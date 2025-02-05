Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8512BC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:59:26 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web11.7287.1738742358973717468
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 23:59:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NgPP4FGH;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpGmdte6yW7Z3Kf7V0gDV+UZATqSXHudsFnTI6VaNTWts+hcPq/rTpcv3WtFoVAlGbhbB/b57DyaklUFEpYJTqJ4ooaoYIyaFWBsw760S/YnG9Nt+ci4N9yF85p6jlJnPi/8mgbGEHCuzfQBBm3PdCJJHonQYxcorhedXap4sT87w+nSZkLy1coZ95ynR2HDVePNNjUt0DWyOt/imJxGo5LOkPhlYzrNHgjqv3FpFOtoy6ZjjWesltsBQIXMxqLhGcR17Hrjy3Wqu9442w/ZGZU1k6xKQYINvPd0AmqANMMCEaLuKDOIqsLdTPByp6gu4ddmAqj4JBCbWHTqD4pw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycPClZVho7ZexALICEhzWWgxGoM4vQMTGa3wC1NQ/Js=;
 b=A3uQFPMAbnTiFCCeSU5FdQ2wneZqhbEvshg1DVHr86/v1V9QKSiJPhCv6BcG5ccW1sCRSvnYKSfDZJb/bvhKKRNLXlRn7MJ58//zV4b2aotT7xSxXykvD0fKfUCNP+AI7bJwCy9WQtL8zBYQDE59XRHKy4nkhF5rbJWBX7yQJum7fX9a3o8rAny/Ey4/FFvbFZp0Fm/POaANuOOcIcYjq5UjEwSgVq4OEJSooQnvvrTSKTMUxZQZKVC9tOEWxMbL6+xgweuPx25hG+x1uacKtQeeImx4OIuICsLyINEhwTcBby4H+bGMMAhlDgTNnij+5kjTZYBB6wPnhOM6x6Tqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycPClZVho7ZexALICEhzWWgxGoM4vQMTGa3wC1NQ/Js=;
 b=NgPP4FGHIu8aoY4w2AuqgHJeZ07nnlPOruDJlNPxPx3FgCRmOnUrXDh/lMTu/aDo0+K500qPpa2Pr71z+4eyEGaAWbXL47384DxAD7UxESB9Gnr28Vy2T4D9FSJ2h9x6g32Y7XNwDPsBuEPC1bgomLnibNAKfgURsGHxCc+QS6Uk2Id0QpuHtIupmzLCINok6qz3r3c1zsnfRQ1/UlS3D7FzU5W6tJhE4fout5+OdRg1KQ21G8vcL+nwROp7uhK5oQ9IIw2uD+UOpIIV23Kib6D/2ZfKFreRQEK4jLSImB58S2f86gfhKfsluQdGV4eWueQAbUVCj3hOuW78+ly7ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Wed, 5 Feb
 2025 07:59:14 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8445.002; Wed, 5 Feb 2025
 07:59:14 +0000
Message-ID: <36fb2001-6886-42c4-8d06-995193d67405@siemens.com>
Date: Wed, 5 Feb 2025 08:59:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] kas/opt: add new option for
 security testing
