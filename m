Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D828C87FDA
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 03:31:15 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.56])
 by mx.groups.io with SMTP id smtpd.web10.86528.1753722250244787057
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 10:04:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jfB8ckbt;
 spf=pass (domain: siemens.com, ip: 52.101.84.56, mailfrom: nicusor.huhulea@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1cZfmYWdhTchu8SSJXD9MA/ER0SgEdx5bryyokdfBfTwsYE55SBKG4Kcv3s1RMbM8JlXzWvR8crfR8xTmy2VjnrngggNL1SDE5pkRNoOInnyRPplfsKhQuEMyNqRvkWhnsZLWVe23MKX0Tm1QdsQK5Bycg58CdDh/YLNAcUXMmt4DPc6myrI8dyMKuCNMXFK90iduqYXbyTLrr4BWAVqzXBnqQVhwC0NJobVC+zXWBpPJEeQPh+iDadR1Ed2kyRqOtWOhIlDH5U9m+9poHSwMKWr0GjKz9OZId8VP2xtqwxSTBYKuAmyry8ZzDk/mJQq4lCMqVtwMXx6UjixEAxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QQUEHo0fPGw7Bi9MVYb/oItJfbGktw1q+9DT0YUpAU=;
 b=DjgbnLiAc0Gl0uV71IKIeINRNNHjQUC0YaPQkDhm+WHansNLNLl1eYTk2ugMr/L2TK209SEmlzFUpGsJ1uIOoH5aCyPsmUnMMq6PSZsBRn1TpXQKDWtZ++DKxL168/K0qA/G4LhTW3eYfqNxT7IHyiGdjCJp2hCalFw3/n86OCP4DF+LhXCIZFYCCxXTYcdbJepKcvyXKmXTSpUOWQSx2Zd7dLcn6rGFe/M6b1qCVqAXh2BooYWv80GaaVg8WT16sN5IpEYoZABabWN1EF+ROvisApq43ZuEJukJSba5Qk7wQp2Y+ZO5lJV0c0XK7YIFkYJpCIMkwve6YbA72kcUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QQUEHo0fPGw7Bi9MVYb/oItJfbGktw1q+9DT0YUpAU=;
 b=jfB8ckbthYcqssCtplJW83Ao6ymllrz66c8KrcGm3zmTRjSk6mR4DlMJFI8Sago5tj67JJR9QT2pVQHAgtqER++1NEzX34Ic8EIX0MP+V2zfT/wUlmMd2qxkrZUOFcktP9HNhNL1nYBIk2FhL8saOzmU0b90Z/l+LaI64dc0Rf4Xqa8Eu9NuQM9RaVCMZ8FSVrQMoqk9+zU+eJap5acr85Ku3ygw3qsXbps1DZh//5Oz1lMLO5jrMgmD85VsZNzVYp+cKLVETvF/7yAieHVu+nR0Ap6JU3rSZIuBAaoQv8O6b3hR1UU4oOieco9AiyuJtnDpMvu2zAPfV13nNfLZxg==
Received: from PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:320::17)
 by DU0PR10MB6276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 16:49:08 +0000
