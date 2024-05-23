Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD08C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 06:12:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.55])
 by mx.groups.io with SMTP id smtpd.web10.9022.1716444771127292166
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 May 2024 23:12:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oDIiFa2C;
 spf=pass (domain: siemens.com, ip: 40.107.13.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWqYjv7mG8MUcr2Ktr9WzkMBMxAvhZUOdh3L6LPo8EIiJosD7bSVxAZiZALz9u4gvR7CyzW5aYQrGJaUeEZjuAhIkBc5kE3Dig+2C8ucunvzUJgbsmrMSMCg5ixcEC9YI7ji8V7qYeqFHyGGyeFq85IvQ0UwaGJhjiqop5ncxRDvVBNMxEchdISwBorZFP41MkFyIXWRIC4efGKQNoxqd2gbGEjlxgrahX9zD5K3RQJo4+eg/FYVBpr1kOKzrxItgceYPmWkRuSCZGiwveiGlCHlO3V5h9rlo+q7hIa/lHtIhi1PYNQEsMZAztsF1pOCtO1Xj5ebRTxN/+oYCC1lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16t4XAbeAjYRGxMMSEvUUXc/5/JgI723OmxSF41YQY0=;
 b=eVplBtH8IWMNLw107kocdp9BpxFfna71Z1iMZcTbog6HN33DkwObB0s9lFzWkQKPmjTbh0kjAWSfM31PPlupYeUS4/9OCWrrLPqPBKZUfR9KAp+WarhT/TeyxyhWIBHa1KERtEqBoRjbXu1tzbAhwBZGhUdY8yxt/UlFy3BS9cAUcl324z7e1MmAeYjjJj+MLXD0Ddqkd4/JZf5ucsbHFhiDPTVBmZXgyiVvYs5jLnPnV5ugihabgUAPO0jc/oMHi9vIKUWSlCvrwkcgx0fxyVPLO+fyaeeumOXjDP/+Y1EclwMze7TcRmG4nTrZ6VHQbLhuCigXTnu1igr287lC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16t4XAbeAjYRGxMMSEvUUXc/5/JgI723OmxSF41YQY0=;
 b=oDIiFa2CbWc9+BFy6ZOaYKrwxMsPcgfLZ3EtSPi9pL/n+5Es8lbPqOseEkoLEhBzqw0IeXlKxr9fi03iGCXFHjkf1WNnOqcwvPafHLbeJhYF4d0xN5cmMAnPuFCKAOPqp/5IRc6wkb94QDVC9RG+c5kMxwQZz3z3fcEcnBJzqDPpLcG7EwVlYSCCkq1XyFK3lnFwqh84Ib9C/nR9Nw7y8HSsoxhuxjKzIh4SUaFw0tr3hs4eP4Q+lsqC3Ys0WbtnClrwgqbtBOmuM3VOeMT8m9nhKHnXXryPvZMOoQLQ0Qer8Bgc3+xoytWWIsnXJyIihhykL7TvO4at9AYVmv4GLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 06:12:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 06:12:47 +0000
Message-ID: <f8fbdef7-4dd3-4b7b-b41f-dc22ac2b7d60@siemens.com>
Date: Thu, 23 May 2024 08:12:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: b40aba91-3c86-4576-37ef-08dc7aef5dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dGFnLzZxaXlsVUJFc2Z4dm0xV1B1WmVwWjBvRDBQUWNJZm5wNjRTTlNzQkRu?=
 =?utf-8?B?TUxWYjJtMlh1QXB6Vk9xemo3ZmpwUnNvdE1wbjZFK3pTbUJnRklYZTBaeDZK?=
 =?utf-8?B?M0tNcmptMjk2Ry9oT09oSmc2ZUNQTTJVTFFsV0lBT1ljWFhMdVd3Rk82UTk4?=
 =?utf-8?B?Sm16ME5Ta0phb0RuNDl2N2N2UjFaU3VGamhVL3IyZW9TQWh4TTd6K2RJaDZ0?=
 =?utf-8?B?enVlODU0WENsRXNLRGFzeC9KV1dDZElBWHNucjZwalcxYmhiK1dISDl0MXZ0?=
 =?utf-8?B?ZUlRTElrb2c1N1RzYlVlSlcyTWRHMUlVcjd5eWtnb0xvTlZVZDNqL3N2Z3da?=
 =?utf-8?B?b3ZXT2JTdEFaOENlNzhCZlZ1TGJuWmptKy9JazZjUjg3T0NUajJTeHZLSkF2?=
 =?utf-8?B?c213aWtTZjZySnJZWjg5YzdxQk9SMzBaTW95SWtYaUxMZ2hTVTlLcjhucytE?=
 =?utf-8?B?Sks2Tmh5ZWhJSitVWlFpTDR5WUNVL2pmanA5V1dQcWpjTkdzb3dTNlZ3UW5l?=
 =?utf-8?B?L1F6VnhBUXZ3RDNleHF0bUptK3hoVXhxa2MweW9CeUxONGVZNEs4dHlwZVRX?=
 =?utf-8?B?QjlLUGw0TVBtWmNsL1gvMjlPMWFJVGFyVkhTcUp4dkFsQkxSeElOTGZGZy8x?=
 =?utf-8?B?bVY4d2FyWnlWclRTWjcvS2dwK3BMTEpSQUduOHYrRXJqNi9Vd1phYzJWRGlE?=
 =?utf-8?B?RmMyaVN2WDl0S1VPRW1IaEppd3pYREQvdWlGS1JPZDRqZVc3V1lzV2NEWW9M?=
 =?utf-8?B?aGEycFBDVkUvQnRMT1NnV2hXYkcwcFN2MTQvZmJYSktoQWk5SkJXVGNSYUhu?=
 =?utf-8?B?cldKU2RtWDR4VGlmZjdDeERTWjlqamVsaWRCNDRHZitBQkMvZkcxNFhjTGlZ?=
 =?utf-8?B?aHVCbUo2QU1ZVDk4RHBTZlNFQlpUM1VrelVhTlVXcUJmTDlxTW9OWnFldXQ5?=
 =?utf-8?B?ZGY3MUNpQlgxOE1ybndwcHZvTkp0QnowTEV3TjNKWUVUNGszRjl6MFdmVWVO?=
 =?utf-8?B?Slpnb1NFNTNMRys2Z0l6VFhZaXpHR1lUZXJwMGxGN3hCQlhXZ1F6MmhjVzRu?=
 =?utf-8?B?amNRbXdxTHBvUkxtdytQVktDTWtOQlNVNHpoYW1QdlVrU0VGeHlrWk5CS25l?=
 =?utf-8?B?end6RnRtQWF3NUNDMjgvWllZNmJTUjVSZ08wc0U0R2UrbUIrb1hEdlYwTlV5?=
 =?utf-8?B?N2dUTk4xQmJjc0FYYUFjSlozWHdSdjJyZ2l4V1g4SE1PNWtNWnBtRjF4TFMx?=
 =?utf-8?B?S0M4TU9tK3lNb2tiSnRSczNMWWJNbWMvMm9JZ2F1SlJuS3dXTzI2QSt2dERR?=
 =?utf-8?B?VXZoV05lNDZhQlJFSmhQRkw5RzFXZ1A3MmxKVnhPRWdwam1JOFFvckp1WmVk?=
 =?utf-8?B?bTVMR1h6YVRoaUwycmpLeWkzZ0E0M3RhR0x4Y2dmdWl3ZnFRbGIyTGUrMzNM?=
 =?utf-8?B?MFJqaDdHRUZPaWg0dUF1RG12LzlYZEQ2cnhKc0FNd2hZS09COUJxVldqQkpU?=
 =?utf-8?B?N21FcHVVRVNzT1F2NzdaOGYyME1rQXB5ZUFxZWJjUEszcEsxYWIrdm1EUTNw?=
 =?utf-8?B?dWxIVkw5T0Zsczd4dlhvUEllRmsyVktra2k2S3pBNUNLN3EydTc1bFNqeWEy?=
 =?utf-8?Q?sf6oQ3XdWG2ouUElpd3TqQ5jFPUtomqna2BpjnDiPDTY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck9ObzAzMmFJME1IZ1Rxc2ZDNTdqdnZwS0lGVTQ4SDZBaXRJRTdERzhad0ZI?=
 =?utf-8?B?ZTJpdUZJZS9mT3Fha3RDUXVZN0YzVWsxMWR0Q0p5MnM3TDBCZTdSMWQzV0FE?=
 =?utf-8?B?czBxb0NoZmVTWkp6S2ZOdDE5YUlxQWZCZUw4eTgrOHFMeDdBQUQwYmd6VUYz?=
 =?utf-8?B?b1EzOEtWRTV3bjY4L1VuOVUzUHlrcmRTYlJCK2ZOcC9DTXl3cFAwNDA2VFJF?=
 =?utf-8?B?eE9kYSs2WXFESjJZUHpYZDg2Z29kMjRNR3ZGbmwxUjFvQXdIcUlxM0NsdHQ1?=
 =?utf-8?B?L1A1L1paYXZZRGtQS2pxSEgwaElZVFU4LzgwdE16NnhzZjV3YXJ6VVd0MEZ6?=
 =?utf-8?B?Vld4aWgxTkx3U0QwQWdpdVNZdUJCQm84dWY3ZWg3ZERTNVNvSEhveTNQTk5T?=
 =?utf-8?B?dVh2dmRvSkd6Tm8yWFZlcllFekJSWUNrVHBRVHp3Z0dOSngveG14TE1mc2VW?=
 =?utf-8?B?clVEVzNpSjAzNHYrTHBQeWdIUUVKeWs2YXhuUVAzMlpqREk0QmNmYW1Hb21I?=
 =?utf-8?B?R2ovUTArOTI2VFBCcFd5aHF1Y2g0QUpMOENUZnduUUZXdVIyaGwxR0tPbEk5?=
 =?utf-8?B?bkVSb3VVS1lpVkpUUVhRdEx2dDRycnAyc1cyem5PZTE2MDVybThKK0N6UEk2?=
 =?utf-8?B?NjA5NVJoZ1g0Q0kzbXNTM1VramRqM1Y0OG0vZ3JvK0FoQjJSck5WZUpUYWdi?=
 =?utf-8?B?Z1c1RUY1eDJqWENpZ1owV1RXRFR6dGIwdHFWYzBQS1p4OFV3WkpPQ3NNMUtI?=
 =?utf-8?B?RUlFUnJ3R2pvWUw1S01GZ0IyTnJuejlqRjEzZGorNGdwRGorS3JxODd0YUFX?=
 =?utf-8?B?OC9TNFVoUVhDTlViZFNucjIrOWp6amFndUc5R1FIZGQxYTd1bmtqTmRHVHEy?=
 =?utf-8?B?WTZ1cFJzVVRqVXZ3NysrVjdwS1N3VlM0RU40WUhVMjFBZVdtVWY3N3lvUWN5?=
 =?utf-8?B?M1h5bm13bUJPd0d6dWxLMitpOVhSZmFocThEQ2pCdUxCNzlaZnc2YytRdFBP?=
 =?utf-8?B?ekNLR0xFK2Q2UWtab0Jwa25TT1BHTllmbXJ5aE1SV1NJRjN2NmxQNVJJMmNr?=
 =?utf-8?B?bW1FN0czbDlCdEZVVGNzdGNlWmJiR29qbHBZbFowT0tXZndPK2dEV1BaU3B5?=
 =?utf-8?B?SzFzRmwvWlJnVzhtZ04rTSt3RkE5RWNsWGlZeldyeDJnMFRscHBHdEhPNXFO?=
 =?utf-8?B?SGo1YkdQODFsZm1qa0o5Y1NOMHZoOG9hbWJMajJveGZ1emdWNnhIUDYxaFBG?=
 =?utf-8?B?NEdubEMrcWFxYTh1cmRCV2p6cG5WQ3BiSmZNZktUMW95aEZjUXFCQkM3aFFW?=
 =?utf-8?B?N3VndWlGdGs4SnhuUnZQUGNFSUYvTThHQm5pWS9kSUVKN0haMHh2UUNRMWta?=
 =?utf-8?B?SUsyTlJkTXVpaVZKY0NLYmtGcXVGQitwK3BaUFR2YUoxd0VEbFpVTWxUTit4?=
 =?utf-8?B?aExBZlhkOFJGZnk3OGJEOG55UG93akJyQS9lQjlNajBWeEg3VXJWUjkyb1p2?=
 =?utf-8?B?K3VpR3NJd3hISzVpQnZQZkNFK1ZtRUxmS1dNTzdWTEk1bjJxWlZKTWlQSVNT?=
 =?utf-8?B?RWFONlNTYS9Qdi9XYzQ0WEZRV3kzRkxJUkxhQStZSmNSMWxkZndJdk1LYnRD?=
 =?utf-8?B?Vm5tc1ZhNXU3ZGRtRTR6eFF3Rk44VTlqeW1XMHU4czNKTDk2aEF0NWRvSXdK?=
 =?utf-8?B?eEZvY0pRQUhtWEk2eDZia05VaGwzV3NuZHpYZWs5S2cyb2dselAxcU9TbDYw?=
 =?utf-8?B?YTIxU29OUG4xQjNuNExIajdoR1llRmNLYXpsU0c1aWh4bWdRRUVaVVlOdkxs?=
 =?utf-8?B?SzhkeXUraFphTjd1bFBxbk5nTFY2MEJSSllDdEM5V0hxU1pKRlpjb3NPSzFP?=
 =?utf-8?B?WDlJZTgzTThDMVlDQlNNZTdUVExwRCtROXEwRUZ4SHljZXhJNzRnbCsrRFVn?=
 =?utf-8?B?UWRTd2tMcUlvVEErMzAyOUJvNFlVLzNDTmQwS3AvbkZLOTFJTm5tMkl0T3Ew?=
 =?utf-8?B?bENTUWtjL2hld2JQNjhubWh4aHVvRmIvWExLYXlaaGtITmVpalpqYVpaVlhI?=
 =?utf-8?B?YmhmdUg4THd1Y0QxSU8yaDIvVkltOEdLbnA2eHByYkVvV29BdXR3NDdORVo3?=
 =?utf-8?B?RU85WFdOK2V0dlA3VE5jOGh4VVNYWjBKSnhZdWNUdHdrOUcwa0g3M2g3TWV2?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40aba91-3c86-4576-37ef-08dc7aef5dc9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:12:46.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHe+WCqdgJAP37oWW/RiEy0Zi2hCnb13VDLE1KrqMQBbAf6MehLShYA0Ohq4RXKnjtbi2AJZn3AIkEFL6gN5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 06:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15925

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=5&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/05/cip.2024-05-16-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed May  8 10:31:09 AM UTC 2024
  limit date: Fri Jun  7 10:31:09 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Apr 25 11:55:36 AM UTC 2024
  limit date: Sat May 25 11:55:36 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Mar  1 08:49:23 PM UTC 2024
  limit date: Tue Apr 30 08:49:23 PM UTC 2024
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu May  9 04:32:32 AM UTC 2024
  limit date: Sat Jun  8 04:32:32 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Apr 19 09:32:00 AM UTC 2024
  limit date: Tue Jun 18 09:32:00 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue May  7 12:32:11 PM UTC 2024
  limit date: Wed May 22 12:32:11 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue May  7 02:34:00 PM UTC 2024
  limit date: Thu Jun  6 02:34:00 PM UTC 2024
  Status: On track

