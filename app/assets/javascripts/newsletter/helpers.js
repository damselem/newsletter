newsletter.Helpers = {
    activeNavigationItem: function () {
        var path = window.location.pathname;
        $('#header').find("a[href='"+ path + "']").parent().addClass('active');
    }
};
