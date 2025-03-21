Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBEC35FF3
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 08:09:58 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.16160.1742544591886814243
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 01:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Rk0qNnOa;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53A35101E9152;
	Fri, 21 Mar 2025 09:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742544589; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iQZmCLi1ky6hpGSmpXYhj2fTYDxqC62NzbjNwSz6uWg=;
	b=Rk0qNnOacQXRXN27vb/gzWPMUmcTq487zcsc+u2NIwbQH9iaWDToKmAHQvTliRHBcvbjr3
	Zp8PAbWvqfD3tifpHOLgsDY2Wx3aldThZpdLTaIengX/G+wz2kZraQH/rcNEallSRUrUtq
	fnrcXhzI6cSUnw03naRvV2iwGBlOYDUUmQgED5ZapD8vujSutthxSjGmmrUPnA7Nqhx/+d
	jClfmDp0iCQm7kIaEXYw72rn0e60JqB5GfXxpyt62ZJNUjdR5fTG/TPNeEkTWeXKdTVSsF
	uvDgZswdgsUchy5Kn7B79n22uX8VlCcPLL+qzsyFpYtdyMIRf1cOHWKPfpkl/A==
Date: Fri, 21 Mar 2025 09:09:45 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Starting 6.12-cip branch
Message-ID: <Z90eyRZSD8WZVDjB@duo.ucw.cz>
References: <Z9v5aLZhun8zwFk2@duo.ucw.cz>
 <OS3PR01MB5896A5F20C13F5E62925E2DAB7D82@OS3PR01MB5896.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zStBNpaspA6tk50y"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB5896A5F20C13F5E62925E2DAB7D82@OS3PR01MB5896.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 08:09:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18304


--zStBNpaspA6tk50y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: 20 March 2025 11:18
> >=20
> > Hi!
> >=20
> > So... I'm starting 6.12-cip branch. It is based on 6.12.19 and I
> > already pushed tree to kernel.org:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/log/?h=3Dlinux-6.12.y-cip
> >=20
> > Next steps should be starting testing the branch. Chris, could you
> > suggest appropriate gitlab-ci file? [Or even better, could we test the
> > branch without the gitlab-ci file, as we are doing for stable trees?]
>=20
> This should _mostly_ work for now as we don't have a localversion file ye=
t.
> Once we have our usual CIP localversion file we'll need to have the relev=
ant directory added to cip-kernel-configs.
>

It mostly works. Except risc-v :-).

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1727265523

Do we need to add risc-v config somewhere?

Thanks and best regards,
									Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zStBNpaspA6tk50y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ90eyQAKCRAw5/Bqldv6
8osBAKCFzNABvXjw4qb6X/d245nLIFTWigCfTu4KV30jKSgM/TJ1GZZ9fa7lqoc=
=QTj7
-----END PGP SIGNATURE-----

--zStBNpaspA6tk50y--

