Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDCC05027
	for <webhook@archiver.kernel.org>; Thu,  9 Feb 2023 08:59:00 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.52])
 by mx.groups.io with SMTP id smtpd.web10.9962.1675933136452476816
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 00:58:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wPRRifxg;
 spf=pass (domain: siemens.com, ip: 40.107.8.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmU/nviXT+/LkEkY6bDZt69Ylgh/SOEHpRD4aZLRxddTNfFYNZSE0TZxurklfQ7i02E0ObF1KMBJVCXwHOPkkyfCmksO7oy0dFhIkq105XK/j1Z5IzDV7VcpPUyhsWYQTjZPYlrMvW4hHYtmT67ACFL2K9L+x8hpnVRKklej/rtOWSrW1wYjKZX5dgoXrV1Ls2QUgs98Kc5a2zVgVCpLlk6dxNLxHBewgv7bT0G7t6YcYRLGt5YtehyA4WICkWb0qNgjkJpGwphgJsvrjKnAlC4DQtAYzL8agJcUFboiLx7RTbqWU9uBudBa6YyfnRst6LBCgfnbQ5LT54sP6PHHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6r0LAeDlX9g40fwBuPSvOCyP+Ob4VS8m9E6w7f8SAA=;
 b=HxyUh9TPwH/IqALXZiWmRoI/nSy/Pwh/q5KxjX2eZJvoZLEPrnD/KzXAfSwNJwNx6xIcnjCHhIGLOgMtcgWgzvXVQFdooW+h81+mPBN7ddTHP7nkaErsVDdkykxKxuP9qWKfCg5AzFfkvhjXQDvlszQIP35M0uiJraBFgdDLKJYkddYpVCc4bA/YfS1K1iIyalj5RYvH0Kic1uWvfLTjH2xY+hWSlWDjr4b9GFN6s6HWjYX173UNa/qgk2iF+Da0LuyZMOdqOK1+S4sbKLClayaNrkFFZqh70vq3Kkr089cqFNJgIh8Ax2qhXY0RZ9kq0mjFpU4Y6avoGd7U7juRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6r0LAeDlX9g40fwBuPSvOCyP+Ob4VS8m9E6w7f8SAA=;
 b=wPRRifxgCnEyGnTFADdaMeXtlPWc2Pr/M012rThAFN3quokdpRxW1DPRQXFTHMW7JKOKCkZpc3IZgyICa06ATABmUZrhU3RTL8S9lJmiacFSN4r9mHem/zIniFjr2afVIaTr3zbUfScJTZtZCN3gdieiBnIY3SdJ467CqT2SKraNecdUE6T2e2vv6pJbBs/NmBRiWcGvLP10WuKitu58uGPdKCr3MS4KyFawoMzlnwEc72iXtaBN8mU3VU80YoKmWAYtrJZLstGqTLU8JwnBxP/w0nN55rIA4ynIqVuP2Tp1pMZtgiwvuFnXCuRwMwwFFakvJteawhQcqWC/259ZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 08:58:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 08:58:53 +0000
Message-ID: <f5cdca18-86eb-9ce5-2e5b-9622692b633c@siemens.com>
Date: Thu, 9 Feb 2023 09:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] conf/distro: Use cip prefix
 and snapshot postfix for sid lists
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230206082541.15361-1-Quirin.Gylstorff@siemens.com>
 <fa1101c8-7e40-3dfe-fe69-cdf047f07d6b@siemens.com>
