# h24


* Filter ist jetzt sehr sehe.... da stimmt was nicht!

* Abfrage Box für Krankmeldung

* edit mode mit roten Rahmen, dann kann man was ändern.
* Device Filter in Datenbank ergänzen.... readout.

* Automatische Läuferreinfolge!
* bug: searach auf Team Filter zurückgestellt... wird nicht alles gelöscht, wenn es keine Zahl ist!


* Search Eingabe, bei voller Datenbank sehr zäh.. 2 sec warten und dann erst suchen?
* Change Event kommt mehrfach?



* Unterscheidung nur die von meinem REchner abzeigen (auch bei all)

* Läufer Hinzufügen ?
* Läufer Löschen in 12h oder 6h ?

* keine Krankmeldung... erste Spalte Unsichtbar?... wennn einfach umsetztbar
* Krankmeldung kann man nicht rückgängig machen ?




# Logbuch in der Datenbank
* Chip-Ummeldung
* Krankmeldung, Wann, Wer und bei Whem


* Laufer Read Only Mode , chip nummer nicht einfach so ändern.

* Logging : Chip-Nummer Änderung, verfoglbar + Zeitstempel, auch in der Datenbank?

* Zahllose Logging Meldung in der Datenbanken Wo sind die Entstanden? Suchen oder Kacel fragen...
  normal Logging-Meludung sollten einfach nur ins Log-File aber nicht in die Datenbank


* Läuferreihenfolge  mit erstem Durchlauf:

* rank_order... sollte damit null haben. 
* bib erstmal ohne Buchstabe.
* 

# Auslesen 
* SI-TYPE ausgaben... also Info... wenn das kommisch ist.
* Auslese: Info Chip wurde ausgelehen? chip geliehen, erst bei der Ausgaben des chip markieren.

* Alle Button abschaffen.,m 
* Edit Menu...
* ? Hat jede Auslesestation seine ID in der Datenbank?
 

### Sicherung der DB während des Wettkampfes
Mach wohl keinen Sinn..
besser wäre es die Datenbank einmal mit dem Start zu sichern.
dann sollten einträge in ein Logfile, auf extra Platte, wieviel ist das etwa?
dann diese einträge Importieren
Jeder rechner selbst.

### Auslesefenster erweitern: Fehler anzeige, Laufzeit anzeigen, Gelochte Posten vs. Zu lochende Posten, manuelle Bahnzuordnung ermöglichen
### Dokumentation von Läuferausfällen und Bahnkorrekturen mit Zeitstempel und Bearbeiter
* Logbuch

## Sprechersoftware
* Funkposten und Endposten
* Mit dem Posten 100 könnte der Läufer angesagt werden, aber nicht die Zeit oder irgendwas mehr.
  * Die Bahn müsste am Start schon zugeordnet werden.
* Zugriff auf Liveergebnisse, das was der Läufer nicht bekommen sollte

# Läuferanzeige
* Fehlt nur noch den Läufer aus der Datenbank rauszusuchen
   * mit Python oder Java-Script, dirket die Datenbank abfragen.

## Checkliste
* USV + Kabel
* Switch + Kabel
* Netzwerk Kabeltrommel
* Rechner

### Bahn Statistik
* Anzahl Staffeln, Anzahl Bahnenn, Anzahl Läufer
* Wieviel gelaufene Bahnen pro Läufer und Insgesamt. 
* Wie oft hat ein Läufer den selben Posten angelaufen
  "= 0": Keiner ist die Bahn mit dem Posten gelaufen
  = 1: Eine Bahn mit dem Posten, die auch gelaufen wurde
  > 1: + min max, Posten wurde auf mehreren Bahn angelaufen. 


## Aufbau

* Server ohne Auslesen, nur für Netzwerkausfall im Ziel.

## Installation


### Datenbank



## Einweisung

Alle Änderungen sind direkte Datenbankänderungen, kein extra Abfragebox oder Bestätigung!

* SI-Chip Änderung direkt im Hauptfenster
  * Unbekannt Chip-Nummer nach dem Auslese, wird abgefragt, wird aber nicht automatisch in die Datenbank übernommen
  * TODO: Abfrage, den SI-Chip zu übernehmen hinzufügen?

* TODO: Teamname Änderung direkt im Hauptfenster? Könnte man dort auch verriegel, wenn es im Meldungsfenster geht?
* TODO: Läufennamen Ändern direkt im Hauptfenter? Könnte man dort auch verriegel, wenn es im Meldungsfenster geht?
* TODO: Läuferreihenfolge mit Pfeiltasten hoch und runter ( zur eigenen Sicherheit, nur Meldungsfenster!)
* TODO: Jahrgangs Anzeige und Änderung nur im Meldungsfenster

* TODO: Splittime Fester - Anzeige per click auf die Auslese-Zeil in der Tabelle

* **Bahnzuordnung erfolgt automatsch muss aber kontrolliert werden**
   * Läufer ist zum Beispiel einen andern Läufer vollständig angelaufen, dann hat er automatisch ein gültige Bahnzuordnung
     aber nicht sein!
* FIXME: **SI-Chip nur einmal pro Lauf auslesen!**

## Daten-Import

### Meldungen

* CSV-Datei
  * Manuelle Startnummern Vorgabe ist dort viel einfacher möglich 
* CSV Speichern und Encoding nach UTF8 with BOM Konvertieren (mit VS code)
  * "with BOM" damit die Datei mit Excelt erneut richtig geöffnet werden kann
  * ohne BOM wird CSV-Datei mit Ansi kodiierung geöffnet
* Import
  * Spalten werden über den Name angesprochen
  * weitere Spalten oder Spaltenreinfolge ist egal

### Bahndaten

