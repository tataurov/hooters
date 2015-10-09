Paperclip.options[:command_path] = '/usr/local/bin/'

Paperclip::Attachment.default_options.merge!(
  :url => '/system/images/:class/:id_partition/:style/:filename',
  :path => ':rails_root/public:url'
)