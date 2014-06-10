describe Contact do 
  
  it "is valid with a firstname, a lastname and a email" do 
    expect(create(:contact)).to be_valid
  end

  it "is invalid without a firstname" do
    expect(build(:contact, firstname: nil)).to have(1).errors_on(:firstname)
  end


  it "is invalid without a lastname" do 
    expect(build(:contact, lastname: nil)).to have(1).errors_on(:lastname)
  end


  it "is invalid without a email" do 
    expect(build(:contact, email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email" do 
    create(:contact, email: "1@1.com")
    contact = build(:contact, email: "1@1.com")

    expect(contact).to have(1).errors_on(:email)
  end

  it "returns contact's fullname as a string" do
    contact = create(:contact, firstname: "han", lastname: "bing")  
                    
    expect(contact.name).to eq("han bing")                      
  end

  describe "filter lastname by letter" do 

    before :each do 
      @smith = create( :contact, firstname: 'John', lastname: 'Smith')
      @jones = create( :contact, firstname: 'Tim', lastname: 'Jones')
      @johnson = create( :contact, firstname: 'John', lastname: 'Johnson')      
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

  it "has 3 phones after build" do
    expect(build(:contact).phones.size).to eq 3
  end

end