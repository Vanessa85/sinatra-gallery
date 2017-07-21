class Image < ActiveRecord::Base
  validates :title, :size, :filename, presence: true
  validates :title, uniqueness: true

  def save_with_file(file = nil)
    unless file.nil? && file.empty?
      uploads_path = File.join(Sinatra::Application.settings.public_folder, 'uploads')
      Dir.mkdir(uploads_path) unless Dir.exist?(uploads_path)

      File.open(File.join(uploads_path, file[:filename]), 'wb') do |f|
        f.write(file[:tempfile].read)
      end

      return self.save
    end
    false
  end

end
