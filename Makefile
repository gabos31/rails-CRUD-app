start:
	rails server
routes:
	rails routes
lint:
	rubocop
tests:
	RAILS_ENV=test rails db:migrate test