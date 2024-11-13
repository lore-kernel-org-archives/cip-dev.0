Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827CD597C1
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 00:22:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.587.1731457360811854812
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Nov 2024 16:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Qxs76atU;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1731457340;x=1732666940;bh=bp
	BwnKr4xgwLib+pU3bV0CYz2EJ0A/Fy8rnlwq3Zzz8=;b=Qxs76atUz0ZtNbmckUVlkoyAtlgaBGux
	mLbcp2hEYxA7VP9JFfF6h7/CFXr9jWLyv8KvIyvqdNQTJzw1tUI9bXNrlYkQylA/XzrZ4GCGeGLYe
	cGMCykMtR+NUM/ZqjFI+VFXcC5LgHWlkffSocs5AJinD3Xwbg0oXpngAzQTgejaB7SlczWe2m05Wi
	AF1EcTt+AzzGiKDtZgDMKqMnvOV5HJq3BDsNQsm5+KdujRIzC76L8/gZaGDHkbEzkd2vyG6AOev+W
	Fd4KvSePh9gq+9XVL7djUzM3nU0qcNiYVGc1XH2GAYfBECA3HqiLIkX/xmPbZRJsCDfQn5V+Os16q
	hw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4AD0MKn12564303; Wed, 13 Nov 2024 09:22:20 +0900
X-Iguazu-Qid: 2yAa7nzfcMBQWoqDos
X-Iguazu-QSIG: v=2; s=0; t=1731457339; q=2yAa7nzfcMBQWoqDos; m=DdKAArYAvrtFQLcO9adKOYv2SAiMrqxPjGVj92p3Dyo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4AD0MItr1127322
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 09:22:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S898aLfmYkbRtjatiUeC2WSkxIfY6/H1uKSYU2dqZVYPYAzpBHuYrQOHdE3eVzROxWvS7K5/GmVhYVgl8LmX8LKPQeZsOfVHLMgrCqQih0y2t6VCDljTc2CF+ano7Yg2u9QE8c9PbtKV7A5fGfmZl43rPniodHxU55Io3LMkl+/yCiJoT/UWHZNf5CYvw669wfFWq4fw8b/4Istjg6Bsk8KxXNwJ48nT9pDfcNfHNYPF1xjmALSoNxpu9rnRMcdETexNti0QOPxUedlGo+VswyzT57cH3mBYfMRAGMzRP0vb0sl32o5hOK7DyagJewovNoFkNppjXfo8Vzz2uLgO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZK6gFTxB+iWBlH2Q4ufHYVOWALgWKK9DDpe3lmhF4U=;
 b=yOkiRZMgcyXhz6iqLki1kuGXthjLoXalfSVdgVHYBA025fI2Pt98uPsL4BCO5ucngVtjarst1pOrFq3t9YXRAa4RtYJOcdYU/E2crziEesLO2pMGkSFxECLTw3c7TcWO4zWF6YEdCh4PDpMe1qJqlzVJqSNabxDx6wxHk9WpIBFa7NIJdnE9gQ9u2POu8lBaddjwvnk6iw3j/lLIiypS9DEoixJk1OexVHjw8mTdln5hLTSVCytjjnIFua580RRusPbVND3fWmRTq4g0ZU2WwLZIjG96BngNFA/ZxZbYky2NXQZOO3Kb15gEFaY1y82Y+Mm2O9SjT4qTs6bj2BU4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.323-cip114 and v5.10.226-cip54
