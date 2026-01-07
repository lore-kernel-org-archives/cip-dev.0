Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28FCD0D14B
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 17:39:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11875.1767807551339274344
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 09:39:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OVec5jks;
 spf=pass (domain: siemens.com, ip: 52.101.70.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro7z9pwz/OH3voUp5p77ev21c/YF1P7MIagJ3vf1+oBmO1inpiJRPjXfWbIUhasnL12jAb5x8zRNT5OkSwqOswX8unEXDwBSFAZpfLjg2WFq5hcqTPZyNAwV7lXGNAQmyDZxN/PyvdBEW0KfnZgwzp30xMZPxepc1Ux0LtmqGeB0sqhTfi3JIOF8twOvFqNq73qE19K8jSWhVz3IhPGhegKubI2cgDrVA8mIBNVxC0CXPF+nDGLRfnWwMCyTnnilqD7KWr9qzgU+I9zlu17ckAlqrSlRSn0jkcRFHzrz5o96AEAYlCLvULs3sQWyDaDKkCRfPUvWgYpJyt81WBNW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXn44KtCPVq4ZLrSCiXJvOgiXQmzMxa3Qsk0+lCWZho=;
 b=gvdMYkLTQbLddhAjpuOlC4f/fvHE1xmYWuH2RLvX2db8sIzmvAdiwN84+ABPpcIpNC4WWTPFtW/QxQQ2JtCpD2hZJrAnQgHsOv07PyU8mVML1+iJF1Dh7UYHlJSKQPcezTyV/xPIYpDqJ1YNs59Q3y+rY/F/C9Dj8ASuUdh4b5d9C4VLvQAkFr3kR4GnDHQC4kYwvf/pB4/JQRePtl2dl5zREiutkp1ayFt1YVkea1QLQLmeJRqFL/gSs46hRJf2VpvVfG7SkQtcXzFH8E1KYfdJbH+d4RQhWCKmRudXikolRIW4n7PB7cPWC2uCjaXMrJum+Df/JzgjzFa+aljqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXn44KtCPVq4ZLrSCiXJvOgiXQmzMxa3Qsk0+lCWZho=;
 b=OVec5jksufDiZhI6/6LDUwrVLaywuVLJeJPqDNxE7gn6K3RLdpFZTWJ/zyiMlkj9MlTCUBGyJM4GPb3RVcoof9dSt/24R4igpHigVcjiYCNKGMKJZa9+aXS4mws8DRkdNSuhfRthZ2peMfkiAssVTQc/2ytNH1vOh3HvLjlV8rTPk4rLA9wN38x4Pub9wq4zS40QZawep0cxS5Sf2Qe8HwiYUppfyGd5EbZhokJS0hiBEpEL7saM7XFfv3LwTcN4rNUbLrXw+NP3Es+ApXPTsswFArJ1LdIsJex/jXLiSLJKTghxJTU7ZOyOH5B6Yti1BuwgbwQMmtQK41Rwa+w1PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:39:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:39:06 +0000
Message-ID: <4c10d426-af80-4a91-b6a0-c41442da459f@siemens.com>
Date: Wed, 7 Jan 2026 18:39:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 7/7] rename
 recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
 <20260107132707.733180-8-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260107132707.733180-8-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b4fcc6-7a3b-46a2-1ebc-08de4e13a7f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T2o2b1M4NmZwUEpiTklLR0M1aWpkbzdiT0tQcHVzSW5yVnI1eXYxaGVkcmxl?=
 =?utf-8?B?RDFVMGNEaWowcHhXdmEvajFQTGJvNzR3ZTJRdU5VNFRLR01ubnlCUkFEVlIy?=
 =?utf-8?B?OStSZU90MnpOMzlJcVJIMXg4WkMyUXJ3V0x1RC9ra3NyM25FTGZQR2hDZVBw?=
 =?utf-8?B?Tmh1bjlSU3RiVVMyYkErVFYzanNXdEFDRmFCbEcrbEdJSmZxM0hrTkJxeTVQ?=
 =?utf-8?B?dDZ6K29TeVZxMDRZWkNreDNmOFVBQmdCcVJTRlppN2kzcXBHd0pCaGdHSlJI?=
 =?utf-8?B?bHpkWW0xeVhjaXNKbTZvMEFWVXR1aFB6akdoWkxMMFBkeHJDRERKOEZTQlg2?=
 =?utf-8?B?RmlJdmRIdWZPKzIzUEFBOHJBMXNTNFFsQnROaWhBeXE0ZWNOMU5ybjJFMDVw?=
 =?utf-8?B?aFBlYlZUKzdieW5ydUJQODBsZWNVWVVaQnpNZXpZZmYwSzdlT1dWR2s4VXdR?=
 =?utf-8?B?aVM0VFR3dXhkWFpGKzBod1dXdlR3QmJKb3RpNDA2eXlEZ281VVE1dEZtbVgz?=
 =?utf-8?B?WG10WWpiSWVpbHRWajBaWkdiTHo1TEZXVVYzb0lpR0NTVHlwTWNPZ0R5b1Iz?=
 =?utf-8?B?NU92S2lnQTJGbzlsQ0hJbHMrcTZ4d2JTVCtFQ1hhSjBJSUZoVjk0U3pOa0ZM?=
 =?utf-8?B?cC9qVDJPcEdMb3VlNGtvWjZXWHgyMFUzMkZablZYNE5CVE9ENEJuWjhKdllS?=
 =?utf-8?B?RmNUWkIzTjdkS0QrNXFncVJ0NXViMHAwU2hhQU5BVG4rQVgyQlhCM2dyYW9j?=
 =?utf-8?B?b3U4aGlvRWVaTTVGWVNZUG5Mbm5NV3pkUHhSSXIvWWFzdnlRNHdwYzJPck9F?=
 =?utf-8?B?alZETXhGZlRmZjBSL1F5MFB5cVNkNXFoaFVNSTFrMU9aRjFIN3FETWZZU3Bs?=
 =?utf-8?B?NWg0VGloZDBZVEZyRnY1TmMyVUc2Z3lqcEhkWSszcTUyOXBjbjdwcnM1dnBP?=
 =?utf-8?B?c2oxS0xZVzNXL3E4QTFTbWpSOGsrSGhycWNiaDRXS2ZaZFVCNktiZzRyZmdo?=
 =?utf-8?B?MERhSVdlaC8yNE15QlVZUHcya1YyZ1Q4NTNxUG93ZGN5UVFpajdpTGZJZS9v?=
 =?utf-8?B?WnAxNmN1c1FPNjN3UEhvUDhwaUI1c2VWblE1eTZieU85d2RuSnJmbmp1T1px?=
 =?utf-8?B?RXFmbVRXZmdBcldCbHEvczNJUC9lZ011STFkUGtrcWdsMTdDRkxNcHpMNjNT?=
 =?utf-8?B?MXVWR3dvcXVzTVVIRUpvYUJRTUxBbHdqd21DV2tFQ3VCWndCM2NITkpwYUJr?=
 =?utf-8?B?bytLRmtDQzduNzREMHc3S2FKZThqaTZ4R0g5SWpRVGdTQXVYVG9WMk9QZDh5?=
 =?utf-8?B?MFBER1dNbFZoRkhvL2ZMN1RHQ2E0bmU4c2xOSGRBcXJSaTZBcmJjTEZ6TGdm?=
 =?utf-8?B?eU9mTmRJbTBrVzNWbDhFQmdnQ2V6OHdiZnpxWllIMm1Wblh0cFBmcGpWalpj?=
 =?utf-8?B?dG1xWEhGMDhwdm9ENUV0aXJwbEt2Z1EzbDlrQlZBQk14aWgrZXBFVWJBL3dI?=
 =?utf-8?B?RU00NmNQWnAxenVYWDhnYkJqWUZiVm5SR0hSL3JudzRNbS9uYTVGdFBHMlZn?=
 =?utf-8?B?ZXVYRUtNOVNyRy9uKzJPQkxJQzl6Y25VM25HMTFGcURvc1owOEhqQlQ0YTBN?=
 =?utf-8?B?ekhWai9WUHByeERwYkRYV0pFV2tQNUpES0ZraWhpR0tkYkZoV2FlSFY2V3h2?=
 =?utf-8?B?b01qa2hkNFdmaDdJSHRwN2Yyd0p3ZTA1ZzRzdWpRaEQ2aytjOUppZnBSK0J6?=
 =?utf-8?B?T2F6Z2g4WUU5Mzlnb3hYd0Y2UHF0a0F6VWEyNWhCR1RFTkxpZEd6OFlIYkEx?=
 =?utf-8?B?ZUM3WmYweWxnUjQxQjR2bTdMMzdkVlJvYVVWdkVNb1hYK0hrNHFkTTZSMnBy?=
 =?utf-8?B?NlNid2JqTVlKeFpraDkzYmxLbUUrL2VuaXg3VDUybldidlhpZ29KamloeTMy?=
 =?utf-8?Q?/nhIH/5cRBTmEVLyfMz9Aqw0rs+Q1EuI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE5XTHpVcG9aeFhaUC9EYjVHcHF4NWIzSDVRQzNDWkgzVHlta2kvTTFINTVC?=
 =?utf-8?B?R3hUODY0VEE4TW9kUTRCcGFhb1VWdFMxa2F4VjI2azNTOEF1YWhJQ0dLQklK?=
 =?utf-8?B?WGZKOVJuMzdYdUxJaURDLzIxRnhBTW5rcGp6aEMwMlRLNjMyR3A0VlpoRjMr?=
 =?utf-8?B?ZkkyM2QwZVdFRHNRbEJLS1ViOStrUXhoblo2Y3RBbEYxRVdabmwwczE1czBq?=
 =?utf-8?B?V2RiVEVrZExZSEdaWHl4Vk9YK2hqR1YydTlORlFJYXFlWmlidmRUaklHYlox?=
 =?utf-8?B?UEV0Nm1sRktQVVB6YnJxZ0Z6Q0QyemVzZVYrdml1V05QUkFlbk01dnoxcDlz?=
 =?utf-8?B?WGxsV3FCVzN4N1ROTERkOWtKVnVieDFRd1IwRG4xNSt0MnZkWkdiZ25hRWpj?=
 =?utf-8?B?b3VjT3dxZnRjem1HMk91UTBhTVVQMW40T013TFZxY2kzR2gwVjdncHJURnN5?=
 =?utf-8?B?QjdrdWxNYXQxQytneG1keVBJSlg4dVdaVmZOZHVreGd5UGNFaWV6V2hzV3E4?=
 =?utf-8?B?ZEk4RjlNaW8wTTg0VjN3NzV1VDJycERhaWkxNC9YUWFjcHhiSUs2VFluQ1FG?=
 =?utf-8?B?VTg1TWJJekZDdzJXUEFLb05iNU1RQWcrNmkvMjNobmQyNmJYeFJWNHh5NGZP?=
 =?utf-8?B?c2hDMXZGTno0ZWd2SnphQU5aR1lkajVEZEYrTFZNV09RWHFGUTBpWlhFZ3Uw?=
 =?utf-8?B?Z1RqYVJIYTFTRVMvMi9qaFdFd1E0eDd3a2JqL0VhZGJoWDBWOWRMVTcyVmJz?=
 =?utf-8?B?YVZwSDU5L3hwaHpoN3BQQXNGQjVRbmZEcTJKcGdWVE1JcTVuMDNZQjdJT1or?=
 =?utf-8?B?Y3JYcGRPUEdJVTViZUNqM01FZHNYSzRzZTB2TzgrdHV4RXYwVlQxcG1hcUZv?=
 =?utf-8?B?ZnZqT2dNOVlKc2NlL1lvcWR1R09XQ3ZWSXdnMk9uU25QTlo2aVA5Qk1JWU5K?=
 =?utf-8?B?THJaL1N0Q3hZNklvMHpGblNTY2tscDBiRUEyaGxrWWtyZHB1M3d1RnY1TWNO?=
 =?utf-8?B?RkZ5WDNkYVNjOW5JZ0RrOE84WkxOZm5CeVZtZHJPOUEyRXo3RWxKK3JLcEJl?=
 =?utf-8?B?d0M2SmcxbUV5VkFlQVc1S3ZqK3VpTG16UStvWFNWbmg2Sk9STWVZQVYvOXd1?=
 =?utf-8?B?MzFpdTNrSXBQeFlkS2lReXFzZEUzdWNWdVlrU0R4a1E0SmVPUVJmbnQ1Vkxm?=
 =?utf-8?B?ZDh4OGsxZXRjTDJCNS92c2M2NHdWQlVVb2lBZ0ZZQU9FWlplM0NpNm5hdkRh?=
 =?utf-8?B?YTl5UVdXeGVvREpsQisweVpXU2RWWnhqVEg4SFFCR1FwSk1OS0NzeENKR3ph?=
 =?utf-8?B?ZXFGZG9RczFScEFxM0RoM3NrQUVpMnRSYWdPaFNJMkcvby9KK3plcTZMdzV6?=
 =?utf-8?B?L2VhemlrdWg1TE8wQyt0NmN0clFXL3FaVGxqZnhXdEZCWFB5NWxQTDIwb2E0?=
 =?utf-8?B?RTJ3MHQxMEJCK0tmN1hJbkV1eEFaVjFNUGdIRXo1RWFqdFdoQ0JJUm1WaE9j?=
 =?utf-8?B?QnVZYlplRW9GbEZ5WTduWUlZaHljcHZWWmFwcWZqejArN0krOTlPeGlzQXlV?=
 =?utf-8?B?SmZqK2UxNGNkODVWbHd3ZDZlWDE5c1FWUkk2QU5oeHh6UnVRekJLY0J3c2U3?=
 =?utf-8?B?VDlkam55alowR2pnR1BIVFI2S1NBbHV6akREdnJLRjM2UFBTemtWR2dvOGFo?=
 =?utf-8?B?N3BFMW11Uy9zdjd4U0gzdUoxRUpmOUVJNDlNMmlvYjMrMTRjM2pBcnBaL3F3?=
 =?utf-8?B?NlBOUHNNMWhTT2gxcHhPZU9EV1VkeFBYWGVaOG9aRFpsbGtOZGQvWngyMXBx?=
 =?utf-8?B?MzBJQ1NJWE9PM2tGdzRwWDZvVkwwV2RraUJOQmpPV1lnaEE3WGlmVEZBcDAy?=
 =?utf-8?B?NG1jK2VST1BmNkdkZW9PdnBSUnNvSGtjN2ZqSERnOXJTYU1MREphNzhHRkF2?=
 =?utf-8?B?OEJicFE0UnV2RkFkZW4xZU5jUGErQVgzUmx0TVZRZHZUN21WY3hyQ2M3SVNM?=
 =?utf-8?B?UTI2QUdJTlJJMnA1YmdHa0hDalc4M3RTYXhrU2ZSQkZ1dkozNUxnUU1tZW5N?=
 =?utf-8?B?QWNqRy9POVg5OTc2MlZBay9oV0owWUtWcjhRV2JiajFpenhyRXdSLzE0dTYx?=
 =?utf-8?B?MEtZUVM4clpMWVZ1MGN0RVhZc1ZoWHpxNTM3YXQrSjd6cWo3UExsU1B3UitZ?=
 =?utf-8?B?Wm1XNTJydmhVVU92dDdGUVVFRFcyWjU0VUpITm9rNmRCQkhIL0FyRVJubVRx?=
 =?utf-8?B?TEE3K1MxeVNHYmxCSjlZeEl3aFVXZ3lwbE1BTnRiUDIzYXlGTk9FZ1BkWFJy?=
 =?utf-8?B?dDRMUTFkYjIzVFgyOXo3R2d1TzYzZ2pHMlNsaGpvNVBxeXlyK2pTbWpkcEZ5?=
 =?utf-8?Q?27QDQ35uSGfaksK4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b4fcc6-7a3b-46a2-1ebc-08de4e13a7f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:39:06.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p8uCZhEvvqxgxfhDBtU8gp1LSRlclcIF29VusX/TjjG1grzriCYkUm7ISOCq7L1cagZ7rJqE+rnxS8H0cB9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5230
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 17:39:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21418

