Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334CC77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 20:25:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1392.1684182327179855805
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 13:25:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DFEF31C0E4B; Mon, 15 May 2023 22:25:23 +0200 (CEST)
Date: Mon, 15 May 2023 22:25:23 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com
Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add audit and
 nftables configs
Message-ID: <ZGKVMzAz/daB/o2G@duo.ucw.cz>
References: <20230515121238.14356-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fF9RQ9nsIOaS5abN"
Content-Disposition: inline
In-Reply-To: <20230515121238.14356-1-Sai.Sathujoda@toshiba-tsip.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 20:25:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11456


--fF9RQ9nsIOaS5abN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These kernel configs are required for nftables and auditd package
> to work which is used for IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Looks good to me, but likely we should do similar changes for 6.1.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fF9RQ9nsIOaS5abN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGKVMwAKCRAw5/Bqldv6
8huTAJ4jplGFwhmpccGZgP7zMzDn5LR1/ACePpgrYnO3rrdGenBgCtcr0EAMpG0=
=oBHs
-----END PGP SIGNATURE-----

--fF9RQ9nsIOaS5abN--

