var __aspxStateItemsExist = false;
var __aspxFocusedItemKind = "FocusedStateItem";
var __aspxHoverItemKind = "HoverStateItem";
var __aspxPressedItemKind = "PressedStateItem";
var __aspxSelectedItemKind = "SelectedStateItem";
var __aspxDisabledItemKind = "DisabledStateItem";
var __aspxCachedStatePrefix = "cached";
ASPxStateItem = _aspxCreateClass(null, {
 constructor: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink){
  this.name = name;
  this.classNames = classNames;
  this.customClassNames = [];
  this.resultClassNames = [];
  this.cssTexts = cssTexts;
  this.postfixes = postfixes;
  this.imageObjs = imageObjs;
  this.imagePostfixes = imagePostfixes;
  this.kind = kind;
  this.classNamePostfix = kind.substr(0, 1).toLowerCase();
  this.enabled = true;
  this.needRefreshBetweenElements = false;
  this.elements = null;
  this.images = null;
  this.linkColor = null;
  this.lintTextDecoration = null;
  this.disableApplyingStyleToLink = !!disableApplyingStyleToLink;
 },
 GetCssText: function(index){
  if(_aspxIsExists(this.cssTexts[index]))
   return this.cssTexts[index];
  return this.cssTexts[0];
 },
 CreateStyleRule: function(index){
  if(this.GetCssText(index) == "") return "";
  var styleSheet = _aspxGetCurrentStyleSheet();
  if(styleSheet)
   return _aspxCreateImportantStyleRule(styleSheet, this.GetCssText(index), this.classNamePostfix);  
  return ""; 
 },
 GetClassName: function(index){
  if(_aspxIsExists(this.classNames[index]))
   return this.classNames[index];
  return this.classNames[0];
 },
 GetResultClassName: function(index){
  if(!_aspxIsExists(this.resultClassNames[index])) {
   if(!_aspxIsExists(this.customClassNames[index]))
    this.customClassNames[index] = this.CreateStyleRule(index);
   if(this.GetClassName(index) != "" && this.customClassNames[index] != "")
    this.resultClassNames[index] = this.GetClassName(index) + " " + this.customClassNames[index];
   else if(this.GetClassName(index) != "")
    this.resultClassNames[index] = this.GetClassName(index);
   else if(this.customClassNames[index] != "")
    this.resultClassNames[index] = this.customClassNames[index];
   else
    this.resultClassNames[index] = "";
  }
  return this.resultClassNames[index];
 },
 GetElements: function(element){
  if(!this.elements || !_aspxIsValidElements(this.elements)){
   if(this.postfixes && this.postfixes.length > 0){
    this.elements = [ ];
    var parentNode = element.parentNode;
    if(parentNode){
     for(var i = 0; i < this.postfixes.length; i++){
      var id = this.name + this.postfixes[i];
      this.elements[i] = _aspxGetChildById(parentNode, id);
      if(!this.elements[i])
       this.elements[i] = _aspxGetElementById(id);
     }
    }
   }
   else
    this.elements = [element];
  }
  return this.elements;
 },
 GetImages: function(element){
  if(!this.images || !_aspxIsValidElements(this.images)){
   this.images = [ ];
   if(this.imagePostfixes && this.imagePostfixes.length > 0){
    var elements = this.GetElements(element);
    for(var i = 0; i < this.imagePostfixes.length; i++){
     var id = this.name + this.imagePostfixes[i];
     for(var j = 0; j < elements.length; j++){
      if(!elements[j]) continue;
      if(elements[j].id == id)
       this.images[i] = elements[j];
      else
       this.images[i] = _aspxGetChildById(elements[j], id);
      if(this.images[i])
       break;
     }
    }
   }
  }
  return this.images;
 },
 Apply: function(element){
  if(!this.enabled) return;
  try{
   this.ApplyStyle(element);
   if(this.imageObjs && this.imageObjs.length > 0)
    this.ApplyImage(element);
  }
  catch(e){
  }
 },
 ApplyStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   var className = elements[i].className.replace(this.GetResultClassName(i), "");
   elements[i].className = _aspxTrim(className) + " " + this.GetResultClassName(i);
   if(!__aspxOpera || __aspxBrowserVersion >= 9)
    this.ApplyStyleToLinks(elements, i);
  }
 },
 ApplyStyleToLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  var linkCount = 0;
  var savedLinkCount = -1;
  if(_aspxIsExists(elements[index]["savedLinkCount"]))
   savedLinkCount = parseInt(elements[index]["savedLinkCount"]);
  do{
   if(savedLinkCount > -1 && savedLinkCount <= linkCount)
    break;
   var link = elements[index]["link" + linkCount];
   if(!link){
    link = _aspxGetChildByTagName(elements[index], "A", linkCount);
    if(!link)
     link = _aspxGetChildByTagName(elements[index], "SPAN", linkCount); 
    if(link)
     elements[index]["link" + linkCount] = link;
   }
   if(link)
    this.ApplyStyleToLinkElement(link, index);
   else
    elements[index]["savedLinkCount"] = linkCount;
   linkCount++;
  }
  while(link != null)
 },
 ApplyStyleToLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   _aspxChangeAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color", this.GetLinkColor(index));
  if(this.GetLinkTextDecoration(index) != "")
   _aspxChangeAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration", this.GetLinkTextDecoration(index));
 },
 ApplyImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   if(_aspxIsAlphaFilterUsed(images[i]))   
    _aspxChangeAttributeExtended(images[i].style, "filter", images[i], "saved" + this.kind + "Filter", 
     "progid:DXImageTransform.Microsoft.AlphaImageLoader(src=" + this.imageObjs[i] + ", sizingMethod=scale)");    
   else{
    var useSpriteImage = typeof(this.imageObjs[i]) != "string";
    var newUrl = "", newCssClass = "", newBackground = "";
    if(useSpriteImage){
     newUrl = ASPx.EmptyImageUrl;           
     if(this.imageObjs[i].spriteCssClass) 
      newCssClass = this.imageObjs[i].spriteCssClass;
     if(this.imageObjs[i].spriteBackground)
      newBackground = this.imageObjs[i].spriteBackground;
    }
    else{
     newUrl = this.imageObjs[i];
     if(_aspxIsExistsAttribute(images[i].style, "background"))   
      newBackground = " ";
    }
    if(newUrl != "")
     _aspxChangeAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src", newUrl);
    if(newCssClass != "")
     this.ApplyImageClassName(images[i], newCssClass);
    if(newBackground != ""){
     if(__aspxWebKitFamily) {
      var savedBackground = _aspxGetAttribute(images[i].style, "background");
      if(!useSpriteImage)
       savedBackground += " " + images[i].style["backgroundPosition"];
      _aspxSetAttribute(images[i], "saved" + this.kind + "Background", savedBackground);
      _aspxSetAttribute(images[i].style, "background", newBackground);
     }
     else
      _aspxChangeAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background", newBackground);
    }     
   }
  }
 },
 ApplyImageClassName: function(element, newClassName){
  var className = element.className.replace(newClassName, "");
  _aspxSetAttribute(element, "saved" + this.kind + "ClassName", className);
  element.className = className + " " + newClassName;
 },
 Cancel: function(element){
  if(!this.enabled) return;
  try{  
   if(this.imageObjs && this.imageObjs.length > 0)
    this.CancelImage(element);
   this.CancelStyle(element);
  }
  catch(e){
  }
 },
 CancelStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   var className = _aspxTrim(elements[i].className.replace(this.GetResultClassName(i), ""));
   elements[i].className = className;
   if(!__aspxOpera || __aspxBrowserVersion >= 9)
    this.CancelStyleFromLinks(elements, i);
  }
 },
 CancelStyleFromLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  var linkCount = 0;
  var savedLinkCount = -1;
  if(_aspxIsExists(elements[index]["savedLinkCount"]))
   savedLinkCount = parseInt(elements[index]["savedLinkCount"]);
  do{
   if(savedLinkCount > -1 && savedLinkCount <= linkCount)
    break;
   var link = elements[index]["link" + linkCount];
   if(!link){
    link = _aspxGetChildByTagName(elements[index], "A", linkCount);
    if(!link)
     link = _aspxGetChildByTagName(elements[index], "SPAN", linkCount); 
    if(link)
     elements[index]["link" + linkCount] = link;
   }
   if(link)
    this.CancelStyleFromLinkElement(link, index);
   else
    elements[index]["savedLinkCount"] = linkCount;
   linkCount++;
  }
  while(link != null)
 },
 CancelStyleFromLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   _aspxRestoreAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color");
  if(this.GetLinkTextDecoration(index) != "")
   _aspxRestoreAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration");
 },
 CancelImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   if(_aspxIsAlphaFilterUsed(images[i]))
    _aspxRestoreAttributeExtended(images[i].style, "filter", images[i], "saved" + this.kind + "Filter");
   else{
    _aspxRestoreAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src");
    this.CancelImageClassName(images[i]);
    _aspxRestoreAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background");
   }
  }
 },
 CancelImageClassName: function(element){
  var savedClassName = _aspxGetAttribute(element, "saved" + this.kind + "ClassName");
  if(_aspxIsExists(savedClassName)) {
   element.className = savedClassName;
   _aspxRemoveAttribute(element, "saved" + this.kind + "ClassName");
  }
 },
 Clone: function(){
  return new ASPxStateItem(this.name, this.classNames, this.cssTexts, this.postfixes, 
   this.imageObjs, this.imagePostfixes, this.kind, this.disableApplyingStyleToLink);
 },
 IsChildElement: function(element){
  if(element != null){
   var elements = this.GetElements(element);
   for(var i = 0; i < elements.length; i++){
    if(!elements[i]) continue;
    if(_aspxGetIsParent(elements[i], element)) 
     return true;
   }
  }
  return false;
 },
 GetLinkColor: function(index){
  if(!_aspxIsExists(this.linkColor)){
   var rule = _aspxGetStyleSheetRule(this.customClassNames[index]);
   this.linkColor = rule ? rule.style.color : null;
   if(!_aspxIsExists(this.linkColor)){
    var rule = _aspxGetStyleSheetRule(this.GetClassName(index));
    this.linkColor = rule ? rule.style.color : null;
   }
   if(this.linkColor == null) 
    this.linkColor = "";
  }
  return this.linkColor;
 },
 GetLinkTextDecoration: function(index){
  if(!_aspxIsExists(this.linkTextDecoration)){
   var rule = _aspxGetStyleSheetRule(this.customClassNames[index]);
   this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   if(!_aspxIsExists(this.linkTextDecoration)){
    var rule = _aspxGetStyleSheetRule(this.GetClassName(index));
    this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   }
   if(this.linkTextDecoration == null) 
    this.linkTextDecoration = "";
  }
  return this.linkTextDecoration;
 }
});
ASPxClientStateEventArgs = _aspxCreateClass(null, {
 constructor: function(item, element){
  this.item = item;
  this.element = element;
  this.toElement = null;
  this.fromElement = null;
  this.htmlEvent = null;
 }
});
ASPxStateController = _aspxCreateClass(null, {
 constructor: function(){
  this.focusedItems = { };
  this.hoverItems = { };
  this.pressedItems = { };
  this.selectedItems = { };
  this.disabledItems = { };
  this.currentFocusedElement = null;
  this.currentFocusedItemName = null;
  this.currentHoverElement = null;
  this.currentHoverItemName = null;
  this.currentPressedElement = null;
  this.currentPressedItemName = null;
  this.savedCurrentPressedElement = null;
  this.savedCurrentMouseMoveSrcElement = null;
  this.AfterSetFocusedState = new ASPxClientEvent();
  this.AfterClearFocusedState = new ASPxClientEvent();
  this.AfterSetHoverState = new ASPxClientEvent();
  this.AfterClearHoverState = new ASPxClientEvent();
  this.AfterSetPressedState = new ASPxClientEvent();
  this.AfterClearPressedState = new ASPxClientEvent();
  this.AfterDisabled = new ASPxClientEvent();
  this.AfterEnabled = new ASPxClientEvent();
  this.BeforeSetFocusedState = new ASPxClientEvent();
  this.BeforeClearFocusedState = new ASPxClientEvent();
  this.BeforeSetHoverState = new ASPxClientEvent();
  this.BeforeClearHoverState = new ASPxClientEvent();
  this.BeforeSetPressedState = new ASPxClientEvent();
  this.BeforeClearPressedState = new ASPxClientEvent();
  this.BeforeDisabled = new ASPxClientEvent();
  this.BeforeEnabled = new ASPxClientEvent();
  this.FocusedItemKeyDown = new ASPxClientEvent();
 }, 
 AddHoverItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.hoverItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, __aspxHoverItemKind, disableApplyingStyleToLink);
  this.AddItem(this.focusedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, __aspxFocusedItemKind, disableApplyingStyleToLink);
 },
 AddPressedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes ,disableApplyingStyleToLink){
  this.AddItem(this.pressedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, __aspxPressedItemKind, disableApplyingStyleToLink);
 },
 AddSelectedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.selectedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, __aspxSelectedItemKind, disableApplyingStyleToLink);
 },
 AddDisabledItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.disabledItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, __aspxDisabledItemKind, disableApplyingStyleToLink);
 },
 AddItem: function(items, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind , disableApplyingStyleToLink){
  var stateItem = new ASPxStateItem(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink);
  if(postfixes && postfixes.length > 0){
   for(var i = 0; i < postfixes.length; i ++){
    items[name + postfixes[i]] = stateItem;
   }
  }
  else
   items[name] = stateItem;
  __aspxStateItemsExist = true;
 },
 RemoveHoverItem: function(name){
  this.RemoveItem(this.hoverItems, name);
  this.RemoveItem(this.focusedItems, name);
 },
 RemovePressedItem: function(name){
  this.RemoveItem(this.pressedItems, name);
 },
 RemoveSelectedItem: function(name){
  this.RemoveItem(this.selectedItems, name);
 },
 RemoveDisabledItem: function(name){
  this.RemoveItem(this.disabledItems, name);
 },
 RemoveItem: function(items, name){
  delete items[name];
 },
 GetFocusedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.focusedItems, __aspxFocusedItemKind);
 },
 GetHoverElement: function(srcElement){
  return this.GetItemElement(srcElement, this.hoverItems, __aspxHoverItemKind);
 },
 GetPressedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.pressedItems, __aspxPressedItemKind);
 },
 GetSelectedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.selectedItems, __aspxSelectedItemKind);
 },
 GetDisabledElement: function(srcElement){
  return this.GetItemElement(srcElement, this.disabledItems, __aspxDisabledItemKind);
 },
 GetItemElement: function(srcElement, items, kind){
  if(srcElement && srcElement[__aspxCachedStatePrefix + kind]){
   var cachedElement = srcElement[__aspxCachedStatePrefix + kind];
   if(cachedElement != __aspxEmptyCachedValue)
    return cachedElement;
   return null;
  }
  var element = srcElement;
  while(element != null) {
   var item = items[element.id];
   if(item){
    this.CacheItemElement(srcElement, kind, element);
    element[kind] = item;
    return element;
   }
   element = element.parentNode;
  }
  this.CacheItemElement(srcElement, kind, __aspxEmptyCachedValue);
  return null;
 },
 CacheItemElement: function(srcElement, kind, value){
  if(srcElement && !srcElement[__aspxCachedStatePrefix + kind])
   srcElement[__aspxCachedStatePrefix + kind] = value;
 },
 DoSetFocusedState: function(element, fromElement){
  var item = element[__aspxFocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetFocusedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetFocusedState.FireEvent(this, args);
  }
 },
 DoClearFocusedState: function(element, toElement){
  var item = element[__aspxFocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearFocusedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearFocusedState.FireEvent(this, args);
  }
 },
 DoSetHoverState: function(element, fromElement){
  var item = element[__aspxHoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetHoverState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetHoverState.FireEvent(this, args);
  }
 },
 DoClearHoverState: function(element, toElement){
  var item = element[__aspxHoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearHoverState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearHoverState.FireEvent(this, args);
  }
 },
 DoSetPressedState: function(element){
  var item = element[__aspxPressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeSetPressedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetPressedState.FireEvent(this, args);
  }
 },
 DoClearPressedState: function(element){
  var item = element[__aspxPressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeClearPressedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearPressedState.FireEvent(this, args);
  }
 },
 SetCurrentFocusedElement: function(element){
  if(this.currentFocusedElement && !_aspxIsValidElement(this.currentFocusedElement)){
   this.currentFocusedElement = null;
   this.currentFocusedItemName = "";
  }
  if(this.currentFocusedElement != element){
   var oldCurrentFocusedElement = this.currentFocusedElement;
   var item = (element != null) ? element[__aspxFocusedItemKind] : null;
   var itemName = (item != null) ? item.name : "";
   if(this.currentFocusedItemName != itemName){
    if(this.currentHoverItemName != "")
     this.SetCurrentHoverElement(null);
    if(this.currentFocusedElement != null)
     this.DoClearFocusedState(this.currentFocusedElement, element);
    this.currentFocusedElement = element;
    item = (element != null) ? element[__aspxFocusedItemKind] : null;
    this.currentFocusedItemName = (item != null) ? item.name : "";
    if(this.currentFocusedElement != null)
     this.DoSetFocusedState(this.currentFocusedElement, oldCurrentFocusedElement);
   }
  }
 },
 SetCurrentHoverElement: function(element){
  if(this.currentHoverElement && !_aspxIsValidElement(this.currentHoverElement)){
   this.currentHoverElement = null;
   this.currentHoverItemName = "";
  }
  var item = (element != null) ? element[__aspxHoverItemKind] : null;
  if(item && !item.enabled) { 
   element = this.GetItemElement(element.parentNode, this.hoverItems, __aspxHoverItemKind);
   item = (element != null) ? element[__aspxHoverItemKind] : null;
  }
  if(this.currentHoverElement != element){
   var oldCurrentHoverElement = this.currentHoverElement,
    itemName = (item != null) ? item.name : "";
   if(this.currentHoverItemName != itemName || (item != null && item.needRefreshBetweenElements)){
    if(this.currentFocusedItemName != "")
     this.SetCurrentFocusedElement(null);
    if(this.currentHoverElement != null)
     this.DoClearHoverState(this.currentHoverElement, element);
    item = (element != null) ? element[__aspxHoverItemKind] : null;
    if(item == null || item.enabled){
     this.currentHoverElement = element;
     this.currentHoverItemName = (item != null) ? item.name : "";
     if(this.currentHoverElement != null)
      this.DoSetHoverState(this.currentHoverElement, oldCurrentHoverElement);
    }
   }
  }
 },
 SetCurrentPressedElement: function(element){
  if(this.currentPressedElement && !_aspxIsValidElement(this.currentPressedElement)){
   this.currentPressedElement = null;
   this.currentPressedItemName = "";
  }
  if(this.currentPressedElement != element){
   if(this.currentPressedElement != null)
    this.DoClearPressedState(this.currentPressedElement);
   var item = (element != null) ? element[__aspxPressedItemKind] : null;
   if(item == null || item.enabled){
    this.currentPressedElement = element;
    this.currentPressedItemName = (item != null) ? item.name : "";
    if(this.currentPressedElement != null)
     this.DoSetPressedState(this.currentPressedElement);
   }
  }
 },
 SetCurrentFocusedElementBySrcElement: function(srcElement){
  var element = this.GetFocusedElement(srcElement);
  this.SetCurrentFocusedElement(element);
 },
 SetCurrentHoverElementBySrcElement: function(srcElement){
  var element = this.GetHoverElement(srcElement);
  this.SetCurrentHoverElement(element);
 },
 SetCurrentPressedElementBySrcElement: function(srcElement){
  var element = this.GetPressedElement(srcElement);
  this.SetCurrentPressedElement(element);
 },
 SetPressedElement: function (element) {
  this.SetCurrentHoverElement(null);
  this.SetCurrentPressedElementBySrcElement(element);
  this.savedCurrentPressedElement = this.currentPressedElement;
 },
 SelectElement: function (element) {
  var item = element[__aspxSelectedItemKind];
  if(item)
   item.Apply(element);
 }, 
 SelectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.SelectElement(element);
 }, 
 DeselectElement: function(element){
  var item = element[__aspxSelectedItemKind];
  if(item)
   item.Cancel(element);
 }, 
 DeselectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.DeselectElement(element);
 },
 SetElementEnabled: function(element, enable){
  if(enable)
   this.EnableElement(element);
  else
   this.DisableElement(element);
 },
 DisableElement: function(element){
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[__aspxDisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeDisabled.FireEvent(this, args);
    if(item.name == this.currentPressedItemName)
     this.SetCurrentPressedElement(null);
    if(item.name == this.currentHoverItemName)
     this.SetCurrentHoverElement(null);
    item.Apply(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, false);
    this.AfterDisabled.FireEvent(this, args);
   }
  }
 }, 
 EnableElement: function(element){
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[__aspxDisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeEnabled.FireEvent(this, args);
    item.Cancel(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, true);
    this.AfterEnabled.FireEvent(this, args);
   }
  }
 }, 
 SetMouseStateItemsEnabled: function(name, postfixes, enabled){   
  if(postfixes && postfixes.length > 0){
   for(var i = 0; i < postfixes.length; i ++){
    this.SetItemsEnabled(this.hoverItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.pressedItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.focusedItems, name + postfixes[i], enabled);
   }
  }
  else{
   this.SetItemsEnabled(this.hoverItems, name, enabled);
   this.SetItemsEnabled(this.pressedItems, name, enabled);
   this.SetItemsEnabled(this.focusedItems, name, enabled);
  }  
 },
 SetItemsEnabled: function(items, name, enabled){   
  if(items[name])
   items[name].enabled = enabled;
 },
 OnFocusMove: function(evt){
  var element = _aspxGetEventSource(evt);
  aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
 },
 OnMouseMove: function(evt, checkElementChanged){
  var srcElement = _aspxGetEventSource(evt);
  if(checkElementChanged && srcElement == this.savedCurrentMouseMoveSrcElement) return;
  this.savedCurrentMouseMoveSrcElement = srcElement;
  if(__aspxIE && !_aspxGetIsLeftButtonPressed(evt) && this.savedCurrentPressedElement != null)
   this.ClearSavedCurrentPressedElement();
  if(this.savedCurrentPressedElement == null)
   this.SetCurrentHoverElementBySrcElement(srcElement);
  else{
   var element = this.GetPressedElement(srcElement);
   if(element != this.currentPressedElement){
    if(element == this.savedCurrentPressedElement)
     this.SetCurrentPressedElement(this.savedCurrentPressedElement);
    else
     this.SetCurrentPressedElement(null);
   }
  }
 },
 OnMouseDown: function(evt){
  if(!_aspxGetIsLeftButtonPressed(evt)) return;
  var srcElement = _aspxGetEventSource(evt);
  this.OnMouseDownOnElement(srcElement);
 },
 OnMouseDownOnElement: function (element) {
  if (this.GetPressedElement(element) == null) return;
  this.SetPressedElement(element);
 },
 OnMouseUp: function(evt){
  var srcElement = _aspxGetEventSource(evt);
  this.OnMouseUpOnElement(srcElement);
 },
 OnMouseUpOnElement: function(element){
  if(this.savedCurrentPressedElement == null) return;
  this.ClearSavedCurrentPressedElement();
  this.SetCurrentHoverElementBySrcElement(element);
 },
 OnMouseOver: function(evt){
  var element = _aspxGetEventSource(evt);
  if (element && element.tagName == "IFRAME")
   this.OnMouseMove(evt, true);
 },
 OnKeyDown: function(evt){
  var element = this.GetFocusedElement(_aspxGetEventSource(evt));
  if(element != null && element == this.currentFocusedElement) {
   var item = element[__aspxFocusedItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    args.htmlEvent = evt;
    this.FocusedItemKeyDown.FireEvent(this, args);
   }
  }
 },
 OnSelectStart: function(evt){
  if(this.savedCurrentPressedElement) {
   _aspxClearSelection();
   return false;
  }
 },
 ClearSavedCurrentPressedElement: function() {
  this.savedCurrentPressedElement = null;
  this.SetCurrentPressedElement(null);
 },
 ClearCache: function(srcElement, kind) {
  if(srcElement[__aspxCachedStatePrefix + kind])
   srcElement[__aspxCachedStatePrefix + kind] = null;
 },
 ClearElementCache: function(srcElement) {
  this.ClearCache(srcElement, __aspxFocusedItemKind);
  this.ClearCache(srcElement, __aspxHoverItemKind);
  this.ClearCache(srcElement, __aspxPressedItemKind);
  this.ClearCache(srcElement, __aspxSelectedItemKind);
  this.ClearCache(srcElement, __aspxDisabledItemKind);
 }
});
var __aspxStateController = null;
function aspxGetStateController(){
 if(__aspxStateController == null)
  __aspxStateController = new ASPxStateController();
 return __aspxStateController;
}
function aspxAddStateItems(method, namePrefix, classes, disableApplyingStyleToLink){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][2].length; j ++) {
   var name = namePrefix;
   if(classes[i][2][j])
    name += "_" + classes[i][2][j];
   var postfixes = classes[i][3] || null;
   var imageObjs = (classes[i][4] && classes[i][4][j]) || null;
   var imagePostfixes = classes[i][5] || null;
   method.call(aspxGetStateController(), name, classes[i][0], classes[i][1], postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink);
  }
 }
}
function aspxAddHoverItems(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddHoverItem, namePrefix, classes, disableApplyingStyleToLink);
}
function aspxAddPressedItems(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddPressedItem, namePrefix, classes, disableApplyingStyleToLink);
}
function aspxAddSelectedItems(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddSelectedItem, namePrefix, classes, disableApplyingStyleToLink);
}
function aspxAddDisabledItems(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddDisabledItem, namePrefix, classes, disableApplyingStyleToLink);
}
function aspxRemoveStateItems(method, namePrefix, classes){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][0].length; j ++) {
   var name = namePrefix;
   if(classes[i][0][j])
    name += "_" + classes[i][0][j];
   method.call(aspxGetStateController(), name);
  }
 }
}
function aspxRemoveHoverItems(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveHoverItem, namePrefix, classes);
}
function aspxRemovePressedItems(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemovePressedItem, namePrefix, classes);
}
function aspxRemoveSelectedItems(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveSelectedItem, namePrefix, classes);
}
function aspxRemoveDisabledItems(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveDisabledItem, namePrefix, classes);
}
function aspxAddAfterClearFocusedState(handler){
 aspxGetStateController().AfterClearFocusedState.AddHandler(handler);
}
function aspxAddAfterSetFocusedState(handler){
 aspxGetStateController().AfterSetFocusedState.AddHandler(handler);
}
function aspxAddAfterClearHoverState(handler){
 aspxGetStateController().AfterClearHoverState.AddHandler(handler);
}
function aspxAddAfterSetHoverState(handler){
 aspxGetStateController().AfterSetHoverState.AddHandler(handler);
}
function aspxAddAfterClearPressedState(handler){
 aspxGetStateController().AfterClearPressedState.AddHandler(handler);
}
function aspxAddAfterSetPressedState(handler){
 aspxGetStateController().AfterSetPressedState.AddHandler(handler);
}
function aspxAddAfterDisabled(handler){
 aspxGetStateController().AfterDisabled.AddHandler(handler);
}
function aspxAddAfterEnabled(handler){
 aspxGetStateController().AfterEnabled.AddHandler(handler);
}
function aspxAddBeforeClearFocusedState(handler){
 aspxGetStateController().BeforeClearFocusedState.AddHandler(handler);
}
function aspxAddBeforeSetFocusedState(handler){
 aspxGetStateController().BeforeSetFocusedState.AddHandler(handler);
}
function aspxAddBeforeClearHoverState(handler){
 aspxGetStateController().BeforeClearHoverState.AddHandler(handler);
}
function aspxAddBeforeSetHoverState(handler){
 aspxGetStateController().BeforeSetHoverState.AddHandler(handler);
}
function aspxAddBeforeClearPressedState(handler){
 aspxGetStateController().BeforeClearPressedState.AddHandler(handler);
}
function aspxAddBeforeSetPressedState(handler){
 aspxGetStateController().BeforeSetPressedState.AddHandler(handler);
}
function aspxAddBeforeDisabled(handler){
 aspxGetStateController().BeforeDisabled.AddHandler(handler);
}
function aspxAddBeforeEnabled(handler){
 aspxGetStateController().BeforeEnabled.AddHandler(handler);
}
function aspxAddFocusedItemKeyDown(handler){
 aspxGetStateController().FocusedItemKeyDown.AddHandler(handler);
}
function aspxSetHoverState(element){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(element);
}
function aspxClearHoverState(evt){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(null);
}
function aspxUpdateHoverState(evt){
 aspxGetStateController().OnMouseMove(evt, false);
}
function aspxSetFocusedState(element){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
}
function aspxClearFocusedState(evt){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(null);
}
function aspxUpdateFocusedState(evt){
 aspxGetStateController().OnFocusMove(evt);
}
function aspxAssignAccessabilityEventsToChildrenLinks(container){
 var links = _aspxGetChildrenByPartialClassName(container, __aspxAccessibilityMarkerClass);
 for(var i = 0; i < links.length; i++)
  aspxAssignAccessabilityEventsToLink(links[i]);
}
function aspxAssignAccessabilityEventsToLink(link) {
 if (!_aspxElementCssClassContains(link, __aspxAccessibilityMarkerClass))
  return;
 _aspxAttachEventToElement(link, "focus", function(e) { aspxUpdateFocusedState(e); });
 _aspxAttachEventToElement(link, "blur", function(e) { aspxClearFocusedState(e); });
 if(__aspxIE && __aspxBrowserMajorVersion < 7 && link.href == __aspxAccessibilityEmptyUrl)
  _aspxAttachEventToElement(link, "click", function() { return false; });
}
_aspxAttachEventToDocument("mousemove", aspxClassesDocumentMouseMove);
function aspxClassesDocumentMouseMove(evt) {
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  aspxGetStateController().OnMouseMove(evt, true);
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseDownEventName, aspxClassesDocumentMouseDown);
function aspxClassesDocumentMouseDown(evt){
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  aspxGetStateController().OnMouseDown(evt);
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseUpEventName, aspxClassesDocumentMouseUp);
function aspxClassesDocumentMouseUp(evt){
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  aspxGetStateController().OnMouseUp(evt);
}
_aspxAttachEventToDocument("mouseover", aspxClassesDocumentMouseOver);
function aspxClassesDocumentMouseOver(evt){
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  aspxGetStateController().OnMouseOver(evt);
}
_aspxAttachEventToDocument("keydown", aspxClassesDocumentKeyDown);
function aspxClassesDocumentKeyDown(evt){
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  aspxGetStateController().OnKeyDown(evt);
}
_aspxAttachEventToDocument("selectstart", aspxClassesDocumentSelectStart);
function aspxClassesDocumentSelectStart(evt){
 if(__aspxClassesScriptParsed && __aspxStateItemsExist)
  return aspxGetStateController().OnSelectStart(evt); 
}

