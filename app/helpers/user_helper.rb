module UserHelper
  def full_name(user)
    [user.name, user.surname].join(' ')
  end

  def format_cpf(user)
    user.document.gsub(/([0-9]{3})|([0-9]{2})/) do |number_block|
      number_block.length == 3 ? number_block + '.' : '-' + number_block
    end.gsub('.-','-')
  end
end

