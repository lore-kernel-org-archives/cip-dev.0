Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C1BC27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:18:38 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.100])
 by mx.groups.io with SMTP id smtpd.web10.184781.1692271115797186434
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=a3oNnEN3;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.100, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwChPYi8LX492gcQRqfVmGJRDgJsuqBO7ZtuBwYMf41f0gBkXW5XOSx/N5Zw1CqXF+LJe4fvgUVPInAfY52GqbuNjzPfj3cKYrfdJCbNmz5cZIweNYcUsfNJctopHH74gN8KxGfteoptwy5SzTBBxZ11zTZSfHGcn0kMt0pCy4c5982Z/9B1Ki4HCTrkmISVBmQY/9O2ZyGBEEdY/HJHdGjQpz2xOdIeI9IAobmAsnHasrHtEjfq1vmeFFwLBWmbeSq0hBB3Ei9HTVBzAisf4KrpxFHl8jAeCjGlXqY1vB6Q90p4aQNDTtM7XTnBE7DdzqjneEmIgLBZJ+CSpDo5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cbZnOeJdjJ2hywVMrL6fj6YczIlxzo3PC9c8jKEL5o=;
 b=l7ZfvqdiVewSgr37H8kXxtJZEL2BiE2gnIAXhRO8B5OZr66mLQCh/yCf30QWWgQCqUomqsj6CzdcmZshkvfk+gdO/divQwTDahtgx7Nk8rIL/gANAJrctVlfQThFHAwtlE7tDehDkmTkETqQy0cYwzrHslpNt5fcyYDpzwgthtBlOu2eMr7IRxUC10zbnp6JXeZmVZ2AISZuYQ+zBv8VsfAQL8YlGTSiHdEwILbki/X0LzqUsUR8lDJebTeyBqCNWY7uFQ7LSvhG2+o0/Nc2bSd2VtxPGsJL/kcAgNNYrJmYLdBRNGuBr+eeZlG1MW8bx6ODBjaJ/Ipx/K+xwM2N/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cbZnOeJdjJ2hywVMrL6fj6YczIlxzo3PC9c8jKEL5o=;
 b=a3oNnEN3JBJbkouONIGem7+rrlx5yLFPQtAdxGltuNNrgpzmAcNytC0Ibq2FQVOMFS/CDjuJvIPYtxH9KY3uSFgsbJcLFIioqv2bzWgUA8v+72MqMbbuEyPlH026Nuk0Q7ZlQQMeJHzzm/Ar4ZGKKd2DBwQRuGVdxAdmAHwUElk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8435.jpnprd01.prod.outlook.com (2603:1096:604:16e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:18:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:18:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 01/13] regulator: dt-bindings: Add Renesas
 RAA215300 PMIC bindings
Thread-Topic: [PATCH 6.1.y-cip 01/13] regulator: dt-bindings: Add Renesas
 RAA215300 PMIC bindings
Thread-Index: AQHZ0E1zRJ3lIC0xN0mDjf0fxCKk5a/uVDMAgAACp9A=
Date: Thu, 17 Aug 2023 11:18:29 +0000
Message-ID: 
 <OS0PR01MB5922966F10AC0EADA873D6FD861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-2-biju.das.jz@bp.renesas.com>
 <ZN3+bE6uTfXf0QFL@duo.ucw.cz>
