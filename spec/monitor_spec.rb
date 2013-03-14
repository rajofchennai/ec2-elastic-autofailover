require './lib/ec2-elastic-autofailover.rb'

describe Monitor do
  context "initialize" do
    it "without any params should throw ArgumentError" do
      expect {Monitor.new}.to raise_error(ArgumentError)
    end

    it "without elastic ip should throw ArgumentError" do
      expect {Monitor.new(:active_instance_id => 'abc')}.to raise_error(ArgumentError)
    end

    it "without active_instance_id should throw ArgumentError" do
    end

    it "without passive_instance_ids should throw ArgumentError" do
    end

    it "passive_instance_ids should be an array" do
    end

    it "without url should throw ArgumentError" do
    end

    it "without access_key_id should throw ArgumentError" do
    end

    it "without access_secret should throw ArgumentError" do
    end

    it "without name should throw ArgumentError" do
    end

    it "with all the above params it should create a monitor object" do
    end

    it "should take default values for frequency, threshold, protocol if not specified" do
    end
  end

  context "monitor_instance" do
    it "should call fork" do
    end

    it "child process should be daemonized with start_monitoring" do
    end

    it "parent process should just return nil and continue" do
    end
  end

  context "start_monitoring" do
    it "have a em periodic time at frequency given during initialization" do
    end

    it "should call ping_url at options[:frequency] (if given)" do
    end

    it "should call ping_url at 30 second frequency" do
    end

    it "whenever ping url return nil failure count should be incremented (till threshold)" do
    end

    it "when failure count reaches threshold call reassign_eip" do
    end
  end

  context "reassign_eip" do
    it "should disassociate eip from currently active  and wait for 30 seconds" do
    end

    it "should select a new active from the list of passives" do
    end

    it "should raise RuntimeError when the passive is empty" do
    end

    it "should change the selected passive to the new active and remove that node from list of passives" do
    end

  end

  context "ping" do
    it "should do a rest call to the url specified with the protocol" do
    end

    it "if the protocol is not http or https raise NotImplementedError" do
    end

    it "if the rest call succeeds return the response" do
    end

    it "if the rest call fails for any exceptions return nil" do
    end
  end
end
