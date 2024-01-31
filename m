Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87EC47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 10:38:46 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.106])
 by mx.groups.io with SMTP id smtpd.web10.11217.1706697525216553596
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 02:38:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=n5OzFt1H;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.106, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaTuPOuZ9u2fRj/lJIMBU/NsRsYK75cajgSZHQpPQbKKlzzaKlNK4v3mok1eluytGVFC8t+fWZOeh3/ip3inK6IMb0ADa9pyk8q6yD0GZiTZvEFUlASlZyljkQsjyeC9R0kpZ/wLT1Ji65dVdWAUwITph7HK6AV9mwc11oXMWzz+USyCvLZ2UgygrolxtMhdxUnoKS/XmLgVapJ7GH8D3SdLZsfprFSRoMG9IW0AfFQk79MBGg6y2KLQ3rj1Y6BaevMajPKLy9M3Jm22LErNb/HIj07DbtmLynYL9mL1zo6EVzTxhWk6nwNzbbOWUnH9DrGBijvgNcgRmChHaVrk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmgP8NhowMCmsZiHOnYx0MfloWEku0Xjf82nSPcC5pQ=;
 b=k3Wg/EEKGlG+y7+NWZsuizr3BwhXw491FfT+d9P3ESnrumHWmALjQYR7pXNaKltymODmGvd7xDQc6t7KZIzopwpeb57rk4zbuwUCerlpPAWDwzQ+2soGvusWQVBHFqa9q6zJL5ZPxec9Oj9W+6x8awVxEJiWeh3PkZa1BpxCa9xRm2HNXuqdUYr2Eu56XSo4F3YTS/bhlHbrIUQWscIUPevQATBszGM6Z++RtDbhCcPAbwIm54cxFtOOYmQ2YLw8Y30V//TCUBH0JA96nc+42JIEp3jgZ0cOrPb/46dlwQQ5du/hrUOLjHjcmGiFarDUpjEOGdT8Nd5dZE+tJdOG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmgP8NhowMCmsZiHOnYx0MfloWEku0Xjf82nSPcC5pQ=;
 b=n5OzFt1HBIiBMhNJYbHysslN7CSiYfrvTRHbCCgUqUH528a4hAGt86DJa2RlZxbtZAlNVJuTxfQZVVN8V8GPGrA2dZVWSOLtV0fAh0XLI9YUpw8AmsJKZTmuDBOIuqJWs/v3fzbp3tQE7TPGtZbPApDuJRH5G5MCbzv43GOZ6fs=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB11884.jpnprd01.prod.outlook.com (2603:1096:400:3e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 10:38:40 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::86fd:d1b8:7db8:2f16]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::86fd:d1b8:7db8:2f16%4]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 10:38:35 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family
 and Split out RZ/G2UL DTS/I
Thread-Topic: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family
 and Split out RZ/G2UL DTS/I
Thread-Index: AQHaVCv92Tsm/EHyokW/lumyYGamGLDzujeQ
Date: Wed, 31 Jan 2024 10:38:35 +0000
Message-ID: 
 <OSZPR01MB70192961567BB010EF309A57AA7C2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZboZqpdu5x6aEohp@duo.ucw.cz>
