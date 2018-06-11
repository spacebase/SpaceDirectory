@api
#Background:
#  Given users:
#    | name           | password | username      |
#    | Kurt UserAtest | passw0rd | KurtuserAtest |
#    | Kurt Higgins   | passw0rd | kurt.higgins  |


Feature: Test user profiles
  As a user with an account, I want to be able to test
  view profile, edit profile, check profile, anonymous user cannot edit, but can view.
  Other logged in users cannot edit, but can view.

  Scenario: Join form exists
    Given I am on "/"
    When I click "Join"
    Then I should see "Sign up for SpaceBase"

  Scenario: Sign in form exists
    Given I am on "/"
    When I click "Sign In"
    Then I should see "Password"

  Scenario: Authenticated user stuff
    Given users:
      | name           | password     | username                             |
      | Kurt UserAtest  | passw0rd | KurtuserAtest |
    # this user should already exists in the environment
    Given I am logged in as "Kurt UserAtest"
    When I am on "/u/kurtuseratest"
    Then I should see "Bio"

    #change the following to reflect specs in #175
    And I am on "https://spacebase.lndo.site/search?keywords=kurt"
    Then I should see "kurthigginstest"

  Scenario: Fill in sign up form
    Given I am on "/user/register"
    When I fill in the following:
      # this user should NOT already exists in the environment
      | edit-mail | BehatTest912@mailinator.com |
      | edit-name | BehatTest912 |
      | edit-field-first-name-user-0-value | Behat |
      | edit-field-last-name-user-0-value | Test |
      | edit-field-position-0-value | Director |
      | edit-field-tagline-user-0-value | Snappy |
      | edit-field-bio-user-0-value | My bio here. |

      #| field_home_location_user[0][address][country_code] | NZ |
      #TODO: when selecting the country, the form changes to reflect new fields.
      #  the following doesn't work.
      #| field_home_location_user[0][address][address_line1] | 90 Cable St |
      #| field_home_location_user[0][address][address_line2] | Te Aro |
      #| field_home_location_user[0][address][locality] | Wellington |

    And I press the "Create new account" button
    And I wait until the page loads
    Then I should see "An email has been sent to you"

    #TODO need mailgun integration
    #And I should see an email with subject "Account details for"

  Scenario: Fill in sign up form with special characters
    Given I am on "/user/register"
    When I fill in the following:
      # this user should already exists in the environment
      | edit-mail | BehatTest_special_chars2@mailinator.com |
      | edit-name | BehatTest .-'@_2 |
      | edit-field-first-name-user-0-value | Behat |
      | edit-field-last-name-user-0-value | Test |
      | edit-field-position-0-value | Director |
      | edit-field-tagline-user-0-value | Snappy |
      | edit-field-bio-user-0-value | My bio here. |

      #| field_home_location_user[0][address][country_code] | NZ |
      #TODO: when selecting the country, the form changes to reflect new fields.
      #  the following doesn't work.
      #| field_home_location_user[0][address][address_line1] | 90 Cable St |
      #| field_home_location_user[0][address][address_line2] | Te Aro |
      #| field_home_location_user[0][address][locality] | Wellington |

    And I press the "Create new account" button
    And I wait until the page loads
    Then I should see "An email has been sent to you"


  Scenario: Login with username that has special characters
    Given users:
      | name       | password | username        |
      | BehatTestabc  | passw0rd | BehatTestabc .-'@_ |
    Given I am not logged in
    And I am on "/user/login"
    #TODO: actually, what SHOULD the URL alias be?
    When I am on "/u/behattestabc"
    Then I should see "Bio"


  Scenario: Anonymous visitor should not be able to edit a user
    Given I am not logged in
    # this user should already exists in the environment
    When I am on "/u/behattestabc"
    Then I should not see "Edit Profile"
    And I should see "My Organizations"


  # https://gitlab.com/spacebase/spacebase/issues/175
  Scenario: User must enter first and last names
    Given I am not logged in

  # make sure the user you created shows up in search results and that the link traverses to the correct profile data
  # also https://gitlab.com/spacebase/spacebase/issues/175
  Scenario: New user should appear in search results
