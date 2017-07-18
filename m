From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jul 2017 16:30:23 +0100
Subject: [cip-dev] [PATCH  0/6] Basic SoC support for r8a7743/r8a7745
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1500391823.1935.111.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-07-12 at 10:21 +0100, Biju Das wrote:
> This series aims to add basic SoC support for  
> r8a7743/r8a7745. All the patches in this series
> are cherry-picked from the upstream kernel.
> 
> This series has been tested against linux-cip tag v4.4.75-cip6.

These all look good to me, so I've applied these to the linux-4.4.y-cip
branch.  Are you going to add more driver support (e.g. ravb, xhci-rcar)
and device tree sources?

Ben.

> Laurent Pinchart (1):
>   ARM: shmobile: Consolidate R8A7743 and R8A779[234] machine definitions
> 
> Sergei Shtylyov (5):
>   sh_eth: add R8A7743/5 support
>   DT: irqchip: renesas-irqc: document R8A7743/5 support
>   sh-sci: document R8A7743/5 support
>   ARM: shmobile: r8a7743: basic SoC support
>   ARM: shmobile: r8a7745: basic SoC support
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |  4 +++
>  .../bindings/interrupt-controller/renesas,irqc.txt |  4 ++-
>  Documentation/devicetree/bindings/net/sh_eth.txt   |  2 ++
>  .../bindings/serial/renesas,sci-serial.txt         |  8 ++++++
>  arch/arm/mach-shmobile/Kconfig                     |  8 ++++++
>  arch/arm/mach-shmobile/Makefile                    |  2 --
>  arch/arm/mach-shmobile/setup-r8a7793.c             | 33 ----------------------
>  arch/arm/mach-shmobile/setup-r8a7794.c             | 33 ----------------------
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           | 33 ++++++++++++++++++++++
>  drivers/net/ethernet/renesas/Kconfig               |  2 +-
>  drivers/net/ethernet/renesas/sh_eth.c              |  2 ++
>  11 files changed, 61 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
> 

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
