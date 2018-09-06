RSpec.describe Petui::Component::Box do
  describe '#render' do
    it 'renders a box' do
      component = Petui::Component::Box.new(width: 5, height: 5)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌───┐
        |│   │
        |│   │
        |│   │
        |└───┘
      OUTPUT
      expect(component.render).to eq(output)
    end
  end

end
