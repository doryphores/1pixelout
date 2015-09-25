Feature: Testing all the things
  As the owner of 1pixelout.net
  I want to check that the generated site is OK
  So that I am confident it is OK to deploy

  Scenario: Visiting the home page
    Given I am on the "1pixelout.net" website
    When I visit the home page
    Then I can see a "Browse posts" link
