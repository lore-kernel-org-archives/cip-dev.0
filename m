Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21473C4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 09:20:07 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.114])
 by mx.groups.io with SMTP id smtpd.web11.43328.1669368001020164602
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Nov 2022 01:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=T5cZaL8I;
 spf=pass (domain: renesas.com, ip: 40.107.113.114, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUCr45WA0A05A4+EMRizmxQoeFGfPnQBEKHqy74353v2qShyuSJdFSZ/t2+pRAAyHJqxUqWr9OLF7Ksh+CnalFtr5+TaZmRsvG6CAWNYCuyqNYo2SVrrseRcbAakK+VwEbUYh73gDK9iuyz0Vth10neb5AnHqp5OrrMqgM6USMU1h9R5tsc4Aa5964YY/o2Sshymid7Je0mmvQ79osYtSPvm27yA7gRaUA0YEK6cUoExvwWtW+D8zqanMg4IzLKMWrlwhn44KERtW9hH/GITfOQff3uA7LKkNJ8fDaAIShnWiXHfV6sQ7WCZTD2b+yON5zZpS4RTNzsOg9FqitYAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV4m2omn4PZUBui/eLi8xgajAQ8233gWeMAWpykK/58=;
 b=SOUIBHW841ombeVzl0OIlVr7Miq9jU9ud2WC9IH5GVAwlGyuqcqE3Dm+cHQEVgK+ukDh/Kcwy9WX2gbiWX2jqCZzZuDVjsb+ZAUwAuJ5OtTrThzkyDlNBKBZjx+TFpHJY7Ktu603Fb5i5uHYFBqJLk9tvhAP1DQ0rH+qj4yYZuH3ef1GHKVDJ15rBTHfBMXVvAsbH/xGB5NKcDVZvXJHS0+sExcBMXCnHd93yN9DMLYtdBusWQq6bfeonVUFjNBKjz235HZCZ2W+ByOV8aqX78ffNq2W1FQDh8XW//O0wGeI/qWIEIRa2OYE7/Uo+UfNkP3uBUP4OZJtewIJFESDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV4m2omn4PZUBui/eLi8xgajAQ8233gWeMAWpykK/58=;
 b=T5cZaL8IeYqgSV/lb+dPjvlKnlEXFOPNcHGNzJaXSpiUkvz/Nn0LdbAJRDcgoz020Xi/AK3HCsfpZPVwIW13wogK3YC4fr0N9qKekXhdcoMCeHfzs5pJDc58zTxHGTLh9J2Of2pDbGo/wXeHzdidB8Nl9ChbTLmiRaYLS+U2PdQ=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYWPR01MB9775.jpnprd01.prod.outlook.com (2603:1096:400:235::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 09:19:55 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293%8]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 09:19:55 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] cip/linux-4.4.y-cip build: 180 builds: 0 failed, 180
 passed, 196 warnings (v4.4.302-cip70-98-g7f7838c92740) #kernelci
Thread-Topic: [cip-dev] cip/linux-4.4.y-cip build: 180 builds: 0 failed, 180
 passed, 196 warnings (v4.4.302-cip70-98-g7f7838c92740) #kernelci
Thread-Index: AQHZAKMNpuCnJq3hFkmh/0y7+mAyfq5PWVcA
Date: Fri, 25 Nov 2022 09:19:55 +0000
Message-ID: 
 <TYCPR01MB10588D04A18B949134BE7DD0BB70E9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <6380747d.170a0220.c8a23.38be@mx.google.com>
