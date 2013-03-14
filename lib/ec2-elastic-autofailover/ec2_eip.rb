module AutoFailover
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
