--creating the tables that we need
create table spital.tDepartament
(
    codDep char(10) CONSTRAINT PK_Dep PRIMARY KEY,
    denumire VARCHAR(50)
)


create table spital.tMedici
(
    codMedic char(10) CONSTRAINT PK_Med PRIMARY KEY,
    numeMedic VARCHAR(50),
    salariu int,
    gradDoctor VARCHAR(50),
    codDep char(10) not NULL CONSTRAINT FK_Dep FOREIGN KEY REFERENCES spital.tDepartament(codDep)
)


create table spital.tAsistenti
(
    codAsistent char(10) CONSTRAINT PK_Asistenti PRIMARY KEY,
    numeAsistent VARCHAR(50),
    salariu int,
    gradAsistent varchar(50),
    codDep char(10) not null CONSTRAINT FK_Depart FOREIGN key REFERENCES spital.tDepartament(codDep)
)


create table spital.tTratament
(
    codTratament char(10) CONSTRAINT PK_Trat PRIMARY KEY,
    numeTratament VARCHAR(50)
)


create table spital.tPacienti
(
    codPacient char(10) CONSTRAINT PK_Pacient PRIMARY KEY,
    numePacient VARCHAR(50),
    varsta int,
    afectiune VARCHAR(50),
    codTratament char(10) constraint FK_Tratament FOREIGN key REFERENCES spital.tTratament(codTratament)
)


create table spital.tPrescriptie
(
    idPrescriptie char(10) not null CONSTRAINT PK_Prescriptie PRIMARY KEY,
    cantitatePastile int,
    codTratament char(10) not null constraint FK_Trat FOREIGN KEY REFERENCES spital.tTratament(codTratament),
    codMedic char(10) not null CONSTRAINT FK_Medic FOREIGN KEY REFERENCES spital.tMedici(codMedic)
)


create table spital.tConsultatii
(
    idConsultatie char(10) not null constraint PK_Cons PRIMARY KEY,
    codMedic char(10) not null CONSTRAINT FK_MedicCons FOREIGN KEY REFERENCES spital.tMedici(codMedic),
    codPacient char(10) not null CONSTRAINT Fk_PacientConsultat FOREIGN KEY REFERENCES spital.tPacienti(codPacient)
)


--I. Adding constraints, modifying the tables

--1. Add a type validation constraint to the doctors table, considering the meaning G = general practitioner, R = resident, S = specialist, P = primary care doctor.
alter table spital.tMedici
add constraint ck_GradDoctor check(gradDoctor in ('G', 'R', 'S', 'P'))

--2. Add a type validation constraint to the assistants table, considering the meaning P = principal, S = simple, D = beginner.
alter table spital.tAsistenti
add constraint ck_GradAsistent check(gradAsistent in ('P', 'S', 'D'))

--3. Add a column to the patients table that represents the admission day.
alter table spital.tPacienti
add dataInternarii date;

--4. Add a default value to the new column representing the date the patient is registered.
alter table spital.tPacienti
add constraint ck_data DEFAULT getdate() for dataInternarii

--5. Add a constraint to the Prescriptie table at the cantitatePastile column level.
alter table spital.tPrescriptie
add CONSTRAINT ck_cantitate CHECK (cantitatePastile <>0)

--6. Modify the salary column in the assistants and doctors tables so that the salaries always have a value different from 0.
alter table spital.tMedici
alter column salariu int not null

alter table spital.tAsistenti
alter column salariu int not NULL


--II. Queries on the database
--1. Display all doctors and their specializations
select codMedic, numeMedic, codDep
from spital.tMedici

--2. Display all patients who are older than 50 years
select codPacient,numePacient, varsta
from spital.tPacienti
where varsta>50

--3. Display the assistants whose salary is between 4000 and 5000 lei
select codAsistent, numeAsistent, salariu
from spital.tAsistenti
where salariu BETWEEN 4000 and 5000

--4. Display the patients consulted by the doctor with the code '108'
select A.codPacient, numePacient
from spital.tConsultatii as A inner join spital.tPacienti as B
on A.codPacient=B.codPacient
where codMedic='108'

--5. Display the total number of consultations each patient has had and sort them in descending order by the number of consultations
select numePacient, count(*) as Numar_consultatii
from spital.tConsultatii as A inner join spital.tPacienti as B on a.codPacient=b.codPacient
group by b.numePacient
order by Numar_consultatii desc

