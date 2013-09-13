window.GistClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($rootEl) {
    var dat = this;

    var start = function () {
      $.ajax({
        url: 'gists#index',
        type: 'GET',
        success: function (data) {
          console.log(JSON.parse(data));
        }
      });
    };

    start();

    new GistClone.Collections.Gists().fetch({
      success: function (gists) {
        console.log(JSON.parse(gists));
        // new dat.Routers.Gists($rootEl, gists);
        // Backbone.history.start();
      },

      error: function (data) {
        alert('Did not fetch Gists');
      }
    });

    // new dat.Routers.Gists($rootEl, gists);
    // Backbone.history.start();
  }
};