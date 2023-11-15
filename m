Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D2BC2BB3F
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 15:50:57 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.60])
 by mx.groups.io with SMTP id smtpd.web11.16692.1700063449901981384
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 07:50:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OkMV6o75;
 spf=pass (domain: siemens.com, ip: 40.107.103.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+8BguM3B+h7FZohIob/qhtJu8V/rGZRxUYVngRQZvwknYEH9CDQG2NBpHmk2rbYcLpW6kKxp0L0NdgNvY9rF8g2zBz2tx67M52CcC2G+ea3d3cUtZhPmLrtyx/PUCDZqYy/LQSoMWXp/jM7LG2Hq8y4tu+MqZ8x+y018R/cOV2MeXZiMtveB1kfekCMfJYDaZi4GmCF7Ns02ikY/5FY4f6PRP5pz1Gyb7MmxyJvsoO4abFjpYiaJhgo6XcnSd8I2yX3yYvfmYZ0Y4hZAF0SWH5mVSFCtx6kC2uMUlaOyh3UZiM3AVlSLjmUPVFeUIOtR7I3O67Huzg4sCikJOj2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkyidhusUXynbOemQ8pPGJy/c3g7PU9trtWTNye4Thg=;
 b=RYuxLstCgzsFCy8zbU2LiZ03tHzQB+Gilo59iLzIs1P1KeMZ+4KcZ9G7BuLjEFzA7AC1xU7yGLj4ZAqvD6QKeH4Fd+BbdhCAJPQII8ywUPVCoJOq7tMVQtRuY8dnIRHJ7gi2TYXXfnMgRjZ0ITfLe8i6R8/wkpUlgyDI30Ax9qW2rz0SwYshoLZMmKfNNIIRKyCPwTIjNqRlfqilnxiV427ZKL7Y9UU7GKVisVL3AevTL0Kh+K//Gr2bOCxJKrZJnHWV1p8zqr0TFXhb/PIqqHFrd+bSLMIgs063TlUNRG4FUOmPIgMv54lJeRKAPragCbyGjEYwSPzgdzg9tV+z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkyidhusUXynbOemQ8pPGJy/c3g7PU9trtWTNye4Thg=;
 b=OkMV6o75FhEqzwF6zqYb4OAOIkYhY2T8kSEDP6wTaDuG8s3D8sRcOKFoISRfQizXlsgqO0AeUnT2WwGl9KR8CZMpF7bRUUaIzor5ygYLo1flKZ0Gk5J8aQlAHUNdptBsBFRlPZx2WmqrGublXv0GTPblDgbWC4fEX5lD4vFMd/DScZiq+h9sVL7uXgp25Wv5Yc/0V48Mxb/3i+Hfp9wuSJhWrFs76tI3JnzOg9LSJ2T3aLyp3Oh/WPlrwP7EOVMXv0U4WetHqQaRU7iPEu9Hxavie9zZaS+FSSdzn46LtOlCM6IWNhQQCIivXqvDgd81dmKyWWR2HBzBQghjRE+J8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6418.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:50:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 15:50:45 +0000
Message-ID: <69502f57-633a-47a9-8a9a-2e7ad1768269@siemens.com>
Date: Wed, 15 Nov 2023 16:50:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update debian folder to
 2023.05+dfsg-4
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
 <eb98a52d-9bd0-4583-a148-81ef1253c6ab@siemens.com>
 <6e0de253-9504-4de8-8b23-849d6dd2bdcf@siemens.com>
 <445986cd-4714-456e-8117-e349b2860c8b@siemens.com>
In-Reply-To: <445986cd-4714-456e-8117-e349b2860c8b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: abe34f0a-7dff-49ed-363e-08dbe5f2a138
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4U66e/A6JitW7TzfK8hVwGZmrJW96gZzKrHJnmkJuP7nbUMBt2/v86SOc8jtY+6YbZlPhVb1RLkmmye6f2BdwbZR7z0h99Xq68RVkkNQFIngUBy+DfNbimcjgq71l9wltmR4jvCpI0rA4EHlPuyrboMlDo90y4YpYHRGPef+0MmCxk8vaL4f7niCDbzKJv9Ihf0LQb5yE+tb42jQeunSiN3kZEefU+vw+FI+1eUXRP0CqaHwm8gPDHft+eFvGKOmcsjyr9CJhtwQ8dBLRO4HhPJBJVOxZeuRxN7DhVSEYsHYSRLr9kUM5o9jXjxkcwxm+RfIRdwrret7NdQixl97HIiL/WKZnMPO6M9Nu0deEfZecvx6o/QOWHOGUMlSuvPkYJG74cOsKIqe9BcsyB+ibsjlKTb1V+dug8Gdsppj4C1lf34dS6MPsarF41EWTc6Bu7QI6iwtEZwRskFyWVsk4m/sJnOYwJ9cHB+LSYoo2r4ti6gw8VHuT6gq1zRof7IaLTdGyx2/hS0+pcn7RrJUUy1i5iObml58XwbD5XvBaG5hPDweYV0Qc1tVULRdy4aKqFhqTdzTxx/YkZl1pLbzY6XzQlbHgHKoRGvlaG/EIvOOPqIW35/sQEaD7XMk+yzpZlMamVt6txdqBwO30PnT0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31696002)(82960400001)(86362001)(36756003)(44832011)(6512007)(26005)(4744005)(2616005)(8936002)(5660300002)(8676002)(53546011)(6506007)(6666004)(66476007)(83380400001)(66556008)(66946007)(316002)(2906002)(478600001)(966005)(6486002)(31686004)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTlhMEI3SEJKT2pyb3BxbDBOTjdMbmJHMHRKZXlwZkVNT1o0aVZqWDZJN01U?=
 =?utf-8?B?ZE51REU3QXpKT2pOK25BamZrVGVLZzVkTlZGa1NqcDRmb21XNXpKL203L3ov?=
 =?utf-8?B?TmR1eGkxT3kwdHdLNXBGaUpjTGN5S0xPT1FFdHBOelJaQWIyODVCem0zZzZn?=
 =?utf-8?B?SDdhcGlVZEd0ZzFpVnlIY0JSRDZZaGl1Z3F1UUs1SUhCVFdXeTBXcGl1ZXJ1?=
 =?utf-8?B?TlBGWnNERkl2UW1aMmZVTlJXZlU4YUI3REdDVzV3a3Z5bTNaWVlZSEpYZFYr?=
 =?utf-8?B?MmRkdVZpVE1idGZROUF0NDNPeXBXemYzS3dQZ28zU0Z0eDd2bnVOZm44ZURW?=
 =?utf-8?B?Nmk0d1ZPNjRCWlNhZUEzRDBpdEt3dm9aRnJuSlR5MUJaZVVWMjBRaHZzSFUv?=
 =?utf-8?B?dHJFS0pxelNRanhPMndxRmUwaG1vNTlqUmFyZGFvNFhMQ1JFWTFZN0lqUEdi?=
 =?utf-8?B?TFJ4K1dkSXl0SFBPdjlvZlF1Q3ZkbWhDSlRBc2x3MnJxS2NlbTB4Y1JBazlV?=
 =?utf-8?B?dmFEN25vR050d1pBZDRJR3BudTdkZkZzWllQbjIrWFRGUWNSZFlrQWpLK0tN?=
 =?utf-8?B?S2ZvSllvaUppcEtuZGJ1M1hac2dlL0YzZ3pXRmdzalNDMU8yMU9uTWxVVWV4?=
 =?utf-8?B?MnVhdHlnZ1YxRHpJOXRrRDBHclY2Zkl0TVZkczlYVlY1Ujl1UUhRZ0VockU1?=
 =?utf-8?B?ZUFONytJdGNZeTQyUGVTY0lnYk1lRTZDV283SjF2a0dUbjFtQkRvVVNHbGQy?=
 =?utf-8?B?eXd0aEhUcTdtdXFBc0ZCN1ZUUDBVcmlFWmpDa1pDUytOdlFRMjF2QUNLS2pH?=
 =?utf-8?B?V3hxT0tRNlhlOU5Bd2MrZVRJL3c2R0U5RHBINzN4NEMzUU5LT1VmU1pnSzh6?=
 =?utf-8?B?dkZ1RGVkV2FRaUhiL0EwZ2JDL1d4RDdKdUppenRTSy9reHJaaGYvaC9NeVJu?=
 =?utf-8?B?VU5vVUFVRnNLcFNTOGlDb0pDS1NmZnVNYjZqOThSYjR1VHlOY256bFJqZDRR?=
 =?utf-8?B?RGxPMjJkdXdOQmhZWXM0Vm1FZlJxbVh0RUhYNWNYZi93UUt4SkVvZnlzYS8z?=
 =?utf-8?B?QU54UlpuN3FEVXdmR3dibnhCV1g3UGZnVm1uanYrdTBLSFZXTmIwaXMwVU9W?=
 =?utf-8?B?eHhpVXBRZHZPVXRnVWdsM3pUSzc0eDMzSi9SV0VSZjN5dTBianA3SmdZdThT?=
 =?utf-8?B?NzJWQzZkUVJIZ1B6SEVqcUNPNlFDK2E4dTJjYnJqRW93Ym5UWE16WGY2R2dU?=
 =?utf-8?B?aGE2SEFsUjVpOVVEM0JCeXBtS3k1SGJOWXRpeUJoUWhocStJUzRzZ0tjVkxB?=
 =?utf-8?B?dmdwVmZwNjg2L3dCVU4yRUp3RTRhMStlS3NyTUZZZk14S3BOdTYzNDZCSXlY?=
 =?utf-8?B?Qk5lWllmUHV0QjdUY0UvZ0lZV0w3Mm8ydHA1LzFDd2RCekErWHllMUo0SnVC?=
 =?utf-8?B?RFFIRWJnVFJUcjZqclVySzY2NWFDTWQ0bklnWmZubHo0UG1lNWxDNjV1aXFr?=
 =?utf-8?B?UW1ZU0I1UmdtRzU0SzZicHdSSENKLzZBYkpGOHF3OUEzZmtEMlF4aE5GVGt0?=
 =?utf-8?B?TGhzK2NMMDhlaHRZdEJFYVoxd0JkNXJ5aDFxVnVxSXRDMjFoYUpZT0wzK3Fl?=
 =?utf-8?B?cERTMWRraVp6NkhlaUpkMEJmMTlsbERzT250QVp0SUpwQmJ4bTFzZ3k0Qm9T?=
 =?utf-8?B?d25iSndzVlhPclFZUXd1MWtyS2NPVVFwUCt3WC9zQmVrYkJrQmxkaW51djk4?=
 =?utf-8?B?bzY0OGJvY2V4aG5NckxCMHRuUDNGWVNTbXltY2xONVE5elJtZTh5QjVhTGZ5?=
 =?utf-8?B?ZTNMTDZzQnpPeTM5SWpTN0xrWm0wSGhNWnVSbHEvVjVWV2UyNEJrcHROT1J1?=
 =?utf-8?B?S0o2elJ0VGRlcTBEbzU3NUJiWm5nMFdEaE9QbVJYVkhUZkVDUHYrRnVId3Z1?=
 =?utf-8?B?SWszVGVWOEtManJOYjg1amlqVUtjWm9tL0pTYXdmMXRyYzlNNGgrNml6cy9I?=
 =?utf-8?B?RTlSMFhxa1drTnM0YVN1WGRLUTBoMDl1Rmc4SE1qcVdteWhPeHVqaU1Ob3NN?=
 =?utf-8?B?aGJ0WWsrdmJDazlQb0RjcGk3bkNjdzhDWjdaOE5lMlFFek0wSG9GMGFERktS?=
 =?utf-8?B?Z0lnQkJNOVBlNVdzTWcyUlhwWmk1dENYRlVJVDVOelpkK3h2ZEVGTVdVMGFn?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe34f0a-7dff-49ed-363e-08dbe5f2a138
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:50:45.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjWPXnrYDB1QgfG2XuhEPF0jrTHvXhOnSoyVrVq9/Kno0sGUGJ/odnYB6ZB79f/f24wVJJwNZ3KnXXOAqERiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6418
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 15:50:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13589

On 15.11.23 15:55, Jan Kiszka wrote:
> On 15.11.23 15:45, Gylstorff Quirin wrote:
>>
>>
>> On 11/15/23 15:40, Jan Kiszka wrote:
>>> On 14.11.23 17:37, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This adds the system user swupdate and changes the permission
>>>> of the sockets to 0660 instead of world writable.
>>>>
>>>
>>> Stefano had some concerns about the best aproach. Is this Debian
>>> revision already reflecting those?
>>>
>>> Jan
>>
>> This reflects the latest communication I know with mode=660 and an added
>> swupdate group.
>>
> 
> Prefect. Applied, thanks.
> 

Seems to cause a bullseye regression:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/5543285308

Jan

-- 
Siemens AG, Technology
Linux Expert Center


