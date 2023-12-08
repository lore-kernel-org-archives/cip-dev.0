Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565AC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 12:09:23 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.135])
 by mx.groups.io with SMTP id smtpd.web10.30866.1702037360741159887
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 04:09:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=FJHQyC0y;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.135, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJASzi8BFxgPcfgmkMaO4srbgelxzWjuH2Jbpt/gv2JdtfWpnEcYJmLdsfMhr1CW93d642Cnq034KIXhfz4Y4G0EhOMvV8czb6kQAJUw6+7+atkaO0CTcXYxtdSXjL5FlWoNBt7G3pP6CCr5/ZPAprKgpqebzWu1vZeFztUXRG7iCcLvX/OHyF6cUPNwVv18WSraxnN5If3Kq6kV6S4yF8p0nywtqh5IC2Z0NWLZm4Zog58+IE8UEzjFRC65wHlbeHBYorL0iNXSMcDocpbNiOSYpOnRrgmMsVFIn4MrFXPUk4NiusqELFR33TbEecLQ0/zglHI5jF9+1UkNAlEamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2vMriTVT9qtBpQceowg1OoFGIv/UTL505pP4en0UEo=;
 b=ifqJjn8eN347rgoy8hJTI2AKZcuc/nTqAZVndJlub4AoJTZ9b+YbHn7fnq2dt7xHz0IWqBM4MTiq4h1P4rtb1smGFfKvl10bFRpPlGuPfiwFWrJOq1X13EyHmVb5UH0TmyFdBovHa7zOiiKppzgrqT9R5v3Q9gU/cCzaSDGUJHHUqHTn5nolWW/dZ8L0CD7XER1dGOdubUtEW4HHGH4M1TdZpj2t5bi4Qwj/tNWxFu4UT5gvdihWTwoZKRheIT6wfJrsAqy/3ErrSQNKavNXlHk4S37Dguytbw/Av/WKn13EydkAuKdN1yYQG7odRzGw14Lk8sQtVSjFo1vsz+7JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2vMriTVT9qtBpQceowg1OoFGIv/UTL505pP4en0UEo=;
 b=FJHQyC0yiyTP4UTvlPkhv6j1zKfoKl/K36sbKL8pw6qP34yw3tBn5wnGeI0KbhADLx1L7ARV3ysPxgrft5zM24VQehAcx9HlnpKpSVS3c/RhBlYZNwir8V0fb40yxl8unx+WPzoNAoMFJ/ISqAQ5AceYVm4ASh+J7fQhqwq4iT0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11009.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.17; Fri, 8 Dec
 2023 12:09:16 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.017; Fri, 8 Dec 2023
 12:09:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Thread-Topic: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Thread-Index: AQHaKRktq19Gr3VJJkGFymjyi+1WiLCfQ/EAgAAISiA=
Date: Fri, 8 Dec 2023 12:09:16 +0000
Message-ID: 
 <TYCPR01MB1126981A5B47036DA2871B78C868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
 <ZXMAOPmuU1J+JCtw@duo.ucw.cz>