Thread-Topic: [ANNOUNCE] Release v4.19.323-cip114 and v5.10.226-cip54
Thread-Index: Ads1Yf1URfTbHyuMSkCZmHELOzlvXw==
Date: Wed, 13 Nov 2024 00:22:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391DAC4B6A1B643A7D2218D925A2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OS3PR01MB6642:EE_
x-ms-office365-filtering-correlation-id: 49ce2cac-16ca-4ae7-04fb-08dd037939ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cldQRWZ4VFd5cXJudHQyRno4Um1TQzFZZit0b3k1M2JCSWU0Vm1vRzdU?=
 =?iso-2022-jp?B?ZW1Lak43a2ZyY2RTbmxmQ05yS1pqZDBDeld0dDhLNUZxT24ybTl4c3pr?=
 =?iso-2022-jp?B?UFZTUTA1WVRTSzRWSGxoTXJQWFlCL0JlN2VPSmFLZ3cweUx6dktMVmFM?=
 =?iso-2022-jp?B?bFZ2b2dmMDloblpPK21TRHlpNFcxTUpVSW85ZEw0Qng3eEZmSUREYS9m?=
 =?iso-2022-jp?B?bjhMWEVBaG02N3l0MFBBSnM0VXZ0SW9iSDdWYVRsNWlER0F2eWJBN0ZE?=
 =?iso-2022-jp?B?WmN6bURnaUFpSmh2REVCVlJKWFhqODEzTVdxSS9RNDBtWlFNYUkrdXUx?=
 =?iso-2022-jp?B?bmFtNXZSbmhTSW5BSU9DeDhKY0ZJbnhWQlRoTkQyOGRsZlZpVU9vL0h3?=
 =?iso-2022-jp?B?a1M3Q0VZcHh6ektQUUd4bHc4cjY0eVo1N3orWE54VnRsZSt5MHgzQ1FM?=
 =?iso-2022-jp?B?djZjcy9ZMVh6M1ZQOVhiaG1aVDhYZW5yL1VtM2wyUVZPUlNrSWtvRFRj?=
 =?iso-2022-jp?B?dW90UHl5dWVVdStxRE1SR25FMDBiVGZkSE1TTGxjOGdja3lWSkF1UkEw?=
 =?iso-2022-jp?B?ZEZIR3lwMitmN1lCZUY0TTVVNlhJRHVtUzVhRnZSSUg1RndBYVNxcnIx?=
 =?iso-2022-jp?B?Z2N6K0g2cUxjd1B1WWJoZHZQZnJZVjRlSTZWbk56enZCQmVaWk11cHlT?=
 =?iso-2022-jp?B?bDBldDJKVU1aRUxOdm5GQmJFRUdvZXI1clB2UnRFVWQydGZ6NkkyemRo?=
 =?iso-2022-jp?B?Sk0vdlpxdzBkeFE3OW05N21RMnRqbE9yemV5UUpTdkEvZnpGTjZPU2JH?=
 =?iso-2022-jp?B?M1dqcEZ6dDgwVFFZaDlSc3JKWFBJQTBuQWIvZkxMY1FUb1pSNllkY1pT?=
 =?iso-2022-jp?B?M2ttd0tqN01xOGdaYWYvZ3FIVFdBSEZMSnN2OTNzUVByaTJ2aEwxYnFo?=
 =?iso-2022-jp?B?c3cyM0FyRCs4WCtnVW4raEJkVnJqZ3lXWHhFbHJQMFRKWEUwSjl2RUFu?=
 =?iso-2022-jp?B?bWYwUGp0NXJ2ODN2dFMyTUtScWJhQ1V5c3BJUlJmVEtqcGMwUnVIc1JS?=
 =?iso-2022-jp?B?MURScjRtZE5teGVqWFJFZk1CMnR1NW9ka1RLZ3pXbHBMZTRhRDFaSitC?=
 =?iso-2022-jp?B?MWJBRXZwalFOaytVQmhjVGkwVWY3czVUUkNvRkNDMlZ6WFE2OG42UGk2?=
 =?iso-2022-jp?B?c01TaWEyckRHbXp5bEwwMWlmMFFCQmloOERNL1dFRXk2RXVacE5sdkxT?=
 =?iso-2022-jp?B?S01VeVNRM0ZmMkovZW8zZUxCdGN5YXBRWXZvSTRMSGw1OHgwWnh1Z2Na?=
 =?iso-2022-jp?B?ZUdZNCtYdzQxTjBvaUJndk9TUU5hbnRIZ2NESWlXQU9icUhYRTR4OTNv?=
 =?iso-2022-jp?B?R0FzeWk2WS92VTd6WjZVRU5aZ1dGekgvU2hsWDJWcmp4Q0FCcVl6Y2dQ?=
 =?iso-2022-jp?B?a0JVa21aWTdLQVJJbjkxWCs0M1Yrd1ZzRUFzM2kycDFqSDBXMWl1a09E?=
 =?iso-2022-jp?B?YlhDR3dWdEYxWVhldkpuOGpmUmVmck5zYlJKUEEvQzhHNXJpUHhKRU5B?=
 =?iso-2022-jp?B?akpTQjNrL2pkd2UwNXl4S0NtUm05TGpUODR5bnc4bmU4c0k1clFZaUoy?=
 =?iso-2022-jp?B?MXdSdS9KaWJYVnJ0bVovZ1A5bjhndVJvaTJlWTdoSUhwajVOQnk1aDVy?=
 =?iso-2022-jp?B?QjF1T2pZWE1zektybHpkOWJwRUpnNmh6T1QwQmlDR3NzRThhREVCU21w?=
 =?iso-2022-jp?B?SzlZTlhrd214ZlhrSGRxODZYOWE3ZzU3NEFOMXlmTld0Y205OHh1VGQz?=
 =?iso-2022-jp?B?dTJoaHhYd0JYM054VVRjSGgxb3llU1A2YUMzY0lkZnJ6NXMrNjdRby9P?=
 =?iso-2022-jp?B?R3NpbGxNTHdDaHZSaTl6Y0crOWpzY2QzTGJtTjJWU2RNSWttaFJTb1dY?=
 =?iso-2022-jp?B?SmdreEE3UG1HSXQ2WS94T3I1UWdwQnNUY05mbnZmTjdtV0p1Y1A1VDlL?=
 =?iso-2022-jp?B?SlZTM21FZUM4ajJGdmFiYjBLeCtyR0VZbTZneWhTSFl5MVdISS9yQWgx?=
 =?iso-2022-jp?B?MHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UHFsdVlzR0tRVHdPY2JIWkRPeUo0L01oZFR4NjNmdUFyL3NQMUNROXhh?=
 =?iso-2022-jp?B?SkFqMDJsYWhTT1NXUm8wY3RmRnlVQjBiSm15YU1xazhsbzNIKzlVTFVV?=
 =?iso-2022-jp?B?REVmUEpuNC9UZ2V4OWFaTmR0MXBoQVlIRVBkRFlEK3hmcitqaXNhSjNs?=
 =?iso-2022-jp?B?cXNsMkM3MlM3UnA5c1B1TDZkNE1jdTlDRGVOMW1sSm9jWXd3NFlFY3g0?=
 =?iso-2022-jp?B?V3p0N3QvMDZ1WGdXU3pUejJQaHpRQmgwSlhsejY0RUJaRHdobWJVUFlt?=
 =?iso-2022-jp?B?ZDJncExUQSs3TE1KOXdidk1BRVpwejQ2TVBEODI5ZFZ5eFRwZ1gxMitX?=
 =?iso-2022-jp?B?Yjd4UXYvb205YnlNeEhSTUJHZ0ZtVDZJYnBtYktoZk5tRks3VXJ0QVVN?=
 =?iso-2022-jp?B?R2NXTWRnT3FXTG5lSEVYZUNvUXI3a05QeXNqNS8yWU9SVVZIQjNjUGE0?=
 =?iso-2022-jp?B?SmRLSTI0QS8wSDVqN1d3Q2EvR1d1dFdLNysvRUNpd0xqYytxdDcwc1cv?=
 =?iso-2022-jp?B?Q3dveFhwT2M0SFU2WUFWR1YrdXNRM204dC9kR3owbWZBRTN3YlRVaUI2?=
 =?iso-2022-jp?B?NE9YVmwzMC9wSTVERXZDcldVc0xmbklBV2dpUy9pN21GS0FmMFp3MGxo?=
 =?iso-2022-jp?B?dHpIdVR2dTZTUnM2eU0zeldRNC9ieDdHYlUzOWNHNUVhRHJoOGRJTGdr?=
 =?iso-2022-jp?B?bC81M3JBc05GNFU5QkxlNzB4WnNsOXQ3eHJNRkMwdGp1Mm1xN2hMR0Fo?=
 =?iso-2022-jp?B?UURPblAwSTVKVG04UVdoWGw2ZUFIS05uRUVsa1ExVnhBcElXQ3lEdDNC?=
 =?iso-2022-jp?B?Z1QwQytIVlovTjVoUDFsc21wVmt2U0gxZ25sZVJ2ZkEwdUFFMUJGcVcy?=
 =?iso-2022-jp?B?RlowMW5XZGlva1YwRmQyUlpOMzFEREZDaDhQQkNjWjFkYzc4czNXeER3?=
 =?iso-2022-jp?B?TEVDYmkxV3ZGSEFnOWVsVUlpUkZzeXVxVXFYbWZKUG9TTmh6bVVEK3pY?=
 =?iso-2022-jp?B?K3g2dktMYUxOQlhZNFgxbCtnT0JWWHhMTklBdDRkK094b2Z2YmtXOTJm?=
 =?iso-2022-jp?B?YmtUUzRtdkJiR2xNbCsvU1RuYkpleE5RTzNjTENwVndkaGJVak9yaStL?=
 =?iso-2022-jp?B?WGlScys0eVpSZU1maVJZZmlKQ2pkdjVVbVVWWUJWbG01ZHdReG0yNUtM?=
 =?iso-2022-jp?B?dXVuY3dRZ0I4b3VSN0U3b0tnWVRlNUo4R012Z2h0QmpqMWI4bWhOZUVO?=
 =?iso-2022-jp?B?NjF3U2FMZ24zVmZNVmdLV1l6T2JwdlJHUEdET1A5Ymd2WWI3UHFkdWFS?=
 =?iso-2022-jp?B?MUU1K3djMHBUYXRFY0Y4VDVDeEdTamFiTWQwWUloTGphcngzWmE2THNT?=
 =?iso-2022-jp?B?YVRhN3p6Q0RNbW9YekZUVWFFK01lWmV5cnRvQk5EZUNTVFBWcU52VERX?=
 =?iso-2022-jp?B?NllTNm0xZGN5dnRIaU5RdzhmNnlQd1hhcnJvZC9TV1NHOXpnT2lWQmpa?=
 =?iso-2022-jp?B?RUJIdmZqM1NqbVRreldhL2lneUtBTFM3ckZ4dXlFTmxYdUV2bmVZVXh3?=
 =?iso-2022-jp?B?Z2VXNU5HejM4VU13Vmc5UksrRVlkbS81UjY2dmx6WTE2Z0E2bDIva1N3?=
 =?iso-2022-jp?B?K3dKbGFqUVVZazU5QjdtK0t2L2o2bGx4MHo4L21QRTBFb0VyNHZmeWpw?=
 =?iso-2022-jp?B?MVFCWjJXYUJLTm9TamFiYytSZDZabzFsa0JYZ2IvRXZ6K0N2N3dsUjJC?=
 =?iso-2022-jp?B?Vys0bTRBN0J2dEhFZVN2V29RMUNQd3krbFlZdnpkUUdBS2lQZDFvTUZ2?=
 =?iso-2022-jp?B?MnpZdmw5S25vRmtqOEtXY2JKY1ZEOU5vUkFVU25CRHVWcDRWaUpyMjFx?=
 =?iso-2022-jp?B?bU9MNVRoaDBYZkNVU3dzZ08xTzVmUUZnVE1OZ0NFZXA0WTdHcHdpUVhx?=
 =?iso-2022-jp?B?azdCYVJRUnpMUSsrOXEvR2RSZ0FUQkdOeFNoNk8vazdhNlNmQ2dIdjgx?=
 =?iso-2022-jp?B?T3N0bGd4U1ppdWZyM1ZEUVE5OUVDK1pDci9OSjhxdncvOUd2ZmQxTkpN?=
 =?iso-2022-jp?B?TTkxbFR3aytUait1MnljL3dwZHd4K1E3N2JKMFhKT3Z4ZHpPSkRlKzB4?=
 =?iso-2022-jp?B?OVMzaWN6THF2RjMwaUo5TytMcDZaaUNaSkFLYjBEenNjanpFcW9halRj?=
 =?iso-2022-jp?B?TmFqTmN2cFhCcnF3QTNtQndYd0JvSW1qQmxVOWwwTkZqQjFSYnhScmFK?=
 =?iso-2022-jp?B?NjV1TzdHL2dBTHdTSjFnWXdwYTEyNFlKYk1JRmNGaGxRSmRYM1BHUVVu?=
 =?iso-2022-jp?B?M0d2MzIwYUt6VVh2WUxuRnlZSXh1b2oxYWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ce2cac-16ca-4ae7-04fb-08dd037939ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 00:22:15.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doipO1pjrLGEm5XpOMqcLr/iZDjiO1oDXQrpjOFONNbVL2r/1Zp0bG8RFW4BGSFp57PXl72j2Fw4ksERnRN6G6RHXi2vY6k9VJl0yedtYFwqpzRPoyrjWq+X0AGNbRdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 00:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17242

