module AutoFailover
  def select_master
    new_active = @passive_instance_ids.sample
    raise RuntimeError.new("passive instances is empty") unless new_active
    @passive_instance_ids.delete new_active
  end
end
