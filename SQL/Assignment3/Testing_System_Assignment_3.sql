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
	AccountID 	TINYINT UNSIGNED NOT NULL,
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
                        
-- QUESTION 1: Thêm ít nhất 10 record vào mỗi table 
-- QUESTION 2: Lấy ra tất cả phòng ban
		SELECT DepartmentID 
        FROM Department;
-- QUESTION 3: Lấy ra id của phòng ban 'Sale' 
		SELECT DepartmentID 
        FROM Department 
        WHERE DepartmentName = 'Sale'; 
-- QUESTION 4: Lấy ra thông tin account có full name dài nhất
		-- Sub Query: Câu lệnh truy vấn con  
        SELECT * 
        FROM `account` 
        WHERE LENGTH(Fullname)= (SELECT MAX(LENGTH(Fullname)) FROM `account`);
		
-- QUESTION 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
		-- Cách 1: Sub query  
        SELECT * 
        FROM ( SELECT * FROM `account` WHERE DepartmentID =3) AS tmp_departmentID3
        WHERE length(Fullname) = (SELECT MAX(length(fullname)) FROM ( SELECT * FROM `account` WHERE DepartmentID =3) AS tmp_departmentID3);
        -- Cách 2: CTE: Tạo ra 1 bảng dữ liệu tạm, bảng dữ liệu này chỉ được dùng trong câu truy vấn hiện tại 
		WITH CTE_AccountDepID3 AS (
        SELECT * 
        FROM `account` 
        WHERE DepartmentID =3
        )
        SELECT * 
        FROM CTE_AccountDepID3 
        WHERE length(Fullname) = (SELECT max(length(Fullname)) FROM CTE_AccountDepID3); 
        
-- QUESTION 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
		SELECT GroupName 
        FROM `Group` 
        WHERE Createdate < '2019-12-20' ;

-- QUESTION 7: Lấy ra ID của question có >=4 câu trả lời
		SELECT a.QuestionID, q.content, COUNT(a.QuestionID)
        FROM answer a 
        INNER JOIN question q ON a.QuestionID = q.QuestionID
        GROUP BY a.QuestionID 
        HAVING COUNT(a.QuestionID) >=4;
        
-- QUESTION 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
		SELECT `Code` 
        FROM Exam 
        WHERE Duration >= 60 
        AND Createdate < '2019-12-20' ; 
-- QUESTION 9: Lấy ra 5 group được tạo gần đây nhất
		SELECT * FROM `Group` LIMIT 5;
-- QUESTION 10: Đếm số nhân viên thuộc department có id = 2
		SELECT COUNT(AccountID) 
        FROM `Account` 
        WHERE DepartmentID = 2; 
-- QUESTION 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
		-- substring_index: Lấy ra 1 chuỗi con từ chuỗi ban đầu
        -- substring_index('chuỗi, ký tự phân chia, vị trí cần lấy) 
		SELECT * FROM `Account` WHERE substring_index(Fullname,' ',-1) LIKE 'D%y' ;
        -- substring_index: Lấy ra 1 chuỗi con từ chuỗi ban đầu
        -- substring_index('chuỗi, ký tự phân chia, vị trí cần lấy) 
        
-- QUESTION 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
		DELETE FROM EXAM WHERE CreateDate < '2019-12-20'; 
-- QUESTION 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
		DELETE FROM Question WHERE Substring_index (Content, ' ' , 2) = 'Câu hỏi' ;
        
-- QUESTION 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
		UPDATE `account` 
        SET 	Fullname = 'Nguyễn Bá Lộc',
				Email 	 = ' loc.nguyenba@vti.com.vn ' 
        WHERE 	AccountID = 5; 
-- QUESTION 15: update account có id = 5 sẽ thuộc group có id = 4
		UPDATE GroupAccount
        SET    AccountID = 5
		WHERE  GroupID = 4; 
      
	
        
        
	
 
                        
                        
                        
                        
                        