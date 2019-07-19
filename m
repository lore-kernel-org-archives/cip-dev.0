From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Fri, 19 Jul 2019 19:58:04 +0200
Subject: [cip-dev] [OBSOLETE?] CONFIG_PREEMPT_RT_FULL config parameter
	in 4.19?!
In-Reply-To: <5d8ff922971892e85f4e682d687476645cf690e5.camel@codethink.co.uk>
References: <CAEss1E+HzuGDxBCww0dkShV6Wqe-cnSpxCuM_kiq=0TtXOjo-A@mail.gmail.com>
	<5d8ff922971892e85f4e682d687476645cf690e5.camel@codethink.co.uk>
Message-ID: <CAEss1E+93RuXzGWeNMaTreUaMOObmNioB5=VGD0qjgerYTFf6Q@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> This never existed in the upstream kernel, only in -rt branches.
> It still exists in 4.19-rt.

Sure. The following is done by me:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git

*Isn't this CIP RT-kernel real-time tree?*

cd linux-cip
*git checkout -b cip_v4.19.58-cip6 v4.19.58-cip6*

make -j4 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
*omap2plus_defconfig*

Please, check the folllowing:

Linux stretch 4.19.0-5-amd64 #1 SMP Debian 4.19.37-5 (2019-06-19) x86_64

vagrant at stretch:~/git-repos/linux-cip/build-arm$ pwd
/home/vagrant/git-repos/linux-cip/build-arm
vagrant at stretch:~/git-repos/linux-cip/build-arm$ ls -al .config
*-rw-r--r-- 1 vagrant vagrant 148183 Jul 18 04:25 .config*
vagrant at stretch:~/git-repos/linux-cip/build-arm$ cat .config | grep PREEMPT
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
vagrant at stretch:~/git-repos/linux-cip/build-arm $

And, finally:

vagrant at stretch:~/git-repos/linux-cip$ pwd
/home/vagrant/git-repos/linux-cip
vagrant at stretch:~/git-repos/linux-cip$ ack CONFIG_PREEMPT_RT_FULL
vagrant at stretch:~/git-repos/linux-cip$

Hmmmmmm... Strange, isn't it??? Please, advise?

Thank you,
Zoran Stojsavljevic
_______


On Fri, Jul 19, 2019 at 3:58 PM Ben Hutchings <ben.hutchings@codethink.co.uk>
wrote:

> On Fri, 2019-07-19 at 15:31 +0200, Zoran S wrote:
> > Hello  Ben, Daniel,
> >
> > I started my own investigation about RT kernels, namely 4.19. I
> > proceed very carefully over the kernel config parameters... BUt the
> > last one I inspected today got me nowhere!?
> >
> > Seems, that the following config parameters are obsolete in 4.19:
> > CONFIG_PREEMPT_RT_FULL
> [...]
>
> This never existed in the upstream kernel, only in -rt branches.  It
> still exists in 4.19-rt.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190719/a022d547/attachment.html>
