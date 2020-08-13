Return-Path: <SRS0=ftfj=BX=lists.cip-project.org=bounce+64572+5118+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447EC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:24 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A2820771
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gTR/1jqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A2820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5118+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id C31fYY4521723xRWRMhQnC0m; Thu, 13 Aug 2020 04:43:16 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.133])
 by mx.groups.io with SMTP id smtpd.web10.5295.1597302883867862297
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 00:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmh5YSXCNzCEYUnEri7jT0e/hvtv5C+ybgg8jLE/gbSHWql4ydnmcu7IVgakVb6ognG6D438Ek3+mqfubYsqlreev/mxQhEpW3PuNUQbunijhFpgTtpLbes123Ekd7bo51iiKTlNRM3444hS2/fM9wO7vQ5cBp1TYW1szaskDkZhErZ2ANHqytLROY+rKcqMzZiPrxsLgoVvpQQfVQ3ubbSYnBNab3P/VJV/JP1oEZ7rfiAqdUngTZ2oCDWBYbtT0H5IL9l/wBaRz+oUr+bjUIoztL0FfSvEnIgiR57FzUXgKpavZuJyjiQ3joz88u/IOTJOdbffbs8iCYQgSLOOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u5YQ3URokoX9r1PrYn58cG1v5nisX4nb4pre0zttDQ=;
 b=FtqaPykbCeSAIVKX9Giw0cfmKCekkFXckmcfpSd+yw37MDqspSyliK+VXq1vtAe8ZRnIQQJ4eY8QrG3zb+SD3mBiX7zx/02ETJT0jwXxNYFa137e1QxcH/VqqlAKfkw3dybhT5isYtqEZQL/n4/tF3rimeF84QFhBTA7fQTHc2cL4/uAA44OqcC8rvDt59Iz6Vz3VsNIXxoB7wZkmvJS1YDBv8TUkt/nckbIpNGL1DAtNo6QpX9GEscu7F2N2Hx5m/OOLanL5Q8eeRKHx2FMuztwopUFidRdRweWmsDZbi22R4YMzx89r5IM0F6T1j6H7Ncv5qvt1CeUhlZ9UMA/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB5162.jpnprd01.prod.outlook.com
 (2603:1096:404:11a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 07:14:38 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 07:14:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [linux-cip:linux-4.19.y-cip 7/17] drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for 'drm_atomic_get_old_private_obj_state'
Thread-Topic: [linux-cip:linux-4.19.y-cip 7/17]
 drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
 'drm_atomic_get_old_private_obj_state'
Thread-Index: AQHWblc6UyTwUPv9eECCBW1u6/T3Caky6F9AgAIJMICAALPG0A==
Date: Thu, 13 Aug 2020 07:14:37 +0000
Message-ID: 
 <TYBPR01MB5309A9DA2DF6664805B26C1E86430@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <202008092247.i5TR1Oel%lkp@intel.com>
 <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200812202821.GC19363@amd>
In-Reply-To: <20200812202821.GC19363@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad55823f-c9f7-4c36-3db3-08d83f588a2a
x-ms-traffictypediagnostic: TY2PR01MB5162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB5162AB0387B5D619BDAFD45C86430@TY2PR01MB5162.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:95;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 sezWCYDSmLO10DE9inecN3GmDBrB2u7lZSrGQlx0tSsCgelx/SPOIJ2GiuQsXojezBHSv6cxIbcSE8maYHMATXPkjFC5783DUOGEd8rwwHzfM48Z6Q67hw3Hga3bWIGzpa1pWXBvCZNqs5vgN/42sIsTC+WpPcW5TkQLdM92GY1IMGbZnTTTULGAsdsGzFbP06EvIIX13aqNF8aGbXMnAPg1Dnn08e6klM6ZY9VBbs8C+2e0zm9ccsi6I6X3zMlOI8valNXsiuKwN/T6nN083KvjoslCyNPFVPXmx/NFsXZS49EBBhSLWQhHRGUdqjxdjS2FFOBS/vSkWqBpU/ODJA==
x-ms-exchange-antispam-messagedata: 
 KXEZEIWdW7SLleO+zR9i6aFPX7bZR9mlVnyebTvotwNaT3Q32A1v+eEhJHp3EaaBPeG1u3985G6g5igfd3V4rIGAjpINI03FaDFO8jKU1a9eEBLgtqeSoR0brh5G731reEpqR5thddvIhKq6ybTqZUE68P8akeJnWfL0QuyZ+quvQLNanttR/gTuqkyZUtoCV6ZEvUpyaEtsTawtnwGxOiUTNneziW1OrDexECsgukxZUb7DDZUjEi80SVr87dwTS3HFqgFCzV+jdgk9NkPfPazqyStuJFu786AAIgDdtxTRt+Ux2/HkpFJAq2rAJitooRSukCl420ieLTkMLW+AjNjuiQexnwAUpPm741mWwAbZ8kPiaX69hVLDrUrUcDsMWXuQJy+3gmycRuII00ZWZJ9+nVM9S1b+DW+qadFav1Lo+D5WG0COHLOXPxnySgOxuuP4WFNGedJvVm2ilsh46kbs7X7LhMoRq6ggoLAAr0wEIsXy+dVupsK9mqplQ/hbtT+8ZQfy79Nq3IaEVXPSTTbOZBvW8/3OSB2S6u/vb6c6GlR/wOoGS/LsrmzRmMnGjZG0fY7Hs6rivdunN+QcwjkWj0jLzvWvp9OjYSTXzfSafwsS8RtkPbMifU65H5RnxGu87aRTKHE9C/vHXzocvQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad55823f-c9f7-4c36-3db3-08d83f588a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:14:37.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+5gL3tvJ6WSBTg5NLxT2AHS+O1HUMn8ardWeQJJWE02xem6Vj16sjhBIKQIERpPgy/2EYyWg3Omjl+acoUroXBYHw+/GXt28C6Bk+XwKvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5162
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SpK9D8ghjbgHQg58lIZmZ235x4520388AA=
Content-Type: multipart/mixed; boundary="bLjoDHTNxei6mFuQY7Do"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318996;
 bh=6bGB8qy528lOWV4AtLORXjH3TdaS7Ps8OvgemZWc8XU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gTR/1jqqARsfkPMjL4M8JbXNM9XjbKeoeq6I2Z8Sc6y6AyBAnRt/TaAje6I0czXRYRW
 xqi4C2ZMGw3pQoCEIMd2VYIm1av6RiasewHVeIM2lUWCLFGMKqJPRko1cnF9OtXh+p81T
 C9hC2aLEJ4Wtvo8ikMV3ur+e2fzVn/laZFc=

--bLjoDHTNxei6mFuQY7Do
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
> 'drm_atomic_get_old_private_obj_state'
>
> Hi!
>
> > I have received a warning message mail from Kernel test robot. I have
> investigated this issue and found there were lots of warnings with
> architecture by following the steps mentioned in this mail.
> >
> > Then I investigated this particular issue and found that issue is
> > caused by bad commit done by me while backporting. The below backport
> commit has extra functions from patch1(0001-drm-Add-
> drm_atomic_get_old-new_private_obj_state.patch), but the corresponding
> header is missing.
> >
> > cip commit: cacc2a81b9872aa8830353110b1252021f124ae8
> > upstream commit: 1b27fbdde1df172dba604855c45078d741f8c858
> >
> > I have attached 3 patches, that looks like fixes the issue mentioned by
> kernel robot.
> >
> > How do we proceed here?
> > drop cip commit: cacc2a81b9872aa8830353110b1252021f124ae8 and apply
> the 3 patches to fix this issue?
> >
>
> No, let's not revert anything.
>
> This is trivial fix for first issue, make it into patch:

Ok, will make it into a patch

> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h index
> c0b48e25a620..9042fdae9211 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -402,6 +402,12 @@ void drm_atomic_private_obj_fini(struct
> drm_private_obj *obj);  struct drm_private_state * __must_check
> drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
>   struct drm_private_obj *obj);
> +struct drm_private_state *
> +drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
> +     struct drm_private_obj *obj);
> +struct drm_private_state *
> +drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
> +     struct drm_private_obj *obj);
>
>  struct drm_connector *
>  drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state
> *state,
>
> And this is somehow strange / non-trivial thingie. Make it into second pa=
tch,
> and maybe try to explain what is going on there.

