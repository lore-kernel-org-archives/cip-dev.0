Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA420C433F5
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 18:22:09 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.120])
 by mx.groups.io with SMTP id smtpd.web11.15224.1637691636349090630
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 10:20:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesasgroup.onmicrosoft.com
 header.s=selector2-renesasgroup-onmicrosoft-com header.b=fbwjVj9I;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.120,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKjn5klMuauPE9g4eBxoQQIVOHhSbDz1k4d2o7UpoHTbmGFaQCfODBZ8rg53DDljOXc1gdx9jxA8xjaVGcQmQspFtk9u4DrDZWoCIUy8teCU8hSz6o63P4QBsxAdqGstTWgqUBClPYiWWHEdSkY3bk6fQh0gI+KdccHjaRVU+stHD8P2VaM83ncmtGi3GLlCuLkErs5RG/e0UzCvPYvYT8z3/qI5Uu0VLSi/I0lz/10SjOGR3jNX5h+LTcKhy7XMz84wf8c/h1nAfK88i1tHBfS8iW/UnQAC5G+z2eK1W4VjdKoNZzFBhdZEu0uNY7Nb/8kIrfXSazNDpc8AHD9/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5Ibe+N1DrmFKgkkk094C7QGj+xlZnD6RCZo/ltnwk8=;
 b=HQjh2h0RM2Nag/WpP70+pmcOWbJ2j8nZmTho5iWLlmNAt02tDYLj5iXP0e2sCYlqBiFTiykpOGlpLNOmV2JcT3vfj7R5FXe0rsA/3kgybnl3E9pytGqEM7/TA/rg1WO0h38Fu49NHZWCJCcMX+lNF6CaqKe8gVHDH5IUKHIaKD+iIgOYbciBdCIWeN7x3RTvwNdcZEyOndZlSnR5n++trSdKDdvSBPvwv58YbYpgjQS/zK3IZwgmyjc41yF3c0LtMLhv89fc60gV/FF6sJGQp91Va1CMbYwJTMzx7eAw/OKcy2splzoQo06ApgY3T70vgDc990fvL8CYmGISECdzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5Ibe+N1DrmFKgkkk094C7QGj+xlZnD6RCZo/ltnwk8=;
 b=fbwjVj9INv7xAXkoACTpHK+B8l4/r9M/JV+wdLohCVllu4oO+SJcrEmvsed6+MkmEUjpFk9ESoLZV7doXRXUQwaMlsunPNZOatlubAAfR/ciuf75luACL5Kjta2GXDhrTUIjFchQIZni917UPNt0OaNW6Qhu++gwPGxuFehZwyk=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB1571.jpnprd01.prod.outlook.com (2603:1096:603:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 18:20:32 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 18:20:31 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] [PATCH 2/2] conf: hihope-rzg2m: Enable tools and
 firmware for testing WiFi
Thread-Topic: [cip-dev] [PATCH 2/2] conf: hihope-rzg2m: Enable tools and
 firmware for testing WiFi
Thread-Index: AQHX4JZOjS8K8Fuv8EiWrjEOeXV9zawRbAJQ
Date: Tue, 23 Nov 2021 18:20:30 +0000
Message-ID: 
 <OSZPR01MB7019D0C785DE9B138C889AD6AA609@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211123181650.8887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <16BA3FAA9A521607.29711@lists.cip-project.org>
