Return-Path: <SRS0=Bnfg=A4=lists.cip-project.org=bounce+64572+4934+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDC433E5
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D092074B
	for <cip-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hWjjZ7Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D092074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4934+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lBU0YY4521723xh6CBkH3sKG; Fri, 17 Jul 2020 01:04:15 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7145.1594973052609123838
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2020 01:04:13 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 313821C0BEB; Fri, 17 Jul 2020 10:04:07 +0200 (CEST)
Date: Fri, 17 Jul 2020 10:04:06 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-members@lists.cip-project.org, cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev] Notes from realtime meeting, questions for companies using realtime
Message-ID: <20200717080406.GA7886@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rmibLrWEUBCDsz3kLqVCeWm4x4520388AA=
Content-Type: multipart/mixed; boundary="GrfhA4hpye4ou7C98GIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594973055;
 bh=uuyMCk/WMk/mZAcd6isJAlNUKMDqRg42E9iIwV5+6fI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hWjjZ7Gr/M+JGSuQzXDYhesFtxixi2nRcyI2Ce9Ok1qOJAZzESF++ut9hzl0e8lOWhI
 B7LVOnzEOpPdJbzcaX51ccNGm8SX+ILexPFHItRzj3uCQR3iFNK+I/CrJhuNnoOEivbzR
 3C479WZTFNmMLidQItEYlD1+xVTVsJ6B/i4=

--GrfhA4hpye4ou7C98GIV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This week I attended virtual RT meeting, and have couple of notes, and
couple of questions.

Intel was biggest sponsor of RT, and they are decreasing their
funding. So RT project is looking for ... more funding. If we can
provide funding, or know someone who could, there might be good time
to step in.

They still believe most of RT patch can be merged in 5.10, which would
be around end of 2020. But there was interesting question "which
architecture(s) would be present in initial merge". And it looks like
x86 is the initial target (which kind of makes sense given that Intel
is/was the biggest sponsor, and it is "main" Linux architecture; otoh
I'd say x86 is not exactly suitable for realtime/safety related
tasks...). ARM32 and ARM64 is on the radar.

It would be interesting to know:

## Who is using RT in production? On what architectures?

## Is someone planning RT use? If so, on what architectures?

There will be RT microconference (on Plumbers, IIRC). RT project
believes it would be cool if someone from industry stepped up and
explained how they use RT. (It would be interesting for me, too, so it
sounds like a good idea). Is someone willing to do that?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8RW3YACgkQMOfwapXb+vIElQCfQOYUhoX4nDdcNKsZdHeTXlGy
q0YAmgKvh83jNQWEk3S43gX8lLiIBJ0l
=TqnJ
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--GrfhA4hpye4ou7C98GIV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4934): https://lists.cip-project.org/g/cip-dev/message=
/4934
Mute This Topic: https://lists.cip-project.org/mt/75607964/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GrfhA4hpye4ou7C98GIV--
