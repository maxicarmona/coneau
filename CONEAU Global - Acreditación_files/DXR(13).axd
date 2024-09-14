var __aspxTEInputSuffix = "_I";
var __aspxTERawInputSuffix = "_Raw";
var __aspxPasteCheckInterval = 50;
ASPxEditorStretchedInputElementsManager = _aspxCreateClass(null, {
 constructor: function() {
  this.targetEditorNames = { };
 },
 Initialize: function() {
  this.InitializeTargetEditorsList();
 },
 InitializeTargetEditorsList: function() {
  aspxGetControlCollection().ForEachControl(function(control) {
   if(this.targetEditorNames[control.name])
    return;
   if(ASPxIdent.IsASPxClientTextEdit(control) && control.WidthCorrectionRequired()) {
    var inputElement = control.GetInputElement();
    if(inputElement && _aspxIsWidthSetInPercentage(inputElement.style.width))
     this.targetEditorNames[control.name] = true;
   }
  }, this);
 },
 HideInputElementsExceptOf: function(exceptedEditor) {
  var collection = aspxGetControlCollection();
  for(var editorName in this.targetEditorNames) {
   if(typeof(editorName) != "string")
    continue;
   var editor = collection.Get(editorName);
   if(!ASPxIdent.IsASPxClientEdit(editor)) continue;
   if(editor && editor != exceptedEditor) {
    var input = editor.GetInputElement();
    if(input) {
     var existentSavedDisplay = input._dxSavedDisplayAttr;
     if(!_aspxIsExists(existentSavedDisplay)) {
      input._dxSavedDisplayAttr = input.style.display;
      input.style.display = "none";
     }
    }
   }   
  }
 },
 ShowInputElements: function() {
  var collection = aspxGetControlCollection();
  for(var editorName in this.targetEditorNames) {
   if(typeof(editorName) != "string")
    continue;
   var editor = collection.Get(editorName);
   if(!ASPxIdent.IsASPxClientEdit(editor)) continue;
   if(editor) {
    var input = editor.GetInputElement();
    if(input) {
     var savedDisplay = input._dxSavedDisplayAttr;
     if(_aspxIsExists(savedDisplay)) {
      input.style.display = savedDisplay;
      _aspxRemoveAttribute(input, "_dxSavedDisplayAttr");
     }
    }
   }
  }
 }
});
var __aspxEditorStretchedInputElementsManager = null;
function _aspxGetEditorStretchedInputElementsManager() {
 if(!__aspxEditorStretchedInputElementsManager)
  __aspxEditorStretchedInputElementsManager = new ASPxEditorStretchedInputElementsManager();
 return __aspxEditorStretchedInputElementsManager;
}
ASPxClientBrowserHelper = {
 SAFARI_SYSTEM_CLASS_NAME: "dxeSafariSys",
 MOBILE_SAFARI_SYSTEM_CLASS_NAME: "dxeIPadSys",
 GetBrowserSpecificSystemClassName: function() {
  if (__aspxSafari)
   return __aspxMacOSMobilePlatform ? this.MOBILE_SAFARI_SYSTEM_CLASS_NAME : this.SAFARI_SYSTEM_CLASS_NAME;
  return "";
 }
},
ASPxClientTextEdit = _aspxCreateClass(ASPxClientEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);      
  this.isASPxClientTextEdit = true;
  this.nullText = "";
  this.escCount = 0;
  this.raiseValueChangedOnEnter = true;
  this.autoResizeWithContainer = false;
  this.lastChangedValue = null;
  this.helpText = "";
  this.helpTextObj = null;  
  this.helpTextStyle = [];
  this.helpTextPosition = ASPxClientTextEditHelpTextPosition.Right;
  this.helpTextMargins = null;
  this.helpTextHAlign = ASPxClientTextEditHelpTextHAlign.Left;
  this.helpTextVAlign = ASPxClientTextEditHelpTextVAlign.Top;
  this.enableHelpTextPopupAnimation = true;
  this.helpTextDisplayMode = ASPxClientTextEditHelpTextDisplayMode.Inline;
  this.maskInfo = null;  
  this.maskValueBeforeUserInput = "";
  this.maskPasteTimerID = -1;
  this.maskPasteLock = false;    
  this.maskPasteCounter = 0;
  this.maskTextBeforePaste = "";    
  this.maskHintHtml = "";
  this.maskHintTimerID = -1;
  this.displayFormat = null;
  this.TextChanged = new ASPxClientEvent();
 },
 Initialize: function(){
  this.SaveChangedValue();
  ASPxClientEdit.prototype.Initialize.call(this);
  if(__aspxWebKitFamily)  
   this.CorrectMainElementWhiteSpaceStyle();
 },
 InlineInitialize: function(){
  ASPxClientEdit.prototype.InlineInitialize.call(this);
  if(this.maskInfo != null)
   this.InitMask();
  this.ApplyBrowserSpecificClassName();
  this.helpTextInitialize();
  if(__aspxIE && __aspxBrowserVersion > 8 && !this.isNative)
   this.correctInputElementHeight();
  var postHandler = aspxGetPostHandler();
  postHandler.PostFinalization.removeHandlerByControlName(this.name);
  postHandler.PostFinalization.AddHandler(this.OnPost, this);
 },
 correctInputElementHeight: function() {
  var mainElement = this.GetMainElement();
  var inputElement = this.GetInputElement();
  if (mainElement) {
   var mainElementHeight = mainElement.style.height;
   var mainElementHeightSpecified = mainElementHeight && mainElementHeight.indexOf('px') !== -1; 
   if(mainElementHeightSpecified) {
    var inputElementHeight = _aspxPxToInt(mainElementHeight) - _aspxGetTopBottomBordersAndPaddingsSummaryValue(mainElement);    
    var inputElementContainer = inputElement.parentNode;
    inputElementHeight -= _aspxGetTopBottomBordersAndPaddingsSummaryValue(inputElementContainer);
    var mainElementCellspacing = _aspxGetAttribute(mainElement, "cellspacing");
    if(mainElementCellspacing)
     inputElementHeight -= mainElementCellspacing * 2;
    inputElement.style.height = inputElementHeight + "px";
    if (!ASPxIdent.IsASPxClientMemo(this))
     inputElement.style.lineHeight = inputElementHeight + "px";
   }
  }
 },
 helpTextInitialize: function () {
  if (this.helpText) {
   this.helpTextObj = new ASPxClientTextEditHelpText(this, this.helpTextStyle, this.helpText, this.helpTextPosition,
    this.helpTextHAlign, this.helpTextVAlign, this.helpTextMargins, this.enableHelpTextPopupAnimation, this.helpTextDisplayMode);
  }
 },
 showHelpText: function () {
  if (this.helpTextObj)
   this.helpTextObj.show();
 },
 hideHelpText: function () {
  if (this.helpTextObj)
   this.helpTextObj.hide();
 },
 ApplyBrowserSpecificClassName: function() {
  var mainElement = this.GetMainElement();
  if(_aspxIsExistsElement(mainElement)) {
   var className = ASPxClientBrowserHelper.GetBrowserSpecificSystemClassName();
   if (className)
    mainElement.className += " " + className;
  }
 },
  CorrectMainElementWhiteSpaceStyle: function() {
  var inputElement = this.GetInputElement();
  if(inputElement && inputElement.parentNode) {
   if(this.IsElementHasWhiteSpaceStyle(inputElement.parentNode))
    inputElement.parentNode.style.whiteSpace = "normal";
  }
 },
 IsElementHasWhiteSpaceStyle: function(element) {
  var currentStyle = _aspxGetCurrentStyle(element);
  return currentStyle.whiteSpace == "nowrap" || currentStyle.whiteSpace == "pre";  
 },
 FindInputElement: function(){
  return this.isNative ? this.GetMainElement() : _aspxGetElementById(this.name + __aspxTEInputSuffix);
 },
 GetRawInputElement: function() {
  return _aspxGetElementById(this.name + __aspxTERawInputSuffix);
 },
 DecodeRawInputValue: function(value) {
  return value;
 },
 SetRawInputValue: function(value){
  this.GetRawInputElement().value = value;
 },
 SyncRawInputValue: function() {
  if(this.maskInfo != null)
   this.SetRawInputValue(this.maskInfo.GetValue());
  else
   this.SetRawInputValue(this.GetInputElement().value);
 },
 HasTextDecorators: function() {
  return this.nullText != "" || this.displayFormat != null;
 },
 CanApplyTextDecorators: function(){
  return !this.focused;
 },
 GetDecoratedText: function(value) {
  var isNull = value == null || value === "";
  if(isNull && this.nullText != "")
   return this.nullText;
  if(this.displayFormat != null)
   return ASPxFormatter.Format(this.displayFormat, value);
  if(this.maskInfo != null)
   return this.maskInfo.GetText();
  if(value == null)
   return "";
  return value;
 },
 ToggleTextDecoration: function() {
  if (this.HasTextDecorators()) {
   if (this.focused) {
    var input = this.GetInputElement();
    var oldValue = input.value;
    var sel = _aspxGetSelectionInfo(input);
    this.ToggleTextDecorationCore();
    if (oldValue != input.value) {
     if (sel.startPos == 0 && sel.endPos == oldValue.length)
      sel.endPos = input.value.length;
     else
      sel.endPos = sel.startPos;
     _aspxSetInputSelection(input, sel.startPos, sel.endPos);
    }
   } else
    this.ToggleTextDecorationCore();
  }
 },
 ToggleTextDecorationCore: function() {
  if(this.maskInfo != null) {   
   this.ApplyMaskInfo(false);
  } else {
   var input = this.GetInputElement();
   var rawValue = this.GetRawInputElement().value;
   var value = this.CanApplyTextDecorators() ? this.GetDecoratedText(rawValue) : rawValue;
   if(input.value != value)
    input.value = value;
  }
 },
 PopulateStyleDecorationPostfixes: function() {
  ASPxClientEdit.prototype.PopulateStyleDecorationPostfixes.call(this);
  this.styleDecoration.AddPostfix(__aspxTEInputSuffix);
 },
 GetValue: function() {
  var value = null;
  if(this.maskInfo != null)
   value = this.maskInfo.GetValue();
  else if(this.HasTextDecorators())
   value = this.GetRawInputElement().value;
  else
   value = this.GetInputElement().value;
  return (value == "" && this.convertEmptyStringToNull) ? null : value;
 },
 SetValue: function(value) {
  if(value == null) value = "";
  if(this.maskInfo != null) {
   this.maskInfo.SetValue(value);
   this.ApplyMaskInfo(false);
   this.SavePrevMaskValue();
  } 
  else if(this.HasTextDecorators()) {
   this.SetRawInputValue(value);
   this.GetInputElement().value = this.CanApplyTextDecorators() ? this.GetDecoratedText(value) : value;
  }
  else
   this.GetInputElement().value = value;
  if(this.styleDecoration)
   this.styleDecoration.Update();   
  this.SaveChangedValue();   
 },
 CollapseControl: function(checkSizeCorrectedFlag) {
  if (checkSizeCorrectedFlag && this.sizeCorrectedOnce)
   return;
  var mainElement = this.GetMainElement();
  if (!_aspxIsExistsElement(mainElement))
   return;
  if (this.WidthCorrectionRequired())
   this.GetInputElement().style.width = "0";
 },
 CorrectEditorWidth: function() {
  var inputElement = this.GetInputElement();
  var stretchedInputsManager = _aspxGetEditorStretchedInputElementsManager();
  var currentAciveElement = null;
  if (this.IsRestoreActiveElementAfterWidthCorrection()) 
   currentAciveElement = _aspxGetActiveElement();
  try {
   stretchedInputsManager.HideInputElementsExceptOf(this);
   _aspxSetOffsetWidth(inputElement, _aspxGetClearClientWidth(_aspxFindOffsetParent(inputElement)) - this.GetInputWidthCorrection());
  } finally {
   stretchedInputsManager.ShowInputElements();
  }
  if (this.IsRestoreActiveElementAfterWidthCorrection()) 
   this.RestoreActiveElement(currentAciveElement);
 },
 UnstretchInputElement: function(){
  var inputElement = this.GetInputElement();
  var mainElement = this.GetMainElement();
  var mainElementCurStyle = _aspxGetCurrentStyle(mainElement);
  if (_aspxIsExistsElement(mainElement) && _aspxIsExistsElement(inputElement) && _aspxIsExists(mainElementCurStyle) && 
   inputElement.style.width == "100%" &&
   (mainElementCurStyle.width == "" || mainElementCurStyle.width == "auto"))
   inputElement.style.width = "";
 },
 RestoreActiveElement: function(activeElement) {
  if (activeElement && activeElement.setActive && activeElement.tagName != "IFRAME")
   activeElement.setActive();
 },
 IsRestoreActiveElementAfterWidthCorrection: function() {
  return __aspxIE && __aspxBrowserVersion <= 7;
 },
 RaiseValueChangedEvent: function() {
  var processOnServer = ASPxClientEdit.prototype.RaiseValueChangedEvent.call(this);
  processOnServer = this.RaiseTextChanged(processOnServer);
  return processOnServer;
 },
 GetInputWidthCorrection: function(){
  return 0;
 },
 InitMask: function() {
  var raw = String(this.GetRawInputElement().value);  
  this.SetValue(raw.length ? this.DecodeRawInputValue(raw) : this.maskInfo.GetValue());
  this.validationPatterns.unshift(new ASPxMaskValidationPattern(this.maskInfo.errorText, this.maskInfo));
  this.maskPasteTimerID = _aspxSetInterval("aspxMaskPasteTimerProc('" + this.name + "')", __aspxPasteCheckInterval);
 },
 SavePrevMaskValue: function() {
  this.maskValueBeforeUserInput = this.maskInfo.GetValue();
 },
 FillMaskInfo: function() {
  var input = this.GetInputElement();
  if(!input) return; 
  var sel = _aspxGetSelectionInfo(input);
  this.maskInfo.SetCaret(sel.startPos, sel.endPos - sel.startPos);  
 },
 ApplyMaskInfo: function(applyCaret) {
  this.SyncRawInputValue();
  var input = this.GetInputElement();
  var text = this.GetMaskDisplayText();
  this.maskTextBeforePaste = text;
  if(input.value != text)
   input.value = text;
  if(applyCaret)
   _aspxSetInputSelection(input, this.maskInfo.caretPos, this.maskInfo.caretPos + this.maskInfo.selectionLength);
 },
 GetMaskDisplayText: function() {
  if(!this.focused && this.HasTextDecorators())
   return this.GetDecoratedText(this.maskInfo.GetValue());
  return this.maskInfo.GetText();
 },
 ShouldCancelMaskKeyProcessing: function(htmlEvent, keyDownInfo) {
  return htmlEvent.returnValue === false;
 }, 
 HandleMaskKeyDown: function(evt) {
  var keyInfo = _aspxMaskManager.CreateKeyInfoByEvent(evt);
  _aspxMaskManager.keyCancelled = this.ShouldCancelMaskKeyProcessing(evt, keyInfo);
  if(_aspxMaskManager.keyCancelled) {
   _aspxPreventEvent(evt);
   return;
  }
  this.maskPasteLock = true;
  this.FillMaskInfo();  
  var canHandle = _aspxMaskManager.CanHandleControlKey(keyInfo);   
  _aspxMaskManager.savedKeyDownKeyInfo = keyInfo;
  if(canHandle) {   
   _aspxMaskManager.OnKeyDown(this.maskInfo, keyInfo);
   this.ApplyMaskInfo(true);
   _aspxPreventEvent(evt);
  }
  _aspxMaskManager.keyDownHandled = canHandle;
  this.maskPasteLock = false;
  this.UpdateMaskHintHtml();
 },
 HandleMaskKeyPress: function(evt) {
  var keyInfo = _aspxMaskManager.CreateKeyInfoByEvent(evt);
  _aspxMaskManager.keyCancelled = _aspxMaskManager.keyCancelled || this.ShouldCancelMaskKeyProcessing(evt, _aspxMaskManager.savedKeyDownKeyInfo);
  if(_aspxMaskManager.keyCancelled) {
   _aspxPreventEvent(evt);
   return;
  }
  this.maskPasteLock = true;  
  var printable = _aspxMaskManager.savedKeyDownKeyInfo != null && _aspxMaskManager.IsPrintableKeyCode(_aspxMaskManager.savedKeyDownKeyInfo);
  if(printable) {
   _aspxMaskManager.OnKeyPress(this.maskInfo, keyInfo);
   this.ApplyMaskInfo(true);
  }
  if(printable || _aspxMaskManager.keyDownHandled)   
   _aspxPreventEvent(evt); 
  this.maskPasteLock = false;
  this.UpdateMaskHintHtml();
 },
 MaskPasteTimerProc: function() {
  if(this.maskPasteLock) return;
  this.maskPasteCounter++;
  var inputElement = this.inputElement;
  if(!inputElement || this.maskPasteCounter > 40) {
   this.maskPasteCounter = 0;
   inputElement = this.GetInputElement();
  if(!_aspxIsExistsElement(inputElement)) {
   this.maskPasteTimerID = _aspxClearInterval(this.maskPasteTimerID);
   return;  
  }
  }
  if(this.maskTextBeforePaste != inputElement.value && this.maskInfo != null) {
   this.maskInfo.ProcessPaste(inputElement.value, _aspxGetSelectionInfo(inputElement).endPos);
   this.ApplyMaskInfo(true);
  }
 },
 BeginShowMaskHint: function() {  
  if(!this.readOnly && this.maskHintTimerID == -1)
   this.maskHintTimerID = window.setInterval(aspxMaskHintTimerProc, 500);
 },
 EndShowMaskHint: function() {
  window.clearInterval(this.maskHintTimerID);
  this.maskHintTimerID = -1;
 },
 MaskHintTimerProc: function() {  
  if(this.maskInfo) {
   this.FillMaskInfo();
   this.UpdateMaskHintHtml();
  } else {
   this.EndShowMaskHint();
  }
 },
 UpdateMaskHintHtml: function() {  
  var hint =  this.GetMaskHintElement();
  if(!_aspxIsExistsElement(hint))
   return;
  var html = _aspxMaskManager.GetHintHtml(this.maskInfo);
  if(html == this.maskHintHtml)
   return;
  if(html != "") {
   var mainElement = this.GetMainElement();
   if(_aspxIsExistsElement(mainElement)) {
    hint.innerHTML = html;
    hint.style.position = "absolute";  
    hint.style.left = _aspxPrepareClientPosForElement(_aspxGetAbsoluteX(mainElement), mainElement, true) + "px";
    hint.style.top = (_aspxPrepareClientPosForElement(_aspxGetAbsoluteY(mainElement), mainElement, false) + mainElement.offsetHeight + 2) + "px";
    hint.style.display = "block";    
   }   
  } else {
   hint.style.display = "none";
  }
  this.maskHintHtml = html;
 },
 HideMaskHint: function() {
  var hint =  this.GetMaskHintElement();
  if(_aspxIsExistsElement(hint))
   hint.style.display = "none";
  this.maskHintHtml = "";
 },
 GetMaskHintElement: function() {
  return _aspxGetElementById(this.name + "_MaskHint");
 },
 OnMouseWheel: function(evt){
  if(this.readOnly || this.maskInfo == null) return;
  this.FillMaskInfo();
  _aspxMaskManager.OnMouseWheel(this.maskInfo, _aspxGetWheelDelta(evt) < 0 ? -1 : 1);
  this.ApplyMaskInfo(true);
  _aspxPreventEvent(evt);
  this.UpdateMaskHintHtml();
 }, 
 OnBrowserWindowResize: function(evt) {
  if(!this.autoResizeWithContainer)
   this.AdjustControl();
 },
 IsValueChanged: function() {
    return this.GetValue() != this.lastChangedValue; 
 },
 OnKeyDown: function(evt) {        
  if(__aspxIE && _aspxGetKeyCode(evt) == ASPxKey.Esc) {   
   if(++this.escCount > 1) {
    _aspxPreventEvent(evt);
    return;
   }
  } else 
   this.escCount = 0;
  ASPxClientEdit.prototype.OnKeyDown.call(this, evt);
  if(!this.IsRaiseStandardOnChange(evt)) {
   if(!this.readOnly && this.maskInfo != null)
    this.HandleMaskKeyDown(evt);
  }
 },
 OnKeyPress: function(evt) {
  ASPxClientEdit.prototype.OnKeyPress.call(this, evt);
  if(!this.readOnly && this.maskInfo != null && !this.IsRaiseStandardOnChange(evt))
   this.HandleMaskKeyPress(evt);
  if(this.NeedOnKeyEventEnd(evt, true))
   this.OnKeyEventEnd(evt);
 },
 OnKeyUp: function(evt) {
  if (__aspxFirefox && !this.focused && _aspxGetKeyCode(evt) === ASPxKey.Tab)
   return;
  if(this.NeedOnKeyEventEnd(evt, false)) 
   this.OnKeyEventEnd(evt);
  ASPxClientEdit.prototype.OnKeyUp.call(this, evt);
 },
 NeedOnKeyEventEnd: function(evt, isKeyPress) { 
  var handleKeyPress = this.maskInfo != null && evt.keyCode == ASPxKey.Enter;
  return handleKeyPress == isKeyPress;
 },
 OnKeyEventEnd: function(evt){
  if(!this.readOnly) {
   if(this.IsRaiseStandardOnChange(evt))
    this.RaiseStandardOnChange();
   if(this.HasTextDecorators())
    this.SyncRawInputValue();
  }
 },
 IsRaiseStandardOnChange: function(evt){
  return !this.specialKeyboardHandlingUsed && this.raiseValueChangedOnEnter && evt.keyCode == ASPxKey.Enter;
 },
 GetFocusSelectAction: function() {
  if(this.maskInfo)
   return "start";
  return "all"; 
 },
 OnFocusCore: function() {
  var wasLocked = this.IsFocusEventsLocked();
  if(!this.GetEnabled()){
   var inputElement = this.GetInputElement();
   if(inputElement) 
    inputElement.blur();
   return;
  }
  ASPxClientEdit.prototype.OnFocusCore.call(this);
  if(this.maskInfo != null) {
   this.SavePrevMaskValue();
   this.BeginShowMaskHint();
  }
  if(!wasLocked)
   this.ToggleTextDecoration();
  if (this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.showHelpText();
 },
 OnLostFocusCore: function() {
  var wasLocked = this.IsFocusEventsLocked();
  ASPxClientEdit.prototype.OnLostFocusCore.call(this);
  if(this.maskInfo != null) {
   this.EndShowMaskHint();
   this.HideMaskHint();   
   if(this.maskInfo.ApplyFixes(null))
    this.ApplyMaskInfo(false);
   this.RaiseStandardOnChange();
  }
  if(!wasLocked)
   this.ToggleTextDecoration();
  this.escCount = 0;
  if(this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.hideHelpText();
 },
 OnValueChanged: function() { 
  if(this.maskInfo != null) {
   if(this.maskInfo.GetValue() == this.maskValueBeforeUserInput) 
    return;
   this.SavePrevMaskValue();
  }
  if(this.HasTextDecorators())
   this.SyncRawInputValue();
  if(!this.IsValueChanged()) return;
  this.SaveChangedValue(); 
  ASPxClientEdit.prototype.OnValueChanged.call(this);
 }, 
 OnTextChanged: function() {
 },
 SaveChangedValue: function() {
  this.lastChangedValue = this.GetValue();
 },
 RaiseStandardOnChange: function(){
  var element = this.GetInputElement();
  if(element && element.onchange) {
   element.onchange({ target: this.GetInputElement() });
  }
 },
 RaiseTextChanged: function(processOnServer){
  if(!this.TextChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.TextChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;  
 },
 GetText: function(){
  if(this.maskInfo != null) {
   return this.maskInfo.GetText();
  } else {
   var value = this.GetValue();
   return value != null ? value : "";
  }
 },
 SetText: function (value){
  if(this.maskInfo != null) {
   this.maskInfo.SetText(value);
   this.ApplyMaskInfo(false);
   this.SavePrevMaskValue();
  } else {
   this.SetValue(value);
  }
 },
 SelectAll: function() {
  this.SetSelection(0, -1, false);
 },
 SetCaretPosition: function(pos) {
  var inputElement = this.GetInputElement();
  _aspxSetCaretPosition(inputElement, pos);
 },
 SetSelection: function(startPos, endPos, scrollToSelection) { 
  var inputElement = this.GetInputElement();
  _aspxSetSelection(inputElement, startPos, endPos, scrollToSelection);
 },
 ChangeEnabledAttributes: function(enabled){
  var inputElement = this.GetInputElement();
  if(inputElement){
   this.ChangeInputEnabledAttributes(inputElement, _aspxChangeAttributesMethod(enabled), enabled);
   if(this.specialKeyboardHandlingUsed)
    this.ChangeSpecialInputEnabledAttributes(inputElement, _aspxChangeEventsMethod(enabled));
   this.ChangeInputEnabled(inputElement, enabled, this.readOnly);
  }
 },
 ChangeEnabledStateItems: function(enabled){
  if(!this.isNative) {
   var sc = aspxGetStateController();
   sc.SetElementEnabled(this.GetMainElement(), enabled);
   sc.SetElementEnabled(this.GetInputElement(), enabled);
  }
 },
 ChangeInputEnabled: function(element, enabled, readOnly){
  if(this.UseReadOnlyForDisabled())
   element.readOnly = !enabled || readOnly;
  else
   element.disabled = !enabled;
 },
 ChangeInputEnabledAttributes: function(element, method, enabled){
  if(enabled && __aspxWebKitFamily && element.tabIndex == -1)
   element.tabIndex = null;
  method(element, "tabIndex");
  if(!enabled) element.tabIndex = -1;
  method(element, "onclick");
  if(!this.NeedFocusCorrectionWhenDisabled())
   method(element, "onfocus");
  method(element, "onblur");
  method(element, "onkeydown");
  method(element, "onkeypress");
  method(element, "onkeyup");
 },
 UseReadOnlyForDisabled: function(){
  return (__aspxIE || __aspxOpera) && !this.isNative;
 },
 NeedFocusCorrectionWhenDisabled: function(){
  return __aspxIE && !this.isNative;
 },
 OnPost: function() {
  if(this.GetEnabled() || !this.UseReadOnlyForDisabled())
   return;
  var inputElement = this.GetInputElement();
  if(inputElement) {
   inputElement.disabled = true;
   window.setTimeout(function() {
    inputElement.disabled = false;
   }.aspxBind(this), 0);
  }
 }
});
ASPxIdent.IsASPxClientTextEdit = function(obj) {
 return !!obj.isASPxClientTextEdit;
};
ASPxMaskValidationPattern = _aspxCreateClass(ASPxValidationPattern, {
 constructor: function(errorText, maskInfo) {
  this.constructor.prototype.constructor.call(this, errorText);
  this.maskInfo = maskInfo;
 },
 EvaluateIsValid: function(value) {
  return this.maskInfo.IsValid();
 }
});
ASPxClientTextBoxBase = _aspxCreateClass(ASPxClientTextEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.sizingConfig.allowSetHeight = false;
  this.sizingConfig.adjustControl = true;
 }
});
ASPxClientTextBox = _aspxCreateClass(ASPxClientTextBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientTextBox = true;
 }
});
ASPxClientTextBox.Cast = ASPxClientControl.Cast;
ASPxIdent.IsASPxClientTextBox = function(obj) {
 return !!obj.isASPxClientTextBox;
};
var __aspxMMinHeight = 34;
ASPxClientMemo = _aspxCreateClass(ASPxClientTextEdit, { 
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);        
  this.isASPxClientMemo = true;
  this.raiseValueChangedOnEnter = false;
 },
 CollapseControl: function(checkSizeCorrectedFlag) {
  if (checkSizeCorrectedFlag && this.sizeCorrectedOnce)
   return;
  var mainElement = this.GetMainElement();
  var inputElement = this.GetInputElement();
  if (!_aspxIsExistsElement(mainElement) || !_aspxIsExistsElement(inputElement))
   return;
  ASPxClientTextEdit.prototype.CollapseControl.call(this, checkSizeCorrectedFlag);
  var mainElementCurStyle = _aspxGetCurrentStyle(mainElement);
  if (this.heightCorrectionRequired && mainElement && inputElement) {
   if (mainElement.style.height == "100%" || mainElementCurStyle.height == "100%") {
    mainElement.style.height = "0";
    mainElement.wasCollapsed = true;
   }
   inputElement.style.height = "0";
  }
 },
 CorrectEditorHeight: function() {
  var mainElement = this.GetMainElement();
  if(mainElement.wasCollapsed) {
   mainElement.wasCollapsed = null;
   _aspxSetOffsetHeight(mainElement, _aspxGetClearClientHeight(_aspxFindOffsetParent(mainElement)));
  }
  if(!this.isNative) {
   var inputElement = this.GetInputElement();
   var inputClearClientHeight = _aspxGetClearClientHeight(_aspxFindOffsetParent(inputElement));
   if(__aspxIE) {
    inputClearClientHeight -= 2;
    var calculatedMainElementStyle = _aspxGetCurrentStyle(mainElement);
    inputClearClientHeight += _aspxPxToInt(calculatedMainElementStyle.borderTopWidth) + _aspxPxToInt(calculatedMainElementStyle.borderBottomWidth);
   }
   if(inputClearClientHeight < __aspxMMinHeight)
    inputClearClientHeight = __aspxMMinHeight;
   _aspxSetOffsetHeight(inputElement, inputClearClientHeight);
   mainElement.style.height = "100%";
  }
 },
 SetWidth: function(width) {
  this.constructor.prototype.SetWidth.call(this, width);
  if(__aspxIE)
   this.AdjustControl();
 },
 SetHeight: function(height) {
  this.GetInputElement().style.height = "1px";
  this.constructor.prototype.SetHeight.call(this, height);
  this.GetInputElement().style.height = this.GetMainElement().clientHeight + "px";
 },
 ClearErrorFrameElementsStyles: function() {
  var textarea = this.GetInputElement();
  if(!textarea)
   return;
  var scrollBarPosition = textarea.scrollTop;
  ASPxClientTextEdit.prototype.ClearErrorFrameElementsStyles.call(this);
  if(__aspxFirefox)
   textarea.scrollTop = scrollBarPosition;
 },
 AllowPreventingDefaultEnterBehavior: function() {
  return false; 
 }
});
ASPxClientMemo.Cast = ASPxClientControl.Cast;
ASPxIdent.IsASPxClientMemo = function(obj) {
 return !!obj.isASPxClientMemo;
};
ASPxClientButtonEditBase = _aspxCreateClass(ASPxClientTextBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);        
  this.allowUserInput = true;
  this.allowMouseWheel = true;
  this.buttonCount = 0;
  this.ButtonClick = new ASPxClientEvent();
 },
 GetInputWidthCorrection: function(){
  if(__aspxIE && __aspxBrowserVersion <= 7){
   var mainElement = this.GetMainElement();
   var cellSpacing = _aspxGetAttribute(mainElement, "cellSpacing");
   if(cellSpacing === "0")
    return 1;
  }
  return 0;
 },
 GetButton: function(number) {
  return this.GetChild("_B" + number);
 },
 ProcessInternalButtonClick: function(buttonIndex) {
  return false;
 },
 OnButtonClick: function(number){
  var processOnServer = this.RaiseButtonClick(number);
  if (!this.ProcessInternalButtonClick(number) && processOnServer)
   this.SendPostBack('BC:' + number);
 },
 OnKeyPress: function(evt) {
  if(this.allowUserInput)
   ASPxClientTextBoxBase.prototype.OnKeyPress.call(this, evt);
 },
 RaiseButtonClick: function(number){
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("ButtonClick");
  if(!this.ButtonClick.IsEmpty()){
   var args = new ASPxClientButtonEditClickEventArgs(processOnServer, number);
   this.ButtonClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 ChangeEnabledAttributes: function(enabled){
  ASPxClientTextEdit.prototype.ChangeEnabledAttributes.call(this, enabled);
  for(var i = 0; i < this.buttonCount; i++){
   var element = this.GetButton(i);
   if(element) 
    this.ChangeButtonEnabledAttributes(element, _aspxChangeAttributesMethod(enabled));
  }
 },
 ChangeEnabledStateItems: function(enabled){
  ASPxClientTextEdit.prototype.ChangeEnabledStateItems.call(this, enabled);
  for(var i = 0; i < this.buttonCount; i++){
   var element = this.GetButton(i);
   if(element) 
    aspxGetStateController().SetElementEnabled(element, enabled);
  }
 },
 ChangeButtonEnabledAttributes: function(element, method){
  method(element, "onclick");
  method(element, "ondblclick");
  method(element, "onmousedown");
  method(element, "onmouseup");
 },
 ChangeInputEnabled: function(element, enabled, readOnly){
  ASPxClientTextEdit.prototype.ChangeInputEnabled.call(this, element, enabled, readOnly || !this.allowUserInput);
 }
});
ASPxClientButtonEdit = _aspxCreateClass(ASPxClientButtonEditBase, {
});
ASPxClientButtonEdit.Cast = ASPxClientControl.Cast;
ASPxClientButtonEditClickEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, buttonIndex){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.buttonIndex = buttonIndex;
 }
});
function aspxETextChanged(name) { 
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null) edit.OnTextChanged(); 
}
function aspxBEClick(name,number){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null) edit.OnButtonClick(number);
}
function aspxMaskPasteTimerProc(name){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null && edit.maskInfo) 
  edit.MaskPasteTimerProc();
}
function aspxMaskHintTimerProc() {
 var focusedEditor = ASPxClientEdit.GetFocusedEditor();
 if(focusedEditor != null && _aspxIsFunction(focusedEditor.MaskHintTimerProc))
  focusedEditor.MaskHintTimerProc();
}
function _aspxSetFocusToTextEditWithDelay(name) {
 _aspxSetTimeout(function() {
  var edit = aspxGetControlCollection().Get(name);
  if(!edit)
   return;
  __aspxIE ? edit.SetCaretPosition(0) : edit.SetFocus();
 }, 500);
}
ASPxClientTextEditHelpTextPosition = {
 Left: "Left",
 Right: "Right",
 Top: "Top",
 Bottom: "Bottom"
}
ASPxClientTextEditHelpTextHAlign = {
 Left: "Left",
 Right: "Right",
 Center: "Center"
}
ASPxClientTextEditHelpTextVAlign = {
 Top: "Top",
 Bottom: "Bottom",
 Middle: "Middle"
}
ASPxClientTextEditHelpTextDisplayMode = {
 Inline: "Inline",
 Popup: "Popup"
}
ASPxClientTextEditHelpTextConsts = {
 VERTICAL_ORIENTATION_CLASS_NAME: "dxeVHelpTextSys",
 HORIZONTAL_ORIENTATION_CLASS_NAME: "dxeHHelpTextSys"
}
ASPxClientTextEditHelpText = _aspxCreateClass(null, {
 constructor: function (editor, helpTextStyle, helpText, position, hAlign, vAlign, margins, animationEnabled, helpTextDisplayMode) {
  this.hAlign = hAlign;
  this.vAlign = vAlign;
  this.animationEnabled = animationEnabled;
  this.displayMode = helpTextDisplayMode;
  this.editor = editor;
  this.editorMainElement = editor.GetMainElement();
  this.margins = margins ? { Top: margins[0], Right: margins[1], Bottom: margins[2], Left: margins[3] } : null;
  this.defaultMargins = { Top: 10, Right: 10, Bottom: 10, Left: 10 };
  this.position = position;
  this.helpTextElement = this.createHelpTextElement();
  this.setHelpTextZIndex(true);
  this.prepareHelpTextElement(helpTextStyle, helpText);
 },
 addHelpTextCellToExternalTable: function (errorTable, helpTextCell) {
  var getRows = function (table) { return _aspxGetChildNodesByTagName(table, "TR"); };
  var getCells = function (row) { return _aspxGetChildNodesByTagName(row, "TD"); };
  var errorTableBody = _aspxGetChildByTagName(errorTable, "TBODY", 0);
  var tableRows = getRows(errorTableBody);
  var rowCount = tableRows.length;
  var colCount = getCells(tableRows[0]).length;
  if (this.position === ASPxClientTextEditHelpTextPosition.Top || this.position === ASPxClientTextEditHelpTextPosition.Bottom) {
   var helpTextElement = document.createElement("TR");
   if (this.position === ASPxClientTextEditHelpTextPosition.Top)
    errorTableBody.insertBefore(helpTextElement, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextElement);
   helpTextElement.appendChild(helpTextCell);
   if (colCount > 1)
    _aspxSetAttribute(helpTextCell, "ColSpan", colCount);
  } else {
   var helpTextElement = tableRows[0];
   if ((this.position === ASPxClientTextEditHelpTextPosition.Left && !this.editor.rtl) ||
    (this.position === ASPxClientTextEditHelpTextPosition.Right && this.editor.rtl))
    helpTextElement.insertBefore(helpTextCell, helpTextElement.childNodes[0]);
   else
    helpTextElement.appendChild(helpTextCell);
   if (rowCount > 1)
    _aspxSetAttribute(helpTextCell, "RowSpan", rowCount);
  }
 },
 createExternalTable: function () {
  var externalTable = document.createElement("TABLE");
  externalTable.cellPadding = 0;
  externalTable.cellSpacing = 0;
  var editorWidth = this.editorMainElement.style.width;
  if (editorWidth && editorWidth.indexOf('%') !== -1)
   externalTable.style.width = editorWidth;
  var externalTableBody = document.createElement("TBODY");
  var externalTableRow = document.createElement("TR");
  var externalTableCell = document.createElement("TD");
  externalTable.appendChild(externalTableBody);
  externalTableBody.appendChild(externalTableRow);
  externalTableRow.appendChild(externalTableCell);
  this.editorMainElement.parentNode.appendChild(externalTable);
  _aspxChangeElementContainer(this.editorMainElement, externalTableCell, true);
  return externalTable;
 },
 createInlineHelpTextElement: function () {
  var helpTextElement = document.createElement("TD");
  var externalTable = this.editor.GetExternalTable();
  if (!externalTable)
   externalTable = this.createExternalTable();
  this.addHelpTextCellToExternalTable(externalTable, helpTextElement);
  return helpTextElement;
 },
 createPopupHelpTextElement: function () {
  var helpTextElement = document.createElement("DIV");
  document.body.appendChild(helpTextElement);
  ASPxAnimationHelper.setOpacity(helpTextElement, 0);
  return helpTextElement;
 },
 createHelpTextElement: function () {
  return this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Popup ?
   this.createPopupHelpTextElement() : this.createInlineHelpTextElement();
 },
 prepareHelpTextElement: function (helpTextStyle, helpText) {
  this.helpTextElement.className = helpTextStyle[0];
  if (helpTextStyle[1]) {
   var styleSheet = _aspxGetCurrentStyleSheet();
   this.helpTextElement.className += " " + _aspxCreateImportantStyleRule(styleSheet, helpTextStyle[1]);
  }
  _aspxSetInnerHtml(this.helpTextElement, helpText);
  if (this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.updatePopupHelpTextPosition();
  else {
   var isVerticalOrientation = this.position === ASPxClientTextEditHelpTextPosition.Top || this.position === ASPxClientTextEditHelpTextPosition.Bottom;
   var orientationClassName = isVerticalOrientation ? ASPxClientTextEditHelpTextConsts.VERTICAL_ORIENTATION_CLASS_NAME :
    ASPxClientTextEditHelpTextConsts.HORIZONTAL_ORIENTATION_CLASS_NAME;
   this.helpTextElement.className += " " + orientationClassName;
   this.setInlineHelpTextElementAlign();
  }
 },
 setInlineHelpTextElementAlign: function() {
  var hAlignValue = "", vAlignValue = "";
  switch(this.hAlign) {
   case ASPxClientTextEditHelpTextHAlign.Left: hAlignValue = "left"; break;
   case ASPxClientTextEditHelpTextHAlign.Right: hAlignValue = "right"; break;
   case ASPxClientTextEditHelpTextHAlign.Center: hAlignValue = "center"; break;
  }
  switch(this.vAlign) {
   case ASPxClientTextEditHelpTextVAlign.Top: vAlignValue = "top"; break;
   case ASPxClientTextEditHelpTextVAlign.Bottom: vAlignValue = "bottom"; break;
   case ASPxClientTextEditHelpTextVAlign.Middle: vAlignValue = "middle"; break;
  }
  this.helpTextElement.style.textAlign = hAlignValue;
  this.helpTextElement.style.verticalAlign = vAlignValue;
 },
 getHelpTextMargins: function() {
  if (this.margins)
   return this.margins;
  var result = this.defaultMargins;
  if (this.position === ASPxClientTextEditHelpTextPosition.Top || this.position === ASPxClientTextEditHelpTextPosition.Bottom)
   result.Left = result.Right = 0;
  else
   result.Top = result.Bottom = 0;
  return result;
 },
 updatePopupHelpTextPosition: function (editorMainElement) {
  var editorWidth = this.editorMainElement.offsetWidth;
  var editorHeight = this.editorMainElement.offsetHeight;
  var helpTextWidth = this.helpTextElement.offsetWidth;
  var helpTextHeight = this.helpTextElement.offsetHeight;
  var editorX = _aspxGetAbsoluteX(this.editorMainElement);
  var editorY = _aspxGetAbsoluteY(this.editorMainElement);
  var helpTextX = 0, helpTextY = 0;
  var margins = this.getHelpTextMargins();
  if (this.position === ASPxClientTextEditHelpTextPosition.Top || this.position === ASPxClientTextEditHelpTextPosition.Bottom) {
   if (this.position === ASPxClientTextEditHelpTextPosition.Top)
    helpTextY = editorY - margins.Bottom - helpTextHeight;
   else if (this.position === ASPxClientTextEditHelpTextPosition.Bottom)
    helpTextY = editorY + editorHeight + margins.Top;
   if (this.hAlign === ASPxClientTextEditHelpTextHAlign.Left)
    helpTextX = editorX + margins.Left;
   else if (this.hAlign === ASPxClientTextEditHelpTextHAlign.Right)
    helpTextX = editorX + editorWidth - helpTextWidth - margins.Right;
   else if (this.hAlign === ASPxClientTextEditHelpTextHAlign.Center) {
    var editorCenterX = editorX + editorWidth / 2;
    var helpTextWidthWithMargins = helpTextWidth + margins.Left + margins.Right;
    helpTextX = editorCenterX - helpTextWidthWithMargins / 2 + margins.Left;
   }
  } else {
   if (this.position === ASPxClientTextEditHelpTextPosition.Left)
    helpTextX = editorX - margins.Right - helpTextWidth;
   else if (this.position === ASPxClientTextEditHelpTextPosition.Right)
    helpTextX = editorX + editorWidth + margins.Left;
   if (this.vAlign === ASPxClientTextEditHelpTextVAlign.Top)
    helpTextY = editorY + margins.Top;
   else if (this.vAlign === ASPxClientTextEditHelpTextVAlign.Bottom)
    helpTextY = editorY + editorHeight - helpTextHeight - margins.Bottom;
   else if (this.vAlign === ASPxClientTextEditHelpTextVAlign.Middle) {
    var editorCenterY = editorY + editorHeight / 2;
    var helpTextHeightWithMargins = helpTextHeight + margins.Top + margins.Bottom;
    helpTextY = editorCenterY - helpTextHeightWithMargins / 2 + margins.Top;
   }
  }
  helpTextX = helpTextX < 0 ? 0 : helpTextX;
  helpTextY = helpTextY < 0 ? 0 : helpTextY;
  _aspxSetAbsoluteX(this.helpTextElement, helpTextX);
  _aspxSetAbsoluteY(this.helpTextElement, helpTextY);
 },
 setHelpTextZIndex: function (hide) { 
  var newZIndex = 41998 * (hide ? -1 : 1);
  if (this.helpTextElement.style.zIndex != newZIndex)
   this.helpTextElement.style.zIndex = newZIndex;
 },
 hide: function () {
  this.animationEnabled ? ASPxAnimationHelper.fadeOut(this.helpTextElement) :
   ASPxAnimationHelper.setOpacity(this.helpTextElement, 0);
  this.setHelpTextZIndex(true);
 },
 show: function () {
  if (this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.updatePopupHelpTextPosition();
  this.animationEnabled ? ASPxAnimationHelper.fadeIn(this.helpTextElement) :
   ASPxAnimationHelper.setOpacity(this.helpTextElement, 1);
  this.setHelpTextZIndex(false);
 }
});

