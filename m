Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81602D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:46:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44973.1765791960336566071
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:46:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=u66nt0UP;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.56, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXYsiQYdk9P0Z3yXze52WsAfu3sNlRvx5/EwrtBDQNqvLujUiCpruZEXzu+VP4Dgkoq3UxsBqT5m/nORF8e9UccMt01fFig3o+A7YG57uYYAUoiWzti4Xz78eWAEwswMwxpsWgCO2QYpSK8KmytnLzNUGoH+NC4qtg+sU5GwJfhSv6d5viUnlsHrEoS+gQUh2bfJ4LZNrJl3OcvcNXrmJZG2iQbJ3fU69NvywV6WUh+pAgw1c6GMndONDmncEtMzyDaEV7nz8XFRM4j9UhGpGTiwySZ+Wxe8SsH/kUpmGxnFmfadFcz57kmAOGnh2CekQjjlxqcOqNJffVqVcERvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q33FT2pcS1ddfiwG6S6x9EM1jLUoHnDe3vaz5Qa+tzs=;
 b=Ivu8KoEhkFSgHI3hZa9WTuoQtskBDLmJLQ1SIuDbcecQZbNHXv8jVe4OF/Yjby8Z8pqqHxWB0HtZKRlbRWFSM7ScKtc1LgPW29+7uc2ztBI4t3X59xtYcnv+DFe+ZlzXIvehvmYT343kBa4hEdUbRCxyTpEp3I0luiMwBb8zO+SLeZ1HvnA8FPEk4xnz23eDf5oXxxaURdZIb4bNV7PBA4ggDtyUiTryVMGqOMhXnlUN1pVfmIAjkOT2eDHbC81hYYvgNbqWNQGd4nc0pJl5O2cpSPVIyWPlpJ9P9/Vwn7o65K/59MvxnKE/nrSiUzioMTrStPE6a8TMmpdaBCtXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q33FT2pcS1ddfiwG6S6x9EM1jLUoHnDe3vaz5Qa+tzs=;
 b=u66nt0UPr+LVhpwjJCoYE/AgOXQOq77Ui8V9y++1juiECeHlF9XEYw2VACUAPMsdaPgVviaS313w2ucCK9m5rKfX+J61hPQjgTygFOSE99X04CZcUpvbN1tVVwzN7CrjF6Flv68TXPXSSciuAUnernvdzyiENnnpCsjliHu8YeM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:45:55 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:45:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/3] Add 64-bit polling support
