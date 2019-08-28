From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:39 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 12/41] pinctrl: sh-pfc: Improve
	PINMUX_IPSR_PHYS() documentation
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 360328c7dc15f48dd9b6187e7d4a9517a64e51f7 upstream.

  - The IPSR field is meant for documentation only,
  - The function name refers to the pin function, not to the IPSR
    field.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 499356d..f47a159 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -420,8 +420,8 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 /*
  * Describe a pinmux configuration in which a pin is physically multiplexed
  * with other pins.
- *   - ipsr: IPSR field
- *   - fn: Function name, also referring to the IPSR field
+ *   - ipsr: IPSR field (unused, for documentation purposes only)
+ *   - fn: Function name
  *   - psel: Physical multiplexing selector
  */
 #define PINMUX_IPSR_PHYS(ipsr, fn, psel) \
-- 
2.7.4
