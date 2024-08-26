Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F7C5321D
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 12:54:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.83])
 by mx.groups.io with SMTP id smtpd.web10.51906.1724675899811403481
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Aug 2024 05:38:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W25+tZ1W;
 spf=pass (domain: siemens.com, ip: 40.107.21.83, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnWYq8GOn/BzpQ0f6UR7co2M3ygIwdZ9B0q1cGCDTWF+Wp9ZTfa2H/5BF0KcyBsvXNIAhDFN8MT0KD66mjx4NR2Ipj32/YkEFTaCO7QdTTwwGQ3sPCHOvbZTECZ4EkwqqIoH3ZWTu+enVIIPVgdCHNNpR+Ue4UDSknxkJyvKhWzn+rxuwQOGG1BEFqjqZWm6DwPYZdFEYtuTmJcX+ROrLcbFBAnWOQQstn4Jz7M2OOmL/Rki+qcZIGSSYCpTq7WQyuJZ0E7GgNdy+aVotkBfoIFl16Al824OIIqFUps5VHqx3EXpi/ExFI5SHBaY//72Ebxvh0PXI3FG6qY52vMs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFkgaDm1Y/xKcOJmNcoXNv5b0ZBmkUFxLi+PAfIdjc8=;
 b=N7R2VM5RM+R2e9n/szxySWzYCAQ8d8YEOzl/qlkNHz/XGvNCSrCJ3nE5GKZCJaDbNWB8UYdx5hqBWGs2txJ4UE6UxyTXzn7QLNcuh2cmBfze3Ju9GEhqLlAsLAZkuFOfCyI7Per9XNhfjUmUZJ0m6t8xV/fibz/8nuftVIWgBcVyzPnmOaZC/7zHjjh6SKjEQJzjPRXxnpK6MPjA918n0MUjODBGWjIMRRGHrlATak+ywps+f/TVCnry2UTk5uXv7aK09Nu2E7xQ6YVU+v3+ZEITmMsGuVzG6MQRbQyKsNbL+6mrpfA9qE1lFZ40bgqmJiwkwykc61XxAbomeYigQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFkgaDm1Y/xKcOJmNcoXNv5b0ZBmkUFxLi+PAfIdjc8=;
 b=W25+tZ1WaZNtePfuppImiTmpUqMmhtgHWHaJIvyBnw71IuQ1NxErefYv87ry3e22Zu/1BbcKFGizLI5MNVOWZb61sl0CNIvjZ7vNC5Fc/jb9yrII4EEDQ0MJU0iiyBdVTArylMTApxoRR4HUbX0HcQk4LrzLjkYF4Cq2yW1sM9WtLBHKnuWtv1SqelfiUTzQSz5amkheDMKl2LTgOBWzFahv64CQA9GOItyByKPbJN69ufOz/8F/0nzoi+CZn8PkqqKsBs17GDU5B0ZRic7l5J3o9Bxpw+7YzqEa7XLya5IW+G2v8tJIH98nZmZFfnbneJP3Lxmpm9NlAjcMuhmpuQ==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AS4PR10MB7614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:38:16 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 12:38:16 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] Fixing dependency of package expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building with disk encryption enabled.
Thread-Topic: [isar-cip-core][PATCH] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled.
Thread-Index: AQHa9XhkqUioTrhStEWehPx7jPwvT7I5duyAgAAHWNA=
Date: Mon, 26 Aug 2024 12:38:16 +0000
Message-ID: 
 <AM7PR10MB332074787FC29E44AC3F6AF3868B2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
 <70399ffd-bf1f-4a28-b8d6-b7a7981c7726@siemens.com>