To: Jan Kiszka <jan.kiszka@siemens.com>, Sai.Sathujoda@toshiba-tsip.com,
 cip-dev@lists.cip-project.org,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
 <20250204115722.48815-1-Quirin.Gylstorff@siemens.com>
 <40f39bdb-3ca3-4918-8bfe-8bb77e750fcb@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <40f39bdb-3ca3-4918-8bfe-8bb77e750fcb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bcd008-764d-483f-1d6a-08dd45bafb98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nkoydm1WUVZJeXVXODJwOE0vcVRlem9ubGJFOVFYZzlKQUI3NUNQalJOR3Rr?=
 =?utf-8?B?U242Wk9rYXB6NGN6NjFlU1NvZVMxUnEvQ0czam02REpXSjhCOVNXZUxHNzN2?=
 =?utf-8?B?OGFXWTBlbnF4UkZXQ0JRNTVSSDRxQnY4VTlRc3dFQU5UdCtCVWpMS1RDNkVy?=
 =?utf-8?B?d0JiQWxLd0FkZXNTSy9wTkovWVgrVW1jNmFjS0NqbVpndFFURStpd1U2N1dt?=
 =?utf-8?B?cjZobTVXMFBCQkorZ2E2TlFTWURaUTdaSzQ1aXhrdXFIQWRBTmRQY0xXOXZy?=
 =?utf-8?B?eU5DUUtya2N6ZDF6eldVOG9zbEIwWktyWXlXY2NUNFhDTVFmZmZURU5RMUJV?=
 =?utf-8?B?UUdvWUIwWDNiSjUxVXBLVkNWWndRVTZ2NlRDcU5pb1hGNEFJRWhnZEhSSHQ3?=
 =?utf-8?B?UXZqT3FyZzFubGVVc1Rxa05IbTRiMEpQSjVFc0ZQVGgvZHVucHh3Nm1iYnFG?=
 =?utf-8?B?NFFaWDFvSWFOTkhNY0JwZmNFMTJhVWlsaTMwa2EzUVI0bHlyVzg5M25hRXVG?=
 =?utf-8?B?RmUyYldWa2JKUjdpZERsLy92QTJrcE1lUjFTdFFUQmZtQVgvOXpOSUc0cVV0?=
 =?utf-8?B?bVg2aHhWZHZuM01abnRxNXJ1ZTYrd3psVWNic0QxNmZZN1g4OEJ4eVhVTVUw?=
 =?utf-8?B?ZEFSam92YWkrRUdtbjNuOHBIMUlBUmc3cTd3SXZ6TmhTbVp5V1J4bzFhZkhE?=
 =?utf-8?B?aEZkSDlJUlpTclB4K3Erb0dBQ1l5NitsT2N1WHZzR3pmYURDbnIwdjJxSDhm?=
 =?utf-8?B?NFZoa1g3S2lCdHhYZzNEem1HMWNGL1cxN1YySXFyZi9uQUVUUXovTTBhbzJr?=
 =?utf-8?B?ck5VK3JWT0VBb0U0cXpXbnc0a3YzTW10bE5FMXpWbUQ2TFpvMzg2VnlTOVUr?=
 =?utf-8?B?NFJHdWRvUG1telhBcXJ0R0VseXYzRDZ6SXZmak1EWkFIRER0UU1sa003SG5u?=
 =?utf-8?B?ZHgxLys1enAzdURab3lNZm1RaEJaZ3kraTY5VUhaa1hkakdLYURaZlR5ZDA2?=
 =?utf-8?B?dy9sT0IzU3lnU05kSUlNOWl5MFBEWC9xZTZpWWozTWhubjVrTndnYTdUNGVy?=
 =?utf-8?B?eC8zS0NHbkhRN0l4WlJjeUV5c0UyYUNXaTl3VmphRXpLRU5lU3FyOGZBUnJR?=
 =?utf-8?B?K0srWSt1aEwxOG1pb2JnTWtoY3U0QTd1MkJ5YVdmSVRVKzd2S2FUYW53Vldm?=
 =?utf-8?B?ZXh0N20yUXBBQlJEaHNoQ1lWaE5YTHpVSC9NV0FtblY1SjFFczZtMC8zZ3Zr?=
 =?utf-8?B?MFBZanowUU1makNXSXpEdklUdDhobVJRSjgzaTVPNzVCRVoyQXlJaHdwNmZt?=
 =?utf-8?B?eWZXVWNuR3VIRUttWVJmMjkzdkRuME11eTBtLzlpdmphQm9JY0t1TzJ2NCtE?=
 =?utf-8?B?ZzFLM1g0SkgzVHFmd2JYaTFjUlRhUklHeGpCYjBPTk11UWtaR1VhbndJSlNP?=
 =?utf-8?B?bkZuWGVlNnlwd0sxRXBUSHBJL3h1S0xocWdmQVkvZHRBSi9EWDZjWENYMDlW?=
 =?utf-8?B?WjcxVHgyQzVrUDJ6RVFodjV4SWtXaEk5S3ZkbWNOblV1MTk0bk5Ma2ZJeWU1?=
 =?utf-8?B?dE5jU000dHkrTmpGMlc2aG11UVVSSWo2T01KQjIrM2RkWENFenQ4dkMvNG1m?=
 =?utf-8?B?SjBvS3dkZmxtWDVCZXlLZXgxdkxPekI4T0RpdTVnOS9TeEI2clJ5Lzg5b0Jl?=
 =?utf-8?B?b2FKd0xJTVlULzM2UUxYR3NudER0SWFBVmVUaXBwVVF0ckx1bnFkeGdqMWRu?=
 =?utf-8?B?REp3dU1Tc0tGV0liMVRtcytTQ3I3ODByUW51dnRqRmpWZWRRQTlGSVg3Rnpo?=
 =?utf-8?B?WGNJcVRkNkJUN2J3VzEwTlk3UnBJaXVzNU9UM1NCSkMrdGtReDhMMGNleEh2?=
 =?utf-8?Q?Nfu72QwRF3Tar?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTlwT3ArczZ0NGZRRnhKeVVVSnk0cXJWQ0xyb2FkeTlOWWo2di9PWjRwNlpm?=
 =?utf-8?B?d3RmeWxXdS9rSjZSU1REQ3BHcC9NNHlxL21kUFllR2pzWmNtSTA2YWs5TWV2?=
 =?utf-8?B?b243T2pNVmlYc1YvNVZNM1dMNEpsamhQK0d0b1llQnFWcnpvVksxVndvcC9x?=
 =?utf-8?B?eC9VQ2VVSGhwZFRJb2JUM0hlUE11ckY5Ry8xUDc3Q0tZTy9uY2F5ZUVuZHdN?=
 =?utf-8?B?OVJzTlpFMEYzbTVjTTFjTkY5UExHMXNaWEpiZ2JFN2oyUmlPb1NNZDVvOVhF?=
 =?utf-8?B?c09WVElwQUVXTDBzTXh0aHllRWxTMVU4Y3k2OWtHZ2JHQWtnVFd0QlhIVC83?=
 =?utf-8?B?RTBTc1A4SHhOZUtBSExSQWxna2VURjErK1FLeXFQa1Q4RE5nUTMza1NMNzNT?=
 =?utf-8?B?WG4zejdOazZiS3BHM09TY1VXbjNESHQvNmVoUmg2eFdEbU9XVlFWMTJyenZo?=
 =?utf-8?B?ZDU1NHYzU2w5ajdhZ1BGN0pWNUwycUFIUGtHNldYbityU0lMVHd4NUpDaFU0?=
 =?utf-8?B?ZXBvQjdZNWIwZUZWMzFZeU44RFIyazUzUlFwOEZ2RmVFamU5KzRTT2ZrS2Uv?=
 =?utf-8?B?VTUyQVMzcG1NWUNvKzN3RTBId3o5VGxFS3RoZXhsS0NiOXZXV0UzSDZOSmhI?=
 =?utf-8?B?QlMzK1J3ZUNsaDcrTnE1eWUyUnhuNXMrb1BBNHpGbjlTZEhYY3FHYUZVQVF1?=
 =?utf-8?B?S2cxckVhTE9GTzA0OUdrU1ZWVkVDUDNDdVBXblFudTFxS2RoS1RXZkdOUkR5?=
 =?utf-8?B?SVVqckpDRjBDeHByWHRXWWs0MnFpZFcyQXRadjY5Ym5ZZEVQREhEazVTenVG?=
 =?utf-8?B?NFJtZCt3aURJaUVncVFzZ1dnTFVJNm4yeFJWQ1FQMWw5RE9vcHIveGJYZUVD?=
 =?utf-8?B?enZqU0VHK3ozeWVXb2FuY05pTFZmQksvd3pabENHWUlxdmYwZFRsdHNBWWVW?=
 =?utf-8?B?MitnQy9VZWJlYUFoOVh3azl5U0l0ejhKeUpQRGJXeGw0MGVvb3Nya0kzM05a?=
 =?utf-8?B?emJzeFF5T1FYcmVjdktpS3pjMTJkVzVxeUlwNE1raXhyWUs2TlpPUmRBd3Qw?=
 =?utf-8?B?TUtGOTQ0Z0M4WFQyTUdEMDJwTGc0NmNrOWw3dFVxR1Vxdks5TUNHdTR1TTVP?=
 =?utf-8?B?SW9sUjZ0SlRxUjhvcEpjVVBCbnBxanFWV2t4bzlJWFRZUWowNTNjMmZzTlVh?=
 =?utf-8?B?WEoxMTFrOTE4VjZpeGc0WG5BRHBCeE5nSWJ3dHNFVXBjQnlpQ2ZYcHdMeVR4?=
 =?utf-8?B?aHhtQ0pGSWh2QitMeFZvVW80dm5iNUE2R0QxYXBpeGdqM2hLMG1pUHlWeVBk?=
 =?utf-8?B?V0pHSFpibjJ4Z1p4NFdMT05YOXNxL2xmaVd5UHZ4NEdKSFJVMnJLN1NHQ01D?=
 =?utf-8?B?OHVXUE05RlBhamFwUWdQZEh4dzluQ2t5MkZseDVNajFVTFp6QmRKQTEySERO?=
 =?utf-8?B?amlvbzlVeUpQWTR5ZVZRYTV6Wk8vckJ6UjRMRnBoeWsyVng4VFd4Sno2a0hI?=
 =?utf-8?B?VmZtUU0zYWY2SDdlSFBZczdxblFPU1VLc1VlS2xlU0VWSGZjSS9Tb1ptdmN0?=
 =?utf-8?B?YUViL21Ha1pucmQzV1VDSGc0NzhCV1YrV1IrZnAyMU8yOUgrZSsyR0Q5a2hY?=
 =?utf-8?B?SjRZelVYNmVzVHRhMU5WVUFWcURxYk9rTmlkTW5DNXVIQnRmWUhRWGgrYWNX?=
 =?utf-8?B?VVRkeTV4aGQvQzlEKzFoYVBuaHlRd0hwNGVON1hNeExrWTlpNHBrZW9xMXkz?=
 =?utf-8?B?Y0ppUGIzS3Nja1FjejBHZ1dXQlNFcmQ5KzdFU3prL0xOZEYwL08yYkcyWmNa?=
 =?utf-8?B?dVdtaVZmSzBjZ1FwWmVhZmRzUUJNVW1qcEQ4Q3VXSElOR282bDFhUmNTbWpL?=
 =?utf-8?B?T05PVFd1c09ETlljT1dVMDJQbzBxNEczVHE5SWRDellwVWpNaEZ4TW5CelJE?=
 =?utf-8?B?MzU1RE56MHBUZ0gzaHhRL0RSNXprZGd3TjRGNXV4R0NHQ09wOVdnVjByQTVF?=
 =?utf-8?B?VFdBc0ZDQ0pmSmduR1ZRUnNtV0xnQlM0NWU5Z1pseXROUjNOT3NMVUtpWTNy?=
 =?utf-8?B?QkovV09RbVYyOXNJZmRmTGMxQkdnWG1PMmcwRE83b3RaUXg1dTJoaEdyWXla?=
 =?utf-8?B?bnhzajhmTEtaZGZPUDhTbUVHVWN5SWJhLzAycVBIZmVFdUNnYXp6a0U0amFQ?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bcd008-764d-483f-1d6a-08dd45bafb98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:59:14.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEmJhci9YORXU5ASBj4ChUXW3MJAeVwA1HCP4MJmh377LdoyItM1T0OcxK6ryiGxlHcnD+OkA/VUCdxv+A1Lx8tkRnFn4jINO2qS1EA0A9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 07:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17751



