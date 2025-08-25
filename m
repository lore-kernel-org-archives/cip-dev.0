Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862ACA0FE1
	for <webhook@archiver.kernel.org>; Mon, 25 Aug 2025 06:51:06 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.22])
 by mx.groups.io with SMTP id smtpd.web10.33168.1756104657171966360
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Aug 2025 23:50:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Q/zPjMwj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi9LRF5vpESo6854wCe397+WDb3M7zVU5QdEyJCcWTsfc4V+I7FkmrOz2k2iDrQJS+No5aeFlmwDYMSAjs+uoSaWbzhV2pW9HtC9FPm+cYwYsfRgwe0Dis7yUDF/ocM1yiQPCP6H2AcMTcvQcVFu19ReYvXJOmRKH1U2oxKN6bqVCxj1nUJIgE4rIfN/Zb4+eqgBQFgYK6/U8e49E7hct255YWf2IqaUTUQqypW6dFdlEmWg81VjzmXCo5wHzBfZahAEAfP5lyfiUjfq89YcgBnl5LqR95GaPebHgm6VKsyVeFGuXFmVdll08s7FDi0ng1mrVlX9doqjo7xdA9mz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da1N5hV0tpqF3tnSp8nod+Z6r0rjyPwyzE8r1IiXT4s=;
 b=EDwm1pgBPETmEFsVmLHNe6URGVNPbDnWtpjTx5Do4s+7rOB6u6ZM9ZYo+uymwYZS+Ulj/rka1KBwStxx8GOguUWOMnV0BSCCN91LofIs+uAtX1v7GhpgidIPddUWq14vBfHr+pajO1vxfDDkzov9vBTp0VGLqu2r1jTqQ0o3MxSrt7QzGo/E/mqbrZ9IODdqggdljY13c4W2hC8wBa+zPNwH9/815a1uBv+X+FL3KKXIOhx+U1TDfnFcJwwTdwIUNXO//LraAQbXhrsPhVXs6SG2B6FU4v/G6l/XMWvqdD2yJqqApYqSAS6dx84oxU1IXKc/RxtPPgMmqyx09xOIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da1N5hV0tpqF3tnSp8nod+Z6r0rjyPwyzE8r1IiXT4s=;
 b=Q/zPjMwjKmWDkBlhpbWJjxJ0cX7GrwMkZfgDZlNDe3pUlXgEKpCtp5+8uBoPKwrJKw32aCAZNloeAAybniBfBEen01Ecd4VcLc2qAom8rrBr8cvoztrhTVzZvphhPwfCML8gVrNmL+CfiXMD2KdwwrUXBCGfzaq+N86k8ACKoM0=
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB14397.jpnprd01.prod.outlook.com (2603:1096:405:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 06:50:50 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::1de5:890d:9c69:172]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::1de5:890d:9c69:172%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:50:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Tommaso Merciai <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set
 V4L2_SUBDEV_FL_HAS_EVENTS flag
Thread-Topic: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set
 V4L2_SUBDEV_FL_HAS_EVENTS flag
Thread-Index: AQHcEex0Yj+QuZS960eWZhYgbRBVXLRujg4AgARl2PA=
Date: Mon, 25 Aug 2025 06:50:45 +0000
Message-ID: 
 <TY3PR01MB11948A3D133C865A23ACAB261E03EA@TY3PR01MB11948.jpnprd01.prod.outlook.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-56-tommaso.merciai.xr@bp.renesas.com>
 <aKhWKC0G6Q9UBkWA@duo.ucw.cz>
