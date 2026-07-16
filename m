Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0909C44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:11:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9525.1784196677296118479
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WnnvE+Re;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.41, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ73Dh21ncIHsvUvD18Vr0hnJKKcwYyCeTQIl91CxJwiFbgDoVXQyRdDSXdKeYcD2OSblSmk8elOoCDk/CTlieKmAn7GOhmv7CzA9CTOuqQp3RjIl/JYOcV+l96xkJ68eUY6sy47noTt7rvrJDHza6lDuzSfNpMvNSUFVoUr83YVfeOr7P5FxS5xouCY5ANdp7BocEvKg5WvSwrKF4e5Xhapt4BljTe/ASYTuqKgS+ymSET20LXsClDxqboKOGkGJNITEXx8udjSsD2555wb9M4ipjmlBgxjYDHFm2DBCHZIOkZyy2gDaQOuSyjnGavlsyy+3H57JjIDBYa1BLhCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEboGNtvbIalAgYPEeHdvvKvJRu5PT47iNKn4y1ce7E=;
 b=CA7XeFxsBvav6gInIvCRstX9jW41QCnvr1jCK5D+z+hI+7p48HM/ChD4HQ44te8AReSqzTcOZTBzOu0mnOAzNqqB/Xv1lYwwbOyDVU6VQabgZvztjmhHg3NYJrJzE96RDA9pMoBJy6R+y+kbVwJzAGN4ic6nj4NHfVUpO7qOe4rDIUCxGWSqt4rmPHoC/TWYOsJhSKt6fqC+LbFahiBykd8hBMRNp9RgQ2J3uGxWV8a7CxcPu5kgxEEi2yVsN34u8T5bZADiM3ubSbLgntLYNKzUtnBh+yFydg8l9tJ4zTM23BDag/IIYPe3vSsA5msgvTx9FM3Zm2laWOIPO5VueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEboGNtvbIalAgYPEeHdvvKvJRu5PT47iNKn4y1ce7E=;
 b=WnnvE+Re/b+y+qOqpCsNwdin+y+icBQ2IOJw5xcruOlpsFVvrq83YuLvY5sKVCc6+hFSRSuo+9XwGCXCmUDFtDU/DTbWHPRChD2RWtnrrmtVl3K/Z5JZkmEJITEXCGXQ94Isg2xBz7m0UTD6f3DpfX0QnzJT1AdYNsLbxEMveIY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 10:11:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 10:11:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L
 pincontrol
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L
 pincontrol
Thread-Index: AQHdCtsHHlRe9fbGFkG/OkEcb5y3YbZv25wngAAlKbA=
Date: Thu, 16 Jul 2026 10:11:12 +0000
Message-ID: 
 <TY3PR01MB113464BDAE2112B58F3ADECDB86C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <18C26F8AB223D098.2287905@lists.cip-project.org>
 <aliOuduY4Em7AIBQ@duo.ucw.cz>
