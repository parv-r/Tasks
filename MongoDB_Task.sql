--Create a database named MongoDB_Task
use MongoDB_Task

--Create a collection named students and insert numerous records into it
db.students.insertMany(
    [
        {
            Name: "Abhishek Gupta",
            Designation: "Intern",
            Email: "abhishek.g@innovaccer.com",
            EmpId: 'IN522'
        },
        {
            Name: "Astitva Gupta",
            Designation: "Intern",
            Email: "astitva.gupta@innovaccer.com",
            EmpId: 'IN525'
        },
        {
            Name: "Harshita Sachdeva",
            Designation: "Intern",
            Email: "harshita.sachdeva@innovaccer.com",
            EmpId: 'IN521'
        },
        {
            Name: "Parv Rastogi",
            Designation: "Intern",
            Email: "parv.rastogi@innovaccer.com",
            EmpId: 'IN527'
        },
        {
            Name: "Shreya Asthana",
            Designation: "Intern",
            Email: "Shreya.asthana@innovaccer.com",
            EmpId: 'IN530'
        }
    ]
);

--Fetch/Query Document from students' collection
db.students.find();

--Create a collection named courses and insert multiple rows into it
db.courses.insertMany(
    [
        {
            EmpId: 'IN522',
            Course_Name: "Linux",
            CourseId: 'LX11',
            Sessions: 3,
            Assignments: true
        },
        {
            EmpId: 'IN525',
            Course_Name: "GIT",
            CourseId: 'GT22',
            Sessions: 2,
            Assignments: true
        },
        {
            EmpId: 'IN521',
            Course_Name: "PostgreSQL",
            CourseId: 'PG33',
            Sessions: 2,
            Assignments: true
        },
        {
            EmpId: 'IN527',
            Course_Name: "MongoDB",
            CourseId: 'MG44',
            Sessions: 1,
            Assignments: true
        },
        {
            EmpId: 'IN530',
            Course_Name: "Python",
            CourseId: 'PT55',
            Sessions: 0,
            Assignments: false
        }
    ]
);

--Fetch/Query Document from courses' collection
db.courses.find();

--Update Document in courses' collection
db.courses.updateMany(
    {Sessions:{$ge:3}},
    {$set:{Sessions: 1}}
);