On 07.01.26 14:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This clarifies the intended use.
> 

Ok, here we actually move to a class. The previous commit moving code
into the include should at least indicate the reason for the
intermediate steps.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
>  classes-recipe/swupdate-ab-rootfs.bbclass | 52 +++++++++++++++++++

Who is consuming this new class now? I'm not seeing the "inherit" right now.

>  doc/README.usage.md                       |  2 +-
>  kas/opt/swupdate.yml                      |  2 +-
>  recipes-core/images/swupdate.inc          | 62 +----------------------
>  4 files changed, 55 insertions(+), 63 deletions(-)
>  create mode 100644 classes-recipe/swupdate-ab-rootfs.bbclass
>  mode change 100644 => 120000 recipes-core/images/swupdate.inc
> 
> diff --git a/classes-recipe/swupdate-ab-rootfs.bbclass b/classes-recipe/swupdate-ab-rootfs.bbclass
> new file mode 100644
> index 0000000..696ee7d
> --- /dev/null
> +++ b/classes-recipe/swupdate-ab-rootfs.bbclass
> @@ -0,0 +1,52 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023-2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit image_uuid
> +inherit read-only-rootfs
> +
> +RO_ROOTFS_TYPE ??= "squashfs"
> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> +IMAGE_FSTYPES:append = " swu"
> +# input is already compressed
> +SWU_COMPRESSION_TYPE = ""
> +
> +# read-only rootfs with /home and /var
> +# as separate partitions is used
> +# /boot is excluded as an unified kernel image
> +# is used. This images are stored in separate partitions.
> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> +
> +SWU_SIGNED ?= "1"
> +SWU_HW_COMPAT ?= "cip-core-1.0"
> +IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +
> +SWUPDATE_SELFBUILT ?= "0"
> +SWUPDATE_SELFBUILT:buster = "1"
> +SWUPDATE_SELFBUILT:bullseye = "1"
> +SWUPDATE_SELFBUILT:bookworm = "1"
> +
> +python() {
> +    base_distro = d.getVar('BASE_DISTRO_CODENAME')
> +    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
> +        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
> +
> +    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
> +       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
> +        bb.fatal('SWUpdate from Debian requires signed SWUs')
> +}
> +
> +IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
> +IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
> +
> +IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/doc/README.usage.md b/doc/README.usage.md
> index 1e1973c..5ba6259 100644
> --- a/doc/README.usage.md
> +++ b/doc/README.usage.md
> @@ -19,7 +19,7 @@ with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
>  An additional image type is generated with contains the update artifacts.
>  
>  ```bitbake
> -require recipes-core/images/swupdate.inc
> +require recipes-core/images/swupdate-ab-rootfs.inc
>  ```
>  
>  ## Create a image description
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 4a128f1..c120c0e 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -16,7 +16,7 @@ header:
>  
>  local_conf_header:
>    image-option-swupdate: |
> -    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate.inc"
> +    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate-ab-rootfs.inc"
>      OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> deleted file mode 100644
> index 6fcf06e..0000000
> --- a/recipes-core/images/swupdate.inc
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2023-2025
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit image_uuid
> -inherit read-only-rootfs
> -
> -SWUPDATE_BOOTLOADER ??= "efibootguard"
> -python __anonymous() {
> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
> -    if not bootloader in ["efibootguard"]:
> -        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
> -}
> -
> -include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
> -
> -IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> -IMAGE_FSTYPES:append = " swu"
> -# input is already compressed
> -SWU_COMPRESSION_TYPE = ""
> -
> -# read-only rootfs with /home and /var
> -# as separate partitions is used
> -# /boot is excluded as an unified kernel image
> -# is used. This images are stored in separate partitions.
> -RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> -
> -SWU_SIGNED ?= "1"
> -SWU_HW_COMPAT ?= "cip-core-1.0"
> -IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -
> -SWUPDATE_SELFBUILT ?= "0"
> -SWUPDATE_SELFBUILT:buster = "1"
> -SWUPDATE_SELFBUILT:bullseye = "1"
> -SWUPDATE_SELFBUILT:bookworm = "1"
> -
> -python() {
> -    base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> -       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
> -        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
> -
> -    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
> -       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
> -        bb.fatal('SWUpdate from Debian requires signed SWUs')
> -}
> -
> -IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
> -IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
> -
> -IMAGE_INSTALL += " swupdate-handler-roundrobin"
> -IMAGE_INSTALL += " swupdate-config"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> new file mode 120000
> index 0000000..f02080c
> --- /dev/null
> +++ b/recipes-core/images/swupdate.inc
> @@ -0,0 +1 @@
> +swupdate-ab-rootfs.inc
> \ No newline at end of file

No compat logic to detect the old inclusion?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