In-Reply-To: <6380747d.170a0220.c8a23.38be@mx.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYWPR01MB9775:EE_
x-ms-office365-filtering-correlation-id: 0c34d9af-8c07-466f-d606-08dacec6372e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rKlkIObJPVBMGpcNctPfGguXyvYe/bPk/Tx9eMKHTqHPFS+jOX0SBx/ETaUouSoeyYLf5EUbrgkcQltTw3Bwpmxzu4Po3pxQa2eQ7qgyQVRl/bJyw95PuEZujY0wy73CQFtH7IUYmYRba7QePfmuW7WiFHE7Z6EmtmI8y9J8PKVBWEatgfYGULVp4AzWXFEDY5CVsBDyD7aV2mUMmnNGkFMufHXe4r75j64PE3hBfE58Qiuc5rpWWTcYUNDxHXTxmj2rCxlGbB0SsaHrQ15n6R4+OcOkpPi8t7Dj5ANvAc421FJhVvNZCoFNGHCY7XFEEdycF8rJlRrnPSBzn5NdM1AF0C6+yiuSvl25YMtxb6hYLnDbNzQrse6rDxvIxBYknPSX5Kvzqgx7vRFuHjJmGI0/6yOc3Xij/zTmzGmzyMAwpTXu3l1h74dMwrVeNet1xuMwKSVX+Qg/QAqYNWx5VMGUEftz/AoTf6JryM6mSpDk6qI3mQpXDV2b31NR23AXG4PZlSFTzYKJYr+GnDUBnGPLNgHiI6uwEuruyaV8BI2b7HAJ+8PXntbHmwcwb0l4Pj+Vj/UsauV28TQYxkICODaeY2xyClujKmWdcNjeitsVRjS3oPxzft3+ft104LhCUJuBL3cjn4eGkUmANSy9rtDSr2kZkTEjtZv8vapd7KeKU9LGcabfAY4A4Y4iPuNmpsykQV/G/2l7FZBucsbBsgu9HPDa2kSIde6gt2ugwGs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(55016003)(122000001)(41300700001)(478600001)(86362001)(33656002)(38100700002)(45080400002)(71200400001)(966005)(9686003)(26005)(52536014)(66946007)(76116006)(66476007)(66556008)(5660300002)(83380400001)(2906002)(7696005)(6506007)(38070700005)(66446008)(8676002)(186003)(6916009)(316002)(64756008)(30864003)(8936002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?tLDoS4aIDtm2BxEfSJcxpAFLQG0EkbI8MQTtbeY8ew/FzfYKROuGLF8U?=
 =?Windows-1252?Q?ejj1IRqrzCPcROpedg5VqdU+CsLiQbCu8NOsTy3LELwGI/GOkuSk/YZQ?=
 =?Windows-1252?Q?61FV5RdKWZJwLUN7R77fj8tDPUYzneUC3mQDMhRB083SGYuF93zj/lty?=
 =?Windows-1252?Q?HgOzmPw28n+S5hUpSs/hDrznsaE8WBuBsQhHZ3x8ZZ8ITNmW0M+xi7hf?=
 =?Windows-1252?Q?aHV+BHlN+XkuleKOVMusR2P4GFAdxMDCJxGcNdzyzZXJawecQR/fy2+i?=
 =?Windows-1252?Q?QJfHPM0eg+vEZBH8GAVFXd6U3XH2hGpbFdn0HiJ4aItAfU9mdL3EZ1jc?=
 =?Windows-1252?Q?uFJoZ8t4pwfPF5SAQQ0ITwDC/Z2gK0WddgkpQnl98vCSEC1IACNgSN5s?=
 =?Windows-1252?Q?bSmoVk3O9LDLeqwvMvyN2zoCL3b56mTcuEPdKlk5dE8A6kZfb+HzyXBm?=
 =?Windows-1252?Q?7MdbKc1UQRh9l32SYPMqko2Wy59Hp1vQ7gDgif/D9VEN5d62pd8uucRl?=
 =?Windows-1252?Q?iK+H+d0dAfifRP+6I2l25cP3WioPTM93EtcBYxpY7hHU9UAqcO9YUtPJ?=
 =?Windows-1252?Q?ChPC+6yRayrq4intFWYtqnwNTqOghsG+9AzxYKFDgQ2As6Gggi+tWW9+?=
 =?Windows-1252?Q?7i4g11Pt0371ppVYjERl1YkbNS6oljJaMUdwOD41MJojrYQjQ3RNEw+j?=
 =?Windows-1252?Q?8hUxoKzOz+JwTurB7q9cGYAgeIIAMa0YVgWw8FHfkFf+OWO5t3Jl1Qfd?=
 =?Windows-1252?Q?dX34uDGm2ICofrdTaxr+EaV1Y5KWYvAvnyIkRwBKk2T/xMzzLHaDH1tB?=
 =?Windows-1252?Q?9hwMmp6nu+wWyree/xHlUcLPTTVpAOEYcc5ALbxa1yP7PNsJSu12+7HL?=
 =?Windows-1252?Q?1dr8M6a4O5arhMSLakB6QFFwHUEnIFUqv06KyMtHflXj8O2LnenGwQi3?=
 =?Windows-1252?Q?ZdLLtJJXjQrDYvSn6fGYDrG0I2UGyY3a9GRBPKZ8P3oz5/Ren3kHOauS?=
 =?Windows-1252?Q?k4uKqP6Piw7lrZY1lZ1scEkLUKtKjhtFG8r2PW0Iyf+q+OaJ+P8jScKG?=
 =?Windows-1252?Q?PwT0SZvs2Lqb1HHuXZUwk06b/6FHYVHIvTfRcsPU4b3W76erupw7z81N?=
 =?Windows-1252?Q?12Z1lxbrYU1Dai+VrjNEzXakHDsL3Cts3X3/h3eP8S++fO0Cnt6hl60g?=
 =?Windows-1252?Q?V4yVilXA53+4vac3ehBK2FdCq5Qh7PzLphMX0RGucAz1KeGs47GJ2c84?=
 =?Windows-1252?Q?Z7sEttC+2tT71yalnX9dvHSUt9L/W5/f+ziOE21kkrsIBwu13VW81rCz?=
 =?Windows-1252?Q?ov6dxgAjZZuS1DgXhHnU1oPN1E+gjkJ+rZQb1wxYcNfyNcRgHqL5cjuq?=
 =?Windows-1252?Q?dYDgL+l8Yrfrz7O+NmflwHaSzvPqsxuRBRFvB8/7CewP9dj6TaVqr8DJ?=
 =?Windows-1252?Q?zQYg+qfF+we0Xt8PMNovM7vaxA3MHXW7OEMH/Ip1Deqt1xLdcOalcCyG?=
 =?Windows-1252?Q?e9/x6l5ubitY9oObXwEyzT5AlJxRsTZJIuQmwK2r8mC/y9GWa7+xOoNE?=
 =?Windows-1252?Q?qXk40lHyAg+9Z8AEwPKGXIhkhj4HBL5K3d7rjV/yuod3w25jZjZNF6p2?=
 =?Windows-1252?Q?ob5FH1gMx5lFOhVr8tTtbwKefPmEDbi03U2yp4QgphuvZNwT07eNkrCa?=
 =?Windows-1252?Q?pf1+RH2mLWcszxKTyiYvNx/7S018DWpJaKLtH1V01B6OpAaSiorrSg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c34d9af-8c07-466f-d606-08dacec6372e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 09:19:55.0696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsbhjqeaWQsH5Hlawbg5Be9F9UktpI3abt7gXjvNK+Sbb75urgO8+IY10EzxU/WxWD8M1ACWoBO/LWQelHN+avJF/xHzJhUz3sPdRi+kK1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9775
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 09:20:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10105

Hello maintainers,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of kernelci.org bot via lists.cip-project.org
> Sent: 25 November 2022 07:54
>=20
> cip/linux-4.4.y-cip build: 180 builds: 0 failed, 180 passed, 196 warnings
> (v4.4.302-cip70-98-g7f7838c92740)

It looks like we're getting a lot of new build warnings in this build compa=
red to the last where we only had 16.
Scroll to the bottom of these links to see a summary.
Summary of this build (commit 7f7838c92740): https://linux.kernelci.org/bui=
ld/cip/branch/linux-4.4.y-cip/kernel/v4.4.302-cip70-98-g7f7838c92740/
Summary of last build (commit 69445bc0d420): https://linux.kernelci.org/bui=
ld/cip/branch/linux-4.4.y-cip/kernel/v4.4.302-cip70-236-g69445bc0d4209/

However, looking at the complete history for this branch: https://linux.ker=
nelci.org/job/cip/branch/linux-4.4.y-cip/,
It looks like we've seen similar warnings since after the cip69 release.

Whether these warnings are something to be fixed or not I'll leave in your =
hands.

Kind regards, Chris


>=20
> Full Build Summary:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkerne
> lci.org%2Fbuild%2Fcip%2Fbranch%2Flinux-4.4.y-cip%2Fkernel%2Fv4.4.302-
> cip70-98-
> g7f7838c92740%2F&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com
> %7Cf9ac35b0e032458192cf08daceba2cfb%7C53d82571da1947e49cb4625a166
> a4a2a%7C0%7C0%7C638049596289730114%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3DQio42qmKiJtP2GAW7tPFjvZqybLqxhiyloih
> 7cfr2k4%3D&amp;reserved=3D0
>=20
> Tree: cip
> Branch: linux-4.4.y-cip
> Git Describe: v4.4.302-cip70-98-g7f7838c92740
> Git Commit: 7f7838c92740fa423a5a3f12c00ed02d92851254
> Git URL:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fcip%2Flinux-
> cip.git&amp;data=3D05%7C01%7Cchris.paterson2%40renesas.com%7Cf9ac35b0
> e032458192cf08daceba2cfb%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> C0%7C638049596289730114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3DMGUHQP%2FYfZlBLrS46YOrG%2BSy1L%2BC1vxHRlzDrP
> FFjZU%3D&amp;reserved=3D0
> Built: 5 unique architectures
>=20
> Warnings Detected:
>=20
> arc:
>     axs103_defconfig (gcc-10): 1 warning
>     axs103_smp_defconfig (gcc-10): 1 warning
>     nsim_hs_defconfig (gcc-10): 1 warning
>     nsim_hs_smp_defconfig (gcc-10): 1 warning
>     nsimosci_hs_defconfig (gcc-10): 1 warning
>     nsimosci_hs_smp_defconfig (gcc-10): 1 warning
>     vdk_hs38_defconfig (gcc-10): 1 warning
>     vdk_hs38_smp_defconfig (gcc-10): 1 warning
>=20
> arm:
>     acs5k_defconfig (gcc-10): 1 warning
>     acs5k_tiny_defconfig (gcc-10): 1 warning
>     am200epdkit_defconfig (gcc-10): 1 warning
>     assabet_defconfig (gcc-10): 1 warning
>     at91_dt_defconfig (gcc-10): 1 warning
>     axm55xx_defconfig (gcc-10): 1 warning
>     badge4_defconfig (gcc-10): 1 warning
>     bcm2835_defconfig (gcc-10): 1 warning
>     bcm_defconfig (gcc-10): 1 warning
>     cerfcube_defconfig (gcc-10): 1 warning
>     clps711x_defconfig (gcc-10): 2 warnings
>     cm_x2xx_defconfig (gcc-10): 1 warning
>     cm_x300_defconfig (gcc-10): 1 warning
>     colibri_pxa270_defconfig (gcc-10): 1 warning
>     colibri_pxa300_defconfig (gcc-10): 1 warning
>     collie_defconfig (gcc-10): 1 warning
>     corgi_defconfig (gcc-10): 1 warning
>     davinci_all_defconfig (gcc-10): 2 warnings
>     dove_defconfig (gcc-10): 1 warning
>     ebsa110_defconfig (gcc-10): 1 warning
>     efm32_defconfig (gcc-10): 1 warning
>     em_x270_defconfig (gcc-10): 1 warning
>     ep93xx_defconfig (gcc-10): 1 warning
>     eseries_pxa_defconfig (gcc-10): 1 warning
>     exynos_defconfig (gcc-10): 1 warning
>     ezx_defconfig (gcc-10): 1 warning
>     footbridge_defconfig (gcc-10): 1 warning
>     h3600_defconfig (gcc-10): 1 warning
>     h5000_defconfig (gcc-10): 1 warning
>     hackkit_defconfig (gcc-10): 1 warning
>     hisi_defconfig (gcc-10): 1 warning
>     imote2_defconfig (gcc-10): 1 warning
>     imx_v4_v5_defconfig (gcc-10): 1 warning
>     imx_v6_v7_defconfig (gcc-10): 1 warning
>     integrator_defconfig (gcc-10): 1 warning
>     iop13xx_defconfig (gcc-10): 1 warning
>     iop32x_defconfig (gcc-10): 1 warning
>     iop33x_defconfig (gcc-10): 1 warning
>     ixp4xx_defconfig (gcc-10): 1 warning
>     jornada720_defconfig (gcc-10): 1 warning
>     keystone_defconfig (gcc-10): 1 warning
>     ks8695_defconfig (gcc-10): 1 warning
>     lart_defconfig (gcc-10): 1 warning
>     lpc18xx_defconfig (gcc-10): 1 warning
>     lpc32xx_defconfig (gcc-10): 2 warnings
>     lpd270_defconfig (gcc-10): 1 warning
>     lubbock_defconfig (gcc-10): 1 warning
>     magician_defconfig (gcc-10): 1 warning
>     mainstone_defconfig (gcc-10): 1 warning
>     mini2440_defconfig (gcc-10): 2 warnings
>     mmp2_defconfig (gcc-10): 1 warning
>     multi_v5_defconfig (gcc-10): 1 warning
>     multi_v7_defconfig (gcc-10): 1 warning
>     mv78xx0_defconfig (gcc-10): 1 warning
>     mvebu_v5_defconfig (gcc-10): 1 warning
>     mvebu_v7_defconfig (gcc-10): 1 warning
>     mxs_defconfig (gcc-10): 2 warnings
>     neponset_defconfig (gcc-10): 1 warning
>     netwinder_defconfig (gcc-10): 1 warning
>     netx_defconfig (gcc-10): 1 warning
>     nhk8815_defconfig (gcc-10): 1 warning
>     omap1_defconfig (gcc-10): 2 warnings
>     omap2plus_defconfig (gcc-10): 2 warnings
>     orion5x_defconfig (gcc-10): 1 warning
>     palmz72_defconfig (gcc-10): 1 warning
>     pcm027_defconfig (gcc-10): 1 warning
>     pleb_defconfig (gcc-10): 1 warning
>     pxa168_defconfig (gcc-10): 1 warning
>     pxa255-idp_defconfig (gcc-10): 1 warning
>     pxa3xx_defconfig (gcc-10): 1 warning
>     pxa910_defconfig (gcc-10): 1 warning
>     qcom_defconfig (gcc-10): 1 warning
>     raumfeld_defconfig (gcc-10): 1 warning
>     realview-smp_defconfig (gcc-10): 1 warning
>     realview_defconfig (gcc-10): 1 warning
>     s3c2410_defconfig (gcc-10): 2 warnings
>     s3c6400_defconfig (gcc-10): 2 warnings
>     sama5_defconfig (gcc-10): 1 warning
>     shannon_defconfig (gcc-10): 1 warning
>     shmobile_defconfig (gcc-10): 1 warning
>     simpad_defconfig (gcc-10): 1 warning
>     socfpga_defconfig (gcc-10): 1 warning
>     spear13xx_defconfig (gcc-10): 1 warning
>     spitz_defconfig (gcc-10): 1 warning
>     sunxi_defconfig (gcc-10): 1 warning
>     tegra_defconfig (gcc-10): 1 warning
>     trizeps4_defconfig (gcc-10): 1 warning
>     u8500_defconfig (gcc-10): 1 warning
>     versatile_defconfig (gcc-10): 1 warning
>     vexpress_defconfig (gcc-10): 1 warning
>     viper_defconfig (gcc-10): 1 warning
>     vt8500_v6_v7_defconfig (gcc-10): 1 warning
>     xcep_defconfig (gcc-10): 1 warning
>     zeus_defconfig (gcc-10): 1 warning
>=20
> i386:
>     i386_defconfig (gcc-10): 5 warnings
>=20
> mips:
>     ar7_defconfig (gcc-10): 1 warning
>     ath79_defconfig (gcc-10): 1 warning
>     bcm47xx_defconfig (gcc-10): 1 warning
>     bcm63xx_defconfig (gcc-10): 1 warning
>     bigsur_defconfig (gcc-10): 1 warning
>     bmips_be_defconfig (gcc-10): 1 warning
>     bmips_stb_defconfig (gcc-10): 1 warning
>     capcella_defconfig (gcc-10): 1 warning
>     cavium_octeon_defconfig (gcc-10): 1 warning
>     ci20_defconfig (gcc-10): 1 warning
>     cobalt_defconfig (gcc-10): 1 warning
>     db1xxx_defconfig (gcc-10): 1 warning
>     decstation_defconfig (gcc-10): 1 warning
>     gpr_defconfig (gcc-10): 1 warning
>     ip22_defconfig (gcc-10): 2 warnings
>     ip32_defconfig (gcc-10): 1 warning
>     jazz_defconfig (gcc-10): 1 warning
>     jmr3927_defconfig (gcc-10): 1 warning
>     lasat_defconfig (gcc-10): 1 warning
>     loongson3_defconfig (gcc-10): 1 warning
>     ls1b_defconfig (gcc-10): 1 warning
>     malta_defconfig (gcc-10): 1 warning
>     malta_kvm_defconfig (gcc-10): 1 warning
>     malta_kvm_guest_defconfig (gcc-10): 1 warning
>     malta_qemu_32r6_defconfig (gcc-10): 1 warning
>     maltaaprp_defconfig (gcc-10): 1 warning
>     maltasmvp_defconfig (gcc-10): 1 warning
>     maltasmvp_eva_defconfig (gcc-10): 1 warning
>     maltaup_defconfig (gcc-10): 1 warning
>     maltaup_xpa_defconfig (gcc-10): 1 warning
>     markeins_defconfig (gcc-10): 1 warning
>     mips_paravirt_defconfig (gcc-10): 1 warning
>     mpc30x_defconfig (gcc-10): 1 warning
>     msp71xx_defconfig (gcc-10): 1 warning
>     mtx1_defconfig (gcc-10): 4 warnings
>     nlm_xlp_defconfig (gcc-10): 1 warning
>     nlm_xlr_defconfig (gcc-10): 1 warning
>     pnx8335_stb225_defconfig (gcc-10): 1 warning
>     qi_lb60_defconfig (gcc-10): 1 warning
>     rb532_defconfig (gcc-10): 1 warning
>     rbtx49xx_defconfig (gcc-10): 1 warning
>     rm200_defconfig (gcc-10): 1 warning
>     rt305x_defconfig (gcc-10): 1 warning
>     sb1250_swarm_defconfig (gcc-10): 1 warning
>     sead3_defconfig (gcc-10): 1 warning
>     sead3micro_defconfig (gcc-10): 1 warning
>     tb0219_defconfig (gcc-10): 1 warning
>     tb0226_defconfig (gcc-10): 1 warning
>     tb0287_defconfig (gcc-10): 1 warning
>     workpad_defconfig (gcc-10): 1 warning
>     xway_defconfig (gcc-10): 1 warning
>=20
> x86_64:
>     allnoconfig (gcc-10): 4 warnings
>     tinyconfig (gcc-10): 3 warnings
>     x86_64_defconfig (gcc-10): 9 warnings
>     x86_64_defconfig+x86-chromebook (gcc-10): 9 warnings
>=20
>=20
> Warnings summary:
>=20
>     147  net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses
> around =91+=92 in operand of =91&=92 [-Wparentheses]
>     8    net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses
> around '+' in operand of '&' [-Wparentheses]
>     7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic
> suffix given and no register operands; using default for `btr'
>     4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic
> suffix given and no register operands; using default for `btr'
>     4    arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic
> suffix given and no register operands; using default for `sysret'
>     3    ld: warning: creating DT_TEXTREL in a PIE
>     3    drivers/tty/serial/samsung.c:1776:34: warning: array
> =91s3c24xx_uart_dt_match=92 assumed to have one element
>     3    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-
> allocatable section.
>     3    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable
> section.
>     2    sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration
> 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
>     2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in r=
ead-
> only section `.head.text'
>     1    sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration
> 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
>     1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in r=
ead-
> only section `.head.text'
>     1    drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing
> argument 5 of =91dma_free_attrs=92 makes pointer from integer without a c=
ast [-
> Wint-conversion]
>     1    drivers/mmc/host/sdhci-s3c.c:429:34: warning: array
> =91sdhci_s3c_dt_match=92 assumed to have one element
>     1    drivers/gpio/gpio-omap.c:1161:34: warning: array =91omap_gpio_ma=
tch=92
> assumed to have one element
>     1    drivers/cpufreq/ti-cpufreq.c:250:24: warning: passing argument 1=
 of
> =91PTR_ERR_OR_ZERO=92 makes pointer from integer without a cast [-Wint-
> conversion]
>     1    arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =91const=
=92
> declaration specifier [-Wduplicate-decl-specifier]
>     1    arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =91co=
nst=92
> declaration specifier [-Wduplicate-decl-specifier]
>     1    arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =91co=
nst=92
> declaration specifier [-Wduplicate-decl-specifier]
>     1    arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplica=
te
> =91const=92 declaration specifier [-Wduplicate-decl-specifier]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Detailed per-defconfig build reports:
>=20
> -------------------------------------------------------------------------=
-------
> acs5k_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> acs5k_tiny_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (arc, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (mips, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (x86_64, gcc-10) =97 PASS, 0 errors, 4 warnings, 0 section
> mismatches
>=20
> Warnings:
>     arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suff=
ix
> given and no register operands; using default for `sysret'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>=20
> -------------------------------------------------------------------------=
-------
> allnoconfig (i386, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section mism=
atches
>=20
> -------------------------------------------------------------------------=
-------
> am200epdkit_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ar7_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> assabet_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> at91_dt_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ath79_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> axm55xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> axs103_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> axs103_smp_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> badge4_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bcm2835_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bcm47xx_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bcm63xx_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bcm_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bigsur_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bmips_be_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> bmips_stb_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> capcella_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> cavium_octeon_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> cerfcube_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ci20_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> clps711x_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     arch/arm/mach-clps711x/board-autcpu12.c:163:26: warning: duplicate
> =91const=92 declaration specifier [-Wduplicate-decl-specifier]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> cm_x2xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> cm_x300_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> cobalt_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> colibri_pxa270_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 s=
ection
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> colibri_pxa300_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 s=
ection
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> collie_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> corgi_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> davinci_all_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 sec=
tion
> mismatches
>=20
> Warnings:
>     arch/arm/mach-davinci/da8xx-dt.c:23:34: warning: duplicate =91const=
=92
> declaration specifier [-Wduplicate-decl-specifier]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> db1xxx_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> decstation_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> dove_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> e55_defconfig (mips, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> ebsa110_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> efm32_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> em_x270_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ep93xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> eseries_pxa_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> exynos_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ezx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> footbridge_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> gpr_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> h3600_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> h5000_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> hackkit_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> hisi_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> i386_defconfig (i386, gcc-10) =97 PASS, 0 errors, 5 warnings, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>     WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable
> section.
>     WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-
> allocatable section.
>     ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-o=
nly
> section `.head.text'
>     ld: warning: creating DT_TEXTREL in a PIE
>=20
> -------------------------------------------------------------------------=
-------
> imote2_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> imx_v4_v5_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> imx_v6_v7_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> integrator_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> iop13xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> iop32x_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> iop33x_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ip22_defconfig (mips, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     drivers/net/ethernet/seeq/sgiseeq.c:804:26: warning: passing argument=
 5
> of =91dma_free_attrs=92 makes pointer from integer without a cast [-Wint-
> conversion]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ip32_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ixp4xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> jazz_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> jmr3927_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> jornada720_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> keystone_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ks8695_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lart_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lasat_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> loongson3_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lpc18xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lpc32xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     arch/arm/mach-lpc32xx/phy3250.c:215:36: warning: duplicate =91const=
=92
> declaration specifier [-Wduplicate-decl-specifier]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lpd270_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> ls1b_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> lubbock_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> magician_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mainstone_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> malta_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> malta_kvm_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> malta_kvm_guest_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> malta_qemu_32r6_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> maltaaprp_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> maltasmvp_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> maltasmvp_eva_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> maltaup_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> maltaup_xpa_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sec=
tion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> markeins_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mini2440_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>     drivers/tty/serial/samsung.c:1776:34: warning: array
> =91s3c24xx_uart_dt_match=92 assumed to have one element
>=20
> -------------------------------------------------------------------------=
-------
> mips_paravirt_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 s=
ection
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mmp2_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mpc30x_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> msp71xx_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mtx1_defconfig (mips, gcc-10) =97 PASS, 0 errors, 4 warnings, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>     sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration
> 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
>     sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration
> 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
>     sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration
> 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
>=20
> -------------------------------------------------------------------------=
-------
> multi_v5_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> multi_v7_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mv78xx0_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mvebu_v5_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mvebu_v7_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> mxs_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     arch/arm/mach-mxs/mach-mxs.c:285:26: warning: duplicate =91const=92
> declaration specifier [-Wduplicate-decl-specifier]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> neponset_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> netwinder_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> netx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nhk8815_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nlm_xlp_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nlm_xlr_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nsim_hs_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nsim_hs_smp_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nsimosci_hs_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nsimosci_hs_smp_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> nuc910_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> nuc950_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> nuc960_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> omap1_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     drivers/gpio/gpio-omap.c:1161:34: warning: array =91omap_gpio_match=
=92
> assumed to have one element
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> omap2plus_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 secti=
on
> mismatches
>=20
> Warnings:
>     drivers/cpufreq/ti-cpufreq.c:250:24: warning: passing argument 1 of
> =91PTR_ERR_OR_ZERO=92 makes pointer from integer without a cast [-Wint-
> conversion]
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> orion5x_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> palmz72_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pcm027_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pleb_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pnx8335_stb225_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> prima2_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> pxa168_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pxa255-idp_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 secti=
on
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pxa3xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> pxa910_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> qcom_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> qi_lb60_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> raumfeld_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> rb532_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> rbtx49xx_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> realview-smp_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sec=
tion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> realview_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> rm200_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> rt305x_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> s3c2410_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     drivers/tty/serial/samsung.c:1776:34: warning: array
> =91s3c24xx_uart_dt_match=92 assumed to have one element
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> s3c6400_defconfig (arm, gcc-10) =97 PASS, 0 errors, 2 warnings, 0 section
> mismatches
>=20
> Warnings:
>     drivers/mmc/host/sdhci-s3c.c:429:34: warning: array =91sdhci_s3c_dt_m=
atch=92
> assumed to have one element
>     drivers/tty/serial/samsung.c:1776:34: warning: array
> =91s3c24xx_uart_dt_match=92 assumed to have one element
>=20
> -------------------------------------------------------------------------=
-------
> s5pv210_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> sama5_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> sb1250_swarm_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0
> section mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> sead3_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> sead3micro_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sect=
ion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> shannon_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> shmobile_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> simpad_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> socfpga_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> spear13xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> spear3xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 sectio=
n
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> spear6xx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 sectio=
n
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> spitz_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> stm32_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> sunxi_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> tb0219_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> tb0226_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> tb0287_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> tct_hammer_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 sect=
ion
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> tegra_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section mismat=
ches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (arc, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section mismat=
ches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (i386, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (mips, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section misma=
tches
>=20
> -------------------------------------------------------------------------=
-------
> tinyconfig (x86_64, gcc-10) =97 PASS, 0 errors, 3 warnings, 0 section
> mismatches
>=20
> Warnings:
>     arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suff=
ix
> given and no register operands; using default for `sysret'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>=20
> -------------------------------------------------------------------------=
-------
> trizeps4_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> u300_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> u8500_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> vdk_hs38_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> vdk_hs38_smp_defconfig (arc, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sec=
tion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> '+' in operand of '&' [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> versatile_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sectio=
n
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> vexpress_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> vf610m4_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> viper_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> vt8500_v6_v7_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 sec=
tion
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> workpad_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> x86_64_defconfig (x86_64, gcc-10) =97 PASS, 0 errors, 9 warnings, 0 secti=
on
> mismatches
>=20
> Warnings:
>     arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suff=
ix
> given and no register operands; using default for `sysret'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>     WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable
> section.
>     WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-
> allocatable section.
>     ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-o=
nly
> section `.head.text'
>     ld: warning: creating DT_TEXTREL in a PIE
>=20
> -------------------------------------------------------------------------=
-------
> x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =97 PASS, 0 errors, 9
> warnings, 0 section mismatches
>=20
> Warnings:
>     arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/entry/entry_64.S:1642: Warning: no instruction mnemonic suff=
ix
> given and no register operands; using default for `sysret'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffi=
x
> given and no register operands; using default for `btr'
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>     WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable
> section.
>     WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-
> allocatable section.
>     ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-o=
nly
> section `.head.text'
>     ld: warning: creating DT_TEXTREL in a PIE
>=20
> -------------------------------------------------------------------------=
-------
> xcep_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> xilfpga_defconfig (mips, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 sectio=
n
> mismatches
>=20
> -------------------------------------------------------------------------=
-------
> xway_defconfig (mips, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> zeus_defconfig (arm, gcc-10) =97 PASS, 0 errors, 1 warning, 0 section
> mismatches
>=20
> Warnings:
>     net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses aroun=
d
> =91+=92 in operand of =91&=92 [-Wparentheses]
>=20
> -------------------------------------------------------------------------=
-------
> zx_defconfig (arm, gcc-10) =97 PASS, 0 errors, 0 warnings, 0 section
> mismatches
>=20
> ---
> For more info write to <info@kernelci.org>

