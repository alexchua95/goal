function welcomeIndex() {
    $('.welcome-carousel').slick({
        dots: true,
        arrows: false
    });
}

function skillsNew() {
    $('.skill-types-carousel').slick({
        dots: false,
        arrows: true,
        slidesToShow: 3,
        slidesToScroll: 1
    });

    function setSkill(name, id) {
        $('#skill_skill_type_name').val(name);
        $('#skill_skill_type').val(id);
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
            var getMatches = function(skill_types, substring) {
                var matches = _.filter(
                    skill_types,
                    function( skill_type ) { return skill_type.name.toLowerCase().indexOf(substring.toLowerCase()) !== -1; }
                );
                return matches
            };
            $("#skill_skill_type_name").typeahead({
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
        });
}

function requestsNew() {
    $('.form_datetime').datetimepicker({

    });
}

function usersShow() {

    function init() {
        console.log("init")
        $('.form_time')
            .datetimepicker({
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
        //var latitude = $('.user-latitude').val()
        //var longitude = $('.user-longitude').val()
        //map.setCenter(new google.maps.LatLng(latitude, longitude));
        //marker.setPosition(new google.maps.LatLng(latitude, longitude));
    }

    init();

    var bindingFunction = function(event, data, status, xhr) {
        $('.profile').remove();
        $(data.partial).appendTo(".user");
        init();
        $(".edit_hour").bind("ajax:success", bindingFunction);
        $(".new_hour").bind("ajax:success", bindingFunction);
    }

    $(".new_hour").bind("ajax:success", bindingFunction);
    $(".edit_hour").bind("ajax:success", bindingFunction);
}

function ready() {
    welcomeIndex();
    skillsNew();
    requestsNew();
    usersShow();
    console.log("ready")
}

$(document).on('page:change', ready)

