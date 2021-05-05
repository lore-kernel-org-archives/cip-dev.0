Return-Path: <SRS0=OpaB=KA=lists.cip-project.org=bounce+64572+6427+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40759C43460
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:34:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561546112F
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561546112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6427+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x8WXYY4521723xwSXfUOV4gq; Wed, 05 May 2021 01:34:43 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5196.1620203682676860402
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 01:34:43 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7ED9E1C0B87; Wed,  5 May 2021 10:34:40 +0200 (CEST)
Date: Wed, 5 May 2021 10:34:39 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chen-Yu Tsai <wens@csie.org>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	masashi.kudo@cybertrust.co.jp
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
Message-ID: <20210505083439.GC29521@amd>
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lpFI3yf2pj7h1eM7xuoBKUrMx4520388AA=
Content-Type: multipart/mixed; boundary="2W3KJArqSIu7zXs7lPgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620203683;
 bh=b9FMuTpXOaHP6vI7eDEMIMa6Ztsc/0UuFMNl5vf+S/M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NjosI/yPn0a81+fg01Nm4nd1cf5dF38iVJajxgwEH330Gkc10dY7B5Utp1klv/e8YSV
 GnuMEKFufZ3TyM3aNiC4l2Tq8qYiUbKmCqn2LO6rNTCTb+xpQ2ygdf++JD1bDM+xMqP7C
 vfP10oYKNNdBZYEEyUwnT9cU0X+eit3A2kw=

--2W3KJArqSIu7zXs7lPgV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> - CVE-2021-31916 [md: dm_ioctl: out-of-bounds array access] - fixed
>   Likely needs backport to 4.9 and earlier.

Backport is trivial in this case.

> Additionally, one old CVE is now fixed:
> - CVE-2020-26541

This is UEFI secure boot, and it is more of "implement missing
blacklist functionality" than a bugfix.

If someone uses secure boot on UEFI, we may need to do this, but
perhaps noone is doing that.

Best regards,
								Pavel

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index eab3f7325e31..a6e6a852c9e8 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -524,7 +524,7 @@ static int list_devices(struct dm_ioctl *param, size_t =
param_size)
 	 * Grab our output buffer.
 	 */
 	nl =3D get_result_buffer(param, param_size, &len);
-	if (len < needed) {
+	if (len < needed || len < sizeof(nl->dev)) {
 		param->flags |=3D DM_BUFFER_FULL_FLAG;
 		goto out;
 	}

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCSWJ8ACgkQMOfwapXb+vJqxwCcDJJHEveCOXMiS7YW20yp0cmx
wIkAni4zfebjGmaEOazYnMJb7/18L1wY
=E3YH
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--2W3KJArqSIu7zXs7lPgV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6427): https://lists.cip-project.org/g/cip-dev/message=
/6427
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2W3KJArqSIu7zXs7lPgV--
