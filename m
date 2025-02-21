Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1425C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:53 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.53])
 by mx.groups.io with SMTP id smtpd.web10.21846.1740141111591786381
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2025 04:31:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pIhW8Jae;
 spf=pass (domain: siemens.com, ip: 52.101.67.53, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcAFGHWqikGsdYgTFpi/jwKfUHU47IOMMwuWPMbpZtZzrKFE9Uf1/V0XkciQ54pVLL+ygiDqsT7nVBqFta1NSH+R+uyE2Q//lpdjB0YZ4M6z11D6tYiWbCz7IpfAY75MtO0ujZb8E9h6qZXZdZ/hRzDsmMRuEEpugTzZ15ez/V4lvZIN7sSfh1Ne/RsRlbU9+E15aeK8kNnWBMHxZa7PQzeSp72eMD6qb0FRd58J4LvqN3EMxVQKF1+iIy8tg7WIOfUW96d+CBAMmSoFL1FMFaDsDO567Y4mBh62TWorPJM3Hbx+XjrfbuHLFlaNbe65cqrvYiHFfwE6qUzWheTXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvszwS0CJOyIgZYZE2nGwXZ05nZWLjQh89uVhvDTfIA=;
 b=pvpUmXwM0obcae4S9McgAOSc2bsNyc7iNy4XkMGVufwZJEG83IquWbRFwB3d7A1+YmVmns6ow562JpIzPbwsEiZnZbMk2a4gdiJQ9FTBySCdhJSO6sNY37/anFJGTvVf+wDOROurQbwk0Hkrq66nbBd2t/PnDoZ9SM6YDKRs45J0hJXAhxAuYs2HjxXylgTMkzcS48G/Dq7WCMd4pgVsVrF5X9FCxWCEQ+hEvILsRRQh9oF0HNF8d+40gbKIsxuDX6GEg3fZ4gbXZAxMM2rXcwKCTK6rj8MQpRelw/TYZCLNmVC0gt6tVMRF2UfHwKRfJHnfY81PKZB8Xvi7lgrkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvszwS0CJOyIgZYZE2nGwXZ05nZWLjQh89uVhvDTfIA=;
 b=pIhW8JaeoLVO4IpF2B74oZzYgZoe8fDxXE9um1GFbaglm2prjDwsf1CuWdTmyMT0D7XPgUFZOEqzMlpmuuyhbdyvST+7zJjuyLTMtCjLwOVwjCBxyBTvMvEsDPwcijhsRzMOmW1XCy/IuDA0t39Qw4jCbhFXkhI+KsYwQRr7/CqM5kaYuSShCYvGxfWRWs2anLbhR12d7YaqUWEDGwq8K5Zv/gEPY1aZeOnaLGHrb4LswyY/6Qal18yPMquaUBt1EhnX2EL7NX63MOKfvmLRMk/75CwCsqmOvEa8YPbcV5osuN04T11ZvLAduM6D+Hxj7lKoQi1Ops5sYj1gVDt8oA==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DB8PR10MB3593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:31:47 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 12:31:47 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
Thread-Index: AQHbgSMFS4oMVoV72Emqa3dVE8borLNRsACw
Date: Fri, 21 Feb 2025 12:31:47 +0000
Message-ID: 
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
In-Reply-To: <1824F69F112B9158.31881@lists.cip-project.org>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=89faeb88-ffab-48e3-bac7-91e424affe72;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-21T12:07:11Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DB8PR10MB3593:EE_
x-ms-office365-filtering-correlation-id: 566bae44-36dc-4270-72bd-08dd5273b54b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?Z03hI7I4vPM8HMmQJozEvdrKa+7t9dQrx3OQjaUYZFIcufD5oDBK7UlcYV?=
 =?iso-8859-1?Q?cjHM4I2jlEU58C/7sz7glvmq+l8xYxuyQ3PvPdH370DchIQ5h4q8Dg9EY2?=
 =?iso-8859-1?Q?Ff59D5cSjV8fT5BjnZCQXU/H6htzXEUAK9ATl43GLd/5i3SYd8tujFZGSp?=
 =?iso-8859-1?Q?nKmZ7Z4H0HL+j2GuCyWp5xhMSTxyrG5TuM1qeDIlqIbnnXPr6nx1DGpdvw?=
 =?iso-8859-1?Q?o3BDp3flv7/GV71Qwh9XomNeuoCHh2Ue81QOuDShrShihx1LV0ewX3HlvM?=
 =?iso-8859-1?Q?qs/EmH8/Xc3OE+WS9jLFN5mH53PDwFAgm3qyLGrdwhdPCj8UUvCm8UtmuY?=
 =?iso-8859-1?Q?eZdQXfU8ea/7T5rIWvZAexKi8UkMIAO/93ISDSiTZSs4guv/BUrxPFF5h+?=
 =?iso-8859-1?Q?a8IpX84FTICdGDuK8cTLNpwCtwPGLlFReR8DcOXygvTpVHIPyycZ+3s9+e?=
 =?iso-8859-1?Q?5O1j2ycVfsCNzoenKsK7eFWlp3aJ52rP9l0tr731MOrBkHo4mC/6h4Xf6y?=
 =?iso-8859-1?Q?53LmNOFDBOIKu7Yhc5+Zg3UrMiKaUP+fxu+S6GLMxdzidprs8lBIui9tDd?=
 =?iso-8859-1?Q?HLSVF00V/fd5+e76RRFNhcam/CeDWpfA4y5ykvvqusKTu/ng/9BwGsegMF?=
 =?iso-8859-1?Q?dER49ygk7ItG6kcmCGCYH4eWPRmxwt5hJuD9OmsM9uMqkPFFZkVkoOB47q?=
 =?iso-8859-1?Q?6KKs0L2skgyTWwFAVKQWVoVZKAEARJaFdzt+gqEn+3cUcp0qj8oglFbhXt?=
 =?iso-8859-1?Q?pXgoBe6ehLmE3acZO+ONk58luajA763BQR30Eo02iUfcGU4wqbtQ84fMAZ?=
 =?iso-8859-1?Q?oKDXHyqbgWiRG9qMm+LHprKxuutk3u8svZ+e/bEzFreSRka3irLiYymwHO?=
 =?iso-8859-1?Q?22C7I1Tlbpai1FyI4yiptA/FlDYkM3VBLbIE74L2jMxDyyKsd0yWbRp5jH?=
 =?iso-8859-1?Q?dSwD1pyAznfKU7hiQly8L1fxQFeNv71bYt85H8xSsZvh2aOuHQ8r959/Kx?=
 =?iso-8859-1?Q?uDw67mNUiWUWBOakiaPrx4qsA8nDjRBufT2bzwxf1MoCK0amer5wxflx8x?=
 =?iso-8859-1?Q?VDkcwWQoMLrHWQlB+jJSq8NYGRA9Y+NI8G1LFL6rtP6Bz/OjjR0HQf/BBM?=
 =?iso-8859-1?Q?UXPohW6pLwwvFdoPOSDoFDPz5wsiIBa27e9KwN1Uci9vGjZ3eyTDiEg0xB?=
 =?iso-8859-1?Q?9TGmGK5/7gG77AcR63zSmpIPlSsI5SYb/opNMVc5sailxvNeO4JmixIecg?=
 =?iso-8859-1?Q?d4ZVZTa9A5E/DRa/Tyw4y6L41qvO2d6yScfkLIMy34m523Cpbz2RJdSWl0?=
 =?iso-8859-1?Q?MdbHm3vDkArCBr4j6dzNkiMRcQ9ZxAXMW2Zx0BCz7Ky9gd2ImFE68z5s9O?=
 =?iso-8859-1?Q?WJzLAMq1ImUvLl+8QMU1jTuFJ9wipuoxdTSlTurp89RuQav6uK+HaV5Nr9?=
 =?iso-8859-1?Q?ussKsTJl+KpV5TjD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?MGev9rcGzu+ckpuYWKAP2K+bib7/3KFeij3ILsEC1cFqx4RkAZ6sUp6jC3?=
 =?iso-8859-1?Q?kU+ssTFREGtV0W/Y+Gim03vrixuy/vVAAD2sKY1xNetn3ASAsI9YWgTkmc?=
 =?iso-8859-1?Q?Jl3P2Hw4kVmR60w++eSjSj/THWWMY7y1wjskfthQo8CvLcZo5yHjEcrHXh?=
 =?iso-8859-1?Q?vIvu5Nv/TlDKINjp95aTUvaeynu28SuG5GsvU4fTFilNBe3PEhOihYcJ72?=
 =?iso-8859-1?Q?likstIeSbEIN+MvTKIfgChDiieAXHxhAJ3vQItc2+EsjMBIUxYWkHvIwKq?=
 =?iso-8859-1?Q?Va1PYZ36NRLsqBf806IM7IREJKQRRNdIX/JirfU/94xSmWlFeGR1XhFKQn?=
 =?iso-8859-1?Q?3BGmAsM185TxMixbgCUTN1ecIUL42kzPbc3vqBGOF8Loufb0pxH+lxGKIa?=
 =?iso-8859-1?Q?7SS8RzsCMkBlRGbyP06nQxDJox29IOr0G43Hn75Qnah9rbxNOGaTSCGrO1?=
 =?iso-8859-1?Q?xnITh/WioOJ8zUbchjSNeIXm2sjl7xwFvtbPkUzqZk5h5YQt7l2s3vXbav?=
 =?iso-8859-1?Q?AwYuF1A+6oyxtgn7RHTU0VgZjQ3b+Joh9ASwFtHM85Ru4O40+oiIqJhCWR?=
 =?iso-8859-1?Q?57Jf6KYgHA//ceM83U5KmKETUsFdprZefSgfGrHuo3PrDPn4/+Bm7fuzoG?=
 =?iso-8859-1?Q?VV/SqJU5yFV2OvtmZ3/ONsVhOab31Qa4E6V9FnfeWX2wREF1vbA6LjuaRv?=
 =?iso-8859-1?Q?xNXf8doyoo3JjhyLvVx5LpjhSPOY+HTYqNsJQgxK2V7qvfxpMfOOPSu0hG?=
 =?iso-8859-1?Q?Rk/Eir5fWVv+7WjA/1sjNmvVfb7zPBIexwoESz+teZ+PGFz41Sb4pLO+Bf?=
 =?iso-8859-1?Q?hRNX7YXgexhChoFHhp2p+l2nriBr/3+qwgXpzcaWgwSmgULqId0geXNujt?=
 =?iso-8859-1?Q?qf3zKwd1iRUd89tGC/hIuF6qm2FiTD8azffJE0Uw1W9C6evFXwB40owFhE?=
 =?iso-8859-1?Q?Rn/UZQ4eP2RA3cJ/8kWR+aPDf/CLCQ52GiesSdJj0usKT8RLEydnkMDfXT?=
 =?iso-8859-1?Q?5HOiu6Fk1oOj+wlhoSZMuzUF/H4vv5CRMYWvMsC1/TBOYEccGrRNr8PsQm?=
 =?iso-8859-1?Q?yjhqtJyI5oZgJJPbiLDNAG/3UVsEPx3Q5ka9Y6hBg5vBzFJ7IDl3xU77Gl?=
 =?iso-8859-1?Q?rfzQZboc0ZQkI/8cXIST4hHQOuqBCcew2rIz4SIzvQdDGKtcU8yAIZZmoL?=
 =?iso-8859-1?Q?9ck74DmudU1ijH911obIgnJu1+7q+pHzyAzVg8qLaJfmoRJt06RttN9H2D?=
 =?iso-8859-1?Q?3l7h9QhfGX9r7/kC7RX/T2ZsQnFUUS1wnMO9EW2XA5jjfMPQY4D9/zfiNv?=
 =?iso-8859-1?Q?zhw1jSjJ3XfJ3iUm1orelQVErhLaKUvW+5ueG9BZXqEmWRzRMDBkNqmdqz?=
 =?iso-8859-1?Q?oZ9dIKtKi63Qv8sEdf8tmbd8RmKId2A3mACt/JEthM9Zuo7iuFt23axt8g?=
 =?iso-8859-1?Q?2vyxWIjlSNSOe5cDJV5u53u2y8K09AC4pCJQBhrMFPZiuD99VIW4qNcPEM?=
 =?iso-8859-1?Q?0thuiECpW8J1WJ01w5sVZ8mIUqPwWPmtzzxAaAILR10dykGArZpn0biiIV?=
 =?iso-8859-1?Q?2sOiS3XzZG1yktu+IN4fUmFoGXd/xx+DfBYndj5op0eJGwATdDV5xg5hmw?=
 =?iso-8859-1?Q?71DdDPaop92f7JWI6uao7s8les6/QicDt+eeFw1lCUkAaNAiWUByw73A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 566bae44-36dc-4270-72bd-08dd5273b54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:31:47.2336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIT4iPaEsYNy+DDPNzUEPzd0NUlpL/2QqWCqlikCtl8N9TNaBPspQWyferrTLGt8MChpUfRlWwEBbYIVtry7CVIcnRSgj4FYeD45ucjGG3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3593
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2025 12:31:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17876

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Heinisch, Alexander via lists.cip-project.org
> Sent: Montag, 17. Februar 2025 11:00
> To: cip-dev@lists.cip-project.org
> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff, Quirin =
(FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Heinisch, Alexander (FT=
 RPD CED SES-AT) <alexander.heinisch@siemens.com>
> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from re=
ad-only-rootfs's fstab.
>=20
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>=20
> Since we only support erofs and squashfs this option is not needed any mo=
re. Further, it causes potential overlay rootfs variants to be remounted re=
ad-only.
>=20
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.=
bbclass
> index 35a3ab3..83ddc33 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>  image_configure_fstab() {
>      sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF  # Begin /etc/fstab
> -/dev/root	/		auto		defaults,ro			0	0
> +/dev/root	/		auto		defaults			0	0
>  LABEL=3Dvar	/var		auto		defaults			0	0
>  proc		/proc		proc		nosuid,noexec,nodev		0	0
>  sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
> --
> 2.39.5

We observed `systemd-remount-fs` failing in a downstream layer.
(using a ro squashfs and apply full disk encryption on top)
Although, the service is executed in isar-cip-core as well, upstream,
the service can be executed successfully.

In essence what happens is that, the `systemd-remount-fs`
remounts various mountpoints based on their settings in
`/etc/fstab`

```
root@device-mgmt:~# cat /etc/fstab
# Begin /etc/fstab
/dev/root	/		auto		defaults			0	0
LABEL=3Dvar	/var		auto		defaults			0	0
proc		/proc		proc		nosuid,noexec,nodev		0	0
sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
tmpfs		/run		tmpfs		nodev,nosuid,size=3D500M,mode=3D755	0	0
devtmpfs	/dev		devtmpfs	mode=3D0755,nosuid		0	0
# End /etc/fstab
```

Since `defaults` in fstab renders to: `rw,suid,dev,exec,auto,nouser,async`
the service fails trying to remount the `squashfs` as `rw` as shown below:

```
root@device-mgmt:~# systemctl status systemd-remount-fs
=D7 systemd-remount-fs.service - Remount Root and Kernel File Systems
     Loaded: loaded (/lib/systemd/system/systemd-remount-fs.service; enable=
d-ru>
     Active: failed (Result: exit-code) since Fri 2025-02-21 08:55:39 UTC; =
5min>
       Docs: man:systemd-remount-fs.service(8)
             https://www.freedesktop.org/wiki/Software/systemd/APIFileSyste=
ms
    Process: 7530 ExecStart=3D/lib/systemd/systemd-remount-fs (code=3Dexite=
d, statu>
   Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
        CPU: 15ms
```

```
root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs
Feb 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-remount-fs.s=
ervice - Remount Root and Kernel File Systems...
Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /: canno=
t remount /dev/root read-write, is write-protected.
Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:        dmesg(1)=
 may have more information after failed mount system call.
Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/mount for =
/ exited with exit status 32.
Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service: M=
ain process exited, code=3Dexited, status=3D1/FAILURE
Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service: F=
ailed with result 'exit-code'.
Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start systemd-remou=
nt-fs.service - Remount Root and Kernel File Systems.
```

The rootfs is mounted as follows:

```
root@device-mgmt:~# mount | grep " / "
/dev/mapper/verityroot on / type squashfs (ro,relatime,errors=3Dcontinue)
```

I understand why this happens on our system, but could not clarify why it d=
oes=20
not happen upstream! So any idea, welcome!

Nevertheless, after rethinking this patch. Maybe it was advisible to not us=
e
`default` here and either use a options like `suid,dev,exec,auto,nouser,asy=
nc`
or drop the line for `/dev/root` at all, keeping the mounts as they were se=
tup
in the initramfs.

Any opinions, recommendations, hints, ...?

Thx in advance,
BR Alexander

