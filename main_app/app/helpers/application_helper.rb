module ApplicationHelper

  def playdate_action_link(event, user)
    if user.events.any? { |e| e.id == event.id }
      link_to "Leave Playdate", registrations_path(event_id: event.id, user_id: user.id), method: "delete", class:"cbp-vm-icon cbp-vm-add join-playdate-button"
    else
      link_to "Join Playdate", registrations_path(event_id: event.id), method: "post", class:"cbp-vm-icon cbp-vm-add join-playdate-button"
    end
  end
end
