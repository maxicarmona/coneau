ASPxClientGridView = _aspxCreateClass(ASPxClientControl, {
 MainTableID: "DXMainTable",
 HeaderTableID: "DXHeaderTable", 
 FooterTableID: "DXFooterTable",
 DataRowID: "DXDataRow",
 PreviewRowID: "DXPRow",
 GroupRowID: "DXGroupRow",
 FixedColumnsDivID: "DXFixedColumnsDiv",
 FixedColumnsContentDivID: "DXFixedColumnsContentDiv",
 CustomizationWindowSuffix: "_custwindow",
 EmptyHeaderSuffix: "_emptyheader", 
 HeaderRowID: "_DXHeadersRow",
 HeaderFilterButtonClassName: "dxgv__hfb",
 CommandId: {
  NextPage: "NEXTPAGE",
  PreviousPage: "PREVPAGE",
  GotoPage: "GOTOPAGE",
  SelectRows: "SELECTROWS",
  SelectRowsKey: "SELECTROWSKEY",
  Group: "GROUP",
  UnGroup: "UNGROUP",
  Sort: "SORT",
  ColumnMove: "COLUMNMOVE",
  CollapseAll: "COLLAPSEALL",
  ExpandAll: "EXPANDALL",
  ExpandRow: "EXPANDROW",
  CollapseRow: "COLLAPSEROW",
  HideAllDetail: "HIDEALLDETAIL",
  ShowAllDetail: "SHOWALLDETAIL",
  ShowDetailRow: "SHOWDETAILROW",
  HideDetailRow: "HIDEDETAILROW",
  PagerOnClick: "PAGERONCLICK",
  ApplyFilter: "APPLYFILTER",
  ApplyColumnFilter: "APPLYCOLUMNFILTER",
  ApplyHeaderColumnFilter: "APPLYHEADERCOLUMNFILTER",
  FilterRowMenu: "FILTERROWMENU",
  StartEdit: "STARTEDIT",
  CancelEdit: "CANCELEDIT",
  UpdateEdit: "UPDATEEDIT",
  AddNewRow: "ADDNEWROW",
  DeleteRow: "DELETEROW",
  CustomButton: "CUSTOMBUTTON",
  CustomCallback: "CUSTOMCALLBACK",
  ShowFilterControl: "SHOWFILTERCONTROL",
  CloseFilterControl: "CLOSEFILTERCONTROL",
  SetFilterEnabled: "SETFILTERENABLED",
  Refresh: "REFRESH",
  SelFieldValues: "SELFIELDVALUES",
  RowValues: "ROWVALUES",
  PageRowValues: "PAGEROWVALUES",
  FilterPopup: "FILTERPOPUP",
  CustomValues: "CUSTOMVALUES"
 },
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.callBacksEnabled = true;
  this.custwindowLeft = null;
  this.custwindowTop = null;
  this.custwindowVisible = null;
  this.activeElement = null;
  this.filterKeyPressInputValue = "";
  this.userChangedSelection = false;
  this.lockFilter = false;
  this.confirmDelete = "";
  this.filterKeyPressTimerId = -1;
  this.filterRowMenuColumnIndex = -1;
  this.editorIDList = [ ];
  this.keys = [ ];
  this.lastMultiSelectIndex = -1;
  this.hasFooterRowTemplate = false;
  this.mainTableClickData = {
   processing: false,
   focusChanged: false,
   selectionChanged: false
  };
  this.afterCallbackRequired = false;
  this.headerFilterPopupDimensions = { };
  this.enableHeaderFilterCaching = true;
  this.inPostBack = false;
  this.supportGestures = true;
  this.checkBoxImageProperties = null;
  this.internalCheckBoxCollection = null;
  this.sizingConfig.adjustControl = true;
  this.lookupBehavior = false;
  this.SelectionChanged = new ASPxClientEvent();
  this.FocusedRowChanged = new ASPxClientEvent();
  this.ColumnSorting = new ASPxClientEvent();
  this.ColumnGrouping = new ASPxClientEvent();
  this.ColumnMoving = new ASPxClientEvent();
  this.ColumnStartDragging  = new ASPxClientEvent();
  this.ColumnResizing  = new ASPxClientEvent();
  this.ColumnResized  = new ASPxClientEvent();
  this.RowExpanding  = new ASPxClientEvent();
  this.RowCollapsing  = new ASPxClientEvent();
  this.DetailRowExpanding  = new ASPxClientEvent();
  this.DetailRowCollapsing  = new ASPxClientEvent();
  this.RowClick  = new ASPxClientEvent();
  this.RowDblClick  = new ASPxClientEvent();
  this.ContextMenu = new ASPxClientEvent();
  this.CustomizationWindowCloseUp = new ASPxClientEvent();
  this.CustomButtonClick = new ASPxClientEvent();
  this.InternalCheckBoxClick = new ASPxClientEvent();
  this.funcCallbacks = [ ];
  this.pendingCommands = [ ];
  this.pageRowCount = 0;
  this.pageRowSize = 0;
  this.pageIndex = 0;
  this.pageCount = 1;
  this.allowFocusedRow = false;
  this.allowSelectByRowClick = false;
  this.allowSelectSingleRowOnly = false;
  this.focusedRowIndex = -1;
  this.selectedWithoutPageRowCount = 0;
  this.visibleStartIndex = 0;
  this.columns = [ ];
  this.columnResizeMode = ASPxColumnResizeMode.None;
  this.fixedColumnCount = 0;
  this.horzScroll = ASPxScrollBarMode.Hidden;
  this.vertScroll = ASPxScrollBarMode.Hidden;
  this.scrollToRowIndex = -1;
  this.isVirtualScrolling = false;  
  this.callbackOnFocusedRowChanged = false;
  this.callbackOnSelectionChanged = false;
  this.autoFilterDelay = 1200;
  this.editState = 0;
  this.kbdHelper = null;
  this.tableHelper = null;
  this.enableKeyboard = false;
  this.keyboardLock = false;
  this.accessKey = null;
  this.customKbdHelperName = null;
  this.dragHelper = null;
  this.icbFocusedStyle = null;
  this.pendingEvents = [ ];
  this.rowHotTrackStyle = null;
  this.rowHotTrackItemsBag = { };
 },
 HasHorzScroll: function() { return this.horzScroll != ASPxScrollBarMode.Hidden; },
 HasVertScroll: function() { return this.vertScroll != ASPxScrollBarMode.Hidden; },
 HasScrolling: function() { return this.HasHorzScroll() || this.HasVertScroll(); },
 AllowResizing: function() { return this.columnResizeMode != ASPxColumnResizeMode.None; },
 _isGroupRow: function(row) { return row.id.indexOf(this.GroupRowID) > -1; },
 IsHeaderRow: function(row) { return this.IsHeaderRowID(row.id); },
 IsHeaderRowID: function(id) { return id.indexOf(this.name + this.HeaderRowID) == 0; },
 IsEmptyHeaderID: function(id) { return id.indexOf(this.EmptyHeaderSuffix) > -1 },
 GetRootTable: function() { return _aspxGetElementById(this.name); },
 GetGridTD: function() { 
  var table = this.GetRootTable();
  if(!table) return null;
  return table.rows[0].cells[0];
 },
 GetArrowDragDownImage: function() { return this.GetChildElementById("IADD"); },
 GetArrowDragUpImage: function() { return this.GetChildElementById("IADU"); },
 GetArrowDragFieldImage: function() { return this.GetChildElementById("IDHF"); },
 GetCallbackState: function() { return this.GetChildElementById("CallbackState"); },
 GetSelectionInput: function() { return this.GetChildElementById("DXSelInput"); },
 GetKeyValuesInput: function() { return this.GetChildElementById("DXKVInput"); },
 GetFocusedRowInput: function() { return this.GetChildElementById("DXFocusedRowInput"); },
 GetColResizedInput: function() { return this.GetChildElementById("DXColResizedInput"); },
 GetPostBackSyncInput: function() { return this.GetChildElementById("DXSyncInput"); },
 GetLoadingPanelDiv: function() {  return this.GetChildElementById("LPD"); },
 GetFixedColumnsDiv: function() {  return this.GetChildElementById(this.FixedColumnsDivID); },
 GetRow: function(visibleIndex) { 
  var res = this.GetDataRow(visibleIndex);
  if(res == null) res = this.GetGroupRow(visibleIndex);
  return res;
 },
 GetDataRow: function(visibleIndex) { return this.GetChildElementById(this.DataRowID + visibleIndex); },
 GetPreviewRow: function(visibleIndex) { return this.GetChildElementById(this.PreviewRowID + visibleIndex); },
 GetGroupRow: function(visibleIndex) { 
  var element = this.GetChildElementById(this.GroupRowID + visibleIndex);
  if(!element)
   element = this.GetExpandedGroupRow(visibleIndex);
  return element; 
 },
 GetExpandedGroupRow: function(visibleIndex) { return this.GetChildElementById(this.GroupRowID + "Exp" + visibleIndex); },
 GetDataRowSelBtn: function(index) { return this.GetChildElementById("DXSelBtn" + index); },
 GetMainTable: function() { return this.GetChildElementById(this.MainTableID); },
 GetStyleTable: function() { return this.GetChildElementById("DXStyleTable"); },
 GetLoadingPanelContainer: function() { return this.GetChildElementById("DXLPContainer"); },
 GetGroupPanel: function() { return this.GetChildElementById("grouppanel"); },
 GetHeader: function(columnIndex, inGroupPanel) { 
  var id = "col" + columnIndex;
  if(inGroupPanel)
   id = "group" + id;
  return this.GetChildElementById(id); 
 },
 GetHeaderRow: function(index) {
  return _aspxGetElementById(this.name + this.HeaderRowID + index);
 },
 GetEditingRow: function(obj) { return _aspxGetElementById(obj.name + "_DXEditingRow"); },
 GetEditingErrorRow: function(obj) { return _aspxGetElementById(obj.name + "_DXEditingErrorRow"); },
 GetEditFormTable: function() { return _aspxGetElementById(this.name + "_DXEFT"); },
 GetCustomizationWindow: function() { return aspxGetControlCollection().Get(this.name + this.CustomizationWindowSuffix); },
 GetParentRowsWindow: function() { return aspxGetControlCollection().Get(this.name + "_DXparentrowswindow"); },
 GetEditorPrefix: function() { return "DXEditor"; },
 GetPopupEditForm: function() { return aspxGetControlCollection().Get(this.name  + "_DXPEForm"); },
 GetFilterRowMenu: function() { return aspxGetControlCollection().Get(this.name + "_DXFilterRowMenu"); },
 GetFilterControlPopup: function() { return aspxGetControlCollection().Get(this.name + "_DXPFCForm"); },
 GetFilterControl: function() { return aspxGetControlCollection().Get(this.name +  "_DXPFCForm_DXPFC"); }, 
 GetHeaderFilterPopup: function() { return aspxGetControlCollection().Get(this.name + "_DXHFP"); },
 GetHeaderFilterListBox: function() { return aspxGetControlCollection().Get(this.name + "_HFListBox"); },
 GetHeaderFilterSelectAllCheckBox: function() { return aspxGetControlCollection().Get(this.name + "_HFSACheckBox"); },
 GetEditorByColumnIndex: function(colIndex) { 
  var list = this._getEditors();
  for(var i = 0; i < list.length; i++) {
   if(this._getNumberFromEndOfString(list[i].name) == colIndex) return list[i];
  }
  return null;
 }, 
 Initialize: function(){
  this.constructor.prototype.Initialize.call(this);
  if(this.enabled)
   this.SetHeadersClientEvents();
  this.EnsureRowKeys();
  this._setFocusedRowInputValue();
  this.AddSelectStartHandler();
  this.EnsureRowHotTrackItems();
  if(this.enableKeyboard) {
   this.kbdHelper = this.customKbdHelperName ? new window[this.customKbdHelperName](this) : new ASPxGridViewKbdHelper(this);
   this.kbdHelper.Init();
   ASPxKbdHelper.RegisterAccessKey(this);
  }
  if(this.checkBoxImageProperties) 
   this.CreateInternalCheckBoxCollection();
  this.CheckPendingEvents();
  this.InitializeHeaderFilterPopup();
  var resizingHelper = this.GetResizingHelper();
  if(resizingHelper)
   resizingHelper.ResetStretchedColumnWidth();
 },
 EnsureRowKeys: function() {
  var keyValuesInput = this.GetKeyValuesInput();
  if(keyValuesInput)
   this.keys = eval(keyValuesInput.value);
  if(!this.keys)
   this.keys = [ ];
 }, 
 InitializeHeaderFilterPopup: function() {
  var popup = this.GetHeaderFilterPopup();
  if(!popup)
   return;
  popup.PopUp.AddHandler(function() { this.OnPopUpHeaderFilterWindow(); }.aspxBind(this));
  popup.CloseUp.AddHandler(function(s) { 
   if(!this.UseHFContentCaching())
    window.setTimeout(function() { s.SetContentHtml(""); }, 0);
  }.aspxBind(this));
  popup.Resize.AddHandler(function(s) { 
   var colIndex = this.FindColumnIndexByHeaderChild(s.GetCurrentPopupElement());
   var column = this._getColumn(colIndex);
   if(!column) return;
   this.SetHeaderFilterPopupSize(colIndex, s.GetWidth(), s.GetHeight());
  }.aspxBind(this));
  var buttons = this.GetHeaderFilterButtons();
  for(var i = 0; i < buttons.length; i++)
   popup.AddPopupElement(buttons[i]);
 },
 GetHeaderFilterButtons: function() {
  var buttons = [ ];
  for(var i = 0; i < this.GetColumnsCount(); i++) {
   if(!this.GetColumn(i).visible)
    continue;
   this.PopulateHeaderFilterButtons(this.GetHeader(i, false), buttons);
   this.PopulateHeaderFilterButtons(this.GetHeader(i, true), buttons);
  }
  var custWindow = this.GetCustomizationWindow();
  if(custWindow)
   this.PopulateHeaderFilterButtons(custWindow.GetWindowClientTable(-1), buttons);
  return buttons;
 },
 PopulateHeaderFilterButtons: function(container, buttons) {
  if(!container) return;
  var images = container.getElementsByTagName("IMG");
  for(var i = 0; i < images.length; i++) {
   var image = images[i];
   if(_aspxElementCssClassContains(image, this.HeaderFilterButtonClassName))
    buttons.push(image);
  }
 },
 UseHFContentCaching: function() {
  var listBox = this.GetHeaderFilterListBox();
  if(listBox && listBox.GetMainElement())
   return this.enableHeaderFilterCaching && listBox.GetItemCount() < 1000;
  return false;
 },
 OnPopUpHeaderFilterWindow: function() {
  var popup = this.GetHeaderFilterPopup();
  var colIndex = this.FindColumnIndexByHeaderChild(popup.GetCurrentPopupElement());
  var column = this._getColumn(colIndex);
  if(!column) return;
  var shiftKey = popup.GetPopUpReasonMouseEvent().shiftKey;
  var listBox = this.GetHeaderFilterListBox();
  if(listBox && listBox.cpGVColumnIndex == colIndex && this.UseHFContentCaching() && popup.savedShiftKey === shiftKey) {
   this.RestoreHFListBoxPreviousState(listBox, column);
   return;
  }
  popup.savedShiftKey = shiftKey;
  this.gridFuncCallBack([this.CommandId.FilterPopup, this.name, colIndex, shiftKey ? "T" : ""], this.onFilterPopupCallback);
  popup.SetContentHtml("");
  var buttonPanel = document.getElementById(popup.cpButtonPanelID);
  if(buttonPanel) {
   buttonPanel.style.display = column.HFCheckedList ? "" : "none";
   this.SetHFOkButtonEnabled(false);
  }
  var size = this.GetHeaderFilterPopupSize(colIndex);
  if(size) {
   popup.SetSize(size[0], size[1]);
   if(__aspxFirefox)
    popup.Shown.AddHandler(function(s) { 
     window.setTimeout(function() { s.SetSize(size[0], size[1]); }, 0); 
    });
  }
  this.CreateHeaderFilterLoadingPanel(popup);
 },
 CreateHeaderFilterLoadingPanel: function(popup) {
  var contentElement = popup.GetContentContainer(-1);
  var loadingPanel = this.CreateLoadingPanelInsideContainer(contentElement, false, true, true);
  var contentStyle = _aspxGetCurrentStyle(contentElement);
  if(!loadingPanel || !contentStyle)
   return;
  var elements = [];
  elements.push(loadingPanel.tagName == "TABLE" ? loadingPanel : _aspxGetChildByTagName(loadingPanel, "TABLE", 0));
  var cells = _aspxGetElementsByTagName(loadingPanel, "TD");
  if(!cells) cells = [];
  for(var i = 0; i < cells.length; i++)
   elements.push(cells[i]);
  for(var i = 0; i < elements.length; i++) {
   var el = elements[i];
   el.style.borderWidth = 0;
   el.style.backgroundColor = contentStyle.backgroundColor;
   if(_aspxIsExists(el.style.boxShadow))
      el.style.boxShadow = "none";
   else if(_aspxIsExists(el.style.MozBoxShadow))
    el.style.MozBoxShadow = "none";
   else if(_aspxIsExists(el.style.webkitBoxShadow))
    el.style.webkitBoxShadow = "none";
  }
 },
 RestoreHFListBoxPreviousState: function(listBox, column) {
  if(!column.HFCheckedList) 
   return;
  listBox.UnselectAll();
  listBox.SelectIndices(listBox.HFSavedSelectedIndices);
  this.UpdateHFSelectAllCheckState();
  this.SetHFOkButtonEnabled(false);
 },
 SetHFOkButtonEnabled: function(enabled) {
  var popup = this.GetHeaderFilterPopup();
  if(!popup) return;
  var button = aspxGetControlCollection().Get(popup.cpOkButtonID);
  if(!button) return;
  button.SetEnabled(enabled);
 },
 GetHeaderFilterPopupSize: function(key) {
  var size = this.headerFilterPopupDimensions[key];
  if(size) return size;
  if(!this.headerFilterPopupDimensions["Default"]) {
   var popup = this.GetHeaderFilterPopup();
   this.SetHeaderFilterPopupSize("Default", popup.GetWidth(), popup.GetHeight());
  }
  return this.headerFilterPopupDimensions["Default"];
 },
 SetHeaderFilterPopupSize: function(key, width, height) {
  this.headerFilterPopupDimensions[key] = [ width, height ];
 },
 FindColumnIndexByHeaderChild: function(element) {
  if(!element) 
   return -1;
  var level = 0;
  while(level < 6) {
   var index = this.getColumnIndex(element.id);
   if(index > -1)
    return index;
   element = element.parentNode;
   level++;
  }
  return -1;
 },
 InitializeHFListBox: function(listBox) {
  _aspxAttachEventToElement(listBox.GetListTable(), "mousedown", function() { window.setTimeout(_aspxClearSelection, 0); });
  listBox.SelectedIndexChanged.AddHandler(function(s) { this.OnHFListBoxSelectionChanged(s); }.aspxBind(this));
  listBox.HFSavedSelectedIndices = listBox.GetSelectedIndices();
 },
 OnHFListBoxSelectionChanged: function(listBox) {
  var column = this.GetColumn(listBox.cpGVColumnIndex);
  if(!column) return;
  if(!column.HFCheckedList) {
   this.ApplyHeaderFilterByColumn();
   return;
  }
  this.UpdateHFSelectAllCheckState();
  this.SetHFOkButtonEnabled(this.IsHFSelectedIndicesChanged());
 },
 UpdateHFSelectAllCheckState: function() {
  var listBox = this.GetHeaderFilterListBox();
  var selectedItemCount = listBox.GetSelectedIndices().length;
  var checkState = ASPxClientCheckBoxCheckState.Indeterminate;
  if(selectedItemCount == 0)
   checkState = ASPxClientCheckBoxCheckState.Unchecked;
  else if(selectedItemCount == listBox.GetItemCount())
   checkState = ASPxClientCheckBoxCheckState.Checked;
  this.GetHeaderFilterSelectAllCheckBox().SetCheckState(checkState);
 },
 OnHFSelectAllCheckedChanged: function(checkBox) {
  var listBox = this.GetHeaderFilterListBox();
  if(checkBox.GetChecked())
   listBox.SelectAll();
  else
   listBox.UnselectAll();
  this.SetHFOkButtonEnabled(this.IsHFSelectedIndicesChanged());
 },
 IsHFSelectedIndicesChanged: function() {
  var listBox = this.GetHeaderFilterListBox();
  if(!listBox) return;
  var indices = listBox.GetSelectedIndices();
  var savedIndices = listBox.HFSavedSelectedIndices;
  if(indices.length != savedIndices.length)
   return true;
  for(var i = 0; i < indices.length; i++) {
   if(_aspxArrayBinarySearch(savedIndices, indices[i]) < 0)
    return true;
  }
  return false;
 },
 CheckPendingEvents: function() {
  if(this.pendingEvents.length < 1)
   return;
  for(var i = 0; i < this.pendingEvents.length; i++)
   this.ScheduleRaisingEvent(this.pendingEvents[i]);
  this.pendingEvents.length = 0;
 },
 ScheduleRaisingEvent: function(eventName) {
  window.setTimeout(function() { this[eventName](); }.aspxBind(this), 0);
 },
 CreateInternalCheckBoxCollection: function() {
  if(!this.internalCheckBoxCollection)
   this.internalCheckBoxCollection = new ASPxCheckBoxInternalCollection(this.checkBoxImageProperties);
  else
   this.internalCheckBoxCollection.SetImageProperties(this.checkBoxImageProperties);
  this.CompleteInternalCheckBoxCollection();
 },
 CompleteInternalCheckBoxCollection: function() {
  this.internalCheckBoxCollection.Clear();
  for(var i = 0; i < this.pageRowCount; i ++) {
   var index = i + this.visibleStartIndex;
   var icbInputElement = this.GetDataRowSelBtn(index);
   if(icbInputElement) {
    var enabled = !this.IsCheckBoxDisabled(icbInputElement);
    this.AddInternalCheckBoxToCollection(icbInputElement, index, enabled);
   }
  }
 },
 IsCheckBoxDisabled: function(icbInputElement) {
   var icbMainElement = ASPxCheckableElementHelper.Instance.GetICBMainElementByInput(icbInputElement);
   return icbMainElement.className.indexOf("dxgv_cd") != -1;
 },
 AddInternalCheckBoxToCollection: function (icbInputElement, visibleIndex, enabled) {
  var internalCheckBox = this.internalCheckBoxCollection.Add(icbInputElement.id, icbInputElement);
  internalCheckBox.CreateFocusDecoration(this.icbFocusedStyle);
  internalCheckBox.SetEnabled(enabled && this.GetEnabled());
  internalCheckBox.readOnly = this.readOnly;
  var grid = this;
  internalCheckBox.CheckedChanged.AddHandler(
   function(s, e) {
    var rowCheckBox = grid.GetDataRowSelBtn(visibleIndex);
    if(grid.allowSelectSingleRowOnly)
     grid._selectAllSelBtn(false, rowCheckBox.id);
    if(!grid.RaiseInternalCheckBoxClick(visibleIndex)){
     grid.ScheduleCommand(function() { grid.SelectRow(visibleIndex, s.GetChecked()); }, true);
     grid.mainTableClickCore(e, true);
    }
   }
  );
 },
 AdjustControlCore: function() {
  ASPxClientControl.prototype.AdjustControlCore.call(this);
  this.UpdateScrollableControls();
  this.UpdateIndentCellWidths();
  this.ValidateColumnWidths();
  this.ApplyPostBackSyncData();
 },
 GetChildElementById: function(childName){
  if(!this.childrenCache) 
   this.childrenCache = { };
  if(!_aspxIsExistsElement(this.childrenCache[childName])) 
   this.childrenCache[childName] = _aspxGetElementById(this.name + "_" + childName);
  return this.childrenCache[childName];
 }, 
 SerializeCallbackArgs: function(array) {
  if(!_aspxIsExists(array) || array.constructor != Array || array.length == 0)
   return "";
  var sb = [ ];
  for(var i = 0; i < array.length; i++) {
   var item = array[i].toString();
   sb.push(item.length);
   sb.push('|');
   sb.push(item);
  }
  return sb.join("");
 }, 
 gridCallBack: function(args) {
  this.OnBeforeCallbackOrPostBack();
  var serializedArgs = this.SerializeCallbackArgs(args); 
  if(!this.callBack || !this.callBacksEnabled) {
   this.lockFilter = true;
   this.inPostBack = true;
   this.SendPostBack(serializedArgs);
  } else {
   this.OnBeforeCallback();
   var command = this.GetCorrectedCommand(args);
   var preparedArgs = this.prepareCallbackArgs(serializedArgs, this.GetGridTD());
   this.lockFilter = true;
   this.userChangedSelection = false;
   this.CreateCallback(preparedArgs, command);
  }
 },
 GetCorrectedCommand: function(args) {
  if(args.length == 0)
   return "";
  var command = args[0];
  if(args.length > 1 && command == this.CommandId.ColumnMove) {
   if(args[args.length - 1])
    command = this.CommandId.UnGroup;
   if(args[args.length - 2])
    command = this.CommandId.Group;
  }
  return command;
 },
 FuncGetCallBackIndex: function(onCallBack) {
  for(var i = 0; i < this.funcCallbacks.length; i ++) {
   if(this.funcCallbacks[i] == null) {
    this.funcCallbacks[i] = onCallBack;
    return i;
   }
  }
  this.funcCallbacks.push(onCallBack);
  return this.funcCallbacks.length - 1;
 },
 GetFuncCallBack: function(index) {
  if(index < 0 || index >= this.funcCallbacks.length) return null;
  var result = this.funcCallbacks[index];
  this.funcCallbacks[index] = null;
  return result;
 },
 gridFuncCallBack: function(args, onCallBack) {
  var serializedArgs = this.SerializeCallbackArgs(args); 
  var callbackArgs = this.formatCallbackArg("FB", this.FuncGetCallBackIndex(onCallBack).toString()) +
   this.prepareCallbackArgs(serializedArgs, null);
  this.CreateCallback(callbackArgs, "FUNCTION");
 }, 
 prepareCallbackArgs: function(serializedArgs, rootTD) {
  var preparedArgs =
   this.formatCallbackArg("EV", this.GetEditorValues(rootTD)) +
   this.formatCallbackArg("SR", this.GetSelectedState()) +
   this.formatCallbackArg("KV", this.GetKeyValuesInput()) + 
   this.formatCallbackArg("FR", this.GetFocusedRowInput()) +
   this.formatCallbackArg("CR", this.GetColResizedInput()) +
   this.formatCallbackArg("GB", serializedArgs);
  return preparedArgs;
 },
 formatCallbackArg: function(prefix, arg) {
  if(arg == null) return "";
  if(!_aspxIsExists(arg.length) && _aspxIsExists(arg.value)) {
   arg = arg.value;
  }
  if(arg == null || arg == "") return "";
  return prefix + "|" + arg.length + ';' + arg + ';';
 },
 OnCallback: function (result) {
  this.HideFilterControlPopup();
  var isFuncCallback = result.indexOf("FB|") == 0;
  this.afterCallbackRequired = !isFuncCallback; 
  if(isFuncCallback) {
   this.PreventCallbackAnimation();
   var result = this.ParseFuncCallbackResult(result.substr(3));
   if(!result) return;
   if(this.IsHeaderFilterFuncCallback(result.callback))
    this.OnFuncCallback(result);
   else 
    window.setTimeout(function() { this.OnFuncCallback(result); }.aspxBind(this), 0);
  } else {
   var rootTD = this.GetGridTD();
   if(rootTD != null)
    _aspxSetInnerHtml(rootTD, result);
  }
 },
 OnCallbackFinalized: function() {
  if(this.afterCallbackRequired)
   this.OnAfterCallback();
 },
 IsHeaderFilterFuncCallback: function(callback) {
  return callback === this.onFilterPopupCallback;
 },
 ParseFuncCallbackResult: function(result) {
  var pos = result.indexOf("|");
  if(pos < 0) return;
  var index = parseInt(result.substr(0, pos), 10);
  var onCallback = this.GetFuncCallBack(index);
  if(onCallback == null) return;
  result = result.substr(pos + 1);
  return { callback: onCallback, params: result };
 },
 OnFuncCallback: function(result) {
  if(result && result.callback)
   result.callback(eval(result.params));
 },
 OnCallbackError: function(result, data){
  this.showingError = result;
  if(this.GetGridTD())
   this.afterCallbackRequired = true;
 },
 ShowError: function(errorText) {
  var displayIn = this;
  var popupForm = this.GetPopupEditForm();
  if(popupForm) {
   displayIn = popupForm;
   if(!popupForm.IsVisible()) {
    popupForm.Show();  
   }
  }
  var errorRow = this.GetEditingErrorRow(displayIn);
  if(!errorRow) {
   var editRow = this.GetEditingRow(displayIn);
   if(editRow) {
    errorRow = editRow.parentNode.insertRow(editRow.sectionRowIndex + 1);
    errorRow.id = editRow.id.replace("DXEditingRow", "DXEditingErrorRow");
    this.ApplyEditingErrorRowStyle(errorRow);
   }
  }
  if(errorRow) {
   errorRow.cells[errorRow.cells.length - 1].innerHTML = errorText;
  } else {
    alert(errorText);
  }
 },
 ApplyEditingErrorRowStyle: function(errorRow) {
  var row = this.GetStyleTable().rows[1];
  errorRow.className = row.className;
  errorRow.style.cssText = row.style.cssText;
  for(var i = 0; i < row.cells.length; i ++) {
   errorRow.appendChild(row.cells[i].cloneNode(true));
  }
 },
 OnBeforeCallbackOrPostBack: function() {
  this.HidePopupEditForm();
  ASPxClientGridView.SaveActiveElementSettings(this);
  var resizingHelper = this.GetResizingHelper();
  if(resizingHelper)
   resizingHelper.SaveControlDimensions(true);
 },
 OnBeforeCallback: function() {
  this.keyboardLock = true;
  this.ShowLoadingElements();
  this.SaveCallbackSettings();
  this.RemoveSelectStartHandler();
  var popup = this.GetHeaderFilterPopup();
  if(popup)
   popup.RemoveAllPopupElements();
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper && this.isVirtualScrolling)
   scrollHelper.ClearVirtualScrollTimer();
 },
 OnAfterCallback: function() {
  var checkBoxCollectionReinitializeRequired = true; 
  if(this.showingError) {
   checkBoxCollectionReinitializeRequired = false;
   this.ShowError(this.showingError);
      this.showingError = null;
    }
  this.childrenCache = { };
  this.pendingCommands = [ ];
  this.lockFilter = true;
  try {
   this.EnsureRowKeys();
   this.headerMatrix && this.headerMatrix.Invalidate();
   this.SetHeadersClientEvents();
   this.RestoreCallbackSettings();
   this.AddSelectStartHandler();
   this.EnsureRowHotTrackItems();
   if(this.kbdHelper)
    this.kbdHelper.EnsureFocusedRowVisible();
  }
  finally {
   window.setTimeout(function() { this.lockFilter = false; }.aspxBind(this), 0); 
   this.keyboardLock = false;
  }
  if(this.checkBoxImageProperties && checkBoxCollectionReinitializeRequired)
   this.CreateInternalCheckBoxCollection();
  this.CheckPendingEvents();
  this.InitializeHeaderFilterPopup();
 },
 SaveCallbackSettings: function() {
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null) {
   var custWindowElement = custWindow.GetWindowElement(-1);
   if(custWindowElement) {
    this.custwindowLeft = _aspxGetAbsoluteX(custWindowElement);
    this.custwindowTop = _aspxGetAbsoluteY(custWindowElement);
    this.custwindowVisible = custWindow.IsVisible();
   }
  } else {
   this.custwindowVisible = null;
  }
  var helper = this.GetFixedColumnsHelper();
  if(helper != null) helper.SaveCallbackSettings();  
 },
 RestoreCallbackSettings: function() {
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null && this.custwindowVisible != null) {
   if(this.custwindowVisible){
    custWindow.enableAnimation = false;
    custWindow.ShowAtPos(this.custwindowLeft, this.custwindowTop);
   }
  }
  var resizingHelper = this.GetResizingHelper();
  if(resizingHelper)
   resizingHelper.ResetStretchedColumnWidth();
  this.UpdateScrollableControls();
  this.UpdateIndentCellWidths();
  if(resizingHelper)
   resizingHelper.ValidateColumnWidths();
  this.ApplyPostBackSyncData();
  this.sizeCorrectedOnce = false; 
  var helper = this.GetFixedColumnsHelper();
  if(helper != null) helper.RestoreCallbackSettings();
  ASPxClientGridView.RestoreActiveElementSettings(this); 
 },
 HidePopupEditForm: function() {
  var popup = this.GetPopupEditForm();
  if(popup != null) {
   popup.Hide();
  }
 },
 _isRowSelected: function(visibleIndex) {
  if(!this.GetDataRow(visibleIndex)) return false;
  var index = this._getRowIndexOnPage(visibleIndex);
  var selInput = this.GetSelectionInput();
  if(!selInput) return false;
  return this._isTrueInCheckList(selInput.value, index);
 },
 _isTrueInCheckList: function(checkList, index) {
  if(index < 0 ||  index >= checkList.length) return false;
  return checkList.charAt(index) == "T";
 },
 _getSelectedRowCount: function() {
  var res = this.selectedWithoutPageRowCount;
  var selInput = this.GetSelectionInput();
  if(!selInput) return res;
  var checkList = selInput.value;
  var selCount = 0;
  for(var i = 0; i < checkList.length; i++) {
   if(checkList.charAt(i) == "T") selCount ++;
  }
  return res + selCount;
 },
 _selectAllRowsOnPage: function(checked) {
  if(checked && this.allowSelectSingleRowOnly) {
   this.SelectRow(0, true);
   return;
  }
  var selInput = this.GetSelectionInput();
  if(!selInput) return;
  this._selectAllSelBtn(checked);
  var prevSelectedRowCount = 0;
  var isTrueInCheckList = false;
  for(var i = 0; i < this.pageRowCount; i ++) {
   isTrueInCheckList = this._isTrueInCheckList(selInput.value, i);
   if(isTrueInCheckList) prevSelectedRowCount++; 
   if(isTrueInCheckList != checked) {
    this.ChangeRowStyle(i + this.visibleStartIndex, checked ? 0 : 3);
   }
  }
  if (prevSelectedRowCount == 0 && !checked) return;
  var selValue = "";
  if(checked) {
   for(var i = 0; i < this.pageRowCount; i ++)
    selValue += this.IsDataRow(this.visibleStartIndex + i ) ? "T" : "F";
  }
  if(selValue != selInput.value) {
   this.userChangedSelection = true;
   if(selValue == "") selValue = "U";
   selInput.value = selValue;
  }
  this.DoSelectionChanged(-1, checked, true);
 },
 DeleteGridRow: function(visibleIndex) {
  if(this.confirmDelete != "" && !confirm(this.confirmDelete)) return;
  this.DeleteRow(visibleIndex);
 },
 _selectAllSelBtn: function(checked, exceptInternalCheckBoxName) {
  if(this.checkBoxImageProperties) {
   for(var internalCheckBoxName in this.internalCheckBoxCollection.checkBoxes) {
    if(exceptInternalCheckBoxName !== internalCheckBoxName &&  this.internalCheckBoxCollection.checkBoxes[internalCheckBoxName].SetValue) 
     this.internalCheckBoxCollection.checkBoxes[internalCheckBoxName].SetValue(checked ? ASPxClientCheckBoxInputKey.Checked : ASPxClientCheckBoxInputKey.Unchecked);
   }
  }
 },
 doRowMultiSelect: function(row, rowIndex, evt) {
  var ctrlKey = evt.ctrlKey || evt.metaKey,
   shiftKey = evt.shiftKey;
  if((ctrlKey || shiftKey) && (!__aspxIE || __aspxBrowserVersion > 8))
   _aspxClearSelection();
  if(this.allowSelectSingleRowOnly)
   shiftKey = false;
  if(!ctrlKey && !shiftKey) {
   this._selectAllRowsOnPage(false);
   this.SelectRow(rowIndex, true);
   this.lastMultiSelectIndex = rowIndex;
  } else {
   if(ctrlKey) {
    this.SelectRow(rowIndex, !this._isRowSelected(rowIndex));
    this.lastMultiSelectIndex = rowIndex;
   } else {
    var startIndex = rowIndex > this.lastMultiSelectIndex ? this.lastMultiSelectIndex + 1 : rowIndex;
    var endIndex = rowIndex > this.lastMultiSelectIndex ? rowIndex : this.lastMultiSelectIndex - 1;
    for(var i = this.visibleStartIndex; i < this.pageRowCount + this.visibleStartIndex; i ++) {
     if(i == this.lastMultiSelectIndex) 
      continue;
     this.SelectRow(i, i >= startIndex && i <= endIndex);
    }
   }
  }
  this.UpdatePostBackSyncInput();
 },
 AddSelectStartHandler: function() {   
  if(!this.allowSelectByRowClick || !__aspxIE || __aspxBrowserVersion > 8 )
   return;
  _aspxAttachEventToElement(this.GetMainTable(), "selectstart", ASPxClientGridView.SelectStartHandler);
 },
 RemoveSelectStartHandler: function() {
  if(!this.allowSelectByRowClick || !__aspxIE)
   return; 
  _aspxDetachEventFromElement(this.GetMainTable(), "selectstart", ASPxClientGridView.SelectStartHandler);
 },
 SelectRow: function(visibleIndex, checked, fromCheckBox) {
  if(!this.IsDataRow(visibleIndex)) return;
  if(this._isRowSelected(visibleIndex) == checked) return;
  if(_aspxIsExists(fromCheckBox)) fromCheckBox = false;
  var index = this._getRowIndexOnPage(visibleIndex);
  if(index < 0) return;
  if(checked && this.allowSelectSingleRowOnly)
   this._selectAllRowsOnPage(false);
  var selInput = this.GetSelectionInput();
  if(selInput) {
   this.userChangedSelection = true;
   var checkList = selInput.value;
   if(index >= checkList.length) {
    if(!checked) return;
    for(var i = checkList.length; i <= index; i ++)
     checkList += "F";
   }
   checkList = checkList.substr(0, index) + (checked ? "T" : "F") + checkList.substr(index + 1, checkList.length - index - 1);
   if(checkList.indexOf("T") < 0) checkList = "U";
   selInput.value = checkList;
  }
  var checkBox = this.GetDataRowSelBtn(visibleIndex);
  if(checkBox) {
   var internalCheckBox = this.internalCheckBoxCollection.Get(checkBox.id);
   internalCheckBox.SetValue(checked ? ASPxClientCheckBoxInputKey.Checked : ASPxClientCheckBoxInputKey.Unchecked);
  }
  this.ChangeRowStyle(visibleIndex, checked ? 0 : 3);
  this.DoSelectionChanged(visibleIndex, checked, false);
 },
 ScheduleCommand: function(args, postponed) {
  if(postponed)
   this.pendingCommands.push(args);
  else 
   this.PerformScheduledCommand(args);
 },
 PerformScheduledCommand: function(args) {
  if(_aspxIsFunction(args)) {
   args(); 
   return;
  }
  if(args && args.length > 0) {
   var commandName = "UA_" + args[0];
   if(this[commandName])
    this[commandName].apply(this, args.slice(1));
  }
 },
 PerformPendingCommands: function() {
  var commandCount = this.pendingCommands.length;
  for(var i = 0; i < commandCount; i++)
   this.PerformScheduledCommand(this.pendingCommands.pop());
 },
 getRowByHtmlEvent: function(evt) {
  var row = this.getRowByHtmlEventCore(evt, this.DataRowID);
  if(!row)
   row = this.getRowByHtmlEventCore(evt, this.GroupRowID);
  return row;
 },
 getRowByHtmlEventCore: function(evt, partialID) {
  var row = _aspxGetParentByPartialId(_aspxGetEventSource(evt), partialID);
  if(row && row.id.indexOf(this.name) > -1)
   return row;
  return null;
 },
 NeedProcessTableClick: function(evt) {
  var headerTable = _aspxGetParentByPartialId(_aspxGetEventSource(evt), this.HeaderTableID);
  if(headerTable) {
   var headerTableID = headerTable.id;
   var gridID = headerTableID.substr(0, headerTableID.length - this.HeaderTableID.length - 1);
   return this.name == gridID;
  }
  var mainTable = _aspxGetParentByPartialId(_aspxGetEventSource(evt), this.MainTableID);
  if(mainTable) {
   var mainTableID = mainTable.id;
   var gridID = mainTableID.substr(0, mainTableID.length - this.MainTableID.length - 1);
   return this.name == gridID;
  }
  return false;
 },
 mainTableClick: function(evt) { this.mainTableClickCore(evt); },
 mainTableDblClick: function(evt) { 
  var row = this.getRowByHtmlEvent(evt);
  if(row)
   this.RaiseRowDblClick(this.getRowIndex(row.id), evt); 
 },
 mainTableClickCore: function(evt, fromCheckBox) {
  if(this.kbdHelper)
   this.kbdHelper.HandleClick(evt);
  var sendNotificationCallack = true;
  this.mainTableClickData.processing = true;
  try {
   this.ProcessTableClick(evt, fromCheckBox);
   var savedCallbackCount = this.requestCount;
   this.PerformPendingCommands();
   sendNotificationCallack = this.requestCount == savedCallbackCount && !this.inPostBack;
  } finally {
   if(sendNotificationCallack)
    if(this.mainTableClickData.focusChanged && !this.mainTableClickData.selectionChanged) {
     this.gridCallBack(["FOCUSEDROW"]);
    } else if(this.mainTableClickData.selectionChanged) {
     this.gridCallBack(["SELECTION"]);
    }
   this.mainTableClickData.processing = false;
   this.mainTableClickData.focusChanged = false;
   this.mainTableClickData.selectionChanged = false;
  }
 },
 ProcessTableClick: function(evt, fromCheckBox) {
  var source = _aspxGetEventSource(evt);
  var row = this.getRowByHtmlEvent(evt);
  if(row) {
   var rowIndex = this.getRowIndex(row.id);
   var isCommandColumnItem = source && source.className && source.className.indexOf("dxgv__cci") > - 1;
   if(!isCommandColumnItem && !fromCheckBox)
    if(this.RaiseRowClick(rowIndex, evt)) return; 
   if(this.allowFocusedRow) {
    this.focusRow(row);
   }
   if(this.allowSelectByRowClick) {
    var isActionElement = source && source.tagName.match(/input|select|textarea|^a$/i);
    if(!isActionElement && !isCommandColumnItem && !fromCheckBox) {
     if(this.lookupBehavior){
      var checked = this.allowSelectSingleRowOnly || !this._isRowSelected(rowIndex);
      this.SelectRow(rowIndex, checked);
     } else
      this.doRowMultiSelect(row, rowIndex, evt);
    }
   } else {
    this.lastMultiSelectIndex = rowIndex;
   }
  }
 },
 focusRow: function(row) {
  if(!row) return;
  var index = this.getRowIndex(row.id);
  this._setFocusedRowIndex(index);
 },
 _setFocusedRowIndex: function(visibleIndex) {
  if(visibleIndex < 0) visibleIndex = -1;
  if(!this.allowFocusedRow) return;
  var row = this.GetRow(visibleIndex);
  if(visibleIndex == this.focusedRowIndex) return;
  var oldFocusedRow = this.focusedRowIndex;
  this.focusedRowIndex = visibleIndex;
  this.ChangeRowStyle(oldFocusedRow, this._isRowSelected(oldFocusedRow) ? 0 : 3);
  if(this.focusedRowIndex > -1)
  if(row)
   this.ChangeRowStyle(this.focusedRowIndex, this._isGroupRow(row) ? 2 : 1);
  this._setFocusedRowInputValue();
  if(this.callbackOnFocusedRowChanged) {
   this.UpdatePostBackSyncInput(true);
   if(!this.mainTableClickData.processing) {
    this.gridCallBack(["FOCUSEDROW"]);
   } else {
    this.mainTableClickData.focusChanged = true;
   }
   return;
  }
  this.RaiseFocusedRowChanged();
 },
 _setFocusedRowInputValue: function() {
  if(this.GetFocusedRowInput() != null) {
   this.GetFocusedRowInput().value = this.focusedRowIndex;
  }
 },
 _getFocusedRowIndex: function() {
  if(!this.allowFocusedRow) return -1;
  return this.focusedRowIndex;
 },
 getRowIndex: function(rowId) {   
  if(this.IsHeaderRowID(rowId))
   return -1;
  return this._getNumberFromEndOfString(rowId); 
 },
 _getNumberFromEndOfString: function(st) {
  var value = -1;
  var n = st.length - 1;
  while(parseInt(st.substr(n), 10) >= 0) {
   value = parseInt(st.substr(n), 10);
   n --;
  }
  return value;
 },
 GetSelectedState: function() {
  if(!this.userChangedSelection) return null;
  var input = this.GetSelectionInput();
  if(!input) return null;
  return input.value;
 },
 ChangeRowStyle: function(visibleIndex, rowStyle) {
  if(this._getFocusedRowIndex() == visibleIndex && rowStyle != 1 && rowStyle != 2) return;
  var row = this.GetRow(visibleIndex);
  if(!row) return;
  if(rowStyle == 0 && this._isGroupRow(row)) return; 
  var index = this._getRowIndexOnPage(visibleIndex);
  var styleRow = this._getStyleRow(index, rowStyle);
  if(!styleRow) return;
  row.className = styleRow.className;
  row.style.cssText = styleRow.style.cssText;
 },
 _getRowIndexOnPage: function(visibleIndex) { 
  return visibleIndex - this.visibleStartIndex; 
 },
 getColumnIndex: function(colId) {
  if(this.IsEmptyHeaderID(colId))
   return -1;
  var index = this._getNumberFromEndOfString(colId); 
  var postfix = "col" + index;
  if(colId.indexOf(postfix) == colId.length - postfix.length)
   return index;
  return -1;
 },
 getColumnObject: function(colId) {
  var index = this.getColumnIndex(colId);
  return index > -1 ? this._getColumn(index) : null;
 },
 _getColumnIndexByColumnArgs: function(column) {
  column = this._getColumnObjectByArg(column);
  if(!column) return null;
  return column.index;
 },
 _getColumnObjectByArg: function(arg) {
  if(!_aspxIsExists(arg)) return null;
  if(typeof(arg) == "number") return this._getColumn(arg);
  if(_aspxIsExists(arg.index)) return arg;
  var column = this._getColumnById(arg);
  if(column) return column;
  return this._getColumnByField(arg);  
 },
 _getColumnsCount: function() { return this.columns.length; },
 _getColumn: function(index) { 
  if(index < 0 || index >= this.columns.length) return null;
  return this.columns[index];
 },
 _getColumnById: function(id) {
  if(!_aspxIsExists(id)) return null;
  for(var i = 0; i < this.columns.length; i++) {
   if(this.columns[i].id == id) return this.columns[i];
  }
  return null;
 },
 _getColumnByField: function(fieldName) {
  if(!_aspxIsExists(fieldName)) return null;
  for(var i = 0; i < this.columns.length; i++) {
   if(this.columns[i].fieldName == fieldName) return this.columns[i];
  }
  return null;
 },
 _getStyleRow: function(index, rowStyle) {
  var styleTable = this.GetStyleTable();
  if(!styleTable) return null;
  if(rowStyle < 3) return styleTable.rows[rowStyle + 2];
  return styleTable.rows[5 + index];
 },
 DoSelectionChanged: function(index, isSelected, isSelectAllOnPage){
  if(this.callbackOnSelectionChanged) {
   this.UpdatePostBackSyncInput(true);
   if(!this.mainTableClickData.processing) {
    this.gridCallBack(["SELECTION"]);
   } else {
    this.mainTableClickData.selectionChanged = true;
   }
   return;
  }
  this.RaiseSelectionChanged(index, isSelected, isSelectAllOnPage, false);
 },
 CommandCustomButton:function(id, index) {
  var processOnServer = true;
  if(!this.CustomButtonClick.IsEmpty()) {
   var e = new ASPxClientGridViewCustomButtonEventArgs(index, id);
   this.CustomButtonClick.FireEvent(this, e);
   processOnServer = e.processOnServer;
  }
  if(processOnServer)
   this.gridCallBack(["CUSTOMBUTTON", id, index]);
 },
 HeaderMouseDown: function(element, e){
  if(!_aspxGetIsLeftButtonPressed(e)) 
   return;
  var source = _aspxGetEventSource(e);
  if(_aspxElementCssClassContains(source, this.HeaderFilterButtonClassName))
   return;
  if(this.TryStartColumnResizing(e, element))
   return;
  var column = this._getColumnObjectByArg(this.getColumnIndex(element.id));
  var dragCanceled = this.RaiseColumnStartDragging(column);
  var canDrag = !dragCanceled && this.canDragColumn(element) && source.tagName != "IMG";
  if(!this.dragHelper)
   this.dragHelper = new ASPxClientGridViewDragHelper(this);
  var drag = this.dragHelper.CreateDrag(e, element, canDrag);
  if(!canDrag && (e.shiftKey || e.ctrlKey))
   drag.clearSelectionOnce = true;
  this.dragHelper.CreateTargets(drag, e);
 },
 TryStartColumnResizing: function(e, headerCell) {
  var helper = this.GetResizingHelper();
  if(!helper || !helper.CanStartResizing(e, headerCell))
   return false;
  var column = this.columns[helper.GetResizingColumnIndex(e, headerCell)];
  if(this.RaiseColumnResizing(column))
   return false;
  helper.StartResizing(column.index);
  return true;
 }, 
 OnParentRowMouseEnter: function(element) {
  if(this.GetParentRowsWindow() == null) return;
  if(this.GetParentRowsWindow().IsWindowVisible()) return;
  this.ParentRowsTimerId = _aspxSetTimeout("aspxGVParentRowsTimer(\""+this.name+"\", \"" + element.id + "\");", 500);
 },
 OnParentRowMouseLeave: function(evt) {
  _aspxClearTimer(this.ParentRowsTimerId);
  if(this.GetParentRowsWindow() == null) return;
  if(evt && evt.toElement) {
   if(_aspxGetParentByPartialId(evt.toElement, this.GetParentRowsWindow().name) != null)
     return;
  }
  this.HideParentRows();
 },
 ShowParentRows: function(element) {
  this.ParentRowsTimerId = null;
  if(this.GetParentRowsWindow() != null) {
   this.GetParentRowsWindow().ShowAtElement(element);
  }
 },
 onFilterPopupCallback: function(values) {
  var grid = aspxGetControlCollection().Get(values[0]);
  if(grid != null)
   grid.GetHeaderFilterPopup().SetContentHtml(values[1], grid.enableCallbackAnimation);
 },
 HideParentRows: function() {
  this.ParentRowsTimerId = null;
  if(this.GetParentRowsWindow() != null) {
   this.GetParentRowsWindow().Hide();
  }
 }, 
 canSortByColumn: function(headerElement) {
  return this.getColumnObject(headerElement.id).allowSort;
 },
 canGroupByColumn: function(headerElement) {
  return this.getColumnObject(headerElement.id).allowGroup;
 },
 canDragColumn: function(headerElement) {
  return this.getColumnObject(headerElement.id).allowDrag;  
 },
 doPagerOnClick: function(id) {
  if(!_aspxIsExists(id)) return;
  this.AssignSlideAnimationDirectionByPagerArgument(id, this.pageIndex);
  if(__aspxIE && this.kbdHelper)
   this.kbdHelper.Focus();
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.ResetScrollTop();
  this.gridCallBack([this.CommandId.PagerOnClick, id]);
 },
 CanHandleGesture: function(evt) {
  var source = _aspxGetEventSource(evt);
  var table = this.GetMainTable();
  if(_aspxGetIsParent(table, source)) {
   var headerRowCount = this.GetHeaderMatrix().GetRowCount();
   for(var i = 0; i < headerRowCount; i++) {
    if(_aspxGetIsParent(this.GetHeaderRow(i), source))
     return false;
   }
   return true;
  }
  if(table.parentNode.tagName == "DIV" && _aspxGetIsParent(table.parentNode, source))
   return __aspxTouchUI || evt.offsetX < table.parentNode.clientWidth;
  return false;
 },
 AllowStartGesture: function() {
  return ASPxClientControl.prototype.AllowStartGesture.call(this) && 
   (this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, 1) || this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, -1));
 },
 AllowExecuteGesture: function(value) {
  return this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, value);
 },
 ExecuteGesture: function(value, count) {
  this.ExecutePagerGesture(this.pageIndex, this.pageCount, value, count, function(arg) { this.doPagerOnClick(arg); }.aspxBind(this));
 },
 OnColumnFilterInputChanged: function(editor) {
  this.ApplyColumnAutoFilterCore(editor);
 },
 OnColumnFilterInputSpecKeyPress: function(editor, e) {
  if(e.htmlEvent) e = e.htmlEvent;
  if(e.keyCode == ASPxKey.Enter) {
   _aspxPreventEventAndBubble(e);
   editor.Validate();
   this.ApplyColumnAutoFilterCore(editor);
   return;
  }
  if(e.keyCode == ASPxKey.Delete && e.ctrlKey) {
   _aspxPreventEventAndBubble(e);
   editor.SetValue(null);
   this.ApplyColumnAutoFilterCore(editor);
   return;
  }
 },
 OnColumnFilterInputKeyPress: function(editor, e) {
  this.OnColumnFilterInputSpecKeyPress(editor, e);
  if(e.htmlEvent) e = e.htmlEvent;
  if(e.keyCode == ASPxKey.Tab || e.keyCode == ASPxKey.Enter) return;
  if(e.keyCode == ASPxKey.Delete && e.ctrlKey) return;
  this.ClearAutoFilterInputTimer();
  if(editor != this.FilterKeyPressEditor) {
   this.filterKeyPressInputValue = editor.GetValueString();
  }
  this.FilterKeyPressEditor = editor;
  this.filterKeyPressTimerId = _aspxSetTimeout("aspxGVTimer(\""+this.name+"\");", this.autoFilterDelay);
 },
 ClearAutoFilterInputTimer: function() {
  this.filterKeyPressTimerId = _aspxClearTimer(this.filterKeyPressTimerId);
 },
 GetAutoFilterEditorInputElement: function(editor) {
  if(document.activeElement) return document.activeElement;
  if(editor.GetInputElement) return editor.GetInputElement();
  return null;
 },
 OnFilterKeyPressTick: function() {
  if(this.FilterKeyPressEditor) {
   this.ApplyColumnAutoFilterCore(this.FilterKeyPressEditor);
  }
 },
 ApplyColumnAutoFilterCore: function(editor) {
  if(this.lockFilter) return;
  this.ClearAutoFilterInputTimer();
  if(this.FilterKeyPressEditor && editor == this.FilterKeyPressEditor) {
   if(this.FilterKeyPressEditor.GetValueString() == this.filterKeyPressInputValue) return;
  }
  var column = this.getColumnIndex(editor.name);
  if(column < 0) return;
  this.activeElement = this.GetAutoFilterEditorInputElement(editor);
  this.AutoFilterByColumn(column, editor.GetValueString());
 },
 FilterRowMenuButtonClick: function(columnIndex, element) {
  var menu = this.GetFilterRowMenu();
  if(!menu) return;
  var column = this._getColumn(columnIndex);
  if(!column) return;
  for(var i = menu.GetItemCount() - 1; i >= 0; i--) {
   var item = menu.GetItem(i);
   item.SetChecked(item.name.substr(0, item.name.indexOf("|")) == this.filterRowConditions[columnIndex]);
   item.SetVisible(this.GetFilterRowMenuItemVisible(item, column));
  }
  menu.ShowAtElement(element);
  this.filterRowMenuColumnIndex = columnIndex;
 },
 GetFilterRowMenuItemVisible: function(item, column) {
  if(column.filterRowTypeKind) {
   var visible = item.name.indexOf(column.filterRowTypeKind) > -1;
   if(!visible && column.showFilterMenuLikeItem)
    return item.name.indexOf("L") > -1;
   return visible;
  }
  return false;
 },
 FilterRowMenuItemClick: function(item) {
  var itemName = item.name.substr(0, item.name.indexOf("|"));
  this.gridCallBack(["FILTERROWMENU", this.filterRowMenuColumnIndex, itemName]);
 },
 ShowLoadingPanel: function() {
  var gridMainCell = this.GetGridTD();
  if(!gridMainCell) return;
  var lpContainer = this.GetLoadingPanelContainer();
  if(lpContainer)
   this.CreateLoadingPanelInline(lpContainer);
  else
   this.CreateLoadingPanelWithAbsolutePosition(gridMainCell, this.GetLoadingPanelOffsetElement(gridMainCell));
 },
 ShowLoadingDiv: function () {
  this.CreateLoadingDiv(this.GetGridTD());
 },
 GetCallbackAnimationElement: function() {
  var table = this.GetMainTable();
  if(table && table.parentNode && table.parentNode.tagName == "DIV")
   return table.parentNode;
  return table;
 },
 _updateEdit: function() {
  var editors = this._getEditors();
  var isValid = true;
  if(editors.length > 0)
   isValid &= this._validate(editors);
  if(window.ASPxClientEdit)
   isValid &= ASPxClientEdit.ValidateEditorsInContainer(this.GetEditFormTable(), this.name);
  if(!isValid)
   return;
  this.gridCallBack(["UPDATEEDIT"]);
 },
 _validate: function(list) {
  var isValid = true;
  var firstInvalid = null;
  var edit;
  for(var i = 0; i < list.length; i ++) {
   edit = list[i];
   edit.Validate();
   isValid = edit.GetIsValid() && isValid;
   if(firstInvalid == null && edit.setFocusOnError && !edit.GetIsValid())
    firstInvalid = edit;
  }
  if (firstInvalid != null)
   firstInvalid.Focus();
  return isValid;
 },
 _getEditors: function() {
  var list = [ ];
  for(var i = 0; i < this.editorIDList.length; i++) {
   var editor = aspxGetControlCollection().Get(this.editorIDList[i]);
   if(editor && editor.enabled && editor.GetMainElement && _aspxIsExistsElement(editor.GetMainElement())) {
    if(!editor.Validate) continue; 
    list.push(editor);
   }
  }
  return list;
 },
 GetEditorValues: function() {
  var list = this._getEditors();
  if(list.length == 0) return null;
  var res = list.length + ";";
  for(var i = 0; i < list.length; i ++) {
   res += this.GetEditorValue(list[i]);
  }
  return res;
 },
 GetEditorValue: function(editor) {
  var value = editor.GetValueString();
  var valueLength = -1;
  if(!_aspxIsExists(value)) {
   value = "";
  } else {
   value = value.toString();
   valueLength = value.length;
  }
  return this.GetEditorIndex(editor.name) + "," + valueLength + "," + value + ";";
 },
 GetEditorIndex: function(editorId) {
  var i = editorId.lastIndexOf(this.GetEditorPrefix());
  if(i < 0) return -1;
  var result = editorId.substr(i + this.GetEditorPrefix().length);
  i = result.indexOf('_'); 
  return i > 0
   ? result.substr(0, i)
   : result;
 },
 GetTableHelper: function() {
  if(!this.tableHelper && typeof(ASPxClientGridViewTableHelper) != "undefined")
   this.tableHelper = new ASPxClientGridViewTableHelper(this, this.MainTableID, this.HeaderTableID, this.FooterTableID, this.horzScroll, this.vertScroll);
  return this.tableHelper;
 },
 GetScrollHelper: function() {
  if(!this.HasScrolling()) return null;
  if(!this.scrollableHelper)
   this.scrollableHelper = new ASPxClientGridViewTableScrollHelper(this.GetTableHelper());
  return this.scrollableHelper;
 },
 GetFixedColumnsHelper: function() {
  if(!this.GetFixedColumnsDiv()) return null;
  if(!this.fixedColumnsHelper)
   this.fixedColumnsHelper = new ASPxClientTableFixedColumnsHelper(this.GetTableHelper(), this.FixedColumnsDivID, this.FixedColumnsContentDivID, this.fixedColumnCount);
  return this.fixedColumnsHelper;
 },
 GetResizingHelper: function() {
  if(!this.AllowResizing()) return null;
  if(!this.resizingHelper)
   this.resizingHelper = new ASPxClientGridViewTableResizingHelper(this.GetTableHelper());
  return this.resizingHelper;
 },
 GetHeaderMatrix: function() {
  if(!this.headerMatrix)
   this.headerMatrix = new ASPxClientGridViewHeaderMatrix(this);
  return this.headerMatrix;
 },
 UpdateScrollableControls: function() {
  var helper = this.GetScrollHelper();
  if(helper)
   helper.Update();
 },
 ValidateColumnWidths: function() {
  var helper = this.GetResizingHelper();
  if(helper)
   helper.ValidateColumnWidths();
 },
 SetHeadersClientEvents: function() {
  if(!this.AllowResizing())
   return;
  var helper = this.GetResizingHelper();
  var attachMouseMove = function(headerCell) { 
   _aspxAttachEventToElement(headerCell, "mousemove", function(e) { helper.UpdateCursor(e, headerCell); });
  };
  for(var i = 0; i < this.columns.length; i++) {
   var header = this.GetHeader(this.columns[i].index);
   if(header) 
    attachMouseMove(header);
  }
 },
 OnBrowserWindowResize: function(e) {
  if(this.AllowResizing() && !this.HasScrolling())
   this.GetResizingHelper().ValidateColumnWidths();
 },
 UpdatePostBackSyncInput: function(isChangedNotification) {
  var input = this.GetPostBackSyncInput();
  if(!input) return;
  var selectedIndex = isChangedNotification ? -1 : this.lastMultiSelectIndex; 
  ASPxSimpleHiddenField.Set("SI", selectedIndex, input);
 },
 ApplyPostBackSyncData: function() {
  var savedState = ASPxSimpleHiddenField.Get("SI", this.GetPostBackSyncInput());
  if(savedState && savedState.length > 0)
   this.lastMultiSelectIndex = Number(savedState);
 },
 doScrollToRowIndex: function() {
  if(this.scrollToRowIndex < 0) return false;
  this.MakeRowVisible(this.scrollToRowIndex);
  this.scrollToRowIndex = -1;
  return true;
 },
 EnsureRowHotTrackItems: function() {
  if(this.rowHotTrackStyle == null) return;
  var list = [ ];
  for(var i = 0; i < this.pageRowCount; i++) {
   var index = i + this.visibleStartIndex;
   if(this.rowHotTrackItemsBag[index]) continue;
   list.push(this.DataRowID + index);
   this.rowHotTrackItemsBag[index] = true;
  }
  if(list.length > 0) {
   aspxAddHoverItems(this.name, [
    [ 
     [this.rowHotTrackStyle[0]], 
     [this.rowHotTrackStyle[1]], 
     list
    ]
   ]);
  }
 },
 UpdateIndentCellWidths: function() {
  if(this.indentColumnCount <= 0) 
   return;
  if(this.HasScrolling() || this.AllowResizing()) 
   this.GetTableHelper().UpdateIndentCellWidths();
 },
 OnContextMenuClick: function(e) {
  var args = this.GetContextMenuArgs(e);
  if(args)
   this.RaiseContextMenu(args.objectType, args.index, e);
 },
 GetContextMenuArgs: function(e) {
  var objectTypes = { };
  objectTypes[this.name + "_" + this.DataRowID]     = "row";
  objectTypes[this.name + "_" + "col"]     = "header";
  objectTypes[this.name + "_" + this.GroupRowID]    = "grouprow";
  objectTypes[this.name + "_" + this.GroupRowID + "Exp"]  = "grouprow";
  var src = _aspxGetEventSource(e);
  var element = src;
  while(element) {
   if(element.tagName == "BODY")
    return;
   var id = element.id;
   element = element.parentNode;
   if(!id) continue;
   var index = this._getNumberFromEndOfString(id);
   if(index == -1) continue;
   for(var partialID in objectTypes)
    if(id == partialID + index)
     return { objectType: objectTypes[partialID], index: index };
  }
 },
 Focus: function() {
  if(this.kbdHelper)
   this.kbdHelper.Focus();
 },
 PerformCallback: function(args){
  if(!_aspxIsExists(args)) args = "";
  this.gridCallBack([this.CommandId.CustomCallback, args]);
 },
 GetValuesOnCustomCallback: function(args, onCallBack) {
  this.gridFuncCallBack([this.CommandId.CustomValues, args], onCallBack);
 },
 GotoPage: function(pageIndex){
  this.gridCallBack([this.CommandId.GotoPage, pageIndex]);
 },
 GetPageIndex: function(){
  return this.pageIndex;
 },
 GetPageCount: function(){
  return this.pageCount;
 },
 NextPage: function(){
  this.gridCallBack([this.CommandId.NextPage]);
 },
 PrevPage: function(focusBottomRow){
  this.gridCallBack([this.CommandId.PreviousPage, focusBottomRow ? "T" : "F"]);
 },
 UnGroup: function(column){
  column = this._getColumnIndexByColumnArgs(column);
  this.GroupBy(column, -1);
 },
 ExpandAll: function(){
  this.gridCallBack([this.CommandId.ExpandAll]);
 },
 CollapseAll: function(){
  this.gridCallBack([this.CommandId.CollapseAll]);
 },
 ExpandAllDetailRows: function(){
  this.gridCallBack([this.CommandId.ShowAllDetail]);
 },
 CollapseAllDetailRows: function(){
  this.gridCallBack([this.CommandId.HideAllDetail]);
 },
 ExpandRow: function(visibleIndex, recursive){
  if(this.RaiseRowExpanding(visibleIndex)) return;
  recursive = !!recursive;
  this.gridCallBack([this.CommandId.ExpandRow, visibleIndex, recursive]);
 },
 CollapseRow: function(visibleIndex, recursive){
  if(this.RaiseRowCollapsing(visibleIndex)) return;
  recursive = !!recursive;
  this.gridCallBack([this.CommandId.CollapseRow, visibleIndex, recursive]);
 },
 MakeRowVisible: function(visibleIndex) {
  if(!this.HasVertScroll()) return;
  var row = this.GetRow(visibleIndex);
  if(row == null && visibleIndex >= this.visibleStartIndex 
   && visibleIndex < this.visibleStartIndex + this.pageRowCount) {
   row = this.GetEditingRow(this);
  }
  if(row == null) return;
  this.GetScrollHelper().MakeRowVisible(row);
 },
 ExpandDetailRow: function(visibleIndex){
  if(this.RaiseDetailRowExpanding(visibleIndex)) return;
  this.gridCallBack([this.CommandId.ShowDetailRow, visibleIndex]);
 },
 CollapseDetailRow: function(visibleIndex){
  if(this.RaiseDetailRowCollapsing(visibleIndex)) return;
  this.gridCallBack([this.CommandId.HideDetailRow, visibleIndex]);
 },
 GetRowKey: function(visibleIndex) {
  var arrayIndex = visibleIndex - this.visibleStartIndex;
  if (arrayIndex < 0 || arrayIndex > this.keys.length - 1) return null;
  return this.keys[arrayIndex];
 },   
 StartEditRow: function(visibleIndex) {
  var key = this.GetRowKey(visibleIndex);
  if(key != null)
   this.StartEditRowByKey(key);
 },
 StartEditRowByKey: function(key) {
  this.gridCallBack([this.CommandId.StartEdit, key]);
 },
 IsEditing: function() {
  return this.editState > 0;
 },
 IsNewRowEditing: function() {
  return this.editState > 1;
 },
 IsNewRowAtBottom: function() {
  return this.editState == 3;
 },
 UpdateEdit: function(){
  this._updateEdit();
 },
 CancelEdit: function(){
  this.gridCallBack([this.CommandId.CancelEdit]);
 },
 AddNewRow: function(){
  this.gridCallBack([this.CommandId.AddNewRow]);
 },
 DeleteRow: function(visibleIndex){
  var key = this.GetRowKey(visibleIndex);
  if(key != null)
   this.DeleteRowByKey(key);
 },
 DeleteRowByKey: function(key) {
  this.gridCallBack([this.CommandId.DeleteRow, key]);
 },
 Refresh: function(){
  this.gridCallBack([this.CommandId.Refresh]);
 },
 ApplyFilter: function(expression){
  expression = expression || "";
  this.gridCallBack([this.CommandId.ApplyFilter, expression]);
 },
 ClearFilter: function(){
  this.ApplyFilter();
 },
 GetAutoFilterEditor: function(column) { 
  var index = this._getColumnIndexByColumnArgs(column);
  if(!_aspxIsExists(index)) return null;
  return aspxGetControlCollection().Get(this.name + "_DXFREditorcol" + index);
 },
 AutoFilterByColumn: function(column, val){
  var index = this._getColumnIndexByColumnArgs(column);
  if(!_aspxIsExists(index)) return;
  if(!_aspxIsExists(val)) val = "";  
  this.gridCallBack([this.CommandId.ApplyColumnFilter, index, val]);
 },
 ApplyHeaderFilterByColumn: function(){
  this.GetHeaderFilterPopup().Hide();
  var listBox = this.GetHeaderFilterListBox();
  var column = this.GetColumn(listBox.cpGVColumnIndex);
  if(!column) return;
  var values = listBox.GetSelectedValues();
  this.gridCallBack([this.CommandId.ApplyHeaderColumnFilter, column.index, _aspxToJson(values)]);
 },
 GroupBy: function(column, groupIndex, sortOrder){
  if(this.RaiseColumnGrouping(this._getColumnObjectByArg(column))) return;
  column = this._getColumnIndexByColumnArgs(column);
  if(!_aspxIsExists(groupIndex)) groupIndex = "";
  if(!_aspxIsExists(sortOrder)) sortOrder = "ASC";
  this.gridCallBack([this.CommandId.Group, column, groupIndex, sortOrder]);
 },
 SortBy: function(column, sortOrder, reset, sortIndex){
  if(this.RaiseColumnSorting(this._getColumnObjectByArg(column))) return;
  column = this._getColumnIndexByColumnArgs(column);
  if(!_aspxIsExists(sortIndex)) sortIndex = "";
  if(!_aspxIsExists(sortOrder)) sortOrder = "";
  if(!_aspxIsExists(reset)) reset = true;
  this.gridCallBack([this.CommandId.Sort, column, sortIndex, sortOrder, reset]);
 },
 MoveColumn: function(column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup){
  if(!_aspxIsExists(column)) return;
  if(!_aspxIsExists(columnMoveTo)) columnMoveTo = -1;
  if(!_aspxIsExists(moveBefore)) moveBefore = true;
  if(!_aspxIsExists(moveToGroup)) moveToGroup = false;
  if(!_aspxIsExists(moveFromGroup)) moveFromGroup = false;
  if(moveToGroup) {
   if(this.RaiseColumnGrouping(this._getColumnObjectByArg(column))) return;
  }
  column = this._getColumnIndexByColumnArgs(column);
  this.gridCallBack([this.CommandId.ColumnMove, column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup]);
 },
 GetFocusedRowIndex: function() {
  return this._getFocusedRowIndex();
 },
 SetFocusedRowIndex: function(visibleIndex) {
  return this._setFocusedRowIndex(visibleIndex);
 },
 IsCustomizationWindowVisible: function(){
  var custWindow = this.GetCustomizationWindow();
  return custWindow != null && custWindow.IsVisible();
 },
 ShowCustomizationWindow: function(showAtElement){
  var custWindow = this.GetCustomizationWindow();
  if(!showAtElement) showAtElement = this.GetMainElement();
  custWindow.ShowAtElement(showAtElement);
 },
 HideCustomizationWindow: function(){
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null) custWindow.Hide();
 },
 SelectRows: function(visibleIndices, selected){
  if(!_aspxIsExists(selected)) selected = true;
  if(!_aspxIsExists(visibleIndices)) {
   selected = selected ? "all" : "unall";
   visibleIndices = [ ];
  } else {
   if(visibleIndices.constructor != Array)
    visibleIndices = [visibleIndices];
  }
  this.gridCallBack([this.CommandId.SelectRows, selected].concat(visibleIndices));
 },
 SelectRowsByKey: function(keys, selected){
  if(!_aspxIsExists(selected)) selected = true;
  if(!_aspxIsExists(keys)) return;
  if(keys.constructor != Array)
   keys = [keys];
  this.gridCallBack([this.CommandId.SelectRowsKey, selected].concat(keys));
 },
 UnselectRowsByKey: function(keys){
  this.SelectRowsByKey(keys, false);
 },
 UnselectRows: function(visibleIndices){
  this.SelectRows(visibleIndices, false);
 },
 UnselectFilteredRows: function() {
  this.gridCallBack([this.CommandId.SelectRows, "unallf"]);
 },
 SelectRowOnPage: function(visibleIndex, selected){
  if(!_aspxIsExists(selected)) selected = true;
  this.SelectRow(visibleIndex, selected);
 },
 UnselectRowOnPage: function(visibleIndex){
  this.SelectRowOnPage(visibleIndex, false);
 },
 SelectAllRowsOnPage: function(selected){
  if(!_aspxIsExists(selected)) selected = true;
  this._selectAllRowsOnPage(selected);
 },
 UnselectAllRowsOnPage: function(){
  this._selectAllRowsOnPage(false);
 },
 GetSelectedRowCount: function() {
  return this._getSelectedRowCount();
 },
 GetSelectedFieldValues: function(fieldNames, onCallBack) {
  this.gridFuncCallBack([this.CommandId.SelFieldValues, fieldNames], onCallBack);
 },
 GetSelectedKeysOnPage: function() {
  var keys = [];
  for(var i = 0; i < this.pageRowCount; i++) {
   if(this._isRowSelected(this.visibleStartIndex + i))
    keys.push(this.keys[i]);
  }
  return keys; 
 },
 IsRowSelectedOnPage: function(visibleIndex) {
  return this._isRowSelected(visibleIndex);
 },
 GetRowValues: function(visibleIndex, fieldNames, onCallBack) {
  this.gridFuncCallBack([this.CommandId.RowValues, visibleIndex, fieldNames], onCallBack);
 },
 GetPageRowValues: function(fieldNames, onCallBack) {
  this.gridFuncCallBack([this.CommandId.PageRowValues, fieldNames], onCallBack);
 },
 GetVisibleRowsOnPage: function() {
  return this.pageRowCount;
 },
 GetTopVisibleIndex: function() {
  return this.visibleStartIndex;
 },
 IsGroupRow: function(visibleIndex) {
  return this.GetGroupRow(visibleIndex) != null;
 },
 IsDataRow: function(visibleIndex) {
  return this.GetDataRow(visibleIndex) != null;
 },
 IsGroupRowExpanded: function(visibleIndex) { 
  return this.GetExpandedGroupRow(visibleIndex) != null;
 },
 GetColumnsCount: function() {
  return this._getColumnsCount();
 },
 GetColumn: function(index) {
  return this._getColumn(index);
 },
 GetColumnById: function(id) {
  return this._getColumnById(id);
 },
 GetColumnByField: function(fieldName) {
  return this._getColumnByField(fieldName);
 },
 GetEditor: function(column) {
  var columnObject = this._getColumnObjectByArg(column);
  return columnObject != null ? this.GetEditorByColumnIndex(columnObject.index) : null;
 },
 FocusEditor: function(column) {
  var editor = this.GetEditor(column);
  if(editor && editor.SetFocus) {
   editor.SetFocus();  
  }
 },
 GetEditValue: function(column) {
  var editor = this.GetEditor(column);
  return editor != null && editor.enabled ? editor.GetValue() : null;
 },
 SetEditValue: function(column, value) {
  var editor = this.GetEditor(column);
  if(editor != null && editor.enabled) {
   editor.SetValue(value);
  }
 },
 ShowFilterControl: function() {
  this.PreventCallbackAnimation();
  this.gridCallBack([this.CommandId.ShowFilterControl]);
 },
 CloseFilterControl: function() {
  this.PreventCallbackAnimation();
  this.HideFilterControlPopup();
  this.gridCallBack([this.CommandId.CloseFilterControl]);
 },
 HideFilterControlPopup: function() {
  var popup = this.GetFilterControlPopup();
  if(popup) popup.Hide();
 },
 ApplyFilterControl: function() {
  this.PreventCallbackAnimation();
  var fc = this.GetFilterControl();
  if(fc == null) return;
  if(!this.callBacksEnabled)
   this.HideFilterControlPopup();
  if(!fc.isApplied)
   fc.Apply(this);
 },
 SetFilterEnabled: function(isFilterEnabled) {
  this.gridCallBack([this.CommandId.SetFilterEnabled, isFilterEnabled]);
 },
 SetWidth: function(width) {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.OnSetWidth(width);
  this.constructor.prototype.SetWidth.call(this, width);
 },
 SetHeight: function(height) {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetHeight(height);
 },
 GetVertScrollPos: function() {
  return this.GetVerticalScrollPosition();
 },
 GetVerticalScrollPosition: function() {
  if(this.isVirtualScrolling) 
   return 0;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   return scrollHelper.GetVertScrollPosition();
  return 0;
 },
 GetHorzScrollPos: function() {
  return this.GetHorizontalScrollPosition();
 },
 GetHorizontalScrollPosition: function() {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   return scrollHelper.GetHorzScrollPosition();
  return 0;
 },
 SetVertScrollPos: function(value) {
  this.SetVerticalScrollPosition(value);
 },
 SetVerticalScrollPosition: function(value) {
  if(this.isVirtualScrolling) 
   return;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetVertScrollPosition(value);
 },
 SetHorzScrollPos: function(value) {
  this.SetHorizontalScrollPosition(value);
 },
 SetHorizontalScrollPosition: function(value) {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetHorzScrollPosition(value);
 },
 RaiseSelectionChangedOutOfServer: function() {
  this.RaiseSelectionChanged(-1, false, false, true);
 },
 RaiseSelectionChanged: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer) {
  if(!this.SelectionChanged.IsEmpty()){
   var args = new ASPxClientGridViewSelectionEventArgs(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer);
   this.SelectionChanged.FireEvent(this, args);
   if(args.processOnServer) {
    this.gridCallBack(["SELECTION"]);
   }
  }
  return false; 
 },
 RaiseFocusedRowChanged: function() {
  if(!this.FocusedRowChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(false);
   this.FocusedRowChanged.FireEvent(this, args);
   if(args.processOnServer) {
    this.gridCallBack(["FOCUSEDROW"]);
   }
  }
  return false; 
 },
 RaiseColumnSorting: function(column) {
  if(!this.ColumnSorting.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnSorting.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnGrouping: function(column) {
  if(!this.ColumnGrouping.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnGrouping.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnStartDragging: function(column) {
  if(!this.ColumnStartDragging.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnStartDragging.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnResizing: function(column) {
  if(!this.ColumnResizing.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnResizing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnResized: function(column) {
  if(!this.ColumnResized.IsEmpty()){
   var args = new ASPxClientGridViewColumnProcessingModeEventArgs(column);
   this.ColumnResized.FireEvent(this, args);
   if(args.processOnServer)
    this.Refresh();
  }
 },
 RaiseRowExpanding: function(visibleIndex) {
  if(!this.RowExpanding.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.RowExpanding.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseRowCollapsing: function(visibleIndex) {
  if(!this.RowCollapsing.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.RowCollapsing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseDetailRowExpanding: function(visibleIndex) {
  if(!this.DetailRowExpanding.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.DetailRowExpanding.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseDetailRowCollapsing: function(visibleIndex) {
  if(!this.DetailRowCollapsing.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.DetailRowCollapsing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseRowClick: function(visibleIndex, htmlEvent) {
  if(!this.RowClick.IsEmpty()){
   var args = new ASPxClientGridViewRowClickEventArgs(visibleIndex, htmlEvent);
   this.RowClick.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseRowDblClick: function(visibleIndex, htmlEvent) {
  if(!this.RowDblClick.IsEmpty()){
   _aspxClearSelection(); 
   var args = new ASPxClientGridViewRowClickEventArgs(visibleIndex, htmlEvent);
   this.RowDblClick.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseContextMenu: function(objectType, index, htmlEvent) {
  if(!this.ContextMenu.IsEmpty()){
   var args = new ASPxClientGridViewContextMenuEventArgs(objectType, index, htmlEvent);
   this.ContextMenu.FireEvent(this, args);
   return true;
  }
  return false; 
 },
 RaiseCustomizationWindowCloseUp: function() {
  if(!this.CustomizationWindowCloseUp.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.CustomizationWindowCloseUp.FireEvent(this, args);
  }
  return false; 
 },
 RaiseColumnMoving: function(targets) {
  if(this.ColumnMoving.IsEmpty()) return;
  var srcColumn = this.getColumnObject(targets.obj.id);
  var destColumn = this.getColumnObject(targets.targetElement.id);
  var isLeft = targets.isLeftPartOfElement();
  var isGroupPanel = targets.targetElement == targets.grid.GetGroupPanel();
  var args = new ASPxClientGridViewColumnMovingEventArgs(srcColumn, destColumn, isLeft, isGroupPanel);
  this.ColumnMoving.FireEvent(this, args);
  if(!args.allow) {
   targets.targetElement = null;
  }
 },
 RaiseInternalCheckBoxClick: function(visibleIndex) {
  if(!this.InternalCheckBoxClick.IsEmpty()){
   var args = {"visibleIndex": visibleIndex, cancel: false};
   this.InternalCheckBoxClick.FireEvent(this, args);
   return args.cancel;
  }
  return false;
 },
 UA_AddNew: function() {
  this.AddNewRow();
 },
 UA_StartEdit: function(visibleIndex) {
  this.StartEditRow(visibleIndex);
 },
 UA_Delete: function(visibleIndex) {
  this.DeleteGridRow(visibleIndex);
 },
 UA_UpdateEdit: function() {
  this.UpdateEdit();
 },
 UA_CancelEdit: function() {
  this.CancelEdit();
 },
 UA_CustomButton: function(id, visibleIndex) {
  this.CommandCustomButton(id, visibleIndex);
 },
 UA_Select: function(visibleIndex) {
  if(!this.lookupBehavior || this.allowSelectByRowClick)
   this.SelectRow(visibleIndex, !this._isRowSelected(visibleIndex));
 },
 UA_ClearFilter: function() {
  this.ClearFilter();
 }
});
ASPxClientGridView.Cast = ASPxClientControl.Cast;
ASPxClientGridViewColumn = _aspxCreateClass(null, {
 constructor: function(name, index, parentIndex, fieldName, visible, filterRowTypeKind, showFilterMenuLikeItem,
  allowGroup, allowSort, allowDrag, HFCheckedList, inCustWindow, minWidth) {
  this.name = name;
  this.id = name;
  this.index = index;
  this.parentIndex = parentIndex;
  this.fieldName = fieldName;
  this.visible = !!visible;
  this.filterRowTypeKind = filterRowTypeKind;
  this.showFilterMenuLikeItem = !!showFilterMenuLikeItem;
  this.allowGroup = !!allowGroup;
  this.allowSort = !!allowSort;
  this.allowDrag = !!allowDrag;
  this.HFCheckedList = !!HFCheckedList;
  this.inCustWindow = !!inCustWindow;
  this.minWidth = minWidth;
 }
});
ASPxClientGridViewColumnCancelEventArgs = _aspxCreateClass(ASPxClientCancelEventArgs, {
 constructor: function(column){
  this.constructor.prototype.constructor.call(this);
  this.column = column;
 }
});
ASPxClientGridViewColumnProcessingModeEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(column){
  this.constructor.prototype.constructor.call(this, false);
  this.column = column;
 }
});
ASPxClientGridViewRowCancelEventArgs = _aspxCreateClass(ASPxClientCancelEventArgs, {
 constructor: function(visibleIndex){
  this.constructor.prototype.constructor.call(this);
  this.visibleIndex = visibleIndex;
 }
});
ASPxClientGridViewSelectionEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer){
  this.constructor.prototype.constructor.call(this, false);
  this.visibleIndex = visibleIndex;
  this.isSelected = isSelected;
  this.isAllRecordsOnPage = isAllRecordsOnPage;
  this.isChangedOnServer = isChangedOnServer;
 }
});
ASPxClientGridViewRowClickEventArgs = _aspxCreateClass(ASPxClientGridViewRowCancelEventArgs, {
 constructor: function(visibleIndex, htmlEvent){
  this.constructor.prototype.constructor.call(this, visibleIndex);
  this.htmlEvent = htmlEvent;
 }
});
ASPxClientGridViewContextMenuEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(objectType, index, htmlEvent){
  this.constructor.prototype.constructor.call(this);
  this.objectType = objectType;
  this.index = index;
  this.htmlEvent = htmlEvent;
 }
});
ASPxClientGridViewCustomButtonEventArgs = _aspxCreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(visibleIndex, buttonID) {
  this.constructor.prototype.constructor.call(this, false);
  this.visibleIndex = visibleIndex;
  this.buttonID = buttonID;
 } 
});
ASPxClientGridViewColumnMovingEventArgs = _aspxCreateClass(ASPxClientEventArgs, {
 constructor: function(sourceColumn, destinationColumn, isDropBefore, isGroupPanel) {
  this.constructor.prototype.constructor.call(this);
  this.allow = true;
  this.sourceColumn = sourceColumn;
  this.destinationColumn = destinationColumn;
  this.isDropBefore = isDropBefore;
  this.isGroupPanel = isGroupPanel;
 }
});
ASPxGridViewKbdHelper = _aspxCreateClass(ASPxKbdHelper, {
 HandleKeyDown: function(e) {  
  var grid = this.control;
  var index = grid.GetFocusedRowIndex();
  var busy = grid.keyboardLock;
  var key = _aspxGetKeyCode(e);
  if(grid.rtl) {
   if(key == ASPxKey.Left)
    key = ASPxKey.Right;
   else if(key == ASPxKey.Right)
    key = ASPxKey.Left;
  }
  switch(key) {
   case ASPxKey.Down:
    if(!busy) 
     this.TryMoveFocusDown(index, e.shiftKey);
    return true;
   case ASPxKey.Up:
    if(!busy) 
     this.TryMoveFocusUp(index, e.shiftKey);
    return true;
   case ASPxKey.Right:
    if(!busy) {
     if(!this.TryExpand(index))
      this.TryMoveFocusDown(index, e.shiftKey);
    }
    return true;
   case ASPxKey.Left:
    if(!busy) {
     if(!this.TryCollapse(index))
      this.TryMoveFocusUp(index, e.shiftKey);
    }
    return true;
   case ASPxKey.PageDown:
    if(e.shiftKey) {
     if(!busy && grid.pageIndex < grid.pageCount - 1)
      grid.NextPage();
     return true; 
    }
    break;
   case ASPxKey.PageUp:
    if(e.shiftKey) {
     if(!busy && grid.pageIndex > 0)
      grid.PrevPage();
     return true; 
    }
    break;     
  }
  return false;
 },
 HandleKeyPress: function(e) {
  var grid = this.control;
  var index = grid.GetFocusedRowIndex();
  var busy = grid.keyboardLock;
  switch(_aspxGetKeyCode(e)) {
   case ASPxKey.Space:
    if(!busy && this.IsRowSelectable(index))
     grid.IsRowSelectedOnPage(index) ? grid.UnselectRowOnPage(index) : grid.SelectRowOnPage(index);
    return true;
    case 43:
    if(!busy)
     this.TryExpand(index);
    return true;
    case 45: 
    if(!busy)   
     this.TryCollapse(index);    
    return true;
  }
  return false;
 },
 EnsureFocusedRowVisible: function() {
  var grid = this.control;
  if(!grid.HasVertScroll()) return;
  var row = grid.GetRow(grid.GetFocusedRowIndex());
  grid.GetScrollHelper().MakeRowVisible(row, true);
 },
 HasDetailButton: function(expanded) {
  var grid = this.control;
  var row = grid.GetRow(grid.GetFocusedRowIndex());
  if(!row) return;
  var needle = expanded ? "aspxGVHideDetailRow" : "aspxGVShowDetailRow";
  return row.innerHTML.indexOf(needle) > -1;
 },
 IsRowSelectable: function(index) {
  if(this.control.allowSelectByRowClick)
   return true;
  var row = this.control.GetRow(index);
  if(row && row.innerHTML.indexOf("aspxGVSelectRow") > -1)
   return true;
  var check = this.control.GetDataRowSelBtn(index); 
  if(check && this.control.internalCheckBoxCollection && !!this.control.internalCheckBoxCollection.Get(check.id))
   return true;
  return false;
 },
 UpdateShiftSelection: function(start, end) {
  var grid = this.control;
  grid.UnselectAllRowsOnPage();
  if(grid.lastMultiSelectIndex > -1)   
   start = grid.lastMultiSelectIndex;
  else   
   grid.lastMultiSelectIndex = start;
  for(var i = Math.min(start, end); i <= Math.max(start, end); i++)
   grid.SelectRowOnPage(i);
 },
 TryExpand: function(index) {
  var grid = this.control;
  if(grid.IsGroupRow(index) && !grid.IsGroupRowExpanded(index)) {
   grid.ExpandRow(index);
   return true;
  }
  if(this.HasDetailButton(false)) {
   grid.ExpandDetailRow(index);
   return true;
  }
  return false;
 },
 TryCollapse: function(index) {
  var grid = this.control;
  if(grid.IsGroupRow(index) && grid.IsGroupRowExpanded(index)) {
   grid.CollapseRow(index);
   return true;
  }
  if(this.HasDetailButton(true)) {
   grid.CollapseDetailRow(index);
   return true;
  }
  return false;
 },
 TryMoveFocusDown: function(index, select) {
  var grid = this.control;
  if(index < grid.visibleStartIndex + grid.pageRowCount - 1) {
   if(index < 0) 
    grid.SetFocusedRowIndex(grid.visibleStartIndex);
    else
    grid.SetFocusedRowIndex(index + 1);
   this.EnsureFocusedRowVisible();
   if(this.IsRowSelectable(index)) {
    if(select) {
     this.UpdateShiftSelection(index, index + 1);
    } else {
     grid.lastMultiSelectIndex = -1;
    }
   }
  } else {
   if(grid.pageIndex < grid.pageCount - 1 && grid.pageIndex >= 0) {       
    grid.NextPage();
   }
  }  
 },
 TryMoveFocusUp: function(index, select) {
  var grid = this.control;
  if(index > grid.visibleStartIndex || index == -1) {
   if(index < 0) 
    grid.SetFocusedRowIndex(grid.visibleStartIndex + grid.pageRowCount - 1);
   else
    grid.SetFocusedRowIndex(index - 1);
   this.EnsureFocusedRowVisible();
   if(this.IsRowSelectable(index)) {
    if(select) {
     this.UpdateShiftSelection(index, index - 1);
    } else {
     grid.lastMultiSelectIndex = -1;
    }
   }
  } else {
   if(grid.pageIndex > 0) {
    grid.PrevPage(true);
   }
  }
 }
});
ASPxClientGridViewDragHelper = _aspxCreateClass(null, {
 constructor: function(grid) {
  this.grid = grid;
 },
 CreateDrag: function(e, element, canDrag) {
  var drag = new ASPxClientDragHelper(e, element, true);
  drag.centerClone = true;
  drag.canDrag = canDrag;  
  drag.grid = this.grid;
  drag.ctrl = e.ctrlKey;
  drag.shift = e.shiftKey;
  drag.onDragDivCreating = this.OnDragDivCreating;
  drag.onDoClick = this.OnDoClick;
  drag.onCloneCreating = this.OnCloneCreating;
  drag.onEndDrag = this.OnEndDrag;
  drag.onCancelDrag = this.OnCancelDrag;
  return drag;
 },
 PrepareTargetHeightFunc: function() {
  ASPxClientGridViewDragHelper.Target_GetElementHeight = null;
  var headerRowCount = this.grid.GetHeaderMatrix().GetRowCount();
  if(headerRowCount) {
   var row = this.grid.GetHeaderRow(headerRowCount - 1);
   var headerBottom = _aspxGetAbsoluteY(row) + row.offsetHeight;
   ASPxClientGridViewDragHelper.Target_GetElementHeight = function() {
    return headerBottom - this.absoluteY;
   };
  }
 },
 CreateTargets: function(drag, e) {
  if(!drag.canDrag) return;
  var grid = this.grid;
  this.PrepareTargetHeightFunc();
  var targets = new ASPxClientCursorTargets();
  targets.obj = drag.obj;
  targets.grid = grid;
  targets.onTargetCreated = this.OnTargetCreated;
  targets.onTargetChanging = this.OnTargetChanging;
  targets.onTargetChanged = this.OnTargetChanged;
  var scrollLeft = null, scrollRight;
  var scrollHelper = grid.GetScrollHelper();
  var scrollableControl = scrollHelper && scrollHelper.GetHorzScrollableControl();
  if(scrollableControl) {
   scrollLeft = _aspxGetAbsoluteX(scrollableControl);
   scrollRight = scrollLeft + scrollableControl.offsetWidth;
  }
  var sourceColumn = grid.getColumnObject(drag.obj.id);
  var win = grid.GetCustomizationWindow();
  if(win && !sourceColumn.inCustWindow)
   this.AddDragDropTarget(targets, win.GetWindowClientTable(-1));
  for(var i = 0; i < grid.columns.length; i++) {
   var column = grid.columns[i];
   for(var grouped = 0; grouped <= 1; grouped++) {
    var targetElement = grid.GetHeader(column.index, !!grouped);
    if(!targetElement)
     continue;
    if(scrollLeft !== null) {
     var targetX = _aspxGetAbsoluteX(targetElement);
     if(targetX < scrollLeft || targetX + targetElement.offsetWidth > scrollRight)
      continue;
    }
    if(this.IsValidColumnDragDropTarget(drag.obj, targetElement, sourceColumn, column))
     this.AddDragDropTarget(targets, targetElement);  
   }
  }
  this.AddDragDropTarget(targets, grid.GetGroupPanel());
  this.AddDragDropTarget(targets, _aspxGetElementById(grid.name + this.grid.EmptyHeaderSuffix));
 },
 IsValidColumnDragDropTarget: function(sourceElement, targetElement, sourceColumn, targetColumn) {
  if(sourceColumn == targetColumn)
   return false;
  if(sourceColumn.parentIndex == targetColumn.parentIndex)
   return true;
  if(sourceColumn.parentIndex == targetColumn.index) {
   return (sourceColumn.inCustWindow || this.IsGroupingTarget(sourceElement))
    && this.grid.GetHeaderMatrix().IsLeaf(targetColumn.index);
  }
  if(this.IsGroupingTarget(targetElement))
   return true;
  return false;
 },
 AddDragDropTarget: function(targets, element) {
  element && targets.addElement(element);
 },
 IsGroupHeaderTarget: function(element) {
  if(!element)
   return false;
  return element.id.indexOf(this.grid.name + "_groupcol") == 0;
 },
 IsGroupingTarget: function(element) { 
  return element == this.grid.GetGroupPanel() || this.IsGroupHeaderTarget(element);
 },
 IsCustWindowTarget: function(element) {
  var win = this.grid.GetCustomizationWindow();
  return win && element == win.GetWindowClientTable(-1); 
 },
 OnDragDivCreating: function(drag, dragDiv) {
  var rootTable = drag.grid.GetRootTable();
  if(!dragDiv || !rootTable) return;
  dragDiv.className = rootTable.className;
  dragDiv.style.cssText = rootTable.style.cssText;
 },
 OnDoClick: function(drag) {
  if(!drag.grid.canSortByColumn(drag.obj)) return;
  drag.grid.SortBy(drag.grid.getColumnIndex(drag.obj.id), drag.ctrl ? "NONE" : "", !drag.shift && !drag.ctrl);
 },
 OnCancelDrag: function(drag) {
  drag.grid.dragHelper.ChangeTargetImagesVisibility(false);
 },
 OnEndDrag: function(drag) {
  if(!drag.targetElement)
   return;
  var grid = drag.grid;
  var sourceElement = drag.obj;
  var targetElement = drag.targetElement;
  var isLeft = drag.targetTag;
  if(grid.rtl)
   isLeft = !isLeft;
  grid.MoveColumn(
   grid.getColumnIndex(sourceElement.id),
   grid.IsEmptyHeaderID(targetElement.id) ? 0 : grid.getColumnIndex(targetElement.id),
   isLeft,
   grid.dragHelper.IsGroupingTarget(targetElement),
   grid.dragHelper.IsGroupingTarget(sourceElement)
  );
 },
 OnCloneCreating: function(clone) {
  var table = document.createElement("table");
  table.cellSpacing = 0;
  if(this.obj.offsetWidth > 0)
   table.style.width = Math.min(200, this.obj.offsetWidth) + "px";
  if(this.obj.offsetHeight > 0)
   table.style.height = this.obj.offsetHeight + "px";
  var row = table.insertRow(-1);
  clone.style.borderLeftWidth = "";
  clone.style.borderTopWidth = "";
  clone.style.borderRightWidth = "";
  row.appendChild(clone);
  table.style.opacity = 0.80;
  table.style.filter = "alpha(opacity=80)"; 
  if(_aspxIsElementRightToLeft(this.obj))
   table.dir = "rtl";
  return table;
 },
 OnTargetCreated: function(targets, targetObj) {
  var f = ASPxClientGridViewDragHelper.Target_GetElementHeight;
  var h = targets.grid.dragHelper;
  var el = targetObj.element;
  if(f && !h.IsCustWindowTarget(el) && !h.IsGroupingTarget(el))
   targetObj.GetElementHeight = f;
 },
 OnTargetChanging: function(targets) {
  if(!targets.targetElement)
   return;
  targets.targetTag = targets.isLeftPartOfElement();
  var grid = targets.grid;
  var grouping = false;
  if(targets.targetElement == grid.GetGroupPanel()) {
   targets.targetTag = true;
   grouping = true;
  }  
  if(grid.dragHelper.IsGroupHeaderTarget(targets.targetElement)) {
   grouping = true;
  }
  if(grouping && !grid.canGroupByColumn(targets.obj))
   targets.targetElement = null;
  if(targets.targetElement) {
   grid.RaiseColumnMoving(targets);
  }
 },
 OnTargetChanged: function(targets) {
  if(__aspxDragHelper == null)
   return;
  var element = targets.targetElement;
  if(element == __aspxDragHelper.obj)
   return;
  var grid = targets.grid;
  grid.dragHelper.ChangeTargetImagesVisibility(false);
  if(!element) {
   __aspxDragHelper.targetElement = null;
   return;
  }
  __aspxDragHelper.targetElement = element;
  __aspxDragHelper.targetTag = targets.targetTag;
  var moveToGroup = grid.dragHelper.IsGroupingTarget(element);
  var moveToCustWindow = grid.dragHelper.IsCustWindowTarget(element);
  if(moveToCustWindow) {
   __aspxDragHelper.addElementToDragDiv(grid.GetArrowDragFieldImage());
   return;
  }
  var matrix =  grid.GetHeaderMatrix();
  var targetColumnIndex = grid.getColumnIndex(element.id);
  var isRightSide = !targets.targetTag;
  var left = _aspxGetAbsoluteX(element);
  var neighbor;
  if(moveToGroup) {
   var method = isRightSide ^ grid.rtl ? "nextSibling" : "previousSibling";
   neighbor = grid.dragHelper.GetGroupNodeNeighbor(element, method);
   if(neighbor && neighbor.id == __aspxDragHelper.obj.id) {
    __aspxDragHelper.targetElement = null;
    return;
   }
  } else {
   if(targetColumnIndex > -1) {
    var method = isRightSide ^ grid.rtl ? "GetRightNeighbor" : "GetLeftNeighbor";
    var neighborIndex = matrix[method](targetColumnIndex);
    var sourceColumn = grid.getColumnObject(__aspxDragHelper.obj.id);
    if(neighborIndex == sourceColumn.index && !sourceColumn.inCustWindow && !grid.dragHelper.IsGroupHeaderTarget(__aspxDragHelper.obj)) {
     __aspxDragHelper.targetElement = null;
     return;
    } 
    if(!isNaN(neighborIndex))
     neighbor = grid.GetHeader(neighborIndex)
   }
   }
  if(element == grid.GetGroupPanel()) {
   if(grid.rtl)
    left += element.offsetWidth;
  } else {
   if(isRightSide) {
    if(neighbor)
     left = _aspxGetAbsoluteX(neighbor);
    else
     left += element.offsetWidth;
   }
  }
  var bottomElement = element;
  if(!moveToGroup && targetColumnIndex > -1)
   bottomElement = grid.GetHeader(matrix.GetLeaf(targetColumnIndex, !isRightSide, false));
  grid.dragHelper.SetDragImagesPosition(left, _aspxGetAbsoluteY(element),  _aspxGetAbsoluteY(bottomElement) + bottomElement.offsetHeight);
  grid.dragHelper.ChangeTargetImagesVisibility(true);
 },
 GetGroupNodeNeighbor: function(element, method) {
  return this.GetGroupNodeNeighborCore(element, method, 2);
 },
 GetGroupNodeNeighborCore: function(element, method, distance) {
  var neighbor = element[method];
  if(neighbor && neighbor.nodeType == 1) {
   if(this.IsGroupingTarget(neighbor)) 
    return neighbor;
   if(distance > 1)
    return this.GetGroupNodeNeighborCore(neighbor, method, --distance);
  }
  return null;
 },
 ChangeTargetImagesVisibility: function(vis) {
  if(this.grid.GetArrowDragDownImage() == null) return;
  var value = vis ? "visible" : "hidden";
  this.grid.GetArrowDragDownImage().style.visibility = value;
  this.grid.GetArrowDragUpImage().style.visibility = value;
  if(__aspxDragHelper != null) {
   __aspxDragHelper.removeElementFromDragDiv();
  }
 },
 SetDragImagesPosition: function(left, top, bottom) {
  var downImage = this.grid.GetArrowDragDownImage();
  if(downImage) {
   _aspxSetAbsoluteX(downImage, left - downImage.offsetWidth / 2);
   _aspxSetAbsoluteY(downImage, top - downImage.offsetHeight);
  }
  var upImage = this.grid.GetArrowDragUpImage();
  if(upImage) {
   _aspxSetAbsoluteX(upImage, left - upImage.offsetWidth / 2);
   _aspxSetAbsoluteY(upImage, bottom);
  }
 }
});
ASPxClientGridViewDragHelper.Target_GetElementHeight = null;
ASPxClientGridViewHeaderMatrix = _aspxCreateClass(null, {
 constructor: function(grid) {
  this.grid = grid;
 },
 Invalidate: function() {
  this.matrix = null;
  this.inverseMatrix = null;
 }, 
 GetRowCount: function() {
  this.EnsureMatrix();
  return this.matrix.length;
 },
 IsLeftmostColumn: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].left == 0;
 },
 IsRightmostColumn: function(columnIndex) {
  this.EnsureMatrix();  
  return this.inverseMatrix[columnIndex].right == this.matrix[0].length - 1;
 },
 IsLeaf: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].bottom == this.matrix.length - 1;
 },
 GetLeaf: function(columnIndex, isLeft, isOuter) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  var row = this.matrix[this.matrix.length - 1];
  if(isLeft) {
   if(isOuter)
    return row[rect.left - 1];
   return row[rect.left];
  }
  if(isOuter)
   return row[rect.right + 1];
  return row[rect.right];
 },
 GetLeafIndex: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].left;
 },
 GetLeafIndices: function() {
  return this.GetRowIndices(this.GetRowCount() - 1);
 },
 GetRowIndices: function(rowIndex) {
  this.EnsureMatrix();
  return this.matrix[rowIndex] || [];
 },
 GetRowSpan: function(columnIndex) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  return rect.bottom - rect.top + 1;
 },
 GetLeftNeighbor: function(columnIndex) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  return this.matrix[rect.top][rect.left - 1];
 },
 GetRightNeighbor: function(columnIndex) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  return this.matrix[rect.top][rect.right + 1];
 },
 GetRightNeighborLeaf: function(columnIndex) {
  return this.GetLeaf(columnIndex, false, true);
 },
 EnsureMatrix: function() {
  this.matrix || this.Fill();
 },
 Fill: function() {
  this.matrix = [ ];
  this.inverseMatrix = { };
  var rowIndex = 0;
  while(true) {
   var row = this.grid.GetHeaderRow(rowIndex);
   if(!row)
    break;
   var lastFreeIndex = 0;
   for(var cellIndex = !rowIndex ? this.grid.indentColumnCount : 0; cellIndex < row.cells.length; cellIndex++) {
    var cell = row.cells[cellIndex];
    var columnIndex = this.grid.getColumnIndex(cell.id);
    if(columnIndex < 0)
     break;
    lastFreeIndex = this.FindFreeCellIndex(rowIndex, lastFreeIndex);
    this.FillBlock(rowIndex, lastFreeIndex, cell.rowSpan, cell.colSpan, columnIndex);
    lastFreeIndex += cell.colSpan;
   }
   ++rowIndex;
  }
 },
 FindFreeCellIndex: function(rowIndex, lastFreeCell) {
  var row = this.matrix[rowIndex];
  var result = lastFreeCell;
  if(row) {
   while(!isNaN(row[result]))
    result++;
  } 
  return result;
 },
 FillBlock: function(rowIndex, cellIndex, rowSpan, colSpan, columnIndex) {
  var rect = {
   top: rowIndex,
   bottom: rowIndex + rowSpan - 1,
   left: cellIndex,
   right: cellIndex + colSpan - 1
  };
  for(var i = rect.top; i <= rect.bottom; i++) {
   while(!this.matrix[i])
    this.matrix.push([]);
   for(var j = rect.left; j <= rect.right; j++)
    this.matrix[i][j] = columnIndex;
  }
  this.inverseMatrix[columnIndex] = rect;
 }
});
function aspxGVContextMenu(name, e) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.OnContextMenuClick(e);
}
function aspxGVExpandRow(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.ExpandRow(value);
}
function aspxGVCollapseRow(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.CollapseRow(value);
}
function aspxGVShowDetailRow(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.ExpandDetailRow(value);
}
function aspxGVHideDetailRow(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.CollapseDetailRow(value);
}
function aspxGVHeaderMouseDown(name, element, e) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.HeaderMouseDown(element, e);
}
function aspxGVPagerOnClick(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.doPagerOnClick(value);
}
function aspxGVFilterKeyPress(name, element, e) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.OnColumnFilterInputKeyPress(element, e);
}
function aspxGVFilterSpecKeyPress(name, element, e) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.OnColumnFilterInputSpecKeyPress(element, e);
}
function aspxGVFilterChanged(name, element) {
 _aspxSetTimeout("aspxGVFilterChangedDelayed(\""+name+"\", \"" + element.name + "\");", 0);
}
function aspxGVFilterChangedDelayed(name, elementName) {
 var gv = aspxGetControlCollection().Get(name);
 var element = aspxGetControlCollection().Get(elementName);
 if(gv != null && element != null) 
  gv.OnColumnFilterInputChanged(element);
}
function aspxGVTimer(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) 
  gv.OnFilterKeyPressTick();
}
function aspxGVShowParentRows(name, evt, element) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) {
  if(element)
   gv.OnParentRowMouseEnter(element);  
  else 
   gv.OnParentRowMouseLeave(evt);
 }
}
function aspxGVTableClick(name, evt) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null && gv.NeedProcessTableClick(evt))
  gv.mainTableClick(evt);
}
function aspxGVTableDblClick(name, evt) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null && gv.NeedProcessTableClick(evt))
  gv.mainTableDblClick(evt);
}
function aspxGVParentRowsTimer(name, rowId) {
 var gv = aspxGetControlCollection().Get(name);
 var element = _aspxGetElementById(rowId);
 if(!element || !gv) return;
 gv.ShowParentRows(element);
}
function aspxGVCustWindowShown_IE(s) {
 var div = document.getElementById(s.name + "_Scroller");
 div.style.overflow = "hidden";
 var width1 = div.clientWidth;
 div.style.overflow = "auto";
 var width2 = div.clientWidth;
 if(width2 > width1) {
  div.style.width = width1 + "px";
  div.style.paddingRight = (width2 - width1) + "px";
  window.setTimeout(function() { 
   div.className = "_";
   div.className = "";
  }, 0);
 }
}
function aspxGVCustWindowCloseUp(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) {
  gv.RaiseCustomizationWindowCloseUp();
 }
}
function aspxGVApplyFilterPopup(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.ApplyHeaderFilterByColumn();
}
function aspxGVShowFilterControl(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) {
  gv.ShowFilterControl();
 }
}
function aspxGVCloseFilterControl(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) {
  gv.CloseFilterControl();
 }
}
function aspxGVSetFilterEnabled(name, value) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null) {
  gv.SetFilterEnabled(value);
 }
}
function aspxGVApplyFilterControl(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.ApplyFilterControl();
}
function aspxGVFilterRowMenu(name, columnIndex, element) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.FilterRowMenuButtonClick(columnIndex, element);
}
function aspxGVFilterRowMenuClick(name, e) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.FilterRowMenuItemClick(e.item);
}
function aspxGVSort(name, columnIndex) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)  
  gv.SortBy(columnIndex);
}
function aspxGVScheduleCommand(name, commandArgs, postponed) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.ScheduleCommand(commandArgs, postponed);
}
function aspxGVHFListBoxInit(name, listBox) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null && listBox)
  gv.InitializeHFListBox(listBox);
}
function aspxGVHFSelectAllCheckedChanged(name, checkBox) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null && checkBox)
  gv.OnHFSelectAllCheckedChanged(checkBox);
}
function aspxGVHFCancelButtonClick(name) {
 var gv = aspxGetControlCollection().Get(name);
 if(gv != null)
  gv.GetHeaderFilterPopup().Hide();
}
ASPxClientGridView.SelectStartHandler = function(e) {
 if(_aspxGetEventSource(e).tagName.match(/input|select|textarea/i))
  return;
 if(e.ctrlKey || e.shiftKey) {
  _aspxClearSelection();
  _aspxPreventEventAndBubble(e);
 }
};
ASPxClientGridView.SaveActiveElementSettings = function(grid) {
 var element = grid.activeElement;
 grid.activeElement = null;
 ASPxClientGridView.activeElementData = null;
 if (!element || !element.id || element.tagName != "INPUT" || element.id.indexOf(grid.name + "_") != 0)
  return;  
 ASPxClientGridView.activeElementData = [ grid.name, element.id, _aspxGetSelectionInfo(element).endPos ];
 if(typeof(Sys) != "undefined" && typeof(Sys.Application) != "undefined") {
  if(!ASPxClientGridView.MsAjaxActiveElementHandlerAdded) {
   Sys.Application.add_load(function() { ASPxClientGridView.RestoreActiveElementSettings(); } );
   ASPxClientGridView.MsAjaxActiveElementHandlerAdded = true;
  }
 } 
};
ASPxClientGridView.RestoreActiveElementSettings = function(grid) {
 var data = ASPxClientGridView.activeElementData;
 if(!data || grid && data[0] != grid.name) return;
 var element = _aspxGetElementById(data[1]);
 if (element) {
  element.focus();
  _aspxSetInputSelection(element, data[2], data[2]);
 }
 ASPxClientGridView.activeElementData = null;
};
