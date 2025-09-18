Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B03CCAC59A
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 04:41:09 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.2])
 by mx.groups.io with SMTP id smtpd.web11.6393.1758170465238786256
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 21:41:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XTR/HxBj;
 spf=pass (domain: siemens.com, ip: 52.101.65.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lctrfRShE+X5wgyO1urDtFWzFH8/BujmjS0wA5oPWF6kETvgORt1/Y4H++uDqIfXsB5UiFWauyGj/6/AeGHJ4pncRsr0AjEPtrRqnShayLpjEjGrVh5Ycn8d/QzWh5CekqFr3PtFwtgyq6U+HD35lemBSI0JDOcIfVLhJQJK3V3168MzMTlsae9+RpJ1xy6qJKFmBXhDYrRjeilpj9Xdqx6cdRCkR22r2tXTKjPpUSmivbfAmYx5Z0/dN3pblh51Hbng1NVF1ftfKmno+anx0mHV8y04mBlj6cUs5ImP+YRUa57gVrnID3Lfvgc93/yim8qkPmZBdhvAWjI7FrMqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUB8XGxlS+Jyuv6iOVcLyurob775OHzpgiEyatWAGTo=;
 b=AzARfUQGvTOB2Tl8RbJPiNLS3xaIKGFWeem34Z9CUmiVt06y2xoOzg3/WiK08+VwLP+70je9NAcj2kbFfhNk1eZnUoKKiCWB1nqftAwNd7l3sbjeRUoJ66mm36j1IDCSGSW62z9BU+YScLmxE/FUC/iTle/QNhfwSUlNhOpcsgS8gb9A8iaqBdHRvzBroHf8T8eJPbaFvOhGC1m+IQ6sV1RWH+ZuAoYeVuHdXyNgRJficvIJAFKkncYSD4KI6Z/stMqfyI8kcZCqxY+4NcR4wVAjTMuiIYgdg7z34ya8lE35QY91XSubc9DfoPOPCP2CKXR+NFix1MMVLei5UMugHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUB8XGxlS+Jyuv6iOVcLyurob775OHzpgiEyatWAGTo=;
 b=XTR/HxBj+QuLVDpPqfay1CVe0DfIHreHbTkZgLYQQQIeNNx/IBazRdEKvh8bQm7/oyegCfooBWj2zozYn9WPcLYdBDsAPH+pVM8ohNcZD4YSg1h/ok9qmlefqn4YUzwNPdcBDCkJG0/kMQj6LaRdiYl0xbmuN0ukzbNmH9UvKhQ8WV+MsPvGsCU0dItLmGw5bjvIACmJlrhyY0tgRBsUDB5zRWaMPr+JWyFzXUaoEFJh7EWqFdI9VG6cKd8pyD2P/ff660saBIPsiQVXYuhRxaBr3WfBHc7cgfiaAoaAe6gfbpBfYpL0U+7K1+rCBAOSRt+AXF16ZTvOVM4medXnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by DU2PR10MB7836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 04:41:01 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 04:41:01 +0000
Message-ID: <08da04da-5cf7-44af-8b45-5d12d2583fee@siemens.com>
Date: Thu, 18 Sep 2025 06:40:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|DU2PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b47d713-da52-48dd-c3df-08ddf66d91a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlMzM29PS2l0YUJUS3VtcFJCRDRqelYyVVd2Z2RvbGVyZFlCbGZTdWF3VGZ3?=
 =?utf-8?B?OFJNVnFuMFVpMVE3bnVVakkvTHNEcGVwOENvTGlVOE4xY2VPRFFmODN0ajNV?=
 =?utf-8?B?dHRXVzJUZWpRSWRhenhDZHNTVlRXUkZTcFdSTmFVL1B4RHpHMHYxckNqYlA2?=
 =?utf-8?B?NmFNU1ovSjZmeG1PUlRpcFlUdVpZTHJYS0hlUXpZaXcxZVcyb2laZXg3bkdF?=
 =?utf-8?B?aVZwVktvSVA2S285eGtrekIybzRmbnYweWhLL2txV0FuRE5ublRYNHdDQk1s?=
 =?utf-8?B?TjkxN3I0T3RUWEE1akZ0MEJBRkxHRkZRVHBadFpPTG50OTBuV3NwOWNSK0JB?=
 =?utf-8?B?VmY4ckFyY2FBUWdadW9BMXA2dEVoNWtFSE5zZ252NDllNEtjUTA1WU5UMFNn?=
 =?utf-8?B?YmpJekg5OW4wdU1tbGR3UnFkNHE4b0xhRC96RVQvbEdBTnY3MEE0UG5wMVFY?=
 =?utf-8?B?OUk5NXFaUlhIR00wNzl5N2dnaFNTOXg2bjRJM1BrWSt4bEZKQ09QYVRsRUdV?=
 =?utf-8?B?bDBUdU94NjdtKzRiMlVVcnZrWW8rdGY2MVI3QnBwOCtqaDJNVG9DckZGb0lJ?=
 =?utf-8?B?VXQraFJLQktRazIxSWdKTDhBaTdwVHZpRElRTWhsZGZSQVZPZjFTYmpoS1c1?=
 =?utf-8?B?QWdkMy9OTTRXclVoNlZJNzFYZDdnRFk3L3A4REE1ajJRREFaQTM4WUU1MzVz?=
 =?utf-8?B?OEo4M1g0U1RjS1hzTWQxRlZHOEJSYlBSMTR2b3U3Mk9veXU1VWY5NFplOVhB?=
 =?utf-8?B?VjQ2MXBrSmU1L2w5UCtacmZjSnZYNkJ2NjhvNVZJVTV2TFJSQy9LQmh1N0V3?=
 =?utf-8?B?WWJDUlZ5ZEp3b3I2cEFEVmg1eFpEbUVoalMwdkdXckVqOEQxMjM3S0tYT3JI?=
 =?utf-8?B?dlhxMy9xVUU3Y20zY1V1cGZkYkZhakFPTWl4WVJ6T2RxQXBucXluR2tVQjBZ?=
 =?utf-8?B?a1NCRGRCN21MVjdsNzgwUEswTnlCd1lzRElEQlJZYVFrNjBMaHFRY2VQK3pU?=
 =?utf-8?B?TkZYamorbXh1Tm50dmFwQTI3OTZHQ1ZSL3kvTmdIeEpPZCtmOVdMYlc3enFK?=
 =?utf-8?B?eXo0SkFIUUUyNmtSUTVTOGRVcXFUZVRaY1FkdEdmLzFYRW5Zd0U1TGdGQXMv?=
 =?utf-8?B?MXMyOFYxS3JFeU9MRFFjU01neFpnbDdPK2VVeHAwUWhWQ3VzZE56SFViOEg2?=
 =?utf-8?B?REltNnE3K2xOelAyZ2xhYVFaeVN6S2tTYWZpVnJvb1RiamNHT2pFdFBnWEh1?=
 =?utf-8?B?b3FGY2dqcHE0SGlOa3VSa1NkeWhiWWxNKzBraEJXNG4xZWwrLzJ2Zi9aZUpT?=
 =?utf-8?B?TTBZSzA2azVsdjNvTDJjNnlxcEF0aStqUnk2bWhhNDR2UFFONTFZQ0tNZWFK?=
 =?utf-8?B?YjZTTXpHS25LbDhDR0R1U2pkK0tOQWc4akRuWVNZWGtxTHNEZ1ZLdllKOVhH?=
 =?utf-8?B?TnhBVmtKM2lRWWYydTFRRlBGUld1NWI0N21yNUMxNmFjcXpBNWJWZVBJdThC?=
 =?utf-8?B?Z21vdW9Xai9PcTF5bktKVTlqWjUvd2owQ1kwMUhXMysrK0Z3RmpXQWx3a0Q5?=
 =?utf-8?B?TWw2Zlh6Q2dxZnpaZy85RVlDOUh5Q0taR09UY3NNZDQwU0V4QnByVHhtQzNa?=
 =?utf-8?B?Tm9HcUJtcHJ2Z0xLV0VvdkQ4SERFYVdiMmNkdGFIajVHYVh4aWg2eU1BNVNs?=
 =?utf-8?B?Qk1oVWxaby92ZExnclJwMko4azMrV0RqTnpIWk5aZUt0RFI1SnNUeGsrekZt?=
 =?utf-8?B?SjRPTWlvMlNiUTNjN2s1UTVKbnRWd2RvZjJWeU1QejJBRnNXVXpJQ25wWUtk?=
 =?utf-8?Q?n2vh4jjRIjyRKPNVtxC0+5h/+Z5YNFc1QRE08=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1RxZm5hUHRMczVnM1FWSkNMeGhTdjQ5dlpobmxLSkpHM1dxWEN1SitSN0xh?=
 =?utf-8?B?RG95emdYQVIwQlQxZFpUbythZUowYTBISjFLMnV3RmxidzZ6SktPdGl5eS9E?=
 =?utf-8?B?NHJmRG10K21SRmlxNC9wRTNMaUVCdXM3ZUU1RkpkNWpUTEt0RmZFcktyTTBk?=
 =?utf-8?B?TlNEajN5bC9sTVI5OGNmN3pmaTk1dEVmMi9wcXJ2RlBTTlVyTXUxUytyZ2RS?=
 =?utf-8?B?MGFOMHZjQmFXNis2dHI5RTJpbG9BVjlKbDl2bFkxUkFOMllDdFlEM3hjdnlR?=
 =?utf-8?B?K0FzVTNjcTR2NDBnOXU5R2UzaWN6andFakRPUHpuWEZwUUZrSWtJU0NxODBS?=
 =?utf-8?B?aWdFa203ME9iT3BVMW9UUFZmWllDWElYMkJ2ayt5QkNrT1BDc3pmbXAvN3hI?=
 =?utf-8?B?MXAwOUFKbFF5WjFuUzZXRGFTS25XWlNiSHI2MFRnNW9XZWl3dG5CZDQ2R2Fm?=
 =?utf-8?B?Ulo0d1ZVMUJDbURrUkJtVWJXY0hGUEZVbEdYK2swQmp3Y3BFVjBOaVQ5emVL?=
 =?utf-8?B?cmRJcnBaZ09QQjNsUEEza1JyVTFIWFZtay9HN2FDMzRROUhralRkZ2RZd1dp?=
 =?utf-8?B?WXNOQWhTT040eFJIMktQMzJCcWdsZ1lsODd4WEtXUzJlNytmU042aUZFTDdK?=
 =?utf-8?B?WllQY0pLUGpHL3pNVytxUU1reDR1bk95Wlo4dTZwTEh1c2ltN2NmMFFWb21l?=
 =?utf-8?B?MGRvQS9HZjhmd1B0VTB4amtZN29DUjhEcTh6WnBzT0pNMFpQb2EvMis2T1Jh?=
 =?utf-8?B?bThlZkxtTklSWERBL3ZXYXpROUtTYmJpR0tkQW9TSjJIZnNwclFoTWVIa1Z2?=
 =?utf-8?B?WXQ2UHV2Z3k3NzNDUXQ4OUVyMEtxRS9uQ2tyVkVMbk1JNFptSFVySldtS0dy?=
 =?utf-8?B?UWMwbjN2MkpyOGRsV1VNOXROa2ZCam11dEthYnllN01ZSGlleGlsYmczVjdl?=
 =?utf-8?B?ZTJxcU1TN0VUSHZqK2pQbGFRdi9CclpWaGEvYVlLSnluSkpaZ21wMjhnVjlZ?=
 =?utf-8?B?L0p1SWpBdlc3U2tsbFNqRFRSSlg3WkQrTkRCM1UvRDFjQjk2Z3YyYnhma2M1?=
 =?utf-8?B?NVFUYUNyMXA5dXJwUnFXa3o3T3VKUFIycG52c0hhU3dXWEtzaWFhNVUyOGE1?=
 =?utf-8?B?KzBPSzl5dzdCQ1BPb3pDNUhmZzJpcS9kRTdkaGNLbWJwaitQQmswOG5oK1lD?=
 =?utf-8?B?ZXRrZlo1N1h6NURtaU1ZMElzYUhkMHJYSHBGczZTaXEwOEo3YkZ6VDIrQTNT?=
 =?utf-8?B?bjVLaEk3cXJwZ2ZRaHZJb3Rsa2VQWG5Ocm4xM1UyRE9tUDQzUTIwRUs3YjR2?=
 =?utf-8?B?YlhHNDlBcTBuSkNna1ZrbjBlUU1FRzF1U0dGQjBFM0FnM3U1d3lmeGVnWjdZ?=
 =?utf-8?B?M056bGRNNFNJa3crODFkMHAzQ1FDZ3B0ZFRsSm45aWI0UnlLZEcrcFdxMWdW?=
 =?utf-8?B?ZGNkZjJDSWN3S09ScUxqZ2xDK1hyTGJ2SXJYdzR0Vk5yNVR5N3J3NENRSThX?=
 =?utf-8?B?Y0JsQ0hXNktGWDZweFpzd2tXb3JBZTAvYWxyby9TY2Y1MUUvdU1YYS9ES3hE?=
 =?utf-8?B?S3o4dnRjaVFVZE1WcEVnNkF2cVB5UHN4aEUrd2VIWjJETnFVTWNZNjdlSko3?=
 =?utf-8?B?RWtOZ2JjTFlwNXRqSnc4RGduTnlnS2I1MlFqZk5hTGNiRUdmS1M3djJaVXhx?=
 =?utf-8?B?YnlrV2FBMUFMTDBnb3lQckxhQ1JIMlY1RlJYMkdyUFNpUFRINU4yVWhHWTRv?=
 =?utf-8?B?eC9TaGZxUXoraW1Rb1JoNTgwVDlEdFV1T1VCc0J4c2F2cDhmdDRLQTZGY09w?=
 =?utf-8?B?VytRYWtDa3NHS3FOdnJXNzU0T3M3Z0hxM2NWM2ptNVZoYnpJOEpJODZibk5N?=
 =?utf-8?B?OERHZEtqTWg3M0lpTWg2Wkl4WWsxSXZwQkF5UldmQTJZb3VDaHlyTG05bGpL?=
 =?utf-8?B?NWpDa2s2NmUrZjZpVUNwd3VqY1pSQXhpT0JVc1pTUi9xUC8zQWI0b3IxSThD?=
 =?utf-8?B?dHMramh2UnR3My9kcmMwNUtNWGh4U3RyYkxSWi9Mejhka0k2THJHc1NLVlVa?=
 =?utf-8?B?djl1ZGgwY2IzdjZjZUp1Wk5Cbmw0NStFaSt0WkxpeFRSQUUwSm9QUVArekwz?=
 =?utf-8?B?YXV4dGM0NG5RdDlNU1dQK083TjM0ZXAzeUIyUTNSbjVyMXNaZ3JYck9NVSts?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b47d713-da52-48dd-c3df-08ddf66d91a3
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 04:41:01.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydxH92Kjhn0ikapBqIwMGveyy4f19YzPvqwl0b2eWN67QPoav63rivNchVFbkag86PpKDVMy1bru8Uqjyw9UoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Sep 2025 04:41:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20082

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=9&day=18&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/09/cip.2025-09-11-13.02.log.html

* Action items
    - start define a CIP kernel threat model [Pavel]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep 18 04:40:43 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep  1 01:59:32 PM UTC 2025
  limit date: Wed Oct  1 01:59:32 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  6 09:10:31 AM UTC 2025
  limit date: Wed Nov  5 09:10:31 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 18 08:36:05 AM UTC 2025
  limit date: Wed Sep 17 08:36:05 AM UTC 2025
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
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
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Sep  9 11:32:29 PM UTC 2025
  limit date: Wed Sep 24 11:32:29 PM UTC 2025
  Status: On track

