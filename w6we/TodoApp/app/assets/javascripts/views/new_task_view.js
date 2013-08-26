TD.Views.NewTaskView = Backbone.View.extend({
  events: {
    'click button.submit': 'submit'
  },

  render: function () {
    var renderedContent = JST['tasks/new']();
    this.$el.html(renderedContent);
    return this;
  },

  submit: function () {
    var that = this;

    var task = new TD.Models.Task({
      title: that.$('input[name=task\\[title\\]]').val()
    });

    this.collection.add(task);
    task.save();
    Backbone.history.navigate('#/');
  }
})