Hi all,

CIP kernel team has released Linux kernel v4.19.323-cip114 and v5.10.226-ci=
p54.
The linux-4.19.y-cip tree has been updated base version from v4.19.322 to v=
4.19.323, and
the linux-5.10.y-cip tree has been updated base version from v5.10.226 to v=
5.10.226.

You can get this release via the git tree at:

  v4.19.323-cip114:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      4bc566200edfd8e9dc784404bc3a51aa156677d5
    fixed CVEs:
      CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_dst =
skb
      CVE-2024-50230: nilfs2: fix kernel bug due to missing clearing of che=
cked flag
      CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_p=
ut()
      CVE-2024-41016: ocfs2: strict bound check before memcmp in ocfs2_xatt=
r_find_entry()
      CVE-2024-50262: bpf: Fix out-of-bounds write in trie_get_next_key()
      CVE-2024-50236: wifi: ath10k: Fix memory leak in management tx
      CVE-2022-48910: net: ipv6: ensure we call ipv6_mc_down() at most once
      CVE-2024-50142: xfrm: validate new SA's prefixlen using SA family whe=
n sel.family is unset
      CVE-2024-46854: net: dpaa: Pad packets to ETH_ZLEN
      CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check_d=
elete()
      CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()
      CVE-2024-44931: gpio: prevent potential speculation leaks in gpio_dev=
