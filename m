Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BB1105F797
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 10:40:41 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12887.1773398435891886483
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 03:40:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jr9mnIMO;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDA9210C17C;
	Fri, 13 Mar 2026 11:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773398434;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=o+Pt90ZM1n3sG1V7+btu7ixM53PyEVNJsql6OfdZPaw=;
	b=jr9mnIMOWIRBIKKEH/x/0SSdnLAuRkWbhJdtDpKFTNy9W0/3/8KpPdR/TJIDl1ATgrZXc/
	4u/47Pc+POUpomwnMa6MakYX+Tp9S3UsCcs/+dvC5TMUq0HybybqCu39t8kRFcupaj6KwG
	0roSmzk4UtLM5aIYHA5AcV6oNnArFDgbwFZmJ45A1uUCEOrEdSba/I/kL07koe5s+jE/12
	wf/7kH8Yh4IFR9/XecIrIGcTHarHdcbKh+GPjKYia7/a9Wz7jfvSSi0/XyNE6i6zpgb/Kr
	FMqNxOZsSEXuHJh3XFRUOeBax4Ja3QE+L4ZLwIDgsT4j7iOkKBwYVdpRlUYReA==
Date: Fri, 13 Mar 2026 11:40:32 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 00/27] Add RZ/G3E RSCI support
Message-ID: <abPpoISwFeCNVkKW@duo.ucw.cz>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2YdOIjJ+slJCFEu"
Content-Disposition: inline
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 10:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22373


--/2YdOIjJ+slJCFEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
> 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the
> hardware flow control.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--/2YdOIjJ+slJCFEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabPpoAAKCRAw5/Bqldv6
8oJfAJ9q7GD84GeY3zs7PPasVCp9mAS9ywCfZh9VfNf77Th+NucHj57W754FSAE=
=KNPk
-----END PGP SIGNATURE-----

--/2YdOIjJ+slJCFEu--

