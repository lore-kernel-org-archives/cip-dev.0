Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFCE98FA8
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 05:14:49 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.125603.1775711686951506240
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 22:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f40kXzke;
 spf=pass (domain: siemens.com, ip: 40.107.159.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOeVmydJ98/HRVI+VVDGFINJbLM1qOwN/30Ed9EyoNXak477NILLZsltdwDroc2fmgomezhRhLHyZMW7bYvOwBTWzfWXTfCN0K5GE18MMKUDe1VXLEoNkIqLjK7iGEavmDNvqVtsTEFle325QHj31539LL46O/qXo3jWTP84wSFuBqZXyudhuwAbg7rfDFd4iRfI+k2luNHtDPyIN67TICMS3+4EzIOSevsFbhLSw1Cdc1iWymMqQM9FTKJdzJmhT+KJ6vDjtTYYUJXoYSMR+T/jzU3ukL9QLvWquzDqxS8eVRmLMLOUusEXC7qqbbi6SqtYmmsReb6vAJqL3RVY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JftOkoXyj1MEeAikuAlo2WsQ+m06XMSHtGsAvNQDkE=;
 b=ACyCV2phjH6zJ+og5UzWsvYSTh+WlwcBwH5E7kpD3HqviyfLOMvu10N/NoXaAPcDbhbnrfIi/SKzBg+jr2KJiVTili9YzjEVPVLTLEfT6T8uooxOzoa6+RkBajndk+V3tC2SBjKMWuIBxYUztWmWcasScNx8KGUYHGpczLrlouu8ekFlsGQ9gCps0hDdQGqc4oIQZ6d3gWAV0QLeTRtOMGIAF+rQtHj0P3d2w2OHHgBF36t+DBH9zElyZ/+wyaTR2DV5eTibL4zGL3UxKdC5VhdgMXRPSGxau7ItXTA5pDUQINyVyK35SazZsUEZsJWHCrafG06bBIWVKntx+pXwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JftOkoXyj1MEeAikuAlo2WsQ+m06XMSHtGsAvNQDkE=;
 b=f40kXzkebIXVhpJpEA4hwqEu1NxOfOGY1BwrN6TS0j+TfP0/kSh7TFI1x6GVF/HTACyMcHadqOa6wNXrTzsTffNslvf4d8SyA085ODmiDMN+twswB2Z5YEOWaAaFKyj8/rd3CmV+jKA/nTu+XWAvHJX1txp8nK1ya9351lQkSrJGg+r/8OuZaDBIltW1kkvTBBuivnmhyGusB/l86/AUkKWuKZ4h0nbgsNZLCsbE4zDO+NA4O5ddP/LDYc1fg8dasIPM44s1XDpiLZ6WwMK7iy9YS3wATEIgQlEYMsBXkUC2Sv6VtvJFL/m1DhXBsBOVGDYbJnwgZJlbx/w+PAsN5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 05:14:41 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Thu, 9 Apr 2026
 05:14:40 +0000
Message-ID: <88fd5941-b0a0-42a8-a0ed-112ee5929e01@siemens.com>
Date: Thu, 9 Apr 2026 07:14:38 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: d2176c1e-7f4f-44e1-eb55-08de95f6e732
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	KDgDMFYlXAuyGzhzw6G6oB+eH6hhJbIg/CF3r8QdFNfgfCTkG1sAJKMDdUFo4IWnxQyUXe4cOqn0J0aV6uIVKtfgwR8SmMh5U7AbS5eP/wosfJYTsurExpUi7qHD/+4oORM5O74ryEOE16dVYPL1u4a942RGC6kPwtDYCHgzAp5QtO7wDleX4kA6kbfkGuTfLQUNg8mPXX12ntGNNHSFTjo4/DrpsqLn0dhbQ2ECyKZ69m1hUcwOcpcixkWRb5hw1L7xwYKVDZjoeaKzmvqbd7yfE5r5LxsaL/mXTIHb2WoVbEtM/I4bOSfaQk3S1WQQl8DQHR+HTYvqubg13SVYRdGYCua7PZWg/G8ZV9xRbflvMe6w/D/xt8NAW5E9kI/NH4jvvAYJjDu8fJc/ABc8UHAX0zw5eHys0Xn9GcKfYR5jTIp+A5mgB/3uBDFKJIMxesnV1qtbPQ5CIMlaPst/7lP7mEVq7RZI9vMh8aTVzn2aYgu+W50M7A3vhfYABXdPRLOCgR97PgqFiUj8ZYj8PqSFfA0M2ncMyHnTgrYuzr12+GDtTIIfJLYq6PIigP5Zmuqm46+wevU+abAfDFP/qQNr0yh1k8tBpcymV90HO8pXhfSSMsBxAX6q0ihKdAXIkbC0GKFqJFvJmUq1OcX9IOfYR+s5JL4/duYhdxhuJosK0SITkflnGeKv1DvMZR81
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHB0cm9iSzdpRzczMkNJMmljNjdqR0tCS1NPMHQrNjR4djhRVms5QURNRnJl?=
 =?utf-8?B?S09DeTNRSlBwVklEM3J3c0hEN0w0bUk2VVVORkp3ZitaNFVocVprYU4raFA4?=
 =?utf-8?B?Vy9NWGRwazI5MUxmejdMcjRDZVZSOVU0RnNjVjNsK3hvNTdWeXlmR0JTb2xY?=
 =?utf-8?B?OVJVOXhlUlovUjlpYi8yb3ozbGU2M3RVeDNWUEtIQUpUZGl4bk84UzRmNWtX?=
 =?utf-8?B?dkNqNGNvS3VDaEFsY3FlS09xK0tldnRWU2M3c0xCK1N6MWhFQmF3aVV5L1A4?=
 =?utf-8?B?QWlUdmN2Y3ZtdUJSZHZha3Y5SUlrN0YvYXlBMExpb3JGdjRUNFpMWkNETVpD?=
 =?utf-8?B?ZzdqQW8wZ29NOElCRjFnZTJmRDcwZ1FKR3V2VE5idVRxcWtTTVNsQ0kveDZN?=
 =?utf-8?B?K0tya0dTL0JSSFdnUmFxZkJsODYxejVYb3ljZ0FoQldLTGdPZjgrQlN4TWEv?=
 =?utf-8?B?enN1N3ZoamwzTWJiVU5nZGdjTFZIZmJEcTc0b2ZJOVJiYWVkWGlvNFN3TDE2?=
 =?utf-8?B?bEFydVhjcWhLRHBFc1dBL1IyaE90Nm5KRHA4NU5iSTUvREFPL0c1RHBwZGVm?=
 =?utf-8?B?b1ROTjJ2OHU4cDEydDRINWR2QlJ6TUYyTzlUdlpFd0NSQTB4TTBwUktLeTBw?=
 =?utf-8?B?eUt0MVREZHQ0cHUzNTRPa1MxOG5Wd1hCbFgzNDBBN3FRdTdzWVdldTBLK1Fw?=
 =?utf-8?B?Y1E5MzVHUGdJZDlzcjdKeUk5VmluekJEenVXclEyTnhVTml4MmNkcWlKeTBN?=
 =?utf-8?B?SGJkbkNtNzR6d0ZtbW1PSVJ1VzhRZlNXekJVVVJ6SWc5TXVSbWJzOURXTUQ1?=
 =?utf-8?B?MUwrR1RuNUdnK1pxMEFxM25HY1lCRmJLZ1IrdWlaZGRPZ1BKT0Nqa1k5MW50?=
 =?utf-8?B?UG1MMFk3c3RRdlJQTWNkeUI1QTY3UlNXZ29mcGgzK3g1cTN6YmdRMUhTclp4?=
 =?utf-8?B?d0ljdkd1UWJsa0JVbUJiTEV2SENWZWQ5RGtnZWlLcEVqUm5MYW9OWmRIWG94?=
 =?utf-8?B?RzI0Vjh6L0NWS1dhRTlwQVR5ZE5QZU1wTjBLemkwMnhHL1RGYWNMUXlJTURS?=
 =?utf-8?B?a2FJeEJWY3k4YXFGbXJxSndoYVZEMzZsT2JsZWh2SCtDLzgvL3JkRERYUHVJ?=
 =?utf-8?B?ZmhyK2IzMzVTVGxiRmJQM092OGQ4UldxMnNZZUJ5aHp1TU96S3hxdE1MQ0VP?=
 =?utf-8?B?QXBtN1Y0TDJnNXpEbjBJYkExM3JUSmRnWC8xbmtpU2g1SmY4SC95bGRtOTZo?=
 =?utf-8?B?eXFHblBKMmFzUkpxdW5ZYzcxWEhUNnpWUWxEZE54VkZXT3VVVjlUUDRqRDNm?=
 =?utf-8?B?MDVHbDNOV055VmQrdXErUHRsMlI5a2lxUzVrcW5LN25KV3RlSngyZkUwdDBH?=
 =?utf-8?B?MnhSN1FpQS9VWmo3U2R1T0VPQkR1R0FRdVNpNUo1b0NyVndaYUpTQ2MzV2NC?=
 =?utf-8?B?elk5WmFuUmZzbFd2Q2REZEpLSU0xSmxRTW5OR1lzRmMxV0YwQmp5OEgyV0kx?=
 =?utf-8?B?RzZsUy9qMTNkUzJNWktyOEF3ajlEZDlDWXpPSXlSR2NKM2dYTlBkVCtZYVJs?=
 =?utf-8?B?Q0NQZVZEODhIUElid0wyYVhJRUUvWFhKY0ozcnBvRnB2QXUzVlNBenN2M0l3?=
 =?utf-8?B?STBublRCcE5PNVYrc1VpZyt6TDRvVE9JL1lFNisvMStOZG9Pb1p5ekp2UHVV?=
 =?utf-8?B?dVhwZndtdHFzdHF5YlZ0Und0MVhhNFcxMWtWbDBnR3hjSmpuQ0VFUzRrdGFz?=
 =?utf-8?B?eUFXSkxmelp0YThGSHFnS0tndXRtQi9tQmhsaG5jdk5OSGlyRVNoa2xFK1Jp?=
 =?utf-8?B?UHJnSmlSUXV6WGplZWJZL3NIbXlyamZqZGk3cVA4UUd1RTR6b1JhZFB3eDhJ?=
 =?utf-8?B?K3ZvUnRQTFpoR2xWb0xqNjkyV05CNE5ubFdlRnBHVW5kM0NuNFJXOEF4N2ZM?=
 =?utf-8?B?NzdtVEg3bm5KS1NKVCsrLzFvenVVNFppWVdFYkxOSW9DYVd2V01TVGo1ek9U?=
 =?utf-8?B?b0N3Sm1rdU5JVHczUTFDL0gwK3gramh6UzB4dktwL09pdk1LSy9mdUJWTzdj?=
 =?utf-8?B?RTJhRUl4WEdURWN0M3V4enYzamFneDFmZ3lOWU5vTlB4MnJjelBuR0JtTXpU?=
 =?utf-8?B?SWg0US84d2dMaUl1N201VUNFam5tOUdlL24waW5ISzR0OHpJWGV5OWNCQWpZ?=
 =?utf-8?B?dSt3K3p1dndscGV3Ty9EYWlNM21MUGRTVDllRlZLMkR4Q0pacUQvVXVkN2x4?=
 =?utf-8?B?N0p5NlIveVhmS3l0U0ZqTnYrUWdPUU85d3RuWk12TkkyOURuNktaN1BpZkZB?=
 =?utf-8?B?dDlLVlBVbXBaL1R3dDBmTnlJdzBjQ095aDZ5VzBDbXVUcGhpL2kyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2176c1e-7f4f-44e1-eb55-08de95f6e732
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:14:40.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpgJQny/A/hCGofnTaQBgDp92/u7OnIkwVe9cAaUbUdc2YeLkTGS6SaZv/tDLD2ks6MbxiyteTr9Nf8QRb9Vqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8699
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2026 05:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22658

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=4&day=9&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/04/cip.2026-04-02-12.03.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Apr  9 05:14:23 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:05:13 AM UTC 2026
  limit date: Fri Apr 10 03:05:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Mar 13 12:18:31 AM UTC 2026
  limit date: Sun Apr 12 12:18:31 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Sun Mar 29 11:55:46 PM UTC 2026
  limit date: Tue Apr 28 11:55:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Mar 26 06:07:13 AM UTC 2026
  limit date: Fri Apr 10 06:07:13 AM UTC 2026
  Status: On track

