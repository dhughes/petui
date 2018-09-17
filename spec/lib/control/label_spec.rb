# frozen_string_literal: true

RSpec.describe Petui::Control::Label do
  it 'has text' do
    control = Petui::Control::Label.new('Hello World')

    expect(control.text).to eq('Hello World')
  end

  it 'has a preferred width' do
    control = Petui::Control::Label.new('Hello')

    expect(control.preferred_width).to eq(5)
  end

  it 'has a minimum width' do
    control = Petui::Control::Label.new('Hello')
    control.minimum_width = 10

    expect(control.minimum_width).to eq(10)
  end

  it 'has a width' do
    control = Petui::Control::Label.new('Hello')

    expect(control.width).to eq(5)
  end

  it 'does not have a default minimum width' do
    control = Petui::Control::Label.new('Hello')

    expect(control.min_width).to be_nil
  end

  it 'can have a minimum width' do
    control = Petui::Control::Label.new('Hello')
    control.min_width = 10

    expect(control.min_width).to eq(10)
  end

  it 'does not have a default maximum width' do
    control = Petui::Control::Label.new('Hello')

    expect(control.max_width).to be_nil
  end

  it 'can have a minimum width' do
    control = Petui::Control::Label.new('Hello')
    control.max_width = 20

    expect(control.max_width).to eq(20)
  end

  describe '#render' do
    it 'renders text' do
      control = Petui::Control::Label.new('Hello')

      expect(control.render).to eq('Hello')
    end

    it 'renders in color' do
      control = Petui::Control::Label.new('Hello')
      control.color = :blue
      control.background_color = '#123456'

      expect(control.render).to eq("\e[34;48;5;24mHello\e[0m")
    end

    it 'renders styles' do
      control = Petui::Control::Label.new('Hello')
      control.styles = %i[underline bold]

      expect(control.render).to eq("\e[4;1mHello\e[0m")
    end

    context 'when string is longer than width' do
      it 'renders text with spaces when text is shorter than the specified width' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 15

        expect(control.render).to eq('Hello World    ')
      end

      it 'can center text within the specified width' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 15
        control.align = Petui::Position::CENTER

        expect(control.render).to eq('  Hello World  ')
      end

      it 'centers text towards the left when uneven spacing' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 16
        control.align = Petui::Position::CENTER

        expect(control.render).to eq('  Hello World   ')
      end

      it 'can align text to the right within the specified width' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 15
        control.align = Petui::Position::RIGHT

        expect(control.render).to eq('    Hello World')
      end
    end

    context 'when string is shorter than width' do
      it 'renders text with an ellipsis when text is longer than the specified width' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 8

        expect(control.render).to eq('Hello W…')
      end

      it 'ignores alignment' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 6
        control.align = Petui::Position::RIGHT

        expect(control.render).to eq('Hello…')
      end

      it 'raises an error if width is less than 2' do
        control = Petui::Control::Label.new('Hello World')
        control.width = 1

        expect { control.render }.to raise_error('Width must be at least 2')
      end
    end
  end
end
