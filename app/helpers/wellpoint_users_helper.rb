module WellpointUsersHelper

  def wp_user_html(wp_user)
    "<div class='chosen-option'><div class='first-line'>" + wp_user.name + "</div>" + wp_user_data(wp_user) + "</div>"
  end
  
  def wp_user_data(wp_user)
    "<div class='additional-line'>" + "Eligible: #{wp_user.is_fully_eligible? ? 'Yes' : 'No'}" + "</div>"
  end

end
