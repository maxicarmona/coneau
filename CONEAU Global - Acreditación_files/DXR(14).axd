aspxAnimationTransitionBase = _aspxCreateClass(null, {
 constructor: function (element, property, unit, onComplete) {
  this.duration = aspxAnimationTransitionBase.Durations.DEFAULT;
  this.element = element;
  this.property = property;
  this.unit = unit ? unit : "";
  this.onComplete = onComplete;
 },
 Start: function (from, to) {
 },
 Cancel: function () {
  this.element.aspxTransition = null;
 },
 PerformOnComplete: function () {
  if (this.onComplete)
   this.onComplete(this.element);
 },
 SetTransition: function (transition) {
 },
 SetDuration: function (duration) {
  this.duration = duration;
 }
});
aspxAnimationTransitionBase.IsStarted = function (element) {
 return !!element.aspxTransition;
};
aspxAnimationTransitionBase.Cancel = function (element) {
 if (element.aspxTransition)
  element.aspxTransition.Cancel();
};
aspxAnimationTransitionBase.Durations = {
 SHORT: 200,
 DEFAULT: 400,
 LONG: 600
};
aspxAnimationTransitionBase.Transitions = {
 LINER: {
  Css: "cubic-bezier(0.250, 0.250, 0.750, 0.750)",
  Js: function (progress) { return progress; }
 },
 SINE: {
  Css: "cubic-bezier(0.470, 0.000, 0.745, 0.715)",
  Js: function (progress) { return Math.sin(progress * 1.57); }
 },
 POW: {
  Css: "cubic-bezier(0.755, 0.050, 0.855, 0.060)",
  Js: function (progress) { return Math.pow(progress, 4); }
 },
 POW_EASE_OUT: {
  Css: "cubic-bezier(0.165, 0.840, 0.440, 1.000)",
  Js: function (progress) { return 1 - aspxAnimationTransitionBase.Transitions.POW.Js(1 - progress); }
 }
};
aspxJsAnimationTransition = _aspxCreateClass(aspxAnimationTransitionBase, {
 constructor: function (element, propertyOrGetMethod, propertyOrSetMethod, unit, onComplete) {
  this.constructor.prototype.constructor.call(this, element, null, unit, onComplete);
  this.transition = aspxAnimationTransitionBase.Transitions.SINE.Js;
  this.getMethod = typeof (propertyOrGetMethod) == "function" ? propertyOrGetMethod : null;
  this.getProperty = propertyOrGetMethod;
  this.setMethod = typeof (propertyOrSetMethod) == "function" ? propertyOrSetMethod : null;
  this.setProperty = propertyOrSetMethod;
  this.fps = 60;
  this.startTime = null;
  this.to = null;
  this.from = null;
 },
 Start: function (from, to) {
  this.startTime = new Date();
  this.to = to;
  if (from != null) {
   this.setValue(from);
   this.from = from;
  }
  else
   this.from = this.getValue();
  this.timerId = window.setInterval(function () { this.OnTick(); }.aspxBind(this), 1000 / this.fps);
 },
 Cancel: function () {
  aspxAnimationTransitionBase.prototype.Cancel.call(this);
  if (this.timerId)
   clearInterval(this.timerId);
 },
 OnTick: function () {
  var progress = (new Date() - this.startTime) / this.duration;
  if (progress >= 1) {
   this.Cancel();
   this.setValue(this.to);
   this.PerformOnComplete();
   return;
  }
  this.setValue(this.from + (this.to - this.from) * this.transition(progress));
 },
 getValue: function () {
  var value;
  if (this.getMethod)
   value = this.getMethod(this.element);
  else
   value = this.element.style[this.getProperty];
  value = parseFloat(value);
  return isNaN(value) ? 0 : value;
 },
 setValue: function (value) {
  if (this.setMethod)
   this.setMethod(this.element, value);
  else
   this.element.style[this.setProperty] = value + this.unit;
 },
 SetTransition: function (transition) {
  this.transition = transition.Js;
 }
});
aspxCssAnimationTransition = _aspxCreateClass(aspxAnimationTransitionBase, {
 constructor: function (element, property, unit, onComplete) {
  this.constructor.prototype.constructor.call(this, element, property, unit, onComplete);
  this.transition = aspxAnimationTransitionBase.Transitions.SINE.Css;
  this.transitionPropertyName = aspxCssAnimationTransition.CSS_TRANSITION.transitionPropertyName;
  this.eventName = aspxCssAnimationTransition.CSS_TRANSITION.eventName;
 },
 Start: function (from, to) {
  _aspxAttachEventToElement(this.element, this.eventName, aspxOnCssTransitionEnd);
  this.element.style[this.property] = from + this.unit;
  this.element.style[this.transitionPropertyName] = this.property + " " + this.duration + "ms " + this.transition;
  this.element.style[this.property] = to + this.unit;
 },
 Cancel: function () {
  aspxAnimationTransitionBase.prototype.Cancel.call(this);
  _aspxDetachEventFromElement(this.element, this.eventName, aspxOnCssTransitionEnd);
  this.element.style[this.property] = _aspxGetCurrentStyle(this.element)[this.property];
  this.element.style[this.transitionPropertyName] = "";
 },
 OnCssTransitionEnd: function () {
  this.Cancel();
  this.PerformOnComplete();
 },
 SetTransition: function (transition) {
  this.transition = transition.Css;
 }
});
aspxCssAnimationTransition.CSS_TRANSITION = (function () {
 var cssNames = [
  { transitionPropertyName: "webkitTransition", eventName: "webkitTransitionEnd" },
  { transitionPropertyName: "MozTransition", eventName: "transitionend" },
  { transitionPropertyName: "OTransition", eventName: "oTransitionEnd" },
  { transitionPropertyName: "transition", eventName: "transitionend" }
 ];
 var fakeElement = document.createElement("DIV");
 for (var i = 0; i < cssNames.length; i++)
  if (cssNames[i].transitionPropertyName in fakeElement.style)
   return cssNames[i];
 return null;
})();
function aspxOnCssTransitionEnd(evt) {
 var element = evt.target;
 if (element && element.aspxTransition)
  element.aspxTransition.OnCssTransitionEnd();
};
aspxSlideAnimationTransition = _aspxCreateClass(aspxAnimationTransitionBase, {
 constructor: function (element, horizontal, onComplete) {
  this.constructor.prototype.constructor.call(this, element, null, null, onComplete);
  this.horizontal = horizontal;
  this.animationTransition = aspxSlideAnimationTransition.CSS_TRANSFORM ? this.CreateTransformAnimationTransition() : this.CreatePositionAnimationTransition();
  this.animationTransition.SetTransition(aspxAnimationTransitionBase.Transitions.POW_EASE_OUT);
 },
 Start: function (from, to) {
  if (aspxSlideAnimationTransition.CSS_TRANSFORM)
   this.animationTransition.Start(aspxSlideAnimationTransition.GetCssTranslateText(from, !this.horizontal), aspxSlideAnimationTransition.GetCssTranslateText(to, !this.horizontal));
  else
   this.animationTransition.Start(from, to);
 },
 Cancel: function () {
  this.animationTransition.Cancel();
 },
 SetTransition: function (transition) {
  this.animationTransition.SetTransition(transition);
 },
 SetDuration: function (duratrion) {
  this.animationTransition.SetDuration(duratrion);
 },
 OnCssTransitionEnd: function () {
  this.animationTransition.OnCssTransitionEnd();
 },
 CreateTransformAnimationTransition: function () {
  return new aspxCssAnimationTransition(this.element, aspxSlideAnimationTransition.CSS_TRANSFORM, "", this.onComplete);
 },
 CreatePositionAnimationTransition: function () {
  return ASPxAnimationHelper.createAnimationTransition(this.element, this.horizontal ? "left" : "top", null, "px", this.onComplete);
 }
});
aspxSlideAnimationTransition.GetCssTranslateText = function (position, top) {
 return "matrix(1, 0, 0, 1," + (!top ? position : 0) + ", " + (!top ? 0 : position) + ")";
};
aspxSlideAnimationTransition.GetPosition = function (element, top) {
 if (aspxSlideAnimationTransition.CSS_TRANSFORM) {
  var cssValue = element.style[aspxSlideAnimationTransition.CSS_TRANSFORM];
  return cssValue ? Number(cssValue.replace('matrix(1, 0, 0, 1,', '').replace(')', '').split(',')[!top ? 0 : 1]) : 0;
 }
 else
  return !top ? element.offsetLeft : element.offsetTop;
};
aspxSlideAnimationTransition.SetPosition = function (element, position, top) {
 if (aspxSlideAnimationTransition.CSS_TRANSFORM)
  element.style[aspxSlideAnimationTransition.CSS_TRANSFORM] = aspxSlideAnimationTransition.GetCssTranslateText(position, top);
 else
  element.style[!top ? "left" : "top"] = position + "px";
};
aspxSlideAnimationTransition.CSS_TRANSFORM = (function () {
 if (!aspxCssAnimationTransition.CSS_TRANSITION || __aspxWindowsPlatform && __aspxChrome)
  return null;
 var transformPropertiesNames = ["transform", "MozTransform", "-webkit-transform", "msTransform", "OTransform"];
 var fakeElement = document.createElement("DIV");
 for (var i = 0; i < transformPropertiesNames.length; i++)
  if (transformPropertiesNames[i] in fakeElement.style)
   return transformPropertiesNames[i];
 return null;
})();
var ASPxAnimationHelper = {
 SLIDE_TOP_DIRECTION: 0,
 SLIDE_RIGHT_DIRECTION: 1,
 SLIDE_BOTTOM_DIRECTION: 2,
 SLIDE_LEFT_DIRECTION: 3,
 SCROLL_HORIZONTAL_DIRECTION: 0,
 SCROLL_VERTICAL_DIRECTION: 1,
 SLIDE_CONTAINER_CLASS: "dxAC",
 createAnimationTransition: function (element, property, method, unit, callback) {
  return aspxCssAnimationTransition.CSS_TRANSITION ? new aspxCssAnimationTransition(element, property, unit, callback) :
   new aspxJsAnimationTransition(element, null, method || property, unit, callback);
 },
 setOpacity: function(element, value) {
  if (__aspxIE && __aspxBrowserVersion < 8) 
   element.style.zoom = 1;
  _aspxSetElementOpacity(element, value);
 },
 fadeIn: function (element, callback) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  var tween = element.aspxTransition = new aspxJsAnimationTransition(element, null, function (el, value) { ASPxAnimationHelper.setOpacity(el, value); }, "", callback);
  tween.Start(0, 1);
 },
 fadeOut: function (element, callback) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  var tween = element.aspxTransition = new aspxJsAnimationTransition(element, null, function (el, value) { ASPxAnimationHelper.setOpacity(el, value); }, "", callback);
  tween.Start(1, 0);
 },
 fadeTo: function (element, to, callback) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  var aTransition = element.aspxTransition = ASPxAnimationHelper.createAnimationTransition(element, "opacity", function (el, value) { ASPxAnimationHelper.setOpacity(el, value); }, "", callback);
  aTransition.Start(_aspxGetElementOpacity(element), to);
 },
 findSlideAnimationContainer: function (element) {
  return _aspxGetParentByClassName(element, ASPxAnimationHelper.SLIDE_CONTAINER_CLASS);
 },
 createSlideAnimationContainer: function (element) {
  var rootContainer = document.createElement("DIV");
  rootContainer.className = ASPxAnimationHelper.SLIDE_CONTAINER_CLASS;
  rootContainer.style.overflow = "hidden";
  var elementContainer = document.createElement("DIV");
  rootContainer.appendChild(elementContainer);
  var parentNode = element.parentNode;
  parentNode.insertBefore(rootContainer, element);
  elementContainer.appendChild(element);
  return rootContainer;
 },
 getSlideAnimationContainer: function (element, create, fixSize) {
  var width = element.offsetWidth;
  var height = element.offsetHeight;
  var container;
  if(element.className == ASPxAnimationHelper.SLIDE_CONTAINER_CLASS)
   container = element;
  if(!container)
   container = ASPxAnimationHelper.findSlideAnimationContainer(element);
  if(!container && create) 
   container = ASPxAnimationHelper.createSlideAnimationContainer(element);
  if(container && fixSize){
   container.style.width = width + "px";
   container.style.height = height + "px";
   container.firstChild.style.width = width + "px";
   container.firstChild.style.height = height + "px";
  }
  return container;
 },
 resetSlideAnimationContainerSize: function (container) {
  container.style.width = "";
  container.style.height = "";
  container.firstChild.style.width = "";
  container.firstChild.style.height = "";
 },
 getModifyProperty: function (direction) {
  if (direction == ASPxAnimationHelper.SLIDE_TOP_DIRECTION || direction == ASPxAnimationHelper.SLIDE_BOTTOM_DIRECTION)
   return "marginTop";
  return "marginLeft";
 },
 createSlideInTween: function (animationContainer, direction, complete) {
  return new aspxJsAnimationTransition(animationContainer.firstChild, ASPxAnimationHelper.getModifyProperty(direction), ASPxAnimationHelper.getModifyProperty(direction), "px", complete);
 },
 getSlideInStartPos: function (animationContainer, direction) {
  switch(direction) {
   case ASPxAnimationHelper.SLIDE_TOP_DIRECTION:
    return animationContainer.offsetHeight;
   case ASPxAnimationHelper.SLIDE_LEFT_DIRECTION:
    return animationContainer.offsetWidth;
   case ASPxAnimationHelper.SLIDE_RIGHT_DIRECTION:
    return -animationContainer.offsetWidth;
   case ASPxAnimationHelper.SLIDE_BOTTOM_DIRECTION:    
    return -animationContainer.offsetHeight;
  }
 },
 slideIn: function (element, direction, callback) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  ASPxAnimationHelper.setOpacity(element, 1);
  var animationContainer = ASPxAnimationHelper.getSlideAnimationContainer(element, true, true);
  var pos = ASPxAnimationHelper.getSlideInStartPos(animationContainer, direction);
  var tween = element.aspxTransition = ASPxAnimationHelper.createSlideInTween(animationContainer, direction, 
   function (el) {
    ASPxAnimationHelper.resetSlideAnimationContainerSize(animationContainer);
    if(callback)
     callback(el);
   });
  tween.Start(pos, 0);
 },
 createSlideOutTween: function (animationContainer, direction, complete) {
  return new aspxJsAnimationTransition(animationContainer.firstChild, ASPxAnimationHelper.getModifyProperty(direction), ASPxAnimationHelper.getModifyProperty(direction), "px", complete);
 },
 getSlideOutFinishPos: function (animationContainer, direction) {
  switch (direction) {
   case ASPxAnimationHelper.SLIDE_TOP_DIRECTION:
    return -animationContainer.offsetHeight;
   case ASPxAnimationHelper.SLIDE_LEFT_DIRECTION:
    return -animationContainer.offsetWidth;
   case ASPxAnimationHelper.SLIDE_RIGHT_DIRECTION:
    return animationContainer.offsetWidth;
   case ASPxAnimationHelper.SLIDE_BOTTOM_DIRECTION:
    return animationContainer.offsetHeight;
  }
 },
 slideOut: function (element, direction, callback) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  var animationContainer = ASPxAnimationHelper.getSlideAnimationContainer(element, true, true);
  var pos = ASPxAnimationHelper.getSlideOutFinishPos(animationContainer, direction);
  var tween = element.aspxTransition = ASPxAnimationHelper.createSlideOutTween(animationContainer, direction, 
   function (el) {
    ASPxAnimationHelper.setOpacity(el.firstChild, 0);
    if (callback)
     callback(el);
   });
  tween.Start(null, pos);
 },
 scrollTo: function (element, horizontal, to, callBack) {
  if (aspxAnimationTransitionBase.IsStarted(element))
   aspxAnimationTransitionBase.Cancel(element);
  var from = aspxSlideAnimationTransition.GetPosition(element, !horizontal);
  var aTransition = element.aspxTransition = new aspxSlideAnimationTransition(element, horizontal, callBack);
  aTransition.Start(from, to);
 },
 cancelAnimation: function(element){ 
  aspxAnimationTransitionBase.Cancel(element);
 }
};
var ASPxGesturesHelper = {
 handlers: {},
 activeHandler: null,
 isAttachedEvents: false,
 AddSwipeGestureHandler: function(id, getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel) {
  this.handlers[id] = new ASPxSwipeGestureHandler(getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel);
 },
 UpdateSwipeAnimationContainer: function (id) {
  if (this.handlers[id])
   this.handlers[id].UpdateAnimationContainer();
 },
 AddSwipeSlideGestureHandler: function (id, slideElement, isHorizontal, canHandle, backward, forward, rollback, onExecuteGesture) {
  this.handlers[id] = new ASPxSwipeSlideGestureHandler(slideElement, isHorizontal, canHandle, backward, forward, rollback, onExecuteGesture);
 },
 OnDocumentMouseDown: function(evt) {
  if (!_aspxGetIsLeftButtonPressed(evt))
   return;
  ASPxGesturesHelper.activeHandler = ASPxGesturesHelper.FindHandler(evt);
  if(ASPxGesturesHelper.activeHandler)
   ASPxGesturesHelper.activeHandler.OnMouseDown(evt);
 },
 OnDocumentMouseMove: function(evt) {
  if (ASPxGesturesHelper.activeHandler) 
   ASPxGesturesHelper.activeHandler.OnMouseMove(evt);
 },
 OnDocumentMouseUp: function(evt) {
  if (ASPxGesturesHelper.activeHandler) {
   ASPxGesturesHelper.activeHandler.OnMouseUp(evt);
   ASPxGesturesHelper.activeHandler = null;
  }
 },
 AttachEvents: function() {
  if(!ASPxGesturesHelper.isAttachedEvents) {
   ASPxGesturesHelper.Attach(_aspxAttachEventToElement);
   ASPxGesturesHelper.isAttachedEvents = true;
  }
 },
 DetachEvents: function() {
  if(ASPxGesturesHelper.isAttachedEvents) {
   ASPxGesturesHelper.Attach(_aspxDetachEventFromElement);
   ASPxGesturesHelper.isAttachedEvents = false;
  }
 },
 Attach: function(changeEventsMethod) {
  changeEventsMethod(window.document, ASPxClientTouchUI.touchMouseDownEventName, ASPxGesturesHelper.OnDocumentMouseDown);
  changeEventsMethod(window.document, ASPxClientTouchUI.touchMouseMoveEventName, ASPxGesturesHelper.OnDocumentMouseMove);
  changeEventsMethod(window.document, ASPxClientTouchUI.touchMouseUpEventName, ASPxGesturesHelper.OnDocumentMouseUp);
 },
 FindHandler: function (evt) {
  var handler = null;
  for(var id in ASPxGesturesHelper.handlers) {
   if(ASPxGesturesHelper.handlers[id].CanHandleEvent(evt))
    handler = ASPxGesturesHelper.handlers[id];
  }
  return handler;
 }
};
ASPxGesturesHelper.AttachEvents();
ASPxGestureHandler = _aspxCreateClass(null, {
 constructor: function (canHandle, allowStart) {
  this.canHandle = canHandle;
  this.allowStart = allowStart;
  this.startMousePosX = 0;
  this.startMousePosY = 0;
  this.startTime = null;
 },
 OnMouseDown: function (evt) {
  if (!__aspxTouchUI)
   _aspxPreventEvent(evt); 
  this.startMousePosX = _aspxGetEventX(evt);
  this.startMousePosY = _aspxGetEventY(evt);
  this.startTime = new Date();
 },
 OnMouseMove: function (evt) {
 },
 OnMouseUp: function (evt) {
 },
 CanHandleEvent: function (evt) {
  return !this.canHandle || this.canHandle(evt);
 },
 IsStartAllowed: function (value) {
  return !this.allowStart || this.allowStart(value);
 },
 RollbackGesture: function () {
 },
 GetRubberPosition: function (position) {
  return position / ASPxGestureHandler.FACTOR_RUBBER;
 },
 GetCurrentDistanceX: function (evt) {
  return _aspxGetEventX(evt) - this.startMousePosX;
 },
 GetCurrentDistanceY: function (evt) {
  return _aspxGetEventY(evt) - this.startMousePosY;
 },
 GetDistanceLimit: function () {
  return (new Date() - this.startTime) < ASPxGestureHandler.MAX_TIME_SPAN ? ASPxGestureHandler.MIN_DISTANCE_LIMIT : ASPxGestureHandler.MAX_DISTANCE_LIMIT;
 }
});
ASPxGestureHandler.MAX_DISTANCE_LIMIT = 70;
ASPxGestureHandler.MIN_DISTANCE_LIMIT = 10;
ASPxGestureHandler.MIN_START_DISTANCE = 0;
ASPxGestureHandler.SLIDER_MIN_START_DISTANCE = 5;
ASPxGestureHandler.MAX_TIME_SPAN = 300;
ASPxGestureHandler.FACTOR_RUBBER = 4;
ASPxGestureHandler.RETURN_ANIMATION_DURATION = 150;
ASPxSwipeSlideGestureHandler = _aspxCreateClass(ASPxGestureHandler, {
 constructor: function (slideElement, horizontal, canHandle, backward, forward, rollback, onExecuteGesture) {
  this.constructor.prototype.constructor.call(this, canHandle);
  this.slideElement = slideElement;
  this.horizontal = horizontal;
  this.backward = backward;
  this.forward = forward;
  this.rollback = rollback;
  this.onExecuteGesture = onExecuteGesture;
  this.container = this.slideElement.parentNode;
  this.elementStartPos = 0;
 },
 OnMouseDown: function (evt) {
  ASPxGestureHandler.prototype.OnMouseDown.call(this, evt);
  this.startElementPos = this.GetSlideElementPosition();
 },
 OnMouseMove: function (evt) {
  if (!__aspxTouchUI && !_aspxGetIsParent(this.container, _aspxGetEventSource(evt))) {
   ASPxGesturesHelper.activeHandler = null;
   this.OnMouseUp(evt);
   return;
  }
  var currentDistance = this.horizontal ? this.GetCurrentDistanceX(evt) : this.GetCurrentDistanceY(evt);
  if (Math.abs(currentDistance) < ASPxGestureHandler.SLIDER_MIN_START_DISTANCE || ASPxClientTouchUI.isGesture)
   return;
  _aspxPreventEvent(evt);
  this.onExecuteGesture();
  aspxAnimationTransitionBase.Cancel(this.slideElement);
  var minLimitPosition = 0, maxLimitPozition = -(this.GetSlideElementSize() - this.GetContainerElementSize());
  var currentPosition = this.startElementPos + currentDistance;
  if (currentPosition > minLimitPosition)
   currentPosition = this.GetRubberPosition(currentPosition);
  else if (currentPosition < maxLimitPozition)
   currentPosition = maxLimitPozition + this.GetRubberPosition((currentPosition - maxLimitPozition));
  this.SetSlideElementPosition(currentPosition);
 },
 OnMouseUp: function (evt) {
  var distance = this.horizontal ? this.GetCurrentDistanceX(evt) : this.GetCurrentDistanceY(evt);
  if (distance == 0)
   return;
  else if (this.CheckSlidePanelIsOutOfBounds())
   this.PerformRollback();
  else {
   if (Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if (distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  }
 },
 PerformBackward: function () {
  this.backward();
 },
 PerformForward: function () {
  this.forward();
 },
 PerformRollback: function () {
  this.rollback();
 },
 CheckSlidePanelIsOutOfBounds: function () {
  var minOffset = -(this.GetSlideElementSize() - this.GetContainerElementSize()), maxOffset = 0;
  var position = null, slideElementPos = this.GetSlideElementPosition();
  if (slideElementPos > maxOffset || slideElementPos < minOffset)
   return true;
  return false;
 },
 GetSlideElementSize: function () {
  return this.horizontal ? this.slideElement.offsetWidth : this.slideElement.offsetHeight;
 },
 GetContainerElementSize: function () {
  return this.horizontal ? _aspxGetClearClientWidth(this.container) : _aspxGetClearClientHeight(this.container);
 },
 SetSlideElementPosition: function (position) {
  aspxSlideAnimationTransition.SetPosition(this.slideElement, position, !this.horizontal);
 },
 GetSlideElementPosition: function () {
  return aspxSlideAnimationTransition.GetPosition(this.slideElement, !this.horizontal);
 }
});
ASPxSwipeGestureHandler = _aspxCreateClass(ASPxGestureHandler, {
 constructor: function (getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel) {
  this.constructor.prototype.constructor.call(this, canHandle, allowStart);
  this.getAnimationElement = getAnimationElement;
  this.start = start;
  this.allowComplete = allowComplete;
  this.complete = complete;
  this.cancel = cancel;
  this.animationTween = null;
  this.currentDistanceX = 0;
  this.currentDistanceY = 0;
  this.tryStartGesture = false;
  this.tryStartScrolling = false;
  this.savedElements = [];
  this.UpdateAnimationContainer();
 },
 UpdateAnimationContainer: function () {
  this.animationContainer = ASPxAnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, false);
 },
 CanHandleEvent: function(evt) {
  if(ASPxGestureHandler.prototype.CanHandleEvent.call(this, evt))
   return true;
  return this.animationTween && this.animationContainer && _aspxGetIsParent(this.animationContainer, _aspxGetEventSource(evt));
 },
 OnMouseDown: function (evt) {
  ASPxGestureHandler.prototype.OnMouseDown.call(this, evt);
  if(this.animationTween) 
   this.animationTween.Cancel();
  this.currentDistanceX = 0;
  this.currentDistanceY = 0;
 },
 OnMouseMove: function(evt) {
  this.currentDistanceX = this.GetCurrentDistanceX(evt);
  this.currentDistanceY = this.GetCurrentDistanceY(evt);
  if (!this.animationTween && !this.tryStartScrolling && (Math.abs(this.currentDistanceX) > ASPxGestureHandler.MIN_START_DISTANCE || Math.abs(this.currentDistanceY) > ASPxGestureHandler.MIN_START_DISTANCE)) {
   if(Math.abs(this.currentDistanceY) < Math.abs(this.currentDistanceX)) {
    this.tryStartGesture = true;
    if(this.IsStartAllowed(this.currentDistanceX)) {
     this.animationContainer = ASPxAnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, true);
     this.animationTween = ASPxAnimationHelper.createSlideOutTween(this.animationContainer, ASPxAnimationHelper.SLIDE_LEFT_DIRECTION, 
      function() {
       ASPxAnimationHelper.resetSlideAnimationContainerSize(this.animationContainer);
       this.animationContainer = null;
       this.animationTween = null;
      }.aspxBind(this));
     this.PerformStart(this.currentDistanceX);
     this.AttachPreventEvents(evt);
    }
   }
   else
    this.tryStartScrolling = true;
  }
  if(this.animationTween) {
   if(this.allowComplete && !this.allowComplete(this.currentDistanceX)) 
    this.currentDistanceX = this.GetRubberPosition(this.currentDistanceX);
   this.animationTween.setValue(this.currentDistanceX);
  }
  if(!this.tryStartScrolling && !ASPxClientTouchUI.isGesture && evt.touches && evt.touches.length < 2)
   _aspxPreventEvent(evt);
 },
 OnMouseUp: function(evt) {
  if(!this.animationTween) {
   if(this.tryStartGesture)
    this.PerformCancel(this.currentDistanceX);
  }
  else{
   if(Math.abs(this.currentDistanceX) < this.GetDistanceLimit()) 
    this.RollbackGesture();
   else {
    if(this.IsCompleteAllowed(this.currentDistanceX)) {
     this.PerformComplete(this.currentDistanceX);
     this.animationContainer = null;
     this.animationTween = null;
    }
    else
     this.RollbackGesture();
   }
  }
  this.DetachPreventEvents();
  this.tryStartGesture = false;
  this.tryStartScrolling = false;
 },
 PerformStart: function(value) {
  if(this.start)
   this.start(value);
 },
 IsCompleteAllowed: function(value) {
  return !this.allowComplete || this.allowComplete(value);
 },
 PerformComplete: function(value) {
  if(this.complete)
   this.complete(value);
 },
 PerformCancel: function(value) {
  if(this.cancel)
   this.cancel(value);
 },
 RollbackGesture: function() {
  this.animationTween.Start(this.currentDistanceX, 0);
 },
 AttachPreventEvents: function(evt) {
  var element = _aspxGetEventSource(evt);
  while(element && element != this.animationContainer) {
   _aspxAttachEventToElement(element, "mouseup", this.PreventEvent);
   _aspxAttachEventToElement(element, "click", this.PreventEvent);
   this.savedElements.push(element);
   element = element.parentNode;
  }
 },
 DetachPreventEvents: function() {
  window.setTimeout(function() {
   while(this.savedElements.length > 0) {
    var element = this.savedElements.pop();
    _aspxDetachEventFromElement(element, "mouseup", this.PreventEvent);
    _aspxDetachEventFromElement(element, "click", this.PreventEvent);
    }
  }.aspxBind(this), 0);
 },
 PreventEvent: function (evt) {
  return _aspxPreventEvent(evt);
 }
});
