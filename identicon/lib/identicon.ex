defmodule Identicon do
  require Integer
  @moduledoc """
  Documentation for Identicon.
  """
  def main(input) do
    hash_input(input)
    |> pick_collor()
    |> build_grid()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  def draw_image(%{color: color, grid: grid}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each grid, fn(%{:start_point => start_point, :end_point => end_point}) -> 
      :egd.filledRectangle(image, start_point, end_point, fill)
    end

    :egd.render(image)

  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    grid = Enum.map(grid, fn({_code, index}) -> 

      x = rem(index, 5) * 50
      y = div(index, 5) * 50
      start_point = { x, y}
      end_point = {x + 50, y + 50}

      %{:start_point => start_point, :end_point => end_point}
    end)

    %{ image | grid: grid}
  end

  def build_grid(%{hex: hex} = image) do
    grid = 
      Enum.chunk_every(hex, 3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()
      |> Enum.filter(fn({code , _index}) -> Integer.is_even(code) end)
    %{image | grid: grid}
  end

  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  def pick_collor(image) do
    %{image | color: Enum.take(image.hex, -3) |> List.to_tuple()}
  end

  def hash_input(input) do
    hash = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hash}
  end
end
