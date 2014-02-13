#encoding:utf-8
class ExaminesController < ApplicationController

  layout :false, :only => [:examine, :score]

  def show
    @subjects = Subject.where('air like ?', "%#{@examine_profile_hash['air_type']}%").shuffle
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
    examine_subjects = params['no'].map(&:to_i).to_s
    params.select! { |x| x.to_i.to_s == x }
    subjects = Subject.where('id in (?)', params.keys)
    @user = User.find(session[:user][:id])
    @total_score = 0
    @safe_score = 0
    subjects.each do |subject|
      if subject.answer == params[subject.id.to_s].split.map(&:to_i).to_s
        @total_score += @score_profile_hash[subject.code].to_i
        @safe_score += @score_profile_hash[subject.code].to_i if subject.code.include?('SAFE')
      end
    end

    @score = Score.new
    @score.user_id = @user.id
    @score.air = @examine_profile_hash['air_type']
    @score.totle_score=@safe_score
    @score.all_score=@total_score
    @score.exam_date= Date.parse(Time.now.strftime('%Y-%-m-%-d'))
    @score.examine_date = @examine_profile_hash['examine_date']
    @score.subjects = examine_subjects
    @score.reason = if (@safe_score < (@score_profile_hash['SAFE::single'].to_i * @subject_profile_hash['SAFE::single'].to_i + @score_profile_hash['SAFE::multiple'].to_i * @subject_profile_hash['SAFE::multiple'].to_i)) then
                      Tips::NO_SAFE_PASS
                    else
                      @total_score < @examine_profile_hash['pass_score'].to_i ? Tips::NO_PASS : Tips::PASS
                    end
    @score.status = @score.reason == Tips::PASS ? Tips::PASS : Tips::NO_PASS

    @score.save!
    destroy_session
  end

  def score
    @user = User.find(session[:user][:id])
    @score = @user.scores.last!
    destroy_session
  end


end
