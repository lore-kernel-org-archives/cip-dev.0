Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCAC4453C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 14:36:25 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1482.1784730983086565680
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 07:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=shCtDNRL;
 spf=pass (domain: siemens.com, ip: 52.101.72.20, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fo34btYqtru7G3krZjOJTlOq2clN62tgXcyxEbyCsXTjpmJrMI5JklNcdtNKyI/xUV1ntxSwS2kRnIVzdf1+VK7BUtxanv14B7NmX2Md0DXxQ49cE0zlj7v2dWsuCHRw6nsS7T55LFw6pQW157eCqnuK5u2/jaKUhS+eOndFPXa4EC2CJFVF7erfuKIEk2nSzKhAGQjWDogUUYxmoxA8if7bd6o/syZx3Rzv76xYxQMiiFbbV8USik4ZOvqT60vK8Cxpie//aJoSCH72bhsQK42xWbK1ccMInmDuleJrpWpzH5p0pYOxAbRjTQXhTuA4OJbeT/fEinIx+H9NmQDddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sEGdio6KqymHIzJd8xCE7Dqew2Rl0nNbB4dZvmVqHc=;
 b=UitmZoj7SadV+R7MOj+l2ZukP/ry9Ih2GUqvRecU6hg8LO3wj7o1RXk+HzQ74TJDQIofCz2cgCZoMLnnv62eRfVfKUM+NFJf7No9ij4EcTt5CeW5TZ17d1niZ7j1ucN9UZ30gnI3dB8onwuSGZfEVPTioZnwebjhmLIDYCT5/eGfkKEnrvKliYeGPsdg+Kg9YeRFpj9LjrBG12OHjloS7Ie4g+XdSRJPOXrbycffH8CdxtC0eotH0KEffGl13xWfJ9o2Rz7comaX9seIfqfjt/PTOYA0bt7a/Uzc091J+IDwQ4bI45MmWf62RN2hfxP+irYHO5IJD5w7DI3ndEarjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sEGdio6KqymHIzJd8xCE7Dqew2Rl0nNbB4dZvmVqHc=;
 b=shCtDNRLb8TByIyF+YI9xaBGRYLK1/6oLzWvzbVqu4luKTiovhJdvsJN4J+HSdzbKvoJ/UTxix3dOWSWQrFP2BUjyPkbTtZE+fLkt2aZmKxh/LiJltCdMpbpZbqIPw0mj8wlYgj5i0CzIC7Sbu9XzrtFF4FiF5AjwsBCWNf2WxCWEL2RXu8k/2adZFMU78ZKmcgvwYXFOb2gsHWPwtm8Jieq0W2+AzawMVAUi0zfyXbpOzXJ1pMiSctjVpV3O+FUllJ4ED1l2IaPytfXHIdOEPJzKhaEFc1PjuD5Lbk9qUYcwLddavSgKVxwJVLg4f2GqUckTZtubO/6kw+lI/O1Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:36:19 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:36:19 +0000
Message-ID: <05602f14-d7b6-4e78-82e6-788739d8b16b@siemens.com>
Date: Wed, 22 Jul 2026 16:36:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 0/3] Enable swupdate support
 for debian sid
