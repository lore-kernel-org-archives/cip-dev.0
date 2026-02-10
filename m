Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9DEA3F04
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 05:04:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13501.1770699856110395494
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Feb 2026 21:04:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=fJ34A4AI;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1770699853;x=1771909453;bh=n+ME0fK7GP8DQdZlUxnZAT7RJ5lQC858lYVk7
	OieRH8=;b=fJ34A4AI5qvxEwxGwLvOTapgXw8sstHtebeHou9FZ9uqXxVg1DX2EvGovW4C+acfx0j
	6XvSeTgjEBB3bD/Svv87VNXjfKgjlWqaScwneYz7rVvBczF8P8I6xVNrXkL0XBW8AVz8hKFYobsio
	dhyMGJQ5ie5oeloCsF8Bc1pmsRhtHZ1m8teYSKI3LzKEzJ8/YVk20qgJ0Bhj6MOsKbkcmYXgC62bH
	0JvJYLW5H3VaGZU/Y5DuzCtxZqiIjdy3x7ySEV+lMJ+qzSh9lBiUcUFn/gq3P/kRvNNy0vNodJ+T7
	/cFnzUfMEKiy+tCh/3TfVxm7C7mNHx5MV/klsElGZW/A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 61A54C0l3968733; Tue, 10 Feb 2026 14:04:12 +0900
X-Iguazu-Qid: 2rWhaDm0DLejlawCKk
X-Iguazu-QSIG: v=2; s=0; t=1770699851; q=2rWhaDm0DLejlawCKk; m=65fRGXyH561oeSCaQGxCN/e2ixYEmRrdsY809yuN1aE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f98cC5gkHz1xnZ; Tue, 10 Feb 2026 14:04:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdDjy0rJ9pJ980CMN8Zw48jPFSiLfLE8PcngQhGLB2KEi53f/1EHJiF223OA0/eR192UkRY2ggUi94I6Tkm4OhItClmgG8GPjGhP8e2y2j0Jo8FT8duGk+xZHQMU7XU20qBig878SOcyAmrAvCrnjLcvbhQIzpQInTtVLQQPnYMhlYpeM6vRqVKT+Vk4Zu7wHz9b3kIuQdqWkRFoe4sEhEchKuUx40SMKIL3ay8riwMh/K0rxIgUzapaUYc8yJZNkbbaXtakCg+nHcafKXyLXoncH5fa6oG9mpqdEQrn6giqdjCQVM+m0r5CU3pqBP1ilkuhm5Pt78VYJgU7xD4BcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX3Vhinmkro46Cqx5pQu1kuNocBTwLr3aBhsOyISb7E=;
 b=R+hrqcbB2ISXLJLHbcYGx4dZac5zMdeF2/vyZ/r2nYo2FklUZd4dzRb/iJNWFTUdoavpK0OzP4yiLc89Zf6YEKgtj33ane5mQ+zVKolkr98GAx1cIEa96obqmvpdZGJk0H1cPddlzQzdtHv4HurvTCAJ3X65rfm8faJY32kAWZu/eauZg+n0Mh2/7zS0BcChR1CeDND4+yzh9UOELOpBlCtdotZ3G9UudfJZrW4xCTiQQgZAbLfa//PcRX0XVWEHtBl309oJEl4Awf0+sVAz+wdqt9l/gn2qyvvxQ49oSDZMi2Y/H4uo2a5BfwpRhEn7qGSL39gC2w18jgfJbtmJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <s-adivi@ti.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for
 BeagleV-Fire
