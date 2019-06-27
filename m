From: pavel@denx.de (Pavel Machek)
Date: Thu, 27 Jun 2019 23:40:28 +0200
Subject: [cip-dev] lava very slow; it was ok earlier today
Message-ID: <20190627214028.GA21852@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

I'm trying to get something to work on iwg20m, but ... something is
very slow.

https://lava.ciplatform.org/scheduler/job/1552

downloading
https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.tar.gz
saving as
/var/lib/lava/dispatcher/tmp/1552/tftp-deploy-38u2x17d/nfsrootfs/core-image-minimal-iwg20m.tar
total size: 29096711 (27MB)
Using gunzip to decompress gz
progress   0% (0MB)
...
progress  70% (19MB)
http-download timed out after 598 seconds
end: 1.3.1 http-download (duration 00:09:58) [common]

I can increase the timeouts, and then it works better, but... it
should not take 10 minutes to download 19MB. Any idea what is wrong
there?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190627/2cb65cef/attachment.sig>
