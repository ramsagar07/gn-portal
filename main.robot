*** Settings ***
Library  SeleniumLibrary
Resource  ../testcases/test.robot
*** Test Cases ***
GN PORTAL
    open the browser
    verify test user   ${test_user_value}    ${test_password_value}     ${test_wrong_user}  ${test_wrong_password}
    verify home page
    verify contact
    verify home
    verify register     ${r_acc_no}  ${r_user}     ${r_email}      ${r_no_of_countries}    ${r_no_of_languages}   ${r_fname}    ${r_phone}    ${r_lname}
    verify login element