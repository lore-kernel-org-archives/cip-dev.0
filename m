Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF1E6FE49
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 03:13:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.968.1725678823215090770
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Sep 2024 20:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=NyzCVO8O;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1725678804;x=1726888404;bh=9Q
	lilo53pi50CsDV37X0ce+x0LjgCuaWAcjr86Zm4os=;b=NyzCVO8O5/t8OBctNGCa2oKoCemkzMA5
	14+8l3xT35fH5osGKG3OIUBO8FTZm6ICVs+Zar3sOr3ViIOVJ7kYlUEpyaW0CupXGwlHL7gl6ntvn
	3JJ66eAEt9L/z8dc8hK+PEWW4y+Bu+o4mQ/Ra6frtsDZCqI5//AhfwU2JO/Fb9Lv+NPww4cgPKDU6
	HBxPwwHLr14uDGWE0eP7FXAAvYdN7vKcxBTwS9+ZCK2g5aEsCvattAIXVkOk/ZO62sVLRZrWGBdAR
	gcxEnfKHsOSjARd+Rzc16aLWuJwpo4xg859zWvqDUbLiy4JjGfjPuSbQofkMETqHX+USYt0wNYODj
	jw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4873DN6w590616; Sat, 7 Sep 2024 12:13:23 +0900
X-Iguazu-Qid: 2yAb2N10Z8NlVbP2jg
X-Iguazu-QSIG: v=2; s=0; t=1725678802; q=2yAb2N10Z8NlVbP2jg; m=wvvz3vTE3W8Izu4FNYpFN6XFLOyXTVjEAo1HJ60ovgw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4873DKlR3359095
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 7 Sep 2024 12:13:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kae9GegjAvZPnYYvr8Xu6IyY+hEOAJsD+WelScEQOsN/yvrWQVxemJmMXQWvC1wwScynat3O1sibaZhI3Xolb9vvSODwCY4viMetPAoeOnMOXGeNISF5MuYF/H6tfh3ylwWQDne9MqARapfK3cYvjrjIM72kly+kZvh8mqyhFG32TDa3boCNJDklBHvax0YqcEcV+wWcr7s78HBMiBc13f6u1ZWqwIyqKSqKQx0e5jUyXrK6hzZp8TmdUZjQnMZq4vixkOUdY6s0cbVWEPJN2abS2qdzkziryNkX24r5kqMJyPcIKn8xx1q+lfFR2F/zjAO3LO3YUa72N6NS1167dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynz3PVP62VLTj0hHuCKy59pve8aiTVP0IhcxKJXcd54=;
 b=olCznL1EcToHo7EqzDzuvWSTzJtztGkv9C15ODENhM5c5AJc7goeiLfMK//rJ7yvdx7Wcrj3guOkiDlOxkwfec3O4mUOVNsGOyhmLidva8DiORix2C811F7BQrAYYu9fTmeqkYXXNwnomQPnoSfG6/z5mQJNg1AhVVBHFhoEB05nAtk4MolTkpl1+892jUBCG2KJTlnYLHfiSOHdijQ3XLv1bwU/kg3IkV4dwhYYc6AzjYiI5jGx4/og7BtP1xHTBikb6HT9QKly0fP31dvoH4s6Kx+A6JOx3MThL26NKVonf85SU1IZ0wz2Kg7HWGxU8MZwMtNAdOZKuufWdIUgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.224-cip52 and v6.1.107-cip28
