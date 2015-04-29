class ContactsController < AboutController
	def index
    	#@contacts = Contact.all
  	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(params[:contact])

		if @contact.save
			begin
            	ContactMailer.contact_email(@contact).deliver
            	render :action => 'thanks'
        	rescue
            	render :action => 'error'
        	end
		else
		  	render :action => 'new'
		end
	end

	def thanks
    end

    def error
    end

end