Ok will do.

Cheers,
Biju

>
> @@ -656,6 +662,7 @@ void drm_state_dump(struct drm_device *dev, struct
> drm_printer *p);
>       (__i)++)
> \
>  for_each_if ((__state)->connectors[__i].ptr &&
> \
>       ((connector) =3D (__state)->connectors[__i].ptr,
> \
> +     (void)(connector) /* Only to avoid unused-but-
> set-variable
> +warning */, \
>       (old_connector_state) =3D (__state)-
> >connectors[__i].old_state,\
>       (new_connector_state) =3D (__state)-
> >connectors[__i].new_state, 1))
>
> @@ -677,6 +684,7 @@ void drm_state_dump(struct drm_device *dev, struct
> drm_printer *p);
>       (__i)++)
> \
>  for_each_if ((__state)->connectors[__i].ptr &&
> \
>       ((connector) =3D (__state)->connectors[__i].ptr,
> \
> +     (void)(connector) /* Only to avoid unused-but-
> set-variable
> +warning */, \
>       (old_connector_state) =3D (__state)-
> >connectors[__i].old_state, 1))
>
>  /**
> @@ -697,7 +705,9 @@ void drm_state_dump(struct drm_device *dev, struct
> drm_printer *p);
>       (__i)++)
> \
>  for_each_if ((__state)->connectors[__i].ptr &&
> \
>       ((connector) =3D (__state)->connectors[__i].ptr,
> \
> -     (new_connector_state) =3D (__state)-
> >connectors[__i].new_state, 1))
> +     (void)(connector) /* Only to avoid unused-but-
> set-variable warning */, \
> +     (new_connector_state) =3D (__state)-
> >connectors[__i].new_state, \
> +     (void)(new_connector_state) /* Only to avoid
> +unused-but-set-variable warning */, 1))
>
>  /**
>   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic
> update @@ -717,7 +727,9 @@ void drm_state_dump(struct drm_device
> *dev, struct drm_printer *p);
>       (__i)++)\
>  for_each_if ((__state)->crtcs[__i].ptr &&\
>       ((crtc) =3D (__state)->crtcs[__i].ptr,\
> +      (void)(crtc) /* Only to avoid unused-but-set-
> variable warning
> +*/, \
>       (old_crtc_state) =3D (__state)->crtcs[__i].old_state,
> \
> +     (void)(old_crtc_state) /* Only to avoid unused-
> but-set-variable
> +warning */, \
>       (new_crtc_state) =3D (__state)-
> >crtcs[__i].new_state, 1))
>
>  /**
> @@ -756,7 +768,9 @@ void drm_state_dump(struct drm_device *dev, struct
> drm_printer *p);
>       (__i)++)\
>  for_each_if ((__state)->crtcs[__i].ptr &&\
>       ((crtc) =3D (__state)->crtcs[__i].ptr,\
> -     (new_crtc_state) =3D (__state)-
> >crtcs[__i].new_state, 1))
> +     (void)(crtc) /* Only to avoid unused-but-set-
> variable warning */, \
> +     (new_crtc_state) =3D (__state)-
> >crtcs[__i].new_state, \
> +     (void)(new_crtc_state) /* Only to avoid unused-
> but-set-variable
> +warning */, 1))
>
>  /**
>   * for_each_oldnew_plane_in_state - iterate over all planes in an atomic
> update @@ -776,6 +790,7 @@ void drm_state_dump(struct drm_device
> *dev, struct drm_printer *p);
>       (__i)++)\
>  for_each_if ((__state)->planes[__i].ptr &&\
>       ((plane) =3D (__state)->planes[__i].ptr,\
> +      (void)(plane) /* Only to avoid unused-but-set-
> variable warning
> +*/, \
>        (old_plane_state) =3D (__state)-
> >planes[__i].old_state,\
>        (new_plane_state) =3D (__state)-
> >planes[__i].new_state, 1))
>
> @@ -836,7 +851,9 @@ void drm_state_dump(struct drm_device *dev, struct
> drm_printer *p);
>       (__i)++)\
>  for_each_if ((__state)->planes[__i].ptr &&\
>       ((plane) =3D (__state)->planes[__i].ptr,\
> -      (new_plane_state) =3D (__state)-
> >planes[__i].new_state, 1))
> +      (void)(plane) /* Only to avoid unused-but-set-
> variable warning */, \
> +      (new_plane_state) =3D (__state)-
> >planes[__i].new_state, \
> +      (void)(new_plane_state) /* Only to avoid
> +unused-but-set-variable warning */, 1))
>
>  /**
>   * for_each_oldnew_private_obj_in_state - iterate over all private objec=
ts in
> an atomic update
>
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--bLjoDHTNxei6mFuQY7Do
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5118): https://lists.cip-project.org/g/cip-dev/message=
/5118
Mute This Topic: https://lists.cip-project.org/mt/76126617/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bLjoDHTNxei6mFuQY7Do--
