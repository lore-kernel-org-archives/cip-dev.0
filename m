Return-Path: <SRS0=GU+Y=6Z=lists.cip-project.org=bounce+64572+4619+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9CC47255
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 15:04:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A935820736
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wFfbb3Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A935820736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4619+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 41JFYY4521723xpR6yT0Ebva; Mon, 11 May 2020 08:04:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13815.1589209470763387480
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2020 08:04:31 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 574991C024E; Mon, 11 May 2020 17:04:27 +0200 (CEST)
Date: Mon, 11 May 2020 17:04:26 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.120-cip25-rt10
Message-ID: <20200511150426.GA18173@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: l3CwM71QCQXDIAUF4YhTz7Eyx4520388AA=
Content-Type: multipart/mixed; boundary="kIvUOUZYk8AGnAqxBFNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589209472;
 bh=jDq4k0xGYNfvJb+yv1HSq1R2pDcG6vnU/WT8P4618a0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=wFfbb3LpCOos+R1XATuxuhad/MCRmAak5fFmHUr7C3Xt5c1kixTy97fLc9xTcGS+DgE
 fJm7KgeKTha3bXaTyhlIUXG4fWFDnQ4D4TEwz32YkU9d3Z8U+V/dRbl+R/t/d1S0e4vdQ
 cRkQrHdLzfe9oiOknyqORqpa/BloLYUkPMQ=

--kIvUOUZYk8AGnAqxBFNY
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.120-cip25-rt10 should be available at kernel.org. (-cip26 was
not available when I started the -rt update, thus it is based on
-cip25 patches forward ported to 4.19.120. There should not be big
difference besides the version number.)

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

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXrlpegAKCRAw5/Bqldv6
8ptHAJ97JNz0Bt7CgzzHN7LLJdvjq+kicgCfQleAOqJuQT+BqJ/DYLW74BYeYuw=
=vVB/
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--kIvUOUZYk8AGnAqxBFNY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4619): https://lists.cip-project.org/g/cip-dev/message=
/4619
Mute This Topic: https://lists.cip-project.org/mt/74137657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kIvUOUZYk8AGnAqxBFNY--
