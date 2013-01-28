function createNamespace (namespace, context) {
    return namespace[context] || (namespace[context] = {});
}

newsletter = {
    namespace: function (namespace) {
        return _.reduce(namespace.split('.'), createNamespace, this);
    },

    init: function () {
        newsletter.Helpers.activeNavigationItem();
        hljs.initHighlightingOnLoad();
    }
};
