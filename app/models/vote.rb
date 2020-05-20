class Vote < ApplicationRecord

  belongs_to :user, counter_cache: true
  belongs_to :work, counter_cache: true

  def self.user_votes(user)
    return Vote.where(user_id: user.id).size
  end
  
  def self.works(user)
    return Vote.where(user_id: user.id)
  end

  def self.work_votes(work)
    return Vote.where(work_id: work.id).size
  end
  
  def self.users(work)
    return Vote.where(work_id: work.id)
  end
  
  def self.voted?(work, user)
    return Vote.where(work_id: work.id, user_id: user.id).size > 0
  end

  def self.upvote(work, user)
    Vote.create(work_id: work.id, user_id: user.id, voted_on: Date.today)
  end

end
