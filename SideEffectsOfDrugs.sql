SET LANGUAGE POLSKI;

--usuwanie i tworzenie bazy
USE master
GO

IF DB_ID ('ARIS') IS NOT NULL
DROP DATABASE ARIS;

GO

IF DB_ID ('ARIS') IS NUll 
CREATE DATABASE ARIS;

GO

USE ARIS
GO
--usuwanie i tworzenie tabel

IF OBJECT_ID ('ARIS.dbo.Incident','U') IS NOT NULL
DROP TABLE ARIS.dbo.Incident 
IF OBJECT_ID ('ARIS.dbo.SideEffect','U') IS NOT NULL
DROP TABLE ARIS.dbo.SideEffect 
IF OBJECT_ID ('ARIS.dbo.Patient','U') IS NOT NULL
DROP TABLE ARIS.dbo.Patient 
IF OBJECT_ID ('ARIS.dbo.Product','U') IS NOT NULL
DROP TABLE ARIS.dbo.Product 
IF OBJECT_ID ('ARIS.dbo.PharmaceuticalForm','U') IS NOT NULL
DROP TABLE ARIS.dbo.PharmaceuticalForm 
IF OBJECT_ID ('ARIS.dbo.IncidentSource','U') IS NOT NULL
DROP TABLE ARIS.dbo.IncidentSource

IF OBJECT_ID ('ARIS.dbo.SideEffect','U') IS NULL
CREATE TABLE ARIS.dbo.SideEffect 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
Name varchar (255) NOT NULL,
)

IF OBJECT_ID ('ARIS.dbo.Patient','U') IS NULL
CREATE TABLE ARIS.dbo.Patient 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
FirstName varchar (255) NOT NULL,
LastName varchar (255) UNIQUE NOT NULL,
DateOfBirth DATE NOT NULL,
Sex varchar (255) CHECK ( Sex in ('Male', 'Female')),
Adress varchar (255),
TelephoneNumber float,
)

IF OBJECT_ID ('ARIS.dbo.PharmaceuticalForm','U') IS NULL
CREATE TABLE ARIS.dbo.PharmaceuticalForm 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
Name varchar (255) CHECK (Name in ('Injection', 'Pill', 'Drip', 'Infusion', 'Phial'))  NOT NULL,
)

IF OBJECT_ID ('ARIS.dbo.Product','U') IS NULL
CREATE TABLE ARIS.dbo.Product 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
Name varchar (255) UNIQUE NOT NULL,
Ingredients varchar (255) NOT NULL,
PharmaceuticalFormID int NOT NULL,
)

IF OBJECT_ID ('ARIS.dbo.IncidentSource','U') IS NULL
CREATE TABLE ARIS.dbo.IncidentSource 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
Name varchar (255) NOT NULL,
)

IF OBJECT_ID ('ARIS.dbo.Incident','U') IS NULL
CREATE TABLE ARIS.dbo.Incident 
(  
ID int IDENTITY (1,1) PRIMARY KEY,
PatientID int NOT NULL,
ProductID int NOT NULL,
IncidentSourceID int NOT NULL,
SideEffectID int NOT NULL,
Description varchar(500),
Date DATETIME,
)


--DODAWANIE KLUCZY OBCYCH

ALTER TABLE ARIS.dbo.Product ADD FOREIGN KEY (PharmaceuticalFormID) REFERENCES ARIS.dbo.PharmaceuticalForm(ID);
ALTER TABLE ARIS.dbo.Incident ADD FOREIGN KEY (PatientID) REFERENCES ARIS.dbo.Patient(ID);
ALTER TABLE ARIS.dbo.Incident ADD FOREIGN KEY (ProductID) REFERENCES ARIS.dbo.Product(ID);
ALTER TABLE ARIS.dbo.Incident ADD FOREIGN KEY (IncidentSourceID) REFERENCES ARIS.dbo.IncidentSource(ID);
ALTER TABLE ARIS.dbo.Incident ADD FOREIGN KEY (SideEffectID) REFERENCES ARIS.dbo.SideEffect(ID);

--uzupełnianie tabel danymi

