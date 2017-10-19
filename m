From: takuo.koguchi.sw@hitachi.com (=?iso-2022-jp?B?GyRCPi44fUJ2SVcbKEIgLyBLT0dVQ0hJGyRCISQbKEJUQUtVTw==?=)
Date: Thu, 19 Oct 2017 16:28:52 +0000
Subject: [cip-dev] Fwd: Re: [cip-board] Need feedback by Oct. 18: CIP
 Core News Release
In-Reply-To: <03125FF2-8DF0-48F0-83E0-466D07067EDB@hitachi.com>
References: <BB033DEA-BC03-4735-840F-FA2C44EDCC05@linuxfoundation.org>
	<000101d34727$02be9f20$083bdd60$@toshiba.co.jp>
	<7D0EC558-1623-4D25-A754-8ADF7FAE762D@linuxfoundation.org>
	<000601d347bd$c069da30$413d8e90$@toshiba.co.jp>,
	<002301d347fb$0e030a40$2a091ec0$@toshiba.co.jp>
	<7C8CF02E-9A5F-42F5-A50F-D8503974B1C1@hitachi.com>
	<390B4EACA1A32748BA6BC7F859F7D7165D17ADC9@GSjpTKYDCembx31.service.hitachi.net>,
	<390B4EACA1A32748BA6BC7F859F7D7165D17AED5@GSjpTKYDCembx31.service.hitachi.net>,
	<03125FF2-8DF0-48F0-83E0-466D07067EDB@hitachi.com>
Message-ID: <4D024BB1-8BD2-4625-A60E-E4E13FE23BED@hitachi.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Daniel,

I am abroad too.
kas-bbb.yml does not point CIP kernel.

Takuo


iPhone????

2017/10/19 14:13????? / KOGUCHI?TAKUO <takuo.koguchi.sw at hitachi.com<mailto:takuo.koguchi.sw@hitachi.com>> ??????:

Daniel,

Moved to cip-dev.  Thanks, Jan.

I have confirmed I am using kas 0.13 which I got by docker pull.

meta-cip-common and etc. lack layer.conf.  We need to add them.

Maybe because of slow network connection, git clone fails for github.com<http://github.com>.  I did clone them manually, and can start bitbake now.

Takuo


???: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw at hitachi.com<mailto:takuo.koguchi.sw@hitachi.com>>
??: 2017?10?19? 11:46:40 GMT+2
??: 'Daniel Sangorrin' <daniel.sangorrin at toshiba.co.jp<mailto:daniel.sangorrin@toshiba.co.jp>>
Cc: "'cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>'" <cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>>, 'Laura Kempke' <lkempke at linuxfoundation.org<mailto:lkempke@linuxfoundation.org>>, 'Agustin Benito Bethencourt' <agustin.benito at codethink.co.uk<mailto:agustin.benito@codethink.co.uk>>
??: [!]Re: [cip-board] Need feedback by Oct. 18: CIP Core News Release

Daniel,

I continue by changing 0.9 to 0.10.
Then the next error of meta-cip-bbb/conf/layer.conf is missing.

Takuo Koguchi

-----Original Message-----
From: ???? / KOGUCHI?TAKUO
Sent: Thursday, October 19, 2017 10:43 AM
To: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw at hitachi.com<mailto:takuo.koguchi.sw@hitachi.com>>; Daniel Sangorrin
<daniel.sangorrin at toshiba.co.jp<mailto:daniel.sangorrin@toshiba.co.jp>>
Cc: cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>; Laura Kempke
<lkempke at linuxfoundation.org<mailto:lkempke@linuxfoundation.org>>; Agustin Benito Bethencourt
<agustin.benito at codethink.co.uk<mailto:agustin.benito@codethink.co.uk>>
Subject: RE: [!]Re: [cip-board] Need feedback by Oct. 18: CIP Core News Release

Daniel,

I have got the following message when kas build; Am I wrong somewhere?

2017-10-19 08:43:35 - ERROR    - Config file validation Error:
'0.9' is not valid under any of the given schemas

Failed validating 'oneOf' in
schema['properties']['header']['properties']['version']:
   {'oneOf': [{'enum': ['0.10'], 'type': 'string'}, {'type': 'integer'}]}

