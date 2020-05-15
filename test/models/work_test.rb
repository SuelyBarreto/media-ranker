require "test_helper"

describe Work do
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
      expect(new_work.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      new_work.save
      work = Work.first
      [:title, :creator, :publication, :description].each do |field|
        # Assert
        expect(work).must_respond_to field
      end
    end
  end

  describe "relationships" do
    it "can get votes from many users" do
      # Arrange
      new_work.save
      new_user = User.create(name: "Pedro", joined: Date.today)
      new_work.users << new_user
      # Assert
      expect(new_work.users.count).must_equal 1
      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a category" do
      # Arrange
      new_work.category = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["invalid category"]
    end

    it "must have a valid category" do
      # Arrange
      new_work.category = "soda"

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["invalid category"]
    end

  end

  # Tests for methods you create should go here
  describe "custom methods" do

    describe "vote" do
      it "calculates the user votes for the work" do
        # Arrange
        new_work.save

        # Assert
        expect(new_work.votes).must_equal 0

        # Arrange
        new_user1 = User.create(name: "Pedro", joined: Date.today)
        new_work.users << new_user1

        # Assert
        expect(new_work.votes).must_equal 1

        # Arrange
        new_user2 = User.create(name: "Fabio", joined: Date.today)
        new_work.users << new_user2

        # Assert
        expect(new_work.votes).must_equal 2
      end
    end
  end
end