In-Reply-To: <70399ffd-bf1f-4a28-b8d6-b7a7981c7726@siemens.com>
Accept-Language: de-AT, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=a0354d79-1744-4e24-b18a-38ceb9b3d61e;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-08-26T12:36:42Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AS4PR10MB7614:EE_
x-ms-office365-filtering-correlation-id: f437a89d-dc4c-49e9-9fa6-08dcc5cbf523
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NCcbnbGinY5m4PsQ2lS2ARGTyyXb0tCHTtK3WNi4Ar0BhiO7LrOFTdXkQVX3?=
 =?us-ascii?Q?30EraQMvO3AUKYQULT/D5ZbZbKCW93MAmRL8RQypOSBMFM50Qv+kLQzGn8zm?=
 =?us-ascii?Q?JCAbSIv2UxKIRhJwYeCNtokh9RJnq3kKuYkIowQv4QhQUtJdO6uzpbusJ8Lz?=
 =?us-ascii?Q?5xFk/eDlTu68hmv+8S2FJtqwsS5ZWe+UEAlHcKkOjCpYHj1aiDbZ0No4kPxe?=
 =?us-ascii?Q?wnVB8bEfu7yllN3ODk4jX2OGPVR/Ark2g9YDLA2c1AeSzzm25N2OW2Wb4+PL?=
 =?us-ascii?Q?cLLJug0ItHBNaoB16RT75TlK2KDekpUKS8zem/J4MlTynPStK2vJIoi0mRtw?=
 =?us-ascii?Q?Zu1+iHgr/HydxzrmFucWgdt7woTrVxJYmn/MkPTT0dJx5w1DwMjN81qb5yyG?=
 =?us-ascii?Q?UHcEU8ng9E60vZ065Oqu3WWhrkwPzgV8Elr0GicgxpNaqcZjfdnfz9ZTd4n2?=
 =?us-ascii?Q?6z50LqYRWm0BxjvyVy3YEuC6cUDXZthH7XzAH6UCtn8mHH/ZNJk+3Lm4hrJ6?=
 =?us-ascii?Q?kVP5d6e9YisDT7SHDUOzMcI9pAFEF1nZxxgFdhGgB32qqjfR55VHDSTz13oJ?=
 =?us-ascii?Q?k/9J0y9M2HM56IzB5GfF0dwdO+Fm4QzImjbdhE8BmkBe3GkPZxLaLjbWoiRU?=
 =?us-ascii?Q?VhhcTezCrNB6oK5FtzIopauXLECk55SsFS+IdtN5ixwd9bE+mCglGxSw3DD7?=
 =?us-ascii?Q?6iIzyDB9Qu4rEbOxubecWMMaV9EQ7cDO6tzPE/LlTfe3aO4grjhR8xOBrRPx?=
 =?us-ascii?Q?GBKeNKo8jSP1r6lH4RByeA15+gzGhcnp5cbBpzJ+t4vUJ8VrVvY4gMsYV/Nq?=
 =?us-ascii?Q?Ae45MrS5vZ968+4NOAUkwfJOYYXSFaoIoBl60YfoMF5iGEP5pX1O2Ezb9WOj?=
 =?us-ascii?Q?SvcSnGr8lQT8ZF/yPZTbzDvAKNwIhExYdRZDJHlCcO0EbFhMGBAdcI4dbUD9?=
 =?us-ascii?Q?T9jKRAEI2McimU590FJX/8PxWE+uuhNTgowybdjY/1YBP7FBST0OnmRe8cpj?=
 =?us-ascii?Q?o3GjcbA71NI1Vk9zg0Qs3KSg9PSH3kCNKpGgQT4e+0MviYZjr3rHOlDZuTxM?=
 =?us-ascii?Q?kU5gl93v4pIkVjc7js2a+c6HnvyDmnSgstYAiWo4H2TCi4MbukKoR+W2Fq5X?=
 =?us-ascii?Q?AowIOAeZjGPNQhtPmCbeZU06SxQWbNt20gFTUhO3ZPIH6WpfLL+c+W4LNAus?=
 =?us-ascii?Q?w/FHLQskTyoWEWJh0ZcEpXPn+Z4fITEAlFdVlcTrRCV8lnS5M2pO+39s0gpl?=
 =?us-ascii?Q?UCudMb9qZAymK1KIzwWNumPouzszOk4xYYDN9vanApMuk7LWrcN3A6PEnldA?=
 =?us-ascii?Q?eJAOvj0iaszUOJ7w4iqCaK2pFkUECoUluuxb7YL3zA5jY0izHpzwNwkXaRBg?=
 =?us-ascii?Q?NmxFjmTRJ5XsGcMRV9eTkRd99NZ3pDDJTHCqcdmE6U/N+sEJZg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/9FAnSaP5h5SEUGF9Z3XVsqsb1Zu44VL9yyHSohmT/GNxUietHG9HFHbIe32?=
 =?us-ascii?Q?uJhZT5kj9A+3hP7WHSyhtMsutMx9EG5OPEJiq/zBqe0eCmNO39U5YWzNxo6F?=
 =?us-ascii?Q?4Lha2G+kCenO/F0LHtOlexCtI+fcxrlk4Y5ORa5aKVBBY7P/VGkjU6Q5V3XT?=
 =?us-ascii?Q?WpBjuo3qp2H2Bc98CCQcWwAFbTNSCiZJWj+Xk6KVEyz69X4xkC52IfP3z5gt?=
 =?us-ascii?Q?JqUjD4DP1+e/wI7NvlBrlrAwVKteLNSnWTOdZuE4W8bfgTVvjgSX87hqSWgl?=
 =?us-ascii?Q?4iRsiHjp78EtTdyeC+IBlXrAoxo/IB2u1skFePx1wqlP2aSJwN09di52Uztd?=
 =?us-ascii?Q?BiyhfCKSxjo5I4DC+08a971vwKSX1IF+VtpbinU26pbtpMpc6N7z/iVs63zd?=
 =?us-ascii?Q?HlcVRgp4Ycf2gtBylf2jlFzsg8Wp8GtLzkp4WtJFrJa5b3fVeRbGEYHIq+Fi?=
 =?us-ascii?Q?qgBWUUyHiZ9qd4v5CTkPwQektMX7h3yE+ThVCJoytorWuAaJJLenlgoukY1P?=
 =?us-ascii?Q?7RZYhuH24yJJxifBL2Hs3waB7Q+K7T3YgrbKT6IDnAfTsRew7iRA4I3Jr9kG?=
 =?us-ascii?Q?N9Ulrh4Gw4HjGQATkkiObmu5KWuGCa9BQgUnQwi98C0o96OugwDiJTuIYtde?=
 =?us-ascii?Q?Py5TotaMyQH3KDzxAOGka+YcDCLcJYZt/cv0nwjpgx2Zh3i7sCFV5ZjcUn1+?=
 =?us-ascii?Q?DkjW3TS9Hm2QxiBkTbsxAthZ9E+bkNynRB+9X3PGlPB5cvpRN+qy178Egi1T?=
 =?us-ascii?Q?fKSYbsH6l4A3Bu51j/BhlNQONca2evpnPjckSTd/6RZ1IQCIlaOGHkcpw/ag?=
 =?us-ascii?Q?WqxVPCQU1306XxORnHFdSS3l76Ve3Czwz6Z+2wBCeShEzxRDBYNAUkxp/LEH?=
 =?us-ascii?Q?RpxvaaeXNe1GBZHH8siWWQ/S/r2f36RFKxJIocFYV411vNlWaB+hGxtk3qrb?=
 =?us-ascii?Q?4dB2mtTueKxPkLnfp85eKo1Uy6qJ5rIZAbBsvx6tzPmGWgNl7P3syUeyMXWQ?=
 =?us-ascii?Q?K/Wy+07EIah3vMk44bT6dAbRQS+ugznVk+pVDuTVFMrFmoBsDNgBjQvXiLSp?=
 =?us-ascii?Q?l2PWWCuz4G/LsWDLwLcVDtO0Q01v7fe9F0P82I1XEufpbrkIjQjRAf2yW5Ec?=
 =?us-ascii?Q?ftelarOru6XE2pusInfXojRxlhitYgztf9GoR8c0qeI3hf0urFvOzqFfTeUl?=
 =?us-ascii?Q?s9vlDP/Z24OtmlsmrA9k8I3vFcysWlEYQi5lnor5uoIjiiL/Vvic8++IEIGz?=
 =?us-ascii?Q?Q2R5/+DGAzF98QX0kQSmQoiV02CItwCA15S5CbV71lgZmmU54rCW2laGZJyf?=
 =?us-ascii?Q?DIQcEg15j1Xgvyvp9IS1JQK5mHYLjZ7BRcsxB1QWtBXC6QVdWfr4UQsmgTlO?=
 =?us-ascii?Q?Cb7Vu/gYUm/Gq0hnUKuBaoKogaOORJeudptiN2fp4ahL46WNqQPiIkHJESbi?=
 =?us-ascii?Q?g/OXAIc68c/s9o6uctotLswpF0pwUyfaKWAW/ERLKPCt+CnNOWdEN3oKDVe/?=
 =?us-ascii?Q?0ipxEtEOjVvfaRAs0eVex2wYuDEt9WvNuZOl82gFxzC312IQQuU6ZyC/g+lF?=
 =?us-ascii?Q?6yP0fcdTpBSPUzha7w2kU9OYxXXcTRcRPjsmC/sJsjcopYQAGKYSQuHI1y1Q?=
 =?us-ascii?Q?PA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f437a89d-dc4c-49e9-9fa6-08dcc5cbf523
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 12:38:16.1352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHZ/t1m1l/kPCRsdoWVU3Nb+nOw+BMW3zXmZXVIbWeFlvEwQy6IQS6aWztJ8Z6pUFSgrz/NRRfabK2YR2Eir2oAj4DUD6oGZsXeRtdwazjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7614
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Aug 2024 12:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16811

