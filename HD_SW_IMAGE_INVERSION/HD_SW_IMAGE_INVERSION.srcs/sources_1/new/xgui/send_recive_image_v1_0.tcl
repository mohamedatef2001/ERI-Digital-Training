# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA__WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA__WIDTH { PARAM_VALUE.DATA__WIDTH } {
	# Procedure called to update DATA__WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA__WIDTH { PARAM_VALUE.DATA__WIDTH } {
	# Procedure called to validate DATA__WIDTH
	return true
}


proc update_MODELPARAM_VALUE.DATA__WIDTH { MODELPARAM_VALUE.DATA__WIDTH PARAM_VALUE.DATA__WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA__WIDTH}] ${MODELPARAM_VALUE.DATA__WIDTH}
}

