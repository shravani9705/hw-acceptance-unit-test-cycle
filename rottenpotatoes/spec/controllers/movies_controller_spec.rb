require 'rails_helper'

describe MoviesController do


    describe "#search_director" do

        context "When specified movie has a director" do
            
            it "should find movies with the same director" do
            
            @movie_id="1234"
            @movie=double('fake_movie', :director => 'Tarantino')
            
            expect(Movie).to receive(:find).and_return(@movie)
            expect(Movie).to receive(:search_director)
            
            get :search_director, id:  @movie
            
            expect(response).to render_template(:search_director)
        end
    end
        context "When specified movie has no director" do
            it "should redirect to the movies page" do
            @movie_id="1234"
            @movie=double('fake_movie').as_null_object
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :search_director, :id => @movie_id
            expect(response).to redirect_to(root_path)
            
            end
        end
    end

  describe "#create" do
    it "should create movie with provided parameters" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        @defaults = { :title => "Terrible Movie", :rating => "G", :director => "Dr. V" }
        expect(Movie).to receive(:create!).and_return(@movie)
        post :create, :movie => @defaults
        expect(response).to redirect_to(movies_path)
    end
  end
  describe "#show" do
    it "should display details about an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :show, :id => @movie_id
        expect(response).to render_template(:show)
    end
  end
  describe "#destroy" do
    it "should delete the specific movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
        expect(@movie).to receive(:destroy)
        delete :destroy, :id => @movie_id
        expect(response).to redirect_to(movies_path)
    end
  end
  describe "#edit" do
    it "should edit an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :edit, :id => @movie_id
        expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    let(:movie_params) {{title: "Star Wars", rating: "P", release_date: "1977-05-25"}}
    it "should update an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        put :update,  {:id => @movie_id, movie: movie_params}
        expect(response).to redirect_to(movie_path(@movie))
    end
  end
  
  describe 'get all movies' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end  
    it 'should call the all ratings function from Movie' do
      Movie.should_receive(:all_ratings).and_return( %w(G PG PG-13 NC-17 R));
      get :index
    end
  end  

  describe "#new" do
    it "should render the new template" do
      get :new 
        expect(response).to render_template(:new)
    end
  end
end
