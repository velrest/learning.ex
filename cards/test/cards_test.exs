defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 36 cards." do
    assert length(Cards.create_deck()) == 36
  end

  test "contains? returns true for `Schufle Ass` ond a default deck." do
    assert Cards.create_deck() |> Cards.contains?("Schufle Ass") == true
  end

  test "deal returns Schufle Ass and Shufle Chönig from a default deck." do
    {dealt, _remaining} = Cards.create_deck() |> Cards.deal(2)
    assert dealt == ["Schufle Ass", "Schufle Chönig"]
  end
end