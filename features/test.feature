Feature: Testing all the things
  As the owner of 1pixelout.net
  I want to check that the generated site is OK
  So that I am confident it is OK to deploy

  Background:
    Given I am on the "1pixelout.net" website

  Scenario: The home page includes a browse posts link
    When I visit the home page
    And I click the "Browse posts" link
    Then I am on the "Archives" page

  Scenario: The home page shows the latest article
    When I visit the home page
    Then I can see a single article
    When I click the article title
    Then I am on the newest article page

  Scenario Outline: Site navigation
    When I visit "<page url>"
    Then I am presented with the following navigation links:
      | label        | url       |
      | Latest post  | /         |
      | Browse posts | /archives |
      | About        | /about    |
    And the "<active link>" navigation link is highlighted

    Examples:
      | page url  | active link  |
      | /         | Latest post  |
      | /archives | Browse posts |
      | /about    | About        |

  Scenario: Article page
    When I visit the latest article page
    Then I am presented with the following navigation links:
      | label        | url       |
      | Latest post  | /         |
      | Browse posts | /archives |
      | About        | /about    |
    And no navigation links are highlighted
