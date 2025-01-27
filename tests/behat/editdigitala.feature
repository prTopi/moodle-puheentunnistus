@mod @mod_digitala @javascript
Feature: Edit digitala activity

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                  |
      | mauno    | Mauno     | Manager  | mauno.manager@koulu.fi |
      | ossi     | Ossi      | Opettaja | ossi.opettaja@koulu.fi |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user  | course | role           |
      | mauno | C1     | manager        |
      | ossi  | C1     | editingteacher |
    And the following "activities" exist:
      | activity | name               | intro               | course | idnumber  | attemptlang | attempttype | assignment      | resources     | assignmentformat | resourcesformat | attemptlimit | information     | informationformat |
      | digitala | Test digitala name | Test digitala intro | C1     | digitala1 | fi          | freeform    | Assignment text | Resource text | 1                | 1               | 0            | testinformation | 1                 |
    And I log in as "ossi"

  Scenario Outline: Edit a task on course page
    When I am on the "C1" "Course" page logged in as "<user>"
    And I turn editing mode on
    Then I open "Test digitala name" actions menu
    Then I choose "Edit settings" in the open action menu
    And I wait until the page is ready
    Then I set the following fields to these values:
      | Assignment name  | <name>            |
      | Language         | <attemptlang>     |
      | Assignment type  | <attempttype>     |
      | Assignment text  | <assignmenttext>  |
      | Material         | <resourcestext>   |
      | More information | <informationtext> |
    And I press "Save and display"
    Then I am on the "<name>" "digitala activity" page
    And I click on "Next" "link"
    Then I should see "Assignment"
    And I should see "<assignmenttext>"
    And I should see "Material"
    And I should see "<resourcestext>"

    Examples:
      | name          | attemptlang | attempttype | assignmenttext                   | resourcestext                                                          | informationtext  | user  |
      | SWE Readaloud | Swedish     | Read-aloud  | Läs följande avsnitt högt.       | Hejsan, jag heter Jonne-Peter.                                         | some information | ossi  |
      | FIN Readaloud | Finnish     | Read-aloud  | Lue seuraava lause ääneen.       | Tämä on liikennevalojen perusteet -kurssi.                             | some information | ossi  |
      | SWE Freeform  | Swedish     | Freeform    | Berätta om Tigerjakt.            | Här är filmen om tiger.                                                | some information | ossi  |
      | FIN Freeform  | Finnish     | Freeform    | Pidä oppitunti liikennevaloista. | Liikennevaloissa kolme valoa ja ne ovat punainen, keltainen ja vihreä. | some information | ossi  |
      | FIN Freeform  | Finnish     | Freeform    | Pidä oppitunti liikennevaloista. | Liikennevaloissa kolme valoa ja ne ovat punainen, keltainen ja vihreä. | some information | mauno |
