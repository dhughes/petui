RSpec.describe Petui::Component::Box do
  describe '#render' do
    it 'renders a box' do
      component = Petui::Component::Box.new(width: 5, height: 5)

      expect(component.render).to eq([
                                       ['┌', '─', '─', '─', '┐'],
                                       ['│', ' ', ' ', ' ', '│'],
                                       ['│', ' ', ' ', ' ', '│'],
                                       ['│', ' ', ' ', ' ', '│'],
                                       ['└', '─', '─', '─', '┘']
                                     ])
    end
  end

end
