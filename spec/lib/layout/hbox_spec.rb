# frozen_string_literal: true

RSpec.describe Petui::Layout::HBox do
  describe '#render' do
    it 'renders' do
      box = Petui::Layout::HBox.new

      expect(box.render).to eq('')
    end

    it 'renders at the specified width' do
      box = Petui::Layout::HBox.new
      box.width = 10

      expect(box.render).to eq('          ')
    end

    it 'renders a child' do
      box = Petui::Layout::HBox.new
      box.width = 10
      box.children << Petui::Control::Label.new('Example')

      expect(box.render).to eq('Example   ')
    end

    it 'renders multiple children' do
      box = Petui::Layout::HBox.new
      box.width = 20
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render).to eq('Hello█████     World')
    end

    it 'scales children' do
      box = Petui::Layout::HBox.new
      box.width = 17
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render).to eq('Hel…████▌    Wor…')
    end

    it 'scales children, taking in to consideration minimum widths' do
      box = Petui::Layout::HBox.new
      box.width = 17
      label = Petui::Control::Label.new('Hello')
      label.minimum_width = 6
      box.children << label
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render).to eq('Hello ████    Wo…')
    end
  end
end
