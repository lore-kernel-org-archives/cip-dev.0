From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 18 May 2018 09:04:34 +0900
Subject: [cip-dev] Backport for LTS 4.4.129 for LTP fnctl35 tests
In-Reply-To: <1526580927.9159.169.camel@codethink.co.uk>
References: <1526545991-13743-1-git-send-email-daniel.sangorrin@toshiba.co.jp>	
	<3cb5d568-1658-93b1-5d64-eec4eda4d9d4@siemens.com>
	<1526580927.9159.169.camel@codethink.co.uk>
Message-ID: <003c01d3ee3b$cddb2a50$69917ef0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben, Daniel:

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: Friday, May 18, 2018 3:15 AM
> To: Daniel Wagner <daniel.wagner@siemens.com>; Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Cc: fuego at lists.linuxfoundation.org
> Subject: Re: [cip-dev] Backport for LTS 4.4.129 for LTP fnctl35 tests
> 
> On Thu, 2018-05-17 at 10:53 +0200, Daniel Wagner wrote:
> > Hi Daniel,
> >
> > On 05/17/2018 10:33 AM, Daniel Sangorrin wrote:
> > > Dear Ben,
> > >
> > > The other day I mentioned on the list[1] that after running LTP with
> > > Fuego there were a few test cases failing that needed investigation.
> > >
> > > I reviewed the first one (fcntl35 and fcntl35_64). According to the
> > > comments on the LTP fcntl35.c file (by Xiao Yang <yangx.jy@cn.fujitsu.com>)
> > > the bug tested by this test case was fixed by:
> > >     commit 086e774a57fba4695f14383c0818994c0b31da7c
> > >     Author: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> > >     Date:   Tue Oct 11 13:53:43 2016 -0700
> > >
> > > I backported that patch, see next e-mail:
> > > [PATCH] pipe: cap initial pipe capacity according to pipe-max-size
> > >
> > > I tested again and confirmed that the patch fixed the bug.
> > >
> > > Before:
> > > fcntl35.c:98: FAIL: an unprivileged user init the capacity of a pipe to 65536
> unexpectedly, expected 4096
> > > After:
> > > fcntl35.c:101: PASS: an unprivileged user init the capacity of a pipe to 4096
> successfully
> > >
> > > If you think the patch is OK (as mentor) I can send it to the LTS mailing list
> myself.
> >
> > Wouldn't it make sense to send it (also?) to Greg to include into the
> > stable trees?
> 
> I agree, this looks like suitable for stable.

OK, I got confused by this e-mail.
https://lists.cip-project.org/pipermail/cip-dev/2018-April/001061.html
I will send the patch directly to the stable mailing list then.

Thanks,
Daniel
