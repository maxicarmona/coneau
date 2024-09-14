/* TextEdit */
.dxeMemoEditAreaSys 
{
    padding: 3px 3px 0px 3px;
    margin: 0px;
    border-width: 0px;
	display: block;
	resize: none;
}
.dxeEditAreaSys 
{
    height: 14px;
    line-height: 14px;
    border: 0px!important;
	padding: 0px 1px 0px 0px; /* B146658 */
    background-position: 0 0; /* iOS Safari */
}
.dxeMemoSys td 
{
    padding: 0px 6px 0px 0px;
}
*[dir="rtl"].dxeMemoSys td 
{
    padding: 0px 0px 0px 6px;
}
.dxeTextBoxSys, 
.dxeMemoSys 
{
    border-collapse:separate!important;
}

.dxeButtonEditSys 
{
    width: 170px;
}

.dxeButtonEditSys .dxeEditAreaSys,
.dxeButtonEditSys td.dxic,
.dxeTextBoxSys td.dxic,
.dxeMemoSys td,
.dxeEditAreaSys
{
	width: 100%;
}

.dxeTextBoxSys td.dxic,
.dxeButtonEditSys td.dxic 
{
    padding: 3px 3px 2px 3px;
    overflow: hidden;
}
*[cellspacing="1"].dxeButtonEditSys td.dxic 
{
    padding: 2px 2px 1px 2px;
}


/* Safari */
.dxeTextBoxSys.dxeSafariSys td.dxic,
.dxeButtonEditSys.dxeSafariSys td.dxic  
{
    padding-left: 2px;
}
*[cellspacing="1"].dxeButtonEditSys.dxeSafariSys td.dxic 
{
    padding-left: 1px;
}
*[dir="rtl"].dxeTextBoxSys.dxeSafariSys td.dxic,
*[dir="rtl"].dxeButtonEditSys.dxeSafariSys td.dxic 
{
    padding-right: 2px;
}

*[dir="rtl"][cellspacing="1"].dxeButtonEditSys.dxeSafariSys td.dxic 
{
    padding-right: 1px;
}

*[dir="rtl"].dxeSafariSys .dxeMemoEditAreaSys 
{
    padding-right: 4px;
    padding-left: 3px;
}
*[dir="rtl"].dxeSafariSys td.dxic 
{
    padding-left: 7px;
    padding-right: 0px;
}

/* IE8 */
.dxeMemoEditAreaSys 
{
    padding-right: 4px\0/;
}
.dxeMemoSys td 
{
    padding-right: 7px\0/;
}
*[cols="20"].dxeMemoEditAreaSys 
{
    width: 100%\0/;
}
*[dir="rtl"].dxeMemoSys td 
{
    padding-left: 7px\0/;
}
*[dir="rtl"] .dxeEditAreaSys 
{
    padding-right: 1px\0/;
}

/* IE9 */
:root *[cols="20"].dxeMemoEditAreaSys 
{
    width: 100%;
}

/* WebKit */
@media screen and (-webkit-min-device-pixel-ratio:0) 
{  
    *[dir="rtl"] .dxeEditAreaSys 
    {
        padding-right: 1px;
    }
    *[dir="rtl"].dxeMemoSys td 
    {
        padding-left: 7px;
    }
    *[dir="rtl"].dxeMemoSys .dxeMemoEditAreaSys 
    {
        padding-right: 4px;
    }
}

/* iPad */
.dxeIPadSys .dxeMemoEditAreaSys 
{
    padding-left: 1px;
    padding-right: 0px;
}
.dxeIPadSys.dxeMemoSys td 
{
    padding-left: 0px;
    padding-right: 1px;
}
*[dir="rtl"].dxeMemoSys.dxeIPadSys td 
{
    padding-left: 5px;
    padding-right: 0px;
}

/* Opera */
noindex:-o-prefocus, *[dir="rtl"].dxeMemoSys textarea 
{
    padding-right: 3px;
}
noindex:-o-prefocus, *[dir="rtl"].dxeTextBoxSys td.dxic 
{
    padding-right: 3px;
}
noindex:-o-prefocus, *[dir="rtl"].dxeButtonEditSys td.dxic 
{
    padding-right: 3px;
}
noindex:-o-prefocus, *[dir="rtl"][cellspacing="1"].dxeButtonEditSys td.dxic 
{
    padding-right: 2px;
}
noindex:-o-prefocus, *[dir="rtl"] .dxeEditAreaSys 
{
    padding-right: 1px;
}

