Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB860C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 12:51:42 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.53])
 by mx.groups.io with SMTP id smtpd.web11.14664.1746708701914387330
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 05:51:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZyiZDlBf;
 spf=pass (domain: siemens.com, ip: 40.107.249.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/ULF9S3GxCtHG4uRdndgKNpSYo4TPFh6IpuaiBefSdl0r4GX4NjBR6moIqzjkBL1ey1oxMRuMYF5pY6j1MJnP+lLVoiRqgTQ0VmyR6zHu7ryk7YUiyuraDJlc1DILD6E4mpGE5Ggy2r9FQrTw45TZxDwJaSb8cOZJpagJXP8HFAIHdRqD22/nU4drg1bYmlebXKdQE0B45v04r5MPZyoMOL/jey7a7QKtPR1jcn6SzrY16Fd7MJJLMb7U/lM7VO7oyHjWK7d+0ne/+hJU0cLZYG1t7BByjaFM2Ms7d9FcF9zTyGAO5bNDjjowKETrzKFNwT2pzXRaG7iIRcuqiiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgozoaDdg5st4GC2GTr/HGSsGCP4J9RLJ+UOjQXHxSw=;
 b=bqLYNGUaIkLrTBUrnEwE2/P431ctY8R2Nu6CLiBWNYRCOD2JLtGtKQNCx5zy2mUHj5TzIjbvxOhZNtczOqHT8XZBU/muGnyqYZcQbIq1HtgHjAtgCPnhBdbjp8vCuReqqMvJPd5jSnDCLe4cmMF0LI+k16s5L/1y+U/laCJL45MoxmmAaHmhjgEGeuQkKzaOFej+qLLzyc8XuW3daTe90HDK9O+GmVRO1zvWlZ/kttHlDUv/tzFgXpCYlfs5nIwLSAEu67jETRwbNl0XCuhQAGUlRRaKmwCkXtJHChmStb58Dq6XqnrYq2E4SfsTyb7JTbszDpMp5dzwWnKSPIEQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgozoaDdg5st4GC2GTr/HGSsGCP4J9RLJ+UOjQXHxSw=;
 b=ZyiZDlBfvWX2zt9ZhFR9mQ5esIfqdH+Wh2fQpYNHJFjc3FHYMtLAQm7fU2X9v+NDL+ccAC2wNkF6gmq1dqTW/f37ozNnGbIYb1BbW77GsRfVICwX0weMfPvkcHj5aSaNsZRP3ccAk6BWS0WinvqbxoSN3naXbXb9f8fsBQtsi6V//LuWmfzUTYbeR/mfpKSltL03HpNsNRwV5HsDG+RJHMxc5QKwhEUVyjzomdy/AbASy9Z7SMfhBDYyv/awfL2To8GThW6QSM4Vs+l/SmHskfP7zSgFBtP/Wwb+VFZqEJdfXlZER32yJyys7S5YRksEFNr8xDWXKrp8xlvihPZuGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 12:51:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 12:51:38 +0000
Message-ID: <e6dbfadf-97b4-43fb-a407-c740ef343bd4@siemens.com>
Date: Thu, 8 May 2025 14:51:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 2/6] add factory-reset-helper to
 set the marker file
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
 <20250506120807.255675-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250506120807.255675-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 853297aa-6de6-456f-8adf-08dd8e2f12b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NklSdkxrcjUvcUNyMHhwajN5aDZ6NjhJYUN1dWdwNTkrVlBNcDcwdEdZRlNj?=
 =?utf-8?B?TjZiOHluaHEwWFNBdVpHbmlNZXQyMldlSTd2ODFEd1J4TVhxQ0ZQWlorNURM?=
 =?utf-8?B?MTVjbFBOVGRPVjI2T3ZsSEJuOWg2SlVkRWNQTlBEWVFQczdaaFFJdHBSVzV2?=
 =?utf-8?B?UGZCVW4zV1VYaUU3dHN3MzZaejRoMm5EdXVpbTR5TG1NQVNDVnA2V3V0Ym5V?=
 =?utf-8?B?YUNJL2pIOFM4cEsyZ3BjN2ZvZk1VVURrdFd2VW93MWtCRlFjd3JLeXoyY3M1?=
 =?utf-8?B?bmprT2dzZmh0ZnZOaU14ZVFBT0lpRGZHZE5kQzhJT0dZVlIybU5VSDk3S2Jt?=
 =?utf-8?B?VGpJZjEvazFZOExPZ3ZkWlA3QzNOeFlyUUkzczdkYUlFdE85VU5LSitQWk83?=
 =?utf-8?B?dkJ1NldoRStQV0orN3FMN0R1MGlXcTluRnphaCthbzFzbGhVcFBPTFNOd2lJ?=
 =?utf-8?B?Ni9TMEYwdGlGT2Q2WDVhc2Rsd0VkYWNHUHcwRXRkWFVuQ3hWQ1pVaEdGWjYr?=
 =?utf-8?B?NnFKWEgrRkVzZWhRR08ra0RUYkFZaEtGRUFKZ1E0VzRwc3lwS2JFOXhtVENB?=
 =?utf-8?B?VjE1VGhrc2ZFR3k4NDg5VzZxelF6L1B4eXRKb1RidkJIcEhHZm1lemRvZzJ3?=
 =?utf-8?B?Z1o2bUFqSUR1cmlRWVZFdmV1RFVtbXlUVUM4Tm1ueWVyQzVvRzlJdG1MSHdH?=
 =?utf-8?B?T1NxempwcHFxVERkTkxETFhSVGFyVkFDZFZUdWpUbUdTN2k1QndKZ3JYQ2ZC?=
 =?utf-8?B?YWtEdUM4ejNZTUEzNFZnZVNoMWpPdFZqNVp6Z1RaNDlaL2xsUWsvTkhCNWpr?=
 =?utf-8?B?VEVGZWplVkM4Qk5oZWdMdGRkQUlhODN5c1RQSnRnTEZUNHozMGxoZ0hGTXVJ?=
 =?utf-8?B?bS9SUE9hZkwvZk9KSWRGelcydWZoVlFycklWSXlTbjNpSXdONUVmaXFEZ0tX?=
 =?utf-8?B?bGdjaCt2enlMNFYxQnY0UEY5MW05MWtHNVB6clNlNDBoVUxVbGJiUFdoMjVH?=
 =?utf-8?B?NlRHbS8vMjM4cm1uRklBajUzNXQwMUZPNWFsVGRoMDFKdWpYaGdlK1RqZW1L?=
 =?utf-8?B?R3E0b1gyTnVWdXpqOXlrejJjRFVuVGs4YnFiMFNoeHV4TEVydS9kNmlqTFI3?=
 =?utf-8?B?TXNSakFzN1JXRkQzUnM0VlEzTzVuTXUrdysyNHRWSTAyc3pUaVhkb1FOVmlX?=
 =?utf-8?B?bHdZb0kxdDJJMSsxR081bG9YaURnN1pUN2dESDdYakErQ1FlOXBMbnVGR1I2?=
 =?utf-8?B?TGVjL2N6ZEtyNFJiZ3Z0cmgyeWUrVlluRlVpY3BpYXQ3QXZ4dHBYU1RWOGZ2?=
 =?utf-8?B?S1oyVnRaaTN0VmViWHJzRm82WUhpSWowbW81bk0xcUN5SmFQRmhpN2MzZzE4?=
 =?utf-8?B?T3RKS0JFamFhQWFodzcxNDFLTjdNazZmenpXNi9MRld3WDMxaVpaVFZqZVBX?=
 =?utf-8?B?eWIzZnJsZnB4a1NyUnF0cHo3T0dwanhaRklWVWgvUHdhY2dUN0J1OTJUN2lj?=
 =?utf-8?B?c0hyWFRWZ0tNby9sN3BPdFQzQTluWHRucm5VT0tjbXE0ZnVyby8xVkkzR2Fs?=
 =?utf-8?B?d2RHa04zcENlSHFQNmQ1RDdHdDJWZEFGWStKemVuYTY5b2FaWXUza05vc29S?=
 =?utf-8?B?MGQ1ZjJUVUFQeGtnbnhYUnZZcjN5T2lLaFRxRGNTaTBqdEVDcXZWeGxhSnNj?=
 =?utf-8?B?ZmJVODlBRjFsOHY0enp4c1phV0ZqOFBleTVuQTBMRytIeDV2NHBSL2VCMnR5?=
 =?utf-8?B?V0NnWS9XREdGZ3ZOZEUyVzBTS0Yya3VpMXg4b1F0MmxTWDl4Z01VRDc2Mm1L?=
 =?utf-8?B?VldxZGdyc1lNYzRCUVNKUTVnNFFEZ0oxemVBZmVKZ0FCZk01Y3p1cXNtZmhY?=
 =?utf-8?B?OXI3bHBVbURCcnhsaktkNHVPbHdibzRaa1VMVG9Wa3RUMzEwWFh5YTFMTnFq?=
 =?utf-8?Q?GvKRjg3v2s0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUg2WFNaSnVtMHZpM0tic1VGeUZXSXVNZngwKzNLdDNmaU9lL01RZkpoc1d2?=
 =?utf-8?B?WnNrdGJpWkpCNUFpMWhYdUhTdXBNbnJiVjZ5US9sMWorS3Jlbm0vaWdoRUNS?=
 =?utf-8?B?ZExWRnJhWUtVOFpxTkgxM2toRjU4cFR4aHovalZTU29iV09uRUxIUEx4NHhy?=
 =?utf-8?B?ZVcwaGVvTzU1eld1VE92VEFyZi9NMlhWYTBoUUtUekZPQkhJU1ljSlArd1Ix?=
 =?utf-8?B?TFpoQS9zMVlIQU9DZFVFV0pDUE1zTzd4YTFjUFdnamhOblB1WEE4NHdNa05R?=
 =?utf-8?B?K09PUDZKbmFuZkNWcEdoazV1Z2V4QTU2OTJMMENEeWVZQjA0bEdMRGY3V1dP?=
 =?utf-8?B?T3dkY1BPa2lTZWxaa0d4WmxPQmxKS3d4Vml3YkZvUmNPZnBuR1RRS3lQMkdn?=
 =?utf-8?B?ZTltUWZRRmxxM09LWGN1eXZwSEMrWkFtU0R0SmFPQVIxY0xmZ3J6MTFUNlAr?=
 =?utf-8?B?MHdXVHNhQjZZcWVDeUorVVRqUHVFN2xKNVovVzl1eUFVbHNBVk0xV0pEVTlT?=
 =?utf-8?B?S2xOdlZ3WWxCdnlGME1TZ05xaHVLczRyRFdzQUJCSmZZdmVycTkrK1phaXFH?=
 =?utf-8?B?QWVpM3lpVzl6UkU4QWx2MHM1a3d0M0ZROC9RSFBzOXhvcFFoUnVzNnRtZEcx?=
 =?utf-8?B?bGRld2JNeVB0TTRCeUJQdnFhZGFQOW9RWk9abVplcG15VDJZNVJWdEN6UFBB?=
 =?utf-8?B?THBmU2lGU3pGbDJUam4xUWpMTmFGdmYzZUpTVGtZSUJmTWh2WHZ6eExZb25p?=
 =?utf-8?B?cEJrUENiWk5YcVg4emRSMUFqRTNPU0N1NDJrbURyQ1oyRTAyMnRGamtjc0hp?=
 =?utf-8?B?UWJHU255ZTVRc1c2Z3hRTGZWSXYrSXdaSVhOSWJzT1VXOTBGMUR0NHNRMTFq?=
 =?utf-8?B?UlJadU8wUis1S1ZRdlA2bHlNT1pwSXBaSkdxWHJ3QVNMelVmOWM1RUV0aldY?=
 =?utf-8?B?V2Rad0M3a0QxVmdvbW5xcVM4QzE4NmhaN0JLbEVkblpNT2JmYnloZlNjQ3B3?=
 =?utf-8?B?T3dkaFh4OFpndEh0cGNaV3MyS0RMbDBFbVRjZGpkYitqOVB3MFFaUWdkVnda?=
 =?utf-8?B?NS82UjFROTFXS2YxWGJ2WUZheEdvWTVWMHNtNUtOS1kzMGZJdGVtbFFlY2FW?=
 =?utf-8?B?ai9JMFZEZHhhMXNvOXNGeTRFOG9ROWFlMW1UM29uZUlLV0lNdUovMFBvMU9a?=
 =?utf-8?B?alNrdzc3eUowNVZQNXNyd1F1SGF0aEJOcTZPVnZaWGt3MEMzSnRZK2xldzd2?=
 =?utf-8?B?ZWgzSzRXR2ptNkF0QWJvemZ6SnhKa09MSGx5OWpmNnNIL0JySmhzVk1CWjNR?=
 =?utf-8?B?clQwM2VDVG9PVjcwRjB5LzBrYzFkclpIWVA2OUJJbWFNTEFyK1pYOXlnS1k0?=
 =?utf-8?B?SWRIeS9XVjhYWEQvLzVUR0VPZzdVby9Wdm9vR2QwVnZjV2NLUHZWbzRxM2hs?=
 =?utf-8?B?dFBsenJmKzA4a2k2ZWtqSmcrY2xqOXEyTmxlbUFHUFY1cXU1MEpaMFpvYmpq?=
 =?utf-8?B?WTNPamh5eUZuV1JLNWJvL2VtZ2NvZHVrVEJMK3owbDF2WE1sYlJPS1Z2V3Q0?=
 =?utf-8?B?NnJXOWF3VlA2aFBmTzNDMDVyTXU4UW44akIxUGNBejdYaFZMWjcxQUIxeUht?=
 =?utf-8?B?MUtLcVFGKzZONTRJZ1M1VXFic20wb3NTdmI2Um1SVjFuQUFaUXJzR1BrMlhE?=
 =?utf-8?B?cEFweXhrTTJaa1JQdTlLSGRjSUV4T3QyZ0JnUXpvMzRqL2oyb1hueFhDSm9k?=
 =?utf-8?B?emxITWoyRTQ3dzJsZmtuOEFnTzQ3K2RVVnU5RGh3VXB2UWxmdVdpVDFoeVU0?=
 =?utf-8?B?MW01TDRuWkYzSFpNKzg4ZUp4U3hEQkU5SDFGdjhSME9nM1lQRTN4eGFxOHdM?=
 =?utf-8?B?SkFOcXNrSCtMTDErd0wvY3JDNVRRYnhBL0hxNDROMlU0VDIyWDlibjZwYzNH?=
 =?utf-8?B?TWlPS0dZREx2bzVpbFhkOXlkTWsyYVhLdWlrSVRGZVlRZUJHN0M1dWt0VXFT?=
 =?utf-8?B?WGF0UkdjcWgzekFyck5LU2NTUUk4aWVDZ2pGbDdDNkp3Tkp1aktKWjFsOTBT?=
 =?utf-8?B?eE1xM2hXcHBNMVRUam5xOTBWYVZBcFc5Mm9nb2I3VnpBY1hia3pJcWVMWUVM?=
 =?utf-8?B?Ujdtd04xSnMzMWl0UnhpazV1U0RBVFFwaEEzMlhjbTArN05VM1JSdmFZcmNH?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853297aa-6de6-456f-8adf-08dd8e2f12b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:51:38.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPoQYpjlTg38e/dT+hakf8zbF5MnEc50J/e+kj2mdhSVJl0OpRBDCX0Uzvxp6tEXi59+AVxY56TuC2jZfzXTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 12:51:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18782

