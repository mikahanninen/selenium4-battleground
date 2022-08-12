*** Settings ***
Library             RPA.Browser.Selenium

#Library    ExtendedSelenium
Suite Teardown      Close All Browsers


*** Variables ***
${PORTAL_SITE}      https://portal.robocorp.com


*** Tasks ***
Minimal task
    Open Available Browser    ${PORTAL_SITE}    #browser_selection=firefox
    Capture Page Screenshot    ${OUTPUTDIR}${/}screenshot.png
    Highlight Elements    css:button
    Sleep    5s
    Clear All Highlights
    Log    Done.
