Return-Path: <SRS0=ZvJA=EQ=lists.cip-project.org=bounce+64572+5786+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB2C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 10:17:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA3820639
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="au/kL7UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA3820639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5786+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CxMpYY4521723x4XQHhgPRQn; Tue, 10 Nov 2020 02:17:25 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.25675.1605003444642249539
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2020 02:17:25 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 79CC81C0B8B; Tue, 10 Nov 2020 11:17:19 +0100 (CET)
Date: Tue, 10 Nov 2020 11:17:18 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-members@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: [cip-dev] Report from Real Time meeting
Message-ID: <20201110101718.GA5938@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Xl1z0evPwqS8l9H1GT7lfSUax4520388AA=
Content-Type: multipart/mixed; boundary="Dt2ksbSD7CwGgui5zn39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605003445;
 bh=I+MkHHclgUTfmBk9SmeFH7WySL0wA0HrPtiPxSYSUZ8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=au/kL7UY0ziljMltaA+1QqpRvlbeGZRnEK7QqVTPQ6G1N3ZEcSnJpRgMAcIKidjg8Qm
 XB5ISZvHtjSt2qKmv/aaXdRCcYIoviZlq4vXDoqZkeynz0ke3/rFy0Q4anoDSWSqHsd4q
 9aNdjJ/KBgH/sddVo7zHVDyQ3OthDNLwXgA=

--Dt2ksbSD7CwGgui5zn39
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There was (virtual) Real Time meeting yesterday.

They are switching from "gold"/"silver" etc levels to "premier" 50K /
"general" 25K a year; staying with the old agreement is okay.

-stable-rt will likely be published two days before final release, and
it would be good to test them on our Lave infrastructure when they
are.

v4.4-rt maintainence will likely end in Feb 2022, v4.19-rt is
scheduled to end in Dec 2024. We may need to start mainaining it
ourselves or step up as a maintainers in that timeframe.

It is now clear that Real Time support will not be merged into v5.10.

Useful Real Time support for arm32 and arm64 _may_ make it to
v5.11. If it does not make it, printk() support will likely be
responsible.

If you don't use printk() in production, and merging Real Time support
to v5.11 would be useful to you, let me know; it is possible we can
push in that direction. It would mean additional additional patches
for v5.11 during development, but final product could run on
unmodified v5.11.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+qaK4ACgkQMOfwapXb+vLDiACdHlcDvfpPyaQvV0M+d8METfOr
nc0AoJQ9gbB2kwcNWnaafCpGWADlgYGa
=Zu8D
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--Dt2ksbSD7CwGgui5zn39
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5786): https://lists.cip-project.org/g/cip-dev/message=
/5786
Mute This Topic: https://lists.cip-project.org/mt/78156598/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dt2ksbSD7CwGgui5zn39--
