Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACAEC001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:06:36 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.107])
 by mx.groups.io with SMTP id smtpd.web11.13141.1689771986870966516
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=iHkh+qnM;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.107, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Sxn3Wit7canGb4m6M2EVzJrpKYA53pJqOlY8uxDjRYTsBPu4SejwneFeysJ4P5pMeG1HBWMMDfUuwYMUx9jjs+f9BEm2R8E022V/ONEp5LlinbWz9+N04qqtSDhE6nKn44dcoiN+0NZZFx8DwpoYHh8o/9L0gfP+ysGmNUgJW9yGP0q+j9A63z67c+8xi+8Wc7uMVvU58EC8QsJp3TJuKKQYliwcCbhmwOYMQFUHzjK82kCka9Y0CAK0BV4vaf/QTpAezZUMpan7nxr4mLY13Ud4BnNwHVkCnI8N75wo68zUz+WlgapFu8L7lGIMJ5HqDFwInDm2NdJbzSlzbd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ7ZnNdMCySFJwnDR9Ves3QUXbCsjwyu7UObyRnknqM=;
 b=CBcXA3Mag8oeuH1kPjq+COczK5IJqSUl9vD8f/HacE/Ck0pZYIeHnpu9g9zDdoGEho4r02t2s39lzlyHB3HokZo6MaFZCPqLlxBTgv/LGG2unH2E3McJn1CDbz3CKlpX9RFUeiyA4Wdfx9ma0EG+q+DAB467SuzsCuLVOdTUS9hs6mLJqdfvUY5Y/sgn5SmNoYn7+2sSBtEyQP4NIf80Lf/y6v0PVj5NWeSU/GhKSFcCWrXRivwkAQ/1/xOtQFx48SmoUUNMTtjRqodJlvkTljuC6OWp3tbxQ2hBa2cOCoiOXO5uhxQzIAL1gJtfEkiuDoP6BHBb89Q+Zbqu+oGoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ7ZnNdMCySFJwnDR9Ves3QUXbCsjwyu7UObyRnknqM=;
 b=iHkh+qnMs4g705vpwI09KkRJku546YsaO3m1kQ6E8/mE4r/rGJTPHPcnh7Q4FpUDwAAaNNS5h5wrXt71TbI6OHdzU1vKjZZrL/rQ+HFYcKnVbCw8jrJTewhh82yMxP544P2CKD0oPEh1px2ohOC/mK0ACuPFt2Rt1qdPWhsXyTg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5703.jpnprd01.prod.outlook.com (2603:1096:604:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:06:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 13:06:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 11/13] arm64: dts: renesas: rzg2l-smarc: Add
 support for enabling MTU3
Thread-Topic: [PATCH 5.10.y-cip 11/13] arm64: dts: renesas: rzg2l-smarc: Add
 support for enabling MTU3
Thread-Index: AQHZuj4i7YkppyCV/kCViBKLI+IECa/BDnwA
Date: Wed, 19 Jul 2023 13:06:24 +0000
Message-ID: 
 <OS0PR01MB59228BC1294A698E433D95C18639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-12-biju.das.jz@bp.renesas.com>
 <ZLfZnDPNEVejsj3/@duo.ucw.cz>
