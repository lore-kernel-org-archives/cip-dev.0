Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF60DC61DA4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 14:59:16 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.62])
 by mx.groups.io with SMTP id smtpd.web11.16452.1675349954433161921
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 06:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xz9dl84Z;
 spf=pass (domain: siemens.com, ip: 40.107.6.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq/d06qwUgD8rVvBPIu1/tf7BRixHjc8Lvn2H5IEoMh+n2QXqdePtGOZ4m8ruPk+s6ajutaFiw3BJDRF9Ro5DRNQP3py76hYisuI26oWp4rLcrGQQtHdKqJp9r6OO1GzYLupKg68btvawe4v/96zTRbLpVPCw+D/DK+10dund2ww5kLNofICj4eMdUQkfq/zfJcz2WQpm4mkV0oQb8v8J2LksM35C8pUMeELEmkO9YQShn+m3up+SqbDgbfs5ib8K/tgsxo3qMdE9iEQ07VrwRjTP0LhMwQgPVBwofyEJvEcWqEnXt3TQ3Bp8TaYB9mLa2WjqBz2xsayS1pwhJxL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BPTq4Pi9XwaShjzuFAYM89qiqzyM9oziLNDZ/GLRHY=;
 b=Q6wEziLLK9OPgJODFjYIhzlHcDn9ytQiRvaCi5pE4A1l0uFFNy4uawP462eD+OXOvIIVTLxQr7PBoFM4A5VbnAWpTRrU023t3ZVfVatI1pBCcq4w5HBynbpcxu43l3ASlVrthICmhGYF8jK8sUK0C3HhgdLaZohvyBrpXt1bhlXLyPd/T6Da12NBS+ePR3Vv/s6Fdj6A4ny8gikeS0hvYZTaAe4PTowg5ugcMoMIojXRLL8bx6zbS5uDbLaHDpmbMGTjtClCgm+Z0tpzpJ46MZfNqNBcrc7HM/GmtTInGHknySRMPo92OZgbyX5tvBocRLEm+xezvthUYbOvhAYEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPTq4Pi9XwaShjzuFAYM89qiqzyM9oziLNDZ/GLRHY=;
 b=Xz9dl84ZIWhIT1385EKwRN+r9Isn5FLCZcgG+u5Y/mnZvkDmLpALIKkF6NJ2sdEGuPe72Nc3W5u25s35vgM+6PI29hH/33x1j11cUl5r3FM4h5qF+C1UIBXKgtAYmLT+0pxG3+sb6EiKZ3HxhZl0Oyp9A+gIlc3bks6ce8uMhMTsY+KHAEDDLT4la7xZnXF0xj7fFHrdSrDU7F9c/PqsSl65Rx9gGvy6NcMMZyCFFFz15iufxSWc0U2fsSsGbCPIwiW9ZihfcEFGMfvF9KaMbDMfYTYmQE8iwqS/VsHDFChsOtjwK/024oJAKgGwGqp2vHZX/Ns7SsOSqxqCnjHebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 14:59:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 14:59:11 +0000
Message-ID: <7e42959d-4509-fd75-4a9c-22db5f876117@siemens.com>
Date: Thu, 2 Feb 2023 15:59:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Override of sid distro config breaks mirrors
Content-Language: en-US
To: "Moessbauer, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <0236184cd3f04ecb0a3282bdc6c8fb7eeb04ae81.camel@siemens.com>
 <65f143aa-3e48-9075-357a-08087a5e922c@siemens.com>
 <5ceac9cb0b555bb7678894eb3f151aefe797465a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5ceac9cb0b555bb7678894eb3f151aefe797465a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3979:EE_
X-MS-Office365-Filtering-Correlation-Id: a10e0409-e517-49f4-478a-08db052e0b24
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b9vNh4b0nTna0laTOgQRgBc0h+Je72YU19OuiJyNbiS+7M2YD0uvIFErheKGWBsx60hZ7xcGgSmMZ4jm9GfBmlp5YkrO76M4UAtTqQWpLM1MvuHBPrRgtN3QZJzx+1LvlFJlwU4+dS/HJuz2UPgdaXxihJNLxKt3H12+YevXTKgoZp01lPDm+uvqvBAkNv1tUpztBzreWbM39fnvXKfMhSWTr/vteXohlQRROjfpRHwfB4wPl604YnU4VHffDboKnWSP38xs7pLTWyxP8IT8QMbOARV7913APHDUzmtoVE3eH9Q/zv2+F14lh91Ia2wLmtqob2ONxGH/rB8/Ay8EdaHuRuIwqJ3MX8FMrtteA+nQiS1lUdaon8BySOMvzAkzJMoNcelAz8ZTIP0IMyiLzFRJocJOZ1NYUYwFcW8T4I6VLyYgQszKAm5KFqCAKSXaByZeIpTp3jP+Szj66UN4IIoQFMdSI9pAtjV42q3i5qMGBGwdwto+oMopJDJPLgwOfu9+C8X+X/i/VVesI44GmPAvpZvWF2E0y8l/t1511u3Pmvz37ForCJzOzT0KGTmerZvJhYq4Mfjd7W3sZVADKONh6ZkOnoCeeZOl5HTjTUeEKWNN0DEcPqAnafdcxABzLwTAWlJb+4ateG4Aztek/khQ6NA/L7wmrJ0gjQFjmcCpMG1XYJJ1dMcGZyCrswl2du2SuCPap4Y1vHTAXmbIBLTa6qli3T06XzXs68MjRWn9T4Ox5NQedy6eaZpQ7xM/yGEYhAlddG/HuOFrfevylA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199018)(2616005)(44832011)(31686004)(4744005)(26005)(186003)(6512007)(6506007)(5660300002)(53546011)(83380400001)(8936002)(41300700001)(478600001)(110136005)(316002)(966005)(2906002)(38100700002)(6486002)(66946007)(8676002)(86362001)(6636002)(66476007)(66556008)(36756003)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SG9iRFB5YXV1YjQ3VUdWbXRKYUp3NEdvMDg0MEN0MUxTcEJwNHl5a09QOGZL?=
 =?utf-8?B?MHZFeWJTK1RCbzQzSnVCc1QxcDBDZXBBQkFhNlRIekpNSWs2UExYNmhqY0Jk?=
 =?utf-8?B?NDJ6dDZSYnBUZ0lTazRtV1gyZUs1SVJzdTA5TDdkV2NKRGgvQzgzSkRNOEt3?=
 =?utf-8?B?R1lESFN6OU0zbERjL2J5MlNMWGRBaUxTYklxR0p1Vm1iazRvOVJRUmNwUUor?=
 =?utf-8?B?dFdlYXdOa3dZTmZXaExud1ZOcFlCOGVkQWZKRnNKcHlwZ0FIV08zWHVyM0hJ?=
 =?utf-8?B?ajRwQnBSOEJJNkFXdHpha3E3WVVMVFMxWGRoUHdKU1dXMlhDTWt0KzExVEQz?=
 =?utf-8?B?NzV2RkdHVURaRnNRSWd3em4vTmlsbVVwT3BvY2hrdmZqdHl2aitMMVJPbkJW?=
 =?utf-8?B?NE5uR24xd01CVHl1aWtRT3MyZFJrbHJKVm5zcVVseksrUXFnd084UzA5Z2ND?=
 =?utf-8?B?YlNsbXMwOTZVRzZrek1mWnozeUk2bldvQldtejZ1aHFyMjVSS0k0U24vWDVU?=
 =?utf-8?B?RDM0NnNrTnVaNzhySkg5Y2xTbWlBQ0NZMisxL3NnbXp3YWNWQUJyc2hSZ3h4?=
 =?utf-8?B?ZllnNTREdFBEMGg0a1pxMTZBM2g1ckhWR2xNMmJPN0lZSGl3eThhZXI5OVFZ?=
 =?utf-8?B?N1cxelpzZ1lQeXlTRDdJM0x0TkFvdktINXdXUEhvTDlzY0VzS0xjRWZvVkh3?=
 =?utf-8?B?K2VQd2FyWVpWSkFWdXA0QmZEN0dRZjM3NnI1ajNjc0VBN2paMFE2akJlMnlH?=
 =?utf-8?B?MXpLbFhyVnJFSnIvZGRsd1JTTGlXczd6TGNVeUxGSW52Y2xQaS9BcHl3M3FY?=
 =?utf-8?B?RlNwVmU3NmFlODJLNllDTkR2c3lZNHRyRzg0c09aUWZNQjBUMC9HNUZzWkRm?=
 =?utf-8?B?eURkSitmdG1NRmRjdnYyUXFyOHdWam1mMGFpNEp6cTBOSW0vbkJWMGNvRXdo?=
 =?utf-8?B?WlFpQTMxS0tORVgzdTFaUEQzWHdYZ3R5SzJGQ2lyQXhmMFNWd3BHZHJNbVlU?=
 =?utf-8?B?bHhSZ0dCeFZJZjhpdlVjaGEzMzRsazR5YzlrTStRbkNNQWJGK0QrcnAyUTBP?=
 =?utf-8?B?dko4dnU5WGgxRmFKMG85RS9kdVYzRjFKWVBZYXBjQm4wQThtNHNCRVNYQ0t2?=
 =?utf-8?B?T2E4K2p5K2pWQUNTeWhvY3BFem44ZjFkdVg4bDQvRm1qRDFZdmROMmlibHRM?=
 =?utf-8?B?V2d5bVpxZW0vUmkvekZSQUNvczFhTCtUK3BmRC9KSlJhRVNCQ2RFblY3Wk9m?=
 =?utf-8?B?am5QZjYxUGlzQ3BtbXZpT044VWRxNTMrWU1STk5TbDJkQmJEbXpMdTJkTWdk?=
 =?utf-8?B?WDFRSnhhMTR3N0pRdmw4N1I2ZGpRNy9GcjI0c0J2ck9mUUp6R3hvM1FDZFNp?=
 =?utf-8?B?dGk2b3pMVDBObmgwK1pXOUQvRjdoc01BaHJYbjlxZHYxK2RPenEzUkxQWVZY?=
 =?utf-8?B?WkZNc1NUL1M1ZElnOHVUUGtEN1JJYWh2ak53UGFrNUhYazBFRDdJM0d4bXo3?=
 =?utf-8?B?Y1JIaVZUeVhCdFZxeTZkc2NlL09NcXBrdGNENkVuc0lRMmtjb3RMRVQvWjMz?=
 =?utf-8?B?QlhWaW0zTnBJai8vV3V3WlVIdXFiY3hydzZzZHJTV0lndjlhcTFzNW8wenJ6?=
 =?utf-8?B?SklOcExuS1RhbDAva05VZk9GRWhMS2QxR3BFdXVxUitpZHdkR0xUMkhjT29o?=
 =?utf-8?B?ZUxrdjMzR2xMVWEwK2VJd1hacmRuY3NPNnNzUDFUNERXV3pCR2JmajZiZnRK?=
 =?utf-8?B?K0pNRkIwYXdObEE3eHRleGtGc216aCs2MEZrd3Jrakk0eEVXa25DYVJ4SU5z?=
 =?utf-8?B?R2JYMjUvR1dlTUtYOXJKUE9PZG9aN0I4Wld0RWZ0cGlBaEdWVExGWWs2Ky9x?=
 =?utf-8?B?alZxVUtuc0QxcmtXR2dROWwxcE0wN3I3czFnK0drWC9qbTlMeFBHNUtaV3pO?=
 =?utf-8?B?MURaRXZySkFxNkV4VndqVlJKN0trbUQxYk1sWS9VUExMT3NlQ1Z3VjJlWURQ?=
 =?utf-8?B?cm92VHdTWThnWEtpYXNadWQ5TkE1endwaUNBRURqcjhGMlRNMkMvcUNFZnRT?=
 =?utf-8?B?a2N1Vks4MDhkSW5DM25VbXFuL3h3d1BvYnBUQURlSm1MU3JidFBkOFlEN0c0?=
 =?utf-8?B?WEErVFdPT0hUSm93ZW1jcWJJM3VmeUUrYjRXdWxONEoxRm9xeUFEM0Y4Y25m?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10e0409-e517-49f4-478a-08db052e0b24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:59:11.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbRZfymBZHUwx592F1f84jF2eqaxnOJW+GwQ/iuL6T0yPkiP4SqdynOAUZZmhvSbgODoQbs13tvbF/OmX99cUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 14:59:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10567

On 31.01.23 10:09, Moessbauer, Felix wrote:
> On Mon, 2023-01-30 at 12:01 +0100, Gylstorff Quirin wrote:
>>
>>
>> On 1/30/23 10:58, Moessbauer, Felix (T CED INW-CN) wrote:
>>> Dear devs,
>>>
>>> the distro "debian-sid" and "debian-sid-ports" is currently
>>> specified
>>> both in ISAR and in isar-cip-core. While in ISAR standard debian
>>> mirrors are used, cip-core pins that to a specific release on
>>> snapshots.debian.org.
>> You mean the list files, which override the list files provided by
>> ISAR? 
>> Because the only distribution in isar-cip-core is `cip-core-sid-
>> ports`.
>>
>> This looks to me like a workaround to override DISTRO_APT_SOURCES
>> from `conf/distro/debian-sid-ports.conf`.
>>
>> I pushed a fix at 
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/quirin/sid-lists/
> 
> Thanks Quirin. I tested it and can confirm that this solves the issue.
> 

Then someone just need to send the patch :)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