On 06.05.25 14:07, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds an helper script
> `/usr/lib/factory-reset/set-factory-reset-marker` which writes the marker file to
> the correct location.
> 

Missing description how to use this. This way, it's just some piece of
script, lying around in a folder that is on no one's radar.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../factory-reset-helper_0.1.bb               | 34 +++++++++++++++++++
>  .../files/set-factory-reset-marker.sh.tmpl    | 28 +++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
> 
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
> new file mode 100644
> index 0000000..72cf5fd
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +DPKG_ARCH = "all"
> +DESCRIPTION = "helper script to execute a factory reset with a file"

...to request the reset via a marker file. It's not executing anything.

> +
> +# if this file exists execute a factory reset for the given
> +# list of factory-reset targets.
> +INITRAMFS_FACTORY_RESET_MARKER ?= ".factory-reset"
> +# use labels as crypt setup replaces the label links if
> +# an partition is encrypted
> +INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-partlabel/var"

This is duplicating configuration of initramfs-factory-reset-hook. You
should make clear that the expectation is that these variable are tuned
at global conf level, not in the recipes.

That leads the point that we are missing some overview document that
describes the adaptation and usage of this new feature.

Jan

> +
> +SRC_URI = "file://set-factory-reset-marker.sh.tmpl"
> +
> +TEMPLATE_FILES += "set-factory-reset-marker.sh.tmpl"
> +TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_MARKER \
> +                   INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE"
> +DEBIAN_DEPENDS .= ", coreutils, util-linux"
> +
> +do_install[cleandirs] += "${D}/usr/lib/factory-reset/"
> +do_install:prepend() {
> +    install -m 0755 "${WORKDIR}/set-factory-reset-marker.sh" \
> +        "${D}/usr/lib/factory-reset/"
> +}
> +
> diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
> new file mode 100644
> index 0000000..eacb8fb
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +
> +marker="$(basename "${INITRAMFS_FACTORY_RESET_MARKER}")"
> +marker_storage_device="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +
> +marker_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
> +tmp_mnt=$(mktemp -d)
> +if [ -z "$marker_mnt" ]; then
> +  mount "${marker_storage_device}" "$tmp_mnt"
> +  marker_mnt="${tmp_mnt}"
> +fi
> +touch "${marker_mnt}/${marker}"
> +
> +if mountpoint -q "$tmp_mnt"; then
> +   umount "$tmp_mnt"
> +fi
> +rmdir "$tmp_mnt"
> +


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