In-Reply-To: <fa1101c8-7e40-3dfe-fe69-cdf047f07d6b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d18bc9b-843b-447d-5dbd-08db0a7bde73
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RhTae+9NHtFx6bBMXAjREJ75iguGdC1wv5x/oNsYD+G9Q/I9jv+vcvlutJtrPjyBjIxw9TlRmuHq2MCAnKvxY1KIsQ4VzQ2q6nS9UbU6oqypfzuVMlRJJimOU+nCao/B8ab3xAj2faaZhJN20w68gHQJOJXR60v7ftMhAIMEkbS+LBORZDWuJju46b2KW3E6c/HV6damWV3qjFqAT1y4Y8qqMgqykcLppeJ+lfe1cqmYOptRBfYOTO/IdbvKxRTrMkMQf/agZ1d4ESZ1LcOE9R2AzE/YKw1IZoARsOopNMWms2ApbPYPrLBCxeHQ7CMr48opQZ9yx2zXOmgp6oejjD5uSMVwnDV4ZJWsUW6fRMed2m7ocPVTgIV/+wke+hOb5p77opRR1FyETGWQUSzk6ZOn+mD5yKzQOgzqFkbvaYMkETwlBxuHucXkyTVxcqEM/3O/GQKWP4M7MB4pyGgEsKv+yN3I/hj1mg6HPdEoGKi1aTpNlmfkVSq1pEjGR72u+JxoFpZN7iPv4JX3yQw4YErtALCb4wWgl+v5MY8lfwvmSTfOdOF7ru7InGgaN8do4RCi2umqf+0O9/5iVyXfl3mOxKZ1a6iRWOW7AL+bfLtikUhWsnhjQrIrlfGVA6MBbNIubyNFd1t4ynUDU3kYu0H39woeKASSNqn/6zBgFEbjcqU14dkQRZA83BD4r2u1Tp2w9ZsbM58munSfmuoXmP4b5/5OoJbADxxA6WStatk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199018)(5660300002)(26005)(31696002)(86362001)(186003)(8936002)(2616005)(38100700002)(6512007)(83380400001)(66946007)(41300700001)(316002)(66556008)(8676002)(66476007)(82960400001)(6506007)(53546011)(478600001)(6666004)(6486002)(36756003)(31686004)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXFhM3pkZGxScEZVbmNOOUhWVHpLUEdzY0FZdGFHbjhadGRPcmdza3o2VUx6?=
 =?utf-8?B?K25DNklHUVpsb0ZSV3ROU1g4N3FpL2RyK3NRYm1DM2haRHpOMEZ6RklaZXhh?=
 =?utf-8?B?ZTJNL0dWOWd5MEJmMHhWOUI2UlNPMVM1dG5pNGRSR2E1OHFBL2MwQk5PVDJn?=
 =?utf-8?B?enlwWVNMZ0tHbTdmR0YrVE02VFdpZU9RTHpLbitlMmlSUHFHWFFoQW9DMFU0?=
 =?utf-8?B?RmF6VGlNTmtraGZwSnB2dzA1Mm4zQUlzNUhGRG9OR0dwYlZDV0E2UkEyZXZG?=
 =?utf-8?B?bkNpUGl2TkxBRy9vN3JLdWFGY0gzeFY3eHNGakpqbHA0M1U1MWRqUVdZS01u?=
 =?utf-8?B?VitwT3NVSG5qNytNQVdPT20remFsb2Y0bWlDbHNxK0FFT25zSlNoUnllOW1h?=
 =?utf-8?B?UDNDdVVIYjFxWXBHV2N4d3VEWVRZeEFTVVltcmxJR0lDVnBMMnJyQ3JnOVhU?=
 =?utf-8?B?WU5LT2NVczQ3Ukk1Q0JMVW9CaEdMZDVuTmhBREo2TDBqNHhpSmttaXFJVWd3?=
 =?utf-8?B?WkluS2xqRUVrRks4MGNkTnRLVTVHdlY0d2JZZkpKVklsbk5EUmhmcFlYZlM5?=
 =?utf-8?B?a0ptNFZwT0gvRVFzNHFYMGszaVdXM1MrZnVOQTlrTW1UK0Y5NEppYnpSVktU?=
 =?utf-8?B?ZDlLQTdrRmVranpDSWdma0F5TTAxMXdGazZVc2xPU1YwRmZFK3FDVmN2d05s?=
 =?utf-8?B?ZHpCS0pBNFZWSVRzLzlNbzIydXdvc3dkZXYwendadVF4QlJOVmg0eFozWjBX?=
 =?utf-8?B?VHl3VkRsSTJ1amJWWGVxOGhlWDBhdzZjckdMRUJCQXJKNTZ1NnA2U0VPZmRS?=
 =?utf-8?B?YktCNlVVYzNXTXIzbjNsQXR5dGU5cjQxa25pR1g0OXhNOUE1dFhDRkF0d2tB?=
 =?utf-8?B?NlNVTU55NXVSYXN6Qm4veDllVmZ4cUhyVzRMSXpGY3Fsd09KdzJyQWdmYkRG?=
 =?utf-8?B?dERmQ3BhSjlZSFFhQ1RSSlBHcDZlYkRUNE44aWJ6dTZIZjFid2VtblpUcG9O?=
 =?utf-8?B?dVlNSFdvcmMwc3U5aFpPdlIybUM0bGMzQUdvR3NPRDg0RHduZ09BQVRISXZN?=
 =?utf-8?B?VFdyQVllZWprTzlueE9jQUZUV1hlRVpmRjhFSGlOOExkZmFiUzBFMjZxNWJS?=
 =?utf-8?B?Q3pwNTIwUnFCT2pycHlWRWlrT3ZkV3FqZjhJSEJBR3VQLzBVb0ppVDFoaW5Z?=
 =?utf-8?B?cTByL0RrNVh2eE5zVC9yT3N4YUh4OVhEU29pRml4T3lFbWpMdmFhbVFzb1JN?=
 =?utf-8?B?WHIvcDRLeTFXNnlCcXluWGRCUDNETkJ4QlJJYTJGTnl2SGZ1NTBBaXIzenNR?=
 =?utf-8?B?ZHZQcjRibVg0RitLcFBqUjdEOUpvVTU4TkZSUlJXRlpFbktZKzJWazY3elUz?=
 =?utf-8?B?eEpiODc2ckpaOGxySE9LekVuL012UjhvcWR3eE5mcHpOcjBhOWY5UGpDUjZZ?=
 =?utf-8?B?Vm1zdFg5ODhONDVwc2U0dFpTdU5QTm9EVWxMUEpiVEd4dEY2NFNJTzZDczVJ?=
 =?utf-8?B?VEpRZGRjOW5kdmJHMldxMkVKRnZjc3lYVThjSGNITktSYmViNTR1SElwL3Bh?=
 =?utf-8?B?U0JLMlE4U3U2VVZxbnBnSDlpQUIxeWFMbHhPS0hMYlR0RTVpU3JXTzRxdC9U?=
 =?utf-8?B?YzJxMGpuMXRva0NkU08yNlV6VVlTMWdSb2VBaW4zL0VPZWM3azRMbXcwbWlq?=
 =?utf-8?B?djNUL3hIWjFWd2dvRUtiSjAxNGlmQXArVUdwbTZzUWJkTXdqVExNaHhPTHFP?=
 =?utf-8?B?WkZkNXErVUY4OWFDU1BwL0FyOEpyWjQzKy9seUZHdUtQeHc5dG5rbEVaRlpj?=
 =?utf-8?B?OVFQOUsvM2FSZHJVYWNWNkFZUWNXWU1VMS94TWUyTElRM3A5MUQvanZvRFpR?=
 =?utf-8?B?ODZQU2RoWnBiTWh6SGpteVljdzFiK3NjdHNidG1EYVFQTGszOVRBSUVjcG5u?=
 =?utf-8?B?QmdPR21rZjBRckNBeDFSUTQvZ3lNVmhzeDRPUWFuOVM4ZEllZFNPMTRqdVIy?=
 =?utf-8?B?amlKUXJBVUdzNlBFVjdjZ3ZDcUh3M2tLc3NTQy9PclhhTUZ6QlZuejByb0o5?=
 =?utf-8?B?b1NLL29FMzdsMjVHaEcwbERPbEU2ajJpN1JEWHN2b0VUL3lRMkh0SnNDSWlN?=
 =?utf-8?B?N1NMU0pNbzVUSmpVV3JuQkJTL3lTNks0Qy9UQ3FONnFKUncxbFlYcW1IMkpW?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d18bc9b-843b-447d-5dbd-08db0a7bde73
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 08:58:53.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+gJRkxbnZeaaEKM3sRua194zmkA0V26HH6ja9xeAwhDeyKPZj4y2ws6VB6W78+St3mysocvtGicFETOrvHONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Feb 2023 08:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10631

On 07.02.23 14:36, Jan Kiszka wrote:
> On 06.02.23 09:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This is done to avoid infecting other layers with the snapshot version.
>>
>> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v4:
>>  - Restore and rename debian-sid.list to cip-debian-sid-snapshot
>>  - use squash to avoid wrong file assignment in patch after renaming
>>  - Replace Variables in *DISTRO_APT_SOURCES with names
>>
>> Changes v3:
>>  - delete debian-sid.list as it is not used.
>>  - add missing newline
>>
>> Changes v2:
>>  - split renameing into two patches to avoid wrong patch
>>  - add missing newline
>>
>>  conf/distro/cip-core-sid-ports.conf                            | 3 +++
>>  ...ebian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
>>  conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list}  | 0
>>  3 files changed, 3 insertions(+)
>>  rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)
>>  rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)
>>
>> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
>> index 0b369bb..c5d1cc7 100644
>> --- a/conf/distro/cip-core-sid-ports.conf
>> +++ b/conf/distro/cip-core-sid-ports.conf
>> @@ -14,3 +14,6 @@ require cip-core-common.inc
>>  
>>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> +
>> +HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"

This is incomplete, needs both host and target apt sources. Fixes up in
next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


