#encoding:utf-8
class ExaminesController < ApplicationController

  layout :false,:only => :examine

  def show
    @subjects = Subject.where('air like ?', "%#{@examine_profile_hash['air_type']}%" ).shuffle
    subject_hash = {}
    profiles = @profiles.select { |x| x.dic_type == Profile::SUBJECT_PROFILE }
    profiles.each do |profile|
      subject_hash[profile.dic_key] = profile.dic_value.to_i > 0 ? @subjects.select { |x| x.code == profile.dic_key }[0..profile.dic_value.to_i] : []
    end

    @else_subjects = []
    @safe_subjects = []
    subject_hash.each do |k, v|
      k.include?('SAFE') ? @safe_subjects += v : @else_subjects += v
    end
  end

  def examine
    params.select! { |x| x.to_i.to_s == x }
    subjects = Subject.where('id in (?)', params.keys)
    @user = User.find(session[:user][:id])
    @score = 0
    @safe_score = 0
    subjects.each do |subject|
      if subject.answer == params[subject.id.to_s].split.map(&:to_i).to_s
        @score += @score_profile_hash[subject.code].to_i
        @safe_score += @score_profile_hash[subject.code].to_i if subject.code.include?('SAFE')
      end
    end

    destroy_session
  end

end
