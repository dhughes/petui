# frozen_string_literal: true

RSpec.describe Petui::Layout::HBox do
  it "calculates it's minimum width based on content minimum width" do
    box = Petui::Layout::HBox.new
    label1 = Petui::Control::Label.new('Hello')
    label1.minimum_width = 6
    progress_bar = Petui::Control::ProgressBar.new
    progress_bar.minimum_width = 15
    label2 = Petui::Control::Label.new('World')
    label2.minimum_width = 2
    box.children = [label1, progress_bar, label2]

    expect(box.minimum_width).to eq(23)
  end

  it 'has a preferred width' do
    box = Petui::Layout::HBox.new
    box.preferred_width = 50

    expect(box.preferred_width).to eq(50)
  end

  describe '#render' do
    it 'renders' do
      box = Petui::Layout::HBox.new

      expect(box.render).to eq('')
    end

    it 'renders at the specified width' do
      box = Petui::Layout::HBox.new

      expect(box.render(width: 10)).to eq('          ')
    end

    it 'renders a child' do
      box = Petui::Layout::HBox.new
      box.children << Petui::Control::Label.new('Example')

      expect(box.render(width: 10)).to eq('Example   ')
    end

    it 'renders multiple children' do
      box = Petui::Layout::HBox.new
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render(width: 20)).to eq('Hello█████     World')
    end

    it 'scales children' do
      box = Petui::Layout::HBox.new
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render(width: 17)).to eq('Hel…████▌    Wor…')
    end

    it 'scales children, taking in to consideration minimum widths' do
      box = Petui::Layout::HBox.new
      label1 = Petui::Control::Label.new('Hello')
      label1.minimum_width = 6
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      label2 = Petui::Control::Label.new('World')
      label2.minimum_width = 2
      box.children = [label1, progress_bar, label2]

      expect(box.render(width: 17)).to eq('Hello ████    Wo…')
    end
  end
end
