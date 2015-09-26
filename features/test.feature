Feature: Testing all the things
  As the owner of 1pixelout.net
  I want to check that the generated site is OK
  So that I am confident it is OK to deploy

  Scenario: The home page includes a browse posts link
    Given I am on the "1pixelout.net" website
    When I visit the home page
    And I click the "Browse posts" link
    Then I am on the "Archives" page

  Scenario: The home page shows a single article
    Given I am on the "1pixelout.net" website
    When I visit the home page
    Then I can see the latest article
  #
  # Scenario Outline: Site nav
  #   Given I am on the "1pixelout.net" website
  #   When I visit "<page url>"
  #
  #
  #   Examples:
  #     | page url |
