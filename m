Return-Path: <masami.ichikawa@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796EC2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 07:23:07 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web10.7419.1747293778280037748
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 00:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cybertrust.co.jp, ip: 202.241.206.53, mailfrom: masami.ichikawa@cybertrust.co.jp)
Authentication-Results: ss11.sbt-mailgate.jp; dkim=fail(No signature) header.d=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masami.ichikawa@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id PQVR17171B;
	Thu, 15 May 2025 16:21:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVRAuBgr7acvAGc2gsnmLaTynv7Py/b7kv3NeZgb7ehJRxGphfa21++TSeoii62PgkDYj+pDjs8NZRF8VZR5B0z2E6UhOYYl9lK5sg9B1LclVhnFb2Z9dFZiCfZH/rUSO1Md7Kb65cqyMac5gsWEwXYcD1Duq1jeEwPQffG7EQgV6og54gD4eUsM1GlQgBe1otSJmrXzYI0PeOnj3o1XXjOO4IaL6YOaBptJHVJqYGU+DUCj/zmLxFT+cl9trECx+PmYeAQiGS/ifN382IFTQiH68pdmIh0oHqTb7vffOkldiqRs8R0/3/s4WBYTzwmFhpIhj2huF+w6lASRSZ1duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQfL8eu5ISFjrGXS1xJVtcvdy2AuuvLFV17hTLrFUCk=;
 b=MBVLGwTYS70u3VOje5Z5eAMPTMJ/goQ55wi2XlteCGziynsgNuaq6w1YaKzHSQZ9VHVUlfnq8HKgmxsRqQtnpNAL5HmQpeb7BBz1uRetclrws26ZazfSr9tDR0UK5BL1CNegWlEMO+5bw0m3L7RSHylaIrWldELM+vSD0u2kIRs8GPsuQFXVZo+tfSnAQKzpvxjAeK/bgoMVkeSvLPrL0T0BmTHZLaFEGegvfdloQSpt8EbBVKoJxqQ+7/ZWPZR6UIj+/oKntx4HdxDsk27IK7xPNrqJAlkU76lG20AH1UZ4PkFnv9aCicDiw4xK92jBQ5A5xMt+G+yK/TYnDyLlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Received: from OS7PR01MB13684.jpnprd01.prod.outlook.com
 (2603:1096:604:35d::13) by TY7PR01MB15027.jpnprd01.prod.outlook.com
 (2603:1096:405:257::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 07:21:15 +0000
Received: from OS7PR01MB13684.jpnprd01.prod.outlook.com
 ([fe80::7a6a:a531:4f0b:aaa4]) by OS7PR01MB13684.jpnprd01.prod.outlook.com
 ([fe80::7a6a:a531:4f0b:aaa4%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:21:14 +0000
From: <masami.ichikawa@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHbxWDD6fsCAWvvJEue/EzPCmR8y7PTSN/q
Date: Thu, 15 May 2025 16:22:52 +0900
Message-ID: 
 <OS7PR01MB13684DA6330A9E4800D3C1C54D490A@OS7PR01MB13684.jpnprd01.prod.outlook.com>
References: <61802c21-5f90-46fb-84fd-f19b4bb592f4@siemens.com>
In-Reply-To: <61802c21-5f90-46fb-84fd-f19b4bb592f4@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB13684:EE_|TY7PR01MB15027:EE_
x-ms-office365-filtering-correlation-id: 05514888-ffa1-48d4-5676-08dd938113be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NzF3SmJvMkdPUG9FNHloZEtxbjhtd2M4bEhIUmFOR1lBUTU3bExLaGw3?=
 =?iso-2022-jp?B?WTBzNGdJeE9iTFhDU2QzMTg0MWF1NGpsYk5sK1o1THNLMVJ2WGIyZTFQ?=
 =?iso-2022-jp?B?TGduandXd1JmVEIrSFh3b292N3lpSHpEQ1NCeS8zVmxYdUpLNnRZN1E1?=
 =?iso-2022-jp?B?M1RkckJxTmlMQ0hkWStDbVZwQ09YUitnVEIyL0VsTThsT1FoTHMrZnhM?=
 =?iso-2022-jp?B?TU5oSmRkelpFRzRYVndmSUpZV0xxbEhGVEFZVFFDczY5NzVLK2h5SUpy?=
 =?iso-2022-jp?B?V3ZKdU5GYTVkQTlmcUZFUGxxMXV0cExTVVZla1hxUGZjVUR6ZGdMRzUw?=
 =?iso-2022-jp?B?UEhOMVYyRHNmN3ZML0JJeXZUUysrTDl5TXZpYVJtd041M3JYWngwOFFK?=
 =?iso-2022-jp?B?MXhUQ0s1dTJwYlJ1bnFyWTcrSGZpNk9EZjlYellJVnYwZTlad1FRNEF4?=
 =?iso-2022-jp?B?SHNWZ24vWlVTaExyTW5aY0J5d3VCWUlZMnNYMHZHdzV5Qk84QVpNdG51?=
 =?iso-2022-jp?B?UEFuOWVxMytsa2IxeXlxWHRsdHZuamFoMkxGYk9oRWFTMHY5ejNzbUxH?=
 =?iso-2022-jp?B?UHJpUlUyL0RoUU9oRjEzSmovWVYxdTFUNlRFWFpzVEsxcWVzYVljR0Nt?=
 =?iso-2022-jp?B?Y0t5d1dkUDJVWFc5OUd5RmtEZi9qUWowTHQ2SDc1Vk4zeHBYc3pZaUVs?=
 =?iso-2022-jp?B?T2N3OVhva2VXb2ZtRGVvdXQ3OXlxeFluNHJtaEdNY3N6NUxMQXdVYXM0?=
 =?iso-2022-jp?B?QXBKTTdWblNtblJLNGtya2lDM2VHSXJNQW5RZ1AvSXNsOGc5UE9RaEM0?=
 =?iso-2022-jp?B?Q0U2cFQ1czM5eERueDJBdU9yUmJXR2pqYWlkeFkxSWhFMWZFdERMT3gv?=
 =?iso-2022-jp?B?eEJ3Vi90WVhwSTVlVGwzOGdKakZFOW5VUzRQNjhzN3FuRWZGQVpjdWds?=
 =?iso-2022-jp?B?OER0ck9LRi8yUTlxNklPcHNlSGZOMXhOZE1pSjdOTVgzT0pJNDVkRmVx?=
 =?iso-2022-jp?B?bmYzZmJhVG1LRld2Y1RzRmo3REhwSGxHSVZSTDNyRUY5V3ZjQWtmQmty?=
 =?iso-2022-jp?B?RlFhNUd0c1VTVEFtMERSZ1UzbDNKVWZaT1d0cElzV1dYd29mNkdXWWxk?=
 =?iso-2022-jp?B?TGFjdFYxbDlEc2VFT0g0TncxeDl6K1VNUG82MzNBRHlHZldKVVdWUWo0?=
 =?iso-2022-jp?B?QStKR28xb3FoL3cxNjlkU05xb3dqT1QvaEVMdS9KaTB6akdYZGMzMkZj?=
 =?iso-2022-jp?B?eFpPVyt5S3c3NDB1WDVEOUdLMlRjdTZTYW05R21XTDRnM1dXVHcvWGMx?=
 =?iso-2022-jp?B?TjRwTmhSLzRmbHlGZjRhVHlxSnE4bGFyckxGNHBmaUVmRm5ualc4czZa?=
 =?iso-2022-jp?B?cEJXSzVPSGVZN084RDZ3VCszdVArODRkdTZpYTBESThRVnlhdW9KdCtJ?=
 =?iso-2022-jp?B?R2VBSU9DOUxPZkhVeStxN05CRFMwcGlrenNhRVhPRjJHejlEVGRQS3NQ?=
 =?iso-2022-jp?B?Q2hIY3h6TEVSV1lxRE5FcW1VRWxRM2luM0k2QzVyY3VmSWVmVWtNWkU4?=
 =?iso-2022-jp?B?VUh0RkZoSjRRMDZJaHBPaUJ2dnpWdDBmYnJXaWpjTVV5RXI1ZlFBWHJw?=
 =?iso-2022-jp?B?MnhrUmtkTDcxaklwWlBuNEtCWlY4WHRPNmxXcng0dTdpaE9aRmNReTBW?=
 =?iso-2022-jp?B?QjQ1emtoSFRqNXhKUHVja0pZQUlDTDd1SnRFQ2FCMzVBUmwxMGpRVjZG?=
 =?iso-2022-jp?B?ajlreUN3NnJBdmJ0OHdkSlVEWDhSeThPWWJWR211akthRU43cHphR3Ji?=
 =?iso-2022-jp?B?TTRZaFVTK3lIbGczZjEwZ2pvL3RqQmM0bHNTOUlvVWVjL3RmZnc0d0Zo?=
 =?iso-2022-jp?B?QnpuMGZBaEUwb0hyZ1FCYk1BQU5wNTgzUW5GTU9JdEpxdFQ5WThISEs1?=
 =?iso-2022-jp?B?ZWRDQVlCRDRxZGVCYnVsRFY3U1VzdzNIdVp0RU5pcVdkb2Fibm5YVnNq?=
 =?iso-2022-jp?B?RzI5YjZYYi9aL0hBUlpRNFczSDEzMm5hYXZYQWlsMWJ3U1VuODRad3Iz?=
 =?iso-2022-jp?B?dENtdmZITDVlT3BuaVJuRlRMWS93ZFNicGNKc3JITlkwVnRoeHYvNzN1?=
 =?iso-2022-jp?B?VlVTeG9ZcTYxOVVGT2tZSmxSZy9Ta0J3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB13684.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Mlh0T0xHd2RrUEw1K2kwai9xQmp3aGJaQlBSeDhzL3lNdEEwNTVhQ1NT?=
 =?iso-2022-jp?B?OXF4TFNaUlpFdXBndEVVVEhEN2pCVEljdmJuSTRPSzlKZEpld21tZWt4?=
 =?iso-2022-jp?B?L2dvcDBGUGF1MFFzRlNLWGNOVzdPQ25TWklxdktQMXhEeWJ1YXdCQlhN?=
 =?iso-2022-jp?B?bUExQ0s1UzZVZldrL2x4S1ZxV1MwcGZsUzJZNEVFQUxCbDFDeGYyV0hO?=
 =?iso-2022-jp?B?Qko3R2dqMmxFWHNOdUhoeUpTR0UzQ3p1VDFyR09HV1J2MGpxbzVtRUhS?=
 =?iso-2022-jp?B?L2RqTk9MMmE1ZlJsNUoyS216YjN1UDE1eXIwL2twSmNVZlF3UVRubm04?=
 =?iso-2022-jp?B?VmljOG82MHMxMXVxejh6c0pGY1RsMWc3NXEzQWcza2J2UHAvcVhmTVRV?=
 =?iso-2022-jp?B?bnpxWHNvbVR4c2ZVdk92WElnZ05ESTVRTmhPUEMwQU9hOTBPaHVweGN3?=
 =?iso-2022-jp?B?U0Z0VGpLU2ZnTGdNVzNkUE9UNlZXYktEdVUzUnlUT290dlE4WmZYWGp2?=
 =?iso-2022-jp?B?QVpYVWtmK2d5K0dQK1JCSlpmVW5JcHdSYTFGRFdjRURmYzl2NFRsaXFw?=
 =?iso-2022-jp?B?RnlsbTdtZ0k3VEFndEVxT0dNaFVlNFphbURxeTZWa0dQbDcyMUpjY1RE?=
 =?iso-2022-jp?B?azdJU2Vhc2tnRFIyTW0zM05XcWJCdnc2QmF0ZEFlRk1SR2FrMU1IQ2lM?=
 =?iso-2022-jp?B?b0lpUVArZ0pQekl6NFdUYUErQXozcHBPK3hzVDBZTHZXZ2FxOG1FS3ZU?=
 =?iso-2022-jp?B?VzJrdGlUeC9iSzIrWE10MTdrWUtjK0hSc1BIWXNNMUxYcXZndGYvaHNG?=
 =?iso-2022-jp?B?UmRWaWp4S2NGWUtTa0FQb0JZZFQ4YlArbzlxcVphMTl4SVNla3Rac2dL?=
 =?iso-2022-jp?B?TEd0TWIwanJkU1pwR3ozVzZKdnpQQXM1NkJLMyswTTZoYkJ6ZEZjMVl1?=
 =?iso-2022-jp?B?cE9KK2wxeEZXelEyL3NSWDVWaG93VkIwMmtyTWFrbkh3TFEwTjd1NytQ?=
 =?iso-2022-jp?B?YjNIV0dKbTFPL2JsRHAvWUNCeENLYUtrbTdwNTF0NHpkZlV1d1FRYWhB?=
 =?iso-2022-jp?B?MUVPU0dmbFpkT3psVWF1djRSOE00V1h1a0RRb0tWaGxvRGdWeXFEcVgy?=
 =?iso-2022-jp?B?ZUQzUWVyMkdic0cvek1DaG13MG1USUpaQkVKUFhVTjhKcTJIUGN3YWxE?=
 =?iso-2022-jp?B?Uys4dVFqcStPYThMNXMwTldIalZxd2prOTByVUYrS0lWd3ZDWWtNOGZY?=
 =?iso-2022-jp?B?WS92OVc0aXBaYlpRa2RaKzc3anNheUJGQ0N2M1NqMVF5WlJ0YkUwMmhZ?=
 =?iso-2022-jp?B?bmdwNGpaaWhmOG9CMWpxQm1KS3VuV3RDWjQ5dTdXY2hOdkhaaktxbW56?=
 =?iso-2022-jp?B?U2ZEZGgyUk10bWcrUUx5amJzZzQ4Y2hMWWhGdkpiUEk1VlM1cWEvVS85?=
 =?iso-2022-jp?B?amQyMUN2VXBEVG9aUzF2ektscjVRL3BKQmp5dDRSRDllZDVCR3pnM2s3?=
 =?iso-2022-jp?B?eXJ5VlZQUnIwUURWTVh0OVNBcHhGNk8zRDRnYUZYb0NVMjVPNjdrSDJq?=
 =?iso-2022-jp?B?VkQ0a1dFc2pQNndwcEQ2YXplbHlJVkNqYWtMTmpkT3lNNFlhVHFFVncv?=
 =?iso-2022-jp?B?N3pJTzZ3amp3SjI4a0p4UUQ4MnBWT1ZmRkJJRitOTFZ2Zytkdi9sT1Vo?=
 =?iso-2022-jp?B?ZWVldGdwbWRJNFBrdC91M1JCYm5PaHRzQ015Q1NjT1B1OVA4SnhGNDRM?=
 =?iso-2022-jp?B?UEEyLzdDZWRBWmpyaEZiN0Q5YVpSVXJ1UHlWbDB2WG9oenlVRUx2V2FB?=
 =?iso-2022-jp?B?cjhPbXlXcXFKUUFVMmpselN1UjE5Wk1YVHBoS2Q5RmFoV2ZsaHpkcC9s?=
 =?iso-2022-jp?B?UFRsbGttWEpKOVZxaUhpT1Z2aFRaTy9tS0xRTE9aMllGZXVqZUpjNHk1?=
 =?iso-2022-jp?B?Nk4wK2ZTeE5PR3lnOWRZbHlIZTdzN3hVV1d3bytvQUJ3MmM2NjZXY1J1?=
 =?iso-2022-jp?B?Nm1HTm9WdXFYb3psd0dqazIrYjkvTXRtOCtVMmRMbi9xa05HZ2dHaXJM?=
 =?iso-2022-jp?B?YzFaUlJJTGJaMndBUFYvMDRndVRyUXNPemErNHdwOUlGR2FXOGI1RTEw?=
 =?iso-2022-jp?B?U1JkREt6SXFINVdPK253WVRmVmVTazV2ZWQvQ2R3VERoa0VmTVFqZEVn?=
 =?iso-2022-jp?B?cGJZZ2lrUUpWWXV4S1M3d0FxbmlVTXBRYnN1OWlrUXZjYkZOUUpVbCt6?=
 =?iso-2022-jp?B?T2p2cUkydHVUanJxb0thMURVdU1NcE1mL3hIeHRBMis4VFJENXdnQXBw?=
 =?iso-2022-jp?B?ak1waXFZNFEvMmtmSG9OT0pScjJOL0Z1ckE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mwv8DpnrcC91e0u1qv3nULcPy4EojiQ7srSe38GVyOJaFiU5RbuVXQFIwxoNLgtxGlRvuy3A62syeSwtM/AwSBIF3VTJQdl3NaPUmwZ/coHjXHtrDLsSmxcr8EQpbV3xs1UCHsFJ3Y5yWIio/2XOy4AQMA7G7Prbw0sw1n9TxxZSehoFOZU2IpBDe+gCYAmMloiqSECp4jgyqcVS+fE5SN1yDWTO2EHOo+QYvBLT2YQkyE8qqMUMui9cDyAInpRNC0CSEkdLm/shryjKHdVSRgxg+KGvQ6+QMLCG0VWan4CqNgw1N+em5bMPLH0ARxKqXZ6A0hPAsJQf4jaU1EvglViO9ACmAA2h85IWJvdjJpFXx4fFyFoWEXsF8GVRGWaobLzyX75Xo2reM4jrig4RHYIT6+rP/DxvmJyj4Yiex7WQHUx440i52Ma6QXL0WOM2Vq9Qa262gsUm/tFFIMi60o4iml00SPVaBbwMar2F2APdBKSTFs64XhrFfAqOPI6VCB63G/f4QyGyTDUJygzJnWlMir6BfkI/m4JEXPFa+1ZzPVUfZp1f9ePM25ZLk3BO72ID01uToDnK+PcGd/LTsUCGGqr/fA914EFvEEmSkUOaA/UvnENLxJT8kDiPQ9ih
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13684.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05514888-ffa1-48d4-5676-08dd938113be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:21:14.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmZ5hL1DAgeMD0brRVEhO3gQphcXF973y61HmBeIrBgMqY6M7DYOWvcP6Pvr1Wbkbgrqc/S8yjX7ORF3ewtIsa6aMYf40KOWbD03eYb7UHxjgRYJEgAFBdW5RgkU9OWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 07:23:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18909

Hello.=0A=
=0A=
Sorry. I'll be absent today.=0A=
=0A=
--=0A=
Masami Ichikawa=0A=
Cybertrust Japan Co., Ltd.=0A=
=0A=
Email :masami.ichikawa@cybertrust.co.jp=0A=
          :masami.ichikawa@miraclelinux.com=0A=
=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiem=
ens.com@lists.cip-project.org> =1B$B$NBeM}$GAw?.=1B(B=0A=
=1B$BAw?.F|;~=1B(B: 2025=1B$BG/=1B(B5=1B$B7n=1B(B15=1B$BF|=1B(B 15:15=0A=
=1B$B08@h=1B(B: cip-dev=0A=
=1B$B7oL>=1B(B: [cip-dev] CIP IRC weekly meeting today on libera.chat=0A=
=0A=
Hi all,=0A=
=0A=
Kindly be reminded to attend the weekly meeting through IRC to discuss=0A=
technical topics with CIP kernel today. Our channel is the following:=0A=
=0A=
    irc:irc.libera.chat:6667/cip=0A=
=0A=
The IRC meeting is scheduled to UTC (GMT) 13:00:=0A=
=0A=
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mont=
h=3D5&day=3D15&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248=0A=
=0A=
USWest    USEast    UK        DE        TW        JP=0A=
06:00     09:00     14:00     15:00     21:00     22:00=0A=
=0A=
Last meeting minutes:=0A=
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-08-1=
3.01.log.html=0A=
=0A=
* Action items=0A=
* Kernel maintenance updates=0A=
* Kernel release status [*]=0A=
  + state of 6.12.x-cip1=0A=
* Kernel testing=0A=
* AOB=0A=
=0A=
Note that I have a whole-day workshop in parallel. I will likely be able=0A=
to step out for this, but please don't wait for me longer than a few=0A=
minutes in case I fail to.=0A=
=0A=
Jan=0A=
=0A=
[*]=0A=
linux-4.4.y-cip: interval 30 day=0A=
  latest version release date: Wed Apr 23 09:15:22 AM UTC 2025=0A=
  limit date: Fri May 23 09:15:22 AM UTC 2025=0A=
  Status: On track=0A=
linux-4.4.y-cip-rt: interval 60 day=0A=
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025=0A=
  limit date: Sat Jun 28 11:30:23 AM UTC 2025=0A=
  Status: On track=0A=
linux-4.19.y-cip: interval 30 day=0A=
  latest version release date: Thu May  8 10:15:18 AM UTC 2025=0A=
  limit date: Sat Jun  7 10:15:18 AM UTC 2025=0A=
  Status: On track=0A=
linux-4.19.y-cip-rt: interval 60 day=0A=
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025=0A=
  limit date: Sun May 18 01:02:44 PM UTC 2025=0A=
  Status: On track=0A=
linux-5.10.y-cip: interval 30 day=0A=
  latest version release date: Fri Apr 18 04:57:16 AM UTC 2025=0A=
  limit date: Sun May 18 04:57:16 AM UTC 2025=0A=
  Status: On track=0A=
linux-5.10.y-cip-rt: interval 60 day=0A=
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025=0A=
  limit date: Fri May 16 09:54:04 PM UTC 2025=0A=
  Status: On track=0A=
linux-6.1.y-cip: interval 15 day=0A=
  latest version release date: Thu May  8 10:21:06 AM UTC 2025=0A=
  limit date: Fri May 23 10:21:06 AM UTC 2025=0A=
  Status: On track=0A=
linux-6.1.y-cip-rt: interval 30 day=0A=
  latest version release date: Mon May  5 07:36:59 AM UTC 2025=0A=
  limit date: Wed Jun  4 07:36:59 AM UTC 2025=0A=
  Status: On track=0A=

