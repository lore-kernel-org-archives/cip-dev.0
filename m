Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B698C77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:10:51 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.126])
 by mx.groups.io with SMTP id smtpd.web10.83579.1684138241026095775
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:10:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AyajrlAk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.126, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBf4Lhbg4k1bCeWMHL1SSDuGsBFrPzHBKREMADkESz+GOcYER8ZTXEZQ5FFcfFzbcCIovNw0XKRJ+zU8MOvvyNHsctG2L+Tc2s4x4qirgt/pEVCtAYgtr+jqQlJKd/qv5tJCXd5Y+UoUzqJfvanozb3an66gaRLNxAQKdpBBKbTEoJBAZVqJuvdnxrfSw1HY483sKdT79T1Y0iYBmBaxEdhRDXERD/if+XOi85YCbjSp8h42dj3KBwBrSZVrukhy00DT/C84Rm/yWmrkhGLHWBpRw9lysQaEGw+qfLHeo3mZYQkaiWlYDi8KMAh6fgGRwFVQFY+OiIwKPK4o913y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUpkd1la1cGxhDWReAUuyQxU0cAOCMi7JrfLQ8oHWr0=;
 b=HhDbSnFmxnuKIm9apNJ/V5VucoJ9/IRK3fg1x13pz/y+rSNJa65rq46yDkEmZ9ZtmvKP6zMRuAQpj1aITAk0KXn2JYgLC8cCjr27e+aAAeICR9w+Gi8syK/XzMxjMLzT+yi4cjiyCDHhBHNwj8S+I5BJ7xQdnPP49msD9u16lYymTr+NO8J7m4yQ5bDGrDMf+10afRh+RjSReZtaRjicNT5DZB1KhI21y0hmU5fFTnYrME3wQA40PZD1cwEiX1RtfGkYlo+qIsq68oY125L5mo6GlZaAkE02cLk1dJ9z3/4Frw8FxzKrs8SOl8L+xTAFH2cf0Yv49XZ0VEc8ItKxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUpkd1la1cGxhDWReAUuyQxU0cAOCMi7JrfLQ8oHWr0=;
 b=AyajrlAkMjXSzW00leSBpsIsOHROr0CC3RrJ6rmaEmW1tiKYG4y2Lk/ahuOuXyXax2Kemz00za7+KjqB6zfREhmDEFpp7X8E8wCg7/wnK0dHwwwfWeYkTDP2cbpI8Nvh1jRgz775c0BVOZt8c8Cs1A5YBysBDH8uUh1eAPaN5Rs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8062.jpnprd01.prod.outlook.com (2603:1096:400:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 08:10:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:10:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Topic: Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Index: AdmG/WaLeUipv7+wQD+BoBNa122sUwABuRRw
Date: Mon, 15 May 2023 08:10:36 +0000
Message-ID: 
 <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8062:EE_
x-ms-office365-filtering-correlation-id: bbf2777f-2850-4122-ceb9-08db551bdd54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XgtsAiZeQt9sBPT6zvJf3NTOsgCYgsNCMrAAZLc1KMldNL6RmUhawjaWX1Ox8nP9BNw+znHR/IYrXk/H6L/bmqP6mteyYWalgd8f2ip0qVKbkOWo1d2wEY1it8TbnpMCVw7em2CVTkacREeTTK0gWRKCz5kumeSaubR/y8ysL9RI+pEWjYo3Wef/vNTdkdEsVOExKqM1coUUwPbtL3XyOl46sO1XqFx+yxvwWjqLU/JspzJ1BLR1G7rCSk/B73r26yEoLyH1iGNT8PBNhKC1NZSmfJUUr7nUQaOPFWkoZJ0cD90oZCzC/bghOI0j+hp72zh4NLMZUNbkcs8jcPNs+M83+zRDEZw7I9Ry6Hb9KovnzeuSyH+/HOXv9opgNiO7WJpaMwOVmMzddLwf3n8ymRBiEc/nmLU6DgDgX1NQqdLw+PJVTBE5aegNNC8GkFAcvnpCN1A/FdQOOv98Bo+1Fg3/3UyqE/Mv/q3Stc2bjwr6QXczKqbudCi9Og3Ap6QfSF6YetQ+3jkBh0x3xK90e9TC8HXMYHX3E/VGlDPLCTqo8MqNEbDY+4dliFlKejalp02Sw0LdlZrSxZU+PTBj5+6Q6s79bjjwUB9Ft8jVLhCqSJwtAyg07IWKYyNQo/JqRXPC5yL1H5N+nbM4M+5ZqqyVTpkV4cUdIGQw5coJTY8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(71200400001)(478600001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(966005)(38070700005)(7696005)(316002)(86362001)(6916009)(2940100002)(186003)(122000001)(55016003)(38100700002)(5660300002)(41300700001)(2906002)(6506007)(8676002)(8936002)(52536014)(26005)(33656002)(53546011)(9686003)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IAJmkO/d29Z9T2KCxODBs04SAOpJTjngVRTy2l3nXmBxX03kKnFmauF641FY?=
 =?us-ascii?Q?dTGWl2FOzaUR/yIiJRgloeSZ+vMYhAxPcKGY1wHuEaEKTjsC1Mlbd69JiRtU?=
 =?us-ascii?Q?/qILGcIaokE7A15IQRZBoXIOjn72ZvPJbf3N98Z2xLAnTigP63L/7HRicW5a?=
 =?us-ascii?Q?FEZL/6U0Zn3gN52ZekNhiCJj6I8DBjCYr5GQ5B54nmUfg2AhndQldNCAeJro?=
 =?us-ascii?Q?3X6oFBpDVaz2g3bypMbFLK3Ba5tmNmYhSi+cHHduLjw0ZYvKVSwR1/sxnzdo?=
 =?us-ascii?Q?QQSkUZUbmWaMKnlgPXN582QS/uYfShyJtaOh/dopsgxa64V+MknsTM8jQr2x?=
 =?us-ascii?Q?bYv+iP+MPtRbqmP70fFIsD61w1XRsZlII66ET7o7cU05VZ6FdesNbVa1meE+?=
 =?us-ascii?Q?LOr+P4tu+cFGDGwugKw+3T8uYAPNPAdu+TnQEF0Lqjl2nb6CZy9i7maGKydf?=
 =?us-ascii?Q?daKGh/M9wxJVbZ3rJETZrFVbpVS+wDf411JZ6E27oy/x70zn1oVnTxrZSVSx?=
 =?us-ascii?Q?nGD0/UxWOMmVhhVSMqGur7809WLE4OUN48/XV5KOypqfjr9DL5kpKHmQd2eP?=
 =?us-ascii?Q?h9f3OOnO9ZLyM3ZnEe+07vevnOzvkTQjUB/HCflzzhKgXUkZnhy1T1L06VC/?=
 =?us-ascii?Q?30ijHoRZ5+pFNTnQN9EKlNc5HcVTBR8PNu5AVk1igcM32a031eCDAlodyh+f?=
 =?us-ascii?Q?94k9jilFb/i0Kac6KtoSQyROb866oa8g/9hMaFeNu6YbHzzz02mJ+kXw1+ls?=
 =?us-ascii?Q?RNiKEnjLksWkCpHLrN8MY5VGyRln4yx2bgGpKVHb2/wdPoy2MTVCqcZoAdTJ?=
 =?us-ascii?Q?WKNPREePLyNx7dU+ASZYM1bURNfdLzrfPLs528C5tCq0zhm8m0RUGM9oGfY2?=
 =?us-ascii?Q?JGhgUEOfHICM8BNtHYWmYDpiQPaqM9Db+9/Ke/linFkrtNDrVDIERYqluYl0?=
 =?us-ascii?Q?+fyz5cSaXF+Jq4PQ2AovCfBngqnIM04/tROTViCYvhhE1cJl9z9aeREnMEZ/?=
 =?us-ascii?Q?thYUXsNIF5hC+DzsvRgbe3MA/RelmljPYRemx1F7vj92ZMAYb8cqI3L2ZL4a?=
 =?us-ascii?Q?wVLmDzQeyIMDRLsJ3x0gCJkWTbzr18ur27P6htFlPGDfyJG4Thjwofx19uyR?=
 =?us-ascii?Q?nA5lZ/2ERwlO32nyntWe1eHNZuI/y400JaaV9Td2u9+JXGYBmeoeP6wB7YXe?=
 =?us-ascii?Q?GF3yAZfaT1PEAAVqsJ7AGQ+iIl8MJmWjph4fTuSaXnV4/ERD7stE3g3K/PRr?=
 =?us-ascii?Q?VSP5tBwTnFNDC1REFs2GU9KhqDybNElrhb5mBkWXWu5e/BWF/HrRO+J3uRQi?=
 =?us-ascii?Q?R8DyvueGdvKV83T+hzODTyYqvq7ZNqNY/Vf3q0/ggGbYlPgy7tIb04P/abXu?=
 =?us-ascii?Q?ySoQAf6eySoJNMoWd4EEyl8s40A+lsg9kO9cBoKhLgu1IHAKAp1TSjaMI4UF?=
 =?us-ascii?Q?Bybg52o/9YLkePZKsBNBrTPdxngEKFIsoHAHGP1HuT4YjsEuxKhzY4Oc7p0a?=
 =?us-ascii?Q?XU/L2zfwSc7S5yU6GiJk4yUG6Va/iYaZuO/Z+hAneGpKP0tNkaFYDKblSrXj?=
 =?us-ascii?Q?E6LBUKmZNs1c1etZzftnXRpeJb/ooXOhjJZ7hWsh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf2777f-2850-4122-ceb9-08db551bdd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 08:10:36.8361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igbLCcOs2cGxVubIDj+IWFQ3Q7lqVehac5vDbr7aRfcUZ69dRPLVi+allvpPBVwMnFQryFnPbwTYc8mBsyk7DOM4d1M6NA/XxTPUOcNMZL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:10:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11445


MTU3a Counter driver based on IIO framework is available in BSP[1].

Is it acceptable to add MTU3a Counter driver support using IIO framework fo=
r=20
5.10.y cip kernel?

[1] https://github.com/renesas-rz/rz_linux-cip/blob/rz-5.10-cip22/drivers/c=
locksource/renesas-mtu3.c

Cheers,
Biju

> -----Original Message-----
> From: Biju Das
> Sent: Monday, May 15, 2023 8:27 AM
> To: cip-dev@lists.cip-project.org
> Subject: Backporting MTU3a counter driver to linux-5.10.y-cip
>=20
> Hi All,
>=20
> RZ/G2L MTU3a counter driver support is added to 6.4 mainline kernel [1].
>=20
> Counter framework restructure happened from 5.15 along with that all
> vendor specific driver code is also updated[2] and [3]
>=20
> Other than that lot of sysfs entries added after 5.10 see [4]
>=20
> Q1) Do you have any suggestion how to support counter driver in 5.10.y-
> cip?
>=20
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> t/?h=3Dv6.4-rc2&id=3D0be8907359df4c62319f5cb2c6981ff0d9ebf35a
>=20
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> t/drivers/counter?h=3Dv6.4-rc2&id=3Daaec1a0f76ec25f46bbb17b81487c4b0e1c31=
8c5
>=20
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> t/drivers/counter?h=3Dv6.4-rc2&id=3Db6c50affda5957a3629b149a91c7f6688ffce=
7f7
>=20
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/D
> ocumentation/ABI/testing/sysfs-bus-counter?h=3Dv6.4-rc2
>=20
>=20
> Cheers,
> Biju

