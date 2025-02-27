Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E7C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 08:25:47 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.36])
 by mx.groups.io with SMTP id smtpd.web11.6342.1740644742628127004
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 00:25:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pS9QrD03;
 spf=pass (domain: siemens.com, ip: 40.107.162.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgfpL4egjHtffR3G3GHzhyE1gtF/la5Pb8bhNv5aeqJPOHzP8Cqd9h1MUiRSl7AZ7y8huSHZwvbDO6TK8CWJnwZ08VRKCZIqY17hV2lRzPoEupdm+MTDNq8VZnNG9da1GPoaEi4U7Ap64wwCqPkevWfCv/f1GIQzKR0+s2Y8e8FbeOj8JTIjdb0WorA3NxF/FWbBU08kN4VCKP1by2fCEIiUnsfF0Lu0RAtd4D+INesc/wn6hz7oC9zy7NpvgVVoV7NGUKjC2aZX7G0T32JUUFUTu/LXHmIr4FTG7fmjqUmx2a9JdApcjJeWdSyPWJsrjBdwl8jTHKAkwmvj2JictA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5tLB+CrkathEuIhv/nAt476Ivljbl6g5c/boFOB/Uo=;
 b=VvoeYXGJVlGc1OIW21OXqMkkCGdWe/QztYCdNSpbFmRehP6InRtG4GJUXWiVa4rW1XnAbVafriXQ1IqN5i426ZOgAcexBTlO5PsvQ7djV/nCKSPxwTGrM2xxmgvMVOfsko7NDJdE5T9duIVHE5Mooay/5X0LlfdvNYgmO/majbFkVZbXZI1YQRr6y6vnSglhIVwgJYaxwuFrmhWmxsElfxTE8hWuRYXNCTVCOYBZ4cYLrBDknTXwhjO8a/wk6EeKf0dv11rzQ3vNyvrJaRQAPLubr5v/FtHqXwZjboK7QSQOBur+u1DpQz68b9mVM/l2TGnC8wmYlsX3i7TskUAeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5tLB+CrkathEuIhv/nAt476Ivljbl6g5c/boFOB/Uo=;
 b=pS9QrD03hJgm/kd8H5MjGqcNy4DzODB3k9SOSXEDuMiC8s+/q0FxTZmLI9VoEZvx/UTYmtvLk7he1WYltslVRLyVPndI3Gy6yc5UaX3W2lUIvSArZOF1OiKam0z1oDOrdnDVlfGXGqJx8nEEwHLDf7Hxps+T2X3DkpOqOoreCMXgypdMgRCyTlzBSjXy5Gc04xJNWAqMsFdD6iP83tfK7gBElKxpF0917Ud0uZIWUAoqXH5xVSFVgAWJIgSK3VDapezgeppIZlRxwCa1TtLGHxx90hD7ivw7Ts+kusRGxrc9eb6f1fy144CD7Ahia9aK8Po2CFHSNZH6xiPkDIlSBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Thu, 27 Feb
 2025 08:25:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 08:25:39 +0000
Message-ID: <0a491449-f3a7-417b-bfa7-c3a2c239ed6f@siemens.com>
Date: Thu, 27 Feb 2025 09:25:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: f6073055-e1f1-454c-9a58-08dd57085128
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFZpWW9sV0F6emlmdGtFSks1UVJLb0ptdEJoM3dCdURqUzVKR3hXUVZhc01y?=
 =?utf-8?B?cFQvdjRmNkxYcHBUUXlmbUtiT3Uza0Uwd0pTWnF2SjVvVWVtSTZ6VjZpaVV1?=
 =?utf-8?B?dGVHc3dMZjVOem9BbGsxQktQMjkrb094K3QxYnpibEk1cS9rdThmaUtLNUNR?=
 =?utf-8?B?b1gvb1FrNEdnd3U2b3pwbG1SVTIrUTRIYWRxWGk3SktmWEFXdTRjckZKRkNS?=
 =?utf-8?B?Y0VpZE5ncVd3YUxsWmNlQnFGM2VBNUQ1dHFsd0oxaVBhQ2ZQVHdZT2tvR0ZI?=
 =?utf-8?B?NEg4NUkvWmdRVFowTjNObGJFcVZvR2poWG1oOGpqN0FmRnN2ODNrU1k1Um1o?=
 =?utf-8?B?N3I5WnR4MU1BaWx4KzdYRFJJcXduR2FOSTladWtGTUhRM1BWRlhkSktQM0g5?=
 =?utf-8?B?dytqRjJZVndYbXVDaUYrcjZQOVg4aFZLcEFIek15SU1CMkZ2MjhERnpwRito?=
 =?utf-8?B?WkhDdnE3VHYwTlMyR3RUS0VTc1J3b1FYNlZlNTFMS0twaWVvTEdaNm5yTUZS?=
 =?utf-8?B?S0MwM1FKMTc2VEg3OHprU09pajhzaXFPNWNpZXdydGxJSC9MNGNjM0NWRFNy?=
 =?utf-8?B?YXcxVGNPRGpqNDFmSFFYQWdOY1lSZEs4UUNVanFQNi9zc3Q2aUlnNllmNGdE?=
 =?utf-8?B?c3V3bXR3TDk0USs0SlNBQVozV2QzdUExQ2tjaTNNb3EycnAvWEJkR25uVS9v?=
 =?utf-8?B?YkdGWndnZlBiL210em82Y0FXVGRlR25rcVp4NmRoTTVQZkwxUHFiVFBnVS9y?=
 =?utf-8?B?RnluK0h3RXlpRjBNVm91ZFEreTBKS1U0dk1tUFpnZmt4Qnhra3VpVCt2OVBU?=
 =?utf-8?B?U2NiRE0zY0gyNnB2V1FlQnp1NjEwMEhHYVBpdGtKZzVSWHB0cnFKRzdsUkNG?=
 =?utf-8?B?dTR3R2FxM3dtSDZjMnhGdTQ2NDN4RmRaU2hueEpuL2h4d3FNNUR3eDkvUkli?=
 =?utf-8?B?UmlybHZYTThOQ1VlUlREOEI3ZGRFVWRqOG9YZ0t3MGc0QTBVL3lCc2x6TkRv?=
 =?utf-8?B?M2RTclJoUUhTOTl5RGpXTVVrRk9zbDJFRjNOWkNzL2hVQy82dml1NEtlclh5?=
 =?utf-8?B?YjdVaE5TNk5wYlVtSGFoR1FJK21wTi9vSWZNRStPN1ozSHJQcVhudUc5TUFh?=
 =?utf-8?B?eDZRTmg3TnRDbG9mUTQ2cFI1T0FhdFZ4YmtKVEZqZVB4UFA3dVFUR2VHRTc4?=
 =?utf-8?B?d1ZxMzlZVjFTcTB3VStuMUZaM1k4c3RvUXQ2SWRMaGprcTZ4VTQ3QmJtT1dN?=
 =?utf-8?B?bHRIcXlVc2hGalNISkQ1ejN0U3pnbms5dmd2RlQzR2RQNmpFdytySjRnandN?=
 =?utf-8?B?ZitrK0dEeGdIbnEvMHNkZDZqeVVvYkVpeGk3ZEhpMld3L0VlbVJiTVdLcGRq?=
 =?utf-8?B?SVVDOUdxZEY5QUVGc3FxajNhSThzZ3MrY2NadHV1TjZxNlJ5T3padnRoVUVN?=
 =?utf-8?B?THdqUXhtTEdPbmoyWDVFQ0kwaDJzMndraEs2YlAxdlhLdWZjUXUrc0FGaEhC?=
 =?utf-8?B?RTlLSlN4Y1hWMFFHTmJrczhqSTIwQ2tUSkF3aTNlQ1pIN1dodnVOZEtuSG55?=
 =?utf-8?B?N0tmQ2hJTFFpR0trMllhejd4N1l1SEZRQ3ZsQXMwdjRaQi9oMXFDU1ZiVTdp?=
 =?utf-8?B?Z3hUUUo1V0g2TzBVZlZ6cWtpcGxUMW5yREQvaU80ZkMrZ1hTQVVGNkNZa3ln?=
 =?utf-8?B?SzMvWjZtR0RVWisxV2d5VWQ1NlB2VDRKd2QrK0tJM1FnSTVneW16b0EvNXYy?=
 =?utf-8?B?bVBPYURuVXZVcnVOOEFrWHBoTGhSNDZvM21BWUNIRXFMZEtPYllOWXBTd0NQ?=
 =?utf-8?B?WTU3ZlVvTHpjV21WTGZ3Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzVra1ZtUGxpZWZCdlJUWmtJdWRKSTJNVnVmb0R1MlovVjRRWDB3MGk2bWM2?=
 =?utf-8?B?ZU8vZG1HdnRGdFl0ei9zYkZLRU9OV3kyQWVNTTQ5QXl3VmVqZncrZkNDTzhX?=
 =?utf-8?B?SVZHWWxBQWF6N0lCbmVQWXo1aC85TE5BY3NsZGxWcVkrYUVaU2xZYmJuMDlR?=
 =?utf-8?B?c2hONExGMUlUb1BVaGNLL0s3MWVZaUlXNFZvd0VxSlZtZk5SQ3BhL1F2a0Zy?=
 =?utf-8?B?N3J5Zlo0QWRQUyt6RUpreERvMGJPcVVVc3NQSG50WGhPZVZUSzl6K0NIalZ5?=
 =?utf-8?B?ZERPb3RUckVIcElnc2lyR2taQ1BnMVh0YkhnZGh4czY4U0NyRmptUDh3dFRY?=
 =?utf-8?B?OTlKWEk2MkkrVWVialFBODNSLytjTFlPWU5vbU9xVW5QeFBNb0Zsanp3YUZP?=
 =?utf-8?B?VkJiZ2piZGFFNi9mMWFNaEVNaFZ6SXpQSzFodWQ5QjFKRHRFWkRQQ3U2Ujh2?=
 =?utf-8?B?bm9RZTRxajhVQXRkWWpQVE84R2RoazU1di9McHh5cG1XQTJYUW5KOFlRenU5?=
 =?utf-8?B?bCs4ZW14Zlc2UkU4RWZob1g3M0cxME1tR2hveVlJMkJSSk14SE1kUW1aM1lt?=
 =?utf-8?B?NDgzMlVCbWhaQitwOTJFUkN6ZGg5dUYyTnhUc2I5eGRoU240UG9lbWQzcU1F?=
 =?utf-8?B?bUdzZGdxSUF0UnB2K09sdDlzcW1YUXpmbWVFZk80VlgxTlp2RVhVNWFwMFBi?=
 =?utf-8?B?RThNYVR5RXpjKzV6SnJwUEIwd2s4dWFQUmhsdllyODRSYWk0Mlh2UGd1cTlv?=
 =?utf-8?B?VHFyN2VJT0puOXBDVFJjUnY2cFZLQU9OVzRZRit3TTlYanE0R3lXT0grMTQr?=
 =?utf-8?B?WmtxUDlUdVc3Rm1SL3hISkFJU2lLVXRreThBclFvbHJUQVlRRkZQWEJkMUVH?=
 =?utf-8?B?QkQvWTUyWE9kMkl6dGNFRG5XeTdJUDd1YnBsRWdOL3JQbjc1NDdocVk1MUgr?=
 =?utf-8?B?SkRXR2ROQ1VDRWFnM1dNMnhJZ0ZwTEM0NnJiWCtqRlEwWGFwRmtqa2pxd0k3?=
 =?utf-8?B?YTFOQnZqTi9TSGFvSS9pNlhPd3BmcDNpeFpxclBCM29JZ1pCbXNSMjFWMGgw?=
 =?utf-8?B?TzB0cnFmTWFSZHRmT2RXZUdLSTVmd2NoY2c0aDlCM3hJOG1lWkJlUTRVY1Rm?=
 =?utf-8?B?QWF1RlRBaG8vWm80WnV5Vi9OUzhrSkt5eHZnUGU5a3FQUzQ2cklZSW1xNkFT?=
 =?utf-8?B?S0hWYUYySmZ1L0ZjTExQbnRFb2xoRVZGQU05eU9lcGdHNFBNdkc4OHA4TWZ0?=
 =?utf-8?B?ci9pK3RkdnNjbFdmSjJnaUxFalpWSTEyeGlFR1pGN0tHRWd3cUtobk1pL2Jk?=
 =?utf-8?B?bFEyOFJYV0hVQnBZaWhYbWVWYld0cVFhcnptY3IzRjdlVnB5TkZkMlk5bVRK?=
 =?utf-8?B?N281aGdqOXhMNDhLNURxY3NkMFMxeTAzOFlnS0J2ZUROamhxZEg2Ym1CQ3BK?=
 =?utf-8?B?dC9hRUhLNEk2Tkg2ZXlkNWpRUUdaRXlCYU0xODFRcTl1ejNHck44ZEF4czdh?=
 =?utf-8?B?SjY5T015aGZPdWhEdlZnblJzMFB4UWhYWERBT09KdWtpam9tZUdqcVk3dk8v?=
 =?utf-8?B?bU5PWmVQRWlVRFJNK1R2Wnl2Y1A5ejI4RDVQeW9maFlBeEFnWXVlKzZyY1BK?=
 =?utf-8?B?ckhJdHVUS21UYllBNnY0RVRwRThDcy9zcW84MmxZaW9zckRLeUpWOWtramJO?=
 =?utf-8?B?dlRWd1BUckI2TnF5di9UYk9BVHVxenlWcVFvTzlPNzVub1RkaFIvWG9iYUVs?=
 =?utf-8?B?Y0M5NE1aZXVjWE8wbkY5Zm1XRGlUbExNa25KL1IvUytsRmxLTENDNnVsUzRF?=
 =?utf-8?B?WUZNenNmMm9mY2tXbmtYUWZxdUJTb1pFaUttNWxacUxJaitlZ3d4eWdUaEhO?=
 =?utf-8?B?Z2VwUXRsaWFXWlYzYzh4ZXVIbUZaeEVkTnUvclRUa1FpT3JkVXhEeVRScFFF?=
 =?utf-8?B?dHhMazlGYXRNSDdHREtpdXF1dnlHcWhLZGJsZ3FFZjZKcEluemo3T3BUek93?=
 =?utf-8?B?NkpIZU9JcndBK0h6YmxiYXdSWjlRZCtuc0J0VTlwS1dLV3cwWUFuZEk1WVpt?=
 =?utf-8?B?LzdhOGJsakFDV0N3amNoOStFeUF4OUFOdmNlaVF4UHZsOHRya1FvYURpbG9t?=
 =?utf-8?B?S2VhUGF3V2I0eW5ua0FJdXdjVFR4ZkR0UjZDeDc4ZFdXb2xGQlRLbjJGV2Z3?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6073055-e1f1-454c-9a58-08dd57085128
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:25:39.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKbJDzr2XOJhWrfpfP5PzKOD3UV4W5s81u9vaovyaeNjssRRCmLASYj+Inh+rgqL7CB9i5lw6Y7DRu6YvSL1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 08:25:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17928

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=2&day=27&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/02/cip.2025-02-20-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
  limit date: Sat Mar 15 07:52:32 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 10 02:15:53 AM UTC 2025
  limit date: Wed Mar 12 02:15:53 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Feb 13 10:01:34 PM UTC 2025
  limit date: Sat Mar 15 10:01:34 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Feb 13 09:09:51 PM UTC 2025
  limit date: Fri Feb 28 09:09:51 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: On track