INSERT INTO ARIS.dbo.SideEffect VALUES ('headache');
INSERT INTO ARIS.dbo.SideEffect VALUES ('vomits');
INSERT INTO ARIS.dbo.SideEffect VALUES ('rash');
INSERT INTO ARIS.dbo.SideEffect VALUES ('dry mouth');
INSERT INTO ARIS.dbo.SideEffect VALUES ('hair loss');
INSERT INTO ARIS.dbo.SideEffect VALUES ('nusea');
INSERT INTO ARIS.dbo.SideEffect VALUES ('diarrhea');



INSERT INTO ARIS.dbo.PharmaceuticalForm VALUES ('Injection');
INSERT INTO ARIS.dbo.PharmaceuticalForm VALUES ('Pill');
INSERT INTO ARIS.dbo.PharmaceuticalForm VALUES ('Drip');
INSERT INTO ARIS.dbo.PharmaceuticalForm VALUES ('Infusion');
INSERT INTO ARIS.dbo.PharmaceuticalForm VALUES ('Phial');

INSERT INTO ARIS.dbo.Product VALUES ('Anexate', 'Flumazenilum', 4);
INSERT INTO ARIS.dbo.Product VALUES ('Bactrim', 'Trimetoprim, Sulfametoksazyl', 3);
INSERT INTO ARIS.dbo.Product VALUES ('Copegus', 'Ribavirinum', 2);
INSERT INTO ARIS.dbo.Product VALUES ('Lexotan', 'Bromazepamum', 2);
INSERT INTO ARIS.dbo.Product VALUES ('Micera', 'Methoxy polyethylene glycol-epoetin beta', 5);


INSERT INTO ARIS.dbo.IncidentSource VALUES ('mail');
INSERT INTO ARIS.dbo.IncidentSource VALUES ('fax');
INSERT INTO ARIS.dbo.IncidentSource VALUES ('medical consultation');
INSERT INTO ARIS.dbo.IncidentSource VALUES ('telephone');

INSERT INTO ARIS.dbo.Patient VALUES ('Jan', 'Nowak', '1988-04-13', 'Male', 'Poznań', 505123123);
INSERT INTO ARIS.dbo.Patient VALUES ('Angelina', 'Jolie', '1972-06-13', 'Female', 'New York', 505890123);
INSERT INTO ARIS.dbo.Patient VALUES ('Tomasz', 'Drgas', '1989-08-13', 'Male', 'Poznań', 800123987);
INSERT INTO ARIS.dbo.Patient VALUES ('Ksenia', 'Poczobut-Odlanicka', '1988-04-21', 'Female', 'Poznań', 505432123);
INSERT INTO ARIS.dbo.Patient VALUES ('Michał', 'Dardas', '1985-11-10', 'Male', 'Poznań', 505789123);
INSERT INTO ARIS.dbo.Patient VALUES ('Robert', 'Wróbel', '1990-09-13', 'Male', 'Wrocław', 505098123);
INSERT INTO ARIS.dbo.Patient VALUES ('Monika', 'Stachurska', '1999-04-13', 'Female', 'Wrocław', 505098678);