Thread-Index: AQHclEOWJ5Pc4Wjmi0GSSe/5jaNZIrV7a2Aw
Date: Tue, 10 Feb 2026 05:04:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C90B18581467313DC36DCD62A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB10187:EE_
x-ms-office365-filtering-correlation-id: 3f931165-763b-496e-8fc6-08de6861d283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7142099003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZzJmdWcxMTlkTU05aFJRdGc3dlRiblBjbVByejYzWmhHNVkzM0dZNFht?=
 =?iso-2022-jp?B?TmN1RHAzUnIvd2VtL1VQeVJTeXRDbFdhWG5JaS8rVk1UdUIxOTY4NFJs?=
 =?iso-2022-jp?B?TU9WSUwxTVNueE9EaFVvd1RUaG1zKzRsMzlDbXNxZU5EbUpvdjhkdDhL?=
 =?iso-2022-jp?B?NnRmbU5oTW1qTnpqMU9LSXhaSFRlYW1ISUNvZ2RxcVd2T1Y5WlV1bkIw?=
 =?iso-2022-jp?B?YmM5S1ViRmlzcU8zakljak9oODFUdk9KNU5WKzJDdFpoLy9zMU5idFpP?=
 =?iso-2022-jp?B?a1NMdlM3NjBFMEFyMUd3WVEyZ0lNWHRsQzkzMXJ4WExkNnF5VnVzUFlS?=
 =?iso-2022-jp?B?ZmN2eTR2RkJVQUdXMGhIK3BQRDdKc2dXb05OUWpodDl2aG1vbk11a0ts?=
 =?iso-2022-jp?B?NG1PZTl5Yks5YW1BaG1jZlltR2Mza0dtSGdpQWxURDBkcWU0WHpKc1lv?=
 =?iso-2022-jp?B?MzVsU1NyZEdzRmo5VWJpMDZMS3hJMXkwZUFBdmJKT1p4YVBVVDNPVDZE?=
 =?iso-2022-jp?B?NnpNejJwMWg0WlI3cFhTdnRLWFpGNHdEODk5a2QzQWxsU1BWZTJNVlI3?=
 =?iso-2022-jp?B?R1VtRHF3T0RvcXlyY0paVWk5L2xVa3JWdkl2Rm5GY3JZV0M0SUpOM3pJ?=
 =?iso-2022-jp?B?SFJLVUh4VWJ2MzlxWmhkRWd2NlZYM2gxeDRvcGE0VEJwRGtvMzkxbVpT?=
 =?iso-2022-jp?B?MHJTQjJFWHFmbVdESUdybm5mckJnZmR4ZUlCOW9kWDZQZ3VUMGx4eWgw?=
 =?iso-2022-jp?B?TkdKcXVWSEdCbWk0TjZVVVViaTZzQ3B0WmsxWGg0OGtkUXNUY0RMTkp5?=
 =?iso-2022-jp?B?L2toejFBUVNUbGc4N1RoMjFCaTdHaFc4bkp5UlFvb1YwNitVSUFCMmdp?=
 =?iso-2022-jp?B?Y0E2WnNhaHVyb092OFBVT2l5VmR5bzl0VXc3a2xFZ3BlTUw2SGgwTDhn?=
 =?iso-2022-jp?B?RmNZOS8rMXlOd0FlTEZNMkk5Y3krSDlKdGI4d1J5SndtREJ1dHpta0N0?=
 =?iso-2022-jp?B?SjUyTjhUWStrZjNDU2Z4REpjcG5JMlZ0eGJVdGJRdE9UWm1rZEZHOWpp?=
 =?iso-2022-jp?B?ZHRENHR0Y2hSVHdZT0NZSVozbzJZOGgzcE5LN2xVL3BVcEhYNG1NSG9i?=
 =?iso-2022-jp?B?RXlCbVF6NVNUVkVCbXdKc0hPeERhNk82K3o0YlZJcjVOTTYzVzJYK1dB?=
 =?iso-2022-jp?B?M25mL3p5eUx1NTZ5dTNabXNZemRZbXZFenlWeGdDQ1pLc1hZeVhqYXNB?=
 =?iso-2022-jp?B?YWx1U2pYVytLNCtKZkNRZ3p6YUhUV3Z3TnZ5MTdnMzF6NTdvR1JVZjlH?=
 =?iso-2022-jp?B?UlRTYW1FdWVlcmkvdm1RQ0xERm12bTI2SEx6dzhQT3ZaY1dyT3l4UDNX?=
 =?iso-2022-jp?B?NXMyRXJzR2JKcmQzc3JoVTBybURZSkFhcXlLWW5iUFZ0eEM0SjMzT2Zm?=
 =?iso-2022-jp?B?Ti9jaEJ2Wm1jWndFSnk3L2dueU9RcFVFVko0dXVvSnVyS21zaGovcGJK?=
 =?iso-2022-jp?B?ckJoVFZhNG05ajRzR0JGQTNYS013eVRCekN2MkhkN0VPTFc0TnNNWE5z?=
 =?iso-2022-jp?B?bkkrTkNCMHZ1Z3VtNjRLcVFPbDVLVW5wSlFXcys0TzIyUkV5bTlCUE1k?=
 =?iso-2022-jp?B?Yk1SZTdLT0pBWlJQZW8vbWwzWmpMNFh4RmpORDllWEpHU0F5NE5abHZB?=
 =?iso-2022-jp?B?N1ZzSlNhelBXVlhmT1B0M2hSamw3ZStjTlp2ejhoVTJoQzk1b29BTnRz?=
 =?iso-2022-jp?B?QUw1MGNzdzNEU2lpVTVsOGhqWm5Zb2R2U3haWERWUnlnbXgxM3dwUHF2?=
 =?iso-2022-jp?B?MFdORjFaL0h6SlBIVlNqaXR5K29tNzlmN3NmQUR2Z1FidWZTelVENlgy?=
 =?iso-2022-jp?B?N1NSbGQ1c1ZRbjZsendQZDF5VkMrL3hjYzVZNEVKcThEb29adWI3eGpm?=
 =?iso-2022-jp?B?ajAweW8rb0V3NlVObitxdDM2bGNZZnNXU0FSeVdnd09mYUNuMlVMVndr?=
 =?iso-2022-jp?B?bGNDRy9rbXMwN29GSlRpQm9aaXprdVNtd2RocXNOWnlBNFgwdmdFa2ZP?=
 =?iso-2022-jp?B?OERWRXlDZmhUaW52dW5FUWc0QnJPREJsRVV1NW0xYTdXWW9hc2U3aGU4?=
 =?iso-2022-jp?B?N05mclorMXBTSy8vZk9hYzFlVjVJcUE5ckIwaHlWU3RhQWllU3BNWWtQ?=
 =?iso-2022-jp?B?Smw0MzltSUdWL1ZYSmF2MEJsY3o4aEVjNk5QMFdMdE83UGpkbGVxTnpp?=
 =?iso-2022-jp?B?NkluYnBOZU5kSkQ5dWlxSHJwU2dhNXNVeG5URDdkblZBZW1PQ3BKK0ZS?=
 =?iso-2022-jp?B?aWRVYVltSHdSVTg5RmYweW4ybzNWZDN6dmRHanBFOXNPZU0zNFdZcmNy?=
 =?iso-2022-jp?B?UTFDeW89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MjZIaEVBTXBLSG9IVmViMDJxTlFhVmtZVHFRb2RrdmZTL1NPUzNIWVg4?=
 =?iso-2022-jp?B?K2tGL1NiWWd4aG1aQS9CQndEa2VwRDRNRG85QnAvcTNCbVo2N0JjcWRy?=
 =?iso-2022-jp?B?bHZXbVUyakJWMjcyQVMwQTNJdG5vdEwxNi94azY4d2FWSmdLZ0JXNW9y?=
 =?iso-2022-jp?B?Wit1b0czajJsQzRCUmlYQkJmb2k4OVhJaHFkM2FpREYwTTZOZG52Q3BZ?=
 =?iso-2022-jp?B?VEtSQUdDRGFaVGkwMTA3TUdySWtKYkpUeWFjcnN0T25MMnp6VGp3TzE4?=
 =?iso-2022-jp?B?OFZkU0tEOElKbEhiSW9PQlJjcVhHOHBDV01oTEpDc3kyQmEwcVNmMGJj?=
 =?iso-2022-jp?B?ZDg1WFNPWENZK0VPalNWMmxGRjVWWWRsdERCVHlOVU0yQUdpWFJuZlR5?=
 =?iso-2022-jp?B?RzByWS9pQzdnWmZkY2c5NndvSTlTWndXSkpqQzdVYTU5akE4S0tZVllL?=
 =?iso-2022-jp?B?M0Z3Z0FYL0NPc0w0RDF0NGVEYW9wVm1PQVJzWGkwVEZuMktyVE0xNVNE?=
 =?iso-2022-jp?B?ZnFhMUJsY0VKREJWL2tmMElmcUdYZWgzd0FzUkhMM1BjWWZrR1VUYVVQ?=
 =?iso-2022-jp?B?UmtXQ3NZcGxkSDRibkNlMWduYmNVVWVwQmhZNm1DMUR5eUJ4akJuUXVL?=
 =?iso-2022-jp?B?QTIzbWtodHQrd3FZbHlQNXFoalFUcDFPMTA5REZKNmdsaWxJTlhSTHRO?=
 =?iso-2022-jp?B?VkZ3OERCTjZKT3h1TTFBN1ZGQkJXaDNZR3N1di9mS0M2VHdwQWsvNnR2?=
 =?iso-2022-jp?B?QThlM1QrRHdLZlZUUkNsNXZUbXBJbUFDbHZ5VFNUanJ6cXdDVEpURUIy?=
 =?iso-2022-jp?B?NklDdUw1ejRKVm11M0tnYnhjNndqZlFRSHhmSDNiYm1CVjBGTjlxNXdB?=
 =?iso-2022-jp?B?RzNCdkIxUWpaY3E5b3dSYmcwTlRKSFFRbkttdUFlTmNZYS95UmZ4czBO?=
 =?iso-2022-jp?B?azJzWFZKd2NCeDhSdWVCdm1GWjlpZzhzc2Zod0ZLb0VOdnE3QjhySVhq?=
 =?iso-2022-jp?B?OXZSUWwwOXRyUnU5aU9WUmxRSWttMnpGajdEYk4wc2ZxemV0Mzk2ZFdV?=
 =?iso-2022-jp?B?dGp6WjZWUHJpdXRST2s2TGxHRzNWRXNXU3I0TE1taWQ3VkdDazBVZXRT?=
 =?iso-2022-jp?B?RDdHM0IzRU1oeW05MVlpWHhDK0NjNndTOUE5OVdrQ09adHpIWEI0UmNx?=
 =?iso-2022-jp?B?SmRQTmdFVk43T0o4TG9lRjdIRFpUTXNYdDcvZm9sdjNXTmZlSG9hSVYw?=
 =?iso-2022-jp?B?OUpITXJIQmptTXRWSXlaK2FiN2RoK0d4c3ZINEt3MS81eVNwMktUdDNJ?=
 =?iso-2022-jp?B?cmVPOWlBaUVpNEhuaW9KK0xrOUQzNXBaZFk4bmRwSHc2TzZxMEFQWUQ2?=
 =?iso-2022-jp?B?ODJhcXo0eGJHd2tTL0NTZTZ0Q2hHamZzcVo1ZHhJci9nY09nMXRPTWND?=
 =?iso-2022-jp?B?QjUrK3pQNjNWSVNkYkFWRjlvUXVIYUx3QUwwVnlxTkRmSjgza2dWUTZo?=
 =?iso-2022-jp?B?S2kyYTRyK3hwSzNUWVIrRkhCbVhpdCtZUVVjK2VxcGZXZ3JNbDkwZGVu?=
 =?iso-2022-jp?B?VW5va0ZkdjBkQ0h2SUppaXVYZ1liSkVyZXg3cWI3MEJjWWowUkpyUmJt?=
 =?iso-2022-jp?B?bjhtVmxIcUxyUVRvUURvUzQ0VSs0b29qR3kwdGJSV3ZNS01YQ0R1L0hJ?=
 =?iso-2022-jp?B?MUFDKzY2azNEY1dqWGZXbGRBeXZ1VDRSNWRWQW5JZ3ZtM1JXRkQ5OVo1?=
 =?iso-2022-jp?B?UGNRVVArOUlnNkpBMWFJSjU0ZDhKS29YWGVQdkljbEJtRmdkMVlvalZO?=
 =?iso-2022-jp?B?RjRhNUdlc1haTnZETG9WY2JMQlN5YUxnUXNZWG5FdFAwYnhYSlFsZ2t0?=
 =?iso-2022-jp?B?MkN6d3JLTnVSQVA3a1FnZVZ2NUxEdlVxOU9jRjBmbFA4MG1YYUJQTmxH?=
 =?iso-2022-jp?B?VkJOaVAyaWJ1dnRCZGNNaTRWOWd6MU5BbmtiNjdCc2VVcWRQTVBIYjVS?=
 =?iso-2022-jp?B?ZDlwckZ6N3VKMUVaZEhrV3FpM0V1ay9KQnZYRWF4V2NpNDcxYzltbVNk?=
 =?iso-2022-jp?B?VXFKRmdUOUFoTkh1ZGFTc281WXRUU3I0bTNObnJKcmVKYm1mM2M5bVM2?=
 =?iso-2022-jp?B?MzlkOVk3bWZ5eGpXR1lmZVdQOFpmWm1KYStSZzREdXJBM2NoN2FyRlI5?=
 =?iso-2022-jp?B?UEFJa0N0NVhGaSt6REFxeXJaS1c1TzA3THVvdHVyekFCMDlKcEdpVHNG?=
 =?iso-2022-jp?B?ZDBJSFhZS1NPYzBmUjd0NzI1RWczUGdiN2h3UHBZdm5tUlExaEh2eUNC?=
 =?iso-2022-jp?B?MEl0QWJFUU9JN1dQM0YrY0hRLzljSFV0MldZZkpIY2V4N2ttMXJyVElq?=
 =?iso-2022-jp?B?TzBHZXlSc3NCWWtnb0pSQVlFWDQvdHJidm44UksxYnhyRXp3WFR5eVFr?=
 =?iso-2022-jp?B?Q2dUZGErZVlRaU1YR3VJRzBwWFYwc2k3TGE4bXdNclJlV0pnY25NbEVL?=
 =?iso-2022-jp?B?RFcwS3JaTm9NY2V4OXZmd2VKL3BJN2E0ZjdhenhhQXU3VmhjRUNCd0w0?=
 =?iso-2022-jp?B?UjFEelY5WT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f931165-763b-496e-8fc6-08de6861d283
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:04:08.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNIqkW3zYM3FR8BckVw52boQ2uJRUJ4pZFgTZ/dqQgVMe9fpHeZTAOBXDzNItKz14AOe6ZlVueOWe4MYdDP1p/91T+dzAXCC50L+up5HrxjYORiXm3D6qsBFyN6iloZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 05:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21849

