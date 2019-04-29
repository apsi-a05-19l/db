USE apsi;
INSERT INTO RoleInClub
VALUES
('recruit'),
('member'),
('honorary_member'),
('management'),
('former_member'),
('partner'),
('undefined');

INSERT INTO ActivityTag (name)
VALUES
('Zawody'),
('Szkolenie'),
('Targi'),
('Pokazy')
;

INSERT INTO Person (
	Person.first_name,
	Person.last_name,
	Person.phone_number,
	Person.email,
	Person.date_from,
	Person.RoleInClub_name
)
VALUES
('Jan','Kowalski','123123123','kowalski@gmail.com','2018-08-14', (SELECT RoleInClub.name FROM RoleInClub WHERE name='member')),
('Marek','Kowalewski','312312312','Kowalewski@gmail.com','2018-08-14', (SELECT RoleInClub.name FROM RoleInClub WHERE name='management')),
('Jurek','Nowak','123123123','Nowak@gmail.com','2018-08-14', (SELECT RoleInClub.name FROM RoleInClub WHERE name='recruit')),
('Tomek','Karolak','123123123','Karolak@gmail.com','2018-08-14', (SELECT RoleInClub.name FROM RoleInClub WHERE name='member')),
('Paweł','Janas','123123123','Janas@gmail.com','2018-08-14', (SELECT RoleInClub.name FROM RoleInClub WHERE name='management'))
;

INSERT INTO Activity (
	Activity.date,
    Activity.Person_idPerson,
    Activity.ActivityTag_name,
    Activity.points
    )
values
('2019-03-20', 1, (SELECT name FROM ActivityTag WHERE name='Zawody'), 10),    
('2019-03-21', 2, (SELECT name FROM ActivityTag WHERE name='Szkolenie'), 8),    
('2019-03-22', 4, (SELECT name FROM ActivityTag WHERE name='Zawody'), 3),    
('2019-03-23', 3, (SELECT name FROM ActivityTag WHERE name='Zawody'), 6)
;    

INSERT INTO User (
	User.login,
    User.password,
    User.Person_idPerson
)
VALUES 
('member1', 'pass1', '1'),
('member2', 'pass2', '2'),
('member4', 'pass4', '4'),
('member5', 'pass5', '5')
;

INSERT INTO PermissionInSystem (
	PermissionInSystem.Permission
)
VALUES
('admin'),
('standard'),
('gość')
;

INSERT INTO Persons_Permissions (
	Persons_Permissions.User_Person_idPerson,
	Persons_Permissions.PermissionInSystem_Permission
)
VALUES 
('1', (SELECT PermissionInSystem.Permission FROM PermissionInSystem WHERE PermissionInSystem.Permission = 'standard')),
('2', (SELECT Permission FROM PermissionInSystem WHERE Permission = 'admin')),
('4', (SELECT Permission FROM PermissionInSystem WHERE Permission = 'standard')),
('5', (SELECT Permission FROM PermissionInSystem WHERE Permission = 'admin'))
;

INSERT INTO Project (
	Project.date_from,
    Project.name,
    Project.project_leader
)
VALUES
('2019-03-20', 'Łazik', 2),
('2019-02-20', 'Robot', 5),
('2019-02-20', 'Robot 2', 5);

INSERT INTO Persons_Projects (
	Persons_Projects.date_from,
    Persons_Projects.Person_idPerson,
    Persons_Projects.Project_idProject
)
VALUES
('2019-02-20', 1, 1),
('2019-02-20', 2, 1),
('2019-02-20', 4, 2),
('2019-02-20', 5, 2);

INSERT INTO Report (
	Report.date,
    Report.content,
    Report.Project_idProject
)
VALUES
('2019-02-20', 'Raport pierwszy - content', 1),
('2019-03-20', 'Raport drugi - content', 1),
('2019-04-20', 'Raport trzeci - content', 1),
('2019-02-20', 'Raport pierwszy - content', 2),
('2019-03-20', 'Raport drugi - content', 2),
('2019-04-20', 'Raport trzeci - content', 2),
('2019-02-20', 'Raport pierwszy - content', 3),
('2019-03-20', 'Raport drugi - content', 3),
('2019-04-20', 'Raport trzeci - content', 3);

INSERT INTO Topic (Topic.name)
VALUES 
('Elektronika'),
('Programowanie');

INSERT INTO PostTag (PostTag.name) 
values 
('Git'),
('Arduino'),
('Raspberry Pi');

INSERT INTO Post (
	Post.title,
    Post.Topic_name,
    Post.author
)
VALUES
('How to restore a deleted branch', (SELECT Topic.name FROM Topic WHERE Topic.name = 'Programowanie'), 1),
('How to restore a deleted branch', (SELECT Topic.name FROM Topic WHERE Topic.name = 'Programowanie'), 2);

INSERT INTO PostTags_Posts (
	PostTags_Posts.Post_id,
    PostTags_Posts.PostTag_name
)
VALUES 
(1, (SELECT PostTag.name FROM PostTag WHERE PostTag.name = 'Git')),
(2, (SELECT PostTag.name FROM PostTag WHERE PostTag.name = 'Git'));

INSERT INTO Part (
	Part.header,
    Part.contents,
    Part.Post_id
)
VALUES 
('Problem','You accidentally deleted a branch in your Git repository.',1),
('Solution','Make sure to perform all of this locally, and confirm your repo is in the state you desire before pushing to Bitbucket Cloud.',1),
('Problem','When adding an SSH public key to Bitbucket Cloud, the following error appears: Invalid SSH Key',2);

INSERT INTO Link (
	Link.source,
    Link.order_number,
    Link.Part_id
)
VALUES 
('https://confluence.atlassian.com/bbkb/how-to-restore-a-deleted-branch-765757540.html',1,1),
('https://confluence.atlassian.com/bbkb/how-to-restore-a-deleted-branch-765757540.html',2,1),
('https://confluence.atlassian.com/bbkb/invalid-ssh-key-610763481.html',1,2);




