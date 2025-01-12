# apex-ig-external-row-view
Replace the IG Single Row View with a Row View in a regular region, dialog or drawer.

See this [blog item](https://karelekema.hashnode.dev/oracle-apex-ig-external-row-view-plugin) for an overview of the functionality.

The region plugin is a wrapper around the recordView widget which gets instantiated with the same model and field configuration as the related IG.

To be able to configure an external row view (ERV) for an IG, you need to disable the IG Single Row View (SRV) feature. In IG init function:

```
function(options) {
    let features = apex.util.getNestedObject(options, 'views.grid.features');
    features.singleRowView = false;
    return options;
}
```
Configuring an ERV region:
<br/><br/>
![](https://github.com/user-attachments/assets/03072dc7-283f-49f4-b300-95be204c9a6a)<br/><br/>
![](https://github.com/user-attachments/assets/e7940f80-7fb2-4171-9249-9ffcad54fd03)
<br/><br/>
For an explanation of the declarative settings, see the inline help.
<br/><br/>
Next options can be set programmatically: 'alwaysEdit', 'applyTemplateOptions', 'formCssClasses', 'labelAlignment', 'showNullAs', 'skipDeletedRecords', 'suppressValCloseQuestion'
<br/><br/>
See the [recordView options](https://docs.oracle.com/en/database/oracle/apex/24.1/aexjs/recordView.html) for an explanation on all except the last option. 
<br/><br/>
The 'suppressValCloseQuestion' option can be used to suppress a default behavior when a dialog or drawer is closed while the row still has validation errors. By default it will ask a question if to proceed. 
<br/>
```
function(config)
{
    config.alwaysEdit = true;
    config.suppressValCloseQuestion = true;
    return config;
}
```
Individual fields can be further programmatically configured as per the [field properties](https://docs.oracle.com/en/database/oracle/apex/24.1/aexjs/recordView.html#fields). For this, you can utilize the IG column JavaScript init func. For example when you want to configure your own layout using field column spans: 
```
function(options) {
    options.defaultGridColumnOptions = {
        fieldColSpan: 2
    };
    return options;
}
```
Next classes can be used to reduce a field item width. Configure the class on the IG column, Advanced CSS classes.<br/>
* lib4x-form-field-width-25p
* lib4x-form-field-width-50p
* lib4x-form-field-width-75p

The 'lib4x-ig-erv-hidden' class can be used to hide a field. Have the class on the IG column, Appearance CSS classes.<br/>
This class can also be used on 'Link Attributes' in case you have a link column in the IG grid, but you don't want to show the link in the ERV.
<br/><br/>
In case you want to include a link column in the IG grid as to open the ERV (dialog or drawer) from there, you can use the 'lib4x-erv-open' action. Link config:
<br/><br/>
![image](https://github.com/user-attachments/assets/2c6a493f-d4ff-4999-b62b-7677211e1205)
<br/><br/>
`#action$lib4x-erv-open`
`<span class="fa fa-edit"/>`
`lib4x-ig-erv-hidden`
<br/><br/>
Next messages are available for translation:<br/>
* 'LIB4X.ERV.COL_EXP_GRP': 'Collapse/Expand Groups',
* 'LIB4X.ERV.COL_GRP': 'Collapse Groups',
* 'LIB4X.ERV.EXP_GRP': 'Expand Groups',
* 'LIB4X.ERV.Q_VAL_ERR_CLOSE_DIALOG': 'Data has validation errors. Close Dialog?'
  
The recordView widget can be reached via: <br/>
`apex.region('<ERV Static Id>').widget().recordView('<method>')` <br/>


            