In-Reply-To: <ZLfZnDPNEVejsj3/@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5703:EE_
x-ms-office365-filtering-correlation-id: 6f66c213-d3eb-4ba5-51da-08db8858f4df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QDk9Jkaa73eo0GEAn9oMg4QuLEjBIKjBMWxYlN7uOQvVo0bY+5VB9gWBW/K+8oSoMU8e8on9AXt4gIADfIQzs9O7Abq2YePVlxyu5GOnpC5+itgLXUWmycHtYccLQKiA4wdG/XpVkNFLGTBQSgJj+YP0xv9zOOQ1NWmseu7edkdg0fJ+y6ndLmUZvTm2EyWKeqjsUAJVQw87JO4GjKGzCjAWfERujsrVgRMI692UD6Vq9yxcESK2c2RzqYoyySN6FOhS0/WxOSgqARmxPVnsrU+ayr1m5Cj36D7hB3ylK0t0vkFQ/30N4xaxmwjAQxINxr6G8Kco1WEbemtWPUNOXyTjusVgf2T98yczkzGuXWNKdKIn+pySlaVkjMPQ+sx5St2UFYxf+wuRa62hftu5ojb2bcOPLoQmM/fWgjgP3sE9MCzRgO4QQXS09auvx0p3KzWC1a6fX4VpnohiPURISyfk+1x7Hj7TAx1rsQzCvwy5zLKyk5rwnJ1ZHBeo3zqYYxb1fL5HYVfO/u6hYE9dL1LnI9PFjiTR6jI+/lKOYuVUlPPdjB9HAN1MW1u1i8oc/gr6h1FbZSEtzIFBPkTjOl1pKuvJ0CYJOGW3o5+r12BcEKLTEyTUU3yon3vLg2Gu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(71200400001)(7696005)(478600001)(54906003)(83380400001)(86362001)(33656002)(38070700005)(55016003)(2906002)(6506007)(186003)(107886003)(9686003)(38100700002)(122000001)(66946007)(66446008)(76116006)(4326008)(66476007)(316002)(41300700001)(6916009)(64756008)(5660300002)(8676002)(8936002)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9MUPX2hTS1p+divGVo8TVt3Fskj5eMN/mHmzLhki/MD/QoJcXGUTTNk3EXSd?=
 =?us-ascii?Q?ZhmeXisv4rddsjOO90GyL4prNWFHI0Qy33UkFLLviM/o6631EaIpkGH2Wjur?=
 =?us-ascii?Q?CZ7Vi/JjwWd6Bf6D+es9EqWqPwqFkPo5NW3h6M9b8bmZRqjAKPqlTDWhiUvy?=
 =?us-ascii?Q?/CLZ60gcmfonBYhbqmm874NlpfZ+ZmeTHKe79CNZIvSVkCfJGMPBAQcO/gRw?=
 =?us-ascii?Q?Zt1ovdapoaHxxtbDkq1r6O03YZH31stIcut6QRD1q3AEoCFGB5JPBxd1ALxb?=
 =?us-ascii?Q?nDt6u5J2EHg9XtqWCHMuQZMFUyM2SQyv2k90R0QSVUUodVN2EwU6ScQCNrcG?=
 =?us-ascii?Q?Ehh8VNF/xvwjut9g33aeEafTBH8z+788zJJ8Kbi8CrUZ2NtHLA1S0+IgIMkz?=
 =?us-ascii?Q?FWF/wgTcb+QfmdMvSJo5CtZY4n/VoLNdfTC4g7u31ps+VpWYK+Z1atsqm8m2?=
 =?us-ascii?Q?hiI5xeNXr2FGyXAhcVLSxpAExRRVjKaYLwdIlqdVNnSnsqJBJYJ3OEfGgmZA?=
 =?us-ascii?Q?WZls8sktzvBXXzPIDCuEWan3tTEw8NwGx1buM5Q0d0DyF5rS+AfwiGT5yL0P?=
 =?us-ascii?Q?HGrrpVwDbWRDghbPcr8ZbKHE+aL4s0udknG4D1etCFdv4VaexVIQxvu26Wc4?=
 =?us-ascii?Q?Al8krV41U+EqLJ+b9if82M57XEkAEvEMZ3vYMlbmnxymdnqjh7O4W5cYYm4M?=
 =?us-ascii?Q?itaa1dbgkfcDuVWf5yWS2oOJsqlTVAE7hA1OUbssNDVg9DpimXqnJF1clqMy?=
 =?us-ascii?Q?lwslgyvyBlRm88sP9rJyLhcOeJ5y0sU3wXs4PuDWRMgxeKyYrp+tE1ah2UYy?=
 =?us-ascii?Q?0kRpeKd5N5I8Z7Wbyyy8L+bZfxzapRTWge655yG1okS4b0tHCUvyhq4Le5Kg?=
 =?us-ascii?Q?uss6+Cl3BRCvd55X454Bth9JhB56AeoM3GfOmbB67OQXnzEsH4OatPqSKJay?=
 =?us-ascii?Q?efvWhS80WGqaRSc1ZHC3rnuAxZxFLZ4+1P5OOjd5cPc6qbxG3y8nxR4RUulO?=
 =?us-ascii?Q?BpHOFZ72S/IaxUX024eaIuGP89CcI7TFAbh3Df4nGHtpVAbi+YlHGC4ejv+S?=
 =?us-ascii?Q?SgA00ESmkPUFjI3A+D1Cq5dakvO9r+0eu2jXE1zUYjyzKRZ4yxD7qFZ+BWhS?=
 =?us-ascii?Q?QPfDY+cIn0ztUPRArddQ1I/CpDasX3hdi3TtozKZe9tUQg/Q7BAl/gSUd4W7?=
 =?us-ascii?Q?jZUwdHmEc1R+RVv+JxQ7Dj8gfyLUMXvJA2pOMbN0459j/Qk+elQu42w/CNlQ?=
 =?us-ascii?Q?3R4CxMbNshMBuYU3X1hEvwvUv4sqjObZgXYIcBhDsFYOKPr2Y5wQS/w08Fo8?=
 =?us-ascii?Q?ND2qZcdtCsKeRHjeOLHQbCk2wzBOp6vGwM5gmBFfJedcd1YPdutisM7c64Yf?=
 =?us-ascii?Q?k9ULT7M/vnbGnNHlFXGZDLdyUVJ6DMJHs6fV63C3qp0O0kj9YAW2SMhSQImN?=
 =?us-ascii?Q?0N5cJIZHEyuXRKG0zqMFEs9bKApX2TxXKHAowW9SEkvHl8snY68nBK70NCyl?=
 =?us-ascii?Q?JnVwknCZ1DEe1O3CqLjKuUJtHE/sp4yioZJ8C4OrMmeCllCZr8D3hEsSlkQj?=
 =?us-ascii?Q?tv9VMsF9itYdgLTd2Z4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f66c213-d3eb-4ba5-51da-08db8858f4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:06:24.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49/C+h/BlqUFvvBkMOvlI9HgxkDBujrEi6oiy3B/P+qWyXKngxI5YvI6Wwi21RoIprJF/JcjhgHcZlAHcz21ZAsiaTFwOzwymktVaiZoFaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5703
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12426

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 11/13] arm64: dts: renesas: rzg2l-smarc:
> Add support for enabling MTU3
>=20
> Hi!
>=20
> > commit fb9341ebc7df140813d4fbc4a29fddba55a90728 upstream.
> >
> > Add support for PMOD_MTU3 macro to enable MTU3 node on RZ/{G2,V2}L
> > SMARC EVK.
> >
> > The MTU3a PWM pins are muxed with spi1 pins and counter external input
> > phase clock pins are muxed with scif2 pins. Disable these IPs when
> > PMOD_MTU3 macro is enabled.
> >
> > Apart from this, the counter Z phase clock signal is muxed with the
> > SDHI1 cd signal. So disable SDHI1 IP, when the counter Z phase signal
> > is enabled.
>=20
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > @@ -6,6 +6,27 @@
> > +
> > +#if (PMOD_MTU3 && PMOD1_SER0)
> > +#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive
> "
> > +#endif
> > +
> > +#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
> > +
> > +#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL) #error "Cannot set 1
> > +to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=3D0"
> > +#endif
> > +
> >  #include "r9a07g044l2.dtsi"
> >  #include "rzg2l-smarc-som.dtsi"
> >  #include "rzg2l-smarc-pinfunction.dtsi"
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> > b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> > index 3d01a4cf0fbe..b3e6016880dd 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> > @@ -6,6 +6,26 @@
> > +
> > +#if (PMOD_MTU3 && PMOD1_SER0)
> > +#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive
> "
> > +#endif
> > +
> > +#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
> > +#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL) #error "Cannot set 1
> > +to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=3D0"
> > +#endif
> > +
>=20
> These consistency checks are common, could they be done in a common
> place?

Yes, you are right. It should be in common place to avoid code duplication.

Cheers,
Biju

