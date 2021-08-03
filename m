Return-Path: <SRS0=dR47=M2=lists.cip-project.org=bounce+64572+6650+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD3C432BE
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 12:36:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C999960EB9
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 12:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C999960EB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id g370YY4521723xZeyWKyoCP5; Tue, 03 Aug 2021 05:36:16 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4283.1627994174821633439
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Aug 2021 05:36:15 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8B5F01C0B77; Tue,  3 Aug 2021 14:36:10 +0200 (CEST)
Date: Tue, 3 Aug 2021 14:36:10 +0200
From: "Pavel Machek" <pavel@denx.de>
To: mjan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.277-cip60-rt35
Message-ID: <20210803123610.GA8747@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qinOFoVUiBLjeOUKpIXCOLSKx4520388AA=
Content-Type: multipart/mixed; boundary="0jnvZRfV1C7R0RJucYva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627994176;
 bh=TEPcwNAVXhWqjgkIhYa1WKbmtcih+vWiLIXsrCk3sZc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bSFd0/eHZknxl93txV+RGEfJQgWc10iBk4euUe6MoKTp5RqlQvfYDmw/QHIldV7R4kg
 4h1Md3gAhQ8kpvOQA0z3+XSdu2nf1l2tN+M/fswQmNucmnZkH9scbzMLzvggQdo9aZIbL
 B+jN/EZXEMFtg/3X9VsLs4HSDGvAkqZM4tc=

--0jnvZRfV1C7R0RJucYva
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYQk4OgAKCRAw5/Bqldv6
8unTAJ92VAGmiZSBymk9W/jH8YSQw0sLogCeOykCjURXYDIQ3ph3IgSfRZ52X9c=
=VSxw
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--0jnvZRfV1C7R0RJucYva
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6650): https://lists.cip-project.org/g/cip-dev/message=
/6650
Mute This Topic: https://lists.cip-project.org/mt/84637569/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0jnvZRfV1C7R0RJucYva--
