From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 24 Apr 2019 23:57:45 +0000
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
 list
In-Reply-To: <20190424093037.GA30540@amd>
References: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>,
	<20190424093037.GA30540@amd>
Message-ID: <TYAPR01MB41898BC158B6054C4646FFEF923C0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> gcc-8
> 
> How did gcc get to the list? It may be more work to support gcc-8 than
> rest of the packages combined...

This is dependent on apt, glibc and gcc(libstdc++).

Best regards,
  Nobuhiro

________________________________________
???: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> ? Pavel Machek <pavel@ucw.cz> ??????
????: 2019?4?24? 18:30
??: hayashi kazuhiro(? ?? ????????)
CC: cip-dev at lists.cip-project.org
??: Re: [cip-dev] [cip-core] RFC: Process to decide supported package list

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
