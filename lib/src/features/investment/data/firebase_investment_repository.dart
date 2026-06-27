import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../admin/domain/admin_models.dart' show LandingContent;
import '../domain/investment_models.dart';
import '../domain/investment_repository.dart';

class FirebaseInvestmentRepository implements InvestmentRepository {
  FirebaseInvestmentRepository({
    FirebaseFunctions? functions,
    FirebaseStorage? storage,
    FirebaseAuth? firebaseAuth,
  }) : _functions = functions ?? FirebaseFunctions.instance,
       _storage = storage ?? FirebaseStorage.instance,
       _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<MemberDashboardData> loadMemberDashboard() async {
    final callable = _functions.httpsCallable('getMemberDashboard');
    final result = await callable.call<Object?>();
    return MemberDashboardData.fromJson(
      Map<String, dynamic>.from(result.data! as Map),
    );
  }

  @override
  Future<LandingContent> getLandingContent() async {
    try {
      final callable = _functions.httpsCallable('getLandingContent');
      final result = await callable.call<Object?>();
      return LandingContent.fromJson(
        Map<String, dynamic>.from(result.data! as Map),
      );
    } catch (_) {
      // The landing page is pre-auth marketing; never block it on a backend
      // hiccup or cold start. Fall back to the built-in defaults.
      return LandingContent.defaults();
    }
  }

  @override
  Future<List<InvestmentOpportunity>> listOpportunities({
    String? localeCode,
  }) async {
    final callable = _functions.httpsCallable('listMemberOpportunities');
    final result = await callable.call<Object?>(
      localeCode == null ? null : {'locale': localeCode},
    );
    final data = Map<String, dynamic>.from(result.data! as Map);
    final opportunities = data['opportunities'];
    if (opportunities is! List) return const [];

    return opportunities
        .whereType<Map>()
        .map(
          (item) =>
              InvestmentOpportunity.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList(growable: false);
  }

  @override
  Future<PurchaseOrder> createPurchaseOrder(PurchaseRequest request) async {
    final callable = _functions.httpsCallable('createPurchaseOrder');
    final result = await callable.call<Object?>({
      if (request.opportunityId != null)
        'opportunityId': request.opportunityId,
      'amountUsd': request.amountUsd,
      'paymentAsset': request.paymentAsset,
    });
    return PurchaseOrder.fromJson(
      Map<String, dynamic>.from(result.data! as Map),
    );
  }

  @override
  Future<InvestmentPlanResult> createInvestmentPlan({
    required String assetId,
    required double amountUsd,
    required String durationKey,
  }) async {
    final callable = _functions.httpsCallable('createInvestmentPlan');
    final result = await callable.call<Object?>({
      'assetId': assetId,
      'amountUsd': amountUsd,
      'durationKey': durationKey,
    });
    return InvestmentPlanResult.fromJson(
      Map<String, dynamic>.from(result.data! as Map),
    );
  }

  @override
  Future<PurchaseOrder> submitDepositProof({
    required String orderId,
    required String transactionHash,
    required DepositProofFile proof,
  }) async {
    final proofUrl = await _uploadProof(orderId, proof);
    final callable = _functions.httpsCallable('submitDepositProof');
    final result = await callable.call<Object?>({
      'orderId': orderId,
      'transactionHash': transactionHash.trim(),
      'proofUrl': proofUrl,
    });
    return PurchaseOrder.fromJson(
      Map<String, dynamic>.from(result.data! as Map),
    );
  }

  @override
  Future<void> createWithdrawalRequest({
    required double amountUsd,
    required String destinationAddress,
    required String assetSymbol,
    DepositProofFile? qrCode,
  }) async {
    var destinationQrCodeUrl = '';
    if (qrCode != null) {
      final uid = _firebaseAuth.currentUser?.uid;
      if (uid == null) {
        throw StateError('Cannot upload a withdrawal QR without a signed-in user.');
      }
      destinationQrCodeUrl = await _uploadImage('withdrawal-qr/$uid', qrCode);
    }
    final callable = _functions.httpsCallable('createWithdrawalRequest');
    await callable.call<Object?>({
      'amountUsd': amountUsd,
      'destinationAddress': destinationAddress.trim(),
      'assetSymbol': assetSymbol,
      if (destinationQrCodeUrl.isNotEmpty)
        'destinationQrCodeUrl': destinationQrCodeUrl,
    });
  }

  @override
  Future<List<MemberNotification>> listNotifications() async {
    final callable = _functions.httpsCallable('listMemberNotifications');
    final result = await callable.call<Object?>();
    final data = Map<String, dynamic>.from(result.data! as Map);
    final notifications = data['notifications'];
    if (notifications is! List) return const [];

    return notifications
        .whereType<Map>()
        .map(
          (item) =>
              MemberNotification.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList(growable: false);
  }

  @override
  Future<void> markNotificationsRead() async {
    final callable = _functions.httpsCallable('markMemberNotificationsRead');
    await callable.call<Object?>();
  }

  Future<String> _uploadProof(String orderId, DepositProofFile proof) {
    return _uploadImage('payment-proofs/$orderId', proof);
  }

  /// Uploads [file] under [pathPrefix] with a timestamped, sanitized name and
  /// returns its download URL. Shared by deposit proofs and withdrawal QR codes.
  Future<String> _uploadImage(String pathPrefix, DepositProofFile file) async {
    final safeName = file.name.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '-');
    final reference = _storage.ref(
      '$pathPrefix/${DateTime.now().millisecondsSinceEpoch}-$safeName',
    );
    await reference.putData(
      Uint8List.fromList(file.bytes),
      SettableMetadata(
        contentType: file.contentType,
        customMetadata: {'originalName': file.name},
      ),
    );
    return reference.getDownloadURL();
  }
}
