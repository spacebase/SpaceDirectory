@javascript
Feature: Test search, requiring javascript. Status:main:clean-req:content

  #    Given I am on "search/organizations?keywords=space"


  Scenario: Org Search using city and industry facets
    # Seems to fail (the site, not the test) on my localhost
    Given I am on "https://spacebase.co/search/organizations?keywords=space"
    And I wait 2 seconds
    #When I follow "city-wellington" = no link
    #When I click "city-wellington" = no link
    When I check the box "city-wellington"
    #When I check the box "Wellington"
    And I wait until the page loads
    Then I should see "SpaceBase"
    And I should see "SpaceLaunch" 
    And I check the box "Outreach and Education"
    And I wait until the page loads
    Then I should see "SpaceBase"
    And I should see "Space & Science Festival"
    And I should not see "SpaceLaunch"
