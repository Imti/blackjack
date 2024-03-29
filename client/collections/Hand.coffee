class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: =>
      @add(@deck.pop()).last()
      @calculateScore()

  stand: =>
      @playerScore = (do @scores)[0]
      alert "Dealer's Turn"
      @trigger('stand', @)

  calculateScore: =>
    if (do @scores).length == 2

      if (do @scores)[0] > 21 && (do @scores)[1] > 21
        @trigger('bust', @)    

    else

      if (do @scores)[0] > 21
        @trigger('bust', @)

  dealerPlay: =>
    if (do @scores).length == 2

      while (do @scores)[0] < 17 || (do @scores)[1] < 17
        @add(@deck.pop()).last()

    else

      while (do @scores)[0] < 17
        @add(@deck.pop()).last()

    @dealerScore = (do @scores)[0]
    @trigger('gameEnd', @)

  endScore: =>
    @finalScore = 0

    if (do @scores).length == 1
      @finalScore = (do @scores)[0]

    else if (do @scores).length == 2

      if (do @scores)[0] > 22
        if (do @scores)[1] > 22
          @finalScore = (do @scores)[0]
        else
          @finalScore = (do @scores)[1]

      else 

        if (do @scores)[1] < 22 and (do @scores)[1] > (do @scores)[0]
          @finalScore = (do @scores)[1]

        else
          @finalScore = (do @scores)[0]

    @finalScore





  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
