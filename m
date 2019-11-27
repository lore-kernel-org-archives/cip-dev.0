From: pavel@denx.de (Pavel Machek)
Date: Wed, 27 Nov 2019 18:59:13 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/22] Add RZ/G1C SD/eMMC support
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191127175913.GB12777@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch series add SD/eMMC support support for RZ/G1C sbc.
> 
> RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an internal DMA for data transfer which is similar to R-Car Gen3.
> 
> Support for internal DMAC is added in 4.14 kernel and support for
> RZ/G1C added on 4.20 kernel.

Thanks for doing this, and extra thanks for using rename detection so
diffs are easy to read :-).

Series looks good, but I got this while applying:

pavel at amd:~/cip/k$ ~/cip/git-am /tmp/delme.h
Applying: mmc: sdhi: Add EXT_ACC register busy check
Applying: mmc: sh_mobile_sdhi: don't use array for DT configs
Applying: mmc: sh_mobile_sdhi: simplify code for voltage switching
Applying: mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3
Applying: mmc: tmio: always unmap DMA before waiting for interrupt
Applying: mmc: tmio: rename tmio_mmc_{pio => core}.c
Applying: mmc: renesas-sdhi: rename tmio_mmc_dma.c =>
renesas_sdhi_sys_dmac.c
Applying: mmc: renesas-sdhi: rename sh_mobile_sdhi.c =>
renesas_sdhi_core.c
Applying: mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module
file
error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:48
error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply
Patch failed at 0009 mmc: renesas-sdhi: make renesas_sdhi_sys_dmac
main module file
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am
--abort".

Let me try to apply patches 1-8 and try to get them tested.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191127/8caf9c0a/attachment.sig>
