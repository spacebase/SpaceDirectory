@api

Feature: Test the main flow of creating profiles, organizations and discussions within organizations. Status:main:clean.
  As a user with an account, I want to be able to test
  view profile, edit profile, check profile, anonymous user cannot edit, but can view.
  Other logged in users cannot edit, but can view.

Background:
  Given users:
    | name              | password    | username   | email          |  
    | Behat TestFounder | passw345534 | BehatTstTF | tf@example.com |
    | Behat TestJoiner  | passw654891 | BehatTstJ  | j@example.com  | 

  Scenario: Forms exist
    Given I am on "/"
    When I click "Join"
    Then I should see "Sign up for SpaceBase"
    When I am on "/"
    And I click "Sign In"
    Then I should see "Password"
    


  Scenario: Login as authenticated user and edit profile 
    # this user should already exists in the environment
    #Given users:
    #  | name           | password  | username       |
    #  | Kurt UserAtest | passw0rd | kurtuseratest  |
    Given I am logged in as "Behat TestFounder"
    When I am on "/u/Behat-TestFounder"
    Then I should see the link "Log out"
    And I should see "Bio"
    And I click "Edit Profile"
    Then I should see "Edit account settings"

    # Not working in tests, something off about test user email
    # and password.
    #    And I fill in the following:
    #  | edit-current-pass          | passw345534 |
    #  | edit-mail                   | tf@example.com |
    #  | edit-field-position-0-value | I am an automatic testbot |
    #And I press the "Save" button
    #Then I should see "The changes have been saved"

    # AccessTestIt
    # Stay on this page, not accessible to the following user:
    # or use $session->back(); ?
    #    And I click "Edit Profile"
    #Then I should see "Edit account settings"
    #Given I am logged in as a user with the "Authenticated user" role
    #Then I should see "Edit account settings"
    
  # Create an Organization, which I can work with.
  # This, apparently, is clean. deleted when user removed?
  Scenario: Create organization
    Given I am logged in as "Behat TestFounder"
    And I am on "group/add/organization_group"
    When I fill in the following:
      | label[0][value] | Behat Test Org |
      | edit-field-description-0-value | Description of Acme Test Org |
      | field_industry_segment[] | 34 |
    And I press "Create Organization"
    Then I fill in the following:
      | edit-field-organization-role-0-value | Role at Behat Test Org |
    And I press "Save group and membership"
    # Anti-spam security gets in the way: I believe it is supposed to.
    Then I should see "There was a problem with your form submission. Please wait 6 seconds and try again."
    And I wait 6 seconds
    And I press "Save group and membership"

    # Add Discussion
    Then I should see "has been created."
    # you'll land on the Members page... Go to discussion forum and add one:
    And I should see "Invite New Members"
    Then I click "discussions"
    And I should see "Welcome to your organization's discussion forum."
    Then I click "behat-new-post"
    # @ToDoDiscuss: there's no title on this page.
    And I fill in the following: 
      | edit-title-0-value | Behat Test Discussion Title |
      #Editor is an iframe, not getting into complex testing now.
    And I wait 6 seconds
    And I press "Save"
    Then I should see "has been created"
    And I should see "Behat Test Discussion Title" 
    # On the discussions page
    Then I should see "Welcome to your organization"
    And I click "Behat Test Discussion Title"

    ## @ToDo: can't click the empty-ish name=forum-edit-discussion
    #  icon link. Is this a behat-only problem, or also screenreaders?
    #  Techniques like this could work, I think, if this acceptable:
    #  https://stackoverflow.com/questions/33649518/how-can-i-click-a-span-in-behat
    #  TUTORIAL: I needed a new feature context, so wrote a function
    #  in ./bootstrap/FeatureContext.php 
    Then I click the link containing child element ".fa-edit"
    # Editing the discussion
    And I fill in the following:
      | edit-title-0-value | Behat EDITED Test Discussion Title |
    And I wait 11 seconds
    And I press "Save"
    Then I should see "has been updated"    
    
    # Problem: log in as Authenticated takes me to that page.
    # Have to get back to this org! /org/
    Given I am logged in as a user with the "Authenticated user" role
    # ok:    And I am on "/org/te-connectivity"
    # fails: And I am on "/org/behat-test-org"
    # @ToDo question why this doesn't work

    ## Hard to find the org!
    # Go to org owner:
    When I am on "/u/Behat-TestFounder"   
    And I click "Behat Test Org"
    Then I should see "Behat EDITED Test Discussion Title"
    # That is a link, with the URL. Could write a function to extract it
    #  and add edit, as an access check. Going to just parallel the above 
    #  for now
    #Then I fail to click the link containing child element ".fa-edit"

    # u/behattesth
    #Then I should see "the screenshot"


    # @ToDo, maybe Rich, add an External Resources? Then remove it?
    # Do so and fail as an authorized user, without enough permission?
    #

