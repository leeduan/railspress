require 'rails_helper'

describe Upload do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should have_attached_file(:media) }
  it { should validate_attachment_presence(:media) }
  it { should validate_attachment_content_type(:media)
    .allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg', 'video/mpeg',
              'video/mp4', 'video/ogg', 'audio/mp4', 'audio/mpeg', 'audio/ogg',
              'application/gzip', 'application/json')
    .rejecting('text/plain', 'text/xml') }

  describe '#sluggify_file_name' do
    it 'should save the new file' do
      image = Fabricate(:upload)
      expect(image.media_file_name).to eq('placeholder3d15e3a5eaae04842667502103f994d8.gif')
    end

    context '#to_slug' do
      it 'renames file to contain only alphanumeric characters' do
        image_upload = ActionDispatch::Http::UploadedFile.new({
          filename: 'placeholder #$ 3d15e3a5eaae04842667502103f994d8.gif',
          type: 'image/gif',
          tempfile: File.new("#{Rails.root}/spec/fixtures/images/placeholder #$ 3d15e3a5eaae04842667502103f994d8.gif")
        })
        image = Fabricate(:upload, media: image_upload)
        expect(image.media_file_name).to eq('placeholder-3d15e3a5eaae04842667502103f994d8.gif')
      end
    end

    context '#increment_filename' do
      it 'increments filename if file already exists' do
        image = Fabricate(:upload)
        duplicate_image = Fabricate(:upload)
        expect(duplicate_image.media_file_name).to eq('placeholder3d15e3a5eaae04842667502103f994d8-1.gif')
        duplicate_image_2 = Fabricate(:upload)
        expect(duplicate_image_2.media_file_name).to eq('placeholder3d15e3a5eaae04842667502103f994d8-2.gif')
      end
    end
  end
end