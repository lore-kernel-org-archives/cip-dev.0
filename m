Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D82AD3E795
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 05:57:30 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2646.1765432641678069768
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 21:57:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zv8TsxR7;
 spf=pass (domain: siemens.com, ip: 52.101.65.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKlWgf6zV4w0ArDAlcmqadcrh4L5Ahv0qpgfR6avsgZTam4Bm3LgIaCGgXyuKMFan400+oa/rp0Y2EQKlXt6YBKBr3oLuwnIgpIxSg6ylXc6wEE44nqGUa1/Y+iUg8kWqf2PODd9nQ0e+lE0e8xJzN4Y05q5nBVdAGiiUfEv7HKwpnIfEyh40RvvcSgCPDkt8xMkO8nSnxnUkLU9r3ccfuKk4mxAKuB0smF2aZ8lwf44/4ZSjI8vsu8Ql8nnbmVszuzapP5NW2bHFeDqtJ27i1WBYJuTN8tNU6LTGoe/nbp/tELGZuqtp3/NEFWmgTKi6bRxvA/iHLVBqCdTLfUBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVqRswTZIovSYa7DsdHhq8kW5RlpQ3GzioidRX1g1rg=;
 b=JTJ7Z1Ueeti0JhYoWnQdO5QiLySCJ5tkEdHfpA6akt3fQ3cI4t3gvBU/DDXmFT3pUAqb9KcTqU8vQi9TJc3tt1cvHpYrSteA27gGOatYPfVEMhmUdc3MMqaUgDEspTxGzbEqXhj9OCpHE+RF3NZ4a6w7RV55QtrsLh9yU4VTfIsazfdeht9VS/T9fapvsVMmYVgCs1ae1aknqnSkOc6xiz9641T34fp7MN48SWITGIDEfvPIsNFHG4mpFB7mAsipAH4qa3KQ1juZqwfy73+Co1fYkANf8i3DMfstJT76ESlujYCVF8fL9VDh8AwfFJYdCO/WmJxC90Fkl3XsV4tKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVqRswTZIovSYa7DsdHhq8kW5RlpQ3GzioidRX1g1rg=;
 b=zv8TsxR7oz/sVf9poiaGyvY13SNLXUtSiDVufP72sSdXIfBjAE8p6ZEA9eEikiTHRjQq9TJUK11pZVAAHwVBle9UuF959h8SieuSD0bMGpv+os6MaIV3QJmXwz4WWTFUsTQImxpoc3ZOe2NOeKh1NlFTO/j9PJRX4G4c3DRKeV3p6qdtCtECCwLXnyqPS9iUZVz0Xxc+w8ad/K72YhiM3jz3fUvEaYbj23Nb7EUmraD2gMpQ3YeK0WxCv7Y5O0lK47PhYMWmajjD/1e9GEDV1yWrpo3Uj0KIHc8ScMJYITdr5crA5+0mUz5nsmJAY42i9BtOZNZuEsMZiRI77bHDug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 05:57:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:57:18 +0000
Message-ID: <77cca9d7-bc24-459a-9694-0d522d3ef90a@siemens.com>
Date: Thu, 11 Dec 2025 06:57:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8a3a79-977d-44fa-3a51-08de387a242c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dHJZK0VsL2ZzeVp6YjhJZDNNU1J2UXBCM3ZRenZIMmR6My9iUzR1UjVPaUVC?=
 =?utf-8?B?SDJoMDZhaVMxQVZ0Z3E5RFUvQ2ovY2FoUUhCVTFDUHJXV3U4NGlhSThMc0NC?=
 =?utf-8?B?TEw4Ui93VXA5ZS96STFOSkZaWVNEV3FuNlJPR05iZVpuSitiL1NaNWlhMkcz?=
 =?utf-8?B?ZTdTUHY2UmxHbWFSYUNYTzdNYnk2L1ovT2MvSkIwbVZ6dnBvOUJCdEdQYm5R?=
 =?utf-8?B?cm5vaC9aall2ZU9NaU1TUFVpZ0lQdEtyblF4NTNNYlZEb0c0bHgzQ3lxYmlG?=
 =?utf-8?B?aU0zVk5waDl4MDU5Qkx3TXQyNlBubVE4T00zWlJ4VlVabkdiNUUyeWhoQnRy?=
 =?utf-8?B?ZHFvKytuV001TDlLcUxld2RpUS9nc29nQk5odjhRdTFoMitPdHJWZk1pUWFw?=
 =?utf-8?B?U1FLWnFOYmtNN0szUnNneVlWMHRsdU5YdU9YS0hDS3QwWDNyV1JqY3VvVVBP?=
 =?utf-8?B?Yzk2NmtDLzcvMDlDK1BrVlZwaWZhRDBtMTFrcTlTclhVd2FJUnZxcHFVS1NL?=
 =?utf-8?B?R2gycVY4U2hyN3lHRGl5VGtOcVhYbkhLRmNxbFF3cVI4L2JqS1ljdDlvOUZx?=
 =?utf-8?B?ZTFuNUtnTWR6YTNHK2RwaGRHcldicUpVVWxVb0N2Ulg1SDkrVy8zNnR3aFNM?=
 =?utf-8?B?MlZrL1o0L0h6VEE4NE5aVlB3MzdzZTNkQVk1U082a2ljN3BKRC80ZGZhd0RI?=
 =?utf-8?B?YjllNnlkN0I4cERtaE9xSTlUdWZyZUFNK3RrbkZBbUxOVGlMUFpNZGIvb2NX?=
 =?utf-8?B?TkNkTXJoeDJzTEdRQ0lLRnkzS0p2NFVVdmpFbU1BcGR3UWljeFdRbmU1Ymcx?=
 =?utf-8?B?UlpZck1uK0xHTmZrSDRjL1Z2MWNKS3k4eEVTSGxxZDdyZjdYMWdMUyttaHlN?=
 =?utf-8?B?OHY4aUlvUkdIaHJCM2V2Q1VoM0VJSTRqenNkMEpraVFEUlZBRmRKWXdyZEEr?=
 =?utf-8?B?R0xDL3dYNTY2bk9NTnBhWERwMWJvRExZa3Q4WUhuM1UwalpFNTJnczNmbW02?=
 =?utf-8?B?c3RJb1Z5TEFERHp1OTVUV0VHSXRQTHBiTUxUOXBGdXpUR0R6VGlLWm8ycGlF?=
 =?utf-8?B?WjQ5U1JCNXFHOUhpbXlIcDN6Y2xsYXpTQXQrM0t1VzZNRWkrY2d2dE0rcHNo?=
 =?utf-8?B?U0dxbnB2UkdwdHVWdnExaFk0WkZIKzQxV2VJY3J4QnVXdUc2U3oxL0piODgy?=
 =?utf-8?B?RGlvbWtKUW1MKzFNNkIrblRuYVBpcS9KOGNqRTJORUhaK2RiQjdmUHNKUVNB?=
 =?utf-8?B?ZlVCWUx0MDJ2eUxpTnMzNWMzbU5YWk9wUmQ5K0x6WEx6dklWU3ViOEY3eUxh?=
 =?utf-8?B?QVhLTEhiNklnVVdINXNGTk0wVzJYTW1scUtqZE5MOGxXLzJoVGpmck5zN0h4?=
 =?utf-8?B?d0xPckpCR1JwQ2hFTUNNT2dKem9TOTd2RXQraXVtQzl5eVhlTDN1TFlIV3BZ?=
 =?utf-8?B?Qnd2YStvZnl2UXB1bGVzUi8vR2lOTVhWSGF3UGZHQkwvSm14Mkx5U2RkTzln?=
 =?utf-8?B?dG56Nk96djA0N0w2R1VFclhnMnpTNklIak9ySG0zbkIwRXZPakV3S01ENENm?=
 =?utf-8?B?K1hqYzhNeGlSWDQzNFN3c2VVT1hBT1R0bzJTVGxiQmpHc2dnM3ErSU51bmNx?=
 =?utf-8?B?YXFzQTBsUzBLNm1uMEI0dWxHQXk4VVhuRk8ySE5WMlR6MXVXaVlCSTBUZ1ow?=
 =?utf-8?B?Zk5kZmpiS21pMVFzRUUzbTRuamk4TUQyM2ZUQkFoRzJOY1hZUGRCTFZWTkFw?=
 =?utf-8?B?czBKWG1ueDkvTlpSOTJid3BsVjlBSWk3N1JIMTB4ZW94WmJCZG1mQUpKd2tk?=
 =?utf-8?B?QlhKOWNORWl6WXZGWGtXR3pzNkJPV1lBOGZ5cjJ6MW1wTmxCbUFxUEFyYlNn?=
 =?utf-8?B?bzdqNTN6ekljZ3lmZjdxUFRrZzE4YVZiRG9paXlueE1Zd1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0QzVitZTFd0N1M1SWpLSFIvcExkWE9DWWp5WmxLdFhsSng1YmFjKzVrNGhJ?=
 =?utf-8?B?NzU5TkExNXhRckZoVmhOUFo0cVduN2NtY3hMc1B5c2lYbmVNSGx6Qm9GNXJQ?=
 =?utf-8?B?bFpiMHAzVWhJUTBpK0xTYkk5Um82MDdGRnU3REg3S1kzWmwwT0NwUThnZmpX?=
 =?utf-8?B?Q3BFSXJucGdDaVliQzJEUTNIQ3NadWl2MWdPZnA0M0Jma2l6YUdyemJ2MjV6?=
 =?utf-8?B?cmNrczQwVXZ5Zmp6Tks3T1FQTFRqWE84ZExjYnlTREFNNVdBdmlPMjRUUC9E?=
 =?utf-8?B?ejZiMGgxc0hCc1JJMm5hSDhFOVlJYzJZVng2Z3poWWI4NjVJKy9mRmlBMVdE?=
 =?utf-8?B?aEFYOEFkK1k1UlR2c3MrbFpIQWxLbGwyd3lFaDQyZDQ3bUgvd0tMc1ltMDRw?=
 =?utf-8?B?TEJDUk9NQWxWclVEWUZMdWxCUkpuUkxZV0NIMmVkNTJhZkxYNEZlRkMzV05D?=
 =?utf-8?B?UmF1VHhQWHd3bXRwZE1aOGtIZjBkMmYrVGd6QVc2YXRHRmxHRERkVmpVZUw2?=
 =?utf-8?B?dnovNWFpQ0NKVmxkdzE0NmtiaDRLc1ovUll2M2xsSWRxZzJ3TGJySTdrQWhl?=
 =?utf-8?B?YnVJVDNtZjFKUUFKaUYyeVgrY1VnR2ZLWGlxb0F0SGE5K3FXOTZzUmVmczVD?=
 =?utf-8?B?RzU5cjdXajhvUU51c0Ftb0g5b2Rrb1hqUVpPSFF3RXk0T1NQK2NVWHp0aURt?=
 =?utf-8?B?d1NoK1hVLzQ3T3MyeGM4blBFMkx1SjZUd0ptcGJxUUV3cU4wbS9qZnlnUWNi?=
 =?utf-8?B?L2RVdzM1dDZ2Z2M2QUY0US9WUmVCU3I5aExqM0poQXZrMTVaWlA3S1N6L1A3?=
 =?utf-8?B?bkVlR005U1Q4UVl1ajUxNFNCSnR2RE9NeWpWVDNWeW9VaDhic0VuSURZTU90?=
 =?utf-8?B?K2Z3cVZwREEybTUyZUVhZERmZXhvUXpGOFdRK3lqNGpEVGUxTkROU08rc09o?=
 =?utf-8?B?U3czOUxYaU1BN2RmZ2IraEJTazEvbERhNW9VaWpPZ3l2Z3E0R1RhU2pSTGZE?=
 =?utf-8?B?V2xmOUF4ZVBpaW4yenAwUmtoWTJCTGpjdUZLZTdzZitWbkE2c0p3dS9OL050?=
 =?utf-8?B?S25kM1JaM1BmYWJqZFJMdVhITjFtbmxaMXltTkozRVRodDVCV3FKcnkxZ01w?=
 =?utf-8?B?VlVNR2ZJV0NXUloyWThYcFp5VFVTbEpHSXNRcTMzUldxTEQ5NFFscTRJWFRo?=
 =?utf-8?B?cTB1cjcvT3ZiZnhwb0VtWlpoRE9Bd2MwSHhEUllVQ2N4SkNMdFJ0TXpRNllT?=
 =?utf-8?B?bUxBVUJ6LzJmZVRtb3N2a0xvRit6VFZiT3JHa1JaS0s1REFCUjZPVVEzSmNM?=
 =?utf-8?B?R0x4ZVZ2Y0FHM1U5bU5MYzd4c3dWZVphdVBWVlpDT0p1Tmxub2hJaktHOEFw?=
 =?utf-8?B?RG94QkY3eUMxZVl6WGNYODFJTW5HbThyWlFnTW05YThKZlBaQThwbUJLSjFD?=
 =?utf-8?B?YWVZNHpTdExrMXc3SDVUTUVGYm1ZMzlCK1FiMWs1MFA3ejdGWEtUWFBsakRJ?=
 =?utf-8?B?ZXBxK1JmblhTV0RpZFJDQnlKM1E1SWZvblJHc2tid1RGWGtJdGZYckdUOUsz?=
 =?utf-8?B?K0ErM1ZlaTZmSlNmVjE2cWZyeDdYdWFnVVI1eFM0bU1maGZIZldzUGFZcVNM?=
 =?utf-8?B?Wlp3RUZhcjExN2JXekpINFhxS044dm5TNFZhQVk1cEhIMytWem95RkhNRTl2?=
 =?utf-8?B?ci9oYStGNk4yQ21kbWdUQ3VCQlF4Qk0rZy90eTdxMEVMZnBEN1lFcEkvUENX?=
 =?utf-8?B?clk1am9IMWNNcCtJdDRIemRhcUl0VDFqUXNPTkZ0TkdLNWprRW8zWm93Ni9z?=
 =?utf-8?B?TmFmRjdZZVpid1JnUFpDeWJrMU1HSGRZeVo0bktLK0xLMzdvWFYwbUJVUm13?=
 =?utf-8?B?WUE3RkVZVExnNElBcGJHSXFZdDcrN0M0Z2ZFLzc1YXNyYWk1NHpqMWVaTXdY?=
 =?utf-8?B?dm8wdU1aRno4QlVEYkcvOTVmOGkzRUZEcHFaSWYvQXY4djNSQjkxVjNNUXlp?=
 =?utf-8?B?bnhPTjBtTXRBVEpIVDQ5VFdScm1xdDdqZWpxaTJ0UkNpM1kzcndjOGpCQnQ5?=
 =?utf-8?B?S2orWDNzZW5zam1RSFRNcFQxL3ROTUZhcGVtckY0blpFM1lYakRUV2NubGRR?=
 =?utf-8?B?VG1EUmJzL0hRYk9rVDFJdWJ5ZjVTdWFqcnNUWVRyMVlyaEVRRWRqWGs5a0xr?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8a3a79-977d-44fa-3a51-08de387a242c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:57:18.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVULC8yDb3dWhQjXTUnTumNb6ydAC47L06G0mt+NPXx59sEpmzO/b2/oacyEM+LtwPrDC05ruKiJhlVu5qRNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5653
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Dec 2025 05:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20966

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=12&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/12/cip.2025-12-04-12.03.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Dec 11 05:56:56 AM UTC 2025
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
  Status: *Late*
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Dec  9 09:48:21 PM UTC 2025
  limit date: Thu Jan  8 09:48:21 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Dec  2 05:29:12 AM UTC 2025
  limit date: Wed Dec 17 05:29:12 AM UTC 2025
  Status: On track

