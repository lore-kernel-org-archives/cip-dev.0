Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E68E7C712
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 11:46:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14737.1770119165501793313
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Feb 2026 03:46:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BFOG/uak;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66A4010944B;
	Tue,  3 Feb 2026 12:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770119163;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HrU5k9qdgP5mMTfWTFJpYLHaIxpRqoI3errSpw2m/E8=;
	b=BFOG/uakGatWfNyEtzHOAtTjXeU6rQ2WjK/+FWV1/OKHbt7uQqDnUsZKL5i7kRVZxZvNCa
	YrpQSDqV8ppimmoDuffySxA32h10DGU4ckOpMeC1qfW3d/vsL07TNSe1+0cNhe2RSi0wQd
	q6mAi7g7EpsaNPrCSwjZgW2m3VM7/wj3pvonuySvu9ULC/0iNvpB2QddvUOa21Tt7tPfjC
	vlHr1C8Iy57DPuEUudKmyDpfYde71IzfA4yIMk678bMmhfC9qsNs9xqylH6A8U+nKsVX1B
	9ZXK6wAugpLRVDV98s3HqxVkI+x17doGbS8noUfrcdpMmuHoJAYx3f/nEf6e9A==
Date: Tue, 3 Feb 2026 12:45:59 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st72, 4.4-cip107
Message-ID: <aYHf9zpDUEwBm1fS@duo.ucw.cz>
References: <1873813255.141036.1770094885595@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6vVGvJMFsg6kYWkQ"
Content-Disposition: inline
In-Reply-To: <1873813255.141036.1770094885595@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 11:46:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21824


--6vVGvJMFsg6kYWkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a > 9fdef2a6b53b3 jbd2: fix the inconsistency between checksum and data in =
memory for journal sb
a > 7d0ef9b50d5d3 f2fs: fix return value of f2fs_recover_fsync_data()
a > bb471f70de075 ip6_gre: make ip6gre_header() robust
a just a WARN addition > 6eaf989ce1c09 KVM: x86: WARN if hrtimer callback f=
or periodic APIC timer fires with period=3D0
a > 1a0a3e2a74b85 f2fs: invalidate dentry cache on failed whiteout creation
a > cdfaae22c3796 usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_mal=
loc()
>

Patches look good to me, thank you.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--6vVGvJMFsg6kYWkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYHf9wAKCRAw5/Bqldv6
8o7UAJoDUqnvLq3QLkdJq2Vmymx0+12kQQCgwXFy2k5Lcv92/0lcI70oYjYwsho=
=X2fj
-----END PGP SIGNATURE-----

--6vVGvJMFsg6kYWkQ--

