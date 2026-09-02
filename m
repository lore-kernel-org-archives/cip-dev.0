Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B71C61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 17:01:05 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.497.1788368465046994613
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 10:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=C/vkKcrQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DF3111D591;
	Wed, 02 Sep 2026 19:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788368459;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xhym6DYxkCma00/ZWoeNB68BcUtYcqWXDonT1D038Z4=;
	b=C/vkKcrQU7236v9ZMSlkAhW3ew+5XTapA8UdnE1rdVxzX/rvoeOv9EsBTAi1746qm5HTod
	nZfg1QPdwxBcgRkP544X0orzgly2Tc5pnMadIn3VY+bD7JSwvMWe0pKPRabwetdpK1kdG7
	rN2gd+5yZHxxYUE/HAKt2NOjFGNZc0jwBeAsDMl4nDKehcGOVLGLwjLHxzsimyz3zEjgDl
	eVcv9u/Mc//Gw/S8sdZzs/H3/by6alkYKdFMMvaI/mlMMdnloigp2CGCsBidS+BW22+/Pw
	YLHWs3Wj6hzf82Yn4UaMDdA8Pzn8Xva5YqSbHbkfcWeoInNEclzRTry+zen7Vw==
Date: Wed, 2 Sep 2026 19:00:58 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 00/11] Add ICU error and software interrupt
 support for RZ/V2H and RZ/V2N
Message-ID: <aphWSme97YOn6pxD@duo.ucw.cz>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xdnZNPiqLnAXve2A"
Content-Disposition: inline
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 17:01:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24081


--xdnZNPiqLnAXve2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series adds support for error and software interrupts in the ICU
> driver for the Renesas RZ/V2H and RZ/V2N SoCs.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--xdnZNPiqLnAXve2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaphWSgAKCRAw5/Bqldv6
8o70AJ90VqAbeanJFS0RfHeDUl26CCA4CACdFLPnwx1yeudAN0uCEGPJzYIt4qs=
=4srh
-----END PGP SIGNATURE-----

--xdnZNPiqLnAXve2A--

