require "test_helper"

describe Vote do
  let (:new_user) {
    users(:chris)
  }

  let (:new_work) {
    works(:alchemist)
  }

  let (:new_vote) {
    Vote.create(user_id: new_user.id, work_id: new_work.id, voted_on: Date.today)
  }
  describe "basic tests" do
    it "can be instantiated" do
      # Assert
      expect(new_vote.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      new_vote.save
      vote = Vote.first
      [:user_id, :work_id, :voted_on].each do |field|
        # Assert
        expect(vote).must_respond_to field
      end
    end
  end

  describe "relationships" do
    it "belongs to one user" do
      # Arrange
      new_user.save
      new_work.save
      new_vote.save
      # Assert
      expect(new_vote.user.valid?).must_equal true
      expect(new_vote.user).must_be_instance_of User
    end

    it "belongs to one work" do
      # Arrange
      new_user.save
      new_work.save
      new_vote.save
      # Assert
      expect(new_vote.work.valid?).must_equal true
      expect(new_vote.work).must_be_instance_of Work
    end    
  end
end
