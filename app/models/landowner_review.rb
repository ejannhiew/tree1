class LandownerReview < Review
    belongs_to :landowner, class_name: "User"
end
