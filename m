Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17851C3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 08:55:58 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.67])
 by mx.groups.io with SMTP id smtpd.web11.20113.1719910553387992847
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 01:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hhgmbbub;
 spf=pass (domain: siemens.com, ip: 40.107.249.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ4WAZOvw3QMFXv5F+oMncbE1R6LBCB0FgIhQgbwnMl2ZK4quu9ae4X4+WoP5EFIXLFdDgW26DjfO+/9ywdAnYDO2seaoNIZEhkaRylXRLVyPIRtIlh29ruS7VU5Vg1fdi62CH+CN6ZR6iZDL8CZxvlOKp+R925CfFW8QE32DS3nBlDT8e3kW1I/1N02Ps+UA8gR+mVYni0I8VXJZSzYApN9PVPsA5NL0R0XgGg+gKj/U2sLno9yphIE2K1VoPGYLMTRzJwoR9XXFw3j+y/Hsg3K3FyH7+3d6rhCI7G91/STJSkkUdQuglnhE1i5ZScbW4bEDWP78wf74fSTXXBnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sib+kiKbny8T/ZcQ1MZjpsZBrH8dLC/kOHFDr3FIhrY=;
 b=nRStj7jOuNFC2lpkEm6dHH63IDWM8HRAytD4EcxwMEDiaEMq2TlN3JNHYuOrIm84T94pVCy+iHfM8vSmU6rkWVFait6vBc0o7qhy6kN23oUkOCPGJ+PZ26Jzma3SrbRxzHygRr12Rn0QLpugL0mrR5xYO/Havo3SyNmZS/2s1cEVaxcTFa/H+vfJVOs+KZ70w2k3+NHevBb3pQOb2bNNqO/Kae5QoKxJPdp+D8oy0CMlaWZ+o+nkxSLhRmtpewKWSKWmdjpSRfJSlPwRbyZ0WUDYGjC3Ay0S99xAabaenWPMXy9bAOj8z2tHqcqO0FgStqLmMr1Xz0fM59CYys4G4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sib+kiKbny8T/ZcQ1MZjpsZBrH8dLC/kOHFDr3FIhrY=;
 b=hhgmbbub/y+kCKwpQmvmXfvbRnZpF1UBu/Cdln5vDRdE3Od21JlAEWdWPcPG3zshiMR4FhVirTSmSvWm/h8K9lRAlSk9w3UiPgyb0FWgwG9BhMeb2N1D3XGfHkc2E2Fibr50EUc2T2JcpZLiSQPomx6t3f0AbEkb+bR3LQlqcCuYQeL1ntlbqaazdatHdgyV1M4bjUoZYwfeHpgXhvb2zrgJvg5isXQKltV77d1+0ws4FjeYwpPRb68rF7Ee3dw7K5RdEtHDuLsPY5ginMXi1URU/bJVBpQiGqspBrj4ahAN8wGMXoeMJh0WPRz4WOrkuDtbLozILKlO14BVO3Oa+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:55:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 08:55:50 +0000
Message-ID: <1e019226-04bd-43ca-9827-4521396e5e40@siemens.com>
Date: Tue, 2 Jul 2024 10:55:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/1] wic: Set size for rootfs partition
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240702081708.3339644-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240702081708.3339644-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240702081708.3339644-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ae7bb1-2f15-4cbc-7fde-08dc9a74c5de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OHBkQWFKbFZPQnppTmxUcFE2TjZOV2puc2grZGppV2ZwZjArcDJHams1Y0ZP?=
 =?utf-8?B?aVNOQXVtL2hDZHU4dVFydHZiSHg0OXIvLzJYd3VEYVExQk1zVys4R2hLVHRZ?=
 =?utf-8?B?MTk3UkJDZHFIcEVVWGpRZDhKOW05ay92dHl2dWI2N3A0K3FGZkNvcElkcjNE?=
 =?utf-8?B?YXRoRjJBQWhvSC9oRUFUQWU2UnNXbVBKcjhaUUI5N1ZoZW5rVU15ZWlraVdi?=
 =?utf-8?B?eDN3ekZ4TnRhNVlnb2xZOVRxZ2pPUjhTWFZPakh0Vlo2SW4rS3RmbkwvWlRH?=
 =?utf-8?B?T1EwNHdXeG84bDh4dUZSZHJzRnIySURwMEE4azFkUFNucXF3MXlCNXlrYlBn?=
 =?utf-8?B?Y0kvL25IZTdoM0x3Ym5CdEt6V2x1WDMvWlpWNVNjcEtRc3VncGRjRUs1QlBj?=
 =?utf-8?B?U2VGS0NUaTk4ck01TFpWaVVLMjVqaWM1S2lvQVdWR1hWOCtUSHJacGpjaEky?=
 =?utf-8?B?NjdmSlJxVWs5TVlQWHpiaW10MDNYbXdiWkFxVGEzRTIyZUZMbkVRT3YzWGpp?=
 =?utf-8?B?b0hPdUZBUWwyTjBOcU9LL1VRQ1FrTTNIZ2gvb1RCZW5sSDRod1ZualFHdTk2?=
 =?utf-8?B?M3M4UzhIcTUzWitrbDhKM2FvMXN1cVpZLzU1eTZzMGk2RThlMG9HQ1dYanVN?=
 =?utf-8?B?V2p2NkdiWDBEcEt2aDRBSUthOFhRT3RMWGtyMDkxWDVlcUxzd0lsNXhROUxY?=
 =?utf-8?B?d2kxR3Q4RlhBVGZyMWNyWHpKMldVWUZ4dFNMdTZjL2lURUxsQ0htSWlGQzl1?=
 =?utf-8?B?bEdnRzB5amVjc09Pc2RvUHhYcU12Z09FaHpzZ2YrODRJekQ3QUlCODdUMU95?=
 =?utf-8?B?SkFTcnF2ckJKVXFSR1RRRGJOMlBiS1duQVdOSlRBeTZhWTNFaHAwOFF2MUU1?=
 =?utf-8?B?YkRLS1BlbitYSnFrVWczTG1rWnUvK2pvQ2twblovZk1TWnhoQlZzQkZtM1FB?=
 =?utf-8?B?aFVHNGd2YmlUd0VNZ0VhSHpkQ2lTcFhpeHIrTzlkb3F4bytVUzZ0dlI2bDF1?=
 =?utf-8?B?WHNKK1VUa3Yrd2I4bEdnWkEwemdMZS9hRG43YmZ3ZVA2VkZhNTdiZ0JLaVkr?=
 =?utf-8?B?akh1TGYxdWwzMk5DRVN4Y0Z0RXRMMEloK0RWUDVNaS9RY0J0amR5OTlRVXJ6?=
 =?utf-8?B?ZGFvVTZ6WDMrV2RnUjVhN2tPUGRPSDdSdW1nQ1JJdzBIaGw3NDZScGdYZjht?=
 =?utf-8?B?M250blpJekZiQ256WSsxVFBHYWQxL0hyOFZMRzlBV3VyQXgxQjg4eFFWUm92?=
 =?utf-8?B?enZuemdNOU1SUFJqSmNkUUlyNnY1aEUzRzJUbnRETUdYclp6Vlg3akNXODR0?=
 =?utf-8?B?K1hqTmI3TGdkcTNSYmNNd3dQZHpFVnYvV2lsOVBmcmRReld1MTF3WENsbjJI?=
 =?utf-8?B?NzNKcjNCKzlIZHVHdmo2L3BBUFI2QmNWU0RXUmtyNXpYSmwvZ2E3R0VVRTFG?=
 =?utf-8?B?TDZkZi9iTmg3ZTErV0VCOE1XVkN2Y3QxaUpIbUJiRExRTGUxYWI2M3hYSFY2?=
 =?utf-8?B?a3FWYXBGYlNMcnIySkFnT1p3YlE5dy9TSlJ1bno2NXRxMkRjajJFVXE1azF5?=
 =?utf-8?B?WGt4YnRRVkwzM1h6a05zU3hDcTBrZzdpVU1CbDkzWlZnMThMbmo0ZjUvbEpi?=
 =?utf-8?B?NVo4VUF5TnI3aXVsRkxmOTF2OHYwcVdUSExROWFMSWFCVnI4SCtDOGk1dzFu?=
 =?utf-8?B?N2dicDk5VWVSWm1TUkNwM0RlNkx2d0NzdTZNekJDdFNreEZ6RENPYUlSZzFK?=
 =?utf-8?B?cXp1cmtMSkkrczVCcGFsV3pWYlNzYUpPVE1reGUrTlJibHA4NGZnYytMZTF4?=
 =?utf-8?B?TUVtWEtIWkFRK3BvcUMvQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1MyQk52U01aMUMydzRUL3lsOHB5V3hrQ2FoQjJuc1pybFhoSXJDRnA3cHRh?=
 =?utf-8?B?T2JxdVA4a2I2WlBjUVJEUnFvWlNCdlNIL25YL0gwYzRubEJlRHNwd0tnbW5U?=
 =?utf-8?B?STNzbTNyM0hPcUFMekEza28xTmhFN01EWDNDZUpNcERtdkMrN1ZIVm1EbUhu?=
 =?utf-8?B?NkNuRGIwaFdEL0FxTjZwUW9YSjhKa0dXUjQvd1pXN2U1aDBYU2svamdKQ3pw?=
 =?utf-8?B?WkJVZVVQQnhPWUFNdVlWWk9kYVRUYTN5TVQxQWxleWpOTVRxOHpiVXZlcWJu?=
 =?utf-8?B?TGdLY1ZVMm1lYzczTElpQlAyTXpOMjZ3aFdZR01aSFJUMFVvQUJVQjljWXpF?=
 =?utf-8?B?djR4K2I1SFRNVmh6QStRWDhheE1TU2dDTGFlRyt2eTF3VFNoQ3ZudklMaXNz?=
 =?utf-8?B?WG1DNWY4bC82S21LTFBoSGphTnJrNEVFaHd0WFQ3MTBackg5NEdJRzFLLzl0?=
 =?utf-8?B?Y3NxMTZ4eXQ3SFhQaUdaNDBob3R6b0JtaGd5Ym5HcEcrQ2kxQVRzK1grdDcv?=
 =?utf-8?B?MkR6dVN3ci9ZdEYzRDJuZjJRNnZLZy9uT0R4MUtGTXQydmNCOEtzUXJ5QjJ4?=
 =?utf-8?B?SGFEekM1NXpWQlBJZkJxK1pqMmZaRnY1SHVGZHFEcVZhNFlCbnloaHI3YlBj?=
 =?utf-8?B?M3VTelI5My85OFB6V1JFYVo3RGZtVDdwdnFEMnM0UElQM3NFY1B3Sld1dEFJ?=
 =?utf-8?B?RnlyelNhOXhTVEJzdEFxRDEzOVZQU2lxSVpEaHFoZlRPNUVwYTBIcUZST3BS?=
 =?utf-8?B?MFpETVhLdHFTOC9Pc00ydnQwTSttRTJhSEVHK09XR0drVzd1clVQeGFES0ww?=
 =?utf-8?B?TnFGbkdGaVUvd0NHNldlLzQwMFRreDJWc1g1c1hlSHh4eTZ0bXRwME4ybSty?=
 =?utf-8?B?eTZPWk9HKy82Q3Z0eTM0KzRLZ0xLa3M3MXFWaVZjZFc3TndhN1I0MDZDeFBO?=
 =?utf-8?B?enhhVWdmWlBrL1l5U3p5Zm1DUnU0VG80dzVaVzBQSkJIa3d3ZElFWXZtMkNw?=
 =?utf-8?B?T28rL3RmVjBNRDF2cnpLMXhDbmxQelZTdmtjVmt3b1lUQVRDUk91UnA0ZVpS?=
 =?utf-8?B?b2IwR0xvcFpGRksrV0pWTHNPYm1IdnJ1RGR2TUZFRm5mdzUzZkNvTDhnRzk5?=
 =?utf-8?B?YXpHTndoUjNWYm9Jd3FKcGZuUnRpMUs4Z1VQTWk3cHI5dlhKeTEvaWk4dk56?=
 =?utf-8?B?TGJ2OHhpaDgzZE5LdklhRndESCtMM0ZJN2FpZ1hJeUIrMXIyTWZacFdzMWZh?=
 =?utf-8?B?RitlYjN1WjJ6K3RTR0xPUDdRalRvdGFmSlVXQ1o1SnYzLzNqYWVjZmpNUlh1?=
 =?utf-8?B?UWI2VzBNVElsVVNvVTZYclNMWWR5MzhQdDJVVHRmRUZ5TXZGanlXSHlxbGhE?=
 =?utf-8?B?eFk0Wmsxd3NYMTY1Y3RCbitVYlJ0NERTdkJLZ3VrK29YRE5RZFhxRWs1TzI5?=
 =?utf-8?B?K1NBVUE5bmhxTFRhUW5vSkc3aVRoL0tKdDM3QVdiVFFQSXZ4ckxlemtIY2JH?=
 =?utf-8?B?OHozWTFOL2oyTGwzL09nMlNhWFRCYU1uZk1aMDMraktSYUFWNnNrdiszUWFV?=
 =?utf-8?B?N1dqdnQxbWlHL3c3Qjg1K1FvdUUvenM2Tll2bVFOd2V6aU5oNXdxRytRNjRu?=
 =?utf-8?B?Q2IyOFRmSmFjWFFpMEVXKzh4dzZtZkUvdldWSytnTFRNTXBwVUNBbGlKdDA2?=
 =?utf-8?B?UFYrZWkyaFNpYXRkMnpNUXNlSTQ1bFEya2ZsUitmb2NFVFFibHBQNU5wU1hV?=
 =?utf-8?B?SU1Kak9jdzY3dmdWZXEwMjRmSThnbSsrTk1Yb2hHQXpqZG8wNWg4WHRjd1VE?=
 =?utf-8?B?eFozcm02K3pLenJtYzU3NmNDeldWRUxDQzZzY3IxYTVJMGdXNEhzMHh3OVI2?=
 =?utf-8?B?QVg4MHkwems4V0RWcFVyQmlteHFwTzZRN2Y0SG40b28vQ0F3NHJzbGhPRGJh?=
 =?utf-8?B?U0FLZlFEYjVHb0dRZGRyMTVLMi93RmNncVFSTTNpQkRoaDFiUDRCVjhBek5r?=
 =?utf-8?B?cGV1enZDMm1TaUdsYkZwb3VyUnpKUFdDUWVsSGJ6QmFrVnFkaWFzVmVsbkkr?=
 =?utf-8?B?R0w1Nmp6NlU3Q2MwVTJqcVZFak5PZXROdmZwMHdxREZUUVVIS1JsZm5JNk1z?=
 =?utf-8?B?S2xpelNBTDlBc0xOZ3hNei9GdFRqbzFjcG90enpwZ1FMTCtETTBUWmdjc1hy?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ae7bb1-2f15-4cbc-7fde-08dc9a74c5de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:55:50.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxJmA3OTqW7y7f+QL9SPG33p9C+evOAHz3jYmhChlQnOymHE8TtvuGm3BpgitT5cq993ldNKr+aHAkgEAiJeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 08:55:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16358

On 02.07.24 10:17, Adithya Balakumar wrote:
> In the case where no size parameter is set in the wks file, wic estimates
> the rootfs size from the rootfs directory in WORKDIR. Sometimes the
> ROOTFS_SIZE variable is not the same between builds, although the rootfs
> contents are identical. This can lead to different partition images
> (in terms of number of blocks in each partiton image) which makes the
> partition images non-reproducible.
> 
> Although this patch doesn't fix the core problem, setting a reasonable
> size to the rootfs partition would not cause any harm.
> 

I would like to understand the root cause first before taking such such
workaround measures.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


