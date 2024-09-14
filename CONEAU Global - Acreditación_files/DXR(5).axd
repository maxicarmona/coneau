/* -- ValidationSummary -- */

.dxvsValidationSummary_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Red;
}
.dxvsValidationSummary_Glass td.dxvsRC_Glass
{
	vertical-align: top;
	padding: 2px 5px 4px 6px;
}
.dxvsValidationSummary_Glass .dxvsE_Glass
{
}
.dxvsValidationSummary_Glass table.dxvsHT_Glass
{
	width: 100%;
}
.dxvsValidationSummary_Glass td.dxvsH_Glass
{
	padding: 2px 0;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass,
.dxvsValidationSummary_Glass a.dxvsHL_Glass:visited
{
	color: red;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass
{
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass:hover
{
	color: #f70;
}
.dxvsValidationSummary_Glass table.dxvsT_Glass
{
}
.dxvsValidationSummary_Glass tr.dxvsE_Glass
{
}
.dxvsValidationSummary_Glass td.dxvsETC_Glass
{
	padding: 2px 0;
}
.dxvsValidationSummary_Glass ul.dxvsL_Glass
{
}
.dxvsValidationSummary_Glass ol.dxvsL_Glass
{
}
.dxvsValidationSummary_Glass li.dxvsE_Glass
{
	padding: 2px 0;
}

/* TrackBar */
.dxeTrackBar_Glass
{
	user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	visibility:hidden;
}

.dxeDisabled_Glass .dxeTBHSys a,
.dxeDisabled_Glass .dxeTBVSys a
{
    cursor: default;
}

.dxeTBBarHighlight_Glass
{
	font-size: 0;
}

.dxeTBScale_Glass,
.dxeTBTrack_Glass,
.dxeTBBarHighlight_Glass
{
	cursor: pointer;
}

.dxeTBScale_Glass
{
	z-index: 1;
}
.dxeTBSecondaryDH_Glass,
.dxeTBMainDH_Glass
{
	z-index: 4;
}

.dxeTBHSys
{
	width: 170px;
	height: 49px;
}
.dxeTBVSys
{
	height: 170px;
	width: 49px;
}
.dxeTrackBar_Glass.dxeTBBScaleSys.dxeTBVSys
{
	width: 70px;
}
.dxeTrackBar_Glass.dxeTBBScaleSys.dxeTBHSys
{	
	height: 70px;
}

.dxeTBTrack_Glass
{
	z-index: 2;
	position: absolute;
}

.dxeTBTrack_Glass, .dxeTBBarHighlight_Glass 
{
	border-style: solid;
	border-color: #A3C0E8;
}

.dxeTBHSys .dxeTBTrack_Glass, .dxeTBHSys .dxeTBBarHighlight_Glass 
{
	border-width: 0px 1px 0px 1px;
}
.dxeTBVSys .dxeTBTrack_Glass, .dxeTBVSys .dxeTBBarHighlight_Glass 
{
	border-width: 1px 0px 1px 0px;
}

.dxeTBHSys .dxeTBTrack_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_909-qnIN9');
}
.dxeTBVSys .dxeTBTrack_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_910-qnIN9');
}

.dxeTBHSys .dxeTBTrack_Glass, 
.dxeTBHSys .dxeTBBarHighlight_Glass
{
	height: 4px;
}
.dxeTBVSys .dxeTBTrack_Glass, 
.dxeTBVSys .dxeTBBarHighlight_Glass
{
	width: 4px;
}

.dxeTBHSys .dxeTBMainDH_Glass,
.dxeTBHSys .dxeTBSecondaryDH_Glass
{	
	top: -11px;
	width: 13px;
	height: 26px;
}
.dxeTBVSys .dxeTBMainDH_Glass,
.dxeTBVSys .dxeTBSecondaryDH_Glass
{
	left: -11px;
	width: 26px;
	height: 13px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBTrack_Glass,
.dxeTBVSys .dxeTBTrack_Glass
{
	left: 13px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBTrack_Glass
{
	right: 13px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBTrack_Glass
{
	bottom: 13px;
	top: auto;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBTrack_Glass,
.dxeTBHSys .dxeTBTrack_Glass
{
	top: 13px;
}

.dxeTBBarHighlight_Glass
{
	left: 0px;
	top: 0px;
	position:absolute;
	z-index: 3;
}

.dxeTBHSys .dxeTBBarHighlight_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_899-qnIN9');
}
.dxeTBVSys .dxeTBBarHighlight_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_900-qnIN9');
}

.dxeTBRBLabel_Glass,
.dxeTBLTLabel_Glass
{
	font-size: 11px Tahoma, Geneva, sans-serif;
	text-align: center;
	cursor: default;
}
.dxeTBSmallTickSys .dxeTBRBLabel_Glass,
.dxeTBSmallTickSys .dxeTBLTLabel_Glass,
.dxeTBLargeTickSys .dxeTBRBLabel_Glass,
.dxeTBLargeTickSys .dxeTBLTLabel_Glass
{	
	position: absolute;
}

.dxeTBHSys .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBLTLabel_Glass
{
	width: 100%;
}

.dxeTBIncBtn_Glass,
.dxeTBDecBtn_Glass
{
	padding: 2px;
	width: 16px;
	height: 16px;
}

.dxeTBVSys .dxeTBRBLabel_Glass,
.dxeTBVSys .dxeTBLTLabel_Glass
{
	padding-top: 2px;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	margin-left: -4px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBRBLabel_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBLTLabel_Glass
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLTLabel_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBLTLabel_Glass
{
	bottom: 0px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLTLabel_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	top: 0px;
}

.dxeTBHSys .dxeTBItem_Glass .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBItem_Glass .dxeTBLTLabel_Glass
{
	display: inline-block;
	margin-left: 0px!important;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBItem_Glass .dxeTBRBLabel_Glass
{
	padding-top: 12px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBItem_Glass .dxeTBLTLabel_Glass
{
	margin-top: 8px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_Glass .dxeTBRBLabel_Glass 
{
	margin-left: 5px;
}

.dxeTBSelectedItem_Glass .dxeTBRBLabel_Glass,
.dxeTBSelectedItem_Glass .dxeTBLTLabel_Glass,
.dxeTBSelectedTick_Glass .dxeTBRBLabel_Glass,
.dxeTBSelectedTick_Glass .dxeTBLTLabel_Glass
{
	color: #2A769D;
}
.dxeDisabled_Glass .dxeTBSelectedItem_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedItem_Glass .dxeTBLTLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedTick_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedTick_Glass .dxeTBLTLabel_Glass 
{
	color: #E4E4E4;
}

.dxeTBRBLabel_Glass,
.dxeTBLTLabel_Glass,
.dxeTBItem_Glass
{
	color: #93C3D3;
}

.dxeDisabled_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBLTLabel_Glass,
.dxeDisabled_Glass .dxeTBItem_Glass
{
	color: #E4E4E4;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBItem_Glass
{
	text-align: left;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_Glass
{
	text-align: right;
}

.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	text-align: center;
}

.dxeTBHSys .dxeTBItem_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_905-qnIN9');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_903-qnIN9');
}
.dxeTBVSys .dxeTBItem_Glass 
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_906-qnIN9');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_904-qnIN9');
}

.dxeTBHSys .dxeTBLargeTick_Glass
{
	background-image:  url('/coneauglobal/DXR.axd?r=0_905-qnIN9');
}
.dxeTBVSys .dxeTBLargeTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_906-qnIN9');
}
.dxeTBHSys .dxeTBSmallTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_907-qnIN9');
}
.dxeTBVSys .dxeTBSmallTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_908-qnIN9');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBLargeTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_901-qnIN9');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBLargeTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_902-qnIN9');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBSmallTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_903-qnIN9');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBSmallTick_Glass
{
	background-image: url('/coneauglobal/DXR.axd?r=0_904-qnIN9');
}

