$(function() {

    $('#ghapidata').html('<div id="loader"><img src="css/loader.gif" alt="loading..."></div>');

    var username = "danog";
    var requri = 'https://api.github.com/users/' + username;
    var repouri = 'https://api.github.com/users/' + username + '/repos';

    requestJSON(requri, function(json) {
        if (json.message == "Not Found" || username == '') {
            $('#ghapidata').html("<h2>No User Info Found</h2>");
        } else {
            // else we have a user and we display their info
            var fullname = json.name;
            var username = json.login;
            var aviurl = json.avatar_url;
            var profileurl = json.html_url;
            var location = json.location;
            var followersnum = json.followers;
            var followingnum = json.following;
            var reposnum = json.public_repos;

            if (fullname == undefined) {
                fullname = username;
            }

            var outhtml = '<h2>' + fullname + ' <span class="smallname">(@<a href="' + profileurl + '" target="_blank">' + username + '</a>)</span></h2>';
            outhtml = outhtml + '<div class="ghcontent"><div class="avi"><a href="' + profileurl + '" target="_blank"><img src="' + aviurl + '" width="80" height="80" alt="' + username + '"></a></div>';
            outhtml = outhtml + '<p>Followers: ' + followersnum + ' - Following: ' + followingnum + '<br>Repos: ' + reposnum + '</p></div>';
            outhtml = outhtml + '<div class="repolist clearfix">';

            var repositories;
            $.getJSON(repouri, function(json) {
                repositories = json;
                outputPageContent();
            });

            function outputPageContent() {
                if (repositories.length == 0) {
                    outhtml = outhtml + '<p>No repos!</p></div>';
                } else {
                    outhtml = outhtml + '<p><strong>Repos List:</strong></p> <ul>';
                    $.each(repositories, function(index) {
                        if (repositories[index].fork === false && (repositories[index].name != "video-dl" || repositories[index].name != "gigaclone" || repositories[index].name != "php-login-freelancer" || repositories[index].name != "learn-bash")) {
                            outhtml = outhtml + '<li><a href="https://daniil.it/' + repositories[index].name + '" target="_blank">' + repositories[index].name + ' - ' + repositories[index].description + '</a></li>';
                        }
                    });
                    outhtml = outhtml + '</ul></div>';
                }
                $('#ghapidata').html(outhtml);
            } // end outputPageContent()
        } // end else statement
    }); // end requestJSON Ajax call

    $("#contactForm input,#contactForm textarea").jqBootstrapValidation({
        preventSubmit: true,
        submitError: function($form, event, errors) {
            // additional error messages or events
        },
        submitSuccess: function($form, event) {
            // Prevent spam click and default submit behaviour
            $("#btnSubmit").attr("disabled", true);
            event.preventDefault();

            // get values from FORM
            var name = $("input#name").val();
            var email = $("input#email").val();
            var phone = $("input#phone").val();
            var message = $("textarea#message").val();
            var domain = "1";
            var firstName = name; // For Success/Failure Message
            // Check for white space in name for Success/Fail message
            if (firstName.indexOf(' ') >= 0) {
                firstName = name.split(' ').slice(0, -1).join(' ');
            }
            $.ajax({
                url: "https://mail.daniil.it/",
                type: "POST",
                data: {
                    name: name,
                    phone: phone,
                    email: email,
                    message: message,
                    domain: domain
                },
                cache: false,
                success: function(data) {
                    $("#btnSubmit").attr("disabled", false);
                    if (data == "ok") {
                        // Success message
                        $('#success').html("<div class='alert alert-success'>");
                        $('#success > .alert-success').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                            .append("</button>");
                        $('#success > .alert-success')
                            .append("<strong>The message has been sent. </strong>");
                        $('#success > .alert-success')
                            .append('</div>');
                        //clear all fields
                        $('#contactForm').trigger("reset");
                    } else {
                        // Fail message
                        $('#success').html("<div class='alert alert-danger'>");
                        $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                            .append("</button>");
                        $('#success > .alert-danger').append("<strong>Sorry " + firstName + ", it looks like an error occurred. Please try again later!</strong>");
                        $('#success > .alert-danger').append('</div>');
                        //clear all fields
                        $('#contactForm').trigger("reset");
                    }
                },
                error: function() {
                    $("#btnSubmit").attr("disabled", false);
                    // Fail message
                    $('#success').html("<div class='alert alert-danger'>");
                    $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                        .append("</button>");
                    $('#success > .alert-danger').append("<strong>Sorry " + firstName + ", it looks like an error occurred. Please try again later!</strong>");
                    $('#success > .alert-danger').append('</div>');
                    //clear all fields
                    $('#contactForm').trigger("reset");
                },
            })
        },
        filter: function() {
            return $(this).is(":visible");
        },
    });

    $("a[data-toggle=\"tab\"]").click(function(e) {
        e.preventDefault();
        $(this).tab("show");
    });
});

// When clicking on Full hide fail/success boxes
$('#name').focus(function() {
    $('#success').html('');
});

function requestJSON(url, callback) {
    $.ajax({
        url: url,
        complete: function(xhr) {
            callback.call(null, xhr.responseJSON);
        }
    });
}