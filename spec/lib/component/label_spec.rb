
RSpec.describe Petui::Component::Label do
  describe '#render' do
    it 'renders text' do
      component = Petui::Component::Label.new('Hello World')

      expect(component.render).to eq(['Hello World'.split('')])
    end
  end

end
