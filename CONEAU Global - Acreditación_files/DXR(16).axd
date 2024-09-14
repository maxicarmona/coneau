var __aspxPCWIdSuffix = "_PW";
function ASPxPCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset) {
 this.horizontalDirection = horizontalDirection;
 this.verticalDirection = verticalDirection;
 this.horizontalOffset = horizontalOffset;
 this.verticalOffset = verticalOffset;
 this.course = verticalDirection + horizontalDirection;
}
ASPxClientPopupControlCssClasses = {};
ASPxClientPopupControlCssClasses.Prefix = "dxpc-";
ASPxClientPopupControlCssClasses.SizeGripLiteCssClassName = ASPxClientPopupControlCssClasses.Prefix + "sizeGrip";
ASPxClientPopupControlCssClasses.LinkCssClassName = ASPxClientPopupControlCssClasses.Prefix + "link";
ASPxClientPopupControlCssClasses.ShadowLiteCssClassName = ASPxClientPopupControlCssClasses.Prefix + "shadow";
ASPxClientPopupControlCssClasses.MainDivLiteCssClass = ASPxClientPopupControlCssClasses.Prefix + "mainDiv";
ASPxClientPopupControl = _aspxCreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.leadingAfterInitCall = true; 
  this.adjustInnerControlsSizeOnShow = true;
  this.animationDelay = 30;
  this.animationMaxDelay = 400;
  this.appearAfter = 300;
  this.disappearAfter = 500;
  this.allowResize = false;
  this.enableAnimation = true;
  this.popupAnimationType = null;
  this.shadowVisible = true;
  this.allowCorrectYOffsetPosition = true; 
  this.contentUrl = "";
  this.contentUrlArray = [];
  this.contentLoadingMode = "Default"
  this.loadingPanels = [];
  this.loadingDivs = [];
  this.lpTimers = [];
  this.callbackAnimationProcessings = [];
  this.savedCallbackResults = [];
  this.isCallbackFinishedStates = [];
  this.savedCallbackWindowIndex = null;
  this.cookieName = "";
  this.closeAction = "OuterMouseClick";
  this.popupAction = "LeftMouseClick";
  this.closeActionArray = [];
  this.popupActionArray = [];
  this.windowsPopupElementIDList = [];
  this.windowsPopupElementList = [];
  this.windowsLastUsedPopupElementInfoList = [];
  this.windowsIsPopupedList = [];
  this.windowsPopupReasonMouseEventList = [];
  this.defaultWindowPopupElementIDList = [];
  this.defaultWindowPopupElementList = [];
  this.defaultLastUsedPopupElementInfo = {};
  this.defaultIsPopuped = false;
  this.defaultPopupReasonMouseEvent = null;
  this.showOnPageLoad = false;
  this.showOnPageLoadArray = [];
  this.popupHorizontalAlign = __aspxNotSetAlignIndicator;
  this.popupVerticalAlign = __aspxNotSetAlignIndicator;
  this.popupHorizontalOffset = 0;
  this.popupVerticalOffset = 0;
  this.windows = [];
  this.windowCount = 0;
  this.isDragged = false;
  this.isResized = false;
  this.zIndex = -1;
  this.left = 0;
  this.top = 0;
  this.allowLoadToHiddenIframe = __aspxIE || __aspxFirefox;
  this.iframeLoading = false;
  this.isDraggedArray = [];
  this.isResizedArray = [];
  this.zIndexArray = [];
  this.leftArray = [];
  this.topArray = [];
  this.height = 0;
  this.width = 0;
  this.minHeight = null;
  this.minWidth = null;
  this.maxHeight = null;
  this.maxWidth = null;
  this.heightArray = [];
  this.widthArray = [];
  this.minHeightArray = [];
  this.minWidthArray = [];
  this.maxHeightArray = [];
  this.maxWidthArray = [];
  this.iframeLoadingArray = [];
  this.isLiveResizingMode = true;
  this.isPopupPositionCorrectionOn = true;
  this.windowElements = new Object();
  this.hideBodyScrollWhenModal = true;
  this.hideBodyScrollWhenMaximized = true;
  this.autoUpdatePosition = false;
  this.autoUpdatePositionArray = [];
  this.cachedSize = null;
  this.cachedSizeArray = [];
  this.fakeDragDiv = null;
  this.headerHeight = 0;
  this.headerHeightArray = [];
  this.footerHeight = 0;
  this.footerHeightArray = [];
  this.ResizeBorderSize = __aspxTouchUI ? 10 : 6;
  this.ResizeCornerBorderSize = 20;
  this.liteRender = false;
  this.allowDragging = false;
  this.isWindowDragging = false;
  this.enableContentScrolling = false;
  this.contentOverflowX = "None";
  this.contentOverflowY = "None";
  this.isPinned = false;
  this.isPinnedArray = [];
  this.pinX = 0;
  this.pinXArray = [];
  this.pinY = 0;
  this.pinYArray = [];
  this.lockScroll = 0;
  this.isCollapsed = false;
  this.isCollapsedArray = [];
  this.isCollapsedInit = false;
  this.isCollapsedInitArray = [];
  this.collapseExecutingLockCount = 0;
  this.isMaximized = false;
  this.isMaximizedArray = [];
  this.isMaximizedInit = false;
  this.isMaximizedInitArray = [];
  this.maximizationExecutingLockCount = 0;
  this.restoredWindowValues = {};
  this.restoredWindowValuesArray = [];
  this.browserResizingForMaxWindowLockCount = 0;
  this.updateRestoredWindowSizeLockCount = 0;
  this.prohibitClearSelectionOnMouseDown = false;
  this.CloseButtonClick = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  this.Closing = new ASPxClientEvent();
  this.PopUp = new ASPxClientEvent();
  this.Resize = new ASPxClientEvent();
  this.Shown = new ASPxClientEvent();
  this.BeforeResizing = new ASPxClientEvent();
  this.AfterResizing = new ASPxClientEvent();
  this.PinnedChanged = new ASPxClientEvent();
  aspxGetPopupControlCollection().Add(this);
 },
 InlineInitialize: function() {
  this.InitializeArrayCores();
 },
 Initialize: function() {
  aspxGetPopupControlCollection().EnsureSaveScrollState();
  this.InitializeBeforeAnyShow();
  if(this.HasDefaultWindow())
   this.InitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount(); i++)
   this.InitializeWindow(i);
  this.InitializeScrollbars();
  this.constructor.prototype.Initialize.call(this);
 },
 InitializeBeforeAnyShow: function(){
  this.enableContentScrolling = this.contentOverflowX != "None" || this.contentOverflowY != "None";
 },
 InitializeScrollbars: function() {
  if(__aspxWebKitTouchUI && this.enableContentScrolling) {
   var options = {
    showHorizontalScrollbar: this.contentOverflowX == "Auto" || this.contentOverflowX == "Scroll",
    showVerticalScrollbar: this.contentOverflowY == "Auto" || this.contentOverflowY == "Scroll"
   };
   if(this.HasDefaultWindow() && this.GetContentContainer(-1))
    ASPxClientTouchUI.MakeScrollable(this.GetContentContainer(-1), options);
   for(var i = 0; i < this.GetWindowCount(); i++) {
    var scrollElement = this.GetContentContainer(i)
    if(scrollElement)
     ASPxClientTouchUI.MakeScrollable(scrollElement, options);
   }
  }
 },
 AfterInitialize: function() {
  if(this.HasDefaultWindow())
   this.AfterInitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount(); i++)
   this.AfterInitializeWindow(i);
  this.constructor.prototype.AfterInitialize.call(this);
 },
 InitializeArrayCores: function() {
  if(this.GetWindowCountCore() > 0) {
   this.InitializeWindowPopupElementList();
   this.InitializeWindowPopupElementIDList();
   this.InitializeWindowLastUsedPopupElementInfoList();
   this.InitializeArray(this.windowsPopupReasonMouseEventList, null);
   this.InitializeArray(this.windowsIsPopupedList, false);
   this.InitializeArray(this.contentUrlArray, "");
   this.InitializeArray(this.popupActionArray, this.popupAction);
   this.InitializeArray(this.closeActionArray, this.closeAction);
   this.InitializeArray(this.showOnPageLoadArray, false);
   this.InitializeArray(this.isDraggedArray, false);
   this.InitializeArray(this.isPinnedArray, false);
   this.InitializeArray(this.isCollapsedArray, false);
   this.InitializeArray(this.isCollapsedInitArray, false);
   this.InitializeArray(this.isMaximizedArray, false);
   this.InitializeArray(this.isMaximizedInitArray, false);
   this.InitializeArray(this.restoredWindowValuesArray, {});
   this.InitializeArray(this.isResizedArray, false);
   this.InitializeArray(this.zIndexArray, -1);
   this.InitializeArray(this.leftArray, 0);
   this.InitializeArray(this.topArray, 0);
   this.InitializeArray(this.widthArray, 0);
   this.InitializeArray(this.heightArray, 0);
   this.InitializeArray(this.pinXArray, 0);
   this.InitializeArray(this.pinYArray, 0);
   this.InitializeArray(this.minWidthArray, null);
   this.InitializeArray(this.minHeightArray, null);
   this.InitializeArray(this.maxWidthArray, null);
   this.InitializeArray(this.maxHeightArray, null);
   this.InitializeArray(this.cachedSizeArray, null);
   this.InitializeArray(this.iframeLoadingArray, false);
   this.InitializeArray(this.autoUpdatePositionArray, false);
   if(__aspxIE) {
    this.InitializeArray(this.headerHeightArray, -1);
    this.InitializeArray(this.footerHeightArray, -1);
   }
  }
 },
 InitializeArray: function(array, defaultValue) {
  if(array.length == 0) {
   for(var i = 0; i < this.GetWindowCountCore(); i++)
    array[i] = defaultValue;
  }
 },
 InitializeWindowPopupElementIDList: function() {
  for(var i = 0; i < this.GetWindowCountCore(); i++) {
   if(!this.windowsPopupElementIDList[i])
    this.windowsPopupElementIDList[i] = [];
  }
 },
 InitializeWindowPopupElementList: function() {
  for(var i = 0; i < this.GetWindowCountCore(); i++) {
   if(!this.windowsPopupElementList[i])
    this.windowsPopupElementList[i] = [];
  }
 },
 InitializeWindowLastUsedPopupElementInfoList: function() {
  for(var i = 0; i < this.GetWindowCountCore(); i++) {
   if(!this.windowsLastUsedPopupElementInfoList[i])
    this.windowsLastUsedPopupElementInfoList[i] = {};
  }
 },
 WindowElementIDAssignmentMap: [
  { cssClass: "dxpc-header", prefix: "_PWH" },
  { cssClass: "dxpc-headerText", prefix: "_PWH", postfix: "T" },
  { cssClass: "dxpc-headerImg", prefix: "_PWH", postfix: "I" },
  { cssClass: "dxpc-closeBtn", prefix: "_HCB" },
  { cssClass: "dxpc-pinBtn", prefix: "_HPB" },
  { cssClass: "dxpc-refreshBtn", prefix: "_HRB" },
  { cssClass: "dxpc-collapseBtn", prefix: "_HMNB" },
  { cssClass: "dxpc-maximizeBtn", prefix: "_HMXB" },
  { cssClass: "dxpc-content", prefix: "_PWC" },
  { cssClass: "dxpc-iFrame", prefix: "_CIF" },
  { cssClass: "dxpc-footer", prefix: "_PWF" },
  { cssClass: "dxpc-footerText", prefix: "_PWF", postfix: "T" },
  { cssClass: "dxpc-footerImg", prefix: "_PWF", postfix: "I" }
 ],
 AssignElementID: function(element, index, prefix, postfix) {
  element.id = this.name + prefix + index + (postfix ? postfix : "");
 },
 AssignWindowElementsID: function(index, windowElement) {
  for(var i = 0; i < this.WindowElementIDAssignmentMap.length; i++) {
   var elementClass = this.WindowElementIDAssignmentMap[i].cssClass;
   var elements = _aspxGetDescendantNodesByClassName(windowElement, elementClass);
   for(var j = 0; j < elements.length; j++) {
    var element = elements[j];
    if(this.GetFirstParentWindow(element) === windowElement)
     this.AssignElementID(element, index, this.WindowElementIDAssignmentMap[i].prefix, this.WindowElementIDAssignmentMap[i].postfix);
   }
  }
 },
 GetFirstParentWindow: function(el) {
  while(el && el.tagName != "BODY") {
   if(el.nodeType == 1 && el.className.indexOf("dxpclW") > -1 && !isNaN(this.GetWindowIndex(el)))
    return el;
   el = el.parentNode;
  }
 },
 PreventHeaderButtonMouseDownBubbling: function(evt, hdrButton) {
  if(hdrButton) {
   var source = _aspxGetEventSource(evt);
   if(_aspxGetIsParent(hdrButton, source)) {
    aspxPWHMDown(evt);
    return true;
   }
  }
  return false;
 },
 GetWindowElementMouseDownEventHandler: function(index) {
  var instance = this,
   interactiveTagNames = ['INPUT', 'BUTTON', 'TEXTAREA', 'SELECT', 'OPTION', 'A', 'IFRAME'];
  return function(evt) {
   var content = instance.GetWindowContentElement(index),
    target = _aspxGetEventSource(evt);
   if(target && _aspxGetIsParent(content, target) && _aspxArrayIndexOf(interactiveTagNames, target.tagName) > -1)
    return true;
   if(!instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCloseButton(index)) && 
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowPinButton(index)) && 
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowRefreshButton(index)) && 
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCollapseButton(index)) && 
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowMaximizeButton(index)))
    aspxPWMDown(evt, instance.name, index, instance.isWindowDragging);
  }
 },
 GetWindowElementMouseMoveEventHandler: function(index) {
  var instance = this;
  return function(evt) { aspxPWMMove(evt, instance.name, index); };
 },
 GetWindowHeaderElementMouseDownEventHandler: function(index) {
  var instance = this;
  return function(evt) {
   if(!instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCloseButton(index)) &&
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowPinButton(index)) &&
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowRefreshButton(index)) &&
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCollapseButton(index)) &&
      !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowMaximizeButton(index)))
    aspxPWDGMDown(evt, instance.name, index);
  }
 },
 AssignWindowElementsEvents: function(index, element) {
  var instance = this;
  var mdEventName = ASPxClientTouchUI.touchMouseDownEventName;
  _aspxAttachEventToElement(element, mdEventName, this.GetWindowElementMouseDownEventHandler(index), true);
  if(this.allowResize) {
   var mmEventName = ASPxClientTouchUI.touchMouseMoveEventName;
   _aspxAttachEventToElement(element, mmEventName, this.GetWindowElementMouseMoveEventHandler(index));
  }
  var header = this.GetWindowHeaderElement(index);
  if(header && this.allowDragging && !this.isWindowDragging) {
   _aspxAttachEventToElement(header, mdEventName, this.GetWindowHeaderElementMouseDownEventHandler(index), true);
  }
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(sizeGrip) {
   _aspxAttachEventToElement(sizeGrip, mdEventName, function(evt) {
    aspxPWGripMDown(evt, instance.name, index);
    _aspxPreventEvent(evt);
   });
  }
  this.AttachClickToHeaderButton(index, this.GetWindowCloseButton(index), "aspxPWCBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowPinButton(index), "aspxPWPBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowRefreshButton(index), "aspxPWRBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowCollapseButton(index), "aspxPWMNBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowMaximizeButton(index), "aspxPWMXBClick");
 },
 AttachClickToHeaderButton: function(index, headerButton, eventFuncName) {
  var instance = this;
  if(headerButton) {
   _aspxAttachEventToElement(headerButton, "click", function(evt) {
    eval(eventFuncName)(evt, instance.name, index);
   });
  }
 },
 InitializeWindow: function(index) {
  var modalElement = this.GetWindowModalElement(index);
  if(modalElement)
   _aspxAttachEventToElement(modalElement, "mousedown", aspxPWMEMDown);
  this.PopulatePopupElements(index);
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.liteRender) {
    this.AssignWindowElementsID(index, element);
    this.AssignWindowElementsEvents(index, element);
   }
   element.DXPopupWindowElement = true;
   _aspxAttachEventToElement(element, "resize", this.CreateWindowResizeHandler(this.name, index));
   if(__aspxIE)
    this.AttachOnDragStartEventToWindowImages(index);
   this.InitIFrame(index);
   element.isHiding = false;
   element.isContentHeightInit = false;
   element.isPopupPositionCorrectionOn = this.isPopupPositionCorrectionOn || !this.GetShowOnPageLoad(index);
   if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) > 0) {
    this.FirstShowWindow(index, false);
    aspxGetPopupControlCollection().SetWindowElementZIndex(element, this.GetZIndex(index));
    element.isPopupPositionCorrectionOn = true;
   }
  }
 },
 CreateWindowResizeHandler: function(name, index) {
  return function() {
   var pc = aspxGetPopupControlCollection().Get(name);
   if(pc)
    pc.ResizeWindowIFrame(index);
  };
 },
 InitIFrame: function(index) {
  var contentIFrameElement = this.GetWindowContentIFrameElement(index);
  if(contentIFrameElement) {
   contentIFrameElement.popupControlName = this.name;
   contentIFrameElement.pcWndIndex = index;
   _aspxAttachEventToElement(contentIFrameElement, "load", aspxPCIframeLoad);
  }
 },
 InitCollapsedWindows: function(index) {
  if ((this.isCollapsedInit && index == -1) || (index >= 0 && index < this.isCollapsedInitArray.length && this.isCollapsedInitArray[index])){
   if (this.InternalIsWindowVisible(index)){
    this.DoCollapse(index, true);
    if (index == -1)
     this.isCollapsedInit = false;
    else
     this.isCollapsedInitArray[index] = false;
   }
  }
 },
 InitMaximizedWindows: function(index) {
  if ((this.isMaximizedInit && index == -1) || (index >= 0 && index < this.isMaximizedInitArray.length && this.isMaximizedInitArray[index])){
   if (this.InternalIsWindowVisible(index)){
    this.DoMaximize(index, true);
    if (index == -1)
     this.isMaximizedInit = false;
    else
     this.isMaximizedInitArray[index] = false;
   }
  }
 },
 InitPinnedWindows: function(index) {
  if ((this.isPinned && index == -1) || (index >= 0 && index < this.isPinnedArray.length && this.isPinnedArray[index]))
   this.HoldPosition(index, true);
 },
 AfterInitializeWindow: function(index) {
  if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) < 0) {
   this.FirstShowWindow(index, true);
   var element = this.GetWindowElement(index);
   if(element != null)
    element.isPopupPositionCorrectionOn = true;
  }
  this.EnsureContent(index, true);
  this.InitPinnedWindows(index);
  this.InitMaximizedWindows(index);
  this.InitCollapsedWindows(index);
 },
 AttachOnDragStartEventToWindowImages: function(index) {
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowHeaderElement(index));
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowFooterElement(index));
 },
 AttachChildImagesPreventDragStartEvent: function(parentElem) {
  var images = parentElem == null ? null : _aspxGetElementsByTagName(parentElem, "img");
  if(images != null) {
   for(var i = 0; i < images.length; i++)
    _aspxAttachEventToElement(images[i], "dragstart", _aspxPreventDragStart);
  }
 },
 FirstShowWindow: function(index, allowChangeZIndex) {
  var isFreeWindow = this.GetIsDragged(index);
  var x = __aspxInvalidPosition;
  var y = __aspxInvalidPosition;
  if(isFreeWindow) {
   x = this.GetWindowLeft(index);
   y = this.GetWindowTop(index);
   var popupHorizontalOffsetBackup = this.popupHorizontalOffset;
   var popupVerticalOffsetBackup = this.popupVerticalOffset;
   this.popupHorizontalOffset = 0;
   this.popupVerticalOffset = 0;
  }
  var enableAnimationBackup = this.enableAnimation;
  this.enableAnimation = false;
  this.DoShowWindowAtPos(index, x, y, isFreeWindow ? -1 : 0, false, allowChangeZIndex);
  this.enableAnimation = enableAnimationBackup;
  if(isFreeWindow) {
   this.popupHorizontalOffset = popupHorizontalOffsetBackup;
   this.popupVerticalOffset = popupVerticalOffsetBackup;
  }
 },
 GetIsDragged: function(index) {
  if(0 <= index && index < this.isDraggedArray.length)
   return this.isDraggedArray[index];
  return this.isDragged;
 },
 SetIsDragged: function(index, value) {
  if(0 <= index && index < this.isDraggedArray.length)
   this.isDraggedArray[index] = value;
  else
   this.isDragged = value;
 },
 GetIsPinned: function(index) {
  if(0 <= index && index < this.isPinnedArray.length)
   return this.isPinnedArray[index];
  return this.isPinned;
 },
 SetIsPinned: function(index, value) {
  if(0 <= index && index < this.isPinnedArray.length)
   this.isPinnedArray[index] = value;
  else
   this.isPinned = value;
 },
 GetPinPosX: function(index) {
  if(0 <= index && index < this.pinXArray.length)
   return this.pinXArray[index];
  return this.pinX;
 },
 SetPinPosX: function(index, pinX) {
  if(0 <= index && index < this.pinXArray.length)
   this.pinXArray[index] = pinX;
  else
   this.pinX = pinX;
 },
 GetPinPosY: function(index) {
  if(0 <= index && index < this.pinYArray.length)
   return this.pinYArray[index];
  return this.pinY;
 },
 SetPinPosY: function(index, pinY) {
  if(0 <= index && index < this.pinYArray.length)
   this.pinYArray[index] = pinY;
  else
   this.pinY = pinY;
 },
 GetIsCollapsed: function(index) {
  if(0 <= index && index < this.isCollapsedArray.length)
   return this.isCollapsedArray[index];
  return this.isCollapsed;
 },
 SetIsCollapsed: function(index, value) {
  if(0 <= index && index < this.isCollapsedArray.length)
   this.isCollapsedArray[index] = value;
  else
   this.isCollapsed = value;
 },
 GetIsMaximized: function(index) {
  if(0 <= index && index < this.isMaximizedArray.length)
   return this.isMaximizedArray[index];
  return this.isMaximized;
 },
 SetIsMaximized: function(index, value) {
  if(0 <= index && index < this.isMaximizedArray.length)
   this.isMaximizedArray[index] = value;
  else
   this.isMaximized = value;
 },
 GetRestoredWindowData: function(index) {
  if(0 <= index && index < this.restoredWindowValuesArray.length)
   return this.restoredWindowValuesArray[index];
  return _aspxCloneObject(this.restoredWindowValues);
 },
 SetRestoredWindowData: function(index, value) {
  if(0 <= index && index < this.restoredWindowValuesArray.length)
   this.restoredWindowValuesArray[index] = value;
  else
   this.restoredWindowValues = value;
 },
 GetIsResized: function(index) {
  if(0 <= index && index < this.isResizedArray.length)
   return this.isResizedArray[index];
  return this.isResized;
 },
 SetIsResized: function(index, value) {
  if(0 <= index && index < this.isResizedArray.length)
   this.isResizedArray[index] = value;
  else
   this.isResized = value;
 },
 HasDefaultWindow: function() {
  return this.GetWindowCountCore() == 0;
 },
 GetCurrentLeft: function(index) {
  return this.GetPosition(index, true);
 },
 GetCurrentTop: function(index) {
  return this.GetPosition(index, false);
 },
 GetHeaderHeight: function(index) {
  if(0 <= index && index < this.headerHeightArray.length)
   return this.headerHeightArray[index];
  return this.headerHeight;
 },
 GetFooterHeight: function(index) {
  if(0 <= index && index < this.footerHeightArray.length)
   return this.footerHeightArray[index];
  return this.footerHeight;
 },
 GetWindowFooterHeightLite: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(footer)
   return footer.offsetHeight;
  return null;
 },
 SetHeaderHeight: function(index, height) {
  if(0 <= index && index < this.headerHeightArray.length)
   this.headerHeightArray[index] = height;
  else
   this.headerHeight = height;
 },
 SetFooterHeight: function(index, height) {
  if(0 <= index && index < this.footerHeightArray.length)
   return this.footerHeightArray[index] = height;
  else
   this.footerHeight = height;
 },
 GetPosition: function(index, isLeft) {
  if(0 <= index && index < this.GetWindowCountCore())
   return isLeft ? this.leftArray[index] : this.topArray[index];
  return isLeft ? this.left : this.top;
 },
 SetPopupElementReference: function(index, popupElement, popupElementIndex, attach) {
  if(!_aspxIsExistsElement(popupElement)) return;
  var setReferenceFunction = attach ? _aspxAttachEventToElement : _aspxDetachEventFromElement;
  var windowPopupAction = this.GetWindowPopupAction(index);
  if(windowPopupAction == "LeftMouseClick")
   setReferenceFunction(popupElement, "mouseup", aspxPEMEvent);
  else if(windowPopupAction == "RightMouseClick")
   setReferenceFunction(popupElement, "contextmenu", aspxPEMEvent);
  else if(windowPopupAction == "MouseOver") {
   var windowElement = this.GetWindowElement(index);
   setReferenceFunction(popupElement, "mouseover", _aspxClientOverControlUtils.OnMouseOver);
   setReferenceFunction(windowElement, "mouseover", aspxPWEMOver);
   if(attach)
    this.SetMSTouchMouseOverReference(popupElement, windowElement, this.name, index, this.appearAfter);
  }
  if(windowPopupAction == "LeftMouseClick" || windowPopupAction == "RightMouseClick") {
   setReferenceFunction(popupElement, "mousedown", aspxPEMEvent);
  }
  if(attach) {
   popupElement.DXPopupElementControl = this;
   popupElement.DXPopupWindowIndex = index;
   popupElement.DXPopupElementIndex = popupElementIndex;
  } else
   popupElement.DXPopupElementControl = popupElement.DXPopupWindowIndex = popupElement.DXPopupElementIndex = undefined;
 },
 SetMSTouchMouseOverReference: function(popupElement, windowElement, popupName, index, appearAfter){
  if(!window.navigator.msPointerEnabled) return;
  popupElement.dxMsTouchGesture = popupElement.dxMsTouchGesture ||
   ASPxClientTouchUI.msTouchCreateGerturesWrapper(popupElement, function(evt){
    window.setTimeout(function(){
     aspxGetPopupControlCollection().SetAppearTimer(popupName, index, popupElement.DXPopupElementIndex, appearAfter, evt);
    }, 0);
   });
  windowElement.dxMsTouchGesture = windowElement.dxMsTouchGesture || ASPxClientTouchUI.msTouchCreateGerturesWrapper(windowElement, function(evt){
   window.setTimeout(function(){
    aspxGetPopupControlCollection().ClearDisappearTimer();
   }, 0);
  });
 },
 PopulatePopupElements: function(index) {
  var ids = this.GetPopupElementIDList(index);
  for(var i = 0; i < ids.length; i++) {
   var popupElement = _aspxFindPopupElementById(ids[i]);
   if(popupElement)
    this.AddWindowPopupElement(index, popupElement);
  }
 },
 GetPopupElement: function(index, popupElementIndex) {
  var popupElement = this.GetPopupElementList(index)[popupElementIndex];
  return popupElement ? popupElement : null;
 },
 GetPopupElementIDList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementIDList[index];
  return this.defaultWindowPopupElementIDList;
 },
 GetPopupElementList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementList[index];
  return this.defaultWindowPopupElementList;
 },
 SetPopupElementIDs: function(index, ids) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupElementIDList[index] = ids;
  this.defaultWindowPopupElementIDList = ids;
 },
 AddPopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(!popupElements[i]) {
    popupElements[i] = element;
    return i;
   }
  }
  popupElements.push(element);
  return popupElements.length - 1;
 },
 RemovePopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(popupElements[i] == element) {
    popupElements[i] = null;
    return;
   }
  }
 },
 AddPopupElement: function(popupElement) {
  this.AddWindowPopupElement(-1, popupElement);
 },
 AddWindowPopupElement: function(index, popupElement) {
  var popupElementIndex = this.AddPopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, popupElementIndex, true);
 },
 RemovePopupElement: function(popupElement) {
  this.RemoveWindowPopupElement(-1, popupElement);
 },
 RemoveWindowPopupElement: function(index, popupElement) {
  this.RemovePopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, null, false);
 },
 RemoveAllPopupElements: function() {
  this.RemoveWindowAllPopupElements(-1);
 },
 RemoveWindowAllPopupElements: function(index) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++)
   this.RemoveWindowPopupElement(index, popupElements[i]);
 },
 GetIsPopuped: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsIsPopupedList[index];
  return this.defaultIsPopuped;
 },
 SetIsPopuped: function(index, isPopuped) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsIsPopupedList[index] = isPopuped;
  this.defaultIsPopuped = isPopuped;
 },
 GetLastShownPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return _aspxGetDefinedValue(info.shownPEIndex, 0);
 },
 SetLastShownPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.shownPEIndex = popupElementIndex;
 },
 GetLastOverPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return _aspxGetDefinedValue(info.overPEIndex, -1);
 },
 SetLastOverPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.overPEIndex = popupElementIndex;
 },
 GetLastUsedPopupElementInfo: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsLastUsedPopupElementInfoList[index];
  return this.defaultLastUsedPopupElementInfo;
 },
 SetWindowPopUpReasonMouseEvent: function(index, evt) {
  evt = _aspxCloneObject(evt);
  if(evt === undefined)
   evt = null;
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupReasonMouseEventList[index] = evt;
  this.defaultPopupReasonMouseEvent = evt;
 },
 GetPopUpReasonMouseEvent: function() {
  return this.GetWindowPopUpReasonMouseEvent(null);
 },
 GetWindowPopUpReasonMouseEvent: function(window) {
  var index = (window != null) ? window.index : -1;
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupReasonMouseEventList[index];
  return this.defaultPopupReasonMouseEvent;
 },
 GetShadowWidth: function() {
  return this.shadowVisible ? __aspxPopupShadowWidth : 0;
 },
 GetShadowHeight: function() {
  return this.shadowVisible ? __aspxPopupShadowHeight : 0;
 },
 GetShowOnPageLoad: function(index) {
  if(0 <= index && index < this.showOnPageLoadArray.length)
   return this.showOnPageLoadArray[index];
  return this.showOnPageLoad;
 },
 GetWindowCountCore: function() {
  return (this.windows.length > 0) ? this.windows.length : this.windowCount;
 },
 GetWindowIFrame: function(index) {
  var element = this.GetWindowElement(index);
  var iFrame = element.overflowElement;
  if(!iFrame) {
   iFrame = this.FindWindowIFrame(index);
   element.overflowElement = iFrame;
  }
  return iFrame;
 },
 FindWindowIFrame: function(index) {
  return _aspxGetElementById(this.name + "_DXPWIF" + index);
 },
 GetWindowModalElement: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return;
  var modalElement = element.modalElement;
  if(!modalElement) {
   modalElement = this.FindWindowModalElement(index);
   element.modalElement = modalElement;
   if(modalElement) {
    modalElement.DXModalPopupControl = this;
    modalElement.DXModalPopupWindowIndex = index;
   }
  }
  return modalElement;
 },
 FindWindowModalElement: function(index) {
  return _aspxGetElementById(this.name + "_DXPWMB" + index);
 },
 GetWindowElementId: function(index) {
  return this.name + __aspxPCWIdSuffix + index;
 },
 WindowIsModal: function(index) {
  return !!this.GetWindowModalElement(index);
 },
 GetWindowElement: function(index) {
  if(!_aspxIsExistsElement(this.windowElements[index]))
   this.windowElements[index] = _aspxGetElementById(this.GetWindowElementId(index));
  return this.windowElements[index];
 },
 GetWindowCloseButton: function(index) {
  return _aspxGetElementById(this.name + "_HCB" + index);
 },
 GetWindowPinButton: function(index) {
  return _aspxGetElementById(this.name + "_HPB" + index);
 },
 GetWindowRefreshButton: function(index) {
  return _aspxGetElementById(this.name + "_HRB" + index);
 },
 GetWindowCollapseButton: function(index) {
  return _aspxGetElementById(this.name + "_HMNB" + index);
 },
 GetWindowMaximizeButton: function(index) {
  return _aspxGetElementById(this.name + "_HMXB" + index);
 },
 GetWindowChild: function(index, idPostfix) {
  return _aspxGetChildById(this.GetWindowElement(index), this.name + idPostfix);
 },
 GetWindowContentIFrameDivElementID: function(index) {
  return this.name + "_CIFD" + index;
 },
 GetWindowContentIFrameDivElement: function(index) {
  return this.GetWindowChild(index, "_CIFD" + index);
 },
 GetWindowScrollDiv: function(index) {
  return this.GetWindowChild(index, "_CSD" + index);
 },
 GetWindowContentIFrameElementId: function(index) {
  return this.name + "_CIF" + index;
 },
 GetWindowContentIFrameElement: function(index) {
  return this.GetWindowChild(index, "_CIF" + index);
 },
 GetWindowContentIFrameUrl: function(index) {
  if(0 <= index && index < this.contentUrlArray.length)
   return this.contentUrlArray[index];
  return this.contentUrl;
 },
 GetWindowPopupAction: function(index) {
  if(0 <= index && index < this.popupActionArray.length)
   return this.popupActionArray[index];
  return this.popupAction;
 },
 GetWindowCloseAction: function(index) {
  if(0 <= index && index < this.closeActionArray.length)
   return this.closeActionArray[index];
  return this.closeAction;
 },
 SetWindowContentIFrameUrl: function(index, url) {
  if(0 <= index && index < this.contentUrlArray.length)
   this.contentUrlArray[index] = url;
  else
   this.contentUrl = url;
 },
 ShowWindowContentUrl: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  if(!this.liteRender && (__aspxNetscapeFamily || __aspxWebKitFamily || __aspxIE)) {
   var contentIFrameDiv = this.GetWindowContentIFrameDivElement(index);
   if(contentIFrameDiv)
    this.AdjustIFrameDivHeight(index, contentIFrameDiv, contentIFrame);
   if(contentIFrame)
    contentIFrame.style.height = contentIFrameDiv.clientHeight + "px";
  }
  this.LoadWindowContentUrl(index);
  if(contentIFrame && contentIFrame.DXReloadAfterShowRequired) {
   this.RefreshWindowContentUrl(this.GetWindow(index));
   contentIFrame.DXReloadAfterShowRequired = false;
  }
 },
 LoadWindowContentUrl: function(index) {
  var url = this.GetWindowContentIFrameUrl(index);
  this.LoadWindowContentFromUrl(index, url);
 },
 LoadWindowContentFromUrl: function(index, url) {
  var element = this.GetWindowContentIFrameElement(index);
  if(element && element.src != url && element.DXSrcRaw != url) {
   this.SetSrcToIframeElement(index, element, url);
   this.SetWindowContentIFrameUrl(index, element.src); 
  }
 },
 SetSrcToIframeElement: function(index, iframeElement, src) {
  this.SetIframeLoading(index, true);
  iframeElement.src = src;
  if(__aspxChrome && src.indexOf("#"))
   this.PreventScrollingAfterIframeLoaded(iframeElement)
  iframeElement.DXSrcRaw = src;
 },
 PreventScrollingAfterIframeLoaded: function(iframeElement){
  var docScrollTop = _aspxGetDocumentScrollTop();
  var onIframeLoadedHandler = function(){
   window.setTimeout(function() { 
    _aspxSetDocumentScrollTop(docScrollTop);
    _aspxDetachEventFromElement(iframeElement, "load", onIframeLoadedHandler);
   }, 0);
  };
  _aspxAttachEventToElement(iframeElement, "load", onIframeLoadedHandler);
 },
 GetWindowContentElement: function(index) {
  return this.GetWindowChild(index, "_PWC" + index);
 },
 GetWindowHeaderElement: function(index) {
  return this.GetWindowChild(index, "_PWH" + index);
 },
 GetWindowSizeGripElement: function(index) {
  return this.liteRender ? this.GetWindowSizeGripLite(index) : this.GetWindowChild(index, "_FGRP" + index);
 },
 GetWindowSizeGripLite: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(!footer)
   return null;
  var descendants = _aspxGetDescendantNodesByClassName(footer, ASPxClientPopupControlCssClasses.SizeGripLiteCssClassName);
  return descendants.length > 0 ? descendants[0] : null;
 },
 GetWindowFooterElement: function(index) {
  return this.GetWindowChild(index, "_PWF" + index);
 },
 GetContentContainer: function(index) {
  return this.liteRender ? this.GetWindowContentElement(index) : this.GetWindowScrollDiv(index);
 },
 GetWindowIndex: function(element) {
  var id = element.id;
  var pos = id.lastIndexOf(__aspxPCWIdSuffix);
  return parseInt(id.substr(pos + __aspxPCWIdSuffix.length));
 },
 GetWindowMainCell: function(element) {
  if(this.liteRender)
   return this.enableAnimation ? _aspxGetChildByTagName(element, "DIV", 0) : element;
  return this.GetWindowMainTable(element).rows[0].cells[this.rtl && this.shadowVisible ? 1 : 0];
 },
 GetWindowMainTable: function(element) {
  if(this.liteRender)
   return this.GetWindowMainCell(element);
  var index = this.GetWindowIndex(element);
  var shadowTable = this.GetWindowShadowTableCore(index);
  return shadowTable != null ? shadowTable : element;
 },
 GetWindowShadowTable: function(index){
  var shadowTable = this.enableAnimation ? this.GetWindowShadowTableCore(index) : this.GetWindowElement(index);
  if (!shadowTable) return null;
  if(shadowTable.tagName != "TABLE")
   shadowTable = this.GetWindowShadowTableCore(index);
  return (shadowTable && shadowTable.tagName == "TABLE") ? shadowTable : null;
 },
 GetWindowShadowTableCore: function(index) {
  return this.GetWindowChild(index, "_PWST" + index);
 },
 GetWindowClientTable: function(index) {
  if(this.liteRender)
   return this.GetWindowElement(index);
  return this.GetWindowChild(index, "_CLW" + index);
 },
 GetWindowLeft: function(index) {
  if(0 <= index && index < this.leftArray.length)
   return this.leftArray[index];
  return this.left;
 },
 SetWindowLeft: function(index, left) {
  if(0 <= index && index < this.leftArray.length)
   this.leftArray[index] = left;
  else
   this.left = left;
 },
 GetWindowHeightInternal: function(index) {
  if(0 <= index && index < this.heightArray.length)
   return this.heightArray[index];
  return this.height;
 },
 GetWindowMinHeight: function(index) {
  if(0 <= index && index < this.minHeightArray.length)
   return this.minHeightArray[index];
  return this.minHeight;
 },
 GetWindowMaxHeight: function(index) {
  if(0 <= index && index < this.maxHeightArray.length)
   return this.maxHeightArray[index];
  return this.maxHeight;
 },
 SetWindowHeight: function(index, height) {
  if(0 <= index && index < this.heightArray.length)
   this.heightArray[index] = height;
  else
   this.height = height;
 },
 GetWindowWidthInternal: function(index) {
  if(0 <= index && index < this.widthArray.length)
   return this.widthArray[index];
  return this.width;
 },
 GetWindowMinWidth: function(index) {
  if(0 <= index && index < this.minWidthArray.length)
   return this.minWidthArray[index];
  return this.minWidth;
 },
 GetWindowMaxWidth: function(index) {
  if(0 <= index && index < this.maxWidthArray.length)
   return this.maxWidthArray[index];
  return this.maxWidth;
 },
 SetWindowWidth: function(index, width) {
  if(0 <= index && index < this.widthArray.length)
   this.widthArray[index] = width;
  else
   this.width = width;
 },
 GetWindowTop: function(index) {
  if(0 <= index && index < this.topArray.length)
   return this.topArray[index];
  return this.top;
 },
 SetWindowTop: function(index, top) {
  if(0 <= index && index < this.topArray.length)
   return this.topArray[index] = top;
  else
   return this.top = top;
 },
 GetWindowsStateInputElement: function() {
  return _aspxGetElementById(this.name + "WS");
 },
 GetZIndex: function(index) {
  if(0 <= index && index < this.zIndexArray.length)
   return this.zIndexArray[index];
  return this.zIndex;
 },
 GetCurrentZIndex: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(element.style.zIndex != "")
    return element.style.zIndex;
   if(0 <= index && index < this.GetWindowCountCore())
    return this.zIndexArray[index];
   return this.zIndex;
  }
 },
 GetMainWindowWidth: function(index, noCache){
  return this.GetClientWindowWidth(index, true, noCache);
 },
 GetCurrentWindowWidth: function(index) {
  return this.GetClientWindowWidth(index);
 },
 GetClientWindowWidth: function(index, outerSize, noCache) {
  if (!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))){
   var cachedSize = this.GetWindowCachedSize(index);
   if (cachedSize != null)
    return cachedSize.width;
  }
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.liteRender) {
    return element.offsetWidth;
   }
   var mainCell = this.GetWindowMainCell(element);
   if(outerSize && mainCell.offsetWidth > 0)
    return mainCell.offsetWidth;
   if(mainCell.firstChild.offsetWidth > 0)
    return mainCell.firstChild.offsetWidth;
   return this.GetWindowWidthInternal(index);
  }
 },
 GetMainWindowHeight: function(index, noCache){
  return this.GetClientWindowHeight(index, true, noCache);
 },
 GetCurrentWindowHeight: function(index) {
  return this.GetClientWindowHeight(index);
 },
 GetClientWindowHeight: function(index, outerSize, noCache) {
  if (!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))){
   var cachedSize = this.GetWindowCachedSize(index);
   if (cachedSize != null)
    return cachedSize.height;
  }
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.liteRender) {
    return element.offsetHeight;
   }
   var mainCell = this.GetWindowMainCell(element);
   if(outerSize && mainCell.offsetHeight > 0)
    return mainCell.offsetHeight;
   if(mainCell.firstChild.offsetHeight > 0)
    return mainCell.firstChild.offsetHeight;
   return this.GetWindowHeightInternal(index);
  }
 },
 GetIframeLoading: function(index) {
  if(0 <= index && index < this.iframeLoadingArray.length)
   return this.iframeLoadingArray[index];
  return this.iframeLoading;
 },
 SetIframeLoading: function(index, value) {
  if(0 <= index && index < this.iframeLoadingArray.length)
   this.iframeLoadingArray[index] = value;
  else
   this.iframeLoading = value;
 },
 GetAutoUpdatePosition: function(index) {
  if(0 <= index && index < this.autoUpdatePositionArray.length)
   return this.autoUpdatePositionArray[index];
  return this.autoUpdatePosition;
 },
 GetClientPopupPos: function(element, popupElement, pos, isX, isDragged) {
  var index = this.GetWindowIndex(element);
  var popupPosition = null;
  if(isDragged)
   popupPosition = new _aspxPopupPosition(pos == __aspxInvalidPosition ? this.GetPosition(index, isX) : pos, false);
  else
   popupPosition = isX ? this.GetClientPopupPosX(element, popupElement, pos) : this.GetClientPopupPosY(element, popupElement, pos);
  popupPosition.position = _aspxPrepareClientPosForElement(popupPosition.position, element, isX);
  if(__aspxFirefox && __aspxBrowserVersion < 3 && this.GetWindowModalElement(index))
   popupPosition.position -= isX ? _aspxGetDocumentScrollLeft() : _aspxGetDocumentScrollTop();
  return popupPosition;
 },
 GetClientPopupPosX: function(element, popupElement, x) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = _aspxGetPopupAbsoluteX(mainElement, this.GetShadowWidth(), popupElement, this.popupHorizontalAlign, this.popupHorizontalOffset,
   x, this.GetWindowLeft(this.GetWindowIndex(element)), this.rtl);
  return this.CorrectPopupPositionForClientWindow(element, popupPosition, true);
 },
 GetClientPopupPosY: function(element, popupElement, y) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = _aspxGetPopupAbsoluteY(mainElement, this.GetShadowHeight(), popupElement, this.popupVerticalAlign, this.popupVerticalOffset,
   y, this.GetWindowTop(this.GetWindowIndex(element)));
  return (this.allowCorrectYOffsetPosition ? this.CorrectPopupPositionForClientWindow(element, popupPosition, false) : popupPosition);
 },
 CorrectPopupPositionForClientWindow: function(element, popupPosition, isX) {
  if(element.isPopupPositionCorrectionOn) {
   popupPosition.position = _aspxAdjustPositionToClientScreen(element,
    isX ? this.GetShadowWidth() : this.GetShadowHeight(), popupPosition.position, isX);
  }
  return popupPosition;
 },
 DoShowWindow: function(index, popupElementIndex, evt) {
  if(!this.InternalIsWindowVisible(index)) {
   var x = _aspxGetEventX(evt);
   var y = _aspxGetEventY(evt);
   this.DoShowWindowAtPos(index, x, y, popupElementIndex, true, true, evt);
  }
 },
 AdjustContentOnShow: function(index) {
  var windowElement = this.GetWindowElement(index);
  var collection = aspxGetControlCollection();
  if(this.adjustInnerControlsSizeOnShow)
   collection.AdjustControls(windowElement, __aspxCheckSizeCorrectedFlag);
 },
 DoShowWindowAtPos: function(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.adjustInnerControlsSizeOnShow) {
    var windowContent = this.GetContentContainer(index);
    var collection = aspxGetControlCollection();
    collection.CollapseControls(windowContent, __aspxCheckSizeCorrectedFlag);
   }
   this.FFTextCurFixShow(index, true);
   if(closeOtherWindows)
    aspxGetPopupControlCollection().DoHideAllWindows(element, this.GetWindowElementId(index), false);
   var isMoving = this.InternalIsWindowVisible(index);
   _aspxSetElementDisplay(element, true);
   if(this.liteRender) {
    element.style.display = this.HasAnyScrollBars(index) ? "block" : "table";
    element.style.position = "absolute";
   }
   var scrollDiv = this.GetWindowScrollDiv(index),
    shouldResetScrollSize = scrollDiv && this.enableContentScrolling && _aspxGetDocumentMaxClientHeight() <= element.offsetHeight,
    savedScrollDivHeight = shouldResetScrollSize && scrollDiv.style.height;
   if (shouldResetScrollSize)
    scrollDiv.style.height = 0;
   this.CorrectContentCellHeightIfRequired(element, index, false);
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null) {
    this.SetWindowSize(this.GetWindow(index), cachedSize.width, cachedSize.height);
    this.ResetWindowCachedSize(index);
   }
   if(this.liteRender && !this.shown) {
    var liteWidth = Math.max(this.GetWindowWidthInternal(index), this.GetWindowMinWidth(index));
    var maxWidth = this.GetWindowMaxWidth(index);
    if(maxWidth)
     liteWidth = Math.min(liteWidth, maxWidth);
    var liteHeight = Math.max(this.GetWindowHeightInternal(index), this.GetWindowMinHeight(index));
    var maxHeight = this.GetWindowMaxHeight(index);
    if(maxHeight)
     liteHeight = Math.min(liteHeight, maxHeight);
    this.SetClientWindowSizeCoreLite(index, liteWidth, liteHeight);
    this.shown = true;
   }
   this.RefreshRootDivElementSize(index);
   var popupElement = this.GetPopupElement(index, popupElementIndex);
   if(popupElement)
    this.SetLastShownPopupElementIndex(index, popupElementIndex);
   var isDragged = this.GetIsDragged(index);
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, x, true, isDragged);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, y, false, isDragged);
   var clientX = horizontalPopupPosition.position;
   var clientY = verticalPopupPosition.position;
   this.SetWindowPos(index, element, clientX, clientY);
   if(shouldResetScrollSize)
    scrollDiv.style.height = savedScrollDivHeight;
   if(this.hideBodyScrollWhenMaximized && this.GetIsMaximized(index))
    _aspxBodyScrollHelper.HideBodyScroll();
   this.DoShowWindowModalElement(index);
   var isAnimationNeed = this.enableAnimation && !isMoving;
   if(isAnimationNeed) {
    if(this.popupAnimationType === 'slide')
     this.StartSlideAnimation(element, index, horizontalPopupPosition, verticalPopupPosition);
    else
     this.StartFadeAnimation(element, index);
   } else
    _aspxSetElementVisibility(element, true);
   this.SetWindowPopUpReasonMouseEvent(index, evt);
   if(!isMoving) {
    aspxGetPopupControlCollection().RegisterVisibleWindow(element, this, index);
    this.RaisePopUp(index);
    if(!this.enableAnimation)
     this.OnWindowShown(index);
   }
   if(allowChangeZIndex) {
    aspxGetPopupControlCollection().ActivateWindowElement(element);
   }
   if(!isAnimationNeed && __aspxNetscape && this.GetWindowModalElement(index)) {
    _aspxSetElementDisplay(element, false);
    _aspxSetElementDisplay(element, true);
   }
   this.ShowWindowContentUrl(index);
   this.AdjustContentOnShow(index);
   var scrollDiv = this.GetWindowScrollDiv(index);
   if(scrollDiv && this.enableContentScrolling) {
    var dimension = null;
    var windowMainCell = this.GetWindowMainCell(element);
    if(windowMainCell.style.width && windowMainCell.style.height)
     dimension = 'both';
    else if(windowMainCell.style.width)
     dimension = 'width';
    else if(windowMainCell.style.height)
     dimension = 'height';
    if(!dimension)
     return;
    _aspxSetElementDisplay(scrollDiv, false);
    this.SetWindowScrollDivSize(scrollDiv, index, dimension);
    _aspxSetElementDisplay(scrollDiv, true);
    if(this.IsContentCellHeightCorrectionRequired() && !this.liteRender && !element.isSizeCorrectedAfterHeightInit) {
     element.isSizeCorrectedAfterHeightInit = true;
     this.SetWindowSize(this.GetWindow(index), this.GetWindowWidthInternal(index), this.GetWindowHeightInternal(index));
     this.ShowWindowContentUrl(index);
    }
   }
   if(this.liteRender)
    this.CorrectWindowSizeGripPositionLite(index);
   this.NormalizeWindowSize(index);
   this.InitMaximizedWindows(index);
   this.InitCollapsedWindows(index);
   if (this.GetIsPinned(index)) window.setTimeout(function(){this.HoldPosition(index, true);}.aspxBind(this), 0);
  }
 },
 CorrectContentCellHeightIfRequired: function(element, index, isResizing) {
  if(!this.IsContentCellHeightCorrectionRequired() || this.liteRender)
   return;
  if(element.isContentHeightInit && !isResizing)
   return;
  var isDisplayed = _aspxElementIsDisplayed(element);
  this.PrepareContentCellForHeigthCorrection(index);
  this.CorrectContentCellHeight(element, element.isContentHeightInit);
  element.isContentHeightInit = isDisplayed;
 },
 NormalizeWindowSize: function(index) {
  var width = this.GetClientWindowWidth(index),
   height = this.GetClientWindowHeight(index),
   normWidth = width,
   normHeight = height,
   maxWidth = this.GetWindowMaxWidth(index),
   minWidth = this.GetWindowMinWidth(index),
   maxHeight = this.GetWindowMaxHeight(index),
   minHeight = this.GetWindowMinHeight(index);
  if(maxWidth)
   normWidth = Math.min(normWidth, maxWidth);
  if(minWidth)
   normWidth = Math.max(normWidth, minWidth);
  if(maxHeight)
   normHeight = Math.min(normHeight, maxHeight);
  if(minHeight)
   normHeight = Math.max(normHeight, minHeight);
  if(normWidth !== width || normHeight !== height)
   this.SetWindowSize(this.GetWindow(index), normWidth, normHeight);
 },
 RefreshRootDivElementSize: function(index) {
  if(this.WindowRootElementIsDiv()) {
   var window = this.GetWindowElement(index);
   var windowMainTable = this.GetWindowMainTable(window);
   var height = windowMainTable.offsetHeight;
   var width = windowMainTable.offsetWidth;
   if(this.liteRender) {
    height -= _aspxGetTopBottomBordersAndPaddingsSummaryValue(window);
    width -= _aspxGetLeftRightBordersAndPaddingsSummaryValue(window);
   }
   _aspxSetStyleSize(window, width, height);
  }
 },
 WindowRootElementIsDiv: function() {
  return this.enableAnimation;
 },
 DoShowWindowIFrame: function(index, x, y, width, height) {
  if(!this.renderIFrameForPopupElements) return;
  var element = this.GetWindowElement(index);
  var iFrame = this.GetWindowIFrame(index);
  if(element && iFrame) {
   var cell = this.GetWindowMainCell(element);
   if(width < 0)
    width = cell.offsetWidth;
   if(height < 0)
    height = cell.offsetHeight;
   _aspxSetStyleSize(iFrame, width, height);
   if(x != __aspxInvalidPosition && y != __aspxInvalidPosition)
    _aspxSetStylePosition(iFrame, x, y);
   _aspxSetElementDisplay(iFrame, true);
  }
 },
 DoShowWindowModalElement: function(index) {
  var modalElement = this.GetWindowModalElement(index);
  if(modalElement) {
   var bodyScrollHasJustBeingHidden = false;
   if(this.hideBodyScrollWhenModal && !this.IsWindowVisible(this.GetWindow(index))) {
    bodyScrollHasJustBeingHidden = true;
    aspxGetPopupControlCollection().LockWindowResizeByBodyScrollVisibilityChanging();
    _aspxBodyScrollHelper.HideBodyScroll();
   }
   _aspxSetElementDisplay(modalElement, true);
   aspxGetPopupControlCollection().AdjustModalElementBounds(modalElement);
   if(this.popupAnimationType == "fade") {
    var endOpacity = _aspxGetElementOpacity(modalElement);
    if(__aspxIE && __aspxBrowserMajorVersion < 9) {
     _aspxSetElementVisibility(modalElement, true);
     ASPxAnimationHelper.setOpacity(modalElement, 0);
    } else {
     ASPxAnimationHelper.setOpacity(modalElement, 0);
     _aspxSetElementVisibility(modalElement, true);
    }
    ASPxAnimationHelper.fadeTo(modalElement, endOpacity);
   } else {
    _aspxSetElementVisibility(modalElement, true);
   }
   aspxGetPopupControlCollection().RegisterVisibleModalElement(modalElement);
   if(bodyScrollHasJustBeingHidden)
    aspxGetPopupControlCollection().UnlockWindowResizeByBodyScrollVisibilityChanging();
  }
 },
 DoHideWindowCore: function(index) {
  this.FFTextCurFixHide(index, true);
  var element = this.GetWindowElement(index);
  if(element != null) {
   element.isHiding = true;
   this.SetIsDragged(index, false);
   this.UpdateWindowsStateInputElement();
   this.UpdateWindowsStateCookie();
   element.isHiding = false;
   if(this.enableAnimation) {
    var stopAnimation = this.popupAnimationType === 'slide' ? _aspxStopAnimation : ASPxAnimationHelper.cancelAnimation;
    stopAnimation(element);
   }
   _aspxSetElementVisibility(element, false);
   _aspxSetElementDisplay(element, false);
   if(this.hideBodyScrollWhenMaximized && this.GetIsMaximized(index))
    _aspxBodyScrollHelper.RestoreBodyScroll();
   this.DoHideWindowModalElement(element);
   this.DoHideWindowIFrame(element);
   aspxGetPopupControlCollection().UnregisterVisibleWindow(element);
  }
 },
 DoHideWindow: function(index, dontRaiseClosing) {
  if(!this.InternalIsWindowVisible(index)) return;
  var cancel = !dontRaiseClosing && this.RaiseClosing(index);
  if(!cancel) {
   this.DoHideWindowCore(index);
   this.RaiseCloseUp(index);
  }
  return cancel;
 },
 DoHideWindowIFrame: function(element) {
  if(!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(iFrame)
   _aspxSetElementDisplay(iFrame, false);
 },
 DoHideWindowModalElement: function(element) {
  var modalElement = element.modalElement;
  if(modalElement) {
   aspxGetPopupControlCollection().UnregisterVisibleModalElement(modalElement);
   if(this.hideBodyScrollWhenModal) {
    if(__aspxWebKitFamily)
     aspxGetPopupControlCollection().LockScrollEvent();
    _aspxBodyScrollHelper.RestoreBodyScroll();
    if(__aspxWebKitFamily)
     aspxGetPopupControlCollection().UnlockScrollEvent();
   }
   _aspxSetStyleSize(modalElement, 1, 1);
   _aspxSetElementVisibility(modalElement, false);
   _aspxSetElementDisplay(modalElement, false);
  }
 },
 SetWindowDisplay: function(index, value) {
  var pcwElement = this.GetWindowElement(index);
  this.SetFFTextCurFixShowing(index, value, false);
  _aspxSetElementDisplay(pcwElement, value);
 },
 GetTextCurFixDiv: function(index) {
  return _aspxGetElementById(this.name + "_" + "TCFix" + index);
 },
 FFTextCurFixShow: function(index, isSetVisibility) {
  this.SetFFTextCurFixShowing(index, true, isSetVisibility);
 },
 FFTextCurFixHide: function(index, isSetVisibility) {
  this.SetFFTextCurFixShowing(index, false, isSetVisibility);
 },
 IsFFTextCurFixRequired: function(index) {
  return __aspxFirefox && __aspxBrowserVersion < 3 && this.GetWindowModalElement(index);
 },
 SetFFTextCurFixShowing: function(index, value, isSetVisibility) {
  if(this.IsFFTextCurFixRequired(index)) {
   var fixDiv = this.GetTextCurFixDiv(index);
   if(fixDiv) {
    if(isSetVisibility)
     _aspxSetElementVisibility(fixDiv, value);
    _aspxSetElementDisplay(fixDiv, value);
   }
  }
 },
 SetWindowPos: function(index, element, x, y) {
  _aspxSetStylePosition(element, x, y);
  this.DoShowWindowIFrame(index, x, y, __aspxInvalidDimension, __aspxInvalidDimension);
  this.SetIsDragged(index, true);
  this.SetWindowLeft(index, _aspxGetAbsoluteX(element));
  this.SetWindowTop(index, _aspxGetAbsoluteY(element));
  this.UpdateWindowsStateInputElement();
  this.UpdateWindowsStateCookie();
 },
 OnWindowShown: function(windowIndex) {
  this.EnsureContent(windowIndex, false);
  this.RaiseShowen(windowIndex);
 },
 EnsureContent: function(windowIndex, isInit) {
  var element = this.GetWindowElement(windowIndex);
  if(element && !element.loaded && !element.loading) {
   var shouldLoad = this.contentLoadingMode == "OnPageLoad" || this.contentLoadingMode == "OnFirstShow" && !isInit;
   if(shouldLoad) {
    element.loading = true;
    this.CreateWindowCallback(windowIndex, windowIndex);
   } else if(this.contentLoadingMode == "Default")
    element.loaded = true;
  }
 },
 CreateWindowCallback: function(windowIndex, argument) {
  this.ShowWindowLoadingElements(windowIndex);
  this.CreateCallback(argument);
 },
 OnCallback: function(result) {
  this.OnCallbackInternal(result.html, result.index, false);
 },
 OnCallbackError: function(result, data) {
  this.OnCallbackInternal(result, -1, true);
 },
 RaiseCallbackError: function (message) {
  var result = ASPxClientControl.prototype.RaiseCallbackError.call(this, message);
  if (result.isHandled)
   this.HideAllLoadingPanels();
  return result;
 },
 OnCallbackInternal: function(html, windowIndex, isError) {
  var element = this.GetWindowElement(windowIndex);
  element.loaded = !isError;
  element.loading = false;
  this.HideWindowLoadingPanel(windowIndex);
  this.SetWindowContentHtmlCore(windowIndex, html)
  this.savedCallbackWindowIndex = windowIndex;
  this.UpdateWindowsStateInputElement();
  this.UpdateWindowsStateCookie();
 },
 InWindowCallback: function(windowIndex) {
  return !!this.loadingPanels[windowIndex];
 },
 ShowWindowLoadingElements: function(windowIndex) {
  if(this.lpTimers[windowIndex] && this.lpTimers[windowIndex] > -1) return;
  if(this.enableCallbackAnimation)
   this.StartWindowBeginCallbackAnimation(windowIndex);
  else
   this.ShowWindowLoadingElementsInternal(windowIndex);
 },
 ShowWindowLoadingElementsInternal: function(windowIndex) {
  if(this.lpDelay > 1 && !this.enableCallbackAnimation) {
   var _this = this;
   this.lpTimers[windowIndex] = _aspxSetTimeout(function() { _this.ShowWindowLoadingPanelOnTimer(windowIndex); }, this.lpDelay);
  }
  else 
   this.ShowWindowLoadingPanel(windowIndex);
 },
 StartWindowBeginCallbackAnimation: function (windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  this.isCallbackFinishedStates[windowIndex] = false;
  ASPxAnimationHelper.fadeOut(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowBeginCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowBeginCallbackAnimation: function (windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = false;
  if(!this.isCallbackFinishedStates[windowIndex])
   this.ShowWindowLoadingElementsInternal(windowIndex);
  else 
   this.DoCallback(this.savedCallbackResults[windowIndex]);
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  var windowIndex = this.EvalCallbackResult(callbackResult).result.index;
  if(this.enableCallbackAnimation && this.callbackAnimationProcessings[windowIndex]) {
   this.savedCallbackResults[windowIndex] = callbackResult;
   this.isCallbackFinishedStates[windowIndex] = true;
   return true;
  }
  return false;
 },
 StartWindowEndCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  ASPxAnimationHelper.fadeIn(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowEndCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowEndCallbackAnimation: function(windowIndex) {
  this.DoEndCallback();
  this.callbackAnimationProcessings[windowIndex] = false;
 },
 CheckEndCallbackAnimationNeeded: function() {
  var windowIndex = this.savedCallbackWindowIndex;
  this.savedCallbackWindowIndex = null;
  if(windowIndex !== null && !this.callbackAnimationProcessings[windowIndex]) {
   this.StartWindowEndCallbackAnimation(windowIndex);
   return true;
  }
  return false;
 },
 ShowWindowLoadingPanelOnTimer: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  this.ShowWindowLoadingPanel(windowIndex);
 },
 ClearWindowLoadingPanelTimer: function(windowIndex) {
  this.lpTimers[windowIndex] = _aspxClearTimer(this.lpTimers[windowIndex]);  
 },
 ShowWindowLoadingPanel: function(windowIndex) {
  if(!this.loadingPanels[windowIndex]) {
   var contentElement = this.liteRender ? this.GetWindowContentWrapperElement(windowIndex) : this.GetWindowContentElement(windowIndex);
   this.loadingDivs[windowIndex] = this.CreateLoadingDiv(this.GetWindowElement(windowIndex).parentNode, contentElement);
   this.loadingPanels[windowIndex] = this.CreateLoadingPanelWithAbsolutePosition(this.GetWindowElement(windowIndex).parentNode, contentElement);
  }
 },
 HideAllLoadingPanels: function () {
  if (this.HasDefaultWindow())
   this.HideWindowLoadingPanel(-1);
  for (var i = 0; i < this.GetWindowCount() ; i++)
   this.HideWindowLoadingPanel(i);
 },
 HideWindowLoadingPanel: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  if(this.loadingDivs[windowIndex]) {
   _aspxRemoveElement(this.loadingDivs[windowIndex]);
   this.loadingDivs[windowIndex] = null;
  }
  if(this.loadingPanels[windowIndex]) {
   _aspxRemoveElement(this.loadingPanels[windowIndex]);
   this.loadingPanels[windowIndex] = null;
  }
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 },
 IsLoadingContainerVisible: function() {
  return true;
 },
 PerformCallback: function(parameter) {
  this.PerformWindowCallback(null, parameter);
 },
 PerformWindowCallback: function(window, parameter) {
  parameter = _aspxIsExists(parameter) ? parameter.toString() : ""
  var index = (window != null) ? window.index : -1;
  if(!this.InWindowCallback(index)) {
   var windowCallbackArguments = index + ";" + parameter;
   this.CreateWindowCallback(index, windowCallbackArguments);
  }
 },
 PrepareContentCellForHeigthCorrection: function(windowIndex) {
  if(__aspxIE)
   this.GetWindowContentElement(windowIndex).style.height = "0px";
 },
 IsContentCellHeightCorrectionRequired: function() {
  return __aspxIE || __aspxOpera;
 },
 CorrectContentCellHeight: function(element, isResizing) {
  if(__aspxIE)
   this.CorrectContentCellHeightIE(element, isResizing);
  if(__aspxOpera)
   this.CorrectContentCellHeightOpera(element, isResizing);
 },
 CorrectContentCellHeightOpera: function(element, isResizing) {
  var index = this.GetWindowIndex(element);
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  if(contentIFrame) {
   contentIFrame.style.height = "0px";
   var contentIFrameDiv = this.GetWindowContentIFrameDivElement(index);
   if(contentIFrameDiv)
    contentIFrameDiv.style.height = "0px";
   var contentCell = this.GetWindowContentElement(index);
   var height = contentCell.clientHeight;
   contentIFrame.style.height = height + "px";
   if(contentIFrameDiv)
    contentIFrameDiv.style.height = contentIFrame.style.height;
   var correction = contentCell.clientHeight - height;
   contentIFrame.style.height = (height - correction) + "px";
   if(contentIFrameDiv)
    contentIFrameDiv.style.height = contentIFrame.style.height;
  }
 },
 CorrectContentCellHeightIE: function(element, isResizing) {  
  var index = this.GetWindowIndex(element);
  var clientTable = this.GetWindowClientTable(index);
  var headerCell = this.GetWindowHeaderElement(index);
  var contentCell = this.GetWindowContentElement(index);
  var footerCell = this.GetWindowFooterElement(index);
  var windowMainCell = this.GetWindowMainCell(element);
  var mainCellHeight = windowMainCell.clientHeight - this.GetTwoVerticalPaddingSize(windowMainCell);
  var headerHeight = headerCell ? _aspxGetCeilOffsetHeight(headerCell) : 0;
  var footerHeight = footerCell ? footerCell.offsetHeight : 0;
  if(isResizing) {
   headerHeight = this.GetHeaderHeight(index);
   footerHeight = this.GetFooterHeight(index);
  }
  else {
   this.SetHeaderHeight(index, headerHeight);
   this.SetFooterHeight(index, footerHeight);
  }
  var correctedHeight = Math.max(0, mainCellHeight - headerHeight - footerHeight);
  contentCell.style.height = correctedHeight + "px";
  var verticalsPaddings = contentCell.offsetHeight - correctedHeight;
  contentCell.style.height = correctedHeight - verticalsPaddings + "px";
 },
 GetTwoVerticalPaddingSize: function(element) {
  var heightWithBorders = element.clientHeight;
  var paddingTopBackup = element.style.paddingTop;
  var paddingBottomBackup = element.style.paddingBottom;
  element.style.paddingTop = "0px";
  element.style.paddingBottom = "0px";
  var heightWithoutBorders = element.clientHeight;
  element.style.paddingTop = paddingTopBackup;
  element.style.paddingBottom = paddingBottomBackup;
  return (heightWithBorders - heightWithoutBorders);
 },
 InternalIsWindowVisible: function(index) {
  var element = this.GetWindowElement(index);
  if(!element)
   return false;
  var currentStyle = _aspxGetCurrentStyle(element);
  return ((currentStyle && currentStyle.visibility != "hidden") ? true : false);
 },
 InternalIsWindowDisplayed: function(index) {
  var element = this.GetWindowElement(index);
  return (element != null) ? _aspxGetElementDisplay(element) : false;
 },
 OnActivate: function(index, evt) {
  var element = this.GetWindowElement(index);
  if(element != null)
   aspxGetPopupControlCollection().ActivateWindowElement(element, evt);
 },
 OnAnimationTimer: function(index) {
  var animationDivElement = this.GetWindowElement(index);
  if(animationDivElement) {
   var element = this.GetWindowMainTable(animationDivElement);
   var mainCell = this.GetWindowMainCell(animationDivElement);
   var iframeElement = this.GetWindowIFrame(index);
   _aspxOnAnimationTimer(animationDivElement, element, mainCell, iframeElement, this.animationDelay, this.animationMaxDelay, __aspxPCAnimationAccelerator);
  }
 },
 OnAnimationStop: function(index) {
  this.OnWindowShown(index);
  if(this.liteRender && __aspxFirefox) {
   this.GetWindowElement(index).style.display = "table";
  }
 },
 OnDragStart: function(evt, index) {
  this.SetIsDragged(index, true);
  this.ShowDragCursor(index);
  if(this.GetWindowContentIFrameElement(index))
   this.HideIframeElementBeforeDragging(index);
  this.InitDragInfo(index, evt);
 },
 InitDragInfo: function(index, evt) {
  var element = this.GetWindowElement(index);
  var gragXOffset = _aspxGetAbsoluteX(element) - _aspxGetEventX(evt);
  var gragYOffset = _aspxGetAbsoluteY(element) - _aspxGetEventY(evt);
  var xClientCorrection = _aspxGetPositionElementOffset(element, true);
  var yClientCorrection = _aspxGetPositionElementOffset(element, false);
  gragXOffset -= xClientCorrection;
  gragYOffset -= yClientCorrection;
  aspxGetPopupControlCollection().InitDragObject(this, index, gragXOffset, gragYOffset, xClientCorrection, yClientCorrection);
 },
 OnDrag: function(index, x, y, xClientCorrection, yClientCorrection) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   _aspxSetStylePosition(element, x, y);
   this.SetWindowLeft(index, x + xClientCorrection);
   this.SetWindowTop(index, y + yClientCorrection);
   var iFrame = element.overflowElement;
   if(iFrame)
    _aspxSetStylePosition(iFrame, x, y);
   if(__aspxOpera)
    _aspxClearSelection();
  }
 },
 OnDragStop: function(index) {
  var element = this.GetWindowElement(index);
  this.HideDragCursor(index);
  this.UpdateWindowsStateInputElement();
  this.UpdateWindowsStateCookie();
  if(this.GetWindowContentIFrameElement(index))
   this.ShowIframeElementAfterDragging(index);
 },
 OnPopupElementMouseOver: function(evt, popupElement) {
  if(popupElement != null) {
   var index = popupElement.DXPopupWindowIndex;
   var isVisible = this.InternalIsWindowVisible(index);
   var popupElementIndex = popupElement.DXPopupElementIndex;
   if(this.GetLastOverPopupElementIndex(index) != popupElementIndex) {
    if(aspxGetPopupControlCollection().IsAppearTimerActive())
     aspxGetPopupControlCollection().ClearAppearTimer();
    if(aspxGetPopupControlCollection().IsDisappearTimerActive())
     aspxGetPopupControlCollection().ClearDisappearTimer();
    if(isVisible) {
     this.DoHideWindow(index);
     isVisible = false;
    }
   }
   if(!isVisible) {
    aspxGetPopupControlCollection().SetAppearTimer(this.name, index, popupElement.DXPopupElementIndex, this.appearAfter, evt);
    aspxGetPopupControlCollection().InitOverObject(this, index, evt);
   }
   this.SetLastOverPopupElementIndex(index, popupElementIndex);
  }
 },
 OnPopupElementMouseOut: function(evt, popupElement) {
 },
 HideIframeElementBeforeDragging: function(index) {
  var iframeElement = this.GetWindowContentIFrameElement(index);
  if(__aspxIE) {
   this.CreateFakeDragDiv(iframeElement);
   _aspxSetElementDisplay(iframeElement, false);
  } else
   _aspxSetElementVisibility(iframeElement, false);
 },
 ShowIframeElementAfterDragging: function(index) {
  var iframeElement = this.GetWindowContentIFrameElement(index);
  if(this.fakeDragDiv != null) {
   this.RemoveFakeDragDiv(iframeElement);
   _aspxSetElementDisplay(iframeElement, true);
  } else
   _aspxSetElementVisibility(iframeElement, true);
 },
 CreateFakeDragDiv: function(iframe) {
  this.fakeDragDiv = document.createElement("div");
  _aspxSetStyleSize(this.fakeDragDiv, iframe.offsetWidth, iframe.offsetHeight);
  iframe.parentElement.appendChild(this.fakeDragDiv);
 },
 RemoveFakeDragDiv: function(iframe) {
  iframe.parentElement.removeChild(this.fakeDragDiv);
  this.fakeDragDiv = null;
 },
 CreateResizePanel: function(index) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var resizePanel = document.createElement("DIV");
  element.parentNode.appendChild(resizePanel);
  resizePanel.style.overflow = "hidden";
  resizePanel.style.position = "absolute";
  resizePanel.style.zIndex = __aspxPopupControlZIndex + aspxGetPopupControlCollection().visiblePopupWindowIds.length * 2 + 2;
  if(!this.isLiveResizingMode)
   resizePanel.style.border = "black 1px dotted";
  return resizePanel;
 },
 OnResizeStart: function(evt, index) {
  if(!aspxGetPopupControlCollection().IsResizeInint()) {
   this.SetIsResized(index, true);
   var cursor = this.CreateResizeCursorInfo(evt, index);
   if(cursor.course != "") {
    var resizePanel = this.CreateResizePanel(index);
    this.UpdateResizeCursor(resizePanel, cursor.verticalDirection, cursor.horizontalDirection);
    aspxGetPopupControlCollection().InitResizeObject(this, index, cursor, resizePanel);
    this.OnResize(evt, index, cursor, resizePanel);
   }
  }
  return aspxGetPopupControlCollection().IsResizeInint();
 },
 OnResize: function(evt, index, cursor, resizePanel) {
  if(this.liteRender)
   this.OnResizePanelLite(evt, index, cursor, resizePanel);
  else
   this.OnResizePanel(evt, index, cursor, resizePanel);
  if(this.isLiveResizingMode)
   this.OnResizeWindow(index, cursor, resizePanel);
  _aspxClearSelection();
  if(__aspxWebKitTouchUI)
   evt.preventDefault();
  if (this.GetIsPinned(index))
   this.HoldPosition(index, true, resizePanel);
 },
 OnResizePanelLite: function(evt, index, cursor, resizePanel) {
  var x = _aspxGetEventX(evt);
  var y = _aspxGetEventY(evt);
  var element = this.GetWindowElement(index);
  var newLeft = _aspxGetAbsoluteX(element);
  var newTop = _aspxGetAbsoluteY(element);
  var newWidth = element.offsetWidth;
  var newHeight = element.offsetHeight;
  if(cursor.verticalDirection == "n") {
   if(!this.fixedBottom)
    this.fixedBottom = newTop + newHeight;
   newHeight = newHeight + (newTop - y) + cursor.verticalOffset;
   newTop = y - cursor.verticalOffset;
  }
  if(cursor.verticalDirection == "s") {
   newHeight = newHeight + (y - (newTop + newHeight)) + cursor.verticalOffset;
   this.fixedBottom = null;
  }
  if(cursor.horizontalDirection == "w") {
   if(!this.fixedRight)
    this.fixedRight = newLeft + newWidth;
   newWidth = newWidth + (newLeft - x) + cursor.horizontalOffset;
   newLeft = x - cursor.horizontalOffset;
  }
  if(cursor.horizontalDirection == "e") {
   newWidth = newWidth + (x - (newLeft + newWidth)) + cursor.horizontalOffset;
   this.fixedRight = null;
  }
  if(newWidth > 0 && newHeight > 0) {
   var minWidth = this.GetWindowMinWidth(index);
   var maxWidth = this.GetWindowMaxWidth(index);
   if(minWidth && newWidth < minWidth)
    newWidth = minWidth;
   if(maxWidth && newWidth > maxWidth)
    newWidth = maxWidth;
   var minHeight = this.GetWindowMinHeight(index);
   var maxHeight = this.GetWindowMaxHeight(index);
   if(minHeight && newHeight < minHeight)
    newHeight = minHeight;
   if(maxHeight && newHeight > maxHeight)
    newHeight = maxHeight;
   newLeft = _aspxPrepareClientPosForElement(newLeft, element, true);
   newTop = _aspxPrepareClientPosForElement(newTop, element, false);
   _aspxSetStylePosition(resizePanel, newLeft, newTop);
   _aspxSetStyleSize(resizePanel, newWidth, newHeight);
   this.SetWindowLeft(index, _aspxGetAbsoluteX(element));
   this.SetWindowTop(index, _aspxGetAbsoluteY(element));
  }
 },
 OnResizePanel: function(evt, index, cursor, resizePanel) {
  var x = _aspxGetEventX(evt);
  var y = _aspxGetEventY(evt);
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var clientWindow = this.GetWindowClientTable(index);
  var left = _aspxGetAbsoluteX(mainCell);
  var top = _aspxGetAbsoluteY(mainCell);
  var newLeft = _aspxGetAbsoluteX(element);
  var newTop = _aspxGetAbsoluteY(element);
  var newHeight = mainCell.offsetHeight;
  var newWidth = mainCell.offsetWidth;
  var oldHeight = newHeight;
  var oldWidth = newWidth;
  if(cursor.horizontalDirection == "e") {
   newWidth = x - newLeft + cursor.horizontalOffset;
   if(!this.liteRender)
    newWidth++;
  }
  if(cursor.verticalDirection == "s") {
   newHeight = y - newTop + cursor.verticalOffset;
   if(!this.liteRender)
    newHeight++;
  }
  if(cursor.horizontalDirection == "w") {
   newWidth = newWidth - (x - left) + cursor.horizontalOffset;
   newLeft = _aspxPrepareClientPosForElement(x, element, true) - cursor.horizontalOffset;
  } else
   newLeft = _aspxPrepareClientPosForElement(newLeft, element, true);
  if(cursor.verticalDirection == "n") {
   newTop = _aspxPrepareClientPosForElement(y, element, false) - cursor.verticalOffset;
   newHeight = newHeight - (y - top) + cursor.verticalOffset;
  } else
   newTop = _aspxPrepareClientPosForElement(newTop, element, false);
  if(!this.isLiveResizingMode) {
   newWidth -= 2;
   newHeight -= 2;
  }
  if(newWidth > 0 && newHeight > 0) {
   var minWidth = this.GetWindowMinWidth(index);
   if(minWidth && newWidth < minWidth) {
    newWidth = minWidth;
    if(cursor.horizontalDirection == "w")
     newLeft = left + oldWidth - newWidth;
   }
   var maxWidth = this.GetWindowMaxWidth(index);
   if(maxWidth && newWidth > maxWidth) {
    newWidth = maxWidth;
    if(cursor.horizontalDirection == "w")
     newLeft = left + oldWidth - newWidth;
   }
   var minHeight = this.GetWindowMinHeight(index);
   if(minHeight && newHeight < minHeight) {
    newHeight = minHeight;
    if(cursor.verticalDirection == "n")
     newTop = top + oldHeight - newHeight;
   }
   var maxHeight = this.GetWindowMaxHeight(index);
   if(maxHeight && newHeight > maxHeight) {
    newHeight = maxHeight;
    if(cursor.verticalDirection == "n")
     newTop = top + oldHeight - newHeight;
   }
   _aspxSetStylePosition(resizePanel, newLeft, newTop);
   _aspxSetStyleSize(resizePanel, newWidth, newHeight);
   this.SetWindowLeft(index, _aspxGetAbsoluteX(element));
   this.SetWindowTop(index, _aspxGetAbsoluteY(element));
  }
 },
 OnResizeWindow: function(index, cursor, resizePanel) {
  var windowElement = this.GetWindowElement(index);
  var left = _aspxGetAbsoluteX(resizePanel);
  var top = _aspxGetAbsoluteY(resizePanel);
  if(this.liteRender) {
   this.SetClientWindowSizeLite(index, resizePanel.offsetWidth, resizePanel.offsetHeight);
   var bottom = top + windowElement.offsetHeight;
   var right = left + windowElement.offsetWidth;
   if(this.fixedBottom && (bottom > this.fixedBottom || bottom < this.fixedBottom))
    top = this.fixedBottom - windowElement.offsetHeight;
   if(this.fixedRight && (right > this.fixedRight || right < this.fixedRight))
    left = this.fixedRight - windowElement.offsetWidth;
   this.fixedBottom = null;
   this.fixedRight = null;
  } else {
   this.SetClientWindowSize(index, resizePanel.offsetWidth, resizePanel.offsetHeight);
   var correctionElement = this.GetWindowMainCell(windowElement);
   if(cursor.horizontalDirection == "w")
    left -= correctionElement.offsetWidth - resizePanel.offsetWidth;
   if(cursor.verticalDirection == "n")
    top -= correctionElement.offsetHeight - resizePanel.offsetHeight;
  }
  _aspxSetStylePosition(windowElement, _aspxPrepareClientPosForElement(left, windowElement, true),
   _aspxPrepareClientPosForElement(top, windowElement, false));
  if(this.InternalIsWindowVisible(index)) 
   this.DoShowWindowIFrame(index, left, top, __aspxInvalidDimension, __aspxInvalidDimension);
 },
 OnResizeStop: function(evt, index, cursor, resizePanel) {
  if(this.allowResize) {
   if(!this.isLiveResizingMode) {
    var collection = aspxGetControlCollection();
    var windowElement = this.GetWindowElement(index);
    collection.CollapseControls(windowElement);
    this.OnResizeWindow(index, cursor, resizePanel);
   }
   this.CreateResizeCursorInfo(evt, index);
   this.UpdateWindowsStateInputElement();
   this.UpdateWindowsStateCookie();
   this.RaiseResize(index);
   if(!this.isLiveResizingMode)
    collection.AdjustControls(windowElement);
   this.SetWindowCachedSize(index, this.GetClientWindowWidth(index), this.GetClientWindowHeight(index));
  }
 },
 OnMouseDownModalElement: function(evt, index) {
  aspxGetPopupControlCollection().DoHideAllWindows(_aspxGetEventSource(evt), "", false);
  this.SetIsPopuped(index, true)
 },
 IsRaiseAfterResizingLocked: function(){
  return this.CollapseExecuting() || this.MaximizationExecuting();
 },
 SetClientWindowSizeLite: function(index, width, height) {
  this.RaiseBeforeResizing(index);
  this.SetClientWindowSizeCoreLite(index, width, height);
  if(!this.IsRaiseAfterResizingLocked())
   this.RaiseAfterResizing(index);
 },
 HasAnyScrollBars: function(index) {
  var contentElement = this.GetWindowContentElement(index);
  var hasBothScrollBars = contentElement.style.overflow == "scroll" || contentElement.style.overflow == "auto";
  return hasBothScrollBars || contentElement.style.overflowX == "scroll" ||
    contentElement.style.overflowY == "scroll" || contentElement.style.overflowX == "auto" ||
    contentElement.style.overflowY == "auto";
 },
 SetClientWindowSizeCoreLite: function(index, width, height) {
  var contentUrl = this.GetWindowContentIFrameUrl(index);
  var element = this.GetWindowElement(index);
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  var contentElement = this.GetWindowContentElement(index);
  contentWrapper.style.height = "";
  contentWrapper.style.width = "";
  contentElement.style.height = "";
  contentElement.style.width = "";
  if(!contentUrl)
   contentElement.style.display = "none";
  var hasAnyScrollBars = this.HasAnyScrollBars(index);
  var elementsDisplayValue = (width || height) && hasAnyScrollBars ? "block" : "table";
  element.style.display = elementsDisplayValue;
  if (!this.GetIsCollapsed(index))
   contentWrapper.style.display = elementsDisplayValue;
  if(width) {
   var actualWidth = width - _aspxGetLeftRightBordersAndPaddingsSummaryValue(element);
   if(actualWidth < 0)
    actualWidth = 0;
   element.style.width = actualWidth + "px";
   if (this.liteRender && (element.offsetWidth != width)){
    actualWidth += (width - element.offsetWidth);
    if(actualWidth < 0) actualWidth = 0;
    element.style.width = actualWidth + "px";
   }
   if(__aspxWebKitFamily && hasAnyScrollBars) {
    var mainDiv = this.GetWindowMainCell(element);
    contentWrapper.style.width = width - _aspxGetLeftRightBordersAndPaddingsSummaryValue(mainDiv) + "px";
   }
  }
  if(height) {
   var actualHeight = height - _aspxGetTopBottomBordersAndPaddingsSummaryValue(element);
   if(actualHeight < 0)
    actualHeight = 0;
   element.style.height = actualHeight + "px";
   if (this.liteRender && (element.offsetHeight != height)){
    actualHeight += (height - element.offsetHeight);
    if(actualHeight < 0) actualHeight = 0;
    element.style.height = actualHeight + "px";
   }
  }
  this.CorrectWindowSizeGripPositionLite(index);
  this.SetContentWrapperHeightLite(index);
  var correctContentElementSize = hasAnyScrollBars || contentElement.style.overflow == "hidden" || contentElement.style.overflowX == "hidden" || contentElement.style.overflowY == "hidden";
  if((correctContentElementSize || contentUrl) && _aspxIsExists(height)) {
   var contentHeight = _aspxGetClearClientHeight(contentWrapper) -
    _aspxGetTopBottomBordersAndPaddingsSummaryValue(contentElement);
   if(contentHeight < 0)
    contentHeight = 0;
   contentElement.style.height = contentHeight + "px";
  }
  if(correctContentElementSize && _aspxIsExists(width))
   _aspxSetOffsetWidth(contentElement, _aspxGetClearClientWidth(contentWrapper));
  contentElement.style.display = "block";
  this.SetWindowWidth(index, width);
  this.SetWindowHeight(index, height);
 },
 SetClientWindowSize: function(index, width, height) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var clientWindow = this.GetWindowClientTable(index);
  var scrollDiv = this.GetWindowScrollDiv(index);
  if(scrollDiv && this.enableContentScrolling)
   _aspxSetElementDisplay(scrollDiv, false);
  element.style.height = "0px";
  element.style.width = "0px";
  var windowHorizontalTwoBorderSize = mainCell.offsetWidth - clientWindow.offsetWidth;
  var windowVerticalTwoBorderSize = mainCell.offsetHeight - clientWindow.offsetHeight;
  var contentIFrameDiv = this.GetWindowContentIFrameDivElement(index);
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  width -= windowHorizontalTwoBorderSize;
  height -= windowVerticalTwoBorderSize;
  if(width < 0) width = 0;
  if(height < 0) height = 0;
  this.RaiseBeforeResizing(index);
  if(__aspxIE) {
   this.PrepareContentCellForHeigthCorrection(index);
   mainCell.style.height = "0px"; 
  }
  if(contentIFrame)
   contentIFrame.style.height = "0px";
  if(contentIFrameDiv)
   contentIFrameDiv.style.height = "0px";
  _aspxSetStyleSize(clientWindow, width, height);
  var mainCellHeight = __aspxFirefox && height == 0 ? 1 : 0; 
  _aspxSetStyleSize(mainCell, width, mainCellHeight);
  if(__aspxNetscapeFamily) {
   _aspxSetElementDisplay(element, false);
   if(this.liteRender)
    element.style.display = "table";
   else
    _aspxSetElementDisplay(element, true);
  }
  _aspxSetStyleSize(element, clientWindow.offsetWidth + this.GetShadowWidth() + windowHorizontalTwoBorderSize, clientWindow.offsetHeight + this.GetShadowHeight() + windowVerticalTwoBorderSize);
  this.CorrectContentCellHeightIfRequired(element, index, true);
  this.SetWindowWidth(index, clientWindow.offsetWidth);
  this.SetWindowHeight(index, clientWindow.offsetHeight);
  if(contentIFrameDiv)
   this.AdjustIFrameDivHeight(index, contentIFrameDiv, contentIFrame);
  if(contentIFrame)
   contentIFrame.style.height = "100%";
  if(scrollDiv && this.enableContentScrolling) {
   this.SetWindowScrollDivSize(scrollDiv, index, 'both');
   _aspxSetElementDisplay(scrollDiv, true);
  }
  if(!this.IsRaiseAfterResizingLocked())
   this.RaiseAfterResizing(index);
 },
 SetContentWrapperHeightLite: function(index) {
  var windowElem = this.GetWindowElement(index);
  if(!windowElem.style.height || windowElem.style.height.indexOf("%") >= 0)
   return;
  var borderOwner;
  if(_aspxElementHasCssClass(windowElem, ASPxClientPopupControlCssClasses.MainDivLiteCssClass))
   borderOwner = windowElem;
  else
   borderOwner = _aspxGetChildNodesByClassName(windowElem, ASPxClientPopupControlCssClasses.MainDivLiteCssClass)[0];
  var height = windowElem.offsetHeight - _aspxGetTopBottomBordersAndPaddingsSummaryValue(borderOwner);
  var extenders = [
   this.GetWindowHeaderElement(index),
   this.GetWindowFooterElement(index)
  ];
  for(var i = 0; i < extenders.length; i++) {
   if(extenders[i])
    height -= extenders[i].offsetHeight;
  }
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  if(height > 0)
   contentWrapper.style.height = height + "px";
 },
 GetWindowContentWrapperElement: function(index) {
  var windowElem = this.GetWindowElement(index);
  return _aspxGetDescendantNodesByClassName(windowElem, "dxpc-contentWrapper")[0];
 },
 SetWindowScrollDivSize: function(scrollDiv, index, dimension) {
  var windowClientTable = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var height = windowClientTable.offsetHeight;
  if(headerElement)
   height -= headerElement.offsetHeight;
  height -= this.GetWindowFooterHeightLite(index);
  if(dimension == 'height' || dimension == 'both')
   _aspxSetOffsetHeight(scrollDiv, height);
  if(dimension == 'width' || dimension == 'both') {
   var width = windowClientTable.offsetWidth;
   width -= _aspxGetLeftRightBordersAndPaddingsSummaryValue(scrollDiv);
   if(width > -1)
    scrollDiv.style.width = width + "px";
  }
  scrollDiv.style.marginRight = "0px";
 },
 CorrectWindowSizeGripPositionLite: function(index) {
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(!sizeGrip)
   return;
  if(!_aspxIsExists(sizeGrip.initialMarginTop))
   sizeGrip.initialMarginTop = _aspxPxToInt(sizeGrip.style.marginTop);
  sizeGrip.style.marginTop = "";
  var footerHeight = this.GetWindowFooterHeightLite(index) - _aspxGetTopBottomBordersAndPaddingsSummaryValue(this.GetWindowFooterElement(index));
  var marginTop = footerHeight - (sizeGrip.offsetHeight + sizeGrip.initialMarginTop + _aspxPxToInt(sizeGrip.style.marginBottom));
  if(marginTop < 0)
   marginTop = 0;
  sizeGrip.style.marginTop = marginTop + sizeGrip.initialMarginTop + "px";
 },
 GetIsSafariGreater4OrChromeGreater2: function() {
  return (__aspxSafari && __aspxBrowserVersion >= 4) || (__aspxChrome && __aspxBrowserVersion >= 2);
 },
 AdjustIFrameDivHeight: function(index, contentIFrameDiv, contentIFrame) {
  var windowContent = this.GetWindowContentElement(index);
  var scrollDiv = this.GetWindowScrollDiv(index);
  var iframeHeight = windowContent.offsetHeight - _aspxGetTopBottomBordersAndPaddingsSummaryValue(scrollDiv);
  if(iframeHeight >= 0)
   contentIFrameDiv.style.height = iframeHeight + "px";
 },
 SetWindowCachedSize: function(index, width, height) {
  if(0 <= index && index < this.heightArray.length)
   this.cachedSizeArray[index] = new _aspxSize(width, height);
  else
   this.cachedSize = new _aspxSize(width, height);
 },
 GetWindowCachedSize: function(index) {
  if(0 <= index && index < this.heightArray.length)
   return this.cachedSizeArray[index];
  else
   return this.cachedSize;
 },
 ResetWindowCachedSize: function(index) {
  if(0 <= index && index < this.heightArray.length)
   this.cachedSizeArray[index] = null;
  else
   this.cachedSize = null;
 },
 SetWindowSizeByIndex: function(index, width, height) {
  var minWidth = this.GetWindowMinWidth(index);
  var minHeight = this.GetWindowMinHeight(index);
  var maxWidth = this.GetWindowMaxWidth(index);
  var maxHeight = this.GetWindowMaxHeight(index);
  if(minWidth)
   width = Math.max(width, minWidth);
  if(minHeight)
   height = Math.max(height, minHeight);
  if(maxWidth)
   width = Math.min(width, maxWidth);
  if(maxHeight)
   height = Math.min(height, maxHeight);
  var isWindowMaximized = this.GetIsMaximized(index);
  var isWindowCollapsed = this.GetIsCollapsed(index);
  var isWindowMaximizedAndCollapsed = (isWindowMaximized && isWindowCollapsed);
  if(this.InternalIsWindowDisplayed(index) && (!isWindowMaximizedAndCollapsed || this.ResizingForMaxWindowLocked())) {
   if (!this.CollapseExecuting() && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()){
    this.SetWindowCachedSize(index, width, height);
    this.SetIsResized(index, true);
   }
   if (isWindowCollapsed && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()){
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
    height = 0;
   }
   if (isWindowMaximized && !this.CollapseExecuting() && !this.ResizingForMaxWindowLocked()){
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
   } else {
    if(this.liteRender)
     this.SetClientWindowSizeLite(index, width, height);
    else
     this.SetClientWindowSize(index, width, height);
    var iFrame = this.GetWindowIFrame(index);
    if(iFrame && !isWindowCollapsed) {
     var winElememnt = this.GetWindowElement(index);
     var realWidth = winElememnt.offsetWidth;
     var realHeight = winElememnt.offsetHeight;
     _aspxSetStyleSize(iFrame, realWidth, realHeight);
    }
    this.UpdateWindowsStateInputElement();
    this.UpdateWindowsStateCookie();
   }
  } else
   this.SetWindowCachedSize(index, width, height);
 },
 CreateResizeCursorInfo: function(evt, index) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var clientWindow = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var left = _aspxGetAbsoluteX(mainCell);
  var top = _aspxGetAbsoluteY(mainCell);
  var x = _aspxGetEventX(evt);
  var y = _aspxGetEventY(evt);
  var mainCellWidth = mainCell.offsetWidth;
  var mainCellHeight = mainCell.offsetHeight;
  var leftOffset = Math.abs(x - left);
  var rightOffset = Math.abs(x - left - mainCellWidth + (this.liteRender ? 0 : 1));
  var topOffset = Math.abs(y - top);
  var bottomOffset = Math.abs(y - top - mainCellHeight + (this.liteRender ? 0 : 1));
  var cursorInfo = this.CreateResizeBorderCursorInfo(index, leftOffset, rightOffset, topOffset, bottomOffset);
  var grip = this.GetWindowSizeGripElement(index);
  if(grip) {
   var gripCursorInfo = this.CreateGripCursorInfo(index, mainCell, grip, leftOffset, rightOffset, bottomOffset);
   if(gripCursorInfo)
    cursorInfo = gripCursorInfo;
  }
  this.UpdateResizeCursor(clientWindow, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  this.UpdateResizeCursor(mainCell, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  if(headerElement)
   this.UpdateResizeCursor(headerElement, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  return cursorInfo;
 },
 CreateGripCursorInfo: function(index, mainCell, grip, leftOffset, rightOffset, bottomOffset) {
  var gripWidth = this.rtl
   ? _aspxGetAbsoluteX(grip) - _aspxGetAbsoluteX(mainCell) + grip.offsetWidth
   : mainCell.offsetWidth - (_aspxGetAbsoluteX(grip) - _aspxGetAbsoluteX(mainCell));
  var gripHeight = mainCell.offsetHeight - (_aspxGetAbsoluteY(grip) - _aspxGetAbsoluteY(mainCell));
  if(gripHeight > bottomOffset) {
   if(this.rtl && gripWidth > leftOffset)
    return new ASPxPCResizeCursorInfo("w", "s", leftOffset, bottomOffset);
   if(gripWidth > rightOffset)
    return new ASPxPCResizeCursorInfo("e", "s", rightOffset, bottomOffset);
  }
  return null;
 },
 CreateResizeBorderCursorInfo: function(index, leftOffset, rightOffset, topOffset, bottomOffset) {
  var ResizeBorderSize = this.ResizeBorderSize;
  var verticalDirection = this.GetResizeVerticalCourse(ResizeBorderSize, topOffset, bottomOffset);
  ResizeBorderSize = verticalDirection != "" ? this.ResizeCornerBorderSize : this.ResizeBorderSize;
  var horizontalDirection = this.GetResizeHorizontalCourse(ResizeBorderSize, leftOffset, rightOffset);
  if(verticalDirection == "" && horizontalDirection != "")
   verticalDirection = this.GetResizeVerticalCourse(this.ResizeCornerBorderSize, topOffset, bottomOffset);
  var horizontalOffset = leftOffset < rightOffset ? leftOffset : rightOffset;
  var verticalOffset = topOffset < bottomOffset ? topOffset : bottomOffset;
  return new ASPxPCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset);
 },
 GetResizeVerticalCourse: function(ResizeBorderSize, topOffset, bottomOffset) {
  if(ResizeBorderSize > topOffset) return "n";
  if(ResizeBorderSize > bottomOffset) return "s";
  return "";
 },
 GetResizeHorizontalCourse: function(ResizeBorderSize, leftOffset, rightOffset) {
  if(ResizeBorderSize > leftOffset) return "w";
  if(ResizeBorderSize > rightOffset) return "e";
  return "";
 },
 UpdateResizeCursor: function(element, verticalDirection, horizontalDirection) {
  var cursor = verticalDirection + horizontalDirection;
  if(cursor != "") {
   cursor += "-resize";
   this.ShowTemporaryCursor(element, cursor);
  }
  else
   this.HideTemporaryCursor(element);
 },
 ShowTemporaryCursor: function(element, cursor) {
  _aspxChangeStyleAttribute(element, "cursor", cursor);
 },
 HideTemporaryCursor: function(element) {
  _aspxRestoreStyleAttribute(element, "cursor");
 },
 ResizeWindowIFrame: function(index) {
  if(!this.renderIFrameForPopupElements) return;
  if(!this.InternalIsWindowVisible(index)) return;
  var iFrame = this.GetWindowIFrame(index);
  if(iFrame) {
   var cell = this.GetWindowMainCell(this.GetWindowElement(index));
   _aspxSetStyleSize(iFrame, cell.offsetWidth, cell.offsetHeight);
  }
 },
 GetContentIFrameWindow: function() {
  var iframeElement = this.GetContentIFrame();
  return iframeElement.contentWindow;
 },
 ShowDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement)
   this.ShowTemporaryCursor(dragElement, "move");
 },
 HideDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement != null)
   this.HideTemporaryCursor(dragElement);
 },
 GetDragElement: function(index) {
  var headerElement = this.GetWindowHeaderElement(index);
  var element = this.GetWindowElement(index);
  if(element != null)
   return (headerElement != null ? headerElement : this.GetWindowMainCell(element));
  return null;
 },
 OnActivateMouseDown: function(evt, index) {
  this.OnActivate(index, evt);
 },
 OnCloseButtonClick: function(index) {
  this.RaiseCloseButtonClick(index);
  if(this.GetWindowCloseAction(index) != "None")
   this.DoHideWindow(index);
 },
 OnRefreshButtonClick: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  if (contentIFrame)
   this.RefreshWindowContentUrl(this.GetWindow(index));
  else
   this.PerformWindowCallback(this.GetWindow(index));
 },
 OnPinButtonClick: function(index) {
  var value = this.GetIsPinned(index);
  this.SetPinCore(index, !value);
 },
 SetPinCore: function(index, value) {
  if (this.GetIsPinned(index) != value) {
   this.SetIsPinned(index, value);
   this.HoldPosition(index, value);
   this.UpdateWindowsStateInputElement();
   this.UpdateWindowsStateCookie();
   this.OnPinned(index, value);
  }
 },
 OnPinned: function(index, pinned) {
  this.RaisePinnedChanged(index, pinned);
 },
 HoldPosition: function(index, hold, element) {
  if (hold){
   var element = element || this.GetWindowElement(index);
   if (!element) return;
   var x = _aspxGetAbsoluteX(element);
   var y = _aspxGetAbsoluteY(element);
   scrollX = _aspxGetDocumentScrollLeft();
   scrollY = _aspxGetDocumentScrollTop();
   this.SetPinPosX(index, x - scrollX);
   this.SetPinPosY(index, y - scrollY);
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowPinButton", hold);
  this.CheckHeaderCursor(index);
 },
 GetBodyWidth: function(){
  return aspxGetPopupControlCollection().GetSavedBodyWidth();
 },
 GetBodyHeight: function(){
  return aspxGetPopupControlCollection().GetSavedBodyHeight();
 },
 GetIsOutFromViewPort: function(index){
  var element = this.GetWindowElement(index);
  if (!element) return false;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  var popupWindowWidth = this.GetClientWindowWidth(index);
  var docClientWidth = _aspxGetDocumentClientWidth();
  var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
  var popupWindowHeight = this.GetClientWindowHeight(index);
  var docClientHeight = _aspxGetDocumentClientHeight();
  var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
  return (rightOutOffset > 0 || bottomOutOffset > 0);
 },
 AdjustPinPositionWhileScroll: function(index){
  var element = this.GetWindowElement(index);
  if (!element) return;
  var x = _aspxGetAbsoluteX(element);
  var y = _aspxGetAbsoluteY(element);
  var scrollX = _aspxGetDocumentScrollLeft();
  var scrollY = _aspxGetDocumentScrollTop();
  var pinX = x - scrollX;
  var pinY = y - scrollY;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  if ((pinX != pinXTarget) || (pinY != pinYTarget)){
   this.lockScroll++;
   var xNew = pinXTarget + scrollX;
   var yNew = pinYTarget + scrollY;
   var bodyWidth = this.GetBodyWidth();
   var bodyHeight = this.GetBodyHeight();
   var popupWindowWidth = this.GetClientWindowWidth(index);
   var docClientWidth = _aspxGetDocumentClientWidth();
   var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
   var popupWindowHeight = this.GetClientWindowHeight(index);
   var docClientHeight = _aspxGetDocumentClientHeight();
   var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
   var cancelScrollX = false;
   if (xNew + (popupWindowWidth - rightOutOffset) > bodyWidth){
    xNew -= (xNew + (popupWindowWidth - rightOutOffset) - bodyWidth);
    cancelScrollX = true;
   }
   var cancelScrollY = false;
   if (yNew + (popupWindowHeight - bottomOutOffset) > bodyHeight){
    yNew -= (yNew + (popupWindowHeight - bottomOutOffset) - bodyHeight);
    cancelScrollY = true;
   }
   this.SetWindowPos(index, element, xNew, yNew);
   if (cancelScrollX){
    var scrollLeftMax = bodyWidth - _aspxGetDocumentClientWidth();
    if ((rightOutOffset > 0) && (scrollX > scrollLeftMax)){
     this.lockScroll++;
     _aspxSetDocumentScrollLeft(scrollLeftMax);
     this.lockScroll--;
    }
   }
   if (cancelScrollY){
    var scrollTopMax = bodyHeight - _aspxGetDocumentClientHeight();
    if ((bottomOutOffset > 0) && (scrollY > scrollTopMax)){
     this.lockScroll++;
     _aspxSetDocumentScrollTop(scrollTopMax);
     this.lockScroll--;
    }
   }
   this.lockScroll--;
  }
 },
 OnScroll: function(evt, index){
  if (!this.GetIsPinned(index) || (this.lockScroll > 0)) return;
  this.AdjustPinPositionWhileScroll(index);
 },
 OnCollapseButtonClick: function(index) {
  this.SetCollapsedCore(index, !this.GetIsCollapsed(index));
 },
 SetCollapsedCore: function(index, minimization) {
  if(this.GetIsCollapsed(index) == minimization) return;
  this.DoCollapse(index, minimization);
  this.OnCollapsed(index, minimization);
 },
 DoCollapse: function(index, minimization) {
  if (this.GetIsCollapsed(index) == minimization) return;
  this.StartCollapse();
  if (minimization){
   var cachedWidth = this.GetClientWindowWidth(index);
   var cachedHeight = this.GetClientWindowHeight(index);
   var shouldUpdateRestoredSize = this.ShoulUpdatedRestoredWindowSizeOnCollapse(index);
   var width = this.GetMainWindowWidth(index, !shouldUpdateRestoredSize);
   var height = this.GetMainWindowHeight(index, !shouldUpdateRestoredSize);
   this.SetWindowSizeByIndex(index, width, 0);
   this.SetWindowContentVisible(index, false);
   this.SetWindowFooterVisible(index, false);
   var element = this.GetWindowElement(index);
   if (element)
    element.style.height = "";
   this.SetIsCollapsed(index, minimization);
   this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
   if(shouldUpdateRestoredSize)
    this.UpdateRestoredWindowSize(index, width, height);
  }
  else{
   if (this.MaximizationExecuting()){
    var element = this.GetWindowElement(index);
    if (element){
     element.style.left = _aspxGetDocumentScrollLeft();
     element.style.top = _aspxGetDocumentScrollTop();
    }
   }
   this.SetWindowContentVisible(index, true);
   this.SetWindowFooterVisible(index, true);
   this.SetIsCollapsed(index, minimization);
   if (this.GetIsMaximized(index)){
    var documentClientWidth = _aspxGetDocumentClientWidthForPopup();
    var documentClientHeight = _aspxGetDocumentClientHeight();
    this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   } else {
    var restoredWindowData = this.GetRestoredWindowData(index);
    this.SetWindowSizeByIndex(index, restoredWindowData.width, restoredWindowData.height);
   }
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowCollapseButton", minimization);
  this.EndCollapse();
  this.UpdateWindowsStateInputElement();
  this.UpdateWindowsStateCookie();
 },
 ShoulUpdatedRestoredWindowSizeOnCollapse: function(index) {
  return !this.GetIsMaximized(index);
 },
 OnCollapsed: function(index, value){
  if (value)
   this.RaiseCollapsed(index);
  else
   this.RaiseExpanded(index);
  this.RaiseAfterResizing(index);
 },
 OnMaximizeButtonClick: function(index) {
  this.SetMaximizedCore(index, !this.GetIsMaximized(index));
 },
 SetMaximizedCore: function(index, maximization) {
  if(this.GetIsMaximized(index) == maximization) return;
  this.DoMaximize(index, maximization);
  this.OnMaximizedChanged(index, maximization);
 },
 DoMaximize: function(index, maximization) {
  if (this.GetIsMaximized(index) == maximization) return;
  var element = this.GetWindowElement(index);
  if (!element) return;
  this.StartMaximization();
  if (maximization){
   if(this.hideBodyScrollWhenMaximized)
    _aspxBodyScrollHelper.HideBodyScroll();
   if (this.GetIsCollapsed(index))
    this.DoCollapse(index, false);
   var cachedWidth = this.GetClientWindowWidth(index);
   var cachedHeight = this.GetClientWindowHeight(index);
   var restoredWindowData = this.GetInitRestoredWindowData(index);
   var documentClientWidth = _aspxGetDocumentClientWidthForPopup();
   var documentClientHeight = _aspxGetDocumentClientHeight();
   var currentStyle = _aspxGetCurrentStyle(element);
   var windowClientTable = this.GetWindowClientTable(index);
   var windowClientTableParent = windowClientTable.parentNode;
   childStyle = _aspxGetCurrentStyle(windowClientTableParent);
   if (!this.liteRender && this.shadowVisible){
    var shadowWidth = this.GetShadowWidth();
    var shadowHeight = this.GetShadowHeight();
    this.RemoveRestoreWindowShadow(index, false);
    var styleWidth = parseInt(element.style.width, 10) || 0;
    if (styleWidth)
     element.style.width = (styleWidth - shadowWidth).toString() + 'px';
    var styleHeight = parseInt(element.style.height, 10) || 0;
    if (styleHeight)
     element.style.height = (styleHeight - shadowHeight).toString() + 'px';
   }
   var left = _aspxPrepareClientPosForElement(_aspxGetDocumentScrollLeft(), element, true);
   var top = _aspxPrepareClientPosForElement(_aspxGetDocumentScrollTop(), element, false);
   this.SetWindowPos(index, element, left, top);
   this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
   this.SetRestoredWindowData(index, restoredWindowData);
   this.SetIsMaximized(index, maximization);
  }
  else{
   var restoredWindowData = this.GetRestoredWindowData(index);
   var width = restoredWindowData.width || this.GetMainWindowWidth(index);
   var height = restoredWindowData.height || this.GetMainWindowHeight(index);
   if (!this.liteRender)
    this.RemoveRestoreWindowShadow(index, true);
   this.SetIsMaximized(index, maximization);
   var left = _aspxPrepareClientPosForElement(restoredWindowData.left, element, true);
   var top = _aspxPrepareClientPosForElement(restoredWindowData.top, element, false);
   this.SetWindowPos(index, element, left, top);
   this.SetWindowSizeByIndex(index, width, height);
   if (this.GetIsCollapsed(index)){
    this.SetIsCollapsed(index, false);
    this.DoCollapse(index, true);
   }
   if(this.hideBodyScrollWhenMaximized)
    _aspxBodyScrollHelper.RestoreBodyScroll();
  }
  if (this.GetIsPinned(index))
   this.HoldPosition(index, true, element);
  this.UpdateHeaderButtonSelected(index, "GetWindowMaximizeButton", maximization);
  this.EndMaximization();
  this.UpdateWindowsStateInputElement();
  this.UpdateWindowsStateCookie();
  this.CheckHeaderCursor(index);
 },
 OnMaximizedChanged: function(index, value){
  if (value)
   this.RaiseMaximized(index);
  else
   this.RaiseRestoredAfterMaximized(index);
  this.RaiseAfterResizing(index);
 },
 GetInitRestoredWindowData: function (index) {
  var restoredWindowData = this.GetRestoredWindowData(index);
  restoredWindowData.left = this.GetCurrentLeft(index);
  restoredWindowData.top = this.GetCurrentTop(index);
  restoredWindowData.width = this.GetMainWindowWidth(index);
  restoredWindowData.height = this.GetMainWindowHeight(index);
  return restoredWindowData;
 },
 UpdateMaximizedWindowSizeOnResize: function(index){
  this.StartUpdateMaximizedWindowSizeOnResize();
  var documentClientWidth = _aspxGetDocumentClientWidthForPopup();
  var documentClientHeight = _aspxGetDocumentClientHeight();
  if (this.GetIsCollapsed(index)) documentClientHeight = 0;
  this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
  if (this.GetIsCollapsed(index)){
   this.CorrectCollapsedSize(index);
  }
  window.setTimeout(function() { this.SetMaximizedWindowSizeAfterOnResize(index); }.aspxBind(this), 0);
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 SetMaximizedWindowSizeAfterOnResize: function(index){
  this.StartUpdateMaximizedWindowSizeOnResize();
  var documentClientWidth = _aspxGetDocumentClientWidthForPopup();
  var documentClientHeight = _aspxGetDocumentClientHeight();
  windowWidthCurrent = this.GetMainWindowWidth(index, true);
  windowHeightCurrent = this.GetMainWindowHeight(index, true);
  if (this.GetIsCollapsed(index))
   documentClientHeight = 0;
  if (documentClientWidth != windowWidthCurrent || documentClientHeight != windowHeightCurrent){
   this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   if (this.GetIsCollapsed(index)){
    this.CorrectCollapsedSize(index);
   }
  }
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 CorrectCollapsedSize: function(index){
  if (this.liteRender){
   var contentWrapper = this.GetWindowContentWrapperElement(index);
   if (contentWrapper && _aspxElementIsVisible(contentWrapper)){
    contentWrapper.style.display = 'none';
   }
  }
 },
 UpdateHeaderButtonSelected: function(index, methodGetWindowButton, flagSelected){
  if(typeof(aspxGetStateController) != "undefined"){
   button = this[methodGetWindowButton](index);
   var method = flagSelected ? "SelectElementBySrcElement" : "DeselectElementBySrcElement";
   aspxGetStateController()[method](button);
  }
 },
 CheckHeaderCursor: function(index){
  if (!this.allowDragging) return;
  var dragElement = this.GetDragElement(index);
  if (!dragElement) return;
  var styleCursor = dragElement.style.cursor;
  var isPinned = this.GetIsPinned(index);
  var isMaximized = this.GetIsMaximized(index);
  if ((isPinned || isMaximized) && styleCursor != "default")
   dragElement.style.cursor = "default";
  else if (!isPinned && !isMaximized && styleCursor != "move")
   dragElement.style.cursor = "move";
 },
 StartCollapse: function(){
  this.collapseExecutingLockCount++;
 },
 EndCollapse: function(){
  this.collapseExecutingLockCount--;
 },
 CollapseExecuting: function(){
  return this.collapseExecutingLockCount > 0;
 },
 StartMaximization: function(){
  this.maximizationExecutingLockCount++;
 },
 EndMaximization: function(){
  this.maximizationExecutingLockCount--;
 },
 MaximizationExecuting: function(){
  return this.maximizationExecutingLockCount > 0;
 },
 StartUpdateMaximizedWindowSizeOnResize: function(){
  this.browserResizingForMaxWindowLockCount++;
 },
 EndUpdateMaximizedWindowSizeOnResize: function(){
  this.browserResizingForMaxWindowLockCount--;
 },
 ResizingForMaxWindowLocked: function(){
  return this.browserResizingForMaxWindowLockCount > 0;
 },
 UpdateRestoredWindowSizeLock: function () {
  this.updateRestoredWindowSizeLockCount ++;
 },
 UpdateRestoredWindowSizeUnlock: function () {
  this.updateRestoredWindowSizeLockCount --;
 },
 UpdateRestoredWindowSizeLocked: function () {
  return this.updateRestoredWindowSizeLockCount > 0;
 },
 UpdateRestoredWindowSize: function (index, width, height) {
  if (!this.UpdateRestoredWindowSizeLocked()) {
   restoredMinWindowData = this.GetRestoredWindowData(index);
   restoredMinWindowData.width = width;
   restoredMinWindowData.height = height;
   this.SetRestoredWindowData(index, restoredMinWindowData);
  }
 },
 OnMouseDown: function(evt, index, isDraggingAllowed, pointOnScrollBar) {
  if(_aspxGetIsLeftButtonPressed(evt)) {
   if((this.allowResize || isDraggingAllowed) && !this.prohibitClearSelectionOnMouseDown) 
    _aspxClearSelection();
   var isResizing = false;
   if(this.allowResize && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index))
    isResizing = this.OnResizeStart(evt, index);
   if(isResizing && __aspxWebKitTouchUI)
    aspxGetPopupControlCollection().OverStop();
   var clickedOnScroll = pointOnScrollBar && this.enableContentScrolling;
   if(isDraggingAllowed && !isResizing && !clickedOnScroll && !this.GetIsPinned(index) && !this.GetIsMaximized(index))
    this.OnDragStart(evt, index);
  }
 },
 OnMouseMove: function(evt, index) {
  if(this.allowResize && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index))
   this.CreateResizeCursorInfo(evt, index);
 },
 SetShadowVisibility: function(visible, index) {
  var shadowTable = this.GetWindowShadowTable(index);
  if(shadowTable && shadowTable.rows.length > 1) {
   var shadowCol = shadowTable.rows[0].cells[1];
   var shadowRow = shadowTable.rows[1];
   _aspxSetElementVisibility(shadowCol, visible);
   _aspxSetElementVisibility(shadowRow, visible);
  }
 },
 StartFadeAnimation: function(element, index) {
  if(__aspxIE && __aspxBrowserMajorVersion < 9) {
   _aspxSetElementVisibility(element, true);
   ASPxAnimationHelper.setOpacity(element, 0);
   this.SetShadowVisibility(false, index); 
  } else {
   ASPxAnimationHelper.setOpacity(element, 0);
   _aspxSetElementVisibility(element, true);
  }
  var callback = function () {
   if (__aspxIE && __aspxBrowserVersion < 9 && element.style.filter) {
    if (element.style.filter)
     element.style.filter = "";
    this.SetShadowVisibility(true, index);
   }
   this.OnAnimationStop(index);
  } .aspxBind(this);
  ASPxAnimationHelper.fadeIn(element, callback);
 },
 StartSlideAnimation: function(animationDivElement, index, horizontalPopupPosition, verticalPopupPosition) {
  var element = this.GetWindowMainTable(animationDivElement);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  var args = "(\"" + this.name + "\", " + index + ")";
  var onTimerString = "aspxPCATimer" + args;
  var onAnimStopCallString = "aspxPCAStop" + args;
  if(this.liteRender && __aspxFirefox) {
   animationDivElement.style.display = "block";
  }
  _aspxInitAnimationDiv(animationDivElement, clientX, clientY, onTimerString, onAnimStopCallString, this.liteRender);
  var horizontalDirection = _aspxGetAnimationHorizontalDirection(horizontalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign, this.rtl);
  var verticalDirection = _aspxGetAnimationVerticalDirection(verticalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign);
  var xPos = horizontalDirection * animationDivElement.offsetWidth;
  var yPos = verticalDirection * animationDivElement.offsetHeight;
  _aspxSetStylePosition(element, xPos, yPos);
  _aspxSetElementVisibility(animationDivElement, true);
  this.DoShowWindowIFrame(index, clientX, clientY, 0, 0);
  animationDivElement.timerID = window.setTimeout(animationDivElement.onTimerString, this.animationDelay);
 },
 GetWindowsState: function() {
  var state = "";
  if(this.HasDefaultWindow()) {
   state += this.GetWindowState(-1);
  }
  for(var i = 0; i < this.GetWindowCountCore(); i++) {
   state += this.GetWindowState(i);
   if(i < this.GetWindowCountCore() - 1) state += ";";
  }
  return state;
 },
 GetWindowState: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   var mainCell = this.GetWindowMainCell(element);
   var visibleFlag = (!this.InternalIsWindowVisible(index) || element.isHiding) ? "0" : "1";
   var isDraggedFlag = this.GetIsDragged(index) ? "1" : "0";
   var zIndex = this.GetCurrentZIndex(index);
   var isResized = this.GetIsResized(index);
   var isResizedFlag = isResized ? "1" : "0";
   var width = isResized ? this.GetCurrentWindowWidth(index) : __aspxInvalidDimension;
   var height = isResized ? this.GetCurrentWindowHeight(index) : __aspxInvalidDimension;
   var contentWasLoaded = element.loaded ? "1" : "0";
   var left, top;
   var isMaximized = this.GetIsMaximized(index);
   if (isMaximized && !this.MaximizationExecuting()){
    var restoredWindowData = this.GetRestoredWindowData(index);
    left = restoredWindowData.left;
    top = restoredWindowData.top;
   } else {
    left = this.GetCurrentLeft(index);
    top = this.GetCurrentTop(index);
   }
   var isPinned = this.GetIsPinned(index);
   if (isPinned){
    left -= _aspxGetDocumentScrollLeft();
    top -=  _aspxGetDocumentScrollTop();    
   }
   if(__aspxBrowserWithHardwareAcceleration) {
    left = Math.ceil(left);
    top = Math.ceil(top);
   }
   var pinFlag = isPinned ? "1" : "0";
   var minFlag = this.GetIsCollapsed(index) ? "1" : "0";
   var maxFlag = isMaximized ? "1" : "0";
   return [visibleFlag, isDraggedFlag, zIndex, left, top, isResizedFlag, width, height, contentWasLoaded, pinFlag, minFlag, maxFlag].join(":");
  }
  return "";
 },
 UpdateWindowsStateCookie: function() {
  if(this.cookieName == "") return;
  _aspxDelCookie(this.cookieName);
  _aspxSetCookie(this.cookieName, this.GetWindowsState());
 },
 UpdateWindowsStateInputElement: function() {
  var element = this.GetWindowsStateInputElement();
  if(element != null) element.value = this.GetWindowsState();
 },
 OnIFrameLoad: function(index) {
  this.SetIframeLoading(index, false);
 },
 OnPWHBClickCore: function(evt, index, method){
  if (__aspxIE || __aspxOpera)
   _aspxEmulateDocumentOnMouseDown(evt);
  this[method](index);
 },
 CreateWindows: function(windowsNames) {
  for(var i = 0; i < windowsNames.length; i++) {
   var window = new ASPxClientPopupWindow(this, i, windowsNames[i]);
   this.windows.push(window);
  }
 },
 RaiseCloseButtonClick: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.CloseButtonClick.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.CloseButtonClick.FireEvent(this, args);
  }
 },
 RaiseClosing: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  var cancel = false;
  if(!this.Closing.IsEmpty()) {
   var args = new ASPxClientPopupWindowCancelEventArgs(window);
   this.Closing.FireEvent(this, args);
   cancel = args.cancel;
  }
  return cancel;
 },
 RaiseCloseUp: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.CloseUp.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.CloseUp.FireEvent(this, args);
  }
 },
 RaisePopUp: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.PopUp.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.PopUp.FireEvent(this, args);
  }
 },
 RaiseResize: function(index, resizeState) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.Resize.IsEmpty()) {
   if(!resizeState)
    resizeState = ASPxClientPopupControlResizeState.Resized;
   var args = new ASPxClientPopupWindowResizeEventArgs(window, resizeState);
   this.Resize.FireEvent(this, args);
  }
 },
 RaiseBeforeResizing: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.BeforeResizing.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.BeforeResizing.FireEvent(this, args);
  }
 },
 RaiseAfterResizing: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.AfterResizing.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.AfterResizing.FireEvent(this, args);
  }
 },
 RaiseShowen: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.Shown.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.Shown.FireEvent(this, args);
  }
 },
 RaisePinnedChanged: function (index, pinned) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.PinnedChanged.IsEmpty()) {
   var args = new ASPxClientPopupWindowPinnedChangedEventArgs(window, pinned);
   this.PinnedChanged.FireEvent(this, args);
  }
 },
 RaiseCollapsed: function (index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Collapsed);
 },
 RaiseExpanded: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Expanded);
 },
 RaiseMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Maximized);
 },
 RaiseRestoredAfterMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.RestoredAfterMaximized);
 },
 AdjustSize: function() {
  if(this.enableContentScrolling)
   return;
  this.SetSize(1, 1);
 },
 GetHeight: function() {
  return this.GetWindowHeight(null);
 },
 GetWidth: function() {
  return this.GetWindowWidth(null);
 },
 GetContentWidth: function() {
  return this.GetWindowContentWidth(null);
 },
 GetContentHeight: function() {
  return this.GetWindowContentHeight(null);
 },
 SetSize: function(width, height) {
  this.SetWindowSize(null, width, height);
 },
 SetWidth: function(width) {
  var height = this.GetHeight();
  this.SetSize(width, height);
 },
 SetHeight: function(height) {
  var width = this.GetWidth();
  this.SetSize(width, height);
 },
 GetWindowDimensionByIndex: function(index, isWidth, forceFromCache) {
  var cachedSize = this.GetWindowCachedSize(index);
  var dimensionValue = null;
  if (forceFromCache == undefined && !this.GetWindowElement(index)) 
   forceFromCache = true;
  if(cachedSize && forceFromCache)
   dimensionValue = isWidth ? cachedSize.width : cachedSize.height;
  if(dimensionValue)
   return dimensionValue;
  else {
   var element = this.GetWindowElement(index);
   var sizeFromDOM = 0;
   if (this.GetIsCollapsed(index)){
    var headerCell = this.GetWindowHeaderElement(index);
    sizeFromDOM = isWidth ? headerCell.offsetWidth : headerCell.offsetHeight;
   }
   else{
    var mainCell = this.GetWindowMainCell(element);
    sizeFromDOM = isWidth ? mainCell.offsetWidth : mainCell.offsetHeight;
   }
   if(sizeFromDOM === 0 && cachedSize)
    sizeFromDOM = isWidth ? cachedSize.width : cachedSize.height;
   return sizeFromDOM;
  }
 },
 GetWindowDimension: function(window, isWidth, forceFromCache) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowDimensionByIndex(index, isWidth, forceFromCache);
 },
 GetWindowContentDimension: function(window, isWidth) {
  var index = (window != null) ? window.index : -1,
   dimension = 0,
   contentElem = this.GetWindowContentElement(index),
   dimensionHolder = this.liteRender ? contentElem.parentNode : contentElem,
   paddingsHolder = this.liteRender ? contentElem : contentElem.childNodes[0];
  return isWidth ?
  (dimensionHolder.offsetWidth - _aspxGetLeftRightBordersAndPaddingsSummaryValue(paddingsHolder)) :
  (dimensionHolder.offsetHeight - _aspxGetTopBottomBordersAndPaddingsSummaryValue(paddingsHolder));
 },
 GetWindowContentWidth: function(window) {
  return this.GetWindowContentDimension(window, true);
 },
 GetWindowContentHeight: function(window) {
  return this.GetWindowContentDimension(window, false);
 },
 GetWindowHeight: function(window) {
  return this.GetWindowDimension(window, false);
 },
 GetWindowWidth: function(window) {
  return this.GetWindowDimension(window, true);
 },
 SetWindowSize: function(window, width, height) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowSizeByIndex(index, width, height);
 },
 GetContentHTML: function() {
  return this.GetContentHtml();
 },
 SetContentHTML: function(html) {
  this.SetContentHtml(html);
 },
 GetContentHtml: function() {
  return this.GetWindowContentHtml(null);
 },
 SetContentHtml: function(html, useAnimation) {
  this.SetWindowContentHtml(null, html, useAnimation);
 },
 GetContentIFrame: function(window) {
  return this.GetWindowContentIFrame(null);
 },
 GetContentUrl: function() {
  return this.GetWindowContentUrl(null);
 },
 SetContentUrl: function(url) {
  this.SetWindowContentUrl(null, url);
 },
 RefreshContentUrl: function() {
  this.RefreshWindowContentUrl(null);
 },
 SetWindowPopupElementID: function(window, popupElementId) {
  var index = (window != null) ? window.index : -1;
  this.RemoveWindowAllPopupElements(index);
  this.SetPopupElementIDs(index, popupElementId.split(';'));
  if(aspxGetPopupControlCollection().IsDisappearTimerActive()) {
   aspxGetPopupControlCollection().ClearDisappearTimer();
   this.Hide(index);
  }
  this.PopulatePopupElements(index);
 },
 SetPopupElementID: function(popupElementId) {
  this.SetWindowPopupElementID(null, popupElementId);
 },
 GetCurrentPopupElementIndex: function() {
  return this.GetWindowCurrentPopupElementIndex(null);
 },
 GetWindowCurrentPopupElementIndex: function(window) {
  var popupElement = this.GetWindowCurrentPopupElement(window);
  return popupElement ? popupElement.DXPopupElementIndex : -1;
 },
 GetCurrentPopupElement: function() {
  return this.GetWindowCurrentPopupElement(null);
 },
 GetWindowCurrentPopupElement: function(window) {
  var index = (window != null) ? window.index : -1;
  var popupElement = this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index));
  if(popupElement && popupElement.DXPopupElementControl)
   return popupElement;
  return null;
 },
 Show: function(popupElementIndex) {
  this.ShowWindow(null, popupElementIndex);
 },
 ShowAtElement: function(htmlElement) {
  this.ShowWindowAtElement(null, htmlElement);
 },
 ShowAtElementByID: function(id) {
  var htmlElement = document.getElementById(id);
  this.ShowWindowAtElement(null, htmlElement);
 },
 ShowAtPos: function(x, y) {
  this.ShowWindowAtPos(null, Math.round(x), Math.round(y));
 },
 BringToFront: function() {
  this.BringWindowToFront(null);
 },
 Hide: function() {
  this.HideWindow(null);
 },
 IsWindowVisible: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.InternalIsWindowVisible(index);
 },
 IsVisible: function() {
  return this.InternalIsWindowVisible(-1);
 },
 GetWindow: function(index) {
  return (0 <= index && index < this.windows.length) ? this.windows[index] : null;
 },
 GetWindowByName: function(name) {
  for(var i = 0; i < this.windows.length; i++)
   if(this.windows[i].name == name) return this.windows[i];
  return null;
 },
 GetWindowCount: function() {
  return this.GetWindowCountCore();
 },
 ShowWindow: function(window, popupElementIndex) {
  var index = (window != null) ? window.index : -1;
  if(popupElementIndex === undefined)
   popupElementIndex = this.GetLastShownPopupElementIndex(index);
  this.DoShowWindowAtPos(index, __aspxInvalidPosition, __aspxInvalidPosition, popupElementIndex, false, true);
 },
 ShowWindowAtElement: function(window, htmlElement) {
  var index = (window != null) ? window.index : -1;
  var lastIndexBackup = this.GetLastShownPopupElementIndex(index);
  this.ShowWindow(window, this.AddPopupElementInternal(index, htmlElement));
  this.RemovePopupElementInternal(index, htmlElement);
  this.SetLastShownPopupElementIndex(index, lastIndexBackup);
 },
 ShowWindowAtElementByID: function(window, id) {
  var htmlElement = document.getElementById(id);
  this.ShowWindowAtElement(window, htmlElement);
 },
 ShowWindowAtPos: function(window, x, y) {
  var index = (window != null) ? window.index : -1;
  this.DoShowWindowAtPos(index, x, y, -1, false, true);
 },
 BringWindowToFront: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetWindowElement(index);
  aspxGetPopupControlCollection().ActivateWindowElement(element);
 },
 HideWindow: function(window) {
  var index = (window != null) ? window.index : -1;
  this.DoHideWindow(index);
 },
 GetWindowContentHTML: function(window) {
  return this.GetWindowContentHtml(window);
 },
 SetWindowContentHTML: function(window, html) {
  this.SetWindowContentHtml(window, html);
 },
 GetWindowContentHtml: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetContentContainer(index);
  return (element != null) ? element.innerHTML : "";
 },
 SetWindowContentHtml: function(window, html, useAnimation) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowContentHtmlCore(index, html, useAnimation);
 },
 SetWindowContentHtmlCore: function(index, html, useAnimation) {
  var element = this.GetContentContainer(index);
  if(element != null) {
   _aspxSetInnerHtml(element, html);
   if(useAnimation && typeof(ASPxAnimationHelper) != "undefined")
    ASPxAnimationHelper.fadeIn(element, function(){ this.ResizeWindowIFrame(index); }.aspxBind(this));
   else
    this.ResizeWindowIFrame(index);
  }
 },
 GetWindowContentIFrame: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowContentIFrameElement(index);
 },
 GetWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(!this.IsWindowVisible(window))
   return this.GetWindowContentIFrameUrl(index);
  var element = this.GetWindowContentIFrameElement(index);
  return (element != null) ? element.src : "";
 },
 SetWindowContentUrl: function(window, url) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetWindowContentIFrameElement(index);
  var windowVisible = this.IsWindowVisible(window);
  if(windowVisible && element != null)
   this.ShowIframeElementAfterDragging(index);
  this.SetWindowContentIFrameUrl(index, url);
  var src = (this.allowLoadToHiddenIframe && !windowVisible) ? ASPx.SSLSecureBlankUrl : url;
  if(element == null) {
   this.CreateWindowContentIFrameElement(index, src);
   if(this.liteRender)
    this.SetClientWindowSizeCoreLite(index, this.GetWindowWidth(window), this.GetWindowHeight(window));
  }
  else
   this.SetSrcToIframeElement(index, element, src);
 },
 GetPinned: function() {
  return this.GetIsPinned(-1);
 },
 SetPinned: function(value) {
  this.SetPinCore(-1, value);
 },
 GetWindowPinned: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsPinned(index);
 },
 SetWindowPinned: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetPinCore(index, value);
 },
 GetMaximized: function() {
  return this.GetIsMaximized(-1);
 },
 SetMaximized: function(value) {
  this.SetMaximizedCore(-1, value);
 },
 GetWindowMaximized: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsMaximized(index);
 },
 SetWindowMaximized: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetMaximizedCore(index, value);
 },
 GetCollapsed: function() {
  return this.GetIsCollapsed(-1);
 },
 SetCollapsed: function(value) {
  this.SetCollapsedCore(-1, value);
 },
 GetWindowCollapsed: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsCollapsed(index);
 },
 SetWindowCollapsed: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetCollapsedCore(index, value);
 },
 RefreshWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(__aspxIE)
   this.RefreshWindowContentUrlIE(index, window);
  else
   this.RefreshWindowContentUrlCommon(window);
 },
 RefreshWindowContentUrlIE: function(index, window) {
  var windowVisible = this.InternalIsWindowVisible(index);
  if(windowVisible)
   this.RefreshWindowContentUrlIECore(index, window);
  else {
   var iframe = this.GetWindowContentIFrameElement(index);
   if(iframe)
    iframe.DXReloadAfterShowRequired = true;
  }
 },
 RefreshWindowContentUrlIECore: function(index, window) {
  try {
   if(!this.GetIframeLoading(index)) {
    var iframe = this.GetWindowContentIFrameElement(index);
    if(iframe)
     iframe.contentWindow.location.reload();
   }
  } catch(e) {
   this.RefreshWindowContentUrlCommon(window);
  }
 },
 RefreshWindowContentUrlCommon: function(window) {
  this.SetWindowContentUrl(window, this.GetWindowContentUrl(window));
 },
 SetWindowContentVisible: function(index, visible){
  var contentElement = this.liteRender ? this.GetWindowContentWrapperElement(index) : this.GetWindowContentElement(index);
  if (contentElement)
   this.SetWindowPartVisibleCore(contentElement, "DXPopupWindowContentDisplay", visible);
 },
 SetWindowFooterVisible: function(index, visible){
  var footerElement = this.GetWindowFooterElement(index);
  if (footerElement)
   this.SetWindowPartVisibleCore(footerElement, "DXPopupWindowFooterDisplay", visible);
 },
 SetWindowPartVisibleCore: function(partElement, displayCacheName, visible){
  var nothingChanged = _aspxElementIsVisible(partElement) && visible;
  if(nothingChanged) return;
  if(!(_aspxIsExists(partElement[displayCacheName])))
   partElement[displayCacheName] = partElement.style.display;
  partElement.style.display = visible ? partElement[displayCacheName] : 'none';
 },
 RemoveRestoreWindowShadow: function(index, restore){
  if (this.liteRender) return;
  var shadowTable = this.GetWindowShadowTable(index);
  if (!shadowTable) return;
  if (restore){
   if (shadowTable.DXPopupWindowShadowCol && shadowTable.DXPopupWindowShadowRow){
    shadowTable.DXPopupWindowShadowColParentNode.appendChild(shadowTable.DXPopupWindowShadowCol);
    shadowTable.DXPopupWindowShadowRowParentNode.appendChild(shadowTable.DXPopupWindowShadowRow);
    this.shadowVisible = true;
    this.SetShadowVisibility(true, index);
    shadowTable.DXPopupWindowShadowCol = null;
    shadowTable.DXPopupWindowShadowColParentNode = null;
    shadowTable.DXPopupWindowShadowRow = null;
    shadowTable.DXPopupWindowShadowRowParentNode = null;
   }
  } else {
   var shadowCol = shadowTable.rows[0].cells[1];
   var shadowRow = shadowTable.rows[1];
   shadowTable.DXPopupWindowShadowColParentNode = shadowCol.parentNode;
   shadowTable.DXPopupWindowShadowCol = shadowCol;
   shadowCol.parentNode.removeChild(shadowCol);
   shadowTable.DXPopupWindowShadowRowParentNode = shadowRow.parentNode;
   shadowTable.DXPopupWindowShadowRow = shadowRow;
   shadowRow.parentNode.removeChild(shadowRow);
   this.shadowVisible = false;
  }
 },
 UpdatePosition: function() {
  this.UpdatePositionAtElement(this.GetPopupElement(-1, this.GetLastShownPopupElementIndex(-1)));
 },
 UpdatePositionAtElement: function(popupElement) {
  this.UpdateWindowPositionAtElement(null, popupElement);
 },
 UpdateWindowPosition: function(window) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionAtElement(window, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
 },
 UpdateWindowPositionAtElement: function(window, popupElement) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionInternal(index, popupElement);
 },
 UpdateWindowPositionInternal: function(index, popupElement) {
  var element = this.GetWindowElement(index);
  if(this.InternalIsWindowVisible(index) && element != null) {
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, __aspxInvalidPosition, true, false);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, __aspxInvalidPosition, false, false);
   this.SetWindowPos(index, element, horizontalPopupPosition.position, verticalPopupPosition.position);
  } else
   this.DoShowWindowAtPos(index, __aspxInvalidDimension, __aspxInvalidDimension, this.GetLastShownPopupElementIndex(index), false, false);
 },
 TryAutoUpdatePosition: function(index) {
  if(this.GetAutoUpdatePosition(index))
   this.UpdateWindowPositionInternal(index, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
  if(this.GetIsMaximized(index))
   this.UpdateMaximizedWindowSizeOnResize(index);
 },
 CreateWindowContentIFrameElement: function(index, src) {
  var content = this.GetContentContainer(index);
  var iframeParent = content;
  content.innerHTML = "";
  var iframe = this.CreateContentIFrameElement(index, src);
  var iframeDiv = null;
  if(!this.liteRender) {
   iframeDiv = this.CreateContentIFrameDivElement(index);
   content.appendChild(iframeDiv);
   iframeParent = iframeDiv;
   this.AdjustIFrameDivHeight(index, iframeDiv, iframe);
  }
  iframeParent.appendChild(iframe);
  if(!this.liteRender) {
   iframe.style.height = "100%";
  }
  this.InitIFrame(index);
  return iframe;
 },
 CreateContentIFrameElement: function(index, src) {
  var iframe = document.createElement("IFRAME");
  iframe.id = this.GetWindowContentIFrameElementId(index);
  iframe.scrolling = "auto";
  iframe.frameBorder = 0;
  iframe.style.width = "100%";
  iframe.style.height = __aspxIE || this.liteRender ? "100%" : "0px";
  if(this.liteRender)
   iframe.style.overflow = "auto";
  this.SetSrcToIframeElement(index, iframe, src);
  return iframe;
 },
 CreateContentIFrameDivElement: function(index) {
  var iframeDiv = document.createElement("DIV");
  iframeDiv.id = this.GetWindowContentIFrameDivElementID(index);
  iframeDiv.style.width = "100%";
  iframeDiv.style.height = "100%";
  return iframeDiv;
 },
 GetWindowHeaderTextCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "T");
 },
 GetWindowHeaderImageCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "I");
 },
 GetWindowFooterTextCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "T");
 },
 GetWindowFooterImageCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "I");
 },
 GetWindowHeaderImageUrl: function(index) {
  var element = this.GetWindowHeaderImageCell(index);
  if(this.liteRender)
   return element ? element.src : "";
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img.src;
  }
  return "";
 },
 SetWindowHeaderImageUrl: function(index, url) {
  var element = this.GetWindowHeaderImageCell(index);
  if(this.liteRender) {
   if(element != null)
    element.src = url;
   return;
  }
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    img.src = url;
  }
 },
 GetWindowFooterImageUrl: function(index) {
  var element = this.GetWindowFooterImageCell(index);
  if(this.liteRender)
   return element ? element.src : "";
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img.src;
  }
  return "";
 },
 SetWindowFooterImageUrl: function(index, url) {
  var element = this.GetWindowFooterImageCell(index);
  if(this.liteRender) {
   if(element != null) {
    element.src = url;
    this.CorrectWindowSizeGripPositionLite(index);
   }
   return;
  }
  if(element != null) {
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    img.src = url;
  }
 },
 GetWindowHeaderNavigateUrl: function(index) {
  if(this.liteRender) {
   var header = this.GetWindowHeaderElement(index);
   if(header) {
    var link = _aspxGetDescendantNodesByClassName(header, ASPxClientPopupControlCssClasses.LinkCssClassName)[0];
    if(link)
     return link.href;
   }
   return "";
  }
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  element = this.GetWindowHeaderImageCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  return "";
 },
 SetWindowHeaderNavigateUrl: function(index, url) {
  if(this.liteRender) {
   var header = this.GetWindowHeaderElement(index);
   if(header) {
    var link = _aspxGetDescendantNodesByClassName(header, ASPxClientPopupControlCssClasses.LinkCssClassName)[0];
    if(link)
     link.href = url;
   }
   return;
  }
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
  }
  var element = this.GetWindowHeaderImageCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
  }
 },
 GetWindowFooterNavigateUrl: function(index) {
  if(this.liteRender) {
   var footer = this.GetWindowFooterElement(index);
   if(footer) {
    var link = _aspxGetDescendantNodesByClassName(footer, ASPxClientPopupControlCssClasses.LinkCssClassName)[0];
    if(link)
     return link.href;
   }
   return "";
  }
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  element = this.GetWindowFooterImageCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  return "";
 },
 SetWindowFooterNavigateUrl: function(index, url) {
  if(this.liteRender) {
   var footer = this.GetWindowFooterElement(index);
   if(footer) {
    var link = _aspxGetDescendantNodesByClassName(footer, ASPxClientPopupControlCssClasses.LinkCssClassName)[0];
    if(link)
     link.href = url;
   }
   return;
  }
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
  }
  var element = this.GetWindowFooterImageCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
  }
 },
 GetWindowHeaderText: function(index) {
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.innerHTML;
   else
    return element.innerHTML;
  }
  return "";
 },
 SetWindowHeaderText: function(index, text) {
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.innerHTML = text;
   else
    element.innerHTML = text;
  }
 },
 GetWindowFooterText: function(index) {
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.innerHTML;
   else
    return element.innerHTML;
  }
  return "";
 },
 SetWindowFooterText: function(index, text) {
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.innerHTML = text;
   else
    element.innerHTML = text;
   if(this.liteRender)
    this.CorrectWindowSizeGripPositionLite(index);
  }
 },
 RefreshPopupElementConnection: function() {
  var index = this.HasDefaultWindow() ? -1 : 0;
  for(; index < this.GetWindowCount(); index++) {
   this.RemoveWindowAllPopupElements(index);
   this.PopulatePopupElements(index);
  }
 },
 GetHeaderImageUrl: function() {
  return this.GetWindowHeaderImageUrl(-1);
 },
 SetHeaderImageUrl: function(value) {
  this.SetWindowHeaderImageUrl(-1, value);
 },
 GetFooterImageUrl: function() {
  return this.GetWindowFooterImageUrl(-1);
 },
 SetFooterImageUrl: function(value) {
  this.SetWindowFooterImageUrl(-1, value);
 },
 GetHeaderNavigateUrl: function() {
  return this.GetWindowHeaderNavigateUrl(-1);
 },
 SetHeaderNavigateUrl: function(value) {
  this.SetWindowHeaderNavigateUrl(-1, value);
 },
 GetFooterNavigateUrl: function() {
  return this.GetWindowFooterNavigateUrl(-1);
 },
 SetFooterNavigateUrl: function(value) {
  this.SetWindowFooterNavigateUrl(-1, value);
 },
 GetHeaderText: function() {
  return this.GetWindowHeaderText(-1);
 },
 SetHeaderText: function(value) {
  this.SetWindowHeaderText(-1, value);
 },
 GetFooterText: function() {
  return this.GetWindowFooterText(-1);
 },
 SetFooterText: function(value) {
  this.SetWindowFooterText(-1, value);
 },
 GetVisible: function() {
  return this.IsVisible();
 },
 SetVisible: function(visible) {
  if(visible && !this.IsVisible())
   this.Show();
  else if(!visible && this.IsVisible())
   this.Hide();
 }
});
ASPxClientPopupControl.Cast = ASPxClientControl.Cast;
ASPxClientPopupControl.GetPopupControlCollection = function () {
 return aspxGetPopupControlCollection();
}
var ASPxClientPopupControlResizeState = {
 Resized : 0,
 Collapsed : 1,
 Expanded : 2,
 Maximized : 3,
 RestoredAfterMaximized : 4
};
ASPxClientPopupControlCollection = _aspxCreateClass(ASPxClientControlCollection, {
 constructor: function () {
  this.constructor.prototype.constructor.call(this);
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.visibleModalElements = new Array();
  this.visiblePopupWindowIds = new Array();
  this.zIndex = __aspxPopupControlZIndex;
  this.windowResizeByBodyScrollVisibilityChangingLockCount = 0;
  this.savedBodyWidth = 0;
  this.savedBodyHeight = 0;
  this.overControl = null;
  this.overWindowIndex = -1;
  this.overXPos = __aspxInvalidPosition;
  this.overYPos = __aspxInvalidPosition;
  this.appearTimerID = -1;
  this.disappearTimerID = -1;
  this.scrollEventLockCount = 0;
  this.currentActiveWindowElement = null;
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.resizePanel = null;
  this.selectBanned = false;
  this.pcWindowsAreRestrictedByDocumentWindow = true;
  this.searchForTabIndexInAllElements = false;
  this.docScrollLeft = -1;
  this.docScrollTop = -1;
  this.EnsureSaveScrollState();
 },
 EnsureSaveScrollState: function () {
  if (__aspxDocumentLoaded && this.docScrollLeft < 0 && this.docScrollTop < 0)
   this.SaveScrollState();
 },
 GetPopupWindowFromID: function (id) {
  var pos = id.lastIndexOf(__aspxPCWIdSuffix);
  var name = id.substring(0, pos);
  var index = id.substr(pos + __aspxPCWIdSuffix.length);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  return new _aspxPopupWindow(popupControl, index);
 },
 DoHideAllWindows: function (srcElement, excptId, applyToAll) {
  for (var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var id = this.visiblePopupWindowIds[i];
   if (id == excptId) continue;
   if (srcElement != null && _aspxGetParentById(srcElement, id) != null) continue;
   var popupWindow = this.GetPopupWindowFromID(id);
   var windowCloseAction = popupWindow.popupControl.GetWindowCloseAction(popupWindow.windowIndex);
   if (popupWindow.popupControl != null && (
    (windowCloseAction != "CloseButton" && windowCloseAction != "None") || applyToAll)) {
    popupWindow.popupControl.DoHideWindow(parseInt(popupWindow.windowIndex));
   }
  }
 },
 DoShowAtCurrentPos: function (name, index, popupElementIndex, evtClone) {
  var pc = this.Get(name);
  if (pc != null && !pc.InternalIsWindowVisible(index))
   pc.DoShowWindowAtPos(index, this.overXPos, this.overYPos, popupElementIndex, true, true, evtClone);
 },
 ActivateWindowElement: function (element, evt) {
  var visibleWindowsCount = this.visiblePopupWindowIds.length;
  if (__aspxPopupControlZIndex <= element.style.zIndex && element.style.zIndex != visibleWindowsCount * 2 + __aspxPopupControlZIndex) {
   this.DeleteWindowFromZIndexOrder(element);
  }
  this.SetWindowElementZIndex(element, __aspxPopupControlZIndex + visibleWindowsCount * 2);
  var pcWElementEventSource = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupWindowElement);
  if (!evt || (evt && pcWElementEventSource == element)) { 
   if (this.GetCurrentActiveWindowElement() != element) {
    this.RefreshTabIndexes(false);
    this.SaveCurrentActiveWindowElement(element);
   }
  }
 },
 RefreshTabIndexes: function (forceRecalculate) {
  var topModalWindow = this.GetTopModalWindow();
  if (topModalWindow != null || forceRecalculate) {
   var topModalWindowZIndexArray = _aspxGetElementZIndexArray(topModalWindow);
   this.CalculateTabIndexes(topModalWindowZIndexArray);
  }
 },
 ElementHasTabIndex: function (element) {
  if (__aspxIE && __aspxBrowserVersion < 8) {
   var elementHtml = element.outerHTML;
   var attributeIndex = elementHtml.indexOf('tabIndex');
   return attributeIndex != -1 && attributeIndex < elementHtml.indexOf(">");
  }
  else
   return _aspxIsExists(_aspxGetAttribute(element, "tabindex"));
 },
 IsElementCanBeActive: function (element) {
  return element.tagName === "INPUT" || element.tagName === "A" || this.ElementHasTabIndex(element);
 },
 GetCanBeActiveElements: function () {
  var searchForTabIndexInAllElements = aspxGetPopupControlCollection().searchForTabIndexInAllElements;
  if (searchForTabIndexInAllElements) {
   var elements = document.getElementsByTagName("*");
   var canBeActiveElements = [];
   for (var i = 0; i < elements.length; i++) {
    if (this.IsElementCanBeActive(elements[i], searchForTabIndexInAllElements))
     canBeActiveElements.push(elements[i]);
   }
   return canBeActiveElements;
  } else {
   var inputs = document.getElementsByTagName("INPUT");
   var links = document.getElementsByTagName("A");
   return _aspxCollectionsUnionToArray(inputs, links);
  }
 },
 CalculateTabIndexes: function (topModalWindowZIndexArray) {
  var elements = this.GetCanBeActiveElements();
  for (var i = 0; i < elements.length; i++) {
   var currentElementZIndexArray = _aspxGetElementZIndexArray(elements[i]);
   if (_aspxIsHigher(currentElementZIndexArray, topModalWindowZIndexArray))
    _aspxRestoreTabIndexAttribute(elements[i]);
   else
    _aspxChangeTabIndexAttribute(elements[i]);
  }
 },
 PopupWindowIsModalByVisibleIndex: function (visiblePopupWindowIndex) {
  return this.PopupWindowIsModalByID(this.visiblePopupWindowIds[visiblePopupWindowIndex]);
 },
 PopupWindowIsModalByID: function (windowElementID) {
  var popupWindow = this.GetPopupWindowFromID(windowElementID);
  return popupWindow.popupControl.WindowIsModal(popupWindow.windowIndex);
 },
 SaveCurrentActiveWindowElement: function (windowElement) {
  this.currentActiveWindowElement = windowElement;
 },
 SkipCurrentActiveWindowElement: function (element) {
  if (element == this.GetCurrentActiveWindowElement())
   this.SaveCurrentActiveWindowElement(null);
 },
 GetCurrentActiveWindowElement: function () {
  return this.currentActiveWindowElement;
 },
 GetTopModalWindow: function () {
  var topWindow = null;
  var topWindowZIndexArray = null;
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var currentWindow = _aspxGetElementById(this.visiblePopupWindowIds[i]);
   if (this.PopupWindowIsModalByVisibleIndex(i) && _aspxElementIsVisible(currentWindow)) {
    var currentWindowZIndexArray = _aspxGetElementZIndexArray(currentWindow);
    if (topWindow == null || _aspxIsHigher(currentWindowZIndexArray, topWindowZIndexArray)) {
     topWindow = currentWindow;
     topWindowZIndexArray = currentWindowZIndexArray;
    }
   }
  }
  return topWindow;
 },
 DeleteWindowFromZIndexOrder: function (element) {
  for (var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var windowElement = _aspxGetElementById(this.visiblePopupWindowIds[i]);
   if (!windowElement)
    _aspxArrayRemoveAt(this.visiblePopupWindowIds, i);
   else if (windowElement.style.zIndex > element.style.zIndex)
    this.SetWindowElementZIndex(windowElement, windowElement.style.zIndex - 2);
  }
 },
 SetWindowElementZIndex: function (element, zIndex) {
  element.style.zIndex = zIndex;
  var iFrame = element.overflowElement;
  if (iFrame)
   iFrame.style.zIndex = zIndex - 1;
  var modalElement = element.modalElement;
  if (modalElement)
   modalElement.style.zIndex = zIndex - 1;
  this.UpdateWindowsStateInputElement(element.id);
  this.UpdateWindowsStateCookie(element.id);
 },
 AdjustModalElementsBounds: function () {
  for (var i = 0; i < this.visibleModalElements.length; i++)
   this.AdjustModalElementBounds(this.visibleModalElements[i]);
 },
 AdjustModalElementBounds: function (element) {
  if (!_aspxIsExistsElement(element)) return;
  var x = _aspxPrepareClientPosForElement(0, element, true);
  var y = _aspxPrepareClientPosForElement(0, element, false);
  _aspxSetStylePosition(element, x, y);
  if (__aspxNetscapeFamily && !__aspxFirefox) _aspxSetStyleSize(element, 1, 1);
  _aspxSetStyleSize(element, _aspxGetDocumentWidth(), _aspxGetDocumentHeight());
 },
 ClearAppearTimer: function () {
  this.appearTimerID = _aspxClearTimer(this.appearTimerID);
 },
 ClearDisappearTimer: function () {
  this.disappearTimerID = _aspxClearTimer(this.disappearTimerID);
 },
 IsAppearTimerActive: function () {
  return this.appearTimerID > -1;
 },
 IsDisappearTimerActive: function () {
  return this.disappearTimerID > -1;
 },
 SetAppearTimer: function (name, index, popupElementIndex, timeout, evt) {
  var evtClone = _aspxCloneObject(evt);
  this.appearTimerID = _aspxSetTimeout(function() {
   aspxGetPopupControlCollection().DoShowAtCurrentPos(name, index, popupElementIndex, evtClone); 
  }, timeout);
 },
 SetDisappearTimer: function (name, index, timeout) {
  this.disappearTimerID = _aspxSetTimeout("aspxPWDisappearTimer(\"" + name + "\", " + index + ")", timeout);
 },
 GetDocScrollDifference: function () {
  return new _aspxScrollDifference(_aspxGetDocumentScrollLeft() - this.docScrollLeft, _aspxGetDocumentScrollTop() - this.docScrollTop);
 },
 IsDocScrolled: function (scroll) {
  return scroll.horizontal != 0 || scroll.vertical != 0;
 },
 SaveScrollState: function () {
  this.docScrollLeft = _aspxGetDocumentScrollLeft();
  this.docScrollTop = _aspxGetDocumentScrollTop();
 },
 InitDragObject: function (control, index, x, y, xClientCorrection, yClientCorrection) {
  this.draggingControl = control;
  this.draggingWindowIndex = index;
  this.gragXOffset = x;
  this.gragYOffset = y;
  this.xClientCorrection = xClientCorrection;
  this.yClientCorrection = yClientCorrection;
  this.SetDocumentSelectionBan(true);
 },
 InitOverObject: function (control, index, evt) {
  this.overControl = control;
  this.overWindowIndex = index;
  if (evt)
   this.SaveCurrentMouseOverPos(evt);
 },
 InitResizeObject: function (control, index, cursor, resizePanel) {
  this.resizeControl = control;
  this.resizeIndex = index;
  this.resizeCursor = cursor;
  this.resizePanel = resizePanel;
  this.SetDocumentSelectionBan(true);
 },
 SetDocumentSelectionBan: function (value) {
  this.selectBanned = value;
  if (__aspxWebKitFamily) {
   if (value) {
    if (!this.webkitUserSelectBackup && document.body.style.webkitUserSelect)
     this.webkitUserSelectBackup = document.body.style.webkitUserSelect;
    document.body.style.webkitUserSelect = "none";
   } else {
    if (this.webkitUserSelectBackup) {
     document.body.style.webkitUserSelect = this.webkitUserSelectBackup;
     delete this.webkitUserSelectBackup;
    } else
     document.body.style.webkitUserSelect = "auto";
   }
  }
 },
 IsResizeInint: function () {
  return this.resizeControl != null;
 },
 ClearDragObject: function () {
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.SetDocumentSelectionBan(this.resizeControl != null);
 },
 ClearResizeObject: function () {
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.SetDocumentSelectionBan(this.draggingControl != null);
  this.resizePanel.parentNode.removeChild(this.resizePanel);
 },
 Drag: function (evt) {
  if (!_aspxGetIsLeftButtonPressed(evt)) return;
  var x = _aspxGetEventX(evt);
  var y = _aspxGetEventY(evt);
  if (this.pcWindowsAreRestrictedByDocumentWindow && _aspxCoordinatesInDocumentRect(x, y)) {
   x += this.gragXOffset;
   y += this.gragYOffset;
   this.draggingControl.OnDrag(this.draggingWindowIndex, x, y, this.xClientCorrection, this.yClientCorrection, evt);
   if(__aspxWebKitTouchUI)
    evt.preventDefault();
  }
 },
 DragStop: function () {
  this.draggingControl.OnDragStop(this.draggingWindowIndex);
  this.ClearDragObject();
 },
 ResizeStop: function (evt) {
  this.resizeControl.OnResizeStop(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  aspxGetPopupControlCollection().ClearResizeObject();
 },
 OnPWMouseMove: function (evt, name, index) {
  if (this.draggingControl == null &&
   this.overControl == null &&
   this.resizeControl == null) {
   var pc = aspxGetPopupControlCollection().Get(name);
   if (pc != null) pc.OnMouseMove(evt, index);
  }
 },
 OnPWMouseOver: function (evt) {
  if (!this.overControl || this.draggingControl) return;
  if (this.IsOverPopupWindow(evt))
   this.ClearDisappearTimer();
 },
 IsOverPopupWindow: function (evt) {
  return _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement) != null;
 },
 OnDocumentMouseDown: function (evt) {
  var popupElement = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
  var excptId = popupElement == null ? "" :
   popupElement.DXPopupElementControl.GetWindowElementId(popupElement.DXPopupWindowIndex);
  this.OnMouseDownCore(evt, excptId);
 },
 OnMouseDown: function (evt) {
  this.OnMouseDownCore(evt, "");
 },
 OnMouseDownCore: function (evt, excptId) {
  if (this.IsDocumentIsCoveredByModalElement())
   return;
  var srcElement = _aspxGetEventSource(evt);
  this.DoHideAllWindows(srcElement, excptId, false);
  aspxGetPopupControlCollection().ClearAppearTimer();
 },
 OnMouseMove: function (evt) {
  if(__aspxWebKitTouchUI && ASPxClientTouchUI.isGesture)
   return;
  if (this.draggingControl != null) {
   this.Drag(evt);
  }
  else if (this.overControl != null) {
   this.OnMouseOver(evt);
  }
  else if (this.resizeControl != null) {
   if (__aspxIE && !_aspxGetIsLeftButtonPressed(evt))
    this.ResizeStop(evt);
   else
    this.resizeControl.OnResize(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  }
 },
 OnMouseOver: function (evt) {
  var element = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement);
  if(element != null) {
   var clearTimer = true;
   var popup = element.DXPopupElementControl;
   if(popup && popup.GetLastShownPopupElementIndex(element.DXPopupWindowIndex) != element.DXPopupElementIndex)
    clearTimer = false;
   if(clearTimer)
    this.ClearDisappearTimer();
   this.SaveCurrentMouseOverPos(evt);
   if (__aspxTouchUI && !ASPxClientTouchUI.IsNativeScrolling())
    return;
   return _aspxCancelBubble(evt);
  }
  this.OnMouseOut();
 },
 OnMouseOut: function (evt) {
  if (!this.overControl || this.draggingControl) return;
  this.ClearAppearTimer();
  var windowCloseAction = this.overControl.GetWindowCloseAction(this.overWindowIndex);
  if (windowCloseAction == "MouseOut" && this.overControl.InternalIsWindowVisible(this.overWindowIndex)) {
   if (!this.IsDisappearTimerActive() && this.IsDisappearAllowedByMouseOut(evt))
    this.SetDisappearTimer(this.overControl.name, this.overWindowIndex, this.overControl.disappearAfter);
  }
  else
   this.OverStop();
 },
 IsDisappearAllowedByMouseOut: function (evt) {
  return __aspxFirefox ? !this.IsOverPopupWindow(evt) : true;  
 },
 OnMouseUp: function (evt) {
  if (this.draggingControl != null)
   this.DragStop();
  if (this.resizeControl != null)
   this.ResizeStop(evt);
 },
 OnResize: function (evt) {
  this.AutoUpdateElementsPosition();
  this.AdjustModalElementsBounds();
 },
 OnScroll: function (evt) {
  if (this.scrollEventLockCount > 0)
   return;
  var scroll = this.GetDocScrollDifference();
  if (this.IsDocScrolled(scroll)) { 
   this.CorrectPositionAtScroll(scroll);
   this.AdjustModalElementsBounds();
   this.SaveScrollState();
  }
  if (__aspxIE && __aspxBrowserVersion <= 8){
   this.CalculateDocumentDimensionsWithoutPinnedWindowsOldIE(function(){
    this.FireScrollEventToWindowsOldIE(evt);
   }.aspxBind(this));
  }
  else{
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
   this.FireScrollEventToWindows(evt);
  }
 },
 GetSavedBodyWidth: function(){
  if (this.savedBodyWidth == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyWidth;
 },
 GetSavedBodyHeight: function(){
  if (this.savedBodyHeight == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyHeight;
 },
 HidePinnedPopupsThatOutFromViewPort: function(){
  var popupsToRestoreVisible = [];
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if (!(popupControl.GetIsPinned(popupWindow.windowIndex) && popupControl.GetIsOutFromViewPort(popupWindow.windowIndex)))
    continue;
   var element = popupControl.GetWindowElement(popupWindow.windowIndex);
   if (!element) continue;
   var restoreData = {};
   restoreData.element = element;
   restoreData.display = element.style.display;
   element.style.display = "none";
   popupsToRestoreVisible.push(restoreData);
  }
  return popupsToRestoreVisible;
 },
 RestorePinnedPopupsThatOutFromViewPort: function(popupsToRestoreVisible){
  if (popupsToRestoreVisible.length > 0){
   for (var i = 0; i < popupsToRestoreVisible.length; i++) {
    var restoreData = popupsToRestoreVisible[i];
    restoreData.element.style.display = restoreData.display;
   }
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindows: function() {
  var popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.savedBodyWidth = _aspxGetDocumentWidth();
  this.savedBodyHeight = _aspxGetDocumentHeight();
  this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
 },
 FireScrollEventToWindows: function(evt) {
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   popupControl.OnScroll(evt, popupWindow.windowIndex);
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindowsOldIE: function(onCalculateFinished) {
  var popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.scrollEventLockCount++;
  window.setTimeout(function(){
   this.savedBodyWidth = _aspxGetDocumentWidth();
   this.savedBodyHeight = _aspxGetDocumentHeight();
   this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
   if(onCalculateFinished)
    window.setTimeout(function(){onCalculateFinished(); }.aspxBind(this), 0);
   this.scrollEventLockCount--;
  }.aspxBind(this), 0);
 },
 FireScrollEventToWindowsOldIE: function(evt) {
  this.scrollEventLockCount++;
  this.FireScrollEventToWindows(evt);
  this.scrollEventLockCount--;
 },
 LockScrollEvent: function () {
  this.scrollEventLockCount++;
 },
 UnlockScrollEvent: function () {
  this.scrollEventLockCount--;
 },
 CorrectPositionAtScroll: function (scroll) {
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if (popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex)) {
    var isNeedFix = popupControl.liteRender ? false : popupControl.IsFFTextCurFixRequired(popupWindow.windowIndex);
    if (popupControl.GetAutoUpdatePosition(popupWindow.windowIndex))
     popupWindow.popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
    else if (isNeedFix) 
     this.FFScrollEmulation(scroll, popupWindow);
   }
  }
 },
 FFScrollEmulation: function (scroll, popupWindow) {
  var windowElement = popupWindow.popupControl.GetWindowElement(popupWindow.windowIndex);
  windowElement.style.left = (windowElement.offsetLeft - scroll.horizontal) + "px";
  windowElement.style.top = (windowElement.offsetTop - scroll.vertical) + "px";
 },
 OnSelectStart: function () {
  return !this.selectBanned;
 },
 OverStop: function () {
  this.overControl = null;
  this.overWindowIndex = -1;
 },
 OnPWDisappearTimer: function (name, index) {
  var pc = this.Get(name);
  if (pc != null) {
   if (!pc.DoHideWindow(index))
    this.OverStop();
   this.ClearDisappearTimer();
  }
 },
 SaveCurrentMouseOverPos: function (evt) {
  this.overXPos = _aspxGetEventX(evt);
  this.overYPos = _aspxGetEventY(evt);
 },
 RegisterVisibleModalElement: function (element) {
  if (_aspxArrayIndexOf(this.visibleModalElements, element) == -1)
   this.visibleModalElements.push(element);
 },
 UnregisterVisibleModalElement: function (element) {
  _aspxArrayRemove(this.visibleModalElements, element);
 },
 RegisterVisibleWindow: function (element, popupControl, index) {
  if (_aspxArrayIndexOf(this.visiblePopupWindowIds, element.id) == -1) {
   this.visiblePopupWindowIds.push(element.id);
   if (popupControl)
    aspxGetPopupControlCollection().InitOverObject(popupControl, index, null);
   this.OnRegisteredVisibleWindow(element);
  }
 },
 OnRegisteredVisibleWindow: function (element) {
  var elementIndex = _aspxArrayIndexOf(this.visiblePopupWindowIds, element.id);
  if (this.PopupWindowIsModalByVisibleIndex(elementIndex))
   _aspxRemoveFocus(element);
 },
 UnregisterVisibleWindow: function (element) {
  this.DeleteWindowFromZIndexOrder(element);
  _aspxArrayRemove(this.visiblePopupWindowIds, element.id);
  var forceRecalculate = this.PopupWindowIsModalByID(element.id);
  this.RefreshTabIndexes(forceRecalculate);
  this.SkipCurrentActiveWindowElement(element);
 },
 UpdateWindowsStateCookie: function (id) {
  var pos = id.lastIndexOf(__aspxPCWIdSuffix);
  var name = id.substring(0, pos);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  if (popupControl != null)
   popupControl.UpdateWindowsStateCookie(false);
 },
 UpdateWindowsStateInputElement: function (id) {
  var pos = id.lastIndexOf(__aspxPCWIdSuffix);
  var name = id.substring(0, pos);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  if (popupControl != null)
   popupControl.UpdateWindowsStateInputElement(false);
 },
 AutoUpdateElementsPosition: function () {
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if (popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex))
    popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
  }
 },
 IsDocumentIsCoveredByModalElement: function () {
  for (var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if (popupControl && popupControl.GetWindowModalElement(popupWindow.windowIndex))
    return true;
  }
  return false;
 },
 LockWindowResizeByBodyScrollVisibilityChanging: function () {
  this.windowResizeByBodyScrollVisibilityChangingLockCount++;
 },
 UnlockWindowResizeByBodyScrollVisibilityChanging: function () {
  this.windowResizeByBodyScrollVisibilityChangingLockCount--;
 },
 WindowResizeByBodyScrollVisibilityChangingLocked: function () {
  return this.windowResizeByBodyScrollVisibilityChangingLockCount > 0;
 },
 HideAllWindows: function () {
  this.DoHideAllWindows(null, "", true);
 }
});
var __aspxPopupControlCollection = null;
function aspxGetPopupControlCollection() {
 if (__aspxPopupControlCollection == null)
  __aspxPopupControlCollection = new ASPxClientPopupControlCollection();
 return __aspxPopupControlCollection;
}
ASPxClientPopupWindow = _aspxCreateClass(null, {
 constructor: function (popupControl, index, name) {
  this.popupControl = popupControl;
  this.index = index;
  this.name = name;
 },
 GetHeaderImageUrl: function () {
  return this.popupControl.GetWindowHeaderImageUrl(this.index);
 },
 SetHeaderImageUrl: function (value) {
  this.popupControl.SetWindowHeaderImageUrl(this.index, value);
 },
 GetFooterImageUrl: function () {
  return this.popupControl.GetWindowFooterImageUrl(this.index);
 },
 SetFooterImageUrl: function (value) {
  this.popupControl.SetWindowFooterImageUrl(this.index, value);
 },
 GetHeaderNavigateUrl: function () {
  return this.popupControl.GetWindowHeaderNavigateUrl(this.index);
 },
 SetHeaderNavigateUrl: function (value) {
  this.popupControl.SetWindowHeaderNavigateUrl(this.index, value);
 },
 GetFooterNavigateUrl: function () {
  return this.popupControl.GetWindowFooterNavigateUrl(this.index);
 },
 SetFooterNavigateUrl: function (value) {
  this.popupControl.SetWindowFooterNavigateUrl(this.index, value);
 },
 GetHeaderText: function () {
  return this.popupControl.GetWindowHeaderText(this.index);
 },
 SetHeaderText: function (value) {
  this.popupControl.SetWindowHeaderText(this.index, value);
 },
 GetFooterText: function () {
  return this.popupControl.GetWindowFooterText(this.index);
 },
 SetFooterText: function (value) {
  this.popupControl.SetWindowFooterText(this.index, value);
 }
});
ASPxClientPopupWindowEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function (window) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
 }
});
ASPxClientPopupWindowCancelEventArgs = _aspxCreateClass(ASPxClientCancelEventArgs, {
 constructor: function (window) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
 }
});
ASPxClientPopupWindowResizeEventArgs = _aspxCreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function (window, resizeState) {
  this.constructor.prototype.constructor.call(this, window);
  this.resizeState = resizeState;
 }
});
ASPxClientPopupWindowPinnedChangedEventArgs = _aspxCreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function (window, pinned) {
  this.constructor.prototype.constructor.call(this, window);
  this.pinned = pinned;
 }
});
function _aspxPopupWindow(popupControl, windowIndex) {
 this.popupControl = popupControl;
 this.windowIndex = windowIndex;
}
function _aspxScrollDifference(horizontal, vertical) {
 this.horizontal = horizontal;
 this.vertical = vertical;
}
function aspxPWDisappearTimer(name, index) {
 aspxGetPopupControlCollection().OnPWDisappearTimer(name, index);
}
function aspxPWHMDown(evt) {
 return _aspxCancelBubble(evt);
}
function aspxPWCBClick(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnPWHBClickCore(evt, index, "OnCloseButtonClick");
}
function aspxPWPBClick(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnPWHBClickCore(evt, index, "OnPinButtonClick");
}
function aspxPWRBClick(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnPWHBClickCore(evt, index, "OnRefreshButtonClick");
}
function aspxPWMNBClick(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnPWHBClickCore(evt, index, "OnCollapseButtonClick");
}
function aspxPWMXBClick(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnPWHBClickCore(evt, index, "OnMaximizeButtonClick");
}
function aspxPWEMOver(evt) {
 aspxGetPopupControlCollection().OnPWMouseOver(evt);
}
function aspxPWMEMDown(evt) {
 var element = _aspxGetEventSource(evt);
 if (element != null) 
  element.DXModalPopupControl.OnMouseDownModalElement(evt, element.DXModalPopupWindowIndex);
}
function aspxPEMEvent(evt) {
 var element = _aspxFindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
 if(element != null) {
  var popupControl = element.DXPopupElementControl;
  var index = element.DXPopupWindowIndex;
  if(evt.type == "mousedown") {
   popupControl.SetIsPopuped(index, popupControl.InternalIsWindowVisible(index));
   aspxGetPopupControlCollection().OnMouseDown(evt);
  }
  else {
   var windowPopupAction = popupControl.GetWindowPopupAction(element.DXPopupWindowIndex);
   var leftMouseButtonAction = windowPopupAction == "LeftMouseClick" && _aspxGetIsLeftButtonPressed(evt);
   var rightMouseButtonAction = windowPopupAction == "RightMouseClick" && !_aspxGetIsLeftButtonPressed(evt);
   if (leftMouseButtonAction || rightMouseButtonAction) {
    if (rightMouseButtonAction)
     _aspxPreventContextMenu(evt);
    var windowCloseAction = popupControl.GetWindowCloseAction(index);
    var isPopuped = popupControl.GetIsPopuped(index);
    var isNewPopupElement = popupControl.GetLastShownPopupElementIndex(index) != element.DXPopupElementIndex;
    if(isPopuped && isNewPopupElement) {
     popupControl.DoHideWindow(index);
     aspxGetPopupControlCollection().ClearDisappearTimer();
     isPopuped = false;
    }
    if(!(isPopuped && windowCloseAction == "OuterMouseClick")) {
     popupControl.DoShowWindow(index, element.DXPopupElementIndex, evt);
    }
    if(windowCloseAction == "MouseOut")
     aspxGetPopupControlCollection().InitOverObject(popupControl, element.DXPopupWindowIndex, evt);
    return false;
   }
  }
 }
}
function aspxPWDGMDown(evt, name, index) {
 return aspxPWMDown(evt, name, index, true);
}
function aspxPWGripMDown(evt, name, index) {
 aspxPWMDownCore(evt, name, index, false);
 return aspxPWHMDown(evt);
}
function aspxPointOnElementScrollBar(element, x, y, rtl) {
 var scrollWidth = _aspxGetVerticalScrollBarWidth(); 
 var hasHorizontalScroll = element.scrollWidth > element.clientWidth;
 var hasVerticalScroll = element.scrollHeight > element.clientHeight;
 var ceilX = rtl ? _aspxGetAbsoluteX(element) + scrollWidth : 
  _aspxGetAbsoluteX(element) + (element.offsetWidth - _aspxGetHorizontalBordersWidth(element));
 var ceilY = _aspxGetAbsoluteY(element) + (element.offsetHeight - _aspxGetVerticalBordersWidth(element));
 return (hasVerticalScroll && x >= ceilX - scrollWidth && x <= ceilX) ||
     (hasHorizontalScroll && y >= ceilY - scrollWidth && y <= ceilY);
}
function aspxPWMDown(evt, name, index, isWindowContentDraggingAllowed) {
 var pointOnScrollBar = false;
 var pc = aspxGetPopupControlCollection().Get(name); 
 if(pc && pc.enableContentScrolling) {
  var rtl = pc.rtl && (__aspxIE || __aspxFirefox || __aspxOpera);
  pointOnScrollBar = aspxPointOnElementScrollBar(pc.GetContentContainer(index), evt.clientX, evt.clientY, rtl);
 }
 aspxPWMDownCore(evt, name, index, isWindowContentDraggingAllowed, pointOnScrollBar);
 if (isWindowContentDraggingAllowed) { 
  aspxGetPopupControlCollection().OnDocumentMouseDown(evt); 
  if (typeof (aspxGetDropDownCollection) == "function")
   aspxGetDropDownCollection().OnDocumentMouseDown(evt); 
  if(!pointOnScrollBar) {
   if(!__aspxWebKitTouchUI && _aspxGetEventSource(evt).tagName == "IMG") 
    evt.preventDefault();
  }
 }
}
function aspxPWMDownCore(evt, name, index, isDraggingAllowed, pointOnScrollBar) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) {
  pc.OnActivateMouseDown(evt, index);
  pc.OnMouseDown(evt, index, isDraggingAllowed, pointOnScrollBar);
 }
}
function aspxPWMMove(evt, name, index) {
 aspxGetPopupControlCollection().OnPWMouseMove(evt, name, index);
}
function aspxPCATimer(name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnAnimationTimer(index);
}
function aspxPCAStop(name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if (pc != null) pc.OnAnimationStop(index);
}
function aspxPCIframeLoad(evt) {
 var srcElement = _aspxGetEventSource(evt);
 if (srcElement) {
  var pcName = srcElement.popupControlName;
  var pcWndIndex = srcElement.pcWndIndex;
  if (pcName) {
   var pc = aspxGetPopupControlCollection().Get(pcName);
   pc.OnIFrameLoad(pcWndIndex);
  }
 }
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseDownEventName, aspxPopupControlDocumentMouseDown);
function aspxPopupControlDocumentMouseDown(evt) {
 aspxGetPopupControlCollection().OnDocumentMouseDown(evt);
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseUpEventName, aspxPopupControlDocumentMouseUp);
function aspxPopupControlDocumentMouseUp(evt) {
 return aspxGetPopupControlCollection().OnMouseUp(evt);
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseMoveEventName, aspxPopupControlDocumentMouseMove);
function aspxPopupControlDocumentMouseMove(evt) {
 if (typeof (aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseMove(evt);
}
_aspxAttachEventToDocument("mouseout", aspxPopupControlDocumentMouseOut);
function aspxPopupControlDocumentMouseOut(evt) {
 if (typeof (aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseOut(evt);
}
_aspxAttachEventToElement(window, "resize", aspxPopupControlWindowResize);
function aspxPopupControlWindowResize(evt) {
 aspxGetPopupControlCollection().OnResize(evt);
}
_aspxAttachEventToElement(window, "scroll", aspxPopupControlWindowScroll);
function aspxPopupControlWindowScroll(evt) {
 aspxGetPopupControlCollection().OnScroll(evt);
}
_aspxAttachEventToDocument("selectstart", aspxPopupControlDocumentSelectStart);
function aspxPopupControlDocumentSelectStart(evt) {
 var ret = aspxGetPopupControlCollection().OnSelectStart(evt);
 if (!ret) return false; 
}
function aspxTestPopupWindowElement(element) {
 return !!element.DXPopupWindowElement;
}
function aspxTestPopupControlElement(element) {
 return element.DXPopupElementControl && _aspxIsExists(element.DXPopupWindowIndex);
}
function aspxTestPopupControlOverElement(element) {
 var collection = aspxGetPopupControlCollection();
 var popupControl = collection.overControl;
 var index = collection.overWindowIndex;
 var windowId = popupControl.GetWindowElementId(index);
 if(element.id == windowId)
  return true;
 var popupElements = popupControl.GetPopupElementList(index);
 for(var i = 0; i < popupElements.length; i++)
  if(popupElements[i] == element)
   return true;
 return false;
}