/* IE7 */
.dxeMemoEditAreaSys 
{
    *margin: -1px 0px;
    *padding-right: 4px;
}
.dxeMemoSys td 
{ 
    *padding: 0px; 
}
.dxeTextBoxSys td.dxic 
{
    *padding-left: 3px;
    *padding-top: 2px;
    *padding-bottom: 1px;
}
*[dir="rtl"].dxeMemoSys td 
{
    *padding-left: 0px;
    *padding-right: 1px;
}
*[dir="rtl"].dxeTextBoxSys td.dxic 
{
    *padding-right: 3px;
}
*[dir="rtl"].dxeTextBoxSys .dxeEditAreaSys 
{
    *padding-right: 2px;
}
*[dir="rtl"].dxeButtonEditSys td.dxic
{
    *padding-right: 2px;
}
.dxeButtonEditSys td.dxic {
    *padding-top: 1px;
    *padding-bottom: 0px;
}
*[dir="rtl"].dxeButtonEditSys .dxeEditAreaSys 
{
    *padding-right: 1px;
}

/* FireFox*/
@-moz-document url-prefix() 
{   
    .dxeMemoEditAreaSys 
    {
        padding-top: 2px;
        padding-right: 0px;
        padding-left: 2px;
    }
    .dxeMemoSys td 
    {
        padding-right: 2px;   
    }
    .dxeTextBoxSys td.dxic,
    .dxeButtonEditSys td.dxic 
    {
        padding-left: 2px;
        padding-right: 2px;
    }
    *[cellspacing="1"].dxeButtonEditSys td.dxic 
    {
        padding-left: 1px;
        padding-right: 1px;
    }

    *[dir="rtl"].dxeTextBoxSys td.dxic,
    *[dir="rtl"].dxeButtonEditSys td.dxic 
    {
        padding-right: 2px;
    }
    *[dir="rtl"][cellspacing="1"].dxeButtonEditSys td.dxic 
    {
        padding-right: 1px;
    }
    *[dir="rtl"].dxeMemoSys .dxeMemoEditAreaSys 
    {
        padding-left: 0px;
        padding-right: 3px;
    }
    *[dir="rtl"].dxeMemoSys td 
    {
        padding-left: 3px;
    }  
}

/* TrackBar */
.dxeTBLargeTickSys, 
.dxeTBSmallTickSys, 
.dxeTBItemSys
{
	position:absolute;
	background-repeat: no-repeat;
    background-color: transparent;
}

.dxeTBLargeTickSys, .dxeTBSmallTickSys
{
	white-space: nowrap;
}

.dxeTBContentContainerSys
{
	position: relative;
}

.dxeTBVSys a, .dxeTBHSys a
{
	text-indent: -5000px;
    text-align: left;
	overflow: hidden;
	display: block;
	position: absolute;
}

.dxeTBVSys a:focus,
.dxeTBVSys a:active,
.dxeTBHSys a:focus, 
.dxeTBHSys a:active {
	outline-width: 0px;
}

.dxeTBHSys .dxeTBLTScaleSys .dxeTBSmallTickSys,
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLargeTickSys
{
	background-position: bottom;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBSmallTickSys, 
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLargeTickSys
{
	background-position: right;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBSmallTickSys, 
.dxeTBHSys .dxeTBRBScaleSys .dxeTBLargeTickSys
{
	background-position: top;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBSmallTickSys, 
.dxeTBVSys .dxeTBRBScaleSys .dxeTBLargeTickSys
{
	background-position: left;
}
.dxeTBBScaleSys .dxeTBSmallTickSys,
.dxeTBBScaleSys .dxeTBLargeTickSys
{
	background-position: center;
}

.dxeFItemSys
{
	background-image: none!important;
}

.dxeTBHSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: right;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: top;
}
.dxeReversedDirectionSys .dxeTBVSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: bottom;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBItemSys,
.dxeReversedDirectionSys .dxeTBVSys .dxeTBRBScaleSys .dxeTBItemSys
{
	background-position: bottom left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBLTScaleSys .dxeTBItemSys,
.dxeReversedDirectionSys .dxeTBVSys .dxeTBLTScaleSys .dxeTBItemSys
{
	background-position: bottom right;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBItemSys,
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItemSys 
{
	background-position: top left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBRBScaleSys .dxeTBItemSys,
.dxeTBVSys .dxeTBLTScaleSys .dxeTBItemSys
{
	background-position: top right;
}

.dxeTBScaleSys
{
	position: absolute;
	list-style-type: none!important;
	margin: 0px;
	padding: 0px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBScaleSys
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBScaleSys
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBScaleSys
{
	bottom: 0px;
} 
.dxeTBHSys .dxeTBLTScaleSys .dxeTBScaleSys
{
	top: 0px;
}

.dxeFocusedDHSys 
{
	z-index: 6!important;
}

.dxeReversedDirectionSys,
.dxeFocusedMDHSys,
.dxeFocusedSDHSys
{
}

