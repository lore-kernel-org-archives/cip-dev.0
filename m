Return-Path: <SRS0=JGKT=EG=lists.cip-project.org=bounce+64572+5700+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B1C388F7
	for <cip-dev@archiver.kernel.org>; Sat, 31 Oct 2020 08:47:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A264206B6
	for <cip-dev@archiver.kernel.org>; Sat, 31 Oct 2020 08:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dAovU7+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A264206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5700+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yXD0YY4521723xb0BWpDAKJk; Sat, 31 Oct 2020 01:47:01 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7714.1604134020706831542
 for <cip-dev@lists.cip-project.org>;
 Sat, 31 Oct 2020 01:47:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A4DD81C0B98; Sat, 31 Oct 2020 09:46:55 +0100 (CET)
Date: Sat, 31 Oct 2020 09:46:55 +0100
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.152-cip37-rt16
Message-ID: <20201031084655.GA28414@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vbycGqDBZRdr1cylaVX8jfzOx4520388AA=
Content-Type: multipart/mixed; boundary="zooki5Kn56wPIzF1zrob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604134021;
 bh=eQz4R7WmJ6Z/znFQSKpkUJe/aoRiyzog/uJb4CEJwEY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dAovU7+qF8oC9i2Ym167strvrXEAI6sXFaYnSzTFX/eVXYoMDbNZRTplSRMekjXazq3
 0gw2b93TF9IOl/5YcamoGN5kNXTpGOO76ebVvCIpKW3h4VCeSMiGOMcWhybramPeVXrs2
 7ghyYWpJM81RC+fdn0YpmZ9k8Gdsz3ex8ac=

--zooki5Kn56wPIzF1zrob
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

I'm doing release at unusual time because the last one had problems
booting on Renesas boards. This one should work ok.

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


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX50kfwAKCRAw5/Bqldv6
8r1HAKDEjnIn99bmKlyVGsI/eo2VT+6cjACgnvhDNhmJbtayqxpnzTR1rZ5Vi2I=
=LUaY
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--zooki5Kn56wPIzF1zrob
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5700): https://lists.cip-project.org/g/cip-dev/message=
/5700
Mute This Topic: https://lists.cip-project.org/mt/77931041/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zooki5Kn56wPIzF1zrob--