On instance['header']['version']:
   '0.9'
2017-10-19 08:43:35 - ERROR    - Errors occured while validating the config
file %s: /cip-core/deby/poky/meta-cip-bbb/kas-bbb.yml
Traceback (most recent call last):
 File "/usr/local/lib/python3.4/dist-packages/kas/kas.py", line 159, in main
   sys.exit(kas(sys.argv[1:]))
 File "/usr/local/lib/python3.4/dist-packages/kas/kas.py", line 146, in kas
   if plugin().run(args):
 File "/usr/local/lib/python3.4/dist-packages/kas/build.py", line 75, in run
   cfg = Config(args.config, args.target, args.task)
 File "/usr/local/lib/python3.4/dist-packages/kas/config.py", line 67, in
__init__
   self.handler.get_config(repos=repo_paths)
 File "/usr/local/lib/python3.4/dist-packages/kas/includehandler.py", line
263, in get_config
   configs, missing_repos = _internal_include_handler(self.top_file)
 File "/usr/local/lib/python3.4/dist-packages/kas/includehandler.py", line
179, in _internal_include_handler
   current_config = load_config(filename)
 File "/usr/local/lib/python3.4/dist-packages/kas/includehandler.py", line
77, in load_config
   'config file %s', filename)
kas.includehandler.LoadConfigException: Errors occured while validating the
config file %s: /cip-core/deby/poky/meta-cip-bbb/kas-bbb.yml


Takuo Koguchi

-----Original Message-----
From: cip-board-bounces@lists.cip-project.org<mailto:cip-board-bounces@lists.cip-project.org>
[mailto:cip-board-bounces at lists.cip-project.org] On Behalf Of ???? /
KOGUCHI?TAKUO
Sent: Thursday, October 19, 2017 10:05 AM
To: Daniel Sangorrin <daniel.sangorrin at toshiba.co.jp<mailto:daniel.sangorrin@toshiba.co.jp>>
Cc: cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>; Laura Kempke
<lkempke at linuxfoundation.org<mailto:lkempke@linuxfoundation.org>>; Agustin Benito Bethencourt
<agustin.benito at codethink.co.uk<mailto:agustin.benito@codethink.co.uk>>
Subject: [!]Re: [cip-board] Need feedback by Oct. 18: CIP Core News
Release

Hi Daniel,

The method you described in the doc is really working as it is?

After
host$ docker pull kasproject/kas
In my case
docker run failed.  I have to replace "kas sh" to "kasproject/kas".

And after that
docker$ kas build
failed at the very beginning.

Is not  something wrong?

Takuo



2017/10/18 12:23?Daniel Sangorrin <daniel.sangorrin at toshiba.co.jp<mailto:daniel.sangorrin@toshiba.co.jp>>
????
??:

Hi Maemalynn,

I have prepared the attached document for the blog. It shows more
technical
details that the press release. I hope that works for you.
Could you review it and convert it to the format required by the blog?

Thanks,
Daniel


-----Original Message-----
From: cip-board-bounces@lists.cip-project.org<mailto:cip-board-bounces@lists.cip-project.org>
[mailto:cip-board-bounces at lists.cip-project.org] On Behalf Of
Daniel Sangorrin
Sent: Wednesday, October 18, 2017 10:04 AM
To: 'Maemalynn Meanor'; 'Agustin Benito Bethencourt';
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
Cc: 'Laura Kempke'
Subject: Re: [cip-board] Need feedback by Oct. 18: CIP Core News
Release

Hi Maemalynn

-----Original Message-----
From: Maemalynn Meanor [mailto:maemalynn at linuxfoundation.org]
Sent: Wednesday, October 18, 2017 8:04 AM
To: Daniel Sangorrin; Agustin Benito Bethencourt;
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
Cc: Noriaki Fukuyasu; Laura Kempke; Annie Fisher
Subject: Re: Need feedback by Oct. 18: CIP Core News Release

Hi Daniel: I took at look at the GitLab page. We can certainly
turn some of that content into a blog post but would still need a
little
more
descriptions. Ideally, we could use the overview paragraph and
then explain what some of the images are describing. Then we?ll
include a link
to the wiki or Gitlab page. Does that help? Do you think you can draft that?

