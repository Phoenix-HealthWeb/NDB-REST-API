defmodule NdbRestApi.ObservationsTest do
  use NdbRestApi.DataCase

  alias NdbRestApi.Observations

  describe "observations" do
    alias NdbRestApi.Observations.Observation

    import NdbRestApi.ObservationsFixtures

    @invalid_attrs %{result: nil, ward: nil, date_time: nil}

    test "list_observations/0 returns all observations" do
      observation = observation_fixture()
      assert Observations.list_observations() == [observation]
    end

    test "get_observation!/1 returns the observation with given id" do
      observation = observation_fixture()
      assert Observations.get_observation!(observation.id) == observation
    end

    test "create_observation/1 with valid data creates a observation" do
      valid_attrs = %{result: "some result", ward: "some ward", date_time: ~U[2024-12-15 16:57:00Z]}

      assert {:ok, %Observation{} = observation} = Observations.create_observation(valid_attrs)
      assert observation.result == "some result"
      assert observation.ward == "some ward"
      assert observation.date_time == ~U[2024-12-15 16:57:00Z]
    end

    test "create_observation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Observations.create_observation(@invalid_attrs)
    end

    test "update_observation/2 with valid data updates the observation" do
      observation = observation_fixture()
      update_attrs = %{result: "some updated result", ward: "some updated ward", date_time: ~U[2024-12-16 16:57:00Z]}

      assert {:ok, %Observation{} = observation} = Observations.update_observation(observation, update_attrs)
      assert observation.result == "some updated result"
      assert observation.ward == "some updated ward"
      assert observation.date_time == ~U[2024-12-16 16:57:00Z]
    end

    test "update_observation/2 with invalid data returns error changeset" do
      observation = observation_fixture()
      assert {:error, %Ecto.Changeset{}} = Observations.update_observation(observation, @invalid_attrs)
      assert observation == Observations.get_observation!(observation.id)
    end

    test "delete_observation/1 deletes the observation" do
      observation = observation_fixture()
      assert {:ok, %Observation{}} = Observations.delete_observation(observation)
      assert_raise Ecto.NoResultsError, fn -> Observations.get_observation!(observation.id) end
    end

    test "change_observation/1 returns a observation changeset" do
      observation = observation_fixture()
      assert %Ecto.Changeset{} = Observations.change_observation(observation)
    end
  end
end
