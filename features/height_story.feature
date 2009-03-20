Feature: Triangle height calculation
  In order to calculate the volume
  Developers should be able to calculate the height of a triangular

  Scenario: Point
    Given 0 dimentional space
    When triangle with side 0
    Then it's height should be 0
    Then it's volume should be 0

  Scenario: Line
    Given 1 dimentional space
    When triangle with side 5
    Then it's height should be 5
    Then it's volume should be 5

  Scenario: Surface
    Given 2 dimentional space
    When triangle with side 1
    Then it's height should eq sqrt(3)/2
    Then it's calc_height should be 0.866
    Then it's volume should eq sqrt(3)/4
    Then height forms a right triangle: 0.75 + 0.25 == 1

    When triangle with side 2
    Then it's height should eq sqrt(3)
    Then it's calc_height should be 1.732
    Then it's volume should eq sqrt(3)
    Then height forms a right triangle: 3 + 1 == 4

    When triangle with side 0.5
    Then it's height should eq sqrt(3)/4
    Then it's calc_height should be 0.433
    Then it's volume should eq sqrt(3)/16
    Then height forms a right triangle: 0.1875 + 0.0625 == 0.25
    
