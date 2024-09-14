ASPxClientNavBar = _aspxCreateClass(ASPxClientControl, {
 GROUP_TEXT_CLASSNAME: 'dxnb-ghtext',
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.animationOffset = 10;
  this.animationDelay = 10;
  this.animationMaxDelay = 400;
  this.autoCollapse = false;
  this.allowExpanding = true;
  this.allowSelectItem = false;
  this.cookieName = "";
  this.groupCount = 0;
  this.enableAnimation = false;
  this.groups = [];
  this.groupsExpanding = [];
  this.groupsExpandingRequest = [];
  this.mouseOverActionDelay = 300;
  this.mouseOverActionTimerID = -1;
  this.liteRender = false;
  this.ItemClick = new ASPxClientEvent();
  this.ExpandedChanged = new ASPxClientEvent();
  this.ExpandedChanging = new ASPxClientEvent();
  this.HeaderClick = new ASPxClientEvent();
 },
 InlineInitialize: function() {
  if(this.liteRender)
   this.AssignControlElementAttributes();
  this.InitializeSelectedItem();
  this.InitializeEnabledAndVisible();
 },
 InitializeEnabledAndVisible: function() {
  for(var i = 0; i < this.groups.length; i++) {
   var group = this.groups[i];
   for(var j = 0; j < group.items.length; j++) {
    this.SetItemEnabled(i, j, group.items[j].clientEnabled, true);
    this.SetItemVisible(i, j, group.items[j].clientVisible, true);
   }
   this.SetGroupVisible(i, group.clientVisible, true);
  }
 },
 InitializeSelectedItem: function() {
  if(!this.allowSelectItem) return;
  this.SelectItem(this.GetSelectedItemIndexPath());
 },
 InitializeCallBackData: function() {
  for(var i = 0; i < this.GetGroupCountCore(); i++) {
   if(this.groupsExpanding[i]) {
    var element = this.GetGroupContentElement(i);
    if(element != null) element.loaded = true;
   }
  }
 },
 GetClickableGroupHeaderElement: function(index) {
  var isDisplayed = false;
  var element = this.GetGroupHeaderExpandedElement(index);
  if(element != null) isDisplayed = !_aspxGetElementDisplay(element) || !this.allowExpanding;
  if(!isDisplayed)
   element = this.GetGroupHeaderCollapsedElement(index);
  return element;
 },
 AssignControlElementAttributes: function() {
  var disabledCssClass = "dxnbLiteDisabled";
  var mainElement = this.GetMainElement();
  if(mainElement.style.width && mainElement.style.width.indexOf('%') < 0) {
   mainElement.style.width = _aspxPxToInt(mainElement.style.width) -
    _aspxGetLeftRightBordersAndPaddingsSummaryValue(mainElement) + 'px';
  }
  if(_aspxElementCssClassContains(mainElement, disabledCssClass)) return;
  var groups = _aspxGetElementNodes(mainElement);
  var groupIndex = 0;
  for(var i = 0; i < groups.length; i++) {
   while(!this.groups[groupIndex].visible)
    groupIndex++;
   if(_aspxElementHasCssClass(groups[i], disabledCssClass))
    continue;
   this.AssignGroupAttributes(groups[i], groupIndex);
   groupIndex++;
  }
 },
 AssignGroupAttributes: function(group, groupIndex) {
  var headers = _aspxGetChildrenByPartialClassName(group, "dxnb-header");
  for(var i = 0; i < headers.length; i++) {
   if(headers[i].id)
    continue;
   headers[i].id = this.PrepareElementID(this.GetGroupHeaderElementID(groupIndex, headers[i].className.indexOf("Collapsed") == -1));
   aspxAssignAccessabilityEventsToChildrenLinks(headers[i]);
  }
  this.AssignGroupContentAttributes(_aspxGetChildrenByPartialClassName(group, "dxnb-content")[0], groupIndex);
 },
 AssignGroupContentAttributes: function(content, groupIndex) {
  if(!content) return;
  content.id = this.PrepareElementID(this.GetGroupContentElementID(groupIndex));
  if(content.tagName == "UL") {
   var items = _aspxGetElementNodes(content);
   var itemIndex = 0;
   var group = this.groups[groupIndex];
   for(var i = 0; i < items.length; i++) {
    while(!group.items[itemIndex].visible)
     itemIndex++;
    this.AssignItemAttributes(items[i], this.GetIndexPath(groupIndex, itemIndex));
    itemIndex++;
   }
  }
 },
 AssignItemAttributes: function(item, indexPath) {
  item.id = this.PrepareElementID(this.GetItemElementID(indexPath));
  aspxAssignAccessabilityEventsToChildrenLinks(item);
  if(_aspxElementCssClassContains(item, "dxnb-tmpl")) return;
  var itemImg = _aspxGetChildrenByPartialClassName(item, "dxnb-img")[0];
  if(itemImg)
   itemImg.id = this.PrepareElementID(this.GetItemImageID(indexPath));
 },
 PrepareElementID: function(id) {
  return this.name + id;
 },
 GetGroupHeaderElementID: function(index, expanded) {
  return "_GH" + (expanded ? "E" : "C") + index;
 },
 GetGroupContentElementID: function(index) {
  return "_GC" + index;
 },
 GetItemElementID: function(indexPath) {
  return "_I" + indexPath + "_";
 },
 GetItemImageID: function(indexPath) {
  return this.GetItemElementID(indexPath) + "Img";
 },
 GetGroupHeaderExpandedElement: function(index) {
  return this.GetChild(this.GetGroupHeaderElementID(index, true));
 },
 GetGroupHeaderCollapsedElement: function(index) {
  return this.GetChild(this.GetGroupHeaderElementID(index, false));
 },
 GetGroupContentElement: function(index) {
  return this.GetChild(this.GetGroupContentElementID(index));
 },
 GetGroupContentAnimationElement: function(index) {
  if(this.liteRender)
   return this.GetGroupContentElement(index);
  return this.GetChild("_GCA" + index);
 },
 GetRowElement: function(cellElement) {
  return cellElement.parentNode;
 },
 GetItemElement: function(groupIndex, itemIndex) {
  return this.GetItemElementByIndexPath(this.GetIndexPath(groupIndex, itemIndex));
 },
 GetItemSeparatorElement: function(groupIndex, itemIndex) {
  return this.GetChild("_I" + this.GetIndexPath(groupIndex, itemIndex) + "S");
 },
 GetItemElementByIndexPath: function(indexPath) {
  return this.GetChild(this.GetItemElementID(indexPath));
 },
 GetItemTextElementByIndexPath: function(indexPath) {
  return this.GetChild(this.GetItemElementID(indexPath) + "T");
 },
 GetItemImageElementByIndexPath: function(indexPath) {
  return this.GetChild(this.GetItemElementID(indexPath) + "I");
 },
 GetGroupRow: function(groupIndex) {
  if(this.liteRender) {
   return _aspxGetElementNodes(this.GetMainElement())[groupIndex];
  }
  return this.GetChild("_GR" + groupIndex);
 },
 GetGroupSeparatorRow: function(groupIndex) {
  return this.GetChild("_GSR" + groupIndex);
 },
 GetGroupStateInputElement: function(index) {
  return _aspxGetElementById(this.name + "GS");
 },
 GetSelectedItemInputElement: function() {
  return _aspxGetElementById(this.name + "SI");
 },
 DoItemClick: function(groupIndex, itemIndex, hasItemLink, htmlEvent) {
  var processOnServer = this.RaiseItemClick(groupIndex, itemIndex, htmlEvent);
  if(processOnServer && !hasItemLink)
   this.SendPostBack("CLICK:" + this.GetIndexPath(groupIndex, itemIndex));
 },
 GetAutoCollapseCoGroupIndex: function(groupIndex) {
  if(this.autoCollapse) {
   for(var i = 0; i < this.GetGroupCountCore(); i++) {
    if(i != groupIndex && this.groupsExpanding[i])
     return i;
   }
  }
  return -1;
 },
 SetExpandedInternal: function(groupIndex, expanded) {
  if(expanded == this.groupsExpanding[groupIndex]) return;
  var processingMode = this.RaiseExpandedChanging(groupIndex);
  if(processingMode == "Client") {
   if(expanded || !this.autoCollapse)
    this.ChangeExpanding(groupIndex, expanded);
  }
  else if(processingMode == "Server")
   this.SendPostBack("EXPAND:" + groupIndex);
 },
 ChangeExpanding: function(groupIndex, expanded) {
  var element = this.GetGroupContentElement(groupIndex);
  var autoCollapseCoGroupIndex = this.GetAutoCollapseCoGroupIndex(groupIndex);
  if(expanded && _aspxIsFunction(this.callBack) && element != null && !element.loaded) {
   this.DoChangeExpanding(groupIndex, autoCollapseCoGroupIndex, expanded, false, false, true);
   if(!element.loading) {
    element.loading = true;
    this.groupsExpandingRequest.push(groupIndex);
    this.ShowLoadingPanelInGroup(groupIndex);
    this.CreateCallback(groupIndex);
   }
  }
  else
   this.DoChangeExpanding(groupIndex, autoCollapseCoGroupIndex, expanded, this.enableAnimation, true, true);
 },
 DoChangeExpanding: function(groupIndex, autoCollapseCoGroupIndex, expanded, doAnimation, raiseChangedEvent, raiseCoGroupChangedEvent) {
  this.ChangeGroupExpandState(groupIndex, expanded);
  if(autoCollapseCoGroupIndex > -1)
   this.ChangeGroupExpandState(autoCollapseCoGroupIndex, !expanded);
  if(doAnimation) {
   var element = this.GetGroupContentAnimationElement(groupIndex);
   if(element != null) {
    var controlHeight = this.GetMainElement().offsetHeight;
    this.PrepareGroupElementsForAnimation(groupIndex, expanded, 0);
    if(autoCollapseCoGroupIndex > -1) {
     var heightDelta = controlHeight - this.GetMainElement().offsetHeight;
     this.PrepareGroupElementsForAnimation(autoCollapseCoGroupIndex, !expanded, heightDelta);
    }
    element.expanding = expanded;
    element.animationCount = 1;
    element.animationStart = new Date();
    element.autoCollapseCoGroupIndex = autoCollapseCoGroupIndex;
    element.timerID = window.setTimeout("aspxNBAnimT(\"" + this.name + "\", " + groupIndex + ")", this.animationDelay);
    return;
   }
  }
  this.ChangeGroupElementsExpandState(groupIndex, expanded);
  if(autoCollapseCoGroupIndex > -1)
   this.ChangeGroupElementsExpandState(autoCollapseCoGroupIndex, !expanded);
  if(raiseCoGroupChangedEvent && autoCollapseCoGroupIndex > -1)
   this.RaiseExpandedChanged(autoCollapseCoGroupIndex);
  if(raiseChangedEvent)
   this.RaiseExpandedChanged(groupIndex);
 },
 PrepareGroupElementsForAnimation: function(groupIndex, expanding, heightCorrection) {
  var element = this.GetGroupContentAnimationElement(groupIndex);
  var contentElement = this.GetGroupContentElement(groupIndex);
  if(element == null || contentElement == null) return;
  element.style.overflow = "hidden";
  if(expanding) {
   element.originalHeight = this.GetGroupContentAnimationElementHeight(element);
   element.style.height = "0px";
   this.SetGroupElementDisplay(contentElement, true);
   if(__aspxNetscapeFamily && !__aspxFirefox) {
    var innerElement = _aspxGetChildByTagName(element, "TABLE", 0);
    if(innerElement != null)
     element.style.width = innerElement.offsetWidth + "px";
    else {
     innerElement = _aspxGetChildByTagName(element, "UL", 0);
     if(innerElement != null)
      element.style.width = element.clientWidth + "px";
    }
   }
  }
  else {
   var height = element.offsetHeight + heightCorrection;
   if(height >= 0)
    _aspxSetOffsetHeight(element, height);
  }
 },
 GetGroupContentAnimationElementHeight: function(animationElement) {
  var container = this.liteRender ? animationElement : animationElement.parentNode.parentNode;
  var dispaly = container.style.display;
  container.style.display = "";
  var height = animationElement.offsetHeight;
  container.style.display = dispaly;
  return height;
 },
 ChangeGroupExpandState: function(groupIndex, expanded) {
  this.groupsExpanding[groupIndex] = expanded;
  this.UpdateGroupStateInputElement();
  this.UpdateGroupStateCookie();
 },
 ChangeGroupElementsExpandState: function(groupIndex, expanded) {
  this.SetGroupElementDisplay(this.GetGroupContentElement(groupIndex), expanded);
  this.SetGroupElementDisplay(this.GetGroupHeaderExpandedElement(groupIndex), expanded);
  this.SetGroupElementDisplay(this.GetGroupHeaderCollapsedElement(groupIndex), !expanded);
  if(expanded)
   aspxGetControlCollection().AdjustControls(this.GetGroupContentElement(groupIndex), __aspxCheckSizeCorrectedFlag);
 },
 SetGroupElementDisplay: function(groupElement, value) {
  if(groupElement == null) return;
  if(this.liteRender == false) groupElement = this.GetRowElement(groupElement);
  _aspxSetElementDisplay(groupElement, value);
 },
 GetGroupCountCore: function() {
  return (this.groups.length > 0) ? this.groups.length : this.groupCount;
 },
 GetIndexPath: function(groupIndex, itemIndex) {
  return (groupIndex != -1 && itemIndex != -1) ? groupIndex + __aspxItemIndexSeparator + itemIndex : "";
 },
 GetGroupIndex: function(indexPath) {
  var indexes = indexPath.split(__aspxItemIndexSeparator);
  return (indexes.length > 0) ? indexes[0] : -1;
 },
 GetItemIndex: function(indexPath) {
  var indexes = indexPath.split(__aspxItemIndexSeparator);
  return (indexes.length > 1) ? indexes[1] : -1;
 },
 GetGroupState: function() {
  var state = "";
  for(var i = 0; i < this.GetGroupCountCore(); i++) {
   state += this.groupsExpanding[i] ? "1" : "0";
   if(i < this.GetGroupCountCore() - 1) state += ";";
  }
  return state;
 },
 UpdateGroupStateCookie: function() {
  if(this.cookieName == "") return;
  _aspxDelCookie(this.cookieName);
  _aspxSetCookie(this.cookieName, this.GetGroupState());
 },
 UpdateGroupStateInputElement: function() {
  var element = this.GetGroupStateInputElement();
  if(element != null) element.value = this.GetGroupState();
 },
 SelectItem: function(indexPath) {
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetSelectingItemElement(indexPath);
  if(element != null) aspxGetStateController().SelectElementBySrcElement(element);
 },
 DeselectItem: function(indexPath) {
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetSelectingItemElement(indexPath);
  if(element != null) aspxGetStateController().DeselectElementBySrcElement(element);
 },
 GetSelectingItemElement: function(indexPath) {
  return this.liteRender ? this.GetItemElementByIndexPath(indexPath) : this.GetItemTextElementByIndexPath(indexPath);
 },
 GetSelectedItemIndexPath: function() {
  var inputElement = this.GetSelectedItemInputElement();
  if(inputElement != null)
   return inputElement.value;
  return "";
 },
 SetSelectedItemInternal: function(groupIndex, itemIndex) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  if(this.allowSelectItem) {
   var inputElement = this.GetSelectedItemInputElement();
   if(inputElement != null) {
    this.DeselectItem(inputElement.value);
    inputElement.value = indexPath;
    var group = this.GetGroup(groupIndex);
    var item = group ? group.GetItem(itemIndex) : null;
    if(item == null || item.GetEnabled())
     this.SelectItem(inputElement.value);
   }
  }
 },
 OnAnimationTimer: function(groupIndex) {
  var element = this.GetGroupContentAnimationElement(groupIndex);
  if(element != null) {
   window.clearTimeout(element.timerID);
   var autoCollapseCoGroupIndex = element.autoCollapseCoGroupIndex;
   var animationOffset = this.animationOffset * element.animationCount;
   var height = element.offsetHeight + (element.expanding ? animationOffset : -animationOffset);
   var finished = (element.expanding ? (height >= element.originalHeight) : (height <= 0)) ||
    (new Date() - element.animationStart > this.animationMaxDelay);
   if(finished) {
    this.ChangeGroupElementsExpandState(groupIndex, element.expanding);
    if(autoCollapseCoGroupIndex > -1)
     this.ChangeGroupElementsExpandState(autoCollapseCoGroupIndex, !element.expanding);
    element.style.overflow = "";
    element.style.height = "";
    element.style.width = "";
    element.originalHeight = "";
    if(autoCollapseCoGroupIndex > -1) {
     var coGroupAnimationElement = this.GetGroupContentAnimationElement(autoCollapseCoGroupIndex);
     if(coGroupAnimationElement) coGroupAnimationElement.style.height = "";
     this.RaiseExpandedChanged(autoCollapseCoGroupIndex);
    }
    this.RaiseExpandedChanged(groupIndex);
   }
   else {
    _aspxSetOffsetHeight(element, height);
    if(autoCollapseCoGroupIndex > -1) {
     var coGroupElement = this.GetGroupContentAnimationElement(autoCollapseCoGroupIndex);
     if(coGroupElement != null) {
      var coGroupHeight = coGroupElement.offsetHeight + (!element.expanding ? animationOffset : -animationOffset);
      if(coGroupHeight <= 0) coGroupHeight = 1;
      coGroupElement.style.height = coGroupHeight + "px";
     }
    }
    element.animationCount++;
    element.timerID = window.setTimeout("aspxNBAnimT(\"" + this.name + "\", " + groupIndex + ")", this.animationDelay);
   }
  }
 },
 OnHeaderClick: function(groupIndex, evt) {
  this.ClearMouseMoverTimer();
  var processingMode = this.RaiseHeaderClick(groupIndex, evt);
  var linkElement = (evt != null) ? _aspxGetParentByTagName(_aspxGetEventSource(evt), "A") : null;
  if(linkElement == null || linkElement.href == __aspxAccessibilityEmptyUrl) {
   if(processingMode == "Client" && this.allowExpanding) {
    var expanded = this.groupsExpanding[groupIndex];
    this.SetExpandedInternal(groupIndex, !expanded);
    if(evt != null)
     aspxUpdateHoverState(evt);
   }
   else if(processingMode == "Server")
    this.SendPostBack("HEADERCLICK:" + groupIndex);
  }
 },
 OnHeaderMouseMove: function(groupIndex, evt) {
  if(ASPxClientNavBar.MouseOverActiveNavBar != this || ASPxClientNavBar.MouseOverActiveGroupIndex != groupIndex) {
   ASPxClientNavBar.MouseOverActiveNavBar = this;
   ASPxClientNavBar.MouseOverActiveGroupIndex = groupIndex;
   this.ClearMouseMoverTimer();
   this.mouseOverActionTimerID = _aspxSetTimeout("aspxNBHMMoveTimer(\"" + this.name + "\", " + groupIndex + ");", this.mouseOverActionDelay);
  }
 },
 OnHeaderMouseMoveTimer: function(groupIndex) {
  this.ClearMouseMoverTimer();
  if(ASPxClientNavBar.MouseOverActiveNavBar == this || ASPxClientNavBar.MouseOverActiveGroupIndex == groupIndex)
   this.OnHeaderClick(groupIndex, null)
 },
 ClearMouseMoverTimer: function() {
  if(this.mouseOverActionTimerID > -1) {
   _aspxClearTimer(this.mouseOverActionTimerID);
   this.mouseOverActionTimerID = -1;
  }
 },
 OnItemClick: function(groupIndex, itemIndex, evt) {
  var element = this.GetItemElement(groupIndex, itemIndex);
  var clickedLinkElement = _aspxGetParentByTagName(_aspxGetEventSource(evt), "A");
  var isLinkClicked = (clickedLinkElement != null && clickedLinkElement.href != __aspxAccessibilityEmptyUrl);
  var linkElement = (element != null) ? _aspxGetChildByTagName(element, "A", 0) : null;
  if(linkElement != null && linkElement.href == __aspxAccessibilityEmptyUrl)
   linkElement = null;
  aspxClearHoverState();
  this.SetSelectedItemInternal(groupIndex, itemIndex);
  aspxUpdateHoverState(evt);
  this.DoItemClick(groupIndex, itemIndex, isLinkClicked || (linkElement != null), evt);
  if(!isLinkClicked && linkElement != null)
   _aspxNavigateByLink(linkElement);
 },
 OnCallback: function(result) {
  this.OnCallbackInternal(result.html, result.index, false);
 },
 OnCallbackError: function(result, data) {
  this.OnCallbackInternal(result, data, true);
 },
 OnCallbackInternal: function(html, index, isError) {
  this.SetCallbackContent(html, index, isError);
  _aspxArrayRemoveAt(this.groupsExpandingRequest, 0);
  if(this.enableCallbackAnimation)
   ASPxAnimationHelper.fadeIn(this.GetGroupContentElement(index).firstChild, function(){ this.OnCallbackFinish(index, isError); }.aspxBind(this));
  else
   this.OnCallbackFinish(index, isError);
 },
 OnCallbackFinish: function(index, isError) {
  if(!isError)
   this.RaiseExpandedChanged(index);
 },
 OnCallbackGeneralError: function(result) {
  var callbackGroupIndex = (this.groupsExpandingRequest.length > 0) ? this.groupsExpandingRequest[0] : 0;
  this.SetCallbackContent(result, callbackGroupIndex, true);
  _aspxArrayRemoveAt(this.groupsExpandingRequest, 0);
 },
 ShowLoadingPanelInGroup: function(groupIndex) {
  if(this.lpDelay > 0)
   _aspxSetTimeout(function() { this.ShowLoadingPanelInGroupCore(groupIndex); }.aspxBind(this), this.lpDelay); 
  else
   this.ShowLoadingPanelInGroupCore(groupIndex);
 },
 ShowLoadingPanelInGroupCore: function(groupIndex) {
  if(_aspxArrayIndexOf(this.groupsExpandingRequest, groupIndex) < 0) return;
  var element = this.GetGroupContentElement(groupIndex);
  this.CreateLoadingPanelInsideContainer(element);
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 },
 SetCallbackContent: function(html, index, isError) {
  var replaceGroupElement = this.liteRender && !isError;
  if(replaceGroupElement) {
   var groupElement = _aspxGetElementNodes(this.GetMainElement())[index];
   _aspxRemoveElement(this.GetGroupContentElement(index));
   _aspxSetInnerHtml(groupElement, groupElement.innerHTML + html);
   this.AssignGroupContentAttributes(this.GetGroupContentElement(index), index);
  }
  var element = this.GetGroupContentElement(index);
  if(element != null) {
   if(!replaceGroupElement)
    _aspxSetInnerHtml(element, html);
   if(!isError)
    element.loaded = true;
   element.loading = false;
  }
 },
 CreateGroups: function(groupsProperties) {
  for(var i = 0; i < groupsProperties.length; i++) {
   var groupName = groupsProperties[i][0] || "";
   var group = new ASPxClientNavBarGroup(this, i, groupName);
   if(_aspxIsExists(groupsProperties[i][1]))
    group.enabled = groupsProperties[i][1];
   if(_aspxIsExists(groupsProperties[i][2]))
    group.visible = groupsProperties[i][2];
   if(_aspxIsExists(groupsProperties[i][3]))
    group.clientVisible = groupsProperties[i][3];
   this.groups.push(group);
   group.CreateItems(groupsProperties[i][4]);
  }
 },
 RaiseItemClick: function(groupIndex, itemIndex, htmlEvent) {
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("ItemClick");
  if(!this.ItemClick.IsEmpty()) {
   var htmlElement = this.GetItemElement(groupIndex, itemIndex);
   var args = new ASPxClientNavBarItemEventArgs(processOnServer, this.GetGroup(groupIndex).GetItem(itemIndex), htmlElement, htmlEvent);
   this.ItemClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 RaiseExpandedChanged: function(groupIndex) {
  if(!this.ExpandedChanged.IsEmpty()) {
   var args = new ASPxClientNavBarGroupEventArgs(this.GetGroup(groupIndex));
   this.ExpandedChanged.FireEvent(this, args);
  }
 },
 RaiseExpandedChanging: function(groupIndex) {
  var processingMode = this.autoPostBack ? "Server" : "Client";
  if(!this.ExpandedChanging.IsEmpty()) {
   var args = new ASPxClientNavBarGroupCancelEventArgs(processingMode == "Server", this.GetGroup(groupIndex));
   this.ExpandedChanging.FireEvent(this, args);
   if(args.cancel)
    processingMode = "Handled";
   else
    processingMode = args.processOnServer ? "Server" : "Client";
  }
  return processingMode;
 },
 RaiseHeaderClick: function(groupIndex, htmlEvent) {
  var processingMode = this.autoPostBack || this.IsServerEventAssigned("HeaderClick") ? "Server" : "Client";
  if(!this.HeaderClick.IsEmpty()) {
   var htmlElement = this.GetClickableGroupHeaderElement(groupIndex);
   var args = new ASPxClientNavBarGroupClickEventArgs(processingMode == "Server", this.GetGroup(groupIndex), htmlElement, htmlEvent);
   this.HeaderClick.FireEvent(this, args);
   if(args.cancel)
    processingMode = "Handled";
   else
    processingMode = args.processOnServer ? "Server" : "Client";
  }
  return processingMode;
 },
 SetEnabled: function(enabled) {
  for(var i = this.GetGroupCount() - 1; i >= 0; i--) {
   var group = this.GetGroup(i);
   for(var j = group.GetItemCount() - 1; j >= 0; j--) {
    var item = group.GetItem(j);
    item.SetEnabled(enabled);
   }
  }
 },
 GetGroupCount: function() {
  return this.groups.length;
 },
 GetGroup: function(index) {
  return (0 <= index && index < this.groups.length) ? this.groups[index] : null;
 },
 GetGroupByName: function(name) {
  for(var i = 0; i < this.groups.length; i++)
   if(this.groups[i].name == name) return this.groups[i];
  return null;
 },
 GetActiveGroup: function() {
  if(this.autoCollapse) {
   for(var i = 0; i < this.groups.length; i++) {
    if(this.groups[i].GetExpanded())
     return this.groups[i];
   }
  }
  return null;
 },
 SetActiveGroup: function(group) {
  if(this.autoCollapse && group != null)
   group.SetExpanded(true);
 },
 GetItemByName: function(name) {
  for(var i = 0; i < this.groups.length; i++) {
   var item = this.groups[i].GetItemByName(name);
   if(item != null) return item;
  }
  return null;
 },
 GetSelectedItem: function() {
  var indexPath = this.GetSelectedItemIndexPath();
  if(indexPath != "") {
   var groupIndex = this.GetGroupIndex(indexPath);
   var itemIndex = this.GetItemIndex(indexPath);
   if(groupIndex > -1 && itemIndex > -1)
    return this.GetGroup(groupIndex).GetItem(itemIndex);
  }
  return null;
 },
 SetSelectedItem: function(item) {
  var groupIndex = (item != null) ? item.group.index : -1;
  var itemIndex = (item != null) ? item.index : -1;
  aspxClearHoverState();
  this.SetSelectedItemInternal(groupIndex, itemIndex);
 },
 CollapseAll: function() {
  for(var i = 0; i < this.groupsExpanding.length; i++) {
   if(this.groupsExpanding[i])
    this.SetExpandedInternal(i, false);
  }
 },
 ExpandAll: function() {
  for(var i = 0; i < this.groupsExpanding.length; i++) {
   if(!this.groupsExpanding[i])
    this.SetExpandedInternal(i, true);
  }
 },
 ChangeItemElementsEnabledAttributes: function(groupIndex, itemIndex, method, styleMethod) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var imageElement = this.GetItemImageElementByIndexPath(indexPath);
  if(imageElement) {
   method(imageElement, "onclick");
   styleMethod(imageElement, "cursor");
   var link = this.GetInternalHyperlinkElement(imageElement, 0);
   if(link != null) {
    method(link, "href");
    styleMethod(link, "cursor");
   }
  }
  var textElement = this.GetItemTextElementByIndexPath(indexPath);
  if(textElement) {
   method(textElement, "onclick");
   styleMethod(textElement, "cursor");
   var link = this.GetInternalHyperlinkElement(textElement, 0);
   if(link != null) {
    method(link, "href");
    styleMethod(link, "cursor");
    link = this.GetInternalHyperlinkElement(textElement, 1);
    if(link != null) {
     method(link, "href");
     styleMethod(link, "cursor");
    }
   }
  }
  var itemElement = this.GetItemElement(groupIndex, itemIndex);
  if(itemElement) {
   method(itemElement, "onclick");
   if(imageElement == null && textElement == null) {
    styleMethod(itemElement, "cursor");
    var link = this.GetInternalHyperlinkElement(itemElement, 0);
    if(link != null) {
     method(link, "href");
     styleMethod(link, "cursor");
    }
   }
  }
 },
 SetItemEnabled: function(groupIndex, itemIndex, enabled, initialization) {
  if(!this.groups[groupIndex].items[itemIndex].enabled) return;
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  if(!enabled) {
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.DeselectItem(indexPath);
  }
  if(!initialization || !enabled)
   this.ChangeItemEnabledStateItems(groupIndex, itemIndex, enabled);
  this.ChangeItemEnabledAttributes(groupIndex, itemIndex, enabled);
  if(enabled) {
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.SelectItem(indexPath);
  }
 },
 ChangeItemEnabledAttributes: function(groupIndex, itemIndex, enabled) {
  this.ChangeItemElementsEnabledAttributes(groupIndex, itemIndex, _aspxChangeAttributesMethod(enabled),
   _aspxChangeStyleAttributesMethod(enabled));
 },
 ChangeItemEnabledStateItems: function(groupIndex, itemIndex, enabled) {
  if(!this.IsStateControllerEnabled()) return;
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemTextElementByIndexPath(indexPath);
  if(element == null)
   element = this.GetItemImageElementByIndexPath(indexPath);
  if(element == null)
   element = this.GetItemElement(groupIndex, itemIndex);
  if(element != null)
   aspxGetStateController().SetElementEnabled(element, enabled);
 },
 GetItemImageUrl: function(groupIndex, itemIndex) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemImageContainer(indexPath);
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img.src;
  }
  element = this.GetItemTextElementByIndexPath(indexPath);
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img.src;
  }
  return "";
 },
 SetItemImageUrl: function(groupIndex, itemIndex, url) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemImageContainer(indexPath);
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    img.src = url;
  }
  element = this.GetItemTextElementByIndexPath(indexPath);
  if(element != null) {
   var itemImageElementID = this.name + this.GetItemImageID(indexPath);
   var img = _aspxGetChildById(element, itemImageElementID);
   if(img != null)
    img.src = url;
  }
 },
 GetItemImageContainer: function(indexPath) {
  return this.liteRender ? this.GetItemElementByIndexPath(indexPath) : this.GetItemImageElementByIndexPath(indexPath);
 },
 GetItemNavigateUrl: function(groupIndex, itemIndex) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemTextElementByIndexPath(indexPath);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  else {
   element = this.GetItemImageElementByIndexPath(indexPath);
   if(element != null) {
    var link = _aspxGetChildByTagName(element, "A", 0);
    if(link != null)
     return link.href;
   }
   else {
    element = this.GetItemElement(groupIndex, itemIndex);
    if(element != null) {
     var link = _aspxGetChildByTagName(element, "A", 0);
     if(link != null)
      return link.href;
    }
   }
  }
  return "";
 },
 SetItemNavigateUrl: function(groupIndex, itemIndex, url) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var textElement = this.GetItemTextElementByIndexPath(indexPath);
  if(textElement != null) {
   var link = _aspxGetChildByTagName(textElement, "A", 0);
   if(link != null) {
    link.href = url;
    link = _aspxGetChildByTagName(textElement, "A", 1);
    if(link != null)
     link.href = url;
   }
  }
  var imageElement = this.GetItemImageElementByIndexPath(indexPath);
  if(imageElement != null) {
   var link = _aspxGetChildByTagName(imageElement, "A", 0);
   if(link != null)
    link.href = url;
  }
  if(textElement == null && imageElement == null) {
   var element = this.GetItemElement(groupIndex, itemIndex);
   if(element != null) {
    var link = _aspxGetChildByTagName(element, "A", 0);
    if(link != null)
     link.href = url;
   }
  }
 },
 GetItemText: function(groupIndex, itemIndex) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemTextElementByIndexPath(indexPath);
  if(element == null)
   element = this.GetItemElement(groupIndex, itemIndex);
  if(element != null) {
   var textNode = _aspxGetChildTextNode(element, 0);
   if(textNode != null)
    return textNode.nodeValue;
  }
  return "";
 },
 SetItemText: function(groupIndex, itemIndex, text) {
  var indexPath = this.GetIndexPath(groupIndex, itemIndex);
  var element = this.GetItemTextElementByIndexPath(indexPath);
  if(element == null)
   element = this.GetItemElement(groupIndex, itemIndex);
  if(element != null) {
   var textNode = _aspxGetChildTextNode(element, 0);
   if(textNode != null)
    textNode.nodeValue = text;
  }
 },
 SetItemVisible: function(groupIndex, itemIndex, visible, initialization) {
  if(!this.groups[groupIndex].items[itemIndex].visible) return;
  if(visible && initialization) return;
  var element = this.GetItemElement(groupIndex, itemIndex);
  if(element != null) _aspxSetElementDisplay(element, visible);
  this.SetItemSeparatorsVisiblility(groupIndex);
 },
 SetItemSeparatorsVisiblility: function(groupIndex) {
  var group = this.groups[groupIndex];
  for(var i = 0; i < group.items.length; i++) {
   var separatorVisible = group.items[i].GetVisible() && this.HasNextVisibleItems(group, i);
   var separatorElement = this.GetItemSeparatorElement(groupIndex, i);
   if(separatorElement != null) _aspxSetElementDisplay(separatorElement, separatorVisible);
  }
 },
 HasNextVisibleItems: function(group, index) {
  for(var i = index + 1; i < group.items.length; i++) {
   if(group.items[i].GetVisible())
    return true;
  }
  return false;
 },
 SetGroupVisible: function(groupIndex, visible, initialization) {
  if(!this.groups[groupIndex].visible) return;
  if(visible && initialization) return;
  var element = this.GetGroupRow(groupIndex);
  if(element != null) _aspxSetElementDisplay(element, visible);
  this.SetGroupSeparatorsVisiblility();
 },
 GetGroupText: function(groupIndex) {
  var groupRow = this.GetGroupRow(groupIndex);
  if(!groupRow)
   return;
  var groupTextElement = _aspxGetDescendantNodesByClassName(groupRow, this.GROUP_TEXT_CLASSNAME)[0];
  if(!groupTextElement)
   return;
  return _aspxGetInnerText(groupTextElement);
 },
 SetGroupText: function(groupIndex, text) {
  var groupRow = this.GetGroupRow(groupIndex);
  if(!groupRow)
   return;
  var groupTextElements = _aspxGetDescendantNodesByClassName(groupRow, this.GROUP_TEXT_CLASSNAME);
  for(var i = 0; i < groupTextElements.length; i++) {
   var textNode = _aspxGetChildTextNode(groupTextElements[i], 0);
   if(textNode != null)
    textNode.nodeValue = text;
  }
 }, 
 SetGroupSeparatorsVisiblility: function() {
  for(var i = 0; i < this.groups.length; i++) {
   var separatorVisible = this.groups[i].GetVisible() && this.HasNextVisibleGroups(i);
   var separatorElement = this.GetGroupSeparatorRow(i);
   if(separatorElement != null) _aspxSetElementDisplay(separatorElement, separatorVisible);
  }
 },
 HasNextVisibleGroups: function(index) {
  for(var i = index + 1; i < this.groups.length; i++) {
   if(this.groups[i].GetVisible())
    return true;
  }
  return false;
 }
});
ASPxClientNavBar.Cast = ASPxClientControl.Cast;
ASPxClientNavBarGroup = _aspxCreateClass(null, {
 constructor: function(navBar, index, name){
  this.navBar = navBar;
  this.index = index;
  this.name = name;
  this.enabled = true;
  this.visible = true;
  this.clientVisible = true;
  this.items = []; 
 },
 CreateItems: function(itemsProperties){
  for(var i = 0; i < itemsProperties.length; i ++){
   var itemName = itemsProperties[i][0] || "";
   var item = new ASPxClientNavBarItem(this.navBar, this, i, itemName);
   if(_aspxIsExists(itemsProperties[i][1]))
    item.enabled = itemsProperties[i][1];
   if(_aspxIsExists(itemsProperties[i][2]))    
    item.clientEnabled = itemsProperties[i][2];
   if(_aspxIsExists(itemsProperties[i][3]))
    item.visible = itemsProperties[i][3];
   if(_aspxIsExists(itemsProperties[i][4]))
    item.clientVisible = itemsProperties[i][4];
   this.items.push(item);
  }
 },
 GetEnabled: function(){
  return this.enabled;
 },
 GetExpanded: function(){
  return this.navBar.groupsExpanding[this.index];
 },
 SetExpanded: function(value){
  this.navBar.SetExpandedInternal(this.index, value);
 },
 GetVisible: function(){
  return this.visible && this.clientVisible;
 },
 GetText: function() {
  return this.navBar.GetGroupText(this.index);
 },
 SetText: function(text) {
  this.navBar.SetGroupText(this.index, text);
 },
 SetVisible: function(value){
  if (this.clientVisible != value) {
   this.clientVisible = value;
   this.navBar.SetGroupVisible(this.index, value, false);
  }
 },
 GetItemCount: function(groupIndex){
  return this.items.length;
 },
 GetItem: function(index){
  return (0 <= index && index < this.items.length) ? this.items[index] : null;
 },
 GetItemByName: function(name){
  for(var i = 0; i < this.items.length; i ++)
   if(this.items[i].name == name) return this.items[i];
  return null;
 }
});
ASPxClientNavBarItem = _aspxCreateClass(null, {
 constructor: function(navBar, group, index, name){
  this.navBar = navBar;
  this.group = group;
  this.index = index;
  this.name = name;
  this.enabled = true;
  this.clientEnabled = true;
  this.visible = true;
  this.clientVisible = true;
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(value){
  if (this.clientEnabled != value) {
   this.clientEnabled = value;
   this.navBar.SetItemEnabled(this.group.index, this.index, value, false);
  }
 },
 GetImageUrl: function(){
  return this.navBar.GetItemImageUrl(this.group.index, this.index);
 },
 SetImageUrl: function(value){
  this.navBar.SetItemImageUrl(this.group.index, this.index, value);
 },
 GetNavigateUrl: function(){
  return this.navBar.GetItemNavigateUrl(this.group.index, this.index);
 },
 SetNavigateUrl: function(value){
  this.navBar.SetItemNavigateUrl(this.group.index, this.index, value);
 },
 GetText: function(){
  return this.navBar.GetItemText(this.group.index, this.index);
 },
 SetText: function(value){
  this.navBar.SetItemText(this.group.index, this.index, value);
 },
 GetVisible: function(){
  return this.visible && this.clientVisible;
 },
 SetVisible: function(value){
  if (this.clientVisible != value) {
   this.clientVisible = value;
   this.navBar.SetItemVisible(this.group.index, this.index, value, false);
  }
 } 
});
ASPxClientNavBarItemEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, item, htmlElement, htmlEvent){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.item = item;
  this.htmlElement = htmlElement;
  this.htmlEvent = htmlEvent;
 }
});
ASPxClientNavBarGroupEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(group){
  this.group = group;
 }
});
ASPxClientNavBarGroupCancelEventArgs = _aspxCreateClass(ASPxClientProcessingModeCancelEventArgs, {
 constructor: function(processOnServer, group){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.group = group;
 }
});
ASPxClientNavBarGroupClickEventArgs = _aspxCreateClass(ASPxClientNavBarGroupCancelEventArgs, {
 constructor: function(processOnServer, group, htmlElement, htmlEvent){
  this.constructor.prototype.constructor.call(this, processOnServer, group);
  this.htmlElement = htmlElement;
  this.htmlEvent = htmlEvent;  
 }
});
function aspxNBAnimT(name, groupIndex){
 var nb = aspxGetControlCollection().Get(name);
 if(nb != null) nb.OnAnimationTimer(groupIndex);
}
function aspxNBHClick(evt, name, groupIndex){
 var nb = aspxGetControlCollection().Get(name);
 if(nb != null) nb.OnHeaderClick(groupIndex, evt);
 if(!__aspxNetscapeFamily)
  evt.cancelBubble = true;
}
function aspxNBHMMove(evt, name, groupIndex){
 var nb = aspxGetControlCollection().Get(name);
 if(nb != null) nb.OnHeaderMouseMove(groupIndex, evt);
}
function aspxNBHMMoveTimer(name, groupIndex){
 var nb = aspxGetControlCollection().Get(name);
 if(nb != null) nb.OnHeaderMouseMoveTimer(groupIndex);
}
function aspxNBIClick(evt, name, groupIndex, itemIndex){
 var nb = aspxGetControlCollection().Get(name);
 if(nb != null) nb.OnItemClick(groupIndex, itemIndex, evt);
 if(!__aspxNetscapeFamily)
  evt.cancelBubble = true;
}
ASPxClientNavBar.MouseOverActiveNavBar = null;
ASPxClientNavBar.MouseOverActiveGroupIndex = -1;
ASPxClientNavBar.DocMouseMoveHandler = function(evt) {
 if(ASPxClientNavBar.MouseOverActiveNavBar != null && ASPxClientNavBar.MouseOverActiveGroupIndex != -1){
  var srcElement = _aspxGetEventSource(evt);
  var headerElement = ASPxClientNavBar.MouseOverActiveNavBar.GetGroupHeaderExpandedElement(ASPxClientNavBar.MouseOverActiveGroupIndex);
  if(headerElement == null || (srcElement != headerElement && !_aspxGetIsParent(headerElement, srcElement))){
   headerElement = ASPxClientNavBar.MouseOverActiveNavBar.GetGroupHeaderCollapsedElement(ASPxClientNavBar.MouseOverActiveGroupIndex);
   if(headerElement == null || (srcElement != headerElement && !_aspxGetIsParent(headerElement, srcElement))){
    ASPxClientNavBar.MouseOverActiveNavBar = null;
    ASPxClientNavBar.MouseOverActiveGroupIndex = -1;
   }
  }
 }
};
_aspxAttachEventToDocument("mousemove", ASPxClientNavBar.DocMouseMoveHandler);
