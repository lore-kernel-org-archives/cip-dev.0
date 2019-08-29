From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:31 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 26/51] pinctrl: sh-pfc:
	rcar-gen3: Retain TDSELCTRL register across suspend/resume
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-27-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

commit d92ee9cf8ec8d7fe1d7dbc4b3ee459419b1e5533 upstream.

The TDSELCTRL register is responsible for configuring the SDHI/MMC clock
return path delay and may be adjusted by the bootloader. Retain the value
across suspend/resume to prevent hardware instability after resume.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[fab: dropped changes not related to either r8a7796 or r8a77990]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c  | 2 ++
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 3a178d89..7fe0f9f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -5859,10 +5859,12 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 
 enum ioctrl_regs {
 	POCCTRL,
+	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
+	[TDSELCTRL] = { 0xe60603c0, },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 9ade895..7e7d70f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -4997,10 +4997,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 enum ioctrl_regs {
 	POCCTRL0,
+	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL0] = { 0xe6060380, },
+	[TDSELCTRL] = { 0xe60603c0, },
 	{ /* sentinel */ },
 };
 
-- 
2.7.4
