Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFBFC27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:23:38 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web11.184669.1692271412326506735
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:23:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=kHqasVwg;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.123, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiCiRCo8qJZxN5KQZcLibMAyqM3dgi27lZrA+v6ho96zy1LOJdnZPUkguu+jgfoTwB3PjanTECoa1hPDzXlutSsSTQ7Qr7Jgl3GBeJZR78+Ad0NBSzRI27IYZvLm8BqkJ9bSsZSkWmfsiKzRAnAcS1BR6U85dJgMWm2Und4OatZuIH1q9WC3FGAc4JttXk6Fs4I5FZ3jRCT9gnlpdvSWmhieQXhWIzw9wp0qA3NveXKSguTAKqEUIJVd9/b45DisYLjL2F35Ofkf4uqvX0GxYrSPMQDvFmO97syFbQasb2R17R9vRe1UTapPRqw4uVBey1ARfsFTC/ceQSGhGSL8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FAcQBUnZ9W4FtPkim+U5AvCZvx90PBrhOUmbIIQzgk=;
 b=dbSadb4AqSjNtYtYD4cXrS0pRkaPr0AYPZunPUK0s9QFBOyr21rBRQNvQYgQcnQK/TJlcJAT4ysFSa9Wf5Qb/u6U8b8sWz9hHeG3+isRxHGU7eKVGwpGcL87+917H0NsPGq5y/gO4Q1BpQqbpWATFbCrD+k0s0Q1Re41KjxdaTAievvED2YOVKIvL/133iMwDe1WX9sZpInPtHer+JffTIzxVXwOu95C/AWxq0Rt53eTDAshVQtQuebvDHpkVSRM4rs6ofROHHDjH/xPVQ0DnXMyRbR/D4MncrsjaxzzD2FX2nbzt4E7jv0ByuxP6g/Jceq9aaggnLCsFHp2Ds6Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FAcQBUnZ9W4FtPkim+U5AvCZvx90PBrhOUmbIIQzgk=;
 b=kHqasVwgp8M0TU/1oUONMILMCqgZZeEDzeLfXJc19INquy1xSp8f34xW4WRImeE4UvDtm7A7KcZfWiZCdI07X2Y6He5luSI4F9Vc++o3ohRAftTs7Jm06xrO2lXIR3z0osckmez+ER8P8dhtHkfDdTmI65gTCfYvb99GuEJ8L18=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5787.jpnprd01.prod.outlook.com (2603:1096:404:8056::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:23:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:23:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 04/13] dt-bindings: rtc: isl1208: Convert to
 json-schema
Thread-Topic: [PATCH 6.1.y-cip 04/13] dt-bindings: rtc: isl1208: Convert to
 json-schema
Thread-Index: AQHZ0E1614nC9yOSJEChutDNOB0fxa/uVnAAgAACt8A=
Date: Thu, 17 Aug 2023 11:23:28 +0000
Message-ID: 
 <OS0PR01MB59225C7AF6F4ECE30E4B691D861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-5-biju.das.jz@bp.renesas.com>
 <ZN4ATB1T3/wkN+Vo@duo.ucw.cz>
