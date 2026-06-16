import {HttpsError, onCall} from "firebase-functions/v2/https";
import {logger} from "firebase-functions";
import {initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";

initializeApp();

export const getMemberProfile = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Authentication is required.");
  }

  const user = await getAuth().getUser(request.auth.uid);

  logger.info("Loaded member profile", {uid: request.auth.uid});

  return {
    uid: user.uid,
    email: user.email,
    displayName: user.displayName,
    emailVerified: user.emailVerified,
  };
});
