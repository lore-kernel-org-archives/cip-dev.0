From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 19 Jul 2019 19:11:24 +0100
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter
	in 4.19?!
In-Reply-To: <CAEss1E+93RuXzGWeNMaTreUaMOObmNioB5=VGD0qjgerYTFf6Q@mail.gmail.com>
References: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
	<5d8ff922971892e85f4e682d687476645cf690e5.camel@codethink.co.uk>
	<CAEss1E+93RuXzGWeNMaTreUaMOObmNioB5=VGD0qjgerYTFf6Q@mail.gmail.com>
Message-ID: <5c024c43245bd5cdecd256fe9d74d6992ea95598.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2019-07-19 at 19:58 +0200, Zoran S wrote:
> > This never existed in the upstream kernel, only in -rt branches.
> > It still exists in 4.19-rt.
> 
> Sure. The following is done by me:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> 
> Isn't this CIP RT-kernel real-time tree?
[...]

It's the CIP kernel repository.  Only the branches with "-rt" in the
name include the real-time patch set.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
