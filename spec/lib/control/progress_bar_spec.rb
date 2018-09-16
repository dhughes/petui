# frozen_string_literal: true

RSpec.describe Petui::Control::ProgressBar do
  describe '#render' do
    it 'renders at the specified width' do
      control = Petui::Control::ProgressBar.new
      control.width = 10

      expect(control.render).to eq('          ')
    end

    it 'renders 0% complete' do
      control = Petui::Control::ProgressBar.new
      control.width = 10
      control.progress = 0

      expect(control.render).to eq('          ')
    end

    it 'renders 50% complete' do
      control = Petui::Control::ProgressBar.new
      control.width = 8
      control.progress = 0.5

      expect(control.render).to eq('████    ')
    end

    it 'renders 100% complete' do
      control = Petui::Control::ProgressBar.new
      control.width = 8
      control.progress = 1

      expect(control.render).to eq('████████')
    end

    it 'renders fractional completion' do
      control = Petui::Control::ProgressBar.new
      control.width = 5
      control.progress = 0.585

      expect(control.render).to eq('██▉  ')
    end

    it 'renders in color' do
      control = Petui::Control::ProgressBar.new
      control.width = 5
      control.progress = 0.585
      control.color = :red
      control.background_color = 'gold'

      expect(control.render).to eq("\e[31;48;5;226m██▉  \e[0m")
    end
  end
end