--6. Display how many times each treatment has been used and sort them in ascending order by the result obtained
select a.codTratament, b.numeTratament, count(*) as Numar_administrari
from spital.tPrescriptie as A left join spital.tTratament as B on a.codTratament=b.codTratament
GROUP by A.codTratament, b.numeTratament
order by Numar_administrari asc

--7. Display the names of the doctors and the number of consultations provided to the patient with the code 'P010'
select B.numeMedic, count(*) as NumarConsultatii
from spital.tConsultatii as A inner join spital.tMedici as B on a.codMedic=b.codMedic
where codPacient='P010'
group by B.numeMedic

--8. Display the total number of patients registered in each department
select b.codDep, c.denumire, count(*) as Numar_Pacienti
from spital.tConsultatii as A inner join spital.tMedici as B on A.codMedic=B.codMedic
inner join spital.tDepartament as C on c.codDep=b.codDep
group by b.codDep, c.denumire

--9. Display the number of consultations performed in each department
select c.codDep, c.denumire, count(a.idConsultatie) as Numar_consultatii
from spital.tConsultatii as A inner join spital.tMedici as B on a.codMedic=b.codMedic
inner join spital.tDepartament as C on b.codDep=c.codDep
group by c.codDep, c.denumire

--10. Display the average number of pills administered for each treatment
select a.codTratament, b.numeTratament, avg(a.cantitatePastile) as Medie_Pastile_Administrate
from spital.tPrescriptie as A inner join spital.tTratament as B on a.codTratament=b.codTratament
group by a.codTratament, b.numeTratament

--11. Display the names and salaries of doctors whose salary is higher than the average salary of doctors
select numeMedic, gradDoctor, salariu 
from spital.tMedici
where salariu > (select avg(salariu) from spital.tMedici)

--12. Display the doctors who have prescribed the most pills, as well as the name of the treatment administered
select numeMedic, numeTratament, a.cantitatePastile
from spital.tPrescriptie as A inner join spital.tTratament as B on a.codTratament=b.codTratament
inner join spital.tMedici as C on a.codMedic=c.codMedic
where(a.cantitatePastile = (select max(cantitatePastile) from spital.tPrescriptie))

--13. Display the colleagues in the department of the doctor with the code '120'
select codMedic, numeMedic, codDep
from spital.tMedici
where (codDep=(select codDep from spital.tMedici where codMedic='120'))

--14. Create a view named vMedieSalariiMedici that displays the average salary of doctors from each department
CREATE VIEW vMedieSalariiMedici AS
SELECT codDep, AVG(CONVERT(DECIMAL(10, 2), salariu)) AS MedieSalariuMedic
FROM spital.tMedici
GROUP BY codDep

--15. Display the doctors who have salaries lower than the average salary of the department where they work
SELECT m.codMedic, m.numeMedic, m.codDep, m.salariu, v.MedieSalariuMedic
FROM spital.tMedici as m
INNER JOIN vMedieSalariiMedici as v ON m.codDep = v.codDep
WHERE m.salariu < v.MedieSalariuMedic

--16. Create a view named vMedieSalariiAsistenti that displays the average salary of assistants from each department
CREATE VIEW vMedieSalariiAsistenti AS
SELECT codDep, AVG(CONVERT(DECIMAL(10, 2), salariu)) AS MedieSalariuAsistenti
FROM spital.tAsistenti
GROUP BY codDep

--17. Create a view named vMedieSalariiPerDepartament that displays, in a single query, the average salaries of both doctors and assistants
CREATE VIEW vMedieSalariiPerDepartament AS
SELECT m.codDep, m.MedieSalariuMedic, a.MedieSalariuAsistenti
FROM vMedieSalariiMedici m
JOIN vMedieSalariiAsistenti a ON m.codDep = a.codDep

--18. Modify the last view so that it includes an additional column named MedieSalariiTotale that calculates the overall average salary per department
ALTER VIEW vMedieSalariiPerDepartament 
AS
SELECT m.codDep, 
       m.MedieSalariuMedic, 
       a.MedieSalariuAsistenti,
       (m.MedieSalariuMedic + a.MedieSalariuAsistenti) / 2 AS MedieSalariiTotale