ice_get_desc()
      CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_block=
s
      CVE-2024-49881: ext4: update orig_path in ext4_find_extent()
      CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad
      CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns NUL=
L
      CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
      CVE-2024-50202: nilfs2: propagate directory read errors from nilfs_fi=
nd_entry()
      CVE-2024-47663: staging: iio: frequency: ad9834: Validate frequency p=
arameter value
      CVE-2024-49882: ext4: fix double brelse() the buffer of the extents p=
ath
      CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu=
_on_spin()
      CVE-2024-49894: drm/amd/display: Fix index out of bounds in degamma h=
ardware format translation
      CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.
      CVE-2024-47709: can: bcm: Clear bo->bcm_proc_read after remove_proc_e=
ntry().
      CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure
      CVE-2024-44988: net: dsa: mv88e6xxx: Fix out-of-bound access
      CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_=
create_dir()
      CVE-2024-50229: nilfs2: fix potential deadlock with newly created sym=
links
      CVE-2024-49902: jfs: check if leafidx greater than num leaves per dma=
p tree
      CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls
      CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma
      CVE-2024-49949: net: avoid potential underflow in qdisc_pkt_len_init(=
) with UFO
      CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting=
 urb before resubmit
      CVE-2024-49981: media: venus: fix use after free bug in venus_remove =
