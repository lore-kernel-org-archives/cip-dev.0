Return-Path: <SRS0=w+hq=E4=lists.cip-project.org=bounce+64572+5812+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C26C5519F
	for <cip-dev@archiver.kernel.org>; Sun, 22 Nov 2020 09:41:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3187020789
	for <cip-dev@archiver.kernel.org>; Sun, 22 Nov 2020 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ULLUFh2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3187020789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5812+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XevUYY4521723xjSD7FHGAHe; Sun, 22 Nov 2020 01:41:31 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.17695.1606038090148696539
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Nov 2020 01:41:30 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 49FC91C0B8D; Sun, 22 Nov 2020 10:41:25 +0100 (CET)
Date: Sun, 22 Nov 2020 10:41:24 +0100
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.244-cip51-rt32
Message-ID: <20201122094124.GA26770@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zGOvQ7oigOvMEhBVv8wyYYH3x4520388AA=
Content-Type: multipart/mixed; boundary="obrHqSF93lA0M9wofTJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606038091;
 bh=/93fy/dYeiByK9EtoMOV8cugbx2RBuMX1y0YTtmpMyg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ULLUFh2kLWnVuuvs6Kmpt+3V1nOJQ3mGjAoY7WKsK9yyIhGL1QkIwkx9+0shotW5bDO
 WhOcKJkfsM6m9z8f9U38aOLf1y/6oM29qX6I4tMhxf0QgmVMN85fYY6gsIxVhZ2/nay+e
 xhVJDuNcmRsd+XYWVYcejonzIbgwKODlGMA=

--obrHqSF93lA0M9wofTJP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org. This version is
based on v4.4.244-cip51-rt32 (-rt210).

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7oyRAAKCRAw5/Bqldv6
8mVLAKCdu1cYZpNDVMw9qpdFJg7PJOTQBwCgs0ps8nh/s60IEZiEO/vgBO/y60U=
=4pXD
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--obrHqSF93lA0M9wofTJP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5812): https://lists.cip-project.org/g/cip-dev/message=
/5812
Mute This Topic: https://lists.cip-project.org/mt/78427982/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--obrHqSF93lA0M9wofTJP--
