Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160B9C5320E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 11:50:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.208659.1724068226303744317
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 04:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=TFw8pDdX;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1724068206;x=1725277806;bh=cj
	U0aNaRhfEeKeJ/acKiBUC88NakYfNgaBousQt2Rg4=;b=TFw8pDdXrbgMJx8k3frols/wPBk+Is+s
	0NT1Nw8M5GF8HGL+YkuO3pf8acjUfeSn1tTozj9V8HHy7uiqdHK6XjaOAIfkf8oBhNmIpY4WfC4Nb
	aI37OV0ysMevO6Dft2nml06TmFqoiTdNTK4LcBfAVEuLluGXKYnxkx9VGmT733xryWiBCPicRc3dm
	/9parZIvNg2HjeZ72kJ/C3xhnXbvMgSde2VBGF5fxYB/dcnf61mlWI+1hmYW656zkDfC/ILl5ULET
	pz0DbJuScWV8c0JoYfcPOxwNXApjzCiimXV+ceJgLXbXCCy24P9rfnpxbf2Tuuly43SaBA8F/PVSk
	6w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 47JBo5c12586022; Mon, 19 Aug 2024 20:50:05 +0900
X-Iguazu-Qid: 2yAaUsYslKgBiLgnGS
X-Iguazu-QSIG: v=2; s=0; t=1724068205; q=2yAaUsYslKgBiLgnGS; m=dqKLwdgXAHyfohwn+V/JYa9hTdfaQgjHJIwsW167Z8Y=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 47JBo30v1433162
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 20:50:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oScG+tRc2LbbxCsNBJFl//pjkwISbGznggV668R5uh724ulRrgA5n7/TIYLA72GrmeUOV9emOPE+Un6SauKS6hs3p7WALfUb6x98rkVVqDCQjWm9DfB77US75BrV1fQ4HOtgjkafvofdDjTVH9oQbm/9+bFrceksChdnSHouAj9sSGK15YnzbkcY78wxKCCo/Cuj8oHb6xGAwxU5/ooI0T1TbYv4Mgu3xiUQBfGr4vBYOo0X0wZvRMQ4ZCbkBfQLLUd5IUsMy80n8ymApgvVCeOZHLab/oY2LK9xgSfvbVewDScYHv+hY+hYemFOioSSJkXhvxiG0nhcKj6o1NhxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krU1Fcp/Kl0jFugUDG2g6GqqcNj6p0Dz2KAhQM194HQ=;
 b=sJCU9oSc0IveVV20SwLqvZ6K1ZJc85lTysfzpycxSZSVHBlimrMU9q9BROx2FKThIlcIauhn/rfuFi72qo2FKw9Ci1kyBHDtpxo3dbaJa5nVgS8qco5fAaqZymucuotilXbivFxS2xf15BVjDWV3VHC7yMocaV5Mybgz9NTBQftzXgOjtw+XZ9LDg7xmFUJxUNTAOnkbDNorLV+q05y8WOXmTiW2vpJVT7tT7QyvmAIgIT4h6uF3VgZ7zHEQYffqlJZgojqiigr+XR5s5iHK8HUqTFZ+HoMpcEduLTgtn3cs1M3fEwR4Itlh09UegQq5CptmcgkZDnF98pgNKGSs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.320-cip112
