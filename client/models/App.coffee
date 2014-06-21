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
      playerScore = (@get 'playerHand').endScore()
      dealerScore = (@get 'dealerHand').endScore()
      console.log playerScore
      console.log dealerScore
      if dealerScore > 21
        alert "You win"
      else
        if playerScore > dealerScore then alert "You win!"
        if playerScore < dealerScore then alert "You lose!"
        if playerScore == dealerScore then alert "Draw!"