Hi,

Thanks for your patch.
I tested this patch series on 049ea8ff8370a10d88214b2d488ef6f7c1d28a4e (mas=
ter)
My board fails to boot. I pasted the boot log below.

Best regards,
  Nobuhiro

```
HSS: decompressing from eNVM to L2 Scratch ... Passed
DDR training ... Passed ( 5401 ms)

---------------------------------
--        BeagleV-Fire         --
---------------------------------

[5.464693] PolarFire(R) SoC Hart Software Services (HSS) - version 0.99.36-=
BVF-0.3.0
MPFS HAL version 2.2.104 / DDR Driver version 0.4.023 / Mi-V IHC version 0.=
1.1 / BOARD=3Dbvf
(c) Copyright 2017-2022 Microchip FPGA Embedded Systems Solutions.

incorporating OpenSBI - version 1.2
(c) Copyright 2019-2022 Western Digital Corporation.

[5.495680] Build ID: 3f0ed536ff6a0aaef3c9b81896adaee39ec4d8c1
[5.502538] Built with the following tools:
 - riscv64-unknown-elf-gcc (xPack GNU RISC-V Embedded GCC (Microsemi SoftCo=
nsole build), 64-bit) 8.3.0
 - GNU ld (xPack GNU RISC-V Embedded GCC (Microsemi SoftConsole build), 64-=
bit) 2.32

[5.524411] NOTICE: Running from L2 Scratchpad

[5.530053] Serial Number:
9d5ab5e2c5711676ace9e5cd4b2b1dd00000000000000000000000000000000000000000000=
0000000000000000000000000
[5.542726] Segment Configuration:
        Cached: SEG0_0: offset 0x0080000000, physical DDR 0x00000000
        Cached: SEG0_1: offset 0x1000000000, physical DDR 0x00000000
    Non-cached: SEG1_2: offset 0x00c0000000, physical DDR 0x00000000
    Non-cached: SEG1_3: offset 0x1400000000, physical DDR 0x00000000
Non-cached WCB: SEG1_4: offset 0x00d0000000, physical DDR 0x00000000
Non-cached WCB: SEG1_5: offset 0x1800000000, physical DDR 0x00000000
[5.583609] L2 Cache Configuration:
    L2-Scratchpad:  4 ways (512 KiB)
         L2-Cache:  8 ways (1024 KiB)
           L2-LIM:  4 ways (512 KiB)
[5.598104] DDR-Lo size is   32 MiB
[5.602358] DDR-Hi size is 1888 MiB
[5.626176] Design Info:
    Design Name: CI_DEFAULT_FD28A2CA1789CDC1137
    Design Version: 02.00.2
[5.636592] Attempting to select eMMC ... Passed
[5.891124] User button NOT pressed
Press a key to enter CLI, ESC to skip
Timeout in 1 second
..
[6.900764] CLI boot interrupt timeout
[6.905278] Initializing Mi-V IHC
[6.909357] Initializing IPI Queues (3304 bytes @ a02e660)...
[6.915867] Initializing PMPs
[6.919600] Initializing Boot Image ...
[6.924200] Trying to boot via MMC ...
[6.928714] Attempting to select eMMC ... Passed
[7.183124] Preparing to copy from MMC to DDR ...
[7.188654] Validated GPT Header ...
[7.204547] Validated GPT Partition Entries ...
[7.209842] Boot Partition found at index 0
[7.214789] Attempting to read image header (1632 bytes) ...
[7.221221] Copying 601712 bytes to 0x103fc00000
[7.230057] MMC: Boot Image registered ...
[7.234918] Boot image passed CRC
[7.239258] Boot image set name: "PolarFire-SoC-HSS::U-Boot"


U-Boot 2026.01 (Jan 01 1970 - 01:00:00 +0000)

alloc space exhausted ptr 2010 limit 2000
CPU:   sifive,u54-mc
Model: BeagleBoard BeagleV-Fire
DRAM:  1 GiB
Core:  68 devices, 14 uclasses, devicetree: separate
MMC:   mmc@20008000: 0
Loading Environment from nowhere... OK
In:    serial@20000000
Out:   serial@20000000
Err:   serial@20000000
Net:
Error: ethernet@20110000 No valid MAC address found.
No ethernet found.

Hit any key to stop autoboot: 0
switch to partitions #0, OK
mmc0(part 0) is current device
Scanning mmc 0:2...
Failed to load '/'
Failed to load EFI variables

Error: ethernet@20110000 No valid MAC address found.

Error: ethernet@20110000 No valid MAC address found.

Error: ethernet@20110000 No valid MAC address found.

Error: ethernet@20110000 No valid MAC address found.
Booting: Label: mmc 0 Device path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f36=
28b,0000000000000000)/VenHw(e61d73b9-a384-)
EFI stub: Booting Linux Kernel...
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...

Error: ethernet@20110000 No valid MAC address found.

Error: ethernet@20110000 No valid MAC address found.
[    0.000000] Linux version 6.12.63-cip15 (isar-users@googlegroups.com) (r=
iscv64-linux-gnu-gcc (Debian 14.2.0-19) 140
[    0.000000] Machine model: BeagleBoard BeagleV-Fire
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10002
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] efi: EFI v2.11 by Das U-Boot
[    0.000000] efi: RTPROP=3D0xbe335040 SMBIOS 3.0=3D0xbf387000 INITRD=3D0x=
be2ed040 MEMRESERVE=3D0xbe2ec040
[    0.000000] OF: reserved mem: failed to allocate memory for node 'non-ca=
ched-low-buffer': size 64 MiB
[    0.000000] OF: reserved mem: failed to allocate memory for node 'non-ca=
ched-high-buffer': size 256 MiB
[    0.000000] OF: reserved mem: 0x00000000d8000000..0x00000000d9ffffff (32=
768 KiB) nomap non-reusable buffer@d8000000
[    0.000000] OF: reserved mem: 0x00000000c8000000..0x00000000c9ffffff (32=
768 KiB) nomap non-reusable buffer@c8000000
[    0.000000] OF: reserved mem: 0x0000000088000000..0x0000000089ffffff (32=
768 KiB) nomap non-reusable buffer@88000000
[    0.000000] Reserved memory: created DMA memory pool at 0x000000103fc000=
00, size 4 MiB
[    0.000000] OF: reserved mem: initialized node hss-buffer@103fc00000, co=
mpatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000103fc00000..0x000000103fffffff (40=
96 KiB) nomap non-reusable hss-buffer@103f0
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000103fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x0000000087ffffff]
[    0.000000]   node   0: [mem 0x0000000088000000-0x0000000089ffffff]
[    0.000000]   node   0: [mem 0x000000008a000000-0x00000000bdffffff]
[    0.000000]   node   0: [mem 0x00000000be000000-0x00000000be000fff]
[    0.000000]   node   0: [mem 0x00000000be001000-0x00000000be334fff]
[    0.000000]   node   0: [mem 0x00000000be335000-0x00000000be335fff]
[    0.000000]   node   0: [mem 0x00000000be336000-0x00000000be336fff]
[    0.000000]   node   0: [mem 0x00000000be337000-0x00000000be358fff]
[    0.000000]   node   0: [mem 0x00000000be359000-0x00000000bf386fff]
[    0.000000]   node   0: [mem 0x00000000bf387000-0x00000000bf387fff]
[    0.000000]   node   0: [mem 0x00000000bf388000-0x00000000bfb6bfff]
[    0.000000]   node   0: [mem 0x00000000bfb6c000-0x00000000bfb6dfff]
[    0.000000]   node   0: [mem 0x00000000bfb6e000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x00000000c8000000-0x00000000c9ffffff]
[    0.000000]   node   0: [mem 0x00000000d8000000-0x00000000d9ffffff]
[    0.000000]   node   0: [mem 0x000000103fc00000-0x000000103fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000103ffff=
fff]
[    0.000000] On node 0, zone DMA32: 24576 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 56320 pages in unavailable ranges
[    0.000000] SBI HSM extension detected
[    0.000000] Falling back to deprecated "riscv,isa"
[    0.000000] riscv: base ISA extensions acdfim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 22 pages/cpu s50024 r8192 d31896 u90112
[    0.000000] Kernel command line: initrd=3D\initrd.img-6.12.63-cip15 LABE=
L=3DBoot root=3DPARTUUID=3Dbac9149c-8332-4f2b-a225w
[    0.000000] Unknown kernel command line parameters "LABEL=3DBoot", will =
be passed to user space.
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 b=
ytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 27955=
2
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000b4e00000-0x00000000b8=
e00000] (64MB)
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xffffffc4fea00000 - 0xffffffc4ff000000   (61=
44 kB)
[    0.000000]       pci io : 0xffffffc4ff000000 - 0xffffffc500000000   (  =
16 MB)
[    0.000000]      vmemmap : 0xffffffc500000000 - 0xffffffc600000000   (40=
96 MB)
[    0.000000]      vmalloc : 0xffffffc600000000 - 0xffffffd600000000   (  =
64 GB)
[    0.000000]      modules : 0xffffffff01794000 - 0xffffffff80000000   (20=
24 MB)
[    0.000000]       lowmem : 0xffffffd600000000 - 0xffffffe5c0000000   (  =
63 GB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (20=
47 MB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_id=
s=3D4.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D4.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] riscv: providing IPIs using SBI IPI extension
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1d854df40, max_idle_ns: 3526361s
[    0.000003] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps ev=
ery 2199023255500ns
[    0.000628] Console: colour dummy device 80x25
[    0.000658] printk: legacy console [tty0] enabled
[    0.002546] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2.00 BogoMIPS (lpj=3D4000)
[    0.002624] pid_max: default: 32768 minimum: 301
[    0.002845] LSM: initializing lsm=3Dcapability
[    0.003339] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes,=
 linear)
[    0.003484] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 b=
ytes, linear)
[    0.007294] CPU node for /cpus/cpu@0 exist but the possible cpu range is=
 :0-3
[    0.012353] riscv: ELF compat mode unsupported
[    0.012383] ASID allocator disabled (0 bits)
[    0.012907] rcu: Hierarchical SRCU implementation.
[    0.012954] rcu:     Max phase no-delay instances is 1000.
[    0.013953] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.014734] Remapping and enabling EFI services.
[    0.016088] smp: Bringing up secondary CPUs ...
[    0.022908] smp: Brought up 1 node, 4 CPUs
[    0.025064] Memory: 869308K/1118208K available (11596K kernel code, 4965=
K rwdata, 4096K rodata, 2273K init, 517K b)
[    0.027073] devtmpfs: initialized
[    0.038369] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.038491] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.039485] pinctrl core: initialized pinctrl subsystem
[    0.041172] SMBIOS 3.7.0 present.
[    0.041262] DMI: beagle BeagleBoard BeagleV-Fire/BeagleBoard BeagleV-Fir=
e, BIOS 2026.01 01/01/2026
[    0.041357] DMI: Memory slots populated: 0/0
[    0.043197] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.044109] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.044230] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.044519] audit: initializing netlink subsys (disabled)
[    0.045141] audit: type=3D2000 audit(0.044:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    0.046076] thermal_sys: Registered thermal governor 'step_wise'
[    0.046213] cpuidle: using governor menu
[    0.072606] cpu1: Ratio of byte access time to unaligned word access is =
0.01, unaligned accesses are slow
[    0.072606] cpu3: Ratio of byte access time to unaligned word access is =
0.01, unaligned accesses are slow
[    0.072633] cpu2: Ratio of byte access time to unaligned word access is =
0.01, unaligned accesses are slow
[    0.096718] cpu0: Ratio of byte access time to unaligned word access is =
0.01, unaligned accesses are slow
[    0.097122] CCACHE: 4 banks, 16 ways, sets/bank=3D512, bytes/block=3D64
[    0.097181] CCACHE: Index of the largest way enabled: 11
[    0.120441] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependenc=
y cycle(s) with /fabric-pcie-bus@3000000000
[    0.121236] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependenc=
y cycle(s) with /fabric-pcie-bus@3000000000
[    0.121476] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependenc=
y cycle(s) with /fabric-pcie-bus@300000000r
[    0.125897] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.125966] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.128097] ACPI: Interpreter disabled.
[    0.128795] iommu: Default domain type: Translated
[    0.128843] iommu: DMA domain TLB invalidation policy: strict mode
[    0.131990] SCSI subsystem initialized
[    0.133154] usbcore: registered new interface driver usbfs
[    0.133294] usbcore: registered new interface driver hub
[    0.133432] usbcore: registered new device driver usb
[    0.134931] efivars: Registered efivars operations
[    0.136181] Advanced Linux Sound Architecture Driver Initialized.
[    0.138550] vgaarb: loaded
[    0.139556] clocksource: Switched to clocksource riscv_clocksource
[    0.141508] pnp: PnP ACPI: disabled
[    0.167966] NET: Registered PF_INET protocol family
[    0.169012] IP idents hash table entries: 16384 (order: 5, 131072 bytes,=
 linear)
[    0.174128] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, =
16384 bytes, linear)
[    0.174331] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.174427] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes, linear)
[    0.175045] TCP bind hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.178666] TCP: Hash tables configured (established 8192 bind 8192)
[    0.179690] UDP hash table entries: 512 (order: 4, 49152 bytes, linear)
[    0.180092] UDP-Lite hash table entries: 512 (order: 4, 49152 bytes, lin=
ear)
[    0.180915] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.182745] RPC: Registered named UNIX socket transport module.
[    0.182811] RPC: Registered udp transport module.
[    0.182846] RPC: Registered tcp transport module.
[    0.182879] RPC: Registered tcp-with-tls transport module.
[    0.182913] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.182970] PCI: CLS 0 bytes, default 64
[    0.184816] Unpacking initramfs...
[    0.186040] workingset: timestamp_bits=3D46 max_order=3D18 bucket_order=
=3D0
[    0.187088] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.188252] NFS: Registering the id_resolver key type
[    0.188379] Key type id_resolver registered
[    0.188418] Key type id_legacy registered
[    0.188526] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.188575] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    0.189155] 9p: Installing v9fs 9p2000 file system support
[    0.192783] NET: Registered PF_ALG protocol family
[    0.193047] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 245)
[    0.193680] io scheduler mq-deadline registered
[    0.193733] io scheduler kyber registered
[    0.193884] io scheduler bfq registered
[    0.196727] riscv-plic: interrupt-controller@c000000: mapped 186 interru=
pts with 4 handlers for 9 contexts.
[    0.200586] SBI CPPC extension NOT detected!!
[    0.369675] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.376972] 20000000.serial: ttyS0 at MMIO 0x20000000 (irq =3D 12, base_=
baud =3D 9375000) is a 16550A
[    0.377122] printk: legacy console [ttyS0] enabled
[    1.457413] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq =3D 13, base_=
baud =3D 9375000) is a 16550A
[    1.469786] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq =3D 14, base_=
baud =3D 9375000) is a 16550A
[    1.482290] 20106000.serial: ttyS3 at MMIO 0x20106000 (irq =3D 15, base_=
baud =3D 9375000) is a 16550A
[    1.493011] SuperH (H)SCI(F) driver initialized
[    1.498885] [drm] radeon kernel modesetting enabled.
[    1.525663] loop: module loaded
[    1.536543] ------------[ cut here ]------------
[    1.541291] macb 20110000.ethernet: device non-coherent but no non-coher=
ent operations supported
[    1.541323] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/dma-noncoherent.c:13=
9 arch_setup_dma_ops+0x6e/0xac
[    1.541380] Modules linked in:
[    1.541402] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.63-cip=
15 #1
[    1.541426] Hardware name: beagle BeagleBoard BeagleV-Fire/BeagleBoard B=
eagleV-Fire, BIOS 2026.01 01/01/2026
[    1.541438] epc : arch_setup_dma_ops+0x6e/0xac
[    1.541461]  ra : arch_setup_dma_ops+0x6e/0xac
[    1.541482] epc : ffffffff8000f918 ra : ffffffff8000f918 sp : ffffffc600=
023b90
[    1.541498]  gp : ffffffff81710e00 tp : ffffffd600160000 t0 : ffffffff81=
619398
[    1.541513]  t1 : 0720072007200720 t2 : 2d2d2d2d2d2d2d2d s0 : ffffffc600=
023bb0
[    1.541529]  s1 : 0000000000000000 a0 : 0000000000000054 a1 : ffffffff81=
6856c0
[    1.541544]  a2 : 0000000000000010 a3 : 00000000000000b1 a4 : 0000000000=
000000
[    1.541557]  a5 : 0000000000000000 a6 : ffffffff81726f10 a7 : 0000000000=
000000
[    1.541571]  s2 : ffffffd600843410 s3 : ffffffd63ffec618 s4 : 0000000000=
000000
[    1.541586]  s5 : 0000000000000001 s6 : ffffffff80e00870 s7 : 0000000000=
000008
[    1.541600]  s8 : ffffffff813305c0 s9 : 0000000000000000 s10: 0000000000=
000000
[    1.541614]  s11: 0000000000000000 t3 : ffffffd600080f00 t4 : ffffffd600=
080f00
[    1.541629]  t5 : ffffffd600080000 t6 : ffffffc600023998
[    1.541641] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    1.541658] [<ffffffff8000f918>] arch_setup_dma_ops+0x6e/0xac
[    1.541683] [<ffffffff809187e0>] of_dma_configure_id+0xca/0x204
[    1.541727] [<ffffffff8074103e>] platform_dma_configure+0xb6/0xba
[    1.541766] [<ffffffff8073eaf2>] really_probe+0x54/0x22e
[    1.541790] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    1.541814] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    1.541838] [<ffffffff8073efea>] __driver_attach+0x6c/0x11a
[    1.541861] [<ffffffff8073cc84>] bus_for_each_dev+0x62/0xb0
[    1.541883] [<ffffffff8073e564>] driver_attach+0x1a/0x22
[    1.541905] [<ffffffff8073de9a>] bus_add_driver+0xce/0x1d6
[    1.541928] [<ffffffff8073fb8a>] driver_register+0x40/0xda
[    1.541952] [<ffffffff80740dc0>] __platform_driver_register+0x1c/0x24
[    1.541980] [<ffffffff80c32d48>] macb_driver_init+0x1a/0x22
[    1.542011] [<ffffffff80002130>] do_one_initcall+0x5c/0x1b2
[    1.542032] [<ffffffff80c01254>] kernel_init_freeable+0x214/0x27c
[    1.542071] [<ffffffff80b4c64a>] kernel_init+0x1e/0x112
[    1.542115] [<ffffffff80b5521a>] ret_from_fork+0xe/0x18
[    1.542142] ---[ end trace 0000000000000000 ]---
[    1.702338] Freeing initrd memory: 10656K
[    1.821864] macb 20110000.ethernet eth0: Cadence GEM rev 0x0107010c at 0=
x20110000 irq 16 (00:04:a3:b5:5a:9e)
[    1.832240] ------------[ cut here ]------------
[    1.836932] macb 20112000.ethernet: device non-coherent but no non-coher=
ent operations supported
[    1.836962] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/dma-noncoherent.c:13=
9 arch_setup_dma_ops+0x6e/0xac
[    1.837012] Modules linked in:
[    1.837035] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G S           =
      6.12.63-cip15 #1
[    1.837062] Tainted: [S]=3DCPU_OUT_OF_SPEC
[    1.837070] Hardware name: beagle BeagleBoard BeagleV-Fire/BeagleBoard B=
eagleV-Fire, BIOS 2026.01 01/01/2026
[    1.837083] epc : arch_setup_dma_ops+0x6e/0xac
[    1.837105]  ra : arch_setup_dma_ops+0x6e/0xac
[    1.837127] epc : ffffffff8000f918 ra : ffffffff8000f918 sp : ffffffc600=
023b90
[    1.837143]  gp : ffffffff81710e00 tp : ffffffd600160000 t0 : ffffffff81=
61a158
[    1.837158]  t1 : 0720072007200720 t2 : 2d2d2d2d2d2d2d2d s0 : ffffffc600=
023bb0
[    1.837174]  s1 : 0000000000000000 a0 : 0000000000000054 a1 : ffffffff81=
6856c0
[    1.837189]  a2 : 0000000000000010 a3 : 00000000000000d9 a4 : 0000000000=
000000
[    1.837202]  a5 : 0000000000000000 a6 : ffffffff81726f10 a7 : 0000000000=
000000
[    1.837216]  s2 : ffffffd60083c010 s3 : ffffffd63ffed020 s4 : 0000000000=
000000
[    1.837231]  s5 : 0000000000000001 s6 : ffffffff80e00870 s7 : 0000000000=
000008
[    1.837245]  s8 : ffffffff813305c0 s9 : 0000000000000000 s10: 0000000000=
000000
[    1.837259]  s11: 0000000000000000 t3 : ffffffd600080f00 t4 : ffffffd600=
080f00
[    1.837273]  t5 : ffffffd600080000 t6 : ffffffc600023998
[    1.837286] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    1.837303] [<ffffffff8000f918>] arch_setup_dma_ops+0x6e/0xac
[    1.837327] [<ffffffff809187e0>] of_dma_configure_id+0xca/0x204
[    1.837371] [<ffffffff8074103e>] platform_dma_configure+0xb6/0xba
[    1.837409] [<ffffffff8073eaf2>] really_probe+0x54/0x22e
[    1.837433] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    1.837457] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    1.837480] [<ffffffff8073efea>] __driver_attach+0x6c/0x11a
[    1.837504] [<ffffffff8073cc84>] bus_for_each_dev+0x62/0xb0
[    1.837526] [<ffffffff8073e564>] driver_attach+0x1a/0x22
[    1.837547] [<ffffffff8073de9a>] bus_add_driver+0xce/0x1d6
[    1.837570] [<ffffffff8073fb8a>] driver_register+0x40/0xda
[    1.837595] [<ffffffff80740dc0>] __platform_driver_register+0x1c/0x24
[    1.837622] [<ffffffff80c32d48>] macb_driver_init+0x1a/0x22
[    1.837653] [<ffffffff80002130>] do_one_initcall+0x5c/0x1b2
[    1.837673] [<ffffffff80c01254>] kernel_init_freeable+0x214/0x27c
[    1.837714] [<ffffffff80b4c64a>] kernel_init+0x1e/0x112
[    1.837756] [<ffffffff80b5521a>] ret_from_fork+0xe/0x18
[    1.837782] ---[ end trace 0000000000000000 ]---
[    2.099724] macb 20112000.ethernet eth1: Cadence GEM rev 0x0107010c at 0=
x20112000 irq 20 (00:04:a3:b5:5a:9d)
[    2.110244] e1000e: Intel(R) PRO/1000 Network Driver
[    2.115310] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.124095] usbcore: registered new interface driver uas
[    2.129662] usbcore: registered new interface driver usb-storage
[    2.136938] mousedev: PS/2 mouse device common for all mice
[    2.143855] mpfs_rtc 20124000.rtc: prescaler set to: 999999
[    2.150660] mpfs_rtc 20124000.rtc: registered as rtc0
[    2.155871] mpfs_rtc 20124000.rtc: setting system clock to 1970-01-01T00=
:00:00 UTC (0)
[    2.164885] microchip-corei2c 2010a000.i2c: registered CoreI2C bus drive=
r
[    2.173376] microchip-corei2c 2010b000.i2c: registered CoreI2C bus drive=
r
[    2.182721] sdhci: Secure Digital Host Controller Interface driver
[    2.189027] sdhci: Copyright(c) Pierre Ossman
[    2.194053] Synopsys Designware Multimedia Card Interface Driver
[    2.200395] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.207424] usbcore: registered new interface driver usbhid
[    2.213124] usbhid: USB HID core driver
[    2.213364] ------------[ cut here ]------------
[    2.217575] mpfs-mailbox 37020000.mailbox: Registered MPFS mailbox contr=
oller driver
[    2.221666] sdhci-cdns 20008000.mmc: device non-coherent but no non-cohe=
rent operations supported
[    2.221691] WARNING: CPU: 2 PID: 62 at arch/riscv/mm/dma-noncoherent.c:1=
39 arch_setup_dma_ops+0x6e/0xac
[    2.221744] Modules linked in:
[    2.221765] CPU: 2 UID: 0 PID: 62 Comm: kworker/u17:1 Tainted: G S      =
           6.12.63-cip15 #1
[    2.221792] Tainted: [S]=3DCPU_OUT_OF_SPEC
[    2.221801] Hardware name: beagle BeagleBoard BeagleV-Fire/BeagleBoard B=
eagleV-Fire, BIOS 2026.01 01/01/2026
[    2.221814] Workqueue: async async_run_entry_fn
[    2.221843] epc : arch_setup_dma_ops+0x6e/0xac
[    2.221865]  ra : arch_setup_dma_ops+0x6e/0xac
[    2.221886] epc : ffffffff8000f918 ra : ffffffff8000f918 sp : ffffffc600=
263c50
[    2.221902]  gp : ffffffff81710e00 tp : ffffffd6008a6400 t0 : ffffffff81=
61b4f0
[    2.221917]  t1 : 000000000000002d t2 : 2d2d2d2d2d2d2d2d s0 : ffffffc600=
263c70
[    2.221932]  s1 : 0000000000000000 a0 : 0000000000000055 a1 : 0000000200=
000020
[    2.221946]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000=
000000
[    2.221959]  a5 : 0000000000000000 a6 : ffffffff81615628 a7 : 0000000000=
000000
[    2.221973]  s2 : ffffffd600846c10 s3 : ffffffd63ffe8560 s4 : 0000000000=
000000
[    2.221988]  s5 : 0000000000000001 s6 : ffffffd600b4b388 s7 : ffffffd600=
3fc180
[    2.222003]  s8 : ffffffd60005d000 s9 : 0000000000000000 s10: 0000000000=
000000
[    2.222018]  s11: 0000000000000000 t3 : ffffffff81726f1f t4 : ffffffff81=
726f1f
[    2.222032]  t5 : ffffffff81726f20 t6 : ffffffff8172c71d
[    2.222044] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    2.222060] [<ffffffff8000f918>] arch_setup_dma_ops+0x6e/0xac
[    2.222085] [<ffffffff809187e0>] of_dma_configure_id+0xca/0x204
[    2.222123] [<ffffffff8074103e>] platform_dma_configure+0xb6/0xba
[    2.222160] [<ffffffff8073eaf2>] really_probe+0x54/0x22e
[    2.222184] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    2.222208] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    2.222232] [<ffffffff8073f0ce>] __driver_attach_async_helper+0x36/0x7e
[    2.222257] [<ffffffff8003c09e>] async_run_entry_fn+0x22/0xc4
[    2.222281] [<ffffffff8002e05c>] process_one_work+0x120/0x216
[    2.222318] [<ffffffff8002e896>] worker_thread+0x206/0x2e2
[    2.222345] [<ffffffff80036090>] kthread+0xc4/0xde
[    2.222374] [<ffffffff80b5521a>] ret_from_fork+0xe/0x18
[    2.222408] ---[ end trace 0000000000000000 ]---
[    2.255353] mmc0: SDHCI controller on 20008000.mmc [20008000.mmc] using =
ADMA 64-bit
[    2.261190] riscv-pmu-sbi: SBI PMU extension is available
[    2.461291] riscv-pmu-sbi: 16 firmware and 4 hardware counters
[    2.467214] riscv-pmu-sbi: Perf sampling/filtering is not supported as s=
scof extension is not available
[    2.481043] NET: Registered PF_INET6 protocol family
[    2.489898] Segment Routing with IPv6
[    2.493830] In-situ OAM (IOAM) with IPv6
[    2.498033] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.505446] NET: Registered PF_PACKET protocol family
[    2.510903] 9pnet: Installing 9P2000 support
[    2.515449] Key type dns_resolver registered
[    2.586078] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating ar=
chitecture page table helpers
[    2.589668] mmc0: ADMA error: 0x02000000
[    2.599386] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.605894] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000003
[    2.611451] clk: Disabling unused clocks
[    2.612356] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
[    2.612375] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[    2.612390] mmc0: sdhci: Present:   0x01f702f6 | Host ctl: 0x00000011
[    2.612405] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[    2.612420] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
[    2.616484] PM: genpd: Disabling unused power domains
[    2.622784] mmc0: sdhci: Timeout:   0x0000000c | Int stat: 0x00000001
[    2.622800] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
[    2.622815] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[    2.629312] ALSA device list:
[    2.635702] mmc0: sdhci: Caps:      0x176ac8b2 | Caps_1:   0x10000077
[    2.635719] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00202020
[    2.635735] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[    2.642197]   No soundcards found.
[    2.648608] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x3fd04f01
[    2.648623] mmc0: sdhci: Host ctl2: 0x00003000
[    2.648636] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x00000014036=
f8200
[    2.648653] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[    2.723580] mmc0: sdhci: 14036f8200: DMA 0x00000014036ffc00, LEN 0x0200,=
 Attr=3D0x21
[    2.723603] mmc0: sdhci: 14036f8210: DMA 0x0000000000000000, LEN 0x0000,=
 Attr=3D0x03
[    2.738876] CCACHE: DataError @ 0x00000000.081DFFE8
[    2.743801] CCACHE: DataFail @ 0x00000000.081DFFF8
[    2.748914] mmc0: error -5 whilst initialising MMC card
[    2.755737] Freeing unused kernel image (initmem) memory: 2272K
[    2.762118] Run /init as init process
Loading, please wait...
[    2.836185] mmc0: new MMC card at address 0001
[    2.844066] mmcblk0: mmc0:0001 TB2916 0 B
Starting systemd-udevd version 257.9-1~deb13u1
[    4.603957] macb 20112000.ethernet end0: renamed from eth1
[    4.655107] ------------[ cut here ]------------
[    4.659991] mpfs-musb 20201000.usb: device non-coherent but no non-coher=
ent operations supported
[    4.660026] WARNING: CPU: 1 PID: 122 at arch/riscv/mm/dma-noncoherent.c:=
139 arch_setup_dma_ops+0x6e/0xac
[    4.660087] Modules linked in: mpfs(+) phy_generic musb_hdrc spi_microch=
ip_core_qspi(+)
[    4.660145] CPU: 1 UID: 0 PID: 122 Comm: (udev-worker) Tainted: G S     =
            6.12.63-cip15 #1
[    4.660173] Tainted: [S]=3DCPU_OUT_OF_SPEC
[    4.660182] Hardware name: beagle BeagleBoard BeagleV-Fire/BeagleBoard B=
eagleV-Fire, BIOS 2026.01 01/01/2026
[    4.660195] epc : arch_setup_dma_ops+0x6e/0xac
[    4.660220]  ra : arch_setup_dma_ops+0x6e/0xac
[    4.660242] epc : ffffffff8000f918 ra : ffffffff8000f918 sp : ffffffc600=
4538c0
[    4.660259]  gp : ffffffff81710e00 tp : ffffffd603abd780 t0 : ffffffff81=
61d2d8
[    4.660274]  t1 : 0720072007200720 t2 : 2d2d2d2d2d2d2d2d s0 : ffffffc600=
4538e0
[    4.660290]  s1 : 0000000000000000 a0 : 0000000000000054 a1 : ffffffff81=
6856c0
[    4.660305]  a2 : 0000000000000010 a3 : 0000000000000169 a4 : 0000000000=
000000
[    4.660318]  a5 : 0000000000000000 a6 : ffffffff81726f10 a7 : 0000000000=
000000
[    4.660333]  s2 : ffffffd60084c010 s3 : ffffffd63fff0078 s4 : 0000000000=
000000
[    4.660348]  s5 : 0000000000000001 s6 : ffffffc600453d48 s7 : 0000000000=
000000
[    4.660361]  s8 : ffffffff017ba118 s9 : ffffffc600453c90 s10: ffffffc600=
453c40
[    4.660378]  s11: 0000000000000000 t3 : ffffffd600080f00 t4 : ffffffd600=
080f00
[    4.660393]  t5 : ffffffd600080000 t6 : ffffffc6004536c8
[    4.660407] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    4.660422] [<ffffffff8000f918>] arch_setup_dma_ops+0x6e/0xac
[    4.660451] [<ffffffff809187e0>] of_dma_configure_id+0xca/0x204
[    4.660499] [<ffffffff8074103e>] platform_dma_configure+0xb6/0xba
[    4.660541] [<ffffffff8073eaf2>] really_probe+0x54/0x22e
[    4.660566] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    4.660590] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    4.660614] [<ffffffff8073efea>] __driver_attach+0x6c/0x11a
[    4.660642] [<ffffffff8073cc84>] bus_for_each_dev+0x62/0xb0
[    4.660665] [<ffffffff8073e564>] driver_attach+0x1a/0x22
[    4.660687] [<ffffffff8073de9a>] bus_add_driver+0xce/0x1d6
[    4.660711] [<ffffffff8073fb8a>] driver_register+0x40/0xda
[    4.660735] [<ffffffff80740dc0>] __platform_driver_register+0x1c/0x24
[    4.660768] [<ffffffff017be020>] mpfs_musb_driver_init+0x20/0x1000 [mpfs=
]
[    4.660819] [<ffffffff80002130>] do_one_initcall+0x5c/0x1b2
[    4.660841] [<ffffffff80092606>] do_init_module+0x52/0x1d4
[    4.660866] [<ffffffff80093d30>] load_module+0x1392/0x17fe
[    4.660889] [<ffffffff8009435e>] init_module_from_file+0x76/0xae
[    4.660911] [<ffffffff80094574>] __riscv_sys_finit_module+0x1a6/0x310
[    4.660935] [<ffffffff80b4b6bc>] do_trap_ecall_u+0x1a8/0x1d4
[    4.660980] [<ffffffff80b55102>] handle_exception+0x146/0x152
[    4.661018] ---[ end trace 0000000000000000 ]---
[    4.669715] mpfs-rng mpfs-rng: Registered MPFS hwrng
[    4.673005] usb_phy_generic usb_phy_generic.1.auto: dummy supplies not a=
llowed for exclusive requests (id=3Dvbus)
[    4.682724] mpfs-sys-controller syscontroller: Registered MPFS system co=
ntroller
[    4.690897] ------------[ cut here ]------------
[    4.720705] random: crng init done
[    4.722651] musb-hdrc musb-hdrc.2.auto: device non-coherent but no non-c=
oherent operations supported
[    4.963645] WARNING: CPU: 1 PID: 122 at arch/riscv/mm/dma-noncoherent.c:=
139 arch_setup_dma_ops+0x6e/0xac
[    4.963714] Modules linked in: mpfs(+) phy_generic musb_hdrc spi_microch=
ip_core_qspi
[    4.963770] CPU: 1 UID: 0 PID: 122 Comm: (udev-worker) Tainted: G S     =
            6.12.63-cip15 #1
[    4.963800] Tainted: [S]=3DCPU_OUT_OF_SPEC
[    4.963809] Hardware name: beagle BeagleBoard BeagleV-Fire/BeagleBoard B=
eagleV-Fire, BIOS 2026.01 01/01/2026
[    4.963821] epc : arch_setup_dma_ops+0x6e/0xac
[    4.963845]  ra : arch_setup_dma_ops+0x6e/0xac
[    4.963868] epc : ffffffff8000f918 ra : ffffffff8000f918 sp : ffffffc600=
453590
[    4.963883]  gp : ffffffff81710e00 tp : ffffffd603abd780 t0 : ffffffff80=
b3ad1c
[    4.963898]  t1 : 0720072007200720 t2 : 63203a6d6f646e61 s0 : ffffffc600=
4535b0
[    4.963914]  s1 : 0000000000000000 a0 : 0000000000000058 a1 : ffffffff81=
6856c0
[    4.963929]  a2 : 0000000000000010 a3 : 0000000000000197 a4 : 0000000000=
000000
[    4.963943]  a5 : 0000000000000000 a6 : ffffffff81726f10 a7 : 0000000000=
000065
[    4.963957]  s2 : ffffffd60085b010 s3 : ffffffd63fff0078 s4 : 0000000000=
000000
[    4.963972]  s5 : 0000000000000001 s6 : ffffffd603876ea0 s7 : ffffffd600=
84c000
[    4.963988]  s8 : ffffffd60085b010 s9 : ffffffc600453c90 s10: ffffffc600=
453c40
[    4.964003]  s11: 0000000000000000 t3 : ffffffd600080f00 t4 : ffffffd600=
080f00
[    4.964018]  t5 : ffffffd600080000 t6 : ffffffc600453398
[    4.964031] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    4.964047] [<ffffffff8000f918>] arch_setup_dma_ops+0x6e/0xac
[    4.964075] [<ffffffff809187e0>] of_dma_configure_id+0xca/0x204
[    4.964121] [<ffffffff8074103e>] platform_dma_configure+0xb6/0xba
[    4.964163] [<ffffffff8073eaf2>] really_probe+0x54/0x22e
[    4.964189] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    4.964213] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    4.964237] [<ffffffff8073ef5e>] __device_attach_driver+0x6e/0x8e
[    4.964262] [<ffffffff8073ce3c>] bus_for_each_drv+0x66/0xba
[    4.964283] [<ffffffff8073f198>] __device_attach+0x82/0x136
[    4.964308] [<ffffffff8073f39c>] device_initial_probe+0xe/0x16
[    4.964333] [<ffffffff8073dce2>] bus_probe_device+0x86/0x88
[    4.964355] [<ffffffff8073b9fc>] device_add+0x504/0x6d0
[    4.964375] [<ffffffff80740c40>] platform_device_add+0xce/0x1d4
[    4.964407] [<ffffffff017b8576>] mpfs_probe+0x19a/0x282 [mpfs]
[    4.964459] [<ffffffff807410be>] platform_probe+0x52/0xb6
[    4.964488] [<ffffffff8073eb22>] really_probe+0x84/0x22e
[    4.964511] [<ffffffff8073ed28>] __driver_probe_device+0x5c/0xdc
[    4.964536] [<ffffffff8073ee6a>] driver_probe_device+0x2c/0xb2
[    4.964560] [<ffffffff8073efea>] __driver_attach+0x6c/0x11a
[    4.964583] [<ffffffff8073cc84>] bus_for_each_dev+0x62/0xb0
[    4.964605] [<ffffffff8073e564>] driver_attach+0x1a/0x22
[    4.964627] [<ffffffff8073de9a>] bus_add_driver+0xce/0x1d6
[    4.964651] [<ffffffff8073fb8a>] driver_register+0x40/0xda
[    4.964675] [<ffffffff80740dc0>] __platform_driver_register+0x1c/0x24
[    4.964704] [<ffffffff017be020>] mpfs_musb_driver_init+0x20/0x1000 [mpfs=
]
[    4.964734] [<ffffffff80002130>] do_one_initcall+0x5c/0x1b2
[    4.964756] [<ffffffff80092606>] do_init_module+0x52/0x1d4
[    4.964782] [<ffffffff80093d30>] load_module+0x1392/0x17fe
[    4.964806] [<ffffffff8009435e>] init_module_from_file+0x76/0xae
[    4.964828] [<ffffffff80094574>] __riscv_sys_finit_module+0x1a6/0x310
[    4.964851] [<ffffffff80b4b6bc>] do_trap_ecall_u+0x1a8/0x1d4
[    4.964895] [<ffffffff80b55102>] handle_exception+0x146/0x152
[    4.964934] ---[ end trace 0000000000000000 ]---
[    4.965399] musb-hdrc musb-hdrc.2.auto: DMA controller not set
[    5.309028] musb-hdrc musb-hdrc.2.auto: error -ENODEV: musb_init_control=
ler failed
[    5.317499] mpfs-musb 20201000.usb: Registered MPFS MUSB driver
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block=
 ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
[   15.329977] microchip,coreqspi 21000000.spi: cs1 >=3D max 1
[   15.335577] spi_master spi1: spi_device register error /soc/spi@21000000=
/mmc-slot@1
[   15.343494] spi_master spi1: Failed to create SPI device for /soc/spi@21=
000000/mmc-slot@1
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
done.
Gave up waiting for root file system device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay=3D (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  PARTUUID=3Dbac9149c-8332-4f2b-a225-6fb96c83cf31 does not exist.  Dr=
opping to a shell!
(initramfs) \
```
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Monday, February 2, 2026 9:58 PM
> To: cip-dev@lists.cip-project.org
> Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> Subject: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fir=
e
>=20
> This enables support for the BeagleV-Fire in isar-cip-core, including
> SWUpdate, only excluding secure boot so far.
>=20
> Note that this comes with an update of our U-Boot version. I've tested th=
at on
> all but the TI AM62px (no hardware access) and would like ask for support=
 on
