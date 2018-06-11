@api
Feature: Test discussions
  As an org-member, I should be able to create and read posts in my group's discussion.
  As an org-owner, I should be able to create, read, update and delete posts in my group's discussion.
  Anonymous users can see discussions but not edit.

  # initially, these tests presume the example discussion already exists

  Scenario: Group discussion exists
    Given users:
      | name           | password     | username                             |
      | Kurt UserAtest  | passw0rd | KurtuserAtest |
    Given I am logged in as "Kurt UserAtest"
    And I am on "/group/91/forum"
    And I wait until the page loads
    # the following fails and not sure why
    Then I should see "Welcome to your organization's discussion forum"


  Scenario: Anonymous user cannot edit
    Given I am an anonymous user
    #TestOrgA Forum
    And I am on "/group/91/forum"
    And I see the text "My Test Discussion "
    #TODO need to identify the following link by any of these: id|name|title|alt|value
    Then I should not see the link "/node/47/edit"


  Scenario: Org-member user can edit
    # this user should already exists in the environment
    Given users:
      | name           | password     | username                             |
      | Kurt UserAtest  | passw0rd | KurtuserAtest |
    Given I am logged in as "Kurt UserAtest"
    #TestOrgA Forum
    And I am on "/group/91/forum"
    And I see the text "My Test Discussion "
    #TODO need to identify the following link by any of these: id|name|title|alt|value
    Then I should see the link "/node/47/edit"


  Scenario: Create a new post
    Given I am on "/group/91/forum"
    And I am logged in as an "authenticated user"
    When I press the "New post" button
    Then I should see “save"


  Scenario: Non-org-member cannot unpin a discussion
    #TODO reference https://gitlab.com/spacebase/spacebase/issues/132

  Scenario: Org-member can pin a discussion
    #TODO reference https://gitlab.com/spacebase/spacebase/issues/132