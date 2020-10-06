class Types::Enum::JobType < Types::Enum::Base
  value "ACTIVE", 'job is active', value: "active"
  value "COMPLETED", 'job was completed', value: "completed"
end