In-Reply-To: <16BA3FAA9A521607.29711@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f28038a-2e89-49cc-69e7-08d9aeadef16
x-ms-traffictypediagnostic: OSAPR01MB1571:
x-microsoft-antispam-prvs: 
 <OSAPR01MB157128C51EC8CAF48F83924AAA609@OSAPR01MB1571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JLLyZFMDi0DcHnCJnkwuDM0/6kJHe8HgjBmwlu2NrPdbUHxkQ54JU77aipcay6AHZ2DMjP76+6qVBYBzCNjIzUp5mA8ucGs5DpQToNBQFot8Ln7/764agQFwKGA5lFWblhEhVI/VA7RDJq5gsNdiZmqCDnoWDPORpXfQeccVZsyCPF4QYpzLzIDjA0xoXp36jtwNzjkjlGsvRaHeDZDY4Uunq1p1VvA/+8Q1Tzbi7liHat1MnGdY7XJ2HHZvmhqhBiTOgV4xa1oDHkCXhi6MIOtlN3UUF8HiPHjUEItgF6puWPYO1vP0OjUhSndRdOqgwFqYDtuOpkAdzlDsJ8Hjp4T2CX7H9cw/IROJPG5CpmF6pgOqRTChp8PDWnoifmIQ2tJ8v8g0wRoR0IpbN2X29eCMsuDqTa3KAiFY+BdMGutzAYrKDuk7pSL9deLXnW9P87azknHTxhbBOf++bWTlWEHf8K3t/h+vfCzFlmP3vXr4nQec3TiXG85Rr2dF2Pnyz/qKkcasUBpaS+qO3mV1eb4VNaeWjim+kDmVHu0Yk7EXOj7a1WshRzlBKjePVFzz9isoYiPUDE0Z5raBVPMNEXrCuP1YB72rMyFz2Hw8b25OTz+m7JBk6DvjYKDvVXVI89zlB4oyR1zX7Wq7XIJ15wAs1zVrH4rXf3BoeT4CmxVuJggIGjLgTVeSNhaBvdCpkEyQj8uHaBibHFHFkgrQkA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(76116006)(66946007)(66556008)(66446008)(7696005)(508600001)(64756008)(316002)(55016003)(66476007)(5660300002)(110136005)(86362001)(8936002)(6506007)(9686003)(52536014)(53546011)(186003)(33656002)(83380400001)(38070700005)(8676002)(38100700002)(2906002)(122000001)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+tYEVjdQ2jEwE9pvKPHMXWtbKafnlVv+YvpVv1F/DSRi9d79AfZlOpned/Lu?=
 =?us-ascii?Q?hEGht3nIwhCtS9PEoqaV/RoY0JO6FIBO4IrctaaCQr65qVk6/wig5girN/bs?=
 =?us-ascii?Q?5bDgpVFHLxWU/Dv42MZ6mS/f6zSvxCIkh+7+5OVygKCkiibf+PoVfAo+MP74?=
 =?us-ascii?Q?B02TPwhUmnZtdswGL/H166JlMjiVEAZAWEPoNhnj6zTnEQ9DpsoKuqjEIfGe?=
 =?us-ascii?Q?rNEDz9u2t7wX2lPluPUT0BW+JkCBE7MUrURhY7uzwpbs00Vk71RP+thhH/Wi?=
 =?us-ascii?Q?zqhmq0UVtzOv9QcMqZEBEZUV+Zs0cbYuMsGjb+VKjqpxe03yi944pCrufAwE?=
 =?us-ascii?Q?HsRWkoE0eL7auqBJOw2Rg4/EADwYER8yMmdLW9GpPvuKdwrVJYYY+v5DQPOW?=
 =?us-ascii?Q?g0Ha4Pn/gCxg+7kwdYk2A7enBmOblQ1hV4R3sfIDmv5Jdu93XCBnko/qxGeA?=
 =?us-ascii?Q?LZkOUfZYrCTv2q45quZCCJ9cmvqsFWt0zQXXkKyE0qgXnXPNq4L0sN8fcyUR?=
 =?us-ascii?Q?0AoVLg/aSx+TISbe8yxU1JkKJTe9sFgczFeEWNs9TFQs2wVKPqdH2qXgSuby?=
 =?us-ascii?Q?z9yt2Xrdxxt2PQLko1oH3lR6gQ0QaVr+6n5cWv4yqXObCO/ifz94INcycY34?=
 =?us-ascii?Q?jsH+wchKMKvd9wBkFpF8Qce67XrAOybfFFjWgssZSC18Mf3vEG+09InxjggM?=
 =?us-ascii?Q?p35nCgw5YQFOFvbDKXPglimkNjx2z0c7puSKtjtrE/bLlp5BPyGt15pawzN/?=
 =?us-ascii?Q?YV0ODD7TWVoqJNXLN3e79uAk2+Y7mL30dUR4Z+7aM3Epg73MMlGsgqDLDiW1?=
 =?us-ascii?Q?RVJB8wQI/s8cs8VKiTL3B2YEUMGfZ7pln/AbrIv5Sv8FAfPkG3zwfl/W/QxD?=
 =?us-ascii?Q?hnmgJsveKvXu+qRAA8Dj86scHg/sdW8aqGmFFwBudnivfVFqAk+jmBoCkNzD?=
 =?us-ascii?Q?zRSUx6w6isVQWO5zc7cwC+mgERfWF68Okixy3rJBK2iT4mrgqFSPYcqilChg?=
 =?us-ascii?Q?LTpX6H/PpXB/jg+8MkWp/rIIvo3focy3ntK1IZR+BBIdeQmmuCrkMfplJfbK?=
 =?us-ascii?Q?s6oL85b1uI+Z2jc9VRJZK66bhYMpgInl2/tMvr4kRq8fKDdxkOipx4zpHLFC?=
 =?us-ascii?Q?V+Ke9T/ZACXi0l7fDcleaQv7NEJ640auWudXb6M/sF/+lpfT8Rchngh6jUYO?=
 =?us-ascii?Q?bHNcG79D2Q7hIbYGLy7uRSkDHvROMOcjrBXWLYseLyqiy2BiKdEfAaNOcgkx?=
 =?us-ascii?Q?IXCkXksTjDK9ipBi/osN1tXVf/ZwEylzAb/AqyfrLMd0Vv3FPQZvq7BeeoPE?=
 =?us-ascii?Q?A4W3IPQLQ7VfV/as4Qm1BYFnHKmopFiC/laFTjasSXmaN7/IRScXm7ysOhbI?=
 =?us-ascii?Q?mv1KARmcXtsmfSM9kHOhWQEQ9+UEMKWGDRJqkTO3sLuKzPbtvcGzON5dN6CI?=
 =?us-ascii?Q?/M0/6BeRLlV8tBrxrYmZrMQvtCiEVmO8MdB1jhD4xg6Km9pQYb6UvUEoPXlx?=
 =?us-ascii?Q?8LQkLJtkS1GiBlwjU6LtinbBPYcdOTVfnf3Of0ZYdhyfSihKHYKARkl4afmZ?=
 =?us-ascii?Q?UdawI8NzUXq8WKs7xkMm/yhf1nsx0hQS8+J91UCgdhl17FEaeKsNNgxBEmM8?=
 =?us-ascii?Q?c6smm/fMWfwj8QTrnTvujI3Cp84o4UDlBZcZlOiHQiI1jl8RqlSxF17ilCti?=
 =?us-ascii?Q?ZIBnR59IB+apXIuHVRnvoCzqJVvTop9ZL6zCbA5Fc6KPWRuZ5ET8Jyd1lWFF?=
 =?us-ascii?Q?7HJEIqWd9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1f28038a-2e89-49cc-69e7-08d9aeadef16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 18:20:30.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 NU+AZsD984oROxeIOLK9RegG96kdBfJxPGh+d0FqwGBYuOEH+4mlcjI5HUcYZfgww1nDvhTMH6YoMAQkn5TEmpUwX+po2IjM8kZ3wwKT671f5fO40+CugOLkeUm1Ky2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 18:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6980

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Lad Prabhakar via
> lists.cip-project.org
> Sent: 23 November 2021 18:17
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Jan Kiszka <jan.kiszka@siemens.com>
> Subject: [cip-dev] [PATCH 2/2] conf: hihope-rzg2m: Enable tools and firmw=
are for testing WiFi
>=20
Sorry for the missing subject line. I will resend "[isar-cip-core]" in subj=
ect line.

Cheers,
Prabhakar

> HiHope RZ/G2M platform has WiFi module (WL1837) which requires additional=
 firmware (provided by
> firmware-ti-connectivity) for the chip to work.
>=20
> This patch enables tools and firmware required for testing WiFi on HiHope=
 RZ/G2M platform.
>=20
> Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  conf/machine/hihope-rzg2m.conf | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.c=
onf index a2ae03d..4f4ee81
> 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -17,3 +17,6 @@ KERNEL_DEFCONFIG =3D "cip-kernel-config/4.19.y-cip/arm6=
4/renesas_defconfig"
>  USE_CIP_KERNEL_CONFIG =3D "1"
>  DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>  IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
> +
> +WIRELESS_FIRMWARE_PACKAGE =3D "firmware-ti-connectivity"
> +INSTALL_WIRELESS_TOOLS ?=3D "1"
> --
> 2.17.1


