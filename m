From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 28 Jun 2019 07:19:38 +0000
Subject: [cip-dev] lava very slow; it was ok earlier today
In-Reply-To: <20190627214028.GA21852@amd>
References: <20190627214028.GA21852@amd>
Message-ID: <TYAPR01MB228554116EE183C553E1342BB7FC0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 27 June 2019 22:40
>
>
> Hi!
>
> I'm trying to get something to work on iwg20m, but ... something is
> very slow.

That's slow indeed. I can only assume that the Internet line the lab is on at the Renesas office was having some issues.

Sorry for the inconvenience. It seems to be okay this morning.

Kind regards, Chris

>
> https://lava.ciplatform.org/scheduler/job/1552
>
> downloading
> https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-
> core/iwg20m/core-image-minimal-iwg20m.tar.gz
> saving as
> /var/lib/lava/dispatcher/tmp/1552/tftp-deploy-38u2x17d/nfsrootfs/core-
> image-minimal-iwg20m.tar
> total size: 29096711 (27MB)
> Using gunzip to decompress gz
> progress?? 0% (0MB)
> ...
> progress? 70% (19MB)
> http-download timed out after 598 seconds
> end: 1.3.1 http-download (duration 00:09:58) [common]
>
> I can increase the timeouts, and then it works better, but... it
> should not take 10 minutes to download 19MB. Any idea what is wrong
> there?
>
> Best regards,
> ????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? ??????? Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
