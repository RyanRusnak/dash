class Document
  include Mongoid::Document

  require 'csv'

  has_many :abstracts, :dependent => :destroy
  has_many :codes, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  field  :year, type: String
  field  :project_number_base, type: String
  field  :application_id, type: String
  field  :activity_code, type: String
  field  :mechanism, type: String
  field  :project_title, type: String
  field  :investigator, type: String
  field  :cong_district, type: String
  field  :location, type: String
  field  :institution, type: String
  field  :project_type, type: String
  field  :total_sic_dollars, type: String
  field  :total_spc_dollars, type: String
  field  :total_international_dollars, type: String
  field  :obligated_dollars, type: String
  field  :aids_dollars, type: String
  field  :aids_percent, type: String
  field  :award_count, type: String
  field  :project_count, type: String
  field  :appl_id, type: String
  field  :i2_project_num, type: String
  field  :i2_subproject_id, type: String
  field  :fut_yrs, type: String
  field  :project_period_start_date, type: String
  field  :project_period_end_date, type: String
  field  :appl_period_start_date, type: String
  field  :appl_period_end_date, type: String
  field  :expire_fy, type: String
  field  :sub_project_flag, type: String
  field  :project_flag, type: String
  field  :i2_total_obligation, type: String
  field  :study_section, type: String
  field  :percentile, type: String
  field  :priority_score, type: String
  field  :tags, type: Array
  field  :status, type: String

  def self.short_list(documents, att_name)
    documents = documents.group_by{ |document|
          document.read_attribute(att_name)
        }
        totals = []
        documents.keys.each do |key|
          sub = {}
          sub[:label] = key
          sub[:value] = documents[key].count
          totals << sub
        end
        @documents = totals.sort_by { |x, y| x[:label] }
  end

  def self.short_list_dollars(documents, att_name)
    documents = documents.group_by{ |document|
          document.read_attribute(att_name)
        }
        totals = []
        documents.keys.each do |key|
          sub = {}
          sub[:label] = key
          sub[:value] = documents[key].map{|e| e.aids_dollars.to_i}.reduce(:+)
          totals << sub
        end
        @documents = totals.sort_by { |x, y| x[:label] }
  end

  def self.tag_list(documents, att_name)
    documents = documents.group_by{ |document|
          document.read_attribute(att_name)
        }
        totals = []
        documents.keys.each do |key|
          sub = {}
          sub[:label] = key[0]['text'] rescue nil
          sub[:value] = documents[key].count
          totals << sub
        end
        @documents = totals
  end

  def self.last_updated(documents, att_name)
    documents = documents.group_by{ |document|
          document.posts.last.read_attribute(att_name).year rescue nil
        }
        totals = []
        documents.keys.each do |key|
          sub = {}
          sub[:label] = key
          sub[:value] = documents[key].count
          totals << sub
        end
        @documents = totals.sort_by { |x, y| x[:label] }
  end

  def self.import(file)
    csv = CSV.new(file.read, :headers => true, :header_converters => :symbol)
    cats = csv.to_a.map {|row| 
      row.to_hash 
      Document.create({
        :year => row[:year], 
        :project_number_base => row[:project_number_base], 
        :application_id => row[:application_id], 
        :activity_code => row[:activity_code], 
        :mechanism => row[:mechanism], 
        :project_title => row[:project_title], 
        :investigator => row[:investigator], 
        :cong_district => row[:cong_district], 
        :location => row[:location], 
        :institution => row[:institution], 
        :project_type => row[:project_type], 
        :total_sic_dollars => row[:total_sic_dollars], 
        :total_spc_dollars => row[:total_spc_dollars], 
        :total_international_dollars => row[:total_international_dollars], 
        :obligated_dollars => row[:obligated_dollars], 
        :aids_dollars => row[:aids_dollars], 
        :aids_percent => row[:aids_percent], 
        :award_count => row[:award_count], 
        :project_count => row[:project_count], 
        :appl_id => row[:appl_id], 
        :i2_project_num => row[:i2_project_num], 
        :i2_subproject_id => row[:i2_subproject_id], 
        :fut_yrs => row[:fut_yrs], 
        :project_period_start_date => row[:project_period_start_date], 
        :project_period_end_date => row[:project_period_end_date], 
        :appl_period_start_date => row[:appl_period_start_date], 
        :appl_period_end_date => row[:appl_period_end_date], 
        :expire_fy => row[:expire_fy], 
        :sub_project_flag => row[:sub_project_flag], 
        :project_flag => row[:project_flag], 
        :i2_total_obligation => row[:i2_total_obligation], 
        :study_section => row[:study_section], 
        :percentile => row[:percentile], 
        :priority_score => row[:priority_score] 
      })
    }
    return 'success'
  end

  def self.code_import(file)
    csv = CSV.new(file.read, :headers => true, :header_converters => :symbol)
    cats = csv.to_a.map {|row| 
      row.to_hash 

      # find the corresponding document by appl_id
      docs = Document.where({:appl_id=>row[:appl_id]})
      # if there is more than one, match by the year
      if docs
        docs.each do |d|
          if d.year = row[:fy]
            body = row[:abstract_text].encode('utf-8', :invalid => :replace, :undef => :replace) unless row[:abstract_text].blank?
            # create an abstract child record
            d.abstracts.create({
              :fy => row[:fy],
              :project_num => row[:project_num],
              :abstract_text => body
              })
            # create a code child record for each code
            codes = row[:sp_code].split(',')
            codes.each do |c| 
              d.codes.create({:code => c})
            end
          end
        end
      end
    }
    return 'success'
  end

end
