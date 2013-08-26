window.TD = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($sidebar, $content, tasksData) {
    var tasks = new TD.Collections.Tasks(tasksData);

    this.installSidebar($sidebar, tasks);

    // Startup a router
    new TD.Routers.TasksRouter($content, tasks);
    // Begin listening for navigation events
    Backbone.history.start();
  },

  installSidebar: function ($sidebar, tasks) {
    var tasksListView = new TD.Views.TasksListView({
      collection: tasks
    });

    $sidebar.html(tasksListView.render().$el);
  }
};