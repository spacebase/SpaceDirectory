@api
Feature: Test organizations
  As a user with an account, I want to be able to create an organization and add resources.

  Scenario: Create organization
    Given I am logged in as a user with the "Authenticated user" role
    And I am on "group/add/organization_group"
    When I fill in the following:
      | label[0][value] | Acme Org3 |
      | edit-field-description-0-value | Description of Acme Org.3 |
      | field_industry_segment[] | 34 |

      #TODO: troubleshoot why we can't select country
      #| field_headquarters_location[0][address][country_code] | NZ |
      #wait for the address fields to load after selecting country
      #And I wait for 3 seconds
      #TODO troubleshoot getting JS is not supported by Behat\Mink\Driver\GoutteDriver

    #And I fill in the following:
    #  | field_home_location_user[0][address][address_line1] | 90 Cable St |
    #  | field_home_location_user[0][address][address_line2] | Te Aro |
    #  | field_home_location_user[0][address][locality] | Wellington |

    And I press the "edit-submit" button
    And I wait until the page loads
    #TODO not seeing the following field. Is the form fully loaded yet?
    And I fill in "edit-field-organization-role-0-value" with "Grand Poobah"
    And I press the "edit-submit" button
    Then I should see "has been created"


  Scenario: Add resource to organization
    Given users:
      | name           | password | username      |
      | Kurt UserAtest | passw0rd | KurtuserAtest |
    # logged in as a user with permission for the organization using the URL below
    Given I am logged in as "Kurt UserAtest"

    # can't use the following because the button isn't identifiable by any of these: id|name|title|alt|value
    # And I am on "/group/95/resources#Communication"
    # When I press the "btn btn-primary btn-small pull-right" button

    # Instead, going straight to the add resource page...
    And I am on "group/91/content/create/group_node%3Aresources?destination=/group/91/resources"

    #TODO Troubleshoot filling in this form, and clicking "90"
    When I fill in the following:
      | edit-field-resource-link-0-uri | http://mylink.org         |
      | edit-title-0-value             | My Communication resource |

    # "90" is the Communication radio button
    #TODO Troubleshoot clicking the comm radio button
    And I click "edit-field-tab-90"
    And I press the "edit-submit" button
    Then I should see "has been created"

