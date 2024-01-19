Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52417C4725D
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 16:25:08 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.85])
 by mx.groups.io with SMTP id smtpd.web11.26889.1705681501958119216
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 08:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=euv1e7R9;
 spf=pass (domain: siemens.com, ip: 40.107.104.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBu2NQ8LSvCJObjbOomHM6PxtLUgvZbaWrn352T2briagC7Dc8AnWpPs7eDy+byVhzX8srZsgu03LEb+hkCd0VzrBX7hKNKW0CzuF+/XK9MLjWf9jhLcXjZb0Vph2RWhdcVQXSUlnzg8gIqUTcEKR155Cje5so3hakzbbT7fbAqrsbhorqshwNa6l0+L1h2JVld8YiXBUTYyKCVfwBkuOqxTq1vLexpya82TbWQaq9RyCzhLyqkYDM2n9NMgZRoggK4dPv83FBdbxc7+RBRLilImkUDTjSXdrHzHp+szItEIE5TzxvYdBSrS3Vs47k5vRvb8izY2w7vbDsJqKnzpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R51BoJ4ct5I/T29VHrXKrSVqzk7/pzPv8m5zrp/vtDk=;
 b=YM/fZbNnpBjHWaXGz92SoxwCf1xmBTj8hIu5pxZcJReEDGZcsrwxxTin5EtB6bV7KCROJY9wzTxkkJFhfhIzXJzbjZsYlC8wCOTxU+gFOIX9q1qvWkOcBRJjH5e/px+CZ8kjDqVzK51y0TFOn0upCiV49W+HcwrWOFnoFrTE24O+rmdTxB/xg4q2miAddhbo0giamxuF3VorUAo4eBKQfcHBbkKR6wS/2JfBlIO0fp0Ucrxr0h50/4ObQa1SUFXGw5m+zhLPW103JIHv8fpB5ixG4sZV/RkvY+XShhzMLAW0VK59GYZgmn/pZtzC7UdUqnaCjc9xbgR4/31IH+Etjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R51BoJ4ct5I/T29VHrXKrSVqzk7/pzPv8m5zrp/vtDk=;
 b=euv1e7R9TKMSIabbBMI395mWF0G0EpjKR2c6WuYCXsD+ZTvi7E74me1LBBIzSHXaG2RY0sDIYu9mECSrf2LnLIcYaQifC07Wqcw/Mod7ItsOowWENrbETkXZIr7QFlqFA3hDp43Siwa43JG5RwA3W1ILfEh81OjnzGm7p1JaOtq1M3Bn/YFkYZJveiO7YHxWKugGUdaM4FTADq/np+M5j8v5Qxc8U37/ptXhRpCdZysiJVHfbkZRQufY8PFVlmNldDsVHnDd9m8XH1i83UwhXkBAKFOiuEy87qSW0ofpFjO1UFPDGUSUsAYMBoplPlUBstgWJmaIK1EuZKafOevHvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 16:24:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:24:58 +0000
Message-ID: <6cba0c0b-0e8f-4a78-8acd-580c6e04b9cb@siemens.com>
Date: Fri, 19 Jan 2024 17:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ci: Reduce build runs
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <4c3c0db9-d5c5-46d9-b45b-edcd5093bc67@siemens.com>
In-Reply-To: <4c3c0db9-d5c5-46d9-b45b-edcd5093bc67@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e019b1-8f94-455e-ac91-08dc190b2e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lZCELkxt1FVWwv2NvWkmDmDsn7r48frLduz14nk8JvIbV6mJeKmQclqncHA6fkqnoZwSvM/zXoja5Ue44CP6yOyP9CqQCY7etzaRpqKr4JqGo/Q4sMPqUloPVJ018eYORF8H1UU3H4BnEaH/kgNHISP4P8UTj7GVNEaJakQ9UnmrVcNQXyTLRyySYznxkYCvBTjVfwwpDNAqP3r/OrPJPSpJKkWuF4PkwXpEJ5zGpRK1ILmVP9aRtnKpXeDYjXtx7h+Yt90xO1uJofeEjQuLh+3i1qpmV2C2VA6NC1SCV/rpUIWozfYGRD3EPXddi2IUMkYVIcgjTwWhF0XklTlKvGXtGuL/TwCeTjx4OSVtIKY2VgTF4YdtOE7rniKGNRKI1W/3qynDy4qlw93EbbQYRrszlbSvyHuspu1pimGU3cGINynnPg9WNMLhISR1jjcIFOsauLgErOW+OfHd/x51/XesoFzgf1ByodfaLBrdyCk60fU4InTC75tW2zpehfqEi2LUGjhIPWe7TUaTgOfj6WKL+wtBqX0rQKmWmED1IoogHnvuf6537lf5WrNDvbq1tJm9+JwgivYQ02fttJ3wXlsGjBza2k6NDvvWwrLP2QrUdWfTkXyAY1lbkUg71OCjKZg1MiqROItu9QCwfn+VUA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(36756003)(41300700001)(82960400001)(44832011)(38100700002)(2906002)(26005)(31696002)(86362001)(8676002)(8936002)(6512007)(66556008)(53546011)(478600001)(6486002)(66476007)(6506007)(6916009)(316002)(2616005)(83380400001)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Qit3TTRiM3ZIci9mN1hWcW1Cc1U1Vm5KbHgzSHZpVUJXdFJpelVXcTBqL1R6?=
 =?utf-8?B?UGlBSkdDWE83OEwzcFhyK1czVzl1TkdSVU5jdUF4UW54cTMvZDBDSVNuSmhZ?=
 =?utf-8?B?d0xuODFrNUpjc0ZNQUNrWC84Y21tbnFSMU1MRHVGb1c5T1dSYUVGY09rajNo?=
 =?utf-8?B?R3dUUzUzSWNqVDVVdE83djZpZlZvQzAvcVNUUHZBVEw0T2prZ2RFbW1LWkpi?=
 =?utf-8?B?TW5nWklOdENWbUtMaHVnR0xwazdJcnEzWUdKY1JXMzYwcW1LTkJJenFmSzcr?=
 =?utf-8?B?cUpuY29YZHZYZFZBU2lFeTZpV1F4b0FZWGJtUDg0d3RaZVplOWl6aWQwellH?=
 =?utf-8?B?L1k4RitGVXRsMkd5NlkzTVFpMnpZOUtLY2RFSXVQRVo1UFdyY1NFQTFVa0VC?=
 =?utf-8?B?QzFrWDJ4K1J6K25zQUh1dXM2Q0daWXJZb3FGeDhXanNGU3pYaUlrUkhTeE1E?=
 =?utf-8?B?cExhQ3Y3Nm9rdUJsQmNNN3NXNnRkcUlxdlZMMk84QlRDRDVUWXFVMzFWOXhT?=
 =?utf-8?B?T3dYVWxSaWRDWWRTOGtiNTlYemNrTytWUGFuN1ErK24wZWNYbVdiRS9SSkR5?=
 =?utf-8?B?Q2lleDBITUJ4eU0xMC8vVTlmcW9OL1c4UFZITXRKVHhpcTZUVVBnTnhyb0Fv?=
 =?utf-8?B?YWVxa24yT3Q5Nlp5a01NbW5PSDhBeENnM1UvOGRUd1JUekVzRDFRUHlkRVJq?=
 =?utf-8?B?eEdHNDB0bEtZR2ppWkVWN0U4ZHUyOWJTa3BnVm1xRUkrbWVGSFlOMVo4Q3gw?=
 =?utf-8?B?NER1S1JGM2RRL01zd3JxSCtQZ2NDditGT2pFTGZZQ2tpZitUL3JodGNuUVh3?=
 =?utf-8?B?d2NLRU1KdGczVDlyc1dBbDh4MDJCT011SXN4V0VlUmd1YzBVSVlyMzRkb1lF?=
 =?utf-8?B?VlorVmU0cWh0by9Wa0l0em4rOVhYSlgwRzV5ZlVhWVNybnlISGNCbUpIaXRB?=
 =?utf-8?B?VGJGTFJaQUhSWHRzVWJrbHdYZThSTDBpM0FnSkR5NnNaTWJGREF3RWg4dGVY?=
 =?utf-8?B?MXBraTlWTGJHL1BHb1NUR3lMdDY3VHI5N2hTTkJvM0NaYVZjTWwxMHNVVVRv?=
 =?utf-8?B?eWtaRS9PSVlZQzUxK0lXS2xjMVU5Kyt4d2QxL3NBWHNDRmFSa0xqaDYwSUNj?=
 =?utf-8?B?NUJBVi9zREFsaVlzRlRGdWNHQUM1TjFDUjAxQTZieDJjNDIzeCttLzZFMDhF?=
 =?utf-8?B?L1pQVkNUR0JGdnB3bi9rZVozWHdOR0U3MDJBVWh5QU44UXhwVFdzeVo2bTBS?=
 =?utf-8?B?R0ljNlFJellDMnNmd3hESzc1NHUzOVdyeTh5QTRhVEpyUThkQXZHRVZnRXJM?=
 =?utf-8?B?bXRVb2lTT3F5NnBLQXljcHIyZVcybW5JVXpZSVh3TExhWFkwYUJ5elU3TnRq?=
 =?utf-8?B?NTFxTGlmVFFTei9sOUFhaW90cEZ5UWpjcldwVUNLdm5ySmtObk45RERQeXhI?=
 =?utf-8?B?eE01SGpLblYvVVlmNitmWTczMGtqOFRYZlVqMityZlBVQkROUDdmSGcwVXR6?=
 =?utf-8?B?NzJCbTcxU2V3N2ZWVHE4ZzRMckhNSm5BeVBYTC9BRURFWWppaDhBQW9ORUdi?=
 =?utf-8?B?YzVLYVFZd1dLbUZrNng0TXh1YWZSaFZqK2ZPcWswc3k0b3FZMk1VUmppTjlN?=
 =?utf-8?B?UXZldXN3U1cvMTVKa1dIOUczTWpPS3VKbCtOWER4VG1uWTcwOE5IZ003YzVu?=
 =?utf-8?B?ZnB2NFV3RWlnTmZ3L21NQVdVUCtkOXZWVkZNS3gwUHB3Zm9ucWFBWUh2bWR1?=
 =?utf-8?B?SDFUeVlGYlgrNG5ub1A1c3g3MUJ0bTNoS1BRYXZWY3M3QkRPY21saUJOK3Az?=
 =?utf-8?B?VXV5SFlxRFhPTjREZ0F6K1hqdE9wMC8vSXhzV2h6M0lPbi9EZm9NMHFINGRR?=
 =?utf-8?B?QWV6NEk0T3FHL2lXajZrQmRYVEl6QmpRU0pRRVBPQlRaK0g5QktDWXZuNEJ6?=
 =?utf-8?B?NkhkUWp1ZHd5MCthN1V5dWg2TjlZVWdhYkZZbDJaaEwzRHQ1VngvYkQvYTFJ?=
 =?utf-8?B?WUdLYkFIWEdWajllWGs3MGRSM2RUdDJoa3o3azFZMDBqY0diTm9ranQyM2pq?=
 =?utf-8?B?QkNLVFBudEpNRGVUdWNnMzNOaDBqOGQ4bmhQcVFrNkpldldPaExYRU5DZTlm?=
 =?utf-8?B?bmRIS2dJb1BVRnkyTjg3MWlVUCtFNUVvaGN2VXhLSzdkQy9VYzROMUdQQ1BD?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e019b1-8f94-455e-ac91-08dc190b2e12
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:24:58.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFd3owClr34ECEjCPrdBFWJHKgTtlpxwFU1ReOJqJk9tgcZud6ZYldBn1Zui4gFF3kXTkO2pRrCotzmuBFd3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7918
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 16:25:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14429

On 18.01.24 19:57, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Under the assumption that ever revision in master and every tagged
> revision has been covered by a run in next before, exclude those two
> cases from build runs.
> 
> The exclusion of scheduled runs is just translated to rules:.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ba2cdb9d..4f87ec37 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -43,8 +43,12 @@ default:
>  
>  .build_base:
>    stage: build
> -  except:
> -    - schedules
> +  rules:
> +    - if: $CI_COMMIT_BRANCH != "master"
> +    - if: $CI_COMMIT_TAG
> +      when: never
> +    - if: $CI_PIPELINE_SOURCE == "schedule"
> +      when: never
>    tags:
>      - large
>    variables:

This rule set is not yet fully working: CI is building the v1.3-rc1 tag
now. But my push to master was not built. If someone spots the mistake,
please let me know or send a path.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