To: Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
References: <20260722114753.627244-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260722114753.627244-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f903004-029f-483e-a45b-08dee7fe9805
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4022899009|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8VR9BJi38uzys6/RjWpsFYP7zP4dGpDs7sVK0OGeQacZQVXdmPEVMv3OnzQePJBRIA98GWldzaKMGEU1lmllotqRUwXK3EegQjN6SjHXUIljKetdmt3+m7UHEnL5XMPBoa0d38oKbjqxLRAmB1KmNmAjt3mWzRWI5xStikM1zr/6v3MfjKWKRUxWPyMAIUnckAolzCp9cMavkW38qzdhYgIm+ZWQRlyzoDrAwiG6B2/GIv3oDjMAQjB55QMVTJ1P7YPF5C9mkNo6q2saDYcbbPrijyL/Jg2ontXKhLDblXrOtD0yCgKtYCsur7Th71cfCZBk1Ju1hlUvAvMkW4U1Kr+aD6l5AUirxCVbfN6Az1E93idftjA9ffg7xzinQIVbjUFWdK3LkFSZNdmANOz28nVDClLkQYiHvOOJFw5J74UWP4f2FA34SXvjObJW+43O8HC0nCsy44cg9ri9resQopLm2uDN1/hVhSIXtD2hyJ0c/AVLDtPvwEI1LW4QcZV+R9dlrh1+1ou+Yde2b3ML0A3uZZN7DQKFL9jHEkGss+fTfYz0onwtOuJTOY8l4WPOmV0Z0pr0nnEHhvqZtSHN+VA514LPqgFIovI+96HrwOq7gm6zjcj6K1UFmgyUnUja
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4022899009)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUc3emFRbkN5ek56K0doUTZCalhQMjc1MEUxcWtZcmh3ZDdkaDBVTVd1TkQ0?=
 =?utf-8?B?Q28xNU5jUUwxU3l6OHVXNCtkOThtdTloMmEwS2gzU3FhT05lNHRDZmdERnhu?=
 =?utf-8?B?Y2RjcTV6aGVZR1VmanNiTXdRN2lKcU90cm5QWGwvdlcvQkN4ZnlhcGd3K25G?=
 =?utf-8?B?NEtHTEpHWEZOc0thVTR5VDdRNFVPNWRqTmRKQmNCYXhmYWZOV3NiQzRUYlNN?=
 =?utf-8?B?N2tIK2N1NGs4R0UwcFltbGhtYldlalpSK3RjTmFVbmlMbC9pbW1yOEpMZ3Ro?=
 =?utf-8?B?VCthNnNkTmd0KzRKY3VjYURISnFwU1h6NzU5czNON0Q5cnB1TnpLZEF5TmNK?=
 =?utf-8?B?VWFoZUl0OEV6dXlWcE5kTkN5SjBicXJIOXZleWt5cW1sMEYvSWRoWDFoT1Fi?=
 =?utf-8?B?cDNFT29HeXF1cTRXaXBCYnRrNFZOOEJjd2JYcll6My9Db1FpYks2cm0rdEZH?=
 =?utf-8?B?Y1d2Zm9EVFl5MnBKamRLRkRiTzd0TTVxVW5vOFZPQnltK0dGdktnWjRhZk1v?=
 =?utf-8?B?THkxN09lZXlTT0dTNGlmVy9rM1RaUkt0UHh0cGVpczlybm5jL3lmM0RWRVkv?=
 =?utf-8?B?QmNQa3Jnd3Z6eE80VXVSMzhCWDNsZGJTZFlXZnhSSDNSUE1yUkVHMS9hZEM0?=
 =?utf-8?B?d2h1TTFaL0o0L3plKytvUEJ3TWtBcWd2YnlZSENaWWFEVFBBOFVidXJMd2lY?=
 =?utf-8?B?Ui9qdDNlTnlqVWxtZExhUDU5TEdIVXB2RGF5K2Jvb1ZKRENWVjFyNkRYMmxZ?=
 =?utf-8?B?MjVMcXhHeFNYQ0tyMmJibDRKZDZFOUNoNi9mQ0l4SkpIL0FIek9qZ2pTbktO?=
 =?utf-8?B?WHJ1b3pwMk1VTytaYUZ6ZUp1bUNIakFHTTdNR2VKeWRjTUlDR2xaeTcyMFV3?=
 =?utf-8?B?STBIUmtIUVRiQ20xV2puN2FqRFhrNjQvNVgvcTRNWk4ycUlnd3BlU0FIcHl4?=
 =?utf-8?B?bTZmMWlsc1NHUGVmUm5GRjZWZFpCaW9FUnpEanZEVkZMZ3VCZG84ejVFVitZ?=
 =?utf-8?B?amdtY3NvYjZERDlhemRYcWovclF1UXFIMUdoKzFkeitQQjgxRVpRSFZyOHhp?=
 =?utf-8?B?cVZzY2wrT0VjN2FtdEdCNVgxZTdhbTZ2eXZTeStEbjNLRmIvc0EwcHpHTEpv?=
 =?utf-8?B?SzdQOHRYalJqZVlaUVo3bk9pQlg2M0g0Sy8zQVRYYkFhQXBCSVVSbExNWko2?=
 =?utf-8?B?MVlrVHdyWjRrK0xSSmt2d0EydFU1U2pLSHBCWlltRWtaNkRUQ2txbG5zc3A1?=
 =?utf-8?B?R2RIZGtGaWFmY0NCbkVnbXZ5TkRqeXRLbGdGUHFMVzdadVhNekVaaGpURUg5?=
 =?utf-8?B?dFZPblpZdzNMYk8yTXVNaHF3L1YrcCtNMExBRGx4YkV3RlFLd0pqUFhkYSta?=
 =?utf-8?B?SE5VbEYybEVlOFNHYUIzdlpCQzZQb3J0OXpWUUFHUlk4SUVBV1l1QlhUbHZG?=
 =?utf-8?B?c1lzMGJYV2drMGRoQjMzN1VZTTJDZmpWNHZZRmY4L2t4Mmg1TWZMTU5jdUR0?=
 =?utf-8?B?S3NIdFlLakJwYUIzZzMxdWRtTDBLWlpQSEhkelY2SXhmSjZ2K2RYOGp0WlU4?=
 =?utf-8?B?bFlSRDh1Z3VRUmI0VW1VaXlhUkFFQmxsZjZmVXNoL2FoNitGaTBLaUhiTzNz?=
 =?utf-8?B?ckZHK1FBQXJKWWFOQXRvSThNbVpLUXJRUTZvT3dqV0c1MzZ2MFVxMkw2bjdS?=
 =?utf-8?B?ajBwbUJBZ0t6a00vcU94RFNMOEY4MkM4K2RqOTg1UG1oZkUxS3ZjTXhZQTJx?=
 =?utf-8?B?RVJlTzdBa1huZEdFSlludytDamhoMGI3bG55RzNrb2JiMmtaaGo5RWF5Mmt2?=
 =?utf-8?B?U0dQRXpNWUdvQXFzc1NjLys2MFNCMTVjbXZVcWt4alVQOWtCS3phZjVGUjVN?=
 =?utf-8?B?SmhramFZODhJZFNhcjlhbkJ6ZDNRaWFtK1dOVnBjakhnOEozU1p3MkF2OGh2?=
 =?utf-8?B?UzFkOUgxUWF2bzY5Wlpicm5TUzlLRUpvOVVxdTQ3M0liMTNid3U0dkwvNi9N?=
 =?utf-8?B?OUY3WEZ6NEd6NUtwNyt6R2Eyc0t1SThKZDhUZ0Y5RDA0bVBPT1FWN1ZFRm8x?=
 =?utf-8?B?cGpnZ09sWmo5VktXUTVHTVYvcldrMmVIamNvRHpCdTF0U3FkRDZBT21SNEl2?=
 =?utf-8?B?OCsrajU1V2dOTUdlcXN5TDJOT1QwYzBBc3R2dUl6SzdtOVBiakJLeWdNTUVC?=
 =?utf-8?B?MjNPUjRTU05nYUI1RDQ1NFcwam9wWlBkTWd0akJnbU55cXBFZkFYV1dadDlB?=
 =?utf-8?B?L3N6UkpsQ2llOTFzWmh4U0hKQlo5VFRuYzBqeEFuZERhT2llRVRnSm4vUmxN?=
 =?utf-8?B?cUpIL2FNcEFUVjBQZ0JWc2p0N25RcXFubDhBdkkvak8rNGN5NklnOGt6VU9B?=
 =?utf-8?Q?B65iNrCkHMVzGuRM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f903004-029f-483e-a45b-08dee7fe9805
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:36:19.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n66R8r1h9NCmCe45uP7ljkks//+bDFEq9TGTOXePwZBa5y6aetEvHusF86QYEaQ4nKxZ7DvaXMi32i77moS6cnQ7HKHNvoH5IhXeSfBCsbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 14:36:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23714



On 7/22/26 1:47 PM, Kunijadar Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This patch series enables the swupdate support for debian sid.
> 
> Shivanand Kunijadar (3):
>    swupdate-handler-roundrobin: Keep default lua version as 5.5
>    swupdate-handler-roundrobin: Remove adding additional lua version
>      paths
>    swupdate.cfg.tmpl: Add digest-provider option for signature
>      verification
> 

Looks good to me.

Quirin
>   .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  3 ++-
>   recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 +++++++++---
>   .../swupdate-handler-roundrobin_0.1.bb               | 12 +++++-------
>   3 files changed, 16 insertions(+), 11 deletions(-)
>   rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (72%)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23709): https://lists.cip-project.org/g/cip-dev/message/23709
> Mute This Topic: https://lists.cip-project.org/mt/120392305/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


