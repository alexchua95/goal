function ready() {
    $('.welcome-carousel').slick({
        dots: true,
        arrows: false
    });
    $('.form_datetime').datetimepicker({

    });
    $('.form_time').datetimepicker({
        format: 'LT',
        stepping: 30
    });
}

$(document).on('page:change', ready)

