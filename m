Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82670D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:46:33 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44989.1765791991446814392
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:46:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QHwLXNn9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we4b1btawPi/ci+WTMCG+MBGUyV0w/ofXwR/iRElbBYXmrprDRWJrmKGYdEuchjHpAV/mTQ+DsCm7rfzD8pkfDjwZ90wAWVkrSxH+6wz9GQslbUTJkTfaWYDlA49dCmOFydJBOAZZnqcc20qvqTAPjf4hS8qJPwzKVcURVg0if9y9HH3YDQ6IySJmIjp1I8sKW52ilt0iUNHBF4SIlYGIpB087zz4rOxW0xRN8G91IkTrbLiwjEZuHNq+Sa+PsxNu2rKJ99lATZOiMmmNfmMM5wXCAwSW+WZD4A/oICURxpXSu60NBEukXC6WHGqwNzSbr/rFuRnO6+l2W78QzO2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmavm+wEilC1lpl6aLKMslb7sHnfo1MnbgFhN8QF6gU=;
 b=wfVPCabYXm4AO226EBcc7IJGNjfRHSylZLo5cmrn2LADuXgzWium3hpioULa0li831VABvoUg0nKe3+mLDPoqPKh0GOxbSUlySn+TWXMIXhKoRMHVv7VOHejhfc0N6jNa9g6X18lAM6RuCHCaQ7aTc7FIm3jl4WDE6BT5wpw9lHrS47HcqSzDxLgJrRm7PxqrhAJFlw1aqDY4CwJtcK+Uk2di0ASlGpLBmAVg7N+/8/lEyNH1ROauzZS02+H1kReW08WXJBrInxUhbyU85+JXjqsY8hTLPffHJv5pRebuqyRXb9I7PS8/6B4xcZlTK50YYAmx06ffYs1xj9R/0XJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmavm+wEilC1lpl6aLKMslb7sHnfo1MnbgFhN8QF6gU=;
 b=QHwLXNn9fDvZdQXYnDUzeeOfXh3+BTJvEDdaoWBVS5uZ4GyRXGPxk2LiO9Smwws7H85dtNSFus15/MlyiIH//gaVKWVNhqcFiPhBJIdfl6keN5bYS6eiPIzQOTb/E7lXfFBnuH9dVtyaE3kmOCpq85PWkW2IT5xBOJyX4CPw+qs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:46:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:46:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 3/3] mmc: renesas_sdhi: Replace magic number
 '0xff' in renesas_sdhi_set_clock()
Thread-Topic: [PATCH 6.1.y-cip 3/3] mmc: renesas_sdhi: Replace magic number
 '0xff' in renesas_sdhi_set_clock()
