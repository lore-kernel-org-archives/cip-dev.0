Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B8CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 06:15:38 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.54])
 by mx.groups.io with SMTP id smtpd.web10.33043.1756966533927498257
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 23:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x1691Lw0;
 spf=pass (domain: siemens.com, ip: 52.101.83.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWqezG9O5TzOc0AI42gPBUBV/Plq6vPQlkCM/zVMqg+pG91SHwFKv3eP7QaBGXidl8nP0gdEwF05wnFYBGiNmDvUVHy4B2QnEiGFeJ3AuIA91wK+MjPmQtwMJdt5y++0DMBymFAaUhTso5IH79x6rFFLvpZiM1dWe4oxO4tU3v1vQwsWu0Yyt8oinTaCn2iomAr0tdcUpQxV8oKzrFfnh9Gb6jgxVLKP6KAXyDNejlhwhMwH1J8MoaWGe0X2nLfjvogHdy7yNhhVpJ5uY1AFP75klzXfJlLwjmoCT7Vq8if4RzZNLBBlmnlsyxUD3sUHFjsxdXFggvAtCQvQCbvVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VADGM+tXY9HT7AKLhWyArRY1hyhXmwRLaQU+Uobvo0M=;
 b=OsHzgH1hL9sXa0o8G69ns86+aHt6eP4MEMBXXzKBicjed3m7Ak39US0Q6pldrwTkasjrEdgFzHHuWETw5Tu1+71myoynSt8mzpGY88JqLWFv3ScD/u6l6KnbzFxYIUEOsNTx2Vn89zmVcWUwTWNtCjDOq+xP81qZc+bS0MehFKXE9BmGst+jb0VWwgqZ7IX1GtHaMTVQO+Joc626wYbKhjOYK64sivarIvtW0r2iJXCjDwChueAhvwzVd0JJ1rel82FY1l0YmNzUO9iQIt8P9ykuVogp4ODctiXPbMHJH6GDNcwNZynYqPCKg2MJsyjkmh57iBw7jnxRAaIYPV0d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VADGM+tXY9HT7AKLhWyArRY1hyhXmwRLaQU+Uobvo0M=;
 b=x1691Lw0W5Nlk0lykFmYmKcmAm11gDXCwe4tPxgpyrHGfWrmxU/TtvrlPdBPzX6EX3BGRnLGeb9Exd+cLMs0ayaKmFDGq9LA58al2UrSRyOfgXYs19SIvkFkAp9EJXMvw6FZPHweBHfsfgv8ia2Q1ZgTTbhYuL51q8yiHrGS3/4Xevpd89Y3cxyykWhcRW0y2mFnC+87wkI9omWNU1anYgcFfscRnwpx1/zuUPN0kMB+JOb1zfl9CXGj4MvYsSOHAQxpLHTzesVzK8C3JkWPNnivGmoNHQ0rTCz/+BotvtCRn0VeMF29idLEQWxci+/m4e5krFPNpmxPjcnBSmG7qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:15:28 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:15:28 +0000
Message-ID: <be1f56cb-eb04-4dd5-8566-eeb458b1b46c@siemens.com>
Date: Thu, 4 Sep 2025 08:15:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3706:EE_
X-MS-Office365-Filtering-Correlation-Id: 785eb09b-3095-47fb-58fb-08ddeb7a719a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDR1NTJrdDhjV3VJWFBaUTJLMm05OUdjcE9FTis2eTlvVlVubmN4TWxNWWRx?=
 =?utf-8?B?N2lmeWxKcXpDZ0hqOXVLbnBuK1dRbUZJa1MrVkJmUURUcHNVOVpEYXlpRkps?=
 =?utf-8?B?dFZ4MFVYQ2tuMVJNcHYwUUhEVmFWYVNva0xKVXVyWGJodEJSYVZBczI2UHhD?=
 =?utf-8?B?a2cwenEvRU5lMzE2dDV4aVQ1Rk5neWxZSnhMYWttZlhTdDhKTE9DU01GZ0Qx?=
 =?utf-8?B?bjlOWkJwL0lwdUxUT2xFYzNLVEZIZjdSelRUZmtOYXdnaVdJNHpZMFRFRVE5?=
 =?utf-8?B?MmNyak1VNkloRitieU1kejlVaGYrZ1JZRUZjYTFBSitQYkhOb0JWTHlkMitC?=
 =?utf-8?B?UHp1aUY5WG8rZWEzYy9INjhpdzNmM3JQU0g0aVV5VlByL2IyeWplT09YKzQv?=
 =?utf-8?B?Z2lGeHVtZkJnUVdUc1Z1WlY5SEM1czRBVU5SL25zRllRa3A3Ymg1VzdHdFd3?=
 =?utf-8?B?eHFEYk1FK0d0V0d5UlJFNmo0cFJCc0hlcGdyMkZ6ZTUwN0lWUmRwdDhta1hj?=
 =?utf-8?B?akV5L2graXFCb3UzZUFOajQ0V3llK0NvZ2hJbWEvSmFNSlkwRU5DK0NDSGQx?=
 =?utf-8?B?a3hwRVlpTHEyaVJQbm1Eb1czVzQ2eDNZcnh3OFJsVTFJY3dZK0trSjdwSnVI?=
 =?utf-8?B?V1FrSjRxOVJURlpSYkZVUzJjTlFLdlo2K3IydUVndzFxbGg0c0JaUktNZ2dD?=
 =?utf-8?B?RVA3TTdJMnRxVVdtQWVHQmdua2NXbURKeU9sbTF5WjZGeWRPY2c1VWNZemtZ?=
 =?utf-8?B?aGM1YXJYKytyT0dnTzYvTnpJaHp0eVpOSHNNMTYxcUNzNm1LTWJzRXRCWU16?=
 =?utf-8?B?OGhDcWFVVWZ1NU1kcUlFK2x1Tk9FOEk5cVNjdGhWTk5SVS92dGdUSWFLQm5a?=
 =?utf-8?B?aFlkQlplWTF1RkRhM01pY1k4NzFpMTE4S3JVSjJ1OW1Ya2ZBOXRpU2lEK1ov?=
 =?utf-8?B?MHc0c3FYOTNRMGJycDQrS3JFeFFsZjk0Z1J1UWtWcW1jaHpIMktldkJqNFow?=
 =?utf-8?B?TEN5UUkzRlljaFJTSi85WUpoMUwwNXk4UmZSVkxoMHVmMEl2TmllOHc0cHFC?=
 =?utf-8?B?dmtaU0lHZ0ZnWmo1czR4a0dqSWVOZEI1YU1kSW5uMlFnMWI2WjM2a1dNcU9x?=
 =?utf-8?B?Rm0zRTFvOWluUUZEUEpWQVMyaUV2Q0Z5aWh5THQ4MnMrdERaWFlIWW14c1dl?=
 =?utf-8?B?SWh2M3hKdHdQcUR4cjVSUUNVaXF5ZUpJREx2T0hXakRYL05EbWE5R2k4V2Vl?=
 =?utf-8?B?d050V0VRdGxaTlhxcHFIRWhYLy9DRTBBRnlLVVo3ekJMdmNldDJyclg0bEI0?=
 =?utf-8?B?T1RJMjNzc2srelMrMis5dzZqTlZTYjdRQndhaVVST0NyekYyRXluQkltN084?=
 =?utf-8?B?WWNIR09OMkZEUkNBQkVRNW5Bb05qaXY0Mmc1bksrMmI2Zlpzb1NVQzJFMHc2?=
 =?utf-8?B?TFpLNFVlVVJxR3V6VVlUZDA3clF6SVlza25LemJYN3RvTDl3M0dWdlNCcFFZ?=
 =?utf-8?B?MEd6VE9WaUpuVjdneDJpOE5rMHQwK0FQczhsTXZsSE9sOFc3YkN0Z2IvK1pk?=
 =?utf-8?B?ZGUxckRzS1RDemJGUzFndmc3R3lhUDE2dWJBT3VXUHVSOWNpMmExV3NBRE0r?=
 =?utf-8?B?d2hJTGNMZU1YLzNOKzI5L0hCcC9mblI3TGFvamdhYUtBWFRJK0wyQ0dGUThn?=
 =?utf-8?B?RmkvbjRYL05EeU1XRGNuOTFiWmlyZ2NTVVpJOWVmZ3F4OG9OZTdIRjFIZ05V?=
 =?utf-8?B?QmlwMzB1eC9MM3pwSk5RWlhmZlRJWU5oKzN6RDVOSEZaQytQZlVGWTR1UGhZ?=
 =?utf-8?Q?soe26y7iver2yox1Cc9LHKv0761yKG3+mPG6A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGwvR21BMlFxZ25PNUdmOFhNRWV1YlJUOERqQW8wWit0Vmp2cEkzRUczMnZt?=
 =?utf-8?B?bW41cEYxSzFMNWlDL3FBUTZCVVpEczFmaE52czg0aGlEZVhHbWZWSkJ5YzZk?=
 =?utf-8?B?NEJsSm02VTQ2eG5mMll3YUJIaVcveFllZ00xSEl0U3R1MzluZWI2VUdGRHRr?=
 =?utf-8?B?Y3RaVkhjWnl1Vm5KeUxMZTJudFREOHdCd0FoVHFYR1pJNm1VcmdwS3BhYmIz?=
 =?utf-8?B?VXRseDVaWEZ2Y1h3R3p4T3BBSWxtQnduSGlaZ1dLNU1TVUQ2MmM0Yk9mQVNv?=
 =?utf-8?B?TjluUzBRcUpINXZiMGlDTEJVUGNMZVFUNFAzZkhkSEVBN0lrakZLc2huTkJF?=
 =?utf-8?B?Ymtldi9PZ0tlODdaZFpsUUxxR1pMbnJCa2NERDR3U1pNRjVtUzNOUWpxTEU4?=
 =?utf-8?B?eGJVeHZVVzhPMGxMTS92ZEJnNlRoaDc3MG9lU09wRUpib2IvSW5nMWp1NnE3?=
 =?utf-8?B?K1Q3N2R3ajVNWUljZVVYR1hKbTFxWVZkK200Z0FzOUFjNFRlK1lqZElkS2di?=
 =?utf-8?B?MU1xUktjMzg3VnhLc253ZkZKdlZhelNpV2c3YmRzMXR5bFd6Vy9DNWF4M01n?=
 =?utf-8?B?Z0JCUXhBZ0NYNm5yb1VWRzVQa2cvRTRkU0ttN0xOVHdOMWp3T1dIWnpmOUEr?=
 =?utf-8?B?c2pRR0VSNWFvRFNoc25BRE9tR3MraXN5KzQ3ZjNKK1V0anFhZWQ5R20xaTdQ?=
 =?utf-8?B?SFNaT1BhNzNNWXY3RldZbXQ5VWhXVjl1dlNGMFVYbEVJMUU4WXJXWTB3SURs?=
 =?utf-8?B?U0VMamVCWkwrS09UK1EyY0NqSXJuMXNlMzdEbWlrYmczT0RwSWJPNTN5cDRV?=
 =?utf-8?B?ZjM3aGZOR2NLaWJlblJtYm1jVHRCc0R5TkcrSTQ4VzZnUUhxdjR0T0dOZDNS?=
 =?utf-8?B?UE5IZ2pwVThFZEJadU5vQUYyd1JkS1lmMmR3ZTNaM0drZVQ3QUNIbW9Uajh0?=
 =?utf-8?B?a3Jqci9GLzl6cnpHVEhiYnVyRTRMVnpjL2s3YVpldEFJanE3c2xxZUpLekJH?=
 =?utf-8?B?bXMzT01KekJMSjNwZ3Y2VkJQak1wNk9mSnpMd3hYSVIrMFl2Mk9DTTRSMDYv?=
 =?utf-8?B?NFZQb0RQTmM4cXJHem9oNC9FamtNbms0NHBnemtCaW5aSlBIRFJjSXhQRXU1?=
 =?utf-8?B?ZEg5ZU9hVXphYlNZNlJFMC84STREV3RHU2Z6MDFaemxoWVZ4RUpOT3JEOHhy?=
 =?utf-8?B?M2J5ZTRTeXg3cVBRbEpDSlRpTUNOWmloNEN1UEwvTnVLdmh1UUs1d2dHbFpK?=
 =?utf-8?B?QXhWUEV3WU1LSlhObHhMZENBYzhrMWU3OWhlOFVham8vQ3l2TEpGUWVJVEVT?=
 =?utf-8?B?eExpbG55WDJBQmxJM1lCblpPOW5MSENqbHFXUnNkSytiMmJKbnp2WDJPb1Y4?=
 =?utf-8?B?VmJBYjdnN0lCQjIxNWVOd2J5SVNpTGJTS1pCRE9VSkNWbmtaVEJYd05SdmlF?=
 =?utf-8?B?ZlYvWkxFdUFkbW9OMjVybUl1eXFWNDJqd3g1Y1Jnd2Y2TGd0L0MrbHlJKzQx?=
 =?utf-8?B?elJOWGxyMlJIdDNlampnUkJIbU1JNnNRVXp3VjJ3Mk9teVdLN1NuTHhIbFQ3?=
 =?utf-8?B?RVZWQ0h0UWxkZjF3ZDhSSnZ4ZXFRRFFoSzB6c0p3N3RqS0o2Z1gwWGxVYTNS?=
 =?utf-8?B?enRpZ3pqK2w2ZnpVR242bG9Idkd0OXQ2SE91S0FBbFV0aFB0UUNUdXVKRyt0?=
 =?utf-8?B?eWYwM3BVL2laZzR6N0RnRzU4c1FkUTVQQzk2ZmNHU2NWa0Y4cDlERjRXNUVS?=
 =?utf-8?B?QzRxQ0w3MldhVDRjRWdMTFpLZ3hObXozVUU2TUs0M0RpWTFlelo2L3NMZGh1?=
 =?utf-8?B?VnZJVFZEUG1kMDJMdmN2TEJCcFN3TlgyRitiekxNa2VoSGJTdy82MHNUdjI1?=
 =?utf-8?B?NWdBOTdJV3lvck5CenIrRnAwWUlBckQrTytMUkIxeUV2eDVuS1VBSk9zWUxv?=
 =?utf-8?B?SlVtWm42S2ZSb0FFdTAvL3RiSjMyTHQ3SW12NG5Zc1hMNXZBWDRodndidnpu?=
 =?utf-8?B?NFpMNHRRamZDSFhXSXh5b2lpWEFrdmxHNXQ3UXNwNzRoK2ducUJBZDVydkor?=
 =?utf-8?B?b29YQ1kwVWsrcDFjMCtlZmFMT3JVZTlDYUZIaGVmSTh0b3pPWVFJOHU1S1FF?=
 =?utf-8?Q?NOnYhk7vlBwT7buBmZLSUO5bC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785eb09b-3095-47fb-58fb-08ddeb7a719a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:15:28.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhRnYoK59Q+q8M5xhxlSypnrmJBBRzEzuBgG32iQzE3kBVz9TdhdrtZVSCDam26lLvmT+kmbCQz7/AOqvCUaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 06:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20005

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=9&day=4&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/08/cip.2025-08-14-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep  4 06:15:03 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep  1 01:59:32 PM UTC 2025
  limit date: Wed Oct  1 01:59:32 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 18 08:36:05 AM UTC 2025
  limit date: Wed Sep 17 08:36:05 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Aug 20 09:54:43 PM UTC 2025
  limit date: Fri Sep 19 09:54:43 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Mon Aug 18 08:37:35 PM UTC 2025
  limit date: Wed Sep 17 08:37:35 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Aug 26 02:50:14 AM UTC 2025
  limit date: Wed Sep 10 02:50:14 AM UTC 2025
  Status: On track

