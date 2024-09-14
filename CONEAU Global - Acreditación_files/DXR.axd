img 
{
	border-width: 0px;
}

.dx-clear
{
	display: block;
	clear: both;
	height: 0;
	width: 0;
	font-size: 0;
	line-height: 0;
	overflow: hidden;
	visibility: hidden;
}

.dxKBSW
{
	font-size:0;
}

.dxMSTouchDraggable,
.dxAC
{
	-ms-touch-action: pinch-zoom;
}

/* ASPxInternalCheckBox */
.dxicbInput
{
	border: 0;
	width: 0;
	height: 0;
	padding: 0;
	background-color: transparent;
}

/* ASPxUploadControl */
.dxucEditAreaSys
{
    margin: 0px;
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 13px;
}
.dxucButtonSys
{
    color: #394EA2;
    cursor: pointer;
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 13px;
    white-space: nowrap;
}
.dxucButtonSys a[unselectable="on"]
{
    cursor: default;
    user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
}

/* ASPxPopupControl lite */
.dxpc-contentWrapper 
{
	display: table;
    width: 100%;
    border-spacing: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.dxpc-shadow 
{
	-moz-box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
    -webkit-box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
}

/* ASPxMenu lite */
.dxm-shadow 
{
	-moz-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
    -webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
}

/* ASPxDocking - Dock zone */
.dxdzControlVert 
{
    width: 200px;
    height: 400px;
}

.dxdzControlHor
{
    width: 400px;
    height: 200px;
}

.dxdzControlFill
{
    width: 400px;
    height: 400px;
}

.dxdzDisabled
{
}

.dxdzControlVert .dxdz-pnlPlcHolder, 
.dxdzControlHor .dxdz-pnlPlcHolder,
.dxdzControlFill .dxdz-pnlPlcHolder
{
    width: 0;
    height: 0;
    border: 2px solid #A3B5DA;
    background-color: #D1DAEC;
}

.dxdzControlHor .dxdz-pnlPlcHolder
{
    float: left;
}

/* Splitter */
.dxsplS
{
    display: inline-block;
}
.dxsplS
{
	font-size: 0px;
	line-height: 0px;
}
.dxsplLCC,
.dxsplCC,
.dxsplS
{
	overflow: hidden;
}
.dxsplCC,
.dxsplP
{
	width: 100%;
	height: 100%;
}

/* Mobile */
.dxTouchVScrollHandle, .dxTouchHScrollHandle
{
    background-color: Black;
    position: absolute;
    opacity: 0;
    border-radius: 5px;
    -webkit-transition-property: opacity;
    -webkit-transition-duration: 0.3s;
    -webkit-transition-timing-function: ease-out;
}
.dxTouchVScrollHandle
{
    width: 5px;
    height: 50%;
    margin-bottom: 3px;
}
.dxTouchHScrollHandle
{
    width: 50%;
    height: 5px;
    margin-right: 3px;
}
.dxTouchScrollHandleVisible
{
    -webkit-transition-duration: 0s;
	opacity: 0.4!important;
}

/* Layout Control */
.dxflHALSys { text-align: left; }
.dxflHALSys > table,
.dxflHALSys > div {
    margin-left: 0px;
    margin-right: auto;
}
.dxflHARSys { text-align: right; }
.dxflHARSys > table,
.dxflHARSys > div {
    margin-left: auto;
    margin-right: 0px;
}
.dxflHACSys { text-align: center; }
.dxflHACSys > table,
.dxflHACSys > div {
    margin-left: auto;
    margin-right: auto;
}
.dxflVATSys { vertical-align: top; }
.dxflVAMSys { vertical-align: middle; }
.dxflVABSys { vertical-align: bottom; }

/* ASPxFileManager */
.dxfm-file .dxgv,
.dxfm-file .dxgv .dxfm-fileName
{
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.dxfm-file .dxgv.dxfm-fileThumb,
.dxfm-file .dxgv.dxgvCommandColumn
{
	text-overflow: clip;
}
.dxfm-multiSelect .dxfm-pThumbnailCheckImage
{
    display: none;
}
.dxfm-multiSelect div.dxfm-fileSA .dxfm-pThumbnailCheckImage,
.dxfm-multiSelect div.dxfm-fileSI .dxfm-pThumbnailCheckImage
{
    display: inline;
}
