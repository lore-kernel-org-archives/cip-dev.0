Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E1C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 19:01:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.53712.1710788480575755896
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 12:01:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DC7711C007E; Mon, 18 Mar 2024 20:01:17 +0100 (CET)
Date: Mon, 18 Mar 2024 20:01:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: Backporting Renesas IA55 IRQC driver
Message-ID: <ZfiPfc9UZGcIL25F@duo.ucw.cz>
References: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
 <Zfgvq46kKNklD/tK@duo.ucw.cz>
 <TYCPR01MB6478033DC33FDEA53E2D809D9F2D2@TYCPR01MB6478.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCxzgdcV0E5BpHTC"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB6478033DC33FDEA53E2D809D9F2D2@TYCPR01MB6478.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 19:01:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15362


--FCxzgdcV0E5BpHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > and then arrange new_style_board to be set on machines you converted but
> > nowhere else. Best would be passing that information down the callchain
> > somehow, but you use have global variable or even config option...
>=20
> IIUC the proposal here: the of_device_alloc() is called in the
> initialization phase, this being the call stack:
>=20
> [    0.057410] Call trace:
> [    0.057438]  dump_backtrace+0x0/0x1c0
> [    0.057453]  show_stack+0x18/0x40
> [    0.057471]  dump_stack+0xe8/0x124
> [    0.057489]  of_device_alloc+0x54/0x1dc
> [    0.057501]  of_platform_device_create_pdata.part.0+0x24/0xc4
> [    0.057520]  of_platform_device_create_pdata+0x74/0xa0
> [    0.057533]  of_platform_bus_create+0x180/0x3e0
> [    0.057545]  of_platform_populate+0x58/0xfc
> [    0.057563]  of_platform_default_populate_init+0xb8/0xdc
> [    0.057576]  do_one_initcall+0x50/0x1c0
> [    0.057596]  kernel_init_freeable+0x230/0x298
> [    0.057609]  kernel_init+0x14/0x118
> [    0.057620]  ret_from_fork+0x10/0x38
>=20
> while the IRQ driver is probed and used later, so, I cannot pass
> information from driver to of_device_alloc().
>=20
> Based on your proposal, what about the following diff (or something
> similar)? Would it be acceptable for CIP:

This is just a warning workarond, AFAICT, so I guess more will be
needed and I'm not the only stakeholder. We'll need to see whole
series. But this sounds better than 1/ or 2/ alternatives proposed.

> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 43748c6480c8..ddbd46043d46 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -135,7 +135,8 @@ struct platform_device *of_device_alloc(struct device=
_node *np,
>                         rc =3D of_address_to_resource(np, i, res);
>                         WARN_ON(rc);
>                 }
> -               if (of_irq_to_resource_table(np, res, num_irq) !=3D num_i=
rq)
> +               if (!of_device_is_compatible(np, "renesas,rzg2l-irqc") &&
> +                   of_irq_to_resource_table(np, res, num_irq) !=3D num_i=
rq)
>                         pr_debug("not all legacy IRQ resources mapped for=
 %pOFn\n",
>                                  np);
>         }
>=20
> where "renesas,rzg2l-irqc" is the compatible for IA55 IRQ driver.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FCxzgdcV0E5BpHTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfiPfQAKCRAw5/Bqldv6
8onZAJsHoI/S/7FoJLq8XbevNh97Z4IQ1wCgk62HOwCGZ3FNVy2YCNxYT1bouxk=
=R2Rp
-----END PGP SIGNATURE-----

--FCxzgdcV0E5BpHTC--

