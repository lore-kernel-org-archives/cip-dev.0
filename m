Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD4EEF309
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 06:05:10 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38329.1772690706292353624
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Mar 2026 22:05:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hwvNLUjU;
 spf=pass (domain: siemens.com, ip: 52.101.66.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2MxT4GwW2bPwBEQzjyH5p1W8nBSStzM68jifVWbw1jD6uiH28LtWYF91dQj7nlxi5MkJJTsO5qxGypgHSwozJ1ege958BN8oJzV2q0/fjONdn1V2CguvvImW7EM7JbONOVTIO/mvxl7Ob5AuoipgLjjQ2SnP+Me6lrEZC9syKT6Q/7FHAZckp4aPP/bn3iwyXSsRJU2fe0rVi/l7pg4A50wu+mA1wkUTeQn960hmJpCxwHSfiSKTDq9qbzS24XsElbTwKdki0Kr6WfWzclmstEyhaaolvbw1Mel/bGzhkGulOUFexsO1qjEM/VCzQhdI86SoXDLGc46FvA3hW7jkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9WagMiTKNdr/q3NlcPrfTYprrhjMvrWET57tMpBsLk=;
 b=M77VlineiHG2gsYmJ+CdIbtdnJkB219miwYq8xXAzfg9Rq7NJigTK6CmwN+RPNXQkJ4YZ6ByyIQ39una+a/sE/BgXsxjgbzBqrlwnHlilTCy4cdrt3HDBnqICrvY6oXKAFMV3evdEcom3vis7UpXR7m01k/rLmMzzLbR5dlarfex9OYAmL8YAbM93UABlmXeh1ltuIzfZL8uiOtPtx7tPwIPgtpXWSL4WBU+aSJW7RIWB+143AARDobCoqxmcE11lWXAuqSRi2QBM/mdo5HTWLa1pVNEP0pHyH9W/yVaA2pwLhZW02GIg/IvsMvFT+O5MQr44So4f+izFvmbSpSVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9WagMiTKNdr/q3NlcPrfTYprrhjMvrWET57tMpBsLk=;
 b=hwvNLUjUtQSB+Z3de1O9j0THIBzIic2XNCBhkNEMICP+TG87fzf5Y5YSVH83XZOotKFyt8FbsUZfZdHIhua2nscsZb11lK4bGgUofBHwmFSd21B02IFFLPg6hXLK+0KJ/P8wjrjgr84txOa+z302y+YD3D1tqhQZcGa7PVw6d/A9ysirDkkv32i3PhHhYQotMa5o3UEF4J9YLvlXoZru8rP2gKRmJHyzNOBhlmG0pTcIQ3eu0QxufY6rvWWQz0qmE5TeTOBVdEyX/anxMLjHSQJeTGZ/6606hrLSRMHro8puufGmkpu0Dc80gtYxDOKHQF/eq9SSnjNk7+cM6Y9eow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 06:05:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 06:05:01 +0000
Message-ID: <7231117b-e350-4f03-8f3c-1dbeb4dd5f37@siemens.com>
Date: Thu, 5 Mar 2026 07:05:01 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e903664-f56f-468c-f422-08de7a7d235c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	BqGvxYlgXQMhoX23groqjUlinHA5rz5UsuoLlcuOgZ7hR4SzI5lk23HXQ52hQfHTRE82iag37VQLz4CmB8Q+i/fb/fI+Ix+eL8tj7tMdOM+mXtjC9Ss9bLhgUkPlhO0HzwkrDOjgfpMyST/kv83IvOv9639Lfzj+WqOp8SreRhyggFFeFOk/1y5XUmSl/PgmWyo++mZs5e2XnnLm5sO6pIgKWCgapVyFomN5vZs3afZsWPKPHoc+f6Pea05K+IM6PdNYU24oHqx7b6n7vseoBlz2+FC+2pFvzqE9jAs4iSaqONeYSusWNBEp5p3/lsgWhFffE/Cp6bFFaxg0JpnibY00aSUBWSsWY2wytRlepCz4RPkG/EWgovKWKrCey6ytcDW2x0L/g3Dp3Fb6Kk74Jc372e0PjPFuWAOKoJVuqq2lDbjdwYqD75+Fu019TLoM9LGIDVFZ1NQMb2KdCf2MC7OXBMCOP4eaJJsfbv2F2dKbCnKu4qClQKeSwtXgX8/tvUtE0boNatqx6FKrqTw3ptj0N93HDX2rDI2rXocMawF6rJFQF4phmk5Bses4rpYZt4CYMBQuPJSgSAkbNZnugG0UDWk7F1e2Czbj/RteFU68t3ERRr4N9JYZczO0HXSbQLUcbaM3aIQmkWanq+GUPNYt/kL5f2xqSv8VCOXOEhFUNkHvj+BZsHhHqDkg5SXU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVl1NnhxdWZ1Z3R1WXB4S2N1cUJNWHF1VW13aHY2aTJYTzFQdUJoczJnWUVn?=
 =?utf-8?B?Nk53akpVb1BLVVJEY2w0TnQvQURhZGpDNXUwbGhuMXBZRDYzY04xcmFxc1Mv?=
 =?utf-8?B?TlJuajRtYjBLREo5cDR6YjVSM2o3Y0czeFJHYmExUFNNMUNLSlhpeGJrMFdT?=
 =?utf-8?B?S25hYWpiMGw3cnV1cElCSldJcWhMVENhbjJRb0pOVHZSMkUvNXVReWFESGh0?=
 =?utf-8?B?cVJYV3E2WWdWbDhsWjNkTU9YZlpMNVlZMGozanFPaWRUMzk1bTc5MktVenY0?=
 =?utf-8?B?T0ZHYnVaYkYvSFk3VzFxQmNyMWF3UTFneWlOQTM0Q1RpaU1MeWI0bFlHbWJz?=
 =?utf-8?B?SWl6ZDdlV21LMFBoeklSUEl6T2crRytaQndINnFtcFE5Vld3ckcyUHora25C?=
 =?utf-8?B?ZWY2QzR4M3M3aVVyV3JXYUVTQ3l4bVZtWjlPTDZCRkhRbUNyUEN1TzlmUVQ4?=
 =?utf-8?B?TkdIT0tzZ0tkbU93dkt1Ni9qaURRMjZIUEdiQjB4dzY4K0VsbU9TNkMzLzZj?=
 =?utf-8?B?TWJRSncrZmNObVdnTHRUaVZ6UzBZeVBhV254KzdOelFWdUV3NEg4THdtbFRt?=
 =?utf-8?B?NjZrT3FmNVVtaFpseTlJTjI3MWtQNmRLUTIvYjZ4M3lmRU8xMktnbWJqWnk4?=
 =?utf-8?B?OXpObHRFQUZHYkFRRm53anR4Rit4RTBlMEQvNkVKaXNNSXhZQ1RHVlJSai9q?=
 =?utf-8?B?dFRjSmpDeXhlYk1Da255S2FGYmtzUVdyb2dZZE5TTUlCVTBuN0hLRDluRytV?=
 =?utf-8?B?VWVidzE3SlZLdDcrNTMwMnJtTW83Zklka3piNVQ1NXppVHI1QTVoM1dKWXZn?=
 =?utf-8?B?YXpVOG95My9CVnY1dlBCVklnOEFGS1NHeEtTbjRyWmhpbDlkLzZwVVpxM1Ja?=
 =?utf-8?B?TUN4RU56eDZOZktzY0E5UVJVWFY1Z3pTbittS0pFaXJ0LzFtS2l6SkVVRmlT?=
 =?utf-8?B?NHNweWhPUWE3ZlgwblpPNUZ4czQ3UHM5WlZ0T2dseHE0SGJkdmtYRDJueTRn?=
 =?utf-8?B?UkZzbm1JdmRJUnhjZ3NDeXFxQ2lwaTl1RTBUMkxiU1JkNHZSMm1wN1VRaGs0?=
 =?utf-8?B?QVkweVpmUjJLdkF2d296T3B1aDkwQWdwNlNObVJtVElJZnJ5QmdTbHVhcXEv?=
 =?utf-8?B?OFdIenE2REIydkhwVW80TVNDR2duNXcxTHgwUGUzNGdoeitOZU56cksraWJ2?=
 =?utf-8?B?aVgzOXJEZlpkTUR0RTk5WW81SFRiWnE5SVVVZE1tOXBORXgwZTdWbndvaUFT?=
 =?utf-8?B?UldiVXNZK3pqUGJ1a040TjRaQTREZXVFNW96S3ZnTUJVL2hLcWFDa0V5WDB2?=
 =?utf-8?B?ejBvbDYvcE1tR0JlSDNVbUlKRGlVb2tWMndpbHB3M0Q3YkxuMDRjTmtmajFV?=
 =?utf-8?B?MzB5aFlua1E5NmFack1jUkMzVjlxdittVjMza2VjT3Z3c2o5ZGJ6YjVIbFJC?=
 =?utf-8?B?VFN5OXpLWFJMNmcwZlVkejlLZTBsRnNWWDFpMDZkTjVCbXB1OG1SK3NkRzFu?=
 =?utf-8?B?SG55ak12alF0N2h4VWRhbDBVVW5NOU55d2pLdmhmazlZUUdUdDlZZVRjQ1BE?=
 =?utf-8?B?aW1PWXA4NVlCeG1QZ2pqZldqRUx5K21waVVvZEs3aXFPR0ZNd1FFNEdSQ1dT?=
 =?utf-8?B?MEhSbVVWZEY2MlJ5YUord1JuUlFIVmlDRmxCUlQxSmhteGtkemxkaTRvdFMy?=
 =?utf-8?B?VTBuR3QrYXpSM1hLbTFDTTcwYWZkSjBGN0lIeC9ac3dEK0hhQXhOaTQ3YVZa?=
 =?utf-8?B?RllBdzB3ejhFS01SRzdZZ3orUGdXMmRKYytncmt0VUMybnBQVXZwYzlTc3o4?=
 =?utf-8?B?aXRQbU5GcEROKzdZaXpkLzU2cGN3S0ptSmVTWkZ5ZmNRd2s0RXd3OU5GL0kv?=
 =?utf-8?B?ZVkrdXkxNHF0elVLZXRQODFmRGlPY2tZMzJCSThSbTRmVmJ3MTVIQ1RaeFNl?=
 =?utf-8?B?dEtiNEwyNGdZaElEUTBnaDQvVVJ0VGE1NVRoNnV5UnN2QkpialpGMTJjc1lT?=
 =?utf-8?B?ZGJ6OVVnWXJTbzVPZE5oaEZrTVB4dmlpUEJ0elMvNCtuOGh6ZVNqeWJOMEpy?=
 =?utf-8?B?V0dRMnc2a2RuZ0lGVUN4RkdtVXFrK0JIaHUxM2Zwb3RBZDlZZzd1QWxoYzVm?=
 =?utf-8?B?NFZ6b2FOSjJ2SHlSTmlYRDZBSzdzZS9lckhSeWphZ2hHNTg0bjh4R21xVkhZ?=
 =?utf-8?B?MndtOXI5TGppOXlySVdNYnpRdnV3ZFE4ZktWK3VnM1ZVMFdGVWpXYkpzdTZ3?=
 =?utf-8?B?VXNqN0xUbkF1VGkxL0d3UThXMnRsV0ZhZUhwU20wZFRtVmVPOVE5MG1aaVh4?=
 =?utf-8?B?MmMyWks0dGRpdFYzbXdXYjZMZzlxR0Q0dVZNaU12UUN4VHNDYVNuQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e903664-f56f-468c-f422-08de7a7d235c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:05:01.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08UgqsuMOHfEa3Vlk90tcS5xYgw8vtbvXiWmPUcfYFNp/5F1n+kHDsk/In2itw7Pe1xFa+6SNXkfIRWZmUJueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7290
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 06:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22073

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=3&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/02/cip.2026-02-26-12.00.log.html

* Action items
   - enhance wiki around board support backports [jan]
   - provide kernel config snippets for lockdep and rt [jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Mar  5 06:04:17 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Mar  1 10:52:36 AM UTC 2026
  limit date: Tue Mar 31 10:52:36 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 23 03:28:28 AM UTC 2026
  limit date: Wed Mar 25 03:28:28 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Feb 13 12:33:43 AM UTC 2026
  limit date: Sun Mar 15 12:33:43 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Feb 24 08:55:46 AM UTC 2026
  limit date: Thu Mar 26 08:55:46 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Feb 12 10:21:35 PM UTC 2026
  limit date: Fri Feb 27 10:21:35 PM UTC 2026
  Status: *Late*

