window.lib4x = window.lib4x || {};
window.lib4x.axt = window.lib4x.axt || {};
window.lib4x.axt.ig = window.lib4x.axt.ig || {};

/*
 * Region Plugin, enabling to replace the IG Single Row View with a Row View in a regular region, dialog or drawer.
 * It is basically a wrapper around the recordView widget. This widget gets instantiated with the same 
 * model and same field configuration as the IG model and columns configuration.
 */
lib4x.axt.ig.externalRowView = (function($) {
    
    const C_RV = 'a-RV';
    const C_RV_BODY = 'a-RV-body';
    const C_COLLAPSIBLE = 'a-Collapsible';
    const C_COLLAPSIBLE_CONTENT = 'a-Collapsible-content';
    const C_FLEX = 'u-flex';
    const C_FLEX_GROW_1 = 'u-flex-grow-1';
    const C_FORM = 'u-Form';
    const C_FORM_GROUP_HEADING = 'u-Form-groupHeading';
    const C_APEX_WAIT_OVERLAY = 'apex_wait_overlay';
    const C_LIB4X_IG_ERV = 'lib4x-ig-erv';
    const C_LIB4X_FORM_LABEL_WIDTH_PREFIX = 'lib4x-form-label-width-';
    const C_LIB4X_IG_ERV_HIDDEN = 'lib4x-ig-erv-hidden';
    const RV_EXT = '_rv';
    let rvOptions = {};         // plugin options and config
    let rv_igStaticId = {};     // maps the rv widget id to the IG static Id

    /* 
     * An IG with an ext row view (ERV) is made readonly. Upon dbl click, the ext row view will be put in edit mode (and 
     * in case the ERV is configured as a Inline Drawer/Dialog, the dialog will be opened).
     * The IG row menu is also extended with an edit item as an alternative way to start editing in the ERV.
     * An ext row view and a single row view (SRV) can not be used at the same time. On the IG, the developer has to 
     * disable the SRV feature.
     * Upon IG selection change, the ERV will be triggered to change the current record as well.
     */
    let gridModule = (function() 
    {
        $('#wwvFlowForm').on("interactivegridviewmodelcreate", function(jQueryEvent, data) { 
            let model = data.model;
            model.subscribe({
                onChange: function(changeType, change) {
                    if (changeType == 'metaChange')
                    {
                        // Because of an APEX bug, incorrectly a validation error message is shown for a required field (which has a value anyway)
                        // in the situation where you start edit mode and the record is not allowed to be edited. Then, when you paginate to the
                        // next record, the validation error is shown on the field.
                        // To workarround this, we catch the related model notification ('metaChange' is 'message,error') and if the record 
                        // is not allowed to be edited, we clear the error.
                        if (change.recordId && change.property && change.property.includes('message') && change.property.includes('error'))
                        {
                            let recMetadata = model.getRecordMetadata(change.recordId);
                            if (!model.allowEdit(change.record) && !modelsModule.util.recordFieldsValid(recMetadata))
                            {
                                modelsModule.util.setRecordFieldsValid(model, change.record);
                            }
                        }
                    }           
                }
            });
        });

        /*
         * Init/Adjust the IG for which an ERV is configured. 
         */
        let initIG = function(igStaticId, rvStaticId, rvStaticIdRv)
        {
            // Overwrite IG grid setEditMode method
            function extendGridWidget()
            {
                $.widget("apex.grid", $.apex.grid, {
                    setEditMode: function (editMode, select) {
                        let staticId = this.element.closest('.a-IG').interactiveGrid('option').config.regionStaticId;
                        if (staticId == igStaticId)
                        {
                            rowViewModule.setEditMode(rvStaticId, editMode);
                            return;
                        }
                        return this._super(editMode, select);
                    }
                });         
            }

            if ($.apex.grid)
            {
                // if loaded already, extend now, else await the load event
                extendGridWidget();
            }   

            var bodyElem = document.getElementsByTagName("body")[0];
            bodyElem.addEventListener("load", function(event) {
                if (event.target.nodeName === "SCRIPT")
                {
                    let srcAttr = event.target.getAttribute("src");
                    // grid subwidget
                    if (srcAttr && srcAttr.includes('widget.grid'))
                    {
                        extendGridWidget();
                    }                 
                }
            }, true);   // usecapture is critical here       

            $(apex.gPageContext$).on("apexreadyend", function(jQueryEvent) { 
                let igRegion = apex.region(igStaticId);
                if (!igRegion || igRegion.type != 'InteractiveGrid')
                {
                    throw new Error('IG External Row View Settings error: \'' + igStaticId + '\' is not an Interactive Grid Region');
                }            
                let igActions = apex.region(igStaticId).call("getActions");
                // hide edit button - using it would make it complex to toggle the button properly
                igActions.hide("edit");
                // single row view should not exist
                // as developer should disable the feature in IG init func
                // if not disabled though, we hide the menu option
                if (igActions.lookup('single-row-view'))
                {
                    igActions.hide("single-row-view");
                }
                let action = igActions.lookup("edit");
                if (action)
                {
                    // we hide the edit button (see above), but if the edit action is called programmatically, 
                    // the below will take care of switching the edit mode in the related ERV
                    action.set = function(editMode) {
                        rowViewModule.setEditMode(rvStaticId, editMode);
                    };
                    action.get = function() {
                        return $("#" + rvStaticIdRv).recordView('inEditMode');
                    }
                } 
                // make action 'lib4x-erv-open' available, which can be used for example when the developer
                // wants to open the ERV from an IG link column
                igActions.add({ 
                    name: 'lib4x-erv-open', 
                    action: function(event) { 
                        rowViewModule.openRowView(rvStaticId);
                    }
                });  
                let gridView = apex.region(igStaticId).call("getViews", "grid");
                // insert edit menu option after 'Add Row' option
                let rowActionMenu$ = gridView.rowActionMenu$;
                let addRowMenu = rowActionMenu$.menu('option').items.filter((mi)=>mi.action=='row-add-row');
                let index = 0;
                if (addRowMenu.length)
                {
                    index = rowActionMenu$.menu('option').items.indexOf(addRowMenu[0]) + 1;
                }
                rowActionMenu$.menu("option").items.splice(index, 0, {
                    id: 'lib4x_edit',
                    type: 'action',
                    label: 'Edit Row',
                    icon: 'fa fa-edit',
                    action:function(e, el)
                    {
                        let gridView = apex.region(igStaticId).call('getViews').grid;
                        let record = gridView.getContextRecord(el);
                        gridView.view$.grid('setSelectedRecords', record);
                        rowViewModule.setEditMode(rvStaticId, true);
                        if (!$("#" + rvStaticId).is(':ui-dialog'))
                        {
                            setTimeout(()=>{$('#' + rvStaticIdRv).recordView('focus');}, 100);
                        }
                    },   
                    disabled: function (options)
                    {
                        let gridView = $(options.actionsContext.context).interactiveGrid('getViews').grid;
                        let model = gridView.model;      
                        let record = gridView.getContextRecord(gridView.view$.find(".a-Button--actions.is-active")[0])[0];
                        return (!model.allowEdit(record));
                    }
                }); 
                // in case of readonly IG, also enable to open any ERV by dbl click in case it is a dialog
                if (!apex.region(igStaticId).call('option').config.editable)
                {
                    if ($('#' + rvStaticId).is(':ui-dialog')) 
                    {
                        apex.region(igStaticId).element.on('dblclick', function(jQueryEvent, data){
                            rowViewModule.openRegion(rvStaticId, true);
                        });
                    }
                }
            });   
            
            // upon selection change, also change the ERV record
            $("#" + igStaticId).on("interactivegridselectionchange", function(event, data) {
                if (data.selectedRecords?.length)
                {
                    rowViewModule.gotoIGSelectedRecord(rvStaticIdRv);
                }
            });
        }
        
        return{
            initIG: initIG
        }
    })();  

    /*
     * The ext row view is basically a wrapper around a recordView instance, configured with
     * the same model and field configurations as the IG. The ERV can be modelled as a regular
     * region or as a drawer/dialog.
     */
    let rowViewModule = (function() 
    {
        // Below function illustrates how it is also possible to get the IG static Id.
        // For convenience, we maintain the rv_igStaticId hash table and get the Id from there.
        // It also illustrates we don't need a jQuery data() entry for it.
        function getIGStaticId(rvStaticIdRv)
        {
            return ($('#' + rvStaticIdRv).recordView('getModel').getOption('regionStaticId'));
        }

        // enables to remove a control from a toolbar group
        function toolbarRemove(toolbar, actionName, labelKey)
        {
            groupLoop: for (tbGroup of toolbar)
            {
                for (tbControl of tbGroup.controls)
                {
                    if ((tbControl.action && tbControl.action == actionName) ||  (tbControl.labelKey && tbControl.labelKey == labelKey))
                    {
                        let index = tbGroup.controls.indexOf(tbControl);
                        tbGroup.controls.splice(index, 1);
                        break groupLoop;
                    }
                }
            }
        }

        // converts the rv body into a flex column layout as per the field groups definitions
        function applyFieldGroupColumns(rvStaticIdRv)
        {
            let rvBodySelector = '#' + rvStaticIdRv + ' .' + C_RV_BODY;
            if ($(rvBodySelector + ' .' + C_COLLAPSIBLE).length)
            {
                $(rvBodySelector + ' .' + C_COLLAPSIBLE).hide();
                $(rvBodySelector).addClass(C_FLEX);
                $(rvBodySelector + ' .'+ C_COLLAPSIBLE_CONTENT).each(function(){$(this).addClass(C_FLEX_GROW_1)});      
            }         
        }

        // adjust the rv body as per the erv plugin options
        function adjustRvBody(rvStaticIdRv)
        {
            let options = rvOptions[rvStaticIdRv]; 
            // With group heading buttons, a recordView focus results in a focus on the button instead of the
            // first input field. To prevent, we set the buttons tabindex to '-1'.
            $('#' + rvStaticIdRv + ' .' + C_RV_BODY + ' .' + C_FORM_GROUP_HEADING + ' button').each(function(){$(this).attr('tabindex', '-1')});                      
            if (options.columnsLayout == 'FIELD_GROUP_COLUMNS')            
            {
                applyFieldGroupColumns(rvStaticIdRv);
            }
        }

        // group hide feature
        function hideGroup(rvStaticId, fieldStaticId)
        {
            let fieldContainer$ = $('#' + rvStaticId + ' .' + C_RV_BODY + ' #' + fieldStaticId + '_CONTAINER');
            fieldContainer$.closest('.' + C_FORM_GROUP_HEADING).hide();
            fieldContainer$.closest('.' + C_FORM).hide();
        }

        /*
         * Open the row view (dialog, drawer) and switch to edit mode if the view is editable.
        */
        function openRowView(rvStaticId)
        {
            let rvStaticIdRv = rvStaticId + RV_EXT;
            if ($("#" + rvStaticIdRv).recordView('instance'))
            {
                if ($("#" + rvStaticIdRv).recordView('option', 'editable'))
                {
                    setEditMode(rvStaticId, true);
                }
                else
                {
                    openRegion(rvStaticId);
                }
            }
        }

        // Set the edit mode in the underlying recordView. 
        // If the ERV is a dialog or drawer region, opens the region.
        // Pass editMode only as true in case the RV is editable.
        function setEditMode(rvStaticId, editMode)
        {
            let rvStaticIdRv = rvStaticId + RV_EXT;
            if ($("#" + rvStaticIdRv).recordView('instance'))
            {
                if (editMode)
                {
                    if ($("#" + rvStaticId).is(':ui-dialog'))
                    {
                        openRegion(rvStaticId);
                    }
                }            
                if (editMode && !$("#" + rvStaticIdRv).recordView('inEditMode'))
                {
                    if ($("#" + rvStaticIdRv).recordView('option', 'editable'))
                    {
                        $("#" + rvStaticIdRv).recordView('setEditMode', true);
                    }
                }    
                else if (!editMode && $("#" + rvStaticIdRv).recordView('inEditMode')) 
                {
                    $("#" + rvStaticIdRv).recordView('setEditMode', false);
                }  
            } 
        }

        // Opens the ERV drawer/dialog region 
        function openRegion(rvStaticId)
        {
            apex.theme.openRegion(rvStaticId);                           
        }

        // make same record current as selected in IG
        function gotoIGSelectedRecord(rvStaticIdRv)
        {
            // check instance 
            // check also if visible
            // if not visible, 'gotoField' will not execute a refresh, so it wouldn't make sence
            // to call it
            if (($("#" + rvStaticIdRv).recordView('instance')) && ($("#" + rvStaticIdRv).is(':visible')))
            {
                let igStaticId = rv_igStaticId[rvStaticIdRv];
                let selectedRecords = apex.region(igStaticId).call('getSelectedRecords');
                if (selectedRecords.length)
                {
                    let record = selectedRecords[0];
                    let model = apex.region(igStaticId).call('getViews').grid.model;
                    let recordId = model.getRecordId(record);
                    let currentRecordId = null;
                    let currentRecord = $("#" + rvStaticIdRv).recordView('getRecord');
                    if (currentRecord)
                    {
                        currentRecordId = model.getRecordId(currentRecord);
                    }
                    if (recordId != currentRecordId)
                    {
                        $("#" + rvStaticIdRv).recordView('gotoField', recordId);
                    }
                }
            }   
        }

        /*
         * Init the ERV. A recordView is instantiated with same field definitions as the IG column definitions, and the same model.
         * Toolbar is configured. 
         */
        let initRV = function(rvStaticId, rvStaticIdRv, igStaticId)
        {
            function doInitRv(rvStaticId, rvStaticIdRv, igStaticId)
            {
                let options = rvOptions[rvStaticIdRv];
                // check SRV feature should be disabled
                if (apex.region(igStaticId).call('getViews').grid.singleRowView$)
                {
                    throw new Error('Interactive Grid (' + igStaticId + ') can not have both Single Row View and External Row View. Disable SRV in IG Initialization JavaScript Function.');
                }
                // check there is no other ERV for the same IG
                if ($('.' + C_LIB4X_IG_ERV + ' .' + C_RV).filter(function() {                    
                    return(rv_igStaticId[$(this).attr('id')] == igStaticId);
                }).length)
                {
                    throw new Error('Can not have more than 1 External Row View for the same Interactive Grid ('+igStaticId+')');
                }    
                // compose the fields for the recordView    
                // the row items are shared between the IG and the recordView,
                // so the field definitions are just a copy of the IG column definitions                                
                let columns = apex.region(igStaticId).call('getViews').grid.view$.grid('getColumns');
                let fields = {};
                for (columnNo in columns)
                {
                    // the C_LIB4X_IG_ERV_HIDDEN class can be given on the column (appearance section) or link attributes as to 
                    // indicate the column should not be included in the ERV
                    let skip = ((!columns[columnNo].elementId) ||
                                (columns[columnNo].linkAttributes && columns[columnNo].linkAttributes.includes(C_LIB4X_IG_ERV_HIDDEN)) ||
                                (columns[columnNo].columnCssClasses && columns[columnNo].columnCssClasses.includes(C_LIB4X_IG_ERV_HIDDEN)))
                    if (!skip)
                    {
                        fields[columns[columnNo].property] = $.extend(true, {}, columns[columnNo]);
                        fields[columns[columnNo].property].fieldCssClasses = columns[columnNo].columnCssClasses;
                        delete fields[columns[columnNo].property].columnCssClasses;
                    }
                }       
                // include buttons in the toolbar for crud actions and refresh             
                let actionsContext = apex.actions.createContext('recordView', $("#" + rvStaticIdRv)[0]);
                let toolbar = $.apex.recordView.copyDefaultToolbar();
                toolbarRemove(toolbar, null, 'APEX.RV.SETTINGS_MENU');
                toolbar[0].controls.push(
                {
                    action: "insert-record",
                    type: 'BUTTON',
                    iconOnly: true,
                    icon: 'icon-ig-add-row'
                },
                {
                    action: "duplicate-record",
                    type: 'BUTTON',
                    iconOnly: true,
                    icon: 'icon-ig-duplicate'                        
                },
                {
                    action: "delete-record",
                    type: 'BUTTON',
                    iconOnly: true,
                    icon: 'icon-ig-delete'                        
                },
                {
                    action: "refresh-record",
                    type: 'BUTTON',
                    iconOnly: true,
                    icon: 'icon-ig-refresh'                        
                },
                {
                    action: "revert-record",
                    type: 'BUTTON',
                    iconOnly: true,
                    icon: 'icon-ig-revert'                        
                });              
                if (options.columnsLayout != 'FIELD_GROUP_COLUMNS')
                {
                    // when groups are used, include a collapse/expand all button in the toolbar
                    let groupedFieldsLength = Object.entries(fields).filter(
                        ([key, val])=>(val.groupName)
                    ).length;
                    if (groupedFieldsLength > 0)
                    {
                        toolbar[toolbar.length-1].controls.splice(1, 0, {
                            action: "lib4x-toggle-collapsibles",
                            type: 'BUTTON',
                            iconOnly: true          
                        });
                        actionsContext.add([
                        { 
                            name: 'lib4x-toggle-collapsibles', 
                            labelKey: 'LIB4X.ERV.COL_EXP_GRP',
                            onLabelKey: 'LIB4X.ERV.COL_GRP',
                            offLabelKey: 'LIB4X.ERV.EXP_GRP',
                            //onIcon: 'icon-ig-collapse-row',
                            //offIcon: 'icon-ig-expand-row',
                            onIcon: 'fa fa-compress',
                            offIcon: 'fa fa-expand',
                            expanded: true,
                            set: function(expanded)
                            {
                                this.expanded = expanded;
                                $('#'+ rvStaticIdRv + ' .' + C_COLLAPSIBLE).collapsible(expanded ? 'expand' : 'collapse');
                            },
                            get: function()
                            {
                                return this.expanded;
                            }
                        }                     
                        ]); 
                    }  
                }
                // apply any FIELD_COLUMNS_SPAN config
                if (options.columnsLayout == 'FIELD_COLUMNS_SPAN')
                {
                    for (const [property, field] of Object.entries(fields).filter(([key, val])=>(val.elementId)))
                    {
                        field.fieldColSpan = options.fcs_spanWidth;
                    }
                }
                // compose options for recordView
                let gridOptions = apex.region(igStaticId).call('getViews').grid.view$.grid('option');
                let recordViewOptions = {
                    actionsContext: actionsContext,
                    modelName: apex.region(igStaticId).call('getViews').grid.model.name,
                    fields: [fields],
                    editable: gridOptions.editable,
                    fieldGroups: gridOptions.columnGroups,
                    toolbar: toolbar,
                    autoAddRecord: gridOptions.autoAddRecord,
                    hasSize: options.hasSize,
                    noDataIcon: gridOptions.noDataIcon,
                    noDataMessage: gridOptions.noDataMessage,
                    progressOptions: {
                        fixed: false  // by this setting, a fetch/save progress spinner will be in the center of the recordView and not fixed to the page
                    },
                    regionStaticId: rvStaticId
                    // labelAlignment: stick to the default ('end')
                    // progressOptions: stick to the default ({ fixed: !options.hasSize })
                    // recordOffset: no need to set
                    // showExcludeHiddenFields: stick to default (true)
                    // showExcludeNullValues: stick to default (true)
                    // showNullAs: stick to default ('-')
                    // skipDeletedRecords: stick to default (false)
                    // formCssClasses
                };
                // programmatially, next options can be set as part of config
                let config = Object.fromEntries(
                    ['alwaysEdit', 'applyTemplateOptions', 'formCssClasses', 'labelAlignment', 'showNullAs', 'skipDeletedRecords', 'suppressValCloseQuestion']
                    .filter(key => key in options.config).map(key => [key, options.config[key]])
                );
                recordViewOptions = {...recordViewOptions, ...config};
                // instantiate recordView
                $("#" + rvStaticIdRv).recordView(recordViewOptions);
                if ($("#" + rvStaticIdRv).is(':visible'))
                {
                    adjustRvBody(rvStaticIdRv);
                }
                // There is a bug in recordView widget in which upon insert, recordView.focus() is
                // executed twice on the first field. From this, if this field is mandatory, 
                // immediatly a validation message is shown under the field. It only happens
                // when the widget is not in edit mode yet. Also, the issue won't happen when
                // the first control is a collapsible button as it puts (incorrectly) the focus
                // on that button.
                // So below we correct this by reverting the validity to 'valid'.
                let insertAction = actionsContext.lookup('insert-record');
                if (insertAction)
                {
                    let origAction = insertAction.action;
                    insertAction.action = function(){
                        let inEditMode = $("#" + rvStaticIdRv).recordView('inEditMode');
                        origAction();
                        if (!inEditMode)
                        {
                            let model = $("#" + rvStaticIdRv).recordView('getModel');
                            let record = $("#" + rvStaticIdRv).recordView('getRecord');
                            modelsModule.util.setRecordFieldsValid(model, record);
                        }
                    }
                }
                $("#" + rvStaticIdRv).on( "recordviewrecordchange", function( event, data ) {
                    if (data.recordId)
                    {
                        // upon record change, also change the selected record in the IG
                        // if needed, change the page in the IG
                        let model = apex.region(igStaticId).call('getViews').grid.model;
                        let record = model.getRecord(data.recordId);  
                        if  ((!apex.region(igStaticId).call('getViews').grid.view$.grid('option').pagination.scroll) &&
                            apex.region(igStaticId).call('getViews').grid.model.getOption('hasTotalRecords'))
                        {
                            let recordIndex = model.indexOf(record);
                            let pageInfo = apex.region(igStaticId).call('getViews').grid.view$.grid('getPageInfo');
                            if ((recordIndex + 1) < pageInfo.firstOffset)
                            {
                                if (pageInfo.currentPage > 0)
                                {
                                    apex.region(igStaticId).call('getViews').grid.view$.grid('gotoPage', pageInfo.currentPage - 1);
                                }
                            }
                            else if ((recordIndex + 1) > pageInfo.lastOffset)
                            {
                                if ((pageInfo.currentPage + 1) < pageInfo.totalPages)
                                {
                                    apex.region(igStaticId).call('getViews').grid.view$.grid('gotoPage', pageInfo.currentPage + 1);
                                }
                            }
                        }
                        let selectedRecords = apex.region(igStaticId).call('getSelectedRecords');
                        let recordSelected = ((selectedRecords?.length == 1) && (selectedRecords[0] == record));
                        if (!recordSelected)
                        {
                            apex.region(igStaticId).call('setSelectedRecords', [record], false, true);
                        }                            
                    }
                });     
                // similar to IG, have a row initialization event
                // the recordView fires apexbeginrecordedit/apexendrecordedit events
                $("#" + rvStaticIdRv).on( "apexbeginrecordedit", function( event, data ) {
                    if (data)
                    {
                        data.rowData = util.recordView.getRecordData(rvStaticIdRv);
                    }
                    apex.event.trigger($('#' + rvStaticIdRv), 'lib4x_erv_row_initialization', data);
                });
                if ($('#' + rvStaticId).is(':ui-dialog'))
                {
                    // for an erv in a dialog/drawer, if the dialog is closed by the user but there are
                    // validation errors, give question on whether to proceed
                    // can be suppressed by config option
                    $('#' + rvStaticId).on('dialogbeforeclose', function(event) {
                        let dlg$ = $(this);
                        if(dlg$.data('can-close')) {
                            dlg$.removeData('can-close');
                            $("#" + rvStaticIdRv).recordView('setEditMode', false);
                            return true;
                        }
                        apex.event.trigger($("#" + rvStaticIdRv), 'lib4x_rv_do_validate_row');
                        let model = $("#" + rvStaticIdRv).recordView('getModel');
                        let record = $("#" + rvStaticIdRv).recordView('getRecord');
                        let recordId = model.getRecordId(record);
                        let recordIsValid = modelsModule.util.recordIsValid(model, recordId); 
                        if (!recordIsValid && !options.config.suppressValCloseQuestion)
                        {                           
                            let apexOverlay$ = $('<div class="' + C_APEX_WAIT_OVERLAY + '"></div>').prependTo($('.' + C_LIB4X_IG_ERV));
                            apex.message.confirm(getMessage('Q_VAL_ERR_CLOSE_DIALOG'), function(okPressed) {
                                apexOverlay$.remove();
                                if (okPressed) {
                                    dlg$.data('can-close', true);
                                    dlg$.dialog('close');
                                }
                            },{
                                title: 'Validation', 
                                style: 'information'
                            });          
                            return false;
                        }
                        // switch off edit mode so apexendrecordedit will be fired
                        // should be done here in before close as in close event,
                        // the rowItems are not visible anymore, and APEX will then
                        // in recordView.setEditMode(true) set validity of item to
                        // valid only
                        $("#" + rvStaticIdRv).recordView('setEditMode', false);
                    });
                }  
                if (!$('#' + rvStaticId).is(':ui-dialog'))
                {
                    // next situation is applicable when erv is not a dialog
                    // upon save, any server-side validations which result in a field error,
                    // because of a bug it looks like in APEX, the error is not shown
                    // on the field (only on page level as a notification)
                    // the error is there though on the field metadata in the model
                    // to work arround, we refresh the RV after save
                    $("#" + igStaticId).on("interactivegridsave", function( event, data ) {
                        let model = $("#" + rvStaticIdRv).recordView('getModel');
                        let record = $("#" + rvStaticIdRv).recordView('getRecord');
                        let recordId = model.getRecordId(record);
                        if (!modelsModule.util.recordIsValid(model, recordId))
                        {
                            $("#" + rvStaticIdRv).recordView('refresh');
                        }
                    });
                } 
            }

            // init the ERV upon interactivegridviewchange
            $('#' + igStaticId).on("interactivegridviewchange", function(jQueryEvent, data) { 
                if (data && data.created && data.view == 'grid')
                {  
                    // IG columns won't be there if the IG is not visible
                    if (apex.region(igStaticId).call('getViews').grid.view$.grid('getColumns'))  
                    {    
                        // To be sure, check if the ERV is not there yet
                        if (!$('#' + rvStaticIdRv).recordView('instance'))
                        {    
                            doInitRv(rvStaticId, rvStaticIdRv, igStaticId);
                            // no gotoIGSelectedRecord required as IG selection event will trigger that
                        }
                    } 
                } 
            });     
            // when the IG plus ERV is initially not visible (eg in a tab or collapsible region)
            // init the ERV upon becoming visible  
            // also, the instance might exist already, but a refresh is pending to be done
            // when an ERV is not visible, the record is not kept sync with the IG
            // so when the ERV becomes visible, we execute a gotoIGSelectedRecord   
            apex.widget.util.onVisibilityChange($('#' + rvStaticIdRv), function(visible){
                if (visible)
                {
                    if (!$('#' + rvStaticIdRv).recordView('instance'))
                    {       
                        // use setTimeout as the IG might also just have become visible and is yet
                        // to complete it's columns initialization
                        setTimeout(()=>{
                            if (apex.region(igStaticId).call('getViews').grid.view$.grid('getColumns'))  
                            {     
                                // to be sure, check again the instance for non-existence
                                if (!$('#' + rvStaticIdRv).recordView('instance'))
                                {       
                                    doInitRv(rvStaticId, rvStaticIdRv, igStaticId);
                                    gotoIGSelectedRecord(rvStaticIdRv);
                                }
                            }  
                        }, 10);  
                    } 
                    else if ($("#" + rvStaticIdRv).recordView('instance').pendingRefresh)
                    {
                        $("#" + rvStaticIdRv).recordView('refresh');
                        adjustRvBody(rvStaticIdRv);
                        gotoIGSelectedRecord(rvStaticIdRv);
                    }
                    else
                    {
                        gotoIGSelectedRecord(rvStaticIdRv);
                    }
                }
            });         
        }

        return{
            initRV: initRV,
            gotoIGSelectedRecord: gotoIGSelectedRecord,
            openRowView: openRowView,
            setEditMode: setEditMode,
            openRegion: openRegion,
            hideGroup: hideGroup
        }
    })();        
    
    let modelsModule = (function() {
        let modelUtil = {
            recordFieldsValid: function(recMetadata)
            {
                let valid = true;
                if (recMetadata)
                {
                    let fields = recMetadata.fields;
                    if (fields)
                    {
                        for (const field in fields) 
                        {
                            if (fields[field].error)
                            {
                                valid = false;
                                break;
                            }
                        }
                    }
                }
                return valid;                
            },
            recordIsValid: function(model, recordId)
            {
                let recMetaData = model.getRecordMetadata(recordId);
                return (!recMetaData.error && this.recordFieldsValid(recMetaData));
            },
            setRecordFieldsValid: function(model, record)
            {
                let recordId = model.getRecordId(record);
                let recMetadata = model.getRecordMetadata(recordId);
                if (recMetadata)
                {
                    let fields = recMetadata.fields;
                    if (fields)
                    {
                        for (const field in fields) 
                        {
                            if (fields[field].error)
                            {
                                model.setValidity('valid', recordId, field);
                            }
                        }
                    }
                }                
            }
        };

        return{
            util: modelUtil
        }
    })();      

    // ==util module
    let util = {   
        item:
        {
            getNativeValue: function(apexItem)
            {
                let result = null;
                if (apexItem.item_type == "NUMBER")
                {
                    result = apexItem.getNativeValue();
                    if (isNaN(result))
                    {
                        result = null;
                    }
                }
                else if ((apexItem.item_type == "QE") || (apexItem.item_type == "WE") || (apexItem.item_type == "ZE") || (apexItem.item_type == "DATE_PICKER") || (apexItem.node?.nodeName == 'A-DATE-PICKER'))
                {
                    try
                    {
                        result = apex.date.parse(apexItem.getValue(), this.getDateFormat(apexItem));
                    }
                    catch(e) {};                
                }
                else
                {
                    result = apexItem.getValue();
                }
                return result;
            },            
        },
        recordView:
        {
            // getRecordData: data from RV fields
            getRecordData: function(rvStaticIdRv)
            {
                let widget$ = $('#' + rvStaticIdRv);
                let recordData = null;
                // check if there is a record active by checking the activeRecordId
                let activeRecordId = widget$.recordView('getActiveRecordId');
                if (activeRecordId)
                {
                    recordData = {};
                    let fields = widget$.recordView('getFields');
                    for (field of fields)
                    {
                        if (field.elementId && apex.items.hasOwnProperty(field.elementId))
                        {
                            recordData[field.elementId] = util.item.getNativeValue(apex.item(field.elementId));
                        }
                    }
                }
                return recordData;
            }
        }
    };     
    
    function initMessages()
    {
        // here we have the labels and messages for which the developer should be 
        // able to config translations in APEX
        apex.lang.addMessages({
            'LIB4X.ERV.COL_EXP_GRP': 'Collapse/Expand Groups',
            'LIB4X.ERV.COL_GRP': 'Collapse Groups',
            'LIB4X.ERV.EXP_GRP': 'Expand Groups',
            'LIB4X.ERV.Q_VAL_ERR_CLOSE_DIALOG': 'Data has validation errors. Close Dialog?'
        });        
    }

    function getMessage(key) {
        return apex.lang.getMessage('LIB4X.ERV.' + key);
    }    

    /*
     * Main plugin init function
     */
    let init = function(rvStaticId, igStaticId, columnsLayout, fcs_spanWidth, formLabelWidth, autoHeight, height, initFunc)
    {
        initMessages();
        let rvStaticIdRv = rvStaticId + RV_EXT;
        rv_igStaticId[rvStaticIdRv] = igStaticId;
        // tag the region as being an IG ERV
        $('#'+rvStaticId).addClass(C_LIB4X_IG_ERV);
        if (formLabelWidth)
        {
            $('#'+rvStaticId).addClass(C_LIB4X_FORM_LABEL_WIDTH_PREFIX + formLabelWidth);
        }
        if ($('#'+rvStaticId).hasClass('t-DrawerRegion') && $('#'+rvStaticId).hasClass('t-DialogRegion--noPadding'))
        {
            // bug in 24.1 - when 'drawer' template and 'remove body padding' it adds 't-DialogRegion--noPadding'
            // class but should be 't-DrawerRegion--noPadding' class instead
            $('#'+rvStaticId).removeClass('t-DialogRegion--noPadding').addClass('t-DrawerRegion--noPadding');
        }
        let config = {};        
        if (initFunc)
        {
            // call init function which the developer can use to 
            // programmatically specify the config option which are not available declaratively
            config = initFunc(config);
        }
        let options = {};
        options.config = config;
        options.columnsLayout = columnsLayout ? columnsLayout : 'NONE';
        if (columnsLayout == 'FIELD_COLUMNS_SPAN')
        {
            options.fcs_spanWidth = fcs_spanWidth ? parseInt(fcs_spanWidth) : 6;
        }
        options.hasSize = ((autoHeight != 'Y') && (height));
        rvOptions[rvStaticIdRv] = options;
        // create region interface
        // by apex.region('<static id>').widget().recordView(..), the recordView can be reached
        apex.region.create( rvStaticId, {
            type: "IGExternalRowView",
            parentRegionId: igStaticId,
            widget: function() {
                return $('#' + rvStaticIdRv);
            },
            refresh: function() {
                $('#' + rvStaticIdRv).recordView('getActions').invoke('refresh-record');
            },   
            focus: function() {
                $('#' + rvStaticIdRv).recordView('focus');
            }                 
        });           
        gridModule.initIG(igStaticId, rvStaticId, rvStaticIdRv);
        rowViewModule.initRV(rvStaticId, rvStaticIdRv, igStaticId);
    };

    return{
        _init: init,
        openRowView: rowViewModule.openRowView,
        hideGroup: rowViewModule.hideGroup
    }
})(apex.jQuery);