In-Reply-To: <aliOuduY4Em7AIBQ@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13955:EE_
x-ms-office365-filtering-correlation-id: 1e347764-af17-4b63-d021-08dee322906b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: 
 Vvwr4mmC594Xf6ZJE6ELDZa/UbJiIQOqr2t/WWDcxoJ2vL+jCs718XGZ29fa606imkrD4Q7BfbgG8W7M0nCTaLcjV7BRNDbipJuJf8G01tk/MN2rA4lfEFFVUXBdNbiu+r4VkxEwNbHCZ/bYYWjkBaaBOmV+Z+viVqWYFXnY2SYlLeEgjRPXjp6lG5q+F1FmrflAQMabuRo7+w0Eg3/U6ulmmD5PEOrC0KH4FIbMOx5yScCN/WOyN/NyZKIgsSft+10AbZgGUgU/r1KifAxL+VzydEV48shQadxyHYDcqFipjtrYQcVK8A3b03NvCd0j2ouH6voDpRP8NGcL1Mr9WenWd9vy0/c77jur925K4UQNpl79dCEldRyDFE/lsdsv+NagWAHAUz3JAv5HXasQxD7GYqyH8kMk1KGXSXNWuSU/aUitMI3W7KCUK90oRy5+v/ssUJ6Bp1oHSW2x5edvRMoc1Cwz+JA1lOQ0t4rO6R7ITndpXxTlvZ/AOUeNu8y/Ftbl6cpLdHvgZ5ZYL1HjxK/4Wg8vcPVsyOPz5Dsx7J6BrCrGqGb4XhajBIOSf2edBcBJnZsRYKK94ByRBzeZNYsSyWMAxd2X8BQLts9iCBSNkct9XaxKsN+ROG5LPnF9Cxwabx+3Lj9CJu6KJTOBDKxNamvXR7rf9KmOeM2uXTVLi10E0Rj6eR2Nc23E4EP+sKqoHjia4BeObug5qpOiZeqwcKC3gB1GVI9yutOIiCI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tx1LESfDk4d5e+AAA5fqizXsiSjxDgEDDgT2jHlVzGeIUtn4yqqmY/VvJOws?=
 =?us-ascii?Q?l8alJGhVDOJxaD9w7qknPSRc+EySqKGNl+oyQlrLS15DRvRHGI3d2uJ8MKAD?=
 =?us-ascii?Q?flSQ+XfVvZph/bnnQhUrUWqa78hyfO/DAUkmg+Sh9bJkV21w5Gn4Y9d0UYBS?=
 =?us-ascii?Q?+rL8Hf57nWym4OK4usLVfK3WOrTPmUJPifpxLuUHvTwN0rgzbholz12BYjUh?=
 =?us-ascii?Q?XYrVmSlPzfyMWqqTihTjoPBziXXYTeciVZev0vwHnHrhkYThDzqFLVsPd6j/?=
 =?us-ascii?Q?6U7Kr4Eg8F8S507s1e7r8GDaG6gOWDD9XR8qitdDiVc9reDH8Xawbehs66WA?=
 =?us-ascii?Q?DKvOGYsleZsuEIRcrDqGTkfQWk/3PvRPlX7oSb9JJUowxKu4exPJte67chCA?=
 =?us-ascii?Q?Y61+H7GlJzvpMbMHTdIAj3kYulrTGH4yDw+zGFtomIHqjIuFuuP0O3x68mvt?=
 =?us-ascii?Q?IQJ03CXc07GtmPs//gY4STLG2xPKb6xxdY9qkmVoQYZoJ2rZ7wYlaf+FwElQ?=
 =?us-ascii?Q?wn0iMZ6Zd3HXVE9tYgoOj7uV4v9rnqfBb7qlqH7EwiEeuwJdnseocly+BT3n?=
 =?us-ascii?Q?xE3wZ5JkRNqle+YxwfjkgBfcsXd6KwY5iTJcMhb/KK6SQUCaMiH+7bdhogkt?=
 =?us-ascii?Q?crCbLtl0H0MwRwZuEGuR4KDoRtsOV64yIjgASCLZMNaCw3ocRADZBqhU9RF/?=
 =?us-ascii?Q?FZy0zOu3NP/Qoe+3c9OofvjvCsKGcLZnVZluQulvBXW9JUfiHWAd6tr0jmAc?=
 =?us-ascii?Q?TTrb6tD0bAueN04UXudxNlbK9/lg3U4rohglFR30yLtS0pClTE/iNqOhKf0g?=
 =?us-ascii?Q?0qiS7NQHYHRRzM8OHww2CdB9wtIjHA8bj/N4MfFu1cGzx50DUTkcXDFBiIoO?=
 =?us-ascii?Q?0dGe1ZEzkg3ET8RyxCbbvvkWmyqF96xIa0ToZmU6NkGo9U7isfp5CkhBIyde?=
 =?us-ascii?Q?wi9TyjQB5AiwMDTy1ixwOlg5D2zqK4kYIwk71F5QQpkPc7Yy1FvXlvqkfmft?=
 =?us-ascii?Q?sXHCzcmXf7GPgnn8JOZXIDTpKplwsa76ZugiXFKmvXCqUn4Ta37QvjG46zbN?=
 =?us-ascii?Q?ZM4e94w498zymuiB/w2Fi2Qs3knGmkFNt+CM0HFp7FOdVGFzLD81jSw9EGZ1?=
 =?us-ascii?Q?zoxtD4PK99l59Sgbezegke7DrWU1wa/9AsbJCAdbSr2qCfpODLZn1UdMyLkK?=
 =?us-ascii?Q?UmsFOjXxFzR9zIYqeQ2toB0ToOm6ZlNWeeCEwEQL/aM1BmRiSIByLCttADUS?=
 =?us-ascii?Q?2aScUS/rr1AT+B5IEihNF7oMG1a4B+tkzHjfqZ690ICsHo/LGYv+e11xabSf?=
 =?us-ascii?Q?5iIufjYCaEaRgrmMtG9+8BA+aHzyx9wal6ggJXSlVenuQvRmSOV2ylPJH5hW?=
 =?us-ascii?Q?XfcJhU48KqZQZp5GrZGywKEhKs18qrSNqCM2gEa+WMgSf8zZqq9StOgwsI2h?=
 =?us-ascii?Q?ZzoO43OgzWhwCXmyILY2i9yAWP1xCMhvVfg9UViE/aNEXgAjJ7Saw65acvNb?=
 =?us-ascii?Q?qErtyNqg6KEm7bBoZBNS7AUPFSi5l+p9igOXtnZwZC0zub6dqsdApL9KwB3Z?=
 =?us-ascii?Q?bwi5WJ3/0nv8Cwp7XsuUiLxthZnGsJpbViga5+jyScE+UemLvjQw3bi+Xc4r?=
 =?us-ascii?Q?s9xwg7ZCfGEObnT5fzelA2Jj10uieDIG1qtn01ov6jI0sQM6GyJ0iREkERYx?=
 =?us-ascii?Q?6lCXwx4hxsZ8cLA6o4bIaWiYWCPRuTsrPRNbJ8276OHer4irpW28wxJihp9R?=
 =?us-ascii?Q?f2fRBSCVNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e347764-af17-4b63-d021-08dee322906b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 10:11:12.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dwlwoxrt5p4Q8zZfPWgXnzx/OXEnmEc9UvhHFzQI+3cYZfwR6SOXCZ1+Urg1NQofKvLgvFJUibMYILP3ndfmQeVb+sSdREh01zkv+qd/wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13955
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:11:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23612

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 16 July 2026 08:57
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L pi=
ncontrol
>=20
> Hi!
>=20
> > > This patch series aims to add pinctrl driver support for RZ/G3L SoC.
> > >
> > > All the patches from this series are cherry-picked from mainline
> > > except the patch for dropping "syscon" fallback compatible from
> > > sysc/sys nodes from RZ/G3S, RZ/G3E, RZ/V2H and RZ/V2N to match with
> > > the documentation after backporting the commit ba5095ebbc7a ("mfd: sy=
scon:
> > > Allow syscon nodes without a "syscon" compatible") to 6.12.y-cip.
> >
> > I had some minor comments here, but those should be fixed in mainline,
> > first, so they should not block the merge.
>=20
> Aha, as noticed in patch 02/23 by Iwamatsu-san, this is actually wrong ba=
ckport, not mainline problem.

It is issue with 6.12.y-cip. Same binding patch applied twice created dupli=
cate entry.

>=20
> So can I ask for v2 of this, with

I can revert offending patch and send v2 of just binding patches.

Cheers,
Biju


>=20
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> added?
>=20
> Thanks and best regards,
> 								Pavel

