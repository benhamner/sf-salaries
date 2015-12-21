import os
import numpy as np
import pandas as pd

data = pd.DataFrame()

col_names = ["EmployeeName",
             "JobTitle",
             "BasePay",
             "OvertimePay",
             "OtherPay",
             "Benefits",
             "TotalPay",
             "TotalPayBenefits",
             "Year",
             "Notes",
             "Agency"]

for year in range(2011, 2015):
    if year==2014:
        col_names = col_names + ["Status"]
    year_data = pd.read_csv("input/san-francisco-%d.csv" % year,
                            header=None,
                            skiprows=1,
                            names=col_names)
    if year==2011:
        year_data["Benefits"] = np.nan # originally "Not Provided"
    if year<2014:
        year_data.insert(year_data.shape[1], "Status", np.nan)
    data = pd.concat([data, year_data])

data.insert(0, "Id", list(range(1, len(data)+1)))
data.to_csv("output/Salaries.csv", index=False)