Thread-Topic: [ANNOUNCE] Release v4.19.320-cip112
Thread-Index: AdryLbnvt6vmoVw+ROqrro6qJ4OO0Q==
Date: Mon, 19 Aug 2024 11:50:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E01DB7288B98B91E4861928C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSOPR01MB12328:EE_
x-ms-office365-filtering-correlation-id: 01f4e742-fd89-4490-751b-08dcc0450eb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SWtZSHYrQkJJWFBtby9Sc0tCR0RSaVdNMEdHT3hhKzdlOFNDVkc1Q25R?=
 =?iso-2022-jp?B?dTFrQ245U2d4STF3ZS9zdk83K3krcGlUQzNwTW0vM0FLZUtpTHp3cEZT?=
 =?iso-2022-jp?B?MnNpZmN2VUVxTXk1RlBmY0YzOUpha3pKakZzeWx3VFZzcTZJb29ZR0tK?=
 =?iso-2022-jp?B?aFNMVG5tNldHT1hzZEZGVXZ0UGpweVhveEttMkxuV0hqanlRVStpdDd6?=
 =?iso-2022-jp?B?b3NxQnpUOHg5c2VMODM2bkJzRTRCMjd1K3NCWnRObEJkTDlzdGYwd280?=
 =?iso-2022-jp?B?VFB5YVpOMmowejNHQlg2QVlaSU04K2pNd0lxb09ZaFh2R2xNUVZBSjFr?=
 =?iso-2022-jp?B?aEFkaFkvL0RJRHIzcUZNcjdFdGVNY1FMd3Fvdk8wQUw4S1VMamtLYXJs?=
 =?iso-2022-jp?B?TlRPUll2NGR6UnpnN2RHdUpkVUczTys0cW5Sc2c1a29XeDFjQjRscDFS?=
 =?iso-2022-jp?B?eG1LR2dvaExSaVVBZXNpRCtJQUMwKy9ra2lWSHBkUG9EKytNb2wyZTR2?=
 =?iso-2022-jp?B?Y25sMlNEazBjR3dPYVZza0JYc3hENDdNcDMyWEt3aHoyd1pkNGJ6OFov?=
 =?iso-2022-jp?B?ZWJXY2hZZkJQRXVIQmxoVlREdk5SQU85bUpXNzIxUXROOU9qUENtMnNZ?=
 =?iso-2022-jp?B?ZGVLTkNwUzBGamZXRkR5RGM0NEVjRkJDS1BhT0ZjK2k5M0dFM0lWYmtC?=
 =?iso-2022-jp?B?V0pMekNUNG5QQVc0d2JGUytQMjdzeHpac24za05jYldaWlhvWnQ4Z1k1?=
 =?iso-2022-jp?B?cHJGSFJMOVRPSGFSN0diNUVTUS9CcGJBZkVIWjdKbkY1SkFOVWxJQ3Jh?=
 =?iso-2022-jp?B?a2pyeFNrNEF0SDBZVjlTY0VObk9qT2tGSFY5TmxHUDRFTlN6b0NCUmJ5?=
 =?iso-2022-jp?B?bE5kTWh3ZFg4VUtSbTIxalJaS1R5aU4ydXkwYVFkZFRiRmRCNVRkMG1R?=
 =?iso-2022-jp?B?bUJuYisyNXZPdkVaaHdvZzU4QmtGOUlaUHdHTkc4ME5NWThjR2JnanpL?=
 =?iso-2022-jp?B?Nmp0RDBiMXVyai91YWJYSENEeWNkK2ZReHZTVklONWxYc3hOYzlqall1?=
 =?iso-2022-jp?B?MVdERVM5eWRpVU4zK05PR1hNZys5QnhpbUYyMGwrTjNROW1PbVhtSGtO?=
 =?iso-2022-jp?B?QlRGVkwvbWtkWWdwTGFOeFZYMm5uVzlFcndvY082RHBxWXd0dDhOZlVv?=
 =?iso-2022-jp?B?Y0ppZ3NpZXdKTktLOG9HbWhNYVJwRE8vbDB1NHVvMzVNbXJOY1Fza3Fi?=
 =?iso-2022-jp?B?SVlmNmkwVEhOc1ZXK2wzejBOcHVXb3dRYjZPTFpGdVBMZHBTa3A1SS9a?=
 =?iso-2022-jp?B?aW1PMnJCL1Z4UlloL0x4cVE5UmxuWHVjL2lyTm1rb2tXL29lSlY2OTJI?=
 =?iso-2022-jp?B?cllCVUtSL0NabHZGOVN4d2xObDF5K091M29oNzdvVWtWU0xaamZtZkVD?=
 =?iso-2022-jp?B?OEFQalpmNm9NQ3lVS3oxQUlmWHE0bTUvNUlXRmUwNUhzM0FWTVhyMFc5?=
 =?iso-2022-jp?B?Rk0yOWRVTmdTdklmdWZnY1U2Qnp6NnI5MmVObjNIZ3d3SUdoUTlobVhS?=
 =?iso-2022-jp?B?czdNYkNhdCtOaDhBS05vdjhPNUlsNHJjc3B5Z3ZYK3hYcnlkd0VCZG5R?=
 =?iso-2022-jp?B?MHArRFJsNk1VNzd3bHhPSUQybWQ4QXRpLzMvSU5JSnRFQXFmc01Na2pu?=
 =?iso-2022-jp?B?NGQ3WnhQanZwSHZZUEt5VUVudlh3VlREcUVVNlNhSWloZ1l1WWtXUHB1?=
 =?iso-2022-jp?B?V0lXby9IU05mc29WVEdpRzVNcXZJeTJWbEVhYTk5MDB6RS9HdllXK0xk?=
 =?iso-2022-jp?B?MU00Q0sxZE9EZEpGYmVjU3Zkem1Fa3lJNTlhUjgyMGxIdDc5NWt6QktH?=
 =?iso-2022-jp?B?Mys0ZDhmcmR5eTdhdDl1VC9zcVJlNzdHSnJUQ3lTTXpzM2p5b0lXT0VG?=
 =?iso-2022-jp?B?RC9lVVI4TmJQOVorWEJHbm9Dbkw4cTU3aTRJTFFvZXVPc3RyNTBQcXpo?=
 =?iso-2022-jp?B?SnhiajRnVHdjSDczVXRUclRlVkFqTmF2UFNYdENvSU5LbHlHbncxTDl2?=
 =?iso-2022-jp?B?VUd2Mk4vNXpjOWphK0EwVnhFVkl3TkdubWt5azloNVdzejF2Yno4ZytR?=
 =?iso-2022-jp?B?dUg=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NzVuVSsyWllxM3lBRUZJZ0FUQzNvN2o1bWxmTWd5QmdxTVQxenp2TW9i?=
 =?iso-2022-jp?B?c3FUMnAzQVVjS0hhcllWd3Nuc1FNWEdKMzZNcUh6NWszWFFTSVMyVDBC?=
 =?iso-2022-jp?B?WTJOZjBMdnlzS0Q1Z3o1MW5aUG9DNmxlRDdOMjYwNXRFL0l3RGhubU4y?=
 =?iso-2022-jp?B?V1hJZDdPOGJ5YjBLVndmbUZOVk1uZlRzSXlNQTNzZGFGR2JkVXc4c2Mz?=
 =?iso-2022-jp?B?dkFCeHpWZEpBekVSUkdueVd6UGp4K3FiWjlCZjNDSFdqRTh1T2EzVlYv?=
 =?iso-2022-jp?B?SlVWNTNSVWNidER6L1pjcWt6S0dtSU9Sb0E1djhKYVhZcm9kU0orVGhv?=
 =?iso-2022-jp?B?dUFIK1MxLzFEaVptaXNldVJabzd3WTNNaFIwQmtXZ3hpUzcyNmFPcytB?=
 =?iso-2022-jp?B?bFBtMGZtaGgzbFkyRk91YitIQWYydGhVd2F2cCtLd2lpY3l5ektKQWZ4?=
 =?iso-2022-jp?B?QTAvT1JvUnVTN0lDbXV2Q2JGU1EwUGE0M2V0akcyamh3SG1sbGR3R00x?=
 =?iso-2022-jp?B?ZVR4WWhZZ2E2ZDEyZWZGRElxUHl1eGpFVlZwNWozN1ROS2dWdEpJcWtR?=
 =?iso-2022-jp?B?ZGxXaHRidlRCYWgyTmN2QjBFMUUxcjhLNnVjQnFPTFAxQm5VYnVvSDhB?=
 =?iso-2022-jp?B?b3loTW1UWHVKaW1kckQ2bUxtcXlNT2NrWHllano0Y00yTkU0U0dpd1ZZ?=
 =?iso-2022-jp?B?eEtSd2FlRUtsS3A3WGU1MmhkNVZHRGI4SlNReTV6SGxEOHlFclJIdnJD?=
 =?iso-2022-jp?B?Q0s5TnlLdkZpcFNYelZ0VWJoSlFCY3dtVzBmSzhHcjZsY1Rad2lwWW4x?=
 =?iso-2022-jp?B?STEveGh0Z20vMVFCTndpRiszWFF0eGN2NkJ5eG81MnhhWDdQNmd1dkYr?=
 =?iso-2022-jp?B?U05lZnlSWTRQU3J5MW5FUkx5WGRwSVFNM3FMM0VKWXZwd1poeFY1Yml3?=
 =?iso-2022-jp?B?U2o5cmNzTWtZUTlDWXlkVGdGaGYvN3FkSkhsUHNRbDh2MFBTbzlFUWND?=
 =?iso-2022-jp?B?aUc1OFR6cWRQYXRRZFNUWEJ1U2c1YlAvczdhZFAxUkZ2cVhBeWZsKzdi?=
 =?iso-2022-jp?B?SzJCSXlYcTMvSWkwT0lVcVpLY2RXazgrcDA5OXJlSThLS0Y4NlBIQng2?=
 =?iso-2022-jp?B?RS9GUEZMZFpWYWZvWXFDVG5FMmZjckdvVGF6YXVCTUZDMVljeS9ESG9S?=
 =?iso-2022-jp?B?d1VCZGpSQzhyaUlHZmVVaWFJM1VOc3lORm5TZTg5OCtqbk1FUTRxYnB0?=
 =?iso-2022-jp?B?VFVLR1plS0N3TGx5dGxXUDJwQm9iajE5Z0ZZbis0ZkxUckxHZ0xjSVpR?=
 =?iso-2022-jp?B?YzFZbjM2S0ovcHFNUHlYSUFpZThML2F0WVRiRTRIZW94cEFwRHhZUzNl?=
 =?iso-2022-jp?B?eFpmSHFaVFpqczJQWDRWUHVERXE1K3c5dG5IZWFIQy9JcVFERjRndllz?=
 =?iso-2022-jp?B?YmpUK0l3ekxBMVJjTERpaGJFR0d5UlAzSEt2K3Fmb0E0MVREL2NEMnNi?=
 =?iso-2022-jp?B?cXJUMHg4Vm51YnF4M1pxQkFWUnpuZExyRDMyQWtHOHJVMFdDbEI0aHdk?=
 =?iso-2022-jp?B?TUhjdDRKb3RxZ2dpeGl1UW5NeGVMQ2hsNE9YekJNcG1DR0dSbVlpcXE5?=
 =?iso-2022-jp?B?V1lQek9FdmNrSWs1VzFyUmZ6MTRCMHJPTFZ6Rk8yK0xYcVZvenFFdkFP?=
 =?iso-2022-jp?B?dldiVHdKelpsejdyeEtZbWZvMlhJamxvM3JXVEllNngrWFo1TzlzV1RP?=
 =?iso-2022-jp?B?WU9MNlI2d0R4U3d2MFphMHJ3ZUw3STNhQlRhK0lNak9oTmI1L3dwbko0?=
 =?iso-2022-jp?B?ZXQxcDlPRjRBd28vQS9iZ2piazRNT1h6ZXRDbG5BWnlqTUpMUU9xaS9R?=
 =?iso-2022-jp?B?MEtTSnFqTDVGK2pmWjg1NnRaMWxkOUcxWjlaaXVSYzZLQlJjOHNRT2Er?=
 =?iso-2022-jp?B?dHoyWUZEMzZmWk9jWmR1TnlJWW10b1V1WmVtVUc5SFM0Snk4WnNVVFRh?=
 =?iso-2022-jp?B?M21zd0xxWkErMkdvaE9DWmlEWXNrTFg4OEptT0NwR1JCSjU1eUNmS0l1?=
 =?iso-2022-jp?B?WSsrK005TnBDOTdCS0MvU3l6THhMd1FIMDZ3dXJ3M0FoS1BvOTY5Zmh4?=
 =?iso-2022-jp?B?SzM2eUxyaXZySi9tcTJsWGVGQkJMVUZvS05KNWxiT0xpOE81d1FQbWRu?=
 =?iso-2022-jp?B?ZVluUEZnaERBWXc2N3RoUlpZdFR4b2ZCT3ZxL2hybWlyVmx0em5lUitZ?=
 =?iso-2022-jp?B?em53c0VpR2ZZYW1sRHhSSUpKQkU1aUZJUVRpeUsvWGJURVdhWXRCMVBQ?=
 =?iso-2022-jp?B?NDMwWWNoYUNnOVhTZElKV01DZTFsMGxNV2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f4e742-fd89-4490-751b-08dcc0450eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 11:50:01.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA+Y4LYdAqGlCkrJJbJjbKyFk5/ap0BBtAuN/uIOdwyllvfV2RHhc4w8/haOlugwB/sevf4Jm/AexdeaAABEZEo4AGeZOhJIXLLk/Q11NXlILYdijkbPusEIh+lVEYJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12328
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 11:50:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16798

