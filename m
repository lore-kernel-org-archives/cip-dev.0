Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC2EB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 05:30:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.52388.1688448628766219432
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 22:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3645UIUu2420210; Tue, 4 Jul 2023 14:30:19 +0900
X-Iguazu-Qid: 2rWhW3wiO8y3paL9Wg
X-Iguazu-QSIG: v=2; s=0; t=1688448618; q=2rWhW3wiO8y3paL9Wg; m=nIgVQ5u+Uhks5zyenNKVWz5z5jyCXAIJWNFUAMFmNEc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 3645UGQW2817528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jul 2023 14:30:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVrY/nRjsrSLgqTTqXItnENoyHnysdTXLu9u6WqApoOta/UdQ+8lz60yUsiMThHJr8c1ci19YCgzkp+VQ1REe6W2weZ1ziSxYgQxYa1lwQMPhBfnMJjUgrj85a1KNOUm0fxjiCYqw/Q/A5J2keDDVyEAM4JyorGJ5fDQvvwDaNbSteqvPCHCHKtKdGrsV+24PrgQ6zDZgRI7CMDewV3RhrdOZ/XS5ZsCfEcT+khZTpKYztq9UEB1osdaUoXNtRDZ90sXcSfSSxFU9953ouTreskLDIfg7Q16/62t7JN/MxHSKxeSXU0g9HXc4Q/JSNgozQa2zotP79gTj4d01FWMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkd6EGxVuRdLVQslriZK8uF5+swuxuwUbrp015EzelM=;
 b=oRLzfuZLAILxJPNQTfH3rzsNLoWPtJBvUl8nvE/+Nn1/4AvWCI8YSPY/HwormpoNy5sbCdQAuZI6NI6z750fMdlwVlT/or/JxyRVuhZRUUWkymqlqjhNYjidf8KH9nwcVKXj3n4P8UKdfcJlgS8IKnvizvlhq/FPPddSEaogw6HzjHYl5VjS/gm59ETQKBK92CfP9XoOnk6MU6EskTqXD80zD3J86a/CdDKiOwP20Fd05MmtmFGl9z+euYGZ+W2DlcXhysI2OYeRGn2imcM2xoHcZHuBjfuO8OTlhbWfrABprQ1cJL+R//j0Ch6VYFxvWmoQa3EHFisPyyxuyFWvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Topic: [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Index: AQHZq2sXQFmFKTN/0kK3O+d32Y+Bzq+pGB6A
