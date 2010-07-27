# module Meterdata
#
#   # Shamelessly copied from active_support cause I don't want a hard dependency on that
#
#   module Utils
#
#     # By default, +camelize+ converts strings to UpperCamelCase. If the argument to +camelize+
#     # is set to <tt>:lower</tt> then +camelize+ produces lowerCamelCase.
#     #
#     # +camelize+ will also convert '/' to '::' which is useful for converting paths to namespaces.
#     #
#     # Examples:
#     #   "active_record".camelize                # => "ActiveRecord"
#     #   "active_record".camelize(:lower)        # => "activeRecord"
#     #   "active_record/errors".camelize         # => "ActiveRecord::Errors"
#     #   "active_record/errors".camelize(:lower) # => "activeRecord::Errors"
#     def self.camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
#       if first_letter_in_uppercase
#         lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
#       else
#         lower_case_and_underscored_word.to_s[0].chr.downcase + camelize(lower_case_and_underscored_word)[1..-1]
#       end
#     end
#
#     # The reverse of +camelize+. Makes an underscored, lowercase form from the expression in the string.
#     #
#     # Changes '::' to '/' to convert namespaces to paths.
#     #
#     # Examples:
#     #   "ActiveRecord".underscore         # => "active_record"
#     #   "ActiveRecord::Errors".underscore # => active_record/errors
#     def self.underscore(camel_cased_word)
#       word = camel_cased_word.to_s.dup
#       word.gsub!(/::/, '/')
#       word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
#       word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
#       word.tr!("-", "_")
#       word.downcase!
#       word
#     end
#
#   end # module Utils
# end # module Meterdata


class Object

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  #
  # @return [Object] The constant corresponding to the name.
  def full_const_get(name)
    list = name.split("::")
    list.shift if list.first.strip.empty?
    obj = self
    list.each do |x|
      # This is required because const_get tries to look for constants in the
      # ancestor chain, but we only want constants that are HERE
      obj = obj.const_defined?(x) ? obj.const_get(x) : obj.const_missing(x)
    end
    obj
  end

end