Thread-Topic: [ANNOUNCE] Release v5.10.224-cip52 and v6.1.107-cip28
Thread-Index: AdsA03iYdMrJk+YDQ/e87b9DhLhcYA==
Date: Sat, 7 Sep 2024 03:13:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638811FB38FD6C58E090A532929F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS9PR01MB13150:EE_
x-ms-office365-filtering-correlation-id: 347e2724-5cdd-42b8-33bd-08dcceeb054c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?amh6VWM0TmpMTUFia3F4TGxWb2t2eUFQVnNNd3lrVkhMdkM1aUdDQ014?=
 =?iso-2022-jp?B?b2F2NEl1Ti9TK01sa1lGbnI3TTlXa2wrMkRmUXMwQzBZajVWb0lyOEQ2?=
 =?iso-2022-jp?B?V1Y4aXhlMTdSRGllOUgyVC9vZGtqN2FCRkZiOWIrN0lTZlFOVVpLR3BE?=
 =?iso-2022-jp?B?OW9EeHEvSVN3Uk04RDdVUXYzVHJCNXZqbWIzK3MwVVp5OExIZXF2azgy?=
 =?iso-2022-jp?B?Y2hheDQvL0t2dDRwTjlCdzZoRm9LZHVscHFRbUtHaVI2Y3hKWjRhL1lX?=
 =?iso-2022-jp?B?YUNiYm1mTDU3V1ZPR1dIMUFnQWxHWEg3RloxRm12ekc5OGZqQzlKWXZO?=
 =?iso-2022-jp?B?OHQzcmNKL01sdUpNeDRueFVSazFqQUhGNVpzVENSc1BiVjNQdXJ3aGlU?=
 =?iso-2022-jp?B?bG9QbVZTZnNzVlpNb1d6TVo3SENLWGR1VW5sRFlZbUdVYXBkanplRTgx?=
 =?iso-2022-jp?B?eWg2MFBoemJZL1FHZzdicjJTekNKMTFmQm1ORnJkQXU1T2VEMHFaUkhR?=
 =?iso-2022-jp?B?SXNxOWdUS0lWMXlBYjdSSmJ6TTZiMW4zMEJaOGNhaFBCSE5sRm1vS29t?=
 =?iso-2022-jp?B?UmErbmJDaGpPOTlsbHJTbm5OOFdxSWZQMVhQdFU1NGt6MjFLdFJZMDdZ?=
 =?iso-2022-jp?B?aXVBc2Z1YUMyQmNWQlRDZ2pEWVE1N0ZzbXJSNS9VYUpqdmsvWDBDVU5k?=
 =?iso-2022-jp?B?S1JHTy81cUJMRG5EeW5XekJtNXduOUsvZzc2cWVNVDZCVmx3blV6cTRs?=
 =?iso-2022-jp?B?VkNOdXkwVU1mZjYxRWNUaVZuZUJ3RmJvbVVUUDV3L2tibURJVVNNUUdW?=
 =?iso-2022-jp?B?WkJaanpqRWdYeTRabHd4amg0QktOWjYrdC9jNStlZllRem9wcGJPMzRN?=
 =?iso-2022-jp?B?VHVtYUJ0YzkvTUlKYTZ5M251RFZGL1FCWkVEZUE0SHFoaDgzb0lKSWpE?=
 =?iso-2022-jp?B?Ui9qVHF3eitEOVc5NHlEb1diK1R0RUprTmpWa0diWUpkRDh2K2lySGZR?=
 =?iso-2022-jp?B?TWw4UVU4dWkya28zUHhoY2tTRmVGVi9CbE5IQ05yVjZBMko1d01kMEVw?=
 =?iso-2022-jp?B?SGZFT3RvMEI0SkphTitJeDg1azF0QXZNWGhGL0wwVXNyaFY4WENvVDV2?=
 =?iso-2022-jp?B?Q2lqZ2w5N2NCckMxeGlvTXFzWnJoMkpYaDNXZEZEMGR6MGJOVVhPcWRv?=
 =?iso-2022-jp?B?TEppUTdoOXBENVc3SlZPb1NGakhvb0hONVdVZVNKcG1sYlUvRHZnYjR1?=
 =?iso-2022-jp?B?aVhVNzV3Y2NRelBScUI2cHA5dmlmVEhid0h1Tzdqb05xOVFlTDBTNlA5?=
 =?iso-2022-jp?B?NXlyK2N1MFZaeFQrcTU5M1ZSOE1wNFlkQVpFQUNpdHgzN0NNTFdVNVJi?=
 =?iso-2022-jp?B?bW9JRlJrMlNYZmVuLzlIVUVMYkhFREtIejVhSUxPUVFHVnF4dWM2VkhE?=
 =?iso-2022-jp?B?cVUwditnZ085NTJURG1NbVdkZ1RjWUxydmwxbHFseTV3WnJvVzNjMWpI?=
 =?iso-2022-jp?B?L1l2K0RkaTdXZkVSMzYrK0NQcEhveGJScFRPOXlIS1VrZmNMWVBWSld4?=
 =?iso-2022-jp?B?dWt1UmRMRGRmS2tQRmlMSU9PMzhFZzVQSkdJUnlCcWgxd1hFdGNNNFg3?=
 =?iso-2022-jp?B?NHBFV0VXTFRSMlg1a01zSGpuQklNQzVadEl3SDBqS0plR1dBcDlUU3NX?=
 =?iso-2022-jp?B?SVgvamJreExQaE9PdEhPeTRWeFZzMHNzdFA4RzV6SEpkY2podGJXS0da?=
 =?iso-2022-jp?B?NWlFems3Nm5menRmRjF5Q0x2QXA5eDRXZzdKYlJscGFyMmpDY1l3Z2Zy?=
 =?iso-2022-jp?B?OHovOE5lc0pSa2I2SVZ6SHNRUVBzYlc2R1FHS0tJMnEvSnRHb0s2WldO?=
 =?iso-2022-jp?B?MjYxYjJta3dxaVZuM0RrYU1Wbjk2M3kwUzhQUUNSeTRveHBFaFNVV3Zx?=
 =?iso-2022-jp?B?QWNmdUJqUlZqUWZ2bDVJaDZDUW5pWk4wampibzRYOFhaZmxRL1pIamtY?=
 =?iso-2022-jp?B?QUcvS296YjN1OFRCVVZSdEp1K2c0OFRodk1yTmo2TitUcUU0NUNzOFps?=
 =?iso-2022-jp?B?cUE1SndMS0dzcHpsTmdtK25SUExvSGh0VXo3WDlCQmxIeTJXeGNQMEhF?=
 =?iso-2022-jp?B?QkI=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MklYMVBlSkJ0elpOQm1ibVYxbVMzRHJSVlRUY04yRWhWdTBlV3E4Wm9x?=
 =?iso-2022-jp?B?cUthMHV0QnFQT1N5bjFFT3lPc0d4ZFJMS3lkeEtybHhZZEgzeHFrVEIw?=
 =?iso-2022-jp?B?aGxKV0Y1a2F5a0xIa0NuNkRSY0g0YTBrc1BLUHNoUUduMnQ0a0ZqT28v?=
 =?iso-2022-jp?B?T01BN0FBYnFjQ1lFRmtEL0lUeks1djRWWnVYbnkwZ0tVYUlNTEFEMzJr?=
 =?iso-2022-jp?B?cjJybFVpeW5HUnFrcmRBSFZmL3VNeVZiYWhjR3RySjFsV1dGa3FRNUJh?=
 =?iso-2022-jp?B?SUFFU1paK3dDZWt4YWhNQlh4WXdjUDJDOFhJOWVQZlpsenUxcnExRG1m?=
 =?iso-2022-jp?B?VXdDdHpzSUFldFF4V05lWGpXcnRtRjVjcE8zcmVQTVFMWUF2R05wYTNs?=
 =?iso-2022-jp?B?RGJ0YWRpb3JIQkcwdlp5clhzVFFZZHk3YTl1aktvVGdvSExSNk9iV3c3?=
 =?iso-2022-jp?B?TUxLUmpyR1gzV2plRGptU3Z6V1VPRXBTc1E3SUNaamlYZHlSc0xLWVJx?=
 =?iso-2022-jp?B?Z0gzeHNVZlFtbGIzQ1ZTb29jVitKUlJNMDFxbmxEemh1TGxWd2wwNHpZ?=
 =?iso-2022-jp?B?VGVyWllRdkxYSTVyR1U0WjFCdFdMVmRRYjBCTUhjRklaYnVCNmtGM3JK?=
 =?iso-2022-jp?B?UjNjdnpiWjg0eGhhMGt4U3hZWXUyd0VVV0Nva2w1RXA1RHVoZ1Z3WElQ?=
 =?iso-2022-jp?B?R2ZDS1BDaitlM0txSTBQSFZGVXhrcC9pbVpIQjZsanNveXM4RVE3QURG?=
 =?iso-2022-jp?B?RktEelNWOWZmOXh3VktyTUZiWkNNK1ZHWGdPSElvaUdGR2dwQVhxMlI0?=
 =?iso-2022-jp?B?VmNWNXlkc3BwdlhPYmF4czlWRTN5UUthZGR0ZUUzVFlWTzkyTW03d3VG?=
 =?iso-2022-jp?B?QWRwOXN0b1RoUWMwYm02amxXS3gyOUlvSk1PMDRsZERRWkxaRDlDWkF0?=
 =?iso-2022-jp?B?cUJ4S01SdTdNeHNucVhnck94MjRML1hzNjJ6NzBPdWhoUTZHcWttUnV2?=
 =?iso-2022-jp?B?M0sza3pSOHkyTnN5TUtuSTgrcDlrUnRYRlpTVWRsdUhwZFh3cXd1dmNm?=
 =?iso-2022-jp?B?QU9nbU9OMVdNOU51THZsYmp0d3NISGcyVFg2MXdRbngySGY4SjY1THQ1?=
 =?iso-2022-jp?B?bEhUZWptWkQvUXdYRG9KanQ5bjFtQklqWmpGU1d6QmR4M1dXRmRVOUZp?=
 =?iso-2022-jp?B?My9mUTBNNFZCbXQ0aEk2emtQdVdkbUUzRzI2NzErMjlTV1l3bzc0SmV0?=
 =?iso-2022-jp?B?c0s5bTg5K2htU3AvQm85bVRzVHgrOGNkRmNESHBBeTNPSzRRZWx1OFE5?=
 =?iso-2022-jp?B?eDh3UUMvYWhQQXVub1JmLytMbUhmNUxYeHBjUnh3UGRBVlc3ZzdkeC9W?=
 =?iso-2022-jp?B?bGthMFl4cWg5UHBvUklxaStvN2FGWU50eW1KcHVoVkdDVG43V08zcVJW?=
 =?iso-2022-jp?B?Y0tOQWZwTy92ZjIrUHFqUEVDYkVodUlISXpZbko4M2ZVekd5aERQZWRa?=
 =?iso-2022-jp?B?WlprMzJpeVZEK0h0UmxpeUZyOVAvaDFrc01SdURUL005MkJ5TzFvd2NI?=
 =?iso-2022-jp?B?NzhiamlBSDZsU2VUTDRjNThzWEg2UUJJUjZmWmdMdjFPVVUzU2xYTWNz?=
 =?iso-2022-jp?B?T3JRaU9ZT1MzemZJQjlXcTNoMVdGcWpzNHBWV1l3QUxIU0VIUWFUWmRw?=
 =?iso-2022-jp?B?YnlZNFFzQ3pPUm5rVmxsUVJSTWhRSzgwKzF1REMwdnloUzBadlA0cFlP?=
 =?iso-2022-jp?B?R1JtK2JnR0RwVWVYRzB2WnZKdCtnelJpUjFWRjBsRTNLcWFFUzhTYzZV?=
 =?iso-2022-jp?B?S3N5WDQyVmlpb3NXWFNBdndIdWwvUXRQNVhrOTVsZ1dZaCtqbVllSW1H?=
 =?iso-2022-jp?B?VGtQdGZuNURpQklqdDY0MHZtQ2lhc3VSUDllM1ZKOGtyandsT3BQR0lU?=
 =?iso-2022-jp?B?NzlKaE1jaGtDbzNuZ3hGbjVWcEZBWXhBSSt2ZXVCYUdpUS9HcExRVW1P?=
 =?iso-2022-jp?B?aEFJYUd2bFVNS0taWk1TUmFEK0hCUlZtWFdYdUtwcWxnT3lnU1VnalJy?=
 =?iso-2022-jp?B?UzBpT2NaNG0zL04xNWhRbEpvQ0hQYnM3K2FpSlE3TENRYmx0YWRKWVk3?=
 =?iso-2022-jp?B?bVJ4V1VCdnFWR1NrOWFkVkJwMVZ6L2VxUXFEcnpHTVNWbTV1TXVBMXBr?=
 =?iso-2022-jp?B?UzkzR1NKUlZjbnVLUGFQM0I2bStFeUt1WTZ0aTRabm1Lb2V2bStodkNU?=
 =?iso-2022-jp?B?b3hJK25Pc1VQWHZYTDlvTm56WlVYdklHa3A4d1hyM2tLWFNZVjgzaGhQ?=
 =?iso-2022-jp?B?dGZxbkt2bzRCSjlqbmZhWjRYbXVpRktxZmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347e2724-5cdd-42b8-33bd-08dcceeb054c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 03:13:18.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX9GavJPZmXL88LoOqjtjr6L8GBc+Up22J7CztiEQmx5Lz/7lkqANYgJXICyE7/CCUOeu0cyo10bqrA35dZYOhdATQUG+284eX/69lIhnfs2gz2QkkJb/wzUqYVyn5oj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Sep 2024 03:13:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16860

