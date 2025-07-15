Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64656C83F22
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 11:54:17 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.68])
 by mx.groups.io with SMTP id smtpd.web11.6359.1752580452138897900
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 04:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M+kDZClq;
 spf=pass (domain: siemens.com, ip: 40.107.130.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDY0WocebiagZtEhI1QLf2QrmRZVsdDPTp/pKscmn1n4MrxsBGIBv7I2LSo0PHAFVmE9daG9tiFn3GwQOKZSx+1LLtAWEn3mfpsSc3qkIkal7qytUJIiAq/a78Kcv3cPAN6EfsQp42LY7qoJa3K6En+lLFSNHfMjBAJX4MOVuSs+FJ4DyGmGrH+nTtsYV9eOE/cVvOuScXQgTeu7GlM5dytpWuuR7INH7cSApYH9JbE8p9af5b19COybbDe1G0ZbhpRVFIAbJKkFfhdgpI7nV1AH0clBroMRKfPSPjnSfx710RucJ/2j/YfwKHS216gOLwwk1/H2av5TkJJK7FxR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBXzc92TnoOYF8qoVulDE4Kvg/XL/s2MRdXiD9zidhg=;
 b=qi1NtxGPaXHm9uHFDZ426O5GTG4xwsN8w9ypZfPyx4p5cGP801N296BC/aIaHIyU4zkodA07Qgg1hnustLd0icBs5mEWd2hlGT8tDE7Ciu8ZPB0Q7PuTvwn0JMSbgF99p7S08bTPKSAgofKD3EfvvI8LzeHsxbmwpiBRFVEo8RJTqWOE8sn3L+llxUCBypa2XGaz9jmHM7MhmUMbH0W2tBv+GMLRIMUQ7kgXAmPa79Hc6BJ8mNc3xzUMYxo+7AwQQV3AjMrY50IcxuIXafWNPUdXDfHeZHn7sIhGuObTG8SUieEFyB26bDuEHlI5YXpqZTcQb3H3sROR/6rKP/bABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBXzc92TnoOYF8qoVulDE4Kvg/XL/s2MRdXiD9zidhg=;
 b=M+kDZClqtt978datoGfuOw9EJrkeLVGB+Ewids0gvNk1wFdTbqOux3I1DUDO6ZD/aRQxErOXGpl4gxcjQUYwHzJAwtX612HF/9snVFrVmz11A/f3LXWqb/GKbgA2Gai1pRPP9FKmh5mPmrC/i8i3h66+0Xi+fyAdnBAwOvhgMg6DQv3jBU5VqOVU/5klc1T0xkyvsr4hXO3a+eEO25WlCGpdLaw9nSNu9W8lVQnDiLoNIf9i9hVQpIlhMQgE7dVziB3MqrV3/AQ+z4OIHQx4YaXl9hAAzTlPUsYlVzYbJpdlIzRJBKDFXwV+xQu2Y1CMjwdRhAPeDtV2iKDB9Pzs/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 11:54:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 11:54:07 +0000
Message-ID: <2006d2a3-df31-469d-9fb0-09f0086b7b59@siemens.com>
Date: Tue, 15 Jul 2025 13:54:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
 <TY3PR01MB1107546DA13B576633ABC1614C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB1107546DA13B576633ABC1614C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: fd993e2b-5eed-41f7-fb2b-08ddc3964dfa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S0lXR2x4YWNRR2xyUFJkSVVuNFZlcURhMUlEajBlb2RKejJVUStjMHJYUkM0?=
 =?utf-8?B?WjFwVjVjQXYyTHMyWkhRSWJoazg3R053TG9zZ2hNZnJ4dlU4MEd4Zy9MVWhM?=
 =?utf-8?B?QVhwRFVUajVSYktzMnNWeHJyWXBzZVp4QURoU2NZTXU5MWVIZDJ0ZDllN2U0?=
 =?utf-8?B?dk8vRVdoVHh4RjR0R29mWEhBeThrSmRTYkJsak1KemxKWjhqQnRTRzdwbi9B?=
 =?utf-8?B?blpCMGVUZmxrVHRqeUpxcWtoelA3S3JEamFLRTIvT2ZxeVgxQy9SZ3c1WWk3?=
 =?utf-8?B?eVNNZnBVaUticHNtUmtxNUkxUjVnYnh5elZVcXYzZUY4SWFNY1B6ckhpUlhM?=
 =?utf-8?B?U0swQkFMQUFOSDQ5RmJjQVNQTGlxMVRLaGx1bElTOEpXeWgzaTVVSWgvRXha?=
 =?utf-8?B?Z0ZQa2ZaYkFLSGdGaSthc0g2K1NjekFMczlQZ3E4Ky9ZQ29EZWRJREFxeGJ6?=
 =?utf-8?B?WmNVbWNURzJjV0FST0FuNk9oZmtQbktXUHN5QXBFK0Q1U21PTmQxVERKUnFT?=
 =?utf-8?B?NU1DKzk2d0t2TVhIbmpaNzdHUDUwM2p2UEZLM29reU11ZDlwbGQ3TmgwNlhk?=
 =?utf-8?B?Zk1ZTHdscDdZV296b3RKYi9tMmU1Qzg4Z0J3UmlDQXlrdngwUWsrM3Y0Mmp4?=
 =?utf-8?B?Qk9MV0pkR0hZZDE4a21FUlR5YWl0em5PWndhK1NFdGszZm9WZ1dteHBXbHRz?=
 =?utf-8?B?TUVDK3JmV3dyMk8xeEcwcUhoU2dobzNVeWlUZVFYRWxsbHV5UTVaM2RaWDJk?=
 =?utf-8?B?ay9PK3U2NEwyeDJXZUdoem9zaTR1YUxUa0o1YmJyWkJLMkpZdnBqK2pDaHps?=
 =?utf-8?B?WTVaN0t3QUd4OE41cmlTVmVaakNQbENvMDZ6clNYRy8vaHpaSzVhL3JrMVFZ?=
 =?utf-8?B?RFNvSVk0djdqZVZxL1o2YlduMTlVd0QxcEhVblFOUDNGMm1pMjhLZmc1UHJj?=
 =?utf-8?B?Z3VZK2pEWjQ3dVcyclRKUW9NeVo2TDl5cE0wM1l5aEdFMjdDK0Y0T0pTeUhW?=
 =?utf-8?B?YlJDMVpiUmpxSFBvNGlacFVUQWRWaHVqNXV1UzYrcnYxRUZQc3kwR3lnUTRz?=
 =?utf-8?B?YUNxWE0zSGFCaWw1Z2w3aGVWMUN0ZXJENSs1TmpIRDQ5ZGJwSU9KYkxwbmFq?=
 =?utf-8?B?dGhuc2xrODVvSk5wVmVpbVptb2prOEthMVBDL1NTL3VMSUNNeXBtMXlNTUNh?=
 =?utf-8?B?MzRSb1c3OGk4T2ExYjZpSVY0YUVkTDZPZ2J3Rjl5cHRkS1NSeUxpRVd2Unda?=
 =?utf-8?B?QlFpOTh0dVkzN0tlbGR5VGhnSUYxS3hpcXFDOC9xY25kN3VaOEYwVS9CSlhp?=
 =?utf-8?B?aVFORjBGdUpXME4wdTVJOGF5VTNIcHNKUGtXZ3JBazJyOUlYOWQ4Y3NuRENm?=
 =?utf-8?B?SW03T1gvUXFKSnRjZG5wRnlYLzZ6YkZMaFl4cHFRYWVOaGxNVGFoYWdLemhW?=
 =?utf-8?B?cktTQUJISWZaQ3Y1RVZHZXFKZjBlVVZSV1lUTG1vaHI5a09RZlExSGZEdUx1?=
 =?utf-8?B?OW9ubjN3T1E2L01RSXVuTWo2OUhGcHc5MTMyZHVOZVZ2NDAreE1QNlYySXdy?=
 =?utf-8?B?N3JrU1p5Zml1VGtTMlV0S1BvcTQybWpySEhzWTRkU01ySzEyZ2RlS0NyUVBX?=
 =?utf-8?B?TXNrUURqc3BIOGJDTXJIWTJFdFY3Y2NUMStXTUsycVJtTU1BcFRMRXVYUG1P?=
 =?utf-8?B?ZGV2OUM3ZndaVERaT25JcVpGNk5PaFMwajkvWWNNV2xFd0VOWVFyM2QvNC8z?=
 =?utf-8?B?SmR5NjZEYTBZYjRlMWVHaVFoRlliVWhhSjRZTkh4U1BwRVlTRU1qS2tEd3M1?=
 =?utf-8?B?bUZISXFsWmVIRWtxUkhVaVhUYTN2VWlSTm41TndiayswTjZ1QVlxSmZDQ2xr?=
 =?utf-8?B?azUwRXNMM1VTaHF4UnVvWWxJQ0tYNDM0VFlQaktUd0F0aHhOTTJpN0VBeCt6?=
 =?utf-8?Q?3/n2hh+knUM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnJxVlJFZXl1b2k1clJHQnpQcmRseWRjcjNvZ0QvdjlQUHljWk9zdGtuRDZ2?=
 =?utf-8?B?TG9TZDdNMGh0eW85YnQyK0V3dWNxbVFnT1dHRkc2NW9sYlY5QXVlVlM1aDdT?=
 =?utf-8?B?dkJNL1lsMlY3SDU1L0hHUlJlbUNHS01uaEJkSVRVOGJBbUFkR0pIQVFVcnRp?=
 =?utf-8?B?bE1LWlpDNWM1elBsUE5WQ2dPMDlBR1dKb3ROaGsvV2ZBRHZ0Ni9hVmwyKzA2?=
 =?utf-8?B?M2hKU0lyLythOHVpZ0V3YzI2dVpWQTlwVzU3MkFHWHdIZlpjVDdmOTdZM0Vx?=
 =?utf-8?B?M1NEY0hBSGE3Rkx2eis5UUlDZGlpRktjYUFSdStkRkZiUEJ3TGVBSXdzWmZa?=
 =?utf-8?B?NmJkem9KT2hVelZjZCt6Sys0bWhZWUFwTWtLQTJRajE2c3lVSmVyM0VWK2Vp?=
 =?utf-8?B?d0d2M1hxVnh2cTBZdlJBeDl5SUhvd3ZYRHIwdWs5eGc1NGNwTXk0WjNOUHlw?=
 =?utf-8?B?VFl5VlVac2JCZlUrYVFtekxuUENvRldxTEtRV2FLWm5VYTd1SCt4QkpRdzBT?=
 =?utf-8?B?UzRKWWUyclpzbllyNlprWWtYNnZqUVZtV2tkdkxDUVNUTHFnWXlnTExkZ3cx?=
 =?utf-8?B?ZXcweE9MbE0ybXRNR1BCWDFvd1duZGlFTys2dE5PR29oM3lGdmY4YXVNb3kz?=
 =?utf-8?B?Uzc1bHdpYWNNbml3OEpPTlNBczlTMjdnaTY4cjM0ZWcrZE56Q01ZM3Y5bWRV?=
 =?utf-8?B?R3RsYldEZVlKM21QcUxoK2VHQjZNWkJIZUZKOXJ2L1RGdkw0Q1pRMnZKcGdk?=
 =?utf-8?B?UkdmeW83UThoNENsYldxRzRGUGxYV1AwdGhwdytTVmVhcHpXR0VTVm44eTNv?=
 =?utf-8?B?c2dxSEEyeFdvNU92V00xb21Pd3RpaFlJbGNaaDdQdmRudlBCTzNndXVwaXF3?=
 =?utf-8?B?VFpUeTNKVG5kektyekQzR3hZbWFKaGV3eWZlMHhIVDJna0ZnUFpIMml6L2Vw?=
 =?utf-8?B?MXQyV3dtQ1hSMVVaQk9GZ1JKSnJuUlJTK3RQVFduMFR5TlVZSVRUVmY4MUc2?=
 =?utf-8?B?ejJiVnRweEdmUXJnaFNNd1h1TWpMNlBBeEk1Tm5uUFpua0NuYkRxbVBNVkVr?=
 =?utf-8?B?LzZUM0ppTTJ3K2xrMnFNcnZmOUtRZjhqUEZabFppL0c5Wmt5aXZNK1RkY0tq?=
 =?utf-8?B?SzJVelNkVUZYalFKMm9aWXVCNDVjSzBqRE00UG1EQkUwc3cxSnFVS09Ub2Q2?=
 =?utf-8?B?MmMycTlOY2IxK0dYRXJxUzBHV3Z5bmZ5QVp0NlZDK2UxenQ3VkhncnJic0ww?=
 =?utf-8?B?M3FmVUJIbW9EOUZZdytnZG0wWno4YkJrcUw1ejhRM3pLaENvUWVEeEpZWjd1?=
 =?utf-8?B?ZHQ0ZDlidlRURE9tRWpuUElOaURHNEh4OFhnQ2NFR1phVjJDUnJWWkxwbkdK?=
 =?utf-8?B?VXJOVFg3bzZGMHBuNHN2a2Y4dFI5ekE0OFBPaGYwZGdxbjB4cWJoMnFFdVlh?=
 =?utf-8?B?SEp6bWdWV095Sm4wT0w0K0JsYVVLRGtMV01SMC9iMFhZTWNvSit2aE9mYmhK?=
 =?utf-8?B?NStDU3JrQVZ6U0R5bnVZMzA2SldVazE0SzlqejdiMVVEVklLREtvWmFtTXgy?=
 =?utf-8?B?ZjdhWWxOWFRGQUhzRFBOZkNZNGsrWk5PRXZaL3hpSjUwZUF2a1RNbElsUjZD?=
 =?utf-8?B?ZEgxeDV4UWpoZHRscVJQSDZSMmh5ZHJsSjFhY2tUM2Q3UGtDUzJDTWh4VmFl?=
 =?utf-8?B?UlBFTDhjcnpTSWliTUxUR0swZ3FqWm1abVA3M3AzYk56d0xhSUxRSWphREp3?=
 =?utf-8?B?dFV1aUhROXFMeFp5cXBkZEVuYWh5dkloa1JVN2pER2FjTDRERjJTQytnTzlU?=
 =?utf-8?B?SVNub2J6bjZPWTRXVTlVME5MMCs4VmwzMzZVNTlNV0lzZkRuTWxkWlVhZ1ov?=
 =?utf-8?B?T25aRFdOTVBlY2Q5bDhGcS9FdnVTYzVyaUhvTGE5aTNYVU9ZOVR4WnVYL0ZE?=
 =?utf-8?B?Mlg1K2MwVkxjQzN5QjhLdWNTMjkvREM2MDJLT3MzZDZuVFExL0Y4RFJWNmEy?=
 =?utf-8?B?eExGdFFWN293bzVyZnpSRG1RV0dyLzNMVENUSjVHUFJRM1U2WTl5QWNrT2o5?=
 =?utf-8?B?dk9TWUV3emVRbGlrbnBsWWJBRjRlbVArd0ZDUU1Bby9oZXd2UUR5bG1YYVlZ?=
 =?utf-8?B?bUFOTEpNNG14aGJpSmh3djkvZ1orRmxvYnZyWHdZc3U5SjYyMHdQc1ppUzJL?=
 =?utf-8?B?RjN4VlV0dlZEb0FlSWxBUFRTYWlXYjNNSkRUUXFEMEk0WjJHZUkxS1NJRVlS?=
 =?utf-8?B?MnR0RnVHRXc0dVc4aTRJSTdwRkd3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd993e2b-5eed-41f7-fb2b-08ddc3964dfa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:54:07.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGvS0Ds/yh7m1NN0KQfWRbYzI37mxvPLEt2PCW6jEfznvbuhDz6/RqLghshF03HLS2QIqUfcZ2ncPRxQTz+YDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 11:54:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19538

On 15.07.25 12:53, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Thanks for the reply.
> 
>> How do you account for the dm-verity container here? What you get it just the dm-verity container start, no?
> 
> Yes, from the fdisk tool, I'm finding what is the start address of ROOTFS (systema). 
> 
> The re-created squashfs image is written back to a offset (start address of ROOTFS) using dd command.
> In this case, my understanding is that the ROOTFS is not corrupted here but only it don't have the required verity hash details appended to its tail.

Where did you read that this information is appended? I'm reading
https://www.kernel.org/doc/Documentation/admin-guide/device-mapper/verity.rst,
and talks about a header and some hash blocks following it.

> 
> $ dd if=/dev/zero  of=cip-core-image-security-cip-core-bookworm-qemu-amd64.wic bs=1 seek=157286400 count=256   (157286400 - start address of ROOTFS).
> 
> In case of above method, It will corrupt the ROOTFS contents, there by not identifying  /dev/disk/by-partlabel/home file and ending up with panic error. 
> panic "Could not find device  mapped to 'home' cannot be encrypted!"
> 
> Although both methods use the same offset, the boot will fail in different verification steps.
> If you feel the squashfs method is complex then we might need to investigate further to find a simple step to verify dm-verity corrupt issue. If we don't find any alternate solution then we may need to finalize any one of these two.  

I would have taken the rootfs partition, added some reasonable offset of
sectors to skip the header and either hit the hash blocks or even the
rootfs itself this way. No regeneration of any squashfs, just one sector
read, "bit-flip", write.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