INSERT INTO ARIS.dbo.Incident VALUES (1, 1, 3, 5, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (2, 2, 1, 3, 'Rash on neck and chest', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (3, 3, 4, 7, 'After 3 days patient get diarrhea', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 4, 4, 'Patient suffers from extremely dry mouth', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (5, 5, 3, 1, 'Constant, dull headache on the top of head', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (6, 2, 3, 2, 'Patient vomitted 2 times', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 5, 3, 1, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 5, 3, 1, 'More hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 4, 3, 1, 'Hair loss was noted', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 3, 1, 'After 3 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (6, 4, 3, 1, 'After 4 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (5, 4, 3, 1, 'After 1 week patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (1, 1, 3, 5, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (2, 2, 1, 3, 'A lot ofrash on neck', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (3, 3, 4, 7, 'After 2 days patient get diarrhea', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 4, 4, 'Patient suffers a lot because od fry mouth', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (1, 1, 3, 5, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (2, 2, 1, 3, 'Rash on neck and chest', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (3, 3, 4, 7, 'After 3 days patient get diarrhea', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 4, 4, 'Patient suffers from extremely dry mouth', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (5, 5, 3, 1, 'Constant, dull headache on the top of head', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (6, 2, 3, 2, 'Patient vomitted 2 times', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 5, 3, 1, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 5, 3, 1, 'More hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (7, 4, 3, 1, 'Hair loss was noted', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 3, 1, 'After 3 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (6, 4, 3, 1, 'After 4 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (5, 4, 3, 1, 'After 1 week patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (1, 1, 3, 5, 'After 2 weeks patient noticed hair loss', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (2, 2, 1, 3, 'A lot ofrash on neck', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (3, 3, 4, 7, 'After 2 days patient get diarrhea', GETDATE());
INSERT INTO ARIS.dbo.Incident VALUES (4, 4, 4, 4, 'Patient suffers a lot because od fry mouth', GETDATE());

SELECT * FROM ARIS.dbo.Incident
SELECT * FROM ARIS.dbo.IncidentSource
SELECT * FROM ARIS.dbo.PharmaceuticalForm
SELECT * FROM ARIS.dbo.Patient
SELECT * FROM ARIS.dbo.SideEffect

--view sideEffectOfDrugPerMonth - ilosc efektów ubocznych zgłoszona w bieżącym miesiącu

USE ARIS
GO

IF OBJECT_ID ('ARIS.dbo.sideEffectOfDrugPerMonth', 'V') IS NOT NULL
DROP VIEW sideEffectOfDrugPerMonth ;

GO

Create View sideEffectOfDrugPerMonth
AS
SELECT SideEffect.name as SideEffect, count(SideEffect.name) as amount FROM incident
INNER JOIN SideEffect
ON SideEffect.id = incident.SideEffectID
WHERE DATEPART(MONTH, date)=DATEPART(MONTH, GETDATE())
GROUP BY SideEffect.name

GO

SELECT * FROM sideEffectOfDrugPerMonth

--view Top3Patients - trzech pacjentów, którzy zgłaszali najwięcej skutków ubocznych w bieżącym miesiącu

USE ARIS
GO

IF OBJECT_ID ('Top3Patients', 'V') IS NOT NULL
DROP VIEW Top3Patients;

GO

Create View Top3Patients
AS
SELECT TOP(3) count(incident.PatientID) AS number, Patient.LastName FROM incident 
INNER JOIN patient
ON incident.PatientID = patient.id
GROUP BY Patient.LastName
ORDER BY number DESC

GO

SELECT * FROM Top3Patients

-- PROCEDURE numberOfIncidentsReported - liczba incydentów zgłoszona danym źródłem

IF OBJECT_ID ( 'numberOfIncidentsReported', 'P' ) IS NOT NULL 
    DROP PROCEDURE numberOfIncidentsReported;
GO

CREATE PROCEDURE numberOfIncidentsReported (@source varchar(50)) 
AS
SELECT COUNT(*) as numberOfIncidentsReported FROM incident WHERE IncidentSourceID IN (SELECT id FROM  IncidentSource WHERE name = @source)

GO

-- WYWOŁANIE PROCEDURY numberOfIncidentsReported

EXEC numberOfIncidentsReported 'telephone'

-- PROCEDURE SideEffectOfDrug - Produkty, które wywołały dany skutek uboczny

IF OBJECT_ID ( 'SideEffectOfDrug', 'P' ) IS NOT NULL 
    DROP PROCEDURE SideEffectOfDrug;
GO

CREATE PROCEDURE SideEffectOfDrug (@effect varchar(50)) 
AS
SELECT name FROM product WHERE id IN (SELECT ProductID FROM incident where SideEffectID in (SELECT id FROM SideEffect WHERE name = @effect))

GO

-- WYWOŁANIE PROCEDURY numberOfIncidentsReported

EXEC SideEffectOfDrug 'vomits'

-- PROCEDURE sexOFPatients - płeć pacjentów, którzy zgłaszali dany skutek uboczny

IF OBJECT_ID ( 'sexOFPatients', 'P' ) IS NOT NULL 
    DROP PROCEDURE sexOFPatients;
GO

CREATE PROCEDURE sexOFPatients (@effect varchar(50)) 
AS
SELECT Sex FROM patient WHERE id IN (SELECT PatientID FROM incident WHERE SideEffectID IN (SELECT id FROM SideEffect WHERE  name = @effect))

GO

-- WYWOŁANIE PROCEDURY sexOFPatients

EXEC sexOFPatients 'vomits'

