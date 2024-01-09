# GymFit

See on https://idrizarmin.github.io/

GymFIT is a fitness management application that includes both an admin app and a user mobile app, both built using the Flutter framework. The goal of GymFIT is to streamline the management of gym activities and enhance the user experience for fitness enthusiasts.

## Features

### Admin App (Flutter)
- **Dashboard:** A centralized view for administrators to monitor and manage various aspects of the gym.
- **Member Management:** Add, edit, and remove member profiles with ease.
- **Reservations Schedule:** Create and manage reservations schedules.
- **Attendance Tracking:** Track attendance for reservations in gym.
- **Notifications:** Send important announcements and updates to members.
- **Reports:** Generate and view detailed reports on gym activities, attendance, and memberships.
- **Trainer Management:** Add, edit, and remove information about gym trainers.

### User Mobile App (Flutter)
- **User Profiles:** Users can create and manage their profiles with personal information.
- **Reservations Schedule:** View available appointments and create reservations with the desired coach.
- **Workout Tracking:** Log and track their workout routines, progress, and achievements.
- **Notifications:** Receive alerts for appointments, personalized workout recommendations, and important updates.
- **Online Membership Payment:** Users can securely make payments for their gym memberships directly through the mobile app.
- **View Trainers:** Users can explore information about gym trainers, including their specialties, qualifications, and schedules.

## Backend (.NET 6)

The backend of GymFIT is implemented using .NET 6. Follow the steps below to set up and run the backend:

   1. Clone the repository
   2. Open command prompt (CMD) and navigate to ...\SeminarskiGymFit\GymFit
   3. Use command "docker-compose up --build" (second run of the command makes required Hangfire tables in database)


## Frontend (Flutter)

The frontend of GymFit is implemented using Flutter. Follow the steps below to set up and run the backend:

   1. Navigate to ...\SeminarskiGymFit\UI with File Explorer
   2.  For Admin app open gymfit_admin in Visual Studio Code:
        - open new terminal and run command "flutter run -d windows"
            - Login Credentials: 
                - email: admin@gmail.com
                - password: test

    3.  For Mobile app open gymfit_mobile in Visual Studio Code:
        - Start the emulator and run the project
            - Login Credentials: 
                - email: user@gmail.com
                - password: test
    
    4. For trainers mobile app open gymfit_trainer in Visual Studio Code:
         - Start the emulator and run the project
            - Login Credentials: 
                - email: trener@gmail.com
                - password: test

    - **Note:** If running the mobile application is not possible, please create a new emulator with API Level 34 and proceed to run the application on it.

    - **Online Payment:** For successful payment of the membership fee, please use the card number 4242 4242 4242 4242 during the testing process.



**Have a great time using GymFIT!**









   