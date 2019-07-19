From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Fri, 19 Jul 2019 15:31:57 +0200
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter in
	4.19?!
Message-ID: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello  Ben, Daniel,

I started my own investigation about RT kernels, namely 4.19. I
proceed very carefully over the kernel config parameters... BUt the
last one I inspected today got me nowhere!?

Seems, that the following config parameters are obsolete in 4.19:
CONFIG_PREEMPT_RT_FULL

This one (CONFIG_PREEMPT_RT_FULL) is still present in 4.4 .

[vuser at fedora30-ssd kernel-config]$ cat CONFIG-4.4.120-rt-bbb | grep PREEMPT
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT__LL is not set
# CONFIG_PREEMPT_RTB is not set
CONFIG_PREEMPT_RT_FULL=y <<======= Obsolete in 4.19 ?
CONFIG_PREEMPT_COUNT=y
CONFIG_DEBUG_PREEMPT=y
[vuser@fedora30-ssd kernel-config]$

What I should do to maintain RT-kernel-4.19? It is obvious, I must/need to set:
CONFIG_PREEMPT=y

Anything else?

Any viable/reasonable explanation why CONFIG_PREEMPT_RT_FULL was
removed in 4.19?

Thank you,
Zoran Stojsavljevic
_______
