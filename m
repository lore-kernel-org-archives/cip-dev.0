Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496CD5C0D3
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 14:53:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.14490.1731077627344546881
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 06:53:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gA6qW+gu;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwZErmrv7RMok5pxOFNwDy8tLdQLg0cBNdB+DnhqRPke3gn8qYPONs3OYS2TqW+ZkT0J9D6I06jsNx7AZNdOi3JenB6fwf9omUsVnS/QRPfj/HVmqYmt2KdI+aDkDXSHEH2FoVae3WRY0+vu5WcYkcuf6et0mz07jAumBW4HgRtvNkd/lmAH+kqUr1YDIErXa12YFtnVy0ujU+PG4uoEYio0AWLmk1h0yPWyi6hmrROIRtn0cfJ1SkP76c5B6xLgG3K7cCSY22xeeAFEsHKYdjjxLE4haQ5sto4ZuxIZpI70JrBl6IWMgjfSwO+elysFCFWUkRhHUc9Q5+ueqEviiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKOkLlhvboMrUbJ2i2kaOtK4AAgB15+SpnPLwzuYty0=;
 b=pYhEgP+rSbSWeAfHT7e1Ot/hhb+H4ByjAdXs5g5rlSONHFOL9417GpDB9mXWdMHsAGpWMV9J8U1UR5B6KJVqMWzLUN4yHamfohaot2iWbjgpPfkyMZUqBlHnfJasCWLLaVTKspIkuwXh4SATzZ8x8jESbYyh9Aq690i5rCXgQNOmFlaYdJETMN8ThdpCIGICq6OfTeH9l35e3IGO2juFklrz4iA7hiEAfCXzCkkHhHoTzdZYGsLvm+Uyx42PuefqeacbtOxyFUmiKDPVUa15OwMi+5z/zvFwF8PKnnAP6ecSjdayjKqs2GlawACBolP4u8nXuKHEZDNTi6TK7QDo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKOkLlhvboMrUbJ2i2kaOtK4AAgB15+SpnPLwzuYty0=;
 b=gA6qW+guAO3cWZSHeITN9CQ5o4k2FkEf0GjwD+IFJ7UdC5rrm5qadpXf/quhwictc01dy/9TGBiDtCxA4DLguvAogdstc0ykqZe+LFxUTMR3ov2P1PwBTXj9kZcB5zoue6Vtn6QVyD/jJ3oionjl7Z49ZdzhgeLN4GyHV5EaVPxek3P1OnYcmOPoAB/KCe0se+L0tU1MtyRL64ADw7YgETJhOLXNDUROCD7o6ZT/pxp1OCVM1NwZjdQ0SpBArtsygjl2l3DIWxdkdcXNzPVlfKfM0oyDDE3IJx1TYMkCW0/X/djHEyoMS9qAr7cdpiHSz+Qgsm2knbEa08bVw9G+Dg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by VI1PR10MB7669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 14:53:42 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 14:53:42 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Index: 
 AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hCAFHuKAIABX72ggAFi9ICAAC5OgA==