Hi,

CIP kernel team has released Linux kernel v4.19.320-cip112.
The linux-4.19.y-cip tree has been updated base version from v4.19.317 to v=
4.19.320,

You can get this release via the git tree at:

  v4.19.320-cip112:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      72fd755c494bf69e165c988b15e91295569c7938
    Fixed CVEs:
      CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs de=
ntries
      CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set =
element timeout
      CVE-2024-36484: net: relax socket state check at accept time.
      CVE-2024-39487: bonding: Fix out-of-bounds read in bond_option_arp_ip=
_targets_set()
      CVE-2024-41007: tcp: avoid too many retransmit packets
      CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race=
 is detected
      CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()
      CVE-2024-41017: jfs: don't walk off the end of ealist
      CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path
      CVE-2024-41034: nilfs2: fix kernel bug on rename operation of broken =
directory
      CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing res=
erved bits in the descriptor
      CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate
      CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed pac=
kets
      CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach
      CVE-2024-41059: hfsplus: fix uninit-value in copy_name
      CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregi=
ster_dev()
      CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure
      CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data chec=
k
      CVE-2024-41081: ila: block BH in ila_output()
      CVE-2024-42101: drm/nouveau: fix null pointer dereference in nouveau_=
connector_get_modes
      CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in =
