*** Settings ***
Library  SeleniumLibrary
Variables  ../page objects/objects.py
Library  SeleniumLibrary
*** Variables ***
${url}   https://tst-portal-us.gnonlineservices.com/
${browser}  chrome
${test_user_value}   gnusers
${test_password_value}   GNCloud@2018
${test_wrong_user}  ram256343
${test_wrong_password}  bbxus7698@
${loop_var}     0
${r_acc_no}   000999977654
${r_user}   Ram1234567
${r_email}  ram@gmail.com
${r_fname}  ram
${r_phone}  988685637846
${r_no_of_countries}  13
${r_no_of_languages}    35
${r_lname}  sagar
${log_email}    ramsagar70901@gmail.com
${log_password}     8o27p48o7
*** Keywords ***
open the browser
    open browser    ${url}  ${browser}
    maximize browser window
verify test user
    [Arguments]  ${test_user_value}    ${test_password_value}   ${test_wrong_user}  ${test_wrong_password}
    click button    ${test_login}
    page should contain     ${test_invalid_login_verify}
    input text  ${test_username}      ${test_user_value}
    click button    ${test_login}
    page should contain     ${test_invalid_login_verify}
    input text  ${test_password}     ${test_password_value}
    click button    ${test_login}
    page should contain     ${test_invalid_login_verify}
    input text  ${test_username}    ${test_wrong_user}
    input text  ${test_password}    ${test_wrong_password}
    click button    ${test_login}
    page should contain     ${test_invalid_login_verify}
    input text  ${test_username}      ${test_user_value}
    input text  ${test_password}     ${test_password_value}
    click button    ${test_login}
    page should contain     ${test_login_verify}
verify home page
    click element   ${home_login_button}
    sleep   2
    input text      ${login_email}  ${log_email}
    sleep   3
    click element    ${home_login_button_cancel}
    click element    ${home_register_button}
    page should contain     ${register_verify}
verify contact
    click element   ${contact_button}
    page should contain     ${contact_verify}
verify home
    click element   ${home_button}
    page should contain     ${test_login_verify}
verify register
    [Arguments]  ${r_acc_no}  ${r_user}     ${r_email}      ${r_no_of_countries}    ${r_no_of_languages}   ${r_fname}    ${r_phone}    ${r_lname}
    click element   ${register_button}
    page should contain     ${register_verify}
    input text  ${account_no}    ${r_acc_no}
    input text  ${register_username}     ${r_user}
    input text  ${register_email}     ${r_email}
    input text  ${register_fname}        ${r_fname}
    input text  ${register_phone}    ${r_phone}
    WHILE   ${loop_var} <=${r_no_of_countries}
        select from list by index   ${register_list_country}  ${loop_var}
        ${loop_var}=    evaluate    ${loop_var}+1
    END
    ${loop_var}=   set variable    0
    WHILE   ${loop_var} <${r_no_of_languages}
        select from list by index       ${register_list_languages}  ${loop_var}
        ${loop_var}=    evaluate    ${loop_var}+1
    END
    input text  ${register_conf_email}     ${r_email}
    input text  ${register_lname}     ${r_lname}
    select checkbox     ${register_checkbox}
    click button    ${register_submit}
    page should contain     ${register_verify_invalid}
verify login element
    click element   ${login_button}
    sleep   1
    input text      ${login_email}  ${log_email}
    click button    ${login_next}
    wait until element is visible   ${login_cookie}     15
    ${cookie}   run keyword and return status   element should be visible   ${login_cookie}
    IF  ${cookie}
        click button   ${login_cookie}
    END
    input text  ${login_password}    ${log_password}
    click button    ${login_continue}
    title should be     ${login_verify}
    click element   id:PasswordResetExchange
    sleep   30
    #wait until element is visible   d:emailVerificationForPasswordResetControl_but_send_code    10
    #click element   id:emailVerificationForPasswordResetControl_but_send_code