require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do end
    it 'is invalid without title' do end
    it 'is invalid without status' do end
    it 'is invalid with a duplicate title' do end
    it 'is valid with another title' do end
  end
end
