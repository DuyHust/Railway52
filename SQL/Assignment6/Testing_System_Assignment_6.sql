-- Store PROCEDURE
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
                        ('Câu hỏi về .Net', 		2,					1,				1),
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
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó

		DROP PROCEDURE IF EXISTS sp_importdepartment;
		DELIMITER $$
		CREATE PROCEDURE sp_importdepartment(IN Namedep VARCHAR(30))
        BEGIN 
		
            SELECT * FROM `account` a
            INNER JOIN department d ON a.DepartmentID = d.DepartmentID 
            WHERE d.DepartmentName = Namedep;
            
        END $$
		DELIMITER ;
        
-- Question 2: Tạo store để in ra số lượng account trong mỗi group
		
        DROP PROCEDURE IF EXISTS sp_accountgroup;
		DELIMITER $$
		CREATE PROCEDURE sp_accountgroup()
        BEGIN 
		
            SELECT GroupID, COUNT(1) SL FROM groupaccount
            GROUP BY GroupID;
            
        END $$
		DELIMITER ;
        CALL sp_accountgroup();
-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
		DROP PROCEDURE IF EXISTS sp_typequestion;
		DELIMITER $$
		CREATE PROCEDURE sp_typequestion()
        BEGIN 
			
            SELECT a.TypeID, a.CreateDate, COUNT(1) SL FROM question a
            INNER JOIN TypeQuestion d ON a.TypeID = d.TypeID
            GROUP BY a.TypeID
            HAVING month(a.CreateDate) = month(now()) AND year(a.CreateDate) = year(now());
            
        END $$
		DELIMITER ;
        CALL sp_typequestion();
        
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
	
		DROP PROCEDURE IF EXISTS sp_getIDtypeQuestion;
		DELIMITER $$
		CREATE PROCEDURE sp_getIDtypeQuestion()
        BEGIN 
			WITH maxquestion AS (
            SELECT COUNT(1) SL FROM question
            GROUP BY TypeID)
            
            SELECT TypeID FROM question 
            GROUP BY TypeID 
            HAVING COUNT(1) = (SELECT MAX(SL) FROM maxquestion);
            
        END $$
		DELIMITER ;
        CALL sp_getIDtypeQuestion();
	
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
		DROP PROCEDURE IF EXISTS sp_getIDtypeQuestion;
		DELIMITER $$
		CREATE PROCEDURE sp_getIDtypeQuestion()
        BEGIN 
			WITH maxquestion AS (
            SELECT COUNT(1) SL FROM question
            GROUP BY TypeID)
            
            SELECT a.TypeID,d.TypeName FROM question a
            INNER JOIN TypeQuestion d ON a.TypeID = d.TypeID
            GROUP BY a.TypeID 
            HAVING COUNT(1) = (SELECT MAX(SL) FROM maxquestion);
            
        END $$
		DELIMITER ;
        CALL sp_getIDtypeQuestion();
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay