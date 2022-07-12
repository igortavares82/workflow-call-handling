# Maria Flowershop Call Center
The idea is to implement the flow described [here](https://talkdesk.atlassian.net/wiki/spaces/CXMWE/pages/547553303/Onboarding+challenge) as part of Tech Dojo
ruby day.

## Running tests
```bash
docker-compose build tests && docker-compose run tests
```

## Boot service
Bring the service up
```bash
docker-compose up dev
```

Hit the http API
```bash
curl -X POST localhost:9292/inbound_call
```

## Create a Twilio Account
You'll use [Twilio](https://www.twilio.com/) as communication provider, so you need to setup an account in order
to forward calls to your web application. The following steps will guide you into this.

- [Sign up](https://www.twilio.com/try-twilio) for a trial account.
- Let them know you're a human.
- Name your project (e.g. Talkdesk Maria Call Center).
- You're trial account is now set with a budget of $15.50.

## Get a Number
- Under Programmable Voice, choose Numbers.
- Click the Get a Number button.
- Twilio will suggest you a Portuguese phone number. Don't accept it and search for a US number instead (by clicking on the link "Search for a different number"), as you'll be able to make free calls from [Google Hangouts](https://hangouts.google.com/).
- Choose any number from the list that is presented to you.

And you're set. Click "Manage Numbers" and you'll see your brand new phone number listed. You can try it out by making a test call (use Google Hangouts for instance)

For now we're done with Twilio. We'll get back here later to hook your web application to the number you just bought.

## Setup ngrok tunnel
To create a tunnel to localhost on port 9292, we'll just need to run:
```bash
ngrok http 9292
```

## Setup webhook in Twilio
- In your twilio account, access the list of "Phone Numbers".
- Click on the phone number you've just [provisioned](#get-a-number).
- In the "Voice & Fax" section configure the "A call comes in" Webhook to point to your local application (through the ngrok tunnel). The endpoint must be set as `https://<ngrok_url>/inbound_call` where *ngrok_url* should be replaced by the Url that was [assigned by ngrok](#setup-ngrok-tunnel).
      Example: https://44a1dcb5.ngrok.io/inbound_call
- Save the settings and make a test call.
