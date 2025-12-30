Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF1EE0205
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 14:46:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65388.1767105989852129435
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Dec 2025 06:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=WnRRObws;
 spf=pass (domain: renesas.com, ip: 52.101.125.61, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBJFeZpkyqpa1HZy3buEWSEVkLc4esBguNyP/waJ887fZX8A6Di2G/tkgeetNnkvmiBpVS5dXk1wXhBlLmJlTmv9KgzNRzr/a1vGZ7HaXySwWRPckiGNIDj4Kra+aa7v41xhPWp5b5G4nnml49jx1cmbCrTeJOsK95nTR0gwdj2C6oVLKUG/qed1qqpkQlnRMxoOrHce7KqNJqCj9vnvbtPMj9Oza9JListc4z7f2S80FNmptSk3t6QGRAv/jCxpamZevqbmLuyOhOFikAeAZw3QbUpEELe16fTteNcdTpDchHHoydkzvhlepsdZJ1Xfwbs+wjvYq+7+eQzbVG7LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI8uIjIFsxfMAH85cYjXzpZO+jjfesAiqkek9ofvq6U=;
 b=TWzIsQi6nhjRaUQIcXbGBSz48RXbebGFUXP6RLfyrAx5RiqYhuQcwh8f3CRzCtAtrCuDkD3aL40HuiRYYyZSFYc8onvmUZ1Ha0j/RCldjDlCtZky0e4Rzs93LUjrnxr7Mh7sB7PkSGuF+PEtcHktbg2cfsyxh2NMr23tCWVroCbl4/N7nJ8FWQ+v0SaRAKPpebgpMxmzE3V6lWPdTHc5Dr3NAwbN23Ys/KHorPFr6kIIX1Pg80fW2u1JVnSfazLKrywH8bhLeusP69F1nxiPYVlEOBe6/dz1nkyJZ9V+3PWpdDu916l0/e0X242FMN2NnwPkRIr/aqogE4ioYBRNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI8uIjIFsxfMAH85cYjXzpZO+jjfesAiqkek9ofvq6U=;
 b=WnRRObws57XO+X5kfOIoqqqdt9suOjB2GSt+FtaLMJ1ol9Q/Og3wJ9/gULGJvNAOfum66AIObyDWENex859zUlrh7f+V6v4JwPhPSMcpFpQkhtybUknA5G0SdfeVyyqOJzNLWQb7FqZDsfDdQWzS30RaEua0jHPZ/BF/CVhCXGU=
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com (2603:1096:400:1a1::12)
 by OS3PR01MB9769.jpnprd01.prod.outlook.com (2603:1096:604:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 14:46:25 +0000
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596]) by TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596%7]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 14:46:21 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Claudiu.Beznea <claudiu.beznea@tuxon.dev>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip v2 00/19] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip v2 00/19] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Thread-Index: AQHcZUsLP/5iuTXTFEOmd1J9jCUn8bU6ZZ7Q
Date: Tue, 30 Dec 2025 14:46:21 +0000
Message-ID: 
 <TYWPR01MB927762E6BA11B9EAD24A91F7D3BCA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9277:EE_|OS3PR01MB9769:EE_
