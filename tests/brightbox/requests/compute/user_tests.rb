Shindo.tests('Brightbox::Compute | user requests', ['brightbox']) do

  tests('success') do

    tests("#list_users()").formats(Brightbox::Compute::Formats::Collection::USERS) do
      data = Brightbox[:compute].list_users()
      @user_id = data.first["id"]
      data
    end

    tests("#get_user('#{@user_id}')").formats(Brightbox::Compute::Formats::Full::USER) do
      data = Brightbox[:compute].get_user(@user_id)
      @original_name = data["name"]
      data
    end

    update_options = { :name => "New name from Fog" }
    tests("#update_user('#{@user_id}', #{update_options.inspect})").formats(Brightbox::Compute::Formats::Full::USER) do
      Brightbox[:compute].update_user(@user_id, update_options)
    end
    Brightbox[:compute].update_user(@user_id, :name => @original_name)

  end

  tests('failure') do

    tests("#update_user()").raises(ArgumentError) do
      Brightbox[:compute].update_user()
    end

  end

end
