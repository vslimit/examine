#encoding:utf-8
class ExaminesController < ApplicationController
  skip_before_filter :check_login

  def show
    @subjects = Subject.all.shuffle
    subject_hash = {}
    profiles = Profile.where(:dic_type => Profile::SUBJECT_PROFILE)
    profiles.each do |profile|
      subject_hash[profile.dic_key] = @subjects.select { |x| x.code == profile.dic_key }[0..profile.dic_value.to_i]
    end

    @else_subjects = []
    @safe_subjects = []
    subject_hash.each do |k, v|
      #if k.include?('SAFE')
      #  @safe_subjects += v
      #else
      #  @else_subjects += v
      #end
      k.include?('SAFE') ? @safe_subjects += v : @else_subjects += v
    end
  end

  def examine
    p 123123
    p params
  end

end
