// 画面上部にスクロールするボタン
$(function() {
    var pageTop = $('.btn-pagetop');
    pageTop.hide();
    $(window).scroll(function() {
        if ($(this).scrollTop() > 600) {
            pageTop.fadeIn();
        } else {
            pageTop.fadeOut();
        }
    });
    pageTop.click(function() {
        $('body, html').animate({
            scrollTop: 0
        }, 500, 'swing');
        pageTop.blur();
        return false;
    });
});
