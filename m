Return-Path: <SRS0=73f0=52=lists.cip-project.org=bounce+64572+4576+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6554C2D0EC
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 19:45:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D0E20801
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 19:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="itgc1TIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D0E20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4576+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hVGaYY4521723xgjflEzyKnQ; Fri, 10 Apr 2020 12:45:06 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2681.1586542689954540825
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2020 11:18:10 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED2A61C5DD7; Fri, 10 Apr 2020 20:18:06 +0200 (CEST)
Date: Fri, 10 Apr 2020 20:18:06 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.215-cip42-rt28
Message-ID: <20200410181806.GA15301@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: b1u4BtCzRiw79psXNXzGFWMPx4520388AA=
Content-Type: multipart/mixed; boundary="mlJlWMaGVg8dBcLZvAaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586547906;
 bh=jgsrrZMrIf3VJlO1c8mUSjp1SZnBVBMqvNZrELR9CV8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=itgc1TIC2eAumsc1q+8HJd95vi/xSpKRoOS8KPWKf64xk1RgHg2A3pu11W+Cx4csHBo
 Mpz/l9YISg7jGFvyLG4Yxq/SzAdL3E6gkw1oM8DPeTmdSk8tqjTraQJ6//DZeukQCfoNK
 d196toRCAhfY0Hhgv27caMVwpnaYa8fO2Rk=

--mlJlWMaGVg8dBcLZvAaF
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.4.215-cip42-rt28 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Problem that broke boot on 4.19-rt with de0-nano was present in
v4.4-rt, according to my code inspection. de0-nano is not supported
platform for 4.4-rt and I could not easily test the bug or the fix,
but I believe fixing it was safer choice. Problem would not affect
configuration with realtime enabled.

Best regards,
                                                                Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXpC4XgAKCRAw5/Bqldv6
8tZ2AJ40IhwW7FkKFW0b26ANJLuR+ksFawCfTOzUyd/oGPGwGn0vBIWAQ7/ndQU=
=Xln1
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--mlJlWMaGVg8dBcLZvAaF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4576): https://lists.cip-project.org/g/cip-dev/message=
/4576
Mute This Topic: https://lists.cip-project.org/mt/72929820/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mlJlWMaGVg8dBcLZvAaF--
