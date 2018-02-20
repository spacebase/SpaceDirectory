@api
Feature: Testing Search
  As a User, I want to be able to search for content

  Scenario: Home Page Search
    Given I am on "/"
    And I enter "Space" for "edit-keywords"
    When I press the "edit-submit-sitewide-search" button
    Then I should see "Search results for Space"

  Scenario: People Search
    Given I am on "/search/people"
    Then I should see "People"

  Scenario: Organization Search
    Given I am on "/search/organizations"
    Then I should see "Organizations"
