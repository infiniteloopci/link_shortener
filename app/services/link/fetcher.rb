class Link::Fetcher
  attr_accessor :link

  def self.process_token(token)
    fetcher = new(token)
    fetcher.get_link
    fetcher.update_counter
    fetcher.link
  end
  
  def initialize(token)
    @token = token    
  end

  def get_link
    self.link = Link.find_by! token: @token
  end

  def update_counter
    link.view_count += 1
    link.save!
  end
end