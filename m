From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 30 Jul 2019 13:01:03 +0000
Subject: [cip-dev] powerpc build with Kernel v4.4
In-Reply-To: <20190728084920.GA21045@amd>
References: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20190728074044.GA19089@amd> <20190728084920.GA21045@amd>
Message-ID: <TYAPR01MB2285D2A833FCC5D7E0DF8A3CB7DC0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Pavel Machek <pavel@denx.de>
> Sent: 28 July 2019 09:49
>
> *** gpg4o | The signature of this email could not be verified because the
> following public key is missing. Click here to search and import the key
> 30E7F06A95DBFAF2 ***
>
> Hi!
>
> > > I'm trying to build the toshiba_defconfig [1] for the powerpc architecture
> using the CIP v4.4 Kernel but I'm hitting some problems. The log from the
> build can be seen on GitLab [2].
> > >
> > > Has anyone tried building this configuration recently?
> > >
> > > I'm using gcc compiler v8.1.0. I mention this because I've see a half-
> related discussion [3] when Googling. From this mail thread I wonder if there
> are some patches we need to backport?
> > >
> >
> > Is there chance to use different gcc? Because this looks like gcc
> > bug... but workaround seems simple enough. Let me investigate some
> > more.
>
> Workaround seems simple, but won't easily apply on top of 4.4 kernel
That?s a shame.

>
> Can you simply set
>
> CONFIG_PPC_DISABLE_WERROR=y
>
> to make the problem go away?

I could, but even if it works it?s Toshiba?s config and perhaps they had a reason to enable this option.

Daniel, Kobayashi-san, any comments?

Kind regards, Chris

>
> Best regards,
>
>                                                               Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190730/c92e517e/attachment-0001.html>
