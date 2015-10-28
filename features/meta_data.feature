Feature: Meta tags are present
  As the owner of 1pixelout.net
  I want to check that all meta tags are in place
  So that it is friendly to search engines and social networks

  Background:
    Given I am on the "1pixelout.net" website

  Scenario: Google site verification meta tag
    When I visit the home page
    Then the following meta tags are set:
      | name                     | content                                     |
      | google-site-verification | 9uT0USrsuq15SPod2KGvcaLyQuHi9lJo_FXn5oNR67A |
