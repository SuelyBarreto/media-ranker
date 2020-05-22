require "test_helper"

describe Work do  
  describe "basic tests" do

    let (:new_work) {
      works(:alchemist)
    }
        
    it "can be instantiated" do
      # Assert
      expect(new_work.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      work = Work.first
      [:title, :creator, :publication, :description].each do |field|
        # Assert
        expect(work).must_respond_to field
      end
    end
  end

  describe "relationships" do

    let (:new_work) {
      works(:alchemist)
    }
  
    let (:new_user) {
      users(:chris)
    }
      
    it "can get votes for many users" do
      # Arrange
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

    let (:new_work) {
      works(:alchemist)
    }
        
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
      before do
        ["E", "D", "C", "B", "A"].each do |title|
          Work.create(category: "movie", title: title)
        end

        ["H", "G", "F"].each do |title|
          Work.create(category: "book", title: title)
        end
      end

      it "returns a list of works" do
        # Arrange
        result1 = Work.by_category("movie")

        # Assert
        expect(result1.size).must_equal 5
        result1.each do |work|
          expect(work).must_be_instance_of Work 
        end
      end

      it "returns only one category" do
        # Arrange
        Work.find_by(title: "The Alchemist").destroy
        result2 = Work.by_category("book")
        # Assert
        expect(result2.size).must_equal 3
        result2.each do |work|
          expect(work).must_be_instance_of Work
          expect(work.category).must_equal "book"
        end
      end

      it "sorts the works" do
        # Arrange
        result3 = Work.by_category("movie")

        # Assert
        expect(result3.size).must_equal 5
        expect(result3.first.title).must_equal "A"
        expect(result3.last.title).must_equal "E"
      end

      it "returns empty Relation if there are no works" do
        # Arrange
        result4 = Work.by_category("album")

        # Assert
        expect(result4.size).must_equal 0

      end
    end
  
    describe "self.top(category, n)" do
      before do
        (0..25).to_a.each do |x|
          title = "Movie " + ("Z".ord - x).chr
          Work.create(category: "movie", title: title)
        end

        (0..25).to_a.each do |x|
          title = "Book " + ("Z".ord - x).chr
          Work.create(category: "book", title: title)
        end
      end

      it "returns a list of top 10 works in a category" do
        # Arrange
        result1 = Work.top("movie", 10)

        # Assert
        expect(result1.size).must_equal 10
        result1.each do |work|
          expect(work).must_be_instance_of Work 
          expect(work.category).must_equal "movie"
        end
      end

      it "sorts the works by title if tied by votes" do
        # Arrange
        result2 = Work.top("movie", 5)

        # Assert
        expect(result2.size).must_equal 5
        expect(result2.first.title).must_equal "Movie A"
        expect(result2.last.title).must_equal "Movie E"
      end

      it "returns empty Relation if there are no works in the category" do
        # Arrange
        result3 = Work.top("album", 10)

        # Assert
        expect(result3.size).must_equal 0
      end
  
      it "returns the ones with the most votes first" do
        # Arrange
        user1 = User.create(name: "X")
        user2 = User.create(name: "Y")
        movie_m = Work.find_by(title: "Movie M")
        movie_n = Work.find_by(title: "Movie N")
        movie_i = Work.find_by(title: "Movie I")
        movie_j = Work.find_by(title: "Movie J")
        movie_a = Work.find_by(title: "Movie A")
        movie_b = Work.find_by(title: "Movie B")
        
        movie_m.upvote(user1)
        movie_m.upvote(user2)
        movie_n.upvote(user1)
        movie_n.upvote(user2)
        movie_i.upvote(user1)
        movie_j.upvote(user2)

        result4 = Work.top("movie", 6)

        # Assert
        expect(result4.size).must_equal 6
        expect(result4[0].title).must_equal "Movie M" # 2 votes
        expect(result4[1].title).must_equal "Movie N" # 2 votes
        expect(result4[2].title).must_equal "Movie I" # 1 vote
        expect(result4[3].title).must_equal "Movie J" # 1 vote
        expect(result4[4].title).must_equal "Movie A" # 0 votes
        expect(result4[5].title).must_equal "Movie B" # 0 votes
      end
    end
  
    describe "def self.spotlight" do
      it "returns nil if there are no works" do
        # Arrange
        Work.find_by(title: "The Alchemist").destroy
        result5 = Work.spotlight

        # Assert
        expect(result5).must_be_nil
      end

      it "returns the one with the most votes" do
        # Arrange
        work1 = Work.create(category: "book", title: "A")
        work2 = Work.create(category: "book", title: "B")
        work3 = Work.create(category: "book", title: "C")
        user1 = User.create(name: "X")
        user2 = User.create(name: "Y")
        work1.upvote(user1)
        work2.upvote(user1)
        work2.upvote(user2)
        result6 = Work.spotlight

        # Assert
        expect(result6.title).must_equal "B"
      end
      
      it "breaks ties on votes using alphabetical order" do
        # Arrange
        work1 = Work.create(category: "book", title: "C")
        work2 = Work.create(category: "book", title: "B")
        work3 = Work.create(category: "book", title: "A")
        user1 = User.create(name: "X")
        work1.upvote(user1)
        work2.upvote(user1)
        work3.upvote(user1)
        result7 = Work.spotlight

        # Assert
        expect(result7.title).must_equal "A"
      end
    end
    
    describe "def voted?(user)" do

      let (:new_work) {
        works(:alchemist)
      }
    
      let (:new_user) {
        users(:chris)
      }
       
      it "returns false if the user has not voted" do

        # Act & Assert
        expect(new_work.voted?(new_user)).must_equal false

      end

      it "returns true if the user has already voted" do

        # Arrange
        new_work.upvote(new_user)

        # Act & Assert
        expect(new_work.voted?(new_user)).must_equal true

      end
    end
  
    describe "def upvote(user)" do

      let (:new_work) {
        works(:alchemist)
      }
    
      let (:new_user) {
        users(:chris)
      }
       
      it "casts a vote for the work by the user" do

        # Arrange
        expect(new_work.voted?(new_user)).must_equal false
        result = new_work.upvote(new_user)

        # Act & Assert
        expect(result).must_equal true
        expect(new_work.voted?(new_user)).must_equal true

      end


      it "won't let the user vote twice" do

        # Arrange
        result1 = new_work.upvote(new_user)
        expect(new_work.voted?(new_user)).must_equal true

        # Act & Assert
        result2 = new_work.upvote(new_user)
        expect(result2).must_equal false

      end

    end
  end
end
