Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B4C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 13:24:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web10.116189.1738675462273012515
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 05:24:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zVKoXTpo;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN0f4SSuDgry19h7ENH6Ky9y6cTGPLA//yzRPG7hAhqUYp3a0enmABY/Yu9vNWtXV7yTmydEJcJ8BOsi5qf9WZjrP+XvAM6dc5TA+dtD5pBNlokbaxU80q4cbk60BKPH9gxjd7cXd/kWGW/YyskWHiDuiecM8Mq8SwDNmkahnwsuEIJ8LIz33GjkOtgSsNkF869vESlq2VwHV/ETKH6BC2AqBV+yeCisBFTLaI4GUqeu8v5bNH/2Pfdp5KnFv7b4TycinxxFW4vPcTPTj4HpJltkGdle+3FbtR36Hy+T9CN03HBMuLKvdmgIhE6lNpRz2RyzmRgYBhFLkpEu3JMRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsGMOknbmyCBD67OCIdUNOpQ0z/4hSzo6fmIMaHcZ1o=;
 b=Vy3n6pUo4hhdFrDP4vz/m2i8XMwZnnyxT7GFY/RgptkqWYnrDM3APu3wOGZ0it/T1YTKxbni4z/zWTal2XMRkIzuDVcGrxXpsOQkIJzOv7OqWU5A6ruC68FJMqyJinFvbfwfe2uKhp+rGDTgpAd0sIrkr2p+7y35TOTZ/Rl4fDyPwDTeuXNMu9W8/UcsWbkmEOPCxZjH1hMZPQc2UtO6gd//vlksk2z57qz7TodlGgb3Y/kEHZqNh/HaZ1GaiVM41oUfIDlUJ+mzhMLxjAG8g6U1pzmvFluejdq3oYyYeKCs7MJrH0L8PvpE/nw7dcg9zMDq9gBizgyxeQFDo7/Z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsGMOknbmyCBD67OCIdUNOpQ0z/4hSzo6fmIMaHcZ1o=;
 b=zVKoXTpo/uGdfLOafOn3G5SCs+x5sfpifkQgxEAXH8vpOWxCZ1qv1+RR3vnOPWBnhbJ5c/Fn4RL2QwQGKQcYbh/y1Zk/IuRFKMZYD/RqgTgKmppqSukxhgLu2tZWHu+A4LVvi/gnlC2ZSynh1A4g5NJwecnQ635JtWWFLxq4ydE/EL/BF1svn/muWJgv48fC7Eo6z/sDwXYvhZ7sYL9yKYsR8tsND9z+o5n2l2Cx58kuDWtNhF1a6ximwSt7xnR0OlJKsGVRSjKqfAaD4JrWXzbH1kHVkWL4+hipCVYhBJevtq81vG4+rSTInLZaVkNzc+8tpxwyIydhZuI+benk9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Tue, 4 Feb
 2025 13:24:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 13:24:19 +0000
