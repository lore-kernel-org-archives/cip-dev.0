From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jul 2017 16:58:20 +0100
Subject: [cip-dev] [PATCH  0/6] Basic SoC support for r8a7743/r8a7745
In-Reply-To: <1500391823.1935.111.camel@codethink.co.uk>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
	<1500391823.1935.111.camel@codethink.co.uk>
Message-ID: <1500393500.1935.119.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2017-07-18 at 16:30 +0100, Ben Hutchings wrote:
> On Wed, 2017-07-12 at 10:21 +0100, Biju Das wrote:
> > This series aims to add basic SoC support for  
> > r8a7743/r8a7745. All the patches in this series
> > are cherry-picked from the upstream kernel.
> > 
> > This series has been tested against linux-cip tag v4.4.75-cip6.
> 
> These all look good to me, so I've applied these to the linux-4.4.y-cip
> branch.  Are you going to add more driver support (e.g. ravb, xhci-rcar)
> and device tree sources?

Actually, there's something not quite right here.  With just
CONFIG_ARCH_R8A7743 and CONFIG_ARCH_R8A7745 enabled (but no other R-Car
platforms) I get:

arch/arm/mach-shmobile/built-in.o: In function `rcar_gen2_timer_init':
/home/bwh/ln001-cip/kernel/arch/arm/mach-shmobile/setup-rcar-gen2.c:131: undefined reference to `rcar_gen2_clocks_init'

There seems to have been a lot of refactoring of
drivers/clk/{shmobile,renesas} since 4.4 so I'm not sure how this should
be fixed.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