In-Reply-To: <ZN3+bE6uTfXf0QFL@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8435:EE_
x-ms-office365-filtering-correlation-id: b366a3f2-1ea5-4f8c-4ac7-08db9f13af64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5DGNMmCzh6rPoEuDEUkKD8WcbvytlGGDSESxCWfDMhWQO4Q6fawAssEPmIClm76PomnLP6O2xOyD7K2TNHUsh45wcDcfNvYTpTQmxoWRngaFR4WUbmWKS0ZevIsuMtro/8E6LsPeOt4Rw65xvIDy6Iluiu+I3cCZs5Duh+YAjSwbT5OOB5Pi9qoMF6uU//sy1VLttUsfDJL/CBDcgW/bBKW0P9052BBdqzOGs4W/2yih/6tnm8NXrhXvXcfYAuIzV5K5F4O7jwhGNBwk9uqRD9sJ9yyA7JgUdyWKshjt/rk2TUzwz6MV7d7K61zGpxdfrAws5W6qIKw32SfR6CJr+r2UqRTm9YicNFXBJAZcQnU875uT1rx7cHmMva4hAV9lLOnL+unRzjIeU029J/PX5uLvZ+RtNyrFIKa2Ep5ayHe2q/wXt0cpBJEunm+UPRJfQcdz4ILTuwPxkqCoCg4M9aCY428l9Damwg/3+n37lRcrTEv+gObdgAQ2xEgMM4eG0V1Tca6mrufhjGcAJHg7bw3FyNEAyUWWpVOAWg4lBEsp2gq1GbPDeznJH7q9rA0JrFjvz9NiW/gxRr3RR0Y8+2SxZXYKPhmbU2T4bAZ5nKo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(71200400001)(6506007)(7696005)(9686003)(66899024)(83380400001)(26005)(122000001)(86362001)(33656002)(38100700002)(38070700005)(107886003)(55016003)(316002)(2906002)(6916009)(41300700001)(66556008)(54906003)(64756008)(66946007)(76116006)(66476007)(66446008)(5660300002)(8936002)(8676002)(52536014)(4326008)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4DDX/S74GhKKIM1S3KbyIjnwzYIJZy4rZx0sUBWI2Tm08OhpuynjkDf731dD?=
 =?us-ascii?Q?2u9si9d4HhWxt74ehUt3SiBPMR+57JpGumw5YbQ6mAIdTtFcZV9eNPmulywM?=
 =?us-ascii?Q?EGw6S942PaWpu31zKlWgETK93eJAk8u7gBTcGF42ho2dGBE8dCVm5ZFqiDPn?=
 =?us-ascii?Q?PWoc7OWrB8qk4axn4uZBEZZwD1oLJLIegu+RRNNAdIOJcjcjppZdpRKK/bNA?=
 =?us-ascii?Q?at+e2E0We0H1BcEA6M0JEPqjdVZqk/3kBxuTP1xfIbzdJ3aPIMGOjrSijEn9?=
 =?us-ascii?Q?ZMhFBq7wXi4pt6t1KZiJRufSdcngHor5B2/5LPufjtrpdJy0QHywYhf/QNn5?=
 =?us-ascii?Q?meoC2TlfguMSSrTM2WPufpVlet6D1cAt4m+yvmO1NEPKRwTgW44dhdsgPBk9?=
 =?us-ascii?Q?at+d18LaiF8C0/gUoczY3wtD+tBBSsYaxzfxCWOnJsl/8N7ZqW7yqxODg+Vz?=
 =?us-ascii?Q?bIhT36C4r/xMynyqp8maIvf+mJlVVxMK8c1RwbcjbvHu7ctUo12+hhUHUffB?=
 =?us-ascii?Q?cQE2vpXORsd+QVgHBALOcqwFKU7oGbEccOiu+GkW+z46f9KkKYGzT9UKCtgI?=
 =?us-ascii?Q?7/GMXCxxlkadPqXQDrgFjHCYWIzGH7aodGjtgvuG/8fbPpnndwavRkxVw7+L?=
 =?us-ascii?Q?2hl3mUoLMr7b3q5Ir3x45tRkOMTuAjAf+Ou8osO3+0+QVn3hVlzaOhWqAZ3A?=
 =?us-ascii?Q?UW3xlRSPPUDXBsfPgNBs+O1LncPZDfvFnFsdVXUPYla+FUlgdhgbkt7zax2P?=
 =?us-ascii?Q?U+v4VJzqEaSL3vKZdgXQUAAeiZHrV+7CuZgNJptBmaTdSUovK2Ri2sSM3IgK?=
 =?us-ascii?Q?BGVewJaNy1wJ16pKqWo6R322pOQjlXphQl5iHe80CM68JJ8/zZxitSOkKWIO?=
 =?us-ascii?Q?PtE2GyNIW1HNJYd1MuHT9qAr202wv4o3yTfOLX5RvuqJGQFuWvRWED2cfslR?=
 =?us-ascii?Q?tgCHcrvQ/7f/QVCwmbRfZYLPATj5NYvDgYXOXv+TRUGZfItR6QnGsbGNVKFC?=
 =?us-ascii?Q?mDQdZK9gCRO+nRxVu7LOFI0YqusYmExLNs6qkr6+NTvzKhx1YnI5AoNKz3i1?=
 =?us-ascii?Q?fwKWu+BIGOKZ5x78/LfWBqsbVS3/5vsQM+YwSZkOFZNEjEzpiQILqx5V9dSm?=
 =?us-ascii?Q?y8WrRfLUncl5NY0Au461XWlzu0dG2NVu3M5+vIDmAvH0G/XR9Hh2Dj9XvQ7Z?=
 =?us-ascii?Q?rsrwD+fLdSBiSXHeLspOY57/yYLbyk73OMFueisrDqUqj4l18pqVRshb8rF8?=
 =?us-ascii?Q?a/IeNkEVvhxZRXxYmAjWmFLaKnMsZbsytorK+g8SKkKJtx2WO2Lg4vfHAlar?=
 =?us-ascii?Q?b61Fnms1LR4OTa1/smj/fZjlfcphzl+mjPHOzJtER3Au9UdYrM40cKzSASo3?=
 =?us-ascii?Q?J0sWlUqIix3Eg4CyQHYq0U9pUdoNf3RwqjpyJv1ixJ5lw8TvkcNCBmNlkpBI?=
 =?us-ascii?Q?ae459bcjbzi9szFgB4m3IzhGdwZcEVMn5LHVUolveu/wWUEdM3Zpr+0/Gc/T?=
 =?us-ascii?Q?9c5eRzSNOfulGNkqT9E4ioDnszM9oSxBPxWNbcMCpD0senPVcqh0kvR2Bup1?=
 =?us-ascii?Q?910vTo2hTe0egOFTvdhRN5iNYqiNlQYwNHMw1pcK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b366a3f2-1ea5-4f8c-4ac7-08db9f13af64
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:18:29.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSa+ZVBMjVpORmgGr0t7xyCoNwxSx2aTf6u5eSm9TBNxICIZYKYAXeofvBPa/MkPytJv/1MYcYXQZ/KWzsp5qtnfKQGQEVYmrxRpsUPEhwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8435
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12760

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 01/13] regulator: dt-bindings: Add Renesas
> RAA215300 PMIC bindings
>=20
> Hi!
>=20
> > +++ b/Documentation/devicetree/bindings/regulator/renesas,raa215300.ya
> > +++ ml
> > @@ -0,0 +1,85 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/renesas,raa215300.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RAA215300 Power Management Integrated Circuit (PMIC)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  The RAA215300 is a high-performance, low-cost 9-channel PMIC
> > +designed for
> > +  32-bit and 64-bit MCU and MPU applications. It supports DDR3,
> > +DDR3L, DDR4,
> > +  and LPDDR4 memory power requirements. The internally compensated
> > +regulators,
> > +  built-in Real-Time Clock (RTC), 32kHz crystal oscillator, and coin
> > +cell
> > +  battery charger provide a highly integrated, small footprint power
> > +solution
> > +  ideal for System-On-Module (SOM) applications. A spread spectrum
> > +feature
> > +  provides an ease-of-use solution for noise-sensitive audio or RF
> applications.
>=20
> "an easy-to-use"?

It is from hardware manual.

"A spread spectrum feature provides an ease-of-use solution for
noise-sensitive audio or RF applications."

I will discuss this internally, if required will ask HW manual to fix this =
and then will update bindings. They are going to update the HW manual soon.

>=20
> > +    description: |
> > +      The clocks are optional. The RTC is disabled, if no clocks are
> > +      provided(either xin or clkin).
>=20
> "If no clocks are provided (neither xin nor clkin), the RTC is disabled"?

Ok. If required, along with above change will update this as well.

Cheers,
Biju

