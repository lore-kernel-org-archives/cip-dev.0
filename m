Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62671CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 14:00:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.6])
 by mx.groups.io with SMTP id smtpd.web11.20609.1755698447224906543
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 07:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bWmZm8Is;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.6, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc6I8EwW9/YvKzndcfXhud6/C3mbTMRbfMsA4T1dwQ5eYarDjh4WsIwqHz6yIepB6frIwX33H32jEUsPLVA+g7qh5a9ruMV66Qgc8t9It7nEEHjjTrgNljpBvLqbu/N9f0oblgIP9f5xVlBs/dWlxEeuFuGHGNpou9g7cf8ZiWjIas6IWpsYN8sZk0lJQ85aBmbYhFqn80NT2nTCDwanBChSILoa7iSKg+uffssha+J1KJmocuisXihy8XO8TSw8r5htxMcRSH9usLtlY3ftJU4KMun2attZnRFHcJrELEaQLcDRkdOuELQfjQwwLuLyyGx8UflNvR1jBLWka3MPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWcVVkuLG9BoHqQQg4rMK9OilCaBUqJpUm8rzfzkqVk=;
 b=Vhci7pbtJ6Squkax7k2uQm55SqQxIOtbkwF32R66laKrkNNpXNXkUjywh0SXSCJH3Cig6JVi4mhH2P7ErOTRI5pqVQ5B4hmiZnYs/fdT4iVtnLV77w80dDlenFO3CttsLh1KoIoiOtyLAysWym/Fh9ElwrfNld644oY1gwSOD0GGYzwuIoQNY88cpMbHLtVU+q0IVI9Xddq2uyRTpQOpse0tSNGPBsciLXCWd4U+PeG8zJkdHeEt4HnyK8vN6dCAOcKh5ekrAcYbJg76OQTUkPlByb8mD8V/pP1s/Mj3o2Gd+qNlxtmrmxXnF3XyTRsN2C1f7iMaOCMuwsNt9SsnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWcVVkuLG9BoHqQQg4rMK9OilCaBUqJpUm8rzfzkqVk=;
 b=bWmZm8IsSSmEnjDBCA6Rre15vC5VMu1zqWSbMcAQJdqfEvpni9MCrgnIKLgPcOozdiKPojy9mYUxD++2HaOG4XXbYmtDMXsrAp91yGP13IjhMEd0+gsiBJFnRBVjl2I9TbvKSeGg9uVeocni1NcIshyhuFvpPyAGdz/f/jsGw/Q=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY4PR01MB14075.jpnprd01.prod.outlook.com (2603:1096:405:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:00:39 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:00:35 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>,
	Ulrich Hecht <uli@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEdo79TsohFihe0Kgg7RBAPDXzbRrkU7Q
Date: Wed, 20 Aug 2025 14:00:35 +0000
Message-ID: 
 <OSZPR01MB7019CFB8CEB26BA0CFA9E49CAA33A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <185D7E331936EFC0.12978@lists.cip-project.org>
In-Reply-To: <185D7E331936EFC0.12978@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TY4PR01MB14075:EE_
x-ms-office365-filtering-correlation-id: 49334df3-02ee-47bf-e56f-08dddff1ef66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?xpQilaruPudd/tk5U50ATsTIrQMbaBUz++J8rM/EHOj5XsNX1UlfPfu5me/f?=
 =?us-ascii?Q?HUZXGNc8rr5nMEZNDGjYeviuiFY+DtJ5YuuC8Tn3RKh93t4CnfxlgQg9inwK?=
 =?us-ascii?Q?iPWg9SxxVdckHKVDHfqZgPBByZMNHz9+pVV5oG69sh9AyVqcGGplVVu/goZm?=
 =?us-ascii?Q?v6CP+Ivpj/POBdkj73JUc3G9LUBEkmaXdRHOA/rQvuwVXmnE+Wb9Xe3JxHg7?=
 =?us-ascii?Q?sjUH7Q4BMJj0EcY2LAJ+1ar8PFFWqmaP5gZJF8RmW6pkrtspmLQjv11iHGQ0?=
 =?us-ascii?Q?aj1oMjqdz4JcP+dasFdnpAi6PImDNld6m/dU0Vv+uNIVjaY8qooKld7UF0O2?=
 =?us-ascii?Q?1liA6ktY+ypcR4boFJM4tgMgPW3Po+oe6idSQk8x0o7Sa9IgjFVRVgGA/t2Z?=
 =?us-ascii?Q?BEa2/CE+fpYxsjOsOeVCxTtHGPNhEGD/wp2kdgt0HGJuRAzK9BirGYTdzr+y?=
 =?us-ascii?Q?E+xHCDhFo16pEcez5ropKmYbbVYs50nYfK7wci3pMuOuDy55JFOuTMuQ+MRj?=
 =?us-ascii?Q?Wly3zoyxm6JSJJXDXpTGKtUGRo4G/J+Uk0nze5kFSp7K8MwPaswxXb8g8VZe?=
 =?us-ascii?Q?Ar/r61dTtUTymED0dpCcp7LNdR84dlyHREl9JLJFcNgX18v6hrMZxPVo/Xwu?=
 =?us-ascii?Q?MJWFjaC6WLRbqcLZjXSIHnE3EGQUBaPjQDS7PxEJIWEQEF0WK9XpcDQ8yMqd?=
 =?us-ascii?Q?jQhVwbLBOS2JbwQk8OyRM9H4Uepl88i5QivMySO8ELJ7w7SJsdWiAnS5rJDn?=
 =?us-ascii?Q?srLS8A3fPlroz/CQnsMz72nDIYOQhk6vptmnVupzUCsXarpnhpLhvyX4MA5T?=
 =?us-ascii?Q?I/ELP18OXp004oGy9L9gfBOQ7BiyjHhdpw/ZbfIKLP+orbB1356z+MmpUQi3?=
 =?us-ascii?Q?yZApMHu4p9rTCJzjx0u6BRDXLqymjrpkmDVIr4/5dbr7xYqmtmVa6BhQBEUm?=
 =?us-ascii?Q?H9awAl+AjW73eH7y8fanrC1Ff53/I1ea7cFjQvbZHhhabSIQYMnuU7sKwWfF?=
 =?us-ascii?Q?HNQSP/9CMP0Fv8AmWyT9c3afmIpo1NKDQdL8v/E1yo9h551Zw+5qJOtPkOK3?=
 =?us-ascii?Q?TJ/vhPsnJZPsBi38v670vvKmWkWTcB49npHkUqqbhEMH0mQKhqi1I18oWViV?=
 =?us-ascii?Q?G13yhtorx159NYC6SpKlCo1scUaYfgHXMEtmnWYMx10KkvDVBZ1G0eJTpxWC?=
 =?us-ascii?Q?OuPMW+ibEDN8OPQf5WUQNtzVyQfBpuqQH9DJwDq33nP/kr7GWi7+YwfV+Zkx?=
 =?us-ascii?Q?QlgU5YDS+cvXPlL9A9VXkvgAOhV3InFm2bssZdukbCr1Gc+sNusPDZZas3jO?=
 =?us-ascii?Q?srZwF+dVlL2GNGdnFVxnZy7kekMkEqDFGYptaYx0bYsGhnVf50ER0Bq+mEBM?=
 =?us-ascii?Q?n8xqGr/f9FjdOU7vZ9rRckghQfcIRfUIr86+ZdC7/LBqF3Qchxlg/7sFnj31?=
 =?us-ascii?Q?F/Tyn8ri1YDoHCmA5q1+5KV4ER+pMw/QQyNWGPYdzT9eMYbNiBrdA4QafMwb?=
 =?us-ascii?Q?pNtRpAJEEI9ZK9M=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HKvXn8GK4KhMQrS1FGE9eGnr4pLwssoMMY93gN6hSsSiV2dejA5rOLQBBz1/?=
 =?us-ascii?Q?y6ZoAloFtW+KPsJlgepIGJyrZyizdhuEpW1FZsYulDw99Ni8YIMUXNWSq6OP?=
 =?us-ascii?Q?/Pk8X4CXZ6VuFyccthJveV8xAZOHqCHRpwTQ56yjcuuA9EfyNH9zALVu+MK7?=
 =?us-ascii?Q?xbW9S5XP2slxw5Mc/PUD1zzi2Es9G6t+M2D1Hb8b0WmR1EAC6qIo5PCRy512?=
 =?us-ascii?Q?H0D1q9p/ZvN0erECufg0t0ZPRYTyORG6nD9tLmRIEZzdCo+B9GLfQtbz7rYT?=
 =?us-ascii?Q?9vAaG6EeY94jcD03MqdNXxUAlEcm+YFrIjgjMj+2D4btWcjxw894bNx0Ukry?=
 =?us-ascii?Q?yFUsNYxrZ3SYv8/2aWBN4C0K8aFHnBwEEHejRGiU5ZCXegK6d9iPOHX/kDol?=
 =?us-ascii?Q?ApraVs7FoH5kCm4pzFjfbqjCHjIdlmABFfEaXoOjvX7C1B8lDEGoq77UMuQG?=
 =?us-ascii?Q?dwbbT8nztvFarI3t72Pj6CPmeAtys1CIhlDBLHUAD71V6Ikzrdocfv4fpgqt?=
 =?us-ascii?Q?RGjCdHKEEeIgeGsUJ5w6wD+PtAVhLR+71Yt1b9jTCZW8H+tmkSuFpJMmW0kX?=
 =?us-ascii?Q?TdGJNrSZL+rHx2gLxUtjUyBkdkfGJuoTxDxtHADpGjvRGItESJev2ObI7yOL?=
 =?us-ascii?Q?/CNKy9a7u1WceigdQW9EXBgDsrjxYW/eP6ILpPgdi8ApfgDqmYFxpo2QFHyG?=
 =?us-ascii?Q?Ac4ZZYaEJla/enVVkVLmAdIE+yvWbUjXqaenBSQ4ZsEjyXbGxyreODJRewRs?=
 =?us-ascii?Q?lapUwRUEBlwMaMCVU4/oMRfqTxnXdJjhv5+YW9gWOyoCh8zdvY6MJx6tgtNL?=
 =?us-ascii?Q?1zmBOoDoio46M3atfwJV3eNPKdGLxd/pvQLGhmvaTP+vGQjRf+ccGuyzhGOc?=
 =?us-ascii?Q?dQpLc3mowbCMy/jqaqqpCy+rBW4xah/9qbD1Y4BeABzLSYjPmQIfCT2QGo6i?=
 =?us-ascii?Q?xNHnx2ks69OzDiNwuYosEt1SyxrV0/Pp0Mod+L5+y8O8JLwRdJe85IyFSy3p?=
 =?us-ascii?Q?PddPYf+enBSPg206FjS0tPioO8uaYLvvdOxXMRxOpBeunpWA9U+6b18E59gP?=
 =?us-ascii?Q?XdMaL7H95yhDiO0qJh0YnujmE98MFVBcc6GEebnTs9oHYIIlVZV3TFvWT2JX?=
 =?us-ascii?Q?EvvhkV894eIkMuYB8mlzl5YKFpg/jN02duzACBPYbQTLwH+bJDtg8/DnsCkg?=
 =?us-ascii?Q?JJ94LzEH7LtzXxq4qguPStzfZev+J1OJbDYjadB2r4Te/KFCeTe9xHRkghG5?=
 =?us-ascii?Q?bufzHRqsXpJ9ke/FbjXKY0AqCTS5HViMypEqb513P/db5WjfSSJACYORIU1c?=
 =?us-ascii?Q?O+7eOsLcz1lpJFERlDLB1WVsb2JU+IXKZJpiS24c7bOr5lyJyU/BKv2x5vC/?=
 =?us-ascii?Q?JEOuVwTWWJ3WoQmGdv7IYCON071QxzZYFWpFbP0rerRfnS7H9aRse8WK1RVo?=
 =?us-ascii?Q?kaBmTEeHU1gBDDVyVIrg/kgNrsblpabLmsAvESyJ+Lu8SWqkDghuNODDcOOe?=
 =?us-ascii?Q?iBnGhMFQiKBJEE8kADmdEzHVqEGgGL4b2EGHqpMP4cJ1titLqwJENQxXCPnR?=
 =?us-ascii?Q?TNR4ejxu3PqnlGvUZfc4lxJR0AU4Q7t6lZQfCom05Qk6OeS55cJWoU1QAIu4?=
 =?us-ascii?Q?xA85dTtq5mtlMhplNtDHSzo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49334df3-02ee-47bf-e56f-08dddff1ef66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 14:00:35.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWX+Kf0XKZRPBSgHd8FhQE1HYIornGeyvK+4juZiRy31nhIdNixhtZxi2wP17Jojgb2CyXmynJGs2rHFqoRICABLxi3XlslNIoXawsw8bhHLSKuPlqmojSPzdpWRpGoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 14:00:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19820

Hi All,


> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Lad Prabhakar via lists.cip-project.org
> Sent: 20 August 2025 14:56
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Ulrich
> Hecht <uli@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
>=20
> When performing continuous unbind/bind operations on the USB drivers
> available on the Renesas RZ/G2L SoC, a kernel crash with the message
> "Unable to handle kernel NULL pointer dereference at virtual address"
> may occur. This issue points to the usbhsc_notify_hotplug() function.
>=20
> Flush the delayed work to avoid its execution when driver resources are
> unavailable.
>=20
> Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of
> work_struct")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://lore.kernel.org/r/20250225110248.870417-4-
> claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [PL: manually applied the changes]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi all,
>=20
> This backport is intended to fix CVE-2025-21912 [0].
>=20
> [0] https://nvd.nist.gov/vuln/detail/CVE-2025-21912
>=20
Sorry for the wrong CVE number its CVE-2025-21917

https://nvd.nist.gov/vuln/detail/CVE-2025-21917

Cheers,
Prabhakar

