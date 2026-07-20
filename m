Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B5C44527
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 09:58:47 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5692.1784541525026850280
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 02:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=iP09HLVF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.24, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqXzCadF/NyuKX3r9jppZkabJBnK9udfmeBpAjV7uR72EcN7sVaHQEErzmKnSE8900Sp9R2/cfjPMqv/oOCj5bMIs1Li9cGUeKsTQPXdgHevHOSR6Z+zXTlA9ZEh5lOw3V6j+RgEEpba4gg1sLogtjsNr6AQ0h1fFKUpNb2YzlBbZruIbKOtjAEsO/MAvYupchFUwGRs/i8xhB0mBYogbxd+vNNqswiSGf7uU9xO+RLZRlqkhvNqTaqJ+xN3yGSQerL5Nl9vz2vhUJftDJJZ0aWBLWzOr7pBx34U0s1uBf5369rpz3kbYsqL0MTn+Ny3gT+Te+fVdlDi7E6ZAd/PFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e32qqoHQgUu8ab5qbYcPtm8WvNe7N01uDkKXUoS4QM=;
 b=hUMcRZRBn8KwD7tsFSdaaGqz8W5CVFRGMHa5sq6+Iqdfq2eW4mQxs+fVfO2b7+ajOYpL9a6dN86mBv9R+Cqt+83tlQw05X6HpwAOD9kNcrJA5Wj46yZLiLjvVVGBQs5JefgpKF/Ee/6qARG8gsUnK4soacqfjHn2mPQkPDmcZD9JCYJ1BC8PmhtNiAPTThojWXCxqB0YJatwS2zjIrBhWUk2SZAvptzBa36osAs0BMIW9SzQ5QctizjLZGqlcAeALKMSvd4U4+V9bjGRqD2ovR27uXNs4vFpQT0uMoQbpzsbCSwhe6o3K178lNmoKUXWm44J2EhQWqK6Ic6Wdk3FXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e32qqoHQgUu8ab5qbYcPtm8WvNe7N01uDkKXUoS4QM=;
 b=iP09HLVFGIuJGJfCBhXPFT+mctuElapo3I1MpkLbrLEVD8idLCQpWxzHx7U7BLPJFzApVMmmEmiX6ks/BmUGUPux+NrwoGr1xG6E/juEIN7DWSrmPLOw3TBn0JNqksRvF5UYp+OmaXlU3tNGvHnKoSV07Mjhvqsy3T+28Px+ItI=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TYYPR01MB6874.jpnprd01.prod.outlook.com (2603:1096:400:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 09:58:39 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 09:58:38 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g077: Add xSPI core and
 module clocks
Thread-Topic: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g077: Add xSPI core
 and module clocks
Thread-Index: AQHdFRCgzcSjmjsDrUWYDAy+5O4+crZ2Mi8w
Date: Mon, 20 Jul 2026 09:58:38 +0000
Message-ID: 
 <OSCPR01MB14315322CA980A86B4BB7309FAAC32@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ali274E3aNG2-Rtx@duo.ucw.cz>
In-Reply-To: <ali274E3aNG2-Rtx@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TYYPR01MB6874:EE_
x-ms-office365-filtering-correlation-id: 762a3071-6631-4ec9-3aed-08dee64578e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 SyK8IKzoQN6QcPH9wmGLfnsuuw1ac9PfVgh6adf8N2AH0ZTwhRF7dO2rfJBMejNvUjA+8Yysl1X9tg+h5CI5Bn9+/Zbh6xIwzDor0BxSWMm6pSySevpXT221b/oDtqN8WwXWVifz/pfCh3oGWtoKAvWtuvqUtNjSUchJ5A2O34acmJL5Bqraqajc7t00rl3Dr1qzbmWxllyYjCdfY49hj9/ct+mvKV9H0XkupoqI+ck2bsohCg2JqlVhsGF3q3Vi01NPzvTqAAjudH8vyiaXvLbKSquD+bhOnflQWwp+DnG8ZHq9+GA+hnTdqgCQghUVG+2FfUuhMLnEsGbogd3ltxX+HSBLbKYgVJBtjHC8fntvL3Ip+lwY8qVEnJeJ0vSkT1VCI6vWEmq1LdfthfoS3Sp1sWsieiBKKlLXTO+6aktrq9jkXPxe8YVGF4ssGROf0RXIW4pHkz04cVAVKTaJBY9ls5AsouJe/FiZiC7CECS1fJFaQ5it2DhXheJarlPcO3qPB7D3+OMDkuTRsthIfMeomFrM4Xw13JbscxYlP4ZKnuWlxtJSlqN7m9aC6SzFDV7GQhBy3sUNHCjhzGUZVjzargx26b3qZZlTaz3DhRu34k5pScfQkIp/hSVpHsfA75C2ziZwwm6ID/6Bmz+5gy42fEDwtZCjRM0V7ZZLB/x6v0nxXrmWrM27u9E/3dFdOKzY5hbWAwO8prK+CY2IWNxIkdOPtSF7IavOnOP8ykw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?hv6RMWqxTraS73427zGxg//RgtJRQBSJ5sZVCRwHN791cO5cbdPatYWLc3Cn?=
 =?us-ascii?Q?dw2zzH6D9hfuxM5ADdQ9EhwrVFbyPQhmDHOJx9dkjlXcb9GOn4gsv0ido1oT?=
 =?us-ascii?Q?wUk4xKs+s+5WTcZzTWxWoPsyiw8nCBFS/xKy9yZd5mUM2dLI67Le46zMPA/q?=
 =?us-ascii?Q?mVecGwB2yZ2vSy+rQGHJAmGIjTSxXkV0ofxnAHg2O32vkvjHrruRm1Pf+jVu?=
 =?us-ascii?Q?Re/TvWvXCoFnmme0rROr9KrO8y7ygRdU8VQGIAPSlwFAVH3WOhU2NkkIP5i1?=
 =?us-ascii?Q?Nh1iyG2w/qG/dkksUZepB/5RsgDJsCkamGoOektOmM8KjiyJaABWemi9y3H/?=
 =?us-ascii?Q?aVqXU28frUgcOGp2q978ngAaR7zv1zrl+gE7hYxFQGWv+MCepr2mAz3BAtAK?=
 =?us-ascii?Q?wWsLJv2KxsLX4a7TOpCrEuZIv81gWYtoLfVnHIPMtGw/0I1qjVXqAwXjV4iw?=
 =?us-ascii?Q?r+OKwAPFDt0Fhrb4pdH2QfGeGUHSPd/LSCtSofgqC4LzYhael7ZdEPwAA9KJ?=
 =?us-ascii?Q?iQPMn0IbYjzyJWsZ/9yTRwDvwid+q/z2r28xDV0m9ndcHWPOsM/apBbZ/tnK?=
 =?us-ascii?Q?9V74ZO+QX6r5NCoczj7QsiiomC+6NYajQyyaCv4syL3vQqq1tUUuQGPDU5Z5?=
 =?us-ascii?Q?mYcb4sV1peL46VMaUw8/5094wHsC6eThOzczcwMmpFLXgH61FWdSDPRfWcmd?=
 =?us-ascii?Q?Xkbnw8gIjWH++mlfU65sImCnK/WLsZ8cHZVq7Cz7RlTpxv4C6rgqRBWo+YAP?=
 =?us-ascii?Q?M1NpwpMeJnfHC1VucI9pu9/1HPAO6HNBV1RWUhNdcFJXSWrLltuIH17ytSfO?=
 =?us-ascii?Q?+nFjvQymrty7UZ3GczMOE1Mh/BBN+npxlRLIW4v8wHFaRHDVoxWdjQCabMD1?=
 =?us-ascii?Q?bcYHPBRcPxe6Tkb3Qx85G58gWA3UzpfUoaZu38il5hrIWfc5Dpg6+t4qCK1C?=
 =?us-ascii?Q?DRC062NMMw5jRRhF9zsPtb2TDEl0HtOf1uWmMBmySHQ384dCaMJaOYmXODsc?=
 =?us-ascii?Q?Ehz1JTmjFqOst9ySYUlQX1r6xsko/QnEXbm1DN32ZF0/CvRar0L70/uejvq/?=
 =?us-ascii?Q?BOIBDvS56NNKvdu+rSa8o49xB+iVOgAaeNTgjtZs4V8RHWIoaXYgs1EOvSoe?=
 =?us-ascii?Q?gdA1xy1wf5b0YWM/XfdXYIYteGxmAPVzSU36WUnLEKUptInIuBCBvCc8wdSC?=
 =?us-ascii?Q?YAdTfgC82Jp1zBizLZ2h3u5Ps/govHAjX49nnHzg5LqOluaaLgSAbIPmj6Qx?=
 =?us-ascii?Q?8AVOizfGCU3ie3obMnwD5aYDUZs8Z4jIfnKPnl4pBCOPN4j7BgKNtpzkBM4o?=
 =?us-ascii?Q?FuKaWSyw69W/+/xXaZAxln0ZV0kCy9eDP+fMu4ezneGb2hszby0J/5UpchRP?=
 =?us-ascii?Q?Iy63b/hE8MCIjtg0YUdOw1pqjfrhXu1ptStMVYhd8ekGrsjMC87fL63a3iic?=
 =?us-ascii?Q?Ga6pRi3VE6BGb5m/HiKORouYHwoRrtJvlePYQLJq9dOkPca0xJ1bZOgB1a7K?=
 =?us-ascii?Q?lqlAn3pN5tYFqFz2vRd2kKTqTL0DWDfVVrubsMQSERuP3Y/kgzABnYMQqXcB?=
 =?us-ascii?Q?+fxd/fD3+ogFrJ69tKoFnaXsWxykEOvwFPdCmyWnPJVyisiYOI7r9Y8NDrN7?=
 =?us-ascii?Q?WEbAP2s4uTqLIsMpwshZLtSX7AC6VwvzOueQQlE00MFg53no4l1sgzBbymkR?=
 =?us-ascii?Q?3GMMoS13woVohfsc3hB5NxQWXg8WeNfLi1ky4ivdya66rmQ6sG5Bdy1J3RBX?=
 =?us-ascii?Q?gE4XjYluaMMZMgB0bws7R++2bJmp5lmyFnqpCkkQhMNGfK8NcJmz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a3071-6631-4ec9-3aed-08dee64578e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:58:38.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXtpFzkqDDkjD6HVPITOj/VtNfVG1ezG9/o17i/MSQXbHpVZpFUb/gB4SYCO8r9hvy+WK0DSKdQYdv1H6xXiLZi5+Cjv2apNCMZjMZhQFNPsLBR8MkLIxjPttgwG0Pa6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 09:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23675

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 16 July 2026 11:48
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g077: Add xSPI cor=
e
> and module clocks
>=20
> Hi!
>=20
> Minor details here:
>=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > [PL: manually applied the changes]
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> > +++ b/drivers/clk/renesas/r9a09g077-cpg.c
> > @@ -295,6 +334,151 @@ r9a09g077_cpg_mux_clk_register(struct device *dev=
,
> >  	return clk_hw->clk;
> >  }
> >
> > +static unsigned int r9a09g077_cpg_fselxspi_get_divider(struct clk_hw
> *hw, unsigned long rate,
> > +						       unsigned int num_parents) {
> > +	struct clk_fixed_factor *ff;
> > +	struct clk_hw *parent_hw;
> > +	unsigned long best_rate;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < num_parents; i++) {
> > +		parent_hw =3D clk_hw_get_parent_by_index(hw, i);
> > +		best_rate =3D clk_hw_round_rate(parent_hw, rate);
> > +
> > +		if (best_rate =3D=3D rate) {
> > +			ff =3D to_clk_fixed_factor(parent_hw);
> > +			return ff->div;
> > +		}
> > +	}
> > +
> > +	/* No parent could provide the exact rate - this should not happen
> */
> > +	return 0;
> > +}
>=20
> If it can't happen, WARN() may be suitable?
>=20
Agreed.

> > +
> > +static struct clk * __init
> > +r9a09g077_cpg_fselxspi_div_clk_register(struct device *dev,
> > +					const struct cpg_core_clk *core,
> > +					void __iomem *addr,
> ...
> > +	if (!xspi_div_ops) {
> > +		xspi_div_ops =3D devm_kzalloc(dev, sizeof(*xspi_div_ops),
> GFP_KERNEL);
> > +		if (!xspi_div_ops)
> > +			return  ERR_PTR(-ENOMEM);
>=20
> One space would be enough between return and ERR.
>=20
Ack.

> > +		memcpy(xspi_div_ops, &clk_divider_ops,
> > +		       sizeof(const struct clk_ops));
>=20
> And the memcpy does fit on single line.
>=20
Ack.

> (May not be worth cleaning up unless you are doing changes for that
> anyway).
>
Agreed, I will make a note of it while doing changes to this driver.

Cheers,
Prabhakar


