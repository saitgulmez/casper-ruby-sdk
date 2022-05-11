class Error < StandardError
  attr_reader :err
  def initialize(err)
    @err = err
    super(err)
  end
end
