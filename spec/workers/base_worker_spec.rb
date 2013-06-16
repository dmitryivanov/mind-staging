require 'spec_helper'

describe BaseWorker do
  
  describe "do_with_rescue_and_logging" do
    
    it "returns nil when no block given"  
  
    context "after start" do
      it "creates dataload log"
      it "sets dataload log status to running"
      it "sets dataload log dataload type"
    end
  
    context "when exception is raised" do
      it "sets dataload log status to error"
      it "it saves exception data to errors array"
      it "saves dataload as not successfull"
      it "saves number of success rows"
      it "saves number of error rows"
      it "sends exception notification"
    end

    context "after finising" do
      it "sets dataload status to finished"
      it "saves error messages"
      it "saves dataload as successfull if no errors"
      it "saves dataload as not successfull if any errors"
      it "saves number of success rows"
      it "saves number of error rows"
    end

  end
  
  describe "increment_success_count_by" do
    it "increments success count by given number"
  end
  
  describe "log" do
    
    it "logs message as notice by default"
    it "outputs message to stdout"
    
    it "increments success rows count when success message"
    
    context "when error message" do
      it "saves error message to @errors, along with verbose message"
      it "increment errors count"
    end

  end
end