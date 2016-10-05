defmodule Cdmioid do
  @moduledoc """
  Generate a CDMI Object ID and a key suitable for use in a Riak cluster.
  """

  def generate(enterprise_number, oid_length \\ 40) do
    prefix = <<0, enterprise_number :: size(24), 0, oid_length>>
    crc = Elcrc16.crc16(prefix <> <<0, 0>>)
    new_prefix = Base.encode16(prefix <> <<crc :: size(16)>>)
    uuid = UUID.uuid4(:hex)
    key = uuid <> new_prefix
    oid = new_prefix <> uuid
    {oid, key}
  end

end
