defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Returns a list of strings representing a deck.
  """
  def create_deck do
    values = ["Ass", "Chönig", "Dame", "Buur", "Zähni", "Nüni", "Achti", "Sibni", "Sechsi"]
    suites = ["Schufle", "Härz", "Egge", "Chrüz"]

    for suit <- suites,
        value <- values,
        do: "#{suit} #{value}"
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Check if `deck` contains the specified `card`.

  ## Example

      iex> Cards.create_deck() |> Cards.contains?("Schufle Ass")
      true
      iex> Cards.create_deck() |> Cards.contains?("Schufle Test")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Example

      iex> {hand, _deck} = Cards.create_deck() |> Cards.deal(5)
      iex> hand
      ["Schufle Ass", "Schufle Chönig", "Schufle Dame", "Schufle Buur", "Schufle Zähni"]

  """
  def deal(deck, amount) do
    Enum.split(deck, amount)
  end

  def save(deck, filename) do
    File.write(filename, :erlang.term_to_binary(deck))
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _msg} -> "Das file exischtiert niid."
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end