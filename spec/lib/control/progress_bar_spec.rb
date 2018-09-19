# frozen_string_literal: true

RSpec.describe Petui::Control::ProgressBar do
  it 'has a preferred width' do
    control = Petui::Control::ProgressBar.new

    expect(control.preferred_width).to eq(10)
  end

  it 'preferred width is at least the minimum width' do
    control = Petui::Control::ProgressBar.new
    control.preferred_width = 10
    control.minimum_width = 20

    expect(control.preferred_width).to eq(20)
  end

  it 'has a minimum width' do
    control = Petui::Control::ProgressBar.new
    control.minimum_width = 20

    expect(control.minimum_width).to eq(20)
  end

  it 'has a maximum width' do
    control = Petui::Control::ProgressBar.new
    control.maximum_width = 20

    expect(control.maximum_width).to eq(20)
  end

  describe '#render' do
    it 'renders at the specified width' do
      control = Petui::Control::ProgressBar.new

      expect(control.render).to eq('          ')
    end

    it 'renders 0% complete' do
      control = Petui::Control::ProgressBar.new
      control.progress = 0

      expect(control.render).to eq('          ')
    end

    it 'renders 50% complete' do
      control = Petui::Control::ProgressBar.new
      control.progress = 0.5

      expect(control.render(width: 8)).to eq('████    ')
    end

    it 'renders 100% complete' do
      control = Petui::Control::ProgressBar.new
      control.progress = 1

      expect(control.render(width: 8)).to eq('████████')
    end

    it 'renders fractional completion' do
      control = Petui::Control::ProgressBar.new
      control.progress = 0.585

      expect(control.render(width: 5)).to eq('██▉  ')
    end

    it 'renders in color' do
      control = Petui::Control::ProgressBar.new
      control.progress = 0.585
      control.color = :red
      control.background_color = 'gold'

      expect(control.render(width: 5)).to eq("\e[31;48;5;226m██▉  \e[0m")
    end

    it 'raises an error if width is less than the minimum' do
      control = Petui::Control::ProgressBar.new

      expect { control.render(width: 0) }.to raise_error('Width less than minimum.')
    end

    it 'raises an error if width is greater than the maximum' do
      control = Petui::Control::ProgressBar.new
      control.maximum_width = 20

      expect { control.render(width: 21) }.to raise_error('Width greater than maximum.')
    end
  end
end
