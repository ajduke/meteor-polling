Poll = new Mongo.Collection('poll')

if Meteor.isClient
  Template.form.events(
    'submit form': (e, template)->
      e.preventDefault()
      question= $('textarea').val()
      ch1= $('#choice1').val()
      ch2= $('#choice2').val()

      # actually insert the form
      Poll.insert({question:question, choice1: {text: ch1, score:0}, choice2: {text: ch2, score:0}})
      # reset the form
      event.target.reset()
  )

  Template.grid.helpers(
    poll: ()->
      Poll.find()

#    get_score:(id)->
#      p= Poll.findOne(@_id)
#      console.log 'get '  + JSON.stringify p
#      total= p['choice1'].score + p['choice2'].score
#      current = p['choice' + id ].score
#      return (current/total * 100).toFixed(2)

  )

  Template.grid.events(
    'click .ch-btn': (e)->
      choice_id= $(e.currentTarget).data('choice-id')
      act= {}
      act['choice'+choice_id+".score"]=1
      Poll.update({_id: @_id}, {$inc:act})
  )




if Meteor.isServer
  console.log ''
