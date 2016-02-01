function welcomeIndex() {
    function init() {
        $('.welcome-carousel').slick({
            dots: true,
            arrows: false,
            infinite: false
        });
    }

    $('.landing_other_skills input').tagsinput({
        tagClass: function(item) {
            return 'label label-success'
        }
    });

    init()
}

function skillsNew() {
    $('.skill-types-carousel').slick({
        dots: false,
        arrows: true,
        slidesToShow: 3,
        slidesToScroll: 1
    });

    function setSkill(name, id) {
        $('.skill_skill_type_name p.help-block').text("");
        $('.skill_skill_type_name').removeClass('has-error');
        $('#skill_skill_type_name').val(name);
        $('#skill_skill_type_id').val(id);
        var index = _.indexOf(_.pluck(skillTypes,'id'), id);
        $('.skill-types-carousel').slick('slickGoTo', index, false);

    }

    $('.skill-types-select').on("click", function (event) {
        var el = $(event.currentTarget);
        var skillTypeId = el.attr('skill-type-id');
        var skillTypeName = el.attr('skill-type-name');
        console.log(event)
        console.log(skillTypeName)
        setSkill(skillTypeName, skillTypeId);
    });

    var skillTypes = []

    $.ajax({
        url: "/skill_types",
        beforeSend: function( xhr ) {
            //xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
        }
    })
        .done(function( data ) {
            skillTypes = data.skill_types


            function getMatches(skill_types, substring) {
                var matches = _.filter(
                    skill_types,
                    function( skill_type ) { return skill_type.name.toLowerCase().indexOf(substring.toLowerCase()) !== -1; }
                );
                return matches
            };
            $("#skill_skill_type_name").
                typeahead({
                source: function (query, process) {
                    process(getMatches(skillTypes, query))
                },
                displayText: function(item) {
                    return item.name
                },
                updater: function (item) {
                    setSkill(item.name, item.id)
                    return item.name;
                }
            })
                .on("blur", function (event) {
                    var el = $(event.target);
                    var value = el.val();
                    var matches = getMatches(skillTypes, value);
                    if (matches.length == 0) {
                        $('.skill_skill_type_name p.help-block').text("Sorry, we currently don't support \""+ value +"\" as a skill.")
                        $('#skill_skill_type_id').val(null);
                        $('.skill_skill_type_name').addClass('has-error');
                    } else {
                        var skill = matches[0];
                        setSkill(skill.name, skill.id);
                    }
                });
        });

    $('#skill_rate').on("blur", function (event) {
        var el = $(event.target);
        var value = el.val();
        var rate = parseInt(value);
        if (rate) {
            $(event.target).val(rate);
            $('.skill_rate p.help-block').text("");
            $('.skill_rate').removeClass('has-error');
        } else {
            $(event.target).val(null);
            $('.skill_rate p.help-block').text("Please enter a valid rate.");
            $('.skill_rate').addClass('has-error');
        }
    });
}

function requestsNew() {
    $('.form_datetime').datetimepicker({
        sideBySide: true,
        allowInputToggle: true,
        format: 'llll'
    });

    $('#request_rate').on("blur", function (event) {
        var el = $(event.target);
        var value = el.val();
        var rate = parseInt(value);
        if (rate) {
            $(event.target).val(rate);
            $('.request_rate p.help-block').text("");
            $('.request_rate').removeClass('has-error');
        } else {
            $(event.target).val(null);
            $('.request_rate p.help-block').text("Please enter a valid rate.");
            $('.request_rate').addClass('has-error');
        }
    });

    $('#request_length').on("blur", function (event) {
        var el = $(event.target);
        var value = el.val();
        var length = parseFloat(value);

        var roundHalf = function(n) {
            return (Math.round(n*2)/2).toFixed(1);
        };

        if (length) {
            $(event.target).val(roundHalf(length));
            $('.request_length p.help-block').text("");
            $('.request_length').removeClass('has-error');
        } else {
            $(event.target).val(null);
            $('.request_length p.help-block').text("Please enter a valid duration.");
            $('.request_length').addClass('has-error');
        }
    });
}

function usersShow() {

    function init() {
        console.log("init")
        $('.form_time')
            .datetimepicker({
                allowInputToggle: true,
                format: 'LT',
                stepping: 30
            });
        $('.form_time input').on("blur", function (event) {
            var el = $(event.target);
            var hourId = el.attr('hour-id')
            $('#edit_hour_' + hourId).submit()
        });
        $( "#hour_day" ).change( function() {
            var hourId = $(this).attr('hour-id')
            $('#edit_hour_' + hourId).submit()
        });

        var map;
        if (document.getElementById('map')) {
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: -34.397, lng: 150.644},
                zoom: 15
            });
        }

        var marker = new google.maps.Marker({
            position: {lat: -34.397, lng: 150.644},
            map: map,
            title: 'Restaurant Location'
        });

        function setPosition(latitude, longitude) {
            $('#location_latitude').val(latitude);
            $('#location_longitude').val(longitude)
            map.setCenter(new google.maps.LatLng(latitude, longitude));
            marker.setPosition(new google.maps.LatLng(latitude, longitude));
        }

        var latitude = $('#location_latitude').val();
        var longitude = $('#location_longitude').val();

        setPosition(latitude, longitude);

        var service = new google.maps.places.AutocompleteService();
        var geocoder = new google.maps.Geocoder();
        $("#location_address").typeahead({
            source: function(query, process) {
                service.getPlacePredictions({ input: query }, function(predictions, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        process($.map(predictions, function(prediction) {
                            return prediction.description;
                        }));
                    }
                });
            },
            updater: function (item) {
                geocoder.geocode({ address: item }, function(results, status) {
                    if (status != google.maps.GeocoderStatus.OK) {
                        setPosition(null, null);
                        return;
                    }
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();
                    setPosition(latitude, longitude);
                    $('#new_location').submit()
                    $('.edit_location').submit()
                });
                return item;
            }
        });
    }

    init();

    var bindingFunction = function(event, data, status, xhr) {
        $('.profile').remove();
        $(data.partial).appendTo(".user");
        init();
        $(".new_hour").bind("ajax:success", bindingFunction);
        $(".edit_hour").bind("ajax:success", bindingFunction);
        $(".new_location").bind("ajax:success", bindingFunction);
        $(".edit_location").bind("ajax:success", bindingFunction);
    }

    $(".new_hour").bind("ajax:success", bindingFunction);
    $(".edit_hour").bind("ajax:success", bindingFunction);
    $(".new_location").bind("ajax:success", bindingFunction);
    $(".edit_location").bind("ajax:success", bindingFunction);
}

function ready() {
    welcomeIndex();
    skillsNew();
    requestsNew();
    usersShow();
    console.log("ready")
}

$(document).on('page:change', ready)

