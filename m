From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 19 Jul 2019 14:58:29 +0100
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter
	in 4.19?!
In-Reply-To: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
References: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
Message-ID: <5d8ff922971892e85f4e682d687476645cf690e5.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2019-07-19 at 15:31 +0200, Zoran S wrote:
> Hello  Ben, Daniel,
> 
> I started my own investigation about RT kernels, namely 4.19. I
> proceed very carefully over the kernel config parameters... BUt the
> last one I inspected today got me nowhere!?
> 
> Seems, that the following config parameters are obsolete in 4.19:
> CONFIG_PREEMPT_RT_FULL
[...]

This never existed in the upstream kernel, only in -rt branches.  It
still exists in 4.19-rt.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
