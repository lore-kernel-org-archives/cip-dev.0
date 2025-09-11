Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B1CAC583
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 04:57:27 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.15])
 by mx.groups.io with SMTP id smtpd.web11.38592.1757566643661543113
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 21:57:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kBRHHw5K;
 spf=pass (domain: siemens.com, ip: 52.101.65.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRKgsGsTHgAHjG04wNoOE4L7HRj5wL/zqebq9NGeGQX5BGxmXm1+gdwHkjFzjl3Jn6kY0e5IaIDABLPluDied2PjVzIN0o9Vd9wYMN/hRi5NFKVUAs/UuJ3I/m40P036Z7e9u+eB1kw/y5GqujMlqZ0CNRtj7k2F87zmAuDQORl0R8Egvb7IVJU8t28Au/0iWh3Ksz9StaBz7+aTexdoMbcfVRBCmFUA1hadlz51w7gv0E/PY8SHJr/QSUR5ajCOhWavai2R3H6ntg19vi/1zPzjcAlTLUU40wc8NkwznwVuHPsaNgiWs51qsaKoVHeo51pmD/3bvli1i2TJr7LjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhVpdfZW1irmxYKQdKQy2Xdq7oyAnYbxA4AgvkYBSlo=;
 b=n5jzlbn52CgEA+ijmguvMAKOyzdMdCssllsw+o+1Maeops6MGWhtR9ydq4u5FiYDRYsYs/F1zY+bo1BxAuoNwj0wXqsEtioqa1vqkRL/7Xii0TE3Ba3g1wlEtSCVjMsopvQhjq8rSAqU/TNILlbARrM0FmeMW8MLJX78POC4IY6Bs4L2Fp8QUUA4DcYez8GiuRb8T0p7UkEUDdSQKT1V4psVlb0uo/1SJQ9gfBWsnqeFib/X5JBJkXXevU+njq/D8X1cmtALq9gvPDUBgKRxWOnuWfe1m9W35YP3ZYEASlqAnbv9qkmJw6NCm+Uq9Et4wsK2j28gfeGiUng1blzIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhVpdfZW1irmxYKQdKQy2Xdq7oyAnYbxA4AgvkYBSlo=;
 b=kBRHHw5Klqku3nhRmtV0X7Sh4R6JbqKlm2UQfxuuf8Jr8y/iytFumrVo/+hrwwBNkUR/thDfvcltRDC3k/93nqa+dHwGRpqafSyhtY55xNIArou77pTxYdR85T8Dssyov8LTLL/5Jk3ozRs/t29+YQ/OJJ4YoaiVLt+EXrN8OJSr0k9Bbq2Uy9dcV7e0lnSgMf/g0g95Y1WE6to90kVLFPFdCTZn4v34iZJXQPBzYRfxL+rfFqQLZyBsR4dlDild6IoVdIA8Ab9JnNUl0SNMGEYdSOdyHa04UmwCzakxUKZVvMic91ZNh2yRH+clqR3+Z4BYIneQI7S+ybuDah/eAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:360::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 04:57:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 04:57:19 +0000
Message-ID: <7e64c5a9-ed92-49c0-98d6-18197ba24748@siemens.com>
Date: Thu, 11 Sep 2025 06:57:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e39474e-2473-42f9-5ee9-08ddf0efafeb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aDcwZzNxMURmZjZsUG1PMG1UZUpOR1ZJMUxxQVFhQ1drS25Kcmt2cUx1ZFh6?=
 =?utf-8?B?TVBNNTZrTzkya09OaDJ0QVJla0lxNUozU1lQNVUxZXF6ZGU0TVFXWE13QXVV?=
 =?utf-8?B?YllXajN3T2Q3bklHaGd2RnVBb2ZmeVI5OVlDVTZwRTgwN2dmUldlTWhYYVdz?=
 =?utf-8?B?UnVSY28yZWFsZVdxam54a2tVT2RpV2lEblN6M01jazY0SXpLbitRd0g3ekRo?=
 =?utf-8?B?Z3NXVXozdmtEbS9YUndBK3k5cTVJa2l0ZVlYYnRyMEVTWTFPN3hWOXdVQjdu?=
 =?utf-8?B?WFROUllpb0swSWE4d3NkRmJlZm9TYjllOU1pd2ZnVFJreUcxZXQzc3FjZFBI?=
 =?utf-8?B?MS8yeTZnajI3WHpWV3FWdEFLTzR3ay9mREpUZEtDeVE1RFMydVc5Rm1DVkVM?=
 =?utf-8?B?eE9FZnB4ZjlYbUNVS3lHVk9XVm14QTVmWjYwbFBOYlFXdFNEV2htaGszZ01S?=
 =?utf-8?B?TXVYNEVHMVQyNDFsRDBOTFdTWm9QSFFzN1VpUGdLckxtWkVtckw4NUZsVXhC?=
 =?utf-8?B?a1phcUx6TTdwcE1oeFVVbkM2VzhNVXFVd2FldlQ3WTVVWnNEaktYaHNpV1l6?=
 =?utf-8?B?cXZMdHZ4UEVSelBZT3ZlNU8rc0hHRFlNamwyMnd2U3Q2djh6VGJScDAzQWJL?=
 =?utf-8?B?ZDNSNkFKMitaM2V2c0EyTEJBU0xCMkQxcnAyUU1qNGpxNFc1QWIxSU1rRnBR?=
 =?utf-8?B?c1Y0ZmgxSk42QVM1R2pLcUk5RFMySzNwb0VSb0pTTFNwUTZnZVpQdGR2OWV6?=
 =?utf-8?B?TXJhUURGZm1VditrS0g2aHhUZFZ2Y0EzT2EzbGRhU0NEZm9KMm85emJEZWgx?=
 =?utf-8?B?RFlxZDFaT1AyZzNaaUJsbWZKb0JUZDUvbndZYTk0QjdkS3BUOGY4eE54Q3Z0?=
 =?utf-8?B?OHpwZUdrL3Q4Q05mMFFmd2ppY3ZKZkY0L0hqMW1ZdTRtMXpFZUhKdnpQUmg4?=
 =?utf-8?B?SnF6ZmRGYUt4OFZjL2plQWhNNXFMUzV0aXdPQUJBeEczd3NCNGlJMktmS3g3?=
 =?utf-8?B?N3I0S0x2Q2JWUFhpYnBpU2J2aC8yVWRPd1lqcTlFVXNZYXBNL0lPanBDdks0?=
 =?utf-8?B?MXZ1bEhxZGg0dXFNUDNpTVFiYWJsK3dOVWtDSTJuTmFNNUVlTlRKT3QxVUll?=
 =?utf-8?B?ZW5IVUZjU2syTDhzQ2dqZHNDZU5OaXljVFNIYzFEMC9oUU9MRU91OURKM1Yx?=
 =?utf-8?B?NEpjMkZwUlF1bmFlTm51K09DZHErYStTSi9CeCtLN1hCUHNRUGtFYkIxdWVh?=
 =?utf-8?B?UkRnYVB3MmJDRUd1RWRTVDQ1ckVnK2tDL2NiRFFqeFdhZlRDYW9zWDRwdGFM?=
 =?utf-8?B?SjFqZ0NIMEFMSTNCeVdEdkl3aG9zWHE5UWQ2Y0g2ZWZ6V2Zya1ZoZ2hjb3Qr?=
 =?utf-8?B?WDFUNWxpdG5xWmVhMHRXbHJCYTBZcVdCWTJ3cVRPVDFLaFNLMkhPN0Rrekd5?=
 =?utf-8?B?cDEvaDkweGxBTktiSm5uWHdsRFZXc2Z1anhEdlFwNzA4ektvNFZGaTBueXY3?=
 =?utf-8?B?UE4vY0xaMnNuQjJVRnBGU1NEMXZpTzVNRUg0Y3RZY1JNRGJpUkI2U2wwc1h3?=
 =?utf-8?B?VXM3RThwSGRpU0x0aFJob1cxZ1UrRzNSUFJ2STBOVVFOckdUd0Z6Q2R6SmpG?=
 =?utf-8?B?c3M5dWZmR0pzdm9FRXhObG83REF1L3VBV08yeC9KaE1jWDVocVRZZyt0Sllk?=
 =?utf-8?B?Y29EaklJZ0NyaXRLeGNNQkpqbDNRZXdmTkxNM0NndFhyemRrQ1p5S1p1b21T?=
 =?utf-8?B?Y3l1YWYvVFVZQXZGVW9pVW83MndVN1hYdVdhVXg2ZTB4NmhTWjFCL3JkNWxQ?=
 =?utf-8?Q?CXvqJ8GYuen00WHn7MnZ190JCnUL/y3I9ESME=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dURtTWhXZ2NibXNxK2VvTThWWHhLdCtQOW1UdmJQWGYwNStKZmhYWngvQ2ZV?=
 =?utf-8?B?RFZVZ3lJd2VFaEpqNkVycWdBaDJzZHl4YS9ab1laZjdwVnFVa2JlVDUvMWcx?=
 =?utf-8?B?OWFkLzQ2b21WcGt5bDZIZ3FTWkhXcTlHQm9JdkNWaFgzU3RLM0NEVDhIbmhr?=
 =?utf-8?B?RUFaMXI3ZzNqQUdTOUJVei9idWQzbEhwQVJIUjRsUHhjbTl2VVpNbmdwSG1R?=
 =?utf-8?B?a1VYVEw3V3gvdXU2R29mTUxTZkVENUJhK29aWE54SE1CUzFLengzYWkrV1VL?=
 =?utf-8?B?MG9LdWErZUpWRm1BaFlxdklhUkNvM2RYUFQ1SE9RdUlIcEJjc2xiV0ljVWhT?=
 =?utf-8?B?RkloL21jeVA3VmJRekhLSDVpVGJzRno0NDVUYVBBTHI3RUJKRm54anB3UTZm?=
 =?utf-8?B?UFp3ek81S3J1M2Yrd0RRbm83OHlBK0RucHhFOHFiNXFsbzd4SFV5eHhDRUFt?=
 =?utf-8?B?L3VtQVpsR2VkenVGdTR2bXlkdGxEOGFMMWFFdFVXVlZsRHhVT01QT2V4ZE95?=
 =?utf-8?B?RTBNWjkxM3BuNi9DdFVzRjlIWVVZZmI0V1o5bXRSTGk3eFQ0VXpxeFNuZHVz?=
 =?utf-8?B?Nk5yWnp4bTZGYWZrRDJUUEorVFJVdzVYN3FmSm1mS0FHRUJ2RlVkOU9tQlpU?=
 =?utf-8?B?NW8xVFREWU1nNWJDdW40czVtcW9KNitKYzVCemZiUFdPUU9KelhhQ1BCOFVm?=
 =?utf-8?B?eWp3WHA1akQ0VzVpUFhRbzNDeFh3ZDFHLzAvRXM2bmp4YzE1K08vaHdocmVz?=
 =?utf-8?B?L1MyR29Baldwd0lmWmUzN0J6YUZ3RDFtQ2xrWEk3WXFpRTB4eGx2MCtKamtF?=
 =?utf-8?B?d2lZWml6ZmdQa294YkFJaHZzYUJUdnhsWG04YjRZK0ZpelNzQnpTbWpWSmM5?=
 =?utf-8?B?amZPOVhvYlFiMU1OY3lYalVNL3grZjZSd0RyOVlqUDUvZVFnSGZjdGQrUllJ?=
 =?utf-8?B?NFVMYlNIRkw3ZmVocTNZZWNVUk9zTUk4b2NNeW9PSVo2LzBvK1BBRTNGejNL?=
 =?utf-8?B?NDJvNVBUUDdDRHVkOUdFWGJuN2MwdG1wV0NMYUJXNUxnd1dQdlFWOWZoZlNl?=
 =?utf-8?B?MXczVHQwdGJkZHNvUTJEWW5rNlZ5Q3l0d1NEVTZmTDZUU3lsWGRDWng3Tmsv?=
 =?utf-8?B?WHRYUGhjZDdGMVJBNCtIMCtoM3BZM2V0bHlXRTdzdTNLMm90aTJNL2dTR2R4?=
 =?utf-8?B?WFUyRlBnWU55NFVaWDBLZ01hSnRaN2p6Z3hZSzJSbmo2ZGZFN3QrbzFoSm4r?=
 =?utf-8?B?WFVTYnF0QTlyY2lleUVreGR3K2VyR2ZoWjNFYVVScENyRW4rbXRtdHpwZXZL?=
 =?utf-8?B?MXY2bStlYW5aRVF1QnZBNFlSRkNMNEgvVW9LYldXQjIzVzQ4anZkYXc4OWgx?=
 =?utf-8?B?QnpOT3lQQ0pVQUsrUm4va0dFaTNva2VSc0IvdHJaVDBEWDlVQXNsOGtlUHVD?=
 =?utf-8?B?RVBWRnpyRzI2bjhpb3FDa1JXeC8vNkdoeEE3dzFOZDlJRDdNa1NBY1VUZ0pE?=
 =?utf-8?B?MHEzcnZvRm5WSC9pSE1hbm1ic2NKRzNrUXpEMnpzeldRSzZPL0VYUUNMYThw?=
 =?utf-8?B?RkxGZTFMVlhZWitkekNib2lkOWppRCttTDQ3QW9LY2VVY0QwcXF0VVk0eW9t?=
 =?utf-8?B?eHlaeWNmdDRScVd3VXk2OUR2WlgvemJrSytjNUVoR091QXFERC9qRmt2dmZY?=
 =?utf-8?B?S0I3RGVKQm56RExGc3pnMWFKU3kwRm9xbUN4UnQwRUFtQ3F1ajR4cmxVS3Zh?=
 =?utf-8?B?Y3NvZ1JNUzdvRElzeTAvVVlkZStFWVpjRnJzdTRxTjFpUml0K3ROK3VMYWpa?=
 =?utf-8?B?V2UyMTlSU1lGa0k1Rjg4aEgvdEg1K053Z2FldzArdi9wbjFhcFAzVFg1Z3ZW?=
 =?utf-8?B?d3c1ZUxGZ0JUYk1adDRxcGQ3L2dSRW5hM0V5a01CMzB2ZjdqZGhzeU9XWFVa?=
 =?utf-8?B?Z1pxNDNoUER6TnpISHIwRE9UcFlRdWlsVWh5RnVNNitHN2R4YUh5NU5kSU1U?=
 =?utf-8?B?c1FlaVRFNlhiRDFmOGQxZExRd29aRitld0d2MGpWT0ZBdGZYbVhaOTFtTGxr?=
 =?utf-8?B?cVJkeDRGOXcwTkZ2VEZNcVlMR1h2NElhY0ZMRmJkNUMvNTdrUytYRnAzQ2sy?=
 =?utf-8?Q?QpFfUMzSnvyegrHCon4ZGuZ5u?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e39474e-2473-42f9-5ee9-08ddf0efafeb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 04:57:19.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8MpsycsM+iidJEovQKqJHFtWcplwINHUX0ZbdoN3Nzpr7BEG9c/hXSnIj1bkg5FzNMUmAckk1nI243xmT533g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7820
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 04:57:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20037

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=9&day=11&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/09/cip.2025-09-04-13.00.log.html

* Action items
    - start define a CIP kernel threat model [Pavel]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep 11 04:55:15 AM UTC 2025
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
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Aug 20 09:54:43 PM UTC 2025
  limit date: Fri Sep 19 09:54:43 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Mon Aug 18 08:37:35 PM UTC 2025
  limit date: Wed Sep 17 08:37:35 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Sep  9 11:32:29 PM UTC 2025
  limit date: Wed Sep 24 11:32:29 PM UTC 2025
  Status: On track

