Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C4C04A68
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 09:50:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.17945.1658915412226784184
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jul 2022 02:50:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 26R9nrTr021577;
 Wed, 27 Jul 2022 18:49:53 +0900
X-Iguazu-Qid: 34trDbJW1QPzVFbUn9
X-Iguazu-QSIG: v=2; s=0; t=1658915393; q=34trDbJW1QPzVFbUn9;
 m=AqlbLivKoRvQpW4azYXi3IHwVBn5qt8n3OVYetC0cnE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 26R9novM008064
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Jul 2022 18:49:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INi4V7H4AY4DyCk4w/BHPjarades3SGreyeGMh13IRb0EH6Cgl5NHTYhif2TqwHfXZpmvVo6nnnAmWOEq3uwclpLX1z/qh+n7XFqEfW86OprLnZI/0vUDiZHNiCRW+HzGKkNVT6C0aPh4WH7LhUkzMOS7zqDm8cdYYjWyVDfdsnvSsIdPWrZhxUPtrscMXKnPoAVCMzOiKzWZWOAuJP90ockSmi+suYMKSCdo6eEn3grmWfVoPZLB/BxQohdZss4lIIi1yPTHfO8IUvA5r0PH2x3vSeVqytz71AjFb9c3MYGrJj3sQcnNA2CtFkFHaD+c+M4Zgumd2aaF+c+8CB3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgZxiHgXg2Yjk30zkKi93wtInzCjznSKTQM+2nLMMFk=;
 b=TzIgRROC3hzHEvHs2XtiQ32xaT1CgGXn2bcV5l1a61M8IcpZRvqf4PAXehUqiLRN6S93wqGqRYVlICDD1BWFip7QLwnjwCx1Kv+c4lcsy3ZWS0bU/jwZWjYb0wdqWpnSru6SVQ1uF5hiE9PfWb4pbIYd5XRzqXXhdOXN5Bwcfc52RG6ze9ZlVAIke81SB1RIAcac4syaR1ljbhE7lxwgEDhjUXTkyPY8wmUOUoJ+5/njhWIUwONZTi8i8pZ8O7yk31yxQl8SOEFoo/SxbXG8AKR1xnCmxI0Op887uK8ARueBBy7MGwBIFhofPFzUm5FQVMQa1Vf6H1f4cOFCDoWW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.252-cip78 and v5.10.131-cip13
