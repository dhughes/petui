# frozen_string_literal: true

RSpec.describe Petui::Control::ProgressBar do
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

  # it 'calculates fractional width' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 8
  #
  #   expect(control.fractional_width).to eq(64)
  # end
  #
  # it 'calculates full blocks' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 8
  #   control.progress = 63.0 / 64.0
  #
  #   expect(control.full_blocks).to eq(7)
  # end
  #
  # it 'calculates the partial block' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 8
  #   control.progress = 63.0 / 64.0
  #
  #   expect(control.partial_block).to eq(1)
  # end
  #
  # it 'calculates full blocks on non-base 8 units' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 15
  #   control.progress = 14.5 / 15
  #
  #   expect(control.full_blocks).to eq(14)
  # end
  #
  # it 'calculates the partial blocks on whole non-base 8 units' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 15
  #   control.progress = 14.5 / 15
  #
  #   expect(control.partial_block).to eq(4)
  # end
  #
  # it 'calculates the partial blocks on whole non-base 8 units (2)' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 15
  #   control.progress = 14.625 / 15
  #
  #   expect(control.partial_block).to eq(5)
  # end
  #
  # it 'calculates the partial blocks on fractional non-base 8 units' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 15
  #   control.progress = 14.345 / 15
  #
  #   expect(control.partial_block).to eq(3)
  # end
  #
  # it 'calculates the partial and full blocks' do
  #   control = Petui::Control::ProgressBar.new
  #   control.width = 5
  #   control.progress = 0.585
  #
  #   expect(control.full_blocks).to eq(2)
  #   expect(control.blank_blocks).to eq(2)
  #   expect(control.partial_block).to eq(7) # 7 of 8
  # end
end