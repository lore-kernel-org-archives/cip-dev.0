From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 24 Aug 2018 19:17:13 +0100
Subject: [cip-dev] [PATCH 24/42] watchdog: renesas_wdt: Add restart
	handler
In-Reply-To: <1532626980-17190-25-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1532626980-17190-25-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1535134633.2902.41.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-07-26 at 18:42 +0100, Fabrizio Castro wrote:
> On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> by means of the watchdog.
> This patch adds a restart handler to rwdt_ops, and also makes sure we
> keep its priority to the lowest level, in order to not override other
> more effective handlers.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> (cherry picked from commit 089bcaa87e772beb005068a5ef28c71bb895d01d)
> (changed restart handler implementation as .restart is not available
> from struct watchdog_ops)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> ?drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
> ?1 file changed, 26 insertions(+)
[...]
> @@ -205,6 +229,8 @@ static int rwdt_remove(struct platform_device *pdev)
> ?{
> ?	struct rwdt_priv *priv = platform_get_drvdata(pdev);
> ?
> +	if (priv->restart_handler.notifier_call);

There is a rogue semi-colon at the end of the line, so this if-
statement doesn't have any effect!

gcc 6 warns about this:

drivers/watchdog/renesas_wdt.c: In function ?rwdt_remove?:
drivers/watchdog/renesas_wdt.c:234:2: warning: this ?if? clause does not guard... [-Wmisleading-indentation]
  if (priv->restart_handler.notifier_call);
  ^~
drivers/watchdog/renesas_wdt.c:235:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ?if?
   unregister_restart_handler(&priv->restart_handler);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~

but perhaps you are using an older compiler?

I'll fix this up since it's obvious what you intended.

Ben.

> +		unregister_restart_handler(&priv->restart_handler);
> ?	watchdog_unregister_device(&priv->wdev);
> ?	pm_runtime_disable(&pdev->dev);
> ?
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
