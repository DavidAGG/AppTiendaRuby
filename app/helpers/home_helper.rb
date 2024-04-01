module HomeHelper
    def carousel id,  content
        slides =  content.count
    
        note = ->(n){ "<h2 class=\"text-4xl\">#{n[:title]}</h2> <p class=\"text-xl\">#{n[:text]}</p> "}
    
        content_tag( :div, class:  %w( carousel slide carousel-fade carousel-dark  relative ), :"data-bs-ride" => 'carousel', id: id ) do
          content_tag( :div , class: %w( carousel-indicators absolute right-0 bottom-0 left-0 flex justify-center p-0 mb-4 ) ) do
          raw( (0 .. slides).map do | count |
              label =  "Slide #{count + 1}"
              raw(  if count.zero?
               content_tag( :button , nil,  type: 'button', :"data-bs-target" => "##{id}" , :"data-bs-slide-to" => count, :"aria-current" => "true", :"aria-label" => label, class: "active" )
                    else
               content_tag( :button , nil,  type: 'button', :"data-bs-target" => "##{id}" , :"data-bs-slide-to" => count, :"aria-label" => label )
                    end
                 )
            end.join)
          end +
           content_tag( :div, class: %w( carousel-inner relative w-3/2 overflow-hidden ) ) do
            raw( content.map.with_index do | c,index |
              h  = c.values.first
                # first image ist active
                class_attributes = index.zero? ? %w( carousel-item active relative float-left w-full ) : %w( carousel-item relative float-left w-full)
                content_tag( :div, class: class_attributes ) do
                  content_tag( :a,  href: "##{h[:link]}" ) do 
                  image_tag( h[:image]  , class: %w( block w-full)) +
                  content_tag( :div , raw(note[h]), class: %w( carousel-caption hidden sm:block absolute text-center ) )
                  end
                end
              end.join)
          end  +
          content_tag( :button, class: %w( carousel-control-prev absolute top-0 bottom-0 flex items-center justify-center p-0 text-center border-0 hover:outline-none hover:no-underline focus:outline-none focus:no-underline left-0 ),
                      type: 'button', :"data-bs-target" => "##{id}", :"data-bs-slide" => "prev") do
                          content_tag( :span, nil, class: %w( carousel-control-prev-icon inline-block bg-no-repeat ), :"aria-hidden" => "true") +
                          content_tag( :span, "Previous", class: "visually-hidden")
                                                                                                end +
          content_tag( :button, class: %w(carousel-control-next absolute top-0 bottom-0 flex items-center justify-center p-0 text-center border-0 hover:outline-none hover:no-underline focus:outline-none focus:no-underline right-0) ,
                      type: 'button', :"data-bs-target" => "##{id}", :"data-bs-slide"=> "next") do
                          content_tag( :span, nil, class: %w( carousel-control-next-icon inline-block bg-no-repeat ), :"aria-hidden" => "true") +
                          content_tag( :span, "Next", class: "visually-hidden")
                                                                                                end
        end
    
    
    end
end
