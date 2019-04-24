Шандорчик, [24 квіт. 2019 р., 13:20:02]:
rails g rspec:controller posts

RSpec.describe PostsController, type: :controller do
    let!(:user) { build(:user, title: "Here is title", body: "Here is body") }

login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create Post" do
      get :new
      expect(subject.current_user.email).to eq("viktoriazavacka8@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)     
    end
  end

    describe 'POST #create' do
    it "should create Post" do
      post :create, params: {post: {title:"Here is title", body: "Here is body"}}
      expect(subject.current_user.post.title).to eq("Here is title")
      expect(subject.current_user.post.body).to eq("Here is body")
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit Post" do
      get :edit, xhr: true, format: :js, params: {id: subject.current_user.id}
      expect(subject.current_user.email).to eq("viktoriazavacka8@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  
  describe 'PATCH #update' do
   before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
    end  
    it "should update userparam and redirect to userparam" do
      patch :update, params: { id: subject.current_user.id, userparam: {title:"Here is title Updated", body: "Here is body Updated"}}
      expect(subject.current_user.post.title).to eq("Here is title Updated")
      expect(subject.current_user.post.body).to eq("Here is body Updated")
      expect(response).to redirect_to post_path
    end
  end


end