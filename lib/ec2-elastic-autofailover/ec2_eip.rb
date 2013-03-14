module AutoFailover
  def reassign_eip
    disassociate_eip @active, @elastic_ip
    new_active = select_passive(@protocol)
    until associate_eip(new_active, @elastic_ip)
      new_active = select_passive(@protocol)
    end
    @active = new_active
  end

  def disassociate_eip(instance, eip)
    ec2.disassociate_address(:instance_id => instance, :public_ip => eip)
  end

  def associate_eip(instance, eip)
    ec2.associate_address(:instance_id => instance, :public_ip => eip)
  end

  def ec2
    @ec2 ||= AWS::EC2::Base.new(:access_key_id => @access_key_id, :secret_access_key => @access_secret)
  end
end
