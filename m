Return-Path: <SRS0=iHRz=BX=lists.cip-project.org=bounce+64572+5114+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B39C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 08:01:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2B32078D
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 08:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RmWTI8B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2B32078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5114+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8jTxYY4521723xiimFtUb5RL; Thu, 13 Aug 2020 01:01:25 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5720.1597305683976130619
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 01:01:24 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8447F1C0BDD; Thu, 13 Aug 2020 10:01:19 +0200 (CEST)
Date: Thu, 13 Aug 2020 10:01:19 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: defconfig: Restore debugfs support
Message-ID: <20200813080119.GA11401@duo.ucw.cz>
References: <20200813064900.7509-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200813064900.7509-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TLSmgmmuOxqEHTxkKflVRhRBx4520388AA=
Content-Type: multipart/mixed; boundary="LWNrTovzi7fupBs4oF6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597305685;
 bh=2EGcXwpEMLtAhlF+jKJg0PbZoEtMfo6ZS81CteJ1PN0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RmWTI8B28m4d5ea7xywSvS32hjh7ES+D9L99GkVO9cQDeuvZ49f9umkWv0Ks3o1S1rq
 6HSov1deCHMwCFnV4QfCYkvWenj9kUFBPQuUX9mSRRX5JALcPNa5w/6tfeu2aF/XCxnvx
 Rv3nRchTXwSbGuJymm6dzkBSynBG2mPhWCg=

--LWNrTovzi7fupBs4oF6k
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit fa2cdb1762d15f701b83efa60b04f0d04e71bf89 upstream.
>=20
> Since commit 0e4a459f56c32d3e ("tracing: Remove unnecessary DEBUG_FS
> dependency"), CONFIG_DEBUG_FS is no longer auto-enabled.  This breaks
> booting Debian 9, as systemd needs debugfs:
>=20
>     [FAILED] Failed to mount /sys/kernel/debug.
>     See 'systemctl status sys-kernel-debug.mount' for details.
>     [DEPEND] Dependency failed for Local File Systems.
>     ...
>     You are in emergGive root password for maintenance
>     (or press Control-D to continue):
>=20
> Fix this by enabling CONFIG_DEBUG_FS explicitly.
>=20
> See also commit 18977008f44c66bd ("ARM: multi_v7_defconfig: Restore
> debugfs support").

Do we rely on these defconfigs? I can take it as it should not break
anything, but it should not really be too important for -cip project.

[It is "defconfig", not "suitable-config-for-debian-9" :-)].

Best regards,
								Pavel
							=09
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -226,3 +226,4 @@ CONFIG_NLS_ISO8859_1=3Dy
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_ARM_UNWIND is not set
> +CONFIG_DEBUG_FS=3Dy

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzTzTwAKCRAw5/Bqldv6
8uINAJ9VwHZ4/egzSLK5trcZRmpvCZ6Y1wCYg9GhYnEiuYGm3i65KIEsFuR2uA==
=4Ucv
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--LWNrTovzi7fupBs4oF6k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5114): https://lists.cip-project.org/g/cip-dev/message=
/5114
Mute This Topic: https://lists.cip-project.org/mt/76163657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LWNrTovzi7fupBs4oF6k--