wb_dirty_limits(), again"
      CVE-2024-42104: nilfs2: add missing check for inode numbers on direct=
ory entries
      CVE-2024-42105: nilfs2: fix inode number range checks
      CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_r=
eq_v2
      CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_=
free_inode
      CVE-2024-42119: drm/amd/display: Skip finding free audio for unknown =
engine_id
      CVE-2024-42131: mm: avoid overflows in dirty throttling logic
      CVE-2024-42143: orangefs: fix out-of-bounds fsid access
      CVE-2024-42145: IB/core: Implement a limit on UMAD receive List
      CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds
      CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from del_tim=
er_sync() call in isr
      CVE-2024-42154: tcp_metrics: validate source addr length
      CVE-2024-42157: s390/pkey: Wipe sensitive data on failure
      CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow
      CVE-2024-42224: net: dsa: mv88e6xxx: Correct check for empty list
      CVE-2024-42232: libceph: fix race between delayed_work() and ceph_mon=
c_stop()
      CVE-2024-42236: usb: gadget: configfs: Prevent OOB read/write in usb_=
string_copy()
      CVE-2024-42259: drm/i915/gem: Fix Virtual Memory mapping boundaries c=
alculation
      CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispr=
edictions
      CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()
      CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()
      CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() =
on error
      CVE-2024-42285: RDMA/iwcm: Fix a use-after-free related to destroying=
 CM IDs
      CVE-2024-42286: scsi: qla2xxx: validate nvme_local_port correctly
      CVE-2024-42289: scsi: qla2xxx: During vport delete send async logout =
