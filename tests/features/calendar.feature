@api
Feature: Test calendar
  As an authenticated user, I should be able to create, read & search for events. Updating and deleting events is not allowed.
  As an org-owner, I should be able to accept/reject events.
  Anonymous user cannot update, but can read and search for all events.

# pseudo code so far
  Scenario: Site-wide calendar exists
    Given I am on "/"
    When I press the "Events" link
    Then I should see “Previous"

  Scenario: Group calendar exists
    # Bazco org = 89
    Given I am on "/group/89"
    When I press the "Events" link
    Then I should see “Previous"

  Scenario: Anonymous user cannot create a site-wide event
    Given I am on "/"
    When I press the "Events" link
    Then I should not see “Create Event"

  Scenario: Anonymous users cannot create a group event
    Given I am on "/group/89"
    When I press the "Events" link
    Then I should not see “Create Event"

  Scenario: Authenticated user can create a site-wide event
    #Given I am on "/"
    #And I am logged in as an "authenticated user"
    #When I press the "Events" link
    #Then I should see “Create Event"

  Scenario: Authenticated user can create a group event
    #Given I am on "/group/89"
    #And I am logged in as an "authenticated user"
    #When I press the "Events" link
    #Then I should see “Create Event"

