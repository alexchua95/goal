function ready() {
    $('.welcome-carousel').slick({
        dots: true,
        arrows: false
    });
    $('.form_datetime').datetimepicker({

    });
}

$(document).on('page:change', ready)