> > Since expand-on-first-boot is hosted in isar and disk encryption=20
> > features are enabled with encrypt-partitions override in=20
> > isar-cip-core, we extended (.bbappend) on said recipe by adding needed =
dependencies if this override is set.
>=20
> While the implementation of encryption is handled here, everything that e=
xpand-on-first-boot needs to run cryptsetup resize needs to go upstream. I =
should not matter how the image was encrypted before.

I was initially preparing a patch for isar.
But decided against, because isar does not know about disk-encryption, usin=
g tpm2 to store the token nor about the override used to enable disk encryp=
tion.

> > +DEBIAN_DEPENDS:append:encrypt-partitions =3D ", cryptsetup, \
> > +                                            libtss2-esys-3.0.2-0 | lib=
tss2-esys0, \
> > +                                            libtss2-rc0 | libtss2-esys=
0, \
> > +                                            libtss2-mu0 |=20
> > +libtss2-esys0 \
>=20
> Two issues:
>  - this looks debian release-specific and needs to take that into
>    account

It is! But, since `DISTRO` is not limited to a fixed set of debian releases=
,
I don't see an easy way on how to improve on this. Any suggestions?

>  - indention is unusual and ugly wide

Intention was to put all related packages on single lines
while aligning them vertically.
I see the amount of whitespace is probably a little overkill ...

> > +                                           "
> > \ No newline at end of file

> ...and this should also be avoided.

Sure.

BR Alexander

