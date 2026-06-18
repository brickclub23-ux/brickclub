// Firebase Cloud Messaging service worker for the BrickClub web app.
// The firebase_messaging Flutter plugin looks for this file at the web root and
// registers it automatically so background/closed-tab push notifications work.
importScripts(
  "https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js",
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js",
);

// Keep these values in sync with DefaultFirebaseOptions.web in
// lib/src/core/firebase/default_firebase_options.dart.
firebase.initializeApp({
  apiKey: "AIzaSyA4uZVS3lgobVKZXBtNFEz_gsKDfsuusOo",
  appId: "1:336837478378:web:35ad116db920568c01d493",
  messagingSenderId: "336837478378",
  projectId: "brickclub",
  authDomain: "brickclub.firebaseapp.com",
  storageBucket: "brickclub.firebasestorage.app",
  measurementId: "G-Z6E45H9302",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  const notification = payload.notification || {};
  self.registration.showNotification(notification.title || "BrickClub", {
    body: notification.body || "",
    icon: "/icons/Icon-192.png",
  });
});
