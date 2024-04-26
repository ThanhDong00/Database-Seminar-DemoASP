USE master;
GO

CREATE DATABASE HRDatabase;
GO

USE HRDatabase;
GO

CREATE TABLE Companies (
	id				INT CONSTRAINT PK_Companies PRIMARY KEY IDENTITY,
	CompanyName		VARCHAR(80) NOT NULL,
	CompAddress		VARCHAR(80) NOT NULL,
	CompContactNo	VARCHAR(20) NOT NULL,
	IsActive		BIT			CONSTRAINT DF_IsActive_Companies DEFAULT(1),
	CreateDate		DATETIME NOT NULL DEFAULT getdate()
);

INSERT INTO Companies (CompanyName, CompAddress, CompContactNo) VALUES
('Cong ty TNHH Phat Trien Ben Vung', '123 Duong Nguyen Trai, Quan Thanh Xuan, Ha Noi, Viet Nam', '02412345678'),
('Cong ty Co phan Cong Nghe Moi', '456 Duong Le Duan, Quan 1, Thanh pho Ho Chi Minh, Viet Nam', '02898765432'),
('Cong ty TNHH Dich Vu Toan Cau', '789 Duong Tran Hung Dao, Quan Ninh Kieu, Can Tho, Viet Nam', '029234567890');


SELECT * FROM Companies;
GO

/**************************************************************************************
	Create Stored Procedures for Companies table
*/
----------------------------------------------------------------------------
--	Stored Procedure to return a list of all the companies
CREATE OR ALTER PROCEDURE dbo.usp_GetCompanies
AS
BEGIN
	SELECT	ID
			,CompanyName
			,CompAddress
			,CompContactNo
			,CreateDate
	FROM	dbo.Companies
END;
go

----------------------------------------------------------------------------
--	Stored Procedure to return a single Company based on an ID

CREATE OR ALTER PROCEDURE dbo.usp_GetCompany
	@ID		int
AS
BEGIN
	SELECT	ID
			,CompanyName
			,CompAddress
			,CompContactNo
			,CreateDate
	FROM	dbo.Companies
	WHERE	ID = @ID
END;
go

----------------------------------------------------------------------------
--	Stored Procedure to Insert a single Company

CREATE OR ALTER PROCEDURE dbo.usp_InsCompany
	@CompanyName	varchar(80),
	@CompAddress	varchar(80),
	@CompContactNo	varchar(20)
AS
BEGIN
	INSERT INTO dbo.Companies
			   (CompanyName
			   ,CompAddress
			   ,CompContactNo
			   ,CreateDate)
		 VALUES
			   (@CompanyName
			   ,@CompAddress
			   ,@CompContactNo
			   ,getdate())
END;
go

----------------------------------------------------------------------------
--	Stored Procedure to Update a single Company

CREATE OR ALTER PROCEDURE dbo.usp_UpdCompany
	@ID				int			= null,
	@CompanyName	varchar(80)	= null,
	@CompAddress	varchar(80) = null,
	@CompContactNo	varchar(20) = null
AS
BEGIN
	UPDATE	dbo.Companies
	SET		CompanyName			= ISNULL(@CompanyName	, CompanyName	)
			,CompAddress		= ISNULL(@CompAddress	, CompAddress	)
			,CompContactNo		= ISNULL(@CompContactNo	, CompContactNo	)
	WHERE	ID = @ID
END;
GO
----------------------------------------------------------------------------
--	Stored Procedure to Delete a single Company based on its ID

CREATE OR ALTER PROCEDURE dbo.usp_DelCompany
	@ID		int
AS
BEGIN
	DELETE	FROM dbo.Companies
	WHERE	ID = @ID
END;
GO


