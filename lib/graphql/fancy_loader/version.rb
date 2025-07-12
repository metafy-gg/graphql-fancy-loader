module GraphQL
  class FancyLoader < (begin
    require 'graphql/dataloader'
    GraphQL::Dataloader::Source
  rescue LoadError
    BasicObject
  end)
    VERSION = '0.2.0'.freeze
  end
end
