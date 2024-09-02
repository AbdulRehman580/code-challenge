describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Van Gogh Paintings" do

    before :all do
      @response = open("files/van-gogh-paintings.html").read
      @document = Nokogiri::HTML(@response)
    end

    it "contains Knowledge Graph hash" do
      expect(@document["knowledge_panel"]).to be_an(Hash)
    end

    it "artworks" do
      expect(@document["knowledge_panel"]["artworks"]).to be_a(Array)
      expect(@document["knowledge_panel"]["artworks"]).to_not be_empty
    end

    it "artworks - title" do
      expect(@document["knowledge_panel"]["artworks"][0]["title"]).to be_a(String)
      expect(@document["knowledge_panel"]["artworks"][0]["title"]).to_not be_empty
    end

    it "artworks - extensions" do
      expect(@document["knowledge_panel"]["artworks"][0]["extensions"]).to be_a(Array)
      expect(@document["knowledge_panel"]["artworks"][0]["extensions"]).to_not be_empty
    end

    it "artworks - link" do
      expect(@document["knowledge_panel"]["artworks"][0]["link"]).to be_a(String)
      expect(@document["knowledge_panel"]["artworks"][0]["link"]).to_not be_empty
    end

    it "artworks - image" do
      expect(@document["knowledge_panel"]["artworks"][0]["image"]).to be_a(String)
      expect(@document["knowledge_panel"]["artworks"][0]["image"]).to_not be_empty
    end

  end

  describe "Knowledge Graph for HTML without Paintings" do

    before :all do
      @response = open("files/some-file-with-missing-paintings.html").read
      @document = Nokogiri::HTML(@response)
    end

    it "contains Knowledge Graph hash" do
      expect(@document["knowledge_panel"]).to be_an(Hash)
    end

    it "artworks" do
      expect(@document["knowledge_panel"]["artworks"]).to be_a(Array)
      expect(@document["knowledge_panel"]["artworks"]).to be_empty
    end

  end

end
