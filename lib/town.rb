class Town
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_towns = DB.exec("SELECT * FROM towns;")
    towns = []
    returned_towns.each() do |town|
      name = town.fetch("name")
      id = town.fetch("id").to_i()
      towns.push(Town.new({:name => name, :id => id}))
    end
    towns
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM towns WHERE id = #{id};")
    name = result.first().fetch("name")
    Town.new({:name => name, :id => id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO towns (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_town|
    self.name().==(another_town.name()).&(self.id().==(another_town.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (train_id, town_id) VALUES (#{train_id}, #{self.id()});")
    end
  end

  define_method(:trains) do
    stops = []
    results = DB.exec("SELECT train_id FROM stops WHERE town_id = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      stops.push(Train.new({:name => name, :id => train_id}))
    end
    stops
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE id = #{self.id()};")
    DB.exec("DELETE FROM towns WHERE id = #{self.id()};")
  end
end
