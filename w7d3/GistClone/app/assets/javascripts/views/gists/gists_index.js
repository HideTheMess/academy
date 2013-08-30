GistClone.Views.GistsIndex = Backbone.View.extend({
  template: JST['gists/index'],

  render: function () {
    var dat = this;

    this.$el.html(JST['gists/index']({
      gists: dat.collection
    }));

    return this;
  }
});
