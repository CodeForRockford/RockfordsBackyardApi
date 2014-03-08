USE [master]
GO
/****** Object:  Database [WhatWhenWhere]    Script Date: 3/8/2014 11:52:02 AM ******/
CREATE DATABASE [WhatWhenWhere]
GO
ALTER DATABASE [WhatWhenWhere] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WhatWhenWhere].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [WhatWhenWhere] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET ARITHABORT OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WhatWhenWhere] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WhatWhenWhere] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WhatWhenWhere] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WhatWhenWhere] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [WhatWhenWhere] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WhatWhenWhere] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [WhatWhenWhere] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WhatWhenWhere] SET RECOVERY FULL 
GO
ALTER DATABASE [WhatWhenWhere] SET  MULTI_USER 
GO
ALTER DATABASE [WhatWhenWhere] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WhatWhenWhere] SET DB_CHAINING OFF 
GO
USE [WhatWhenWhere]
GO
/****** Object:  StoredProcedure [dbo].[GetOrganizationByEmail]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetOrganizationByEmail]
@email nvarchar(256)
as
select organization
from organizations o inner join Memberships m on o.userid = m.userid
where m.email = @email
GO
/****** Object:  StoredProcedure [dbo].[GetOrganizationByName]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetOrganizationByName]
@name nvarchar(50)
as
select org
from organizations
where name = @name

GO
/****** Object:  StoredProcedure [dbo].[InsertOrganization]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertOrganization]
@Name nvarchar(50),
@Org nvarchar(255)
as
insert into organizations values (@Name, @Org)
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationName] [nvarchar](235) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[events]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[eventId] [int] IDENTITY(1,1) NOT NULL,
	[Sponsor] [nvarchar](max) NULL,
	[NameOfEvent] [nvarchar](max) NULL,
	[StartDate] [nvarchar](max) NULL,
	[EndDate] [nvarchar](max) NULL,
	[EventSite] [nvarchar](max) NULL,
	[EventAddress] [nvarchar](max) NULL,
	[RoomNights] [nvarchar](max) NULL,
	[Attendance] [nvarchar](max) NULL,
	[HQHotel] [nvarchar](max) NULL,
	[HotelAddress] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Time] [nvarchar](max) NULL,
	[ContactPhone] [nvarchar](max) NULL,
	[ContactEmail] [nvarchar](max) NULL,
	[User_ID] [nvarchar](max) NULL,
 CONSTRAINT [PK_events] PRIMARY KEY CLUSTERED 
(
	[eventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Memberships](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
	[Comment] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[Name] [nvarchar](50) NOT NULL,
	[Org] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [nvarchar](4000) NOT NULL,
	[PropertyValueStrings] [nvarchar](4000) NOT NULL,
	[PropertyValueBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/8/2014 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/8/2014 11:52:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 3/8/2014 11:52:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UsersOpenAuthAccounts]    Script Date: 3/8/2014 11:52:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersOpenAuthAccounts](
	[ApplicationName] [nvarchar](128) NOT NULL,
	[ProviderName] [nvarchar](128) NOT NULL,
	[ProviderUserId] [nvarchar](128) NOT NULL,
	[ProviderUserName] [nvarchar](max) NOT NULL,
	[MembershipUserName] [nvarchar](128) NOT NULL,
	[LastUsedUtc] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationName] ASC,
	[ProviderName] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UsersOpenAuthData]    Script Date: 3/8/2014 11:52:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersOpenAuthData](
	[ApplicationName] [nvarchar](128) NOT NULL,
	[MembershipUserName] [nvarchar](128) NOT NULL,
	[HasLocalPassword] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationName] ASC,
	[MembershipUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipApplication]
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipUser]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [UserProfile]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [RoleApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleApplication]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [UserApplication] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [UserApplication]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleRole]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRoleUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRoleUser]
GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts]  WITH CHECK ADD  CONSTRAINT [OpenAuthAccount_UserData] FOREIGN KEY([ApplicationName], [MembershipUserName])
REFERENCES [dbo].[UsersOpenAuthData] ([ApplicationName], [MembershipUserName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts] CHECK CONSTRAINT [OpenAuthAccount_UserData]
GO
USE [master]
GO
ALTER DATABASE [WhatWhenWhere] SET  READ_WRITE 
GO
