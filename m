Return-Path: <SRS0=P0Fr=IH=lists.cip-project.org=bounce+64572+6261+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B71C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:48:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568616523B
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568616523B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6261+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WPAaYY4521723xIOSTEryneC; Tue, 09 Mar 2021 12:48:12 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.536.1615322892254950117
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 12:48:12 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA0CF1C0B78; Tue,  9 Mar 2021 21:48:08 +0100 (CET)
Date: Tue, 9 Mar 2021 21:48:08 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2 support
Message-ID: <20210309204808.GC7900@amd>
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
X-Gm-Message-State: phc2DoBtaqiYqZim6IyYSqMXx4520388AA=
Content-Type: multipart/mixed; boundary="YHy7m9W2olRAuYp68N6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615322892;
 bh=ynpGrmxWzybt2fQd9gczqgqfZU+okR0Npv1Zbw/Bvo0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kZq4GZPhLdq/jMSswYaMTirzQMyBUIDNqdC0gLhCbb6uW8f6C6MP5rJ3Ek5xINyttOo
 cnls47f8QkyEnvRXWWKYCrTKuI4oUC81Phm8z8V4+M1BBiOvcsVAdH25X5Lkl+3DsknB6
 2zQClwALyGguarwT/OPea/tjcej11l1QjWA=

--YHy7m9W2olRAuYp68N6X
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline

--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I had some minor comments, but the series looks good; I guess we don't
need to delay applying.

Some of the patches are not in 5.10, so we'll need them in cip 5.10
branch, too?

Let me do some testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBH3wgACgkQMOfwapXb+vLT9wCbBpYPeOHdKaWN9q9YnGPMC0w/
tZMAnAkPF8cburNzqRCDRJdG7uGZLPEV
=ZoEh
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

--YHy7m9W2olRAuYp68N6X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6261): https://lists.cip-project.org/g/cip-dev/message=
/6261
Mute This Topic: https://lists.cip-project.org/mt/81205345/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YHy7m9W2olRAuYp68N6X--
