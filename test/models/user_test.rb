require "test_helper"

describe User do
  let (:new_user) {
    User.new(
      name: "Paloma",
      joined: Date.today
    )
  }

  let (:new_work) {
    Work.new(
      category: "book",
      title: "The Alchemist",
      creator: "Paulo Coelho" ,
      publication: "1990-01-01",
      description: "A great book"
    )
  }

  describe "basic tests" do
    it "can be instantiated" do
      # Assert
      expect(new_user.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      new_user.save
      user = User.first
      [:name, :joined].each do |field|
        # Assert
        expect(user).must_respond_to field
      end
    end
  end

  describe "relationships" do
    it "can vote for many works" do
      # Arrange
      new_user.save
      new_work.save
      new_user.works << new_work
      # Assert
      expect(new_user.works.count).must_equal 1
      new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_user.name = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a unique name" do
      # Arrange
      new_user.save
      conflicting_user = User.new(
        name: "Paloma",
        joined: Date.today
      )
  
      # Assert
      expect(conflicting_user.valid?).must_equal false
      expect(conflicting_user.errors.messages).must_include :name
      expect(conflicting_user.errors.messages[:name]).must_equal ["has already been taken"]
    end

  end

  # Tests for methods you create should go here
  describe "custom methods" do

    describe "vote" do
      it "calculates the user votes by the user" do
        # Arrange
        new_user.save

        # Assert
        expect(new_user.votes).must_equal 0

        # Arrange
        new_work.save
        new_user.works << new_work

        # Assert
        expect(new_user.votes).must_equal 1
      end
    end
  end
end