Thread-Topic: [PATCH 6.1.y-cip 0/3] Add 64-bit polling support
Thread-Index: AQHcbPKqEah7vOIvSEmbWF9qGVccDrUidUaQ
Date: Mon, 15 Dec 2025 09:45:55 +0000
Message-ID: 
 <TY3PR01MB11346EC45239F519A9AB4364886ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: 5d17fd5b-361d-49de-9c76-08de3bbebe43
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?B0ylXG9g0Yd3w/NFDi059NIEmJIVXlzKLHjX57bx4QMQqnZFdMzBRiCYpLnG?=
 =?us-ascii?Q?nZwBLxmUpRqCCKwJ+yL1QTiBlezt3lEuDXDK/kQogwKYKWr87GldKV8BwgMC?=
 =?us-ascii?Q?eyNHbdfbOBaPf+j+jgHFXNCPw249muN1dKEVEJDcpTZHbRDrSdyCkY/VNULw?=
 =?us-ascii?Q?yBnwZs1+5wIBvsEMKASCKifGlFibyfstubEc005SjptduZmkOhHgXPyYF54B?=
 =?us-ascii?Q?P4XU9+p0e/sXNqaFc27uQlB+AY9Px+3qqYNisKIU/BRPkzP7ucgIuACYmGoM?=
 =?us-ascii?Q?HQ/YzkzM4MuYYRr34ydIeSab8lVkptx0JVZO4PrchG5iT3MKYTSJJuis4Sdb?=
 =?us-ascii?Q?eo2Z09cP30VUupdJkU+LUCmaL0R1kW604bTcrG09UKAMYlqel4fjle50VfJT?=
 =?us-ascii?Q?JVv4FfdisZuDZ7Upu9WrNgm7p8h79DJhI40pdjhsoPuaEHWVoNCkyBb61YtB?=
 =?us-ascii?Q?e5+rnXNn7tuxkhMnUe0TFhE/hjla4oOrQwT9FHh9cHrv+IeX5u0VA9xoJI5i?=
 =?us-ascii?Q?YB1KHp2mNhpCcyiyt3ehBPo5HMWhfmaj6O3ZlgNpoTozCUiTHdzcBV3dkdLl?=
 =?us-ascii?Q?Np7lCneHlVbYjjHnqN0H898bUC7qXrK34ce3p7lvTmLOSbURNjzsAK875t9z?=
 =?us-ascii?Q?6U9W+B8+jpKWxYtXTXbg62Vu+lY8D1FHqY8foauMqMSelNcIlST3Ak+eNQh+?=
 =?us-ascii?Q?oml6RE0zwigGDvwkUJ63TBwenRQmAKIBmjnov9zzBBgl8xJIp/HKjRFtDCYo?=
 =?us-ascii?Q?YiKAuJlwsOOSfM3JdMWswpVQHY09hq4Y0eqTvRc3BnX2fiODaJ86oAZcJs9O?=
 =?us-ascii?Q?JSjWsN23MZ7mnlmTl+wWYZ6+b44IMwMtLS8xIYyYlpsgFjxKbxOJFC9/osVC?=
 =?us-ascii?Q?bJZ2+v2wOE+cQd2cngh+LCGsiDP4bsTTk8/j+3+Bmzf7EKoGbs8xl3iUHPXd?=
 =?us-ascii?Q?0l/+83hXswrPWmtwTLZo5D0Nh0wzURWLPpVduMFPNpgi5Keoi9Yig76NwOG6?=
 =?us-ascii?Q?mf81qr/47a9fxxLED3gHqr6NvgwpvIeKXSo8zroYBXjiEkGMPOCGT4DaDiLE?=
 =?us-ascii?Q?z+cGN8rkLWwXxjScEKh597JIgmKeRVXpUEfQD6ozyV8WrO1D+zz+k9tGmg8i?=
 =?us-ascii?Q?ZjmB0nvugCt1f6W5obftPzQ7CNLZjOGFXN8CEV2FW+G485Sf3ufXlmp4fnpx?=
 =?us-ascii?Q?wkV7yK+jd1nckeYCdGbsRLVUKdQtX/v4xxNNmPeaSzP5zHNHt5cPPp35qR/n?=
 =?us-ascii?Q?ZrxWmeRCkaf1BBEcIu7QscuTVw8XrUxxBGlqH8doPp1sfV6Xipd/PICGXpBp?=
 =?us-ascii?Q?11qZRRgzueaqq4mLjBDyd/xUkjFOBtkGHm3z1s6oaAH4LXiDfzx3KhofaRK5?=
 =?us-ascii?Q?F3kOpd0MVu2XVtB00PxH0/EFdQIFcnDgqfjpbvF2ZDIFtnSqwrjaCaghAJ2t?=
 =?us-ascii?Q?OZWkxjz/+/ASZU+YYfbd153/ygD5qrIg9lV61PYq8/GtG7GN5kE5NkoMnxIp?=
 =?us-ascii?Q?IrE5quSsWvKd6xGl+PSitZZiAZEQMV/RsFOh?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OwrOvOFPKgHJam5kREntieksRDUb58OoPSQm+vwXGZjnILbDCqkSvIL12eBF?=
 =?us-ascii?Q?qv+GKVe61sBwTsNhYo8iutjsTlyzTeBo14BhEQ19KIw432Pii2FkpLo8EFiS?=
 =?us-ascii?Q?13aO4mZs5z24Sj+eCig5BxR+XlR/ld7e5v3k5TOdkSO+6i+HQdNLZzXM9LgH?=
 =?us-ascii?Q?HzV+YDK1A7nIBCoe2+dNH7cg3thXHrBCZMLBAoMauQPK9mhc3h4HiXGDYSPN?=
 =?us-ascii?Q?eca00/nlGcRIZISrggzdGkqaaWyLsaitZah5fEWSz2MbcxWqPoPfyAr49Vbt?=
 =?us-ascii?Q?/rjNKP8TQ8SnH2BBwM9CXyqfpAARxVymcydIAqosYIwA8cQZBNNyzr846jPk?=
 =?us-ascii?Q?zcLoD2QEmYYwLrdG+MJsBuPRb8p2/FlKsTzLsnbiW//ef8BTs2cNKxspZPki?=
 =?us-ascii?Q?7bTL7fYXRH1enHGIgYgwrNqem3bV1061mSVL7sreV6POmxggqNVj/9FU62zg?=
 =?us-ascii?Q?icobAv37M0TpNfJBKqPnYhJB5UamSbCc5o7TiR3IXO9tfPzLay5ZClgGpMxU?=
 =?us-ascii?Q?C1Y6oxtAfgj7bJtCrkGARShep/BKiJsB4fuwMKDJIb73DqPh8gN8JcjR11nc?=
 =?us-ascii?Q?VUCMrWFyM6g9s2+7Rzx6InXwAg88rys5p+85QTRJImyMeBNzvbv9eRfJ6Sw5?=
 =?us-ascii?Q?JIkZlIWGuO4FvuiPEZkTa/qQZFcQ+1o+WQwBH8BXfZgscP7Nj6b7Y3uliZUF?=
 =?us-ascii?Q?CkJfVkb+HgLHWZ4NSU6blMhfZP0wT9qLXOt4/RZ4KCVMR8eyvlcPkaUcBeIT?=
 =?us-ascii?Q?4C2BSa2+QRputomgyll2k5yu8cbBWrhImXxJu+Aq89AIpyzCRjWKJ9I7sYjL?=
 =?us-ascii?Q?/fuc0QlL+v0C+nmLAKIkM3kwLqsjPWmFb+egxpDVbZkDxyX3LhnO7+Jug89m?=
 =?us-ascii?Q?HkRJSbA2ZmbDPJt6Y5Tls9pso3BcrokTWFRjoJNFK0ylkCXoJtLgM7TuEqQE?=
 =?us-ascii?Q?ZUxqorjawKUHZGRuA9H0Kqs7ITMhTJXW6pelDhHmV5ibrSaSCi62iqLozRkF?=
 =?us-ascii?Q?mi7h0CR4Iv8QV7YUHUrMhhmLI5C1lCQ7ssY57NsoXvsEfyvXQXRXGTAF1ebb?=
 =?us-ascii?Q?kooPaPotbETRrmKO/NHlHoMI8iytwzPS5hFetLTnjaRsE+Zu1i/bp+v5QJlr?=
 =?us-ascii?Q?NscJHyi/tkD1opSoFLPNjDeN0BLmvbQvxw6rZboLcpjajekH42WbCrido5Od?=
 =?us-ascii?Q?IGp6QLVtax6Gu8QRkCGUYnuYwpqpJWvE6pN+tJHhjU70Z/zVV85a8znkWhot?=
 =?us-ascii?Q?QgLqCQTeGyq7a9CMVbQLM48/tDpsSWy4z2ZEPyEfGnqyvtJybNn6VDXxM/cM?=
 =?us-ascii?Q?fVHsFpLcUg4mcOfZpmryVibPWvq0Lny+A+sJCeVWrIMu++grD6mK5RRqkN+6?=
 =?us-ascii?Q?clumxhlQMowZCJHgW12/vGNqmYiPB3yaLufeNq52nSZc/wgfN2i51pT6uR0O?=
 =?us-ascii?Q?uIKM72QyX1KU8t0OgNm+/5a/tPbxJzYFjvDAsWmURnRrz+dA6vHg3vDiy0cm?=
 =?us-ascii?Q?HBA4m0RfT3bMPdYndKGT+rneSpJWNKUcccmk4T4Yk8XOu9QUbFyz8gdWyiYe?=
 =?us-ascii?Q?z6ywuYLU1D2R6adXV6U50lYhE2tqjTssX6GC0JwE80Lbrbk2f19zeUNgX427?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17fd5b-361d-49de-9c76-08de3bbebe43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:45:55.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRCo4585GkrEvnlRQjum3ZzILBjELw0Nu+T43+WEoZ0ftjgzSntvPHd4HdcsJ5L7Hy2mwKIxjIgbqzIjuQ1yUOU2AnVJHQOuGaFND4Xwhk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:46:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21041

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:10
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/3] Add 64-bit polling support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64 bit=
s. Most of the data transfer
> in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128 =
bit it fallback to PIO mode.
> In such cases, 64-bit access is much more efficient than the current 16-b=
it.
>=20
> Biju Das (3):
>   mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
>   mmc: renesas_sdhi: Enable 64-bit polling mode
>   mmc: renesas_sdhi: Replace magic number '0xff' in
>     renesas_sdhi_set_clock()
>=20
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
>  drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
>  drivers/mmc/host/tmio_mmc_core.c              | 33 +++++++++++++++++++
>  include/linux/mfd/tmio.h                      |  3 ++
>  5 files changed, 54 insertions(+), 2 deletions(-)
>=20
> --
> 2.43.0


