*** Settings ***
Library    BuiltIn
Library    OperatingSystem  

*** Keywords ***
Get Home dir
    ${home_dir}=     Set Variable
    [Return]    ${home_dir}          

