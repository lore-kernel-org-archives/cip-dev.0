Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96837C54E65
	for <webhook@archiver.kernel.org>; Thu, 22 May 2025 09:30:18 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.20125.1747906209301903028
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 May 2025 02:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zhl/FEaG;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9RQNJxJujT0q2Cj4uzM8I10eQ5ZvxS96Zon8IXWcb+FJtAjqQCtxCASjKYky5BORzbGJoBdlSdTQyndANya5XvA0wdiMJYYIvm1X2ZRiIvy8Cs1Yze/t41LMBxULUaQzm6v8BmtfRIfpgZk/lZSJvGvlK9KRwqX9MAJqjQTLb19UmZ+KrXam9DBeyHedXgYYIy2rf9ewzA6yrgVcVNf0Q6Vw14ZS64tTvE9VYTbsZ1Qv5V++u61vX1m+NYl73TUxh3T9pCTnzhDyIqwt+DlPXcv0wFyhCJIgz12riQQqcIdcuIRkjTZxyIcMsF94qC9vzAg5tb7yaakHEUqjFybwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLAwxl3cNAET0lvjbRwmjRsiie7QXqdZCGYmUxS6dsg=;
 b=RZZtwtaOH490qfTQ/D5ruTmMgYl+9Ng0rcu95P4jfqlPKgcL3o0vqCWBJvaUtLWzpkepiqVeMK7XSKus0GRbVTmletaCD4sG0B0+zKMnLC3vz+2FzUZJ675F96qcz76VZIM5ElhJggg8qtmH9J1tA9F4UitzbG7iD+DrBRxsBGoOFUjgPdan8dL5YqnMKgoEhFk46nHfXZ61A2Dtj4ZGd87qtFR/ZgzQf/wWTM/431GBghYLnd1pnAEs9rH6PlUej4UTBlqSAFHba91bCk12Iv2Nse5oOeOdT4YI9pZsTAN7+x/WKrpH9DHi/byEFxHZwTCS38rzKM2BkD5xko4UUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAwxl3cNAET0lvjbRwmjRsiie7QXqdZCGYmUxS6dsg=;
 b=zhl/FEaGPA2Mf/XvCQaQKG96PJHteossMdBWQsvJBYPl9DxZxXc5oR72ZEO/N4AjlIyWVtKcyY4wtQBcOPcDuqi9w2m687QX9HPK+QjTtX0spxwdBntug+IEyuCafuiEoyRQ+tRifrGuS/NTzChqUaU1664CwJEUxHUCyGljCCH7l/zOzf8t7l6QeUuMx1UEdzZ/YkwcIBc8dAejwuoIxrTJpil0KMqSVrbFjaInXiOtMhUEoWuB7NiydO4p3aYTYILI2omLi57N+AwrLQjcmz4tDBoAFB8bkd262kRUNqxLNawE6qUKn7S/yDdmMp8guyLY4kbNWx1u54Vl9QliSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 09:30:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 09:30:04 +0000
