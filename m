Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A00D59D80
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:09:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.236.1765562967350834013
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 10:09:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nrdY0Tx5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqs8ny4me3m0lWT26iCYKjCXvNnjmShxd1AeOphgmJ5D8+DjSVfri6X8mwAQyUmRZWqQyhAsn5IB9icFxDH53HQ3OpHLwHkg6cglnzVm573JSu0vfJvBo4c+xIqfHdjmEGIlVXbiEoDMQER0VKxe/bH1qv8/KsrdZTm77DDk7AzayjFZSGk8WY2TZxvzg+yOhvSWDGQIk22A9ocqvd9MQ9QLoWoWv9VQzqYO+55x5a45pUkv0Cc25NZmyE5UxIIq+M3PVJTx3v4DxxA8zHvpp7A6xny3KXr8jwBKRTBGpdgb0Zneizs2qQcLqPI1+Me6ddUs3KH/nJtGJ9EKzwtARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhPgfHvxyD6eHfPMbZZH8vRpt0qiCm263XvllMKKI4I=;
 b=SEXQah+d5v36aQafvd1Q9ude/g1W+2HXUPZb/v0NQR87jdu5TIV3srRgb0tLf3++i9b2R/w5XuIsPyyEb/mWbxtnmAz7ZIvXoCLrCOSY1zMlXpNS3KctsgC2L2zyU1XdmCYY5irCajGyyTHUDS/vjqTIfJO3trTBsMnF2oGOAEl0vdYvYN4AqT0H6un9/SkhDEiqJ5hKI0fybWvRrEkviqliDaFh1EZznC432OTGgYIoJfJBfRUSPyNWWsUT84XIrGWrSroPfLaoJysNxMfl+j6KKbsCUjcmOpR8AYYc6R+6mrLyVSuTQV3q5weKZQr9bZMhMe+dU4sWHy4+3rcg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhPgfHvxyD6eHfPMbZZH8vRpt0qiCm263XvllMKKI4I=;
 b=nrdY0Tx5IhOdqc2Rbtg7ZiAPDth1gNb5x1+VZMpVd0+lShHDZgtVG8402Fu1BuWkCFOtAJLUw3uYHTj3RDYCaZKFTxEoklkkR2VibPWICJ+MdsAIfrvLLbB025bsu8z8bxCgPzwGYuGhX78hHF30kQISzVSvA++X85nfQ8i+WyU=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYYPR01MB14116.jpnprd01.prod.outlook.com (2603:1096:405:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 18:09:23 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 18:09:23 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 23/38] clk: renesas: Add CPG/MSSR support to
 RZ/N2H SoC
Thread-Topic: [PATCH 6.12.y-cip 23/38] clk: renesas: Add CPG/MSSR support to
 RZ/N2H SoC
Thread-Index: AQHca2a6T0d5ZcABGEiVAMnZOAvFSrUeTcXQ
Date: Fri, 12 Dec 2025 18:09:23 +0000
Message-ID: 
 <OSZPR01MB7019F88EC869BC05B320BE16AAAEA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aTwQ8evxipbEV9gu@duo.ucw.cz>
