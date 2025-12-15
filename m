Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183BD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:46:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44993.1765792001309532775
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:46:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ICQCE5KB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.27, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgr8oLgz+3m83Uw879f4K+cbEpmFsJz/3KZECcen6o2ksMl5CvcT5673cq0HpODtVelZLVMkiS3T8X+Uex54cZlVy52M8nhx+Wo0VT2F+g/c02o+VSPTPSq0WY8I4fxl6ao76mdAmOJNkOgqt4Gpj/eDUzkcJp2dbCI3aBoOAOQ1vSmXxlKoMWbqQuv2VjYrtp0eueigCp6o8agNeWxDdL0MAp2AMJf2IRF83+r2KtCu164av+H+xed7euxbl5tDd4oy4zYOqbcMjryS47LDB0dyWb9ZQQ7hA/h2L2VwEpaP0azisczmt8APC1t/jurn0qptqGkD9SpEbsNZ3bLclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBQt9L7+jy7A66XgcsESf5HprfgPVUIsrP5+9qw64m0=;
 b=nvFBWIXL7Un8vwSzfEUtXsZE6dzhM/3cTXlxsVwFX/Me8aGCgB/KdXmNo6yX3sJWI8ngtTR9NQAxZOtxGQEMmma08+HWxJDe1oPCbXoAjtQ6AcSixmG345NDrlaen6piNlSA5Ulq68Cp7G4RRSEvB0iW2CsIeaB2kxL3jMCobfnYLxwy6tGVdAdT/TIG8oSccsKmMjUndzzXygSDtkc80sxpEqRKfA0J5Ft+Oh/MFHHMVt+es5fxqqnZfYjx9oLiQaRtsep7GJWeXjtNbMOK6NIGDyGykAsVbuyY3JDmBL6NTjpLU6S3ph2qDCLtYIN1mcGIx72csSuY9vu9DOWDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBQt9L7+jy7A66XgcsESf5HprfgPVUIsrP5+9qw64m0=;
 b=ICQCE5KBmV/S7dYLL1KmDyLS1ceLWqheYm47WqyEE1Lp0QRkCe+bbxK0qXiaahFkqgkVHMuBM8DiXpsM7eAK5HwQKW9oUW73T/4GQpm8Zk1KuD/D6agjidufeyZk6kvKjANJYPtQZjUVjfdddGHOhPcq2Doi6CRYskL8LG5xwts=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:46:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:46:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling
 support
Thread-Topic: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling
 support
