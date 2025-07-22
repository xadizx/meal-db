module ApplicationHelper
  def main_nav_link(path, label)
    if current_page?(path)
      link_to(label, path, class: "inline-flex items-center border-b-2 border-indigo-500 px-1 pt-1 text-sm font-medium text-gray-900")
    else
      link_to(label, path, class: "inline-flex items-center border-b-2 border-transparent px-1 pt-1 text-sm font-medium text-gray-500 hover:border-gray-300 hover:text-gray-700")
    end
  end

  def mobile_nav_link(path, label)
    if current_page?(path)
      link_to(label, path, class: "block border-l-4 border-indigo-500 bg-indigo-50 py-2 pl-3 pr-4 text-base font-medium text-indigo-700")
    else
      link_to(label, path, class: "block border-l-4 border-transparent py-2 pl-3 pr-4 text-base font-medium text-gray-600 hover:border-gray-300 hover:bg-gray-50 hover:text-gray-800")
    end
  end
end
