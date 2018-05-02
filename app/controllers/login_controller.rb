class LoginController < ApplicationController

  def loginUser

    username = params[:username]
    password = params[:password]

    if  (( params.has_key?(:username) && !username.strip.empty? ) &&
         ( params.has_key?(:password) && !password.strip.empty? ))

       user = User.find_by_username(params[:username])

       if (user != nil)

         if (user.password == params[:password])
           # check for a admin ..  admin will go to admin page
           # admin's id is 'admin123'
           session[:user] = user.to_yaml
           flash.now[:alert] = nil

           if (user.username == "admin123")
             render "adminPage.html.erb"
           else
             # password validated.. Now show userInfo
             render "userInfo.html.erb"
           end
         else
           flash.now[:alert] ="Incorrect password entered!! please try again"
         end

       elsif

        if (params[:username] != nil)
           flash.now[:alert] = params[:username] + " does not exist, please sign up "
        end
       end

    end
  end

  def updateUserAdmin
     render "adminPage.html.erb"
  end

  def updateUser
     username = params[:username]
     #validate Username
     if ( params.has_key?(:username) && !username.strip.empty?)
       user = User.find_by_username(username)
       session[:user] = user.to_yaml

       user.update(:full_name => params[:full_name],
                   :street_address => params[:street_address],
                   :city => params[:city],
                   :state => params[:state],
                   :postal_code => params[:postal_code],
                   :country => params[:country],
                   :email_address => params[:email_address],
                   :username => params[:username],
                   :password => params[:password])

       session[:user] = user.to_yaml

       # @users = User.all
       # @hash = Gmaps4rails.build_markers(@users) do | user,marker |
       #   marker.lat user.latitude
       #   marker.lng user.longitude
       # end

       render "userInfo.html.erb"
     end

  end

  def createUser

    username = params[:username]

    #validate Username
    if ( params.has_key?(:username) && !username.strip.empty?)

      user = User.find_by_username(username)
      if (user != nil)
         flash.now[:alert] = username + " already in use.  Please pick new username"
         return
      else
         # now test for any duplicate email Addresses
         user1 = User.find_by_email_address(params[:email_address])
         if (user1 != nil)
            flash.now[:alert] = "Email enter is already in use..  Can not create an account!!"
         else

             flash.now[:alert] = username + " created"
             user = User.new(:full_name => params[:full_name],
                             :street_address => params[:street_address],
                             :city => params[:city],
                             :state => params[:state],
                             :postal_code => params[:postal_code],
                             :country => params[:country],
                             :email_address => params[:email_address],
                             :username => params[:username],
                             :password => params[:password])

             user.save

             session[:user] = user.to_yaml

             UserMailer.with(user: user).welcome_email.deliver

             render "userInfo.html.erb"

         end
      end


    end

  end

  def deleteUser
    if (session[:user] != nil)
      user = YAML.load(session[:user])
      user.destroy
    end

    session.clear
    render "loginUser.html.erb"

  end

  def logOut
    session.clear
    render "loginUser.html.erb"
    # back to loginPage
  end

  def recoverUser
    email_address = params[:email_address]
    if  ( params.has_key?(:email_address) && !email_address.strip.empty? )
        user = User.find_by_email_address(email_address)
        if (user != nil)
          flash.now[:alert] = "SEND EMAIL UserName:= " + user.username + ": Password:= " + user.password
          UserMailer.with(user: user).recovery_email.deliver
        else
          flash.now[:alert] = "Email address does not exist, please sign up"
        end
    end
  end



end
