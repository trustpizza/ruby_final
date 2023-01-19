require 'singleton'

class NullPiece
  include Singleton

  def to_s
    ' '
  end

  def color; end
end
