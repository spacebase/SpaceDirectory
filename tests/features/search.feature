@api
Feature: Test search Basic
  As a User, I want to be able to search for content

  ## Wait for issue #310
#  Scenario: Home Page Search
#    Given I am on "/"
#    And I enter "Space" for "edit-keywords"
#    When I press the "edit-submit-sitewide-search" button
#    # Needs to be fixed, see https://gitlab.com/spacebase/spacebase/issues/310
#    Then I should see "Search results for Space"



  Scenario: People Search
    Given I am on "/search/people"
    Then I should see "People"

  Scenario: People Search for substring
    Given I am on "/search"
    And I enter "hig" for "edit-search-api-fulltext"
    When I press the "Search" button
    Then I should see "Kurt Higgins"



  Scenario: Organization Search
    Given I am on "/search/organizations"
    Then I should see "Organizations"


  ## wait for issue 310  
#  Scenario: Organization Search for substring
#    Given I am on "/search"
#    And I enter "space" for "edit-search-api-fulltext"
#    When I press the "Search" button
#    And I follow "see all "
#    And I wait until the page loads
#    Then I should see "SpaceBase"


  Scenario: Org Search using city and industry facets
    # Seems to fail (the site, not the test) on my localhost
    Given I am on "spacebase.co/search/organizations?keywords=space"
    When I follow "city-wellington"
    # Or maybe try: When I check "city-wellington"
    And I wait until the page loads
    Then I should see "SpaceBase"
    And I follow "Outreach and Education"
    And I wait until the page loads
    Then I should see "SpaceBase"


#TODO
# make sure search results of people have links that are valid
# Reference #175