due to race condition
      CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner=
 kthread during umount
      CVE-2024-47684: tcp: check skb is non-NULL in tcp_rto_delta_us()
      CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an out-of-=
bounds write error
      CVE-2024-47742: firmware_loader: Block path traversal
      CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent(=
)
      CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree_i=
nsert()
      CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write warn=
ing in mwifiex_cmd_802_11_scan_ext()
      CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry(=
)
      CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at=
()
      CVE-2024-49860: ACPI: sysfs: validate return type of _STR method
      CVE-2024-49982: aoe: fix the potential use-after-free problem in more=
 places
      CVE-2024-49955: ACPI: battery: Fix possible crash when unregistering =
a battery hook
      CVE-2024-47747: net: seeq: Fix use after free vulnerability in ether3=
 Driver Due to Race Condition
      CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      CVE-2024-50024: net: Fix an unsafe loop on the list
      CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid
      CVE-2024-47701: ext4: avoid OOB when system.data xattr changes undern=
eath the filesystem
      CVE-2024-49995: tipc: guard against string buffer overrun
      CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_ta=
sk()
      CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in ieee=
80211_do_stop()
      CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buffe=
r_uptodate
      CVE-2024-50168: net/sun3_82586: fix potential memory leak in sun3_825=
86_send_packet()
      CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access
      CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an out-of-=
bounds write error
      CVE-2024-50179: ceph: remove the incorrect Fw reference check when di=
rtying pages
      CVE-2024-50035: ppp: fix ppp_async_encode() illegal access
      CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode
      CVE-2024-50194: arm64: probes: Fix uprobes for big-endian kernels
      CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() i=
n acpi_db_convert_to_package()
      CVE-2024-50195: posix-clock: Fix missing timespec64 check in pc_clock=
_settime()
      CVE-2024-50234: wifi: iwlegacy: Clear stale interrupts before resumin=
g device
      CVE-2024-49967: ext4: no need to continue when the number of entries =
is 1
      CVE-2022-48938: CDC-NCM: avoid overflow in sanity checking
      CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk=
_state_change
      CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails i=
n sctp_listen_start
      CVE-2024-49959: jbd2: stop waiting for space when jbd2_cleanup_journa=
l_tail() returns error
      CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method
      CVE-2024-50167: be2net: fix potential memory leak in be_xmit()
      CVE-2024-50116: nilfs2: fix kernel bug due to missing clearing of buf=
fer delay flag
      CVE-2024-50251: netfilter: nft_payload: sanitize offset and length be=
fore calling skb_checksum()
      CVE-2024-49966: ocfs2: cancel dqi_sync_work before freeing oinfo
      CVE-2024-50150: usb: typec: altmode should keep reference to parent
      CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated corru=
ption
      CVE-2024-50237: wifi: mac80211: do not pass a stopped vif to the driv=
er in .get_txpower
      CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()=
&iput()
      CVE-2024-49958: ocfs2: reserve space for inline xattr before attachin=
g reflink tree
      CVE-2024-50099: arm64: probes: Remove broken LDR (literal) uprobe sup=
port
      CVE-2024-50148: Bluetooth: bnep: fix wild-memory-access in proto_unre=
gister
      CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmw=
are is dead
      CVE-2024-49896: drm/amd/display: Check stream before comparing them
      CVE-2024-47706: block, bfq: fix possible UAF for bfqq->bic with merge=
 chain
      CVE-2024-50171: net: systemport: fix potential memory leak in bcm_sys=
port_xmit()
      CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate=
()
      CVE-2024-50074: parport: Proper fix for array out-of-bounds access
      CVE-2024-50218: ocfs2: pass u64 to ocfs2_truncate_inline maybe overfl=
ow
      CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()
      CVE-2024-50180: fbdev: sisfb: Fix strbuf array overflow
      CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use
      CVE-2024-47696: RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_f=
lush_dependency
      CVE-2024-50040: igb: Do not bring the device up after non-fatal error
      CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer
    added commits:
      CIP: Bump version suffix to -cip114 after merge from stable

  v5.10.226-cip54:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      35cd32f84ab6b210d2be9a26963d82f4ca4afd41
    fixed CVEs:
      CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_dst =
skb
      CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_p=
ut()
      CVE-2024-47756: PCI: keystone: Fix if-statement expression in ks_pcie=
_quirk()
      CVE-2024-41016: ocfs2: strict bound check before memcmp in ocfs2_xatt=
r_find_entry()
      CVE-2024-49933: blk_iocost: fix more out of bound shifts
      CVE-2024-49969: drm/amd/display: Fix index out of bounds in DCN30 col=
