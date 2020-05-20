require "test_helper"

describe WorksController do

  let (:new_work) {
    works(:alchemist)
  }
  
  it "must get index" do
    get works_path
    must_respond_with :success
  end

  it "must get show" do
    get work_path(new_work)
    must_respond_with :success
  end

  it "must get new" do
    get new_work_path
    must_respond_with :success
  end

  it "must get edit" do
    get edit_work_path(new_work)
    must_respond_with :success
  end

end
