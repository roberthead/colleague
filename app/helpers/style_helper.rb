module StyleHelper
  # Returns classes in the Block-Element-Modifier organizational style.
  # returns a string with the block joined to an optional element with '__'
  # for each modifier, returns strings with that modifier appended (joined with '--')
  # Examples:
  #   block_element_modifier_classes('a') # => ['a']
  #   block_element_modifier_classes('a', 'b') # => ['a__b']
  #   block_element_modifier_classes('a', nil, 'c') # => ['a', 'a--c']
  #   block_element_modifier_classes('a', 'b', 'c') # => ['a__b', 'a__b--c']
  #   block_element_modifier_classes('a', 'b', ['c', 'd']) # => ['a__b', 'a__b--c', 'a__b--d']
  def block_element_modifier_classes(block, element = nil, modifiers = [])
    block_element = [block, element].select(&:present?).join('__')
    [block_element].tap { |css_classes|
      [modifiers].flatten.select(&:present?).map do |modifier|
        css_classes << [block_element, modifier].join('--')
      end
    }.uniq
  end
  alias_method :bem, :block_element_modifier_classes
end
