@api
Feature: Test user profile permissions
  As a user with an account, I want to be able to test
  view profile, edit profile, check profile, anonymous user cannot edit, but can view.
  Other logged in users cannot edit, but can view.


#  Scenario: Sign up form exists
#    Given I am logged in as "Behat"
#    And I am on "/"
#    And I press

    Given there are users:
      | username    | password | email                   | firstname | lastname | position | tagline | bio          | streetaddress | city          |
      | BehatTest   | 123lkj   | tfiA4XtZ@mailinator.com | Behat     | TEST     | Director | Snappy  | My bio here. | 123 Main At   | Christ Church |
    When I press the "Join" button
    Then I should see "Sign up for SpaceBase"


  Scenario: Sign in form exists
    Given I am on "/"
    And I wait for "Sign In"
    When I press the "Sign In" button
    Then I should see “Log in"


  Scenario: Fill in sign up form
    Given I am on "/user/register"
    Given there are users:
      | username    | password | email                   | firstname | lastname | position | tagline | bio          | streetaddress | city          |
      | BehatTest   | 123lkj   | tfiA4XtZ@mailinator.com | Behat     | TEST     | Director | Snappy  | My bio here. | 123 Main At   | Christ Church |
    When I fill in "edit-name" with my username
    And I fill in "edit-field-first-name-user-0-value" with my firstname
    And I fill in "edit-field-last-name-user-0-value" with my lastname
    And I fill in "edit-field-position-0-value" with my position
    And I fill in "edit-field-tagline-0-value" with my tagline
    And I fill in "edit-field-bio-0-value" with my bio
    #check on following two lines with fields with the random strings at the end
    And I fill in "edit-field-home-location-user-0-address-address-line1--ebsaVAGLvsU" with my streetaddress
    And I fill in "edit-field-home-location-user-0-address-locality--M8YkxdBhYiw" with my city
    And I fill in "edit-pass" with my password
    And I press "Create new account"
    #success page
    Then I should see "An email has been sent to you with instructions to verify your email address and complete the sign-up process"
    #success email
    And I should see an email with subject "Account details for"
