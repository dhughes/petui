# frozen_string_literal: true

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

    it 'can contain a box in a box' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([12, 5]).at_least(:once)
      box = Petui::Component::Box.new(width: 12, height: 5)
      box2 = Petui::Component::Box.new(width: 10, height: 3)
      box.add_child(box2, x: 0, y: 0)
      text = Petui::Component::Text.new('Hi')
      box2.add_child(text, x: 0, y: 0)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌──────────┐
        |│┌────────┐│
        |││Hi      ││
        |│└────────┘│
        |└──────────┘
      OUTPUT
      expect(box.render).to eq(output)
    end

    it 'can have a label' do
      width = 14
      height = 4
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([width, height]).at_least(:once)
      box = Petui::Component::Box.new(width: width, height: height, label: 'Hello')
      text = Petui::Component::Text.new('World')
      box.add_child(text, x: 0, y: 0)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌─Hello──────┐
        |│World       │
        |│            │
        |└────────────┘
      OUTPUT
      expect(box.render).to eq(output)
    end

    it 'can have multiple children' do
      width = 14
      height = 4
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([width, height]).at_least(:once)
      box = Petui::Component::Box.new(width: width, height: height)
      box.add_child(Petui::Component::Text.new('Hello'), x: 0, y: 0)
      box.add_child(Petui::Component::Text.new('World'), x: 0, y: 1)

      output = <<-OUTPUT.gsub(/^\s+\|/, '').chomp
        |┌────────────┐
        |│Hello       │
        |│World       │
        |└────────────┘
      OUTPUT
      expect(box.render).to eq(output)
    end
  end
end
