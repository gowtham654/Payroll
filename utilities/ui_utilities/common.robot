*** Settings ***
Library  SeleniumLibrary   

*** Variables ***
${URL}     https://livetest.greythr.com/
@{Username_Password}     majordomo     sa
&{Variable}     username=majordomo     password=sa  

*** Keywords ***
Process Payroll for All Employees
    Open Browser    ${URL}     chrome
    Maximize Browser Window
    Set Browser Implicit Wait    5
    Input Text    id=username    &{Variable}[username]  
    Input Password    id=password    &{Variable}[password]  
    Click Button     //button[@class='btn btn-primary btn-block mt-1']
    Click Element    //a[@href='/ngapp/payroll']  
    Click Element    //span[.='Process']   
    Click Element    //span[.='Payroll Process']    
    Click Button    //button[@class='btn btn-primary'][@data-original-title='Quick Process']      