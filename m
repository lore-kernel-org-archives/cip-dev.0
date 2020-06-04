Return-Path: <SRS0=keof=7R=lists.cip-project.org=bounce+64572+4702+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE32BC433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:32:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EBD206E6
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="recHpoio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EBD206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4702+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uttvYY4521723xQfpfomdVTd; Thu, 04 Jun 2020 04:32:37 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.11631.1591270355683836845
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 04:32:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 55A3C1C0BD2; Thu,  4 Jun 2020 13:32:32 +0200 (CEST)
Date: Thu, 4 Jun 2020 13:32:32 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	fabrizio.castro.jz@renesas.com
Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Message-ID: <20200604113231.GA18088@duo.ucw.cz>
References: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uVmuyAo6Sgn582C9NYnbaOnHx4520388AA=
Content-Type: multipart/mixed; boundary="hcLBFFf2yJGTRhBPvoRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591270357;
 bh=79y7S7T6LR4iHzu6VFZUWFcF7n+9FMzQcVHKPBFIBCA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=recHpoiojTjaoNuZdpvBVRs+JJkKvBMv4pREVnIWCZg0JQVQRQixF3PHSemke+9CqWw
 JLigAXhW7xefX5UmvJIWgfHwIGbzwqfVlNuG37tkI8RoUxfJs16B+hCt2YOTjz4djfyty
 lnM8dqZjsWmzDdLEr+35kpeHKvojxeRbIuM=

--hcLBFFf2yJGTRhBPvoRZ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The iwg20d comes with a 7" capacitive touch screen, therefore
> add support for it.

Thanks, applied, I'll run tests on it and push the result.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtjbzwAKCRAw5/Bqldv6
8tvlAKCnze2QvCtOcvU09nmWgm2XqrhNSgCfYuoXzixlvVU9SXmu9x1vdt7RIs4=
=Qkie
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--hcLBFFf2yJGTRhBPvoRZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4702): https://lists.cip-project.org/g/cip-dev/message=
/4702
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--hcLBFFf2yJGTRhBPvoRZ--
