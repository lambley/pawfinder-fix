module ApplicationHelper
  def int_to_stars(average_rating, total)
    # Guard: return 0 if no average rating
    return 0 if average_rating.nil?

    # a => quotient - whole stars
    # b => remainder - part stars
    a, b = average_rating.divmod(1)
    c = total - (a + b).ceil
    # FA icons
    star_filled = '<i class="fa-solid fa-star star"></i>'
    star_half = '<i class="fa-solid fa-star-half-stroke star"></i>'
    star_empty = '<i class="fa-regular fa-star star"></i>'
    # html output
    html_result = []
    # add filled stars
    a.times do
      html_result << star_filled
    end
    # add half star if needed
    html_result << star_half unless b.nil? || b.zero?
    # add empty stars
    c.times do
      html_result << star_empty
    end
    html_result.join.html_safe
  end
end
