describe Phone do 

  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)
    home_phone = create(:home_phone, phone: '785-555-1234', contact: contact)
    mobile_phone = build(:mobile_phone, phone: '785-555-1234', contact: contact)

    expect(mobile_phone).to have(1).errors_on(:phone)
  end


  it "allows two contacts to share a phone number" do
    create(:home_phone, phone: '785-555-1234')
    expect(build(:home_phone, phone: '785-555-1234')).to be_valid
  end

end