Thread-Topic: [ANNOUNCE] Release v4.19.252-cip78 and v5.10.131-cip13
Thread-Index: Adihh5vOdFztnca7T2OANtuepPuR+w==
Date: Wed, 27 Jul 2022 09:49:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420AA595A8605AA5580B39B92979@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae28c6a7-5cef-4425-f766-08da6fb557d5
x-ms-traffictypediagnostic: TYAPR01MB4478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Fqo4tUbPD2P0RPpRGgfsrKMpwO/hzFtXRuiLAV2nJ0ZEsQ6JZ6ENGYI4VZ9OtDd6BE24VaMDdRIjb27ykn6syp5nQFfYcJhV/8wtK5F0eZGPPt1CYyASCRcFGS6pEG6+JUrrNkls3XN+uvNCZwUu0n8icRRdUZ2yRU7DPNPnsZ3W28gQ+0FB24olZzvP+qIJfbJziLCus2h5aE0h8Za4aA1PjNxuc5Y4nZCHg8lrnQJDHPDSk01GdZtZ0ymmyIlms+2wy1+r092gfz41s1RZsNIhciBsUt4xQNlmLvkNVUcoxrfMxQ3tc3AvuAYGpGTRDXz+q/ohbNUQsCGm3GxEaqhdx56DlvmDpuLQui6bjFOn0JxUd/8yIg8nQdqTVwMqYEBW1D3ndwT6JY21W5jbWMIcrh6cScmzNPubQ2r6euDbLpFu/sBarVGhBv2Bk6dRzic1yuW+yAQNejhHYaAI+8OgNWyX8+sCq8h2DbF3UttJ21hTtoD/l1oWI5XJggi4qrgMZwEX+fhFZZL8TssLSPh46J2DcftMy3qfK2RY2CLdZECWgyYQ+xD8axTBE4vUHBW90dQe1znKFZFssryvH6K4jOFf0cHEdWBdeDWFbVfql7llHEhhfBbXwPooNmO/ZJMQFo71cF75HpAvGcKd1jCybTGwL/DoCslygKfmYBkqzsSPOhjx2bb44wZlfpS0t8i0UFAaGlahR879ChsV4rl0GQvMP/VllsmziId7kjPU/aAOCQ3Qp6FIvY7P9qTJqegJX4I+CuItjUF34M8qnxEN7ti3pPoAnq4ox627Xcxyu9dGQo8UfPerviOzR2HJDrMx5p8C1f065vnk/zl66A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(26005)(7696005)(83380400001)(478600001)(41300700001)(86362001)(66476007)(186003)(6506007)(966005)(33656002)(9686003)(38070700005)(8936002)(52536014)(5660300002)(66446008)(2906002)(55016003)(66556008)(4326008)(8676002)(76116006)(66946007)(64756008)(38100700002)(54906003)(6916009)(122000001)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VDhpeHlzZDlzclgrOTE5b3lab0Y2dUVkTE9YUEpxZGFieThIVS9Kdk0z?=
 =?iso-2022-jp?B?SXZTQ3RYMDBTdlJuUHA2Ukt3eVI2cUJ5cmNNY3E2TUZ4dHZmSnZnK0p2?=
 =?iso-2022-jp?B?WHk0QWlpalk4aTIwdG44TWUrU2JtWThTUzMrUmJ5eEgrVldNT1pidXdV?=
 =?iso-2022-jp?B?SXJ3Mll2NE5GYjRMb3ZGYkpKdE1Wa05RUnk5Vm93OGNhc2ppYnlvTFVm?=
 =?iso-2022-jp?B?bmJqTUJKcHJxZ1RPMCtPT1dhbUU3T2xrZVRlSktWazdsdkNVZmYyaThm?=
 =?iso-2022-jp?B?dnNXcVRyZFh6NndieVVUcXFsRENuT01oZ01hTHA2d2R3K0pYdXRRRFVv?=
 =?iso-2022-jp?B?S0VTMGRFODVOR1VkOG9nMTlrUVRlU3ZHL1ovUklsZ0p3b0xoRTV3UldG?=
 =?iso-2022-jp?B?ZHozRzlQTUs3RHREVEVTUGF3aWQyMzJzY2ZieEQ0czJBYUVvV0tDamJK?=
 =?iso-2022-jp?B?WUs1Wk9vdHVheWFXNTJzS0hUYzhxK2MvR2l4SnJoYnFxUUtzc0taRits?=
 =?iso-2022-jp?B?T3Z4aEVCWHFsck9lN3BZUDlqVGhTcXBYenkzaE80NTByTjlqcUJYVndw?=
 =?iso-2022-jp?B?MTdYTTFicGxCSWdnbm5lcVFUTUd1MU02WGNVdUp3cEl1T2lRSFhDdUt0?=
 =?iso-2022-jp?B?MG5iWUNNeWxVeDNKdVIzVG5pQWlLampFeFNaMDB0TnYxblhiVkx2LzNQ?=
 =?iso-2022-jp?B?cEN5b2xOUmhZam5VUmRqVmdWOGZsSkJjekZCYUxYbm9vRXhLUEQxcDBh?=
 =?iso-2022-jp?B?bytRRmFNdFdwV2JldXR0UGlOcTh5Q2RaK2x4YnVkSmk3a3dYUUZVMS92?=
 =?iso-2022-jp?B?U0tYWGk1NzFsbDMrb1V2ZjlrRkQxUnpBVE5ZVU42M0pPWi8zbExOSUNo?=
 =?iso-2022-jp?B?cXZGRm03Ykp2ZUxRWkRkVE4wekJWUk90djVIQ0h5YlRuQkZOdVkyRjBP?=
 =?iso-2022-jp?B?Sklza2ozUVJOQmxjcmRUZkxyYVlDakZaWmsvUDR6bWRFOGFha21vZlYw?=
 =?iso-2022-jp?B?c1A5M242eHArZHpLNyttcjNBelR3dXdHTExleTExSzdjU00wNExoZDda?=
 =?iso-2022-jp?B?Z2t0clNZMW5OWHRqdnRsREhRaDBXZlg3TnBZRDFBdStJWXV5NUs0UTdv?=
 =?iso-2022-jp?B?OXVDeWtNaytLamp0SklaUTN3S3J4bFIyak5BazZiSWVRc25abnZhdVdq?=
 =?iso-2022-jp?B?aW5WVk9NNmdUOGNGZ3hUMlpTMm9Da3Q5UC85NmN3ZVBiTUxMSFM2WUtJ?=
 =?iso-2022-jp?B?eURlMXlwUGliTXVDYnRGYWMzQzNQdXRqRlRBTnE0OHdyYmcyamc3ZWlu?=
 =?iso-2022-jp?B?NzVCTTFHK2hHMUNvUSt5ZHpBWnpuMEJmVXpsSHRaWGhPL3RHYXJjTENy?=
 =?iso-2022-jp?B?TmNabUtxalphTGp0M3RCT1dNU3JzRTRpbURwYnpXWGxvNy9tSWhJUWNY?=
 =?iso-2022-jp?B?K0l0UnlJdVhCTi9iYTR1amlvMFlaL053QWhoMlM4ZjZmdm81MGhnQStJ?=
 =?iso-2022-jp?B?MlZpU21BSzIxbENlZitwSkNjQVFkWFNZZC9YR1BBR2J3WjB1blp1S3FU?=
 =?iso-2022-jp?B?c2VrUmNra3hiSmtDSEJMaGZvVjZ2c2grZVFyRXIybzF3dnBGMnJ5K2Q3?=
 =?iso-2022-jp?B?ejlrY3Z1UURhc1Q3L3VGKy82Q1hoSFQ5OUFHc011TWZQaEdpaStuaGFE?=
 =?iso-2022-jp?B?bU4wa2RRV0w0Qk8wZGwvMW5oOTdFZDV3UHQ2SVhFVVNYMVoxb1EwOTJ6?=
 =?iso-2022-jp?B?ZStkMThyc092c3ZmRXZYVjNiajhndGdJSUYrZkVSazZGTkN2Q1hIQVlG?=
 =?iso-2022-jp?B?K1U4T3Z3VTRVNlJWMXpjaDJyelFvdElrMTVHdVIxZ1U1cTdCemRma3hN?=
 =?iso-2022-jp?B?YjJjWHNOa0VieTNqYXZacVE1akhMY2FrVVJxVGVTeEVmVVlEK3o4Q2pB?=
 =?iso-2022-jp?B?eEEzZjFxdmo1RGszazVvNEhVcEg4NmJBY0x6Z2JKVzEwTVoyVHhaeGp3?=
 =?iso-2022-jp?B?WVNWSVZnK2NKSEZnNVQzcFJwNHdPS2FFajJZKytiMk1qeFhLWTZBMFpH?=
 =?iso-2022-jp?B?QnVOdTFpaGVGaWI2cTgrOHQ5Ynp3eFVYZ05qb3RZaVkyZzFQQ1c5amUz?=
 =?iso-2022-jp?B?R2RTVi9YSHdTUVJEWmhJbFYwSnBIdDU0NUpRdTFoemFkR0JZdFl5Y29W?=
 =?iso-2022-jp?B?bTRNQ2dURkRNVE52d2JHSGJJMzQ5SkJ4OUV0OGlwTHh2RklNelA0OWlD?=
 =?iso-2022-jp?B?dkMvT1o3RmhUVXlEOEFnZWU2cmQzR3BaeGN3engvUVp2bm4rYStYd3ph?=
 =?iso-2022-jp?B?UU1OKzkzMXFNaXBMSyt1TnRVRGFDdFA3dHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ae28c6a7-5cef-4425-f766-08da6fb557d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 09:49:47.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 e/+hAlM2fSl3+64utLUHyiZL5AwPgJayrA1D06QNjqjK6sbqUlb+AEvYXDgiMqH4jfexQktDpSHkm0tnjLWsWhmzKyC6Pk3D2wD7PpJU4M/IEzQt7gUD+RM477oro4xY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4478
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Jul 2022 09:50:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8953

