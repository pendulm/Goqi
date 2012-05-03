$(document).ready ->
    $("#check_email_available").click ->
        email = $("#user_email").val().trim();
        $.ajax
            url:'/users/check_email_available?email=' + email
            dataType: 'json'
            success: (result) ->
                $("#show_check_result").html(if result then "\u2713" else "\u2717")
                .css "color", if result then "green" else "red"
