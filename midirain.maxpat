{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 6,
			"revision": 5,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			80.0,
			100.0,
			840.0,
			660.0
		],
		"bglocked": 0,
		"openinpresentation": 1,
		"default_fontsize": 10.0,
		"default_fontface": 0,
		"default_fontname": "Arial Bold",
		"gridonopen": 1,
		"gridsize": [
			8.0,
			8.0
		],
		"gridsnaponopen": 1,
		"objectsnaponopen": 1,
		"statusbarvisible": 2,
		"toolbarvisible": 1,
		"lefttoolbarpinned": 0,
		"toptoolbarpinned": 0,
		"righttoolbarpinned": 0,
		"bottomtoolbarpinned": 0,
		"toolbars_unpinned_last_save": 0,
		"tallnewobj": 0,
		"boxanimatetime": 500,
		"enablehscroll": 1,
		"enablevscroll": 1,
		"devicewidth": 610.0,
		"description": "lluvia de gotas que dispara notas MIDI",
		"digest": "",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"amxdtype": 1835887981,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						700.0,
						10.0,
						60.0,
						30.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						0.0,
						610.0,
						169.0
					],
					"background": 1,
					"bgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"border": 0,
					"rounded": 0,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						770.0,
						10.0,
						10.0,
						30.0
					],
					"presentation": 1,
					"presentation_rect": [
						302.0,
						0.0,
						1.0,
						169.0
					],
					"background": 1,
					"bgcolor": [
						0.11,
						0.11,
						0.11,
						1.0
					],
					"border": 0,
					"rounded": 0,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "jsui",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						460.0,
						480.0,
						300.0,
						169.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						0.0,
						300.0,
						169.0
					],
					"filename": "midirain_ui.js",
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						10.0,
						60.0,
						18.0
					],
					"text": "Density",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						13.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						20.0,
						30.0,
						40.0,
						40.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						322.0,
						29.0,
						40.0,
						40.0
					],
					"parameter_enable": 1,
					"varname": "density",
					"showname": 0,
					"shownumber": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Density",
							"parameter_shortname": "Density",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 100.0,
							"parameter_initial": [
								30.0
							],
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1
						}
					},
					"activedialcolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"dialcolor": [
						1.0,
						1.0,
						1.0,
						0.28
					],
					"activeneedlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"needlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						74.0,
						60.0,
						18.0
					],
					"text": "30 %",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						55.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.92
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						84.0,
						10.0,
						60.0,
						18.0
					],
					"text": "Fall",
					"presentation": 1,
					"presentation_rect": [
						378.0,
						13.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						84.0,
						30.0,
						40.0,
						40.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						388.0,
						29.0,
						40.0,
						40.0
					],
					"parameter_enable": 1,
					"varname": "fall",
					"showname": 0,
					"shownumber": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Fall",
							"parameter_shortname": "Fall",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 100.0,
							"parameter_initial": [
								40.0
							],
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1
						}
					},
					"activedialcolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"dialcolor": [
						1.0,
						1.0,
						1.0,
						0.28
					],
					"activeneedlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"needlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						84.0,
						74.0,
						60.0,
						18.0
					],
					"text": "40 %",
					"presentation": 1,
					"presentation_rect": [
						378.0,
						55.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.92
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						148.0,
						10.0,
						60.0,
						18.0
					],
					"text": "Wind",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						89.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						148.0,
						30.0,
						40.0,
						40.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						322.0,
						105.0,
						40.0,
						40.0
					],
					"parameter_enable": 1,
					"varname": "wind",
					"showname": 0,
					"shownumber": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Wind",
							"parameter_shortname": "Wind",
							"parameter_type": 1,
							"parameter_mmin": -100.0,
							"parameter_mmax": 100.0,
							"parameter_initial": [
								10.0
							],
							"parameter_unitstyle": 0,
							"parameter_initial_enable": 1
						}
					},
					"activedialcolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"dialcolor": [
						1.0,
						1.0,
						1.0,
						0.28
					],
					"activeneedlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"needlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						148.0,
						74.0,
						60.0,
						18.0
					],
					"text": "10",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						131.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.92
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						212.0,
						10.0,
						60.0,
						18.0
					],
					"text": "Distance",
					"presentation": 1,
					"presentation_rect": [
						378.0,
						89.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						212.0,
						30.0,
						40.0,
						40.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						388.0,
						105.0,
						40.0,
						40.0
					],
					"parameter_enable": 1,
					"varname": "distance",
					"showname": 0,
					"shownumber": 0,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Distance",
							"parameter_shortname": "Distance",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 100.0,
							"parameter_initial": [
								50.0
							],
							"parameter_unitstyle": 5,
							"parameter_initial_enable": 1
						}
					},
					"activedialcolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"dialcolor": [
						1.0,
						1.0,
						1.0,
						0.28
					],
					"activeneedlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"needlecolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						212.0,
						74.0,
						60.0,
						18.0
					],
					"text": "50 %",
					"presentation": 1,
					"presentation_rect": [
						378.0,
						131.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.92
					],
					"textjustification": 1,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						790.0,
						10.0,
						10.0,
						30.0
					],
					"presentation": 1,
					"presentation_rect": [
						448.0,
						14.0,
						1.0,
						136.0
					],
					"background": 1,
					"bgcolor": [
						1.0,
						1.0,
						1.0,
						0.12
					],
					"border": 0,
					"rounded": 0,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						700.0,
						144.0,
						60.0,
						18.0
					],
					"text": "Mode",
					"presentation": 1,
					"presentation_rect": [
						456.0,
						8.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "live.tab",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						260.0,
						30.0,
						134.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						460.0,
						25.0,
						134.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "mode",
					"num_lines_patching": 1,
					"num_lines_presentation": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Mode",
							"parameter_shortname": "Mode",
							"parameter_type": 2,
							"parameter_enum": [
								"Scale",
								"Held"
							],
							"parameter_mmax": 1.0,
							"parameter_initial": [
								0.0
							],
							"parameter_initial_enable": 1
						}
					},
					"bgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"bgoncolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"activebgoncolor": [
						1.0,
						1.0,
						1.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.6
					],
					"textoncolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						770.0,
						144.0,
						60.0,
						18.0
					],
					"text": "Length",
					"presentation": 1,
					"presentation_rect": [
						456.0,
						44.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						620.0,
						60.0,
						64.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						460.0,
						61.0,
						64.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "dur",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Length",
							"parameter_shortname": "Length",
							"parameter_type": 0,
							"parameter_mmin": 10.0,
							"parameter_mmax": 2000.0,
							"parameter_initial": [
								150.0
							],
							"parameter_unitstyle": 2,
							"parameter_exponent": 3.0,
							"parameter_initial_enable": 1
						}
					},
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"activeslidercolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						840.0,
						144.0,
						60.0,
						18.0
					],
					"text": "Sync",
					"presentation": 1,
					"presentation_rect": [
						526.0,
						44.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						340.0,
						30.0,
						64.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						530.0,
						61.0,
						64.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "sync",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Sync",
							"parameter_shortname": "Sync",
							"parameter_type": 2,
							"parameter_enum": [
								"Free",
								"1/32",
								"1/16",
								"1/8",
								"1/4"
							],
							"parameter_mmax": 4.0,
							"parameter_initial": [
								0.0
							],
							"parameter_initial_enable": 1
						}
					},
					"bgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						910.0,
						144.0,
						60.0,
						18.0
					],
					"text": "Root",
					"presentation": 1,
					"presentation_rect": [
						456.0,
						80.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						420.0,
						30.0,
						40.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						460.0,
						97.0,
						40.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "tonic",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Root",
							"parameter_shortname": "Root",
							"parameter_type": 2,
							"parameter_enum": [
								"C",
								"C#",
								"D",
								"D#",
								"E",
								"F",
								"F#",
								"G",
								"G#",
								"A",
								"A#",
								"B"
							],
							"parameter_mmax": 11.0,
							"parameter_initial": [
								0.0
							],
							"parameter_initial_enable": 1
						}
					},
					"bgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						700.0,
						168.0,
						60.0,
						18.0
					],
					"text": "Scale",
					"presentation": 1,
					"presentation_rect": [
						502.0,
						80.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						480.0,
						30.0,
						88.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						506.0,
						97.0,
						88.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "scale",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Scale",
							"parameter_shortname": "Scale",
							"parameter_type": 2,
							"parameter_enum": [
								"Major",
								"Minor",
								"Dorian",
								"Phrygian",
								"Lydian",
								"Mixolydian",
								"Harmonic Minor",
								"Major Pentatonic",
								"Minor Pentatonic",
								"Blues",
								"Chromatic"
							],
							"parameter_mmax": 10.0,
							"parameter_initial": [
								1.0
							],
							"parameter_initial_enable": 1
						}
					},
					"bgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						770.0,
						168.0,
						60.0,
						18.0
					],
					"text": "Low",
					"presentation": 1,
					"presentation_rect": [
						456.0,
						116.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						620.0,
						30.0,
						64.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						460.0,
						133.0,
						64.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "low",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Low",
							"parameter_shortname": "Low",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 127.0,
							"parameter_initial": [
								48.0
							],
							"parameter_unitstyle": 8,
							"parameter_initial_enable": 1
						}
					},
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"activeslidercolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						840.0,
						168.0,
						60.0,
						18.0
					],
					"text": "High",
					"presentation": 1,
					"presentation_rect": [
						526.0,
						116.0,
						60.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.55
					],
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						680.0,
						30.0,
						64.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						530.0,
						133.0,
						64.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "high",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "High",
							"parameter_shortname": "High",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 127.0,
							"parameter_initial": [
								72.0
							],
							"parameter_unitstyle": 8,
							"parameter_initial_enable": 1
						}
					},
					"activebgcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.85
					],
					"activeslidercolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"tricolor": [
						1.0,
						1.0,
						1.0,
						0.5
					],
					"bordercolor": [
						1.0,
						1.0,
						1.0,
						0.35
					],
					"focusbordercolor": [
						1.0,
						1.0,
						1.0,
						0.6
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						760.0,
						100.0,
						60.0,
						18.0
					],
					"text": "mxnchv",
					"presentation": 1,
					"presentation_rect": [
						546.0,
						152.0,
						48.0,
						14.0
					],
					"fontname": "Ableton Sans Medium",
					"fontsize": 8.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.3
					],
					"textjustification": 2,
					"ignoreclick": 1
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						100.0,
						160.0,
						18.0
					],
					"text": "parámetros -> motor",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						130.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend density"
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						112.0,
						130.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend fall"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						204.0,
						130.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend wind"
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						296.0,
						130.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend distance"
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						388.0,
						130.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend mode"
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						156.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend dur"
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						112.0,
						156.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend sync"
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						204.0,
						156.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend tonic"
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						296.0,
						156.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend scale"
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						388.0,
						156.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend low"
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						182.0,
						88.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend high"
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						200.0,
						300.0,
						18.0
					],
					"text": "al cargar: refresca parámetros y arranca el tick",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						20.0,
						220.0,
						100.0,
						22.0
					],
					"outlettype": [
						"bang",
						"int",
						"int"
					],
					"text": "live.thisdevice"
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						20.0,
						250.0,
						50.0,
						22.0
					],
					"outlettype": [
						"int",
						"bang"
					],
					"text": "t 1 b"
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						290.0,
						60.0,
						22.0
					],
					"outlettype": [
						"bang"
					],
					"text": "metro 10"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						820.0,
						230.0,
						260.0,
						18.0
					],
					"text": "Mode: atenúa los controles de escala en Held",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 3,
					"patching_rect": [
						820.0,
						250.0,
						60.0,
						22.0
					],
					"outlettype": [
						"bang",
						"bang",
						""
					],
					"text": "sel 0 1"
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						820.0,
						280.0,
						200.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "active 1, textcolor 1. 1. 1. 0.85"
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						820.0,
						310.0,
						200.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "active 0, textcolor 1. 1. 1. 0.26"
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1030.0,
						280.0,
						140.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "textcolor 1. 1. 1. 0.55"
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1030.0,
						310.0,
						140.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "textcolor 1. 1. 1. 0.17"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						260.0,
						280.0,
						18.0
					],
					"text": "rejilla del transporte (el motor la configura)",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						290.0,
						150.0,
						22.0
					],
					"outlettype": [
						"bang"
					],
					"text": "metro 16n @quantize 16n"
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						380.0,
						260.0,
						120.0,
						18.0
					],
					"text": "transporte de Live",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						380.0,
						290.0,
						80.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "path live_set"
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						380.0,
						320.0,
						70.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						""
					],
					"text": "live.path"
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						380.0,
						350.0,
						190.0,
						22.0
					],
					"outlettype": [
						"",
						""
					],
					"text": "live.observer @property is_playing"
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						580.0,
						350.0,
						170.0,
						22.0
					],
					"outlettype": [
						"",
						""
					],
					"text": "live.observer @property tempo"
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						380.0,
						380.0,
						100.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend playing"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						580.0,
						380.0,
						90.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend tempo"
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						320.0,
						40.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "grid"
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						500.0,
						200.0,
						280.0,
						18.0
					],
					"text": "entrada MIDI: solo notas, no pasan a la salida",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						500.0,
						220.0,
						50.0,
						22.0
					],
					"outlettype": [
						"int"
					],
					"text": "midiin"
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 8,
					"patching_rect": [
						500.0,
						250.0,
						100.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						"int",
						"int",
						"",
						"int",
						""
					],
					"text": "midiparse"
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						500.0,
						280.0,
						80.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend note"
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"patching_rect": [
						20.0,
						420.0,
						420.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"text": "js midirain_engine.js ---mr"
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 5,
					"patching_rect": [
						460.0,
						450.0,
						200.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						"",
						""
					],
					"text": "route density fall wind distance"
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						460.0,
						480.0,
						76.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						540.0,
						480.0,
						76.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						620.0,
						480.0,
						76.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						700.0,
						480.0,
						76.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						470.0,
						280.0,
						18.0
					],
					"text": "salida: makenote siempre manda el note-off",
					"fontname": "Ableton Sans Medium",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						20.0,
						490.0,
						120.0,
						22.0
					],
					"outlettype": [
						"int",
						"int",
						"int"
					],
					"text": "unpack 0 0 0"
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 2,
					"patching_rect": [
						20.0,
						530.0,
						120.0,
						22.0
					],
					"outlettype": [
						"float",
						"float"
					],
					"text": "makenote 100 150"
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						570.0,
						80.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack 0 0"
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "newobj",
					"numinlets": 7,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						610.0,
						100.0,
						22.0
					],
					"outlettype": [
						"int"
					],
					"text": "midiformat"
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						650.0,
						60.0,
						22.0
					],
					"text": "midiout"
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						490.0,
						50.0,
						22.0
					],
					"outlettype": [
						"bang",
						""
					],
					"text": "sel 0"
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						520.0,
						40.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "stop"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-5",
						0
					],
					"destination": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
						0
					],
					"destination": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-14",
						0
					],
					"destination": [
						"obj-36",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-18",
						0
					],
					"destination": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						0
					],
					"destination": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						0
					],
					"destination": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-26",
						0
					],
					"destination": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-28",
						0
					],
					"destination": [
						"obj-42",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-30",
						0
					],
					"destination": [
						"obj-43",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-5",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-22",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						0
					],
					"destination": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-18",
						0
					],
					"destination": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-50",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-52",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						1
					],
					"destination": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						1
					],
					"destination": [
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-57",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-57",
						0
					],
					"destination": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-58",
						0
					],
					"destination": [
						"obj-59",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-58",
						0
					],
					"destination": [
						"obj-60",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						0
					],
					"destination": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-62",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-55",
						0
					],
					"destination": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-65",
						0
					],
					"destination": [
						"obj-66",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						0
					],
					"destination": [
						"obj-67",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-63",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-67",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-61",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-35",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-39",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						1
					],
					"destination": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						0
					],
					"destination": [
						"obj-70",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						0
					],
					"destination": [
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						1
					],
					"destination": [
						"obj-71",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-71",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						2
					],
					"destination": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						0
					],
					"destination": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						3
					],
					"destination": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						3
					],
					"destination": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						2
					],
					"destination": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						0
					],
					"destination": [
						"obj-75",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						0
					],
					"destination": [
						"obj-76",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						1
					],
					"destination": [
						"obj-76",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						2
					],
					"destination": [
						"obj-76",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-76",
						0
					],
					"destination": [
						"obj-77",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-76",
						1
					],
					"destination": [
						"obj-77",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-78",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-78",
						0
					],
					"destination": [
						"obj-79",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						1
					],
					"destination": [
						"obj-80",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-80",
						0
					],
					"destination": [
						"obj-81",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-76",
						0
					]
				}
			}
		],
		"dependency_cache": [
			{
				"name": "midirain_engine.js",
				"bootpath": ".",
				"patcherrelativepath": ".",
				"type": "TEXT",
				"implicit": 1
			},
			{
				"name": "midirain_ui.js",
				"bootpath": ".",
				"patcherrelativepath": ".",
				"type": "TEXT",
				"implicit": 1
			}
		],
		"latency": 0,
		"is_mpe": 0,
		"minimum_live_version": "",
		"minimum_max_version": "",
		"platform_compatibility": 0,
		"autosave": 0
	}
}