Hi all,

CIP kernel team has released Linux kernel v5.10.224-cip52 and v6.1.107-cip2=
8.
The linux-5.10.y-cip tree has been updated base version from v5.10.223 to v=
5.10.224.
and the linux-6.1.y-cip tree has been updated base version from v6.1.106 to=
 v6.1.107.

NOTE: This release is a special one to release the cip-rt tree.

You can get this release via the git tree at:

  v5.10.224-cip52:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      a73978e16f87d704893e4b3a637be257420d43f3=20
    Fixed CVEs:
      CVE-2024-42287: scsi: qla2xxx: Complete command early within lock
      CVE-2024-43828: ext4: fix infinite loop when replaying fast_commit
      CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_cre=
ate_block()
      CVE-2024-42289: scsi: qla2xxx: During vport delete send async logout =
explicitly
      CVE-2024-42310: drm/gma500: fix null pointer dereference in cdv_intel=
_lvds_get_modes
      CVE-2024-42297: f2fs: fix to don't dirty inode for readonly filesyste=
m
      CVE-2024-44952: driver core: Fix uevent_show() vs driver detach race
      CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate
      CVE-2024-44965: x86/mm: Fix pti_clone_pgtable() alignment assumption
      CVE-2024-43880: mlxsw: spectrum_acl_erp: Fix object nesting warning
      CVE-2024-43908: drm/amdgpu: Fix the null pointer dereference to ras_m=
