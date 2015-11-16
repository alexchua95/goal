function ready() {
    $('.welcome-carousel').slick({
        dots: true,
        arrows: false
    });
}

$(document).on('page:change', ready)
