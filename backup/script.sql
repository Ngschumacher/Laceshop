USE [master]
GO
/****** Object:  Database [Laceshop]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE DATABASE [Laceshop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Laceshop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Laceshop.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Laceshop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Laceshop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Laceshop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Laceshop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Laceshop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Laceshop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Laceshop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Laceshop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Laceshop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Laceshop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Laceshop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Laceshop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Laceshop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Laceshop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Laceshop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Laceshop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Laceshop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Laceshop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Laceshop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Laceshop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Laceshop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Laceshop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Laceshop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Laceshop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Laceshop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Laceshop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Laceshop] SET  MULTI_USER 
GO
ALTER DATABASE [Laceshop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Laceshop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Laceshop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Laceshop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Laceshop]
GO
/****** Object:  User [Laceshop]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE USER [Laceshop] FOR LOGIN [Laceshop] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Laceshop]
GO
/****** Object:  Table [dbo].[cmsContent]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[contentType] [int] NOT NULL,
 CONSTRAINT [PK_cmsContent] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[thumbnail] [nvarchar](255) NOT NULL CONSTRAINT [DF_cmsContentType_thumbnail]  DEFAULT ('folder.png'),
	[description] [nvarchar](1500) NULL,
	[isContainer] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_isContainer]  DEFAULT ('0'),
	[allowAtRoot] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_allowAtRoot]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType2ContentType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType2ContentType](
	[parentContentTypeId] [int] NOT NULL,
	[childContentTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsContentType2ContentType] PRIMARY KEY CLUSTERED 
(
	[parentContentTypeId] ASC,
	[childContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentTypeAllowedContentType](
	[Id] [int] NOT NULL,
	[AllowedId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL CONSTRAINT [df_cmsContentTypeAllowedContentType_sortOrder]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AllowedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentVersion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[VersionDate] [datetime] NOT NULL CONSTRAINT [DF_cmsContentVersion_VersionDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentXml](
	[nodeId] [int] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[propertyEditorAlias] [nvarchar](255) NOT NULL,
	[dbType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_cmsDataType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataTypePreValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datatypeNodeId] [int] NOT NULL,
	[value] [ntext] NULL,
	[sortorder] [int] NOT NULL,
	[alias] [nvarchar](50) NULL,
 CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDictionary](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[parent] [uniqueidentifier] NULL,
	[key] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsDictionary] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocument](
	[nodeId] [int] NOT NULL,
	[published] [bit] NOT NULL,
	[documentUser] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[releaseDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_cmsDocument_updateDate]  DEFAULT (getdate()),
	[templateId] [int] NULL,
	[newest] [bit] NOT NULL CONSTRAINT [DF_cmsDocument_newest]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocument] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocumentType](
	[contentTypeNodeId] [int] NOT NULL,
	[templateNodeId] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_cmsDocumentType_IsDefault]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY CLUSTERED 
(
	[contentTypeNodeId] ASC,
	[templateNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsLanguageText](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[languageId] [int] NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[macroUseInEditor] [bit] NOT NULL,
	[macroRefreshRate] [int] NOT NULL,
	[macroAlias] [nvarchar](255) NOT NULL,
	[macroName] [nvarchar](255) NULL,
	[macroScriptType] [nvarchar](255) NULL,
	[macroScriptAssembly] [nvarchar](255) NULL,
	[macroXSLT] [nvarchar](255) NULL,
	[macroCacheByPage] [bit] NOT NULL,
	[macroCachePersonalized] [bit] NOT NULL,
	[macroDontRender] [bit] NOT NULL,
	[macroPython] [nvarchar](255) NULL,
 CONSTRAINT [PK_cmsMacro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacroProperty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[editorAlias] [nvarchar](255) NOT NULL,
	[macro] [int] NOT NULL,
	[macroPropertySortOrder] [int] NOT NULL,
	[macroPropertyAlias] [nvarchar](50) NOT NULL,
	[macroPropertyName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember](
	[nodeId] [int] NOT NULL,
	[Email] [nvarchar](1000) NOT NULL,
	[LoginName] [nvarchar](1000) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsMember] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember2MemberGroup](
	[Member] [int] NOT NULL,
	[MemberGroup] [int] NOT NULL,
 CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY CLUSTERED 
(
	[Member] ASC,
	[MemberGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMemberType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[propertytypeId] [int] NOT NULL,
	[memberCanEdit] [bit] NOT NULL,
	[viewOnProfile] [bit] NOT NULL,
 CONSTRAINT [PK_cmsMemberType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPreviewXml](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentNodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NULL,
	[propertytypeid] [int] NOT NULL,
	[dataInt] [int] NULL,
	[dataDate] [datetime] NULL,
	[dataNvarchar] [nvarchar](500) NULL,
	[dataNtext] [ntext] NULL,
 CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dataTypeId] [int] NOT NULL,
	[contentTypeId] [int] NOT NULL,
	[propertyTypeGroupId] [int] NULL,
	[Alias] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[sortOrder] [int] NOT NULL CONSTRAINT [DF_cmsPropertyType_sortOrder]  DEFAULT ('0'),
	[mandatory] [bit] NOT NULL CONSTRAINT [DF_cmsPropertyType_mandatory]  DEFAULT ('0'),
	[validationRegExp] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
	[UniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyType_UniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyTypeGroup]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyTypeGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentGroupId] [int] NULL,
	[contenttypeNodeId] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[sortorder] [int] NOT NULL,
 CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsStylesheet]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsStylesheet](
	[nodeId] [int] NOT NULL,
	[filename] [nvarchar](100) NOT NULL,
	[content] [ntext] NULL,
 CONSTRAINT [PK_cmsStylesheet] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsStylesheetProperty]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsStylesheetProperty](
	[nodeId] [int] NOT NULL,
	[stylesheetPropertyEditor] [bit] NULL,
	[stylesheetPropertyAlias] [nvarchar](50) NULL,
	[stylesheetPropertyValue] [nvarchar](400) NULL,
 CONSTRAINT [PK_cmsStylesheetProperty] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTagRelationship](
	[nodeId] [int] NOT NULL,
	[tagId] [int] NOT NULL,
	[propertyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[propertyTypeId] ASC,
	[tagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTags]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[group] [nvarchar](100) NULL,
 CONSTRAINT [PK_cmsTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTask]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTask](
	[closed] [bit] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskTypeId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[parentUserId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_cmsTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTaskType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsTaskType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTemplate](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](100) NULL,
	[design] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsTemplate] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchAnonymousCustomer]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchAnonymousCustomer](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchAnonymousCustomer_pk]  DEFAULT ('newid()'),
	[lastActivityDate] [datetime] NOT NULL CONSTRAINT [DF_merchAnonymousCustomer_lastActivityDate]  DEFAULT (getdate()),
	[extendedData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchAnonymousCustomer_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchAnonymousCustomer_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchAnonymousCustomer] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchAppliedPayment]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchAppliedPayment](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchAppliedPayment_pk]  DEFAULT ('newid()'),
	[paymentKey] [uniqueidentifier] NOT NULL,
	[invoiceKey] [uniqueidentifier] NOT NULL,
	[appliedPaymentTfKey] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[amount] [decimal](38, 6) NOT NULL,
	[exported] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchAppliedPayment_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchAppliedPayment_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchAppliedPayment] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchAuditLog]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchAuditLog](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchAuditLog_pk]  DEFAULT ('newid()'),
	[entityKey] [uniqueidentifier] NULL,
	[entityTfKey] [uniqueidentifier] NULL,
	[message] [ntext] NULL,
	[verbosity] [int] NOT NULL CONSTRAINT [DF_merchAuditLog_verbosity]  DEFAULT ('0'),
	[extendedData] [ntext] NULL,
	[isError] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchAuditLog_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchAuditLog_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchAuditLog] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchCatalogInventory]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchCatalogInventory](
	[catalogKey] [uniqueidentifier] NOT NULL,
	[productVariantKey] [uniqueidentifier] NOT NULL,
	[count] [int] NOT NULL,
	[lowCount] [int] NOT NULL,
	[location] [nvarchar](255) NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchCatalogInventory_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchCatalogInventory_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchCatalogInventory] PRIMARY KEY CLUSTERED 
(
	[catalogKey] ASC,
	[productVariantKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchCustomer]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchCustomer](
	[pk] [uniqueidentifier] NOT NULL,
	[loginName] [nvarchar](255) NOT NULL,
	[firstName] [nvarchar](255) NOT NULL,
	[lastName] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[taxExempt] [bit] NOT NULL,
	[lastActivityDate] [datetime] NOT NULL,
	[extendedData] [ntext] NULL,
	[notes] [ntext] NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchCustomer] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchCustomer2EntityCollection]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchCustomer2EntityCollection](
	[customerKey] [uniqueidentifier] NOT NULL,
	[entityCollectionKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchCustomer2EntityCollection] PRIMARY KEY CLUSTERED 
(
	[customerKey] ASC,
	[entityCollectionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchCustomerAddress]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchCustomerAddress](
	[pk] [uniqueidentifier] NOT NULL,
	[customerKey] [uniqueidentifier] NOT NULL,
	[label] [nvarchar](255) NULL,
	[fullName] [nvarchar](255) NULL,
	[company] [nvarchar](255) NULL,
	[addressTfKey] [uniqueidentifier] NOT NULL,
	[address1] [nvarchar](255) NULL,
	[address2] [nvarchar](255) NULL,
	[locality] [nvarchar](255) NULL,
	[region] [nvarchar](255) NULL,
	[postalCode] [nvarchar](255) NULL,
	[countryCode] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[isDefault] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchCustomerAddress] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchCustomerIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchCustomerIndex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customerKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchCustomerIndex] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchDetachedContentType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchDetachedContentType](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchDetachedContentType_pk]  DEFAULT ('newid()'),
	[entityTfKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[contentTypeKey] [uniqueidentifier] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchDetachedContentType_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchDetachedContentType_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchDetachedContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchEntityCollection]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchEntityCollection](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchEntityCollection_pk]  DEFAULT ('newid()'),
	[parentKey] [uniqueidentifier] NULL,
	[entityTfKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[sortOrder] [int] NOT NULL CONSTRAINT [DF_merchEntityCollection_sortOrder]  DEFAULT ('0'),
	[providerKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchEntityCollection_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchEntityCollection_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchEntityCollection] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchGatewayProviderSettings]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchGatewayProviderSettings](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchGatewayProviderSettings_pk]  DEFAULT ('newid()'),
	[providerTfKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
	[extendedData] [ntext] NULL,
	[encryptExtendedData] [bit] NOT NULL CONSTRAINT [DF_merchGatewayProviderSettings_encryptExtendedData]  DEFAULT ('0'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchGatewayProviderSettings_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchGatewayProviderSettings_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchGatewayProviderSettings] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchInvoice]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchInvoice](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchInvoice_pk]  DEFAULT ('newid()'),
	[customerKey] [uniqueidentifier] NULL,
	[invoiceNumberPrefix] [nvarchar](255) NULL,
	[invoiceNumber] [int] NOT NULL,
	[poNumber] [nvarchar](255) NULL,
	[invoiceDate] [datetime] NOT NULL,
	[invoiceStatusKey] [uniqueidentifier] NOT NULL,
	[versionKey] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchInvoice_versionKey]  DEFAULT ('newid()'),
	[billToName] [nvarchar](255) NULL,
	[billToAddress1] [nvarchar](255) NULL,
	[billToAddress2] [nvarchar](255) NULL,
	[billToLocality] [nvarchar](255) NULL,
	[billToRegion] [nvarchar](255) NULL,
	[billToPostalCode] [nvarchar](255) NULL,
	[billToCountryCode] [nvarchar](255) NULL,
	[billToEmail] [nvarchar](255) NULL,
	[billToPhone] [nvarchar](255) NULL,
	[billToCompany] [nvarchar](255) NULL,
	[exported] [bit] NOT NULL,
	[archived] [bit] NOT NULL,
	[total] [decimal](38, 6) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoice_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoice_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchInvoice] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchInvoice2EntityCollection]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchInvoice2EntityCollection](
	[invoiceKey] [uniqueidentifier] NOT NULL,
	[entityCollectionKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchInvoice2EntityCollection] PRIMARY KEY CLUSTERED 
(
	[invoiceKey] ASC,
	[entityCollectionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchInvoiceIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchInvoiceIndex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[invoiceKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceIndex_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceIndex_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchInvoiceIndex] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchInvoiceItem]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchInvoiceItem](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchInvoiceItem_pk]  DEFAULT ('newid()'),
	[invoiceKey] [uniqueidentifier] NOT NULL,
	[lineItemTfKey] [uniqueidentifier] NOT NULL,
	[sku] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](38, 6) NOT NULL,
	[exported] [bit] NOT NULL,
	[extendedData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceItem_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceItem_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchInvoiceItem] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchInvoiceStatus]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchInvoiceStatus](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchInvoiceStatus_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[reportable] [bit] NOT NULL,
	[active] [bit] NOT NULL,
	[sortOrder] [int] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceStatus_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchInvoiceStatus_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchInvoiceStatus] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchItemCache]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchItemCache](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchItemCache_pk]  DEFAULT ('newid()'),
	[entityKey] [uniqueidentifier] NOT NULL,
	[itemCacheTfKey] [uniqueidentifier] NOT NULL,
	[versionKey] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchItemCache_versionKey]  DEFAULT ('newid()'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchItemCache_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchItemCache_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchItemCache] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchItemCacheItem]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchItemCacheItem](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchItemCacheItem_pk]  DEFAULT ('newid()'),
	[itemCacheKey] [uniqueidentifier] NOT NULL,
	[lineItemTfKey] [uniqueidentifier] NOT NULL,
	[sku] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](38, 6) NOT NULL,
	[extendedData] [ntext] NULL,
	[exported] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchItemCacheItem_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchItemCacheItem_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchItemCacheItem] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchNote]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchNote](
	[pk] [uniqueidentifier] NOT NULL,
	[entityKey] [uniqueidentifier] NULL,
	[entityTfKey] [uniqueidentifier] NULL,
	[message] [ntext] NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchNote] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchNotificationMessage]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchNotificationMessage](
	[pk] [uniqueidentifier] NOT NULL,
	[methodKey] [uniqueidentifier] NOT NULL,
	[monitorKey] [uniqueidentifier] NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
	[fromAddress] [nvarchar](255) NULL,
	[replyTo] [nvarchar](255) NULL,
	[bodyText] [ntext] NULL,
	[maxLength] [int] NOT NULL,
	[bodyTextIsFilePath] [bit] NOT NULL,
	[recipients] [nvarchar](255) NOT NULL,
	[sendToCustomer] [bit] NOT NULL,
	[disabled] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchNotificationMessage] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchNotificationMethod]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchNotificationMethod](
	[pk] [uniqueidentifier] NOT NULL,
	[providerKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
	[serviceCode] [nvarchar](255) NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchNotificationMethod] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOfferRedeemed]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOfferRedeemed](
	[pk] [uniqueidentifier] NOT NULL,
	[offerSettingsKey] [uniqueidentifier] NULL,
	[offerCode] [nvarchar](255) NOT NULL,
	[offerProviderKey] [uniqueidentifier] NOT NULL,
	[customerKey] [uniqueidentifier] NULL,
	[invoiceKey] [uniqueidentifier] NOT NULL,
	[redeemedDate] [datetime] NOT NULL,
	[extendedData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchOfferRedeemed] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOfferSettings]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOfferSettings](
	[pk] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[offerCode] [nvarchar](255) NOT NULL,
	[offerProviderKey] [uniqueidentifier] NOT NULL,
	[offerStartsDate] [datetime] NULL,
	[offerEndsDate] [datetime] NULL,
	[active] [bit] NOT NULL,
	[configurationData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchOfferSettings] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOrder]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOrder](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchOrder_pk]  DEFAULT ('newid()'),
	[invoiceKey] [uniqueidentifier] NULL,
	[orderNumberPrefix] [nvarchar](255) NULL,
	[orderNumber] [int] NOT NULL,
	[orderDate] [datetime] NOT NULL,
	[orderStatusKey] [uniqueidentifier] NOT NULL,
	[versionKey] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchOrder_versionKey]  DEFAULT ('newid()'),
	[exported] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrder_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrder_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchOrder] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOrderIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOrderIndex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderIndex_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderIndex_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchOrderIndex] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOrderItem]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOrderItem](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchOrderItem_pk]  DEFAULT ('newid()'),
	[orderKey] [uniqueidentifier] NOT NULL,
	[shipmentKey] [uniqueidentifier] NULL,
	[lineItemTfKey] [uniqueidentifier] NOT NULL,
	[sku] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](38, 6) NOT NULL,
	[backOrder] [bit] NOT NULL,
	[exported] [bit] NOT NULL,
	[extendedData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderItem_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderItem_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchOrderItem] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchOrderStatus]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchOrderStatus](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchOrderStatus_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[reportable] [bit] NOT NULL,
	[active] [bit] NOT NULL,
	[sortOrder] [int] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderStatus_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchOrderStatus_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchOrderStatus] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchPayment]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchPayment](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchPayment_pk]  DEFAULT ('newid()'),
	[customerKey] [uniqueidentifier] NULL,
	[paymentMethodKey] [uniqueidentifier] NULL,
	[paymentTfKey] [uniqueidentifier] NOT NULL,
	[paymentMethodName] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](255) NULL,
	[amount] [decimal](38, 6) NOT NULL,
	[authorized] [bit] NOT NULL CONSTRAINT [DF_merchPayment_authorized]  DEFAULT ('1'),
	[collected] [bit] NOT NULL CONSTRAINT [DF_merchPayment_collected]  DEFAULT ('1'),
	[voided] [bit] NOT NULL CONSTRAINT [DF_merchPayment_voided]  DEFAULT ('0'),
	[extendedData] [ntext] NULL,
	[exported] [bit] NOT NULL CONSTRAINT [DF_merchPayment_exported]  DEFAULT ('0'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchPayment_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchPayment_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchPayment] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchPaymentMethod]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchPaymentMethod](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchPaymentMethod_pk]  DEFAULT ('newid()'),
	[providerKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
	[paymentCode] [nvarchar](255) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchPaymentMethod_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchPaymentMethod_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchPaymentMethod] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProduct]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProduct](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchProduct_pk]  DEFAULT ('newid()'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProduct_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProduct_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProduct] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProduct2EntityCollection]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProduct2EntityCollection](
	[productKey] [uniqueidentifier] NOT NULL,
	[entityCollectionKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchProduct2EntityCollection] PRIMARY KEY CLUSTERED 
(
	[productKey] ASC,
	[entityCollectionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProduct2ProductOption]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProduct2ProductOption](
	[productKey] [uniqueidentifier] NOT NULL,
	[optionKey] [uniqueidentifier] NOT NULL,
	[sortOrder] [int] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProduct2ProductOption_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProduct2ProductOption_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProduct2Option] PRIMARY KEY CLUSTERED 
(
	[productKey] ASC,
	[optionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductAttribute]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductAttribute](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchProductAttribute_pk]  DEFAULT ('newid()'),
	[optionKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[sku] [nvarchar](255) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductAttribute_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductAttribute_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProductAttribute] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductOption]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductOption](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchProductOption_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[required] [bit] NOT NULL CONSTRAINT [DF_merchProductOption_required]  DEFAULT ('0'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductOption_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductOption_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProductOption] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductVariant]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductVariant](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchProductVariant_pk]  DEFAULT ('newid()'),
	[productKey] [uniqueidentifier] NOT NULL,
	[sku] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[price] [decimal](38, 6) NOT NULL,
	[costOfGoods] [decimal](38, 6) NULL,
	[salePrice] [decimal](38, 6) NULL,
	[onSale] [bit] NOT NULL,
	[manufacturer] [nvarchar](255) NULL,
	[modelNumber] [nvarchar](255) NULL,
	[weight] [decimal](38, 6) NULL,
	[length] [decimal](38, 6) NULL,
	[width] [decimal](38, 6) NULL,
	[height] [decimal](38, 6) NULL,
	[barcode] [nvarchar](255) NULL,
	[available] [bit] NOT NULL,
	[trackInventory] [bit] NOT NULL CONSTRAINT [DF_merchProductVariant_trackInventory]  DEFAULT ('1'),
	[outOfStockPurchase] [bit] NOT NULL,
	[taxable] [bit] NOT NULL CONSTRAINT [DF_merchProductVariant_taxable]  DEFAULT ('1'),
	[shippable] [bit] NOT NULL CONSTRAINT [DF_merchProductVariant_shippable]  DEFAULT ('1'),
	[download] [bit] NOT NULL CONSTRAINT [DF_merchProductVariant_download]  DEFAULT ('0'),
	[downloadMediaId] [int] NULL,
	[master] [bit] NOT NULL CONSTRAINT [DF_merchProductVariant_master]  DEFAULT ('0'),
	[versionKey] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchProductVariant_versionKey]  DEFAULT ('newid()'),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariant_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariant_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProductVariant] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductVariant2ProductAttribute]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductVariant2ProductAttribute](
	[productVariantKey] [uniqueidentifier] NOT NULL,
	[optionKey] [uniqueidentifier] NOT NULL,
	[productAttributeKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariant2ProductAttribute_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariant2ProductAttribute_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProductVariant2ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[productVariantKey] ASC,
	[optionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductVariantDetachedContent]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductVariantDetachedContent](
	[pk] [uniqueidentifier] NOT NULL,
	[productVariantKey] [uniqueidentifier] NOT NULL,
	[cultureName] [nvarchar](255) NOT NULL,
	[detachedContentTypeKey] [uniqueidentifier] NOT NULL,
	[values] [ntext] NULL,
	[templateId] [int] NULL,
	[slug] [nvarchar](255) NULL,
	[canBeRendered] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchProductVariantDetachedContent] PRIMARY KEY CLUSTERED 
(
	[productVariantKey] ASC,
	[cultureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchProductVariantIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchProductVariantIndex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productVariantKey] [uniqueidentifier] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariantIndex_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchProductVariantIndex_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchProductVariantIndex] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchShipCountry]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchShipCountry](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipCountry_pk]  DEFAULT ('newid()'),
	[catalogKey] [uniqueidentifier] NOT NULL,
	[countryCode] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipCountry_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipCountry_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchShipCountry] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchShipment]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchShipment](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipment_pk]  DEFAULT ('newid()'),
	[shipmentNumberPrefix] [nvarchar](255) NULL,
	[shipmentNumber] [int] NOT NULL,
	[shipmentStatusKey] [uniqueidentifier] NOT NULL,
	[shippedDate] [datetime] NOT NULL,
	[fromOrganization] [nvarchar](255) NULL,
	[fromName] [nvarchar](255) NULL,
	[fromAddress1] [nvarchar](255) NULL,
	[fromAddress2] [nvarchar](255) NULL,
	[fromLocality] [nvarchar](255) NULL,
	[fromRegion] [nvarchar](255) NULL,
	[fromPostalCode] [nvarchar](255) NULL,
	[fromCountryCode] [nvarchar](255) NULL,
	[fromIsCommercial] [bit] NOT NULL,
	[toOrganization] [nvarchar](255) NULL,
	[toName] [nvarchar](255) NULL,
	[toAddress1] [nvarchar](255) NULL,
	[toAddress2] [nvarchar](255) NULL,
	[toLocality] [nvarchar](255) NULL,
	[toRegion] [nvarchar](255) NULL,
	[toPostalCode] [nvarchar](255) NULL,
	[toCountryCode] [nvarchar](255) NULL,
	[toIsCommercial] [bit] NOT NULL,
	[phone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[shipMethodKey] [uniqueidentifier] NULL,
	[versionKey] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipment_versionKey]  DEFAULT ('newid()'),
	[carrier] [nvarchar](255) NULL,
	[trackingCode] [nvarchar](255) NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipment_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipment_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchShipment] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchShipmentStatus]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchShipmentStatus](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipmentStatus_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[reportable] [bit] NOT NULL,
	[active] [bit] NOT NULL,
	[sortOrder] [int] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipmentStatus_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipmentStatus_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchShipmentStatus] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchShipMethod]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchShipMethod](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipMethod_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[shipCountryKey] [uniqueidentifier] NOT NULL,
	[providerKey] [uniqueidentifier] NOT NULL,
	[surcharge] [decimal](38, 6) NOT NULL CONSTRAINT [DF_merchShipMethod_surcharge]  DEFAULT ('0'),
	[serviceCode] [nvarchar](255) NULL,
	[taxable] [bit] NOT NULL,
	[provinceData] [ntext] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipMethod_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipMethod_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchShipMethod] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchShipRateTier]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchShipRateTier](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchShipRateTier_pk]  DEFAULT ('newid()'),
	[shipMethodKey] [uniqueidentifier] NOT NULL,
	[rangeLow] [decimal](38, 6) NOT NULL,
	[rangeHigh] [decimal](38, 6) NOT NULL,
	[rate] [decimal](38, 6) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipRateTier_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchShipRateTier_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchShipRateTier] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchStoreSetting]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchStoreSetting](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchStoreSetting_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[value] [nvarchar](255) NOT NULL,
	[typeName] [nvarchar](255) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchStoreSetting_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchStoreSetting_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchStoreSetting] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchTaxMethod]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchTaxMethod](
	[pk] [uniqueidentifier] NOT NULL,
	[providerKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NULL,
	[countryCode] [nvarchar](255) NOT NULL,
	[percentageTaxRate] [decimal](38, 6) NOT NULL,
	[provinceData] [ntext] NULL,
	[productTaxMethod] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_merchTaxMethod] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchTypeField]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchTypeField](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchTypeField_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchTypeField_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchTypeField_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchTypeField] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchWarehouse]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchWarehouse](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchWarehouse_pk]  DEFAULT ('newid()'),
	[name] [nvarchar](255) NOT NULL,
	[address1] [nvarchar](255) NULL,
	[address2] [nvarchar](255) NULL,
	[locality] [nvarchar](255) NULL,
	[region] [nvarchar](255) NULL,
	[postalCode] [nvarchar](255) NULL,
	[countryCode] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[isDefault] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchWarehouse_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchWarehouse_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchWarehouse] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[merchWarehouseCatalog]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchWarehouseCatalog](
	[pk] [uniqueidentifier] NOT NULL CONSTRAINT [DF_merchWarehouseCatalog_pk]  DEFAULT ('newid()'),
	[warehouseKey] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NULL,
	[description] [nvarchar](500) NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_merchWarehouseCatalog_updateDate]  DEFAULT (getdate()),
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_merchWarehouseCatalog_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_merchWarehouseCatalog] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccess]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccess](
	[id] [uniqueidentifier] NOT NULL,
	[nodeId] [int] NOT NULL,
	[loginNodeId] [int] NOT NULL,
	[noAccessNodeId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccess] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccessRule]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccessRule](
	[id] [uniqueidentifier] NOT NULL,
	[accessId] [uniqueidentifier] NOT NULL,
	[ruleValue] [nvarchar](255) NOT NULL,
	[ruleType] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoCacheInstruction]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoCacheInstruction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[utcStamp] [datetime] NOT NULL,
	[jsonInstruction] [ntext] NOT NULL,
	[originated] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDomains](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[domainDefaultLanguage] [int] NULL,
	[domainRootStructureID] [int] NULL,
	[domainName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoDomains] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoExternalLogin]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoExternalLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[loginProvider] [nvarchar](4000) NOT NULL,
	[providerKey] [nvarchar](4000) NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLanguage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[languageISOCode] [nvarchar](10) NULL,
	[languageCultureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[Datestamp] [datetime] NOT NULL CONSTRAINT [DF_umbracoLog_Datestamp]  DEFAULT (getdate()),
	[logHeader] [nvarchar](50) NOT NULL,
	[logComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_umbracoLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoMigration]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoMigration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoMigration_createDate]  DEFAULT (getdate()),
	[version] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_umbracoMigration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trashed] [bit] NOT NULL CONSTRAINT [DF_umbracoNode_trashed]  DEFAULT ('0'),
	[parentID] [int] NOT NULL,
	[nodeUser] [int] NULL,
	[level] [int] NOT NULL,
	[path] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_umbracoNode_uniqueID]  DEFAULT (newid()),
	[text] [nvarchar](255) NULL,
	[nodeObjectType] [uniqueidentifier] NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoNode_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NOT NULL,
	[childId] [int] NOT NULL,
	[relType] [int] NOT NULL,
	[datetime] [datetime] NOT NULL CONSTRAINT [DF_umbracoRelation_datetime]  DEFAULT (getdate()),
	[comment] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_umbracoRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelationType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dual] [bit] NOT NULL,
	[parentObjectType] [uniqueidentifier] NOT NULL,
	[childObjectType] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoServer]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoServer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[computerName] [nvarchar](255) NOT NULL,
	[registeredDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoServer_registeredDate]  DEFAULT (getdate()),
	[lastNotifiedDate] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isMaster] [bit] NOT NULL,
 CONSTRAINT [PK_umbracoServer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userDisabled] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userDisabled]  DEFAULT ('0'),
	[userNoConsole] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userNoConsole]  DEFAULT ('0'),
	[userType] [int] NOT NULL,
	[startStructureID] [int] NOT NULL,
	[startMediaID] [int] NULL,
	[userName] [nvarchar](255) NOT NULL,
	[userLogin] [nvarchar](125) NOT NULL,
	[userPassword] [nvarchar](500) NOT NULL,
	[userEmail] [nvarchar](255) NOT NULL,
	[userLanguage] [nvarchar](10) NULL,
	[securityStampToken] [nvarchar](255) NULL,
	[failedLoginAttempts] [int] NULL,
	[lastLockoutDate] [datetime] NULL,
	[lastPasswordChangeDate] [datetime] NULL,
	[lastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2app]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2app](
	[user] [int] NOT NULL,
	[app] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_user2app] PRIMARY KEY CLUSTERED 
(
	[user] ASC,
	[app] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodeNotify](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[action] [nchar](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodePermission]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodePermission](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[permission] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodePermission] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserType]    Script Date: 12/19/2015 2:54:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userTypeAlias] [nvarchar](50) NULL,
	[userTypeName] [nvarchar](255) NOT NULL,
	[userTypeDefaultPermissions] [nvarchar](50) NULL,
 CONSTRAINT [PK_umbracoUserType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[cmsContent] ON 

INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (3, 2071, 2070)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (4, 2072, 2068)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (5, 2073, 2067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (6, 2074, 2067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (7, 2077, 2075)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (8, 2090, 2080)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (9, 2092, 2080)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (10, 2095, 2094)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (11, 2100, 2099)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (12, 2101, 2070)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (13, 2102, 2070)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (14, 2104, 2075)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (15, 2105, 2080)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (16, 2106, 2094)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (17, 2107, 2068)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (18, 2109, 2067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (19, 2110, 2067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (20, 2113, 2112)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (21, 2116, 2115)
SET IDENTITY_INSERT [dbo].[cmsContent] OFF
SET IDENTITY_INSERT [dbo].[cmsContentType] ON 

INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (531, 1044, N'Member', N'icon-user', N'icon-user', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (532, 1031, N'Folder', N'icon-folder', N'icon-folder', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (533, 1032, N'Image', N'icon-picture', N'icon-picture', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (534, 1033, N'File', N'icon-document', N'icon-document', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (544, 2066, N'Master', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (545, 2067, N'Product', N'.sprTreeFolder', N'folder.png', N'', 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (546, 2068, N'Products', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (547, 2070, N'Home', N'icon-home', N'folder.png', N'', 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (548, 2075, N'BasketPage', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (549, 2079, N'CheckoutFolder', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (550, 2080, N'CheckoutPage', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (551, 2081, N'CheckoutBegin', N'.sprTreeFolder', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (552, 2083, N'CheckoutAddress', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (553, 2085, N'CheckoutInvoice', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (555, 2087, N'CheckoutPayment', N'.sprTreeFolder', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (556, 2094, N'DeliveryPage', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (557, 2099, N'Test', N'.sprTreeFolder', N'folder.png', N'', 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (558, 2112, N'PaymentPage', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (559, 2115, N'ReceiptPage', N'.sprTreeFolder', N'folder.png', N'', 0, 0)
SET IDENTITY_INSERT [dbo].[cmsContentType] OFF
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2067)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2068)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2070)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2075)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2080)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2094)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2112)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2066, 2115)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2079, 2081)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2079, 2083)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2079, 2085)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (2079, 2087)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1031, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1032, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1033, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2066, 2112, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2068, 2067, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2068, 10)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2075, 6)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2080, 7)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2094, 8)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2112, 9)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2070, 2115, 11)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (2079, 2080, 1)
SET IDENTITY_INSERT [dbo].[cmsContentVersion] ON 

INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (15, 2071, N'87f548e9-834e-4ad2-90a7-18d68385b245', CAST(N'2015-12-11 22:00:55.907' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (16, 2072, N'c408c6d1-e862-44b2-96fc-70dd0eeb9dbc', CAST(N'2015-12-07 20:55:34.360' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (17, 2073, N'0e7fb840-e9fe-4467-a0ba-19f84fa89bd1', CAST(N'2015-12-07 21:28:00.100' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (18, 2074, N'e6fa650e-41fc-40ff-9dee-9472ad7526e8', CAST(N'2015-12-07 20:56:37.113' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (19, 2074, N'3577dbb4-43e8-4c40-9bc2-f9d37e2c295f', CAST(N'2015-12-07 20:56:55.540' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (20, 2074, N'bdf0373d-9a44-40f0-b041-f20eaa96b20e', CAST(N'2015-12-07 20:57:56.940' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (21, 2077, N'9022a154-dfef-40b1-9825-f874f59e1924', CAST(N'2015-12-12 00:23:08.583' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (22, 2090, N'e369ecea-25c5-4f02-bbc9-1060834b1303', CAST(N'2015-12-11 19:05:14.007' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (23, 2090, N'd44ede21-bcc0-400c-b32d-0b502c35fdf5', CAST(N'2015-12-11 19:13:14.003' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (24, 2090, N'd4283eb8-7985-49de-8ad2-3ff9d93a3d6e', CAST(N'2015-12-11 19:13:35.633' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (25, 2090, N'abf84558-cbd6-44b9-abc5-05b9ae8c0b40', CAST(N'2015-12-11 19:13:35.847' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (26, 2092, N'b7123cea-4f7e-4039-a16d-a081292bd448', CAST(N'2015-12-11 19:15:05.640' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (27, 2095, N'ad138188-09bd-4ff9-ab66-92ca07eabeea', CAST(N'2015-12-11 19:51:36.650' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (28, 2095, N'0777bb69-71fa-49fa-af81-954b70cffb66', CAST(N'2015-12-11 19:51:46.730' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (29, 2071, N'00dbbf4d-b597-4221-af6e-9df33aa645ae', CAST(N'2015-12-11 22:03:12.077' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (30, 2100, N'662a43c0-a7e8-4f89-a0eb-4ce4d5ca31b6', CAST(N'2015-12-11 22:10:38.860' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (31, 2101, N'be6fd03f-a9f2-4d2e-9442-4dd1ddd3d7f5', CAST(N'2015-12-11 22:10:53.967' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (32, 2101, N'013bdce6-a661-45a2-9cdf-ded4fcbecc36', CAST(N'2015-12-11 22:11:01.740' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (33, 2102, N'ef3c1f4e-c815-4172-bc4a-3c1efaf27609', CAST(N'2015-12-11 22:11:35.287' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (34, 2071, N'1fc2dd81-1e3f-44c2-93da-a135b0ac2974', CAST(N'2015-12-11 22:11:49.343' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (35, 2102, N'3ca9a075-a7d1-4343-9b53-f6ec27340932', CAST(N'2015-12-11 22:12:21.933' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (36, 2071, N'cce16f29-fb77-4068-848d-b9bdf0d36a18', CAST(N'2015-12-11 22:12:18.323' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (37, 2100, N'c24b6308-9c24-4ce5-a5f6-c4b1b7765fc5', CAST(N'2015-12-11 22:12:18.353' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (38, 2101, N'afee1d79-8cd8-4306-9903-8d5988b54170', CAST(N'2015-12-11 22:12:18.380' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (39, 2104, N'407afd60-d1fa-4fbd-bc9d-854b326154fa', CAST(N'2015-12-12 00:38:04.290' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (40, 2105, N'34b6bfb5-6501-43a3-af12-3d0f9ca41aca', CAST(N'2015-12-12 00:38:21.773' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (41, 2106, N'08a03125-a7df-400e-9796-1a52352f7e3c', CAST(N'2015-12-12 00:38:33.633' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (42, 2107, N'b9c85686-4d20-4056-a15c-55432dc2994f', CAST(N'2015-12-12 00:39:15.043' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (43, 2109, N'48331f45-adbf-4dad-ab4f-137002ecc992', CAST(N'2015-12-12 00:40:09.303' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (44, 2109, N'f67c913f-f675-47a7-8550-1957bb43d8f6', CAST(N'2015-12-12 00:40:21.390' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (45, 2110, N'd9705207-ab08-4511-8a64-a0b526694495', CAST(N'2015-12-12 00:40:37.807' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (46, 2077, N'd6418566-fbf4-45ac-adac-f9d754dc7cc6', CAST(N'2015-12-13 11:43:24.080' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (47, 2095, N'0e9a109b-ea55-456b-876e-418a7de63c7f', CAST(N'2015-12-13 11:43:24.403' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (48, 2092, N'91ac60a9-fa63-428e-bc8c-a38af3aa906d', CAST(N'2015-12-13 11:43:24.427' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (49, 2072, N'b9e67d79-c826-47d6-a764-6134aa181284', CAST(N'2015-12-13 11:43:24.463' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (50, 2073, N'a9b59603-365a-48a7-b76b-2455ad63ac90', CAST(N'2015-12-13 11:43:24.503' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (51, 2074, N'c8eb4647-7d18-40d3-96eb-4e34b1550ebc', CAST(N'2015-12-13 11:43:24.530' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (52, 2071, N'2aa8276f-bcac-400d-af4c-0455b8e2f8f0', CAST(N'2015-12-13 11:43:24.593' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (53, 2077, N'b0d29b28-7257-4d30-a78b-45af361a873b', CAST(N'2015-12-13 11:43:24.603' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (54, 2095, N'4172b622-33dc-48bf-95da-bc705143f94c', CAST(N'2015-12-13 11:43:24.610' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (55, 2092, N'e30246a6-cc8c-4507-9743-d637dbddfdb1', CAST(N'2015-12-13 11:43:24.610' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (56, 2072, N'3729774b-bce1-4fae-8a54-a0a6fb8611ce', CAST(N'2015-12-13 11:43:24.613' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (57, 2073, N'dddc0736-cf02-40cc-8d7b-73a139e36b4c', CAST(N'2015-12-13 11:43:24.617' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (58, 2074, N'1518e180-fabd-4f95-ab57-75b7854c9d44', CAST(N'2015-12-13 11:43:24.620' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (59, 2113, N'91b49527-ceaf-4492-97a2-38128625befc', CAST(N'2015-12-13 22:30:11.197' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (60, 2116, N'f39661fd-158b-4879-b383-f28e2f245b91', CAST(N'2015-12-14 19:32:21.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[cmsContentVersion] OFF
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2100, N'<Test id="2100" key="03217e73-a724-4087-9e8f-05051599cc03" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2015-12-11T22:10:38" updateDate="2015-12-11T22:12:18" nodeName="rwar" urlName="rwar" path="-1,2100" isDoc="" nodeType="2099" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2098" nodeTypeAlias="Test" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2102, N'<Home id="2102" key="c864c635-8368-4a3f-a10b-faa6a8c6cb9f" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2015-12-11T22:11:35" updateDate="2015-12-11T22:12:21" nodeName="Home" urlName="home" path="-1,2102" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2089" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2104, N'<BasketPage id="2104" key="93760cf1-3c10-443c-81bc-66d5ca0cf932" parentID="2102" level="2" creatorID="0" sortOrder="0" createDate="2015-12-12T00:38:04" updateDate="2015-12-12T00:38:04" nodeName="Basket" urlName="basket" path="-1,2102,2104" isDoc="" nodeType="2075" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2096" nodeTypeAlias="BasketPage" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2105, N'<CheckoutPage id="2105" key="7db74495-324b-43f3-9867-e441507cd604" parentID="2102" level="2" creatorID="0" sortOrder="1" createDate="2015-12-12T00:38:21" updateDate="2015-12-12T00:38:21" nodeName="Checkout" urlName="checkout" path="-1,2102,2105" isDoc="" nodeType="2080" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2091" nodeTypeAlias="CheckoutPage" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2106, N'<DeliveryPage id="2106" key="87353e62-5fe5-4136-a7e0-6e5455066492" parentID="2102" level="2" creatorID="0" sortOrder="2" createDate="2015-12-12T00:38:33" updateDate="2015-12-12T00:38:33" nodeName="Delivery" urlName="delivery" path="-1,2102,2106" isDoc="" nodeType="2094" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2093" nodeTypeAlias="DeliveryPage" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2107, N'<Products id="2107" key="7693ad15-5a6b-4485-ab5b-11d67fc402f2" parentID="2102" level="2" creatorID="0" sortOrder="3" createDate="2015-12-12T00:39:15" updateDate="2015-12-12T00:39:15" nodeName="Products" urlName="products" path="-1,2102,2107" isDoc="" nodeType="2068" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2103" nodeTypeAlias="Products" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2109, N'<Product id="2109" key="4dcef1ed-3c0c-4301-94c9-14154dd627c7" parentID="2107" level="3" creatorID="0" sortOrder="0" createDate="2015-12-12T00:40:09" updateDate="2015-12-12T00:40:21" nodeName="Product1" urlName="product1" path="-1,2102,2107,2109" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2108" nodeTypeAlias="Product"><product><![CDATA[445a79c5-e359-4e39-b2bd-f10ec1e0dc26]]></product><productdescription><![CDATA[Description for product 1]]></productdescription></Product>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2110, N'<Product id="2110" key="69659091-157d-45d6-aaac-a93bd6165405" parentID="2107" level="3" creatorID="0" sortOrder="1" createDate="2015-12-12T00:40:37" updateDate="2015-12-12T00:40:37" nodeName="product2" urlName="product2" path="-1,2102,2107,2110" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2108" nodeTypeAlias="Product"><product><![CDATA[6b0addbd-d511-4e7c-aeec-fc9a4225628e]]></product><productdescription><![CDATA[Description for product2]]></productdescription></Product>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2113, N'<PaymentPage id="2113" key="a85143d8-d0d8-4907-a767-615ed822a3de" parentID="2102" level="2" creatorID="0" sortOrder="4" createDate="2015-12-13T22:30:11" updateDate="2015-12-13T22:30:11" nodeName="Payment" urlName="payment" path="-1,2102,2113" isDoc="" nodeType="2112" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2111" nodeTypeAlias="PaymentPage" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (2116, N'<ReceiptPage id="2116" key="099b0af9-7a25-42e2-b4eb-20bc97fb13e8" parentID="2102" level="2" creatorID="0" sortOrder="5" createDate="2015-12-14T19:32:21" updateDate="2015-12-14T19:32:21" nodeName="Receipt" urlName="receipt" path="-1,2102,2116" isDoc="" nodeType="2115" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2114" nodeTypeAlias="ReceiptPage" />')
SET IDENTITY_INSERT [dbo].[cmsDataType] ON 

INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-28, -97, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-27, -96, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-26, -95, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (1, -49, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (2, -51, N'Umbraco.Integer', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (3, -87, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (4, -88, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (5, -89, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (6, -90, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (7, -92, N'Umbraco.NoEdit', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (8, -36, N'Umbraco.DateTime', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (9, -37, N'Umbraco.ColorPickerAlias', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (10, -38, N'Umbraco.FolderBrowser', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (11, -39, N'Umbraco.DropDownMultiple', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (12, -40, N'Umbraco.RadioButtonList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (13, -41, N'Umbraco.Date', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (14, -42, N'Umbraco.DropDown', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (15, -43, N'Umbraco.CheckBoxList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (16, 1034, N'Umbraco.ContentPickerAlias', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (17, 1035, N'Umbraco.MediaPicker', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (18, 1036, N'Umbraco.MemberPicker', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (21, 1040, N'Umbraco.RelatedLinks', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (22, 1041, N'Umbraco.Tags', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (24, 1043, N'Umbraco.ImageCropper', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (25, 1045, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (26, 1049, N'Merchello.ProductSelector', N'Nvarchar')
SET IDENTITY_INSERT [dbo].[cmsDataType] OFF
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] ON 

INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-4, -97, N'[{"alias":"email","isSystem":1},{"alias":"username","isSystem":1},{"alias":"updateDate","header":"Last edited","isSystem":1}]', 4, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-3, -97, N'asc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-2, -97, N'Name', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-1, -97, N'10', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (3, -87, N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|', 0, N'')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (4, 1041, N'default', 0, N'group')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (5, 1045, N'1', 0, N'multiPicker')
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] OFF
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2071, 0, 0, N'2aa8276f-bcac-400d-af4c-0455b8e2f8f0', N'Home1', NULL, NULL, CAST(N'2015-12-13 11:43:24.593' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2090, 0, 0, N'abf84558-cbd6-44b9-abc5-05b9ae8c0b40', N'Checkout Page', NULL, NULL, CAST(N'2015-12-11 19:13:35.847' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2090, 0, 0, N'd44ede21-bcc0-400c-b32d-0b502c35fdf5', N'Checkout Page', NULL, NULL, CAST(N'2015-12-11 19:13:14.003' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2090, 0, 0, N'e369ecea-25c5-4f02-bbc9-1060834b1303', N'Checkout Page', NULL, NULL, CAST(N'2015-12-11 19:05:14.007' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2109, 0, 0, N'48331f45-adbf-4dad-ab4f-137002ecc992', N'Product1', NULL, NULL, CAST(N'2015-12-12 00:40:09.303' AS DateTime), 2108, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2071, 0, 0, N'87f548e9-834e-4ad2-90a7-18d68385b245', N'Home', NULL, NULL, CAST(N'2015-12-11 22:00:55.907' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2109, 1, 0, N'f67c913f-f675-47a7-8550-1957bb43d8f6', N'Product1', NULL, NULL, CAST(N'2015-12-12 00:40:21.390' AS DateTime), 2108, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2073, 0, 0, N'0e7fb840-e9fe-4467-a0ba-19f84fa89bd1', N'Product Number 1', NULL, NULL, CAST(N'2015-12-07 21:28:00.100' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2106, 1, 0, N'08a03125-a7df-400e-9796-1a52352f7e3c', N'Delivery', NULL, NULL, CAST(N'2015-12-12 00:38:33.633' AS DateTime), 2093, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2073, 0, 0, N'a9b59603-365a-48a7-b76b-2455ad63ac90', N'Product Number 1', NULL, NULL, CAST(N'2015-12-13 11:43:24.503' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2113, 1, 0, N'91b49527-ceaf-4492-97a2-38128625befc', N'Payment', NULL, NULL, CAST(N'2015-12-13 22:30:11.197' AS DateTime), 2111, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2102, 0, 0, N'ef3c1f4e-c815-4172-bc4a-3c1efaf27609', N'Home', NULL, NULL, CAST(N'2015-12-11 22:11:35.287' AS DateTime), 2089, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2105, 1, 0, N'34b6bfb5-6501-43a3-af12-3d0f9ca41aca', N'Checkout', NULL, NULL, CAST(N'2015-12-12 00:38:21.773' AS DateTime), 2091, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2090, 0, 0, N'd4283eb8-7985-49de-8ad2-3ff9d93a3d6e', N'Checkout Page', NULL, NULL, CAST(N'2015-12-11 19:13:35.633' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2095, 0, 0, N'0e9a109b-ea55-456b-876e-418a7de63c7f', N'Delivery Page', NULL, NULL, CAST(N'2015-12-13 11:43:24.403' AS DateTime), 2093, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2077, 0, 0, N'b0d29b28-7257-4d30-a78b-45af361a873b', N'Basket', NULL, NULL, CAST(N'2015-12-13 11:43:24.603' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2100, 0, 0, N'662a43c0-a7e8-4f89-a0eb-4ce4d5ca31b6', N'rwar', NULL, NULL, CAST(N'2015-12-11 22:10:38.860' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2101, 0, 0, N'be6fd03f-a9f2-4d2e-9442-4dd1ddd3d7f5', N'rwar (1)', NULL, NULL, CAST(N'2015-12-11 22:10:53.967' AS DateTime), 2089, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2074, 0, 0, N'c8eb4647-7d18-40d3-96eb-4e34b1550ebc', N'Product number 2', NULL, NULL, CAST(N'2015-12-13 11:43:24.530' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2107, 1, 0, N'b9c85686-4d20-4056-a15c-55432dc2994f', N'Products', NULL, NULL, CAST(N'2015-12-12 00:39:15.043' AS DateTime), 2103, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2072, 0, 0, N'b9e67d79-c826-47d6-a764-6134aa181284', N'Products', NULL, NULL, CAST(N'2015-12-13 11:43:24.463' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2072, 0, 0, N'c408c6d1-e862-44b2-96fc-70dd0eeb9dbc', N'Products', NULL, NULL, CAST(N'2015-12-07 20:55:34.360' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2073, 0, 0, N'dddc0736-cf02-40cc-8d7b-73a139e36b4c', N'Product Number 1', NULL, NULL, CAST(N'2015-12-13 11:43:24.617' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2074, 0, 0, N'1518e180-fabd-4f95-ab57-75b7854c9d44', N'Product number 2', NULL, NULL, CAST(N'2015-12-13 11:43:24.620' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2104, 1, 0, N'407afd60-d1fa-4fbd-bc9d-854b326154fa', N'Basket', NULL, NULL, CAST(N'2015-12-12 00:38:04.290' AS DateTime), 2096, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2101, 0, 0, N'afee1d79-8cd8-4306-9903-8d5988b54170', N'rwar (1)', NULL, NULL, CAST(N'2015-12-11 22:12:18.380' AS DateTime), 2089, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2095, 0, 0, N'ad138188-09bd-4ff9-ab66-92ca07eabeea', N'Delivery Page', NULL, NULL, CAST(N'2015-12-11 19:51:36.650' AS DateTime), 2093, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2074, 0, 0, N'e6fa650e-41fc-40ff-9dee-9472ad7526e8', N'First Product', NULL, NULL, CAST(N'2015-12-07 20:56:37.113' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2095, 0, 0, N'0777bb69-71fa-49fa-af81-954b70cffb66', N'Delivery Page', NULL, NULL, CAST(N'2015-12-11 19:51:46.730' AS DateTime), 2093, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2071, 0, 0, N'00dbbf4d-b597-4221-af6e-9df33aa645ae', N'Home1', NULL, NULL, CAST(N'2015-12-11 22:03:12.077' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2092, 0, 0, N'b7123cea-4f7e-4039-a16d-a081292bd448', N'Checkout Page', NULL, NULL, CAST(N'2015-12-11 19:15:05.640' AS DateTime), 2091, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2072, 0, 0, N'3729774b-bce1-4fae-8a54-a0a6fb8611ce', N'Products', NULL, NULL, CAST(N'2015-12-13 11:43:24.613' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2110, 1, 0, N'd9705207-ab08-4511-8a64-a0b526694495', N'product2', NULL, NULL, CAST(N'2015-12-12 00:40:37.807' AS DateTime), 2108, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2071, 0, 0, N'1fc2dd81-1e3f-44c2-93da-a135b0ac2974', N'Home1', NULL, NULL, CAST(N'2015-12-11 22:11:49.343' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2092, 0, 0, N'91ac60a9-fa63-428e-bc8c-a38af3aa906d', N'Checkout Page', NULL, NULL, CAST(N'2015-12-13 11:43:24.427' AS DateTime), 2091, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2071, 0, 0, N'cce16f29-fb77-4068-848d-b9bdf0d36a18', N'Home1', NULL, NULL, CAST(N'2015-12-11 22:12:18.323' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2095, 0, 0, N'4172b622-33dc-48bf-95da-bc705143f94c', N'Delivery Page', NULL, NULL, CAST(N'2015-12-13 11:43:24.610' AS DateTime), 2093, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2100, 1, 0, N'c24b6308-9c24-4ce5-a5f6-c4b1b7765fc5', N'rwar', NULL, NULL, CAST(N'2015-12-11 22:12:18.353' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2092, 0, 0, N'e30246a6-cc8c-4507-9743-d637dbddfdb1', N'Checkout Page', NULL, NULL, CAST(N'2015-12-13 11:43:24.610' AS DateTime), 2091, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2101, 0, 0, N'013bdce6-a661-45a2-9cdf-ded4fcbecc36', N'rwar (1)', NULL, NULL, CAST(N'2015-12-11 22:11:01.740' AS DateTime), 2089, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2074, 0, 0, N'bdf0373d-9a44-40f0-b041-f20eaa96b20e', N'Product number 2', NULL, NULL, CAST(N'2015-12-07 20:57:56.940' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2116, 1, 0, N'f39661fd-158b-4879-b383-f28e2f245b91', N'Receipt', NULL, NULL, CAST(N'2015-12-14 19:32:21.837' AS DateTime), 2114, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2102, 1, 0, N'3ca9a075-a7d1-4343-9b53-f6ec27340932', N'Home', NULL, NULL, CAST(N'2015-12-11 22:12:21.933' AS DateTime), 2089, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2077, 0, 0, N'9022a154-dfef-40b1-9825-f874f59e1924', N'Basket', NULL, NULL, CAST(N'2015-12-12 00:23:08.583' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2074, 0, 0, N'3577dbb4-43e8-4c40-9bc2-f9d37e2c295f', N'Product number 2', NULL, NULL, CAST(N'2015-12-07 20:56:55.540' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (2077, 0, 0, N'd6418566-fbf4-45ac-adac-f9d754dc7cc6', N'Basket', NULL, NULL, CAST(N'2015-12-13 11:43:24.080' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2067, 2108, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2068, 2103, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2070, 2089, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2075, 2096, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2080, 2091, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2094, 2093, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2112, 2111, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (2115, 2114, 1)
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2071, N'87f548e9-834e-4ad2-90a7-18d68385b245', CAST(N'2015-12-11 22:00:55.913' AS DateTime), N'<Home id="2071" key="26f487c5-eeae-4af2-99a0-79367c3521f3" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2015-12-07T20:55:22" updateDate="2015-12-11T22:00:55" nodeName="Home" urlName="home" path="-1,2071" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2071, N'00dbbf4d-b597-4221-af6e-9df33aa645ae', CAST(N'2015-12-11 22:03:12.097' AS DateTime), N'<Home id="2071" key="26f487c5-eeae-4af2-99a0-79367c3521f3" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2015-12-07T20:55:22" updateDate="2015-12-11T22:03:12" nodeName="Home1" urlName="home1" path="-1,2071" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2071, N'1fc2dd81-1e3f-44c2-93da-a135b0ac2974', CAST(N'2015-12-11 22:11:49.373' AS DateTime), N'<Home id="2071" key="26f487c5-eeae-4af2-99a0-79367c3521f3" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2015-12-07T20:55:22" updateDate="2015-12-11T22:11:49" nodeName="Home1" urlName="home1" path="-1,2071" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2071, N'cce16f29-fb77-4068-848d-b9bdf0d36a18', CAST(N'2015-12-11 22:12:18.350' AS DateTime), N'<Home id="2071" key="26f487c5-eeae-4af2-99a0-79367c3521f3" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2015-12-07T20:55:22" updateDate="2015-12-11T22:12:18" nodeName="Home1" urlName="home1" path="-1,2071" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2072, N'c408c6d1-e862-44b2-96fc-70dd0eeb9dbc', CAST(N'2015-12-07 20:55:34.477' AS DateTime), N'<Products id="2072" key="0b7d9bd0-49fb-425e-84c9-896ee51c0943" parentID="2071" level="2" creatorID="0" sortOrder="0" createDate="2015-12-07T20:55:34" updateDate="2015-12-07T20:55:34" nodeName="Products" urlName="products" path="-1,2071,2072" isDoc="" nodeType="2068" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Products" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2073, N'0e7fb840-e9fe-4467-a0ba-19f84fa89bd1', CAST(N'2015-12-07 21:28:00.127' AS DateTime), N'<Product id="2073" key="cf498bae-3e4b-4df9-9e3d-7c2b59d7d9d5" parentID="2072" level="3" creatorID="0" sortOrder="0" createDate="2015-12-07T20:56:07" updateDate="2015-12-07T21:28:00" nodeName="Product Number 1" urlName="product-number-1" path="-1,2071,2072,2073" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="Product"><product><![CDATA[445a79c5-e359-4e39-b2bd-f10ec1e0dc26]]></product><productdescription><![CDATA[Here is a description of the first product we have.]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2074, N'e6fa650e-41fc-40ff-9dee-9472ad7526e8', CAST(N'2015-12-07 20:56:37.260' AS DateTime), N'<Product id="2074" key="037fff7d-c6d1-47bd-bd12-92e240481af4" parentID="2072" level="3" creatorID="0" sortOrder="1" createDate="2015-12-07T20:56:37" updateDate="2015-12-07T20:56:37" nodeName="First Product" urlName="first-product" path="-1,2071,2072,2074" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="1057" nodeTypeAlias="Product"><product><![CDATA[445a79c5-e359-4e39-b2bd-f10ec1e0dc26]]></product><productdescription><![CDATA[Here is our first product.]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2074, N'bdf0373d-9a44-40f0-b041-f20eaa96b20e', CAST(N'2015-12-07 20:57:57.100' AS DateTime), N'<Product id="2074" key="037fff7d-c6d1-47bd-bd12-92e240481af4" parentID="2072" level="3" creatorID="0" sortOrder="1" createDate="2015-12-07T20:56:37" updateDate="2015-12-07T20:57:56" nodeName="Product number 2" urlName="product-number-2" path="-1,2071,2072,2074" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="1057" nodeTypeAlias="Product"><product><![CDATA[6b0addbd-d511-4e7c-aeec-fc9a4225628e]]></product><productdescription><![CDATA[Secondary product]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2074, N'3577dbb4-43e8-4c40-9bc2-f9d37e2c295f', CAST(N'2015-12-07 20:56:55.707' AS DateTime), N'<Product id="2074" key="037fff7d-c6d1-47bd-bd12-92e240481af4" parentID="2072" level="3" creatorID="0" sortOrder="1" createDate="2015-12-07T20:56:37" updateDate="2015-12-07T20:56:55" nodeName="Product number 2" urlName="product-number-2" path="-1,2071,2072,2074" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="1057" nodeTypeAlias="Product"><product><![CDATA[445a79c5-e359-4e39-b2bd-f10ec1e0dc26]]></product><productdescription><![CDATA[Secondary product]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2077, N'9022a154-dfef-40b1-9825-f874f59e1924', CAST(N'2015-12-12 00:23:08.630' AS DateTime), N'<BasketPage id="2077" key="1a3ba8c8-81da-43e6-804c-c142d2fe2d0c" parentID="2071" level="2" creatorID="0" sortOrder="1" createDate="2015-12-07T21:49:23" updateDate="2015-12-12T00:23:08" nodeName="Basket" urlName="basket" path="-1,2071,2077" isDoc="" nodeType="2075" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="0" nodeTypeAlias="BasketPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2090, N'd44ede21-bcc0-400c-b32d-0b502c35fdf5', CAST(N'2015-12-11 19:13:14.060' AS DateTime), N'<CheckoutPage id="2090" key="8c7a86e0-d2c7-4126-a82a-548f128e6ff8" parentID="2071" level="2" creatorID="0" sortOrder="2" createDate="2015-12-11T19:05:14" updateDate="2015-12-11T19:13:14" nodeName="Checkout Page" urlName="checkout-page" path="-1,2071,2090" isDoc="" nodeType="2080" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2082" nodeTypeAlias="CheckoutPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2090, N'e369ecea-25c5-4f02-bbc9-1060834b1303', CAST(N'2015-12-11 19:05:14.040' AS DateTime), N'<CheckoutPage id="2090" key="8c7a86e0-d2c7-4126-a82a-548f128e6ff8" parentID="2071" level="2" creatorID="0" sortOrder="2" createDate="2015-12-11T19:05:14" updateDate="2015-12-11T19:05:14" nodeName="Checkout Page" urlName="checkout-page" path="-1,2071,2090" isDoc="" nodeType="2080" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2082" nodeTypeAlias="CheckoutPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2092, N'b7123cea-4f7e-4039-a16d-a081292bd448', CAST(N'2015-12-11 19:50:29.917' AS DateTime), N'<CheckoutPage id="2092" key="bb8f3421-f0ec-4895-8e23-c06e3b58302d" parentID="2071" level="2" creatorID="0" sortOrder="2" createDate="2015-12-11T19:15:05" updateDate="2015-12-11T19:15:05" nodeName="Checkout Page" urlName="checkout-page" path="-1,2071,2092" isDoc="" nodeType="2080" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2091" nodeTypeAlias="CheckoutPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2095, N'ad138188-09bd-4ff9-ab66-92ca07eabeea', CAST(N'2015-12-11 19:51:36.677' AS DateTime), N'<Deliverypage id="2095" key="5929bed7-77dc-4d7a-b8eb-9520a0413200" parentID="2071" level="2" creatorID="0" sortOrder="3" createDate="2015-12-11T19:51:36" updateDate="2015-12-11T19:51:36" nodeName="Delivery Page" urlName="delivery-page" path="-1,2071,2095" isDoc="" nodeType="2094" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2093" nodeTypeAlias="Deliverypage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2095, N'0777bb69-71fa-49fa-af81-954b70cffb66', CAST(N'2015-12-11 19:51:46.773' AS DateTime), N'<Deliverypage id="2095" key="5929bed7-77dc-4d7a-b8eb-9520a0413200" parentID="2071" level="2" creatorID="0" sortOrder="3" createDate="2015-12-11T19:51:36" updateDate="2015-12-11T19:51:46" nodeName="Delivery Page" urlName="delivery-page" path="-1,2071,2095" isDoc="" nodeType="2094" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2093" nodeTypeAlias="Deliverypage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2100, N'662a43c0-a7e8-4f89-a0eb-4ce4d5ca31b6', CAST(N'2015-12-11 22:10:38.897' AS DateTime), N'<Test id="2100" key="03217e73-a724-4087-9e8f-05051599cc03" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2015-12-11T22:10:38" updateDate="2015-12-11T22:10:38" nodeName="rwar" urlName="rwar" path="-1,2100" isDoc="" nodeType="2099" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2098" nodeTypeAlias="Test" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2100, N'c24b6308-9c24-4ce5-a5f6-c4b1b7765fc5', CAST(N'2015-12-11 22:12:18.380' AS DateTime), N'<Test id="2100" key="03217e73-a724-4087-9e8f-05051599cc03" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2015-12-11T22:10:38" updateDate="2015-12-11T22:12:18" nodeName="rwar" urlName="rwar" path="-1,2100" isDoc="" nodeType="2099" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2098" nodeTypeAlias="Test" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2101, N'be6fd03f-a9f2-4d2e-9442-4dd1ddd3d7f5', CAST(N'2015-12-11 22:10:53.973' AS DateTime), N'<Home id="2101" key="7a066a82-99a8-4d0b-82ea-dfc50958fa98" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2015-12-11T22:10:53" updateDate="2015-12-11T22:10:53" nodeName="rwar (1)" urlName="rwar-1" path="-1,2101" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2089" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2101, N'afee1d79-8cd8-4306-9903-8d5988b54170', CAST(N'2015-12-11 22:12:18.390' AS DateTime), N'<Home id="2101" key="7a066a82-99a8-4d0b-82ea-dfc50958fa98" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2015-12-11T22:10:53" updateDate="2015-12-11T22:12:18" nodeName="rwar (1)" urlName="rwar-1" path="-1,2101" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2089" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2102, N'ef3c1f4e-c815-4172-bc4a-3c1efaf27609', CAST(N'2015-12-11 22:11:41.423' AS DateTime), N'<Home id="2102" key="c864c635-8368-4a3f-a10b-faa6a8c6cb9f" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2015-12-11T22:11:35" updateDate="2015-12-11T22:11:35" nodeName="Home" urlName="home" path="-1,2102" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2089" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2102, N'3ca9a075-a7d1-4343-9b53-f6ec27340932', CAST(N'2015-12-11 22:12:21.957' AS DateTime), N'<Home id="2102" key="c864c635-8368-4a3f-a10b-faa6a8c6cb9f" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2015-12-11T22:11:35" updateDate="2015-12-11T22:12:21" nodeName="Home" urlName="home" path="-1,2102" isDoc="" nodeType="2070" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2089" nodeTypeAlias="Home" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2104, N'407afd60-d1fa-4fbd-bc9d-854b326154fa', CAST(N'2015-12-12 00:38:04.330' AS DateTime), N'<BasketPage id="2104" key="93760cf1-3c10-443c-81bc-66d5ca0cf932" parentID="2102" level="2" creatorID="0" sortOrder="0" createDate="2015-12-12T00:38:04" updateDate="2015-12-12T00:38:04" nodeName="Basket" urlName="basket" path="-1,2102,2104" isDoc="" nodeType="2075" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2096" nodeTypeAlias="BasketPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2105, N'34b6bfb5-6501-43a3-af12-3d0f9ca41aca', CAST(N'2015-12-12 00:38:21.793' AS DateTime), N'<CheckoutPage id="2105" key="7db74495-324b-43f3-9867-e441507cd604" parentID="2102" level="2" creatorID="0" sortOrder="1" createDate="2015-12-12T00:38:21" updateDate="2015-12-12T00:38:21" nodeName="Checkout" urlName="checkout" path="-1,2102,2105" isDoc="" nodeType="2080" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2091" nodeTypeAlias="CheckoutPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2106, N'08a03125-a7df-400e-9796-1a52352f7e3c', CAST(N'2015-12-12 00:38:33.643' AS DateTime), N'<DeliveryPage id="2106" key="87353e62-5fe5-4136-a7e0-6e5455066492" parentID="2102" level="2" creatorID="0" sortOrder="2" createDate="2015-12-12T00:38:33" updateDate="2015-12-12T00:38:33" nodeName="Delivery" urlName="delivery" path="-1,2102,2106" isDoc="" nodeType="2094" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2093" nodeTypeAlias="DeliveryPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2107, N'b9c85686-4d20-4056-a15c-55432dc2994f', CAST(N'2015-12-12 00:39:15.083' AS DateTime), N'<Products id="2107" key="7693ad15-5a6b-4485-ab5b-11d67fc402f2" parentID="2102" level="2" creatorID="0" sortOrder="3" createDate="2015-12-12T00:39:15" updateDate="2015-12-12T00:39:15" nodeName="Products" urlName="products" path="-1,2102,2107" isDoc="" nodeType="2068" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2103" nodeTypeAlias="Products" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2109, N'48331f45-adbf-4dad-ab4f-137002ecc992', CAST(N'2015-12-12 00:40:09.323' AS DateTime), N'<Product id="2109" key="4dcef1ed-3c0c-4301-94c9-14154dd627c7" parentID="2107" level="3" creatorID="0" sortOrder="0" createDate="2015-12-12T00:40:09" updateDate="2015-12-12T00:40:09" nodeName="Product1" urlName="product1" path="-1,2102,2107,2109" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2108" nodeTypeAlias="Product" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2109, N'f67c913f-f675-47a7-8550-1957bb43d8f6', CAST(N'2015-12-12 00:40:21.413' AS DateTime), N'<Product id="2109" key="4dcef1ed-3c0c-4301-94c9-14154dd627c7" parentID="2107" level="3" creatorID="0" sortOrder="0" createDate="2015-12-12T00:40:09" updateDate="2015-12-12T00:40:21" nodeName="Product1" urlName="product1" path="-1,2102,2107,2109" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2108" nodeTypeAlias="Product"><product><![CDATA[445a79c5-e359-4e39-b2bd-f10ec1e0dc26]]></product><productdescription><![CDATA[Description for product 1]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2110, N'd9705207-ab08-4511-8a64-a0b526694495', CAST(N'2015-12-12 00:40:37.833' AS DateTime), N'<Product id="2110" key="69659091-157d-45d6-aaac-a93bd6165405" parentID="2107" level="3" creatorID="0" sortOrder="1" createDate="2015-12-12T00:40:37" updateDate="2015-12-12T00:40:37" nodeName="product2" urlName="product2" path="-1,2102,2107,2110" isDoc="" nodeType="2067" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2108" nodeTypeAlias="Product"><product><![CDATA[6b0addbd-d511-4e7c-aeec-fc9a4225628e]]></product><productdescription><![CDATA[Description for product2]]></productdescription></Product>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2113, N'91b49527-ceaf-4492-97a2-38128625befc', CAST(N'2015-12-13 22:30:11.263' AS DateTime), N'<PaymentPage id="2113" key="a85143d8-d0d8-4907-a767-615ed822a3de" parentID="2102" level="2" creatorID="0" sortOrder="4" createDate="2015-12-13T22:30:11" updateDate="2015-12-13T22:30:11" nodeName="Payment" urlName="payment" path="-1,2102,2113" isDoc="" nodeType="2112" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2111" nodeTypeAlias="PaymentPage" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (2116, N'f39661fd-158b-4879-b383-f28e2f245b91', CAST(N'2015-12-14 19:32:21.867' AS DateTime), N'<ReceiptPage id="2116" key="099b0af9-7a25-42e2-b4eb-20bc97fb13e8" parentID="2102" level="2" creatorID="0" sortOrder="5" createDate="2015-12-14T19:32:21" updateDate="2015-12-14T19:32:21" nodeName="Receipt" urlName="receipt" path="-1,2102,2116" isDoc="" nodeType="2115" creatorName="Niclas Schumacher" writerName="Niclas Schumacher" writerID="0" template="2114" nodeTypeAlias="ReceiptPage" />')
SET IDENTITY_INSERT [dbo].[cmsPropertyData] ON 

INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (29, 2073, N'0e7fb840-e9fe-4467-a0ba-19f84fa89bd1', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (30, 2073, N'0e7fb840-e9fe-4467-a0ba-19f84fa89bd1', 39, NULL, NULL, N'Here is a description of the first product we have.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (31, 2074, N'e6fa650e-41fc-40ff-9dee-9472ad7526e8', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (32, 2074, N'e6fa650e-41fc-40ff-9dee-9472ad7526e8', 39, NULL, NULL, N'Here is our first product.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (33, 2074, N'3577dbb4-43e8-4c40-9bc2-f9d37e2c295f', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (34, 2074, N'3577dbb4-43e8-4c40-9bc2-f9d37e2c295f', 39, NULL, NULL, N'Secondary product', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (35, 2074, N'bdf0373d-9a44-40f0-b041-f20eaa96b20e', 40, NULL, NULL, N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (36, 2074, N'bdf0373d-9a44-40f0-b041-f20eaa96b20e', 39, NULL, NULL, N'Secondary product', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (37, 2109, N'48331f45-adbf-4dad-ab4f-137002ecc992', 40, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (38, 2109, N'48331f45-adbf-4dad-ab4f-137002ecc992', 39, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (39, 2109, N'f67c913f-f675-47a7-8550-1957bb43d8f6', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (40, 2109, N'f67c913f-f675-47a7-8550-1957bb43d8f6', 39, NULL, NULL, N'Description for product 1', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (41, 2110, N'd9705207-ab08-4511-8a64-a0b526694495', 40, NULL, NULL, N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (42, 2110, N'd9705207-ab08-4511-8a64-a0b526694495', 39, NULL, NULL, N'Description for product2', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (43, 2073, N'a9b59603-365a-48a7-b76b-2455ad63ac90', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (44, 2073, N'a9b59603-365a-48a7-b76b-2455ad63ac90', 39, NULL, NULL, N'Here is a description of the first product we have.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (45, 2074, N'c8eb4647-7d18-40d3-96eb-4e34b1550ebc', 40, NULL, NULL, N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (46, 2074, N'c8eb4647-7d18-40d3-96eb-4e34b1550ebc', 39, NULL, NULL, N'Secondary product', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (47, 2073, N'dddc0736-cf02-40cc-8d7b-73a139e36b4c', 40, NULL, NULL, N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (48, 2073, N'dddc0736-cf02-40cc-8d7b-73a139e36b4c', 39, NULL, NULL, N'Here is a description of the first product we have.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (49, 2074, N'1518e180-fabd-4f95-ab57-75b7854c9d44', 40, NULL, NULL, N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDate], [dataNvarchar], [dataNtext]) VALUES (50, 2074, N'1518e180-fabd-4f95-ab57-75b7854c9d44', 39, NULL, NULL, N'Secondary product', NULL)
SET IDENTITY_INSERT [dbo].[cmsPropertyData] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyType] ON 

INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (6, -90, 1032, 3, N'umbracoFile', N'Upload image', 0, 0, NULL, NULL, N'00000006-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (7, -92, 1032, 3, N'umbracoWidth', N'Width', 0, 0, NULL, NULL, N'00000007-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (8, -92, 1032, 3, N'umbracoHeight', N'Height', 0, 0, NULL, NULL, N'00000008-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (9, -92, 1032, 3, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'00000009-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (10, -92, 1032, 3, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'0000000a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (24, -90, 1033, 4, N'umbracoFile', N'Upload file', 0, 0, NULL, NULL, N'00000018-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (25, -92, 1033, 4, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'00000019-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (26, -92, 1033, 4, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'0000001a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (27, -38, 1031, 5, N'contents', N'Contents:', 0, 0, NULL, NULL, N'0000001b-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (28, -89, 1044, 11, N'umbracoMemberComments', N'Comments', 0, 0, NULL, NULL, N'0000001c-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (29, -92, 1044, 11, N'umbracoMemberFailedPasswordAttempts', N'Failed Password Attempts', 1, 0, NULL, NULL, N'0000001d-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (30, -49, 1044, 11, N'umbracoMemberApproved', N'Is Approved', 2, 0, NULL, NULL, N'0000001e-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (31, -49, 1044, 11, N'umbracoMemberLockedOut', N'Is Locked Out', 3, 0, NULL, NULL, N'0000001f-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (32, -92, 1044, 11, N'umbracoMemberLastLockoutDate', N'Last Lockout Date', 4, 0, NULL, NULL, N'00000020-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (33, -92, 1044, 11, N'umbracoMemberLastLogin', N'Last Login Date', 5, 0, NULL, NULL, N'00000021-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (34, -92, 1044, 11, N'umbracoMemberLastPasswordChangeDate', N'Last Password Change Date', 6, 0, NULL, NULL, N'00000022-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (39, -88, 2067, 14, N'productdescription', N'ProductDescription', 0, 0, N'', N'', N'756a0048-e2bc-4ba7-afbf-dc48f7f7bf15')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (40, 1049, 2067, 14, N'product', N'Product', 1, 1, N'', N'', N'2e98ee2e-32c4-4d00-a75a-1f59eb420240')
SET IDENTITY_INSERT [dbo].[cmsPropertyType] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] ON 

INSERT [dbo].[cmsPropertyTypeGroup] ([id], [parentGroupId], [contenttypeNodeId], [text], [sortorder]) VALUES (3, NULL, 1032, N'Image', 1)
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [parentGroupId], [contenttypeNodeId], [text], [sortorder]) VALUES (4, NULL, 1033, N'File', 1)
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [parentGroupId], [contenttypeNodeId], [text], [sortorder]) VALUES (5, NULL, 1031, N'Contents', 1)
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [parentGroupId], [contenttypeNodeId], [text], [sortorder]) VALUES (11, NULL, 1044, N'Membership', 1)
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [parentGroupId], [contenttypeNodeId], [text], [sortorder]) VALUES (14, NULL, 2067, N'Merchandise Properties', 0)
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] OFF
SET IDENTITY_INSERT [dbo].[cmsTaskType] ON 

INSERT [dbo].[cmsTaskType] ([id], [alias]) VALUES (1, N'toTranslate')
SET IDENTITY_INSERT [dbo].[cmsTaskType] OFF
SET IDENTITY_INSERT [dbo].[cmsTemplate] ON 

INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (4, 1053, N'Layout', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@using Umbraco.Core
@using Merchello.Web
@{
  Layout = null;
}
layoutpage')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1015, 2089, N'Home', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1016, 2091, N'CheckoutPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1017, 2093, N'DeliveryPage', N'@using Laceshop.Controllers.Checkout
@model Laceshop.Models.Checkout.DeliveryPageViewModel
@{
    Layout = "Shared/_Layout.cshtml";
}

@Html.Action("Breadcrumb", "Navigation")
<hr />
<h1>@Model.MainHeading</h1>
@using (Html.BeginUmbracoForm<DeliveryPageController>
    ("SelectDeliveryOption", FormMethod.Post))
    {
    @Html.AntiForgeryToken()
    @Html.ValidationSummary()

    <div>
        @Html.LabelFor(m => m.SelectedDeliveryOption)
        @Html.DropDownListFor(m => m.SelectedDeliveryOption, Model.DeliveryOptions, "Please select...")
        @Html.ValidationMessageFor(m => m.SelectedDeliveryOption)
    </div>
    <input type="submit" value="Submit" />
    }

    @Html.Partial("Partials/_Basket")
')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1018, 2096, N'BasketPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1021, 2103, N'Products', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1022, 2108, N'Product', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1023, 2111, N'PaymentPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1024, 2114, N'ReceiptPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}')
SET IDENTITY_INSERT [dbo].[cmsTemplate] OFF
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'0432144a-b4f3-4231-b888-0daf05955066', CAST(N'2015-12-08 17:21:16.547' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:21:16.547' AS DateTime), CAST(N'2015-12-08 17:21:16.547' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'6e487946-b9e7-4dd9-a2fd-0de8b07f8c36', CAST(N'2015-12-13 00:39:54.140' AS DateTime), N'<extendedData><merchBillingAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchBillingAddress></extendedData>', CAST(N'2015-12-13 00:39:54.140' AS DateTime), CAST(N'2015-12-12 10:55:16.863' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'b6dedc1e-f11f-4f05-a79a-115b8de41bbd', CAST(N'2015-12-12 00:58:41.910' AS DateTime), N'<extendedData><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress></extendedData>', CAST(N'2015-12-12 00:58:41.910' AS DateTime), CAST(N'2015-12-11 19:06:44.910' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'5f6f2cbe-6990-4c36-a83e-11678209e30e', CAST(N'2015-12-08 17:12:53.300' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:12:53.300' AS DateTime), CAST(N'2015-12-08 17:12:53.300' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'2e57021d-4937-4484-9fe1-13f4685ee141', CAST(N'2015-12-11 18:59:43.940' AS DateTime), N'<extendedData />', CAST(N'2015-12-11 18:59:43.940' AS DateTime), CAST(N'2015-12-11 18:59:43.940' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'75475f42-b152-4a26-940f-1c93959c227f', CAST(N'2015-12-08 17:28:12.123' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:28:12.123' AS DateTime), CAST(N'2015-12-08 17:28:12.123' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'810aa5a4-96c0-417d-b979-1ca8023f1294', CAST(N'2015-12-13 13:12:45.050' AS DateTime), N'<extendedData><merchBillingAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;asd&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email&gt;ns@impact.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;aarhus&lt;/Locality&gt;&lt;Name&gt;niclas&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;1234&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region&gt;denmark&lt;/Region&gt;&lt;/Address&gt;</merchBillingAddress></extendedData>', CAST(N'2015-12-13 13:12:45.050' AS DateTime), CAST(N'2015-12-13 13:11:49.217' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'60a78f22-97ce-478b-837a-2d22bd477543', CAST(N'2015-12-08 21:36:45.197' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 21:36:45.197' AS DateTime), CAST(N'2015-12-08 21:31:34.883' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'd00beda6-160a-4bce-9273-3226b8b7b47b', CAST(N'2015-12-08 17:27:52.917' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:27:52.917' AS DateTime), CAST(N'2015-12-08 17:27:52.917' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'2f49a5af-0105-4c83-af79-355ba9652544', CAST(N'2015-12-11 17:36:39.763' AS DateTime), N'<extendedData />', CAST(N'2015-12-11 17:36:39.763' AS DateTime), CAST(N'2015-12-11 17:36:39.763' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'8c30934f-7fd6-463b-920b-360189a26bf9', CAST(N'2015-12-08 17:18:39.223' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:18:39.223' AS DateTime), CAST(N'2015-12-08 17:18:39.223' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'c5d75683-6102-49ad-8f56-4d2a5e9cdf4c', CAST(N'2015-12-13 23:08:07.800' AS DateTime), N'<extendedData><merchBillingAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchBillingAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchPaymentMethod>8a387fe0-9b9a-4f23-a1d6-f2cc39b88424</merchPaymentMethod></extendedData>', CAST(N'2015-12-13 23:08:07.800' AS DateTime), CAST(N'2015-12-13 13:32:23.653' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'486dbe0f-70b3-4daa-ad3d-4d84c379fa64', CAST(N'2015-12-08 20:32:08.893' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 20:32:08.893' AS DateTime), CAST(N'2015-12-08 17:29:21.297' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'57931f88-c921-429e-b473-5f9b08a7ab4c', CAST(N'2015-12-13 11:48:05.833' AS DateTime), N'<extendedData><merchBillingAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchBillingAddress></extendedData>', CAST(N'2015-12-13 11:48:05.833' AS DateTime), CAST(N'2015-12-13 11:34:53.093' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'b148bfa2-a8b7-4885-aaf1-622a123e9f77', CAST(N'2015-12-08 17:14:39.210' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:14:39.210' AS DateTime), CAST(N'2015-12-08 17:14:39.210' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'81d0794b-f97b-4f40-8436-64ab95089749', CAST(N'2015-12-11 18:46:45.947' AS DateTime), N'<extendedData />', CAST(N'2015-12-11 18:46:45.947' AS DateTime), CAST(N'2015-12-11 18:46:45.947' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'40a6170b-d3da-497d-baa9-7fd97c03c2a6', CAST(N'2015-12-08 17:14:39.220' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:14:39.220' AS DateTime), CAST(N'2015-12-08 17:14:39.220' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'5c55ce2c-c64e-4eaf-9272-8e2b45519619', CAST(N'2015-12-08 17:22:00.610' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:22:00.610' AS DateTime), CAST(N'2015-12-08 17:22:00.610' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'cbb6ce85-9fa6-4821-a9d5-92b5266eacf2', CAST(N'2015-12-13 01:49:33.540' AS DateTime), N'<extendedData />', CAST(N'2015-12-13 01:49:33.540' AS DateTime), CAST(N'2015-12-13 01:49:24.863' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'0a219d71-25de-4e84-9cc3-9387928fedee', CAST(N'2015-12-08 17:18:30.000' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:18:30.000' AS DateTime), CAST(N'2015-12-08 17:18:30.000' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'fe5911e5-957f-440c-9a77-9981b2178866', CAST(N'2015-12-14 23:04:46.017' AS DateTime), N'<extendedData><merchBillingAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchBillingAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone&gt;60394919&lt;/Phone&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchPaymentMethod>8a387fe0-9b9a-4f23-a1d6-f2cc39b88424</merchPaymentMethod></extendedData>', CAST(N'2015-12-14 23:04:46.017' AS DateTime), CAST(N'2015-12-14 17:14:53.497' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'3ef561b0-acaf-4e5e-b69a-a854bec4d6f6', CAST(N'2015-12-08 17:13:01.177' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:13:01.177' AS DateTime), CAST(N'2015-12-08 17:13:01.177' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'cb5bd5a3-fa79-43ac-b4d5-abdaf13f0382', CAST(N'2015-12-08 17:29:05.100' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:29:05.100' AS DateTime), CAST(N'2015-12-08 17:29:05.100' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'ef53884d-1eeb-4ab0-be8c-afd00743e360', CAST(N'2015-12-08 17:18:53.743' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:18:53.743' AS DateTime), CAST(N'2015-12-08 17:18:53.743' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'fcc54412-7c2b-4aa1-8be0-d2a7bcfa9b79', CAST(N'2015-12-08 17:13:26.033' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:13:26.033' AS DateTime), CAST(N'2015-12-08 17:13:26.033' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'590d9d2d-c114-411f-a8e5-db7ade13cc07', CAST(N'2015-12-08 17:29:01.450' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:29:01.450' AS DateTime), CAST(N'2015-12-08 17:29:01.450' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'c0301535-0726-4407-a56b-dbbe3aa6bbe8', CAST(N'2015-12-08 17:17:56.750' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:17:56.750' AS DateTime), CAST(N'2015-12-08 17:17:56.750' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'18cefd41-08ee-440f-b979-dcf5891f99ec', CAST(N'2015-12-08 17:12:31.873' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:12:31.873' AS DateTime), CAST(N'2015-12-08 17:12:31.873' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'05b934ba-f1b9-49ee-a63e-e619fa335c6b', CAST(N'2015-12-08 17:17:34.067' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:17:34.067' AS DateTime), CAST(N'2015-12-08 17:17:34.067' AS DateTime))
INSERT [dbo].[merchAnonymousCustomer] ([pk], [lastActivityDate], [extendedData], [updateDate], [createDate]) VALUES (N'fc2bb781-7d76-4e09-8aa4-f637710683ba', CAST(N'2015-12-08 17:12:42.237' AS DateTime), N'<extendedData />', CAST(N'2015-12-08 17:12:42.237' AS DateTime), CAST(N'2015-12-08 17:12:42.237' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'51bef432-9f9f-4da7-9676-1a1dfa683748', N'57165b01-542b-4a39-9806-5e2a9da353a6', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'Cash payment', CAST(300.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 23:03:13.293' AS DateTime), CAST(N'2015-12-14 23:03:13.293' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'2a4ac2a2-68db-4cf3-8efb-3ddeb7aab36b', N'577a0285-ed28-4e52-8e7a-cfcddf155d0a', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'Cash payment', CAST(100.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 19:33:25.413' AS DateTime), CAST(N'2015-12-14 19:33:25.413' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'95a3afff-0443-497a-b239-454986d1c599', N'57165b01-542b-4a39-9806-5e2a9da353a6', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'To show promise of a Cash payment', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 22:58:55.353' AS DateTime), CAST(N'2015-12-14 22:58:55.353' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'5044a10a-0733-479f-ac95-4a2b64e64cdc', N'577a0285-ed28-4e52-8e7a-cfcddf155d0a', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'To show promise of a Cash payment', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 19:30:49.397' AS DateTime), CAST(N'2015-12-14 19:30:49.397' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'1a181d83-8969-42c1-b41a-7e145885d00e', N'1f200041-8098-4f76-a30c-e038ac33f6b2', N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'To show promise of a Cash payment', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 22:43:48.340' AS DateTime), CAST(N'2015-12-14 22:43:48.340' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'19e221fd-5943-4816-a8e9-9426debbae9b', N'72f298fa-56fd-406e-b406-80b7503727ad', N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'To show promise of a Cash payment', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 22:51:41.197' AS DateTime), CAST(N'2015-12-14 22:51:41.197' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'4a1ca0dd-1cc3-4d84-baba-f223b49d9325', N'6f496087-d8a7-48f0-8224-85fe08c5574a', N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', N'f59c7da6-8252-4891-a5a2-7f6c38766649', N'To show promise of a Cash payment - **Void**', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 23:02:39.130' AS DateTime), CAST(N'2015-12-14 19:33:01.117' AS DateTime))
INSERT [dbo].[merchAppliedPayment] ([pk], [paymentKey], [invoiceKey], [appliedPaymentTfKey], [description], [amount], [exported], [updateDate], [createDate]) VALUES (N'33c6d447-d3ed-4412-8066-f810338a0349', N'c6cc6cf3-460c-4c3b-a0d1-b1073deb88e4', N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'To show promise of a Card payment', CAST(0.000000 AS Decimal(38, 6)), 0, CAST(N'2015-12-14 22:58:12.653' AS DateTime), CAST(N'2015-12-14 22:58:12.653' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'a65280d3-c0a4-4245-a735-014869f8d8ef', N'6f496087-d8a7-48f0-8224-85fe08c5574a', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentVoided"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 23:02:39.197' AS DateTime), CAST(N'2015-12-14 23:02:39.197' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'baa7c757-bc8b-4a51-985f-1b4d6e891496', N'577a0285-ed28-4e52-8e7a-cfcddf155d0a', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentCaptured","invoiceTotal":100.0,"currencyCode":""}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:33:25.550' AS DateTime), CAST(N'2015-12-14 19:33:25.550' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'5382cede-5613-4f57-bc09-1e0b39b7129c', N'57165b01-542b-4a39-9806-5e2a9da353a6', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":300.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:58:55.460' AS DateTime), CAST(N'2015-12-14 22:58:55.460' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'2f2886a0-af0f-48a5-aa58-202b4c5c7afd', N'bd966aa4-de80-407e-b204-da3e12639c69', N'5f26df00-bd45-4e83-8095-d17ad8d7d3ce', N'{"area":"merchelloAuditLogs","key":"shipmentStatusChanged","shipmentStatus":"Shipped"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:42:03.790' AS DateTime), CAST(N'2015-12-14 19:42:03.790' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'28052c00-4f0b-4fb7-bcf2-25248beda214', N'c6cc6cf3-460c-4c3b-a0d1-b1073deb88e4', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":100.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:58:12.663' AS DateTime), CAST(N'2015-12-14 22:58:12.663' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'ea52fc83-877f-4f47-ab56-3fb485529bb8', N'6f496087-d8a7-48f0-8224-85fe08c5574a', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":100.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:33:01.143' AS DateTime), CAST(N'2015-12-14 19:33:01.143' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'b6d9086b-4612-4774-8e2b-43fa63c970f4', N'577a0285-ed28-4e52-8e7a-cfcddf155d0a', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":100.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:30:49.450' AS DateTime), CAST(N'2015-12-14 19:30:49.450' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'0067337c-f6bf-4a61-88b3-645de2451f58', N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"3"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:33:01.137' AS DateTime), CAST(N'2015-12-14 19:33:01.137' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'4d046107-3516-4445-b75e-65e92469e692', N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"5"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:51:41.250' AS DateTime), CAST(N'2015-12-14 22:51:41.250' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'cb057712-de2c-4dc8-89fd-6a84d311b03f', N'1f200041-8098-4f76-a30c-e038ac33f6b2', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":100.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:43:48.420' AS DateTime), CAST(N'2015-12-14 22:43:48.420' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'8214d21f-c6bf-43f1-a071-8e95915d6887', N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"6"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:58:12.660' AS DateTime), CAST(N'2015-12-14 22:58:12.660' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'0a540d3d-3dbf-4cd4-bede-905958dcd319', N'bd966aa4-de80-407e-b204-da3e12639c69', N'5f26df00-bd45-4e83-8095-d17ad8d7d3ce', N'{"area":"merchelloAuditLogs","key":"shipmentStatusChanged","shipmentStatus":"Delivered"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:42:20.693' AS DateTime), CAST(N'2015-12-14 19:42:20.693' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'1acd927c-f045-4ef7-b894-96db4575b21b', N'6f496087-d8a7-48f0-8224-85fe08c5574a', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentVoided"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 23:02:39.140' AS DateTime), CAST(N'2015-12-14 23:02:39.140' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'01170973-fbfb-476f-8e97-9ac544d4923d', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"7"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:58:55.443' AS DateTime), CAST(N'2015-12-14 22:58:55.443' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'befffb7c-ce44-432a-8771-a6b8aeee92b1', N'72f298fa-56fd-406e-b406-80b7503727ad', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentAuthorize","invoiceTotal":220.00,"currencyCode":"DKK"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:51:41.270' AS DateTime), CAST(N'2015-12-14 22:51:41.270' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'65f90b50-9e61-4ef6-8844-aed89d707152', N'57165b01-542b-4a39-9806-5e2a9da353a6', N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'{"area":"merchelloAuditLogs","key":"paymentCaptured","invoiceTotal":300.0,"currencyCode":""}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 23:03:13.407' AS DateTime), CAST(N'2015-12-14 23:03:13.407' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'30e70579-17ae-4a89-a371-c8ec472e544b', N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"4"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:43:48.393' AS DateTime), CAST(N'2015-12-14 22:43:48.393' AS DateTime))
INSERT [dbo].[merchAuditLog] ([pk], [entityKey], [entityTfKey], [message], [verbosity], [extendedData], [isError], [updateDate], [createDate]) VALUES (N'0500f384-e412-40e8-9737-f56e22f0ae40', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'454539b9-d753-4c16-8ed5-5eb659e56665', N'{"area":"merchelloAuditLogs","key":"invoiceCreated","invoiceNumber":"2"}', 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:30:49.443' AS DateTime), CAST(N'2015-12-14 19:30:49.443' AS DateTime))
INSERT [dbo].[merchCatalogInventory] ([catalogKey], [productVariantKey], [count], [lowCount], [location], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'45feb315-d8d7-4b69-bf5c-10599ada21ff', 20, 2, N'', CAST(N'2015-12-13 19:52:04.463' AS DateTime), CAST(N'2015-12-05 00:43:02.443' AS DateTime))
INSERT [dbo].[merchCatalogInventory] ([catalogKey], [productVariantKey], [count], [lowCount], [location], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'975a3dee-a6cd-4952-810d-1504a95a30f3', 0, 0, NULL, CAST(N'2015-12-13 19:52:04.537' AS DateTime), CAST(N'2015-12-08 20:59:08.287' AS DateTime))
INSERT [dbo].[merchCatalogInventory] ([catalogKey], [productVariantKey], [count], [lowCount], [location], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'8a92a440-4dac-4d8e-b915-4634f8e559f2', 14, 2, N'Home', CAST(N'2015-12-14 23:03:38.803' AS DateTime), CAST(N'2015-12-07 20:57:49.560' AS DateTime))
INSERT [dbo].[merchCatalogInventory] ([catalogKey], [productVariantKey], [count], [lowCount], [location], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed', 18, 0, NULL, CAST(N'2015-12-14 23:03:38.790' AS DateTime), CAST(N'2015-12-08 20:59:08.217' AS DateTime))
INSERT [dbo].[merchCatalogInventory] ([catalogKey], [productVariantKey], [count], [lowCount], [location], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'873edc9e-331b-43dc-83f8-97749fbcfa99', 0, 0, NULL, CAST(N'2015-12-14 23:09:00.853' AS DateTime), CAST(N'2015-12-08 20:59:08.250' AS DateTime))
INSERT [dbo].[merchDetachedContentType] ([pk], [entityTfKey], [name], [description], [contentTypeKey], [updateDate], [createDate]) VALUES (N'c8d21daa-6f5f-46e6-841d-f32b6a7a58e1', N'9f923716-a022-4089-a110-1e9b4e1f2ad1', N'Shoelace', N'This is a shoelace', N'5e5ef354-78db-4feb-a2f2-1be792472514', CAST(N'2015-12-05 00:42:25.460' AS DateTime), CAST(N'2015-12-05 00:42:25.460' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'4efae0bb-d7bd-41e9-81fc-09d70930438c', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Partially Paid Invoice Collection', 0, N'82015b97-11e8-4e57-8258-a59e1d378e04', CAST(N'2015-12-05 00:13:45.430' AS DateTime), CAST(N'2015-12-05 00:13:45.430' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'6aa9fa8d-0f48-49e0-8a1a-7b4ed8cca881', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Invoices with unfulfilled orders collection', 0, N'5fd6e5eb-0b7c-41a4-b863-7aec31be84c0', CAST(N'2015-12-05 00:13:45.427' AS DateTime), CAST(N'2015-12-05 00:13:45.427' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'4f95ab37-aa7b-481f-ba24-ae3949092e4e', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Invoices with fulfilled orders collection', 0, N'68b57648-7550-4702-8223-c5574b7c0604', CAST(N'2015-12-05 00:13:45.420' AS DateTime), CAST(N'2015-12-05 00:13:45.420' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'19672054-bc54-404b-8581-c5db359363f3', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Paid Invoice Collection', 0, N'072e0671-31be-41e4-8cf9-4aeec6cc5bc6', CAST(N'2015-12-05 00:13:45.427' AS DateTime), CAST(N'2015-12-05 00:13:45.427' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'a675b704-8d79-4bb3-a545-dbf9a76ade93', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Unpaid Invoice Collection', 0, N'a8120a01-e9bf-4204-addd-d9553f6f24fe', CAST(N'2015-12-05 00:13:45.430' AS DateTime), CAST(N'2015-12-05 00:13:45.430' AS DateTime))
INSERT [dbo].[merchEntityCollection] ([pk], [parentKey], [entityTfKey], [name], [sortOrder], [providerKey], [updateDate], [createDate]) VALUES (N'39798266-ba3b-4e4f-8a52-fac3c42ef5f5', NULL, N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Invoices with open orders collection', 0, N'a9a288f3-da98-4712-9e90-f9f909f2c26a', CAST(N'2015-12-05 00:13:45.423' AS DateTime), CAST(N'2015-12-05 00:13:45.423' AS DateTime))
INSERT [dbo].[merchGatewayProviderSettings] ([pk], [providerTfKey], [name], [description], [extendedData], [encryptExtendedData], [updateDate], [createDate]) VALUES (N'aec7a923-9f64-41d0-b17b-0ef64725f576', N'646d3ea7-3b31-45c1-9488-7c0449a564a6', N'Fixed Rate Shipping Provider', NULL, N'<extendedData />', 0, CAST(N'2015-12-05 00:12:26.070' AS DateTime), CAST(N'2015-12-05 00:12:26.070' AS DateTime))
INSERT [dbo].[merchGatewayProviderSettings] ([pk], [providerTfKey], [name], [description], [extendedData], [encryptExtendedData], [updateDate], [createDate]) VALUES (N'b2612c3d-8bf0-411c-8c56-32e7495ae79c', N'a0b4f835-d92e-4d17-8181-6c342c41606e', N'Cash Payment Provider', NULL, N'<extendedData />', 0, CAST(N'2015-12-05 00:12:26.077' AS DateTime), CAST(N'2015-12-05 00:12:26.077' AS DateTime))
INSERT [dbo].[merchGatewayProviderSettings] ([pk], [providerTfKey], [name], [description], [extendedData], [encryptExtendedData], [updateDate], [createDate]) VALUES (N'a4ad4331-c278-4231-8607-925e0839a6cd', N'360b47f9-a4fb-4b96-81b4-a4a497d2b44a', N'Fixed Rate Tax Provider', NULL, N'<extendedData />', 0, CAST(N'2015-12-05 00:12:26.077' AS DateTime), CAST(N'2015-12-05 00:12:26.077' AS DateTime))
INSERT [dbo].[merchGatewayProviderSettings] ([pk], [providerTfKey], [name], [description], [extendedData], [encryptExtendedData], [updateDate], [createDate]) VALUES (N'5f2e88d1-6d07-4809-b9ab-d4d6036473e9', N'c5f53682-4c49-4538-87b3-035d30ee3347', N'SMTP Notification Provider', N'SMTP Notification Provider', N'<extendedData><merchSmtpProviderSettings>{"Host":"127.0.0.1","UserName":null,"Password":null,"EnableSsl":false,"Port":25,"HasCredentials":false,"Credentials":null}</merchSmtpProviderSettings></extendedData>', 0, CAST(N'2015-12-13 22:17:37.990' AS DateTime), CAST(N'2015-12-13 22:17:37.990' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', NULL, NULL, 5, NULL, CAST(N'2015-12-14 22:51:40.863' AS DateTime), N'17ada9ac-c893-4c26-aa26-234eceb2fa75', N'990d8a29-4892-4dcd-8e2b-844736d46181', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(220.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 22:51:40.913' AS DateTime), CAST(N'2015-12-14 22:51:40.913' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', NULL, NULL, 6, NULL, CAST(N'2015-12-14 22:58:12.540' AS DateTime), N'17ada9ac-c893-4c26-aa26-234eceb2fa75', N'59f6c5cc-a1a3-46e2-b9fc-9e6585c2607a', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(100.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 22:58:12.553' AS DateTime), CAST(N'2015-12-14 22:58:12.553' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', NULL, NULL, 4, NULL, CAST(N'2015-12-14 22:43:48.163' AS DateTime), N'17ada9ac-c893-4c26-aa26-234eceb2fa75', N'8088920a-ad27-44e1-b793-b471c6e40fce', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(100.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 22:43:48.220' AS DateTime), CAST(N'2015-12-14 22:43:48.220' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', NULL, NULL, 3, NULL, CAST(N'2015-12-14 19:33:01.050' AS DateTime), N'17ada9ac-c893-4c26-aa26-234eceb2fa75', N'64d3570d-93b5-4ddc-b181-6226bfde8d15', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(100.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 23:02:39.163' AS DateTime), CAST(N'2015-12-14 19:33:01.067' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', NULL, NULL, 2, NULL, CAST(N'2015-12-14 19:30:49.210' AS DateTime), N'1f872a1a-f0dd-4c3e-80ab-99799a28606e', N'aac450ce-a9e0-490b-9cda-736efdb821ad', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(100.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 19:42:15.170' AS DateTime), CAST(N'2015-12-14 19:30:49.263' AS DateTime))
INSERT [dbo].[merchInvoice] ([pk], [customerKey], [invoiceNumberPrefix], [invoiceNumber], [poNumber], [invoiceDate], [invoiceStatusKey], [versionKey], [billToName], [billToAddress1], [billToAddress2], [billToLocality], [billToRegion], [billToPostalCode], [billToCountryCode], [billToEmail], [billToPhone], [billToCompany], [exported], [archived], [total], [updateDate], [createDate]) VALUES (N'eb39fee8-952f-465b-8e97-da4dbac221cd', NULL, NULL, 7, NULL, CAST(N'2015-12-14 22:58:55.250' AS DateTime), N'1f872a1a-f0dd-4c3e-80ab-99799a28606e', N'd988b09c-2a95-4bb4-ba38-182ab0ca7636', N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', N'niclas@schu.dk', N'60394919', NULL, 0, 0, CAST(300.000000 AS Decimal(38, 6)), CAST(N'2015-12-14 23:03:13.367' AS DateTime), CAST(N'2015-12-14 22:58:55.287' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchInvoiceIndex] ON 

INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (1, N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', CAST(N'2015-12-14 19:30:49.263' AS DateTime), CAST(N'2015-12-14 19:30:49.263' AS DateTime))
INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (2, N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', CAST(N'2015-12-14 19:33:01.067' AS DateTime), CAST(N'2015-12-14 19:33:01.067' AS DateTime))
INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (3, N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', CAST(N'2015-12-14 22:43:48.220' AS DateTime), CAST(N'2015-12-14 22:43:48.220' AS DateTime))
INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (4, N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', CAST(N'2015-12-14 22:51:40.913' AS DateTime), CAST(N'2015-12-14 22:51:40.913' AS DateTime))
INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (5, N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', CAST(N'2015-12-14 22:58:12.553' AS DateTime), CAST(N'2015-12-14 22:58:12.553' AS DateTime))
INSERT [dbo].[merchInvoiceIndex] ([id], [invoiceKey], [updateDate], [createDate]) VALUES (6, N'eb39fee8-952f-465b-8e97-da4dbac221cd', CAST(N'2015-12-14 22:58:55.287' AS DateTime), CAST(N'2015-12-14 22:58:55.287' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchInvoiceIndex] OFF
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'5fcef6b0-bb27-4dbb-b2a8-048a015d4373', N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>2.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>2.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><umbracoContentId>2110</umbracoContentId><merchVersionKey>0b74b8bf-7af9-4971-86d9-690a188091d2</merchVersionKey><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>50.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>2.000000</merchWidth></extendedData>', CAST(N'2015-12-14 22:51:40.933' AS DateTime), CAST(N'2015-12-14 22:51:40.933' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'2ba9f710-d2fa-4950-8a4d-073ccb34d415', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 19:42:15.177' AS DateTime), CAST(N'2015-12-14 19:30:49.290' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'e4f8cdfc-50b0-4203-a91e-0c249ef057e5', N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 23:02:39.180' AS DateTime), CAST(N'2015-12-14 19:33:01.083' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'deda5a3c-207a-4f21-84a6-2a1c5a2f61e5', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 23:03:13.393' AS DateTime), CAST(N'2015-12-14 22:58:55.303' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'00285f78-59dd-42b4-a089-3839bd638e73', N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>ada55e50-30bb-4c54-a885-a4988ac84f73</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 22:58:12.560' AS DateTime), CAST(N'2015-12-14 22:58:12.560' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'7389a6c6-2420-4973-a75c-4e31ad9d2437', N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 22:43:48.247' AS DateTime), CAST(N'2015-12-14 22:43:48.247' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'c74bda3e-b0c9-4347-9091-5383b2a26236', N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace', 1, CAST(80.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><umbracoContentId>2109</umbracoContentId><merchVersionKey>9526f241-aa66-4d26-bc63-846344f59160</merchVersionKey><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 23:02:39.183' AS DateTime), CAST(N'2015-12-14 19:33:01.080' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'06ab388c-7c94-438b-8b39-553271279375', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>9526f241-aa66-4d26-bc63-846344f59160</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 19:42:15.177' AS DateTime), CAST(N'2015-12-14 19:30:49.287' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'9f6d474d-3375-4286-b078-57262272b767', N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace', 1, CAST(80.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><umbracoContentId>2109</umbracoContentId><merchVersionKey>ada55e50-30bb-4c54-a885-a4988ac84f73</merchVersionKey><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 22:43:48.247' AS DateTime), CAST(N'2015-12-14 22:43:48.247' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'310f71b7-bb95-4da4-b280-57c877e2a6ca', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>2.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>2.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><merchVersionKey>0b74b8bf-7af9-4971-86d9-690a188091d2</merchVersionKey><umbracoContentId>2110</umbracoContentId><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>50.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>2.000000</merchWidth></extendedData>', CAST(N'2015-12-14 23:03:13.383' AS DateTime), CAST(N'2015-12-14 22:58:55.297' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'd0ac06e6-ea0c-4611-a063-5e98edd8cd3a', N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 22:58:12.563' AS DateTime), CAST(N'2015-12-14 22:58:12.563' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'036e4a63-8ddc-43d9-aeb7-8f1b8bb89d8e', N'52e8ff08-a1ce-4acf-b2e1-502d659f5f28', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;1233-Blue&lt;/merchSku&gt;&lt;merchName&gt;First shoelace&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;80.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.000000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;manu&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcode&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;True&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;80.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed&lt;/merchProductVariantKey&gt;&lt;umbracoContentId&gt;2109&lt;/umbracoContentId&gt;&lt;merchVersionKey&gt;ada55e50-30bb-4c54-a885-a4988ac84f73&lt;/merchVersionKey&gt;&lt;merchProductKey&gt;445a79c5-e359-4e39-b2bd-f10ec1e0dc26&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;25.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;100.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;0&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;ManuNumber&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 22:43:48.243' AS DateTime), CAST(N'2015-12-14 22:43:48.243' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'46ba92f6-2c59-4163-bd24-a06d794e6543', N'c9f60659-8340-45f1-ba9e-37c8f5a71d2d', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;1233-Blue&lt;/merchSku&gt;&lt;merchName&gt;First shoelace - Blue&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;80.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.000000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;manu&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcode&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;True&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;80.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed&lt;/merchProductVariantKey&gt;&lt;merchVersionKey&gt;ada55e50-30bb-4c54-a885-a4988ac84f73&lt;/merchVersionKey&gt;&lt;umbracoContentId&gt;2109&lt;/umbracoContentId&gt;&lt;merchProductKey&gt;445a79c5-e359-4e39-b2bd-f10ec1e0dc26&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;25.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;100.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;0&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;ManuNumber&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 22:58:12.560' AS DateTime), CAST(N'2015-12-14 22:58:12.560' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'ed1eee0b-50f3-4189-9d07-a4853dedd944', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;1233-Blue&lt;/merchSku&gt;&lt;merchName&gt;First shoelace - Blue&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;80.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.000000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;manu&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcode&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;True&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;80.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed&lt;/merchProductVariantKey&gt;&lt;merchVersionKey&gt;9526f241-aa66-4d26-bc63-846344f59160&lt;/merchVersionKey&gt;&lt;umbracoContentId&gt;2109&lt;/umbracoContentId&gt;&lt;merchProductKey&gt;445a79c5-e359-4e39-b2bd-f10ec1e0dc26&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;25.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;100.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;0&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;ManuNumber&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 19:42:15.177' AS DateTime), CAST(N'2015-12-14 19:30:49.290' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'd0654d90-700b-44d7-85d4-c4732e0afdf5', N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', 1, CAST(0.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchCurrencyCode>DKK</merchCurrencyCode></extendedData>', CAST(N'2015-12-14 22:51:40.940' AS DateTime), CAST(N'2015-12-14 22:51:40.940' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'02301057-e6e3-42a9-9cf3-d4a714b91ff5', N'4f7805e1-8b1b-4bb2-a6e8-a2a6ed5c0f17', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;1233-Blue&lt;/merchSku&gt;&lt;merchName&gt;First shoelace&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;80.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.000000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;manu&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcode&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;True&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;80.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed&lt;/merchProductVariantKey&gt;&lt;merchVersionKey&gt;9526f241-aa66-4d26-bc63-846344f59160&lt;/merchVersionKey&gt;&lt;umbracoContentId&gt;2109&lt;/umbracoContentId&gt;&lt;merchProductKey&gt;445a79c5-e359-4e39-b2bd-f10ec1e0dc26&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;25.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;100.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;0&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;ManuNumber&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 23:02:39.187' AS DateTime), CAST(N'2015-12-14 19:33:01.083' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'7948f09f-eda7-401c-8037-e4bfc265d164', N'4e54f0cb-fbf7-4d38-a365-212a147f12f0', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;Skunumber2&lt;/merchSku&gt;&lt;merchName&gt;Second product&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.500000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;2.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;Laceshoppers&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcondefor2&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;False&lt;/merchOnSale&gt;&lt;merchHeight&gt;2.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;150.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;8a92a440-4dac-4d8e-b915-4634f8e559f2&lt;/merchProductVariantKey&gt;&lt;umbracoContentId&gt;2110&lt;/umbracoContentId&gt;&lt;merchVersionKey&gt;0b74b8bf-7af9-4971-86d9-690a188091d2&lt;/merchVersionKey&gt;&lt;merchProductKey&gt;6b0addbd-d511-4e7c-aeec-fc9a4225628e&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;50.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;-1&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;1235455&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;2.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 22:51:40.937' AS DateTime), CAST(N'2015-12-14 22:51:40.937' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'73bf12ff-f656-40d5-bd51-fe8f00c8596e', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>ada55e50-30bb-4c54-a885-a4988ac84f73</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 23:03:13.383' AS DateTime), CAST(N'2015-12-14 22:58:55.297' AS DateTime))
INSERT [dbo].[merchInvoiceItem] ([pk], [invoiceKey], [lineItemTfKey], [sku], [name], [quantity], [price], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'20131309-b88f-4814-8840-ffd8692fc07b', N'eb39fee8-952f-465b-8e97-da4dbac221cd', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 2 items', 1, CAST(20.000000 AS Decimal(38, 6)), 0, N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchCurrencyCode>DKK</merchCurrencyCode><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;1233-Blue&lt;/merchSku&gt;&lt;merchName&gt;First shoelace - Blue&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;80.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.000000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;manu&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcode&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;True&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;80.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed&lt;/merchProductVariantKey&gt;&lt;merchVersionKey&gt;ada55e50-30bb-4c54-a885-a4988ac84f73&lt;/merchVersionKey&gt;&lt;umbracoContentId&gt;2109&lt;/umbracoContentId&gt;&lt;merchProductKey&gt;445a79c5-e359-4e39-b2bd-f10ec1e0dc26&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;25.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;100.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;0&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;ManuNumber&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;Skunumber2&lt;/merchSku&gt;&lt;merchName&gt;Second product&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.500000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;2.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;Laceshoppers&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcondefor2&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;False&lt;/merchOnSale&gt;&lt;merchHeight&gt;2.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;150.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;8a92a440-4dac-4d8e-b915-4634f8e559f2&lt;/merchProductVariantKey&gt;&lt;merchVersionKey&gt;0b74b8bf-7af9-4971-86d9-690a188091d2&lt;/merchVersionKey&gt;&lt;umbracoContentId&gt;2110&lt;/umbracoContentId&gt;&lt;merchProductKey&gt;6b0addbd-d511-4e7c-aeec-fc9a4225628e&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;50.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;-1&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;1235455&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;2.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', CAST(N'2015-12-14 23:03:13.390' AS DateTime), CAST(N'2015-12-14 22:58:55.300' AS DateTime))
INSERT [dbo].[merchInvoiceStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'53077efd-6bf0-460d-9565-0e00567b5176', N'Cancelled', N'cancelled', 1, 1, 4, CAST(N'2015-12-05 00:12:26.060' AS DateTime), CAST(N'2015-12-05 00:12:26.060' AS DateTime))
INSERT [dbo].[merchInvoiceStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'17ada9ac-c893-4c26-aa26-234eceb2fa75', N'Unpaid', N'unpaid', 1, 1, 1, CAST(N'2015-12-05 00:12:26.057' AS DateTime), CAST(N'2015-12-05 00:12:26.057' AS DateTime))
INSERT [dbo].[merchInvoiceStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'75e1e5eb-33e8-4904-a8e5-4b64a37d6087', N'Fraud', N'fraud', 1, 1, 5, CAST(N'2015-12-05 00:12:26.060' AS DateTime), CAST(N'2015-12-05 00:12:26.060' AS DateTime))
INSERT [dbo].[merchInvoiceStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'1f872a1a-f0dd-4c3e-80ab-99799a28606e', N'Paid', N'paid', 1, 1, 2, CAST(N'2015-12-05 00:12:26.057' AS DateTime), CAST(N'2015-12-05 00:12:26.057' AS DateTime))
INSERT [dbo].[merchInvoiceStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'6606b0ea-15b6-44aa-8557-b2d9d049645c', N'Partial', N'partial', 1, 1, 3, CAST(N'2015-12-05 00:12:26.057' AS DateTime), CAST(N'2015-12-05 00:12:26.057' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'4c087e19-009c-46d5-a669-02c956d550a5', N'57931f88-c921-429e-b473-5f9b08a7ab4c', N'c53e3100-2dfd-408a-872e-4380383fad35', N'143661eb-e63f-48b0-8103-fcb54b08fa1d', CAST(N'2015-12-13 11:48:05.807' AS DateTime), CAST(N'2015-12-13 11:34:53.153' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'27d48f50-936b-4486-9eb2-032149fd485e', N'6e487946-b9e7-4dd9-a2fd-0de8b07f8c36', N'c53e3100-2dfd-408a-872e-4380383fad35', N'0b26455e-1d3b-4bc7-b793-2a550e936a1f', CAST(N'2015-12-12 22:41:07.110' AS DateTime), CAST(N'2015-12-12 10:55:16.933' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'1f97ac5b-574d-4059-893b-25400fa7755e', N'75475f42-b152-4a26-940f-1c93959c227f', N'c53e3100-2dfd-408a-872e-4380383fad35', N'd35a7097-fc25-40ca-b940-99bf17b75f6c', CAST(N'2015-12-08 17:28:12.140' AS DateTime), CAST(N'2015-12-08 17:28:12.140' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'2b8dddb1-78d8-41eb-8378-2a34f289671b', N'fc2bb781-7d76-4e09-8aa4-f637710683ba', N'c53e3100-2dfd-408a-872e-4380383fad35', N'5e8160d6-0622-4fea-bbde-4612dd1cdb28', CAST(N'2015-12-08 17:12:42.417' AS DateTime), CAST(N'2015-12-08 17:12:42.417' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'df66fcfc-fdf5-4d0b-a756-4c8be5043725', N'60a78f22-97ce-478b-837a-2d22bd477543', N'c53e3100-2dfd-408a-872e-4380383fad35', N'93e1eb55-13cf-4bb2-a883-281966d464f1', CAST(N'2015-12-08 22:56:24.967' AS DateTime), CAST(N'2015-12-08 21:31:34.900' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'95d7232f-9fb5-41ce-bfa6-4fd74971bfd3', N'590d9d2d-c114-411f-a8e5-db7ade13cc07', N'c53e3100-2dfd-408a-872e-4380383fad35', N'5b5cd486-72d3-42d2-a51e-464ecf4c82ff', CAST(N'2015-12-08 17:29:01.463' AS DateTime), CAST(N'2015-12-08 17:29:01.463' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'c5a4b653-067a-4ca2-96ab-597f011a5599', N'fcc54412-7c2b-4aa1-8be0-d2a7bcfa9b79', N'c53e3100-2dfd-408a-872e-4380383fad35', N'01ee78ee-d57d-4e43-b75f-4c1aa9ce39a6', CAST(N'2015-12-08 17:13:26.180' AS DateTime), CAST(N'2015-12-08 17:13:26.180' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'956eb679-28d2-4128-8708-5a3e1332fac4', N'57931f88-c921-429e-b473-5f9b08a7ab4c', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'143661eb-e63f-48b0-8103-fcb54b08fa1d', CAST(N'2015-12-13 11:48:05.830' AS DateTime), CAST(N'2015-12-13 11:48:05.830' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'ecf564a5-9665-4337-b1f8-5c7a46525b57', N'b6dedc1e-f11f-4f05-a79a-115b8de41bbd', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'336978ba-f13f-4808-9b9c-59c7263d09c8', CAST(N'2015-12-12 00:58:19.920' AS DateTime), CAST(N'2015-12-12 00:58:19.920' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'41c04c30-d1e0-4cea-996b-5fae1c25b3c8', N'b148bfa2-a8b7-4885-aaf1-622a123e9f77', N'c53e3100-2dfd-408a-872e-4380383fad35', N'1540c8e4-b641-4830-9a41-90d9271c1f4e', CAST(N'2015-12-08 17:14:39.363' AS DateTime), CAST(N'2015-12-08 17:14:39.363' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'81bf39ce-e05c-4569-82fc-61dad25e0045', N'cbb6ce85-9fa6-4821-a9d5-92b5266eacf2', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'2a331f51-fee5-4431-b4c8-b8c9d142b78e', CAST(N'2015-12-13 01:49:33.593' AS DateTime), CAST(N'2015-12-13 01:49:33.593' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'17ec8591-9cbf-4680-9fba-62952098bff9', N'2e57021d-4937-4484-9fe1-13f4685ee141', N'c53e3100-2dfd-408a-872e-4380383fad35', N'43d7c4bd-63f5-41a9-914b-147f126470e2', CAST(N'2015-12-11 18:59:44.200' AS DateTime), CAST(N'2015-12-11 18:59:44.200' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'2fc7c07f-d0d2-4553-8969-6556461c7de5', N'3ef561b0-acaf-4e5e-b69a-a854bec4d6f6', N'c53e3100-2dfd-408a-872e-4380383fad35', N'd395e25c-80ad-42ba-869e-6dc967e0e499', CAST(N'2015-12-08 17:13:01.183' AS DateTime), CAST(N'2015-12-08 17:13:01.183' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'9652fadf-d6a2-41b1-bc80-66419955b6ae', N'cbb6ce85-9fa6-4821-a9d5-92b5266eacf2', N'c53e3100-2dfd-408a-872e-4380383fad35', N'2a331f51-fee5-4431-b4c8-b8c9d142b78e', CAST(N'2015-12-13 01:49:33.407' AS DateTime), CAST(N'2015-12-13 01:49:25.020' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'293dc7e7-1bc2-41be-9a1c-6dcb7c20aaad', N'2f49a5af-0105-4c83-af79-355ba9652544', N'c53e3100-2dfd-408a-872e-4380383fad35', N'351f0a0a-84ad-4815-b3c5-f22d6ebabce6', CAST(N'2015-12-11 17:36:50.993' AS DateTime), CAST(N'2015-12-11 17:36:39.887' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'f090fd3a-e7b9-4e88-abb8-70bf69cb7c0b', N'8c30934f-7fd6-463b-920b-360189a26bf9', N'c53e3100-2dfd-408a-872e-4380383fad35', N'83db0708-a064-4051-90f9-c8108bd21b35', CAST(N'2015-12-08 17:18:39.373' AS DateTime), CAST(N'2015-12-08 17:18:39.373' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'fa8f2ba5-2d0d-4a0c-a1b1-72590af18950', N'6e487946-b9e7-4dd9-a2fd-0de8b07f8c36', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'0b26455e-1d3b-4bc7-b793-2a550e936a1f', CAST(N'2015-12-12 22:41:07.157' AS DateTime), CAST(N'2015-12-12 22:41:07.157' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'f4d296c7-c94a-4cc2-878c-7726124cc6ba', N'b6dedc1e-f11f-4f05-a79a-115b8de41bbd', N'c53e3100-2dfd-408a-872e-4380383fad35', N'336978ba-f13f-4808-9b9c-59c7263d09c8', CAST(N'2015-12-12 00:58:17.333' AS DateTime), CAST(N'2015-12-11 19:06:45.110' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'21c13209-404b-42c1-9cb4-78d3038b9ae6', N'c0301535-0726-4407-a56b-dbbe3aa6bbe8', N'c53e3100-2dfd-408a-872e-4380383fad35', N'effa7fec-9e22-40b3-bd4a-e0e2c8bb77fd', CAST(N'2015-12-08 17:17:56.897' AS DateTime), CAST(N'2015-12-08 17:17:56.897' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'ecc87281-5318-4ff5-9073-902e64ec0d4f', N'40a6170b-d3da-497d-baa9-7fd97c03c2a6', N'c53e3100-2dfd-408a-872e-4380383fad35', N'b3b86bef-3358-4991-af8c-8d1d885aff94', CAST(N'2015-12-08 17:14:39.377' AS DateTime), CAST(N'2015-12-08 17:14:39.377' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'c807c009-dc44-4823-998e-9386d5f669dc', N'486dbe0f-70b3-4daa-ad3d-4d84c379fa64', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'38aa1f10-f334-4879-a091-e1e97da39dd7', CAST(N'2015-12-08 20:32:08.907' AS DateTime), CAST(N'2015-12-08 20:32:08.907' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'30cb7167-a522-4e76-a46f-94a15a7558f5', N'cb5bd5a3-fa79-43ac-b4d5-abdaf13f0382', N'c53e3100-2dfd-408a-872e-4380383fad35', N'bffb5c16-8b0e-448c-adb6-3c6161aeca5b', CAST(N'2015-12-08 17:29:05.123' AS DateTime), CAST(N'2015-12-08 17:29:05.123' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'd34b90b8-adcd-4dc8-9372-a0860ccb2d6b', N'5f6f2cbe-6990-4c36-a83e-11678209e30e', N'c53e3100-2dfd-408a-872e-4380383fad35', N'7507c408-9c99-409f-8865-53dfcef84036', CAST(N'2015-12-08 17:12:53.447' AS DateTime), CAST(N'2015-12-08 17:12:53.447' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'fa8128e5-9b7a-4ed8-bf2e-a81e4c985d33', N'81d0794b-f97b-4f40-8436-64ab95089749', N'c53e3100-2dfd-408a-872e-4380383fad35', N'b001fe75-82ed-4902-b729-1f6f386d1250', CAST(N'2015-12-11 18:46:50.620' AS DateTime), CAST(N'2015-12-11 18:46:46.007' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'ae08256a-ed28-4358-bdbe-af0912bf67c0', N'c5d75683-6102-49ad-8f56-4d2a5e9cdf4c', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'5d62b5b6-2960-4aa4-a328-37c17ea78f41', CAST(N'2015-12-13 23:08:04.153' AS DateTime), CAST(N'2015-12-13 21:33:21.333' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'7f460a83-d8cb-4c91-9843-b0242f9c3c8a', N'fe5911e5-957f-440c-9a77-9981b2178866', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'b72385b0-82ca-4405-8160-9198812bed09', CAST(N'2015-12-14 23:04:45.960' AS DateTime), CAST(N'2015-12-14 23:04:45.960' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'f1c88656-401d-4878-a254-bab32f5d316a', N'fe5911e5-957f-440c-9a77-9981b2178866', N'c53e3100-2dfd-408a-872e-4380383fad35', N'82726968-f576-4e72-8951-bae323983bfb', CAST(N'2015-12-14 23:12:05.833' AS DateTime), CAST(N'2015-12-14 17:14:53.553' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'856482c8-8f3b-4d93-a752-c20a8f8ee910', N'60a78f22-97ce-478b-837a-2d22bd477543', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'4a83324f-8077-4f86-8f07-24897d8b17d3', CAST(N'2015-12-08 21:36:45.200' AS DateTime), CAST(N'2015-12-08 21:36:45.200' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'95bcaae1-e36b-43da-ac0f-c26d615ff956', N'0a219d71-25de-4e84-9cc3-9387928fedee', N'c53e3100-2dfd-408a-872e-4380383fad35', N'584317b5-15a9-457a-962f-30ca9185c418', CAST(N'2015-12-08 17:18:30.160' AS DateTime), CAST(N'2015-12-08 17:18:30.160' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'af50de63-8349-49ee-aea0-c7279953261c', N'0432144a-b4f3-4231-b888-0daf05955066', N'c53e3100-2dfd-408a-872e-4380383fad35', N'd78ff28a-f6d8-4619-ba1a-2bb51f9230cc', CAST(N'2015-12-08 17:21:16.693' AS DateTime), CAST(N'2015-12-08 17:21:16.693' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'9e156f52-f937-448a-9f2f-c8336d8dd3fd', N'5c55ce2c-c64e-4eaf-9272-8e2b45519619', N'c53e3100-2dfd-408a-872e-4380383fad35', N'd735aaff-9dea-4d98-bc4e-187593b77cdf', CAST(N'2015-12-08 17:22:00.623' AS DateTime), CAST(N'2015-12-08 17:22:00.623' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'1541a32a-616f-4b9d-a8af-c86fa682d119', N'486dbe0f-70b3-4daa-ad3d-4d84c379fa64', N'c53e3100-2dfd-408a-872e-4380383fad35', N'38aa1f10-f334-4879-a091-e1e97da39dd7', CAST(N'2015-12-08 20:32:08.783' AS DateTime), CAST(N'2015-12-08 17:29:21.310' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'69448e68-8a0e-477f-a94f-d064a15dc857', N'ef53884d-1eeb-4ab0-be8c-afd00743e360', N'c53e3100-2dfd-408a-872e-4380383fad35', N'00acc29c-700c-4cd1-ad6c-a9d70efa8868', CAST(N'2015-12-08 17:18:53.750' AS DateTime), CAST(N'2015-12-08 17:18:53.750' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'60b7559a-7b4d-4a34-902a-d14147834881', N'c5d75683-6102-49ad-8f56-4d2a5e9cdf4c', N'c53e3100-2dfd-408a-872e-4380383fad35', N'5d62b5b6-2960-4aa4-a328-37c17ea78f41', CAST(N'2015-12-13 21:33:21.280' AS DateTime), CAST(N'2015-12-13 13:32:23.700' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'69e89ded-650f-43c9-b751-d7d0e7e617f1', N'810aa5a4-96c0-417d-b979-1ca8023f1294', N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'e798c761-97ae-4016-aa00-b4bab070e134', CAST(N'2015-12-13 13:12:45.047' AS DateTime), CAST(N'2015-12-13 13:12:45.047' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'342717b4-cde0-40a1-be25-f61a6fb35209', N'18cefd41-08ee-440f-b979-dcf5891f99ec', N'c53e3100-2dfd-408a-872e-4380383fad35', N'c39eda03-9318-4f07-890c-1ef80d463c18', CAST(N'2015-12-08 17:12:31.933' AS DateTime), CAST(N'2015-12-08 17:12:31.933' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'c761e2dd-6b94-4989-9d37-f70f9e302fa4', N'd00beda6-160a-4bce-9273-3226b8b7b47b', N'c53e3100-2dfd-408a-872e-4380383fad35', N'2d22fc79-dfd8-4d37-9e5c-837710fc3434', CAST(N'2015-12-08 17:27:52.927' AS DateTime), CAST(N'2015-12-08 17:27:52.927' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'2a14ec77-c807-4458-9682-f768ac624068', N'810aa5a4-96c0-417d-b979-1ca8023f1294', N'c53e3100-2dfd-408a-872e-4380383fad35', N'e798c761-97ae-4016-aa00-b4bab070e134', CAST(N'2015-12-13 13:12:45.010' AS DateTime), CAST(N'2015-12-13 13:11:49.260' AS DateTime))
INSERT [dbo].[merchItemCache] ([pk], [entityKey], [itemCacheTfKey], [versionKey], [updateDate], [createDate]) VALUES (N'388d8a77-6bd2-4fa8-befd-fe8efa970936', N'05b934ba-f1b9-49ee-a63e-e619fa335c6b', N'c53e3100-2dfd-408a-872e-4380383fad35', N'2e35728c-5fc8-4e23-9258-8729418706b7', CAST(N'2015-12-08 17:17:34.217' AS DateTime), CAST(N'2015-12-08 17:17:34.217' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'b914b65f-674b-4f2b-8147-28ff27dfc32d', N'fa8128e5-9b7a-4ed8-bf2e-a81e4c985d33', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace', 1, CAST(80.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>e07fecbd-ef87-4d28-92cb-362899dd321d</merchVersionKey><umbracoContentId>2073</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-11 18:46:50.627' AS DateTime), CAST(N'2015-12-11 18:46:47.650' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'0a677e82-12cb-4f60-ad99-3d1fdba18870', N'f1c88656-401d-4878-a254-bab32f5d316a', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Red', N'First shoelace - Red', 1, CAST(80.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>True</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>873edc9e-331b-43dc-83f8-97749fbcfa99</merchProductVariantKey><merchVersionKey>f7bf96f0-c447-4c86-a116-e076f2a107f8</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-14 23:12:05.837' AS DateTime), CAST(N'2015-12-14 23:11:59.657' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'2bdb79a3-54ed-4b4f-81f9-43ae8c8287c6', N'ae08256a-ed28-4358-bdbe-af0912bf67c0', N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', N'Shipment - Other shipping provider - 1 items', 1, CAST(20.000000 AS Decimal(38, 6)), N'<extendedData><merchShippingOriginAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a st th&lt;/Address1&gt;&lt;Address2 i:nil="true" /&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;DK&lt;/CountryCode&gt;&lt;Email i:nil="true" /&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;8210&lt;/Locality&gt;&lt;Name&gt;Default Warehouse&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingOriginAddress><merchShippingDestinationAddress>&lt;Address xmlns:i="http://www.w3.org/2001/XMLSchema-instance" z:Id="i1" xmlns:z="http://schemas.microsoft.com/2003/10/Serialization/" xmlns="http://schemas.datacontract.org/2004/07/Merchello.Core.Models"&gt;&lt;Address1&gt;Ryhavevej 1a &lt;/Address1&gt;&lt;Address2&gt;st th 1a&lt;/Address2&gt;&lt;AddressType&gt;Shipping&lt;/AddressType&gt;&lt;CountryCode&gt;GB&lt;/CountryCode&gt;&lt;Email&gt;niclas@schu.dk&lt;/Email&gt;&lt;IsCommercial&gt;false&lt;/IsCommercial&gt;&lt;Locality&gt;Aarhus V&lt;/Locality&gt;&lt;Name&gt;Niclas Schumacher&lt;/Name&gt;&lt;Organization i:nil="true" /&gt;&lt;Phone i:nil="true" /&gt;&lt;PostalCode&gt;8210&lt;/PostalCode&gt;&lt;Region i:nil="true" /&gt;&lt;/Address&gt;</merchShippingDestinationAddress><merchLineItemCollection>&lt;merchLineItemCollection&gt;&lt;merchLineItem&gt;&lt;merchContainerKey&gt;00000000-0000-0000-0000-000000000000&lt;/merchContainerKey&gt;&lt;merchLineItemTfKey&gt;d462c051-07f4-45f5-aad2-d5c844159f04&lt;/merchLineItemTfKey&gt;&lt;merchSku&gt;Skunumber2&lt;/merchSku&gt;&lt;merchName&gt;Second product&lt;/merchName&gt;&lt;merchQuantity&gt;1&lt;/merchQuantity&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchExtendedData&gt;&lt;extendedData&gt;&lt;merchWeight&gt;0.500000&lt;/merchWeight&gt;&lt;merchDownload&gt;False&lt;/merchDownload&gt;&lt;merchShippable&gt;True&lt;/merchShippable&gt;&lt;merchLength&gt;0.000000&lt;/merchLength&gt;&lt;merchManufacturer&gt;Laceshoppers&lt;/merchManufacturer&gt;&lt;merchTaxable&gt;True&lt;/merchTaxable&gt;&lt;merchBarcode&gt;barcondefor2&lt;/merchBarcode&gt;&lt;merchOutOfStockPurchase&gt;False&lt;/merchOutOfStockPurchase&gt;&lt;merchOnSale&gt;False&lt;/merchOnSale&gt;&lt;merchHeight&gt;0.000000&lt;/merchHeight&gt;&lt;merchSalePrice&gt;150.000000&lt;/merchSalePrice&gt;&lt;merchProductVariantKey&gt;8a92a440-4dac-4d8e-b915-4634f8e559f2&lt;/merchProductVariantKey&gt;&lt;umbracoContentId&gt;2110&lt;/umbracoContentId&gt;&lt;merchVersionKey&gt;f0572d1e-0f0e-439b-9685-7c4f6e26c950&lt;/merchVersionKey&gt;&lt;merchProductKey&gt;6b0addbd-d511-4e7c-aeec-fc9a4225628e&lt;/merchProductKey&gt;&lt;merchTrackInventory&gt;True&lt;/merchTrackInventory&gt;&lt;merchCostOfGoods&gt;0.000000&lt;/merchCostOfGoods&gt;&lt;merchPrice&gt;200.000000&lt;/merchPrice&gt;&lt;merchDownloadMediaId&gt;-1&lt;/merchDownloadMediaId&gt;&lt;merchManufacturerModelNumber&gt;1235455&lt;/merchManufacturerModelNumber&gt;&lt;merchWarehouseCatalogKey&gt;b25c2b00-578e-49b9-bea2-bf3712053c63&lt;/merchWarehouseCatalogKey&gt;&lt;merchWidth&gt;0.000000&lt;/merchWidth&gt;&lt;/extendedData&gt;&lt;/merchExtendedData&gt;&lt;/merchLineItem&gt;&lt;/merchLineItemCollection&gt;</merchLineItemCollection><merchShipMethodKey>ff73e86b-a306-4614-ac94-cb77b9e49924</merchShipMethodKey></extendedData>', 0, CAST(N'2015-12-13 23:08:04.157' AS DateTime), CAST(N'2015-12-13 23:08:04.157' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'a223638e-3b5e-4570-a5dd-5ea52a0abd5c', N'f1c88656-401d-4878-a254-bab32f5d316a', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>67ea2d5a-25bc-4ced-8ebb-2465d4a4ed81</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-14 23:12:05.837' AS DateTime), CAST(N'2015-12-14 23:12:03.267' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'd37fd6a2-9365-470e-bd7d-b0fb09698018', N'ae08256a-ed28-4358-bdbe-af0912bf67c0', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><merchVersionKey>f0572d1e-0f0e-439b-9685-7c4f6e26c950</merchVersionKey><umbracoContentId>2110</umbracoContentId><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>0.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-13 23:08:04.157' AS DateTime), CAST(N'2015-12-13 22:25:05.890' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'55e32987-9c53-49a0-823d-b30395004f55', N'fa8128e5-9b7a-4ed8-bf2e-a81e4c985d33', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><merchVersionKey>f0572d1e-0f0e-439b-9685-7c4f6e26c950</merchVersionKey><umbracoContentId>2074</umbracoContentId><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>0.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-11 18:46:50.630' AS DateTime), CAST(N'2015-12-11 18:46:50.630' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'00c2b51c-cc1c-4eab-8605-b88900f5caa0', N'1541a32a-616f-4b9d-a8af-c86fa682d119', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233', N'First shoelace', 5, CAST(80.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>45feb315-d8d7-4b69-bf5c-10599ada21ff</merchProductVariantKey><umbracoContentId>2073</umbracoContentId><merchVersionKey>9b314dfe-953d-41fd-96a6-a11a41626bfd</merchVersionKey><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-08 20:32:08.797' AS DateTime), CAST(N'2015-12-08 17:31:02.170' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'21d878c7-f38b-45c8-a22a-c0cb31ff69e3', N'293dc7e7-1bc2-41be-9a1c-6dcb7c20aaad', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace', 2, CAST(80.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>e07fecbd-ef87-4d28-92cb-362899dd321d</merchVersionKey><umbracoContentId>2073</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-11 17:36:51.007' AS DateTime), CAST(N'2015-12-11 17:36:47.753' AS DateTime))
INSERT [dbo].[merchItemCacheItem] ([pk], [itemCacheKey], [lineItemTfKey], [sku], [name], [quantity], [price], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'65137b6d-2bfa-44e2-b6ce-c69788a76f9e', N'60b7559a-7b4d-4a34-902a-d14147834881', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><merchVersionKey>f0572d1e-0f0e-439b-9685-7c4f6e26c950</merchVersionKey><umbracoContentId>2110</umbracoContentId><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>0.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWidth>0.000000</merchWidth></extendedData>', 0, CAST(N'2015-12-13 21:33:21.297' AS DateTime), CAST(N'2015-12-13 21:33:08.213' AS DateTime))
INSERT [dbo].[merchOrder] ([pk], [invoiceKey], [orderNumberPrefix], [orderNumber], [orderDate], [orderStatusKey], [versionKey], [exported], [updateDate], [createDate]) VALUES (N'e882e81e-a9f9-4bec-bba6-29a29ef18fc7', N'eb39fee8-952f-465b-8e97-da4dbac221cd', NULL, 3, CAST(N'2015-12-14 23:03:13.307' AS DateTime), N'e67b414e-0e55-480d-9429-1204ad46ecda', N'd988b09c-2a95-4bb4-ba38-182ab0ca7636', 0, CAST(N'2015-12-14 23:03:38.863' AS DateTime), CAST(N'2015-12-14 23:03:13.317' AS DateTime))
INSERT [dbo].[merchOrder] ([pk], [invoiceKey], [orderNumberPrefix], [orderNumber], [orderDate], [orderStatusKey], [versionKey], [exported], [updateDate], [createDate]) VALUES (N'1f457a05-5211-4e56-b11c-e77d2b774a1e', N'7e9ce0dc-3d7a-40e2-b5e1-caa0198d7de6', NULL, 2, CAST(N'2015-12-14 19:33:25.430' AS DateTime), N'd5369b84-8cca-4586-8fba-f3020f5e06ec', N'aac450ce-a9e0-490b-9cda-736efdb821ad', 0, CAST(N'2015-12-14 19:42:20.697' AS DateTime), CAST(N'2015-12-14 19:33:25.440' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchOrderIndex] ON 

INSERT [dbo].[merchOrderIndex] ([id], [orderKey], [updateDate], [createDate]) VALUES (1, N'1f457a05-5211-4e56-b11c-e77d2b774a1e', CAST(N'2015-12-14 19:33:25.440' AS DateTime), CAST(N'2015-12-14 19:33:25.440' AS DateTime))
INSERT [dbo].[merchOrderIndex] ([id], [orderKey], [updateDate], [createDate]) VALUES (2, N'e882e81e-a9f9-4bec-bba6-29a29ef18fc7', CAST(N'2015-12-14 23:03:13.317' AS DateTime), CAST(N'2015-12-14 23:03:13.317' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchOrderIndex] OFF
INSERT [dbo].[merchOrderItem] ([pk], [orderKey], [shipmentKey], [lineItemTfKey], [sku], [name], [quantity], [price], [backOrder], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'4ca8aa24-a4cb-4d0a-ac4d-39dae42672b8', N'e882e81e-a9f9-4bec-bba6-29a29ef18fc7', N'68fcd61a-1f4d-4a6d-8e19-a21f20ef928a', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Skunumber2', N'Second product', 1, CAST(200.000000 AS Decimal(38, 6)), 0, 0, N'<extendedData><merchWeight>0.500000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>2.000000</merchLength><merchManufacturer>Laceshoppers</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcondefor2</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>False</merchOnSale><merchHeight>2.000000</merchHeight><merchSalePrice>150.000000</merchSalePrice><merchProductVariantKey>8a92a440-4dac-4d8e-b915-4634f8e559f2</merchProductVariantKey><merchVersionKey>0b74b8bf-7af9-4971-86d9-690a188091d2</merchVersionKey><umbracoContentId>2110</umbracoContentId><merchProductKey>6b0addbd-d511-4e7c-aeec-fc9a4225628e</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>50.000000</merchCostOfGoods><merchPrice>200.000000</merchPrice><merchDownloadMediaId>-1</merchDownloadMediaId><merchManufacturerModelNumber>1235455</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>2.000000</merchWidth></extendedData>', CAST(N'2015-12-14 23:03:38.877' AS DateTime), CAST(N'2015-12-14 23:03:13.337' AS DateTime))
INSERT [dbo].[merchOrderItem] ([pk], [orderKey], [shipmentKey], [lineItemTfKey], [sku], [name], [quantity], [price], [backOrder], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'8bd8ed29-062a-48db-93c5-bd2636904c65', N'e882e81e-a9f9-4bec-bba6-29a29ef18fc7', N'68fcd61a-1f4d-4a6d-8e19-a21f20ef928a', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), 0, 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><merchVersionKey>ada55e50-30bb-4c54-a885-a4988ac84f73</merchVersionKey><umbracoContentId>2109</umbracoContentId><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 23:03:38.873' AS DateTime), CAST(N'2015-12-14 23:03:13.333' AS DateTime))
INSERT [dbo].[merchOrderItem] ([pk], [orderKey], [shipmentKey], [lineItemTfKey], [sku], [name], [quantity], [price], [backOrder], [exported], [extendedData], [updateDate], [createDate]) VALUES (N'49423c47-196f-4ef2-a2ce-cb1a33535a53', N'1f457a05-5211-4e56-b11c-e77d2b774a1e', N'bd966aa4-de80-407e-b204-da3e12639c69', N'd462c051-07f4-45f5-aad2-d5c844159f04', N'1233-Blue', N'First shoelace - Blue', 1, CAST(80.000000 AS Decimal(38, 6)), 0, 0, N'<extendedData><merchWeight>0.000000</merchWeight><merchDownload>False</merchDownload><merchShippable>True</merchShippable><merchLength>0.000000</merchLength><merchManufacturer>manu</merchManufacturer><merchTaxable>True</merchTaxable><merchBarcode>barcode</merchBarcode><merchOutOfStockPurchase>False</merchOutOfStockPurchase><merchOnSale>True</merchOnSale><merchHeight>0.000000</merchHeight><merchSalePrice>80.000000</merchSalePrice><merchProductVariantKey>7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed</merchProductVariantKey><umbracoContentId>2109</umbracoContentId><merchVersionKey>9526f241-aa66-4d26-bc63-846344f59160</merchVersionKey><merchProductKey>445a79c5-e359-4e39-b2bd-f10ec1e0dc26</merchProductKey><merchCurrencyCode>DKK</merchCurrencyCode><merchTrackInventory>True</merchTrackInventory><merchCostOfGoods>25.000000</merchCostOfGoods><merchPrice>100.000000</merchPrice><merchDownloadMediaId>0</merchDownloadMediaId><merchManufacturerModelNumber>ManuNumber</merchManufacturerModelNumber><merchWarehouseCatalogKey>b25c2b00-578e-49b9-bea2-bf3712053c63</merchWarehouseCatalogKey><merchWidth>0.000000</merchWidth></extendedData>', CAST(N'2015-12-14 19:42:20.703' AS DateTime), CAST(N'2015-12-14 19:33:25.457' AS DateTime))
INSERT [dbo].[merchOrderStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'e67b414e-0e55-480d-9429-1204ad46ecda', N'Open', N'open', 1, 1, 2, CAST(N'2015-12-05 00:12:26.063' AS DateTime), CAST(N'2015-12-05 00:12:26.063' AS DateTime))
INSERT [dbo].[merchOrderStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'c54d47e6-d1c9-40d5-9baf-18c6adffe9d0', N'Not Fulfilled', N'notfulfilled', 1, 1, 1, CAST(N'2015-12-05 00:12:26.060' AS DateTime), CAST(N'2015-12-05 00:12:26.060' AS DateTime))
INSERT [dbo].[merchOrderStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'c47d475f-a075-4635-bbb9-4b9c49aa8ebe', N'BackOrder', N'backOrder', 1, 1, 4, CAST(N'2015-12-05 00:12:26.063' AS DateTime), CAST(N'2015-12-05 00:12:26.063' AS DateTime))
INSERT [dbo].[merchOrderStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'77daf52e-c79c-4e1b-898c-5e977a9a6027', N'Cancelled', N'cancelled', 1, 1, 5, CAST(N'2015-12-05 00:12:26.063' AS DateTime), CAST(N'2015-12-05 00:12:26.063' AS DateTime))
INSERT [dbo].[merchOrderStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'd5369b84-8cca-4586-8fba-f3020f5e06ec', N'Fulfilled', N'fulfilled', 1, 1, 3, CAST(N'2015-12-05 00:12:26.063' AS DateTime), CAST(N'2015-12-05 00:12:26.063' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'57165b01-542b-4a39-9806-5e2a9da353a6', NULL, N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash-7', CAST(300.000000 AS Decimal(38, 6)), 1, 1, 0, N'<extendedData />', 0, CAST(N'2015-12-14 23:03:13.290' AS DateTime), CAST(N'2015-12-14 22:58:55.337' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'72f298fa-56fd-406e-b406-80b7503727ad', NULL, N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash-5', CAST(220.000000 AS Decimal(38, 6)), 1, 0, 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:51:41.087' AS DateTime), CAST(N'2015-12-14 22:51:41.087' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'6f496087-d8a7-48f0-8224-85fe08c5574a', NULL, N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash-3', CAST(100.000000 AS Decimal(38, 6)), 1, 0, 1, N'<extendedData />', 0, CAST(N'2015-12-14 23:02:39.133' AS DateTime), CAST(N'2015-12-14 19:33:01.090' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'c6cc6cf3-460c-4c3b-a0d1-b1073deb88e4', NULL, N'8a6b414d-45ac-4193-9d9e-bc30efab71a1', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Card', N'Cash-8e5d9362-82a1-4cf2-afa6-6dfbd8f926b8-6', CAST(100.000000 AS Decimal(38, 6)), 1, 0, 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:58:12.637' AS DateTime), CAST(N'2015-12-14 22:58:12.637' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'577a0285-ed28-4e52-8e7a-cfcddf155d0a', NULL, N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash-2', CAST(100.000000 AS Decimal(38, 6)), 1, 1, 0, N'<extendedData />', 0, CAST(N'2015-12-14 19:33:25.410' AS DateTime), CAST(N'2015-12-14 19:30:49.353' AS DateTime))
INSERT [dbo].[merchPayment] ([pk], [customerKey], [paymentMethodKey], [paymentTfKey], [paymentMethodName], [referenceNumber], [amount], [authorized], [collected], [voided], [extendedData], [exported], [updateDate], [createDate]) VALUES (N'1f200041-8098-4f76-a30c-e038ac33f6b2', NULL, N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash-4', CAST(100.000000 AS Decimal(38, 6)), 1, 0, 0, N'<extendedData />', 0, CAST(N'2015-12-14 22:43:48.313' AS DateTime), CAST(N'2015-12-14 22:43:48.313' AS DateTime))
INSERT [dbo].[merchPaymentMethod] ([pk], [providerKey], [name], [description], [paymentCode], [updateDate], [createDate]) VALUES (N'8a6b414d-45ac-4193-9d9e-bc30efab71a1', N'b2612c3d-8bf0-411c-8c56-32e7495ae79c', N'Card', N'visa', N'Cash-8e5d9362-82a1-4cf2-afa6-6dfbd8f926b8', CAST(N'2015-12-14 19:21:01.440' AS DateTime), CAST(N'2015-12-14 19:21:01.430' AS DateTime))
INSERT [dbo].[merchPaymentMethod] ([pk], [providerKey], [name], [description], [paymentCode], [updateDate], [createDate]) VALUES (N'8a387fe0-9b9a-4f23-a1d6-f2cc39b88424', N'b2612c3d-8bf0-411c-8c56-32e7495ae79c', N'Cash', N'Cash Payment', N'Cash', CAST(N'2015-12-05 00:12:26.077' AS DateTime), CAST(N'2015-12-05 00:12:26.077' AS DateTime))
INSERT [dbo].[merchProduct] ([pk], [updateDate], [createDate]) VALUES (N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', CAST(N'2015-12-13 19:52:04.413' AS DateTime), CAST(N'2015-12-05 00:43:02.420' AS DateTime))
INSERT [dbo].[merchProduct] ([pk], [updateDate], [createDate]) VALUES (N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', CAST(N'2015-12-13 22:24:13.080' AS DateTime), CAST(N'2015-12-07 20:57:49.490' AS DateTime))
INSERT [dbo].[merchProduct2ProductOption] ([productKey], [optionKey], [sortOrder], [updateDate], [createDate]) VALUES (N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', 1, CAST(N'2015-12-13 19:52:04.440' AS DateTime), CAST(N'2015-12-08 20:59:08.137' AS DateTime))
INSERT [dbo].[merchProductAttribute] ([pk], [optionKey], [name], [sku], [sortOrder], [updateDate], [createDate]) VALUES (N'6f9a2c9c-e912-4b3c-ad18-6384c420f47b', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'Red', N'Red', 2, CAST(N'2015-12-13 19:52:04.453' AS DateTime), CAST(N'2015-12-08 20:59:08.153' AS DateTime))
INSERT [dbo].[merchProductAttribute] ([pk], [optionKey], [name], [sku], [sortOrder], [updateDate], [createDate]) VALUES (N'd75ae82f-9940-40fd-af05-7cf29547203c', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'Green', N'Green', 3, CAST(N'2015-12-13 19:52:04.453' AS DateTime), CAST(N'2015-12-08 20:59:08.153' AS DateTime))
INSERT [dbo].[merchProductAttribute] ([pk], [optionKey], [name], [sku], [sortOrder], [updateDate], [createDate]) VALUES (N'ba252d87-bac9-4666-90fa-c9e2fd369c4c', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'Blue', N'Blue', 1, CAST(N'2015-12-13 19:52:04.450' AS DateTime), CAST(N'2015-12-08 20:59:08.150' AS DateTime))
INSERT [dbo].[merchProductOption] ([pk], [name], [required], [updateDate], [createDate]) VALUES (N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'Color', 1, CAST(N'2015-12-13 19:52:04.440' AS DateTime), CAST(N'2015-12-08 20:59:08.133' AS DateTime))
INSERT [dbo].[merchProductVariant] ([pk], [productKey], [sku], [name], [price], [costOfGoods], [salePrice], [onSale], [manufacturer], [modelNumber], [weight], [length], [width], [height], [barcode], [available], [trackInventory], [outOfStockPurchase], [taxable], [shippable], [download], [downloadMediaId], [master], [versionKey], [updateDate], [createDate]) VALUES (N'45feb315-d8d7-4b69-bf5c-10599ada21ff', N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', N'1233', N'First shoelace', CAST(100.000000 AS Decimal(38, 6)), CAST(25.000000 AS Decimal(38, 6)), CAST(80.000000 AS Decimal(38, 6)), 1, N'manu', N'ManuNumber', CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), N'barcode', 1, 1, 0, 1, 1, 0, -1, 1, N'6f41df9a-ec54-4dd9-9e28-142dbfc47bc6', CAST(N'2015-12-13 19:52:04.413' AS DateTime), CAST(N'2015-12-05 00:43:02.423' AS DateTime))
INSERT [dbo].[merchProductVariant] ([pk], [productKey], [sku], [name], [price], [costOfGoods], [salePrice], [onSale], [manufacturer], [modelNumber], [weight], [length], [width], [height], [barcode], [available], [trackInventory], [outOfStockPurchase], [taxable], [shippable], [download], [downloadMediaId], [master], [versionKey], [updateDate], [createDate]) VALUES (N'975a3dee-a6cd-4952-810d-1504a95a30f3', N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', N'1233-Green', N'First shoelace - Green', CAST(100.000000 AS Decimal(38, 6)), CAST(25.000000 AS Decimal(38, 6)), CAST(80.000000 AS Decimal(38, 6)), 1, N'manu', N'ManuNumber', CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), N'barcode', 1, 1, 0, 1, 1, 0, NULL, 0, N'f7ab4fe1-b753-4b3b-9f3b-299e8d259f60', CAST(N'2015-12-13 19:52:04.537' AS DateTime), CAST(N'2015-12-08 20:59:08.277' AS DateTime))
INSERT [dbo].[merchProductVariant] ([pk], [productKey], [sku], [name], [price], [costOfGoods], [salePrice], [onSale], [manufacturer], [modelNumber], [weight], [length], [width], [height], [barcode], [available], [trackInventory], [outOfStockPurchase], [taxable], [shippable], [download], [downloadMediaId], [master], [versionKey], [updateDate], [createDate]) VALUES (N'8a92a440-4dac-4d8e-b915-4634f8e559f2', N'6b0addbd-d511-4e7c-aeec-fc9a4225628e', N'Skunumber2', N'Second product', CAST(200.000000 AS Decimal(38, 6)), CAST(50.000000 AS Decimal(38, 6)), CAST(150.000000 AS Decimal(38, 6)), 0, N'Laceshoppers', N'1235455', CAST(0.500000 AS Decimal(38, 6)), CAST(2.000000 AS Decimal(38, 6)), CAST(2.000000 AS Decimal(38, 6)), CAST(2.000000 AS Decimal(38, 6)), N'barcondefor2', 1, 1, 0, 1, 1, 0, -1, 1, N'1b4bf9ed-7753-4ecb-acfb-1d48ffeabb17', CAST(N'2015-12-14 23:03:38.797' AS DateTime), CAST(N'2015-12-07 20:57:49.490' AS DateTime))
INSERT [dbo].[merchProductVariant] ([pk], [productKey], [sku], [name], [price], [costOfGoods], [salePrice], [onSale], [manufacturer], [modelNumber], [weight], [length], [width], [height], [barcode], [available], [trackInventory], [outOfStockPurchase], [taxable], [shippable], [download], [downloadMediaId], [master], [versionKey], [updateDate], [createDate]) VALUES (N'7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed', N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', N'1233-Blue', N'First shoelace - Blue', CAST(100.000000 AS Decimal(38, 6)), CAST(25.000000 AS Decimal(38, 6)), CAST(80.000000 AS Decimal(38, 6)), 1, N'manu', N'ManuNumber', CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), N'barcode', 1, 1, 0, 1, 1, 0, 0, 0, N'67ea2d5a-25bc-4ced-8ebb-2465d4a4ed81', CAST(N'2015-12-14 23:03:38.777' AS DateTime), CAST(N'2015-12-08 20:59:08.190' AS DateTime))
INSERT [dbo].[merchProductVariant] ([pk], [productKey], [sku], [name], [price], [costOfGoods], [salePrice], [onSale], [manufacturer], [modelNumber], [weight], [length], [width], [height], [barcode], [available], [trackInventory], [outOfStockPurchase], [taxable], [shippable], [download], [downloadMediaId], [master], [versionKey], [updateDate], [createDate]) VALUES (N'873edc9e-331b-43dc-83f8-97749fbcfa99', N'445a79c5-e359-4e39-b2bd-f10ec1e0dc26', N'1233-Red', N'First shoelace - Red', CAST(100.000000 AS Decimal(38, 6)), CAST(25.000000 AS Decimal(38, 6)), CAST(80.000000 AS Decimal(38, 6)), 1, N'manu', N'ManuNumber', CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), CAST(0.000000 AS Decimal(38, 6)), N'barcode', 1, 1, 1, 1, 1, 0, 0, 0, N'f7bf96f0-c447-4c86-a116-e076f2a107f8', CAST(N'2015-12-14 23:09:00.843' AS DateTime), CAST(N'2015-12-08 20:59:08.243' AS DateTime))
INSERT [dbo].[merchProductVariant2ProductAttribute] ([productVariantKey], [optionKey], [productAttributeKey], [updateDate], [createDate]) VALUES (N'975a3dee-a6cd-4952-810d-1504a95a30f3', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'd75ae82f-9940-40fd-af05-7cf29547203c', CAST(N'2015-12-08 20:59:08.280' AS DateTime), CAST(N'2015-12-08 20:59:08.280' AS DateTime))
INSERT [dbo].[merchProductVariant2ProductAttribute] ([productVariantKey], [optionKey], [productAttributeKey], [updateDate], [createDate]) VALUES (N'7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'ba252d87-bac9-4666-90fa-c9e2fd369c4c', CAST(N'2015-12-08 20:59:08.197' AS DateTime), CAST(N'2015-12-08 20:59:08.197' AS DateTime))
INSERT [dbo].[merchProductVariant2ProductAttribute] ([productVariantKey], [optionKey], [productAttributeKey], [updateDate], [createDate]) VALUES (N'873edc9e-331b-43dc-83f8-97749fbcfa99', N'7b821c74-6a4d-4ec1-878b-0c618b1d9ada', N'6f9a2c9c-e912-4b3c-ad18-6384c420f47b', CAST(N'2015-12-08 20:59:08.243' AS DateTime), CAST(N'2015-12-08 20:59:08.243' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchProductVariantIndex] ON 

INSERT [dbo].[merchProductVariantIndex] ([id], [productVariantKey], [updateDate], [createDate]) VALUES (1, N'45feb315-d8d7-4b69-bf5c-10599ada21ff', CAST(N'2015-12-05 00:43:02.423' AS DateTime), CAST(N'2015-12-05 00:43:02.423' AS DateTime))
INSERT [dbo].[merchProductVariantIndex] ([id], [productVariantKey], [updateDate], [createDate]) VALUES (2, N'8a92a440-4dac-4d8e-b915-4634f8e559f2', CAST(N'2015-12-07 20:57:49.490' AS DateTime), CAST(N'2015-12-07 20:57:49.490' AS DateTime))
INSERT [dbo].[merchProductVariantIndex] ([id], [productVariantKey], [updateDate], [createDate]) VALUES (3, N'7a7b4c2d-c5e5-45a6-8841-5c4d235a29ed', CAST(N'2015-12-08 20:59:08.190' AS DateTime), CAST(N'2015-12-08 20:59:08.190' AS DateTime))
INSERT [dbo].[merchProductVariantIndex] ([id], [productVariantKey], [updateDate], [createDate]) VALUES (4, N'873edc9e-331b-43dc-83f8-97749fbcfa99', CAST(N'2015-12-08 20:59:08.243' AS DateTime), CAST(N'2015-12-08 20:59:08.243' AS DateTime))
INSERT [dbo].[merchProductVariantIndex] ([id], [productVariantKey], [updateDate], [createDate]) VALUES (5, N'975a3dee-a6cd-4952-810d-1504a95a30f3', CAST(N'2015-12-08 20:59:08.277' AS DateTime), CAST(N'2015-12-08 20:59:08.277' AS DateTime))
SET IDENTITY_INSERT [dbo].[merchProductVariantIndex] OFF
INSERT [dbo].[merchShipCountry] ([pk], [catalogKey], [countryCode], [name], [updateDate], [createDate]) VALUES (N'9517caa1-5099-4ca6-ba42-4ef4e767083e', N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'ELSE', N'Everywhere Else', CAST(N'2015-12-05 00:12:26.073' AS DateTime), CAST(N'2015-12-05 00:12:26.073' AS DateTime))
INSERT [dbo].[merchShipCountry] ([pk], [catalogKey], [countryCode], [name], [updateDate], [createDate]) VALUES (N'56794cb8-ed3a-418a-b181-bf5c77fb55de', N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'DK', N'Denmark', CAST(N'2015-12-13 21:27:22.330' AS DateTime), CAST(N'2015-12-13 21:27:22.330' AS DateTime))
INSERT [dbo].[merchShipCountry] ([pk], [catalogKey], [countryCode], [name], [updateDate], [createDate]) VALUES (N'9bef7c78-22e4-4d6b-aed8-f0f5970bd184', N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'VU', N'Vanuatu', CAST(N'2015-12-13 21:39:30.150' AS DateTime), CAST(N'2015-12-13 21:39:30.150' AS DateTime))
INSERT [dbo].[merchShipment] ([pk], [shipmentNumberPrefix], [shipmentNumber], [shipmentStatusKey], [shippedDate], [fromOrganization], [fromName], [fromAddress1], [fromAddress2], [fromLocality], [fromRegion], [fromPostalCode], [fromCountryCode], [fromIsCommercial], [toOrganization], [toName], [toAddress1], [toAddress2], [toLocality], [toRegion], [toPostalCode], [toCountryCode], [toIsCommercial], [phone], [email], [shipMethodKey], [versionKey], [carrier], [trackingCode], [updateDate], [createDate]) VALUES (N'68fcd61a-1f4d-4a6d-8e19-a21f20ef928a', NULL, 3, N'7342dcd6-8113-44b6-bfd0-4555b82f9503', CAST(N'2015-12-14 23:03:38.757' AS DateTime), NULL, N'Default Warehouse', N'Ryhavevej 1a st th', NULL, N'8210', NULL, N'8210', N'DK', 0, NULL, N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', 0, NULL, N'niclas@schu.dk', N'ff73e86b-a306-4614-ac94-cb77b9e49924', N'00000000-0000-0000-0000-000000000000', NULL, N'', CAST(N'2015-12-14 23:03:38.830' AS DateTime), CAST(N'2015-12-14 23:03:38.830' AS DateTime))
INSERT [dbo].[merchShipment] ([pk], [shipmentNumberPrefix], [shipmentNumber], [shipmentStatusKey], [shippedDate], [fromOrganization], [fromName], [fromAddress1], [fromAddress2], [fromLocality], [fromRegion], [fromPostalCode], [fromCountryCode], [fromIsCommercial], [toOrganization], [toName], [toAddress1], [toAddress2], [toLocality], [toRegion], [toPostalCode], [toCountryCode], [toIsCommercial], [phone], [email], [shipMethodKey], [versionKey], [carrier], [trackingCode], [updateDate], [createDate]) VALUES (N'bd966aa4-de80-407e-b204-da3e12639c69', NULL, 2, N'3a279633-4919-485d-8c3b-479848a053d9', CAST(N'2015-12-14 19:33:48.427' AS DateTime), NULL, N'Default Warehouse', N'Ryhavevej 1a st th', NULL, N'8210', NULL, N'8210', N'DK', 0, NULL, N'Niclas Schumacher', N'Ryhavevej 1a ', N'st th 1a', N'Aarhus V', NULL, N'8210', N'GB', 0, NULL, N'niclas@schu.dk', N'ff73e86b-a306-4614-ac94-cb77b9e49924', N'00000000-0000-0000-0000-000000000000', NULL, N'1324', CAST(N'2015-12-14 19:42:20.693' AS DateTime), CAST(N'2015-12-14 19:33:48.583' AS DateTime))
INSERT [dbo].[merchShipmentStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'6fa425a9-7802-4da0-bd33-083c100e30f3', N'Quoted', N'quoted', 1, 1, 1, CAST(N'2015-12-05 00:12:26.093' AS DateTime), CAST(N'2015-12-05 00:12:26.093' AS DateTime))
INSERT [dbo].[merchShipmentStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'7342dcd6-8113-44b6-bfd0-4555b82f9503', N'Packaging', N'packaging', 1, 1, 2, CAST(N'2015-12-05 00:12:26.097' AS DateTime), CAST(N'2015-12-05 00:12:26.097' AS DateTime))
INSERT [dbo].[merchShipmentStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'3a279633-4919-485d-8c3b-479848a053d9', N'Delivered', N'delivered', 1, 1, 5, CAST(N'2015-12-05 00:12:26.097' AS DateTime), CAST(N'2015-12-05 00:12:26.097' AS DateTime))
INSERT [dbo].[merchShipmentStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'b37be101-cec9-4608-9330-54e56fa0537a', N'Shipped', N'shipped', 1, 1, 4, CAST(N'2015-12-05 00:12:26.097' AS DateTime), CAST(N'2015-12-05 00:12:26.097' AS DateTime))
INSERT [dbo].[merchShipmentStatus] ([pk], [name], [alias], [reportable], [active], [sortOrder], [updateDate], [createDate]) VALUES (N'cb24d43f-2774-4e56-85d8-653e49e3f542', N'Ready', N'ready', 1, 1, 3, CAST(N'2015-12-05 00:12:26.097' AS DateTime), CAST(N'2015-12-05 00:12:26.097' AS DateTime))
INSERT [dbo].[merchShipMethod] ([pk], [name], [shipCountryKey], [providerKey], [surcharge], [serviceCode], [taxable], [provinceData], [updateDate], [createDate]) VALUES (N'512b5975-6e08-4e00-b62e-07e7992802a8', N'Post danmark', N'56794cb8-ed3a-418a-b181-bf5c77fb55de', N'aec7a923-9f64-41d0-b17b-0ef64725f576', CAST(0.000000 AS Decimal(38, 6)), N'VBW-fcc90bdb-ec3c-4be0-8436-ef21d1fd5de2', 0, N'[]', CAST(N'2015-12-13 22:18:11.897' AS DateTime), CAST(N'2015-12-13 22:18:11.897' AS DateTime))
INSERT [dbo].[merchShipMethod] ([pk], [name], [shipCountryKey], [providerKey], [surcharge], [serviceCode], [taxable], [provinceData], [updateDate], [createDate]) VALUES (N'aeee983b-7718-4502-bd3f-85cc55c8d137', N'New ship method', N'9bef7c78-22e4-4d6b-aed8-f0f5970bd184', N'aec7a923-9f64-41d0-b17b-0ef64725f576', CAST(0.000000 AS Decimal(38, 6)), N'VBW-eb0c7d69-4b77-47d7-97fd-72ab9ca6e369', 0, N'[]', CAST(N'2015-12-13 21:39:37.050' AS DateTime), CAST(N'2015-12-13 21:39:37.050' AS DateTime))
INSERT [dbo].[merchShipMethod] ([pk], [name], [shipCountryKey], [providerKey], [surcharge], [serviceCode], [taxable], [provinceData], [updateDate], [createDate]) VALUES (N'0f87274a-e68c-42b0-9ffd-8844544a65c6', N'Denmark Vary by Weight', N'56794cb8-ed3a-418a-b181-bf5c77fb55de', N'aec7a923-9f64-41d0-b17b-0ef64725f576', CAST(0.000000 AS Decimal(38, 6)), N'VBP-82cfc226-59ae-4de8-ad33-87045248eea1', 0, N'[]', CAST(N'2015-12-13 22:18:54.853' AS DateTime), CAST(N'2015-12-13 22:18:54.853' AS DateTime))
INSERT [dbo].[merchShipMethod] ([pk], [name], [shipCountryKey], [providerKey], [surcharge], [serviceCode], [taxable], [provinceData], [updateDate], [createDate]) VALUES (N'ff73e86b-a306-4614-ac94-cb77b9e49924', N'Other shipping provider', N'9517caa1-5099-4ca6-ba42-4ef4e767083e', N'aec7a923-9f64-41d0-b17b-0ef64725f576', CAST(0.000000 AS Decimal(38, 6)), N'VBW-eaf9a6d7-5803-42d9-af2a-0ad1cb9d649c', 0, N'[]', CAST(N'2015-12-13 22:18:28.377' AS DateTime), CAST(N'2015-12-13 22:18:28.377' AS DateTime))
INSERT [dbo].[merchShipRateTier] ([pk], [shipMethodKey], [rangeLow], [rangeHigh], [rate], [updateDate], [createDate]) VALUES (N'6cb21797-e2fb-4698-8f35-80f50c5e1b09', N'ff73e86b-a306-4614-ac94-cb77b9e49924', CAST(0.000000 AS Decimal(38, 6)), CAST(1000.000000 AS Decimal(38, 6)), CAST(20.000000 AS Decimal(38, 6)), CAST(N'2015-12-13 22:18:28.350' AS DateTime), CAST(N'2015-12-13 22:18:28.350' AS DateTime))
INSERT [dbo].[merchShipRateTier] ([pk], [shipMethodKey], [rangeLow], [rangeHigh], [rate], [updateDate], [createDate]) VALUES (N'c29fd000-ce90-431d-a5cf-96b53faaa664', N'0f87274a-e68c-42b0-9ffd-8844544a65c6', CAST(0.000000 AS Decimal(38, 6)), CAST(10000.000000 AS Decimal(38, 6)), CAST(30.000000 AS Decimal(38, 6)), CAST(N'2015-12-13 22:18:54.823' AS DateTime), CAST(N'2015-12-13 22:18:54.823' AS DateTime))
INSERT [dbo].[merchShipRateTier] ([pk], [shipMethodKey], [rangeLow], [rangeHigh], [rate], [updateDate], [createDate]) VALUES (N'c5fe855a-861b-4e9b-884e-dc5c28e48b4a', N'512b5975-6e08-4e00-b62e-07e7992802a8', CAST(0.000000 AS Decimal(38, 6)), CAST(10000.000000 AS Decimal(38, 6)), CAST(20.000000 AS Decimal(38, 6)), CAST(N'2015-12-13 22:18:11.853' AS DateTime), CAST(N'2015-12-13 22:18:11.853' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'e322f6c7-9ad6-4338-adaa-0c86353d8192', N'globalShippingIsTaxable', N'False', N'System.Boolean', CAST(N'2015-12-14 19:17:57.723' AS DateTime), CAST(N'2015-12-05 00:12:26.087' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'56044d81-5c1e-4073-a2cb-1be3412e461b', N'migration', N'', N'System.Guid', CAST(N'2015-12-14 19:17:57.727' AS DateTime), CAST(N'2015-12-05 00:12:26.087' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'292e477b-e39a-4b8b-9865-334eee850fd7', N'defaultExtendedContentCulture', N'en-US', N'System.String', CAST(N'2015-12-14 19:17:57.727' AS DateTime), CAST(N'2015-12-05 00:12:26.093' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'b9653d97-a87b-4f78-be2d-395665fbe361', N'globalTaxationApplication', N'Product', N'System.String', CAST(N'2015-12-14 19:17:57.727' AS DateTime), CAST(N'2015-12-05 00:12:26.087' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'10bf357e-2e91-4888-9ae5-5b9d7e897052', N'nextInvoiceNumber', N'7', N'System.Int32', CAST(N'2015-12-14 22:58:55.283' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'43116355-fc53-497f-965b-6227b57a38e6', N'globalShippable', N'True', N'System.Boolean', CAST(N'2015-12-14 19:17:57.730' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'ffc51fa0-2aff-4707-876d-79e6fd726022', N'nextOrderNumber', N'3', N'System.Int32', CAST(N'2015-12-14 23:03:13.313' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'03069b06-27cb-494b-b153-9c295af2de85', N'unitSystem', N'Metric', N'System.String', CAST(N'2015-12-14 19:17:57.733' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'487f1c4e-ddbc-4dcd-9882-a9f7c78892b5', N'nextShipmentNumber', N'3', N'System.Int32', CAST(N'2015-12-14 23:03:38.827' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'02f008d4-6003-4e4a-9f82-b0027d6a6208', N'globalTaxable', N'False', N'System.Boolean', CAST(N'2015-12-14 19:17:57.737' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'11d2cbe6-1057-423b-a7c4-b0ef6d07d9a0', N'globalTrackInventory', N'True', N'System.Boolean', CAST(N'2015-12-14 19:17:57.737' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'7e62b7ab-e633-4cc1-9c3b-c3c54bf10bf6', N'currencyCode', N'DKK', N'System.String', CAST(N'2015-12-14 19:17:57.737' AS DateTime), CAST(N'2015-12-05 00:12:26.080' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'4693279f-85dc-4eef-aadf-d47db0cde974', N'dateFormat', N'dd-MM-yyyy', N'System.String', CAST(N'2015-12-14 19:17:57.740' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchStoreSetting] ([pk], [name], [value], [typeName], [updateDate], [createDate]) VALUES (N'cbe0472f-3f72-439d-9c9d-fc8f840c1a9d', N'timeFormat', N'am-pm', N'System.String', CAST(N'2015-12-14 19:17:57.740' AS DateTime), CAST(N'2015-12-05 00:12:26.083' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'9fefeef2-7ece-439c-90e2-02d2f95d9e37', N'ItemCache', N'ItemCache', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'c5f53682-4c49-4538-87b3-035d30ee3347', N'Notification', N'Notification', CAST(N'2015-12-05 00:12:26.043' AS DateTime), CAST(N'2015-12-05 00:12:26.043' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'6f3119ea-53f8-41d0-9249-167b8d32ae81', N'Shipping', N'Shipping', CAST(N'2015-12-05 00:12:26.023' AS DateTime), CAST(N'2015-12-05 00:12:26.023' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'9f923716-a022-4089-a110-1e9b4e1f2ad1', N'Product', N'Product', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'6263d568-dee1-41bb-8100-2333ecb4cf08', N'Payment', N'Payment', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'2b588ae0-7b76-430f-9341-270a8c943e7e', N'Purchase Order', N'PurchaseOrder', CAST(N'2015-12-05 00:12:26.030' AS DateTime), CAST(N'2015-12-05 00:12:26.030' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'c53e3100-2dfd-408a-872e-4380383fad35', N'Standard Basket', N'Basket', CAST(N'2015-12-05 00:12:26.017' AS DateTime), CAST(N'2015-12-05 00:12:26.017' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'2ae1f2e2-df5f-4087-81c1-4e0ee809948f', N'Denied', N'Denied', CAST(N'2015-12-05 00:12:26.037' AS DateTime), CAST(N'2015-12-05 00:12:26.037' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'd32d7b40-2ff2-453f-9ac5-51cf1a981e46', N'Shipping', N'Shipping', CAST(N'2015-12-05 00:12:26.003' AS DateTime), CAST(N'2015-12-05 00:12:26.003' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'454539b9-d753-4c16-8ed5-5eb659e56665', N'Invoice', N'Invoice', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'1607d643-e5e8-4a93-9393-651f83b5f1a9', N'Customer', N'Customer', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'2367d705-4bea-4b3e-8329-664823d28316', N'Warehouse', N'Warehouse', CAST(N'2015-12-05 00:12:26.053' AS DateTime), CAST(N'2015-12-05 00:12:26.053' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'a0b4f835-d92e-4d17-8181-6c342c41606e', N'Payment', N'Payment', CAST(N'2015-12-05 00:12:26.043' AS DateTime), CAST(N'2015-12-05 00:12:26.043' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'cc5b1372-2efa-49d5-b9f7-6eacd1182c5b', N'Order', N'Order', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'e36930fe-6d6a-4eb3-af95-712629913812', N'Standard Backoffice', N'Backoffice', CAST(N'2015-12-05 00:12:26.017' AS DateTime), CAST(N'2015-12-05 00:12:26.017' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'646d3ea7-3b31-45c1-9488-7c0449a564a6', N'Shipping', N'Shipping', CAST(N'2015-12-05 00:12:26.043' AS DateTime), CAST(N'2015-12-05 00:12:26.043' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'f59c7da6-8252-4891-a5a2-7f6c38766649', N'Void', N'Void', CAST(N'2015-12-05 00:12:26.037' AS DateTime), CAST(N'2015-12-05 00:12:26.037' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'e7cc502d-de7c-4c37-8a9c-837760533a76', N'Discount', N'Discount', CAST(N'2015-12-05 00:12:26.023' AS DateTime), CAST(N'2015-12-05 00:12:26.023' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'b73c17bc-50d8-4b67-b343-9f0af7a6e62e', N'Tax', N'Tax', CAST(N'2015-12-05 00:12:26.023' AS DateTime), CAST(N'2015-12-05 00:12:26.023' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'360b47f9-a4fb-4b96-81b4-a4a497d2b44a', N'Taxation', N'Taxation', CAST(N'2015-12-05 00:12:26.043' AS DateTime), CAST(N'2015-12-05 00:12:26.043' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'25608a4e-f3db-43de-b137-a9e55b1412ce', N'Checkout', N'Checkout', CAST(N'2015-12-05 00:12:26.017' AS DateTime), CAST(N'2015-12-05 00:12:26.017' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'9c9a7e61-d79c-4ecc-b0e0-b2a502f252c5', N'Cash', N'Cash', CAST(N'2015-12-05 00:12:26.030' AS DateTime), CAST(N'2015-12-05 00:12:26.030' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'05bd6e6e-37a0-4954-aa34-bb73678543b2', N'GatewayProvider', N'GatewayProvider', CAST(N'2015-12-05 00:12:26.050' AS DateTime), CAST(N'2015-12-05 00:12:26.050' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'b3ebb9e0-c7ce-4ba6-b379-beda3465d6d5', N'Wishlist', N'Wishlist', CAST(N'2015-12-05 00:12:26.017' AS DateTime), CAST(N'2015-12-05 00:12:26.017' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'020f6ff8-1f66-4d90-9ff4-c32a7a5ab32b', N'Credit', N'Credit', CAST(N'2015-12-05 00:12:26.037' AS DateTime), CAST(N'2015-12-05 00:12:26.037' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'a3c60219-2687-4044-a85c-cc7d6ffca298', N'EntityCollection', N'EntityCollection', CAST(N'2015-12-05 00:12:26.053' AS DateTime), CAST(N'2015-12-05 00:12:26.053' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'cb1354fe-b30c-449e-bd5c-cd50bcbd804a', N'Credit Card', N'CreditCard', CAST(N'2015-12-05 00:12:26.030' AS DateTime), CAST(N'2015-12-05 00:12:26.030' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'4cfceb9c-f6f4-4fdc-9c52-cdc285f1b90a', N'Refund', N'Refund', CAST(N'2015-12-05 00:12:26.037' AS DateTime), CAST(N'2015-12-05 00:12:26.037' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'5f26df00-bd45-4e83-8095-d17ad8d7d3ce', N'Shipment', N'Shipment', CAST(N'2015-12-05 00:12:26.053' AS DateTime), CAST(N'2015-12-05 00:12:26.053' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'd462c051-07f4-45f5-aad2-d5c844159f04', N'Product', N'Product', CAST(N'2015-12-05 00:12:26.023' AS DateTime), CAST(N'2015-12-05 00:12:26.023' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'ed7d69b2-7434-40f4-88a7-edda9fb50995', N'WarehouseCatalog', N'WarehouseCatalog', CAST(N'2015-12-05 00:12:26.053' AS DateTime), CAST(N'2015-12-05 00:12:26.053' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'5c2a8638-ea32-49ad-8167-eddfb45a7360', N'Billing', N'Billing', CAST(N'2015-12-05 00:12:26.010' AS DateTime), CAST(N'2015-12-05 00:12:26.010' AS DateTime))
INSERT [dbo].[merchTypeField] ([pk], [name], [alias], [updateDate], [createDate]) VALUES (N'916929f0-96fb-430a-886d-f7a83e9a4b9a', N'Debit', N'Debit', CAST(N'2015-12-05 00:12:26.037' AS DateTime), CAST(N'2015-12-05 00:12:26.037' AS DateTime))
INSERT [dbo].[merchWarehouse] ([pk], [name], [address1], [address2], [locality], [region], [postalCode], [countryCode], [phone], [email], [isDefault], [updateDate], [createDate]) VALUES (N'268d4007-8853-455a-89f7-a28398843e5f', N'Default Warehouse', N'Ryhavevej 1a st th', NULL, N'8210', NULL, N'8210', N'DK', NULL, N'niclas@schu.dk', 1, CAST(N'2015-12-13 21:29:44.323' AS DateTime), CAST(N'2015-12-05 00:12:26.063' AS DateTime))
INSERT [dbo].[merchWarehouseCatalog] ([pk], [warehouseKey], [name], [description], [updateDate], [createDate]) VALUES (N'b25c2b00-578e-49b9-bea2-bf3712053c63', N'268d4007-8853-455a-89f7-a28398843e5f', N'Default Catalog', NULL, CAST(N'2015-12-05 00:12:26.067' AS DateTime), CAST(N'2015-12-05 00:12:26.067' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoLanguage] ON 

INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (1, N'en-US', N'en-US')
SET IDENTITY_INSERT [dbo].[umbracoLanguage] OFF
SET IDENTITY_INSERT [dbo].[umbracoLog] ON 

INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1, 0, -1, CAST(N'2015-12-05 00:12:18.480' AS DateTime), N'PackagerInstall', N'Package ''Merchello'' installed. Package guid: ')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (2, 0, -1, CAST(N'2015-12-05 00:12:25.580' AS DateTime), N'Save', N'Save ContentTypes performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (3, 0, 1046, CAST(N'2015-12-05 00:16:28.060' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (4, 0, 1046, CAST(N'2015-12-05 00:27:22.377' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (5, 0, 1047, CAST(N'2015-12-05 00:41:52.637' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (6, 0, 1048, CAST(N'2015-12-05 00:41:52.687' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (7, 0, 1048, CAST(N'2015-12-05 00:42:01.810' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (8, 0, 1049, CAST(N'2015-12-05 12:05:46.660' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (9, 0, 1049, CAST(N'2015-12-05 12:12:08.140' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (10, 0, 1050, CAST(N'2015-12-05 12:12:32.217' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (11, 0, 1051, CAST(N'2015-12-05 12:12:55.380' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (12, 0, 1052, CAST(N'2015-12-05 12:12:55.387' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (13, 0, 1052, CAST(N'2015-12-05 12:13:33.030' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (14, 0, 1052, CAST(N'2015-12-05 12:14:08.587' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (15, 0, 1052, CAST(N'2015-12-05 12:14:40.687' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (16, 0, 1053, CAST(N'2015-12-05 12:15:38.527' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (17, 0, 1054, CAST(N'2015-12-05 12:15:49.373' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (18, 0, 1051, CAST(N'2015-12-05 12:16:30.967' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (19, 0, 1054, CAST(N'2015-12-05 12:16:47.990' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (20, 0, 1055, CAST(N'2015-12-05 12:17:13.773' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (21, 0, -1, CAST(N'2015-12-05 12:17:32.517' AS DateTime), N'Delete', N'Delete Content of Type 1052 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (22, 0, 1052, CAST(N'2015-12-05 12:17:32.547' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (23, 0, 1055, CAST(N'2015-12-05 12:17:57.113' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (24, 0, -1, CAST(N'2015-12-05 12:18:16.047' AS DateTime), N'Delete', N'Delete Content of Type 1048 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (25, 0, 1048, CAST(N'2015-12-05 12:18:16.063' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (26, 0, 1056, CAST(N'2015-12-05 12:18:28.383' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (27, 0, 1056, CAST(N'2015-12-05 12:18:43.797' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (28, 0, 1056, CAST(N'2015-12-05 12:19:03.207' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (29, 0, 1056, CAST(N'2015-12-05 12:19:14.453' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (30, 0, 1057, CAST(N'2015-12-05 12:19:35.003' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (31, 0, 1056, CAST(N'2015-12-05 12:19:40.893' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (32, 0, 1053, CAST(N'2015-12-05 12:20:49.683' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (33, 0, 1053, CAST(N'2015-12-05 12:21:17.557' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (34, 0, 0, CAST(N'2015-12-05 12:21:40.580' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (35, 0, 1058, CAST(N'2015-12-05 12:22:05.357' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (36, 0, 1058, CAST(N'2015-12-05 12:22:12.733' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (37, 0, 1058, CAST(N'2015-12-05 12:22:15.683' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (38, 0, 1058, CAST(N'2015-12-05 12:45:17.503' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (39, 0, 1047, CAST(N'2015-12-05 19:09:15.960' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (40, 0, 1057, CAST(N'2015-12-05 19:09:25.017' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (41, 0, -1, CAST(N'2015-12-05 19:09:29.670' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (42, 0, 1056, CAST(N'2015-12-05 19:09:29.730' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (43, 0, 1056, CAST(N'2015-12-05 19:09:31.983' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (44, 0, 0, CAST(N'2015-12-05 19:10:39.940' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (45, 0, 1059, CAST(N'2015-12-05 19:10:52.057' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (46, 0, 1057, CAST(N'2015-12-06 13:56:55.460' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (47, 0, 1060, CAST(N'2015-12-06 14:00:46.580' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (48, 0, 1060, CAST(N'2015-12-06 14:01:28.980' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1046, 0, 0, CAST(N'2015-12-06 22:32:53.373' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1047, 0, 1050, CAST(N'2015-12-06 22:33:25.163' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1048, 0, 2060, CAST(N'2015-12-06 22:33:36.797' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1049, 0, 1056, CAST(N'2015-12-06 22:34:04.523' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1050, 0, 1056, CAST(N'2015-12-06 22:34:24.170' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1051, 0, 1056, CAST(N'2015-12-06 22:34:50.863' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1052, 0, 1056, CAST(N'2015-12-06 22:34:56.713' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1053, 0, 1056, CAST(N'2015-12-06 22:35:01.363' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1054, 0, 2060, CAST(N'2015-12-06 22:35:12.303' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1055, 0, 2061, CAST(N'2015-12-06 22:35:53.703' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1056, 0, 2061, CAST(N'2015-12-06 22:36:04.907' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1057, 0, 2061, CAST(N'2015-12-06 22:36:24.367' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1058, 0, 1050, CAST(N'2015-12-06 22:37:57.007' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1059, 0, 0, CAST(N'2015-12-06 22:39:51.100' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1060, 0, 2062, CAST(N'2015-12-06 22:41:35.690' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1061, 0, 2063, CAST(N'2015-12-06 22:41:35.727' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1062, 0, 2063, CAST(N'2015-12-06 22:43:24.567' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1063, 0, 1050, CAST(N'2015-12-07 20:24:39.230' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1064, 0, 1059, CAST(N'2015-12-07 20:25:00.667' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1065, 0, 1059, CAST(N'2015-12-07 20:25:00.717' AS DateTime), N'Delete', N'Trashed content with Id: ''1059'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1066, 0, 1059, CAST(N'2015-12-07 20:25:00.723' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1067, 0, 1058, CAST(N'2015-12-07 20:25:08.477' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1068, 0, 1058, CAST(N'2015-12-07 20:25:08.497' AS DateTime), N'Delete', N'Trashed content with Id: ''1058'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1069, 0, 1058, CAST(N'2015-12-07 20:25:08.500' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1070, 0, 1059, CAST(N'2015-12-07 20:32:13.167' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1071, 0, 1059, CAST(N'2015-12-07 20:32:13.177' AS DateTime), N'Move', N'Move Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1072, 0, 1059, CAST(N'2015-12-07 20:32:16.537' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1073, 0, 0, CAST(N'2015-12-07 20:32:20.293' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1074, 0, 0, CAST(N'2015-12-07 20:33:46.683' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1075, 0, -1, CAST(N'2015-12-07 20:34:53.690' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1076, 0, -1, CAST(N'2015-12-07 20:34:56.793' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1077, 0, -1, CAST(N'2015-12-07 20:34:58.017' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1078, 0, -1, CAST(N'2015-12-07 20:34:58.820' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1079, 0, -1, CAST(N'2015-12-07 20:34:59.057' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1080, 0, -1, CAST(N'2015-12-07 20:35:05.357' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1081, 0, -1, CAST(N'2015-12-07 20:35:05.663' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1082, 0, -1, CAST(N'2015-12-07 20:35:05.863' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1083, 1, 1059, CAST(N'2015-12-07 20:35:15.573' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1084, 1, 1059, CAST(N'2015-12-07 20:35:15.617' AS DateTime), N'Delete', N'Trashed content with Id: ''1059'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1085, 1, 1059, CAST(N'2015-12-07 20:35:15.617' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1086, 0, 1059, CAST(N'2015-12-07 20:35:22.443' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1087, 0, 1058, CAST(N'2015-12-07 20:35:22.467' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1088, 0, -1, CAST(N'2015-12-07 20:35:22.467' AS DateTime), N'Delete', N'Delete Content of Type 1056 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1089, 0, 1056, CAST(N'2015-12-07 20:35:22.520' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1090, 0, -1, CAST(N'2015-12-07 20:35:25.497' AS DateTime), N'Delete', N'Delete Content of Type 2060 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1091, 0, 2060, CAST(N'2015-12-07 20:35:25.540' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1092, 0, -1, CAST(N'2015-12-07 20:35:28.620' AS DateTime), N'Delete', N'Delete Content of Type 2061 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1093, 0, 2061, CAST(N'2015-12-07 20:35:28.640' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1094, 0, -1, CAST(N'2015-12-07 20:35:33.487' AS DateTime), N'Delete', N'Delete Content of Type 1050 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1095, 0, 1050, CAST(N'2015-12-07 20:35:33.503' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1096, 0, -1, CAST(N'2015-12-07 20:35:39.380' AS DateTime), N'Delete', N'Delete Content of Type 2063 performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1097, 0, 2063, CAST(N'2015-12-07 20:35:39.410' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1098, 0, 1046, CAST(N'2015-12-07 20:35:55.830' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1099, 0, 2062, CAST(N'2015-12-07 20:35:58.247' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1100, 0, 2064, CAST(N'2015-12-07 20:37:44.510' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1101, 0, 2064, CAST(N'2015-12-07 20:38:00.440' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1102, 0, 2064, CAST(N'2015-12-07 20:38:06.230' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1103, 0, -1, CAST(N'2015-12-07 20:40:06.397' AS DateTime), N'Delete', N'Delete Content of Type 2064 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1104, 0, 2064, CAST(N'2015-12-07 20:40:06.457' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1105, 0, 2065, CAST(N'2015-12-07 20:46:03.220' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1106, 0, 2065, CAST(N'2015-12-07 20:46:07.857' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1107, 0, -1, CAST(N'2015-12-07 20:53:28.943' AS DateTime), N'Delete', N'Delete Content of Type 2065 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1108, 0, 2065, CAST(N'2015-12-07 20:53:29.067' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1109, 0, 2066, CAST(N'2015-12-07 20:53:36.070' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1110, 0, 2066, CAST(N'2015-12-07 20:53:41.683' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1111, 0, -1, CAST(N'2015-12-07 20:54:01.780' AS DateTime), N'Save', N'Save ContentTypes performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1112, 0, 2068, CAST(N'2015-12-07 20:54:22.643' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1113, 0, 2068, CAST(N'2015-12-07 20:54:33.080' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1114, 0, 2069, CAST(N'2015-12-07 20:54:39.143' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1115, 0, 2070, CAST(N'2015-12-07 20:54:39.180' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1116, 0, -1, CAST(N'2015-12-07 20:55:04.260' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1117, 0, 2070, CAST(N'2015-12-07 20:55:04.290' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1118, 0, 0, CAST(N'2015-12-07 20:55:16.057' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1119, 0, 2071, CAST(N'2015-12-07 20:55:22.717' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1120, 0, 0, CAST(N'2015-12-07 20:55:28.560' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1121, 0, 2072, CAST(N'2015-12-07 20:55:34.700' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1122, 0, 0, CAST(N'2015-12-07 20:55:40.627' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1123, 0, 2073, CAST(N'2015-12-07 20:56:08.257' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1124, 0, 0, CAST(N'2015-12-07 20:56:18.710' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1125, 0, 0, CAST(N'2015-12-07 20:56:23.727' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1126, 0, 2074, CAST(N'2015-12-07 20:56:37.493' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1127, 0, 2074, CAST(N'2015-12-07 20:56:55.937' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1128, 0, 2074, CAST(N'2015-12-07 20:57:57.353' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1129, 0, 2075, CAST(N'2015-12-07 21:02:41.460' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1130, 0, 2075, CAST(N'2015-12-07 21:02:46.310' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1131, 0, 2073, CAST(N'2015-12-07 21:05:52.623' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1132, 0, 2067, CAST(N'2015-12-07 21:06:40.313' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1133, 0, 2067, CAST(N'2015-12-07 21:06:51.023' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1134, 0, 2073, CAST(N'2015-12-07 21:06:56.573' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1135, 0, 1057, CAST(N'2015-12-07 21:17:33.317' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1136, 0, 2076, CAST(N'2015-12-07 21:18:15.850' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1137, 0, 2076, CAST(N'2015-12-07 21:18:18.487' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1138, 0, 2073, CAST(N'2015-12-07 21:18:36.547' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1139, 0, 2073, CAST(N'2015-12-07 21:18:37.267' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1140, 0, 2073, CAST(N'2015-12-07 21:20:30.960' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1141, 0, 2067, CAST(N'2015-12-07 21:20:41.223' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1142, 0, 2073, CAST(N'2015-12-07 21:20:48.137' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1143, 0, 2067, CAST(N'2015-12-07 21:22:19.867' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1144, 0, 2067, CAST(N'2015-12-07 21:27:48.513' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1145, 0, 2067, CAST(N'2015-12-07 21:27:54.107' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1146, 0, 2073, CAST(N'2015-12-07 21:28:00.193' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1147, 0, 2076, CAST(N'2015-12-07 21:28:23.377' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1148, 0, 2070, CAST(N'2015-12-07 21:49:13.500' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1149, 0, 0, CAST(N'2015-12-07 21:49:16.943' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1150, 0, 2077, CAST(N'2015-12-07 21:49:23.247' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1151, 0, 2078, CAST(N'2015-12-11 18:02:55.947' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1152, 0, 2079, CAST(N'2015-12-11 18:02:56.110' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1153, 0, 2080, CAST(N'2015-12-11 18:11:17.210' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1154, 0, 2081, CAST(N'2015-12-11 18:11:56.413' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1155, 0, 2082, CAST(N'2015-12-11 18:12:05.773' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1156, 0, 2083, CAST(N'2015-12-11 18:12:05.817' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1157, 0, 2084, CAST(N'2015-12-11 18:12:18.027' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1158, 0, 2085, CAST(N'2015-12-11 18:12:18.067' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1159, 0, 2086, CAST(N'2015-12-11 18:12:30.127' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1160, 0, -1, CAST(N'2015-12-11 18:12:40.213' AS DateTime), N'Delete', N'Delete Content of Type 2086 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1161, 0, 2086, CAST(N'2015-12-11 18:12:40.340' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1162, 0, 2087, CAST(N'2015-12-11 18:12:49.207' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1163, 0, 2085, CAST(N'2015-12-11 18:12:57.617' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1164, 0, 2083, CAST(N'2015-12-11 18:13:00.760' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1165, 0, 2088, CAST(N'2015-12-11 18:14:04.687' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1166, 0, 2079, CAST(N'2015-12-11 18:14:13.063' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1167, 0, 2079, CAST(N'2015-12-11 18:14:32.057' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1168, 0, 2080, CAST(N'2015-12-11 18:14:56.943' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1169, 0, 2069, CAST(N'2015-12-11 18:28:13.537' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1170, 0, 2089, CAST(N'2015-12-11 18:28:19.017' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1171, 0, 2070, CAST(N'2015-12-11 19:04:57.437' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1172, 0, 0, CAST(N'2015-12-11 19:05:06.960' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1173, 0, 2090, CAST(N'2015-12-11 19:05:14.127' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1174, 0, 2090, CAST(N'2015-12-11 19:05:22.460' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1175, 0, 2091, CAST(N'2015-12-11 19:08:33.407' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1176, 0, 2080, CAST(N'2015-12-11 19:08:38.717' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1177, 0, 2080, CAST(N'2015-12-11 19:10:51.163' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1178, 0, 2090, CAST(N'2015-12-11 19:13:14.540' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1179, 0, 2090, CAST(N'2015-12-11 19:13:35.813' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1180, 0, 2090, CAST(N'2015-12-11 19:13:35.960' AS DateTime), N'Delete', N'Trashed content with Id: ''2090'' related to original parent content with Id: ''2071''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1181, 0, 2090, CAST(N'2015-12-11 19:13:35.963' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1182, 0, 0, CAST(N'2015-12-11 19:13:58.147' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1183, 0, 2080, CAST(N'2015-12-11 19:14:21.837' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1184, 0, 0, CAST(N'2015-12-11 19:14:32.877' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1185, 0, 2092, CAST(N'2015-12-11 19:15:05.813' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1186, 0, 2093, CAST(N'2015-12-11 19:50:24.553' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1187, 0, 2094, CAST(N'2015-12-11 19:50:24.720' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1188, 0, 2092, CAST(N'2015-12-11 19:50:30.053' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1189, 0, 2094, CAST(N'2015-12-11 19:50:30.937' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1190, 0, 2070, CAST(N'2015-12-11 19:51:03.350' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1191, 0, 2070, CAST(N'2015-12-11 19:51:22.030' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1192, 0, 2094, CAST(N'2015-12-11 19:51:26.427' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1193, 0, 0, CAST(N'2015-12-11 19:51:29.463' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1194, 0, 2095, CAST(N'2015-12-11 19:51:36.703' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1195, 0, 2095, CAST(N'2015-12-11 19:51:46.860' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1196, 0, -1, CAST(N'2015-12-11 19:52:29.953' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1197, 0, 2094, CAST(N'2015-12-11 19:52:30.003' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1198, 0, 2094, CAST(N'2015-12-11 19:52:34.633' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1199, 0, 2096, CAST(N'2015-12-11 21:40:07.887' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1200, 0, 2096, CAST(N'2015-12-11 21:40:17.810' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1201, 0, 2096, CAST(N'2015-12-11 21:40:18.607' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1202, 0, -1, CAST(N'2015-12-11 21:40:34.573' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1203, 0, 2075, CAST(N'2015-12-11 21:40:34.663' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1204, 0, 2093, CAST(N'2015-12-11 21:40:45.707' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1205, 0, 2093, CAST(N'2015-12-11 21:40:48.360' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1206, 0, 2077, CAST(N'2015-12-11 21:42:15.777' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1207, 0, 2075, CAST(N'2015-12-11 21:42:27.367' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1208, 0, 2077, CAST(N'2015-12-11 21:42:34.777' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1209, 0, 2070, CAST(N'2015-12-11 21:48:34.500' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1210, 0, 2071, CAST(N'2015-12-11 21:48:40.127' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1211, 0, 2077, CAST(N'2015-12-11 21:58:50.617' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1212, 0, 2071, CAST(N'2015-12-11 22:00:53.267' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1213, 0, 2071, CAST(N'2015-12-11 22:00:55.937' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1214, 0, 2071, CAST(N'2015-12-11 22:03:06.270' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1215, 0, 2071, CAST(N'2015-12-11 22:03:12.173' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1216, 0, 0, CAST(N'2015-12-11 22:03:20.867' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1217, 0, 2070, CAST(N'2015-12-11 22:03:52.163' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1218, 0, 2077, CAST(N'2015-12-11 22:08:32.823' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1219, 0, 2077, CAST(N'2015-12-11 22:09:03.540' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1220, 0, 2097, CAST(N'2015-12-11 22:09:27.387' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1221, 0, 2098, CAST(N'2015-12-11 22:10:15.440' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1222, 0, 2099, CAST(N'2015-12-11 22:10:15.503' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1223, 0, 2099, CAST(N'2015-12-11 22:10:28.593' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1224, 0, 0, CAST(N'2015-12-11 22:10:32.210' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1225, 0, 2100, CAST(N'2015-12-11 22:10:38.987' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1226, 0, 0, CAST(N'2015-12-11 22:10:48.583' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1227, 0, 2101, CAST(N'2015-12-11 22:10:54.013' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1228, 0, 0, CAST(N'2015-12-11 22:11:27.887' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1229, 0, 2102, CAST(N'2015-12-11 22:11:35.390' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1230, 0, 2102, CAST(N'2015-12-11 22:11:41.453' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1231, 0, 2071, CAST(N'2015-12-11 22:11:49.393' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1232, 0, 0, CAST(N'2015-12-11 22:12:18.667' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1233, 0, 2102, CAST(N'2015-12-11 22:12:22.033' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1234, 0, 2077, CAST(N'2015-12-12 00:23:08.860' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1235, 0, 0, CAST(N'2015-12-12 00:23:21.103' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1236, 0, 0, CAST(N'2015-12-12 00:32:50.557' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1237, 0, 2082, CAST(N'2015-12-12 00:33:35.653' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1238, 0, 2088, CAST(N'2015-12-12 00:33:38.617' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1239, 0, 2078, CAST(N'2015-12-12 00:33:41.630' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1240, 0, 2084, CAST(N'2015-12-12 00:33:44.200' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1241, 0, 2097, CAST(N'2015-12-12 00:34:16.090' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1242, 0, 2098, CAST(N'2015-12-12 00:34:18.883' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1243, 0, 2103, CAST(N'2015-12-12 00:34:26.597' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1244, 0, 0, CAST(N'2015-12-12 00:37:47.850' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1245, 0, 2104, CAST(N'2015-12-12 00:38:04.497' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1246, 0, 0, CAST(N'2015-12-12 00:38:10.300' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1247, 0, 2105, CAST(N'2015-12-12 00:38:21.840' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1248, 0, 0, CAST(N'2015-12-12 00:38:26.873' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1249, 0, 2106, CAST(N'2015-12-12 00:38:33.677' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1250, 0, 0, CAST(N'2015-12-12 00:38:38.820' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1251, 0, 2068, CAST(N'2015-12-12 00:39:01.270' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1252, 0, 0, CAST(N'2015-12-12 00:39:09.827' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1253, 0, 2107, CAST(N'2015-12-12 00:39:15.143' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1254, 0, 2108, CAST(N'2015-12-12 00:39:37.623' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1255, 0, 2067, CAST(N'2015-12-12 00:39:51.857' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1256, 0, 0, CAST(N'2015-12-12 00:39:58.767' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1257, 0, 2109, CAST(N'2015-12-12 00:40:09.343' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1258, 0, 2109, CAST(N'2015-12-12 00:40:21.613' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1259, 0, 0, CAST(N'2015-12-12 00:40:25.460' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1260, 0, 2110, CAST(N'2015-12-12 00:40:37.887' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1261, 0, 2077, CAST(N'2015-12-13 11:43:24.387' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1262, 0, 2095, CAST(N'2015-12-13 11:43:24.423' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1263, 0, 2092, CAST(N'2015-12-13 11:43:24.457' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1264, 0, 2072, CAST(N'2015-12-13 11:43:24.487' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1265, 0, 2073, CAST(N'2015-12-13 11:43:24.523' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1266, 0, 2074, CAST(N'2015-12-13 11:43:24.593' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1267, 0, 2071, CAST(N'2015-12-13 11:43:24.650' AS DateTime), N'Delete', N'Trashed content with Id: ''2071'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1268, 0, 2077, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'Delete', N'Trashed content with Id: ''2077'' related to original parent content with Id: ''2071''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1269, 0, 2095, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'Delete', N'Trashed content with Id: ''2095'' related to original parent content with Id: ''2071''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1270, 0, 2092, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'Delete', N'Trashed content with Id: ''2092'' related to original parent content with Id: ''2071''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1271, 0, 2072, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'Delete', N'Trashed content with Id: ''2072'' related to original parent content with Id: ''2071''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1272, 0, 2073, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'Delete', N'Trashed content with Id: ''2073'' related to original parent content with Id: ''2072''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1273, 0, 2074, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'Delete', N'Trashed content with Id: ''2074'' related to original parent content with Id: ''2072''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1274, 0, 2071, CAST(N'2015-12-13 11:43:24.680' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1275, 0, 2111, CAST(N'2015-12-13 22:26:57.223' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1276, 0, 2112, CAST(N'2015-12-13 22:26:57.357' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1277, 0, 2112, CAST(N'2015-12-13 22:27:15.663' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1278, 0, 2066, CAST(N'2015-12-13 22:27:41.627' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1279, 0, 2066, CAST(N'2015-12-13 22:27:52.373' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1280, 0, 2070, CAST(N'2015-12-13 22:29:04.177' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1281, 0, 2070, CAST(N'2015-12-13 22:29:43.693' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1282, 0, 0, CAST(N'2015-12-13 22:30:01.463' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1283, 0, 2113, CAST(N'2015-12-13 22:30:11.493' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1284, 0, 2114, CAST(N'2015-12-14 19:31:37.283' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1285, 0, 2115, CAST(N'2015-12-14 19:31:37.420' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1286, 0, 2115, CAST(N'2015-12-14 19:31:50.027' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1287, 0, 2070, CAST(N'2015-12-14 19:32:06.320' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1288, 0, 0, CAST(N'2015-12-14 19:32:15.823' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1289, 0, 2116, CAST(N'2015-12-14 19:32:22.037' AS DateTime), N'Publish', N'Save and Publish performed by user')
SET IDENTITY_INSERT [dbo].[umbracoLog] OFF
SET IDENTITY_INSERT [dbo].[umbracoMigration] ON 

INSERT [dbo].[umbracoMigration] ([id], [name], [createDate], [version]) VALUES (1, N'Umbraco', CAST(N'2015-12-04 23:57:46.663' AS DateTime), N'7.3.3')
SET IDENTITY_INSERT [dbo].[umbracoMigration] OFF
SET IDENTITY_INSERT [dbo].[umbracoNode] ON 

INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-97, 0, -1, 0, 1, N'-1,-97', 2, N'aa2c52a0-ce87-4e65-a47c-7df09358585d', N'List View - Members', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-96, 0, -1, 0, 1, N'-1,-96', 2, N'3a0156c4-3b8c-4803-bdc1-6871faa83fff', N'List View - Media', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-95, 0, -1, 0, 1, N'-1,-95', 2, N'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4', N'List View - Content', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-92, 0, -1, 0, 1, N'-1,-92', 35, N'f0bc4bfb-b499-40d6-ba86-058885a5178c', N'Label', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-90, 0, -1, 0, 1, N'-1,-90', 34, N'84c6b441-31df-4ffe-b67e-67d5bc3ae65a', N'Upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-89, 0, -1, 0, 1, N'-1,-89', 33, N'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3', N'Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-88, 0, -1, 0, 1, N'-1,-88', 32, N'0cc0eba1-9960-42c9-bf9b-60e150b429ae', N'Textstring', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-87, 0, -1, 0, 1, N'-1,-87', 4, N'ca90c950-0aff-4e72-b976-a30b1ac57dad', N'Richtext editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-51, 0, -1, 0, 1, N'-1,-51', 2, N'2e6d3631-066e-44b8-aec4-96f09099b2b5', N'Numeric', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-49, 0, -1, 0, 1, N'-1,-49', 2, N'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49', N'True/false', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-43, 0, -1, 0, 1, N'-1,-43', 2, N'fbaf13a8-4036-41f2-93a3-974f678c312a', N'Checkbox list', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-42, 0, -1, 0, 1, N'-1,-42', 2, N'0b6a45e7-44ba-430d-9da5-4e46060b9e03', N'Dropdown', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-41, 0, -1, 0, 1, N'-1,-41', 2, N'5046194e-4237-453c-a547-15db3a07c4e1', N'Date Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-40, 0, -1, 0, 1, N'-1,-40', 2, N'bb5f57c9-ce2b-4bb9-b697-4caca783a805', N'Radiobox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-39, 0, -1, 0, 1, N'-1,-39', 2, N'f38f0ac7-1d27-439c-9f3f-089cd8825a53', N'Dropdown multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-38, 0, -1, 0, 1, N'-1,-38', 2, N'fd9f1447-6c61-4a7c-9595-5aa39147d318', N'Folder Browser', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-37, 0, -1, 0, 1, N'-1,-37', 2, N'0225af17-b302-49cb-9176-b9f35cab9c17', N'Approved Color', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-36, 0, -1, 0, 1, N'-1,-36', 2, N'e4d66c0f-b935-4200-81f0-025f7256b89a', N'Date Picker with time', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-21, 0, -1, 0, 0, N'-1,-21', 0, N'bf7c7cbc-952f-4518-97a2-69e9c7b33842', N'Recycle Bin', N'cf3d8e34-1c1c-41e9-ae56-878b57b32113', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-20, 0, -1, 0, 0, N'-1,-20', 0, N'0f582a79-1e41-4cf0-bfa0-76340651891a', N'Recycle Bin', N'01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-1, 0, -1, 0, 0, N'-1', 0, N'916724a5-173d-4619-b97e-b9de133dd6f5', N'SYSTEM DATA: umbraco master root', N'ea7d8624-4cfe-4578-a871-24aa946bf34d', CAST(N'2015-12-04 23:57:46.303' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1031, 0, -1, 0, 1, N'-1,1031', 2, N'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d', N'Folder', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1032, 0, -1, 0, 1, N'-1,1032', 2, N'cc07b313-0843-4aa8-bbda-871c8da728c8', N'Image', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1033, 0, -1, 0, 1, N'-1,1033', 2, N'4c52d8ab-54e6-40cd-999c-7a5f24903e4d', N'File', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1034, 0, -1, 0, 1, N'-1,1034', 2, N'a6857c73-d6e9-480c-b6e6-f15f6ad11125', N'Content Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.310' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1035, 0, -1, 0, 1, N'-1,1035', 2, N'93929b9a-93a2-4e2a-b239-d99334440a59', N'Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1036, 0, -1, 0, 1, N'-1,1036', 2, N'2b24165f-9782-4aa3-b459-1de4a4d21f60', N'Member Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1040, 0, -1, 0, 1, N'-1,1040', 2, N'21e798da-e06e-4eda-a511-ed257f78d4fa', N'Related Links', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1041, 0, -1, 0, 1, N'-1,1041', 2, N'b6b73142-b9c1-4bf8-a16d-e1c23320b549', N'Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1043, 0, -1, 0, 1, N'-1,1043', 2, N'1df9f033-e6d4-451f-b8d2-e0cbc50a836f', N'Image Cropper', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1044, 0, -1, 0, 1, N'-1,1044', 0, N'd59be02f-1df9-4228-aa1e-01917d806cda', N'Member', N'9b5416fb-e72f-45a9-a07b-5a9a2709ce43', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1045, 0, -1, 0, 1, N'-1,1045', 2, N'7e3962cc-ce20-4ffc-b661-5897a894ba7e', N'Multiple Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-04 23:57:46.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1049, 0, -1, 0, 1, N'-1,1049', 25, N'3eb14d5f-dfe9-4102-85ec-274e8f5b9e0b', N'Merchello Product Selector', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2015-12-05 12:05:46.610' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1053, 0, -1, NULL, 1, N'-1,1053', 0, N'9aa6d9f9-2d97-41c5-88a6-8a8094007339', N'Layout', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-05 12:15:38.523' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2066, 0, -1, 0, 1, N'-1,2066', 0, N'b23bdc8f-d424-489d-8807-fa711d999d31', N'Master', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-07 20:53:36.033' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2067, 0, 2066, 0, 2, N'-1,2066,2067', 0, N'6dc5cb73-1c54-4b40-bae6-ce0e494b4271', N'Product', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-07 20:54:01.740' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2068, 0, 2066, 0, 2, N'-1,2066,2068', 1, N'eec1fa5b-3ba7-4c48-99b4-8be9fa85b4b4', N'Products', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-07 20:54:22.637' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2070, 0, 2066, 0, 2, N'-1,2066,2070', 2, N'7b0d8a5c-994b-406c-b277-73b4540ea83c', N'Home', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-07 20:54:39.153' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2071, 1, -20, 0, 1, N'-1,-20,2071', 2, N'26f487c5-eeae-4af2-99a0-79367c3521f3', N'Home1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-07 20:55:22.280' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2072, 1, 2071, 0, 2, N'-1,-20,2071,2072', 7, N'0b7d9bd0-49fb-425e-84c9-896ee51c0943', N'Products', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-07 20:55:34.360' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2073, 1, 2072, 0, 3, N'-1,-20,2071,2072,2073', 2, N'cf498bae-3e4b-4df9-9e3d-7c2b59d7d9d5', N'Product Number 1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-07 20:56:07.797' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2074, 1, 2072, 0, 3, N'-1,-20,2071,2072,2074', 3, N'037fff7d-c6d1-47bd-bd12-92e240481af4', N'Product number 2', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-07 20:56:37.113' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2075, 0, 2066, 0, 2, N'-1,2066,2075', 3, N'929e6f91-aed9-402a-97f8-1d97bfa1a98c', N'Basket Page', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-07 21:02:41.443' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2077, 1, 2071, 0, 2, N'-1,-20,2071,2077', 4, N'1a3ba8c8-81da-43e6-804c-c142d2fe2d0c', N'Basket', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-07 21:49:23.157' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2079, 0, -1, 0, 1, N'-1,2079', 1, N'19bca4f8-93c6-4649-b4ec-75309f1c018b', N'Checkout Folder', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:02:55.983' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2080, 0, 2066, 0, 2, N'-1,2066,2080', 4, N'09c74573-ea6d-4f41-af91-5f35b152c1dc', N'Checkout Page', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:11:17.190' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2081, 0, 2079, 0, 2, N'-1,2079,2081', 0, N'82ea574c-f226-4f6e-aced-547319aae301', N'Checkout Begin', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:11:56.373' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2083, 0, 2079, 0, 2, N'-1,2079,2083', 1, N'8f38fecd-0662-410b-82d4-5ed856db4dcc', N'checkout Address', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:12:05.793' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2085, 0, 2079, 0, 2, N'-1,2079,2085', 2, N'9dfb54f2-c9a5-4c5e-9037-041102a82601', N'Checkout Invoice', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:12:18.040' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2087, 0, 2079, 0, 2, N'-1,2079,2087', 3, N'487f10f4-aebe-4a4b-96be-dc2efc38e5c8', N'Checkout Payment', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 18:12:49.183' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2089, 0, -1, NULL, 1, N'-1,2089', 0, N'b17285d7-5a6c-432c-a2d1-13f869dd3773', N'Home', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-11 18:28:18.980' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2090, 1, -20, 0, 1, N'-1,-20,2090', 1, N'8c7a86e0-d2c7-4126-a82a-548f128e6ff8', N'Checkout Page', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 19:05:14.007' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2091, 0, -1, NULL, 1, N'-1,2091', 0, N'66892653-2915-4a3d-aeda-d0801ab01d84', N'Checkout Page', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-11 19:08:33.337' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2092, 1, 2071, 0, 2, N'-1,-20,2071,2092', 6, N'bb8f3421-f0ec-4895-8e23-c06e3b58302d', N'Checkout Page', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 19:15:05.640' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2093, 0, -1, NULL, 1, N'-1,2093', 0, N'53663bbb-6e92-4728-9a86-f3e675748686', N'Delivery Page', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-11 19:50:24.483' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2094, 0, 2066, 0, 2, N'-1,2066,2094', 5, N'38a33b14-548e-421d-8e3c-8f926f784755', N'Delivery Page', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 19:50:24.637' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2095, 1, 2071, 0, 2, N'-1,-20,2071,2095', 5, N'5929bed7-77dc-4d7a-b8eb-9520a0413200', N'Delivery Page', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 19:51:36.650' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2096, 0, -1, NULL, 1, N'-1,2096', 0, N'3b9af0b2-4bf0-4ef1-9cd9-23f63a3ff161', N'Basket Page', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-11 21:40:07.803' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2099, 0, -1, 0, 1, N'-1,2099', 2, N'79006128-43aa-4114-b15e-e06846af2999', N'test', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-11 22:10:15.460' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2100, 0, -1, 0, 1, N'-1,2100', 2, N'03217e73-a724-4087-9e8f-05051599cc03', N'rwar', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 22:10:38.860' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2101, 0, -1, 0, 1, N'-1,2101', 3, N'7a066a82-99a8-4d0b-82ea-dfc50958fa98', N'rwar (1)', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 22:10:53.967' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2102, 0, -1, 0, 1, N'-1,2102', 0, N'c864c635-8368-4a3f-a10b-faa6a8c6cb9f', N'Home', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-11 22:11:35.287' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2103, 0, -1, NULL, 1, N'-1,2103', 0, N'993c3802-7188-4392-bb17-8a1b041aa21e', N'Products', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-12 00:34:26.573' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2104, 0, 2102, 0, 2, N'-1,2102,2104', 0, N'93760cf1-3c10-443c-81bc-66d5ca0cf932', N'Basket', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:38:04.290' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2105, 0, 2102, 0, 2, N'-1,2102,2105', 1, N'7db74495-324b-43f3-9867-e441507cd604', N'Checkout', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:38:21.773' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2106, 0, 2102, 0, 2, N'-1,2102,2106', 2, N'87353e62-5fe5-4136-a7e0-6e5455066492', N'Delivery', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:38:33.633' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2107, 0, 2102, 0, 2, N'-1,2102,2107', 3, N'7693ad15-5a6b-4485-ab5b-11d67fc402f2', N'Products', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:39:15.043' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2108, 0, -1, NULL, 1, N'-1,2108', 0, N'65611ce3-bf95-47b2-b291-5b77a7c72862', N'Product', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-12 00:39:37.597' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2109, 0, 2107, 0, 3, N'-1,2102,2107,2109', 0, N'4dcef1ed-3c0c-4301-94c9-14154dd627c7', N'Product1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:40:09.303' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2110, 0, 2107, 0, 3, N'-1,2102,2107,2110', 1, N'69659091-157d-45d6-aaac-a93bd6165405', N'product2', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-12 00:40:37.807' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2111, 0, -1, NULL, 1, N'-1,2111', 0, N'5bbf98c9-66a8-46ea-aa20-b6e9f28a50ec', N'Payment Page', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-13 22:26:57.123' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2112, 0, 2066, 0, 2, N'-1,2066,2112', 6, N'47250010-27a0-4eae-a4e9-c1beb0ada339', N'Payment Page', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-13 22:26:57.247' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2113, 0, 2102, 0, 2, N'-1,2102,2113', 4, N'a85143d8-d0d8-4907-a767-615ed822a3de', N'Payment', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-13 22:30:11.197' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2114, 0, -1, NULL, 1, N'-1,2114', 0, N'78b40b6b-e68a-4858-9021-4cfe0bc607f1', N'Receipt Page', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2015-12-14 19:31:37.227' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2115, 0, 2066, 0, 2, N'-1,2066,2115', 7, N'43784081-a70e-4751-ae27-eb6bf264cc54', N'Receipt Page', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2015-12-14 19:31:37.320' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (2116, 0, 2102, 0, 2, N'-1,2102,2116', 5, N'099b0af9-7a25-42e2-b4eb-20bc97fb13e8', N'Receipt', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2015-12-14 19:32:21.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoNode] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelation] ON 

INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (4, 2071, 2090, 2, CAST(N'2015-12-11 19:13:35.947' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (5, -1, 2071, 2, CAST(N'2015-12-13 11:43:24.643' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (6, 2071, 2077, 2, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (7, 2071, 2095, 2, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (8, 2071, 2092, 2, CAST(N'2015-12-13 11:43:24.653' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (9, 2071, 2072, 2, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (10, 2072, 2073, 2, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (11, 2072, 2074, 2, CAST(N'2015-12-13 11:43:24.657' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[umbracoRelation] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelationType] ON 

INSERT [dbo].[umbracoRelationType] ([id], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (1, 1, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Document On Copy', N'relateDocumentOnCopy')
INSERT [dbo].[umbracoRelationType] ([id], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (2, 0, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Parent Document On Delete', N'relateParentDocumentOnDelete')
SET IDENTITY_INSERT [dbo].[umbracoRelationType] OFF
SET IDENTITY_INSERT [dbo].[umbracoServer] ON 

INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (1, N'http://localhost:64232/umbraco', N'NICLAS-PC//LM/W3SVC/11/ROOT', CAST(N'2015-12-04 23:57:54.853' AS DateTime), CAST(N'2015-12-06 18:58:55.670' AS DateTime), 0, 0)
INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (2, N'http://laceshop.localhost:80/umbraco', N'NICLAS-PC//LM/W3SVC/2/ROOT', CAST(N'2015-12-06 19:58:26.307' AS DateTime), CAST(N'2015-12-19 13:45:57.703' AS DateTime), 1, 1)
INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (3, N'http://localhost:12413/umbraco', N'NICLAS-PC//LM/W3SVC/14/ROOT', CAST(N'2015-12-07 20:45:20.317' AS DateTime), CAST(N'2015-12-13 01:49:04.043' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[umbracoServer] OFF
SET IDENTITY_INSERT [dbo].[umbracoUser] ON 

INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (0, 0, 0, 1, -1, -1, N'Niclas Schumacher', N'niclas@schu.dk', N'I/P9+10Xi/ZtsP2GIdQjoMKHB64=', N'niclas@schu.dk', N'en-GB', N'8afdde9d-162c-468a-99e8-ae833b5fef27', 0, NULL, CAST(N'2015-12-04 23:57:46.940' AS DateTime), CAST(N'2015-12-14 19:16:54.700' AS DateTime))
INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (1, 0, 0, 1, -1, -1, N'Ngschumacher', N'Ngschumacher', N'10LZylzYPUKN2cYDdUiYhPerbDE=', N'ns@impact.dk', N'da', N'cee22117-5988-4c34-b854-24aaa721328a', 0, NULL, CAST(N'2015-12-07 20:34:08.657' AS DateTime), CAST(N'2015-12-07 20:34:24.930' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoUser] OFF
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'developer')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'forms')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'member')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'merchello')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'settings')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'translation')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'users')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'developer')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'forms')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'member')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'merchello')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'settings')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'translation')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'users')
SET IDENTITY_INSERT [dbo].[umbracoUserType] ON 

INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (1, N'admin', N'Administrators', N'CADMOSKTPIURZ:5F7')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (2, N'writer', N'Writer', N'CAH:F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (3, N'editor', N'Editors', N'CADMOSKTPUZ:5F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (4, N'translator', N'Translator', N'AF')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (6, N'Customer', N'Customer', N'')
SET IDENTITY_INSERT [dbo].[umbracoUserType] OFF
/****** Object:  Index [IX_cmsContent]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContent] ON [dbo].[cmsContent]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentType]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentType] ON [dbo].[cmsContentType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsContentType_icon]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentType_icon] ON [dbo].[cmsContentType]
(
	[icon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_ContentId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentVersion_ContentId] ON [dbo].[cmsContentVersion]
(
	[ContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_VersionId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentVersion_VersionId] ON [dbo].[cmsContentVersion]
(
	[VersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDataType_nodeId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDataType_nodeId] ON [dbo].[cmsDataType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDictionary_id]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDictionary_id] ON [dbo].[cmsDictionary]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDocument] ON [dbo].[cmsDocument]
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_newest]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_newest] ON [dbo].[cmsDocument]
(
	[newest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_published]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_published] ON [dbo].[cmsDocument]
(
	[published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroPropertyAlias]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroPropertyAlias] ON [dbo].[cmsMacro]
(
	[macroAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroProperty_Alias]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_Alias] ON [dbo].[cmsMacroProperty]
(
	[macro] ASC,
	[macroPropertyAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData] ON [dbo].[cmsPropertyData]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_1]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_1] ON [dbo].[cmsPropertyData]
(
	[contentNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_2]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_2] ON [dbo].[cmsPropertyData]
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_3]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_3] ON [dbo].[cmsPropertyData]
(
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeUniqueID]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeUniqueID] ON [dbo].[cmsPropertyType]
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTags]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTags] ON [dbo].[cmsTags]
(
	[tag] ASC,
	[group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTaskType_alias]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTaskType_alias] ON [dbo].[cmsTaskType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsTemplate_nodeId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsTemplate_nodeId] ON [dbo].[cmsTemplate]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchCatalogInventoryLocation]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchCatalogInventoryLocation] ON [dbo].[merchCatalogInventory]
(
	[location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchCustomerLoginName]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchCustomerLoginName] ON [dbo].[merchCustomer]
(
	[loginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchCustomerIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchCustomerIndex] ON [dbo].[merchCustomerIndex]
(
	[customerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchInvoiceDate]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchInvoiceDate] ON [dbo].[merchInvoice]
(
	[invoiceDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchInvoiceNumber]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchInvoiceNumber] ON [dbo].[merchInvoice]
(
	[invoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchInvoiceIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchInvoiceIndex] ON [dbo].[merchInvoiceIndex]
(
	[invoiceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchInvoiceItemSku]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchInvoiceItemSku] ON [dbo].[merchInvoiceItem]
(
	[sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchItemCacheEntityKey]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchItemCacheEntityKey] ON [dbo].[merchItemCache]
(
	[entityKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchOfferSettingsOfferCode]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchOfferSettingsOfferCode] ON [dbo].[merchOfferSettings]
(
	[offerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchOrderDate]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchOrderDate] ON [dbo].[merchOrder]
(
	[orderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchOrderNumber]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchOrderNumber] ON [dbo].[merchOrder]
(
	[orderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchOrderIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchOrderIndex] ON [dbo].[merchOrderIndex]
(
	[orderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchOrderItemSku]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchOrderItemSku] ON [dbo].[merchOrderItem]
(
	[sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchPaymentCustomer]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchPaymentCustomer] ON [dbo].[merchPayment]
(
	[customerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_merchProductVariantDetachedContentCultureName]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_merchProductVariantDetachedContentCultureName] ON [dbo].[merchProductVariantDetachedContent]
(
	[cultureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchProductVariantDetachedContentKey]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchProductVariantDetachedContentKey] ON [dbo].[merchProductVariantDetachedContent]
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchProductVariantIndex]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchProductVariantIndex] ON [dbo].[merchProductVariantIndex]
(
	[productVariantKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_merchShipmentNumber]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_merchShipmentNumber] ON [dbo].[merchShipment]
(
	[shipmentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoAccess_nodeId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccess_nodeId] ON [dbo].[umbracoAccess]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoAccessRule]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccessRule] ON [dbo].[umbracoAccessRule]
(
	[ruleValue] ASC,
	[ruleType] ASC,
	[accessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoLanguage_languageISOCode]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoLanguage_languageISOCode] ON [dbo].[umbracoLanguage]
(
	[languageISOCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoLog]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoLog] ON [dbo].[umbracoLog]
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoMigration]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoMigration] ON [dbo].[umbracoMigration]
(
	[name] ASC,
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeObjectType]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeObjectType] ON [dbo].[umbracoNode]
(
	[nodeObjectType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeParentId]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeParentId] ON [dbo].[umbracoNode]
(
	[parentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeTrashed]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeTrashed] ON [dbo].[umbracoNode]
(
	[trashed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeUniqueID]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoNodeUniqueID] ON [dbo].[umbracoNode]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_computerName]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_computerName] ON [dbo].[umbracoServer]
(
	[computerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoServer_isActive]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoServer_isActive] ON [dbo].[umbracoServer]
(
	[isActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUser_userLogin]    Script Date: 12/19/2015 2:54:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser_userLogin] ON [dbo].[umbracoUser]
(
	[userLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroUseInEditor]  DEFAULT ('0') FOR [macroUseInEditor]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroRefreshRate]  DEFAULT ('0') FOR [macroRefreshRate]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCacheByPage]  DEFAULT ('1') FOR [macroCacheByPage]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCachePersonalized]  DEFAULT ('0') FOR [macroCachePersonalized]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroDontRender]  DEFAULT ('0') FOR [macroDontRender]
GO
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_cmsMacroProperty_macroPropertySortOrder]  DEFAULT ('0') FOR [macroPropertySortOrder]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Email]  DEFAULT ('''') FOR [Email]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_LoginName]  DEFAULT ('''') FOR [LoginName]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Password]  DEFAULT ('''') FOR [Password]
GO
ALTER TABLE [dbo].[cmsMemberType] ADD  CONSTRAINT [DF_cmsMemberType_memberCanEdit]  DEFAULT ('0') FOR [memberCanEdit]
GO
ALTER TABLE [dbo].[cmsMemberType] ADD  CONSTRAINT [DF_cmsMemberType_viewOnProfile]  DEFAULT ('0') FOR [viewOnProfile]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_closed]  DEFAULT ('0') FOR [closed]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[merchCustomer] ADD  CONSTRAINT [DF_merchCustomer_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchCustomer] ADD  CONSTRAINT [DF_merchCustomer_lastActivityDate]  DEFAULT (getdate()) FOR [lastActivityDate]
GO
ALTER TABLE [dbo].[merchCustomer] ADD  CONSTRAINT [DF_merchCustomer_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchCustomer] ADD  CONSTRAINT [DF_merchCustomer_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection] ADD  CONSTRAINT [DF_merchCustomer2EntityCollection_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection] ADD  CONSTRAINT [DF_merchCustomer2EntityCollection_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchCustomerAddress] ADD  CONSTRAINT [DF_merchCustomerAddress_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchCustomerAddress] ADD  CONSTRAINT [DF_merchCustomerAddress_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchCustomerAddress] ADD  CONSTRAINT [DF_merchCustomerAddress_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchCustomerIndex] ADD  CONSTRAINT [DF_merchCustomerIndex_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchCustomerIndex] ADD  CONSTRAINT [DF_merchCustomerIndex_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection] ADD  CONSTRAINT [DF_merchInvoice2EntityCollection_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection] ADD  CONSTRAINT [DF_merchInvoice2EntityCollection_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchNote] ADD  CONSTRAINT [DF_merchNote_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchNote] ADD  CONSTRAINT [DF_merchNote_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchNote] ADD  CONSTRAINT [DF_merchNote_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchNotificationMessage] ADD  CONSTRAINT [DF_merchNotificationMessage_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchNotificationMessage] ADD  CONSTRAINT [DF_merchNotificationMessage_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchNotificationMessage] ADD  CONSTRAINT [DF_merchNotificationMessage_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchNotificationMethod] ADD  CONSTRAINT [DF_merchNotificationMethod_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchNotificationMethod] ADD  CONSTRAINT [DF_merchNotificationMethod_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchNotificationMethod] ADD  CONSTRAINT [DF_merchNotificationMethod_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchOfferRedeemed] ADD  CONSTRAINT [DF_merchOfferRedeemed_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchOfferRedeemed] ADD  CONSTRAINT [DF_merchOfferRedeemed_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchOfferRedeemed] ADD  CONSTRAINT [DF_merchOfferRedeemed_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchOfferSettings] ADD  CONSTRAINT [DF_merchOfferSettings_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchOfferSettings] ADD  CONSTRAINT [DF_merchOfferSettings_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchOfferSettings] ADD  CONSTRAINT [DF_merchOfferSettings_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection] ADD  CONSTRAINT [DF_merchProduct2EntityCollection_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection] ADD  CONSTRAINT [DF_merchProduct2EntityCollection_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent] ADD  CONSTRAINT [DF_merchProductVariantDetachedContent_canBeRendered]  DEFAULT ('1') FOR [canBeRendered]
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent] ADD  CONSTRAINT [DF_merchProductVariantDetachedContent_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent] ADD  CONSTRAINT [DF_merchProductVariantDetachedContent_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[merchTaxMethod] ADD  CONSTRAINT [DF_merchTaxMethod_pk]  DEFAULT ('newid()') FOR [pk]
GO
ALTER TABLE [dbo].[merchTaxMethod] ADD  CONSTRAINT [DF_merchTaxMethod_percentageTaxRate]  DEFAULT ('0') FOR [percentageTaxRate]
GO
ALTER TABLE [dbo].[merchTaxMethod] ADD  CONSTRAINT [DF_merchTaxMethod_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[merchTaxMethod] ADD  CONSTRAINT [DF_merchTaxMethod_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoExternalLogin] ADD  CONSTRAINT [DF_umbracoExternalLogin_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_cmsContentType_nodeId] FOREIGN KEY([contentType])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType] CHECK CONSTRAINT [FK_cmsContentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child] FOREIGN KEY([childContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent] FOREIGN KEY([parentContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY([Id])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY([AllowedId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1]
GO
ALTER TABLE [dbo].[cmsContentVersion]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY([ContentId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentVersion] CHECK CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsContentXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentXml] CHECK CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDataType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDataType] CHECK CONSTRAINT [FK_cmsDataType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDataTypePreValues]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY([datatypeNodeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDataTypePreValues] CHECK CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsDictionary]  WITH CHECK ADD  CONSTRAINT [FK_cmsDictionary_cmsDictionary_id] FOREIGN KEY([parent])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsDictionary] CHECK CONSTRAINT [FK_cmsDictionary_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId] FOREIGN KEY([templateId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId] FOREIGN KEY([templateNodeId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id] FOREIGN KEY([UniqueId])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY([languageId])
REFERENCES [dbo].[umbracoLanguage] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id]
GO
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY([macro])
REFERENCES [dbo].[cmsMacro] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY([Member])
REFERENCES [dbo].[cmsMember] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY([MemberGroup])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId] FOREIGN KEY([NodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY([NodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY([versionId])
REFERENCES [dbo].[cmsContentVersion] ([VersionId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY([propertytypeid])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY([contentNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId] FOREIGN KEY([contentTypeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId] FOREIGN KEY([dataTypeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY([propertyTypeGroupId])
REFERENCES [dbo].[cmsPropertyTypeGroup] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id]
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId] FOREIGN KEY([contenttypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup] CHECK CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyTypeGroup_cmsPropertyTypeGroup_id] FOREIGN KEY([parentGroupId])
REFERENCES [dbo].[cmsPropertyTypeGroup] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup] CHECK CONSTRAINT [FK_cmsPropertyTypeGroup_cmsPropertyTypeGroup_id]
GO
ALTER TABLE [dbo].[cmsStylesheet]  WITH CHECK ADD  CONSTRAINT [FK_cmsStylesheet_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsStylesheet] CHECK CONSTRAINT [FK_cmsStylesheet_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsContent]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY([propertyTypeId])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY([tagId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsTags_id]
GO
ALTER TABLE [dbo].[cmsTags]  WITH CHECK ADD  CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY([ParentId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTags] CHECK CONSTRAINT [FK_cmsTags_cmsTags]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_cmsTaskType_id] FOREIGN KEY([taskTypeId])
REFERENCES [dbo].[cmsTaskType] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_cmsTaskType_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY([parentUserId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser1]
GO
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_umbracoNode]
GO
ALTER TABLE [dbo].[merchAppliedPayment]  WITH CHECK ADD  CONSTRAINT [FK_merchAppliedPayment_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchAppliedPayment] CHECK CONSTRAINT [FK_merchAppliedPayment_merchInvoice]
GO
ALTER TABLE [dbo].[merchAppliedPayment]  WITH CHECK ADD  CONSTRAINT [FK_merchAppliedPayment_merchPayment] FOREIGN KEY([paymentKey])
REFERENCES [dbo].[merchPayment] ([pk])
GO
ALTER TABLE [dbo].[merchAppliedPayment] CHECK CONSTRAINT [FK_merchAppliedPayment_merchPayment]
GO
ALTER TABLE [dbo].[merchCatalogInventory]  WITH CHECK ADD  CONSTRAINT [FK_merchCatalogInventory_merchWarehouseCatalog] FOREIGN KEY([catalogKey])
REFERENCES [dbo].[merchWarehouseCatalog] ([pk])
GO
ALTER TABLE [dbo].[merchCatalogInventory] CHECK CONSTRAINT [FK_merchCatalogInventory_merchWarehouseCatalog]
GO
ALTER TABLE [dbo].[merchCatalogInventory]  WITH CHECK ADD  CONSTRAINT [FK_merchWarehouseInventory_merchProductVariant] FOREIGN KEY([productVariantKey])
REFERENCES [dbo].[merchProductVariant] ([pk])
GO
ALTER TABLE [dbo].[merchCatalogInventory] CHECK CONSTRAINT [FK_merchWarehouseInventory_merchProductVariant]
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchCustomer2EntityCollection_merchEntityCollection] FOREIGN KEY([entityCollectionKey])
REFERENCES [dbo].[merchEntityCollection] ([pk])
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection] CHECK CONSTRAINT [FK_merchCustomer2EntityCollection_merchEntityCollection]
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchCustomer2EntityCollection_merchInvoice] FOREIGN KEY([customerKey])
REFERENCES [dbo].[merchCustomer] ([pk])
GO
ALTER TABLE [dbo].[merchCustomer2EntityCollection] CHECK CONSTRAINT [FK_merchCustomer2EntityCollection_merchInvoice]
GO
ALTER TABLE [dbo].[merchCustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_merchCustomerAddress_merchCustomer] FOREIGN KEY([customerKey])
REFERENCES [dbo].[merchCustomer] ([pk])
GO
ALTER TABLE [dbo].[merchCustomerAddress] CHECK CONSTRAINT [FK_merchCustomerAddress_merchCustomer]
GO
ALTER TABLE [dbo].[merchCustomerIndex]  WITH CHECK ADD  CONSTRAINT [FK_merchCustomerIndex_merchCustomer] FOREIGN KEY([customerKey])
REFERENCES [dbo].[merchCustomer] ([pk])
GO
ALTER TABLE [dbo].[merchCustomerIndex] CHECK CONSTRAINT [FK_merchCustomerIndex_merchCustomer]
GO
ALTER TABLE [dbo].[merchEntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchEntityCollection_merchEntityCollection] FOREIGN KEY([parentKey])
REFERENCES [dbo].[merchEntityCollection] ([pk])
GO
ALTER TABLE [dbo].[merchEntityCollection] CHECK CONSTRAINT [FK_merchEntityCollection_merchEntityCollection]
GO
ALTER TABLE [dbo].[merchInvoice]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoice_merchCustomer] FOREIGN KEY([customerKey])
REFERENCES [dbo].[merchCustomer] ([pk])
GO
ALTER TABLE [dbo].[merchInvoice] CHECK CONSTRAINT [FK_merchInvoice_merchCustomer]
GO
ALTER TABLE [dbo].[merchInvoice]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoice_merchInvoiceStatus] FOREIGN KEY([invoiceStatusKey])
REFERENCES [dbo].[merchInvoiceStatus] ([pk])
GO
ALTER TABLE [dbo].[merchInvoice] CHECK CONSTRAINT [FK_merchInvoice_merchInvoiceStatus]
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoice2EntityCollection_merchEntityCollection] FOREIGN KEY([entityCollectionKey])
REFERENCES [dbo].[merchEntityCollection] ([pk])
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection] CHECK CONSTRAINT [FK_merchInvoice2EntityCollection_merchEntityCollection]
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoice2EntityCollection_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchInvoice2EntityCollection] CHECK CONSTRAINT [FK_merchInvoice2EntityCollection_merchInvoice]
GO
ALTER TABLE [dbo].[merchInvoiceIndex]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoiceIndex_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchInvoiceIndex] CHECK CONSTRAINT [FK_merchInvoiceIndex_merchInvoice]
GO
ALTER TABLE [dbo].[merchInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_merchInvoiceItem_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchInvoiceItem] CHECK CONSTRAINT [FK_merchInvoiceItem_merchInvoice]
GO
ALTER TABLE [dbo].[merchItemCacheItem]  WITH CHECK ADD  CONSTRAINT [FK_merchItemCacheItem_merchItemCache] FOREIGN KEY([itemCacheKey])
REFERENCES [dbo].[merchItemCache] ([pk])
GO
ALTER TABLE [dbo].[merchItemCacheItem] CHECK CONSTRAINT [FK_merchItemCacheItem_merchItemCache]
GO
ALTER TABLE [dbo].[merchNotificationMessage]  WITH CHECK ADD  CONSTRAINT [FK_merchNotificationMessage_merchNotificationMethod] FOREIGN KEY([methodKey])
REFERENCES [dbo].[merchNotificationMethod] ([pk])
GO
ALTER TABLE [dbo].[merchNotificationMessage] CHECK CONSTRAINT [FK_merchNotificationMessage_merchNotificationMethod]
GO
ALTER TABLE [dbo].[merchNotificationMethod]  WITH CHECK ADD  CONSTRAINT [FK_merchNotificationMethod_merchGatewayProvider] FOREIGN KEY([providerKey])
REFERENCES [dbo].[merchGatewayProviderSettings] ([pk])
GO
ALTER TABLE [dbo].[merchNotificationMethod] CHECK CONSTRAINT [FK_merchNotificationMethod_merchGatewayProvider]
GO
ALTER TABLE [dbo].[merchOfferRedeemed]  WITH CHECK ADD  CONSTRAINT [FK_merchOfferRedeemed_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchOfferRedeemed] CHECK CONSTRAINT [FK_merchOfferRedeemed_merchInvoice]
GO
ALTER TABLE [dbo].[merchOfferRedeemed]  WITH CHECK ADD  CONSTRAINT [FK_merchOfferRedeemed_merchOfferSettings] FOREIGN KEY([offerSettingsKey])
REFERENCES [dbo].[merchOfferSettings] ([pk])
GO
ALTER TABLE [dbo].[merchOfferRedeemed] CHECK CONSTRAINT [FK_merchOfferRedeemed_merchOfferSettings]
GO
ALTER TABLE [dbo].[merchOrder]  WITH CHECK ADD  CONSTRAINT [FK_merchOrder_merchInvoice] FOREIGN KEY([invoiceKey])
REFERENCES [dbo].[merchInvoice] ([pk])
GO
ALTER TABLE [dbo].[merchOrder] CHECK CONSTRAINT [FK_merchOrder_merchInvoice]
GO
ALTER TABLE [dbo].[merchOrder]  WITH CHECK ADD  CONSTRAINT [FK_merchOrder_merchOrderStatus] FOREIGN KEY([orderStatusKey])
REFERENCES [dbo].[merchOrderStatus] ([pk])
GO
ALTER TABLE [dbo].[merchOrder] CHECK CONSTRAINT [FK_merchOrder_merchOrderStatus]
GO
ALTER TABLE [dbo].[merchOrderIndex]  WITH CHECK ADD  CONSTRAINT [FK_merchOrderIndex_merchOrder] FOREIGN KEY([orderKey])
REFERENCES [dbo].[merchOrder] ([pk])
GO
ALTER TABLE [dbo].[merchOrderIndex] CHECK CONSTRAINT [FK_merchOrderIndex_merchOrder]
GO
ALTER TABLE [dbo].[merchOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_merchOrderItem_merchOrder] FOREIGN KEY([orderKey])
REFERENCES [dbo].[merchOrder] ([pk])
GO
ALTER TABLE [dbo].[merchOrderItem] CHECK CONSTRAINT [FK_merchOrderItem_merchOrder]
GO
ALTER TABLE [dbo].[merchOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_merchOrderItem_merchShipment] FOREIGN KEY([shipmentKey])
REFERENCES [dbo].[merchShipment] ([pk])
GO
ALTER TABLE [dbo].[merchOrderItem] CHECK CONSTRAINT [FK_merchOrderItem_merchShipment]
GO
ALTER TABLE [dbo].[merchPayment]  WITH CHECK ADD  CONSTRAINT [FK_merchPayment_merchCustomer] FOREIGN KEY([customerKey])
REFERENCES [dbo].[merchCustomer] ([pk])
GO
ALTER TABLE [dbo].[merchPayment] CHECK CONSTRAINT [FK_merchPayment_merchCustomer]
GO
ALTER TABLE [dbo].[merchPayment]  WITH CHECK ADD  CONSTRAINT [FK_merchPayment_merchPaymentMethod] FOREIGN KEY([paymentMethodKey])
REFERENCES [dbo].[merchPaymentMethod] ([pk])
GO
ALTER TABLE [dbo].[merchPayment] CHECK CONSTRAINT [FK_merchPayment_merchPaymentMethod]
GO
ALTER TABLE [dbo].[merchPaymentMethod]  WITH CHECK ADD  CONSTRAINT [FK_merchPaymentMethod_merchGatewayProviderSettings] FOREIGN KEY([providerKey])
REFERENCES [dbo].[merchGatewayProviderSettings] ([pk])
GO
ALTER TABLE [dbo].[merchPaymentMethod] CHECK CONSTRAINT [FK_merchPaymentMethod_merchGatewayProviderSettings]
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchProduct2EnityCollection_merchProduct] FOREIGN KEY([productKey])
REFERENCES [dbo].[merchProduct] ([pk])
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection] CHECK CONSTRAINT [FK_merchProduct2EnityCollection_merchProduct]
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection]  WITH CHECK ADD  CONSTRAINT [FK_merchProduct2EntityCollection_merchEntityCollection] FOREIGN KEY([entityCollectionKey])
REFERENCES [dbo].[merchEntityCollection] ([pk])
GO
ALTER TABLE [dbo].[merchProduct2EntityCollection] CHECK CONSTRAINT [FK_merchProduct2EntityCollection_merchEntityCollection]
GO
ALTER TABLE [dbo].[merchProduct2ProductOption]  WITH CHECK ADD  CONSTRAINT [FK_merchProduct2Option_merchOption] FOREIGN KEY([optionKey])
REFERENCES [dbo].[merchProductOption] ([pk])
GO
ALTER TABLE [dbo].[merchProduct2ProductOption] CHECK CONSTRAINT [FK_merchProduct2Option_merchOption]
GO
ALTER TABLE [dbo].[merchProduct2ProductOption]  WITH CHECK ADD  CONSTRAINT [FK_merchProduct2Option_merchProduct] FOREIGN KEY([productKey])
REFERENCES [dbo].[merchProduct] ([pk])
GO
ALTER TABLE [dbo].[merchProduct2ProductOption] CHECK CONSTRAINT [FK_merchProduct2Option_merchProduct]
GO
ALTER TABLE [dbo].[merchProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_merchProductAttribute_merchOption] FOREIGN KEY([optionKey])
REFERENCES [dbo].[merchProductOption] ([pk])
GO
ALTER TABLE [dbo].[merchProductAttribute] CHECK CONSTRAINT [FK_merchProductAttribute_merchOption]
GO
ALTER TABLE [dbo].[merchProductVariant]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariant_merchProduct] FOREIGN KEY([productKey])
REFERENCES [dbo].[merchProduct] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariant] CHECK CONSTRAINT [FK_merchProductVariant_merchProduct]
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductAttribute] FOREIGN KEY([productAttributeKey])
REFERENCES [dbo].[merchProductAttribute] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute] CHECK CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductAttribute]
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductOption] FOREIGN KEY([optionKey])
REFERENCES [dbo].[merchProductOption] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute] CHECK CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductOption]
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductVariant] FOREIGN KEY([productVariantKey])
REFERENCES [dbo].[merchProductVariant] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariant2ProductAttribute] CHECK CONSTRAINT [FK_merchProductVariant2ProductAttribute_merchProductVariant]
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariantDetachedContent_merchDetachedContentTypeKey] FOREIGN KEY([detachedContentTypeKey])
REFERENCES [dbo].[merchDetachedContentType] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent] CHECK CONSTRAINT [FK_merchProductVariantDetachedContent_merchDetachedContentTypeKey]
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariantDetachedContent_merchProductVariant] FOREIGN KEY([productVariantKey])
REFERENCES [dbo].[merchProductVariant] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariantDetachedContent] CHECK CONSTRAINT [FK_merchProductVariantDetachedContent_merchProductVariant]
GO
ALTER TABLE [dbo].[merchProductVariantIndex]  WITH CHECK ADD  CONSTRAINT [FK_merchProductVariantIndex_merchProductVariant] FOREIGN KEY([productVariantKey])
REFERENCES [dbo].[merchProductVariant] ([pk])
GO
ALTER TABLE [dbo].[merchProductVariantIndex] CHECK CONSTRAINT [FK_merchProductVariantIndex_merchProductVariant]
GO
ALTER TABLE [dbo].[merchShipCountry]  WITH CHECK ADD  CONSTRAINT [FK_merchCatalogCountry_merchWarehouseCatalog] FOREIGN KEY([catalogKey])
REFERENCES [dbo].[merchWarehouseCatalog] ([pk])
GO
ALTER TABLE [dbo].[merchShipCountry] CHECK CONSTRAINT [FK_merchCatalogCountry_merchWarehouseCatalog]
GO
ALTER TABLE [dbo].[merchShipment]  WITH CHECK ADD  CONSTRAINT [FK_merchShipment_merchShipmentStatus] FOREIGN KEY([shipmentStatusKey])
REFERENCES [dbo].[merchShipmentStatus] ([pk])
GO
ALTER TABLE [dbo].[merchShipment] CHECK CONSTRAINT [FK_merchShipment_merchShipmentStatus]
GO
ALTER TABLE [dbo].[merchShipment]  WITH CHECK ADD  CONSTRAINT [FK_merchShipment_merchShipMethod] FOREIGN KEY([shipMethodKey])
REFERENCES [dbo].[merchShipMethod] ([pk])
GO
ALTER TABLE [dbo].[merchShipment] CHECK CONSTRAINT [FK_merchShipment_merchShipMethod]
GO
ALTER TABLE [dbo].[merchShipMethod]  WITH CHECK ADD  CONSTRAINT [FK_merchShipMethod_merchGatewayProviderSettings] FOREIGN KEY([providerKey])
REFERENCES [dbo].[merchGatewayProviderSettings] ([pk])
GO
ALTER TABLE [dbo].[merchShipMethod] CHECK CONSTRAINT [FK_merchShipMethod_merchGatewayProviderSettings]
GO
ALTER TABLE [dbo].[merchShipMethod]  WITH CHECK ADD  CONSTRAINT [FK_merchShipMethod_merchShipCountry] FOREIGN KEY([shipCountryKey])
REFERENCES [dbo].[merchShipCountry] ([pk])
GO
ALTER TABLE [dbo].[merchShipMethod] CHECK CONSTRAINT [FK_merchShipMethod_merchShipCountry]
GO
ALTER TABLE [dbo].[merchShipRateTier]  WITH CHECK ADD  CONSTRAINT [FK_merchShipmentRateTier_merchShipMethod] FOREIGN KEY([shipMethodKey])
REFERENCES [dbo].[merchShipMethod] ([pk])
GO
ALTER TABLE [dbo].[merchShipRateTier] CHECK CONSTRAINT [FK_merchShipmentRateTier_merchShipMethod]
GO
ALTER TABLE [dbo].[merchTaxMethod]  WITH CHECK ADD  CONSTRAINT [FK_merchTaxMethod_merchGatewayProviderSettings] FOREIGN KEY([providerKey])
REFERENCES [dbo].[merchGatewayProviderSettings] ([pk])
GO
ALTER TABLE [dbo].[merchTaxMethod] CHECK CONSTRAINT [FK_merchTaxMethod_merchGatewayProviderSettings]
GO
ALTER TABLE [dbo].[merchWarehouseCatalog]  WITH CHECK ADD  CONSTRAINT [FK_merchWarehouseCatalog_merchWarehouse] FOREIGN KEY([warehouseKey])
REFERENCES [dbo].[merchWarehouse] ([pk])
GO
ALTER TABLE [dbo].[merchWarehouseCatalog] CHECK CONSTRAINT [FK_merchWarehouseCatalog_merchWarehouse]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY([loginNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id1]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY([noAccessNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id2]
GO
ALTER TABLE [dbo].[umbracoAccessRule]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY([accessId])
REFERENCES [dbo].[umbracoAccess] ([id])
GO
ALTER TABLE [dbo].[umbracoAccessRule] CHECK CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id]
GO
ALTER TABLE [dbo].[umbracoDomains]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY([domainRootStructureID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoDomains] CHECK CONSTRAINT [FK_umbracoDomains_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY([parentID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoNode] CHECK CONSTRAINT [FK_umbracoNode_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY([parentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY([childId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode1]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY([relType])
REFERENCES [dbo].[umbracoRelationType] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id]
GO
ALTER TABLE [dbo].[umbracoUser]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser_umbracoUserType_id] FOREIGN KEY([userType])
REFERENCES [dbo].[umbracoUserType] ([id])
GO
ALTER TABLE [dbo].[umbracoUser] CHECK CONSTRAINT [FK_umbracoUser_umbracoUserType_id]
GO
ALTER TABLE [dbo].[umbracoUser2app]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2app_umbracoUser_id] FOREIGN KEY([user])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2app] CHECK CONSTRAINT [FK_umbracoUser2app_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id]
GO
USE [master]
GO
ALTER DATABASE [Laceshop] SET  READ_WRITE 
GO
