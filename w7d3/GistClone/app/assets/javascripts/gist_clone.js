window.GistClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($rootEl) {
    var dat = this;

    var gists = new GistClone.Collections.Gists().fetch({
      success: function (gists) {
        new dat.Routers.Gists($rootEl, gists);
        Backbone.history.start();
      },

      error: function (data) {
        alert('Did not fetch Gists');
      }
    });
  }
};