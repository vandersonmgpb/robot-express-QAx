*** Settings ***
Documentation        Online

Resource        ../resources/base.resource

*** Test Cases ***    
Webapp deve estar online
    
    Start session
    Get Title        equal    Mark85 by QAx

    #Sleep    5

