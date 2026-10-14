# Gera um slug a partir de um atributo (ex.: nome) quando o slug está vazio.
# Em caso de colisão acrescenta um sufixo numérico: "brecho-da-ana", "brecho-da-ana-2"...
module Sluggable
  extend ActiveSupport::Concern

  class_methods do
    def slug_from(attribute, scope: nil)
      before_validation do
        if slug.blank? && self[attribute].present?
          self.slug = unique_slug_for(self[attribute].to_s.parameterize, scope)
        end
      end
    end
  end

  private
    def unique_slug_for(base, scope)
      base = base.presence || "item"
      candidate = base
      counter = 2
      while slug_taken?(candidate, scope)
        candidate = "#{base}-#{counter}"
        counter += 1
      end
      candidate
    end

    def slug_taken?(candidate, scope)
      relation = self.class.where(slug: candidate).where.not(id: id)
      relation = relation.where(scope => self[scope]) if scope
      relation.exists?
    end
end
