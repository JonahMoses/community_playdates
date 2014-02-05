module RegistrationsHelper
  def link_visible_to_attendees(event)
    # if current_user == event.creator
    #   link_to "Edit Playdate", edit_event_path(event)
    # else
    link_to "Join Playdate", registrations_path(event_id: event.id), method: "post"
    # end
  end
end
