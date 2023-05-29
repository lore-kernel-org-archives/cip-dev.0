Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA04C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 10:52:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web10.46914.1685357572257169292
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 03:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=URW87l1W;
 spf=pass (domain: siemens.com, ip: 40.107.22.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFMdFoOAhUpNY7gOdM3jJviGaggNqkxRiY9OB5BFnQtZXll4mDMg1QY/sQYMh3JAPbTCl83kHVgWOb8AaNY3IaRuh4uQznaE8Qv8K8UmHncY0r29OXjzrppjUkhpHxcf+UKIytRGNoFsH6G7zlCfY0EERh2uIeIiIywaW0oR9QQf61sQCfDjT+L8En2HUDCtsVBvvDTBNa9zEKHdvNJxqCZ0BedQfbkPWwQNwRYnB5Vae8F/h1yLE9TaC3xAienlUhaTTP46DH7LL6JSryxOjobgFIB2LGPEMyhbWVYYbZECYGZGennVkLXM1SQ647A+XGBRhaa2LYfAYgNSYt1N6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxHIVBIjCpAC8O0jSXwuK4i5mD2pziW+p7NgBjbfaCQ=;
 b=RIzYKH71qk11q1ellw0gy7Gmym4WD039LqWxJNGETZ9y1h0qUpnZLhKZ7R5KDnwIYkjSl2wQZzbV0bqnk1ATSTV81p0pvJdA+kEqZzfqypwOIIq2iDziqGTX7A8ZR2HWt1xA+EsmQbNk+EDZm0z1iOs0uxDjPvVvtAxQatgVGX1ftpFdVX2cLOjKPsCSKyHP9LYm6ulOD9T97ycUmCKpKkUxpizLG2wCNqhxhEteinLjbEveK32qx16N3AF70W0otZ2SkQ6aHWC4UbRt+QzxU9k5sNTp/WE4QZZJzrG/mogtnYVAV5U0enVkHzkJ1qqt9ts8Dd45mNyZ4UfPrkIMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxHIVBIjCpAC8O0jSXwuK4i5mD2pziW+p7NgBjbfaCQ=;
 b=URW87l1WsaC92f+UE0GqlOmBiMjkjz2gOyBd58KgWWNlnwZb07WLv/kWW993lKZgG72nOHVPIpfM/gYMY8HmoIaiQwYqet2ZTZtoA8lp7q7MMryaUdqpENK9haqORSfJd6LeX3ovvqmPr2iWUzTNUYU9pavE59Wv+aKyjqSThZGb0FLEdIyr9gg7jlTx8PXom0+PEpz2beDS4J+JqtEzZT91fb0oBd2YpHWJUFd0iV+Fx3K4tBVKswVn0jpk0zndADgaOKaGqGrUiVBI+knyFSWYskhf9v6v3kcj6ODBk1Nb6uTCMK8ItAHinOX8Vp9hc0225hYsKmktWkxus8HiGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 10:52:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:52:49 +0000
Message-ID: <a432547f-a4df-c629-483b-fb85962acc36@siemens.com>
Date: Mon, 29 May 2023 12:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] squashfs: Fix vardeps for SQUASHFS_THREADS
 and SQUASHFS_MEMLIMIT
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
 <f36525bc1cc242990263b839798c8977803d3d4d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f36525bc1cc242990263b839798c8977803d3d4d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b804af-6270-4022-e20c-08db6032d7aa
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ooW0fJNJFlzaN6JObMbkecOl2FSp9mjrGibBZkbis7jzlRfwwkNVf/6LvZcUol0SVvCBn5SOCwUF/eqe9H9xUnGCbgiQbPo/cg9fhpTt0LAmlXt3bnr8hSYWoWIPhTrwtZpmUWkzlBjyx3YXwzMo4FBm1R9qp2eNy6dEgBEaswYzDYglEMgYX4lSDa5nM+gkPwXgMC8PrxYPYi8JVrWSKXjkcxfS5dCVXsTveQ/diyy8JL2MN9CzcQKJY5MiYviwXrzGCn0nacxzd1Bf08iNItgw+epWg0YvrtrZed24MP+fJEu7WxMnnT8NpxyMiAGN4qz84kqN8yw4Wc1xcnAQNaiYu5GrHYNMiGT6JkLCYpmdEfM8T9qQaUbKmXrbzanao0Pat7LGIlQ2abayoeeq18WQVkcMnzjusSNa7ieLHD1KRimnaVSjqeZIjW0bP753ozHMfBui1dLGcV2xQCe2DVzQFDEWWqv6iXIWIxTgBjerQx2uocUyCUC9QWXXoc+qJVwyyLwRMVmj/p2m499dcistTMVh8N9IOHsdxeWobwWlkvnCQRcOx+DkDD3LKNpYtCGHzfe7yZEy5h1duRVN5+KM/toSJFvgMGir9iV883v1OHCKKuMFTjgrAkGvycJ9tEiPg34HyuU/poWhWcmUUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(186003)(38100700002)(2616005)(41300700001)(31686004)(83380400001)(53546011)(6486002)(6506007)(6512007)(26005)(6666004)(478600001)(110136005)(66556008)(66946007)(66476007)(82960400001)(316002)(5660300002)(8936002)(44832011)(8676002)(86362001)(31696002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2ovYmVkLzNYVGhSR2tudzFseituK09RaXJBUmwwUWZSTHAzM2puUStHN0Ri?=
 =?utf-8?B?N3ZMOEZpOXFSYTZsVlYxQW9NaVBETGRYU3cyc3BkSm9wVElFdmJkcmFNYlFD?=
 =?utf-8?B?TmJtdDdmejBnT01QUW1xdXBuN0JhYllPc3ZoTVFNTXVpLzIvVzVVOUtEcFpv?=
 =?utf-8?B?YnhXdEZGQ2paYmlhQWRTVEFTU1JuWlR0Tm1SVDQrOTB0VDZkVDdsTFJhMlg2?=
 =?utf-8?B?b1AzN0g0bEF6a0hHdVFjL002aWxpY3k5UUtnSzl0bEtaYWVGZzArTHNBK2xX?=
 =?utf-8?B?RmhSVElJODVvVmt1Y2tvL1REd0ZFN1JNNTNQbWFXRHN0azg2a2UwcElQUWVh?=
 =?utf-8?B?dGVUZ0R1MVNnczlnbnNMU0VmSko1QzRoVm5mMzFQMkV0VUp6dzh4VFd2TGRy?=
 =?utf-8?B?Z0l1cG9SblQ0TEc5eTdoNFY4NzlBVzYvVEw3VHNBSDdqYUdyK3hOTTg3UHRu?=
 =?utf-8?B?ZUcwVUdFOFV5QTVDY0N3QUswaHg5UTB1QXFqbWoxUE1IVHFDWnVFa3ltdXdq?=
 =?utf-8?B?SEwyd3ZrcGJVOStYNmtoVzFzdWhuVnZuMjFGMDZIbHdBTktqdmpYeHY0ZDVy?=
 =?utf-8?B?c3J0Z3JwSEdEUmlBanV2NXJUTFJSeFIzTWt1TmxrQlhES1ZPQ1BncGRJMVBs?=
 =?utf-8?B?NHVodzdpZEhuV0N3UzI5QllBNWNHYjJPUGdHOWsyMHluMDdvUmxVVHVNaVdw?=
 =?utf-8?B?U0NyUlM4dUZtNStDN0VaSjRScndkZ3BqcVV0VHNKcERGVGh0dUdqa2oydURk?=
 =?utf-8?B?SGhGeUhLN0lUdmc5bTJkYzFpVHJKOE43MG5FeTZvK3RLajNUZ1FFUXgzTGhB?=
 =?utf-8?B?R1VEOGtBYnN2YVJVTldKaVFPRGVZZUVBZjlXNXBJcW5DcGJwQjB5VEJGVWFv?=
 =?utf-8?B?TklkNFlDam9IK0dYRWZKSG9MRDNvTzNIMGZFeG1QeHlrQTltckliZDhlc3pZ?=
 =?utf-8?B?MXdMVVY4TUovejhVTTF5U01XSi92dWZrNkVKWnFSWWlCNmdWTFFQSGhrWkhm?=
 =?utf-8?B?S2NXTE1Ham9zcndmZXVFbmxrZ2VxM2Zid2h1RE5LR3lCcE14QXRuVHdUL2JU?=
 =?utf-8?B?T0tXR2tuUjBGSkJuQkswb0JYcU5mMGlqUUhIV0JpZDNHcHlFanA1bUF3M244?=
 =?utf-8?B?V3l2OExkUVhLakNuamlMeXZNdGxrWWhpRVI0VTNuUTBRN0hPdEVPNGM5Mnh0?=
 =?utf-8?B?VTFqcU1IUjF6Yjh0LzNZWDVtOTFKRDFQNWZRREU5Q0RwUVJNdTgxVVBiZjdY?=
 =?utf-8?B?RjNTSGlrT3M3Ri9qb2hocy84OTRuL1VrUytoWWhHOEVQazk1clgrR3MxdVRQ?=
 =?utf-8?B?TGtZbnBFTzUwV3BiVlUzZ0g5WmJxMlcvSEZ3V0dmd2ZnVlZQK0FKZGN2ZHha?=
 =?utf-8?B?SzdTYUJ2a2IwZ05Ic3ltUHRxenk4blB6aSs3WkR4VlRzamcvM29Ua3FtZVlN?=
 =?utf-8?B?S3JqUEJDZmNWK2kwbDlkaDdVbDhoSzZTTTdwK2p3Yy9qVURvK2ZYZjFaSkRr?=
 =?utf-8?B?U214Ujlwb0xoWmVFUE9WS2ZNT2ZxajFQeTZvU3phbkFieG9wZHhtM0l6QXpB?=
 =?utf-8?B?dlRFdkxKdHJwbDdZdUJXdGdwSUJlbEhZMDZLYjd1cnRRWm9sbkRvYldkSTlI?=
 =?utf-8?B?dXNxaTVHbFFOd3BvRDgzMDNJRnlwajNHYnlmVGtnK2FXNm1Ea29PeDQ5Tk9M?=
 =?utf-8?B?ekRUZmhVaXMyTUFQMy9URElKQlY4MnF4TVd6Snh5M09WNjFUWlB6aUtTNnBn?=
 =?utf-8?B?MU4wNFJoQmpqN0lJS1crUzltdktCVVZLanBwemM2WEpMYXNqZ0MvMWY3VTJr?=
 =?utf-8?B?TjJkREJ1T3NNRWEzd090bXpRN2g4Qzk2ZmhrUjhkbmZVMFczZUF2ZHA1UVdq?=
 =?utf-8?B?aXFUd0g2YldFOGNocERuMmFDbnM1MFF1eCtUK1dwdS8zTVRnT2lTblpNZTIv?=
 =?utf-8?B?TWQ3enNqK25HRWpSSmI5MFVOcWN5QmNkay9sYXZoMTlWZFU2ZXQ1UVplTGdt?=
 =?utf-8?B?QzBZSzlRb2RCWVFaOXNuWklRMm4yeXAzOUptOWpKbVpjdVdCSWlpNk5wRnNX?=
 =?utf-8?B?QUVjMVFZRjFDZ0gvTHhQTlhEelJ3M1VIMERkcmM0NFBSRWNENy9SUWh5Vklm?=
 =?utf-8?Q?pQnENZW39qcWMBssm8cTxY4cw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b804af-6270-4022-e20c-08db6032d7aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:52:48.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3rWstIj/WLUA8RUIFXw/leV/b3wKrBXsMmML8ge6ZkYr2ld217Uuycp5sn2V7fAGknEM5hvI1pz1VQAQL5rsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 10:52:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11694

On 29.05.23 12:24, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Sat, 2023-05-27 at 18:47 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> While SQUASHFS_DEFAULTS was decoupled from its potentially unstable
>> inputs, SQUASHFS_THREADS and SQUASHFS_MEMLIMIT, the consumer of
>> SQUASHFS_DEFAULTS was not. Rework this moving the vardepsexclude to
>> IMAGE_CMD:squashfs. This also obsoletes the related vardepvalue and
>> vardepsexclude for SQUASHFS_THREADS and SQUASHFS_MEMLIMIT.
> 
> Why was this required? The consumer does not expand the variables and
> by that changes of e.g SQUASHFS_THREADS should not affect the hashes.
> 
>>
>> As we are now expecting only generation limits via that ignored
>> variable, rename it to SQUASHFS_CREATION_LIMITS and deny overwriting.
>> Only SQUASHFS_THREADS and SQUASHFS_MEMLIMIT are supposed to be tuned
>> to the build environment - if at all.
> 
> I'm not against this change, but I don't understand what issue is
> solved here.

The current code broke as soon as patch 2 ("Calculate a smarter default
SQUASHFS_MEMLIMIT") got applied and actually brought variation into the
variables, and that already during runtime (changing free memory ->
unstable task hashes). I'm sure you can reproduce the issue as well by
varying the number of available CPUs between builds.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


