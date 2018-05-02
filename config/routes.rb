Rails.application.routes.draw do

  root :to => 'login#loginUser'

  get "loginUser" => "login#loginUser"
  get "createUser" => "login#createUser"
  get "recoverUser" => "login#recoverUser"

  get "deleteUser" => "login#deleteUser"
  get "updateUser" => "login#updateUser"
  get "logOut" => "login#logOut"

  get "updateUserAdmin" => "login#updateUserAdmin"
end
