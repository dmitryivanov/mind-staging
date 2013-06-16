module RailsthemesMailerHelper
  def set_block_defaults options
    @header = options[:header] || 'Test header'
    @body = 'Content'
    @image_url = options[:image_url]
  end

  def yield_content! content_key
    view_flow.content.delete(content_key)
  end

  def email_block &block
    @body = capture(&block) unless block.nil?
    render :partial => 'shared/email_block'
  end

  def side_block options = {}, &block
    set_block_defaults options
    @body = capture(&block) unless block.nil?
    render :partial => 'shared/side_block'
  end

  def header header
    @header = header
  end

  def image url
    @image_url = url
  end
end
