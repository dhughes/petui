RSpec.describe Petui::Component::Box do
  describe '#render' do
    it 'renders a box' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([5, 5]).at_least(:once)
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

    it 'renders a wide box' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 3]).at_least(:once)
      component = Petui::Component::Box.new(width: 10, height: 3)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌────────┐
        |│        │
        |└────────┘
      OUTPUT
      expect(component.render).to eq(output)
    end

    it 'can contain stuff' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 3]).at_least(:once)
      box = Petui::Component::Box.new(width: 10, height: 3)
      text = Petui::Component::Text.new('Hi')
      box.add_child(text, x: 0, y: 0)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌────────┐
        |│Hi      │
        |└────────┘
      OUTPUT
      expect(box.render).to eq(output)
    end
  end

end
