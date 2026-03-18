Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A17103D958
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:03:23 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10632.1773828198510515699
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 03:03:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=eW3ykf2o;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52C01FE867;
	Wed, 18 Mar 2026 11:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773828196;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KtsnERFNqcZmB2/ZCg2bKSPLUBxhRGbRaocEAIa+XmE=;
	b=eW3ykf2ohMKnsGCLQw6m1SGwoqewQKY6iTb+6/Yshs+srYahCCeeznuQcQedkwTotPYE9Y
	JDro0VuKse2176ybO8WF6u01+ayXRE/wlIEGccOcSKkoAI5UaEwmNzt9fH+gaq1J9rQmMK
	KDxZ221T/HHsM9BD89T8vBfLFi1WS7ocjIIc7M1TZdsL27aGb31ToH2/MLrMLvva75uuHw
	PDzmjquZb5Vno31ol/ps7jqDo2qh8vMseb4Nagkoxt/jGJ0sjK+B8y01xuwYTEPyFf/k3D
	mQZtETR9nwWkeww8t3L9kYtAvmoWx/klIvss6YwSlp5+MvvBcKn0QcAeH7geoA==
Date: Wed, 18 Mar 2026 11:03:15 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/11] Add RZ/G3E USB3.2 Gen1 Host Controller
 support
Message-ID: <abp4Y2FVspUgEpCT@duo.ucw.cz>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50y7aWsTbh4G+f/k"
Content-Disposition: inline
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 10:03:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22498


--50y7aWsTbh4G+f/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The USB3HOST
> is compliant with the Universal Serial Bus 3.2 Specification Revision 1.0.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--50y7aWsTbh4G+f/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabp4YgAKCRAw5/Bqldv6
8rkPAJ0XjDznjgaWGJDmbBSTNdTythNOTACdFB25SdajBFYilzWIC0j8wRaceCQ=
=jJed
-----END PGP SIGNATURE-----

--50y7aWsTbh4G+f/k--

