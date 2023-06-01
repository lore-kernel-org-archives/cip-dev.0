Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694BAC7EE29
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 08:49:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.26454.1685609347813362759
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 01:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 3518n0Y8030488; Thu, 1 Jun 2023 17:49:01 +0900
X-Iguazu-Qid: 2wHH8MjPb87l5Q9dIJ
X-Iguazu-QSIG: v=2; s=0; t=1685609340; q=2wHH8MjPb87l5Q9dIJ; m=K/rrsuLA5TdMV3HQQ2EW7f1vdrsCSDaIcskK/DBb2qU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 3518mxH4033993
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 17:49:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P20PJxzXNQaQBBL36pcTlBrQK9j2qCDvVWAcjwlmJ+ZfimKVXBZvVrxslBuaLUdPP1BTQfig+l60ODQMeAczXqBcli8IlXUiIbHZR1Ozomo0sKFdCyVctDgKOXMTaurZqrZswffGVWZQDLg1HVS3s9K2QUrefhKcvbJdSGZX0cGpoQ0TBq/QSe7qMjZnc1xpfCzTCeOcNGjH7ZF3mGx3qdsvdmMmtHWWOm5V9b04bu73KBFLKBuZkp+CaZ1mIT726L/p121NmvJQGqsqRzde1NrxpfpWpumbdilkcU+nibguRDLR6d7Sz5L2yAH6lSO7pdtiSnN1Ri0MssWVLA9uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBOgd7a2AfOp9xKhlm6Hxve2EpufCuE+Ge+eSMgwm54=;
 b=Svftg7zKPTvMyehvwhNzz/4QDghNP4QhZulz4PK7DlTSdKJu438W1c/gRCRj41UgTiVLMdndFB2C4IXu/kGULiBbCBHVYEmv6GdBqqFN7UFZCBnQs6ibNdDL9LcN3lv07IwQzwAPMBpoS1npuppAa4Bv0IrM51wIh7Y/LNaO0oZI5Odu9bAjFY80HOMnKGryXqm9bi5ZxfGKAFKz/KjrpyMl/jP8WkolCsEcaJIy3w/MHOx5GPmnyiCaHWODtKCXeQkGJN+1hcFXYzEC+fY71du7NMHPT+BhoWLeXYYCObkOZ+zIgvFs3dTvNjPiM2kKOznGhwo2HNK3eeCmYLunJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <ch@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [cip-kernel-config][PATCH 2/2] 6.1.y-cip/x86: add
 Siemens IPC127e defconfig
Thread-Topic: [cip-dev] [cip-kernel-config][PATCH 2/2] 6.1.y-cip/x86: add
 Siemens IPC127e defconfig
Thread-Index: AQHZjhm5WSBwlxqQFE+pJ2NbejdiCK91r2RA
Date: Thu, 1 Jun 2023 08:48:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9418CD78978379F99143885E92499@TYCPR01MB9418.jpnprd01.prod.outlook.com>
References: <20230524082725.41558-1-ch@denx.de>
 <20230524082725.41558-3-ch@denx.de>
