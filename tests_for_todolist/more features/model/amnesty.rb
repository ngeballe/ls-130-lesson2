class AIGroup
  attr_accessor :coordinator, :size, :name

  def initialize(name)
    @name = name
  end

  def member_leader?
    member_leader ? true : false
  end
end

class LocalGroup < AIGroup
  attr_accessor :ac
  alias_method :member_leader, :ac
  alias_method :ac?, :member_leader?

  def initialize(name, number = nil)
    super(name)
    @number = number
  end

  def ac=(ac)
    raise TypeError, "must be an AC" unless ac.instance_of?(AC)
    @ac = ac
    ac.add_group_unless_present(self)
  end
  alias_method :member_leader=, :ac=
end

class StudentGroup < AIGroup
  attr_accessor :sac
  alias_method :member_leader, :sac
  alias_method :sac?, :member_leader?

  def sac=(sac)
    raise TypeError, "must be an SAC" unless sac.instance_of?(SAC)
    @sac = sac
    sac.add_group_unless_present(self)
  end
  alias_method :member_leader=, :sac=
end

class MemberLeader
  attr_accessor :groups

  def initialize(name, area)
    @name = name
    @area = area
    @groups = []
  end

  def add_groups(*groups)
    groups.each do |group|
      add_group(group)
    end
  end

  def number_of_groups
    @groups.count
  end

  def add_group_unless_present(group)
    add_group(group) unless groups.include?(group)
  end

  def add_group(group, required_class)
    raise TypeError, "can only add #{required_class} objects" unless group.instance_of?(required_class)
    @groups << group
    group.member_leader = self
  end
end

class AC < MemberLeader
  def add_group(group)
    super(group, LocalGroup)
  end
end

class SAC < MemberLeader
  def add_group(group)
    super(group, StudentGroup)
  end
end
