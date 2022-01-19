Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2FC433F5
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 14:12:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.6724.1642601535325819979
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 06:12:16 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ACD4D1C0B80; Wed, 19 Jan 2022 15:12:10 +0100 (CET)
Date: Wed, 19 Jan 2022 15:12:10 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: 4.4.X-stable and 4.4.X-rt maintainance ends in less than two weeks
Message-ID: <20220119141210.GA2310@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jan 2022 14:12:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7467


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It looks like stable 4.4.X maintainence ends real soon now:
https://www.kernel.org/category/releases.html . I talked to Greg and
it seems like plan is to end it at the beggining of month, rather than
end.

That means we'll be on our own maintaining -cip and -cip-rt versions.

To review our 4.4 branch:

git log --pretty=3Doneline linux-4.4.y-cip-rebase

We have 757 patches on top of 4.4.216, and there are some 14000
patches between 4.4 and 4.4.216. Going forward, most new patches will
come from upstream.

We do some compile testing, but we only run run-time tests on two
targets:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/448669210
=2E

Given that most of work we'll be doing will be maintaining -stable
patches, anyway, I believe it would make sense to step up as official
maintainers of 4.4.X-stable and 4.4.X-rt series. We'll need to do the
work, anyway, keeping -stable and -cip split will not result in much
overhead for us, and this way we'll get a lot of visibility for the
project, and hopefully a lot of additional testing.

Any thoughts?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYegcOgAKCRAw5/Bqldv6
8kuyAJ9MCgQd4MDWReF1MRgRztx4N7OAygCguhpCs1dXrEeOrkTwQG5AJD2mvi0=
=biq9
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