anager
      CVE-2024-43914: md/raid5: avoid BUG_ON() while continue reshape after=
 reassembling
      CVE-2024-43871: devres: Fix memory leakage caused by driver API devm_=
free_percpu()
      CVE-2024-44948: x86/mtrr: Check if fixed MTRRs exist before saving th=
em
      CVE-2024-42292: kobject_uevent: Fix OOB access within zap_modalias_en=
v()
      CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() =
on error
      CVE-2024-42281: bpf: Fix a segment issue when downgrading gso_size
      CVE-2024-42286: scsi: qla2xxx: validate nvme_local_port correctly
      CVE-2024-43890: tracing: Fix overflow in get_free_elt()
      CVE-2024-42306: udf: Avoid using corrupted block bitmap buffer
      CVE-2024-43841: wifi: virt_wifi: avoid reporting connection success w=
ith wrong SSID
      CVE-2024-43889: padata: Fix possible divide-by-0 panic in padata_mt_h=
elper()
      CVE-2024-42276: nvme-pci: add missing condition check for existence o=
f mapped data
      CVE-2024-43879: wifi: cfg80211: handle 2x996 RU allocation in cfg8021=
1_calculate_bitrate_he()
      CVE-2024-44971: net: dsa: bcm_sf2: Fix a possible memory leak in bcm_=
