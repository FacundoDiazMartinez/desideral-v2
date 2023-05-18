class Result
  def initialize(success, value, error, status)
    @success = success
    @value = value
    @error = error
    @status = status || (success ? :ok : :unprocessable_entity)
  end

  def success?
    @success
  end

  def value
    @value
  end

  def error
    @error
  end

  def status
    @status
  end

  def self.success(value, status = nil)
    new(true, value, nil, status)
  end

  def self.failure(error, status = nil)
    new(false, nil, error, status)
  end
end
