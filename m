From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:36 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 02/22] watchdog: renesas_wdt: Fix typos
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit f8cde726739c60109cc4a30b6b5475b5bd5e1d97 upstream.

Do not use "," but ";" to separate instructions.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
---
 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 62d9d3e..777c5a1 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -228,8 +228,8 @@ static int rwdt_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	priv->wdev.info = &rwdt_ident,
-	priv->wdev.ops = &rwdt_ops,
+	priv->wdev.info = &rwdt_ident;
+	priv->wdev.ops = &rwdt_ops;
 	priv->wdev.parent = &pdev->dev;
 	priv->wdev.min_timeout = 1;
 	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
-- 
2.7.4
