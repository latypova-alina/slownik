module ResponseGetter
  WAIT_TIME = 2.freeze
  RETRIES = 3.freeze

  def get_response
    retry_counter ||= 0

    yield
  rescue
    sleep(WAIT_TIME)

    if (retry_counter += 1) < RETRIES
      retry
    else
      File.open("errors.txt", "a") do |file|
        file.write("#{word}, #{Time.now}\n")
      end
    end
  end
end
