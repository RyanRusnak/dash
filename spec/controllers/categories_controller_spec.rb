require 'spec_helper' 
require 'csv'

describe CategoriesController do 

	# it "returns a classification object" do

	# 	@group = Group.create({:name => "Animals"})

	# 	c1 = @group.categories.create({:name => 'cats'})
	# 		c1.documents.create({:name => 'doc1', :body => 'I love kittens'})
	# 		c1.documents.create({:name => 'doc2', :body => 'I really like cats'})
	# 	c2 = @group.categories.create({:name => 'dogs'})
	# 		c2.documents.create({:name => 'doc3', :body => 'I am all about dogs'})
	# 		c2.documents.create({:name => 'doc4', :body => 'Dogs are the coolest'})
	# 	c3 = @group.categories.create({:name => 'Fish'})
	# 		c3.documents.create({:name => 'doc5', :body => 'I hate fish. They are dirty'})
	# 		c3.documents.create({:name => 'doct6', :body => 'Fish are the worst'})
	# 		c3.documents.create({:name => 'doct7', :body => 'Fish are stinky beasts'})

	#       # create new classifier instance
	# 	nbayes = NBayes::Base.new
	# 	# train it - notice split method used to tokenize text (more on that below)
	# 	nbayes.train( c1.documents[0].body.split(/\s+/), c1.name )
	# 	nbayes.train( c1.documents[1].body.split(/\s+/), c1.name )
	# 	nbayes.train( c2.documents[0].body.split(/\s+/), c2.name )
	# 	nbayes.train( c2.documents[1].body.split(/\s+/), c2.name )
	# 	nbayes.train( c3.documents[0].body.split(/\s+/), c3.name )
	# 	nbayes.train( c3.documents[1].body.split(/\s+/), c3.name )
	# 	nbayes.train( c3.documents[2].body.split(/\s+/), c3.name )
		
	# 	tokens = "I like kittens"

	#     post :classify_document, :id => @group.id, :format => :json, :doc => tokens
	#     tokens = tokens.split(/\s+/)
	#     result = nbayes.classify(tokens)

	#     expect(JSON.parse(response.body)['probability']).to eq(result.to_json)
 #    end

 #   it "should not be biased based on the amount of data in each category" do
 #   	#sample huge data
 #   	s1 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #   	s2 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #    s3 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #   	s4 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #    s5 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #   	s6 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #    s7 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
 #   	s8 = '     DESCRIPTION (provided by applicant): Access to antiretroviral therapy (ART) and policies around HIV treatment are expanding throughout sub- Saharan Africa (SSA). Recent improvements in the treatment context in Malawi stand to alter the bi-directional relationship between HIV and fertility in Africa. Of particular relevance is ""Option B+"", a new program designed to provide universal and lifelong access to ART to pregnant, HIV+ women. Because such a policy has never been implemented before, Option B+ offers an important and immediate opportunity to learn about the implications of widespread ART access for reproductive goals and behaviors and the knock-on effects for HIV transmission. The proposed work builds upon longitudinal data collected by Tsogolo la Thanzi (TLT-1) between 2009-11from approximately 3000 young adults living in Balaka, Malawi. Specifically, we seek to field TLT-2: a follow up survey of the TLT-1. TLT-2 will focus on respondents reproductive, relationship, sexual, contraceptive, and biomedical service use histories. The original cohort will have aged to 21-31-years of peak childbearing and acute risk for HIV infection. We will leverage TLT-2 and the combined TLT-1/TLT-2 dataset to answer questions about women, men, and couples in an environment of widespread and expanding access to ART. In particular, we will measure the expected and possible unanticipated consequences of this new policy on both vertical (i.e., mother-to-child) and horizontal (i.e., between partners) HIV transmission and on patterns of fertility for this cohort. These individual- and couple-level data will be combined with new detailed data collected from clinics and policymakers examining the realities of new policy implementation at the local level. This combined couple-based and institutionally informed approach to understanding the changing  relationship between HIV and fertility-a crucial dimension of reproductive health in SSA-stands to inform  both research and policy by providing a preliminary evidentiary basis for how other ""test and treat"" policies in  high-prevalence setting might influence fertility behavior and HIV transmission.           '.split(/\s+/)
    
 #    @nbayes = NBayes::Base.new
 #    @nbayes.train( s1, 'classA' )
 #    @nbayes.train( s2, 'classA' )
 #    @nbayes.train( s3, 'classA' )
 #    @nbayes.train( s4, 'classA' )
 #    @nbayes.train( s5, 'classA' )
 #    @nbayes.train( s6, 'classA' )
 #    @nbayes.train( s7, 'classA' )
 #    @nbayes.train( s8, 'classA' )

 #    @nbayes.train( %w[dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy], 'dogs' )
 #    results = @nbayes.classify( %w[dogs are fuzzy and warm] )
 #    expect(results.max_class).to  eq('dogs')
 #    # puts results['dogs']
 #    expect(results['dogs']).to be > 0.5
 #    results = @nbayes.classify( %w[Access to antiretroviral therapy (ART) and policies around HIV treatment] )
 #    expect(results.max_class).to  eq('classA')
 #    # puts results['classA']
 #    expect(results['classA']).to be > 0.5
 #  end

 #  it "should not be biased based on the amount of data in each category using a file upload" do
 #  	file = Rack::Test::UploadedFile.new("#{Rails.root}/public/files/1A-2013.csv", "text/csv")
 #  	category = Category.create({:name => '1A-2013'})
 #  	dogs_cat = Category.create({:name => 'Dogs'})
 #  	csv = CSV.new(file.read, :headers => true, :header_converters => :symbol)
	#   cats = csv.to_a.map {|row| 
	#   	row.to_hash 
	#   	category.documents.create({
	#   		:name => row[:project_number], 
	#   		:body => row[:abstract_text1].encode('utf-8', :invalid => :replace, :undef => :replace)})
	#   }
	#   224.times do 
	#   	dogs_cat.documents.create({:name => 'DogsDoc', :body => 'dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzydogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy'})
	#   end
 #    @nbayes = NBayes::Base.new

 #    Category.all.each do |cat| 
 #      cat.documents.each do |doc|
 #        @nbayes.train(doc.body.split(/\s+/), cat.name )
 #      end
 #    end 
 #    test_doc = 'dogs dogs dogs dogs dogs warm warm warm warm fuzzy fuzzy fuzzy fuzzy'
 #    doc = test_doc.to_s.split(/\s+/)
 #    results = @nbayes.classify(doc)

 #    puts 'Confidence: '+ results['Dogs'].to_s
 #    expect(results.max_class).to  eq('Dogs')
 #    expect(results['Dogs']).to be > 0.6
 #  end

 #  it "should only classify within the specified group" do

 #  	@group_one = Group.create({:name => "Animals"})
 #  	@group_two = Group.create({:name => "Humans"})

	# c1 = @group_one.categories.create({:name => 'Cats'})
	# 	c1.documents.create({:name => 'doc1', :body => 'I love kittens'})
	# c2 = @group_one.categories.create({:name => 'Dogs'})
	# 	c2.documents.create({:name => 'doc3', :body => 'I am all about dogs'})
	# c3 = @group_two.categories.create({:name => 'Guys'})
	# 	c3.documents.create({:name => 'doc5', :body => 'Jeff Bill Fred'})
	# c4 = @group_two.categories.create({:name => 'Girls'})
	# 	c4.documents.create({:name => 'doc5', :body => 'Kate Kirby Mary'})

 #      # create new classifier instance
	# nbayes = NBayes::Base.new
	# # train it - notice split method used to tokenize text (more on that below)
	# nbayes.train( c3.documents[0].body.split(/\s+/), c3.name )
	# nbayes.train( c4.documents[0].body.split(/\s+/), c4.name )
	
	# tokens = "Bill Jeff Fred"

 #    post :classify_document, :id => @group_two.id, :format => :json, :doc => tokens
 #    tokens = tokens.split(/\s+/)
 #    result = nbayes.classify(tokens)

 #    expect(JSON.parse(response.body)['probability']).to eq(result.to_json)

 #  end

 #  it "should be successful" do
 #  	group = Group.create({:name => 'test group'})
 #    post :classify_document, :id => group.id, :format => :json
 #    response.should be_success
 #  end

 #  it "index should be successful" do
 #  	group = Group.create({:name => 'test group'})
 #    get :index, :group_id => group.id
 #    response.should be_success
 #  end

end