In-Reply-To: <aTwQ8evxipbEV9gu@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYYPR01MB14116:EE_
x-ms-office365-filtering-correlation-id: a2579094-b694-4c4d-2060-08de39a9944d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?F6ppXSKqJjWEXj/RWm9gp53nMThETxqFWdWRZfGDHkKx1CTLI7dmz8APXeY0?=
 =?us-ascii?Q?NjD/qdy2EQVE92UL+ncO73cpGw9uW+H+qPXjq13rC5K8cxFINBNlDKbJMEzI?=
 =?us-ascii?Q?aEpKzpVVWe7xNDgxzCwsNkuqy4T6ICtE/97r38CYBsMlH57VKzhXm+YsPvmI?=
 =?us-ascii?Q?Pbi97wXafmZ2/jnuXv8hLQdHBrQ4OSyt4VtDx2Kco2ZNoQWyxo4zTFeC31B6?=
 =?us-ascii?Q?UKSnT0TcdEwPMF7Sr6xNf5eioRxW9xlDr9duveMv6oB8DID/ikGpi2aL+mr2?=
 =?us-ascii?Q?ZT0MenVNxclKNEEhkzD2b/AB7aqjnKcdbLk8SugDtW5KWqGcJ0QWH7/BQEtk?=
 =?us-ascii?Q?RaBPJkVSkba2mllvCCC75uvDfVf+ZDvTh+3E1oX6DftJ4tYh2NeToTU4M6vj?=
 =?us-ascii?Q?2xu2FVnRu2SrQbIFOeDXkJ7ixP1cVyCZ5ocVeidDc5M9F6SuaTwf4gv+yjM/?=
 =?us-ascii?Q?f8Blq739oClqvBLfhRgfgoBB8ixDlDW2zwPtbehGYkTQNJtFZPVhYPsHLaoH?=
 =?us-ascii?Q?qLj/SilIhFm1JPH6MD1No0b2xhGjp68MeYzfCzleSDiAbEC8uqQSfLLuCTpJ?=
 =?us-ascii?Q?YenPgvj4fCe/RsLMVXu434Xj1DFq5scv6kVxsQ/SEydy8XYza0GUimAd3PAv?=
 =?us-ascii?Q?YuT83HujIz8quBcD+W2h7U2VhPJ0x/JFNeoKqNgUm2AsYOI0+JxuJD7pAjnj?=
 =?us-ascii?Q?+sYvwLj7DG4Jgk8Ufb//JTu7F2jl842UOX9psv1EHs0Lrrul6rtXYRjUeITV?=
 =?us-ascii?Q?0LI2AVlkMemnko7tzkpIOX7W/znD2XjDZIO094TJwMR3f1AZgK2bBYZScRY9?=
 =?us-ascii?Q?Qo/11hoMqHxTq8N/iuI/X1oYcdgbnrjxu3PgtsQqQHinoqg2UOa2GW45Nv6A?=
 =?us-ascii?Q?vQ84KrOQaFAPg+J22OR2QPem+Q1kce+HM5UZxoXXMMpvQgp0fhte0NUtTA4T?=
 =?us-ascii?Q?xmjx39TBBVo5t/zhdop/Vmd/QIryLAkYeHG7FqbIaGiDw2IMHMUa0OqY73rH?=
 =?us-ascii?Q?EGZ7IhK8Wliz+TNCd15mzdWZaKtqEzevD/32E85IcEuv/j4jiMWWT5eLHEDp?=
 =?us-ascii?Q?/3lXubScCf7eP9iq/iM1u+WUd4hbw1pQCgz468Qal3zpY2xJbqKlDrLiEqve?=
 =?us-ascii?Q?9HH/BXhFmc7Soh5vWs6wm8x6mQpOHwrHNpEgN5e0UmA8bK8Jn+lwLTB/PdxG?=
 =?us-ascii?Q?pyn7nwrutlES2vzao+nG+9Pca9ZBuucWfd3ts7FD3hYwntN4QGxzBK8bW0kT?=
 =?us-ascii?Q?h148Ge+Ig52q6u1Jf0Q4JAaHp+u6t7KFYE0iLkWzHAMyg/WRhNuC2efo1ctV?=
 =?us-ascii?Q?9VGDCjkTIj22mfr5l3rmKAl3bpUaMa3xl5jBTXFOtB0+mmIEtMmeMIInAD7a?=
 =?us-ascii?Q?uKu0526ZD8tthalF857Xlw4t47jwwc3zk012YYfyFZCfNBN/E/nsimXgyQY5?=
 =?us-ascii?Q?ohB1hwEv8BYYmT2sKdRZoKQTJipe4ngRySDwm9bolfIci6X300A5HFkiEZMA?=
 =?us-ascii?Q?1UMSjFHN/XTKlul0ks7jpFLBxY2APPNUvcp+?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vr92fcSI4+WN7L483F8Y5m+wb1NJDD80mtkUiRKg9zQQMFYhhSrGWTUTcO69?=
 =?us-ascii?Q?Lv6X2MEsa7K9pfQye4WPkUI9JffYQZtz1sRu9MDl0hflr4Uv5P4KDi+dSusu?=
 =?us-ascii?Q?gVHx6islNfKVHeHVTpX2hc+9e4N0sn00UVm5+I1lRNuzM89qOc1uYL2xK8b6?=
 =?us-ascii?Q?25dZXC+VeIQ5qbE0gkLmYEJrqpk6KtcY/0WOBbPcuvFM3HF4dpx0N4A6ll/1?=
 =?us-ascii?Q?RYIsP9TqRjoFdL8mJrtwR8gpuQpoMBBZkIUVNMTbVjXrJ1mBIjmYOR2zLyro?=
 =?us-ascii?Q?fHl2S+VVwroTWNU8I54oas9PJP91v8/Jf0XnjHf7EVt5TDu3MNyC4ejAmigf?=
 =?us-ascii?Q?pqx9iIVz0ibYO9SXxj4IXRJfLrqJmPOZ3sDQIm8S97KzfF6xkLRnmzGh0MeY?=
 =?us-ascii?Q?a0LAKiODJuFuEw4HEHSyhv6RMiyRVi/1/ChdhjOirZxDikFoP08ZWzExRes4?=
 =?us-ascii?Q?AoPrbIQe7uADnKQjjXwfvJsILu49I6kRP5BrI5HqoX9cw/DAXInDvMAHrnq2?=
 =?us-ascii?Q?ym0DjKCofXEPhMdWTMQjNNifpvos287u5K90Tm+ywY5Y/6LsyvVX1BiV+95/?=
 =?us-ascii?Q?ZL54diyGYw9jzokQ8IS8t+ilWS5nfooZIKcbxAF3nBhNr1x8QbBixkCnWFVe?=
 =?us-ascii?Q?Ip4rDSgS4bXd6lmDOnXeFPl5i05UrANSAzUG8aoM9zz2e1PUSYQT45LRn4e4?=
 =?us-ascii?Q?vpkyelYAjyuY9ZD+fIcni5wCnKbLWPIDEMejHHdOgMmjKYgTscFP0s5t+brF?=
 =?us-ascii?Q?OW7hP9sOiYvOaYEQa3e2wv3hAB5SKchL9SeBcbnZEtpoqJemat14Xz59sFOt?=
 =?us-ascii?Q?bgrQOu1TwU1qF+u5WIioRKxUjHM3x4ckT57YbWImHiT5qjLirFuQidg3e2xN?=
 =?us-ascii?Q?IRCogvBYhXtqbTqeHf66plmxyMhDichwY1UcMW8TQnZfreKow/3dzYTj9ITZ?=
 =?us-ascii?Q?zZuDIzPUUT22ZzkwvGHu4XXlzpbptV4FNYoL6HSM4SUZ3oWundE7Z6gmHwS5?=
 =?us-ascii?Q?kgpza9Iu/t7m5FAJX9tYioqnWO/EmKsDNw0+cac56VvgtPtEP0CmyYZ/npDT?=
 =?us-ascii?Q?Jb4C3FDm7rSOwBhljnzHRBAO9uHamNLnPPuMnTfVkYHodPLXcgWZ/wR+/KHe?=
 =?us-ascii?Q?bve3grTGLHFZ/LMaVipdTrqO8CncdNgYaSr0RJYPg2pH25IiG5ZZ0nKyEBXk?=
 =?us-ascii?Q?WukNY6svOMJqWaeTURVWGQ0X2o0NFPmU5aiPAOC3cJlSltUIj1P3atJQDml4?=
 =?us-ascii?Q?HDJ/PNizGCQog6Ri45NTeHMJYldXGTuG23flBWs3SpEEAA2kAdpFyF9AaAQW?=
 =?us-ascii?Q?k2Ahhfh+xJsFYKFAXBTi+Va+QQqXJyKl8TcMBtWaf8mwyaUQEP4ybb5NSIrd?=
 =?us-ascii?Q?M08ASSrmMbMeYIJl5FsRl1xuE7/diIirtE3AwK+U9BS9vSDeLhVdN+UFRyid?=
 =?us-ascii?Q?wBaSH8mRBwE8ma6nLUHzYEGu1ppzQx/MB9hDcK107+HueK3PoJB1Ig+XVqDd?=
 =?us-ascii?Q?63k5Z7CUAAvvLsz+AfVDQzPqFwlpKeKMzMKR8DmPdEXar4r3Z/POoCSosBuP?=
 =?us-ascii?Q?/YI00pexKTaMK4U4ByC5o+/OWCn0WY9G4xnjz4Q+pQ5v06ibTk8K6KNDHMHC?=
 =?us-ascii?Q?f6rs4cIRlQs27N70E3ZHgQw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2579094-b694-4c4d-2060-08de39a9944d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 18:09:23.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lapc5QLf87E7I6Adf8BvlL2r2RdrGqBy6a1MigTs29l+xHbGlY7dpy7wtVY6+M7o164K4YsSybnhfMBHsWuywI+/V6rBa3Wx/c2rh5tWYEdldWtj7yS1UE8SMkYXc1qa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 18:09:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20991

Hi Pavel,

Thank you for the review.

> Subject: Re: [PATCH 6.12.y-cip 23/38] clk: renesas: Add CPG/MSSR support
> to RZ/N2H SoC
>=20
> Hi!
>=20
> > Add clock driver support for the Renesas RZ/N2H (R9A09G087) SoC by
> > reusing the existing RZ/T2H (R9A09G077) CPG/MSSR implementation, as
> > both SoCs share the same clock and reset architecture.
>=20
> > +++ b/drivers/clk/renesas/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_CLK_R9A09G047)		+=3D r9a09g047-cpg.o
> >  obj-$(CONFIG_CLK_R9A09G056)		+=3D r9a09g056-cpg.o
> >  obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
> >  obj-$(CONFIG_CLK_R9A09G077)		+=3D r9a09g077-cpg.o
> > +obj-$(CONFIG_CLK_R9A09G087)		+=3D r9a09g077-cpg.o
> >  obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
>=20
> This is kind of strange -- two options selecting same file. I believe it
> is correct based on code below.
>
Yes, as both the SoCs use the same r9a09g077-cpg.c file for clock handling.

Cheers,
Prabhakar

