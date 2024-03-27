Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227C7CD11DD
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 12:07:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.35837.1711541238374582000
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 05:07:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 104171C007E; Wed, 27 Mar 2024 13:07:16 +0100 (CET)
Date: Wed, 27 Mar 2024 13:07:15 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 11/36] irqchip: Add RZ/G2L IA55 Interrupt
 Controller driver
Message-ID: <ZgQL8xwYwbaRdX4N@duo.ucw.cz>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
 <20240327081756.2228036-12-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aDkik8VTg1UoTnB0"
Content-Disposition: inline
In-Reply-To: <20240327081756.2228036-12-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 12:07:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15470


--aDkik8VTg1UoTnB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/irqchip/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)			+=3D irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
>  obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
> +obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
>  obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
>  obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-re=
nesas-rzg2l.c
> new file mode 100644
> index 000000000000..cf99cd6b41c4
> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -0,0 +1,394 @@
> +#define IRQC_IRQ_START			1
> +#define IRQC_IRQ_COUNT			8
> +#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
> +#define IRQC_TINT_COUNT			32

The code hardwires assumption that interrupts are IRQ_START
=2E. TINT_START .. TINT_START+TINT_COUNT.

> +	raw_spin_lock(&priv->lock);
> +	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> +		rzg2l_irq_eoi(d);

I'd do "< IRQC_TINT_START" here.

> +static void rzg2l_irqc_irq_disable(struct irq_data *d)
> +{
> +	unsigned int hw_irq =3D irqd_to_hwirq(d);
> +
> +	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {

And here.

> +	if (hwirq > (IRQC_NUM_IRQ - 1))
> +		return -EINVAL;

'>=3D IRQC_NUM_IRQ' would be more clear here.

> +static int rzg2l_irqc_init(struct device_node *node, struct device_node =
*parent)
> +{
> +	struct irq_domain *irq_domain, *parent_domain;
> +	struct platform_device *pdev;
> +	struct reset_control *resetn;
> +	struct rzg2l_irqc_priv *priv;
> +	int ret;
> +
> +	pdev =3D of_find_device_by_node(node);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	parent_domain =3D irq_find_host(parent);
> +	if (!parent_domain) {
> +		dev_err(&pdev->dev, "cannot find parent domain\n");
> +		return -ENODEV;
> +	}

I believe you'll need to put pdev in this and following error paths.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aDkik8VTg1UoTnB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgQL8wAKCRAw5/Bqldv6
8rm2AJwIsyjEEpBS7w66WCOlWv2rW6pQlgCgvy1Q2mPoBnMukQvzfaIRU9c3OD0=
=9mMj
-----END PGP SIGNATURE-----

--aDkik8VTg1UoTnB0--

