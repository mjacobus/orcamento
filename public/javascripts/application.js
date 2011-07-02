// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function() {
	if ($('.edit_movimento, .new_movimento').length) {
		$('label[for=movimento_data_prevista]').parent().append('<a href="#" id="copy_data_prevista_to_realizada" >Copiar</a>')
	}
	
	$('a#copy_data_prevista_to_realizada').live('click',function(){
		$('#movimento_data_realizacao_1i').val($('#movimento_data_prevista_1i').val());
		$('#movimento_data_realizacao_2i').val($('#movimento_data_prevista_2i').val());
		$('#movimento_data_realizacao_3i').val($('#movimento_data_prevista_3i').val());
		return false;
	});
});