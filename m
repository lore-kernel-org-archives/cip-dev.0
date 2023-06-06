Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B97C7EE2F
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:01:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5087.1686045665600189444
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2BBC21C0CAF; Tue,  6 Jun 2023 12:01:03 +0200 (CEST)
Date: Tue, 6 Jun 2023 12:01:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 4/8] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Message-ID: <ZH8D3lCobUJP2T4K@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFuXEj5kvXjbOwMl"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-5-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11856


--iFuXEj5kvXjbOwMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This commit adds cascade_counts_enable and external_input_phase_
> clock_select items to counter ABI file.
> (e.g. for Renesas MTU3 hardware used for phase counting).

> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -1,3 +1,33 @@
> +What:		/sys/bus/counter/devices/counterX/cascade_counts_enable
> +KernelVersion:	6.4
> +KernelVersion:	6.1
> +KernelVersion:  6.1

Indentation is not consistent here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iFuXEj5kvXjbOwMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH8D3gAKCRAw5/Bqldv6
8r+oAJ40fNJjOV1HyxISSIZc1+q0BoagbACgq9fdyWdTx/YJDBvlU4IORnQUl5M=
=3pJQ
-----END PGP SIGNATURE-----

--iFuXEj5kvXjbOwMl--

