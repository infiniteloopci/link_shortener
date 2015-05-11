require 'rails_helper'

describe Link do
  subject { build :link }

  it 'has valid factory' do
    link = build(:link)
    expect(link).to be_valid
  end

  it 'validates url presence' do
    link = build(:link, url: '')
    expect(link).not_to be_valid
  end

  it 'validates url format' do
    link = build(:link, url: 'invalidurl')
    expect(link).not_to be_valid
  end

  describe 'token' do
    it 'is generated on creation' do
      expect(subject.token).to be_nil
      subject.save
      expect(subject.token).to match /[A-Za-z0-9_\-]{6}/
    end

    it 'is generated uniquely' do
      non_unique_token = described_class.generate_token
      unique_token = described_class.generate_token

      # Create first link
      link = build(:link)
      expect(described_class).to receive(:generate_token) { non_unique_token }
      link.save!

      # Create second link
      link = build(:link)
      expect(described_class).to receive(:generate_token).twice.and_return(non_unique_token, unique_token)
      link.save!
    end
  end
end
