Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BAFC8303C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 01:29:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.12456.1751506167327619295
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 18:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=RDNBM1Hg;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1751506150;x=1752715750;bh=j2W0ZzNl7A7st7E1B5gYbxo9Jdxb4XW5+t2oHWY
	A40Q=;b=RDNBM1HgdEFYGhsUrazHsID3sFCZuA58pktWHeesRFrxsh8rvpAkf69nZbdvUmXDUjDWR
	CQ1Oji13OYLB8/m4ZsaxdcJD3IM4BUbRUeoVbtPn151eWMmqrF3Y6mFtSb5+QhQp2SjeyykDM+LbS
	hg8fOfQLo/wkvxzcTPghmY9BxRJ4pXPW4OAxqJNF9nHEw95Wc5705N+Btk2ZYj+izAmd/jduGkIeY
	AKEbIIaS5uDdboBOwU3Y3vWM62xUeP8NkTOdGYmMyWXszMiNCb7MID7MQ349+B/2Nj83HojrI2hrS
	qvrQJrinjxI2yjBAcYk0uZzzxlxNh9y9hu+PsWtyTA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5631TAO34138594; Thu, 3 Jul 2025 10:29:10 +0900
X-Iguazu-Qid: 2yAb5TJlinWIiWnNTl
X-Iguazu-QSIG: v=2; s=0; t=1751506149; q=2yAb5TJlinWIiWnNTl; m=j0Cgt9gbMZjL/oQkshrGYJQQQJLF8f+FyI4xysSeVtE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 5631T8h9024951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 10:29:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN3Bs3nUTqKDJ2+uozt/US6echWDocsKJp2kQb0V+jbI/yAsIr6yeGTXJnldi47tzY4Z6YrAYo335BSt0rRm9GB6NGrhF3liifEOhCrv/HWegejhN/ORbCH/S//9Q3Dh9UNTi+O3QF5xA5KuDEEZcnTa0vxCL1IuUYbXJJ0yuybmRog0EYYTWFUVgXJ8imxvz71mWYBOfWo8eRtie/FfuD4UyT8SY+gjFqOU01bVtN7cZgsaI+QnG4PsSsFS8KjfZvclwPr1+t36ZMv/k0QbNZOee++QJ0yAAp/0FvuTAUNGC/lO6rfAcQyNjsNwgceBBAlyK4+SHfDvVPVh4XsDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSoXpEcuDYaRjNeBX1C8xVsPhCVOdu4Fd9uvQd1169Q=;
 b=lmzEHfI5x73Mr+ntA6wysxbjo2b1z4RkvmQSmpvufNjO/VeOf1oFmiY0rpub6m4LToXLyRrIK0Budhkp1cp9gbHUehYQQfCCGRfQVfDDmn74bTj+ptOsxSW8DYl/T/Sa1sx6ALmXx3J4rCBFHeGlb9BwKTEMY5+j3Qc4oV6sEEgE3Kc6kqKRL0pyJvd9UMBAbI9VGuVZaFfq4yWFxjnH8de5RmkDiwfZTTmSPy+tolOjODM/Mg0NfMnssOCgEB7NQFB/V37YrL55zGYqJEVg+7ZRwszsr42PTQEiAjjhXnj+sLbAl87pE92lMJ3rV0RIY5pDy2gi6nZIuWWioDAHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Thread-Topic: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Thread-Index: AQHb6z0aZDDltp4XXU6l3B9dfuI1D7QfiYfQ