sf2_mdio_register()
      CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb st=
ructures
      CVE-2024-42285: RDMA/iwcm: Fix a use-after-free related to destroying=
 CM IDs
      CVE-2024-42305: ext4: check dot and dotdot of dx_root before making d=
ir indexed
      CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree
      CVE-2024-42304: ext4: make sure the first directory block is not a ho=
le
      CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()
      CVE-2024-43883: usb: vhci-hcd: Do not drop references before new refe=
rences are gained
      CVE-2024-43893: serial: core: check uartclk for zero to avoid divide =
by zero
      CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispr=
edictions
      CVE-2024-42259: drm/i915/gem: Fix Virtual Memory mapping boundaries c=
alculation
      CVE-2024-42126: powerpc: Avoid nmi_enter/nmi_exit in real mode interr=
upt.
      CVE-2024-43861: net: usb: qmi_wwan: fix memory leak for not ip packet=
s
      CVE-2024-44969: s390/sclp: Prevent release of buffer in I/O
      CVE-2024-43834: xdp: fix invalid wait context of page_pool_destroy()
      CVE-2024-42313: media: venus: fix use after free in vdec_close
      CVE-2024-43867: drm/nouveau: prime: fix refcount underflow
      CVE-2024-42312: sysctl: always initialize i_uid/i_gid
      CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid u=