or transformation
      CVE-2024-49913: drm/amd/display: Add null check for top_pipe_to_progr=
am in commit_planes_for_stream
      CVE-2024-50089: unicode: Don't special case ignorable code points
      CVE-2024-50095: RDMA/mad: Improve handling of timed out WRs of mad ag=
ent
      CVE-2024-46854: net: dpaa: Pad packets to ETH_ZLEN
      CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check_d=
elete()
      CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()
      CVE-2024-50059: ntb: ntb_hw_switchtec: Fix use after free vulnerabili=
ty in switchtec_ntb_remove due to race condition
      CVE-2024-50033: slip: make slhc_remember() more robust against malici=
ous packets
      CVE-2024-44931: gpio: prevent potential speculation leaks in gpio_dev=
ice_get_desc()
      CVE-2024-46865: fou: fix initialization of grc
      CVE-2024-49985: i2c: stm32f7: Do not prepare/unprepare clock during r=
untime suspend/resume
      CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_block=
s
      CVE-2024-49879: drm: omapdrm: Add missing check for alloc_ordered_wor=
kqueue
      CVE-2024-49881: ext4: update orig_path in ext4_find_extent()
      CVE-2024-50039: net/sched: accept TCA_STAB only for root qdisc
      CVE-2024-50184: virtio_pmem: Check device status before requesting fl=
ush
      CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns NUL=
L
      CVE-2024-47718: wifi: rtw88: always wait for both firmware loading at=
tempts
      CVE-2024-49882: ext4: fix double brelse() the buffer of the extents p=
ath
      CVE-2024-50013: exfat: fix memory leak in exfat_load_bitmap()
      CVE-2024-26921: inet: inet_defrag: prevent sk release while still in =
use
      CVE-2024-49993: iommu/vt-d: Fix potential lockup if qi_submit_sync ca=
lled with 0 count
      CVE-2024-50049: drm/amd/display: Check null pointer before dereferenc=
ing se
      CVE-2024-49894: drm/amd/display: Fix index out of bounds in degamma h=
ardware format translation
      CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.
      CVE-2024-50188: net: phy: dp83869: fix memory corruption when enablin=
g fiber
      CVE-2024-47709: can: bcm: Clear bo->bcm_proc_read after remove_proc_e=
ntry().
      CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure
      CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_=
create_dir()
      CVE-2024-49902: jfs: check if leafidx greater than num leaves per dma=
p tree
      CVE-2024-46695: selinux,smack: don't bypass permissions check in inod=
e_setsecctx hook
      CVE-2024-49851: tpm: Clean up TPM space after command failure
      CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls
      CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma
      CVE-2024-47705: block: fix potential invalid pointer dereference in b=
lk_add_partition
      CVE-2024-49949: net: avoid potential underflow in qdisc_pkt_len_init(=
) with UFO
      CVE-2024-49863: vhost/scsi: null-ptr-dereference in vhost_scsi_get_re=
q()
      CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting=
 urb before resubmit
      CVE-2024-47748: vhost_vdpa: assign irq bypass producer token correctl=
y
      CVE-2024-49981: media: venus: fix use after free bug in venus_remove =
due to race condition
      CVE-2024-46858: mptcp: pm: Fix uaf in __timer_delete_sync
      CVE-2024-50096: nouveau/dmem: Fix vulnerability in migrate_to_ram upo=
n copy error
      CVE-2024-47735: RDMA/hns: Fix spin_unlock_irqrestore() called with IR=
Qs enabled
      CVE-2024-47671: USB: usbtmc: prevent kernel-usb-infoleak
      CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner=
 kthread during umount
      CVE-2024-49895: drm/amd/display: Fix index out of bounds in DCN30 deg=
amma hardware format translation
      CVE-2024-47684: tcp: check skb is non-NULL in tcp_rto_delta_us()
      CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an out-of-=
bounds write error
      CVE-2024-47692: nfsd: return -EINVAL when namelen is 0
      CVE-2024-35965: Bluetooth: L2CAP: Fix not validating setsockopt user =
input
      CVE-2024-47742: firmware_loader: Block path traversal
      CVE-2024-47712: wifi: wilc1000: fix potential RCU dereference issue i=
n wilc_parse_join_bss_param
      CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent(=
)
      CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree_i=
nsert()
      CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write warn=
ing in mwifiex_cmd_802_11_scan_ext()
      CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry(=
)
      CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at=
()
      CVE-2024-49860: ACPI: sysfs: validate return type of _STR method
      CVE-2024-49982: aoe: fix the potential use-after-free problem in more=
 places
      CVE-2024-49955: ACPI: battery: Fix possible crash when unregistering =
a battery hook
      CVE-2024-47747: net: seeq: Fix use after free vulnerability in ether3=
 Driver Due to Race Condition
      CVE-2024-50181: clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for=
 i.MX7D
      CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      CVE-2024-50024: net: Fix an unsafe loop on the list
      CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid
      CVE-2024-47701: ext4: avoid OOB when system.data xattr changes undern=
