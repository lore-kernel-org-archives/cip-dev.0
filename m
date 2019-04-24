From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 24 Apr 2019 11:30:37 +0200
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
 list
In-Reply-To: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <20190424093037.GA30540@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Hello CIP developers,
> 
> I would like to suggest an idea about the process to determine the package list that should be supported by CIP.
> It's difficult to discuss adding any packages including their dependencies from whole Debian, mixing the two profiles.
> 
> As the first step, it would be better to start from the source package list
> which binary packages are installed by debootstrap minbase.
> I attached the source package list, where only 58 packages exist.
> I guess that it's easier to discuss which packages should be supported from such core components.
> 
> NOTE: busybox is not included in the attached list, but it have to be supported
> not only for the tiny profile but also initramfs (and Debian
> installer?) in the generic profile.

Looking at the list, one things stands out:

There are tiny packages one would expect on embedded system:

> dash

And there's huge package one would not expect there:

> gcc-8

How did gcc get to the list? It may be more work to support gcc-8 than
rest of the packages combined...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190424/72d55e5c/attachment.sig>
