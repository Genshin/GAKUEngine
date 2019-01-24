unless defined?(Gaku::InstallGenerator)
  require 'generators/gaku/install/install_generator'
end

desc 'Generates a dummy app for testing'
namespace :common do
  task :test_app do

    require "#{ENV['LIB_NAME']}"

    puts ENV['LIB_NAME']

    Gaku::DummyGenerator.start ["--lib_name=#{ENV['LIB_NAME']}", '--quiet']
    Gaku::InstallGenerator.start ["--lib_name=#{ENV['LIB_NAME']}",
                                  '--auto-accept',
                                  '--migrate=false',
                                  '--seed=false',
                                  '--sample=false',
                                  '--quiet'
                                 ]

    puts 'Setting up dummy database...'

    # TODO The following two lines prefixed with ** are for a future version which will be safer
    # **if (!!(`PGPASSWORD=manabu psql postgres --user manabu -c "SELECT datname FROM pg_database WHERE has_database_privilege('manabu', datname, 'CONNECT');"` =~ /gaku_test/))
    # ** `bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare RAILS_ENV=test`
    if (!!(`PGPASSWORD=manabu psql postgres --user manabu -c "SELECT current_setting('is_superuser');"` =~ /on/))
      `RAILS_ENV=test bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare`
    else
      printf "Database was not accessible. How would you like to proceed?\n" \
        "(1) Try to create user and database automatically (requires sudo)\n" \
        "   *WARNING* This will create a Postgres super user (needed to enable hstore)!\n" \
        "(2) Attempt to run creation tasks/migrations. This requires the following:\n" \
        "\t * HStore installed\n" \
        "\t * Postgres super user \"manabu\" with password \"manabu\"\n" \
        "\t * Database \"gaku_test\" and \"gaku_development\" with full permission granted to \"manabu\"\n" \
        "\t * Database \"gaku_test\" and \"gaku_development\" are *empty*\n" \
        "Please enter 1 or 2. Enter anything else or simply hit enter to cancel: "
      selection = STDIN.getc
      case selection
        when '1' then
          puts 'Creating user and database automatically...'
          _autopilot_setup
        when '2' then
          puts 'Running creation tasks/migrations...'
          `RAILS_ENV=test bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare`
        else
          puts
      end
    end
  end
end

def _autopilot_setup
  term_cover = " 1> /dev/null 2> /dev/null"
  puts "Setting up DB User, Database, and Extensions..."
  # Clear out any stale users and databases if they exist
  `sudo -u postgres psql -c "DROP DATABASE IF EXISTS gaku_test;"#{term_cover}`
  `sudo -u postgres psql -c "DROP DATABASE IF EXISTS gaku_development;"#{term_cover}`
  `sudo -u postgres psql -c "DROP USER IF EXISTS manabu;"#{term_cover}`

  # Create user
  `sudo -u postgres psql -c "CREATE USER manabu WITH PASSWORD 'manabu';"#{term_cover}`
  `sudo -u postgres psql -c "ALTER USER manabu WITH SUPERUSER;"#{term_cover}`
  # **`sudo -u postgres psql -c "ALTER USER manabu CREATEDB;"#{term_cover}`
  `sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS hstore;"#{term_cover}`

  # **# Create the gaku_test database and grant privileges to user
  # **`sudo -u postgres psql -c "CREATE DATABASE gaku_test;"#{term_cover}`
  # **`sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_test\" to manabu;"#{term_cover}`
  # **`sudo -u postgres psql gaku_test -c "CREATE EXTENSION hstore;"#{term_cover}`
  # **`sudo -u postgres psql -c "ALTER DATABASE gaku_test OWNER TO manabu;"#{term_cover}`
  # **
  # **# Create the gaku_development database and grant privileges to user
  # **`sudo -u postgres psql -c "CREATE DATABASE gaku_development;"#{term_cover}`
  # **`sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_development\" to manabu;"#{term_cover}`
  # **`sudo -u postgres psql gaku_development -c "CREATE EXTENSION hstore;"#{term_cover}`
  # **`sudo -u postgres psql -c "ALTER DATABASE gaku_development OWNER TO manabu;"#{term_cover}`
  puts "Done."

  puts "Running tasks..."
  `RAILS_ENV=test bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare`
  puts "Done. If the test app does not run normally please follow the setup guide at: "
  puts "https://github.com/GAKUEngine/gaku"
end
