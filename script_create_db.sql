USE [QAP]
GO
/****** Object:  Table [dbo].[Badges]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Badges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Date] [date] NULL,
	[Class] [tinyint] NULL,
	[TagBased] [bit] NULL,
 CONSTRAINT [PK_Badges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Certified]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certified](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Certified] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CloseAsOffTopicReasonTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CloseAsOffTopicReasonTypes](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[IsUniversal] [bit] NULL,
	[MarkdownMini] [nvarchar](50) NULL,
	[CreationDate] [datetime] NULL,
	[CreationModeratorId] [int] NULL,
	[ApprovalDate] [datetime] NULL,
	[ApprovalModeratorId] [int] NULL,
	[DeactivationDate] [datetime] NULL,
	[DeactivationModeratorId] [int] NULL,
 CONSTRAINT [PK_CloseAsOffTopicReasonTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CloseReasonTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CloseReasonTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_CloseReasonTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NULL,
	[CreationByAdmin] [bit] NULL,
	[CreationByCurrentUser] [bit] NULL,
	[Content] [nvarchar](max) NULL,
	[PostsId] [int] NULL,
	[ParentId] [int] NULL,
	[ProfilePictureUrl] [nvarchar](250) NULL,
	[UserId] [int] NULL,
	[UserDisplayName] [nvarchar](50) NULL,
	[UpvoteCount] [int] NULL,
	[UserHasUpvote] [bit] NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FlagTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlagTypes](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_FlagTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Following]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Following](
	[FollowingUserId] [int] NOT NULL,
	[FollowedUserId] [int] NOT NULL,
 CONSTRAINT [PK_Following] PRIMARY KEY CLUSTERED 
(
	[FollowingUserId] ASC,
	[FollowedUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Images]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageData] [varbinary](max) NULL,
	[Name] [varbinary](50) NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PendingFlags]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PendingFlags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FlagTypeId] [tinyint] NULL,
	[PostId] [int] NULL,
	[CreationDate] [datetime] NULL,
	[CloseReasonTypeId] [tinyint] NULL,
	[CloseAsOffTopicReationTypeId] [tinyint] NULL,
	[DuplicateOfQuestionId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostFeedback]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostFeedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NULL,
	[IsAnonymous] [bit] NULL,
	[VoteTypeId] [tinyint] NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_PostFeedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostHistoryTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostHistoryTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_PostHistoryTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostLinks]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostLinks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NULL,
	[PostId] [int] NULL,
	[RelatedPostId] [int] NULL,
	[LinkTypeId] [tinyint] NULL,
 CONSTRAINT [PK_PostLinks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AcceptedAnswerId] [int] NULL,
	[AnswerCount] [int] NULL,
	[BodyContent] [nvarchar](max) NULL,
	[CreationDate] [datetime] NULL,
	[Comments] [nvarchar](max) NULL,
	[CommentCount] [int] NULL,
	[CloseDate] [datetime] NULL,
	[CommunityOwnedDate] [datetime] NULL,
	[CoverImg] [varchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[DeletionDate] [datetime] NULL,
	[OwnerUserId] [int] NULL,
	[PostTypeId] [tinyint] NULL,
	[ParentId] [int] NULL,
	[RelatedPosts] [varchar](500) NULL,
	[Score] [int] NULL,
	[HtmlContent] [nvarchar](max) NULL,
	[HeadContent] [nvarchar](500) NULL,
	[Tags] [nvarchar](500) NULL,
	[Title] [nvarchar](250) NULL,
	[TableContent] [nvarchar](max) NULL,
	[UserDisplayName] [nvarchar](50) NULL,
	[LastActivityDate] [datetime] NULL,
	[LastEditDate] [datetime] NULL,
	[LastEditorUserId] [int] NULL,
	[VoteCount] [int] NULL,
	[ViewCount] [int] NULL,
	[Answer2] [nvarchar](max) NULL,
	[Answer3] [nvarchar](max) NULL,
	[Answer4] [nvarchar](max) NULL,
	[Answer5] [nvarchar](max) NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PostsTag]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostsTag](
	[TagId] [int] NOT NULL,
	[PostsId] [int] NOT NULL,
 CONSTRAINT [PK_PostsTag] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC,
	[PostsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostType]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_PostType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Questions]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](500) NULL,
	[Answer1] [nvarchar](250) NULL,
	[Answer2] [nvarchar](250) NULL,
	[Answer3] [nvarchar](250) NULL,
	[Answer4] [nvarchar](250) NULL,
	[Answer] [nvarchar](max) NULL,
	[CorrectAnswer] [tinyint] NULL,
	[VoteCount] [int] NULL,
	[ViewCount] [int] NULL,
	[Tags] [nvarchar](500) NULL,
	[Level] [tinyint] NULL,
	[TestTypeId] [tinyint] NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionTag]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionTag](
	[QuestionId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
 CONSTRAINT [PK_QuestionTag] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quotes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](500) NULL,
	[UserId] [int] NULL,
	[AuthorDisplayName] [nvarchar](50) NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_Quotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewRejectionReasons]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewRejectionReasons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[PostTypeId] [tinyint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewTaskResults]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTaskResults](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReviewTaskId] [int] NULL,
	[ReviewTaskResultTypeId] [tinyint] NULL,
	[CreationDate] [datetime] NULL,
	[RejectionReationId] [tinyint] NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_ReviewTaskResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewTaskResultType]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTaskResultType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_ReviewTaskResultType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewTasks]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReviewTaskTypeId] [tinyint] NULL,
	[CreationDate] [datetime] NULL,
	[DeletionDate] [datetime] NULL,
	[ReviewTaskStateId] [tinyint] NULL,
	[PostId] [int] NULL,
	[SuggestedEditId] [int] NULL,
	[CompletedByReviewTaskId] [int] NULL,
 CONSTRAINT [PK_ReviewTasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewTaskStates]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTaskStates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_ReviewTaskStates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewTaskTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTaskTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_ReviewTaskTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuggestedEdits]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuggestedEdits](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NULL,
	[CreationDate] [datetime] NULL,
	[ApprovalDate] [datetime] NULL,
	[RejectionDate] [datetime] NULL,
	[OwnerUserId] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[EditContent] [nvarchar](max) NULL,
	[Title] [nvarchar](250) NULL,
	[Tags] [nvarchar](250) NULL,
	[RevisionGuid] [nvarchar](50) NULL,
 CONSTRAINT [PK_SuggestedEdits] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuggestedEditVotes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuggestedEditVotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SuggestedEditId] [int] NULL,
	[UserId] [int] NULL,
	[VoteTypeId] [tinyint] NULL,
	[CreationDate] [datetime] NULL,
	[TargetUserId] [int] NULL,
	[TargetRepChange] [int] NULL,
 CONSTRAINT [PK_SuggestedEditVotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tags]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Count] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[ExcerptPostId] [int] NULL,
	[WikiPostId] [int] NULL,
	[UserCreatedId] [int] NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TagSynonyms]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagSynonyms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SourceTagName] [nvarchar](50) NULL,
	[TargetTagName] [nvarchar](50) NULL,
	[CreationDate] [datetime] NULL,
	[OwnerUserId] [int] NULL,
	[AutoRenameCount] [int] NULL,
	[LastAutoRename] [datetime] NULL,
	[Score] [int] NULL,
	[ApprovedByUserId] [int] NULL,
	[ApprovalDate] [datetime] NULL,
 CONSTRAINT [PK_TagSynonyms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestQuestion]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestQuestion](
	[TestId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
 CONSTRAINT [PK_TestQuestion] PRIMARY KEY CLUSTERED 
(
	[TestId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tests]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatorId] [int] NULL,
	[CloseDate] [nchar](10) NULL,
	[CommentCount] [nchar](10) NULL,
	[Comments] [nchar](10) NULL,
	[CreationDate] [nchar](10) NULL,
	[Description] [nvarchar](500) NULL,
	[DeletionDate] [nchar](10) NULL,
	[Title] [nvarchar](500) NULL,
	[Tags] [nvarchar](500) NULL,
	[TestTypeId] [tinyint] NULL,
	[VoteCount] [int] NULL,
	[ViewCount] [int] NULL,
	[ExcuteCount] [int] NULL,
	[LastEditDate] [datetime] NULL,
	[LastActiveDate] [datetime] NULL,
	[UserDisplayName] [nvarchar](50) NULL,
	[LastEditorUserId] [int] NULL,
	[Level] [tinyint] NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_Test1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestType]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_TestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NULL,
	[Address] [nvarchar](250) NULL,
	[Age] [int] NULL,
	[AboutMe] [nvarchar](250) NULL,
	[Avatar] [varchar](250) NULL,
	[CreationDate] [datetime] NULL,
	[DisplayName] [nvarchar](50) NULL,
	[DownVotes] [int] NULL,
	[DoB] [datetime] NULL,
	[Email] [varchar](250) NULL,
	[Reputation] [int] NULL,
	[Rank] [int] NULL,
	[Location] [nvarchar](250) NULL,
	[LastAccessDate] [datetime] NULL,
	[LastName] [nvarchar](50) NULL,
	[ProfileImageUrl] [nvarchar](250) NULL,
	[Phone] [varchar](50) NULL,
	[Password] [nvarchar](250) NULL,
	[PostsCount] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[FollowedCount] [int] NULL,
	[UpVotes] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[Views] [int] NULL,
	[WebsiteUrl] [nvarchar](250) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserTest]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[TestId] [int] NULL,
	[Total] [int] NULL,
	[Pass] [int] NULL,
	[ScoreUnit] [int] NULL,
	[UserDisplayName] [nvarchar](50) NULL,
	[CertifiedId] [tinyint] NULL,
 CONSTRAINT [PK_UserTest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Votes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Votes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostsId] [int] NULL,
	[VoteTypeId] [tinyint] NULL,
	[UserId] [int] NULL,
	[CreationDate] [datetime] NULL,
	[BountyAmount] [int] NULL,
	[IsOn] [bit] NULL,
 CONSTRAINT [PK_Votes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VoteTypes]    Script Date: 08/07/2017 11:56:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoteTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_VoteTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
