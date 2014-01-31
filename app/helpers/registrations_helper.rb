module RegistrationsHelper
  def link_visible_to_attendees(event)
    if current_user == event.creator
      "Edit"
    else
    link_to "Join Playdate", registrations_path(event_id: event.id), method: "post"
    end
  end
end
