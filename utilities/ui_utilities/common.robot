*** Settings ***
 
Resource    ../parser_utilities/test_bed_parser.robot
Library   OperatingSystem    
Library   Selenium2Library

*** Keywords ***
ToLogin
    Open Browser    ${URL}     ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    5
    Input Text    id=username    &{Variable}[username]  
    Input Password    id=password    &{Variable}[password]  
    Click Button     //button[@class='btn btn-primary btn-block mt-1']
         
Add Employee
     Set Browser Implicit Wait    5
    Click Element    //a[@href='/ngapp/employee'] 
    Click Element    //a[@href='/ngapp/employee/main']    
    Click Element    //span[.='Employee Directory']
    Click Button    //button[.='Add Employee']
    sleep  5  
    Click Element    //span[.='---Select---']
    sleep  5
   # Click Element    //option[.='Permanent Employees'][@value='2']    
    Input Text    //input[@name='name']    Yogesh    
    Click Element    //input[@name='sex'][@value='M']    
    sleep  5
    Click Element    //input[@name='doj']
    Click Button    //a[.='28']              

Process Payroll for All Employees
    Click Element    //a[@href='/ngapp/payroll']  
    Click Element    //span[.='Process']   
    Click Element    //span[.='Payroll Process']    
    Click Button    //button[@class='btn btn-primary'][@data-original-title='Quick Process']
    Close Browser
    
To Release Payslip and itStatement
     Set Browser Implicit Wait    8
     Click Element    //a[@href='/ngapp/payroll']  
     Click Element     //a[@href='/ngapp/payroll/main']
     Click Element    //a[@href='/ngapp/payroll/main/overview/: id'] 
     sleep     8  
     Click Element    //a[@id='pushActionRefuse']    
     #Wait Until Page Contains Element    //button[.='Release']        
     Click Element     //button[.='Release']  
           Execute Javascript    window.scrollBy(0,200)
      #Page Should Contain Element    //li[.='Payroll is released for all the employees']    
    # Element Text Should Be    //li[.='Payroll is released for all the employees']    Payroll is released for all the employees    
     Click Element    //button[@ng-click='updateIncomeTax(m)'] 
     #Page Should Contain Element    //li[.='IT Statement for the employees has been released.']    
     Element Text Should Be    //li[.='IT Statement for the employees has been released.']    IT Statement for the employees has been released.    
     
Quick Salary Statement
      Set Browser Implicit Wait    5
      Click Element    //a[@href='/ngapp/payroll']  
     Click Element    //span[.='Verify'] 
      Click Element     //span[.='Quick Salary Statement']
     Element Text Should Be    //h2[.='Quick Salary Statement']    Quick Salary Statement
     Page Should Contain Button    //button[.='Export to Excel']  
     Element Should Be Enabled         //button[.='Export to Excel']
     Click Button    //button[.='Export to Excel']    
     
Payroll Statement
     Set Browser Implicit Wait    5
     Click Element    //a[@href='/ngapp/payroll']  
     Click Element    //span[.='Verify'] 
     Click Element    //span[.='Payroll Statement']  
     Click Element    //span[@ng-click='addPayStatement()']
     Input Text    //input[@name='name']    New Statement
     Input Text    //input[@name='reportTitle']    Report Title   
     Execute Javascript    window.scrollBy(0,500) 
     Click Element    //button[.='Next ']  
      sleep  3
     Execute Javascript    window.scrollBy(0,600)
     Click Element    //a[@id='pushActionRefuse']    
     Click Button    //button[@ng-click='addAllIncomeCols()']
     Click Button    //button[@ng-click='addAllDeductionCols()']
     Click Button    //button[@ng-click='removeAllCols()']    
     sleep     3
     click button  //button[@ng-click='addIncomeAndDeductionCols()']   
    # Click Element    //i[@ng-click='item.expanded = !item.expanded'][1]
     Click Element    //button[.='Next ']
     sleep      3
     Scroll Element Into View    //button[.='Next ']
     Click Element    //button[.='Next ']
      Scroll Element Into View    //button[.='Next ']
      Execute Javascript    window.scrollBy(0,500)
      sleep  3
      Click Element    //button[.= ' Finish']

     
Payroll Difference
     Set Browser Implicit Wait    5
     sleep  8
     Click Element    //a[@href='/ngapp/payroll']  
     Click Element    //span[.='Verify'] 
     Click Element    //a[@href='/ngapp/payroll/verify/payrolldifference']
     Element Text Should Be    //h3[.='Payroll Differences']    Payroll Differences
     sleep  2
     Click Element    //span[@class='btn'][@data-toggle='dropdown']
     sleep  2
     Click Element    //a[.='Employee Wise Report']    
     sleep  2
     Click Element    //span[.='Employee Wise Report']    
     sleep  8
     Click Element    //span[@class='btn'][@data-toggle='dropdown'] 
     Click Element  //a[.='Consolidated Report']     
      Click Element    //span[.='Consolidated Report'] 
      sleep  8
      Click Element    //span[@class='btn'][@data-toggle='dropdown'] 
    Click Element    //a[.='Item Wise Report']    
    Click Element    //span[.='Item Wise Report']    
    
To Download Payslip
     Set Browser Implicit Wait    5
    Click Element    //a[@href='/ngapp/payroll'] 
    Click Element    //span[.='Payout']
    Click Element    //span[.='Payslips']     
    Page Should Contain Element    //h3[.='Payslips']    
    Element Text Should Be    //h3[.='Payslips']    Payslips           
    Select Checkbox    //input[@type='checkbox' and @id='selectAll']
    Execute Javascript    window.scrollBy(0,500)
    sleep     5
    Click Element    //span[@class='btn']    
    Page Should Contain    Downloading Payslip(s). Please wait...    
    
Download should be done
    [Arguments]    ${directory}
    [Documentation]    Verifies that the directory has only one folder and it is not a temp file.
    ...
    ...    Returns path to the file
    ${files}    List Files In Directory     ${directory}
    Length Should Be    ${files}    1    Should be only one file in the download folder
    Should Not Match Regexp    ${files[0]}    (?i).*\\.tmp    Chrome is still downloading a file
    ${file}    Join Path    ${directory}    ${files[0]}
    Log    File was successfully downloaded to ${file}
    [Return]    ${file}
    
Arrear Process
       Set Browser Implicit Wait    5
       Set Selenium Implicit Wait    5
       Click Element    //a[@href='/ngapp/payroll']
       Click Element    //a[@href='/ngapp/payroll/payrollinputs']
       Click Element    //a[@href='/ngapp/payroll/payrollinputs/arrears']  
       sleep  8
       Click Element    //a[@id='pushActionRefuse']
       Execute Javascript    window.scrollBy(0,300)
       Click Button    //button[.='Process']  
       Wait Until Page Contains Element    //div[@class='message-content']      
       Element Text Should Be    //div[@class='message-content']    Please select atleast one record   
       Click Element    //div[@class='ng-scope ag-row ag-row-no-focus ag-row-no-animation ag-row-group ag-row-level-0 ag-full-width-row ag-row-even ag-row-group-contracted']       
       Click Button    //button[.='Process']  
       Wait Until Page Contains Element    //div[@class='message-content']
       Element Text Should Be    //div[@class='message-content']    Arrears processed successfully!  
       Close Browser
              
         
    
To CloseBrowser
    sleep  5
    Close Browser     