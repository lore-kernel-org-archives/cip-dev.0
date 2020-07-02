Return-Path: <SRS0=rOXN=AN=lists.cip-project.org=bounce+64572+4883+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F6C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7171220771
	for <cip-dev@archiver.kernel.org>; Thu,  2 Jul 2020 09:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xH0UKKA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7171220771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4883+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kfqoYY4521723xRH0LrOmkLx; Thu, 02 Jul 2020 02:32:50 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2965.1593682367910836421
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2020 02:32:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 04B611C0C0A; Thu,  2 Jul 2020 11:32:45 +0200 (CEST)
Date: Thu, 2 Jul 2020 11:32:44 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] v4.19-rt status
Message-ID: <20200702093244.GA12176@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iqxTc1cCqlw1CyOTMQikVKChx4520388AA=
Content-Type: multipart/mixed; boundary="iLOpSElVlgKWNMeD73jB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593682370;
 bh=uUaHGk+r6fTxKpi566x5e6Ml5seAG+IlAiIP10DSpx8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=xH0UKKA05pZNnLfqsr6wFXL/2XetoW833/4pAwgzGeQh9b1hVbAKp5Z+TnykQiymDdp
 z4XRVK3vtI5DVUjWkpUCH4aD0chjms5U0qKlk2KLYCqfXnCUvxOed4Oi96Umrg8KhM/L/
 NgXRlzP1y7jYwVLmkSstjjoXlKTCoH/WO0w=

--iLOpSElVlgKWNMeD73jB
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Newest 4.19-rt kernel is currently v4.19.127-rt54. That's not good
match for us, as -cip kernels are v4.19.128-cip28 and v4.19.130-cip29.

I could do kernel based on v4.19.127-rt54 and v4.19.124-cip27, but I
believe it makes more sense to wait for newer v4.19-rt release.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXv2pvAAKCRAw5/Bqldv6
8qHKAJ9zMF5/Byo6fGvUeELU4YR1x9ngjwCglUUQBsPe0Zj5s/r/1QZuH+cCvhg=
=ypVH
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--iLOpSElVlgKWNMeD73jB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4883): https://lists.cip-project.org/g/cip-dev/message=
/4883
Mute This Topic: https://lists.cip-project.org/mt/75254805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iLOpSElVlgKWNMeD73jB--
