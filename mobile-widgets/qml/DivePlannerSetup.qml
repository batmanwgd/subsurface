// SPDX-License-Identifier: GPL-2.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import org.subsurfacedivelog.mobile 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.ScrollablePage {
	title: qsTr("Dive planner setup")

	property string speedUnit: (PrefUnits.length === "meters") ? qsTr("m/min") : qsTr("ft/min")
	Connections {
		target: PrefUnits
		onLengthChanged: {
			spinAscrate75.value = Planner.ascrate75
			spinAscrate50.value = Planner.ascrate50
			spinAscratestops.value = Planner.ascratestops
			spinAscratelast6m.value = Planner.ascratelast6m
			spinDescrate.value = Planner.descrate
		}
	}
	Column {
		width: parent.width
		spacing: 1
		Layout.margins: 10

		TemplateSection {
			id: rates
			title: qsTr("Rates")

			GridLayout {
				columns: 2
				rowSpacing: 10
				columnSpacing: 20
				visible: rates.isExpanded

				TemplateLabel {
					Layout.columnSpan: 2
					text: qsTr("Ascent")
					font.bold: true
				}
				TemplateLabel {
					text: qsTr("below 75% avg. depth")
				}
				TemplateSpinBox {
					id: spinAscrate75
					from: 1
					to: 99
					stepSize: 1
					value: Planner.ascrate75
					textFromValue: function (value, locale) {
						return value + speedUnit
					}
					onValueModified: {
						Planner.ascrate75 = value
					}
				}
				TemplateLabel {
					text: qsTr("75% to 50% avg. depth")
				}
				TemplateSpinBox {
					id: spinAscrate50
					from: 1
					to: 99
					stepSize: 1
					value: Planner.ascrate50
					textFromValue: function (value, locale) {
						return value + speedUnit
					}
					onValueModified: {
						Planner.ascrate50 = value
					}
				}
				TemplateLabel {
					text: qsTr("50% avg. depth to 6m")
				}
				TemplateSpinBox {
					id: spinAscratestops
					from: 1
					to: 99
					stepSize: 1
					value: Planner.ascratestops
					textFromValue: function (value, locale) {
						return value + speedUnit
					}
					onValueModified: {
						Planner.ascratestops = value
					}
				}
				TemplateLabel {
					text: qsTr("6m to surface")
				}
				TemplateSpinBox {
					id: spinAscratelast6m
					from: 1
					to: 99
					stepSize: 1
					value: Planner.ascratelast6m
					textFromValue: function (value, locale) {
						return value + speedUnit
					}
					onValueModified: {
						Planner.ascratelast6m = value
					}
				}
				TemplateLabel {
					Layout.columnSpan: 2
					text: qsTr("Descent")
					font.bold: true
				}
				TemplateLabel {
					text: qsTr("Surface to the bottom")
				}
				TemplateSpinBox {
					id: spinDescrate
					from: 1
					to: 99
					stepSize: 1
					value: Planner.descrate
					textFromValue: function (value, locale) {
						return value + speedUnit
					}
					onValueModified: {
						Planner.descrate = value
					}
				}
			}
		}
		TemplateSection {
			id: planning
			title: qsTr("Planning")

			GridLayout {
				columns: 2
				rowSpacing: 10
				columnSpacing: 20
				visible: planning.isExpanded

				// Only support "Open circuit"
				TemplateLabel {
					text: "WORK in progress"
				}

				TemplateRadioButton {
					text: qsTr("Recreational NO deco")
					Layout.columnSpan: 2
				}
				// Reserve gas is 50bar (PADI/SSI rules)
				TemplateRadioButton {
					text: qsTr("Bühlmann, GFLow/GFHigh:")
				}
				Row {
					spacing: 0

					TemplateSpinBox {
						width: planning.width / 2 -30
						from: 1
						to: 99
						stepSize: 1
						value: 15
						textFromValue: function (value, locale) {
							return value + qsTr(" %")
						}
						onValueModified: {
							console.log("got value: " + value)
						}
					}
					TemplateSpinBox {
						width: planning.width / 2 -30
						from: 1
						to: 99
						stepSize: 1
						value: 15
						textFromValue: function (value, locale) {
							return value + qsTr(" %")
						}
						onValueModified: {
							console.log("got value: " + value)
						}
					}
				}
				TemplateRadioButton {
					text: qsTr("VPM-B, Conservatism:")
				}
				TemplateSpinBox {
					from: 0
					to: 4
					stepSize: 1
					value: 2
					textFromValue: function (value, locale) {
						return qsTr("+") + value
					}
					onValueModified: {
						console.log("got value: " + value)
					}
				}
			}
		}
		TemplateSection {
			id: gasoptions
			title: qsTr("Gas options")

			GridLayout {
				columns: 2
				rowSpacing: 10
				columnSpacing: 20
				visible: gasoptions.isExpanded

				TemplateLabel {
					text: qsTr("Bottom SAC")
				}
				TemplateSpinBox {
					from: 1
					to: 99
					stepSize: 1
					value: Planner.bottomsac
					textFromValue: function (value, locale) {
						return value + qsTr("l/min")
					}
					onValueModified: {
						Planner.bottomsac = value
					}
				}
				TemplateLabel {
					text: qsTr("Deco SAC")
				}
				TemplateSpinBox {
					from: 1
					to: 99
					stepSize: 1
					value: Planner.decosac
					textFromValue: function (value, locale) {
						return value + qsTr("l/min")
					}
					onValueModified: {
						Planner.decosac = value
					}
				}
				TemplateLabel {
					text: qsTr("SAC factor")
				}
				TemplateSpinBox {
					from: 20
					to: 99
					stepSize: 1
					value: Planner.sacfactor
					textFromValue: function (value, locale) {
						return (value / 10).toFixed(1)
					}
					onValueModified: {
						Planner.sacfactor = value
					}
				}
				TemplateLabel {
					text: qsTr("Problem solving time")
				}
				TemplateSpinBox {
					from: 1
					to: 9
					stepSize: 1
					value: Planner.problemsolvingtime
					textFromValue: function (value, locale) {
						return value + qsTr("min")
					}
					onValueModified: {
						Planner.problemsolvingtime = value
					}
				}
				TemplateLabel {
					text: qsTr("Bottom pO2")
				}
				TemplateSpinBox {
					from: 0
					to: 200
					stepSize: 1
					value: Planner.bottompo2
					textFromValue: function (value, locale) {
						return (value / 100).toFixed(2) + "bar"
					}
					onValueModified: {
						Planner.bottompo2 = value
					}
				}
				TemplateLabel {
					text: qsTr("Deco pO2")
				}
				TemplateSpinBox {
					from: 0
					to: 200
					stepSize: 1
					value: Planner.decopo2
					textFromValue: function (value, locale) {
						return (value / 100).toFixed(2) + "bar"
					}
					onValueModified: {
						Planner.decopo2 = value
					}
				}
				TemplateLabel {
					text: qsTr("Best mix END")
				}
				TemplateSpinBox {
					from: 1
					to: 99
					stepSize: 1
					value: Planner.bestmixend
					textFromValue: function (value, locale) {
						return value + qsTr("m")
					}
					onValueModified: {
						Planner.bestmixend = value
					}
				}
				TemplateCheckBox {
					text: qsTr("O2 narcotic")
					checked: Planner.o2narcotic
					onClicked: {
						Planner.o2narcotic = checked
					}
				}
			}
		}
		TemplateSection {
			id: notes
			title: qsTr("Notes")

			ColumnLayout {
				visible: notes.isExpanded

				TemplateCheckBox {
					text: qsTr("Display runtime")
					checked: Planner.display_runtime
					onClicked: {
						Planner.display_runtime = checked
					}
				}
				TemplateCheckBox {
					text: qsTr("Display segment duration")
					checked: Planner.display_duration
					onClicked: {
						Planner.display_duration = checked
					}
				}
				TemplateCheckBox {
					text: qsTr("Display transitions in deco")
					checked: Planner.display_transitions
					onClicked: {
						Planner.display_transitions = checked
					}
				}
				TemplateCheckBox {
					text: qsTr("Verbatim dive plan")
					checked: Planner.verbatim_plan
					onClicked: {
						Planner.verbatim_plan = checked
					}
				}
				TemplateCheckBox {
					text: qsTr("Display plan variations")
					checked: Planner.display_variations
					onClicked: {
						Planner.display_variations = checked
					}
				}
			}
		}
	}
}
