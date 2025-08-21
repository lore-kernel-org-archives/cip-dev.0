Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5802CA0EE6
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 05:00:38 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.31])
 by mx.groups.io with SMTP id smtpd.web11.2104.1755752430121981492
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 22:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TQ2jAAi4;
 spf=pass (domain: siemens.com, ip: 52.101.66.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jggfkvJS/Nic4EMlVsYYwf9IAlCXYwNlOHi1cs2is8lZJdBB1b2VBLy0rh6vJlrr4GRXiaECmIBhTuvJrla8nraoRBRVW5Tvd19TW7TT5jhfY5VLQD1zomG6IjpTlqjvJkRvnSvXVpJpi9w36xEVVw6JmYKDTHXN333/xeoHLhinkUUxXVGoWrhpPJjvluEFoO6TrCI2PWMIXThvQ5saKH7sBIN7RNxUa/2Sfb0O9f2eO387qkvDy5PcS+coQJfIU2A9FR1Q8xPpQPI/kArFKXRjJWrQ8JfOIfpZiormPR9ojz6VBLiI/KTQjYAE3SKNbb4hJZlKlh6eXg++gjKZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/QJVnL/vf/wlZtg4KaInyTpUwA92WxATOaH20pt6+M=;
 b=FVViSTPKVCy0YxaYGui9NSa2SRMYtAVPWoNzoCHUOxbWmNqbZSmVwVS0iUY6Qn1sfT8ZIEaFmlOsSTrnHJuto5cCRsohYNLvBqd2H0eUiDUTFp87iNbQPIoUeDAwSfg5ZELJ4hzgzK45patgd+CBMaG+LUufLxEjWRB5O6gvqSAIILnrzZEavy7xL0zdAQwXBR9REIQTqTzxT63tPFuB6OSl2VcpxJ25WbcmYZ3ckMF9ED1gXJAiSPH3pWO0tvfNj9Qtp8NY8XbjISAY0noOk+h6JUZ9iXOzwW9bSPESZa8KompbFMssQj3D9SYG10bhWuZa5afs2N+bIDGyy1I/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/QJVnL/vf/wlZtg4KaInyTpUwA92WxATOaH20pt6+M=;
 b=TQ2jAAi4kb8zkYhX12nYS6pgtOZTBXdI1ijA3Te3Q/ifodrmJL2vRVdnEljX2hG3CqLnl0WyntAVcd4eEh8q2PzpbGfT3GiOHO4B28sOkrpE9r0bVaNkONE/Z3qL19OQ5QAljUig4YS8XnL8YvZWyoiSChFGrQJW2YNZ8gwud1TfFY/KWLptH6kMkkzmgVb2MHhqtZoXoCWqIbiLYOWPjo0zdF0vAsdaiES+FK7ZTkEtb3Kye7VX1Am9NfC9MPdsPW0INSC8PxTN3QTgzaKcqJfqJP9zHM93HTsJ0qOa2OAdcfvHpajtK+hJQzZlSmYsRtGoyCnNjqVBVmqVYLZ6ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:317::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 05:00:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 05:00:25 +0000
Message-ID: <d87cc2b1-a24e-4609-a59b-cdde071dce3a@siemens.com>
Date: Thu, 21 Aug 2025 07:00:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 4187869e-a4dc-4865-78ec-08dde06fa3dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clEvNGsySFgvQXBwNHdscGo1M1JWaDR1RTJKWnJiQm9la0h3LzRGZStLRGdv?=
 =?utf-8?B?NFNDQit0SGMxS3B1OHZjd29SczFpU3ZuOXFDamFNNnh2bDVZeHppVCtVTmt1?=
 =?utf-8?B?T3VHVWVUVlFtL00rdWp5Wjdrd3pzMWxscGtqRWI5TExYYi9IRFJDTC9LeW0v?=
 =?utf-8?B?T0pVeXlYWXMrb2pnN1JicnRrWHB3V3VGdDY2RHB0WlJSa0pUNnJoK1dtQlZl?=
 =?utf-8?B?VzUxeGJ0TWFGVTNTY0RqcnlKUStSaW1hZGFsVFZ1OHk3Z29pNU93QUZRajJG?=
 =?utf-8?B?VjFvcEtFQjJaTTZ1OFQyd3FWbDltM3paKzQrcDNoZHI5czZGcWxRT1lFZmVT?=
 =?utf-8?B?eTV6ckhwT2lOUkM0KzBqdjNHbnVUYTRsYlZGSll4TENSdmZ4bm9qdkJTYXdN?=
 =?utf-8?B?YkUzTVIrNWE4WlZNQml2cSsyT0VEQ2VCeThFRW5wSTZIUFphZk4vUUgwK1FE?=
 =?utf-8?B?emgzaWFlbWY1OGFad1lHUUlVTnBFZjNzQTdob1ZBUWVmd3kzVGhRVmlwTisz?=
 =?utf-8?B?aTduekFHMjBhVU5BZXlpRjNuMXpqY1p0RkR0M1FVYlg2NHo4Zy9zSzVmdDZq?=
 =?utf-8?B?MUZIczZPRVZHUTZRbisxZXlJZVorVVQ3WnQ2eURjcThOZzIrNFJHUHJRaExz?=
 =?utf-8?B?aHpCNTJoVmhZWjczOU1yS2FvT1B1YTVPQXlrdCtSMWZsTXVHUFloc2JnR2Mx?=
 =?utf-8?B?bk9ENlFhb2ZGNFFYS3BwdHNZRU95QWUzS0FnT0R0dXJMaHB0SHdlakJHTXo4?=
 =?utf-8?B?ZkFVbWVySzljK2VwczNabGZoOG90ZVNGZW5ENWdidHI4VDVROUI3bjJaR2Ez?=
 =?utf-8?B?NlZrNTVrbC9STktnQjA1eFFzNjh6Z2UwN0htbnFQV21MWVJBYzZlWDFjbU10?=
 =?utf-8?B?NlJISzlTcW0rM0lLRFpYd1NNSFBrTW9SS2tWa2YxYktKVzZKNzZXNlJqWk42?=
 =?utf-8?B?WDdZRFhSVnc1QXcyL0Y5RXhLS3BZTjA3VUxKaVJtSmlXYlRHaUlmTzh6VzZ5?=
 =?utf-8?B?WHRsUGhaS0s2S3JDT3U2UXBKWW9ueHM2dlpuSTVxQnlVYVJrcEN0a3NQN2Fs?=
 =?utf-8?B?ZXpvVm5jVm5lWXlWalFsRmZSTy9Jak00MktaWFVYM1hsYlhoSDIzNFZPZHVT?=
 =?utf-8?B?Zjl2OGNFMGQ2bGk2UWN4QmFkQXF4a0dmUHUrd1NwVzlXK2ZLcjJRQjBrbXJH?=
 =?utf-8?B?SEc2RDNpMHlKMWl2NnhNY0xRRDhzY2VzKytTNXRYNzU2SHM4a3hHVlFLN0o0?=
 =?utf-8?B?bGZOazROYm9rKzAyL1hFNHQvVzNHNTE3WW03OXBpQTkrNWVsR2xRZ1VPczFq?=
 =?utf-8?B?akpLaTh6d2VOb1QvZThjWnFkdklkZ08zQ05pUmJGa0FpMVZHOGVDcmtqL3Vq?=
 =?utf-8?B?YStvSHMzOEJrVS9OR1N1NGZaMzh5VFJBNWRLVDZQbHk1S3JiTWsrY24wakJm?=
 =?utf-8?B?TThqUDlnWHd4L2JZWTIyQUJYOXJxdWVoMmxJUkJRR2hLSXUrZWxSYnlLNXgz?=
 =?utf-8?B?ZTBuSmUxZXc1dHd5eFJ3L3h1WFNqRnNFM1Z0cldnVnVGWXVVMUxCM1JtdWZS?=
 =?utf-8?B?S0VPN3pOYVZtS0NORjZjS0cvbkZ0QkJpTmpPeHRtZ1hSbU1hSEh3dDZ6ZGpm?=
 =?utf-8?B?YnJJbXlkSDY0MEdPejRFejJsLzlyOWtDNVJmWEh1VWUyakJZaGM5SkR1ZURw?=
 =?utf-8?B?dVlkMmRLUlV2a1hMOUYxOEZncjlJcXA1alNzeW9meURHTzZ5RzdIczhxb1Np?=
 =?utf-8?B?UTUwakpHNmd0T0phd2JvZTlmNkVXTFgzVzViVzhFekJtdk8ySmtWVXhlQ1lv?=
 =?utf-8?Q?FUFtcqoEWLIkvF+kiVQH30UtRBFBpc/KKfCqo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bS8rZ2ZhY2RIT3RFc3FpdGowMWVGSk8wT1A4TGFZTy9hLy9WMnhkYUNOcm50?=
 =?utf-8?B?UHZONERHVXR5Z1VtSytoZWhRUWRSY2JtVi9MZ1Y4SHRvMi9teTNGM2FXSTE0?=
 =?utf-8?B?SndoNkFQZm5YYzdiRDZnM0lyR3NDQ1pVZk4vVFRJUWdicUdybjRCUzVjMUls?=
 =?utf-8?B?bGxBdExqSkUxVFM0aG5NUWJTc3Iza2tZSmdrTzlyTWg1eVJSWnEvTHNtamVi?=
 =?utf-8?B?ejd2cnVjanJhaGxzSXpYZlBRYkhES1BpNVkwUm1JVTcxeURRU2xZakl1QVFE?=
 =?utf-8?B?dTBTaUJhdjR3RkwwRS8rNzRjZWxKek1QUU85TUlhenM0R0Z2QUJpeVN6eStU?=
 =?utf-8?B?bTJoVHV5T0xhVXRrN05jRkp2V0g5S1c3a0FJWmNSTUN4V1FsditwbkpFY0F1?=
 =?utf-8?B?R1VUWjVVR3FyWGFRc2djMVJPWWpYWEpIeTN3YVcvTnBkZGhEUjVUeE9DVHpL?=
 =?utf-8?B?eFNtcG1GSjZjR1drZUhTdkJRUFUvRHFjOGZLbkJocGxETXZHMHIzUmwvUHJ2?=
 =?utf-8?B?L1Rhb3ZBVVhKQUxGNzhZV1lXQXEwQytMemZLeVdvQzV2MWNFZFNkR0g3dmZu?=
 =?utf-8?B?WWxNMGhwWlJZVFhGNENTY3ZpQklnLzRPVXZUM2E2TWVlOWxKQUgzdTFranpI?=
 =?utf-8?B?SUlpck55SllLTG5wcmJLa3FxQkFtcXNFQUNXUkdBbGhqamRyTzZsRlErWUlh?=
 =?utf-8?B?bG85dmNmUWhJeUVadXM3Nlc3YTJSRk5FNGYwV2puY1Vja0cyclVuN1grcmJK?=
 =?utf-8?B?RGJaWCtXenkydXhpdWhpT0paWnBYYi9KMEcyRGQwelEvSVZVaTJNRDZjbSt1?=
 =?utf-8?B?TVNkRWdXazlIZUpkUjhyNDIxY0VoenJudk1kL1hnMlBSQjlyR3luaXAvcWtq?=
 =?utf-8?B?SVN1ODlZV3hiODE3QlBETmJBQkdwR1g5R3ZORDZlVEpzS296eGhKZS94aldY?=
 =?utf-8?B?U1RrY0I5YVkyRkMxNEhQZ3hybUN2QnJVYTNEYjBpdC9PQisrUlpIZ3E3am9X?=
 =?utf-8?B?ZXhpaFRDdUNrMFJCN3NKK2dQNDM1VTVOZjhEQUEvemg5Z2tYTDJiOVlucFJj?=
 =?utf-8?B?SDVGUEhBMjV1bnNCQTR0dTBQaHBMQU15NmpoQnIzV0FsT3lwdkJQWVVsbVJi?=
 =?utf-8?B?dHNKUEJvS1psaktoZGZiRHAzTVZxNU44ZnJXOFpEUXlxOEUrd1R0TDJwVVl3?=
 =?utf-8?B?TkQzT1BDZE5JSXZ5TEpIY2pUSDY4YThBcFhvMXlXRFg0aU02R292RGZETnNr?=
 =?utf-8?B?cFAvanFpeEhveG5rNzVZK1hZYk8vNG5pMDFjYWFXWWE3a09TWVpiRnN1d05m?=
 =?utf-8?B?SUxyL09TYVNoNGt2bEhIQjZMS0I2KzYxMVJtbkROeHAvUXNSWjBmSXVKZDVM?=
 =?utf-8?B?aFFqTE1jelJ2SkdKQnBXOW9NKytwUVNyVmVvNG9YNjBhMU5XcTM5Y2s4YUdU?=
 =?utf-8?B?M29UZWI3dURvbHd6SG9LaU1URVEwdThwUTFOSTArVWNqUFFZVmR2eHV0T2Vv?=
 =?utf-8?B?RkYwTUVJbkxDZDlzU0NORFZMbHRrUDNXT3dzYVBCTmxYWmsydVlvZmxaUFh0?=
 =?utf-8?B?aWVpYVBqcFpCZzZpUFJZN2hta2ZibFQvc3pXdVRSbllPYlRNQXR4dUZSdzAw?=
 =?utf-8?B?T2dRd2RVQndPSWhVTE1EQlluK2VxNUMrNk15azEraEVweFhXUERIYldDbFl3?=
 =?utf-8?B?TTFMQUlRcklKa3gyc0QzRlc4Ly90TG14S2RXVVNobERjQWQxbmhHTk5ON2xl?=
 =?utf-8?B?VnBxVXRieEQwekoxQVN6WG0yTHhUU3orTVB1TlZ0ZHlHYndGMjREOTN1aXdU?=
 =?utf-8?B?SlVRQnd2MGtGSDNSNGRJUmRQREJaMEJScTBrbnVjSEJrOEluSHd2YVhMRVJs?=
 =?utf-8?B?cWxwT1R5ZTRwZ0ZsTWFNa3BRZGdta2JtaUp2VXFxaFB1TDB3allGdWRGRTg3?=
 =?utf-8?B?Sno0QmZNZzM0S1ZwYXhxYlF3blE0M1VEWEFpTVpMYWU5bFpCcFhuWk5YRVBS?=
 =?utf-8?B?cWhBZU1wWnhiU21qQXBveWQrL0Q1Q3RjZHc3S1V4N21DWjVPUzlpYVpuVk12?=
 =?utf-8?B?aXVSZk1Hd0FFdlF4MFZ2WkJOYy9CZ0JYei9VL2pVc1RmTUp1UG4vbTNHeFl5?=
 =?utf-8?B?YWNCR3p4QVd3YWZXc0FCOWNMV3hSdDM0anpOampZeVdTMkdEMTVUaExXYkhH?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4187869e-a4dc-4865-78ec-08dde06fa3dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:00:25.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMVNKfmgDGqs9YT+eUob2O+p3wiCBDOiRMqZSWfZIP2TejZYXb8vk1xyem8tQi9sLiQ5mpk94VAlw0jen4DCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 05:00:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19929

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=8&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/08/cip.2025-08-14-13.01.log.html

* Action items
   - draft CVE handling process for CIP kernel [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - meetup next week at Amsterdam?
   - no irc call next week

Jan

[*]
Date the data is created: Thu Aug 21 04:58:57 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jul 30 11:27:27 AM UTC 2025
  limit date: Fri Aug 29 11:27:27 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
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
  latest version release date: Fri Aug  8 12:49:51 AM UTC 2025
  limit date: Sat Aug 23 12:49:51 AM UTC 2025
  Status: On track

