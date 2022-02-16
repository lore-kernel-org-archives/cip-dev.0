Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4A2C433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 10:28:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10266.1645007285131741701
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 02:28:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4EEF71C0B78; Wed, 16 Feb 2022 11:27:59 +0100 (CET)
Date: Wed, 16 Feb 2022 11:27:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: kernelci results for my test branch
Message-ID: <20220216102758.GA313@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 10:28:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7615


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I pushed a test commit to ci/pavel/linux-test. This is not first
commit in the 14 days. Where can I get the results? I don't see them
at https://linux.kernelci.org/test/  .

pavel@amd:~/cip/4$ ./testhash 2fe7e363b1b121239e91f0d69511cf354db03386
https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test
Counting objects: 112, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (104/104), done.
Writing objects: 100% (112/112), 17.44 KiB | 0 bytes/s, done.
Total 112 (delta 95), reused 8 (delta 8)
remote: Resolving deltas: 100% (95/95), completed with 48 local
objects.
To gitlab.com:cip-project/cip-kernel/linux-cip.git
 + 94973269ae47d...2fe7e363b1b12
 2fe7e363b1b121239e91f0d69511cf354db03386 -> ci/pavel/linux-test
 (forced update)
 pavel@amd:~/cip/4$
=20
Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIM0a4ACgkQMOfwapXb+vJoywCfYTPvBHp3C4qzdtvbdyhsUohc
P68AnR2+vkVAGRIx+on8N6uUhfeaourj
=3h0t
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

