#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module RuboCop
  module Cop
    module Chef
      module ChefModernize
        # There is no need for an empty initialize method in a resource
        #
        # @example
        #
        #   # bad
        #   def initialize(*args)
        #     super
        #   end
        #
        class EmptyResourceInitializeMethod < Cop
          MSG = 'There is no need for an empty initialize method in a resource'.freeze

          def_node_matcher :empty_initialize?, <<-PATTERN
            (def :initialize (args (restarg :args)) (zsuper))
          PATTERN

          def on_def(node)
            empty_initialize?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
