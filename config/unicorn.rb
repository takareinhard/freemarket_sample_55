

worker_processes 1
RAILS_ROOT = File.expand_path('../../../', __FILE__)
# currentを指定
# # 実行したファイルの場所からrailsのrootパスを見つける
# RAILS_ROOT = File.expand_path('../../', __FILE__)
# ENV['BUNDLE_GEMFILE'] = RAILS_ROOT + "/Gemfile"
# ここは、RIALS_ROOTが記載されていれば、明示的にかかなくても大丈夫です。
# 自分が使っている環境でも、下の記載なしにちゃんと動いてますね。
working_directory RAILS_ROOT

# それぞれ、sharedの中を参照するよう変更
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"
#Railsアプリケーションの応答を待つ上限時間を設定
timeout 60

#以下は応用的な設定なので説明は割愛

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end