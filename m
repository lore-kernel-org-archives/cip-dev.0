From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Fri, 19 Jul 2019 21:03:46 +0200
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter
	in 4.19?!
In-Reply-To: <5c024c43245bd5cdecd256fe9d74d6992ea95598.camel@codethink.co.uk>
References: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
	<5d8ff922971892e85f4e682d687476645cf690e5.camel@codethink.co.uk>
	<CAEss1E+93RuXzGWeNMaTreUaMOObmNioB5=VGD0qjgerYTFf6Q@mail.gmail.com>
	<5c024c43245bd5cdecd256fe9d74d6992ea95598.camel@codethink.co.uk>
Message-ID: <CAEss1E+5iPMUYam8YzvA31EHZJKmM8OxtsTSaVeQ8kWPB7Uy5Q@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

OK, I see. Wrong check-out!

*git checkout -b cip_v4.19.58-cip6 v4.19.58-cip6*

Yup... This is the root cause of the problem!

v4.19.13-cip1

*v4.19.13-cip1-rt1v4.19.13-cip1-rt1-rebase*
v4.19.13-cip2
v4.19.13-cip2-rebase
v4.19.50-cip3
v4.19.50-cip3-rebase
v4.19.52-cip4
v4.19.52-cip4-rebase
v4.19.56-cip5
v4.19.56-cip5-rebase
v4.19.58-cip6
v4.19.58-cip6-rebase

Psychological mislead! Well... Blind trust in what I see (and I do see NOT
reality, just what I did expect! ;-)

Well, I need to fix this psychosocial problems with my brain! :-)

Case Closed!

Thank you,
Zoran
_______


On Fri, Jul 19, 2019 at 8:11 PM Ben Hutchings <ben.hutchings@codethink.co.uk>
wrote:

> On Fri, 2019-07-19 at 19:58 +0200, Zoran S wrote:
> > > This never existed in the upstream kernel, only in -rt branches.
> > > It still exists in 4.19-rt.
> >
> > Sure. The following is done by me:
> >
> > git clone git://
> git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >
> > Isn't this CIP RT-kernel real-time tree?
> [...]
>
> It's the CIP kernel repository.  Only the branches with "-rt" in the
> name include the real-time patch set.
>
> Ben.
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190719/d5434acf/attachment.html>
