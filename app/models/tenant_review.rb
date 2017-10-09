class TenantReview < Review
  belongs_to :tenant, class_name: "User"
end
