Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FFC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 12:49:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.6615.1648730954521498649
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 05:49:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 863A11C0B8B; Thu, 31 Mar 2022 14:49:10 +0200 (CEST)
Date: Thu, 31 Mar 2022 14:49:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Message-ID: <20220331124910.GA16062@duo.ucw.cz>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331092808.GA20092@amd>
 <OSZPR01MB701991610B34316CAB5B2D90AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB701991610B34316CAB5B2D90AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 12:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7902


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> > > enables this interfaces on Renesas RZ/G2L SMARC EVK.
> > >
> > > All the patches have been cherry picked from v5.17 release.
> >=20
> > I tried to apply the patches on top of 5.10.106-cip4, and could not. Can
> > you double check series applies properly?
> >=20
> I did cross check my base branch and it is 5.10.106-cip4. For some weird =
reason patches 01 to 09 are missing in patchwork. (I can see the patches ar=
e in my inbox though and pretty sure you too have it as have received feedb=
ack on patch 04 and 09).
>=20
> Do you want me to resend the series hoping patches appear on
> patchwork?

I took patches from emails list, not from patchwork, so that should
not be it.

Let me try again:

git log
commit 8bb6e30b765989a3c0924158316d689e16317cd1 (HEAD -> linux-5.10.y-cip, =
tag: v5.10.106-cip4, origin/l\
inux-5.10.y-cip)
Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date:   Tue Mar 29 08:32:48 2022 +0900

    CIP: Bump version suffix to -cip4 after merge from stable
pavel@duo:~/cip/10$ ./git-am /tmp/delme.zz

pavel@duo:~/cip/10$ ./git-am /tmp/delme.zt
Applying: mmc: renesas_sdhi: probe into TMIO after SCC parameters have been=
 setup
Applying: mmc: renesas_sdhi: populate SCC pointer at the proper place
Applying: mmc: renesas_sdhi: simplify reset routine a little
error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:569
error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply
Patch failed at 0003 mmc: renesas_sdhi: simplify reset routine a little
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
pavel@duo:~/cip/10$ git am --skip
Applying: mmc: renesas_sdhi: clear TAPEN when resetting, too
error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:558
error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply
Patch failed at 0004 mmc: renesas_sdhi: clear TAPEN when resetting, too
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
pavel@duo:~/cip/10$
pavel@duo:~/cip/10$ git am --skip
Applying: mmc: renesas_sdhi: merge the SCC reset functions
Applying: mmc: renesas_sdhi: remove superfluous SCLKEN
error: patch failed: drivers/mmc/host/renesas_sdhi_core.c:556
error: drivers/mmc/host/renesas_sdhi_core.c: patch does not apply
Patch failed at 0006 mmc: renesas_sdhi: remove superfluous SCLKEN
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
pavel@duo:~/cip/10$

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkWjRgAKCRAw5/Bqldv6
8jTjAKCcnymYOo3+KZVlx9jl/Cv9d1PF7gCfZM9FSWLkks/85JoUitmfPEHxa9Y=
=lTC3
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