Date: Fri, 8 Nov 2024 14:53:42 +0000
Message-ID: 
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
In-Reply-To: <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=9b2a1a94-a89e-4ea4-84b5-f8b61a3f45f6;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-08T14:28:14Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|VI1PR10MB7669:EE_
x-ms-office365-filtering-correlation-id: b40329d1-de96-4396-b36e-08dd00052387
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?znuRcZVwrh4lxM1M13VjeCgzAP8JEq5QihjTuU5X+fDmhijKKu2H1RUljR0A?=
 =?us-ascii?Q?AUFKY9gNidjLE0eufuo5HfDpjNWF2J6Nkxe2VELd66Snsl61PrXJl1d2FGgp?=
 =?us-ascii?Q?7xasfRe2ncuDSXOIQvb0klqrr98y2jVzNaZ+Nwm9jemoyC6B/nFlvnaA2W7j?=
 =?us-ascii?Q?jviLu+yz9YzLEvtLXymuafKAysATZVHZOILaehi7qZ/PNLF4THwhQjMqlIID?=
 =?us-ascii?Q?BO3MwYWLaCvCMdluJBTIbS6IhEZ3xJ9vqgd6up+7s0+OhpQ84Px91/Rtm+sI?=
 =?us-ascii?Q?M8t2EuRrsu/wSGGV0vQu4y/aN85314anQgdeCG1psBjcSoWpBzlTW67cLgl5?=
 =?us-ascii?Q?6FdTygFfCLsv3GuZWjeZKzFNIzz57RkcbQ/5IUVC/VgUHWTzkr33mrJX3Iy9?=
 =?us-ascii?Q?jkpdZiVS/AA10V3eMJ41gKe416krnuRTYmMhG842daSbvdPy+Fo56dzjLgMu?=
 =?us-ascii?Q?IsmYTukIU1gCFmE8IXrVqu2gOukTKenv5qR6gJLSJYCMRR/RXuRM5ROKNc6o?=
 =?us-ascii?Q?Wrcr5seMbTbDc+EqPS0ziF1xHQMSVPxKI3tRuzSXX0xYlXBFwHFOr22hvHwU?=
 =?us-ascii?Q?K0/D3Sz5QXTGRYJk+rNlOm1GjyJUH1BrCSkcweKDj+XoNwN8Tfn3d8ItPqUt?=
 =?us-ascii?Q?PeKe52cVMrM0rjT5djeShReKsKmsff5jTFPvgwja2fL4Y43WcW9XoPcwUWRe?=
 =?us-ascii?Q?IUPaDECm9wyPqIy7Vd9tvn6HxR03toW1I0zbeKk03Y6km5cVH3DXZy4RXwhy?=
 =?us-ascii?Q?DRG8bISh/Uy83DGYgAL6+p58Cp0Z20N16gdY4P42QjpxODDBsjfEv9wghAor?=
 =?us-ascii?Q?Gaa+7MZ2pxkQZSLxBpQSLOJ1S9XyrMfkjoRSipUYyih0BqP2D6q5P1gUAy0Z?=
 =?us-ascii?Q?+OVukDDljQI5hBPYxSkMVN7kQCH3QNeB2OIyxTit41UdpQEfnE5vuNJNy0n0?=
 =?us-ascii?Q?CPRAEfnwPtGcwuX91XeVcqR1W7QLWqhUv5dNCcrFK/7PCFUCOo7HWkMIHgXs?=
 =?us-ascii?Q?FV9cLCY+5yQdznrLo8XOxf2bVicFaqIPFm6yCNR8x3UzeAM5ECHD4+ASMsmF?=
 =?us-ascii?Q?P4g/jTvQCuEOPA1GipthpsbnJ+5YG+4CyrB3QqCWrPP/nicLT3xlfqLBqL3y?=
 =?us-ascii?Q?lSnemXpx1CgMssmzdNAs0Q5V6P7UsIhYyA8NS8Ol9j4CKf4azFNXsuOfT/ff?=
 =?us-ascii?Q?jBhymQ/+djirH93WjU+JQOZRF4wkfYd5RoSG7Ukegp+bgU5LX670IN8HJMd1?=
 =?us-ascii?Q?i6pzNyP0gMqN7VO8L5J5fqbAfLKHOeL1uQytaFtP2Eei1icVpcqLSq3kyn64?=
 =?us-ascii?Q?lc3K+hujcBAuDKR7/5bg2ERX8T3LaumYE1CqOZkOFQiJuhJOlzHA4RVZSifN?=
 =?us-ascii?Q?zXPvpCw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A9D1QClKv9AOG8WVnMFu2bz2XsGPlAHPtGL9K1AXAT1k2gfmhCqsH9ALnXYH?=
 =?us-ascii?Q?AqIw04blOLscKT9EST77yhY9NBi55n235eh25tOfaV3oEwt5BlxppbcydU6p?=
 =?us-ascii?Q?zdhSJMYSIEkr02gugKl4I5WkxfZg9aJR7HvfBEfkbD4GvoTp9PTwCD96XHB7?=
 =?us-ascii?Q?fHv0sjbC7O61K18XCw73IszipVqvlB5MFp8N8F7NCP6CblIyGs7wzb947vf+?=
 =?us-ascii?Q?tF6nf5NZRbAsD92/oj0A92GVwbpgLP21AbfcX5KLBscvK9JigP6MZgfBNoiL?=
 =?us-ascii?Q?Xnn+4JL66kT/x67ur/coL1dmSOdGtXv3b1TDKr8fTfd2DJUOz74R/s7HwhKX?=
 =?us-ascii?Q?4hJ9G+OX/IlAjRvwULzxZZeKm1dySOFE9R+7Wda1yNLaQcuNQKXbbVCakukg?=
 =?us-ascii?Q?VOWQZoBEkHC6NCg8ujZMeueQcAeQHyoKpnP2ROLSZ47/dYdIdr1b6szBuGH5?=
 =?us-ascii?Q?gNLuZtdzWHgTVBFLBLlIOsH0iCWaeV3IWkDs/n25b2aO79ObQ6dHxTXDPlnX?=
 =?us-ascii?Q?mcdbd3k/Oivx6dDQW+LhIPyGiyiq2LY34MlvVPhRr0WTORM2mgCSG7NG+kc5?=
 =?us-ascii?Q?WcqPv7Qh/Ttv6CVB/R3SCjIYD3KQBl8G0fSJRBZVZg4FLvayffoQDh/NEowP?=
 =?us-ascii?Q?fXF7/cNKMmIUPjIFocgSD39/rkvjLrBiBWoIS4LrIW99xWIvBBRq8oebAC6R?=
 =?us-ascii?Q?1UiDanp2q8Fhhbprp/hoMqp8XFEhBY1WUY76vV8TrTgsxka29ZjLKwcDlVYi?=
 =?us-ascii?Q?I/bqkuboAWY2xReYNgykPvVYyenJOYU6qjfaDgO3Y5xo7NKOx4FQ2n7t+l2g?=
 =?us-ascii?Q?Hm2o11wASaZDjrwqqMdCbQHscdbKwhJH8hONLALFdPQCjyZ+mjemAuHp+9pV?=
 =?us-ascii?Q?k8X8eaM4ekG2Fi3RqXcfkBkGogK5hRqCnRNkqk5nJu+m+CHFfFu+SIgR5RIP?=
 =?us-ascii?Q?/5jXiJA2zStTIUuRHzKssCwDQUR2Amxf0vkrNdA7HoHOnMR9XuYW/jnlidfw?=
 =?us-ascii?Q?r1FW2EGieL1fqn92UsVceNUCQ6dLzRNCu/JDqSL7oYeJC2ymfAMm+jfmqwwX?=
 =?us-ascii?Q?LZVK/hBy/RvNzEbvGZqmMPUoYAaUEhHWZpOKuv62e0VnWQcsYnsE0a6wdrXM?=
 =?us-ascii?Q?goDvNYD5GTOcc76ix5Jvs5Wn2CQdDlZmjc6bnYZQ8Ob4cAGERDEF1qYcbJpF?=
 =?us-ascii?Q?eoK42pHNeYAzl6jz1DPYTuPVHD546IB2T7bE4B/b92IHBauG4fsyGaFgYTno?=
 =?us-ascii?Q?NwmH4IvfRPsq4Kdtjlnegk1PnsV0MDa+FGEmyY3eQPgsT+QG2zwZRkNNtu6g?=
 =?us-ascii?Q?5eu5PaYyagBnhHKu5W8r+/pSUi2wUySlcW0iy24rPqUv5GZ0PRMuLVwmfJpw?=
 =?us-ascii?Q?95UDviGcOI+OrbQAz/rnK+i8JT2MmyDYfeNYuwXHxOVzSWAP36niIvuY/89v?=
 =?us-ascii?Q?r5fizdH7iWGo9X0S8Gxs5dP3GWY09vfAZsGS65C7c1q8FX1VcaCkQNaIhyth?=
 =?us-ascii?Q?7s1XJAi1vO3Yte79+tsU3Viq7GMlR1Jx/afNQ88JNEEexZPsI8597SGQaJuh?=
 =?us-ascii?Q?XtwY81EiS9YfHcpzG/V77S7VknQpcKPS1N7Fnm785PzpLndDexNhVsy9Edwx?=
 =?us-ascii?Q?gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b40329d1-de96-4396-b36e-08dd00052387
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 14:53:42.7334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXD9fdNUECnZpSDTRfsWBu6SRBVFTPQFxg7IMMxergWA7RE5PvVUrKandI3BFUv9HDOIyqf+hhhWxyaUMYFGPhicLdIi6QMU52+y+UckbDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7669
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 14:53:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17226

