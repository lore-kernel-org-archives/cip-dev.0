Return-Path: <SRS0=Foia=5W=lists.cip-project.org=bounce+64572+4555+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE33EC2BA1A
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:02:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653C120801
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DmOioVoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653C120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4555+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lWDVYY4521723xT3zgea7QIr; Mon, 06 Apr 2020 15:02:51 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.618.1586209929111513645
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 14:52:09 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A1B881C4818; Mon,  6 Apr 2020 23:52:05 +0200 (CEST)
Date: Mon, 6 Apr 2020 23:52:05 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>,
	Kento Yoshida <kento.yoshida.wz@renesas.com>,
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Python 3.x vs 2.7
Message-ID: <20200406215205.GA14162@amd.ucw.cz>
References: <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <20200403214708.GA32080@duo.ucw.cz>
 <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
MIME-Version: 1.0
In-Reply-To: <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2UwxIpG6gge5IAYhSO2mMJdjx4520388AA=
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586210571;
 bh=xmiwkJ1ztWX8Wb4eY8fvj1znQX8qh45pVvRGM0EDB5I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DmOioVoBeELE5roUVClu2aZW1R6+FnFj6e2KgvpEUaQSzT6XGcdcEatQFnG18sppw1P
 /Sp2rQSE2QFC69JfbuwkzaZfierZMkJSiZkvHWEY37v85mOPHnGfUJc96uFM9bEZDOnDp
 CfffepliiAZ9VgkMKijHglsMjCmaJl2UBcg=

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-04-06 12:15:16, Jan Kiszka wrote:
> On 03.04.20 23:47, Pavel Machek wrote:
> > Hi!
> >=20
> > >=20
> > > FYI, unfortunately we couldn't find the alternative package for syst=
em backup. The duplicity is the best package for us from the license and nu=
m of dependencies point of view.
> > > See the following.
> > >=20
> >=20
> > > <duplicity>
> > > Encryption: Yes
> > > Schedule backup: No
> > > Incremental backup: Yes
> > > License: GPL v2
> > > Dependencies count (aprox): 80
> > > Reference: http://duplicity.nongnu.org/features.ht
> >=20
> > I'm not sure what your exact requirements are, but have you considered
> > "tar"? It should be possible to pipe its output to aespipe (and
> > possibly other tools) to get encryption, and it should be able to do
> > incremental backups...
>=20
> I suppose there is that concern about GPLv3 again (as with broadly used
> rsync) - which is generally overrated. There exists legal views that alr=
eady
> GPLv2 requires to keep such licensed components replaceable on the targe=
t.
> What then effectively remains with v3 is its, well, wording complexity.

Does "tar" match the requirements?

And I agree that best option would be to accept GPLv3.

If that's out of question, I'm pretty sure we can get GPLv2 tar
implementation somewhere. busybox has implementation, and I'm pretty
sure there's GPLv2 fork of busybox. Old version of tar should be
GPLv2. Still better than porting duplicity to different python
version...

Best regards,
	=09	=09	=09	=09Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4555): https://lists.cip-project.org/g/cip-dev/message=
/4555
Mute This Topic: https://lists.cip-project.org/mt/72826088/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoukhQAKCRAw5/Bqldv6
8lz9AJ4qSuIrbwBf4pLJYFu84YL4Kus50QCcDxkvxrl0gPwP+Z8dXa/TipRW8gk=
=Chuh
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
