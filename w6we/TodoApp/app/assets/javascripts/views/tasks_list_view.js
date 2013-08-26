TD.Views.TasksListView = Backbone.View.extend({
  initialize: function () {
    var that = this;

    var renderCallback = this.render.bind(that);
    this.listenTo(that.collection, 'add', renderCallback);
    this.listenTo(that.collection, 'change', renderCallback);
    this.listenTo(that.collection, 'remove', renderCallback);
  },

  render: function () {
    var that = this;

    var renderedContent = JST['tasks/list']({
      tasks: that.collection
    });

    this.$el.html(renderedContent);
    return this;
  }
});