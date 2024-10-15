Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E728D1D89A
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 18:34:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4407.1729017247329750402
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 11:34:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE2841C0095; Tue, 15 Oct 2024 20:34:05 +0200 (CEST)
Date: Tue, 15 Oct 2024 20:34:05 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: gitlab mirroring slow? Re: [cip-dev] lab-cip-renesas offline
Message-ID: <Zw61nUmWBkUfH9rN@duo.ucw.cz>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz>
 <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nbxnva63QQTEIf0v"
Content-Disposition: inline
In-Reply-To: <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 18:34:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17042


--Nbxnva63QQTEIf0v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

gitlab mirroring is either slow or not working. 6.1.113-rc2 is already
available for a while,

commit 7e3aa874350e5222a88aac9d02d8bc5a8ff44f80 (origin/linux-6.1.y)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue Oct 15 13:24:42 2024 +0200

    Linux 6.1.113-rc2


But there's still -rc1 at gitlab.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Linux 6.1.113-rc1 (c060104c065d)
=EF=BF=BC
Greg Kroah-Hartman authored 18 hours ago

Pipeline schedule says next run in 2 hours:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipeline_sc=
hedules

I can try to trigger it, but I already tried that and no luck.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nbxnva63QQTEIf0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZw61nQAKCRAw5/Bqldv6
8k9pAKC8C/uy+TRmIU+os7iVV9MPwxjpeQCfeHeaI604xVM12cLvFdz8MilSzrI=
=MU8K
-----END PGP SIGNATURE-----

--Nbxnva63QQTEIf0v--