eath the filesystem
      CVE-2024-27017: netfilter: nft_set_pipapo: walk over current view on =
netlink dump
      CVE-2024-49995: tipc: guard against string buffer overrun
      CVE-2024-49889: ext4: avoid use-after-free in ext4_ext_show_leaf()
      CVE-2024-49858: efistub/tpm: Use ACPI reclaim memory for event log to=
 avoid corruption
      CVE-2024-50046: NFSv4: Prevent NULL-pointer dereference in nfs42_comp=
lete_copies()
      CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_ta=
sk()
      CVE-2024-49977: net: stmmac: Fix zero-division error when disabling t=
c cbs
      CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in ieee=
80211_do_stop()
      CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use t=
o prevent UAF
      CVE-2024-46852: dma-buf: heaps: Fix off-by-one in CMA heap fault hand=
ler
      CVE-2024-49868: btrfs: fix a NULL pointer dereference when failed to =
start a new trasacntion
      CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buffe=
r_uptodate
      CVE-2024-27072: media: usbtv: Remove useless locks in usbtv_video_fre=
e()
      CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access
      CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an out-of-=
bounds write error
      CVE-2024-50179: ceph: remove the incorrect Fw reference check when di=
rtying pages
      CVE-2024-50035: ppp: fix ppp_async_encode() illegal access
      CVE-2024-47739: padata: use integer wrap around to prevent deadlock o=
n seq_nr overflow
      CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode
      CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() i=
n acpi_db_convert_to_package()
      CVE-2024-49973: r8169: add tally counter fields added with RTL8125
      CVE-2024-50015: ext4: dax: fix overflowing extents beyond inode size =
when partially writing
      CVE-2024-49967: ext4: no need to continue when the number of entries =
is 1
      CVE-2024-46849: ASoC: meson: axg-card: fix 'use-after-free'
      CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk=
_state_change
      CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails i=
n sctp_listen_start
      CVE-2024-49959: jbd2: stop waiting for space when jbd2_cleanup_journa=
l_tail() returns error
      CVE-2024-49878: resource: fix region_intersects() vs add_memory_drive=
r_managed()
      CVE-2024-49892: drm/amd/display: Initialize get_bytes_per_element's d=
efault to 1
      CVE-2024-47710: sock_map: Add a cond_resched() in sock_hash_free()
      CVE-2024-49930: wifi: ath11k: fix array out-of-bound access in SoC st=
ats
      CVE-2024-49966: ocfs2: cancel dqi_sync_work before freeing oinfo
      CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated corru=
ption
      CVE-2024-38544: RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
      CVE-2024-49983: ext4: drop ppath from ext4_ext_replay_update_ex() to =
avoid double-free
      CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()=
&iput()
      CVE-2024-49958: ocfs2: reserve space for inline xattr before attachin=
g reflink tree
      CVE-2024-46853: spi: nxp-fspi: fix the KASAN report out-of-bounds bug
      CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmw=
are is dead
      CVE-2024-49936: net/xen-netback: prevent UAF in xenvif_flush_hash()
      CVE-2024-49890: drm/amd/pm: ensure the fw_info is not null before usi=
ng it
      CVE-2024-49896: drm/amd/display: Check stream before comparing them
      CVE-2024-47706: block, bfq: fix possible UAF for bfqq->bic with merge=
 chain
      CVE-2024-49907: drm/amd/display: Check null pointers before using dc-=
>clk_mgr
      CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_l=
ocation()
      CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate=
()
      CVE-2024-50180: fbdev: sisfb: Fix strbuf array overflow
      CVE-2024-47696: RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_f=
lush_dependency
      CVE-2024-50040: igb: Do not bring the device up after non-fatal error
      CVE-2024-49875: nfsd: map the EBADMSG to nfserr_io to avoid warning
      CVE-2024-50001: net/mlx5: Fix error path in multi-packet WQE transmit
      CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer
      CVE-2024-50185: mptcp: handle consistently DSS corruption
      CVE-2024-50202: nilfs2: propagate directory read errors from nilfs_fi=
nd_entry()
      CVE-2024-50192: irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
      CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu=
_on_spin()
      CVE-2024-50199: mm/swapfile: skip HugeTLB pages for unuse_vma
      CVE-2023-52530: wifi: mac80211: fix potential key use-after-free
      CVE-2024-50083: tcp: fix mptcp DSS corruption due to large pmtu xmit
      CVE-2024-50082: blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_=
function race
      CVE-2024-50195: posix-clock: Fix missing timespec64 check in pc_clock=
_settime()
      CVE-2024-50193: x86/entry_32: Clear CPU buffers after register restor=
e in NMI return
      CVE-2024-50201: drm/radeon: Fix encoder->possible_clones
      CVE-2024-50099: arm64: probes: Remove broken LDR (literal) uprobe sup=
