@api
Feature: Test search
  As a User, I want to be able to search for content

  Scenario: Home Page Search
    Given I am on "/"
    And I enter "Space" for "edit-keywords"
    When I press the "edit-submit-sitewide-search" button
    Then I should see "Search results for Space"



  Scenario: People Search
    Given I am on "/search/people"
    Then I should see "People"

  Scenario: People Search for substring
    Given I am on "/search"
    And I enter "hig" for "edit-keywords"
    When I press the "edit-submit-sitewide-search" button
    Then I should see "Kurt Higgins"



  Scenario: Organization Search
    Given I am on "/search/organizations"
    Then I should see "Organizations"

  Scenario: Organization Search for substring
    Given I am on "/search"
    And I enter "space" for "edit-keywords"
    When I press the "edit-submit-sitewide-search" button
    And I follow "see all "
    And I wait until the page loads
    Then I should see "SpaceBase"

  Scenario: Org Search using city and industry facets
    Given I am on "search/organizations?keywords=space"
    When I follow "city-wellington"
    And I wait until the page loads
    Then I should see "SpaceBase"
    And I follow "Outreach and Education"
    And I wait until the page loads
    Then I should see "SpaceBase"


#TODO
# make sure search results of people have links that are valid
# Reference #175