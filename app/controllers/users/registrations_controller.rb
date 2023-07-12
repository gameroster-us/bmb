class Users::RegistrationsController < Devise::RegistrationsController
  skip_after_action :verify_authorized

  def create
    super do |user|
      if user.persisted?
        p user
        send_sms_verification_code(user) # Pass the user as an argument to the method
        # generate_and_save_otp(user)
        # sign_in(user) # Sign in the user after successful registration if desired
        redirect_to verify_otp_path(user_id: user.id) and return
      end
    end
  end
  

  def send_sms_verification_code(user) # Accept the user as a parameter
    account_sid = 'AC489da7c9dbf2cd29f7df83101b56d40b'
    auth_token = '0206706a3a3e94f1171e097cc3653bb3'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    p    user.phone_number  
    message = @client.messages.create(
      body: "this is the otp #{generate_and_save_otp(user)}", # Corrected the string interpolation syntax
      messaging_service_sid: 'MGa4558d42b2a3db7fe4d8f66e415e0fd3',
      to: "+91#{user.phone_number}"
    )

    puts message.sid
  end

  def verify_otp
    p "111111111111"
    u =  params[:user_id]
    user = User.find(u)
    p user 
    # user = current_user
    p "111111111111"
    if user&.checkotp == params[:checkotp]
      p "222222222222222222"
      # OTP verification successful, proceed with sign-up
      user.update(checkotp: nil) # Remove the OTP after successful verification
      sign_in(user) # Sign in the user if desired
      redirect_to organizations_path, notice: "Account verified successfully!"
    elsif params[:checkotp].present?
      p "33333333"
      flash.now[:alert] = "Enter a Valid OTP Which you Recieved Via Text Message"
      render :verify_otp
    end
  end


  private

  def generate_and_save_otp(user)
    checkotp = generate_otp # Implement your logic to generate an OTP
    user.update(checkotp: checkotp)
    return checkotp
  end

  def generate_otp
    # Implement your logic to generate an OTP (e.g., using SecureRandom or other methods)
    SecureRandom.random_number(100000..999999).to_s
  end

  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone_number)
  end

end