In-Reply-To: <ZN4ATB1T3/wkN+Vo@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5787:EE_
x-ms-office365-filtering-correlation-id: 9c00c8ca-e4ec-41bc-a6e5-08db9f146142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1Qpwtw7qS/8Qf5srD+RikfyzVIW6pdEZruIJf0XFnZnZzAtck/eEB120GuDsJQCUypy02lJUI4IUupLjc51WjCYhhrgc1P0AVcQOLnYE/t51CTJGCNW1G7lEXR7VWjaXjB/eSd28N5Rpmwt4UeDlhfmz2ZILuD9s4Kd8ZXJtmD4jWI+EBx6/DlMK+QRHfy9oNMowISoJe9/yS/iPC2QAJqkA6L8JhP0xzjy135AIq7DdVjcJzJNYNoAZjvtmEtPAnd6nsby4BNeRGZxQgolGFx7kUlWCOL+C/o4qv6PYMs6O1pzLiE94i9IqZ4PkBbIL+oAjXDOnmyyLPZ1jDN2Rc1+kyXwxDeCC9bT0HZyEXA0m8Gnta9v8RnELT+Z2RldIbVYgmyWcSHtlGl3EG9b2Xl8va17ovAHKCJKGIvusm2/XBZ5ic+JM9bQGMEkS9jJ4aKUyT2jLhKOMJULnMdveA67+YYVp2DQHF3d+YAEn1Z+hJlUNAMVl/BrRJM5VPGLAX9jovmc4EFpiQ7vdodsXA5OoOCdURewqefin5bx5/a56u2b643J/zc6/jAQj+6QpxdmtK4rPxGKwaXiTizUBva/h4v7f8sIUGLCBZ3FCwIaFZ+2Unag42VXA9k73C6Z+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(1800799009)(451199024)(186009)(71200400001)(6506007)(9686003)(7696005)(26005)(86362001)(122000001)(33656002)(38100700002)(38070700005)(107886003)(55016003)(4744005)(2906002)(316002)(6916009)(41300700001)(54906003)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(5660300002)(8676002)(52536014)(4326008)(8936002)(478600001)(966005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?t8ixbE5BOib4A/9ZtGWkj2Iw19B4vVET7P5LcoiLiOpoF/VWDF1OfMXevAtv?=
 =?us-ascii?Q?L5WPgChXO1GlF9cvCzB2gQK+K3hn/dDWi8DgqKVx70YTuaObaTC/iQutGEhd?=
 =?us-ascii?Q?+wckE0HA+h373H2Ajkf5dtYAkvan3E3hF1oRF7dmuUnpbS1Wb417LiSL1RO2?=
 =?us-ascii?Q?14xtAh4xW99KKwdttJdENqrkpag7+wSfC5JcSBrDwPNzKJo9vPdz8a3exx2N?=
 =?us-ascii?Q?3kTZIpDmb13hvUQ6XGf49oj64/01lBAvxlS4+HowQcSJA61s7jVvNuArK/Q2?=
 =?us-ascii?Q?Td36HvWGFJV0eu8NpWfk+uJK/7aTqfPTVyZwVcwEGOqkN0G5rDfBktqFGj/p?=
 =?us-ascii?Q?dY3lfTuS/Cy5LOK3lZRJ1++G1MoFsSPWA2LsQD2+kyyqsXAp8c44WVEAEiOy?=
 =?us-ascii?Q?Rq8AnBNxoj7yUKd5jfmh2bqHiYwj0iC2YgVU4LObOmuESkAK6X5qWRJ/kfjJ?=
 =?us-ascii?Q?WnGOnVXHPDMmkrtirp2x42KZRr3zB8HIRvTLInP5gWLsdT1oxsQl87PTHq8i?=
 =?us-ascii?Q?XM1m3zUqYUrr+FSmUo3YmyzAWOvW5OSe8j4YxUhFr1GKuuLmOoq7G/R0FxWd?=
 =?us-ascii?Q?9Vlt6kuKw42uSW4PDwlY4xfR1rAbK4aVXqcI/M0tFJT8Sd31rgYa8QESkIXt?=
 =?us-ascii?Q?yJ1zwJWn1dtKqSrWZI0hBqFgw1so+p5OzLfSzqG1Y4vpe8c6dsTKlL4MJRWO?=
 =?us-ascii?Q?/Nciiy+IM2Q4804FpAywBO6T781zsCNh5gMOCYYSteHMaInlcQa+cW9PymDr?=
 =?us-ascii?Q?L5zkqZXBEkJB2TPids3jBInM0zd3KJwBzFZENQPsSHeT/COkpRoAzMxtH4Q3?=
 =?us-ascii?Q?5Q5J8DrdEGukIjNJwrYOr1nyDEBXgOzio2Cm3hXzYzcwBANZ+aSDeo52eOip?=
 =?us-ascii?Q?2bqKOJftwYdENHC6DOXow+44v3Xiycs74dCys9QaraC7lkinisRs6FEw1yGT?=
 =?us-ascii?Q?HLzxzxPQyBxWvRDqGKwtqjJRmB37gExaNaEgwKWQc6xcI4xegrwSPZhwuOYV?=
 =?us-ascii?Q?btbxKhK54fwkFjrLuoAJLoAZVOS5myy+1pnBgvyfR/J74axTKQ9XnFRpZcmf?=
 =?us-ascii?Q?I8+ZUxyfyWGy/Vib3uajSv1zqSR8He7a2RbxY+6lLcWs5A6FyC8ll+9fCIXy?=
 =?us-ascii?Q?x5hBKZaFlyeA9vZtjGzTXjuau7WbCq1AsKtcZWWFNUHpYlW2BfuU64uku1lt?=
 =?us-ascii?Q?NmQ2Ef/iN0NqYQ0moH/3wFE7ddKZWRM6uhUe4As/vHCK5iHHu2439Yp6sr9O?=
 =?us-ascii?Q?bQlGREkTVno3Qzti2yg08GHIs4t7jo2tDrH/XthBYoLvmuCgmX733oBdJSkd?=
 =?us-ascii?Q?ZcBXGuZJwswtaIojSZooRE6xTMZPbAnwrIv179os8Q1NB6Nx0Or+HPvwKaM8?=
 =?us-ascii?Q?N0QRHF+tkYN+9vTwBKUmR5LSM0CCFgwODaJJOn/uP1FSh9w2mM0AaCb/kha8?=
 =?us-ascii?Q?fMFFN7MpM1n5A4HchAms8SxwfcdBKSUt4KbvC/vC2vaDKHg1IXyqxf6tQfJA?=
 =?us-ascii?Q?FvWEigw+gqemk8KxiNbO+kmu+FIhDidaOWpXZSdYzg9fw580j/7fa/U2Y1uC?=
 =?us-ascii?Q?JRMeP4+Wf50zik9JMGzugjfvF88/dkY7yrdBfjbc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c00c8ca-e4ec-41bc-a6e5-08db9f146142
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:23:28.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8domb0iRm10WlsORe8JeBjvFNd47+FfSGdNq74xNYbRQQBe6faOIviq9dV0QzPeOTdW1H+o51vb5gIvD37wNnqwth/VlmxXC+Ws25m0cK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5787
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12761

Hi Pavel Machek,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 04/13] dt-bindings: rtc: isl1208: Convert t=
o
> json-schema
>=20
> Hi!
>=20
> > +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
> > @@ -0,0 +1,89 @@
> > +  isil,ev-evienb:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1 ]
> > +    description: |
> > +      Enable or disable internal pull on EVIN pin
>=20
> Add "." at end of line.

It is just cut + paste from .txt file [1]
[1] https://elixir.bootlin.com/linux/v6.1.46/source/Documentation/devicetre=
e/bindings/rtc/isil,isl1208.txt

>=20
> > +      Default will leave the non-volatile configuration of the pullup
>=20
> "By default driver will not touch the configuration of the pullup"?
>=20
> > +      as is.
> > +        <0> : Enables internal pull-up on evin pin
> > +        <1> : Disables internal pull-up on evin pin
>=20
> Too late to change this but logic seems inverted from what "isil,ev-evien=
b"
> suggests. Other dts-es spell xxx-pull-up.

I agree.

Cheers,
Biju

