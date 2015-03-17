Feature: Hear a shout

  Rules:
    - Listener must be within 1000m
    - Shouts must be 140 characters or less

  Questions
    - Should a shouter hear their own message?

  Background:
    Given "Manchester Picadilly" is at "53.4773800,-2.2309100"
    And "On the Beach" is at "53.3934580,-2.1860940"
    And "Morrisons Cheadle" is at "53.4004700,-2.1916600"

  Scenario: James doesn't hear Chris' shout
    Given James is at "Manchester Picadilly"
    And Chris is at "On the Beach"
    When Chris shouts "Donuts in the breakout area"
    Then James doesn't hear Chris' shout

  Scenario: James hears Chris' shout
    Given James is at "Morrisons Cheadle"
    And Chris is at "On the Beach"
    When Chris shouts "Donuts in the breakout area"
    Then James hears Chris' shout
