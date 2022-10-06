Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DEAC433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 11:50:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4779.1665057036480721383
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 04:50:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0B7F71C0017; Thu,  6 Oct 2022 13:50:34 +0200 (CEST)
Date: Thu, 6 Oct 2022 13:50:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Michael Adler <michael.adler@siemens.com>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221006115033.GB21855@duo.ucw.cz>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20221004075301.etgur4dyb5dtrcct@backstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 11:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9662


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > @Adler, Michael, could you take a look when you get a chance? Could t=
his be
> > > caused by the recent upgrade?
>=20
> not sure. For now, I have downgraded the Gitlab runner to the previous ve=
rsion. Please try again and let me know how
> that works out.

Still there, I'd say:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3123103311


94upload: output/Image_renesas_defconfig_5.10.145-cip17-rt6_0d804ef4a/arm64=
/renesas_defconfig/dtb/rcar_du_of_lvds_r8a7796.dtb to s3://download2.cip-pr=
oject.org/cip-testing/linux-cip/Image_renesas_defconfig_5.10.145-cip17-rt6_=
0d804ef4a/arm64/renesas_defconfig/dtb/rcar_du_of_lvds_r8a7796.dtb
95Completed 10.3 MiB/~22.2 MiB (2.0 MiB/s) with ~1 file(s) remaining (calcu=
lating...) =20
96Completed 15.2 MiB/~22.2 MiB (2.7 MiB/s) with ~1 file(s) remaining (calcu=
lating...) =20
97Completed 22.2 MiB/~22.2 MiB (3.4 MiB/s) with ~1 file(s) remaining (calcu=
lating...) =20
98upload: output/Image_renesas_defconfig_5.10.145-cip17-rt6_0d804ef4a/arm64=
/renesas_defconfig/kernel/Image to s3://download2.cip-project.org/cip-testi=
ng/linux-cip/Image_renesas_defconfig_5.10.145-cip17-rt6_0d804ef4a/arm64/ren=
esas_defconfig/kernel/Image
99Completed 22.2 MiB/~22.2 MiB (3.4 MiB/s) with ~0 file(s) remaining (calcu=
lating...)
101
Uploading artifacts for failed job
00:00
103
Cleaning up project directory and file based variables
00:00
105ERROR: Job failed (system failure): pods
"runner-kmcmucmn-project-2678032-concurrent-4jcrtw" not found

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/657708852

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz7BCQAKCRAw5/Bqldv6
8ns3AKCAAWUxx7axdxBOJFG2xVf+E8m9eACcD7WCSVYVO9s7iIFQhGO+dvK4sGY=
=DmTo
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