In-Reply-To: <20230524082725.41558-3-ch@denx.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|OS7PR01MB12082:EE_
x-ms-office365-filtering-correlation-id: ef8037a8-1608-42f8-c6b6-08db627d098f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8TA+1zu9hfN6Bql1QGUzAbmaVXI/cEVhXHRI/rYWpAQVg8E6YYCi+Tw1qBwgTEeX+qiSB2qR/xgkcApoKP3Xfw9lKdl5zav+yJLeYhvajAyOGQ2Rvckm7Gcr06NXUASW3HUAwJZQfoJBd4z+Ws0hsGGR/zdko4ekKGPgczXMn9DCFN536VTIGPiVBNK41gE9H+pniYghK/ntkaK+xpJEEOseQxOqDC6hs2C9+LfJSe77ov7UqtdGbI9xgxgn63ncsygz9azKssNKCaXXTbz4Gl+uou1Ctx95DB5fb5OaPfjlrAvf2LCBzRs4+CuImZi60SGjKgUvokpq83o5Rq3SlVuZqyX73Xj8Y9ofGGyMsw/GzNeHX+yG2NxlREssIvAgVHBmYoNRiNQCBKMh/Jpw62nAZoOZKrQJKwtvn7lGkS8HFtO7XnzAktqPW/brUowybSJEwIR01aqcevuiWJcBeETTNWPtQvtEUCbxsXl5X7G3wknPi3lNQV4sIpHAbO9wny0LwiH5J8IuEfbhRy2FCYEr6vLo2ZARiBGn0LB7T1Nkq3coAJRrs2jY1dWc7TGu4t2asrrRW9liX/J2sCJk0zs3QyvOPC6Tt+BnUJ2kri8PGiQ3MUIwCDEkNgE6lJT+ZTWeRjus8kpszW9OHM1GUQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(53546011)(52536014)(6506007)(9686003)(26005)(6916009)(66946007)(76116006)(64756008)(66446008)(66556008)(66476007)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(33656002)(83380400001)(86362001)(41300700001)(55016003)(316002)(7696005)(71200400001)(186003)(2906002)(4744005)(478600001)(38070700005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUw1UjV4SkJTbWxnY0hsZ0ZkVG44alBBZFBIZ0wvcjJUN1d1UWhIcHpF?=
 =?iso-2022-jp?B?VWtZd29ZMHkxa0xtQTZ5VUVBK1VsSW1HK3haSXlBWENhNG1kc3k4RFBK?=
 =?iso-2022-jp?B?NS81dXVKa1IwTXFSRmtad1pmRklFTTJUdWdaZi9OUXlCNnE1RUcwSCtr?=
 =?iso-2022-jp?B?c3VGNmh6dTNLc3A3TGlqdys4aDRPQ0hSTDE3RitpK0Y5UVRzODdqdVlP?=
 =?iso-2022-jp?B?OGFBQWFMMVZHK0NCR1NwRjdPQk5ZbkFrN29pa1MyNGRaSFFZUWFvOEt4?=
 =?iso-2022-jp?B?Y1N5NlFSRDcvNTlVK0tsakxoQXdibkZOR3k4ZC9sSUtLdEJNYytqN294?=
 =?iso-2022-jp?B?enlVNmhlMitxQW9VR0YyM1VLejVpcXlZbTIzREpMZmRLc0NLTmt1YUwx?=
 =?iso-2022-jp?B?MnFkRVBSS29wK1g1OHdWQnIrL2N2VzJWN3AyZ3k3bWxpV2VxTUFacnRX?=
 =?iso-2022-jp?B?WUNpL2pZVE54US9wbXFJWmJCdnl2WU1vMjZyQXd2UlhnUlF4a2RQQmU0?=
 =?iso-2022-jp?B?NjVDT0dlSmZhbzlpeFlDNnkrYk51elVNNUxEQTBFdmp6bDl2Zk5zeTIz?=
 =?iso-2022-jp?B?SVhjZkw3ZVo4SlRuVDNONmxyMHIrVUczZHA5cWQ5aDdSNU55aUJDWUZa?=
 =?iso-2022-jp?B?M25UdmhmRmVaV1Q0bHJGTTN0NGVHSk4zdzFCWFNROSt5WlE4eDRYWEFh?=
 =?iso-2022-jp?B?cEdENkZvbkkvYnJqaVVEN3pMbXJESEc0YjlkcHFUK011K0hCNjl6L3ht?=
 =?iso-2022-jp?B?cXBJRG5ZcFJZMUwwQmFMYnM3dHZ1dDlZQitrREFNU0FGM2t0Unc0N3pp?=
 =?iso-2022-jp?B?YjBxcWVJQVdhd0dRNUtqMG00M3o1Sk94MzB3ZUVWY3ZaMkdCS1N6Unhk?=
 =?iso-2022-jp?B?L1M2UmRsM2svK3hSd0YvTVQyUFdnVlRvNTZQV0xMUFZKZko1VVJHanhS?=
 =?iso-2022-jp?B?NStETTVTOHpWNmpNYnBzTE02WjdneWxHeTczNVZvNzkxS2pJYnhsUyt4?=
 =?iso-2022-jp?B?eXo5R1B3b0luc2lTdVczODExMWtWNFl2eENjRWxvN3BCZ0xoM0IzMHYz?=
 =?iso-2022-jp?B?S1N2VC9OVG0xc05yL0YzbDg1UTluZlVqYmd1YmI5OGI0alhvTkFleFJD?=
 =?iso-2022-jp?B?ajVOckUyb0RqK1UzWXo1RjM2ajlCaVZBc3h4MjZLd2w3ZU1wU3dJQWpv?=
 =?iso-2022-jp?B?WDk4enRHcmJoQS92TUZPbzlHR2J0OGtOSnFUTGM4YU1XejRPK0NFNDFY?=
 =?iso-2022-jp?B?UjAxZkFCZnA4K0lwakp3ZkRWcHJseUFXNnUxN2NRb0ZFZ0U0UkoyMjUx?=
 =?iso-2022-jp?B?Ty8vNFRQR2U1N05zcW5NN0R1a0RveUd5TW1yRm5MZ25Jamx6VWQyTHpz?=
 =?iso-2022-jp?B?dWRSOUxwNW5KeTVGQ0dDaDlyR0RXUVBnSTZhbnRmQ1hOejJ0UkpZRzFN?=
 =?iso-2022-jp?B?elVxbWNOVC9ndml0NG1GTUZ3ZE9XSWg4cDNoblBjeDZmbmpiL1BLbTBm?=
 =?iso-2022-jp?B?YTZxZUx2Z2NSdFRBQXpwbS9od2lIV0pOQ2wwVkd3KzVDUTJiVDQvTUVG?=
 =?iso-2022-jp?B?K1FuSFR4SEp2c2ZEbG9mcDYzSzBZa2Y4Mkw2TWpqTEVBRGhhcGE1RlRu?=
 =?iso-2022-jp?B?eGFIdFlVN251Y2szc0tVVUdoeXRJYUF2d0JGb2hjclV3V2p0UkRvSktX?=
 =?iso-2022-jp?B?b0pNOTE2UmZRQXZOZFlCUTBFVEhUS2dCS1pHbm9yQTVOQ3hsUGxLSktT?=
 =?iso-2022-jp?B?Z1g3amVMdEorNzlkblhtOFlWRkxjUll4aTh5TUNid3JiSkt3bGtoVWNk?=
 =?iso-2022-jp?B?RmhzaHF1dTQ3UEFUUEVUYWZ4UldSbFkzQUxPME1hdjNzQ0YxSTB2Qkt2?=
 =?iso-2022-jp?B?eTcxVVBuZVkraDBQRU1YZjRaMTh3ekNvaXJscGlJMm9BZVJmU3NOMU5S?=
 =?iso-2022-jp?B?UTdRMHhnUWhLTE85elZoRzJ1TzJTRkZQSTJ5QXZMaDUrZEhEUktvWlpu?=
 =?iso-2022-jp?B?ZXV3YWQzU1NLY2xzZFRhZG8wWjRLaVR0T2tHWmF4cWtTM0pmdUgvR1d3?=
 =?iso-2022-jp?B?QVpZMGtlVllaZWFFUU9qNlhEMjdVWms2MlhFdVQwK04zcUE5ejhvOVEw?=
 =?iso-2022-jp?B?TjdHQ3BKaUhRd2p1K3BqOThoejdBL2xlc25acTBvdVkzMmp6OUtJUjNj?=
 =?iso-2022-jp?B?UWtRZFJtOGNRbG9OZ0Q1OVpycmZ6RkZVYVlrNG5tbWpJbzNFR3pQZS9Q?=
 =?iso-2022-jp?B?dHZrZ0YzV1VIbENGaktnVUNQNE1NQ2UrUytIU1hSbFF4Y0MwOHh2cE1O?=
 =?iso-2022-jp?B?Snhic2g3MFlMQXJWTURqU1F4Ui9tYTEzNWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	31CfR2nv3hBeAueKrHgL4UdEps8scrt5ZpBamPV3r4vJb4x3fBbT7hYyHyAUr0bOSZOHvS9lKJfYInaP4LAzt4ck0QK6NcB/7aS9/bXVI3kgZz4Ob3QG19O3IOxVhoEfiIUZj67lZceym+ddjJxo1adZWOgOqXwFz52gznkcYNXSbNDMdWLVykPleStWUUmJs2Ta/ePaeDKnvyBcnSDWGYgRSUqVxfGmtKkeuoM+X75asAUUkUA8Sze5IsMu2/xCHJR8+gpD9M8YmOWQv/7qOIl0ORnVvS9SxM33p0X4A7mt6fXwYuV1X5Tz9L2qDrxE5S1X+8XDMi33wJlqLpnO57QIYDmbl+3fGij1T/3gcA1OYw4R7rGIq793CdMgWqrKNpwwzvNUErO75cfFrH5c46+Y6nQcLfY841kbub/bjO8kP47+WBEsSd4U65WXB5ZofExrc0Gv9QS8usT88EYrMS2bq2XrZ1Bz/zeg7iRCBvEMv6U4QcCX1Sr+iDWGh5I3ljvNztfXAuk600uUxdCy7fT8zf2b0qWfVVv6mrKhUqfjEc1S+LrI8tNc1QCgQiFboCzojwog0ukKBWty3Q5TX/D+JF+mjCR9ZAVDVE12vIIidr0R0TRaADvg50KIRgAGe1hcfMbQJiSFXnnBHp9Wr4I2AyKCjrE7yrc6tplHIhnYcd+G8MBnpvWEXKhRkve5ME3kxeQFFyTOklAHttc1Zhzqo46d/YVMIOOxgcdNpM9hI8M/Lbx+rwOv85v1qet3TpujpzDwM8ZbFKMyRn9xKYYFaC7U9H6YY8f3WVUReCP10iUKYOrILTcOtQLkmiKOl4Olr6EjqBCDzoeyEhMWwQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8037a8-1608-42f8-c6b6-08db627d098f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 08:48:57.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srW9ubg6RclX8myIwNc97IcX2hrLmBSSMSFJWMT4JeOw1kMEtCNyjcdBDw2Bq5hMIxsR2QP9DoToQPvqUXw2HC14jHQ0s+VQfGBzojIrXyL3PefHUn6ugu6ikMQdVl00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 08:49:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11722

Hi Claudius,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Claudius Heine
> Sent: Wednesday, May 24, 2023 5:27 PM
> To: cip-dev@lists.cip-project.org
> Cc: Claudius Heine <ch@denx.de>
> Subject: [cip-dev] [cip-kernel-config][PATCH 2/2] 6.1.y-cip/x86: add Siem=
ens
> IPC127e defconfig
>=20
> This is a copy of the IPC227e defconfig, just `CONFIG_WDAT_WDT=3Dm` added
> for watchdog support on that platform.
>=20
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  6.1.y-cip/x86/siemens_ipc127e.sources   | 10961
> ++++++++++++++++++++++
>  6.1.y-cip/x86/siemens_ipc127e_defconfig |   425 +
>  2 files changed, 11386 insertions(+)
>  create mode 100644 6.1.y-cip/x86/siemens_ipc127e.sources
>  create mode 100644 6.1.y-cip/x86/siemens_ipc127e_defconfig
>=20

Applied, thanks.

Best regards,
  Nobuhiro



