function show() {

    function init() {
        $('.form_time')
            .datetimepicker({
                format: 'LT',
                stepping: 30
            })
        $('.form_time input').on("blur", function (event) {
            var el = $(event.target);
            var hourId = el.attr('hour-id')
            $('#edit_hour_' + hourId).submit()
        });
        $( "#hour_day" ).change( function() {
            var hourId = $(this).attr('hour-id')
            $('#edit_hour_' + hourId).submit()
        });
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

$(document).on('page:change', show)