class ApplicationService
  CACHE_EXPIRY = 24.hours

  def self.call(*, **)
    new(*, **).call
  end
end
