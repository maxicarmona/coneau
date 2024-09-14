var __aspxClassesScriptParsed = false;
var __aspxDocumentLoaded = false; 
ASPxClientEvent = _aspxCreateClass(null, {
 constructor: function() {
  this.handlerInfoList = [];
 },
 AddHandler: function(handler, executionContext) {
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  this.handlerInfoList.push(handlerInfo);
 },
 RemoveHandler: function(handler, executionContext) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.handler == handler && 
    (!executionContext || handlerInfo.executionContext == executionContext);
  });
 },
 removeHandlerByCondition: function(predicate) {
   for(var i = this.handlerInfoList.length - 1; i >= 0; i--) {
   var handlerInfo = this.handlerInfoList[i];
   if(predicate(handlerInfo))
    _aspxArrayRemoveAt(this.handlerInfoList, i);
  }
 },
 removeHandlerByControlName: function(controlName) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.executionContext &&  
    handlerInfo.executionContext.name === controlName;
  });
 },
 ClearHandlers: function() {
  this.handlerInfoList.length = 0;
 },
 FireEvent: function(obj, args) {
  for(var i = 0; i < this.handlerInfoList.length; i++) {
   var handlerInfo = this.handlerInfoList[i];
   handlerInfo.handler.call(handlerInfo.executionContext, obj, args);
  }
 },
 InsertFirstHandler: function(handler, executionContext){
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  _aspxArrayInsert(this.handlerInfoList, handlerInfo, 0);
 },
 IsEmpty: function() {
  return this.handlerInfoList.length == 0;
 }
});
ASPxClientEvent.CreateHandlerInfo = function(handler, executionContext) {
 return {
  handler: handler,
  executionContext: executionContext
 };
};
ASPxClientEventArgs = _aspxCreateClass(null, {
 constructor: function() {
 }
});
ASPxClientEventArgs.Empty = new ASPxClientEventArgs();
ASPxClientCancelEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.cancel = false;
 }
});
ASPxClientProcessingModeEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this);
  this.processOnServer = processOnServer;
 }
});
ASPxClientProcessingModeCancelEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.cancel = false;
 }
});
ASPxClientBeginCallbackEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(command){
  this.constructor.prototype.constructor.call(this);
  this.command = command;
 }
});
ASPxClientEndCallbackEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
 }
});
ASPxClientCustomDataCallbackEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(result) {
  this.constructor.prototype.constructor.call(this);
  this.result = result;
 }
});
ASPxClientCallbackErrorEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(message){
  this.constructor.prototype.constructor.call(this);
  this.message = message;
  this.handled = false;
 }
});
ASPxClientControlsInitializedEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(isCallback) {
  this.isCallback = isCallback;
 }
});
ASPxClientControlCollection = _aspxCreateClass(null, {
 constructor: function(){
  this.elements = new Object();
  this.windowResizeSubscribers = [];
  this.prevWndWidth = "";
  this.prevWndHeight = "";
  this.BeforeInitCallback = new ASPxClientEvent();
  this.ControlsInitialized = new ASPxClientEvent();
 },
 Add: function(element){
  this.elements[element.name] = element;
 },
 Remove: function(element) {
  this.elements[element.name] = null;
 },
 Get: function(name){
  return this.elements[name];
 },
 GetGlobal: function(name) {
  var result = window[name];
  return result && result.isASPxClientControl
   ? result
   : null;
 },
 GetByName: function(name){
  return this.Get(name) || this.GetGlobal(name);
 },
 ForEachControl: function(processFunc, context) {
  if(!context)
   context = this;
  for(var name in this.elements) {
   var control = this.elements[name];
   if(ASPxIdent.IsASPxClientControl(control))
    if(processFunc.call(context, control))
     return;
  }
 },
 AdjustControls: function(container, checkSizeCorrectedFlag) {
  if(typeof(container) == "undefined")
   container = null;
  if(typeof(checkSizeCorrectedFlag) == "undefined")
   checkSizeCorrectedFlag = false;
  var collection = this;
  window.setTimeout(function() {
   collection.ProcessControlsInContainer(container, function(control) {
    control.AdjustControl(checkSizeCorrectedFlag);
   });
  }, 0);
 },
 CollapseControls: function(container, checkSizeCorrectedFlag) {
  this.ProcessControlsInContainer(container, function(control) {
   control.CollapseControl(checkSizeCorrectedFlag);
  });
 },
 AtlasInitialize: function(isCallback) {
  if(__aspxIE && __aspxBrowserMajorVersion < 9) {
   var func = function() {
    if(_aspxIsLinksLoaded())
     _aspxProcessScriptsAndLinks("", isCallback); 
    else
     setTimeout(func, 100);
   }   
   func();
  }
  else
   _aspxProcessScriptsAndLinks("", isCallback);
 },
 Initialize: function() {
  this.InitializeElements(false );
  if(typeof(Sys) != "undefined" && typeof(Sys.Application) != "undefined")
   Sys.Application.add_load(aspxCAInit);
  this.InitWindowSizeCache();
 },
 InitializeElements: function(isCallback) {
  this.ForEachControl(function(control){
   if(!control.isInitialized)
    control.Initialize();
  });
  if(typeof(_aspxGetEditorStretchedInputElementsManager) != "undefined")
   _aspxGetEditorStretchedInputElementsManager().Initialize();
  this.AfterInitializeElements(true);
  this.AfterInitializeElements(false);
  this.RaiseControlsInitialized(isCallback);
 },
 AfterInitializeElements: function(leadingCall) {
  this.ForEachControl(function(control){
   if (control.leadingAfterInitCall && leadingCall || !control.leadingAfterInitCall && !leadingCall) {
    if(!control.isInitialized)
     control.AfterInitialize();
   }
  });
 },
 DoFinalizeCallback: function() {
  this.ForEachControl(function(control){
   control.DoFinalizeCallback();
  });
 },
 ProcessControlsInContainer: function(container, processFunc) {
  this.ForEachControl(function(control){
   if(!container || this.IsControlInContainer(container, control))
    processFunc(control);
  });
 },
 IsControlInContainer: function(container, control) {
  if(control.GetMainElement) {
   var mainElement = control.GetMainElement();
   if(mainElement && (mainElement != container)) {
    if(_aspxGetIsParent(container, mainElement))
     return true;
   }
  }
  return false;
 },
 RaiseControlsInitialized: function(isCallback) {
  if(!this.ControlsInitialized.IsEmpty()){
   if(typeof(isCallback) == "undefined")
    isCallback = true;
   var args = new ASPxClientControlsInitializedEventArgs(isCallback);
   this.ControlsInitialized.FireEvent(this, args);
  }
 },
 Before_WebForm_InitCallback: function(){
  var args = new ASPxClientEventArgs();
  this.BeforeInitCallback.FireEvent(this, args);
 },
 InitWindowSizeCache: function(){
  this.prevWndWidth = document.documentElement.clientWidth;
  this.prevWndHeight = document.documentElement.clientHeight;
 },
 BrowserWindowSizeChanged: function(){
  var wndWidth = _aspxGetDocumentClientWidth();
  var wndHeight = _aspxGetDocumentClientHeight();
  var browserWindowSizeChanged = (this.prevWndWidth != wndWidth) || (this.prevWndHeight != wndHeight);
  if(browserWindowSizeChanged){
   this.prevWndWidth = wndWidth;
   this.prevWndHeight = wndHeight;
   return true;
  }
  return false;
 },
 OnBrowserWindowResize: function(evt){
  if(this.BrowserWindowSizeChanged()){
   this.ForEachControl(function(control) {
    control.OnBrowserWindowResizeInternal(evt);
   });
    for(var i = 0; i < this.windowResizeSubscribers.length; i++)
    this.windowResizeSubscribers[i].OnBrowserWindowResize(evt);
  }
 }
});
ASPxClientControl = _aspxCreateClass(null, {
 constructor: function(name){
  this.isASPxClientControl = true;
  this.name = name;
  this.uniqueID = name;  
  this.enabled = true;
  this.clientEnabled = true;
  this.clientVisible = true;
  this.rtl = false;
  this.autoPostBack = false;
  this.allowMultipleCallbacks = true;
  this.callBack = null;
  this.enableCallbackAnimation = false;
  this.enableSlideCallbackAnimation = false;
  this.slideAnimationDirection = null;
  this.beginCallbackAnimationProcessing = false;
  this.endCallbackAnimationProcessing = false;
  this.savedCallbackResult = null;
  this.savedCallbacks = null;
  this.isCallbackAnimationPrevented = false;
  this.lpDelay = 300;
  this.lpTimer = -1;
  this.isNative = false;
  this.requestCount = 0;
  this.enableSwipeGestures = false;
  this.supportGestures = false;
  this.repeatedGestureValue = 0;
  this.repeatedGestureCount = 0;
  this.isInitialized = false;
  this.initialFocused = false;
  this.leadingAfterInitCall = false; 
  this.sizeCorrectedOnce = false;
  this.serverEvents = [];
  this.dialogContentHashTable = { };
  this.loadingPanelElement = null;
  this.loadingDivElement = null;  
  this.hasPhantomLoadingElements = false;
  this.mainElement = null;
  this.renderIFrameForPopupElements = false;
  this.widthValueSetInPercentage = false;
  this.sizingConfig = {
   allowSetWidth: true,
   allowSetHeight: true,
   correction : false,
   adjustControl : false
  };
  this.Init = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.EndCallbackAnimationStart = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.CustomDataCallback = new ASPxClientEvent();
  aspxGetControlCollection().Add(this);  
 },
 Initialize: function() {
  if(this.callBack != null)
   this.InitializeCallBackData();
 },
 InlineInitialize: function() {
  this.InitializeGestures();
 },
 InitializeGestures: function() {
  if(this.enableSwipeGestures && this.supportGestures)
   ASPxGesturesHelper.AddSwipeGestureHandler(this.name, 
    function() { return this.GetCallbackAnimationElement(); }.aspxBind(this), 
    function(evt) { return this.CanHandleGestureCore(evt); }.aspxBind(this), 
    function(value) { return this.AllowStartGesture(); }.aspxBind(this),
    function(value) { return this.StartGesture(); }.aspxBind(this),
    function(value) { return this.AllowExecuteGesture(value); }.aspxBind(this),
    function(value) { this.ExecuteGesture(value); }.aspxBind(this),
    function(value) { this.CancelGesture(value); }.aspxBind(this)
   );
 },
 InitailizeFocus: function() {
  if(this.initialFocused && this.IsVisible())
   this.Focus();
 },
 AfterInitialize: function() {
  this.AdjustControl(__aspxCheckSizeCorrectedFlag);
  this.InitailizeFocus();
  this.isInitialized = true;
  this.RaiseInit();
  if(this.savedCallbacks) {
   for(var i = 0; i < this.savedCallbacks.length; i++) 
    this.CreateCallbackInternal(this.savedCallbacks[i].arg, this.savedCallbacks[i].command, 
     false, this.savedCallbacks[i].callbackInfo);
   this.savedCallbacks = null;
  }
 },
 InitializeCallBackData: function() {
 },
 RenderExistsOnPage: function() {
  return _aspxIsExistsElement(this.GetMainElement());
 },
 IsStateControllerEnabled: function(){
  return typeof(aspxGetStateController) != "undefined" && aspxGetStateController();
 },
 GetWidth: function() {
  return this.GetMainElement().offsetWidth;
 },
 GetHeight: function() {
  return this.GetMainElement().offsetHeight;
 },
 SetWidth: function(width) {
  if(this.sizingConfig.allowSetWidth)
   this.SetSizeCore("width", width, "GetWidth", false);
 },
 SetHeight: function(height) {
  if(this.sizingConfig.allowSetHeight)
   this.SetSizeCore("height", height, "GetHeight", false);
 },
 SetSizeCore: function(sizePropertyName, size, getFunctionName, corrected) {
  if(size < 0)
   return;
  this.GetMainElement().style[sizePropertyName] = size + "px";
  if(this.sizingConfig.adjustControl)
   this.AdjustControl(false, true);
  if(this.sizingConfig.correction && !corrected) {
   var realSize = this[getFunctionName]();
   if(realSize != size) {
    var correctedSize = size - (realSize - size);
    this.SetSizeCore(sizePropertyName, correctedSize, getFunctionName, true);
   }
  }
 },
 CollapseControl: function(checkSizeCorrectedFlag) {
 },
 AdjustControl: function(checkSizeCorrectedFlag, nestedCall) {
  if(checkSizeCorrectedFlag && this.sizeCorrectedOnce || ASPxClientControl.adjustControlLocked && !nestedCall) {
   this.TryShowPhantomLoadingElements();
   return;
  }
  ASPxClientControl.adjustControlLocked = true;
  try {
   var mainElement = this.GetMainElement();
   if (!mainElement || !this.IsDisplayed() || this.IsHidden())
    return;
   if(!this.sizeCorrectedOnce)
    this.UpdateWidthCorrectionRequired();
   this.AdjustControlCore();
   this.TryShowPhantomLoadingElements();
   this.sizeCorrectedOnce = true;
  } finally {
   delete ASPxClientControl.adjustControlLocked;
  }
 },
 ResetControlAdjustment: function () {
  this.sizeCorrectedOnce = false;
 },
 UpdateWidthCorrectionRequired: function() {
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var mainElementStyle = _aspxGetCurrentStyle(mainElement);
   this.widthValueSetInPercentage = _aspxIsWidthSetInPercentage(mainElementStyle.width) || _aspxIsWidthSetInPercentage(mainElement.style.width);
  }
 },
 OnBrowserWindowResize: function(evt) {
 },
 AdjustControlCore: function() {
 },
 OnBrowserWindowResizeInternal: function(evt){
  if(this.widthValueSetInPercentage) 
   this.OnBrowserWindowResize(evt);
 },
 RegisterServerEventAssigned: function(eventNames){
  for(var i = 0; i < eventNames.length; i++)
   this.serverEvents[eventNames[i]] = true;
 },
 IsServerEventAssigned: function(eventName){
  return !!this.serverEvents[eventName];
 },
 GetChild: function(idPostfix){
  var mainElement = this.GetMainElement();
  return mainElement ? _aspxGetChildById(mainElement, this.name + idPostfix) : null;
 },
 GetItemElementName: function(element) {
  var name = "";
  if(element.id)
   name = element.id.substring(this.name.length + 1);
  return name;
 },
 GetLinkElement: function(element) {
  if (element == null) return null;
  return (element.tagName == "A") ? element : _aspxGetChildByTagName(element, "A", 0);
 },
 GetInternalHyperlinkElement: function(parentElement, index) {
  var element = _aspxGetChildByTagName(parentElement, "A", index);
  if (element == null) 
   element = _aspxGetChildByTagName(parentElement, "SPAN", index);
  return element;
 },
 GetParentForm: function(){
  return _aspxGetParentByTagName(this.GetMainElement(), "FORM");
 },
 GetMainElement: function(){
  if(!_aspxIsExistsElement(this.mainElement))
   this.mainElement = _aspxGetElementById(this.name);
  return this.mainElement;
 },
 OnControlClick: function(clickedElement, htmlEvent) {
 },
 IsLoadingContainerVisible: function(){
  return this.IsVisible();
 },
 GetLoadingPanelElement: function(){
  return _aspxGetElementById(this.name + "_LP");
 },
 CloneLoadingPanel: function(element, parent) {
  var clone = element.cloneNode(true);
  clone.id = element.id + "V";
  parent.appendChild(clone);
  return clone;
 },
 CreateLoadingPanelInsideContainer: function(parentElement, hideContent, collapseHeight, collapseWidth) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if (element != null){
   var width = collapseWidth ? 0 : _aspxGetClearClientWidth(parentElement);
   var height = collapseHeight ? 0 : _aspxGetClearClientHeight(parentElement);
   if(hideContent){
    for(var i = parentElement.childNodes.length - 1; i > -1; i--){
     if(parentElement.childNodes[i].style)
      parentElement.childNodes[i].style.display = "none";
     else if(parentElement.childNodes[i].nodeType == 3) 
      parentElement.removeChild(parentElement.childNodes[i]);
    }
   }
   else
    parentElement.innerHTML = "";
   var table = document.createElement("TABLE");
   parentElement.appendChild(table);
   table.border = 0;
   table.cellPadding = 0;
   table.cellSpacing = 0;
   table.style.height = (height > 0) ? height + "px" : "100%";
   table.style.width = (width > 0) ? width + "px" : "100%";
   var tbody = document.createElement("TBODY");
   table.appendChild(tbody);
   var tr = document.createElement("TR");
   tbody.appendChild(tr);
   var td = document.createElement("TD");
   tr.appendChild(td);
   td.align = "center";
   td.vAlign = "middle";
   element = this.CloneLoadingPanel(element, td);
   _aspxSetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  } else
   parentElement.innerHTML = "&nbsp;";
  return null;
 },
 CreateLoadingPanelWithAbsolutePosition: function(parentElement, offsetElement) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   element.style.position = "absolute";
   _aspxSetElementDisplay(element, true);
   this.SetLoadingPanelLocation(offsetElement, element);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 CreateLoadingPanelInline: function(parentElement){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   _aspxSetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 ShowLoadingPanel: function() {
 },
 ShowLoadingElements: function() {
  if(this.InCallback() || this.lpTimer > -1) return;
  this.ShowLoadingDiv();
  if(this.IsCallbackAnimationEnabled())
   this.StartBeginCallbackAnimation();
  else
   this.ShowLoadingElementsInternal();
 },
 ShowLoadingElementsInternal: function() {
  if(this.lpDelay > 0 && !this.IsCallbackAnimationEnabled()) {
   var _this = this;
   this.lpTimer = _aspxSetTimeout(function() { _this.ShowLoadingPanelOnTimer(); }, this.lpDelay);
  }
  else {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 GetLoadingPanelOffsetElement: function (baseElement) {
  if(this.IsCallbackAnimationEnabled()) {
   var element = this.GetLoadingPanelCallbackAnimationOffsetElement();
   if(element) {
    var container = typeof(ASPxAnimationHelper) != "undefined" ? ASPxAnimationHelper.findSlideAnimationContainer(element) : null;
    if(container)
     return container.parentNode.parentNode;
    else
     return element;
   }
  }
  return baseElement;
 },
 GetLoadingPanelCallbackAnimationOffsetElement: function () {
  return this.GetCallbackAnimationElement();
 },
 IsCallbackAnimationEnabled: function () {
  return (this.enableCallbackAnimation || this.enableSlideCallbackAnimation) && !this.isCallbackAnimationPrevented;
 },
 StartBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = true;
  this.isCallbackFinished = false;
  var element = this.GetCallbackAnimationElement();
  if(element && this.enableSlideCallbackAnimation && this.slideAnimationDirection) 
   ASPxAnimationHelper.slideOut(element, this.slideAnimationDirection, this.FinishBeginCallbackAnimation.aspxBind(this));
  else if(element && this.enableCallbackAnimation) 
   ASPxAnimationHelper.fadeOut(element, this.FinishBeginCallbackAnimation.aspxBind(this));
  else
   this.FinishBeginCallbackAnimation();
 },
 FinishBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = false;
  if(!this.isCallbackFinished)
   this.ShowLoadingElementsInternal();
  else {
   this.DoCallback(this.savedCallbackResult);
   this.savedCallbackResult = null;
  }
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  if(this.beginCallbackAnimationProcessing) {
   this.savedCallbackResult = callbackResult;
   this.isCallbackFinished = true;
   return true;
  }
  return false;
 },
 StartEndCallbackAnimation: function () {
  this.HideLoadingPanel();
  this.SetInitialLoadingDivOpacity();
  this.RaiseEndCallbackAnimationStart();
  this.endCallbackAnimationProcessing = true;
  var element = this.GetCallbackAnimationElement();
  if(element && this.enableSlideCallbackAnimation && this.slideAnimationDirection) 
   ASPxAnimationHelper.slideIn(element, this.slideAnimationDirection, this.FinishEndCallbackAnimation.aspxBind(this));
  else if(element && this.enableCallbackAnimation) 
   ASPxAnimationHelper.fadeIn(element, this.FinishEndCallbackAnimation.aspxBind(this));
  else
   this.FinishEndCallbackAnimation();
  this.slideAnimationDirection = null;
 },
 FinishEndCallbackAnimation: function () {
  this.DoEndCallback();
  this.endCallbackAnimationProcessing = false;
  this.CheckRepeatGesture();
 },
 CheckEndCallbackAnimationNeeded: function() {
  if(!this.endCallbackAnimationProcessing && this.requestCount == 1) {
   this.StartEndCallbackAnimation();
   return true;
  }
  return false;
 },
 PreventCallbackAnimation: function() {
  this.isCallbackAnimationPrevented = true;
 },
 GetCallbackAnimationElement: function() {
  return null;
 },
 AssignSlideAnimationDirectionByPagerArgument: function(arg, currentPageIndex) {
  this.slideAnimationDirection = null;
  if(this.enableSlideCallbackAnimation && typeof(ASPxAnimationHelper) != "undefined") {
   if (arg == ASPxClientPagerCommands.Next || arg == ASPxClientPagerCommands.Last)
    this.slideAnimationDirection = ASPxAnimationHelper.SLIDE_LEFT_DIRECTION;
   else if (arg == ASPxClientPagerCommands.First || arg == ASPxClientPagerCommands.Prev)
    this.slideAnimationDirection = ASPxAnimationHelper.SLIDE_RIGHT_DIRECTION;
   else if(!isNaN(currentPageIndex) && arg.indexOf(ASPxClientPagerCommands.PageNumber) == 0) {
    var newPageIndex = parseInt(arg.substring(2));
    if(!isNaN(newPageIndex))
     this.slideAnimationDirection = newPageIndex < currentPageIndex ? ASPxAnimationHelper.SLIDE_RIGHT_DIRECTION : ASPxAnimationHelper.SLIDE_LEFT_DIRECTION;
   }
  }
 },
 TryShowPhantomLoadingElements: function () {
  if (this.hasPhantomLoadingElements && this.InCallback()) {
   this.ShowLoadingDivAndPanel();
   this.hasPhantomLoadingElements = false;
  }
 },
 ShowLoadingDivAndPanel: function () {
  this.ShowLoadingDiv();
  this.RestoreLoadingDivOpacity();
  this.ShowLoadingPanel();
 },
 HideLoadingElements: function() {
  this.HideLoadingPanel();
  this.HideLoadingDiv();
 },
 ShowLoadingPanelOnTimer: function() {
  this.ClearLoadingPanelTimer();
  if(this.RenderExistsOnPage()) {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 ClearLoadingPanelTimer: function() {
  this.lpTimer = _aspxClearTimer(this.lpTimer);  
 },
 HideLoadingPanel: function() {
  this.ClearLoadingPanelTimer();
  this.hasPhantomLoadingElements = false;
  if(_aspxIsExistsElement(this.loadingPanelElement)) {
   _aspxRemoveElement(this.loadingPanelElement);
   this.loadingPanelElement = null;
  }
 },
 SetLoadingPanelLocation: function(offsetElement, loadingPanel, x, y, offsetX, offsetY) {
  if(!_aspxIsExists(x) || !_aspxIsExists(y)){
   var x1 = _aspxGetAbsoluteX(offsetElement);
   var y1 = _aspxGetAbsoluteY(offsetElement);
   var x2 = x1;
   var y2 = y1;
   if(offsetElement == document.body){
    x2 += _aspxGetDocumentMaxClientWidth();
    y2 += _aspxGetDocumentMaxClientHeight();
   }
   else{
    x2 += offsetElement.offsetWidth;
    y2 += offsetElement.offsetHeight;
   }
   if(x1 < _aspxGetDocumentScrollLeft())
    x1 = _aspxGetDocumentScrollLeft();
   if(y1 < _aspxGetDocumentScrollTop())
    y1 = _aspxGetDocumentScrollTop();
   if(x2 > _aspxGetDocumentScrollLeft() + _aspxGetDocumentClientWidth())
    x2 = _aspxGetDocumentScrollLeft() + _aspxGetDocumentClientWidth();
   if(y2 > _aspxGetDocumentScrollTop() + _aspxGetDocumentClientHeight())
    y2 = _aspxGetDocumentScrollTop() + _aspxGetDocumentClientHeight();
   x = x1 + ((x2 - x1 - loadingPanel.offsetWidth) / 2);
   y = y1 + ((y2 - y1 - loadingPanel.offsetHeight) / 2);
  }
  if(_aspxIsExists(offsetX) && _aspxIsExists(offsetY)){
   x += offsetX;
   y += offsetY;
  }
  x = _aspxPrepareClientPosForElement(x, loadingPanel, true);
  y = _aspxPrepareClientPosForElement(y, loadingPanel, false);
  if(__aspxIE && __aspxBrowserVersion == 9 && (y - Math.floor(y) === 0.5))
   y = Math.ceil(y);
  loadingPanel.style.left = x + "px";
  loadingPanel.style.top = y + "px";
 },
 GetLoadingDiv: function(){
  return _aspxGetElementById(this.name + "_LD");
 },
 CreateLoadingDiv: function(parentElement, offsetElement){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingDiv();
  if(parentElement == null) 
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var div = this.GetLoadingDiv();
  if(div != null){
   div = div.cloneNode(true);
   parentElement.appendChild(div);
   _aspxSetElementDisplay(div, true);
   _aspxAttachEventToElement(div, ASPxClientTouchUI.touchMouseDownEventName, _aspxPreventEvent);
   _aspxAttachEventToElement(div, ASPxClientTouchUI.touchMouseMoveEventName, _aspxPreventEvent);
   _aspxAttachEventToElement(div, ASPxClientTouchUI.touchMouseUpEventName, _aspxPreventEvent);
   this.SetLoadingDivBounds(offsetElement, div);
   this.loadingDivElement = div;
   this.SetInitialLoadingDivOpacity();
   return div;
  }
  return null;
 },
 SetInitialLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  _aspxSaveStyleAttribute(this.loadingDivElement, "opacity");
  _aspxSaveStyleAttribute(this.loadingDivElement, "filter");
  _aspxSetElementOpacity(this.loadingDivElement, 0.01);
 },
 RestoreLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  _aspxRestoreStyleAttribute(this.loadingDivElement, "opacity");
  _aspxRestoreStyleAttribute(this.loadingDivElement, "filter");
 },
 SetLoadingDivBounds: function(offsetElement, loadingDiv) {
  var absX = (offsetElement == document.body) ? 0 : _aspxGetAbsoluteX(offsetElement);
  var absY = (offsetElement == document.body) ? 0 : _aspxGetAbsoluteY(offsetElement);
  loadingDiv.style.left = _aspxPrepareClientPosForElement(absX, loadingDiv, true) + "px";
  loadingDiv.style.top = _aspxPrepareClientPosForElement(absY, loadingDiv, false) + "px";
  var width = (offsetElement == document.body) ? _aspxGetDocumentWidth() : offsetElement.offsetWidth;
  var height = (offsetElement == document.body) ? _aspxGetDocumentHeight() : offsetElement.offsetHeight;
  if(height < 0) 
   height = 0;
  _aspxSetStyleSize(loadingDiv, width, height); 
  var correctedWidth = 2 * width - loadingDiv.offsetWidth;
  if(correctedWidth <= 0) correctedWidth = width;
  var correctedHeight = 2 * height - loadingDiv.offsetHeight;
  if(correctedHeight <= 0) correctedHeight = height;
  _aspxSetStyleSize(loadingDiv, correctedWidth, correctedHeight);
 },
 ShowLoadingDiv: function() {
 },
 HideLoadingDiv: function() {
  this.hasPhantomLoadingElements = false;
  if(_aspxIsExistsElement(this.loadingDivElement)){
   _aspxRemoveElement(this.loadingDivElement);
   this.loadingDivElement = null;
  }
 },
 CanHandleGesture: function(evt) {
  return false;
 },
 CanHandleGestureCore: function(evt) {
  var source = _aspxGetEventSource(evt);
  if(_aspxGetIsParent(this.loadingPanelElement, source) || _aspxGetIsParent(this.loadingDivElement, source))
   return true; 
  var animationContainer = ASPxAnimationHelper.getSlideAnimationContainer(this.GetCallbackAnimationElement(), false, false);
  if(animationContainer && _aspxGetIsParent(animationContainer, source) && !_aspxGetIsParent(animationContainer.childNodes[0], source))
   return true; 
  return this.CanHandleGesture(evt); 
 },
 AllowStartGesture: function() {
  return !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing;
 },
 StartGesture: function() {
 },
 AllowExecuteGesture: function(value) {
  return false;
 },
 ExecuteGesture: function(value) {
 },
 CancelGesture: function(value) {
  if(this.repeatedGestureCount === 0) {
   this.repeatedGestureValue = value;
   this.repeatedGestureCount = 1;
  }
  else {
   if(this.repeatedGestureValue * value > 0)
    this.repeatedGestureCount++;
   else
    this.repeatedGestureCount--;
   if(this.repeatedGestureCount === 0)
    this.repeatedGestureCount = 0;
  }
 },
 CheckRepeatGesture: function() {
  if(this.repeatedGestureCount !== 0) {
   if(this.AllowExecuteGesture(this.repeatedGestureValue))
    this.ExecuteGesture(this.repeatedGestureValue, this.repeatedGestureCount);
   this.repeatedGestureValue = 0;
   this.repeatedGestureCount = 0;
  }
 },
 AllowExecutePagerGesture: function (pageIndex, pageCount, value) {
  if(pageIndex < 0) return false;
  if(pageCount <= 1) return false;
  if(value > 0 && pageIndex === 0) return false;
  if(value < 0 && pageIndex === pageCount - 1) return false;
  return true;
 },
 ExecutePagerGesture: function(pageIndex, pageCount, value, count, method) {
  if(!count) count = 1;
  var pageIndex = pageIndex + (value < 0 ? count : -count);
  if(pageIndex < 0) pageIndex = 0;
  if(pageIndex > pageCount - 1) pageIndex = pageCount - 1;
  method(ASPxClientPagerCommands.PageNumber + pageIndex);
 },
 RaiseInit: function(){
  if(!this.Init.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.Init.FireEvent(this, args);
  }
 },
 RaiseBeginCallbackInternal: function(command){
  if(!this.BeginCallback.IsEmpty()){
   var args = new ASPxClientBeginCallbackEventArgs(command);
   this.BeginCallback.FireEvent(this, args);
  }
 },
 RaiseBeginCallback: function(command){
  this.RaiseBeginCallbackInternal(command);
  if(typeof(aspxGetGlobalEvents) != "undefined")
   aspxGetGlobalEvents().OnBeginCallback(this, command);
 },
 RaiseEndCallback: function(){
  if(!this.EndCallback.IsEmpty()){
   var args = new ASPxClientEndCallbackEventArgs();
   this.EndCallback.FireEvent(this, args);
  }
  if(typeof(aspxGetGlobalEvents) != "undefined")
   aspxGetGlobalEvents().OnEndCallback(this);
 },
 RaiseEndCallbackAnimationStart: function(){
  if(!this.EndCallbackAnimationStart.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EndCallbackAnimationStart.FireEvent(this, args);
  }
 },
 RaiseCallbackError: function(message) {
  if(!this.CallbackError.IsEmpty()) {
   var args = new ASPxClientCallbackErrorEventArgs(message);
   this.CallbackError.FireEvent(this, args);
   if(args.handled)
    return { isHandled: true, errorMessage: args.message };
  }
  if(typeof(aspxGetGlobalEvents) != "undefined") {
   var args = new ASPxClientCallbackErrorEventArgs(message);
   aspxGetGlobalEvents().OnCallbackError(this, args);
   if(args.handled)
    return { isHandled: true, errorMessage: args.message };
  }
  return { isHandled: false, errorMessage: message };
 },
 IsVisible: function() {
  var element = this.GetMainElement();
  return _aspxElementIsVisible(element);
 },
 IsDisplayed: function() {
  var element = this.GetMainElement();
  while(element && element.tagName != "BODY") {
   if(!_aspxGetElementDisplay(element)) 
    return false;
   element = element.parentNode;
  }
  return true;
 },
 IsHidden: function() {
  var element = this.GetMainElement();
  return element.offsetWidth == 0 && element.offsetHeight == 0;
 },
 Focus: function() {
 },
 GetClientVisible: function(){
  return this.GetVisible();
 },
 SetClientVisible: function(visible){
  this.SetVisible(visible);
 },
 GetVisible: function(){
  return this.clientVisible;
 },
 SetVisible: function(visible){
  if(this.clientVisible != visible){
   this.clientVisible = visible;
   _aspxSetElementDisplay(this.GetMainElement(), visible);
   if (visible) {
    this.AdjustControl(__aspxCheckSizeCorrectedFlag);
    var mainElement = this.GetMainElement();
    if(mainElement)
     aspxGetControlCollection().AdjustControls(mainElement, __aspxCheckSizeCorrectedFlag);
   }
  }
 },
 GetEnabled: function() {
  return this.clientEnabled;
 },
 SetEnabled: function(enabled) {
  this.clientEnabled = enabled;
  if(ASPxClientControl.setEnabledLocked)
   return;
  else
   ASPxClientControl.setEnabledLocked = true;
  aspxGetControlCollection().ProcessControlsInContainer(this.GetMainElement(), function(control) {
   if(_aspxIsFunction(control.SetEnabled))
    control.SetEnabled(enabled);
  });
  delete ASPxClientControl.setEnabledLocked;
 },
 InCallback: function() {
  return this.requestCount > 0;
 },
 DoBeginCallback: function(command) {
  this.RaiseBeginCallback(command || "");
  aspxGetControlCollection().Before_WebForm_InitCallback();
  if(typeof(WebForm_InitCallback) != "undefined" && WebForm_InitCallback) {
   __theFormPostData = "";
   __theFormPostCollection = [ ];
   this.ClearPostBackEventInput("__EVENTTARGET");
   this.ClearPostBackEventInput("__EVENTARGUMENT");
   WebForm_InitCallback();
   this.savedFormPostData = __theFormPostData;   
   this.savedFormPostCollection = __theFormPostCollection;
  }
 },
 ClearPostBackEventInput: function(id){
  var element = _aspxGetElementById(id);
  if(element != null) element.value = "";
 },
 PerformDataCallback: function(arg, handler) {
  this.CreateCustomDataCallback(arg, "", handler);
 }, 
 CreateCallback: function(arg, command) {
  var callbackInfo = this.CreateCallbackInfo(ASPxCallbackType.Common, null);
  this.CreateCallbackByInfo(arg, command, callbackInfo);
 },
 CreateCustomDataCallback: function(arg, command, handler) {
  var callbackInfo = this.CreateCallbackInfo(ASPxCallbackType.Data, handler);
  this.CreateCallbackByInfo(arg, command, callbackInfo);
 },
 CreateCallbackByInfo: function(arg, command, callbackInfo) {
  if(!this.CanCreateCallback()) return;
  if(typeof(WebForm_DoCallback) != "undefined" && WebForm_DoCallback && __aspxDocumentLoaded)
   this.CreateCallbackInternal(arg, command, true, callbackInfo);
  else {
   if(!this.savedCallbacks)
    this.savedCallbacks = [];
   var callbackInfo = { arg: arg, command: command, callbackInfo: callbackInfo };
   if(this.allowMultipleCallbacks)
    this.savedCallbacks.push(callbackInfo);
   else
    this.savedCallbacks[0] = callbackInfo;
  }
 },
 CreateCallbackInternal: function(arg, command, viaTimer, callbackInfo) {
  this.requestCount++;
  this.DoBeginCallback(command);
  if(typeof(arg) == "undefined")
   arg = "";
  if(typeof(command) == "undefined")
   command = "";
  var callbackID = this.SaveCallbackInfo(callbackInfo);
  if(viaTimer)
   window.setTimeout("aspxCreateCallback('" + this.name + "', '" + escape(arg) + "', '" + escape(command) + "', " + callbackID + ");", 0);
  else
   this.CreateCallbackCore(arg, command, callbackID);
 },
 CreateCallbackCore: function(arg, command, callbackID) {
  var callBackMethod = this.GetCallbackMethod(command);
  __theFormPostData = this.savedFormPostData;
  __theFormPostCollection = this.savedFormPostCollection;
  callBackMethod.call(this, this.GetSerializedCallbackInfoByID(callbackID) + arg);
 },
 GetCallbackMethod: function(command){
  return this.callBack;
 },
 CanCreateCallback: function() {
  return !this.InCallback() || (this.allowMultipleCallbacks && !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing);
 },
 DoLoadCallbackScripts: function() {
  _aspxProcessScriptsAndLinks(this.name);
 },
 DoEndCallback: function() {
  if(this.IsCallbackAnimationEnabled() && this.CheckEndCallbackAnimationNeeded()) 
   return;
  this.requestCount--;
  if(this.HideLoadingPanelOnCallback() && this.requestCount < 1) 
   this.HideLoadingElements();
  if(this.enableSwipeGestures && this.supportGestures)
   ASPxGesturesHelper.UpdateSwipeAnimationContainer(this.name);
  this.isCallbackAnimationPrevented = false;
  this.OnCallbackFinalized();
  this.RaiseEndCallback();
 },
 DoFinalizeCallback: function() {
 },
 OnCallbackFinalized: function() {
 },
 HideLoadingPanelOnCallback: function() {
  return true;
 },
 ShouldHideExistingLoadingElements: function() {
  return true;
 },
 EvalCallbackResult: function(resultString){
  return eval(resultString)
 },
 DoCallback: function(result) {
  if(this.IsCallbackAnimationEnabled() && this.CheckBeginCallbackAnimationInProgress(result))
   return;
  result = _aspxTrim(result);
  if(result.indexOf(__aspxCallbackResultPrefix) != 0) 
   this.ProcessCallbackGeneralError(result);
  else {
   var resultObj = null;
   try {
    resultObj = this.EvalCallbackResult(result);
   } 
   catch(e) {
   }
   if(resultObj) {
    if(resultObj.redirect){
     if(!__aspxIE)
      window.location.href = resultObj.redirect;
     else { 
      var fakeLink = document.createElement("a");
      fakeLink.href = resultObj.redirect;
      document.body.appendChild(fakeLink); 
      fakeLink.click();
     }
    }
    else if(resultObj.generalError){
     this.ProcessCallbackGeneralError(resultObj.generalError);
    }
    else {
     var errorObj = resultObj.error;
     if(errorObj)
      this.ProcessCallbackError(errorObj);
     else {
      if(resultObj.cp) {
       for(var name in resultObj.cp)
        this[name] = resultObj.cp[name];
      }
      var callbackInfo = this.DequeueCallbackInfo(resultObj.id);
      if(callbackInfo.type == ASPxCallbackType.Data) 
       this.ProcessCustomDataCallback(resultObj.result, callbackInfo);
      else 
       this.ProcessCallback(resultObj.result);
     }
    }
   } 
  }
  this.DoLoadCallbackScripts();
 },
 DoCallbackError: function(result) {
  this.HideLoadingElements();
  this.ProcessCallbackGeneralError(result); 
 },
 DoControlClick: function(evt) {
  this.OnControlClick(_aspxGetEventSource(evt), evt);
 },
 ProcessCallback: function(result) {
  this.OnCallback(result);
 },
 ProcessCustomDataCallback: function(result, callbackInfo) {
  if(callbackInfo.handler != null)
   callbackInfo.handler(this, result);
  this.RaiseCustomDataCallback(result);
 },
 RaiseCustomDataCallback: function(result) {
  if(!this.CustomDataCallback.IsEmpty()) {
   var arg = new ASPxClientCustomDataCallbackEventArgs(result);
   this.CustomDataCallback.FireEvent(this, arg);
  }
 },
 OnCallback: function(result) {
 },
 CreateCallbackInfo: function(type, handler) {
  return { type: type, handler: handler };
 },
 GetSerializedCallbackInfoByID: function(callbackID) {
  return this.GetCallbackInfoByID(callbackID).type + callbackID + __aspxCallbackSeparator;
 },
 SaveCallbackInfo: function(callbackInfo) {
  var activeCallbacksInfo = this.GetActiveCallbacksInfo();
  for(var i = 0; i < activeCallbacksInfo.length; i++) {
   if(activeCallbacksInfo[i] == null) {
    activeCallbacksInfo[i] = callbackInfo;
    return i;
   }
  }
  activeCallbacksInfo.push(callbackInfo);
  return activeCallbacksInfo.length - 1;
 },
 GetActiveCallbacksInfo: function() {
  var persistentProperties = this.GetPersistentProperties();
  if(!persistentProperties.activeCallbacks)
   persistentProperties.activeCallbacks = [ ];
  return persistentProperties.activeCallbacks;
 },
 GetPersistentProperties: function() {
  var storage = _aspxGetPersistentControlPropertiesStorage();
  var persistentProperties = storage[this.name];
  if(!persistentProperties) {
   persistentProperties = { };
   storage[this.name] = persistentProperties;
  }
  return persistentProperties;
 },
 GetCallbackInfoByID: function(callbackID) {
  return this.GetActiveCallbacksInfo()[callbackID];
 },
 DequeueCallbackInfo: function(index) {
  var activeCallbacksInfo = this.GetActiveCallbacksInfo();
  if(index < 0 || index >= activeCallbacksInfo.length)
   return null;
  var result = activeCallbacksInfo[index];
  activeCallbacksInfo[index] = null;
  return result;
 },
 ProcessCallbackError: function(errorObj) {
  var data = _aspxIsExists(errorObj.data) ? errorObj.data : null;
  var result = this.RaiseCallbackError(errorObj.message);
  if(!result.isHandled)
   this.OnCallbackError(result.errorMessage, data);
 },
 OnCallbackError: function(errorMessage, data) {
  if(errorMessage)
   alert(errorMessage);
 },
 ProcessCallbackGeneralError: function(errorMessage) {
  var result = this.RaiseCallbackError(errorMessage);
  if(!result.isHandled)
   this.OnCallbackGeneralError(result.errorMessage);
 },
 OnCallbackGeneralError: function(errorMessage) {
  this.OnCallbackError(errorMessage, null);
 },
 SendPostBack: function(params) {
  __doPostBack(this.uniqueID, params);
 }
});
ASPxClientControl.AdjustControls = function(container){
 aspxGetControlCollection().AdjustControls(container);
};
ASPxClientControl.Cast = function(obj) {
 if(typeof obj == "string")
  return window[obj];
 return obj;
};
ASPxClientControl.GetControlCollection = function(){
 return aspxGetControlCollection();
}
var __aspxControlCollection = null;
function aspxGetControlCollection(){
 if(__aspxControlCollection == null)
  __aspxControlCollection = new ASPxClientControlCollection();
 return __aspxControlCollection;
}
var __aspxPersistentControlPropertiesStorage = null;
function _aspxGetPersistentControlPropertiesStorage() {
 if(__aspxPersistentControlPropertiesStorage == null)
  __aspxPersistentControlPropertiesStorage = { };
 return __aspxPersistentControlPropertiesStorage;
}
function _aspxFunctionIsInCallstack(currentCallee, targetFunction, depthLimit) {
 var candidate = currentCallee;
 var depth = 0;
 while(candidate && depth <= depthLimit) {
  candidate = candidate.caller;
  if(candidate == targetFunction)
   return true;
  depth++;
 }
 return false;
}
function aspxCAInit() {
 var isAppInit = typeof(Sys$_Application$_doInitialize) != "undefined" &&
  _aspxFunctionIsInCallstack(arguments.callee, Sys$_Application$_doInitialize, 10 );
 aspxGetControlCollection().AtlasInitialize(!isAppInit);
}
function aspxCreateCallback(name, arg, command, callbackID){
 var control = aspxGetControlCollection().Get(name);
 if(control != null)
  control.CreateCallbackCore(unescape(arg), unescape(command), callbackID);
}
function aspxCallback(result, context){
 var collection = aspxGetControlCollection();
 collection.DoFinalizeCallback();
 var control = collection.Get(context);
 if(control != null)
  control.DoCallback(result);
}
function aspxCallbackError(result, context){
 var control = aspxGetControlCollection().Get(context);
 if(control != null)
  control.DoCallbackError(result, false);
}
function aspxCClick(name, evt) {
 var control = aspxGetControlCollection().Get(name);
 if(control != null) control.DoControlClick(evt);
}
_aspxAttachEventToElement(window, "resize", aspxGlobalWindowResize);
function aspxGlobalWindowResize(evt){
 aspxGetControlCollection().OnBrowserWindowResize(evt); 
}
_aspxAttachEventToElement(window, "load", aspxClassesWindowOnLoad);
function aspxClassesWindowOnLoad(evt){
 __aspxDocumentLoaded = true;
 ASPxResourceManager.SynchronizeResources();
 aspxGetControlCollection().Initialize();
 _aspxInitializeScripts();
 _aspxInitializeLinks();
 _aspxInitializeFocus();
}
ASPxIdent = { };
ASPxIdent.IsDate = function(obj) {
 return obj && obj.constructor == Date;
};
ASPxIdent.IsRegExp = function(obj) {
 return obj && obj.constructor === RegExp;
};
ASPxIdent.IsArray = function(obj) {
 return obj && obj.constructor == Array;
};
ASPxIdent.IsASPxClientControl = function(obj) {
 return obj && obj.isASPxClientControl;
};
ASPxIdent.IsASPxClientEdit = function(obj) {
 return obj && obj.isASPxClientEdit;
};
ASPxIdent.IsASPxClientRadioButtonList = function(obj) {
 return obj && obj.isASPxClientRadioButtonList;
};
ASPxClientPagerCommands = {
 Next : "PBN",
 Prev : "PBP",
 Last : "PBL",
 First : "PBF",
 PageNumber : "PN",
 PageSize : "PSP"
};
if(_aspxIsFunction(window.WebForm_InitCallbackAddField)) {
 (function() {
  var original = window.WebForm_InitCallbackAddField;
  window.WebForm_InitCallbackAddField = function(name, value) {
   if(typeof(name) == "string" && name)
    original.apply(null, arguments);
  };
 })();
}
function aspxFireDefaultButton(evt, buttonID) {
 if(_aspxIsDefaultButtonEvent(evt, buttonID)) {
  var defaultButton = _aspxGetElementById(buttonID);
  if(defaultButton && defaultButton.click) {
   if(_aspxIsFocusable(defaultButton))
    defaultButton.focus();
   _aspxDoElementClick(defaultButton);
   _aspxPreventEventAndBubble(evt);
   return false;
  }
 }
 return true;
}
function _aspxIsDefaultButtonEvent(evt, defaultButtonID) {
 if(evt.keyCode != ASPxKey.Enter)
  return false;
 var srcElement = _aspxGetEventSource(evt);
 if(!srcElement || srcElement.id === defaultButtonID)
  return true;
 var tagName = srcElement.tagName;
 var type = srcElement.type;
 return tagName != "TEXTAREA" && tagName != "BUTTON" && tagName != "A" &&
  (tagName != "INPUT" || type != "checkbox" && type != "radio" && type != "button" && type != "submit" && type != "reset");
}
ASPxPostHandler = _aspxCreateClass(null, {
 constructor: function() {
  this.Post = new ASPxClientEvent();
  this.PostFinalization = new ASPxClientEvent();
  this.observableForms = [];
  this.ReplaceGlobalPostFunctions();
  this.HandleDxCallbackBeginning();
  this.HandleMSAjaxRequestBeginning();
 },
 Update: function() {
  this.ReplaceFormsSubmit(true);
 },
 OnPost: function() {
  this.Post.FireEvent(this, ASPxClientEventArgs.Empty);
  this.PostFinalization.FireEvent(this, ASPxClientEventArgs.Empty);
 },
 ReplaceGlobalPostFunctions: function() {
  if(_aspxIsFunction(window.__doPostBack))
   this.ReplaceDoPostBack();
  if(_aspxIsFunction(window.WebForm_DoCallback))
   this.ReplaceDoCallback();
  this.ReplaceFormsSubmit();
 },
 HandleDxCallbackBeginning: function() {
  aspxGetControlCollection().BeforeInitCallback.AddHandler(function() {
   _aspxRaisePostHandlerOnPost(false, true);
  });
 },
 HandleMSAjaxRequestBeginning: function() {
  if(window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager && Sys.WebForms.PageRequestManager.getInstance) {
   var pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
   if(pageRequestManager != null && ASPxIdent.IsArray(pageRequestManager._onSubmitStatements)) {
    pageRequestManager._onSubmitStatements.unshift(function() {
     _aspxRaisePostHandlerOnPost(true); return true;
    });
   }
  }
 },
 ReplaceDoPostBack: function() {
  var original = __doPostBack;
  __doPostBack = function(eventTarget, eventArgument) {
   _aspxRaisePostHandlerOnPost();
   original(eventTarget, eventArgument);
  };
 },
 ReplaceDoCallback: function() {
  var original = WebForm_DoCallback;
  WebForm_DoCallback = function(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync) {
   var postHandler = aspxGetPostHandler();
   if(postHandler.dxCallbackHandled)
    delete postHandler.dxCallbackHandled;
   else
    _aspxRaisePostHandlerOnPost();
   return original(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync);
  };
 },
 ReplaceFormsSubmit: function(checkObservableCollection) {
  for(var i = 0; i < document.forms.length; i++) { 
   var form = document.forms[i];
   if(checkObservableCollection && _aspxArrayIndexOf(this.observableForms, form) >= 0)
    continue;
   if(form.submit)
    this.ReplaceFormSubmit(form);
   this.ReplaceFormOnSumbit(form);
   this.observableForms.push(form);
  }
 },
 ReplaceFormSubmit: function(form) {
  var originalSubmit = form.submit;
  form.submit = function() {
   _aspxRaisePostHandlerOnPost();
   var callee = arguments.callee;
   this.submit = originalSubmit;
   var submitResult = this.submit();
   this.submit = callee;
   return submitResult;
  };
  form = null;
 },
 ReplaceFormOnSumbit: function(form) {
  var originalSubmit = form.onsubmit;
  form.onsubmit = function() {
   var postHandler = aspxGetPostHandler();
   if(postHandler.msAjaxRequestBeginningHandled)
    delete postHandler.msAjaxRequestBeginningHandled;
   else
    _aspxRaisePostHandlerOnPost();
   return _aspxIsFunction(originalSubmit)
    ? originalSubmit.apply(this, arguments)
    : true;
  };
  form = null;
 }
});
function _aspxRaisePostHandlerOnPost(isMSAjaxRequestBeginning, isDXCallbackBeginning) {
 var postHandler = aspxGetPostHandler();
 if(postHandler) {
  if(isMSAjaxRequestBeginning)
   postHandler.msAjaxRequestBeginningHandled = true;
  else if(isDXCallbackBeginning)
   postHandler.dxCallbackHandled = true;
  postHandler.OnPost();
 }
}
function aspxGetPostHandler() {
 if (!window.__aspxPostHandler)
  window.__aspxPostHandler = new ASPxPostHandler();
 return window.__aspxPostHandler;
}
ASPxResourceManager = {
 HandlerStr: "DXR.axd?r=",
 ResourceHashes: {},
 SynchronizeResources: function(){
  this.SynchronizeResourcesElements(_aspxGetIncludeScripts(), "src", "DXScript");
 },
 SynchronizeResourcesElements: function(elements, urlAttr, id){
  var s = this.GetResourcesElementsString(elements, urlAttr, id);
  this.UpdateInputElements(id, s);
 },
 GetResourcesElementsString: function(elements, urlAttr, id){
  if(!this.ResourceHashes[id]) 
   this.ResourceHashes[id] = {};
  var hash = this.ResourceHashes[id];
  for(var i = 0; i < elements.length; i++) {
   var resourceUrl = _aspxGetAttribute(elements[i], urlAttr);
   if(resourceUrl) {
    var pos = resourceUrl.indexOf(this.HandlerStr);
    if(pos > -1){
     var list = resourceUrl.substr(pos + this.HandlerStr.length);
     var ampPos = list.lastIndexOf("-");
     if(ampPos > -1)
      list = list.substr(0, ampPos);
     var indexes = list.split(",");
     for(var j = 0; j < indexes.length; j++)
      hash[indexes[j]] = indexes[j];
    }
    else
     hash[resourceUrl] = resourceUrl;
   }
  }
  var array = [];
  for(var key in hash) 
   array.push(key);
  return array.join(",");
 },
 UpdateInputElements: function(typeName, list){
  for(var i = 0; i < document.forms.length; i++){
   var inputElement = document.forms[i][typeName];
   if(!inputElement)
    inputElement = this.CreateInputElement(document.forms[i], typeName);
   inputElement.value = list;
  }
 },
 CreateInputElement: function(form, typeName){
  var inputElement = _aspxCreateHiddenField(typeName, typeName);
  form.appendChild(inputElement);
  return inputElement;
 }
};
var __aspxIncludeScriptPrefix = "dxis_";
var __aspxStartupScriptPrefix = "dxss_";
var __aspxIncludeScriptsCache = {};
var __aspxCreatedIncludeScripts = [];
var __aspxAppendedScriptsCount = 0;
var __aspxCallbackOwnerNames = [];
var __aspxScriptsRestartHandlers = { };
function _aspxGetScriptCode(script) {
 var useFirstChildElement = __aspxChrome && __aspxBrowserVersion < 11 
  || __aspxSafari && __aspxBrowserVersion < 5; 
 var text = useFirstChildElement ? script.firstChild.data : script.text;
 var comment = "<!--";
 var pos = text.indexOf(comment);
 if(pos > -1)
  text = text.substr(pos + comment.length);
 return text;
}
function _aspxAppendScript(script) {
 var parent = document.getElementsByTagName("head")[0];
 if(!parent)
  parent = document.body;
 if(parent)
  parent.appendChild(script);
}
function _aspxIsAlphaFilterUsed(img){
 return (__aspxIE && __aspxBrowserVersion < 9 && img.style.filter.indexOf("progid:DXImageTransform.Microsoft.AlphaImageLoader") > -1);
}
function _aspxIsKnownIncludeScript(script) {
 return !!__aspxIncludeScriptsCache[script.src];
}
function _aspxCacheIncludeScript(script) {
 __aspxIncludeScriptsCache[script.src] = 1;
}
function _aspxProcessScriptsAndLinks(ownerName, isCallback) {
 if(!__aspxDocumentLoaded) return; 
 _aspxProcessScripts(ownerName, isCallback);
 _aspxSweepDuplicatedLinks();
 _aspxMoveLinkElements();
 __aspxCachedRules = { };
}
function _aspxGetStartupScripts() {
 return _aspxGetScriptsCore(__aspxStartupScriptPrefix);
}
function _aspxGetIncludeScripts() {
 return _aspxGetScriptsCore(__aspxIncludeScriptPrefix);
}
function _aspxGetScriptsCore(prefix) {
 var result = [];
 var scripts = document.getElementsByTagName("SCRIPT");
 for(var i = 0; i < scripts.length; i++) {
  if (scripts[i].id.indexOf(prefix) == 0)
   result.push(scripts[i]);
 }
 return result;
}
function _aspxGetLinks() {
 var result = [];
 var links = document.getElementsByTagName("LINK");;
 for(var i = 0; i < links.length; i++) 
  result[i] = links[i];
 return result;
}
function _aspxIsLinksLoaded() {
 var links = _aspxGetLinks();
 for(var i = 0, link; link = links[i]; i++) {
  if(link.readyState && link.readyState.toLowerCase() == "loading")
    return false;
  }
 return true;
}
function _aspxInitializeLinks() {
 var links = _aspxGetLinks();
 for(var i = 0; i < links.length; i++)
  links[i].loaded = true; 
}
function _aspxInitializeScripts() {
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++)
  _aspxCacheIncludeScript(scripts[i]);   
 var startupScripts = _aspxGetStartupScripts();
 for(var i = 0; i < startupScripts.length; i++)
  startupScripts[i].executed = true; 
}
function _aspxSweepDuplicatedLinks() {
 if((__aspxIE && __aspxBrowserVersion < 7) || __aspxOpera)
  return;
 var hash = { };
 var links = _aspxGetLinks();
 for(var i = 0; i < links.length; i++) {
  var href = links[i].href;
  if(!href)
   continue;
  if(hash[href]){
   if(!hash[href].loaded && links[i].loaded){
    _aspxRemoveElement(hash[href]);
    hash[href] = links[i];
   }
   else
    _aspxRemoveElement(links[i]);
  }
  else
   hash[href] = links[i];
 }
}
function _aspxSweepDuplicatedScripts() {
 var hash = { };
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++) {
  var src = scripts[i].src;
  if(!src) continue;
  if(hash[src])
   _aspxRemoveElement(scripts[i]);
  else
   hash[src] = scripts[i];
 }
}
function _aspxProcessScripts(ownerName, isCallback) {
 var scripts = _aspxGetIncludeScripts();
 var previousCreatedScript = null;
 var firstCreatedScript = null;
 for(var i = 0; i < scripts.length; i++) {
  var script = scripts[i];
  if(script.src == "") continue; 
  if(_aspxIsKnownIncludeScript(script))
   continue;
  var createdScript = document.createElement("script");
  createdScript.type = "text/javascript";
  createdScript.src = script.src;
  createdScript.id = script.id;
  function AreScriptsEqual(script1, script2) {
   return script1.src == script2.src;
  }
  if(_aspxArrayIndexOf(__aspxCreatedIncludeScripts, createdScript, AreScriptsEqual) >= 0)
   continue;
  __aspxCreatedIncludeScripts.push(createdScript);
  _aspxRemoveElement(script);
  if(__aspxIE && __aspxBrowserVersion < 9) {
   createdScript.onreadystatechange = new Function("_aspxOnScriptReadyStateChangedCallback(this, \"" + ownerName + "\");");
  } else if(__aspxWebKitFamily || (__aspxFirefox && __aspxBrowserVersion >= 4) || __aspxIE && __aspxBrowserVersion >= 9) {
   createdScript.onload = new Function("_aspxOnScriptLoadCallback(this, \"" + ownerName + "\");");
   if(firstCreatedScript == null)
    firstCreatedScript = createdScript;
   createdScript.nextCreatedScript = null;
   if(previousCreatedScript != null)
    previousCreatedScript.nextCreatedScript = createdScript;
   previousCreatedScript = createdScript;
  } else {
   createdScript.onload = new Function("_aspxOnScriptLoadCallback(this, \"" + ownerName + "\");");
   _aspxAppendScript(createdScript);
   _aspxCacheIncludeScript(createdScript);
  }
 }
 if(firstCreatedScript != null) {
  _aspxAppendScript(firstCreatedScript);
  _aspxCacheIncludeScript(firstCreatedScript);
 }
 __aspxCallbackOwnerNames.push(ownerName);
 if(__aspxCreatedIncludeScripts.length == 0)
  _aspxFinalizeScriptProcessing(ownerName, isCallback);
}
function _aspxFinalizeScriptProcessing(ownerName, isCallback) {
 __aspxCreatedIncludeScripts = [];
 __aspxAppendedScriptsCount = 0;
 _aspxSweepDuplicatedScripts();
 _aspxRunStartupScripts(isCallback);
 ASPxResourceManager.SynchronizeResources();
 while(__aspxCallbackOwnerNames.length > 0) {
  var callbackOwnerName = __aspxCallbackOwnerNames.pop();
  var callbackOwner = aspxGetControlCollection().Get(callbackOwnerName);
  if(callbackOwner)
   callbackOwner.DoEndCallback();
 }
}
function _aspxRunStartupScripts(isCallback) {
 var scripts = _aspxGetStartupScripts();
 var code;
 for(var i = 0; i < scripts.length; i++){
  if(!scripts[i].executed) {
   code = _aspxGetScriptCode(scripts[i]);
   eval(code);
   scripts[i].executed = true;
  }
 }
 if(__aspxDocumentLoaded) 
  aspxGetControlCollection().InitializeElements(isCallback);
 for(var key in __aspxScriptsRestartHandlers)
  __aspxScriptsRestartHandlers[key]();
}
function _aspxOnScriptReadyStateChangedCallback(scriptElement, ownerName) {
 if(scriptElement.readyState == "loaded") {
  _aspxCacheIncludeScript(scriptElement);
  for(var i = 0; i < __aspxCreatedIncludeScripts.length; i++) {
   var script = __aspxCreatedIncludeScripts[i];
   if(_aspxIsKnownIncludeScript(script)) {
    if(!script.executed) {
     script.executed = true;
     _aspxAppendScript(script);
     __aspxAppendedScriptsCount++;
    }
   } else
    break;
  }
  if(__aspxCreatedIncludeScripts.length == __aspxAppendedScriptsCount)
   _aspxFinalizeScriptProcessing(ownerName);
 }
}
function _aspxOnScriptLoadCallback(scriptElement, ownerName) {
 __aspxAppendedScriptsCount++;
 if(scriptElement.nextCreatedScript) {
  _aspxAppendScript(scriptElement.nextCreatedScript);
  _aspxCacheIncludeScript(scriptElement.nextCreatedScript);
 }
 if(__aspxCreatedIncludeScripts.length == __aspxAppendedScriptsCount)
  _aspxFinalizeScriptProcessing(ownerName);
}
function _aspxAddScriptsRestartHandler(objectName, handler) {
 __aspxScriptsRestartHandlers[objectName] = handler;
}
function _aspxMoveLinkElements() {
 if(__aspxIE)
  return;
 var head = _aspxGetElementsByTagName(document, "head")[0];
 var bodyLinks = _aspxGetElementsByTagName(document.body, "link");
 while(bodyLinks.length > 0) 
  head.appendChild(bodyLinks[0]);
}
ASPxIFrame = _aspxCreateClass(null, {
 constructor: function(params) {
  this.params = params || {};
  this.params.src = this.params.src || "";
  this.CreateElements();
 },
 CreateElements: function() {
  var elements = ASPxIFrame.Create(this.params);
  this.containerElement = elements.container;
  this.iframeElement = elements.iframe;
  this.AttachOnLoadHandler(this, this.iframeElement);
  this.SetLoading(true);
  if(this.params.onCreate)
   this.params.onCreate(this.containerElement, this.iframeElement);
 },
 AttachOnLoadHandler: function(instance, element) {
  _aspxAttachEventToElement(element, "load", function() {
   instance.OnLoad(element);
  });
 },
 OnLoad: function(element) {
  this.SetLoading(false, element);
  if(!element.preventCustomOnLoad && this.params.onLoad)
   this.params.onLoad();
 },
 IsLoading: function(element) {
  element = element || this.iframeElement;
  if(element)
   return element.loading;
  return false;
 },
 SetLoading: function(value, element) {
  element = element || this.iframeElement;
  if(element)
   element.loading = value;
 },
 GetContentUrl: function() {
  return this.params.src;
 },
 SetContentUrl: function(url, preventBrowserCaching) {
  if(url) {
   this.params.src = url;
   if(preventBrowserCaching)
    url = ASPxIFrame.AddRandomParamToUrl(url);
   this.SetLoading(true);
   this.iframeElement.src = url;
  }
 },
 RefreshContentUrl: function() {
  if(this.IsLoading())
   return;
  this.SetLoading(true);
  var oldContainerElement = this.containerElement;
  var oldIframeElement = this.iframeElement;
  var postfix = "_del" + Math.floor(Math.random()*100000).toString();
  if(this.params.id)
   oldIframeElement.id = this.params.id + postfix;
  if(this.params.name)
   oldIframeElement.name = this.params.name + postfix;
  oldContainerElement.style.height = "0px";
  this.CreateElements();
  oldIframeElement.preventCustomOnLoad = true;
  oldIframeElement.src = ASPx.BlankUrl;
  window.setTimeout(function() {
   oldContainerElement.parentNode.removeChild(oldContainerElement);
  }, 10000); 
 }
});
ASPxIFrame.Create = function(params) {
 var iframeHtmlStringParts = [ "<iframe frameborder='0'" ];
 if(params) {
  if(params.id)
   iframeHtmlStringParts.push(" id='", params.id, "'");
  if(params.name)
   iframeHtmlStringParts.push(" name='", params.name, "'");
  if(params.title)
   iframeHtmlStringParts.push(" title='", params.title, "'");
  if(params.scrolling)
   iframeHtmlStringParts.push(" scrolling='", params.scrolling, "'");
  if(params.src)
   iframeHtmlStringParts.push(" src='", params.src, "'");
 }
 iframeHtmlStringParts.push("></iframe>");
 var containerElement = _aspxCreateHtmlElementFromString("<div style='border-width: 0px; padding: 0px; margin: 0px'></div>");
 var iframeElement = _aspxCreateHtmlElementFromString(iframeHtmlStringParts.join(""));
 containerElement.appendChild(iframeElement);
 return {
  container: containerElement,
  iframe: iframeElement
 };
};
ASPxIFrame.AddRandomParamToUrl = function(url) {
 var prefix = url.indexOf("?") > -1
  ? "&"
  : "?";
 var param = prefix + Math.floor(Math.random()*100000).toString();
 var anchorIndex = url.indexOf("#");
 return anchorIndex == -1
  ? url + param
  : url.substr(0, anchorIndex) + param + url.substr(anchorIndex);
};
ASPxIFrame.GetWindow = function(name) {
 if(__aspxIE)
  return window.frames[name].window;
 else{
  var frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentWindow : null;
 }
};
ASPxIFrame.GetDocument = function(name) {
 if(__aspxIE)
  return window.frames[name].document;
 else{
  var frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentDocument : null;
 }
};
ASPxIFrame.GetDocumentBody = function(name) {
 var doc = ASPxIFrame.GetDocument(name);
 return (doc != null) ? doc.body : null;
};
ASPxIFrame.GetElement = function(name) {
 if(__aspxIE)
  return window.frames[name].window.frameElement;
 else
  return document.getElementById(name);
};
ASPxKbdHelper = _aspxCreateClass(null, {
 constructor: function(control) {
  this.control = control;
 },
 Init: function() {
  ASPxKbdHelper.GlobalInit();
  var element = this.GetFocusableElement();
  element.tabIndex = Math.max(element.tabIndex, 0);
  var instance = this;
  _aspxAttachEventToElement(element, "click", function(e) {
   instance.HandleClick(e);
  });  
  _aspxAttachEventToElement(element, "focus", function(e) {    
   if(!instance.CanFocus(e))
    return true;
   ASPxKbdHelper.active = instance;
  });
  _aspxAttachEventToElement(element, "blur", function() {
   delete ASPxKbdHelper.active;
  });    
 },
 GetFocusableElement: function() { return this.control.GetMainElement(); },
 CanFocus: function(e) {
  var tag = _aspxGetEventSource(e).tagName;
  if(tag == "A" || tag == "TEXTAREA" || tag == "INPUT" || tag == "SELECT")
   return false; 
  return true;
 },
 HandleClick: function(e) {
  if(!this.CanFocus(e))
   return;
  this.Focus();
 },
 Focus: function() {
  try {
   this.GetFocusableElement().focus();   
  } catch(e) {
  }
 },
 HandleKeyDown: function(e) { }, 
 HandleKeyPress: function(e) { }, 
 HandleKeyUp: function(e) { }
});
ASPxKbdHelper.GlobalInit = function() {
 if(ASPxKbdHelper.ready)
  return;
 _aspxAttachEventToDocument("keydown", ASPxKbdHelper.OnKeyDown);
 _aspxAttachEventToDocument("keypress", ASPxKbdHelper.OnKeyPress);
 _aspxAttachEventToDocument("keyup", ASPxKbdHelper.OnKeyUp);
 ASPxKbdHelper.ready = true; 
};
ASPxKbdHelper.swallowKey = false;
ASPxKbdHelper.accessKeys = { };
ASPxKbdHelper.ProcessKey = function(e, actionName) {
 if(!ASPxKbdHelper.active) 
  return;
 var ctl = ASPxKbdHelper.active.control;
 if(ctl !== aspxGetControlCollection().Get(ctl.name)) {
  delete ASPxKbdHelper.active;
  return;
 }
 if(!ASPxKbdHelper.swallowKey) 
  ASPxKbdHelper.swallowKey = ASPxKbdHelper.active[actionName](e);
 if(ASPxKbdHelper.swallowKey)
  _aspxPreventEvent(e);
};
ASPxKbdHelper.OnKeyDown = function(e) {
 ASPxKbdHelper.swallowKey = false; 
 if(e.ctrlKey && e.shiftKey && ASPxKbdHelper.TryAccessKey(_aspxGetKeyCode(e)))
  _aspxPreventEvent(e);  
 else 
  ASPxKbdHelper.ProcessKey(e, "HandleKeyDown"); 
};
ASPxKbdHelper.OnKeyPress = function(e) { ASPxKbdHelper.ProcessKey(e, "HandleKeyPress"); };
ASPxKbdHelper.OnKeyUp = function(e) { ASPxKbdHelper.ProcessKey(e, "HandleKeyUp"); };
ASPxKbdHelper.RegisterAccessKey = function(obj) {
 var key = obj.accessKey;
 if(!key) return;
 ASPxKbdHelper.accessKeys[key.toLowerCase()] = obj.name;
};
ASPxKbdHelper.TryAccessKey = function(code) {
 var name = ASPxKbdHelper.accessKeys[String.fromCharCode(code).toLowerCase()];
 if(!name) return false;
 var obj = aspxGetControlCollection().Get(name);
 if(!obj) return false;
 var el = obj.GetMainElement();
 if(!el) return false;
 el.focus();
 return true;
};
var __aspxFocusedElement = null;
function aspxOnElementFocused(evt) {
 evt = _aspxGetEvent(evt);
 if(evt && evt.target)
  __aspxFocusedElement = evt.target;
}
function _aspxInitializeFocus() {
 if(!_aspxGetActiveElement())
  _aspxAttachEventToDocument("focus", aspxOnElementFocused);
}
function _aspxGetFocusedElement() {
 var activeElement = _aspxGetActiveElement();
 return activeElement ? activeElement : __aspxFocusedElement;
}
function _aspxChangeElementContainer(element, container, savePreviousContainer) {
 if(element.parentNode != container) {
  var parentNode = element.parentNode;
  parentNode.removeChild(element);
  container.appendChild(element);
  if(savePreviousContainer)
   element.previousContainer = parentNode;
 }
}
function _aspxRestoreElementContainer(element) {
 if(element.previousContainer) {
  _aspxChangeElementContainer(element, element.previousContainer, false);
  element.previousContainer = null;
 }
}
var ASPxCacheHelper = {};
ASPxCacheHelper.GetCachedValue = function(obj, cacheName, func, cacheObj) {
 if(!cacheObj)
  cacheObj = obj;
 if(!cacheObj.cache)
  cacheObj.cache = {};
 if(!_aspxIsExists(cacheObj.cache[cacheName]))
  cacheObj.cache[cacheName] = func.apply(obj, []);
 return cacheObj.cache[cacheName];
};
ASPxCacheHelper.DropCachedValue = function(cacheObj, cacheName) {
 cacheObj.cache[cacheName] = null;
};  
ASPxClientTemporaryCache = _aspxCreateClass(null, {
 constructor: function() { 
  this.cache = { };
  this.invalidateTimerID = -1;
 },
 Get: function(key, getObjectFunc, context, args) {
  if(this.invalidateTimerID < 0) {
   this.invalidateTimerID = window.setTimeout(function() {
    this.Invalidate();
   }.aspxBind(this), 0);
  }
  if(!_aspxIsExists(this.cache[key])) {
   if(!_aspxIsExists(args))
    args = [ ];
   this.cache[key] = getObjectFunc.apply(context, args);
  }
  return this.cache[key];
 },
 Invalidate: function() {
  this.cache = { };
  this.invalidateTimerID = _aspxClearTimer(this.invalidateTimerID);
 }
});
ASPxClientCheckBoxCheckState = {
 Checked : "Checked",
 Unchecked : "Unchecked",
 Indeterminate : "Indeterminate"
};
ASPxClientCheckBoxInputKey = { 
 Checked : "C",
 Unchecked : "U",
 Indeterminate : "I"
};
ASPxCheckableElementStateController = _aspxCreateClass(null, {
 constructor: function(imageProperties) {
  this.checkBoxStates = [];
  this.imageProperties = imageProperties;
 },
 GetValueByInputKey: function(inputKey) {
  return this.GetFirstValueBySecondValue("Value", "StateInputKey", inputKey);
 },
 GetInputKeyByValue: function(value) {
  return this.GetFirstValueBySecondValue("StateInputKey", "Value", value);
 },
 GetImagePropertiesNumByInputKey: function(value) {
  return this.GetFirstValueBySecondValue("ImagePropertiesNumber", "StateInputKey", value);
 },
 GetNextCheckBoxValue: function(currentValue, allowGrayed) {
  var currentInputKey = this.GetInputKeyByValue(currentValue);
  var nextInputKey = '';
  switch(currentInputKey) {
   case ASPxClientCheckBoxInputKey.Checked:
    nextInputKey = ASPxClientCheckBoxInputKey.Unchecked; break;
   case ASPxClientCheckBoxInputKey.Unchecked:
    nextInputKey = allowGrayed ? ASPxClientCheckBoxInputKey.Indeterminate : ASPxClientCheckBoxInputKey.Checked; break;
   case ASPxClientCheckBoxInputKey.Indeterminate:
    nextInputKey = ASPxClientCheckBoxInputKey.Checked; break;
  }
  return this.GetValueByInputKey(nextInputKey);
 },
 GetCheckStateByInputKey: function(inputKey) {
  switch(inputKey) {
   case ASPxClientCheckBoxInputKey.Checked: 
    return ASPxClientCheckBoxCheckState.Checked;
   case ASPxClientCheckBoxInputKey.Unchecked: 
    return ASPxClientCheckBoxCheckState.Unchecked;
   case ASPxClientCheckBoxInputKey.Indeterminate: 
    return ASPxClientCheckBoxCheckState.Indeterminate;
  }
 },
 GetValueByCheckState: function(checkState) {
  switch(checkState) {
   case ASPxClientCheckBoxCheckState.Checked: 
    return this.GetValueByInputKey(ASPxClientCheckBoxInputKey.Checked);
   case ASPxClientCheckBoxCheckState.Unchecked: 
    return this.GetValueByInputKey(ASPxClientCheckBoxInputKey.Unchecked);
   case ASPxClientCheckBoxCheckState.Indeterminate: 
    return this.GetValueByInputKey(ASPxClientCheckBoxInputKey.Indeterminate);
  }
 },
 GetFirstValueBySecondValue: function(firstValueName, secondValueName, secondValue) {
  return this.GetValueByFunc(firstValueName, 
   function(checkBoxState) { return checkBoxState[secondValueName] === secondValue; });
 },
 GetValueByFunc: function(valueName, func) {
  for(var i = 0; i < this.checkBoxStates.length; i++) {
   if(func(this.checkBoxStates[i]))
    return this.checkBoxStates[i][valueName];
  }  
 },
 AssignElementClassName: function(element, cssClassPropertyKey, disabledCssClassPropertyKey, assignedClassName) {
  var classNames = [ ];
  for(var i = 0; i < this.imageProperties[cssClassPropertyKey].length; i++) {
   classNames.push(this.imageProperties[disabledCssClassPropertyKey][i]);
   classNames.push(this.imageProperties[cssClassPropertyKey][i]);
  }
  var elementClassName = element.className;
  for(var i = 0; i < classNames.length; i++) {
   var className = classNames[i];
   var index = elementClassName.indexOf(className);
   if(index > -1)
    elementClassName = elementClassName.replace((index == 0 ? '' : ' ') + className, "");
  }
  elementClassName += " " + assignedClassName;
  element.className = elementClassName;
 },
 UpdateInternalCheckBoxDecoration: function(mainElement, inputKey, enabled) {
  var imagePropertiesNumber = this.GetImagePropertiesNumByInputKey(inputKey);
  for (var imagePropertyKey in this.imageProperties) {
   var propertyValue = this.imageProperties[imagePropertyKey][imagePropertiesNumber];
   propertyValue = propertyValue || !isNaN(propertyValue) ? propertyValue : "";
   switch(imagePropertyKey) {
    case "0" : mainElement.title = propertyValue; break;
    case "1" : mainElement.style.width = propertyValue + (propertyValue != "" ? "px" : ""); break;
    case "2" : mainElement.style.height = propertyValue + (propertyValue != "" ? "px" : ""); break;
   }
   if(enabled) {
    switch(imagePropertyKey) {
     case "3" : this.SetImageSrc(mainElement, propertyValue); break;
     case "4" : 
      this.AssignElementClassName(mainElement, "4", "8", propertyValue);
      break;
     case "5" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
     case "6" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
    }
   } else {
     switch(imagePropertyKey) {
     case "7" : this.SetImageSrc(mainElement, propertyValue); break;
     case "8" : 
      this.AssignElementClassName(mainElement, "4", "8", propertyValue);
      break;
     case "9" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
     case "10" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
    }
   }
  }
 },
 SetImageSrc: function(mainElement, src) {
  mainElement.style.backgroundImage = "url(" + src + ")";
  this.SetBackgroundPosition(mainElement, 0, 0);
 },
 SetBackgroundPosition: function(element, value, isX) {
  if(value === "") {
   element.style.backgroundPosition = value;
   return;
  }
  if(element.style.backgroundPosition === "")
   element.style.backgroundPosition = isX ? "-" + value.toString() + "px 0px" : "0px -" + value.toString() + "px";
  else {
   var position = element.style.backgroundPosition.split(' ');
   element.style.backgroundPosition = isX ? '-' + value.toString() + "px " + position[1] :  position[0] + " -" + value.toString() + "px";
  }
 },
 AddState: function(value, stateInputKey, imagePropertiesNumber) {
  this.checkBoxStates.push({
   "Value" : value, 
   "StateInputKey" : stateInputKey, 
   "ImagePropertiesNumber" : imagePropertiesNumber
  });
 }
});
ASPxCheckableElementStateController.Create = function(imageProperties, valueChecked, valueUnchecked, valueGrayed, allowGrayed) {
 var stateController = new ASPxCheckableElementStateController(imageProperties);
 stateController.AddState(valueChecked, ASPxClientCheckBoxInputKey.Checked, 0);
 stateController.AddState(valueUnchecked, ASPxClientCheckBoxInputKey.Unchecked, 1);
 if(typeof(valueGrayed) != "undefined")
  stateController.AddState(valueGrayed, ASPxClientCheckBoxInputKey.Indeterminate, allowGrayed ? 2 : 1);
 stateController.allowGrayed = allowGrayed;
 return stateController;
};
ASPxCheckableElementHelper = _aspxCreateClass(null, {
 InternalCheckBoxInitialize: function(internalCheckBox) {
  this.AttachToMainElement(internalCheckBox);
  this.AttachToInputElement(internalCheckBox);
 },
 AttachToMainElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.mainElement) {
    _aspxAttachEventToElement(internalCheckBox.mainElement, "click",
    function (evt) { 
     instance.InvokeClick(internalCheckBox, evt);
     if(!internalCheckBox.disableCancelBubble)
      return _aspxPreventEventAndBubble(evt);
    }
   );
   _aspxAttachEventToElement(internalCheckBox.mainElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
   _aspxPreventElementDragAndSelect(internalCheckBox.mainElement, true);
  }
 },
 AttachToInputElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.inputElement && internalCheckBox.mainElement) {
   _aspxAttachEventToElement(internalCheckBox.inputElement, "focus",
    function (evt) { 
     if(!internalCheckBox.enabled)
      internalCheckBox.inputElement.blur();
     else
      internalCheckBox.OnFocus();
    }
   );
   _aspxAttachEventToElement(internalCheckBox.inputElement, "blur", 
    function (evt) { 
     internalCheckBox.OnLostFocus();
    }
   );
   _aspxAttachEventToElement(internalCheckBox.inputElement, "keyup",
    function (evt) { 
     if(_aspxGetKeyCode(evt) == ASPxKey.Space)
      instance.InvokeClick(internalCheckBox, evt);
    }
   );
   _aspxAttachEventToElement(internalCheckBox.inputElement, "keydown",
    function (evt) { 
     if(_aspxGetKeyCode(evt) == ASPxKey.Space)
      return _aspxPreventEvent(evt);
    }
   );
  }
 },
 IsKBSInputWrapperExist: function() {
  return __aspxOpera || __aspxWebKitFamily;
 },
 GetICBMainElementByInput: function(icbInputElement) {
  return this.IsKBSInputWrapperExist() ? icbInputElement.parentNode.parentNode : icbInputElement.parentNode;
 },
 InvokeClick: function(internalCheckBox, evt) {
   if(internalCheckBox.enabled && !internalCheckBox.readOnly) {
   var inputElementValue = internalCheckBox.inputElement.value;
   internalCheckBox.inputElement.focus();
   if(!__aspxIE) 
    internalCheckBox.inputElement.value = inputElementValue;
   this.InvokeClickCore(internalCheckBox, evt)
   }
 },
 InvokeClickCore: function(internalCheckBox, evt) {
  internalCheckBox.OnClick(evt);
 }
});
ASPxCheckableElementHelper.Instance = new ASPxCheckableElementHelper();
ASPxClientCheckBoxInternal = _aspxCreateClass(null, {
 constructor: function(inputElement, stateController, allowGrayed, allowGrayedByClick, helper, container, storeValueInInput, key, disableCancelBubble) {
  this.inputElement = inputElement;
  this.mainElement = helper.GetICBMainElementByInput(this.inputElement);
  this.name = (key ? key : this.inputElement.id) + ASPxClientCheckBoxInternal.GetICBMainElementPostfix();
  this.mainElement.id = this.name;
  this.stateController = stateController;
  this.container = container;
  this.allowGrayed = allowGrayed;
  this.allowGrayedByClick = allowGrayedByClick;
  this.autoSwitchEnabled = true;
  this.storeValueInInput = !!storeValueInInput;
  this.storedInputKey = !this.storeValueInInput ? this.inputElement.value : null;
  this.disableCancelBubble = !!disableCancelBubble;
  this.focusDecoration = null;
  this.focused = false;
  this.focusLocked = false;
  this.enabled = true;
  this.readOnly = false;
  this.CheckedChanged = new ASPxClientEvent();
  this.Focus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  helper.InternalCheckBoxInitialize(this);
 },
 ChangeInputElementTabIndex: function() {  
  var changeMethod = this.enabled ? _aspxRestoreTabIndexAttribute : _aspxSaveTabIndexAttributeAndReset;
  changeMethod(this.inputElement);
 },
 CreateFocusDecoration: function(focusedStyle) {
   this.focusDecoration = new ASPxClientEditStyleDecoration(this);
   this.focusDecoration.AddStyle('F', focusedStyle[0], focusedStyle[1]);
   this.focusDecoration.AddPostfix("");
 },
 UpdateFocusDecoration: function() {
  this.focusDecoration.Update();
 },  
 StoreInputKey: function(inputKey) {
  if(this.storeValueInInput)
   this.inputElement.value = inputKey;
  else
   this.storedInputKey = inputKey;
 },
 GetStoredInputKey: function() {
  if(this.storeValueInInput)
   return this.inputElement.value;
  else
   return this.storedInputKey;
 },
 OnClick: function(e) {
  if(this.autoSwitchEnabled) {
   var currentValue = this.GetValue();
   var value = this.stateController.GetNextCheckBoxValue(currentValue, this.allowGrayedByClick && this.allowGrayed);
   this.SetValue(value);
  }
  this.CheckedChanged.FireEvent(this, e);
 },
 OnFocus: function() {
  if(!this.IsFocusLocked()) {
   this.focused = true;
   this.UpdateFocusDecoration();
   this.Focus.FireEvent(this, null);
  } else
   this.UnlockFocus();
 },
 OnLostFocus: function() {
   if(!this.IsFocusLocked()) {
   this.focused = false;
   this.UpdateFocusDecoration();
   this.LostFocus.FireEvent(this, null);
  }
 },
 Refocus: function() {
  if(this.focused) {
   this.LockFocus();
   this.inputElement.blur();
   _aspxSetFocus(this.inputElement);
  }
 },
 LockFocus: function() {
  this.focusLocked = true;
 },
 UnlockFocus: function() {
  this.focusLocked = false;
 },
 IsFocusLocked: function() {
  return this.focusLocked;
 },
 SetValue: function(value) {
  var currentValue = this.GetValue();
  if(currentValue !== value) {
   var newInputKey = this.stateController.GetInputKeyByValue(value);
   if(newInputKey) {
    this.StoreInputKey(newInputKey);   
    this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, newInputKey, this.enabled);
   }
  }
 },
 GetValue: function() {
  return this.stateController.GetValueByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentCheckState: function() {
  return this.stateController.GetCheckStateByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentInputKey: function() {
  return this.GetStoredInputKey();
 },
 GetChecked: function() {
  return this.GetCurrentInputKey() === ASPxClientCheckBoxInputKey.Checked;
 },
 SetChecked: function(checked) {
  var newValue = this.stateController.GetValueByCheckState(checked ? ASPxClientCheckBoxCheckState.Checked : ASPxClientCheckBoxCheckState.Unchecked);
  this.SetValue(newValue);
 },
 SetEnabled: function(enabled) {
  if(this.enabled != enabled) {
   this.enabled = enabled;
   this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, this.GetCurrentInputKey(), this.enabled);
   this.ChangeInputElementTabIndex();
  }
 }
});
ASPxClientCheckBoxInternal.GetICBMainElementPostfix = function() {
 return "_D";
};
ASPxCheckBoxInternalCollection = _aspxCreateClass(null, {
 constructor: function(imageProperties, allowGrayed, storeValueInInput, helper, disableCancelBubble) {
  this.checkBoxes = {};
  this.stateController = allowGrayed 
   ? ASPxCheckableElementStateController.Create(imageProperties, ASPxClientCheckBoxInputKey.Checked, ASPxClientCheckBoxInputKey.Unchecked, ASPxClientCheckBoxInputKey.Indeterminate, true)
   : ASPxCheckableElementStateController.Create(imageProperties, ASPxClientCheckBoxInputKey.Checked, ASPxClientCheckBoxInputKey.Unchecked);
  this.helper = helper || ASPxCheckableElementHelper.Instance;
  this.storeValueInInput = !!storeValueInInput;
  this.disableCancelBubble = !!disableCancelBubble;
 },
 Add: function(key, inputElement, container) {
  this.Remove(key);
  this.checkBoxes[key] = this.CreateInternalCheckBox(key, inputElement, container);
  return this.checkBoxes[key];
 },
 Clear: function(){
  this.checkBoxes = {};
 },
 Remove: function(key) {
  delete this.checkBoxes[key];
 },
 Get: function(id) {
  return this.checkBoxes[id];
 },
 SetImageProperties: function(imageProperties) {
  this.stateController.imageProperties = imageProperties;
 },
 CreateInternalCheckBox: function(key, inputElement, container) {
  return new ASPxClientCheckBoxInternal(inputElement, this.stateController, this.stateController.allowGrayed, false, this.helper, container, this.storeValueInInput, key, this.disableCancelBubble);
 }
});
ASPxClientEditStyleDecoration = _aspxCreateClass(null, {
 constructor: function(editor) {
  this.editor = editor;
  this.postfixList = [ ];
  this.styles = { };
  this.innerStyles = { };
 },
 GetStyleSheet: function() {
  if(!ASPxClientEditStyleDecoration.__sheet)
   ASPxClientEditStyleDecoration.__sheet = _aspxCreateStyleSheet();
  return ASPxClientEditStyleDecoration.__sheet;
 },
 AddPostfix: function(value, applyClass, applyBorders, applyBackground) {
  this.postfixList.push(value);
 },
 AddStyle: function(key, className, cssText) {
  this.styles[key] = this.CreateRule(className, cssText);
  this.innerStyles[key] = this.CreateRule("", this.FilterInnerCss(cssText));
 },
 CreateRule: function(className, cssText) {
  return _aspxTrim(className + " " + _aspxCreateImportantStyleRule(this.GetStyleSheet(), cssText));
 },
 Update: function() {
  for(var i = 0; i < this.postfixList.length; i++) {
   var postfix = this.postfixList[i];
   var inner = postfix.length > 0;
   var element = _aspxGetElementById(this.editor.name + postfix);
   if(!element) continue;
   if(this.HasDecoration("I")) {
    var isValid = this.editor.GetIsValid();
    this.ApplyDecoration("I", element, inner, !isValid);
   }
   if(this.HasDecoration("F"))
    this.ApplyDecoration("F", element, inner, this.editor.focused);
   if(this.HasDecoration("N")) {
    var apply = !this.editor.focused;
    if(apply) {
     var value = this.editor.GetValue();
     apply = apply && (value == null || value === "");
    }    
    this.ApplyDecoration("N", element, inner, apply);
   }
  }
 },
 HasDecoration: function(key) {
  return !!this.styles[key];
 },
 ApplyDecoration: function(key, element, inner, active) {
  var value = inner ? this.innerStyles[key] : this.styles[key];
  element.className = element.className.replace(value, "");
  if(active)
   element.className = _aspxTrim(element.className + " " + value);
 },
 FilterInnerCss: function(css) {
  return css.replace(/(border|background-image)[^:]*:[^;]+/gi, "");
 }
});
var ASPxClientTouchUI = {
 isGesture: false,
 isMouseEventFromScrolling: false,
 isNativeScrollingAllowed: true,
 clickSensetivity: 10,
 documentTouchHandlers: {},
 documentEventAttachingAllowed: true,
 msTouchDraggableClassName: "dxMSTouchDraggable",
 touchMouseDownEventName: __aspxWebKitTouchUI ? "touchstart" : "mousedown",
 touchMouseUpEventName:   __aspxWebKitTouchUI ? "touchend"   : "mouseup",
 touchMouseMoveEventName: __aspxWebKitTouchUI ? "touchmove"  : "mousemove",
 isTouchEvent: function(evt) { 
  return __aspxWebKitTouchUI && _aspxIsExists(evt.changedTouches); 
 },
 isTouchEventName: function(eventName) {
  return __aspxWebKitTouchUI && (eventName.indexOf("touch") > -1 || eventName.indexOf("gesture") > -1);
 },
 getEventX: function(evt) { 
  return evt.changedTouches[0].pageX; 
 },
 getEventY: function (evt) { 
  return evt.changedTouches[0].pageY; 
 },
 getWebkitMajorVersion: function(){
  if(!this.webkitMajorVersion){
   var regExp = new RegExp("applewebkit/(\\d+)", "i");
   var matches = regExp.exec(__aspxUserAgent);
   if(matches && matches.index >= 1)
    this.webkitMajorVersion = matches[1];
  }
  return this.webkitMajorVersion;
 },
 getIsLandscapeOrientation: function(){
  if(__aspxMacOSMobilePlatform || __aspxAndroidMobilePlatform)
   return Math.abs(window.orientation) == 90;
  return _aspxGetDocumentClientWidth() > _aspxGetDocumentClientHeight();
 },
 nativeWebKitScrollingSupported: function(){
  return __aspxMacOSMobilePlatform && (__aspxBrowserVersion >= 5.1 || this.getWebkitMajorVersion() > 533);
 },
 makeScrollableIfRequired: function(element, options) {
  if(__aspxWebKitTouchUI && element) {
   var overflow = _aspxGetCurrentStyle(element).overflow;
   if (element.tagName == "DIV" &&  overflow != "hidden" && overflow != "visible" ){
    return this.MakeScrollable(element);
   }
  }
 },
 preventScrollOnEvent: function(evt){
 },
 ensureDocumentSizesCorrect: function (){
  return (document.documentElement.clientWidth - document.documentElement.clientHeight) / (screen.width - screen.height) > 0;
 },
 ensureOrientationChanged: function(onOrientationChangedFunction){
  if(ASPxClientUtils.iOSPlatform || this.ensureDocumentSizesCorrect())
   onOrientationChangedFunction();
  else {
   window.setTimeout(function(){
    this.ensureOrientationChanged(onOrientationChangedFunction);
   }.aspxBind(this), 100);
  }
 },
 onEventAttachingToDocument: function(eventName, func){
  if(__aspxMacOSMobilePlatform && this.isTouchEventName(eventName)) {
   if(!this.documentTouchHandlers[eventName])
    this.documentTouchHandlers[eventName] = [];
   this.documentTouchHandlers[eventName].push(func);
   return this.documentEventAttachingAllowed;
  }
  return true;
 },
 onEventDettachedFromDocument: function(eventName, func){
  if(__aspxMacOSMobilePlatform && this.isTouchEventName(eventName)) {
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers)
    _aspxArrayRemove(handlers, func);
  }
 },
 processDocumentTouchEventHandlers: function(proc) {
  var touchEventNames = ["touchstart", "touchend", "touchmove", "gesturestart", "gestureend"];
  for (var i = 0; i < touchEventNames.length; i++) {
   var eventName = touchEventNames[i];
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers) {
    for (var j = 0; j < handlers.length; j++) {
     proc(eventName,handlers[j]);
    }
   }
  }
 },
 removeDocumentTouchEventHandlers: function() {
  if(__aspxMacOSMobilePlatform) {
   this.documentEventAttachingAllowed = false;
   this.processDocumentTouchEventHandlers(_aspxDetachEventFromDocumentCore);
  }
 },
 restoreDocumentTouchEventHandlers: function () {
  if(__aspxMacOSMobilePlatform) {
   this.documentEventAttachingAllowed = true;
   this.processDocumentTouchEventHandlers(_aspxAttachEventToDocumentCore);
  }
 },
 IsNativeScrolling: function() {
  return ASPxClientTouchUI.nativeWebKitScrollingSupported() && ASPxClientTouchUI.isNativeScrollingAllowed;
 },
 msTouchCreateGerturesWrapper: function(element, onTap){
  if(!window.navigator.msPointerEnabled || typeof(MSGesture) == "undefined") 
   return;
  var gesture = new MSGesture();
  gesture.target = element;
  _aspxAttachEventToElement(element, "MSPointerDown", function(evt){
   gesture.addPointer(evt.pointerId);
  });
  _aspxAttachEventToElement(element, "MSPointerUp", function(evt){
   gesture.stop();
  });
  if(onTap)
   _aspxAttachEventToElement(element, "MSGestureTap", onTap);
  return gesture;
 }
};
__aspxClassesScriptParsed = true;

