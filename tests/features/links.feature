@api
Feature: Test social media links
  As a visitor to the site, the social media and feedback links should work.

    Scenario: Facebook link
    Given I am on "/"
    When I click "behat-facebook"
    And I wait until the page loads
    Then I should see "SpaceBase NZ"


    Scenario: Twitter link
    Given I am on "/"
    When I click "behat-twitter"
    And I wait until the page loads
    Then I should see "SpaceBase is a social enterprise with a vision to democratize space for everyone"


    Scenario: YouTube link
    Given I am on "/"
    When I click "behat-youtube"
    And I wait until the page loads
    Then I should see "Videos"


    Scenario: LinkedIn link
    Given I am on "/"
    When I click "behat-linkedin"
    # And I wait until the page loads
    # TODO: resolve issue of 'join now' page loading instead of proper page
    Then I should see "SpaceBase is a social enterprise founded by three Edmund Hillary Fellows"



