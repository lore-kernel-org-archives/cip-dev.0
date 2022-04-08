Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D2C38161
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.7776.1649433544808247452
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Apr 2022 08:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7584D1C0B8C; Fri,  8 Apr 2022 17:58:59 +0200 (CEST)
Date: Fri, 8 Apr 2022 17:58:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: 5.10.110-rc2 mirroring/testing
Message-ID: <20220408155858.GA4221@duo.ucw.cz>
References: <20220406220612.GB4213@duo.ucw.cz>
 <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Apr 2022 17:09:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8024


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 5.10.110-rc2 is out, and it would be good to test it, but somehow we
> > are still at -rc1...?
>=20
> Already linux-stable-rc uses 11G by now.

I see there are some changes:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

but it seems to say "authored 12 minutes ago". Hour ago it also said
"authored 12 minutes ago", so I believe it will not be able to finish
the tests.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYlBbwgAKCRAw5/Bqldv6
8vWWAJ9Q6Mjz8y9acJl83r+YRMbHodSc1gCfSz5CkARGxd9BQQaiTKJToKQn21o=
=W2Rv
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

