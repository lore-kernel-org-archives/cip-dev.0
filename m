Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4DCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 19:42:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4629.1762285371400242396
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 11:42:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=lYYZwmGf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.46, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2uEUGwxtoynigGWkHn+oL1kh5Mi7xYazQhmjkr8mIq7VPm2XcLWQRejhdMhVIxYfLQYTtBfGndknEBNLrAA/l2TYThGO3FjuFm+m965mP5CDC73WQAQMP1XQzT765UWvlOS2fFokoBE4QnHj0K1VyLWPqfb7G+7SHpJRF9DDG0aaSoyaGOOrTlD6nM32lfdcbSDA7fZwr4R7J3PnSvjtQx9ZYca6zIwBdgj5Xgdirk9bATW9nMeLiFD0NTT3iuA9Fh5I+G71HENYv+YaBfu3t/v1q8LPkCrlgzr4p4ee9rB3RIKZ+99Al8OYhto65jFngD6GD3JULvIPSXlY5QTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAcHPxyW2oMR6akqLNTpdwaoMAtcOt381IhmSfHU9pA=;
 b=ZG9XLTxLko8TL7Uq9K7hK2l7BZ+O5WzMz+CDF+zW40CTZMAZvGsKsvFUYCFgtSwhq8JqlHQDi6x6bymYix1HON7wZAICZRuZPOZhR3RillBGk1PYDCPraOzw25F5RQhalwIZ+6ugRx9AsUf6GZ4JXVIe7qM2T0x7/Ssbnb2cepyHiJaiMnkcILsQoJrhqJeduQuUo9/D0rYiCx6jCncoz6Ft9lTOXiFVNRk3yUqh0vSV/qttfPrFH1zoJhuv/bgu9CkmbFTlnMsOaYyAVF2I5GR13dY9qpGhsIB0b+KKAm+CHaGv3o9/8dNSHIzdwy4wHVprHKAc5Teagq/v+a8x8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAcHPxyW2oMR6akqLNTpdwaoMAtcOt381IhmSfHU9pA=;
 b=lYYZwmGfDLazbb9NSTrNzYgJAJLnpx7lLgXyFshaRxHfo+ARNSnR66s5yc+dEc9aZPx5iGxJiZ4ibNoBSSdBMMLqFT5arPfthoRFOO/wt01ncH/oTpPj3CnzMRtMpAbZcPR6kG0WpZ6jXZJvubtBGVmhQ1Aao96T1xMmfGr7d7Y=
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com (2603:1096:604:2b8::6)
 by OSZPR01MB6568.jpnprd01.prod.outlook.com (2603:1096:604:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Tue, 4 Nov
 2025 19:42:42 +0000
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c]) by OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c%7]) with mapi id 15.20.9298.007; Tue, 4 Nov 2025
 19:42:42 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 6.1.y-cip 20/25] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
Thread-Topic: [PATCH 6.1.y-cip 20/25] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
Thread-Index: AQHcTYqMJgtBDA66EkCZhHz/2P61bbTi1CoA
Date: Tue, 4 Nov 2025 19:42:42 +0000
Message-ID: 
 <OS9PR01MB16368C316B7BEF50B6087AF32FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-21-john.madieu.xa@bp.renesas.com>
 <aQn4LbAIUWBOFMFN@duo.ucw.cz>
