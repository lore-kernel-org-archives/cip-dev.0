Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0399BCEACC1
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 13:46:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.67])
 by mx.groups.io with SMTP id smtpd.web10.81780.1727790395069803024
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 06:46:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=YH38s+Lz;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.67, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA6AlLajE3c2U7aGXG+ROUFSIM9QrfS0sgTbl9Q6Ux+C2kH+n2waVVxRNv8ejw+WSjGih3+k1AWJ0vFztbNr1+2eEIqGUN4+n5f7zUokRhimWjBSrqTd+M+e1kkg5ApWEusFn5ANoGTr8Xs7hcCD3lD91CqRGW0JyHaZw4ZBv9Ir1QICusYlsBQfhk2Zn2N7L0iS1cbCzjGjFTKGE7h0QMOkTfdcbqnlr7EL9gXLnjopPmjjhNzohjfzmkJYkwjdMaZNI0kEs/VdatUgPWeXNW9SjyJY3K8IrvG+HMRKuWpN1bXv+wk6AbSxav91GBh5H3xQRWh0PwAxVF22KnefLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlhOH5No1Zg3P0TbGIBcFEUSl1YTgkDznrIT/TqChQQ=;
 b=sszcB9wPebmug/6yEqesQyNUre9TLjM9V7pZUSoE8XrJ53BKhNkCNoH7UsYro7j/RMSxlzRw7wpLi8ET6uBzReDBBFNAtLcrELYrKCBXVoIoc1ZdEL8yP5dH8DjkJX9S7pj5UzyhRRvwmTL4zxqlZ07D3pr+Dpkn00JdwGzZaFGHK8vVatHZuX2b+QnhGUgp/lGakNJ5FeO1jNMOzWMWWjcwUvxFssH5n8+fSTvEXk0jr8Nx568zppaUUm+LQF6DJL3KYgPS+e079T7Ejrsd2bVp4AoPk9MDstnGqgnGggnG1uATTPknNXdqL+oHCg04KJFaENSHGT1oeJeRJXPTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlhOH5No1Zg3P0TbGIBcFEUSl1YTgkDznrIT/TqChQQ=;
 b=YH38s+LzYnT9bDv7QlwugPM7//lXEuynRxEqDzOSxyqax1x4zd9GiGjtefrtoXZnjIo7xqjS6GnnrkSV6gpjOyQbKKM83+exirYedLY38nqEAE8+iyQJT0d6yPYDXhAqQfn8EdhAgHo9MgAectQlHIYJUq/GntCGZH46TdibCYg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10311.jpnprd01.prod.outlook.com (2603:1096:400:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 13:46:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Tue, 1 Oct 2024
 13:46:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] Backporting query
Thread-Topic: [cip-dev] Backporting query
Thread-Index: AQHbFAhOCxXewe5AS0SunINIuwzhKg==
Date: Tue, 1 Oct 2024 13:46:24 +0000
Message-ID: 
 <TY3PR01MB11346B7F9FA61A31E428C25EA86772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
 <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10311:EE_
