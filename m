Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BACF537D
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 10:01:26 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.61])
 by mx.groups.io with SMTP id smtpd.web10.10906.1729764085131341726
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 03:01:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vWBAtjDV;
 spf=pass (domain: siemens.com, ip: 40.107.247.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkL/TWWf0I6iChAjKBk5d12oUFaq7MBO45zVSfwmeBYUdHBHZQPhlx/OvpOSlVPeOq47UXbuNMJAfAQXgLftOP2B7nFeKGAZbsBUBPJmg0mHl/YW1bktrEtWpMGd374xSnW/YrtdNxd0/mqGdQsbWJpZ3vv1mBoc727cTVXSlPy4swxLw6kIYOpMz8BdmRIv1NKt+0tlOqO/QhBq28Sf6YM7Gffhtx0JS9gPS29wz4g90klsZE26w6LbU7z+2Ek6uhgbbZ1/TFN53u3Gx20kSVmJ/465ex1EmjeiV5NERo2tukVPQ4cFJGe68PTinMKi7jBaIalOPWOHX3nYZB2X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET+ZZA4VTpmgOcwAIwV48LUYh/8XM29i9x3Upu4rHlk=;
 b=jc6yDpuZCMiI49NdgCmBK78wkFwamjiuF1UbVfT/4pGOUTXLPO5YlwCABCDm26I/dVuptULKELWpEu8wFx8Y7qHHuBr49rSQejanmdBekYcn7io9Tn4QP0uMesVRfM0/Mlp8BAxCl/6zWnFl/HhtloaUGm/lQwktDhigeqpJchMn9GUVjaoviTfTnXcL4ExQ4oeLuDQr5oDpyeUONMJitZWzq39psQwVCl2adEwGooJBikcKA3KjR45t/GCO9fxFm7R96ep9iZvonML7ep7xOdw3rDUPlXB7p0hOdDn1xwTnm+SRd8mlgEblEXHrSbndFTCpknOXpNDAVBElh6tJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET+ZZA4VTpmgOcwAIwV48LUYh/8XM29i9x3Upu4rHlk=;
 b=vWBAtjDV2Y5VyghvZO30nYUM8MDm0+V7lR7XBICIT5U7N7Oh4pMh0Z3/CKcoDyABlkl7Amn1WV7iMMICTOnZWodewzBIpTtrWD78798g9g+WvmVDlTPV5VRPwAlngrN+itV05CcaOBVHqEvej2MKrpjKBiFNnWJRtqXMN7GXEEwojzDf+4p5hlCAKfkVZHB4aByrWfyLpjpoDE3vAYrpf2C7BQ0wA7GPVsFOcSmuHKnBp/ZGTCSGDLMS/nwB062U2zS+gTIf1cQH1sJ7eb39cLQgCkqD4UM6t3gXdUog9RxaYvw4QYuenuoPgJo2KCbCjRhZHCN12yq3X0dt9wcu5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 10:01:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:01:21 +0000
Message-ID: <cf485f5d-fef3-40b6-83eb-c14a9e8bed40@siemens.com>
Date: Thu, 24 Oct 2024 12:01:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: ac68094e-d659-41ae-64f0-08dcf412cff8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZlQyaXRONFI3Z2hIdFpvM1IzK3l5RlczemNUZTFRdVFhVnFrK2FTNDhJR05j?=
 =?utf-8?B?d2hOSG9lbnN4dlFmemkwVlFacEprTlJwMFZXOG0wbmVIdENmZ01oTE81bnBH?=
 =?utf-8?B?Q2VSczRUblBiNWRkSTU4enI5V3RpdDVld1lLYzFndWRvci9idCsvSzRTa3d0?=
 =?utf-8?B?eHFXa1pIeitMR3ZyRmM2SGtvZU1tZUpheXZ5SjBwSGxEK1NMcTA0YUt1cDNw?=
 =?utf-8?B?OU9pYVhPejdCYjFYYjJKZWtlOS9kQUM4bHRnWmFYSmhWbk1sODRUTTlicTdE?=
 =?utf-8?B?Y2l6WWZKOEtUS09YVzNFNndCWkxnSHovakJDeExJSmFJRHUwVUErV3ZDdzB3?=
 =?utf-8?B?ZGNXeEhqMVY1OW1Yb0NIRjUwYmk5dnpHcTVyMVQ3Y2ZXOE9XMGI2QnlzditJ?=
 =?utf-8?B?OWVCK2wvRWgzY21URCtyZDVGTHBmSll4cGJKc3RXS2hnRSsvaGVjcjdUQlh5?=
 =?utf-8?B?cWl4dm9LKzJCVjhaRks0ejJVR3I0UUFidmRiQk1XWWlNbnhXWjE4Vm9CckJu?=
 =?utf-8?B?VEp3cFdZVzYvb2pPUktPZzJLUDJGNzJZaWliK0tpVFFjQnN4MW9LeGpBRXVr?=
 =?utf-8?B?YjljYUdvWnZJQUZSaE40UURHL2dBbFgxNU9sdzZCaXlzN0tTZHhWZFVObFMw?=
 =?utf-8?B?RjZiT2pEeUw0RG9GbGxyQXJCazhyNjhQTzlUUWVNdEFvcXI5M3FpYzZNYjVV?=
 =?utf-8?B?ZXRiT2VPbGVMQmpnYm93MXUrVVVTVGtlZDd2NWdBU2JRc2tuSURZeUJxNEpE?=
 =?utf-8?B?aitkSHV3OUpFQVBjM3hyaWtmbEs3azVHeTB1R1VDNnVtZmR0YVRGL0NrVjN4?=
 =?utf-8?B?d2QrdWVNbnk0SzByaWpTUkhXNTlEVjlLWUdaSDJFTDFDTlZCZkVta295MTlx?=
 =?utf-8?B?MHNMSzZGWnZVQ3B1WDdVSE0vd25ENVN2RkF4S3JqYlRMLzlwZHV1ZFd0bVA2?=
 =?utf-8?B?YjRPdG1MT3JBa1AzWDJkVlNmR2NBQU9qUjVVcTNrb2dWL0FGdmIxTEtHWXNI?=
 =?utf-8?B?YWl4WktaUkZRNW1WUkxEOFh1UEVoa3BWZWpEUjRnUXpWQkk4RGFSZDRlNmhj?=
 =?utf-8?B?SWRYTzNHdUFIb3BBdU1XcmZlK1lDdk5RZWUzbUY3Q2FnQU9QN0h3Q1l3MlJs?=
 =?utf-8?B?blNMNXFzSHlGdWVwM0RLNHFmNjFKSk5MekhrY1huVlVLMGJZWHRKOTYrcllo?=
 =?utf-8?B?WVkrNlBsZ1ZXcWFrUUk2ekNBbFlSWHFwcGZ4cHFnb01sczVuUkQ4K3hiVTN1?=
 =?utf-8?B?S1hyTm00bC9FL2dPMG8wczVobzYrMm4zZ01vL2RiRTlPVWZCcGFnbm01cCtS?=
 =?utf-8?B?RFF0VnMwRU5UYzhJY0szNHkxQkltUk15R1RWUC96NjVRMkJ5RitCdnMzOVBQ?=
 =?utf-8?B?alJEUTk2ejlRcHJCTE9XUjFZY0hLS3BjM0k3MkdpREswWTQ1RnN1T3JHR1R3?=
 =?utf-8?B?ZlJ0RVRLVVdlZlFtZzg0UklFUExEU0E2UEY0WnptNm15ZUxRRGlnTEN0Mlhx?=
 =?utf-8?B?L0VzcTFBOGlsaHdEV1lXL0N2MS9uWHBHODNUSnNwMVNLTkRsdEJuN1Jud1ZU?=
 =?utf-8?B?eUFUZW1BaENCUWpKUlRtV0MxYk5LL2ZpcXVkV2JPTU4wTDBKL1VDVTZua0t4?=
 =?utf-8?B?WVRSTW1DY2lPRFpJdGdwNFpYaFVoVkMxNTZISkl1OHhzYzhIM1VqVXUrcGhz?=
 =?utf-8?Q?hex8/hkaD7xq32eME99h?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TldrYkE0dVoyWUtHU3JybWpwcXBDWjZlQ0VYN1lXdms4L0czeUZTL2pGUU1u?=
 =?utf-8?B?aWZUdkVGNlJQZngzSHZGVTNqMXU0YzMrYldQOUdDWnRMNThyV1pSOUNacnlK?=
 =?utf-8?B?d0ozUnNaK2ZZOE1yRkFyTnhuOXJWYThvb2U3S1Z6ZlNmSndLaE9Id3hTMHVT?=
 =?utf-8?B?ZEQ2eW1XR0d5TndpdURneG11aC9TUlVuL3k2bUdURGlvYW1GMU91TGdLMUcx?=
 =?utf-8?B?NVJMMGNvRUdHRWRPUlhGc0dxMjR0dnZCZzFqbXFNSjZpdUdaNWt6V2xnalZS?=
 =?utf-8?B?VnB0YW1OaVFiaDFGOGx5TDNKT3M1T3M4djJPY3g3ZEl5R25nZkhSN216U2Rt?=
 =?utf-8?B?em5tYjAvNSsvKzJSU3RUSy9GSU45ZXVXcWRWeVVuTEU1T2ZOL2hWQjB4clkr?=
 =?utf-8?B?Ty9qK1ZPU3hnVXhpbXAzc1luQ2pNVHJFWW9mR3JocHFjS0tXVldEWVkyWDQ2?=
 =?utf-8?B?TDUzK3piQ0wvcjliUmdHRUZHWERHeEF1QUpGM2xKekZ3QlFEb3h4YVpqT3VJ?=
 =?utf-8?B?djBvQ29ONFZ5aVE2dTV2RXlkSkU4QkdGaUNBUEo1cjhJVnR3djJTRzliUzdr?=
 =?utf-8?B?amhlTHVVMmhzWW5odTNXTDFaUG9uTTB1ajlOZFo5RVdZN0ZKNVVGR0JtYm1B?=
 =?utf-8?B?SUp6UTJIQU9TVmd2NkJqVjZCZW9od2orZXdISVpKMnd5dkJpZ2FGUFBJSWtw?=
 =?utf-8?B?MGl2TmExMVdPdUMvN3l0NGpZZlV5dVZ6bWlaclFhbk00czZOZ3A2SkNHcXJp?=
 =?utf-8?B?eFFrcGJ3UVZwODdLV3crbFUxSk0rZHFOcWEwUGxsYzVRYUZRT3ZzRmdONjlr?=
 =?utf-8?B?RVE3NzVpRWkvUjhLUHhHRk1JcWduY2lCUHQ5aWlYcXZqT29aL0J5cDFqUUtp?=
 =?utf-8?B?MXgvRFRoNlJtOFdvOUUvN3IrZjJhT0VwL2Fqa2hRN1VvSENVVFFNL2dPSXBs?=
 =?utf-8?B?QlMvb2tUaVJ1UlZqWG9RUzd2bHg3eW14NnJFLzRENUpxZk1RbTVkYlV3YjFs?=
 =?utf-8?B?a1FFQVZ4QnZmK0N4VDJZK21JTkJLc2tyWXNmM0wvRnQ2MVozVW9kbHlPaVFB?=
 =?utf-8?B?NWFDU3ZNcmVtTjE4TWRhSnZOb0RPakFuRnVHdCtyYmJ1b0VlclAxQlNKaWhW?=
 =?utf-8?B?aXk5UU82VkV4VFFPOVlXM0tJcVBMU2pxYVR4OFR5eExvOUh4TnV4eTljUUxC?=
 =?utf-8?B?WGVGRDVDNktXQXlPbjdOOGNGV0dsV3g1ZWJWM0ZqN2doYWdHV2RRQUREY09U?=
 =?utf-8?B?NlIvbDZjK0xmbFViNkNMYm5XYzBPNHdYWU01WkF4MHM0L0oxUGJWRm9YRm9t?=
 =?utf-8?B?d1QrRG5jb0xsWS84bXU4WlloeGJQYndia0pRa091MThtOE5sZUcvMkJ2ejkr?=
 =?utf-8?B?dE9aZVdTRkN4bHpaV0FSTHdyUXA1TWFSTi9TRDNTa0ZpNk5zd2lHUVZ4MlE5?=
 =?utf-8?B?eDZVQkJWM0ZiRzY5RE1RQ0pNWW1ZUU50RjM1d0thN3l6QlEreEhzN1hBVUVC?=
 =?utf-8?B?cHIreVdSN3FQZ0t1NFAwQkZFUmdjUG1XalplRlZ6QWYzc0xsMTdtamVxVC80?=
 =?utf-8?B?VEl3U25OclNOQWJ4ZVNYdnI3NVhRUW4xMWNVMGFqZjEvTVNNdE5taFE0akpi?=
 =?utf-8?B?QkdUbnhTZ3I3WDV0bWY0aGl0SWczdG1ESWNsVXg2eTJlblFGWnRTWEU3akNt?=
 =?utf-8?B?OFRTdG1FYjRGRVpnMzZKSmZqU2pKWG9PTGR6RXdIS2RMSWoyTWNWMkVDaEQ0?=
 =?utf-8?B?UzUrdUNqcVNET0hnZHp3SjBVMVlrZlJIZkRZZFltcUFzaHhaS0RyTHUrTGdn?=
 =?utf-8?B?dEo3bHJ2elNwdVhnSFpHSkRsT3VWTWhqRW9lYVhobzc3K2FVT1BjUWVlbVNI?=
 =?utf-8?B?ZzlaVDdZQWhmVTg2TGNvU0tCbUN3dlJhUi9HMFY3S1ZvSkVlZ29JRjFzcUdk?=
 =?utf-8?B?Nkx2T0lRVDF5TndSc2ZRdDljRUM5MXlJblVZdzA4Y09Hc2tmWXpFY25ac1pi?=
 =?utf-8?B?S0p2OXFiMlM2S3BxQVZXVmN5L0EweHlZR2lFS2VQT21tYVFPUUQ0ZFBjdnZU?=
 =?utf-8?B?aWtlajFQVDQ0QXYwdVdnVWdGZDIzZVE0R2tMcFFpZ2JMdURSTXI4Zm8xbEln?=
 =?utf-8?B?L0dxMWxGM1NZalo2WjdWQVYwbGQ4bVM4SUxya0MrV0cxdGxhZnpNcGtmNGUw?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac68094e-d659-41ae-64f0-08dcf412cff8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:01:21.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJllb4/IZNlQQ6zCJr/op4YqoLCo5xNN1TBqCPnDPKMPdb0NUZWxgWIpQpgqKx0+7w7WqfZ9mkNiuE/sayDGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 10:01:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17076

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=10&day=24&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/10/cip.2024-10-17-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct  9 04:23:37 AM UTC 2024
  limit date: Fri Nov  8 04:23:37 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Sep 24 09:32:37 AM UTC 2024
  limit date: Thu Oct 24 09:32:37 AM UTC 2024
  Status: Late
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Oct  9 10:54:23 PM UTC 2024
  limit date: Fri Nov  8 10:54:23 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Oct 16 09:40:02 PM UTC 2024
  limit date: Thu Oct 31 09:40:02 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Oct 10 09:13:53 AM UTC 2024
  limit date: Sat Nov  9 09:13:53 AM UTC 2024
  Status: On track

