Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A86C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 12:37:35 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.web11.38779.1745325450356424796
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 05:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=dA/yhdgr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT5sY2MS5U81xtobHa8nLPIOP1T/U3+POnvLm9sXVnKLQCmxfZxX3CPQTrUABSxJyusLX5yS3SDPfFNddR8y/4N/zf2bqC7O8Ewr7SKQnE/KlOdJCJWD9lWCMmo5FQlyPHPuMj/30WKt5pJ9dN5bnMxuVlkch4MeyJZo/slXxtUyRVpJYGCsZeGrr1vzOCjZO7dmZxw6FVChrnmwvAo3kbCIlczAMQlZ1IxEu5SNPRj2JQ1B6oAcw1IMVbixycFEfyX2oZctUxkcklZElDSV/6UXsQE5yhr2aiuSUbr7ef5+7uxc7YRQ7aXWtvsrqGn/Wz6JDob5QtN3PCV9x/2EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUD8b4/EB8ygLXkBJk9soeJmzXqNoejCtc0Jqlj8vFo=;
 b=ASoI3KY+0nuYnKh2Ab6kWNjOPUvrQ4N+ltMKSh87Pxi4mve9zlRKZsnS67utBKBvFkPfrGtFef1qU8FNZzJi4Zt/d1rWLvUUfSeOlVtSHtWVUs7CSnUVfxfyrsUk1+zPHh862BTJARS5isrhV5mvSu3yS/2RxA9dok7X9s6dS42Y1Vd+ylKHU5S1NSfXq/HIH/AtnZu0zTtpVEeDi0MQHHrJZ9sHjm/PMdHYFBXbxYeUiTzV9IEQ90YTyb4Rrhn4k0dw3dS03cTZg4RfQuGiK1hiqJoTogW7f1FtmSOOz+Z9NtqpDT/zTfkmq47hSBdzW7k6gI3oICCSv7+SKPexSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUD8b4/EB8ygLXkBJk9soeJmzXqNoejCtc0Jqlj8vFo=;
 b=dA/yhdgru8iAqP8QSo97Qt+4ZBIYvhoU0gbNGKTG755T2vxeIKkxJZF+0GGuHK8/KUVe0+G1WJg6XGjfaFvFtEO/LOAQ7i0LecAJSvDlWl+plyIzgFXG1M2Pwe8DIHYqxyDDiXUH7Ns/5LBZ2xkwJ7eyOugaN239P3o7VwJcnm8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB5734.jpnprd01.prod.outlook.com (2603:1096:604:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 12:37:22 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8655.027; Tue, 22 Apr 2025
 12:37:22 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock
 and reset entry for DRP-AI
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock
 and reset entry for DRP-AI
Thread-Index: AQHbs3AksUmW7b9k+0eyq8wSAZE/1rOvn1yw
Date: Tue, 22 Apr 2025 12:37:21 +0000
Message-ID: 
 <OSZPR01MB701981496E7F32530C968970AABB2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250421184657.633352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <18389BCA0DAE4776.21966@lists.cip-project.org> <aAdtYQPQAHQ9Jx7/@duo.ucw.cz>
In-Reply-To: <aAdtYQPQAHQ9Jx7/@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB5734:EE_
x-ms-office365-filtering-correlation-id: b7e0c86b-abef-4dfb-8793-08dd819a6d98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JRR8ZAgE7hgG+JEHB+3ZZY7zaf7nx2jMFkjq74QMc05mv7CKYqus9+kpd/4i?=
 =?us-ascii?Q?SzSLUnH7h3SHh3S7xZ09g3kVU3gu7pvwKqkzcRDKr5Kil1YUPQAH0KjheZj0?=
 =?us-ascii?Q?xhweZZ/W9ADlugkswzwMVR7ArCkH4Ju935X5VdWIbdET12l/CmMHIKNCEftj?=
 =?us-ascii?Q?NHam6+rAMMhjkJ79xcrbzr+JunhCTWUhYBV7K9i9IqCzyvmXJxuMzBRSgn5c?=
 =?us-ascii?Q?UhUUC+Pz4KEIEz1WORX9lwEZ13LiOZHvJKclW2bZB8lOSHSYzVeRHs6Ah3jm?=
 =?us-ascii?Q?a/lZkNDyFGjdIG0cwrDxHb8Tlk831aKN9vUSJabwaYeumo/aQ4bzPVwwi4o4?=
 =?us-ascii?Q?Z4FInpApt7TpBG9MYwoJ88tlwJSdmEnmLRcYr4De3tdwbZq/kug603+fQMZq?=
 =?us-ascii?Q?7cOu1pv/SUds45q4poqFphAd39mjOc7uSPwz+AadNHkthTiPKG1LM57S2ahZ?=
 =?us-ascii?Q?37NPhGsflpuhR/LHMjybsl1/8ipT3DN3HQ7hpUlNsskaPHd81QqOSH30eak8?=
 =?us-ascii?Q?TmALA0j92HJoOg9oOw45QBacJqL3EYQu/1iDy5WR1PUiEeOJ81njhO7t4qA4?=
 =?us-ascii?Q?PuCPaq2cvaWS29NoxK4ou37t5IjpO/UPd77yowX3cgTGhyrWOzQgD8qoRx/A?=
 =?us-ascii?Q?sRJng9Cmf3kXndyElGo+dX+7xdsWPu8gH80kGabR/cRlmVgA68pc07W1Dka2?=
 =?us-ascii?Q?GIlwbYIkJR8NJs1qcFOv2aiu/0ygisYyQXk3rfxpusTCRDNWLyUadm2U3kex?=
 =?us-ascii?Q?TVFxh5spJahb+f6P/ZDIjvOylva14+w/iEPJLJNJ0DkW3mrfDTFAaGksWskF?=
 =?us-ascii?Q?lj5YphgCPnRYnanqa4y0skjZrI3HNB9yuy2r8L1YYzuVJyDBuBi817MOw4cv?=
 =?us-ascii?Q?4RijJP1CcjrmuUzkllUdGRw1b+MVH3hZqlMrRBxA/wK//hZzZUhP7avtRrn0?=
 =?us-ascii?Q?EqsJonl94E0Fl1w1wES4nOk8b+OBT6aHGtVhsEQqlp5fIe8udqdvgntkq92R?=
 =?us-ascii?Q?dqVZPiRTzjdNA52Xkl1pJ2AymUbcx1SeDnd71K9ctMHydUvmjV5WW//7BPpg?=
 =?us-ascii?Q?s6wbvVVPWeGaKDHpOdTEP/g1hslExUxiBp2vvuis6qTzEzYvMBDWEBbvhBBJ?=
 =?us-ascii?Q?9H4vSSVMdq2V7zPbnNaIP87zJGIjM0sUmKRzCy83gHc13p2T/LY7ylhG+GLq?=
 =?us-ascii?Q?l/LIKo7G/z/ErOmBwABAgFBbRVSkBOuskb3z/yqrQjS8kMQhFqsetXg0JTEZ?=
 =?us-ascii?Q?Q8yNNqLyhwgJYe7ImEgpoySuOo88bCLYFweWbS56Pou6xJY6rLDs91cWWZoh?=
 =?us-ascii?Q?YA9FUC/C09FGjmb6wCezVwmLl3kv/vkewkUJtZC2vMkT/EzNjCCGQYBKPsau?=
 =?us-ascii?Q?3tJaJc10uzDcP3DWpRb+BjACQ1YwuONjSRSJhvwEHtAh3xqq9AL03Ti26wn4?=
 =?us-ascii?Q?5FN+5R/BohRjjVFr0KmrqWa2GPIuAV2QXc3NqfrI3+yleFJd3vZBgG9TK0V0?=
 =?us-ascii?Q?9rfCdS0SAlawFIk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+pg16AR+lBdIGkEJC4DvCAasjtvNy8GQu+YpAhxSumMvPS1N2wlATO1BhPcZ?=
 =?us-ascii?Q?fRegOPIJ8kPRpYIjiwgK+91wguRG7ePVx6J35++e4CeIpx0fdc3SUjuScHh1?=
 =?us-ascii?Q?EuVUd5RBa/Q5QITwTXzjI2tKD3DdmwCQstu5rOSCdttwn7JMD5b938YOjUpl?=
 =?us-ascii?Q?S5L7186/vSZpbaTRY5v4HhjCbMo67umWGQzNK0K56JxaoNAooO7srHvs7Tir?=
 =?us-ascii?Q?rqazzGqFmU+M26WsWqYqeQNg3JV7wlmNkuQOVKI80+XrGSPnohqrv2iU0IXq?=
 =?us-ascii?Q?CDL3keVdOfrL7fRdUbUfUepzzDpbDS8ZNEAe3gfX+x43hr0zQE3AB4BTqIzs?=
 =?us-ascii?Q?Zmy+zdbE3CkaLLqcRibGpxzQBCOK8fHZ7wMeE0Ws8DOST8UaRMkTr6Dj9dHn?=
 =?us-ascii?Q?yaFvg2w21AWTAZjMmFkeiKK8nzVjgxuTkSScPQ9dCnSiPaXbxeJoxO0o/FaA?=
 =?us-ascii?Q?J6g96KqAASbauFMXJDi1fPXnRd0UWUlwmI2wKNvraE08xK8e4b7gJX/96NuH?=
 =?us-ascii?Q?G9LXVlQF7X+qRqP3n7Ibmbdzdn9rO9mec1gEX+31VFlIQ2SUapaAQoQqe0Gb?=
 =?us-ascii?Q?1NDHq9qvkNeVnEdAlzm9C7U2ALFEecGWxpCTBn9C8BSUhnfkvdBf1/CVxO1A?=
 =?us-ascii?Q?2HlhnmYM7NHTqpbOgK+WwwNTeg6fk1ahZJSBc30yxniFwYdsN/C7EOdpXIwQ?=
 =?us-ascii?Q?nGkgEdtfLVdFfj7GMqXJ09aO31k7ltZ032exQ8oIhQ1j0EtECfusTsvWhOVM?=
 =?us-ascii?Q?axCesCj/1OJdoVrd5h1m8Dr3zEdE/4T01SLS7y4sxL/J/J49BQk9UQCYZo0S?=
 =?us-ascii?Q?lA3wk3MWNztklbvWjHbqrRrDhOWHVQTj/n2WuQ/FftzFr7txrittcohlyeEP?=
 =?us-ascii?Q?lwf58rjbBUf7gCJea7MZP1O+YSZ0cn0vTfpPhC1ew++lTo5Y3KDZZRe31bmp?=
 =?us-ascii?Q?6nljXvvRjJj8T03RvCcT1dQ91VQPROf5jm1RgeMigsmG4SCD5S1gw/NzDl1s?=
 =?us-ascii?Q?U/WigcgNu295ZXvxhL6INsVqET+WJn7B0Ce1J9/d9pBHlAT22kEKGPy9PsHB?=
 =?us-ascii?Q?6HappcxGEVAnUD7n/LXri2zn4uAv3yMevJ5CAlWiOFNZcqt2ZalD/fGg6Agi?=
 =?us-ascii?Q?VjIdGODNxMShy+kR1BoEEg1L3FBPvyXrTbn2UoIIGbTLUGpIqEK5IsN7cqps?=
 =?us-ascii?Q?0jav2xrJSSweEJaQ+j5fVx5pilHjUUw6o6dj3fDuJXal8eYwTl6YnlVYosk2?=
 =?us-ascii?Q?t2oSr7aLfhbne9+59xuqyj6+jkMDKj8eOsKAH1JCfHJ+w4qaMHmrKJsnIdBO?=
 =?us-ascii?Q?k0mfz19LJaMwO8MxAfWLObiIgN1JacR2IiPZAsPSUZeofUEjVEZmKNVmUR+E?=
 =?us-ascii?Q?QSb0AzM6u22iCHmDGKaQfUtPuHAaqq6pwc9ZCcqetYfX99M5FrpxuFOjqlzJ?=
 =?us-ascii?Q?zth9UcDK8DACVlwA+UFsNGR0vcaRb9MZiu/MnVq2j2fSuIem38CuYNTwDtZL?=
 =?us-ascii?Q?n/SWRBP6ayzjEbJCf027Z/5/qwGXQ9zq+Hs8g5VXDeEdkRUlfq1Icfu+tDBN?=
 =?us-ascii?Q?LbRHOBXGPHhAZAP7aiTYpmDgDsP7KpDhVdBUsGoqslEJRx+/J6S2XqmZG8gW?=
 =?us-ascii?Q?uVENKWfKQKcNHTjbBgxT6TA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e0c86b-abef-4dfb-8793-08dd819a6d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 12:37:21.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPvFIcjT3fgJswGIubPiUK1BXdZL0C9bGEK2YBEThVrjWlAR4x434Z790t6ddKN3lQbnXCqz2L7tZK5FWXRdM+qUZ5PewvyRDbzCG37ItzYhuRS4AsQ9V81UZsyF1iVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5734
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 12:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18554

Hi Pavel,

Thank you for the review.

> Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add
> clock and reset entry for DRP-AI
>=20
> Hi!
>=20
> > > commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.
> > >
> > > Add clock and reset entries for the DRP-AI block, which is available
> > > only on the Renesas RZ/V2L SoC.
> >
> > Looks ok to me. Both 5.10 and 6.1 versions:
> >
> > Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> So, sorry for the noise. Patches are ok, but we'll need to get this to
> 6.12, too.
>
I've posted a patch for v6.12 [0].

[0] https://lore.kernel.org/all/20250422123255.7722-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com/

Cheers,
Prabhakar

