From: pavel@denx.de (Pavel Machek)
Date: Mon, 24 Jun 2019 13:11:41 +0200
Subject: [cip-dev] [ANNOUNCE] 4.19.50-cip3 and 4.4.181-cip33
In-Reply-To: <b7549d5e-bf7e-ba5b-dd44-fca0346b8a12@siemens.com>
References: <OSBPR01MB418452DE0AB57E8B6792731192EE0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
	<OSBPR01MB41847EC988B652D8224B357792E80@OSBPR01MB4184.jpnprd01.prod.outlook.com>
	<b7549d5e-bf7e-ba5b-dd44-fca0346b8a12@siemens.com>
Message-ID: <20190624111141.GA22088@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > Although patches for MDS are included in this release, no test code has been
> > published for these, so we have not tested for MDS. Also, patches did not
> > really follow the stable rules, so they could not be checked the same way
> > as checking for other patches. But the bug is ugly enough so we included
> > the patches anyway.
> > For the above reasons, modern x86 CPUs can not really be trusted with secrets;
> > similar attacks are likely to happen in future.
> > 
> 
> I wouldn't see it that extreme, it still heavily depends on what you are running and where. Also, the attacks are getting more complex.
> 

Well, most systems do not really need to protect local user's secrets
from each other. We simply don't allow code execution for untrusted
parties.

If someone decides to combine "top secret document storage" and
"honeypot giving shell to attackers" on single machine, well, they are
asking for trouble.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190624/698caec2/attachment.sig>
