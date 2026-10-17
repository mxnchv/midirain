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
		"devicewidth": 600.0,
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
						600.0,
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
					"numoutlets": 1,
					"patching_rect": [
						460.0,
						420.0,
						300.0,
						169.0
					],
					"outlettype": [
						""
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
						20.0,
						60.0,
						18.0
					],
					"text": "densidad",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						4.0,
						52.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
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
						40.0,
						44.0,
						36.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						314.0,
						16.0,
						44.0,
						36.0
					],
					"parameter_enable": 1,
					"varname": "density",
					"showname": 0,
					"shownumber": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Densidad",
							"parameter_shortname": "Densidad",
							"parameter_type": 0,
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
						0.16
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
						0.6
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.8
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
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
						80.0,
						20.0,
						60.0,
						18.0
					],
					"text": "caída",
					"presentation": 1,
					"presentation_rect": [
						364.0,
						4.0,
						52.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						80.0,
						40.0,
						44.0,
						36.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						366.0,
						16.0,
						44.0,
						36.0
					],
					"parameter_enable": 1,
					"varname": "fall",
					"showname": 0,
					"shownumber": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Caída",
							"parameter_shortname": "Caída",
							"parameter_type": 0,
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
						0.16
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
						0.6
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.8
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						140.0,
						20.0,
						60.0,
						18.0
					],
					"text": "viento",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						58.0,
						52.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						140.0,
						40.0,
						44.0,
						36.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						314.0,
						70.0,
						44.0,
						36.0
					],
					"parameter_enable": 1,
					"varname": "wind",
					"showname": 0,
					"shownumber": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Viento",
							"parameter_shortname": "Viento",
							"parameter_type": 0,
							"parameter_mmin": -100.0,
							"parameter_mmax": 100.0,
							"parameter_initial": [
								0.0
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
						0.16
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
						0.6
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.8
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					]
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						20.0,
						60.0,
						18.0
					],
					"text": "duración",
					"presentation": 1,
					"presentation_rect": [
						364.0,
						58.0,
						56.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						40.0,
						44.0,
						36.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						366.0,
						70.0,
						44.0,
						36.0
					],
					"parameter_enable": 1,
					"varname": "dur",
					"showname": 0,
					"shownumber": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Duración",
							"parameter_shortname": "Duración",
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
						0.16
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
						0.6
					],
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.8
					],
					"panelcolor": [
						0.0,
						0.0,
						0.0,
						1.0
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
						260.0,
						20.0,
						60.0,
						18.0
					],
					"text": "modo",
					"presentation": 1,
					"presentation_rect": [
						312.0,
						114.0,
						52.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "live.tab",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						260.0,
						40.0,
						96.0,
						16.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						314.0,
						128.0,
						96.0,
						16.0
					],
					"parameter_enable": 1,
					"varname": "mode",
					"num_lines_patching": 1,
					"num_lines_presentation": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Modo",
							"parameter_shortname": "Modo",
							"parameter_type": 2,
							"parameter_enum": [
								"escala",
								"midi"
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
					"id": "obj-14",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						370.0,
						20.0,
						60.0,
						18.0
					],
					"text": "tónica",
					"presentation": 1,
					"presentation_rect": [
						426.0,
						4.0,
						50.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						370.0,
						40.0,
						46.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						428.0,
						18.0,
						46.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "tonic",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Tónica",
							"parameter_shortname": "Tónica",
							"parameter_type": 2,
							"parameter_enum": [
								"c",
								"c#",
								"d",
								"d#",
								"e",
								"f",
								"f#",
								"g",
								"g#",
								"a",
								"a#",
								"b"
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
					"id": "obj-16",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						430.0,
						20.0,
						60.0,
						18.0
					],
					"text": "escala",
					"presentation": 1,
					"presentation_rect": [
						480.0,
						4.0,
						60.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						430.0,
						40.0,
						110.0,
						15.0
					],
					"outlettype": [
						"",
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						482.0,
						18.0,
						110.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "scale",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Escala",
							"parameter_shortname": "Escala",
							"parameter_type": 2,
							"parameter_enum": [
								"mayor",
								"menor",
								"dórica",
								"frigia",
								"lidia",
								"mixolidia",
								"menor armónica",
								"pentatónica mayor",
								"pentatónica menor",
								"blues",
								"cromática"
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
					"id": "obj-18",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						20.0,
						60.0,
						18.0
					],
					"text": "grave",
					"presentation": 1,
					"presentation_rect": [
						426.0,
						40.0,
						50.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						560.0,
						40.0,
						46.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						428.0,
						54.0,
						46.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "low",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Nota grave",
							"parameter_shortname": "Nota grave",
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
					"id": "obj-20",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						620.0,
						20.0,
						60.0,
						18.0
					],
					"text": "aguda",
					"presentation": 1,
					"presentation_rect": [
						480.0,
						40.0,
						50.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						620.0,
						40.0,
						46.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						482.0,
						54.0,
						46.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "high",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Nota aguda",
							"parameter_shortname": "Nota aguda",
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
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						20.0,
						60.0,
						18.0
					],
					"text": "sync",
					"presentation": 1,
					"presentation_rect": [
						426.0,
						76.0,
						50.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 9.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.5
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						680.0,
						40.0,
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
						428.0,
						90.0,
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
								"libre",
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
					"id": "obj-24",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						740.0,
						60.0,
						60.0,
						18.0
					],
					"text": "mxnchv",
					"presentation": 1,
					"presentation_rect": [
						548.0,
						149.0,
						48.0,
						14.0
					],
					"fontname": "Space Mono",
					"fontsize": 8.0,
					"textcolor": [
						1.0,
						1.0,
						1.0,
						0.3
					],
					"textjustification": 2
				}
			},
			{
				"box": {
					"id": "obj-25",
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
					"fontname": "Space Mono",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-26",
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
					"id": "obj-27",
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
					"id": "obj-28",
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
					"id": "obj-29",
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
					"text": "prepend dur"
				}
			},
			{
				"box": {
					"id": "obj-30",
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
					"id": "obj-31",
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
					"text": "prepend tonic"
				}
			},
			{
				"box": {
					"id": "obj-32",
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
					"text": "prepend scale"
				}
			},
			{
				"box": {
					"id": "obj-33",
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
					"text": "prepend low"
				}
			},
			{
				"box": {
					"id": "obj-34",
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
					"text": "prepend high"
				}
			},
			{
				"box": {
					"id": "obj-35",
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
					"text": "prepend sync"
				}
			},
			{
				"box": {
					"id": "obj-36",
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
					"fontname": "Space Mono",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-37",
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
					"id": "obj-38",
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
					"id": "obj-39",
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
					"id": "obj-40",
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
					"fontname": "Space Mono",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-41",
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
					"id": "obj-42",
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
					"id": "obj-43",
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
					"fontname": "Space Mono",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-44",
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
					"id": "obj-45",
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
					"id": "obj-46",
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
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						20.0,
						370.0,
						420.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						""
					],
					"text": "js midirain_engine.js ---mr"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						410.0,
						280.0,
						18.0
					],
					"text": "salida: makenote siempre manda el note-off",
					"fontname": "Space Mono",
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						20.0,
						430.0,
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
					"id": "obj-50",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 2,
					"patching_rect": [
						20.0,
						470.0,
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
					"id": "obj-51",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						510.0,
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
					"id": "obj-52",
					"maxclass": "newobj",
					"numinlets": 7,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						550.0,
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
					"id": "obj-53",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						590.0,
						60.0,
						22.0
					],
					"text": "midiout"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						430.0,
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
					"id": "obj-55",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						460.0,
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
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
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
						"obj-9",
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
						"obj-11",
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
						"obj-13",
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
						"obj-15",
						0
					],
					"destination": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
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
						"obj-21",
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
						"obj-23",
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
						"obj-37",
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
						"obj-38",
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
						"obj-38",
						1
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
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
						"obj-38",
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
						"obj-38",
						1
					],
					"destination": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
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
						"obj-38",
						1
					],
					"destination": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
					],
					"destination": [
						"obj-19",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
					],
					"destination": [
						"obj-21",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						1
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
						"obj-38",
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
						"obj-41",
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
						"obj-44",
						0
					],
					"destination": [
						"obj-45",
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
						"obj-39",
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
						"obj-42",
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
						"obj-26",
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
						"obj-27",
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
						"obj-28",
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
						"obj-29",
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
						"obj-30",
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
						"obj-31",
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
						"obj-32",
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
						"obj-33",
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
						"obj-34",
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
						"obj-35",
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
						"obj-47",
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
						"obj-47",
						2
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
						"obj-47",
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
						1
					],
					"destination": [
						"obj-50",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						2
					],
					"destination": [
						"obj-50",
						2
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
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						1
					],
					"destination": [
						"obj-51",
						1
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
						"obj-52",
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
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						1
					],
					"destination": [
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						0
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
						"obj-55",
						0
					],
					"destination": [
						"obj-50",
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
