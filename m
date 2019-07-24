From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 24 Jul 2019 05:45:32 +0200
Subject: [cip-dev] [ANNOUNCE] v4.19.50-cip3-rt2
In-Reply-To: <20190723210608.GA23154@amd>
References: <20190723124015.GA13044@amd>
	<34180972-ec78-ec39-d191-297e2029c3f0@siemens.com>
	<20190723210608.GA23154@amd>
Message-ID: <CAEss1EKQ_6SWV+Z5aOCkdrtDGGXOhN_ASfDs6Zf1UcjJm5mX0w@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I finally was able to make the viable .config... For the previous
rt-kernel for BBB.

root at beaglebone:~# uname -a
Linux beaglebone 4.19.13-cip1-rt1 #1 PREEMPT RT Tue Jul 23 12:18:18
GMT 2019 armv7l GNU/Linux

It was very tough and rough... But I have it! Now I need to abandon
this effort, since I have another immediate things to do!

Well...

Zoran
_______

On Tue, Jul 23, 2019 at 11:06 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > Trees are available at
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
> > >
> > > And their content should be identical. I attempted to tag it in a way
> > > consistent with previous releases, and I attempted to sign a tag.
> >
> > ...but you didn't push the tag yet? Or is this WiP?
>
> Sorry, I forgot I need to push the tag. It should be fixed now.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
