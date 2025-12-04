Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66746D1D876
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 06:44:33 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37479.1764830666730621462
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 22:44:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O+36nq6f;
 spf=pass (domain: siemens.com, ip: 52.101.69.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FylpkRwaF4cJ0oiWdgvzcTvPvUm048Fz9EcuGqVIO3mn4/Tsan6ZsCCPeNu6b5+q56mSHUZB2fJt5VOYrKUv+GQ8Szn04PgjEA5Zykcj28hu5ZpglDKFAgs1TCl/IiE7jZUOWvC8hWWAfqSyTPhU/GMP8FsJ7HiLNPwHlyHRttoD58GU3ueAjWM6ZKSgeccruOGQmH4guL4hgqSuvB2sGj3RS4eil9v2N7SIf1igJNgv3MspDdOsG5UnbBEWrXni9hyO9DggnPqTvw4CrlpZARSkKPGpBjYye2wc3ju64A0+AdpgOMjTdwLiEsxUyPC12vCGNKYzREFLOxpP+WP7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akEup6ivic4Pt7g46nWoZ6yG2YEQ/boCwUFsvv4afx4=;
 b=lmTt2qLI2JDxYXEInS5ihoO7CjRyPHXro499BWbm8cNddI2UYUYZ7bnU83OsrOsFs9W7QtG8BirKiegZ0U/iP8up3oYRJJuGNv0Q7OlP5nKkq4NF/GhXL7rUY2H0VRSg4XYQMc5t132KpN0lzx6pxpcHt9kWwPPYRQ9h8r+oGS8O/DBYMKpxywMJky3rZ0d8OVbWTFx8mNZqPz2/0Y1VXOqbR7aWbw0gxM2eA/Rayf5YJLioiPjYVjuaXnFkjPpLkgPfy4q0rXqlmTDN3i8tQOOlIp3oikHT6Tri4RFHIySKNvcYLHj8QUkGD7OE9Goy6bpGndgFlPQ12xQy3dO6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akEup6ivic4Pt7g46nWoZ6yG2YEQ/boCwUFsvv4afx4=;
 b=O+36nq6fuCFyQET1VyLzsRrbCj732Rm01ojL2I0EuyyloC1a8OXQRXnZ1B1G6s3GaQk8U2Gzmu1gmdCqVi7KUkB7JnbPp8SFwZhztm4gaOWAnSNbzl4j98fo5zKqlAwvwJAf3XdIbcM9H4UuLOB8DaGlV8iAETOoYrcQIbZ56VSVvgelMK01AGC0uxdUjKVKPwrswoVdulTV9LTLFWcXBkS/PPSJg/4tFaBoTid0KLoEiyyts0haro/jFG8ivoK09TKHbQmgIPM9JJrqwuSkVtLdy/gaBBitR9nRqI4VHdhuXWCHy+iNH/ywONTt0VmyT80H5F180MIFnT6JkoiOYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 06:44:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 06:44:21 +0000
Message-ID: <c70812d1-e6ab-4d1a-b55c-b58011fe63ba@siemens.com>
Date: Thu, 4 Dec 2025 07:44:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0591ee4c-52b4-4157-e194-08de33008e11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UzJWOWtoWkhNNjBEc1dhN1l1RENOSW9lU2dkNnVzTWc1dU8rU25rRzRaSncz?=
 =?utf-8?B?NTkyd3Qyek51TW5JbTFTUEFUR0lubmtRODhkOTNaMVl0dXUwS2RrVEdJOGtz?=
 =?utf-8?B?bksydHFyNENBYnVzcXUzRks3K1BrOG50Uy9SVk9XT1ZRSHFkNldGVStHNFU2?=
 =?utf-8?B?T24vYXRISkk5czhjOUJaZDhEMzErOGF6dmZyTitaN0laL2pUVzBUVGxzRFYy?=
 =?utf-8?B?TWtWamEyLzU2RmMydDZDWFc1Z0FvZTVRRjhlU1NzYWdodmVCajMyRGttWVl1?=
 =?utf-8?B?QnJzTHJPSi8zaGRjZFRPV2JQU1Eybkhrc1g1ZU10cFdUdUZEL2pXb1lLSGhx?=
 =?utf-8?B?VXRmK1NCam9PREpQQlJqTTkvaEhxd3NFcXZzeWN1QUE5aGQrMjlYa2sxZkI0?=
 =?utf-8?B?Tzk2THJrYkxpNjArWnV6UURVQndDaExTZ3h6QXhEV09MQ3JvMDBBaTVOMWZJ?=
 =?utf-8?B?YitpSUFVTWFZOW1tdFRlOVhaZUl4djNxcjFoeHFyUEdVbUIycDZVU1NPcXBH?=
 =?utf-8?B?RENDQWgrQ3VVS0tQRmRaOFhsN1QxRzgvRXdXUlF3bTRyeGE3RCtCaEpOTXpQ?=
 =?utf-8?B?R1lMRWpoSStqc29VZDVOeDFtNi9vQWJ3SzZjdUNTanQreWtQMmZOTytOTzFh?=
 =?utf-8?B?c09Qa3NHb0dFTUtONHBaaWpKQnk3QkxqbWx0RXFkUk9ydGxZcW0ySmZNSm5B?=
 =?utf-8?B?dW5zV2xTUWxTbW9XZ2R2WG55SlBNa2Q2cXlDR3NjYTZxRldnUEY0MkRPL29R?=
 =?utf-8?B?S0x3QmRyTk5kUzU4SUVHMzBETmpOKzFQczZPZDJmeVJrOGkraFpGeWs4a2xp?=
 =?utf-8?B?QllOdlgrdjhPc202VUE5NjFOcVh6em1LQ1JsdVpNSDhFeVNWcURXUVV3ZTRR?=
 =?utf-8?B?UzdqNW5vMlVJakZ0OXlrSXpaK3lMalJHRUJ4OE5SV0FWL1dXbzRKQ0gxY0hy?=
 =?utf-8?B?ejZOODBSKzhZL2pTU1NleCtHQURYK1NWK0NGZlFTazBPYTdVeGlSR0RkUFpR?=
 =?utf-8?B?QnU3NHBJcy8xN3Q1T3R0dFpnTk5EcmRUN1U1TnFMS0pEUXJ4RjZIWm5nSmxv?=
 =?utf-8?B?cGhNa3g1VHNhZlNvVUZ5VVcvSGhsZTNGMmp3OFVyWUdhTWJKMS9DN0hhOGFC?=
 =?utf-8?B?WEFlRFJqa24wVUZPbXBxOURsR3h4aU8zOGxoZk80cG40UUU1WWNVdmNQS2VD?=
 =?utf-8?B?QXJEUVhHYXpLQzhkLzlWUjZCS0lGYk4vTDNEbU9sTFpwZnBDcTdmVDh6Ym4y?=
 =?utf-8?B?azloRjNXbGZ6aHQ3Qk53dUZuZE0rRVNpSkZPU3dhejV5UVhlOS9TZXlHdzBi?=
 =?utf-8?B?OUxyR2x2RTc3UkVRQnE2WjBVK0liNHF0TG9uMzRWTXlMRnUxTEl4aDBDdm00?=
 =?utf-8?B?ekxlaGlxTUNZU1ZPeHhDZTRtaEExSTBqZWxRVm9qUUFmY3hDWUlUeDFBcHoy?=
 =?utf-8?B?QTMralhvQjhRMjcreS9RZHorMXJKL3NZaGx0MDR1TGFwMVVUSmZ5SEhkRDRu?=
 =?utf-8?B?VFBUTXA1UEVCMTJRWlhlSStsSHJLbXpqMnBNVnlzdWpSY2c1K0luVFpWUi9v?=
 =?utf-8?B?bVdJb1EvTm1TcU9sNHExUVcwR3MzanRLWWNFSEdCL2c0MEl1WTNsbkRQVXRH?=
 =?utf-8?B?aWNsSkFHTWVDK0dZeXlOWGpRTHZ3RlZsd3l0MmU0NDhveUE2dkE5SGtNQVEv?=
 =?utf-8?B?aFdtaTAvZGl2TEpvSUtYQjA4NHRQN0UvYWhwcUJGTE1xMDFNaVJyNEFENFFu?=
 =?utf-8?B?TUxBMVBOUVpSNmwxVmJiNitsMUNQV3dpVm0vbXZWN0dRdEhvdWN3UTBkaGhV?=
 =?utf-8?B?UDFPOWRSY0ZWZlY0RnM2a1VianZ5RVZuZkdtZVdRQW55TjQ4bWVzM29aSW1C?=
 =?utf-8?B?VVdFMzdSV2dkdmd6NTBqdjBvYVB1SU9tYzRRMEwyV3F5U2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUFkVm90Q0ZheVgwc2dTcGZpTG53SDBsQUJYZEdOVS9hVnM3dkVSUXJRbkkw?=
 =?utf-8?B?Vklic2dvM3dXNGl1bWdIMjJqbW9xTEJuWG9jYnFPQTZmSTZBMFRGUVJuZEgy?=
 =?utf-8?B?YkdpaEVnYklMWUR3Q3NKdTRLcmVNVkNTM3orbFg0UGJhNVFRZHVTdlMxZktU?=
 =?utf-8?B?WFNpNzQxNnkwL3NzY1JNRzdIVUZJWG5iUlJWeDRScll2Vm9yZ2tiSEw1dzJG?=
 =?utf-8?B?R0l2cXpZay9CNSt5Q3AwVDdsYUxBSEtYaFV4Y3ExV3ljYzJPOGtwVWZJc1RL?=
 =?utf-8?B?alBJdm5uaDIwNFZCcVdsemlSbktsOXVNd3ErV1ZjMXlUTmJ4NWZ5eUlwSWI1?=
 =?utf-8?B?K1k2RmpENnd6NWZkSG5DNWcxZUxlMmdIclBkUVlWVjlrMGJRcmhKZnRQcU84?=
 =?utf-8?B?UUZ4aDl5cEFBbnNIUUNjU2VUOXN2TjVJaExwM0ZqZ1JMNEtOd1BON3d2dFR2?=
 =?utf-8?B?RUliOTlOb3RoZysxMnpIbTh2SmZRK2FtbStnWVBCeTlYaEpiZmJzWkJjNHJo?=
 =?utf-8?B?ZlgxNzRPUmRQTDBpUGxTWGhCL3NWczRUamYraTBUa0RrblBzU1RyV3dGOGZD?=
 =?utf-8?B?ZlpsYzNCOW90RXVxZ0J6citjZFRYSXlGMTZoZFlKUlU5aG5vaS9tUmZ2dktx?=
 =?utf-8?B?VVRnSTBhVkxTTHEybmlmeUpiMW53Umx1V0dRUlFoT1hLeEc0bFVLcEJFZ1d0?=
 =?utf-8?B?V0dDalEzRG9aT24xd1FmMVJESlp0UFA1MEVoU2RJbTdZMEJmN2ZlNmg3OVVv?=
 =?utf-8?B?RDI5Z0FuVkZua0dnYXNMZlowUGJYa3o3YTE4M0tyTGJvbnpPSjdoVmd4Wjhk?=
 =?utf-8?B?VzJWRW1sZlhzclBlaXVCcUp1TGUvM1FhTGlGOXRnNllaQ3NOQVl4dnhYd2tZ?=
 =?utf-8?B?VHRwWGRUWlJURUY3NlVIS0FDajh6RFZYc09XbXFkeFMxK0VNUlNIbWZVT1Jj?=
 =?utf-8?B?SmVoMWMxSkFZVTA4Z2RRbHJSOWUwelNULy9QNHB1bjlNZ3l6VkVCa2liRGNt?=
 =?utf-8?B?NjI2WUZhNE1lM1hzbVJiU1RiL0twWkRWYmw2Yk5vckUyR3pRdmc2MUVDSHd5?=
 =?utf-8?B?WFZBNzc3djhZcDBnbDhabWFVNWNBd0FSaHArczZLVmoweFFTVURLY2tVN1Rw?=
 =?utf-8?B?Y2RKYmUraDA1VlVuTGNCS2JQSE5HcXFWbkdPcGJYWDJRSVF2MFVEVDVMZy81?=
 =?utf-8?B?ZUl3eGhJNzRESjBidkNjM1pDblRpaTR2ZnlpQ2NVSFI0RFIzOUxFaGFRcnFY?=
 =?utf-8?B?NnBsQVhjM1BqenJ1KzJIVFprdHUxdGNRMHI5K2ZUSWhQYmNlWFFTRUZWbFgy?=
 =?utf-8?B?VnF6eTM1VUx1bFlRdlBSVjZ2QWlDRlljcDlvRjNVR29lZVlla1Qvenc5djhv?=
 =?utf-8?B?UFpTVm93OHA1YmhkcnFqQTZacHFEWG5YTHhXWFNRSFZpOThQV3B5YllSMnBz?=
 =?utf-8?B?VEt2cThxTXM3ajdFZGpsQjMrUUhITG5ackZLdWY1cXdWbmtadWRWdmVRY2Rn?=
 =?utf-8?B?WkpPN2NrakQxSGRJOTVDRmIvVGh6WXhQNFZiV1ZQeDVwUHBTUSszTEJLZUM5?=
 =?utf-8?B?Z09OeUZTd2tCWkpiMm9zOVcxZlJvczc5VXNVY0xpczJMNVhjT1gzblRjckNP?=
 =?utf-8?B?MG1lcVpaZ21CNkVXSGJFTHA0RUx4T2VJeThHU0FueXB6V0FJMkpJbThSS2Jn?=
 =?utf-8?B?b3R0cHpwQkh3QlBDN1lOVWNscmFsMHZ0WEtQNXhpaFBVaHRib3o5VmRsKzVJ?=
 =?utf-8?B?MzhyY0VuUDhHZ3d6Y0YrTHN2RWkwc21JanZDbEhwdS9vdnBoc3c3Q08vZENG?=
 =?utf-8?B?R2Ruckw0THdHSDR1YUl2K2RyaHlSY0J3ckJoZWdnOHBEZkd0eU13Z21zK0NS?=
 =?utf-8?B?L2t2aC9ZVHpaRlVWVWlJS1h2b2lJaDI0QitBZTFia2Z2NDIyRitWMGxkTUt5?=
 =?utf-8?B?SDNvMnFvczdLdm5JM2I5SnUwTXBuaGxQQ0M5RFZzbmpFQ2pjZGgxbmdOWVlm?=
 =?utf-8?B?bXhvZmt1Z1hnT0RXa1ZuSjJxZFNEUkJzZ0FEd09tVFhWLzc3RE1icnhpSXZ6?=
 =?utf-8?B?SUEyclBQSmdrT1hJQ24yMEV5TElJSzZQek84SmYxSmNVcHFsTGx2YnR0cmta?=
 =?utf-8?Q?dAtv5LrunBe+aHKc3et5+1QBS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0591ee4c-52b4-4157-e194-08de33008e11
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 06:44:21.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/vcQf6lWBE5WhVdoYqj8lmKMLcQ92kloRyyw8Q9CTVe9kmO2Z3KeCcVsBti0urjH2Dyc0J7hFfoigEHyT77Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 06:44:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20839

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=12&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/11/cip.2025-11-27-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - topics for Extended TSC meeting in Japan

I'm have some parallel event again today, and if its agenda shifts, I 
would need someone to pick up and run the meeting. So, do not wait for 
me longer than a couple of minutes.

Jan

[*]
Date the data is created: Thu Dec  4 06:40:52 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Nov 27 12:52:11 AM UTC 2025
  limit date: Sat Dec 27 12:52:11 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
  limit date: Sun Jan  4 10:07:00 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Nov 20 10:20:08 AM UTC 2025
  limit date: Sat Dec 20 10:20:08 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
  limit date: Sat Dec  6 09:00:25 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Nov  5 12:32:45 PM UTC 2025
  limit date: Fri Dec  5 12:32:45 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Dec  2 05:29:12 AM UTC 2025
  limit date: Wed Dec 17 05:29:12 AM UTC 2025
  Status: On track

