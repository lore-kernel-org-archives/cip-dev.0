From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 28 Aug 2018 09:00:01 +0000
Subject: [cip-dev] [PATCH 24/42] watchdog: renesas_wdt: Add restart
	handler
In-Reply-To: <1535134633.2902.41.camel@codethink.co.uk>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1532626980-17190-25-git-send-email-fabrizio.castro@bp.renesas.com>
	<1535134633.2902.41.camel@codethink.co.uk>
Message-ID: <TY1PR01MB1770BF8D5C5A94E3F916C3D1C00A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you for your feedback.

> -----Original Message-----
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Sent: 24 August 2018 19:17
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH 24/42] watchdog: renesas_wdt: Add restart handler
>
> On Thu, 2018-07-26 at 18:42 +0100, Fabrizio Castro wrote:
> > On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> > by means of the watchdog.
> > This patch adds a restart handler to rwdt_ops, and also makes sure we
> > keep its priority to the lowest level, in order to not override other
> > more effective handlers.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> > (cherry picked from commit 089bcaa87e772beb005068a5ef28c71bb895d01d)
> > (changed restart handler implementation as .restart is not available
> > from struct watchdog_ops)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> [...]
> > @@ -205,6 +229,8 @@ static int rwdt_remove(struct platform_device *pdev)
> >  {
> >  struct rwdt_priv *priv = platform_get_drvdata(pdev);
> >
> > +if (priv->restart_handler.notifier_call);

Good catch!

>
> There is a rogue semi-colon at the end of the line, so this if-
> statement doesn't have any effect!
>
> gcc 6 warns about this:
>
> drivers/watchdog/renesas_wdt.c: In function ?rwdt_remove?:
> drivers/watchdog/renesas_wdt.c:234:2: warning: this ?if? clause does not guard... [-Wmisleading-indentation]
>   if (priv->restart_handler.notifier_call);
>   ^~
> drivers/watchdog/renesas_wdt.c:235:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ?if?
>    unregister_restart_handler(&priv->restart_handler);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> but perhaps you are using an older compiler?

Yes I am unfortunately

>
> I'll fix this up since it's obvious what you intended.


Thank you!

Fab

>
> Ben.
>
> > +unregister_restart_handler(&priv->restart_handler);
> >  watchdog_unregister_device(&priv->wdev);
> >  pm_runtime_disable(&pdev->dev);
> >
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
