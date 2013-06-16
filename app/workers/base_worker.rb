# all workers will inherit from this class,
# wich provides default loggin, rescue of errors
# for dataloads and settings for sidekiq

class BaseWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false


  # basic logging of error messages,
  # all errors will be saved as array of hases with
  # error text and error details
  def log(message = '', type = :notice, verbose_message = '')
    @errors ||= []
    @error_rows ||= 0
    @success_rows ||= 0

    case type
    when :error
      @error_rows += 1
      @errors << { :error_text => message, :details => verbose_message }

    when :success
      @success_rows += 1      
    end

    puts message
  end


  # this method accepts a block, wich will be executed
  # between rescue blocs and surrounded by creating 
  # dataload log and finishing it
  #
  # Accepts values of options hash
  #     :dataload_type (string) - type, recorder in log
  #     :user_id - user to bind this dataload to
  #
  # Returns dataload log object it created
  #                 
  def do_with_rescue_and_logging(options = {})
    return nil unless block_given?
    
    @errors ||= []
    @success_rows = 0
    @error_rows = 0
  
    dataload_log = DataloadLog.create(
      :dataload_type => options[:dataload_type],
      :status => 'running',
      :user_id => options[:user_id]
    )
  
    begin

      yield
    
      dataload_log.update_attributes(
        :status => 'finished',
        :error_text => @errors, 
        :is_successfull => @error_rows == 0, 
        :success_rows => @success_rows, 
        :error_rows => @error_rows
      )
    rescue Exception => e
      dataload_log.update_attributes(
        :status => 'error',
        :error_text => @errors.unshift({ :error_text => e.message, :details => e.backtrace.inspect }),
        :is_successfull => false, 
        :success_rows => @success_rows, 
        :error_rows => @error_rows
      )
    
      ExceptionNotifier::Notifier.background_exception_notification(e).deliver
    end
  
    return dataload_log    
  end

  def increment_success_count_by(count)
    @success_rows += count
  end
end