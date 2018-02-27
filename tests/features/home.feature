@api
Feature: Testing Home Page content
  As a user, I want to be able to test
  the home page text

  Scenario: Home Page Title
    Given I am on "/"
    Then I should see "Co-create a New Zealand Space Directory!"
