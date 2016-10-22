class Module
  def attribute(name, &block)
    var = name.to_a.first if name is_a? Hash

    define_method ("#{var}=") do |value|
      instance_variable_set("#{var}", value)
    end

    define_method ("#{var}==") do |other_var|
      instance_variable_get("#{var}") == other_var
    end

    define_method ("#{var}") do
      if instance_variable_defined?("#{var}")
        instance_variable_get("#{var}")
      else
        instance_variable_set("#{var}", (block ? instance_eval(&block) : name))
      end
    end
  end
end
