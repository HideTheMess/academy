GistClone.Views.GistDetail = Backbone.View.extend({
  events: {
    'click button.favorite': 'toggleFavorite'
  };

  template: JST['gists/show'],

  render: function () {
    var dat = this;

    this.$el.html(JST['gists/show']({
      gist: dat.model
    }));

    return this;
  },

  toggleFavorite: function () {

  }
});