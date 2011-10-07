require_relative 'spinach/version'
require_relative 'spinach/config'
require_relative 'spinach/support'
require_relative 'spinach/exceptions'
require_relative 'spinach/runner'
require_relative 'spinach/parser'
require_relative 'spinach/dsl'
require_relative 'spinach/feature'
require_relative 'spinach/reporter'
require_relative 'spinach/cli'


# Spinach is a BDD framework in top of gherkin. Its main goals are:
#   * No magic: All features are implemented using actual classes.
#   * Reusability: Steps are methods, so they can be put inside modules.
#   * Proper encapsulation: No conflicts between steps from different
#     scenarios.
#
module Spinach
  @@features = []

  # @return [Array<Spinach::Feature>]
  #   all the registered features
  #
  def self.features
    @@features
  end

  # Resets Spinach to a pristine state, as if any feature was registered.
  # Mostly useful in Spinach's own testing.
  #
  def self.reset_features
    @@features = []
  end

  # Finds a feature given a feature name
  #
  # @param [String] name
  #   the feature name
  #
  def self.find_feature(name)
    klass = Spinach::Support.camelize(name)
    @@features.detect do |feature|
      feature.feature_name.to_s == name.to_s ||
      feature.name == klass
    end || raise(Spinach::FeatureNotFoundException, [klass, name])
  end
end