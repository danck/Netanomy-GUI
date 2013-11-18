// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// jQuery(document).ready(function() {
  
//   //definitions

//   var source = new EventSource('/realtime/comments');

//   var template = _.template($("#comment_template").html());

//   var App = Backbone.View.extend({
    
//     events: {
//       'click #see_newer': 'seeNewComments'
//     },

//     new_comment: function(){
//       this.$el.find('#see_newer').show().html('See '+this.collection.length+' new comment(s)')
//     },

//     seeNewComments: function(){
//       this.collection.each(_.bind(function(model){
//         var html = template(model.toJSON());
//         this.$el.find('#comments_container').append(html);
//       },this));
//       this.clear();
//     },

//     clear: function(){
//       this.collection.reset();
//       this.$el.find('#see_newer').hide();
//     }

//   });

//   //instances

//   var newCommentCollection = new Backbone.Collection([]);
//   var appInstance = new App({el: $('#comment_app'), collection: newCommentCollection})

//   //listeners

//   newCommentCollection.on('add', function(model){
//     appInstance.new_comment();
//   });

//   source.addEventListener('new', function(e) {
//     data = $.parseJSON(e.data);
//     var comment = new Backbone.Model({title: data.title, content: data.content});
//     newCommentCollection.add(comment);
//   });

// });