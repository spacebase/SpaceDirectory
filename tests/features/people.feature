@api

Feature: Test user profiles
  As a user with an account, I want to be able to test
  view profile, edit profile, check profile, anonymous user cannot edit, but can view.
  Other logged in users cannot edit, but can view.

Background:
  Given users:
    | name          | password | username           |
    | Behat Test    | passw0rd | BehatTestUser      |
    | Behat Test 2  | passw0rd | BehatTestabc.-'_@  |

  Scenario: Forms exist
    Given I am on "/"
    When I click "Join"
    Then I should see "Sign up for SpaceBase"
    When I am on "/"
    And I click "Sign In"
    Then I should see "Password"

  Scenario: Login as authenticated user
    # this user should already exists in the environment
    Given users:
      | name           | password  | username       |
      | Kurt UserAtest | passw0rd | kurtuseratest  |
    Given I am logged in as "Kurt UserAtest"
    When I am on "/u/kurt-useratest"
    Then I should see the link "Log out"
    And I should see "Bio"

    #change the following to reflect specs in #175
    #the following presumes this user already exists... created above
    And I am on "https://spacebase.lndo.site/search?keywords=useratest"
    Then I should see "UserAtest"

    
    #  Scenario: See Bio page
    #Given I am logged in as a user with the "Authenticated user" role
    #And I am on "https://spacebase.lndo.site/search?keywords=UserAtest"



  Scenario: Edit own profile
    # this user should already exist in the environment
    Given users:
      | name           | password  | username       |
      | Kurt UserAtest | passw0rd | kurtuseratest  |
    Given I am logged in as "Kurt UserAtest"
    When I am on "/u/kurt-useratest"
    Then I should see the link "Log out"
    And I should see "Bio"
    #TODO can't press Edit Profile button, so instead resorting to going directly to URL
    # @ToDo -- why not above?
    # @ToDo -- No no no....
    When I am on "/user/125/edit"
    #TODO and the following errors...
    And I fill in the following:
      | edit-field-position-0-value | my position |
    And I press the "Save" button
    Then I should see "The changes have been saved"


  Scenario: Anon cannot edit another profile
    Given I am an anonymous user
    When I am on "/u/kurt-useratest"
    Then I should not see the link "Log out"
    And I should see "Bio"
    And I am on "/user/125/edit"
    Then I should see "You are not authorized to access this page"


  Scenario: Authenticated user cannot edit another profile
    Given I am logged in as a user with the "Authenticated user" role
    When I am on "/u/kurt-useratest"
    And I should see "Bio"
    And I am on "/user/125/edit"
    Then I should see "You are not authorized to access this page"


  Scenario: Fill in sign up form
    Given I am on "/user/register"
    When I fill in the following:
      # this user should NOT already exists in the environment
      | edit-mail | BehatTest0h@mailinator.com |
      | edit-name | BehatTesth |
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
    Then I should not see text matching "is already taken"
    And I should see "An email has been sent to you"
    #TODO need mailhog integration
    #And I should see an email with subject "Account details for"
    # make sure the user you created shows up in search results and that the link traverses to the correct profile data
    # also https://gitlab.com/spacebase/spacebase/issues/175
    And I am on "/search/people?keywords=Behat0f"
    And I should see "Behat0f"


  Scenario: Fill in sign up form with special characters
    Given I am on "/user/register"
    When I fill in the following:
      # this user should NOT already exists in the environment
      | edit-mail | BehatTest_1h@mailinator.com |
      | edit-name | BehatTest@1h |
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
    Then I should not see text matching "is already taken"
    And I should not see text matching "The username contains an illegal character"
    And I should see "An email has been sent to you"


  Scenario: Login with username that has special characters
    Given I am logged in as "Behat Test 2"
    When I follow "behat-edit-profile" 
    Then I should see "Bio"


  Scenario: Anonymous visitor should not be able to edit a user
    Given I am not logged in
    # this user should already exists in the environment
    When I am on "/u/kurt-useratest"
    Then I should not see "Edit Profile"
    And I should not see "The requested page could not be found"
    And I should see "My Organizations"


  # https://gitlab.com/spacebase/spacebase/issues/175
  # Scenario: User must enter first and last names
  #   Given I am not logged in

