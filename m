Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F309C47DB3
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 18:21:01 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.42])
 by mx.groups.io with SMTP id smtpd.web11.408.1705602054703001272
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 10:20:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lWb3Cqoe;
 spf=pass (domain: siemens.com, ip: 40.107.6.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXZC+xvxOYNGRoXoV1iCas5YFi9cFKF01M4NyQABwtKqOGsqO9myOlZmhNdD332d+C1SS9GxB34gmQeeUEw2bAOGp+WZX+dCASioXBGivw5LXg85GjddC1EPA9ZeSzBffZjABPc5Ip24a6JkGuUrrzyAIX3RTHkA/u5biYFVE/izauSQzOyVbaYM/aOoIvzXk/L/84RTuStHTv+YEvn13htN0qJoyWBbNqNLkK+ZpGY6DUhTeC+wVliRbv9EXRgXuRQ3YhJQTumhN1a1vkiC8UmstkvDb90Xh4qGu1Y2eNWMUk5Xgnnq+A8envyhLP4RCRDh8t3Aj9Hr1OApIqbEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GltfQDSa7GuYt0UEtg5Qdr/argwandY1MPiljSlPlmk=;
 b=i+kt6G7PbIvqkDUmTxCI5gRGk9WzQLaY9jRTw5U2olRKcBnd+wENfhuma1swXmES6Tkwhax75oK2rRGc/SmkDrXsA/W4VzwruPzUNZFLWyOquspOHVx/W4EaLb+cSddPGaQWmRFa2UKCoiBsKHc33DWTO4qfICtqVJjP23ORzLPivWPly5eSuK+36yF9/1UwCrGT8oSkvJEon8Vd2PTBaZ+PaR4ziyTGPermyrje62RWAtXmicItnrnH2UbKlKqtsqbH0YH4d9LH39h0/SaXUzrtl3Cj0QJ4GLnGYSjCg2s4IKPpAwzjm489tmEyXqB99eIpNijpBybGii4CSa7CyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GltfQDSa7GuYt0UEtg5Qdr/argwandY1MPiljSlPlmk=;
 b=lWb3CqoeHf3Hi13ep8/s7ONldAXvsyC8sdQYJfVOhX7k85+vQPHtw9ruFrJameUZe88L1fJcN8TSPa8yfFfhDDUu0OB239ujBx7FZ8ZCTUCdl8PfR8nmc8uT2B4GvLCOVxtzDehyap2oPqlSpsLQ9JqbtrXo9hUioBC57eDN0odF0uXJLzEPHFbB8OaENqtAYr1KkK51bAa/9AZCKHieT5H0+w7OIaUvgsgEy8lYN/gC0RWAcdMo3TJiQV5oZcgp1F82+R+g3XblMrg8vomaX+YblRTpHJYCMiFstvnyA7AqilqdXtfSmMK8D7PudrSOnHtujpxYzIZH88UmcQpmXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 18:20:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 18:20:52 +0000
Message-ID: <8f51796d-1f88-4572-bbb6-c31efffa3003@siemens.com>
Date: Thu, 18 Jan 2024 19:20:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Generate CVE-reports only with manual
 trigger
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7f9b64-8f59-40ce-f481-08dc1852341d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	beh/9J98kOZTbkkHD2Gul6AQyNPzil7Clu6KA6ehlSsPc/Kdscrf8ChkN5Z3Qm7N0Hw1HPyp+cR2SYHwIONWzU5HJZzAXUrqrVXcMfqfh15XtDQzempX/cygr1dXBZRLO/VFJEBMqiENTMTSmQZ7pZVZO57ynhEM5RDcKaYoCt2srQXKPSJbOOQWHzdDbIZLLMeuFVrmRfzcc2J7SV9cXqfcUl8Rf3tzkwrdPEq9fYjngb5KjAOUootxFCsQRFnywfNlRnV794/fDCLiZzaPlSeGIiEXGVXCpdZgsv+BdLRyqv75xs8R4Sewcct9PJhEzAIT8Z4pQmsx4BNNP5fCQPFJPiDjn82H64naf5kMuRw28KOewpiN+THyWD2xvBN9z5QIEZakHTo4S9bwN98yi1eromG9qwAJB9EOGenKjOMIgIMJb7AzUUx3HrsDjRHxGSxnidSWLFyaNpCClZD5+QUgXvJYpyFvfMbKxZ9DbrMvfz08WxSFp4rHSPGw/LjelEPx5AQidnxqCYfxXDMUHArlbpcNs/tSBNZRphegm9bg8AJVB1Qm/x/66dTNXAOm/PKMP5agxk42HMCoKihXJ9DZ4fyh4xkoocpFVFWMidME77j/wHyZriXC6aqtCIXuX2womh3lkAOtRYGkUtpm2Q9BpF475hA+lqK+BXxuGiTw8TCx6zcdCjLZJY5sYvsp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(26005)(6512007)(53546011)(6506007)(2616005)(38100700002)(44832011)(4326008)(5660300002)(8676002)(8936002)(6486002)(41300700001)(2906002)(478600001)(966005)(66476007)(66556008)(66946007)(316002)(86362001)(36756003)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFZpbWxIT0pwM2hxbDVIbEw1QXloWnQvZEJua2tyaHZJQXJ6TUliVHh0Zzdv?=
 =?utf-8?B?cHBzWi9QV3ZXT0l3UGM2QnlBTTFDSVRhK2F6b05UOFpDOU1ycWlhYU01V0ow?=
 =?utf-8?B?elAxVjhHemQ0aWdQeWxCWkhsMW5DYjk1THMrbHJoMVVYSkxTc2pRUmpRYTJn?=
 =?utf-8?B?ODF0VEtHN3hkb2Q1aGNJb2tUR1VWYkN4Nml0N2huMjljbEhlNXRGWC8waW5p?=
 =?utf-8?B?UkNOM1MrOEJ4OWhHbDl1Ti9qbld2Qmw3cVFYaGhnT3hTbWMxaVVzdytWVEJp?=
 =?utf-8?B?czVVZ0Z1cG5lVzRoa2c0SGwzNXQ5c0hJVlJpTnNMWlJnd1JzVHhDTkZHVHdh?=
 =?utf-8?B?cGVaKzdzNU4zaXZaRmVTMTZJRHJzU0xuOWFwTVZ1djQ1WEJId0daM0JGVzJM?=
 =?utf-8?B?eWEzTFlWU3ZGWWNGakNDUDFBNW5oWjhqMGIzcVRVdDhXUlBsYkMzc21jK0JH?=
 =?utf-8?B?VHl4eTgvYS9oT1l0ekU3bW5WOEdVR1ROdzV3cXBzTmdqK1JTOFYxZUhKRkcy?=
 =?utf-8?B?dEtaMnRBdWw5ZmJQdEtRaGZWQVJzVDVOMGd1aEVGR3d6VE5Jd1VHbVU4MFFu?=
 =?utf-8?B?Rlc2eDhPblY2MGhiSXdGOGNoaGNpZk1Va1A1Q3JReXdOQ3R2d2Juc1M2a0RX?=
 =?utf-8?B?Sm5ic29vTC9nb1RQWlBhSS9PTWhQa1AwZzZqdXQvdkMrZ3hIUjNNaUtyaHVl?=
 =?utf-8?B?MDBxWDh4ZUJvM3AwVDhRWk9yeGl6bkhmUW00dEd0NXY4ZlRIbi9wM0ZTSFl1?=
 =?utf-8?B?d2RSNHFkN295WW44S0R1UEM1cXJ2aDRQVEVrdEFXNklBajdRbGNMeHpvOVZJ?=
 =?utf-8?B?YU5ocUl2TW9pc25BNzNlRVA4VDhMZEdRY2daME1OTjlLK0thYm1RY2pUTXhQ?=
 =?utf-8?B?cjNzY0tGdGJobEgzYlRyT0RvOWsvc1JBNmJueHFJd0NaUms5WnZibVJaaXQ0?=
 =?utf-8?B?QTBtd2pVWjVEMEttdUtzK0sxdE54Um10aDNtdGhEZ3ZwQmJjTm9lL2RIdWF5?=
 =?utf-8?B?NjFjUVZlZTJRZUIzS1IzK0JhdFh0ZHdIZm8wSXIrOUpRTGhZemFicEJ1dXc2?=
 =?utf-8?B?bmtUYkN6U2t4MnU2amptSkgyenRrWHJpL00xd0l2UThSeVNKNDNIVG5yVGNk?=
 =?utf-8?B?bVdKV1VTVUpkcWM4enM4R3RibTdZd2dEMkRwMzRjNjJEdG9IcFdqSlJZVGNz?=
 =?utf-8?B?RFpCUFBkbzIvenVCWncwNUJ3NlJONXZHOXEwakRFK0dCT0xHUjFPR3UwdWFD?=
 =?utf-8?B?T3lJYkJiazdjUW5uZ1FLOG04RjR3a2tIbnpZSG5NVGthcmsydkZBcEg3aUw5?=
 =?utf-8?B?K0FIQW9uOFNPczczTTllbzNLSStMNjhDakhWUUNNZHk5R09zTm5ISDBpYXd1?=
 =?utf-8?B?VWliMmVNdTk2b1kwb0x3Y082ZmFKSTJiNmdsV1REdUs3UzA3QXZmVmp0cjV5?=
 =?utf-8?B?RzNQTXJEYlpuM2RIRVJmZ0R1WXNEN01aSW11YlZEZFk0b2krTEVrSEd1a2VP?=
 =?utf-8?B?TjBITXJGL2R0YlpzaDZFVWlOWnd6elFGemJ5OXdXQnhhdDJVV1BsOGRobFAx?=
 =?utf-8?B?a3RaVnVqR05NZVZhNExmYW1wT29yTTJ6Wmg1QklJanAzbGRFVC9KcnFqN01F?=
 =?utf-8?B?c0JaTzBjd2dCV1JYaGlNSFk5UUQ1Y21lQUNRL2V0OGYzcGFUaUJ6YzNrc2I4?=
 =?utf-8?B?Z0FrUFQ1eGFBUC9Qb2d5UmUvV08rRitpOC91MGNsN0txTFBuUFFtMmh2dFBE?=
 =?utf-8?B?bzlaNVRQakRVK2dDZklWckEwcWZaR1d0TEU4eU9LbVZQY0oxaUFjdGdHL3hl?=
 =?utf-8?B?aUxiOWUyN0JSK1ZTQk5ncnpOa1RXWGExSlFpSUtYeFpQK1ZMdkVrQ2RiakdH?=
 =?utf-8?B?T3lScUgwdThjeEtMUkNnVDM2bUdXNUZmQjUrK0YvR2NTaTV1bDBzMDZPZm1N?=
 =?utf-8?B?WkR0M2FEaDJadzk4dFdKT1czM2RaVjdXU1VmT09EU0dwcVpFeC9zd08wU3VS?=
 =?utf-8?B?UUJVUHprb05ncUVlVVZ1cWpwMUpDemIyMzQxWEtiU2x5RDdkMFQxbVNCYXRk?=
 =?utf-8?B?eWJJNUt0YjhzWWc3ZlhLQURIVkluZ3VXVXlvS2Fid0dVbXZqMW5takNjeUR3?=
 =?utf-8?B?aGErRHBwM0ZwVGpPNkVFL0hXWWdyS1BuL3huMXcvL1pMbUtjbEJvOWtDeWQ0?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7f9b64-8f59-40ce-f481-08dc1852341d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 18:20:52.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NVoJtFNlgUYI74at4vSRqSh6icidbKlkTX9u64ROUWjTbw4g1VAV/s78zfuJnFYJ1vMefu60rhToPU9XYT2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 18:21:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14406

On 18.01.24 18:59, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> This series of patches enables generation of CVE-reports from a latest copy of
> dpkg-status files stored in CIP project's s3 bucket only when they are manually
> started in the pipeline.
> 
> The cve-checker.py script in debian-cve-checker repository [1] is used to generate
> the CVE-reports from the dpkg-status of repsective targets.
> 
> [1] https://gitlab.com/cip-playground/debian-cve-checker
> 
> Sai Sathujoda (3):
>   scripts/run-cve-checks.sh: Add script to generate CVE report
>   scripts/deploy-cip-core.sh: Upload dpkg-status files to aws s3 bucket
>   .gitlab-ci.yml: Run cve-checks job only when it is manually triggered
>     in the pipeline
> 
>  .gitlab-ci.yml             | 14 +++++++++++++
>  scripts/deploy-cip-core.sh | 12 ++++++++++++
>  scripts/run-cve-checks.sh  | 40 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100755 scripts/run-cve-checks.sh
> 

Thanks, applied - with warning fixes. Please check next branch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