FROM vMedieSalariiMedici as m
JOIN vMedieSalariiAsistenti as a ON m.codDep = a.codDep

--19. Perform a summary of doctors' salaries by department using ROLLUP
select codDep,gradDoctor, 
       sum(salariu)as [Total salarii],
       avg(salariu) as [Salariu mediu],
       min(salariu) as [Salariu minim],
       max(salariu) as [Salariu maxim]
from spital.tMedici
group by codDep,gradDoctor with rollup

--20. Perform a summary of doctors' salaries by department using CUBE
select codDep,gradDoctor, 
       sum(salariu)as [Total salarii],
       avg(salariu) as [Salariu mediu],
       min(salariu) as [Salariu minim],
       max(salariu) as [Salariu maxim]
from spital.tMedici
group by codDep,gradDoctor with cube

--21. Use GROUPING to enhance the results of the above query
select case when grouping(codDep)=0 
            then codDep 
            else 'total general' 
       end as codDep,
       case when grouping(gradDoctor)=0 
              then gradDoctor 
              else '=' 
       end as gradDoctor,
       sum(salariu) as [Total salarii]
from spital.tMedici
group by codDep,gradDoctor with rollup


--III. Creating functions and stored procedures
--1. Create a function that returns the sum of doctors' salaries by department and use it to display the sum of salaries for the 'ORL' department
create function SumaSalariiMediciPerDep (@codDep char(10))
returns INT
AS
BEGIN
DECLARE @s INT
SELECT @s=sum(salariu)
from spital.tMedici
where codDep=@codDep
return @s
END

DECLARE @SumaDepORL INT
set @SumaDepORL=dbo.SumaSalariiMediciPerDep('ORL')

if @SumaDepORL is NULL
print 'Departament necunoscut'
ELSE
print 'Suma salariilor de pe departamentul de ORL este '+convert(char(10),@sumaDepORl)

--2. Create a procedure that displays a list of doctors based on department or name
create procedure ps_ListaMedici   @codDep char(10)='%',
                                  @numeMedic varchar(50)='%'
as
begin
   select codMedic, numeMedic, salariu, gradDoctor
   from spital.tMedici
   where codDep like @codDep
         and numeMedic like @numeMedic
end

EXECUTE ps_ListaMedici 


--IV. SQL Transactions, Cursors, and Triggers
--1. Create a transaction for the tMedici table
begin try
begin TRANSACTION

insert into spital.tMedici 
VALUES ('152', 'Mircea Medeea', 8000, 'R', 'Orto')

UPDATE spital.tMedici
set salariu=7200
where codMedic='101'

commit TRANSACTION
print 'Tranzactie incheiata cu succes!'
end try

begin catch 
    ROLLBACK TRANSACTION
    print 'Tranzactie nereusita!'
end catch

--2. Create a cursor that displays doctors in order
DECLARE @codMedic CHAR(10)
DECLARE @numeMedic VARCHAR(50)
DECLARE @salariu INT
DECLARE @gradDoctor VARCHAR(50)

DECLARE MedicCursor CURSOR FOR
SELECT codMedic, numeMedic, salariu, gradDoctor
FROM spital.tMedici

OPEN MedicCursor

FETCH NEXT FROM MedicCursor INTO @codMedic, @numeMedic, @salariu, @gradDoctor
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Cod medic: ' + @codMedic + ', Nume medic: ' + @numeMedic + ', Salariu: ' + CAST(@salariu AS VARCHAR(10)) + ', Grad doctor: ' + @gradDoctor
    FETCH NEXT FROM MedicCursor INTO @codMedic, @numeMedic, @salariu, @gradDoctor
END

CLOSE MedicCursor
DEALLOCATE MedicCursor

--3. Create a trigger that displays a message after each insertion of a new doctor into the database
CREATE TRIGGER afisareMesajDupaIntroducereMedic
ON spital.tMedici
AFTER INSERT
AS
BEGIN
    DECLARE @mesaj VARCHAR(100);
    SELECT @mesaj = 'Un nou medic a fost inserat cu codul: ' + CAST(i.codMedic AS VARCHAR(10)) + ' și numele: ' + i.numeMedic
    FROM inserted AS i;
    
    PRINT @mesaj
END


