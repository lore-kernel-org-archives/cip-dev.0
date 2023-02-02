Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17FC05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 16:00:36 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.59])
 by mx.groups.io with SMTP id smtpd.web10.18404.1675353634988170477
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 08:00:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UNSHx8eV;
 spf=pass (domain: siemens.com, ip: 40.107.241.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgKs+Eh4DUCbQ/cA/YAa4ppVGViEy9jDniydwFUfoHxC2SsPi/M4yMKDcUJ3cvjWoIIiv3N8KwIrNIz7hQ9URi2d9b//5pXRuNkp0OFlzhbsPA2Uj9lGnN9tMEOSoY6NPKxkETnXLExvxY84B/ByXGCBsrEtvT84IwoEzesUjO/hy6E9hVRlMG2Rtp/R02M1l5IgJHqCxXPQBIvQyGCkPY0mMgkIcF7lqLD4cX8cmwy4kkg9ADKCI2CotXlqrp16OGEobHBx1voH3Nh5u8GS7ZdfPTu6xY8axiA+X2zmAnBiJ10E3TbjOdhfutz1om0zZ6HuBiewgvt+CWEu3vGKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Lm+gqdYfEvgKlCUYgWhlgcGDaQ4qDaX149RrHGmibI=;
 b=ni9XG2DHYJLxE9zDKsIGNTDjUIS0dgm3iiRFURwl05lw/QxmKMluDXwJUcEDq0VkN3NFcqHZGtpvHdrwfK39dO3o86GL9xL7ZtSXAjYIci++o8TvsTY5E1QrHQlJd8lmBcL0sCOPFMA0kOTTuJ56dmlJXYMIZuQvSUPN5TZdQore83iMUKmaLtI8s/psiunMvMrqiW4+I1VBJZsShZDH2o2QBuMW4j+D/uXmgh1Io10bZ7tnXAirqc/D4nW2GjVWe1RXsH74gjyk77QTxTffw2wxDlZKphjdg4fJhK3p0um15neFvCF3I1AKvCpL1mK6EpV8rSzxgQWTgFwGRwDTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lm+gqdYfEvgKlCUYgWhlgcGDaQ4qDaX149RrHGmibI=;
 b=UNSHx8eVU6KAH9uJwDHYruW9wDQKjtSxfGt3BkO22uZwUWQ4O4vvaGjnvXLZQK4QFuWlxvnElcihtferCfPTnnJqoOt4ASRLk5H45FZNfcPbDt1sp8l85HxYeLN9QC7TLL5jnwpTJxbY2IHUALVJdQig4qYy8SEH4kRAidbkdYUi2V3RWxGSnuxSITm3LGzoOH6+AqtZgPOg8T0sHEO/J04ARVhZijPUdgPv0rCw5MDC0Zy+g7LAkoHFeUmThtMVlWUWttTqQEhmeyxDDc1exIo89WW9+EYQsjLdNR9ePVjI2YmI4xpF+xit3vdFWRllosUq8gCF+IOg1JMq8bMeDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 16:00:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 16:00:29 +0000
Message-ID: <80e74fd4-6f93-7622-6188-43301a8dcd87@siemens.com>
Date: Thu, 2 Feb 2023 17:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Enable Images based on Debian
 12 (bookworm)
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
References: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
 <0b9cea9cb50626a59ea5818fc3e7ed582c2265ba.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0b9cea9cb50626a59ea5818fc3e7ed582c2265ba.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:610:e4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4026:EE_
X-MS-Office365-Filtering-Correlation-Id: 9995999d-62f1-4229-b7ee-08db05369b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	05QBmEYyVEgztDOjzH+7WuFqexysDauf9YcW7zavfN9PPtBqZlBNvXnnFbklxM+c1ik9bjkadk/b5d5lgIuFlhkL/YGa1newmnA7UUcJgb8srlIsA5AxqeyqGgqfJzU/R3X7WXUPczibxKKpj0FKAKIx8B9wHpvSd9/6OjuvcBgxudYVPrnCCB1FZ0BhOADsikoppIWlt54nW8LkdKQ5ACmqVniq9GeeAex/zW8f2W9DKUj0qrm+1FHhmoIpKfVpdU5tViBPEjTVQ1tttJ1uKTnxugotXaPVIzpAxNmf7c1asFEdsG6DAMW0Wn+DujK65CC4KKxeohX9X6+eLicAeKQHiZOJSytBVXbAAEsDgcZv5/k0coyawARJuC2PMwIpCJQEmyA8haB8TBKMh9z+50JZ+s01YMAHL1xEmPcDaQLmpZCfcBUndYoVwxaF3uJQ9yasmpa2w6cupgYJLtWA1Sceb6jFkKaj/Jj/Mu6kNtanaodc+xqzOAN5kvANKVEckd2lJ6Uv/wCk+j5sL+YwsPIQqSCX1Cc9OqMc+BiIy0dIrntYXSC6Eokuxl1HL7m9MvpmIqyNnE3DHaInGkqt9s+THxHICfl6yjOHZKylaFGeHgfWcUjf6izwwans53WMp7EwqASv2jHw5iva7ayvQL9bZLW6LMVWDtr45ybaATq/2Y46uNHjC5TJzqT51WS5osR6BgGwLkH4TqhiH/gkBMbO2DSOR/vcSJW7vJYQpxk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199018)(2616005)(83380400001)(31686004)(82960400001)(38100700002)(8676002)(66476007)(66946007)(44832011)(41300700001)(8936002)(66556008)(31696002)(86362001)(5660300002)(2906002)(478600001)(6486002)(6506007)(316002)(6666004)(186003)(26005)(6512007)(110136005)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3RhZVo4TklmY3o5OEhQTWpSa3RWUHBmcElCL1ArSGs4cy9IbnU5c2xkNUdm?=
 =?utf-8?B?MDVJS1lhWU9aOGJyWXNncE84ZTdYOWM4NDE5VUllTE8zRjlHaFM0KzJkTnUr?=
 =?utf-8?B?S3NSbDhKYy9DRFB3NWtKdW14L3BrY2haN05TY3ZjZVFxbytCc3JVOWxyNDVR?=
 =?utf-8?B?YmRCNlVBdTZMQzhSaWdUSzRzTHFtNGVnNHV4SVRxNzFOUnFWS3JwcWcwOG4y?=
 =?utf-8?B?QlJxeCtvZmVxZ1pYWjU2K2wwM1BxanJQUVRnUXZBL3BNVFp0cGVxWnlWTWEw?=
 =?utf-8?B?YnhRUGR0TEtDK3l1aXBjcFBuZlNma1NaOXNBanZSSkYyeEpvVXlTdnlZenhG?=
 =?utf-8?B?QzNudUs5M1l0ZjE0YmdRWkUzUHZJTE14QzlSZ3FUYVlCWXhnemR6d0pFOGVS?=
 =?utf-8?B?Zno0VUV6dDNZeENxWVA3a1lhN3hzNEJjQUtHZ2Y2NUV0ZzJnRjRHSmJyeER1?=
 =?utf-8?B?eVNGdVVsWk5GR0pWVVpYR0Nad3pLOHRFQ3pjZTV1NDJVcXVQbGFsUkNRYzFZ?=
 =?utf-8?B?Rk92QXUxaUp1N2hwTkZVbGV3eloyZFl5R0pnOS92b0p3Myt2c3ZlZldQdENK?=
 =?utf-8?B?QW5XbEVIQTNNV3NaS2h3NVZzUWd1MFZvRFNUVVNjVlFJN0RVVyt3VEQxTHVM?=
 =?utf-8?B?MDBjR3NjbmtCdHlweG9ITks3cXVJemEzanpFS0I2WVBYc1I5NmJoYWRQTWwy?=
 =?utf-8?B?M0JwanpMai8wY1ZKSVNLdG9wUFhadVh6YVVFQTZ1ckhuQzlQeGFkK2dCelR5?=
 =?utf-8?B?V3dGd0JQYzNOMFNBeFBtQjlKVFF5NWpsTExwTE95NHdNSExvcDljYTJxOGJp?=
 =?utf-8?B?Z3JmMExpNFg5WTgzYi9YTjMyNFo5QTNSbzBIUnNrQUVYazlReTNla083aVdi?=
 =?utf-8?B?MW9ZU3hhSzZ3NFQ3R1puTEorRW9seGcyKzdkSGYzRmlWTHA5bElaVWp3OHBk?=
 =?utf-8?B?QmlBUjZpZFpuYjJEMUFvR0FKQm1ZVFA0d3VlYy9RMXdzMWw3eklnRENLRkFH?=
 =?utf-8?B?L2FXSE1RMzdMYUQ4eEp5ZEwzNFd3cjhnTzZWWDZuTkRXZkYzc3F4dk1IaDdF?=
 =?utf-8?B?RU90Z2V5Z2FqVUNiZjkxOHYvWExQMlRyTm5UK1AyakVvLys0dzRzUmZDdVBQ?=
 =?utf-8?B?SDc4czgrOGdLYkVaSEZyNk5nTGRsZHZZSDlkYmI3M2NpQlh2NUNtc0s0SHR6?=
 =?utf-8?B?ZStnYnFnajB5V2hOVDJ1WTFHYzJJZk9pSWNna1FHWENERlNZdUtVMWw4dTNZ?=
 =?utf-8?B?TElrTzJRN2g4WU5VMlJtOEVnNHJuRklCZTh0L0E2OVljYzd6LzFPTkh0czhC?=
 =?utf-8?B?RldFbDBqNklXbmhFRytuRnQvZ2VFOTRlUGYrdFNFU2prUVlFdW5GTktUMXhF?=
 =?utf-8?B?OTlZRll1VlBpVjdVclVSQUFWNVI4NjJIVDJZaDFNLzFVcmx3MWRqOEpoTXVy?=
 =?utf-8?B?MDVMSDRCa0xnbXV2UVVldVBNblZRMzFOSHdzcy9HNHYxalhLeGl4QUN3dUs1?=
 =?utf-8?B?MVlpMUhDU2VNME0yWDhYenYyL1lDTUJrUlYyNkxGVkxzVGNtSTlPMnRpVTZw?=
 =?utf-8?B?T01jcW9DV2pNcXQzUDFUb0YvT3o3UXB6SXM0QlRURFl2Skx5MHd3SGY0Wnk4?=
 =?utf-8?B?OWFKL1AzN0UrYXQ2Z1BXUlk4aFNDT1JQbkpaeld6RTdNZkp4NHc2VkdDVEsw?=
 =?utf-8?B?TE9PVitGSlZQL3VROXVlUnVUR3hyWXZaQXFPYXUzM2RTSGsxbzdZUmxra2hx?=
 =?utf-8?B?ZkdMWG5jWU4ySlpTNVE0RDIza1N4UFRrOFBuais5ZktsenVTZlVGZGxiWWlw?=
 =?utf-8?B?TTJRSFAzajd5TzYxUHUvd25KbSthTEx1cTBsWVRSbWpzM3A5emVSMFdGZkpp?=
 =?utf-8?B?ajFtTE1mWmlTcWdpa0ZNNlBGV2hQVEhNNXczaG15TjZQbWcyR2NHbDA5bTBJ?=
 =?utf-8?B?WXlsam1sME40RDVJUjNnWUc2T3IwS1dFU2pKME8wUCtmWEFXY1J5NDJueFJq?=
 =?utf-8?B?eGo4cUx0SUErcWpTN1F4aVBma2RyMjhDRytKeEFGcUw2d042YW1BWThIc1dl?=
 =?utf-8?B?and4a1RYc1ZBZGFKQ2dvbnZIeGxKdDhrRGUyOFZyanJ5dVFBUVpXZGpaaTVi?=
 =?utf-8?B?Zld1dnJja0IwOGlFeWk1SSszYWJlQkppZVZKUGFDZ1FjMjFuK2F3a09LcmxP?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9995999d-62f1-4229-b7ee-08db05369b14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:00:29.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSxfc0ECkoFQ6DckG0jx2/LoIgjxromvxZxvPJ7SKvAfXdXFN7eqMaZUoQWVpftdMgEH6ZzTGlqgdmLCfPugAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 16:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10571

On 02.02.23 16:11, Florian Bezdeka wrote:
> On Thu, 2023-02-02 at 16:08 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This will add prelimitary support for the debian 12 aka bookworm.
> 
> Following the Isar mailing list I will expect some trouble now. The apt
> keys fpr bookworm part of Isar expired... Fixes are available but would
> force isar-cip-core to migrate to bitbake 2.0.
> 
> Let's wait for some build and test results and see.

And there might be also a fix for the firmware topic coming, see Felix'
patch. Then we can keep the hihope.

Jan

> 
> Best regards,
> Florian
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>  - Adjusted blank lines
>>  - Change Submit subject from "Add bookworm" to "Enable Images based on Debian 12 (bookworm)"
>>  - Replaced "+=" with "=" if append was used
>>  - drop pinned kernel for qemu-amd64 secureboot
>>  - drop Hihope build as firmware-ti-connectivity is not available for bookworm
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


