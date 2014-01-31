require 'spec_helper' 

describe CategoriesController do 

	it "returns a classification object" do

		c1 = Category.create({:name => 'cats'})
			c1.documents.create({:name => 'doc1', :body => 'I love kittens'})
			c1.documents.create({:name => 'doc2', :body => 'I really like cats'})
		c2 = Category.create({:name => 'dogs'})
			c2.documents.create({:name => 'doc3', :body => 'I am all about dogs'})
			c2.documents.create({:name => 'doc4', :body => 'Dogs are the coolest'})
		c3 = Category.create({:name => 'Fish'})
			c3.documents.create({:name => 'doc5', :body => 'I hate fish. They are dirty'})
			c3.documents.create({:name => 'doct6', :body => 'Fish are the worst'})
			c3.documents.create({:name => 'doct7', :body => 'Fish are stinky beasts'})

	      # create new classifier instance
		nbayes = NBayes::Base.new
		# train it - notice split method used to tokenize text (more on that below)
		nbayes.train( c1.documents[0].body.split(/\s+/), c1.name )
		nbayes.train( c1.documents[1].body.split(/\s+/), c1.name )
		nbayes.train( c2.documents[0].body.split(/\s+/), c2.name )
		nbayes.train( c2.documents[1].body.split(/\s+/), c2.name )
		nbayes.train( c3.documents[0].body.split(/\s+/), c3.name )
		nbayes.train( c3.documents[1].body.split(/\s+/), c3.name )
		nbayes.train( c3.documents[2].body.split(/\s+/), c3.name )
		
		tokens = "I like kittens"
		
		params = {}
		params[:doc] = tokens
		params[:format] = :json
	    post "classify_document", params
	    tokens = tokens.split(/\s+/)
	    result = nbayes.classify(tokens)

	    expect(JSON.parse(response.body)['probability']).to eq(result.to_json)
    end

end
