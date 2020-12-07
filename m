Return-Path: <SRS0=GRCB=FL=lists.cip-project.org=bounce+64572+5946+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301FC4361B
	for <cip-dev@archiver.kernel.org>; Mon,  7 Dec 2020 08:35:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342A022C7E
	for <cip-dev@archiver.kernel.org>; Mon,  7 Dec 2020 08:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342A022C7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5946+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rQcxYY4521723xDvWHHYzhRe; Mon, 07 Dec 2020 00:35:05 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.3566.1607330103898196218
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Dec 2020 00:35:04 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 652081C0B93; Mon,  7 Dec 2020 09:35:00 +0100 (CET)
Date: Mon, 7 Dec 2020 09:34:59 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] A lot of compiles failing
Message-ID: <20201207083459.GA26656@amd>
References: <20201123190940.GA13627@duo.ucw.cz>
 <OSAPR01MB23853004B735A607C4BEE0C5B7F40@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB23853004B735A607C4BEE0C5B7F40@OSAPR01MB2385.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tIoO8NEHb10XkTkrnUAcKXV2x4520388AA=
Content-Type: multipart/mixed; boundary="4zDwkRmEGFv6Nl27VTfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607330105;
 bh=Sv01md4V1NON5dVP1QHza9u8hgA6q3tgHxOC8KomuOw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ns5kIf4dBuqU7XwuUdgYaGDJggkY5prNk5Dlx2H54XUmt+FvU1/yruEiVJfnxkvI2NE
 BQmfPvElfTKbiowYxNNU9E3XGeVp8l6O5ujc8xfYRi6wMq4XxRJArSvBV07n3bBwFtH3C
 vKKXazooWhkM3327PKyZ2sEp9jPGnA63wpU=

--4zDwkRmEGFv6Nl27VTfH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Pavel Machek <pavel@denx.de>
> > Sent: 23 November 2020 19:10
> >
> > *** gpg4o | The signature of this email could not be verified because t=
he
> > following public key is missing. Click here to search and import the key
> > 30E7F06A95DBFAF2 ***
> >
> > Hi!
> >
> > This is going on for a few days now, but today it seems worse than
> > usual:
>=20
> For me things seems to have stabilised now.
> Are you still seeing a lot of issues?

I still see them:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
25881953

2 builds failed, for example:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/893211=
490

225
Cloning into '.'...
00:32
226$ git clone --depth 10 --branch $CI_COMMIT_REF_NAME
https://gitlab.com/cip-project/cip-testing/linux-stable-rc.git .
227error: RPC failed; HTTP 500 curl 22 The requested URL returned
error: 500 Server Error
228fatal: The remote end hung up unexpectedly

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/N6TMACgkQMOfwapXb+vK+EQCghQAAehmqZ7KE7xACghvfOkWe
BkUAni4P7v9oXeD5zTa/eJUg9Xljr5Jy
=RlEv
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--4zDwkRmEGFv6Nl27VTfH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5946): https://lists.cip-project.org/g/cip-dev/message=
/5946
Mute This Topic: https://lists.cip-project.org/mt/78460850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4zDwkRmEGFv6Nl27VTfH--
