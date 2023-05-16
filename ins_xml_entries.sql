

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

--insert cometitors;

WITH cte_comp_max
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