In-Reply-To: <ZXMAOPmuU1J+JCtw@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11009:EE_
x-ms-office365-filtering-correlation-id: bb732d67-2b7b-4a7f-b3a4-08dbf7e67fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GpXM77ModYWj5OKHURWDpQ6clLzQd9x98PrjJGc/gKXTkjwx4IaxWrZI9+3PrlAzmBWDuiYoNSH03Gk1tJbC7tFOEWnwr6TG+KOXKwzEaTBfSJdHVMub1riEy8t4bXLPQ6eO7KWCGQbausEAUbM6ckfDZWzkfDTrjfeUoSIKR/1jdu3eblHMe7mZQzetABgT+684RrfYtc0PB72JQ53vC3pww56+WeVezkoCHfLL0r1Y9g+i6SbvK8Sd4mVmpMwZBb68T3yKxViSQfwzza3z1iuH17QbjrppM54xbxD5aWF74IEPCHbTXE5ry9aiwYHG/ca9nuI2KG0ymAsB93rEV+8L1lUfLtIOp8gcgKwefuDpSP/cf5hHh7pJiRKeD7QfqPtfPsyM3DDIQntnntSFnHH8Am38eUtg5XRRThKZirznkwnZLcvlE2ueEtIIOun48aLhZ8dG98tGLzH3YZ0WhB/OQho1n5eONJNeh5dQm+G1z/wtdLquMZ9IwIWXaPBCUCUqhmNUUYccgXA2YH+OMs7xga4gze4U/sePQ4vcEIMsRUYrkbsYK3gJJ6jAu/MQqXO0mY1Nf8Fr7j0hb8XzAh8dgqsmJUetRBAANID96AZYlfrgQYNu7qY1mpD96sFK7e6Xb74ShffqepuFkpEkOA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(9686003)(26005)(107886003)(7696005)(33656002)(6506007)(71200400001)(53546011)(45080400002)(478600001)(966005)(122000001)(316002)(6916009)(66476007)(66556008)(64756008)(76116006)(66946007)(54906003)(66446008)(38100700002)(8936002)(8676002)(86362001)(4326008)(52536014)(5660300002)(2906002)(55016003)(38070700009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3JkMRZYi1cCRcDdRGuPl0dRjXwmLGl4w+Dr+mUmdwyJun/3vlJtt8gKQf51G?=
 =?us-ascii?Q?SioDEZab6oIKWO9SVsMl/Ckz2wZni3rMhYCa8akAESMCgpZNkEDLybtncraT?=
 =?us-ascii?Q?RBoLXF/3p0ELvHATp01WQWhdCXRbU7e/ZtHnoddaP5MsKyDkOyUWyVS6JYat?=
 =?us-ascii?Q?+VJeJkGBQVdBDmTno7sDgoal3TUOlXdFZYuppEENoi7NiFNPCbea7wXtgvKE?=
 =?us-ascii?Q?04QqWuHUp2J+lbymnvnFKKtzhuWa0uii8WvXZ+hHfYmr7o7bjf0A5sKtMoA9?=
 =?us-ascii?Q?98Hrj8ibpR+2U0mPSp4bjO6eWbUOdHUUgl7XqM9FdtfJrcuppB8IIpY6Iv/x?=
 =?us-ascii?Q?xtBX+CRsaoY6eAclZqEeu5rClXG4gQTJkp1pWmEOt9AwBJIYtn2f8HtSm0kH?=
 =?us-ascii?Q?SvofCj1jGqvXzJuOBK+UFdjtyqhSSRnMtw0eODLq/moBCgXMG8u/BBG+lTOe?=
 =?us-ascii?Q?G+H8klGwS0uOmJzYYciysSwf6n5J190IQ9HLG3gqg93ktSPaSlemEzPg1pl6?=
 =?us-ascii?Q?h5UNODz3rFOh/EpgPGZZqnUkCTH90JCtXYf6E6iqLlDP7OjPpN26BSzTaMXu?=
 =?us-ascii?Q?25WzFQgxojvyvIGtcz1Wu5TwaAkI0uXaHQc0nAl7gBXx2W7gtESiaVoXIM89?=
 =?us-ascii?Q?Xme6WLOuFiV/C5v+AsKZJQSaqoIvkYsG9Rdj355p2lSwpyVztS20Tv8Sh4Tn?=
 =?us-ascii?Q?umrlPpxq1Hz25a8jOvLw2xACo2Q5anx9UDL4Ux0pK9A/qDsuDlKB37JQgb/e?=
 =?us-ascii?Q?RBiSgPAARtpcmidWdyRFIFjctiA0p9xZSaRc8/qed0USbd8V3IDJgY9TJMSL?=
 =?us-ascii?Q?pVHKD+PZylVdmjxAMLjj85SMuaWmkm6hZ6qi+FPYnjcgh2WZhnf2D7/74ci4?=
 =?us-ascii?Q?GuUHASS1v6B1LcBTPWDknAnrjCLGWHBwOa6l1xf9HpySeKZ70DaJUNjDbcrm?=
 =?us-ascii?Q?Gk1JgV1eC1XbcVFw1fk97yYIP4ubFfTy6A6z9gm1Smip8jDDoUq4reJy8fTE?=
 =?us-ascii?Q?SM5qjK8Di6m1ZAe1AIw5nBKjjIdfmoJiP/OSkfoACgsSEXkNcry90PpcQI7i?=
 =?us-ascii?Q?gvVY/d1zwgey31HeXY7IwO0O/XX2C9qpYbQ23sKQa6NF1UKkDuIG7F1uUgzU?=
 =?us-ascii?Q?VnOEvXTC6kXwhhiuf+G3I33hfoA2HQuLW7ipgX7kkWPEr47uAGYhsqOOR5zV?=
 =?us-ascii?Q?UYMrPmEXnEuiYXTOvkQhmCrbZDUUYRuzyCzftG0n9NA/q0InqIi2EWc0A4qu?=
 =?us-ascii?Q?q/Uq5SmZP5zTybyZ9DHOoctiEChvd9sZPCz/5X43wJl4fmx5y90m7It3BXsF?=
 =?us-ascii?Q?qIxlCKyowLgQJj7SJWMD0h44jcUtTPAn37CXhc2PjMjZbPwM7va7+5a9Nzyt?=
 =?us-ascii?Q?gpet7jlIdGX1EsMgGuIiK1sX3nzQ8LB8ggKioCKiTbsAEc3X4hDIrHG9D+zX?=
 =?us-ascii?Q?9qJk3TfU1KxWHSSyBbpmUVK+Llcbz8P8aFNZfm3+Ft8Y/JHl/cgovQCQU/0h?=
 =?us-ascii?Q?2vYSLrBDCqg9m4Q89qpUrthrGIXwCy0qMO6+o9KNZVMAopJdBY8Ru9VUPwJY?=
 =?us-ascii?Q?mt2WdMVAUOG+2w/kZHYdfIvpD4HJNKjvgnP0+E16BrT/+h51+Mr2WxtEMow8?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb732d67-2b7b-4a7f-b3a4-08dbf7e67fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 12:09:16.1185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/KXcWeZWhqaFiiOCCj9OZZT0XMfJ8zV6WHFx2FMkfTUADOyAC8Zgu6jRFiaUkiGf0QEteF7vLjfAOg+5LMiCppN61q4xiQnhq1jhfkG1pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11009
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 12:09:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13936

Hi Pavel Machek,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, December 8, 2023 11:39 AM
> Subject: Re: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
>=20
> Hi!
>=20
> > This patch series aims to add RZ/G2L DSI support on RZ/{G2L,GLC,V2L}
> > SMARC EVKs.
> >
> > All the patches are cherry-picked from the mainline, except [1] and
> > [2]
> >
> > Without [1] DU is giving probe failure as the encoder is not able to
> > find all the connected bridges due to the framework changes between
> > mainline and 5.10 kernel. So just restructured the bridge handling.
> >
> > IA55 IRQ driver is not backported to 5.10, so defining it in dts is
> > giving warnings, so drop IRQs in patch[2].
>=20
> This series fails testing on x86:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/5706662029
>=20
>   CC      drivers/hid/hid-lg4ff.o
> 3346In file included from drivers/gpu/drm/drm_bridge_connector.c:11:
> 3347./include/drm/drm_bridge.h:903:34: error: static declaration of
> 'devm_drm_of_get_bridge' follows non-static declaration
> 3348  903 | static inline struct drm_bridge *devm_drm_of_get_bridge(struc=
t
> device *dev,
> 3349      |                                  ^~~~~~~~~~~~~~~~~~~~~~
> 3350./include/drm/drm_bridge.h:894:20: note: previous declaration of
> 'devm_drm_of_get_bridge' was here
> 3351  894 | struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
> struct device_node *node,
> 3352      |                    ^~~~~~~~~~~~~~~~~~~~~~
> 3353  CC      drivers/hid/hid-lg-g15.o
> 3354make[3]: *** [scripts/Makefile.build:286:
> drivers/gpu/drm/drm_bridge_connector.o] Error 1
> 3355make[3]: *** Waiting for unfinished jobs....
> 3356  CC      drivers/hid/hid-microsoft.o
> 3357

I can reproduce the issue here with x86. I am looking on to it.


In file included from drivers/gpu/drm/drm_bridge_connector.c:11:
./include/drm/drm_bridge.h:903:34: error: static declaration of 'devm_drm_o=
f_get_bridge' follows non-static declaration
  903 | static inline struct drm_bridge *devm_drm_of_get_bridge(struct devi=
ce *dev,
      |                                  ^~~~~~~~~~~~~~~~~~~~~~
./include/drm/drm_bridge.h:894:20: note: previous declaration of 'devm_drm_=
of_get_bridge' was here
  894 | struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struc=
t device_node *node,
      |                    ^~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:286: drivers/gpu/drm/drm_bridge_connec=
tor.o] Error 1
make[2]: *** [scripts/Makefile.build:503: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:503: drivers/gpu] Error 2
make[1]: *** Waiting for unfinished jobs....

Cheers,
Biju

