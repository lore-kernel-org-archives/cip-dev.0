Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9550.1795070385257228262
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 22:39:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mhhEX+Na;
 spf=pass (domain: siemens.com, ip: 52.101.66.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2R9bjzi8TiNp+0cwUCZwD2q+Tdj3feAAZtvZSULfoqGCBRriqJVIjxyS8hrm6Cx2ymJnU64elUWkgOsEGWw0pFpiBuEKDw/NsUw9h86rKiC7OUoYlmV9rHUHTNHLk75JCxNKnRkBWgXgqylvd0GJXPzqsw1V5r+Gbx8gSphRMrBKyEP+O12AhTzNcNiJC4mWg+Xm4L4zaWzs7GVzFDrtBW1iThzlo51OqnXh9LlVyt5Qkvh7Xlbz+fsIjXsARRUc5A77ZgGpWit6VY5cuKnQLSHOZk+hJL0UplYd8zzbGMaZQmHEfGLPfF86iXhCSHg+A5CM8cbSqgXuoZQzWhHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY+iJYNOwV4exbbeFHoo7sRVSw1BbP4ve19bY/vYZvc=;
 b=flxFtva6ORvXIkQpEw5dG7drgo8rQiwNRgD442mjnjzVk3DBm8aQV7B0xZ+s7yyhb/f6tINVXFNb4okk5fM30Ks3CB3zvOqPzf38IPjoFnegT7gTUYaPN3wtWeAM0sarREOQXet9YVXY/Kl2R0SDPxH60AMLpaEuvvWN75AA7yNA7vkXFfZC8zc0t3e+9VQAaVK6NIK14tdkotIzwtTCyqEOxGBwm9KzRVa5bA1RN3agPfYLVMUtisCk91+hlf+KNlKhCsQkkHKQOoqF4o9ZgTrAimzFFVhKsFV9q1galbK6awia7NXu0J/Ls0Pqllum+Jq24I1idcxNNW3BPwHMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY+iJYNOwV4exbbeFHoo7sRVSw1BbP4ve19bY/vYZvc=;
 b=mhhEX+NaqrECrghQUNxRS3y2BASB6yfQjwOd1py8Cgjn7/Jx2Tx5Pj8+Q+8UeT9wddnzgYAMKe4pSsK/jqCU5sxSszRVdUHNay9qjOrNAe4Wjs8T/QgYoYWke9f27CsNRexSzmvEau4/f8/d2OnoUliMVwUmb8uPOSUpWykdyGaUdjrAfsKQRNcjJGG3BQ3V/CiKHf/PlofLM3jfofvF9hJ4n5izTmNTpa0YnWaQG6MCln4L7FEBv9t4b06Oe3cFV92DyGgictZNebo6pagRuBCcz5OCXjRi2DnAaPoTOXosFluPAMYvilOD2hNC+GjKx76QI8eIfb9ctDzKby5yXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9389.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:2ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Thu, 19 Nov
 2026 06:39:41 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 06:39:41 +0000
Message-ID: <2d2ff17a-7673-40c3-b05c-c3b7f8cec256@siemens.com>
Date: Thu, 19 Nov 2026 07:39:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e1901e-1abc-4093-6181-08df4607e3bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|55112099003|11063799006|56012099006|261028144727099003|261022075727099003|10067099003|261021135927099003|261009223027099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: C6ZiULiDTXU0/rjAhWc8E4nLVho3uPQ8CHXYgGXDkNw3Y2jTAlvtDt+lrgCT74PGTwKS2lKvHO4xIjHJTxgT5xrvicyGiiQK1QxCcJMs0HpyRxJ4JGZK9jTZwEfVCrjoZ7qMUMe9GopDvLzcSpLW00+2DZdmeUSAw2SqcWfMJZzPIYstcnKIvYr/VgX7oVgfFwffEkwQbef70D9cPw/ZeEEUfvzgjp5ROMvhFuAdks3G4MAv/JVHsXvIGzF5D57EdEdSVmh+y73uz6AuEHaizl58yVIaibC2e3NopXU1ISr6DA9dVAl/KNNWkV+iTMxXQ7IZzAwViLRTyVYkZtyGvLmaNs7B5op6X4pfmybalkKWLCF4EwhbF97EiMlplg2oR4cNAR4DvTTlk8k3GLMfjXYSQ1/dgdwDheQy9SoxbJ7qU9R4u66/VN2e73RBjUlMwRtx62WrrfTCuWAz+v5lLbVggsEBhY8/WG9vbJy8pxb5Ad5TIApBa90PsG+o0Z392fwJ2VsT6S6U/8KpNBpoelK9exm9qsURPq7DoVCOg61HE3AfChg6oVZ5+bbKISOiygOgdNLrgj2PxIGjCfILv7AkRVRFoO9VeB5k/WoiMVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(10067099003)(261021135927099003)(261009223027099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdWcGxYd2FKMHNidnkwNjhGS3ZlencxaG1ReGN1UkhFYXJUR3lseUtBajQ0?=
 =?utf-8?B?YUJJc3RTR3h5Z2dQQWN1RUtlZzcyTzQ3S3hlQXJNMGRSUU5SY3RoWC9FRUJO?=
 =?utf-8?B?aGZCb3FBQ2lERnI2ZWtGeTZJUW5tM1lOcUgrNnNaSjNwanorbzVzN1hVMVZr?=
 =?utf-8?B?dGsyV0pabEF4UVZsYmN2bXhhUzBLU0U3d3ZRZDRpOFJSRzUzbHlrZE8ydzNs?=
 =?utf-8?B?Rk5EaUc3Uk44amlOR3c5OFEvWm9TVHNtS0VJSzl0bStjdXY5bmREYjFEQ09K?=
 =?utf-8?B?OWNkblhYMXRjRFY2bG1pQnp4OXJUQS9QNUhTQ3g3bzBqSE1KNDM5bWdCRDl5?=
 =?utf-8?B?MjhpSm10THhJV3k1QUtXVlRSYkZKR3AwaHdyMHBKTERtWVBtU0xhSHdFc0pQ?=
 =?utf-8?B?cDZjbmFQYzhKOTdETEFBVUczYzRIUEpxb1NiK2hGaWJpdlZvWTI0elBLY0s4?=
 =?utf-8?B?QldZUkY0WTJNU2FGMk14Mi9OUlhGVWFTNkV4MEU1M2JWaVpWa3VGZTFWbzQ4?=
 =?utf-8?B?YXhTYW5pV2Z4Y3ZRTStoY3h6WTRvUGhEMGxpYVlPUTFjbUs5RDMwMEZOcnFH?=
 =?utf-8?B?ZTYvSVY3WG4zUWxmWG9ISjNFQWdCK0VQdzAvYk9HM3NuR1BVOVV2cFkxVEU0?=
 =?utf-8?B?Zm4wZVcyRTFLV3ZvMWppZ3ZzT1pEbGJCSkYyL2ZOc0xHYy8rdzJhQXIybG5Y?=
 =?utf-8?B?cklTVDRPNlZWcmxPYitDNVJ2UGY4d3lweGdBV1ZXbHVRSXI3dlgrWGV5bCt2?=
 =?utf-8?B?SjRKaFltNzNCbmFPWnUyYTBYeWJHNDgwaXlGcGw1czhiZFBSdFB5WXEyUlV0?=
 =?utf-8?B?M0ltSERKSnB3TmdzM3B4SGl0WE1UNlc4WXprQ3NsOHZLVzZvQXVISW5mMTc3?=
 =?utf-8?B?aHQ5NnJGb3VnTnR0WVNWaVJGcnJDRVd2cVZuejJ0dEJQQzJBSzJtYkV0TkhR?=
 =?utf-8?B?c2c4czBtYTQ0NVFqSG1ja2hTNHdjQXNLMVR3YndvMVU0R1AyeDBTS0l1cVBU?=
 =?utf-8?B?SCtJNkM5NDF2d1ZJbUdJUlNZRHZnT2JHSGt4RE5vZGRRbzMyYWppN1RTSWlo?=
 =?utf-8?B?c1RVVFl5RmhRWjBzUWVIQ3FyWmZHZktGTkduL1A4aUFqZHFkcWxudWk3Lyth?=
 =?utf-8?B?b3BGRSsxREFCUXRyZ1RxLzFFRW5iN1dGbUJKYVNmckZEc3VHR0N0YjlJWXJs?=
 =?utf-8?B?K3hlSXZoUFl2bmZRcW1sTGJEV0g4ZUZZMDZxS0p5SzZlSmxnMlI2UE1waFhW?=
 =?utf-8?B?K05QaWNkMkF1Y2NvMlhRZ2RwTG1SeW4wVGtLOWcyUDdBM3NlR1hqYW9zNUp6?=
 =?utf-8?B?RGordXdhck5GQjJRMzVaZ0pPTWlkajJWS01PTm5zSGVmWi8vWVA4TVJGNk5S?=
 =?utf-8?B?TUh1cUdxNlRjTERDeE51S3ZQb3JYTTFRcUFTNUhQWkErWGJXS3ZvWDFEM1FY?=
 =?utf-8?B?VXB5ank4blB2eGw3TWwvWlROZlNhYVVTZ0tQdVJMbk5SZ3hVeVE3eDUvajFV?=
 =?utf-8?B?ekZzRkZ3K21vUHc4SjVTdnZsakh0d2JKQnp1K01ueFpTRDRjdWNQbGtYTXBi?=
 =?utf-8?B?L0YyRWQzejQ2cE0vOGFRV24vbWFXemlOdjRobmtPS3VNazd1NWpnb1JjZFc3?=
 =?utf-8?B?TDdUdDFvd1BaQzFyQVI5ZXZSbWxBWTNET1RLNXFYMXpReTlYZEd2SjgzNDhX?=
 =?utf-8?B?OVhqRXhjeXpoUEFCa1lHZnpQY0xoQ1YzY3h5cjhGY2lRdVN0WVRwM2VaZyt4?=
 =?utf-8?B?YWlQUm41SEJtWUY1MHRFYTJhTmhJSHNhdWdWZE5zcTVnNjBjS05NN2l1eW84?=
 =?utf-8?B?RVRuK092djFuTnRMRm9NUG9JVUtOamVaQ2h6NVBvNmQzU2huTUJEdmpJbWFR?=
 =?utf-8?B?QXNJL0tFcDUrY0Y1QVhxQm9LYW1WSjBXQmhUUVBGbXVXcGZ2TEtWNVE2K051?=
 =?utf-8?B?cFJ4MngwRnRPUnlNQ0lnakgraFFkN3NDUEpUNDhDVCtZN0V5bEZoMjhlVHkv?=
 =?utf-8?B?NUJnemYvWTc4NkN3MjdFazZ2alVoZ0tkS096QkVtZHRBZFhNREQ3UFVad2VO?=
 =?utf-8?B?N1p4YVIzSHBkQVlDVk1ST0xvNFVEd2lOSGpITUVNV24wUllhbEc5aitxdGhW?=
 =?utf-8?B?TFc4RW5BMmVaLzFPQWtXeitCbzZwcU1xY0FBUi80SlBnMUp4TXRWVUNITW95?=
 =?utf-8?B?T3F2RmVtSENvOUl2RzB1RmFXNHpRanluNzl3Zk1OTzFtK294WkF4endiRzNJ?=
 =?utf-8?B?ZVZyUkVqWUM2c0RkMmUyV0hyei91ZzJkZUlZL3cwYnJ6c2ZjbFVabUM1emRK?=
 =?utf-8?B?MDJvSVhEVlpobk03S09oYWovSnhsTlNsTU9JYTg3L0drNWloUStXQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e1901e-1abc-4093-6181-08df4607e3bd
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 06:39:40.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jv5WRQiDaRBawf0X1qRQLVJIaAzAzyUURPNi0SDyfekj69Atno8rzCzbfy4/HFDg8b2tWuYWghuTt6odDNAdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 06:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25006

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=11&day=19&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/11/cip.2026-11-12-12.00.log.html

* Action items
   - draft of improved patch review process [all maintainers]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - additional contracted support next year

Jan

[*]
Date the data is created: Thu Nov 19 06:38:39 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip116
  latest version release date: Tue Nov 17 02:52:16 PM UTC 2026
  limit date: Thu Dec 17 02:52:16 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip137
  latest version release date: Fri Nov 13 03:27:41 PM UTC 2026
  limit date: Sun Dec 13 03:27:41 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip137-rt51
  latest version release date: Mon Nov 16 11:18:01 AM UTC 2026
  limit date: Fri Jan 15 11:18:01 AM UTC 2027
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.272-cip79
  latest version release date: Tue Nov  3 09:48:41 AM UTC 2026
  limit date: Thu Dec  3 09:48:41 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.272-cip79-rt35
  latest version release date: Wed Nov  4 02:13:46 PM UTC 2026
  limit date: Sun Jan  3 02:13:46 PM UTC 2027
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.190-cip62
  latest version release date: Mon Nov  2 08:01:07 PM UTC 2026
  limit date: Wed Dec  2 08:01:07 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.189-cip61-rt32
  latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
  limit date: Mon Dec 14 09:34:39 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.118-cip136
  latest version release date: Wed Nov 18 06:07:08 PM UTC 2026
  limit date: Thu Dec  3 06:07:08 PM UTC 2026
  Status: On track