x-ms-office365-filtering-correlation-id: 8b59108b-99fe-43c2-e2e6-08dce21f70c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Ym2L7pPAwqdPnZQVwJsxiqnNtUc1LlbYJZvCYihObicHTl4kScu+wC8o0lLk?=
 =?us-ascii?Q?flvHpDsJZjq/Ut9a26upLywUK8/MO5T375DT8TR/yfeIkFb599ZZlrV+LyV8?=
 =?us-ascii?Q?oBvSWNlNdILJFR7H/ubSXL1bAEriHqBoKZv7Lv/QVa/afCC5zb91EjNhNpF9?=
 =?us-ascii?Q?9PHb6FRFhsVjYH3J2bRjHmJWfWaMSKAtHB5IaB+c/TNq5URrixTKnVZy6seh?=
 =?us-ascii?Q?MBJmGJWylqnhbzQf9+uBXLvzuJE/NR/CoWUZDr/MxyzF7UqmR10QxTw4BdUc?=
 =?us-ascii?Q?5zGksZl2RQtyauR3HAlOY2+GwemkpQpSi2yFTPcunIWfluP7o/IMOuxmtCGd?=
 =?us-ascii?Q?ImTf/TyBgEcEqIXFtlyswOQe1JzPgtyI+A6QSxqfwL8bfWY8yNo//2jVExjU?=
 =?us-ascii?Q?q+kT22NhfPVpuFuReKcTKV4i717ozzZlwkcCJCcpc8ADgs5TWDTMGaSy3CP0?=
 =?us-ascii?Q?lojUZE7+T0z4QFthmuNaqzX4FUN054X0tziCySCvt3nk6KfrzmHxt9dKZn7X?=
 =?us-ascii?Q?3GuYD6eILD6Ouk8IaI73m/0sGx3RGq77yvSkyPoqxW2ZwHxyIXLBb9GFsC5A?=
 =?us-ascii?Q?ukrwDMsvWAkSICvgtSOdawf7ecfkT9mSD2YCxAgZQc2AjRxsbkkyO37yHIb+?=
 =?us-ascii?Q?r8ie+wlTbze/oSbuYJjrPX/yHcJVzgpiuwMwPIRoe/R4irAOZK7mAveKm636?=
 =?us-ascii?Q?tSanWQ9JOQhN7x+1kZ6GApb9/gzpaFomUr4p2l5XkZYJIjOrey0wUcif7XG+?=
 =?us-ascii?Q?F3gf0FGy76CjkkndtTvoVI7Entk8Xty0/i/XIzxdCI8Y0eVBxY0Cr5z8qDSK?=
 =?us-ascii?Q?QpqvlLBiJ2S7XNzw+K+eEl6580xdhq2HPUmowgKx5zCtav01JfdZ5X1nsDTP?=
 =?us-ascii?Q?k0nrJb9/SJwt4FZdDW2DiKgDOEHewsr1pIx8N4lot+NXMXzk74XUKPf9KY1T?=
 =?us-ascii?Q?899yL8L8l+zdvNf99H4RsMkrMISYpasDYqWAg7uH8HjK6ZUlcG4x5khp4MlH?=
 =?us-ascii?Q?toOCNQOspbXNEEpJM+xEuvZXHhCSy01lctlOZ98xbfvRoAr0Gd0ydatihmre?=
 =?us-ascii?Q?YP67tuGrYCLfJ0nQ+tSXI8Rpr3g0HW65q1gJ/yRUKG+UtRWcR6qhx+tMgYQo?=
 =?us-ascii?Q?XkcAhCp0SkCvMlrs0+sgRHALC6Yo1fuJh7zbRoLL5gohLXL/CF3bs6jomg/n?=
 =?us-ascii?Q?Rp3Mv7Esow+Je7Ev/zU6asoIRTR4I7fPkxRwjEeGMYojjoBSrsBAkeRIdFxI?=
 =?us-ascii?Q?15+VvIsH3BGYPhRnMZi5W5CDlkrXqTJK3Keo2L/94hUzyzMJ3CBgB9vBIBcE?=
 =?us-ascii?Q?DO/oLRFTxSyzPhFyDD0xRee68yoi1xLMMTLX1yP+9L7sRqInvxsgoWutJJv3?=
 =?us-ascii?Q?UMZaTrms0ZQNZf8Sly99MLiyiJkhp+5D9jAsNSaFYQbjfAOIeg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UNGCs6PEemch6FtW42RoryuEO7fHtCmp2tUKk025VADRJmRbbbKRLhCUFnuI?=
 =?us-ascii?Q?XVnB0MQNdkuVnSqKVvAOaKVk3zd5xUY8Xgc9rCbEoM9/OHF7AyHGByNO0O2v?=
 =?us-ascii?Q?thBfPssAM77Si5XyKuUXxoPpu+sRAWVGIM84M/OKAA4/Uhni8BrSO0vR0NKS?=
 =?us-ascii?Q?Z4tjinuScx3UJ0j0FQ8TRc5xaBzsWQSAM3H+lZgLO1kpFtBoMT448nZltDBu?=
 =?us-ascii?Q?ZCBHKNn5L2BpyWwfrk/tuyDaEQ+YP36jUjUgWhtlYSsgdOIAAnvtd2J+lvvC?=
 =?us-ascii?Q?hP3UF7StRpi5S2+KC1OqULi9TE5FL71n6w6+CCENxeSUaFiGYEb62H07SO1i?=
 =?us-ascii?Q?RcFc4ZskxE7fCPlLFp74BmlWyxEZ5JKf13lqTr1Uw09M+3pV/PD3Q76Y5x3m?=
 =?us-ascii?Q?X/mMKP7Pb8hArJVGtHExA8FK0MMAw0PW600nKKtyGuqFW1Hz1uB2IXUbcJhO?=
 =?us-ascii?Q?VhWIQA8G5W3bbo6S9Ek2yxoVcrhhPZw9k4z0odDeQyJ6CbbieZfzQdQxVVMn?=
 =?us-ascii?Q?XmYKGrA2Bunl8fv+jB4YgfHpz3j42/bdDyhr7EDAghgSLO2T93ywlqoamjUp?=
 =?us-ascii?Q?G4Y0OXsCdud2fDEmt9C7vud3aBBETM+h0SoNCbG1S6kjGBMdEVZ6WhCgcdEK?=
 =?us-ascii?Q?5fDx7K9Cyamx3KfDdWrV6DGasxA01HZhoenBqduEnv9rnYp0weCqtKXYDY7z?=
 =?us-ascii?Q?74xsj2upFXc2hyiIiPX2rEDncmqPrbVJ2wf28MAeqzhrX54Llra5qovgPzn1?=
 =?us-ascii?Q?t17jKKDrs1iNZ2qwIJGt/J1+LxDqdsMHobouFhpUa7KspOvLzmtd+sv0q9Bm?=
 =?us-ascii?Q?TwG4ZuMNj6tVRN/fVEXFMZNYjrG9Ld72rLYBh5OR02xOVyDT/HWcYD+SXOzW?=
 =?us-ascii?Q?/N6/K+241xQ5+AYfHznWwQKizTZRXYSroW38j7o2+vHjZGioqKUaz5u8OL7w?=
 =?us-ascii?Q?FoF2thfWMdWuq3RWR3qGr9dkrf1HxZ8GUB36FjCmbKA7vgY6faROXU4HWsQf?=
 =?us-ascii?Q?i6H87nqmGSYTQvVO6cxNSmgsE8V1b0/os8T+N5G5MptezWUBicLMoCE41KoP?=
 =?us-ascii?Q?u8IWNVNfFSSbr6srXoyMwux4dbH7u1Q65njzywpgJn20VTWx7RY9MUbXHU8y?=
 =?us-ascii?Q?XulrtriCnhleJTEnAkAl5tndwYVleCFt5tDoQeGzSrORCIn5aTnpwPdpdbPM?=
 =?us-ascii?Q?uLS/kXkIN/Hbtq8kW9LAIMvznSw30DdHyCdjG+gV0oMPRHJdsi47krG2BDio?=
 =?us-ascii?Q?3GwIo4VXR8fQj8+C+r6ZT56dwPST36THre31I3xY7zk9pjrDhntR9ufjcdqP?=
 =?us-ascii?Q?l45QPD/M9i/AqVMyoy3sFjtIZRJqIe3kGGM3ycTgqtu7E/yyrOs9mio70ELi?=
 =?us-ascii?Q?QgOFc675/42Lr9GCkiw2MZxuPA+3TciK/OPLh7WSMrDqu7KEN0KCgPz1++3I?=
 =?us-ascii?Q?Ubre8ZqyPpZJioiyMxiZbYes1a3hnr4i7PENkNsOekq5EFR62NwOppjNXTzX?=
 =?us-ascii?Q?vrtlBVaO0CftHe51hZPbVBQ3kDguvRCQnV7/CHUObIXHfcuvdXXe4i4BvpxI?=
 =?us-ascii?Q?ozXRlaWrGVHHVTjPhx3GDEZ7eAAZOgHkSJJZJNQh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59108b-99fe-43c2-e2e6-08dce21f70c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 13:46:24.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/EZCrVteW+g6xiHnBG1qnjO/Eu9CGyt/nuIxZ1IU8prw9pCy6Vj2gcQIWYu65fWkqXkXqU+yJHZnvDqUwHyXcz/E6DTbyoellwntZ+BeIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Oct 2024 13:46:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16944

Hi Pavel and All,

RZ/G2UL display support patches are now in linux-rc1 [1].

Previously as CIP policy, we are not allowed to backport anything from linu=
x next, but
ok to backport from rc series.

Is any CIP policy is changed for back porting recently? If yes, for new fea=
ture/device support
patches like [1], without any fixes tag or dependencies, how many rc cycles=
 we need to wait?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.12-rc1&id=3Dcc49fcd0bc2db23489a87f6fa17119a76b70ec6b

Cheers,
Biju



