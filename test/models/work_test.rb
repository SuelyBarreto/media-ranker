require "test_helper"

describe Work do
  let (:new_work) {
    works(:alchemist)
  }

  let (:new_user) {
    users(:chris)
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
    it "can get votes for many users" do
      # Arrange
      new_user.save
      new_work.save
      new_work.upvote(new_user)
      # Assert
      expect(new_work.votes.count).must_equal 1
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
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
      new_work.category = "taco"

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["invalid category"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "self.by_category(category)" do
      # return Work.where(category: category).order(title: :asc)
    end
  
    describe "self.top(category, n)" do
      # return Work.where(category: category).order(votes_count: :desc, title: :asc).limit(n)
    end
  
    describe "def self.spotlight" do
      # return Work.order(votes_count: :desc, title: :asc).first
    end
    
    describe "def voted?(user)" do
      # return Vote.where(work_id: self.id, user_id: user.id).size > 0
    end
  
    describe "def upvote(user)" do
      # if voted?(user)
      #   return false
      # end
      # Vote.create(work_id: self.id, user_id: user.id, voted_on: Date.today)
      # return true
    end
  

  end
end
