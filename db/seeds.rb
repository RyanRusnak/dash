# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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