Received: from PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::24f8:f8c0:8ad6:66cc]) by PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::24f8:f8c0:8ad6:66cc%6]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 16:49:08 +0000
From: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues
Thread-Topic: [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug
 Detection and build/runtime issues
Thread-Index: AQHb+9D1JO3MDz459UKk3bu5fHleZbRBviqAgAYIj9U=
Date: Mon, 28 Jul 2025 16:49:08 +0000
Message-ID: 
 <PAVPR10MB6910AFDA0F86BEDE7BE3C2C5E65AA@PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
 <871fc209-a592-4fcb-bff7-d97337bdcb5d@siemens.com>
In-Reply-To: <871fc209-a592-4fcb-bff7-d97337bdcb5d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-07-28T16:49:08.359Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR10MB6910:EE_|DU0PR10MB6276:EE_
x-ms-office365-filtering-correlation-id: 72e8f555-3935-487e-fcbf-08ddcdf6abf0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?1PhvKtwCvpaD6dSt0FHFYERWief1J40UGvKqXfNKMAh69ma4VjkHYwdVAF?=
 =?iso-8859-1?Q?A00NRS1fOAqajZaIQqTtILPIzaItTqez49dVeELQOu9IhGYhgI+2XaxcsR?=
 =?iso-8859-1?Q?JHGWzHvBhU4t4z7axXj2nJmNHMkI70ec6o1ZFecPn5xLlUgtuc9amhj8i9?=
 =?iso-8859-1?Q?FW3QDP/MDo1OUisTwj65nqfbIo/XGXV+6ewsZFx/t0d92e0I4Bav7Hh/1Z?=
 =?iso-8859-1?Q?vzwjHObJ0sF0qQ5X87oYz6M2PdWSAhLZNlLkBmMbGzEWlgbCkMvttquU5L?=
 =?iso-8859-1?Q?GdZ9wsQhisVy9Ge/Ekaa5SD+jVLcGYWfgJA6GqDp2O3bv+hQNzs0HxTb0W?=
 =?iso-8859-1?Q?t/XBoOWwCh6zYISgqKLN6CSHLTHth+pLXh/Lv8HZTi/qxiwpAZ8cgiXXJP?=
 =?iso-8859-1?Q?QZecYfxacm++H2uArg2oY3kfCqSw9r9zB1rYHxwvj4fOqWfqUUFhY3bgPu?=
 =?iso-8859-1?Q?sdup+yepbG6QiTmUaQ6YJn0YEC0FUJUYjc2ApfEg7XwltjCEoii7cZQTcA?=
 =?iso-8859-1?Q?tAi4DmqsnkR+rfHzi1IrA2VoxkenHDzOlJ2GVbqQdenONcMSSk7WCpD6Yk?=
 =?iso-8859-1?Q?DTq+sYLi3EUw0irR8cRZJVVpqmLUrAyuSQbiNP0RpN4W851yu/9o6uhm89?=
 =?iso-8859-1?Q?rT552gmwmP9nIEjd10xzQQhMrW+NUiVR2PNI21L35H60CJwK+Xbtk5s57l?=
 =?iso-8859-1?Q?cOWqixiznvblbWRxKrvFqxPql5EX6EaHX3sX1BgAMxDB7Ns3EKRP00nnQ6?=
 =?iso-8859-1?Q?WU72Vm9B4DiLnnBAkIhqGZV3GUj1dySLDF/oRZeYrIB2lBpF9OXnTnOyNg?=
 =?iso-8859-1?Q?DWRSxT/Si+qQ5jE8V2TOx2TbfUAZ7eTFTHedtRTArs6/+VIMNircuhlg84?=
 =?iso-8859-1?Q?6vlS4egZNS9DEVSOebShDc1FJ4el3BpbvpV7bQhaXs8kayCdU37T4RAWnw?=
 =?iso-8859-1?Q?UAGX9iZBEePvXeHXElEbwCU0i5OSLmFrf6BMnasKobDou3CLnanoJ2iH4h?=
 =?iso-8859-1?Q?eQXa+AbbUfsk/kTgjyWRixwsvvmMkbAkipI3EExtAloAcElZbY0YHY3YtT?=
 =?iso-8859-1?Q?OfMT9gncr68GG4b2+0GBleiThJs+mBDSxCz/ErPgIq8kMQDTaPrI4bEHNA?=
 =?iso-8859-1?Q?1c3C0DnlLraFmJupT3EJ3Tf4EYAt8hFx5nPAoNI/VY6yrgMlMKLb1ahwUq?=
 =?iso-8859-1?Q?8w+jchFGAMKPcZPb9rt9iZWUJlSb5EV35XOVU9fb/SerisKV3t5zYop0jG?=
 =?iso-8859-1?Q?49RsDwENnKTMCB/Jdir+b1fs5sDoHQBnwa42/C7OwpxI6Wuc/s5VpU8yG7?=
 =?iso-8859-1?Q?xC/GcbL680kb63cWt36CqSm1P60YdjyAdruCZ1GEX/+dG4U01z4t9iNqKL?=
 =?iso-8859-1?Q?DGe60ng7zsA/zMluNHakQUMCFd9P840eRW9x7z3nB+R7MsSXWWGyxH75DO?=
 =?iso-8859-1?Q?KeyZ5wbYXyl9Vle/i1CJHfnGcXhxv6jdynA/lNysw3nV+ukk0Mrq+Uwyt+?=
 =?iso-8859-1?Q?ErGNwmEsN6PvUAGMz9T7HXOkmRmY5I5RDkVoVQrYnJQQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?rbSMPMv0BiPC8Bru/4M/MF6IP3wg0bNTScZOoeGfbAlPSyib0VV4yNR036?=
 =?iso-8859-1?Q?E10/fjiAa/lRJJkYWxEeKwwJMQYR30QaS8WjA2Fl0XiLPAThGjgXxuUHsr?=
 =?iso-8859-1?Q?e+HE30WQv01+Tx/djzILKCnUzJG8iFjaTmta3NQMGKZZ69N0x3wn6bILyP?=
 =?iso-8859-1?Q?BAlWbRMwy2AB/LT/YQOdPjm3+DfzDr4gde/8BoXFNDQw+p846BKp5wiFud?=
 =?iso-8859-1?Q?TcGob5hxz3l7Z1JVWOEd3F1UoqkwtMJbiBlxhcecW1DIFvGEwN2UUx0bcw?=
 =?iso-8859-1?Q?PFuG6ch1Xv1RTOrgOAGn4AnIeqPcZfv4L0Nk3dJXJn9hSqSmvLEVHqtMx6?=
 =?iso-8859-1?Q?hhqfvIYG5R1ehUixhTTZjYae9W8QuvVFMUmAyFM50BMhc/yBECTjVwRvsy?=
 =?iso-8859-1?Q?rbv0kZ7LI/uffi3RFHLMSQomle/s2rMoJXCNWyWPXOTZX5fAdPR9TmlSvm?=
 =?iso-8859-1?Q?6cfnaOZ16uVcFha0/p24yjQ4AKJjkAlWVGxWQJ9eiqMMKl5Vf8BZ363MMT?=
 =?iso-8859-1?Q?mlInrgdjFr9Rmkx4qEu0AL9fei2CZDm8DlbLgN3UbJY0zDp6qdk76VnqO1?=
 =?iso-8859-1?Q?3+ccV536xRvTGsmfkmsWTWOi8ni0kRgF90pOqFazAZ/9GaK/BSXq/+Wr/E?=
 =?iso-8859-1?Q?M2kXn28v86daR1OoNOXDwRExgenEdi7MnOq54sOm12ZFZIYQwZDTiUK6V2?=
 =?iso-8859-1?Q?MT7pbCwKLyax9E9FoKo+/WFZGYdUQ/OIb3M48FixRI8pfuLXF7+lY1W+cG?=
 =?iso-8859-1?Q?dF0qo8joS5bJ8/r7RUaz2ekcQm60gG6doTZ0P6oAp+AejUZjxQpYK8h4iu?=
 =?iso-8859-1?Q?nyifvB/9edjjlzR1WBzxv1PwP3cpZns2o6gO+/VSokw400QiRtRR2mrY+J?=
 =?iso-8859-1?Q?MrYcpWVaBnuznu9+ovU93LoanxRlE5mrrAgy0HV4WRLLvHsbV6NNW8qeC/?=
 =?iso-8859-1?Q?Xye7UBHZGVbuSq0JJY6LeytfyzbtNs3o9rq3kPzc+U3mIG8/ETjmulxXQG?=
 =?iso-8859-1?Q?xNL1ZbwFBX8kMUlM+cyw1USshfqdXCclChw6PR8olxTgbUR2VeqpEUQv0d?=
 =?iso-8859-1?Q?+P3oG+OjgxFxBAE547NPxs438eagOqguFZKJd0RNd4B/9JwqncPEY12wDX?=
 =?iso-8859-1?Q?mWSnxPZ+k04/dXLWOSuP2C1tyJK92UkIKBTPX31fT7OtqnIlDGK5sCHoKE?=
 =?iso-8859-1?Q?84cbUpUO7dMrTJe8LtXpRCzcGjaPpHoqbIXD4EUjoAQ2VqU2hbENNjEshR?=
 =?iso-8859-1?Q?wO/U5U8JKo5nh22N+Lea6V7M0O6Z46WE44LoVDlpEizeCkC0zVAMcT7C2d?=
 =?iso-8859-1?Q?FO+1H7ynbuJHMbuKPCVPZJiTzIdtn95IDWEIiTxu8ML6i+Lu54GGI9OZ5R?=
 =?iso-8859-1?Q?1X5fYjCLkjLHGczv4KDpPWmEql3z+HlEuj/ySRsXkSl7O2+rRd2V2r1vLZ?=
 =?iso-8859-1?Q?rsnlhbDEQinmli6ZK4Q3pAoilxgenkyKcAqvCRJvcudRub+l/GS93kY/4E?=
 =?iso-8859-1?Q?+goAByFeaIuBG2vAeMq5O8+2VtWtGGkczUIhIinfrld4ra2CJJdbnRXP9H?=
 =?iso-8859-1?Q?C8bOJPOlS2ND7Ky4u1/zD00eVTXnMiHa3o8QmTQtQZ3EG7jvS6ov6QsS07?=
 =?iso-8859-1?Q?s7ioTsppYZXjoL3vLivdESqMtKCS5wKF70?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e8f555-3935-487e-fcbf-08ddcdf6abf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 16:49:08.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AjmZhAPCdtgw2WBFfR7ZP6yIZlC1zUgs10ZXj7J9jy/hNNbDngW9OP8lnnKJI5dm5s7RNYKLoCvuQXEtu6i/I5hGwcbuiT73NEl+TuM9nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6276
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Aug 2025 03:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19713

=0A=
=0A=
=0A=
________________________________________=0A=
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=0A=
Sent: Thursday, July 24, 2025 11:38 PM=0A=
To: Huhulea, Nicusor Liviu (FT FDS CES LX PBU 1); cip-dev@lists.cip-project=
.org=0A=
Subject: Re: [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug Detect=
ion and build/runtime issues=0A=
=0A=
On 23.07.25 14:54, Nicusor Huhulea wrote:=0A=
> Hello maintainers,=0A=
>=0A=
> This series addresses a defect observed on certain hardware platforms usi=
ng Linux kernel 6.1.127 with the i915 driver. The issue concerns hot plug d=
etection (HPD) logic,=0A=
> leading to unreliable or missed detection events on affected hardware. Th=
is is happening on some specific devices.=0A=
>=0A=
> ### Background=0A=
>=0A=
> Issue:=0A=
>     On Simatic IPC227E, we observed unreliable or missing hot plug detect=
ion events, while on Simatic IPC227G (otherwise similar platform), expected=
 hot plug behavior was maintained.=0A=
> Affected kernel:=0A=
>     Most of the tests were conducted on 6.1.127 (manual/standalone kernel=
 build, CIP/Isar context). But it also happens on 6.1.145-cip44=0A=
> Root cause analysis:=0A=
>     Through testing and diagnostics, it appears that the HPD finite state=
 machine or polling logic in kernel 6.1.127 is marginal for this edge case.=
 Device IPC227E's behavior triggers=0A=
>     this kernel edge case, likely due to slight variations in signal inte=
grity, electrical margins, or internal component timing.=0A=
>     Simatic IPC227G, functions as expected, possibly due to cleaner elect=
rical signaling or more optimal timing characteristics, thus avoiding the t=
riggering condition.=0A=
> Summary:=0A=
>     This points to a hardware-software interaction where kernel code assu=
mes nicer signaling or margins than IPC227E is able to provide, exposing lo=
gic gaps not visible on more robust hardware.=0A=
>=0A=
> ### Patches=0A=
>=0A=
> Patches 1-4:=0A=
>     - Partial backports of upstream commits; only the relevant logic or f=
ixes are applied, with other code omitted due to downstream divergence.=0A=
> Patch 5:=0A=
>     - Additional modifications to ensure the driver builds and resolves r=
un-time issues=0A=
>     - Contains cherry-picked logic plus context/compatibility amendments =
as needed.=0A=
>     - Together these fixes greatly improve reliability of hotplug detecti=
on on both devices, with no regression detected in our setups.=0A=
=0A=
What is this series targeting, regular stable 6.1 or 6.1-cip only? If=0A=
the latter, why only cip? 6.1 stable is still alive, and this introduces=0A=
itself as fix.=0A=
=0A=
Jan=0A=
=0A=
--=0A=
Siemens AG, Foundational Technologies=0A=
Linux Expert Center=0A=
=0A=
Thank you for your review. I was targeting 6.1-cip but not anymore. =0A=

