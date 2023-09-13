Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF640EEB597
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 06:01:51 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.96])
 by mx.groups.io with SMTP id smtpd.web11.5550.1694584907488439857
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 23:01:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ip+Xy09k;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.96, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHGTUTRgiaQ0PmR1sjmIECVLfq+ppS4S/CopmFzrs1pRxoyF3dWug9+zIk5EWRd9KMSyJZqFmyRCHttCVVo0cYp/g24T0Pf8ridcgYw/HxqnVPKoMWvloGkDsujwZl6uZ0WmWZe3+fQQV7zqVLEdUgh8BHE+XI53fBHfEIpRl7W2gCjl3zgZOk6InOb47Bb33HIp4wzzmWIqgTPANnuje0EAx1t/HLTwcPV26TjVU0SUTarsKgfZq/Ihhy0KD/Xmis008Gu8VWVBi7XjnrWpHef454gF6Tv9TMIud+wO72klgpjxYDOw4vHy6ekRvZDu4sd6qljPo+JXKqxH/gkouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr81RfJ/Js9R+5TYkwFn/2ZVx+1j8KnDTSHYCkeqsKA=;
 b=jErV6MjS4Fu3GipAOZW6zaANFsp3o7hoQsAPv1MmHtwEhVZkOxePqQzyAc1tusoWGKwUjxsHC8ST7QYt2MPYJD2/+ZWrDLt8y+0TF9Scfk2SigLMR/aVzpY7nWk7TSzc/4iFvS0K9V3u4WbQbwkR8OUsX5lkiMTG8pb/h6vElDUlG19ZPqNjqS1mufjJ6S77uqPhObZxMzJLrqa53J6a0tTfiJGtbLCdgaizLAgj9Ot3sKGivz6lK3Ww5gildxPk8gBtTMA7wgVAB0nenfNeEqmoIdLzaKixOVH5mD3ph4MNLizM0vfPuBM/COgH7OEB0a2F38RdOKR/svDIwi46Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr81RfJ/Js9R+5TYkwFn/2ZVx+1j8KnDTSHYCkeqsKA=;
 b=ip+Xy09k1iuccQYpdQQjXzQJVLLpbcPmio3b1d+Hh41pTJuwyYraRbq8KtAG++UJzpagasJ8thb990Ncr/V19a56q7QXVNnxQ693znnXkinxvF+ta6HR3VlDReWWXz+7cIPtXuUExw2fUYnbsQXG4hGVa+vchmh0MwExvN3eukc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6150.jpnprd01.prod.outlook.com (2603:1096:604:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 06:01:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:01:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Thread-Topic: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Thread-Index: AQHZ5M0JBE/CcNwYj0eMnWrAEtZ6r7AXsr8AgACS3zA=
Date: Wed, 13 Sep 2023 06:01:40 +0000
Message-ID: 
 <OS0PR01MB59222D5B824F1694EDDA906486F0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
 <ZQDUzmyf4zQGd4fB@duo.ucw.cz>
In-Reply-To: <ZQDUzmyf4zQGd4fB@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6150:EE_
x-ms-office365-filtering-correlation-id: cd3d46d6-f122-4035-6ff8-08dbb41ee5f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /te9TYvNDkkXZlW8hVhRZMmhkXmVT7fUBNgeZsfSWwMusPaUHm8YZrD2LkVnPO0TgaMUMmowSg/C4sE9MVKQxUDB58tOdpv8pjyxdBCGPVCr/N6f5kYNGyhsXv7BB+G3jxfjb9o/6nGzq6mq4Wr9jHW4P3bmHsBdJmeztqnYBKcXUPHMMPhx3/IIVSSaC9F6zEzxWvwJLppY5J7uZTJrjKKrKq4zIGYk1E+/fXpGOKJc2bM5njYRKahMUJqLfHJOJEG4l1uAmTuYf2ryrxKiCugnnJaX3S82W4HHZDbNCgoD3PMGoDQ9MQNuutXsURRHJ80BKa233iKujKeYek+Y2IztWZ0GbWR0C8cshVLSaj2Zs+YkhyOZShz45HRDqrKkJqBytn7BKDk5XdeEqVgdNtAHm+hlDiezzRGFbeN1Gp/kWGR5MpM6GQfEAIgpt99ZS+76jr4ZfXAHkyUPFbopwdFX1SGADYab7tKW0K9z2+pi4UDkfh7u/Q4MsGjygVvOgeE8kokr36Ifvs7kZOX/bvtMWDkJv99b8ZeusIzj4gPLQTprvsl8WdeJsBRr2wIysP8Vq82TTAMVRZh/NcmsQH/TyiYqZlBSAfLZK7yx8a3foQayiJi6FU+CcHMxAsVD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(7696005)(6506007)(71200400001)(9686003)(478600001)(107886003)(26005)(2906002)(4744005)(66446008)(66476007)(64756008)(54906003)(66556008)(66946007)(5660300002)(76116006)(6916009)(316002)(52536014)(4326008)(8676002)(8936002)(41300700001)(33656002)(38070700005)(122000001)(86362001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7b+tBeWiHb1vjv+5JLql6o+7YF+A75Cj5VD9rHlhup5+8obaJo5RjJSTn7vU?=
 =?us-ascii?Q?DNuw/YN074VUyFISGieZ0TjRmn8/4ca/rNNAVkPcBJsl8tRdtrK9/1WAL9Y4?=
 =?us-ascii?Q?tUVqvUsm6EVAQltwtjA7KBYJ9MdS+d24BVkQDixmfgaBIgFFZDgkQE/RJE+A?=
 =?us-ascii?Q?UU4V+DWlx4LosfdnjuGjmH+KIxczPmKeIWVYkWYbayY66BgVAdh5uZskdCbJ?=
 =?us-ascii?Q?aEJKhTzOYb4tX5+ZVKGD6bwHdxoGPYlPrF26mDMACw3mlwChYWFox+zzo2qu?=
 =?us-ascii?Q?YMFUhDazZ3lAOhQfxczNq2KK6wFnPCGdaHzVVbSAuZxIuYMQ4v+acP4S7D4l?=
 =?us-ascii?Q?cqauVikH2TAeYTqqtVP+eyw/ib560UbRSN9v7ae7JqkuAzDtyM7jg+hM3V5p?=
 =?us-ascii?Q?sgbFbmR28VyvBRyiss3VeUBC7YiryWh2Ts7yNLoWibaH550NohFp8K7KnKLG?=
 =?us-ascii?Q?K2aqqxGPUAC87VGO5mIVnkf0qQT+XjUhBJeIG23UEvy9YQdJeu3PmiaP5vKX?=
 =?us-ascii?Q?FbQz6HX5LCVBcomhbhywCCbRA/mhNBzRLb31Ekx3N/CjiDEmRT7liKrjGwIt?=
 =?us-ascii?Q?lfM+LaJ7Z+YbH6E+BCv+P26JVJUEVLwlRpuBKMIj+CtPwmIiWW/pkFuBgHU5?=
 =?us-ascii?Q?pSzYdxxktKRagV/zxrLTbs3HzeITZI8llSFri4OVOwF/Mphm+bWCSlDiETTZ?=
 =?us-ascii?Q?yxJOP+OxouKmTSt+4FAXwt7t37kbBCIIBHi4eT/dS1/Lc9YKkvGLTvpNd4Ej?=
 =?us-ascii?Q?ud0Tc5SAL6XFzZuIgu+jdxnBnZWdKEQvLlHz1qkut8d7pZpMaclcRP/sxklA?=
 =?us-ascii?Q?jKrxXIykxS0gNBanwdcapidhTTETWLJwgrqcbeRuXQlkvO44HSFBi+rBwXd2?=
 =?us-ascii?Q?l4zmoQRLAts8bdl2CC9fQW8vDO/wkKHMWOGpJt5rwt07azphd5Thv+z9lDXm?=
 =?us-ascii?Q?u0QMg0eglsYjNfWzGXqSTbvYVhwl9JDd+3Eg2pklnLzTG3ARhTnzWPzAD/5F?=
 =?us-ascii?Q?JyxYYmv++1bTf9vGuCNzkYjexi1ENYLgmTUYvKr0ojpXwATYQ/0N9oJYbJLJ?=
 =?us-ascii?Q?8yDqhRu1567aIOjUemMJxMnOla56dvRhVuRrFhu0+d63472MK2HgnoguvjZn?=
 =?us-ascii?Q?Y1ql1CiDgy3HVs4uzOh+7A1Deoid7CjMak1FwNfMVNCJsAxGh2EMOhOIvX0Z?=
 =?us-ascii?Q?kAsl1kMwJOhtbPBnSxpzjAD5URWniHzDB8hzZGuE3WRO1oM9EZDHiWowNvqy?=
 =?us-ascii?Q?eLSb+Ada4WxHWtKekl9JZAesMFU+Lud7N+xulc7sJ0xCVGyxF0DLXBBiTGVq?=
 =?us-ascii?Q?JFY1iP4Z4ygff+ifd7idnulhFOnpnCl0MyXSzJ0yX3OaHl/DwOPSPlHKuOsw?=
 =?us-ascii?Q?q9RGUOL5PnQQe0RwULUqUp2cyiFHq8BIxKTZdDQUyi2eduyTnMtZ2+CW7bsQ?=
 =?us-ascii?Q?WIC2JTZtoaq4zjECMxL5iFCr1gMoIFuo/KZ1+KXxL8s2InVUEWkZlMc7HgDu?=
 =?us-ascii?Q?jcEtyiW9q5kGBBfeXfZzTPBToAVdLNK8b8AnX+enrT8DlsgQQcw9w2CoC8HO?=
 =?us-ascii?Q?RDMUXj0Q4waog8NBe1yCtM27R2n4V9qVvZAftVJYxkoUsRJ045lq7ud67UuE?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3d46d6-f122-4035-6ff8-08dbb41ee5f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 06:01:40.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rpn+uJxmSAFNkUs3xKRihkr9ZhohWRcvx/2A3Isj2QA59lKVGcEpbJ0Suz8u22Fj3X5ETkcSe1gIGxPLGm6vybVrspN+OY6JO6XX5xveGx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 06:01:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13096

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RT=
C
> builtin support
>=20
> Hi!
>=20
> > This patch series aims to enable PMIC RAA215300 and builtin RTC
> > support on RZ/G2L SMARC EVK platform.
> >
> > All the patches are cherry-picked from the mainline.
>=20
> This is a bit strange; these two look quite unrelated.
>=20
> >   arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for
> >     ETH0
> >   arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos
>=20
> I'm happy to apply the rest (unless testing fails or someone objects). I
> can take these two, too, if you tell me this is intentional.

I missed to add this in cover letter. Sorry for that.
Please take these patches as well.

Cheers,
Biju

