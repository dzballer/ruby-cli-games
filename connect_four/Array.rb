#monkeypatch
class Array
  def four_in_a_row??(x)
    self.join.include?("#{x}#{x}#{x}#{x}")
  end
end