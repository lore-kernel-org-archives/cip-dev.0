Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788CFC64EC7
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 07:09:45 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web11.37237.1676963374969575602
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Feb 2023 23:09:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mFh7t1JV;
 spf=pass (domain: siemens.com, ip: 40.107.22.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJBjSVzGztOQP9Rnb/o8sATD3S542cmUidIxP71rBN/EBl9EPVim/Sw9Gw1ENg/BitbuXlAKWkAdlxLDsHA3u5Zz68X6j+zHJpE+zuVYDO2igXPkoODy42SRbFXojzpm9hDbfJtzwfjolNmj29quLF4KxNAvTXeslbyEnokRp2fwL53gorJR6y7GMRzsWAkr6gOOyu1+OiaDFLcbbHcaYWtOkzl0jIJoDLE3Z7wVQ7kRU7KHfO+igcUdQQVAY2ordiCZ6QiqxVqduvBtt5o7p3VrryxKKm6550GAPbljNCaeHTYBnmqeGSvtAvg41mcrNDl9FPe3dzeUYh21HzqmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjHnOoz0Hped6fWWKMsuF804KwWK+6XLkugMq2TSYz0=;
 b=cLHY/tbbdjNzNi0SpbZmW+4ERuFGBWd7h57SN2or6xQM91c8cxsrMmGmZfkbnllZ/wdG3lSZXDcJbk6uCdcS6AbzehaHCnb4MWNlo4xqlRmAjpetVRXwMv57SCQq9LmQHn/n1DeMy73p0KNizZQh1t8FV4ti2eu9yy0DnOGyfeP0udiFsmlOQ3iav7PAziRcXpHfR0nKwqy7OtEmPO6DuZV25rhjwLo53bwsdDVT5a5r6V+rlucNckrC2b/lxEs39zi1Ntnf/PpyG7DRIt6VU90HnUzBcxJYc7cIPz8yiwXnmblMLpEQxD63LXHP0SX7CtUTMzn2kcvgESv1pKyuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjHnOoz0Hped6fWWKMsuF804KwWK+6XLkugMq2TSYz0=;
 b=mFh7t1JVsW0CHzJrtZt+l77hoshsk+DAq4uW+BFCCLJMkYYWZRJPmMS2bzSvGlrws88RPUpNu3VVRe8ZA9Yxh2EHV4v08VQo3ZVhrcL/PjHW9KYJxbLzBhvtlDzO9ccrJdWptu6YOkV0TObeYz5oHhkMx9psqQwlgQMnjq1P2ADh+bS2ldr6N3TDQejL5oQeUUKR1d96iV/naqqGW0giAvx1hg9fn68ePDa/MY8OFNwLoWyygDgwVb3yKA+LoYpDDlyXVHXHYaWqaBAIFLxzdXBYnpF/5FXlWquGtab9Xdsk6z4Ts3zesdXKtxJLxNmvM4Tx8U76TysFfxNKbVsPXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:413::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 07:09:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 07:09:31 +0000
Message-ID: <934a4d61-ed5c-cb5b-82af-86d9e3353120@siemens.com>
Date: Tue, 21 Feb 2023 08:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: efibootguard-dev <efibootguard-dev@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: SWUpdate+EBG: The impossible state and how it's being handled so far
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d139df4-3470-4eac-a09c-08db13da944b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gUPwjOXxisvGrnBh05YCgEiHwJZkV9MxuPJJsP96Xa3V7dfL2Kx9s0enqILaWp0NvJF/QvWE11XGuKJCd8LkwgGtlTDzqs6f00IOn4nn4Nwh0i4GVD5IF4/P8quTE2usSriJtpRveyS19T598AT4tsjNbJOP/L5C6wNogGT1C0pLpbO8pcnsCnkkGvPEvPfpMFtpAJZ1Q/J99q3lIaJ0aRT9gP0DJ2YuCwVwdSahoOknrKo9F52hNqyS9n2FHmG2CZwnakrqHyR2BNGZZ0E/Js7cTF5r2hiLjOpUmOIIOVX9vQHFZZrVk40h1zN07cnaBXNC5+WvZCnP7Fg5J8XgQ1jbVx+xis5/w13YIcVCaqQIy6s9b9zfVp8vVA5RtYEGyzPUftaDn03iczNAOJrPskHqq1pxzGXqXcTTtRh/6D+R4c0LiwrH3RBhqhCx+6cvVMXXLept0cKtxmZHJVCoaGXKAS6/olg/GrhR49W25/HpCA6CR+IT0ZiNy5Isk0CT80TADjqW08pJt6uF4WQX3nEnOOjqNh0KMxRRW4cti6H1PxNFgmlRSV/7GM8ej7/FGAALLKT6l8Gde0KpLRDGxuf5Kdmh6Q80zqISmkP1aAPnMqIc/SW+0rWua9GG4F61cQCK63/oa1MusskWgk/JoxJnZVDzlTSj+VrL10p13hbUoSqyyE6bn9dMzWVIgeTfPGMNbSoJxpgkO9LIAEiq+fdKIPv1ZhX4Jj2oSRaI1Ug=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(6486002)(66899018)(6512007)(186003)(26005)(31686004)(8676002)(66946007)(66556008)(66476007)(83380400001)(5660300002)(36756003)(8936002)(2616005)(6506007)(478600001)(6636002)(41300700001)(316002)(110136005)(38100700002)(86362001)(31696002)(82960400001)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0t0SnRtRTdlYk1hb1ZHMzBwV3VZak45cnJ3MkNqanM4UDE5TE8wODVYRUNK?=
 =?utf-8?B?NnRWaS9FNEZJSHk5WndVUzYrMHgvV0MvK0pnVWQ5U1QwQ3ZScSttTk9OekI2?=
 =?utf-8?B?U3FobTEvTEtwNTJmZlR1c1pGblUwaU5oUWtiMHBXeHBTTlJGRFZJaVFhQ3M5?=
 =?utf-8?B?WTBoWTc0MUZsb3VsY0NabmNIZkRWeU1WQ3hTN1MyTVpoWEpod084ekdpdThl?=
 =?utf-8?B?Q090dzUxcUFWRFlyQ011ME1JRTVHRjVEZk5pTU45a05JZEZ5Zmsydi8xU3Vx?=
 =?utf-8?B?c05ZZ2g5cUJUQ3B3cWdsVnBHOGZxQ0hyMXFGL2FTazZpUlJ5WHRNaFV4ZWNh?=
 =?utf-8?B?Q0ZHU1pBL05YTjhXaFNHWlZxejNjczJ3cHRKSGRpY0FoeTM2bXhjZHIzd29t?=
 =?utf-8?B?eUhYMWRxRkNScmVFSG1pS1hSNlZ1Und3UUNCNGp6WmE3WC8zSm56L1NiZVR3?=
 =?utf-8?B?U05FNDZLNCtoV3NsRm80U2N5eWg1V01GL21kanBkVEp3OGhKcExjakdIa0FB?=
 =?utf-8?B?KzhxREpISHhXTjFIdHFYa3hJYmtLY2VGamF3WS80b0JxdUpvblBIMlNqOUJQ?=
 =?utf-8?B?OExIRHJPSSt4alVCYW9aYi9qZjRnQ1hnSnY1Tlo2TCtzbGYyLzdLZWJ3RHpm?=
 =?utf-8?B?UVZFbzhCS3A3cnVsLzFPWFVWSW96bm1lK282OStuK3U4RWNwblJCT2JxdGJW?=
 =?utf-8?B?MFRvdGdhektkYkRNOUF3d1BDN0tYbHdtNmhBYnp5ZHhFK3Q0MVBXek5mYjE3?=
 =?utf-8?B?QUg5MWFibElMcFQya0R6NktHQnU2WndlNC9xUTZyOGpnL1RNbldORDl2Q3B4?=
 =?utf-8?B?M0RLTDJMWDg4VnQyTTBDL2lHRVFaTTIxWDlkWjhOclhrTklsMStXUWpMaWhr?=
 =?utf-8?B?UTB5VnptZU4zc1J0SWxzaUxid1hBVlljVFJDcG0zWHRuclR3UXk5RkkwVWkw?=
 =?utf-8?B?RC9HTTVmRTJicDVtUTEyUWl1QkVuL1FWSW1mS3F6cm5XMUgwcXByN25zaUgz?=
 =?utf-8?B?djFuYVlWRncyUStzN1hqN2Y3M1ZUckF0YWRqK2RmWWJ6MU5WNlN1RHVOeHhB?=
 =?utf-8?B?TXlZOFdXV1c2akhyODFrRWtXNEpvdFNqQ0dQeVl6Nld2UG1tYU0wKzFJdjNY?=
 =?utf-8?B?UFlISEloQ3hOcktHemxWdWRoMDdWMUVxVldMQ3hSa2tsaXU5eEQ3eDJPRDNs?=
 =?utf-8?B?bVo0cThxK0Rja3gxUERjaFFUYWV2V1NUMFlYanZONGJrN0p6OHhJTlVwM3A3?=
 =?utf-8?B?cUw4VEYvNjhuQ1hQWVpjNnR2RnVHNnQ5MFdoQWlWb3BWTlRXa2ExdTlMVG9W?=
 =?utf-8?B?OVIwS2svMnRFelZKS3VEOTJ5MlBRdXNmWDVSaElqSml4ZzNTNWFhRU1IQ2xY?=
 =?utf-8?B?d2NkeXhhVE1lQzdvNENQaVhTVis2Zlc0OTRwMlBqM2M2U1NxR0UwL2lGdHYx?=
 =?utf-8?B?dlNDZTZkaExEU3VQMjJiTFdoNGxYSERWSHkyeXJXSmM3Wk9VdmhlRWhJeVJh?=
 =?utf-8?B?VS83dEZGZlhxcDdIQnQ4WElWWXpPL1FOa1h2bHpzT1o0UHlrbkw5NHJUTlJh?=
 =?utf-8?B?VHFPUFdMVG9Hb3V3SkFqS1A3bFRhbENZSTd4c3FxUmJublNxS3YrMEZuUFJN?=
 =?utf-8?B?aERKb1VFbWhuNlRkbGR5enJ6eUZhODdwVlp4cWc1VkhzL3JvckpYU1RCYzV2?=
 =?utf-8?B?LzcwdWZtb2xLSWI3Y0FDMER6ZDd6SDViRXFKdlo1a29MR3huSHA1NHZsMjBh?=
 =?utf-8?B?TmZYNm1yL3JJZXpuZVpVZkgrUGJDUWN0SWZRcG5EcU5WUWppTFVJTTVub3E5?=
 =?utf-8?B?cUdHbHJzOFFMRjY2L3lFYjdJVHBIRld1Wi9LWmNlcVplY2grenVjbWhSNzRa?=
 =?utf-8?B?dXRBZllJOUdRRFFsWjcvclNWS1FVSG0xeFE4OUNTZ3pMODd4MEFncDk4T2ZL?=
 =?utf-8?B?MXpoT0g0UUQzOVJzWHRwYW5zZ1Zpalo4MFJkUk05WHJrdU9JTGdCS1VEZkJT?=
 =?utf-8?B?Q3JTRkhES1ErQ21MaFVqOE9VT29UeC95cFJacjlWNlFydFNtaG9VcUJqeWgv?=
 =?utf-8?B?UTJYNmEvN1VpN1B1RURYU0plajJSeUFHY3hiTko0eTh1YUpnQlEzUUtoTGRC?=
 =?utf-8?B?bi84M2ZMaEpzYjF0SmgvbFZZT3lWcmxRQXJ2ZGQyUUkrMnFMV1R6ZC9jdzUw?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d139df4-3470-4eac-a09c-08db13da944b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 07:09:31.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQxQAncaJ3+fuMetjSzNRGurz9adVdj7JfOV8fZTpfUoJkne78Tx8vOmkR5zx2fpzUjMVFF+2WOV0vxygSnMYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 07:09:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10743

Hi again,

playing with updates, I maneuvered the EBG envs on a system into this
weird state:


----------------------------
 Config Partition #0 Values:
in_progress:      yes
revision:         4
kernel:           C:BOOT1:linux.efi
kernelargs:
watchdog timeout: 0 seconds
ustate:           3 (FAILED)

user variables:
recovery_status = failed



----------------------------
 Config Partition #1 Values:
in_progress:      no
revision:         3
kernel:           C:BOOT1:linux.efi
kernelargs:
watchdog timeout: 0 seconds
ustate:           2 (TESTING)

user variables:


To get there, I started an upstate with swupdate and booted into testing
path #1. But then didn't confirm this update and rather started it
again, using the same swu. That didn't complete because the UUID clash
was detected. swupdate terminated, and I was left with the above.

I can still boot this constellation, EBG will select path #1 (endless
testing, so to say). OTOH:

# bg_printenv -c
Using latest config partition
Values:
in_progress:      yes
revision:         4
kernel:           C:BOOT1:linux.efi
kernelargs:
watchdog timeout: 0 seconds
ustate:           3 (FAILED)

user variables:
recovery_status = failed


That is not quite correct. To be fair, bg_printenv deals with an illegal
state here. Still...

The key question is where to avoid best entering this state in the first
place?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

