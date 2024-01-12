importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDOyDK9Pm49VTkT7-1-DACD-M84FZaiHhU",
    authDomain: "flutter-web-83673.firebaseapp.com",
    projectId: "flutter-web-83673",
    storageBucket: "flutter-web-83673.appspot.com",
    messagingSenderId: "493427708399",
    appId: "1:493427708399:web:b9d4abd257d81fa639e61a"
  });
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});