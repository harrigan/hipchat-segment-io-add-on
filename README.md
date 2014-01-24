     _   _ _        ____ _           _
    | | | (_)_ __  / ___| |__   __ _| |_
    | |_| | | '_ \| |   | '_ \ / _` | __|
    |  _  | | |_) | |___| | | | (_| | |_
    |_| |_|_| .__/ \____|_| |_|\__,_|\__|
            |_|
     ____                                  _     _
    / ___|  ___  __ _ _ __ ___   ___ _ __ | |_  (_) ___
    \___ \ / _ \/ _` | '_ ` _ \ / _ \ '_ \| __| | |/ _ \
     ___) |  __/ (_| | | | | | |  __/ | | | |_ _| | (_) |
    |____/ \___|\__, |_| |_| |_|\___|_| |_|\__(_)_|\___/
                |___/
        _       _     _        ___
       / \   __| | __| |      / _ \ _ __
      / _ \ / _` |/ _` |_____| | | | '_ \
     / ___ \ (_| | (_| |_____| |_| | | | |
    /_/   \_\__,_|\__,_|      \___/|_| |_|

A HipChat Add-On that provides an endpoint for Segment.io to post events to. The events are then sent to a HipChat room as notifications. The project is was started using the [HipChat Add-On Generator](https://github.com/logankoester/generator-hipchat-addon).

![Screenshot](hipchat-segment-io-add-on.png?raw=true)

## Instructions

This is a Sinatra application that uses MongoDB for storage. You need to clone it and deploy it to, say, [Heroku](http://heroku.com) and [MongoLab](http://mongolab.com).

You will also need to set four environment variables as follows:
* MONGO_URL=mongodb://username:password@database.mongolab.com:27739/database-name
* BASE_URI=http://your-hipchat-add-on.herokuapp.com
* HIPCHAT_SCOPES=send_notification
* SESSION_SECRET=secret

Then navigate to http://your-hipchat-add-on.herokuapp.com and install the HipChat Add-On.

Finally, in your Segment.io account, enable the WebHook integration and set the WebHook URL to http://your-hipchat-add-on.herokuapp.com/segment_io/AccountId/RoomIdOrName.

The HipChat room must already exist. You can retrieve the AccountId from the MongoDB database after you have installed the HipChat Add-On.

## Contributions

If you would like to contribute a bug fix or feature:
* Check that the latest version from the master branch does not contain an equivalent bug fix or feature.
* Fork the project.
* Create a bug fix or feature branch.
* Commit your changes and push until you are happy with your contribution.
* Create a pull request.

Also:
* Follow the same coding style as used in the project.
* Write good commit messages.
* Keep it simple: Any contribution that changes a lot of code or is difficult to understand should be discussed before you put in the effort.

## Copyright

&copy; 2014 [Martin Harrigan](http://www.martinharrigan.ie)
