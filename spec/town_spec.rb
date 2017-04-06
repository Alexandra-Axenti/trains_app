require('spec_helper')

describe(Town) do
  describe('.all') do
    it("starts off with no towns") do
      expect(Town.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a town by its ID number") do
      test_town = Town.new({:name => "Shanghai", :id => nil})
      test_town.save()
      test_town2 = Town.new({:name => "Beijing", :id => nil})
      test_town2.save()
      expect(Town.find(test_town2.id())).to(eq(test_town2))
    end
  end

  describe("#==") do
    it("is the same town if it has the same name and id") do
      town = Town.new({:name => "Beijing", :id => nil})
      town2 = Town.new({:name => "Beijing", :id => nil})
      expect(town).to(eq(town2))
    end
  end

  describe("#update") do
    it("lets you update towns in the database") do
      town = Town.new({:name => "Beijing", :id => nil})
      town.save()
      town.update({:name => "Shanghai"})
      expect(town.name()).to(eq("Shanghai"))
    end

    it("lets you add a train to a town") do
      town = Town.new({:name => "Beijing", :id => nil})
      town.save()
      AN233 = Train.new({:name => "AN233", :id => nil})
      AN233.save()
      AR935 = Train.new({:name => "AR935", :id => nil})
      AR935.save()
      town.update({:train_ids => [AN233.id(), AR935.id()]})
      expect(town.trains()).to(eq([AN233, AR935]))
    end
  end

  describe("#trains") do
    it("returns all of the trains in a particular city") do
      town = Town.new({:name => "Shanghai", :id => nil})
      town.save()
      AN233 = Train.new({:name => "AN233", :id => nil})
      AN233.save()
      AR935 = Train.new({:name => "AR935", :id => nil})
      AR935.save()
      town.update({:train_ids => [AN233.id(), AR935.id()]})
      expect(town.trains()).to(eq([AN233, AR935]))
    end
  end

  describe("#delete") do
    it("lets you delete a town from the database") do
      town = Town.new({:name => "Shanghai", :id => nil})
      town.save()
      town2 = Town.new({:name => "Beijing", :id => nil})
      town2.save()
      town.delete()
      expect(Town.all()).to(eq([town2]))
    end
  end
end