In-Reply-To: <aKhWKC0G6Q9UBkWA@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11948:EE_|TY4PR01MB14397:EE_
x-ms-office365-filtering-correlation-id: c7d7d8e2-9ed3-473f-9e86-08dde3a3b7d3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?q/M/t65c19AQni7lytRE4v7viAhCRViV9yjLemeAqtdNQv3wsY5dtlJv/3uU?=
 =?us-ascii?Q?xfJ/SPyfbm54IweKpjeDkPQh2mVROG3KE1+FT8HPYyMlFCiAnrvj8bcXqXY7?=
 =?us-ascii?Q?NlZAXDLSwcK4YpFeL8VmdwEpa0uE/8eQaCEJeGjdVcENqFEGaD20187zjodt?=
 =?us-ascii?Q?nBLv9jvIyuT4vS4QOK6qbG0vJvJTBOPqOvL/TnMmtPEuwS+Pn65B7loRHxey?=
 =?us-ascii?Q?yRs0PNbI08jEA2S1x1ZulHAN6RV3u2XiXPNamz25RSEMNPcGmW7I0pHTUEi4?=
 =?us-ascii?Q?GXTSKVJlN/6P7jNF+VvrHIi/XZvrb66iPLNBNaDUNS11dDMZDc3kDRH/nmbC?=
 =?us-ascii?Q?fr4P/PmCHKbeAijJZT6hWf2hq42/FFYJUWASy8plXT1DzEsDon869fM9NK1c?=
 =?us-ascii?Q?+sCQ9clqcwngX7Wji4TydgUYtnGOGcntsBaA5kI6ZSAPf7+9D++NTV9zO7Lr?=
 =?us-ascii?Q?PSdxvsWZGFEVO7YVhE/mqTtC5wbovalq8W12czx6r/W8g+5yKt0ui7KwYlhT?=
 =?us-ascii?Q?BF2tMdlDURMxBiT3DDMRWivhmwZiNBItzTqtAciKTNKVSwz2M04tFStaESlE?=
 =?us-ascii?Q?J8AjtwMGrIGLCQez0eenxJCdvA+bi8zuYviax5Dd5+dxaP1Z5yuL0bXyjww6?=
 =?us-ascii?Q?jnqINfMbl1PukEECp41oyN0MsziPoAgCMggh6rKkrYpu3/STqMeW9ZX7MB78?=
 =?us-ascii?Q?Pd6P3V2xB9CkyZ2ZK2lqUKwug6VTBgROHK4/HOoVIy3otzQVYlHTHJwCd1/G?=
 =?us-ascii?Q?h9aM8ZlpZBQiJf8UkI3rr2IlgMIVVwaf9wq6aXd/uhNkD9uhCx89paj8CAuV?=
 =?us-ascii?Q?uM8t+ZrXxEhk/W3q8+0B92QXmDJgzmi0TqJZbJMojB0zRxnN9aBdkQcVki/G?=
 =?us-ascii?Q?K1C8F9VNEoJfibZ3hdgWwhbVLmtdDEVflZPppotcNjZoYljwof62QmkES86G?=
 =?us-ascii?Q?LtS6MQxeK8bgNRsMWMeiJVAlZrBSoUV5PlCeEypufSi+wYKh/CJzpkGI1i0i?=
 =?us-ascii?Q?hjQ/M4g/57ag6IocvhEPqPW1rgsZ0hVMPbvuFjOr7XprfzvzxMXeoDj5dhGZ?=
 =?us-ascii?Q?36BeFSYJ0CVif992cCnrTzhSZLOSgy8I64FpaqRFhHw1r6nSmLKgRXsIzH/V?=
 =?us-ascii?Q?HyUy+14zTLxPQZbMWz4oLgx8IClh3QothrXo1nZLmt1QVZpaaY3XqbqJUUOk?=
 =?us-ascii?Q?dCvPdpkK9XkZawjMmlynUjlJOqzeHs8NxSATu8rsslKZC5owjDwgT6icsYck?=
 =?us-ascii?Q?z3CJF9qqhaHdaIDtLd8TUwQGT/qEH/WdylTscUgm7rBQbS4SAmfqDsHR1Ugt?=
 =?us-ascii?Q?t08i6u0ucKnDYMqP7KvhorFs4h/Vy9qpFzTazndzAIhNkFwEoJsj7tcb0Luv?=
 =?us-ascii?Q?GUNxoWKXsYx5fRiVVZEyNrUbJY1lAskFLbwwrj3jGTJBD6CXzGrpalYcWUdn?=
 =?us-ascii?Q?3UJyVDFvhG7f1qhtG9+mH0pB4Y5FSFyCdLQGQg+5XN/FkF4tjqz93w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aukbQDQ/g6rcfXD1Zzlff+jxW8KKyRjV9R78fCSSLVukZdmqvyaOYHphvGOE?=
 =?us-ascii?Q?+uFjTqKR82MqbiFOHJn1nX+6lhCzAAis2VBtWhv9T+GZeelkg2xppo4nz2bP?=
 =?us-ascii?Q?E10rUpz5QcRTgGc7nOQoUkjgp6w95ewB0Bd9PPJknbM9xPJsZwFreFAC4ydE?=
 =?us-ascii?Q?tZC1Ce/5O1NWjNoC2gAyKnCU7gTLxepuvHS923mBJFN4zVH58xb1uyhm7hn/?=
 =?us-ascii?Q?/Vgs9/iI3S+r+L8Q94BnY4nXSBcb1qbgTpPKV8UpITqcqrdP6dbGWlDGtRmT?=
 =?us-ascii?Q?FxfjD8aM7OqvZbZbeI2qFhs6WFExNbPFM7vG53lS7i1OB7e4y/sGyAReVJFl?=
 =?us-ascii?Q?vOf5KDzXAQVzjEh0qShC15+v6LB7saiRkNCgG2nMDvGedsUzKxn1aFjS+H4t?=
 =?us-ascii?Q?QtwkKtwprr9+t5qGaKoG1/M3HbFzkU5itgjKFHKHKjNR4Govoka1KlhNjQPv?=
 =?us-ascii?Q?Wee8GE/XFm2T66SMka2tWrl3wnOxhSxPelfP2+YNxYlOW9EfebgEsETNU4gv?=
 =?us-ascii?Q?wseYsxLt3ZIjVlGfNqghe3GDwn08TWXYrbBtjUT/EHovEdCB+TTXXFVIkFQ0?=
 =?us-ascii?Q?ILwMhbxB13rkiQy85UENJNh7kdNwuemRgcJ+aRZjGPzFg6MkHCGPWCjjGTe9?=
 =?us-ascii?Q?V4MrR43k6XeL+lqpl0KuvoQeuZkTKdx/iDbzeqA/o/UdcZ8AS9lDbcEeoldU?=
 =?us-ascii?Q?vGExxexdzZPtYl7Z1ayTjl4OLiEdK9kPLq4RjuiuzZdApykw5YrqBeBIcutI?=
 =?us-ascii?Q?hUXuOQy3H2PsQIBg5emtjbhOrZBW0B0Cj5tOYPY7YNFeXoofnKYdwzdC3PUq?=
 =?us-ascii?Q?S+67nWTcqWy/xohZQufUQd3E7+PWST80oQTJeR9Ito1uKwzSsG/2s5aPn891?=
 =?us-ascii?Q?I6RFrZZx32jV5IoDQL0R3Qpwy0CjZrGiPt470ed4l9xr7W0BcGQrj+hCM+FO?=
 =?us-ascii?Q?kGmKwvVol6TmCa9tGGeCIxkIjxV/Q6DC3wZ7xv0nGPlozmLd2Efunt+ZTuZC?=
 =?us-ascii?Q?5fs2ip16opVWTADGwG4jflYW0X2cBApr8vnonBs/EwqTUn0Ulspn+ihcg/sg?=
 =?us-ascii?Q?U0j/O7Dd3Jo4jL3TrmbYMpwOqB2GDzzZQOoLb3RxpP4rzZEt2iHhzEOoVDrl?=
 =?us-ascii?Q?49tRXgfMT2bTpyHKj+Emn4FHua2XQKxEYM5MB+Ov+c8+xzOu7AggkdrgZdJW?=
 =?us-ascii?Q?8TR503KzS9mNWp/ejJw9q3GiYY6wmM+5AUTH/VUc5MX6O5oMFjZbl0jBL19X?=
 =?us-ascii?Q?q7MZhY9I/OQ4y7u3p6W6cq791KUum6dFEPS2JEOnOAo6AqIF8QXx0tkCe7HX?=
 =?us-ascii?Q?v65kYajlL82TvAYODeXNjIml6Uc8I1aGrtvzgzcFtOf/arUbxuRHSq27LeP9?=
 =?us-ascii?Q?mnp6BCHP1RA8oZFdbPf3y0obbxlcuGAWh19H2xVuoNyE17mbPEbQH1JtVvor?=
 =?us-ascii?Q?KWx7uXof3/AlRHU0yxoN6Us0lAgHlf0SR7ljXTprZgR1imdfLUSjNYHJ1eUm?=
 =?us-ascii?Q?59WTUOiARbd0dfkQaZ7F3Pbc6RxWp1DO2F9v2JfuoVCo4ljxv0V/0XD617P+?=
 =?us-ascii?Q?mQd9eyNVJ63dtwVl5T9ORwUxmhEAFkFFkEsFm9miV5T/SF36TRtcXoOEBIbY?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d7d8e2-9ed3-473f-9e86-08dde3a3b7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 06:50:45.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DL0pe6j87jLHTGi+EtopbBbDqit42hMwqtIw9YSxKesL0SyhjCu9R+0qlyxg3hR7hqEt1I8h1V3AB/1Vl2N1oT7bFPa/uLGdQerqN5itPhhyU5GnZp/0RPimPOC3Xmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14397
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Aug 2025 06:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19960

Hi Pavel,
Thanks for your review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, August 22, 2025 1:36 PM
> To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>=
;
> Tommaso Merciai <tomm.merciai@gmail.com>
> Subject: Re: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set
> V4L2_SUBDEV_FL_HAS_EVENTS flag
>=20
> Hi!
>=20
> > The ov5645 subdev can generate control events, therefore set the
> > V4L2_SUBDEV_FL_HAS_EVENTS flag.
> >
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>=20
> This misses "upstream XXX" marking, and likely some sign-offs, too.

Same, sorry this was added by me to pass the v4l2-compliance into 6.1-cip k=
ernel.

Let me gently know if you want me to send v2 for fixing the series or
you can take care while applying. Thanks in advance.

Kind Regards,
Tommaso


>=20
> Best regards,
> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

