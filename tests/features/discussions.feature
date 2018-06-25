@api
Feature: Test discussions
  As an org-member, I should be able to create and read posts in my group's discussion.
  As an org-owner, I should be able to create, read, update and delete posts in my group's discussion.
  Anonymous users can see discussions but not edit.

  # these tests presume the example discussion already exists

  Scenario: Anonymous user cannot edit
    Given I am an anonymous user
    #TestOrgA Forum
    And I am on "/group/91/forum"
    And I see the text "My Test Discussion "
    #TODO need to identify the following link by any of these: id|name|title|alt|value
    Then I should see "Join SpaceBase"


  Scenario: Group discussion exists
    Given users:
      | name           | password | username      |
      | Kurt UserAtest | passw0rd | KurtuserAtest |
    Given I am logged in as "Kurt UserAtest"
    And I am on "/group/91/forum"
    And I wait until the page loads
    Then I should not see "Join SpaceBase, then join the organizations you are interested in"
    # 1. tried looking for "Welcome to your organization" but that was failing mysteriously
    # 2. this test presumes the example discussion already exists
    And I should see "My Test Discussion"


  Scenario: Org-member user can edit
    # this user should already exists in the environment
    Given users:
      | name           | password | username      |
      | Kurt UserAtest | passw0rd | KurtuserAtest |
    Given I am logged in as "Kurt UserAtest"
    And I am on "/group/91/forum"
    And I see the text "My Test Discussion "
    Then I should not see "Join SpaceBase, then join the organizations you are interested in"
    # TODO need to add ID="behat-edit-discussion" to line 38, views-view-fields--group-forum.html.twig
    And I should see the link "behat-edit-discussion"


  Scenario: Create a new post
    # this user should already exists in the environment
    Given users:
      | name           | password | username      |
      | Kurt UserAtest | passw0rd | KurtuserAtest |
    Given I am logged in as "Kurt UserAtest"
    And I am on "/group/91/forum"
    # troubleshoot: screenshot shows user is not a member of this group. But user IS. 
    When I click "behat-new-post" 
    Then I should see "save"


  Scenario: Non-org-member cannot unpin a discussion
    #TODO reference https://gitlab.com/spacebase/spacebase/issues/132

  Scenario: Org-member can pin a discussion
    #TODO reference https://gitlab.com/spacebase/spacebase/issues/132