*** Settings ***
Resource   ../../utilities/ui_utilities/common.robot 
Library   Selenium2Library

Test Setup    ToLogin


*** Test Cases ***
TC-01 To Add new Employee 
    Add Employee
    
To process Payroll for AllEmployeees
    Process Payroll for All Employees
    
TC-03 To verfy Quick Salary Statement
    Quick Salary Statement
    
Tc-To Verify the Payroll Statement
    Payroll Statement
    
Tc-To Verify the Payroll Difference
    Payroll Difference
    
To download Payslip
    To Download Payslip
    
Tc To Release the payslip
   To Release Payslip and itStatement
   
Tc Todo Arrear Process
    Arrear Process