Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259AC3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 07:19:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web11.117948.1723706343073704104
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Aug 2024 00:19:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H8eRFPcQ;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jskGJtt9562R718QTviBUBS8WVsPRkoQf5zd8WJo4crv42Nu8oJsJoR9DsinwB/sb4A3fS1nLsBnpYH2TR7rR8M8tD5pz9VIOvRMrR11/goW172kmcfV24/pz2b2XVjDtv+LUD3jW+6widsQzi6rso1cLvLqpGEbmMyWR0ORRLPs7TECq76HRaHJfKsPZUKUOLAQ4YYHz84y5K5W4md0zby1dbZ/sPitRBso6ERWnay5lUopD+3B1fMc1vp9qzXS7elGsxZbFJcdvHHCrHEwL+I+XwMkrcJ87uOSCMedqxfJKjsWzjSQ4r2CXckDO05I/5DeEHO+pa/hGr+JQQnTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67rqtDEb8POKVsFv8H8yTv95K1rL+L0S9HC8AdM3Hk4=;
 b=P36iVcBgI+zHUM6bwvtJhtSMP/Jk3OpVZbMipbxrbVhwSvtu7SGk7S7qqi+oaFo0CrK3WC3eiyIS2QTHtxU/YH61BfSo29fJhCuGc3VARfyqWFUMHr1DUGAXxBxIomqly5szSNX4M/JDR00B4Bjq6dm3QaK9aRffn+ucgGJFI0/5RvDOfaLC+2hKTkLP+r+6SLNXEjG9YcGdwVzUS3gMgSC6CQvjsbT6Ig+umih8R/5JW+j+0zUDYgZo6YpSTotWAzZ9noaRZlnj9ZY4rrldXHIdmk8aG3CiZ2EXtqWNdYAQG7Y344Fs7GPYA4kmgvzvGSX+jY+srmm1Y1U6t0p+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67rqtDEb8POKVsFv8H8yTv95K1rL+L0S9HC8AdM3Hk4=;
 b=H8eRFPcQqBSrM+pW9RimNkQ40rlDUkqe2HOFIdk143NbZ6sq7Ub8ouANzupI9DU//h+rwvcSzcidFYOqb4Hmk2j3+dXIo6CjLeB34I+4UjTH9esmfaRy85QY8lBvDUpqJEowSgoeFbUw/xRbLmrkvDgonf6fKqK4qA5yClfyPDSKtmYA7LACRdeMg++v6AxR5hSAzdkEqu7fqYYSIALRWKxXEib+XvVZdLqP7O/dgNUFS/HHoTLlW8F62K4o3hUaVXybm0yDj+W4hlBZiojJjH7oFfWvZmenLz7/3npCb84rEFRAFSmWlwYV/EKuYZIub2RKGiFNsRmBR9+quHZuXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 07:18:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 07:18:59 +0000
