class PixelMap
  def self.rows
    @rows ||= read
  end

  def self.write!(pos, color)
    File.open(file, 'rb+') { |f| f.seek(pos); f.write(pos.chr) }
  end

  def self.setup!
    File.open(file, 'wb') { |f| f.write(0.chr * 300)}
  end

  private

  def self.read
    data.scan(/.{20}/).map do |row|
      row.split('')
    end
  end

  def self.file
    File.join(Sinatra::Application.root, 'data', 'map.bin')
  end

  def self.data
    @data ||= File.read(file)
  end
end