x-ms-office365-filtering-correlation-id: b247832f-c830-404e-9eea-08de47b232e4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Hj2tZbwnnkY7Po2yMhG5hxVG3v2AkE1vArrj+Do+IE/oqfzfHEzTB3ke5bj7?=
 =?us-ascii?Q?OP5ysbq4Bh7wTCvIeBmsYFnItXRzLSKX7/tqLN9AO67eSdQw+uOyS73Ih1pa?=
 =?us-ascii?Q?IPYAaFVQK1LPBY4IY705/R80ii4BuhyBKY5W63gqM86gphhZ0JYM6FtZOALF?=
 =?us-ascii?Q?n7zT6elVPuGGBIFdlSpVp7z8cJd3+aQv6YT2djKrxh+woGcwCGfQEV2Hzrq6?=
 =?us-ascii?Q?xxjAOBK6vt0Mf0Txk24//lEpDYMXm2/BRQHUSlRaby/9pNz7uRfIfvED/gri?=
 =?us-ascii?Q?B88Fgy21QTqUXJyyd3y3kOeF2MxCw+gMHZcwz5ovvc7NQW6rCO4qoclRLm3y?=
 =?us-ascii?Q?5ZsYTj+iBYpZmExZcKzyyj0+gSCkz8PkVeJ8RN89JJ4I68kyLeAQepxUl9W2?=
 =?us-ascii?Q?eJ2JF9MJDHS1MzJudoQexoOEUGuv1lY8oM+Q0YvRMigOma58FJr+sCcjC1E0?=
 =?us-ascii?Q?6SHW2V4+TV1OrICU6ozyhkx+rg4t9rpN1OyRBUxoMvaztFNkCnjakrJHh9Om?=
 =?us-ascii?Q?B73GJum9/z5ybyrLHrVolyztJTZM0lOCAMHtemVTlaAOHEbU3eperx53gU/j?=
 =?us-ascii?Q?ev7YOKxQIkStE2Yj6QDRmd/ktF5SoR0fLWtdfZurdDNDqiDDdLydP52STloJ?=
 =?us-ascii?Q?v3Iu819Gd3tGubSGMBMEk54k2qhdsn+mwOz6Tdp5lceuV3ox9otM5+YPhmS3?=
 =?us-ascii?Q?PP7KBAHTYVsM+I8oQdjudCc0iX22OPz5RpByxUohN7lIwCEnypweDNxxbskh?=
 =?us-ascii?Q?HlETUi2eOIxe2fbql0Kt5AAqy9lTxDpC6pWUYUCAInTetw6vHE0V/JBHgB+y?=
 =?us-ascii?Q?zjZlPruZMjX9Qxh6s/4/A5Vba+zXFNWV1Eq4K21EWwGv4fKiMQgta4oKisvg?=
 =?us-ascii?Q?zn8kWHUEtigeo/N+fXuhtrgJsP8s2jFbvsQDADpEMw8HrA9Q3CXT94+ZpYyy?=
 =?us-ascii?Q?c974X5Bo03lHvpzHTEMX3B8BqkFKuyz8YznXRbTYr7PpZ41Xp3ui/oQ5/xPQ?=
 =?us-ascii?Q?PMNbafm0bbjSSf4v48jOxXCN5djsYjWYPOp/LqaKJU32HeVlFJTJzEQaNxri?=
 =?us-ascii?Q?K2Cj6sEgpOj2aha92w+Tnw/86HqWEwqdT9rxuSUtGvdIfknvFOfElJjs+FVw?=
 =?us-ascii?Q?cVFtjfnX5UYC+7IV78Bgee0IuPw+0yF+uzj36NlH2c7J4KpdkWEcHVD2PrYD?=
 =?us-ascii?Q?nIp6hoSeLCkhCDQQlz0ATFxVQOGRRq82UkfFoLneNw0EW79J5xgKQi7ZWHVp?=
 =?us-ascii?Q?WFOS+K+SNH7zWhTby4uH5rkQsZwF394j6fAvswzOt1qACRaj4Xoklt9LEoVP?=
 =?us-ascii?Q?0cykBsqhAXm7f0cTz72QQDMaUr1dFAd8hVffZWCo+Br/ww3XJo7rKDnEXfUg?=
 =?us-ascii?Q?eMnsC6+o/q6zKHCLXZVjOsQJ2EV59pVXIGvA4yoQdohNFpa+VehCPqsX1GEi?=
 =?us-ascii?Q?MYOgFYmfKYiQvx0m7WaT5d/O4x0iN5cQJtNszvkaIlVF3X3wlzNNa0dZLvVU?=
 =?us-ascii?Q?VDqfsk9PuQTvoqid0BEGR9bGkjI4YY7+5SHQ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9277.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JqEVBIIdHMz8qsKP7P/MQ2znAyhzTwelBahpHhJ0Q00PQHkdf7FKoEOv6q/b?=
 =?us-ascii?Q?9jrB8WgmY3dKqySJWa8Ds2zXV/elZQvB7WDGzwRAG9R8BPf7Suo4deEKPDrf?=
 =?us-ascii?Q?xGzSlkLgRD2/gB6hzSpC/1IZFfhh/rXPu+aPiXElxGbzNRdHaLtH2GW45x0e?=
 =?us-ascii?Q?KRacKECv5b1zLuU3ndllSDmUOLVAmKS+ulCIYFCrxyPVoQTMWhGRXdZ+RabC?=
 =?us-ascii?Q?INzUbI71bkoeDnw/eJEsecQWjQsE0woZ+dbQAPqMcudXg+KkVDaFryi244Yd?=
 =?us-ascii?Q?QJXS6SRSbb9Dm5IeJ2+i7nP0w+VQGrUfkl3G18FSF1Z9Tj/JivWXa0B4jVv3?=
 =?us-ascii?Q?MXITr8tQ6s5EfpoZi44Mi70AwsJqeREiwpD4x1LdddQJzofImjbcwwq23nhA?=
 =?us-ascii?Q?8m+6dx6vX0SxRg0KiGHS4DPIFyXJjP3aJ1JRHpjdFQcqVypekWHLquDOa4/n?=
 =?us-ascii?Q?cFqBRms+UhH9eV09UtuSvx6Fq7NXkhPrNywIIHY4rMSUTRWX10q6gTC6xLDa?=
 =?us-ascii?Q?lcD+Q/f1Q8pZqP1ByNyLTr2qUpa2osko1udgi2fF5U3PgZBsqUckdWNAs2sn?=
 =?us-ascii?Q?lVdnJcH02FEQmw/vM9ueKZEPbe510CBpD2tpDLfJCBL6Y1Yn5tdHI9lzV5Oy?=
 =?us-ascii?Q?cTT9Rc94PJ+/8C4pRUmrk3aOeUdWzZpPD5fUWHTs3/xCQv1VLvchAcnYH/YS?=
 =?us-ascii?Q?S7ClEgUkKxew94YOAjOPRfxYyNQNhEEWdcu6RZOio88AV53bL2Q3cRQVBGBZ?=
 =?us-ascii?Q?PGic7eTasujVPTj2Z5+yih52ET4Kj+95vcKx6pIDMcFGH3EEYEhchq5LahJP?=
 =?us-ascii?Q?k6kB7sVqqmu3Ih2UCOI9D2TCF32B49iY0XsoXn7D7zmpriUVl9HV/WoT0Xnc?=
 =?us-ascii?Q?AKqjEvG8xQ04Ptop/sqrtws1X7yTF7DIfZxVjJKIJ/rKl0Ytves6wgFN5Kg5?=
 =?us-ascii?Q?MBmbBvxA1EDutUx8i86dIyWBXDx9wFCbYAFHDv3FL5o19eGzP7DpRdokQpEz?=
 =?us-ascii?Q?+AdlYTDGGErI7fugfdLtGwQpehQWE+zhIGvJtpBn9ZKdlUfbDCQFoNljAJyD?=
 =?us-ascii?Q?W5cBqpEv1YsA3QgwNSpNsD8PyKwLxYa1ujIns1WqqXx3+sDBIr5bc10EmuyJ?=
 =?us-ascii?Q?OpBJQDQd/D+ygy2vRShL82F9H6TTTokardHerRyiEEBbEI7fGKAUlVTuZuWT?=
 =?us-ascii?Q?dpldKe0bsB21fkFdGBi8Mj1AZsMGMmTlIujl1zLIRYPi40/Rk59mvrEWPnlv?=
 =?us-ascii?Q?k2uxW9zTxrWqQatl58Gq6h3Mb2FISL5DLESVMEiqXd7mLK9OhrQkHoh6C3Qv?=
 =?us-ascii?Q?/Qh8fWTQPagS9q2eHFXriPBQKGw54LGVD7CC9vc/wFyFN+664A48l7nMIwi1?=
 =?us-ascii?Q?FAs/IXupcqux+ihpgIsZBges0UZTgDKTmJUCJLfyTAtvcDrmvl5wYx37l3Sx?=
 =?us-ascii?Q?dpdrxUVj6+Tq3lcmhfYcG6u140jLyb/glp1gO32OBZGBRqYPRhLPObjmExuX?=
 =?us-ascii?Q?yaY0ONW8WnsFsGjOoVhRDjKkxvjHRnbZRQoT+HLeqrMIYZJUQflp/guZkiKA?=
 =?us-ascii?Q?vpcY+hAZaAy+xvbQIasyCV/5PIB1EnLvj+G8w/cbGTDRMUx7MFkMQKb0RoB1?=
 =?us-ascii?Q?ZIOUem0DowZSsW2jWqjA3eQ7NmDwO7q8DynAvv4X3VSP1ct+qLMlm0346f2Z?=
 =?us-ascii?Q?XowGf/ZbZYuZYbyOkQxUSX8Xw6va42LDwvJGrzMft49643+EoIruLqBEDlOe?=
 =?us-ascii?Q?J+iR9XGSSOFCX29vyGREOl08AYnXTPU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9277.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b247832f-c830-404e-9eea-08de47b232e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 14:46:21.6253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REITpy/GtagTYzHjAkb+tR5/qqv5S2l42hLpND7oRcmH96/rmjpYXEmI9UEsDdKuFS4aIt85QzyZrH29E7YMpntGgymU/R8/pHn+v0+/8yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Dec 2025 14:46:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21276

