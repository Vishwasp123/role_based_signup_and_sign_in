require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:role){create(:role, name: "user")}
  let(:user) {create(:user, role: role)}
  let(:mail) {UserMailer.welcome(user)}

  it "Welcome wait for approve your request" do 
    expect(mail.subject).to eq("Welcome wait for approve your request")
  end

  it "Status Appove request"do
    expect(mail.subject).to eq("Welcome wait for approve your request")
  end
end
