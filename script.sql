USE [master]
GO
/****** Object:  Database [WebTuyenDung]    Script Date: 02/12/2015 9:48:35 AM ******/
CREATE DATABASE [WebTuyenDung]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebTuyenDung', FILENAME = N'E:\DOCUMENTS\School\ASP.NETWorkSpaces\ProjectII\Database\WebTuyenDung.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WebTuyenDung_log', FILENAME = N'E:\DOCUMENTS\School\ASP.NETWorkSpaces\ProjectII\Database\WebTuyenDung_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WebTuyenDung] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebTuyenDung].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebTuyenDung] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebTuyenDung] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebTuyenDung] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebTuyenDung] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebTuyenDung] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebTuyenDung] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [WebTuyenDung] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WebTuyenDung] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebTuyenDung] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebTuyenDung] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebTuyenDung] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebTuyenDung] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebTuyenDung] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebTuyenDung] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebTuyenDung] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebTuyenDung] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebTuyenDung] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebTuyenDung] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebTuyenDung] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebTuyenDung] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebTuyenDung] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebTuyenDung] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebTuyenDung] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebTuyenDung] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WebTuyenDung] SET  MULTI_USER 
GO
ALTER DATABASE [WebTuyenDung] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebTuyenDung] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebTuyenDung] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebTuyenDung] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WebTuyenDung]
GO
/****** Object:  StoredProcedure [dbo].[AddAJobInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAJobInfo] 
	-- Add the parameters for the stored procedure here
@JobTitle nvarchar(100)
,@CertificateID int
,@JobSalaryLevelID int
,@ProvinceID int
,@JobIndutriesID int
,@ContentDetail nvarchar(Max)
,@Description nvarchar(Max)
,@ExpiredDate date
,@JobPositionID int
,@ExperienceLevelID int
,@WorkTypeID int
,@RecruiterID int
,@NumsApplicant int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 BEGIN TRY
            BEGIN TRANSACTION
          
            INSERT INTO [Jobs]
			(
			FullTitle,
			CertificateID,
			SalaryLevelID,
			ProvinceID,
			JobIndustryID,
			ContentDetail,
			Description,
			ExpiredDate,
			RewriteUrl,
			JobPositionID,
			ExperienceLevelID,
			WorkTypeID,
			RecruitorID,
			NumsApplicant,
			STATUS,
			IS_HOT
			)
			VALUES(
			@JobTitle 
			,@CertificateID 
			,@JobSalaryLevelID
			,@ProvinceID 
			,@JobIndutriesID
			,@ContentDetail 
			,@Description 
			,@ExpiredDate
			,'JobDetail.aspx'
			,@JobPositionID
			,@ExperienceLevelID
			,@WorkTypeID 
			,@RecruiterID
			,@NumsApplicant
			,1
			,0
			)
			DECLARE @Identity INT;
			SET @Identity = Scope_Identity();
				SELECT @Identity
             COMMIT;
			END TRY
			BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
			END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[AddAnAdminQuickly]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAnAdminQuickly]
	@Email nvarchar(50),
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
	@DateOfBirth date,
	@Phone nvarchar(20),
	@IsAdmin bit
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  BEGIN TRY
            BEGIN TRANSACTION
          
            INSERT INTO [User]
				(Email
				,FirstName
				,LastName	
				,DateOfBirth	
				,SexID				
				,PhoneNumber
				,DistrictID	
				,RaceID
				,JobIndustryID
				,IsAdmin
				,PhotoPath
				)				
			VALUES (@Email,
					@FirstName ,
					@LastName,
					@DateOfBirth ,
					1,
					@Phone,					
					1,
					1,
					2,
					@IsAdmin,
					'/Images/no_image_available.png'					
					)
				SELECT @@IDENTITY
             COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
	 
END

GO
/****** Object:  StoredProcedure [dbo].[AddAnUserQuickly]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAnUserQuickly]
	@Email nvarchar(50),
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
	@DateOfBirth date,
	@SexID int,
	@IsAdmin bit
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  BEGIN TRY
            BEGIN TRANSACTION
          
            INSERT INTO [User]
				(Email
				,FirstName
				,LastName	
				,DateOfBirth	
				,SexID				
				
				,DistrictID	
				,RaceID
				,JobIndustryID
				,IsAdmin
				,PhotoPath
				)				
			VALUES (@Email,
					@FirstName ,
					@LastName,
					@DateOfBirth ,
					@SexID ,
										
					1,
					1,
					2,
					@IsAdmin,
					'/Images/no_image_available.png'					
					)
				SELECT @@IDENTITY
             COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
	 
END

GO
/****** Object:  StoredProcedure [dbo].[AddARecruitorQuickly]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddARecruitorQuickly]
	-- Add the parameters for the stored procedure here
	@Email nvarchar(50),	
	@RecruitorName nvarchar(50),
	@CompanyName nvarchar(100),
	@Address nvarchar(200),
	@PhoneToCallForJob nvarchar(20),
	@CompanySizeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY 
		BEGIN TRANSACTION 
		INSERT INTO [Recruitor]
		(EmailLogin,
		RecruitorName,
		CompanyFullName,
		Address,
		CompanySizeID,
		PhoneToCallForJob,
		PhotoPath		
		)
		VALUES
		(@Email,
		@RecruitorName,
		@CompanyName,
		@Address,
		@CompanySizeID,
		@PhoneToCallForJob,
		'/Images/no_image_available.png'
		)
					SELECT @@IDENTITY
             COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[AddARegistration]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddARegistration] 
	-- Add the parameters for the stored procedure here
	@EmailLogin nvarchar(50),
	@PassWord nvarchar(50),
	@UserID int,
	@Captcha nvarchar(50),
	@RegistrationDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  BEGIN TRY
            BEGIN TRANSACTION
          
            INSERT INTO Registration
				(EmailLogin,
				PassWordLogin,
				UserID,
				RegistrationDate,
				TypeUser,
				User_Valid_Email_Code,
				IS_ACTIVATED,
				STATUS
				)				
			VALUES (@EmailLogin,
					@PassWord,
					@UserID,
					@RegistrationDate,
					1,
					@Captcha,
					0,
					1)
				SELECT @@IDENTITY
             COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[AddARegistrationAdmin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddARegistrationAdmin] 
	-- Add the parameters for the stored procedure here
	@EmailLogin nvarchar(50),
	@PassWord nvarchar(50),
	@UserID int,
	@Captcha nvarchar(50),
	@RegistrationDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  BEGIN TRY
            BEGIN TRANSACTION
          
            INSERT INTO Registration
				(EmailLogin,
				PassWordLogin,
				UserID,
				RegistrationDate,
				TypeUser,
				User_Valid_Email_Code,
				IS_ACTIVATED,
				STATUS
				)				
			VALUES (@EmailLogin,
					@PassWord,
					@UserID,
					@RegistrationDate,
					1,
					@Captcha,
					0,
					1)
				SELECT @@IDENTITY
             COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[AddARegistrationAsRecruitor]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddARegistrationAsRecruitor] 
	@EmailLogin nvarchar(50),
	@PassWord nvarchar(50),
	@RecruitorID int,
	@RandomCode nvarchar(50),
	@RegistrationDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY 
		BEGIN TRANSACTION
			INSERT INTO RegistrationAsRecruitor
			(EmailLoginAsRecruitor,
			Password,
			RecruitorID,
			RegistrationDateTime,
			User_Valid_Email_Code,
			TypeUser,
			IS_ACTIVATED,
			STATUS
			)
			VALUES
			(@EmailLogin,
			@PassWord,
			@RecruitorID,
			@RegistrationDate,
			@RandomCode,
			2,
			0,
			1
			)
			SELECT @@IDENTITY
			COMMIT;
			END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[AddAResumeInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAResumeInfo]
	-- Add the parameters for the stored procedure here
	        @JobPositionId int,
            @JobIndutriesId int,
            @ProvinceID int,
            @JobSalaryLevelId int,
            @WorkTypeId int,
           @ExperienceLevelId int,
           @ResumeName nvarchar(50),
           @ContactMail nvarchar(50),
           @Achievement nvarchar(max),
           @UserId int,
           @SkillID int, 
           @CareerGoal nvarchar(500),
           @WorkExperience nvarchar(500),
           @Literacy nvarchar(500),
           @Skill nvarchar(500),
           @Reference nvarchar(500) ,        
           @CertificateId int,
		   @FileAttach NVARCHAR(200)
		   
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 BEGIN TRY
            BEGIN TRANSACTION
			
INSERT INTO [dbo].[ResumeDetails]
           ([JobPositionID]
           ,[JobIndustryID]
           ,[ProvinceID]
           ,[SalaryLevelID]
           ,[WorkTypeID]
           ,[ExperienceLevelID]
           ,[ResumeName]
           ,[ContactEmail]
           ,[ACHIEVEMENTS]
           ,[UserID]
           ,[SkillID]
           ,[CAREER_GOALS]
           ,[WORK_EXPERIENCE]
           ,[LITERACY]
           ,[SKILLS]
           ,[REFERENCE]          
           ,[CertificateID]
		   ,[ATTACHMENT]
		   ,[STATUS]
		   ,Active)
		   
     VALUES
           (@JobPositionId ,
            @JobIndutriesId,
            @ProvinceID ,
            @JobSalaryLevelId,
            @WorkTypeId ,
           @ExperienceLevelId ,
           @ResumeName ,
           @ContactMail ,
           @Achievement ,
           @UserId ,
           @SkillID , 
           @CareerGoal ,
           @WorkExperience ,
           @Literacy ,
           @Skill ,
           @Reference  ,        
           @CertificateId ,
		   @FileAttach,
		   1,
		   0)
   	SELECT @@IDENTITY
             COMMIT;
			END TRY
			BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
			END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[BlockAnAccount]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[BlockAnAccount]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].Registration
	set STATUS=0
    WHERE UserID=@UserID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[BlockAnRecrutorAccount]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[BlockAnRecrutorAccount]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].RegistrationAsRecruitor
	set STATUS=0
    WHERE RecruitorID=@UserID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[ChangePassWord]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangePassWord] 
	-- Add the parameters for the stored procedure here
	@EmailLogin nvarchar(50),
	@PassWord nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRY
	UPDATE [Registration]
	SET PassWordLogin=@PassWord
	WHERE EmailLogin=@EmailLogin
	SELECT 1
	END TRY
	BEGIN CATCH
	SELECT 0
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[CheckExistLoginName]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckExistLoginName]
@EmailLogin nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(
	SELECT *
	FROM Registration 
	WHERE EmailLogin=@EmailLogin)
	SELECT 1
	ELSE SELECT 0 
END

GO
/****** Object:  StoredProcedure [dbo].[CheckExistRecuitor]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckExistRecuitor] 
	@EmailLoginAsRecruitor int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS(
	SELECT *
	FROM RegistrationAsRecruitor 
	WHERE EmailLoginAsRecruitor=@EmailLoginAsRecruitor)
	SELECT 1
	ELSE SELECT 0 
END

GO
/****** Object:  StoredProcedure [dbo].[CheckLogin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckLogin]
	-- Add the parameters for the stored procedure here
	@EmailLogin nvarchar(50),
	@Password nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS(
	SELECT *
	FROM [Registration]
	WHERE EmailLogin=@EmailLogin
	AND PassWordLogin=@Password
	AND IS_ACTIVATED=1
	AND STATUS=1) 
	SELECT TypeUser, [UserID] FROM [Registration] WHERE EmailLogin=@EmailLogin AND PassWordLogin=@Password
	IF EXISTS(
	SELECT *
	FROM RegistrationAsRecruitor
	WHERE EmailLoginAsRecruitor=@EmailLogin
	AND Password=@Password
	AND IS_ACTIVATED=1
	AND STATUS=1) 
	SELECT TypeUser ,RecruitorID FROM RegistrationAsRecruitor WHERE EmailLoginAsRecruitor=@EmailLogin AND Password=@Password
	ELSE SELECT 0
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteAJobByRecuiter]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAJobByRecuiter]
@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	DELETE FROM [dbo].Jobs
      WHERE JobID=@JobID
	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteAResumeByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAResumeByUser] 
	@ResumeID int,
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].[ResumeDetails]
	Set STATUS=0
      WHERE ResumeID=@ResumeID
	  AND UserID=@UserID	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteJobsByAdmin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteJobsByAdmin]
@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].Jobs
	set STATUS=0
    WHERE JobID=@JobID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[deletesAJobApplied]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deletesAJobApplied] 
	-- Add the parameters for the stored procedure here
	@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].[JobApplied] set Status=0
    WHERE JobID=@JobID
	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
	END

GO
/****** Object:  StoredProcedure [dbo].[deletesJobSaved]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deletesJobSaved] 
@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
	BEGIN TRANSACTION
    Update [dbo].[JobsSaved]
	set Status=0
    WHERE JobID=@JobID
	 
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[EditCompanyInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditCompanyInfo]
	-- Add the parameters for the stored procedure here
	@RecruitorID int,
	@CompanyFullName nvarchar(100),
	@CompanyShortName nvarchar(50),
	@CompanySizeId int,
	@Address nvarchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			Update Recruitor
			Set
			CompanyFullName=@CompanyFullName,
			CompanyShortName=@CompanyShortName,
			CompanySizeID=@CompanySizeId,
			Address=@Address
			WHERE RecruitorID=@RecruitorID
					select 1
			COMMIT;
	END TRY
	BEGIN CATCH
			       IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[EditContactInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditContactInfo] 
	-- Add the parameters for the stored procedure here
	@RecruitorID int,
	@RecruitorName nvarchar(50),
	@PhoneToCallForJob nvarchar(50),
	@EmailToSendResume nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		BEGIN TRANSACTION
			Update Recruitor
			Set
			RecruitorName=@RecruitorName,
			PhoneToCallForJob=@PhoneToCallForJob,
			EmailToSendResume=@EmailToSendResume
			WHERE RecruitorID=@RecruitorID
					select 1
			COMMIT;
	END TRY
	BEGIN CATCH
			       IF ( @@ERROR <> 0 ) 
                 ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[EditUserInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditUserInfo]
-- Add the parameters for the stored procedure here
	@UserID int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@DateOfBirth DateTime,
	@SexID int,
	@PhoneNumber nvarchar(20),
	@JobIndustryID int,
	@DistrictID int,
	@RaceID int,
	@MaximOfLife nvarchar(500)	,
	@ThumImg nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRY
		BEGIN TRANSACTION
			Update [User]
			Set 
			     FirstName = @FirstName
				,LastName=@LastName	
				,DateOfBirth = @DateOfBirth
				,SexID = @SexID
				,PhoneNumber = @PhoneNumber
				,JobIndustryID = @JobIndustryID
				,DistrictID = @DistrictID
				,RaceID =	@RaceID
				,MaximOfLife = @MaximOfLife
				,PhotoPath=@ThumImg
			WHERE UserID=@UserID
			select 1
			COMMIT;
	END TRY
	BEGIN CATCH
			       IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_ads_jobs]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ads_jobs] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRANSACTION

			SELECT j.ExpiredDate,j.FullTitle,j.RewriteUrl,p.ProvinceName,r.RecruitorID,r.CompanyFullName,r.Address,j.JobID
			FROM Jobs j,Recruitor r, Province p
			WHERE j.RecruitorID=r.RecruitorID
			AND j.ProvinceID=p.ProvinceID
			AND j.IS_HOT=1
			AND j.STATUS=1
			AND j.ExpiredDate>=GETDATE()
					         
            COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_ads_resumes]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ads_resumes]

AS
BEGIN
BEGIN TRY
		BEGIN TRANSACTION

			 SELECT j.ContactEmail,j.ResumeID,
					s.SalaryLevelID,s.SalaryLevel,
					c.JobIndustryID,c.JobIndustryName					
					,ct.CertificateID,ct.CertificateName,		
					l.ExperienceLevelID,l.ExperienceLevelName,
					dt.ProvinceID,pr.ProvinceName,dt.DistrictID,dt.DistrictName	
					,sk.SkillID,sk.SkillName,r.UserID,
					r.FirstName,r.LastName,r.DateOfBirth,sex.SexID,SexName
			 FROM   ResumeDetails j,JobSalaryLevel s,JobIndustries c,
					Certificates ct,[User] r,ExperienceLevel l,Province pr,Skill sk,District dt,Sex sex
			 WHERE j.CertificateID=ct.CertificateID
					AND j.ExperienceLevelID=l.ExperienceLevelID				
					AND j.ProvinceID=pr.ProvinceID
					AND j.UserID=r.UserID
					AND j.JobIndustryID=c.JobIndustryID
					AND j.SalaryLevelID=s.SalaryLevelID					
					AND j.SkillID=sk.SkillID
					AND r.DistrictID=dt.DistrictID
					AND dt.ProvinceID=pr.ProvinceID
					AND r.SexID=sex.SexID							         
            COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_ads_resumes2]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ads_resumes2] 
	@JobID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			SELECT a.*, b.CertificateName,c.SalaryLevel,
					e.JobIndustryName,f.JobPositionName,g.ExperienceLevelName,sk.SkillName,
					h.WorkTypeName,i.FirstName,i.LastName,sex.SexName,i.DateOfBirth,i.PhotoPath,dt.DistrictName,pr.ProvinceName
					FROM 
					ResumeDetails AS a LEFT OUTER JOIN Certificates AS b ON a.CertificateID = b.CertificateID
					LEFT OUTER JOIN JobSalaryLevel AS c ON a.SalaryLevelID = c.SalaryLevelID
					LEFT OUTER JOIN Province AS d ON a.ProvinceID = d.ProvinceID
					LEFT OUTER JOIN JobIndustries AS e ON a.JobIndustryID = e.JobIndustryID
					LEFT OUTER JOIN JobPosition AS f ON a.JobPositionID = f.JobPositionID
					LEFT OUTER JOIN ExperienceLevel AS g ON a.ExperienceLevelID = g.ExperienceLevelID
					LEFT OUTER JOIN WorkTypes AS h ON a.WorkTypeID = h.WorkTypeID
					LEFT OUTER JOIN Skill AS sk ON a.SkillID = sk.SkillID
					LEFT OUTER JOIN [User] AS i ON a.UserID = i.UserID,Sex sex,District dt,Province pr
			 WHERE		 i.SexID=sex.SexID
						AND i.DistrictID=dt.DistrictID
						AND dt.ProvinceID=pr.ProvinceID
					AND a.ResumeID in (SELECT [ResumeID]
										  FROM [dbo].[JobApplied]
										  WHERE [JobID]=@JobID AND STATUS=1)						         
            COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_all_jobs]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_all_jobs] 
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRANSACTION

			SELECT *
			FROM Jobs j
			WHERE j.STATUS=1
			AND j.JobID NOT IN(Select JobID From JobsSaved js Where js.UserID=@UserID )
				AND j.JobID NOT IN(Select JobID From JobApplied ja Where ja.UserID=@UserID )
			AND j.ExpiredDate>=GETDATE()
					         
            COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_all_recommend_resume]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_all_recommend_resume] 
	
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			select a.*,i.FirstName,i.LastName,sex.SexName,i.DateOfBirth,i.PhotoPath,dt.DistrictID,pr.ProvinceID
					FROM 
					ResumeDetails AS a LEFT OUTER JOIN Certificates AS b ON a.CertificateID = b.CertificateID
					LEFT OUTER JOIN JobSalaryLevel AS c ON a.SalaryLevelID = c.SalaryLevelID
					LEFT OUTER JOIN Province AS d ON a.ProvinceID = d.ProvinceID
					LEFT OUTER JOIN JobIndustries AS e ON a.JobIndustryID = e.JobIndustryID
					LEFT OUTER JOIN JobPosition AS f ON a.JobPositionID = f.JobPositionID
					LEFT OUTER JOIN ExperienceLevel AS g ON a.ExperienceLevelID = g.ExperienceLevelID
					LEFT OUTER JOIN WorkTypes AS h ON a.WorkTypeID = h.WorkTypeID
					LEFT OUTER JOIN Skill AS sk ON a.SkillID = sk.SkillID
					LEFT OUTER JOIN [User] AS i ON a.UserID = i.UserID,Sex sex,District dt,Province pr
			 WHERE		 i.SexID=sex.SexID
						AND i.DistrictID=dt.DistrictID
						AND dt.ProvinceID=pr.ProvinceID
					AND a.ResumeID in  (SELECT [ResumeID]     
								FROM [dbo].[ResumeDetails]
								where Active=1
								and ResumeID NOT In( Select ResumeID from ResumeRecruited where status=1))					         
    COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[get_resume_recruited]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_resume_recruited] 
	@JobID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			SELECT a.*, b.CertificateName,c.SalaryLevel,
					e.JobIndustryName,f.JobPositionName,g.ExperienceLevelName,sk.SkillName,
					h.WorkTypeName,i.FirstName,i.LastName,sex.SexName,i.DateOfBirth,i.PhotoPath,dt.DistrictName,pr.ProvinceName
					FROM 
					ResumeDetails AS a LEFT OUTER JOIN Certificates AS b ON a.CertificateID = b.CertificateID
					LEFT OUTER JOIN JobSalaryLevel AS c ON a.SalaryLevelID = c.SalaryLevelID
					LEFT OUTER JOIN Province AS d ON a.ProvinceID = d.ProvinceID
					LEFT OUTER JOIN JobIndustries AS e ON a.JobIndustryID = e.JobIndustryID
					LEFT OUTER JOIN JobPosition AS f ON a.JobPositionID = f.JobPositionID
					LEFT OUTER JOIN ExperienceLevel AS g ON a.ExperienceLevelID = g.ExperienceLevelID
					LEFT OUTER JOIN WorkTypes AS h ON a.WorkTypeID = h.WorkTypeID
					LEFT OUTER JOIN Skill AS sk ON a.SkillID = sk.SkillID
					LEFT OUTER JOIN [User] AS i ON a.UserID = i.UserID,Sex sex,District dt,Province pr
			 WHERE		 i.SexID=sex.SexID
						AND i.DistrictID=dt.DistrictID
						AND dt.ProvinceID=pr.ProvinceID
					AND a.ResumeID in (SELECT [ResumeID]
										  FROM [dbo].ResumeRecruited
										  WHERE [JobID]=@JobID AND STATUS=1)						         
            COMMIT;
        END TRY
        BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;        

            SELECT  0;

        END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[GetAdminAcounts]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAdminAcounts] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT u.FirstName,u.LastName,u.Email,u.PhoneNumber,r.EmailLogin,r.STATUS,r.IS_ACTIVATED,r.RegistrationDate,u.UserID
	FROM [User] u, Registration r
	WHERE u.UserID=r.UserID		
	AND u.IsAdmin=1
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllJobAppliedByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllJobAppliedByUser]
			@UserID int			
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  -- Insert statements for procedure here
	SELECT top 5 a.JobID,b.FullTitle,b.ExpiredDate,b.RewriteUrl,r.CompanyFullName,r.Address,p.ProvinceName FROM JobApplied a, Jobs b, Province p, Recruitor r
	WHERE a.[UserID]=@UserID
	AND a.[Status]=1
	AND a.JobID=b.JobID
	AND b.ProvinceID=p.ProvinceID
	AND b.RecruitorID=r.RecruitorID
	AND b.ExpiredDate> = GETDATE()
	AND b.STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllJobByRecruiter]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllJobByRecruiter] 
	-- Add the parameters for the stored procedure here
	@RecruitorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [JobID]     
      ,[ExpiredDate]   
      ,[FullTitle]
	  ,[NumsApplicant]
  FROM [dbo].[Jobs]
  WHERE RecruitorID=@RecruitorID
  And STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllJobSavedByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllJobSavedByUser] 
	-- Add the parameters for the stored procedure here
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT top 5 a.JobID,b.FullTitle,b.ExpiredDate,b.RewriteUrl,r.CompanyFullName,r.Address,p.ProvinceName,a.JobSavedID FROM JobsSaved a, Jobs b, Province p, Recruitor r
	WHERE a.[UserID]=@UserID
	AND a.[Status]=1
	AND a.JobID=b.JobID
	AND b.ProvinceID=p.ProvinceID
	AND b.RecruitorID=r.RecruitorID
	AND b.ExpiredDate>=GETDATE()
	AND b.STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllJobsByAdmin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllJobsByAdmin] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT r.CompanyFullName,r.RecruitorName,r.EmailToSendResume,r.PhoneToCallForJob,j.STATUS,j.JobID,j.FullTitle,j.IS_HOT,j.ExpiredDate
	FROM [Recruitor] r, Jobs j
	WHERE r.RecruitorID=j.RecruitorID	
	AND j.STATUS=	1
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllProvince]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllProvince]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Province
END

GO
/****** Object:  StoredProcedure [dbo].[GetDistrictInProvince]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDistrictInProvince]
	-- Add the parameters for the stored procedure here
@ProvinceId int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * From District Where ProvinceID=@ProvinceId
END

GO
/****** Object:  StoredProcedure [dbo].[GetFullJobInforById]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFullJobInforById]
	@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT j.ContentDetail,j.Description,j.FullTitle,j.ExpiredDate,j.RewriteUrl,j.NumsApplicant,
	s.SalaryLevelID,s.SalaryLevel,
	c.JobIndustryID,c.JobIndustryName,
	p.JobPositionID,p.JobPositionName,
	w.WorkTypeID,w.WorkTypeName
	,ct.CertificateID,ct.CertificateName,
	r.CompanyFullName,r.Address,r.RecruitorName,
	size.CompanySizeID,size.CompanySize,
	l.ExperienceLevelID,l.ExperienceLevelName,pr.ProvinceID,pr.ProvinceName
	FROM Jobs j,JobSalaryLevel s,JobIndustries c,
	JobPosition p,WorkTypes w,Certificates ct,Recruitor r,CompanySize size,ExperienceLevel l,Province pr
	WHERE j.CertificateID=ct.CertificateID
	AND j.ExperienceLevelID=l.ExperienceLevelID
	AND j.JobIndustryID=c.JobIndustryID
	AND j.JobPositionID=p.JobPositionID
	AND j.ProvinceID=pr.ProvinceID
	AND j.RecruitorID=r.RecruitorID
	AND r.CompanySizeID=size.CompanySizeID
	AND j.SalaryLevelID=s.SalaryLevelID
	AND j.WorkTypeID=w.WorkTypeID
	AND j.JobID=@JobID
	AND j.STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetFullRecruiterInfoById]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFullRecruiterInfoById]
@RecruitorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT r.CompanyFullName, c.CompanySizeID,c.CompanySize,r.PhoneToCallForJob,r.RecruitorName,r.CompanyShortName,r.EmailToSendResume,r.Address
   FROM Recruitor r,CompanySize c
   WHERE r.CompanySizeID=c.CompanySizeID
   AND r.RecruitorID=@RecruitorID

END

GO
/****** Object:  StoredProcedure [dbo].[GetFullResumeInfoById]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFullResumeInfoById]
@ResumeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT j.ACHIEVEMENTS,j.CAREER_GOALS,j.LITERACY,j.REFERENCE,j.SKILLS,j.WORK_EXPERIENCE,j.ContactEmail,j.ResumeName,j.ATTACHMENT,j.UserID,
	s.SalaryLevelID,s.SalaryLevel,
	c.JobIndustryID,c.JobIndustryName,
	p.JobPositionID,p.JobPositionName,
	w.WorkTypeID,w.WorkTypeName
	,ct.CertificateID,ct.CertificateName,		
	l.ExperienceLevelID,l.ExperienceLevelName,
	pr.ProvinceID,pr.ProvinceName	
	,sk.SkillID,sk.SkillName,
	r.FirstName,r.LastName,r.DateOfBirth
	FROM ResumeDetails j,JobSalaryLevel s,JobIndustries c,
	JobPosition p,WorkTypes w,Certificates ct,[User] r,ExperienceLevel l,Province pr,Skill sk
	WHERE j.CertificateID=ct.CertificateID
	AND j.ExperienceLevelID=l.ExperienceLevelID
	AND j.JobIndustryID=c.JobIndustryID
	AND j.JobPositionID=p.JobPositionID
	AND j.ProvinceID=pr.ProvinceID
	AND j.UserID=r.UserID
	AND j.SalaryLevelID=s.SalaryLevelID
	AND j.WorkTypeID=w.WorkTypeID
	AND j.SkillID=sk.SkillID
	AND j.ResumeID=@ResumeID

END

GO
/****** Object:  StoredProcedure [dbo].[GetFullUserInfoById]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFullUserInfoById] 
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT u.FirstName,u.LastName, u.DateOfBirth, u.PhotoPath,sex.SexID, sex.SexName,
	d.DistrictID,d.DistrictName,d.Latitude,d.Longitude,d.ProvinceID,p.ProvinceName,
	r.RaceID,r.RaceName,j.JobIndustryID,j.JobIndustryName,u.MaximOfLife,u.PhoneNumber
	FROM [User] u, [Sex] sex,[District] d, [Province] p,Race r,JobIndustries j
	WHERE u.SexID=sex.SexID		
	AND u.DistrictID=d.DistrictID	
	AND d.ProvinceID=p.ProvinceID	
	AND u.RaceID=r.RaceID
	AND u.JobIndustryId=j.JobIndustryID
	AND u.UserID=@UserId
END

GO
/****** Object:  StoredProcedure [dbo].[GetLoginInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLoginInfo]
	@EmailLogin nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Registration WHERE EmailLogin=@EmailLogin
END

GO
/****** Object:  StoredProcedure [dbo].[GetRcruitorAcounts]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetRcruitorAcounts] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	  -- Insert statements for procedure here
	SELECT u.CompanyFullName,u.EmailToSendResume,u.PhoneToCallForJob,u.Address,r.EmailLoginAsRecruitor,r.STATUS,r.IS_ACTIVATED,r.RegistrationDateTime,u.RecruitorID
	FROM [Recruitor] u, RegistrationAsRecruitor r
	WHERE u.RecruitorID=r.RecruitorID	
	AND r.IS_ACTIVATED=1
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetRecruiterInfoById]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRecruiterInfoById]
@RecruitorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT r.CompanyFullName,r.PhoneToCallForJob,r.RecruitorName,r.CompanyShortName
   FROM Recruitor r
   WHERE r.RecruitorID=@RecruitorID

END

GO
/****** Object:  StoredProcedure [dbo].[GetRecruiterLoginInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRecruiterLoginInfo]
	@EmailLogin nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM RegistrationAsRecruitor WHERE EmailLoginAsRecruitor=@EmailLogin
END

GO
/****** Object:  StoredProcedure [dbo].[GetResumeActiveByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetResumeActiveByUser]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM ResumeDetails r
	WHERE r.[UserID]=@UserID	
	AND r.STATUS=1
	AND r.Active=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetResumeByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetResumeByUser]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT top 5 r.ResumeName, r.ResumeID, r.STATUS,r.Active
	FROM ResumeDetails r
	WHERE r.[UserID]=@UserID	
	AND r.STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserAcounts]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserAcounts] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT u.FirstName,u.LastName,u.Email,u.PhoneNumber,r.EmailLogin,r.STATUS,r.IS_ACTIVATED,r.RegistrationDate,u.UserID
	FROM [User] u, Registration r
	WHERE u.UserID=r.UserID		
	AND u.IsAdmin=0
	AND r.IS_ACTIVATED=1
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserInfoByEmailLogin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserInfoByEmailLogin]
@EmailLogin nvarchar(50),
@Type int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@Type=1)
	SELECT * From [User]
	WHERE UserID in (SELECT UserID FROM Registration WHERE EmailLogin=@EmailLogin)
	ELSE IF (@Type=2)
	SELECT * FROM Recruitor
	WHERE RecruitorID in (SELECT RecruitorID FROM RegistrationAsRecruitor WHERE EmailLoginAsRecruitor=@EmailLogin)
	ELSE SELECT 0
END

GO
/****** Object:  StoredProcedure [dbo].[RecoverPassword]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RecoverPassword] 
	-- Add the parameters for the stored procedure here
	@Email					VARCHAR(50),
	@Token					VARCHAR(32)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
       BEGIN TRY
           BEGIN TRANSACTION
		   
			IF(NOT EXISTS(SELECT * FROM Registration a WHERE a.EmailLogin = @Email ) AND NOT EXISTS(SELECT * FROM RegistrationAsRecruitor b WHERE b.EmailLoginAsRecruitor = @Email ))
			BEGIN
				SELECT 'INVALID_EMAIL';
			END
			ELSE IF((SELECT a.IS_ACTIVATED FROM  Registration a WHERE a.EmailLogin = @Email) = 0 OR (SELECT b.IS_ACTIVATED FROM  RegistrationAsRecruitor b WHERE b.EmailLoginAsRecruitor = @Email) = 0)
			BEGIN
				SELECT 'NOT_ACTIVE';
			END
			ELSE
			BEGIN
			IF(EXISTS(SELECT * FROM Registration a WHERE a.EmailLogin = @Email ))
				BEGIN
				UPDATE Registration
				SET	PassWordLogin = @Token
				WHERE  
				EmailLogin = @Email
				SELECT '1';
				END
			ELSE
				BEGIN
				UPDATE RegistrationAsRecruitor
				SET	Password = @Token
				WHERE  
				EmailLoginAsRecruitor = @Email
				SELECT '2';
				END
			END
			COMMIT;
       END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[ResetPassword]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ResetPassword]
	@EmailLogin nvarchar(50),
	@Password	VARCHAR(50),
    @Token		VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;
       BEGIN TRY
           BEGIN TRANSACTION
		   
		   IF( NOT EXISTS(SELECT * FROM Registration a WHERE  a.EmailLogin = @EmailLogin AND a.User_Valid_Email_Code = @Token) AND NOT EXISTS(SELECT * FROM RegistrationAsRecruitor b WHERE  b.EmailLoginAsRecruitor = @EmailLogin AND b.User_Valid_Email_Code = @Token))
			BEGIN
				SELECT 'INVALID_TOKEN';
			END
			ELSE
			BEGIN
			IF(EXISTS(SELECT * FROM Registration a WHERE a.EmailLogin = @EmailLogin ))
				BEGIN
				UPDATE Registration
				SET PassWordLogin = @Password
				WHERE  EmailLogin = @EmailLogin
				AND User_Valid_Email_Code = @Token
				SELECT 1;
				END
			ELSE
				BEGIN
				UPDATE RegistrationAsRecruitor
				SET Password = @Password
				WHERE  EmailLoginAsRecruitor = @EmailLogin
				AND User_Valid_Email_Code = @Token
				SELECT 2;
				END
			END

		   COMMIT;
       END TRY
	      BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[SearchJobByIds]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchJobByIds] 
	-- Add the parameters for the stored procedure here
	@CertificateID				int
	,@JobSalaryLevelID			int
	,@ProvinceID				int
	,@JobIndutriesID			int
	,@JobPositionID				int
	,@ExperienceLevelID			int
	,@WorkTypeID				int
	,@RecruiterID				int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.*, b.CertificateName,c.SalaryLevel,d.ProvinceName,e.JobIndustryName,f.JobPositionName,g.ExperienceLevelName,h.WorkTypeName,i.CompanyFullName,i.[Address] FROM 
	Jobs AS a LEFT OUTER JOIN Certificates AS b ON a.CertificateID = b.CertificateID
	LEFT OUTER JOIN JobSalaryLevel AS c ON a.SalaryLevelID = c.SalaryLevelID
	LEFT OUTER JOIN Province AS d ON a.ProvinceID = d.ProvinceID
	LEFT OUTER JOIN JobIndustries AS e ON a.JobIndustryID = e.JobIndustryID
	LEFT OUTER JOIN JobPosition AS f ON a.JobPositionID = f.JobPositionID
	LEFT OUTER JOIN ExperienceLevel AS g ON a.ExperienceLevelID = g.ExperienceLevelID
	LEFT OUTER JOIN WorkTypes AS h ON a.WorkTypeID = h.WorkTypeID
	LEFT OUTER JOIN Recruitor AS i ON a.RecruitorID = i.RecruitorID
	WHERE (a.CertificateID = @CertificateID OR @CertificateID = 0)
	AND (a.SalaryLevelID = @JobSalaryLevelID OR @JobSalaryLevelID =0)
	AND (a.ProvinceID = @ProvinceID OR @ProvinceID = 0)
	AND (a.JobIndustryID = @JobIndutriesID OR @JobIndutriesID = 0)
	AND (a.JobPositionID = @JobPositionID OR @JobPositionID = 0)
	AND (a.ExperienceLevelID = @ExperienceLevelID OR @ExperienceLevelID =0)
	AND (a.WorkTypeID = @WorkTypeID OR @WorkTypeID =0)
	AND (a.RecruitorID = @RecruiterID OR @RecruiterID =0)
	AND a.ExpiredDate > = GETDATE()
	AND a.STATUS=1
END

GO
/****** Object:  StoredProcedure [dbo].[SearchResumeByIds]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchResumeByIds] 
	-- Add the parameters for the stored procedure here
	@CertificateID				int
	,@JobSalaryLevelID			int
	,@ProvinceID				int
	,@JobIndutriesID			int
	,@JobPositionID				int
	,@ExperienceLevelID			int
	,@WorkTypeID				int
	,@SexID						int
	,@LangSkillID				int
	,@UserID				int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.*, b.CertificateName,c.SalaryLevel,DATEPART(yyyy,i.DateOfBirth) AS OrderYear,
	e.JobIndustryName,f.JobPositionName,g.ExperienceLevelName,sk.SkillName,
	h.WorkTypeName,i.FirstName,i.LastName,i.PhotoPath,sex.SexName,i.DateOfBirth,dt.DistrictName,pr.ProvinceName
	FROM 
	ResumeDetails AS a LEFT OUTER JOIN Certificates AS b ON a.CertificateID = b.CertificateID
	LEFT OUTER JOIN JobSalaryLevel AS c ON a.SalaryLevelID = c.SalaryLevelID
	LEFT OUTER JOIN Province AS d ON a.ProvinceID = d.ProvinceID
	LEFT OUTER JOIN JobIndustries AS e ON a.JobIndustryID = e.JobIndustryID
	LEFT OUTER JOIN JobPosition AS f ON a.JobPositionID = f.JobPositionID
	LEFT OUTER JOIN ExperienceLevel AS g ON a.ExperienceLevelID = g.ExperienceLevelID
	LEFT OUTER JOIN WorkTypes AS h ON a.WorkTypeID = h.WorkTypeID
	LEFT OUTER JOIN Skill AS sk ON a.SkillID = sk.SkillID
	LEFT OUTER JOIN [User] AS i ON a.UserID = i.UserID,Sex sex,District dt,Province pr
	WHERE (a.CertificateID = @CertificateID OR @CertificateID = 0)
	AND (a.SalaryLevelID = @JobSalaryLevelID OR @JobSalaryLevelID =0)
	AND (a.ProvinceID = @ProvinceID OR @ProvinceID = 0)
	AND (a.JobIndustryID = @JobIndutriesID OR @JobIndutriesID = 0)
	AND (a.JobPositionID = @JobPositionID OR @JobPositionID = 0)
	AND (a.ExperienceLevelID = @ExperienceLevelID OR @ExperienceLevelID =0)
	AND (a.WorkTypeID = @WorkTypeID OR @WorkTypeID =0)
	AND (a.UserID = @UserID OR @UserID =0)
	AND (a.SkillID=@LangSkillID OR @LangSkillID=0)
	AND i.SexID=sex.SexID
	AND i.DistrictID=dt.DistrictID
	AND dt.ProvinceID=pr.ProvinceID
	AND (sex.SexID=@SexID OR @SexID=0)	
	END
GO
/****** Object:  StoredProcedure [dbo].[SetJobAppliedByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetJobAppliedByUser]
			@UserID int,
	    @JobID int,
		@ResumeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY    
            BEGIN TRANSACTION
			IF EXISTS(SELECT * FROM JobApplied
						WHERE [UserID]=@UserID AND JobID=@JobID AND ResumeID=@ResumeID)
					
            UPDATE  JobApplied
			SET
				[Status]=1
			WHERE UserID=@UserID
			AND JobID=@JobID
			AND ResumeID=@ResumeID
			
			ELSE
			INSERT INTO JobApplied
						([UserID]
						,JobID
						,ResumeID
						,[Status]
						)
				VALUES	(@UserID
						,@JobID
						,@ResumeID
						,1)
						SELECT 1
		COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[SetJobSavedByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetJobSavedByUser]
		@UserID int,
	    @JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY    
            BEGIN TRANSACTION
			IF EXISTS(SELECT * FROM JobsSaved
						WHERE [UserID]=@UserID AND JobID=@JobID)
					
            UPDATE  JobsSaved
			SET
				[Status]=1
			WHERE UserID=@UserID
			AND JobID=@JobID
			
			ELSE
			INSERT INTO JobsSaved
						([UserID]
						,JobID
						,[Status]
						)
				VALUES	(@UserID
						,@JobID
						,1)
						SELECT 1
		COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[SetResumeRecruitedByRecruiter]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetResumeRecruitedByRecruiter]
			@RecruitorID int,
	    @ResumeID int,
		@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY    
            BEGIN TRANSACTION
			IF EXISTS(SELECT * FROM ResumeRecruited
						WHERE RecruitorID=@RecruitorID AND ResumeID=@ResumeID)
					
            UPDATE  ResumeRecruited
			SET
				[Status]=1
			WHERE RecruitorID=@RecruitorID 
			AND ResumeID=@ResumeID
			AND JobID=@JobID
			
			ELSE
			INSERT INTO ResumeRecruited
						(RecruitorID
						,ResumeID
						,JobID
						,[Status]
						)
				VALUES	(@RecruitorID
						,@ResumeID
						,@JobID
						,1)
						SELECT 1
		COMMIT;
	END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[UnlockAnAccount]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnlockAnAccount]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].Registration
	set STATUS=1
    WHERE UserID=@UserID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UnlockAnRecrutorAccount]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnlockAnRecrutorAccount]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].RegistrationAsRecruitor
	set STATUS=1
    WHERE RecruitorID=@UserID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAJobInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAJobInfo] 
	-- Add the parameters for the stored procedure here
@JobTitle nvarchar(100)
,@CertificateID int
,@JobSalaryLevelID int
,@ProvinceID int
,@JobIndutriesID int
,@ContentDetail nvarchar(Max)
,@Description nvarchar(Max)
,@ExpiredDate date
,@JobPositionID int
,@ExperienceLevelID int
,@WorkTypeID int
,@RecruiterID int
,@NumsApplicant int
,@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SET NOCOUNT ON;
	 BEGIN TRY
            BEGIN TRANSACTION
			UPDATE [dbo].[Jobs]
   SET [RecruitorID]=@RecruiterID,
      [JobPositionID] =@JobPositionID
      ,[SalaryLevelID] = @JobSalaryLevelID
      ,[ProvinceID] = @ProvinceID
      ,[WorkTypeID] = @WorkTypeID
      ,[ExperienceLevelID] = @ExperienceLevelID
      ,[CertificateID] = @CertificateID
      ,[ExpiredDate] = @ExpiredDate
      ,[JobIndustryID] = @JobIndutriesID
      ,[FullTitle] = @JobTitle
      ,[ContentDetail] = @ContentDetail
      ,[Description] = @Description      
      ,[NumsApplicant] = @NumsApplicant
      WHERE JobID=@JobID
				 	SELECT 1
             COMMIT;
			END TRY
			BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
			END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAllResumeUnActiveByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAllResumeUnActiveByUser]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update ResumeDetails
	set Active=0	
	WHERE UserID=@UserID	
	AND STATUS=1
	SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAResumeInfo]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAResumeInfo] 
	       @JobPositionId int,
            @JobIndutriesId int,
            @ProvinceID int,
            @JobSalaryLevelId int,
            @WorkTypeId int,
           @ExperienceLevelId int,
           @ResumeName nvarchar(50),
           @ContactMail nvarchar(50),
           @Achievement nvarchar(max),
           @UserId int,
           @SkillID int, 
           @CareerGoal nvarchar(500),
           @WorkExperience nvarchar(500),
           @Literacy nvarchar(500),
           @Skill nvarchar(500),
           @Reference nvarchar(500) ,        
           @CertificateId int,
		   @ResumeID int,
		   @AttachFile VARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 BEGIN TRY
            BEGIN TRANSACTION

			UPDATE [dbo].[ResumeDetails]
			   SET [JobPositionID] = @JobPositionId
				  ,[JobIndustryID] = @JobIndutriesId
				  ,[ProvinceID] = @ProvinceID
				  ,[SalaryLevelID] = @JobSalaryLevelId
				  ,[WorkTypeID] = @WorkTypeId
				  ,[ExperienceLevelID] = @ExperienceLevelId
				  ,[ResumeName] = @ResumeName
				  ,[ContactEmail] = @ContactMail
				  ,[ACHIEVEMENTS] = @Achievement
				  ,[UserID] = @UserId
				  ,[SkillID] = @SkillID
				  ,[CAREER_GOALS] = @CareerGoal
				  ,[WORK_EXPERIENCE] = @WorkExperience
				  ,[LITERACY] = @Literacy
				  ,[SKILLS] = @Skill
				  ,[REFERENCE] = @Reference				  
				  ,[CertificateID] = @CertificateId
				  ,ATTACHMENT=@AttachFile
					 WHERE ResumeID=@ResumeID
			 	SELECT 1
             COMMIT;
			END TRY
			BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
			END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[UpdateJobsActiveByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateJobsActiveByUser]
@ResumeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update ResumeDetails
	set Active=1	
	WHERE ResumeID=@ResumeID	
	SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateJobsHotByAdmin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateJobsHotByAdmin]
@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].Jobs
	set IS_HOT=1
    WHERE JobID=@JobID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateJobsUnActiveByUser]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[UpdateJobsUnActiveByUser]
@ResumeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update ResumeDetails
	set Active=0	
	WHERE ResumeID=@ResumeID	
	SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateJobsUnHotByAdmin]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateJobsUnHotByAdmin]
@JobID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    	BEGIN TRY
	BEGIN TRANSACTION
	Update [dbo].Jobs
	set IS_HOT=0
    WHERE JobID=@JobID	 	  
	  SELECT 1
	  COMMIT;
	  END TRY
    BEGIN CATCH
            IF ( @@ERROR <> 0 ) 
                ROLLBACK TRANSACTION;
                 SELECT  0;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[VerifyAccount]    Script Date: 02/12/2015 9:48:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VerifyAccount]
	@VerifyCode					NVARCHAR(50)	
 AS
   BEGIN
       SET NOCOUNT ON;
       BEGIN TRY
			BEGIN TRANSACTION
				
				IF(NOT EXISTS(SELECT * FROM Registration WHERE User_Valid_Email_Code = @VerifyCode))
					SELECT 'INVALID_VERIFY_CODE'; --Sai mã kích hoạt
				ELSE IF(EXISTS(SELECT * FROM Registration WHERE User_Valid_Email_Code = @VerifyCode AND IS_ACTIVATED = 1))
					SELECT 'ACTIVATED'; --Tài khoản đã kích hoạt
				ELSE
				BEGIN
					UPDATE Registration SET IS_ACTIVATED = 1 WHERE User_Valid_Email_Code = @VerifyCode;

					SELECT 'SUCCESS'; --Kích hoạt  thành công

					SELECT * FROM Registration WHERE User_Valid_Email_Code = @VerifyCode 
				END
					
			COMMIT;
       END TRY
       BEGIN CATCH
           IF(@@ERROR <> 0) ROLLBACK TRANSACTION;       
			  SELECT 0
       END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[VerifyAccountForRecruitor]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VerifyAccountForRecruitor]
	@VerifyCode					NVARCHAR(50)	
 AS
   BEGIN
       SET NOCOUNT ON;
       BEGIN TRY
			BEGIN TRANSACTION
				
				IF(NOT EXISTS(SELECT * FROM RegistrationAsRecruitor WHERE User_Valid_Email_Code = @VerifyCode))
					SELECT 'INVALID_VERIFY_CODE'; --Sai mã kích hoạt
				ELSE IF(EXISTS(SELECT * FROM RegistrationAsRecruitor WHERE User_Valid_Email_Code = @VerifyCode AND IS_ACTIVATED = 1))
					SELECT 'ACTIVATED'; --Tài khoản đã kích hoạt
				ELSE
				BEGIN
					UPDATE RegistrationAsRecruitor SET IS_ACTIVATED = 1 WHERE User_Valid_Email_Code = @VerifyCode;

					SELECT 'SUCCESS'; --Kích hoạt  thành công

					SELECT * FROM RegistrationAsRecruitor WHERE User_Valid_Email_Code = @VerifyCode 
				END
					
			COMMIT;
       END TRY
       BEGIN CATCH
           IF(@@ERROR <> 0) ROLLBACK TRANSACTION;       
			  SELECT 0
       END CATCH
END

GO
/****** Object:  Table [dbo].[Certificates]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certificates](
	[CertificateID] [int] IDENTITY(1,1) NOT NULL,
	[CertificateName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Certificates] PRIMARY KEY CLUSTERED 
(
	[CertificateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanySize]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanySize](
	[CompanySizeID] [int] IDENTITY(1,1) NOT NULL,
	[CompanySize] [nvarchar](50) NULL,
 CONSTRAINT [PK_CompanySize] PRIMARY KEY CLUSTERED 
(
	[CompanySizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[District]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[DistrictID] [int] IDENTITY(1,1) NOT NULL,
	[DistrictName] [nvarchar](50) NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[ProvinceID] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Education]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Education](
	[EducationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[School] [nvarchar](50) NULL,
	[Faculty] [nvarchar](50) NULL,
	[CertificateID] [int] NOT NULL,
	[Major] [nvarchar](50) NULL,
	[FromMonthYear] [nchar](7) NULL,
	[ToMonthYear] [nchar](7) NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_Education] PRIMARY KEY CLUSTERED 
(
	[EducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExperienceLevel]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExperienceLevel](
	[ExperienceLevelID] [int] IDENTITY(1,1) NOT NULL,
	[ExperienceLevelName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ExperienceLevel] PRIMARY KEY CLUSTERED 
(
	[ExperienceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Experiences]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Experiences](
	[ExperienceID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Company] [nvarchar](50) NULL,
	[Salary] [nvarchar](50) NULL,
	[FromMonthYear] [nchar](10) NULL,
	[JobPosition] [nvarchar](50) NULL,
	[Description] [nvarchar](300) NULL,
 CONSTRAINT [PK_Experiences] PRIMARY KEY CLUSTERED 
(
	[ExperienceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobApplied]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobApplied](
	[JobAppliedID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[JobID] [int] NULL,
	[Status] [int] NULL,
	[ResumeID] [int] NULL,
 CONSTRAINT [PK_JobApplied] PRIMARY KEY CLUSTERED 
(
	[JobAppliedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobIndustries]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobIndustries](
	[JobIndustryID] [int] IDENTITY(1,1) NOT NULL,
	[JobIndustryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobIndustries] PRIMARY KEY CLUSTERED 
(
	[JobIndustryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobPosition]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPosition](
	[JobPositionID] [int] IDENTITY(1,1) NOT NULL,
	[JobPositionName] [nvarchar](50) NULL,
 CONSTRAINT [PK_JobPosition] PRIMARY KEY CLUSTERED 
(
	[JobPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs](
	[JobID] [int] IDENTITY(1,1) NOT NULL,
	[RecruitorID] [int] NOT NULL,
	[JobPositionID] [int] NOT NULL,
	[SalaryLevelID] [int] NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[WorkTypeID] [int] NOT NULL,
	[ExperienceLevelID] [int] NOT NULL,
	[CertificateID] [int] NOT NULL,
	[ExpiredDate] [datetime] NOT NULL,
	[JobIndustryID] [int] NOT NULL,
	[FullTitle] [nvarchar](100) NOT NULL,
	[ContentDetail] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[RewriteUrl] [nvarchar](250) NOT NULL,
	[NumsApplicant] [int] NULL,
	[STATUS] [int] NOT NULL,
	[IS_HOT] [bit] NOT NULL,
 CONSTRAINT [PK_Jobs] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobSalaryLevel]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobSalaryLevel](
	[SalaryLevelID] [int] IDENTITY(1,1) NOT NULL,
	[SalaryLevel] [nvarchar](50) NULL,
 CONSTRAINT [PK_JobSalaryLevel] PRIMARY KEY CLUSTERED 
(
	[SalaryLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobsSaved]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobsSaved](
	[JobSavedID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[JobID] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_JobsSavedID] PRIMARY KEY CLUSTERED 
(
	[JobSavedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Province]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Province](
	[ProvinceID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Race]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Race](
	[RaceID] [int] IDENTITY(1,1) NOT NULL,
	[RaceName] [nvarchar](30) NULL,
 CONSTRAINT [PK_Race] PRIMARY KEY CLUSTERED 
(
	[RaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Recruitor]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recruitor](
	[RecruitorID] [int] IDENTITY(1,1) NOT NULL,
	[RecruitorName] [nvarchar](50) NULL,
	[CompanySizeID] [int] NULL,
	[CompanyFullName] [nvarchar](100) NULL,
	[CompanyShortName] [nvarchar](50) NULL,
	[Address] [nvarchar](200) NULL,
	[EmailToSendResume] [nvarchar](50) NULL,
	[PhoneToCallForJob] [nvarchar](20) NULL,
	[EmailLogin] [nvarchar](50) NULL,
	[PhotoPath] [nvarchar](200) NULL,
 CONSTRAINT [PK_Recruitor] PRIMARY KEY CLUSTERED 
(
	[RecruitorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Registration]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[RegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[EmailLogin] [nvarchar](50) NOT NULL,
	[PassWordLogin] [nvarchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
	[RegistrationDate] [date] NOT NULL,
	[TypeUser] [int] NULL,
	[User_Valid_Email_Code] [nvarchar](50) NULL,
	[IS_ACTIVATED] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[RegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegistrationAsRecruitor]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationAsRecruitor](
	[RegistrationAsRecruitorID] [int] IDENTITY(1,1) NOT NULL,
	[EmailLoginAsRecruitor] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RecruitorID] [int] NOT NULL,
	[RegistrationDateTime] [date] NOT NULL,
	[TypeUser] [int] NOT NULL,
	[User_Valid_Email_Code] [nvarchar](50) NULL,
	[IS_ACTIVATED] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
 CONSTRAINT [PK_RegistrationAsRecruitor] PRIMARY KEY CLUSTERED 
(
	[RegistrationAsRecruitorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ResumeDetails]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResumeDetails](
	[ResumeID] [int] IDENTITY(1,1) NOT NULL,
	[JobPositionID] [int] NULL,
	[JobIndustryID] [int] NULL,
	[ProvinceID] [int] NULL,
	[SalaryLevelID] [int] NULL,
	[WorkTypeID] [int] NULL,
	[ExperienceLevelID] [int] NULL,
	[ResumeName] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](50) NULL,
	[ACHIEVEMENTS] [nvarchar](max) NULL,
	[UserID] [int] NOT NULL,
	[SkillID] [int] NULL,
	[CAREER_GOALS] [nvarchar](500) NULL,
	[WORK_EXPERIENCE] [nvarchar](500) NULL,
	[LITERACY] [nvarchar](500) NULL,
	[SKILLS] [nvarchar](500) NULL,
	[REFERENCE] [nvarchar](500) NULL,
	[ATTACHMENT] [nvarchar](50) NULL,
	[CertificateID] [int] NULL,
	[STATUS] [int] NOT NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_ResumeDetails] PRIMARY KEY CLUSTERED 
(
	[ResumeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ResumeRecruited]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResumeRecruited](
	[ResumeRecruitedID] [int] IDENTITY(1,1) NOT NULL,
	[ResumeID] [int] NULL,
	[RecruitorID] [int] NULL,
	[Status] [int] NULL,
	[JobID] [int] NULL,
 CONSTRAINT [PK_ResumeRecruited] PRIMARY KEY CLUSTERED 
(
	[ResumeRecruitedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sex]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sex](
	[SexID] [int] IDENTITY(1,1) NOT NULL,
	[SexName] [nvarchar](20) NULL,
 CONSTRAINT [PK_Sex] PRIMARY KEY CLUSTERED 
(
	[SexID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Skill]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [nvarchar](50) NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[SexID] [int] NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[DistrictID] [int] NULL,
	[FirstName] [nvarchar](30) NULL,
	[LastName] [nvarchar](30) NULL,
	[RaceID] [int] NULL,
	[PhotoPath] [nvarchar](200) NULL,
	[NewsLetter] [bit] NULL,
	[JobAlert] [bit] NULL,
	[Activate] [bit] NULL,
	[ResumeActivate] [int] NULL,
	[MaximOfLife] [nvarchar](500) NULL,
	[JobIndustryID] [int] NULL,
	[IsAdmin] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkTypes]    Script Date: 02/12/2015 9:48:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTypes](
	[WorkTypeID] [int] IDENTITY(1,1) NOT NULL,
	[WorkTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_WorkTypes] PRIMARY KEY CLUSTERED 
(
	[WorkTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Certificates] ON 

INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (2, N'Trên đại học')
INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (3, N'Đại học')
INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (4, N'Cao đẳng')
INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (5, N'Trung cấp')
INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (6, N'THPT')
INSERT [dbo].[Certificates] ([CertificateID], [CertificateName]) VALUES (7, N'Không có bằng cấp')
SET IDENTITY_INSERT [dbo].[Certificates] OFF
SET IDENTITY_INSERT [dbo].[CompanySize] ON 

INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (1, N'Dưới 10 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (2, N'10 đến 30 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (3, N'30 đến 100 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (4, N'Trên 100 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (5, N'15 - 20 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (6, N'20 - 25 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (7, N'100 - 499 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (8, N'Trên 500 người')
INSERT [dbo].[CompanySize] ([CompanySizeID], [CompanySize]) VALUES (9, N'Trên 1000 người')
SET IDENTITY_INSERT [dbo].[CompanySize] OFF
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (1, N'Từ Liêm
', 21.052059, 105.746834, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (2, N'Hai Bà Trưng
', 21.004106, 105.855413, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (3, N'Ba Đình
', 21.035943, 105.826082, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (4, N'Cầu Giấy
', 21.028378, 105.790659, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (5, N'Hoàn Kiếm
', 21.028325, 105.855468, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (6, N'Sóc Sơn
', 21.254694, 105.849527, 2)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (7, N'Quận 1
', 10.776386, 106.700321, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (8, N'Phú Nhuận
', 10.799253, 106.679184, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (9, N'Tân Bình 
', 10.808895, 106.646769, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (10, N'Bình Thạnh
', 10.810695, 106.709015, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (11, N'Thủ Đức
', 10.84944, 106.753814, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (12, N'Quận 8
', 10.72986, 106.637924, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (13, N'Quận 12
', 10.873223, 106.658608, 3)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (14, N'Bến Thủy
', 18.657162, 105.702864, 4)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (15, N'Hà Huy Tập
', 18.691954, 105.683713, 4)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (16, N'Trường Thi
', 18.669756, 105.691068, 4)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (17, N'Hưng Dũng
', 18.677113, 105.705758, 4)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (18, N'Đội Cung
', 18.672608, 105.665394, 4)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (19, N'Hải Châu
', 16.047167, 108.220041, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (20, N'Sơn Trà
', 16.107234, 108.252092, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (21, N'Ngũ Hành Sơn
', 15.980296, 108.273054, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (22, N'Cẩm Lệ
', 16.015439, 108.195976, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (23, N'Thanh Khê
', 16.064067, 108.187078, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (24, N'Hòa Vang
', 16.058674, 108.02435, 5)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (25, N'Lê Chân
', 20.83968, 106.681897, 6)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (26, N'Tiên Lãng
', 20.692773, 106.592553, 6)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (27, N'Vĩnh Bảo
', 20.694318, 106.463141, 6)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (29, N'Bạch Long Vỹ
', 20.13112, 107.731118, 6)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (30, N'Đồ Sơn
', 20.722334, 106.75908, 6)
INSERT [dbo].[District] ([DistrictID], [DistrictName], [Latitude], [Longitude], [ProvinceID]) VALUES (34, N'Khác', 1, NULL, 0)
SET IDENTITY_INSERT [dbo].[District] OFF
SET IDENTITY_INSERT [dbo].[ExperienceLevel] ON 

INSERT [dbo].[ExperienceLevel] ([ExperienceLevelID], [ExperienceLevelName]) VALUES (2, N'Tôi mới tốt nghiệp/chưa có kinh nghiệm làm việc')
INSERT [dbo].[ExperienceLevel] ([ExperienceLevelID], [ExperienceLevelName]) VALUES (3, N'Dưới 1 năm')
INSERT [dbo].[ExperienceLevel] ([ExperienceLevelID], [ExperienceLevelName]) VALUES (1002, N'1-3 năm')
INSERT [dbo].[ExperienceLevel] ([ExperienceLevelID], [ExperienceLevelName]) VALUES (1003, N'Từ 3-5 năm')
INSERT [dbo].[ExperienceLevel] ([ExperienceLevelID], [ExperienceLevelName]) VALUES (1004, N'Trên 5 năm')
SET IDENTITY_INSERT [dbo].[ExperienceLevel] OFF
SET IDENTITY_INSERT [dbo].[JobApplied] ON 

INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (13, 1, 1044, 1, 7)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (14, 1, 31, 1, 6)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (15, 1, 31, 1, 7)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (16, 1, 39, 1, 7)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (17, 11, 32, 0, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (18, 30, 2045, 1, 13)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (19, 28, 2047, 1, 12)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (20, 27, 2045, 1, 14)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (22, 27, 2047, 1, 14)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (23, 27, 35, 0, 14)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (26, 15, 2045, 1, 15)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (27, 15, 2047, 1, 15)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (28, 15, 2046, 1, 15)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (32, 31, 2043, 1, 16)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (33, 31, 2045, 1, 16)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2018, 1, 2043, 1, 6)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2019, 11, 2047, 1, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2020, 11, 2044, 0, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2021, 11, 35, 0, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2022, 11, 34, 0, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2023, 11, 2048, 1, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2024, 11, 2045, 1, 10)
INSERT [dbo].[JobApplied] ([JobAppliedID], [UserID], [JobID], [Status], [ResumeID]) VALUES (2025, 2057, 2043, 1, 1039)
SET IDENTITY_INSERT [dbo].[JobApplied] OFF
SET IDENTITY_INSERT [dbo].[JobIndustries] ON 

INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (2, N'Bán hàng')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (3, N'Bán hàng kỹ thuật')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (4, N'Bán lẻ/Bán sỉ')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (5, N'Bảo hiểm')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (6, N'Bất động sản')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (7, N'Biên phiên dịch')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (8, N'Cấp quản lý điều hành')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (9, N'Chứng khoán')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (10, N'Cơ khí')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (11, N'CNTT-Phần cứng/Mạng')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (12, N'Công nghệ cao')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (13, N'Dầu khí')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (14, N'Dệt may/Da giấy')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (15, N'Dịch vụ khách hàng ')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (16, N'Dược phẩm/Công nghệ sinh học')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (17, N'Giáo dục đào tạo')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (18, N'Hàng cao cấp')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (19, N'Hàng không/Du lịch/Khách sạn')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (20, N'Hành chính/Thư ký')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (21, N'Hóa học/Sinh học')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (22, N'Hoạch định/Dự án')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (23, N'IT-Phần mềm')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (24, N'IT-Phần cứng/Mạng')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (25, N'Kế toán')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (26, N'Kho vận')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (27, N'Kiểm toán')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (28, N'Kiến trúc /Thiết kế nội thất')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (29, N'Marketing')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (30, N'Môi trường/Xử lý chất thải')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (31, N'Mỹ thuật/Thiết kế')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (32, N'Ngân hàng')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (33, N'Nông nghiệp')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (34, N'Ô tô')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (35, N'Thời trang')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (36, N'Truyền hình')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (37, N'Viễn thông')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (38, N'Y tế/ Chăm sóc sức khỏe')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (39, N'Điện/Điện tử')
INSERT [dbo].[JobIndustries] ([JobIndustryID], [JobIndustryName]) VALUES (40, N'Khác')
SET IDENTITY_INSERT [dbo].[JobIndustries] OFF
SET IDENTITY_INSERT [dbo].[JobPosition] ON 

INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (2, N'Quản lý cấp cao')
INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (3, N'Nhân viên')
INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (4, N'Trưởng nhóm/Giám sát')
INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (5, N'Quản lý')
INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (6, N'Điều hành cấp cao')
INSERT [dbo].[JobPosition] ([JobPositionID], [JobPositionName]) VALUES (7, N'Sinh viên/Thực tập sinh')
SET IDENTITY_INSERT [dbo].[JobPosition] OFF
SET IDENTITY_INSERT [dbo].[Jobs] ON 

INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (32, 1020, 2, 2, 2, 2, 2, 2, CAST(0x0000A57F00000000 AS DateTime), 2, N'Tuyển Thiết kế HTML', N'thi?t k? HTML boostrap, ch? dô lao d?ng theo lu?t nhà nu?c', N'Bi?t phottoshop, ki nang chuyên môn t?t', N'JobDetail.aspx', 5, 1, 1)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (33, 1020, 3, 4, 2, 2, 3, 3, CAST(0x0000A56700000000 AS DateTime), 11, N'Tuyển kỹ sư Asp.net', N'vavacabiscaincpianscacacava', N'Lalapsasancasncanvonaosnca', N'JobDetail.aspx', 6, 1, 1)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (34, 1020, 4, 5, 2, 2, 1002, 3, CAST(0x0000A56700000000 AS DateTime), 11, N'IT manager', N'1. ÐỀ XUẤT XÂY D?NG VÀ T? CH?C TRI?N KHAI CHI?N LU?C ?NG D?NG CNTT
Nghiên c?u các xu hu?ng công ngh? thông tin trong nu?c cung nhu qu?c t? d? d? xu?t áp d?ng phù h?p tình hình b?nh vi?n
Tham gia d? xu?t chi?n lu?c và chính sách ?ng d?ng Công ngh? thông tin (CNTT), bao g?m H? t?ng Công ngh?, ?ng d?ng gi?i pháp vào các ho?t d?ng c?a b?nh vi?n
T? ch?c tri?n khai các Chuong trình/D? án CNTT t?i B?nh vi?n và các co s? phòng khám
- Rà soát, s?a d?i chính sách ?ng d?ng CNTT cho phù h?p v?i t?ng th?i k? và chính sách c?a T?p doàn

2. NGHIÊN C?U, TU V?N VÀ XÂY D?NG GI?I PHÁP ?NG D?NG CNTT
Tìm hi?u, dánh giá kh? thi ?ng d?ng CNTT cho các ho?t d?ng.
Làm vi?c v?i các nhà cung ?ng xây d?ng gi?i pháp ?ng d?ng CNTT.
Ðánh giá d?nh k? các công c?, gi?i pháp, rà soát các h? th?ng thông tin và quy trình hi?n có.
- Ph?i h?p v?i các don v? tìm hi?u, phân tích các ho?t d?ng c?a doanh nghi?p nh?m m?c tiêu tin h?c hóa.

3. Ð?M B?O HO?T Ð?NG ?N Ð?NH, HI?U QU? C?A CÁC H? TH?NG THÔNG TIN HI?N CÓ
T? ', N'-	T?t nghi?p d?i h?c CNTT
-	Có ít nh?t 05 nam kinh nghi?m tri?n khai các h? th?ng ph?n m?m & các gi?i pháp ph?n m?m qu?n lý doanh nghi?p t?ng th? ho?c ERP
-	Có ít nh?t 05 nam kinh nghi?m làm vi?c v?i h? qu?n tr? CSDL MS SQL/Oracle, …
-	Có ít nh?t 03 nam kinh nghi?m làm vi?c v?i 01 ngôn ng? l?p trình: VB; .Net; l?p trình website
-	Ch? d?ng, sáng t?o, có ý th?c k? lu?t cao, kh? nang ch?u áp l?c công vi?c và tinh th?n làm vi?c nhóm
-	Thái d? làm vi?c nghiêm túc, có trách nhi?m
-	Có hi?u bi?t v? các h? th?ng thanh toán, k? toán h?ch toán
-	Thông th?o ti?ng Anh trong các k? nang nghe nói d?c vi?t', N'JobDetail.aspx', 6, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (35, 1020, 4, 6, 2, 2, 1002, 3, CAST(0x0000A56700000000 AS DateTime), 11, N'IT General manager', N'1. Ð? XU?T XÂY D?NG VÀ T? CH?C TRI?N KHAI CHI?N LU?C ?NG D?NG CNTT
Nghiên c?u các xu hu?ng công ngh? thông tin trong nu?c cung nhu qu?c t? d? d? xu?t áp d?ng phù h?p tình hình b?nh vi?n
Tham gia d? xu?t chi?n lu?c và chính sách ?ng d?ng Công ngh? thông tin (CNTT), bao g?m H? t?ng Công ngh?, ?ng d?ng gi?i pháp vào các ho?t d?ng c?a b?nh vi?n
T? ch?c tri?n khai các Chuong trình/D? án CNTT t?i B?nh vi?n và các co s? phòng khám
- Rà soát, s?a d?i chính sách ?ng d?ng CNTT cho phù h?p v?i t?ng th?i k? và chính sách c?a T?p doàn

2. NGHIÊN C?U, TU V?N VÀ XÂY D?NG GI?I PHÁP ?NG D?NG CNTT
Tìm hi?u, dánh giá kh? thi ?ng d?ng CNTT cho các ho?t d?ng.
Làm vi?c v?i các nhà cung ?ng xây d?ng gi?i pháp ?ng d?ng CNTT.
Ðánh giá d?nh k? các công c?, gi?i pháp, rà soát các h? th?ng thông tin và quy trình hi?n có.
- Ph?i h?p v?i các don v? tìm hi?u, phân tích các ho?t d?ng c?a doanh nghi?p nh?m m?c tiêu tin h?c hóa.

3. Ð?M B?O HO?T Ð?NG ?N Ð?NH, HI?U QU? C?A CÁC H? TH?NG THÔNG TIN HI?N CÓ
T? ch?c d?m b?o h? t?ng và h? th?ng thông tin ho?t d?ng thông su?t và an toàn.
Xây d?ng phuong án s?a l?i, c?p nh?t ph?n m?m k?p th?i và ph?c h?i h? th?ng sau s? c?.
Báo cáo d?nh k? ho?t d?ng c?a h? th?ng CNTT t?i lãnh d?o Công ty và theo yêu c?u c?a T?p doàn (ngành d?c).

4. XÂY D?NG H? TH?NG QUY TRÌNH, QUY Ð?NH, HU?NG D?N S? D?NG H? TH?NG THÔNG TIN
Ð? xu?t, ki?n ngh? ho?c ch? trì xây d?ng, c?i ti?n tài li?u h? th?ng qu?n tr? c?a b?nh vi?n liên quan d?n linh v?c Công ngh? thông tin (IT) (chính sách, quy ch?, quy d?nh, quy trình, tiêu chu?n,..).
Xây d?ng các tài li?u, s? tay, quy trình, quy d?nh, hu?ng d?n s? d?ng h? th?ng thông tin, dào t?o ngu?i s? d?ng tru?c khi tri?n khai các h? th?ng thông tin m?i ho?c nâng c?p h? th?ng hi?n có.
Rà soát, c?p nh?t các quy d?nh, quy trình s? d?ng h? th?ng thông tin nh?m dem l?i ti?n l?i, hi?u qu? hon cho ngu?i s? d?ng.

5. Ð?M B?O AN NINH AN TOÀN THÔNG TIN DOANH NGHI?P
Xây d?ng các công c? d?m b?o các h? th?ng thông tin c?a doanh nghi?p du?c an toàn, b?o m?t.
Xây d?ng chính sách, hu?ng d?n ngu?i dùng b?o v? thông tin tru?c các t?n công, ph?n m?m d?c h?i.
Ð?m b?o th?c thi và tuân th? v? an ninh và an toàn h? th?ng thông tin T?p doàn và co s?.

6. VAI TRÒ QU?N LÝ
Ðánh giá, tuy?n d?ng nhân viên
Phân công và giám sát th?c hi?n
Qu?n lý, dánh giá thông qua xây d?ng và th?c hi?n KPI
Ðào t?o và d? xu?t dào t?o nhân viên
K?t n?i nhân viên

7. VAI TRÒ CHUYÊN GIA
Tu v?n h? tr? cho BLÐ trong vi?c xác d?nh các chi?n lu?c CNTT, h? th?ng tin h?c hóa.
Tu v?n h? tr? v? chính sách, và quy trình, giám sát ho?t d?ng trong linh v?c du?c giao', N'-	T?t nghi?p d?i h?c CNTT
-	Có ít nh?t 05 nam kinh nghi?m tri?n khai các h? th?ng ph?n m?m & các gi?i pháp ph?n m?m qu?n lý doanh nghi?p t?ng th? ho?c ERP
-	Có ít nh?t 05 nam kinh nghi?m làm vi?c v?i h? qu?n tr? CSDL MS SQL/Oracle, …
-	Có ít nh?t 03 nam kinh nghi?m làm vi?c v?i 01 ngôn ng? l?p trình: VB; .Net; l?p trình website
-	Ch? d?ng, sáng t?o, có ý th?c k? lu?t cao, kh? nang ch?u áp l?c công vi?c và tinh th?n làm vi?c nhóm
-	Thái d? làm vi?c nghiêm túc, có trách nhi?m
-	Có hi?u bi?t v? các h? th?ng thanh toán, k? toán h?ch toán
-	Thông th?o ti?ng Anh trong các k? nang nghe nói d?c vi?t', N'JobDetail.aspx', 11, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2043, 1023, 3, 2, 2, 2, 1002, 3, CAST(0x0000A57E00000000 AS DateTime), 2, N'Nhân Viên Kinh Doanh (sales Representatives) - HANOI', N'Chúng tôi đang tìm kiếm ứng viên cho Vị trí Nhân viên kinh doanh làm việc tại Hà Nội

Ứng viên được lựa chọn sẽ mở ra cơ hội lớn để có một thu nhập cao và các quyền lợi hấp dẫn khác. Ngoài ra, ứng viên sẽ được làm việc trong một môi trường quốc tế năng động là bước đệm cho sự phát triển nghề nghiệp và bản thâ', N'- Xây dựng và duy trì hệ thống khách hàng của riêng cá nhân và theo nhóm
- Thực hiện các buổi thuyết trình, giới thiệu sản phẩm, mô hình nghỉ dưỡng tại ALMA
- Thực hiện và quản lý các giao dịch bán hàng
- Cung cấp dịch vụ tư vấn, chăm sóc Khách hàng
- Kết hợp với các bộ phận Truyền thông, Marketing thực hiện các kế hoạch quảng bá, giới thiệu Dịch vụ. 
', N'JobDetail.aspx', 30, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2044, 1023, 2, 2, 2, 2, 2, 7, CAST(0x0000A57400000000 AS DateTime), 40, N'Nhân Viên An Ninh - HANOI', N'Đảm bảo an ninh cho toàn nhà, PhamViet Tower 24/24', N'Khoe Mạnh Không mắc các bệnh lý mãn tính.....', N'JobDetail.aspx', 20, 1, 1)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2045, 1024, 2, 2, 2, 2, 1003, 2, CAST(0x0000A56900000000 AS DateTime), 23, N'.Net Developer', N'-	Architect & develop .NET software solutions
-	Contribute to the development of tools that make using the product easier
-	Able to work independently or in a team environment
-	Work as a part of a global IT Team incl. travellin', N'***Qualifications and Requirements
-	Minimum 3 years in .NET development
-	Microsoft Server / MSSQL / Visual Studio
-	Entity Framework, ASP.NET C# (Required)

***Development
-	Good knowledge of agile software development (like Scrum or kanban)

***General
-	Fluent in written and spoken English
-	Willingness to travel
-	Be a team player, professional, proficient and motivate', N'JobDetail.aspx', 10, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2046, 1025, 2, 2, 2, 2, 2, 3, CAST(0x0000A57300000000 AS DateTime), 2, N'Business Development Manager', N'The Business Development Manager is responsible for driving the growth and longevity of DEK Technologies through the identification, development and successful acquisition of new business opportunities.

By joining our team, you will be accountable for:

-	Formulating and contributing to objectives around Customer Diversity
-	Bringing fresh business concepts and proposals 
-	Developing and managing sales strategies
-	Prospecting and marketing to new customers
-	Establishing initial relationships and managing the sales process
-	Accurately forecasting the sales pipeline', N'A minimum 3 years of experience in business development in technology sector.

-	A proven track record of generating revenue through new sales prospecting and customer development
-	A strong background with the information technology sector
-	Ability to drive the sales process, identifying opportunities, qualifying leads, providing quotes, making presentations and closing sale
-	Excellent in both English and Vietnamese
-	Passionate to develop career in a professional and multicultural work environment 
-	Proactive and positive with good communication skills', N'JobDetail.aspx', 10, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2047, 1026, 2, 2, 2, 2, 2, 3, CAST(0x0000A57E00000000 AS DateTime), 2, N'Kỹ Sư Lập Trình / Tuyển Gấp / Mức Lương Hấp Dẫn', N'Ứng viên vào link dưới để lấy mẫu CV xin việc:

http://www.vasc.com.vn/recruitment/job-detail/tuyen-dung-10-ky-su-lap-trinh/6

* Mô tả công việc
- Phát triển các sản phẩm dịch vụ trên nền web như: Cổng thông tin giải trí tổng hợp Media, MobileTV, 2!Chat,...
- Phát triển dịch vụ trên nền tảng SMS
- Phát triển các dịch vụ trên nền thoại như: tổng đài 1800:1255, 1900:1762, ..
- Phát triển các sản phẩm ứng dụng, game trên Mobile
- Phát triển các ứng dụng trên các thiết bị Smart TV
- Phát triển các ứng dụng phục vụ nhu cầu quản lý của trung tâm, công ty
- Thực hiện các yêu cầu công việc khác khi có yêu cầu

* Quyền lợi
- Hưởng đầy đủ các chính sách theo đúng Luật Lao động
- Môi trường làm việc thân thiện, có các hoạt động ngoại khóa vui chơi giải trí
- Thường xuyên cập nhật công nghệ mới, hỗ trợ học tập nâng cao kỹ năng
- Ngoài lương cơ bản, công ty có chính sách hỗ trợ tiền thưởng theo thâm niên, theo dự án, theo thời gian làm việc ngoài giờ và thưởng cuối năm.
- Có chính sách ưu tiên cho những nhân viên gắn bó lâu dài', N'1.	Yêu cầu chuyên môn
- Tốt nghiệp đại học chính quy chuyên ngành ĐTVT, CNTT hoặc tương đương. Sinh viên ĐHBK, ĐHQG năm cuối đáp ứng chuyên môn cũng có thể tham dự tuyển
- Có kỹ năng lập trình thành thạo 1 trong các ngôn ngữ Java hoặc C, C++
- Có tư duy về thiết kế, xây dựng hệ thống
- Sử dụng, đọc hiểu tốt các tài liệu kỹ thuật tiếng Anh

2.	Yêu cầu khác
- Nhiệt huyết, chủ động, sáng tạo trong công việc, có khả năng chịu áp lực công việc cao
- Có khả năng nắm bắt, tự học hỏi và nghiên cứu kỹ thuật & công nghệ mới
- Tư duy logic, xử lý vấn đề & thuật toán tốt
- Có khả năng làm việc độc lập và làm việc nhóm, ham học hỏi Chịu được áp lực công việc
- Khả năng làm việc theo nhóm và độc lập

3.	Ưu tiên
- Tốt nghiệp ĐHBK và ĐH Quốc Gia 
- Các ứng viên tốt nghiệp loại Giỏi và xuất sắc; đạt các giải thưởng quốc gia và quốc tế, tham gia Nghiên cứu khoa học/ Làm thí nghiệm tại các phòng Lab đặc biệt là các ứng viên có kinh nghiệm trong lĩnh vực liên quan
- Ưu tiên ứng viên có các chứng chỉ lập trình quốc tế
- Có kinh nghiệm tham gia phát triển các hệ thống phần mềm liên quan đến viễn thông
- Có kiến thức, kinh nghiệm quản trị trên các hệ quản trị cơ sở dữ liệu: MySQL, Oracle hoặc SQL Server
- Có kiến thức về các hệ thống viễn thông, di động, truyền hình
- Ngoại ngữ: có chứng chỉ TOEIC, TOEFL hoặc IELTS tương đương với điểm TOEIC – 500 điểm trở lên
', N'JobDetail.aspx', 9, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2048, 1027, 3, 2, 3, 2, 2, 3, CAST(0x0000A57F00000000 AS DateTime), 2, N'Technical Sales Engineer (with Strong Experience In Selling Industrial Equipments/spare Parts)', N'MAIN PURPOSE
•	Responsible for Technical Sales & Service Portfolio development of Processing Equipment and Solution Department
•	Market penetration
•	Setting the objectives doing sales planning and action.

RESPONSIBILITY

1.	Actively Selling of Technical Sales and Service Portfolio (Spare Part products, Plant Components, Upgrades, Maintenance Service).
2.	Contact new and existing customers and manage relationship with existing customers
3.	Identify needs and qualifying opportunities with customers to obtain a quote request for products within Tetra Pak’s Technical Sales & Service Portfolio
4.	Select and present products and solutions, make quotes
5.	Negotiate and secure orders for our portfolio
6.	Achieving preset sales goals', N'•	University Degree in or Mechanical and or Automation / Electrical Engineering
•	3-5 years technical sales experience in relevant fields and preferably in Food/ Beverage Industries
•	Good command of English 
•	Frequent travel is required
•	Good in using office software such as MS Excel, Word, Power-point', N'JobDetail.aspx', 4, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2049, 1026, 3, 5, 2, 2, 2, 3, CAST(0x0000A57800000000 AS DateTime), 23, N'Cần Tuyển 5 Lập Trình Viên Java', N'Làm việc theo lịch của nhà nước, hỗ trợ đưa đón đến nơi làm việc', N'Biết Java, JSP,JavaScript...', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2050, 1026, 2, 2, 2, 2, 2, 2, CAST(0x0000A57D00000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java', N'abc test ', N'demo', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2051, 1026, 2, 2, 2, 2, 2, 2, CAST(0x0000A56300000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java', N'abc test ', N'demo', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2052, 1026, 2, 2, 2, 2, 2, 2, CAST(0x0000A56300000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java', N'abc test ', N'demo', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2053, 1026, 2, 2, 2, 2, 2, 2, CAST(0x0000A56300000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java', N'abc test ', N'demo', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2054, 1026, 2, 2, 2, 2, 2, 2, CAST(0x0000A56300000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java', N'abc test ', N'demo', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2055, 1017, 3, 2, 2, 4, 2, 7, CAST(0x0000A54900000000 AS DateTime), 40, N'Cần Tuyển 15 Nhân viên bảo vệ toàn nhà', N'demo', N'demo', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2056, 1017, 3, 2, 2, 4, 2, 7, CAST(0x0000A54900000000 AS DateTime), 40, N'Cần Tuyển 15 Nhân viên bảo vệ toàn nhà', N'demo', N'demo', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2057, 1017, 3, 2, 2, 4, 2, 7, CAST(0x0000A54900000000 AS DateTime), 40, N'Cần Tuyển 15 Nhân viên bảo vệ toàn nhà', N'demo', N'demo', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2058, 1017, 3, 2, 2, 4, 2, 7, CAST(0x0000A54900000000 AS DateTime), 40, N'Cần Tuyển 15 Nhân viên bảo vệ toàn nhà', N'demo', N'demo', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2059, 1017, 3, 2, 2, 4, 2, 7, CAST(0x0000A54900000000 AS DateTime), 40, N'Cần Tuyển 15 Nhân viên bảo vệ toàn nhà', N'demo', N'demo', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2060, 1017, 2, 2, 2, 2, 2, 2, CAST(0x0000A55B00000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java demo', N'fasfas', N'fasf', N'JobDetail.aspx', 15, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2061, 1017, 2, 2, 2, 2, 2, 2, CAST(0x0000A55B00000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java demo', N'fasfas', N'fasf', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2062, 1017, 2, 2, 2, 2, 2, 2, CAST(0x0000A55B00000000 AS DateTime), 2, N'Cần Tuyển 5 Lập Trình Viên Java demo', N'fasfas', N'fasf', N'JobDetail.aspx', 15, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2063, 3037, 2, 2, 2, 2, 2, 2, CAST(0x0000A54E00000000 AS DateTime), 2, N'Tuyên 5 cố vấn COC', N'test', N'tesst', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2064, 3037, 2, 2, 2, 2, 2, 2, CAST(0x0000A54500000000 AS DateTime), 2, N'Tuyên 5 cố vấn WAR', N'test', N'test', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2065, 3037, 2, 2, 2, 2, 2, 2, CAST(0x0000A54500000000 AS DateTime), 2, N'Tuyên 5 cố vấn WAR', N'test', N'test', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2066, 3037, 2, 2, 2, 2, 2, 2, CAST(0x0000A54500000000 AS DateTime), 2, N'Tuyên 5 cố vấn WAR', N'test', N'test', N'JobDetail.aspx', 5, 0, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2067, 3037, 2, 2, 2, 2, 2, 2, CAST(0x0000A57200000000 AS DateTime), 2, N'Cần Tuyển 5 Cố vấn Lập Trình Viên Android', N'test', N'test', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2068, 3023, 2, 2, 2, 2, 2, 2, CAST(0x0000A57F00000000 AS DateTime), 2, N'Cán Bộ Tư Vấn Tài Chính Cấp Cao', N'What You Will Do
+ Số lượng tuyển dụng: 30 cán bộ, chi tiết theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

I. Phạm vi tuyển dụng: ngoài hệ thống BIDV

II. Về mô tả vị trí công việc và tiêu chuẩn tuyển dụng: chi tiết theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

III. Thu nhập: được hưởng lương, thưởng và các cơ chế khuyến khích hấp dẫn theo kết quả hoạt động kinh doanh
', N'What You Are Good At
I. Hình thức tuyển dụng: sơ loại hồ sơ và phỏng vấn trực tiếp

II. Hồ sơ dự tuyển: chi tiết hồ sơ yêu cầu theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

III. Thời gian, địa điểm nhận hồ sơ
+ Thời gian: từ ngày 01/12/2015 đến hết ngày 31/12/2015 (hoặc đến khi thu đủ số lượng hồ sơ theo yêu cầu);
+ Cách thức nộp hồ sơ: Hồ sơ ứng tuyển của mỗi ứng viên bao gồm 1file pdf và 1 file excel (PL2 – tóm tắt trích ngang lý lịch cán bộ), gửi email 

(Hội đồng tuyển dụng chỉ liên hệ với các ứng viên đạt yêu cầu tại vòng sơ tuyển hồ sơ)
Ngân hàng TMCP Đầu tư và Phát triển Việt Nam trân trọng thông báo./.', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2069, 3023, 5, 4, 2, 2, 1002, 3, CAST(0x0000A57F00000000 AS DateTime), 32, N'Cán Bộ Tư Vấn Tài Chính', N'What You Will Do
+ Số lượng tuyển dụng: 30 cán bộ, chi tiết theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

I. Phạm vi tuyển dụng: ngoài hệ thống BIDV

II. Về mô tả vị trí công việc và tiêu chuẩn tuyển dụng: chi tiết theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

III. Thu nhập: được hưởng lương, thưởng và các cơ chế khuyến khích hấp dẫn theo kết quả hoạt động kinh doanh', N'What You Are Good At
I. Hình thức tuyển dụng: sơ loại hồ sơ và phỏng vấn trực tiếp

II. Hồ sơ dự tuyển: chi tiết hồ sơ yêu cầu theo thông tin tuyển dụng đăng tải trên website: http://tuyendung.bidv.com.vn/Views/NewsWork/co-hoi-nghe-nghiep.aspx 

III. Thời gian, địa điểm nhận hồ sơ
+ Thời gian: từ ngày 01/12/2015 đến hết ngày 31/12/2015 (hoặc đến khi thu đủ số lượng hồ sơ theo yêu cầu);
+ Cách thức nộp hồ sơ: Hồ sơ ứng tuyển của mỗi ứng viên bao gồm 1file pdf và 1 file excel (PL2 – tóm tắt trích ngang lý lịch cán bộ), gửi email 

(Hội đồng tuyển dụng chỉ liên hệ với các ứng viên đạt yêu cầu tại vòng sơ tuyển hồ sơ)
Ngân hàng TMCP Đầu tư và Phát triển Việt Nam trân trọng thông báo./.', N'JobDetail.aspx', 30, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2070, 3024, 2, 5, 3, 2, 1002, 3, CAST(0x0000A57F00000000 AS DateTime), 12, N'Nhân Viên Bảo Trì, Kỹ Thuật Sản Xuất', N'What You Will Do
Do mở rộng sản xuất, chúng tôi cần tuyển 15 vị trí nhân viên KỸ THUẬT cho nhà máy sản xuất Máy ảnh KTS, thiết bị Y tế và máy ghi âm. Các bạn sẽ:


- Thực hiện nghiệp vụ chuyển giao sản phẩm từ công ty Olympus Nhật Bản sang Olympus Việt Nam,

- Thiết kế, lắp đặt và cải tiến công đoạn sản xuất,

- Tìm lỗi và đưa ra giải pháp khắc phục lỗi sản phẩm,

- Thiết lập quy trình sản xuất sản phẩm mới,

- Làm thử, kiểm tra đánh giá sản phẩm mới,

- Quản lý và cải tiến thiết bị sản xuất.

* Làm việc tại Khu công nghiệp Long Thành, Đồng Nai


*** Các chính sách phúc lợi của công ty: 

- Lương cạnh tranh, 

- Thưởng thâm niên 3 năm, 5 năm, 10 năm; Thưởng tái ký hợp đồng lao động;

- Trợ cấp tiếng Nhật cho nhân viên có chứng chỉ JLPT từ trình độ N4, N3, N2, N1 hoặc tiếng Anh TOEIC 600 điểm trở lên; Hoặc tiếng Hoa HSK;

– Chế độ trợ cấp hấp dẫn (chỗ ở, đi lại, …)

- Làm việc từ Thứ Hai đến thứ Sáu hàng tuần, và một ngày Thứ Bảy trong tháng;

- Chính sách phúc lợi tốt;

- Có cơ hội đào tạo và làm việc ở nước ngoài;

- Xe đưa rước nhân viên cư ngụ tại TP.HCM, Biên Hòa, Trảng Bom, Phước Thái;

- Thời gian làm việc 08 giờ/ ngày', N'What You Are Good At
- Nam/ Nữ, Tuổi từ 25 đến 40.

- Tốt nghiệp Đại học các chuyên nghành có liên quan về kỹ thuật công nghiệp như Cơ khí, điện, điện tử;

- Đọc hiểu được bản vẽ kỹ thuật

- Ưu tiên có kinh nghiệm 5S, IE tool, Lean (TPS), thiết kế lắp đặt và cải tiến chuyền sản xuất.

- Ưu tiên có kinh nghiệm về nghiệp vụ chuyển giao sản phẩm từ các công ty ở nước ngoài về Việt Nam.

- Có kinh nghiệm phân tích, khắc phục lỗi trong sản xuất.

- Ưu tiên có kinh nghiệm về quản lý hiện trường sản xuất.

- Có thể đi đào tạo, làm việc ở nước ngoài khi được yêu cầu;

- Có thể làm việc theo ca;

- Tiếng Nhật trình độ N3 ~ N1;

- Ưu tiên ứng viên đang sinh sống ở Long Thành, Biên Hòa - Đồng Nai;

- Vui lòng gởi CV bằng file PDF hoặc Word dưới 3Mb


(JapanWorks)
japanesebeginner, n03level, n02level
151125, 151126, 151127', N'JobDetail.aspx', 15, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2071, 3025, 3, 4, 63, 2, 3, 3, CAST(0x0000A57E00000000 AS DateTime), 21, N'02 Nhân Viên Kỹ Thuật Vùng - Đồng Tháp - Vĩnh Long', N'**** CÔNG VIỆC CHÍNH

- Lập kế hoạch hội thảo kỹ thuật, hội thảo bán hàng, hội thảo đầu bờ hàng tháng để thông qua vùng, phụ trách kỹ thuật vùng, bộ phận kỹ thuật.
- Hỗ trợ về chuyên môn kỹ thuật cho nhân viên bán hàng trên địa bàn.
- Thực hiện các demo, hội thảo đầu bờ, tư vấn nông dân.
- Tổ chức các buổi sinh hoạt câu lạc bộ nông dân toạ đàm 
- Phối hợp cùng nhân viên bán hàng trên địa bàn xây dựng kế hoạch hỗ trợ bán hàng cho đại lý
- Giải quyết và tư vấn nông dân khi gặp các vấn đề về sử dụng sản phẩm .


**** CÔNG VIỆC KHÁC
- Kết hợp các phòng và cơ quan chuyên môn thực hiện các khảo nghiệm sản phẩm
- Làm việc với các cơ quan chuyên môn khi được yều cầu.
- Hỗ trợ kỹ thuật cho 1 số vùng khi được bộ phận kỹ thuật và ban Giám đốc yêu cầu.', N'**** BĂT BUỘC
- Kỹ sư Nông học hoặc bảo vệ thực vật, trồng trọt
-Từ 3-5 năm kinh nghiệm trong lĩnh kỹ thuật cây trồng và thuốc BVTV
-Kinh nghiệm thuyết trình về chuyên môn thuốc BVTV trước đám đông
-Có kinh nghiệm chuyên môn về cây lúa, cây ăn trái, rau màu


**** KỸ NĂNG
- Thông thạo vi tính văn phòng: Word, Excel, PowerPoint
- Nhiệt tình, năng động, trách nhiệm trong công việc, có khả năng giao tiếp tốt với các đồng nghiệp.
- Có khả năng và làm việc độc lập
- Biết tiếng Anh là lợi thế

**** ƯU TIÊN
- Đã từng làm việc ở các công ty đa quốc gia, công ty có vốn đầu tư nước ngoài.', N'JobDetail.aspx', 2, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2072, 3026, 4, 6, 2, 2, 1002, 3, CAST(0x0000A57D00000000 AS DateTime), 23, N'iOS, Java Developer', N'* iOS developer (Minimum 2 years experience)
• Knowledge of RESTful, JSON

* Java developer (Minimum 2 years experience)
• Experience with HTML, JavaScript, and JSP is a must
• Knowledge of JavaScript, Spring, MVC or Hibernate is an advantage', N'Minimum 2 years experience working with Java-related technologies or (object-C) in web-based programming and problem-solving

• Strong in Git and Maven
• Experience with Scrum methodologies
• Strong soft skills: group discussion, teamwork, presentations.', N'JobDetail.aspx', 15, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2073, 3027, 3, 2, 2, 2, 3, 3, CAST(0x0000A57F00000000 AS DateTime), 17, N'Biên Phiên Dịch Tiếng Nhật Và Hỗ Trợ Dự Án', N'***Nội dung công việc:
•	Biên dịch các tài liệu dự án, tài liệu chuyên ngành, biên dịch hồ sơ xin cấp phép,…
•	Phiên dịch dự án (Phiên dịch hội nghị, phiên dịch hiện trường,...)
•	Tham gia các công việc khác liên quan đến dự án như: điều tra thông tin, hỗ trợ liên lạc với các bên liên quan,...
•	Phân tích, tra cứu và đề xuất giải quyết các yêu cầu của khách hàng (liên quan đến các dự án kinh doanh, đầu tư)
•	Thực hiện các chuẩn bị cần thiết khi có đoàn công tác (đặt phòng khách sạn, nhà hàng, xe di chuyển, in ấn…).
•	Liên lạc với các cơ quan liên quan, đối tác.
•	Liên lạc và quản lý chất lượng của các nhà cung cấp, liên lạc với công ty mẹ tại Tokyo về các vấn đề nội bộ (sử dụng tiếng Nhật).

***Chế độ đào tạo:
•	Được đào tạo một cách căn bản về chuyên ngành liên quan đến tài liệu dịch.
•	Các tác phẩm biên dịch được kiểm tra trực tiếp với biên dịch người nhật có 20 năm kinh nghiệm biên, phiên dịch 
•	Được kiến tập các buổi tọa đàm, hội nghị,.. .có dịch song song 
•	Được đào tạo kỹ năng điều tra thông tin, tiếp xúc khách hàng…
•	Được đào tạo cụ thể về các hệ thống của công ty (như nhập chi phí, hệ thống quản lý lịch làm việc, …).

***Chế độ làm việc:
•	Địa điểm làm việc: Tầng 12, Tòa nhà BIDV, 194 Trần Quang Khải, Hoàn Kiếm, Hà Nội.
•	Thời gian làm việc: : 8:00 ~ 17:00, từ thứ hai đến thứ sáu. Có thể làm ngoài giờ tùy theo yêu cầu công việc. Thời gian làm thêm được trả lương đầy đủ theo Luật lao động và được tính chi tiết từng 5 phút.
•	Các chế độ: Các loại bảo hiểm xã hội, bảo hiểm y tế, ngày nghỉ theo luật định. Ngoài ra còn có bảo hiểm tai nạn lao động, một số phúc lợi xã hội cho nhân viên như hỗ trợ chi phí đi lại, du lịch Công ty...

***Lương và thưởng:
- Lương: 600 USD đến 800 USD (NET) tùy theo năng lực và mức độ đáp ứng công việc.
- Thưởng: Điều chỉnh hằng năm theo năng lực thực tế', N'- Tiếng nhật linh hoạt, vốn từ sâu rộng, (trình độ tương đương N1), biết tiếng Anh là một lợi thế.
- Tiếng Việt tốt, hành văn trôi chảy, dễ hiểu.
- Năng động, chủ động, làm việc nhóm hiệu quả,
- Bằng cấp: Tốt nghiệp đại học trở lên

***Lưu ý:
Hồ sơ lý lịch (CV) thể hiện đầy đủ những KINH NGHIỆM, NĂNG LỰC phù hợp với yêu cầu của công việc. (Các bằng cấp chỉ cần bản sao, KHÔNG cần công chứng)



(JapanWorks)
n01level
151126, 151127, 151128', N'JobDetail.aspx', 1, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2074, 3029, 2, 5, 2, 2, 1002, 3, CAST(0x0000A57F00000000 AS DateTime), 23, N'Sale Manager { Attractive Salary – Urgent }', N'We are looking for Sales Manager (Vietnamese) for our massive Holiday Ownership project. This position is to hold very important role in the Sale process of the Company, which can differ from training, sales management, sales strategy planning, sales quality control, sales system consultancy, sales evaluation for a sales system that he/she will be trained very intensively. Main job includes: 

-	Develop and lead the sales team of around 10 sales force to achieve the Sales targets 
-	Provide strong leadership and motivation to the team members
-	Monitor and supervise the Sales production & activities
- Coordinate with Marketing Department to build high quality potential customer base
- Train sales force as daily task 
- Involve in sales process including negotiating, decision making 
- Practice Company rules, ethics and personnel management to direct staffs 
- Direct report to Director of Sales', N'Job Requirements: 

- Vietnamese

- At least 3 year - experienced in Sales Management position with Proven records is a must.

- Preferred experience in Direct Sales

- Result and high income oriented 

- Can work under very high pressure

- Good command of English is a MUST

- Strong determination and self-motivated to success

- Self-confident and strong personality, Well-presented. 

- Strong management, leadership skills with capability to manage, coach and motivate a team of salespeople. 

- Excellent communication & negotiation skills 

- Excellent problem solving skills 

- Able to work under pressure and handle problems 

- Candidates experienced working in a sales environment with a can-do and positive attitude, commercial mind and belief in “working hard, playing hard, thinking different” 

Benefits:
- Competitive salary and attractive commission scheme & bonuses 
- Opportunity for professional training & development (professional before job training with foreign expert in the industry) 
- Opportunity for overseas travel 
- Opportunity to work in an exciting sales environment and form a successful career path 


Application: 
- In English, With Photo', N'JobDetail.aspx', 2, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2075, 3030, 3, 5, 25, 2, 3, 3, CAST(0x0000A57F00000000 AS DateTime), 2, N'Nhân Viên Logistics', N'- Đưa ra phương án nhập/xuất đảm bảo thời hạn và số lượng hàng nhập/xuất dựa vào đơn đặt hàng, kế hoạch xuất hàng; Liên lạc với nhà cung cấp/khách hàng và dịch vụ vận chuyển về thông tin hàng nhập/hàng xuất.

- Chuẩn bị chứng từ, các giấy tờ cần thiết cho việc nhập/xuất hàng; thông quan hàng nhập/hàng xuất.

- Phối hợp với các bộ phận lập kế hoạch nhập/xuất hàng; kiểm soát hàng nhập/xuất đảm bảo thời hạn, số lượng, chất lượng, quy chuẩn.

- Giải quyết các vấn đề phát sinh liên quan đến quá trình xuất/nhập khẩu: thời hạn giao nhận, số lượng, chất lượng, quy chuẩn

- Giao dịch, làm báo cáo định kì và thủ tục thanh khoản cho cơ quan Hải quan;

- Cập nhật và tuân thủ các quy định hiện hành về xuất nhập khẩu

- Nhập và kiểm soát dữ liệu xuất nhập đưa vào hệ thống quản trị phần mềm; Thông báo với phòng kế toán về hàng nhập/ hàng xuất

- Quản lý, lưu trữ hồ sơ liên quan đến việc xuất nhập khẩu.', N'- Tuổi từ 25-35.
- Trình độ Đại học trở lên, chuyên ngành ngoại thương, Marketing, Quản trị kinh doanh các trường Đại học Ngoại Thương…
- Kiến thức về quản lý điều hành bao gồm các nguyên tắc và quy trình về lập kế hoạch, tổ chức, điều hành, phối hợp trong kinh doanh và hoạt động Logisitcs, kiến thức về Luật kinh tế, các quy phạm pháp luật và Quy định các cơ quan hữu quan liên quan đến hoạt động kinh doanh của Công ty.
- Am hiểu hoạt động kinh doanh và các nghiệp vụ Marketing thuộc các lĩnh vực hoạt động của Công ty.
- Tiếng Anh thành thạo (Có khả năng đàm phán, thương lượng, thuyết phục và soạn thảo hợp đồng bằng tiếng Anh). Trình độc C Anh văn hoặc tương đương.
- Ít nhất 03 năm kinh nghiệm công tác trong lĩnh vực Logistics, Kho vận tại các công ty nước ngoài.

* Nộp hồ sơ
- Đơn xin việc viết tay bằng tiếng Việt và tiếng Anh có dán hình.
- Nộp tại địa chỉ: Km1+900, Quốc lộ 51, Phường Long BÌnh Tân, Tp. Biên Hỏa, Tỉnh Đồng Nai.', N'JobDetail.aspx', 4, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2076, 3031, 2, 5, 43, 2, 1002, 3, CAST(0x0000A57F00000000 AS DateTime), 2, N'Chuyên Viên Kinh Doanh (Thanh Hoá, Nghệ An, Hà Tĩnh, Quảng Bình)', N'***Trao đổi chi tiết trong quá trình phỏng vấn', N'***Yêu cầu chung: 
-	Độ tuổi: Dưới 35 tuổi.
-	Yêu cầu về trình độ: Tốt nghiệp Đại học Công lập (Bằng 1), Hệ Chính quy, đúng chuyên ngành kinh tế
-	Trình độ tiếng Anh: Bằng B trở lên hoặc tương đương.
-	Trình độ Tin học: Sử dụng thành thạo tin học văn phòng.
-	Giới tính: ưu tiên ứng viên là nam giới.

***Hình thức thi tuyển
1.	Ưu tiên tuyển dụng theo hình thức 1-Phỏng vấn (Không thi viết): đối với thí sinh học các trường: Đại học Ngoại Thương, Đại học Kinh tế Quốc dân, Đại học Bách Khoa Hà Nội, Học viện Tài chính, Học viện Công nghệ Bưu chính viễn thông.
-	Tốt nghiệp loại giỏi trở lên, đúng chuyên ngành (Bằng 1).
Hoặc:
-	Có bằng Thạc sỹ trở lên (đúng chuyên ngành). Đồng thời tốt nghiệp Đại học loại khá trở lên và có ít nhất 02 năm kinh nghiệm công tác tại Ngành Bưu điện, các Công ty nước ngoài hoặc các Công ty Nhà nước lớn có uy tín.
2.	Đối với thí sinh còn lại: Thi viết và Phỏng vấn (Nội dung thi viết gồm 3 môn: Chuyên ngành, Tiếng Anh và Tin học ứng dụng)

***Yêu cầu về hồ sơ dự tuyển
Tất cả giấy tờ trong hồ sơ được chính quyền địa phương chứng thực trong thời gian không quá 6 tháng tính đến ngày nộp, sắp xếp theo thứ tự sau:
1.	Bìa hồ sơ ghi rõ: vị trí dự tuyển vàtừ 02 đến 03 địa điểm đăng ký làm việc (ưu tiên 1, 2, 3), địa chỉ và số điện thoại liên lạc của ứng viên;
2.	01 Đơn xin dự tuyển viết tay (ghi rõ vị trí thi tuyển, trình độ, quá trình công tác và kinh nghiệm_nếu có);
3.	01 Bản sao (công chứng) Bằng tốt nghiệp Đại học, Thạc sỹ hoặc Giấy chứng nhận tốt nghiệp tạm thời còn hiệu lực; Chứng chỉ tiếng Anh,...;
4.	01 Bản sao (công chứng) Bảng điểm toàn khóa học; 
5.	Giấy tờ chứng nhận kinh nghiệm công tác nếu có (Hợp đồng lao động; các Quyết định nâng lương; Giấy xác nhận của cơ quan,...);
6.	01 Bản gốc Sơ yếu lý lịch có dán ảnh và đóng dấu giáp lai theo quy định;
7.	01 Bản sao (công chứng) giấy chứng nhận sức khoẻ;
8.	01 Bản sao (công chứng) Sổ hộ khẩu, chứng minh thư nhân dân; 
9.	02 ảnh 3x4 mới nhất.

***Nhận hồ sơ
-	Thời hạn nhận hồ sơ: đến hết ngày 15/12/2015.
-	Địa điểm nhận hồ sơ: tại văn phòng MobiFone các tỉnh hoặc Phòng Tổ chức - Hành chính, Công ty Dịch vụ MobiFone Khu vực 6. 
Số 34 đường Nguyễn Sỹ Sách, thành phố Vinh, tỉnh Nghệ An.
-	Hình thức nộp hồ sơ: Nộp trực tiếp hoặc gửi chuyển phát.', N'JobDetail.aspx', 12, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2077, 3032, 2, 6, 2, 2, 2, 3, CAST(0x0000A57F00000000 AS DateTime), 23, N'Web & Graphic Designer', N'- Thiết kế các hạng mục 2D graphic trong sự kiện và truyền thông: backdrop, flyer, banner, invitation card. 

- Thiết kế bộ nhận dạng thương hiệu: logo, brochure, name card, letterhead…

- Thiết kế showroom, booth trưng bày sản phẩm, ... 

- Thiết kế các công trình quảng cáo, bảng hiệu quảng cáo ..

- Có thể thực hiện được những nhiệm vụ của một Website Admin: Update hình ảnh, thông tin mới lên website...

- Phát triển các ý tưởng sáng tạo cho các yếu tố hình ảnh của các chiến dịch quảng cáo.', N'- Có bằng cấp chuyên ngành thiết kế đồ họa

- Tối thiểu 02 năm kinh nghiệm làm việc tại vị trí tương tự 

- Thành thạo các phần mềm thiết kế đồ họa Photoshop, Illustrator, Indesign, Flash, Phần mềm và ngôn ngữ lập trính web.

- Có kiến thức về Thiết kế trải nghiệm người dùng (UX).

- Ưu tiên ứng viên có hiểu biết và khả năng sử dụng các phần mềm xử lý video

- Hiểu biết về Concept Design 2D, biết thêm về 3D là một lợi thế.

- Hiểu về bố cục, màu sắc, Typography cho thiết kế thương hiệu & Marketing

- Có tư duy sáng tạo và óc thẩm mỹ tốt

- Kỹ năng làm việc độc lập và theo nhóm

- Hòa đồng, chia sẻ trong công việc.

- Chịu được áp lực công việc cao 

- Tôn trọng Deadline

Ứng viên cần thêm thông tin chi tiết liên hệ http://www.hellomedia.vn/tuyendung

Nội dung cần có: Portfolio/CVs - Cover letter - Sản phẩm demo - Ảnh đại diện 

Chúng tôi sẽ liên hệ với ứng viên phù hợp trong vòng 24h sau khi nhận hồ sơ.', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2078, 3033, 2, 4, 2, 2, 1003, 3, CAST(0x0000A57F00000000 AS DateTime), 2, N'Sales Operation Manager', N'POSITION SUMMARY
To execute business processes related to sales operation, third party PGs and sales men, and the draught beer team to support the overall sales business.

MAJOR RESPONSIBILITIES
1. Manage sales men
- Select third party agency to administer sales men effectively in coordination with distributors that the sales men appointed to work with.
- Work with RSM/ ASM to define number of sales men needed for each sales area to deliver their owned sales target.
- Involve in sales men recruitment process.
- Coordinate with RSM/ ASM to set up sales target for each sales men.
- Measure the performance of sales men and proactively involve in developing the compensation package for sales men.
- Responsible for the sales men’s payment on time and in full.
- Train sales men on steps of a call.

2. Manage PG
- Selects appropriate agency to supply PGs in line with Heineken procurement procedures.
- Clear KPIs are set for selected agency.
- Manage and control PG recruitment from agency.
- Set operating standard and sales target for PG.
- Analyze and track PG performance to ensure effectiveness of budget.
- Responsible for the PG’s payment on time and in full.
- Train/ coach PG to deliver the agreed targets.

3. Manage the draught beer team
- Manage draught beer expansion plan in nationwide.
- Control draught beer equipment inventory with coordination to Brewery.
- Implement draught beer service control scheme to distributors to ensure high quality service level to customers.', N'- University Degree. Bachelor Degree in any field.
- 4-5 years sales operation, sales or sales management experience.
- Experience in working with external suppliers.
- Brand knowledge.
- Attention to details with good analytical skill.
- Good communication skill and problem solving skill.
- Strong planning, organizational and time management.
- Ability to take initiative and work independently in identifying and meeting business needs.
- Good English.', N'JobDetail.aspx', 2, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2079, 3034, 3, 2, 3, 2, 2, 3, CAST(0x0000A57F00000000 AS DateTime), 15, N'Training Support (Nữ)', N'- Training arrangement
- Document translation
- Training report and record training data
- Other tasks assigned by management', N'- Graduated from college/university specialize in English or Business administration...(Priority for English major)
- Fluently in speaking and writing English
- At least 1 year experienced in working
- Good in Microsoft office (word, excel, power point..)
- Dynamic, well-organized', N'JobDetail.aspx', 5, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2080, 3035, 2, 6, 3, 2, 1003, 3, CAST(0x0000A57F00000000 AS DateTime), 28, N'HRBP Manager', N'•Identify Division needs of HR aspects (HR policy, workforce planning, recruitment, employee relations, training needs etc.) to provide HR practice support timely and efficiently to the Division, to ensure they are fully informed of HR objectives, purposes and achievements as per company strategy and guidelines.
•Recruitment: Be responsibility to recruit right person to right position for in-charge Division.
•Compensation & benefits: Advise in-charge division in compensation & benefits policy & proposal to ensure internal equity, alignment with company guidelines, keep competitive in market.
•Employee Relation & Compliance Provide guidance to in-charge division in case of reward, discipline, grievance solving to comply with legal and company regulation
•HR Communication: Liaise with other managers of the Division to understand, develop and implement all necessary aspects and needs of HR development, and to ensure they are fully informed of HR objectives, purposes and achievements.
•HR Consulting: Provision of timely, quality and consistent HR advice, inputs and support to the management and employees on HR issues and HR implications of business decisions and change.
•HR initiatives Deployment: Assistance in the implementation of HR initiatives that support the business strategy, and effectively translate the broader company HR strategies.
•Involve in other HR projects or tasks as required', N'•At least 5 years HR Management experience
•Experience partnering with managers to deliver HR solutions is preferred
•Ability to work under pressure
•Takes ownership in decisions and actions
•Fluently English & Vietnamese communication & writing

COMPENSATION & BENEFITS
•Professional working environment
•18 annual leaves/year
•AON health care
•Full insurances according to Vietnam''s labour law
•Competitive bonus scheme
•Yearly medical check up


Candidates get interested in the job post, kindly apply to the link: 
http://www.homecredit.vn/en/career', N'JobDetail.aspx', 1, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2081, 3036, 2, 6, 2, 2, 1004, 3, CAST(0x0000A57F00000000 AS DateTime), 26, N'Trưởng Phòng Quản Trị Cơ Sở Vật Chất (Td1511033)', N'1. Mô tả công việc

- Tổ chức thực hiện quản lý tài sản, cơ sở hạ tầng, trang thiết bị, kiểm soát ra vào các văn phòng làm việc của TOPICA.
- Xây dựng các phương án bảo vệ/quản lý tài sản tại các văn phòng, chi nhánh, văn phòng đại diện...
- Định kỳ báo cáo về công tác quản lý tài sản, cơ sở vật chất.
- Xây dựng và tạo mối quan hệ tốt với khách hàng đối tác cung cấp giải pháp cơ sở vật chất, tạo điều kiện thuận lợi cho hoạt động triển khai cung cấp thiết bị, cơ sở vật chất cho công ty.
- Tổ chức công tác kiểm tra, bảo dưỡng thiết bị, cơ sở vật chất định kỳ, đảm bảo cho hoạt động phát triển của công ty diễn ra ổn định.
- Tham gia xây dựng, sửa đổi các quy trình/quy định về công tác bảo vệ, quản lý tài sản.
- Tham gia hoạt động thiết kế, xây dựng văn phòng mới, mở rộng văn phòng ra thị trường Thái Lan, Philipines.
- Chỉ số đánh giá của người được tuyển được đánh giá bằng tỷ lệ hài lòng của khách hàng về cơ sở hạ tầng làm việc.
- Quản lý 20-30 nhân viên cấp dưới.
- Phối hợp với trung tâm tài chính kế hoạch. 
- Phối hợp với các đối tác cung cấp dịch vụ văn phòng, quản lý tòa nhà. 
- Phòng CSCV ở Sài Gòn, Đà Nẵng, Thái Lan...

2. Quyền lợi

2.1. Chế độ đãi ngộ
- Thu nhập cạnh tranh, thưởng đa dạng: Chính sách lương cạnh tranh, tăng lương 2 lần/ năm. Thưởng năng suất; thưởng dự án; thưởng sáng kiến; thưởng tăng tốc; thưởng nóng; thưởng khi nghĩ ra cách thưởng mới…
- Hưởng niềm vui chứ không chỉ phúc lợi: Phi tiêu lãnh đạo, gym, yoga, ghế massage. Quỹ liên hoan. Giờ nghỉ trưa. Nghỉ mát hàng năm. Sinh nhật hàng tháng. Chế độ hơn 10 dịp lễ tết mỗi năm, thăm hỏi ốm đau.

2.2. Cơ hội thăng tiến
- Luyện "đai đen" với hàng chục kỹ năng: Được tham gia hàng chục khóa đào tạo nội bộ, luyện "đai đen" về các công nghệ, phương pháp, quy trình hiện đại đi đầu trong ngành giáo dục đào tạo Đông Nam Á.
- Lên 2 chức trong 6 tháng; 23 tuổi làm lãnh đạo: Đánh giá 2 kỳ/năm, có người được cất nhắc 2 lần/kỳ. Luôn có hàng chục vị trí quản lý trống. Tuổi trung bình là 28, lãnh đạo trẻ nhất là 23. Nhân sự tăng 30% - 50%/năm.
- Trở thành chuyên gia tầm quốc tế: Các tổ chức quốc tế vinh danh: AAOU, APIN, CASA, Development Gateway, SEAMOLEC, Stockholm, Challenge, World Economic Forum... Bill Gates và 3 Phó Thủ tướng đã tới thăm.
- Đi đầu Đông Nam Á về công nghệ đào tạo: Trực tiếp xung trận, hoặc chỉ huy đầu não các cơ sở Thái Lan, Philippines, Singapore, Mỹ. Làm sếp của Tây, chứ không phải làm cho Tây. Luyện nói qua Google Glass đầu tiên thế giới; Mô phỏng 3D Second Life đầu tiên Đông Nam Á; IPTV, Mobile. E-Learning theo xu thế của Đại học Harvard, Stanford, Maryland...

2.3. Được tự hào
- Đi đầu Đông Nam Á về công nghệ đào tạo: Trực tiếp xung trận, hoặc chỉ huy đầu não các cơ sở Thái Lan, Philippines, Singapore, Mỹ. Làm sếp của Tây, chứ không phải làm cho Tây. Luyện nói qua Google Glass đầu tiên thế giới; Mô phỏng 3D Second Life đầu tiên Đông Nam Á; IPTV, Mobile. E-Learning theo xu thế của Đại học Harvard, Stanford, Maryland...
- 1000 Doanh nhân và hàng trăm GV Âu Mỹ giảng dạy: 1000 Doanh nhân và GV giảng dạy kiến thức thực tế; hàng trăm GV Âu, Mỹ luyện kỹ năng hội thoại sinh động. Mọi nhân viên Topica được gọi là thầy cô và tri ân 20/11.
- 1600 Cựu sinh viên thăng tiến, thành đạt: Tự hào với 1600 Cựu sinh viên thăng tiến, thành đạt; nhiều Thạc sĩ học tiếp với Topica;hàng trăm học viên nói tiếng Anh thành thạo. Các startup tốt nghiệp TOPICA FI đã nhận gần 10 triệu USD vốn đầu tư.
- "Pay It Forward": Văn hoá "Cho đi chưa cần nhận lại" ở khắp nơi: Nhân viên, sinh viên TOPICA tham gia từ thiện "Chia sẻ yêu thương" hàng tháng. Sinh viên khoá trên tổ chức ôn thi cho khoá dưới. Học viên TFI tài trợ hàng chục học bổng toàn phần cho khoá sau.

2.4. Được hết mình
- Được làm vua, thua làm... hiệp sĩ: Khi xung phong việc mới, thành công dĩ nhiên được thưởng, thăng tiến. Nhưng nếu thất bại, bạn được phong hiệp sĩ, thưởng, ưu tiên quay về, miễn đánh giá thấp 1 kỳ.
- Giúp hàng trăm ngàn người học tốt hơn: Mỗi sáng kiến đều được đưa ra bảo vệ, khen thưởng, và bạn trực tiếp giúp hàng trăm ngàn người học tập tốt hơn. Sứ mệnh TOPICA có câu "Triệu người nâng trí tuệ".
- Nói thẳng: thưởng. Nịnh sếp: phạt. Thưởng: đập bàn sếp, bắt quả tang sếp, nhận mình không hiểu. Phạt: nịnh sếp. Nói thẳng: cuộc họp, trà đá, bàn tròn cuối kỳ. Sốc để ra giải pháp, chứ không dĩ hoà vi quý.
- Gắn bó như gia đình: Nhiều quản lý, nhân viên ra đi 3 tháng, 1 năm rồi lại trở về cống hiến. Hàng chục người đã gắn bó 6-7 năm kể từ ngày đầu thành lập. Nhiều đôi trẻ nên duyên (hay gỡ bom) trong đại gia đình TOPICAN.
- Work hard, Play hard: Làm hết sức, chơi hết mình.', N'3. Yêu cầu

- Kinh nghiệm xây dựng hệ thống quản trị tài sản.
- Sẵn sàng đi công tác, triển khai xây dựng hệ thống ở nhiều nước.
- Khả năng lập kế hoạch, thuyết trình.
- Không ngại khó khăn, chỉ đòi hỏi làm việc này không làm việc kia.

4. Liên hệ
Tiêu đề Email vui lòng ghi rõ vị trí ứng tuyển: VNW_PMquantricsvc(TD1511033)_Họ tên', N'JobDetail.aspx', 1, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2082, 3038, 2, 4, 2, 2, 2, 3, CAST(0x0000A57F00000000 AS DateTime), 11, N'[magnon] [hcmc] System Engineer', N'System Engineer builds, maintains, and troubleshoots our rapidly expanding infrastructure etc.

Working Conditions:
Working Days:
Monday ~ Saturday (Mon – Fri: 8:00 AM ~ 5:00 PM; Saturday: 8:00 AM ~ 12:00 PM)
Working Place (Location):District 1, HCMC', N'Degree: College Degree or higher Multimedia certificate/award or higher
Major: Information Technology (Computer, software, and media etc)/ Art
Experience: No experience required 

We also looking for someone who’s experienced in related industry

Competency:
-Ability to take direction well
-Strong time management skills and ability to meet deadlines in a fast-paced environment
-Skills / Licenses	Computer Skills
-Any valid certifications of graphic designs or art (Please provide your portfolio)

Other Preferences
This position have 3 months of training and the employee is employed subject to satisfactory completion and result of this trial period. During the training, you will get paid approximately $160 per month during the training period and this will be vary on position.
Please note that all of above conditions are may vary depending upon situation.
Please kindly send your updated CV in English as soon as possible.', N'JobDetail.aspx', 4, 1, 0)
INSERT [dbo].[Jobs] ([JobID], [RecruitorID], [JobPositionID], [SalaryLevelID], [ProvinceID], [WorkTypeID], [ExperienceLevelID], [CertificateID], [ExpiredDate], [JobIndustryID], [FullTitle], [ContentDetail], [Description], [RewriteUrl], [NumsApplicant], [STATUS], [IS_HOT]) VALUES (2083, 3025, 2, 5, 2, 2, 2, 3, CAST(0x0000A57F00000000 AS DateTime), 6, N'Cần Tuyển 5 Lập Trình Viên Java', N'aa', N'aa', N'JobDetail.aspx', 5, 1, 0)
SET IDENTITY_INSERT [dbo].[Jobs] OFF
SET IDENTITY_INSERT [dbo].[JobSalaryLevel] ON 

INSERT [dbo].[JobSalaryLevel] ([SalaryLevelID], [SalaryLevel]) VALUES (2, N'Thỏa thuận')
INSERT [dbo].[JobSalaryLevel] ([SalaryLevelID], [SalaryLevel]) VALUES (3, N'Dưới 5 triệu')
INSERT [dbo].[JobSalaryLevel] ([SalaryLevelID], [SalaryLevel]) VALUES (4, N'5- 10 triệu')
INSERT [dbo].[JobSalaryLevel] ([SalaryLevelID], [SalaryLevel]) VALUES (5, N'Trên 10 triệu')
INSERT [dbo].[JobSalaryLevel] ([SalaryLevelID], [SalaryLevel]) VALUES (6, N'10-20 triệu')
SET IDENTITY_INSERT [dbo].[JobSalaryLevel] OFF
SET IDENTITY_INSERT [dbo].[JobsSaved] ON 

INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (8, 11, 2047, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (10, 11, 32, 0)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (11, 27, 2047, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (12, 11, 2046, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (13, 15, 33, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (14, 15, 2045, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (15, 15, 2047, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (16, 15, 2046, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (17, 31, 32, 0)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (18, 31, 2043, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (1011, 1, 2043, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (1012, 28, 2044, 1)
INSERT [dbo].[JobsSaved] ([JobSavedID], [UserID], [JobID], [Status]) VALUES (1013, 11, 33, 1)
SET IDENTITY_INSERT [dbo].[JobsSaved] OFF
SET IDENTITY_INSERT [dbo].[Province] ON 

INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (2, N'Hà Nội
  ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (3, N'Hồ Chí Minh')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (5, N'Đà Nẵng
')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (6, N'Hải Phòng
')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (7, N'An Giang')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (8, N'Bà Rịa -Vũng Tàu')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (9, N'Bắc Cạn')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (10, N'Bắc Giang')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (11, N'Bạc Liêu')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (12, N'Bắc Ninh')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (13, N'Bến Tre ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (14, N'Biên Hòa')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (15, N'Bình Định')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (16, N'Bình Dương')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (17, N'Bình Phước')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (18, N'Bình Thuận')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (19, N'Cà Mau ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (20, N'Cần Thơ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (21, N'Cao Bằng')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (22, N'Đà Nẵng')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (23, N'Đắc Lắc')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (24, N'Điện Biên')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (25, N'Đồng Nai')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (26, N'Đồng Tháp')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (27, N'Gia Lai')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (28, N'Hà Giang')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (29, N'Hà Nam')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (30, N'Hà Tĩnh')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (31, N'Hải Dương')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (32, N'Hải Phòng')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (33, N'Hòa Bình')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (34, N'Huế ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (35, N'Hưng Yên')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (36, N'Khánh Hòa')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (37, N'Kon Tum')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (38, N'Lai Châu')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (39, N'Lâm Đồng')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (40, N'Lạng Sơn')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (41, N'Lào Cai')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (42, N'Nam Định')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (43, N'Nghệ An')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (44, N'Ninh Bình')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (45, N'Ninh Thuận')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (46, N'Phú Thọ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (47, N'Phú Yên')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (48, N'Quảng Bình')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (49, N'Quảng Nam ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (50, N'Quảng Ngãi')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (51, N'Quảng Ninh')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (52, N'Quảng Trị')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (53, N'Sóc Trăng')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (54, N'Sơn La')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (55, N'Tây Ninh ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (56, N'Thái Bình')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (57, N'Thái Nguyên ')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (58, N'Thanh Hóa')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (59, N'Thừa Thiên Huế')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (60, N'Tiền Giang')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (61, N'Trà Vinh')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (62, N'Tuyên Quang')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (63, N'Vĩnh Long')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (64, N'Vĩnh Phúc')
INSERT [dbo].[Province] ([ProvinceID], [ProvinceName]) VALUES (65, N'Yên Bái')
SET IDENTITY_INSERT [dbo].[Province] OFF
SET IDENTITY_INSERT [dbo].[Race] ON 

INSERT [dbo].[Race] ([RaceID], [RaceName]) VALUES (1, N'Kinh')
INSERT [dbo].[Race] ([RaceID], [RaceName]) VALUES (2, N'Tày')
INSERT [dbo].[Race] ([RaceID], [RaceName]) VALUES (3, N'Mường')
SET IDENTITY_INSERT [dbo].[Race] OFF
SET IDENTITY_INSERT [dbo].[Recruitor] ON 

INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1017, N'Hòa Phát', 9, N'Tập đoàn Hòa Phát', N'HPCo', N'69 Vũ Trọng Phụng, Thanh Xuân, Hà Nội', N'contact@hp.vn', N'0969969969', N'hoaphat@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1018, N'Potter Harry', 5, N'Công ty TNHH Tumisumo', N'Tumisumo', N'109 Tầng 1, Tòa nhà Hapuco, Thanh Xuân, Hà Nội', N'Harrypotter@Howard.Uk', N'0987125389', N'Siunhantrolai@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1019, N'Châu Tấn', 5, N'Công ty cổ phần Châu Châu', N'XXX', N'45 Phố Vọng,Hoàng Mai, Hai Bà Trưng, Hà Nội', N'contact@sddd.vn', N'0969969969', N'chuancmnr@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1020, N'Nguyễn Nhạn', 3, N'Công ty Cổ Phần O2S', NULL, N'405Tầng 4, Tòa nhà Vietcombank, Thanh Xuân, Hà Nội', N'contact@o2s.vn', N'0983896823', N'o2sJSC@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1021, N'Jake Sulley', 8, N'Công Ty Cổ Phần Thương Mại Tin Học Hưng Long', N'HLCo', N'Số 42C ngõ 255 Phố Vọng, Hà Nội', N'contact@abc.vn', N'5225252521', N'abcder@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1022, N'Mr  Dương', 2, N'Trung Tâm Trọng Tài Quốc Tế Việt Nam', N'TTTTQTVN', N'Tầng 6, Tòa Nhà Số 9 Phố Đào Duy Anh, Quận Đống Đa, Hà Nộ', NULL, N'098866554', N'trongtai@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1023, N'Lan Anh', 8, N'Brand Name Under Paradise Bay Resort Ltd. Company', N'ALMA', N'7 & 15th Floor, Capital Tower, 109 Tran Hung Dao, Hoan Kiem, Hano', N'Recruiment@alma.com.vn', N'0906152539', N'tuyendung@alma.com.vn', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1024, N'HR Dept', 3, N'Rieckermann Gmbh', N'', N'331 Nguyen Thuong Hien Street, Ward 11', NULL, N'019992177317', N'tuyendung@gmbh.vn', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1025, N'Phan Loan', 7, N'DEK Technologies', N'DEK', N'CnR Rigall St and Maldon St, Broadmeadows, VIC 3047, Melbourne, Australia-121/137 Le Loi Street, Ben Thanh Ward, District 1,HCMC', NULL, N'0092188313', N'humanresource@dek.com.jn', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1026, N'Phòng Nhân Sự', 8, N'Công Ty Phần Mềm Và Truyền Thông VASC', N'VASC', N'97 Nguyễn Chí Thanh, Đống Đa, Hà Nội', N'solarface94@gmail.com', N'0921831312', N'humanresource@vasc.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (1027, N'Như Quỳnh', 7, N'Tetra Pak Vietnam', N'TPK', N'14 Floor, 235 Dong Khoi Street, Dist.1', N'solarface94@gmail.com', N'09898821773', N'tetrapakvietnam@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3023, N'Ronoraha Roro', 9, N'Ngân Hàng TMCP Đầu Tư Và Phát Triển Việt Nam', N'BIDV', N'Tháp BIDV, 35 Hàng Vôi, Hoàn Kiếm, Hà Nội', N'solarface94@gmail.com', N'0992883871', N'solarface1994@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3024, N'Portgas D. Ace', 9, N'Olympus Vietnam Co., Ltd', N'Olympus', N'LongThanh Industrial Zone, Dong Nai Province, VN', N'solarface94@gmail.com', N'0992883871', N'solarface1995@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3025, N'Gol D. Roger', 9, N'Sumitomo Chemical Vietnam', N'', N'Lầu 5, số 40 Phạm Ngọc Thạch, p6 q3', N'solarface94@gmail.com', N'0992883873', N'solarface1996@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3026, N'Gol D. Law', 8, N'Trams', N'Trams', N'10 Hang Chao(6th Floor), Dong Da, Hanoi', N'solarface94@gmail.com', N'0992883873', N'vietpv00@o2s.vn', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3027, N'Gol D. Jack', 1, N'Công Ty TNHH MTV Uryu& Itoga Advisory Service Việt Nam', N' Uryu& Itoga', N'Tầng 12, Tòa nhà BIDV, Số 194 Trần Quang Khải, Hoàn Kiếm, Hà Nội', N'solarface94@gmail.com', N'0992883873', N'vietpv444@o2s.vn', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3028, N'Gol D. Jack', 1, N'Back Breard JSC', NULL, N'12St Yokohama, Japan', NULL, N'0992883873', N'vietpv@o2s.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3029, N'Gol D. John', 8, N'ALMA (hospitality brand Name Under Paradise Bay Resort Ltd. Company)', N'ALMA ', N'15th Floor, Capital Tower, 109 Tran Hung Dao, Hoan Kiem, Hanoi / 30th Floor, Lim Tower, Ton Duc Thang, Distric 1, HCMC', N'solarface94@gmail.com', N'0992883871', N'vietpv9444@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3030, N'Gol D. John', 3, N'Công Ty Cổ Phần Logistics Tín Nghĩa - ICD Biên Hòa', N' TinNghia Logistics', N'Km1+900 Quốc Lộ 51, Phường Long Bình Tân, Tp, Biên Hòa, Tỉnh Đồng Nai', N'solarface94@gmail.com', N'0992883871', N'vietpv9dd4@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3031, N'Ronoraha Roger', 9, N'Công Ty Dịch Vụ Mobifone Khu Vực 6', N'Mobifone ', N'Số 34, Đường Nguyễn Sỹ Sách, Phường Hưng Bình, Thành phố Vinh, Nghệ An', N'solarface94@gmail.com', N'0992883873', N'vietpv94@yahoo.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3032, N'Ronoraha Sanji', 2, N'Công Ty Cổ Phần Truyền Thông Xin Chào - Hello Media JSC', N'Hello Media JSC', N'Số 8, Tràng Thi, Hoàn Kiếm, Hà Nội', N'solarface94@gmail.com', N'0992883871', N'vietpv94ff@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3033, N'Human Resources Department', 7, N'Asia Pacific Brewery (Hanoi) Limited .', N'', N'Km 15+500, Road 427, Vantao commune, Thuongtin, HaNoi', N'solarface94@gmail.com', N'0992883871', N'vietpv94fff@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3034, N'pham Roger', 7, N'Daikin Air Conditioning (Vietnam) Joint Stock Company', N'', N'201-203 Cach Mang Thang Tam, Ward 4, Dist 3', N'solarface94@gmail.com', N'0992883871', N'vietpv96@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3035, N'pham Roro', 9, N'Home Credit Vietnam', N'', N'194 Golden Buidling, 473 Dien Bien Phu, Ward 25, Binh Thanh District, HCMC', N'solarface94@gmail.com', N'0992883873', N'vietpvdepzai@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3036, N'Portgas D. Roger', 7, N'Tổ Hợp Công Nghệ Giáo Dục Topica', N'', N'VP Hà Nội : Tầng 3_Số 75 Phương Mai_Phường Phương Mai_Quận Đống Đa_Hà Nội. CN TPHCM : 58/10 Thành Thái, P.12, Q.10, TP.HCM', N'solarface94@gmail.com', N'0998763131', N'vietpv91@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3037, N'Nguyễn Xuân  Duẩn', 4, N'Trách Nhiệm Hữu Hạn 1 Thành Viên XDNonStop', N'', N'12 Châu Quỳ, Hà Nội', N'solarface94@gmail.com', N'0992883871', N'vietpv102@gmail.com', N'/Images/no_image_available.png')
INSERT [dbo].[Recruitor] ([RecruitorID], [RecruitorName], [CompanySizeID], [CompanyFullName], [CompanyShortName], [Address], [EmailToSendResume], [PhoneToCallForJob], [EmailLogin], [PhotoPath]) VALUES (3038, N'Sparrow Jack', 1, N'Magnon Studio', NULL, N'Gwang-ju CGI Center 9F, 373-3, Songha-dong, Nam-gu, Gwangju 503-820', N'solarface94@gmail.com', N'0992883873', N'vietpv94@gmail.com', N'/Images/no_image_available.png')
SET IDENTITY_INSERT [dbo].[Recruitor] OFF
SET IDENTITY_INSERT [dbo].[Registration] ON 

INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1, N'solarface94@gmail.com', N'25F9E794323B453885F5181F1B624D0B', 1, CAST(0x823A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (2, N'alibama@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 11, CAST(0xD7390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3, N'abc@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 12, CAST(0xD7390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (4, N'abcd@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 13, CAST(0xD7390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (5, N'quyetngu@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 14, CAST(0xD7390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (6, N'sonngu@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 15, CAST(0xD7390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1012, N'PhamViet(4@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 27, CAST(0x823A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1013, N'whoami@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 28, CAST(0xF5390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1014, N'Booiminhdidauthe@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 30, CAST(0xF5390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1015, N'TungTu@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 31, CAST(0xF9390B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3015, N'vietpv98@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2031, CAST(0x933A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3016, N'vietpv1994@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2032, CAST(0x973A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3017, N'vietpv1995@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2033, CAST(0x9C3A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3018, N'vietpv1999@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2034, CAST(0xA03A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3019, N'vietpv200@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2035, CAST(0xA03A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3020, N'vietpv2000@gmail.com', N'D41D8CD98F00B204E9800998ECF8427E', 2036, CAST(0xA03A0B00 AS Date), 1, NULL, 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3021, N'vietpv2001@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2037, CAST(0xAD3A0B00 AS Date), 1, N'29l7dacf40obhhk', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3022, N'vietpv@o2s.com', N'C5191F2B46CCFCC448437B530CE296E3', 2038, CAST(0xAD3A0B00 AS Date), 1, N'2mivzqqj8mqvybh', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3023, N'viepv9489@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2039, CAST(0xAD3A0B00 AS Date), 1, N'g3gviyyoe4pz1qa', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3024, N'viepv9934@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2040, CAST(0xAD3A0B00 AS Date), 1, N'b4y69f6px072x8p', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3025, N'viepv9441@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2041, CAST(0xAD3A0B00 AS Date), 1, N'a85rdh46y6xmg8a', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3026, N'viepv94@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2042, CAST(0xAD3A0B00 AS Date), 1, N'0wxbgs5t5vcin0z', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3027, N'vietpv994@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2043, CAST(0xAD3A0B00 AS Date), 1, N'yfuwccgr33v2op3', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3028, N'vietpv15@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2044, CAST(0xAD3A0B00 AS Date), 1, N'yuy8ad0l8j3yert', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3029, N'vietpv933@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2045, CAST(0xAD3A0B00 AS Date), 1, N'cx3edu5cl4mlpgl', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3030, N'vietpv984@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2046, CAST(0xAD3A0B00 AS Date), 1, N'xv0j128jf78oii7', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3031, N'vietpv9ddd4@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2047, CAST(0xAD3A0B00 AS Date), 1, N'0sq6qrepkojb729', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3032, N'vietpv9409@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2048, CAST(0xAD3A0B00 AS Date), 1, N'57a2qbmrg0z6v59', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3033, N'apolobama1@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2049, CAST(0xAE3A0B00 AS Date), 1, N's6k8c5j3gdj250a', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3034, N'', N'D41D8CD98F00B204E9800998ECF8427E', 2050, CAST(0xB33A0B00 AS Date), 1, N'AdminVIPNoNeedCaptcha', 0, 0)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3035, N'vietpv@o2s.vn', N'C5191F2B46CCFCC448437B530CE296E3', 2051, CAST(0xB33A0B00 AS Date), 1, N'AdminVIPNoNeedCaptcha', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3038, N'Admin1@gmail.com', N'25F9E794323B453885F5181F1B624D0B', 2053, CAST(0xB33A0B00 AS Date), 1, N'AdminVIPNoNeedCaptcha', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3039, N'20122797@student.hust.edu.vn', N'C5191F2B46CCFCC448437B530CE296E3', 2054, CAST(0xBB3A0B00 AS Date), 1, N'g6ux5aeaw6ittgw', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3040, N'apolobama@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 2055, CAST(0xBC3A0B00 AS Date), 1, N'tguh7cxj9fps3gp', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3041, N'xuanduanngunguyen@gmail.com', N'E10ADC3949BA59ABBE56E057F20F883E', 2056, CAST(0xBC3A0B00 AS Date), 1, N'8n0duy8dn65gwxk', 1, 1)
INSERT [dbo].[Registration] ([RegistrationID], [EmailLogin], [PassWordLogin], [UserID], [RegistrationDate], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3042, N'20122797@student.hut.edu.vn', N'C5191F2B46CCFCC448437B530CE296E3', 2057, CAST(0xBC3A0B00 AS Date), 1, N'ksa84g0vr5o0guw', 1, 1)
SET IDENTITY_INSERT [dbo].[Registration] OFF
SET IDENTITY_INSERT [dbo].[RegistrationAsRecruitor] ON 

INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1, N'fullofsunshine94@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 11, CAST(0x823A0B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (9, N'fullofsunshine@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1, CAST(0x833A0B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (10, N'hoaphat@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1017, CAST(0xE9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (11, N'Siunhantrolai@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1018, CAST(0xE9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (12, N'chuancmnr@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1019, CAST(0xEA390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (13, N'o2sJSC@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1020, CAST(0xEA390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (14, N'abcder@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1021, CAST(0xEA390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (15, N'trongtai@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1022, CAST(0xEA390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1015, N'tuyendung@alma.com.vn', N'C5191F2B46CCFCC448437B530CE296E3', 1023, CAST(0xF9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1016, N'tuyendung@gmbh.vn', N'C5191F2B46CCFCC448437B530CE296E3', 1024, CAST(0xF9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1017, N'humanresource@dek.com.jn', N'C5191F2B46CCFCC448437B530CE296E3', 1025, CAST(0xF9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1018, N'humanresource@vasc.com', N'C5191F2B46CCFCC448437B530CE296E3', 1026, CAST(0xF9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (1019, N'tetrapakvietnam@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 1027, CAST(0xF9390B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3015, N'solarface1994@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3023, CAST(0xA03A0B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3016, N'solarface1995@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3024, CAST(0xA03A0B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3017, N'solarface1996@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3025, CAST(0xA03A0B00 AS Date), 2, NULL, 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3018, N'vietpv00@o2s.vn', N'C5191F2B46CCFCC448437B530CE296E3', 3026, CAST(0xAD3A0B00 AS Date), 2, N'ol9thhf2nr70wqi', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3019, N'vietpv444@o2s.vn', N'C5191F2B46CCFCC448437B530CE296E3', 3027, CAST(0xAD3A0B00 AS Date), 2, N'gfv9bzu37snks2d', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3020, N'vietpv@o2s.com', N'C5191F2B46CCFCC448437B530CE296E3', 3028, CAST(0xAD3A0B00 AS Date), 2, N'r1bdjl4h78yjapd', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3021, N'vietpv9444@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3029, CAST(0xAD3A0B00 AS Date), 2, N'vhuluugt4ecks7w', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3022, N'vietpv9dd4@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3030, CAST(0xAD3A0B00 AS Date), 2, N'632oabk2xwwuvt1', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3023, N'vietpv94@yahoo.com', N'C5191F2B46CCFCC448437B530CE296E3', 3031, CAST(0xAD3A0B00 AS Date), 2, N'ibxnlelj20gds58', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3024, N'vietpv94ff@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3032, CAST(0xAD3A0B00 AS Date), 2, N'ksan43agod7mr43', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3025, N'vietpv94fff@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3033, CAST(0xAD3A0B00 AS Date), 2, N'ims2ng5pv5nhi75', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3026, N'vietpv96@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3034, CAST(0xAD3A0B00 AS Date), 2, N'qqdf71pgyj2r47f', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3027, N'vietpvdepzai@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3035, CAST(0xAD3A0B00 AS Date), 2, N't252iq3fovuks7l', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3028, N'vietpv91@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3036, CAST(0xAE3A0B00 AS Date), 2, N'lg0ri2kygt460dz', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3029, N'vietpv102@gmail.com', N'25F9E794323B453885F5181F1B624D0B', 3037, CAST(0xAE3A0B00 AS Date), 2, N'8qys7rpnduqaa8h', 1, 1)
INSERT [dbo].[RegistrationAsRecruitor] ([RegistrationAsRecruitorID], [EmailLoginAsRecruitor], [Password], [RecruitorID], [RegistrationDateTime], [TypeUser], [User_Valid_Email_Code], [IS_ACTIVATED], [STATUS]) VALUES (3030, N'vietpv94@gmail.com', N'C5191F2B46CCFCC448437B530CE296E3', 3038, CAST(0xBC3A0B00 AS Date), 2, N'grzq2n6bc91q27w', 1, 1)
SET IDENTITY_INSERT [dbo].[RegistrationAsRecruitor] OFF
SET IDENTITY_INSERT [dbo].[ResumeDetails] ON 

INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (6, 2, 12, 2, 6, 2, 2, N'test hồ sơ', N'johnterry@gmail.com', N'sadasdasdasd', 1, 9, N'guong mat dang thuong', N'yaeh', N'adsadasdasdasdasda', N'dsaddasdasdasdasdasd', N'dasdsaaaaaaaaaaaaaaaaaaaaaa', N'/FileSticky/UC-exerciseFragment.docx', 2, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (7, 2, 26, 2, 6, 2, 2, N'Test Ho So 3', N'naruto@gmail.com', N'Xin hay la em cua ngay hom qua', 1, 9, N'dung bo mac anh 1  minh noi day', N'em mang tieng cuoi', N'nguoi buoc xa roi', N'nguoi cu voi vang', N'em mang hanh phuc di xa roi', NULL, 2, 1, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (8, 2, 26, 2, 6, 2, 2, N'Test Ho So 99', N'sakura@gmail.com', N'lalalalalala', 11, 9, N'ok dem nay se la 1 dem tuyet voi', N'e y e yey y ye e', N'nuoc mat roi uot tran', N'asdasdasdasdsad', N'mnmn[asnasd', NULL, 2, 1, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (10, 2, 26, 2, 6, 2, 2, N'SaSuke', N'SaSuke@gmail.com', N'A du.....................', 11, 9, N'sdadasdas', N'asdasdasd', N'asdasdasd', N'su dung sharingan', N'dsadasdasd', NULL, 2, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (11, 2, 26, 2, 6, 2, 2, N'anh k muon mat em nguoi oi', N'Kakashi@gmail.com', N'Anh sai roi', 11, 9, N'sasddddddddddddddd', N'asddddddddddddddddd', N'asddddddddddddddddd', N'sadddddddddddd', N'dsaaaaaaa', NULL, 2, 0, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (12, 6, 34, 6, 6, 2, 1004, N'Điệp viên 007', N'007@gmail.com', N'Cua gai', 28, 6, N'Cua gai 5 giay', N'20 nam cua gai', N'sâsas', N'lai oto', N'hoc o khap noi tren the gioi', NULL, 2, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (13, 3, 40, 3, 2, 2, 2, N'Xin làm Osin', N'QuyetGay@gmail.com', N'kiêm tiền mua dầu ăn', 30, 1, N'sàddsfsdfsdff', N'21 năm dọn rác ở sông Tô Lịch', N'áddddddddddddddddddddddddddddd', N'adasdassssssssssssssssssss', N'hết lớp 1', NULL, 7, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (14, 6, 11, 3, 6, 2, 1002, N'Đẹp Trai Không Ai Thuê', N'catchmeifyoucan@yahoo.com', N'1.Như đã đề cập ở trên, đối với sinh viên hoặc người chưa có mục tiêu nghề nghiệp rõ ràng thì họ sẽ cần thể hiện những định hướng của mình (Orientation). Ứng viên này đã cho nhà tuyển dụng thấy được mong muốn và định hướng của mình, và đặc biệt định hướng này giúp ích cho vị trí ứng tuyển.
2. Riêng đối với những bạn đã có mục tiêu nghề nghiệp rõ ràng thì cách nhanh nhất để giúp nhà tuyển dụng nắm bắt được mục tiêu nghề nghiệp của bạn là: Hãy tập trung vào những thành tựu, kỹ năng, kiến thức mà bạn mong muốn đạt được trong quá trình làm việc hay những vị trí nhất định. Và những mục tiêu này phải có khả năng định lượng cũng như tính khả thi. 
3. Một lưu ý nhỏ khi viết phần Career Objective là nếu bạn chỉ muốn học hỏi kinh nghiệm trong khoảng 1 – 2 năm và sau đó thành lập doanh nghiệp riêng thì không nên đề cập trong CV vì điều này sẽ khiến bạn bị loại ngay lập tức, nhà tuyển dụng hoàn toàn không muốn nhân viên mình dành thời gian, chi phí đào tạo trong 2 năm sau đó xin nghỉ và tự kinh doanh. ', 27, 4, N'Chơi được tất cả các môn thể thao, trư các môn không chơi được', N'Từng làm cho 20 cty trên 10 quôc gia khác nhau.', N'có tất cả trên mạng xã hội', N'chém gió, gây sóng thần trên biển', N'đang bảo vệ đồ án giáo sư', NULL, 3, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (15, 7, 23, 3, 2, 3, 2, N'Sơn Tù Ú U U Ù', N'sontu@mtp.com.vn', N'Làm thật nhiều tiền để nuôi vợ ăn học', 15, 1, N'lấy nhiều vợ', N'lấy 3 vợ 3 năm vẫn muốn lấy tiếp', N'facebook songayly', N'k cần tán gái vẫn tự đổ', N'đại học là level thấp nhất dự định sẽ vượt qua', NULL, 3, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (16, 3, 2, 3, 2, 2, 3, N'Tù như con gà rù', N'xinhaylatungcuangayhomqua@gmail.com', N'Đi làm cho bớt tù', 31, 8, N'Siu sao bóng đá, đã từng đưa đội bóng của lớp bào tới vòng loại.', N'đá bóng 2 năm vẫn tù', N'nothing ', N'đá bóng siêu tù', N'học hết đại học, bị bố bắt về lấy vợ', NULL, 3, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (1026, 2, 26, 2, 6, 2, 2, N'handsome', N'Jackgay@gmail.com', N'3fafasfadsadasdada', 31, 9, N'fqwwefqfsfa', N'fsdfsdfsdfsdf', N'fdsfsdfsdfsdff', N'fsdfsdfsdfsdf', N'fdsfdsfsdfsdfdsf', NULL, 2, 1, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (1036, 2, 2, 2, 2, 2, 2, N'Hồ Sơ HandSome', N'solarface94@gmail.com', N'kasdlanlbasvasvcasv', 1, 1, N'asvmnhgfdszngbfvdcsxz', N'mnfgbdfscaxaz', N'nhgbfvsdsAZ', N'NFGBDFVSDSXaz', N'NHGBDFVSAZ', N'', 2, 1, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (1037, 2, 2, 2, 6, 2, 1003, N'Hổ Sơ Hải Tặc', N'MonkeyDLuffy@gmail.com', N'Thành Vua Hải Tặc', 2042, 9, N'Đánh bại Mìngo', N'3 năm làm hải tặc', N'xem Onepiece ', N'kéo dãn cơ thể', N'chả bao giờ đi học', N'', 7, 1, 1)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (1038, 2, 2, 2, 2, 2, 2, N'', N'', N'', 11, 1, N'', N'', N'', N'', N'', N'', 2, 0, 0)
INSERT [dbo].[ResumeDetails] ([ResumeID], [JobPositionID], [JobIndustryID], [ProvinceID], [SalaryLevelID], [WorkTypeID], [ExperienceLevelID], [ResumeName], [ContactEmail], [ACHIEVEMENTS], [UserID], [SkillID], [CAREER_GOALS], [WORK_EXPERIENCE], [LITERACY], [SKILLS], [REFERENCE], [ATTACHMENT], [CertificateID], [STATUS], [Active]) VALUES (1039, 4, 2, 2, 2, 2, 1002, N'viet pham', N'solarface94@gmail.com', N'das', 2057, 3, N'da', N'das', N'da', N'dad', N'ds', N'', 3, 1, 1)
SET IDENTITY_INSERT [dbo].[ResumeDetails] OFF
SET IDENTITY_INSERT [dbo].[ResumeRecruited] ON 

INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (1, 6, 1017, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (2, 7, 1017, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (3, 13, 1017, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (4, 7, 1018, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (5, 14, 1020, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (1005, 6, 1020, 0, NULL)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (2005, 15, 1026, 1, 2047)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (2006, 14, 1026, 1, 2047)
INSERT [dbo].[ResumeRecruited] ([ResumeRecruitedID], [ResumeID], [RecruitorID], [Status], [JobID]) VALUES (2007, 12, 1026, 1, 2047)
SET IDENTITY_INSERT [dbo].[ResumeRecruited] OFF
SET IDENTITY_INSERT [dbo].[Sex] ON 

INSERT [dbo].[Sex] ([SexID], [SexName]) VALUES (1, N'Khác')
INSERT [dbo].[Sex] ([SexID], [SexName]) VALUES (2, N'Nam')
INSERT [dbo].[Sex] ([SexID], [SexName]) VALUES (3, N'Nữ')
SET IDENTITY_INSERT [dbo].[Sex] OFF
SET IDENTITY_INSERT [dbo].[Skill] ON 

INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (1, N'Tiếng Anh(Bằng C)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (2, N'Tiếng Anh(Bằng B)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (3, N'Tiếng Anh(Bằng A)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (4, N'Tiếng Anh(Bằng Toefl)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (5, N'Tiếng Anh(Bằng Toeic)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (6, N'Tiếng Anh(Bằng IELTS)', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (7, N'Tiếng Pháp', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (8, N'Tiếng Trung', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (9, N'Tiếng Nhật', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (10, N'Tiếng Hàn', NULL)
INSERT [dbo].[Skill] ([SkillID], [SkillName], [Description]) VALUES (11, N'Không Biết Ngoại Ngữ', NULL)
SET IDENTITY_INSERT [dbo].[Skill] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (1, N'solarface94@gmail.com', CAST(0xDB1B0B00 AS Date), 2, N'0983896823', 1, N'Viet', N'Pham', 1, N'/Images/0122215.jpg', 0, 0, 1, 1, N' ', 2, 1)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (11, N'alibama@gmail.com', CAST(0x8C1C0B00 AS Date), 2, N'0123456789', 9, N'jack', N'Sparrow', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, N'Dep trai ', 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (12, N'abc@gmail.com', CAST(0x8C1C0B00 AS Date), 2, N'0992233322', 1, N'jake', N'Sparrow', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (13, N'abcd@gmail.com', CAST(0x8C1C0B00 AS Date), 3, N'0312444422', 1, N'jobs', N'john', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (14, N'quyetngu@gmail.com', CAST(0x8C1C0B00 AS Date), 3, N'0932314124', 1, N'Quyet', N'Ngu', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (15, N'sonngu@gmail.com', CAST(0xD01C0B00 AS Date), 2, N'0412421244', 1, N'Sơn', N'Nguyễn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, N'Lấy nhiêu vợ', 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (27, N'PhamViet(4@gmail.com', CAST(0x8C1C0B00 AS Date), 2, N'09212213414', 1, N'Viet', N'Pham', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (28, N'whoami@gmail.com', CAST(0xDE020B00 AS Date), 2, N'09293183183', 1, N'Jame', N'Bone', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (30, N'Booiminhdidauthe@gmail.com', CAST(0x901C0B00 AS Date), 2, NULL, 1, N'Quyết', N'Hà Minh', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (31, N'TungTu@gmail.com', CAST(0x6C1C0B00 AS Date), 2, NULL, 1, N'Tùng Tù', N'Gay', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2031, N'vietpv98@gmail.com', CAST(0x8C1C0B00 AS Date), 2, NULL, 1, N'Việt', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2032, N'vietpv1994@gmail.com', CAST(0x8C1C0B00 AS Date), 2, N'', 1, N'Văn', N'Phạm', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, N'', 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2033, N'vietpv1995@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Việt', N'Phạm văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2034, N'vietpv1999@gmail.com', CAST(0xA73A0B00 AS Date), 2, NULL, 1, N'Luffy', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2035, N'vietpv200@gmail.com', CAST(0x16150B00 AS Date), 2, NULL, 1, N'Garp', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2036, N'vietpv2000@gmail.com', CAST(0xFB0E0B00 AS Date), 2, NULL, 1, N'Dragon', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2037, N'vietpv2001@gmail.com', CAST(0xA13A0B00 AS Date), 2, NULL, 1, N'Luffy', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2038, N'vietpv@o2s.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'viet', N'pham', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2039, N'viepv9489@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Việt', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2040, N'viepv9934@gmail.com', CAST(0xCE2D0B00 AS Date), 2, NULL, 1, N'Monkey', N'Monkey D. ', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2041, N'viepv9441@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Việt', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2042, N'viepv94@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Luffy', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2043, N'vietpv994@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Việt', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2044, N'vietpv15@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Dragon', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2045, N'vietpv933@gmail.com', CAST(0xB6150B00 AS Date), 2, NULL, 1, N'Huy', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2046, N'vietpv984@gmail.com', CAST(0xDB1B0B00 AS Date), 3, NULL, 1, N'Nami', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2047, N'vietpv9ddd4@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Potter', N'Harry Jame', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2048, N'vietpv9409@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Garp', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2049, N'apolobama1@gmail.com', CAST(0x8C1C0B00 AS Date), 2, N'', 1, N'viet', N'pham', 1, N'/Images/images.jpg', 1, NULL, NULL, NULL, N'', 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2050, N'vietpv@o3s.vn', CAST(0xDB1B0B00 AS Date), 0, NULL, 1, N'test', N'test', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2051, N'vietpv@o2s.vn', CAST(0xDB1B0B00 AS Date), 983896823, NULL, 1, N'viet', N'pham', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2052, N'vietpv09@gmail.com', CAST(0xDB1B0B00 AS Date), 0, NULL, 1, N'Jack', N'Sparrow', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2053, N'Admin1@gmail.com', CAST(0xDB1B0B00 AS Date), 1, N'0983896823', 1, N'Jack', N'Sparrow', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2054, N'20122797@student.hut.edu.vn', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Việt', N'Phạm Văn', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2055, N'apolobama@gmail.com', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Duan', N'Monkey D.', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2056, N'xuanduanngunguyen@gmail.com', CAST(0xAB1B0B00 AS Date), 2, NULL, 1, N'Xuan Duan', N'Nguyen ', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Email], [DateOfBirth], [SexID], [PhoneNumber], [DistrictID], [FirstName], [LastName], [RaceID], [PhotoPath], [NewsLetter], [JobAlert], [Activate], [ResumeActivate], [MaximOfLife], [JobIndustryID], [IsAdmin]) VALUES (2057, N'20122797@student.hut.edu.vn', CAST(0xDB1B0B00 AS Date), 2, NULL, 1, N'Viet', N'Pham', 1, N'/Images/no_image_available.png', 1, NULL, NULL, NULL, NULL, 2, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[WorkTypes] ON 

INSERT [dbo].[WorkTypes] ([WorkTypeID], [WorkTypeName]) VALUES (2, N'Toàn thời gian')
INSERT [dbo].[WorkTypes] ([WorkTypeID], [WorkTypeName]) VALUES (3, N'Bán thời gian')
INSERT [dbo].[WorkTypes] ([WorkTypeID], [WorkTypeName]) VALUES (4, N'Làm ca')
INSERT [dbo].[WorkTypes] ([WorkTypeID], [WorkTypeName]) VALUES (5, N'Làm thời vụ')
SET IDENTITY_INSERT [dbo].[WorkTypes] OFF
ALTER TABLE [dbo].[Registration] ADD  CONSTRAINT [DF_Registration_RegistrationDate]  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[ResumeDetails] ADD  CONSTRAINT [DF_ResumeDetails_SalaryFrom]  DEFAULT ((100)) FOR [SalaryLevelID]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_PhotoPath]  DEFAULT ((0)) FOR [PhotoPath]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_NewsLetter]  DEFAULT ((1)) FOR [NewsLetter]
GO
ALTER TABLE [dbo].[Recruitor]  WITH CHECK ADD  CONSTRAINT [FK_Recruitor_CompanySize] FOREIGN KEY([CompanySizeID])
REFERENCES [dbo].[CompanySize] ([CompanySizeID])
GO
ALTER TABLE [dbo].[Recruitor] CHECK CONSTRAINT [FK_Recruitor_CompanySize]
GO
USE [master]
GO
ALTER DATABASE [WebTuyenDung] SET  READ_WRITE 
GO
