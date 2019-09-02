From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:38 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/22] watchdog: renesas_wdt: drop
	superfluous glob pattern
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e18431264954247f76a8e7aeac3b68421e35e65a upstream.

If we want to match all revisions, it is enough to leave the field
empty.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index a579a23..c6ce244 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -154,7 +154,6 @@ static const struct soc_device_attribute rwdt_quirks_match[] = {
 		.data = (void *)1,	/* needs single CPU */
 	}, {
 		.soc_id = "r8a7792",
-		.revision = "*",
 		.data = (void *)0,	/* needs SMP disabled */
 	},
 	{ /* sentinel */ }
-- 
2.7.4