Message-ID: <d9534eed-0fec-43a8-a245-6e5edbf62c68@siemens.com>
Date: Thu, 15 Aug 2024 09:18:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: a948174c-0884-4978-1ac4-08dcbcfa8820
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UGhjcHRtZjFaeFZreHlabEgrL1pQRlVuSXZQaEVCd1hVZDRyZVM0bFNKdFNk?=
 =?utf-8?B?RzYxQlFsOHRlTUNCZDdTL3RKYjZTZTArNUpqT0d3ZmpJYlZjQXRvSkdlODNV?=
 =?utf-8?B?cm92S1FBU1EzWmJVZzBiaDlZR0RabkZvZkF6UFRtQlNhRXhPbjdLdm1nUE9r?=
 =?utf-8?B?NklMUEcxRFZPWDBzdVlpckRJL1plbEx4RmI5UWNDaGFIbytvWTdlYzk0NUdj?=
 =?utf-8?B?am1lZ05qVEtSWXp3Wk5BK21VWG92OWRjN2RiMUU4Q0JTRnYrdmVBQnJyME9R?=
 =?utf-8?B?VkQzeDhMUkhreG80L256Z3BwNmJwVUR0WmMwNjg3SGFTQzBKMHhkeEdPRGdx?=
 =?utf-8?B?dTlGRkMvQ3RlTFYzS3c3YlNQdjN1blNMN0ZXSmRLdTNEMUVNV083dXNQTHlU?=
 =?utf-8?B?SFhWV1MyNkhlck5zNThKZU5tb1pjTDMwWTNaMnRlVXJmdngyeTZWYXpnVEVL?=
 =?utf-8?B?dkxoamF5MkwvVW5SQkdQTmJoZ0p0ZmxNbFhGMWprT2JUb3NZdVNBRHRtNndV?=
 =?utf-8?B?QVFDUUlKN002NDFDbHJKWnREUkpQSU5CTEVBZ29CYlo3M3RvRmhZdFVuRnZH?=
 =?utf-8?B?eUFmVm9UdnFiWHB6SElGaTI4Um5zZE81RnE0eGVnZ29vZlZVRzhra21aYkVw?=
 =?utf-8?B?ZGc3WFQzTVJxNk1nS1dRZmxzeHFYdHlzK3VyaWxNakV4SE1BNjY4Vm9zYUNK?=
 =?utf-8?B?VjZuRkNZUzV1SXpHMUZwQzRYU2ZQWDhEMW94ZTZuYUpiWG5ZTTZRUkpxdU43?=
 =?utf-8?B?eUJPVE45MVhsTngxV25MZzhVVmcweEh6eUdUclUwdUtua3o2dlozdkdoaUhM?=
 =?utf-8?B?YTB2eGxQcHJReHJsbnBEV0puMUpVYjh5L25teUQ5bjZBUlF2cVhsZm16N1VT?=
 =?utf-8?B?anZiaFVaU1ZEWnRkUEFSalZKL2NmUmkybVUwYnd4ckloZFplV3ZoM1hiMXBC?=
 =?utf-8?B?dWxGcmp2cmwyU2h1MVFGc3FJdzRHRGpxamZvRkxacHpsRGEvUFdzakNENVdK?=
 =?utf-8?B?UGhzd1lLTXNWNElXcExwZytoSkJ0UzBzdG1QRzhlUlA5SjlqL2NWbTNUZDBw?=
 =?utf-8?B?NGZxMms0Y2lreWU1dm5CMWcrMzB2MHA4dGxVaDBvNGsxTGswY1JHM0gvTGlW?=
 =?utf-8?B?bURoU2wwNU96NFFYQW5nc2gyMHFqeWE5RllFMUdXY0E2V0ttWlVvWElidGlR?=
 =?utf-8?B?K1Y4QWNIWlAvdksxV2dMakE0Qm5JcWs0NDVDYTM4YVpGd3JMRU9jWjlGK2hN?=
 =?utf-8?B?d2lYZmlpTEhpQTVjWlJLbFRxR3FsdCtyK2lvcGc1NWRZazlxMzVKcjRHOEJK?=
 =?utf-8?B?Mi9Sb1ZnTGo3QmdCa1ZqMzVvK24xWWpzWS9tUS95eWdHM2xxQ2Z4STFROGtX?=
 =?utf-8?B?bWdHL2pGNWwreTJneHVvSlRPTURDd3BZRE1DZEhtc3ZFZlpjSGpBaFZjZE5s?=
 =?utf-8?B?OGJaUmFRWEk3aElmZHZDeUF3dHJnUmpiUUZpSW5JaHNYY2RSeVB0c1hkYlpl?=
 =?utf-8?B?STRmVzM2NExOKzFIejFVZm9rcU1iTDJiT2pXb0RZZ0xRNWlKMHVGcDF2ZEFW?=
 =?utf-8?B?SE9YVGRmcjBHb3oxekF4UWJIT0pXTlhQRkJHcTV4M1F5ejRVZmVqWnBkRHZr?=
 =?utf-8?B?L1JpSGcvb2RRNVV5MlUxanNzNXhlNC9Nck02SUVGTjdGcG5oT2YyUlcveEdW?=
 =?utf-8?B?V3JUcnh6dlRTNVJMNXhKMi8yNXAwcWNIL0RZTU5CY1JxdzJ4T2R0M3JKcVBF?=
 =?utf-8?B?ZHFYMkVHRnJETTRqWkZWbzV5bHQ4OUNDOWEvVStxM2ZYOTBvODB0NTZtZFo2?=
 =?utf-8?B?N3JUdE5aZ1BNaEhFazJ1QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDhMTDFpYTRxQVhnbjA3RU1LVkhDRUtuZlI1ZVpmSHB5eEZ3SHpic2ZQRGJD?=
 =?utf-8?B?eGxOUll6T0g0UW5SY0phTEJqUyszeDRIZlBNNHlCRzc3LytESlZhWThUb3RS?=
 =?utf-8?B?TTE0emRYaHY2SmpIWVAwWTduZFRpRzYraTE4UzVIVEpGaWVlRGEzZUQrdHhU?=
 =?utf-8?B?dDdYU1NFallZU3lKL3pMa0dsQ0dJWVNrZDhRb3NjMHVKKzZzeW5qTEI4czN3?=
 =?utf-8?B?Z294V2pjbU9uNjA4SGtqbkFZQzB0VmNaWHVZODF2NTk0bDh0dTJsdDFkckxm?=
 =?utf-8?B?bXROaTZGalJBRW9zZEJLVUhLYTcyZzBZZmh0aXNWQXhoRVpRUzlMN0hSdUtJ?=
 =?utf-8?B?azdVRkJSWmRqODBkZ0lTeml6cXpReVRvN2tkWDZnUWNISllhNFVqV1d6SUpJ?=
 =?utf-8?B?THFCSHZPWUloMXUvaTlVaGdIc1JlYXBnYUNVU3Q3a3NHK0VpNThMQU1IanlQ?=
 =?utf-8?B?akErOTdjZVRLYnJ1L3RxS0U2WmNRWS9McWJ3eFE0TGZSWnhIZkZoMnFkODJq?=
 =?utf-8?B?QjNObnE1OThtWTZ5c2ozT0JyQzdvdHh6MEhEakdYNWxVVVF6dldJc2QrSkM1?=
 =?utf-8?B?MHZyUlhEQlFWak1qQ3ZCamhhak9LZWw0Y2xRSW9laDNyVDF5dnNxd0t5RExO?=
 =?utf-8?B?OUxvV0dxSXF6VVZsUjBuVHlabzhqZ0N3eDRMNXFVWW90WERPcmdwNE45RUlT?=
 =?utf-8?B?bkF6RTVsRVlwYVlrY1hWZElKb0V2Z3RQUHFhRVhFU01ZN3dGVUFBQzhhSFVP?=
 =?utf-8?B?eTFuUUdTZEtFOTdvb0JUZlVtMDVrV2wxZEpjU0k4dUJvRzgxU280b3Zlck5l?=
 =?utf-8?B?cUliTGt4aSs5Nm0reS9iQVoraFQ5VGZvWWRaSzJiM0RuUlNOMVVEVFVSMnM5?=
 =?utf-8?B?b1lFVkhYWHcxS1h5OThHM2xUM0dBaWlsakFCcUxuR3Y0NllTVk0yRFJkR2hw?=
 =?utf-8?B?UFovVjI3REdKMmZjUkZNN0t5Qm15MkYrc3FVMWVOaVkzcjJjTlV2NlYwTkxj?=
 =?utf-8?B?YXM3anFhWXdQaTZmbE5lVURJVHpSL2pneWtXeFFwZFVUR0VDcXAxbHExdFY5?=
 =?utf-8?B?dW9mcS9EUWxUOC8zWGJJNGJHaDZ6VEpkZnk4RU9GUTZMalErWmVUQTlITGhR?=
 =?utf-8?B?NUhZL1pUWHVKNmRiRmRlKys2amxDN0RyZUFSV0wrMmQ5cjhwY2V4dGRGTE5r?=
 =?utf-8?B?WG9zeVhPYzdwcXF0S3FOZ0I3STFibVFId01xNHlGejd5TFlSZ3JvQWZPSFZz?=
 =?utf-8?B?VEVweUYxdVMzWWNiWWI3QTVMaGU4c0luUzFxU0VUMW45aU9oVyttMmIrNTJu?=
 =?utf-8?B?dDhKcW5DNUhKcno4R0Zsck5JM010eHptUEdkUWNsQ0JudlZiZGZ5UnB6czh6?=
 =?utf-8?B?Q0MyUXNGYzdVUldZdDZJVWN4cVdvMmJhWmxmNjhDdnVXZ1EzUU1zMUIwVUlB?=
 =?utf-8?B?NDVVcnVSaXRPbUZOVGpTR1Z0WmI1cXR5Q1ZNTWJyL01WckowTW1kaUZpYkZx?=
 =?utf-8?B?WVpHd1l1SlNFUGVhQVV1ZEU2WnVKUVJlYzhGaUdvaFdiTk5SeVJmcUFlaXBR?=
 =?utf-8?B?Ris5bmRGZUF6VGZ6M1BFbkV0UDBjam1ETnFLOGZTZ0g1Z1lwODRKaHd4bHFv?=
 =?utf-8?B?TWxhMmxSSWNNTVh3L01VSkt2TnVBcUNnMWdmb2tmOTI5SVlyNkxPK2lqVmtq?=
 =?utf-8?B?WnpkSEthamUreGVnNmx1S2dFRFExMUNoNWsxVHl1TjFObGxXdTFXVmxBdFp0?=
 =?utf-8?B?K2c1dFRpbmdzUkt3MEgwNndMODZReGV1NUU4UXhsWDBTeHBoT05qVjJtd3Fv?=
 =?utf-8?B?NkZ5Q3RTL3NkZWpvaVJpb2I2aXRRdDVqVURYYXJUaXkzOStTZG9BMVFQcDhy?=
 =?utf-8?B?OTlhM3VabGNnNW12bThwRXFvbVpIRzQ3ZU56ZnpoSTd4anRYSEt3S3FDRXZm?=
 =?utf-8?B?RzhEaEwybzAxVWUzbXdwU0o4anh3S1hFcWpRZmRSN1NhTDY3WlFoT3hxUkY5?=
 =?utf-8?B?ODMwRXAraVRGZ3ZWZFdxUlA2dlFxL3l3SkMwbFQ2Rm1aeTlHWjJ0dDRnWHR4?=
 =?utf-8?B?MU56WVdtZStGbVR6RFVxM1NmZUkvRGMzdUtOYUhjQmxWTDVKc1Y1YVJmdnNY?=
 =?utf-8?Q?NcFB5XB4dUYvgpY1y0hOmTJr1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a948174c-0884-4978-1ac4-08dcbcfa8820
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:59.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNBLVMz0sFf7og3F8rqfJSra+YRXNVV4/v032R5GFv17W4jg2KUZv7snLEsFC6/amMoZIDtuDME6UdC4ROsBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Aug 2024 07:19:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16789

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=8&day=15&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-08-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - look into CVE triage tool [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
  limit date: Fri Sep  6 09:06:02 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
  limit date: Fri Aug  9 07:05:27 AM UTC 2024
  Status: Late
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  9 01:12:59 AM UTC 2024
  limit date: Sun Sep  8 01:12:59 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Aug  9 05:08:44 PM UTC 2024
  limit date: Tue Oct  8 05:08:44 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sun Aug 11 09:13:17 AM UTC 2024
  limit date: Mon Aug 26 09:13:17 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Aug 11 07:14:28 PM UTC 2024
  limit date: Tue Sep 10 07:14:28 PM UTC 2024
  Status: On track

