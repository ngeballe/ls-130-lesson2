require 'simplecov'
SimpleCov.start

require 'pry'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

require_relative 'amnesty'

class LocalGroupTest < MiniTest::Test
  def setup
    @local_group = LocalGroup.new("Las Vegas, New Mexico, not Nevada", 563)
    # binding.pry
    @local_group.coordinator = "Carrol Pearson"
    @local_group.size = 8
  end

  def test_create_without_number
    mena = LocalGroup.new("Amnesty MENA DC")
    assert_nil(mena.instance_variable_get(:@number))    
  end

  def test_size
    @local_group.size = 10
    assert_equal(10, @local_group.size)
  end

  def test_coordinator
    @local_group.coordinator = "Bob Pearson"
    assert_equal(@local_group.coordinator, "Bob Pearson")
  end

  def test_ac
    @ac = AC.new("Carrol Pearson", "New Mexico")
    @local_group.ac = @ac
    assert_equal(@local_group.ac, @ac)
  end

  def test_no_ac
    assert_nil(@local_group.ac)
  end

  def test_no_member_leader
    assert_equal(@local_group.member_leader?, false)
  end

  def test_member_leader
    @ac = AC.new("Aaron", "Minneapolis")
    @local_group.member_leader = @ac

    assert_equal(@local_group.member_leader, @ac)
    assert_equal(@local_group.ac, @ac)

    @ac2 = AC.new("Michael Andrews", "South Florida")
    @local_group.ac = @ac2

    assert_equal(@local_group.member_leader, @ac2)
    assert_equal(@local_group.ac, @ac2)
  end

  def test_member_leader_question
    assert_nil(@local_group.member_leader)

    @ac = AC.new("Aaron", "Minneapolis")
    @local_group.member_leader = @ac

    assert_equal(@local_group.member_leader?, true)
  end

  def test_ac_question
    assert_equal(@local_group.ac?, false)
    @ac = AC.new("Carolyn Smiles", "The Hills of Old Vermont")

    @local_group.ac = @ac

    assert_equal(@local_group.ac?, true)
  end

  def test_raise_sac_method_error
    @sac = SAC.new("SAC Valdez", "Northern Virginia")

    assert_raises(NoMethodError) { @local_group.sac = @sac }
  end

  def test_raise_ac_as_sac
    @sac = SAC.new("SAC Valdez", "Northern Virginia")

    assert_raises(TypeError) do
      @local_group.ac = @sac
    end
  end

end

class StudentGroupTest < MiniTest::Test
  def setup
    @student_group = StudentGroup.new("George Washington University")
    @student_group.coordinator = "Natalie Green"   
    @student_group.size = 30
  end   

  def test_name
    assert_equal(@student_group.name, "George Washington University")
  end

  def test_size
    assert_equal(@student_group.size, 30)
  end

  def test_sac
    @sac = SAC.new("Sungmin Sohn", "Washington, DC")
    @student_group.sac = @sac
    assert_equal(@student_group.sac, @sac)

    assert_equal(@sac.groups, [@student_group])
  end

  def test_coordinator
    @student_group.coordinator = "Bob Pearson"
    assert_equal(@student_group.coordinator, "Bob Pearson")
  end

  def test_sac
    @sac = SAC.new("Natalie Green", "Washington, DC")
    @student_group.sac = @sac
    assert_equal(@student_group.sac, @sac)
  end

  def test_no_sac
    assert_nil(@student_group.sac)
  end

  def test_no_member_leader
    assert_equal(@student_group.member_leader?, false)
  end

  def test_member_leader
    @sac = SAC.new("Mario", "Minneapolis")
    @student_group.member_leader = @sac

    assert_equal(@student_group.member_leader, @sac)
    assert_equal(@student_group.sac, @sac)

    @sac2 = SAC.new("Kate", "South Florida")
    @student_group.sac = @sac2

    assert_equal(@student_group.member_leader, @sac2)
    assert_equal(@student_group.sac, @sac2)
  end

  def test_member_leader_question
    assert_nil(@student_group.member_leader)

    @sac = SAC.new("Aaron", "Minneapolis")
    @student_group.member_leader = @sac

    assert_equal(@student_group.member_leader?, true)
  end

  def test_sac_question
    assert_equal(@student_group.sac?, false)

    @sac = SAC.new("Jenny", "The Hills of Old Vermont")
    @student_group.sac = @sac

    assert_equal(@student_group.sac?, true)
  end

  def test_raise_ac_method_error
    @ac = AC.new("AC Valdez", "Northern Virginia")

    assert_raises(NoMethodError) { @student_group.ac = @ac }
  end

  def test_raise_sac_as_ac
    @ac = AC.new("AC Valdez", "Northern Virginia")
    
    assert_raises(TypeError) do
      @student_group.sac = @ac
    end
  end
end

class ACTest < MiniTest::Test
  def setup
    @cap_hill = LocalGroup.new("Capitol Hill", 211)
    @nw_dc = LocalGroup.new(159, "Northwest DC")
    @ac = AC.new("Nick Geballe", "Washington, DC Area")
  end

  def test_add_group
    @ac.add_group(@nw_dc)

    assert_equal(@ac.groups.include?(@nw_dc), true)
    assert_equal(@ac.groups.include?(@cap_hill), false)

    @ac.add_group(@cap_hill)

    assert_equal(@ac.groups.size, 2)
    assert_equal(@ac.groups, [@nw_dc, @cap_hill])
  end

  def test_add_groups
    @ac.add_groups(@cap_hill, @nw_dc)

    assert_equal(@ac.groups, [@cap_hill, @nw_dc])
  end

  def test_number_of_groups
    @ac.add_group(@nw_dc)
    @ac.add_group(@cap_hill)

    assert_equal(@ac.number_of_groups, 2)
  end

  def test_acs_groups_have_ac
    @ac.add_group(@nw_dc)

    assert_equal(@nw_dc.ac, @ac)
  end
end

class SACTest < MiniTest::Test
  def setup
    @sac = SAC.new("Sungmin Sohn", "Washington, DC")
    @student_group1 = StudentGroup.new("Georgetown")
    @student_group2 = StudentGroup.new("Washington International School")
  end

  def test_add_group
    @sac.add_group(@student_group1)

    assert_equal(@sac.groups.include?(@student_group1), true)
  end

  def test_add_groups
    @sac.add_groups(@student_group1, @student_group2)

    assert_equal(@sac.groups, [@student_group1, @student_group2])
  end

  def test_number_of_groups
    @sac.add_group(@student_group1)
    @sac.add_group(@student_group2)

    assert_equal(@sac.number_of_groups, 2)
  end

  def test_sacs_groups_have_sac
    @sac.add_group(@student_group1)

    assert_equal(@student_group1.sac, @sac)
  end
end
