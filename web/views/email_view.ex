defmodule EmailReports.EmailView do
  use EmailReports.Web, :view

  def expires(raw_date) do
    {:ok, date} = Date.from_iso8601(raw_date)
    "#{date.month}/#{date.day}/#{date.year}"
  end

  def auto_renew(true), do: "on"
  def auto_renew(false), do: "off"
end
