Return-Path: <SRS0=Pt1g=CP=lists.cip-project.org=bounce+64572+5417+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75749C43461
	for <cip-dev@archiver.kernel.org>; Sun,  6 Sep 2020 21:18:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17ABD207BC
	for <cip-dev@archiver.kernel.org>; Sun,  6 Sep 2020 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HWsxc9i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ABD207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5417+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9ek4YY4521723xDZDwOx5qRV; Sun, 06 Sep 2020 14:18:10 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.28447.1599427088555691482
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Sep 2020 14:18:09 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1E25E1C0B7C; Sun,  6 Sep 2020 23:18:04 +0200 (CEST)
Date: Sun, 6 Sep 2020 23:18:03 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.142-cip33-rt14
Message-ID: <20200906211803.GA13616@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5x6ch7ngAlEf7EleHw4QrHESx4520388AA=
Content-Type: multipart/mixed; boundary="ls4mZfznnBOqveCSWT8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599427090;
 bh=Zo0VCU8hOkg++EqtWOuF3hoA3MRUp19DCcOwyZH0c9I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HWsxc9i76wkenj7m3TWocS71JsC8aHx6YgmBIPCCBKU1pY6zr5TlLLv/VBNM1HuPFRj
 z7lS0L1FNRzSKJZse8Da/IQZDbdyXge08vRVGxmjR6Nryn86weKTKukwett/wAqU1allx
 yE1yvecZDSVDemvZIcZ9DT8kQCWRpx2szII=

--ls4mZfznnBOqveCSWT8A
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.142-cip33-rt14 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1VSCwAKCRAw5/Bqldv6
8l0fAKCwyZsdaUi9sFPC6FboAIWzxVM6rACePgRXg0j2KGy5xLdpTEMBiXOfE2I=
=HzWn
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--ls4mZfznnBOqveCSWT8A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5417): https://lists.cip-project.org/g/cip-dev/message=
/5417
Mute This Topic: https://lists.cip-project.org/mt/76674951/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ls4mZfznnBOqveCSWT8A--
