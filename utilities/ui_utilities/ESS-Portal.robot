*** Settings ***
Library    Selenium2Library    
Resource    ../parser_utilities/test_bed_parser.robot

*** Keywords ***
 download payslip and itstatement from ess portal
    Open Browser    ${URL}     ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    5
    Input Text    id=username   ${employye no} 
    Input Password    id=password    ${employee password}
    Click Button     //button[@class='btn btn-primary btn-block mt-1']
    Set Selenium Implicit Wait    5
    #Click Element         //a[.=' older version']    
    Click Element    //a[.='My Info']    
    Click Element    //a[.='Payslip']   
    Click Element    //button[.=' Download As PDF'] 
     Click Element    //a[.='My Info']
    Click Element    //li[.='IT Statement']        
    Select From List By Value    //select[@title='Select a month to view payslip for that month']     89
     Click Element    //button[.=' Download As PDF']  
     Close Browser      