module RegistrationsHelper
  def link_for_attendees(event)
  if current_user != event.creator
   link_to "Join Playdate", registrations_path(event_id: event.id), method: "post" 
    else
      "Edit"
    end
  end
end
