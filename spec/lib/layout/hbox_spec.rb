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

  describe '#render' do
    it 'renders' do
      box = Petui::Layout::HBox.new

      expect(box.render).to eq('')
    end

    it 'renders at the specified width' do
      box = Petui::Layout::HBox.new
      # TODO: need to calculate x offsets
      expect(box.render(width: 10)).to eq('          ')
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

  # it 'preferred_content_width' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 2
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 10
  #   progress_bar = Petui::Control::ProgressBar.new
  #   progress_bar.preferred_width = 12
  #   label2 = Petui::Control::Label.new('World')
  #   label2.minimum_width = 8
  #   box.children = [label1, progress_bar, label2]
  #
  #   expect(box.preferred_content_width).to eq(34)
  # end
  #
  # it 'preferred_children_widths' do
  #   box = Petui::Layout::HBox.new
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 10
  #   progress_bar = Petui::Control::ProgressBar.new
  #   progress_bar.preferred_width = 12
  #   label2 = Petui::Control::Label.new('World')
  #   label2.minimum_width = 8
  #   box.children = [label1, progress_bar, label2]
  #
  #   expect(box.preferred_children_widths).to eq([10, 12, 8])
  # end
  #
  # it 'usable_width' do
  #   box = Petui::Layout::HBox.new
  #   box.padding = 2
  #
  #   expect(box.usable_width(width: 10)).to eq(6)
  # end
  #
  # it 'spacing width' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 2
  #   box.children << Petui::Control::Label.new('Hello')
  #   box.children << Petui::Control::Label.new('Hello')
  #   box.children << Petui::Control::Label.new('Hello')
  #   box.children << Petui::Control::Label.new('Hello')
  #
  #   expect(box.spacing_width).to eq(6)
  # end
  #
  # it 'adjusted children widths - expands to fit equally' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 0
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 10
  #   label2 = Petui::Control::Label.new('World')
  #   label2.preferred_width = 10
  #   box.children = [label1, label2]
  #
  #   expect(box.adjusted_children_widths(width: 30)).to eq(
  #     label1 => 15,
  #     label2 => 15
  #   )
  # end
  #
  # it 'adjusted children widths - expands only those that can expand' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 0
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.maximum_width = 5
  #   label2 = Petui::Control::Label.new('World')
  #   box.children = [label1, label2]
  #
  #   expect(box.adjusted_children_widths(width: 30)).to eq(
  #     label1 => 5,
  #     label2 => 25
  #   )
  # end
  #
  # it 'adjusted children widths - expands only those that can expand' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 0
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 5
  #   label1.maximum_width = 7
  #   label2 = Petui::Control::Label.new('World')
  #   box.children = [label1, label2]
  #
  #   expect(box.adjusted_children_widths(width: 30)).to eq(
  #     label1 => 7,
  #     label2 => 23
  #   )
  # end
  #
  # it 'adjusted children widths - shrinks to fit equally' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 0
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 10
  #   label2 = Petui::Control::Label.new('World')
  #   label2.preferred_width = 10
  #   box.children = [label1, label2]
  #
  #   expect(box.adjusted_children_widths(width: 6)).to eq(
  #     label1 => 3,
  #     label2 => 3
  #   )
  # end
  #
  # it 'renders children' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 1
  #   box.padding = 1
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 7
  #   label2 = Petui::Control::Label.new('World')
  #   label2.preferred_width = 7
  #   box.children = [label1, label2]
  #
  #   puts box.render(width: 17)
  # end
  #
  # it 'renders weird children' do
  #   box = Petui::Layout::HBox.new
  #   box.spacing = 1
  #   box.padding = 1
  #   label1 = Petui::Control::Label.new('Hello')
  #   label1.preferred_width = 7
  #   label1.background_color = '#6666FF'
  #   label1.color = :black
  #   label1.align = Petui::Position::CENTER
  #   label2 = Petui::Control::Label.new('World')
  #   label2.preferred_width = 7
  #   label2.styles = [:underline]
  #   label2.align = Petui::Position::CENTER
  #   box.children = [label1, label2]
  #
  #   puts "*#{box.render(width: 30)}*"
  # end

  # it 'extra width' do
  #   box = Petui::Layout::HBox.new
  #   box.padding = 2
  #
  #   width -
  #   expect(box.extra_width(width: 15, children_width:  ))
  # end
end