explicitly
      CVE-2024-42292: kobject_uevent: Fix OOB access within zap_modalias_en=
v()
      CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_cre=
ate_block()
      CVE-2024-42297: f2fs: fix to don't dirty inode for readonly filesyste=
m
      CVE-2024-42301: dev/parport: fix the array out-of-bounds risk
      CVE-2024-42304: ext4: make sure the first directory block is not a ho=
le
      CVE-2024-42305: ext4: check dot and dotdot of dx_root before making d=
ir indexed
      CVE-2024-42309: drm/gma500: fix null pointer dereference in psb_intel=
_lvds_get_modes
      CVE-2024-42310: drm/gma500: fix null pointer dereference in cdv_intel=
_lvds_get_modes
      CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after=
 hfs_alloc_inode()
      CVE-2024-42313: media: venus: fix use after free in vdec_close
      CVE-2024-43830: leds: trigger: Unregister sysfs attributes before cal=
ling deactivate()
      CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb st=
ructures
      CVE-2024-43856: dma: fix call order in dmam_free_coherent
      CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree
      CVE-2024-43860: remoteproc: imx_rproc: Skip over memory region when n=
ode value is NULL
    added commits:
      CIP: Bump version suffix to -cip112 after merge from stable

Best regards,
   Nobuhiro




