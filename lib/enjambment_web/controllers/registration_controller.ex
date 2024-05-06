defmodule Enjambment.RegistrationController do
  use EnjambmentWeb, :controller
  
  def new(conn, _) do
    render(conn, "new.html")
  end
end
