module ApplicationHelper
  def sort_link(search_object, attribute, *args, &block)
    search, routing_proxy = extract_search_and_routing_proxy(search_object)
    unless Ransack::Search === search
      raise TypeError, 'First argument must be a Ransack::Search!'
    end
    args.unshift(capture(&block)) if block_given?
    s = System::SortLink.new(search, attribute, args, params, &block)
    link_to(s.name, url(routing_proxy, s.url_options), s.html_options(args))
  end

  def get_chart chart_data
    LazyHighCharts::HighChart.new('chart') do |f|
      # f.title({text: chart_data[:title]})
      f.options[:xAxis][:type] = 'datetime'
      f.options[:tooltip][:shared] = true,
      f.options[:tooltip][:crosshairs] = true,
      f.series(type: 'spline', name: '(ABEV3,CIEL3)', data: chart_data[:residues], marker: {enabled: false})
      f.series(type: 'arearange', name: 'Desvio', data: chart_data[:desvio], zIndex: 0, fillOpacity: 0.3)
    end
  end
end
