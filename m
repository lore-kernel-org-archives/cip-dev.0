Return-Path: <SRS0=b4lt=NB=lists.cip-project.org=bounce+64572+6668+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F08C432BE
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 07:33:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3925C61051
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 07:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3925C61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hXsPYY4521723xcrPNxH0Vlf; Tue, 10 Aug 2021 00:33:18 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.5097.1628580797214249058
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Aug 2021 00:33:18 -0700
X-Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 17A7XERA003831
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Aug 2021 09:33:15 +0200
X-Received: from localhost ([167.87.39.56])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTPS id 17A7XDZe013390
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Aug 2021 09:33:14 +0200
Date: Tue, 10 Aug 2021 09:35:38 +0200
From: "Christian Storm" <christian.storm@siemens.com>
To: "Jan Kiszka via lists.cip-project.org" <jan.kiszka=siemens.com@lists.cip-project.org>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-config: Remove runtime dependency efibootguard-dev
Message-ID: <20210810073538.u627sm4pyc4a2ovv@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: "Jan Kiszka via lists.cip-project.org" <jan.kiszka=siemens.com@lists.cip-project.org>,
	Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	cip-dev@lists.cip-project.org
MIME-Version: 1.0
In-Reply-To: <5b7466e9-b110-fd2f-71a0-7d762596e58d@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id 17A7XERA003831
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9VJHwEptrK5W71DPsS2iPORjx4520388AA=
Content-Type: multipart/mixed; boundary="upU9bZMtAxOGys4PIH1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628580798;
 bh=oUK1RY8aHvWCaUS90qSZHDdNa6lWXtXIuw3a/IepBEI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=W3EPAxskljkVkQ3LNpszvBfIgLVK0Oxg5reU8S8eR2hsyTYnCSGaLmk07+LKNaM/RtM
 6tY7GN1HY8AgMx0RJeGUZUQyvMxt8sPp4cK0Zr/d32OVGDp8n3Yed0UKtviqCMSbLqd3x
 IYl9GYyGDGKwXxNKFsp/9wQKZjA8RyjAsUU=

--upU9bZMtAxOGys4PIH1r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>> efibootguard-dev is only a build time dependency and
> >>> not an runtime dependency.
> >>>
> >>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >>> ---
> >>> =A0 classes/swupdate-config.bbclass | 2 +-
> >>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/classes/swupdate-config.bbclass
> >>> b/classes/swupdate-config.bbclass
> >>> index dfa3579..e4879c7 100644
> >>> --- a/classes/swupdate-config.bbclass
> >>> +++ b/classes/swupdate-config.bbclass
> >>> @@ -38,7 +38,7 @@ KFEATURE_DEPS[luahandler] =3D "lua"
> >>> =A0 =A0 KFEATURE_efibootguard =3D ""
> >>> =A0 KFEATURE_efibootguard[BUILD_DEB_DEPENDS] =3D "efibootguard-dev"
> >>> -KFEATURE_efibootguard[DEBIAN_DEPENDS] =3D "efibootguard-dev"
> >>> +KFEATURE_efibootguard[DEBIAN_DEPENDS] =3D ""
> >>> =A0 KFEATURE_efibootguard[DEPENDS] =3D "efibootguard-dev"
> >>> =A0 KFEATURE_efibootguard[KCONFIG_SNIPPETS] =3D
> >>> "file://swupdate_defconfig_efibootguard.snippet"
> >>> =A0
> >>
> >> -dev makes no sense, but don't we have any dep on libs? Or are they
> >> statically linked?
> >=20
> > It is statically linked - efibootguard-dev contains only libebgenv.a.
> >=20
>=20
> Ah, yeah, part the SWUpdate's problems...

Well, meanwhile, this pattern has been deprecated in favor of
using https://github.com/sbabic/libubootenv
I guess it's about time for EFI Boot Guard to catch up..


Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

--upU9bZMtAxOGys4PIH1r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6668): https://lists.cip-project.org/g/cip-dev/message/=
6668
Mute This Topic: https://lists.cip-project.org/mt/84765287/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--upU9bZMtAxOGys4PIH1r--
