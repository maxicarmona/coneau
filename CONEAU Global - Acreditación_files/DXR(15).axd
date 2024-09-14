var __aspxMenuAnimationAccelerator = 1/10;
var __aspxPCAnimationAccelerator = 1/3;
var __aspxAnimationDiscardPixels = 3;
var __aspxNotSetAlignIndicator = "NotSet";
var __aspxInnerAlignIndicator = "Sides";
function _aspxIsAlignNotSet(align){
 return align == __aspxNotSetAlignIndicator;
}
function _aspxIsInnerAlign(align){
 return align.indexOf(__aspxInnerAlignIndicator) != -1;
}
function _aspxIsOuterAlign(align){
 return (!this.IsInnerAlign(align)) && (!_aspxIsAlignNotSet(align));
}
function _aspxPopupPosition(position, isInverted){
 this.position = position;
 this.isInverted = isInverted;
}
function _aspxSegment(pos, len){
 this.pos = pos;
 this.len = len;
}
function _aspxRect(left, top, width, height){
 this.left = left;
 this.top = top;
 this.width = width;
 this.height = height;
}
function _aspxSize(width, height){
 this.width = width;
 this.height = height;
}
function _aspxFindPopupElementById(id){
 if(id == "") return null; 
 var popupElement = _aspxGetElementById(id);
 if(!_aspxIsExistsElement(popupElement)){
  var idParts = id.split("_");
  var uniqueId = idParts.join("$");
  popupElement = _aspxGetElementById(uniqueId);
 }
 return popupElement;
}
function _aspxFindEventSourceParentByTestFunc(evt, testFunc){
 return _aspxFindParentByTestFunc(_aspxGetEventSource(evt), testFunc);
}
function _aspxPreventContextMenu(evt){
 if (__aspxWebKitFamily){
  if(evt.stopPropagation)
   evt.stopPropagation();
  evt.returnValue = false;
  if(evt.preventDefault)
   evt.preventDefault();
 } else if (__aspxNetscapeFamily || (__aspxIE && __aspxBrowserVersion > 8))
  evt.preventDefault();
}
function _aspxIsExistsAbsolutePosParent(element){
 return _aspxIsExistsParentWithSpecPosition(element, ["absolute"]);
}
function _aspxIsExistsAbsoluteOrRelativePosParent(element){
 return _aspxIsExistsParentWithSpecPosition(element, ["absolute", "relative"]);
}
function _aspxIsExistsParentWithSpecPosition(element, positions){
 var curEl = element.offsetParent;
 while(curEl != null) {
  for(var i = 0; i < positions.length; i ++){
   if (_aspxGetCurrentStyle(curEl).position == positions[i])
    return true;
  }
  curEl = curEl.offsetParent;
 }
 return false;
}
function _aspxGetDocumentClientWidthForPopup(){
 return (__aspxWebKitTouchUI ? _aspxGetDocumentWidth() : _aspxGetDocumentClientWidth()); 
}
function _aspxAdjustPositionToClientScreen(element, shadowSize, pos, isX){
 var min = isX ? _aspxGetDocumentScrollLeft() : _aspxGetDocumentScrollTop();
 var documentClientWidth = _aspxGetDocumentClientWidthForPopup();
 var max = min + (isX ? documentClientWidth : _aspxGetDocumentClientHeight());
 max -= (isX ? element.offsetWidth + shadowSize : element.offsetHeight + shadowSize);
 if (pos > max) pos = max;
 if (pos < min) pos = min;
 return pos;
}
function _aspxGetPopupAbsoluteX(element, shadowWidth, popupElement, hAlign, hOffset, x, left, rtl){
 var width = element.offsetWidth;
 var bodyWidth = _aspxGetDocumentClientWidth();
 var elementX = _aspxGetAbsoluteX(popupElement);
 var scrollX = _aspxGetDocumentScrollLeft();
 if (hAlign == "WindowCenter"){
  var showAtPos = x != __aspxInvalidPosition && !popupElement;
  if(showAtPos)
   hAlign = "";
  else
   return new _aspxPopupPosition(Math.ceil(bodyWidth / 2 - width / 2) + scrollX + hOffset, false);
 }
 if (popupElement) {
  var leftX = elementX - width;
  var rightX = elementX + popupElement.offsetWidth;
  var innerLeftX = elementX;
  var innerRightX = elementX + popupElement.offsetWidth - width;
  var isMoreFreeSpaceLeft = bodyWidth - (rightX + width) < leftX - 2 * scrollX;
 }
 else
  hAlign = "";
 var isInverted = false; 
 if (hAlign == "OutsideLeft"){
  isInverted = !(leftX - scrollX > 0 || isMoreFreeSpaceLeft);
  if(isInverted)
   x = rightX - hOffset;
  else
   x = leftX + hOffset;
 }
 else if (hAlign == "LeftSides"){
  x =  innerLeftX + hOffset;
  x = _aspxAdjustPositionToClientScreen(element, shadowWidth, x, true);
 }
 else if (hAlign == "Center"){
  x =  elementX + Math.round((popupElement.offsetWidth  - width) / 2) + hOffset;
 }
 else if (hAlign == "RightSides"){
  x = innerRightX + hOffset;
  x = _aspxAdjustPositionToClientScreen(element, shadowWidth, x, true);
 }
 else if (hAlign == "OutsideRight"){
  isInverted = !(rightX + width < bodyWidth + scrollX || !isMoreFreeSpaceLeft);
  if(isInverted)
   x = leftX - hOffset;
  else
   x = rightX + hOffset;
 }
 else{
  if(rtl){
   if(!_aspxGetIsValidPosition(x))
    x = popupElement ? innerRightX : left;
   else
    x -= width;
   isInverted = x < scrollX && x - scrollX < bodyWidth / 2;
   if(isInverted)
    x = x + width + hOffset;
   else
    x = x - hOffset;
  } else {
   if (!_aspxGetIsValidPosition(x))
    x = popupElement ? elementX : left;
   isInverted = x - scrollX + width > bodyWidth && x - scrollX > bodyWidth / 2;
   if(isInverted)
    x = x - width - hOffset;
   else
    x = x + hOffset;
  }
 }
 return new _aspxPopupPosition(x, isInverted);
}
function _aspxGetPopupAbsoluteY(element, shadowHeight, popupElement, vAlign, vOffset, y, top){
 var height = element.offsetHeight;
 var bodyHeight = _aspxGetDocumentClientHeight(); 
 var elementY = _aspxGetAbsoluteY(popupElement);
 var scrollY = _aspxGetDocumentScrollTop();
 if (vAlign == "WindowCenter"){
  var showAtPos = y != __aspxInvalidPosition && !popupElement;
  if(showAtPos)
   hAlign = "";
  else
   return new _aspxPopupPosition(Math.ceil(bodyHeight / 2 - height / 2) + scrollY + vOffset, false);
 }
 if (popupElement) {
  var bottomY = elementY + popupElement.offsetHeight;
  var topY = elementY - height;
  var innerBottomY = elementY + popupElement.offsetHeight - height;
  var innerTopY = elementY;
  var isMoreFreeSpaceAbove = bodyHeight - (bottomY + height) < topY - 2 * scrollY;
 }
 else
  vAlign = "";
 var isInverted = false;
 if (vAlign == "Above"){
  isInverted = !(topY - scrollY > 0 || isMoreFreeSpaceAbove);
  if(isInverted)
   y = bottomY - vOffset;
  else
   y = topY + vOffset;
 }
 else if (vAlign == "TopSides"){
  y = innerTopY + vOffset;
  y = _aspxAdjustPositionToClientScreen(element, shadowHeight, y, false);
 }
 else if (vAlign == "Middle"){
  y =  elementY + Math.round((popupElement.offsetHeight  - height) / 2) + vOffset;
 }
 else if (vAlign == "BottomSides"){
  y = innerBottomY + vOffset;
  y = _aspxAdjustPositionToClientScreen(element, shadowHeight, y, false);
 }
 else if (vAlign == "Below"){
  isInverted = !(bottomY + height < bodyHeight + scrollY || !isMoreFreeSpaceAbove);
  if(isInverted)
   y = topY - vOffset;
  else
   y = bottomY + vOffset;
 }
 else{
  if (!_aspxGetIsValidPosition(y))
   y = popupElement ? _aspxGetAbsoluteY(popupElement) : top;
  isInverted = y - _aspxGetDocumentScrollTop() + height > bodyHeight && y - _aspxGetDocumentScrollTop() > bodyHeight / 2;
  if(isInverted)
   y = y - height - vOffset;
  else
   y = y + vOffset;
 }
 return new _aspxPopupPosition(y, isInverted);
}
function _aspxGetIntersectionRect(left1, top1, left2, top2, width, height){
 var segment1 = _aspxGetIntersectionSegment(left1, left2, width);
 var segment2 = _aspxGetIntersectionSegment(top1, top2, height);
 if (segment1 != null && segment2 != null){
  var left = segment1.pos;
  var top = segment2.pos;
  var width = segment1.len;
  var height = segment2.len;
  return new _aspxRect(left, top, width, height);
 }
 return null;
}
function _aspxGetIntersectionSegment(pos1, pos2, len){
 var posDifferense = Math.abs(pos1 - pos2);
 if (posDifferense <= len){
  var pos = pos1 > pos2 ? pos1 : pos2;
  var len = len - posDifferense;
  return new _aspxSegment(pos, len);
 }
 return null;
}
function _aspxRemoveFocus(parent){
 var input = document.createElement('div');
 _aspxConcealInputElement(input);
 parent.appendChild(input);
 if(_aspxIsFocusable(input))
  input.focus();
 _aspxRemoveElement(input);
} 
function _aspxConcealInputElement(input){
 input.style.position = "absolute";
 input.style.left = 0;
 input.style.top = 0;
 if(__aspxWebKitFamily) {
    input.style.opacity = 0;
    input.style.width = 1;
    input.style.height = 1;
 } else {
  input.style.border = 0;
  input.style.width = 0;
  input.style.height = 0;
   }
}
function _aspxInitAnimationDiv(element, x, y, onTimerString, onAnimStopCallString, skipSizeInit){
 element.animationStart = new Date();
 element.absoluteLeft = x;
 element.absoluteTop = y;
 element.popuping = true;
 element.onTimerString = onTimerString;
 element.onAnimStopCallString = onAnimStopCallString;
 element.style.overflow = "hidden";
 element.style.position = "absolute";
 if(!skipSizeInit)
  _aspxSetStyleSize(element, element.offsetWidth, element.offsetHeight);
 _aspxSetStylePosition(element, x, y);
}
function _aspxOnAnimationTimer(animationDivElement, element, mainCell, iframeElement, animationDelay, animationMaxDelay, animationAccelerator){
 animationDivElement.timerID = _aspxClearTimer(element.timerID);
 var timeExpired = new Date() - animationDivElement.animationStart > animationMaxDelay;
 var left = !timeExpired ? _aspxGetNextAnimationPosInternal(element.offsetLeft, animationAccelerator) : 0;
 var top = !timeExpired ? _aspxGetNextAnimationPosInternal(element.offsetTop, animationAccelerator) : 0;
 element.style.top = top + "px";
 element.style.left = left + "px";
 var rect = _aspxGetIntersectionRect(animationDivElement.offsetLeft, animationDivElement.offsetTop, 
  element.offsetLeft + animationDivElement.offsetLeft, element.offsetTop + animationDivElement.offsetTop,
  mainCell.offsetWidth, mainCell.offsetHeight);
 if (rect && iframeElement){
  _aspxSetStylePosition(iframeElement, rect.left, rect.top);
  _aspxSetStyleSize(iframeElement, rect.width, rect.height);
 }
 if(timeExpired || (left == 0 && top == 0))
  _aspxAnimationFinished(animationDivElement);
 else 
  animationDivElement.timerID = window.setTimeout(animationDivElement.onTimerString, animationDelay);
}
function _aspxGetNextAnimationPosInternal(pos, animationAccelerator){
 pos = Math.round(pos * animationAccelerator);
 if (Math.abs(pos) < __aspxAnimationDiscardPixels)
  pos = 0;
 return pos;
}
function _aspxAnimationFinished(element){
 if(_aspxStopAnimation(element) && _aspxIsExists(element.onAnimStopCallString) && 
  element.onAnimStopCallString !== ""){
  window.setTimeout(element.onAnimStopCallString, 0);
 }
}
function _aspxStopAnimation(element){
 if(element.popuping){
  element.popuping = false;
  element.onTimerString = "";
  element.style.overflow = "visible";
  return true;
 }
 return false;
}
function _aspxGetAnimationHorizontalDirection(popupPosition, horizontalAlign, verticalAlign, rtl){
 if (_aspxIsInnerAlign(horizontalAlign) 
  && !_aspxIsInnerAlign(verticalAlign) 
  && !_aspxIsAlignNotSet(verticalAlign))
  return 0;
 var toTheLeft = (horizontalAlign == "OutsideLeft" || horizontalAlign == "RightSides" || (horizontalAlign == "NotSet" && rtl)) ^ popupPosition.isInverted;
 return toTheLeft ? 1 : -1;
}
function _aspxGetAnimationVerticalDirection(popupPosition, horizontalAlign, verticalAlign){
 if (_aspxIsInnerAlign(verticalAlign) 
  && !_aspxIsInnerAlign(horizontalAlign) 
  && !_aspxIsAlignNotSet(horizontalAlign))
  return 0;
 var toTheTop = (verticalAlign == "Above" || verticalAlign == "BottomSides") ^ popupPosition.isInverted;
 return toTheTop ? 1 : -1;
}
function _aspxIsVerticalScrollExists() {
 return _aspxGetDocumentHeight() > _aspxGetDocumentClientHeight() || __aspxIE && __aspxBrowserVersion < 8;
}
var _aspxBodyScrollHelper = (function () {
 var hideBodyScrollCount = 0;
 function fixScrollsBug() {
  var scrollTop = document.body.scrollTop;
  var scrollLeft = document.body.scrollLeft;
  document.body.scrollTop ++;
  document.body.scrollTop --;
  document.body.scrollLeft ++;
  document.body.scrollLeft --;
  document.body.scrollLeft = scrollLeft;
  document.body.scrollTop = scrollTop;
 }
 return {
  HideBodyScroll: function() {
   hideBodyScrollCount++;
   if(hideBodyScrollCount > 1) 
    return;
   if(__aspxIE) {
    _aspxChangeAttribute(document.body, "scroll", "no");
    _aspxChangeStyleAttribute(document.documentElement, "overflow", "hidden");
   } else if(__aspxFirefox && __aspxBrowserVersion < 3) { 
    var scrollTop = document.documentElement.scrollTop;
    _aspxChangeStyleAttribute(document.body, "overflow", "hidden");
    document.documentElement.scrollTop = scrollTop;
   } else {
    _aspxChangeStyleAttribute(document.documentElement, "overflow", "hidden");
    var documentHeight = _aspxGetDocumentHeight();
    var documentWidth = _aspxGetDocumentWidth();
    if(window.pageYOffset > 0 && _aspxPxToInt(window.getComputedStyle(document.body, null)) != documentHeight)
     _aspxChangeStyleAttribute(document.body, "height", documentHeight + "px");
    if(window.pageXOffset > 0 && _aspxPxToInt(window.getComputedStyle(document.body, null)) != documentWidth)
     _aspxChangeStyleAttribute(document.body, "width", documentWidth + "px");
    if(__aspxChrome) {
     fixScrollsBug();
    } 
   }
   if(_aspxIsVerticalScrollExists())
    _aspxChangeStyleAttribute(document.body, "margin-right", _aspxGetVerticalScrollBarWidth() + "px");
   if(__aspxIE && __aspxBrowserVersion == 7)
    _aspxWindowResizedByBodyScrollToggle();
  },
  RestoreBodyScroll: function() {
   hideBodyScrollCount--;
   if(hideBodyScrollCount > 0) 
    return;
   if(__aspxIE) {
    _aspxRestoreAttribute(document.body, "scroll");
    _aspxRestoreStyleAttribute(document.documentElement, "overflow");
   } else {
    _aspxRestoreStyleAttribute(document.documentElement, "overflow");
   }
   _aspxRestoreStyleAttribute(document.body, "margin-right");
   _aspxRestoreStyleAttribute(document.body, "height");
   _aspxRestoreStyleAttribute(document.body, "width");
   if(__aspxWebKitFamily) { 
    fixScrollsBug();
   }
   if(__aspxIE && __aspxBrowserVersion == 7)
    _aspxWindowResizedByBodyScrollToggle();
  }
 }
})();
function _aspxWindowResizedByBodyScrollToggle() { 
 if(aspxGetPopupControlCollection)
  aspxGetPopupControlCollection().LockWindowResizeByBodyScrollVisibilityChanging();
 var docWidth = document.documentElement.clientWidth; 
 if(aspxGetPopupControlCollection)
  aspxGetPopupControlCollection().UnlockWindowResizeByBodyScrollVisibilityChanging();
}
function _aspxCoordinatesInDocumentRect(x, y){
 var docScrollLeft = _aspxGetDocumentScrollLeft();
 var docScrollTop = _aspxGetDocumentScrollTop();
 return (x > docScrollLeft && y > docScrollTop && 
  x < _aspxGetDocumentClientWidth() + docScrollLeft && 
  y < _aspxGetDocumentClientHeight() + docScrollTop);
}
function _aspxGetElementZIndexArray(element){  
 var currentElement = element;
 var zIndexesArray = [0];
 while(currentElement && currentElement.tagName != "BODY") {
  if(currentElement.style) {
   if(typeof(currentElement.style.zIndex) != "undefined" && currentElement.style.zIndex != "")
    zIndexesArray.unshift(currentElement.style.zIndex);
  }
  currentElement = currentElement.parentNode;
 }
 return zIndexesArray;   
}
function _aspxIsHigher(higherZIndexArrat, zIndexArray){
 if (zIndexArray == null) return true;
 var count = (higherZIndexArrat.length >= zIndexArray.length) ? higherZIndexArrat.length : zIndexArray.length;
 for (var i = 0; i < count; i++) 
    if(typeof(higherZIndexArrat[i]) != "undefined" && typeof(zIndexArray[i]) != "undefined"){
    if (higherZIndexArrat[i] != zIndexArray[i]) return higherZIndexArrat[i] > zIndexArray[i];   
    } else return typeof(zIndexArray[i]) == "undefined";  
 return true;   
}
function _aspxTestIsPopupElement(element) {
 return !!element.DXPopupElementControl;
}
var _aspxClientOverControlUtils = {
 GetPopupElementByEvt: function(evt) {
  return _aspxFindEventSourceParentByTestFunc(evt, _aspxTestIsPopupElement);
 },
 OnMouseEvent: function (evt, mouseOver) {
  var popupElement = _aspxClientOverControlUtils.GetPopupElementByEvt(evt);
  if (mouseOver) 
   popupElement.DXPopupElementControl.OnPopupElementMouseOver(evt, popupElement);
  else 
   popupElement.DXPopupElementControl.OnPopupElementMouseOut(evt, popupElement);
 },
 OnMouseOut: function(evt) {
  _aspxClientOverControlUtils.OnMouseEvent(evt, false);
 },
 OnMouseOver: function(evt) {
  _aspxClientOverControlUtils.OnMouseEvent(evt, true);
 }
}
