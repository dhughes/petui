# frozen_string_literal: true

require 'io/console/size'
require 'pry-byebug'

RSpec.describe Petui::Component::Container do
  describe '#render' do
    it 'renders text' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 10]).at_least(:once)
      component = Petui::Component::Container.new

      expect(component.render).not_to be_nil
    end

    it 'should render a string as long as the screen is wide and tall' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 10]).at_least(:once)
      component = Petui::Component::Container.new

      expect(component.render.length).to eq(109)
    end

    it 'should render a child' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 10]).at_least(:once)
      component = Petui::Component::Container.new
      text = Petui::Component::Text.new('test')
      component.add_child(text, x: 1, y: 1)

      code = <<-EXAMPLE.gsub(/^\s+\|/, '')
        |          
        | test     
        |          
        |          
        |          
        |          
        |          
        |          
        |          
        |          
      EXAMPLE
      expect(component.render).to eq(code.chomp("\n"))
    end

    it 'should render multiple children' do
      IO = class_double('IO').as_stubbed_const(transfer_nested_constants: true)
      expect(IO).to receive(:console_size).and_return([10, 10]).at_least(:once)
      component = Petui::Component::Container.new
      component.add_child(Petui::Component::Text.new('test'), x: 0, y: 0)
      component.add_child(Petui::Component::Text.new('test'), x: 1, y: 1)
      component.add_child(Petui::Component::Text.new('test'), x: 2, y: 2)
      component.add_child(Petui::Component::Text.new('test'), x: 3, y: 3)
      component.add_child(Petui::Component::Text.new('test'), x: 4, y: 4)

      code = <<-EXAMPLE.gsub(/^\s+\|/, '')
        |test      
        | test     
        |  test    
        |   test   
        |    test  
        |          
        |          
        |          
        |          
        |          
      EXAMPLE
      expect(component.render).to eq(code.chomp("\n"))
    end
  end
end