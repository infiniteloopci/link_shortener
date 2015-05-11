require 'rails_helper'

describe Link::Fetcher do
  subject { Link::Fetcher.new('foo') }
  let(:link) { build :link, view_count: 0 }

  it 'assigns token as variabley' do
    expect(subject.instance_variable_get('@token')).to eq 'foo'
  end

  describe 'get link' do
    it 'fetches link from database' do
      expect(Link).to receive(:find_by).with(token: 'foo').and_return(link)
      subject.get_link
    end

    it 'raises error if link with given token does not exists' do
      expect { subject.get_link }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'update_counter' do
    it 'increases view_count by 1' do
      subject.link = link
      expect { subject.update_counter }.to change { subject.link.view_count }.from(0).to(1)
    end
  end

  describe 'process_token' do
    it 'fetches token, update_counter and return link' do
      expect(described_class).to receive(:new).and_return(fetcher = double)
      expect(fetcher).to receive(:get_link).ordered
      expect(fetcher).to receive(:update_counter).ordered
      expect(fetcher).to receive(:link).ordered
      described_class.process_token('foo')
    end    
  end
end
