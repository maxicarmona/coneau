var __aspxDragHelper = null;
ASPxClientDragHelper = _aspxCreateClass(null, {
 constructor: function(e, root, clone){
  if(__aspxDragHelper != null) __aspxDragHelper.cancelDrag();
  this.dragArea = 5;
  this.clickX = _aspxGetEventX(e);
  this.clickY = _aspxGetEventY(e);
  this.centerClone = false;
  this.cachedCloneWidth = -1;
  this.cachedCloneHeight = -1;
  this.cachedOriginalX = -1;
  this.cachedOriginalY = -1;
  this.canDrag = true; 
  if(typeof(root) == "string") 
   root = _aspxGetParentByTagName(_aspxGetEventSource(e), root);
  this.obj = root && root != null ? root : _aspxGetEventSource(e);
  this.clone = clone;
  this.dragObj = null; 
  this.additionalObj = null;
  this.onDoClick = null;
  this.onEndDrag = null;
  this.onCancelDrag = null;
  this.onDragDivCreating = null;
  this.onCloneCreating = null;
  this.onCloneCreated = null;
  this.dragDiv = null;
  __aspxDragHelper = this;
  this.clearSelectionOnce = false;
 }, 
 drag: function(e) {
  if(!this.canDrag) return;
  _aspxClearSelection();
  if(!this.isDragging()) {
   if(!this.isOutOfDragArea(e)) 
    return;
   this.startDragCore(e);
  }
  if(__aspxIE && !_aspxGetIsLeftButtonPressed(e)) {
   this.cancelDrag(e);
   return;
  }
  if(!__aspxIE)
   _aspxSetElementSelectionEnabled(document.body, false);
  this.dragCore(e);
 },
 startDragCore: function(e) {  
  this.dragObj = this.clone != true ? this.obj : this.createClone(e);
 },
 dragCore: function(e) { 
  this.updateDragDivPosition(e);
 },
 endDrag: function(e) { 
  if(!this.isDragging() && !this.isOutOfDragArea(e)) {
   if(this.onDoClick)
    this.onDoClick(this);
  } else {
   if(this.onEndDrag)
    this.onEndDrag(this);
  }
  this.cancelDrag();
 },
 cancel: function(){
  this.cancelDrag();
 },
 cancelDrag: function() {
  if(this.dragDiv != null) {
   document.body.removeChild(this.dragDiv);
   this.dragDiv = null;
  }
  if(this.onCancelDrag)
   this.onCancelDrag(this);
  __aspxDragHelper = null;
  if(!__aspxIE)
   _aspxSetElementSelectionEnabled(document.body, true);
 },
 isDragging: function() {    
  return this.dragObj != null;
 },
 updateDragDivPosition: function(e) {
  if(this.centerClone) {
   this.dragDiv.style.left = _aspxGetEventX(e) - this.cachedCloneWidth / 2 + "px";
   this.dragDiv.style.top = _aspxGetEventY(e) - this.cachedCloneHeight / 2 + "px";
  } else {
   this.dragDiv.style.left = this.cachedOriginalX + _aspxGetEventX(e) - this.clickX + "px";
   this.dragDiv.style.top = this.cachedOriginalY + _aspxGetEventY(e) - this.clickY + "px";
  }
 },
 createClone: function(e) {
  this.dragDiv = document.createElement("div");
  if(this.onDragDivCreating)
   this.onDragDivCreating(this, this.dragDiv);
  var clone = this.creatingClone();  
  this.dragDiv.appendChild(clone);
  document.body.appendChild(this.dragDiv);
  this.dragDiv.style.position = "absolute";    
  this.dragDiv.style.cursor = "move";
  this.dragDiv.style.borderStyle = "none";
  this.dragDiv.style.padding = "0";
  this.dragDiv.style.margin = "0";
  this.dragDiv.style.backgroundColor = "transparent";
  this.dragDiv.style.zIndex = 20000; 
  if(this.onCloneCreated)
   this.onCloneCreated(clone);
  this.cachedCloneWidth = clone.offsetWidth;
  this.cachedCloneHeight = clone.offsetHeight;
  if(!this.centerClone) {  
   this.cachedOriginalX = _aspxGetAbsoluteX(this.obj);
   this.cachedOriginalY = _aspxGetAbsoluteY(this.obj);
  }
  this.dragDiv.style.width = this.cachedCloneWidth + "px";
  this.dragDiv.style.height = this.cachedCloneHeight + "px";
  this.updateDragDivPosition(e);
  return this.dragDiv;
 },
 creatingClone: function() {
  var clone = this.obj.cloneNode(true);
  if(!this.onCloneCreating) return clone;
  return this.onCloneCreating(clone);
 },
 addElementToDragDiv: function(element) {
  if(this.dragDiv == null) return;
  this.additionalObj = element.cloneNode(true);
  this.additionalObj.style.visibility = "visible";
  this.additionalObj.style.display = "";
  this.additionalObj.style.top = "";
  this.dragDiv.appendChild(this.additionalObj);
 },
 removeElementFromDragDiv: function() {
  if(this.additionalObj == null || this.dragDiv == null) return;
  this.dragDiv.removeChild(this.additionalObj);
  this.additionalObj = null;
 },
 isOutOfDragArea: function(e) {
  return Math.max(
   Math.abs(_aspxGetEventX(e) - this.clickX), 
   Math.abs(_aspxGetEventY(e) - this.clickY)
  ) >= this.dragArea;
 }
});
function DragHelper_onmouseup(e) {
 if(__aspxDragHelper != null) {
  __aspxDragHelper.endDrag(e);
  return true;
 }
}
function DragHelper_cancel(e) {
 if(__aspxDragHelper != null) {
  __aspxDragHelper.cancel(e);
  return true;
 }
}
function DragHelper_onmousemove(e) {
 if(__aspxDragHelper != null && !(__aspxWebKitTouchUI && ASPxClientTouchUI.isGesture)) {
  __aspxDragHelper.drag(e);
  if(ASPxClientTouchUI.isTouchEvent(e)) {
   e.preventDefault();
   ASPxClientTouchUI.preventScrollOnEvent(e);
  }
  return true;
 }
}
function DragHelper_onkeydown(e) {
 if(!__aspxDragHelper) return;
 if(e.keyCode == ASPxKey.Esc)
  __aspxDragHelper.cancelDrag();
 return true;
}
function DragHelper_onkeyup(e) {
 if (!__aspxDragHelper) return;
 if(e.keyCode == ASPxKey.Esc && __aspxWebKitFamily)
  __aspxDragHelper.cancelDrag();
 return true;
}
function DragHelper_onselectstart(e) {
 var drag = __aspxDragHelper;
 if(drag && (drag.canDrag || drag.clearSelectionOnce)) {
  _aspxClearSelection();
  drag.clearSelectionOnce = false;
  return false;
 }
}
(function(){
 if(__aspxMSTouchUI)
  _aspxAttachEventToDocument("MSPointerCancel", DragHelper_cancel);
 _aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseUpEventName, DragHelper_onmouseup);
 _aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseMoveEventName, DragHelper_onmousemove);
 _aspxAttachEventToDocument("keydown", DragHelper_onkeydown);
 _aspxAttachEventToDocument("keyup", DragHelper_onkeyup);
 _aspxAttachEventToDocument("selectstart", DragHelper_onselectstart);
})();
var __aspxCursorTargets = null;
ASPxClientCursorTargets = _aspxCreateClass(null, {
 constructor: function() {
  this.list = [];
  this.starttargetElement = null;
  this.starttargetTag = 0;
  this.oldtargetElement = null;
  this.oldtargetTag = 0;
  this.targetElement = null;
  this.targetTag = 0;
  this.x = 0;
  this.y = 0;
  this.removedX = 0;
  this.removedY = 0;
  this.removedWidth = 0;
  this.removedHeight = 0;
  this.onTargetCreated = null;
  this.onTargetChanging = null;
  this.onTargetChanged = null;
  this.onTargetAdding = null;
  this.onTargetAllowed = null;
  __aspxCursorTargets = this;
 },
 addElement: function(element) {
  if(!this.canAddElement(element)) return null;
  var target = new ASPxClientCursorTarget(element);
  this.onTargetCreated && this.onTargetCreated(this, target);
  this.list.push(target);
  return target;
 },
 removeElement: function(element) {
  for(var i = 0; i < this.list.length; i++) {
   if(this.list[i].element == element) {
    this.list.splice(i, 1);
    return;
   }
  }
 },
 addParentElement: function(parent, child) {
  var target = this.addElement(parent);
  if(target != null) {
   target.targetElement = child;
  }
  return target;
 },
 RegisterTargets: function(element, idPrefixArray) {
  this.addFunc = this.addElement;
  this.RegisterTargetsCore(element, idPrefixArray);
 },
 UnregisterTargets: function(element, idPrefixArray) {
  this.addFunc = this.removeElement;
  this.RegisterTargetsCore(element, idPrefixArray);
 },
 RegisterTargetsCore: function(element, idPrefixArray) {
  if(element == null) return;
  for(var i = 0; i < idPrefixArray.length; i++)
   this.RegisterTargetCore(element, idPrefixArray[i]);
 },
 RegisterTargetCore: function(element, idPrefix) {
  if(!_aspxIsExists(element.id)) return;
  if(element.id.indexOf(idPrefix) > -1)
   this.addFunc(element);
  for(var i = 0; i < element.childNodes.length; i++)
   this.RegisterTargetCore(element.childNodes[i], idPrefix);
 },
 canAddElement: function(element) {
  if(element == null || !_aspxGetElementDisplay(element))
   return false;
  for(var i = 0; i < this.list.length; i++) {
   if(this.list[i].targetElement == element) return false;
  }
  if(this.onTargetAdding != null && !this.onTargetAdding(this, element)) return false;
  return element.style.visibility != "hidden";
 },
 removeInitialTarget: function(x, y) {
  var el = this.getTarget(x + _aspxGetDocumentScrollLeft(), y + _aspxGetDocumentScrollTop());
  if(el == null) return;
  this.removedX = _aspxGetAbsoluteX(el);
  this.removedY = _aspxGetAbsoluteY(el);
  this.removedWidth = el.offsetWidth;
  this.removedHeight = el.offsetHeight;
 },
 getTarget: function(x, y) {
  for(var i = 0; i < this.list.length; i++) {
   var record = this.list[i];
   if(record.contains(x, y)) {
    if(!this.onTargetAllowed || this.onTargetAllowed(record.targetElement, x, y))
     return record.targetElement;
   }
  }
  return null;
 },
 targetChanged: function(element, tag) {
  this.targetElement = element;
  this.targetTag = tag;
  if(this.onTargetChanging)
   this.onTargetChanging(this);
  if(this.oldtargetElement != this.targetElement || this.oldtargetTag != this.targetTag) {
   if(this.onTargetChanged)
    this.onTargetChanged(this);
   this.oldtargetElement = this.targetElement;
   this.oldtargetTag = this.targetTag;
  }
 },
 cancelChanging: function() {
  this.targetElement = this.oldtargetElement;
  this.targetTag = this.oldtargetTag;
 },
 isLeftPartOfElement: function() {
  if(this.targetElement == null) return true;
  var left = this.x - this.targetElementX();
  return left < this.targetElement.offsetWidth / 2;
 },
 isTopPartOfElement: function() {
  if(this.targetElement == null) return true;
  var top = this.y - this.targetElementY();
  return top < this.targetElement.offsetHeight / 2;
 },
 targetElementX: function() {
  return this.targetElement != null ? _aspxGetAbsoluteX(this.targetElement) : 0;
 },
 targetElementY: function() {
  return this.targetElement != null ? _aspxGetAbsoluteY(this.targetElement) : 0;
 },
 onmousemove: function(e) {
  this.doTargetChanged(e);
 },
 onmouseup: function(e) {
  this.doTargetChanged(e);
  __aspxCursorTargets = null;
 },
 doTargetChanged: function(e) {
  this.x = _aspxGetEventX(e);
  this.y = _aspxGetEventY(e);
  if(this.inRemovedBounds(this.x, this.y)) return;
  this.targetChanged(this.getTarget(this.x, this.y), 0);
 },
 inRemovedBounds: function(x, y) {
  if(this.removedWidth == 0) return false;
  return x > this.removedX && x < (this.removedX + this.removedWidth) &&
   y > this.removedY && y < (this.removedY + this.removedHeight);
 }
});
ASPxClientCursorTarget = _aspxCreateClass(null, {
 constructor: function(element) {
  this.element = element;
  this.targetElement = element;
  this.absoluteX = _aspxGetAbsoluteX(element);
  this.absoluteY = _aspxGetAbsoluteY(element);
 },
 contains: function(x, y) {
  return x >= this.absoluteX && x <= this.absoluteX + this.GetElementWidth() &&
   y >= this.absoluteY && y <= this.absoluteY + this.GetElementHeight();
 },
 GetElementWidth: function() {
  return this.element.offsetWidth;
 },
 GetElementHeight: function() {
  return this.element.offsetHeight;
 }
});
function CursorTarget_onmouseup(e) {
 if(__aspxCursorTargets != null) {
  __aspxCursorTargets.onmouseup(e);
  return true;
 }
}
function CursorTarget_onmousemove(e) {
 if(__aspxCursorTargets != null) {
  __aspxCursorTargets.onmousemove(e);
  return true;
 }
}
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseUpEventName, CursorTarget_onmouseup);
_aspxAttachEventToDocument(ASPxClientTouchUI.touchMouseMoveEventName, CursorTarget_onmousemove);

