Feature: Hear a shout

  Rules:
    - Listener must be within 1000m
    - Shouts must be 140 characters or less

  Questions
    - Should a shouter hear their own message?

  Background:
    Given the following geolocations:
      | Place                | Latitude   | Longitude  |
      | Manchester Picadilly | 53.4773800 | -2.2309100 |
      | On the Beach         | 53.3934580 | -2.1860940 |
      | Morrisons Cheadle    | 53.4004700 | -2.1916600 |

  Scenario: James is out of range
    Given James is at "Manchester Picadilly"
    And Chris is at "On the Beach"
    When Chris shouts "Donuts in the breakout area"
    Then James doesn't hear the shout

  Scenario: James is in range
    Given James is at "Morrisons Cheadle"
    And Chris is at "On the Beach"
    When Chris shouts "Donuts in the breakout area"
    Then James hears the shout

  Scenario: James' shout is too long
    Given James is at "Morrisons Cheadle"
    And Chris is at "On the Beach"
    When Chris shouts:
      """
      This shout is very long, far more than the allowed 140
      characters. The longer I make the text the harder it is to
      decide when to stop. Not yet. A little more.
      """
    Then James doesn't hear the shout
