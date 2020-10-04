Return-Path: <SRS0=pYEN=DL=lists.cip-project.org=bounce+64572+5495+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94697C4363C
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 09:07:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C35D207EA
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 09:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="I2YOnxa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C35D207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5495+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VSWJYY4521723x6eFluCaKek; Sun, 04 Oct 2020 02:07:01 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7473.1601802419980548936
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Oct 2020 02:07:00 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 046511C0B77; Sun,  4 Oct 2020 11:06:55 +0200 (CEST)
Date: Sun, 4 Oct 2020 11:06:54 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Message-ID: <20201004090653.GA18130@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fJEBtg13qXLRtcIf8SuJo907x4520388AA=
Content-Type: multipart/mixed; boundary="RIQF0WjySHEroQGLuLLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601802421;
 bh=s1qXVojPKzm6MYHuLqBe0RTzGPNeN6d8RyGB59W3OH8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=I2YOnxa/eEOiz5CaSAJI7VNowggemH63EFYs5cIQ/Q7b6MBJvcg1tMa5pZMArFGABNP
 t1ZYL+JPaaDsIkPgiYiKCF2ulo0vO4Z8YqpNKYyxqA1ZTmUTia5N1rOpQ6KSu5mvpAeVi
 mC2yxuHjJhwemb0iVhreZero3Nm6AlBVGus=

--RIQF0WjySHEroQGLuLLt
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

This patch merges 4.19.148-stable into -cip-rt (because that's what
recent -rt is based on, and older -rt tree is too old). Unfortunately,
that brings regression with ethernet on Renesas Arm64 targets, which
will prevent boot, and fail tests etc.

Kernel that should work ok on Renesas Arm64 machines can be obtained
by reverting fb3a780e7a76cf8efb055f8322ec039923cee41f "ravb: Fixed to
be able to unload modules" on top of -cip-rt release.

Best regards,
                                                                Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl95kK0ACgkQMOfwapXb+vLcHwCfRt5GZeJXGBwMqJnlMtlauUQs
EmcAnAnlTjv4t8XiWp/GodkbfgFtBUxL
=dsU0
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--RIQF0WjySHEroQGLuLLt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5495): https://lists.cip-project.org/g/cip-dev/message=
/5495
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RIQF0WjySHEroQGLuLLt--
