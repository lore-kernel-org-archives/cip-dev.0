Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF9FC4829A
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 10:13:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18352.1707214378881624302
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 02:12:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AE29B1C0081; Tue,  6 Feb 2024 11:12:55 +0100 (CET)
Date: Tue, 6 Feb 2024 11:12:55 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Message-ID: <ZcIGJ+Rd3xJAgTLZ@duo.ucw.cz>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB638894EFF5D8E2BA83D45B0992462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019F985CDD1F11C0671EEBBAA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="akBWAosQJmzF8Oqe"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB7019F985CDD1F11C0671EEBBAA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 10:13:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14780


--akBWAosQJmzF8Oqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I can not apply this patch cip/Linux-5.10.y-cip.
> > Could you check this ?
> >=20
> > $ git am -s patch.series
> > Applying: arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_E=
N to board DTS
> > Applying: arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into boar=
d DTS
> > Applying: arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ(=
) macro to specify interrupt
> > property
> > Applying: arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI ch=
annels
> > Applying: arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specifi=
c parts
> > Applying: cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
> > Applying: riscv: Kconfig: Enable cpufreq kconfig menu
> > Applying: dma-direct: add support for dma_coherent_default_memory
> > Applying: dma-mapping: allow using the global coherent pool for !ARM
> > Applying: dma-mapping: simplify dma_init_coherent_memory
> > error: patch failed: kernel/dma/coherent.c:37
> > error: kernel/dma/coherent.c: patch does not apply Patch failed at 0010=
 dma-mapping: simplify
> > dma_init_coherent_memory
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch =
When you have resolved this
> > problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >=20
> My patch series was based on v5.10.208-cip43, I'll rebase and send the v2=
 soon after testing.

That's a bad coincidence. Hopefully we won't have too many conflicts
in that code in future, as it looks a bit tricky.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--akBWAosQJmzF8Oqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcIGJwAKCRAw5/Bqldv6
8kqkAJ9ecUloTKhl1by/mx5MZOsZgBoTIACcD2Eob0NaWHIUOVaWRsUXuhLnhIo=
=usrw
-----END PGP SIGNATURE-----

--akBWAosQJmzF8Oqe--