Message-ID: <40f39bdb-3ca3-4918-8bfe-8bb77e750fcb@siemens.com>
Date: Tue, 4 Feb 2025 14:24:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] kas/opt: add new option for
 security testing
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
 <20250204115722.48815-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250204115722.48815-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9aafd3-a119-405d-b460-08dd451f3b02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXBLS1ExaVVPVTU0RHcrVVhDNVk3WXdkbUh6b3Y4WkVyTDRkZkl2V1lHWUp5?=
 =?utf-8?B?MktEa09yeURyMmUwc0g5a2E0Q0FiQ0NXcTI2SHN3cGxiSzNXcGxkZGN4VjF5?=
 =?utf-8?B?QVNsYUVLS09DaGpqK2JBL2djN2dMT0FLRFF3QzdWa2ppWjJBa3hLLytaTXF1?=
 =?utf-8?B?dGNCSzYwaVEwa0E3eXZ0VE1OL09XUm5PZjBjZks1QWF0MVlEVnJ1aS9iU1Nn?=
 =?utf-8?B?U2RHcXA5eTFYbGVmZWxlMDdwWU5Wckc0ZmlxSnpwT1ZrdEt5OC9yaWRJcEI4?=
 =?utf-8?B?Y0hyQklPMTRCdXkzdk5CeFJQcG1nMlROdkZOaFREeUJ2UTJpQW5ZNHZ5eHhR?=
 =?utf-8?B?djZ4SFJ3bjB3RlNSTW5CU0RTMjB6WGl3dUo1enJFZlp2bFJoT2JJZVFVSHFS?=
 =?utf-8?B?US93a1JOTnc2VVRyZENES2thSXE2dWJVR2VMT2dnam9iZzUzRTFVKy9VRUp2?=
 =?utf-8?B?RlVjbzhhWTNrWGJYSFRHNjB0M09sTUhaMWZpTTV0OGp2MDJ6eGoyMjdYS0xF?=
 =?utf-8?B?ZVFxZEJyVVByWER6NVhlSzUzdzl2cnFHSStRT3pZS0w4RWQxK281YzFlSVFE?=
 =?utf-8?B?TTJnVzNZM2N4UnJpMWV4WnQ4VW9veVlHUlVmMStoUTJVdkY5cGUxbWN2QWRh?=
 =?utf-8?B?SnExK2dhUGdpQU9XZC8wdTNvaEJZWE82NmsyMU9IVXRqejhwVXkxM0ozZ2VH?=
 =?utf-8?B?Y25QajFCRlRXckpLYVdmcVhlZWsxdHNtTFpiaDdCNVVLYTM0aGF5VnFXVGRE?=
 =?utf-8?B?T1hNZnZTVnI4SG9ORzZTWkVhM0UwWFJxbTBMUGV5Y3NRaHlMbTlxd2RzTWI3?=
 =?utf-8?B?OEdCQUF1Y20rd3VrMkNzdUcvQWdjeVRwVS9aY1RadTV3TW00WWhLM3pNQXYr?=
 =?utf-8?B?WUdJNU10RHRGT2JTUU9UVjlUNHVKWWY3N2RFelNnSjBnU1I0dWNtYnBySWh1?=
 =?utf-8?B?aTZiK3RFNy9CUk5NSFVkNHFGSHFZN2p2dUdldjlQV1hSTGhpM1RucjY5Qytk?=
 =?utf-8?B?Um9UTStXOTdXd0tlTEJwbEtva1ZMRjYrU1ZCN2Z1aGVPRG1UMFc1UjcxU3pX?=
 =?utf-8?B?bnBlTWVIUm9sSXJCbzhkQmU5V041Nmk4OWljTk1FOVZ1NkRCdXFDZnNaNkZQ?=
 =?utf-8?B?aXBFZHdyS0U2UzBjbUhvMDF0NUY0amlKcG9veDNPcjNMWFJ4ODFnTmxtZ2Fx?=
 =?utf-8?B?cXRDZHcrcVZYVFJwSk1hME1aQVUvdmhtZ3dSWHVhcUJGMnVueWN0UHJLUVZW?=
 =?utf-8?B?YWhtZ0pUajVQMUl4aEl4UWdHai91K3FIM2dCWHByaTRUSUY2dDVxbnJSdGND?=
 =?utf-8?B?MEhLb1ZSVENwZFkwSkU3dzBWVThUM2Q5azdPMU1kVHcvMHJNRUhCWE1ZUTBS?=
 =?utf-8?B?bTZIWFZkWDlxRUVCNWx3RjEyM3Vlc0VCTDhQZ2FjSEF2WUpyTDhUZlRmSzhM?=
 =?utf-8?B?ZjJrbmlJeloraWEyT2pJdkc3ZG5BTTlBdkJMQlVwNXRaZWF1cENlbnl1MFZ5?=
 =?utf-8?B?QVNpVTIyaXhTb2JEcWVKQVlNbVFUWlFtaXVaUVl0MitCN1hyVjZKeWIxRnlS?=
 =?utf-8?B?bW5Lc3hXdWY3cnJFRTBhY3ZlblFGZFV3R3NObEFxbjBVN2lwamd1ekUyQXFj?=
 =?utf-8?B?S2RSN0o0MWVIejF3U1pnVU04ODU4MUtxY0hvOHRIL1U2R2hmQVlCdXlYd29r?=
 =?utf-8?B?K202YTVXeGNNZHhWY0FtSlZqeWs5ZGJ2WDhIUGhEdmxraEVtV3JkbE5JM1BM?=
 =?utf-8?B?cUZsaWhVVTNCaVBBVXZPMVlzbjVsb2FueFFXdFcvZjFIa0ovcjRiZ0NzZmg3?=
 =?utf-8?B?QzFrdFBsZFdzN2hia2ZwSUwxRHZ5c2hZRWFBd01XZ3BwYWpDNWVHV0x5czcy?=
 =?utf-8?Q?wHPk2RiX3zfmg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGFkZm5DbmI1WDVUNEh2L2kyZ3ArSGF2VmFxNmJCa05vRnZwZE9sVzBMdXpr?=
 =?utf-8?B?UjdNbzRpUXdIOUw2cy9uc1E3TUVkUjZhMkdFTE1kS3NVeHpuL2tVQzVMeXZJ?=
 =?utf-8?B?Um1pcDB3T1g4M0hGVHNPMTNOc3pwMDdNcUdONWphUGkzUzd6b1hyaS82YzQ2?=
 =?utf-8?B?Y0x4UEdnZW5wZkFoTkZKd2k3K3FTRGwvUnN2bTNEVDVQd1FIRDVJTWxWL0Er?=
 =?utf-8?B?czg4YkU3amtOQThTSWVHZ0FrY0NRZHk1U1FEcXY5Y1ZqaklobElVSGdlUlJx?=
 =?utf-8?B?Z0JFcUlsM1ZtaW9tWXcvTXIyOStVVmRtNDlTekhaai9FUURoV3NJdHN4eHRD?=
 =?utf-8?B?R09yN2ZNL29Fd08wNmZvZFh5WHZPNk5uZmthQlNCNVVRSFdZUnZoYmJuSkhU?=
 =?utf-8?B?TjdGWG1EVGo1VStuM2J0S2xSQjBySktndXNjdlF2V1dUTjBpbUEvWm5ZSXFs?=
 =?utf-8?B?TlY3K0VsL3ZibDlqZCtISjdpTldSYkFVM3lmRUJuVGZnaFpnTzNCdDhsb3JL?=
 =?utf-8?B?dWFuVVJQd1k3UkRnMUIvcXZnM3VwYUdRQlpOQWMwNit3Vjc2ZHpGNFFGdTc0?=
 =?utf-8?B?U3o4UEdEdHNOVHpLYjJHTlI5UWVhQ2FJUEtKRTk0bEM5dUNXWlBkNHhKQ1d1?=
 =?utf-8?B?V0QyMi8vUzA5UUpvTndRSTBhV1R0cGJ0cWx2aHlySk84V2VXcFNVL25GWVFD?=
 =?utf-8?B?bGlYamc0WlgzZG1FTkMzRUlyUjFuTjgyZk1lNmxVMlhFNmQwMEdENlMrOGhw?=
 =?utf-8?B?TGNaQ2F6TFErQjJJUExSVURPMWRTNDBRdXNiMUJTVnpIWSt0Ti9SWkxaQkRu?=
 =?utf-8?B?aENZa290WXdJUG9OalNYRjlyQVZpZGgxc3ZwVlNrVWlGY0E1Zzd6Q3F0TVBo?=
 =?utf-8?B?TjZSYUJTNEhCeGFENE5OWDJqVTRCTzVnc0dCN2JFMVd5ZGFYSS9oMS92QzBS?=
 =?utf-8?B?UWNtdUxwdlB6ZjZOL2pQRG84WXRsakd3Y1BvOFpIRHphVmNyUTAyR2xtTVhM?=
 =?utf-8?B?S3lJc1cxbFlsVGxKdGF4WDFtVEU1MStxNDdyR2gvNVhsZ05jN0s0UTdBY003?=
 =?utf-8?B?bVdtektydGRFRCtEMzJ5VHQ3WUdiZCsyR3M1MkdTb1picVhndUtmRG9XeEpZ?=
 =?utf-8?B?M1Azc0ltSEZ5dXcrVk9UQndjdlJTVHNFVWY4NWxqaG4yaVU3L1BQamYwcWxV?=
 =?utf-8?B?ZWNrcHFWUm4rOVY4RGJ3N2pxdStTVmdZZnRUYk01ekI1WDFrV3AvTTNsN3p1?=
 =?utf-8?B?VTN6elprL1F5aHRxMTZaeCs4OHJsNER5VDhMaE1KQm5ZbmxKUXFTeGZsQTU1?=
 =?utf-8?B?VzBjMWl2STVoSlpzS0xyUnp3d2FmUk4rdi91Z1VreEF1VlJ2b2R1VUxKWUts?=
 =?utf-8?B?SzNUZk15WU9GSi9qRnV1S254TlhXYVRabXJ1bWJadmlEMGE5VkFGaVh3Sk5X?=
 =?utf-8?B?YmpsR3h4SWE4UmdmYnlvQWtYcXRpV2hHemJIWlk1VnZVd283ZFByVnpQdXlo?=
 =?utf-8?B?VEh1VFk1UGpFUmE4MVVranpLWkpiU1dxYTFIN1R5SXZSRWliT1QrMlRLNTN4?=
 =?utf-8?B?MnYxMEZOQmFjRDgySnVnMVU0a1lkSzFCbGlhRW9KVnBXZXIzRjUxQXBBaTdk?=
 =?utf-8?B?ZFRkOW4wRUtrVXp1R1FDWjdnSk9WcmR3aE0wYkNpV0VQOXN5Q3dIbWMrNUxy?=
 =?utf-8?B?MEVIems2RVV3TnNZb3JyT1Yzdm9HNDREU0luWFo5Ri9tWVFHSWE2QnpEbVR6?=
 =?utf-8?B?QjhheHptdElCMUY3Ni9QaUtTUFlGQ3NudHJyOFNLeHk0RkkwVjhZaTlFMWYr?=
 =?utf-8?B?NHkxQkZacDJMRUgzZWs5YlJkdXlHQU83eFlyWUo3aTUzZ1d5Q0hFbERIdFlF?=
 =?utf-8?B?b2hXOFdWNVcwYWo0aVh5cWdvMTdaZkw4dUFTM3NDcXJlWVNyVGQxckdsdXBu?=
 =?utf-8?B?QXRQNzUralhZcFN6U3JWVlNPOVZOdXFhRTBDRkZsODNSYnhGbWdFVWd6MVVL?=
 =?utf-8?B?L1cyR20zaWFrM0dsSGwzMjJpSzBPT244MVduU015SFowczJuZ0YxRlZ3UFFP?=
 =?utf-8?B?SFIwd3lENm5hOFVhQkxqYU1IR0ZMVGwxdytKREZYM1JCUDg0R3RkUTRieVhE?=
 =?utf-8?B?cWVtTUlIc1BCcjNtNmdNVlBvOElCbWN0ZG5NMGowRG03TXoyU0NoSEc2YjBI?=
 =?utf-8?B?WWZqR3JVcHY1Qm1QNnExOGtEckI4NWhrai9IZFFSQUlnN3J6VmlRZ1JVWW1T?=
 =?utf-8?B?bkg4b1FwYUV6WE8wc1dMZGkzODZRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9aafd3-a119-405d-b460-08dd451f3b02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:24:19.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0O/nfUlhh9jRecTEWCwf0lVF0SYgdAq58vqYhLti304QBzbkQ6QD+hxlHFqAb4yc8jN0S4b/2RmwOS0GPvyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8529
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 13:24:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17748

On 04.02.25 12:56, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Lava generates a directory, in LAVA called overlay, which contains
> all scripts and tests of the test stage. The device-under-test
> needs to be instrumented with this overlay.  LAVA provides the
> possibility to download the overlay via http or NFS. We use curl
> to download the overlay from a http server onto the target.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v4:
>  - fixed description

This does not yet address my other comments at the end of v3.

Jan

>  .gitlab-ci.yml            |  2 ++
>  kas/opt/security_test.yml | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 kas/opt/security_test.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index dd4baf4..d7055f2 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -65,6 +65,7 @@ default:
>      - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
> +    - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> @@ -251,6 +252,7 @@ build:x86-uefi-secure-boot:
>      use_rt: disable
>      targz: disable
>      watchdog: disable
> +    security_test: enable
>  
>  build:qemu-amd64-swupdate:
>    extends:
> diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
> new file mode 100644
> index 0000000..73d22eb
> --- /dev/null
> +++ b/kas/opt/security_test.yml
> @@ -0,0 +1,16 @@
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  lava-testing-add-curl: |
> +    IMAGE_PREINSTALL += "curl"
> +

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

