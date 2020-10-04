Return-Path: <SRS0=ek3c=DL=lists.cip-project.org=bounce+64572+5494+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F5C4363C
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 07:32:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F960206B5
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LeVdagjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F960206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5494+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PqNzYY4521723x7notaWHPfZ; Sun, 04 Oct 2020 00:32:09 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.6508.1601796728621474508
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Oct 2020 00:32:09 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A115E1C0B79; Sun,  4 Oct 2020 09:32:00 +0200 (CEST)
Date: Sun, 4 Oct 2020 09:31:59 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Pending problem in v4.19.148 -- arm64/renesas test failing for v4.19.148-cip35-rt15 (-rt64)
Message-ID: <20201004073158.GA15680@amd>
References: <20201003151745.GA1399@duo.ucw.cz>
 <20201003214939.GA3733@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201003214939.GA3733@duo.ucw.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WckHfTLRd2IyMTYG49mTRr62x4520388AA=
Content-Type: multipart/mixed; boundary="ZJLQQPzZPbLiOCcz50ef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601796729;
 bh=mAmHXAcYdFqj4rFbre7pYKJyWpi7BvH5+0/PJHAmUwI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LeVdagjdqSkHM0E+w56Q5DgCSp9Yff9fSEdkLt0eh9LZeUsiqPDVSZVawmRKzr+/R7s
 JJ29mosRqxcm+0Oh+6BOIN0V8VPInpAyrTjbLvRujGohUbaQDQBFZTlPzkrfhrb0/5HbJ
 f9V6wa7ryN9v2fHqS3Un66oWQU7CZeltHcw=

--ZJLQQPzZPbLiOCcz50ef
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit fb3a780e7a76cf8efb055f8322ec039923cee41f
> Author: Yuusuke Ashizuka <ashiduka@fujitsu.com>
> Date:   Thu Aug 20 18:43:07 2020 +0900
>=20
>     ravb: Fixed to be able to unload modules
>=20
> Let me investigate some more.

And this one seems to be responsible. I believe -cip will need to do
something with it when it tries to merge 4.19.148... I hit it early
because 4.19.147-rt is not available, so I merged 4.19.148-rt with
4.19.147-cip.

Fix can be as simple as reverting
fb3a780e7a76cf8efb055f8322ec039923cee41f... I'm pretty sure noone
unloads modules in production.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl95em4ACgkQMOfwapXb+vI3yACgtV9oNBnHEScJ8TqHOgWHadjm
AswAn2tBtpgvDjM1Xvm9XtMROH/gpzCX
=xX8b
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--ZJLQQPzZPbLiOCcz50ef
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5494): https://lists.cip-project.org/g/cip-dev/message=
/5494
Mute This Topic: https://lists.cip-project.org/mt/77294519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZJLQQPzZPbLiOCcz50ef--
