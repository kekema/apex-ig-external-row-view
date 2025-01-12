# apex-ig-external-row-view
Replace the IG Single Row View with a Row View in a regular region, dialog or drawer.

See this blog item for an overview of the functionality.

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

<img src="https://github.com/user-attachments/assets/03072dc7-283f-49f4-b300-95be204c9a6a" width=30% height=30%/>
<img src="https://github.com/user-attachments/assets/e7940f80-7fb2-4171-9249-9ffcad54fd03" width=30% height=30%/>
<br/><br/>
For an explanation of the declarative settings, see the inline help.
<br/><br/>
Next options can be set programmatically: 'alwaysEdit', 'applyTemplateOptions', 'formCssClasses', 'labelAlignment', 'showNullAs', 'skipDeletedRecords', 'suppressValCloseQuestion'
<br/><br/>
See the [recordView options](https://docs.oracle.com/en/database/oracle/apex/24.1/aexjs/recordView.html) for an explanation on all except the last option. 
<br/><br/>
The 'suppressValCloseQuestion' option can be used to suppress a default behavior when a dialog or drawer is closed while the row still has validation errors. By default it will ask a question if to proceed. 
<br/><br/>