> >>
> >> Quirin and I discussed this a bit longer today: We actually should rem=
ove the need of expand-on-first-boot to access the key again. And that is a=
lso due to an idea I picked up yesterday to lock the tpm secret after initr=
amfs so that we reduce the risk of leaking it via the main OS.
> >>
> >> Our plan is now to convert expand-on-first-boot into an initramfs hook=
 that would then come before the crypt-hook, thus would only work against t=
he unencrypted blank filesystem - problem solved, just differently.
> >>
> >=20
> > Actually that's a good idea!
> > =20
> >> For now, also for trixie, we will just make the dependencies of initra=
mfs-crypt-hook release-dependent in isar-cip-core.
> >=20
> > I guess this is the patch [1] you are referring to?
> >=20
>=20
> Correct.
>=20
> > Just to be sure, still, the implementation of the initramfs hook for ex=
pansion will be in isar?
> >=20
>=20
> Nope, this ideas fell apart after trying to convert the current systemd u=
nit into an early initramfs hook. We will need to split things:
>=20
>  - expansion for already or to-be encrypted partitions needs to go into
>    the crypt-hook of cip-core

ad "expansion for already encrypted": I guess that covers cases like in VM/=
Cloud infra,
where disks can be expanded after first-boot / installation?
---

In many use cases resizing the partition should be required during=20
installation / or first boot only.
That's why, I'd prefer having those steps separated and opting in for eithe=
r!=20
Although package dependencies might be tempting to combine those and reduce=
 recipes + initramfs hooks,
