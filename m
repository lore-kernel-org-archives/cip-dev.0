Return-Path: <SRS0=t4/h=A2=lists.cip-project.org=bounce+64572+4928+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67393C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:19 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9061A20672
	for <cip-dev@archiver.kernel.org>; Wed, 15 Jul 2020 07:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bheJ07gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9061A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4928+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XBWRYY4521723xEidZKVTDrr; Wed, 15 Jul 2020 00:10:18 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1852.1594797016098235819
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2020 00:10:16 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 810521C0BD5; Wed, 15 Jul 2020 09:10:10 +0200 (CEST)
Date: Wed, 15 Jul 2020 09:10:10 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.132-cip30-rt12
Message-ID: <20200715071010.GA10112@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zZNH4xKpckDjHzTFDbl7yStNx4520388AA=
Content-Type: multipart/mixed; boundary="GSfC2sDwU3cYL8Chh2VA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594797018;
 bh=aZPYfEU/Hk/IE6SR0WIA8iDhdFUlGy3kdEkJWvPFJpw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bheJ07gSCU+0tgRq0Dopf2lv2dWHGey9FkMDOqhCuHg+mE5mXwYCrYGaLApXTNW6e9V
 8VDAJkUCSYhfCECB1q3t5dMgvAHN51folYCz7fynG3DxRgL/dnkNMJ/wixZS9paW6uXI9
 du8QIND1uEpTs1AVueCMUMcRXLCFnXLS42o=

--GSfC2sDwU3cYL8Chh2VA
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.132-cip30-rt12 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXw6r0gAKCRAw5/Bqldv6
8nNcAJ9rInB11AXh2JcivaYinuxATJbaBQCgg6wSodeqZ8ZrNouoHdZudw8gM+E=
=BNUY
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--GSfC2sDwU3cYL8Chh2VA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4928): https://lists.cip-project.org/g/cip-dev/message=
/4928
Mute This Topic: https://lists.cip-project.org/mt/75515995/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GSfC2sDwU3cYL8Chh2VA--
