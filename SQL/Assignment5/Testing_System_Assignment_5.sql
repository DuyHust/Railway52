-- Create Database

DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE 		TestingSystem;
USE 					TestingSystem;

-- Create Table

DROP TABLE IF exists 	Department;
CREATE TABLE 			Department (
	DepartmentID 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 	VARCHAR(30) NOT NULL 
    );
    
DROP TABLE IF EXISTS 	`Position`;
CREATE TABLE 			`Position` (
	PositionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PositionName 	ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

DROP TABLE IF EXISTS 	`Account`;
CREATE TABLE 			`Account` (
	AccountID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Email 			VARCHAR(30) NOT NULL UNIQUE KEY,
	Username  		VARCHAR(30) NOT NULL UNIQUE KEY,
	Fullname 		VARCHAR(30) NOT NULL,
	DepartmentID 	TINYINT UNSIGNED NOT NULL,
	PositionID 		TINYINT UNSIGNED NOT NULL,
	CreateDate 		DATETIME DEFAULT NOW(), 
	FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

DROP TABLE IF EXISTS 	`Group`;
CREATE TABLE 			`Group`(
	GroupID 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	GroupName 	VARCHAR(30) NOT NULL,
	CreatorID 	TINYINT UNSIGNED NOT NULL,
	CreateDate 	DATETIME DEFAULT NOW(),
	FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS 	`GroupAccount`;
CREATE TABLE 			`GroupAccount` (
	GroupID 	TINYINT UNSIGNED NOT NULL,
	AccountID 	TINYINT UNSIGNED NOT NULL ,
	JoinDate 	DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID)
);

DROP TABLE IF EXISTS 	TypeQuestion;
CREATE TABLE 			TypeQuestion (
	TypeID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName	ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS 	CategoryQuestion;
CREATE TABLE 			CategoryQuestion (
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName	VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS 	Question;
CREATE TABLE 			Question (
	QuestionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content			VARCHAR(150) NOT NULL,
	CategoryID		TINYINT UNSIGNED NOT NULL,
	TypeID			TINYINT UNSIGNED NOT NULL,
	CreatorID		TINYINT UNSIGNED NOT NULL,
	CreateDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS 	Answer;
CREATE TABLE 			Answer (
	AnswerID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content			VARCHAR(150) NOT NULL,
	QuestionID		TINYINT UNSIGNED NOT NULL,
	isCorrect		ENUM('Đúng','Sai') NOT NULL ,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS 	Exam;
CREATE TABLE 			Exam (
	ExamID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Code			TINYINT UNSIGNED NOT NULL ,
    Title			VARCHAR(100) NOT NULL,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		TINYINT UNSIGNED NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate 		DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS 	ExamQuestion;
CREATE TABLE 			ExamQuestion (
	ExamID				TINYINT UNSIGNED NOT NULL,
    QuestionID 			TINYINT UNSIGNED NOT NULL,
	FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    PRIMARY KEY (ExamID,QuestionID)
);

-- Insert Database

 INSERT INTO Department	(DepartmentName)
 VALUES 				('Marketing'),
 						('Sale'),
						('Kỹ thuật');
 INSERT INTO `Position` (PositionName)
 VALUES 				('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
INSERT INTO `Account` (Email, 				Username, 		Fullname, 		DepartmentID,		PositionID) 
VALUES 				('Email1@gmail.com',	'Username1',	'Duy',				3,					3),
					('Email2@gmail.com',	'Username2',	'Daonqviettel',		2,					2),
                    ('Email3@gmail.com',	'Username3',	'CôngAnh',			1,					2),
                    ('Email4@gmail.com',	'Username4',	'NguyenQuoc',		3,					1),
					('Email5@gmail.com',	'Username5',	'Fullname5',		2,					2),
                    ('Email6@gmail.com',	'Username6',	'Khương Duy',		1,					2),
					('Email7@gmail.com',	'Username7',	'Việt Hoà',			2,					2),
                    ('Email8@gmail.com',	'Username8',	'Công minh',		2,					2);
INSERT INTO `Group`	(GroupName,		CreatorID)
VALUES				('Thethao',			3),
					('Nghethuat',		2),
                    ('Sukien',			5),
                    ('Hoctap',			5),
                    ('Nghiencuu',		5);

INSERT INTO GroupAccount (GroupID,		AccountID)
VALUES						(1,				1),
							(1,				2),
							(2,				1),
                            (2,				2),
                            (2,				3),
                            (3,				3),
                            (4,				2);
                            
                            
INSERT INTO TypeQuestion (TypeName)
VALUES					('Essay'),
					('Multiple-Choice' );

INSERT INTO CategoryQuestion (CategoryName)
VALUES							('Java'),
								('.NET'),
								('SQL'),
								('Postman'),
								('Python'),
								('C++');
INSERT INTO	Question	(Content,				CategoryID,			TypeID,			CreatorID)
VALUES					('Câu hỏi về Java', 		1,					1,				2),
						('Câu hỏi về Java', 		1,					2,				2),
						('Câu hỏi về .Net', 		2,					1,				1),
                        ('Câu hỏi về .Net', 		2,					2,				1),
                        ('Câu hỏi về SQL', 			3,					1,				4),
                        ('Câu hỏi về SQL', 			3,					2,				4);
INSERT INTO	Answer		(Content,				QuestionID,			isCorrect)
VALUES					('Trả lời 1', 				1, 				'Đúng'),
						('Trả lời 2', 				1, 				'Đúng'),
                        ('Trả lời 3', 				1, 				'Sai'),
                        ('Trả lời 4', 				1, 				'Sai'),
						('Trả lời 5', 				2, 				'Đúng'),
                        ('Trả lời 6', 				3, 				'Đúng'),
                        ('Trả lời 7', 				5, 				'Sai');
                   
INSERT INTO	Exam		(Code,		Title,		CategoryID,		Duration,		CreatorID)                     
VALUES					(101, 'Kiểm tra Java',		1,				15,				1),
						(101, 'Kiểm tra Java',		1,				30,				1),
                        (102, 'Kiểm tra	.Net',		2,				15,				2),
                        (103, 'Kiểm tra SQL', 		3,				30,				2);

INSERT INTO	ExamQuestion (ExamID, QuestionID) 
VALUES 					(1,			1),
						(1,			2),
                        (2,			1),
                        (2,			3),
                        (2,			4),
                        (3,			2),
                        (4,			2);
-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo