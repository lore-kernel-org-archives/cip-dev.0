Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BFEC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 19:48:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77654.1722541727408364454
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 12:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A789A1C008E; Thu,  1 Aug 2024 21:48:43 +0200 (CEST)
Date: Thu, 1 Aug 2024 21:48:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y cip 0/8] Backport ravb driver performance
 improvements
Message-ID: <Zqvmmy93WNzvezGB@duo.ucw.cz>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
 <ZqntqGYravYHauM1@duo.ucw.cz>
 <ac9dbdc6-ef2f-453a-bc0a-94db12e95414@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FS8l9KcwPPm+kn0G"
Content-Disposition: inline
In-Reply-To: <ac9dbdc6-ef2f-453a-bc0a-94db12e95414@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 19:48:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16707


--FS8l9KcwPPm+kn0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This series includes the performance improvements present in Linux
> >> v6.11-rc1 along with dependencies.
> >=20
> > That's a bit aggressive timing, is it? -rc1 does not really get much
> > testing.
>=20
> Hi Pavel,
>=20
> Please feel free to delay merging these patches for a couple of rc
> cycles if you need to.

I'm getting:

drivers/net/ethernet/renesas/ravb_main.c: In function 'ravb_rx_gbeth':
2534
drivers/net/ethernet/renesas/ravb_main.c:869:33: error: implicit declaratio=
n of function 'skb_mark_for_recycle' [-Werror=3Dimplicit-function-declarati=
on]
2535
  869 |                                 skb_mark_for_recycle(skb);
2536
      |                                 ^~~~~~~~~~~~~~~~~~~~
2537

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/7484664109
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1397249930

When attempting to test this. Fix is probably as simple as:

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/etherne=
t/renesas/ravb_main.c
index 2a48ffc08464f..25a15cda707a0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -31,6 +31,7 @@
 #include <linux/sys_soc.h>
 #include <linux/reset.h>
 #include <linux/math64.h>
+#include <linux/skbuff.h>
 #include <net/ip.h>
 #include <net/page_pool.h>

But... what about this:

In about two weeks, you submit new version with blank line replaced by
Reviewed-by: Pavel Machek <pavel@denx.de>

?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FS8l9KcwPPm+kn0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqvmmwAKCRAw5/Bqldv6
8iwzAJ9YAdGjy2BxLyf7aRNYxuIh1XmWzQCgxMdI++G3PJxLxjuXorph9HyAgOs=
=IDo3
-----END PGP SIGNATURE-----

--FS8l9KcwPPm+kn0G--

