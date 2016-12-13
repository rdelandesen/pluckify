module Pluckify
  module Core
    extend ActiveSupport::Concern

    module ClassMethods

      ##
      # Allows you to pluck to Hash, OpenStruct or any custom class like presenters
      #
      #   # Hash (only column name args)
      #   User.limit(10).pluckify(:id, :first_name, 'users.last_name as last_name')
      #   # => [ { id: 1, first_name: 'Romain', last_name: 'de Landesen' } ]
      #
      #   # OpenStruct
      #   Administrator.where(id: 1).pluckify(:id, :first_name, :last_name, OpenStruct)
      #   # => [ #<OpenStruct id=1, first_name="Romain", last_name="de Landesen"> ]
      #
      #   # Custom Presenter
      #   Administrator.pluckify(:id, :first_name, :last_name, AdministratorPresenter)
      #   # => [ #<AdministratorPresenter @model=#<OpenStruct id=1, first_name="Judge", last_name="Dredd">> ]
      #
      def pluckify(*column_names)
        presenter = column_names[-1]
        klass     = presenter.class

        if [String, Symbol].include?(klass)
          klass = Hash
        else
          column_names.pop
        end

        rows = pluck(*column_names).map do |row|
          Hash[pluckify_keys(column_names).zip(Array(row))]
        end

        rows.present? && klass != Hash ? pluckify_collection(rows, presenter) : rows
      end

      private

      ##
      # Format the String keys
      # Excludes anything else that a String or a Symbol
      #
      def pluckify_keys(keys)
        keys.map do |k|
          case k
            when String
              k.split.last # e.g. 'users.id as id' => 'id'
            when Symbol
              k
          end
        end
      end

      ##
      # Instanciates each row
      #
      def pluckify_collection(rows, presenter)
        # Presenter class with `collection` class method
        if presenter.respond_to? :collection
          presenter.collection(rows)

        # e.g. OpenStruct
        else
          rows.map { |row| presenter.new(row) }
        end
      end
    end

  end
end

ActiveRecord::Base.send(:include, Pluckify::Core)