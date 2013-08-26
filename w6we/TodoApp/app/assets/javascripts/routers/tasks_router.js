TD.Routers.TasksRouter = Backbone.Router.extend({
  initialize: function ($rootEl, tasks) {
    this.$rootEl = $rootEl;
    this.tasks = tasks;
  },

  routes: {
    '': 'index',
    'tasks/new': 'new',
    'tasks/:id': 'show'
  },

  index: function () {
    this.$rootEl.empty();
  },

  new: function () {
    var that = this;

    var newTaskView = new TD.Views.NewTaskView({
      collection: that.tasks
    });
    this.$rootEl.html(newTaskView.render().$el);
  },

  show: function (id) {
    var that = this;

    var task = this.tasks.get(id);
    var taskDetailView = new TD.Views.TaskDetailView({
      model: task
    });

    this.$rootEl.html(taskDetailView.render().$el);
  }
});