Date: Thu, 3 Jul 2025 01:29:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189EEA4EDF0CE5D2D292309243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8617:EE_
x-ms-office365-filtering-correlation-id: 9429dbc8-1267-4353-52a0-08ddb9d0ffb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Vmg3VFJUbXRWUEdwZjF4NXF6WkNMVjkzNzNhTVFNeURBdWZGYjVhMng4?=
 =?iso-2022-jp?B?STlQTDU3RFkzNnlvbm5jUm1ncC84SWcxeFhJdUNXcUNmS2dyY3pKSWpy?=
 =?iso-2022-jp?B?SnQwT1k5VU1lSmV3WDJ6RzlhUlB3ZmtqNmUweWNrd3d1cTVOZGROUjkv?=
 =?iso-2022-jp?B?bC8wVk40ODB1ZjU1T1JldFg4OW5KUURySFdVcVVEc28yaTRkN04xRDl5?=
 =?iso-2022-jp?B?UlkxUUpsMlAyaEV5UURPcVM1RGx5NHhMc2wramFmS0E2L3BHT0hRandR?=
 =?iso-2022-jp?B?Um80Z3JTZDVwbkViNWkzUVJkSEh5cm5ydEJHUGJnYTJKOWFZd0NkWXVO?=
 =?iso-2022-jp?B?K2NaeGYrdkd6VEN6UmE2ZUVxWFMxSU5lRU51cHpzYzZVYkd4M2NCNjZV?=
 =?iso-2022-jp?B?YUhmcnhqQjBSTjJTUXM4cVlHUWFkSUZVL2tRUHRnbUp5dGZlTnQ3blNE?=
 =?iso-2022-jp?B?cVVXTUlYeWtLdUpZZ1RDcUpSV01tc2xNcEZDVkVtc1gvSy9UU2N2aE1H?=
 =?iso-2022-jp?B?RC95VmFzZ3NwZ1QxY2M5aE5WVjIzMGJoRmFoVzNyMGFLWDdhS3dIVWcx?=
 =?iso-2022-jp?B?RkQ5TGZaWUc5d0xBeHo4aVhiMnhiRHZhWDl3eHBoRGQ4eWlueGdtSW5o?=
 =?iso-2022-jp?B?b1NUcTdaOWg1WU4yT2Ryc013dFVaa2duK2hrT2xETGpzYWRoNlBsUU5C?=
 =?iso-2022-jp?B?REdtdDF2YkJ2SHU2VVJPelBZZWIyNzFlRHNFY0Q2b0lnM0RmUW1FVGli?=
 =?iso-2022-jp?B?NFA1VkE5eU14bERJZVZXNm5NSWZ5WE1SODJYVTBDbTQyb3NWWVB5eWZG?=
 =?iso-2022-jp?B?b0ZjMHNyYjBSWGpGOU9YdHhyd0FGQThBTjh6UFdWTEF2V1VFRU05MTVx?=
 =?iso-2022-jp?B?b3hCanphaDZrdUZKcnlGQUpUdHhBc2Ivd0toeEg5Ry8vK1A5NHhJRkFv?=
 =?iso-2022-jp?B?a0lkSnRKNG9zKzQ3aWpEQWxodUdWc0JlMk83dCtCNWw1N0h0QVVpUERD?=
 =?iso-2022-jp?B?dWdEa0w0UVpyMjJteXpHR0s0OTc2LzgvNDRHWDhQL0JtSThVam53T3RS?=
 =?iso-2022-jp?B?eVJrOENKb2xGR25PSy9uWCtvakdjY1ZYeUluWTQvVzJoOXhITERIb1Zr?=
 =?iso-2022-jp?B?ZFNMbEs3M3BxY2NjaW95R01QanZVeUlPMzFMT1gvY2w5RlpBa0NQYmZX?=
 =?iso-2022-jp?B?ZHd4VFlmOWdDalB6TDRzUmZwV09WS0JGeHpaTDhmd3FURnRiVUs2VHNP?=
 =?iso-2022-jp?B?aXMxTnFFbnJGcVdNZ1kvZUE0MHl5R2xZNmF1OTJmSGF0T1YzVlB5SVEy?=
 =?iso-2022-jp?B?T005TCtFTEd4VXh6V1RIZTA4dy8zNUg3V1M4cUh1eEpxRmZxcHF4bUNJ?=
 =?iso-2022-jp?B?azVGUWxVNzhZSXFmSGZNZzY3Vml5OUcyb3R0SllMZ3czK0V5Wlk1Y1U2?=
 =?iso-2022-jp?B?YWw3SEFVdmFhRFlGKzB0bVVaMnArbHNxMEZoclFVamw4MGNSLzlOb3ow?=
 =?iso-2022-jp?B?RVErNzlZWWJMRHNwNU50Zmh4NUJIZEQwTnNTTHlvN05IM2xlbmlZbVkz?=
 =?iso-2022-jp?B?M2w0WWlXUHRHcTN1akFGR2FaNWIvNU1MaWxQUUt5VXIzRjRENFoya0Y5?=
 =?iso-2022-jp?B?M2tDMVhFOVE1eFdGWWdYemswT1N1YnhSV0JzTXJDME0yTUYwbXZDdE9P?=
 =?iso-2022-jp?B?MktSM1h3WHhyTkZsSnVqZWhqTXhSUlJSc21SRWhvcHR2cGdIWnh5cmpZ?=
 =?iso-2022-jp?B?Y1JYUzE3WE1kTFUwNHd3aSt1bTVSNzZjNGxpUmM3aEErQzUwaWFjZXdu?=
 =?iso-2022-jp?B?M2VTY2pZUnk3bTQzSW1oSm9xdi9lSWMvbTd1QzhDV2VYbnFReE9yM2lZ?=
 =?iso-2022-jp?B?Kys1MU5DTGZ3b3htWnZSRHJtUGxjejBMa20yVzBjZUhESmRBNFRPeHVV?=
 =?iso-2022-jp?B?UnFLREh5b1NpaWZKV0RCSjZiczc5bll2UVVmSytCZm4wb0hOS2lLcDBr?=
 =?iso-2022-jp?B?eU5BNXg4ejI3eUVtV2pJM09yRjB3TjRxbU9nVncrUkQ0TkhHWXQ5Rk1q?=
 =?iso-2022-jp?B?dWVuRHNZeG9nVktaMGZhVm8xTnNyNXFRTWxWOE5NdTBCazA0eVRoZmhu?=
 =?iso-2022-jp?B?bnlBVDRQNWtsOGJoaGd0dXE4cm1tUVpSTDc1SWpDSml2WFpzU1BYYUJh?=
 =?iso-2022-jp?B?b05RPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eVJoWFVTSkt4c2FBTTBaNUIxNVMxNUtZZnJ4YVo3Mis0U1BkTHMvWXd6?=
 =?iso-2022-jp?B?ODAwUTJWNW1sYy90WnhJQzBwbklyTWM3ajJsUHVOS2E1QmVJWTI1c2xY?=
 =?iso-2022-jp?B?T0pGenlPOEpQK1ZWTDI1LzlBK1JWTkd0VnRueEFvQzV5Q2E4dmF3ekdJ?=
 =?iso-2022-jp?B?SUk0ekxRS3g4LzBUYitrWFo1eVljNlpSYnU4bktRYURaajV6UFNxZ3BL?=
 =?iso-2022-jp?B?eHZRVHM3M3dBeDZGU0lEUi9OcjRXN1Q5VnBYZFNJUjVkQnhkR2ZQT21J?=
 =?iso-2022-jp?B?UU1LS3c2OWpjckpkUzM3cFNBSUlqS2hsbE9XWmgwZlBxTGgyV0FlU3JE?=
 =?iso-2022-jp?B?Z2pQeWlmRGV0dkFTMkRxQUtVM1krMEZiQUZ4MUYyd3ZWQXpoMDBYOEJY?=
 =?iso-2022-jp?B?TlZSSnRIWWU2aXplR2luZWg4RXUvc3h3MkJxenJPU0c0cUorb01RbFNO?=
 =?iso-2022-jp?B?M3kzbGVPSGNGaG9IYk55TzJQanMwZ2hiOTRscm9YOGJ0UUNTNlBMa1hp?=
 =?iso-2022-jp?B?UGRyRzBkS0dXdHduR1JUVmpsbTZDOHl4Ukk0Smxmb2ZuV25JUzVHQ0Yz?=
 =?iso-2022-jp?B?QWlPbkVyS0dqbTNDUkNMQlBuQkp2cm43L2liNEltSEFQYVdqY0VBMHM4?=
 =?iso-2022-jp?B?VXpOVFcrOHdQa05zOXIzaXY2VVh4SldnQktrZWdGU01CSmJyUkRSSUVP?=
 =?iso-2022-jp?B?VkdCN0g3WklxZ1BpdVJuTmhpMlZyTi9QNU9OK3ZjVnRDYXdBM2duVUt6?=
 =?iso-2022-jp?B?NVEwUm9jZDl3ZnhjY2o0Y1BQMUJEZVVGVXZXM21pdkdia3p2THdha2xO?=
 =?iso-2022-jp?B?MGdjSnRrcUF1Q3NudHRvR0dvdW5TL1o4ZjBYUS9pS0tzM09BWXlqd0My?=
 =?iso-2022-jp?B?L0FzeXhTcWdIOXZqTTE5ZHVlQWJmbkVxTnN5UUUvZ1M3aCtueDVLRGVa?=
 =?iso-2022-jp?B?YXQxL1ZybzFyT2tTc1FQek5jZVhkd0d1UmlicXJ5SUl5cDNKN1dPSTFy?=
 =?iso-2022-jp?B?VXNiR21FVy9kc0tyd05sVnFldGhRODlwazBoUWcrNVZMdVlzZ3A5Si9O?=
 =?iso-2022-jp?B?elN3MjRDajljM1l3M3dTVGlDQ0ZyTy9pNkZia29FeGw0eUxaNHFYR2hG?=
 =?iso-2022-jp?B?Q04yNmNzRU8rRWE3ZEJ3NjF4TUdNd1pVRUlqSnROSC9uZHhacmM2em1N?=
 =?iso-2022-jp?B?YWRzUTUwdnpsdkx3RlFXcXd5Q0paaXBhNTRORkJXaTJZeVQxMmJIK1BC?=
 =?iso-2022-jp?B?RTFHeDRITUNCV3ErQXJxRExzZGJkMHZWZUdabitZTnN3T2xkUVR2UDVK?=
 =?iso-2022-jp?B?QnlVdno0WHNodFpJRFNDM2E2ditZeU9yMEhBVjUrU2IvVjdLOGpMZnNC?=
 =?iso-2022-jp?B?dUxDb0dQdGYzRCtaOEx3RmM2UnplaVI5OHJ0U2sxUUVGMWVTZEtsczU0?=
 =?iso-2022-jp?B?dWZJNlhSMWN0dzgwczVWY0tuOUJHWWFCeDIyN3FMTElEM2pLdFBOc2FV?=
 =?iso-2022-jp?B?dzVJejRpbUpNUlZlN3pLa1ZIOXlXTlc4UVZubDd6TUVSVUp0cmZhR1hN?=
 =?iso-2022-jp?B?UnRQaW1YYTVsRVlROXhqcFpKdmdUV0VVV1VLNVJtb0E4ZXhqeWIxb1A2?=
 =?iso-2022-jp?B?NWpqYU04SlRiWndhdjJrUEJoYUdFOVdxRFZueGJOdGJMQzA3cFFoVTIz?=
 =?iso-2022-jp?B?UVFua1h5aGlJQlI1ZG9QS2lyeURwa2M1eVVTczRaZnZnM2JGYzBISU9l?=
 =?iso-2022-jp?B?dC80OEtVWDZ5eTBOQkh3WHBuOW94Nk45WmgyTWVkVlNLb1BVZkRzTytv?=
 =?iso-2022-jp?B?RnVPa2V6OGZYVE9hRXlpcXR5eDl5SWk1dHNaZ2Mvdldia1lUeFNJYk1O?=
 =?iso-2022-jp?B?MTlzK05oTUJrQjJVYmRjT0dleXZ2OTVPWWhWR0dXZU1URjAxQlBTMmp5?=
 =?iso-2022-jp?B?ZFpjUlVtMlNiczlyNFF3VWduS2p0QXN2L2RZaG1PU0RXWmwvWnFlSW5P?=
 =?iso-2022-jp?B?dGpuK0t4ajF6d21RdlB6QzVsZnpFL1hGRGdzVkJVMWJId1VuYjVkS2R4?=
 =?iso-2022-jp?B?QXFaVnoxZW10VHZ0dGlVcUZEU0Y4OUNBV01pWjJrZ1Z0YTJQUEh0YUdl?=
 =?iso-2022-jp?B?ZXByTVRrRTlLL3hvZW9WcVJFMmpPM0xWTEhkbTlGTVFvbjVqS0NLNXFm?=
 =?iso-2022-jp?B?cktrOW90NTZZUnpXVWFLOC81S0ErOWxaYU1DT0dwYnZiQzhJaklLNS84?=
 =?iso-2022-jp?B?MWFvaGtpWFpRWnBvQzR0cFhvUmxMN2EvSG0rNkx2Q1lTQTg2KzR4NG14?=
 =?iso-2022-jp?B?SjhDR3ArVXVUTnlnQzRkMVRpWTRmdXpoUUsrSGZ6eElaVXZyTG8yT1VW?=
 =?iso-2022-jp?B?QVZLUkE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429dbc8-1267-4353-52a0-08ddb9d0ffb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 01:29:05.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjVB/5DZ/nAKHLS0b08zDmXlMQF+CdFTp6iCvMJJ5Jg/8WQ9dzCRhb3P42L8MkJek6lKIhtQKxFu6PN4woUgLfalPLlZyXlcjKDdO8h7xhx48SoXm8pgkQnGW98/x5qz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 01:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19318

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Wednesday, July 2, 2025 7:35 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
>=20
> Dear All,
>=20
> This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC int=
o
> linux-cip 6.1.y Linux Kernel.
>=20
> The changes include updating the device tree bindings, adding the GPU nod=
e
> to the SoC device tree, and enabling the GPU on the R9A09G047E57 SMARC
> SoM board.
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (2):
>   clk: renesas: r9a09g047: Add ICU clock/reset
>   clk: renesas: r9a09g047: Add CANFD clocks and resets
>=20
> Fabrizio Castro (1):
>   clk: renesas: r9a09g057: Add entries for the DMACs
>=20
> John Madieu (1):
>   clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
>=20
> Lad Prabhakar (3):
>   clk: renesas: rzv2h: Refactor PLL configuration handling
>   clk: renesas: r9a09g057: Add clock and reset entries for GE3D
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
>=20
> Tommaso Merciai (5):
>   clk: renesas: r9a09g047: Add CRU0 clocks and resets
>   clk: renesas: r9a09g047: Add clock and reset entries for GE3D
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
>   arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
>   arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
>=20
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  4 ++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 49
> +++++++++++++++++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 15 ++++++
>  drivers/clk/renesas/r9a09g047-cpg.c           | 53
> ++++++++++++++++++-
>  drivers/clk/renesas/r9a09g057-cpg.c           | 40 +++++++++++++-
>  drivers/clk/renesas/rzv2h-cpg.c               | 13 +++--
>  drivers/clk/renesas/rzv2h-cpg.h               | 34 +++++++++---
>  7 files changed, 193 insertions(+), 15 deletions(-)

I reviewed this series, looks good to me.
I can apply, if there are no other comments and test is green.

  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/190=
3593678

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


