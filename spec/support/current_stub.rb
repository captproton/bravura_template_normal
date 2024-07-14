# frozen_string_literal: true

# spec/support/current_stub.rb
module CurrentStub
  def stub_current_account(account)
    allow(Current).to receive(:account).and_return(account)
  end
end

# Create a stub Current class if it doesn't exist
unless defined?(Current)
  class Current
    def self.account
      # This will be stubbed in tests
    end
  end
end
