RSpec.shared_examples 'invalid without attributes' do |*attributes|
  attributes.each do |attr|
    it "is invalid without #{attr}" do
      subject.send("#{attr}=", nil)
      expect(subject).not_to be_valid
    end
  end
end