Hi all,

CIP kernel team has released Linux kernel v4.19.252-cip78 and v5.10.131-cip=
13.
The linux-4.19.y-cip tree has been updated base version from v4.19.251 to v=
4.19.252,
and the linux-5.10.y-cip tree has been updated base version from v5.10.129 =
to v5.10.131.

In 5.10.y-cip, fixes such as thermal, watchdog, ASoC, iiic for RZ/V2L as Re=
nesas ARM64 SoC
have been applied.

You can get this release via the git tree at:

  v4.19.252-cip78:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      f8a3b10debe25208205cdab53b1c95b7113fe8b8
    Fixed CVEs:
      CVE-2021-33655: fbcon: Disallow setting font bigger than screen size
    added commits:
      CIP: Bump version suffix to -cip78 after merge from stable
     =20
  v5.10.131-cip13:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      e217bcd84090afd29c7a9ab120fb3c8ff8844478
    Fixed CVEs:
      CVE-2021-33655: fbcon: Disallow setting font bigger than screen size
      CVE-2022-34918: netfilter: nf_tables: stricter validation of element =
data
    added commits:
      CIP: Bump version suffix to -cip13 after merge from stable with some =
updates
      arm64: dts: renesas: rzg2l-smarc: Move pinctrl definitions
      arm64: dts: renesas: Fix pin controller node names
      i2c: riic: Simplify reset handling
      reset: renesas: Check return value of reset_control_deassert()
      reset: renesas: Fix Runtime PM usage
      iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_par=
