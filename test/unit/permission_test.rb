require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  test "score permissions, class & guest" do
    p = Permission.new(Score, User.new)
    assert(!p.destroy, "can't destroy")
    assert(!p.edit, "can't edit")
    assert(!p.new, "can't new")
    assert(p.read, "can read")
  end

  test "score permissions, class & logged in user" do
    p = Permission.new(Score, users(:user0))
    assert(!p.destroy, "can't destroy")
    assert(!p.edit, "can't edit")
    assert(p.new, "can new")
    assert(p.read, "can read")
  end

  test "score permissions, instance & guest" do
    p = Permission.new(scores(:one), User.new)
    assert(!p.destroy, "can't destroy")
    assert(!p.edit, "can't edit")
    assert(!p.new, "can't new")
    assert(p.read, "can read")
  end

  test "score permissions, instance & owner" do
    p = Permission.new(scores(:one), users(:user0))
    assert(!p.destroy, "can't destroy")
    assert(p.edit, "can edit")
    assert(p.new, "can new")
    assert(p.read, "can read")
  end

  test "score permissions, instance & logged-in non-owner" do
    p = Permission.new(scores(:one), users(:user1))
    assert(!p.destroy, "can't destroy")
    assert(!p.edit, "can't edit")
    assert(p.new, "can new")
    assert(p.read, "can read")
  end

end
