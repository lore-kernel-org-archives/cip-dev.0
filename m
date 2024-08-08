Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91983C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 09:43:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.60])
 by mx.groups.io with SMTP id smtpd.web11.55920.1723110196850413817
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Aug 2024 02:43:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z02VWdA4;
 spf=pass (domain: siemens.com, ip: 40.107.21.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvT+KXHj1Y3JZb5muH7PjeBJWh74+tcO74+scPCdb5LH7Rqe3pOekXTL8q4GBh9Zd2jTRiAD0hp1MKR14696pF8XehMfzo2LobSz7v92Zwc9vYcvAPP0udwwhM+81kR9DMoNMLwBr6IHbY1CXkBN+EA4ymtXM8/nqNCFfjDMKv3Eo4raklK5Gg7qWG6Dy3hURywoijanRYLnGcgELzjxaFbzQTeILNzK+rGzNqeXNfIVI68IEC5wcF8cdDNkZwaIx5M3fZTZapCKqP3szojEAVJ61Vn3jrbvXS7jkideDDgLelvy8mcljLw50Mbt9t/1Oi04Ii6aT/CbgyR6yTPbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk2bwd3/a0MWECH4J9SO4EN9OCpCcjkWCaJxAR3v1J0=;
 b=qcnKA5b8cb9mBrkJqiRj9jJWcQ8KZP3FGUViBf2ETzC1PdVXkCyL2KcBnIRFN9Ys+mh+55ER7fYElQsZ1lPJcbjyId5zy/lnQ1IlCL2pJsp7xbzPq+tyvWTvOyJQHSvcuqv7IU5DSZazJnjezlJKO7Ru8U9VGpywBfMpRp8F/6gTLQgmP+5TqLkojsmc5WzdKAFDRylwx1u9jOPtEpZAmN/3OX0htM2Oe3BxRBzhY7Uq2jtwzgmJWScd15hdnGpYSOhAir74/RKda0PcNRPkgo5jrfxmUvxSoAC4rNH8PyGr1ff/4qDiUkK8jFStysr7MYuIywoFPIu5S6TCvW5Wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk2bwd3/a0MWECH4J9SO4EN9OCpCcjkWCaJxAR3v1J0=;
 b=Z02VWdA4i7CJpdFhJc7wtddSSpi1NdzmIcV7YeU66//6zAxxSYaqbqWIQmcuU3T0nKazRZ/bjWID9TiT9By9cy1QIPgGrD1RDfJj/bW/+OgsuAygdiRTcXVwFo2mCDMbUGj8ahmQ914X9uIH5xEz/W7xrSqCtMKVnqX9rAKdfq6p+D9Vp5riWOBouOXI5+Vg0DxP6pH6zs2rapBh7zf/9GeAgn7wRi4VxwUAmuqaajMsNJfeQcjUO83mJULvRfmfc5jd/dlg7bfZH/LbvCqCH77okLDgq0YIrPYY3Qflm5b1Zt/W98LOKsuklaJfE8hmnRI0FkSMXh5UbidFLoP0OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 09:43:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 09:43:12 +0000
Message-ID: <43b095b1-3f49-499c-a102-c13144857ffd@siemens.com>
Date: Thu, 8 Aug 2024 11:43:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: fc212332-9cc1-42ff-c110-08dcb78e8529
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QUZudUVpMFlGRnJGc2dvT2VmalVPRDhDZ1B3a0pkbUVFVHJvaldMTGljZ2pS?=
 =?utf-8?B?MllMenE4OU1Td0tNWHRheWxSZ3I5RVRmZUx4WmNNc3dHZERLRGd4cjVQOGVl?=
 =?utf-8?B?S3JLQWZxdXRGU2RkdFFOelU3MnpHMUxhRjVnVXlzbDJRMWkvUERXVENZSERn?=
 =?utf-8?B?VUdRNWtWL0FCb3pPNjU3ZlNNQU92YWJ3cEFKSUt0YkExY2NYeFhMYWxNOE9x?=
 =?utf-8?B?MWlEOUFOV2JhdzlKRVdrSEdEeGZzVHQ5RmpEWHhyWkdmOWp5OFlaaXpKUXUx?=
 =?utf-8?B?d2l1UEtVckJVaXk3aGN4cEM3NUcwN2FkczBwZmdvaGx1YzRwSGRrNTZqdzRB?=
 =?utf-8?B?aGFwM3dZVk5ZTEVqNXZQM3RVaWhPTjB6K2ludFdlakZMODdRWGZqa0c5akNW?=
 =?utf-8?B?SEdRQkJsN2UxVytFQU51U3VMcisvblk3a2pRekllYmNaSld1U3NZa1BRanlT?=
 =?utf-8?B?S3BBYWpWb0ZBM0VoZTNDcG53c25WZGlOaW9TNUhVUWdORGVDL1J5QUsvT3M2?=
 =?utf-8?B?NUxDTXU1YVR1TGs1NDFyOVRRMkJZR1pGbzVUMkVMbWVJOFdBOTJ2cUxncmZ3?=
 =?utf-8?B?aDFPK2FVTXNGdzJPQkVac2FqUENnVU5WYzFTbk1rcmVDa0NmY3RvdGRzUjdo?=
 =?utf-8?B?b2daRS9MbDdTU0p4eXQ2WDhLdUJyOFNjS3kwVzFNWjZSWFA0SG5leWZEYzNz?=
 =?utf-8?B?YWZvNzlyM3gxbTNjMmpHNVg0aUtGMXRCdWx0VDRmTE0wOXREcEk2TStTa25N?=
 =?utf-8?B?S2tQU0gyeUlIVVBpMkN6bUFQeVpMSzJKMHpiUDVIVEhOY1B6S3JXUllkUnVy?=
 =?utf-8?B?dW5ycUZIV0s3VnkvbDZJcTUyVGxOU3NhKzBkbDV0OE9qYVhBcHBweW9iTU9q?=
 =?utf-8?B?R0J2NzFKU3hCalRLTlhIVFl5bVgzZnhVYnpsemdaMnl2eXBudlA5TjZBdlVv?=
 =?utf-8?B?c2xRNFVybklmY3VsSmFQSDZpNVAxMjRBUkRCNnJVcDZWeUR6WHJhZzVGdWR0?=
 =?utf-8?B?ZUlFcTNmT2oyNXJuc2wzUFk5ZXZnVk9FZnRSYU51dFp3am5QUm9oZmNEN3BU?=
 =?utf-8?B?QXdCdEFWQ0o4Ty9QNDlZU0tXajRKUjlvQ3ZrU1NETVAxT25INzR4TEtlRlBh?=
 =?utf-8?B?OEJGS0N5UFFRS1E5b1dWNDlSN3Q1NWFLeDJsd2pJbUdmakFBSXQ4WENRK3Bn?=
 =?utf-8?B?V1l2dzlKNmFFNXM1eDJvZnY2WGpDY3dBamxlQ0lNb0N6T29uVmNtTjU0K0Jl?=
 =?utf-8?B?SlcwbFJwM1RhbUpySG8yUUJKUk1meTNGVnJzOEYvclpmWnhBS05paDJzOEJu?=
 =?utf-8?B?V0xvZEw3Y0V1ZEFaUEUwZExEaUhzOG1WaHJpaTB5Tk9Heiszb2NnV1h1bDNj?=
 =?utf-8?B?MTNVaGZNZENpTURkMlEyRXk0S2ZyRjdZQ0Q1Zkk0ejBETHpYNXBqY1crQ2dS?=
 =?utf-8?B?OWhTZ3RjK1NBQlR0NVBqYkNPbU9zeUI4dFN5TWw0V1Vnc1FxZTdBZFBFZ2xO?=
 =?utf-8?B?bG50MFFjMmtnTWc2aWgxSEl1UnlrN2MrL0c3dVlJcUVVZDdCdERtOUNCa0tD?=
 =?utf-8?B?NnJtaERSSkdBV0NmZENweVdobzZ1aVpKM0Nxdm9hcHZta294THhYT3Y3cU9T?=
 =?utf-8?B?aU9iRU1BQzJTQk01NThPbEhmc0ZiUEhxTU0wcElnSkxDZFM3OG9ZUTRPbDdC?=
 =?utf-8?B?K2dJclhRN1huTVBsNjFkc3JCeHB5R0QxdjV0OWRLdTJpbmtzeG43VlN4UkpM?=
 =?utf-8?Q?l8jMnUF9RueF1Q5LR4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkkwNHFCUVg4ME9sZHRjNUhpZ3lsVER5dDR3L0dwN1NWL0RrWG4yNFI2ajZZ?=
 =?utf-8?B?bXBwOWQ4TWpaNFdCQWVoVHNXaklxUGdKOVF6NWQvWk9ZbUlzZVRyR0JXRlNv?=
 =?utf-8?B?cXJtSVU2b1JucXBMMUliRUhyMXp4ZlNwOFNoQnlSWG9pWUcwejk2M25XN29T?=
 =?utf-8?B?Zy82dm1ZNnlnNSs5KzI4MlN2bUs1Z0pTZ3p0MkNmdHMzaWVxdTRUUWZqb3p3?=
 =?utf-8?B?THhhdGVsbEZsWjB0bG5Ha0RiYVczejJMdTlOajV4d2JyRWNhVmdUcFA4K2lQ?=
 =?utf-8?B?Tlo0STJ4aTNNbUNLalFCMkVLZlc3R0NWMDJ2YU5kRzBoMWdOd3VrN2lNZHdm?=
 =?utf-8?B?dVJEeFhoNWQ3dER3eWFGeDdIUXB5WGhMVGZBbVd5c0pUVXVCQm9lczRQUTYr?=
 =?utf-8?B?UEJqT1Z4Z3UxdzR6WXZPRG9FMXc5VnVPa09YWGYwTWsvOEhFQURGZDRpUnJL?=
 =?utf-8?B?UDB6aUhLL21IMk5DT0U5QWVOSWgzSGhjY1owRmIzWWpEanE5Slp5N3VNU3E4?=
 =?utf-8?B?c3VxNjNSa2dFUTFtWVJsNWRTbmMwQS9SUkpXNnhBREh4UU5JMklEeDI2a01o?=
 =?utf-8?B?K2phU2RCY0txeHJhT3ZobGNoMHJXUDREU0JzbzRzVWVNTHNlSWNnSk1aT0NU?=
 =?utf-8?B?clp2Q0lhNVVtOUFwaDBralY5a1ZqUkgyeDZqZ01XYmI4S3JCcUt6dTJBWlgw?=
 =?utf-8?B?ZjhkMXh5Zjh2dEpWd0gwaTRhQWJyWHVUdGh5elZrcjFCQnFwUWJPTTVWZmpP?=
 =?utf-8?B?bk82Y3Y3Ynl2dEJUU2dNL1lZSzIrTGV2ckdOL2lqdnJ1eUtCc1kvamlSTU5S?=
 =?utf-8?B?VlRyd2NqVjd4bGc3b1RSUEMxOGYyOHB6NWZxUTI3UndrNUY5UTNmYmNrM054?=
 =?utf-8?B?Vk5JbDlWbHU3MmpGY2o5RVExd1lNZHhWbVNpZHcyOWtkazBlSmptMCtXUEZC?=
 =?utf-8?B?QWlxRVNwcTNyL0k3TFhSa0ZMSnI4QjZZK0tyOVQ5VzlBN2hlQmhLd2pZeE8z?=
 =?utf-8?B?a3ZSM25ZTXBWOFdJanp5VkozSTJiZGhWZHFEK1BXeXBIbkJ6QndoSUcyVzVL?=
 =?utf-8?B?L0F0S2xZU2g4TGo3dFpMeFFvRExPbmpwQ3kzWkI0emJUTnRTeTA2VStNdEIx?=
 =?utf-8?B?WW5VVi9hRVpBN2hkN0lpSnRrK3ZkVUhqYjZoaE9mM0trbnF0ZnZQZVdOTDVD?=
 =?utf-8?B?SWdNaFF1WVdxdE1JcUh3NkJSUjR5RElZYW9vR2ZMRm4rZWxtZkNVbWJ4U1Zs?=
 =?utf-8?B?amgrUlBlb2hEOHNja3N2WjQ5Si9iR01QWVZCVytzR0pCLzZqc2N3cXhINlly?=
 =?utf-8?B?TGF3Yk5IRXdUQytXYWl2OEw4WUxUYUJ2SStUMDA3bXBPb0FkZTl3WWk5UXRC?=
 =?utf-8?B?Mkx3enh5dE9CQ2d5bmx0djdYU0NoOThQR0FicmRFWTZ5elVJa2IvclVXRXN0?=
 =?utf-8?B?SFJ0TVk3TDhIamxiWGprNzFMd1NienIwcy8wVUxEOGRJc3YrY3VWcmtlc1BM?=
 =?utf-8?B?akVGMHdOUy9lT0Z2ZnNMT2pDSTQ0eEFHWkIrRmovWVQ1NUJrSmtpUkxCZXlT?=
 =?utf-8?B?ZU9SRmZIMk9TR20yMmVtUFo2NEFrOE9Zb3p3emMwVHFsK1RJZnVSY1ZzaEhQ?=
 =?utf-8?B?WjRhR3JhaXZZMjFJRHZSbXVkMXJxU0RvZTFkMFVtS1dUdW5LbXVnemkzY2dD?=
 =?utf-8?B?ZkhFWUhWSHhBcEJ5b28wMUZZTVpJd1k3TkV5OHdKR2premx4RzdWcUZWSkVP?=
 =?utf-8?B?VnBaa0dlM1R2YkR0TXBvQm56dzRuSVhOODV2dHM4YXk4aXJJSWorb2M4RnZC?=
 =?utf-8?B?Q1ZjMW93VTNTRzNaUWNDa2dvM3VDMGVKME9taEpDWG1CZHBPUEJmaGZyTjlw?=
 =?utf-8?B?d3VpNmRGLys3UURyUXhpalhaWkF1eTl1enNuTWpWUTRwbGtTQ1NGZklSUElo?=
 =?utf-8?B?ZGNMUWxoR2lXbnFSb05iRVB3WkRRbDJmVnNUSnhmRUhEd2hHbWVVTmNyTGVI?=
 =?utf-8?B?dElqdjJINXg0UkxuMnJoTmpkMURSbVNRbGpIR0Ntd3RveUJrWnR0aHNadE9x?=
 =?utf-8?B?QWVtSEpEenVMVzZHdDdGN2RlOTZHM0JHWHVJemJMK0paVUh5LzBjZ3pyYnEr?=
 =?utf-8?Q?8K91DiS/bFUI4DvgGRUPuCG7z?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc212332-9cc1-42ff-c110-08dcb78e8529
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 09:43:12.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44UV0NbBpFx0ADm5sv6sbMXgSDvLz2xMMimvSRuJ6OJzKbGZI99M9Y8H7e/eqB3ApmAvEoMdyGETjekJfwSK1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7028
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Aug 2024 09:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16762

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=8&day=8&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-01-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
  limit date: Fri Sep  6 09:06:02 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
  limit date: Fri Aug  9 07:05:27 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 10 04:51:56 AM UTC 2024
  limit date: Fri Aug  9 04:51:56 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: **Late**
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Jul 26 02:12:55 AM UTC 2024
  limit date: Sat Aug 10 02:12:55 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jul 10 10:22:07 AM UTC 2024
  limit date: Fri Aug  9 10:22:07 AM UTC 2024
  Status: On track

