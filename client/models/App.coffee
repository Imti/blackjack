#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'bust', =>
      alert "Bust!"

    (@get 'playerHand').on 'stand', =>
      (@get 'dealerHand').models[0].flip()
      (@get 'dealerHand').dealerPlay();

    (@get 'dealerHand').on 'gameEnd', =>
      alert "Game has ended"
