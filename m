From: pavel@denx.de (Pavel Machek)
Date: Thu, 12 Sep 2019 00:14:52 +0200
Subject: [cip-dev] gitlab: mirroring broken, tests failing
Message-ID: <20190911221452.GA30802@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

I pushed kernel to kernel.org, bug I don't see it on gilab. Does
mirroring need to be restarted?

Plus, tests are failing, and it seems to me that problem is with
tests, not with
kernel... https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/292957614

Job submitted successfully as #3620.
------------------------------
Current job status:
Job #3605: Submitted
...
Job #3620: Submitted
Timed out waiting for test jobs to complete
Errors during testing

I tried submiting known-good kernel, 3bc5ed22, and it failed, too...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190912/4592c695/attachment.sig>
