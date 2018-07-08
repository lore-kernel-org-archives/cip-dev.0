From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sun, 08 Jul 2018 20:07:05 +0100
Subject: [cip-dev] [PATCH 55/86] ARM: shmobile: rcar-gen2: Make sure
 CNTVOFF is initialized on CA7/15
In-Reply-To: <1530283167-14050-56-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-56-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1531076825.21552.6.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-06-29 at 15:38 +0100, Fabrizio Castro wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> On Cortex-A7, the arch timer CNTVOFF register is uninitialized.
> Ideally it should be initialized by the boot loader, but it isn't.
> 
> For the boot CPU, CNTVOFF is initialized by Linux since commit
> 9ce3fa6816c2fb59 ("ARM: shmobile: rcar-gen2: Add CA7 arch_timer
> initialization for r8a7794").
> For secondary CPU cores, no such initialization is done.
> 
> Hence when enabling SMP on r8a7794, the kernel log is spammed with:
> 
> ????WARNING: Underflow in clocksource 'arch_sys_counter' observed, time update ignored.
> 	?????Please report this, consider using a different clocksource, if possible.
> 	?????Your kernel is probably still fine.
> 
> As Marc Zyngier pointed out that Cortex-A15 and Cortex-A7 are similar with
> respect to CNTVOFF, we have been very lucky this just worked on R-Car
> Gen2 SoCs with Cortex-A15 cores.
> 
> To fix this:
> ? - Move the existing inline asm code to initialize CNTVOFF to an
> ????assembler source file (adding comments and replacing hardcoded
> ????constants by definitions in the process), so it can be reused,
> ? - Perform the initialization of CNTVOFF on the boot CPU (Cortex-A15 or
> ????Cortex-A7) on all R-Car Gen2 and RZ/G1 parts,
> ? - Wrap the standard secondary_startup() routine inside a routine which
> ????initializes CNTVOFF.
> 
> Based on patches by Hisashi Nakamura in the BSP.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> (cherry picked from commit 3fd45a136ff61bb54deab70fb2d534a85e40481f)
> (move back to virt_to_phys to keep the code consistent)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
[...]

There is a related fix (but with an incorrect commit reference):

commit 703ef76b8fd5169d5cff30de5b958d6728b9a147
Author: Arnd Bergmann <arnd@arndb.de>
Date:???Thu Oct 5 14:09:04 2017 +0200

????ARM: shmobile: rcar-gen2: fix non-SMP build

I'll apply that along with this.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
