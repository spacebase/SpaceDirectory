@api
Feature: Test Sign in
  As a new user, I want to be able to test
  signing up for an account

  Scenario: Sign up form exists
    Given I am on the homepage
    When I click "Join"
    Then I should see "Sign up for SpaceBase"

  Scenario: Sign in form exists
    Given I am on the homepage
    When I click "Sign In"
    Then I should see "Forgot your password?"


#  Scenario: Sign up with credentials
#    Given there are following users:
#      | username          | password | email                   | firstname | lastname    | position | tagline | bio          | streetaddress | city          |
#      | Kurt HigginsTEST  | 123lkj   | tfiA4XtZ@mailinator.com | Kurt      | HigginsTEST | Director | Snappy  | My bio here. | 123 Main At   | Christ Church |
#
#    And I am on "user/register"
#    When I fill in "edit-name" with my username
#    And I fill in "edit-field-first-name-user-0-value" with my firstname
#    And I fill in "edit-field-last-name-user-0-value" with my lastname
#    And I fill in "edit-field-position-0-value" with my position
#    And I fill in "edit-field-tagline-0-value" with my tagline
#    And I fill in "edit-field-bio-0-value" with my bio
#    #check on following two lines with fields with the random strings at the end
#    And I fill in "edit-field-home-location-user-0-address-address-line1--ebsaVAGLvsU" with my streetaddress
#    And I fill in "edit-field-home-location-user-0-address-locality--M8YkxdBhYiw" with my city
#    And I press "Create new account"
#    #success page
#    Then I should see "An email has been sent to you with instructions to verify your email address and complete the sign-up process"
#    #success email
#    And I should see an email with subject "Account details for"

  Scenario: Sign up with credentials
#    Given there are following users:
#      | username          | password | email                   | firstname | lastname    | position | tagline | bio          | streetaddress | city          |
#      | Kurt HigginsTEST  | 123lkj   | tfiA4XtZ@mailinator.com | Kurt      | HigginsTEST | Director | Snappy  | My bio here. | 123 Main At   | Christ Church |

    Given I am on "/user/register"
    When I fill in "edit-mail" with my "tfiA4XtZ@mailinator.com"
    And I fill in "edit-name" with "Kurt HigginsTEST"
#    And I fill in "edit-field-first-name-user-0-value" with my ""
#    And I fill in "edit-field-last-name-user-0-value" with my lastname
#    And I fill in "edit-field-position-0-value" with my position
#    And I fill in "edit-field-tagline-0-value" with my tagline
#    And I fill in "edit-field-bio-0-value" with my bio
#    #check on following two lines with fields with the random strings at the end
#    And I fill in "edit-field-home-location-user-0-address-address-line1--ebsaVAGLvsU" with my streetaddress
#    And I fill in "edit-field-home-location-user-0-address-locality--M8YkxdBhYiw" with my city
    And I press "Create new account"
    #success page
    Then I should see "An email has been sent to you with instructions to verify your email address and complete the sign-up process"
    #success email
    And I should see an email with subject "Account details for"


#  Scenario: Welcome email contains link


#  Scenario: Logging in
#    Given there are users:
#      | username          | password | email                          | firstname | lastname    |
#      | Kurt HigginsRPH   | 123poi   | kurt+rph@rockpaperhiggins.com  | Kurt      | HigginsRPH  |
#    And I am on “/user/login"
#    When I fill in "edit-name" with my username
#    And I fill in "edit-pass" with my password
#    And I press “Log in"
#    Then I should see “Bio”
#
#
#  Scenario: Password reset
#    Given there are users:
#      | username          | password | email                   | firstname | lastname    | position | tagline | bio          | streetaddress | city          |
#      | Kurt HigginsTEST  | 123lkj   | tfiA4XtZ@mailinator.com | Kurt      | HigginsTEST | Director | Snappy  | My bio here. | 123 Main At   | Christ Church |
#    #clear out the inbox
#    And my inbox is empty
#    When I visit "/user/password"
#    And I wait for 2 seconds
#    And I fill in "edit-name" with my email
#    And I press the "Submit" button
#    Then an email should be sent to my email
#    And I should see an email with subject "Replacement login information for” and from "feedback@spacebase.co"
#    #reference for mail capture with mailhog: https://github.com/rpkamp/mailhog-behat-extension





