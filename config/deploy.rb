# Capistranoのバージョン（固定）、バージョン固定することでバージョン変更によるトラブルを防止
lock '~> 3.14.1'

# Capistranoのログの表示に利用する
set :application, 'payways'

# アプリケーション(payways)のリポジトリからプルするように設定
set :repo_url, 'git@github.com:Teppeichang/payways.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.1'

# EC2で設定したアプリケーションのキーペアを利用してデプロイ
set :ssh_options, auth_methods: ['publickey'], keys: ['~/.ssh/payways_keypare.pem']

# プロセス番号(PID)を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定に関するファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後に、Unicornを再起動(restart)する
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