.dxeTBVSys .dxeTBIncBtn_Glass,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBDecBtn_Glass
{
	bottom: 0px;
	top: auto;
}
.dxeTBVSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBIncBtn_Glass
{
	top: 0px;
	bottom: auto;
}
.dxeTBHSys .dxeTBDecBtn_Glass, 
.dxeTBHSys .dxeReversedDirectionSys .dxeTBIncBtn_Glass
{
	left: 0px;
	right: auto;
}
.dxeTBHSys .dxeTBIncBtn_Glass,
.dxeTBHSys .dxeReversedDirectionSys .dxeTBDecBtn_Glass
{
	right: 0px;
	left: auto;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBIncBtn_Glass
{
	margin-left: -10px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBIncBtn_Glass
{
	margin-top: -10px;
	top: 50%;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBTrack_Glass
{ 
	margin-left: -2px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBTrack_Glass
{ 
	margin-top: -2px;
	top: 50%;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBLTScaleSys .dxeTBIncBtn_Glass
{
	right: 5px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBLTScaleSys .dxeTBIncBtn_Glass
{
	bottom: 5px;
	top: auto;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBRBScaleSys .dxeTBIncBtn_Glass,
.dxeTBVSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBIncBtn_Glass
{
	left: 5px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBRBScaleSys .dxeTBIncBtn_Glass,
.dxeTBHSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBIncBtn_Glass
{
	top: 5px;
}

div.dxeHelpText_Glass,
.dxeTBValueToolTip_Glass
{
	padding: 3px 8px 4px 8px;
    display: inline;
    position:absolute;
    border-radius: 3px;
    z-index: 41998;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -o-border-radius: 3px;
    -khtml-border-radius: 3px;
    -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    -moz-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    border: 1px solid #B2BCBE;
    font: 12px Tahoma, Geneva, sans-serif;
    background: #F7F8F8;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#F7F8F8', endColorstr='#ECF1F1');
	background: -webkit-gradient(linear, left top, left bottom, from(#F7F8F8), to(#ECF1F1));
	background: -moz-linear-gradient(top,  #F7F8F8,  #ECF1F1);
}
td.dxeHelpText_Glass {
    visibility: visible;
    color: #9F9F9F;
    font: 11px Tahoma, Geneva, sans-serif;
}
td.dxeHelpText_Glass.dxeHHelpTextSys {
    padding: 0 6px;
}
td.dxeHelpText_Glass.dxeVHelpTextSys {
    padding: 2px 0;
}

/* InternalCheckBox */
.dxeIRBFocused_Glass
{
	border: 1px dotted #68a4c0;
	margin: 0px!important;
}
.dxeIRadioButton_Glass
{
	display: inline-block;
	vertical-align: middle;
	margin: 1px;
}
.dxeLoadingDiv_Glass
{
	background: White none;
	opacity: 0.85;
	filter: alpha(opacity=85);
}
.dxeLoadingDivWithContent_Glass
{
	background: White none;
	opacity: 0.01;
	filter: alpha(opacity=1);
}

.dxeLoadingPanel_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}
.dxeLoadingPanelWithContent_Glass
{
	border: 1px solid #7EACB1;
	background-color: #FFFFFF;
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}

.dxeLoadingPanel_Glass td.dx,
.dxeLoadingPanelWithContent_Glass td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}

.dxeBase_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
}
td.dxic
{
	font-size: 0;
}
/* -- ErrorFrame -- */
.dxeErrorCell_Glass,
.dxeErrorCell_Glass td
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: red;
}
.dxeErrorCell_Glass
{
	color: #a91123;
	padding-left: 4px;
}
.dxeErrorFrame_Glass
{
}
.dxeErrorFrameWithoutError_Glass
{
	border: 1px solid Red;
}
.dxeErrorFrameWithoutError_Glass .dxeControlsCell_Glass,
.dxeErrorFrameWithoutError_Glass.dxeControlsCell_Glass
{
	padding: 2px;
}
.dxeEditArea_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	border: 1px solid #A0A0A0;
}

/* -- Buttons -- */
.dxeButtonEdit_Glass
{
	background-color: white;
}

.dxeButtonEdit_Glass td.dxic {
    *padding-left: 2px;
}
*[dir="rtl"].dxeTextBox_Glass td.dxic {
    *padding-right: 2px;
}

.dxeButtonEdit_Glass .dxeEditArea_Glass
{
	background-color: white;
}

.dxeButtonEditButton_Glass,
.dxeCalendarButton_Glass,
.dxeSpinIncButton_Glass,
.dxeSpinDecButton_Glass,
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	background-color: #5F94B2;
	vertical-align: middle;
	cursor: pointer;
} 
.dxeButtonEditButton_Glass,
.dxeCalendarButton_Glass, 
.dxeButtonEditButton_Glass td.dx,
.dxeCalendarButton_Glass td.dx,
.dxeSpinIncButton_Glass td.dx,
.dxeSpinDecButton_Glass td.dx,
.dxeSpinLargeIncButton_Glass td.dx,
.dxeSpinLargeDecButton_Glass td.dx,
.dxeSpinIncButton_Glass,
.dxeSpinDecButton_Glass,
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	color: #000000;
	font: normal 12px Tahoma, Geneva, sans-serif;
	text-align: center;
} 
.dxeButtonEditButton_Glass
{
	background: #45829F url('/coneauglobal/DXR.axd?r=0_883-qnIN9') repeat-x top;
	border: 1px solid #4986a2;
	padding: 0px 1px;
}
.dxeSpinIncButton_Glass,
.dxeSpinDecButton_Glass,
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	border-style: none;
	padding: 0px;
}

.dxeButtonEditButton_Glass table.dxbebt
{
	width: 12px;
}
.dxeButtonEditButton_Glass table.dxbebt td.dx
{
	color: White;
}
/* SpinButtons */
.dxeSpinLargeIncButton_Glass
{
	padding-left: 1px;
}
.dxeSpinIncButton_Glass
{
	background: #5F94B2 url('/coneauglobal/DXR.axd?r=0_893-qnIN9') no-repeat left top;
	border-bottom: 1px Solid #FFFFFF;
}
.dxeSpinDecButton_Glass
{
	background: #4986A2 url('/coneauglobal/DXR.axd?r=0_892-qnIN9') no-repeat left top;
	border-bottom-style: none;
}
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	background: #4986A2 url('/coneauglobal/DXR.axd?r=0_896-qnIN9') no-repeat left top;
}

.dxeSpinLargeDecButton_Glass
{
	border-right-style: none;
}
.dxeSpinLargeIncButton_Glass
{
	border-left-style: none;
}

.dxeCalendarButton_Glass
{
	background: #DADFE0 url('/coneauglobal/DXR.axd?r=0_881-qnIN9') repeat-x top;
	border: 1px solid #B2BCBE;
	padding: 5px 10px;
}
.dxeCalendarButton_Glass table.dxbebt
{
	width: 30px;
}
/* SpinButtons */
.dxeSpinIncButton_Glass table.dxbebt,
.dxeSpinDecButton_Glass table.dxbebt
{
	width: 15px;
}
.dxeSpinLargeDecButton_Glass table.dxbebt
{
	width: 16px;
}
.dxeSpinLargeIncButton_Glass table.dxbebt
{
	width: 15px;
}

.dxeCalendarButton_Glass td.dx
{
	text-align: center;
	white-space: nowrap;
}

/* -- Hover -- */
.dxeButtonHover_Glass         /* inherits dxeButton */
{
	background-color: #E6E3D6;
}
.dxeCalendarButtonHover_Glass
{
	background: #B5D7DB url('/coneauglobal/DXR.axd?r=0_885-qnIN9') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxeButtonEditButtonHover_Glass
{
	background: #35acd2 url('/coneauglobal/DXR.axd?r=0_887-qnIN9') repeat-x top;
	border: 1px Solid #4986a2;
}
/* SpinButtons */
.dxeSpinIncButtonHover_Glass,
.dxeSpinDecButtonHover_Glass,
.dxeSpinLargeIncButtonHover_Glass,
.dxeSpinLargeDecButtonHover_Glass
{
	border-style: none;
}
.dxeSpinIncButtonHover_Glass
{
	background: #536b78 url('/coneauglobal/DXR.axd?r=0_894-qnIN9') no-repeat left top;
	border-bottom: 1px Solid #FFFFFF;
}
.dxeSpinDecButtonHover_Glass
{
	background: #56abd1 none;
	border-bottom-style: none;
}
.dxeSpinLargeIncButtonHover_Glass
{
	background: #86bad6 url('/coneauglobal/DXR.axd?r=0_897-qnIN9') no-repeat left top;
	border-left-style: none;
}
.dxeSpinLargeDecButtonHover_Glass
{
	background: #86bad6 url('/coneauglobal/DXR.axd?r=0_897-qnIN9') no-repeat left top;
	border-right-style: none;
}
/* -- Pressed -- */
.dxeButtonPressed_Glass       /* inherits dxeButton */
{
	background-color: #D4D1C3;
}
.dxeCalendarButtonPressed_Glass
{
	background: #9ABDC1 url('/coneauglobal/DXR.axd?r=0_886-qnIN9') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxeButtonEditButtonPressed_Glass
{
	background: #35657b url('/coneauglobal/DXR.axd?r=0_888-qnIN9') repeat-x top;
	border: 1px Solid #3b6d84;
}
/* SpinButtons */
.dxeSpinIncButtonPressed_Glass,
.dxeSpinDecButtonPressed_Glass,
.dxeSpinLargeIncButtonPressed_Glass,
.dxeSpinLargeDecButtonPressed_Glass
{
	border-style: none;
}
.dxeSpinIncButtonPressed_Glass
{
	background: #363636 url('/coneauglobal/DXR.axd?r=0_895-qnIN9') no-repeat left top;
	border-bottom: 1px Solid #FFFFFF;
}
.dxeSpinDecButtonPressed_Glass
{
	background: #3b6d84 none;
	border-bottom-style: none;
}
.dxeSpinLargeIncButtonPressed_Glass
{
	background: #b7b7b7 url('/coneauglobal/DXR.axd?r=0_898-qnIN9') no-repeat left top;
	border-left-style: none;
}
.dxeSpinLargeDecButtonPressed_Glass
{
	background: #b7b7b7 url('/coneauglobal/DXR.axd?r=0_898-qnIN9') no-repeat left top;
	border-right-style: none;
}

.dxeButtonEdit_Glass
{
	border: 1px solid #7EACB1;
}
.dxeButtonEdit_Glass .dxeIIC img
{
	padding-left: 3px;
}
.dxeTextBox_Glass,
.dxeMemo_Glass
{
	background-color: white;
	border: 1px Solid #7eacb1;
}
.dxeTextBox_Glass .dxeEditArea_Glass
{
	background-color: white;
}
.dxeRadioButtonList_Glass,
.dxeRadioButtonList_Glass table,
.dxeCheckBoxList_Glass,
.dxeCheckBoxList_Glass table
{
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxeCheckBoxList_Glass .dxe > table,
.dxeRadioButtonList_Glass .dxe > table 
{
    width: 100%;
}

.dxeRadioButtonList_Glass,
.dxeCheckBoxList_Glass
{
	border: 1px Solid #7EACB1;
}
.dxeRadioButtonList_Glass td.dxe,
.dxeCheckBoxList_Glass td.dxe
{
	padding: 6px 5px 6px 11px;
}
.dxeRadioButtonList_Glass label,
.dxeCheckBoxList_Glass label
{
	margin-right: 6px;
}
.dxeRadioButtonList_Glass img,
.dxeCheckBoxList_Glass img
{
	margin-bottom: -4px;
    padding-right: 5px;
}

/* -- Memo -- */
.dxeMemo_Glass
{
}
.dxeMemoEditArea_Glass
{
	background-color: white;
	font: 12px Tahoma, Geneva, sans-serif;
	outline: none;
}

/* -- Hyperlink -- */
.dxeHyperlink_Glass
{
	font: normal 12px Tahoma, Geneva, sans-serif;
	color: #2a769d;
}
a.dxeHyperlink_Glass
{
	color: #2a769d;
}
a:hover.dxeHyperlink_Glass
{
	color: #f15e34;
}
a:visited.dxeHyperlink_Glass
{
	color: #a1a1a1;
}

/* -- ListBox -- */
.dxeListBox_Glass
{
	background-color: white;
	border: 1px solid #7EACB1;
	font: 12px Tahoma, Geneva, sans-serif;
	height: 102px;
	width: 70px;
}

.dxeListBox_Glass div.dxlbd
{
	height: 102px;
}
.dxeListBoxItemRow_Glass
{
	cursor: default;
}
.dxeListBoxItem_Glass
{
	border: 1px solid white;
	font: normal 12px Tahoma, Geneva, sans-serif;
	padding: 2px 2px 2px 3px;
	white-space: nowrap;
	text-align: left;
	color: Black;
}
.dxeListBoxItem_Glass em
{
	background: #d9eced none repeat 0 0;
	color: #333333;
	font-weight: bold;
	font-style: normal;
}
.dxeListBoxItemSelected_Glass     /* inherits dxeListBoxItem */
{
	background-color: #E9F6F8;
}
.dxeListBoxItemHover_Glass        /* inherits dxeListBoxItem */
{
	background-color: #d9eced;
}
.dxeListBoxItemHover_Glass em,
.dxeListBoxItemSelected_Glass em
{
	background-image: none;
}
.dxeListBox_Glass td.dxeI,
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeC,
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeMI,
.dxeListBox_Glass td.dxeMIM
{
	border-right-width: 0!important;
}
.dxeListBox_Glass td.dxeIR,
.dxeListBox_Glass td.dxeIMR,
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeCR,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeHCCR,
.dxeListBox_Glass td.dxeMIR,
.dxeListBox_Glass td.dxeMIMR
{
	border-left-width: 0!important;
}
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeHCCR
{
	width: 29px;
    *width: 23px;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass td.dxeIMR
{
	width: 0;
}
.dxeListBox_Glass td.dxeC
{
	padding-right: 3px!important;
}
.dxeListBox_Glass td.dxeCR
{
	padding-left: 3px!important;
}
.dxeListBox_Glass td.dxeC > span,
.dxeListBox_Glass td.dxeCM > span
{
    margin: 2px 2px 2px 3px;
}
.dxeListBox_Glass td.dxeCR > span,
.dxeListBox_Glass td.dxeCMR > span
{
    margin: 2px 3px 2px 2px;
}
.dxeListBox_Glass td.dxeT
{
	width: 100%;
	padding-left: 0!important;
}
.dxeListBox_Glass td.dxeTR
{
	width: 100%;
	padding-right: 0!important;
}
.dxeListBox_Glass td.dxeT,
.dxeListBox_Glass td.dxeMI
{
	border-left-width: 0!important;
}
.dxeListBox_Glass td.dxeTR,
.dxeListBox_Glass td.dxeMIR
{
	border-right-width: 0!important;
}
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR
{
	overflow: hidden;
	border-top-width: 0;
}
.dxeListBox_Glass .dxeCM,
.dxeListBox_Glass .dxeIM,
.dxeListBox_Glass .dxeMIM,
.dxeListBox_Glass .dxeCMR,
.dxeListBox_Glass .dxeIMR,
.dxeListBox_Glass .dxeMIMR
{
	border-top-width: 0;
}
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM, 
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC
{
	padding-right: 6px!important;
}
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR
{
	padding-left: 6px!important;
}
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC
{
	padding-left: 6px!important;
}
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR
{
	padding-right: 6px!important;
}
/*Grid lines*/
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeMIM
{
	border-left: 1px solid #C2D4DA!important;
}
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeMIMR
{
	border-right: 1px solid #C2D4DA!important;
}
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeMIM,
.dxeListBox_Glass td.dxeIMR,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeMIMR
{
	border-bottom: 1px solid #C2D4DA;
}
/*Header*/
.dxeListBox_Glass .dxeHD
{
	background: #C0DDE0 url('/coneauglobal/DXR.axd?r=0_911-qnIN9') repeat-x top center;
	border-bottom: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeHMIC,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR,
.dxeListBox_Glass td.dxeHCCR,
.dxeListBox_Glass td.dxeHMICR
{
	padding-top: 4px;
	padding-bottom: 5px;
	border-bottom-width: 0;
	border-top-width: 0;
}
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeHMIC
{
	border-left: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR,
.dxeListBox_Glass td.dxeHMICR
{
	border-right: 1px solid #7EACB1;
	text-align: right;
}
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHCC
{
	border-left: 1px solid #C0DDE0;
}
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCCR
{
	border-right: 1px solid #C0DDE0;
	text-align: right;
}
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHMIC
{
	border-right-width: 0;
}
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHMICR
{
	border-left-width: 0;
	text-align: right;
}
.dxeListBox_Glass .dxeHLC
{
	border-right: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHLCR
{
	border-left: 1px solid #7EACB1;
	text-align: right;
}

/* -- Calendar -- */
.dxeCalendar_Glass
{
	color: black;
	font-weight: normal;
	border: 1px solid #7eacb1;
	background-color: White;
}
.dxeCalendar_Glass td.dxMonthGrid,
.dxeCalendar_Glass td.dxMonthGridWithWeekNumbers
{
	padding: 8px 20px 8px 8px;
	cursor: default;
}
.dxeCalendar_Glass td.dxMonthGrid
{
	padding-left: 20px;
}
.dxeCalendar_Glass td.dxMonthGridWithWeekNumbersRtl
{
	padding: 8px 8px 8px 20px;
	cursor: default;
}
.dxeCalendarDayHeader_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	padding: 4px;
	color: Black;
	border-bottom: 1px solid #bcbcff;
}
.dxeCalendarWeekNumber_Glass
{
	font: 11px Tahoma, Geneva, sans-serif;
	text-align: right;
	color: #a0a0ff;
	padding: 6px 8px 2px 4px;
}
.dxeCalendarDay_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	padding: 3px;
	color: Black;
	background-color: White;
	text-align: center;
}
.dxeCalendarWeekend_Glass       	/* inherits dxeCalendarDay */
{
	color: #fe3c00;
}
.dxeCalendarOtherMonth_Glass    	 /* inherits dxeCalendarDay */
{
	color: #acacac;
}
.dxeCalendarOutOfRange_Glass        /* inherits dxeCalendarDay */
{
	color: #d0d0d0;
}
.dxeCalendarSelected_Glass       	/* inherits dxeCalendarDay */
{
	background-color: #9eced6;
	color: #FFFFFF;
}
.dxeCalendarToday_Glass       	        /* inherits dxeCalendarDay */
{
	border: 1px solid #ff5c20;
	padding: 2px;
}
.dxeCalendarHeader_Glass
{
	color: #000000;
	font: 12px Tahoma, Geneva, sans-serif;
	background-color: #bcdbeb;
	border-top: 1px solid #7eacb1;
	border-right: 0 solid #7eacb1;
	border-bottom: 1px solid #7eacb1;
	border-left: 0 solid #7eacb1;
	text-align: center;
	padding: 1px;
	height: 18px;
}
.dxeCalendarHeader_Glass td.dxe
{
	text-align: center;
	cursor: pointer;
}
.dxeCalendarFooter_Glass
{
	background-color: #e3f0f7;
	padding: 6px 0px;
	border-top: 1px solid #7eacb1;
}
.dxeCalendarFastNav_Glass
{
	background: white none;
	border-top: 1px solid #7eacb1;
	border-right: 1px solid #7eacb1;
	border-bottom: 0px solid #7eacb1;
	border-left: 1px solid #7eacb1;
	padding: 8px;
}
.dxeCalendarFastNavFooter_Glass
{
	background-color: #e3f0f7;
	padding: 6px 0px;
	border: 1px solid #7eacb1;
}
.dxeCalendarFastNavMonth_Glass,
.dxeCalendarFastNavYear_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
	padding: 4px 6px;
	text-align: center;
	cursor: pointer;
}
.dxeCalendarFastNavMonthSelected_Glass,
.dxeCalendarFastNavYearSelected_Glass
{
	background: #9eced6 none;
}
.dxeCalendarFastNavMonthHover_Glass,
.dxeCalendarFastNavYearHover_Glass
{
	background: #e4edef none;
}
.dxeDateEditTimeEditCell_Glass
{
    padding: 4px 37px 12px ;
}
.dxeDateEditClockCell_Glass
{
    padding: 8px 14px 0;
}
.dxeCalendarFooter_Glass.dxeDETSF
{
    padding-left: 6px;
    padding-right: 6px;
}
/* Disabled */
.dxeDisabled_Glass,
.dxeDisabled_Glass td.dxe
{
	color: #93a1a4;
	cursor: default;
}
a.dxeDisabled_Glass, a.dxeDisabled_Glass:hover
{
	color: #93a1a4;
}
.dxeButtonDisabled_Glass,
.dxeButtonDisabled_Glass td.dxe
{
	color: #93a1a4;
	background: #cdd7db url('/coneauglobal/DXR.axd?r=0_884-qnIN9') repeat-x left top;
	border-color: #c2c3c4;
	cursor: default;
}
.dxeButtonDisabled_Glass td.dx
{
	color: #93a1a4;
}
/* -- Button -- */
.dxbButton_Glass
{
	color: #000000;
	font: normal 12px Tahoma, Geneva, sans-serif;
	vertical-align: middle;
	border: 1px solid #B2BCBE;
	background: #DADFE0 url('/coneauglobal/DXR.axd?r=0_881-qnIN9') repeat-x top;
	padding: 1px;
	cursor: pointer;
}
.dxbButtonHover_Glass
{
	background: #B5D7DB url('/coneauglobal/DXR.axd?r=0_885-qnIN9') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxbButtonChecked_Glass
{
	background: #d3d3d3 url('/coneauglobal/DXR.axd?r=0_882-qnIN9') repeat-x top;
	border: 1px solid #929292;
}
.dxbButtonPressed_Glass
{
	background: #9ABDC1 url('/coneauglobal/DXR.axd?r=0_886-qnIN9') repeat-x top;
	border: 1px solid #71ACB4;
}

.dxbButton_Glass div.dxb
{
	padding: 3px 13px 4px;
	border-width: 0px;
}
.dxbButton_Glass div.dxbf
{
	padding: 2px 12px 3px;
	border: 1px dotted #9C99CA;
}
.dxbButton_Glass div.dxb td.dxb
{
	background: transparent url('')!important;
	border-width: 0px!important;
	padding: 0px!important;
}
/* Disabled */
.dxbDisabled_Glass
{
	color: #93a1a4;
	cursor: default;
}
.dxbDisabled_Glass td.dxb
{
	color: #93a1a4;
}

/* -- FilterControl -- */
.dxfcTable_Glass
{
	border-collapse: separate!important;
}
.dxfcTable_Glass td.dxfc
{
	padding: 0px 0px 0px 3px;
	vertical-align: middle;
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
}
a.dxfcPropertyName_Glass
{
	white-space: nowrap!important;
	color: Blue!important;
}
a.dxfcGroupType_Glass
{
	white-space: nowrap!important;
	padding: 0px 3px!important;
	color: Red!important;
}
a.dxfcOperation_Glass
{
	white-space: nowrap!important;
	color: Green!important;
}
a.dxfcValue_Glass
{
	white-space: nowrap!important;
	color: Gray!important;
}
.dxfcImageButton_Glass
{
	cursor: pointer;
}
.dxfcLoadingPanel_Glass
{
	border: 1px solid #7EACB1;
	background: white none;
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}
.dxfcLoadingPanel_Glass td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}
.dxfcLoadingDiv_Glass
{
	background: white none;
	opacity: 0.01;
	filter: alpha(opacity=1);
}

.dxeMaskHint_Glass
{
	background: #ffffe1 none;
	border: 1px solid black;
	padding: 2px 5px 3px;
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
}
/* -- ProgressBar -- */
.dxeProgressBar_Glass,
.dxeProgressBar_Glass td
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
}
.dxeProgressBar_Glass .dxePBMainCell,
.dxeProgressBar_Glass td
{
	padding: 0;
}
.dxeProgressBar_Glass td
{
	background: url('/coneauglobal/DXR.axd?r=0_891-qnIN9') no-repeat 50% 0px;
}
.dxeProgressBar_Glass
{
	border: 1px Solid #4986a2;
	background: #C6E0E4 url('/coneauglobal/DXR.axd?r=0_889-qnIN9') repeat-x;
}
.dxeProgressBarIndicator_Glass
{
	background: #4986a2 url('/coneauglobal/DXR.axd?r=0_890-qnIN9') repeat-x;
}

/* -- DropDownWindow -- */
.dxeDropDownWindow_Glass
{
	background-color: white;
	border: 1px solid #7EACB1;
}

/*----------------- ColorTable -----------------*/
.dxeColorIndicator_Glass
{
	border: 1px solid #7EACB1;
	width: 15px;
	height: 15px;
	cursor: pointer;
}
.dxeColorTable_Glass
{
	background-color: white;
	border: 1px solid #7EACB1;
}
.dxeItemPicker_Glass
{
	background-color: #EDF3F4;
	border: 1px solid #7EACB1;
}
.dxeColorTable_Glass td.dx,
.dxeItemPicker_Glass td.dx
{
	padding: 4px;
}
.dxeColorTableCell_Glass,
.dxeItemPickerCell_Glass
{
	padding: 3px;
	cursor: pointer;
}
.dxeColorTableCellDiv_Glass
{
	border: 1px solid #808080;
	width: 12px;
	height: 12px;
	font-size: 0px;
}
.dxeColorTableCellSelected_Glass
{
	padding: 2px!important;
	background-color: #CBCBCB;
	border: 1px solid #888888;
}
.dxeColorTableCellHover_Glass,
.dxeItemPickerCellHover_Glass
{
	padding: 2px!important;
}  
.dxeColorTableCellHover_Glass
{
	background-color: #F2F2F2;
	border: 1px solid #888888;
}
.dxeItemPickerCellHover_Glass
{
	background-color: #D9ECED;
	border: 1px solid #C0DDE0;
}

/* -- Invalid Style -- */
.dxeInvalid_Glass
{
}
.dxeInvalid_Glass .dxeEditArea_Glass,
.dxeInvalid_Glass .dxeMemoEditArea_Glass
{
}

/* -- Focused Style -- */
.dxeFocused_Glass
{
	border: 1px solid #39555d;
}

.dxeFocused_Glass.dxeTrackBar_Glass
{	
	border: 0px;
}

/* -- Null Text Style -- */
.dxeNullText_Glass .dxeEditArea_Glass,
.dxeNullText_Glass .dxeMemoEditArea_Glass
{
	color: #93a1a4;
}

/* -- Captcha -- */
.dxcaControl_Glass 
{
}

.dxcaRefreshButton_Glass
{
	font: 13px Tahoma, Geneva, sans-serif;
	text-decoration: none;
	color: #2a769d;
}

.dxcaDisabledRefreshButton_Glass
{
	color: #93a1a4;
}

.dxcaRefreshButtonCell_Glass
{
	padding-left: 4px;
	padding-right: 4px;
}

.dxcaRefreshButtonText_Glass
{
	text-decoration: underline;
}

.dxcaDisabledRefreshButtonText_Glass
{
	text-decoration: none;
}

.dxcaTextBoxCell_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxcaTextBoxCell_Glass,
.dxcaTextBoxCellNoIndent_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxcaTextBoxCellNoIndent_Glass .dxeErrorCell_Glass
{
	padding-left: 0px;
	padding-top: 4px;
	color: #a91123;
}

.dxcaTextBoxLabel_Glass
{
	padding-bottom: 4px;
	display: block;
}

.dxcaLoadingPanel_Glass
{
	border: 1px solid #7EACB1;
	background-color: #FFFFFF;
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}

.dxcaLoadingPanel_Glass td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}

.dxpcControl_Glass .dxHFBPS,
.dxpcLite_Glass .dxHFBPS
{
    width: 6px;
}

.dxeTextBox_Glass,
.dxeButtonEdit_Glass,
.dxeIRadioButton_Glass,
.dxeRadioButtonList_Glass,
.dxeCheckBoxList_Glass
{
    cursor: default;
}

/* Removes flicking in iOS Safari*/
.dxeTrackBar_Glass, 
.dxeIRadioButton_Glass, 
.dxeButtonEdit_Glass, 
.dxeTextBox_Glass, 
.dxeRadioButtonList_Glass, 
.dxeCheckBoxList_Glass, 
.dxeMemo_Glass, 
.dxeListBox_Glass, 
.dxeCalendar_Glass, 
.dxeColorTable_Glass
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}
