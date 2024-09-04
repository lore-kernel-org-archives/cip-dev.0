Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D90CD37B4
	for <webhook@archiver.kernel.org>; Wed,  4 Sep 2024 13:12:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.49691.1725455573067402064
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 06:12:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E14C11C00A1; Wed,  4 Sep 2024 15:12:49 +0200 (CEST)
Date: Wed, 4 Sep 2024 15:12:49 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st56, 4.4-cip91
Message-ID: <Zthc0X8oAPukA+bf@duo.ucw.cz>
References: <1429823644.5400616.1725385132328@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aq25B81z0hP4WG0z"
Content-Disposition: inline
In-Reply-To: <1429823644.5400616.1725385132328@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 13:12:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16846


--aq25B81z0hP4WG0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Thanks for the heads-up. Your backports look good.

a > 72982c66626c7 exec: Fix ToCToU between perm check and set-uid/gid usage
a > 8a5da8b6126e2 USB: serial: debug: do not echo input by default
a > 4af9a95deab1a ALSA: line6: Fix racy access to midibuf
a > e8ec978a784ee i2c: smbus: Send alert notifications to all devices if so=
urce not found
a just a robustness agaisnt bad hw > ad01acb964a7f i2c: smbus: Improve hand=
ling of stuck alerts
a > 733e3de52985d SUNRPC: Fix a race to wake a sync task
a not a minimum fix > 52bcba99c1772 udf: prevent integer overflow in udf_bi=
tmap_free_blocks()
!! still buggy? sizeof(buffer)-len < 0, but snprintf takes unsigned > 9f1f1=
bc701217 dev/parport: fix the array out-of-bounds risk
a just a robustness > 067c903b48150 tipc: Return non-zero value from tipc_u=
dp_addr2str() on error
a > d9b7eda8938fd hwrng: amd - Convert PCIBIOS_* return codes to errnos
a just a preparation > c75ed93ef09eb net: fec: Refactor: #define magic cons=
tants

The parport change... "9f1f1bc701217 dev/parport: fix the array
out-of-bounds risk": I believe this is still not correct.

        if ((str =3D info->class_name) !=3D NULL)
-               len +=3D sprintf (buffer + len, "CLASS:%s;\n", str);
+               len +=3D snprintf (buffer + len, sizeof(buffer) - len, "CLA=
SS:%s;\n", str);
=20
        if ((str =3D info->model) !=3D NULL)
-               len +=3D sprintf (buffer + len, "MODEL:%s;\n", str);
+               len +=3D snprintf (buffer + len, sizeof(buffer) - len, "MOD=
EL:%s;\n", str);

snprintf will return "how much it would like to write". So
sizoeof(buffer) - len will be < 0, AFAICT. But snprintf takes unsigned
value, so it will see huge space available and overwrite.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aq25B81z0hP4WG0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZthc0QAKCRAw5/Bqldv6
8oa5AJ4heD2Eeg9wWM2rj2OrjpsJxTWcHQCglNMiBW3XhlmXbUAgZJBJO5oVzsU=
=dG+r
-----END PGP SIGNATURE-----

--aq25B81z0hP4WG0z--