Hi Pavel, Nobuhiro,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of claudiu beznea via lists.cip-project.org
> Sent: Thursday, December 4, 2025 8:16 PM
> To: nobuhiro1.iwamatsu@toshiba.co.jp; pavel@denx.de
> Cc: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; cip-dev@lists.cip-
> project.org
> Subject: [cip-dev] [PATCH 6.12.y-cip v2 00/19] RZ/{G2L, G2LC, G2UL, G3S,
> Five, V2L}: Backport MSTOP support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the
> MSTOP bit set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes
> to PM domain specific code were needed. The changes backported in
> this series were adjusted to be executed only for the above
> mentioned Renesas SoCs.
>=20
> Please share your thoughts on this approach.
>=20

Could you please let me know what is the status of this series?

I was backporting thermal driver support for the Renesas RZ/V2H SoC
and I hit pm-related asynchronous aborts during unbind, which are fixed
by this series (fixed by commit 4/19 ("driver core: platform: Drop
dev_pm_domain_detach() call").

Thanks!
Ovidiu



> Thank you,
> Claudiu
>=20
> Changes in v2:
> - dropped patches:
> -- rpmsg: core: Drop dev_pm_domain_detach() call
> -- soundwire: bus: Drop dev_pm_domain_detach() call
> -- serdev: Drop dev_pm_domain_detach() call
> -- clk: renesas: r9a07g04[34]: Use tabs instead of spaces
>=20
> Claudiu Beznea (19):
>   PM: domains: Add flags to specify power on attach/detach
>   PM: domains: Add helper to check for PM domain detach on unbind
>     cleanup
>   PM: domains: Detach on device_unbind_cleanup()
>   driver core: platform: Drop dev_pm_domain_detach() call
>   mmc: sdio: Drop dev_pm_domain_detach() call
>   spi: Drop dev_pm_domain_detach() call
>   driver core: auxiliary bus: Drop dev_pm_domain_detach() call
>   i2c: core: Drop dev_pm_domain_detach() call
>   clk: renesas: rzg2l: Move pointers after hw member
>   clk: renesas: rzg2l: Add macro to loop through module clocks
>   clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable API
>   clk: renesas: r9a08g045: Drop power domain instantiation
>   clk: renesas: rzg2l: Drop MSTOP based power domain support
>   dt-bindings: clock: rzg2l: Drop power domain IDs
>   Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update
>     #power-domain-cells =3D <1> for RZ/G3S"
>   clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
>   clk: renesas: r9a08g045: Add MSTOP for GPIO
>   clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
>   clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
>=20
>  .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
>  drivers/amba/bus.c                            |   4 +-
>  drivers/base/auxiliary.c                      |   8 +-
>  drivers/base/dd.c                             |   3 +
>  drivers/base/platform.c                       |   8 +-
>  drivers/base/power/common.c                   |  29 +-
>  drivers/clk/qcom/apcs-sdx55.c                 |   2 +-
>  drivers/clk/renesas/r9a07g043-cpg.c           | 132 ++---
>  drivers/clk/renesas/r9a07g044-cpg.c           | 168 +++----
>  drivers/clk/renesas/r9a08g045-cpg.c           | 246 ++++-----
>  drivers/clk/renesas/r9a09g011-cpg.c           | 116 ++---
>  drivers/clk/renesas/rzg2l-cpg.c               | 476 ++++++++++--------
>  drivers/clk/renesas/rzg2l-cpg.h               |  71 +--
>  drivers/gpu/drm/display/drm_dp_aux_bus.c      |   2 +-
>  drivers/i2c/i2c-core-base.c                   |   9 +-
>  drivers/mmc/core/sdio_bus.c                   |   8 +-
>  drivers/rpmsg/rpmsg_core.c                    |   2 +-
>  drivers/soundwire/bus_type.c                  |   2 +-
>  drivers/spi/spi.c                             |   8 +-
>  drivers/tty/serdev/core.c                     |   2 +-
>  include/dt-bindings/clock/r9a07g043-cpg.h     |  53 --
>  include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ---
>  include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ---
>  include/dt-bindings/clock/r9a08g045-cpg.h     |  70 ---
>  include/linux/pm.h                            |   1 +
>  include/linux/pm_domain.h                     |  15 +-
>  26 files changed, 671 insertions(+), 898 deletions(-)
>=20
> --
> 2.43.0


