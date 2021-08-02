*** Settings ***
Documentation    Suite description
Library     ../PythonDataDip/epas.py
Variables   ../PythonDataDip/config_epas.py

Suite Setup     setup
Suite Teardown  teardown
Test Teardown   sleep  30

*** Test Cases ***
epas: basic_prov_cust_db
    [Tags]    include   epas   sanity   demo
    ${resturnStatus}=  basic_prov_cust_db   ${epas_custname}  ${epas_dbname}   ${epas_custdata}   ${EPAS_EXCEL_NAME}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed

epas: basic_unprov_cust_db
    [Tags]    include   epas   sanity  demo
    ${resturnStatus}=  basic_unprov_cust_db   ${epas_custname}  ${epas_dbname}  ${epas_custdata}   ${EPAS_EXCEL_NAME}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed

epas: basic_create_cust_bucket
    [Tags]    include   epas   sanity
    ${resturnStatus}=  basic_create_cust_bucket  ${epas_custname}  ${epas_dbname}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed

epas: delete_loaded_cust_bucket
    [Tags]    include   epas   sanity
    ${resturnStatus}=  delete_loaded_cust_bucket   ${epas_custname}  ${epas_dbname}  ${epas_custdata}  ${EPAS_EXCEL_NAME}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed



epas: basic_delete_empty_cust_bucket
    [Tags]    include   epas
    ${resturnStatus}=  basic_delete_empty_cust_bucket    ${epas_custname}  ${epas_dbname}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed



epas: negative_create_already_exist_cust_bucket
    [Tags]    include   epas
    ${resturnStatus}=  negative_create_already_exist_cust_bucket  ${epas_custname}  ${epas_dbname}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed


epas: unprov_nonexist_cust_db
    [Tags]    include   epas
    ${resturnStatus}=  unprov_nonexist_cust_db     ${epas_custname}  ${epas_dbname}
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed


epas: provision_cust_db_in_new_instance
    [Tags]    include   epas   sanity
    ${resturnStatus}=  provision_cust_db_in_new_instance
    run keyword unless  '${resturnStatus}' == 'PASS'   fail  testFailed







