*** Settings ***
Library             RPA.Browser.Selenium
Library             Collections

#Library    ExtendedSelenium
Suite Teardown      Close All Browsers


*** Variables ***
${PORTAL_SITE}          https://portal.robocorp.com
@{BROWSERS_TO_CHECK}    chrome    firefox
@{FAILURES}             @{EMPTY}


*** Tasks ***
Minimal task
    FOR    ${browser}    IN    @{BROWSERS_TO_CHECK}
        TRY
            Portal Check    ${browser}
        EXCEPT
            Log To Console    \n${browser} browser failed
            Append To List    ${FAILURES}    ${browser}
        END
    END
    IF    len(${FAILURES}) > 0    Fail
    Log    Done.


*** Keywords ***
Portal Check
    [Arguments]    ${browser_selection}=AUTO
    Open Available Browser    ${PORTAL_SITE}    browser_selection=${browser_selection}
    Capture Page Screenshot    ${OUTPUTDIR}${/}screenshot.png
    # Highlighting used because there was Selenium 4 change related change within `Clear All Highlights` keyword 
    Highlight Elements    css:button
    Sleep    5s
    Clear All Highlights
