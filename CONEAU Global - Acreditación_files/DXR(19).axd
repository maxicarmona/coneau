ASPxClientPopupMenu = _aspxCreateClass(ASPxClientMenuBase, {
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.skipNextPEMouseOutBeforePEMouseOver = false; 
  this.cursorOverPopupElement = false;
  this.isPopupMenu = true;
  this.closeAction = "OuterMouseClick";
  this.popupAction = "RightMouseClick";
  this.popupElementIDList = [ ];
  this.popupElementList = [ ];
  this.lastUsedPopupElementInfo = { };
  this.popupHorizontalOffset = 0;
  this.popupVerticalOffset = 0;
  this.popupHorizontalAlign = __aspxNotSetAlignIndicator;
  this.popupVerticalAlign = __aspxNotSetAlignIndicator;
  this.left = 0;
  this.top = 0;
 },
 Initialize: function() {
  this.PopulatePopupElements();
  ASPxClientMenuBase.prototype.Initialize.call(this);
 },
 SetPopupElementReference: function(popupElement, popupElementIndex, attach) {
  if(!_aspxIsExistsElement(popupElement)) return;
  var setReferenceFunction = attach ? _aspxAttachEventToElement : _aspxDetachEventFromElement;
  if(this.closeAction == "MouseOut" || this.popupAction == "MouseOver") {
   setReferenceFunction(popupElement, "mouseover", _aspxClientOverControlUtils.OnMouseOver);
   setReferenceFunction(popupElement, "mouseout",  _aspxClientOverControlUtils.OnMouseOut);
  }
  if(this.popupAction == "RightMouseClick")
   setReferenceFunction(popupElement, "contextmenu", aspxPMOnMouseUp);
  else if(this.popupAction == "LeftMouseClick")
   setReferenceFunction(popupElement, "mouseup", aspxPMOnMouseUp);
  if(attach) {
   popupElement.DXPopupElementControl = this;
   popupElement.DXPopupElementIndex = popupElementIndex;
  }else
   popupElement.DXPopupElementControl = popupElement.DXPopupElementIndex = undefined;
 },
 GetPopupElement: function (indexPopupElement) {
  var popupElement = this.popupElementList[indexPopupElement];
  return popupElement ? popupElement : null;
 },
 GetLastShownPopupElementIndex: function() {
  return _aspxGetDefinedValue(this.lastUsedPopupElementInfo.shownPEIndex, 0);
 },
 SetLastShownPopupElementIndex: function(popupElementIndex) {
  this.lastUsedPopupElementInfo.shownPEIndex = popupElementIndex;
 },
 GetLastOverPopupElementIndex: function() {
  return _aspxGetDefinedValue(this.lastUsedPopupElementInfo.overPEIndex, -1);
 },
 SetLastOverPopupElementIndex: function(popupElementIndex) {
  this.lastUsedPopupElementInfo.overPEIndex = popupElementIndex;
 },
 PopulatePopupElements: function() {
  var ids = this.popupElementIDList;
  for(var i = 0; i < ids.length; i++) {
   var popupElement = _aspxFindPopupElementById(ids[i]);
   if(popupElement)
    this.AddPopupElement(popupElement);
  }
 },
 AddPopupElement: function(popupElement) {
  var popupElementIndex = this.AddPopupElementInternal(popupElement);
  this.SetPopupElementReference(popupElement, popupElementIndex, true);
 },
 RemovePopupElement: function(popupElement) {
  this.RemovePopupElementInternal(popupElement);
  this.SetPopupElementReference(popupElement, null, false);
 },
 AddPopupElementInternal: function(element) {
  for(var i = 0; i < this.popupElementList.length; i++) {
   if(!this.popupElementList[i]) {
    this.popupElementList[i] = element;
    return i;
   }
  }
  this.popupElementList.push(element);
  return this.popupElementList.length - 1;
 },
 RemovePopupElementInternal: function(element) {
  for(var i = 0; i < this.popupElementList.length; i++) {
   if(this.popupElementList[i] == element) {
    this.popupElementList[i] = null;
    return;
   }
  }
 },
 RemoveAllPopupElements: function() {
  for(var i = 0; i < this.popupElementList.length; i++)
   this.RemovePopupElement(this.popupElementList[i]);
 },
 IsMenuVisible: function(){
  var element = this.GetMainElement();
  return (element != null) ? _aspxGetElementDisplay(element) : false;
 },
 IsVisible: function() {
  return this.isShowing || this.IsMenuVisible();
 },
 IsParentElementPositionStatic: function(indexPath){
  return false;
 },
 GetClientSubMenuPos: function(element, indexPath, pos, isXPos){
  if (indexPath == "") {
   var popupPosition = null;
   if (isXPos){
    popupPosition = _aspxGetPopupAbsoluteX(this.GetMenuMainCell(this.GetMainElement()),
     __aspxPopupShadowWidth, this.GetPopupElement(this.GetLastShownPopupElementIndex()), this.popupHorizontalAlign, this.popupHorizontalOffset, pos, this.left, this.rtl);
   }
   else{
    popupPosition = _aspxGetPopupAbsoluteY(this.GetMenuMainCell(this.GetMainElement()),
     __aspxPopupShadowHeight, this.GetPopupElement(this.GetLastShownPopupElementIndex()), this.popupVerticalAlign, this.popupVerticalOffset, pos, this.top);
   }
   popupPosition.position -= _aspxGetPositionElementOffset(element, isXPos);
   return popupPosition;
  }
  return ASPxClientMenuBase.prototype.GetClientSubMenuPos.call(this, element, indexPath, pos, isXPos);
 },
 GetMenuElement: function(indexPath){
  if (indexPath == "")
   return this.GetMainElement();
  return ASPxClientMenuBase.prototype.GetMenuElement.call(this, indexPath);
 },
 OnItemOverTimer: function(indexPath){
  aspxGetMenuCollection().ClearCurrentShowingPopupMenuName();
  if(indexPath == ""){
   aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
   aspxGetMenuCollection().DoShowAtCurrentPos(this.name, indexPath);
  }
  else
   ASPxClientMenuBase.prototype.OnItemOverTimer.call(this, indexPath);
 },
 DoShow: function(x, y){
  var element = this.GetMainElement();
  if(element != null && !_aspxGetElementDisplay(element)){
   aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
   this.isShowing = true;
   this.DoShowPopupMenu(element, x, y, "");
   this.isShowing = false;
  }
 },
 ShowPopupSubMenuAfterCallback: function(element, callbackResult) { 
  this.SetSubMenuInnerHtml(element, callbackResult);
  var indexPath = this.GetIndexPathById(element.id, true);
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) {
   element.style.height = "";
   this.PrepareScrolling(element, scrollHelper, _aspxPxToInt(element.style.top));
  }
  aspxGetControlCollection().AdjustControls(element);
 },
 WrongEventOrderOperaHack: function(){
  this.skipNextPEMouseOutBeforePEMouseOver = true;
 },
 WrongEventOrderOperaRollBack: function(){
  this.skipNextPEMouseOutBeforePEMouseOver = false;
 },
 OnAfterItemOver: function(hoverItem, hoverElement) {
  var afterItemOverAllowed = ASPxClientMenuBase.prototype.AfterItemOverAllowed(this, hoverItem);
  if(afterItemOverAllowed) {
   this.WrongEventOrderOperaHack();
   ASPxClientMenuBase.prototype.OnAfterItemOver.call(this, hoverItem, hoverElement); 
  }
 },
 OnPopupElementMouseOver: function(evt, popupElement) {
  if(popupElement != null) {
   if(popupElement.DXPopupElementIndex == this.GetLastShownPopupElementIndex())
    this.cursorOverPopupElement = true
   this.WrongEventOrderOperaRollBack();
   if(this.popupAction == "MouseOver") {
    var isVisible = this.IsMenuVisible();
    if(popupElement.DXPopupElementIndex != this.GetLastOverPopupElementIndex()) {
     this.ClearDisappearTimer();
     this.ClearAppearTimer();
     if(isVisible) {
      this.Hide();
      isVisible = false;
     }
    }
    if(!isVisible) {
     aspxGetMenuCollection().SetCurrentShowingPopupMenuName(this.name);
     this.ShowInternal(evt, popupElement.DXPopupElementIndex);
    }
    this.SetLastOverPopupElementIndex(popupElement.DXPopupElementIndex);
   }
  }
 },
 OnPopupElementMouseOut: function(evt, popupElement) {
   if (popupElement != null) {
   aspxGetMenuCollection().ClearCurrentShowingPopupMenuName();
   this.cursorOverPopupElement = false;
   if(!this.IsMenuVisible()) 
    this.ClearAppearTimer();
   else if (!this.skipNextPEMouseOutBeforePEMouseOver) 
    this.SetDisappearTimer();
   }
 },
 DoShowPopupMenuBorderCorrector: function(element, x, y, indexPath, toTheLeft, toTheTop){
  if (indexPath != "")
   ASPxClientMenuBase.prototype.DoShowPopupMenuBorderCorrector.call(this, element, x, y, indexPath, toTheLeft, toTheTop);
 },
 ShowInternal: function(evt, popupElementIndex) {
  this.SetLastShownPopupElementIndex(popupElementIndex);
  var x = _aspxGetEventX(evt);
  var y = _aspxGetEventY(evt);
  if (evt.type == "mouseover")
   aspxGetMenuCollection().SetAppearTimer(this.name, "", this.appearAfter);
  else
   this.DoShow(x, y);
 },
 GetAnimationHorizontalDirection: function(indexPath, popupPosition){
  if (this.GetMenuLevel(indexPath) == 0)
   return _aspxGetAnimationHorizontalDirection(popupPosition, this.popupHorizontalAlign, this.popupVerticalAlign, this.rtl);
  else 
   return popupPosition.isInverted ? 1 : -1;
 },
 GetAnimationVerticalDirection: function(indexPath, popupPosition){
  if (this.GetMenuLevel(indexPath) == 0)
   return _aspxGetAnimationVerticalDirection(popupPosition, this.popupHorizontalAlign, this.popupVerticalAlign);
  else 
   return 0;
 },
 OnHideByItemOut: function(){
  if(this.closeAction == "MouseOut" && !this.cursorOverPopupElement)
   this.Hide();
  else
   ASPxClientMenuBase.prototype.OnHideByItemOut.call(this);
 },
 SetPopupElementID: function(popupElementId) {
  this.RemoveAllPopupElements();
  this.popupElementIDList = popupElementId.split(';');
  if(this.closeAction == "MouseOut") {
   this.ClearDisappearTimer();
   this.Hide();
  }
  this.PopulatePopupElements();
  this.WrongEventOrderOperaRollBack();
 },
 GetCurrentPopupElementIndex: function() {
  var popupElement = this.GetCurrentPopupElement();
  return popupElement ? popupElement.DXPopupElementIndex : -1;
 },
 GetCurrentPopupElement: function() {
  var popupElement = this.GetPopupElement(this.GetLastShownPopupElementIndex());
  if(popupElement && popupElement.DXPopupElementControl)
   return popupElement;
  return null;
 },
 RefreshPopupElementConnection: function(){
  this.RemoveAllPopupElements();
  this.PopulatePopupElements();
 },
 Hide: function(){
  aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
 },
 Show: function(popupElementIndex){
  if(this.GetPopupElement(popupElementIndex) != null)
   this.SetLastShownPopupElementIndex(popupElementIndex);
  this.DoShow(__aspxInvalidPosition, __aspxInvalidPosition);
 },
 ShowAtElement: function(htmlElement){
  this.SetLastShownPopupElementIndex(this.AddPopupElementInternal(htmlElement));
  this.DoShow(__aspxInvalidPosition, __aspxInvalidPosition);
  this.RemovePopupElementInternal(htmlElement);
 },
 ShowAtElementByID: function(id){
  var htmlElement = document.getElementById(id);
  this.ShowAtElement(htmlElement);
 },
 ShowAtPos: function(x, y){
  var lastIndexBackup = this.GetLastShownPopupElementIndex();
  this.SetLastShownPopupElementIndex(-1);
  this.DoShow(x, y);
  this.SetLastShownPopupElementIndex(lastIndexBackup);
 },
 GetVisible: function(){
  return this.IsMenuVisible();
 },
 SetVisible: function(visible){
  if(visible && !this.IsMenuVisible())
   this.Show();
  else if(!visible && this.IsMenuVisible())
   this.Hide();
 }
});
ASPxClientPopupMenu.Cast = ASPxClientControl.Cast;
function aspxPMOnMouseUp(evt, element){
 var element = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupMenuElement);
 if(element == null || !element.DXPopupElementControl.isPopupMenu)
  return;
 if(element.DXPopupElementControl.popupAction == "RightMouseClick")
  _aspxPreventContextMenu(evt);
 aspxGetMenuCollection().ClearDisappearTimer();
 element.DXPopupElementControl.ShowInternal(evt, element.DXPopupElementIndex);
 return _aspxCancelBubble(evt);
}
function aspxTestPopupMenuElement(element){
 return !!element.DXPopupElementControl;
}
_aspxAttachEventToDocument("mousemove", aspxPopupMenuDocumentMouseMove);
function aspxPopupMenuDocumentMouseMove(evt){
 var element = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupMenuElement);
 if(element != null)
  aspxGetMenuCollection().SaveCurrentMouseOverPos(evt, element);
}

