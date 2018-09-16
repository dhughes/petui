# frozen_string_literal: true

RSpec.describe Petui::Control::Label do
  it 'has text' do
    component = Petui::Control::Label.new('Hello World')

    expect(component.text).to eq('Hello World')
  end

  it 'has a width' do
    component = Petui::Control::Label.new('Hello')

    expect(component.width).to eq(5)
  end

  it 'does not have a default minimum width' do
    component = Petui::Control::Label.new('Hello')

    expect(component.min_width).to be_nil
  end

  it 'can have a minimum width' do
    component = Petui::Control::Label.new('Hello')
    component.min_width = 10

    expect(component.min_width).to eq(10)
  end

  it 'does not have a default maximum width' do
    component = Petui::Control::Label.new('Hello')

    expect(component.max_width).to be_nil
  end

  it 'can have a minimum width' do
    component = Petui::Control::Label.new('Hello')
    component.max_width = 20

    expect(component.max_width).to eq(20)
  end

  describe '#render' do
    it 'renders text' do
      component = Petui::Control::Label.new('Hello')

      expect(component.render).to eq('Hello')
    end

    context 'when string is longer than width' do
      it 'renders text with spaces when text is shorter than the specified width' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 15

        expect(component.render).to eq('Hello World    ')
      end

      it 'can center text within the specified width' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 15
        component.align = Petui::Position::CENTER

        expect(component.render).to eq('  Hello World  ')
      end

      it 'centers text towards the left when uneven spacing' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 16
        component.align = Petui::Position::CENTER

        expect(component.render).to eq('  Hello World   ')
      end

      it 'can align text to the right within the specified width' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 15
        component.align = Petui::Position::RIGHT

        expect(component.render).to eq('    Hello World')
      end
    end

    context 'when string is shorter than width' do
      it 'renders text with an ellipsis when text is longer than the specified width' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 8

        expect(component.render).to eq('Hello W…')
      end

      it 'ignores alignment' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 6
        component.align = Petui::Position::RIGHT

        expect(component.render).to eq('Hello…')
      end

      it 'raises an error if width is less than 2' do
        component = Petui::Control::Label.new('Hello World')
        component.width = 1

        expect { component.render }.to raise_error('Width must be at least 2')
      end
    end
  end
end
