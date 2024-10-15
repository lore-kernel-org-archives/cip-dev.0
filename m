Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B7D216A7
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 13:46:26 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.web11.14022.1728999978486223850
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 06:46:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=nHvSq3XP;
 spf=pass (domain: renesas.com, ip: 40.107.74.38, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgOJp3FZOs0f3ihaS9YMLwbxT+xikGwJ2JgX5LDX3MXuVyXVq7y10sqWC2swsN+vV5LK99UNjdP5L59Q6VCtTy2jgpOpXSe9SXzlGTlGHql2elLsan/n8xyia17OhIPeCAGGU2L9+50lqYeshsTQCz4nOxNjs+nnpZsFrQ0NNOnKBqYR7y4RAUWyBDfW9R2lYDZcxPSBZZNNC98oy/WKfAhjTF6GLj3EKVZOWqjyMd1nVLSAMMXDg6ehXd88B7UjKLdwkDzxEkSREyxH7fLgwxBt0vl/qLl9v12lev4CLh1h02hSRfd4rK9sR8pXo9vcR957Y3Ox1FMGZkKzKT0N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+naxaWx8x7xZdt0RayeY2yApZj9EHFyQQL1dT1ScizA=;
 b=k7Ohydct+Q/0v7CMXc1xAxb46bGhHTB/3WHj4XeuHpRfCdODPtf3jGBD0AWi8rDHk/85ELxJSQtezO5XmpylPLhfBt883+1Sbgxl5uXJJLAoOemmvDZ2ugm73a4u8/rWs9U1Wf+CVS97tMKBgmS4GdmNirplveVSp1KH0rasbW8i/EiYg6hTHRTvIrrrUylhroCSp6PHwWDE6YwEQSLoEsz2EWA54GzXh0dy0mDY6RAfFPA50WuabiB1pwUJw6E1/nJTdn28qM10S2h4+WBn/c6EfKiC70EjPewG1VUHd7ysTk4mfB/yBsNODNlwmw8otVnZR98yO29+UVW9VWb3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+naxaWx8x7xZdt0RayeY2yApZj9EHFyQQL1dT1ScizA=;
 b=nHvSq3XPtsCe/LNmWLiTWvHTheaf5+23AFhSx14yjxeIicN3R2hmXW6qekQQogiEPWuTKgzxFOMQ3pOuzerQPYJVNZGDCWxDfjf1T4Sqe6EG9MBz58kC4cuwVIKqib0BTJh5prduI7+dtzRP30nquwV3fKk1aumomhsma47ubX0=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYCPR01MB7457.jpnprd01.prod.outlook.com
 (2603:1096:400:f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 13:46:13 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:46:13 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] lab-cip-renesas offline
Thread-Topic: [cip-dev] lab-cip-renesas offline
Thread-Index: AdsaKgOu1+fH4iYTQ/ipcTRm11rUKQAGNb8wASdLSIAACdxZAA==
Date: Tue, 15 Oct 2024 13:46:13 +0000
Message-ID: 
 <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz>
In-Reply-To: <Zw4uFWi6kWekKeCd@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYCPR01MB7457:EE_
x-ms-office365-filtering-correlation-id: 778418d6-d512-42e6-a4a1-08dced1fbc03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?WRy4kSPga4e2yY73lsTTjQg270W1GCz2jdAJxBB4x0aiwz5IqsPhkih5?=
 =?Windows-1252?Q?R8cuV5LWdMe5SMNaHCZE6kxNmbKYe43UWQ26565/cErbIM9n9M5Vx3+8?=
 =?Windows-1252?Q?52YP82yi1+c49E9a8GHTTSirdTV6yHLTYbq0LTeY3RUPV8TpCEeU48I9?=
 =?Windows-1252?Q?4xOxn96gvBSNoNRffecNWQFW5y/z4iCA8uJMZtYijYp8Sv0KhMJk6+cG?=
 =?Windows-1252?Q?QYpun1vdIQ0V5ONn7R6pS6duQmuR4g8nznQMlLZM+gbmgJMSsbmhExHl?=
 =?Windows-1252?Q?6rBVvbb62GPW98Z6FXAyZyx++0qFoW2YazdiaUa54LCXKSBG2HrPiJvk?=
 =?Windows-1252?Q?NvvM6/ttAB0VwbW5yxPg3Itzy3FJAkka0Wm0VP0wxgTgQdexMOigZHBM?=
 =?Windows-1252?Q?XN01WBJWQdt6d8jleTM9lxLbwMWA1CsqGTeVXUatZLTa0drTBGaHWZhM?=
 =?Windows-1252?Q?67mofVGMnZZwoh4ST8ALx0tk+3dpR13FDsvuzb4OnLwBleKqzzxYeU0l?=
 =?Windows-1252?Q?61aMGiSsj6o8vH7+Fkh7S4xg77yJE4/MoqrNFS+nUzRvA2paJvN6iOlY?=
 =?Windows-1252?Q?JtrXOWrQhSJhBIDtjHzteKRlKKio36o0LeL7btukBXjf84UXaFIVWxgV?=
 =?Windows-1252?Q?xktz0r9mCtOVvpEs7wZfNUrIkJuSfUYxa3YlzQG5lKkO9NDPVKLmL0xv?=
 =?Windows-1252?Q?d1dxncbxk/i2DKhyVl9/bGlk6EdEVPUxVZqiHcoJwN1FVCJSGgZHCgK/?=
 =?Windows-1252?Q?HqKedgXgjBjd/3CKFC7i3C8NRrXS4dKn14bkmFfkIX0dLmiE2wTO9ldI?=
 =?Windows-1252?Q?mAvu5hrxMkplRAmDPcDuZO1vLrZcePaNYu7Py9nCGPEQp+UZJcsFi741?=
 =?Windows-1252?Q?ja6Gjtu4UUt6GyfstVuJ+JS+WCF1bBJ3TSgQ7GiWOnyTGNsoaVJ/8hg7?=
 =?Windows-1252?Q?hAJgS1F6/0S0v/5NPZy6mQkv8F1mSs8Z8YEpeqTXogvzMGZ9IWlZ2N65?=
 =?Windows-1252?Q?M/MDvRBO1EYtNGF+b1sA1dqz2Q88lvgx0h700QAwHJiYpDu2NIkC0tdc?=
 =?Windows-1252?Q?zoigC1X+Tsayk5AB89VmTcGpPQ4zTJFD0o2EpiKtM8AHtwc8VT2VgiE9?=
 =?Windows-1252?Q?sJvTjUDVmFInc/cpVnDwm7VedVdCmjNO/8khw17gnsK/HQJPaSuSxHkT?=
 =?Windows-1252?Q?9TUwYNER8QooYhBR1AhesJwIzxNh/WAosdvL3cIkhIja/aRsM0wj9yZh?=
 =?Windows-1252?Q?pnC9RgQbQnH/V2b7dgOOwDJpNKif98bBbXC/2kM51EUZqQXYrkexuJyp?=
 =?Windows-1252?Q?DlB5VocNCLrdwQhbAFvoRLQm5S8PKp1ED5NIlXe+OOM8xhAoqm6KWgTD?=
 =?Windows-1252?Q?FdIclpTYPbL6QQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?EjgECkbL3F3PkTy3nmbd4+Ted7E6Rea5z8ZPbuyWMVLnv6Qd4/Zv7Q8n?=
 =?Windows-1252?Q?jw6Tx/SIF0IeY1FTknrOHb47LTN87K0VXV5EzkwcdC9/fLoTsLF4DBSJ?=
 =?Windows-1252?Q?RmYbQtgbZ+sfPomxlQD2sv5nDNw7guYFOKNbFX8FOsB5OpcURdwj8Pae?=
 =?Windows-1252?Q?r4GZo7kozNt0oAXAfEBhlwXu8gb0iefSluxC3+afLsvDDAq3tIaXLO8u?=
 =?Windows-1252?Q?SctboousrvfT5xx6RZPApFtjvSXa2CBhRaLN/dhPTtkjGYhJM/rnBU81?=
 =?Windows-1252?Q?j3UAduTjzEjw+iKPKPPMaq1499XF7S8tsiTKPIGOEXMPujIgDgdqiNC+?=
 =?Windows-1252?Q?hVWo0uxFy1721ZPg3b0SOFofg1mb9349SikvtxhP5otimiJtI2P3tPNj?=
 =?Windows-1252?Q?KNXXINuQASMALg9Au/ctWZiZiU78IymQ/jKbXlfrakmAy+hOo4X45ZFi?=
 =?Windows-1252?Q?ON0KRDs5zQI2FovZdMAaFmoVqi6+NYQjijT5vIIaMAu7qNbvyMaNHAN3?=
 =?Windows-1252?Q?QBWIdQHFz5y2tcu7n2tDHoO2iiP1bVRSt9/dtGIu6nOGp62ngA5Ey0r0?=
 =?Windows-1252?Q?8ui0OvHbxfhcclQfL5tOgBe4m1rzVgE66eDjkN4v7DCerly/yyQeQfs/?=
 =?Windows-1252?Q?vTxl8GvTVxzuTUSVn8w3ar1sSsGwGbSjRmM2TufQF6v7Ipn40+/+a3WG?=
 =?Windows-1252?Q?DwfQxbbAyS1pV8t1ixZtL/veBZlRC5bUMIy5MTb7fKcBjvs1KCAA3Iqc?=
 =?Windows-1252?Q?dWIh2T5z0azdmOCJuAhvIjO9zY3GQbsLppimfUlMgz47xv8kMry2t6Yw?=
 =?Windows-1252?Q?5BWFJvy3s+DPHKwRNS/jFY3HYNYbvT+Fd2AyGRhJYpmjNSDvO53EO0kd?=
 =?Windows-1252?Q?aLatJJc1v6X5OEtCTjtQhb8X/W6GNot2anS/ZlGQWgDyZLkBUorr3SXE?=
 =?Windows-1252?Q?l0wHF6GeGTRFVaP4TrNFcc/PsRW1PtNXk6jynIBAOV5pXalF2VRsJwbi?=
 =?Windows-1252?Q?vT7IBX+QDp00UlU9ZIrzMR0OedLhb1/EU0XW41iSTNYDBvj4cuamer6c?=
 =?Windows-1252?Q?t1ljOPrEjhOPxK0CbDbwtBsLdTYx55e4eaKHeJHCA4GBXau5zoo3EJF8?=
 =?Windows-1252?Q?WRAPvz4ZKJKLbyk1Id/6TjbYTvD4NcHXtyBvoSezs8M1a98+hUNoaqdh?=
 =?Windows-1252?Q?diZGkcwD975FpbBk0UhiySeghMHl9i7Gg7oDQIJDhW35doiy5+DFFzBw?=
 =?Windows-1252?Q?9qYXGwERqyTaOvw/UDLd1+RcyzcY2sf0CUsYsAczzyqWplHeuUkwERqT?=
 =?Windows-1252?Q?8iRBIjkGE3IA4hS2XTr1pY2mZTEpILUYUALgG8m+wgLbw7BEbW1Ut8Kf?=
 =?Windows-1252?Q?IIbSaSC88LbhVG60+osRT+OP8CQLjaITHeGJeP32MQPstrRbKpbv1rbh?=
 =?Windows-1252?Q?6qZOieyvsVoAitiY+Io3BdxXVMdz/Gtb920491idnscm+nfQGtClOn0B?=
 =?Windows-1252?Q?njkfziC/N1M2edp4kBsjGmXq64jZ44AEgnlZ8jda8ctu3FDbrwEF7tl/?=
 =?Windows-1252?Q?ai5csEJPORVGkyeL3mGYARHe3IUMWjs37G4LM3aJyrLwdQWkDxJjlLux?=
 =?Windows-1252?Q?6pFn5/0A6ONbiKoh8gXC12xXG9uOH9u/BKTqVCl6BE1pw+5g7jy7fyDH?=
 =?Windows-1252?Q?yPCNvzDV9i7EV+Wry5Hkza/OLnq/xd5FxgTmywgqHynWTx+64t84JA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778418d6-d512-42e6-a4a1-08dced1fbc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 13:46:13.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsKETs23Vv20xbLDbJZs0bqvzl0DvDzvz+S4RBCI3BGLNUYeSIkXZ6aQ7W/7mvWeqUO+RTeU2L1Jc/4Bb9xNPZzRDSrv5ra4//9LgcnUSkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7457
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 13:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17040

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 15 October 2024 09:56
>=20
> Hi!
>=20
> > > lab-cip-renesas is currently offline (since last night) due to some
> power
> > > issues.
> > > Hopefully it'll be back online later today or tomorrow.
> >
> > All back online now :)
>=20
> I still see failures like this:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/8086067433

lab-cip-renesas doesn't have any de0-nano-soc boards.
We were seeing some issues with other labs, but now we have 2x de0-nano-soc=
 available from lab-cip-denx.

>=20
> Other branches show test:arm_multi_v7_defconfig_de0nanosoc failures,
> too.

Interesting.
The de0-nano-soc device seems to be working from a LAVA point of view, it's=
 just the kernel that isn't loading.

If you look at the job history [0] for one of the de0-nano-soc devices you =
can see that it's booting okay for various kernels, but not all of them.
multi_v7_defconfig seemed to boot okay with 6.12.0-rc2_d3d155669 [1], but n=
ot since 6.12.0-rc3_6485cf5ea [2].



[0] https://lava.ciplatform.org/scheduler/device/de0-nano-soc-03?recent_sea=
rch=3D&recent_length=3D100#recent_
[1] https://lava.ciplatform.org/scheduler/job/1205245
[2] https://lava.ciplatform.org/scheduler/job/1206169


Kind regards, Chris

