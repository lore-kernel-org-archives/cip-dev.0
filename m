From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 20 Jun 2019 10:00:20 +0000
Subject: [cip-dev] [ANNOUNCE] 4.19.50-cip3 and 4.4.181-cip33
In-Reply-To: <b7549d5e-bf7e-ba5b-dd44-fca0346b8a12@siemens.com>
References: <OSBPR01MB418452DE0AB57E8B6792731192EE0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
	<OSBPR01MB41847EC988B652D8224B357792E80@OSBPR01MB4184.jpnprd01.prod.outlook.com>
	<b7549d5e-bf7e-ba5b-dd44-fca0346b8a12@siemens.com>
Message-ID: <OSBPR01MB41841CD37D46BB75B83992A292E40@OSBPR01MB4184.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Thursday, June 20, 2019 1:59 AM
> To: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Cc: SZ.Lin at moxa.com
> Subject: Re: [cip-dev] [ANNOUNCE] 4.19.50-cip3 and 4.4.181-cip33
> 
> On 17.06.19 00:14, nobuhiro1.iwamatsu at toshiba.co.jp wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: iwamatsu nobuhiro(?? ?? ????????)
> >> Sent: Friday, June 14, 2019 6:12 PM
> >> To: cip-dev at lists.cip-project.org
> >> Cc: SZ.Lin at moxa.com; Pavel Machek <pavel@denx.de>; Ben Hutchings
> >> <ben.hutchings@codethink.co.uk>
> >> Subject: [ANNOUNCE] 4.19.50-cip3 and 4.4.181-cip33
> >>
> >> Hi all,
> >>
> >> CIP kernel team has released Linux kernel 4.19.50-cip3 and
> 4.4.181-cip33.
> >> You can get this release via the git tree at:
> >>
> >>    4.19.50-cip3:
> >>
> >>      repository:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >>      branch: linux-4.19.y-cip
> >>      commit: 0f13d9b4d0efa9e87381717c113df57718bc92d6
> >>
> >>    4.4.181-cip33:
> >>
> >>      repository:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >>      branch: linux-4.4.y-cip
> >>      commit: b791a4823f245e7871dbdd05d8f13bcc5dc377c9
> >>
> >> And I introduce the updates for each kernel below.
> >>
> >> About 4.19.50-cip3:
> >>    * This version has been updated from stable version 4.19.13 to
> >> 4.19.50, and
> >>      many CVE fixes including MDS (Microarchitectural Data Sampling:
> >> CVE-2018-12130,
> >>      CVE-2018-12126, CVE-2018-12127,, CVE-2019-11091).
> >>    * CIP updates include device-tree fixes by Renesas.
> >>
> >> About 4.4.176-cip32:
> >>    * This version has been updated from stable version 4.4.176 to
> >> 4.4.181, and
> >>      this also includes MDS fixes as in 4.19.y.
> >>    * CIP updates include update of RZ/G1C by Renesas.
> >>
> >
> > I forgot to explain about MDS.
> >
> > Although patches for MDS are included in this release, no test code
> > has been published for these, so we have not tested for MDS. Also,
> > patches did not really follow the stable rules, so they could not be
> > checked the same way as checking for other patches. But the bug is
> > ugly enough so we included the patches anyway.
> > For the above reasons, modern x86 CPUs can not really be trusted with
> > secrets; similar attacks are likely to happen in future.
> >
> 
> I wouldn't see it that extreme, it still heavily depends on what you are
> running and where. Also, the attacks are getting more complex.
> 
> Anyway, different while similar topic: Is there a plan to quickly follow
> up with releases containing the SACK issue patches? That is cooking
> everywhere now.
> 

We talked about this at today's IRC meeting, we decided to release this soon.

Best regards,
  Nobuhiro