the use cases and options on combining those justify a split.

As an example to point out the combinatorial complexity of just those two r=
ecipes=20
and probably there are even more combinations to come when keeping the syst=
emd expand from isar.=20
(which probably also makes sense for non (customized) initramfs use cases):
My current approach to streamline that (downstream) is by utilizing a=20
target-bootstrapper (kind of next-gen isar-installer).
That means, expansion is not a use case after installation for me when runn=
ing on
target hardware, still, when deploying on vm! Similar combinations apply fo=
r encryption,
not necessarily mapping the ones for expansion.
I am aware of the target-bootstrapping/installer approach is not desired fo=
r many other scenarios=20
(e.g. vm, sd-card based installs, ...) but it already shows a good amount o=
f combinations.

Apart from that, not related to the initial problem, but maybe something to=
 keep in mind when refactoring/reviewing
the existing implementation: The current implementation will potentially br=
eak the rollback capability
on upgrades from systems without encryption yet in case of full disk encryp=
tion.
To mitigate such for upgrades of unencrypted systems to use encryption, we =
must
encrypt the partition relating to the current initramfs only!


>  - filesystem expansion may be doable via the existing
>    expand-on-first-boot if we teach it to skip partition expansion if
>    the disk is already full (currently, it bails out early in that case)

and also skip partition expansion if it is already encrypted.


BR Alexander

