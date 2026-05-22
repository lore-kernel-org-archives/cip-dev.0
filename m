Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47526CD5BAC
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 10:42:40 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14131.1779446553282385683
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 May 2026 03:42:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Crt6jFNT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JukN5jvoENfzisz6V+r6uj0sW6HcYQH1KRX4MmWEMobbmgJIxkBNIiBP/J9ADt+2F2lw4vwhQA1i3j+8witXBeJSt6M9Uz91OpPNP7XLFmCHeSNmBn2u2F8Bizf9AN/DOFH3g0AMD0GJYcFfDbCLnUTxE99jUa/6Kkp5/lGQFP0Cssp4Z34A+NjcJ3Yz6yXnA8LOCdEJp2Gdaz5gk/YvffA5bWhpVc2+50e0Lmv0iQ/IQSVn3kSp3LzW5EyUKdWo57rdzrk+XKMSWlFf9lfhgb1tJek0ms6DOwPRF1Uj9rKwZwIXAhOexmi/f1D7DBkJzS+frIOk/6hjZlsCqcLFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22TKSgqk0xkGLfk86nD7gTXqYbNxLZIHRXWuWU1Bz7M=;
 b=A7xHUnsJV6vhRdJ2svVdPigmbfIiDSvUQ2FTKIxWUvV8YuCrPzGAmf4z5EjgUMyNH7E8LL2fyMgnakXaX1oDBnusMPbnBgtulzCWZZMm2bmk5WCPun1PLIVmVKUx4kA3zJ5PRNVzCIX1kLDrKBKmK6E+REMWGdpN/u3mSJyQfika0EqDIoG9g7osVsTiMZG04/s1adjjOztDY8dXKeROrNpfnBZq2VvGVvFgnyRh1go3zvNDu+TRlyAeAL1F/fAVTKn+ucS6RW35OqCbJxB/CzT1MiyOZupoHJerH3p/fM9uLGyhGOMiPceZDn1easD+b19R3Q7deqVA2RdjzjJD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22TKSgqk0xkGLfk86nD7gTXqYbNxLZIHRXWuWU1Bz7M=;
 b=Crt6jFNTWP8RbsYX+Kl8RB1GSpMeymlXgfHZy0CUd8CJSavA84fhUP1rjpZyh/RLtBgAM5J8NziYtCxKgLCpAVzCDgVb58yI6Tmd0rHBqy1AbiiY945iQ/i2ByD9WBiRtBjsMZ7KgjcY9iGx0ekPQXAAp4vNeVfjZoZcr1TaDPs=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB14680.jpnprd01.prod.outlook.com (2603:1096:604:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 10:42:27 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 10:42:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, KernelCI bot via lists.cip-project.org
	<bot=kernelci.org@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "kernelci-results@groups.io" <kernelci-results@groups.io>,
	"gus@collabora.com" <gus@collabora.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Thread-Topic: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Thread-Index: AQHc6aBDlJ8JMOOXbkyyVQ/Sl5mg07YZvH8AgAAeSwA=
Date: Fri, 22 May 2026 10:42:27 +0000
Message-ID: 
 <TY6PR01MB17377025B3BE5EB9806D02FE4FF0F2@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <177941154371.3955.14567547508285219672@330cfa3079ca>
 <ahAYjl0g7RuivHQJ@duo.ucw.cz>
In-Reply-To: <ahAYjl0g7RuivHQJ@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB14680:EE_
x-ms-office365-filtering-correlation-id: 96ee30ea-944d-477f-0e28-08deb7eed15c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|38070700021|11063799006|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 TEFDYluMzQa5vBH6L3L52WRgG06qrN18NpXdWhWprkkzouMPR1uoWtN+H+DsbfXHHaIytx+PP7MwAWFYQl3z08CW80kx0VSXVMGOhl4geOj7ee6CvIDybDTqCppEu69Leg85PMxkJXMLUCqTsBjxtbIB6rU6lNZ5+WQOOZIBwZs154/guwnyPqMP6lE65Nl6GuQ/Z/udmLSAfiT+EGPtxseqUzJzkOZ5xmo8AmNODjSqWdjnxN62b8NxhpGXSlMLl3A5KoDowr5NbmQ9PArmzVdh9Ir3Xc6OI2irZ5i44knD+mC5mzUyWGKGFoupEcXMXLUw9en3F6hkN47r2+V+xsueRJ6YtI0BUsoMMSJnJibu/EFs6xinBTU3wkb8FmDpNUO8qybEaMEhN3NfG2aZYfijiVmG8/he5RypFAYMNJ9Y3CT/WSTp6iOPcS1SpLQ7VeWZ3n6DNk2tYV0GIx3VJJb474LKqBpstAnSw4LA8OsG+pMJ/06VnOzlfojZp3jRk7UscEK+qJX36Tf81hsSOBy7bl1vs0XhMZPlBmQbHOhQQkZjFpDzR6gvcTKVw3ShVAbOhDa+wtmPhpNdS4ixnX3mETEiW/KOpJB8JYey5/kKtY3tJlGYIju3L4wB+zgBqFWPvLMc1xOUjlyi0FcI88SNjrKfwxbYO2iSY2WhQJar6UJn6+UxgEG1aqAi6FmBtzPtWR7vugQtVRNck0MUhFidJRUAo3Llh9QLn04F7D6ALppkNLGqrxxoh87In3+N
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(38070700021)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HVw8joUt8Zol4ZPSjSiB0WpsdH0gWDr6/sjk6r0Ey8ApYUHpnjlIH8Gvu/Qo?=
 =?us-ascii?Q?iGg/fzrzHBsHVIoey0oJcKswJpKqJR45xJJXjU9ZoML8Al7t7VXp6U+TMDUg?=
 =?us-ascii?Q?lNw31k6sa2GTHFymTJ20xRsWByd5RS9coIz6l1od85cqbcIrrlhq5At6FYlH?=
 =?us-ascii?Q?xoHQAcipzalCelq20u6Bj5cnv9A0lzzaYGMLTmJqAP7qkGVPnq5qg/yB5eoQ?=
 =?us-ascii?Q?rOTzn41WJ3gkqTi5uj/moM79ixjI926djJtUO3lU17aE6r7vEXWQqVupp7fv?=
 =?us-ascii?Q?yaGHmSHFABMkJ7+TnZvCDQAp5LbMTE43BVwmGMELIKcoYCtuIwCLIevw+uQ2?=
 =?us-ascii?Q?zBtxBMCdE/gR/MpPiBCumEIFttuDgF/zWknjyIznxgTbfNbLE+8Gol759zHa?=
 =?us-ascii?Q?1tTF36bNNqekv2i+xB+RGnSME3+XxrKmY0ewr7wQCjjiZ5ZF2HKH+Q79wR0W?=
 =?us-ascii?Q?AcUHyl5QmQAPEGNhHfahOs9afNrRT54Fr1jbisjcpMx9haMxoJqjHHfO6FBD?=
 =?us-ascii?Q?wu200uzSgnHZVJ2y15IWFgtSqFoQVtaadaabxwb3TkKF+roAtZ6QCu9EYgQK?=
 =?us-ascii?Q?hvP1wpYeyCnu+qMnOPAMWt5/P6Ypry5R3nfzX4v+gbF7iPWsYxTev4aXVA5O?=
 =?us-ascii?Q?/V8pQWJazjOUVCGwZvwIgZ1mEqTgPj2XH6wCnCL35omWaB7n6CCMMbA8k89h?=
 =?us-ascii?Q?Zs9gdwy3ebwx/8I6Y2EAADgGeitMhw60XMxJDTG9Bm54/5FrwIjhQLq0e53V?=
 =?us-ascii?Q?IrhTfIjDm33/04zPFUhjKElvgnymxjVtcw79+ox2tw9pZc79u0NFxUHezFDC?=
 =?us-ascii?Q?ILK1HrDPoP+ltINI8nG6bMuOpfYZWbMs48dLjZiJ6TqnHN+t9Pig6r/64ynG?=
 =?us-ascii?Q?vuLwX5wjCmCI6dWwyTzTiTI3APQgygkXgg3P1hZcEizxrrSky/cDUUeQh2n5?=
 =?us-ascii?Q?9+R7mutrDiNIILRoO77HF2a85lurWC+4//vqIm/9UGukRLLslGtQHEsiIBp4?=
 =?us-ascii?Q?di8leNwXLSgsRTU2b9+5WsrKKfNurCffy/ctPfp0UJUg5J4fZ7ePLeGy18G1?=
 =?us-ascii?Q?FUbHBWbDcrUZT/pO8sB1E9q2xQke/QeAcSFn4jgF0mRjcSd0KO7d+IW4aqbm?=
 =?us-ascii?Q?8WDqJ/a4hf6scMHAbSXg/jTe0m3e8uMdZpGiLf19t23GTgs1Oku+pU4uq7wd?=
 =?us-ascii?Q?26CABHW0lmX+lhz+QSQgzdA/Wk+rA9MNiUsLd6/ZXUgYNNSF2qKmZEBHpMuz?=
 =?us-ascii?Q?9RtJ46EYIF5Cy+0bgEP2TP02gtYLKoHhkDpY9jHFzefBwO7iP81SO/FXmM+C?=
 =?us-ascii?Q?L+wLruBaeolv48MoKwtxEHMBEESPmhGZFvf0if8G2HCuUwSzds8ur/p2kdvl?=
 =?us-ascii?Q?CtJiOKYnqJjvAzRstja6ckfhXRMUoYapsJrrst6TdUghzGMDfHYz+y41ANa0?=
 =?us-ascii?Q?5eGWKniHZGEUnh00Mj1wZKzsjHA/HbP0VLSXxKdtFvPBmE590fr8JBVin5q5?=
 =?us-ascii?Q?Sb1pNNYKx0s7t8n4sXJKdJGND55uEA1cs3L8e2brVqKYMkg1j0npEnZfD+Lw?=
 =?us-ascii?Q?EczytodeD2QfuJUSoflSlLIKvQRt3an9YUbhym+WHAfC4wvWXTbFvAcoLFX1?=
 =?us-ascii?Q?F8v9q/r/3xT/cu5LX7Bv8xg9ygPW5dSJP8dCGqwWEmttWdXnSlx6rGzpOjFD?=
 =?us-ascii?Q?0XrmMg5qhVsK4hOIPY4aeJ19HDGuehgzdOi1dvJVBccZiFBKWPCP/LpjtOmw?=
 =?us-ascii?Q?gwOgYi7QrjtlS4j4r86jh9R8Lm4RrA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ee30ea-944d-477f-0e28-08deb7eed15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 10:42:27.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVzqxQtpoZud5UDlnOvtxOyxsyAcZrGypMsjxTLbDVShGGggqaqZ2GaJMA10R3Es0KtgtF3I5UiYMrME9esle423sQXiq/pDcPcaDZXZ1Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 10:42:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23000

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Freitag, 22. Mai 2026 10:49
> To: KernelCI bot via lists.cip-project.org <bot=3Dkernelci.org@lists.cip-
> project.org>; John Madieu <john.madieu.xa@bp.renesas.com>;
> nobuhiro.iwamatsu.x90@mail.toshiba
> Subject: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
> cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
> sound/usb/mixer_quirks.o (sound...
>=20
> Hi!
>=20
> We recently added
>=20
> include/linux/bitfield.h:#define field_get(mask, reg) \
>=20
> in renesas series (arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe):
>=20
>     bitfield: Add non-constant field_{prep,get}() helpers
>=20
>     [ Upstream commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 ]
>=20
>     Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>     Reviewed-by: Pavel Machek <pavel@nabladev.com>
>     Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> and now it is causing warnings, one was reported by kernelci, and likely
> more are coming:
>=20
> drivers/clk/at91/pmc.h:#define field_get(_mask, _reg) (((_reg) & (_mask))
> >> (ffs(_mask) - 1))
> drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c:#define
> field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> drivers/iio/temperature/mlx90614.c:#define field_get(_mask, _reg)
> (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> drivers/irqchip/irq-renesas-rzv2h.c:#define field_get(_mask, _reg)
> (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> drivers/pinctrl/nuvoton/pinctrl-ma35.c:#define field_get(_mask, _reg)
> (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> drivers/soc/renesas/rz-sysc.c:#define field_get(_mask, _reg) (((_reg) &
> (_mask)) >> (ffs(_mask) - 1)) sound/usb/mixer_quirks.c:#define
> field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>=20
> Likely similar problem will appear in 6.1.x-cip, shortly.

Sorry about that. I'll drop the two field_get-related patches and define
it locally like other drivers do.

Regards,
John

>=20
> Best regards,
> 							Pavel

