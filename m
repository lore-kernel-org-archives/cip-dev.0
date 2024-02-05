Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492BC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 09:45:35 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.121])
 by mx.groups.io with SMTP id smtpd.web11.59196.1707126331280634287
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 01:45:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=tDA4jSKM;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.121, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYQtqNTLQtH7nbwH81sBweyHXm2TzxNyn/DzZ0dTFW/XRqTSlKu6nQr9FkvH/3GIzKHfuua1D42Sijz8g7ZDKtiIpHY5pEFAd/kRZs120VULqm16DTef6JZM8Hp8LoWnKZueVtkJFQ+uI37laXxDkHWrqge+aMe4xTo4GN6KThp7gYiJvtQkvuU+r3DoYbzdGjMOGOkLBWtdDMeVDg3FCAkBkcg1XhdOEpISg7M5tA2sZ9FvyrZeZh2Jv78bPkKEObCwAlSJRpfbhyX4/r4O643k4ykHxlP9PKrawxhzfa+bO+6WPyz6ibH2KK3r7zd8lGQJR6+LWt6OB4pICAtlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJL8XISxvor1NPXC6kHm+Kn38mg/Hfl4mC1rVdbRRfo=;
 b=hLAQorIGcWuNZGZOj/TBzbcsQNWJ/wcTJU9iEfswXv86WLSE9eYDyWXsB2y4kEnfTFnYLkCIUCJ8dfNQvaH8OZqIMexceruJFWIeM1XYld2nQzQz4g/aOgA+++YMIWnfU5nKkuyN4u5ziIfLnsIMcjhFRPo+gEP0Xh6JRLkTqvpbPXepVv3mL5yYOrj8HJEy7dIvYBykfRAIGB0xSBE2vPCVkwlevh7+m5OzbGceUVJ9dkozm6xyOl3AhNZQF8WcVw92fex2pWa9QrTDmgPQ9pXYgCMpKMJBxCa1v1CK6+8NGT/XOfNAIqXYoCpqWgtSCDclx+HfQLOGe+nGX5Pmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJL8XISxvor1NPXC6kHm+Kn38mg/Hfl4mC1rVdbRRfo=;
 b=tDA4jSKMi1nYltIVjJJCvI3JqTDjLRNOfbm6EragjNvzDGKaf0E3h/O3yPzSEihvStfwUKdMXf058rrLeaF46CSKmNPGDCnd1+BHHmxj+hPjbd03fG2zxfEjMrm37qAvGf/aMZzzCmDZgh12369wVSj4SrgO8VbNM6t4gIUhqSg=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB10227.jpnprd01.prod.outlook.com (2603:1096:400:1d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:45:24 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:45:23 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: AQHaVDlhz35XwbGvJU+n7DaOll4U2LD7hwrw
Date: Mon, 5 Feb 2024 09:45:23 +0000
Message-ID: 
 <OSZPR01MB70199E2D7FE8CF56D5536481AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZbowIA9sDtDExkBU@duo.ucw.cz>
In-Reply-To: <ZbowIA9sDtDExkBU@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB10227:EE_
x-ms-office365-filtering-correlation-id: f5303fbe-8f28-486e-652a-08dc262f2ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Om4mo9OTacJV73G4pAQqeY7y8Rym+q+wH5Pwuxo1dONGBzI8QXg+LbiUn/U/k2yxDJsZ4tclJ5aqODari+EjF6O1ZjUgDUHx5zDxa2B16k1ES4CIKgZoJ0BCjBR0kORBJORL4tMg3G97+dL7dT27M24kjasg56t/OkBf0bmHMrVJHtobyd4Amqe6p1KddoGLIdscSbuqvyrbXMnW2v1pV6jQkyIzkmwPzBJtUTtDQCJiOr48U7LkIVSm57v3W9c9BLPQ8rswx2elqkRtJlk0yFVZ1d5mpA2W0flkA8+RkhvrZGEm5QiVa2JYqyxDHaWzv3ZweVm91t+OCiN0QC/6HX7ma77t5xJbM6RjnnqJEmFhq4XRIiXsHxhvKRWNDTQAO/n58NJOyQij7segpXkBIWnrXlJuzlcPBRlyJMN4IW5sViiPqtuScyk4WeexcIRHaM5wo/elixmzUNCQ+g8m7EINwJnh7LLq71eogRx7sa9djhbABEkN9dtZas72M7pIiC87rpLrBejW9dJa9V+gYZnsm1nMX5T41yTDRP5/DX/yQ3ERmuy/JoTTtMciYZzHqJLIJW0PwZvbxJ6C1xYbT8uGs0+ySYuZBEuocz73zkrOzlPWlHCvkqN5cAHn/mfq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(86362001)(41300700001)(33656002)(9686003)(6506007)(107886003)(26005)(2906002)(53546011)(7696005)(71200400001)(38070700009)(64756008)(66946007)(66446008)(66476007)(66556008)(478600001)(76116006)(54906003)(52536014)(316002)(5660300002)(8936002)(83380400001)(6916009)(38100700002)(4326008)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?H77DBrY9SkP/OLUY8gYhLTpqIVO6crRVy9V2Psun2Qc6dCRmt3E5kISSRLCB?=
 =?us-ascii?Q?+m0a20NMNgQV7MhOUKFV/VLfpoPYx3qZx6y9D/drTZ9lp1s28CwDVxJLuMd9?=
 =?us-ascii?Q?g+3LhSud0slIlPGfO5is3dv3Jdha0JzXF5NRZ0lNNZZVZdsY0HTJU1ScLcUG?=
 =?us-ascii?Q?/6xS/GeH/d+/j1ewfuJpqUi1jsojxZj4rWXac+JjLVi1Og2ktFZ/5BnV9JRV?=
 =?us-ascii?Q?DCzHbt5aT/RrPh3dWY/yOleOM4QaZLIXGiHqBjXTjxmsB34Z/2gm7fKLVSv6?=
 =?us-ascii?Q?Mju8psz7v7qojkoIlcFmJzX/sstkLyopmumKyM5Jn/2tYOs6PX3fybmXXM1/?=
 =?us-ascii?Q?hf2NO5brNsAvs29LN4Itam15y4Q/bHPYYECGH2QxyXsqOQjaDXZrKWNrc7or?=
 =?us-ascii?Q?R9WTWByLRHNAp0dvBS62Ok+uQHRzMaknIUyfs93QU56jhuGi8kt/cKBYQiZW?=
 =?us-ascii?Q?L3lVCXUxRc1eFniPGMkaM57vjAVrOU8bwiiuhb6zkaEJ9sZCbhDSrwyrNH9C?=
 =?us-ascii?Q?RJ7ziqHf2LLiRyG1sdCEwzKI7IVxitaX5s9AAajB1Wrhkm5cWZLRZFaoNSIP?=
 =?us-ascii?Q?BrEpLm9pwmNC6wpH+mgqPCjZLZq3O+HqjIpEl6bmaZXZy+w5+PQwPOM9EH3O?=
 =?us-ascii?Q?5LzmMrcQRXcMqOrkdnPl2P1uC2wugrrPrR/EkEIPyW06ErOrrZo4DusXvNo9?=
 =?us-ascii?Q?4fB8xTwSUVi+TA8VZcQzOEnC6EE3wFtlWD+sdh8B+CdDPKJq6cXIxIaUKzoV?=
 =?us-ascii?Q?YmVQYIsIooUrdVRoZFor8BeFyJMEo5ODipqfd/NUaM2kP3Q+1GlDFX8cZyn3?=
 =?us-ascii?Q?jAANGgZQcirCr+XKAohSqTftPOhb1FRMefrsVWgnLudLV4SPA1zHMXXGlWYm?=
 =?us-ascii?Q?Ci5GsNNTCDnLKPM2cDQQOAitP9Iz49p9R2EJNuA2G3p+PLfTt2WjWyLbzXxv?=
 =?us-ascii?Q?eT9ueD1/SGovJnmJ4voDfahzyrLnHHzkSQoVdVL7IwJrfkAkYsRghgglA+MV?=
 =?us-ascii?Q?59H67hnVGqyVTsDTXurGEFnkuawffqmK4X1k9ugXjgcLRXKDcFoKgXULd9dl?=
 =?us-ascii?Q?kBmTG4VnhJeAbDLAAJXaGnbtYTcgL77SDrtB6RpB907VhjsDcrYUSt4YnRtu?=
 =?us-ascii?Q?tKbcfm9ojkiLfdQkWdFP0chT72OsJaG5suQXT0S3N0TEp5sMAJT4JiN466tq?=
 =?us-ascii?Q?SmO/PbiPYz6b4sLYq690diQ3J14vPxVVp7ICOrR00z9I62rFZr98VaYJ+2eQ?=
 =?us-ascii?Q?MHac/OVQ6Q5LzJp7+ZAKzTCwGof+VKosJ+j6PTD/TgGXFtFookiZ3m91Yxk6?=
 =?us-ascii?Q?6afYrZG2JLSX0ynsvnUwH7BZ+s/wnCFeVa2ymrrw4GNMPAGONV9GNF+U4c0y?=
 =?us-ascii?Q?wW+F4efMpGFqQfjvThDvRuNj+VRJHOv3roKqidTzbuVbeIw64dgLU+REAEt5?=
 =?us-ascii?Q?4mHm2vW0fLz/9J2iU9K+Qz0UnMB7/Kwn3xwadYGZ676k+wiSppM7q35v8dtX?=
 =?us-ascii?Q?T2Nx+J4yNil/wA52oYjUoWat0HFe22GSgX9kdnVdtjpkpWxOqbFJnnrSvhNA?=
 =?us-ascii?Q?03sBwjIXwosv4bBl4891FTN9fl/6hu4yFDC2fy9Pk8l0Gq0Ml9imk9esBSY+?=
 =?us-ascii?Q?i87xYh9O8yqLhf8jZ3Kjtk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5303fbe-8f28-486e-652a-08dc262f2ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 09:45:23.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPT4gVLTVcLN9OPKOtmtpAcCVrjEv20BmyTfZozqlluOHsj8eU5XOUAGDgLUHrgLpGTpDqG4i0/XY3y778ojVfmcJ94CMSvTmF1f/eUuyyyUQf4G8XdhzutGAq3wIYuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 09:45:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14662

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, January 31, 2024 11:34 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five=
 RISC-V SoC
>=20
> Hi!
>=20
> > This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> > support for this SoC has already been added to 6.1-cip kernel.
> >
> > Sending this series as an RFC as,
> > 1] Support for Global DMA cohernet pool is added 2] As support for
> > non-coherent DMA is missing for RISC-V core,
> >    required changes have been added directly in ax45mp_cache.c
> >    (ie patch #26)
> > 3] Patch #26 has been newly added, rest of the patches have been
> >    cherry-picked from upstream kernel.
>=20
> I quickly went through this, and found nothing too crazy. But as this add=
s whole new architecture into
> 5.10-cip, I guess I should get confirmation on the IRC. We'll also need t=
o add this (and RISC-V qemu)
> to 5.10 testing.
>=20
Now that we have agreed for RISC-V support on 5.10-cip, shall I send non RF=
C series?

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