> that part.
>=20
> Jan
>=20
>=20
> CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>=20
> Jan Kiszka (9):
>   Kconfig: Sort boards by architecture
>   u-boot: Add U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
>   u-boot: Update to v2026.01
>   Add hss-payload-generator recipe
>   u-boot: Add recipe for BeagleV-Fire
>   linux-cip: Update cip-kernel-config revision
>   Add BeagleV-Fire board
>   kas: Add BeagleV-Fire target
>   ci: Add BeagleV-Fire build target
>=20
>  .gitlab-ci.yml                                |   7 +
>  Kconfig                                       |  26 +-
>  conf/machine/beaglev-fire.conf                |  22 ++
>  kas/board/beaglev-fire.yml                    |  12 +
>  recipes-bsp/hss-payload-generator/files/rules |  22 ++
>  .../hss-payload-generator_2025.07.bb          |  27 ++
>  ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37
> --  ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97
> -----  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38
> --  ...ustom-CPU-implementation-for-PolarFi.patch | 153
> ++++++++  ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |  30
> ++  ...ot-generate-logo-when-cross-building.patch |  33
> --  ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28
> --  ...SoC-level-options-to-the-CPU-Kconfig.patch |  83
> +++++  ...or-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} |  38
> +-  ...3-riscv-Add-support-for-BeagleV-Fire.patch | 346
> ++++++++++++++++++
>  ...ector-value-passed-to-mmc_load_imag.patch} |   6 +-
>  .../files/0003-test-Fix-optee-unit-test.patch | 134
> -------  ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  16 +-
>  ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |   4 +-
>  ...6-configs-socfpga-Permit-EFI-booting.patch | 161 ++++----
>  .../u-boot/files/beaglev-fire-config.yaml     |  17 +
>  recipes-bsp/u-boot/files/rules.tmpl           |   1 +
>  ...t-bbb_2025.07.bb =3D> u-boot-bbb_2026.01.bb} |   0
>  .../u-boot/u-boot-beaglev-fire_2026.01.bb     |  28 ++
>  ...-2025.07.inc =3D> u-boot-common-2026.01.inc} |  19 +-
>  ...5.07.bb =3D> u-boot-de0-nano-soc_2026.01.bb} |   0
>  ...025.07.bb =3D> u-boot-qemu-arm64_2026.01.bb} |   0
>  ..._2025.07.bb =3D> u-boot-qemu-arm_2026.01.bb} |   0
>  ...5.07.bb =3D> u-boot-qemu-riscv64_2026.01.bb} |   0
>  ...5.07.bb =3D> u-boot-ti-am62px-sk_2026.01.bb} |   1 -
>  recipes-kernel/linux/cip-kernel-config.inc    |   2 +-
>  wic/beaglev-fire-efibootguard.wks.in          |  20 +
>  wic/beaglev-fire.wks                          |  14 +
>  34 files changed, 924 insertions(+), 498 deletions(-)  create mode 10064=
4
> conf/machine/beaglev-fire.conf  create mode 100644
> kas/board/beaglev-fire.yml  create mode 100644
> recipes-bsp/hss-payload-generator/files/rules
>  create mode 100644
> recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
>  delete mode 100644
> recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kc
> onfig.patch
>  delete mode 100644
> recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targ
> ets.patch
>  delete mode 100644
> recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3
> -devic.patch
>  create mode 100644
> recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-
> for-PolarFi.patch
>  create mode 100644
> recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOC
> K-for-SYS_MMCSD.patch
>  delete mode 100644
> recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-buil
> ding.patch
>  delete mode 100644
> recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI
> _INIT.patch
>  create mode 100644
> recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-C
> PU-Kconfig.patch
>  rename
> recipes-bsp/u-boot/files/{0003-spl-mmc-Account-for-SYS_MMCSD_RAW_
> MODE_U_BOOT_USE_PA.patch =3D>
> 0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.p
> atch} (67%)  create mode 100644
> recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
>  rename
> recipes-bsp/u-boot/files/{0002-spl-mmc-Respect-sector-value-passed-to-
> mmc_load_imag.patch =3D>
> 0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch}
> (87%)  delete mode 100644
> recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
>  create mode 100644 recipes-bsp/u-boot/files/beaglev-fire-config.yaml
>  rename recipes-bsp/u-boot/{u-boot-bbb_2025.07.bb =3D>
> u-boot-bbb_2026.01.bb} (100%)  create mode 100644
> recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
>  rename recipes-bsp/u-boot/{u-boot-common-2025.07.inc =3D>
> u-boot-common-2026.01.inc} (76%)  rename
> recipes-bsp/u-boot/{u-boot-de0-nano-soc_2025.07.bb =3D>
> u-boot-de0-nano-soc_2026.01.bb} (100%)  rename
> recipes-bsp/u-boot/{u-boot-qemu-arm64_2025.07.bb =3D>
> u-boot-qemu-arm64_2026.01.bb} (100%)  rename
> recipes-bsp/u-boot/{u-boot-qemu-arm_2025.07.bb =3D>
> u-boot-qemu-arm_2026.01.bb} (100%)  rename
> recipes-bsp/u-boot/{u-boot-qemu-riscv64_2025.07.bb =3D>
> u-boot-qemu-riscv64_2026.01.bb} (100%)  rename
> recipes-bsp/u-boot/{u-boot-ti-am62px-sk_2025.07.bb =3D>
> u-boot-ti-am62px-sk_2026.01.bb} (98%)  create mode 100644
> wic/beaglev-fire-efibootguard.wks.in
>  create mode 100644 wic/beaglev-fire.wks
>=20
> --
> 2.51.0



