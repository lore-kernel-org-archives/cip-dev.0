Return-Path: <SRS0=2m0G=DB=lists.cip-project.org=bounce+64572+5470+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E14C4363D
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7248123600
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ngMaxlyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7248123600
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5470+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w5mMYY4521723xqVc8OGNctx; Thu, 24 Sep 2020 03:17:40 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13567.1600942658842337453
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 03:17:39 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C804C1C0BDA; Thu, 24 Sep 2020 12:17:32 +0200 (CEST)
Date: Thu, 24 Sep 2020 12:17:32 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CVE-2020-0427 / pinctrl: devicetree: Avoid taking direct reference to device name string
Message-ID: <20200924101732.GA30460@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GnInVQdbdEe9ETOuiQgYihssx4520388AA=
Content-Type: multipart/mixed; boundary="EAm3TR3nsPeBFIe4t8mF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600942660;
 bh=nhbPb/7PjORGYbO5rRUEiIE8NZLA/SYqbRP6AviWDHk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ngMaxlyjQmUIi3g1dh6Ih7AUVL0WMJkDBkG7DnhPj1GBIabFXs4DALlqei6/3J/ywBe
 p1Se7LtB0yaAIojvRWCscp415+1ERu2eAARHCzKcZ5tGdsAcRZXwmUD+OELt6zJ6vmoZA
 GqogV2CJfIgHC/QVnUDIgSDV/As4yhVJDWo=

--EAm3TR3nsPeBFIe4t8mF
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Backport to 4.4 was very easy (there was single dev_err that prevented
patch for applying), and backported patch tests okay:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/193933346

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2xyPAAKCRAw5/Bqldv6
8k3rAJ9ViQvmwXZYS4QQBFM8rCkuJaxosACeJ4ABxQohiPriZVfEaodAfh8tmuU=
=JxKg
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--EAm3TR3nsPeBFIe4t8mF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5470): https://lists.cip-project.org/g/cip-dev/message=
/5470
Mute This Topic: https://lists.cip-project.org/mt/77054335/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EAm3TR3nsPeBFIe4t8mF--
