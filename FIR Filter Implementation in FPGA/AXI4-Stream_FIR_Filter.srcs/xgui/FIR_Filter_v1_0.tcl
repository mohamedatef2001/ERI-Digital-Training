# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_INPUT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA__OUTPUT" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA_INPUT { PARAM_VALUE.DATA_INPUT } {
	# Procedure called to update DATA_INPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_INPUT { PARAM_VALUE.DATA_INPUT } {
	# Procedure called to validate DATA_INPUT
	return true
}

proc update_PARAM_VALUE.DATA__OUTPUT { PARAM_VALUE.DATA__OUTPUT } {
	# Procedure called to update DATA__OUTPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA__OUTPUT { PARAM_VALUE.DATA__OUTPUT } {
	# Procedure called to validate DATA__OUTPUT
	return true
}


proc update_MODELPARAM_VALUE.DATA_INPUT { MODELPARAM_VALUE.DATA_INPUT PARAM_VALUE.DATA_INPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_INPUT}] ${MODELPARAM_VALUE.DATA_INPUT}
}

proc update_MODELPARAM_VALUE.DATA__OUTPUT { MODELPARAM_VALUE.DATA__OUTPUT PARAM_VALUE.DATA__OUTPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA__OUTPUT}] ${MODELPARAM_VALUE.DATA__OUTPUT}
}

