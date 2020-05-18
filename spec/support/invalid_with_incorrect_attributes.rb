RSpec.shared_examples 'invalid with incorrect attributes' do |*attributes|
  attributes.each do |attr|
    it "is invalid with incorrect #{attr[:field]}" do
      subject.send("#{attr[:field]}=", attr[:params])
      expect(subject).not_to be_valid
    end
  end
end