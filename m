Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDFCAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 05:48:34 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.56])
 by mx.groups.io with SMTP id smtpd.web10.2206.1759384108512538783
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Oct 2025 22:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vacD+CzA;
 spf=pass (domain: siemens.com, ip: 40.107.130.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+sjQpkwY2z5aFjxYAp3N5IBaXkGDQ4O4xAddt+dKBdEVXKVwyVAgnZvnCY460pGMlzcKR4nWFpZGE5DAxXF0flV5nc06xpq9UWK8eKYaOYULl5C6+KItnfo+glu1lAQ7vwGhr4GJEHHIrTDMRjVzakwatlaFHRGlXQjF4ujnu8fU062VWpFtM790znO2JojgK97+li5CffW2RWbHOel6RLHTNh9MxNU0B5nu0gF5FmQ36FboODRlWiMh0wgmHNVCjIVUTf0fukFeGejBa+38xytcPk+k5VSKzGNPZbAUtYrJdKE6qjhEnOGsCsQdcoLDydU01ccMsplWXsj3Xy8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+MvcfWicq0oq0e1wDXgmcSX6mXpvanZkenm0NuOFpE=;
 b=BH0k5wQtc7ZEvRZYxfgMaxy1S9Ok68n9LDo6gf4xLaL985DO48KZF+ttdD0KtGcFpz7XB3pvN239K/mNYoBsj8SGXGJceBjlgSzc1CYyPSkUNllmevSquCJYduuxiJXbQxpE4/8ehd6zNz+qAsj5l3+2gVTfLaYJkmUAMKqnljxqVQsFGA4yXUhcqSp0bAedY/VExMyQyODCI8JjVp6r5mpvTBmmHCsF8RgAFco9mIxGAm9CzSs2uPk8m3D9rl3bNEF2Bk4Y6lo+1p63hGl5mua9lbYmOefDLTSEF+6kzlblf+C/jPOgLqhRqOJElfSUIznb+40C1GUjcm4ARU7j9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+MvcfWicq0oq0e1wDXgmcSX6mXpvanZkenm0NuOFpE=;
 b=vacD+CzAxx+do84sUaf62L9iQXyE/qG9XAB3GJoYD3aHc71OXCj5ZkI8u37QXpjdVnMEX6g+GgO50ol3cyOnH3HPz8jx/HjK3D04amSeGGW200L6rXBoZEvUHNbTdL3PrUSMOc4WxOtgjqNZg0Rs4hf9dsQb+tm76G+RBrATFIjw1TkJpfFKWU+9c4vwYuZu6NH66jfjzP2UvbzdBbwqH7X9CwYd5G9AXHUMLE5DjxFi+VS91Xxyx/GG3w5+RjGK++zR9FnaX3HLPbBXSd1PhRaFPFJmAWLsgqthQ+rbgyjvtyWoiYcMlWt5bpptd3EVE6ZynWyRyksqTk1UrgLhDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 05:48:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 05:48:20 +0000
Message-ID: <898435d6-3022-4cb5-bb2b-c515758fffd1@siemens.com>
Date: Thu, 2 Oct 2025 07:48:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 812690c9-c13b-4de2-5d99-08de01774b30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TlNMNXpyd250WlZxU2ZldUUrNzR0VmZheGorVW5yenEvamltSExzQXlPanFo?=
 =?utf-8?B?OWlEMTMwQlgyOFhXNXlNaTh2OEZVL2ZhbG1xSy9WN1pKK3BnanVpUXhjUDUx?=
 =?utf-8?B?SEdBdm9RTHE5ZXJQU3U4RGpWd2g2RVFoakY4Tm9PNmZqd0ttZTU5eHpqdjZX?=
 =?utf-8?B?Y2UxTEQ0VjYwa0pUb0dqL1NRL1ZGTDBJckFFT3Z4MTNiSHJ6TG45THFaemNm?=
 =?utf-8?B?N3cvZlZTRDF6U3JkSndQMlM0UDg3RFhkWU80U3p4ZElrUnhWZ3g3YzM1UjhX?=
 =?utf-8?B?UXEyaE8va0R4L1NxNGtXcFBadno4NmdnZUs2dUpiMVpYellyMjVRdDVncXk2?=
 =?utf-8?B?YW0wRUZvUUxwbitmd0Q5SjBPQ205cjhjdWoxbFliQ2p2K0FPTFdxVzZsblBu?=
 =?utf-8?B?TUFsdzI2RnliOUdLQk9NcHRlYStVejlBU1Q4QXpVcnNkODBNWGlJZUVvQlJW?=
 =?utf-8?B?R21kUTZUT3NlOUJ2aFJDUGJWRXhIaGNiYVhZOXJ4dEFja3pHblk0eFpQWFVW?=
 =?utf-8?B?cXo2eHRYeEhmUDMvS21wd3BwNzVkb2dmdjkrUUhxcEpVVTFiK2QrWjZpMWR5?=
 =?utf-8?B?RExwMGtBRjVvbDM3U0VINUJ2MW0wUWZhcmEvN0tadE5uOTN0WU5XdDRydnRW?=
 =?utf-8?B?MFVBaldkNHFJdmJ4MTRXV3ZNcWtoV05UMm00aGhZc2ZaUlNjT0ZaaUd0MjBa?=
 =?utf-8?B?dWRUNy9MUGFqQ1hYbUM5QzNvdHZBZmNrYUhpYjd3YmxlZTJaWVBvZEZqZHpQ?=
 =?utf-8?B?cWhsVXZsNmV3TXFQTU14NzRxT3YrTldwU0ZhU0l6MlFTemdnZytGeWNGbGwy?=
 =?utf-8?B?NkNWTzNxbnBjN3VBd0dHc1U0SU9jSjI3MkZCUThKV0VjVzV5NzFmc1FsY1pV?=
 =?utf-8?B?YjhWQko5aWZXWDBmYUw4VEdYU0QweHpkME9IUjBHcG0xVWl3eE0ycVFJdWNv?=
 =?utf-8?B?d2pvN0FHTjNTRVRhSFFHRWxhaEx3VHFWendRbEo1RGFhaFdqZlVLU2F2VzhO?=
 =?utf-8?B?dFBRMnhyblpLMUZzcjF0NWszT2pxNmdVOENRSzB3Q2s1T2thQzMxYzZxTkFm?=
 =?utf-8?B?dFgwM0JOUm5DT1dtaXlIUUszaHY2UVZjVVVvUzNhTWlqdm1QK053Z1JFWDA4?=
 =?utf-8?B?VE5ZeWM4Zk5OaEVKN1prU0Q1UDM2RC94QXZMQ1ZVWlJkZFdEZTA4UDBnaHJi?=
 =?utf-8?B?d0o5cWNqL0hlN0w3QnA1cGZJWnJlTkJ2RFNaa0N6UGJwTEVleTV4SGhhNHJl?=
 =?utf-8?B?WWxFNk15UzFPYkUzQUtwTDNQM1hFMjNyREY3UVJVRUtwb2ZaZDZRQzh3emVU?=
 =?utf-8?B?cUtkUW93RG90REtEdTNiYUQ2NHBSdG81bTBHYzJMbGFCQmVHSGpuUVRuNzV1?=
 =?utf-8?B?bkJMK3BxV00xY3UwZUExTXdBNys4RlJwRmZCY3lCdmJVZUQ5QkNuek95ZUdC?=
 =?utf-8?B?ZmlVeGRFWk9FaFNKdXFsMktDNDZ3alJWVTZWdW1lSHpzK3hUZ0tSK3hBbWRw?=
 =?utf-8?B?S2hGS3AzUGZFbGo1VDNRZFFlZGZ2SEF2MmIvNW9EM0o5cWJoMCtPT0hjWmdr?=
 =?utf-8?B?Nmh1MFVubWwvVlJnOW8yRndwYWQvVXkyVDRoclJSZm0rNjFUS2wwN29wRWl4?=
 =?utf-8?B?WHZSYWhMdFJld0xxOW1RNnJaQ1JRY3phNThzbktSaEh0MGFvQUo5dnhjREc5?=
 =?utf-8?B?TFp1ZHh0RkNtS1lDbndtVjY1c0RRN3NkYlE3dTJodFhnR0pSc1VXV3NOMWFp?=
 =?utf-8?B?cERXZm8zNlhXOFBzNGZaK3QyM0xvQkdiR0Z3eEM2MHRNenpvcnFVOVV0L2pT?=
 =?utf-8?B?ZUVacUlsWWx0aGduZEs0VHQ0Ynp6YlNFWFpjZGgzVTJnYmhWVGNDakFXQzkw?=
 =?utf-8?B?ZE5LZDMvemdYSDJuQXdPeXZPL21TU2QzQ0VncEFvZGpVUHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWd4WVN1dnNidUJGUHk3QkZMUEFNYm5jZEREWVQyZXNCUyt0Y1hxMjlNR21C?=
 =?utf-8?B?OW9QRWlJYzY5Q2Z0S3VNbzhDd2lrVk4rdnlxVUsvSHFkeVlvNnd5QnoySTMy?=
 =?utf-8?B?bkVwS3BtTzA5NFFGS1JHTThFSGx3Nkc3R2RDMHNWeFdVV0R6dVVMZnZUTHFO?=
 =?utf-8?B?ZWowOC9CVTEzL0NLelBSY25naGxNc0NjbWlKYk9UWjN1Q1B1NzFLNzl3cVVi?=
 =?utf-8?B?WWNTZVlCbmVjd3g1NlkwWEZpSi8rOWdIVmFpUDNIYXNvN0FLc2RGRzRmdGxz?=
 =?utf-8?B?cnNnVGkyKzlPSWxrZWZnQnBSSmt6ZU1FaGE3WEFhamJick9rc1lQVHR5djd5?=
 =?utf-8?B?aTZQQVc1SG92MUdSdzdoa3BIME1DZUh6T1VkakswbHVKcUVTVDVaVDU4UUxx?=
 =?utf-8?B?OEZRdnNSOXJVaFg3ZGtQOWNGNGN5WDljSWkyTzlkU3JSSTBmTWU1Q2dIb1l5?=
 =?utf-8?B?bEx1YWRlZHUyNVpOdUpHRkZ6R2owdXZmUFhRYkpaay9HOGh5Z3hrUWFLTmxQ?=
 =?utf-8?B?U0JBMkNRZi9OVHJSWHhpRVgyc3ArWjVKRDhlc1RHWUVqQWdEVkdxRkMzRGFF?=
 =?utf-8?B?NWVuTUVlcC9JOC85YllBRHpjTkZnWDkzZWRVeThxTXYwRlk0WmE4SHY3TWhM?=
 =?utf-8?B?dHQ0V2psZEdMM3FkKzdnTjBGczJ4SWs3UlJmZW9VZ2YrcWdKeVI1RzNPVXZm?=
 =?utf-8?B?T0NlaFBQNlhxVS92alhqVmE3RDdYMlhwbXg5dTBWZmt0VTdJNTZXRTlabE1y?=
 =?utf-8?B?ZHNaSFA0endGRmE1T0tEcHZ6MjNodUdHVS9RWkVzVjJDczk0QWNqdDYrMVBT?=
 =?utf-8?B?ODRiU1czenJlekRIbU1Kc29XSlQ0dC9tbU9XYWRVb2ZVZnlvenBKd1hmb3Zv?=
 =?utf-8?B?VU1oTENsWndodW1ZNmo1Z0tpTmFhdWRUS0wwRGhvemNGallLSjZlNnBRNTQ1?=
 =?utf-8?B?WnFkVnYyU0ZBSkJzQkRNNlFCbWQzeGlZdGZzUlVjMkM1c0QxaTdpY1BkRGUz?=
 =?utf-8?B?dHlBMDF3SFZHM0RjMjhKa050YXdHTjBwci9mblFYNjhva2xCck53VUZ3MTVx?=
 =?utf-8?B?NEs5Z21ILzJlVFNuV29MWDcrQzJWWWRPdXRIeXltNkNlYkY3dTR6NzFiU2tL?=
 =?utf-8?B?Nit6UGxRYlVaSGRxRzd3YmhQQlJoRXJLcDhROHRxRnlPdEhLeU1FVTg3c2FQ?=
 =?utf-8?B?Y1l1M2xKazdFNktaSTkzblh0OFRWYmFaUno3Q1lydi9xRkZkb0JXY0JpY2U2?=
 =?utf-8?B?OEpQMUZvQi9MMnEwZnhnY3V3TExienB2Rnh3QUtZNVY1T21sR0R1SjVRM1dR?=
 =?utf-8?B?Rk8rZ29kTFpVRnBQSzRjWUw3TEptVFlmUVJYTGx6RC8xUGl2Zm02MW1wdm8z?=
 =?utf-8?B?MHB1eSt6RVBEd3RKMytNblFxVGQ4ay9EcjZhU0VWS1ZFTUloRUV4eGpDWnFu?=
 =?utf-8?B?cXR1Y0FaWW9KWHpsL3BVTThIWndXbS9iRXp6bGVrYlR0Y0lWcUNHR0ordHow?=
 =?utf-8?B?MWlnK0N4SUJmUzUvamZVOHE5VzZ3Z2tqRFZvUWRaZUNmRm9WM2VJbmRwNHdV?=
 =?utf-8?B?a2FVekcyVkpWbERGdGlKOUMyYUZNVXZHZU4rNDJnanpBYWlrTmpzUnRzQ2VZ?=
 =?utf-8?B?dG5LekFuT3crUGUwVTVINFNFYU1RSGpLQ2dlWkF6bEkxSVVHdHB6Y0llSzFR?=
 =?utf-8?B?R1AxNVNvWWhuY09mKzlUR1MrdXZ0ZlV4SEZYdEppaitqWUlCS0pvbDNLQndm?=
 =?utf-8?B?QWoyUEpSS0RSKy9RMzlIMlR1aUNvY1o2T3NwOUdJWHBlR24rMkorUUtneDJL?=
 =?utf-8?B?NEk0YUtlVTIwbytGdGhFdUZVbjZLNWR6NkdsOTRnZVdVUjZvMmNOY0RPT2gy?=
 =?utf-8?B?RVhrUGY3RkJBTENjMm9aZVhRYjJ6VHNnUW9ZMDBMdDlNdkw4Uld6dFJCWkxI?=
 =?utf-8?B?WjErSFYrVE1IeFVTNW5qNUQ2Qm42OTlWTVhVbTJOdGVSWWs5NnV5V2tpbmE0?=
 =?utf-8?B?QmdjcGM5MzZxYUlicjVQNW80dndpbjlXWmlwbkoxSzJsd2hPeHcyUFVWejlh?=
 =?utf-8?B?WWF3bmFmVVhyQXFrcitQWTNtQWhQMUU1Y1RXS1QxU1BRa1o5REJFM0grTkxt?=
 =?utf-8?Q?TKev76pU5qigeyW5tnq6+dgDX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812690c9-c13b-4de2-5d99-08de01774b30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 05:48:20.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnawnCWbqNpIakI09FPo/2EWb2/6YHXlj3yIvj/j1/hLkxL7+JK2h+bAASpuggvIwn4MrV9b72ZnWEBP0gmLdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 05:48:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20154

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=10&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/09/cip.2025-09-25-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Oct  2 05:48:06 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep 29 02:11:50 PM UTC 2025
  limit date: Wed Oct 29 02:11:50 PM UTC 2025
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
  latest version release date: Wed Sep 24 12:24:09 PM UTC 2025
  limit date: Thu Oct  9 12:24:09 PM UTC 2025
  Status: On track

