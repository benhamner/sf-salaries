.separator ","

CREATE TABLE Salaries (
    Id INTEGER PRIMARY KEY,
    EmployeeName TEXT,
    JobTitle TEXT,
    BasePay NUMERIC,
    OvertimePay NUMERIC,
    OtherPay NUMERIC,
    Benefits NUMERIC,
    TotalPay NUMERIC,
    TotalPayBenefits NUMERIC,
    Year INTEGER,
    Notes TEXT,
    Agency TEXT,
    Status TEXT);

.import "working/noHeader/Salaries.csv" Salaries

CREATE INDEX salaries_year_idx ON Salaries (Year);