In-Reply-To: <aQn4LbAIUWBOFMFN@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB16368:EE_|OSZPR01MB6568:EE_
x-ms-office365-filtering-correlation-id: 723d8852-9f8b-4c1c-b073-08de1bda5209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tVjPfiv1qCVeJKlNx2tUGJDh5gRpktuYgO8M+cCyYGPmKwUrajGPn6gZ7Tb5?=
 =?us-ascii?Q?hVjTEJqlDEm0ZdXXQkspMacntG/yC/vdmtIDo7OgROHE3BS1QNiZPAyeFGLA?=
 =?us-ascii?Q?Z8QorW19nt7zlHU6zyrTD1Y2aVUQG5HQyLUrXFTEETzCFmQQqtONBEWASFJn?=
 =?us-ascii?Q?EaGO3vg6n/SY2gJwl3a7yzAjxkrQhikJWLz7W7kmtqaXUk0qVM0gZhl9k7Hw?=
 =?us-ascii?Q?WhWPx7ziztqdVZWaL5ug/O8y3BEoGneYrPg6T5uAUwXf+DPS7YcfeIJTNDDI?=
 =?us-ascii?Q?GL6yV02zxrxyz5qGN/Qe/W/iBeH/1oLNZcP7Cj+/7ALie01QA2pwauGH4EVY?=
 =?us-ascii?Q?OpLfFBEt93ff8qa6SrYTV1tPXYRlPceBAvk9kdybZcRWFEBhHtU3zd/ww3CC?=
 =?us-ascii?Q?HkneIurmPs4hkvXBglTOMX0hQr4VeVmK0rOOo1zs5DhJ/e/b2yoE3sayBY22?=
 =?us-ascii?Q?4fqqk8MmI2FX0jiu4P6/1WdHi678gr67/dNjDkUk6FoOHPjx5qJBo3BCxAbq?=
 =?us-ascii?Q?DdNUCxgBFhQ257X8RTZ+VDIdThvACGAzQgxGUxlUL00ZXEPQVizOaimqTHhL?=
 =?us-ascii?Q?tI8OmJIMMm+DZ/MNPDXufcjm4lNf6XGisyygA1KrwIWKn6ewzZYTCDmQiFvs?=
 =?us-ascii?Q?RuUhwPn4Koh33CztEyYvYA64zFK9TN+Izxr1mEYL4cIKNzn5cZaKJerAtHDx?=
 =?us-ascii?Q?J1Zk5VINk9l6pl/r2MPuKgbeiFxXKjt3ryezNoTT6n/ULurVoRbYNKj7QhpS?=
 =?us-ascii?Q?zJ3459rx5yCxfRdsQ+cg1ec7HAHvIyoH/wVedvWbH0NQi0ti98VOfYBe3ARb?=
 =?us-ascii?Q?bgLL3hYFRNNQLwi0u/vb07BZxQNDuXOnw0AUjIluZdMgjhI1GSYzUkr+DmPx?=
 =?us-ascii?Q?K9ZNJpQbntJ8y6VlSXRR6E0pcp6xRkS5r7rrFxE3Osewk+AkTpdI6FKF0YNT?=
 =?us-ascii?Q?40i/StFf0kcp0YhH9wq1uL7zq/YT8jsZh2t3gnR8/7Gpupq1tEyW7yE2Dra0?=
 =?us-ascii?Q?7NODaupfB8hmtbvuOU1jr5AswHhFGi3OXVJbF8sfdR5apRXzdgA6Amomwt+G?=
 =?us-ascii?Q?Qk8eNNEJdgNVOp4FjzWhC68TgK87hVXh5HlMW3oxpUQr2qXcqgAdBmIG+M+q?=
 =?us-ascii?Q?wfGCpydmohh1xr3uh8bDXodh7kFU129u/fMiiCk+kEboLg1NRy4ZoVsXdA17?=
 =?us-ascii?Q?W4mMqILagQxftw56wsLn/eJKaJtXklWhI98x5T0EXsqjPOmIOcNPh/M8Utzx?=
 =?us-ascii?Q?vx0pHdLcMa3oN8idvNSxjUOJ58Jx+s2PJQBPi+NuRID6qdXb85StbLQn+CtZ?=
 =?us-ascii?Q?tcII9P3ZxjZoxsgTnQxv+9pKDSRNbdrBofy/XTDlF2yPVNSlChUYEYKsufLP?=
 =?us-ascii?Q?MWzj+bPGgDnaBdpPTE99v/HzyaWqQdMGB7829X/4ecmrODBQOZkY2+wzLetg?=
 =?us-ascii?Q?ardF/hka3MnE/GoVtcybCsHDibowUliT/DCLnE7QXA+W/AymeW2uQ9ChCQhE?=
 =?us-ascii?Q?u8/U7HtzRftdPqQFDKe2oX/7oU3kGSH+zFzP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB16368.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mlhh5S26haigJ3H8ozqWD1gOUvT4Z1+nEt8Yi5k7pnb4CAnT+5AKqSd3Ds0U?=
 =?us-ascii?Q?pmK8/KYFcSQPF17nOdnnW/9CjPRvekLGLk/e/CRch1LH5iUNY0PjVhpTtweQ?=
 =?us-ascii?Q?gnwKJmA2+OJ+plpC2grsGhSvuyft82kK/BxNAp6LiUyBFPxIG4BLry0PHBLV?=
 =?us-ascii?Q?UQiNyK5xWjhnk82mk4XCqteMxEt3v6+MMRavpW0DKb7Ra3lDiZUfmfdcfJmx?=
 =?us-ascii?Q?A64kVXUS1Q/GPU/d+xxpNH5gvjZ1x5xMZRsfNyrqvaTTohK0M4t3m7D0pGHZ?=
 =?us-ascii?Q?jyqcitm+xGID/JdCV+Dr4ygICD0EI6PaRCKfnwlxpkQKkOtpD6v8l9xQgnlQ?=
 =?us-ascii?Q?MEZnHgcTDyGWY24zH5iGuhacbri9Q8zKVTiJ3tUw/tMdSBazJ2o0Qf4klnoJ?=
 =?us-ascii?Q?vN667sbo7vwiFKD6v3uDBjON7Gw0cVhCn6rUwzplI3iEPolKKy9s7oHpBXqu?=
 =?us-ascii?Q?s9SEKxj+BCaPJahUM5TqS0RMto3VEwyi50bbYKEBv7ty44q9gYGgwQAdocQc?=
 =?us-ascii?Q?Efn0rP1DRYx1C+wQJZGs+jNSyxyNqQ8qqiw1i50Ii+8KBHJu6v4gJ2ZXN/GT?=
 =?us-ascii?Q?jcPr0e30uPGPFaq5j1wlxxVKmSVtJo9/3gteosiRJm05UKX2ykhYBMnxnDfq?=
 =?us-ascii?Q?wW/tjdHkJ/3p69J5jW0n5cSydqeIJZmr7oIP5GzU5e8cqDKFC5XqL6MGOMbj?=
 =?us-ascii?Q?IbrrcgKHH9caI9TPeNKOdscaoAFkwGZzDdeD5nAeJSgMK/iKGmq2FKVUVfzG?=
 =?us-ascii?Q?IYLWt8wMFUZKzeKUCaeRJBMpIoN8hQeRuvjG65WSzxgS64CcHUR9p+G28Lna?=
 =?us-ascii?Q?iR6txhYuSAO+YUs0hDBEL+SvAtazIwUbO548HfyLeHcDDtRgKqA+MMySG78P?=
 =?us-ascii?Q?W1uKULyHH5Cb9SamWh8TosKXdcgcmNBsnrtUNiKYIpEVvatPMuoli/yA4KtE?=
 =?us-ascii?Q?TvRciaEt1qjovl7RzFJe3L2E3whtA4J0pLLNpIwCkk6QZUfNp/VS2aBKbnj1?=
 =?us-ascii?Q?NnKD0SOQt8WmX3uS5P264yOKnGxNbZkxZfM2zALVTdCNMGXC6OMYO58HKPOW?=
 =?us-ascii?Q?01SuCQxCf20kpR/SShE59UZHSQMeraMKEQVNM5mV9cH8gozHJj2E2Uz9nlsh?=
 =?us-ascii?Q?BiF4pF4/TGj1hj5BCO8Du6fc4LhPjdFmDwigZjyAbLeQ6+HSN08zQ714FMj6?=
 =?us-ascii?Q?RYb/2IQn1OsWcO2MKn7rpB5AOAF1Li8WXo8FriMkartUC6TCcJArGhDnUFHx?=
 =?us-ascii?Q?JGlg91QwAimXYLK/mt7zz1PN5mxIb3j4EhV0wRPISQGNIXBVH+/gs0HR0bHY?=
 =?us-ascii?Q?xOvdG4aCz0vPvq9Ud6O9ND8PZf3ZuaV+p6YdvrFkxCODDjHSzNvKmoQ035c7?=
 =?us-ascii?Q?SiVDqInVX4Y7L00/1yhNMmzDHbrNbupOz9/yLHe0MKwfvLLe91YhShij3nc/?=
 =?us-ascii?Q?O3r7UmoTJNTTYy5kLedWDzvY2JXHL0pPoxai57fsFz/NzdnIlZILtIaa7954?=
 =?us-ascii?Q?lKw0vP7RZeP6WznKg26Q3zO4S64WAlqDuZbM3IpZfp5UOoiFbuEGyHVgd/JP?=
 =?us-ascii?Q?jaJ/mKAetWlwxg3h5WO2AOCt0DzSrhNgNfugbwbWMtWZgErjhLF9468k6xyC?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB16368.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723d8852-9f8b-4c1c-b073-08de1bda5209
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 19:42:42.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcsYAa2WwknFI1AmxVEotlDQt4Ybs55NGNBAKQ2M2taCTPPAApipuY27lDLVCBoDh4RcaXsBZfRkOVxGrxjIAEOZ0WQLFKVacPQ3NEISTK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6568
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 19:42:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20355

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, November 4, 2025 1:57 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [PATCH 6.1.y-cip 20/25] net: stmmac: provide generic
> implementation for set_clk_tx_rate method
>=20
> Hi!
>=20
> > + * plat_data->clk_tx_i must be filled in.
> > + */
> > +int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> > +			   phy_interface_t interface, int speed) {
> > +	long rate =3D rgmii_clock(speed);
> > +
> > +	/* Silently ignore unsupported speeds as rgmii_clock() only
> > +	 * supports 10, 100 and 1000Mbps. We do not want to spit
> > +	 * errors for 2500 and higher speeds here.
> > +	 */
> > +	if (rate < 0)
> > +		return 0;
> > +
> > +	return clk_set_rate(clk_tx_i, rate); }
>=20
> Silently ignoring errors is ugly. Author clearly understood that, and
> wrote a comment, but failed to explain why ignoring the errors is good
> idea here. Maybe this should be WARN_ON? Better comment would be
> certainly welcome.
>=20

Indeed.
If this is relevant here, I can suggest the following comment in mainline
and then backport if accepted.

"
/* rgmii_clock() only supports standard RGMII speeds (10/100/1000Mbps).
 * Higher speeds (e.g., 2.5G+) are valid but either use different
 * interface modes or don't require this TX clock adjustment. Return
 * success to allow the link to establish normally on such configurations.
 */
"

> Best regards,

Regards,
John.

> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

