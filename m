Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E1FC4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 10:45:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.44370.1669373144737941237
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Nov 2022 02:45:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E76D91C09FE; Fri, 25 Nov 2022 11:45:41 +0100 (CET)
Date: Fri, 25 Nov 2022 11:45:41 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] cip/linux-4.4.y-cip build: 180 builds: 0 failed, 180
 passed, 196 warnings (v4.4.302-cip70-98-g7f7838c92740) #kernelci
Message-ID: <Y4Cc1VnR9+W4Nr7G@duo.ucw.cz>
References: <6380747d.170a0220.c8a23.38be@mx.google.com>
 <TYCPR01MB10588D04A18B949134BE7DD0BB70E9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7G/k/y6MZlYSaUht"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB10588D04A18B949134BE7DD0BB70E9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 10:45:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10106


--7G/k/y6MZlYSaUht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of kernelci.org bot via lists.cip-project.org
> > Sent: 25 November 2022 07:54
> >=20
> > cip/linux-4.4.y-cip build: 180 builds: 0 failed, 180 passed, 196 warnin=
gs
> > (v4.4.302-cip70-98-g7f7838c92740)
>=20
> It looks like we're getting a lot of new build warnings in this build com=
pared to the last where we only had 16.
> Scroll to the bottom of these links to see a summary.
> Summary of this build (commit 7f7838c92740): https://linux.kernelci.org/b=
uild/cip/branch/linux-4.4.y-cip/kernel/v4.4.302-cip70-98-g7f7838c92740/
> Summary of last build (commit 69445bc0d420): https://linux.kernelci.org/b=
uild/cip/branch/linux-4.4.y-cip/kernel/v4.4.302-cip70-236-g69445bc0d4209/
>=20
> However, looking at the complete history for this branch: https://linux.k=
ernelci.org/job/cip/branch/linux-4.4.y-cip/,
> It looks like we've seen similar warnings since after the cip69 release.
>=20
> Whether these warnings are something to be fixed or not I'll leave
> > in your hands.

These warnings should be fixed by:

commit 69445bc0d4209b0634d1f43657fd58f708cadf81 (HEAD -> linux-4.4.y-cip)
Merge: 7f7838c92740f 0d18c1b035a22

    Merge branch 'linux-4.4.y-st' into linux-4.4.y-cip
   =20
    Bring the tree up-to-date with 4.9.328, with exception described in
    KNOWN-BUGS file.

=2E..which should be become -cip71 "soon". Aha, and it seems like I have
forgot to do the push. Did that now, hopefully things should get
clear.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7G/k/y6MZlYSaUht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4Cc1QAKCRAw5/Bqldv6
8v98AKC1npEvFSW368IPa2SkvpRaWWc9tACgtwfNsMjxd2K9tXuvKCnu6r1j68s=
=8UKb
-----END PGP SIGNATURE-----

--7G/k/y6MZlYSaUht--

