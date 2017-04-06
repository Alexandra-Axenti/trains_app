require('spec_helper')

describe(Stop) do
  describe('.all') do
    it("starts off with no towns and no trains") do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a stop by its ID number") do
      test_stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      test_stop.save()
      test_stop2 = Stop.new({:name => "Central", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      test_stop2.save()
      expect(Stop.find(test_stop2.id())).to(eq(test_stop2))
    end
  end

  describe("#==") do
    it("is the same stop if it has the same name and id") do
      stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop2 = Stop.new({:name => "Central", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      expect(stop).to(eq(stop2))
    end
  end

  describe("#update") do
    it("lets you update stops in the database") do
      stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop.save()
      stop.update({:name => "Central"})
      expect(stop.name()).to(eq("Central"))
    end

    it("lets you add a train and a town to a stop") do
      stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop.save()
      AN233 = Train.new({:name => "AN233", :id => nil})
      AN233.save()
      hongkong = Town.new({:name => "Hong Kong", :id => nil})
      hongkong.save()
      stop.update({:train_id => AN233.id(),:town_id => hongkong.id()})
      expect(stop()).to(eq("AN233", "Hong Kong"))
    end
  end

  describe("#time") do
    it("returns all of the times a trains passes by a particular city") do
      stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop.save()
      AN233 = Train.new({:name => "AN233", :id => nil})
      AN233.save()
      hongkong = Town.new({:name => "Hong Kong", :id => nil})
      hongkong.save()
      stop.update({:train_id => AN233.id(), :town_id => hongkong.id()})
      expect(stop()).to(eq("AN233", "Hong Kong"))
    end
  end

  describe("#delete") do
    it("lets you delete a stop from the database") do
      stop = Stop.new({:name => "Wanchai", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop.save()
      stop2 = Town.new({:name => "Central", :id => nil, :train_id => nil, :town_id => nil, :time => nil})
      stop2.save()
      stop.delete()
      expect(Stop.all()).to(eq([stop2]))
    end
  end
end
