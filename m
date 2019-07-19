From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 19 Jul 2019 15:59:32 +0200
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter
 in 4.19?!
In-Reply-To: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
References: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
Message-ID: <20190719135932.GA23951@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> I started my own investigation about RT kernels, namely 4.19. I
> proceed very carefully over the kernel config parameters... BUt the
> last one I inspected today got me nowhere!?
> 
> Seems, that the following config parameters are obsolete in 4.19:
> CONFIG_PREEMPT_RT_FULL
> 
> This one (CONFIG_PREEMPT_RT_FULL) is still present in 4.4 .
> 
> [vuser at fedora30-ssd kernel-config]$ cat CONFIG-4.4.120-rt-bbb | grep PREEMPT
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_RT_BASE=y
> CONFIG_HAVE_PREEMPT_LAZY=y
> CONFIG_PREEMPT_LAZY=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT__LL is not set
> # CONFIG_PREEMPT_RTB is not set
> CONFIG_PREEMPT_RT_FULL=y <<======= Obsolete in 4.19 ?
> CONFIG_PREEMPT_COUNT=y
> CONFIG_DEBUG_PREEMPT=y
> [vuser at fedora30-ssd kernel-config]$
> 
> What I should do to maintain RT-kernel-4.19? It is obvious, I must/need to set:
> CONFIG_PREEMPT=y

Are you sure you have your kernel patched with -rt patches?
CONFIG_PREEMPT_RT_FULL=y was still needed in 4.19, AFAICT.

Note that not every piece of hardware has suitable characteristics for
realtime / low latencies.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190719/72b0ce91/attachment-0001.sig>
