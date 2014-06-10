describe Contact do 
  
  it "is valid with a firstname, a lastname and a email" do 
    contact = Contact.new(firstname: "han", lastname: "bing", email: "rspec@test.com")
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end


  it "is invalid without a lastname" do 
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end


  it "is invalid without a email" do 
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email" do 
    Contact.create( firstname: "first", lastname: "last", 
                    email: "rspec@test.com")
    contact = Contact.new(firstname: "han", lastname: "bing", 
                          email: "rspec@test.com")

    expect(contact).to have(1).errors_on(:email)
  end

  it "returns contact's fullname as a string" do
    contact = Contact.new(firstname: "han", lastname: "bing", email: "rspec@test.com")  
                    
    expect(contact.name).to eq("han bing")                      
  end

  describe "filter lastname by letter" do 

    before :each do 
      @smith = Contact.create( firstname: 'John', lastname: 'Smith',
                              email: 'jsmith@example.com')
      @jones = Contact.create( firstname: 'Tim', lastname: 'Jones',
                              email: 'tjones@example.com')
      @johnson = Contact.create( firstname: 'John', lastname: 'Johnson',
                                email: 'jjohnson@example.com')      
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "none matching letters" do
      it "only returns contacts with the provided starting letter" do
        expect(Contact.by_letter("J")).to_not include @smith
      end
    end

  end

end