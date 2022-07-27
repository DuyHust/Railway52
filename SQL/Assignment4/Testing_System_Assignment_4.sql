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
        --   Exercise1: JOIN               
        -- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 
        
			SELECT a.Email, a.Username, a.Fullname, q.DepartmentName 
            FROM `account` a
            INNER JOIN Department q ON a.DepartmentID = q.DepartmentID;
            
		-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
        
			SELECT * FROM `account` WHERE CreateDate > '2010-12-20';
            
		-- Question 3: Viết lệnh để lấy ra tất cả các developer
        
			SELECT a.Email, a.UserName, a.Fullname, q.PositionName FROM `account` a
            INNER JOIN Position q ON a.PositionID = q.PositionID
            WHERE a.PositionID = 1; 
            
		-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
        
			Select a.DepartmentID, d.DepartmentName, COUNT(1) AS SL From `account` a
			INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
			GROUP BY a.DepartmentID
			HAVING COUNT(1) >3; 
        
        -- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

			WITH CTE_Count AS (
			SELECT COUNT(1) AS SL FROM examquestion
			GROUP BY QuestionID
			)
			SELECT eq.QuestionID, q.Content, COUNT(1) FROM examquestion eq
			INNER JOIN question q ON q.QuestionID = eq.QuestionID 
			GROUP BY eq.QuestionID
			HAVING COUNT(1) = (SELECT MAX(SL) FROM CTE_Count);
        
        -- Question 6: Thống kê mỗi category Question được sử dụng trong bao nhiêu Question
        
			SELECT a.CategoryID, d.CategoryName, COUNT(1) SL FROM Question a
            INNER JOIN CategoryQuestion d ON a.CategoryID = d.CategoryID
            GROUP BY a.CategoryID; 
            
		-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
        
			Select a.QuestionID, d.Content, COUNT(1) SL FROM Examquestion a
            INNER JOIN Question d ON a.QuestionID = d.QuestionID
            GROUP BY QuestionID;
            
		-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
        
            WITH CTE_Count AS( 
            SELECT COUNT(1) SL FROM Answer GROUP BY QuestionID
            )
            SELECT a.QuestionID,d.Content, COUNT(1) SL FROM Answer a
            INNER JOIN Question d ON a.QuestionID = d.QuestionID 
            GROUP BY a.QuestionID
            HAVING COUNT(1) = (SELECT MAX(SL) FROM CTE_Count)  ;
            
		-- Question 9: Thống kê số lượng account trong mỗi group
			
            SELECT a.GroupID, d.GroupName, COUNT(1) SL FROM GroupAccount a
            INNER JOIN `Group` d ON a.GroupID = d.GroupID
            GROUP BY a.GroupID;
            
		-- Question 10: Tìm chức vụ có ít người nhất
			
        -- Cách 1: Sub query
        
			SELECT a.PositionID,p.PositionName, COUNT(a.PositionID) FROM `account` a
			INNER JOIN Position p ON p.PositionID = a.PositionID
			GROUP BY a.PositionID
			HAVING COUNT(1) = (SELECT min(SL) FROM (SELECT COUNT(a1.PositionID) AS SL FROM `account` a1 GROUP BY a1.PositionID) AS tmp_1); 
        
        -- Cách 2: CTE 
			WITH CTE_Count AS(
            SELECT COUNT(1) AS SL FROM `account`
            GROUP BY PositionID
            )
			SELECT a.PositionID, d.PositionName, COUNT(1) SL FROM `account` a
            INNER JOIN Position d ON a.PositionID = d.PositionID
            GROUP BY PositionID
            HAVING COUNT(1) = (SELECT MIN(SL) FROM CTE_Count) ;
        
        -- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
			
        
		-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
        
			SELECT a.QuestionID, a.Content, d.CategoryName, e.Username, f.Content FROM question a
			INNER JOIN CategoryQuestion d ON a.CategoryID = d.CategoryID
			INNER JOIN `Account` e ON e.AccountID = a.CreatorID 
			INNER JOIN Answer f ON f.QuestionID = a.QuestionID ;
        
        -- Question13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
        
			SELECT a.TypeID, d.TypeName, COUNT(1) SL FROM question a
			INNER JOIN TypeQuestion d ON a.TypeID = d.TypeID
			GROUP BY TypeID;
        
        -- Question 15: Lấy ra group không có account nào
        
        -- Question 16: Lấy ra question không có answer nào 
        
        
        
	
 
                         
                        
                        
                        
                        