sage
      CVE-2024-42288: scsi: qla2xxx: Fix for possible memory corruption
      CVE-2024-43829: drm/qxl: Add check for drm_cvt_mode
      CVE-2024-44968: tick/broadcast: Move per CPU pointer access into the =
atomic section
      CVE-2024-43894: drm/client: fix null pointer dereference in drm_clien=
t_modeset_probe
      CVE-2023-52889: apparmor: Fix null pointer deref when receiving skb d=
uring sock creation
      CVE-2024-42308: drm/amd/display: Check for NULL pointer
      CVE-2024-42267: riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fau=
lt_error()
      CVE-2024-42283: net: nexthop: Initialize all fields in dumped nexthop=
s
      CVE-2024-42309: drm/gma500: fix null pointer dereference in psb_intel=
_lvds_get_modes
      CVE-2024-43849: soc: qcom: pdr: protect locator_addr with the main mu=
tex
      CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set =
element timeout
      CVE-2024-42301: dev/parport: fix the array out-of-bounds risk
      CVE-2024-43856: dma: fix call order in dmam_free_coherent
      CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after=
 hfs_alloc_inode()
      CVE-2024-42114: wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM val=
ues
      CVE-2024-43830: leds: trigger: Unregister sysfs attributes before cal=
ling deactivate()
      CVE-2024-44954: ALSA: line6: Fix racy access to midibuf
      CVE-2024-42302: PCI/DPC: Fix use-after-free on concurrent DPC and hot=
-removal
      CVE-2024-44935: sctp: Fix null-ptr-deref in reuseport_add_sock().
      CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()
      CVE-2024-44944: netfilter: ctnetlink: use helper function to calculat=
e expect ID
      CVE-2024-42290: irqchip/imx-irqsteer: Handle runtime power management=
 correctly
      CVE-2024-43846: lib: objagg: Fix general protection fault
      CVE-2024-43860: remoteproc: imx_rproc: Skip over memory region when n=
