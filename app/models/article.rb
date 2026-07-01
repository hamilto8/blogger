class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 3, maximum: 150 }
  validates :body, presence: true, length: { minimum: 10 }

  class ImageAttachment
    attr_reader :article

    def initialize(article)
      @article = article
    end

    def exists?
      article.image_file_name.present?
    end

    def url
      return nil unless exists?
      if article.image_file_name.to_s.start_with?('http://', 'https://', '/')
        article.image_file_name
      else
        "/system/images/#{article.image_file_name}"
      end
    end

    def to_s
      url.to_s
    end
  end

  def image
    @image ||= ImageAttachment.new(self)
  end

  def image=(file_or_string)
    if file_or_string.respond_to?(:original_filename)
      filename = file_or_string.original_filename
      self.image_file_name = filename
      self.image_content_type = file_or_string.content_type if file_or_string.respond_to?(:content_type)
      self.image_file_size = file_or_string.size if file_or_string.respond_to?(:size)
      self.image_updated_at = Time.current

      # Save uploaded file to public/system/images
      if file_or_string.respond_to?(:read) && defined?(Rails) && Rails.root.present?
        require 'fileutils'
        dir = Rails.root.join('public', 'system', 'images')
        FileUtils.mkdir_p(dir)
        File.open(dir.join(filename), 'wb') do |f|
          f.write(file_or_string.read)
        end
      end
    elsif file_or_string.is_a?(String) && file_or_string.present?
      self.image_file_name = file_or_string
    end
    @image = nil
  end

  def image_exists?
    image.exists?
  end

  def image_url
    image.url
  end

  # Reading time estimation in minutes (assuming 200 words per min)
  def reading_time
    return 1 unless body.present?
    word_count = body.split.size
    [1, (word_count / 200.0).ceil].max
  end

  def word_count
    return 0 unless body.present?
    body.split.size
  end

  def tag_list
    self.tags.collect(&:name).join(", ")
  end

  def tag_list=(tags_string)
    return self.tags = [] if tags_string.blank?

    tag_names = tags_string.split(",").collect { |s| s.strip.downcase }.reject(&:blank?).uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
