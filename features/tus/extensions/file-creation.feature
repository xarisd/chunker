Feature: Create a file
As an API client
In order to be able to upload a file
I can create a file

  Scenario: Create a file - normal
    Given I send and accept JSON
    When I send a POST request to "/files" with headers:
      | Entity-Length | 100 |
    Then the response status should be "201"
    And the response should contain header "Location"

  Scenario: Create a file - normal - ZERO 'Entity-Length'
    Given I send and accept JSON
    When I send a POST request to "/files" with headers:
      | Entity-Length | 0 |
    Then the response status should be "201"
    And the response should contain header "Location"

  Scenario: Create a file - NO 'Entity-Length' - 'application/json'
    Given I send and accept JSON
    When I send a POST request to "/files"
    Then the response status should be "400"
    And the JSON response should be:
    """
    { "error" : "'Entity-Length' header must be sent" }
    """
  Scenario: Create a file - NO 'Entity-Length' - 'Accept: text/html'
    Given I send and accept HTML
    When I send a POST request to "/files"
    Then the response status should be "400"
    And the response should be:
    """
    'Entity-Length' header must be sent
    """

  Scenario: Create a file - NEGATIVE 'Entity-Length' - 'application/json'
    Given I send and accept JSON
    When I send a POST request to "/files" with headers:
      | Entity-Length | -100 |
    Then the response status should be "400"
    And the JSON response should be:
    """
    { "error" : "'Entity-Length' header value MUST be a non-negative INTEGER" }
    """
  Scenario: Create a file - NEGATIVE 'Entity-Length' - 'Accept: text/html'
    Given I send and accept HTML
    When I send a POST request to "/files" with headers:
      | Entity-Length | -100 |
    Then the response status should be "400"
    And the response should be:
    """
    'Entity-Length' header value MUST be a non-negative INTEGER
    """

  Scenario: Create a file - NOT A NUMBER 'Entity-Length' - 'application/json'
    Given I send and accept JSON
    When I send a POST request to "/files" with headers:
      | Entity-Length | foo |
    Then the response status should be "400"
    And the JSON response should be:
    """
    { "error" : "'Entity-Length' header value MUST be a non-negative INTEGER" }
    """
  Scenario: Create a file - NOT A NUMBER 'Entity-Length' - 'Accept: text/html'
    Given I send and accept HTML
    When I send a POST request to "/files" with headers:
      | Entity-Length | foo |
    Then the response status should be "400"
    And the response should be:
    """
    'Entity-Length' header value MUST be a non-negative INTEGER
    """
