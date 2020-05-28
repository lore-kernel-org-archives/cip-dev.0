Return-Path: <SRS0=nxH/=7K=lists.cip-project.org=bounce+64572+4653+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6343FC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 12:43:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB9E20707
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 12:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F37TyD5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB9E20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4653+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3bSMYY4521723x3QeV28OUQd; Thu, 28 May 2020 05:43:12 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11035.1590669790886624539
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2020 05:43:11 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 31D1A1C0373; Thu, 28 May 2020 14:43:07 +0200 (CEST)
Date: Thu, 28 May 2020 14:43:06 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.124-cip27-rt11
Message-ID: <20200528124306.GA30770@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FOG5VEdJhZbWrGjlVStSg6VFx4520388AA=
Content-Type: multipart/mixed; boundary="r5jDsq3Jk0EKH235IXzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590669792;
 bh=feghq3UV8fFVHh6Qz4j+13JDloBlzyKBRNhHNSVKNto=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=F37TyD5gMPGvg+eL7c74C5cVZRWRxSG+OSo49aVmDtE/y/8A2PpLDswx1b15NEbxvJf
 v4KJ3khxvmQfoKJ7gLdcWUrJlCoIvFUiVesIZ3A6KZueCoD0q4ft53pMcbGQE2d+M7Op/
 3lKtP1licFEcmOB6oOOo0aVYe0O1VUPsoUk=

--r5jDsq3Jk0EKH235IXzq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.124-cip27-rt11 should be available at kernel.org.

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

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXs+x2gAKCRAw5/Bqldv6
8leaAJ9/9pHoA3s7OFlf3ApldKiHxCtYhQCfX3n2sPofEJaqxBqbtXvund8pwcc=
=GElp
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--r5jDsq3Jk0EKH235IXzq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4653): https://lists.cip-project.org/g/cip-dev/message=
/4653
Mute This Topic: https://lists.cip-project.org/mt/74520536/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--r5jDsq3Jk0EKH235IXzq--
