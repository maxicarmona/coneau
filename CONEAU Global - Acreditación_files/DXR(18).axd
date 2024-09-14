var __aspxMIIdSuffix = "_DXI";
var __aspxMMIdSuffix = "_DXM";
var __aspxSBIdSuffix = "_DXSB";
var __aspxSBUIdEnd = "_U";
var __aspxSBDIdEnd = "_D";
ASPxClientMenuItemInfo = _aspxCreateClass(null, {
 constructor: function(menu, indexPath){
  if(menu.liteRender) {
   var itemElement = menu.GetItemElement(indexPath);
   this.clientHeight = itemElement.clientHeight;
   this.clientWidth = itemElement.clientWidth;
   this.clientTop = _aspxGetClientTop(itemElement);
   this.clientLeft = _aspxGetClientLeft(itemElement);
   this.offsetHeight = itemElement.offsetHeight;
   this.offsetWidth = itemElement.offsetWidth;
   this.offsetTop = 0;
   this.offsetLeft = 0;
  }
  else {
   this.clientHeight = 0;
   this.clientWidth = 0;
   this.clientTop = 0;
   this.clientLeft = 0;
   this.offsetHeight = 0;
   this.offsetWidth = 0;
   this.offsetTop = 0;
   this.offsetLeft = __aspxAbsoluteRightPosition;
   var imageElement = (indexPath != "") ? menu.GetItemImageCell(indexPath) : null;
   if(imageElement != null){
    this.clientWidth += imageElement.clientWidth;
    this.offsetWidth += imageElement.offsetWidth;
    if(this.clientLeft == 0) 
     this.clientLeft = _aspxGetClientLeft(imageElement);
    if(this.offsetLeft > imageElement.offsetLeft)
     this.offsetLeft = imageElement.offsetLeft;
   }
   var indentElement = (indexPath != "") ? menu.GetItemIndentCell(indexPath) : null;
   if(indentElement != null){
    this.clientWidth += indentElement.clientWidth;
    this.offsetWidth += indentElement.offsetWidth;
   }
   var textElement = (indexPath != "") ? menu.GetItemTextCell(indexPath) : null;
   if(textElement != null){ 
    this.clientWidth += textElement.clientWidth;
    this.offsetWidth += textElement.offsetWidth;
    if(this.clientLeft == 0) 
     this.clientLeft = _aspxGetClientLeft(textElement);
    if(this.offsetLeft > textElement.offsetLeft)
     this.offsetLeft = textElement.offsetLeft;
    this.clientTop = _aspxGetClientTop(textElement);
    this.offsetHeight += textElement.offsetHeight;
    this.offsetTop = textElement.offsetTop;
    this.clientHeight = textElement.clientHeight;
    if(__aspxSafari && __aspxBrowserVersion >= 3 || __aspxChrome){ 
     if(!menu.IsVertical(indexPath))
      this.clientHeight = _aspxWebKit3TDRealInfo.GetClientHeight(textElement);
     if(imageElement != null && this.clientHeight < imageElement.clientHeight) 
      this.clientHeight = imageElement.clientHeight;
    }
   }
   var popOutImageElement = (indexPath != "") ? menu.GetItemPopOutImageCell(indexPath) : null;
   if(popOutImageElement != null){
    this.clientWidth += popOutImageElement.clientWidth;
    this.offsetWidth += popOutImageElement.offsetWidth;
    if(this.clientLeft == 0) 
     this.clientLeft = _aspxGetClientLeft(popOutImageElement);
    if(this.offsetLeft > popOutImageElement.offsetLeft)
     this.offsetLeft = popOutImageElement.offsetLeft;
   }
  }
 }
});
ASPxClientMenuCssClasses = {};
ASPxClientMenuCssClasses.Prefix = "dxm-";
ASPxClientMenuCssClasses.Menu = "dxmLite";
ASPxClientMenuCssClasses.BorderCorrector = "dxmBrdCor";
ASPxClientMenuCssClasses.Disabled = ASPxClientMenuCssClasses.Prefix + "disabled";
ASPxClientMenuCssClasses.MainMenu = ASPxClientMenuCssClasses.Prefix + "main";
ASPxClientMenuCssClasses.PopupMenu = ASPxClientMenuCssClasses.Prefix + "popup";
ASPxClientMenuCssClasses.IE7 = ASPxClientMenuCssClasses.Prefix + "ie7";
ASPxClientMenuCssClasses.HorizontalMenu = ASPxClientMenuCssClasses.Prefix + "horizontal";
ASPxClientMenuCssClasses.VerticalMenu = ASPxClientMenuCssClasses.Prefix + "vertical";
ASPxClientMenuCssClasses.DX = "dx";
ASPxClientMenuCssClasses.Separator = ASPxClientMenuCssClasses.Prefix + "separator";
ASPxClientMenuCssClasses.Spacing = ASPxClientMenuCssClasses.Prefix + "spacing";
ASPxClientMenuCssClasses.Gutter = ASPxClientMenuCssClasses.Prefix + "gutter";
ASPxClientMenuCssClasses.WithoutImages = ASPxClientMenuCssClasses.Prefix + "noImages";
ASPxClientMenuCssClasses.Item = ASPxClientMenuCssClasses.Prefix + "item";
ASPxClientMenuCssClasses.ItemHovered = ASPxClientMenuCssClasses.Prefix + "hovered";
ASPxClientMenuCssClasses.ItemSelected = ASPxClientMenuCssClasses.Prefix + "selected";
ASPxClientMenuCssClasses.ItemChecked = ASPxClientMenuCssClasses.Prefix + "checked";
ASPxClientMenuCssClasses.ItemWithoutImage = ASPxClientMenuCssClasses.Prefix + "noImage";
ASPxClientMenuCssClasses.ItemWithSubMenu = ASPxClientMenuCssClasses.Prefix + "subMenu";
ASPxClientMenuCssClasses.ItemDropDownMode = ASPxClientMenuCssClasses.Prefix + "dropDownMode";
ASPxClientMenuCssClasses.ItemWithoutSubMenu = ASPxClientMenuCssClasses.Prefix + "noPopOut";
ASPxClientMenuCssClasses.HorizontalAlignCenter = ASPxClientMenuCssClasses.Prefix + "haCenter";
ASPxClientMenuCssClasses.HorizontalAlignCenterWrapper = ASPxClientMenuCssClasses.Prefix + "haWrapper";
ASPxClientMenuCssClasses.ContentContainer = ASPxClientMenuCssClasses.Prefix + "content";
ASPxClientMenuCssClasses.Image = ASPxClientMenuCssClasses.Prefix + "image";
ASPxClientMenuCssClasses.PopOutContainer = ASPxClientMenuCssClasses.Prefix + "popOut";
ASPxClientMenuCssClasses.PopOutImage = ASPxClientMenuCssClasses.Prefix + "pImage";
ASPxClientMenuCssClasses.ImageLeft = ASPxClientMenuCssClasses.Prefix + "image-l";
ASPxClientMenuCssClasses.ImageRight = ASPxClientMenuCssClasses.Prefix + "image-r";
ASPxClientMenuCssClasses.ImageTop = ASPxClientMenuCssClasses.Prefix + "image-t";
ASPxClientMenuCssClasses.ImageBottom = ASPxClientMenuCssClasses.Prefix + "image-b";
ASPxClientMenuCssClasses.ScrollArea = ASPxClientMenuCssClasses.Prefix + "scrollArea";
ASPxClientMenuCssClasses.ScrollUpButton = ASPxClientMenuCssClasses.Prefix + "scrollUpBtn";
ASPxClientMenuCssClasses.ScrollDownButton = ASPxClientMenuCssClasses.Prefix + "scrollDownBtn";
ASPxClientMenuLiteRenderHelper = {};
ASPxClientMenuLiteRenderHelper.InlineInitializeElements = function(menu) {
 if(!menu.isPopupMenu)
  this.InlineInitializeMainMenuElements(menu, menu.GetMainElement());
 var commonContainer = menu.GetMainElement().parentNode;
 if(!menu.isPopupMenu && __aspxIE && __aspxBrowserMajorVersion == 7)
  commonContainer = commonContainer.parentNode;
 var subMenuElements = this.GetNodesByTagName(commonContainer, "DIV");
 for(var i = 0; i < subMenuElements.length; i++) {
  if(!menu.isPopupMenu) {
   if(__aspxIE && __aspxBrowserMajorVersion == 7) {
    if(subMenuElements[i] == menu.GetMainElement().parentNode)
     continue;
   }
   else if(subMenuElements[i] == menu.GetMainElement())
    continue;
  }
  this.InlineInitializeSubMenuElements(menu, subMenuElements[i]);
 }
};
ASPxClientMenuLiteRenderHelper.FindNodes = function(node, match) {
 var result = [];
 for(var i = 0; i < node.childNodes.length; i++) {
  var childNode = node.childNodes[i];
  if(!childNode.tagName)
   continue;
  if(match(childNode))
   result.push(childNode);
 }
 return result;
};
ASPxClientMenuLiteRenderHelper.GetNodesByTagName = function(node, tagName) {
 return this.FindNodes(node, function(childNode) {
  return childNode.tagName == tagName;
 });
};
ASPxClientMenuLiteRenderHelper.GetNodesByClassName = function(node, className) {
 return this.FindNodes(node, function(childNode) {
  return _aspxElementCssClassContains(childNode, className);
 });
};
ASPxClientMenuLiteRenderHelper.GetNodeByClassName = function(node, childNodeClassName) {
 var nodes = this.GetNodesByClassName(node, childNodeClassName);
 return nodes.length > 0 ? nodes[0] : null;
};
ASPxClientMenuLiteRenderHelper.InlineInitializeScrollElements = function(menu, indexPath, menuElement) {
 var scrollArea = this.GetNodeByClassName(menuElement, ASPxClientMenuCssClasses.ScrollArea);
 if(scrollArea) scrollArea.id = menu.GetScrollAreaId(indexPath);
 var scrollUpButton = this.GetNodeByClassName(menuElement, ASPxClientMenuCssClasses.ScrollUpButton);
 if(scrollUpButton) scrollUpButton.id = menu.GetScrollUpButtonId(indexPath);
 var scrollDownButton = this.GetNodeByClassName(menuElement, ASPxClientMenuCssClasses.ScrollDownButton);
 if(scrollDownButton) scrollDownButton.id = menu.GetScrollDownButtonId(indexPath);
};
ASPxClientMenuLiteRenderHelper.InlineInitializeMainMenuElements = function(menu, menuElement) {
 var contentElement = _aspxGetChildByTagName(menuElement, "UL", 0);
 var itemElements = this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Item);
 for(var i = 0; i < itemElements.length; i++)
  this.InlineInitializeItemElement(menu, itemElements[i], "", i);
 this.InlineInitializeScrollElements(menu, "", menuElement);
};
ASPxClientMenuLiteRenderHelper.PrepareSpacingAndSeparators = function(menu, menuElement) {
 if(!menu.IsVisible()) return;
 var indexPath = menu.GetMenuIndexPathById(menuElement.id);
 if(menu.IsVertical(indexPath)) return;
 var contentElement = _aspxGetChildByTagName(menuElement, "UL", 0);
 var itemElements = this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Item);
 if(!itemElements[0]) return;
 var spaceElements = this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Separator);
 spaceElements = spaceElements.concat(
  this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Spacing)
 );
 for(var i = 0; i < spaceElements.length; i++)
  spaceElements[i].style.height = itemElements[0].offsetHeight + "px";
};
ASPxClientMenuLiteRenderHelper.ProsessRightFloatElements = function(contentElement, action) {
 var raw = _aspxGetChildrenByPartialClassName(contentElement, ASPxClientMenuCssClasses.Prefix).concat([ contentElement ]);
 var list = [ ];
 for(var i = 0; i < raw.length; i++) {
  if(raw[i].offsetWidth < 1 || _aspxGetElementFloat(raw[i]) != "right")
   continue;
  list.push(raw[i]);
 }
 var directionChanged;
 if(contentElement.className == ASPxClientMenuCssClasses.DX && 
  contentElement.tagName.toUpperCase() == "DIV" && _aspxGetElementDirection(contentElement) == "rtl") {
  _aspxSetElementDirection(contentElement, "ltr");
  directionChanged = true;
 }
 for(var i = 0; i < list.length; i++)  
  _aspxSetElementFloat(list[i], "left");   
 action(list);
 for(var i = 0; i < list.length; i++)
  _aspxSetElementFloat(list[i], "");
 if(directionChanged)
  _aspxSetElementDirection(contentElement, "rtl");
};
ASPxClientMenuLiteRenderHelper.FreezeElementSizes = function(elements) {
 for(var i = 0; i < elements.length; i++)
  elements[i].style.width = elements[i].offsetWidth - _aspxGetLeftRightBordersAndPaddingsSummaryValue(elements[i]) + "px";
};
ASPxClientMenuLiteRenderHelper.InlineInitializeSubMenuElements = function(menu, parentElement) {
 parentElement.style.position = "absolute";
 var indexPath = menu.GetMenuIndexPathById(parentElement.id);
 var borderCorrectorElement = this.GetNodeByClassName(parentElement, ASPxClientMenuCssClasses.BorderCorrector);
 if(borderCorrectorElement != null) {
  borderCorrectorElement.id = menu.GetMenuBorderCorrectorElementId(indexPath);
  borderCorrectorElement.style.position = "absolute";
  parentElement.removeChild(borderCorrectorElement);
  parentElement.parentNode.appendChild(borderCorrectorElement);
 }
 this.InlineInitializeSubMenuMenuElement(menu, parentElement);
};
ASPxClientMenuLiteRenderHelper.InlineInitializeSubMenuMenuElement = function(menu, parentElement) {
 var menuElement = this.GetNodeByClassName(parentElement, ASPxClientMenuCssClasses.PopupMenu);
 var indexPath = menu.GetMenuIndexPathById(parentElement.id);
 menuElement.id = menu.GetMenuMainElementId(indexPath);
 var contentElement = _aspxGetChildByTagName(menuElement, "UL", 0); 
 if(contentElement != null) {
  var itemElements = this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Item);
  var parentIndexPath = parentElement == menu.GetMainElement() ? "" : indexPath;
  for(var i = 0; i < itemElements.length; i++)
   this.InlineInitializeItemElement(menu, itemElements[i], parentIndexPath, i);
 }
 this.InlineInitializeScrollElements(menu, indexPath, menuElement);
};
ASPxClientMenuLiteRenderHelper.PrepareSubMenuSize = function(menu, parentElement) {
 var widthPrepared = _aspxGetAttribute(parentElement, "widthPrepared") == "true"; 
 var menuElement = menu.GetMenuMainCell(parentElement); 
 var contentElement = this.GetContentElement(menuElement);
 _aspxSetStylePosition(parentElement, __aspxAbsoluteLeftPosition, __aspxInvalidPosition);
 var savedDisplay = parentElement.style.display;
 parentElement.style.display = "";
 parentElement.style.width = "";
 parentElement.style.height = "";
 if(widthPrepared)
  menuElement.style.width = "";
 var itemElements = this.GetNodesByClassName(contentElement, ASPxClientMenuCssClasses.Item);
 var contentWidth;
 if(__aspxIE && __aspxBrowserVersion < 8) {  
  this.ProsessRightFloatElements(contentElement, function(elements) {
   if(menu.rtl)
    ASPxClientMenuLiteRenderHelper.FreezeElementSizes(elements);   
   contentWidth = contentElement.offsetWidth;
  });
  if(contentElement.tagName == "UL") {
   contentElement.style.height = "";
   contentElement.style.height = contentElement.offsetHeight + "px";
  }
 }
 if(__aspxIE && __aspxBrowserVersion > 8) { 
  var isTemplate = contentElement.tagName != "UL" || !_aspxGetChildrenByPartialClassName(contentElement, ASPxClientMenuCssClasses.ContentContainer).length;
  if(!isTemplate)
   var contentWidth = ASPxClientMenuLiteRenderHelper.GetContentOffsetWidth(menuElement, contentElement);
 }
 menuElement.style.width = (contentWidth || contentElement.offsetWidth) + "px";
 if(contentElement.style.width !== "")
  contentElement.style.width = menuElement.style.width;   
 parentElement.style.display = savedDisplay;
 if(!widthPrepared)
  _aspxSetAttribute(parentElement, "widthPrepared", "true");
};
ASPxClientMenuLiteRenderHelper.GetContentOffsetWidth = function(menuElement, contentElement) { 
 var contentWidth = 0;
 for(var item = contentElement.firstChild; item; item = item.nextSibling) {
  if(item.nodeType == 1 && _aspxElementCssClassContains(item, ASPxClientMenuCssClasses.Item)) {
   var curItemStyle = _aspxGetCurrentStyle(item);
   var itemWidth = 0;
   itemWidth += _aspxPxToInt(curItemStyle.paddingLeft) + _aspxPxToInt(curItemStyle.paddingRight);
   itemWidth += _aspxPxToInt(curItemStyle.borderLeftWidth) + _aspxPxToInt(curItemStyle.borderRightWidth);
   for(var child = item.firstChild; child; child = child.nextSibling) {
    if(child.tagName == "DIV") {
     var curChildStyle = _aspxGetCurrentStyle(child);
     itemWidth += _aspxPxToInt(curChildStyle.marginLeft) + _aspxPxToInt(curChildStyle.marginRight);
     itemWidth += child.offsetWidth;
    }
   }
   contentWidth = contentWidth > itemWidth ? contentWidth : itemWidth + 1;
  }
 }
 var curStyle = _aspxGetCurrentStyle(menuElement);
 contentWidth += _aspxPxToInt(curStyle.paddingLeft) + _aspxPxToInt(curStyle.paddingRight);
 contentWidth += _aspxPxToInt(curStyle.borderLeftWidth) + _aspxPxToInt(curStyle.borderRightWidth);
 return contentWidth;
};
ASPxClientMenuLiteRenderHelper.GetContentElement = function(menuElement) {
 var contentElement = _aspxGetChildByTagName(menuElement, "DIV", 0); 
 if( contentElement &&
  contentElement.className == ASPxClientMenuCssClasses.DX &&
  contentElement.parentNode == menuElement)
  return contentElement;
 contentElement = _aspxGetChildByTagName(menuElement, "UL", 0);
 if(contentElement)
  return contentElement;
 return _aspxGetChildByTagName(menuElement, "TABLE", 0);
};
ASPxClientMenuLiteRenderHelper.InlineInitializeItemElement = function(menu, itemElement, parentIndexPath, visibleIndex) {
 function getItemIndex(visibleIndex) {
  var itemData = parentItemData[Math.max(visibleIndex, 0)];
  return itemData.constructor == Array
   ? itemData[0]
   : itemData;
 }
 var parentItemData = menu.liteRenderData[parentIndexPath],
  prepareItemOnClick = parentItemData[visibleIndex].constructor == Array,
  indexPathPrefix = parentIndexPath + (parentIndexPath != "" ? __aspxItemIndexSeparator : ""),
  indexPath = indexPathPrefix + getItemIndex(visibleIndex),
  prevIndexPath = indexPathPrefix + getItemIndex(visibleIndex - 1);
 itemElement.id = menu.GetItemElementId(indexPath);
 aspxAssignAccessabilityEventsToChildrenLinks(itemElement);
 var separatorElement = itemElement.previousSibling;
 if(separatorElement && separatorElement.className) {
  if(_aspxElementCssClassContains(separatorElement, ASPxClientMenuCssClasses.Spacing))
   separatorElement.id = menu.GetItemIndentElementId(prevIndexPath);
  else if(_aspxElementCssClassContains(separatorElement, ASPxClientMenuCssClasses.Separator))
   separatorElement.id = menu.GetItemSeparatorElementId(indexPath);
 }
 var contentElementParent = itemElement;
 if(_aspxElementCssClassContains(itemElement, ASPxClientMenuCssClasses.HorizontalAlignCenter))
  contentElementParent = this.GetNodeByClassName(itemElement, ASPxClientMenuCssClasses.HorizontalAlignCenterWrapper);
 var contentElement = this.GetNodeByClassName(contentElementParent, ASPxClientMenuCssClasses.ContentContainer);
 if(contentElement != null) {
  contentElement.id = menu.GetItemTextCellId(indexPath);
  var imageElement = this.GetNodeByClassName(contentElement, ASPxClientMenuCssClasses.Image);
  if(imageElement == null) {
   var hyperLinkElement = this.GetNodeByClassName(contentElement, ASPxClientMenuCssClasses.DX);
   if(hyperLinkElement != null)
    imageElement = this.GetNodeByClassName(hyperLinkElement, ASPxClientMenuCssClasses.Image);
  }
  if(imageElement != null)
   imageElement.id = menu.GetItemImageId(indexPath);
 }
 else
  prepareItemOnClick = false;
 var popOutElement = this.GetNodeByClassName(itemElement, ASPxClientMenuCssClasses.PopOutContainer);
 if(popOutElement != null) {
  popOutElement.id = menu.GetItemPopOutImageCellId(indexPath);
  var popOutImageElement = this.GetNodeByClassName(popOutElement, ASPxClientMenuCssClasses.PopOutImage);
  if(popOutImageElement != null)
   popOutImageElement.id = menu.GetItemPopOutImageId(indexPath);
 }
 if(prepareItemOnClick)
  this.InlineInitializeItemOnClick(menu, itemElement, indexPath);
};
ASPxClientMenuLiteRenderHelper.InlineInitializeItemOnClick = function(menu, itemElement, indexPath) {
 var name = menu.name;
 var onclick = this.GetItemOnClick(menu, name, itemElement, indexPath);
 if(menu.IsDropDownItem(indexPath)) {
  var contentElement = menu.GetItemTextCell(indexPath);
  var dropDownElement = menu.GetItemPopOutImageCell(indexPath);
  var dropDownOnclick = this.GetItemDropdownOnClick(name, itemElement, indexPath);
  _aspxAttachEventToElement(contentElement, "click", onclick);
  _aspxAttachEventToElement(dropDownElement, "click", dropDownOnclick);
 }
 else
  _aspxAttachEventToElement(itemElement, "click", onclick);
 if(itemElement.style.cursor == "")
  itemElement.style.cursor = "pointer";
};
ASPxClientMenuLiteRenderHelper.GetItemOnClick = function (menu, name, itemElement, indexPath) { 
 var sendPostBackHandler = function () {
  menu.SendPostBack("CLICK:" + indexPath);
 };
 var itemClickHandler = function(e) {
  aspxMIClick(e, name, indexPath);
 };
 var handler = menu.autoPostBack && !menu.IsClientSideEventsAssigned() && !_aspxGetChildByTagName(itemElement, "A", 0)
  ? sendPostBackHandler
  : itemClickHandler;
 return function (e) {
  if (!itemElement.clientDisabled)
   handler(e);
 };
};
ASPxClientMenuLiteRenderHelper.GetItemDropdownOnClick = function(name, itemElement, indexPath) {
 return function(e) {
  if(!itemElement.clientDisabled)
   aspxMIDDClick(e, name, indexPath);
 };
};
ASPxClientMenuLiteRenderHelper.ChangeItemEnabledAttributes = function(itemElement, enabled) {
 if(itemElement) {
  itemElement.clientDisabled = !enabled;
  _aspxChangeStyleAttributesMethod(enabled)(itemElement, "cursor");
  var hyperLink = _aspxGetChildByTagName(itemElement, "A", 0);
  if(hyperLink)
   _aspxChangeAttributesMethod(enabled)(hyperLink, "href");
 }
};
ASPxClientMenuScrollHelper = _aspxCreateClass(null, {
 constructor: function(menu, indexPath) {
  this.menu = menu;
  this.indexPath = indexPath;
  this.scrollingAreaElement = null;
  this.manager = null;
  this.initialized = false;
  this.visibleItems = [];
  this.itemsHeight = 0;
  this.scrollHeight = 0;
  this.scrollUpButtonHeight = 0;
  this.scrollDownButtonHeight = 0;
  this.scrollAreaHeight = null;
  this.scrollUpButtonVisible = false;
  this.scrollDownButtonVisible = false;
 },
 Initialize: function(){
  if(this.initialized) return;
  this.scrollingAreaElement = this.menu.GetScrollContentItemsOuterContainer(this.indexPath);
  var vector = [ 0, 1 ];
  this.manager = new ASPxScrollingManager(this, this.scrollingAreaElement, vector, 
   function(manager, direction){
    manager.owner.OnBeforeScrolling(direction);
   }, 
   function(manager, direction){
    manager.owner.OnAfterScrolling(direction);
   }
  );
  this.ShowScrollButtons();
  var scrollUpButton = this.menu.GetScrollUpButtonElement(this.indexPath);
  if(scrollUpButton){
   this.scrollUpButtonHeight = this.GetScrollButtonHeight(scrollUpButton)
   _aspxSetElementSelectionEnabled(scrollUpButton, false);
  }
  var scrollDownButton = this.menu.GetScrollDownButtonElement(this.indexPath);
  if(scrollDownButton){
   this.scrollDownButtonHeight = this.GetScrollButtonHeight(scrollDownButton);
   _aspxSetElementSelectionEnabled(scrollDownButton, false);
  }
  if(__aspxWebKitTouchUI){
   var preventDefault = function(event){event.preventDefault();};
   _aspxAttachEventToElement(scrollUpButton, "touchstart", preventDefault);
   _aspxAttachEventToElement(scrollDownButton, "touchstart", preventDefault);
  }
  this.HideScrollButtons();
  this.initialized = true;  
 },
 GetScrollButtonHeight: function(button) {
  var style = _aspxGetCurrentStyle(button);
  return button.offsetHeight + _aspxPxToInt(style.marginTop) + _aspxPxToInt(style.marginBottom);
 },
 FillVisibleItemsList: function(){
  var index = 0;
  this.visibleItems = [];
  while(true){
   var childIndexPath = (this.indexPath != "" ? this.indexPath + __aspxItemIndexSeparator : "") + index;
   var itemElement = this.menu.GetItemElement(childIndexPath);
   if(itemElement == null)
    break;
   if(_aspxGetElementDisplay(itemElement))
    this.visibleItems.push(itemElement);
   index++;
  }
 },
 CanCalculate: function(){
  return this.scrollingAreaElement && _aspxElementIsDisplayed(this.scrollingAreaElement);
 },
 Calculate: function(scrollHeight){
  if(!this.CanCalculate()) return;
  this.FillVisibleItemsList();
  this.itemsHeight = 0;
  this.scrollHeight = scrollHeight;
  var itemsContainer = this.menu.GetScrollContentItemsContainer(this.indexPath);
  if(itemsContainer) this.itemsHeight = itemsContainer.offsetHeight;
  this.SetPosition(0);
  this.CalculateScrollingElements(-1);
 },
 GetPosition: function(){
  return -this.manager.GetScrolledAreaPosition();
 },
 SetPosition: function(pos){
  this.manager.SetScrolledAreaPosition(-pos);
 },
 CalculateScrollingElements: function(direction){
  if(this.itemsHeight <= this.scrollHeight){
   this.scrollUpButtonVisible = false;
   this.scrollDownButtonVisible = false;
   this.scrollAreaHeight = null;
   this.SetPosition(0);
  }
  else{
   var scrollTop = this.GetPosition();
   this.scrollAreaHeight = this.scrollHeight;
   if(direction > 0){
    var showScrollUpButton = !this.scrollUpButtonVisible;
    this.scrollUpButtonVisible = true;
    this.scrollAreaHeight -= this.scrollUpButtonHeight;
    this.scrollDownButtonVisible = this.itemsHeight - this.scrollAreaHeight - scrollTop > this.scrollDownButtonHeight;
    if(this.scrollDownButtonVisible) {
     this.scrollAreaHeight -= this.scrollDownButtonHeight;
     if(showScrollUpButton)
      this.SetPosition(this.GetPosition() + this.scrollUpButtonHeight);
    }
    else {
     this.SetPosition(this.itemsHeight - this.scrollAreaHeight);
    }
   }
   else{
    this.scrollDownButtonVisible = true;
    this.scrollAreaHeight -= this.scrollDownButtonHeight;    
    this.scrollUpButtonVisible = scrollTop > this.scrollUpButtonHeight;
    if(this.scrollUpButtonVisible)
     this.scrollAreaHeight -= this.scrollUpButtonHeight;
    else
     this.SetPosition(0);
   }
   if(this.scrollAreaHeight < 1) this.scrollAreaHeight = 1;
  }
  this.UpdateScrollingElements();
 },
 UpdateScrollingElements: function(){
  this.UpdateScrollAreaHeight();
  this.UpdateScrollButtonsVisibility();
 },
 UpdateScrollAreaHeight: function() {
  var scrollAreaElement = this.menu.GetScrollAreaElement(this.indexPath);
  if(scrollAreaElement) 
   scrollAreaElement.style.height = (this.scrollAreaHeight) ? (this.scrollAreaHeight + "px") : "";
 },
 UpdateScrollButtonsVisibility: function() {
  var scrollUpButton = this.menu.GetScrollUpButtonElement(this.indexPath);
  if(scrollUpButton) _aspxSetElementDisplay(scrollUpButton, this.scrollUpButtonVisible);
  var scrollDownButton = this.menu.GetScrollDownButtonElement(this.indexPath);
  if(scrollDownButton) _aspxSetElementDisplay(scrollDownButton, this.scrollDownButtonVisible);
 },
 ChangeScrollButtonsVisibility: function(visible) {
  this.scrollUpButtonVisible = visible;
  this.scrollDownButtonVisible = visible;
  this.UpdateScrollButtonsVisibility();
 },
 ShowScrollButtons: function() {
  this.ChangeScrollButtonsVisibility(true);
 },
 HideScrollButtons: function() {
  this.ChangeScrollButtonsVisibility(false);
 },
 ResetScrolling: function() {
  if(!this.initialized)
   return;
  this.HideScrollButtons();
  this.SetPosition(0);
  this.scrollAreaHeight = null;
  this.UpdateScrollAreaHeight();
 },
 GetScrollAreaHeight: function() {
  var scrollAreaElement = this.menu.GetScrollAreaElement(this.indexPath);
  if(scrollAreaElement)
   return scrollAreaElement.offsetHeight;
  return 0;
 },
 OnAfterScrolling: function(direction){
  this.CalculateScrollingElements(direction);
 },
 OnBeforeScrolling: function(direction){
  var scrollButton = (direction > 0) ? this.menu.GetScrollDownButtonElement(this.indexPath) :
   this.menu.GetScrollUpButtonElement(this.indexPath);
  if(!scrollButton || !_aspxGetElementDisplay(scrollButton))
   this.manager.StopScrolling();
 },
 StartScrolling: function(direction, delay, step) {
  this.manager.StartScrolling(direction, delay, step);
 },
 StopScrolling: function() {
  this.manager.StopScrolling();
 }
});
ASPxClientMenuScrollHelper.GetMenuByScrollButtonId = function(id){
 var menuName = aspxGetMenuCollection().GetMenuNameBySuffixes(id, [__aspxSBIdSuffix]);
 return aspxGetMenuCollection().Get(menuName);
}
ASPxClientMenuBase = _aspxCreateClass(ASPxClientControl, {
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.liteRender = false;
  this.createIFrames = false;
  this.liteRenderData = null;
  this.allowSelectItem = false;
  this.allowCheckItems = false;
  this.allowMultipleCallbacks = false;
  this.appearAfter = 300;
  this.animationDelay = 30;
  this.animationMaxDelay = 400;
  this.disappearAfter = 500;
  this.enableAnimation = true;
  this.checkedItems = [ ];
  this.itemCheckedGroups = [ ];
  this.lockHoverEvents = false;
  this.popupToLeft = false;
  this.popupCount = 0;
  this.rootItem = null;
  this.showSubMenus = false;
  this.savedCallbackHoverItem = null;
  this.savedCallbackHoverElement = null;
  this.scrollInfo = [];
  this.scrollHelpers = {};
  this.scrollVertOffset = 1;
  this.rootSubMenuFIXOffset = 0;
  this.rootSubMenuFIYOffset = 0;
  this.rootSubMenuLIXOffset = 0;
  this.rootSubMenuLIYOffset = 0;
  this.rootSubMenuXOffset = 0;
  this.rootSubMenuYOffset = 0;
  this.subMenuFIXOffset = 0;
  this.subMenuFIYOffset = 0;
  this.subMenuLIXOffset = 0;
  this.subMenuLIYOffset = 0;
  this.subMenuXOffset = 0;
  this.subMenuYOffset = 0;
  this.sizingConfig.allowSetHeight = false;
  this.shadowVisible = true;
  this.ItemClick = new ASPxClientEvent();
  this.ItemMouseOver = new ASPxClientEvent();
  this.ItemMouseOut = new ASPxClientEvent();
  this.PopUp = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  aspxGetMenuCollection().Add(this);
 }, 
 Initialize: function(){
  this.constructor.prototype.Initialize.call(this);
  if(this.liteRender) {
   var main = this.GetMainElement();
   if(__aspxIE && __aspxBrowserMajorVersion < 8 && this.rtl && _aspxElementCssClassContains(main, ASPxClientMenuCssClasses.HorizontalMenu))
    ASPxClientMenuLiteRenderHelper.ProsessRightFloatElements(main, ASPxClientMenuLiteRenderHelper.FreezeElementSizes);
   ASPxClientMenuLiteRenderHelper.PrepareSpacingAndSeparators(this, main);
  }
 },   
 InlineInitialize: function(){
  if (this.liteRender) { 
   ASPxClientMenuLiteRenderHelper.InlineInitializeElements(this);
   if(__aspxIE && __aspxBrowserMajorVersion == 7) {
    var mainElement = this.GetMainElement();
    var width = _aspxPxToInt(mainElement.style.width);
    if(width > 0) {
     var currentStyle = _aspxGetCurrentStyle(mainElement);
     width -= _aspxPxToInt(currentStyle.paddingLeft) + _aspxPxToInt(currentStyle.paddingRight);
     width -= _aspxPxToInt(currentStyle.borderLeftWidth) + _aspxPxToInt(currentStyle.borderRightWidth);
     if(width > 0)
      mainElement.style.width = width + "px";
    }
   }
  }
  this.InitializeInternal(true);
  if(this.IsCallbacksEnabled()){
   this.showSubMenus = this.GetLoadingPanelElement() != null;
   this.CreateCallback("DXMENUCONTENT");
  }
  else 
   this.showSubMenus = true;
  this.popupToLeft = this.rtl;
 },
 InitializeInternal: function(inline) {
  this.InitializeCheckedItems();
  this.InitializeSelectedItem();
  this.InitializeEnabledAndVisible(!inline || !this.IsCallbacksEnabled());
  if(!this.IsCallbacksEnabled())
   this.InitializeScrollableMenus();
 },
 InitializeEnabledAndVisible: function(recursive){
  if(this.rootItem == null) return;
  for(var i = 0; i < this.rootItem.items.length; i++)
   this.rootItem.items[i].InitializeEnabledAndVisible(recursive);
 },
 InitializeScrollableMenus: function() {
  var info = eval(this.scrollInfo);
  this.scrollHelpers = {};
  for(var i = 0; i < info.length; i++)
   this.scrollHelpers[info[i]] = new ASPxClientMenuScrollHelper(this, info[i]);
 },
 IsClientSideEventsAssigned: function() {
  return !this.ItemClick.IsEmpty()
   || !this.ItemMouseOver.IsEmpty()
   || !this.ItemMouseOut.IsEmpty()
   || !this.PopUp.IsEmpty()
   || !this.CloseUp.IsEmpty();
 },
 IsCallbacksEnabled: function(){
  return _aspxIsFunction(this.callBack);
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 }, 
 GetMenuElementId: function(indexPath) {
  return this.name + __aspxMMIdSuffix + indexPath + "_";
 },
 GetMenuMainElementId: function(indexPath) {
  return this.name + (this.liteRender ? "_DXME" : "_DXMST") + indexPath + "_";
 },
 GetMenuBorderCorrectorElementId: function(indexPath) {
  return this.name + "_DXMBC" + indexPath + "_";
 },
 GetMenuIFrameElementId: function(indexPath) {
  return this.name + "_DXMIF" + this.GetMenuLevel(indexPath);
 },
 GetScrollAreaId: function(indexPath) {
  return this.name + "_DXSA" + indexPath;
 },
 GetMenuTemplateContainerID: function(indexPath) {
  return this.name + "_MTCNT" + indexPath;
 },
 GetScrollUpButtonId: function(indexPath) {
  return this.name + __aspxSBIdSuffix + indexPath + __aspxSBUIdEnd;
 },
 GetScrollDownButtonId: function(indexPath) {
  return this.name + __aspxSBIdSuffix + indexPath + __aspxSBDIdEnd;
 },
 GetItemElementId: function(indexPath) {
  return this.name + __aspxMIIdSuffix + indexPath + "_";
 },
 GetItemTextCellId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "T";
 },
 GetItemPopOutImageCellId: function(indexPath){
  return this.GetItemElementId(indexPath) + "P";
 },
 GetItemImageId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "Img";
 },
 GetItemPopOutImageId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "PImg";
 },
 GetItemIndentElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "II";
 },
 GetItemSeparatorElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "IS";
 },
 GetMenuElement: function(indexPath){
  return _aspxGetElementById(this.GetMenuElementId(indexPath));
 },
 GetMenuIFrameElement: function(indexPath){
  var elementId = this.GetMenuIFrameElementId(indexPath);
  var element = _aspxGetElementById(elementId);
  if(!element && this.createIFrames)
   return this.CreateIFrameElement(elementId);
  return element;
 },
 CreateIFrameElement: function(elementId) {
  var element = document.createElement("IFRAME");
  _aspxSetAttribute(element, "id", elementId);
  _aspxSetAttribute(element, "src", "javascript:false");
  _aspxSetAttribute(element, "scrolling", "no");
  _aspxSetAttribute(element, "frameborder", "0");
  element.style.position = "absolute";
  element.style.display = "none";
  element.style.zIndex = "19997";
  element.style.filter = "progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=0)";
  _aspxInsertElementAfter(element, this.GetMainElement());
  return element;
 },
 GetMenuBorderCorrectorElement: function(indexPath){
  return _aspxGetElementById(this.GetMenuBorderCorrectorElementId(indexPath));
 },
 GetMenuMainCell: function(element){
  var menuMainTable = this.GetMenuMainTable(element);
  if(this.liteRender)
   return menuMainTable;
  return this.liteRender ? menuMainTable : menuMainTable.rows[0].cells[this.rtl && this.shadowVisible ? 1 : 0];
 },
 GetMenuMainTable: function(element){
  var indexPath = this.GetIndexPathById(element.id, true);
  var shadowTable = _aspxGetElementById(this.GetMenuMainElementId(indexPath));
  return shadowTable != null ? shadowTable : element;
 },
 GetScrollAreaElement: function(indexPath){
  return _aspxGetElementById(this.GetScrollAreaId(indexPath));
 },
 GetScrollContentItemsOuterContainer: function(indexPath){
  return this.liteRender ? _aspxGetChildByTagName(this.GetScrollAreaElement(indexPath), "UL", 0) : 
   _aspxGetChildByTagName(this.GetScrollAreaElement(indexPath), "TABLE", 0);
 },
 GetScrollContentItemsContainer: function(indexPath){
  return this.liteRender ? _aspxGetChildByTagName(this.GetScrollAreaElement(indexPath), "UL", 0) : 
   _aspxGetChildByTagName(this.GetScrollAreaElement(indexPath), "TBODY", 0);
 },
 GetScrollUpButtonElement: function(indexPath){
  return _aspxGetElementById(this.GetScrollUpButtonId(indexPath));
 },
 GetScrollDownButtonElement: function(indexPath){
  return _aspxGetElementById(this.GetScrollDownButtonId(indexPath));
 },
 GetItemElement: function(indexPath){
  return _aspxGetElementById(this.GetItemElementId(indexPath));
 },
 GetItemTemplateCell: function(indexPath){ 
  return this.GetItemTextTemplateContainer(indexPath);
 },
 GetItemTemplateContainer: function(indexPath) {
  return this.liteRender
   ? this.GetItemElement(indexPath)
   : this.GetItemTextCell(indexPath);
 },
 GetItemTextTemplateContainer: function(indexPath) {
  return this.liteRender
   ? this.GetItemTextCell(indexPath)
   : _aspxGetElementById(this.GetItemElementId(indexPath) + "ITC");
 },
 GetItemImageCell: function(indexPath){
  if(!this.liteRender)
   return _aspxGetElementById(this.GetItemElementId(indexPath) + "I");
  else
   return this.GetItemTextCell(indexPath);
 },
 GetItemIndentCell: function(indexPath){
  return _aspxGetElementById(this.GetItemElementId(indexPath) + "N");
 },
 GetItemTextCell: function(indexPath){
  return _aspxGetElementById(this.GetItemTextCellId(indexPath));
 },
 GetItemPopOutImageCell: function(indexPath){
  return _aspxGetElementById(this.GetItemPopOutImageCellId(indexPath));
 },
 GetItemTextOrImageCell: function(indexPath){
  var element = this.GetItemTextCell(indexPath);
  if(element == null)
   element = this.GetItemImageCell(indexPath);
  return element;
 },
 GetSelectedItemInputElement: function(){
  return _aspxGetElementById(this.name + "SI");
 },
 GetCheckedItemsInputElement: function(){
  return _aspxGetElementById(this.name + "CI");
 },
 GetSubMenuXPosition: function(indexPath) {
  var pos = this.liteRender ? 
   this.GetLiteSubMenuXPosition(indexPath) :
   this.GetClassicSubMenuXPosition(indexPath);
  if(__aspxWebKitFamily && !this.IsParentElementPositionStatic(indexPath))
   pos -= document.body.offsetLeft;
  return pos;
 },
 GetClassicSubMenuXPosition: function(indexPath){
  var position = 0;
  var imageElement = this.GetItemImageCell(indexPath);
  var textElement = this.GetItemTextCell(indexPath);
  var popOutImageElement = this.GetItemPopOutImageCell(indexPath);
  var imagePos = _aspxGetAbsoluteX(imageElement);
  var textPos = _aspxGetAbsoluteX(textElement);
  var popOutImagePos = _aspxGetAbsoluteX(popOutImageElement);
  if(imageElement != null || textElement != null || popOutImageElement != null){
   var element = null;
   var updatePositionFunc;
   if(this.IsVertical(indexPath)) {
    position = __aspxAbsoluteLeftPosition;
    updatePositionFunc = function(element_, elementPos) {
     if(element_ != null && elementPos > position) {
      position = elementPos;
      element = element_;
     }
    };
   }
   else {
    position = __aspxAbsoluteRightPosition;
    updatePositionFunc = function(element_, elementPos) {
     if(element_ != null && elementPos < position ) {
      position = elementPos;
      element = element_;
     }
    };
   }
   updatePositionFunc(imageElement, imagePos);
   updatePositionFunc(textElement, textPos);
   updatePositionFunc(popOutImageElement, popOutImagePos);
   if(this.IsVertical(indexPath))
    position += element.clientWidth;
  }
  return position;
 },
 GetLiteSubMenuXPosition: function(indexPath) {
  var itemElement = this.GetItemElement(indexPath);
  return _aspxGetAbsoluteX(itemElement)
   + (this.IsVertical(indexPath) ? itemElement.clientWidth + itemElement.clientLeft : 0);
 },
 GetSubMenuYPosition: function(indexPath){
  var position = 0;
  var element = this.liteRender
   ? this.GetItemElement(indexPath)
   : this.GetItemTextOrImageCell(indexPath);
  if(element != null){
   if(this.IsVertical(indexPath)){
    position = _aspxGetAbsoluteY(element); 
   }
   else{
    if(__aspxNetscapeFamily || __aspxOpera && __aspxBrowserVersion >= 9 || __aspxSafari && __aspxBrowserVersion >= 3 || __aspxChrome)
     position = _aspxGetAbsoluteY(element) + element.offsetHeight - _aspxGetClientTop(element);
    else if(__aspxWebKitFamily)
     position = _aspxGetAbsoluteY(element) + element.offsetHeight + element.offsetTop - _aspxGetClientTop(element);
    else
     position = _aspxGetAbsoluteY(element) + element.clientHeight + _aspxGetClientTop(element);
   }
  }
  if(__aspxWebKitFamily && !this.IsParentElementPositionStatic(indexPath))
   position -= document.body.offsetTop;
  return position;
 },
 GetClientSubMenuXPosition: function(element, x, indexPath){
  var itemInfo = new ASPxClientMenuItemInfo(this, indexPath);
  var itemWidth = itemInfo.clientWidth;
  var itemOffsetWidth = itemInfo.offsetWidth;
  var subMenuWidth = this.GetMenuMainCell(element).offsetWidth;
  var docClientWidth = _aspxGetDocumentClientWidth();
  if(this.IsVertical(indexPath)){
   var left = x - _aspxGetDocumentScrollLeft();
   var right = left + subMenuWidth;
   var toLeftX = x - subMenuWidth - itemWidth;
   var toLeftLeft = left - subMenuWidth - itemWidth;
   var toLeftRight = right - subMenuWidth - itemWidth;
   if(this.popupToLeft){
    if(toLeftLeft < 0 && toLeftLeft < docClientWidth - right){
     this.popupToLeft = false;
     return x;
    }
    else
     return toLeftX;
   }
   else{
    if(docClientWidth - right < 0 && docClientWidth - right < toLeftLeft){
     this.popupToLeft = true;
     return toLeftX;
    }
    else
     return x;
   }
  }
  else{
   var left = x - _aspxGetDocumentScrollLeft();
   var right = left + subMenuWidth + this.GetShadowWidth();
   var toLeftX = x - subMenuWidth + itemOffsetWidth;
   var toLeftLeft = left - subMenuWidth + itemOffsetWidth;
   var toLeftRight = right - subMenuWidth + itemOffsetWidth;
   if(this.popupToLeft){
    if(toLeftLeft < 0 && toLeftLeft < docClientWidth - right){
     this.popupToLeft = false;
     return x;
    }
    else
     return toLeftX;
   }
   else{
    if(docClientWidth - right < 0 && docClientWidth - right < toLeftLeft){
     this.popupToLeft = true;
     return toLeftX;
     }
     else
     return x;
   }
  }
 },
 GetClientSubMenuYPosition: function(element, y, indexPath){
  var itemInfo = new ASPxClientMenuItemInfo(this, indexPath);
  var itemHeight = itemInfo.offsetHeight;
  var itemOffsetHeight = itemInfo.offsetHeight;
  var subMenuHeight = this.GetMenuMainCell(element).offsetHeight;
  var menuItemTop = y - _aspxGetDocumentScrollTop();
  var subMenuBottom = menuItemTop + subMenuHeight;
  var docClientHeight = _aspxGetDocumentClientHeight();
  var clientSubMenuYPos = y;  
  if(this.IsVertical(indexPath)){
   var notEnoughSpaceToShowDown = subMenuBottom > docClientHeight;
   var menuItemBottom = menuItemTop + itemHeight;
   if(menuItemBottom > docClientHeight) {
    menuItemBottom = docClientHeight;
    itemHeight = menuItemBottom - menuItemTop;
   }
   var notEnoughSpaceToShowUp = menuItemBottom < subMenuHeight;
   var subMenuIsFitToDisplayFrames = docClientHeight >= subMenuHeight;  
   if (!subMenuIsFitToDisplayFrames) clientSubMenuYPos = y - menuItemTop;
   else if(notEnoughSpaceToShowDown){
    if (notEnoughSpaceToShowUp){   
     var docClientBottom = _aspxGetDocumentScrollTop() + docClientHeight;
     clientSubMenuYPos = docClientBottom - this.GetShadowHeight() - subMenuHeight; 
    } else 
     clientSubMenuYPos =  y + itemHeight - subMenuHeight;
   }   
  }
  else{
   if(subMenuBottom > docClientHeight && menuItemTop - subMenuHeight - itemHeight > docClientHeight - subMenuBottom)
    clientSubMenuYPos = y - subMenuHeight - itemHeight;
  }
  return clientSubMenuYPos;
 },
 GetShadowWidth: function(){
  return this.shadowVisible ? __aspxPopupShadowWidth : 0;
 },
 GetShadowHeight: function(){
  return this.shadowVisible ? __aspxPopupShadowHeight : 0;
 },
 HasChildren: function(indexPath){
  return (this.GetMenuElement(indexPath) != null);
 },
 IsVertical: function(indexPath){
  return true;
 },
 IsRootItem: function(indexPath){
  return this.GetMenuLevel(indexPath) <= 1;
 },
 IsParentElementPositionStatic: function(indexPath){
  return this.IsRootItem(indexPath);
 },
 GetItemIndexPath: function(indexes){
  return aspxGetMenuCollection().GetItemIndexPath(indexes);
 },
 GetItemIndexes: function(indexPath){
  return aspxGetMenuCollection().GetItemIndexes(indexPath);
 },
 GetItemIndexPathById: function(id){
  return aspxGetMenuCollection().GetIndexPathById(id, __aspxMIIdSuffix);
 },
 GetMenuIndexPathById: function(id){
  return aspxGetMenuCollection().GetIndexPathById(id, __aspxMMIdSuffix);
 },
 GetScrollButtonIndexPathById: function(id){
  return aspxGetMenuCollection().GetIndexPathById(id, __aspxSBIdSuffix);
 },
 GetIndexPathById: function(id, checkMenu){
  var indexPath = this.GetItemIndexPathById(id);
  if(indexPath == "" && checkMenu) 
   indexPath = this.GetMenuIndexPathById(id);
  return indexPath;
 },
 GetMenuLevel: function(indexPath){
  return aspxGetMenuCollection().GetMenuLevel(indexPath);
 },
 GetParentIndexPath: function(indexPath){
  var indexes = this.GetItemIndexes(indexPath);
  indexes.length --;
  return (indexes.length > 0) ? this.GetItemIndexPath(indexes) : ""; 
 },
 GetFirstChildIndexPath: function(indexPath){
  var indexes = this.GetItemIndexes(indexPath);
  indexes[indexes.length] = 0;
  var newIndexPath = this.GetItemIndexPath(indexes); 
  return this.GetFirstSiblingIndexPath(newIndexPath);
 },
 GetFirstSiblingIndexPath: function(indexPath){
  var indexes = this.GetItemIndexes(indexPath);
  var i = 0;
  while(true){
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.GetItemIndexPath(indexes); 
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsItemExistAndEnabled(newIndexPath))
    return newIndexPath;
   i++;
  }
  return null;
 },
 GetLastSiblingIndexPath: function(indexPath){
  var indexes = this.GetItemIndexes(indexPath);
  var newIndexPath = null;
  var i = indexes[indexes.length - 1] + 1;
  while(true){  
   indexes[indexes.length - 1] = i;
   var nextIndexPath = this.GetItemIndexPath(indexes); 
   if(!this.IsItemExist(nextIndexPath))
    return newIndexPath;
   if(this.IsItemExistAndEnabled(nextIndexPath))
    newIndexPath = nextIndexPath;
   i++;
  }
  return null;
 },
 GetNextSiblingIndexPath: function(indexPath){
  if(this.IsLastItem(indexPath)) return null;
  var indexes = this.GetItemIndexes(indexPath);
  var i = indexes[indexes.length - 1] + 1;
  while(true){  
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.GetItemIndexPath(indexes); 
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsItemExistAndEnabled(newIndexPath))
    return newIndexPath;
   i++;
  }
  return null;
 },
 GetPrevSiblingIndexPath: function(indexPath){
  if(this.IsFirstItem(indexPath)) return null;
  var indexes = this.GetItemIndexes(indexPath);
  var i = indexes[indexes.length - 1] - 1;
  while(true){  
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.GetItemIndexPath(indexes); 
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsItemExistAndEnabled(newIndexPath))
    return newIndexPath;
   i--;
  }
  return null;
 },
 IsLastElement: function(element){
  return element && (!element.nextSibling || !element.nextSibling.tagName);
 },
 IsLastItem: function(indexPath){
  if(this.IsVertical(indexPath) || this.liteRender){
   var itemElement = this.GetItemElement(indexPath);
   return this.IsLastElement(itemElement);
  } 
  else{
   var imageCell = this.GetItemImageCell(indexPath);
   if(this.IsLastElement(imageCell))
    return true;
   var textCell = this.GetItemTextCell(indexPath);
   if(this.IsLastElement(textCell))
    return true;
   var popOutImageCell = this.GetItemPopOutImageCell(indexPath);
   if(this.IsLastElement(popOutImageCell))
    return true;
   return false;
  }
 },
 IsFirstElement: function(element){
  return element && (!element.previousSibling || !element.previousSibling.tagName);
 },
 IsFirstItem: function(indexPath){
  if(this.IsVertical(indexPath) || this.liteRender){
   var itemElement = this.GetItemElement(indexPath);
   return this.IsFirstElement(itemElement);
  } 
  else{
   var imageCell = this.GetItemImageCell(indexPath);
   if(this.IsFirstElement(imageCell))
    return true;
   var textCell = this.GetItemTextCell(indexPath);
   if(this.IsFirstElement(textCell))
    return true;
   var popOutImageCell = this.GetItemPopOutImageCell(indexPath);
   if(this.IsFirstElement(popOutImageCell))
    return true;
   return false;
  }
 },
 IsItemExist: function(indexPath){
  return !!this.GetItemTextOrImageCell(indexPath);
 },
 IsItemExistAndEnabled: function(indexPath){
  if(this.liteRender) {
   var itemElement = this.GetItemElement(indexPath);
   return itemElement && !itemElement.clientDisabled;
  }
  else {
   var cell = this.GetItemTextOrImageCell(indexPath);
   if(cell){
    var link = _aspxGetChildByTagName(cell, "A", 0);
    if(link)
     return !_aspxIsExists(cell.enabled) || cell.enabled;
   }
   return false;
  }
 },
 GetClientSubMenuPos: function(element, indexPath, pos, isXPos){
  if (!_aspxGetIsValidPosition(pos)){
   pos = isXPos ? this.GetSubMenuXPosition(indexPath) : 
    this.GetSubMenuYPosition(indexPath);
  }
  var clientPos = isXPos ? this.GetClientSubMenuXPosition(element, pos, indexPath) :
   this.GetClientSubMenuYPosition(element, pos, indexPath);
  var isInverted = pos != clientPos;
  var offset = isXPos ? this.GetSubMenuXOffset(indexPath) : this.GetSubMenuYOffset(indexPath);
  clientPos += isInverted ? - offset : offset;
  clientPos -= _aspxGetPositionElementOffset(this.GetMenuElement(indexPath), isXPos);
  return new _aspxPopupPosition(clientPos, isInverted);
 },
 GetSubMenuXOffset: function(indexPath){
  if(indexPath == "")
   return 0;
  else if(this.IsRootItem(indexPath)){
   if(this.IsFirstItem(indexPath))
    return this.rootSubMenuFIXOffset;
   else if(this.IsLastItem(indexPath))
    return this.rootSubMenuLIXOffset;
   else
    return this.rootSubMenuXOffset;
  }
  else{
   if(this.IsFirstItem(indexPath))
    return this.subMenuFIXOffset;
   else if(this.IsLastItem(indexPath))
    return this.subMenuLIXOffset;
   else
    return this.subMenuXOffset;
  }
 },
 GetSubMenuYOffset: function(indexPath){
  if(indexPath == "")
   return 0;
  else if(this.IsRootItem(indexPath)){
   if(this.IsFirstItem(indexPath))
    return this.rootSubMenuFIYOffset;
   else if(this.IsLastItem(indexPath))
    return this.rootSubMenuLIYOffset;
   else
    return this.rootSubMenuYOffset;
  }
  else{
   if(this.IsFirstItem(indexPath))
    return this.subMenuFIYOffset;
   else if(this.IsLastItem(indexPath))
    return this.subMenuLIYOffset;
   else
    return this.subMenuYOffset;
  }
 },
 StartScrolling: function(buttonId, delay, step) {
  var indexPath = this.GetScrollButtonIndexPathById(buttonId);
  var level = this.GetMenuLevel(indexPath);
  aspxGetMenuCollection().DoHidePopupMenus(null, level, this.name, false, "");
  var direction = (buttonId.lastIndexOf(__aspxSBDIdEnd) == buttonId.length - __aspxSBDIdEnd.length) ? 1 : -1;
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) scrollHelper.StartScrolling(direction, delay, step);
 },
 StopScrolling: function(buttonId) {
  var indexPath = this.GetScrollButtonIndexPathById(buttonId);
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) scrollHelper.StopScrolling();
 },
 ClearAppearTimer: function(){
  aspxGetMenuCollection().ClearAppearTimer();
 },
 ClearDisappearTimer: function(){
  aspxGetMenuCollection().ClearDisappearTimer();
 },
 IsAppearTimerActive: function(){
  return aspxGetMenuCollection().IsAppearTimerActive();
 },
 IsDisappearTimerActive: function(){
  return aspxGetMenuCollection().IsDisappearTimerActive();
 },
 SetAppearTimer: function(indexPath){
  aspxGetMenuCollection().SetAppearTimer(this.name, indexPath, this.appearAfter);
 },
 SetDisappearTimer: function(){
  aspxGetMenuCollection().SetDisappearTimer(this.name, this.disappearAfter);
 },
 IsDropDownItem: function(indexPath){
  if(this.liteRender)
   return _aspxElementCssClassContains(this.GetItemElement(indexPath), ASPxClientMenuCssClasses.ItemDropDownMode);
  else {
   var element = this.GetItemPopOutImageCell(indexPath);
   if(element && element.onclick)
    return element.onclick.toString().indexOf("aspxMIDDClick") > -1;
   return false;
  }
 },
 DoItemClick: function(indexPath, hasItemLink, htmlEvent){
  var processOnServer = this.RaiseItemClick(indexPath, htmlEvent);
  if(processOnServer && !hasItemLink)
   this.SendPostBack("CLICK:" + indexPath);
  else{
   this.ClearDisappearTimer();
   this.ClearAppearTimer();
   if(!this.HasChildren(indexPath) || this.IsDropDownItem(indexPath))
    aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
   else if(this.IsItemEnabled(indexPath) && !this.IsDropDownItem(indexPath))
    this.ShowSubMenu(indexPath);
  }
 },
 HasContent: function(mainCell) {
  for(var i = 0; i < mainCell.childNodes.length; i++)
   if(mainCell.childNodes[i].tagName)
    return true;
  return false;
 },
 DoShowPopupMenu: function(element, x, y, indexPath){
  if(element && this.IsCallbacksEnabled())
   this.ShowLoadingPanelInMenu(element);
  if(this.liteRender)
   ASPxClientMenuLiteRenderHelper.PrepareSubMenuSize(this, element);
  _aspxSetStylePosition(element, __aspxInvalidPosition, __aspxInvalidPosition);
  _aspxSetElementDisplay(element, true);
  if(this.popupCount == 0) this.popupToLeft = this.rtl;
  var horizontalPopupPosition = this.GetClientSubMenuPos(element, indexPath, x, true);
  var verticalPopupPosition = this.GetClientSubMenuPos(element, indexPath, y, false);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  var toTheLeft = horizontalPopupPosition.isInverted;
  var toTheTop = verticalPopupPosition.isInverted;
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) {
   var yClientCorrection = this.GetScrollSubMenuYCorrection(element, scrollHelper, clientY);
   if(yClientCorrection > 0) {
    clientY += yClientCorrection;
    verticalPopupPosition.position = clientY;
   }
  }
  var parentElement = this.GetItemTextOrImageCell(indexPath);
  var prevParentPos = _aspxGetAbsoluteX(parentElement);
  _aspxSetStylePosition(element, clientX, clientY);
  if(__aspxIE && __aspxBrowserMajorVersion > 7 && _aspxIsElementRightToLeft(document.body)) {
   _aspxSetElementDisplay(element, false);   
   _aspxSetElementDisplay(element, true);   
  }
  clientX += _aspxGetAbsoluteX(parentElement) - prevParentPos;
  if (this.enableAnimation){
   this.StartAnimation(element, indexPath, horizontalPopupPosition, verticalPopupPosition);
  }
  else{
   _aspxSetStylePosition(element, clientX, clientY);
   _aspxSetElementVisibility(element, true);
   this.DoShowPopupMenuIFrame(element, clientX, clientY, __aspxInvalidDimension, __aspxInvalidDimension, indexPath);
   this.DoShowPopupMenuBorderCorrector(element, clientX, clientY, indexPath, toTheLeft, toTheTop);
  }
  aspxGetMenuCollection().RegisterVisiblePopupMenu(this.name, element.id);
  this.popupCount ++;
  aspxGetControlCollection().AdjustControls(element);
  this.RaisePopUp(indexPath);
 },
 ShowLoadingPanelInMenu: function(element) {
  var mainCell = this.GetMenuMainCell(element);
  if(mainCell && !this.HasContent(mainCell))
   this.CreateLoadingPanelInsideContainer(mainCell);
 },
 GetScrollSubMenuYCorrection: function(element, scrollHelper, clientY) {
  var absoluteClientY = clientY + _aspxGetPositionElementOffset(element);
  var excessTop = this.GetScrollExcessTop(absoluteClientY);
  var excessBottom = this.GetScrollExcessBottom(element, absoluteClientY);
  var correction = 0;
  if(excessTop > 0)
   correction += excessTop + this.scrollVertOffset;
  if(excessBottom > 0 && (absoluteClientY + correction == _aspxGetDocumentScrollTop())) {
   excessBottom += this.scrollVertOffset;
   correction += this.scrollVertOffset;
  }
  this.PrepareScrolling(element, scrollHelper, excessTop, excessBottom);
  return correction;
 },
 GetScrollExcessTop: function(clientY) {
  return _aspxGetDocumentScrollTop() - clientY;
 },
 GetScrollExcessBottom: function(element, clientY) {
  _aspxSetElementDisplay(element, false);
  var docHeight = _aspxGetDocumentClientHeight();
  _aspxSetElementDisplay(element, true);
  return clientY + element.offsetHeight - _aspxGetDocumentScrollTop() - docHeight;  
 },
 PrepareScrolling: function(element, scrollHelper, excessTop, excessBottom) {  
  scrollHelper.Initialize();
  var corrector = element.offsetHeight - scrollHelper.GetScrollAreaHeight() + this.scrollVertOffset;
  if(excessTop > 0)
   scrollHelper.Calculate(element.offsetHeight - excessTop - corrector);
  if(excessBottom > 0)
   scrollHelper.Calculate(element.offsetHeight - excessBottom - corrector);
 },
 DoShowPopupMenuIFrame: function(element, x, y, width, height, indexPath){
  if (!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(!iFrame) {
   iFrame = this.GetMenuIFrameElement(indexPath);
   element.overflowElement = iFrame;
  }
  if(iFrame) {
   var cell = this.GetMenuMainCell(element);
   if (width < 0)
    width = cell.offsetWidth;
   if (height < 0)
    height = cell.offsetHeight;
   _aspxSetStyleSize(iFrame, width, height);
   _aspxSetStylePosition(iFrame, x, y);
   _aspxSetElementDisplay(iFrame, true);
  }
 },
 DoShowPopupMenuBorderCorrector: function(element, x, y, indexPath, toTheLeft, toTheTop){
  var borderCorrectorElement = this.GetMenuBorderCorrectorElement(indexPath);
  if(borderCorrectorElement) {
   var params = this.GetPopupMenuBorderCorrectorPositionAndSize(element, x, y, indexPath, toTheLeft, toTheTop);
   var itemCell = this.GetItemTextOrImageCell(indexPath);
   var popOutImageCell = this.GetItemPopOutImageCell(indexPath);
   if(__aspxIE && __aspxBrowserMajorVersion == 9) { 
    var isVertical = this.IsVertical(indexPath);
    var itemBoundCoord = itemCell.getBoundingClientRect()[isVertical ? 'bottom' : 'right'];
    var itemBorderWidth = _aspxPxToInt(_aspxGetCurrentStyle(itemCell)[isVertical ? 'borderBottomWidth' : 'borderRightWidth']);
    if(popOutImageCell != null) {
     var popOutImageBoundCoord = popOutImageCell.getBoundingClientRect()[isVertical ? 'bottom' : 'right'];
     if(popOutImageBoundCoord > itemBoundCoord) {
      itemBoundCoord = popOutImageBoundCoord;
      itemBorderWidth = _aspxPxToInt(_aspxGetCurrentStyle(popOutImageCell)[isVertical ? 'borderBottomWidth' : 'borderRightWidth']);
     }
    }
    var menu = this.GetMainElement();
    itemBoundCoord -= Math.min(menu.getBoundingClientRect()[isVertical ? 'top' : 'left'], _aspxGetPositionElementOffset(menu, !isVertical));
    if(isVertical) {
     var bottomsDifference = this.GetItemElement(indexPath).getBoundingClientRect().bottom - 
      this.GetMenuElement(indexPath).getBoundingClientRect().bottom;
     itemBoundCoord -= bottomsDifference > 0 && bottomsDifference;
    }
    var borderCorrectorBoundCoord = isVertical ? params.top + params.height : params.left + params.width;
    if(itemBoundCoord - borderCorrectorBoundCoord != itemBorderWidth) {
     borderCorrectorBoundCoord = itemBoundCoord - itemBorderWidth;
     if(isVertical)
      params.height = borderCorrectorBoundCoord - params.top;
     else
      params.width = borderCorrectorBoundCoord - params.left;
    }
   }
   _aspxSetStyleSize(borderCorrectorElement, params.width, params.height);
   _aspxSetStylePosition(borderCorrectorElement, params.left, params.top);
   _aspxSetElementVisibility(borderCorrectorElement, true);
   _aspxSetElementDisplay(borderCorrectorElement, true);
   element.borderCorrectorElement = borderCorrectorElement;
  }
 },
 GetPopupMenuBorderCorrectorPositionAndSize: function(element, x, y, indexPath, toTheLeft, toTheTop) {
  var result = {};
  var itemInfo = new ASPxClientMenuItemInfo(this, indexPath);
  var menuXOffset = _aspxGetClientLeft(this.GetMenuMainCell(element));
  var menuYOffset = _aspxGetClientTop(this.GetMenuMainCell(element));
  var mainCell = this.GetMenuMainCell(element);
  var menuClientWidth = mainCell.clientWidth;
  var menuClientHeight = mainCell.clientHeight;
  if(this.IsVertical(indexPath)){
   var commonClientHeight = itemInfo.clientHeight < menuClientHeight
    ? itemInfo.clientHeight
    : menuClientHeight;
   result.width = menuXOffset;
   result.height = commonClientHeight + itemInfo.clientTop - menuYOffset;
   result.left = x;
   if(toTheLeft)
    result.left += menuClientWidth + menuXOffset;
   result.top = y + menuYOffset;
   if(toTheTop)
    result.top += menuClientHeight - result.height;
  }
  else{
   var itemWidth = itemInfo.clientWidth;
   if(this.IsDropDownItem(indexPath)){
    if(this.liteRender)
     itemWidth = this.GetItemTextCell(indexPath).clientWidth;
    else {
     var popOutImageElement = this.GetItemPopOutImageCell(indexPath);
     if(popOutImageElement != null)
      itemWidth -= popOutImageElement.clientWidth;
    }
   }
   var commonClientWidth = itemWidth < menuClientWidth
    ? itemWidth
    : menuClientWidth;
   result.width = commonClientWidth + itemInfo.clientLeft - menuXOffset;
   result.height = menuYOffset;
   result.left = x + menuXOffset;
   if(toTheLeft)
    result.left += menuClientWidth - result.width;
   result.top = y;
   if(toTheTop)
    result.top += menuClientHeight + menuYOffset;
  }
  return result;
 },
 DoHidePopupMenu: function(evt, element){
  this.DoHidePopupMenuBorderCorrector(element);
  this.DoHidePopupMenuIFrame(element);
  _aspxStopAnimation(element);
  _aspxSetElementVisibility(element, false);
  _aspxSetElementDisplay(element, false);
  this.CancelSubMenuItemHoverItem(element);
  aspxGetMenuCollection().UnregisterVisiblePopupMenu(this.name, element.id);
  this.popupCount --;
  var indexPath = this.GetIndexPathById(element.id, true);
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) {
   element.style.height = "";
   scrollHelper.ResetScrolling();
  }
  this.RaiseCloseUp(indexPath);
 },
 DoHidePopupMenuIFrame: function(element){
  if (!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(iFrame)
   _aspxSetElementDisplay(iFrame, false);  
 },
 DoHidePopupMenuBorderCorrector: function(element){
  var borderCorrectorElement = element.borderCorrectorElement;
  if(borderCorrectorElement) {
   _aspxSetElementVisibility(borderCorrectorElement, false);
   _aspxSetElementDisplay(borderCorrectorElement, false);
   element.borderCorrectorElement = null;
  }
 },
 SetHoverElement: function(element){
  if(!this.IsStateControllerEnabled()) return;
  this.lockHoverEvents = true;
  aspxGetStateController().SetCurrentHoverElementBySrcElement(element);
  this.lockHoverEvents = false;
 },
 ApplySubMenuItemHoverItem: function(element, hoverItem, hoverElement){
  if(!element.hoverItem && _aspxGetElementDisplay(element)) {
   var newHoverItem = hoverItem.Clone();
   element.hoverItem = newHoverItem;
   element.hoverElement = hoverElement;
   newHoverItem.Apply(hoverElement);
  }
 },
 CancelSubMenuItemHoverItem: function(element){
  if(element.hoverItem) {
   element.hoverItem.Cancel(element.hoverElement);
   element.hoverItem = null;
   element.hoverElement = null;
  }
 },
 ShowSubMenu: function(indexPath){
  var element = this.GetMenuElement(indexPath);
  if(element != null){
   var level = this.GetMenuLevel(indexPath);
   aspxGetMenuCollection().DoHidePopupMenus(null, level - 1, this.name, false,  element.id);
   if (!_aspxGetElementDisplay(element))
    this.DoShowPopupMenu(element, __aspxInvalidPosition, __aspxInvalidPosition, indexPath);
  } 
  this.ClearAppearTimer();
 },
 SelectItem: function(indexPath){
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetItemTextOrImageCell(indexPath);
  if(element != null)
   aspxGetStateController().SelectElementBySrcElement(element);
 },
 DeselectItem: function(indexPath){
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetItemTextOrImageCell(indexPath);
  if(element != null){
   var hoverItem = null;
   var hoverElement = null;
   var menuElement = this.GetMenuElement(indexPath);
   if (menuElement && menuElement.hoverItem) {
    hoverItem = menuElement.hoverItem;
    hoverElement = menuElement.hoverElement;
    this.CancelSubMenuItemHoverItem(menuElement);
   }
   aspxGetStateController().DeselectElementBySrcElement(element);
   if(menuElement != null && hoverItem != null)
    this.ApplySubMenuItemHoverItem(menuElement, hoverItem, hoverElement);
  }
 },
 InitializeSelectedItem: function(){
  if(!this.allowSelectItem) return;
  this.SelectItem(this.GetSelectedItemIndexPath());
 },
 GetSelectedItemIndexPath: function(){
  var inputElement = this.GetSelectedItemInputElement();
  if(inputElement != null)
   return inputElement.value;
  return ""; 
 },
 SetSelectedItemInternal: function(indexPath, modifyHotTrackSelection){
  if(modifyHotTrackSelection)
   this.SetHoverElement(null);
  var inputElement = this.GetSelectedItemInputElement();
  if(inputElement != null){
   this.DeselectItem(inputElement.value);
   inputElement.value = indexPath;
   var item = this.GetItemByIndexPath(indexPath);
   if(item == null || item.GetEnabled())
    this.SelectItem(inputElement.value);
  }
  if(modifyHotTrackSelection){
   var element = this.GetItemTextOrImageCell(indexPath);
   if(element != null) 
    this.SetHoverElement(element);
  }
 },
 InitializeCheckedItems: function(){
  if(!this.allowCheckItems) return;
  var inputElement = this.GetCheckedItemsInputElement();
  if(inputElement != null){
   var indexPathes = inputElement.value.split(";");
   for(var i = 0; i < indexPathes.length; i ++){
    if(indexPathes[i] != ""){
     this.checkedItems.push(indexPathes[i]);
     this.SelectItem(indexPathes[i]);
    }
   }
  }
 },
 ChangeCheckedItem: function(indexPath){
  this.SetHoverElement(null);
  var inputElement = this.GetCheckedItemsInputElement();
  if(inputElement != null){
   var itemsGroup = this.GetItemsGroup(indexPath);
   if(itemsGroup != null){
    if(itemsGroup.length > 1){
     if(!this.IsCheckedItem(indexPath)){
      for(var i = 0; i < itemsGroup.length; i ++){
       if(itemsGroup[i] == indexPath) continue;
       if(this.IsCheckedItem(itemsGroup[i])){
        _aspxArrayRemove(this.checkedItems, itemsGroup[i]);
        this.DeselectItem(itemsGroup[i]);
       }
      }
      this.SelectItem(indexPath);
      this.checkedItems.push(indexPath);
     }
    }
    else{
     if(this.IsCheckedItem(indexPath)){
      _aspxArrayRemove(this.checkedItems, indexPath);
      this.DeselectItem(indexPath);
     }
     else{
      this.SelectItem(indexPath);
      this.checkedItems.push(indexPath);
     }
    }
    this.UpdateCheckedInputElement(inputElement);
   }
  }
  var element = this.GetItemTextOrImageCell(indexPath);
  if(element != null) 
   this.SetHoverElement(element);
 },
 GetItemsGroup: function(indexPath){
  for(var i = 0; i < this.itemCheckedGroups.length; i ++){
   if(_aspxArrayIndexOf(this.itemCheckedGroups[i], indexPath) > -1)
    return this.itemCheckedGroups[i];
  }
  return null;
 },
 IsCheckedItem: function(indexPath){
  return _aspxArrayIndexOf(this.checkedItems, indexPath) > -1;
 },
 UpdateCheckedInputElement: function(inputElement){
  var state = "";
  for(var i = 0; i < this.checkedItems.length; i ++){
   state += this.checkedItems[i];
   if(i < this.checkedItems.length - 1)
    state += ";";
  }
  inputElement.value = state;
 },
 GetAnimationVerticalDirection: function(indexPath, popupPosition){
  var verticalDirection = (this.IsRootItem(indexPath) && !this.IsVertical(indexPath)) ? -1 : 0;
  if (popupPosition.isInverted) verticalDirection *= -1;
  return verticalDirection;
 },
 GetAnimationHorizontalDirection: function(indexPath, popupPosition){
  var horizontalDirection = (this.IsRootItem(indexPath) && !this.IsVertical(indexPath)) ? 0 : -1;
  if (popupPosition.isInverted) horizontalDirection *= -1;
  return horizontalDirection;
 },
 StartAnimation: function(animationDivElement, indexPath, horizontalPopupPosition, verticalPopupPosition){
  var element = this.GetMenuMainTable(animationDivElement);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  _aspxInitAnimationDiv(animationDivElement, clientX, clientY, "aspxMATimer(\"" + this.name + "\", " + "\"" + indexPath + "\")", "");
  var verticalDirection = this.GetAnimationVerticalDirection(indexPath, verticalPopupPosition);
  var horizontalDirection = this.GetAnimationHorizontalDirection(indexPath, horizontalPopupPosition);
  var yPos = verticalDirection * element.offsetHeight;
  var xPos = horizontalDirection * element.offsetWidth;
  _aspxSetStylePosition(element, xPos, yPos);
  _aspxSetElementVisibility(animationDivElement, true);
  this.DoShowPopupMenuIFrame(animationDivElement, clientX, clientY, 0, 0, indexPath);
  this.DoShowPopupMenuBorderCorrector(animationDivElement, clientX, clientY, indexPath, 
   horizontalPopupPosition.isInverted, verticalPopupPosition.isInverted);
  animationDivElement.timerID = window.setTimeout(animationDivElement.onTimerString, this.animationDelay);
 },
 OnAnimationTimer: function(indexPath){  
  var animationDivElement = this.GetMenuElement(indexPath);
  if(animationDivElement) {
   var element = this.GetMenuMainTable(animationDivElement);
   var mainCell = this.GetMenuMainCell(element);   
   var iframeElement = this.GetMenuIFrameElement(indexPath);
   _aspxOnAnimationTimer(animationDivElement, element, mainCell, iframeElement, this.animationDelay, this.animationMaxDelay, __aspxMenuAnimationAccelerator);
  }
 },
 OnItemClick: function(indexPath, evt){
  var sourceElement = _aspxGetEventSource(evt);
  var clickedLinkElement = _aspxGetParentByTagName(sourceElement, "A");
  var isLinkClicked = (clickedLinkElement != null && clickedLinkElement.href != __aspxAccessibilityEmptyUrl);
  var element = this.GetItemTextOrImageCell(indexPath);
  var linkElement = (element != null) ? _aspxGetChildByTagName(element, "A", 0) : null;
  if(linkElement != null && linkElement.href == __aspxAccessibilityEmptyUrl)
   linkElement = null;
  if(this.allowSelectItem)
   this.SetSelectedItemInternal(indexPath, true); 
  if(this.allowCheckItems)
   this.ChangeCheckedItem(indexPath); 
  this.DoItemClick(indexPath, isLinkClicked || (linkElement != null), evt);
  if(!isLinkClicked && linkElement != null && !(__aspxWebKitTouchUI && this.HasChildren(indexPath))) 
   _aspxNavigateByLink(linkElement);
 },
 OnItemDropDownClick: function(indexPath, evt){
  if(this.IsItemEnabled(indexPath))
   this.ShowSubMenu(indexPath);
 },
 AfterItemOverAllowed: function(hoverItem) {
  return hoverItem.name != "" && !this.lockHoverEvents;
 },
 OnAfterItemOver: function(hoverItem, hoverElement){
  if(!this.AfterItemOverAllowed(hoverItem)) return;
  if(!this.showSubMenus) {
   this.savedCallbackHoverItem = hoverItem;
   this.savedCallbackHoverElement = hoverElement;
   return;
  }
  this.ClearDisappearTimer();
  this.ClearAppearTimer();
  var indexPath = this.GetMenuIndexPathById(hoverItem.name);
  if(indexPath == ""){
   indexPath = this.GetItemIndexPathById(hoverItem.name);
   var canShowSubMenu = true;
   if(this.IsDropDownItem(indexPath)){
    var popOutImageElement = this.GetItemPopOutImageCell(indexPath);
    if(popOutImageElement != null && popOutImageElement != hoverElement){
     hoverItem.needRefreshBetweenElements = true;
     canShowSubMenu = false;
    }
   }
   if(canShowSubMenu){
    if(hoverItem.enabled && hoverItem.kind == __aspxHoverItemKind){
     this.SetAppearTimer(indexPath);
     this.RaiseItemMouseOver(indexPath);
    }
   }
  }
 },
 OnBeforeItemOver: function(hoverItem, hoverElement){
  if (__aspxNetscapeFamily && _aspxIsExists(hoverElement.offsetParent) && 
    hoverElement.offsetParent.style.borderCollapse == "collapse") {
   hoverElement.offsetParent.style.borderCollapse = "separate";
   hoverElement.offsetParent.style.borderCollapse = "collapse";
  }
  var indexPath = this.GetItemIndexPathById(hoverItem.name);
  var element = this.GetMenuElement(indexPath);
  if(element) this.CancelSubMenuItemHoverItem(element);  
 },
 OnItemOverTimer: function(indexPath){
  var element = this.GetMenuElement(indexPath);
  if(element == null){  
   var level = this.GetMenuLevel(indexPath);
   aspxGetMenuCollection().DoHidePopupMenus(null, level - 1, this.name, false, "");
  }   
  if(this.IsAppearTimerActive()){
   this.ClearAppearTimer();
   if(this.GetItemImageCell(indexPath) != null || this.GetItemIndentCell(indexPath) != null ||
    this.GetItemTextCell(indexPath) != null || this.GetItemPopOutImageCell(indexPath) != null){
    this.ShowSubMenu(indexPath);
   }
  }
 },
 OnBeforeItemDisabled: function(disabledItem, disabledElement){
  this.ClearAppearTimer();
  var indexPath = this.GetItemIndexPathById(disabledElement.id);
  if(indexPath != ""){
   var element = this.GetMenuElement(indexPath);
   if(element != null) this.DoHidePopupMenu(null, element);
  }
 },
 OnAfterItemOut: function(hoverItem, hoverElement, newHoverElement){
  if(!this.showSubMenus) {
   this.savedCallbackHoverItem = null;
   this.savedCallbackHoverElement = null;
  }
  if(hoverItem.name == "" || this.lockHoverEvents) return;
  if(hoverItem.IsChildElement(newHoverElement)) return;
  var indexPath = this.GetItemIndexPathById(hoverItem.name);
  var element = this.GetMenuElement(indexPath);
  this.ClearDisappearTimer();
  this.ClearAppearTimer();
  if(element == null || !_aspxGetIsParent(element, newHoverElement)) 
   this.SetDisappearTimer();
  if(element != null) 
   this.ApplySubMenuItemHoverItem(element, hoverItem, hoverElement);
  if(indexPath != "")
   this.RaiseItemMouseOut(indexPath);
 },
 OnItemOutTimer: function(){
  if(this.IsDisappearTimerActive()){
   this.ClearDisappearTimer();
   if(aspxGetMenuCollection().CheckFocusedElement())
    this.SetDisappearTimer();
   else
    this.OnHideByItemOut();
  }
 },
 OnHideByItemOut: function(){
  aspxGetMenuCollection().DoHidePopupMenus(null, 0, this.name, true, "");
 },
 OnFocusedItemKeyDown: function(evt, focusedItem, focusedElement){
  var handled = false;
  var indexPath = this.GetItemIndexPathById(focusedItem.name);
  switch(evt.keyCode){
   case ASPxKey.Tab: {
    handled = this.FocusNextTabItem(indexPath, evt.shiftKey);
    break;
   }
   case ASPxKey.Down: {
    if(this.IsVertical(indexPath)){
     this.FocusNextItem(indexPath);
    }
    else{
     this.ShowSubMenu(indexPath);
     this.FocusItemByIndexPath(this.GetFirstChildIndexPath(indexPath));
    }
    handled = true;
    break;
   }
   case ASPxKey.Up: {
    if(this.IsVertical(indexPath)){
     this.FocusPrevItem(indexPath);
    }
    else{
     this.ShowSubMenu(indexPath);
     this.FocusItemByIndexPath(this.GetFirstChildIndexPath(indexPath));
    }
    handled = true;
    break;
   }
   case ASPxKey.Left: {
    if(this.IsVertical(indexPath)){
     var parentIndexPath = this.GetParentIndexPath(indexPath);
     if(this.IsVertical(parentIndexPath)){
      this.FocusItemByIndexPath(parentIndexPath);
     }
     else{
      this.FocusPrevItem(parentIndexPath);
     }
    }
    else{
     this.FocusPrevItem(indexPath);
    }
    handled = true;
    break;
   }
   case ASPxKey.Right: {
    if(this.IsVertical(indexPath)){
     if(this.HasChildren(indexPath)){
      this.ShowSubMenu(indexPath);
      this.FocusItemByIndexPath(this.GetFirstChildIndexPath(indexPath));
     }
     else{
      while(!this.IsRootItem(indexPath))
       indexPath = this.GetParentIndexPath(indexPath);
      this.FocusNextItem(indexPath);
     }
    }
    else{
     this.FocusNextItem(indexPath);
    }
    handled = true;
    break;
   }
   case ASPxKey.Esc: {
    var parentIndexPath = this.GetParentIndexPath(indexPath);
    this.FocusItemByIndexPath(parentIndexPath);
    var element = this.GetMenuElement(parentIndexPath);
    if(element != null) {
     this.DoHidePopupMenu(null, element);
     handled = true;
    }
   }
  }
  if(handled)
   _aspxPreventEventAndBubble(evt);
 },
 FocusItemByIndexPath: function(indexPath){
  var element = this.GetItemTextOrImageCell(indexPath);
  var link = _aspxGetChildByTagName(element, "A", 0);
  if(link != null) _aspxSetFocus(link);
 },
 FocusNextTabItem: function(indexPath, shiftKey){
  if(this.IsRootItem(indexPath)) return false;
  while(true){
   if(this.IsRootItem(indexPath)) {
    if(!shiftKey){
     if(this.GetNextSiblingIndexPath(indexPath) != null){
      this.FocusNextItem(indexPath);
      return true;
     }
    }
    else{
     if(this.GetPrevSiblingIndexPath(indexPath) != null){
      this.FocusPrevItem(indexPath);
      return true;
     }
    }
    break;
   }
   else {
    if(!shiftKey){
     if(this.GetNextSiblingIndexPath(indexPath) == null)
      indexPath = this.GetParentIndexPath(indexPath);
     else{
      this.FocusNextItem(indexPath);
      return true;
     }
    }
    else{
     if(this.GetPrevSiblingIndexPath(indexPath) == null)
      indexPath = this.GetParentIndexPath(indexPath);
     else{
      this.FocusPrevItem(indexPath);
      return true;
     }
    }
   }
  }
  return false;
 },
 FocusNextItem: function(indexPath){
  var newIndexPath = this.GetNextSiblingIndexPath(indexPath);
  if(newIndexPath == null)
   newIndexPath = this.GetFirstSiblingIndexPath(indexPath);
  if(indexPath != newIndexPath)
   this.FocusItemByIndexPath(newIndexPath);
 },
 FocusPrevItem: function(indexPath){
  var newIndexPath = this.GetPrevSiblingIndexPath(indexPath);
  if(newIndexPath == null)
   newIndexPath = this.GetLastSiblingIndexPath(indexPath);
  if(indexPath != newIndexPath)
   this.FocusItemByIndexPath(newIndexPath);
 },
 TryFocusItem: function(itemIndex){
  var item = this.GetItem(itemIndex);
  if(item.GetVisible()) {
   this.FocusItemByIndexPath(item.GetIndexPath());
   return true;
  }
  return false;
 },
 Focus: function(){
  if(this.rootItem != null) { 
   for(var i = 0; i < this.GetItemCount(); i++) {
    if(this.TryFocusItem(i))
     return true;
   }
  }
  else
   this.FocusNextItem("-1");
 },
 FocusLastItem: function(){
  if(this.rootItem != null) { 
   for(var i = this.GetItemCount() - 1; i >= 0; i--) {
    if(this.TryFocusItem(i))
     return true;
   }
  }
  else
   this.FocusPrevItem(this.GetItemCount() - 1);
 },
 OnCallback: function(result){
  _aspxInitializeScripts(); 
  this.InitializeScrollableMenus();
  for(var indexPath in result){
   var menuElement = this.GetMenuElement(indexPath);
   if(menuElement) {
    if(aspxGetMenuCollection().IsSubMenuVisible(menuElement.id)) {
     this.ShowPopupSubMenuAfterCallback(menuElement, result[indexPath]);
    } else {
     this.SetSubMenuInnerHtml(menuElement, result[indexPath]);
    }
   }
  }
  this.InitializeInternal(false);
  if(!this.showSubMenus){
   this.showSubMenus = true;
   if(this.savedCallbackHoverItem != null && this.savedCallbackHoverElement != null)
    this.OnAfterItemOver(this.savedCallbackHoverItem, this.savedCallbackHoverElement);
   this.savedCallbackHoverItem = null;
   this.savedCallbackHoverElement = null;
  }
 },
 SetSubMenuInnerHtml: function(menuElement, html) {
  _aspxSetInnerHtml(this.GetMenuMainCell(menuElement), html);
  if(this.liteRender) {
   ASPxClientMenuLiteRenderHelper.InlineInitializeSubMenuMenuElement(this, menuElement);
   ASPxClientMenuLiteRenderHelper.PrepareSubMenuSize(this, menuElement);
  }
 },
 ShowPopupSubMenuAfterCallback: function(element, callbackResult) {
  var indexPath = this.GetIndexPathById(element.id, true);
  var currentX = _aspxPxToInt(element.style.left);
  var currentY = _aspxPxToInt(element.style.top);
  var showedToTheTop = this.ShowedToTheTop(element, indexPath);
  var showedToTheLeft = this.ShowedToTheLeft(element, indexPath);
  _aspxSetStylePosition(element, __aspxInvalidPosition, __aspxInvalidPosition);
  this.SetSubMenuInnerHtml(element, callbackResult);
  var vertPos = this.GetClientSubMenuPos(element, indexPath, __aspxInvalidPosition, false);
  var clientY = vertPos.position;
  var toTheTop = vertPos.isInverted;
  if(!this.IsVertical(indexPath) && showedToTheTop != toTheTop) {
   clientY = currentY;
   toTheTop = showedToTheTop;
  }
  var scrollHelper = this.scrollHelpers[indexPath];
  if(scrollHelper) {
   var yClientCorrection = this.GetScrollSubMenuYCorrection(element, scrollHelper, clientY);
   if(yClientCorrection > 0)
    clientY += yClientCorrection;
  }
  _aspxSetStylePosition(element, currentX, clientY);
  this.DoShowPopupMenuIFrame(element, currentX, clientY, __aspxInvalidDimension, __aspxInvalidDimension, indexPath);
  this.DoShowPopupMenuBorderCorrector(element, currentX, clientY, indexPath, showedToTheLeft, toTheTop);
  aspxGetControlCollection().AdjustControls(element);
 },
 ShowedToTheTop: function(element, indexPath) {
  var currentY = _aspxPxToInt(element.style.top);
  var parentBottomY = this.GetSubMenuYPosition(indexPath);
  return currentY < parentBottomY;
 },
 ShowedToTheLeft: function(element, indexPath) {
  var currentX = _aspxPxToInt(element.style.left);
  var parentX = this.GetSubMenuXPosition(indexPath);
  return currentX < parentX;
 },
 CreateItems: function(itemsProperties){
  var itemType = this.GetClientItemType();
  this.rootItem = new itemType(this, null, 0, "");
  this.rootItem.CreateItems(itemsProperties);
 },
 GetClientItemType: function(){
  return ASPxClientMenuItem;
 },
 GetItemByIndexPath: function(indexPath){
  var item = this.rootItem;
  if(indexPath != "" && item != null){
   var indexes = this.GetItemIndexes(indexPath);
   for(var i = 0; i < indexes.length; i ++)
    item = item.GetItem(indexes[i]);
  }
  return item;
 },
 SetItemChecked: function(indexPath, checked){
  var inputElement = this.GetCheckedItemsInputElement();
  if(inputElement != null){
   var itemsGroup = this.GetItemsGroup(indexPath);
   if(itemsGroup != null){
    if(!checked && this.IsCheckedItem(indexPath)){
     _aspxArrayRemove(this.checkedItems, indexPath);
     this.DeselectItem(indexPath);
    }
    else if(checked && !this.IsCheckedItem(indexPath)){
     if(itemsGroup.length > 1){
      for(var i = 0; i < itemsGroup.length; i ++){
       if(itemsGroup[i] == indexPath) continue;
       if(this.IsCheckedItem(itemsGroup[i])){
        _aspxArrayRemove(this.checkedItems, itemsGroup[i]);
        this.DeselectItem(itemsGroup[i]);
       }
      }
     }
     this.SelectItem(indexPath);
     this.checkedItems.push(indexPath);
    }
    this.UpdateCheckedInputElement(inputElement);
   }
  }
 },
 ChangeItemEnabledAttributes: function(indexPath, enabled){
  if(this.liteRender)
   ASPxClientMenuLiteRenderHelper.ChangeItemEnabledAttributes(this.GetItemElement(indexPath), enabled);
  else {
   var textOrImageCell = this.GetItemTextOrImageCell(indexPath);
   if(!textOrImageCell)
    return;
   textOrImageCell.enabled = enabled;
   var method = _aspxChangeAttributesMethod(enabled);
   var styleMethod = _aspxChangeStyleAttributesMethod(enabled);
   var itemElement = this.IsVertical(indexPath) ? this.GetItemElement(indexPath) : null;
   if(itemElement)
    method(itemElement, "onclick");
   var templateElement = this.GetItemTemplateCell(indexPath);
   if(templateElement)
    method(templateElement, "onclick");
   var imageElement = this.GetItemImageCell(indexPath);
   if(imageElement){
    method(imageElement, "onclick");
    styleMethod(imageElement, "cursor");
       var link = this.GetInternalHyperlinkElement(imageElement, 0);
       if(link){
        method(link, "onclick");
        method(link, "href");
        styleMethod(link, "cursor");
    }
   }
   var textElement = this.GetItemTextCell(indexPath);
   if(textElement){
    method(textElement, "onclick");
    styleMethod(textElement, "cursor");
       var link = this.GetInternalHyperlinkElement(textElement, 0);
       if(link){
        method(link, "onclick");
        method(link, "href");
        styleMethod(link, "cursor");
     link = this.GetInternalHyperlinkElement(textElement, 1);
     if(link){
      method(link, "onclick");
      method(link, "href");
      styleMethod(link, "cursor");
     }
    }
   }
   var popOutImageElement = this.GetItemPopOutImageCell(indexPath);
   if(popOutImageElement){
    method(popOutImageElement, "onclick");
    styleMethod(popOutImageElement, "cursor");
   }
   var indentElement = this.GetItemIndentCell(indexPath);
   if(indentElement){
    method(indentElement, "onclick");
    styleMethod(indentElement, "cursor");
   }
  }
 },
 IsItemEnabled: function(indexPath){
  var item = this.GetItemByIndexPath(indexPath);
  return (item != null) ? item.GetEnabled() : true;
 },
 SetItemEnabled: function(indexPath, enabled, initialization){
  if(indexPath == "" || !this.GetItemByIndexPath(indexPath).enabled) return;
  if(!enabled){
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.DeselectItem(indexPath);
  }
  if(!initialization || !enabled)
   this.ChangeItemEnabledStateItems(indexPath, enabled);
  this.ChangeItemEnabledAttributes(indexPath, enabled);
  if(enabled){
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.SelectItem(indexPath);
  }
 },
 ChangeItemEnabledStateItems: function(indexPath, enabled){
  if(!this.IsStateControllerEnabled()) return;
  var element = this.liteRender
   ? this.GetItemElement(indexPath)
   : this.GetItemTextOrImageCell(indexPath);
  if(element)
   aspxGetStateController().SetElementEnabled(element, enabled);
 },
 GetItemImageUrl: function(indexPath){
  var image = this.GetItemImage(indexPath);
  if(image)
   return image.src;
  return "";
 },
 SetItemImageUrl: function(indexPath, url){
  var image = this.GetItemImage(indexPath);
  if(image)
   image.src = url;
 },
 GetItemImage: function(indexPath) {
  var element = this.GetItemImageCell(indexPath);
  if(element != null){
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img;
  }
  element = this.GetItemTextCell(indexPath);
  if(element != null){
   var img = _aspxGetChildByTagName(element, "IMG", 0);
   if(img != null)
    return img;
  }
 },
 GetItemNavigateUrl: function(indexPath){
  var element = this.GetItemTextCell(indexPath);
  if(element != null){
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  element = this.GetItemImageCell(indexPath);
  if(element != null){
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    return link.href;
  }
  return "";
 },
 SetItemNavigateUrl: function(indexPath, url){
  var element = this.GetItemTextCell(indexPath);
  if(element != null){
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
   link = _aspxGetChildByTagName(element, "A", 1);
   if(link != null)
    link.href = url;
  }
  element = this.GetItemImageCell(indexPath);
  if(element != null){
   var link = _aspxGetChildByTagName(element, "A", 0);
   if(link != null)
    link.href = url;
  }
 },
 FindTextNode: function(indexPath) {
  var element = this.GetItemTextCell(indexPath);
  if(element) {
   if(this.liteRender) {
    var link = _aspxGetChildByTagName(element, "A", 0); 
    if(link)
     return _aspxGetChildTextNode(link, 0);
    var titleSpan = _aspxGetChildByTagName(element, "SPAN", 0); 
    if(titleSpan)
     return _aspxGetChildTextNode(titleSpan, 0);
    for(var i = 0; i < element.childNodes.length; i++) { 
     var child = element.childNodes[i];
     if (child.nodeValue && (_aspxTrim(child.nodeValue) != ""))
      return child;
    }
   }
   return _aspxGetChildTextNode(element, 0);
  }
  return null;
 },
 GetItemText: function(indexPath){
  var textNode = this.FindTextNode(indexPath);
  return textNode
   ? _aspxTrim(textNode.nodeValue) 
   : "";
 },
 SetItemText: function(indexPath, text){
  var textNode = this.FindTextNode(indexPath);
  if(textNode)
   textNode.nodeValue = text;
 },
 SetItemVisible: function(indexPath, visible, initialization){
  if(indexPath == "" || !this.GetItemByIndexPath(indexPath).visible) return;
  if(visible && initialization) return;
  var element = null;
  if(this.liteRender || this.IsVertical(indexPath)){
   element = this.GetItemElement(indexPath);
   if(element != null)
    _aspxSetElementDisplay(element, visible);
  }
  else{
   element = this.GetItemTextTemplateContainer(indexPath);
   if(element != null)
    _aspxSetElementDisplay(element, visible);
   element = this.GetItemImageCell(indexPath);
   if(element != null)
    _aspxSetElementDisplay(element, visible);
   element = this.GetItemTextCell(indexPath);
   if(element != null)
    _aspxSetElementDisplay(element, visible);
   element = this.GetItemPopOutImageCell(indexPath);
   if(element != null)
    _aspxSetElementDisplay(element, visible);
  }
  this.SetIndentsVisiblility(indexPath);
  this.SetSeparatorsVisiblility(indexPath);
 },
 SetIndentsVisiblility: function(indexPath){
  var parent = this.GetItemByIndexPath(indexPath).parent;
  for(var i = 0; i < parent.GetItemCount(); i++){
   var item = parent.GetItem(i);
   var separatorVisible = item.GetVisible() && this.HasNextVisibleItems(parent, i);
   var element = this.GetItemIndentElement(item.GetIndexPath());
   if(element != null) _aspxSetElementDisplay(element, separatorVisible);
  }
 },
 SetSeparatorsVisiblility: function(indexPath){
  var parent = this.GetItemByIndexPath(indexPath).parent;
  for(var i = 0; i < parent.GetItemCount(); i++){
   var item = parent.GetItem(i);
   var separatorVisible = this.HasPrevVisibleItems(parent, i) && (item.GetVisible() || this.HasNextVisibleItemInGroup(parent, i));
   var element = this.GetItemSeparatorElement(item.GetIndexPath());
   if(element != null) _aspxSetElementDisplay(element, separatorVisible);
   element = this.GetItemSeparatorIndentElement(item.GetIndexPath());
   if(element != null) _aspxSetElementDisplay(element, separatorVisible);
  }
 },
 HasNextVisibleItemInGroup: function(parent, index){
  for(var i = index + 1; i < parent.GetItemCount(); i++){
   var item = parent.GetItem(i);
   if(this.IsItemBeginsGroup(item))
    return false;
   if(item.GetVisible())
    return true;
  }
  return false;
 },
 IsItemBeginsGroup: function(item){
  var itemSeparator = this.GetItemSeparatorElement(item.GetIndexPath());
  return this.liteRender
   ? itemSeparator && _aspxElementCssClassContains(itemSeparator, ASPxClientMenuCssClasses.Separator)
   : itemSeparator;
 },
 HasNextVisibleItems: function(parent, index){
  for(var i = index + 1; i < parent.GetItemCount(); i++){
   if(parent.GetItem(i).GetVisible())
    return true;
  }
  return false;
 },
 HasPrevVisibleItems: function(parent, index){
  for(var i = index - 1; i >= 0; i--){
   if(parent.GetItem(i).GetVisible())
    return true;
  }
  return false;
 },
 GetItemIndentElement: function(indexPath){
  return _aspxGetElementById(this.GetItemIndentElementId(indexPath));
 },
 GetItemSeparatorElement: function(indexPath){
  if(this.liteRender)
   return _aspxGetElementById(this.GetItemSeparatorElementId(indexPath));
  else {
   var separator1 = _aspxGetElementById(this.GetItemSeparatorElementId(indexPath));
   var separator2 = _aspxGetElementById(this.GetItemSeparatorElementId(indexPath) + "F");
   if(separator1 == null)
    return separator2;
   else if(separator2 == null)
    return separator1;
   else {
    if(separator1.style.display != "")
     return separator1;
    else if(separator2.style.display != "")
     return separator2;
    else {
     if(_aspxGetCurrentStyle(separator1).display == "none")
      return separator2;
     else
      return separator1;
    }
   }
  }
 },
 GetItemSeparatorIndentElement: function(indexPath){
  return _aspxGetElementById(this.name + __aspxMIIdSuffix + indexPath + "_ISI");
 },
 RaiseItemClick: function(indexPath, htmlEvent){
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("ItemClick");
  if(!this.ItemClick.IsEmpty()){
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemTextOrImageCell(indexPath);
   var args = new ASPxClientMenuItemClickEventArgs(processOnServer, item, htmlElement, htmlEvent);
   this.ItemClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 }, 
 RaiseItemMouseOver: function(indexPath){
  if(!this.ItemMouseOver.IsEmpty()){
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemTextOrImageCell(indexPath);
   var args = new ASPxClientMenuItemMouseEventArgs(item, htmlElement);
   this.ItemMouseOver.FireEvent(this, args);
  }
 },
 RaiseItemMouseOut: function(indexPath){
  if(!this.ItemMouseOut.IsEmpty()){
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemTextOrImageCell(indexPath);
   var args = new ASPxClientMenuItemMouseEventArgs(item, htmlElement);
   this.ItemMouseOut.FireEvent(this, args);
  }
 },
 RaisePopUp: function(indexPath){
  var item = this.GetItemByIndexPath(indexPath);
  if(!this.PopUp.IsEmpty()){
   var args = new ASPxClientMenuItemEventArgs(item);
   this.PopUp.FireEvent(this, args);
  }
 },
 RaiseCloseUp: function(indexPath){
  var item = this.GetItemByIndexPath(indexPath);
  if(!this.CloseUp.IsEmpty()){
   var args = new ASPxClientMenuItemEventArgs(item);
   this.CloseUp.FireEvent(this, args);
  }
 },
 SetEnabled: function(enabled) {
  for(var i = this.GetItemCount() - 1; i >= 0; i--) {
   var item = this.GetItem(i);
   item.SetEnabled(enabled);
  }
 },
 GetItemCount: function(){
  return (this.rootItem != null) ? this.rootItem.GetItemCount() : 0;
 },
 GetItem: function(index){
  return (this.rootItem != null) ? this.rootItem.GetItem(index) : null;
 },
 GetItemByName: function(name){
  return (this.rootItem != null) ? this.rootItem.GetItemByName(name) : null;
 },
 GetSelectedItem: function(){
  var indexPath = this.GetSelectedItemIndexPath();
  if(indexPath != "")
   return this.GetItemByIndexPath(indexPath);
  return null;
 },
 SetSelectedItem: function(item){
  var indexPath = (item != null) ? item.GetIndexPath() : "";
  this.SetSelectedItemInternal(indexPath, false);
 },
 GetRootItem: function(){
  return this.rootItem;
 }
});
ASPxClientMenuBase.GetMenuCollection = function(){
 return aspxGetMenuCollection();
}
ASPxClientMenuCollection = _aspxCreateClass(ASPxClientControlCollection, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.appearTimerID = -1;
  this.disappearTimerID = -1;
  this.currentShowingPopupMenuName = null;
  this.visibleSubMenusMenuName = "";
  this.visibleSubMenuIds = [ ];
  this.overXPos = -1;
  this.overYPos = -1;
 },
 RegisterVisiblePopupMenu: function(name, id){
  this.visibleSubMenuIds.push(id);
  this.visibleSubMenusMenuName = name;
 },
 UnregisterVisiblePopupMenu: function(name, id){
  _aspxArrayRemove(this.visibleSubMenuIds, id);
  if(this.visibleSubMenuIds.length == 0)
   this.visibleSubMenusMenuName = "";
 },
 IsSubMenuVisible: function(subMenuId) {
  for(var i = 0; i < this.visibleSubMenuIds.length; i++) {
   if(this.visibleSubMenuIds[i] == subMenuId)
    return true;
  }
  return false;
 },
 GetMenu: function(id){
  return this.Get(this.GetMenuName(id));
 },
 GetMenuName: function(id){
  return this.GetMenuNameBySuffixes(id, [__aspxMMIdSuffix, __aspxMIIdSuffix]);
 },
 GetMenuNameBySuffixes: function(id, idSuffixes){
  for(var i = 0; i < idSuffixes.length; i++){
   var pos = id.lastIndexOf(idSuffixes[i]);
   if(pos > -1) 
    return id.substring(0, pos);
  }
  return id;
 },
 ClearCurrentShowingPopupMenuName: function() {
  this.SetCurrentShowingPopupMenuName(null);
 },
 SetCurrentShowingPopupMenuName: function(value) {
  this.currentShowingPopupMenuName = value;
 },
 NowPopupMenuIsShowing: function() {
  return this.currentShowingPopupMenuName != null;
 },
 GetMenuLevel: function(indexPath){
  if(indexPath == "")
   return 0;
  else{
   var indexes = this.GetItemIndexes(indexPath);
   return indexes.length;
  }
 },
 GetMenuLevelById: function(id){ 
  var indexPath = this.GetIndexPathById(id, __aspxMMIdSuffix);
  return this.GetMenuLevel(indexPath);
 },
 GetIndexPathById: function(id, idSuffix){
  var pos = id.lastIndexOf(idSuffix);
  if(pos > -1){
   id = id.substring(pos + idSuffix.length);
   pos = id.lastIndexOf("_");
   if(pos > -1) 
    return id.substring(0, pos);
  }
  return "";
 },
 GetItemIndexPath: function(indexes){
  var indexPath = "";
  for(var i = 0; i < indexes.length; i ++){
   indexPath += indexes[i];
   if(i < indexes.length - 1)
    indexPath += __aspxItemIndexSeparator;
  }
  return indexPath;
 },
 GetItemIndexes: function(indexPath){
  var indexes = indexPath.split(__aspxItemIndexSeparator);
  for(var i = 0; i < indexes.length; i ++)
   indexes[i] = parseInt(indexes[i]);
  return indexes;
 },
 ClearAppearTimer: function(){
  this.appearTimerID = _aspxClearTimer(this.appearTimerID);
 },
 ClearDisappearTimer: function(){
  this.disappearTimerID = _aspxClearTimer(this.disappearTimerID);
 },
 IsAppearTimerActive: function(){
  return this.appearTimerID > -1;
 },
 IsDisappearTimerActive: function(){
  return this.disappearTimerID > -1;
 },
 SetAppearTimer: function(name, indexPath, timeout){
  this.appearTimerID = _aspxSetTimeout("aspxMIMOverTimer(\"" + name + "\", \"" + indexPath + "\")", timeout);
 },
 SetDisappearTimer: function(name, timeout){
  this.disappearTimerID = _aspxSetTimeout("aspxMIMOutTimer(\"" + name + "\")", timeout);
 },
 GetMouseDownMenuLevel: function(evt){
  var srcElement = _aspxGetEventSource(evt);
  if(this.visibleSubMenusMenuName != ""){
   var element = _aspxGetParentById(srcElement, this.visibleSubMenusMenuName);
   if(element != null) return 1;
  }
  for(var i = 0; i < this.visibleSubMenuIds.length; i ++){
   var element = _aspxGetParentById(srcElement, this.visibleSubMenuIds[i]);
   if(element != null)
    return this.GetMenuLevelById(this.visibleSubMenuIds[i]) + 1;
  }
  return -1;
 },
 CheckFocusedElement: function(){
  try {
   if(document.activeElement != null) {
    for(var i = 0; i < this.visibleSubMenuIds.length; i ++) {
     var menuElement = _aspxGetElementById(this.visibleSubMenuIds[i]);
     if(menuElement != null && _aspxGetIsParent(menuElement, document.activeElement)) {
      var tagName = document.activeElement.tagName;
      if (!__aspxIE || tagName == "INPUT" || tagName == "TEXTAREA" || tagName == "SELECT")
       return true;    
     }
    }
   }
  } catch(e) {
  }
  return false;
 },
 DoHidePopupMenus: function(evt, level, name, leavePopups, exceptId){
  for(var i = this.visibleSubMenuIds.length - 1; i >=0 ; i --){
   var menu = this.GetMenu(this.visibleSubMenuIds[i]);
   if(menu != null){
    var menuLevel = this.GetMenuLevelById(this.visibleSubMenuIds[i]);
    if((!leavePopups || menuLevel > 0) && exceptId != this.visibleSubMenuIds[i]){
     if(menuLevel > level || (menu.name != name && name != "")){
      var element = _aspxGetElementById(this.visibleSubMenuIds[i]);
      if(element != null)
       menu.DoHidePopupMenu(evt, element);
     }
    }
   }
  }
 },
 DoShowAtCurrentPos: function(name, indexPath){
  var pc = this.Get(name);
  var element = pc.GetMainElement();
  if(pc != null && !_aspxGetElementDisplay(element))
   pc.DoShowPopupMenu(element, this.overXPos, this.overYPos, indexPath);
 },
 SaveCurrentMouseOverPos: function(evt, popupElement){
  if (!this.NowPopupMenuIsShowing()) return;
  var currentShowingPopupMenu = this.Get(this.currentShowingPopupMenuName);
  if(currentShowingPopupMenu.popupElement == popupElement) 
   if(!currentShowingPopupMenu.IsMenuVisible()) {
    this.overXPos = _aspxGetEventX(evt);
    this.overYPos = _aspxGetEventY(evt);
   }
 },
 OnMouseDown: function(evt){
  var menuLevel = this.GetMouseDownMenuLevel(evt);
  this.DoHidePopupMenus(evt, menuLevel, "", false, "");
 },
 HideAll: function(){
  this.DoHidePopupMenus(null, -1, "", false, "");
 },
 IsAnyMenuVisible: function() {
  return this.visibleSubMenuIds.length != 0;
 }
});
var __aspxMCollection = null;
function aspxGetMenuCollection(){
 if(__aspxMCollection == null)
  __aspxMCollection = new ASPxClientMenuCollection();
 return __aspxMCollection;
}
ASPxClientMenuItem = _aspxCreateClass(null, {
 constructor: function(menu, parent, index, name){
  this.menu = menu;
  this.parent = parent;
  this.index = index;
  this.name = name;
  this.indexPath = "";
  if(parent) {
   this.indexPath = parent.indexPath
    ? parent.indexPath + __aspxItemIndexSeparator + this.index.toString()
    : this.index.toString();
  }
  this.enabled = true;
  this.clientEnabled = true;
  this.visible = true;
  this.clientVisible = true;
  this.items = [];
 },
 CreateItems: function(itemsProperties){
  var itemType = this.menu.GetClientItemType();
  for(var i = 0; i < itemsProperties.length; i ++){
   var itemName = itemsProperties[i][0] || "";
   var item = new itemType(this.menu, this, i, itemName);
   if(_aspxIsExists(itemsProperties[i][1]))
    item.enabled = itemsProperties[i][1];
   if(_aspxIsExists(itemsProperties[i][2]))    
    item.clientEnabled = itemsProperties[i][2];
   if(_aspxIsExists(itemsProperties[i][3]))
    item.visible = itemsProperties[i][3];
   if(_aspxIsExists(itemsProperties[i][4]))
    item.clientVisible = itemsProperties[i][4];
   this.items.push(item);
   item.CreateItems(itemsProperties[i][5]);
  }
 },
 GetIndexPath: function(){
  return this.indexPath;
 },
 GetItemCount: function(){
  return this.items.length;
 },
 GetItem: function(index){
  return (0 <= index && index < this.items.length) ? this.items[index] : null;
 },
 GetItemByName: function(name){
  for(var i = 0; i < this.items.length; i ++)
   if(this.items[i].name == name) return this.items[i];
  for(var i = 0; i < this.items.length; i ++){
   var item = this.items[i].GetItemByName(name);
   if(item != null) return item;
  }
  return null;
 },
 GetChecked: function(){
  var indexPath = this.GetIndexPath();
  return this.menu.IsCheckedItem(indexPath);
 },
 SetChecked: function(value){
  var indexPath = this.GetIndexPath();
  this.menu.SetItemChecked(indexPath, value);
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(value){
  if (this.clientEnabled != value) {
   this.clientEnabled = value;
   this.menu.SetItemEnabled(this.GetIndexPath(), value, false);
  }
 },
 GetImage: function() {
  return this.menu.GetItemImage(this.GetIndexPath());
 },
 GetImageUrl: function(){
  return this.menu.GetItemImageUrl(this.GetIndexPath());
 },
 SetImageUrl: function(value){
  var indexPath = this.GetIndexPath();
  this.menu.SetItemImageUrl(indexPath, value);
 },
 GetNavigateUrl: function(){
  var indexPath = this.GetIndexPath();
  return this.menu.GetItemNavigateUrl(indexPath);
 },
 SetNavigateUrl: function(value){
  var indexPath = this.GetIndexPath();
  this.menu.SetItemNavigateUrl(indexPath, value);
 },
 GetText: function(){
  var indexPath = this.GetIndexPath();
  return this.menu.GetItemText(indexPath);
 },
 SetText: function(value){
  var indexPath = this.GetIndexPath();
  this.menu.SetItemText(indexPath, value);
 },
 GetVisible: function(){
  return this.visible && this.clientVisible;
 },
 SetVisible: function(value){
  if (this.clientVisible != value) {
   this.clientVisible = value;
   this.menu.SetItemVisible(this.GetIndexPath(), value, false);
  }
 },
 InitializeEnabledAndVisible: function(recursive){
  this.menu.SetItemEnabled(this.GetIndexPath(), this.clientEnabled, true);
  this.menu.SetItemVisible(this.GetIndexPath(), this.clientVisible, true);
  if(recursive) {
   for(var i = 0; i < this.items.length; i++)
    this.items[i].InitializeEnabledAndVisible(recursive);
  }
 }
});
ASPxClientMenu = _aspxCreateClass(ASPxClientMenuBase, {
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.isVertical = false;
 },
 InlineInitialize: function() {
  ASPxClientMenuBase.prototype.InlineInitialize.call(this);
  if(this.liteRender)
   this.SetLightweightMenuHeightInIE7IfDisplayed();
 },
 IsVertical: function(indexPath){
  return this.isVertical || (indexPath.indexOf(__aspxItemIndexSeparator) > -1);
 },
 AdjustControlCore: function() {
  if(this.liteRender) {
   ASPxClientMenuLiteRenderHelper.PrepareSpacingAndSeparators(this, this.GetMainElement());
   this.SetLightweightMenuHeightInIE7IfDisplayed(true);
  }
  else
   this.CalculateClassicMenuHeight();
 },
 CalculateClassicMenuHeight: function() {
  if(!this.isVertical) {
   var mainCell = _aspxGetChildByTagName(this.GetMainElement(), "TD", 0);
   var table = mainCell.childNodes[0];
   _aspxSetOffsetHeight(table, _aspxGetClearClientHeight(mainCell));
  }
 },
 SetLightweightMenuHeightInIE7IfDisplayed: function(force) { 
  if(!__aspxIE || __aspxBrowserMajorVersion != 7)
   return;
  if(force)
   this.lightweightMenuHeightIE7Set = false;
  if(this.lightweightMenuHeightIE7Set || !this.IsDisplayed()) 
   return;
  var mainElement = this.GetMainElement();
  var commonContainer = mainElement.parentNode;
  if(!this.isPopupMenu && __aspxIE && __aspxBrowserMajorVersion == 7)
   commonContainer = commonContainer.parentNode;
  var _this = this;
  window.setTimeout(function() {
   if(mainElement.offsetHeight != 0) 
    commonContainer.style.height = mainElement.offsetHeight + "px";
   else
    _this.lightweightMenuHeightIE7Set = false;
  }, 0);
  this.lightweightMenuHeightIE7Set = true;
 }
});
ASPxClientMenu.Cast = ASPxClientControl.Cast;
ASPxClientMenuItemEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
ASPxClientMenuItemMouseEventArgs = _aspxCreateClass(ASPxClientMenuItemEventArgs, {
 constructor: function(item, htmlElement) {
  this.constructor.prototype.constructor.call(this, item);
  this.htmlElement = htmlElement;
 }
});
ASPxClientMenuItemClickEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, item, htmlElement, htmlEvent) {
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.item = item;
  this.htmlElement = htmlElement;
  this.htmlEvent = htmlEvent;  
 }
});
function aspxMIClick(evt, name, indexPath){
 if(ASPxClientTouchUI.isMouseEventFromScrolling) return;
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemClick(indexPath, evt);
 if(!__aspxNetscapeFamily)
  evt.cancelBubble = true;
}
function aspxMIDDClick(evt, name, indexPath){
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemDropDownClick(indexPath, evt);
 if(!__aspxNetscapeFamily)
  evt.cancelBubble = true;
}
function aspxAMIMOver(source, args){
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnAfterItemOver(args.item, args.element);
}
function aspxBMIMOver(source, args){
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnBeforeItemOver(args.item, args.element);
}
function aspxMIMOverTimer(name, indexPath){
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemOverTimer(indexPath);
}
function aspxBIDisabled(source, args){
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnBeforeItemDisabled(args.item, args.element);
}
function aspxFIKeyDown(source, args){
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnFocusedItemKeyDown(args.htmlEvent, args.item, args.element);
}
function aspxAMIMOut(source, args){
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnAfterItemOut(args.item, args.element, args.toElement);
}
function aspxMIMOutTimer(name){
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemOutTimer();
}
function aspxMContextMenu(evt){
 return _aspxCancelBubble(evt);
}
function aspxMSBOver(source, args) {
 var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id)
 if(menu != null) menu.ClearDisappearTimer();
}
function aspxMSBOut(source, args) {
 var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id)
 if(menu != null) menu.SetDisappearTimer();
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseDownEventName, aspxMenuDocumentMouseDown);
function aspxMenuDocumentMouseDown(evt){
 return aspxGetMenuCollection().OnMouseDown(evt); 
}
function aspxMATimer(name, indexPath){
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnAnimationTimer(indexPath);
}
(function(){
 aspxAddAfterSetFocusedState(aspxAMIMOver);
 aspxAddAfterClearFocusedState(aspxAMIMOut);
 aspxAddAfterSetHoverState(aspxAMIMOver);
 aspxAddAfterClearHoverState(aspxAMIMOut);
 aspxAddBeforeSetFocusedState(aspxBMIMOver);
 aspxAddBeforeSetHoverState(aspxBMIMOver);
 aspxAddBeforeDisabled(aspxBIDisabled);
 aspxAddFocusedItemKeyDown(aspxFIKeyDown);
 aspxAddAfterSetHoverState(aspxMSBOver);
 aspxAddAfterSetPressedState(aspxMSBOver);
 aspxAddAfterClearHoverState(aspxMSBOut);
 aspxAddAfterSetPressedState(function(source, args) {
  var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
  if(menu) menu.StartScrolling(args.element.id, 1, 4);
 });
 aspxAddAfterClearPressedState(function(source, args) {
  var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
  if(menu) menu.StopScrolling(args.element.id);
 });
 if(!__aspxTouchUI){
  aspxAddAfterSetHoverState(function(source, args) {
   var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
   if(menu) menu.StartScrolling(args.element.id, 15, 1);
  });
  aspxAddAfterClearHoverState(function(source, args) {
   var menu = ASPxClientMenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
   if(menu) menu.StopScrolling(args.element.id);
  }); 
 }
})();
