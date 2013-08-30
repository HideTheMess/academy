GistClone.Routers.Gists = Backbone.Router.extend({
  initialize: function ($rootEl, gists) {
    this.$rootEl = $rootEl;
    this.gists = gists;
  },

  routes: {
    '': 'index',
    'gists/:id': 'show'
  },

  index: function () {
    var dat = this;

    var gistsIndex = new GistClone.Views.GistsIndex({
      collection: dat.gists
    });

    this.$rootEl.append(gistsIndex.render().$el);
  },

  show: function (id) {
    var dat = this;

    var gistDetail = new GistClone.Views.GistDetail({
      model: dat.gists.get(id)
    })

    this.$rootEl.append(gistDetail.render().$el);
  }
});
