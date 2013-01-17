require 'test_helper'

class Authorization < ActionDispatch::IntegrationTest
  # load all the to-be-created fixtures
  fixtures :all

  def emberVisit(path)
    visit(path)
    page.evaluate_script('Ember.run.sync();')
    # not sure how to get around this sleep... the data doesn't show up in the DOM even 
    # after Ember.run.sync has been called.
    sleep 1
  end


  setup do
    # use capybara's javascript driver
    Capybara.current_driver = Capybara.javascript_driver

    # reset ember state
    emberVisit('/#/')

    @user0 = users(:user0)
    @scores_path_user0 = "/#/users/#{@user0.id}"
  end

  test "guest" do
    emberVisit(@scores_path_user0)    

    summaries = page.all('.summary')
    assert_equal(@user0.scores.count, summaries.count, "same number of summaries and scores")
   
    summaries.each do |item|
      assert(item.has_link?('.view'), "has a view link")
      assert(item.has_no_link?('.edit'), "has no edit link")
      assert(item.has_no_link?('.destroy'), "has no edit link")
    end
  end

  test "owner" do
    signInEmber('user0@example.com', 'hellohello')

    emberVisit(@scores_path_user0)
    
    summaries = page.all('.summary')
    assert_equal(@user0.scores.count, summaries.count, "same number of summaries and scores")

    summaries.each do |item|
      assert(item.has_link?('.view'), "has a view link")
      assert(item.has_link?('.edit'), "has edit link")
      assert(item.has_no_link?('.destroy'), "has no edit link")
    end
  end

  test "not owner" do
    signInEmber('user1@example.com', 'byebye')

    emberVisit(@scores_path_user0)
    
    summaries = page.all('.summary')
    assert_equal(@user0.scores.count, summaries.count, "same number of summaries and scores")

    summaries.each do |item|
      assert(item.has_link?('.view'), "has a view link")
      assert(item.has_no_link?('.edit'), "has edit link")
      assert(item.has_no_link?('.destroy'), "has no edit link")
    end
  end


  test "admin" do
    signInEmber('admin@example.com', 'imanadmin')

    emberVisit(@scores_path_user0)
    
    summaries = page.all('.summary')
    assert_equal(@user0.scores.count, summaries.count, "same number of summaries and scores")

    summaries.each do |item|
      assert(item.has_link?('.view'), "has a view link")
      assert(item.has_link?('.edit'), "has edit link")
      assert(item.has_link?('.destroy'), "has no edit link")
    end
  end

end