Thread-Index: AQHcbPKqct4JMnSmHkeFnGu1x83BjbUidXHA
Date: Mon, 15 Dec 2025 09:46:28 +0000
Message-ID: 
 <TY3PR01MB11346232D090A58895A854B2486ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
 <20251214121034.4352-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121034.4352-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: c297d6da-992c-48c1-7712-08de3bbed223
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LFXPrrRa1DSaOIUNmk5H7a6tyFraZWwEu7H/15qjSjgqdgsTGMMLeJFjRJT+?=
 =?us-ascii?Q?7I1mzBR0b5qp+LxqjAdrveH3WClxknW+PJZTkf5Bd0TjCXCOqDYDzP5S/xdL?=
 =?us-ascii?Q?TQznYO+sRnV2/q+LVAZ7qzgeQnGnAr3vC83cz138Xc/0G0oX3y1E1fPAXHil?=
 =?us-ascii?Q?/cF2u4YW/MZfPYC4Qv7eVH7olMn1nCiOLSRd0GGPMI5OU4FddC1nzmPhCBg8?=
 =?us-ascii?Q?VRD3YSoyn28aSY4QbD2WwqYor367DhuDmSiCLqAGElMsRnOA6xSZObbpRHHm?=
 =?us-ascii?Q?5sNAzBAF7BH3KP1BP27HQ12cSBEL4HG6qHBYg2oZCjT7THYY1EBvdV9Jh3bD?=
 =?us-ascii?Q?oDAiToztMOEXhB5c6Co5F+Ux5ZVEBm1q3FD5LxRrwQNqujiO/8+zd5oF3f+8?=
 =?us-ascii?Q?dH1xVE8qXln2sVoHrPOfA0hPgUHz9ihXuNcQA2kMqbdhhY87p8lxtw0aTOXT?=
 =?us-ascii?Q?sSOlzMGjKpn8MJ2df9Tuzs978b3VVXmNBdpYq1KAhVbjNWVdkm+BuflHt5C8?=
 =?us-ascii?Q?umefvzh07jYtd4SFfmEnqC644Cb85yZoyzHxXVqXpOFIUvbfbxqwT8uyzqml?=
 =?us-ascii?Q?uACD4k0VyuIhmA0eWLCsG1gpiqJ9E07teF7hXT/jqYzAR3msmcSARFKfS9tP?=
 =?us-ascii?Q?3Qdi/5Qsm0J1iOnlFvRJowQwxMjuDZEHVgDNTx5sWsPDDpFalNKIGDKh/hQ+?=
 =?us-ascii?Q?lQraSUKiMQO/Ub3JdyG99SrnnwSTCYlx3h5zIgN2BWDxhi29Yu/GdWt4QixL?=
 =?us-ascii?Q?qyHOnIxrKSxcUZknMtCGxQTB8Kbior6gjokIBsoFWewu4PMD8A5hn/5lBxpH?=
 =?us-ascii?Q?zIoCzU/nb8JC8WXfMidMK2zBHF4pTOP2MXq6bumk7HcqthnVTaw02tKk0Giy?=
 =?us-ascii?Q?CJACmV5lQcw04m2rGmoE+qdZ+V7EzjqZqZSIZKPavQoc3+BXEsINNj7bZTbt?=
 =?us-ascii?Q?Fa+mKzisBNq0ekDIiV36fSCk7oDVaJuOMopsZ+jDSTuEReZyf8EWNbbDTXZN?=
 =?us-ascii?Q?bUtKZib/8RasOoPia3GTJPFss2vh2ikajP9F+JuVInx/TSQCcsgVhZwv0A1a?=
 =?us-ascii?Q?E4i+AePiHjg7lzuH4zb6FPBZcUNfhcj7tBkmeNxs4Xrqbr/3qgLoUEDVK0cx?=
 =?us-ascii?Q?l5r1ldZioEyxLz+g6QCduYMbCrks0tyd+1XibrrBKFU2AKVJOLNcj2+hZLVZ?=
 =?us-ascii?Q?LBl7/DPduzsDZ1cXFfkoX0XVI5esKI9GprYINU73JPKeRHZHfLEGEUtF7grs?=
 =?us-ascii?Q?ZF7crtosy9ykbdu2uLV7RVpE5caOWngw/U5b2Cn+jk7fCrHcej4gdTckZ4Im?=
 =?us-ascii?Q?U+uw0Un2n5L3W8ZlS8D4aMfl74xCTQ3vmnYrrKcOxyMpfNFnSLMS4RT5wkeE?=
 =?us-ascii?Q?Sf8EMgySz0YoQouO9YpqnhZ+1Y7ukiLn3CskHn2ljRsZ17zGOnMkGVjoe8cp?=
 =?us-ascii?Q?4BN2acamN01g/0qkil3+dgD9QDIyjGEQJprkZpmSTw2O2QMGwi/3TO1IPWas?=
 =?us-ascii?Q?peadE5ooaoO8ruLg8jfYw1lfZDOt/chP3AxJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?a5VOKuMzM2OdX6ZJc/wxZYakaajoGUMuRv79NvuYB8t6V/q0g9O+YHfH2OYs?=
 =?us-ascii?Q?h1xQzCcTR8hk2a9IlJ+yMRjg6iZJCS7glP3+wKNSZ/wyXY3kblcYQ/ny6bwJ?=
 =?us-ascii?Q?0zyPaNoVqfP37MxfE1SNQ/olmZe7hv57pO6xQ94EgcnVJf9uc53TKxfk7hUt?=
 =?us-ascii?Q?vL4BsimTpTNy5v4fRm7kmXE/FYQ1bKOiXjboSzmHx3A9wqa+z8RRpM7TTL8Z?=
 =?us-ascii?Q?ttj6R8UnAPHiB7x66RDRt+d2bx8MTCfM43/KhAvickKeI83WwXYw4d427/R4?=
 =?us-ascii?Q?z46msNU00un3tPqHhSaqibhE5iYWJNnEqnH6KRJhP6JEKCjlp7U0XhGrFxJl?=
 =?us-ascii?Q?RIwVO+Qah6v8WNUWqvcRcZaFlRauGF0MAQwPu0eo0I6D7rzHcVKkQkTunTfh?=
 =?us-ascii?Q?LwwhC1CyVP81j0LBHwpKgd4rQxYdszxQIc0n7MkFw/r+dlJ59YmZvMMUNngz?=
 =?us-ascii?Q?6jxkR0431l4s69V41zILwah2n+EwCqDenkuviDpPkYE/dH8bw1KlCAsoJp/2?=
 =?us-ascii?Q?+/QrYkyKv3BMMZH0BoWEXU82BR1+50GuwmBm07zrCpEV2CCZrEE/wMd0pECQ?=
 =?us-ascii?Q?vZh4pct5kb5UF17bioMmTsd8UXr3mgmIutvm2GTsjy9X5d1L7CGUFFlVKr1B?=
 =?us-ascii?Q?ICD995Qy1h0hFqTZC+zsxzb8luoobS8J9NlVvI4Mgks68IXdRniIN93ZNI5j?=
 =?us-ascii?Q?PQ0cA3x6Z8z4vm/QNlyjoTtGfb8U+iJxrdeWplG0M1V+LTkaCkyyMrPBA2Wb?=
 =?us-ascii?Q?s3JwFpIq0w8BjqQgI0T0mVOW+du23n1YKhAc3TfESl61Xo7dvtsCp7YFdUDE?=
 =?us-ascii?Q?0in9o79QgiIEy7W3iS1Au76TwMRwb150OipeazwIEAqhYCYiFA6p5ASP9gYg?=
 =?us-ascii?Q?c/ii/9tRUSxKSaLauQ3WH7Lraphxe2dVUJiWucw0XwrR4+1fivDqd3ZzpDo5?=
 =?us-ascii?Q?5v74IAVzS5KyLxyAUugWuczdCi3xtVumjDrvjHcHZpYhcYAZYdcnZt2dfDKe?=
 =?us-ascii?Q?UvZKKsEqGCyOMfqRUsAkEQlIT5QsX4aCZpNLO6IcXOOULepEFqZ6empZGTwb?=
 =?us-ascii?Q?2OfcNAsOrt7bHy2DF9ImXIw+89fH2NarYP/TE4iiPatjFMP/TzemR0lYLAkC?=
 =?us-ascii?Q?nUWFQsygHgsFMhYfwaylpR06Ss8+zUiILj32EpgLzwVItQHg4t1fcVZB2+6s?=
 =?us-ascii?Q?4XWy+XMyjWE9OVjW1LABn2EfSkU09KXPHDQxkALK4wzMzXjKnxBuEJDrfVO4?=
 =?us-ascii?Q?XOHFs6RXydJrj02pSm0iWEPxih1Szfkp3zNTkqAbskY9sBnL3flAzub2XTlE?=
 =?us-ascii?Q?UGBzNyMHfu/uNoDXBvCj2wIf4aBpOY0zJP4RZYPRcj44rTYaaH7NpxZrESM+?=
 =?us-ascii?Q?Gp5tpLRWcm5VbLTaVYn/7PdkojfDgn1p53uDiTvmj/YwrJNhuimmgsYZN2Vl?=
 =?us-ascii?Q?G89zXSpngwyl7mhPOxHhQSU1aAkWT8qKqPTdAotKUamh9NUK+iqgumG4zyv6?=
 =?us-ascii?Q?wSBUhAZr9a6DN/5dFwiZZ51b4C3z/thP3gfXM1UhieaiWK9g4CbaSjEkFult?=
 =?us-ascii?Q?NTqFnEzvOBL7kDHbpA08XdG+D5VAcDzdok6KRdfnl5/U2qKTDxYFPYeaqwTq?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c297d6da-992c-48c1-7712-08de3bbed223
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:46:28.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBBLm2qjfvPQzOCGbIfvdGi2eNvGjXtZgr/l7Lv0A4FwK1KNAEaqo23thwDHAQo9ZrSuJy+02jqZVehaPdpwLmKndOwuAyMOL/9uLw1r/oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:46:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21044

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:11
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 3/3] mmc: renesas_sdhi: Replace magic number '0=
xff' in
> renesas_sdhi_set_clock()
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 5d0702dc9c2f6700140b7366dd9ec6c78cde3aa1 ]
>=20
> Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding a=
ctual clock in
> renesas_sdhi_set_clock().
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20250820104808.94562-1-biju.das.jz@bp.ren=
esas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index 9cbfc2230011..4b84dbb5f262 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_ho=
st *host,
>  	}
>=20
>  	clock =3D clk & CLK_CTL_DIV_MASK;
> -	if (clock !=3D 0xff)
> +	if (clock !=3D CLK_CTL_DIV_MASK)
>  		host->mmc->actual_clock /=3D (1 << (ffs(clock) + 1));
>=20
>  	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> --
> 2.43.0


