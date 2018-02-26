defmodule XConf.ConferenceTest do
  use XConf.DataCase

  alias XConf.Conference

  @sample_attrs %{code: "some-conf", name: "Some Conf"}

  test "changeset with valid attributes" do
    changeset = Conference.changeset(%Conference{}, @sample_attrs)
    assert changeset.valid?
  end

  test "changeset with attribute code left blank" do
    changeset = Conference.changeset(%Conference{}, Map.delete(@sample_attrs, :code))
    refute changeset.valid?
    changeset = Conference.changeset(%Conference{}, Map.put(@sample_attrs, :code, ""))
    refute changeset.valid?
  end

  test "changeset with attribute name left blank" do
    changeset = Conference.changeset(%Conference{}, Map.delete(@sample_attrs, :name))
    refute changeset.valid?
    changeset = Conference.changeset(%Conference{}, Map.put(@sample_attrs, :name, ""))
    refute changeset.valid?
  end
end
