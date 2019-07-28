From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Sun, 28 Jul 2019 06:22:17 +0200
Subject: [cip-dev] powerpc build with Kernel v4.4
In-Reply-To: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <CAEss1E+JD=vvXDAsz-tpisBsCAGnwbxnRNaiWJb9f+eJ+3+68A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Quick ad-hoc observation:

[1] From https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/260410825
> /opt/build_kernel.sh: line 123: [: /opt/cip-kernel-config/4.4/powerpc/toshiba_defconfig: unary operator expected

Interesting line...WTH is wrong with the line 123 (CONFIG_SPI_DEBUG=y)?

[2] From https://lkml.org/lkml/2019/2/27/106
On Tue, Feb 26, 2019 at 09:29:40AM -0800, Guenter Roeck wrote:
> In function ?user_regset_copyin?,
>     inlined from ?vr_set? at arch/powerpc/kernel/ptrace.c:490:9:
> include/linux/regset.h:258:4: error:
> ?memcpy? offset [-527, -529] is out of the bounds [0, 16] of object ?vrsave?
> with type ?union <anonymous>?
>
> The problem is not new. It is seen now because I switched to use
> gcc 8.3.0. The problem is fixed in linux-next.

You should contact Guenter Roeck and ask him about the following:
> The problem is not new. It is seen now because I switched to use
> gcc 8.3.0. The problem is fixed in linux-next.

Stress on: "The problem is fixed in linux-next".

My two cent worth thinking,
Zoran
_______

On Sat, Jul 27, 2019 at 11:29 PM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello all,
>
> I'm trying to build the toshiba_defconfig [1] for the powerpc architecture using the CIP v4.4 Kernel but I'm hitting some problems. The log from the build can be seen on GitLab [2].
>
> Has anyone tried building this configuration recently?
>
> I'm using gcc compiler v8.1.0. I mention this because I've see a half-related discussion [3] when Googling. From this mail thread I wonder if there are some patches we need to backport?
>
>
> [1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.4/powerpc/toshiba_defconfig
> [2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/260410825
> [3] https://lkml.org/lkml/2019/2/27/106
>
> Kind regards, Chris
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