port
      CVE-2024-50198: iio: light: veml6030: fix IIO device retrieval from e=
mbedded device
      CVE-2024-50074: parport: Proper fix for array out-of-bounds access
      CVE-2024-50230: nilfs2: fix kernel bug due to missing clearing of che=
cked flag
      CVE-2024-50262: bpf: Fix out-of-bounds write in trie_get_next_key()
      CVE-2024-50236: wifi: ath10k: Fix memory leak in management tx
      CVE-2024-50142: xfrm: validate new SA's prefixlen using SA family whe=
n sel.family is unset
      CVE-2024-50208: RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL =
pages
      CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
      CVE-2024-50233: staging: iio: frequency: ad9832: fix division by zero=
 in ad9832_calc_freqreg()
      CVE-2024-50072: x86/bugs: Use code segment selector for VERW operand
      CVE-2024-50115: KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from =
memory
      CVE-2024-50229: nilfs2: fix potential deadlock with newly created sym=
links
      CVE-2024-50134: drm/vboxvideo: Replace fake VLA at end of vbva_mouse_=
pointer_shape with real VLA
      CVE-2024-50103: ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_c=
pu_platform_probe()
      CVE-2024-50153: scsi: target: core: Fix null-ptr-deref in target_allo=
c_device()
      CVE-2024-50205: ALSA: firewire-lib: Avoid division by zero in apply_c=
onstraint_to_size()
      CVE-2024-39497: drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MA=
P_PRIVATE)
      CVE-2024-50168: net/sun3_82586: fix potential memory leak in sun3_825=
86_send_packet()
      CVE-2024-50010: exec: don't WARN for racy path_noexec check
      CVE-2024-50127: net: sched: fix use-after-free in taprio_change()
      CVE-2024-50194: arm64: probes: Fix uprobes for big-endian kernels
      CVE-2024-50234: wifi: iwlegacy: Clear stale interrupts before resumin=
g device
      CVE-2024-50131: tracing: Consider the NULL character when validating =
the event length
      CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method
      CVE-2024-50167: be2net: fix potential memory leak in be_xmit()
      CVE-2024-50116: nilfs2: fix kernel bug due to missing clearing of buf=
fer delay flag
      CVE-2024-50251: netfilter: nft_payload: sanitize offset and length be=
fore calling skb_checksum()
      CVE-2024-50150: usb: typec: altmode should keep reference to parent
      CVE-2024-50237: wifi: mac80211: do not pass a stopped vif to the driv=
er in .get_txpower
      CVE-2024-47674: mm: avoid leaving partial pfn mappings around in erro=
r case
      CVE-2024-50148: Bluetooth: bnep: fix wild-memory-access in proto_unre=
gister
      CVE-2024-50058: serial: protect uart_port_dtr_rts() in uart_shutdown(=
) too
      CVE-2024-50151: smb: client: fix OOBs when building SMB2_IOCTL reques=
t
      CVE-2024-50171: net: systemport: fix potential memory leak in bcm_sys=
port_xmit()
      CVE-2024-50218: ocfs2: pass u64 to ocfs2_truncate_inline maybe overfl=
ow
      CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()
      CVE-2024-50209: RDMA/bnxt_re: Add a check for memory allocation
    added commits:
      CIP: Bump version suffix to -cip54 after merge from stable
      arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support
      arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
      arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
      media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-=
2 block
      media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU b=
lock
      arm64: defconfig: Enable RZ/G2L MIPI CSI-2 and CRU support
      arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
      arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
      arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
      clk: renesas: r9a07g044: Add clock and reset entries for CRU
      media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TAB=
LE
      media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedur=
e
      media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
      media: platform: rzg2l-cru: rzg2l-video: Fix image processing initial=
ization
      media: platform: rzg2l-cru: rzg2l-ip: Add delay after D-PHY reset
      media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
      media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in parenthe=
ses
      media: rzg2l-cru: Remove unneeded semicolon
      media: rzg2l-cru: fix a test for timeout
      media: rzg2l-cru: Fix missing error code in rzg2l_cru_start_streaming=
_vq()
      media: platform: renesas: rzg2l-cru: Add missing documentation for im=
age_conv_irq
      media: rzg2l-cru: Remove unnecessary shadowing of ret in rzg2l_csi2_s=
_stream()
      media: platform: Add Renesas RZ/G2L CRU driver
      media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
      media: dt-bindings: Document Renesas RZ/G2L CRU block
      media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
      media: v4l: subdev: Add pre_streamon and post_streamoff callbacks
      media: i2c: ov5645: Remove software reset entry from ov5645_global_in=
it_setting
      media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering =
the subdev
      media: i2c: ov5645: Make sure to call PM functions
      media: i2c: ov5645: Drop empty comment
      media: i2c: ov5645: Use runtime PM
      media: i2c: ov5645: Drop fetching the clk reference by name

Best regards,
   Nobuhiro


