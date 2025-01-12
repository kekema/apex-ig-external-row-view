procedure render (
    p_plugin in            apex_plugin.t_plugin,
    p_region in            apex_plugin.t_region,
    p_param  in            apex_plugin.t_region_render_param,
    p_result in out nocopy apex_plugin.t_region_render_result )
is 
    l_region_id             varchar2(50);  
    l_ig_static_id          varchar2(50);
    l_columns_layout        varchar2(20);
    l_span_width            varchar2(20);
    l_form_label_width      varchar2(20);
    l_auto_height           varchar2(10);
    l_height                varchar2(10);
    l_style                 varchar2(100);
begin
    if apex_application.g_debug then
        apex_plugin_util.debug_region(p_plugin => p_plugin, p_region => p_region);
    end if;
    l_region_id := apex_escape.html_attribute(p_region.static_id);
    l_ig_static_id := apex_escape.html(p_region.attributes.get_varchar2('attr_ig_static_id'));
    l_columns_layout := p_region.attributes.get_varchar2('attr_columns_layout');
    l_span_width := p_region.attributes.get_varchar2('attr_span_width');
    l_form_label_width := p_region.attributes.get_varchar2('attr_form_label_width');
    l_auto_height := p_region.attributes.get_varchar2('attr_auto_height');
    l_height := p_region.attributes.get_varchar2('attr_height');
    l_style := '';
    if (l_auto_height != 'Y') then
        l_style := 'style="height:' || l_height || 'px"';
    end if;

    sys.htp.p('<div id="' || l_region_id || '_rv"' || l_style || '></div>');
 
    -- When specifying the library declaratively, it fails to load the minified version. So using the API:
    apex_javascript.add_library(
          p_name      => 'ig-externalrowview',
          p_check_to_add_minified => true,
          --p_directory => '#WORKSPACE_FILES#javascript/',          
          p_directory => p_plugin.file_prefix || 'js/',
          p_version   => NULL
    );  

    apex_css.add_file (
        p_name => 'ig-externalrowview',
        --p_directory => '#WORKSPACE_FILES#css/'
        p_directory => p_plugin.file_prefix || 'css/' 
    );    

    apex_javascript.add_inline_code(
        p_code => apex_string.format(
            'lib4x.axt.ig.externalRowView._init("%s", "%s", "%s", "%s", "%s", "%s", "%s", '
            , l_region_id
            , l_ig_static_id  
            , l_columns_layout
            , l_span_width
            , l_form_label_width
            , l_auto_height
            , l_height
        ) || p_region.init_javascript_code || ');'
    );    
end;
