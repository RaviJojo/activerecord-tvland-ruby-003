require_relative 'spec_helper'

describe "Actor" do
  #TODO: implement the tests as described in the it blocks,
  #      and implement the class and migrations required to pass them

  # HINTS: look at show_spec.rb and network_spec.rb and character_spec.rb for guidance

  it "has a first and last name" do
    actor = Actor.find_or_create_by(:first_name => "Mandy", :last_name => "Patinkin")

    expect(Actor.find_by(:first_name => "Mandy")).to eq(actor)
    expect(Actor.find_by(:last_name => "Patinkin")).to eq(actor)

  end

  it "has associated characters in an array" do
    actor = Actor.find_or_create_by(:first_name => "Mandy", :last_name => "Patinkin")

    ren = Character.create(:name => "Ren")
    stimpy = Character.create(:name => "Stimpy")

    actor.characters << [ren, stimpy]

    expect(Actor.find_by(:first_name => "Mandy", :last_name => "Patinkin").characters.count).to eq(2)
    expect(Actor.find_by(:first_name => "Mandy", :last_name => "Patinkin").characters).to include(ren)
    expect(Actor.find_by(:first_name => "Mandy").characters).to include(stimpy)


    # Hint: think about what migration you'll need to write so that an actor can have many characters.
    # Where will the association foreign key go?
    # pending "set up the appropriate association for characters and add characters through the array push"
  end

  it "can build its associated characters" do
    actor = Actor.find_or_create_by(:first_name => "John", :last_name => "Malkovich")

    actor.characters.build(:name => "Malkovich Malkovich Malkovich")
    actor.characters.build(:name => "Lenny")
    actor.save

    expect(Actor.find_by(:first_name => "John", :last_name => "Malkovich").characters.count).to eq(2)    
    expect(Character.find_by(:name => "Malkovich Malkovich Malkovich").actor_id).to eq(actor.id)
    expect(Character.find_by(:name => "Lenny").actor_id).to eq(actor.id)

    # expect(Actor.find_by(:first_name => "John", :last_name => "Malkovich").characters.first.name).to eq("Malkovich Malkovich Malkovich")
    # expect(Actor.find_by(:first_name => "John", :last_name => "Malkovich").characters.last.name).to include(:name => "Lenny")
    

  end

  it "can build its associated shows through its characters" do

    actor = Actor.find_or_create_by(:first_name => "Javier", :last_name => "Bardem")

    actor.characters.build(:name => "Friendo", :show => Show.create(:name => "No Country For Old Men"))
    actor.save

    # pending "in one line, build a show and a character for this actor"
  end

  it "can list its full name" do
    actor = Actor.find_or_create_by(:first_name => "Woody", :last_name => "Harrelson")

    expect(actor.full_name).to eq("Woody Harrelson")
  end

  it "can list all of its shows and characters" do
    actor = Actor.find_or_create_by(:first_name => "Hank", :last_name => "Azaria")
    ren = Character.find_by(:name => "Ren")
    stimpy = Character.find_by(:name => "Stimpy")
    ren.show = Show.find_or_create_by(:name => "Ren and Stimpy")
    stimpy.show = Show.find_by(:name => "Ren and Stimpy")

    actor.characters << [ren, stimpy]
    expect(actor.list_roles).to eq("Ren - Ren and Stimpy\nStimpy - Ren and Stimpy")

    # pending "create a list_roles method"
    # TODO: build a method on actor that will return a string in the form of
    # character name - show name\n and test the results
  end
end
