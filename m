Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FCCC3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 06:17:56 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.42])
 by mx.groups.io with SMTP id smtpd.web11.43747.1743056266343356006
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Mar 2025 23:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xx/02X1B;
 spf=pass (domain: siemens.com, ip: 40.107.159.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcuxr20i5zeOhwLClpfnm59ywcnjk1kC8umrbqTWVjvNiOe7u8j8eSCE6OW/cNUy0aj06VryadLXyWH/Cje8iet0c7lhZO02DvXQHOhX1FXdToX2xTgaV8GuFhgByKQPx8bzSsaNztDZLTAW2dGLd8GrXnAIKIubTxNnAasQolwNDp/tBdrL+grU68orGZRN8iV++XdNdcTWwbIuyMGhF1MqFoOjH3BQhk1dWmXehz/05v0HGjuGbO/Tty1RXMtenEXZbQ5dGf7t9/gevL+s+w6uqW6cKl1MlzefB0bQoTykqcf+DH+3Yn9x84rfyal6KOuwuCMFc1KcfCbuK1NEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBBRu4pXmz44ga5encmoLqs4Z2UGrA1sKXUa02gjFLk=;
 b=yITtCeN5D3GSe7t0FD+Rmc9oaAc1kOtrE0m5tTRTbRuIFqVwrtElU2Kav1I539CIzo4TIFYVsZBtZPkUAQoWjhVN2ssyHYnI3gYy1v4PpR5mDBQBMFdupLpYqloxyb5wgKLjBtXGwQqvhhxVOtSpTMsUaA1+9IhdLjYCBjxw1SvA5q8ZlzWaeksX/+iBTPH7/OkwzHO7cxeZyGr8NwS4i4i7/gkk+LxdBJK6yX0kAFbqbVnoa2iM3LvfwOkXsCdnOghlHYgGeVVPrLGeKIsZoA6F0Uu0hfsVMjqK3BBKRkK8XEDzbAzq/3xXQ+kHbCfBY6SRwshoBIIJK88LaytA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBBRu4pXmz44ga5encmoLqs4Z2UGrA1sKXUa02gjFLk=;
 b=xx/02X1BVsTBtvkDqjJKQuFwRx/EwzM+HXx68p85Z2DpssAWTvdHw8jH7IvUKJhTvB5gl9oWxHePbvWtlkAZHJNFLgBI9+YbZ487TKSnDP5Jm2QyggWfcO7l56zUoRqsVt8Q29hj4VITw6ss/sitpyE8HotxQeNTHayWG6x3OXf7ie9OO0K4eU03Kcf0UbZyIw9fzI2Uy3Y6+pwMP4su3k1lat1LNR0FxwGR5WA8+DNT88BEDrnBtCq0Y18tkIDRbk4VFJa+mNoWW2CCaP838B7mVUFGYNfFrBwAVdvZHpToQ8hRYv99/NiVWiDVCEIbi/U8WOCIQ8SvRsVJgBajoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 06:17:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:17:41 +0000
Message-ID: <91122720-81dd-412e-bcd0-a43ed2648fcf@siemens.com>
Date: Thu, 27 Mar 2025 07:17:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 881ef683-1e80-44ca-1d04-08dd6cf7147c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1pmbm9SOXZrcE1VZE4vbEtjMnNKTmloZ1p2T2dTWVFJYmFJL0NlNDM3L25B?=
 =?utf-8?B?eUM5Q1J5ZEhpbVJJdzdubWhEZGhhQ0F0bE1WaExpU2FPb1FPYW5iL1BjUG5k?=
 =?utf-8?B?S0FXL09SbDBZNENpOUpqNjVyVEdTeGlMQkZtTW5UTTJaTDBFend2VzFaMVF3?=
 =?utf-8?B?aitQYkdtZm8rTGpYMkd5bmJpQUlkbmp4c2ZLNWNJZXduaFk1OEliMTRocnNP?=
 =?utf-8?B?KyttTllqOW9SRTBqaVF2aGxOcm5MWlFuLzFuNlprRGxwaS8xd1VXQ1NSZXdz?=
 =?utf-8?B?TXdWQ09nSkFTUmlCSFJ1dERudDRHbElRUVJNVVl2RnJobGtUK2JlQWIxZFd4?=
 =?utf-8?B?cXVuUUVxbzZad2FwVDZhQlcyZDRYSlUwNUJyMnZKd1BpMGtHNWFyY0IreG1I?=
 =?utf-8?B?dDVPZm5FaEp6M0M5Q2o3bjloaCttdDlLQm91WitDTVd6OU5JZnF1bDdMbWZZ?=
 =?utf-8?B?c1d5a3FVcTk1b2pBck5yYlE1bW9WbGZkcmdjL21tZ3hHa3ArTDBrZ2hGdGVN?=
 =?utf-8?B?YjBsYlpDWXN5dzNteVVCTUoxaEdPcGtETmFiWHZYOS9MMW5MS2Rpc3hLd3lJ?=
 =?utf-8?B?QVNCSlYvZkVBMm42U21uTXU5RUd5a0MrR3NaekdpNjZ0STJUQzVtWVBwRkUv?=
 =?utf-8?B?VmFyTWNlYVVEWFZNZm9uQzFsVGl1K2VHa3g2aTU0K0c2Z2VkUS9lUWJaTHRY?=
 =?utf-8?B?MGdTTnlRdWIwY2hpWmhyOVNtTVc4MnYzN2FvSVhHR0p6TGVockhzaGVEQ2ho?=
 =?utf-8?B?UlBGSjZtTFExd2VHT05VaEh3cktrQTd1RmNXcmhweDRZOVR0WFJCMEQvby90?=
 =?utf-8?B?NE1US1RJSFh2QzlzWUlNSHk5bGY5cDFGT1g4YVpQQnBzRU9aU0ZWaE00Zm9o?=
 =?utf-8?B?TG5Tck5JT1dMM01tQTIxRFBJaGk1c0wza090bE9rL0N1Wk1zWTY5L3lFWUpC?=
 =?utf-8?B?NFE5cEtpRnVkRko4NjM0MXlSTHFOL1dMcEVnUDZjL2gwcTQ5T0tLOVo5M2V5?=
 =?utf-8?B?WE1TSkhteFJRNDJTNG8vUW1rMUt2cHBySC93NWRTRVl3YXFEbkdCTmpXTXZp?=
 =?utf-8?B?bUhRTEJzK3pHTWsvbEdSdHcydmZKNjAwRVNSekg1a0RzTUhVTnJuM0RUZUdT?=
 =?utf-8?B?c3ZTem1vV2ZjZHFzMll4WERHMm1XWDc1QkpLWEZWS0YwT3VwOEV1dGt4Q3JD?=
 =?utf-8?B?YTZvY2ZPbTJVbkZ4VlU1MHcwWGpXYnFaMmg3UUg2bEUvdWphRG1UN25KNlht?=
 =?utf-8?B?VlVXWlFreFl3dExzUzJPamgwaTI0azZkejRiMEphY3RUOXRYcE5Mb1dQS1c3?=
 =?utf-8?B?NVFMMzVyYVFnV2JtTzhrMkkwTlFkNTE5NHBHSEs5NThSdlB1M081aDQyanNu?=
 =?utf-8?B?WTNMeW53SS9kN0srSTQ2d3FqUyt2dUZxMDU3MURlcXFmMmVHemY1MlRTbHRQ?=
 =?utf-8?B?QXl3UnNQSHNjNHA3S2NhbEZtQnkycERFS3dGa3JSSjM1Z1BSQ3JZOXVBcUtR?=
 =?utf-8?B?TmJoRGJTUVFXSC9XQ3pLWkdGTmcxdmloOURHdzdHNFJPOWdQdUo5S2JlaHBv?=
 =?utf-8?B?NjJ2Y3gwVFQvTmxWT0FWRk1YWmgvVXZCaXkzbDVNYThMRHZ0cXpxZDczaHM0?=
 =?utf-8?B?bjVKUlZ0L3BsUEQwU0l5Y1AzRkVLVGpLR1l6Z3dxdHFMQ1BKanRRSmFqbVho?=
 =?utf-8?B?OHRUdU45aGFBdllDVm8wQ3JyZGZ1bGdwZzgvZEJ5a244OWwzSW0xb2FTbE85?=
 =?utf-8?B?VWZDdm5CdWRTc0E5MFVXV1UyU1JSMk13QW8xR3lxeTFueGZBcW92cEpRWVhl?=
 =?utf-8?B?dzVJYkhRTjBuOU5SYW9udz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjRWUlhTMHZhdUpHMGdscjl1TXFnUWNiV2JyZlduUitNb3hQVHJJSm9iQWpt?=
 =?utf-8?B?TnczUCtaV1ZiZE5lcjY4MFl1TzVKWXhyWjdIWStSU3pJR3JwMy8vc3dYcENO?=
 =?utf-8?B?Zno1WFNNd04yZkh6NURDdWtEVkN6VitCR0wzZTBGOTAxQm9GcllmSVpOek5k?=
 =?utf-8?B?NytXbTNQZk56OGp6bms4S3lXTjN1Y0dOWis2UGx3L1ozdUxaUnVIQ3Q0ZTZv?=
 =?utf-8?B?bldOVXhFZ2FjWTVkS1FEWXlnUTJZeDhqMDZpNE42cnYvcWhyNkdvdnQzTGFH?=
 =?utf-8?B?OHRlSEc1WDFWS1JDQlM2NUtoS3JBYzZxbG9acTFGUXd4MXdJOUZtQkYrRi9H?=
 =?utf-8?B?bEpMZHVGOThXdmE2cXEyaTJjMHRiK1NxeVlHZ0E0WHJzS2EyK0hoWnZORFpn?=
 =?utf-8?B?WDV3RDRCMW11M2lxQ0ZtVVFENGRYWXVlbmp1aFRZVyt6QVhqR2dvZGRJSmhq?=
 =?utf-8?B?UUNiVStGOWhuMEpKNE83aHoyNjU2b3B6Nk5sSVhocjZ4SFJXNzJKc0R4Z01X?=
 =?utf-8?B?bE1aTmp5a1I3ZDIxRFBDZUpRR2ljZWx2a2NtUUJiT04xZ2dQNTVIb3V2ekY2?=
 =?utf-8?B?c0JZZnlSMzVMcDV5QU8vVWZycmNNM1lpVU16Vm4zRHN4RXVFYjRHZHY3N1VP?=
 =?utf-8?B?V1F4QmQyclU4dTh5R3QvWDdEYzl3QUVXNUhNL21IVWhJR29ZT1FWdkREMU1v?=
 =?utf-8?B?bHBZU0FvYjVZUUR1T0NISHpzTTF4VTA4WExlazhLdFB0VVBZUWhLRTBnVWdF?=
 =?utf-8?B?dVQrVnEzaGFMbS9jei80aEEySWJ0S2RldGw0dW80TWZaOTZxNGYvVFBMc3U5?=
 =?utf-8?B?czFoa3ROQjV5OHkySEM5VVVkTnl2cU9TcGpmVnZacUF0eEtQWWcxbjNyZjFH?=
 =?utf-8?B?SnNGaHR4RHk0clhnTms4b1BmcHRkUmJYTTcvbWdhb3N6V3lROSt4OVRhL05o?=
 =?utf-8?B?cW9EeW02bFhCN1FNczF6VXVCWkt1UUt6bnBuOSt2ZjV0YVFNdWZBL2E0S1Zo?=
 =?utf-8?B?NWlqMUdEYU9OZUJhdFhiMjRybWxyelZ1VDMrOEZFeVNkOEFFQ2JKRVFJK01j?=
 =?utf-8?B?aU5JcjBEM0pscy9jNVNpN2szSzhDRWRZb3hQUk5sa2x0MlBGdWxMa3crVjBV?=
 =?utf-8?B?ck4wR2ZCMlEwMGhQdTdKbkZ6dVpnclZGcjduODBOeG5HSngwM01LMjh5bUpu?=
 =?utf-8?B?dEFUUUczbDJHYTlveEVkVEZRRUZTRlE2TzVuR21LK2RqV3NNM2Y1dmdjWllR?=
 =?utf-8?B?MDJHYmhIcHUvWmUzQ1JFa3hhZ1A0dk9zMVhWTEtEUzNjOTc0RDEzcTUrdE4r?=
 =?utf-8?B?cVRtMlVzSEIzM1pYWWZ3cTdGRFBhVWx2ZVlibE5IeHEvb3JBVmZRbW9VRHRp?=
 =?utf-8?B?TGFCRTZ1Y0N3cHZDQWNTWGJHRDNRZTZxN0NWTkhFZGh1cWdMb3NpWEp5bHF3?=
 =?utf-8?B?Nnk3ZWpVazhOaG1pWnBQVWtuVlR2RVdVYSsxRmFiTUx1TWcydXluUlFJTENF?=
 =?utf-8?B?KzB6NG8zWnkwdng2d0NtZUhPZ3AwQjZhem0vKzduYS9PbDVaOGJtN0QzekxX?=
 =?utf-8?B?UUgrdkt6NU5Pb0k3QTFQdkluQS9hTklBVDJtMGFIVEZNeDk4eTZrdi9nUnBV?=
 =?utf-8?B?NEViNHVLdkJOUk1uQ2k1UjNFSG1GNm4wUEhJZGFrS0RuNkNPUFl2SkZpaU4v?=
 =?utf-8?B?TzBNdGYrZUVidzA5c0lmYlRKaWRsOEZldVZaeDdVeE1PTjltSi92bUc1anhu?=
 =?utf-8?B?RllTMDV5YnpXanh3ckZkQU1IMVBIalV0U09Gc0E1YWtWNnpFRWN2Qkp0eVp2?=
 =?utf-8?B?ZlZUTGdRL1BRTWUzNXRLajJIc1NnOFY2bi9jeksyanR5enUyMmNKTmVWVzlw?=
 =?utf-8?B?Z253SDNVQ3RJNjRCUlNtL1ZvNE5QYWpvWmY2aTI3czRSM0ZId29jeENjSDcw?=
 =?utf-8?B?L09WSnNOL1lLbTJEUFc5ZHN4TDZSVUY3VU8vSkppdmI2STRXWEwvS3lnQlpW?=
 =?utf-8?B?VzEwUkNYNkhFS3lmV0ozalBlME9Idmg4RHE5VzE1dC92bnFqN2swYmdIOW82?=
 =?utf-8?B?UXhKR0NaU1Rubmx1MHNTeVhEaE1oVHFuZWZINExIbFB4QmVacWw1Y0djOUJF?=
 =?utf-8?B?TWFYOTI2MGRoWlhDNWVUbkVScEF1MmZ5U0RVSnB2dFRhQ0Jhb2sxK29YSjVC?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ef683-1e80-44ca-1d04-08dd6cf7147c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 06:17:41.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHEpixaY/7Qu39YChgS/QXo+5s1XacVnLnlBQEaxwB1aM47SADaoVCvkxprJF65+YABZL3fzp8Y7CPSGy+aM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 06:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18373

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=3&day=27&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/03/cip.2025-03-20-13.02.log.html

* Action items
  - share release scripts/procedures [iwamatsu-san]
  - ask for adjusting reply-to setting on CIP MLs [jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - /me absent next week

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue Mar 18 02:02:02 PM UTC 2025
  limit date: Thu Apr 17 02:02:02 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Mar 11 09:13:42 AM UTC 2025
  limit date: Thu Apr 10 09:13:42 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Mar 18 09:47:53 PM UTC 2025
  limit date: Thu Apr 17 09:47:53 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sat Mar 22 10:27:15 PM UTC 2025
  limit date: Sun Apr  6 10:27:15 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: *Late*

