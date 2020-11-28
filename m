Return-Path: <SRS0=07C7=FC=lists.cip-project.org=bounce+64572+5888+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53629C63777
	for <cip-dev@archiver.kernel.org>; Sat, 28 Nov 2020 19:10:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6795020665
	for <cip-dev@archiver.kernel.org>; Sat, 28 Nov 2020 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qEqldUMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6795020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5888+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FaaNYY4521723x1kcMhZYxRg; Sat, 28 Nov 2020 11:10:47 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.36316.1606590646631136102
 for <cip-dev@lists.cip-project.org>;
 Sat, 28 Nov 2020 11:10:47 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7169B1C0BB7; Sat, 28 Nov 2020 20:10:42 +0100 (CET)
Date: Sat, 28 Nov 2020 20:10:42 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.160-cip39-rt17
Message-ID: <20201128191042.GA14941@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tryfYw0hOlp0LNbadXVW50adx4520388AA=
Content-Type: multipart/mixed; boundary="1qUejwnNIClxHaLUpiu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606590647;
 bh=cTOI+/M9CNi28SromUCfO3nYWj2ox1a3q81MAbsrY9Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qEqldUMeXqc0Ytecut1Pk2fozNm5Nk7XWkJvmLNOuvZa2aZjfL7hFJQDFok2WwnoXog
 0a0cFxzPV5Lh441zKTYnedUMo+YueOyAOAFFXiMOxWQNaYgTovC3Jod9gsE60GS7/5fLs
 FIGeSkhPNSsOy3AZKzxBq4416qoMVfc9Jno=

--1qUejwnNIClxHaLUpiu7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline

--X1bOJ3K7DJ5YkBrT
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

Best regards,
                                                                Pavel

--=20
http://www.livejournal.com/~pavelmachek

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8KgsgAKCRAw5/Bqldv6
8vcoAJ9GrhoQxhw5NAsCAauWLNUPdLuamwCeIzPWaSlKVrSBDc1fMrxW70897Yg=
=uOVx
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--1qUejwnNIClxHaLUpiu7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5888): https://lists.cip-project.org/g/cip-dev/message=
/5888
Mute This Topic: https://lists.cip-project.org/mt/78572223/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1qUejwnNIClxHaLUpiu7--
