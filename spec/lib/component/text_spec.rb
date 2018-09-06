
RSpec.describe Petui::Component::Text do
  describe '#render' do
    it 'renders text' do
      component = Petui::Component::Text.new('Hello World')

      expect(component.render).to eq('Hello World')
    end
  end

end
