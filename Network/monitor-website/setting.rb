class Setting
  def self.websites
    ['http://ipy.bartucci.it', 'http://significatocanzone.it']
  end

  def self.user
    'ale'
  end

  def self.code_color code
    if code.to_i == 200
      return "00cc00"
    else
      return "ff0000"
    end
  end

end
