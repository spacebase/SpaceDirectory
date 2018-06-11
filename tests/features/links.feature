@api
Feature: Test social media links
  As a visitor to the site, the social media and feedback links should work.

    Scenario: Facebook link
    Given I am on "/"
    When I click on the element with xpath """
/html/body/div[3]/footer[2]/div/div/section[1]/a[1]/i
"""
    And I wait until the page loads
    #TODO not sure why these are failing, need to see screen to see where browser is going
    Then I should see "Greetings from New Zealand!"


    Scenario: Twitter link
    Given I am on "/"
    When I click on the element with xpath """
//a[@href='https://twitter.com/SpaceBaseNZ']
"""
    And I wait until the page loads
    Then I should see "Tweet to SpaceBase"


    Scenario: YouTube link
    Given I am on "/"
    When I click on the element with xpath """
//*[@id="block-sociallinks"]/a[3]
"""
    And I wait until the page loads
    Then I should see "Videos"


    Scenario: LinkedIn link
    Given I am on "/"
    When I click on the element with xpath """
//*[@id="block-sociallinks"]/a[4]
"""
    And I wait until the page loads
    Then I should see "Company details"



