Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B0C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 13:16:30 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.136])
 by mx.groups.io with SMTP id smtpd.web11.31284.1685625387942597838
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 06:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gdbDJDdX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.136, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+6N/991mQRI/Q8hyipfVFGrrH3VAeAfSUqDKks9Q2f/mXe74t/UT4T9rP97eMsKe8o8FN0nUez9sflTWWxTGO4SSRvBPPRHcTP5TZasrOpEcjt/jR/DnEHPFN0c3QEhe0mEyuyBnleyM8LIIh6l773quBdz+EAA4rC+tQ57tEYOM10VPEFRhobrYH7bUL/QkYr25UqeSjk6LN8o/yYdxr1pJUU4+WCYu58oJXdv1KwFdhghaFZ6NkzOS6hx8o6+PCYI/UvvZh0CFUwGj1fBnms5dFAktBEZOTsd6AkLvALaRme78s5Xs3f1wNmiTCYVubinUm+6JELQ7sbjW5iE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOxhbvdFnf2O77rfRnEG8e223mXEh93Z3pUC8FoOg8A=;
 b=XmSpEajq6M3g+cqP4D7J3XgztP3EuCb7MklWIPF3jO9gjG0RR7mAjiPFVwrjorzhYSB5T6Ff4pNo7M2Ytc7mRnyC4JcYdysWnzrxp+N27qAccu4SC/uxiyWGaKGbD3FJdMyuFXZlcSbCiCRvymj8LVSA9wUKItylnqp3QApca4ypViUr8MLLluuSYjuyFcOxVRKpy6WjDt229KdZwTqvgHKMHLPls2pqPd7ylZwzWEoAJ8Y0dWr9+58XRTFOyPIUz+SEX5q2Gmwt2QI6ChboCBmXRhQTbLH2+bt9Z6GkOkEKNc9B+D1AQgdMSAU95QNbv73H35VPmhdJHm9JM8x1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOxhbvdFnf2O77rfRnEG8e223mXEh93Z3pUC8FoOg8A=;
 b=gdbDJDdXJybSzHZI5wXCqAa6Cl7jCCBlbu2Q0ealSdUgxMcRvp6Z4+DvO6GF692ieU68wecqtI5XZ2La3FZgVztOSH43YtvYmvBiApkUH5GS5/EdDpqAjznjKaRw4cMVcUvhQKiKPawtSfpvhAlqlxwTTZ6DR9vMP6JQJ+mdiUM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7972.jpnprd01.prod.outlook.com (2603:1096:604:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 13:16:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 13:16:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Topic: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Index: AdmG/WaLeUipv7+wQD+BoBNa122sUwABuRRwALMJJQAAFAohAAKZvMwAAADVrWA=
Date: Thu, 1 Jun 2023 13:16:24 +0000
Message-ID: 
 <OS0PR01MB592252C0DEB9B1C51AEEF7C286499@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGaZvnCWMW+cOXl1@duo.ucw.cz>
 <OS0PR01MB59227670A61E6EBAB81A1D33867C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZHiT6kWwgOHqslQs@duo.ucw.cz>
In-Reply-To: <ZHiT6kWwgOHqslQs@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB7972:EE_
x-ms-office365-filtering-correlation-id: c8c2b522-1849-44a0-4e43-08db62a26637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XuppPYOGSZBA0p/mC5mFhuQ5amBllv/P70aBoXAoa+UKxUa0qKwdG3iv7Ej5zkoMA82NpB3jWG6jGmuTdwfU1mCkSRsLiZOrtPxJ4CSV2jc6vsza+7V660mtkHj+psDhd29zlaZtS2JpJmDUd8nWR1fvv2hmRUweANNonBtXQ5l102OxCQKM/nn+60Ciul41xHdGZ4bkQYj/bqtX/bk3uyOh/F+nQU297zuxBoHCPjgZQoKpQuiR8L4HOjUtmQGjEYC20xIJD+jHZHbTMd+OZDOBgjWB5xV87Pja8JQK49WI1Q4S0bjLJcs4FI/pKvaqe99SqKHKMbkBAC02O7iIjKVtbbdCkHt5eO7l+7vtw516J4GcQFZFzlY/wVniHCspZFjNuDxL/4Czk2xjzGwHfJakVeSUPQrjbnhherCNVBWHVel+IgDJPt0e9MiznGrfDX/UZIphk0hEwjbm+ozEFzzQcfdQXAi6aArR4vY9OF6/vJ0PM9dfkH5MfCqPWkq8rvipRWHOszxvfJsRJk4eOFZF4SqIB72ls9xMUfm48jj2Git+YWqhCyBC22gXv4ZlFMBQC/zNgR68b/rCjbXXnSgBhauZDvOHQwXEZgLdL7gNaIFDFe6F7yNMVsUvaQrH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(38070700005)(33656002)(86362001)(83380400001)(2906002)(5660300002)(52536014)(8936002)(41300700001)(38100700002)(76116006)(8676002)(66476007)(186003)(64756008)(66946007)(66446008)(66556008)(6916009)(26005)(53546011)(122000001)(316002)(9686003)(6506007)(478600001)(55016003)(7696005)(71200400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?a/0yrkRp4cyrz3vHMXfdAISs2Ptjs/TObN11k4ru/ofJsAvl7lHZnmzStzmd?=
 =?us-ascii?Q?OTeabBBjBDKr6Q0ckduSCqbsyQoDPVf7mYrdidTI2Lpgi3J03WctVXbDmE/2?=
 =?us-ascii?Q?BzmuMJYsSxX7zBwD5ZNgTvqgcqCw4tEIsSbe2EFGeMycHn+h01+GWGty6qeZ?=
 =?us-ascii?Q?3AaOiMQSHJCOSQLYI9Ob6jmtyx1y/pt2i1WNOCPmW3955O4bWi0hmApvddS4?=
 =?us-ascii?Q?tt5V8ZaU4ZRQMIqrF7GmNDyYD1OxlkHD3qVzJQ2l6jgeSLzg/OzPNmYtP+RC?=
 =?us-ascii?Q?u9YSlaG1FMZnN51OE28uH1p7S9vU+5Ydqir5NoEw6hvEok03XQ0OXfu+anPc?=
 =?us-ascii?Q?W/P+4Bb1LCVIGdhELgOfFZypVZ5w1NTpNnnDURSU6CXpHdgu4ax0k/MLuEns?=
 =?us-ascii?Q?UjHaXoM1oXxOZgmwx6RwiP38jK/twqnPY83/UILcy93/r55sU7PolFG+Furi?=
 =?us-ascii?Q?8M5LVDO26sRd0bzu9PQOE2ob1LYnWxHhS56elEEv7yB05uxQyTL9d0LXJakG?=
 =?us-ascii?Q?yuUYAQL1B24CAXzDBccSBq34p2bsc7kD7Wv6zRM4XsV1R6ez2yPk911yAmh0?=
 =?us-ascii?Q?F6n6lENQ8lG343Ep9ubXTuntDOvHiVgU5g9KU0W0wUli81WEr4j8O5o0yaMt?=
 =?us-ascii?Q?Gjfbioj6oqQ3WW+wWu5/T8ohO6vb3m+gVyawWFjnnI/S1HUPHNi4WNJcg1Yz?=
 =?us-ascii?Q?syWMd9BU9dZMbEstwesZeLPvEAfF9/tN5jYHc5LI5moo7hVPCRsRijxdaM7n?=
 =?us-ascii?Q?G4OAeKVcvQ6GhfB8cNKsVW1B3GJOjk0x6HTsyyPPY+c0pt2IOiMhqdrVSsDD?=
 =?us-ascii?Q?negtwp2mNYHhDyu6Z6CUolG9wta56HyfoIJnHf91JnhXsgZe4N1ijZJKJIKw?=
 =?us-ascii?Q?VCtUsZtNii8yEo75JbUspAnaKnBPA5HI9m2cRvv5mfmE7zhbdJdxqPb8tWa7?=
 =?us-ascii?Q?sI19vI0ZL1LEPPrwcf62b81RgX4RY2+rLzELJ7KFfdUm/oFl+W5gtg3T+xFR?=
 =?us-ascii?Q?7Qm6prZaDM/lQcR12naw2BCeseKXpRZIPiH34GKAaolqpRbxQO9UyIsrWwtq?=
 =?us-ascii?Q?6LMYzErxI0qxtCwq60bsUgs4csIcv1TatmEzI4Maws+OE7D1VPJULs5u3Lec?=
 =?us-ascii?Q?/+dcjBhmFIVvawA1z2bRh+d+jgxToh437hmZ593rDFj7otmKSbF+48pqzhVp?=
 =?us-ascii?Q?9kttOdmGngLrDRhYGlnkzAirGLWIa7P2gMJ8FfI6upKIT/4ukv080Gvp5MXy?=
 =?us-ascii?Q?8GZbLBH2HKv4jWio6/vR7qvUKxza9A6puqXothfyNsr1yOYuqIOxu2r2DmAl?=
 =?us-ascii?Q?FnnYNsKGusucOw5cZQrBVRQS4pvHZmIo5fpI3dwXxgIX5Vtmj8X/dUJhmoqV?=
 =?us-ascii?Q?mNkSz4B9efkQKYsUj9oTLEZtkTARM/wd8B00eheMs83/Ky0iMsIRtFoBkdlI?=
 =?us-ascii?Q?sq/8GnIUapuDNy7GEb/q0TzwHv9VmKSI0ig+DDemS56cxRB7q/rF/u1WsSZJ?=
 =?us-ascii?Q?1Y2Ihc4wAIWh8TKIv74keWpVGg+jhwj9QIGXKd7jVnhRzSh/7uCt0fpQIZeX?=
 =?us-ascii?Q?cPKbntOxPWoR9SQk32mVgqi+LnXmx7gb1filFWZcP8z+D5rs6PYKUqWqAKQL?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c2b522-1849-44a0-4e43-08db62a26637
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 13:16:24.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBH8LzoBA4nxtgFcihFsHITbUWhHT7qr8N0ELLuNpKsPDpOK280PPPMomeYTf5YWK1SMEmv5RKHZ3ph9aOQEhiBQjR6w+lRtgox4eAH8NLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7972
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 13:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11729

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, June 1, 2023 1:50 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-
> cip
>=20
> Hi!
>=20
> > > 2) Update counter subsystem in 5.10-cip with patches from 5.15, then
> > > merge the driver from 6.4.
>=20
> > So basically 2 and 3 ruled out. The only option left out is 1??
>=20
> So we discussed options on todays meeting on IRC (you may want to review
> the log)... and if you are willing to do the work, we are willing to
> consider option 2.
>=20
> That does not mean we are willing to do updates on other subsystems --
> this should really be an exception -- but it seems counter subsystem is
> simple enough and you may be the only user in -cip.
>=20
> (Of course, the patches need to be reasonable and reviewable etc).

OK will revisit and send some patches if it is in reasonable and reviewable=
 state
for 5.10.y-cip.

By the way we have backported counter driver to 6.1 without any issues
We will be sending counter driver patches for 6.1 soon.

Cheers,
Biju

