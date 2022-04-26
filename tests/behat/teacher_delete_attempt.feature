@mod @mod_digitala @javascript
Feature: Teacher can delete attempts from overview page

  Background:
    Given the following "users" exist:
      | username | firstname | lastname   | email                    |
      | ossi     | Ossi      | Opettaja   | ossi.opettaja@koulu.fi   |
      | olli     | Olli      | Opiskelija | olli.opiskelija@koulu.fi |
      | essi     | Essi      | Opiskelija | essi.opiskelija@koulu.fi |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user | course | role    |
      | ossi | C1     | manager |
      | olli | C1     | student |
    And the following "activities" exist:
      | activity | name      | intro                | course | idnumber  | attemptlang | attempttype | assignment                 | resources                                  | resourcesformat | attemptlimit |
      | digitala | Freeform  | This is a freeform.  | C1     | freeform  | sv          | freeform    | Berätta om Tigerjakt.      | Här är filmen om tiger.                    | 1               | 0            |
      | digitala | Readaloud | This is a readaloud. | C1     | readaloud | fi          | readaloud   | Lue seuraava lause ääneen. | Tämä on liikennevalojen perusteet -kurssi. | 1               | 2            |
    And I add freeform attempt to database:
      | name     | username | attemptnumber | file  | transcript  | fluency | taskcompletion | pronunciation | lexicogrammatical | holistic | recordinglength | status    |
      | Freeform | olli     | 1             | file1 | transcript1 | 1       | 1              | 2             | 3                 | 1        | 1               | evaluated |
      | Freeform | essi     | 1             | file2 | transcript2 | 1       | 1              | 2             | 3                 | 1        | 1               | evaluated |
    And I add readaloud attempt to database:
      | name      | username | attemptnumber | file  | transcript  | feedback | fluency | pronunciation | recordinglength | status    |
      | Readaloud | olli     | 1             | file3 | transcript3 | feedback | 0.7     | 1.5           | 2               | evaluated |
      | Readaloud | essi     | 1             | file4 | transcript4 | feedback | 3.4     | 2.4           | 3               | evaluated |

  Scenario: Delete buttons show for teacher
    When I am on the "Freeform" "mod_digitala > Teacher Reports Overview" page logged in as "ossi"
    Then I should see "Delete all"
    And I should see "Delete attempt"

  Scenario: Student should not see delete buttons
    When I am on the "Freeform" "mod_digitala > Teacher Reports Overview" page logged in as "olli"
    Then I should not see "Delete all"
    And I should not see "Delete attempt"

  Scenario: Teacher can delete all attempts
    When I am on the "Freeform" "mod_digitala > Teacher Reports Overview" page logged in as "ossi"
    Then I should see "Olli Opiskelija"
    And I should see "Essi Opiskelija"
    And I click on "Delete all" "button"
    Then I should see "Warning"
    And I click on "Confirm delete" "link"
    Then I should not see "Olli Opiskelija"
    And I should not see "Essi Opiskelija"
    And I should see "No results to show yet."

  Scenario: Teacher can delete one attempt
    When I am on the "Freeform" "mod_digitala > Teacher Reports Overview" page logged in as "ossi"
    Then I should see "Olli Opiskelija"
    And I should see "Essi Opiskelija"
    And I click on "deleteButtonessi" "button"
    Then I should see "Warning"
    And I click on "deleteRedirectButtonessi" "link"
    Then I should see "Olli Opiskelija"
    And I should not see "Essi Opiskelija"
