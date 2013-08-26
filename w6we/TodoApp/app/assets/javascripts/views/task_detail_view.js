TD.Views.TaskDetailView = Backbone.View.extend({
  render: function () {
    var that = this;

    var renderedContent = JST['tasks/detail']({
      task: that.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});