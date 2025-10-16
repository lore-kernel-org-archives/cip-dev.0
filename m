Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF9CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 06:13:29 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.36])
 by mx.groups.io with SMTP id smtpd.web10.1915.1760595203741738479
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 23:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TZd8H+g+;
 spf=pass (domain: siemens.com, ip: 52.101.65.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ric4/CImu5qW4KsJAiGPVuHybPuoNNu8rDawDsdRGClriSzGJIYLHXPawbQw1Wi8MGqQPYt1Z/LGeHgdjjaGO5inbqlHdeAOi1e0XRY0LpG4xZ6qoW+z6KW25h1JlSMlVU7Fc71qTyg4/Y7MoAPZI1NNaaLxYhRDDKxEm9e6kWhYqPHHB1SNoHSgvHhO0Yd+rE4AS32+dN+0wIQDmcOZ+W3AaEomUgKcdj1EI32XDPQ7er5R10BuqERO/sb9yajoOvHSa9bVj0rJpzxvG0iamW6lEPX77N4uL0hrzI0E7KsaszKdHieNV85037Fedl7pac3edF7mUUlWUP4PT3g6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD7tKv/yhLDX9XaZq44KHCXD4rQitNIISbtX0lDM71A=;
 b=YAGxg7Ir8MWfyOSxN1+cIiP/ZPNb6t/KMWW/CWUsGYjNZWpECqgA9e3F61FlAxX4fIMsY11il9C72naGkR6TSwzmyTWmsMcmkRGjy+uid1Ly6e39uVjxeCH5m/cwiqlDkHpt2YCOxg3s3lZ12TVuVAC1kJ/P7BwcjoV3B/qUzRNE9E5d+fN5rdgonz3N1S7ZDZXVqpH5KdZTgg9HtAGRNELGfR0+y9p4o59QEufs77b38SpkJBWGGRRj3W6fVPqAZyUR7s9NB7dq4LXYYTJuofE8McTVm/+aAZVsSQcFeV2rFUhQWacnBGmjquCoZt7I5g3/LVlwVyzyr/YT8IkcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD7tKv/yhLDX9XaZq44KHCXD4rQitNIISbtX0lDM71A=;
 b=TZd8H+g+TXg3XO5r7gGNpRZjzcRF35xwAfqTXW0naYxr3fGV/Y+c274dingz/Ro2Crtwkj21Qn6ToP7EJ3dlG8Std3XCqDvrOpdDc240iqnRY2/cMJI6DwpJJRJb2nXvBlKJK/TyxLBNODCYZnSO18gXJLTtlp4hcqfNr/Fw4/QVJoVZJ5VfjmVOIPVMtGNbuFsiYXj40OEYI3oEOpOKlJ4DC79S1W4q6DwaJ3z4DmfjZZJYfOr1ROkjtINybCtjmNeeqbgYuAbRsOunMxTa/mJhuKK8dLmP+rm31jg3ofchs7qbcwKq0wXoq7K1b8fxbTKRPuSXoDan76/bkloJAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8485.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:13:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 06:13:19 +0000
Message-ID: <fb148554-926a-4363-bead-0e451fa655e0@siemens.com>
Date: Thu, 16 Oct 2025 08:13:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c9e006-2bea-45c0-86eb-08de0c7b1a36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TlBDdTlxNkFaV0JNWEVQcFJaY09OQ0hUSU9aOGozOHNKRXphNmhNNlpvQ1BZ?=
 =?utf-8?B?dGNxMXphRGJyV2hLOHdiOXhrSjJMdC8vaFJOelJDWEZLakpuc0lWR1EzZmFs?=
 =?utf-8?B?TWVKelFxbHhkQUNia0RSeS8zZnViQjl3YWJOOENyb2dscHlXZEczWlpCdFdG?=
 =?utf-8?B?a3ZwY25MclQvN0NCdGRlVVFCRDNjNUlDcTBTa1dkTXNqYUFPS1JEM2t5b1BI?=
 =?utf-8?B?VG9XWU41VXFFRXVFUVpBWS9vT09NaE9KQWJXVmduTUgrNCttczcreU4xdlJi?=
 =?utf-8?B?cWsvMHJhL1lmUEJIdzkyb042OVYzT1A0ZEZwd0I2ckR1Q0JFK244SitFVHBG?=
 =?utf-8?B?TmJ1VEU0cWVkM0d5WFZLN1o0TlAzWEx4a21BcjlrZFh5TVk5Tk0vbis1dW9F?=
 =?utf-8?B?QTRTVVh3NllMT1AvbXVnOGo0ZmlDcWRRbURqa3p3d0w2bUtPdjJ4aEtLTWhr?=
 =?utf-8?B?VUM3OCtDazlJUzN2QTM0dEVVMk10eU5uZkEwVkZvNVc2bXBvK0FwK21Hb0hD?=
 =?utf-8?B?c1Y1cnFib1RRTXFXWnNIQWtVY29uTWpMUFR1VlRBSytJOXVRTjVJSUpuejYw?=
 =?utf-8?B?c0ZPQVZDS290QXZ5M2NaRHBxYk1wekt5UXVEZFFXUnZyWm9zUjEwNUFjaHQx?=
 =?utf-8?B?aWRRNWNpdVNxSkVlUm10N0F6S0hKK2xCbGNya2ZYVUVlZkJLV1FaaHZOQnBK?=
 =?utf-8?B?QSs4Zjd2Um5MS2M1L2JPZEZXSFZxK3dXbXY3eEl4RXBFTGJpTE90SzVsbE0x?=
 =?utf-8?B?VTFnQWk3b1dpWVVwVVJESXc2c1JlOWMyWGRDU1cxMkNhc1htS1dTcjJwN0ln?=
 =?utf-8?B?S0NzRHQwVG16dmtzbU0ydE9SbFZadFJTZlR4NlZNa1Z5a25TaXluWXFnYUMv?=
 =?utf-8?B?dWVjTTFpQmdrdG0zejYwUG45Z1hSNlZqcVZ5VXBDaUJDKzd1dURGdjVvMjdi?=
 =?utf-8?B?QXo0VzdWcC9ITnRhWm1uRGw5NHZET2tTQzdDc3RkWFl5RTJuSGxnRURlS2Fy?=
 =?utf-8?B?bVdMTUdkcG1TYW1qQkZCVitNZ0xWcU0vRC91OEhFTTc5WlA3NXpFdmxJaXNt?=
 =?utf-8?B?Qm4wdTFpcUg5Q1BhWGtEOGVrVEhlekp2SVdtVndGZHBzMllxaHhYQXlCaVVP?=
 =?utf-8?B?UXhEWFFrc3AxeU52RFpvMjVqNG50aWdURXNkUTZIeXhHOGd1WDU0cVRyZWxk?=
 =?utf-8?B?eHN3UnkwTE04L09rNVdiWE9lZThhd2xzdmFmaUtza3F2bW83djUvYzRNSVAw?=
 =?utf-8?B?a21aUmt6RnlIZmJOTE9aTVVyYVV1WnBDZ2k1Z2tlNEZTaXo2dUovNGtGanQz?=
 =?utf-8?B?Z2FKTjlVSm5xM0Y0MGpLWktybVMzWVAwdXNrU1NGeDRZcEVSbWFzUGxPa2lF?=
 =?utf-8?B?NEhJWlNsVUlKaHZKNFJ6RzlqbzFwL2FzUWkrWTF2ZUt2ZTU4RVFBQjJVcnJ0?=
 =?utf-8?B?ejU3Y2k4WmpXeHpWQlYyMkdKV1dKdmtkTjF0OTFzTFdjUzdWWFZhd2RCY3Zs?=
 =?utf-8?B?MkZoN0RKZnVYZnJ6elJkYUZ3NDhRU0JkcktzNGZxT0ZIeTBnL050Rlh4ZGsx?=
 =?utf-8?B?Mk9KanUvZ3pIWVprY0p6S1dEK25sOUVrLy95eFRoUmloamxQdDd0eE1BT3VX?=
 =?utf-8?B?OTZnQjh1TTlUWW9KcWUzbDBFQi95M3FGNW8raVplTkkwWm1MS2JZSWZQbFlv?=
 =?utf-8?B?L1Jqckc2VTdWcGY5QzVzUlR4Rk1QZVl2NWFkQnlFQ3NmSDFpY2pKVU9rNkd6?=
 =?utf-8?B?N2FwK1BKSHZTZFBpdm9jcFhsNWZsSXMybUFzSEhDTzFIczk5cWxUQ1lUMVo3?=
 =?utf-8?B?Ky9xQzlrM0pwM2NaVS95OE5xQjFGM2x3bW9vSjUxdWw0UlduMENTb0FEN0JI?=
 =?utf-8?B?ZnF2VDJicVhFejQzTDh0RFNodm9hSmxzVEpGNytxdEswd2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVRYZUxpeFN3UmlqeVQvUW10N2hLcitsL0JVTGZtMUUyUmc1RWs1aFduUm1I?=
 =?utf-8?B?azZQV21sYUxDekNTZlFsblF4V25LV2cySnA0R2M5UnNIVGtHTUx2SlZrcUZT?=
 =?utf-8?B?TUpZWFIraFdOdGxJSVFja1Y5ZTAyczVKeEhvZnpZVlNZVG9sYUg5NGJ1M3Yy?=
 =?utf-8?B?bU5pMG0yRkprNjB1OUJRQjZSUUNGUWIzNzN2YUFXSXJ0VFhyMUczWWRWaFNr?=
 =?utf-8?B?OG1pbytNdDR3WUV2QUMvcVlUMlI2d0licHlMajBsc09rSlRVbUhIbHN0SVh3?=
 =?utf-8?B?bnp6UGF1RDJkYmVzU3VzOTNYSHRldms0SENBam5VT3BDOTV3blpKclRST0NM?=
 =?utf-8?B?eUF4aXduMncwL1ZGSHpteW0zQWViQWZJN2V1NnJmcDNwaWRadUZFb2pQLzJH?=
 =?utf-8?B?VllISlkvWDRrcnIzYWRhVGEzQUVmN1NESXhZV013UzZKWk9jOUlWdUhNM2Y2?=
 =?utf-8?B?TU43UDg1RFNqcGhqRmQxVElBWkJUbkdLTldVVVduT3ZyaVRmc0pjNUNJSzF6?=
 =?utf-8?B?aFU2ZHlvWTR1bXJwVkNvKzU4RHdQWnFoS1orWWx5b0VaeXkrYmJMdWV1Umtr?=
 =?utf-8?B?UjdCdmM5L29VUDBONDJtbEVYMHErYjRjNmtkOWI0aEM2VzlDQkdwbjkrS2dI?=
 =?utf-8?B?U1lvZnlqSWx1TjhRMVpKdkREeVRlWkZmVkI1SzB1WFhBR3BBaUVZMFRibkZV?=
 =?utf-8?B?Ty8vTU1YaUZCZE1Fako3bkZITTVlUnFLaytWeGY4akdlM1VKckQwTk9oWURQ?=
 =?utf-8?B?RjNMZTFweHNtOTZTSkxnMXVjVE9LblRJVlZwZENrU2pXdXlaOHZlUU4zUUh4?=
 =?utf-8?B?bXF4YWxVV2RiQ1hNZWswb0hxblNKNHZKREM5eWJRK3dQMnB1ZEdHSHNYZlZX?=
 =?utf-8?B?TmF3NGFmZnhZYzUzOHBtdm44RUQxV1k4a2o1dFN1SzVvZ1BUZzV4MCs3Rmht?=
 =?utf-8?B?dFRMNWV0ZjFhL09aL21FK2tPZXlYSmZTeEtGOW5abkNNaVJCWUtab3QrUlBG?=
 =?utf-8?B?b2gvdzlkMXNlWTA1L2pDNUtCREVxMTNXekFBdGpsSHhuNlhka1F3SzlKR3VF?=
 =?utf-8?B?NFlMRDI3VHByb0FORi8zV2MrZXhyODh3Z2NXTHNGTlByOVhibFltcEZFVGFF?=
 =?utf-8?B?WHROU0ZrRmxyTTF3MVUwWUNaVWVyeHdFazFyMUl6cmdHOGpkVGhEakNRSVNn?=
 =?utf-8?B?c3FOQnYyVEd4UTd1MTFBMXZaUnBjYzQxUWtIRTN4cm9QU0tiSDdHZEwrQjNX?=
 =?utf-8?B?a3g1OVMrclJTaGl4dlVRWElRcjdMVmpiOUJaQmVPOXkwSDVnYTNWdnR4cU9L?=
 =?utf-8?B?bWpmUnMzZUV6Ym0rNU1TbC9lV2ppUCtERG5DWVF2akN5N2R0WHczSm1LRWVC?=
 =?utf-8?B?K3QrR2NpazM1MXV1ZFVWNzZTdnQxWnE0bnZQdjVicXZLRFZsaEN5SEdoblZv?=
 =?utf-8?B?cnFYK1NFd1ZrbHlNUTdqVE1aMTQ0UkYwWGNFb3FaNWZ1U1pqQ0FVREpWN0pk?=
 =?utf-8?B?MllmVXRLTzNhUFE1NXZzMmhHQlU1NU55S0JYZ2FOUldVWGRRZEZqVU9XSEdQ?=
 =?utf-8?B?eUh6V3JZMk9TMXFueFAxcEc0VzlndGc4NmhGYml4M2xuQ3FqVHY3MlpTaWJn?=
 =?utf-8?B?MFFmSm9QS3M1SlVkWWhSNjNONEhvWjNneTJIT0NVa2ovYytFbXBiQ1dvM2lx?=
 =?utf-8?B?TE0xMDFnQUUvMDlrNjNvVVB3R09Rak5GYUVyeWZrbkIyekVwZktWR2l4T0Jh?=
 =?utf-8?B?VnNwL2V3azlscHNIZ1BYMGxzRWM3bktwRjhYZUN0Nk9zdGg1YmI4dlgzZGYy?=
 =?utf-8?B?SmpSbXR5ZUppK2xENHY1aVJ6T2tsQWhKQitGdjByZjlQbGRWclZLVGFzZVBN?=
 =?utf-8?B?T3dSKzZqUkdnRHdvbG03ak9BUnRFaXdWUU9MN05NVi9lOUhHL3IrckkzU0ha?=
 =?utf-8?B?VEQvcmp1Q3VscU1RMWNGd0NEYkR3TnM1V3hCUWw4Q1NNaTA5NnB4QVJsM25L?=
 =?utf-8?B?SFVEZVpzMUxoYVgyNUM5eWxHVm1LdUtnRDN2WDd5bGtja21QbU5KU0lEVldN?=
 =?utf-8?B?RmI0Z0x5YXdqOVBQbC91VE5JNklRY0s5VXI0Z3ZJRngyc2ZFc2hhZERVUkt0?=
 =?utf-8?Q?x+MjzhDEMIMkXFDGcQEYwYS2G?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c9e006-2bea-45c0-86eb-08de0c7b1a36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 06:13:19.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEwW/qjEe4WclelCeTajF48nHjuX7dkKc1ecb+xYTJ7OigBlboPd5iAjq+fCeEJd4MBOHgKtEplpGzYK/fs4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 06:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20182

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=10&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-09-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Oct 16 06:12:34 AM UTC 2025
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
  latest version release date: Wed Oct 15 11:57:26 PM UTC 2025
  limit date: Fri Nov 14 11:57:26 PM UTC 2025
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
  latest version release date: Thu Oct  9 07:01:15 AM UTC 2025
  limit date: Fri Oct 24 07:01:15 AM UTC 2025
  Status: On track

