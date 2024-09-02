require 'nokogiri'

class ArtworkParsingService
  def initialize(file_path)
    @file_path = file_path
  end

  def call
    html_content = open(@file_path).read
    document = Nokogiri::HTML(open(html_content)
    kp_artworks_items = extract_kp_artworks_items(document)
    process_kp_items(kp_artworks_items)
  end

  private

  def process_kp_items(kp_artworks_items)
    results = {knowledge_panel: {artworks: []}}
    return results if kp_artworks_items.empty?

    kp_artworks_items.each do |kp_item|
      item = kp_item.css("a").first
      next unless item

      results[:knowledge_panel][:artworks] << process_kp_item(item)
    end

    results
  end

  def process_kp_item(item)
    title = extract_title(item)
    extensions = extract_extensions(item)
    link = extract_link(item)
    image = extract_image(item)

    {title: title, extensions: extensions, link: link, image: image}
  end

  def extract_kp_artworks_items(document)
    document.css(".klitem-tr") + document.css(".iELo6")
  end

  def extract_title(item)
    item.attributes["aria-label"]&.text || item.css(".KHK6lb .pgNMRc")&.text
  end

  def extract_extensions(item)
    year = item.css(".KHK6lb .cxzHyb")&.text
    return [year] unless year.empty?

    year = item.attributes["title"]&.text
    return unless year

    [year.split("(").last.gsub!(")", "")]
  end

  def extract_link(item)
    item.attributes["href"]&.text
  end

  def extract_image(item)
    image = item.css("img").first
    return unless image

    image.attributes["src"]&.text
  end
end
