module Textile
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def textile(*attributes)
      @unicode = String.new.respond_to? :chars
      
      attributes.each do |attribute|
        define_method("#{attribute}_html",  proc { redcloth(__send__(attribute)) })
        define_method("#{attribute}_html_no_hard_breaks",  proc { redcloth_no_hard_breaks(__send__(attribute)) })
        define_method("#{attribute}_plain", proc { strip_redcloth(__send__(attribute))})
      end
    end
  end
  
  private
  def redcloth(source)
    return '' if source.nil?
    RedCloth.new(source, [:hard_breaks, :filter_html]).to_html    
  end

  def redcloth_no_hard_breaks(source)
    return '' if source.nil?
    RedCloth.new(source, [:filter_html]).to_html    
  end
  
  def strip_redcloth(source)
    returning redcloth(source).gsub(html_regexp, '') do |h|
      redcloth_glyphs.each do |(entity, char)|
        sub = [ :gsub!, entity, char ]
        @unicode ? h.chars.send(*sub) : h.send(*sub)
      end
    end
  end
  
  def redcloth_glyphs
     [[ '&#8217;', "'" ], 
      [ '&#8216;', "'" ],
      [ '&lt;', '<' ], 
      [ '&gt;', '>' ], 
      [ '&#8221;', '"' ],
      [ '&#8220;', '"' ],
      [ '&quot;', '"'],          
      [ '&#8230;', '...' ],
      [ '\1&#8212;', '--' ], 
      [ ' &rarr; ', '->' ], 
      [ ' &#8211; ', '-' ], 
      [ '&#215;', 'x' ], 
      [ '&#8482;', '(TM)' ], 
      [ '&#174;', '(R)' ],
      [ '&#169;', '(C)' ],
      [ '&#38;', '&'],
      [ '&amp;', '&']]
  end

  def html_regexp
    %r{<(?:[^>"']+|"(?:\\.|[^\\"]+)*"|'(?:\\.|[^\\']+)*')*>}xm
  end
end