module System
  class SortLink < Ransack::Helpers::FormHelper::SortLink
    def parameters_hash(params)
      params.to_unsafe_h
    end
  end
end
