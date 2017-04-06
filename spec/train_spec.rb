require('spec_helper')

describe(Train) do
  describe('.all') do
    it("starts off with no trains") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe("#initialize") do
    it("is initialized with a name") do
      train = Train.new({:name => "AN233", :id => nil})
      expect(train).to(be_an_instance_of(Train))
    end

    it("can be initialized with its database ID") do
      train = Train.new({:name => "AN233", :id => 1})
      expect(train).to(be_an_instance_of(Train))
    end
  end

  describe(".find") do
    it("returns a train by its ID number") do
      test_train = Train.new({:name => "TR234", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "AN233", :id => nil})
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe("#==") do
    it("is the same train if it has the same name and id") do
      train = Train.new({:name => "AN233", :id => nil})
      train2 = Train.new({:name => "AN233", :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      train = Train.new({:name => "AR435", :id => nil})
      train.save()
      train.update({:name => "AR935"})
      expect(train.name()).to(eq("AR935"))
    end

    it("lets you add a city to a train") do
      town = Town.new({:name => "Hong Kong", :id => nil})
      town.save()
      train = Train.new({:name => "AN233", :id => nil})
      train.save()
      train.update({:town_ids => [town.id()]})
      expect(train.towns()).to(eq([town]))
    end
  end

  describe("#towns") do
    it("returns all of the cities a train stops in") do
      town = Town.new(:name => "Shenzhen", :id => nil)
      town.save()
      town2 = Town.new(:name => "Guangdong", :id => nil)
      town2.save()
      train = Train.new(:name => "AN233", :id => nil)
      train.save()
      train.update(:town_ids => [town.id()])
      train.update(:town_ids => [town2.id()])
      expect(train.towns()).to(eq([town, town2]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({:name => "AN233", :id => nil})
      train.save()
      train2 = Train.new({:name => "AR935", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end
end
