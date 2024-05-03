# frozen_string_literal: true

class RenameSubjectToResourcInNotifications < ActiveRecord::Migration[7.0]
  def change
    remove_reference :notifications, :subject, polymorphic: true
    add_reference :notifications, :resource, polymorphic: true
  end
end
