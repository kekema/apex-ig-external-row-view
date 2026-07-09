prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.1'
,p_default_workspace_id=>8205260902819239028
,p_default_application_id=>66677
,p_default_id_offset=>0
,p_default_owner=>'LUFCMATTYLAD'
);
end;
/
 
prompt APPLICATION 66677 - ERV
--
-- Application Export:
--   Application:     66677
--   Name:            ERV
--   Date and Time:   09:42 Thursday July 9, 2026
--   Exported By:     LUFC
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 16569484616163898440
--   Manifest End
--   Version:         26.1.1
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/lib4x_axt_ig_externalrowview
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(16569484616163898440)
,p_plugin_type=>'REGION TYPE'
,p_name=>'LIB4X.AXT.IG.EXTERNALROWVIEW'
,p_display_name=>'LIB4X - IG External Row View'
,p_apexlang_name=>'lib4xIgExternalRowView'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function get_attr_as_boolean(',
'    p_region in apex_plugin.t_region,',
'    p_attribute in varchar2',
')',
'return boolean',
'is',
'    l_attribute varchar2(10);',
'begin',
'    l_attribute := p_region.attributes.get_varchar2(p_attribute);',
'    return (l_attribute is not null and l_attribute = ''Y'');',
'end;',
'',
'procedure render (',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_region in            apex_plugin.t_region,',
'    p_param  in            apex_plugin.t_region_render_param,',
'    p_result in out nocopy apex_plugin.t_region_render_result )',
'is ',
'    l_region_id             varchar2(50);  ',
'    l_ig_static_id          varchar2(50);',
'    l_columns_layout        varchar2(20);',
'    l_span_width            varchar2(20);',
'    l_form_label_width      varchar2(20);',
'    l_auto_height           varchar2(10);',
'    l_height                varchar2(10);',
'    l_style                 varchar2(100);',
'    l_toolbar_conf          varchar2(400);',
'    l_show_toolbar          boolean;',
'    l_row_action_buttons    boolean;',
'    l_navigation_buttons    boolean;',
'begin',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_region(p_plugin => p_plugin, p_region => p_region);',
'    end if;',
'    l_region_id := apex_escape.html_attribute(p_region.static_id);',
'    l_ig_static_id := apex_escape.html(p_region.attributes.get_varchar2(''attr_ig_static_id''));',
'    l_columns_layout := p_region.attributes.get_varchar2(''attr_columns_layout'');',
'    l_span_width := p_region.attributes.get_varchar2(''attr_span_width'');',
'    l_form_label_width := p_region.attributes.get_varchar2(''attr_form_label_width'');',
'    l_auto_height := p_region.attributes.get_varchar2(''attr_auto_height'');',
'    l_height := p_region.attributes.get_varchar2(''attr_height'');',
'    l_style := '''';',
'    if (l_auto_height != ''Y'') then',
'        l_style := ''style="height:'' || l_height || ''px"'';',
'    end if;',
'',
'    l_show_toolbar := get_attr_as_boolean(p_region, ''attr_show_toolbar'');  ',
'    l_toolbar_conf := ''{'' || apex_javascript.add_attribute(''show'', l_show_toolbar, false, l_show_toolbar);  ',
'    if (l_show_toolbar) then',
'        l_row_action_buttons := get_attr_as_boolean(p_region, ''attr_row_action_buttons'');',
'        l_toolbar_conf := l_toolbar_conf || apex_javascript.add_attribute(''rowActionButtons'', l_row_action_buttons);',
'        if (l_row_action_buttons) then',
'            l_toolbar_conf := l_toolbar_conf || apex_javascript.add_attribute(''rowActionButtonsSelection'', p_region.attributes.get_varchar2(''attr_row_action_buttons_select''), false);',
'        end if;',
'        l_toolbar_conf := l_toolbar_conf || apex_javascript.add_attribute(''navigationButtons'', get_attr_as_boolean(p_region, ''attr_navigation_buttons''), false, false);',
'    end if;',
'    l_toolbar_conf := l_toolbar_conf || ''}'';    ',
'',
'    sys.htp.p(''<div id="'' || l_region_id || ''_rv"'' || l_style || ''></div>'');',
' ',
'    -- When specifying the library declaratively, it fails to load the minified version. So using the API:',
'    apex_javascript.add_library(',
'          p_name      => ''ig-externalrowview'',',
'          p_check_to_add_minified => true,',
'          --p_directory => ''#WORKSPACE_FILES#javascript/'',          ',
'          p_directory => p_plugin.file_prefix || ''js/'',',
'          p_version   => NULL',
'    );  ',
'',
'    apex_css.add_file (',
'        p_name => ''ig-externalrowview'',',
'        --p_directory => ''#WORKSPACE_FILES#css/''',
'        p_directory => p_plugin.file_prefix || ''css/'' ',
'    );    ',
'',
'    apex_javascript.add_onload_code(',
'        p_code => apex_string.format(',
'            ''lib4x.axt.ig.externalRowView._init("%s", "%s", "%s", "%s", "%s", "%s", "%s", ''',
'            , l_region_id',
'            , l_ig_static_id  ',
'            , l_columns_layout',
'            , l_span_width',
'            , l_form_label_width',
'            , l_auto_height',
'            , l_height',
'        ) || l_toolbar_conf || '', '' || p_region.init_javascript_code || '');''',
'    );    ',
'end;'))
,p_api_version=>3
,p_render_function=>'render'
,p_standard_attributes=>'INIT_JAVASCRIPT_CODE'
,p_version_scn=>'SH256:mry1RqcUmYxQXN71OxhuURBMNTVEIjeEEr4ghfFrNEo'
,p_help_text=>'Replace the IG Single Row View with a Row View in a regular region, dialog or drawer.'
,p_version_identifier=>'26.1.1'
,p_about_url=>'https://github.com/kekema/apex-ig-external-row-view'
,p_files_version=>2461231094151
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(16576834825409183826)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_title=>'Toolbar'
,p_apexlang_name=>'toolbar'
,p_static_id=>'toolbar'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16570752999324637526)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'attr_auto_height'
,p_prompt=>'Auto Height'
,p_apexlang_name=>'autoHeight'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'With auto height checked, the height of the region is determined by the number of fields. In case of unchecked, you can specify a fixed height, and a scrollbar will appear if needed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16570671250458108260)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'attr_columns_layout'
,p_prompt=>'Columns Layout'
,p_apexlang_name=>'columnsLayout'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_show_in_wizard=>false
,p_default_value=>'NONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Enables to distribute the fields to a number of columns.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570672550962116774)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570671250458108260)
,p_display_sequence=>20
,p_display_value=>'Field Columns Span'
,p_return_value=>'FIELD_COLUMNS_SPAN'
,p_apexlang_name=>'fieldColumnsSpan'
,p_help_text=>'Achieve a columns layout by specifying a span width which will be applied to each field. The fields are put side by side as per this width. So the distribution of fields is horizontally.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570672909536118431)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570671250458108260)
,p_display_sequence=>30
,p_display_value=>'Field Group Columns'
,p_return_value=>'FIELD_GROUP_COLUMNS'
,p_apexlang_name=>'fieldGroupColumns'
,p_help_text=>'Achieve a columns layout by utilizing Field Groups which can be defined as Column Groups in the IG. Each group will be a column in which the related fields are distributed vertically.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570672122110112820)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570671250458108260)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'NONE'
,p_apexlang_name=>'none'
,p_help_text=>'No columns layout.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16570732146975768749)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'attr_form_label_width'
,p_prompt=>'Form Label Width'
,p_apexlang_name=>'formLabelWidth'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Gives a number of options, both in percentage as well as in pixels, for the width of the label part of all fields.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570735024254774735)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>60
,p_display_value=>'100px'
,p_return_value=>'100'
,p_apexlang_name=>'100px'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570735414662775360)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>70
,p_display_value=>'150px'
,p_return_value=>'150'
,p_apexlang_name=>'150px'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570733077327769432)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>10
,p_display_value=>'20%'
,p_return_value=>'20p'
,p_apexlang_name=>'20'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570735890350776279)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>80
,p_display_value=>'200px'
,p_return_value=>'200'
,p_apexlang_name=>'200px'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570733455413770085)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>20
,p_display_value=>'25%'
,p_return_value=>'25p'
,p_apexlang_name=>'25'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570740416207891292)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>90
,p_display_value=>'250px'
,p_return_value=>'250'
,p_apexlang_name=>'250px'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570733897322770648)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>30
,p_display_value=>'30%'
,p_return_value=>'30p'
,p_apexlang_name=>'30'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570734255220771181)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>40
,p_display_value=>'35%'
,p_return_value=>'35p'
,p_apexlang_name=>'35'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570734642998771877)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570732146975768749)
,p_display_sequence=>50
,p_display_value=>'40%'
,p_return_value=>'40p'
,p_apexlang_name=>'40'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16570753819502645463)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'attr_height'
,p_prompt=>'Height (pixels)'
,p_apexlang_name=>'heightPixels'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(16570752999324637526)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Fixed height of the region in pixels.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16569485211605170502)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'attr_ig_static_id'
,p_prompt=>'IG Static Id'
,p_apexlang_name=>'igStaticId'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Static Id of the IG for which you are defining the external row view.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16576874055715364252)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'attr_navigation_buttons'
,p_prompt=>'Navigation Buttons'
,p_apexlang_name=>'navigationButtons'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(16576837541454200363)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(16576834825409183826)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16576839361491204098)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'attr_row_action_buttons'
,p_prompt=>'Row Action Buttons'
,p_apexlang_name=>'rowActionButtons'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(16576837541454200363)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(16576834825409183826)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16576868408770334184)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'attr_row_action_buttons_select'
,p_prompt=>'Actions'
,p_apexlang_name=>'actions'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'ADD_ROW:DUPLICATE_ROW:DELETE_ROW:REFRESH_ROW:REVERT_ROW'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(16576839361491204098)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(16576834825409183826)
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16576870263452335404)
,p_plugin_attribute_id=>wwv_flow_imp.id(16576868408770334184)
,p_display_sequence=>10
,p_display_value=>'Add Row'
,p_return_value=>'ADD_ROW'
,p_apexlang_name=>'addRow'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16576871074607339670)
,p_plugin_attribute_id=>wwv_flow_imp.id(16576868408770334184)
,p_display_sequence=>30
,p_display_value=>'Delete Row'
,p_return_value=>'DELETE_ROW'
,p_apexlang_name=>'deleteRow'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16576870613125336860)
,p_plugin_attribute_id=>wwv_flow_imp.id(16576868408770334184)
,p_display_sequence=>20
,p_display_value=>'Duplicate Row'
,p_return_value=>'DUPLICATE_ROW'
,p_apexlang_name=>'duplicateRow'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16576871427416341231)
,p_plugin_attribute_id=>wwv_flow_imp.id(16576868408770334184)
,p_display_sequence=>40
,p_display_value=>'Refresh Row'
,p_return_value=>'REFRESH_ROW'
,p_apexlang_name=>'refreshRow'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16576871900621342206)
,p_plugin_attribute_id=>wwv_flow_imp.id(16576868408770334184)
,p_display_sequence=>50
,p_display_value=>'Revert Row'
,p_return_value=>'REVERT_ROW'
,p_apexlang_name=>'revertRow'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16576837541454200363)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'attr_show_toolbar'
,p_prompt=>'Show'
,p_apexlang_name=>'show'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(16576834825409183826)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(16570767482041143546)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>30
,p_static_id=>'attr_span_width'
,p_prompt=>'Span Width'
,p_apexlang_name=>'spanWidth'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_show_in_wizard=>false
,p_default_value=>'6'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(16570671250458108260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'FIELD_COLUMNS_SPAN'
,p_lov_type=>'STATIC'
,p_help_text=>'The span width effectively determines the number of columns. Normally, the span width of a field is 12. By specifying a width of 6, 4 or 3, the number of resulting columns will be 2, 3 or 4.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570768305572145667)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570767482041143546)
,p_display_sequence=>10
,p_display_value=>'3'
,p_return_value=>'3'
,p_apexlang_name=>'3'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570768797910146031)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570767482041143546)
,p_display_sequence=>20
,p_display_value=>'4'
,p_return_value=>'4'
,p_apexlang_name=>'4'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(16570769163004146424)
,p_plugin_attribute_id=>wwv_flow_imp.id(16570767482041143546)
,p_display_sequence=>30
,p_display_value=>'6'
,p_return_value=>'6'
,p_apexlang_name=>'6'
);
wwv_flow_imp_shared.create_plugin_std_attribute(
 p_id=>wwv_flow_imp.id(16570714277755684837)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_name=>'INIT_JAVASCRIPT_CODE'
,p_is_required=>false
);
wwv_flow_imp_shared.create_plugin_event(
 p_id=>wwv_flow_imp.id(16570966965559812707)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_name=>'lib4x_erv_row_initialization'
,p_display_name=>'Row Initialization'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6C696234782D69672D657276202E612D52562D626F6479207B0D0A202020202D2D612D72762D626F64792D70616464696E672D783A20302E3572656D3B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E612D5256207B0D0A202020202D2D612D';
wwv_flow_imp.g_varchar2_table(2) := '746F6F6C6261722D6974656D2D73706163696E673A20302E3372656D3B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D323570290D';
wwv_flow_imp.g_varchar2_table(3) := '0A7B0D0A2020202077696474683A203235253B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D353070290D0A7B0D0A202020207769';
wwv_flow_imp.g_varchar2_table(4) := '6474683A203530253B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D373570290D0A7B0D0A2020202077696474683A203735253B0D';
wwv_flow_imp.g_varchar2_table(5) := '0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323070207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203230253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C616265';
wwv_flow_imp.g_varchar2_table(6) := '6C2D77696474682D323570207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203235253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D333070207B0D0A202020202D2D61';
wwv_flow_imp.g_varchar2_table(7) := '2D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203330253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D333570207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D';
wwv_flow_imp.g_varchar2_table(8) := '77696474683A203335253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D343070207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203430253B0D0A7D0D0A0D0A2E6C6962';
wwv_flow_imp.g_varchar2_table(9) := '34782D666F726D2D6C6162656C2D77696474682D313030207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031303070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D';
wwv_flow_imp.g_varchar2_table(10) := '313530207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031353070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323030207B0D0A202020202D2D612D666F726D2D';
wwv_flow_imp.g_varchar2_table(11) := '6C6162656C2D636F6E7461696E65722D77696474683A2032303070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323530207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474';
wwv_flow_imp.g_varchar2_table(12) := '683A2032353070783B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E752D466F726D2D67726F757048656164696E6720627574746F6E207B0D0A2020202077696474683A20313030253B0D0A20202020746578742D616C69676E3A207374617274';
wwv_flow_imp.g_varchar2_table(13) := '3B0D0A20202020626F726465723A20303B0D0A20202020666F6E742D73697A653A202E3635656D3B0D0A2020202070616464696E673A203470783B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E752D466F726D2D67726F757048656164696E67';
wwv_flow_imp.g_varchar2_table(14) := '202E612D49636F6E207B0D0A20202020766572746963616C2D616C69676E3A20746578742D626F74746F6D3B0D0A7D0D0A0D0A2E6C696234782D69672D6572762068332E752D466F726D2D67726F757048656164696E67207B0D0A202020206D61726769';
wwv_flow_imp.g_varchar2_table(15) := '6E2D626C6F636B2D73746172743A20302E35656D3B0D0A202020206D617267696E2D626C6F636B2D656E643A20302E34656D3B0D0A7D0D0A0D0A2E6C696234782D69672D657276202E612D52562D626F64792E752D666C6578202E612D416C657274207B';
wwv_flow_imp.g_varchar2_table(16) := '0D0A202020206D61782D77696474683A203230253B0D0A7D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(16571184887557557307)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_file_name=>'css/ig-externalrowview.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6C696234782D69672D657276202E612D52562D626F64797B2D2D612D72762D626F64792D70616464696E672D783A302E3572656D7D2E6C696234782D69672D657276202E612D52567B2D2D612D746F6F6C6261722D6974656D2D73706163696E673A30';
wwv_flow_imp.g_varchar2_table(2) := '2E3372656D7D2E6C696234782D69672D657276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D323570297B77696474683A3235257D2E6C696234782D69672D657276202E612D47562D';
wwv_flow_imp.g_varchar2_table(3) := '636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D353070297B77696474683A3530257D2E6C696234782D69672D657276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D';
wwv_flow_imp.g_varchar2_table(4) := '2D6669656C642D77696474682D373570297B77696474683A3735257D2E6C696234782D666F726D2D6C6162656C2D77696474682D3230707B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A3230257D2E6C696234782D666F';
wwv_flow_imp.g_varchar2_table(5) := '726D2D6C6162656C2D77696474682D3235707B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A3235257D2E6C696234782D666F726D2D6C6162656C2D77696474682D3330707B2D2D612D666F726D2D6C6162656C2D636F6E';
wwv_flow_imp.g_varchar2_table(6) := '7461696E65722D77696474683A3330257D2E6C696234782D666F726D2D6C6162656C2D77696474682D3335707B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A3335257D2E6C696234782D666F726D2D6C6162656C2D7769';
wwv_flow_imp.g_varchar2_table(7) := '6474682D3430707B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A3430257D2E6C696234782D666F726D2D6C6162656C2D77696474682D3130307B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474';
wwv_flow_imp.g_varchar2_table(8) := '683A31303070787D2E6C696234782D666F726D2D6C6162656C2D77696474682D3135307B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A31353070787D2E6C696234782D666F726D2D6C6162656C2D77696474682D323030';
wwv_flow_imp.g_varchar2_table(9) := '7B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A32303070787D2E6C696234782D666F726D2D6C6162656C2D77696474682D3235307B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A323530';
wwv_flow_imp.g_varchar2_table(10) := '70787D2E6C696234782D69672D657276202E752D466F726D2D67726F757048656164696E6720627574746F6E7B77696474683A313030253B746578742D616C69676E3A73746172743B626F726465723A303B666F6E742D73697A653A2E3635656D3B7061';
wwv_flow_imp.g_varchar2_table(11) := '6464696E673A3470787D2E6C696234782D69672D657276202E752D466F726D2D67726F757048656164696E67202E612D49636F6E7B766572746963616C2D616C69676E3A746578742D626F74746F6D7D2E6C696234782D69672D6572762068332E752D46';
wwv_flow_imp.g_varchar2_table(12) := '6F726D2D67726F757048656164696E677B6D617267696E2D626C6F636B2D73746172743A2E35656D3B6D617267696E2D626C6F636B2D656E643A2E34656D7D2E6C696234782D69672D657276202E612D52562D626F64792E752D666C6578202E612D416C';
wwv_flow_imp.g_varchar2_table(13) := '6572747B6D61782D77696474683A3230257D';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(16571186379708558663)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_file_name=>'css/ig-externalrowview.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E6C69623478203D2077696E646F772E6C69623478207C7C207B7D3B0D0A77696E646F772E6C696234782E617874203D2077696E646F772E6C696234782E617874207C7C207B7D3B0D0A77696E646F772E6C696234782E6178742E696720';
wwv_flow_imp.g_varchar2_table(2) := '3D2077696E646F772E6C696234782E6178742E6967207C7C207B7D3B0D0A0D0A2F2A0D0A202A20526567696F6E20506C7567696E2C20656E61626C696E6720746F207265706C616365207468652049472053696E676C6520526F77205669657720776974';
wwv_flow_imp.g_varchar2_table(3) := '68206120526F77205669657720696E206120726567756C617220726567696F6E2C206469616C6F67206F72206472617765722E0D0A202A204974206973206261736963616C6C79206120777261707065722061726F756E6420746865207265636F726456';
wwv_flow_imp.g_varchar2_table(4) := '696577207769646765742E205468697320776964676574206765747320696E7374616E7469617465642077697468207468652073616D65200D0A202A206D6F64656C20616E642073616D65206669656C6420636F6E66696775726174696F6E2061732074';
wwv_flow_imp.g_varchar2_table(5) := '6865204947206D6F64656C20616E6420636F6C756D6E7320636F6E66696775726174696F6E2E0D0A202A2F0D0A6C696234782E6178742E69672E65787465726E616C526F7756696577203D202866756E6374696F6E282429207B0D0A202020200D0A2020';
wwv_flow_imp.g_varchar2_table(6) := '2020636F6E737420435F5256203D2027612D5256273B0D0A20202020636F6E737420435F52565F424F4459203D2027612D52562D626F6479273B0D0A20202020636F6E737420435F434F4C4C41505349424C45203D2027612D436F6C6C61707369626C65';
wwv_flow_imp.g_varchar2_table(7) := '273B0D0A20202020636F6E737420435F434F4C4C41505349424C455F434F4E54454E54203D2027612D436F6C6C61707369626C652D636F6E74656E74273B0D0A20202020636F6E737420435F464C4558203D2027752D666C6578273B0D0A20202020636F';
wwv_flow_imp.g_varchar2_table(8) := '6E737420435F464C45585F47524F575F31203D2027752D666C65782D67726F772D31273B0D0A20202020636F6E737420435F464F524D203D2027752D466F726D273B0D0A20202020636F6E737420435F464F524D5F47524F55505F48454144494E47203D';
wwv_flow_imp.g_varchar2_table(9) := '2027752D466F726D2D67726F757048656164696E67273B0D0A20202020636F6E737420435F415045585F574149545F4F5645524C4159203D2027617065785F776169745F6F7665726C6179273B0D0A20202020636F6E737420435F4C494234585F49475F';
wwv_flow_imp.g_varchar2_table(10) := '455256203D20276C696234782D69672D657276273B0D0A20202020636F6E737420435F4C494234585F464F524D5F4C4142454C5F57494454485F505245464958203D20276C696234782D666F726D2D6C6162656C2D77696474682D273B0D0A2020202063';
wwv_flow_imp.g_varchar2_table(11) := '6F6E737420435F4C494234585F49475F4552565F48494444454E203D20276C696234782D69672D6572762D68696464656E273B0D0A20202020636F6E73742052565F455854203D20275F7276273B0D0A202020206C65742072764F7074696F6E73203D20';
wwv_flow_imp.g_varchar2_table(12) := '7B7D3B2020202020202020202F2F20706C7567696E206F7074696F6E7320616E6420636F6E6669670D0A202020206C65742072765F69675374617469634964203D207B7D3B20202020202F2F206D61707320746865207276207769646765742069642074';
wwv_flow_imp.g_varchar2_table(13) := '6F20746865204947207374617469632049640D0A202020206C65742069675F72765374617469634964203D207B7D3B20202020202F2F2068617320616E20656E74727920666F722065766572792049472077686963682068617320612072656C61746564';
wwv_flow_imp.g_varchar2_table(14) := '206572760D0A0D0A202020202F2A200D0A20202020202A20416E204947207769746820616E2065787420726F772076696577202845525629206973206D61646520726561646F6E6C792E2055706F6E2064626C20636C69636B2C20746865206578742072';
wwv_flow_imp.g_varchar2_table(15) := '6F7720766965772077696C6C2062652070757420696E2065646974206D6F64652028616E64200D0A20202020202A20696E2063617365207468652045525620697320636F6E66696775726564206173206120496E6C696E65204472617765722F4469616C';
wwv_flow_imp.g_varchar2_table(16) := '6F672C20746865206469616C6F672077696C6C206265206F70656E6564292E0D0A20202020202A2054686520494720726F77206D656E7520697320616C736F20657874656E646564207769746820616E2065646974206974656D20617320616E20616C74';
wwv_flow_imp.g_varchar2_table(17) := '65726E61746976652077617920746F2073746172742065646974696E6720696E20746865204552562E0D0A20202020202A20416E2065787420726F77207669657720616E6420612073696E676C6520726F7720766965772028535256292063616E206E6F';
wwv_flow_imp.g_varchar2_table(18) := '742062652075736564206174207468652073616D652074696D652E204F6E207468652049472C2074686520646576656C6F7065722068617320746F200D0A20202020202A2064697361626C65207468652053525620666561747572652E0D0A2020202020';
wwv_flow_imp.g_varchar2_table(19) := '2A2055706F6E2049472073656C656374696F6E206368616E67652C20746865204552562077696C6C2062652074726967676572656420746F206368616E6765207468652063757272656E74207265636F72642061732077656C6C2E0D0A20202020202A2F';
wwv_flow_imp.g_varchar2_table(20) := '0D0A202020206C657420677269644D6F64756C65203D202866756E6374696F6E2829200D0A202020207B0D0A20202020202020202F2F204F7665727772697465204947206772696420736574456469744D6F6465206D6574686F640D0A20202020202020';
wwv_flow_imp.g_varchar2_table(21) := '2066756E6374696F6E20657874656E644772696457696467657428290D0A20202020202020207B0D0A202020202020202020202020242E7769646765742822617065782E67726964222C20242E617065782E677269642C207B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(22) := '20202020202020736574456469744D6F64653A2066756E6374696F6E2028656469744D6F64652C2073656C65637429207B0D0A2020202020202020202020202020202020202020636F6E7374205B617065784D616A6F7256657273696F6E2C2061706578';
wwv_flow_imp.g_varchar2_table(23) := '4D696E6F7256657273696F6E2C2061706578506174636856657273696F6E5D203D20617065782E656E762E415045585F56455253494F4E2E73706C697428222E22292E6D6170284E756D626572293B2020200D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(24) := '202020206C6574206967436F6E666967203D20746869732E656C656D656E742E636C6F7365737428272E612D494727292E696E7465726163746976654772696428276F7074696F6E27292E636F6E6669673B20202020202020202020202020202020200D';
wwv_flow_imp.g_varchar2_table(25) := '0A20202020202020202020202020202020202020206C65742069675374617469634964203D20617065784D616A6F7256657273696F6E203E3D203236203F206967436F6E6669672E726567696F6E446F6D4964203A206967436F6E6669672E726567696F';
wwv_flow_imp.g_varchar2_table(26) := '6E53746174696349643B0D0A20202020202020202020202020202020202020206966202869675F727653746174696349642E6861734F776E50726F7065727479286967537461746963496429290D0A20202020202020202020202020202020202020207B';
wwv_flow_imp.g_varchar2_table(27) := '0D0A202020202020202020202020202020202020202020202020726F77566965774D6F64756C652E736574456469744D6F64652869675F727653746174696349645B696753746174696349645D2C20656469744D6F6465293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(28) := '20202020202020202020202020202072657475726E3B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202072657475726E20746869732E5F737570657228656469744D6F64652C2073656C65';
wwv_flow_imp.g_varchar2_table(29) := '6374293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D293B2020202020202020200D0A20202020202020207D0D0A0D0A202020202020202069662028242E617065782E67726964290D0A20202020202020207B0D';
wwv_flow_imp.g_varchar2_table(30) := '0A2020202020202020202020202F2F206966206C6F6164656420616C72656164792C20657874656E64206E6F772C20656C736520617761697420746865206C6F6164206576656E740D0A202020202020202020202020657874656E644772696457696467';
wwv_flow_imp.g_varchar2_table(31) := '657428293B0D0A20202020202020207D2020200D0A0D0A202020202020202076617220626F6479456C656D203D20646F63756D656E742E676574456C656D656E747342795461674E616D652822626F647922295B305D3B0D0A2020202020202020626F64';
wwv_flow_imp.g_varchar2_table(32) := '79456C656D2E6164644576656E744C697374656E657228226C6F6164222C2066756E6374696F6E286576656E7429207B0D0A202020202020202020202020696620286576656E742E7461726765742E6E6F64654E616D65203D3D3D202253435249505422';
wwv_flow_imp.g_varchar2_table(33) := '290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C65742073726341747472203D206576656E742E7461726765742E676574417474726962757465282273726322293B0D0A202020202020202020202020202020202F';
wwv_flow_imp.g_varchar2_table(34) := '2F2067726964207375627769646765740D0A20202020202020202020202020202020696620287372634174747220262620737263417474722E696E636C7564657328277769646765742E677269642729290D0A202020202020202020202020202020207B';
wwv_flow_imp.g_varchar2_table(35) := '0D0A2020202020202020202020202020202020202020657874656E644772696457696467657428293B0D0A202020202020202020202020202020207D20202020202020202020202020202020200D0A2020202020202020202020207D0D0A202020202020';
wwv_flow_imp.g_varchar2_table(36) := '20207D2C2074727565293B2020202F2F207573656361707475726520697320637269746963616C2068657265202020202020200D0A0D0A2020202020202020617065782E6750616765436F6E74657874242E6F6E2822696E746572616374697665677269';
wwv_flow_imp.g_varchar2_table(37) := '64766965776D6F64656C637265617465222C2066756E6374696F6E286A51756572794576656E742C206461746129207B200D0A2020202020202020202020206C6574206D6F64656C203D20646174612E6D6F64656C3B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(38) := '6D6F64656C2E737562736372696265287B0D0A202020202020202020202020202020206F6E4368616E67653A2066756E6374696F6E286368616E6765547970652C206368616E676529207B0D0A2020202020202020202020202020202020202020696620';
wwv_flow_imp.g_varchar2_table(39) := '286368616E676554797065203D3D20276D6574614368616E676527290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202F2F2042656361757365206F6620616E20415045582062';
wwv_flow_imp.g_varchar2_table(40) := '75672C20696E636F72726563746C7920612076616C69646174696F6E206572726F72206D6573736167652069732073686F776E20666F722061207265717569726564206669656C64202877686963682068617320612076616C756520616E79776179290D';
wwv_flow_imp.g_varchar2_table(41) := '0A2020202020202020202020202020202020202020202020202F2F20696E2074686520736974756174696F6E20776865726520796F752073746172742065646974206D6F646520616E6420746865207265636F7264206973206E6F7420616C6C6F776564';
wwv_flow_imp.g_varchar2_table(42) := '20746F206265206564697465642E205468656E2C207768656E20796F7520706167696E61746520746F207468650D0A2020202020202020202020202020202020202020202020202F2F206E657874207265636F72642C207468652076616C69646174696F';
wwv_flow_imp.g_varchar2_table(43) := '6E206572726F722069732073686F776E206F6E20746865206669656C642E0D0A2020202020202020202020202020202020202020202020202F2F20546F20776F726B6172726F756E6420746869732C207765206361746368207468652072656C61746564';
wwv_flow_imp.g_varchar2_table(44) := '206D6F64656C206E6F74696669636174696F6E2028276D6574614368616E67652720697320276D6573736167652C6572726F72272920616E6420696620746865207265636F7264200D0A2020202020202020202020202020202020202020202020202F2F';
wwv_flow_imp.g_varchar2_table(45) := '206973206E6F7420616C6C6F77656420746F206265206564697465642C20776520636C65617220746865206572726F722E0D0A202020202020202020202020202020202020202020202020696620286368616E67652E7265636F72644964202626206368';
wwv_flow_imp.g_varchar2_table(46) := '616E67652E70726F7065727479202626206368616E67652E70726F70657274792E696E636C7564657328276D6573736167652729202626206368616E67652E70726F70657274792E696E636C7564657328276572726F722729290D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(47) := '202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020206C6574207265634D65746164617461203D206D6F64656C2E6765745265636F72644D65746164617461286368616E67652E7265636F';
wwv_flow_imp.g_varchar2_table(48) := '72644964293B0D0A2020202020202020202020202020202020202020202020202020202069662028216D6F64656C2E616C6C6F7745646974286368616E67652E7265636F72642920262620216D6F64656C734D6F64756C652E7574696C2E7265636F7264';
wwv_flow_imp.g_varchar2_table(49) := '4669656C647356616C6964287265634D6574616461746129290D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206D6F64656C734D6F6475';
wwv_flow_imp.g_varchar2_table(50) := '6C652E7574696C2E7365745265636F72644669656C647356616C6964286D6F64656C2C206368616E67652E7265636F7264293B0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(51) := '202020202020202020202020656C73650D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202F2F20696E2063617365206F66206D616E6461';
wwv_flow_imp.g_varchar2_table(52) := '746F7279206669656C642076616C69646174696F6E206572726F7220636175736564206279206F70656E696E672061206669656C64206469616C6F672C0D0A20202020202020202020202020202020202020202020202020202020202020202F2F207265';
wwv_flow_imp.g_varchar2_table(53) := '6D6F7665207468652076616C69646174696F6E206D6573736167650D0A202020202020202020202020202020202020202020202020202020202020202069662028617065782E7574696C2E676574546F704170657828292E6A517565727928272E75692D';
wwv_flow_imp.g_varchar2_table(54) := '6469616C6F672D706F7075706C6F762C202E75692D6469616C6F672D646174657069636B657227292E697328273A76697369626C652729290D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(55) := '20202020202020202020202020202020202020202020202020202020206D6F64656C2E73657456616C6964697479282776616C6964272C206368616E67652E7265636F726449642C206368616E67652E6669656C64293B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(56) := '2020202020202020202020202020202020202020207D2020202020202020202020202020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D2020202020202020202020';
wwv_flow_imp.g_varchar2_table(57) := '20202020202020202020202020202020200D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D20202020202020202020200D0A202020202020202020202020202020207D0D0A20';
wwv_flow_imp.g_varchar2_table(58) := '20202020202020202020207D293B0D0A20202020202020207D293B0D0A0D0A20202020202020202F2A0D0A2020202020202020202A20496E69742F41646A7573742074686520494720666F7220776869636820616E2045525620697320636F6E66696775';
wwv_flow_imp.g_varchar2_table(59) := '7265642E200D0A2020202020202020202A2F0D0A20202020202020206C657420696E69744947203D2066756E6374696F6E28696753746174696349642C20727653746174696349642C20727653746174696349645276290D0A20202020202020207B0D0A';
wwv_flow_imp.g_varchar2_table(60) := '202020202020202020202020617065782E6750616765436F6E74657874242E6F6E2822617065787265616479656E64222C2066756E6374696F6E286A51756572794576656E7429207B200D0A202020202020202020202020202020206C65742069675265';
wwv_flow_imp.g_varchar2_table(61) := '67696F6E203D20617065782E726567696F6E2869675374617469634964293B0D0A2020202020202020202020202020202069662028216967526567696F6E207C7C206967526567696F6E2E7479706520213D2027496E7465726163746976654772696427';
wwv_flow_imp.g_varchar2_table(62) := '290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020207468726F77206E6577204572726F72282749472045787465726E616C20526F7720566965772053657474696E6773206572726F723A205C272720';
wwv_flow_imp.g_varchar2_table(63) := '2B2069675374617469634964202B20275C27206973206E6F7420616E20496E746572616374697665204772696420526567696F6E27293B0D0A202020202020202020202020202020207D2020202020202020202020200D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(64) := '202020206C6574206967416374696F6E73203D20617065782E726567696F6E2869675374617469634964292E63616C6C2822676574416374696F6E7322293B0D0A202020202020202020202020202020202F2F2068696465206564697420627574746F6E';
wwv_flow_imp.g_varchar2_table(65) := '202D207573696E6720697420776F756C64206D616B6520697420636F6D706C657820746F20746F67676C652074686520627574746F6E2070726F7065726C790D0A202020202020202020202020202020206967416374696F6E732E686964652822656469';
wwv_flow_imp.g_varchar2_table(66) := '7422293B0D0A202020202020202020202020202020202F2F2073696E676C6520726F7720766965772073686F756C64206E6F742065786973740D0A202020202020202020202020202020202F2F20617320646576656C6F7065722073686F756C64206469';
wwv_flow_imp.g_varchar2_table(67) := '7361626C6520746865206665617475726520696E20494720696E69742066756E630D0A202020202020202020202020202020202F2F206966206E6F742064697361626C65642074686F7567682C207765206869646520746865206D656E75206F7074696F';
wwv_flow_imp.g_varchar2_table(68) := '6E0D0A20202020202020202020202020202020696620286967416374696F6E732E6C6F6F6B7570282773696E676C652D726F772D766965772729290D0A202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(69) := '6967416374696F6E732E68696465282273696E676C652D726F772D7669657722293B0D0A202020202020202020202020202020207D0D0A202020202020202020202020202020206C657420616374696F6E203D206967416374696F6E732E6C6F6F6B7570';
wwv_flow_imp.g_varchar2_table(70) := '28226564697422293B0D0A2020202020202020202020202020202069662028616374696F6E290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202F2F20776520686964652074686520656469742062';
wwv_flow_imp.g_varchar2_table(71) := '7574746F6E20287365652061626F7665292C2062757420696620746865206564697420616374696F6E2069732063616C6C65642070726F6772616D6D61746963616C6C792C200D0A20202020202020202020202020202020202020202F2F207468652062';
wwv_flow_imp.g_varchar2_table(72) := '656C6F772077696C6C2074616B652063617265206F6620737769746368696E67207468652065646974206D6F646520696E207468652072656C61746564204552560D0A2020202020202020202020202020202020202020616374696F6E2E736574203D20';
wwv_flow_imp.g_varchar2_table(73) := '66756E6374696F6E28656469744D6F646529207B0D0A202020202020202020202020202020202020202020202020726F77566965774D6F64756C652E736574456469744D6F646528727653746174696349642C20656469744D6F6465293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(74) := '202020202020202020202020202020207D3B0D0A2020202020202020202020202020202020202020616374696F6E2E676574203D2066756E6374696F6E2829207B0D0A20202020202020202020202020202020202020202020202072657475726E202428';
wwv_flow_imp.g_varchar2_table(75) := '222322202B20727653746174696349645276292E7265636F7264566965772827696E456469744D6F646527293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D200D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(76) := '2020202020202F2F206D616B6520616374696F6E20276C696234782D6572762D6F70656E2720617661696C61626C652C2077686963682063616E206265207573656420666F72206578616D706C65207768656E2074686520646576656C6F7065720D0A20';
wwv_flow_imp.g_varchar2_table(77) := '2020202020202020202020202020202F2F2077616E747320746F206F70656E20746865204552562066726F6D20616E204947206C696E6B20636F6C756D6E0D0A202020202020202020202020202020206967416374696F6E732E616464287B200D0A2020';
wwv_flow_imp.g_varchar2_table(78) := '2020202020202020202020202020202020206E616D653A20276C696234782D6572762D6F70656E272C200D0A2020202020202020202020202020202020202020616374696F6E3A2066756E6374696F6E286576656E7429207B200D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(79) := '202020202020202020202020202020206C6574206772696456696577203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269643B0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(80) := '2020206C6574207265636F7264203D2067726964566965772E676574436F6E746578745265636F7264286576656E742E746172676574293B0D0A20202020202020202020202020202020202020202020202067726964566965772E76696577242E677269';
wwv_flow_imp.g_varchar2_table(81) := '64282773657453656C65637465645265636F726473272C207265636F7264293B2020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020726F77566965774D6F64756C652E6F70656E';
wwv_flow_imp.g_varchar2_table(82) := '526F77566965772872765374617469634964293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D293B20200D0A202020202020202020202020202020206C6574206772696456696577203D2061';
wwv_flow_imp.g_varchar2_table(83) := '7065782E726567696F6E2869675374617469634964292E63616C6C28226765745669657773222C20226772696422293B0D0A202020202020202020202020202020202F2F20696E736572742065646974206D656E75206F7074696F6E2061667465722027';
wwv_flow_imp.g_varchar2_table(84) := '41646420526F7727206F7074696F6E0D0A202020202020202020202020202020206C657420726F77416374696F6E4D656E7524203D2067726964566965772E726F77416374696F6E4D656E75243B0D0A202020202020202020202020202020206C657420';
wwv_flow_imp.g_varchar2_table(85) := '616464526F774D656E75203D20726F77416374696F6E4D656E75242E6D656E7528276F7074696F6E27292E6974656D732E66696C74657228286D69293D3E6D692E616374696F6E3D3D27726F772D6164642D726F7727293B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(86) := '2020202020206C657420696E646578203D20303B0D0A2020202020202020202020202020202069662028616464526F774D656E752E6C656E677468290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(87) := '20696E646578203D20726F77416374696F6E4D656E75242E6D656E7528276F7074696F6E27292E6974656D732E696E6465784F6628616464526F774D656E755B305D29202B20313B0D0A202020202020202020202020202020207D0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(88) := '202020202020202020726F77416374696F6E4D656E75242E6D656E7528226F7074696F6E22292E6974656D732E73706C69636528696E6465782C20302C207B0D0A202020202020202020202020202020202020202069643A20276C696234785F65646974';
wwv_flow_imp.g_varchar2_table(89) := '272C0D0A2020202020202020202020202020202020202020747970653A2027616374696F6E272C0D0A20202020202020202020202020202020202020206C6162656C3A20274564697420526F77272C0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(90) := '2069636F6E3A202766612066612D65646974272C0D0A2020202020202020202020202020202020202020616374696F6E3A66756E6374696F6E28652C20656C290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(91) := '202020202020202020202020206C6574206772696456696577203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269643B0D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(92) := '6C6574207265636F7264203D2067726964566965772E676574436F6E746578745265636F726428656C293B0D0A20202020202020202020202020202020202020202020202067726964566965772E76696577242E67726964282773657453656C65637465';
wwv_flow_imp.g_varchar2_table(93) := '645265636F726473272C207265636F7264293B0D0A202020202020202020202020202020202020202020202020726F77566965774D6F64756C652E736574456469744D6F646528727653746174696349642C2074727565293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(94) := '20202020202020202020202020202069662028212428222322202B2072765374617469634964292E697328273A75692D6469616C6F672729290D0A2020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(95) := '202020202020202020202020202073657454696D656F75742828293D3E7B2428272327202B20727653746174696349645276292E7265636F7264566965772827666F63757327293B7D2C20313030293B0D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(96) := '2020202020207D0D0A20202020202020202020202020202020202020207D2C2020200D0A202020202020202020202020202020202020202064697361626C65643A2066756E6374696F6E20286F7074696F6E73290D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(97) := '2020202020207B0D0A2020202020202020202020202020202020202020202020206C6574206772696456696577203D2024286F7074696F6E732E616374696F6E73436F6E746578742E636F6E74657874292E696E74657261637469766547726964282767';
wwv_flow_imp.g_varchar2_table(98) := '6574566965777327292E677269643B0D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D2067726964566965772E6D6F64656C3B2020202020200D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(99) := '6C6574207265636F7264203D2067726964566965772E676574436F6E746578745265636F72642867726964566965772E76696577242E66696E6428222E612D427574746F6E2D2D616374696F6E732E69732D61637469766522295B305D295B305D3B0D0A';
wwv_flow_imp.g_varchar2_table(100) := '20202020202020202020202020202020202020202020202072657475726E2028216D6F64656C2E616C6C6F7745646974287265636F726429293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(101) := '293B200D0A202020202020202020202020202020202F2F20696E2063617365206F6620726561646F6E6C792049472C20616C736F20656E61626C6520746F206F70656E20616E79204552562062792064626C20636C69636B20696E206361736520697420';
wwv_flow_imp.g_varchar2_table(102) := '69732061206469616C6F670D0A202020202020202020202020202020206966202821617065782E726567696F6E2869675374617469634964292E63616C6C28276F7074696F6E27292E636F6E6669672E6564697461626C65290D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(103) := '202020202020207B0D0A2020202020202020202020202020202020202020696620282428272327202B2072765374617469634964292E697328273A75692D6469616C6F67272929200D0A20202020202020202020202020202020202020207B0D0A202020';
wwv_flow_imp.g_varchar2_table(104) := '202020202020202020202020202020202020202020617065782E726567696F6E2869675374617469634964292E656C656D656E742E6F6E282764626C636C69636B272C2066756E6374696F6E286A51756572794576656E742C2064617461297B0D0A2020';
wwv_flow_imp.g_varchar2_table(105) := '2020202020202020202020202020202020202020202020202020726F77566965774D6F64756C652E6F70656E526567696F6E28727653746174696349642C2074727565293B0D0A2020202020202020202020202020202020202020202020207D293B0D0A';
wwv_flow_imp.g_varchar2_table(106) := '20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D293B2020200D0A2020202020202020202020200D0A2020202020202020202020202F2F2075706F6E2073656C65';
wwv_flow_imp.g_varchar2_table(107) := '6374696F6E206368616E67652C20616C736F206368616E67652074686520455256207265636F72640D0A2020202020202020202020202428222322202B2069675374617469634964292E6F6E2822696E7465726163746976656772696473656C65637469';
wwv_flow_imp.g_varchar2_table(108) := '6F6E6368616E6765222C2066756E6374696F6E286576656E742C206461746129207B0D0A2020202020202020202020202020202069662028646174612E73656C65637465645265636F7264733F2E6C656E677468290D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(109) := '2020207B0D0A2020202020202020202020202020202020202020726F77566965774D6F64756C652E676F746F494753656C65637465645265636F726428727653746174696349645276293B0D0A202020202020202020202020202020207D0D0A20202020';
wwv_flow_imp.g_varchar2_table(110) := '20202020202020207D293B0D0A20202020202020207D0D0A20202020202020200D0A202020202020202072657475726E7B0D0A202020202020202020202020696E697449473A20696E697449470D0A20202020202020207D0D0A202020207D2928293B20';
wwv_flow_imp.g_varchar2_table(111) := '200D0A0D0A202020202F2A0D0A20202020202A205468652065787420726F772076696577206973206261736963616C6C79206120777261707065722061726F756E642061207265636F72645669657720696E7374616E63652C20636F6E66696775726564';
wwv_flow_imp.g_varchar2_table(112) := '20776974680D0A20202020202A207468652073616D65206D6F64656C20616E64206669656C6420636F6E66696775726174696F6E73206173207468652049472E20546865204552562063616E206265206D6F64656C6C6564206173206120726567756C61';
wwv_flow_imp.g_varchar2_table(113) := '720D0A20202020202A20726567696F6E206F722061732061206472617765722F6469616C6F672E0D0A20202020202A2F0D0A202020206C657420726F77566965774D6F64756C65203D202866756E6374696F6E2829200D0A202020207B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(114) := '2020202F2F2042656C6F772066756E6374696F6E20696C6C757374726174657320686F7720697420697320616C736F20706F737369626C6520746F2067657420746865204947207374617469632049642E0D0A20202020202020202F2F20466F7220636F';
wwv_flow_imp.g_varchar2_table(115) := '6E76656E69656E63652C207765206D61696E7461696E207468652072765F696753746174696349642068617368207461626C6520616E6420676574207468652049642066726F6D2074686572652E0D0A20202020202020202F2F20497420616C736F2069';
wwv_flow_imp.g_varchar2_table(116) := '6C6C757374726174657320776520646F6E2774206E6565642061206A51756572792064617461282920656E74727920666F722069742E0D0A202020202020202066756E6374696F6E20676574494753746174696349642872765374617469634964527629';
wwv_flow_imp.g_varchar2_table(117) := '0D0A20202020202020207B0D0A2020202020202020202020202F2F2072657475726E20282428272327202B20727653746174696349645276292E7265636F72645669657728276765744D6F64656C27292E6765744F7074696F6E2827726567696F6E5374';
wwv_flow_imp.g_varchar2_table(118) := '6174696349642729293B2020202F2F2032342E320D0A2020202020202020202020202F2F2072657475726E20282428272327202B20727653746174696349645276292E7265636F72645669657728276765744D6F64656C27292E6765744F7074696F6E28';
wwv_flow_imp.g_varchar2_table(119) := '27726567696F6E446F6D49642729293B2020202F2F2032362E310D0A20202020202020207D0D0A0D0A20202020202020202F2F20656E61626C657320746F2072656D6F7665206120636F6E74726F6C2066726F6D206120746F6F6C6261722067726F7570';
wwv_flow_imp.g_varchar2_table(120) := '0D0A202020202020202066756E6374696F6E20746F6F6C62617252656D6F766528746F6F6C6261722C20616374696F6E4E616D652C206C6162656C4B65792C206964290D0A20202020202020207B0D0A20202020202020202020202067726F75704C6F6F';
wwv_flow_imp.g_varchar2_table(121) := '703A20666F722028746247726F7570206F6620746F6F6C626172290D0A2020202020202020202020207B0D0A20202020202020202020202020202020666F7220287462436F6E74726F6C206F6620746247726F75702E636F6E74726F6C73290D0A202020';
wwv_flow_imp.g_varchar2_table(122) := '202020202020202020202020207B0D0A202020202020202020202020202020202020202069662028287462436F6E74726F6C2E616374696F6E202626207462436F6E74726F6C2E616374696F6E203D3D20616374696F6E4E616D6529207C7C20200D0A20';
wwv_flow_imp.g_varchar2_table(123) := '20202020202020202020202020202020202020202020287462436F6E74726F6C2E6C6162656C4B6579202626207462436F6E74726F6C2E6C6162656C4B6579203D3D206C6162656C4B657929207C7C0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(124) := '20202020287462436F6E74726F6C2E6964202626207462436F6E74726F6C2E6964203D3D20696429290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C657420696E64657820';
wwv_flow_imp.g_varchar2_table(125) := '3D20746247726F75702E636F6E74726F6C732E696E6465784F66287462436F6E74726F6C293B0D0A202020202020202020202020202020202020202020202020746247726F75702E636F6E74726F6C732E73706C69636528696E6465782C2031293B0D0A';
wwv_flow_imp.g_varchar2_table(126) := '202020202020202020202020202020202020202020202020627265616B2067726F75704C6F6F703B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20';
wwv_flow_imp.g_varchar2_table(127) := '202020202020207D0D0A0D0A20202020202020202F2F20636F6E76657274732074686520727620626F647920696E746F206120666C657820636F6C756D6E206C61796F75742061732070657220746865206669656C642067726F75707320646566696E69';
wwv_flow_imp.g_varchar2_table(128) := '74696F6E730D0A202020202020202066756E6374696F6E206170706C794669656C6447726F7570436F6C756D6E7328727653746174696349645276290D0A20202020202020207B0D0A2020202020202020202020206C6574207276426F647953656C6563';
wwv_flow_imp.g_varchar2_table(129) := '746F72203D20272327202B20727653746174696349645276202B2027202E27202B20435F52565F424F44593B0D0A2020202020202020202020206966202824287276426F647953656C6563746F72202B2027202E27202B20435F434F4C4C41505349424C';
wwv_flow_imp.g_varchar2_table(130) := '45292E6C656E677468290D0A2020202020202020202020207B0D0A2020202020202020202020202020202024287276426F647953656C6563746F72202B2027202E27202B20435F434F4C4C41505349424C45292E6869646528293B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(131) := '20202020202020202024287276426F647953656C6563746F72292E616464436C61737328435F464C4558293B0D0A2020202020202020202020202020202024287276426F647953656C6563746F72202B2027202E272B20435F434F4C4C41505349424C45';
wwv_flow_imp.g_varchar2_table(132) := '5F434F4E54454E54292E656163682866756E6374696F6E28297B242874686973292E616464436C61737328435F464C45585F47524F575F31297D293B2020202020200D0A2020202020202020202020207D2020202020202020200D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(133) := '7D0D0A0D0A20202020202020202F2F2061646A7573742074686520727620626F647920617320706572207468652065727620706C7567696E206F7074696F6E730D0A202020202020202066756E6374696F6E2061646A7573745276426F64792872765374';
wwv_flow_imp.g_varchar2_table(134) := '6174696349645276290D0A20202020202020207B0D0A2020202020202020202020206C6574206F7074696F6E73203D2072764F7074696F6E735B7276537461746963496452765D3B200D0A2020202020202020202020202F2F20576974682067726F7570';
wwv_flow_imp.g_varchar2_table(135) := '2068656164696E6720627574746F6E732C2061207265636F72645669657720666F63757320726573756C747320696E206120666F637573206F6E2074686520627574746F6E20696E7374656164206F66207468650D0A2020202020202020202020202F2F';
wwv_flow_imp.g_varchar2_table(136) := '20666972737420696E707574206669656C642E20546F2070726576656E742C207765207365742074686520627574746F6E7320746162696E64657820746F20272D31272E0D0A2020202020202020202020202428272327202B2072765374617469634964';
wwv_flow_imp.g_varchar2_table(137) := '5276202B2027202E27202B20435F52565F424F4459202B2027202E27202B20435F464F524D5F47524F55505F48454144494E47202B202720627574746F6E27292E656163682866756E6374696F6E28297B242874686973292E617474722827746162696E';
wwv_flow_imp.g_varchar2_table(138) := '646578272C20272D3127297D293B202020202020202020202020202020202020202020200D0A202020202020202020202020696620286F7074696F6E732E636F6C756D6E734C61796F7574203D3D20274649454C445F47524F55505F434F4C554D4E5327';
wwv_flow_imp.g_varchar2_table(139) := '292020202020202020202020200D0A2020202020202020202020207B0D0A202020202020202020202020202020206170706C794669656C6447726F7570436F6C756D6E7328727653746174696349645276293B0D0A2020202020202020202020207D0D0A';
wwv_flow_imp.g_varchar2_table(140) := '20202020202020207D0D0A0D0A20202020202020202F2F2067726F7570206869646520666561747572650D0A202020202020202066756E6374696F6E206869646547726F757028727653746174696349642C206669656C645374617469634964290D0A20';
wwv_flow_imp.g_varchar2_table(141) := '202020202020207B0D0A2020202020202020202020206C6574206669656C64436F6E7461696E657224203D202428272327202B2072765374617469634964202B2027202E27202B20435F52565F424F4459202B2027202327202B206669656C6453746174';
wwv_flow_imp.g_varchar2_table(142) := '69634964202B20275F434F4E5441494E455227293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F464F524D5F47524F55505F48454144494E47292E6869646528293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(143) := '20202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F464F524D292E6869646528293B0D0A20202020202020207D0D0A0D0A20202020202020202F2A0D0A2020202020202020202A204F70656E2074686520';
wwv_flow_imp.g_varchar2_table(144) := '726F77207669657720286469616C6F672C206472617765722920616E642073776974636820746F2065646974206D6F6465206966207468652076696577206973206564697461626C652E0D0A20202020202020202A2F0D0A202020202020202066756E63';
wwv_flow_imp.g_varchar2_table(145) := '74696F6E206F70656E526F77566965772872765374617469634964290D0A20202020202020207B0D0A2020202020202020202020206C657420727653746174696349645276203D2072765374617469634964202B2052565F4558543B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(146) := '202020202020696620282428222322202B20727653746174696349645276292E7265636F7264566965772827696E7374616E63652729290D0A2020202020202020202020207B0D0A20202020202020202020202020202020696620282428222322202B20';
wwv_flow_imp.g_varchar2_table(147) := '727653746174696349645276292E7265636F72645669657728276F7074696F6E272C20276564697461626C652729290D0A202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020736574456469744D6F646528';
wwv_flow_imp.g_varchar2_table(148) := '727653746174696349642C2074727565293B0D0A202020202020202020202020202020207D0D0A20202020202020202020202020202020656C73650D0A202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(149) := '6F70656E526567696F6E2872765374617469634964293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020207D0D0A0D0A20202020202020202F2F20536574207468652065646974206D6F6465';
wwv_flow_imp.g_varchar2_table(150) := '20696E2074686520756E6465726C79696E67207265636F7264566965772E200D0A20202020202020202F2F20496620746865204552562069732061206469616C6F67206F722064726177657220726567696F6E2C206F70656E732074686520726567696F';
wwv_flow_imp.g_varchar2_table(151) := '6E2E0D0A20202020202020202F2F205061737320656469744D6F6465206F6E6C79206173207472756520696E206361736520746865205256206973206564697461626C652E0D0A202020202020202066756E6374696F6E20736574456469744D6F646528';
wwv_flow_imp.g_varchar2_table(152) := '727653746174696349642C20656469744D6F6465290D0A20202020202020207B0D0A2020202020202020202020206C657420727653746174696349645276203D2072765374617469634964202B2052565F4558543B0D0A20202020202020202020202069';
wwv_flow_imp.g_varchar2_table(153) := '6620282428222322202B20727653746174696349645276292E7265636F7264566965772827696E7374616E63652729290D0A2020202020202020202020207B0D0A2020202020202020202020202020202069662028656469744D6F6465290D0A20202020';
wwv_flow_imp.g_varchar2_table(154) := '2020202020202020202020207B0D0A2020202020202020202020202020202020202020696620282428222322202B2072765374617469634964292E697328273A75692D6469616C6F672729290D0A20202020202020202020202020202020202020207B0D';
wwv_flow_imp.g_varchar2_table(155) := '0A2020202020202020202020202020202020202020202020206F70656E526567696F6E2872765374617469634964293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D20202020202020202020';
wwv_flow_imp.g_varchar2_table(156) := '20200D0A2020202020202020202020202020202069662028656469744D6F646520262620212428222322202B20727653746174696349645276292E7265636F7264566965772827696E456469744D6F64652729290D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(157) := '20207B0D0A2020202020202020202020202020202020202020696620282428222322202B20727653746174696349645276292E7265636F72645669657728276F7074696F6E272C20276564697461626C652729290D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(158) := '2020202020207B0D0A2020202020202020202020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F7264566965772827736574456469744D6F6465272C2074727565293B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(159) := '2020202020202020207D0D0A202020202020202020202020202020207D202020200D0A20202020202020202020202020202020656C7365206966202821656469744D6F6465202626202428222322202B20727653746174696349645276292E7265636F72';
wwv_flow_imp.g_varchar2_table(160) := '64566965772827696E456469744D6F6465272929200D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F726456696577282773657445';
wwv_flow_imp.g_varchar2_table(161) := '6469744D6F6465272C2066616C7365293B0D0A202020202020202020202020202020207D20200D0A2020202020202020202020207D200D0A20202020202020207D0D0A0D0A20202020202020202F2F204F70656E73207468652045525620647261776572';
wwv_flow_imp.g_varchar2_table(162) := '2F6469616C6F6720726567696F6E200D0A202020202020202066756E6374696F6E206F70656E526567696F6E2872765374617469634964290D0A20202020202020207B0D0A202020202020202020202020617065782E7468656D652E6F70656E52656769';
wwv_flow_imp.g_varchar2_table(163) := '6F6E2872765374617469634964293B2020202020202020202020202020202020202020202020202020200D0A20202020202020207D0D0A0D0A20202020202020202F2F206D616B652073616D65207265636F72642063757272656E742061732073656C65';
wwv_flow_imp.g_varchar2_table(164) := '6374656420696E2049470D0A202020202020202066756E6374696F6E20676F746F494753656C65637465645265636F726428727653746174696349645276290D0A20202020202020207B0D0A2020202020202020202020202F2F20636865636B20696E73';
wwv_flow_imp.g_varchar2_table(165) := '74616E6365200D0A2020202020202020202020202F2F20636865636B20616C736F2069662076697369626C650D0A2020202020202020202020202F2F206966206E6F742076697369626C652C2027676F746F4669656C64272077696C6C206E6F74206578';
wwv_flow_imp.g_varchar2_table(166) := '6563757465206120726566726573682C20736F20697420776F756C646E2774206D616B652073656E63650D0A2020202020202020202020202F2F20746F2063616C6C2069740D0A20202020202020202020202069662028282428222322202B2072765374';
wwv_flow_imp.g_varchar2_table(167) := '6174696349645276292E7265636F7264566965772827696E7374616E636527292920262620282428222322202B20727653746174696349645276292E697328273A76697369626C65272929290D0A2020202020202020202020207B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(168) := '2020202020202020206C65742069675374617469634964203D2072765F696753746174696349645B7276537461746963496452765D3B0D0A202020202020202020202020202020206C65742073656C65637465645265636F726473203D20617065782E72';
wwv_flow_imp.g_varchar2_table(169) := '6567696F6E2869675374617469634964292E63616C6C282767657453656C65637465645265636F72647327293B0D0A202020202020202020202020202020206966202873656C65637465645265636F7264732E6C656E677468290D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(170) := '20202020202020207B0D0A20202020202020202020202020202020202020206C6574207265636F7264203D2073656C65637465645265636F7264735B305D3B0D0A20202020202020202020202020202020202020206C6574206D6F64656C203D20617065';
wwv_flow_imp.g_varchar2_table(171) := '782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E6D6F64656C3B0D0A20202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72';
wwv_flow_imp.g_varchar2_table(172) := '644964287265636F7264293B0D0A20202020202020202020202020202020202020206C65742063757272656E745265636F72644964203D206E756C6C3B0D0A20202020202020202020202020202020202020206C65742063757272656E745265636F7264';
wwv_flow_imp.g_varchar2_table(173) := '203D202428222322202B20727653746174696349645276292E7265636F72645669657728276765745265636F726427293B0D0A20202020202020202020202020202020202020206966202863757272656E745265636F7264290D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(174) := '20202020202020202020207B0D0A20202020202020202020202020202020202020202020202063757272656E745265636F72644964203D206D6F64656C2E6765745265636F726449642863757272656E745265636F7264293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(175) := '20202020202020202020207D0D0A2020202020202020202020202020202020202020696620287265636F7264496420213D2063757272656E745265636F72644964290D0A20202020202020202020202020202020202020207B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(176) := '2020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F7264566965772827676F746F4669656C64272C207265636F72644964293B0D0A20202020202020202020202020202020202020207D0D0A20202020';
wwv_flow_imp.g_varchar2_table(177) := '2020202020202020202020207D0D0A2020202020202020202020207D2020200D0A20202020202020207D0D0A0D0A20202020202020202F2A0D0A2020202020202020202A20496E697420746865204552562E2041207265636F7264566965772069732069';
wwv_flow_imp.g_varchar2_table(178) := '6E7374616E74696174656420776974682073616D65206669656C6420646566696E6974696F6E732061732074686520494720636F6C756D6E20646566696E6974696F6E732C20616E64207468652073616D65206D6F64656C2E0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(179) := '2A20546F6F6C62617220697320636F6E666967757265642E0D0A2020202020202020202A2F0D0A20202020202020206C657420696E69745256203D2066756E6374696F6E28727653746174696349642C207276537461746963496452762C206967537461';
wwv_flow_imp.g_varchar2_table(180) := '7469634964290D0A20202020202020207B0D0A20202020202020202020202066756E6374696F6E20646F496E6974527628727653746174696349642C207276537461746963496452762C2069675374617469634964290D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(181) := '7B0D0A202020202020202020202020202020206C6574206F7074696F6E73203D2072764F7074696F6E735B7276537461746963496452765D3B0D0A202020202020202020202020202020202F2F20636865636B2053525620666561747572652073686F75';
wwv_flow_imp.g_varchar2_table(182) := '6C642062652064697361626C65640D0A2020202020202020202020202020202069662028617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E73696E676C65526F775669657724290D0A20';
wwv_flow_imp.g_varchar2_table(183) := '2020202020202020202020202020207B0D0A20202020202020202020202020202020202020207468726F77206E6577204572726F722827496E7465726163746976652047726964202827202B2069675374617469634964202B2027292063616E206E6F74';
wwv_flow_imp.g_varchar2_table(184) := '206861766520626F74682053696E676C6520526F77205669657720616E642045787465726E616C20526F7720566965772E2044697361626C652053525620696E20494720496E697469616C697A6174696F6E204A6176615363726970742046756E637469';
wwv_flow_imp.g_varchar2_table(185) := '6F6E2E27293B0D0A202020202020202020202020202020207D0D0A202020202020202020202020202020202F2F20636865636B207468657265206973206E6F206F746865722045525620666F72207468652073616D652049470D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(186) := '20202020202020696620282428272E27202B20435F4C494234585F49475F455256202B2027202E27202B20435F5256292E66696C7465722866756E6374696F6E2829207B20202020202020202020202020202020202020200D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(187) := '2020202020202020202072657475726E2872765F696753746174696349645B242874686973292E617474722827696427295D203D3D2069675374617469634964293B0D0A202020202020202020202020202020207D292E6C656E677468290D0A20202020';
wwv_flow_imp.g_varchar2_table(188) := '2020202020202020202020207B0D0A20202020202020202020202020202020202020207468726F77206E6577204572726F72282743616E206E6F742068617665206D6F7265207468616E20312045787465726E616C20526F77205669657720666F722074';
wwv_flow_imp.g_varchar2_table(189) := '68652073616D6520496E74657261637469766520477269642028272B696753746174696349642B272927293B0D0A202020202020202020202020202020207D202020200D0A202020202020202020202020202020202F2F20636F6D706F73652074686520';
wwv_flow_imp.g_varchar2_table(190) := '6669656C647320666F7220746865207265636F7264566965770D0A202020202020202020202020202020202F2F2074686520726F77206974656D732061726520736861726564206265747765656E2074686520494720616E6420746865207265636F7264';
wwv_flow_imp.g_varchar2_table(191) := '566965772C0D0A202020202020202020202020202020202F2F20736F20746865206669656C6420646566696E6974696F6E7320617265206A757374206120636F7079206F662074686520494720636F6C756D6E20646566696E6974696F6E730D0A202020';
wwv_flow_imp.g_varchar2_table(192) := '202020202020202020202020206C657420636F6C756D6E73203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E677269642827676574436F6C756D6E7327293B0D0A';
wwv_flow_imp.g_varchar2_table(193) := '202020202020202020202020202020206C6574206669656C6473203D207B7D3B0D0A20202020202020202020202020202020666F722028636F6C756D6E4E6F20696E20636F6C756D6E73290D0A202020202020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(194) := '202020202020202020202020202020202F2F2074686520435F4C494234585F49475F4552565F48494444454E20636C6173732063616E20626520676976656E206F6E2074686520636F6C756D6E2028617070656172616E63652073656374696F6E29206F';
wwv_flow_imp.g_varchar2_table(195) := '72206C696E6B206174747269627574657320617320746F0D0A20202020202020202020202020202020202020202F2F20696E6469636174652074686520636F6C756D6E2073686F756C64206E6F7420626520696E636C7564656420696E20746865204552';
wwv_flow_imp.g_varchar2_table(196) := '560D0A20202020202020202020202020202020202020206C657420736B6970203D20282821636F6C756D6E735B636F6C756D6E4E6F5D2E656C656D656E74496429207C7C0D0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(197) := '202028636F6C756D6E735B636F6C756D6E4E6F5D2E6C696E6B4174747269627574657320262620636F6C756D6E735B636F6C756D6E4E6F5D2E6C696E6B417474726962757465732E696E636C7564657328435F4C494234585F49475F4552565F48494444';
wwv_flow_imp.g_varchar2_table(198) := '454E2929207C7C0D0A202020202020202020202020202020202020202020202020202020202020202028636F6C756D6E735B636F6C756D6E4E6F5D2E636F6C756D6E437373436C617373657320262620636F6C756D6E735B636F6C756D6E4E6F5D2E636F';
wwv_flow_imp.g_varchar2_table(199) := '6C756D6E437373436C61737365732E696E636C7564657328435F4C494234585F49475F4552565F48494444454E2929290D0A20202020202020202020202020202020202020206966202821736B6970290D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(200) := '20207B0D0A2020202020202020202020202020202020202020202020206669656C64735B636F6C756D6E735B636F6C756D6E4E6F5D2E70726F70657274795D203D20242E657874656E6428747275652C207B7D2C20636F6C756D6E735B636F6C756D6E4E';
wwv_flow_imp.g_varchar2_table(201) := '6F5D293B0D0A2020202020202020202020202020202020202020202020206669656C64735B636F6C756D6E735B636F6C756D6E4E6F5D2E70726F70657274795D2E6669656C64437373436C6173736573203D20636F6C756D6E735B636F6C756D6E4E6F5D';
wwv_flow_imp.g_varchar2_table(202) := '2E636F6C756D6E437373436C61737365733B0D0A20202020202020202020202020202020202020202020202064656C657465206669656C64735B636F6C756D6E735B636F6C756D6E4E6F5D2E70726F70657274795D2E636F6C756D6E437373436C617373';
wwv_flow_imp.g_varchar2_table(203) := '65733B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A202020202020202020202020202020202F2F20696E636C75646520627574746F6E7320696E2074686520746F6F6C62617220666F72';
wwv_flow_imp.g_varchar2_table(204) := '206372756420616374696F6E7320616E642072656672657368202020202020202020202020200D0A202020202020202020202020202020206C657420616374696F6E73436F6E74657874203D20617065782E616374696F6E732E637265617465436F6E74';
wwv_flow_imp.g_varchar2_table(205) := '65787428277265636F726456696577272C202428222322202B20727653746174696349645276295B305D293B0D0A202020202020202020202020202020206C657420746F6F6C626172436F6E66203D206F7074696F6E732E636F6E6669672E746F6F6C62';
wwv_flow_imp.g_varchar2_table(206) := '6172436F6E663B0D0A202020202020202020202020202020206C657420746F6F6C626172203D206E756C6C3B0D0A2020202020202020202020202020202069662028746F6F6C626172436F6E662E73686F77290D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(207) := '207B0D0A2020202020202020202020202020202020202020746F6F6C626172203D20242E617065782E7265636F7264566965772E636F707944656661756C74546F6F6C62617228293B0D0A2020202020202020202020202020202020202020746F6F6C62';
wwv_flow_imp.g_varchar2_table(208) := '617252656D6F766528746F6F6C6261722C206E756C6C2C2027415045582E52562E53455454494E47535F4D454E55272C206E756C6C293B0D0A20202020202020202020202020202020202020206966202821746F6F6C626172436F6E662E6E6176696761';
wwv_flow_imp.g_varchar2_table(209) := '74696F6E427574746F6E73290D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020746F6F6C62617252656D6F766528746F6F6C6261722C202770726576696F75732D7265636F7264';
wwv_flow_imp.g_varchar2_table(210) := '272C206E756C6C2C206E756C6C293B0D0A202020202020202020202020202020202020202020202020746F6F6C62617252656D6F766528746F6F6C6261722C20276E6578742D7265636F7264272C206E756C6C2C206E756C6C293B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(211) := '2020202020202020202020202020202020746F6F6C62617252656D6F766528746F6F6C6261722C206E756C6C2C206E756C6C2C20277265636F72644E756D62657227293B0D0A20202020202020202020202020202020202020207D0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(212) := '2020202020202020202020202069662028746F6F6C626172436F6E662E726F77416374696F6E427574746F6E73290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206966202874';
wwv_flow_imp.g_varchar2_table(213) := '6F6F6C626172436F6E662E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C7564657328274144445F524F57272929207B0D0A20202020202020202020202020202020202020202020202020202020746F6F6C6261725B305D2E';
wwv_flow_imp.g_varchar2_table(214) := '636F6E74726F6C732E70757368280D0A202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A2022696E736572742D7265636F72';
wwv_flow_imp.g_varchar2_table(215) := '64222C0D0A2020202020202020202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E6C793A2074727565';
wwv_flow_imp.g_varchar2_table(216) := '2C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E3A202769636F6E2D69672D6164642D726F77270D0A202020202020202020202020202020202020202020202020202020207D293B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(217) := '20202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202069662028746F6F6C626172436F6E662E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C7564657328274455504C';
wwv_flow_imp.g_varchar2_table(218) := '49434154455F524F57272929207B0D0A20202020202020202020202020202020202020202020202020202020746F6F6C6261725B305D2E636F6E74726F6C732E70757368280D0A202020202020202020202020202020202020202020202020202020207B';
wwv_flow_imp.g_varchar2_table(219) := '0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A20226475706C69636174652D7265636F7264222C0D0A2020202020202020202020202020202020202020202020202020202020202020747970653A';
wwv_flow_imp.g_varchar2_table(220) := '2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E3A2027';
wwv_flow_imp.g_varchar2_table(221) := '69636F6E2D69672D6475706C6963617465272020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D293B0D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(222) := '207D0D0A20202020202020202020202020202020202020202020202069662028746F6F6C626172436F6E662E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C75646573282744454C4554455F524F57272929207B0D0A202020';
wwv_flow_imp.g_varchar2_table(223) := '20202020202020202020202020202020202020202020202020746F6F6C6261725B305D2E636F6E74726F6C732E70757368282020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(224) := '202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202264656C6574652D7265636F7264222C0D0A2020202020202020202020202020202020202020202020202020202020202020747970';
wwv_flow_imp.g_varchar2_table(225) := '653A2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E3A';
wwv_flow_imp.g_varchar2_table(226) := '202769636F6E2D69672D64656C657465272020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D293B0D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(227) := '7D0D0A20202020202020202020202020202020202020202020202069662028746F6F6C626172436F6E662E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C756465732827524546524553485F524F57272929207B0D0A202020';
wwv_flow_imp.g_varchar2_table(228) := '20202020202020202020202020202020202020202020202020746F6F6C6261725B305D2E636F6E74726F6C732E7075736828202020202020202020202020202020202020202020202020202020200D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(229) := '20202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A2022726566726573682D7265636F7264222C0D0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(230) := '2020747970653A2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(231) := '69636F6E3A202769636F6E2D69672D72656672657368272020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D293B0D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(232) := '2020202020207D0D0A20202020202020202020202020202020202020202020202069662028746F6F6C626172436F6E662E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C7564657328275245564552545F524F57272929207B';
wwv_flow_imp.g_varchar2_table(233) := '0D0A20202020202020202020202020202020202020202020202020202020746F6F6C6261725B305D2E636F6E74726F6C732E707573682820202020202020202020202020202020202020202020202020200D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(234) := '20202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A20227265766572742D7265636F7264222C0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(235) := '20202020747970653A2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(236) := '202069636F6E3A202769636F6E2D69672D726576657274272020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D293B200D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(237) := '20202020202020207D0D0A20202020202020202020202020202020202020207D200D0A202020202020202020202020202020207D2020202020202020202020200D0A20202020202020202020202020202020696620286F7074696F6E732E636F6C756D6E';
wwv_flow_imp.g_varchar2_table(238) := '734C61796F757420213D20274649454C445F47524F55505F434F4C554D4E5327290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202F2F207768656E2067726F7570732061726520757365642C2069';
wwv_flow_imp.g_varchar2_table(239) := '6E636C756465206120636F6C6C617073652F657870616E6420616C6C20627574746F6E20696E2074686520746F6F6C6261720D0A20202020202020202020202020202020202020206C65742067726F757065644669656C64734C656E677468203D204F62';
wwv_flow_imp.g_varchar2_table(240) := '6A6563742E656E7472696573286669656C6473292E66696C746572280D0A202020202020202020202020202020202020202020202020285B6B65792C2076616C5D293D3E2876616C2E67726F75704E616D65290D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(241) := '2020202020292E6C656E6774683B0D0A20202020202020202020202020202020202020206966202867726F757065644669656C64734C656E677468203E2030290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(242) := '2020202020202020202020202069662028746F6F6C626172436F6E662E73686F7729200D0A2020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020746F6F6C6261725B';
wwv_flow_imp.g_varchar2_table(243) := '746F6F6C6261722E6C656E6774682D315D2E636F6E74726F6C732E73706C69636528312C20302C207B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E3A20226C696234782D746F67676C652D636F6C';
wwv_flow_imp.g_varchar2_table(244) := '6C61707369626C6573222C0D0A2020202020202020202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A202020202020202020202020202020202020202020202020202020202020202069636F6E4F6E';
wwv_flow_imp.g_varchar2_table(245) := '6C793A2074727565202020202020202020200D0A202020202020202020202020202020202020202020202020202020207D293B0D0A2020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(246) := '20202020616374696F6E73436F6E746578742E616464285B0D0A2020202020202020202020202020202020202020202020207B200D0A202020202020202020202020202020202020202020202020202020206E616D653A20276C696234782D746F67676C';
wwv_flow_imp.g_varchar2_table(247) := '652D636F6C6C61707369626C6573272C200D0A202020202020202020202020202020202020202020202020202020206C6162656C4B65793A20274C494234582E4552562E434F4C5F4558505F475250272C0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(248) := '20202020202020202020206F6E4C6162656C4B65793A20274C494234582E4552562E434F4C5F475250272C0D0A202020202020202020202020202020202020202020202020202020206F66664C6162656C4B65793A20274C494234582E4552562E455850';
wwv_flow_imp.g_varchar2_table(249) := '5F475250272C0D0A202020202020202020202020202020202020202020202020202020202F2F6F6E49636F6E3A202769636F6E2D69672D636F6C6C617073652D726F77272C0D0A202020202020202020202020202020202020202020202020202020202F';
wwv_flow_imp.g_varchar2_table(250) := '2F6F666649636F6E3A202769636F6E2D69672D657870616E642D726F77272C0D0A202020202020202020202020202020202020202020202020202020202F2F6F6E49636F6E3A202766612066612D636F6D7072657373272C0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(251) := '2020202020202020202020202020202020202F2F6F666649636F6E3A202766612066612D657870616E64272C0D0A2020202020202020202020202020202020202020202020202020202069636F6E3A202766612066612D657870616E642D636F6C6C6170';
wwv_flow_imp.g_varchar2_table(252) := '7365272C202020202020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020202020202020202020657870616E6465643A20747275652C0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(253) := '202020202020207365743A2066756E6374696F6E28657870616E646564290D0A202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020746869732E';
wwv_flow_imp.g_varchar2_table(254) := '657870616E646564203D20657870616E6465643B0D0A202020202020202020202020202020202020202020202020202020202020202024282723272B20727653746174696349645276202B2027202E27202B20435F434F4C4C41505349424C45292E636F';
wwv_flow_imp.g_varchar2_table(255) := '6C6C61707369626C6528657870616E646564203F2027657870616E6427203A2027636F6C6C6170736527293B0D0A202020202020202020202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(256) := '2020202020206765743A2066756E6374696F6E28290D0A202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202072657475726E20746869732E6578';
wwv_flow_imp.g_varchar2_table(257) := '70616E6465643B0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D2020202020202020202020202020202020202020200D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(258) := '2020202020202020202020205D293B200D0A20202020202020202020202020202020202020207D20200D0A202020202020202020202020202020207D0D0A202020202020202020202020202020202F2F206170706C7920616E79204649454C445F434F4C';
wwv_flow_imp.g_varchar2_table(259) := '554D4E535F5350414E20636F6E6669670D0A20202020202020202020202020202020696620286F7074696F6E732E636F6C756D6E734C61796F7574203D3D20274649454C445F434F4C554D4E535F5350414E27290D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(260) := '20207B0D0A2020202020202020202020202020202020202020666F722028636F6E7374205B70726F70657274792C206669656C645D206F66204F626A6563742E656E7472696573286669656C6473292E66696C74657228285B6B65792C2076616C5D293D';
wwv_flow_imp.g_varchar2_table(261) := '3E2876616C2E656C656D656E7449642929290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206669656C642E6669656C64436F6C5370616E203D206F7074696F6E732E6663735F';
wwv_flow_imp.g_varchar2_table(262) := '7370616E57696474683B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A202020202020202020202020202020202F2F20636F6D706F7365206F7074696F6E7320666F72207265636F726456';
wwv_flow_imp.g_varchar2_table(263) := '6965770D0A202020202020202020202020202020206C657420677269644F7074696F6E73203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E6772696428276F7074';
wwv_flow_imp.g_varchar2_table(264) := '696F6E27293B0D0A202020202020202020202020202020206C6574207265636F7264566965774F7074696F6E73203D207B0D0A2020202020202020202020202020202020202020616374696F6E73436F6E746578743A20616374696F6E73436F6E746578';
wwv_flow_imp.g_varchar2_table(265) := '742C0D0A20202020202020202020202020202020202020206D6F64656C4E616D653A20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E6D6F64656C2E6E616D652C0D0A202020202020';
wwv_flow_imp.g_varchar2_table(266) := '20202020202020202020202020206669656C64733A205B6669656C64735D2C0D0A20202020202020202020202020202020202020206564697461626C653A20677269644F7074696F6E732E6564697461626C652C0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(267) := '2020202020206669656C6447726F7570733A20677269644F7074696F6E732E636F6C756D6E47726F7570732C0D0A2020202020202020202020202020202020202020746F6F6C6261723A20746F6F6C6261722C0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(268) := '20202020206175746F4164645265636F72643A20677269644F7074696F6E732E6175746F4164645265636F72642C0D0A202020202020202020202020202020202020202068617353697A653A206F7074696F6E732E68617353697A652C0D0A2020202020';
wwv_flow_imp.g_varchar2_table(269) := '2020202020202020202020202020206E6F4461746149636F6E3A20677269644F7074696F6E732E6E6F4461746149636F6E2C0D0A20202020202020202020202020202020202020206E6F446174614D6573736167653A20677269644F7074696F6E732E6E';
wwv_flow_imp.g_varchar2_table(270) := '6F446174614D6573736167652C0D0A202020202020202020202020202020202020202070726F67726573734F7074696F6E733A207B0D0A20202020202020202020202020202020202020202020202066697865643A2066616C736520202F2F2062792074';
wwv_flow_imp.g_varchar2_table(271) := '6869732073657474696E672C20612066657463682F736176652070726F6772657373207370696E6E65722077696C6C20626520696E207468652063656E746572206F6620746865207265636F72645669657720616E64206E6F7420666978656420746F20';
wwv_flow_imp.g_varchar2_table(272) := '74686520706167650D0A20202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020726567696F6E53746174696349643A20727653746174696349642C2020202020202F2F2032342E322020204E6F74';
wwv_flow_imp.g_varchar2_table(273) := '20737572652069662074686973206F6E65206973207573656420617420616C6C2074686F7567683B206974206973206E6F7420616E206F6666696369616C205256206F7074696F6E0D0A2020202020202020202020202020202020202020726567696F6E';
wwv_flow_imp.g_varchar2_table(274) := '446F6D49643A2072765374617469634964202020202020202020202F2F2032362E310D0A20202020202020202020202020202020202020202F2F206C6162656C416C69676E6D656E743A20737469636B20746F207468652064656661756C74202827656E';
wwv_flow_imp.g_varchar2_table(275) := '6427290D0A20202020202020202020202020202020202020202F2F2070726F67726573734F7074696F6E733A20737469636B20746F207468652064656661756C7420287B2066697865643A20216F7074696F6E732E68617353697A65207D290D0A202020';
wwv_flow_imp.g_varchar2_table(276) := '20202020202020202020202020202020202F2F207265636F72644F66667365743A206E6F206E65656420746F207365740D0A20202020202020202020202020202020202020202F2F2073686F774578636C75646548696464656E4669656C64733A207374';
wwv_flow_imp.g_varchar2_table(277) := '69636B20746F2064656661756C74202874727565290D0A20202020202020202020202020202020202020202F2F2073686F774578636C7564654E756C6C56616C7565733A20737469636B20746F2064656661756C74202874727565290D0A202020202020';
wwv_flow_imp.g_varchar2_table(278) := '20202020202020202020202020202F2F2073686F774E756C6C41733A20737469636B20746F2064656661756C742028272D27290D0A20202020202020202020202020202020202020202F2F20736B697044656C657465645265636F7264733A2073746963';
wwv_flow_imp.g_varchar2_table(279) := '6B20746F2064656661756C74202866616C7365290D0A20202020202020202020202020202020202020202F2F20666F726D437373436C61737365730D0A202020202020202020202020202020207D3B0D0A202020202020202020202020202020202F2F20';
wwv_flow_imp.g_varchar2_table(280) := '70726F6772616D6D617469616C6C792C206E657874206F7074696F6E732063616E206265207365742061732070617274206F6620636F6E6669670D0A202020202020202020202020202020206C657420636F6E666967203D204F626A6563742E66726F6D';
wwv_flow_imp.g_varchar2_table(281) := '456E7472696573280D0A20202020202020202020202020202020202020205B27616C7761797345646974272C20276170706C7954656D706C6174654F7074696F6E73272C2027666F726D437373436C6173736573272C20276C6162656C416C69676E6D65';
wwv_flow_imp.g_varchar2_table(282) := '6E74272C202773686F774E756C6C4173272C2027736B697044656C657465645265636F726473272C2027737570707265737356616C436C6F73655175657374696F6E275D0D0A20202020202020202020202020202020202020202E66696C746572286B65';
wwv_flow_imp.g_varchar2_table(283) := '79203D3E206B657920696E206F7074696F6E732E636F6E666967292E6D6170286B6579203D3E205B6B65792C206F7074696F6E732E636F6E6669675B6B65795D5D290D0A20202020202020202020202020202020293B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(284) := '202020207265636F7264566965774F7074696F6E73203D207B2E2E2E7265636F7264566965774F7074696F6E732C202E2E2E636F6E6669677D3B0D0A202020202020202020202020202020202F2F20696E7374616E7469617465207265636F7264566965';
wwv_flow_imp.g_varchar2_table(285) := '770D0A202020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F726456696577287265636F7264566965774F7074696F6E73293B0D0A202020202020202020202020202020202F2F20436173636164696E';
wwv_flow_imp.g_varchar2_table(286) := '67204C4F5620737570706F72742C2070617274203220287061727420312069732067657453657373696F6E537461746520696E2074686520726567696F6E20696E746572666163652C2073656520696E6974292E0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(287) := '20202F2F2054686520494727732067657453657373696F6E537461746520696D706C656D656E746174696F6E206F6E6C7920696E636C7564657320636F6C756D6E206974656D2076616C756573207768656E206974732063757272656E740D0A20202020';
wwv_flow_imp.g_varchar2_table(288) := '2020202020202020202020202F2F20766965772068617320616E20616374697665207265636F7264202D20627574207768696C652065646974696E672068617070656E7320696E20746865204552562C2074686520677269642076696577206E65766572';
wwv_flow_imp.g_varchar2_table(289) := '206861730D0A202020202020202020202020202020202F2F206F6E652C20736F207468652076616C7565732028616E6420746865207265636F7264277320636865636B73756D2920776F756C642062652073696C656E746C792064726F707065642E2046';
wwv_flow_imp.g_varchar2_table(290) := '616C6C206261636B20746F207468650D0A202020202020202020202020202020202F2F20455256207265636F726456696577277320616374697665207265636F72642E0D0A202020202020202020202020202020206C6574206772696456696577496D70';
wwv_flow_imp.g_varchar2_table(291) := '6C203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269643B0D0A202020202020202020202020202020206C6574206F7269674765744163746976655265636F72644964203D2067726964';
wwv_flow_imp.g_varchar2_table(292) := '56696577496D706C2E6765744163746976655265636F726449643B0D0A202020202020202020202020202020206772696456696577496D706C2E6765744163746976655265636F72644964203D2066756E6374696F6E2829207B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(293) := '2020202020202020202020206C6574207265636F72644964203D206F7269674765744163746976655265636F726449642E6170706C7928746869732C20617267756D656E7473293B0D0A2020202020202020202020202020202020202020696620282172';
wwv_flow_imp.g_varchar2_table(294) := '65636F72644964202626202428272327202B20727653746174696349645276292E7265636F7264566965772827696E7374616E63652729290D0A20202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(295) := '20202020207265636F72644964203D202428272327202B20727653746174696349645276292E7265636F72645669657728276765744163746976655265636F7264496427293B0D0A20202020202020202020202020202020202020207D0D0A2020202020';
wwv_flow_imp.g_varchar2_table(296) := '20202020202020202020202020202072657475726E207265636F726449643B0D0A202020202020202020202020202020207D3B0D0A20202020202020202020202020202020696620282428222322202B20727653746174696349645276292E697328273A';
wwv_flow_imp.g_varchar2_table(297) := '76697369626C652729290D0A202020202020202020202020202020207B0D0A202020202020202020202020202020202020202061646A7573745276426F647928727653746174696349645276293B0D0A202020202020202020202020202020207D0D0A20';
wwv_flow_imp.g_varchar2_table(298) := '2020202020202020202020202020202F2F20546865726520697320612062756720696E207265636F7264566965772077696467657420696E2077686963682075706F6E20696E736572742C207265636F7264566965772E666F63757328292069730D0A20';
wwv_flow_imp.g_varchar2_table(299) := '2020202020202020202020202020202F2F206578656375746564207477696365206F6E20746865206669727374206669656C642E2046726F6D20746869732C2069662074686973206669656C64206973206D616E6461746F72792C200D0A202020202020';
wwv_flow_imp.g_varchar2_table(300) := '202020202020202020202F2F20696D6D65646961746C7920612076616C69646174696F6E206D6573736167652069732073686F776E20756E64657220746865206669656C642E204974206F6E6C792068617070656E730D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(301) := '202020202F2F207768656E2074686520776964676574206973206E6F7420696E2065646974206D6F6465207965742E20416C736F2C2074686520697373756520776F6E27742068617070656E207768656E0D0A202020202020202020202020202020202F';
wwv_flow_imp.g_varchar2_table(302) := '2F2074686520666972737420636F6E74726F6C206973206120636F6C6C61707369626C6520627574746F6E20617320697420707574732028696E636F72726563746C79292074686520666F6375730D0A202020202020202020202020202020202F2F206F';
wwv_flow_imp.g_varchar2_table(303) := '6E207468617420627574746F6E2E0D0A202020202020202020202020202020202F2F20536F2062656C6F7720776520636F7272656374207468697320627920726576657274696E67207468652076616C696469747920746F202776616C6964272E0D0A20';
wwv_flow_imp.g_varchar2_table(304) := '2020202020202020202020202020206C657420696E73657274416374696F6E203D20616374696F6E73436F6E746578742E6C6F6F6B75702827696E736572742D7265636F726427293B0D0A2020202020202020202020202020202069662028696E736572';
wwv_flow_imp.g_varchar2_table(305) := '74416374696F6E290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206F726967416374696F6E203D20696E73657274416374696F6E2E616374696F6E3B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(306) := '2020202020202020696E73657274416374696F6E2E616374696F6E203D2066756E6374696F6E28297B0D0A2020202020202020202020202020202020202020202020206C657420696E456469744D6F6465203D202428222322202B207276537461746963';
wwv_flow_imp.g_varchar2_table(307) := '49645276292E7265636F7264566965772827696E456469744D6F646527293B0D0A2020202020202020202020202020202020202020202020206F726967416374696F6E28293B0D0A20202020202020202020202020202020202020202020202069662028';
wwv_flow_imp.g_varchar2_table(308) := '21696E456469744D6F6465290D0A2020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020206C6574206D6F64656C203D202428222322202B207276537461746963496452';
wwv_flow_imp.g_varchar2_table(309) := '76292E7265636F72645669657728276765744D6F64656C27293B0D0A202020202020202020202020202020202020202020202020202020206C6574207265636F7264203D202428222322202B20727653746174696349645276292E7265636F7264566965';
wwv_flow_imp.g_varchar2_table(310) := '7728276765745265636F726427293B0D0A202020202020202020202020202020202020202020202020202020206D6F64656C734D6F64756C652E7574696C2E7365745265636F72644669656C647356616C6964286D6F64656C2C207265636F7264293B0D';
wwv_flow_imp.g_varchar2_table(311) := '0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A202020202020202020202020202020202F2F205468657265206973206120';
wwv_flow_imp.g_varchar2_table(312) := '62756720696E204150455820696E202075706F6E207265766572742C20616E792076616C69646174696F6E206D6573736167657320617265206E6F7420636C65617265642C0D0A202020202020202020202020202020202F2F2063617573696E6720616E';
wwv_flow_imp.g_varchar2_table(313) := '79207361766520616374696F6E20746F20706F707570207468652027436F7272656374206572726F7273206265666F726520736176696E6727206D6573736167652E0D0A202020202020202020202020202020202F2F20536F2062656C6F772077652063';
wwv_flow_imp.g_varchar2_table(314) := '6F7272656374207468697320627920636C656172696E67207468652076616C69646174696F6E206572726F7273206166746572207265766572740D0A202020202020202020202020202020206C657420726576657274416374696F6E203D20616374696F';
wwv_flow_imp.g_varchar2_table(315) := '6E73436F6E746578742E6C6F6F6B757028277265766572742D7265636F726427293B0D0A2020202020202020202020202020202069662028726576657274416374696F6E290D0A202020202020202020202020202020207B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(316) := '202020202020202020206C6574206F726967416374696F6E203D20726576657274416374696F6E2E616374696F6E3B0D0A2020202020202020202020202020202020202020726576657274416374696F6E2E616374696F6E203D2066756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(317) := '29207B202020200D0A2020202020202020202020202020202020202020202020206F726967416374696F6E28293B0D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D202428222322202B207276537461746963';
wwv_flow_imp.g_varchar2_table(318) := '49645276292E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F7264203D202428222322202B20727653746174696349645276292E7265636F726456696577';
wwv_flow_imp.g_varchar2_table(319) := '28276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(320) := '202020202020206C6574207265634D65746164617461203D206D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A20202020202020202020202020202020202020202020202069662028216D6F64656C734D6F6475';
wwv_flow_imp.g_varchar2_table(321) := '6C652E7574696C2E7265636F72644669656C647356616C6964287265634D6574616461746129290D0A2020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020206D6F6465';
wwv_flow_imp.g_varchar2_table(322) := '6C734D6F64756C652E7574696C2E7365745265636F72644669656C647356616C6964286D6F64656C2C207265636F7264293B0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(323) := '3B0D0A202020202020202020202020202020207D3B20202020202020202020202020202020200D0A202020202020202020202020202020202428222322202B20727653746174696349645276292E6F6E2820227265636F7264766965777265636F726463';
wwv_flow_imp.g_varchar2_table(324) := '68616E6765222C2066756E6374696F6E28206576656E742C20646174612029207B0D0A202020202020202020202020202020202020202069662028646174612E7265636F72644964290D0A20202020202020202020202020202020202020207B0D0A2020';
wwv_flow_imp.g_varchar2_table(325) := '202020202020202020202020202020202020202020202F2F2075706F6E207265636F7264206368616E67652C20616C736F206368616E6765207468652073656C6563746564207265636F726420696E207468652049470D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(326) := '2020202020202020202020202F2F206966206E65656465642C206368616E676520746865207061676520696E207468652049470D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D20617065782E726567696F6E';
wwv_flow_imp.g_varchar2_table(327) := '2869675374617469634964292E63616C6C2827676574566965777327292E677269642E6D6F64656C3B0D0A2020202020202020202020202020202020202020202020206C6574207265636F7264203D206D6F64656C2E6765745265636F72642864617461';
wwv_flow_imp.g_varchar2_table(328) := '2E7265636F72644964293B20200D0A20202020202020202020202020202020202020202020202069662020282821617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E6772';
wwv_flow_imp.g_varchar2_table(329) := '696428276F7074696F6E27292E706167696E6174696F6E2E7363726F6C6C292026260D0A20202020202020202020202020202020202020202020202020202020617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965';
wwv_flow_imp.g_varchar2_table(330) := '777327292E677269642E6D6F64656C2E6765744F7074696F6E2827686173546F74616C5265636F7264732729290D0A2020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(331) := '20206C6574207265636F7264496E646578203D206D6F64656C2E696E6465784F66287265636F7264293B0D0A202020202020202020202020202020202020202020202020202020206C65742070616765496E666F203D20617065782E726567696F6E2869';
wwv_flow_imp.g_varchar2_table(332) := '675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E67726964282767657450616765496E666F27293B0D0A2020202020202020202020202020202020202020202020202020202069662028287265636F7264';
wwv_flow_imp.g_varchar2_table(333) := '496E646578202B203129203C2070616765496E666F2E66697273744F6666736574290D0A202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202069';
wwv_flow_imp.g_varchar2_table(334) := '66202870616765496E666F2E63757272656E7450616765203E2030290D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(335) := '20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E677269642827676F746F50616765272C2070616765496E666F2E63757272656E7450616765202D2031293B0D0A2020';
wwv_flow_imp.g_varchar2_table(336) := '2020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020656C736520696620';
wwv_flow_imp.g_varchar2_table(337) := '28287265636F7264496E646578202B203129203E2070616765496E666F2E6C6173744F6666736574290D0A202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(338) := '202020202020696620282870616765496E666F2E63757272656E7450616765202B203129203C2070616765496E666F2E746F74616C5061676573290D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(339) := '2020202020202020202020202020202020202020202020202020202020202020617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E677269642827676F746F50616765272C';
wwv_flow_imp.g_varchar2_table(340) := '2070616765496E666F2E63757272656E7450616765202B2031293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020';
wwv_flow_imp.g_varchar2_table(341) := '202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020206C65742073656C65637465645265636F726473203D20617065782E726567696F6E2869675374617469634964292E63616C6C28276765';
wwv_flow_imp.g_varchar2_table(342) := '7453656C65637465645265636F72647327293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F726453656C6563746564203D20282873656C65637465645265636F7264733F2E6C656E677468203D3D203129202626';
wwv_flow_imp.g_varchar2_table(343) := '202873656C65637465645265636F7264735B305D203D3D207265636F726429293B0D0A20202020202020202020202020202020202020202020202069662028217265636F726453656C6563746564290D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(344) := '20202020207B0D0A20202020202020202020202020202020202020202020202020202020617065782E726567696F6E2869675374617469634964292E63616C6C282773657453656C65637465645265636F726473272C205B7265636F72645D2C2066616C';
wwv_flow_imp.g_varchar2_table(345) := '73652C2074727565293B0D0A2020202020202020202020202020202020202020202020207D202020202020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(346) := '2020202020207D293B20202020200D0A202020202020202020202020202020202F2F2073696D696C617220746F2049472C2068617665206120726F7720696E697469616C697A6174696F6E206576656E740D0A202020202020202020202020202020202F';
wwv_flow_imp.g_varchar2_table(347) := '2F20746865207265636F7264566965772066697265732061706578626567696E7265636F7264656469742F61706578656E647265636F726465646974206576656E74730D0A202020202020202020202020202020202428222322202B2072765374617469';
wwv_flow_imp.g_varchar2_table(348) := '6349645276292E6F6E28202261706578626567696E7265636F726465646974222C2066756E6374696F6E28206576656E742C20646174612029207B0D0A20202020202020202020202020202020202020206966202864617461290D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(349) := '2020202020202020202020207B0D0A202020202020202020202020202020202020202020202020646174612E726F7744617461203D207574696C2E7265636F7264566965772E6765745265636F72644461746128727653746174696349645276293B0D0A';
wwv_flow_imp.g_varchar2_table(350) := '20202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020617065782E6576656E742E74726967676572282428272327202B20727653746174696349645276292C20276C696234785F6572765F726F775F';
wwv_flow_imp.g_varchar2_table(351) := '696E697469616C697A6174696F6E272C2064617461293B0D0A202020202020202020202020202020207D293B0D0A20202020202020202020202020202020696620282428272327202B2072765374617469634964292E697328273A75692D6469616C6F67';
wwv_flow_imp.g_varchar2_table(352) := '2729290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202F2F20666F7220616E2065727620696E2061206469616C6F672F6472617765722C20696620746865206469616C6F6720697320636C6F7365';
wwv_flow_imp.g_varchar2_table(353) := '6420627920746865207573657220627574207468657265206172650D0A20202020202020202020202020202020202020202F2F2076616C69646174696F6E206572726F72732C2067697665207175657374696F6E206F6E207768657468657220746F2070';
wwv_flow_imp.g_varchar2_table(354) := '726F636565640D0A20202020202020202020202020202020202020202F2F2063616E206265207375707072657373656420627920636F6E666967206F7074696F6E0D0A20202020202020202020202020202020202020202428272327202B207276537461';
wwv_flow_imp.g_varchar2_table(355) := '7469634964292E6F6E28276469616C6F676265666F7265636C6F7365272C2066756E6374696F6E286576656E7429207B0D0A2020202020202020202020202020202020202020202020206C657420646C6724203D20242874686973293B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(356) := '20202020202020202020202020202020202020696628646C67242E64617461282763616E2D636C6F7365272929207B0D0A20202020202020202020202020202020202020202020202020202020646C67242E72656D6F766544617461282763616E2D636C';
wwv_flow_imp.g_varchar2_table(357) := '6F736527293B0D0A202020202020202020202020202020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F7264566965772827736574456469744D6F6465272C2066616C7365293B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(358) := '20202020202020202020202020202020202020202072657475726E20747275653B0D0A2020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020617065782E6576656E742E747269';
wwv_flow_imp.g_varchar2_table(359) := '67676572282428222322202B20727653746174696349645276292C20276C696234785F72765F646F5F76616C69646174655F726F7727293B0D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D20242822232220';
wwv_flow_imp.g_varchar2_table(360) := '2B20727653746174696349645276292E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F7264203D202428222322202B20727653746174696349645276292E';
wwv_flow_imp.g_varchar2_table(361) := '7265636F72645669657728276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(362) := '20202020202020202020202020202020206C6574207265636F7264497356616C6964203D206D6F64656C734D6F64756C652E7574696C2E7265636F7264497356616C6964286D6F64656C2C207265636F72644964293B200D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(363) := '2020202020202020202020202069662028217265636F7264497356616C696420262620216F7074696F6E732E636F6E6669672E737570707265737356616C436C6F73655175657374696F6E290D0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(364) := '20207B2020202020202020202020202020202020202020202020202020200D0A202020202020202020202020202020202020202020202020202020206C657420617065784F7665726C617924203D202428273C64697620636C6173733D2227202B20435F';
wwv_flow_imp.g_varchar2_table(365) := '415045585F574149545F4F5645524C4159202B2027223E3C2F6469763E27292E70726570656E64546F282428272E27202B20435F4C494234585F49475F45525629293B0D0A20202020202020202020202020202020202020202020202020202020617065';
wwv_flow_imp.g_varchar2_table(366) := '782E6D6573736167652E636F6E6669726D286765744D6573736167652827515F56414C5F4552525F434C4F53455F4449414C4F4727292C2066756E6374696F6E286F6B5072657373656429207B0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(367) := '2020202020202020202020617065784F7665726C6179242E72656D6F766528293B0D0A2020202020202020202020202020202020202020202020202020202020202020696620286F6B5072657373656429207B0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(368) := '202020202020202020202020202020202020202020646C67242E64617461282763616E2D636C6F7365272C2074727565293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020646C67242E6469616C6F6728';
wwv_flow_imp.g_varchar2_table(369) := '27636C6F736527293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D2C7B0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(370) := '20202020202020202020207469746C653A202756616C69646174696F6E272C200D0A20202020202020202020202020202020202020202020202020202020202020207374796C653A2027696E666F726D6174696F6E270D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(371) := '202020202020202020202020202020207D293B202020202020202020200D0A2020202020202020202020202020202020202020202020202020202072657475726E2066616C73653B0D0A2020202020202020202020202020202020202020202020207D0D';
wwv_flow_imp.g_varchar2_table(372) := '0A2020202020202020202020202020202020202020202020202F2F20737769746368206F66662065646974206D6F646520736F2061706578656E647265636F7264656469742077696C6C2062652066697265640D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(373) := '2020202020202020202F2F2073686F756C6420626520646F6E65206865726520696E206265666F726520636C6F736520617320696E20636C6F7365206576656E742C0D0A2020202020202020202020202020202020202020202020202F2F207468652072';
wwv_flow_imp.g_varchar2_table(374) := '6F774974656D7320617265206E6F742076697369626C6520616E796D6F72652C20616E6420415045582077696C6C207468656E0D0A2020202020202020202020202020202020202020202020202F2F20696E207265636F7264566965772E736574456469';
wwv_flow_imp.g_varchar2_table(375) := '744D6F6465287472756529207365742076616C6964697479206F66206974656D20746F0D0A2020202020202020202020202020202020202020202020202F2F2076616C6964206F6E6C790D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(376) := '2428222322202B20727653746174696349645276292E7265636F7264566965772827736574456469744D6F6465272C2066616C7365293B0D0A20202020202020202020202020202020202020207D293B0D0A202020202020202020202020202020207D20';
wwv_flow_imp.g_varchar2_table(377) := '200D0A2020202020202020202020202020202069662028212428272327202B2072765374617469634964292E697328273A75692D6469616C6F672729290D0A202020202020202020202020202020207B0D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(378) := '20202F2F206E65787420736974756174696F6E206973206170706C696361626C65207768656E20657276206973206E6F742061206469616C6F670D0A20202020202020202020202020202020202020202F2F2075706F6E20736176652C20616E79207365';
wwv_flow_imp.g_varchar2_table(379) := '727665722D736964652076616C69646174696F6E7320776869636820726573756C7420696E2061206669656C64206572726F722C0D0A20202020202020202020202020202020202020202F2F2062656361757365206F66206120627567206974206C6F6F';
wwv_flow_imp.g_varchar2_table(380) := '6B73206C696B6520696E20415045582C20746865206572726F72206973206E6F742073686F776E0D0A20202020202020202020202020202020202020202F2F206F6E20746865206669656C6420286F6E6C79206F6E2070616765206C6576656C20617320';
wwv_flow_imp.g_varchar2_table(381) := '61206E6F74696669636174696F6E290D0A20202020202020202020202020202020202020202F2F20746865206572726F722069732074686572652074686F756768206F6E20746865206669656C64206D6574616461746120696E20746865206D6F64656C';
wwv_flow_imp.g_varchar2_table(382) := '0D0A20202020202020202020202020202020202020202F2F20746F20776F726B206172726F756E642C20776520726566726573682074686520525620616674657220736176650D0A20202020202020202020202020202020202020202428222322202B20';
wwv_flow_imp.g_varchar2_table(383) := '69675374617469634964292E6F6E2822696E7465726163746976656772696473617665222C2066756E6374696F6E28206576656E742C20646174612029207B0D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D';
wwv_flow_imp.g_varchar2_table(384) := '202428222322202B20727653746174696349645276292E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F7264203D202428222322202B2072765374617469';
wwv_flow_imp.g_varchar2_table(385) := '6349645276292E7265636F72645669657728276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A';
wwv_flow_imp.g_varchar2_table(386) := '20202020202020202020202020202020202020202020202069662028216D6F64656C734D6F64756C652E7574696C2E7265636F7264497356616C6964286D6F64656C2C207265636F7264496429290D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(387) := '202020207B0D0A202020202020202020202020202020202020202020202020202020202428222322202B20727653746174696349645276292E7265636F72645669657728277265667265736827293B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(388) := '20202020207D0D0A20202020202020202020202020202020202020207D293B0D0A202020202020202020202020202020207D200D0A2020202020202020202020207D0D0A0D0A20202020202020202020202066756E6374696F6E20646F496E6974527649';
wwv_flow_imp.g_varchar2_table(389) := '664967436F6C756D6E7350726573656E7428727653746174696349642C207276537461746963496452762C20696753746174696349642C20646F476F746F494753656C65637465645265636F7264290D0A2020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(390) := '2020202020202020202020202F2F20494720636F6C756D6E7320776F6E277420626520746865726520696620746865204947206973206E6F742076697369626C650D0A2020202020202020202020202020202069662028617065782E726567696F6E2869';
wwv_flow_imp.g_varchar2_table(391) := '675374617469634964292E63616C6C2827676574566965777327292E677269642E76696577242E677269642827676574436F6C756D6E7327292920200D0A202020202020202020202020202020207B202020200D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(392) := '20202020202F2F20546F20626520737572652C20636865636B2069662074686520455256206973206E6F74207468657265207965740D0A202020202020202020202020202020202020202069662028212428272327202B20727653746174696349645276';
wwv_flow_imp.g_varchar2_table(393) := '292E7265636F7264566965772827696E7374616E63652729290D0A20202020202020202020202020202020202020207B202020200D0A202020202020202020202020202020202020202020202020646F496E6974527628727653746174696349642C2072';
wwv_flow_imp.g_varchar2_table(394) := '76537461746963496452762C2069675374617469634964293B0D0A20202020202020202020202020202020202020202020202069662028646F476F746F494753656C65637465645265636F7264290D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(395) := '202020207B0D0A20202020202020202020202020202020202020202020202020202020676F746F494753656C65637465645265636F726428727653746174696349645276293B0D0A2020202020202020202020202020202020202020202020207D0D0A20';
wwv_flow_imp.g_varchar2_table(396) := '202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D20202020202020202020202020202020200D0A2020202020202020202020207D0D0A0D0A2020202020202020202020202F2F207768656E207468652072';
wwv_flow_imp.g_varchar2_table(397) := '656C6174656420494720686173206265656E20637265617465642C20696E697420746865204552560D0A202020202020202020202020696620282428272327202B2069675374617469634964202B2027202E612D494727292E6461746128276170657849';
wwv_flow_imp.g_varchar2_table(398) := '6E7465726163746976654772696427292026262028617065782E726567696F6E2869675374617469634964292E77696467657428292E696E74657261637469766547726964282767657443757272656E745669657749642729203D3D2027677269642729';
wwv_flow_imp.g_varchar2_table(399) := '290D0A2020202020202020202020207B0D0A20202020202020202020202020202020646F496E6974527649664967436F6C756D6E7350726573656E7428727653746174696349642C207276537461746963496452762C20696753746174696349642C2066';
wwv_flow_imp.g_varchar2_table(400) := '616C7365293B0D0A2020202020202020202020207D0D0A202020202020202020202020656C73650D0A2020202020202020202020207B0D0A202020202020202020202020202020202F2F20494720746F2062652063726561746564207965740D0A202020';
wwv_flow_imp.g_varchar2_table(401) := '202020202020202020202020202F2F20696E697420746865204552562075706F6E20696E74657261637469766567726964766965776368616E67650D0A202020202020202020202020202020202428272327202B2069675374617469634964292E6F6E28';
wwv_flow_imp.g_varchar2_table(402) := '22696E74657261637469766567726964766965776368616E6765222C2066756E6374696F6E286A51756572794576656E742C206461746129207B200D0A2020202020202020202020202020202020202020696620286461746120262620646174612E6372';
wwv_flow_imp.g_varchar2_table(403) := '656174656420262620646174612E76696577203D3D20276772696427290D0A20202020202020202020202020202020202020207B20200D0A202020202020202020202020202020202020202020202020646F496E6974527649664967436F6C756D6E7350';
wwv_flow_imp.g_varchar2_table(404) := '726573656E7428727653746174696349642C207276537461746963496452762C20696753746174696349642C2066616C7365293B0D0A20202020202020202020202020202020202020207D200D0A202020202020202020202020202020207D293B0D0A20';
wwv_flow_imp.g_varchar2_table(405) := '20202020202020202020207D20202020200D0A2020202020202020202020202F2F207768656E2074686520494720706C75732045525620697320696E697469616C6C79206E6F742076697369626C652028656720696E206120746162206F7220636F6C6C';
wwv_flow_imp.g_varchar2_table(406) := '61707369626C6520726567696F6E290D0A2020202020202020202020202F2F20696E697420746865204552562075706F6E206265636F6D696E672076697369626C6520200D0A2020202020202020202020202F2F20616C736F2C2074686520696E737461';
wwv_flow_imp.g_varchar2_table(407) := '6E6365206D6967687420657869737420616C72656164792C20627574206120726566726573682069732070656E64696E6720746F20626520646F6E650D0A2020202020202020202020202F2F207768656E20616E20455256206973206E6F742076697369';
wwv_flow_imp.g_varchar2_table(408) := '626C652C20746865207265636F7264206973206E6F74206B6570742073796E632077697468207468652049470D0A2020202020202020202020202F2F20736F207768656E2074686520455256206265636F6D65732076697369626C652C20776520657865';
wwv_flow_imp.g_varchar2_table(409) := '63757465206120676F746F494753656C65637465645265636F72642020200D0A202020202020202020202020617065782E7769646765742E7574696C2E6F6E5669736962696C6974794368616E6765282428272327202B20727653746174696349645276';
wwv_flow_imp.g_varchar2_table(410) := '292C2066756E6374696F6E2876697369626C65297B0D0A202020202020202020202020202020206966202876697369626C65290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206966202821242827';
wwv_flow_imp.g_varchar2_table(411) := '2327202B20727653746174696349645276292E7265636F7264566965772827696E7374616E63652729290D0A20202020202020202020202020202020202020207B202020202020200D0A2020202020202020202020202020202020202020202020202F2F';
wwv_flow_imp.g_varchar2_table(412) := '207573652073657454696D656F757420617320746865204947206D6967687420616C736F206A7573742068617665206265636F6D652076697369626C6520616E64206973207965740D0A2020202020202020202020202020202020202020202020202F2F';
wwv_flow_imp.g_varchar2_table(413) := '20746F20636F6D706C657465206974277320636F6C756D6E7320696E697469616C697A6174696F6E0D0A20202020202020202020202020202020202020202020202073657454696D656F75742828293D3E7B0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(414) := '202020202020202020202020646F496E6974527649664967436F6C756D6E7350726573656E7428727653746174696349642C207276537461746963496452762C20696753746174696349642C2074727565293B0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(415) := '2020202020202020207D2C203130293B20200D0A20202020202020202020202020202020202020207D200D0A2020202020202020202020202020202020202020656C736520696620282428222322202B20727653746174696349645276292E7265636F72';
wwv_flow_imp.g_varchar2_table(416) := '64566965772827696E7374616E636527292E70656E64696E6752656672657368290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202428222322202B2072765374617469634964';
wwv_flow_imp.g_varchar2_table(417) := '5276292E7265636F72645669657728277265667265736827293B0D0A20202020202020202020202020202020202020202020202061646A7573745276426F647928727653746174696349645276293B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(418) := '2020202020676F746F494753656C65637465645265636F726428727653746174696349645276293B0D0A20202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020656C73650D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(419) := '20202020202020202020207B0D0A202020202020202020202020202020202020202020202020676F746F494753656C65637465645265636F726428727653746174696349645276293B0D0A20202020202020202020202020202020202020207D0D0A2020';
wwv_flow_imp.g_varchar2_table(420) := '20202020202020202020202020207D0D0A2020202020202020202020207D293B2020202020202020200D0A20202020202020207D0D0A0D0A202020202020202072657475726E7B0D0A202020202020202020202020696E697452563A20696E697452562C';
wwv_flow_imp.g_varchar2_table(421) := '0D0A202020202020202020202020676F746F494753656C65637465645265636F72643A20676F746F494753656C65637465645265636F72642C0D0A2020202020202020202020206F70656E526F77566965773A206F70656E526F77566965772C0D0A2020';
wwv_flow_imp.g_varchar2_table(422) := '20202020202020202020736574456469744D6F64653A20736574456469744D6F64652C0D0A2020202020202020202020206F70656E526567696F6E3A206F70656E526567696F6E2C0D0A2020202020202020202020206869646547726F75703A20686964';
wwv_flow_imp.g_varchar2_table(423) := '6547726F75700D0A20202020202020207D0D0A202020207D2928293B20202020202020200D0A202020200D0A202020206C6574206D6F64656C734D6F64756C65203D202866756E6374696F6E2829207B0D0A20202020202020206C6574206D6F64656C55';
wwv_flow_imp.g_varchar2_table(424) := '74696C203D207B0D0A2020202020202020202020207265636F72644669656C647356616C69643A2066756E6374696F6E287265634D65746164617461290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C6574207661';
wwv_flow_imp.g_varchar2_table(425) := '6C6964203D20747275653B0D0A20202020202020202020202020202020696620287265634D65746164617461290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206669656C6473203D2072';
wwv_flow_imp.g_varchar2_table(426) := '65634D657461646174612E6669656C64733B0D0A2020202020202020202020202020202020202020696620286669656C6473290D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(427) := '666F722028636F6E7374206669656C6420696E206669656C647329200D0A2020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020696620286669656C64735B6669656C';
wwv_flow_imp.g_varchar2_table(428) := '645D2E6572726F72290D0A202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202076616C6964203D2066616C73653B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(429) := '20202020202020202020202020202020202020202020627265616B3B0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(430) := '20202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020202020202072657475726E2076616C69643B202020202020202020202020202020200D0A2020202020202020202020207D2C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(431) := '20202020207265636F7264497356616C69643A2066756E6374696F6E286D6F64656C2C207265636F72644964290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C6574207265634D65746144617461203D206D6F6465';
wwv_flow_imp.g_varchar2_table(432) := '6C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A2020202020202020202020202020202072657475726E2028217265634D657461446174612E6572726F7220262620746869732E7265636F72644669656C647356616C6964';
wwv_flow_imp.g_varchar2_table(433) := '287265634D6574614461746129293B0D0A2020202020202020202020207D2C0D0A2020202020202020202020207365745265636F72644669656C647356616C69643A2066756E6374696F6E286D6F64656C2C207265636F7264290D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(434) := '202020207B0D0A202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A202020202020202020202020202020206C6574207265634D65746164617461203D20';
wwv_flow_imp.g_varchar2_table(435) := '6D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A20202020202020202020202020202020696620287265634D65746164617461290D0A202020202020202020202020202020207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(436) := '2020202020202020206C6574206669656C6473203D207265634D657461646174612E6669656C64733B0D0A2020202020202020202020202020202020202020696620286669656C6473290D0A20202020202020202020202020202020202020207B0D0A20';
wwv_flow_imp.g_varchar2_table(437) := '2020202020202020202020202020202020202020202020666F722028636F6E7374206669656C6420696E206669656C647329200D0A2020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(438) := '2020202020202020696620286669656C64735B6669656C645D2E6572726F72290D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206D6F64';
wwv_flow_imp.g_varchar2_table(439) := '656C2E73657456616C6964697479282776616C6964272C207265636F726449642C206669656C64293B0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D';
wwv_flow_imp.g_varchar2_table(440) := '0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D202020202020202020202020202020200D0A2020202020202020202020207D0D0A20202020202020207D3B0D0A0D0A202020202020202072657475';
wwv_flow_imp.g_varchar2_table(441) := '726E7B0D0A2020202020202020202020207574696C3A206D6F64656C5574696C0D0A20202020202020207D0D0A202020207D2928293B2020202020200D0A0D0A202020202F2F203D3D7574696C206D6F64756C650D0A202020206C6574207574696C203D';
wwv_flow_imp.g_varchar2_table(442) := '207B2020200D0A20202020202020206974656D3A0D0A20202020202020207B0D0A2020202020202020202020206765744E617469766556616C75653A2066756E6374696F6E28617065784974656D290D0A2020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(443) := '2020202020202020202020206C657420726573756C74203D206E756C6C3B0D0A2020202020202020202020202020202069662028617065784974656D2E6974656D5F74797065203D3D20224E554D42455222290D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(444) := '207B0D0A2020202020202020202020202020202020202020726573756C74203D20617065784974656D2E6765744E617469766556616C756528293B0D0A20202020202020202020202020202020202020206966202869734E614E28726573756C7429290D';
wwv_flow_imp.g_varchar2_table(445) := '0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020726573756C74203D206E756C6C3B0D0A20202020202020202020202020202020202020207D0D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(446) := '2020207D0D0A20202020202020202020202020202020656C7365206966202828617065784974656D2E6974656D5F74797065203D3D202251452229207C7C2028617065784974656D2E6974656D5F74797065203D3D202257452229207C7C202861706578';
wwv_flow_imp.g_varchar2_table(447) := '4974656D2E6974656D5F74797065203D3D20225A452229207C7C2028617065784974656D2E6974656D5F74797065203D3D2022444154455F5049434B45522229207C7C2028617065784974656D2E6E6F64653F2E6E6F64654E616D65203D3D2027412D44';
wwv_flow_imp.g_varchar2_table(448) := '4154452D5049434B45522729290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020207472790D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(449) := '202020202020726573756C74203D20617065782E646174652E706172736528617065784974656D2E67657456616C756528292C20746869732E67657444617465466F726D617428617065784974656D29293B0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(450) := '202020207D0D0A20202020202020202020202020202020202020206361746368286529207B7D3B202020202020202020202020202020200D0A202020202020202020202020202020207D0D0A20202020202020202020202020202020656C73650D0A2020';
wwv_flow_imp.g_varchar2_table(451) := '20202020202020202020202020207B0D0A2020202020202020202020202020202020202020726573756C74203D20617065784974656D2E67657456616C756528293B0D0A202020202020202020202020202020207D0D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(452) := '20202072657475726E20726573756C743B0D0A2020202020202020202020207D2C2020202020202020202020200D0A20202020202020207D2C0D0A20202020202020207265636F7264566965773A0D0A20202020202020207B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(453) := '2020202F2F206765745265636F7264446174613A20646174612066726F6D205256206669656C64730D0A2020202020202020202020206765745265636F7264446174613A2066756E6374696F6E28727653746174696349645276290D0A20202020202020';
wwv_flow_imp.g_varchar2_table(454) := '20202020207B0D0A202020202020202020202020202020206C65742077696467657424203D202428272327202B20727653746174696349645276293B0D0A202020202020202020202020202020206C6574207265636F726444617461203D206E756C6C3B';
wwv_flow_imp.g_varchar2_table(455) := '0D0A202020202020202020202020202020202F2F20636865636B2069662074686572652069732061207265636F72642061637469766520627920636865636B696E6720746865206163746976655265636F726449640D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(456) := '2020206C6574206163746976655265636F72644964203D20776964676574242E7265636F72645669657728276765744163746976655265636F7264496427293B0D0A20202020202020202020202020202020696620286163746976655265636F72644964';
wwv_flow_imp.g_varchar2_table(457) := '290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020207265636F726444617461203D207B7D3B0D0A20202020202020202020202020202020202020206C6574206669656C6473203D2077696467657424';
wwv_flow_imp.g_varchar2_table(458) := '2E7265636F72645669657728276765744669656C647327293B0D0A2020202020202020202020202020202020202020666F7220286669656C64206F66206669656C6473290D0A20202020202020202020202020202020202020207B0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(459) := '2020202020202020202020202020202020696620286669656C642E656C656D656E74496420262620617065782E6974656D732E6861734F776E50726F7065727479286669656C642E656C656D656E74496429290D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(460) := '2020202020202020207B0D0A202020202020202020202020202020202020202020202020202020207265636F7264446174615B6669656C642E656C656D656E7449645D203D207574696C2E6974656D2E6765744E617469766556616C756528617065782E';
wwv_flow_imp.g_varchar2_table(461) := '6974656D286669656C642E656C656D656E74496429293B0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A202020202020';
wwv_flow_imp.g_varchar2_table(462) := '2020202020202020202072657475726E207265636F7264446174613B0D0A2020202020202020202020207D0D0A20202020202020207D0D0A202020207D3B20202020200D0A202020200D0A2020202066756E6374696F6E20696E69744D65737361676573';
wwv_flow_imp.g_varchar2_table(463) := '28290D0A202020207B0D0A20202020202020202F2F2068657265207765206861766520746865206C6162656C7320616E64206D6573736167657320666F722077686963682074686520646576656C6F7065722073686F756C64206265200D0A2020202020';
wwv_flow_imp.g_varchar2_table(464) := '2020202F2F2061626C6520746F20636F6E666967207472616E736C6174696F6E7320696E20415045580D0A2020202020202020617065782E6C616E672E6164644D65737361676573287B0D0A202020202020202020202020274C494234582E4552562E43';
wwv_flow_imp.g_varchar2_table(465) := '4F4C5F4558505F475250273A2027436F6C6C617073652F457870616E642047726F757073272C0D0A202020202020202020202020274C494234582E4552562E434F4C5F475250273A2027436F6C6C617073652047726F757073272C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(466) := '2020202020274C494234582E4552562E4558505F475250273A2027457870616E642047726F757073272C0D0A202020202020202020202020274C494234582E4552562E515F56414C5F4552525F434C4F53455F4449414C4F47273A202744617461206861';
wwv_flow_imp.g_varchar2_table(467) := '732076616C69646174696F6E206572726F72732E20436C6F7365204469616C6F673F270D0A20202020202020207D293B20202020202020200D0A202020207D0D0A0D0A2020202066756E6374696F6E206765744D657373616765286B657929207B0D0A20';
wwv_flow_imp.g_varchar2_table(468) := '2020202020202072657475726E20617065782E6C616E672E6765744D65737361676528274C494234582E4552562E27202B206B6579293B0D0A202020207D202020200D0A0D0A202020202F2A0D0A20202020202A204D61696E20706C7567696E20696E69';
wwv_flow_imp.g_varchar2_table(469) := '742066756E6374696F6E0D0A20202020202A2F0D0A202020206C657420696E6974203D2066756E6374696F6E28727653746174696349642C20696753746174696349642C20636F6C756D6E734C61796F75742C206663735F7370616E57696474682C2066';
wwv_flow_imp.g_varchar2_table(470) := '6F726D4C6162656C57696474682C206175746F4865696768742C206865696768742C20746F6F6C626172436F6E662C20696E697446756E63290D0A202020207B0D0A2020202020202020696E69744D6573736167657328293B0D0A20202020202020206C';
wwv_flow_imp.g_varchar2_table(471) := '657420727653746174696349645276203D2072765374617469634964202B2052565F4558543B0D0A202020202020202072765F696753746174696349645B7276537461746963496452765D203D20696753746174696349643B0D0A202020202020202069';
wwv_flow_imp.g_varchar2_table(472) := '675F727653746174696349645B696753746174696349645D203D20727653746174696349643B0D0A20202020202020202F2F207461672074686520726567696F6E206173206265696E6720616E204947204552560D0A202020202020202024282723272B';
wwv_flow_imp.g_varchar2_table(473) := '72765374617469634964292E616464436C61737328435F4C494234585F49475F455256293B0D0A202020202020202069662028666F726D4C6162656C5769647468290D0A20202020202020207B0D0A20202020202020202020202024282723272B727653';
wwv_flow_imp.g_varchar2_table(474) := '74617469634964292E616464436C61737328435F4C494234585F464F524D5F4C4142454C5F57494454485F505245464958202B20666F726D4C6162656C5769647468293B0D0A20202020202020207D0D0A20202020202020206966202824282723272B72';
wwv_flow_imp.g_varchar2_table(475) := '765374617469634964292E686173436C6173732827742D447261776572526567696F6E27292026262024282723272B72765374617469634964292E686173436C6173732827742D4469616C6F67526567696F6E2D2D6E6F50616464696E672729290D0A20';
wwv_flow_imp.g_varchar2_table(476) := '202020202020207B0D0A2020202020202020202020202F2F2062756720696E2032342E31202D207768656E2027647261776572272074656D706C61746520616E64202772656D6F766520626F64792070616464696E672720697420616464732027742D44';
wwv_flow_imp.g_varchar2_table(477) := '69616C6F67526567696F6E2D2D6E6F50616464696E67270D0A2020202020202020202020202F2F20636C617373206275742073686F756C642062652027742D447261776572526567696F6E2D2D6E6F50616464696E672720636C61737320696E73746561';
wwv_flow_imp.g_varchar2_table(478) := '640D0A20202020202020202020202024282723272B72765374617469634964292E72656D6F7665436C6173732827742D4469616C6F67526567696F6E2D2D6E6F50616464696E6727292E616464436C6173732827742D447261776572526567696F6E2D2D';
wwv_flow_imp.g_varchar2_table(479) := '6E6F50616464696E6727293B0D0A20202020202020207D0D0A20202020202020206C657420636F6E666967203D207B7D3B0D0A202020202020202069662028696E697446756E63290D0A20202020202020207B0D0A2020202020202020202020202F2F20';
wwv_flow_imp.g_varchar2_table(480) := '63616C6C20696E69742066756E6374696F6E2077686963682074686520646576656C6F7065722063616E2075736520746F200D0A2020202020202020202020202F2F2070726F6772616D6D61746963616C6C7920737065636966792074686520636F6E66';
wwv_flow_imp.g_varchar2_table(481) := '6967206F7074696F6E20776869636820617265206E6F7420617661696C61626C65206465636C617261746976656C790D0A202020202020202020202020636F6E666967203D20696E697446756E6328636F6E66696729207C7C207B7D3B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(482) := '2020207D0D0A2020202020202020636F6E6669672E746F6F6C626172436F6E66203D20746F6F6C626172436F6E663B0D0A20202020202020206C6574206F7074696F6E73203D207B7D3B0D0A20202020202020206F7074696F6E732E636F6E666967203D';
wwv_flow_imp.g_varchar2_table(483) := '20636F6E6669673B0D0A20202020202020206F7074696F6E732E636F6C756D6E734C61796F7574203D20636F6C756D6E734C61796F7574203F20636F6C756D6E734C61796F7574203A20274E4F4E45273B0D0A202020202020202069662028636F6C756D';
wwv_flow_imp.g_varchar2_table(484) := '6E734C61796F7574203D3D20274649454C445F434F4C554D4E535F5350414E27290D0A20202020202020207B0D0A2020202020202020202020206F7074696F6E732E6663735F7370616E5769647468203D206663735F7370616E5769647468203F207061';
wwv_flow_imp.g_varchar2_table(485) := '727365496E74286663735F7370616E576964746829203A20363B0D0A20202020202020207D0D0A20202020202020206F7074696F6E732E68617353697A65203D2028286175746F48656967687420213D2027592729202626202868656967687429293B0D';
wwv_flow_imp.g_varchar2_table(486) := '0A202020202020202072764F7074696F6E735B7276537461746963496452765D203D206F7074696F6E733B0D0A20202020202020202F2F2063726561746520726567696F6E20696E746572666163650D0A20202020202020202F2F20627920617065782E';
wwv_flow_imp.g_varchar2_table(487) := '726567696F6E28273C7374617469632069643E27292E77696467657428292E7265636F726456696577282E2E292C20746865207265636F7264566965772063616E20626520726561636865640D0A2020202020202020617065782E726567696F6E2E6372';
wwv_flow_imp.g_varchar2_table(488) := '656174652820727653746174696349642C207B0D0A202020202020202020202020747970653A2022494745787465726E616C526F7756696577222C0D0A202020202020202020202020706172656E74526567696F6E49643A20696753746174696349642C';
wwv_flow_imp.g_varchar2_table(489) := '0D0A2020202020202020202020202F2F20436173636164696E67204C4F5620737570706F72742E205768656E206120706F707570204C4F56207769746820224974656D7320746F205375626D6974222066697265732069747320616A61782C2061706578';
wwv_flow_imp.g_varchar2_table(490) := '2E7365727665720D0A2020202020202020202020202F2F207265736F6C766573207468652072657175657374277320726567696F6E20636F6E746578742076696120726567696F6E2E66696E64436C6F73657374287461726765742920616E642063616C';
wwv_flow_imp.g_varchar2_table(491) := '6C73207468617420726567696F6E27730D0A2020202020202020202020202F2F2067657453657373696F6E537461746528292E20546865204947277320696D706C656D656E746174696F6E2073706C69747320746865207375626D6974746564206E616D';
wwv_flow_imp.g_varchar2_table(492) := '657320696E746F20636F6C756D6E206974656D732076730D0A2020202020202020202020202F2F2070616765206974656D732C20616E64207061636B616765732074686520636F6C756D6E2076616C7565732028706C7573207468652061637469766520';
wwv_flow_imp.g_varchar2_table(493) := '7265636F7264277320636865636B73756D2F73616C742920696E746F20610D0A2020202020202020202020202F2F20726567696F6E2D73636F7065642073657453657373696F6E537461746520656E747279202D20776869636820697320746865204F4E';
wwv_flow_imp.g_varchar2_table(494) := '4C5920776179207468652073657276657220616363657074732076616C75657320666F720D0A2020202020202020202020202F2F20696E7465726E616C2022433C636F6C756D6E49643E2220636F6C756D6E207265666572656E6365732E2053696E6365';
wwv_flow_imp.g_varchar2_table(495) := '207468652073686172656420636F6C756D6E206974656D73206C69766520696E207468652045525627730D0A2020202020202020202020202F2F20444F4D2C2066696E64436C6F73657374207265736F6C76657320746F205448495320726567696F6E2C';
wwv_flow_imp.g_varchar2_table(496) := '20736F20776974686F757420746869732064656C65676174696F6E2074686520636F6C756D6E207265666572656E6365730D0A2020202020202020202020202F2F206C65616B20696E746F20706167654974656D7320616E642074686520736572766572';
wwv_flow_imp.g_varchar2_table(497) := '207468726F7773204552522D3130303220556E61626C6520746F2066696E64206974656D2049442E0D0A20202020202020202020202067657453657373696F6E53746174653A2066756E6374696F6E28704974656D73546F5375626D697429207B0D0A20';
wwv_flow_imp.g_varchar2_table(498) := '20202020202020202020202020202072657475726E20617065782E726567696F6E2869675374617469634964292E67657453657373696F6E537461746528704974656D73546F5375626D6974293B0D0A2020202020202020202020207D2C0D0A20202020';
wwv_flow_imp.g_varchar2_table(499) := '20202020202020207769646765743A2066756E6374696F6E2829207B0D0A2020202020202020202020202020202072657475726E202428272327202B20727653746174696349645276293B0D0A2020202020202020202020207D2C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(500) := '2020202020726566726573683A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202428272327202B20727653746174696349645276292E7265636F7264566965772827676574416374696F6E7327292E696E766F6B65282772';
wwv_flow_imp.g_varchar2_table(501) := '6566726573682D7265636F726427293B0D0A2020202020202020202020207D2C2020200D0A202020202020202020202020666F6375733A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202428272327202B20727653746174';
wwv_flow_imp.g_varchar2_table(502) := '696349645276292E7265636F7264566965772827666F63757327293B0D0A2020202020202020202020207D20202020202020202020202020202020200D0A20202020202020207D293B20202020202020202020200D0A2020202020202020677269644D6F';
wwv_flow_imp.g_varchar2_table(503) := '64756C652E696E6974494728696753746174696349642C20727653746174696349642C20727653746174696349645276293B0D0A2020202020202020726F77566965774D6F64756C652E696E6974525628727653746174696349642C2072765374617469';
wwv_flow_imp.g_varchar2_table(504) := '63496452762C2069675374617469634964293B0D0A202020207D3B0D0A0D0A2020202072657475726E7B0D0A20202020202020205F696E69743A20696E69742C0D0A20202020202020206F70656E526F77566965773A20726F77566965774D6F64756C65';
wwv_flow_imp.g_varchar2_table(505) := '2E6F70656E526F77566965772C0D0A20202020202020206869646547726F75703A20726F77566965774D6F64756C652E6869646547726F75700D0A202020207D0D0A7D2928617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(16571186758929561846)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_file_name=>'js/ig-externalrowview.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E6C696234783D77696E646F772E6C696234787C7C7B7D2C77696E646F772E6C696234782E6178743D77696E646F772E6C696234782E6178747C7C7B7D2C77696E646F772E6C696234782E6178742E69673D77696E646F772E6C69623478';
wwv_flow_imp.g_varchar2_table(2) := '2E6178742E69677C7C7B7D2C6C696234782E6178742E69672E65787465726E616C526F77566965773D66756E6374696F6E2865297B636F6E737420693D22612D52562D626F6479222C743D22612D436F6C6C61707369626C65222C6F3D22752D466F726D';
wwv_flow_imp.g_varchar2_table(3) := '2D67726F757048656164696E67222C6E3D226C696234782D69672D657276222C723D226C696234782D69672D6572762D68696464656E222C6C3D225F7276223B6C657420643D7B7D2C613D7B7D2C633D7B7D2C733D66756E6374696F6E28297B66756E63';
wwv_flow_imp.g_varchar2_table(4) := '74696F6E206928297B652E7769646765742822617065782E67726964222C652E617065782E677269642C7B736574456469744D6F64653A66756E6374696F6E28652C69297B636F6E73745B742C6F2C6E5D3D617065782E656E762E415045585F56455253';
wwv_flow_imp.g_varchar2_table(5) := '494F4E2E73706C697428222E22292E6D6170284E756D626572293B6C657420723D746869732E656C656D656E742E636C6F7365737428222E612D494722292E696E7465726163746976654772696428226F7074696F6E22292E636F6E6669672C6C3D743E';
wwv_flow_imp.g_varchar2_table(6) := '3D32363F722E726567696F6E446F6D49643A722E726567696F6E53746174696349643B69662821632E6861734F776E50726F7065727479286C292972657475726E20746869732E5F737570657228652C69293B672E736574456469744D6F646528635B6C';
wwv_flow_imp.g_varchar2_table(7) := '5D2C65297D7D297D652E617065782E6772696426266928292C646F63756D656E742E676574456C656D656E747342795461674E616D652822626F647922295B305D2E6164644576656E744C697374656E657228226C6F6164222C66756E6374696F6E2865';
wwv_flow_imp.g_varchar2_table(8) := '297B69662822534352495054223D3D3D652E7461726765742E6E6F64654E616D65297B6C657420743D652E7461726765742E676574417474726962757465282273726322293B742626742E696E636C7564657328227769646765742E6772696422292626';
wwv_flow_imp.g_varchar2_table(9) := '6928297D7D2C2130292C617065782E6750616765436F6E74657874242E6F6E2822696E74657261637469766567726964766965776D6F64656C637265617465222C66756E6374696F6E28652C69297B6C657420743D692E6D6F64656C3B742E7375627363';
wwv_flow_imp.g_varchar2_table(10) := '72696265287B6F6E4368616E67653A66756E6374696F6E28652C69297B696628226D6574614368616E6765223D3D652626692E7265636F726449642626692E70726F70657274792626692E70726F70657274792E696E636C7564657328226D6573736167';
wwv_flow_imp.g_varchar2_table(11) := '6522292626692E70726F70657274792E696E636C7564657328226572726F722229297B6C657420653D742E6765745265636F72644D6574616461746128692E7265636F72644964293B742E616C6C6F774564697428692E7265636F7264297C7C752E7574';
wwv_flow_imp.g_varchar2_table(12) := '696C2E7265636F72644669656C647356616C69642865293F617065782E7574696C2E676574546F704170657828292E6A517565727928222E75692D6469616C6F672D706F7075706C6F762C202E75692D6469616C6F672D646174657069636B657222292E';
wwv_flow_imp.g_varchar2_table(13) := '697328223A76697369626C6522292626742E73657456616C6964697479282276616C6964222C692E7265636F726449642C692E6669656C64293A752E7574696C2E7365745265636F72644669656C647356616C696428742C692E7265636F7264297D7D7D';
wwv_flow_imp.g_varchar2_table(14) := '297D293B72657475726E7B696E697449473A66756E6374696F6E28692C742C6F297B617065782E6750616765436F6E74657874242E6F6E2822617065787265616479656E64222C66756E6374696F6E286E297B6C657420723D617065782E726567696F6E';
wwv_flow_imp.g_varchar2_table(15) := '2869293B69662821727C7C22496E7465726163746976654772696422213D722E74797065297468726F77206E6577204572726F72282249472045787465726E616C20526F7720566965772053657474696E6773206572726F723A2027222B692B22272069';
wwv_flow_imp.g_varchar2_table(16) := '73206E6F7420616E20496E746572616374697665204772696420526567696F6E22293B6C6574206C3D617065782E726567696F6E2869292E63616C6C2822676574416374696F6E7322293B6C2E6869646528226564697422292C6C2E6C6F6F6B75702822';
wwv_flow_imp.g_varchar2_table(17) := '73696E676C652D726F772D76696577222926266C2E68696465282273696E676C652D726F772D7669657722293B6C657420643D6C2E6C6F6F6B757028226564697422293B64262628642E7365743D66756E6374696F6E2865297B672E736574456469744D';
wwv_flow_imp.g_varchar2_table(18) := '6F646528742C65297D2C642E6765743D66756E6374696F6E28297B72657475726E2065282223222B6F292E7265636F7264566965772822696E456469744D6F646522297D292C6C2E616464287B6E616D653A226C696234782D6572762D6F70656E222C61';
wwv_flow_imp.g_varchar2_table(19) := '6374696F6E3A66756E6374696F6E2865297B6C6574206F3D617065782E726567696F6E2869292E63616C6C2822676574566965777322292E677269642C6E3D6F2E676574436F6E746578745265636F726428652E746172676574293B6F2E76696577242E';
wwv_flow_imp.g_varchar2_table(20) := '67726964282273657453656C65637465645265636F726473222C6E292C672E6F70656E526F77566965772874297D7D293B6C657420613D617065782E726567696F6E2869292E63616C6C28226765745669657773222C226772696422292E726F77416374';
wwv_flow_imp.g_varchar2_table(21) := '696F6E4D656E75242C633D612E6D656E7528226F7074696F6E22292E6974656D732E66696C74657228653D3E22726F772D6164642D726F77223D3D652E616374696F6E292C733D303B632E6C656E677468262628733D612E6D656E7528226F7074696F6E';
wwv_flow_imp.g_varchar2_table(22) := '22292E6974656D732E696E6465784F6628635B305D292B31292C612E6D656E7528226F7074696F6E22292E6974656D732E73706C69636528732C302C7B69643A226C696234785F65646974222C747970653A22616374696F6E222C6C6162656C3A224564';
wwv_flow_imp.g_varchar2_table(23) := '697420526F77222C69636F6E3A2266612066612D65646974222C616374696F6E3A66756E6374696F6E286E2C72297B6C6574206C3D617065782E726567696F6E2869292E63616C6C2822676574566965777322292E677269642C643D6C2E676574436F6E';
wwv_flow_imp.g_varchar2_table(24) := '746578745265636F72642872293B6C2E76696577242E67726964282273657453656C65637465645265636F726473222C64292C672E736574456469744D6F646528742C2130292C65282223222B74292E697328223A75692D6469616C6F6722297C7C7365';
wwv_flow_imp.g_varchar2_table(25) := '7454696D656F75742828293D3E7B65282223222B6F292E7265636F7264566965772822666F63757322297D2C313030297D2C64697361626C65643A66756E6374696F6E2869297B6C657420743D6528692E616374696F6E73436F6E746578742E636F6E74';
wwv_flow_imp.g_varchar2_table(26) := '657874292E696E746572616374697665477269642822676574566965777322292E677269642C6F3D742E6D6F64656C2C6E3D742E676574436F6E746578745265636F726428742E76696577242E66696E6428222E612D427574746F6E2D2D616374696F6E';
wwv_flow_imp.g_varchar2_table(27) := '732E69732D61637469766522295B305D295B305D3B72657475726E216F2E616C6C6F7745646974286E297D7D292C617065782E726567696F6E2869292E63616C6C28226F7074696F6E22292E636F6E6669672E6564697461626C657C7C65282223222B74';
wwv_flow_imp.g_varchar2_table(28) := '292E697328223A75692D6469616C6F6722292626617065782E726567696F6E2869292E656C656D656E742E6F6E282264626C636C69636B222C66756E6374696F6E28652C69297B672E6F70656E526567696F6E28742C2130297D297D292C65282223222B';
wwv_flow_imp.g_varchar2_table(29) := '69292E6F6E2822696E7465726163746976656772696473656C656374696F6E6368616E6765222C66756E6374696F6E28652C69297B692E73656C65637465645265636F7264733F2E6C656E6774682626672E676F746F494753656C65637465645265636F';
wwv_flow_imp.g_varchar2_table(30) := '7264286F297D297D7D7D28292C673D66756E6374696F6E28297B66756E6374696F6E206328652C692C742C6F297B653A666F7228746247726F7570206F66206529666F72287462436F6E74726F6C206F6620746247726F75702E636F6E74726F6C732969';
wwv_flow_imp.g_varchar2_table(31) := '66287462436F6E74726F6C2E616374696F6E26267462436F6E74726F6C2E616374696F6E3D3D697C7C7462436F6E74726F6C2E6C6162656C4B657926267462436F6E74726F6C2E6C6162656C4B65793D3D747C7C7462436F6E74726F6C2E696426267462';
wwv_flow_imp.g_varchar2_table(32) := '436F6E74726F6C2E69643D3D6F297B6C657420653D746247726F75702E636F6E74726F6C732E696E6465784F66287462436F6E74726F6C293B746247726F75702E636F6E74726F6C732E73706C69636528652C31293B627265616B20657D7D66756E6374';
wwv_flow_imp.g_varchar2_table(33) := '696F6E2073286E297B6C657420723D645B6E5D3B65282223222B6E2B22202E222B692B22202E222B6F2B2220627574746F6E22292E656163682866756E6374696F6E28297B652874686973292E617474722822746162696E646578222C222D3122297D29';
wwv_flow_imp.g_varchar2_table(34) := '2C224649454C445F47524F55505F434F4C554D4E53223D3D722E636F6C756D6E734C61796F7574262666756E6374696F6E286F297B6C6574206E3D2223222B6F2B22202E222B693B65286E2B22202E222B74292E6C656E67746826262865286E2B22202E';
wwv_flow_imp.g_varchar2_table(35) := '222B74292E6869646528292C65286E292E616464436C6173732822752D666C657822292C65286E2B22202E612D436F6C6C61707369626C652D636F6E74656E7422292E656163682866756E6374696F6E28297B652874686973292E616464436C61737328';
wwv_flow_imp.g_varchar2_table(36) := '22752D666C65782D67726F772D3122297D29297D286E297D66756E6374696F6E206728692C74297B6C6574206F3D692B6C3B65282223222B6F292E7265636F7264566965772822696E7374616E6365222926262874262665282223222B69292E69732822';
wwv_flow_imp.g_varchar2_table(37) := '3A75692D6469616C6F6722292626662869292C7426262165282223222B6F292E7265636F7264566965772822696E456469744D6F646522293F65282223222B6F292E7265636F72645669657728226F7074696F6E222C226564697461626C652229262665';
wwv_flow_imp.g_varchar2_table(38) := '282223222B6F292E7265636F7264566965772822736574456469744D6F6465222C2130293A2174262665282223222B6F292E7265636F7264566965772822696E456469744D6F64652229262665282223222B6F292E7265636F7264566965772822736574';
wwv_flow_imp.g_varchar2_table(39) := '456469744D6F6465222C213129297D66756E6374696F6E20662865297B617065782E7468656D652E6F70656E526567696F6E2865297D66756E6374696F6E20772869297B69662865282223222B69292E7265636F7264566965772822696E7374616E6365';
wwv_flow_imp.g_varchar2_table(40) := '2229262665282223222B69292E697328223A76697369626C652229297B6C657420743D615B695D2C6F3D617065782E726567696F6E2874292E63616C6C282267657453656C65637465645265636F72647322293B6966286F2E6C656E677468297B6C6574';
wwv_flow_imp.g_varchar2_table(41) := '206E3D6F5B305D2C723D617065782E726567696F6E2874292E63616C6C2822676574566965777322292E677269642E6D6F64656C2C6C3D722E6765745265636F72644964286E292C643D6E756C6C2C613D65282223222B69292E7265636F726456696577';
wwv_flow_imp.g_varchar2_table(42) := '28226765745265636F726422293B61262628643D722E6765745265636F72644964286129292C6C213D64262665282223222B69292E7265636F7264566965772822676F746F4669656C64222C6C297D7D7D72657475726E7B696E697452563A66756E6374';
wwv_flow_imp.g_varchar2_table(43) := '696F6E28692C6F2C6C297B66756E6374696F6E206728692C6F2C6C297B6C657420673D645B6F5D3B696628617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E73696E676C65526F775669657724297468726F77';
wwv_flow_imp.g_varchar2_table(44) := '206E6577204572726F722822496E74657261637469766520477269642028222B6C2B22292063616E206E6F74206861766520626F74682053696E676C6520526F77205669657720616E642045787465726E616C20526F7720566965772E2044697361626C';
wwv_flow_imp.g_varchar2_table(45) := '652053525620696E20494720496E697469616C697A6174696F6E204A6176615363726970742046756E6374696F6E2E22293B6966286528222E222B6E2B22202E612D525622292E66696C7465722866756E6374696F6E28297B72657475726E20615B6528';
wwv_flow_imp.g_varchar2_table(46) := '74686973292E617474722822696422295D3D3D6C7D292E6C656E677468297468726F77206E6577204572726F72282243616E206E6F742068617665206D6F7265207468616E20312045787465726E616C20526F77205669657720666F7220746865207361';
wwv_flow_imp.g_varchar2_table(47) := '6D6520496E74657261637469766520477269642028222B6C2B222922293B6C657420663D617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E76696577242E677269642822676574436F6C756D6E7322292C773D';
wwv_flow_imp.g_varchar2_table(48) := '7B7D3B666F7228636F6C756D6E4E6F20696E2066297B21665B636F6C756D6E4E6F5D2E656C656D656E7449647C7C665B636F6C756D6E4E6F5D2E6C696E6B417474726962757465732626665B636F6C756D6E4E6F5D2E6C696E6B41747472696275746573';
wwv_flow_imp.g_varchar2_table(49) := '2E696E636C756465732872297C7C665B636F6C756D6E4E6F5D2E636F6C756D6E437373436C61737365732626665B636F6C756D6E4E6F5D2E636F6C756D6E437373436C61737365732E696E636C756465732872297C7C28775B665B636F6C756D6E4E6F5D';
wwv_flow_imp.g_varchar2_table(50) := '2E70726F70657274795D3D652E657874656E642821302C7B7D2C665B636F6C756D6E4E6F5D292C775B665B636F6C756D6E4E6F5D2E70726F70657274795D2E6669656C64437373436C61737365733D665B636F6C756D6E4E6F5D2E636F6C756D6E437373';
wwv_flow_imp.g_varchar2_table(51) := '436C61737365732C64656C65746520775B665B636F6C756D6E4E6F5D2E70726F70657274795D2E636F6C756D6E437373436C6173736573297D6C657420563D617065782E616374696F6E732E637265617465436F6E7465787428227265636F7264566965';
wwv_flow_imp.g_varchar2_table(52) := '77222C65282223222B6F295B305D292C523D672E636F6E6669672E746F6F6C626172436F6E662C783D6E756C6C3B696628522E73686F77262628783D652E617065782E7265636F7264566965772E636F707944656661756C74546F6F6C62617228292C63';
wwv_flow_imp.g_varchar2_table(53) := '28782C6E756C6C2C22415045582E52562E53455454494E47535F4D454E55222C6E756C6C292C522E6E617669676174696F6E427574746F6E737C7C286328782C2270726576696F75732D7265636F7264222C6E756C6C2C6E756C6C292C6328782C226E65';
wwv_flow_imp.g_varchar2_table(54) := '78742D7265636F7264222C6E756C6C2C6E756C6C292C6328782C6E756C6C2C6E756C6C2C227265636F72644E756D6265722229292C522E726F77416374696F6E427574746F6E73262628522E726F77416374696F6E427574746F6E7353656C656374696F';
wwv_flow_imp.g_varchar2_table(55) := '6E2E696E636C7564657328224144445F524F5722292626785B305D2E636F6E74726F6C732E70757368287B616374696F6E3A22696E736572742D7265636F7264222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A226963';
wwv_flow_imp.g_varchar2_table(56) := '6F6E2D69672D6164642D726F77227D292C522E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C7564657328224455504C49434154455F524F5722292626785B305D2E636F6E74726F6C732E70757368287B616374696F6E3A22';
wwv_flow_imp.g_varchar2_table(57) := '6475706C69636174652D7265636F7264222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D6475706C6963617465227D292C522E726F77416374696F6E427574746F6E7353656C656374696F6E2E69';
wwv_flow_imp.g_varchar2_table(58) := '6E636C75646573282244454C4554455F524F5722292626785B305D2E636F6E74726F6C732E70757368287B616374696F6E3A2264656C6574652D7265636F7264222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A226963';
wwv_flow_imp.g_varchar2_table(59) := '6F6E2D69672D64656C657465227D292C522E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C756465732822524546524553485F524F5722292626785B305D2E636F6E74726F6C732E70757368287B616374696F6E3A22726566';
wwv_flow_imp.g_varchar2_table(60) := '726573682D7265636F7264222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D72656672657368227D292C522E726F77416374696F6E427574746F6E7353656C656374696F6E2E696E636C75646573';
wwv_flow_imp.g_varchar2_table(61) := '28225245564552545F524F5722292626785B305D2E636F6E74726F6C732E70757368287B616374696F6E3A227265766572742D7265636F7264222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D72';
wwv_flow_imp.g_varchar2_table(62) := '6576657274227D2929292C224649454C445F47524F55505F434F4C554D4E5322213D672E636F6C756D6E734C61796F7574297B4F626A6563742E656E74726965732877292E66696C74657228285B652C695D293D3E692E67726F75704E616D65292E6C65';
wwv_flow_imp.g_varchar2_table(63) := '6E6774683E30262628522E73686F772626785B782E6C656E6774682D315D2E636F6E74726F6C732E73706C69636528312C302C7B616374696F6E3A226C696234782D746F67676C652D636F6C6C61707369626C6573222C747970653A22425554544F4E22';
wwv_flow_imp.g_varchar2_table(64) := '2C69636F6E4F6E6C793A21307D292C562E616464285B7B6E616D653A226C696234782D746F67676C652D636F6C6C61707369626C6573222C6C6162656C4B65793A224C494234582E4552562E434F4C5F4558505F475250222C6F6E4C6162656C4B65793A';
wwv_flow_imp.g_varchar2_table(65) := '224C494234582E4552562E434F4C5F475250222C6F66664C6162656C4B65793A224C494234582E4552562E4558505F475250222C69636F6E3A2266612066612D657870616E642D636F6C6C61707365222C657870616E6465643A21302C7365743A66756E';
wwv_flow_imp.g_varchar2_table(66) := '6374696F6E2869297B746869732E657870616E6465643D692C65282223222B6F2B22202E222B74292E636F6C6C61707369626C6528693F22657870616E64223A22636F6C6C6170736522297D2C6765743A66756E6374696F6E28297B72657475726E2074';
wwv_flow_imp.g_varchar2_table(67) := '6869732E657870616E6465647D7D5D29297D696628224649454C445F434F4C554D4E535F5350414E223D3D672E636F6C756D6E734C61796F757429666F7228636F6E73745B652C695D6F66204F626A6563742E656E74726965732877292E66696C746572';
wwv_flow_imp.g_varchar2_table(68) := '28285B652C695D293D3E692E656C656D656E7449642929692E6669656C64436F6C5370616E3D672E6663735F7370616E57696474683B6C6574206D3D617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E766965';
wwv_flow_imp.g_varchar2_table(69) := '77242E6772696428226F7074696F6E22292C623D7B616374696F6E73436F6E746578743A562C6D6F64656C4E616D653A617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E6D6F64656C2E6E616D652C6669656C';
wwv_flow_imp.g_varchar2_table(70) := '64733A5B775D2C6564697461626C653A6D2E6564697461626C652C6669656C6447726F7570733A6D2E636F6C756D6E47726F7570732C746F6F6C6261723A782C6175746F4164645265636F72643A6D2E6175746F4164645265636F72642C68617353697A';
wwv_flow_imp.g_varchar2_table(71) := '653A672E68617353697A652C6E6F4461746149636F6E3A6D2E6E6F4461746149636F6E2C6E6F446174614D6573736167653A6D2E6E6F446174614D6573736167652C70726F67726573734F7074696F6E733A7B66697865643A21317D2C726567696F6E53';
wwv_flow_imp.g_varchar2_table(72) := '746174696349643A692C726567696F6E446F6D49643A697D2C683D4F626A6563742E66726F6D456E7472696573285B22616C7761797345646974222C226170706C7954656D706C6174654F7074696F6E73222C22666F726D437373436C6173736573222C';
wwv_flow_imp.g_varchar2_table(73) := '226C6162656C416C69676E6D656E74222C2273686F774E756C6C4173222C22736B697044656C657465645265636F726473222C22737570707265737356616C436C6F73655175657374696F6E225D2E66696C74657228653D3E6520696E20672E636F6E66';
wwv_flow_imp.g_varchar2_table(74) := '6967292E6D617028653D3E5B652C672E636F6E6669675B655D5D29293B623D7B2E2E2E622C2E2E2E687D2C65282223222B6F292E7265636F7264566965772862293B6C657420453D617065782E726567696F6E286C292E63616C6C282267657456696577';
wwv_flow_imp.g_varchar2_table(75) := '7322292E677269642C763D452E6765744163746976655265636F726449643B452E6765744163746976655265636F726449643D66756E6374696F6E28297B6C657420693D762E6170706C7928746869732C617267756D656E7473293B72657475726E2169';
wwv_flow_imp.g_varchar2_table(76) := '262665282223222B6F292E7265636F7264566965772822696E7374616E63652229262628693D65282223222B6F292E7265636F72645669657728226765744163746976655265636F726449642229292C697D2C65282223222B6F292E697328223A766973';
wwv_flow_imp.g_varchar2_table(77) := '69626C652229262673286F293B6C657420493D562E6C6F6F6B75702822696E736572742D7265636F726422293B69662849297B6C657420693D492E616374696F6E3B492E616374696F6E3D66756E6374696F6E28297B6C657420743D65282223222B6F29';
wwv_flow_imp.g_varchar2_table(78) := '2E7265636F7264566965772822696E456469744D6F646522293B6966286928292C2174297B6C657420693D65282223222B6F292E7265636F72645669657728226765744D6F64656C22292C743D65282223222B6F292E7265636F72645669657728226765';
wwv_flow_imp.g_varchar2_table(79) := '745265636F726422293B752E7574696C2E7365745265636F72644669656C647356616C696428692C74297D7D7D6C657420433D562E6C6F6F6B757028227265766572742D7265636F726422293B69662843297B6C657420693D432E616374696F6E3B432E';
wwv_flow_imp.g_varchar2_table(80) := '616374696F6E3D66756E6374696F6E28297B6928293B6C657420743D65282223222B6F292E7265636F72645669657728226765744D6F64656C22292C6E3D65282223222B6F292E7265636F72645669657728226765745265636F726422292C723D742E67';
wwv_flow_imp.g_varchar2_table(81) := '65745265636F72644964286E292C6C3D742E6765745265636F72644D657461646174612872293B752E7574696C2E7265636F72644669656C647356616C6964286C297C7C752E7574696C2E7365745265636F72644669656C647356616C696428742C6E29';
wwv_flow_imp.g_varchar2_table(82) := '7D7D65282223222B6F292E6F6E28227265636F7264766965777265636F72646368616E6765222C66756E6374696F6E28652C69297B696628692E7265636F72644964297B6C657420653D617065782E726567696F6E286C292E63616C6C28226765745669';
wwv_flow_imp.g_varchar2_table(83) := '65777322292E677269642E6D6F64656C2C743D652E6765745265636F726428692E7265636F72644964293B69662821617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E76696577242E6772696428226F707469';
wwv_flow_imp.g_varchar2_table(84) := '6F6E22292E706167696E6174696F6E2E7363726F6C6C2626617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E6D6F64656C2E6765744F7074696F6E2822686173546F74616C5265636F7264732229297B6C6574';
wwv_flow_imp.g_varchar2_table(85) := '20693D652E696E6465784F662874292C6F3D617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E76696577242E67726964282267657450616765496E666F22293B692B313C6F2E66697273744F66667365743F6F';
wwv_flow_imp.g_varchar2_table(86) := '2E63757272656E74506167653E302626617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E76696577242E677269642822676F746F50616765222C6F2E63757272656E74506167652D31293A692B313E6F2E6C61';
wwv_flow_imp.g_varchar2_table(87) := '73744F666673657426266F2E63757272656E74506167652B313C6F2E746F74616C50616765732626617065782E726567696F6E286C292E63616C6C2822676574566965777322292E677269642E76696577242E677269642822676F746F50616765222C6F';
wwv_flow_imp.g_varchar2_table(88) := '2E63757272656E74506167652B31297D6C6574206F3D617065782E726567696F6E286C292E63616C6C282267657453656C65637465645265636F72647322293B313D3D6F3F2E6C656E67746826266F5B305D3D3D747C7C617065782E726567696F6E286C';
wwv_flow_imp.g_varchar2_table(89) := '292E63616C6C282273657453656C65637465645265636F726473222C5B745D2C21312C2130297D7D292C65282223222B6F292E6F6E282261706578626567696E7265636F726465646974222C66756E6374696F6E28692C74297B74262628742E726F7744';
wwv_flow_imp.g_varchar2_table(90) := '6174613D702E7265636F7264566965772E6765745265636F726444617461286F29292C617065782E6576656E742E747269676765722865282223222B6F292C226C696234785F6572765F726F775F696E697469616C697A6174696F6E222C74297D292C65';
wwv_flow_imp.g_varchar2_table(91) := '282223222B69292E697328223A75692D6469616C6F672229262665282223222B69292E6F6E28226469616C6F676265666F7265636C6F7365222C66756E6374696F6E2869297B6C657420743D652874686973293B696628742E64617461282263616E2D63';
wwv_flow_imp.g_varchar2_table(92) := '6C6F736522292972657475726E20742E72656D6F766544617461282263616E2D636C6F736522292C65282223222B6F292E7265636F7264566965772822736574456469744D6F6465222C2131292C21303B617065782E6576656E742E7472696767657228';
wwv_flow_imp.g_varchar2_table(93) := '65282223222B6F292C226C696234785F72765F646F5F76616C69646174655F726F7722293B6C657420723D65282223222B6F292E7265636F72645669657728226765744D6F64656C22292C6C3D65282223222B6F292E7265636F72645669657728226765';
wwv_flow_imp.g_varchar2_table(94) := '745265636F726422292C643D722E6765745265636F72644964286C293B69662821752E7574696C2E7265636F7264497356616C696428722C6429262621672E636F6E6669672E737570707265737356616C436C6F73655175657374696F6E297B6C657420';
wwv_flow_imp.g_varchar2_table(95) := '693D6528273C64697620636C6173733D22617065785F776169745F6F7665726C6179223E3C2F6469763E27292E70726570656E64546F286528222E222B6E29293B72657475726E20617065782E6D6573736167652E636F6E6669726D2828613D22515F56';
wwv_flow_imp.g_varchar2_table(96) := '414C5F4552525F434C4F53455F4449414C4F47222C617065782E6C616E672E6765744D65737361676528224C494234582E4552562E222B6129292C66756E6374696F6E2865297B692E72656D6F766528292C65262628742E64617461282263616E2D636C';
wwv_flow_imp.g_varchar2_table(97) := '6F7365222C2130292C742E6469616C6F672822636C6F73652229297D2C7B7469746C653A2256616C69646174696F6E222C7374796C653A22696E666F726D6174696F6E227D292C21317D76617220613B65282223222B6F292E7265636F72645669657728';
wwv_flow_imp.g_varchar2_table(98) := '22736574456469744D6F6465222C2131297D292C65282223222B69292E697328223A75692D6469616C6F6722297C7C65282223222B6C292E6F6E2822696E7465726163746976656772696473617665222C66756E6374696F6E28692C74297B6C6574206E';
wwv_flow_imp.g_varchar2_table(99) := '3D65282223222B6F292E7265636F72645669657728226765744D6F64656C22292C723D65282223222B6F292E7265636F72645669657728226765745265636F726422292C6C3D6E2E6765745265636F726449642872293B752E7574696C2E7265636F7264';
wwv_flow_imp.g_varchar2_table(100) := '497356616C6964286E2C6C297C7C65282223222B6F292E7265636F72645669657728227265667265736822297D297D66756E6374696F6E206628692C742C6F2C6E297B617065782E726567696F6E286F292E63616C6C2822676574566965777322292E67';
wwv_flow_imp.g_varchar2_table(101) := '7269642E76696577242E677269642822676574436F6C756D6E73222926262865282223222B74292E7265636F7264566965772822696E7374616E636522297C7C286728692C742C6F292C6E26267728742929297D65282223222B6C2B22202E612D494722';
wwv_flow_imp.g_varchar2_table(102) := '292E64617461282261706578496E74657261637469766547726964222926262267726964223D3D617065782E726567696F6E286C292E77696467657428292E696E74657261637469766547726964282267657443757272656E7456696577496422293F66';
wwv_flow_imp.g_varchar2_table(103) := '28692C6F2C6C2C2131293A65282223222B6C292E6F6E2822696E74657261637469766567726964766965776368616E6765222C66756E6374696F6E28652C74297B742626742E6372656174656426262267726964223D3D742E7669657726266628692C6F';
wwv_flow_imp.g_varchar2_table(104) := '2C6C2C2131297D292C617065782E7769646765742E7574696C2E6F6E5669736962696C6974794368616E67652865282223222B6F292C66756E6374696F6E2874297B7426262865282223222B6F292E7265636F7264566965772822696E7374616E636522';
wwv_flow_imp.g_varchar2_table(105) := '293F65282223222B6F292E7265636F7264566965772822696E7374616E636522292E70656E64696E67526566726573683F2865282223222B6F292E7265636F72645669657728227265667265736822292C73286F292C77286F29293A77286F293A736574';
wwv_flow_imp.g_varchar2_table(106) := '54696D656F75742828293D3E7B6628692C6F2C6C2C2130297D2C313029297D297D2C676F746F494753656C65637465645265636F72643A772C6F70656E526F77566965773A66756E6374696F6E2869297B6C657420743D692B6C3B65282223222B74292E';
wwv_flow_imp.g_varchar2_table(107) := '7265636F7264566965772822696E7374616E6365222926262865282223222B74292E7265636F72645669657728226F7074696F6E222C226564697461626C6522293F6728692C2130293A66286929297D2C736574456469744D6F64653A672C6F70656E52';
wwv_flow_imp.g_varchar2_table(108) := '6567696F6E3A662C6869646547726F75703A66756E6374696F6E28742C6E297B6C657420723D65282223222B742B22202E222B692B222023222B6E2B225F434F4E5441494E455222293B722E636C6F7365737428222E222B6F292E6869646528292C722E';
wwv_flow_imp.g_varchar2_table(109) := '636C6F7365737428222E752D466F726D22292E6869646528297D7D7D28292C753D7B7574696C3A7B7265636F72644669656C647356616C69643A66756E6374696F6E2865297B6C657420693D21303B69662865297B6C657420743D652E6669656C64733B';
wwv_flow_imp.g_varchar2_table(110) := '6966287429666F7228636F6E7374206520696E207429696628745B655D2E6572726F72297B693D21313B627265616B7D7D72657475726E20697D2C7265636F7264497356616C69643A66756E6374696F6E28652C69297B6C657420743D652E6765745265';
wwv_flow_imp.g_varchar2_table(111) := '636F72644D657461646174612869293B72657475726E21742E6572726F722626746869732E7265636F72644669656C647356616C69642874297D2C7365745265636F72644669656C647356616C69643A66756E6374696F6E28652C69297B6C657420743D';
wwv_flow_imp.g_varchar2_table(112) := '652E6765745265636F726449642869292C6F3D652E6765745265636F72644D657461646174612874293B6966286F297B6C657420693D6F2E6669656C64733B6966286929666F7228636F6E7374206F20696E206929695B6F5D2E6572726F722626652E73';
wwv_flow_imp.g_varchar2_table(113) := '657456616C6964697479282276616C6964222C742C6F297D7D7D7D2C703D7B6974656D3A7B6765744E617469766556616C75653A66756E6374696F6E2865297B6C657420693D6E756C6C3B696628224E554D424552223D3D652E6974656D5F7479706529';
wwv_flow_imp.g_varchar2_table(114) := '693D652E6765744E617469766556616C756528292C69734E614E286929262628693D6E756C6C293B656C736520696628225145223D3D652E6974656D5F747970657C7C225745223D3D652E6974656D5F747970657C7C225A45223D3D652E6974656D5F74';
wwv_flow_imp.g_varchar2_table(115) := '7970657C7C22444154455F5049434B4552223D3D652E6974656D5F747970657C7C22412D444154452D5049434B4552223D3D652E6E6F64653F2E6E6F64654E616D65297472797B693D617065782E646174652E706172736528652E67657456616C756528';
wwv_flow_imp.g_varchar2_table(116) := '292C746869732E67657444617465466F726D6174286529297D63617463682865297B7D656C736520693D652E67657456616C756528293B72657475726E20697D7D2C7265636F7264566965773A7B6765745265636F7264446174613A66756E6374696F6E';
wwv_flow_imp.g_varchar2_table(117) := '2869297B6C657420743D65282223222B69292C6F3D6E756C6C3B696628742E7265636F72645669657728226765744163746976655265636F726449642229297B6F3D7B7D3B6C657420653D742E7265636F72645669657728226765744669656C64732229';
wwv_flow_imp.g_varchar2_table(118) := '3B666F72286669656C64206F662065296669656C642E656C656D656E7449642626617065782E6974656D732E6861734F776E50726F7065727479286669656C642E656C656D656E744964292626286F5B6669656C642E656C656D656E7449645D3D702E69';
wwv_flow_imp.g_varchar2_table(119) := '74656D2E6765744E617469766556616C756528617065782E6974656D286669656C642E656C656D656E7449642929297D72657475726E206F7D7D7D3B72657475726E7B5F696E69743A66756E6374696F6E28692C742C6F2C722C752C702C662C772C5629';
wwv_flow_imp.g_varchar2_table(120) := '7B617065782E6C616E672E6164644D65737361676573287B224C494234582E4552562E434F4C5F4558505F475250223A22436F6C6C617073652F457870616E642047726F757073222C224C494234582E4552562E434F4C5F475250223A22436F6C6C6170';
wwv_flow_imp.g_varchar2_table(121) := '73652047726F757073222C224C494234582E4552562E4558505F475250223A22457870616E642047726F757073222C224C494234582E4552562E515F56414C5F4552525F434C4F53455F4449414C4F47223A2244617461206861732076616C6964617469';
wwv_flow_imp.g_varchar2_table(122) := '6F6E206572726F72732E20436C6F7365204469616C6F673F227D293B6C657420523D692B6C3B615B525D3D742C635B745D3D692C65282223222B69292E616464436C617373286E292C75262665282223222B69292E616464436C61737328226C69623478';
wwv_flow_imp.g_varchar2_table(123) := '2D666F726D2D6C6162656C2D77696474682D222B75292C65282223222B69292E686173436C6173732822742D447261776572526567696F6E2229262665282223222B69292E686173436C6173732822742D4469616C6F67526567696F6E2D2D6E6F506164';
wwv_flow_imp.g_varchar2_table(124) := '64696E672229262665282223222B69292E72656D6F7665436C6173732822742D4469616C6F67526567696F6E2D2D6E6F50616464696E6722292E616464436C6173732822742D447261776572526567696F6E2D2D6E6F50616464696E6722293B6C657420';
wwv_flow_imp.g_varchar2_table(125) := '783D7B7D3B56262628783D562878297C7C7B7D292C782E746F6F6C626172436F6E663D773B6C6574206D3D7B7D3B6D2E636F6E6669673D782C6D2E636F6C756D6E734C61796F75743D6F7C7C224E4F4E45222C224649454C445F434F4C554D4E535F5350';
wwv_flow_imp.g_varchar2_table(126) := '414E223D3D6F2626286D2E6663735F7370616E57696474683D723F7061727365496E742872293A36292C6D2E68617353697A653D225922213D702626662C645B525D3D6D2C617065782E726567696F6E2E63726561746528692C7B747970653A22494745';
wwv_flow_imp.g_varchar2_table(127) := '787465726E616C526F7756696577222C706172656E74526567696F6E49643A742C67657453657373696F6E53746174653A66756E6374696F6E2865297B72657475726E20617065782E726567696F6E2874292E67657453657373696F6E53746174652865';
wwv_flow_imp.g_varchar2_table(128) := '297D2C7769646765743A66756E6374696F6E28297B72657475726E2065282223222B52297D2C726566726573683A66756E6374696F6E28297B65282223222B52292E7265636F7264566965772822676574416374696F6E7322292E696E766F6B65282272';
wwv_flow_imp.g_varchar2_table(129) := '6566726573682D7265636F726422297D2C666F6375733A66756E6374696F6E28297B65282223222B52292E7265636F7264566965772822666F63757322297D7D292C732E696E6974494728742C692C52292C672E696E6974525628692C522C74297D2C6F';
wwv_flow_imp.g_varchar2_table(130) := '70656E526F77566965773A672E6F70656E526F77566965772C6869646547726F75703A672E6869646547726F75707D7D28617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(16598201315192087932)
,p_plugin_id=>wwv_flow_imp.id(16569484616163898440)
,p_file_name=>'js/ig-externalrowview.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
