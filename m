Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A6C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 14:52:45 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.0])
 by mx.groups.io with SMTP id smtpd.web10.23443.1741099961472929087
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 06:52:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RtjLmzpc;
 spf=pass (domain: siemens.com, ip: 52.101.65.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp9yKBKxFOUqNMnpRMAJnyFAU2URcZ0GmgG3BcNCD6lX1RwuGNVd8itI5W/bHb+J1ELIvsviIM936lS5CPmSu9MBVN1EJX6zPKllAUefmurQRIcRiA9hLFmvbQcCX+5TIQW1xB6rrVmvybx2KtQPRRBxSgBw75zjW1YJOLHfj8aJ7fDD0OfBjXz4YdSK7w+JBYg9ZUyaZvEcJBX54vIJh276I1ox3C0zBdwAj61Kes5aa7JuAH2UPCVKaa/6pDUATqOaVCz3f+9viI1rZ7V6dmdLZCw/jFeOCd3vvJ8csyWOWEE3TuaPsq/rgqM1mZ1ffO7uychab41TZ9QNgcMC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKO/PkZhujvJYSOgaZqBJHV13HB867MCsN6Af6iZdac=;
 b=T5cZiPkZVoVz8IbDVXkXgTmyJet6fGANvTsd4+IRxq8z574qSnDYX+Up/NuXmTzb3xxAPhIMRGd57rOVdYGiMIa+3ZuYj2U8kAIrkSv39Gwb8mnqmpWGV/YNCG10X5/ZUNStvLfDmBZrhZXIlmzljgpGx9nKrC4b50F3cHKc5NnV1G5BkguUw3xQlzLRnlFYKmdzK6bnGYMm3DWcsgxjIk2WZkLgy1UyMfQUxVw9sdT7NfbdKeS5EQCJMvUzRewvTJ4D6mJf+Yq5Xdn/8Y+orK8jB2/8v0WC4uvehTLtetDSfmntg0r+44qOQkEMzgCGSy8GnkxX/Cpa4/oqTvMKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKO/PkZhujvJYSOgaZqBJHV13HB867MCsN6Af6iZdac=;
 b=RtjLmzpca50v941ChUZVndPavv+vqaOG6K3h0G0J345viwCfPSvfJ4Fkh7OlIPsMdhY+DfXKahxox+NNS2NE4aiUcIxJz/rU7bEJSROYxhPkCJikeuGjg31FSB2CLqZVCYOiLTo1p1BpJ/QTtO1LBPtBu6XMFEglg1CD43jr3TIrZbnCc6mJMxnQ3fF3/c99eESpaVxJNy19QK/k+nWG6L8YEFtRgcKMHRwbmOY/gLJ4Jpc23Kx1mi+hFZeXpjzOhfqqVWCHf3SDECI1HN7u0rnnazj/FZFJOHMCyVqqok2RQcXXMGMW0vMLrK70x5Kqwo7TTPcub+0akoF34CPPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:646::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 14:52:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 14:52:38 +0000
Message-ID: <3d4d80f3-64c0-4d2c-aa32-f4987f370eed@siemens.com>
Date: Tue, 4 Mar 2025 15:52:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-5-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250304130743.2812183-5-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7afd8c-2c8e-4f3e-cf13-08dd5b2c351b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VGRqZ1FLdlJJUlFvcmFnWEhGOTFWK1gydXF1NjNLekxrS2RLbUFsajFFWEJO?=
 =?utf-8?B?OTJsT0pHUm0vblZ3Vm9NcDJZVUNSQ3JPL3IzaXdFbGQvVGlKdFpoMEE4aVVn?=
 =?utf-8?B?RklCVmFZd0RHS1MwQzI5WUNGRUROa1l2NHlSVUt3NklnaFNzWEU3b2hiWWJk?=
 =?utf-8?B?TU16SVJNVnB1ajdEMFdVS3hYeEF3N0ZiMVVIOVg1VlczaFA0aFB3NXZzOGFD?=
 =?utf-8?B?a0RQeWpqam9KdjhHZmJYTzZ6Qi9MQmFibU1MQzdUOWZuenIza1dVR2Y5SENW?=
 =?utf-8?B?L08zcDB5b0ZZNnZrVktIYVdUV2M2VHJJSkkxd0c3dTUzZi94TzMwKzdNc2I0?=
 =?utf-8?B?eUZxK1ZvR1dkSjF4UElhdTYvVVlrMERvd09abVd1WkZlN0VzTCtkRGt2a1RD?=
 =?utf-8?B?MmlCcytDWWpwenBKL3JxSkR5Q3d1eXR5NHFTOHlTdVAvVFlEWFIxcHFMakNX?=
 =?utf-8?B?clJzZVdEbnh0UmowQXRDakJ4ZkIySDRnSEtweGllMnNmNEtXM1lHU0JCT0pI?=
 =?utf-8?B?djJvVUJRWHZ2NWpPTFBSWjI3azJuMWs3b0ZXWWFiNk5RNU1hd1JxdVY5UFo1?=
 =?utf-8?B?aUpJSlBuZnpLWVFNaE5DQVFzZVN5UHU3a3Z5ckU4cVp1VFlVR1grS3pCVmZJ?=
 =?utf-8?B?Mmg0dVROUE84QmVCU1RETFgvUjdSNno0bXcyZlNEOG9kb05kYTV2a1BCQitr?=
 =?utf-8?B?c21hc0ZoZ1dTc2o5V2I3VDk5UlVNMGloVjJ6dnJzb29ZVVd2bWQvMUlVL0lo?=
 =?utf-8?B?elZheUptSkNhd2FYaWJTdHBLTGlCR1NtL0lnd2R4TGhrZTJSNlVScDRlNnB4?=
 =?utf-8?B?MGNnZHkxS0FwZGNZT3RTT2hSeVU3eDlld3ljQTVOTTVuREhUVmpzTFNwRXNk?=
 =?utf-8?B?WXFzeGF1N2xmdTFYdERFR1lBbnh2RVFxUC8zZ1dUcUN4U21aekpScVhKN3h6?=
 =?utf-8?B?R1BkZ2RHWE5vL3A1OHNJVTR1UnJma3NyemFqZ2FSQVpXUmZMWkNYU0g4aDFW?=
 =?utf-8?B?SExKVGVmenR6Vy91TXVBVUdrRDlSRTVLUFhxOVBIT1I5MVpqZ3JFNnMvREdz?=
 =?utf-8?B?QUt0ekQ3eWF1U1FwalR2MUFHTklLeWVEeXBTZzZRc2huRmE2NitaSXluenE3?=
 =?utf-8?B?aTQ3dUZ1Q0lYdnlyayswWU0rSkZrYUZiaEhkM1JIWnNiUGhGdGlkQjh3UzF2?=
 =?utf-8?B?UjZ1NndjOVJUV2U1Vzd6dVlXNkE0c1VkT0crc2ZzaGxZRDVvQTU3eFJPRFI4?=
 =?utf-8?B?NWtCSzkvbDZSSFN6ckswM2ZFYkV6VXpDYU53QlVvUlZIU2lNRVMyZExWN0hI?=
 =?utf-8?B?SzhLY011MVIrM3I0ZmNpWFBZaUxCNlkwWUh2eGVHQkZSKzBIdHo5TERDR0Vq?=
 =?utf-8?B?UFhJZ2FiZHhNdUQzNko1amdON1NGMlBaTlZ4TUE3RW5WbzBvUnpYMVF2Wm9D?=
 =?utf-8?B?bDFhQ0VhVVk3U1pGUW4wTUtoNGphNEo0UnQyVGJTeVAvbFlwM2ZkQ3BmVHlw?=
 =?utf-8?B?eUIyM1FrTEdqSTVMLzlxQTVUdTVlcUVEL2p6VDhlWTR3bnhtZGVibm5EcXdp?=
 =?utf-8?B?RnAyWHhXajMyWkhvd0RKQXZ0T0h4cHJ5czhoaHhZVVZiS3d1RWplWWxsSjdp?=
 =?utf-8?B?K2RwUWNraXlLVFZWZHNYKzVuYjRlZzdVblk5a3RXZFdvODlQTEZyY2FkcmJp?=
 =?utf-8?B?aUlKYzVLZWp2ZlJTaXREQ3BIV1hucktYM29kK3Z1MzV6eWJmV2N3TnpFbGVE?=
 =?utf-8?B?azh2OGd2YndDSlZmbFJtb09TRlNsT1JhQS81VU5XdW5ZK2syR0JrYnExOVJL?=
 =?utf-8?B?UytMT3Iwb2V6QlRiT0dTS0pxOU5BYVpiNDQwRGgzaVFMZEpUeTVPL3RjbjRr?=
 =?utf-8?Q?kxUoFXQKZc2ma?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2JCSnZLMEdwMTZObTJBT2ZpS0xnaDU1R2xlWW9qVVM1aUpmNWUzYVBYQ28r?=
 =?utf-8?B?RG9Xd0M5SEhMYWpMUTFudmlvOHhGcXZyRlRMM0FPcThWcmZSMTV3c0FiQ0Ux?=
 =?utf-8?B?Y3U0SDF1OENLSEovSW0yQkJTNUJRTWtGcG9ONmpQaXdpQ1lweDhZN28vZzBt?=
 =?utf-8?B?SFdDNzVhVDlOL2RxMXl6ckpYaFZUV0cwVzZPaG1zOGVZcWdCMnRNQmcxdkpT?=
 =?utf-8?B?bGhoVGZvUFJnYWRtRTlTcWYrMVh0cTBqTVU1RE9KdzdxY3JObGk5SEVYOHFW?=
 =?utf-8?B?Z0xzV2JOM003R1dnaE01VEJXUXJlNWZvZVh3bWd0RE9zTUNzaXQzanNpRXYv?=
 =?utf-8?B?cjJaajBMVlZ5ak9KTDFqOGhkTEVhbmVjajNXRDVKekhSUUo2Z002Qzl3blpM?=
 =?utf-8?B?WmkvY0ZmU3FxbFNybGpibUJjYUh6SkE1MlFuV29zWHhTTlU4bE51NTBhby90?=
 =?utf-8?B?YXc1U2FkSTh3WVp1c0MvMXhQelc3THlqUFk3RTRxU2FUamIxK2VFbUorMVhQ?=
 =?utf-8?B?TDZ0YkY0aS8vSXZwZVloS3ZObWdqOStpcTZMUnYzekR0NDZQZ1hmeHRBK2Rv?=
 =?utf-8?B?Y2NIbTdERzJud2RJVDFZQWNSbEg4NjZkM09iaklucm1RUHF2amNGL0pRUitz?=
 =?utf-8?B?SE1mbzFDYlIrTFN5UjZDRXJXK2wrckxRSGllalhhUEI2V05kaFhGY0hzSUZp?=
 =?utf-8?B?SHRRNmRtcDFwZlNkNHIzUjhDelJDa0RuS3BQZ2F5U1JQRDN2cVdlWGczbmF2?=
 =?utf-8?B?Vkt1bEdPV1I2WlJSYjI2bkczVWxNai8zY2tWYVJIVUNvYnZPRDQrQWUwYTYw?=
 =?utf-8?B?a29zWlpyT000WndyNUVJSGE4c1pCc3B4ZjZldjZuU0xzcFpBMXI1QjZ2enMw?=
 =?utf-8?B?NkNzbnlrcUZPSHcyVVY3NnlSckVOa0ZxQTUwNnBpWEQ3T1kydTZLeUp5enNJ?=
 =?utf-8?B?bkZRNU9QMi9RY2NFNk9aN2laakVOZGpKSk5EYXVjRFZYbkVxdW5QTHlpclAz?=
 =?utf-8?B?WmNYWFFhemNwWFdYSG02amY4a1FoMEpiUXpST21JN2RWZjlCWnBwWEVoOS9v?=
 =?utf-8?B?dzZtZmp0U0orcVkrRDRreU45NGFIeklxSUtPM3FvZ3ZNVlBtUGpZOTI0aXpw?=
 =?utf-8?B?MUdyelZDMDhlR2VxWDZzVDZiTlplN2cyVzl6dVRLMWN4ZUMxUjJpT1RRc2E5?=
 =?utf-8?B?N0JBaGQrZGtCczRSTVBvV0E2NnVVVHVlVlpEZkhFNXV2TFdpTHExYjFzNW9T?=
 =?utf-8?B?RXYyWFJKeUx0YSt4QkZ2b2tiNkZWdGFtb3VzbWl6T0pZY1pKSk9CSWQ2cGk4?=
 =?utf-8?B?dWpLNXhGU0V2UzJ1dnNHVEdKeWpYUWtPVVhKUHQ5TEpYS2NHUmUxaDBrNTZw?=
 =?utf-8?B?ZC9WL2QxYVIrVTd0S2UvdEhkcktzajlDWE5xQ2dUZGg0aUJ5alVpMWpPWXg5?=
 =?utf-8?B?cDM2djZHV3c3Zm5QUmIzMDMzYXp5UHJLaGFQL2xWMU84Z2duMUdicVB2S25t?=
 =?utf-8?B?K2FBcXAvdDJZZkNZRmtaM2k5dW5hLy9RbjRkdzJvaTQ0eitOYnpZRjVRN3Mz?=
 =?utf-8?B?aXhZT3l1WjhnVjdHRnNuYllUa2VrSWxNNTJKZVRCN1NTNzUyZ0d1NVAvVXlI?=
 =?utf-8?B?Zis3ODFheGsrWlNNWlJPeG1taHFWN1ZPUG5MMEN3NHhHMk1STGQ4bHJ2aFFh?=
 =?utf-8?B?dk5TbkMxbGNsN1dVVGt3UG1EVXJtWGFKVlJjQS9sUi93d1FML3B4OFR6b25r?=
 =?utf-8?B?aWhrVU9SK1E5eStNVUlzTFRZWWlwdllJTHd5cjhOeDY4RUNWUnptVkZ4V29F?=
 =?utf-8?B?VUZ1bWcwVi9relZVdElJbFdHUnJXMWU0VDhLbmRTNDg3dmdGWThMQkNkREVp?=
 =?utf-8?B?VVBCYTJNa2RIRGFyTzZqUEdLNzQyZDViRlN4dEo0OTJpZTVuaG1QcGdhL3h1?=
 =?utf-8?B?bTVmZDdVallsZU8xZTdhUGtzT1NFSm50emVSUUQ5azF1MnpEWW8vdHVxeFNr?=
 =?utf-8?B?K29sTkdxd05GcXpSeUJQdmM3SmFQa0dYemJHUUJZcmdSUENObFNYeGJ3S1hT?=
 =?utf-8?B?NFZnVnArSmh2RDBjZEhJMlVtMW5UZ01mM3RGdXBBR0lTcFR4QnlwcDRvc1F6?=
 =?utf-8?B?L0NHWDRoTWFuSXBlcTFLUHRreGFsbGVQMVhiYTFheGtCTUxHVG9aWWRDM0Rn?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7afd8c-2c8e-4f3e-cf13-08dd5b2c351b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:52:38.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7EqZOXcBg1Msi9wQwyPRC+8DFl+o1OGm20D3PY4JmJACZ4kk9LTTb/Nufo+OavzORdTATznBmuck9c+/v+lLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7657
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 14:52:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18020

On 04.03.25 14:07, Claudius Heine wrote:
> Integrate detection and recovery of power failures while a partition is
> being encrypted.
> 

Why is this at the end of the series? It can already help the existing
implementation during encrypt-on-first-boot.

> There are possible scenarios:
> 1. Power-fail happens while the partition is reencrypted:
>   - The LUKS header contains `online-reencrypt-v2` and needs to be
>     repaired with `cryptsetup repair` before it can continue.
>   - Also no resizing of the file system is necessary
> 2. Power-fail happens before the systemd-tpm2/clevis token can be installed
>   - The LUKS header does not contain 'systemd-tpm2'/'clevis', thus it
>     needs to be registered and the temporary encryption key needs to be
>     removed
> 
> In both scenarios the system after the reboot needs to have access to
> the temporary encryption key that was initially used. So using a random
> one, generated via `openssl rand` is not possible. Since it is only a
> temporary key and gets removed after the systemd-tpm2/clevis token was
> installed, a known password can be used.
> 
> The list of these scenarios is not complete, there might be other
> instances where a sudden power-fail could be fatal to the system, but
> these where the most obvious and risky ones.

For recovery of the first boot, this might be enough. But when proposing
this for in-field recovery, we should be stricter with thinking the
details through. If we fix them, immediately or later (or never if
unfixable) is on a different page.

> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  .../files/local-top-complete                  | 33 +++++++++++++++----
>  .../initramfs-crypt-hook_0.6.bb               |  5 ++-
>  2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 47533b5..e67f26f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>  	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +
> +	CRYPTSETUP_PARAMS="--reduce-device-size ${reduce_device_size}k"
> +
>  	case $partition_fstype in
>  	ext*)
>  		# reduce the filesystem and partition by 32M to fit the LUKS header
> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>  	squashfs|swap|erofs|"")
>  		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>  		;;
> +	luks)
> +		# Check if reencrypt was aborted
> +		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
> +				| grep -q "online-reencrypt-v2"; then
> +			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
> +				panic "cryptsetup repair was not successful"
> +		fi
> +
> +		# already luks partition, don't resize
> +		CRYPTSETUP_PARAMS=""
> +		;;
>  	*)
>  		panic "cannot resize partition, unsupported fstype: '$partition_fstype'"
>  		;;
>  	esac
>  	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup-reencrypt --new ${CRYPTSETUP_PARAMS} "$1" < "$2"
>  	else
> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup reencrypt --encrypt ${CRYPTSETUP_PARAMS} "$1" < "$2"
>  	fi
>  }
>  
> @@ -244,7 +258,7 @@ for partition_set in $partition_sets; do
>  	# If partition is already encrypted, decrypt and continue with next partition:
>  	decrypted_part=/dev/mapper/"$crypt_mount_name"
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
> -			| grep -q "luks2"; then
> +			| grep -q "systemd-tpm2\|clevis"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  
>  		# check if we are trying to mount root, set ROOT to decrypted partition:
> @@ -255,6 +269,12 @@ for partition_set in $partition_sets; do
>  		continue
>  	fi
>  
> +	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
> +	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
> +			| grep -q "online-reencrypt-v2"; then
> +		partition_format="reencrypt"
> +	fi
> +
>  	# If partition should not be encrypted, continue with next partition:
>  	if [ "$partition_format" = "noencrypt" ]
>  	then
> @@ -272,10 +292,11 @@ for partition_set in $partition_sets; do
>  		watchdog_pid=$!
>  	fi
>  
> -	# create random password for initial encryption
> -	# this will be dropped after reboot
> +	# use partuuid of the partition for initial encryption password, this key
> +	# will be removed after the reencryption has finished and the TPM2 token is
> +	# registered:
>  	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
> -	openssl rand -base64 32 > "$tmp_key"
> +	lsblk -no partuuid "$part_device" > "$tmp_key"

This should be factored out into a separate commit. I don't disagree
about it, it just deserves an own, clear reasoning. Without recovery, it
looks to me like a nice size optimization for the initramfs by dropping
the openssl dependency.

>  
>  	case "${partition_format}" in
>  		"reencrypt")
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> index c9a7f89..5e82521 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>  DEBIAN_DEPENDS .= ", \
>      cryptsetup, \
>      awk, \
> -    openssl, \
>      e2fsprogs, \
>      tpm2-tools, \
>      coreutils, \
> @@ -40,8 +39,8 @@ HOOK_ADD_MODULES = " \
>      ecb aes_generic xts"
>  
>  HOOK_COPY_EXECS = " \
> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> -    e2fsck resize2fs cryptsetup cmp \
> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> +    e2fsck resize2fs cryptsetup cmp lsblk \
>      tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>      /usr/lib/*/libgcc_s.so.1"
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

