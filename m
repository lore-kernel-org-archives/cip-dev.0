Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9916CAC5AA
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 06:02:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.26])
 by mx.groups.io with SMTP id smtpd.web11.4850.1758780121466171730
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 23:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fKwWbsFD;
 spf=pass (domain: siemens.com, ip: 52.101.69.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysCtzPu6nmxQ9asz2zOKaKu3mm8tWOBUDdcVw/wGwk2HLTqqigsd8Ezrr27ATtAH7+k/ckW8vOLUk+K2hj5RJ2MpVFwS6FgucvK5PCEbTlGqGUfRykarJxXEVZ9t5GqwfQ9jXhOU+x04D1ds8NTxLpL2wd/JPjYM7xSbhGKjayxSUdx4URqnmegcb/ksNKIRo61IuB3ZSDzE2iQ9V9ZZsmi9KNc0oBlXecdmYmbY5IaVSwxEKf49/MwfpnGJ8VltxFvaYBiLLvxIVisXJqHMwvFOMWo9l9dlxgvdkNKuwL7vqIerXCaMS2tj8m4hT5hMDjEtPupjrbNqoESuaj27hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeRBbsBVNbrT3abveTK0Pic+nVzVF6zpeG7dZ24QJgg=;
 b=cqk4A104KPsq+6IJRleOgGrpnEb9EFrIOzuo33ab5vqC2odV7PrItmOcxWrlhnFZGU7iLXFtcyJYiXef0NzuJxvAdU7pwA0wHwjpBs6BAitQUdTKrFVHadMG/GQ/fh40ei3v/m0/z+10Fd+6AXPPjx7JhhSpoFGCqBa3nccX4HkcUoL4DrYqrbxTlu+peQsY1qXkW1yI4VPFfWHGhulr37Nn30yDjL24Vp+eoXlCduH3VmF7PBmuQ8hAFJqMm10+1Hk/IZ37PHdurjgxjadmJErLlQa03HXCXCCqwfxeen92TV6AC0TQYB9TC//kZXNv0Ti11qDaJBIMlYjCh3A3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeRBbsBVNbrT3abveTK0Pic+nVzVF6zpeG7dZ24QJgg=;
 b=fKwWbsFDHPlrNjf7yIsQj99esDwa3xw21d0HXj7vavkrtHo8XI5eQV9Uei+bDk3vbxlOvVnR7xVOYfgd6u/Ef6gWleM3cx4CiTw23FQ4YXHkjIkCPUsK1G4jXSfkoT4sMnWrN1KvyZlmvqgfjVO/rJTdlHIIp48GZugSbeSCfr9xAmlU/AFvAIo2l9COFxLfOx2Emedj29zTnLHBGAg+dy8jsOqjkEBBSU5PlI/SeOhQoDkk7P90c+oDc51Vk9DFMFBe8aGYLUrSXm88ojcuYGZf2GdZHVjFRKD6vWNVh28jlsXlDe4JuCQBT1kjpnQOKo6L1vbm5aqlxDBvmbM34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 06:01:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 06:01:57 +0000
Message-ID: <b64abe31-4e85-4669-ba12-29ca0703fdda@siemens.com>
Date: Thu, 25 Sep 2025 08:01:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 139b16e7-7eb8-4408-a867-08ddfbf90945
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R1VxVGxlV1NmYjZjN29TamJ4cDBaeXlKdnE3aFRyYWV5L2xCb294VGRmTElx?=
 =?utf-8?B?dGVGakxlallqWU9NaWxHZWh6Qy9pajkrOCtnUlhjVk1NOGdnaTJCZGh4bnZ1?=
 =?utf-8?B?Qm53cUxSbFg2WEx0cU55VGlYWHVoSlR3T0JkcmlYcnVUdCtKa1dXbmhwNUYw?=
 =?utf-8?B?WlNXcy9qYnRKT3pFaU9xckFOUGp2NlhaWGM4b0ZjeVI4ODNQanQwdU9jOGM1?=
 =?utf-8?B?WS9FRGZpUDR4Vk8yb01VZnBqUjBweFVDWVZEQXlUV3NTaVNXcnc2WGNjdmhu?=
 =?utf-8?B?UW1GSTZwZFpWWXQyUE56UkJGZjV0MEduSHptdmdSTnlYdkJabVVDSVp4N0pS?=
 =?utf-8?B?cnM4TEpvVHNPZ29tR2U2TkY3UTQvV1JVS0tucURkSC9RRm10OHgzenNNVHBo?=
 =?utf-8?B?Q3ZleGtzdW9sSlEvOUZTdVk0NVBvRkRtUVRWNThtYmF5S0Q0Sk0vTTJCekJW?=
 =?utf-8?B?cmlDUTZ2ODlwSThzYzd6R1JWOGx5U3hzam55Ujc1dk55aklmVk9HSmVyRHdO?=
 =?utf-8?B?aXRLZzgvVzlXdUM0ZGFDdzVIMGhKRVdid2NRWEE1Z0cycWxqK3ladGxTbXJu?=
 =?utf-8?B?RW1mM3J0aXJvdlB3Y1hrOXphaU00OXVBSW5WQ3N3dU5uTldIN3pVRVFaUGUz?=
 =?utf-8?B?dEFlaUVYQVZmM3JlMFRKS0xnWk44eFFQTnN3bEFRMW1TSXRPRDFHZXRhc0xV?=
 =?utf-8?B?YTQyTnBRS3Vic1NMMFBUNEhER0ZGczhka3NScHpGMnZ0OGV1ZkUxK0hzcmZL?=
 =?utf-8?B?UzJLYmFVLzBMMExCazY5a2hsZy83cVZiVWFGV0w3Ynplc3VleWJjK3BSOFdV?=
 =?utf-8?B?T0gvdmdYZkxLSE1Fb1laZFQ2ZjN3SFZsaG80U1p3QWFsSkFGaUtXUWlGMzJW?=
 =?utf-8?B?aVhtYzcxQ2F6SWZMcXhpMnFHcXZLcytmS2VwM2NuZ29oMm55aTVSeTNHclpW?=
 =?utf-8?B?YkJ6dlcwcmVYTGY1UlVpQlNCZE0yN1dQRmh1VUpycVpJV3JTY1lVc2NNMHFv?=
 =?utf-8?B?KzZLVGVSMjJ6cFkrZ29qMGZMKyt6bDlRTTlUbDNhNXJVdENyUHBFOGdlbjVk?=
 =?utf-8?B?RDEzYkhXVTR0YTEwOWkvTFczcjd2SStzYkhtajc1RWR6NDFtc2xPbGlBdzBN?=
 =?utf-8?B?Mkx2YWttS2RRWVYxeU5HRGpIdzJpRjEreXR1NXJYTzAySGt2UmkwQjkxZ202?=
 =?utf-8?B?RzkrZ3NIN3lMeUsyV2l1ZVR1eExtQzdGTVdlWmNmcXprd2d3aXNIRHVyZ1B1?=
 =?utf-8?B?SC9YRnBxeWY5WURYQ1JMTVFhNTFkMVdHcFJ6SWN1VWw0N1pvZHdZMlpPMkpK?=
 =?utf-8?B?VitiekZDVmcyZzVKZ0dvcnQwekxKNUxuV0NhNG5ZS3ZsRzZNbzMzSXFtNTVY?=
 =?utf-8?B?emEvLzgwUGZCWlZtU1dkQ2ptS1NzMjNZdmwxQjNRakxTQlhtcHlVajhzaGtP?=
 =?utf-8?B?c1hwMXVjODZxY29kYmxsdkI4QWNRN2N0Wjk3dDdnRGdpck91TXhtN0Nod0tO?=
 =?utf-8?B?Sy9JV3lMVUdaVk9KMmt6YjhBSWl6eDRNSlM0V0tERzlhVmR3NnRtRWR1Z1lR?=
 =?utf-8?B?RWJkOXdZQzlqWWNVZTJXTk13L0VJRlVianE1U2s0LzRvRXVpbDNpU0NzY0Vk?=
 =?utf-8?B?TnlSODZVUHREQ2RpcEEydGRNYXh4S1k4RjFBOE5RcHp2aVlrbURrdWhhZ3Z0?=
 =?utf-8?B?L1dqbm9JakswSEdGWVluWWR1SlpDWW53ZHRYRGhjUjE5aXBZNEFrV3dSVXB2?=
 =?utf-8?B?Z1ZrQTF0V0NZd3BldSt6TE5SdDJVRWRWUm94K2hweWhRYm5HdVBWU0tvME5S?=
 =?utf-8?Q?MSp5otyuUXdun4rBCl1crhgqM9mf06a5gSFpc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEtqZFgvMVk1Q1ZGWGo1cElNVld1U0srZWZoS0taOWdMc1hCRHFwVWJXNlF3?=
 =?utf-8?B?TXlqZytEVHB3WExSL2J1QXVuN0s5QThEOHViaDc0eXF6VFBVZFR6aGhXMC8y?=
 =?utf-8?B?SlArYmFhcU5EUHJvVkJsYlJaY0F2cnhGQk9TdDNtbkNDbld1KzNJSW9sQ2pI?=
 =?utf-8?B?aHlaczVVZUJBUFp4M24xOHFNTmRTUWM1d0ZxSVlVak8vWm1ibmxnM1Y3bjA2?=
 =?utf-8?B?bmdOMWlUYVhhcWNTWUVuQkxpOXdtVTJIQkFJaVE3UTNqVzhmaTRCMlI0L1ZO?=
 =?utf-8?B?RHk4eWNsTGh3T0ZXak5EZHUwTCtUUXc3anVuMDBnWXRQb2hkK3ArR3BhLzZs?=
 =?utf-8?B?NmxnN250ZzMyOG1sL3kyclJOa21vRXRMbnJoT0laK3MwRWxZSkl1eVRFMEVI?=
 =?utf-8?B?SERMM1oxWkZBeEtISWVUT212bzZjckZWdE0xUVovblJxeTl0ZHA4WXFjc2xL?=
 =?utf-8?B?SnNCT044aU4zQjJKUDNCZmVabTRiWGNaVUh0ZWgzUXd5cEtYVUZKSDhIY2FY?=
 =?utf-8?B?dW9DaDMyK3R3L1ZZQy9uZGlrdHA3TlJlZEN5UDdxUjFJdXB1ZXpmaitxWEtO?=
 =?utf-8?B?d3hZL3lNZjNwZXEwK2hmNWNTNEExSTZtdmhzRGtSSFJwSWM4WjMyckw3WjFU?=
 =?utf-8?B?RFd6VGM5UUdrUGZmZVMrMlhPVFV1emFNakkyRlBrcGpyVHJ6Ni9xaldnYlJZ?=
 =?utf-8?B?VFdRUjRlMlc1cDBNUnMyY3RJL3U5UkFPaCtrNHNsTUhPQ3hJM1YyZkY0elhh?=
 =?utf-8?B?RzJRMTRQWFhseTNraFJSWDQzWXRkSkpxMEJMdEp5NU1Oekh2bVovQ25qQkdw?=
 =?utf-8?B?LzF0Uk5rVUsrQ1BLZ2lFZG91V3Jya3RLWG8vUjdhSUNwUngxZXZyS3UvQ1d0?=
 =?utf-8?B?WGREdkhFdFJubEl3ZmdIdDBQRldiTXlPRENPWWFVV01reDRPaWRCcTVSdFVw?=
 =?utf-8?B?UkZ0MnVJL0Znait2THBtNk5KejAxY2tSSnNJT0FxZmVGWnhTUU83aDJDYlE4?=
 =?utf-8?B?cEoyOGdwMjVYRUpPWVNUVTE1YzRsNHJIbWRvaDluamZzYUtoSm9rR2tKR0k1?=
 =?utf-8?B?RWRhcTFpTEphU3RSaTBJTHdXZ0JnRFVtQlN5bXJ6QkFwd25YUnh0dG45TFlR?=
 =?utf-8?B?bVNaTDAraXVYalpEYklWdnhHeTJEQ2JiZ0Z6SWF3a3ZYbkZtTDNhdWVnSEEz?=
 =?utf-8?B?cmdXZXhMZDJ6M1MvTGZ0dHRQck5tUHpPM2FuUWoyL3NoUG91ZjVHc2xNeUpx?=
 =?utf-8?B?Z3N0RnBmcW40dWdDanVyMFVLaDM1S2lpaTBJN3pLcG83SGRtYVFHUk9VOFJC?=
 =?utf-8?B?WXNhSjV0YkV5REw3clM0cFdJSXdabkRucC83NnZMLzhESTVWQzZFMnNkT3Ba?=
 =?utf-8?B?NEVrcDlGekhaYlFRMk96S2tpNStwcVFrZFVNR1ptTVFGOHh6U1pZZTIrQmds?=
 =?utf-8?B?Y0RlWGovQ3FRNUxQaTg4Vms2WVhmK2ZSRHVyZ3g5c2Z4dWFnUHh3R1hhMmZq?=
 =?utf-8?B?b3ZIeGxBemF6cjNtdUFuUy9mUDcxdkR5V3dxOGY5TUZqb3NLOTBRa25Jb0NF?=
 =?utf-8?B?NVJxNGIwSjdXN05SRzFCcnM0bFZUMTFGM1F0bVF4MjlKcklmMVZ6UHp1Szk1?=
 =?utf-8?B?L0xSdVMweHFyVnpCTVd1Zi92Tlh1TGFnRlMvNHhpZTQvY2lXcysyNTh2bnFv?=
 =?utf-8?B?NlRZTWphc3lOUEtjbERRekxxTEpqaUZyWEs1OGtkeDMwaXNOZ252bkFUUHFH?=
 =?utf-8?B?OXdTUTNFYlNjMUNtamprWlhkOEh3bklXRkgyRWxoYSs2VnJla1ZmT2lub0RG?=
 =?utf-8?B?cVZGc3dVNUxoNEh3Y0dzL2J3QlRHei9DckZ2Q3BBUjRoUmE3RE8vTSttaHpG?=
 =?utf-8?B?MHM4S244VjArd3ZOTjdaR0hwM0piM0dibk5QTmJ5TmVBYnltQm5pcmdObFFW?=
 =?utf-8?B?V1NuN0RBMTJTdW1SRmFLRENYeGIxQWMvUHBUQU92bHYraFhIYy82eGpOaVRw?=
 =?utf-8?B?ak13NUMxRGk5VFFsSVI3eTlLbFIwakllait3L0RBYzZmYVExWVcycTNaSGpr?=
 =?utf-8?B?NEhDeDBtYks0cllKcGpRSzZLOForMktBN2MyVGVaMSsvN0EyR2dqZ0ZlbmpV?=
 =?utf-8?Q?vL5h+NFcVswdlSgcqRF38Ouhd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b16e7-7eb8-4408-a867-08ddfbf90945
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 06:01:57.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr/H2dxXn/FoXlL8/hPNutOfDfEJgBzPZeGinD55D5YlVwDsK4FcsWPK9RXc+pvW2zdfE6cWjuC9lmG/rUPdSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7799
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 06:02:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20130

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=9&day=24&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/09/cip.2025-09-18-13.04.log.html

* Action items
    - start define a CIP kernel threat model [Pavel]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep 25 06:00:51 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep  1 01:59:32 PM UTC 2025
  limit date: Wed Oct  1 01:59:32 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  6 09:10:31 AM UTC 2025
  limit date: Wed Nov  5 09:10:31 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Sep 22 08:38:34 AM UTC 2025
  limit date: Wed Oct 22 08:38:34 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Sep 10 05:54:13 PM UTC 2025
  limit date: Fri Oct 10 05:54:13 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Sep 12 01:11:18 PM UTC 2025
  limit date: Tue Nov 11 01:11:18 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Sep 17 11:15:11 AM UTC 2025
  limit date: Fri Oct 17 11:15:11 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Sep 17 07:30:39 PM UTC 2025
  limit date: Sun Nov 16 07:30:39 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Sep  9 11:32:29 PM UTC 2025
  limit date: Wed Sep 24 11:32:29 PM UTC 2025
  Status: *Late*