On 2/4/25 14:24, Jan Kiszka wrote:
> On 04.02.25 12:56, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Lava generates a directory, in LAVA called overlay, which contains
>> all scripts and tests of the test stage. The device-under-test
>> needs to be instrumented with this overlay.  LAVA provides the
>> possibility to download the overlay via http or NFS. We use curl
>> to download the overlay from a http server onto the target.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v4:
>>   - fixed description
> 
> This does not yet address my other comments at the end of v3.

I cannot answer that part ;-p The automatic testing didn't require it as
far as I know. So I would suspect that the README needs to be adapted.


@Sai, @Dinesh - Does security testing still need sshpass and a rootfs 
size of at least 5G?

Quirin
> 
> Jan
> 
>>   .gitlab-ci.yml            |  2 ++
>>   kas/opt/security_test.yml | 16 ++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>   create mode 100644 kas/opt/security_test.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index dd4baf4..d7055f2 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -65,6 +65,7 @@ default:
>>       - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
>>       - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
>>       - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>> +    - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>>       - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>> @@ -251,6 +252,7 @@ build:x86-uefi-secure-boot:
>>       use_rt: disable
>>       targz: disable
>>       watchdog: disable
>> +    security_test: enable
>>   
>>   build:qemu-amd64-swupdate:
>>     extends:
>> diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
>> new file mode 100644
>> index 0000000..73d22eb
>> --- /dev/null
>> +++ b/kas/opt/security_test.yml
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 14
>> +
>> +local_conf_header:
>> +  lava-testing-add-curl: |
>> +    IMAGE_PREINSTALL += "curl"
>> +
> 


