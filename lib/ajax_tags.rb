module AjaxTags
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper
  require "digest"

  class TagError < StandardError; end
  
  desc %{
    Encloses block in an HTML container that will be replaced by subsequent
    AJAX update call.

    <strong>Usage:</strong>

    <pre><code><r:ajax:update id="user_box" url="/users/box">Login</r:ajax:update></code></pre>

    <strong>Attributes:</strong>

    url: Required. Used for AJAX request.
    id: Optional. Default to some random string.

    <strong>Example output:</strong>

    <div id="user_box">Login</div>
    <script type="text/javascript">
      $(document).ready(function() {
        $("#user_box").load("/users/box");
      });
    </script>
  }
  
  tag "ajax:update" do |tag|
    raise TagError, 'ajax:update tag requires a "url" attribute.' unless tag.attr['url']

    id = tag.attr.delete('id') || Digest::MD5.hexdigest(Time.now.to_s)
    url = tag.attr.delete('url')

    "<div id=\"#{id}\">#{tag.expand}</div>
<script type=\"text/javascript\">
  $(document).ready(function() {
    $(\"##{id}\").load(#{url.inspect});
  });
</script>"
  end

  desc %{ Namespace for AJAX tags. }
  tag 'ajax' do |tag|
    tag.expand
  end
end