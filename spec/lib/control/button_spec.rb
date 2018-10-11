# frozen_string_literal: true

RSpec.describe Petui::Control::Button do
  it 'has text' do
    control = Petui::Control::Button.new('Hello World')

    expect(control.text).to eq('Hello World')
  end

  describe '#render' do
    it 'renders a button' do
      control = Petui::Control::Button.new('Hello')

      expect(control.render).to eq(samples.hello_button)
    end

    context 'when focused' do
      it 'renders with double lines' do
        control = Petui::Control::Button.new('Hello')
        control.focused = true

        expect(control.render).to eq(samples.focused_hello_button)
      end
    end
  end
end