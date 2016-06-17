require "./spec_helper"

describe Meth::Misc do
  it "can convert hash keys to snake_case" do
    Meth::Misc.hash_snake({"ayyLmao" => true}).should eq({"ayy_lmao" => true})
  end
end

describe Meth::IO do
  teststring = "Methlamine"
  it "can split strings using an empty delimiter" do
    Meth::IO.split(teststring, "")[0].should eq "M"
  end
  it "can split strings" do
    Meth::IO.split(teststring, "l")[0].should eq "Meth"
  end
  it "can handle not finding the delimiter in the string" do
    Meth::IO.split(teststring, "x").size.should eq 0
  end
end

describe Meth::Web do
  it "can resolve the ip" do
    x, ip, y = Meth::Web.curl "http://canihazip.com/s"
    ip.should eq(Meth::Web.ip)
  end
end
