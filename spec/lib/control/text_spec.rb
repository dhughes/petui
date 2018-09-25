# frozen_string_literal: true

RSpec.describe Petui::Control::Text do
  it 'has text' do
    control = Petui::Control::Text.new('Hello World')

    expect(control.text).to eq('Hello World')
  end

  it 'has a preferred width' do
    control = Petui::Control::Text.new('Hello')

    expect(control.preferred_width).to eq(5)
  end

  it 'preferred width is at least the minimum width' do
    control = Petui::Control::Text.new('Hello')
    control.preferred_width = 10
    control.minimum_width = 20

    expect(control.preferred_width).to eq(20)
  end

  it 'has a minimum width' do
    control = Petui::Control::Text.new('Hello')
    control.minimum_width = 10

    expect(control.minimum_width).to eq(10)
  end

  it 'can have a minimum width' do
    control = Petui::Control::Text.new('Hello')
    control.minimum_width = 10

    expect(control.minimum_width).to eq(10)
  end

  it 'does not have a default maximum width' do
    control = Petui::Control::Text.new('Hello')

    expect(control.maximum_width).to be_nil
  end

  it 'can have a minimum width' do
    control = Petui::Control::Text.new('Hello')
    control.maximum_width = 20

    expect(control.maximum_width).to eq(20)
  end

  describe '#render' do
    it 'renders text' do
      control = Petui::Control::Text.new('Hello')

      expect(control.render).to eq('Hello')
    end

    it 'wraps text that is longer than the specified width' do
      control = Petui::Control::Text.new(samples.text_example)

      expect(control.render(width: 11)).to eq(samples.wrapped_text_example)
    end

    it 'preserves existing line breaks' do
      control = Petui::Control::Text.new(samples.lorem_ipsum)

      expect(control.render(width: 120)).to eq(samples.lorem_ipsum_wrapped)
    end

    context 'when not scrolled' do
      it 'truncates at the specified height' do
        control = Petui::Control::Text.new(samples.height_truncated_input)

        expect(control.render(width: 40, height: 5)).to eq(samples.height_truncated_output)
      end
    end

    context 'when scrolled' do
      it 'renders only visible text to the specified height' do
        control = Petui::Control::Text.new(samples.height_truncated_input)
        control.scroll_top = 2

        expect(control.render(width: 40, height: 5)).to eq(samples.scrolled_height_truncated_output)
      end
    end

    it 'wraps words that are longer than the width by breaking them apart' do
      control = Petui::Control::Text.new(samples.long_word_input)

      expect(control.render(width: 15)).to eq(samples.long_word_output)
    end
  end

  describe '#preferred_height' do
    context 'when preferred_width is not specified (IE: the length of the text)' do
      it 'preferred height defaults to the number of lines in the text' do
        control = Petui::Control::Text.new(samples.lorem_ipsum)

        expect(control.preferred_height).to eq(3)
      end
    end

    context 'when preferred_width is specified' do
      it 'calculates preferred height based on preferred width' do
        control = Petui::Control::Text.new(samples.lorem_ipsum)
        control.preferred_width = 120

        expect(control.preferred_height).to eq(13)
      end
    end

  end
end
