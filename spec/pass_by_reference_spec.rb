describe "methods that mutate" do
  it "modifies an array" do
    instructors = ["Steven", "Avi"]
    add_instructor(instructors, "Joe")
    expect(instructors).to include("Joe")
  end
end

describe "methods that don't mutate" do
  it "returns a new array, but doesn't modify the existing array" do
    play_pals = ["Steven"]
    expect(be_friends_with(play_pals, "Avi")).to eq(["Steven", "Avi"])
    expect(play_pals).not_to include("Avi")
  end
end
