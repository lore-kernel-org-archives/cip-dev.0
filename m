Return-Path: <SRS0=F6i8=IH=lists.cip-project.org=bounce+64572+6262+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5AC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 23:13:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7412865100
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 23:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7412865100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6262+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d9FVYY4521723x6sRjvaxOfe; Tue, 09 Mar 2021 15:13:57 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.1030.1615331635864412824
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 15:13:56 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CCC7C1C0B88; Wed, 10 Mar 2021 00:13:51 +0100 (CET)
Date: Wed, 10 Mar 2021 00:13:51 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2 support
Message-ID: <20210309231350.GA14309@amd>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XT8ZrXBXgh0Y54x97pAuU4Mqx4520388AA=
Content-Type: multipart/mixed; boundary="V6TYbwbp43ymfHT1OAO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615331637;
 bh=teThDXqE2r07VUYtVub4vK9zRvsg8fmHQa9hv73MmFk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=d96Nr0mXQcum0AEMh1bggKZuO8D92YXYj/QLafc1/YYRRxZ5lZdKv1ixq7VLk48tcsV
 XgsOe7ZOJhllEI7bo5y4iqVerwVkRbWdaH+iCraUgVLyIJFbtiPO9XdO5HB8CMBcA1Ayh
 bTVPQLYB39i9AgS/rQRVNgEbjK9CECYXb9I=

--V6TYbwbp43ymfHT1OAO0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series does the following:
> * Drops unneeded regulator setup for OV5645 sensor
> * Adds driver for IMX219 sensor
> * Updates v4l2-async to accept endpoints for fwnode matching
> * Various fixes for R-Car VIN driver
> * Support to capture RAW format to VIN driver
> * Support for RZ/G2{H,M,N,E} SoC's in VIN/CSI2 driver
> * DTS changes for HiHope RZ/G2{H,M,N} and SI Linux RZ/G2E to
>   enable VIN, CSI2 modules and OV5645, IMX219 sensors.

Well... test are okay, except that Renesas lab is offline so it was
not really tested on Renesas targets.

Anyway, I guess I'm okay with applying these if there are no other
comments.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBIAS4ACgkQMOfwapXb+vJ4NQCgmnc5YXTXjEL8RLctmTfN/Rh3
qFMAnj0U2gS2C0vifHM8uP3MJWOazNO5
=W+do
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--V6TYbwbp43ymfHT1OAO0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6262): https://lists.cip-project.org/g/cip-dev/message=
/6262
Mute This Topic: https://lists.cip-project.org/mt/81205345/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--V6TYbwbp43ymfHT1OAO0--
