Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71115CD4F3D
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 04:57:11 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29950.1779339428560462239
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2026 21:57:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ID/vYC21;
 spf=pass (domain: siemens.com, ip: 40.107.130.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRDml5YIBd0eisAGoBSEPeo4M0+6fWss1YgMKhkhPGT4VwLzLPjRLPvR5+UjqjXX9qvc56GmY1rMWgaxZX02oCdmbabVPfdVaPB7gZd2mG1uq3TJyPAlosc3H+KFBgiNVYaRggsDpHJ//+ieQo5V53AIuVplUlERo2FQLyp3OpNmseP1BHNCX3FEcmFTQ7rT61JrgRT1vrPQIEi7o9P9RdB6l+et0AC5b/qPWH/WjEPN049QlIrC226HcJ5/cxu9Rbb2VoZWo9Bi4C3m1Bl8XYaAXeShWpR6TqsW2KPZSxlgjWMRtDHF/1ckZxk1iBDs6Z6aVS28UUxj4Hoha96NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbK0WvQ47KKcvAAbC/j0CiN7YrYmr3wjPXfRMlwlDKs=;
 b=d+m486S21mllku6aHcy1vcnJu3K2v9SZ/T08v1w5Reckwm103EIrJMlr8N2nuiTzXRdc45UZ8X5dDQi5IIgU1i8MYfomIjWsEokFaNE6AVKIvQ5QV1GY6AoWoSGWpyLrg2oYVIRU3sJPit8AqShN3hxFscWQFhanWE1JuQqkWhTc92euyUbAFZUV0t6Bl2QWw4H6+SmJjm84KcCp2kOS32P3uH6wGOERb4dPs1YTqX10y0DjCOM/QeJnUgvLwdB1cycUXAilqz/rHY+NwJjQE8hr3X2y7Ykfij/eINpSEgwE2/rin56eoUNPlP/VIR3sF2BQ2AyCDIZ0Dy2xjb9whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbK0WvQ47KKcvAAbC/j0CiN7YrYmr3wjPXfRMlwlDKs=;
 b=ID/vYC21ndx5E3jbTxFgWJHjaD80HmGK0refMPWMQWt26+9UzLuRUH3Y49CCIDrox0MoqYWRgj444HJ7DMH2sl9NL4tebl06fp4vJkFVwdT6mtDkfFp8sL29bbgJc2CtITRWRFukg1awJOJjkAgv3cUUH6Gk6N6mF9DDxfR6j3Bf44GIJwGkCUxUrsKejLM/hxHIcAhfU6fRBmjUIAwobxICH7fFAkw6ceDuBm2k7OL0wJt4fr/CbPnrZZpTUT4MYpKPzx964PONRdsH/gYzpKZZEdPee5D4cVDxhqd16kKCl1GynGicpcGnNZ8Ufj1A7pWADQenQ/mEWWYDYeGcuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3284.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 04:57:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:57:04 +0000
Message-ID: <f75ed982-379e-4e12-8af9-08db6e776fff@siemens.com>
Date: Thu, 21 May 2026 06:57:03 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3284:EE_
X-MS-Office365-Filtering-Correlation-Id: f14a7bb0-70f2-4c26-cb34-08deb6f566b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Ek5xK9wmW4zeWl7x5eVBY91xkemOEKjNl8M1/ysTJSiCcZvr98DFDmJLV3QuRg8zvd6V6Xic8+YHbROJn3l3VW0lQzzx0I+rYGDijJX8mdHkCM0nOuDn8bkdivpNWilClvP52/sFV1N7KdYZrEBh9NaxR9VQwVUs/6Dt7oNpIzM80YTnWvSzfQfAOIQ2DMtlqQ4t1F2NYdebxj/Y/XMRZ76zgzx8aQXAbFbGupf8KU4cqZb3z+0bAgwhgSuCWc4urglVQERRF42AK2y/sK0a+V6+GeQvRe4YEGNPyQ1Yblsij29sjc3558JdIxRme0IqN2VbjGXc0jCYvb/OtBe/m6ydu+7pItSWYkHMtgP0PxBlqBpNNLsi9F76brNiwsJQ+ismZm5uul1U4Rv/N6WdTcvN50hw+OvAHwI0mG7fthv0sWQE8GFsKBCqF9Aall8qU8zkA6Je0Q8y6Uz1TmQ9292kKtFZWZajBmPDFSUf3xDe/K5WKUGlBabviq47Z4v40rTjqtnhiy2qJVO6EpDXZ707bQHCfPT/I6UTcjLQ/tbPfs2n7elF7eAb9OAvD7gZID9zo70GlKx2GLqluZZWwpKVEWymooVtjBYUlkuG6a+nvqJX2bkVXub4rbitzXHU6lf8EUVCfyh+K2XAokFRGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VG43cHpDcE9wK2JWUjRhV0FtMkhHbklYQTB0N1Fkaklac0NvY3JjcnJDTDJk?=
 =?utf-8?B?Y3JPQ2ZrVm9KTFZFUk1qL3pSako3MFVZZ01maEp2UDg5cE9xc0tOdXRJb1Zz?=
 =?utf-8?B?dmEzVHEvR2Z3VHF4ankwQXJNOXRlUWtOd3BuQ1hJZXBYQyswaGExUzhyN29k?=
 =?utf-8?B?WVpGZjlvQUVDS1Y4Z2h0Qmw3dnJXVjN5SWtuVTFNanN2Nno4Qk5ySGRIK2dP?=
 =?utf-8?B?Q3g1TlJ2d1hDT2ozVmFKSE14b1czbFRuakE0T1BaQjhnelpuRGg2TUNmWWw3?=
 =?utf-8?B?UGMwV2xzcVVneEd2eXZ1cGtQT0JibERXaDVRSnRYNWpNSlorUlEyRnFQKzlY?=
 =?utf-8?B?eEpxdU5NcDFNRlJzb0N0YnVUeElteUR1ZS9YN3l3SjRLcXR0cG5Lc3B5dXNh?=
 =?utf-8?B?UDBHQ2NOSTQ0ZkhkZWt3NlNjYzEyT0FJSjJPYmVsT2FqMWNSdFNtOEd2NEhG?=
 =?utf-8?B?QnFZcXFFNTZYUERtRVFBMDQxeW94aVlZTS9yRUs5OW16VTBCME9xZVp2U2Ft?=
 =?utf-8?B?amYzeHowVkFLUmRpaDE2Tld1L3UrYmxCd3JtTTlHbTdDNy9vQXk4RGRVRHJh?=
 =?utf-8?B?ejNORzlGLzQrQW9Zd3lZVGowcXV1U215bEdLckd4ZUZveVlwYkl1UXhKelFp?=
 =?utf-8?B?M0dNYVY2RGZrcTRwMk4zWmVwT2kyY1AwZjdKRWE5alpKMXF6enVIcGZGZTRE?=
 =?utf-8?B?NGN1YklVN08yb2pMQ05zaFBEQ3NTK2swWWpicXN2a2F3TU1oOUEvYjRwYzRG?=
 =?utf-8?B?QkRNWUtWN2VtdDRHcDk1Z3gwdmdvZUR1dmFlM29ML3ZNamg0OGJQa3VzNkdV?=
 =?utf-8?B?czNNUHcvUnorKzlsNGdKZDhHQ2tDRDRtQURUMHYzNU92cEl2N3MrZ1hseTBa?=
 =?utf-8?B?cjFuaitxS0FkclY4TGM5ekY3WTUxUEYrVDdOclN3QVVvbGVlRlVZNnRVT0ZE?=
 =?utf-8?B?RnVzblIrODNPRVAvMkdpRDV2Mm5mT0hXbHpld0ZuNytGaUJEaFcvajdrUXBt?=
 =?utf-8?B?akdkSHVzYm5jNUFNeWkrK2JZSW9xOC9zaVd3L1lzMGJIT2ZwTStwbWk1VEll?=
 =?utf-8?B?aGtKek1Bb1l4SHlacTRnRm9OOGw3MUZ1bnNrbkd6eFgzMWRLZ0NiU05JUURK?=
 =?utf-8?B?dFc0QmFhTGhzZFEwK3UxQ09nYlgvSzRXRlBDS09VZVhiM3Nqem83b0o3d1pv?=
 =?utf-8?B?aVpyMHpUbXNRamh5YUhNNUpteWR4YlJiVFhwc0dHelljS2NGS3hRZUhQTzl5?=
 =?utf-8?B?TU51MUY0NHdINkVEellBWUpWWG5yOFFZZnJSS1lLZEY1QXlIcFhPQlA5ekg3?=
 =?utf-8?B?cDlMZ1dTZi9PRUI3VG84K3NZYUpmSkZDcklESVQzTmd4Yk5Oc2ZVYXFqcUp1?=
 =?utf-8?B?dnNUNjlZMHRIVGVYR1RrL3J3amZqYkM1V2lHeXZJZjdrSzRIMndCcGJwaVg4?=
 =?utf-8?B?Q0laOUhzTzQ2VFdESlVlODdaWENTeGY4blk2RlJzNlNWbWpjMVZtVTY5Z3BU?=
 =?utf-8?B?SmoybThoMWZoV002OEFwVHFlU2hGVEp3VDhWa3diYVh0MTJ4ejVRTEQ2cjNM?=
 =?utf-8?B?UHBjQ3lzRVU0ZlprV0FSYVNOZ0dKUWlOdzdIa1VLMi9GMzFMeU15S0NmRTVO?=
 =?utf-8?B?cnFuZzc2UHA5ZmgrMnZYYW5sSlM0ZlY2VHBVRGtFMmVkck81WnNydVplOHVS?=
 =?utf-8?B?RVlwNDhVVGt3bEJQZEVBb2tCUGovYWpoRU1qRk5OSVFBUDZ3TkFuSk5RMnhI?=
 =?utf-8?B?ajVXWVMzamlVNnlhU3cyTjhWWGx5NXlFdFpNY1hFeEJrajJrU0crUm9wejlW?=
 =?utf-8?B?RWF1Nk1lOGN4T0RDWkJwS0ZGQVpSOTR1ZnN5a2JTNGp3c1psdUVWZnpFcXJU?=
 =?utf-8?B?SmRHb3libnl6YkVTNXYvVUttTVdwR0JkUGI5RGF1cmY0cUFHMDdBVzVBRlZR?=
 =?utf-8?B?Q05SaERoVVZFbHErNFBOTzQ1TlYyY2xOWE1aL1lrZDl4MjZQUHRoSmhWU2xP?=
 =?utf-8?B?RDVYcCs1VVdDSit0dng1d2NPQ2pxVTdPTUJJbG1FWlZFbGR4TmZYRTNCWXdS?=
 =?utf-8?B?dUVYOWt0S2t4WG9MVmlHb0duMG1heUh5NVhqYkFiUm5RaUFtRmJ6OGNITUQ1?=
 =?utf-8?B?cG9ZeTJqbGRoZmtxa0RNRzltWGo5TVk1MTMwSHFjTWRmeXZUaS9OVDVseWJX?=
 =?utf-8?B?NzRwNGxPV09jNnpuZ2Z3TEMwRnVPK05IYzhvcDVsRnV6cFVFQjRoZUJFc1gr?=
 =?utf-8?B?bU9OR1BpanEvcVB4MVFSL3IxTkg3blpJbkdTSGQvSXExSmhhZnZZWHpyV1lX?=
 =?utf-8?B?OVZrRFEyN0NoNjFUZ3RrbVdhZHQvRnBsdmtQMko0UmtqQVd4bExRQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14a7bb0-70f2-4c26-cb34-08deb6f566b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:57:04.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItLB6fM60GC9o6Zu8U1oUv1ghLJBBzIf7JBz7qXzOSstW87gx8iQkQqC164uT+DCFdhpDSFk6nRci3a1+ZwLZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3284
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 04:57:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22987

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=5&day=21&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/05/cip.2026-05-14-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - next week / Embedded Recipes

Jan

[*]
Date the data is created: Thu May 21 04:56:43 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue May 19 02:53:20 PM UTC 2026
  limit date: Thu Jun 18 02:53:20 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  7 11:06:48 AM UTC 2026
  limit date: Sat Jun  6 11:06:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri May 15 10:25:33 PM UTC 2026
  limit date: Sun Jun 14 10:25:33 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May 15 10:28:23 PM UTC 2026
  limit date: Sun Jun 14 10:28:23 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri May 15 10:42:48 AM UTC 2026
  limit date: Sat May 30 10:42:48 AM UTC 2026
  Status: On track