Message-ID: <f1eb3318-21fa-4d9c-b9c3-98a7d5dcf0e8@siemens.com>
Date: Thu, 22 May 2025 11:30:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:610:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d99f141-9ab5-44d4-608a-08dd99133bda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlpyK1hvRFFVQVB6YXZNTjluSWkwWXpwU0NHQThROGpjWHp2YVhQT1MzRFVi?=
 =?utf-8?B?N2lOdE1Pb2FUNXk3QjZOdG5QZURjVnh1SzN4ZGRlK2xrOWV3OTF0QTJGdDRF?=
 =?utf-8?B?QTZUOFd5VWliUEZtVWllYU92aCtvOHlySU96aDFIbGpWWkx1c2VlZ0lkblI1?=
 =?utf-8?B?ZjhSWnZEcEZ5QTlabHZGUG8zdTkweUY4MkpsNm9XcGtKSWQ0K2xObDlnVy8w?=
 =?utf-8?B?MXFmeUo3d3c1RXQ3MlFQRExoTGhCajdteXY2ZGdodWZnQm5wcHFiSnVTQUt3?=
 =?utf-8?B?V3BmcWhoYUxpTWlKMDRLN0FHdkloSEJUTWwvZDJFRzJiUWN5OHhlYndqb05m?=
 =?utf-8?B?YlZWUlBUN0wrZzhET1dobzJIcWJVQ3FFOStpY2VOUWp6WGhadXJiYlJUbVRN?=
 =?utf-8?B?WUpEdE1pTVF1MTdORXowNXRvaXNjcytCa1oxVG4yRVQxWkdjdXpESFlzRDZE?=
 =?utf-8?B?V0VkNDdIa3U1c0psZkRTNUZqSXF3OVd6dmIyYXFJNGczODZnL1RqVDNtenFT?=
 =?utf-8?B?RVhpdG9Kd3plNG1TSXp4NnQreXdEWWV5VHhKU29KQ1BSNFdYblhIL2JSOFAx?=
 =?utf-8?B?Q2tEZTlpNWxSdkppbm1XL1dxdXJ6bXlZQUF2L0thb0lMSXhlRDNWTjBaTGVp?=
 =?utf-8?B?MUQ5SXdNazluZHl6SkJDSGRURURNYzByMkZQTllhYzZsczN5TkcwdTd4SHpK?=
 =?utf-8?B?Rng1Sk02TE9KSlE0NFM4WkNKK2RiZFh5T1hHRlljQ3hZc0luR2Zjcm1Ydmg0?=
 =?utf-8?B?NHFWSDFOZDRva1dJN2twNnFaQkhNVEtFenEwNjJWaGdHTGR6c0JuMUs2RWtr?=
 =?utf-8?B?ejRGaFVaYVdBY2FpMnVNbW5UOW51azNXYXZ3aDdXRFNWYy9KTHR1Z3EvTldj?=
 =?utf-8?B?THBGVXZxNUJYTUpBUXdXcFFGd3ZUT1NiWENtRi9HRVlVeXZOVXkrS0JDSk40?=
 =?utf-8?B?QzFpd1pRYllHUGwzeXd5aWVwczlrQkswZElvOStMaEMwZkNPMDBDNGdobGlt?=
 =?utf-8?B?Y1dTNXRPYnpwTU5oSWU5K2IyL2VXczVoajMxbVY0dDd3dEFyZ240NmJrZk9Y?=
 =?utf-8?B?dWo2VFdFZm53Y0cvdE9XTThSbEl1QkpxMjZsdjV5L2U0NUIxek5ZSWpZbllR?=
 =?utf-8?B?Rnh0TDZ3MEVhWHpES1R0MFV1SDA5NWkrQXA0ZHlKZU9xRDUwbFFlWUVvanZM?=
 =?utf-8?B?L3FUSHRmY0J0K0MxNTRQLzZWcFVVWTBjYS9vdWtPbXkvY3M1MHc0LzRuYzZW?=
 =?utf-8?B?S1VleFA0Q2wxdzAyYlpUZWlMclk0T1BKSW8yTlhCWHZDVWY1dDhnUUpud0cr?=
 =?utf-8?B?a0d4OGorWU9keTJ5YmlCdVhrQXNyYllzVG5WOEdNUVhqS1FlVmR2bnM3QlZD?=
 =?utf-8?B?MlFUSlpwVkJoMkYyT1lmUHRNdk9BWFNpaXI5bUdjMkJMRGhwcXJiNnBucmpW?=
 =?utf-8?B?WlBROTBPZEV6WVZZR3V3VEh4RmNtVC9mck5oSEY4UDBOenZjem5JV2tiYXlD?=
 =?utf-8?B?M0k3TXpabmhjdDQwMDRrd1lVbVozQWgxWk9PSlBhOXNSQ2RUUDVDR2FlNGQw?=
 =?utf-8?B?NkxEYmxabkpqdXFnUko0aEE3NGVxcUw4WXNQUHUrN0tjOFVUb0NlakhpNWFS?=
 =?utf-8?B?cmxHNW9vUHpQRmpuNmkxNnEzeExzdzFIeW1zbHk4T25EN0QwNXNWQzJVQ2Nr?=
 =?utf-8?B?MExnTEh1eVdSYmhtQTFvSTRHV2lBOE1rZmlFQnhhQitzS1NjTkhwU1pLTkhJ?=
 =?utf-8?B?SFk5cDNmc2JieFpLVndxMEtVa2ZiR2JSdTh0Ty85RVN2Z1hUV0VJeU9OYUhP?=
 =?utf-8?Q?qpZoiG6L3Sbcxj6MjM7nZPD9Fsh/NIDtuMggw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0svNk5IOUhMbElxTU1OSTZWcmF6Qk5KbllKcTkyc3QwV2JTbHpHYWQ5eHZ0?=
 =?utf-8?B?YnhoQzFPZ25yZTFnWXlaWkUyWjN0ZEZleDZzT3JLQ0wvNzd4eER6bmNpWkdo?=
 =?utf-8?B?aXU3elB6Sk81S0FYMEdqbmg5SS9xcElHUXN2elB2RnFHM3BtNFlnalVSdExk?=
 =?utf-8?B?OFhPV1pDOFRIRXdLdndMdmNkUGpTdnBKNWZCTmdvVk9TcGUxSStTVms5ZEtI?=
 =?utf-8?B?alZBVVV4L0thUUhZeXpYeG51a3hxa3NLbFg0aHh1bVErU01MSUpJKzhzTWdl?=
 =?utf-8?B?Q2g1bnlQT0FKODhoaDJRQzdjOThVMnk0T0VoMFhNcG14eVRscWhLcHZ2Tllq?=
 =?utf-8?B?WVYvSUFBa3U4N3hqTEtnQ1ZuRHFxUUVMZmdtZTUzb0JNaHNrREF1UTFTcUxQ?=
 =?utf-8?B?V2YwQXpCenJTSU51L2lKYXNPOGZZMFRXTVo0d0VoR0Vpc2lrWlRLZ1hDZkJv?=
 =?utf-8?B?RDFOUzNEZHg3M05TRG81WVltZkdoa1RvbGlPUmtzWFQ3RldzeXNITHU0T2pm?=
 =?utf-8?B?eVdWeElIUENlTHFLL2x0SXN1V0V3aTZNVmdsbzBlN0ZjeXJER0Q4WmZ4SlVp?=
 =?utf-8?B?Q1lDVFdtVEFRZ3hnczVkblpCVjVpblhZYS9PL1N0NWp6aU5RZTVjVjhkR3gw?=
 =?utf-8?B?cjFTZXVzSExndUJaeUl1KzRjNWdUSHArYy82ZTc0TTREN2o5TzRWdnI5Q2FO?=
 =?utf-8?B?eDcxWjMyS1hpNEhtbm4vS2FtTDRMTXpCaFdGeVZPZDVGSE1pOC8yN2hlUlRl?=
 =?utf-8?B?WFk0U3FHbzV4WmJLNFg1b2piUDR4YjUwRkVaYnNqWkcwUzAweFEwVTdQa1pP?=
 =?utf-8?B?ckFXTjhVNHYxS254alh6Vm9sSEduUHFTa0tQUXlZKzBwUlZaUFlta3YrbmVN?=
 =?utf-8?B?NHVlWVliY0JHOVlPZ25QcHZnV0lyK3dWVEtIaWhUenVHV0NNcUFQQUVVVzQz?=
 =?utf-8?B?cU0xalFIOHM5RTc5OEplUUlNZ0FxOXp3bGQwaTNwc1FMWWJJSHN3eXYrZ2ta?=
 =?utf-8?B?cGtTM2hmT1NmaHhyQjRqZzBCcGgybk53dDZRT0ZrM3pBOUlna2ZOTXZjUkl2?=
 =?utf-8?B?Y1pnZDJwOHlwaDdYV3NHemRmMXcycUhZN0wzMkQ2ZVlTY0tuSTlNTmZjZ2Z5?=
 =?utf-8?B?eWFxQkUzdG5qVXNBQlY2VUNCSVBucnQ2NEU4NnpwUytqcS9QeXJoT0htTVBF?=
 =?utf-8?B?NEpwYzhYcDk5bHREWFovT2xZRmc5QUd3MGZsNXpLaldmWHZrYndiRXpIb3E5?=
 =?utf-8?B?b2FtUTNuNVpzT0dCUUFJdTk2bnB1b2FkVEFlOEg5S3lGbU5ZMzFqYW1oYVFv?=
 =?utf-8?B?dS9IbXlyUlh3enRtYTNIdWdTbm5nbUtaaWNEQS9NL2RrNUVoNmlSTFFwY0x2?=
 =?utf-8?B?RlMrUFlMek02elcxaVpYQjZYVTR6SjNGZmp5ajBHR0VWa3BtZHVzRWpxL3Fi?=
 =?utf-8?B?MVNQUVNIZnFacFBOK0J5R3hydEFieExsUkFiUjBJNWxQUzNRcmp5ZHpJeUsw?=
 =?utf-8?B?SnU3U1AyT1pjYllKaFZYSHI2bFp2QlQ0eVRJUWU5eW15cUdJTFhxeFdZNCty?=
 =?utf-8?B?a2wzUXJRMlpPQkNLY3dka09EbGpsTWQ5SVJTdUVLS3FUZ1NpQ0ZtOHpQTkI0?=
 =?utf-8?B?SzNHMmhLZ0RmbjZjWWJ3b2dyd1d6UFBhcmxsb2tyUG9zWkgycVN4MCtPY0lJ?=
 =?utf-8?B?TklEd041WTVpczQ1SXQxWjZ5THc4ejlvQ1lINExkQnZGZUJFdnJSLzdLakVh?=
 =?utf-8?B?aXk5N3lNZy9ZRnhjZ0xXWk1SZk1zalhGUmIyTWJNVlJvbUFKOXVPNFloVjFK?=
 =?utf-8?B?bTV5TC94T1FCY3pVYXZqQzJDdUo3MjJobmJZb2JnQUJkZWhjaUJ6eEhrRnkv?=
 =?utf-8?B?cTdYRWVQaEVtRm10UFRoUlZQVzZRUXNHMVBVTHJUYTBxZGhNNERORjdqVGZl?=
 =?utf-8?B?V1RvYlNqZkhLcUJyeUhybERZVDVLV0NCaXoxYWtWQTN6QXRYWHRuVjhsWnho?=
 =?utf-8?B?dy92YkVhVHlJNFF4bnVHcGltcHFsVnBBKzJSYW1RQUdudzZXZ2xVaEtrOFd6?=
 =?utf-8?B?QlBvVkZ5dTdYZ0Y4aytVeEZ2V3kzWE0yOEw2U1Joemo2dzhjemp0MWhnLzNx?=
 =?utf-8?B?UTZkNTZsVHRvNEg2UWIvV3BSVTVVa2NKelkyUE9DalRlVks4UXN6Z1VwUUF2?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d99f141-9ab5-44d4-608a-08dd99133bda
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:30:04.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yuthq+qdeUt1ujXX9xv3izdtZJdU/2vDzfgzctMcAwlwcTXZvRggAhjsSX1nadDRiPCTW2C4nq7Cu1u4dpZ78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6131
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 May 2025 09:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18937

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=5&day=22&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-15-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu May 22 09:29:24 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu May 15 09:59:23 AM UTC 2025
  limit date: Sat Jun 14 09:59:23 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  8 10:15:18 AM UTC 2025
  limit date: Sat Jun  7 10:15:18 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed May 14 09:48:14 PM UTC 2025
  limit date: Fri Jun 13 09:48:14 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Thu May  8 10:21:06 AM UTC 2025
  limit date: Sat Jun  7 10:21:06 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue May 20 01:39:35 AM UTC 2025
  limit date: Wed Jun  4 01:39:35 AM UTC 2025
  Status: On track