* OCAD 8 Export


## Anzeige

### Courses Info vs. Import

* TODO: weclche ZeEinheit hat.... cat_time_limit
  * Welche Bahnen gelaufen sind gehört in Hauptfenster +  Anzahl der Wechsel
  * File / Print Open Courses... (Wenn offene Bahnen direkt im Hauptfenster angezeigt werden verwirrt das zu sehr!)
    * Drucken Vorschauen:.. startnummer Eingabe, nächste Startnummern Butten. Print All von bis
    * ... nächte Startnumemrauswhl.. Filter kathorgie, Print, Print All
    (Anzeige welche Bahnen ein Team schon gelaufen ist)
    * Anzeige welche Bahnen ein Team noch nicht gelaufen ist
      * Überschrift: "Open Courses"  + Kathegorie
      * Team-Nr, Team-Name
      * alle Bahnen untereinander, so kann man was dainter vermerken oder abhanken.
        * Gruppung nach Day, Night, Final
      * Anzahl:
      * Druckzeitpunkt
      (könnte man zur Not auch json Ausgeben)
      
   * welche aktuell möglich sind (für eine Vorstart-Lösung) 
        * Kartenausgaben am Sonntag, nach Zielschluss: Team x Bahn Matrix.. Restbahnen pro Team oder Bahnen mit Teamnummern (ausdruck)


  *  TODO: Prüfen, ob mehrfach gelaufe Bahnen nur einmal gezählt werden. 


## TODO

* Meldeliste

* Windows XP Nutzbar?
* geht es auch ohne ODBC?

* TODO: Rename: "Courses" in "Import Courses..."
* TODO: Überall wo ein neues Fenster aufgeht "..." ergänzen.

* TODO: Hauptanzeige: die automatisch zugeordnete Bahn anzeigen

* TODO: Startbahn-Zuorder, über eine Vorauswahl oder Nachprüfung und neu Zuordnung wie "Change Course"
        * aktuelle Bahnzuordnung pro Team
        * für eine Vorstartlösung: noch eine nächste Bahnzuorndung, die dann automatisch zur akuellen wird

* FIXME: ExportWinnerList wiederholt immer die erste spalter
* TODO: Gesamtstreckenlänge sollte doch mit auf der Urkunde stehen?

* Datenbank Diagramm erstellen, ausdrucken

* FIXME: Teamnamen nicht änderbar, von der Oberfläche!
* FIXME: Jahrgang beim Team mit Anzeigen unänderbar

* TODO: Buttons umbennen, was sie machen
   * "Change Course"
   * "Recalculate"

* Readout-List 
  * Spiltime mit Click anzeigen, nicht erst mit Button
  * Filter/Option:
    * alle (wie aktuell)
    * nur die Bahnen vom gerade ausgelesen Team 
    * nur die am akuellen Rechner ausgelesen (nach neustart des Programms) -> default
* TODO: Läufer mit neuem Si-Chip. Abfragebox einfügen, diese gleich in der Datenbank zu übernehmen?


* Teamverwaltung
  * delete Button, um einzelne Teams wieder zu entfernen
  * weiterer Import oder doch direkt Teams hinzufügen in der Oberfläche 
  * Läufenreinfolge mit Button ändern, nicht mit order und Startnummern Anpassung!

* TODO: Finish-Auslesen optimeriern: 40 sekunden (einstellbar) nach letztem stempel.

* TODO: Prüfen, nach 9 Uhr bzw. nach seiner Zielzeit (6h,12h, strafzeiten) eingelaufen, wird automatisch disqualifiziert.
* TODO: Jahrgangsprüfung schon umgesetzt? Wie wird ein Verstoß dann angezeigt?
* TODO: 2 Frauen Prüfung bei 24-Team umgesetzt? Wie wird der Verstoß dann angezeigt?
* TODO: Prüfung ausgefallen Läufer
* TODO: Prüfung der Läuferreinfolge, was passiert, wenn es nicht passt, was wird angezeigt?
* TODO: Prüfung, Bahnfreigabe zum laufen. Dämmerungsbahn.. Nachtbahnen erst nach Dämmerungsbahnen...finalbahn erstnach allen Tag/Nacht bahnen.

* Möglichkeit zum Bahn bwz. Strecke rausnehmen

## Merge zur Hauptversion
* TODO: finish_missing über get_config_item bereitstellen?
* TODO: Import-Möglichkeiten


## SQL Export
 * advance -> "Schema and Data"

## GibHub unterschiede:
 * app.config: koe + andere Einstellung die gar nicht gebraucht werden?
 * h24.csproj: nur settings die automatsisch korrigiert werden.
 * Properties\Settings.settings: extra sportident user/passwort?
                                 -> and auch in Settings.Designer.cs
 * frmApiQueue.Designer.cs: viele Änderugnen
 * frmEntries.Designer.cs: wie kommt es zu dieser einen Veränderung?
 * FrmMain.Designer.cs: echt viele Änderungen!


## Datenbank abgleich   
* klc01.sql mit letztem export der Datenbank vergleich!
  * tabele [dbo].[_l] wurde angelegt?
  * q_content war nach auf 4000 begrenzt
  * TEXTIMAGE_ON [PRIMARY]
  * große Kaleder definition war noch enthalten? [dbo].[calendar]
  * cte_second_course anpassungen waren noch nicht aktiv?
  * CASE WHEN t.race_end > l.finish_dtime AND l.leg_status = 'OK' and sc.same_courses
  * sys.sp_addextendedproperty
 

#  IOF-XML Ergebniss Daten (online, wenn gewünscht)
   * es wird immer alles vollständig hochgeladen
   * Wettkampf muss zuvor angelegt sein.


