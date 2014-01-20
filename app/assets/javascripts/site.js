$(document).ready(function() {
  supports_placeholder = check_supports_placeholder();
  initialize_form_values();
})

var supports_placeholder = false;

function check_supports_placeholder() {
	var placeholder_test = document.createElement('input');
	if('placeholder' in placeholder_test) {
		supports_placeholder = true;
		return supports_placeholder;
	}
}

function initialize_form_values() {
	if (!supports_placeholder) {
		form_input_fields = $("input[type='text'], textarea");
		form_input_fields_length = form_input_fields.length;
		for (i = 0; i <= form_input_fields_length; i++) {
      if ($(form_input_fields[i]).val() == "" || $(form_input_fields[i]).val() == $(form_input_fields[i]).attr("placeholder")) {
        $(form_input_fields[i]).css("color", "#999999");
//        $(form_input_fields[i]).prop("type", "text");
//        $(form_input_fields[i]).attr("type", "text");
        $(form_input_fields[i]).val($(form_input_fields[i]).attr("placeholder"));
        $(form_input_fields[i]).focus(function() {
          if ($(this).val() == $(this).attr("placeholder")) {
            $(this).val("");
          }
        });
        $(form_input_fields[i]).blur(function() {
          if ($(this).val() == "") {
            $(this).val($(this).attr("placeholder"));
          }
        });
      }
		}
    password_field = $("input[type='password']");
    if (password_field) {
      var msg = "<div>" + password_field.attr("placeholder") + "</div>";
      password_field.before(msg);
    }
	}
}