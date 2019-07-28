From: pavel@denx.de (Pavel Machek)
Date: Sun, 28 Jul 2019 09:40:44 +0200
Subject: [cip-dev] powerpc build with Kernel v4.4
In-Reply-To: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20190728074044.GA19089@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> I'm trying to build the toshiba_defconfig [1] for the powerpc architecture using the CIP v4.4 Kernel but I'm hitting some problems. The log from the build can be seen on GitLab [2].
> 
> Has anyone tried building this configuration recently?
> 
> I'm using gcc compiler v8.1.0. I mention this because I've see a half-related discussion [3] when Googling. From this mail thread I wonder if there are some patches we need to backport?
> 

Is there chance to use different gcc? Because this looks like gcc
bug... but workaround seems simple enough. Let me investigate some
more.

								Pavel





commit 9d2e929c3bae4c30afd1b00fdbe6f7d477e13e8c
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Thu Feb 14 11:08:29 2019 +1100

    powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

    commit ca6d5149d2ad0a8d2f9c28cbe379802260a0a5e0 upstream.

    GCC 8 warns about the logic in vr_get/set(), which with -Werror
    breaks
        the build:

      In function ?user_regset_copyin?,
                inlined from ?vr_set? at
                arch/powerpc/kernel/ptrace.c:628:9:
		      include/linux/regset.h:295:4: error: ?memcpy?
                offset [-527, -529] is
		      out of the bounds [0, 16] of object ?vrsave?
                with type ?union
		      <anonymous>? [-Werror=array-bounds]
		            arch/powerpc/kernel/ptrace.c: In function
                ?vr_set?:
		      arch/powerpc/kernel/ptrace.c:623:5: note:
                ?vrsave? declared here
		         } vrsave;

    This has been identified as a regression in GCC, see GCC bug
    88273.

    However we can avoid the warning and also simplify the logic and
    make
        it more robust.
	


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190728/5984ccfe/attachment.sig>
