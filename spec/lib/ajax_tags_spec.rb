require File.dirname(__FILE__) + '/../spec_helper'

describe AjaxTags do
  dataset :pages

  describe '<r:ajax:update id="user_box" url="/users/box">' do
    it 'should render the correct HTML' do
      tag = '<r:ajax:update id="user_box" url="/users/box">Login</r:ajax:update>'

      expected = %{<div id="user_box">Login</div>
<script type="text/javascript">
  $(document).ready(function() {
    $("#user_box").load("/users/box");
  });
</script>}

      pages(:home).should render(tag).as(expected)
    end
  end
end