In-Reply-To: <ZboZqpdu5x6aEohp@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB11884:EE_
x-ms-office365-filtering-correlation-id: 25a0d951-c15f-47b2-8c75-08dc2248c734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wJE9ClFsuDqLtrGlxdepY1d2/smpxsaD71pwm9dgFzuRgW9W+qvYV4UWiX3nY1Zl/NrRYGFF8JyZDxommY3U0Tc0NJP0Aj/9/FhsmkNJNppdQKI8lUeIEc7IrXAIh6izWvFQ8aRwaJBJhIA6qDLluTKeJGCn9H4FZmRdY9PQLU4OCUn4xVcDpodzBPKPEMKy5KfUoS5zuIfCj9LaIawW0gY1hslyzOgztPOXLprsLP7k96n9YEmEOrhhVqp+eP9vn7MXmMju9RyC9V9JDXvU1juiAnS4xR+DijHk5O0PmkRAzn0lRtUgw4iLYXGBbPTqO4+ruwPgVgAcGnRS18AwDRY3eHfTblVLrnxZ7OgF/CpNQZ+iseXb1IKiz7jMA5jbtkMrZjsJApiSFdBEWZ0A+WLp1MucWCarChNEpWdygU4lTqWpsdnV0HTk29FMtMnHEmAppPFhnP46SK3Ek21hI2n3DgvQpVGqb8gER5BzSPsWCqgQGrsVV46rzPMYnG4TopASEWIu2Wzs7s99Tj6NXKSL1RTqZ945dBGVglP/bBXft7oJMFdBtCFWuqF2wVSdirpSb6yFRbldPuehch7pD0nmAYBd4+OcCZOoHj//ok0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(107886003)(26005)(55016003)(966005)(38070700009)(83380400001)(6506007)(478600001)(71200400001)(7696005)(9686003)(122000001)(38100700002)(86362001)(2906002)(4744005)(5660300002)(33656002)(8676002)(66556008)(54906003)(66446008)(64756008)(66946007)(316002)(66476007)(6916009)(8936002)(15650500001)(4326008)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AEx6IV8NK/c4YhLScxTnHaveJH8pcS3KsEpK0D1xXkbnpFuXPv7mJa/vmbh6?=
 =?us-ascii?Q?rVfs4K2UKYyIt4if8yINNenY8T0XvRtW8lzb15d2b3s2lU/F8XmWHM+Q0LBj?=
 =?us-ascii?Q?ZY9Slqv2Wj84T4Tsn1mC8QGNGDH0BoPgWXFj++KuBF5gcr9BbTF/IlaT9fmG?=
 =?us-ascii?Q?3gxXil8JdJRrf0CoK9yE2fuIpvMxI0uBEh6ZqWI95JQi9rC2F+tR3yBBUEQV?=
 =?us-ascii?Q?/ZahRbXmG0usKFY+eymcQwQJUePR/MCx9SufqMPCYNZJg+WNn9DChzljkZAC?=
 =?us-ascii?Q?fgkR/fi9WaNBeokNeO2jdu06qr1rHdmV5RwAWmD3xuzNMo+yBTcJ0Lw0CgHu?=
 =?us-ascii?Q?5aSeHJrwfwvO2leHgUg1cmjdILQP73QBvxzuk6tkSlvRPTuH0iV4H/OHOTYM?=
 =?us-ascii?Q?Kvqoc9RAlQQo1SGXizTr7IsQ7g9Gpphs7eszCGg1tm7Lw1ZYaOZh9Y+qWSec?=
 =?us-ascii?Q?aKair2qD3SpMk5o+jGWv9ZLBc+1q9BxuJeriSjyWMFaNirbsQmal0ronZXo7?=
 =?us-ascii?Q?Qx04XIyAv6iA1CsH6sWO/OvNhuk9QF3uHiW6Mj8+l5SkC40ZWxMbUp3M3UUU?=
 =?us-ascii?Q?zE1Ci2qixm8IvNVhrELPqAU2vZTEQuHmGTR8Fzz2GqLjfUH8FW24grU4Xva+?=
 =?us-ascii?Q?deqysLsPHRnNGRU9UikUO2SaWbvJ4rNkEnsXRyQFP8T7+Oh5V8Zb5cAvBL0f?=
 =?us-ascii?Q?TBGuIwjHNfuTTuEVFphaVG88yvYcOzKQnu17CLTkfXPwL3umi61xnV3jORbj?=
 =?us-ascii?Q?XRy4ZANeIVZMijEMvEMiv7G4t6fmeroszU/TOGgcw7kkXlxBGoUysBctimoH?=
 =?us-ascii?Q?WajR8mFoz+nuwIuPvVBsCwoKr17qRXokgqUT8DqfsdEU1k/cRyL8i2jAWLBT?=
 =?us-ascii?Q?P7B2VGi9b41Q8a2WI77A5PbGSF9E8EYO3UPQ6ZowKPGHqsa0bJgBD1arB2Kp?=
 =?us-ascii?Q?7Cvcw8z3eQqKyvwaygqleiyzr5Gq+6WqtD+s5u5hcnpyR64M5HYhLklJ2MxE?=
 =?us-ascii?Q?Hh/6B9doXIpbFRHyv3WPsy4gUwzpgIX7ByBG1GYpCV03bHH4sPbPR2NuEjxy?=
 =?us-ascii?Q?FccbbanOQNek2E9/Ab0keo5jymmI1wodwnSxSTQm2mzqHfmqZzkFBa3+yhWU?=
 =?us-ascii?Q?3XTICxxwi3bpbDuuYUDEi+havJOUyAVLw3YE1OED7uLrDMDotXdrmYHVCn1o?=
 =?us-ascii?Q?Eq7X7ubicG8Lvk7G1faZZ6ajATmGkhtHbvKdxNB47+LvryOUw9j1PegQgrxR?=
 =?us-ascii?Q?gFzL+uEnBUwRZzEtQ9KkyZ1lcuWyyBPUDwh6ahon9tgcpeuLoubXLq5c31Lw?=
 =?us-ascii?Q?DqcwR38gVhxc7PgC3DhtPs0uY5tiZ2bmWs+3ov18yOxATjoS2vz70mXlLnLf?=
 =?us-ascii?Q?z1MXaNKJuJRzs4SOUPF5wgreTGFF5s1DBM1tSlHvy73KCI9MipY4SrBDifaB?=
 =?us-ascii?Q?hvj0i68Y7wq1zQYwO6JElrzZP01DKM1O97Lk+E24JJ/FYT7w51lj7IViwyVd?=
 =?us-ascii?Q?VfaG+MA8jhCJcgi0jZsUiSuhSx6N0yPO3lkfacQMZyornJbmgiYBXtMGECMR?=
 =?us-ascii?Q?01z4N3ytqolYDdcz9Sy1qDCcIrOWbSCq3gFtIBrt+l9FfJB7NH0o782N2SKw?=
 =?us-ascii?Q?bayK9yBVPpg0EoNsl6lltr4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a0d951-c15f-47b2-8c75-08dc2248c734
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:38:35.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjskWlk+NZ+/jJkaGUtH35AM/nIFo2gwzZqfjxoeZYlLrZuk4wZnAtpbnpMY3w8ulA+uSIPkx5W4QWsLPmuY8NJqKJ9Rzx4BE1xk02DTgAGe7ySArvnno3nv2d/stb5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11884
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 10:38:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14554

Hi Pavel,

> Hi!
>=20
> > This patch series does the below,
> > - Updates SSI interrupts for RZ/G2L family
> > - Splits up RZ/G2UL DTS/I for re-using for RZ/Five SoC
> >
> > Note, patch #5 has been newly added and rest of the patches have been
> > cherry-picked from upstream kernel.
>=20
> I'll take more detailed look but just to be sure: do you plan to backport=
 RISC-V changes to 5.10? If
> so, do you have some kind of WIP series, just to get an idea how big chan=
ges that means?
>=20
I've already posted out an RFC series [0] adding support for RZ/Five RISC-V=
 SoC to 5.10-cip.

[0] https://patchwork.kernel.org/project/cip-dev/cover/20240130203346.94488=
-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

