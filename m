Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D0C83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 07:38:13 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.34])
 by mx.groups.io with SMTP id smtpd.web11.43631.1752737891113813961
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jul 2025 00:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Sg5fR1Aw;
 spf=pass (domain: siemens.com, ip: 52.101.66.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktyo6I1D9Yr5YA3EbHsw3teseUrZljqPHvoX8k2A8ilzYDDcLNL2CQ1wvWTpWPzKxdRYfz43hZenxlC3hPs9mZ80wOkAxG1P7cCMoRWVL5LFdm/rrMjy1fQYmSO8WIOUzxYL7E9+XJhWSR7xfeMhn0O6o5LS0H1UgtdP7wqjaGmHH7PxpnyjSHueVa4+ms2BfEc7++073imYMzt/lFY0q5/Jrg8reQUeZiZK6hUGDcy0vHqeTArLA9DYLrexK2+wLdtKKxo3+hf3r5RKp8WvbgSf8jrZpgEqW4R91URmFoQ4tqrUGv0ETm4K+ow6hddmA/ja8jVxelJPDzlarVchtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axQtX7kNQ4tpCGmXt9yPxz/LOZa5rHlnb1RwyyZEUKA=;
 b=doXZgNH7BxuzNjbL4C7aJLKZCsjaEREhbvbVmWbOMKK2B/K4hlB+f+bGebC6yG5hJ6PnuetQ6agtpPp1zpgQFJTZB4MaF2/W/mzxtLbPZaktk9fJj4V82SSZuB3V0XDoOGOTbnKEbGPsRfZCf/o9tcscXJvtdy3fBovOJLrTuCMhJdctJqePk1UxV5YGEHRP/wCuYMtNLAX/sIOhe8iGMywb+hmZ92IvNpXyZy91FdL8aglmLS1gXSkrhlKrlIRLs5+ZYedL/+XxROV69DR7u1T4vHq2M54pJ+ZuRctWG97XXorJ1zo6HYcNpOlv4rRbVi2TEjloeFfom2Y7H8te+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axQtX7kNQ4tpCGmXt9yPxz/LOZa5rHlnb1RwyyZEUKA=;
 b=Sg5fR1AwbZMR4RZIEAtArvET3WWYiYsI1K3mvsi3OSOQKzIVdwrxMw0XzeGrLMOW0Lo1D87FR6xuguIW3WrSXWjxqleykKVFxyL1cglDpdcbBYap8Z8VQilDjSyOpe9GSpj1fiiQ51triiriLxaQW3ymAveYeiQOI19JlVlQD4HBol/EXwV9I9Y5T7eeJ7/EbAbLgg8Vct7WxvesfSUQquFI+MgNEFiUSjwRbi1Wm6ONg4p2cya790Cf4bKN+HwvgJugxfWoBDMb6xKcVhjGdR/5BpG6W99pJLPCnfG1hDwjcT+z3g7xfd2+3Nl7l4hMR6xhw58I6J2dzpXr8cK4sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:38:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:38:07 +0000
Message-ID: <61a6cfac-3460-4ad8-985a-ef48dccf2f0c@siemens.com>
Date: Thu, 17 Jul 2025 09:38:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d285099-166d-4581-82a8-08ddc504defe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bW4va0ZuV0RHSHFjYnJqN09SME5CRm9kVkN3RXh3WXpmcFBoQUZDTnBPMzUz?=
 =?utf-8?B?WjdYa0RwZVFaL2Z2UTBTRXVxOTBiSXhSSXgyYXJpdkM2ZkV2Q3Vxb0xOZ1Jm?=
 =?utf-8?B?dFlZd1hTOS9VVko2TmxvK2FGcVphTk5iaFlJc2NVa0xTeDlOUFAzd2cvcXpw?=
 =?utf-8?B?bG83a2dhVVNXMGRjZTFnSmZRdjF3ZDZkZVFIblBxZjdZTlAwM0R1OUVmVFBR?=
 =?utf-8?B?Q2VZNW44c3Y0VlFzUS9uQ1F3dFBXUmNJT1gvNVgxQXV6c0FkZnByenZkK0xB?=
 =?utf-8?B?dWVOek5QTGhCdlpSejlpZHk3bUdraUJuTENUYjlnZDZ5V2o4N1krbWlQTExD?=
 =?utf-8?B?RHhCdXVZQW1MUmF3KzY4eGlBcXA5ekVKM1BKd3cwZFE3V0x4ZG1GeGRUUi9C?=
 =?utf-8?B?OS9Rb29iTlZOWUsvWlVMOGpRNWlDYXJjRUNVb3FSVFRIbHB6OGF6ZHJSdVVM?=
 =?utf-8?B?S20vaU5PK09mSldJcytWeWcrWFZaU1VYSUFSZURoRXB5VURQZlBIOFY5VlZJ?=
 =?utf-8?B?dlpWbEdQdG5tNXpUekxicXA2K1BGYUk4bWNYamxkbjBvc3g3b0ZaZGdmTXdx?=
 =?utf-8?B?d2dxM3gyeFRFUjZDbHNEaGJzSXNNQno0YjliTDE0d3p5ZWpDZndBenVRemND?=
 =?utf-8?B?MXZWVnYwL3Z4MlExa3NLcUhyQVNZN2tycWo2OTFQOFZxdGdmNmd5THhDK2VK?=
 =?utf-8?B?bytsM3hZbjVybDdKVUd4ZFBOWjBxVFNWSGdCUHZsVis4UVpaWnNQZWZlM1By?=
 =?utf-8?B?L3hieGErYy84QUxyajZxQ3ZwYkhyOVhyakN1dW1lNVFtSWk3Z2RRdFVzaE9L?=
 =?utf-8?B?b0p4Sng0V3FEOXdCdDdDWmc3ZVR6L0xpK0xDRWwxNjlmR0NxL0UxRGsySjBv?=
 =?utf-8?B?S0lXYUtaZnJweDFFRG93WnQ4SU1tcnVMU1dkN0tzZnk0UVZIdU1JMVhJSkhz?=
 =?utf-8?B?dnNQM21WNjFJUlJZUkM3TzBrcVRJTTFabmtWZzEvdFh6cGRaZFBQVitNNXlY?=
 =?utf-8?B?NllmVVdYbzU3UDNLdk9ZSnZKeG1sQ2NaOGt4NnVodE8wQWlQY01PN2I0UDIv?=
 =?utf-8?B?L1lQbTJ4ZmZNZnJua3J5RTlneEF1a2ptSmRJWVB4bVVSeVVSdUZuYmYxemJZ?=
 =?utf-8?B?cmVUVXJGRURqenAxLzNrTmRWVE5wV1duN3BTdWhmQ2hPOGdNNE5ZaTlLOEZN?=
 =?utf-8?B?NVMyNEZxNlUxZkdXV0ZzT2VhUDRmemttdk9Hamp6KzZTSEdIQ1ZtUUtJS3NO?=
 =?utf-8?B?cUVhSi85Mi9NOWhBZnV2Z0pQU2d5THJKaCtkT1dMa2xXU055cnpybFpCK1BN?=
 =?utf-8?B?c0RlbUxVYU5lQUp5Q0tsUWJDVmdhcWFkQzVxWXYydjg3UU90cGlob3pCTmNV?=
 =?utf-8?B?S1VmN2lKdWlpSFhDSERQTjBQRU04M0R6dTZrbm96VDM1eStic3NVVVlOaXVl?=
 =?utf-8?B?d1ZDZU9JNkU3VVJsMVluRjhwTDYzNCsveFFNSWFWY0xwMHBtZFpNVGN3WEVF?=
 =?utf-8?B?ZW5ZV2Nnd0tTa0tkWXhENGE2elJGa0dmNy9qTklHMW83YUVrZlFTM2dmUkdF?=
 =?utf-8?B?eFNkbkpnd21sS0ZHU09JQnlKQTdvUE5nSnY4THJlRVZ3azJXS3BNRG5sRGVi?=
 =?utf-8?B?UnJFVkVrbzRzdkNVVG5nTC9EN1hUMXRNM1dlSy9rVXN0azQrMUZoYkJ5TlRj?=
 =?utf-8?B?Z2F0MlowN0VaNE8vQW94U2NjeEVCbTBOTHpxWS9KcHQwdm5LZE5PaEo4eEJF?=
 =?utf-8?B?bnZLUVgwdS9DUkkzSC8wVllaK0NFSTU5NVVJN1c4ZVdmb0YrUWc4Tmo4TXUz?=
 =?utf-8?Q?MQvJg33QBbc8EV/VLifS4rwd0PirS5I0+OZ2w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkFIRmFxN3BLUTZLM0ZKL1l2Q2lzMU01eHhnQlQrZVZzRUtlVnVTWTJ5VGlY?=
 =?utf-8?B?YlNoWkRRVDlYb3V4K2lqSHhIU3c2cCtyelpGSTdNOEUyT1ZtZG9hSGUzdlJ5?=
 =?utf-8?B?eG5TZDRvbXg5cVFFenJsTG50Q2NOMVM0SmVDS2RQc3dEWmtIRnlHbXBHRVFI?=
 =?utf-8?B?YnZsU0RDQzNzWXNXclgzeUhBRFYyNDE5eDYzanZWTmJ6SHJJRDlmR3dkdmFt?=
 =?utf-8?B?OXNzdFVuU2lua0pDM0RrdXhyNXVIdUV4blYyVVB6WWZORmpPVGlkUU1xVU1V?=
 =?utf-8?B?UmRqdXpXZXpESWJuaE9JM1JlR2FRc05kU0lPN253UHZSOTVFc1FwRkxNcmMw?=
 =?utf-8?B?Q2ZabFhyZjVqOXZhMTVmcldGN3J6eUhCS05JQkxOZ1lOdW9PcENyUGw5d2Q1?=
 =?utf-8?B?aHI4c2JFYmxEZ2RESXc2ZWJYSms5R2dhMDZmOFMvVHZPa3ZSaVZsRmQra0s3?=
 =?utf-8?B?bitYSkNHeW51SWpqbW5RZklNZWg0NVNjNHdzY1o4L3hNMDhJWE1wc2dQWnhZ?=
 =?utf-8?B?ZTYwR2RwQzNTRG5tOE5JNHZGZkV3b3NoMXUxQnlmUkZrQ2dVemJ5eFRHVitr?=
 =?utf-8?B?TzhnakpiVkhxL2JtanVhV3dVSE9zM3pBQmwxK0NUenpRenZDVjVHNnZWVjFW?=
 =?utf-8?B?SFN0L3pHQU02bUJuZ3pIVVJxNUF2TWdXb3BnWnJXU2xxMzBxMWNiakgwZmJB?=
 =?utf-8?B?TWpNVGNlbFJHOXhjYVNsQ3BPZysyOVhJZStvWEtMYUZ2clB6WjFNd1VCUXp3?=
 =?utf-8?B?Mnk2MHB5SW5BcVlpNFBPR2hlYUtGVjFEOUNXUTRHcC9sSTI1RzdIUnM4TS80?=
 =?utf-8?B?NE44cnN3SStyUWJYM1hZSy9zWDh0L3pqdWh4My95a29zK1pkejQ2c3l0VmR3?=
 =?utf-8?B?UDNtVDN5dlVSaDl2U0Y3TGhqem01bnNRNE9FbUlVUTd5VzlFbnBWUnNZMW9m?=
 =?utf-8?B?dExJTE1tRmJvWTkydlBYWFozbzZHWUpoN25rMURVQzN3aE1SbjFXZmtrT0Zw?=
 =?utf-8?B?WEcrRUNjbzFvYWdZT050OWxsOHNmM01nSEt4TjZMZXorSk9uV2NSczY1YVpQ?=
 =?utf-8?B?MU5QVUVxTkNmOGpnV3B5ZXl2Q0JIRHN1L2hub3VQYmYzL3N1MUZCeTlLQ2x1?=
 =?utf-8?B?OEM4V0VxK25PUnJzUHpBaFRJZGMwclF0bDBZUmwrV094VVNCcXNTamVyekg3?=
 =?utf-8?B?UUwvUUxpKzdxWHpVUEkrdnUyRDd1ZEowRndxNzZuL2UwQjFNSHFqNUZXMEtw?=
 =?utf-8?B?bnlNWnhTSDNBTGk1WW1ib2NRalowNTJ5bDRqM0dLNWFCS29YRi9RczVKY2l2?=
 =?utf-8?B?eEt0RUZoWUJJRjZzOUdrczd0c0xQSkQvMy9PQkI1WUNDaVlkN29Fb3NRVWE1?=
 =?utf-8?B?MjFGa0s5OTJJaGF6Qm9pdHZkdFA5YTJpNFFmb3JEVUFlRFVIVFV5Y1dEZmJY?=
 =?utf-8?B?SVd2Q3VVWEZPNFBwZlV3eHZmQTBxRlkxQVpHNUhLaEkzYTdtc1pFTmRDTmps?=
 =?utf-8?B?R2NDU2RyTC9nUVJLZzJiYUZWSnBYdEIvai9QRHUwWndLYlR0ZHBrYmY2ZERp?=
 =?utf-8?B?Q0FJcmR6dXpuWXpCb0VjZ1IxSTVFbkhnWDJERXcwaWhRc3dtN2hNNnRIOTFt?=
 =?utf-8?B?WlRjVnNVQkFFZlQwRDJjcmlpU1lzT2Z3czFPRlpJcis4eEVPWkMrK1publVW?=
 =?utf-8?B?b0NQazd2R3pwYU1nOTlHYklhTjdUdEpsN3VLNXJrK3YrSHYzNjZkcyt2TlRN?=
 =?utf-8?B?TGZZeTVZZ1MrOWt1RHFDSnpYTlI1dmthOXE1L1hJVk1JK3pxMXNuVEFlNzlq?=
 =?utf-8?B?R1hBclUxdkxDQ2RteWlOejB3MzlHL2U2bmUwZDNGWEY1cks5ZjU0Ym1CNDFv?=
 =?utf-8?B?RkFvdzdBcEVtUHJuZlBoc3FQaStTcmlyZzVDVTFOMmxzU2hWVjZjM1daYWwy?=
 =?utf-8?B?MTYrL3hUeFZZYjRySTRLL3NxOTV2cmJJaDdjTFU4VTNqRXRnN3BWd3Rha0FS?=
 =?utf-8?B?WXB4dWFDSHdURm4yWmJTckd6ZGdCVmJhUEhRNUZvUkZ5QmhHdWlZTEZsRUJn?=
 =?utf-8?B?WXN5cFFqaEVNcFBxazNyWHRaYW10UFoxblZvQU1PMzE5YXpMUlFYamZnMkJq?=
 =?utf-8?B?YWRyZ25BUUtueHNFSzcyQTFWSm1aQ1c3Q1N0eFBuYVdOcGNqM1FjUUpVWVB3?=
 =?utf-8?B?RStDcEJ2S21kemEyZVFsTkhnQ1pEb2NKL21pMS9UNWxBZTBTSmZKa2Q1aGhk?=
 =?utf-8?B?U1JYaFBnZ3p4MTVQSnFSd0pMK0tBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d285099-166d-4581-82a8-08ddc504defe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:38:06.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmjd8FTqXu9TbLHMvj5g4zqmHv9za8tstUUIqd8SKpoy4TFGMAxHRPFy9KRxz/HRNWFfXmnmISbGQ33WPVo83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8441
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Jul 2025 07:38:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19551

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=7&day=17&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/07/cip.2025-07-10-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
 - further workflow improvements for cip-kernel-config

Jan

[*]
Date the data is created: Thu Jul 17 07:35:16 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jun 11 08:39:43 AM UTC 2025
  limit date: Fri Jul 11 08:39:43 AM UTC 2025
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 16 05:30:11 AM UTC 2025
  limit date: Fri Aug 15 05:30:11 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: *Late*
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 15 04:51:02 AM UTC 2025
  limit date: Thu Aug 14 04:51:02 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Jul 10 12:36:09 PM UTC 2025
  limit date: Fri Jul 25 12:36:09 PM UTC 2025
  Status: On track

