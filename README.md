# RaceDay_Management_System.
RaceDay_Management_System - PROG6212- PART 1- POE

Project Description

The RaceDay Management System is a database-driven system designed to manage race events, participants, organisers, event categories, enrolments, and race results. The system allows organisers to create and manage race events while participants can register for events and view their enrolment and race results.

The project uses SQL Server as the database and provides a structured database design based on the requirements of the RaceDay Management System.

User Roles
Organisers

Organisers are responsible for managing race events. They can:

Create and manage race events.
Manage race categories.
View and manage participant enrolments.
Record and manage race results.
Update event-related information.
Participants

Participants are users who take part in race events. They can:

Register for an account.
View available race events.
Enrol in events.
View their event enrolments.
View their race results.
Manage their profile information.

How to Open and Run the SQL Script in SSMS
Open SQL Server Management Studio (SSMS).
Connect to your SQL Server instance.
Open the SQL script file from the project.
Click Execute or press F5.
The script will create the required database and tables.
The script will also insert the required sample/initial data.
After execution, refresh Databases in Object Explorer to view the newly created database.
Expand the database and check Tables to confirm that the tables were created successfully.

Important: Make sure you are connected to the correct SQL Server instance before executing the script.

What the GitHub Action Checks

The GitHub Action is used to automatically verify that the project can be built successfully when changes are pushed to the repository.

The workflow checks that:

The repository can restore the required .NET dependencies.
The project/solution builds successfully.
There are no build errors that would prevent the application from compiling.
The correct .NET SDK is available for the project.
The code pushed to GitHub passes the configured CI build process.

<img width="1332" height="610" alt="image" src="https://github.com/user-attachments/assets/7642c285-a098-449a-846e-994434c642d4" />
