# frozen_string_literal: true

class DeviseCustomMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    opts[:from] = record.domain == 'www.domain.com' ? 'joko@gmail.com' : 'jaka@gmail.com'
    super
  end
end
