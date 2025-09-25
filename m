Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6BCAC5A7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 11:21:58 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.13])
 by mx.groups.io with SMTP id smtpd.web11.9188.1758799315469083442
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 04:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pgtYDSNh;
 spf=pass (domain: siemens.com, ip: 40.107.162.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYIydsTWX42u/is8un2flCg8tXE/dfBW9/g+eVT7V49hNathK22Sv/lOoUavz7PpSTCprjufz7gno+/WW2qyY0dk6/+zWhw5LrgzLFPDsFFHddwn6sMsfMmx2qxwS5e8BPOhc7FTkEaD/2TKS8UqeYzRyRUJOvRXoxNMR3BEvl3CnkSF8fQSKdSA7/OzqXc2RRSp8i9XQYUY85oxpWnUpKwvG3cw5p7r1ejLaIs5nYgMZlO2mGhHpZoUUnPf5OjRxRuhYX7yipzw7Q78z6VYadsjshKOcShgV3cHzhk9TcPg/Ljt0/ovF6I96c724eOKSeCQwxxrrDqEk1/lkWnr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjdKuybFA+IQBDoL7wn9MBYEKxjJhwOpgCAvDWAsv0E=;
 b=QF4xlwI56Gtg12BytJF3qC+IyYLcfQrrMaUq3wBlQTWsBOSFDZngQM5BAn/KCbL6FG/+DlK+t/kGUa3WK3BFoAtPWFnD1T/+Hus8G688Ip95HX7z3/OR5qaaspp6Zaz0MRFR72cX9s6jwJBj4ZO4wQ/mvjX77Yt5PjbbK/vWbN86hOk+RFEOGOEDm0cE/NGX05F3arotQcrPi7fpG8w/7VOjynAeyKoKcKDT9oYFRKhZ/0MoeEB7ft1El8CpOXnNz/ayFG4aPMXvdlAcIJpddfGonhAwHZRKBI9odHyBc58Y8iq0mZJEzXuqHT/paYc/E0ysDKXRpJkYMM1j6lCRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjdKuybFA+IQBDoL7wn9MBYEKxjJhwOpgCAvDWAsv0E=;
 b=pgtYDSNhDPRJlv485S/hK6+kSH45vCxCcuDJzOC2Fu28pRG7PhNnoB6fvkGuXeXmDuKXzIvzNo6+rydvxu8Bnv+2oQV1M1FAJgE2XQ8lc/ius5jGCjl0xZiZr5cM2EERdFA4Lr0ryIIdzEg/ux5ImyqItu6Mn7OsquxinmVFxf3dzfGd6RtV8Nx/ugrR7FjsBCx2A/ZsIzKnXaBMnoUkjQCeH4u0a1rWCThTO6OvR6KFUTGmlUVkMPZShFArupAwAPqr4v8g1ZYtwFjsEclumDLtJQ7H/y2Vs0BTUS8Opi7DdtEmw5mwwfDyUMhKI6pkPdKEQVRzJqELY8ng/3GXNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:21:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 11:21:51 +0000
Message-ID: <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
Date: Thu, 25 Sep 2025 13:21:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:610:38::38) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ca2a09-d778-45db-ec51-08ddfc25b989
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHlCMTRkRGFBMnhldVVHeG9aa1FRNGQ0bjlpeFZZZ3hZaTl3cE00Q0diTVFI?=
 =?utf-8?B?UTBCYitVcUdLL2Q1SmxDOGM4Q05qSDkzL1M4a1dhc05XSFJPMys5Vjd0VFNx?=
 =?utf-8?B?bWliTWc0TytoR2ZGcm5jR3NFeXhXNUsvRWFVblFJcVR6bThicjA3N0tPaXo3?=
 =?utf-8?B?cHJOMjhmQUFFbzdVTnoxcWIyTWt1UUlXYWFIdHQzQ2t6QjRKZjRVTkh0WVJp?=
 =?utf-8?B?dnF3RVBsTUNvMDB6RjZDU1pSMDFQYm5LNzhsa29KTHdUZE5SUnJleURGT2tT?=
 =?utf-8?B?TkxTVHVOVkwzK0k2cE9ManRaTGxsZDVYcVhpMDRqUllJUW5zZDQyMmFQbjFa?=
 =?utf-8?B?RHJlRVdYL293d2dFSm1OTmN0bVhhMjN2Zzc5VEJ1Wm91ZExwdGk1alY0azBY?=
 =?utf-8?B?V3lZWFNWblY5NUpPbmxYZFFiZG1SVDhpR1IvZWRkaVlaYmFTMlBNc29Ub2Uv?=
 =?utf-8?B?Y2RPZllCLzdiR2t2M1hEeW1Oc0loWFFpOVZscnVFM29qbXZXakFRNzRqbFJI?=
 =?utf-8?B?UTl2ZXVPOC9ubkc0NVdDcnlyKzV3UGtOdm1vRWZseW82byt1ZWU5REZKQVhK?=
 =?utf-8?B?b0R2Um9LdUVKVzR1V1R5WjJRUUlMZ3pLcE5NSElwSENacW1YN1VGYjAzMURZ?=
 =?utf-8?B?a2JmcCtNYndjakZzUjgxOU5VRWpxTWJyZnc1K0pGbmx6ZUp0YXlUWUF3azRo?=
 =?utf-8?B?b25ZMzlra0hVRGQxMlRPaFNmR1BCREMwbVpjdDJrOWptZzRkektIazVIZkpQ?=
 =?utf-8?B?eDRILzhyMnZBOUZvbGVVYjZEeGZ6NFY5S214RzMrWjRBRjZ0YWRhM2VSSzFH?=
 =?utf-8?B?ZVNCQ1p3Z3FHb2ExNW1IUEMxSHZOSzhvLzl0NkJ0bWw3akcrOFlpVktlSjRn?=
 =?utf-8?B?YUgya1hKMDhUWE5mK1JlWEZyU2VZQWZmbS9qK0FJZVVmd1VPMnAyN3FiUmFJ?=
 =?utf-8?B?VGM3S1VFVVAzd2RZMEcrVi9NRklXQkxEQ0RRVUhKU0FzMnRsN1FqK3ZtUU9T?=
 =?utf-8?B?TG9oREErcE02enk5cElhMk13elRtYXkrMUxnV0IxTHI3WFNRMm11bnNjSHJX?=
 =?utf-8?B?dDRENTlxcGpka2dRK0V3RmpxQmViMkduS3VRbTRna2ZJaGlhd1ZrU0tGZ1N4?=
 =?utf-8?B?Q1V1ZUF3eURibVJwYnBmVXpMd0hKek80VXR5VDFPVTdZZTBiU2JOQW9xdTNP?=
 =?utf-8?B?c2tOSTBUaVp2L29KNWtLUXlhUmQxR0ZmbHpVbnBQaWdXTmhVdEl5RlkycVho?=
 =?utf-8?B?NDJJcWUxVm1zSW4rT1NPcFY3UUZEK3Q5ckJlL3lYd2srZmNjeWtHRUJtbEps?=
 =?utf-8?B?VmxUaElxY1ROY2ZzanBkTUdLcm1UNUF4c1lLbkVlcVdOTFRiK1dKWXh1b2k0?=
 =?utf-8?B?SkJUODdLT0hFVzhRblJZR0gwU09yeGVONks3NDFYODA0UTdWdEdaZ0F4QmxE?=
 =?utf-8?B?NG9ld1MzK011bFRmbVRsa3QvU3dydlAyYkd2UE1zVDJSdzY3ZWlNRmZhZ2xx?=
 =?utf-8?B?cDNBRUlEWjFTZG5JTjI4dTc4ZXRIeWNIREh4aXBmbmpEbW1CbGhsYUNUMW9q?=
 =?utf-8?B?N21hKzJFRzVRd0F1OG1EUjZyN2ZNTnpSL2dVL0s4S3RueTg2cnE2MDVEWVdo?=
 =?utf-8?B?SGxnMmp0MTUySGlla0o4cjVSN1ZKS1hNQzY2OGJBVXpINjgxMmlhOEF0SHc4?=
 =?utf-8?B?dEp5WVU4Qng2Q1kvOUhWYkNENVUycGsrcEkxVGpmdGhHN3pWMm0vUGM5UWNY?=
 =?utf-8?B?QWk2UE9lZkV1eUhMTFdkem1ZMjhBM1RDZlBqWkRVTlJzdGNHRCtiY25aSXQv?=
 =?utf-8?B?OFVsR01DekVVcmxsQzZlUlJQMCsvb2lwcysxMWV0MUN4R2tUNXNDTmNMcUdk?=
 =?utf-8?Q?ClN91TZz04604?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NzA5ZFJoOGxUNzQyRlRzaC8yZUo1dkhiVVlQTDM4bWM2MmRJM0J4QWVmM1Vj?=
 =?utf-8?B?b3Zaai9YSkVxeHVaTmlhUmZaaTNyLzZEeU9BSGdMeHJTSzdGVjM2VXluZGRk?=
 =?utf-8?B?cHFEclQwR1BrMjJHcUpHMXBvSUg4T1NBUUxTem1IODdhSW9iQ1ZxeWQ0ZkxB?=
 =?utf-8?B?VDdwRHp4Wjl5NU5SWTJoUmM3LytFNTJ3NjBWVTFzS0tVRTZoUnZyc0VmbUpj?=
 =?utf-8?B?TkRKNE8vOVpYYm9pQkpnNnFVU1Bzb3RnekhpMExGcHVWVUFJLzRHZlFqWW1C?=
 =?utf-8?B?Y3FLMEpGMVVjbVVhZlRFVUFpNlJzLzdiWld5eWEzb0J5ZFZXZ3lNRi9TWnRn?=
 =?utf-8?B?d2IzUk9iV2svQk1HbFluV01IMk5GMlM3T3JPNWwxSEdvSG1ZQlk2dUk2QXRE?=
 =?utf-8?B?MDVld3FqNWQreE1DQm0zdVhWSEZGR1gxZlplZWZIY2xESnhZNVNoTCtMV2dQ?=
 =?utf-8?B?K25ET0N0QjVwU3F2UkhuQ3NEUlFRQmRLaHZ6anlTYWlXd1VpTlFyV1MvOUNE?=
 =?utf-8?B?SW9mS2xRZFRXUTZmVmZoYThoTG1pVXRmb1cwVHhuU056Uk5Nb1V3TzBmNjly?=
 =?utf-8?B?SGRzTmZOWFgxdEZsUmhnQjRtWWZDMlJJeE9yWTNqQndSKzVrbURqWGwvYVJH?=
 =?utf-8?B?NWh2ZlAvUmZXdjVWVGIydTNRbnM0STJBYlZPdkVUbHJENENocHFvT1FRNTJJ?=
 =?utf-8?B?WnpDam5FMlloTlFKb0plUW5GZFRRcmpoZUtqMUhhRWxjSkpzSUUyLzc3MWVo?=
 =?utf-8?B?dzA4Q3hFbXB6L25YUVR0ODBaa3N2S2hVMWdoMHRudWJ0N1VxQUJsaTJTM0x5?=
 =?utf-8?B?R2licVhYYVNMWUpQRWZNL1pQV0h6TWNNQWVxUEdxRlJUQWdZUkIrUjFLUGZv?=
 =?utf-8?B?QzFPNDZaMTRwMDVPcm1xYWZnMDBYYW4xZDVpaldyUUhFK0taN1RLM2FvWGlN?=
 =?utf-8?B?S2tVL2RVR0NJVXFFVlNKclBIb3dwV1pzTkNlVkFQZ2V2ZEYwSkExOHFNa0pv?=
 =?utf-8?B?VUlOYmxKNE5XbndVOXVLRnNlYkl1WDVReUdBUlFlMnVPY25VYklndlA4eEV5?=
 =?utf-8?B?YjZIbHBVeVQ4TkpYRTI4NFFvL3lRWVJNam9Qdm9OQkVtYkE3V2owUDdnR1gr?=
 =?utf-8?B?VDJQNkxiQlE1My8ySUhTVG5jN0FrSE5QZHRQTHowZTdENWtFT1MyTlZrSkZU?=
 =?utf-8?B?cnB6VFZSYU0xY1J4OVZZK0pnV1hkL3I1TlB1bEpOS0dnRzB1VVpmazh2VUF5?=
 =?utf-8?B?M0NKbGgvZnVUUmdLYTRiblBoUW9QeGZtREhsSGxVVHpNT3JjM1ZDSDE1eEk0?=
 =?utf-8?B?MGl4bWNDNlZKT1ZCaGlHRWFXTmxWT0U5QitUSHJqWDNsZnBpN21GbXFrMVZJ?=
 =?utf-8?B?VXFpQlpZWUgvSlEyM2czR2dTdlI1am4xMmxYblR4MktvK3lTNHJqb2RjNktr?=
 =?utf-8?B?NnZ6M3Q2a3c5dGVteDVsNmdzQzNvK3hlQlFUdzdib2pscGcrM0VremlSUGhE?=
 =?utf-8?B?cU9WbnBwbjQ2TkZNc2lOTUwrWHNPaFdLKzI0bGNsTWpuc29mSjR6YUdRWFNq?=
 =?utf-8?B?bVJsNVRVTUJJWE9XMjJGY1ZyR0JZdXF2QUpYNk1nRWRXZDNXditMRFJnUytY?=
 =?utf-8?B?VkRLL3FKbkVqb3JkMlBreEEzTjJGNzhDSlRnTy9nZWdPdFFibkdOaHF0U00v?=
 =?utf-8?B?YXp5OGVZbGlRM21hRmZJcC90NFl1UVY0RDA2YmZ2cmhaY3pyUis3YmNEbmtK?=
 =?utf-8?B?YXZMb0dNd2xWRFBtZm92ZzhEUTh5dmJCemxqbkxJQVFqeG83K1JobmFqeE9I?=
 =?utf-8?B?TmZ0WUM3YXZvRmZLNVF2L2pDaXdYQzBRNjJqclEwMi82Z3dDRGtTYlZld2Rh?=
 =?utf-8?B?emdrc3NXOUNhVEJmeFhPR0F4RnBrS2R5ZldSMHhMRFdIN2NJZm52MTd2ZmFF?=
 =?utf-8?B?UHZMWHhjTEJ0MVVSbE9nWFFpS0xlSXcxVGxmeWZ5MDBVZ1V3QWs0c0l6aTNH?=
 =?utf-8?B?VDJSWWJGa211K0tLSXZpbTJmVm05Q0xVUEMwR2RKM2lPdlYrTTVRdUN3ZGcz?=
 =?utf-8?B?dVpoeUdNdDR3bFlSNTlmWUxzYzV4aDhjRHg2OWs2SGdISlFwbmpQckNGY1pK?=
 =?utf-8?B?MjVmLzlJNERZTHVRRjhMUndKcnFXQjRqc01WUUtVSS9hamRvNFdpY1lZTEk0?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca2a09-d778-45db-ec51-08ddfc25b989
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:21:51.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GLAborLy+GT3DJr+fxSmDr2pVTU7n7n/ZCUyNS4EVDoHeWFvYjRazf8sxs9Nrs15AsOSI/HtmoXo3Bl2ruwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8804
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 11:21:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20133

On 25.09.25 11:53, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Thanks for reporting it, I had a look on the failed tests and they all are related M-COM device.
> It's a timeout issue, 30mins is being assigned to boot block. It means the device should boot and get the login prompt within 30mins if not then the test will fail. 
> Unfortunately, the 30mins is not sufficient for M-COM to boot and it's causing this issue.
> 
> Please note this issue is seen for the first time, earlier timeout issues were related to executing IEC layer tests cases as it was not able to complete the test execution within the specified time.
> 
> At the moment, I've below ideas, 
> 
> 1. We might need to increase the boot block timeout value and check if it works. 
> 2. In the current image /home partition is deployed as separate partition, so during the boot process the partitions /home and /var are   encrypted which will usually take more time (even in QEMU) to complete so, we can consider to remove deploying /home partition separately for CI images and it saves some time. Data encryption can still be verified with /var partition. 
> 
> What do you think? Please let us know, accordingly I can send a patch.
> 

I'm already running a test with
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf71701983e3cb12f19efe9c217f500b9b0868

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

