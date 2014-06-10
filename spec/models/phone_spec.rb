describe Phone do 

  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create(firstname: "first", lastname: "last", email: "rspec@test.com")
    phone1 = contact.phones.create(phone_type: "home", phone: "000-111-222")
    phone2 = contact.phones.build(phone_type: "home", phone: "000-111-222")

    expect(phone2).to have(1).errors_on(:phone)
  end


  it "allows two contacts to share a phone number" do
    contact = Contact.create( firstname: 'Joe', lastname: 'Tester', 
                              email: 'joetester@example.com')
    contact.phones.create(phone_type: 'home', phone: '785-555-1234')
    other_contact = Contact.new
    other_phone = other_contact.phones.build(phone_type: 'home', phone: '785-555-1234')

    expect(other_phone).to be_valid
  end

end



