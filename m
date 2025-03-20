Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44924C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 06:46:36 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.55])
 by mx.groups.io with SMTP id smtpd.web11.1785.1742453187725254665
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 23:46:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xETURTAg;
 spf=pass (domain: siemens.com, ip: 40.107.103.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba3du/Dxndr9t1xbPt8yjbm8PZEk/DtKIobtdEF85GcWBsmW26pPODNbEX71WTFPVPFz94kbtIKSzQ2wliPDd2aI+L0rI3aiSXRh5UlVDOKM1BQSyj/MpF7C/AxOfSC4pfUL73e8gBM/E7z5Up0HzkJSfirjkqkNkpvc/6wz7dIM89eI86cNFcj0KGh6KouUQX+YlocNmOJ8p6IQV+TGrQ8T9wdY7S4YPrTKB6PG8z8f/49mBOUBFG/LDxSXZ1Jgkv3nU/rPEUgK8LsNgu9Y7Kj1Tk2aNfstiPBv85xo0TejBOQIjFWijqMBphvhVWU4rZIcO1tDX2eSSwfqST3T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNoHR3z9ECUOaO2HgQTuuShO80giNxHx0ewBRpXjipc=;
 b=ls71g5dHSDbPTILpuRAGubZfTaKFixNVwvlvSPtEtMMDZashGa1VGI29+gcO+/2vnDAxHT3dJld9MwXG2J0MP9cRjkeZyEBBR1u5drV74PvvK86rGGKUYwxWeJJUJj86FZzmVgMZNBolbFf9ebPIlmKkE3LIk9zWaU2zOJQKbVb/pMglOW0DIbpXkB+HoS6EKxX5V7ErvvjHlA+2sxJjpnwUPU8qpvIyO5J2Y9jTAW3+lZNFku0RNK1X0r9OjWh5uF1vQcyEHvn+Grdpm7zcwJb+Y/Fk0Q5pySartpyLmSrBKbB00pIIAvVrF1zn3egWsxVeVG1HDiZGPElFr2F0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNoHR3z9ECUOaO2HgQTuuShO80giNxHx0ewBRpXjipc=;
 b=xETURTAgceqhnAwZlSkkCWoKNa2ciumJnE2t4AMJ+a1padc781wE/cwFmWm/VLkbPZ1DFrLCKIPIlLxJGjKZSJ3FedeLeaX7Vhkr3Vs5gK2vOvktHVfKaPXMWoY8A9tDQoqHbH1okKuCYFCKKtRcYSwEG5NcjEW/Dqee/nQi2BIcmN9AsHtnGi4A412YzftSL8tMmH6R3VtAfuHFgOX3JeXPoI+NRVrNeTVxKTFtGQRHH/TQ0MyMBUC3BKS7S61Otu4Ksusmeqg+tLCXsI4sNW7jpEJKG3dqDPTRGukdwfupECZ2uTU08g36i8vOdn14jKnipLLCFLU9s4Xz1pNK5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:452::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 06:46:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 06:46:24 +0000
Message-ID: <829eaaf7-4cd0-456d-8e9b-5d568a8d09a5@siemens.com>
Date: Thu, 20 Mar 2025 07:46:23 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab6de8c-02f7-48b6-9674-08dd677aee9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHFLdlVFWWxNKzIxODRQdmZNY3IraUpwd2oxVm9TMkMwdWpub1AvRElvdTNR?=
 =?utf-8?B?UGJJc29YVWFaak1UWVpNSC92THNuVlF3RzcyNjdtK2pzUHVGOFhLVlhTQWZ6?=
 =?utf-8?B?SW05QzJFN0pKalVYcGRJeTdFV09pNFJLUktmdEZjZktjZGNBd0IxcVlZSWps?=
 =?utf-8?B?QXJlbG9Gbzc4cnVwa2pxeU13dnVQVFlRNUFUVSt3M2FEOURsQ2gzZzBTL3JR?=
 =?utf-8?B?RmFOb2hHZ3RLTHY4SHVHeUI1eldxOXEwa3ZGTWExSktBbSsxMVNJZldMNWRv?=
 =?utf-8?B?WFdMVkh2TlN6UEVKdHpyTVdJTExzZENQKzh0b3hXZWlJd1JTRDdZbCtYYWgy?=
 =?utf-8?B?ZHcybkhiUS9WazR0Y2JFMEZ1U3pCeFRxU1pFWnV4T3IyckdBa0JkSGNaQmRF?=
 =?utf-8?B?NjlhQmdqVCtHRnJBNjhNQmFhVWtvUC8wSGhRblJ4TmNMb1NoVm01STZmMDc1?=
 =?utf-8?B?R1d0OGEzMGl5ajNYdWtyUjI0QmJBSzEybS9MdENNKzF1UUR0eVI5MW5VY29O?=
 =?utf-8?B?RGE2WnpwdHFZQlhEWWVjZXRuWXNRdGVBNDUrVUJJVnB1UGY4QmRGYXQ3R09P?=
 =?utf-8?B?T2VlZXR5Nk9MblRUTjVyNEJqdHFnS3Nrc1RvSGltTFUwekRHUUZkeTVQYUI0?=
 =?utf-8?B?OXBTQkRDLzZ3cGIzcFl2Z3oxTEc2Q2pKRkIwak5WTjZrUDlWVjU5TStHQTdO?=
 =?utf-8?B?aWlobjc1cEYwWm1xWFhKK3UxOUJiRDFreWFIazBZbGlmOS9pVlpkYzF1MGg0?=
 =?utf-8?B?T05VTnAzR0hZK1NXQ1JrdmNVdmxQMnlKc0Z4QWNKLzFJS0pGZkwzRlU4RFNa?=
 =?utf-8?B?cDZBOGJXeUtDU21jMlJVZ0lHckNldHN3NnBXQktFbi9Da1NyNWdZeStqWndl?=
 =?utf-8?B?Wk9hSzkyUDFuR0JzYVFWcDBMQnNjZFVXSFc0cmMrVDdhN0lmYlZreHpQdEM3?=
 =?utf-8?B?TzlEQk1UTDJPcVk4cUg0REwyeURCSmh3R3FhK0d3L3NlRWdGNW92NlBmRjNI?=
 =?utf-8?B?bDFSMVQ3WTZHK0ZrSzBjSlpQNldsUHV0N3FveHhYMjhJU3hyb1U3UERkK2N0?=
 =?utf-8?B?b29vMzFSNkVCZXZFcGVuWEd0VlBNK3hvaDJsa0pJdEExc2lKV2t5NjhzcDVv?=
 =?utf-8?B?VzdoekpQZkNFRTM3TG4yNjY0SWtaOXMxQklyVnRmclVFM1RGSFFnelJFQU83?=
 =?utf-8?B?dmxHUC85ZzR5SkwxN0t6V3hDUTRCRzdtYjVMZEw0OGF2K3BVUFgxUWoxU1Zw?=
 =?utf-8?B?dUMrRktKaVFMQ0FOTzBITGZxYTNMQzBRc2VoSks5VjV5d1F3WXhXZG53bENi?=
 =?utf-8?B?UUQwMzA1S001M29xdmtVOWR3UWhGQmJJNjBXR1N3YVE4OGV0N2Y3ODBFRllL?=
 =?utf-8?B?NUI4VjZ6SHNwUnhOMklyVWx1cWRTNDJ2eXBCYUp0RkRabVBQTktzWTZNdUpW?=
 =?utf-8?B?aUl3N0QreGZYNEgySGNmNGszUDI1b21HL0NZVVhXdkE1Q05OK1E0Z0pNRU9z?=
 =?utf-8?B?OUNQYnJhZ25DQ2s5ZjQxQlBVV2JGeWpRRFpZS3pIRFltKzlNVDR3QVVQWVA2?=
 =?utf-8?B?eGUzbkJLdUp0TVpBRjIvc2RXeHRuS3NzdDhMR0dnUjROciswdTBCcUdsQXBh?=
 =?utf-8?B?cEVoL1RkM0tYR3FxWHlJT2JlMmtPc0gvTTN5dHhvQXVsaisyYWJKY0UwNHMx?=
 =?utf-8?B?bE5FWXVWaC9YWEdZT3R6QytOUEVTd2g1ZENFZjhoSTZIQTJqL0VqRGxYcGhy?=
 =?utf-8?B?L1B2SUJiWjZUaDhGRkd5YlNCRmlhNWZycWszVGt4S3dnUjBORVYxQm5NVUVj?=
 =?utf-8?B?U3NKWFRlZEp4L0VYMnJ3UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmNWdWEyWGtmeUdUemc2Ukl6dFAxQlNrVmVldFZzS0hkWWlpekgwaGk1Qklj?=
 =?utf-8?B?SU1kTUVSZkFRWWw3SHArei8vYlVUUmFBM293WHNsbzRacXFvamxCazUrWjZZ?=
 =?utf-8?B?T1ZPV2dXWXNrSE9UcTZNcHFieXAvRXAvcjV2YmlKUW5yZm12a20wU0xSV2lt?=
 =?utf-8?B?Y3VyYzFLWVFOK3hodTlYbFJvM1kzZ1pRL0EzNE0vbndRcmZiUDBMclA0QU1l?=
 =?utf-8?B?TmdkaWJQc0FyNDdpWGI2bDRyNThpQ3RDOE5EaEw5UVo4VXQ4ZHc5NzVhVGxU?=
 =?utf-8?B?S1U5cXV2TGdRMytUOTJGSVlBODNSVHBKZ25DOGgzZzZKTkFHZ2NOQ2IyOVNL?=
 =?utf-8?B?SCs0WEFOcEtNdmFMemJhLzBEOEZzamp5NGRWNUVNV3Y0RFg1UE1vajJwakl1?=
 =?utf-8?B?ejhINzJZOW5lQytqd0Y4Y0huOFVzZGVJTVQ3RkxSa1ZwbXNlNWlaSEVKK2Vk?=
 =?utf-8?B?TEx2bEpRNnVwWjNablhiMU9aeXM5ZG5ZOGp2RGdXQUhWTmpvbmZOaTRQL2Nj?=
 =?utf-8?B?Rk15Zjh0NGovdTZNNTFXRll3RllpUnN3ajUwc2JVOHNUZVY1VHBmVFVvZXBw?=
 =?utf-8?B?YW9lNEZHMnNxQmZoekV1TDZtRVQxeDZzc1o1QXVGSC9MSjVDTXlsanJIbEY4?=
 =?utf-8?B?bllWbFh3STNRQm9RcFRNOGY5Ymp1ZTVxU05KeXFrWm9FWXZ6RHVMeFRIMnc5?=
 =?utf-8?B?QkV6YVpmMGI4ZHZlVnNYTElrN1p2MjVhalJRWHFUdVJJR0w5eml6aDFjQklD?=
 =?utf-8?B?K013NGVERWgvemhZTUw2S1g3dzRIV0RMWklRYzhpTEtQdElVeGhuZ3JqNUp0?=
 =?utf-8?B?b1JVaUh5ZmpwWGZUNWFVQXNYRFcyWVlFVkF0dWlkT1FIbnp4V0Nlb05zNnNu?=
 =?utf-8?B?MzRUeXcrQ3BSUjNwbVlSdTUwZHM4Wk9iSWpvUXVQajQ1ZkkzaStvcmxMWUg4?=
 =?utf-8?B?TWp0cUlNeEpSVnl4NGx2VnNuVGhnSkZJNEkrd2NuSitYS09MNng2ZzhNV0RI?=
 =?utf-8?B?M1ptZ3AzMEhoYWtBRSt4RlR3WURIQm1zd1RaSU5xWFBQeGRXaEY1NS94SWhl?=
 =?utf-8?B?YW1oYlY4dE9uR1JyYlVoUUpCQjFQWXFhYzRMZmNIK0pTSmVnWC91NVlBU1hC?=
 =?utf-8?B?ckJ6ekEvRnQ0YVFXRWZhSDJiWTJkNDVSTVlnSkMveUxKaWxXT01NQ3BXWGxk?=
 =?utf-8?B?TW9TMW1VbDJ5bnJtWUFnbWNIem9ROXdQclRkcjczZUZHMkhUUk15Qnl1NTlE?=
 =?utf-8?B?emxPaVU2R3g4azd3eDZFREhSZWs1N3pxbm5UbHRlOFE2d3k5QzBSUnVBdG91?=
 =?utf-8?B?c3lSMjdMSjkyZnhlNVJBZVFyb0Vaenk4WlkvanM3eklUVWdvR2ZvWjcrMUx1?=
 =?utf-8?B?c2hWS281OTBGSG1DMVlwT3oxWU5pTzBUdHlzb3BqcDVFeitsMnBneTYvaXM4?=
 =?utf-8?B?TkRPU0xmb2F5QUcxeDFLTDc1em8wM0R4K1pjWUpXWDlSZlZEdU01NHRUaXFx?=
 =?utf-8?B?Z3F0TzlNTWp6Z2VJQ1FWVEMwdWx4U1RZcEpCMFJPUkVtZnZGTmh1OXZrek1k?=
 =?utf-8?B?d1RROEZPbEFENUw1Vk1QVG9RVm43MzRqSmpmNjdkbFUycTZUVVEyUWxUUnpq?=
 =?utf-8?B?bGxWVWVsMDZ1b2M2cUZ2QzNNODZuSGFmYjIxWk9UU0JvWVJOWm9Yc0tmOUNI?=
 =?utf-8?B?WFFwYk9OY05zMkQrSDRRTGlIczg2T2EvZEMxQ3JzZHlEYmdDc2IrZlIyTnNW?=
 =?utf-8?B?Q1FHRUVBWFNvMy9XdGFJclE2WWdRUWJncnoyNWY4b0FUdUh3SW5xQ0p3cUV4?=
 =?utf-8?B?VGIyb1l4N1NaKy94R3BmcUtoM2MxeHB1RHpDUnk3RE9aemJFd2JhYllGeEti?=
 =?utf-8?B?bTYwSnRIYmdDeW5Fc2EwcnU1cklEMzNBZkRVMnFHUVpsRnF3MW9seUIraHhM?=
 =?utf-8?B?R2ViMkpOanlRNjh1WXFTUllOMGM2eVNCTnIraUxKYnY1aWdlMjNGcE9FTVNI?=
 =?utf-8?B?RXlUUjU4WHdWb2NidWdqR203b1F5ZHZiWDdXb2ZNWWpwQ0JreWxMM1VZMm1p?=
 =?utf-8?B?bWZSVnZSME85ZGNiNnBtbEpGb0NlbFNqa3VKR0VFdEl0bGw1T1NsYWtLc3dz?=
 =?utf-8?B?dmJhYkJHZ1JWL2xLVzJlSVNSRTM4bTB6SGtSWmVNZUFmVVZSd2NtK2pJUlN6?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab6de8c-02f7-48b6-9674-08dd677aee9c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 06:46:24.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOxpOo5AcUVGfzBaBC1YOUL2KZxbnSsLvIH6eUEPgOZB3tytMKAe1F6zJW/DVb4+wKfMtqSF64pqyIKmkrg6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 06:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18282

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=3&day=20&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/03/cip.2025-03-13-13.01.log.html

* Action items
  - share release scripts/procedures [iwamatsu-san]
  - ask for adjusting reply-to setting on CIP MLs [jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

PS: Pavel will take the moderation if I'm not there in time.

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
  latest version release date: Wed Mar  5 05:05:09 AM UTC 2025
  limit date: Thu Mar 20 05:05:09 AM UTC 2025
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: *Late*