Thread-Index: AQHcbPN8lSU0Ky4WLkOUb3wbonwR6LUidXtQ
Date: Mon, 15 Dec 2025 09:46:38 +0000
Message-ID: 
 <TY3PR01MB11346420FA59E7495EFCB55AB86ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: 26d83c8d-b055-467c-e93a-08de3bbed80f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?SJ8NcHYn9teeZkIDbHncU8vbgF3XJB1ZR0ohp9EwsG2m8lc6xjAmNPhkycyN?=
 =?us-ascii?Q?xxGWaKcJwa4Ha5qM+5kgsFp1cV2t+q2x9R80yXQamOjaYxruPBYyZi6srjI0?=
 =?us-ascii?Q?uGdHNwyaEKKG0FYIQ39/Z2PrUMEtI+TBYgVbB503jdcsak/Wgis67gVkEBB5?=
 =?us-ascii?Q?TJqEUwtPmXFdhPcCrEXCTbZKSO4NulkWulTJc5pJbEoX7nExXQXJF+3r9GHD?=
 =?us-ascii?Q?EL7ckqz98bH3N3wXUWSN03ik9/Xz9v16QbibIzgkyomTKD0sfhspDbUZOjsr?=
 =?us-ascii?Q?RRlvcFaTdnbB/pNr4IrOYQ4HZoaG8sGahoqB/ss+IxLkqpOCQd8AZQDknWox?=
 =?us-ascii?Q?vh5e5tSQ6rQPBEZgqxrOQppK1dL3cpy+6AWlTlumbdEiGNXegMMht6163Lfa?=
 =?us-ascii?Q?wKLGJewRZsPd5t7MUfkcGXhYReM9+oRV3O/OWWHyZTTJmGZy4oRDXFWw/3RR?=
 =?us-ascii?Q?OVcPK+n5Hx75CmATflKeurwNwcUvdv/HXMf3sRmBv6aWwIfU8Wc8kOtXrQbh?=
 =?us-ascii?Q?StLcTGjMJLMlz7qzgC8Co7bMifCQi1R12IKBFO+D9AouttogcxSm1mXCLgJb?=
 =?us-ascii?Q?by+FX45PR/igsSkwzahC7us7MEpcSXztljCq5hV1rATBHNbKAbuL1d9Q/eEL?=
 =?us-ascii?Q?CtLBgq/i5A7yR9/EI0KSgBa7nYGDd3IxBGkWUOPADNXWvF/bdc65IMPiljJ5?=
 =?us-ascii?Q?l5ZzmXxw6x7L2WgId0ONKbv4xs7BPcUvB/K7r+ksaVX0Z0+q2PRJg+gO9maM?=
 =?us-ascii?Q?rUvG0r70dxkLz6ZHbHJ2msV1SlzSCFjnJPfJS8OMdtP73eP5soyn4WtPouVz?=
 =?us-ascii?Q?JVoCJYhn2pKX5aZQsf0IgH3qW8/UXlx6ReLQKWih7KlTOfgkpVyQxxgxnJDo?=
 =?us-ascii?Q?HB3I9n7MHgyFUlOmYJuPUpys0/qtEROrGkDU0/SCJalLEZU3Uiqe/MFXL7LE?=
 =?us-ascii?Q?8HpOqpyAsvCZbNzKm0uQ1LeAakp8FPmxoA/iqD6GJ87s1nWAXQ5xjjB5CiQl?=
 =?us-ascii?Q?otaZXNJoIbb4DeiZCcbHeOgDF4ST0UAew/9PJMfvIS+l8JQ36IavIU71Y1fR?=
 =?us-ascii?Q?VgHCmZ3sOnhW9qGB7FErVvcJZ12ErNOLTwI/HdcSfR7X9czyIJDxYofRADrs?=
 =?us-ascii?Q?FyPujAsmrhkjWKnKOwqZUridS7qADxHF/J1I/llIqD6NXfSMYGzIbJBCTDHP?=
 =?us-ascii?Q?6M3Tcc4+JBtavKZrHGlNSoVWl04HO25Q53Q4FlB4QN+4Gc34t4DFjRFPk6SB?=
 =?us-ascii?Q?cgY/UeO8UKZdCOGmDcB5bj9dJBhOES36AueEWiRAxZ9ytkp02roN9eKVeO98?=
 =?us-ascii?Q?6S7EuaVs7bFz05V2A1HvEcvGJDMIiyRaaneNsqKTx13+ReVP7/mQSk1Ew9mC?=
 =?us-ascii?Q?22VPzTxnguJNK69qdPHh/8OH+55KrT7/hgKAuw6WFvSuKDS/oWxIGU7P5Kcl?=
 =?us-ascii?Q?j/k+hOUREpKwceGBzoxXZ2FnKAz5gQYwQHixPGfg+1P8bJBunXSh/LVccOF9?=
 =?us-ascii?Q?6ullqtV9rALO2KGW0SY/DYTyK0IsmBnG1/aO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0YlHHs7abbfNEW+3WfHsLwwo3sxHCgrqOg4pXc0xI5y1CHQr2fc7pBe1WVKy?=
 =?us-ascii?Q?TTyCn6YbynbuuVb+WrGXW9aVwlQurfaiOOVFCP/atdimM1CmOnkDyDdpvULS?=
 =?us-ascii?Q?y+J44vF/6E39s0koyp6R/JFAZttg/xw44Ixbquq9j/OWCiWgeMDAQ4IpamC8?=
 =?us-ascii?Q?fyfAdxwFmHGcMxWDceEPFLhSFe7hMnCg3XRNXaT+dvP3Yplrco8tEDxcBZFy?=
 =?us-ascii?Q?lA9uNpmvPSyX0w/ozOV4lpkjd5Vl/kp+Fgc4QsoBSYLjJmf0gN/I/pdNM3fk?=
 =?us-ascii?Q?c3tlyRw+TKpN0Qoacr8CgEcAza28AcRKR/yhH7eWtHomyY/PMpGb+ygReYzb?=
 =?us-ascii?Q?B5+XH/Gn+8oH1sjUDnCxD7wa2sPdg0ojFhhuogAzBp4S4pLniRu3XaGFPC31?=
 =?us-ascii?Q?lBU+VJ5h4TOu3zjYi9lMe0dRWv+f3ng/dvADuXH/0cBeP2cjG1P49BLZNNJu?=
 =?us-ascii?Q?K3O9BYZ5SCk06/sv5NL2o4uh+Q73ucG20v3hSjgzGsXXtKE7LdmwTPaix50Z?=
 =?us-ascii?Q?Qs+K0ErMe4V/qeITLBWLh1OjZi2fPlTzQp4PG8Xi//XjGrOwMFagnyI9NUKl?=
 =?us-ascii?Q?W3nI43mq00g0IiLl3ZmlrjepsyOVbxMPKERUf4OaCyCGmRcreH43+xpEHmkv?=
 =?us-ascii?Q?DFihH7Io+/9/rSpnnXCcJWDVNMy/koHdRgXnKZrWimYdvF9r76LgaY2vHIxy?=
 =?us-ascii?Q?k1seCQbuMyx6HgjMXB15u89mSbG7EwANMCuLXvcSyM3HgXbOt4Nenys7H1TT?=
 =?us-ascii?Q?R3ljAHHt7M/XsGCyY+42PKb3jnGIwRBD+cDm/NuEMhqS3PprFYgHkT6pRmbJ?=
 =?us-ascii?Q?8TrOIN816O/+SFRuETglE0g4hWznQnquIpyFSfNInFIkyYkoIwm8jj0QaMqk?=
 =?us-ascii?Q?UrHzfpkFJeTPJJeN+dmCllR3KtgRQa0Gd6kg4fbBOzNqHbX/uN9KLM3DFzMV?=
 =?us-ascii?Q?fEkR4fg4EhkmCpduXVwM3xXBbs6IwtcrCmbG9PyHJ5+38lsEQvvP6s8yFtG8?=
 =?us-ascii?Q?RJUpGUiADKTUEbntWBQzHLUR/ByJm4OwvCan69joAB3otnlSIL/oMICgZmED?=
 =?us-ascii?Q?lS5uQRdqUCHQkqEHfpjpM1HnMhMDZUIvifaylZ7junkErGnTbzAOnUQegOed?=
 =?us-ascii?Q?q+n0uztETvYXw0hk0ErNFfWA+kG8uwPgVICGuUjKyRXhO/TDrOZ5d4reMb8d?=
 =?us-ascii?Q?CMoas9ihA3lvMsGfS8oRntQJ+Nu36blkKkRKdngzkki/r7kURcXdF5vNmSCm?=
 =?us-ascii?Q?YDHb1mavxa4WJ4z0recojC5IAN/GO+aKOsUebN/2cJjrNeHECx2RGtjGAxhL?=
 =?us-ascii?Q?9kiwW5XAHryXkxmvoxsGkUSOZ9f8dvN9aLa2RNTCUPdbpUgrjpL5Idb4rDQQ?=
 =?us-ascii?Q?+HsqCpk3sLC50q5AKZx8XZVTyyVcc49NdjY76onNQLP2jOH9IWtrX4v9MUq+?=
 =?us-ascii?Q?I/eB4NrRWsPkLTamo8TN2AG8lq77JLFHvEHn9mDy65YUJhvL4HRzhtIEkHKy?=
 =?us-ascii?Q?BHdjtEv86OpOlIuFTm/Hp07THxTbzOBkk0iNP0ArP6DtQubjJkuKH7DUYwjR?=
 =?us-ascii?Q?ttIKu9jXp8LTADlmB5td5PNckaV90zQNPGihByXMDn6LGiIZx6MvASKvpZJT?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d83c8d-b055-467c-e93a-08de3bbed80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:46:38.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smLkOyiXQGYte43Yh+rN1Ae7yJ5dTRB4m0bJimA1zLBwT8pBxPBNVPjdgYOcwjrjqdVwTOZIm6E+oLfbZmUpwMI9N4XPilTu3c+bjDYI9YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:46:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21045

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:16
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling sup=
port
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
>  include/linux/platform_data/tmio.h            |  3 ++
>  5 files changed, 54 insertions(+), 2 deletions(-)
>=20
> --
> 2.43.0


