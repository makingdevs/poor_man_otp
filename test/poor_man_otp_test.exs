defmodule PoorManOtpTest do
  use ExUnit.Case
  doctest PoorManOtp

  test "greets the world" do
    assert PoorManOtp.hello() == :world
  end
end
