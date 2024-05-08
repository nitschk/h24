USE [master]
GO
/****** Object:  Database [klc01]    Script Date: 05.05.2024 21:24:12 ******/
CREATE DATABASE [klc01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'klc01', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\klc01.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'klc01_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\klc01_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [klc01] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [klc01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [klc01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [klc01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [klc01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [klc01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [klc01] SET ARITHABORT OFF 
GO
ALTER DATABASE [klc01] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [klc01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [klc01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [klc01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [klc01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [klc01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [klc01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [klc01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [klc01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [klc01] SET  DISABLE_BROKER 
GO
ALTER DATABASE [klc01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [klc01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [klc01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [klc01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [klc01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [klc01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [klc01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [klc01] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [klc01] SET  MULTI_USER 
GO
ALTER DATABASE [klc01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [klc01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [klc01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [klc01] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [klc01] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [klc01] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [klc01] SET QUERY_STORE = OFF
GO
USE [klc01]
GO
/****** Object:  User [sportident]    Script Date: 05.05.2024 21:24:12 ******/
CREATE USER [sportident] FOR LOGIN [sportident] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sportident]
GO
/****** Object:  UserDefinedFunction [dbo].[time_from_start]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[time_from_start] (
    @start_time DATETIME
   ,@punch_time DATETIME
)
/*
select dbo.time_from_start('2021-01-04 00:00:00.000', '2021-01-04 00:15:43.000')
*/
RETURNS VARCHAR(10)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @diff_seconds INT
    DECLARE @hours AS INT
    DECLARE @minutes AS INT
    DECLARE @sec AS CHAR(2)
    DECLARE @minus AS CHAR(1)
    DECLARE @time_from_start AS VARCHAR(10)

    -- Add the T-SQL statements to compute the return value here	
    SET @diff_seconds = DATEDIFF(s, @start_time, @punch_time)
    IF @diff_seconds < 0
    BEGIN
        SET @diff_seconds = ABS(@diff_seconds)
        SET @minus = '-'
    END
    ELSE
        SET @minus = ''

    SET @hours = @diff_seconds / 3600
    SET @minutes = ((@diff_seconds - @hours * 3600) / 60)
    SET @sec = CAST(@diff_seconds % 60 AS CHAR(2))
    SET @sec = RIGHT('00' + RTRIM(@sec), 2)

    -- Return the result of the function
    SET @time_from_start = @minus + RTRIM(CAST(@hours AS CHAR(2))) + ':' + RIGHT('00' + RTRIM(CAST(@minutes AS CHAR(2))), 2) + ':' + @sec
    RETURN @time_from_start
END
GO
/****** Object:  Table [dbo].[slips]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slips](
	[slip_id] [int] IDENTITY(1,1) NOT NULL,
	[comp_id] [int] NOT NULL,
	[team_id] [int] NULL,
	[course_id] [int] NOT NULL,
	[course_name] [nvarchar](20) NOT NULL,
	[readout_id] [int] NOT NULL,
	[chip_id] [int] NOT NULL,
	[leg_id] [int] NOT NULL,
	[comp_name] [nvarchar](50) NULL,
	[bib] [nvarchar](10) NOT NULL,
	[comp_country] [varchar](10) NULL,
	[rented_chip] [bit] NULL,
	[team_nr] [int] NULL,
	[team_name] [nvarchar](255) NULL,
	[cat_name] [nvarchar](50) NOT NULL,
	[course_length] [int] NULL,
	[course_climb] [int] NULL,
	[start_dtime] [datetime] NULL,
	[clear_dtime] [datetime] NULL,
	[clear_time] [varchar](15) NULL,
	[check_dtime] [datetime] NULL,
	[check_time] [varchar](15) NULL,
	[finish_dtime] [datetime] NULL,
	[leg_time] [varchar](15) NULL,
	[punch_index] [int] NULL,
	[position] [int] NULL,
	[control_code] [varchar](5) NULL,
	[punch_dtime] [datetime] NULL,
	[punch_time] [varchar](15) NULL,
	[lap_dtime] [time](7) NULL,
	[lap_time] [varchar](15) NULL,
	[valid_flag] [bit] NULL,
	[leg_status] [nvarchar](10) NULL,
	[dsk_penalty] [time](7) NULL,
	[team_race_end_zero] [varchar](10) NULL,
	[team_race_end] [datetime] NULL,
	[stamp_readout_dtime] [datetime] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__slips__43C7142249FC2140] PRIMARY KEY CLUSTERED 
(
	[slip_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_teams_results]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[v_teams_results]
AS
SELECT 
	RANK() OVER (PARTITION BY cat_name ORDER BY legs_count DESC, race_time) AS res_pos,
	team_id, 
	team_nr, 
	team_name, 
	cat_name, 
	race_time,
	legs_count
FROM   
(
	SELECT 
		team_id, 
		course_name, 
		team_nr, 
		team_name, 
		cat_name, 
		finish_dtime, 
		team_race_end_zero, 
		team_race_end,
		MAX(finish_dtime) OVER( PARTITION BY team_id) AS race_time,
		dense_rank() over (partition by team_id order by course_name) 
			+ dense_rank() over (partition by team_id order by course_name desc) 
			- 1 as legs_count
	FROM
		dbo.slips
	WHERE valid_flag = 1
	GROUP BY 
		team_id, 
		course_name, 
		team_nr, 
		team_name, 
		cat_name, 
		finish_dtime, 
		team_race_end_zero, 
		team_race_end
) AS a
GROUP BY 
	team_id, 
	team_nr, 
	team_name, 
	cat_name,
	legs_count,
	race_time
GO
/****** Object:  Table [dbo].[teams]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teams](
	[team_id] [int] IDENTITY(1,1) NOT NULL,
	[team_nr] [int] NULL,
	[team_name] [nvarchar](255) NULL,
	[team_abbr] [nvarchar](50) NULL,
	[cat_id] [int] NULL,
	[team_did_start] [bit] NOT NULL,
	[team_status] [varchar](10) NULL,
	[race_end] [datetime] NULL,
	[oris_id] [int] NULL,
	[phone_number] [nvarchar](20) NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__teams__F82DEDBDF3AC913B] PRIMARY KEY NONCLUSTERED 
(
	[team_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[cat_id] [int] IDENTITY(1,1) NOT NULL,
	[cat_name] [nvarchar](50) NOT NULL,
	[first_start_number] [int] NULL,
	[cat_start_time] [datetime] NULL,
	[cat_time_limit] [int] NULL,
	[force_order] [bit] NULL,
	[valid] [bit] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__categori__DD5DDDBC2286FC7F] PRIMARY KEY NONCLUSTERED 
(
	[cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_xml_resutls]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_xml_resutls] as
SELECT top 100 percent
	t.cat_id,
	s.cat_name,
	s.team_name,
	s.team_id,
	s.team_nr,
	s.comp_id,
	s.comp_name,
	s.bib,
	s.start_dtime,
	s.finish_dtime,
	DATEDIFF(second, s.start_dtime, s.finish_dtime) as time_seconds,
	--DATEDIFF(second, s.start_dtime, s.finish_dtime) - MIN(DATEDIFF(second, s.start_dtime, s.finish_dtime)) over (partition by course_id, cat_id) as seconds_behind,
	leg_status,
	DATEDIFF(second, c.cat_start_time, s.finish_dtime) as overall_time_seconds,
	s.course_id,
	s.course_name,
	s.course_length,
	s.control_code,
	DATEDIFF(second, s.start_dtime, s.punch_dtime) as split_time_seconds

  FROM [dbo].[slips] AS s
inner join v_teams_results as tr on s.team_id = tr.team_id
inner join dbo.teams as t on s.team_id = t.team_id
inner join dbo.categories as c on c.cat_id = t.cat_id
order by s.cat_name, tr.legs_count, s.start_dtime, s.position
GO
/****** Object:  Table [dbo].[competitors]    Script Date: 30.04.2024 17:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[competitors](
	[comp_id] [int] IDENTITY(1,1) NOT NULL,
	[comp_name] [nvarchar](50) NULL,
	[bib] [nvarchar](10) NOT NULL,
	[comp_chip_id] [int] NULL,
	[rented_chip] [bit] NULL,
	[team_id] [int] NULL,
	[rank_order] [int] NOT NULL,
	[comp_withdrawn] [bit] NOT NULL,
	[comp_status] [varchar](10) NULL,
	[comp_valid_flag] [bit] NULL,
	[comp_club] [nvarchar](50) NULL,
	[comp_reg] [nvarchar](10) NULL,
	[comp_country] [varchar](10) NULL,
	[comp_birthday] [datetime] NULL,
	[as_of_date] [datetime] NOT NULL,
	[withdrawn_datetime] [datetime] NULL,
	[comp_id_previous] [int] NULL,
 CONSTRAINT [PK__competit__531653DCEFC42586] PRIMARY KEY NONCLUSTERED 
(
	[comp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[legs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[legs](
	[leg_id] [int] IDENTITY(1,1) NOT NULL,
	[comp_id] [int] NOT NULL,
	[course_id] [int] NULL,
	[readout_id] [int] NULL,
	[start_dtime] [datetime] NULL,
	[start_time] [varchar](20) NULL,
	[finish_dtime] [datetime] NULL,
	[finish_time] [varchar](20) NULL,
	[leg_time] [varchar](20) NULL,
	[leg_status] [nvarchar](10) NULL,
	[dsk_penalty] [time](7) NULL,
	[as_of_date] [datetime] NOT NULL,
	[valid_flag] [bit] NULL,
	[starting_leg] [bit] NULL,
 CONSTRAINT [PK__legs__810CE3C034474519] PRIMARY KEY CLUSTERED 
(
	[leg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[si_readout]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[si_readout](
	[readout_id] [int] IDENTITY(1,1) NOT NULL,
	[chip_id] [varchar](15) NOT NULL,
	[card_readout_datetime] [datetime] NOT NULL,
	[clear_datetime] [datetime] NULL,
	[start_datetime] [datetime] NULL,
	[check_datetime] [datetime] NULL,
	[finish_datetime] [datetime] NULL,
	[finish_missing] [bit] NULL,
	[punch_count] [int] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__si_reado__C71FE367F7D92631] PRIMARY KEY CLUSTERED 
(
	[readout_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_readout_legs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_readout_legs] as
select 
    r.readout_id,
    r.chip_id,
    r.card_readout_datetime,
    l.comp_id,
    l.start_time,
    l.finish_time,
    l.leg_time,
    l.leg_status,
    l.dsk_penalty,
    c.comp_name,
    c.rank_order,
    c.bib,
    s.course_name,
    s.team_name as team,
    l.leg_id,
    l.valid_flag,
    s.valid_flag as race_valid
from 
	dbo.si_readout as r
left outer join dbo.legs as l on r.readout_id = l.readout_id 
left outer join dbo.competitors as c on l.comp_id = c.comp_id
left outer join ( 
	select 
		readout_id,
		course_name,
		team_name,
		valid_flag
	from
		dbo.slips
	group by 
			readout_id,
		course_name,
		team_name,
		valid_flag
	) as s on r.readout_id = s.readout_id

GO
/****** Object:  View [dbo].[v_teams_results_legs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[v_teams_results_legs]
AS
	SELECT top 100 percent
		team_id, 
		course_name, 
		team_nr, 
		team_name, 
		cat_name, 
		finish_dtime, 
		team_race_end_zero, 
		team_race_end,
		MAX(finish_dtime) OVER( PARTITION BY team_id) AS race_time,
		dense_rank() over (partition by team_id order by course_name) 
			+ dense_rank() over (partition by team_id order by course_name desc) 
			- 1 as legs_count
	FROM
		dbo.slips
	WHERE valid_flag = 1

	GROUP BY 
		team_id, 
		course_name, 
		team_nr, 
		team_name, 
		cat_name, 
		finish_dtime, 
		team_race_end_zero, 
		team_race_end
order by cat_name, legs_count desc, race_time, finish_dtime
GO
/****** Object:  Table [dbo].[roc_punches]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roc_punches](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[CodeNr] [int] NOT NULL,
	[ChipNr] [int] NOT NULL,
	[PunchTime] [datetime] NULL,
	[status] [varchar](50) NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_roc_punches] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_new_roc_punches]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[v_new_roc_punches] as
select 
	p.p_id as record_id,
	p.CodeNr as control_code,
	p.ChipNr as chip_id,
	p.PunchTime as punch_date,
	ca.cat_name as cat_name,
	t.team_nr as team_nr,
	t.team_name,
	c.comp_name,
	c.bib,
	t.phone_number
from roc_punches as p
inner join competitors as c on p.ChipNr = c.comp_chip_id
inner join teams as t on c.team_id = t.team_id
inner join categories as ca on t.cat_id = ca.cat_id
where p.status is null
GO
/****** Object:  View [dbo].[v_comp_teams]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[v_comp_teams]
AS
	SELECT
	t.team_id,
	t.team_nr,
	t.team_name,
	t.team_did_start,
	t.team_status,
	t.race_end,
	c.comp_id,
	c.comp_chip_id,
	c.comp_name,
	c.bib,
	c.rented_chip,
	c.rank_order,
	c.comp_withdrawn,
	c.comp_status,
	c.comp_country,
	c.comp_birthday,
	c.comp_valid_flag,
	c.withdrawn_datetime,
	ca.cat_id,
	ca.cat_name,
	ca.cat_start_time,
	ca.cat_time_limit
FROM teams AS t
INNER JOIN competitors AS c
	ON t.team_id = c.team_id
INNER JOIN categories AS ca
	ON t.cat_id = ca.cat_id
GO
/****** Object:  Table [dbo].[api_queue]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[api_queue](
	[q_id] [int] IDENTITY(1,1) NOT NULL,
	[q_dtime] [datetime] NOT NULL,
	[q_url] [nvarchar](150) NOT NULL,
	[q_content] [nvarchar](max) NOT NULL,
	[q_header] [nvarchar](4000) NULL,
	[q_status] [nchar](20) NULL,
	[q_response] [nvarchar](4000) NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_api_queue] PRIMARY KEY CLUSTERED 
(
	[q_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[api_queue_link]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[api_queue_link](
	[q_id] [int] NOT NULL,
	[link_to] [nvarchar](20) NOT NULL,
	[link_id] [int] NOT NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_queue_link] PRIMARY KEY CLUSTERED 
(
	[q_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[calendar]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[calendar](
	[TheDate] [date] NOT NULL,
	[TheDateTime] [datetime] NULL,
	[TheDay] [int] NULL,
	[TheDayName] [nvarchar](30) NULL,
	[TheWeek] [int] NULL,
	[TheISOWeek] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[TheMonthName] [nvarchar](30) NULL,
	[TheQuarter] [int] NULL,
	[TheYear] [int] NULL,
	[TheFirstOfMonth] [date] NULL,
	[TheLastOfYear] [date] NULL,
	[TheDayOfYear] [int] NULL,
 CONSTRAINT [PK_calendar] PRIMARY KEY CLUSTERED 
(
	[TheDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controls]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controls](
	[control_id] [varchar](5) NOT NULL,
	[control_code] [varchar](5) NOT NULL,
	[alt_code] [varchar](5) NULL,
	[time_direction] [char](2) NULL,
	[dif_hour] [int] NULL,
	[dif_min] [int] NULL,
	[dif_sec] [int] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [controls_PK] PRIMARY KEY NONCLUSTERED 
(
	[control_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_codes]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_codes](
	[cc_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[control_id] [varchar](5) NOT NULL,
	[position] [int] NOT NULL,
	[cc_status] [bit] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__course_c__9F1E187BD1C5FCE4] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [nvarchar](20) NOT NULL,
	[course_length] [int] NULL,
	[course_climb] [int] NULL,
	[course_type] [nvarchar](100) NULL,
	[control_count] [int] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__courses__8F1EF7AE2B55AA27] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entry_competitors]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entry_competitors](
	[comp_id] [int] IDENTITY(1,1) NOT NULL,
	[comp_name] [nvarchar](50) NULL,
	[comp_chip_id] [int] NULL,
	[rented_chip] [bit] NULL,
	[entry_team_id] [int] NULL,
	[rank_order] [int] NOT NULL,
	[comp_country] [varchar](10) NULL,
	[comp_birthday] [datetime] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_entry_competitor] PRIMARY KEY NONCLUSTERED 
(
	[comp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entry_file]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entry_file](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[entry] [text] NULL,
	[entry2] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entry_teams]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entry_teams](
	[team_id] [int] IDENTITY(1,1) NOT NULL,
	[team_nr] [int] NULL,
	[team_name] [nvarchar](255) NULL,
	[team_abbr] [nvarchar](50) NULL,
	[class_name] [nvarchar](20) NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_entry_teams] PRIMARY KEY NONCLUSTERED 
(
	[team_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entry_xml]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entry_xml](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oris_team_id] [int] NOT NULL,
	[team_bib] [int] NOT NULL,
	[class_name] [nvarchar](20) NULL,
	[team_name] [nvarchar](50) NULL,
	[team_short_name] [nvarchar](50) NULL,
	[leg] [int] NULL,
	[bib] [nvarchar](10) NULL,
	[family] [nvarchar](50) NULL,
	[given] [nvarchar](50) NULL,
	[gender] [nchar](10) NULL,
	[country] [nchar](10) NULL,
	[birth_date] [nvarchar](50) NULL,
	[si_chip] [int] NULL,
	[note] [nvarchar](500) NULL,
 CONSTRAINT [PK_entry_xml] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leg_exceptions]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leg_exceptions](
	[ex_id] [int] IDENTITY(1,1) NOT NULL,
	[leg_id] [int] NOT NULL,
	[ex_leg_status] [nvarchar](10) NOT NULL,
	[ex_valid_flag] [bit] NOT NULL,
	[ex_dsk_penalty] [time](7) NOT NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_leg_exceptions] PRIMARY KEY CLUSTERED 
(
	[ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[logs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs](
	[logs_id] [int] IDENTITY(1,1) NOT NULL,
	[logs_time] [datetime] NOT NULL,
	[logs_message] [text] NULL,
	[logs_type] [nvarchar](20) NULL,
	[as_of_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[logs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[results]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[results](
	[res_id] [int] IDENTITY(1,1) NOT NULL,
	[cat_id] [int] NULL,
	[team_name] [nvarchar](255) NULL,
	[team_nr] [int] NOT NULL,
	[team_id] [int] NOT NULL,
	[race_end] [datetime] NULL,
	[comp_name] [nvarchar](50) NULL,
	[bib] [nvarchar](10) NOT NULL,
	[start_time] [varchar](20) NULL,
	[finish_time] [varchar](20) NULL,
	[leg_time] [varchar](20) NULL,
	[leg_status] [nvarchar](10) NULL,
	[course_id] [int] NULL,
	[valid_leg] [int] NOT NULL,
	[sum_legs] [int] NULL,
	[max_finish] [varchar](20) NULL,
 CONSTRAINT [PK_results] PRIMARY KEY CLUSTERED 
(
	[res_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[settings]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[settings](
	[s_id] [int] IDENTITY(1,1) NOT NULL,
	[config_name] [nvarchar](50) NOT NULL,
	[config_value] [nvarchar](4000) NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK_settings] PRIMARY KEY CLUSTERED 
(
	[s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[si_stamps]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[si_stamps](
	[id_stamp] [int] IDENTITY(1,1) NOT NULL,
	[readout_id] [int] NOT NULL,
	[chip_id] [bigint] NOT NULL,
	[control_code] [varchar](5) NOT NULL,
	[control_mode] [int] NOT NULL,
	[punch_datetime] [datetime] NULL,
	[punch_wday] [varchar](50) NULL,
	[punch_index] [int] NULL,
	[as_of_date] [datetime] NOT NULL,
 CONSTRAINT [PK__si_stamp__12FEB3630A0F9872] PRIMARY KEY CLUSTERED 
(
	[id_stamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-01' AS Date), CAST(N'2023-01-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-02' AS Date), CAST(N'2023-01-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-03' AS Date), CAST(N'2023-01-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-04' AS Date), CAST(N'2023-01-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-05' AS Date), CAST(N'2023-01-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-06' AS Date), CAST(N'2023-01-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-07' AS Date), CAST(N'2023-01-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-08' AS Date), CAST(N'2023-01-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-09' AS Date), CAST(N'2023-01-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-10' AS Date), CAST(N'2023-01-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-11' AS Date), CAST(N'2023-01-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-12' AS Date), CAST(N'2023-01-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-13' AS Date), CAST(N'2023-01-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-14' AS Date), CAST(N'2023-01-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-15' AS Date), CAST(N'2023-01-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-16' AS Date), CAST(N'2023-01-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-17' AS Date), CAST(N'2023-01-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-18' AS Date), CAST(N'2023-01-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-19' AS Date), CAST(N'2023-01-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-20' AS Date), CAST(N'2023-01-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-21' AS Date), CAST(N'2023-01-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-22' AS Date), CAST(N'2023-01-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-23' AS Date), CAST(N'2023-01-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-24' AS Date), CAST(N'2023-01-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-25' AS Date), CAST(N'2023-01-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-26' AS Date), CAST(N'2023-01-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-27' AS Date), CAST(N'2023-01-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-28' AS Date), CAST(N'2023-01-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-29' AS Date), CAST(N'2023-01-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-30' AS Date), CAST(N'2023-01-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-01-31' AS Date), CAST(N'2023-01-31T00:00:00.000' AS DateTime), 31, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-01' AS Date), CAST(N'2023-02-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-02' AS Date), CAST(N'2023-02-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-03' AS Date), CAST(N'2023-02-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-04' AS Date), CAST(N'2023-02-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-05' AS Date), CAST(N'2023-02-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-06' AS Date), CAST(N'2023-02-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-07' AS Date), CAST(N'2023-02-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-08' AS Date), CAST(N'2023-02-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-09' AS Date), CAST(N'2023-02-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-10' AS Date), CAST(N'2023-02-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-11' AS Date), CAST(N'2023-02-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-12' AS Date), CAST(N'2023-02-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-13' AS Date), CAST(N'2023-02-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-14' AS Date), CAST(N'2023-02-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-15' AS Date), CAST(N'2023-02-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-16' AS Date), CAST(N'2023-02-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-17' AS Date), CAST(N'2023-02-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-18' AS Date), CAST(N'2023-02-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-19' AS Date), CAST(N'2023-02-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-20' AS Date), CAST(N'2023-02-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-21' AS Date), CAST(N'2023-02-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-22' AS Date), CAST(N'2023-02-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-23' AS Date), CAST(N'2023-02-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-24' AS Date), CAST(N'2023-02-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-25' AS Date), CAST(N'2023-02-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-26' AS Date), CAST(N'2023-02-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-27' AS Date), CAST(N'2023-02-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-02-28' AS Date), CAST(N'2023-02-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-01' AS Date), CAST(N'2023-03-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-02' AS Date), CAST(N'2023-03-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-03' AS Date), CAST(N'2023-03-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-04' AS Date), CAST(N'2023-03-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-05' AS Date), CAST(N'2023-03-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-06' AS Date), CAST(N'2023-03-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-07' AS Date), CAST(N'2023-03-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-08' AS Date), CAST(N'2023-03-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-09' AS Date), CAST(N'2023-03-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-10' AS Date), CAST(N'2023-03-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-11' AS Date), CAST(N'2023-03-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-12' AS Date), CAST(N'2023-03-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-13' AS Date), CAST(N'2023-03-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-14' AS Date), CAST(N'2023-03-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-16' AS Date), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-17' AS Date), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-18' AS Date), CAST(N'2023-03-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-19' AS Date), CAST(N'2023-03-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-20' AS Date), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-21' AS Date), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-22' AS Date), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-23' AS Date), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-24' AS Date), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-25' AS Date), CAST(N'2023-03-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-26' AS Date), CAST(N'2023-03-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-27' AS Date), CAST(N'2023-03-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-28' AS Date), CAST(N'2023-03-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-29' AS Date), CAST(N'2023-03-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-30' AS Date), CAST(N'2023-03-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-03-31' AS Date), CAST(N'2023-03-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-01' AS Date), CAST(N'2023-04-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-02' AS Date), CAST(N'2023-04-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-03' AS Date), CAST(N'2023-04-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-04' AS Date), CAST(N'2023-04-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-05' AS Date), CAST(N'2023-04-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-06' AS Date), CAST(N'2023-04-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-07' AS Date), CAST(N'2023-04-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-08' AS Date), CAST(N'2023-04-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-09' AS Date), CAST(N'2023-04-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-10' AS Date), CAST(N'2023-04-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-11' AS Date), CAST(N'2023-04-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-12' AS Date), CAST(N'2023-04-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-13' AS Date), CAST(N'2023-04-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-14' AS Date), CAST(N'2023-04-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-15' AS Date), CAST(N'2023-04-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-16' AS Date), CAST(N'2023-04-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-17' AS Date), CAST(N'2023-04-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-18' AS Date), CAST(N'2023-04-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-19' AS Date), CAST(N'2023-04-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-20' AS Date), CAST(N'2023-04-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-21' AS Date), CAST(N'2023-04-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-22' AS Date), CAST(N'2023-04-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-23' AS Date), CAST(N'2023-04-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-24' AS Date), CAST(N'2023-04-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-25' AS Date), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-26' AS Date), CAST(N'2023-04-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-27' AS Date), CAST(N'2023-04-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-28' AS Date), CAST(N'2023-04-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-29' AS Date), CAST(N'2023-04-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-04-30' AS Date), CAST(N'2023-04-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-01' AS Date), CAST(N'2023-05-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-02' AS Date), CAST(N'2023-05-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-03' AS Date), CAST(N'2023-05-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-04' AS Date), CAST(N'2023-05-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-05' AS Date), CAST(N'2023-05-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-06' AS Date), CAST(N'2023-05-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-07' AS Date), CAST(N'2023-05-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-08' AS Date), CAST(N'2023-05-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-09' AS Date), CAST(N'2023-05-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-10' AS Date), CAST(N'2023-05-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-11' AS Date), CAST(N'2023-05-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-12' AS Date), CAST(N'2023-05-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-13' AS Date), CAST(N'2023-05-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-14' AS Date), CAST(N'2023-05-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-16' AS Date), CAST(N'2023-05-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-17' AS Date), CAST(N'2023-05-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-18' AS Date), CAST(N'2023-05-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-19' AS Date), CAST(N'2023-05-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-20' AS Date), CAST(N'2023-05-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-21' AS Date), CAST(N'2023-05-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-22' AS Date), CAST(N'2023-05-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-23' AS Date), CAST(N'2023-05-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-24' AS Date), CAST(N'2023-05-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-25' AS Date), CAST(N'2023-05-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-26' AS Date), CAST(N'2023-05-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-27' AS Date), CAST(N'2023-05-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-28' AS Date), CAST(N'2023-05-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-29' AS Date), CAST(N'2023-05-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-30' AS Date), CAST(N'2023-05-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-05-31' AS Date), CAST(N'2023-05-31T00:00:00.000' AS DateTime), 31, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-01' AS Date), CAST(N'2023-06-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-02' AS Date), CAST(N'2023-06-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-03' AS Date), CAST(N'2023-06-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-04' AS Date), CAST(N'2023-06-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-05' AS Date), CAST(N'2023-06-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-06' AS Date), CAST(N'2023-06-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-07' AS Date), CAST(N'2023-06-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-08' AS Date), CAST(N'2023-06-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-09' AS Date), CAST(N'2023-06-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-10' AS Date), CAST(N'2023-06-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-11' AS Date), CAST(N'2023-06-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-12' AS Date), CAST(N'2023-06-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-13' AS Date), CAST(N'2023-06-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-14' AS Date), CAST(N'2023-06-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-15' AS Date), CAST(N'2023-06-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-16' AS Date), CAST(N'2023-06-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-17' AS Date), CAST(N'2023-06-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-18' AS Date), CAST(N'2023-06-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-19' AS Date), CAST(N'2023-06-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-20' AS Date), CAST(N'2023-06-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-21' AS Date), CAST(N'2023-06-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-22' AS Date), CAST(N'2023-06-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-23' AS Date), CAST(N'2023-06-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-24' AS Date), CAST(N'2023-06-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-25' AS Date), CAST(N'2023-06-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-26' AS Date), CAST(N'2023-06-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-27' AS Date), CAST(N'2023-06-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-28' AS Date), CAST(N'2023-06-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-29' AS Date), CAST(N'2023-06-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-06-30' AS Date), CAST(N'2023-06-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-01' AS Date), CAST(N'2023-07-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-02' AS Date), CAST(N'2023-07-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-03' AS Date), CAST(N'2023-07-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-04' AS Date), CAST(N'2023-07-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-05' AS Date), CAST(N'2023-07-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-06' AS Date), CAST(N'2023-07-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-07' AS Date), CAST(N'2023-07-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-08' AS Date), CAST(N'2023-07-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-09' AS Date), CAST(N'2023-07-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-10' AS Date), CAST(N'2023-07-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-11' AS Date), CAST(N'2023-07-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-12' AS Date), CAST(N'2023-07-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-13' AS Date), CAST(N'2023-07-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-14' AS Date), CAST(N'2023-07-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-15' AS Date), CAST(N'2023-07-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-16' AS Date), CAST(N'2023-07-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-17' AS Date), CAST(N'2023-07-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-18' AS Date), CAST(N'2023-07-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-19' AS Date), CAST(N'2023-07-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-20' AS Date), CAST(N'2023-07-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-21' AS Date), CAST(N'2023-07-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-22' AS Date), CAST(N'2023-07-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-23' AS Date), CAST(N'2023-07-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-24' AS Date), CAST(N'2023-07-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-25' AS Date), CAST(N'2023-07-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-26' AS Date), CAST(N'2023-07-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-27' AS Date), CAST(N'2023-07-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-28' AS Date), CAST(N'2023-07-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-29' AS Date), CAST(N'2023-07-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-30' AS Date), CAST(N'2023-07-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-07-31' AS Date), CAST(N'2023-07-31T00:00:00.000' AS DateTime), 31, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-01' AS Date), CAST(N'2023-08-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-02' AS Date), CAST(N'2023-08-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-03' AS Date), CAST(N'2023-08-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-04' AS Date), CAST(N'2023-08-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-05' AS Date), CAST(N'2023-08-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-06' AS Date), CAST(N'2023-08-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-07' AS Date), CAST(N'2023-08-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-08' AS Date), CAST(N'2023-08-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-09' AS Date), CAST(N'2023-08-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-10' AS Date), CAST(N'2023-08-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-11' AS Date), CAST(N'2023-08-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-12' AS Date), CAST(N'2023-08-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-13' AS Date), CAST(N'2023-08-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-14' AS Date), CAST(N'2023-08-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-15' AS Date), CAST(N'2023-08-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-16' AS Date), CAST(N'2023-08-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-17' AS Date), CAST(N'2023-08-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-18' AS Date), CAST(N'2023-08-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-19' AS Date), CAST(N'2023-08-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-20' AS Date), CAST(N'2023-08-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-21' AS Date), CAST(N'2023-08-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-22' AS Date), CAST(N'2023-08-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-23' AS Date), CAST(N'2023-08-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-24' AS Date), CAST(N'2023-08-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-25' AS Date), CAST(N'2023-08-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-26' AS Date), CAST(N'2023-08-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-27' AS Date), CAST(N'2023-08-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-28' AS Date), CAST(N'2023-08-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-29' AS Date), CAST(N'2023-08-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-30' AS Date), CAST(N'2023-08-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-08-31' AS Date), CAST(N'2023-08-31T00:00:00.000' AS DateTime), 31, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-01' AS Date), CAST(N'2023-09-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-02' AS Date), CAST(N'2023-09-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-03' AS Date), CAST(N'2023-09-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-04' AS Date), CAST(N'2023-09-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-05' AS Date), CAST(N'2023-09-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-06' AS Date), CAST(N'2023-09-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-07' AS Date), CAST(N'2023-09-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-08' AS Date), CAST(N'2023-09-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-09' AS Date), CAST(N'2023-09-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-10' AS Date), CAST(N'2023-09-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-11' AS Date), CAST(N'2023-09-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-12' AS Date), CAST(N'2023-09-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-13' AS Date), CAST(N'2023-09-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-14' AS Date), CAST(N'2023-09-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-15' AS Date), CAST(N'2023-09-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-16' AS Date), CAST(N'2023-09-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-17' AS Date), CAST(N'2023-09-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-18' AS Date), CAST(N'2023-09-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-19' AS Date), CAST(N'2023-09-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-20' AS Date), CAST(N'2023-09-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-21' AS Date), CAST(N'2023-09-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-22' AS Date), CAST(N'2023-09-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-23' AS Date), CAST(N'2023-09-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-24' AS Date), CAST(N'2023-09-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-25' AS Date), CAST(N'2023-09-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-26' AS Date), CAST(N'2023-09-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-27' AS Date), CAST(N'2023-09-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-28' AS Date), CAST(N'2023-09-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-29' AS Date), CAST(N'2023-09-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-09-30' AS Date), CAST(N'2023-09-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-01' AS Date), CAST(N'2023-10-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-02' AS Date), CAST(N'2023-10-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-03' AS Date), CAST(N'2023-10-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-04' AS Date), CAST(N'2023-10-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-05' AS Date), CAST(N'2023-10-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-06' AS Date), CAST(N'2023-10-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-07' AS Date), CAST(N'2023-10-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-08' AS Date), CAST(N'2023-10-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-09' AS Date), CAST(N'2023-10-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-10' AS Date), CAST(N'2023-10-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-11' AS Date), CAST(N'2023-10-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-12' AS Date), CAST(N'2023-10-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-13' AS Date), CAST(N'2023-10-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-14' AS Date), CAST(N'2023-10-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-15' AS Date), CAST(N'2023-10-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-16' AS Date), CAST(N'2023-10-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-17' AS Date), CAST(N'2023-10-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-18' AS Date), CAST(N'2023-10-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-19' AS Date), CAST(N'2023-10-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-20' AS Date), CAST(N'2023-10-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-21' AS Date), CAST(N'2023-10-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-22' AS Date), CAST(N'2023-10-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-23' AS Date), CAST(N'2023-10-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-24' AS Date), CAST(N'2023-10-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-25' AS Date), CAST(N'2023-10-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-26' AS Date), CAST(N'2023-10-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-27' AS Date), CAST(N'2023-10-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-28' AS Date), CAST(N'2023-10-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-29' AS Date), CAST(N'2023-10-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-30' AS Date), CAST(N'2023-10-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-10-31' AS Date), CAST(N'2023-10-31T00:00:00.000' AS DateTime), 31, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-01' AS Date), CAST(N'2023-11-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-02' AS Date), CAST(N'2023-11-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-04' AS Date), CAST(N'2023-11-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-05' AS Date), CAST(N'2023-11-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-07' AS Date), CAST(N'2023-11-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-08' AS Date), CAST(N'2023-11-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-09' AS Date), CAST(N'2023-11-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-10' AS Date), CAST(N'2023-11-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-11' AS Date), CAST(N'2023-11-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-12' AS Date), CAST(N'2023-11-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-13' AS Date), CAST(N'2023-11-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-14' AS Date), CAST(N'2023-11-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-15' AS Date), CAST(N'2023-11-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-16' AS Date), CAST(N'2023-11-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-17' AS Date), CAST(N'2023-11-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-18' AS Date), CAST(N'2023-11-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-19' AS Date), CAST(N'2023-11-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-21' AS Date), CAST(N'2023-11-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-22' AS Date), CAST(N'2023-11-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-23' AS Date), CAST(N'2023-11-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-24' AS Date), CAST(N'2023-11-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-25' AS Date), CAST(N'2023-11-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-26' AS Date), CAST(N'2023-11-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-27' AS Date), CAST(N'2023-11-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-28' AS Date), CAST(N'2023-11-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-29' AS Date), CAST(N'2023-11-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-11-30' AS Date), CAST(N'2023-11-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-01' AS Date), CAST(N'2023-12-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-02' AS Date), CAST(N'2023-12-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-03' AS Date), CAST(N'2023-12-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-04' AS Date), CAST(N'2023-12-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-05' AS Date), CAST(N'2023-12-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-06' AS Date), CAST(N'2023-12-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-07' AS Date), CAST(N'2023-12-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-09' AS Date), CAST(N'2023-12-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-10' AS Date), CAST(N'2023-12-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-11' AS Date), CAST(N'2023-12-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-12' AS Date), CAST(N'2023-12-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-13' AS Date), CAST(N'2023-12-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-14' AS Date), CAST(N'2023-12-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-15' AS Date), CAST(N'2023-12-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-16' AS Date), CAST(N'2023-12-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-17' AS Date), CAST(N'2023-12-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-18' AS Date), CAST(N'2023-12-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-19' AS Date), CAST(N'2023-12-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-20' AS Date), CAST(N'2023-12-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-21' AS Date), CAST(N'2023-12-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-22' AS Date), CAST(N'2023-12-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-23' AS Date), CAST(N'2023-12-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-24' AS Date), CAST(N'2023-12-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-25' AS Date), CAST(N'2023-12-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-26' AS Date), CAST(N'2023-12-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-27' AS Date), CAST(N'2023-12-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-28' AS Date), CAST(N'2023-12-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-29' AS Date), CAST(N'2023-12-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-30' AS Date), CAST(N'2023-12-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2023-12-31' AS Date), CAST(N'2023-12-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-01' AS Date), CAST(N'2024-01-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-02' AS Date), CAST(N'2024-01-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-03' AS Date), CAST(N'2024-01-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-04' AS Date), CAST(N'2024-01-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-05' AS Date), CAST(N'2024-01-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-06' AS Date), CAST(N'2024-01-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-07' AS Date), CAST(N'2024-01-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-08' AS Date), CAST(N'2024-01-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-09' AS Date), CAST(N'2024-01-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-10' AS Date), CAST(N'2024-01-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-11' AS Date), CAST(N'2024-01-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-12' AS Date), CAST(N'2024-01-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-13' AS Date), CAST(N'2024-01-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-14' AS Date), CAST(N'2024-01-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-15' AS Date), CAST(N'2024-01-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-16' AS Date), CAST(N'2024-01-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-17' AS Date), CAST(N'2024-01-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-18' AS Date), CAST(N'2024-01-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-19' AS Date), CAST(N'2024-01-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-20' AS Date), CAST(N'2024-01-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-21' AS Date), CAST(N'2024-01-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-22' AS Date), CAST(N'2024-01-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-23' AS Date), CAST(N'2024-01-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-24' AS Date), CAST(N'2024-01-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-25' AS Date), CAST(N'2024-01-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-26' AS Date), CAST(N'2024-01-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-27' AS Date), CAST(N'2024-01-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-28' AS Date), CAST(N'2024-01-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-29' AS Date), CAST(N'2024-01-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-30' AS Date), CAST(N'2024-01-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-01-31' AS Date), CAST(N'2024-01-31T00:00:00.000' AS DateTime), 31, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-01' AS Date), CAST(N'2024-02-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-02' AS Date), CAST(N'2024-02-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-03' AS Date), CAST(N'2024-02-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-04' AS Date), CAST(N'2024-02-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-05' AS Date), CAST(N'2024-02-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-06' AS Date), CAST(N'2024-02-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-07' AS Date), CAST(N'2024-02-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-08' AS Date), CAST(N'2024-02-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-09' AS Date), CAST(N'2024-02-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-10' AS Date), CAST(N'2024-02-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-11' AS Date), CAST(N'2024-02-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-12' AS Date), CAST(N'2024-02-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-13' AS Date), CAST(N'2024-02-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-14' AS Date), CAST(N'2024-02-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-15' AS Date), CAST(N'2024-02-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-16' AS Date), CAST(N'2024-02-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-17' AS Date), CAST(N'2024-02-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-18' AS Date), CAST(N'2024-02-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-19' AS Date), CAST(N'2024-02-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-20' AS Date), CAST(N'2024-02-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-21' AS Date), CAST(N'2024-02-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-22' AS Date), CAST(N'2024-02-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-23' AS Date), CAST(N'2024-02-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-24' AS Date), CAST(N'2024-02-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-25' AS Date), CAST(N'2024-02-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-26' AS Date), CAST(N'2024-02-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-27' AS Date), CAST(N'2024-02-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-28' AS Date), CAST(N'2024-02-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-02-29' AS Date), CAST(N'2024-02-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-01' AS Date), CAST(N'2024-03-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-02' AS Date), CAST(N'2024-03-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-03' AS Date), CAST(N'2024-03-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-04' AS Date), CAST(N'2024-03-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-05' AS Date), CAST(N'2024-03-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-06' AS Date), CAST(N'2024-03-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-07' AS Date), CAST(N'2024-03-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-08' AS Date), CAST(N'2024-03-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-09' AS Date), CAST(N'2024-03-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-10' AS Date), CAST(N'2024-03-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-11' AS Date), CAST(N'2024-03-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-12' AS Date), CAST(N'2024-03-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-13' AS Date), CAST(N'2024-03-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-14' AS Date), CAST(N'2024-03-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-15' AS Date), CAST(N'2024-03-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-16' AS Date), CAST(N'2024-03-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-17' AS Date), CAST(N'2024-03-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-18' AS Date), CAST(N'2024-03-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-19' AS Date), CAST(N'2024-03-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-20' AS Date), CAST(N'2024-03-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-21' AS Date), CAST(N'2024-03-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-22' AS Date), CAST(N'2024-03-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-23' AS Date), CAST(N'2024-03-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-24' AS Date), CAST(N'2024-03-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-25' AS Date), CAST(N'2024-03-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-26' AS Date), CAST(N'2024-03-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-27' AS Date), CAST(N'2024-03-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-28' AS Date), CAST(N'2024-03-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-29' AS Date), CAST(N'2024-03-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-30' AS Date), CAST(N'2024-03-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-03-31' AS Date), CAST(N'2024-03-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-01' AS Date), CAST(N'2024-04-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-02' AS Date), CAST(N'2024-04-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-03' AS Date), CAST(N'2024-04-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-04' AS Date), CAST(N'2024-04-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-05' AS Date), CAST(N'2024-04-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-06' AS Date), CAST(N'2024-04-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-07' AS Date), CAST(N'2024-04-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-08' AS Date), CAST(N'2024-04-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-09' AS Date), CAST(N'2024-04-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-10' AS Date), CAST(N'2024-04-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-11' AS Date), CAST(N'2024-04-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-12' AS Date), CAST(N'2024-04-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-13' AS Date), CAST(N'2024-04-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-14' AS Date), CAST(N'2024-04-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-15' AS Date), CAST(N'2024-04-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-16' AS Date), CAST(N'2024-04-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-17' AS Date), CAST(N'2024-04-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-18' AS Date), CAST(N'2024-04-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-19' AS Date), CAST(N'2024-04-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-20' AS Date), CAST(N'2024-04-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-21' AS Date), CAST(N'2024-04-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-22' AS Date), CAST(N'2024-04-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-23' AS Date), CAST(N'2024-04-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-24' AS Date), CAST(N'2024-04-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-25' AS Date), CAST(N'2024-04-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-26' AS Date), CAST(N'2024-04-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-27' AS Date), CAST(N'2024-04-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-28' AS Date), CAST(N'2024-04-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-29' AS Date), CAST(N'2024-04-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-04-30' AS Date), CAST(N'2024-04-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-01' AS Date), CAST(N'2024-05-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-02' AS Date), CAST(N'2024-05-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-03' AS Date), CAST(N'2024-05-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-04' AS Date), CAST(N'2024-05-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-05' AS Date), CAST(N'2024-05-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-06' AS Date), CAST(N'2024-05-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-07' AS Date), CAST(N'2024-05-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-08' AS Date), CAST(N'2024-05-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-09' AS Date), CAST(N'2024-05-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-10' AS Date), CAST(N'2024-05-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-11' AS Date), CAST(N'2024-05-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-12' AS Date), CAST(N'2024-05-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-13' AS Date), CAST(N'2024-05-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-14' AS Date), CAST(N'2024-05-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-15' AS Date), CAST(N'2024-05-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-16' AS Date), CAST(N'2024-05-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-17' AS Date), CAST(N'2024-05-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-18' AS Date), CAST(N'2024-05-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-19' AS Date), CAST(N'2024-05-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-20' AS Date), CAST(N'2024-05-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-22' AS Date), CAST(N'2024-05-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-26' AS Date), CAST(N'2024-05-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-27' AS Date), CAST(N'2024-05-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-28' AS Date), CAST(N'2024-05-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-29' AS Date), CAST(N'2024-05-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-30' AS Date), CAST(N'2024-05-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-05-31' AS Date), CAST(N'2024-05-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-01' AS Date), CAST(N'2024-06-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-02' AS Date), CAST(N'2024-06-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-03' AS Date), CAST(N'2024-06-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-04' AS Date), CAST(N'2024-06-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-05' AS Date), CAST(N'2024-06-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-06' AS Date), CAST(N'2024-06-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-07' AS Date), CAST(N'2024-06-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-08' AS Date), CAST(N'2024-06-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-10' AS Date), CAST(N'2024-06-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-11' AS Date), CAST(N'2024-06-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-12' AS Date), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-13' AS Date), CAST(N'2024-06-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-14' AS Date), CAST(N'2024-06-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-15' AS Date), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-16' AS Date), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-17' AS Date), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-18' AS Date), CAST(N'2024-06-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-19' AS Date), CAST(N'2024-06-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-20' AS Date), CAST(N'2024-06-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-21' AS Date), CAST(N'2024-06-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-22' AS Date), CAST(N'2024-06-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-23' AS Date), CAST(N'2024-06-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-24' AS Date), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-25' AS Date), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-26' AS Date), CAST(N'2024-06-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-27' AS Date), CAST(N'2024-06-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-28' AS Date), CAST(N'2024-06-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-29' AS Date), CAST(N'2024-06-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-06-30' AS Date), CAST(N'2024-06-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-01' AS Date), CAST(N'2024-07-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-02' AS Date), CAST(N'2024-07-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-03' AS Date), CAST(N'2024-07-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-04' AS Date), CAST(N'2024-07-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-05' AS Date), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-06' AS Date), CAST(N'2024-07-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-07' AS Date), CAST(N'2024-07-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-08' AS Date), CAST(N'2024-07-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-09' AS Date), CAST(N'2024-07-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-10' AS Date), CAST(N'2024-07-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-11' AS Date), CAST(N'2024-07-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-12' AS Date), CAST(N'2024-07-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-13' AS Date), CAST(N'2024-07-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-14' AS Date), CAST(N'2024-07-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-15' AS Date), CAST(N'2024-07-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-16' AS Date), CAST(N'2024-07-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-17' AS Date), CAST(N'2024-07-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-18' AS Date), CAST(N'2024-07-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-19' AS Date), CAST(N'2024-07-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-20' AS Date), CAST(N'2024-07-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-21' AS Date), CAST(N'2024-07-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-22' AS Date), CAST(N'2024-07-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-23' AS Date), CAST(N'2024-07-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-24' AS Date), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-25' AS Date), CAST(N'2024-07-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-26' AS Date), CAST(N'2024-07-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-27' AS Date), CAST(N'2024-07-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-28' AS Date), CAST(N'2024-07-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-29' AS Date), CAST(N'2024-07-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-30' AS Date), CAST(N'2024-07-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-07-31' AS Date), CAST(N'2024-07-31T00:00:00.000' AS DateTime), 31, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-01' AS Date), CAST(N'2024-08-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-02' AS Date), CAST(N'2024-08-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-03' AS Date), CAST(N'2024-08-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-04' AS Date), CAST(N'2024-08-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-05' AS Date), CAST(N'2024-08-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-06' AS Date), CAST(N'2024-08-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-07' AS Date), CAST(N'2024-08-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-08' AS Date), CAST(N'2024-08-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-09' AS Date), CAST(N'2024-08-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-10' AS Date), CAST(N'2024-08-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-11' AS Date), CAST(N'2024-08-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-12' AS Date), CAST(N'2024-08-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-13' AS Date), CAST(N'2024-08-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-14' AS Date), CAST(N'2024-08-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-15' AS Date), CAST(N'2024-08-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-16' AS Date), CAST(N'2024-08-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-17' AS Date), CAST(N'2024-08-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-18' AS Date), CAST(N'2024-08-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-19' AS Date), CAST(N'2024-08-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-20' AS Date), CAST(N'2024-08-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-21' AS Date), CAST(N'2024-08-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-22' AS Date), CAST(N'2024-08-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-23' AS Date), CAST(N'2024-08-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-24' AS Date), CAST(N'2024-08-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-25' AS Date), CAST(N'2024-08-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-26' AS Date), CAST(N'2024-08-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-27' AS Date), CAST(N'2024-08-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-28' AS Date), CAST(N'2024-08-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-29' AS Date), CAST(N'2024-08-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-30' AS Date), CAST(N'2024-08-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-08-31' AS Date), CAST(N'2024-08-31T00:00:00.000' AS DateTime), 31, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-01' AS Date), CAST(N'2024-09-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-02' AS Date), CAST(N'2024-09-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-03' AS Date), CAST(N'2024-09-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-04' AS Date), CAST(N'2024-09-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-05' AS Date), CAST(N'2024-09-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-06' AS Date), CAST(N'2024-09-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-07' AS Date), CAST(N'2024-09-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-08' AS Date), CAST(N'2024-09-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-09' AS Date), CAST(N'2024-09-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-10' AS Date), CAST(N'2024-09-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-11' AS Date), CAST(N'2024-09-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-12' AS Date), CAST(N'2024-09-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-14' AS Date), CAST(N'2024-09-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-15' AS Date), CAST(N'2024-09-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-16' AS Date), CAST(N'2024-09-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-17' AS Date), CAST(N'2024-09-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-18' AS Date), CAST(N'2024-09-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-19' AS Date), CAST(N'2024-09-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-20' AS Date), CAST(N'2024-09-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-21' AS Date), CAST(N'2024-09-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-22' AS Date), CAST(N'2024-09-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-23' AS Date), CAST(N'2024-09-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-24' AS Date), CAST(N'2024-09-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-25' AS Date), CAST(N'2024-09-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-26' AS Date), CAST(N'2024-09-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-27' AS Date), CAST(N'2024-09-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-28' AS Date), CAST(N'2024-09-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-29' AS Date), CAST(N'2024-09-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-09-30' AS Date), CAST(N'2024-09-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-01' AS Date), CAST(N'2024-10-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-02' AS Date), CAST(N'2024-10-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-03' AS Date), CAST(N'2024-10-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-04' AS Date), CAST(N'2024-10-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-05' AS Date), CAST(N'2024-10-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-06' AS Date), CAST(N'2024-10-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-07' AS Date), CAST(N'2024-10-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-08' AS Date), CAST(N'2024-10-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-09' AS Date), CAST(N'2024-10-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-10' AS Date), CAST(N'2024-10-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-11' AS Date), CAST(N'2024-10-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-12' AS Date), CAST(N'2024-10-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-13' AS Date), CAST(N'2024-10-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-14' AS Date), CAST(N'2024-10-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-16' AS Date), CAST(N'2024-10-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-17' AS Date), CAST(N'2024-10-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-18' AS Date), CAST(N'2024-10-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-19' AS Date), CAST(N'2024-10-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-20' AS Date), CAST(N'2024-10-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-21' AS Date), CAST(N'2024-10-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-22' AS Date), CAST(N'2024-10-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-23' AS Date), CAST(N'2024-10-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-24' AS Date), CAST(N'2024-10-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-25' AS Date), CAST(N'2024-10-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-26' AS Date), CAST(N'2024-10-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-27' AS Date), CAST(N'2024-10-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-28' AS Date), CAST(N'2024-10-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-29' AS Date), CAST(N'2024-10-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-30' AS Date), CAST(N'2024-10-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-10-31' AS Date), CAST(N'2024-10-31T00:00:00.000' AS DateTime), 31, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-01' AS Date), CAST(N'2024-11-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-02' AS Date), CAST(N'2024-11-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-03' AS Date), CAST(N'2024-11-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-04' AS Date), CAST(N'2024-11-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-05' AS Date), CAST(N'2024-11-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-06' AS Date), CAST(N'2024-11-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-07' AS Date), CAST(N'2024-11-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-08' AS Date), CAST(N'2024-11-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-09' AS Date), CAST(N'2024-11-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-10' AS Date), CAST(N'2024-11-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-11' AS Date), CAST(N'2024-11-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-12' AS Date), CAST(N'2024-11-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-13' AS Date), CAST(N'2024-11-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-14' AS Date), CAST(N'2024-11-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-15' AS Date), CAST(N'2024-11-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-16' AS Date), CAST(N'2024-11-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-17' AS Date), CAST(N'2024-11-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-18' AS Date), CAST(N'2024-11-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-19' AS Date), CAST(N'2024-11-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-20' AS Date), CAST(N'2024-11-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-21' AS Date), CAST(N'2024-11-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-22' AS Date), CAST(N'2024-11-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-23' AS Date), CAST(N'2024-11-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-24' AS Date), CAST(N'2024-11-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-25' AS Date), CAST(N'2024-11-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-26' AS Date), CAST(N'2024-11-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-27' AS Date), CAST(N'2024-11-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-28' AS Date), CAST(N'2024-11-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-29' AS Date), CAST(N'2024-11-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-11-30' AS Date), CAST(N'2024-11-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-01' AS Date), CAST(N'2024-12-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-02' AS Date), CAST(N'2024-12-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-03' AS Date), CAST(N'2024-12-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-04' AS Date), CAST(N'2024-12-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-05' AS Date), CAST(N'2024-12-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-06' AS Date), CAST(N'2024-12-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-07' AS Date), CAST(N'2024-12-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-08' AS Date), CAST(N'2024-12-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-09' AS Date), CAST(N'2024-12-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-10' AS Date), CAST(N'2024-12-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-11' AS Date), CAST(N'2024-12-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-12' AS Date), CAST(N'2024-12-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-13' AS Date), CAST(N'2024-12-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-14' AS Date), CAST(N'2024-12-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-15' AS Date), CAST(N'2024-12-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-16' AS Date), CAST(N'2024-12-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-17' AS Date), CAST(N'2024-12-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-18' AS Date), CAST(N'2024-12-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-19' AS Date), CAST(N'2024-12-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-20' AS Date), CAST(N'2024-12-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-21' AS Date), CAST(N'2024-12-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-22' AS Date), CAST(N'2024-12-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-23' AS Date), CAST(N'2024-12-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-24' AS Date), CAST(N'2024-12-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-25' AS Date), CAST(N'2024-12-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-26' AS Date), CAST(N'2024-12-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-27' AS Date), CAST(N'2024-12-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-28' AS Date), CAST(N'2024-12-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-29' AS Date), CAST(N'2024-12-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-30' AS Date), CAST(N'2024-12-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2024-12-31' AS Date), CAST(N'2024-12-31T00:00:00.000' AS DateTime), 31, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-01' AS Date), CAST(N'2025-01-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-02' AS Date), CAST(N'2025-01-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-03' AS Date), CAST(N'2025-01-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-04' AS Date), CAST(N'2025-01-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-05' AS Date), CAST(N'2025-01-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-06' AS Date), CAST(N'2025-01-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-07' AS Date), CAST(N'2025-01-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-08' AS Date), CAST(N'2025-01-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-09' AS Date), CAST(N'2025-01-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-10' AS Date), CAST(N'2025-01-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-11' AS Date), CAST(N'2025-01-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-12' AS Date), CAST(N'2025-01-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-13' AS Date), CAST(N'2025-01-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-14' AS Date), CAST(N'2025-01-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-15' AS Date), CAST(N'2025-01-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-16' AS Date), CAST(N'2025-01-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-17' AS Date), CAST(N'2025-01-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-18' AS Date), CAST(N'2025-01-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-19' AS Date), CAST(N'2025-01-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-20' AS Date), CAST(N'2025-01-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-21' AS Date), CAST(N'2025-01-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-22' AS Date), CAST(N'2025-01-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-23' AS Date), CAST(N'2025-01-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-24' AS Date), CAST(N'2025-01-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-25' AS Date), CAST(N'2025-01-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-26' AS Date), CAST(N'2025-01-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-27' AS Date), CAST(N'2025-01-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-28' AS Date), CAST(N'2025-01-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-29' AS Date), CAST(N'2025-01-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-30' AS Date), CAST(N'2025-01-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-01-31' AS Date), CAST(N'2025-01-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-01' AS Date), CAST(N'2025-02-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-02' AS Date), CAST(N'2025-02-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-03' AS Date), CAST(N'2025-02-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-04' AS Date), CAST(N'2025-02-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-05' AS Date), CAST(N'2025-02-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-06' AS Date), CAST(N'2025-02-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-07' AS Date), CAST(N'2025-02-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-08' AS Date), CAST(N'2025-02-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-09' AS Date), CAST(N'2025-02-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-10' AS Date), CAST(N'2025-02-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-11' AS Date), CAST(N'2025-02-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-12' AS Date), CAST(N'2025-02-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-13' AS Date), CAST(N'2025-02-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-14' AS Date), CAST(N'2025-02-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-15' AS Date), CAST(N'2025-02-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-16' AS Date), CAST(N'2025-02-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-17' AS Date), CAST(N'2025-02-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-18' AS Date), CAST(N'2025-02-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-19' AS Date), CAST(N'2025-02-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-20' AS Date), CAST(N'2025-02-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-21' AS Date), CAST(N'2025-02-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-22' AS Date), CAST(N'2025-02-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-23' AS Date), CAST(N'2025-02-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-24' AS Date), CAST(N'2025-02-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-25' AS Date), CAST(N'2025-02-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-26' AS Date), CAST(N'2025-02-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-27' AS Date), CAST(N'2025-02-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-02-28' AS Date), CAST(N'2025-02-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-01' AS Date), CAST(N'2025-03-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-02' AS Date), CAST(N'2025-03-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-03' AS Date), CAST(N'2025-03-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-04' AS Date), CAST(N'2025-03-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-05' AS Date), CAST(N'2025-03-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-06' AS Date), CAST(N'2025-03-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-07' AS Date), CAST(N'2025-03-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-08' AS Date), CAST(N'2025-03-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-09' AS Date), CAST(N'2025-03-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-10' AS Date), CAST(N'2025-03-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-11' AS Date), CAST(N'2025-03-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-12' AS Date), CAST(N'2025-03-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-13' AS Date), CAST(N'2025-03-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-14' AS Date), CAST(N'2025-03-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-15' AS Date), CAST(N'2025-03-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-16' AS Date), CAST(N'2025-03-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-17' AS Date), CAST(N'2025-03-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-18' AS Date), CAST(N'2025-03-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-19' AS Date), CAST(N'2025-03-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-20' AS Date), CAST(N'2025-03-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-21' AS Date), CAST(N'2025-03-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-22' AS Date), CAST(N'2025-03-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-23' AS Date), CAST(N'2025-03-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-24' AS Date), CAST(N'2025-03-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-25' AS Date), CAST(N'2025-03-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-26' AS Date), CAST(N'2025-03-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-27' AS Date), CAST(N'2025-03-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-28' AS Date), CAST(N'2025-03-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-29' AS Date), CAST(N'2025-03-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-30' AS Date), CAST(N'2025-03-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-03-31' AS Date), CAST(N'2025-03-31T00:00:00.000' AS DateTime), 31, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-01' AS Date), CAST(N'2025-04-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-02' AS Date), CAST(N'2025-04-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-03' AS Date), CAST(N'2025-04-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-04' AS Date), CAST(N'2025-04-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-05' AS Date), CAST(N'2025-04-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-06' AS Date), CAST(N'2025-04-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-07' AS Date), CAST(N'2025-04-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-08' AS Date), CAST(N'2025-04-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-09' AS Date), CAST(N'2025-04-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-10' AS Date), CAST(N'2025-04-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-11' AS Date), CAST(N'2025-04-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-12' AS Date), CAST(N'2025-04-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-13' AS Date), CAST(N'2025-04-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-14' AS Date), CAST(N'2025-04-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-15' AS Date), CAST(N'2025-04-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-16' AS Date), CAST(N'2025-04-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-17' AS Date), CAST(N'2025-04-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-18' AS Date), CAST(N'2025-04-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-19' AS Date), CAST(N'2025-04-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-20' AS Date), CAST(N'2025-04-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-21' AS Date), CAST(N'2025-04-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-22' AS Date), CAST(N'2025-04-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-23' AS Date), CAST(N'2025-04-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-24' AS Date), CAST(N'2025-04-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-25' AS Date), CAST(N'2025-04-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-26' AS Date), CAST(N'2025-04-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-27' AS Date), CAST(N'2025-04-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-28' AS Date), CAST(N'2025-04-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-29' AS Date), CAST(N'2025-04-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-04-30' AS Date), CAST(N'2025-04-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-01' AS Date), CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-02' AS Date), CAST(N'2025-05-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-03' AS Date), CAST(N'2025-05-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-04' AS Date), CAST(N'2025-05-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-05' AS Date), CAST(N'2025-05-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-06' AS Date), CAST(N'2025-05-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-07' AS Date), CAST(N'2025-05-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-08' AS Date), CAST(N'2025-05-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-09' AS Date), CAST(N'2025-05-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-10' AS Date), CAST(N'2025-05-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-11' AS Date), CAST(N'2025-05-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-12' AS Date), CAST(N'2025-05-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-13' AS Date), CAST(N'2025-05-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-14' AS Date), CAST(N'2025-05-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-15' AS Date), CAST(N'2025-05-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-16' AS Date), CAST(N'2025-05-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-17' AS Date), CAST(N'2025-05-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-18' AS Date), CAST(N'2025-05-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-19' AS Date), CAST(N'2025-05-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-20' AS Date), CAST(N'2025-05-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-21' AS Date), CAST(N'2025-05-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-22' AS Date), CAST(N'2025-05-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-23' AS Date), CAST(N'2025-05-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-24' AS Date), CAST(N'2025-05-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-25' AS Date), CAST(N'2025-05-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-26' AS Date), CAST(N'2025-05-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-27' AS Date), CAST(N'2025-05-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-28' AS Date), CAST(N'2025-05-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-29' AS Date), CAST(N'2025-05-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-30' AS Date), CAST(N'2025-05-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-05-31' AS Date), CAST(N'2025-05-31T00:00:00.000' AS DateTime), 31, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-01' AS Date), CAST(N'2025-06-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-02' AS Date), CAST(N'2025-06-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-03' AS Date), CAST(N'2025-06-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-04' AS Date), CAST(N'2025-06-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-05' AS Date), CAST(N'2025-06-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-06' AS Date), CAST(N'2025-06-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-07' AS Date), CAST(N'2025-06-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-08' AS Date), CAST(N'2025-06-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-09' AS Date), CAST(N'2025-06-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-10' AS Date), CAST(N'2025-06-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-11' AS Date), CAST(N'2025-06-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-12' AS Date), CAST(N'2025-06-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-14' AS Date), CAST(N'2025-06-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-15' AS Date), CAST(N'2025-06-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-16' AS Date), CAST(N'2025-06-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-17' AS Date), CAST(N'2025-06-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-18' AS Date), CAST(N'2025-06-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-19' AS Date), CAST(N'2025-06-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-20' AS Date), CAST(N'2025-06-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-21' AS Date), CAST(N'2025-06-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-22' AS Date), CAST(N'2025-06-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-23' AS Date), CAST(N'2025-06-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-24' AS Date), CAST(N'2025-06-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-25' AS Date), CAST(N'2025-06-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-26' AS Date), CAST(N'2025-06-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-27' AS Date), CAST(N'2025-06-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-28' AS Date), CAST(N'2025-06-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-29' AS Date), CAST(N'2025-06-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-06-30' AS Date), CAST(N'2025-06-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-01' AS Date), CAST(N'2025-07-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-02' AS Date), CAST(N'2025-07-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-03' AS Date), CAST(N'2025-07-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-04' AS Date), CAST(N'2025-07-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-05' AS Date), CAST(N'2025-07-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-06' AS Date), CAST(N'2025-07-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-07' AS Date), CAST(N'2025-07-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-08' AS Date), CAST(N'2025-07-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-09' AS Date), CAST(N'2025-07-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-10' AS Date), CAST(N'2025-07-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-11' AS Date), CAST(N'2025-07-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-12' AS Date), CAST(N'2025-07-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-13' AS Date), CAST(N'2025-07-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-14' AS Date), CAST(N'2025-07-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-15' AS Date), CAST(N'2025-07-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-16' AS Date), CAST(N'2025-07-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-17' AS Date), CAST(N'2025-07-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-18' AS Date), CAST(N'2025-07-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-19' AS Date), CAST(N'2025-07-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-20' AS Date), CAST(N'2025-07-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-21' AS Date), CAST(N'2025-07-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-22' AS Date), CAST(N'2025-07-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-23' AS Date), CAST(N'2025-07-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-24' AS Date), CAST(N'2025-07-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-25' AS Date), CAST(N'2025-07-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-26' AS Date), CAST(N'2025-07-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-27' AS Date), CAST(N'2025-07-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-28' AS Date), CAST(N'2025-07-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-29' AS Date), CAST(N'2025-07-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-30' AS Date), CAST(N'2025-07-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-07-31' AS Date), CAST(N'2025-07-31T00:00:00.000' AS DateTime), 31, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-01' AS Date), CAST(N'2025-08-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-02' AS Date), CAST(N'2025-08-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-03' AS Date), CAST(N'2025-08-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-04' AS Date), CAST(N'2025-08-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-05' AS Date), CAST(N'2025-08-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-06' AS Date), CAST(N'2025-08-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-07' AS Date), CAST(N'2025-08-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-08' AS Date), CAST(N'2025-08-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-09' AS Date), CAST(N'2025-08-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-10' AS Date), CAST(N'2025-08-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-11' AS Date), CAST(N'2025-08-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-12' AS Date), CAST(N'2025-08-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-13' AS Date), CAST(N'2025-08-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-14' AS Date), CAST(N'2025-08-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-15' AS Date), CAST(N'2025-08-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-16' AS Date), CAST(N'2025-08-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-17' AS Date), CAST(N'2025-08-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-18' AS Date), CAST(N'2025-08-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-19' AS Date), CAST(N'2025-08-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-20' AS Date), CAST(N'2025-08-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-21' AS Date), CAST(N'2025-08-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-22' AS Date), CAST(N'2025-08-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-23' AS Date), CAST(N'2025-08-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-24' AS Date), CAST(N'2025-08-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-25' AS Date), CAST(N'2025-08-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-26' AS Date), CAST(N'2025-08-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-27' AS Date), CAST(N'2025-08-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-28' AS Date), CAST(N'2025-08-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-29' AS Date), CAST(N'2025-08-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-30' AS Date), CAST(N'2025-08-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-08-31' AS Date), CAST(N'2025-08-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-01' AS Date), CAST(N'2025-09-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-02' AS Date), CAST(N'2025-09-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-03' AS Date), CAST(N'2025-09-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-04' AS Date), CAST(N'2025-09-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-05' AS Date), CAST(N'2025-09-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-06' AS Date), CAST(N'2025-09-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-07' AS Date), CAST(N'2025-09-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-08' AS Date), CAST(N'2025-09-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-09' AS Date), CAST(N'2025-09-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-10' AS Date), CAST(N'2025-09-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-11' AS Date), CAST(N'2025-09-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-12' AS Date), CAST(N'2025-09-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-13' AS Date), CAST(N'2025-09-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-14' AS Date), CAST(N'2025-09-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-15' AS Date), CAST(N'2025-09-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-16' AS Date), CAST(N'2025-09-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-17' AS Date), CAST(N'2025-09-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-18' AS Date), CAST(N'2025-09-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-19' AS Date), CAST(N'2025-09-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-20' AS Date), CAST(N'2025-09-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-21' AS Date), CAST(N'2025-09-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-22' AS Date), CAST(N'2025-09-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-23' AS Date), CAST(N'2025-09-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-24' AS Date), CAST(N'2025-09-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-25' AS Date), CAST(N'2025-09-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-26' AS Date), CAST(N'2025-09-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-27' AS Date), CAST(N'2025-09-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-28' AS Date), CAST(N'2025-09-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-29' AS Date), CAST(N'2025-09-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-09-30' AS Date), CAST(N'2025-09-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-01' AS Date), CAST(N'2025-10-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-02' AS Date), CAST(N'2025-10-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-03' AS Date), CAST(N'2025-10-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-04' AS Date), CAST(N'2025-10-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-05' AS Date), CAST(N'2025-10-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-06' AS Date), CAST(N'2025-10-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-07' AS Date), CAST(N'2025-10-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-08' AS Date), CAST(N'2025-10-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-09' AS Date), CAST(N'2025-10-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-10' AS Date), CAST(N'2025-10-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-11' AS Date), CAST(N'2025-10-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-12' AS Date), CAST(N'2025-10-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-13' AS Date), CAST(N'2025-10-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-14' AS Date), CAST(N'2025-10-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-15' AS Date), CAST(N'2025-10-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-16' AS Date), CAST(N'2025-10-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-17' AS Date), CAST(N'2025-10-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-18' AS Date), CAST(N'2025-10-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-19' AS Date), CAST(N'2025-10-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-20' AS Date), CAST(N'2025-10-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-21' AS Date), CAST(N'2025-10-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-22' AS Date), CAST(N'2025-10-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-23' AS Date), CAST(N'2025-10-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-24' AS Date), CAST(N'2025-10-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-25' AS Date), CAST(N'2025-10-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-26' AS Date), CAST(N'2025-10-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-27' AS Date), CAST(N'2025-10-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-28' AS Date), CAST(N'2025-10-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-29' AS Date), CAST(N'2025-10-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-30' AS Date), CAST(N'2025-10-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-10-31' AS Date), CAST(N'2025-10-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-01' AS Date), CAST(N'2025-11-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-02' AS Date), CAST(N'2025-11-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-03' AS Date), CAST(N'2025-11-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-04' AS Date), CAST(N'2025-11-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-05' AS Date), CAST(N'2025-11-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-06' AS Date), CAST(N'2025-11-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-07' AS Date), CAST(N'2025-11-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-08' AS Date), CAST(N'2025-11-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-09' AS Date), CAST(N'2025-11-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-10' AS Date), CAST(N'2025-11-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-11' AS Date), CAST(N'2025-11-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-12' AS Date), CAST(N'2025-11-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-13' AS Date), CAST(N'2025-11-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-14' AS Date), CAST(N'2025-11-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-15' AS Date), CAST(N'2025-11-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-16' AS Date), CAST(N'2025-11-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-17' AS Date), CAST(N'2025-11-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-18' AS Date), CAST(N'2025-11-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-19' AS Date), CAST(N'2025-11-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-20' AS Date), CAST(N'2025-11-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-21' AS Date), CAST(N'2025-11-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-22' AS Date), CAST(N'2025-11-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-23' AS Date), CAST(N'2025-11-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-24' AS Date), CAST(N'2025-11-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-25' AS Date), CAST(N'2025-11-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-26' AS Date), CAST(N'2025-11-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-27' AS Date), CAST(N'2025-11-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-28' AS Date), CAST(N'2025-11-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-29' AS Date), CAST(N'2025-11-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-11-30' AS Date), CAST(N'2025-11-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-01' AS Date), CAST(N'2025-12-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-02' AS Date), CAST(N'2025-12-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-03' AS Date), CAST(N'2025-12-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-04' AS Date), CAST(N'2025-12-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-05' AS Date), CAST(N'2025-12-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-06' AS Date), CAST(N'2025-12-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-07' AS Date), CAST(N'2025-12-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-08' AS Date), CAST(N'2025-12-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-09' AS Date), CAST(N'2025-12-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-10' AS Date), CAST(N'2025-12-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-11' AS Date), CAST(N'2025-12-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-12' AS Date), CAST(N'2025-12-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-13' AS Date), CAST(N'2025-12-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-14' AS Date), CAST(N'2025-12-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-15' AS Date), CAST(N'2025-12-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-16' AS Date), CAST(N'2025-12-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-17' AS Date), CAST(N'2025-12-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-18' AS Date), CAST(N'2025-12-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-19' AS Date), CAST(N'2025-12-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-20' AS Date), CAST(N'2025-12-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-21' AS Date), CAST(N'2025-12-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-22' AS Date), CAST(N'2025-12-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-23' AS Date), CAST(N'2025-12-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-24' AS Date), CAST(N'2025-12-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-25' AS Date), CAST(N'2025-12-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-26' AS Date), CAST(N'2025-12-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-27' AS Date), CAST(N'2025-12-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-28' AS Date), CAST(N'2025-12-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-29' AS Date), CAST(N'2025-12-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-30' AS Date), CAST(N'2025-12-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2025-12-31' AS Date), CAST(N'2025-12-31T00:00:00.000' AS DateTime), 31, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-01' AS Date), CAST(N'2026-01-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-02' AS Date), CAST(N'2026-01-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-03' AS Date), CAST(N'2026-01-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-04' AS Date), CAST(N'2026-01-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-05' AS Date), CAST(N'2026-01-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-06' AS Date), CAST(N'2026-01-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-07' AS Date), CAST(N'2026-01-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-08' AS Date), CAST(N'2026-01-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-09' AS Date), CAST(N'2026-01-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-10' AS Date), CAST(N'2026-01-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-11' AS Date), CAST(N'2026-01-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-12' AS Date), CAST(N'2026-01-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-13' AS Date), CAST(N'2026-01-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-14' AS Date), CAST(N'2026-01-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-15' AS Date), CAST(N'2026-01-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-16' AS Date), CAST(N'2026-01-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-17' AS Date), CAST(N'2026-01-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-18' AS Date), CAST(N'2026-01-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-19' AS Date), CAST(N'2026-01-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-20' AS Date), CAST(N'2026-01-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-21' AS Date), CAST(N'2026-01-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-22' AS Date), CAST(N'2026-01-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-23' AS Date), CAST(N'2026-01-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-24' AS Date), CAST(N'2026-01-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-25' AS Date), CAST(N'2026-01-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-26' AS Date), CAST(N'2026-01-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-27' AS Date), CAST(N'2026-01-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-28' AS Date), CAST(N'2026-01-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-29' AS Date), CAST(N'2026-01-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-30' AS Date), CAST(N'2026-01-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-01-31' AS Date), CAST(N'2026-01-31T00:00:00.000' AS DateTime), 31, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-01' AS Date), CAST(N'2026-02-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-02' AS Date), CAST(N'2026-02-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-03' AS Date), CAST(N'2026-02-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-04' AS Date), CAST(N'2026-02-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-05' AS Date), CAST(N'2026-02-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-06' AS Date), CAST(N'2026-02-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-07' AS Date), CAST(N'2026-02-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-08' AS Date), CAST(N'2026-02-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-09' AS Date), CAST(N'2026-02-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-10' AS Date), CAST(N'2026-02-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-11' AS Date), CAST(N'2026-02-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-12' AS Date), CAST(N'2026-02-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-13' AS Date), CAST(N'2026-02-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-14' AS Date), CAST(N'2026-02-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-15' AS Date), CAST(N'2026-02-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-16' AS Date), CAST(N'2026-02-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-17' AS Date), CAST(N'2026-02-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-18' AS Date), CAST(N'2026-02-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-19' AS Date), CAST(N'2026-02-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-20' AS Date), CAST(N'2026-02-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-21' AS Date), CAST(N'2026-02-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-22' AS Date), CAST(N'2026-02-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-23' AS Date), CAST(N'2026-02-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-24' AS Date), CAST(N'2026-02-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-25' AS Date), CAST(N'2026-02-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-26' AS Date), CAST(N'2026-02-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-27' AS Date), CAST(N'2026-02-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-02-28' AS Date), CAST(N'2026-02-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-01' AS Date), CAST(N'2026-03-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-02' AS Date), CAST(N'2026-03-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-03' AS Date), CAST(N'2026-03-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-04' AS Date), CAST(N'2026-03-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-05' AS Date), CAST(N'2026-03-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-06' AS Date), CAST(N'2026-03-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-07' AS Date), CAST(N'2026-03-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-08' AS Date), CAST(N'2026-03-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-09' AS Date), CAST(N'2026-03-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-10' AS Date), CAST(N'2026-03-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-11' AS Date), CAST(N'2026-03-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-12' AS Date), CAST(N'2026-03-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-13' AS Date), CAST(N'2026-03-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-14' AS Date), CAST(N'2026-03-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-15' AS Date), CAST(N'2026-03-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-16' AS Date), CAST(N'2026-03-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-17' AS Date), CAST(N'2026-03-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-18' AS Date), CAST(N'2026-03-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-19' AS Date), CAST(N'2026-03-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-20' AS Date), CAST(N'2026-03-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-21' AS Date), CAST(N'2026-03-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-22' AS Date), CAST(N'2026-03-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-23' AS Date), CAST(N'2026-03-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-24' AS Date), CAST(N'2026-03-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-25' AS Date), CAST(N'2026-03-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-26' AS Date), CAST(N'2026-03-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-27' AS Date), CAST(N'2026-03-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-28' AS Date), CAST(N'2026-03-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-29' AS Date), CAST(N'2026-03-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-30' AS Date), CAST(N'2026-03-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-03-31' AS Date), CAST(N'2026-03-31T00:00:00.000' AS DateTime), 31, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-01' AS Date), CAST(N'2026-04-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-02' AS Date), CAST(N'2026-04-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-03' AS Date), CAST(N'2026-04-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-04' AS Date), CAST(N'2026-04-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-05' AS Date), CAST(N'2026-04-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-06' AS Date), CAST(N'2026-04-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-07' AS Date), CAST(N'2026-04-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-08' AS Date), CAST(N'2026-04-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-09' AS Date), CAST(N'2026-04-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-10' AS Date), CAST(N'2026-04-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-11' AS Date), CAST(N'2026-04-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-12' AS Date), CAST(N'2026-04-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-13' AS Date), CAST(N'2026-04-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-14' AS Date), CAST(N'2026-04-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-15' AS Date), CAST(N'2026-04-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-16' AS Date), CAST(N'2026-04-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-17' AS Date), CAST(N'2026-04-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-18' AS Date), CAST(N'2026-04-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-19' AS Date), CAST(N'2026-04-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-20' AS Date), CAST(N'2026-04-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-21' AS Date), CAST(N'2026-04-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-22' AS Date), CAST(N'2026-04-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-23' AS Date), CAST(N'2026-04-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-24' AS Date), CAST(N'2026-04-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-25' AS Date), CAST(N'2026-04-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-26' AS Date), CAST(N'2026-04-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-27' AS Date), CAST(N'2026-04-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-28' AS Date), CAST(N'2026-04-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-29' AS Date), CAST(N'2026-04-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-04-30' AS Date), CAST(N'2026-04-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-01' AS Date), CAST(N'2026-05-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-02' AS Date), CAST(N'2026-05-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-03' AS Date), CAST(N'2026-05-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-04' AS Date), CAST(N'2026-05-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-05' AS Date), CAST(N'2026-05-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-06' AS Date), CAST(N'2026-05-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-07' AS Date), CAST(N'2026-05-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-08' AS Date), CAST(N'2026-05-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-09' AS Date), CAST(N'2026-05-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-10' AS Date), CAST(N'2026-05-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-11' AS Date), CAST(N'2026-05-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-12' AS Date), CAST(N'2026-05-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-13' AS Date), CAST(N'2026-05-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-14' AS Date), CAST(N'2026-05-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-15' AS Date), CAST(N'2026-05-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-16' AS Date), CAST(N'2026-05-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-17' AS Date), CAST(N'2026-05-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-18' AS Date), CAST(N'2026-05-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-19' AS Date), CAST(N'2026-05-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-20' AS Date), CAST(N'2026-05-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-21' AS Date), CAST(N'2026-05-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-22' AS Date), CAST(N'2026-05-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-23' AS Date), CAST(N'2026-05-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-24' AS Date), CAST(N'2026-05-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-25' AS Date), CAST(N'2026-05-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-26' AS Date), CAST(N'2026-05-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-27' AS Date), CAST(N'2026-05-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-28' AS Date), CAST(N'2026-05-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-29' AS Date), CAST(N'2026-05-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-30' AS Date), CAST(N'2026-05-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-05-31' AS Date), CAST(N'2026-05-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-01' AS Date), CAST(N'2026-06-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-02' AS Date), CAST(N'2026-06-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-03' AS Date), CAST(N'2026-06-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-04' AS Date), CAST(N'2026-06-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-05' AS Date), CAST(N'2026-06-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-06' AS Date), CAST(N'2026-06-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-07' AS Date), CAST(N'2026-06-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-08' AS Date), CAST(N'2026-06-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-09' AS Date), CAST(N'2026-06-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-10' AS Date), CAST(N'2026-06-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-11' AS Date), CAST(N'2026-06-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-12' AS Date), CAST(N'2026-06-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-13' AS Date), CAST(N'2026-06-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-14' AS Date), CAST(N'2026-06-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-15' AS Date), CAST(N'2026-06-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-16' AS Date), CAST(N'2026-06-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-17' AS Date), CAST(N'2026-06-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-18' AS Date), CAST(N'2026-06-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-19' AS Date), CAST(N'2026-06-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-20' AS Date), CAST(N'2026-06-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-21' AS Date), CAST(N'2026-06-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-22' AS Date), CAST(N'2026-06-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-23' AS Date), CAST(N'2026-06-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-24' AS Date), CAST(N'2026-06-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-25' AS Date), CAST(N'2026-06-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-26' AS Date), CAST(N'2026-06-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-27' AS Date), CAST(N'2026-06-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-28' AS Date), CAST(N'2026-06-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-29' AS Date), CAST(N'2026-06-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-06-30' AS Date), CAST(N'2026-06-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-01' AS Date), CAST(N'2026-07-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-02' AS Date), CAST(N'2026-07-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-03' AS Date), CAST(N'2026-07-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-04' AS Date), CAST(N'2026-07-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-05' AS Date), CAST(N'2026-07-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-06' AS Date), CAST(N'2026-07-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-07' AS Date), CAST(N'2026-07-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-08' AS Date), CAST(N'2026-07-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-09' AS Date), CAST(N'2026-07-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-10' AS Date), CAST(N'2026-07-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-11' AS Date), CAST(N'2026-07-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-12' AS Date), CAST(N'2026-07-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-13' AS Date), CAST(N'2026-07-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-14' AS Date), CAST(N'2026-07-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-15' AS Date), CAST(N'2026-07-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-16' AS Date), CAST(N'2026-07-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-17' AS Date), CAST(N'2026-07-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-18' AS Date), CAST(N'2026-07-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-19' AS Date), CAST(N'2026-07-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-20' AS Date), CAST(N'2026-07-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-21' AS Date), CAST(N'2026-07-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-22' AS Date), CAST(N'2026-07-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-23' AS Date), CAST(N'2026-07-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-24' AS Date), CAST(N'2026-07-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-25' AS Date), CAST(N'2026-07-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-26' AS Date), CAST(N'2026-07-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-27' AS Date), CAST(N'2026-07-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-28' AS Date), CAST(N'2026-07-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-29' AS Date), CAST(N'2026-07-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-30' AS Date), CAST(N'2026-07-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-07-31' AS Date), CAST(N'2026-07-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-01' AS Date), CAST(N'2026-08-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-02' AS Date), CAST(N'2026-08-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-03' AS Date), CAST(N'2026-08-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-04' AS Date), CAST(N'2026-08-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-05' AS Date), CAST(N'2026-08-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-06' AS Date), CAST(N'2026-08-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-07' AS Date), CAST(N'2026-08-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-08' AS Date), CAST(N'2026-08-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-09' AS Date), CAST(N'2026-08-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-10' AS Date), CAST(N'2026-08-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-11' AS Date), CAST(N'2026-08-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-12' AS Date), CAST(N'2026-08-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-13' AS Date), CAST(N'2026-08-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-14' AS Date), CAST(N'2026-08-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-15' AS Date), CAST(N'2026-08-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-16' AS Date), CAST(N'2026-08-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-17' AS Date), CAST(N'2026-08-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-18' AS Date), CAST(N'2026-08-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-19' AS Date), CAST(N'2026-08-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-20' AS Date), CAST(N'2026-08-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-21' AS Date), CAST(N'2026-08-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-22' AS Date), CAST(N'2026-08-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-23' AS Date), CAST(N'2026-08-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-24' AS Date), CAST(N'2026-08-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-25' AS Date), CAST(N'2026-08-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-26' AS Date), CAST(N'2026-08-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-27' AS Date), CAST(N'2026-08-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-28' AS Date), CAST(N'2026-08-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-29' AS Date), CAST(N'2026-08-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-30' AS Date), CAST(N'2026-08-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-08-31' AS Date), CAST(N'2026-08-31T00:00:00.000' AS DateTime), 31, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-01' AS Date), CAST(N'2026-09-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-02' AS Date), CAST(N'2026-09-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-03' AS Date), CAST(N'2026-09-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-04' AS Date), CAST(N'2026-09-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-05' AS Date), CAST(N'2026-09-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-06' AS Date), CAST(N'2026-09-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-07' AS Date), CAST(N'2026-09-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-08' AS Date), CAST(N'2026-09-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-09' AS Date), CAST(N'2026-09-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-10' AS Date), CAST(N'2026-09-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-11' AS Date), CAST(N'2026-09-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-12' AS Date), CAST(N'2026-09-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-13' AS Date), CAST(N'2026-09-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-14' AS Date), CAST(N'2026-09-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-15' AS Date), CAST(N'2026-09-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-16' AS Date), CAST(N'2026-09-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-17' AS Date), CAST(N'2026-09-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-18' AS Date), CAST(N'2026-09-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-19' AS Date), CAST(N'2026-09-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-20' AS Date), CAST(N'2026-09-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-21' AS Date), CAST(N'2026-09-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-22' AS Date), CAST(N'2026-09-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-23' AS Date), CAST(N'2026-09-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-24' AS Date), CAST(N'2026-09-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-25' AS Date), CAST(N'2026-09-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-26' AS Date), CAST(N'2026-09-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-27' AS Date), CAST(N'2026-09-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-28' AS Date), CAST(N'2026-09-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-29' AS Date), CAST(N'2026-09-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-09-30' AS Date), CAST(N'2026-09-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-01' AS Date), CAST(N'2026-10-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-02' AS Date), CAST(N'2026-10-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-03' AS Date), CAST(N'2026-10-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-04' AS Date), CAST(N'2026-10-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-05' AS Date), CAST(N'2026-10-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-06' AS Date), CAST(N'2026-10-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-07' AS Date), CAST(N'2026-10-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-08' AS Date), CAST(N'2026-10-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-09' AS Date), CAST(N'2026-10-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-10' AS Date), CAST(N'2026-10-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-11' AS Date), CAST(N'2026-10-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-12' AS Date), CAST(N'2026-10-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-13' AS Date), CAST(N'2026-10-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-14' AS Date), CAST(N'2026-10-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-15' AS Date), CAST(N'2026-10-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-16' AS Date), CAST(N'2026-10-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-17' AS Date), CAST(N'2026-10-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-18' AS Date), CAST(N'2026-10-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-19' AS Date), CAST(N'2026-10-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-20' AS Date), CAST(N'2026-10-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-21' AS Date), CAST(N'2026-10-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-22' AS Date), CAST(N'2026-10-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-23' AS Date), CAST(N'2026-10-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-24' AS Date), CAST(N'2026-10-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-25' AS Date), CAST(N'2026-10-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-26' AS Date), CAST(N'2026-10-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-27' AS Date), CAST(N'2026-10-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-28' AS Date), CAST(N'2026-10-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-29' AS Date), CAST(N'2026-10-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-30' AS Date), CAST(N'2026-10-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-10-31' AS Date), CAST(N'2026-10-31T00:00:00.000' AS DateTime), 31, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-01' AS Date), CAST(N'2026-11-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-02' AS Date), CAST(N'2026-11-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-03' AS Date), CAST(N'2026-11-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-04' AS Date), CAST(N'2026-11-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-05' AS Date), CAST(N'2026-11-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-06' AS Date), CAST(N'2026-11-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-07' AS Date), CAST(N'2026-11-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-08' AS Date), CAST(N'2026-11-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-09' AS Date), CAST(N'2026-11-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-10' AS Date), CAST(N'2026-11-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-11' AS Date), CAST(N'2026-11-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-12' AS Date), CAST(N'2026-11-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-13' AS Date), CAST(N'2026-11-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-14' AS Date), CAST(N'2026-11-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-15' AS Date), CAST(N'2026-11-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-16' AS Date), CAST(N'2026-11-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-17' AS Date), CAST(N'2026-11-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-18' AS Date), CAST(N'2026-11-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-19' AS Date), CAST(N'2026-11-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-20' AS Date), CAST(N'2026-11-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-21' AS Date), CAST(N'2026-11-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-22' AS Date), CAST(N'2026-11-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-23' AS Date), CAST(N'2026-11-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-24' AS Date), CAST(N'2026-11-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-25' AS Date), CAST(N'2026-11-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-26' AS Date), CAST(N'2026-11-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-27' AS Date), CAST(N'2026-11-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-28' AS Date), CAST(N'2026-11-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-29' AS Date), CAST(N'2026-11-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-11-30' AS Date), CAST(N'2026-11-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-01' AS Date), CAST(N'2026-12-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-02' AS Date), CAST(N'2026-12-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-03' AS Date), CAST(N'2026-12-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-04' AS Date), CAST(N'2026-12-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-05' AS Date), CAST(N'2026-12-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-06' AS Date), CAST(N'2026-12-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-07' AS Date), CAST(N'2026-12-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-08' AS Date), CAST(N'2026-12-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-09' AS Date), CAST(N'2026-12-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-10' AS Date), CAST(N'2026-12-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-11' AS Date), CAST(N'2026-12-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-12' AS Date), CAST(N'2026-12-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-13' AS Date), CAST(N'2026-12-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-14' AS Date), CAST(N'2026-12-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-15' AS Date), CAST(N'2026-12-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-16' AS Date), CAST(N'2026-12-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-17' AS Date), CAST(N'2026-12-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-18' AS Date), CAST(N'2026-12-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-19' AS Date), CAST(N'2026-12-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-20' AS Date), CAST(N'2026-12-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-21' AS Date), CAST(N'2026-12-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-22' AS Date), CAST(N'2026-12-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-23' AS Date), CAST(N'2026-12-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-24' AS Date), CAST(N'2026-12-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-25' AS Date), CAST(N'2026-12-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-26' AS Date), CAST(N'2026-12-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-27' AS Date), CAST(N'2026-12-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-28' AS Date), CAST(N'2026-12-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-29' AS Date), CAST(N'2026-12-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-30' AS Date), CAST(N'2026-12-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2026-12-31' AS Date), CAST(N'2026-12-31T00:00:00.000' AS DateTime), 31, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-01' AS Date), CAST(N'2027-01-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-02' AS Date), CAST(N'2027-01-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-03' AS Date), CAST(N'2027-01-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-04' AS Date), CAST(N'2027-01-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-05' AS Date), CAST(N'2027-01-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-06' AS Date), CAST(N'2027-01-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-07' AS Date), CAST(N'2027-01-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-08' AS Date), CAST(N'2027-01-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-09' AS Date), CAST(N'2027-01-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-10' AS Date), CAST(N'2027-01-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-11' AS Date), CAST(N'2027-01-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-12' AS Date), CAST(N'2027-01-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-13' AS Date), CAST(N'2027-01-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-14' AS Date), CAST(N'2027-01-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-15' AS Date), CAST(N'2027-01-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-16' AS Date), CAST(N'2027-01-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-17' AS Date), CAST(N'2027-01-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-18' AS Date), CAST(N'2027-01-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-19' AS Date), CAST(N'2027-01-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-20' AS Date), CAST(N'2027-01-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-21' AS Date), CAST(N'2027-01-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-22' AS Date), CAST(N'2027-01-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-23' AS Date), CAST(N'2027-01-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-24' AS Date), CAST(N'2027-01-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-25' AS Date), CAST(N'2027-01-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-26' AS Date), CAST(N'2027-01-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-27' AS Date), CAST(N'2027-01-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-28' AS Date), CAST(N'2027-01-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-29' AS Date), CAST(N'2027-01-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-30' AS Date), CAST(N'2027-01-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-01-31' AS Date), CAST(N'2027-01-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-01' AS Date), CAST(N'2027-02-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-02' AS Date), CAST(N'2027-02-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-03' AS Date), CAST(N'2027-02-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-04' AS Date), CAST(N'2027-02-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-05' AS Date), CAST(N'2027-02-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-06' AS Date), CAST(N'2027-02-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-07' AS Date), CAST(N'2027-02-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-08' AS Date), CAST(N'2027-02-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-09' AS Date), CAST(N'2027-02-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-10' AS Date), CAST(N'2027-02-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-11' AS Date), CAST(N'2027-02-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-12' AS Date), CAST(N'2027-02-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-13' AS Date), CAST(N'2027-02-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-14' AS Date), CAST(N'2027-02-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-15' AS Date), CAST(N'2027-02-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-16' AS Date), CAST(N'2027-02-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-17' AS Date), CAST(N'2027-02-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-18' AS Date), CAST(N'2027-02-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-19' AS Date), CAST(N'2027-02-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-20' AS Date), CAST(N'2027-02-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-21' AS Date), CAST(N'2027-02-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-22' AS Date), CAST(N'2027-02-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-23' AS Date), CAST(N'2027-02-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-24' AS Date), CAST(N'2027-02-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-25' AS Date), CAST(N'2027-02-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-26' AS Date), CAST(N'2027-02-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-27' AS Date), CAST(N'2027-02-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-02-28' AS Date), CAST(N'2027-02-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-01' AS Date), CAST(N'2027-03-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-02' AS Date), CAST(N'2027-03-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-03' AS Date), CAST(N'2027-03-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-04' AS Date), CAST(N'2027-03-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-05' AS Date), CAST(N'2027-03-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-06' AS Date), CAST(N'2027-03-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-07' AS Date), CAST(N'2027-03-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-08' AS Date), CAST(N'2027-03-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-09' AS Date), CAST(N'2027-03-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-10' AS Date), CAST(N'2027-03-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-11' AS Date), CAST(N'2027-03-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-12' AS Date), CAST(N'2027-03-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-13' AS Date), CAST(N'2027-03-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-14' AS Date), CAST(N'2027-03-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-15' AS Date), CAST(N'2027-03-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-16' AS Date), CAST(N'2027-03-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-17' AS Date), CAST(N'2027-03-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-18' AS Date), CAST(N'2027-03-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-19' AS Date), CAST(N'2027-03-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-20' AS Date), CAST(N'2027-03-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-21' AS Date), CAST(N'2027-03-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-22' AS Date), CAST(N'2027-03-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-23' AS Date), CAST(N'2027-03-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-24' AS Date), CAST(N'2027-03-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-25' AS Date), CAST(N'2027-03-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-26' AS Date), CAST(N'2027-03-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-27' AS Date), CAST(N'2027-03-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-28' AS Date), CAST(N'2027-03-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-29' AS Date), CAST(N'2027-03-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-30' AS Date), CAST(N'2027-03-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-03-31' AS Date), CAST(N'2027-03-31T00:00:00.000' AS DateTime), 31, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-01' AS Date), CAST(N'2027-04-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-02' AS Date), CAST(N'2027-04-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-03' AS Date), CAST(N'2027-04-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-04' AS Date), CAST(N'2027-04-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-05' AS Date), CAST(N'2027-04-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-06' AS Date), CAST(N'2027-04-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-07' AS Date), CAST(N'2027-04-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-08' AS Date), CAST(N'2027-04-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-09' AS Date), CAST(N'2027-04-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-10' AS Date), CAST(N'2027-04-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-11' AS Date), CAST(N'2027-04-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-12' AS Date), CAST(N'2027-04-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-13' AS Date), CAST(N'2027-04-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-14' AS Date), CAST(N'2027-04-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-15' AS Date), CAST(N'2027-04-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-16' AS Date), CAST(N'2027-04-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-17' AS Date), CAST(N'2027-04-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-18' AS Date), CAST(N'2027-04-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-19' AS Date), CAST(N'2027-04-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-20' AS Date), CAST(N'2027-04-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-21' AS Date), CAST(N'2027-04-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-22' AS Date), CAST(N'2027-04-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-23' AS Date), CAST(N'2027-04-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-24' AS Date), CAST(N'2027-04-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-25' AS Date), CAST(N'2027-04-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-26' AS Date), CAST(N'2027-04-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-27' AS Date), CAST(N'2027-04-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-28' AS Date), CAST(N'2027-04-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-29' AS Date), CAST(N'2027-04-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-04-30' AS Date), CAST(N'2027-04-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-01' AS Date), CAST(N'2027-05-01T00:00:00.000' AS DateTime), 1, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-02' AS Date), CAST(N'2027-05-02T00:00:00.000' AS DateTime), 2, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-03' AS Date), CAST(N'2027-05-03T00:00:00.000' AS DateTime), 3, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-04' AS Date), CAST(N'2027-05-04T00:00:00.000' AS DateTime), 4, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-05' AS Date), CAST(N'2027-05-05T00:00:00.000' AS DateTime), 5, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-06' AS Date), CAST(N'2027-05-06T00:00:00.000' AS DateTime), 6, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-07' AS Date), CAST(N'2027-05-07T00:00:00.000' AS DateTime), 7, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-08' AS Date), CAST(N'2027-05-08T00:00:00.000' AS DateTime), 8, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-09' AS Date), CAST(N'2027-05-09T00:00:00.000' AS DateTime), 9, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-10' AS Date), CAST(N'2027-05-10T00:00:00.000' AS DateTime), 10, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-11' AS Date), CAST(N'2027-05-11T00:00:00.000' AS DateTime), 11, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-12' AS Date), CAST(N'2027-05-12T00:00:00.000' AS DateTime), 12, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-13' AS Date), CAST(N'2027-05-13T00:00:00.000' AS DateTime), 13, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-14' AS Date), CAST(N'2027-05-14T00:00:00.000' AS DateTime), 14, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-15' AS Date), CAST(N'2027-05-15T00:00:00.000' AS DateTime), 15, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-16' AS Date), CAST(N'2027-05-16T00:00:00.000' AS DateTime), 16, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-17' AS Date), CAST(N'2027-05-17T00:00:00.000' AS DateTime), 17, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-18' AS Date), CAST(N'2027-05-18T00:00:00.000' AS DateTime), 18, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-19' AS Date), CAST(N'2027-05-19T00:00:00.000' AS DateTime), 19, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-20' AS Date), CAST(N'2027-05-20T00:00:00.000' AS DateTime), 20, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-21' AS Date), CAST(N'2027-05-21T00:00:00.000' AS DateTime), 21, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-22' AS Date), CAST(N'2027-05-22T00:00:00.000' AS DateTime), 22, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-23' AS Date), CAST(N'2027-05-23T00:00:00.000' AS DateTime), 23, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-24' AS Date), CAST(N'2027-05-24T00:00:00.000' AS DateTime), 24, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-25' AS Date), CAST(N'2027-05-25T00:00:00.000' AS DateTime), 25, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-26' AS Date), CAST(N'2027-05-26T00:00:00.000' AS DateTime), 26, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-27' AS Date), CAST(N'2027-05-27T00:00:00.000' AS DateTime), 27, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-28' AS Date), CAST(N'2027-05-28T00:00:00.000' AS DateTime), 28, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-29' AS Date), CAST(N'2027-05-29T00:00:00.000' AS DateTime), 29, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-30' AS Date), CAST(N'2027-05-30T00:00:00.000' AS DateTime), 30, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-05-31' AS Date), CAST(N'2027-05-31T00:00:00.000' AS DateTime), 31, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-01' AS Date), CAST(N'2027-06-01T00:00:00.000' AS DateTime), 1, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-02' AS Date), CAST(N'2027-06-02T00:00:00.000' AS DateTime), 2, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-03' AS Date), CAST(N'2027-06-03T00:00:00.000' AS DateTime), 3, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-04' AS Date), CAST(N'2027-06-04T00:00:00.000' AS DateTime), 4, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-05' AS Date), CAST(N'2027-06-05T00:00:00.000' AS DateTime), 5, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-06' AS Date), CAST(N'2027-06-06T00:00:00.000' AS DateTime), 6, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-07' AS Date), CAST(N'2027-06-07T00:00:00.000' AS DateTime), 7, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-08' AS Date), CAST(N'2027-06-08T00:00:00.000' AS DateTime), 8, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-09' AS Date), CAST(N'2027-06-09T00:00:00.000' AS DateTime), 9, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-10' AS Date), CAST(N'2027-06-10T00:00:00.000' AS DateTime), 10, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-11' AS Date), CAST(N'2027-06-11T00:00:00.000' AS DateTime), 11, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-12' AS Date), CAST(N'2027-06-12T00:00:00.000' AS DateTime), 12, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-13' AS Date), CAST(N'2027-06-13T00:00:00.000' AS DateTime), 13, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-14' AS Date), CAST(N'2027-06-14T00:00:00.000' AS DateTime), 14, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-15' AS Date), CAST(N'2027-06-15T00:00:00.000' AS DateTime), 15, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-16' AS Date), CAST(N'2027-06-16T00:00:00.000' AS DateTime), 16, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-17' AS Date), CAST(N'2027-06-17T00:00:00.000' AS DateTime), 17, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-18' AS Date), CAST(N'2027-06-18T00:00:00.000' AS DateTime), 18, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-19' AS Date), CAST(N'2027-06-19T00:00:00.000' AS DateTime), 19, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-20' AS Date), CAST(N'2027-06-20T00:00:00.000' AS DateTime), 20, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-21' AS Date), CAST(N'2027-06-21T00:00:00.000' AS DateTime), 21, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-22' AS Date), CAST(N'2027-06-22T00:00:00.000' AS DateTime), 22, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-23' AS Date), CAST(N'2027-06-23T00:00:00.000' AS DateTime), 23, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-24' AS Date), CAST(N'2027-06-24T00:00:00.000' AS DateTime), 24, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-25' AS Date), CAST(N'2027-06-25T00:00:00.000' AS DateTime), 25, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-26' AS Date), CAST(N'2027-06-26T00:00:00.000' AS DateTime), 26, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-27' AS Date), CAST(N'2027-06-27T00:00:00.000' AS DateTime), 27, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-28' AS Date), CAST(N'2027-06-28T00:00:00.000' AS DateTime), 28, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-29' AS Date), CAST(N'2027-06-29T00:00:00.000' AS DateTime), 29, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-06-30' AS Date), CAST(N'2027-06-30T00:00:00.000' AS DateTime), 30, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-01' AS Date), CAST(N'2027-07-01T00:00:00.000' AS DateTime), 1, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-02' AS Date), CAST(N'2027-07-02T00:00:00.000' AS DateTime), 2, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-03' AS Date), CAST(N'2027-07-03T00:00:00.000' AS DateTime), 3, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-04' AS Date), CAST(N'2027-07-04T00:00:00.000' AS DateTime), 4, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-05' AS Date), CAST(N'2027-07-05T00:00:00.000' AS DateTime), 5, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-06' AS Date), CAST(N'2027-07-06T00:00:00.000' AS DateTime), 6, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-07' AS Date), CAST(N'2027-07-07T00:00:00.000' AS DateTime), 7, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-08' AS Date), CAST(N'2027-07-08T00:00:00.000' AS DateTime), 8, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-09' AS Date), CAST(N'2027-07-09T00:00:00.000' AS DateTime), 9, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-10' AS Date), CAST(N'2027-07-10T00:00:00.000' AS DateTime), 10, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-11' AS Date), CAST(N'2027-07-11T00:00:00.000' AS DateTime), 11, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-12' AS Date), CAST(N'2027-07-12T00:00:00.000' AS DateTime), 12, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-13' AS Date), CAST(N'2027-07-13T00:00:00.000' AS DateTime), 13, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-14' AS Date), CAST(N'2027-07-14T00:00:00.000' AS DateTime), 14, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-15' AS Date), CAST(N'2027-07-15T00:00:00.000' AS DateTime), 15, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-16' AS Date), CAST(N'2027-07-16T00:00:00.000' AS DateTime), 16, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-17' AS Date), CAST(N'2027-07-17T00:00:00.000' AS DateTime), 17, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-18' AS Date), CAST(N'2027-07-18T00:00:00.000' AS DateTime), 18, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-19' AS Date), CAST(N'2027-07-19T00:00:00.000' AS DateTime), 19, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-20' AS Date), CAST(N'2027-07-20T00:00:00.000' AS DateTime), 20, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-21' AS Date), CAST(N'2027-07-21T00:00:00.000' AS DateTime), 21, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-22' AS Date), CAST(N'2027-07-22T00:00:00.000' AS DateTime), 22, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-23' AS Date), CAST(N'2027-07-23T00:00:00.000' AS DateTime), 23, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-24' AS Date), CAST(N'2027-07-24T00:00:00.000' AS DateTime), 24, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-25' AS Date), CAST(N'2027-07-25T00:00:00.000' AS DateTime), 25, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-26' AS Date), CAST(N'2027-07-26T00:00:00.000' AS DateTime), 26, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-27' AS Date), CAST(N'2027-07-27T00:00:00.000' AS DateTime), 27, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-28' AS Date), CAST(N'2027-07-28T00:00:00.000' AS DateTime), 28, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-29' AS Date), CAST(N'2027-07-29T00:00:00.000' AS DateTime), 29, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-30' AS Date), CAST(N'2027-07-30T00:00:00.000' AS DateTime), 30, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-07-31' AS Date), CAST(N'2027-07-31T00:00:00.000' AS DateTime), 31, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-01' AS Date), CAST(N'2027-08-01T00:00:00.000' AS DateTime), 1, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-02' AS Date), CAST(N'2027-08-02T00:00:00.000' AS DateTime), 2, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-03' AS Date), CAST(N'2027-08-03T00:00:00.000' AS DateTime), 3, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-04' AS Date), CAST(N'2027-08-04T00:00:00.000' AS DateTime), 4, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-05' AS Date), CAST(N'2027-08-05T00:00:00.000' AS DateTime), 5, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-06' AS Date), CAST(N'2027-08-06T00:00:00.000' AS DateTime), 6, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-07' AS Date), CAST(N'2027-08-07T00:00:00.000' AS DateTime), 7, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-08' AS Date), CAST(N'2027-08-08T00:00:00.000' AS DateTime), 8, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-09' AS Date), CAST(N'2027-08-09T00:00:00.000' AS DateTime), 9, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-10' AS Date), CAST(N'2027-08-10T00:00:00.000' AS DateTime), 10, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-11' AS Date), CAST(N'2027-08-11T00:00:00.000' AS DateTime), 11, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-12' AS Date), CAST(N'2027-08-12T00:00:00.000' AS DateTime), 12, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-13' AS Date), CAST(N'2027-08-13T00:00:00.000' AS DateTime), 13, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-14' AS Date), CAST(N'2027-08-14T00:00:00.000' AS DateTime), 14, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-15' AS Date), CAST(N'2027-08-15T00:00:00.000' AS DateTime), 15, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-16' AS Date), CAST(N'2027-08-16T00:00:00.000' AS DateTime), 16, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-17' AS Date), CAST(N'2027-08-17T00:00:00.000' AS DateTime), 17, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-18' AS Date), CAST(N'2027-08-18T00:00:00.000' AS DateTime), 18, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-19' AS Date), CAST(N'2027-08-19T00:00:00.000' AS DateTime), 19, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-20' AS Date), CAST(N'2027-08-20T00:00:00.000' AS DateTime), 20, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-21' AS Date), CAST(N'2027-08-21T00:00:00.000' AS DateTime), 21, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-22' AS Date), CAST(N'2027-08-22T00:00:00.000' AS DateTime), 22, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-23' AS Date), CAST(N'2027-08-23T00:00:00.000' AS DateTime), 23, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-24' AS Date), CAST(N'2027-08-24T00:00:00.000' AS DateTime), 24, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-25' AS Date), CAST(N'2027-08-25T00:00:00.000' AS DateTime), 25, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-26' AS Date), CAST(N'2027-08-26T00:00:00.000' AS DateTime), 26, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-27' AS Date), CAST(N'2027-08-27T00:00:00.000' AS DateTime), 27, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-28' AS Date), CAST(N'2027-08-28T00:00:00.000' AS DateTime), 28, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-29' AS Date), CAST(N'2027-08-29T00:00:00.000' AS DateTime), 29, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-30' AS Date), CAST(N'2027-08-30T00:00:00.000' AS DateTime), 30, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-08-31' AS Date), CAST(N'2027-08-31T00:00:00.000' AS DateTime), 31, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-01' AS Date), CAST(N'2027-09-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-02' AS Date), CAST(N'2027-09-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-03' AS Date), CAST(N'2027-09-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-04' AS Date), CAST(N'2027-09-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-05' AS Date), CAST(N'2027-09-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-06' AS Date), CAST(N'2027-09-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-07' AS Date), CAST(N'2027-09-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-08' AS Date), CAST(N'2027-09-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-09' AS Date), CAST(N'2027-09-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-10' AS Date), CAST(N'2027-09-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-11' AS Date), CAST(N'2027-09-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-12' AS Date), CAST(N'2027-09-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-13' AS Date), CAST(N'2027-09-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-14' AS Date), CAST(N'2027-09-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-15' AS Date), CAST(N'2027-09-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-16' AS Date), CAST(N'2027-09-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-17' AS Date), CAST(N'2027-09-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-18' AS Date), CAST(N'2027-09-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-19' AS Date), CAST(N'2027-09-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-20' AS Date), CAST(N'2027-09-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-21' AS Date), CAST(N'2027-09-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-22' AS Date), CAST(N'2027-09-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-23' AS Date), CAST(N'2027-09-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-24' AS Date), CAST(N'2027-09-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-25' AS Date), CAST(N'2027-09-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-26' AS Date), CAST(N'2027-09-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-27' AS Date), CAST(N'2027-09-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-28' AS Date), CAST(N'2027-09-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-29' AS Date), CAST(N'2027-09-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-09-30' AS Date), CAST(N'2027-09-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-01' AS Date), CAST(N'2027-10-01T00:00:00.000' AS DateTime), 1, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-02' AS Date), CAST(N'2027-10-02T00:00:00.000' AS DateTime), 2, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-03' AS Date), CAST(N'2027-10-03T00:00:00.000' AS DateTime), 3, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-04' AS Date), CAST(N'2027-10-04T00:00:00.000' AS DateTime), 4, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-05' AS Date), CAST(N'2027-10-05T00:00:00.000' AS DateTime), 5, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-06' AS Date), CAST(N'2027-10-06T00:00:00.000' AS DateTime), 6, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-07' AS Date), CAST(N'2027-10-07T00:00:00.000' AS DateTime), 7, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-08' AS Date), CAST(N'2027-10-08T00:00:00.000' AS DateTime), 8, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-09' AS Date), CAST(N'2027-10-09T00:00:00.000' AS DateTime), 9, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-10' AS Date), CAST(N'2027-10-10T00:00:00.000' AS DateTime), 10, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-11' AS Date), CAST(N'2027-10-11T00:00:00.000' AS DateTime), 11, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-12' AS Date), CAST(N'2027-10-12T00:00:00.000' AS DateTime), 12, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-13' AS Date), CAST(N'2027-10-13T00:00:00.000' AS DateTime), 13, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-14' AS Date), CAST(N'2027-10-14T00:00:00.000' AS DateTime), 14, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-15' AS Date), CAST(N'2027-10-15T00:00:00.000' AS DateTime), 15, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-16' AS Date), CAST(N'2027-10-16T00:00:00.000' AS DateTime), 16, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-17' AS Date), CAST(N'2027-10-17T00:00:00.000' AS DateTime), 17, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-18' AS Date), CAST(N'2027-10-18T00:00:00.000' AS DateTime), 18, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-19' AS Date), CAST(N'2027-10-19T00:00:00.000' AS DateTime), 19, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-20' AS Date), CAST(N'2027-10-20T00:00:00.000' AS DateTime), 20, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-21' AS Date), CAST(N'2027-10-21T00:00:00.000' AS DateTime), 21, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-22' AS Date), CAST(N'2027-10-22T00:00:00.000' AS DateTime), 22, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-23' AS Date), CAST(N'2027-10-23T00:00:00.000' AS DateTime), 23, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-24' AS Date), CAST(N'2027-10-24T00:00:00.000' AS DateTime), 24, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-25' AS Date), CAST(N'2027-10-25T00:00:00.000' AS DateTime), 25, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-26' AS Date), CAST(N'2027-10-26T00:00:00.000' AS DateTime), 26, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-27' AS Date), CAST(N'2027-10-27T00:00:00.000' AS DateTime), 27, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-28' AS Date), CAST(N'2027-10-28T00:00:00.000' AS DateTime), 28, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-29' AS Date), CAST(N'2027-10-29T00:00:00.000' AS DateTime), 29, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-30' AS Date), CAST(N'2027-10-30T00:00:00.000' AS DateTime), 30, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-10-31' AS Date), CAST(N'2027-10-31T00:00:00.000' AS DateTime), 31, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-01' AS Date), CAST(N'2027-11-01T00:00:00.000' AS DateTime), 1, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-02' AS Date), CAST(N'2027-11-02T00:00:00.000' AS DateTime), 2, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-03' AS Date), CAST(N'2027-11-03T00:00:00.000' AS DateTime), 3, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-04' AS Date), CAST(N'2027-11-04T00:00:00.000' AS DateTime), 4, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-05' AS Date), CAST(N'2027-11-05T00:00:00.000' AS DateTime), 5, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-06' AS Date), CAST(N'2027-11-06T00:00:00.000' AS DateTime), 6, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-07' AS Date), CAST(N'2027-11-07T00:00:00.000' AS DateTime), 7, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-08' AS Date), CAST(N'2027-11-08T00:00:00.000' AS DateTime), 8, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-09' AS Date), CAST(N'2027-11-09T00:00:00.000' AS DateTime), 9, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-10' AS Date), CAST(N'2027-11-10T00:00:00.000' AS DateTime), 10, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-11' AS Date), CAST(N'2027-11-11T00:00:00.000' AS DateTime), 11, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-12' AS Date), CAST(N'2027-11-12T00:00:00.000' AS DateTime), 12, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-13' AS Date), CAST(N'2027-11-13T00:00:00.000' AS DateTime), 13, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-14' AS Date), CAST(N'2027-11-14T00:00:00.000' AS DateTime), 14, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-15' AS Date), CAST(N'2027-11-15T00:00:00.000' AS DateTime), 15, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-16' AS Date), CAST(N'2027-11-16T00:00:00.000' AS DateTime), 16, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-17' AS Date), CAST(N'2027-11-17T00:00:00.000' AS DateTime), 17, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-18' AS Date), CAST(N'2027-11-18T00:00:00.000' AS DateTime), 18, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-19' AS Date), CAST(N'2027-11-19T00:00:00.000' AS DateTime), 19, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-20' AS Date), CAST(N'2027-11-20T00:00:00.000' AS DateTime), 20, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-21' AS Date), CAST(N'2027-11-21T00:00:00.000' AS DateTime), 21, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-22' AS Date), CAST(N'2027-11-22T00:00:00.000' AS DateTime), 22, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-23' AS Date), CAST(N'2027-11-23T00:00:00.000' AS DateTime), 23, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-24' AS Date), CAST(N'2027-11-24T00:00:00.000' AS DateTime), 24, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-25' AS Date), CAST(N'2027-11-25T00:00:00.000' AS DateTime), 25, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-26' AS Date), CAST(N'2027-11-26T00:00:00.000' AS DateTime), 26, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-27' AS Date), CAST(N'2027-11-27T00:00:00.000' AS DateTime), 27, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-28' AS Date), CAST(N'2027-11-28T00:00:00.000' AS DateTime), 28, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-29' AS Date), CAST(N'2027-11-29T00:00:00.000' AS DateTime), 29, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-11-30' AS Date), CAST(N'2027-11-30T00:00:00.000' AS DateTime), 30, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-01' AS Date), CAST(N'2027-12-01T00:00:00.000' AS DateTime), 1, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-02' AS Date), CAST(N'2027-12-02T00:00:00.000' AS DateTime), 2, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-03' AS Date), CAST(N'2027-12-03T00:00:00.000' AS DateTime), 3, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-04' AS Date), CAST(N'2027-12-04T00:00:00.000' AS DateTime), 4, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-05' AS Date), CAST(N'2027-12-05T00:00:00.000' AS DateTime), 5, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-06' AS Date), CAST(N'2027-12-06T00:00:00.000' AS DateTime), 6, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-07' AS Date), CAST(N'2027-12-07T00:00:00.000' AS DateTime), 7, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-08' AS Date), CAST(N'2027-12-08T00:00:00.000' AS DateTime), 8, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-09' AS Date), CAST(N'2027-12-09T00:00:00.000' AS DateTime), 9, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-10' AS Date), CAST(N'2027-12-10T00:00:00.000' AS DateTime), 10, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-11' AS Date), CAST(N'2027-12-11T00:00:00.000' AS DateTime), 11, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-12' AS Date), CAST(N'2027-12-12T00:00:00.000' AS DateTime), 12, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-13' AS Date), CAST(N'2027-12-13T00:00:00.000' AS DateTime), 13, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-14' AS Date), CAST(N'2027-12-14T00:00:00.000' AS DateTime), 14, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-15' AS Date), CAST(N'2027-12-15T00:00:00.000' AS DateTime), 15, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-16' AS Date), CAST(N'2027-12-16T00:00:00.000' AS DateTime), 16, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-17' AS Date), CAST(N'2027-12-17T00:00:00.000' AS DateTime), 17, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-18' AS Date), CAST(N'2027-12-18T00:00:00.000' AS DateTime), 18, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-19' AS Date), CAST(N'2027-12-19T00:00:00.000' AS DateTime), 19, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-20' AS Date), CAST(N'2027-12-20T00:00:00.000' AS DateTime), 20, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-21' AS Date), CAST(N'2027-12-21T00:00:00.000' AS DateTime), 21, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-22' AS Date), CAST(N'2027-12-22T00:00:00.000' AS DateTime), 22, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-23' AS Date), CAST(N'2027-12-23T00:00:00.000' AS DateTime), 23, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-24' AS Date), CAST(N'2027-12-24T00:00:00.000' AS DateTime), 24, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-25' AS Date), CAST(N'2027-12-25T00:00:00.000' AS DateTime), 25, N'Saturday', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-26' AS Date), CAST(N'2027-12-26T00:00:00.000' AS DateTime), 26, N'Sunday', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-27' AS Date), CAST(N'2027-12-27T00:00:00.000' AS DateTime), 27, N'Monday', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-28' AS Date), CAST(N'2027-12-28T00:00:00.000' AS DateTime), 28, N'Tuesday', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-29' AS Date), CAST(N'2027-12-29T00:00:00.000' AS DateTime), 29, N'Wednesday', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-30' AS Date), CAST(N'2027-12-30T00:00:00.000' AS DateTime), 30, N'Thursday', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[calendar] ([TheDate], [TheDateTime], [TheDay], [TheDayName], [TheWeek], [TheISOWeek], [TheDayOfWeek], [TheMonth], [TheMonthName], [TheQuarter], [TheYear], [TheFirstOfMonth], [TheLastOfYear], [TheDayOfYear]) VALUES (CAST(N'2027-12-31' AS Date), CAST(N'2027-12-31T00:00:00.000' AS DateTime), 31, N'Friday', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

GO
SET IDENTITY_INSERT [dbo].[settings] ON

INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1, N'event_id', N'1', CAST(N'2021-04-17T18:06:48.577' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (3, N'start_time', N'2023-05-11 09:00:00.000', CAST(N'2021-04-17T18:06:48.577' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (4, N'slip_printer', N'Microsoft Print to PDF', CAST(N'2022-04-26T08:06:41.077' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (5, N'default_time_limit', N'1440', CAST(N'2022-05-06T09:16:47.600' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (6, N'dsk_penalty_min', N'30', CAST(N'2022-07-11T21:56:38.630' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (7, N'live_entries', N'/entries', CAST(N'2022-07-25T07:46:12.630' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (8, N'live_slips', N'/legs', CAST(N'2022-07-25T07:46:40.237' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (9, N'live_entries_truncate', N'/entries_truncate', CAST(N'2022-10-29T19:38:02.107' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (10, N'live_password', N'heslo', CAST(N'2022-10-29T19:39:07.673' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (11, N'live_user', N'client1', CAST(N'2022-11-09T08:33:48.700' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (12, N'live_url1', N'http://knitsch01.local:3000', CAST(N'2022-11-09T08:59:54.323' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1009, N'live_token', N'XXX', CAST(N'2022-11-13T19:09:21.120' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1010, N'oris_entries', N'https://oris.orientacnisporty.cz/ExportIOF30?agenda=entries&comp=7634', CAST(N'2023-03-19T11:56:19.310' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1012, N'stop_roc_service', N'/stop_roc', CAST(N'2023-04-08T11:04:57.640' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1013, N'start_roc_service', N'/start_roc', CAST(N'2023-04-08T11:05:53.580' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1014, N'live_legs_truncate', N'/legs_truncate', CAST(N'2023-04-08T20:23:43.760' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1015, N'live_url', N'http://knitsch01.local:3000;https://24ol.eu.meteorapp.com', CAST(N'2022-11-09T08:59:54.323' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1016, N'wdrn_course', N'WDRN', CAST(N'2023-04-28T20:51:21.293' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1017, N'live_competitors', N'/competitors', CAST(N'2023-06-01T14:27:56.163' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1018, N'live_competitors_truncate', N'/competitors_truncate', CAST(N'2023-06-01T15:40:44.973' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1019, N'live_url2', N'https://24ol.eu.meteorapp.com', CAST(N'2023-06-01T16:06:56.050' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1020, N'api_queue_timer', N'2', CAST(N'2023-11-22T17:51:04.277' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1021, N'q_status_new', N'New', CAST(N'2023-11-22T20:17:36.247' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1022, N'api_queue_timeout', N'60', CAST(N'2023-11-22T20:18:58.160' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1023, N'q_status_completed', N'Completed', CAST(N'2023-11-22T20:19:24.597' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1024, N'q_status_in_progress', N'InProgress', CAST(N'2023-11-25T17:38:36.643' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1025, N'q_status_sent', N'Sent', CAST(N'2023-11-25T17:39:00.503' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1026, N'q_status_failed', N'Failed', CAST(N'2023-11-25T17:39:35.453' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1027, N'live_roc', N'/roc', CAST(N'2023-12-07T08:33:32.043' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1028, N'sms_url1', N'https://rest.spryngsms.com/v1/messages', CAST(N'2023-12-25T14:41:42.163' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1029, N'sms_token1', N'XXX', CAST(N'2023-12-25T14:41:59.860' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1030, N'sms_url', N'https://gatewayapi.com/rest/mtsms', CAST(N'2023-12-29T21:24:01.847' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1032, N'sms_token_gatewayapi', N'XXX', CAST(N'2024-02-05T10:44:56.750' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1033, N'sms_url3', N'https://gateway.seven.io/api/sms', CAST(N'2024-04-10T20:38:13.627' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1034, N'sms_token3', N'', CAST(N'2024-04-10T20:38:56.880' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1035, N'sms_send', N'true', CAST(N'2024-04-10T21:26:16.907' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1036, N'sms_originator', N'420734401555', CAST(N'2024-04-11T08:39:57.783' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1037, N'sms_url', N'http://192.168.1.106:8080/message', CAST(N'2024-04-11T14:47:13.697' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1038, N'sms_token', N'c21zOi1FN1BJUkRx', CAST(N'2024-04-11T14:47:36.140' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1039, N'sms_method', N'3', CAST(N'2024-04-27T11:33:24.553' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1040, N'sms_url_clickatel', N'https://platform.clickatell.com/messages', CAST(N'2024-04-28T21:49:10.450' AS DateTime))
INSERT [dbo].[settings] ([s_id], [config_name], [config_value], [as_of_date]) VALUES (1041, N'sms_token_clickatel', N'XXX', CAST(N'2024-04-28T22:01:39.100' AS DateTime))
GO

SET IDENTITY_INSERT [dbo].[settings] OFF
GO

SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_course_codes]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [IX_course_codes] ON [dbo].[course_codes]
(
	[control_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_legs]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [IX_legs] ON [dbo].[legs]
(
	[comp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_legs_1]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [IX_legs_1] ON [dbo].[legs]
(
	[readout_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_si_stamps_readout_id]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [IX_si_stamps_readout_id] ON [dbo].[si_stamps]
(
	[readout_id] ASC
)
INCLUDE([control_code],[punch_index]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ix_slips_leg_id]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [ix_slips_leg_id] ON [dbo].[slips]
(
	[leg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_slips_readout_id]    Script Date: 05.05.2024 21:24:12 ******/
CREATE NONCLUSTERED INDEX [IX_slips_readout_id] ON [dbo].[slips]
(
	[readout_id] ASC
)
INCLUDE([course_name],[team_name],[valid_flag]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[api_queue] ADD  CONSTRAINT [DF__api_queue__as_of_date__7D439ABD]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[api_queue_link] ADD  CONSTRAINT [DF__queue_link__as_of_date]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[categories] ADD  CONSTRAINT [DF__categorie__as_of__778AC167]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[competitors] ADD  CONSTRAINT [DF__competitors__bib__4BAC3F29]  DEFAULT ('0') FOR [bib]
GO
ALTER TABLE [dbo].[competitors] ADD  CONSTRAINT [DF__competito__rank___4AB81AF0]  DEFAULT ((0)) FOR [rank_order]
GO
ALTER TABLE [dbo].[competitors] ADD  CONSTRAINT [DF_competitors_comp_withdrawn]  DEFAULT ((0)) FOR [comp_withdrawn]
GO
ALTER TABLE [dbo].[competitors] ADD  CONSTRAINT [DF__competito__as_of__787EE5A0]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[controls] ADD  CONSTRAINT [DF__controls__as_of___797309D9]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[course_codes] ADD  CONSTRAINT [DF__course_co__as_of__1332DBDC]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[courses] ADD  CONSTRAINT [DF__courses__as_of_d__14270015]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[entry_competitors] ADD  CONSTRAINT [DF_entry_competitor_rank]  DEFAULT ((0)) FOR [rank_order]
GO
ALTER TABLE [dbo].[entry_competitors] ADD  CONSTRAINT [DF_entry_competitor_as_of]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[entry_teams] ADD  CONSTRAINT [DF_entry_teams_as_of_date]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[entry_xml] ADD  CONSTRAINT [DF__entry_xml__team___7B264821]  DEFAULT ((0)) FOR [team_bib]
GO
ALTER TABLE [dbo].[leg_exceptions] ADD  CONSTRAINT [DF_leg_exceptions_as_of_date]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[legs] ADD  CONSTRAINT [DF__legs__as_of_date__7D439ABD]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[logs] ADD  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[settings] ADD  CONSTRAINT [DF__settings__as_of___7F2BE32F]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[si_readout] ADD  CONSTRAINT [DF__si_readou__as_of__00200768]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[si_stamps] ADD  CONSTRAINT [DF__si_stamps__as_of__01142BA1]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[slips] ADD  CONSTRAINT [DF__slips__as_of_dat__42E1EEFE]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[teams] ADD  CONSTRAINT [DF__teams__as_of_dat__70A8B9AE]  DEFAULT (getdate()) FOR [as_of_date]
GO
ALTER TABLE [dbo].[competitors]  WITH CHECK ADD  CONSTRAINT [FK_competitors_teams] FOREIGN KEY([team_id])
REFERENCES [dbo].[teams] ([team_id])
GO
ALTER TABLE [dbo].[competitors] CHECK CONSTRAINT [FK_competitors_teams]
GO
ALTER TABLE [dbo].[course_codes]  WITH CHECK ADD  CONSTRAINT [FK_course_codes_controls] FOREIGN KEY([control_id])
REFERENCES [dbo].[controls] ([control_id])
GO
ALTER TABLE [dbo].[course_codes] CHECK CONSTRAINT [FK_course_codes_controls]
GO
ALTER TABLE [dbo].[course_codes]  WITH CHECK ADD  CONSTRAINT [FK_course_codes_courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([course_id])
GO
ALTER TABLE [dbo].[course_codes] CHECK CONSTRAINT [FK_course_codes_courses]
GO
ALTER TABLE [dbo].[legs]  WITH CHECK ADD  CONSTRAINT [FK_legs_competitors] FOREIGN KEY([comp_id])
REFERENCES [dbo].[competitors] ([comp_id])
GO
ALTER TABLE [dbo].[legs] CHECK CONSTRAINT [FK_legs_competitors]
GO
ALTER TABLE [dbo].[legs]  WITH CHECK ADD  CONSTRAINT [FK_legs_courses1] FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([course_id])
GO
ALTER TABLE [dbo].[legs] CHECK CONSTRAINT [FK_legs_courses1]
GO
ALTER TABLE [dbo].[si_stamps]  WITH CHECK ADD  CONSTRAINT [FK_si_stamps_si_readout] FOREIGN KEY([readout_id])
REFERENCES [dbo].[si_readout] ([readout_id])
GO
ALTER TABLE [dbo].[si_stamps] CHECK CONSTRAINT [FK_si_stamps_si_readout]
GO
ALTER TABLE [dbo].[teams]  WITH CHECK ADD  CONSTRAINT [FK_teams_categories] FOREIGN KEY([cat_id])
REFERENCES [dbo].[categories] ([cat_id])
GO
ALTER TABLE [dbo].[teams] CHECK CONSTRAINT [FK_teams_categories]
GO
/****** Object:  StoredProcedure [dbo].[get_competitor]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_competitor]
	@chip_id INT
AS
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 2021-01-07
-- Description:	returns competitor_id based on chip_id
-- =============================================
/*
declare @chip_id INT = 8914
execute get_competitor
	@chip_id INT
*/
BEGIN
	SET NOCOUNT ON;

	SELECT comp_id FROM dbo.competitors
	WHERE comp_chip_id = @chip_id

END
GO
/****** Object:  StoredProcedure [dbo].[get_course_results_json]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_course_results_json]
	@cat_name varchar(50) = ''
AS
/*
Create date: 2023-07-21
Description: get json string of all course results
*/
/*
DECLARE @cat_name varchar(50) = ''

EXECUTE dbo.get_course_results_json
	@cat_name
*/
BEGIN

	SET NOCOUNT ON;

--drop table #temp_legs
CREATE TABLE #temp_legs(
	leg_id int NOT NULL PRIMARY KEY,
	class_name nvarchar(20) NOT NULL,
	team_id INT NULL,
	team_nr INT NULL,
	team_name NVARCHAR(255) NULL,
	comp_bib NVARCHAR(10) NOT NULL,
	leg_course nvarchar(20) NOT NULL,
	leg_length int NULL,
	leg_climb int NULL,
	comp_name nvarchar(50) NULL,
	leg_time varchar(15) NULL,
	start_dtime datetime NULL,
	leg_start nvarchar(4000) NULL,
	leg_finish nvarchar(4000) NULL,
	finish_dtime DATETIME NULL,
	leg_status nvarchar(10) NULL,
	dsk_penalty time(7) NULL,
	leg_valid bit NULL,
	splits nvarchar(max) NULL
)

INSERT INTO #temp_legs
           (
			leg_id,
			class_name,
			team_id,
			team_nr,
			team_name,
			comp_bib,
			leg_course,
			leg_length,
			leg_climb
           ,comp_name
           ,leg_time
           ,start_dtime
           ,leg_start
           ,leg_finish
		   ,finish_dtime
           ,leg_status
           ,dsk_penalty
           ,leg_valid
           ,splits
		   )
	SELECT 
		max(s.leg_id) as leg_id,
		s.cat_name AS class_name,
		s.team_id,
		s.team_nr,
		s.team_name,
		s.bib AS comp_bib,
		s.course_name as leg_course,
		s.course_length as leg_length,
		s.course_climb as leg_climb,
		s.comp_name, 
		s.leg_time,
		s.start_dtime,
		FORMAT(s.start_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_start,
		FORMAT(s.finish_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_finish,
		s.finish_dtime,
		s.leg_status,
		s.dsk_penalty,
		s.valid_flag AS leg_valid,
		(
			SELECT 
				--readout_id,
				--punch_index,
				position,
				control_code,
				--punch_dtime,
				punch_time,
				--lap_dtime,
				lap_time,
				leg_time
			FROM dbo.slips		
			WHERE 
				readout_id = max(s.readout_id)
			order by position
			FOR JSON PATH--, 
				--INCLUDE_NULL_VALUES
		) AS splits
	FROM dbo.slips AS s
	inner join dbo.teams as t on s.team_id = t.team_id
	where t.team_did_start = 1
	group by 		
		s.cat_name,
		s.team_id,
		s.team_nr,
		s.team_name,
		s.bib,
		s.course_name,
		s.course_length,
		s.course_climb,
		s.comp_name, 
		s.leg_time,
		s.start_dtime,
		s.start_dtime,
		s.finish_dtime,
		s.leg_status,
		s.dsk_penalty,
		s.valid_flag
	--ORDER BY s.course_name, 
	--leg_time desc
	;

--select * from #temp_legs order by leg_id

	DECLARE @ResultJson nvarchar(max)
	SET @ResultJson =
	(
		SELECT DISTINCT
			sli.leg_course,
			(
				SELECT
					l.class_name,
					l.team_nr,
					--team_id,
					l.team_name,
					l.comp_bib,
					l.comp_name,
					l.leg_id,
					l.leg_time,
					FORMAT(l.start_dtime, N'dd.MM.yyyy HH\:mm\:ss') as start_time,
					l.leg_start,
					l.leg_finish,
					l.leg_status,
					l.leg_valid,
					l.dsk_penalty,
					json_query(l.splits) as splits
				from #temp_legs as l
				where l.leg_course = sli.leg_course
				order by l.leg_course,
					CASE
					WHEN l.leg_status = 'OK'
					THEN 1
					ELSE 0
				   END DESC, 
				   l.leg_time
				FOR JSON PATH--, 
					--INCLUDE_NULL_VALUES
			) AS legs
			FROM (
				SELECT DISTINCT 
					leg_course 
				FROM #temp_legs
				--where team_id = 99
				WHERE class_name = @cat_name
					OR @cat_name = ''
			) AS sli
			ORDER BY leg_course
			FOR JSON PATH
	)
	SELECT @ResultJson as course_results
END
GO
/****** Object:  StoredProcedure [dbo].[get_one_competitor_json]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_one_competitor_json]
	@comp_id int
AS
/*
-- Author:		<Author,,Name>
-- Create date: 2023-06-01
-- Description:	returns competitor as json string

execute dbo.get_one_competitor_json 8
*/
BEGIN
	SET NOCOUNT ON;

	SELECT 
		team_id
		,team_nr
		,team_name
		,comp_id
		,comp_chip_id
		,comp_name
		,bib
		--,cat_id
		,cat_name
	FROM dbo.v_comp_teams
	WHERE comp_id = @comp_id
	FOR JSON PATH, INCLUDE_NULL_VALUES

END
GO
/****** Object:  StoredProcedure [dbo].[get_one_entry_json]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_one_entry_json]
	-- Add the parameters for the stored procedure here
	@team_id int
AS
/*
-- Author:		<Author,,Name>
-- Create date: 2022-07-25
-- Description:	returns entries of one team as json string

execute get_one_entry_json 43
*/
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		ca.cat_name,
		--ca.valid,
		t.team_nr,
		t.team_name,
		t.team_id,
		0 as team_wdrn_penalty,
		(
			SELECT
				c.comp_name,
				c.bib AS comp_bib,
				c.comp_chip_id AS siid,
				c.comp_withdrawn,
				c.comp_valid_flag,
				c.rank_order AS team_rank,
				c.team_id
			FROM   competitors AS c
			WHERE c.team_id = t.team_id FOR JSON PATH, INCLUDE_NULL_VALUES
		) AS comp
	FROM categories AS ca
	INNER JOIN teams AS t
		ON ca.cat_id = t.cat_id
	where t.team_id = @team_id
	FOR JSON PATH, INCLUDE_NULL_VALUES

END
GO
/****** Object:  StoredProcedure [dbo].[get_results_json]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_results_json]
	@cat_name varchar(50) = ''
AS
/*
Create date: 2023-07-21
Description: get json string of all results
*/
/*
DECLARE @cat_name varchar(50) = ''

EXECUTE dbo.get_results_json
	@cat_name
*/
BEGIN

	SET NOCOUNT ON;

--drop table #temp_legs
CREATE TABLE #temp_legs(
	leg_id int NOT NULL PRIMARY KEY,
	class_name nvarchar(20) NOT NULL,
	team_id INT NULL,
	team_nr INT NULL,
	team_name NVARCHAR(255) NULL,
	comp_bib NVARCHAR(10) NOT NULL,
	leg_course nvarchar(20) NOT NULL,
	leg_length int NULL,
	leg_climb int NULL,
	comp_name nvarchar(50) NULL,
	leg_time varchar(15) NULL,
	start_dtime datetime NULL,
	leg_start nvarchar(4000) NULL,
	leg_finish nvarchar(4000) NULL,
	finish_dtime DATETIME NULL,
	leg_status nvarchar(10) NULL,
	dsk_penalty time(7) NULL,
	leg_valid bit NULL,
	splits nvarchar(max) NULL
)

INSERT INTO #temp_legs
           (
			leg_id,
			class_name,
			team_id,
			team_nr,
			team_name,
			comp_bib,
			leg_course,
			leg_length,
			leg_climb
           ,comp_name
           ,leg_time
           ,start_dtime
           ,leg_start
           ,leg_finish
		   ,finish_dtime
           ,leg_status
           ,dsk_penalty
           ,leg_valid
           ,splits
		   )
	SELECT DISTINCT 
		s.leg_id,
		s.cat_name AS class_name,
		s.team_id,
		t.team_nr,
		t.team_name,
		s.bib AS comp_bib,
		s.course_name as leg_course,
		s.course_length as leg_length,
		s.course_climb as leg_climb,
		s.comp_name, 
		s.leg_time,
		s.start_dtime,
		FORMAT(s.start_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_start,
		FORMAT(s.finish_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_finish,
		s.finish_dtime,
		s.leg_status,
		s.dsk_penalty,
		s.valid_flag AS leg_valid,
		(
			SELECT 
				--readout_id,
				--punch_index,
				position,
				control_code,
				--punch_dtime,
				punch_time,
				--lap_dtime,
				lap_time,
				leg_time
			FROM dbo.slips		
			WHERE 
				readout_id = s.readout_id
			order by position
			FOR JSON PATH--, 
				--INCLUDE_NULL_VALUES
		) AS splits
	FROM dbo.slips AS s
	inner join dbo.teams as t on s.team_id = t.team_id
	where t.team_did_start = 1;

--select * from #temp_legs order by leg_id

	--drop table #temp_teams
	CREATE TABLE #temp_teams(
		class_name NVARCHAR(50) NOT NULL,
		team_nr INT NOT NULL,
		team_id int not null primary key,
		team_name NVARCHAR(255) NULL,
		legs_count INT NOT NULL,
		courses_length INT NOT NULL,
		team_time DATETIME NULL,
		legs nvarchar(max) NULL
	)
	CREATE INDEX ix_class_name
	ON #temp_teams (class_name); 

		INSERT INTO #temp_teams (
			class_name,
			team_nr,
			team_id,
			team_name,
			legs_count,
			courses_length,
			team_time,
			legs
			)
		SELECT 
			sl.class_name,
			sl.team_nr,
			sl.team_id,
			sl.team_name,
			COUNT(DISTINCT CASE WHEN sl.leg_valid = 1 THEN sl.leg_course END) as legs_count,
			SUM(CASE WHEN sl.leg_valid = 1 THEN sl.leg_length END) as courses_length,
			MAX(CASE WHEN sl.leg_valid = 1 THEN sl.finish_dtime ELSE '2000-01-01' END) as team_time,
			(
				SELECT 
					leg_id,
					comp_bib,
					leg_course,
					--leg_length,
					leg_climb,
				   comp_name,
				   leg_time,
				   --start_dtime,
				   leg_start,
				   leg_finish,
				   leg_status,
				   dsk_penalty,
				   leg_valid,
				   json_query(splits) as splits
				FROM #temp_legs as t
				WHERE t.team_id = sl.team_id
				ORDER BY t.start_dtime
					FOR JSON PATH--, 
						--INCLUDE_NULL_VALUES
			) AS legs
			FROM #temp_legs as sl
		GROUP BY
			sl.class_name,
			sl.team_nr,
			sl.team_id,
			sl.team_name
		ORDER BY sl.class_name, sl.team_nr

--select * from #temp_teams

	DECLARE @ResultJson nvarchar(max)
	SET @ResultJson =
	(
		SELECT DISTINCT
			sli.class_name,
			(
				SELECT
					--class_name,
					team_nr,
					--team_id,
					team_name,
					legs_count,
					courses_length,
					FORMAT(team_time, N'dd.MM.yyyy HH\:mm\:ss') as team_time,
					json_query(legs) as legs
				from #temp_teams as t
				where t.class_name = sli.class_name
				order by class_name, legs_count desc, team_time
				FOR JSON PATH--, 
					--INCLUDE_NULL_VALUES
			) AS teams
			FROM (
				SELECT DISTINCT 
					class_name 
				FROM #temp_teams
				--where team_id = 99
				WHERE class_name = @cat_name
					OR @cat_name = ''
			) AS sli
			ORDER BY class_name
			FOR JSON PATH
	)
	SELECT @ResultJson
END
GO
/****** Object:  StoredProcedure [dbo].[get_slip_json]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_slip_json]
-- Add the parameters for the stored procedure here
	@readout_id INT
AS
/*
Create date: 2022-07-28
Description: get json string of slip
*/
/*
DECLARE @readout_id INT = 1150

EXECUTE dbo.get_slip_json
	@readout_id
*/
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @ResultJson nvarchar(max)
	set @ResultJson =
	(
	SELECT DISTINCT 
		s.cat_name AS class_name,
		s.team_nr,
		s.team_name,
		s.team_id,
		s.bib AS comp_bib,
		s.course_name as leg_course,
		s.course_length as leg_length,
		s.course_climb as leg_climb,
		s.leg_id,
		s.comp_name, 
		s.chip_id AS siid, 
		s.leg_time,
		FORMAT(s.start_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_start,
		FORMAT(s.finish_dtime, N'dd.MM.yyyy HH\:mm\:ss') AS leg_finish,
		s.leg_status,
		c.rank_order AS team_rank,
	--	0 AS finishtimems,
	--	0 AS timems,
		s.comp_id, 
		s.readout_id,
		s.dsk_penalty,
		s.valid_flag AS leg_valid,
		FORMAT(s.team_race_end, N'dd.MM.yyyy HH\:mm\:ss') AS team_race_end,
		(
			SELECT 
				punch_index,
				position,
				control_code,
				punch_dtime,
				punch_time,
				lap_dtime,
				lap_time,
				leg_time
			FROM dbo.slips		
			WHERE 
				readout_id = s.readout_id
			FOR JSON PATH, 
				INCLUDE_NULL_VALUES
		) AS sp
	FROM dbo.slips AS s
	inner join competitors as c on s.comp_id = c.comp_id
	WHERE s.readout_id = @readout_id
	FOR JSON path
	)
	select @ResultJson
END
GO
/****** Object:  StoredProcedure [dbo].[rpt_results]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rpt_results]
    @category_id INT = NULL
AS
/*
 Create date: 2022-10-02
 Description:    shows results

 declare @category_id int = 2
 exec rpt_results @category_id

*/
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
/*        select
            max(a.sum_legs) over (partition by a.team_id) as total_legs
            ,a.team_name
            ,a.team_nr
            ,a.team_id
            ,a.comp_name
            ,a.bib
            ,a.finish_time
            ,a.course_id
            ,a.valid_leg
            ,a.leg_status
            ,a.sum_legs
            ,a.max_finish
            ,a.race_end
        from
        (*/
            SELECT
				t.cat_id,
                t.team_name,
                t.team_nr,
                t.team_id,
                t.race_end,
                c.comp_name,
                c.bib,
                l.start_time,
                l.finish_time,
                l.leg_time,
                l.leg_status,
                l.course_id,
                CASE
                  WHEN l.leg_status = 'OK'
                       AND l.finish_dtime < t.race_end
                  THEN 1
                  ELSE 0
                END AS valid_leg,
                SUM(CASE
                    WHEN l.leg_status = 'OK'
                         AND l.finish_dtime < t.race_end
                    THEN 1
                    ELSE 0
                    END) OVER(PARTITION BY t.team_id ORDER BY l.finish_dtime) AS sum_legs,
                --MAX(l.finish_dtime) OVER(PARTITION BY t.team_id) as max_finish
                MAX(l.finish_time) OVER(PARTITION BY t.team_id) as max_finish
            FROM  dbo.legs AS l
            INNER JOIN dbo.competitors AS c
                ON l.comp_id = c.comp_id
            INNER JOIN dbo.teams AS t
                ON t.team_id = c.team_id
            WHERE t.cat_id = @category_id
                  OR @category_id IS NULL
--        ) as a
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_check_courses]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_check_courses]
AS
/*
	Create date: 2023-01-14
	Description:	checks all courses for intersection with another one

execute dbo.sp_check_courses
*/
BEGIN
	SET NOCOUNT ON;


	DECLARE @same_courses TABLE(
		course_id INT NOT NULL,
		course_name NVARCHAR(20) NOT NULL,
		control_code NVARCHAR(20) NULL,
		course_name1 NVARCHAR(20) NOT NULL
	)

	DECLARE @course_id INT
	DECLARE @course_name NVARCHAR(20)
	
	DECLARE course_cursor CURSOR FOR 
	SELECT 
		course_id,
		course_name
	from dbo.courses

	OPEN course_cursor  
	FETCH NEXT FROM course_cursor INTO @course_id, @course_name

	WHILE @@FETCH_STATUS = 0  
	BEGIN  

		WITH courses_cte AS (
			SELECT
				c.course_id
			   ,c.course_name
			   ,con.control_code
			   ,cc.position
			   ,cc.cc_status
			FROM
				dbo.courses AS c
				INNER JOIN dbo.course_codes AS cc ON c.course_id = cc.course_id
				INNER JOIN dbo.controls AS con ON cc.control_id = con.control_id
			WHERE
				con.control_code NOT IN ('F', 'F1', 'S1', 'S')
		)
		,punches_cte AS (
			SELECT 
				cc.control_id,
				co.control_code,
				cc.position
			FROM course_codes AS cc
			inner join controls AS co ON cc.control_id = co.control_id
			WHERE course_id = @course_id
			and cc.control_id <> 'S1'
		)
		,course_punch AS (
			SELECT
				c.course_id
			   ,c.course_name
			   ,c.control_code
			   ,c.position
			   ,c.cc_status
			   ,p.control_code AS p_control_code
			   ,p.position as punch_index
			FROM
				courses_cte AS c
				LEFT OUTER JOIN punches_cte AS p ON c.control_code = p.control_code
		)
		,all_missing AS (
			SELECT  DISTINCT
					cp.course_id
				   ,cp.course_name
			FROM
					course_punch AS cp
					LEFT OUTER JOIN punches_cte AS pc ON cp.control_code = pc.control_code
														 AND cp.position <= pc.position
			WHERE
					pc.control_code IS NULL
		)
		INSERT INTO @same_courses 
		(
			course_id,
			course_name,
			course_name1
		)
		SELECT  DISTINCT
				@course_id,
				@course_name,
				cp.course_name as course_name1
		FROM
				course_punch AS cp
				LEFT OUTER JOIN all_missing AS am ON cp.course_id = am.course_id
		WHERE
				am.course_id IS NULL
				and cp.course_id <> @course_id

	FETCH NEXT FROM course_cursor INTO @course_id, @course_name
	END 

	CLOSE course_cursor
	DEALLOCATE course_cursor


	SELECT * FROM @same_courses
	ORDER BY course_name, course_name1

END
GO
/****** Object:  StoredProcedure [dbo].[sp_fill_calendar]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_fill_calendar]
	-- Add the parameters for the stored procedure here
	@StartDate  date,
	@years int
AS
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 2023-04-10
-- Description:	fills Calendar table
-- =============================================
/*
execute sp_fill_calendar '2023-01-01', 5
*/
BEGIN
	SET NOCOUNT ON;

	SET DATEFIRST 1;
	truncate table dbo.calendar

	DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, @years, @StartDate));

	;WITH seq(n) AS 
	(
	  SELECT 0 UNION ALL SELECT n + 1 FROM seq
	  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
	),
	d(d) AS 
	(
	  SELECT DATEADD(DAY, n, @StartDate) FROM seq
	),
	src AS
	(
	  SELECT
		TheDate         = CONVERT(date, d),
		TheDateTime = convert(datetime, d),
		TheDay          = DATEPART(DAY,       d),
		TheDayName      = DATENAME(WEEKDAY,   d),
		TheDayOfWeek    = DATEPART(WEEKDAY,   d)
	  FROM d
	)
	insert into dbo.calendar (
		TheDate,
		TheDateTime,
		TheDay,
		TheDayName,
		TheDayOfWeek)
	select
		TheDate,
		TheDateTime,
		TheDay,
		TheDayName,
		TheDayOfWeek
	FROM src
	  ORDER BY TheDate
	  OPTION (MAXRECURSION 0)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_fill_results]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_fill_results]
    @category_id INT = NULL
AS
/*
 Create date: 2022-10-02
 Description: fills results

 declare @category_id int = null
 exec sp_fill_results

*/
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

		delete from dbo.results

		insert into dbo.results(
			cat_id,
            team_name,
            team_nr,
            team_id,
            race_end,
            comp_name,
            bib,
            start_time,
            finish_time,
            leg_time,
            leg_status,
            course_id,
            valid_leg,
            sum_legs,
			max_finish
		)
        SELECT
			t.cat_id,
            t.team_name,
            t.team_nr,
            t.team_id,
            t.race_end,
            c.comp_name,
            c.bib,
            l.start_time,
            l.finish_time,
            l.leg_time,
            l.leg_status,
            l.course_id,
            CASE
                WHEN l.leg_status = 'OK'
                    AND l.finish_dtime < t.race_end
                THEN 1
                ELSE 0
            END AS valid_leg,
            SUM(CASE
                WHEN l.leg_status = 'OK'
                        AND l.finish_dtime < t.race_end
                THEN 1
                ELSE 0
                END) OVER(PARTITION BY t.team_id ORDER BY l.finish_dtime) AS sum_legs,
            --MAX(l.finish_dtime) OVER(PARTITION BY t.team_id) as max_finish
            MAX(l.finish_time) OVER(PARTITION BY t.team_id) as max_finish
        FROM  dbo.legs AS l
        INNER JOIN dbo.competitors AS c
            ON l.comp_id = c.comp_id
        INNER JOIN dbo.teams AS t
            ON t.team_id = c.team_id
        WHERE t.cat_id = @category_id
                OR @category_id IS NULL

    END
GO
/****** Object:  StoredProcedure [dbo].[sp_generate_legs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_generate_legs]
	@prefix varchar(5)
AS
/*
Create date: 2022-06-14
Description: creates records in legs for first relay legs


declare @prefix varchar(3) = 'YZa'
execute sp_generate_legs @prefix
*/
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO legs(comp_id, course_id, valid_flag)
	SELECT 
		c.comp_id, 
		cr.course_id,
		1
	FROM competitors AS c
	INNER JOIN teams AS t 
		ON c.team_id = t.team_id
	INNER JOIN courses AS cr 
		ON @prefix + CAST(t.team_nr AS NVARCHAR(4)) + '.' + CAST(c.rank_order AS NVARCHAR(4)) = cr.course_name

	SELECT @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_guess_course]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_guess_course]
    @readout_id INT
AS
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 2021-01-07
-- Description:	returns most likely course_id
-- =============================================
/*
DECLARE @readout_id int = 48

EXECUTE dbo.sp_guess_course 
   @readout_id

*/
BEGIN
    SET NOCOUNT ON;

    WITH courses_cte AS (
        SELECT
            c.course_id
           ,c.course_name
           ,con.control_code
           ,cc.position
           ,cc.cc_status
        FROM
            dbo.courses AS c
            INNER JOIN dbo.course_codes AS cc ON c.course_id = cc.course_id
            INNER JOIN dbo.controls AS con ON cc.control_id = con.control_id
        WHERE
            con.control_code NOT IN ('F', 'F1', 'S1', 'S')
    )
        ,punches_cte AS (
        SELECT
            r.readout_id
           ,r.chip_id
           ,CAST(s.control_code AS VARCHAR(5)) AS control_code
           ,s.punch_datetime
           ,s.punch_index
        FROM
            dbo.si_readout AS r
            INNER JOIN dbo.si_stamps AS s ON r.readout_id = s.readout_id
        WHERE
            r.readout_id = @readout_id
    )
    ,course_punch AS (
        SELECT
            c.course_id
           ,c.course_name
           ,c.control_code
           ,c.position
           ,c.cc_status
           ,p.readout_id
           ,p.control_code AS p_control_code
           ,p.punch_index
        FROM
            courses_cte AS c
            LEFT OUTER JOIN punches_cte AS p ON c.control_code = p.control_code
    )
	,all_missing AS (
        SELECT  DISTINCT
                cp.course_id
               ,cp.course_name
        FROM
                course_punch AS cp
                LEFT OUTER JOIN punches_cte AS pc ON cp.control_code = pc.control_code
                                                     AND cp.position <= pc.punch_index
        WHERE
                pc.readout_id IS NULL
    )
    SELECT  DISTINCT
            cp.course_id
    FROM
            course_punch AS cp
            LEFT OUTER JOIN all_missing AS am ON cp.course_id = am.course_id
    WHERE
            am.course_id IS NULL
--ORDER BY
--    cp.course_name
--   ,cp.position

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_xml_entries]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_xml_entries]
AS
/*
Create date: 2023-03-20
Description:	inserts competitors and teams from xml
*/
/*
	exec sp_ins_xml_entries
*/

BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	DECLARE @cte_max_nr TABLE
	(
		cat_id INT NOT NULL PRIMARY KEY CLUSTERED,
		max_nr INT NULL
	)

	-- insert teams

	INSERT INTO @cte_max_nr
	(
		cat_id,
		max_nr
	)
	SELECT
		a.cat_id,
	(
		SELECT
			MAX(v)
		FROM(VALUES
		(
					a.first_start_number
		),
		(
					a.team_nr
		)) AS value(v)
	) AS max_nr
	FROM
	(
		SELECT
			MAX(c.first_start_number) AS first_start_number,
			MAX(t.team_nr) AS team_nr,
			c.cat_id
		FROM categories AS c
		LEFT OUTER JOIN teams AS t
			ON t.cat_id = c.cat_id
		GROUP BY
			c.cat_id
	) AS a


	INSERT INTO dbo.teams
	(
		team_nr,
		team_name,
		team_abbr,
		team_did_start,
		team_status,
		cat_id,
		oris_id,
		race_end
	)
	SELECT
		RANK() OVER(PARTITION BY e.class_name
		ORDER BY
		e.oris_team_id) + mn.max_nr AS nr,
		e.team_short_name AS team_name,
		e.team_name AS team_abbr,
		1 AS team_start,
		1 AS team_status,
		c.cat_id,
		e.oris_team_id,
		DATEADD(MINUTE,c.cat_time_limit,CAST(s.config_value AS DATETIME)) AS race_end
	FROM  dbo.entry_xml AS e
	LEFT OUTER JOIN dbo.categories AS c
		ON e.class_name = c.cat_name
	INNER JOIN dbo.settings AS s
		ON s.config_name = 'start_time'
	LEFT OUTER JOIN dbo.teams AS t
		ON t.oris_id = e.oris_team_id
	LEFT OUTER JOIN @cte_max_nr AS mn
		ON c.cat_id = mn.cat_id
	WHERE t.oris_id IS NULL
	GROUP BY
		c.cat_id,
		e.class_name,
		e.team_short_name,
		e.team_name,
		oris_team_id,
		c.cat_id,
		c.first_start_number,
		c.cat_time_limit,
		s.config_value,
		mn.max_nr
	ORDER BY
		nr,
		e.class_name,
		e.oris_team_id

	--update

	UPDATE t
	SET
		team_name = e.team_short_name,
		team_abbr = e.team_name,
		cat_id = c.cat_id,
		race_end = DATEADD(MINUTE,c.cat_time_limit,CAST(s.config_value AS DATETIME))
	FROM   dbo.teams AS t
	INNER JOIN dbo.entry_xml AS e
		ON t.oris_id = e.oris_team_id
	INNER JOIN dbo.settings AS s
		ON s.config_name = 'start_time'
	LEFT OUTER JOIN dbo.categories AS c
		ON e.class_name = c.cat_name
	LEFT OUTER JOIN @cte_max_nr AS mn
		ON c.cat_id = mn.cat_id

	--insert cometitors

	;WITH cte_comp_max
		 AS (SELECT
				 MAX(e.leg) AS max_leg,
				 oris_team_id
			 FROM  entry_xml AS e
			 WHERE NOT(e.family = ''
					   AND e.given = ''
					   AND e.gender = ''
					   AND e.si_chip = 0)
			 GROUP BY
				 oris_team_id)
		 INSERT INTO dbo.competitors
		 (
			 comp_name,
			 bib,
			 comp_chip_id,
			 rented_chip,
			 team_id,
			 rank_order,
			 comp_status,
			 comp_valid_flag,
			 comp_country,
			 comp_birthday
		 )
		 SELECT
			 e.family + ' ' + e.given AS comp_name,
			 CAST(t.team_nr AS VARCHAR(3)) + CHAR(64 + e.leg) AS bib,
			 e.si_chip,
			 0 AS rented,
			 t.team_id,
			 e.leg AS rank_order,
			 1 AS comp_status,
			 1 AS valid_fl,
			 e.country,
			 e.birth_date
		 FROM  dbo.entry_xml AS e
		 INNER JOIN cte_comp_max AS cm
			 ON e.oris_team_id = cm.oris_team_id
		 INNER JOIN dbo.teams AS t
			 ON e.oris_team_id = t.oris_id
		 LEFT OUTER JOIN competitors AS c
			 ON CAST(t.team_nr AS VARCHAR(3)) + CHAR(64 + e.leg) = c.bib
		 WHERE e.leg <= cm.max_leg
			   AND c.bib IS NULL

	UPDATE c
	SET
		comp_name = e.family + ' ' + e.given,
		comp_chip_id = e.si_chip,
		rank_order = e.leg,
		comp_country = e.country,
		comp_birthday = e.birth_date
	FROM   dbo.competitors AS c
	INNER JOIN dbo.teams AS t
		ON c.team_id = t.team_id
	INNER JOIN dbo.entry_xml AS e
		ON CAST(t.team_nr AS VARCHAR(3)) + CHAR(64 + e.leg) = c.bib
		   AND t.oris_id = e.oris_team_id

	select @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_slips]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insert_slips]
	@leg_id INT
AS
/*
	Create date: 2022-02-24
	Description: Inserts records to slips

DECLARE @leg_id INT = 22;
EXEC dbo.sp_insert_slips @leg_id
*/
	BEGIN
		SET NOCOUNT ON

		DECLARE @OutputTbl TABLE (ID INT)

		DELETE FROM slips WHERE leg_id = @leg_id

--DECLARE @leg_id int = 909;
		
		;WITH cte_pu AS (
			SELECT
				r.readout_id,
				l.leg_id,
				r.chip_id,
				s.control_code,
				s.punch_datetime,
				s.punch_wday,
				r.card_readout_datetime,
				CAST(r.card_readout_datetime AS DATE) AS card_readout_date,
				s.punch_index,
				r.clear_datetime,
				r.check_datetime
			FROM   
				dbo.si_readout AS r
			INNER JOIN dbo.si_stamps AS s
				ON r.readout_id = s.readout_id
			INNER JOIN dbo.legs AS l
				ON l.readout_id = r.readout_id
			WHERE l.leg_id = @leg_id
			AND l.valid_flag = 1
			UNION ALL
			SELECT
				l.readout_id,
				l.leg_id,
				r.chip_id,
				'F' AS control_code,
				CASE WHEN l.finish_time <> '' THEN l.finish_dtime ELSE NULL END AS finish_dtime,
				'NA' AS punch_wday,
				r.card_readout_datetime,
				CAST(r.card_readout_datetime AS DATE) AS card_readout_date,
				999 AS punch_index,
				r.clear_datetime,
				r.check_datetime
			FROM  
				dbo.legs AS l
			INNER JOIN dbo.si_readout AS r
				ON l.readout_id = r.readout_id
			WHERE l.leg_id = @leg_id
			AND l.valid_flag = 1
		)
--		select * from cte_pu
		,cte_pu_dtime AS (
			SELECT
				pu.readout_id,
				pu.leg_id,
				pu.chip_id,
				pu.control_code,
				pu.card_readout_datetime,
				ISNULL(CASE WHEN pu.chip_id < 500000 THEN
					CASE
					WHEN CAST(pu.card_readout_datetime AS TIME) < '12:00:00'
					THEN CASE
							WHEN CAST(pu.punch_datetime AS TIME) <= CAST(pu.card_readout_datetime AS TIME)
							THEN DATEADD(d,0,DATEDIFF(d,0,pu.card_readout_datetime)) + CAST(CAST(pu.punch_datetime AS TIME) AS DATETIME)
							ELSE DATEADD(d,0,DATEDIFF(d,0,pu.card_readout_datetime) - 1) + CAST(DATEADD(HOUR,12,CAST(pu.punch_datetime AS TIME)) AS DATETIME)
							END
					ELSE CASE
							WHEN CAST(pu.punch_datetime AS TIME) <= CAST(DATEADD(HOUR,-12,pu.card_readout_datetime) AS TIME)
							THEN DATEADD(d,0,DATEDIFF(d,0,pu.card_readout_datetime)) + CAST(CAST(DATEADD(HOUR,12,pu.punch_datetime) AS TIME) AS DATETIME)
							WHEN CAST(pu.punch_datetime AS TIME) <= CAST(pu.card_readout_datetime AS TIME)
							THEN DATEADD(d,0,DATEDIFF(d,0,pu.card_readout_datetime)) + CAST(CAST(pu.punch_datetime AS TIME) AS DATETIME)
							ELSE DATEADD(d,0,DATEDIFF(d,0,pu.card_readout_datetime) - 1) + CAST(CAST(pu.punch_datetime AS TIME) AS DATETIME)
							END
					END 
				ELSE
					c.TheDateTime + CAST(CAST(pu.punch_datetime AS TIME) AS DATETIME)
				END, pu.punch_datetime) AS punch_dtime,
				pu.punch_index,
				pu.clear_datetime,
				pu.check_datetime
			FROM cte_pu AS pu
			OUTER APPLY (SELECT TOP 1 TheDateTime FROM dbo.calendar 
			where pu.card_readout_date >= TheDate 
				and pu.punch_wday = TheDayName
			order by TheDate desc) as c
		)
--select * from cte_pu_dtime
		,cte_punches
			 AS (SELECT
					 b.readout_id,
					 b.leg_id,
					 b.chip_id,
					 b.control_code,
					 b.card_readout_datetime,
					 CASE
					   WHEN b.punch_dtime > b.next_punch
					   THEN DATEADD(HOUR,-12,b.punch_dtime)
					   ELSE b.punch_dtime
					 END AS punch_dtime,
					 b.punch_index,
					 b.clear_datetime,
					 b.check_datetime
				 FROM
				 (
					 SELECT
						 a.readout_id,
						 a.leg_id,
						 a.chip_id,
						 a.control_code,
						 a.card_readout_datetime,
						 a.punch_dtime,
						 a.punch_index,
						 LEAD(a.punch_dtime,1,'2990-01-01') OVER(ORDER BY a.readout_id, a.punch_index) AS next_punch,
						 a.clear_datetime,
						 a.check_datetime
					 FROM cte_pu_dtime AS a
				 ) AS b)
--select * from cte_punches
			,cte_legs AS (
				SELECT
					pun.readout_id,
					pun.leg_id,
					pun.chip_id,
					l.comp_id,
					pun.clear_datetime,
					pun.check_datetime,
					l.start_dtime,
					fin.punch_dtime AS finish_dtime,
					pun.card_readout_datetime,
					CONVERT(TIME, fin.punch_dtime - l.start_dtime) AS leg_time,
					l.course_id,
					l.leg_status,
					l.dsk_penalty,
					l.valid_flag
					--,RANK() over (partition by team order by l.start_dtime)
				FROM dbo.legs as l
				INNER JOIN cte_punches AS pun ON l.leg_id = pun.leg_id
				LEFT OUTER JOIN cte_punches AS fin
					 ON fin.control_code = 'F'
				GROUP BY
					pun.readout_id,
					pun.leg_id,
					pun.chip_id,
					l.comp_id,
					fin.punch_dtime,
					pun.card_readout_datetime,
					l.start_dtime,
					pun.clear_datetime,
					pun.check_datetime,
					l.course_id,
					l.leg_status,
					l.dsk_penalty,
					l.valid_flag
			)
--select * from cte_legs
			,cte_second_course as (
				select count(1) as same_courses
				from cte_legs as l
				inner join competitors as c on l.comp_id = c.comp_id
				inner join competitors as c2 on c.team_id = c2.team_id
				inner join legs as l2 on c2.comp_id = l2.comp_id and l.course_id = l2.course_id
					and l2.leg_status = 'OK'
				left outer join ( 
					select distinct 
						leg_id
					from 
						slips 
					where valid_flag = 1
				)as s
				on l2.leg_id = s.leg_id
				where s.leg_id is not null
			)
--select * from cte_second_course
			 ,cte_slip AS (
				SELECT
					 pun.readout_id,
					 pun.leg_id,
					 pun.control_code,
					 pun.punch_dtime,
					 pun.punch_index,
 					 CONVERT(TIME, pun.punch_dtime - 
						CASE WHEN LAG(pun.punch_dtime,1,0) OVER(ORDER BY pun.punch_index) = '1900-01-01' 
							THEN l.start_dtime
							ELSE LAG(pun.punch_dtime,1,0) OVER(ORDER BY pun.punch_index) 
						END) AS split_dtime,
					 CONVERT(TIME, pun.punch_dtime - l.start_dtime) AS punch_time
				 FROM cte_punches AS pun
				 LEFT OUTER JOIN cte_legs as l on pun.readout_id = l.readout_id
					 )
--select * from cte_slip
			,cte_controls AS
			(
				SELECT
					ISNULL(l.readout_id, p.readout_id) as readout_id,
					ISNULL(l.leg_id, p.leg_id) as leg_id,
					p.punch_index,
					cc.position,
					COALESCE(con.control_code, p.control_code, '') AS control_code,
					p.punch_dtime,
					CONVERT(VARCHAR(10), p.punch_time, 120) as punch_time,
					CASE WHEN cc.position IS NULL THEN NULL ELSE p.split_dtime END AS lap_dtime,
					CASE WHEN cc.position IS NULL THEN NULL ELSE CONVERT(VARCHAR(10), p.split_dtime, 120) END AS lap_time
				FROM  
					dbo.legs AS l
				INNER JOIN dbo.courses AS cou
					ON l.course_id = cou.course_id
				INNER JOIN dbo.course_codes AS cc
					ON cou.course_id = cc.course_id
				INNER JOIN dbo.controls AS con
					ON cc.control_id = con.control_id
					and con.control_code <> 'S1'
				FULL OUTER JOIN cte_slip AS p
					ON con.control_code = p.control_code
					AND l.readout_id = p.readout_id
					AND l.leg_id = p.leg_id
				WHERE l.leg_id = @leg_id OR p.leg_id = @leg_id
					AND (l.valid_flag = 1 OR l.valid_flag IS NULL)
			)
--select * from cte_controls
			 INSERT INTO dbo.slips
			 (
				 comp_id,
				 team_id,
				 course_id,
				 course_name,
				 course_length,
				 course_climb,
				 readout_id,
				 chip_id,
				 leg_id,
				 comp_name,
				 bib,
				 comp_country,
				 rented_chip,
				 team_nr,
				 team_name,
				 cat_name,
				 punch_index,
				 position,
				 control_code,
				 punch_dtime,
				 punch_time,
				 lap_dtime,
				 lap_time,
				 valid_flag,
				 clear_dtime,
				 clear_time,
				 check_dtime,
				 check_time,
				 start_dtime,
				 finish_dtime,
				 leg_time,
				 stamp_readout_dtime,
				 leg_status,
				 dsk_penalty,
				 team_race_end_zero,
				 team_race_end
			 )
			 OUTPUT INSERTED.slip_id INTO @OutputTbl(ID)
			SELECT 
				 com.comp_id,
				 com.team_id,
				 l.course_id,
				 cou.course_name,
				 cou.course_length,
				 cou.course_climb,
				 l.readout_id,
				 l.chip_id,
				 l.leg_id,
				 com.comp_name,
				 com.bib,
				 com.comp_country,
				 com.rented_chip,
				 t.team_nr,
				 t.team_name,
				 cat.cat_name,
				 cc.punch_index,
				 cc.position,
				 cc.control_code,
				 cc.punch_dtime,
				 cc.punch_time,
				 cc.lap_dtime,
				 cc.lap_time,
				 CASE WHEN t.race_end > l.finish_dtime AND l.leg_status = 'OK' and sc.same_courses < 1 THEN 1 ELSE 0 END AS valid_flag,
				 l.clear_datetime,
				 NULL AS clear_time,
				 l.check_datetime,
				 NULL AS check_time,
				 l.start_dtime,
				 l.finish_dtime,
				 format(l.leg_time, N'hh\:mm\:ss') AS leg_time,
				 l.card_readout_datetime,
				 l.leg_status,
				 l.dsk_penalty,
				 dbo.time_from_start(cat.cat_start_time, t.race_end) as team_race_end_zero,
				 t.race_end
			FROM cte_controls AS cc
			INNER JOIN cte_legs AS l
				ON cc.leg_id = l.leg_id
			INNER JOIN dbo.competitors AS com
				ON l.comp_id = com.comp_id
			INNER JOIN dbo.teams AS t
				ON com.team_id = t.team_id
			INNER JOIN dbo.categories AS cat
				ON t.cat_id = cat.cat_id
			INNER JOIN dbo.courses AS cou
				ON l.course_id = cou.course_id
			cross join cte_second_course as sc
			WHERE l.valid_flag = 1
		ORDER BY ISNULL(cc.position, 999), cc.punch_index

		SELECT o.ID FROM @OutputTbl AS o 
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_inset_wdr_slip]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_inset_wdr_slip] 
	@comp_id int
AS
/*
Create date: 2023-04-29
Description: inserts fake slip for withdrawn competitors
*/
/*
declare @comp_id int = 2351
exec sp_inset_wdr_slip @comp_id
*/
BEGIN
	SET NOCOUNT ON;

	declare @wd_course varchar(10)
	select @wd_course = config_value from settings where config_name = 'wdrn_course'

	INSERT INTO [dbo].[slips]
           ([comp_id]
           ,[team_id]
           ,[course_id]
           ,[course_name]
           ,[readout_id]
           ,[chip_id]
           ,[leg_id]
           ,[comp_name]
           ,[bib]
		   ,comp_country
		   ,rented_chip
		   ,team_name
           ,[cat_name]
		   ,course_length
		   ,course_climb
           ,[start_dtime]
		   ,clear_dtime
           ,[finish_dtime]
           ,[leg_time]
           ,[valid_flag]
           ,[leg_status]
           ,[dsk_penalty]
           ,[team_race_end_zero]
           ,[team_race_end])
	select 
		l.comp_id,
		c.team_id,
		l.course_id,
		co.course_name,
		r.readout_id,
		r.chip_id,
		l.leg_id,
		c.comp_name,
		c.bib,
		c.comp_country,
		c.rented_chip,
		t.team_name,
		ca.cat_name,
		co.course_length,
		co.course_climb,
		l.start_dtime,
		l.start_dtime as clear_dtime,
		l.finish_dtime,
		l.leg_time,
		0 as valid_flag,
		l.leg_status,
		l.dsk_penalty,
		dbo.time_from_start(ca.cat_start_time, t.race_end) as team_race_end_zero,
		t.race_end
	from si_readout as r
	inner join legs as l on r.readout_id = l.readout_id
	inner join competitors as c on l.comp_id = c.comp_id
	inner join courses as co on l.course_id = co.course_id
	inner join teams as t on c.team_id = t.team_id
	inner join categories as ca on t.cat_id = ca.cat_id
	where 
		l.comp_id = @comp_id
		and co.course_name = @wd_course
END
GO
/****** Object:  StoredProcedure [dbo].[sp_legs_assign_first]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_legs_assign_first]
	@course_prefix varchar(5),
	@category_id int
AS
/*
Create date: 2024-05-04
Description: creates records in legs for first legs - German version


declare @course_prefix varchar(3) = 'SF'
declare @category_id int = 16
execute sp_legs_assign_first @course_prefix, @category_id
*/
BEGIN
	SET NOCOUNT ON;

	INSERT INTO legs(comp_id, course_id, valid_flag)
	select
	co.comp_id,
	cr.course_id,
	1
	from teams as t
	inner join categories as ca on t.cat_id = ca.cat_id
	inner join competitors as co on t.team_id = co.team_id
		INNER JOIN courses AS cr 
			ON @course_prefix + char(97+(t.team_nr - ca.first_start_number) % 8) = cr.course_name
	where co.rank_order = 1
	and ca.cat_id = @category_id

	SELECT @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[sp_search_competitors]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_search_competitors]
	-- Add the parameters for the stored procedure here
	@s nvarchar(50)
AS
/*
Author:		<Author,,Name>
Create date: 2022-05-02
Description:	search competitors
*/
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select * from dbo.v_comp_teams
	where team_name like '%'+ @s+ '%'
	or comp_name  like '%'+ @s+ '%'
	or bib  like '%'+ @s+ '%'

END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_xml_entries_team_bib]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_update_xml_entries_team_bib]
AS
/*
Create date: 2023-09-23
Description: sets team_bib based on category and oris_team_id from xml entry file
*/
/*
	exec sp_update_xml_entries_team_bib
*/
BEGIN
	SET NOCOUNT ON;

	;WITH cte AS (
		SELECT 
			DENSE_RANK() OVER (PARTITION BY x.class_name ORDER BY x.class_name, x.oris_team_id) AS r,
			x.team_bib,
			isnull(c.first_start_number, 0) as first_start_number
		FROM dbo.entry_xml AS x
		left outer join dbo.categories as c on x.class_name = c.cat_name
	)
	UPDATE cte 
		SET team_bib = first_start_number + r -1
	;
	UPDATE dbo.entry_xml
	SET bib = CAST(team_bib AS VARCHAR(3)) + CHAR(64 + leg)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_upsert_legs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upsert_legs]
	@readout_id INT,
	@competitor_id INT,
	@course_id INT,
	@guessed_course INT,
	@upd char(2)
AS
/*
	Create date: 2022-02-23
	Description:	inserts card to legs, updates if record exists
*/
/*

DECLARE @readout_id INT = 149
DECLARE @competitor_id INT = 1152
DECLARE @course_id INT = 1067
DECLARE @guessed_course INT = 1067
DECLARE @upd char(2) = 'I'

exec dbo.sp_upsert_legs @readout_id, @competitor_id, @course_id, @guessed_course, @upd

*/
BEGIN
/*
DECLARE @readout_id INT = 125
DECLARE @competitor_id INT = 269
DECLARE @course_id INT = 285
DECLARE @guessed_course INT = 285
DECLARE @upd char(2) = 'I'
*/
	SET NOCOUNT ON;
	DECLARE @cnt INT
	DECLARE @leg_cnt INT
	DECLARE @dsk_penalty INT
	DECLARE @prev_comp INT

	SELECT @dsk_penalty = cast(config_value AS INT) FROM dbo.settings WHERE config_name = 'dsk_penalty_min'

	DECLARE @force_order BIT
	SELECT 
		@force_order = ca.force_order 
	FROM competitors AS co
	INNER JOIN teams AS t 
		ON co.team_id = t.team_id
	INNER JOIN categories AS ca 
		ON t.cat_id = ca.cat_id
	WHERE co.comp_id = @competitor_id

	--DECLARE @readout_id INT = 149
	--declare @competitor_id int = 1156

	DECLARE @as_of_date DATETIME 
	SELECT @as_of_date = card_readout_datetime 
	FROM dbo.si_readout
		WHERE readout_id = @readout_id

	DECLARE @last_comp_id INT 
	SELECT TOP 1 @last_comp_id = c.comp_id 
	FROM competitors AS c
	INNER JOIN competitors as c2 on c.team_id = c2.team_id
	WHERE c.comp_valid_flag = 1
	AND (c.comp_withdrawn = 0 OR c.withdrawn_datetime >= @as_of_date)
	AND c2.comp_id = @competitor_id
	ORDER BY c.rank_order desc

	/*SELECT c.comp_id 
	FROM competitors AS c
	INNER JOIN competitors as c2 on c.team_id = c2.team_id
	WHERE c.comp_valid_flag = 1
	AND (c.comp_withdrawn = 0 OR c.withdrawn_datetime < @as_of_date)
	AND c2.comp_id = @competitor_id
	ORDER BY c.rank_order desc*/

	SELECT 
		@prev_comp = p.prev
	FROM
	(
		SELECT  c.comp_id, 
			c.comp_name, 
--TODO add withdrawn
			lag(comp_id, 1, @last_comp_id) OVER (PARTITION BY c.team_id ORDER BY c.rank_order) AS prev
		FROM competitors AS c
		WHERE c.comp_valid_flag = 1
	AND (c.comp_withdrawn = 0 OR c.withdrawn_datetime >= @as_of_date)
	) AS p
	WHERE p.comp_id = @competitor_id
/*print @as_of_date
print @dsk_penalty
print 'last ' + cast(@last_comp_id as varchar(50))
print @prev_comp
*/

	DECLARE @OutputTbl TABLE (ID INT)

	DECLARE @leg TABLE (comp_id INT, course_id INT, readout_id INT, start_dtime DATETIME,
		start_time VARCHAR(10), finish_dtime DATETIME, finish_time VARCHAR(10), leg_time VARCHAR(10), leg_status VARCHAR(3), dsk_penalty TIME(7))

	;WITH start_time_cte AS (
		SELECT
				a.prev_finish,
				a.prev_comp_id,
				config_value AS zero_time,
				1 AS sort_order
			FROM
			(
				SELECT top 1
					lp.finish_dtime AS prev_finish,
					lp.comp_id as prev_comp_id,
					NULL AS config_value
				FROM  dbo.legs AS lp
				INNER JOIN dbo.competitors AS cp
					ON lp.comp_id = cp.comp_id
				INNER JOIN dbo.competitors AS c
					ON c.team_id = cp.team_id
				LEFT OUTER JOIN dbo.legs AS l 
					ON c.comp_id = l.comp_id
					AND l.readout_id = @readout_id
					AND l.valid_flag = 1
				WHERE c.comp_id = @competitor_id
				AND lp.comp_id <> c.comp_id
				AND (lp.finish_dtime < l.finish_dtime OR l.leg_id IS NULL)
				AND lp.valid_flag = 1
				AND lp.readout_id IS NOT NULL
				AND isnull(l.starting_leg, 0) <> 1
				ORDER BY
					lp.finish_dtime DESC
			) AS a
			UNION ALL
				SELECT 
					NULL AS prev_finish,
					NULL AS prev_comp_id,
					ca.cat_start_time,
					2 AS sort_order
				FROM categories AS ca
				INNER JOIN teams AS t ON t.cat_id = ca.cat_id
				INNER JOIN competitors AS co ON co.team_id = t.team_id
				WHERE co.comp_id = @competitor_id
		)
--select * from start_time_cte
		,finish_cte AS (
			SELECT
					CASE
					WHEN CAST(r.card_readout_datetime AS TIME) < '12:00:00'
					THEN CASE
						WHEN CAST(r.finish_datetime AS TIME) <= CAST(r.card_readout_datetime AS TIME)
						THEN DATEADD(d,0,DATEDIFF(d,0,r.card_readout_datetime)) + CAST(CAST(r.finish_datetime AS TIME) AS DATETIME)
						ELSE DATEADD(d,0,DATEDIFF(d,0,r.card_readout_datetime) - 1) + CAST(DATEADD(HOUR,12,CAST(r.finish_datetime AS TIME)) AS DATETIME)
						END
					ELSE CASE
						WHEN CAST(r.finish_datetime AS TIME) <= CAST(DATEADD(HOUR,-12,r.card_readout_datetime) AS TIME)
						THEN DATEADD(d,0,DATEDIFF(d,0,r.card_readout_datetime)) + CAST(CAST(DATEADD(HOUR,12,r.finish_datetime) AS TIME) AS DATETIME)
						WHEN CAST(r.finish_datetime AS TIME) <= CAST(r.card_readout_datetime AS TIME)
						THEN DATEADD(d,0,DATEDIFF(d,0,r.card_readout_datetime)) + CAST(CAST(r.finish_datetime AS TIME) AS DATETIME)
						ELSE DATEADD(d,0,DATEDIFF(d,0,r.card_readout_datetime) - 1) + CAST(CAST(r.finish_datetime AS TIME) AS DATETIME)
						END
					END AS finish_dtime,
					r.finish_missing
				FROM  dbo.si_readout AS r
				WHERE r.readout_id = @readout_id)
--select * from finish_cte
		,start_finish as (
			SELECT 
				MAX(f.finish_dtime) AS finish_dtime,
				MAX(s.prev_comp_id) AS prev_comp_id,
				MAX(s.prev_finish) AS prev_finish,
				MAX(s.zero_time) AS zero_time,
				f.finish_missing
			FROM start_time_cte AS s
			CROSS JOIN finish_cte AS f
			group by finish_missing
		)
--select * from start_finish
--select @prev_comp
--(@course_id <> @guessed_course OR sf.finish_missing = 1) and DATEDIFF(MINUTE, ISNULL(sf.prev_finish, sf.zero_time), sf.finish_dtime ) < @dsk_penalty 
/*
select sf.prev_comp_id,
@prev_comp as prev_comp,
@course_id as course_id,
@guessed_course as guessed_course,
sf.finish_missing
FROM start_finish AS sf
*/
		INSERT INTO @leg(comp_id, course_id, readout_id, start_dtime, start_time, finish_dtime, finish_time, leg_time, leg_status , dsk_penalty)
		SELECT
			@competitor_id AS comp_id,
			@course_id AS course_id,
			@readout_id AS readout_id,
			ISNULL(sf.prev_finish, sf.zero_time) AS start_dtime,
			dbo.time_from_start(sf.zero_time, ISNULL(sf.prev_finish, sf.zero_time)) AS start_time,
			sf.finish_dtime,
			CASE WHEN sf.finish_missing = 1 THEN '' ELSE dbo.time_from_start(sf.zero_time, sf.finish_dtime) END AS finish_time,
			CASE WHEN sf.finish_missing = 1 THEN '' ELSE dbo.time_from_start(ISNULL(sf.prev_finish, sf.zero_time), sf.finish_dtime) END AS leg_time,
			CASE WHEN sf.finish_missing = 1 THEN 'DNF'
				WHEN @course_id <> @guessed_course
				THEN 'DSK'
				ELSE 'OK' END AS leg_status,
			CASE 
				WHEN (sf.prev_comp_id <> @prev_comp AND sf.prev_comp_id IS NOT NULL AND @force_order = 1) THEN
					CAST(DATEADD(MINUTE, @dsk_penalty, 0) as time)
--					CAST('0:30:00' AS TIME) 
--					@dsk_penalty
				WHEN (@course_id <> @guessed_course OR sf.finish_missing = 1) and DATEDIFF(MINUTE, ISNULL(sf.prev_finish, sf.zero_time), sf.finish_dtime ) < @dsk_penalty 
			THEN --CAST('0:30:00' AS TIME)
				CAST(DATEADD(SECOND, @dsk_penalty * 60 - DATEDIFF(SECOND, ISNULL(sf.prev_finish, sf.zero_time), sf.finish_dtime), 0) AS TIME)
			ELSE 
				CAST('0:00:00' AS TIME) 
			END AS dsk_penalty
		FROM start_finish AS sf

--select * from @leg


	SELECT
		@cnt = COUNT(1)
	FROM  legs
	WHERE (comp_id = @competitor_id
			and readout_id is null
			and @upd = 'I')
		OR (comp_id = @competitor_id
			and readout_id = @readout_id
			and @upd = 'U')
--select @cnt
		IF @cnt > 0
			BEGIN
				-- update;
						UPDATE l
						SET
							l.course_id = @course_id,
							l.readout_id = @readout_id,
							l.finish_dtime = lg.finish_dtime,
							l.finish_time = lg.finish_time,
							l.start_dtime = lg.start_dtime,
							l.start_time = lg.start_time,
							l.dsk_penalty = lg.dsk_penalty,
							l.leg_status = lg.leg_status,
							l.leg_time = lg.leg_time,
							l.as_of_date = GETDATE()
						OUTPUT INSERTED.leg_id INTO @OutputTbl(ID)
						FROM   legs AS l
						CROSS JOIN @leg as lg 
						WHERE 1 = 1
							and l.comp_id = @competitor_id
							AND (l.readout_id = @readout_id 
								OR (l.readout_id is null and @upd = 'I'))
--select * from legs where leg_id = 107
		END
		ELSE
		BEGIN
			--insert;
			INSERT INTO dbo.legs
			(
				comp_id,
				course_id,
				readout_id,
				start_dtime,
				start_time,
				finish_dtime,
				finish_time,
				leg_status,
				dsk_penalty,
				valid_flag
			)
			OUTPUT INSERTED.leg_id INTO @OutputTbl(ID)
			SELECT
				@competitor_id AS comp_id,
				@course_id AS course_id,
				@readout_id AS readout_id,
				lg.start_dtime,
				lg.start_time,
				lg.finish_dtime,
				lg.finish_time,
				lg.leg_status,
				lg.dsk_penalty,
				1
			FROM @leg AS lg
		END
		SELECT isnull(o.ID, 0) FROM @OutputTbl AS o 
	END
GO
/****** Object:  StoredProcedure [dbo].[update_team_race_end]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_team_race_end]
	@comp_id int
AS
/*
Create date: 2022-06-22
Description:	updates teams race_end based on disk penalities

DECLARE @comp_id int = 2201
execute dbo.update_team_race_end @comp_id
*/
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	;WITH cte_dsk AS (
		SELECT 
			d.team_id,
			SUM(d.e * d.penalty_seconds) AS dsk_seconds
		FROM ( 	
			SELECT 
				l.leg_id,
				c.team_id,
				CASE WHEN DATEADD(second, -SUM(DATEDIFF(SECOND, 0, l.dsk_penalty)) over(order by l.start_dtime ), DATEADD(MINUTE, ca.cat_time_limit, ca.cat_start_time)) < l.start_dtime 
				THEN 0 
				ELSE 1 
				END AS e,
				l.dsk_penalty,
				DATEDIFF(SECOND, 0, l.dsk_penalty) AS penalty_seconds
			FROM competitors AS c
			INNER JOIN competitors AS cp ON c.team_id = cp.team_id
			INNER JOIN legs AS l ON cp.comp_id = l.comp_id
			inner join teams as t on c.team_id = t.team_id
			INNER JOIN categories AS ca ON t.cat_id = ca.cat_id
			WHERE c.comp_id = @comp_id
		) AS d
		GROUP BY d.team_id
	)
	UPDATE teams
		SET race_end = DATEADD(SECOND, -s.dsk_seconds, DATEADD(MINUTE, c.cat_time_limit, c.cat_start_time))
	FROM 
		teams AS t
	INNER JOIN categories AS c ON t.cat_id = c.cat_id
	INNER JOIN cte_dsk AS s ON s.team_id = t.team_id

	select @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[x_sp_fill_runs]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[x_sp_fill_runs]
AS
/*
	execute sp_fill_runs
*/
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.runs (comp_id, comp_chip_id, as_of_date, team_rank)
SELECT
    c.comp_id
   ,c.comp_chip_id
   ,GETDATE()
   ,ROW_NUMBER() OVER (PARTITION BY c.team_id ORDER BY n.n, c.rank_order) AS rnk
FROM
    dbo.competitors AS c
    CROSS JOIN (
        SELECT  TOP (100)
                CONVERT(INT, ROW_NUMBER() OVER (ORDER BY s1.object_id)) AS n
        FROM
                sys.all_objects AS s1
                CROSS JOIN sys.all_objects AS s2
    ) AS n
END
GO
/****** Object:  StoredProcedure [dbo].[x_sp_stamp2punches]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[x_sp_stamp2punches]
    @id_card INT
AS
BEGIN
    IF ISNULL(@id_card, 0) <> 0
    BEGIN
        SET NOCOUNT ON;
        SET DATEFIRST 1;

		DECLARE @event_id INT
		--config
		SELECT @event_id = CAST(config_value AS INT)
		FROM dbo.settings AS s
		WHERE s.config_name = 'event_id'

        DELETE FROM
        dbo.punches
        WHERE
            id_card = @id_card

        DECLARE
            @start AS DATETIME
           ,@num INT
           ,@stamp_punch_last DATETIME
           ,@stamp_punch_last_orig DATETIME
           ,@exc_dtime DATETIME
           ,@exc_time VARCHAR(15)
           ,@exc_del BIT;
        DECLARE
            @stamp_card_id INT
           ,@control_code VARCHAR(5)
           ,@control_mode INT
           ,@punch_time VARCHAR(20)
           ,@stamp_punch_datetime DATETIME
           ,@stamp_readout_datetime DATETIME
           ,@stamp_punch_timesi INT
           ,@stamp_punch_wday INT
           ,@stamp_punch_index INT
           ,@stamp_punch_count INT
           ,@cat_start_time DATETIME
           ,@time_direction CHAR
           ,@dif_hour INT
           ,@dif_min INT
           ,@dif_sec INT
           ,@dif_hour_s INT
           ,@dif_min_s INT
           ,@dif_sec_s INT;

        BEGIN TRAN

        SELECT
            @stamp_card_id = s.stamp_card_id
           ,@control_code = s.stamp_control_code
           ,@control_mode = s.stamp_control_mode
           ,@stamp_readout_datetime = s.stamp_readout_datetime
           ,@stamp_punch_timesi = s.stamp_punch_timesi
           ,@stamp_punch_datetime = s.stamp_punch_datetime
           ,@stamp_punch_wday = s.stamp_punch_wday
           ,@stamp_punch_index = s.stamp_punch_index
           ,@stamp_punch_count = s.stamp_punch_count
        FROM
            dbo.stamps AS s
			INNER JOIN dbo.lccard_link_stamps AS ls ON ls.id_stamp = s.id_stamp
        WHERE
			ls.id_card = @id_card --243

		-- first possible start - events or previous competitor from same team
/*SELECT MAX(r.start_dtime) FROM dbo.competitors AS c
INNER JOIN dbo.runs AS r ON c.comp_id = r.comp_id
--INNER JOIN dbo.punches AS p ON r.run_id = p.run_id
WHERE c.comp_chip_id = @stamp_card_id

SELECT event_date FROM dbo.events WHERE 
SELECT top 10000 * FROM dbo.punches
SELECT top 10000 * FROM dbo.runs
*/
        SELECT
            @start = MIN(ca.cat_start_time)
        FROM
            dbo.competitors AS co
            LEFT OUTER JOIN dbo.teams AS te ON te.team_id = co.team_id
            LEFT OUTER JOIN dbo.categories AS ca ON ca.cat_id = te.cat_id
                                                    AND ca.valid = 1
        WHERE
            co.comp_chip_id = @stamp_card_id;

        IF @start IS NULL
        BEGIN
            SELECT
                @start = MIN(cat_start_time)
            FROM
                dbo.categories
            WHERE
                valid = 1;
        END
        PRINT '@chip_id ' + CAST(@stamp_card_id AS VARCHAR)
        PRINT 'start: ' + CONVERT(VARCHAR, @start)

        --ver prior 6
        IF @stamp_card_id < 500000
        BEGIN
            DECLARE new_punches_cursor CURSOR FOR
                SELECT
                    stamp_card_id
                   ,CASE WHEN stamp_control_mode = 3
                              THEN 'S'
                    WHEN stamp_control_mode = 4
                         THEN 'F'
                    WHEN stamp_control_mode = 7
                         THEN 'X'
                    WHEN stamp_control_mode = 10
                         THEN 'C'
                    ELSE CAST(stamp_control_code AS NVARCHAR(3))END AS control_code
                   ,stamp_punch_datetime
                   ,MIN(stamp_readout_datetime) AS stamp_readout_datetime
                FROM
                    dbo.stamps
                WHERE
                    stamp_card_id = @stamp_card_id
                GROUP BY
                    stamp_card_id
                   ,stamp_control_mode
                   ,stamp_control_code
                   ,stamp_punch_datetime
                ORDER BY
                    MIN(id_stamp)

            OPEN new_punches_cursor;

            FETCH NEXT FROM new_punches_cursor
            INTO
                @stamp_card_id
               ,@control_code
               ,@stamp_punch_datetime
               ,@stamp_readout_datetime;

            SET @stamp_punch_last = DATEADD(MINUTE, -60, @start)
            SET @stamp_punch_last_orig = DATEADD(MINUTE, -60, @start)

            WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT '@stamp_card_id ' + CAST(@stamp_card_id AS VARCHAR)
                PRINT '@stamp_punch_last ' + CONVERT(VARCHAR, @stamp_punch_last, 113)
                PRINT '@stamp_punch_datetime: ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                PRINT '@stamp_punch_last_orig ' + CONVERT(VARCHAR, @stamp_punch_last_orig, 113)
                PRINT '@control_code ' + CAST(@control_code AS VARCHAR)
                PRINT 'dif ' + CAST(DATEDIFF(SECOND, @stamp_punch_last_orig, @stamp_punch_datetime) AS VARCHAR)
                --while datediff(second, @stamp_punch_last_orig, @stamp_punch_datetime) < -86400
                --begin
                --	set @stamp_punch_datetime = dateadd(hh, 12, @stamp_punch_datetime)
                --end

                IF DATEDIFF(SECOND, @stamp_punch_last_orig, @stamp_punch_datetime) > 0
                   OR   DATEDIFF(SECOND, @stamp_punch_last_orig, @stamp_punch_datetime) < -1 --between -43200 and -1
                BEGIN
                    PRINT 'rozdilne'
                    SET @stamp_punch_last_orig = @stamp_punch_datetime
                    SELECT
                        @num = COUNT(*)
                    FROM
                        dbo.exceptions
                    WHERE
                        chip_id = @stamp_card_id
                        AND control_code = @control_code;
                    IF @num > 0
                    BEGIN
                        PRINT 'vyjimka'
                        --vyjimka
                        SELECT
                            @exc_dtime = exc_dtime
                           ,@exc_time = exc_time
                           ,@exc_del = exc_del
                        FROM
                            dbo.exceptions
                        WHERE
                            chip_id = @stamp_card_id
                            AND control_code = @control_code;
                        IF @exc_del = 1
                        BEGIN
                            PRINT '@exc_del = 1'
                            PRINT 'nic do punches nevkladam'
                        --insert into punches (chip_id, control_code, punch_dtime, punch_time, valid_flag, stamp_readout_datetime)
                        --values (@stamp_card_id, @control_code, cast(@exc_dtime as datetime), @exc_time, 0, @stamp_readout_datetime);
                        END
                        ELSE
                        BEGIN
                            PRINT 'ins ' + CAST(@stamp_card_id AS VARCHAR) + ', ' + CAST(@control_code AS VARCHAR) + ', ' + CAST(@exc_dtime AS VARCHAR) + ',' + CAST(@exc_time AS VARCHAR)
                            INSERT INTO dbo.punches (
                                chip_id
                               ,control_code
                               ,punch_dtime
                               ,punch_time
                               ,valid_flag
                               ,stamp_readout_datetime
                            )
                            VALUES (
                                @stamp_card_id, @control_code, CAST(@exc_dtime AS DATETIME), @exc_time, 1, @stamp_readout_datetime
                            );
                            --					insert into punches (chip_id, control_code, punch_time, valid_flag, stamp_readout_datetime)
                            --					values (@stamp_card_id, @control_code, @exc_time, 1, @stamp_readout_datetime);
                            SET @stamp_punch_last = @exc_dtime
                        END
                    END
                    ELSE
                    BEGIN
                        PRINT 'normalni '
                        --neni vyjimka, vkladam normalni...
                        IF @control_code NOT IN ('C', 'S', 'X')
                        BEGIN
                            PRINT 'x'
                            SELECT
                                @num = COUNT(*)
                            FROM
                                dbo.controls
                            WHERE
                                control_code = @control_code
                                AND time_direction <> ''
                            --posun casu
                            IF @num > 0
                            BEGIN
                                PRINT 'time_diff '
                                SELECT
                                    @time_direction = time_direction
                                   ,@dif_hour = dif_hour
                                   ,@dif_min = dif_min
                                   ,@dif_sec = dif_sec
                                FROM
                                    dbo.controls
                                WHERE
                                    control_code = @control_code

                                SET @dif_hour = (CASE WHEN @time_direction = '-'
                                                           THEN -COALESCE(@dif_hour, 0)
                                                 ELSE      COALESCE(@dif_hour, 0)END
                                                )
                                SET @dif_min = (CASE WHEN @time_direction = '-'
                                                          THEN -COALESCE(@dif_min, 0)
                                                ELSE      COALESCE(@dif_min, 0)END
                                               )
                                SET @dif_sec = (CASE WHEN @time_direction = '-'
                                                          THEN -COALESCE(@dif_sec, 0)
                                                ELSE      COALESCE(@dif_sec, 0)END
                                               )
                                PRINT '@time_direction ' + CONVERT(VARCHAR, @dif_hour) + ' ' + CONVERT(VARCHAR, @dif_min) + ' ' + CONVERT(VARCHAR, @dif_sec)
                                PRINT '@stamp_punch_datetime ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                                SET @stamp_punch_datetime = DATEADD(SECOND, @dif_sec, DATEADD(MINUTE, @dif_min, DATEADD(HOUR, @dif_hour, @stamp_punch_datetime)))
                            END

                            PRINT '@stamp_punch_last ' + CONVERT(VARCHAR, @stamp_punch_last, 113)
                            PRINT '@stamp_punch_datetime ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            --prechod pres pulnoc
                            IF ABS(DATEDIFF(SECOND, @stamp_punch_datetime, @stamp_punch_last)) > 43200
                            BEGIN
                                SET @stamp_punch_datetime = DATEADD(DAY, DATEDIFF(DAY, @stamp_punch_datetime, @stamp_punch_last), @stamp_punch_datetime)
                                PRINT '@stamp_punch_datetime ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            END
                            PRINT '@stamp_punch_datetime ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            PRINT DATEDIFF(HOUR, @stamp_punch_last, @stamp_punch_datetime)
                            PRINT DATEDIFF(MINUTE, @stamp_punch_last, @stamp_punch_datetime)
                            --first control same day as start -> force shift
                            PRINT '@stamp_punch_last: pred mene ' + CONVERT(VARCHAR, @stamp_punch_last, 113)
                            PRINT '@stamp_punch_datetime: pred mene ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            WHILE (DATEDIFF(SECOND, @stamp_punch_last, @stamp_punch_datetime) > 43200)
                            BEGIN
                                SET @stamp_punch_datetime = DATEADD(hh, -12, @stamp_punch_datetime)
                                PRINT '@stamp_punch_datetime: mene ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            END

                            --date moret than 12 hours -> substract 12 h
                            WHILE @stamp_punch_datetime <= @stamp_punch_last
                            BEGIN
                                SET @stamp_punch_datetime = DATEADD(hh, 12, @stamp_punch_datetime)

                                PRINT '@stamp_punch_datetime: vice ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                            END
                            SET @stamp_punch_last = @stamp_punch_datetime
                            PRINT '@stamp_punch_datetime-final: ' + CONVERT(VARCHAR, @stamp_punch_datetime, 113)
                        END
                        PRINT 'insert'
                        SET @punch_time = dbo.time_from_start(@start, @stamp_punch_datetime)
                        --				insert into punches (chip_id, control_code, punch_time, valid_flag, stamp_readout_datetime)
                        --				values (@stamp_card_id, @control_code, @stamp_punch_datetime, 1, @stamp_readout_datetime);
                        PRINT 'ins ' + CAST(COALESCE(@stamp_card_id, '') AS VARCHAR) + ', ' + CAST(COALESCE(@control_code, '') AS VARCHAR) + ', ' + CAST(COALESCE(@stamp_punch_datetime, '') AS VARCHAR) + ', ' + CAST(COALESCE(@punch_time, '') AS VARCHAR) + ', 1, ' + CAST(COALESCE(@stamp_readout_datetime, '') AS VARCHAR)
                        INSERT INTO dbo.punches (
                            chip_id
                           ,control_code
                           ,punch_dtime
                           ,punch_time
                           ,valid_flag
                           ,stamp_readout_datetime
                        )
                        VALUES (
                            @stamp_card_id, @control_code, @stamp_punch_datetime, @punch_time, 1, @stamp_readout_datetime
                        );
                    END
                END
                ELSE
                    PRINT 'stejne'

                FETCH NEXT FROM new_punches_cursor
                INTO
                    @stamp_card_id
                   ,@control_code
                   ,@stamp_punch_datetime
                   ,@stamp_readout_datetime;
            END --end while
            CLOSE new_punches_cursor;
            DEALLOCATE new_punches_cursor;
        END
        ELSE
        BEGIN
            --SI6 and higher
            --	declare new_punches_cursor cursor for
            --print 'ins ' + cast(coalesce(@stamp_card_id,'') as varchar)+ ', ' + cast(coalesce(@control_code,'') as varchar)+', '+ cast(coalesce(@stamp_punch_datetime,'') as varchar)+', '+cast(coalesce(@punch_time,'') as varchar)+', 1, '+ cast(coalesce(@stamp_readout_datetime,'') as varchar)
            INSERT INTO dbo.punches (
                chip_id
               ,control_code
               ,punch_dtime
               ,punch_time
               ,valid_flag
               ,stamp_readout_datetime
            )
            SELECT
                s.stamp_card_id
               ,CASE WHEN s.stamp_control_mode = 3
                          THEN 'S'
                WHEN s.stamp_control_mode = 4
                     THEN 'F'
                WHEN s.stamp_control_mode = 7
                     THEN 'X'
                WHEN s.stamp_control_mode = 10
                     THEN 'C'
                ELSE COALESCE(c.control_code, CAST(s.stamp_control_code AS NVARCHAR(3)))END AS control_code
               --s.stamp_punch_datetime,
               ,DATEADD(SECOND, DATEPART(HOUR, CONVERT(TIME, s.stamp_punch_datetime)) * 3600 + DATEPART(MINUTE, CONVERT(TIME, s.stamp_punch_datetime)) * 60 + DATEPART(SECOND, CONVERT(TIME, s.stamp_punch_datetime)), DATEADD(DAY, CASE WHEN s.stamp_punch_wday = 0 THEN 7 ELSE s.stamp_punch_wday END, DATEADD(WEEK, DATEDIFF(WEEK, 0, @start), 0) - 1)) AS t
               ,dbo.time_from_start(ca.cat_start_time, DATEADD(SECOND, DATEPART(HOUR, CONVERT(TIME, s.stamp_punch_datetime)) * 3600 + DATEPART(MINUTE, CONVERT(TIME, s.stamp_punch_datetime)) * 60 + DATEPART(SECOND, CONVERT(TIME, s.stamp_punch_datetime)), DATEADD(DAY, CASE WHEN s.stamp_punch_wday = 0 THEN 7 ELSE s.stamp_punch_wday END, DATEADD(WEEK, DATEDIFF(WEEK, 0, @start), 0) - 1))) AS punch_time
               ,1 AS valid
               ,s.stamp_readout_datetime
            FROM
                dbo.stamps AS s
                INNER JOIN dbo.competitors AS com ON s.stamp_card_id = com.comp_chip_id
                INNER JOIN dbo.teams AS t ON com.team_id = t.team_id
                INNER JOIN dbo.categories AS ca ON t.cat_id = ca.cat_id
                LEFT OUTER JOIN dbo.controls AS c ON s.stamp_control_code = c.control_id
            WHERE
                s.stamp_card_id = @stamp_card_id
                AND s.stamp_control_mode NOT IN (10, 3, 7)
            ORDER BY
                s.stamp_punch_datetime

            /*	OPEN new_punches_cursor;
			
			FETCH NEXT FROM new_punches_cursor
			INTO
			@stamp_card_id,
			@control_code,
			@punch_time,
			@stamp_punch_datetime,
			@stamp_readout_datetime;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
			if @control_code not in('C', 'S', 'X')
			begin
			insert into punches (chip_id, control_code, punch_dtime, punch_time, valid_flag, stamp_readout_datetime)
			values (@stamp_card_id, @control_code, @stamp_punch_datetime, @punch_time, 1, @stamp_readout_datetime);
			end
			FETCH NEXT FROM new_punches_cursor
			INTO
			@stamp_card_id,
			@control_code,
			@punch_time,
			@stamp_punch_datetime,
			@stamp_readout_datetime;
			end --end while
			CLOSE new_punches_cursor;
			DEALLOCATE new_punches_cursor;
			*/
            --exceptions
            DECLARE exceptions_cursor CURSOR FOR
                SELECT
                    e.control_code
                   ,e.exc_dtime
                   ,e.exc_del
                   ,dbo.time_from_start(ca.cat_start_time, e.exc_dtime) AS exc_time
                FROM
                    dbo.exceptions AS e
                    INNER JOIN dbo.competitors AS co ON co.comp_chip_id = e.chip_id
                    INNER JOIN dbo.teams AS t ON t.team_id = co.team_id
                    INNER JOIN dbo.categories AS ca ON t.cat_id = ca.cat_id
                WHERE
                    e.chip_id = @stamp_card_id

            OPEN exceptions_cursor;
            PRINT 'exceptions'
            FETCH NEXT FROM exceptions_cursor
            INTO
                @control_code
               ,@exc_dtime
               ,@exc_del
               ,@exc_time;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @exc_del = 1
                BEGIN
                    PRINT 'delete ' + @control_code
                    UPDATE
                        dbo.punches
                    SET
                        valid_flag = 0
                    WHERE
                        chip_id = @stamp_card_id
                        AND control_code = @control_code
                END
                ELSE
                BEGIN
                    PRINT 'insert_update'
                    --insert or update
                    UPDATE
                        dbo.punches
                    SET
                        punch_dtime = @exc_dtime
                       ,punch_time = @exc_time
                       ,valid_flag = 1
                    WHERE
                        chip_id = @stamp_card_id
                        AND control_code = @control_code
                    IF @@rowcount = 0
                    BEGIN
                        PRINT 'insert'
                        INSERT INTO dbo.punches (chip_id, control_code, punch_time, punch_dtime, valid_flag)
                        SELECT
                            CAST(@stamp_card_id AS VARCHAR(50))
                           ,@control_code
                           ,@exc_time
                           ,@exc_dtime
                           ,1
                        WHERE
                            NOT EXISTS (
                            SELECT
                                punch_id
                            FROM
                                dbo.punches
                            WHERE
                                chip_id = @stamp_card_id
                                AND control_code = @control_code
                        )
                    END
                END
                FETCH NEXT FROM exceptions_cursor
                INTO
                    @control_code
                   ,@exc_dtime
                   ,@exc_del
                   ,@exc_time;
            END --end while
            CLOSE exceptions_cursor
            DEALLOCATE exceptions_cursor
        END
        --rollback
        COMMIT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[x_sp_stamp2punches2]    Script Date: 05.05.2024 21:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[x_sp_stamp2punches2]
    @id_card INT
AS
/*

DECLARE @RC int
DECLARE @id_card int = 243

EXECUTE @RC = dbo.sp_stamp2punches2 
   @id_card

*/
BEGIN
--DECLARE @id_card int = 243
    IF ISNULL(@id_card, 0) <> 0
    BEGIN

        SET NOCOUNT ON;
        SET DATEFIRST 1;

        DECLARE @event_id INT
        --config
        SELECT
            @event_id = CAST(s.config_value AS INT)
        FROM
            dbo.settings AS s
        WHERE
            s.config_name = 'event_id'

        DELETE  FROM
        dbo.punches
        WHERE
            id_card = @id_card

        --do I know this chip?

        DECLARE @comp_id INT

        SELECT
            @comp_id = co.comp_id
        FROM
            dbo.competitors AS co
            INNER JOIN dbo.lccards AS lc ON co.comp_chip_id = lc.card_id
        WHERE
            lc.id_card = 243 --@id_card

        IF ISNULL(@comp_id, -1) = -1
        BEGIN
PRINT 'chip known'


--            RETURN 1
        END
        ELSE
		BEGIN
PRINT 'no chip known'			
--            RETURN 0
		end
    END



END
GO
USE [master]
GO
ALTER DATABASE [klc01] SET  READ_WRITE 
GO
