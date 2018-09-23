# frozen_string_literal: true

RSpec.describe Petui::Layout::HBox do
  it "calculates it's minimum width based on content minimum width" do
    box = Petui::Layout::HBox.new
    box.spacing = 0
    label1 = Petui::Control::Label.new('Hello')
    label1.minimum_width = 6
    progress_bar = Petui::Control::ProgressBar.new
    progress_bar.minimum_width = 15
    label2 = Petui::Control::Label.new('World')
    label2.minimum_width = 2
    box.children = [label1, progress_bar, label2]

    expect(box.minimum_width).to eq(23)
  end

  it 'has a preferred width (even when empty)' do
    box = Petui::Layout::HBox.new

    expect(box.preferred_width).to eq(0)
  end

  it 'has a user-providable preferred width' do
    box = Petui::Layout::HBox.new
    box.preferred_width = 50

    expect(box.preferred_width).to eq(50)
  end

  it 'has a minimum width' do
    box = Petui::Layout::HBox.new

    expect(box.minimum_width).to eq(0)
  end

  it 'has a user-provided minimum width' do
    box = Petui::Layout::HBox.new
    box.minimum_width = 10

    expect(box.minimum_width).to eq(10)
  end

  describe '#render' do
    it 'renders' do
      box = Petui::Layout::HBox.new
      box.minimum_width = 5
      label = Petui::Control::Label.new('Hello World')
      label.minimum_width = 11
      box.children << label

      expect(box.minimum_width).to eq(11)
    end

    it 'renders at the specified width' do
      box = Petui::Layout::HBox.new

      expect(box.render(width: 10)).to eq('          ')
    end

    context 'when left aligned (as is default)' do
      it 'renders children left aligned' do
        box = Petui::Layout::HBox.new
        box.children << Petui::Control::Label.new('Hello')
        box.children << Petui::Control::Label.new('World')
        box.children.each { |label| label.maximum_width = 5 }

        expect(box.render(width: 19)).to eq('Hello World        ')
      end
    end

    context 'when center aligned' do
      it 'renders children centered' do
        box = Petui::Layout::HBox.new
        box.children << Petui::Control::Label.new('Hello')
        box.children << Petui::Control::Label.new('World')
        box.children.each { |label| label.maximum_width = 5 }
        box.align = Petui::Position::CENTER

        expect(box.render(width: 19)).to eq('    Hello World    ')
      end

      it 'renders children centered oddly' do
        box = Petui::Layout::HBox.new
        box.children << Petui::Control::Label.new('Hello')
        box.children << Petui::Control::Label.new('World')
        box.children.each { |label| label.maximum_width = 5 }
        box.align = Petui::Position::CENTER

        expect(box.render(width: 20)).to eq('    Hello World     ')
      end
    end

    context 'when right aligned' do
      it 'renders children right aligned' do
        box = Petui::Layout::HBox.new
        box.children << Petui::Control::Label.new('Hello')
        box.children << Petui::Control::Label.new('World')
        box.children.each { |label| label.maximum_width = 5 }
        box.align = Petui::Position::RIGHT

        expect(box.render(width: 19)).to eq('        Hello World')
      end
    end

    it 'renders a child' do
      box = Petui::Layout::HBox.new
      box.children << Petui::Control::Label.new('Example')

      expect(box.render(width: 10)).to eq('Example   ')
    end

    it 'renders multiple children' do
      box = Petui::Layout::HBox.new
      box.spacing = 0
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render(width: 20)).to eq('Hello█████     World')
    end

    it 'scales children' do
      box = Petui::Layout::HBox.new
      box.spacing = 0
      box.children << Petui::Control::Label.new('Hello')
      progress_bar = Petui::Control::ProgressBar.new
      progress_bar.progress = 0.5
      box.children << progress_bar
      box.children << Petui::Control::Label.new('World')

      expect(box.render(width: 17)).to eq('Hel…████▌    Wor…')
    end

    it 'scales children, taking in to consideration minimum widths' do
      box = Petui::Layout::HBox.new
      box.spacing = 0
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