Also, please note that this page still says Project X. We need to
update
all references to CIP Core.


OK, I will try to get it done by 17:00 Vietnam time.

Thanks,
Daniel



Hi Agustin: I added a description of your session. Please review
this and let me know if you approve. Once you approve, I?ll also
add this
description to the ELC Europe preview blog post.

ALL CIP Board Members: Please review the CIP Core news release.
All feedback
need to be sent by EOD Oct. 18.


https://docs.google.com/document/d/12yCR-K7OBY9NAqfiGG8-4WOS_qQ-k7
uT
ta59egaed0I/edit

Thanks so much!
Mae

Maemalynn Meanor
PR Manager
The Linux Foundation
Maemalynn at linuxfoundation.org<mailto:Maemalynn@linuxfoundation.org>
<mailto:Maemalynn@linuxfoundation.org>
(602) 541-0356
Skype: Maemalynn






  On Oct 17, 2017, at 2:04 AM, Daniel Sangorrin
<daniel.sangorrin at toshiba.co.jp<mailto:daniel.sangorrin@toshiba.co.jp>
<mailto:daniel.sangorrin@toshiba.co.jp> >
wrote:

  Hi Maemalynn,



      -----Original Message-----
      From: Maemalynn Meanor [mailto:maemalynn at linuxfoundation.org]
      Sent: Tuesday, October 17, 2017 11:49 AM
      To: Daniel Sangorrin; Agustin Benito Bethencourt;
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org> <mailto:cip-board@lists.cip-
project.org<http://project.org>>
      Cc: Noriaki Fukuyasu; Laura Kempke; Annie Fisher
      Subject: Need feedback by Oct. 18: CIP Core News Release

      Hi All:

      Below is the link to the CIP news release. This news
release features an overview for the CIP Core, B at D v1.0 and our activities
at ELC
      Europe. We?re planning on announcing it on Monday, Oct. 23
Prague
time.




  Thanks, I have checked the link and I think it summarizes quite
well what's
being released.



      The CIP Core details featured in the release came from the
questionnaire that Daniel and team filled out. CIP Core is really technical,
      however, the news release needs to be a simple overview
that anyone reading it can understand. Knowing this, I?d like to suggest
a
      technical blog post that can go along with this announcement.
We can plan on also posting it on the CIP blog on Monday. Daniel - is this
      something you can help do? I?m happy to help edit it, we
would just
need you to draft the technical portion.



  I created a Wiki web page that explain the technical details.
It is
currently here, but I have to move it to the official repo:

https://gitlab.com/cip-playground/project-x/wikis/Introduction-to-
th
e-CIP-Project-X

  Do you think it could be used for the blog post?

  Thanks,
  Daniel





https://docs.google.com/document/d/12yCR-K7OBY9NAqfiGG8-4WOS_qQ-k7
uT
ta59egaed0I/edit?usp=sharing

      A few other notes:
      - As the chair of the TSC, we included a quote for Yoshi.
This is a typical practice for LF news releases - we usually quote
the
executive
      director of the project or the TSC chair.
      - The information for B at D came directly from Agustin?s blog
post that
goes live on Wed.

      Please review the benefits and details for the CIP Core and
provide your details or suggestions. Please remember - it needs to be
      simple language - the technical details can be featured in
the blog
post.

      Please provide all comments and changes by EOD Wednesday, Oct. 18.

      Thanks for your help!
      Maemalynn

      Maemalynn Meanor
      PR Manager
      The Linux Foundation
      Maemalynn at linuxfoundation.org<mailto:Maemalynn@linuxfoundation.org>
<mailto:Maemalynn@linuxfoundation.org>
      (602) 541-0356
      Skype: Maemalynn












_______________________________________________
cip-board mailing list
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-board
<CIP Core project release v1.docx>
_______________________________________________
cip-board mailing list
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-board
_______________________________________________
cip-board mailing list
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-board
_______________________________________________
cip-board mailing list
cip-board at lists.cip-project.org<mailto:cip-board@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-board
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20171019/406ec837/attachment-0001.html>