ode value is NULL
      CVE-2024-43907: drm/amdgpu/pm: Fix the null pointer dereference in ap=
ply_state_adjust_rules
      CVE-2024-44960: usb: gadget: core: Check for unset descriptor
      CVE-2024-42272: sched: act_ct: take care of padding in struct zones_h=
t_key
    added commits:
      CIP: Bump version suffix to -cip52 after merge from stable

  v6.1.107-cip28:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      d5cc54849a0b793a2413dcd5f31b45d9907066ab=20
    Fixed CVEs:
      CVE-2024-43845: udf: Fix bogus checksum computation in udf_rename()
      CVE-2024-44986: ipv6: fix possible UAF in ip6_finish_output2()
      CVE-2024-45006: xhci: Fix Panther point NULL pointer deref at full-sp=
eed re-enumeration
      CVE-2024-44947: fuse: Initialize beyond-EOF page contents before sett=
ing uptodate
      CVE-2024-44983: netfilter: flowtable: validate vlan header
      CVE-2024-43884: Bluetooth: MGMT: Add error handling to pair_device()
      CVE-2024-44988: net: dsa: mv88e6xxx: Fix out-of-bound access
      CVE-2024-45003: vfs: Don't evict inode under the inode lru traversing=
 context
      CVE-2024-44987: ipv6: prevent UAF in ip6_send_skb()
      CVE-2024-44938: jfs: Fix shift-out-of-bounds in dbDiscardAG
      CVE-2024-44977: drm/amdgpu: Validate TA binary size
      CVE-2024-44939: jfs: fix null ptr deref in dtInsertEntry
      CVE-2024-35937: wifi: cfg80211: check A-MSDU format more carefully
      CVE-2024-45000: fs/netfs/fscache_cookie: add missing "n_accesses" che=
ck
      CVE-2024-35966: Bluetooth: RFCOMM: Fix not validating setsockopt user=
 input
      CVE-2024-45007: char: xillybus: Don't destroy workqueue from work ite=
m running on it
      CVE-2024-44982: drm/msm/dpu: cleanup FB if dpu_format_populate_layout=
 fails
      CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl
      CVE-2024-44991: tcp: prevent concurrent execution of tcp_sk_exit_batc=
h
      CVE-2024-44999: gtp: pull network headers in gtp_dev_xmit()
      CVE-2024-44995: net: hns3: fix a deadlock problem when config TC duri=
ng resetting
      CVE-2024-44940: fou: remove warn in gue_gro_receive on unsupported pr=
otocol
      CVE-2024-44990: bonding: fix null pointer deref in bond_ipsec_offload=
_ok
      CVE-2024-45002: rtla/osnoise: Prevent NULL dereference in error handl=
ing
      CVE-2024-40972: ext4: do not create EA inode under buffer lock
      CVE-2024-44998: atm: idt77252: prevent use after free in dequeue_rx()
      CVE-2024-44985: ipv6: prevent possible UAF in ip6_xmit()
      CVE-2024-45008: Input: MT - limit max slots
      CVE-2024-44989: bonding: fix xfrm real_dev null pointer dereference
      CVE-2024-43897: net: drop bad gso csum_start and offset in virtio_net=
_hdr
      CVE-2024-44946: kcm: Serialise kcm_sendmsg() for the same socket.
    added commits:
      CIP: Bump version suffix to -cip28 after merge from stable
      ravb: RAVB should select PAGE_POOL
      net: ravb: Allocate RX buffers via page pool
      net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
      net: ravb: Enable SW IRQ Coalescing for GbEth
      net: add netdev_sw_irq_coalesce_default_on()
      net: ravb: Refactor GbEth RX code path
      net: ravb: Refactor RX ring refill
      net: ravb: Align poll function with NAPI docs
      net: ravb: Simplify poll & receive functions

Best regards,
   Nobuhiro


