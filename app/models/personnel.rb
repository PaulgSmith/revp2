class Personnel < ApplicationRecord
  has_many :reimbursement_request
  has_one :job
  has_one :login_token

  def authenticate(password)
    if pass == password
      true
    else
      false
    end
  end
end
