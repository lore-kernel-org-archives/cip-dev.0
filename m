Return-Path: <SRS0=Z+nd=DK=lists.cip-project.org=bounce+64572+5493+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5191C41604
	for <cip-dev@archiver.kernel.org>; Sat,  3 Oct 2020 21:49:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15F1206C3
	for <cip-dev@archiver.kernel.org>; Sat,  3 Oct 2020 21:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DH78tkfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15F1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5493+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 83QTYY4521723x3qwEt9pwdh; Sat, 03 Oct 2020 14:49:51 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4551.1601761785464115886
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Oct 2020 14:49:46 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3F5771C0B7D; Sat,  3 Oct 2020 23:49:40 +0200 (CEST)
Date: Sat, 3 Oct 2020 23:49:39 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] arm64/renesas test failing for v4.19.148-cip35-rt15 (-rt64)
Message-ID: <20201003214939.GA3733@duo.ucw.cz>
References: <20201003151745.GA1399@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201003151745.GA1399@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cAhVVUJLuIzwS3I3uhaJ2Z79x4520388AA=
Content-Type: multipart/mixed; boundary="doMlC5Qk7UyUXe1TEcWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601761791;
 bh=sMPgv+9iDS2Cufo/ICO1ywqS3NzxbWWz5oCmrIJf8bo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DH78tkfw1di6nqfcRctHfiaS0yCb2chNYwD7TJtp5LDV/vYXo2q1OY89LgI+hMdQ4rN
 cnunLnGuOgsRAiaEviRFUygt5xe6RaGaL19lWcKAmHHwg7+pBXn6is0Ye9XLyKHI+ctv0
 9eo5s13enov5RydKGJOcTq87vbfyT7MkoJ0=

--doMlC5Qk7UyUXe1TEcWT
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I got test failure when I submitted -rt branch for testing.
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/197703780
>=20
> This seems to be "real" failure:

I re-ran the test with same sources, and failure is still there.

I tried rt+v4.19.147-cip35 -- e8bcfc1349886ef3cf6625a0bc9cd25ddf80112c
-- fails, too.

Let me try commit 1d9c4c7e291d5f49ab07402ef739f98fac6e7adb (tag:
v4.19.144-cip34). ... that one works.

To be sure, let's try older rt commit:
f15040b9d853b9cfbcdd4707d9be2593b42b000b ( v4.19.142-cip33-rt14 /
-rt63). That one works ok.

-rt63-rebase and -rt64-rebase trees have same commits on top.. in
fact, they seem to have same commits. That probably means nothing
changed in -rt. But it looks like there's commit in -stable, touching
relevant area.

commit fb3a780e7a76cf8efb055f8322ec039923cee41f
Author: Yuusuke Ashizuka <ashiduka@fujitsu.com>
Date:   Thu Aug 20 18:43:07 2020 +0900

    ravb: Fixed to be able to unload modules

Let me investigate some more.

> With no network, it is easy to understand that tests would fail.
>=20
> x86_siemens, OTOH, seems to be infrastructure error
> (bootloader-interrupt timed out after 599 seconds).

This one went away when I resubmitted same kernel... so lets ignore it.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3jx8wAKCRAw5/Bqldv6
8hAhAKCCAbFLDSvIif9q0miZpodA72CXVgCglxBj2bf1EbXKTAyKRaOTquHiMHA=
=yeJL
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--doMlC5Qk7UyUXe1TEcWT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5493): https://lists.cip-project.org/g/cip-dev/message=
/5493
Mute This Topic: https://lists.cip-project.org/mt/77282618/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--doMlC5Qk7UyUXe1TEcWT--
