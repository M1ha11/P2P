RSpec.shared_examples 'valid without attributes' do |*attributes|
  attributes.each do |attr|
    it "is invalid without #{attr}" do
      subject.send("#{attr}=", nil)
      expect(subject).to be_valid
    end
  end
end