Date: Tue, 4 Jul 2023 05:30:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94201C9E1FC1A2DF030AA86D922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5869:EE_
x-ms-office365-filtering-correlation-id: 9936e99f-8c2d-45f7-30d7-08db7c4fbd58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 46GrXvrIos6964dtcQkoO1ja/5Wu4kzTFIcvXijtw8wOlEeZneeVOaVeqHylfI0UW7dzcbrPvC3EjqyWb7zXTGhzT3wPnvIpVmJEYcfXgLb/OnzuNhrHFMdvd9HN27GZeOX5mpgT27660FWup2vbb73+kewA6rqNcWMx1+CG+5yt4Yol8VHcqCOtsUQS3KXriOVrdal0rKfa/gMS/YqtZvS4VFbZGmyucTpaDEgEhj2Xc1+grWTPp/6DlVKXFCV+DNi3F7f28W/+lH1ZygQob0BWr+OSonufuXrtiPVux/Mw2XnRwEKoI3yVIajagWGXXdSMoZnEg6NX/ipJwyadTgrLmxQFWRBUbsyzu8cKvDI85sfNadyG6dJ0sjDNHry0z4KtlaSGZCym2EVnvEerfWHLgLdShDJrBkDRB81vmgmBIDk7obyUEWFCh6ThPTLOAAMTmFz5X7YZH4qrSr8nxaFu0bsIH36R86vr5ZsVLdYV+zrVozx//tUqKyIP15uHn3q+Ops8FKH9TyOq2XIrH00rfPG8ktUX2w4tneqMTTfe5Q8TXGMjj3Lp07BOl5lcce1tJBTvhI8FWlo9W0MKAbsSLX/x+LbM5MPO5vrCYGEj6Jid8TiBuP/Mp/MYmsXBiBfocaU5wppPHx7e9McbIg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(26005)(478600001)(9686003)(966005)(6506007)(71200400001)(86362001)(186003)(53546011)(38100700002)(66446008)(66946007)(66556008)(64756008)(66476007)(4326008)(83380400001)(110136005)(7696005)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(4744005)(41300700001)(2906002)(55016003)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aXBEV2gyRFRlQVp5T3RrNFNLQzJUUzIrdTRNMzh0b1gxZTFJZy81Tytu?=
 =?iso-2022-jp?B?QmcxWEtKY3A5VE5lTGdGdWlPdUduWUdHMFRaNnpNRlk0c083dWd3MVQ0?=
 =?iso-2022-jp?B?U2lBd3F4cnVOcjNmRUV2Q2FkYW0yMEpqNVZNMy9JdE1VdVVFOXBiQnRX?=
 =?iso-2022-jp?B?cjU1UEJrTVY5OHc2UkFOelIxMGZQVTRQQS8wYVdZY1FpUGpQZVk4WHV0?=
 =?iso-2022-jp?B?cTlTUVdMLzl6aXJXcXZGdVZIM1NXbWhtby8xYjhzdUV2QktTdjdBaEZl?=
 =?iso-2022-jp?B?cHMvRlhRRVJwNk1DejNmWExzMDE2eFB2UkdxOHcvYnNaUVMvZWtsM3ZM?=
 =?iso-2022-jp?B?ajJKaUtLbzQ2NnBVQmlJZldrSmdEWG1xb2dlOXNjNlBDWE54RTdvZTBP?=
 =?iso-2022-jp?B?dUwxZ000VnhTVHM5V2pSRVV0WUdwTURmaXlZMDc3OXE3RlNRYzVVYTV2?=
 =?iso-2022-jp?B?T0d3NFg1N3k4Z3ZvcG9rMkNnZXpUNit0Y1o0NTFuSFQybGN1bzNuK0h1?=
 =?iso-2022-jp?B?Y0x6TmN3azlZeFJMLzRmNlFzQTZ1YnJ6ZXVQOTZnY205N3FyVzg4cW43?=
 =?iso-2022-jp?B?a3RGQTgvZ2FhSVQxbWdkMkoyd0F6VllDVW5CS2ZweEY1aEQ4ZVFib1Za?=
 =?iso-2022-jp?B?dHprWHhwb3d0YURtelREMDA2YWJkcTdvS0N6OG55MUJkUTByb0ltbUpq?=
 =?iso-2022-jp?B?Qk9Qa3RQdmpMMDBuUEM2MjJYU1AzaHJIdFRZQ0g0T2F3aUZ0NmExdGhS?=
 =?iso-2022-jp?B?cmVEbGJQRGczUCtxRUVlUnBXZlpWZVFkOHRCTGJWbGswRSsrc1NFa2p2?=
 =?iso-2022-jp?B?WlA3ZGg4dWNCMktCMXoycXpiR2VQMExZZU1oblVDR1JZSEdXV0poZHh1?=
 =?iso-2022-jp?B?OG9UZ3FMUUgwL1p6cXdGeURmd0dQQXdERklUUEQ0OWpJQUR3TWtIbVRL?=
 =?iso-2022-jp?B?MzZuMlZBcWVISldzdlI4d1FQZHdvS2xVMFZUdkZlekw2Z2syVkhqNFR0?=
 =?iso-2022-jp?B?S3RBUW1JS0VIYllwZXh6cm1IT0RpUmViWnhyYmt4OHJ2TGxSck53clRG?=
 =?iso-2022-jp?B?bmpoeVdUSjRNTVdsVFVlTUU1NEs3MlcrTTcwRG5vMnN2ZS8zb3F5YkJJ?=
 =?iso-2022-jp?B?L0lxeFEzejN1UkMwRFBMMmxVZFRScG81eXIySVo5eWxJb0YzL3VTc29x?=
 =?iso-2022-jp?B?VmwycXFBVWdacDU4MkxKd3BNU29CYzh4SWFSQWJKdVNIYXNpT2xLZGVX?=
 =?iso-2022-jp?B?THBjZmVkRlQwR0tBRmQ0aFRSQ3hZMnBYR2U5UUZCWHY3VERBdVlrVzNr?=
 =?iso-2022-jp?B?R3ptKzZjVGZVOGxPSW91TDZzUDFsbWk4ZW1HWjJjTVZHMGpRZ3AxZFpR?=
 =?iso-2022-jp?B?YlpWMS9HYkdxV2N2aGRDUUlVS2hYdjg2a0FWcFJMdE9aTEFWa0I1Qkt2?=
 =?iso-2022-jp?B?VFVVWEVwMjRRdjZ0WmRiVjN3b2VIVVBBTXlIYXpXekNDNDAyUUg3c21R?=
 =?iso-2022-jp?B?VkdkS0Z2Rk5JOUZSUHAwb0ZjQmVxUTBPTGRJOVptRVRXOHFLa2JKczhs?=
 =?iso-2022-jp?B?d2dKNWw0RmxxdzNLQ3dyd09GWGh1TWZxQ3FhSVZROHczR2JGTkRrV1Ji?=
 =?iso-2022-jp?B?dGRKU3ZXWERTazQ3Q3haZXNxSHM4RU04eWZieTFzSzFLbklkUHVOZDRr?=
 =?iso-2022-jp?B?MjIvUVA1QWNoZ0ZCaG1ZemZuMVhTNHI0enY3U0VNbEVVNDNmOEFUcE9W?=
 =?iso-2022-jp?B?VktJV3gvZ3o2c0NnZ0txcGVNK0RXYVlBaDlNczB3UnA0bnpTRE1BVVJR?=
 =?iso-2022-jp?B?OVVqRWFaaW92TER2M09Ocnd6WGFMaGp3b2UwV2Mycnd2Q2pHeG01N0d6?=
 =?iso-2022-jp?B?VUZJQmgyNys5QTJXV09qcUVlN1c5SjY1V2JUVTE2VG1hNitrWTUxd0xB?=
 =?iso-2022-jp?B?TUpuOVB4bmxkQU5OTkUvSnMyUHNKeHFidExiUm5pNG5XZUsvbUdRY2tG?=
 =?iso-2022-jp?B?WHQva3dDK2o3WDZFUWVuSk5tTkU1V2h4bDNUYlk3Q2U0ajdNemoyS2p5?=
 =?iso-2022-jp?B?Vzd3dXFGd2hHZ1czRENXUGxNZEJsS2hoaEl4SzAzdXNMVVlubEdlSS9Y?=
 =?iso-2022-jp?B?anpnQlRrcTFRL1Q4ZCtqTms3d00xaEhwL2JFQWVhdkpHK3pJWmhDK0Vs?=
 =?iso-2022-jp?B?dUluU3ZJb3psSGIxMDNFOFdGeXM3TGM3NE56KytFc1ZTVC9BaFZneG1s?=
 =?iso-2022-jp?B?TElXMGcrYXhDYnAraTBOZTVoOGh2ZlR0OEcrSElLcURnL1FNbmlNQWx1?=
 =?iso-2022-jp?B?M0puWFhJVW5qOE4rVjZ4dzFINzVkQUMrQUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YKM2rS39woy8i3TWzpondiYnE2sRYWyWd1k+BWoo5Zng4VDeVatQbrMqayXMyUPFL1Q2dZXVqwx2lSEIlmEpAP4SKBaQGxGJs2cUyqiXaXGk4VFIqm19Qs3afR/TyVH9v0PeOa963FQohVHJ026USMtVJ24Dd1SbYmqNqC3LnJ7XJdxmfFi/VhUYDs18uRyOKkDZMd+sk9388WRVOdbvfCpB0hLoyYlVNub+ZoAwGpzAUBvoPk1Oj10P+XhMivBwQZhlAzDXq8xslXG4trl3YNRFxtcVDAN+P5oWDPeUZhnBWtjuwjQgorXkUaJWscL6nirftht+moW27iH7q649bfjo9QDd7EYo8HZDmx6aHq2v2nhXJgR7a2vHMJrxcnIwceXB1322rUj3R+JfkMsEyHFLEHABbTdY76ZXGUrGDIb/iQrm0xCO32QpNP/yWlIGIntcrxFr4PO/HVMtaQiFd1aVR4gCH0nnRI8ekp68OV4+TTeQIlSv+1rnKPVRin5r2YFnbvRTfNF7cbYitUixmMhqzQgdoacmlmnt/FZS6U59wHIerlXKNbhf5AJsRzjO7LViD2Me9tlKmKaO+9Tg0aNTxDpnB/yUqJLJaow49rUL7Ton0GiZGN6tWM5M4ezVbZX2XVnIQodAZ+dCoT+6hQt/x2Rog6JMBr1yUJ6vPE3qUC4dTeJy91YpvLPHNi9AG/aevh24JA4tR7P2RBvKqXgPHFw7MzGNQmWeCOobTleaE+Uz2JRjZJfpKsvQB26IVYAGUAdZA5W+RZ6/Pl7Muknyvh9pAoigec2g3Qtg+EZhK5dUTOxLIMT9w32Cf4dGXbxB+cpRZKrtCJpDGsJPpn4nDGGeXT85ppZTllXfx1q9PckTHzXufwMsaDGpA+uVD6SCE8grVDujN8zKge3bYQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9936e99f-8c2d-45f7-30d7-08db7c4fbd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 05:30:12.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhDklqJqSTVNqfulThqs4eASDjGkVG4Ja14xR4871cQwSCqXUwp4Rte/xelzid6xq8rOl+llCAAbR+fFcMd9UppiUirB6oswd00uM4tbOXEdMvZ6T1CpvM9G0yYF1co/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 05:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12201

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Saturday, July 1, 2023 12:54 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
>=20
> This patch series aims to improve RZ/V2M I2C driver, based on the feedbac=
k
> from Pavel.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Biju Das (3):
>   i2c: rzv2m: Drop extra space
>   i2c: rzv2m: Replace lowercase macros with static inline functions
>   i2c: rzv2m: Disable the operation of unit in case of error
>=20

I reviewed this series. Looks fine to me.
I can apply, if there are no comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/91996=
4303
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



