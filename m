Return-Path: <SRS0=nirJ=DI=lists.cip-project.org=bounce+64572+5491+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDC4C4727C
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 14:18:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938F820B1F
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="haoUNfUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938F820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5491+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HCDJYY4521723xFyT6zuiODa; Thu, 01 Oct 2020 07:18:23 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1106.1601561902046697570
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2020 07:18:22 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 67E511C0B92; Thu,  1 Oct 2020 16:18:18 +0200 (CEST)
Date: Thu, 1 Oct 2020 16:18:17 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.235-cip49-rt31
Message-ID: <20201001141817.GA21738@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UaJYKus7MFBYgNzldZ2yMBucx4520388AA=
Content-Type: multipart/mixed; boundary="EI6SOAKjpKlxfKIUa5hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601561903;
 bh=HWtRN4hLqjJ82rafim3OeoRs+dkeCWGHnxPWI6EAe28=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=haoUNfUrTPaS+fsSCSFOu9nc9y+kW9dBVRD0KZI/TM5sIqv4r7Bz94Zh7xwyVyrkk1v
 Sys4ftHqgu9vtVlYnpXmllOGAIsumlsnKJT5ZNLQLz0DFxUhnu6egkNrD8EUtL/IwFgxt
 EWMolDjgXsY6lfBQvA65VmHHscHk6uBQr9A=

--EI6SOAKjpKlxfKIUa5hh
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

v4.4.235-cip49-rt31 should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX3XlKQAKCRAw5/Bqldv6
8l/uAKC+gnjil16t5JCOLBoFNS8rMtGnqQCeOM0iojYHcBAnxZ8GPgggnkMdFOo=
=KhZx
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--EI6SOAKjpKlxfKIUa5hh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5491): https://lists.cip-project.org/g/cip-dev/message=
/5491
Mute This Topic: https://lists.cip-project.org/mt/77241331/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EI6SOAKjpKlxfKIUa5hh--
