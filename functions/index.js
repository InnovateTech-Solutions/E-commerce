/* eslint-disable */
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationOnNameUpdate = functions.firestore
    .document('User/{UserName}')
    .onUpdate(async (change, context) => {          
        const currentDate = new Date();

        // Set the timezone to 'Asia/Amman'
        const options = { timeZone: 'Asia/Amman' };
        const formattedDate = currentDate.getFullYear() + "-" +(currentDate.getMonth()+1) + "-" + (currentDate.getDate()+1) ;
        // const formattedDate = currentDate.toLocaleString('en-US', { ...options, year: 'numeric', month: '2-digit', day: '2-digit' }).split(', ')[0];
        
        // Calculate the start and end times for the next hour
        const nextHourStart = new Date(currentDate);
        nextHourStart.setMinutes(0, 0, 0);
        const formattednextHourStart = nextHourStart.toLocaleString('en-US', { ...options, hour12: false, hour: '2-digit', minute: '2-digit' });

        const nextHourEnd = new Date(nextHourStart);
        nextHourEnd.setHours(nextHourEnd.getHours() + 1);
        const formattednextHourEnd = nextHourEnd.toLocaleString('en-US', { ...options, hour12: false, hour: '2-digit', minute: '2-digit' });

        console.log("formatted date", formattedDate);
        console.log("formatted nextHourStart", formattednextHourStart);
        console.log("formatted nextHourEnd", formattednextHourEnd);


    
    try {
        // Query bookings for the next hour

            const snapshot = await admin.firestore()
            .collection('Bookings')
            .where('date', '==', formattedDate)
            .where('time', '>=', formattednextHourStart)
            .where('time', '<', formattednextHourEnd)
            .get();
            console.log("snapshot: ", snapshot);

        // Prepare an array of promises for each booking
        const notifications = snapshot.docs.map(async (doc) => {
            const bookingData = doc.data();
            const userEmail = bookingData.userEmail;
            console.log("User Email", userEmail);

            // Query users collection to get FCM token based on userEmail
            const userSnapshot = await admin.firestore()
                .collection('User')
                .where('Email', '==', userEmail)
                .limit(1)
                .get();
                
            console.log("userSnapshot: ", userSnapshot);

            // If user exists, return notification object
            if (!userSnapshot.empty) {
                const userData = userSnapshot.docs[0].data();
                const userFCMToken = userData.fcmToken;
                console.log("userFCMToken: ", userFCMToken);

                const payload = {
                    data: {
                        title: 'Upcoming Booking',
                        body: 'You have a booking in the next hour.',
                    }
                };

                // Send notification in parallel
                const response = await admin.messaging().sendToDevice(userFCMToken, payload);
                console.log('Notification sent successfully:', response);
            } else {
                console.log('User with email ${userEmail} not found.');
            }
        });

        // Wait for all notifications to be sent
        await Promise.all(notifications);

        return null; // Return null to indicate success
    } catch (error) {
        console.error('Error:', error);
        throw error; // Re-throw the error to indicate failure
    }
});
