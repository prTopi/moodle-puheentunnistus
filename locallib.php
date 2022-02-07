<?php
// This file is part of Moodle - https://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <https://www.gnu.org/licenses/>.

/**
 * Library of functions used by the digitala module.
 *
 * @package     mod_digitala
 * @copyright   2022 Name
 * @license     https://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

function page_url($name, $page, $id, $d) {
	return new moodle_url('/mod/digitala/view.php', array('id' => $id, 'd' => $d, 'page' => $page));
}

function switch_page_button($name, $page, $id, $d, $is_curr) {
	$url = page_url($name, $page, $id, $d);
	$page_out = $page + 1;
	if ($is_curr) {
		$title = '<span class="pb-num active">'.$page_out.'</span>'.$name;
	} else {
		$title = '<span class="pb-num">'.$page_out.'</span>'.$name;
	}
	$out = html_writer::link($url, $title, array('class' => 'display-6'));
	return $out;
}

function start_progress_bar() {
	$out = html_writer::start_div('digitala-progress-bar');
	return $out;
}

function create_progress_bar_step($name, $page, $id, $d, $curr_page) {
	$classes = 'pb-step';
	$is_curr = $page == $curr_page;
	if ($is_curr) {
		$classes .= ' active';
	}
	if ($page == 0) {
		$classes .= ' first';
	}
	if ($page == 2) {
		$classes .= ' last';
	}
	
	$out = html_writer::start_div($classes);
	$out .= switch_page_button($name, $page, $id, $d, $is_curr);
	$out .= html_writer::end_div();
	return $out;
}

function calculate_spacers($page) {
	if ($page == 0) {
		return array('left' => 'right-empty', 'right' => 'nothing');
	} elseif ($page == 1) {
		return array('left' => 'left-empty', 'right' => 'right-empty');
	} else {
		return array('left' => 'nothing', 'right' => 'left-empty');
	}
}

function create_spacer($mode) {

	
	$out = html_writer::start_div('pb-spacer');
	$out .= '<svg width="100%" height="100%" viewBox="0 0 275 500" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:1.5;">';
	#vasen
	if ($mode == 'left-empty') {
		$out .= '<path d="M275,0L20,0L255,250L20,500L275,500L275,0Z" style="fill:rgb(211,211,211);"/>';
	}	
	#oikea
	if ($mode == 'right-empty') {
		$out .= '<path d="M255,250L20,0L0,0L0,500L20,500L255,250Z" style="fill:rgb(211,211,211);"/>';
	}
	$out .= '<path d="M20,20L255,250L20,480" style="fill:none;stroke:rgb(211,211,211);stroke-width:40px;"/>';
	$out .= '</svg>';
	$out .= html_writer::end_div();
	
	
	return $out;
}

function end_progress_bar() {
	$out = html_writer::end_div();
	return $out;
}