se_properties()
      iio: adc: rzg2l_adc: Fix typo
      iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()
      ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error pa=
th
      ASoC: sh: rz-ssi: Propagate error codes returned from platform_get_ir=
q_byname()
      ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add description for powe=
r-source property
      reset: Kconfig: Make RESET_RZG2L_USBPHY_CTRL depend on ARCH_RZG2L
      dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
      dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC con=
fig option
      iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
      dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
      ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
      soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
      soc: renesas: Kconfig: Explicitly select PM and PM_GENERIC_DOMAINS co=
nfigs
      soc: renesas: Add support for reading product revision for RZ/G2L fam=
ily
      soc: renesas: Identify RZ/V2L SoC
      dt-bindings: power: renesas,rzg2l-sysc: Document RZ/V2L SoC
      soc: renesas: Consolidate product register handling
      watchdog: rzg2l_wdt: Add set_timeout callback
      watchdog: rzg2l_wdt: Use force reset for WDT reset
      watchdog: rzg2l_wdt: Add error check for reset_control_deassert
      watchdog: rzg2l_wdt: Fix reset control imbalance
      watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
      watchdog: rzg2l_wdt: Fix Runtime PM usage
      watchdog: rzg2l_wdt: Fix 32bit overflow issue
      arm64: defconfig: Enable additional support for Renesas platforms
      thermal/drivers/rz2gl: Fix OTP Calibration Register values
      thermal/drivers/rz2gl: Add error check for reset_control_deassert()
      thermal/drivers: Add TSU driver for RZ/G2L
      units: Add SI metric prefix definitions

Best regards,
   Nobuhiro


