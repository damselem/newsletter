# Newsletter

This project's goal is to allow all engineers in Klarna's TLV office to share knowledge between them in a way that most people feel comfortable.

 - **Send an email written in Markdown**. Because Markdown is A-W-E-S-O-M-E!!

 - **Receive a newsletter once a week with an aggregated collection of posts**. Who doesn't like inbox-zero??

## Development

The application depends on two external resources, [Postmark](https://postmarkapp.com/) and [Google OAuth](https://developers.google.com/accounts/docs/OAuth2). In order to get the application up and running in your development machine you have to follow the next steps:

### Postmark

###### Real integration
- [Sign up](https://postmarkapp.com/sign_up) for an account.
- In the [list of servers](https://postmarkapp.com/servers), create a new one by following the setup wizard.
- Copy the **Inbound Address** from the *Get Started* page that will be presented to you. This address is the one you will have to use to send the emails to.
- Click on **Settings** in the top menu and modify the **Inbound Hook** to something like:

        http://my-ip-address:3000/posts
        
###### Fake integration

If you don't want to do all the tedious work described above, you can simply generate fake emails by running:

    bundle exec rake development:create_fake_email

### Google OAuth
- Go to [Google APIs Console](https://code.google.com/apis/console).
- Create a project and name it with any name you like.
- On the left sidebar click on **API Access** and then on **Create another client ID**.
- In the *Your site or hostname* section fill in the text field with `localhost:3000`.
- Click on **Edit** on the new box that appears on the page and modify the following values:
  - Authorized Redirect URIs:
  
        http://localhost:3000/auth/google_oauth2/callback
        
  - Authorized JavaScript Origins:
  
  		http://localhost:3000

### application.yml

This file is the one used to store all configuration settings in the application. There is a sample file under `config` that you can use to set up the application:

	cp config/application.yml.sample config/application.yml

Modify all keys under `development` to match your development settings. You are good to go! :)

## Contributing

Please use the issues page to report any bug or suggest new features. If you feel brave:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
