module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def flasher(flash)
    if flash.now[:alert]
      "<div class='notification is-danger global-notification'>
        <p class='alert'>#{alert}</p>
      </div>".html_safe
    elsif flash.now[:notice]
      "<div class='notification is-info global-notification'>
        <p class='notice'> #{notice} </p>
      </div>".html_safe
    end
  end

  def sign_in_out
    if current_user
      link_to 'Sign out', destroy_user_session_path, method: :delete
    else
      link_to 'Sign in', user_session_path
    end
  end

  def my_friends_link
    menu_link_to 'My Friends', "/users/#{current_user.id}/friendships" if current_user
  end

  def logged_name
    link_to current_user.name, "/users/#{current_user.id}" if current_user
  end
end
