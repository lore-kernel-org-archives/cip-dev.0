Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1FEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:42:26 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.94])
 by mx.groups.io with SMTP id smtpd.web11.9071.1687434135370614160
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=DRw1r4Z5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.94, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjksC4+gh4z6hr+oZD0LQJ1GkJSHAPU98etfUpCjktTG1lVX8TNKKOBkowxXg53skEX20PIa0SmYuNvAd0elj9QrZLEiYJOPjGC8ZKDw+a//xf2LODttt0f39HqKfkqglc/YaAVctcBr7zzk4r0SIk8DWJdaJbRuXJD5WgR6BLf8UBMiG/Qi30GSgjdFpNzO84r6XC7xbe6X+PNlmgjAEwzSDDaOtvkqjfPWi8hH62qHG0VmGtaHdcZhQqDwtqsrhkXNxnk0Uppc+99bWs6m8E3H9GKitTBnKWOKg2+5v8vmHpBGWyhmboiLnzBf6qClcbYcYnWjDCSPyqaRCkqR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTOEkfvZCOMH3oWYxD+vV81KgiDOMbReFc2snDUi+mo=;
 b=BkFsvX4PqsSLvz/bVaALp00gEp/LRs7pX5WrCquxdQE73G0QrcCQ+UI/KsTWOF6SdAf62IJ2UDZ3BGl5HRBsrYFS7a67ID2/UCiIfi5HRbkw8q4NQlMooY8v4cTLVHlimiaZNx3d2WLa4GNeWvTT1n0So0GcWNN48jK7+CnvQ9qT9gCTB1XqCy34JR0H7rJGnfCiNPIAyz0oMZW2H8b1GpOer48P0Xq6f+FoqFxNfBqreUFjeVA1pWD7/PvVAA3Xmx82cexfVN8V3HjJd+yyzVnie8xCuphvPohAYAhNA4IyjBxEroKWyK8nznf5TCb/PBa8/5FC+bq30T2LuI5bSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTOEkfvZCOMH3oWYxD+vV81KgiDOMbReFc2snDUi+mo=;
 b=DRw1r4Z5GIF4s8BxzGll5jbCr4RdSLmHJyQqa/IQeepjAenAi9VaiVJgEWFY4mvxG2f5R1B82S1IcplSTXWOIDjlq0kcfisdrLC6UeqFYpwM7ccucP+hwaVSPuId62Myeu/CmAYMVuO3A4cebJth5tlgO2GhIJqJwEKYFeiicOw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5550.jpnprd01.prod.outlook.com (2603:1096:404:8024::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 11:42:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 11:42:10 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Thread-Topic: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Thread-Index: AQHZmEveAqDJseRZIkWtuC2wZy0K1q+WxJcAgAAH2HA=
Date: Thu, 22 Jun 2023 11:42:10 +0000
Message-ID: 
 <OS0PR01MB5922D86A7D08B5CD0F6240308622A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <ZJQs4hqSSX2mU4ZF@duo.ucw.cz>
In-Reply-To: <ZJQs4hqSSX2mU4ZF@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5550:EE_
x-ms-office365-filtering-correlation-id: ff949541-e636-4378-8c76-08db7315b6cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uKpAG8gvWuRH/5VWoSJ7wuoSMqD01LkJz6syGdZmeVvNSHNq/50t8zuo67h6SwaBaVEQFAq/fLcsy2xVwxdfc2IhWbhVU1IDVUjzviT0FoEKzRgpjMfeE+8+pPLGd6HPic5inXdiW/Fcy/0ZIv4shtZwLUOzp8pW1Z8qD/1bbzVmMdgnvXSAdXBiyuL9/Smg+fI9y8D2XnVnQxKDxGtROdxOUduuvGaBZjhymGBCauEYatPpEXZr6a4nbs5wZAM6v0zcQGfx+71AEj910u3ZQfASM1fWSZb85XXbJnEfI9T9/3AontVWJ8MKTIqObfyG8mGSLZ195ufLspiv418cOUGZRrnpGr6DWE5xvJ0QCx6GMBch9vX0OutID0WU3GgtZ4T7sHMChdykUNmk5t6vHQ6Cntcy5W/0czlbIOm9uxNkrYuoSCb45TmHp0fbJnpPEd5MGrzuLMbFjnueiM6N7ZK3w/Af8R+ZhpYDqXdTaQP8jXsHZsQYxZ802i5N1RGd5OwM7IusdRtG3hH82XU1MfBq45mGEubJprU3Ux5L2jNwr2jg1fJSewHBmAZZaBrxteyVM1E6yJYF79XYDW2Opq2PreC7kHDEvVOOGiFdGrY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(71200400001)(478600001)(7696005)(55016003)(33656002)(107886003)(38100700002)(54906003)(316002)(66446008)(122000001)(76116006)(66946007)(4326008)(66556008)(66476007)(64756008)(6916009)(6506007)(9686003)(186003)(41300700001)(8676002)(8936002)(2906002)(38070700005)(5660300002)(4744005)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?EFsTgwMipuRLD0vHCdBn0xNepywTz4GgJe2qN08IOhrhjOkH/w7Al+ZOllnA?=
 =?us-ascii?Q?ChtfsAKhYv/mq3MtaTIlepSm4rnxyae1XzdN0kMLZMN3rk2WyJncRkqpVfqv?=
 =?us-ascii?Q?DBC0/7kiMEoBNzSdV79iUet0FRPAm0vM7FVjOdm9g+nsxro41EgpnCFvXoCS?=
 =?us-ascii?Q?NHdREAS3UzFOXJU36o6esOcDK9ZVr04CjIbKHFdXsUbkNOBs3Gyz9SWmwwJw?=
 =?us-ascii?Q?OthQ3eKxlvk2SxcbYsSL7/9z1sO1ubn56epqocv6ZZGFGMJwt2fxdrB0yqWI?=
 =?us-ascii?Q?alFhrhyMAPqPYuBNAyPYFcwXTfQO28zpLkjwAXItqfKlkWSVv7Hbzcp9zmIT?=
 =?us-ascii?Q?+9GQnUdB1+qAmOFYe1aULCr5hxZVUxjHIRxVdUu3ZBulZEjR6VPRjlPcWXtd?=
 =?us-ascii?Q?0JNNeytKVzJra2MjJcj7soo7zO2lUTSloz8h8xQmeCneVwQSQV1ueb85D1vB?=
 =?us-ascii?Q?2+VPOpjXDYH8+VzdmzsbjS/3rFgScSbNIrFjfMwdNzJYKnn+qu3Cfjfd/3uK?=
 =?us-ascii?Q?AQMmQq/PwVZEQTxxvJ9gq4gG0l0385jXSVW6/AfID04DX5fwki00BZWQ+BDs?=
 =?us-ascii?Q?XrEKtfdmw7RWgqTyvFu3APur3gaPxp58q8lP9AkA3jzUuOE7qDcrGPRXo1Mb?=
 =?us-ascii?Q?aMIAUk/n1eGXylYDETcXYzmJdwFH0i4+E3zDtugnd5iyKcdVRrx60xhk+9gY?=
 =?us-ascii?Q?y7ePbF+6NWhGzfcvdx3Ol/+MKZzYwGzw5KLWw4tDeBiyWMz4UGl2XO/GWrkO?=
 =?us-ascii?Q?rzEUZYzUZAWpmi5fj8elhdyTz0kstQE1ZC+Dsqw71gEZ0SqxErAwk9etj+sN?=
 =?us-ascii?Q?fZZ6jICMtXNo3MJ3Yd2C4k0EVlvJxXBonXGkb4mo8orCNlch+Sd7BpoVZuQn?=
 =?us-ascii?Q?T43o03KdjZqj2wYylOEV3PSZ+x7yeqPpq9WzAA3dotOghR6WpnsQdX/CKcjj?=
 =?us-ascii?Q?YA24ClIUKLI0Bfkm9R2lfwVsTBC65Y89AujznxpofBMlxIEvqtMcOYnCUI/V?=
 =?us-ascii?Q?uXIGd95N2XnsimM1uKP+DI2DkwSsgbWaExVttJF7vXQeeCoFPi3QfbIVQ2Vo?=
 =?us-ascii?Q?qb8NXksKZqgi2voFOzimNpbOPIEO/4TE49yhBFuJnvKcQ4O6mAt/v18+mv5R?=
 =?us-ascii?Q?HSH3cEm8D2cknZhd/XjnK1ndZ0RKMYPyDhgV7p+2uRpNcwB9nBve6nfpPoxZ?=
 =?us-ascii?Q?zw4mrPnPgTOCOlcZGdzq3EqSlGpvfSjwAjK4xzzP0qt151TClk+ehYzGUgQ3?=
 =?us-ascii?Q?ULJSGUhiDhGzFLbPfj2RpCevnTzO5Do4osRgw+LmecfiOr0MWX0DPrTw+eVr?=
 =?us-ascii?Q?R+hnZDDny1HMtqIzFC+v1PobTqCEGiF5Wf/fRdkP3GrC3STwb7h2elO3br0+?=
 =?us-ascii?Q?dLAoj59rjY+btawTBLDdlFMHK70hAm64wsUhiZK07ABGRpiWBkX53A5x5+It?=
 =?us-ascii?Q?w6jSRlbQYO9dGK8zt6kBBcnXiLf9umF1x18dW3+faWwAzsekJhBW9Bl3l+As?=
 =?us-ascii?Q?HMtfMP/8RQg8Znk9OvT+gHzpEbkTwvRtl92aezew7ZXQlFqRPiPT9SeZdpDt?=
 =?us-ascii?Q?31dwdr1JzwAWPe8fqfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff949541-e636-4378-8c76-08db7315b6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 11:42:10.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6FOKRzy3viXlfR3x+r90gEmqdshjqHHOAee3MdHG9roX15168u2teVI/Kx+TQnPdaOrIqqd3P9hyn+URQyq2oiTAQHqjd1VRDRthxrrEYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5550
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:42:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12122

Hi Pavel,
> Subject: Re: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support
> for RZ/G2L alike SoCs
>=20
> Hi!
>=20
> > This patch series aims to add MTU3 core/counter driver support for
> > RZ/G2L alike SoCs.
> >
> > All these patches are cherry-picked from the mainline.
>=20
> I went through my comments again, and I guess they are better solved in
> the mainline. There were no other comments, and patches pass the testing,
> so I applied them.

OK will do.

Cheers,
Biju

