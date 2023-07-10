class Users::RegistrationsController < Devise::RegistrationsController
    def create
        super do |user|
            if user.persisted?
              generate_and_save_otp(user)
              sign_in(user) # Sign in the user after successful registration if desired
              redirect_to verify_otp_path
            end
          end
    end
  
    private
  
    def send_sms_verification_code(user)
        client = Twilio::REST::Client.new('AC489da7c9dbf2cd29f7df83101b56d40b', '8582e4e474ec259ae74a20de02f22fd4')

  
      message = client.messages.create(
        body: 'Otp For Slot Booking App',
        messaging_service_sid: 'MGa4558d42b2a3db7fe4d8f66e415e0fd3',
        to: '+917984471511'
      )
  
      # You can add error handling for failed SMS sending here if needed
    end

    def verify_otp
        user = current_user
        if user&.otp == params[:otp]
          # OTP verification successful, proceed with sign-up
          user.update(otp: nil) # Remove the OTP after successful verification
          sign_in(user) # Sign in the user if desired
          redirect_to root_path, notice: "Account verified successfully!"
        else
          flash.now[:alert] = "Invalid OTP"
          render :verify_otp
        end
      end
 
  
    private

    def generate_and_save_otp(user)
      otp = generate_otp # Implement your logic to generate an OTP
      user.update(otp: otp)
    end
  
    def generate_otp
      # Implement your logic to generate an OTP (e.g., using SecureRandom or other methods)
      SecureRandom.random_number(100000..999999).to_s
    end
  
  end
  