var __aspxClientValidationStateNameSuffix = "$CVS";
ASPxClientEditBase = _aspxCreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.EnabledChanged = new ASPxClientEvent();
 },
 InlineInitialize: function(){
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeEnabled(); 
 },
 InitializeEnabled: function() {
  this.SetEnabledInternal(this.clientEnabled, true);
 },
 GetValue: function() {
  var element = this.GetMainElement();
  if(_aspxIsExistsElement(element))
   return element.innerHTML;
  return "";
 },
 GetValueString: function(){
  var value = this.GetValue();
  return (value == null) ? null : value.toString();
 },
 SetValue: function(value) {
  if(value == null)
   value = "";
  var element = this.GetMainElement();
  if(_aspxIsExistsElement(element))
   element.innerHTML = value;
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(enabled){
  if(this.clientEnabled != enabled) {
   var errorFrameRequiresUpdate = this.GetIsValid && !this.GetIsValid();
   if(errorFrameRequiresUpdate && !enabled)
    this.UpdateErrorFrameAndFocus(false , null , true );
   this.clientEnabled = enabled;
   this.SetEnabledInternal(enabled, false);
   if(errorFrameRequiresUpdate && enabled)
    this.UpdateErrorFrameAndFocus(false );
   this.RaiseEnabledChangedEvent();
  }
 },
 SetEnabledInternal: function(enabled, initialization){
  if(!this.enabled) return;
  if(!initialization || !enabled)
   this.ChangeEnabledStateItems(enabled);
  this.ChangeEnabledAttributes(enabled);
  if(__aspxChrome) {   
   var mainElement = this.GetMainElement();
   if(mainElement)
    mainElement.className = mainElement.className;
  } 
 },
 ChangeEnabledAttributes: function(enabled){
 },
 ChangeEnabledStateItems: function(enabled){
 },
 RaiseEnabledChangedEvent: function(){
  if(!this.EnabledChanged.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EnabledChanged.FireEvent(this, args);
  }
 }
});
ASPxValidationPattern = _aspxCreateClass(null, {
 constructor: function(errorText) {
  this.errorText = errorText;
 }
});
ASPxRequiredFieldValidationPattern = _aspxCreateClass(ASPxValidationPattern, {
 constructor: function(errorText) {
  this.constructor.prototype.constructor.call(this, errorText);
 },
 EvaluateIsValid: function(value) {
  return value != null && (value.constructor == Array || _aspxTrim(value.toString()) != "");
 }
});
ASPxRegularExpressionValidationPattern = _aspxCreateClass(ASPxValidationPattern, {
 constructor: function(errorText, pattern) {
  this.constructor.prototype.constructor.call(this, errorText);
  this.pattern = pattern;
 },
 EvaluateIsValid: function(value) {
  if (value == null) 
   return true;
  var strValue = value.toString();
  if (_aspxTrim(strValue).length == 0)
   return true;
  var regEx = new RegExp(this.pattern);
  var matches = regEx.exec(strValue);
  return matches != null && strValue == matches[0];
 }
});
function _aspxIsEditorFocusable(inputElement) {
 return _aspxIsFocusableCore(inputElement, function(container) {
  return container.getAttribute("errorFrame") == "errorFrame";
 });
}
var __aspxInvalidEditorToBeFocused = null;
ASPxValidationType = {
 PersonalOnValueChanged: "ValueChanged",
 PersonalViaScript: "CalledViaScript",
 MassValidation: "MassValidation"
};
ASPxErrorFrameDisplay = {
 None: "None",
 Static: "Static",
 Dynamic: "Dynamic"
};
ASPxEditElementSuffix = {
 ExternalTable: "_ET",
 ControlCell: "_CC",
 ErrorCell: "_EC",
 ErrorTextCell: "_ETC",
 ErrorImage: "_EI"
};
ASPxClientEdit = _aspxCreateClass(ASPxClientEditBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientEdit = true;
  this.inputElement = null;
  this.elementCache = { };
  this.convertEmptyStringToNull = true;
  this.readOnly = false;
  this.focused = false;
  this.focusEventsLocked = false;
  this.receiveGlobalMouseWheel = true;
  this.styleDecoration = null;
  this.widthCorrectionRequired = false;
  this.heightCorrectionRequired = false;
  this.customValidationEnabled = false;
  this.display = ASPxErrorFrameDisplay.Static;
  this.initialErrorText = "";
  this.causesValidation = false;
  this.validateOnLeave = true;
  this.validationGroup = "";
  this.sendPostBackWithValidation = null;
  this.validationPatterns = [];
  this.setFocusOnError = false;
  this.errorDisplayMode = "it";
  this.errorText = "";
  this.isValid = true;
  this.errorImageIsAssigned = false;
  this.clientValidationStateElement = null;
  this.notifyValidationSummariesToAcceptNewError = false;
  this.enterProcessed = false;
  this.keyDownHandlers = {};
  this.keyPressHandlers = {};
  this.keyUpHandlers = {};
  this.specialKeyboardHandlingUsed = false;
  this.onKeyDownHandler = null;
  this.onKeyPressHandler = null;
  this.onKeyUpHandler = null;
  this.onGotFocusHandler = null;
  this.onLostFocusHandler = null;
  this.GotFocus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  this.Validation = new ASPxClientEvent();
  this.ValueChanged = new ASPxClientEvent();
  this.KeyDown = new ASPxClientEvent();
  this.KeyPress = new ASPxClientEvent();
  this.KeyUp = new ASPxClientEvent();
 },
 Initialize: function() {
  this.initialErrorText = this.errorText;
  ASPxClientEditBase.prototype.Initialize.call(this);
  this.InitializeKeyHandlers();
  this.UpdateClientValidationState();
  this.UpdateValidationSummaries(null , true );
 },
 InlineInitialize: function() {
  ASPxClientEditBase.prototype.InlineInitialize.call(this);
  if(this.styleDecoration)
   this.styleDecoration.Update();
 }, 
 InitSpecialKeyboardHandling: function(){
  this.onKeyDownHandler = _aspxCreateEventHandlerFunction("aspxKBSIKeyDown", this.name, true);
  this.onKeyPressHandler = _aspxCreateEventHandlerFunction("aspxKBSIKeyPress", this.name, true);
  this.onKeyUpHandler = _aspxCreateEventHandlerFunction("aspxKBSIKeyUp", this.name, true);
  this.onGotFocusHandler = _aspxCreateEventHandlerFunction("aspxESGotFocus", this.name, false);
  this.onLostFocusHandler = _aspxCreateEventHandlerFunction("aspxESLostFocus", this.name, false);
  this.specialKeyboardHandlingUsed = true;
  this.InitializeDelayedSpecialFocus();
 },
 InitializeKeyHandlers: function() {
 },
 AddKeyDownHandler: function(key, handler) {
  this.keyDownHandlers[key] = handler;
 },
 ChangeSpecialInputEnabledAttributes: function(element, method){
  element.autocomplete = "off";
  if(this.onKeyDownHandler != null)
   method(element, "keydown", this.onKeyDownHandler);
  if(this.onKeyPressHandler != null)
   method(element, "keypress", this.onKeyPressHandler);
  if(this.onKeyUpHandler != null)
   method(element, "keyup", this.onKeyUpHandler);
  if(this.onGotFocusHandler != null)
   method(element, "focus", this.onGotFocusHandler);
  if(this.onLostFocusHandler != null)
   method(element, "blur", this.onLostFocusHandler);
 },
 UpdateClientValidationState: function() {
  if(!this.customValidationEnabled)
   return;
  var mainElement = this.GetMainElement();
  if (mainElement) {
   var hiddenField = this.GetClientValidationStateHiddenField();
   if(hiddenField)
    hiddenField.value = _aspxEncodeHtml(!this.GetIsValid() ? ("-" + this.GetErrorText()) : "");
  }
 },
 UpdateValidationSummaries: function(validationType, initializing) {
  if(typeof(ASPxClientValidationSummary) != "undefined") {
   var summaryCollection = aspxGetClientValidationSummaryCollection();
   summaryCollection.OnEditorIsValidStateChanged(this, validationType, initializing && this.notifyValidationSummariesToAcceptNewError);
  }
 },
 GetCachedElementByIdSuffix: function(idSuffix) {
  var element = this.elementCache[idSuffix];
  if(!_aspxIsExistsElement(element)) {
   element = _aspxGetElementById(this.name + idSuffix);
   this.elementCache[idSuffix] = element;
  }
  return element;
 },
 FindInputElement: function(){
  return null;
 },
 GetInputElement: function(){
  if(!_aspxIsExistsElement(this.inputElement))
   this.inputElement = this.FindInputElement();
  return this.inputElement;
 },
 GetFocusableInputElement: function() {
  return this.GetInputElement();
 },
 GetErrorImage: function() {
  return this.GetCachedElementByIdSuffix(ASPxEditElementSuffix.ErrorImage);
 },
 GetExternalTable: function() {
  return this.GetCachedElementByIdSuffix(ASPxEditElementSuffix.ExternalTable);
 },
 GetControlCell: function() {
  return this.GetCachedElementByIdSuffix(ASPxEditElementSuffix.ControlCell);
 },
 GetErrorCell: function() {
  return this.GetCachedElementByIdSuffix(ASPxEditElementSuffix.ErrorCell);
 },
 GetErrorTextCell: function() {
  return this.GetCachedElementByIdSuffix(this.errorImageIsAssigned ?
   ASPxEditElementSuffix.ErrorTextCell : ASPxEditElementSuffix.ErrorCell);
 },
 GetClientValidationStateHiddenField: function() {
  if(!this.clientValidationStateElement)
   this.clientValidationStateElement = this.CreateClientValidationStateHiddenField();
  return this.clientValidationStateElement;
 },
 CreateClientValidationStateHiddenField: function() {
  var mainElement = this.GetMainElement();
  var hiddenField = _aspxCreateHiddenField(this.uniqueID + __aspxClientValidationStateNameSuffix);
  mainElement.parentNode.appendChild(hiddenField);
  return hiddenField;
 },
 SetVisible: function(isVisible){
  if(this.clientVisible == isVisible)
   return;
  if(this.customValidationEnabled) {
   var errorFrame = this.GetExternalTable();
   if(errorFrame) {
    _aspxSetElementDisplay(errorFrame, isVisible);
    var isValid = !isVisible ? true : void(0);
    this.UpdateErrorFrameAndFocus(false , true , isValid );
   }
  }
  ASPxClientControl.prototype.SetVisible.call(this, isVisible);
 },
 GetValueInputToValidate: function() {
  return this.GetInputElement();
 },
 IsVisible: function() {
  if (!this.clientVisible)
   return false;
  var element = this.GetMainElement();
  if(!element) 
   return false;
  while(element && element.tagName != "BODY") {
   if (element.getAttribute("errorFrame") != "errorFrame" && (!_aspxGetElementVisibility(element) || !_aspxGetElementDisplay(element)))
    return false;
   element = element.parentNode;
  }
  return true;
 },
 AdjustControlCore: function() {
  this.CollapseControl();
  if (this.WidthCorrectionRequired())
   this.CorrectEditorWidth();
  else
   this.UnstretchInputElement();
  if (this.heightCorrectionRequired)
   this.CorrectEditorHeight();
 },
 WidthCorrectionRequired: function() {
  var mainElement = this.GetMainElement();
  if(_aspxIsExistsElement(mainElement)) {
   var mainElementCurStyle = _aspxGetCurrentStyle(mainElement);
   return this.widthCorrectionRequired && mainElementCurStyle.width != "" && mainElementCurStyle.width != "auto";
  }
  return false;
 },
 CorrectEditorWidth: function() {
 },
 CorrectEditorHeight: function() {
 },
 UnstretchInputElement: function() {
 },
 UseDelayedSpecialFocus: function() {
  return false;
 },
 GetDelayedSpecialFocusTriggers: function() {
  return [ this.GetMainElement() ];
 },
 InitializeDelayedSpecialFocus: function() {
  if(!this.UseDelayedSpecialFocus())
   return;
  this.specialFocusTimer = -1;    
  var handler = function(evt) { this.OnDelayedSpecialFocusMouseDown(evt); }.aspxBind(this);
  var triggers = this.GetDelayedSpecialFocusTriggers();
  for(var i = 0; i < triggers.length; i++)
   _aspxAttachEventToElement(triggers[i], "mousedown", handler);
 },
 OnDelayedSpecialFocusMouseDown: function(evt) {
  window.setTimeout(function() { this.SetFocus(); }.aspxBind(this), 0);
 },
 IsFocusEventsLocked: function() {
  return this.focusEventsLocked;
 },
 LockFocusEvents: function() {
  if(!this.focused) return;
  this.focusEventsLocked = true;
 },
 UnlockFocusEvents: function() {
  this.focusEventsLocked = false;
 },
 ForceRefocusEditor: function() {
  this.LockFocusEvents();
  var inputElement = this.GetFocusableInputElement();
  if(inputElement && inputElement.blur)
   inputElement.blur();
  window.setTimeout("aspxGetControlCollection().Get('" + this.name + "').SetFocus();", 0);
 },
 IsEditorElement: function(element) {
  return this.GetMainElement() == element || _aspxGetIsParent(this.GetMainElement(), element);
 },
 IsElementBelongToInputElement: function(element) {
  return this.GetInputElement() == element;
 },
 OnFocusCore: function() {
  if(this.UseDelayedSpecialFocus())
   window.clearTimeout(this.specialFocusTimer);
  if (!this.IsFocusEventsLocked()){
   this.focused = true;
   ASPxClientEdit.SetFocusedEditor(this);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   if(this.isInitialized)
    this.RaiseFocus();
  }
  else
   this.UnlockFocusEvents();
 },
 OnLostFocusCore: function() {
  if (!this.IsFocusEventsLocked()){
   this.focused = false;
   ASPxClientEdit.SetFocusedEditor(null);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   this.RaiseLostFocus();
  }
 },
 OnFocus: function() {
  if (!this.specialKeyboardHandlingUsed)
   this.OnFocusCore();
 },
 OnLostFocus: function() {
  if (this.isInitialized && !this.specialKeyboardHandlingUsed)
   this.OnLostFocusCore();
 },
 OnSpecialFocus: function() {
  if (this.isInitialized)
   this.OnFocusCore();
 },
 OnSpecialLostFocus: function() {
  if (this.isInitialized)
   this.OnLostFocusCore();
 },
 OnMouseWheel: function(evt){
 },
 OnValidation: function(validationType) {
  if(this.customValidationEnabled && this.isInitialized && _aspxIsExistsElement(this.GetMainElement()) &&
   (this.display == ASPxErrorFrameDisplay.None || this.GetExternalTable())) {
   this.BeginErrorFrameUpdate();
   try {
    this.SetIsValid(true, true );
    this.SetErrorText(this.initialErrorText, true );
    if(this.validateOnLeave || validationType != ASPxValidationType.PersonalOnValueChanged) {
     this.ValidateWithPatterns();
     this.RaiseValidation();
    }
    this.UpdateErrorFrameAndFocus(validationType == ASPxValidationType.PersonalOnValueChanged && this.validateOnLeave && !this.GetIsValid());
   } finally {
    this.EndErrorFrameUpdate();
   }
   this.UpdateValidationSummaries(validationType);
  }
 },
 OnValueChanged: function() {
  var processOnServer = this.RaiseValidationInternal();
  processOnServer = this.RaiseValueChangedEvent() && processOnServer;
  if (processOnServer)
   this.SendPostBackInternal("");
 },
 ParseValue: function() {
 },
 RaisePersonalStandardValidation: function() {
  if (_aspxIsFunction(window.ValidatorOnChange)) {
   var inputElement = this.GetValueInputToValidate();
   if(inputElement && inputElement.Validators)
    window.ValidatorOnChange({ srcElement: inputElement });
  }
 },
 RaiseValidationInternal: function() {
  if (this.isPostBackAllowed() && this.causesValidation && this.validateOnLeave)
   return ASPxClientEdit.ValidateGroup(this.validationGroup);
  else {
   this.OnValidation(ASPxValidationType.PersonalOnValueChanged);
   return this.GetIsValid();
  }
 },
 RaiseValueChangedEvent: function(){
  return this.RaiseValueChanged();
 },
 SendPostBackInternal: function(postBackArg) {
  if (_aspxIsFunction(this.sendPostBackWithValidation))
   this.sendPostBackWithValidation(postBackArg);
  else
   this.SendPostBack(postBackArg);
 },
 SetElementToBeFocused: function() {
  if (this.IsVisible())
   __aspxInvalidEditorToBeFocused = this;
 },
 GetFocusSelectAction: function() {
  return null;
 },
 SetFocus: function() {
  var inputElement = this.GetFocusableInputElement();
  if (!inputElement) return; 
  var isIE9 = __aspxIE && __aspxBrowserVersion >= 9;
  if ((_aspxGetActiveElement() != inputElement || isIE9) && _aspxIsEditorFocusable(inputElement)) {
   _aspxSetFocus(inputElement, this.GetFocusSelectAction());
   if (_aspxGetActiveElement() == inputElement && isIE9)
    window.setTimeout(function() { _aspxClearInputSelection(inputElement); }, 100);
  }
 },
 SetFocusOnError: function() {
  if (__aspxInvalidEditorToBeFocused == this) {
   this.SetFocus();
   __aspxInvalidEditorToBeFocused = null;
  }
 },
 BeginErrorFrameUpdate: function() {
  if(!this.errorFrameUpdateLocked)
   this.errorFrameUpdateLocked = true;
 },
 EndErrorFrameUpdate: function() {
  this.errorFrameUpdateLocked = false;
  var args = this.updateErrorFrameAndFocusLastCallArgs;
  if(args) {
   this.UpdateErrorFrameAndFocus(args[0], args[1]);
   delete this.updateErrorFrameAndFocusLastCallArgs;
  }
 },
 UpdateErrorFrameAndFocus: function(setFocusOnError, ignoreVisibilityCheck, isValid) {
  if(!this.GetEnabled() || !ignoreVisibilityCheck && !this.GetVisible())
   return;
  if(this.errorFrameUpdateLocked) {
   this.updateErrorFrameAndFocusLastCallArgs = [ setFocusOnError, ignoreVisibilityCheck ];
   return;
  }
  if(this.styleDecoration)
   this.styleDecoration.Update();
  if(typeof(isValid) == "undefined")
   isValid = this.GetIsValid();
  var externalTable = this.GetExternalTable();
  var isStaticDisplay = this.display == ASPxErrorFrameDisplay.Static;
  var isErrorFrameDisplayed = this.display != ASPxErrorFrameDisplay.None;
  if(isValid && isErrorFrameDisplayed) {
   if(isStaticDisplay) {
    externalTable.style.visibility = "hidden";
   } else {
    this.HideErrorCell();
    this.SaveErrorFrameStyles();
    this.ClearErrorFrameElementsStyles();
   }
  } else {
   var editorLocatedWithinVisibleContainer = this.IsVisible();
   if(isErrorFrameDisplayed) {
    if(this.widthCorrectionRequired) {
     if(editorLocatedWithinVisibleContainer)
      this.CollapseControl(); 
     else
      this.ResetControlAdjustment();
    }
    this.UpdateErrorCellContent();
    if(isStaticDisplay) {
     externalTable.style.visibility = "visible";
    } else {
     this.EnsureErrorFrameStylesLoaded();
     this.RestoreErrorFrameElementsStyles();
     this.ShowErrorCell();
    }
   }
   if(editorLocatedWithinVisibleContainer) {
    if(isErrorFrameDisplayed && this.widthCorrectionRequired)
     this.AdjustControl(); 
    if(setFocusOnError && this.setFocusOnError && __aspxInvalidEditorToBeFocused == null)
     this.SetElementToBeFocused();
   }
  }
 },
 ShowErrorCell: function() {
  var errorCell = this.GetErrorCell();
  if(errorCell)
   _aspxSetElementDisplay(errorCell, true);
 },
 HideErrorCell: function() {
  var errorCell = this.GetErrorCell();
  if(errorCell)
   _aspxSetElementDisplay(errorCell, false);
 },
 SaveErrorFrameStyles: function() {
  this.EnsureErrorFrameStylesLoaded();
 },
 EnsureErrorFrameStylesLoaded: function() {
  if(typeof(this.errorFrameStyles) == "undefined") {
   var externalTable = this.GetExternalTable();
   var controlCell = this.GetControlCell();
   this.errorFrameStyles = {
    errorFrame: {
     cssClass: externalTable.className,
     style: this.ExtractElementStyleStringIgnoringVisibilityProps(externalTable)
    },
    controlCell: {
     cssClass: controlCell.className,
     style: this.ExtractElementStyleStringIgnoringVisibilityProps(controlCell)
    }
   };
  }
 },
 ClearErrorFrameElementsStyles: function() {
  this.ClearElementStyle(this.GetExternalTable());
  this.ClearElementStyle(this.GetControlCell());
 },
 RestoreErrorFrameElementsStyles: function() {
  var externalTable = this.GetExternalTable();
  externalTable.className = this.errorFrameStyles.errorFrame.cssClass;
  externalTable.style.cssText = this.errorFrameStyles.errorFrame.style;
  var controlCell = this.GetControlCell();
  controlCell.className = this.errorFrameStyles.controlCell.cssClass;
  controlCell.style.cssText = this.errorFrameStyles.controlCell.style;
 },
 ExtractElementStyleStringIgnoringVisibilityProps: function(element) {
  var savedVisibility = element.style.visibility;
  var savedDisplay = element.style.display;
  element.style.visibility = "";
  element.style.display = "";
  var styleStr = element.style.cssText;
  element.style.visibility = savedVisibility;
  element.style.display = savedDisplay;
  return styleStr;
 },
 ClearElementStyle: function(element) {
  if(!element)
   return;
  element.className = "";
  var excludedAttrNames = [
   "width", "display", "visibility",
   "position", "left", "top", "z-index",
   "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
   "float", "clear"
  ];
  var savedAttrValues = { };
  for(var i = 0; i < excludedAttrNames.length; i++) {
   var attrName = excludedAttrNames[i];
   var attrValue = element.style[attrName];
   if(attrValue)
    savedAttrValues[attrName] = attrValue;
  }
  element.style.cssText = "";
  for(var styleAttrName in savedAttrValues)
   element.style[styleAttrName] = savedAttrValues[styleAttrName];
 },
 UpdateErrorCellContent: function() {
  if (this.errorDisplayMode.indexOf("t") > -1)
   this.UpdateErrorText();
  if (this.errorDisplayMode == "i")
   this.UpdateErrorImage();
 },
 UpdateErrorImage: function() {
  var image = this.GetErrorImage();
  if (_aspxIsExistsElement(image)) {
   image.alt = this.errorText;
   image.title = this.errorText;
  } else {
   this.UpdateErrorText();
  }
 },
 UpdateErrorText: function() {
  var errorTextCell = this.GetErrorTextCell();
  if(_aspxIsExistsElement(errorTextCell))
   errorTextCell.innerHTML = _aspxEncodeHtml(this.errorText);
 },
 ValidateWithPatterns: function() {
  if (this.validationPatterns.length > 0) {
   var value = this.GetValue();
   for (var i = 0; i < this.validationPatterns.length; i++) {
    var validator = this.validationPatterns[i];
    if (!validator.EvaluateIsValid(value)) {
     this.SetIsValid(false, true );
     this.SetErrorText(validator.errorText, true );
     return;
    }
   }
  }
 },
 OnSpecialKeyDown: function(evt){
  this.RaiseKeyDown(evt);
  var handler = this.keyDownHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnSpecialKeyPress: function(evt){
  this.RaiseKeyPress(evt);
  var handler = this.keyPressHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  if(__aspxNetscapeFamily || __aspxOpera){
   if(evt.keyCode == ASPxKey.Enter)
    return this.enterProcessed;
  }
  return false;
 },
 OnSpecialKeyUp: function(evt){
  this.RaiseKeyUp(evt);
  var handler = this.keyUpHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnKeyDown: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyDown(evt);
 },
 OnKeyPress: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyPress(evt);
 },
 OnKeyUp: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyUp(evt);
 },
 RaiseKeyDown: function(evt){
  if(!this.KeyDown.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyDown.FireEvent(this, args);
  }
 },
 RaiseKeyPress: function(evt){
  if(!this.KeyPress.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyPress.FireEvent(this, args);
  }
 },
 RaiseKeyUp: function(evt){
  if(!this.KeyUp.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyUp.FireEvent(this, args);
  }
 },
 RaiseFocus: function(){
  if(!this.GotFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.GotFocus.FireEvent(this, args);
  }
 },
 RaiseLostFocus: function(){
  if(!this.LostFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.LostFocus.FireEvent(this, args);
  }
 },
 RaiseValidation: function() {
  if(this.customValidationEnabled && !this.Validation.IsEmpty()) {
   var currentValue = this.GetValue();
   var args = new ASPxClientEditValidationEventArgs(currentValue, this.errorText, this.GetIsValid());
   this.Validation.FireEvent(this, args);
   this.SetErrorText(args.errorText, true );
   this.SetIsValid(args.isValid, true );
   if(args.value != currentValue)
    this.SetValue(args.value);
  }
 },
 RaiseValueChanged: function(){
  var processOnServer = this.isPostBackAllowed();
  if(!this.ValueChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.ValueChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;  
 },
 isPostBackAllowed: function() {
  return this.autoPostBack;
 },
 RequireStyleDecoration: function() {
  this.styleDecoration = new ASPxClientEditStyleDecoration(this);
  this.PopulateStyleDecorationPostfixes();
 }, 
 PopulateStyleDecorationPostfixes: function() {
  this.styleDecoration.AddPostfix("");
 },
 Focus: function(){
  this.SetFocus();
 },
 GetIsValid: function(){
  if((ASPxIdent.IsASPxClientRadioButtonList(this) || _aspxIsExistsElement(this.GetInputElement())) &&
   (this.display == ASPxErrorFrameDisplay.None || _aspxIsExistsElement(this.GetExternalTable())  ))
   return this.isValid;
  else
   return true;
 },
 GetErrorText: function(){
  return this.errorText;
 },
 SetIsValid: function(isValid, validating){
  if (this.customValidationEnabled) {
   this.isValid = isValid;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ASPxValidationType.PersonalViaScript);
  }
 },
 SetErrorText: function(errorText, validating){
  if (this.customValidationEnabled) {
   this.errorText = errorText;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ASPxValidationType.PersonalViaScript);
  }
 },
 Validate: function(){
  this.ParseValue();
  this.OnValidation(ASPxValidationType.PersonalViaScript);
 }
});
ASPxClientEdit.focusedEditorName = "";
ASPxClientEdit.GetFocusedEditor = function(){
 var focusedEditor = aspxGetControlCollection().Get(ASPxClientEdit.focusedEditorName);
 if(focusedEditor && !focusedEditor.focused){
  ASPxClientEdit.SetFocusedEditor(null);
  focusedEditor = null;
 }
 return focusedEditor;
}
ASPxClientEdit.SetFocusedEditor = function(editor){
 ASPxClientEdit.focusedEditorName = editor ? editor.name : "";
}
ASPxClientEdit.ClearEditorsInContainer = function(container, validationGroup, clearInvisibleEditors) {
 __aspxInvalidEditorToBeFocused = null;
 _aspxProcessEditorsInContainer(container, _aspxClearProcessingProc, _aspxClearChoiceCondition, validationGroup, clearInvisibleEditors, true );
 ASPxClientEdit.ClearExternalControlsInContainer(container, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ClearEditorsInContainerById = function(containerId, validationGroup, clearInvisibleEditors) {
 var container = document.getElementById(containerId);
 this.ClearEditorsInContainer(container, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ClearGroup = function(validationGroup, clearInvisibleEditors) {
 return this.ClearEditorsInContainer(null, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ValidateEditorsInContainer = function(container, validationGroup, validateInvisibleEditors) {
 var summaryCollection;
 if(typeof(ASPxClientValidationSummary) != "undefined") {
  summaryCollection = aspxGetClientValidationSummaryCollection();
  summaryCollection.AllowNewErrorsAccepting(validationGroup);
 }
 var validationResult = _aspxProcessEditorsInContainer(container, _aspxValidateProcessingProc, _aspxValidateChoiceCondition, validationGroup, validateInvisibleEditors,
  false );
 validationResult.isValid = ASPxClientEdit.ValidateExternalControlsInContainer(container, validationGroup, validateInvisibleEditors) && validationResult.isValid;
 if(typeof(aspxGetGlobalEvents) != "undefined") {
  if(typeof(validateInvisibleEditors) == "undefined")
   validateInvisibleEditors = false;
  if(typeof(validationGroup) == "undefined")
   validationGroup = null;
  validationResult.isValid = aspxGetGlobalEvents().OnValidationCompleted(container, validationGroup,
   validateInvisibleEditors, validationResult.isValid, validationResult.firstInvalid, validationResult.firstVisibleInvalid);
 }
 if(summaryCollection)
  summaryCollection.ForbidNewErrorsAccepting(validationGroup);
 return validationResult.isValid;
}
ASPxClientEdit.ValidateEditorsInContainerById = function(containerId, validationGroup, validateInvisibleEditors) {
 var container = document.getElementById(containerId);
 return this.ValidateEditorsInContainer(container, validationGroup, validateInvisibleEditors);
}
ASPxClientEdit.ValidateGroup = function(validationGroup, validateInvisibleEditors) {
 return this.ValidateEditorsInContainer(null, validationGroup, validateInvisibleEditors);
}
ASPxClientEdit.AreEditorsValid = function(containerOrContainerId, validationGroup, checkInvisibleEditors) {
 var container = typeof(containerOrContainerId) == "string" ? document.getElementById(containerOrContainerId) : containerOrContainerId;
 var checkResult = _aspxProcessEditorsInContainer(container, _aspxEditorsValidProcessingProc, _aspxEditorsValidChoiceCondition, validationGroup,
  checkInvisibleEditors, false );
 checkResult.isValid = ASPxClientEdit.AreExternalControlsValidInContainer(containerOrContainerId, validationGroup, checkInvisibleEditors) && checkResult.isValid;
 return checkResult.isValid;
}
ASPxClientEdit.AreExternalControlsValidInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if (typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.AreEditorsValidInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
ASPxClientEdit.ClearExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if (typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.ClearEditorsInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
ASPxClientEdit.ValidateExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if (typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.ValidateEditorsInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
ASPxClientEditKeyEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(htmlEvent) {
  this.constructor.prototype.constructor.call(this);
  this.htmlEvent = htmlEvent;
 }
});
ASPxClientEditValidationEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(value, errorText, isValid) {
  this.constructor.prototype.constructor.call(this);
  this.errorText = errorText;
  this.isValid = isValid;
  this.value = value;
 }
});
function aspxEGotFocus(name){
 var edit = aspxGetControlCollection().Get(name); 
 if(edit != null)
  edit.OnFocus();
}
function aspxELostFocus(name){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null) 
  edit.OnLostFocus();
}
function aspxESGotFocus(name){
 var edit = aspxGetControlCollection().Get(name); 
 if(edit != null)
  edit.OnSpecialFocus();
}
function aspxESLostFocus(name){
 var edit = aspxGetControlCollection().Get(name);
 if(edit == null)
  return;
 if(edit.UseDelayedSpecialFocus())
  edit.specialFocusTimer = window.setTimeout(function() { edit.OnSpecialLostFocus(); }, 30);
 else
  edit.OnSpecialLostFocus();
}
function aspxEValueChanged(name){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null)
  edit.OnValueChanged();
}
_aspxAttachEventToDocument("mousedown", aspxEMouseDown);
function aspxEMouseDown(evt) {
 var editor = ASPxClientEdit.GetFocusedEditor();
 if(!editor) 
  return;
 var evtSource = _aspxGetEventSource(evt);
 if(editor.OwnerDateEdit && editor.OwnerDateEdit.GetShowTimeSection()) {
  editor.OwnerDateEdit.ForceRefocusTimeSectionTimeEdit(evtSource);
  return;
 }
 if(editor.IsEditorElement(evtSource) && !editor.IsElementBelongToInputElement(evtSource))
  editor.ForceRefocusEditor();
}
_aspxAttachEventToDocument(__aspxNetscapeFamily ? "DOMMouseScroll" : "mousewheel", aspxEMouseWheel);
function aspxEMouseWheel(evt) {
 var editor = ASPxClientEdit.GetFocusedEditor();
 if (editor != null && _aspxIsExistsElement(editor.GetMainElement()) && editor.focused && editor.receiveGlobalMouseWheel)
  editor.OnMouseWheel(evt);
}
function aspxKBSIKeyDown(name, evt){
 var control = aspxGetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyDown(evt);
  if(isProcessed)
   return _aspxPreventEventAndBubble(evt);
 }
}
function aspxKBSIKeyPress(name, evt){
 var control = aspxGetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyPress(evt);
  if(isProcessed)
   return _aspxPreventEventAndBubble(evt);
 }
}
function aspxKBSIKeyUp(name, evt){
 var control = aspxGetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyUp(evt);
  if(isProcessed)
   return _aspxPreventEventAndBubble(evt);
 }
}
function aspxEKeyDown(name, evt){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null)
  edit.OnKeyDown(evt);
 if (__aspxAndroidMobilePlatform && __aspxChrome)
  aspxEKeyPress(name, evt);
}
function aspxEKeyPress(name, evt){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null)
  edit.OnKeyPress(evt);
}
function aspxEKeyUp(name, evt){
 var edit = aspxGetControlCollection().Get(name);
 if(edit != null)
  edit.OnKeyUp(evt);
}
ASPxValidationResult = _aspxCreateClass(null, {
 constructor: function(isValid, firstInvalid, firstVisibleInvalid) {
  this.isValid = isValid;
  this.firstInvalid = firstInvalid;
  this.firstVisibleInvalid = firstVisibleInvalid;
 }
});
function _aspxProcessEditorsInContainer(container, processingProc, choiceCondition, validationGroup, processInvisibleEditors, processDisabledEditors) {
 var allProcessedSuccessfull = true;
 var firstInvalid = null;
 var firstVisibleInvalid = null;
 var invalidEditorToBeFocused = null;
 aspxGetControlCollection().ForEachControl(function(control) {
  if (ASPxIdent.IsASPxClientEdit(control) && (processDisabledEditors || control.GetEnabled())) {
   var mainElement = control.GetMainElement();
   if (mainElement &&
    (container == null || _aspxGetIsParent(container, mainElement)) &&
    (processInvisibleEditors || control.IsVisible()) &&
    choiceCondition(control, validationGroup)) {
    var isSuccess = processingProc(control);
    if(!isSuccess) {
     allProcessedSuccessfull = false;
     if(firstInvalid == null)
      firstInvalid = control;
     var isVisible = control.IsVisible();
     if(isVisible && firstVisibleInvalid == null)
      firstVisibleInvalid = control;
     if (control.setFocusOnError && invalidEditorToBeFocused == null && isVisible)
      invalidEditorToBeFocused = control;
    }
   }
  }
 }, this);
 if (invalidEditorToBeFocused != null)
  invalidEditorToBeFocused.SetFocus();
 return new ASPxValidationResult(allProcessedSuccessfull, firstInvalid, firstVisibleInvalid);
}
function _aspxClearChoiceCondition(edit, validationGroup) {
 return !_aspxIsExists(validationGroup) || (edit.validationGroup == validationGroup);
}
function _aspxValidateChoiceCondition(edit, validationGroup) {
 return _aspxClearChoiceCondition(edit, validationGroup) && edit.customValidationEnabled;
}
function _aspxEditorsValidChoiceCondition(edit, validationGroup) {
 return _aspxValidateChoiceCondition(edit, validationGroup);
}
function _aspxClearProcessingProc(edit) {
 edit.SetValue(null);
 edit.SetIsValid(true);
 return true;
}
function _aspxValidateProcessingProc(edit) {
 edit.OnValidation(ASPxValidationType.MassValidation);
 return edit.GetIsValid();
}
function _aspxEditorsValidProcessingProc(edit) {
 return edit.GetIsValid();
}
ASPxCheckEditElementHelper = _aspxCreateClass(ASPxCheckableElementHelper, {
 AttachToMainElement: function(internalCheckBox) {
  ASPxCheckableElementHelper.prototype.AttachToMainElement.call(this, internalCheckBox);
  this.AttachToLabelElement(this.GetLabelElement(internalCheckBox.container), internalCheckBox);
 },
 AttachToLabelElement: function(labelElement, internalCheckBox) {
  var _this = this;
  if(labelElement) {
   _aspxAttachEventToElement(labelElement, "click", 
    function (evt) { 
     _this.InvokeClick(internalCheckBox, evt);
    }
   );
   _aspxAttachEventToElement(labelElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
  }
 },
 GetLabelElement: function(container) {
  return _aspxGetChildByTagName(container, "LABEL", 0);
 }
});
ASPxCheckEditElementHelper.Instance = new ASPxCheckEditElementHelper();
