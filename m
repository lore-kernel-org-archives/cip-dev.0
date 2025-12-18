Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F60D68BE5
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 07:02:32 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36147.1766041343874720030
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 23:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HNcapF9d;
 spf=pass (domain: siemens.com, ip: 52.101.66.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfTeDaRMV77gVjpXLV4RM/z8joYF5IBTP8jzG8I49zk8EXR0tYoK7UfiHol+qvLTfBr5bGCMkonG4zZ6nM1JeXt5yL8u64RPeBAxzjfYThpZsUV+7Kq47YVm35dggk8y9Za4JyOz8eQHVtb6ms9KiAR3GDIk1cdHJM9szhqSKQKaTRXvkiopupRVP9FBYfl8FkbUg9ZvDM1GyZ16grrLQN7LaC8wrYQMOdfS6z5xkbuBCyVp8RlzEIQl06YoR7iOxUqaYeKpq3dpdnR49kT5lOLr3OFD91DyFCvAeCEA41nO9iTAIxzEB5lQ3+GVDShuWm/N6DwCw6UCq8VhIM0ROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viubGy+pnMBPuJTJjbKYH3WpzteNvC0ktrh6XbdF0dg=;
 b=T/sktGrWUAly9VKhF3S1ApLuH0T1+O1oyUuvcLvl5bg3VT0/PkGQs6th66B9YD7WVTI3pqS0bQDPYvqmgBRtab+9iFD/6C4Z9fXoAXCs8SyjDk1P2pg81gW/SAP0HKqZcQT2HtumP409xY7KCmw+Wn6SXXz+JeHvHD8D3x/oqUFvbJeHTTxQxTy51VZ5YUOBZSs7JQgnaScTgmEolB3VDf7yr762m5vyGUbcUnG72cOGVqaGK4Idn3XvE3whPfW6T272pdNjTMnhx7DFET7FVMAbU1dF/qFlyfQOtBcsXiPoJFx47gDMXqYHrwJFSjwJh+davqN7M4/otL0u2InO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viubGy+pnMBPuJTJjbKYH3WpzteNvC0ktrh6XbdF0dg=;
 b=HNcapF9dFPq9gSkon7KakvmeJCnzD7vGV42udZuUyxG6dDg47ntzVUPgQzpcBHKpnkrP+E4ZRY2g25184jrrVm4A7Jh+PidEHF5ztQ64jkqfM+O2f2YdG3Inur+hm8XMkDqwws7bbK7lSUtDRGeIBU74hoGyLH4H9O0EA6U6hPJZltCmxZYd/ZJVMwOtoFsloiKsaBACj8e77vXyXomY34qnAnUxR+inS0JOJNKttTP02S04PHc8vm8ufF2P2LmL1Hdax+SnZc6RLUlHtwj7RKPXcMH4rxmZ1V7wZhLmJKdsUITKreks2UW86lYFco0yQ3yQCY6taNFvrpPzyvn5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 07:02:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 07:02:20 +0000
Message-ID: <258113dc-28cf-4348-9555-02eaf6741132@siemens.com>
Date: Thu, 18 Dec 2025 08:02:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: b13a9232-d696-4dca-a430-08de3e036304
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTN0a0xaK2QrWjRQTC9aVmNFeWxGdjFVY2VwUURtdVRCMk1oSGcyalRVeWhO?=
 =?utf-8?B?V0ttbGZ0bVNCeDB6MmtzRFErZFEvN3hRWmNvSzVqY1Azc2lrak9ib0tvVnh0?=
 =?utf-8?B?YXd1amNhbzJucUhmZUVnZjNoaWFBTVpNcWI0VWFVa1I5MlRUQkxyejBWSmtE?=
 =?utf-8?B?UDI2RUNrczZmWmdtU1JKN1ZDNVVCN0pkemRWRG5odnUrVDEyTGF0eFZIQkRI?=
 =?utf-8?B?UlFzMWtYQitFb1Y5S0RCdE5GMi9pZjFGR1FiWlBNWW5vM3J5T2ZVdmQ0c2ZQ?=
 =?utf-8?B?Wkk4VWR2RmFlQTMxS1QrM1R5R2hwQ2IyV2pjNFZLK3hlMitSUXh4OFRCM3Vx?=
 =?utf-8?B?VmxMM2ozejROeXRxbllXMUdESTNzdUNjREUvVWRkT2gxQU53OWEyM2d5dnU5?=
 =?utf-8?B?M3ZpanhtMlhlWGM0MWhkU3ZGSlN2d3dYREtsU2dneTBOb1dydFBWc1RVaWkz?=
 =?utf-8?B?ei9OSFVZdlUyN0FweXJuWm9VT0tZbks2S0VXV0xoVksvdnVqdTFqWVdYQUJt?=
 =?utf-8?B?RWsyMkNHaWY3NDEvZ1BqajhCOHpoSFg2VTUycnZTNkkvcU8rWmRNQWxSUERh?=
 =?utf-8?B?TXVpTFVzalJEcVp2alhOSzh2RTJxckpBRUNySVdsNVZJNXp3Z1RDaDNzUnhO?=
 =?utf-8?B?Z3FuYWZCNVpWbkJWUVVMUjZoQUVtcHI1Mmd3LzRNbXVNaWJodVpFc0t0L2pi?=
 =?utf-8?B?VXYwS3NzRU9pbVMzalVxcWRpVzgrVlJBenBQVGhxbDZuT1U4ZzBlVjUwMzhV?=
 =?utf-8?B?VWFCUWhZVHNrVkZXNWJSU0tMMks2RlcvaEZrcnRtUmE4US8wdTlpZzkvZUl4?=
 =?utf-8?B?aUZPRlFIQ1psODR2ZFBKRUdKa0tWc0ZNNkFVbkdsZ3lNbjJvTy91cVZRUXJ5?=
 =?utf-8?B?bkhOeUEzNWNJMzdkcklyblA0ekxvZGN4K3lvQWs3ZnhlRzEzYVBsUzQ3cTgx?=
 =?utf-8?B?OHhDQ01NcWZrMHlkVGZQNWRyeVY0clQ3QUxDWm93TUtnOWFsbHZ3VXNFeXlM?=
 =?utf-8?B?Z2wyc1dzNlJCMWNtY3dtQWVpSk8zc3JoeHlEMldhWEtzMExsMDl1QkhTU1Vz?=
 =?utf-8?B?QlhuRWY2dXBaelYxb1pZUmIrYkVmSVh1TTZUd3RTbndtbHhJOXdOWnZWVDEy?=
 =?utf-8?B?cFUzdFI3dDNyaXQ4aVNDSzZ4eXc5K3NkdzhzN2dIVU84dUU4aUxvV2ljYUtj?=
 =?utf-8?B?Zm54MW9yWEU2ZFBDanh5RzdLU3NEV2txS05ZY1ppWHhrTFFDOU9BZnE4S0lR?=
 =?utf-8?B?U3lRYnFnOWZIWkQ4bEUzckJLbnJCNU9lb1piR0dNZElnT0FESWM0ZExmRk9l?=
 =?utf-8?B?U3pFclN2RHpWVWxXMW81a0VpTkFWd2QxbjF0QkhIOFE3MklIdklwTFVNb3Qr?=
 =?utf-8?B?S1lxQ2lzSG1wNnhhTjhjNHI3ODBSSFE5VkJ2dlcwMnZ4bS9lQW8zVGFndkZa?=
 =?utf-8?B?bko2Q1BPclJVMm9KdWpNeThONldnczByMnk1cWJ6ZmRTZGFjMmtnd1gwWUZ3?=
 =?utf-8?B?ZHdWeEpIQTFzbWNnZllXTG1hSFIzbDJkT0VvdEJlZmE3aTBzUVRON005ZDQ4?=
 =?utf-8?B?Vk52Mnp3dmFPeUN3YUtVUVdEZDJEQ3g1YlF6WS9XRUNPOWgrT0RBRW9uZUdB?=
 =?utf-8?B?NjgrcFZVSEhtODA1VEdsSGk5aXJnZWplVDAzdkg2a2lJMzNlcHdVV1RRSXNZ?=
 =?utf-8?B?Ym45QmhGampYTFY5WEowUkZrYlFldEZHWndkTDI4dUVFeXBYK1owMWwvNmFE?=
 =?utf-8?B?SFlzaUtYdEhSZDFoQlFhMjc4SUp3WFJKMEExNm9IQ3pvck5venNSRENiSmpM?=
 =?utf-8?B?b2FYL1VUcDFwNGRya01EZS80ZkMreWxHZEkyS0IwcStMVnJWeEcvVklkSFQ4?=
 =?utf-8?B?emV1aXF1SlkvajA0T0RBMS9hZlhFOXo3S1V6U1B4VncrT3c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NG50RHZ3TWNDeEZubzViTldEaEpZaUN3R1dhVXcyTFpMTk5SMWVTaDVWY2w5?=
 =?utf-8?B?cERXMGhGSXdzcW1hN0gzaGxLL2JnWjVBVDBCSFVZYXdZZlN0dEl6aTBiL2tO?=
 =?utf-8?B?SUw1MjdNTmhENnc3MVBaN2x1VGZwTDdUVEtLTmUwYUIwVXYrRzB3bFBPRE85?=
 =?utf-8?B?SmpLektsRlByb2dESXdzTllvdDlRa0MyRTFWV082aUJkajVIclE3S0pCeWRm?=
 =?utf-8?B?alY3YlFjSU90eHZSSWZwRTV5YWh6MHZ4eWpiR3VpNVMzNGRTdVp2N0NhTHpK?=
 =?utf-8?B?aWRMa3gwS2d5TmFzcno4VHRhUUsvU2M1Y2U3NTJ3QWowZFNsRDlTUVZHQk5k?=
 =?utf-8?B?V29JdzJnRUZ5b08wMTM1S0UrYm01UWxGdDhvZ3JyWUZBdmhnT2JFdVk2c29F?=
 =?utf-8?B?MFIwRTZWWXFyQWovWEtKU1d4NXN6bkJmemlQMjdRM0VKZnNVNkRwWEw3a0Nx?=
 =?utf-8?B?QXNib0srRWpjMVg0WGdNWE1hSlJZNy84MGpseGw4MkxSZUtWc0FGOFNHT3RX?=
 =?utf-8?B?UVIzOEtyOGtMWDhXNmZJa1F5a1g0RlFDK2E4WFczaUNVNThkMlRrYitGTlNj?=
 =?utf-8?B?S2lMeDNEWXhoZGI3bkZQUG5Hc3dRNFBpdnpWM2VFQWEwcEpCckZlY3pKWGR1?=
 =?utf-8?B?RGtIb0RqaTl0QUVCTEdnQm1QYzB4Si8rUlg1bG9CSWZvbU5hcHR1ZC9SL3hQ?=
 =?utf-8?B?TUJXSUhGQmNZVjJ2cnZ5TjZLMmYrUmJRRjJsUURLekNmYjJQR2RPSkwyTXVm?=
 =?utf-8?B?L1V0Q3ptY0pUV3ZUNlZEN0VNVzlYSk9JVE9RdDFJVEpMYTZ6TkF3cnhVYkJT?=
 =?utf-8?B?LzhKeWRONmtFZGxEL0RoZVM5c3hqNVhZL2k4eTlIRS8wb1Jhd0xqekphS2k5?=
 =?utf-8?B?REs1L1JNSnBlWm1TM2JtQndUN0hHVzQ4ZFF5MEdURmc0OVplWUh6MEtxZWdU?=
 =?utf-8?B?eVJxZGxGa0FNdlYyUGVHWEJqcEU4eDVBNzNhSW9GZTE1cTNoLzAzRUpicldo?=
 =?utf-8?B?YzJBSUh6NmdLekRYOUxpK2VYditLWmMyZkVoZkg1Z1F3VVg3YU0wb2dHSnFu?=
 =?utf-8?B?M1BjR28xOUJ1SjloWjRaOHFONG5JL3NNcHZhbGc1YlZyTFFNRFVPTW4ySkpF?=
 =?utf-8?B?OVJtTzJDeWZOMXcyQ005M0g1TTR2a2xUaFpzemNuQmE5Z2RrTnVhYVEwM3Jx?=
 =?utf-8?B?M2orYjlQYjJ4L0YzdGxmaG9mRlMrbDAvU1M4dVUwbnVsSllhWTNybjVuOVA2?=
 =?utf-8?B?azJKRExEWXNlYWFTTzlMSkJxREF5UityS2tMc1liREUrSjJYZGx3ejErR2d3?=
 =?utf-8?B?ZmM1ZDNsZ3RZZmlDYzNTSjlualVrMVU0M29XUnNwRXNYanhueFRDY2V4YXM4?=
 =?utf-8?B?OHRKWUp5Ym5uMVgzcXB0eGQ1Y3FCcjVJQXdOaU0rNDV4Rmx2VE94ZUFsS0R3?=
 =?utf-8?B?a2ZPb0xtSkFyUnhITlRxTHhvb2NFcXFJUFF2SGpuSUs2cTBNQUkrQTV4NE9N?=
 =?utf-8?B?V3pLNFhPVStVTXhMQlZaMDlVRUJqYXFiZ1ZmTW1NNmJBTnpkVEVYcTIyMzFj?=
 =?utf-8?B?U1o1ZUtZY280R0lUNTZvaTYvSzFnNExWSVRZQ1J5REZqOEREaFkrRmQ4QVJq?=
 =?utf-8?B?bGlhTnN0bGZ4RmhUVGZYeVdSSXUvdFhTVzc4UEYveGFLTzVNQzRaZ2hRclFJ?=
 =?utf-8?B?K0NwWEM3dTdNWmxOaHZNZ3lKQW42UXovNnVHRm5ibmVESGJvUEFJa2xrbVo4?=
 =?utf-8?B?Tmk5aURQeks1d3IybXRQK0g0Sk9sT0c3ZUl6LzB2QkJIUWUwY2Rxb3RvZDB5?=
 =?utf-8?B?SUZkK1Y4dXpFR0lFT2V1Unk5dU9pSDk0bndoUUJnemdNazg1bDNXeWhQOTBv?=
 =?utf-8?B?NkMyaUlqOTlxZDdZMU1nL1B2cktLTTIwWStuTzhUaTJ3c283L2M1N2Naekd2?=
 =?utf-8?B?YVR4VHdXQTZZSlFHOWhoNnp1REQ3dFM3OGZzUkd3cUNsZDEwdjNMelE4aVVZ?=
 =?utf-8?B?R1FPVjFZYmdFQlZ4aWFvVXJ6MXBnd3pkanRLZjkrdno5bkVRVmNJNFZxQUxK?=
 =?utf-8?B?ODhlZkRvQ1FOMXFEczR0RUNldVU4Nks1ZzZmWXJJS3NzRkFkVWlFckRZUTVL?=
 =?utf-8?Q?zPGTyOuV+YWfPy18aJaiWz9x7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13a9232-d696-4dca-a430-08de3e036304
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 07:02:20.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akfh1amPkA/dRuK6RnM9WcZPH1lFYsHMd7IiOUNKscXz2ZyjlFnB+uagU6yBbTydX8YkxGQ17GuC9ZeYXdKPqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:02:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21123

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=12&day=18&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/12/cip.2025-12-11-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Dec 18 07:01:39 AM UTC 2025
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
  latest version release date: Wed Dec 10 10:14:17 PM UTC 2025
  limit date: Fri Jan  9 10:14:17 PM UTC 2026
  Status: On track
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
  Status: *Late*

