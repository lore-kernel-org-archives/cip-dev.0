From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 12 Jul 2017 10:21:06 +0100
Subject: [cip-dev] [PATCH  1/6] sh_eth: add R8A7743/5 support
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499851271-20037-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for the first two members of the Renesas RZ/G family, RZ/G1M/E
(also known as  R8A7743/5). The Ether core is the same as in the R-Car gen2
SoCs, so will share the code/data with them...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit c099ff3cdb9dd2281dee3dc4ef89fec1c516df22)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/sh_eth.txt | 2 ++
 drivers/net/ethernet/renesas/Kconfig             | 2 +-
 drivers/net/ethernet/renesas/sh_eth.c            | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/sh_eth.txt b/Documentation/devicetree/bindings/net/sh_eth.txt
index 2f6ec85..0115c85 100644
--- a/Documentation/devicetree/bindings/net/sh_eth.txt
+++ b/Documentation/devicetree/bindings/net/sh_eth.txt
@@ -5,6 +5,8 @@ interface contains.
 
 Required properties:
 - compatible: "renesas,gether-r8a7740" if the device is a part of R8A7740 SoC.
+	      "renesas,ether-r8a7743"  if the device is a part of R8A7743 SoC.
+	      "renesas,ether-r8a7745"  if the device is a part of R8A7745 SoC.
 	      "renesas,ether-r8a7778"  if the device is a part of R8A7778 SoC.
 	      "renesas,ether-r8a7779"  if the device is a part of R8A7779 SoC.
 	      "renesas,ether-r8a7790"  if the device is a part of R8A7790 SoC.
diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 270c4c9..0f86521 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -27,7 +27,7 @@ config SH_ETH
 	  Renesas SuperH Ethernet device driver.
 	  This driver supporting CPUs are:
 		- SH7619, SH7710, SH7712, SH7724, SH7734, SH7763, SH7757,
-		  R8A7740, R8A777x and R8A779x.
+		  R8A7740, R8A774x, R8A777x and R8A779x.
 
 config RAVB
 	tristate "Renesas Ethernet AVB support"
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 480f3da..c04b4ea 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3055,6 +3055,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 
 static const struct of_device_id sh_eth_match_table[] = {
 	{ .compatible = "renesas,gether-r8a7740", .data = &r8a7740_data },
+	{ .compatible = "renesas,ether-r8a7743", .data = &r8a779x_data },
+	{ .compatible = "renesas,ether-r8a7745", .data = &r8a779x_data },
 	{ .compatible = "renesas,ether-r8a7778", .data = &r8a777x_data },
 	{ .compatible = "renesas,ether-r8a7779", .data = &r8a777x_data },
 	{ .compatible = "renesas,ether-r8a7790", .data = &r8a779x_data },
-- 
1.9.1
