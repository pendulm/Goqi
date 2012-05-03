$(document).ready(function() {
    $("#check_email_available").click(function() {
        var email = $("#user_email").val().trim();
        $.ajax({url:'/users/check_email_available?email=' + email, dataType: 'script'})
    });
});
