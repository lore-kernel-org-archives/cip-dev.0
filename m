Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ECCD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 07:45:12 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.148734.1781595903179626669
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 00:45:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kzHaKM7N;
 spf=pass (domain: siemens.com, ip: 40.107.130.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqovNJHslJCmz0+b5SYbsv85Vt3PI+EmSWct5hVBkwsPnp+ODoGKj55H9TtPeMPln11a/+8dg0yUHuFSquLBg25E4WvIsMF7Aaiuu7AJZPMaN9hEZj7+JCj9Htmo3A/2pD7+6mZgv5gc9SOr3i5iyALoSppMbQwIew+fNo8QCQlE/RCKlYJ3ENC1EgBxt5gbjelM3aDNoOB8VGrBmZ2DIePksMXec+D5Z89HyprtmwvjVnWibR038J9VlX5/gr5u1UvyB3V9P1e11fomQx4dkESQfF3HdHFJ5N4bnCfpb/3OXuCP+qpJlVYZJn+casuvRJA05YoDp5SV05wD8LnhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci3UBWWdMwJHKwfbwzNBX7OY8dX9oWU33B3NEvjcHEk=;
 b=EbgTo4PvYZ9YtoUfMWvVBPhmaaK0TIXr3/f9N6MI7FvmTy87KQG9zdhXlZ4BApCCUJnalrc0maaYdBinYZw7Oek1vp1IoAqMgeMQ4CcodwPCSsn5vqUDZTi8xNjdpNgFonJt/osNr66q9CKj6jv2hympSXHyY2qfStOKlHWMbNaqdkeuB6oK7TtVDr7niiaAnRZzkXgAdaXXQmMhS6hf3m7mjhtanjQM992OgR9bZusDR+ewePy/zxwTIGWJGl1BsQpALFEnVtXTz01H307ihQQ8Xw6aZ/pPPpt7hTFkTkfOjE4WDrhQmxeG/wC2hJHvn+NRBO4gpldjAyKJpEspMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci3UBWWdMwJHKwfbwzNBX7OY8dX9oWU33B3NEvjcHEk=;
 b=kzHaKM7NQIeNlb7yTm809/yuTPg8sNB8ZPGuzVm4o847NPpL6aB9m6sygj7CI2oYjY5uYQLUE6YIQRELsWq8St+mh5bSHAduZGQ+TEni4aEUULsRv2vnQfnGz/ibffEaBkXOg2BXTHFQ+hSaIneTnhRAiP6ZHWaAItgC3e9xLoZVoU/l01li09bY+W7CfSF+N5EgNvq7w7nBaHSf+mP4vE1br47jdFv7tTNrqK/6f+Dd0g/oFu7th5K/R3gNgdFlNYHflWCsjTqnLASrn9f9m20h7SccamNqf68YhqmMMGUT0evzu5aXKFttE6ITy0KxieHIY+CCbwQa279HW24GCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Tue, 16 Jun
 2026 07:44:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:44:56 +0000
Message-ID: <3725876b-c679-4ef8-8097-6506fef8a7ff@siemens.com>
Date: Tue, 16 Jun 2026 09:44:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH 2/2] Update Isar revision
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20260610212746.22275-1-srinuvasan.a@siemens.com>
 <20260610212746.22275-2-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260610212746.22275-2-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ac10ce-8a2a-4a59-d4ad-08decb7b2931
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|55112099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	yrOtCFCpmgloClIWd2PWU8FT82fRaeN8GJ3dtIql247d8gsmUg98eh5YIc/PbYIQknH8SyvVa+nT67zOumqWZIrBGFpsf7QoNOcfMyyI3d9snD7seIM/39WkdRAhQ/5MWbCwyHkXj8iysMZOeoHRt1D9bRaJ728XxRjFJli5omRIiTJhbivI6AzT8a0VNpr19qHiYSY8/fqYdANp8T+PFFuQuJapiIvUkY7G/YKSMJ8Hg8ziTz1OpEwv1eqFMF/HRbZcYUJ7muILbZdpOIYXdKFLyJuVbTjJuPlv7Y+xPJ/zZWJT8bypHYFS4ykhcIVrJTKxYfPVvtc0tAM4TJVQ6r1ZO15FxTr4ViYrMta5HOej0aSvzyBO2I6D470r8X1Va7WtbLO8VxSVw9zjwWIaFr9y1aGXdLCpVX9vMORP94LMw5v3J2hbMCL6FJ4kEvYmfNlxYDrXUjsnWkK5GLwULWHadgVdtDD8yqz1zjDMGKDVv8JfLcbXUQPk9aXp4hE6UL9MHXkkXmHI5hO/U4xyOJv4A4eHowLI3xqTX71d7mc38vYDvATWNT0e7+1Xd3A9bL6hCl38INDds9EhV1wdNq/z2XpSH4tMD+mcT37N5GnGD6zfpxiRZ23gb8Elx1KFdMLA1fvK8jFtoaCy9yuv0XpHI4FGSuSkMrHPw32vXq6S43CWCuKue7dk9L62piB4KpRus7NOnnmA6SvWvCHacw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OE82YXViS0N1SFprL0hrZ2JhUzVSTzcya1pWSk1jdmcxeUMzUEVLc0NibnV5?=
 =?utf-8?B?V21OVmpGckFZczR0dXY5OXlidVZKYXRxZ1g1SUEyM0sxbU02MzRkUkRjZGxu?=
 =?utf-8?B?N3QrMkJEdFZvdzFhRFRmamZjRkJ2OUh2QW45VWJzYWRNS3p4dzZpTVE0dmVz?=
 =?utf-8?B?UXJ4SDZGanhtY2VkV2xnZXk2eHpsbHhGdkVKdTh1ZlN1TkpBRURwRmhjUTFz?=
 =?utf-8?B?VDg1Ymo0UlJ1czFoMVJxcUF3QzRReVZUbUx0Vjk2OU5ZNjFMUFpvQ29GY1dp?=
 =?utf-8?B?WDhPdWhHT1lVM2R6aU5xQjJhMnhsU0Z4MzJJdkRmaFdHdjlLTUh5OXdmeWJP?=
 =?utf-8?B?dThVZWJrYW1EOUNCYjU2bklYL1RpWVVMSGdpaXNlQVhrVnFIUzJwN3ArNWNC?=
 =?utf-8?B?b2xOUC9PdGF0WnZFSUViVitCUUduZldaSjVjTDJyc3A2YzYwOHVSbnNYU3dr?=
 =?utf-8?B?NkhHL1M0ak10TndhWEloU0pRNUkvT3Q5cEYrR0RYa2lBVEU0QjFsdjB3YXVh?=
 =?utf-8?B?bzM4L0JWdFBrTmMzUm9TMU1xWWFQR0NTS3l4UUdiNTNobWE4dElvN0M2QXZJ?=
 =?utf-8?B?R1NRUWhWdHM4NVo0bUZHUGhDcE1ORytYcnhrMzdzczNCQ3l0L1ZyWHQ4a2ha?=
 =?utf-8?B?MXdmMDZkU3hidmdjRHNmM083VUExMUUwL2ZhTHpJNmpPVnFma1Ivdlh6OUlG?=
 =?utf-8?B?cTNTYVFKNGtVaVY5bTZDU25NWGwwUEt6eEp4Uzd5YisvVVN0aFpTTU90OFdT?=
 =?utf-8?B?YnE3VDk1QnphQk50am5wOEJ2bnVIM3pKTlRycnZjY0czN0hua2ltWElONHov?=
 =?utf-8?B?ZDZhZndZUEFiNTN3blMxYzRRM2EvK3UyWUxSWFJabCtOTzRIS0ZnM0pwY1R6?=
 =?utf-8?B?bE1HL1l2OEpXR2xmd2hWazJ0NzZHcWQxdXRZRkhQLzAvSzZuWmJ5UUlSL3pQ?=
 =?utf-8?B?NWFTV0l3R2dmdGhManpLM0FaSm4vNGVvZ0hTdEtlT0s2ckVMOGFhNWdPNlR2?=
 =?utf-8?B?dXh4Ky96M25vaWFlaFRXUkpvNHVQaG01ckN4WUJzYlpBSWl3QnpaTWNRRXo2?=
 =?utf-8?B?OE51RXBjRVgyc2JESWZWbkVwdnVaWkhseGg3WXNhK21HSXhJMU1UenZFZW96?=
 =?utf-8?B?M2ZmQzhKUVFqMDlxWVZ1VW1QS3ZSSmxIQ3ZaNWdYazV6OUtQNVRNU3VNamZq?=
 =?utf-8?B?M3FEcDZNTmpvUmJrczBNb3RQRlUxcVFOZEhhcTdic2dkRlFtSXAyUWMvZ0M2?=
 =?utf-8?B?MHYzbFc2NnhkVmZ0S3pycmRqVkVEYnN4RVppMTVLRktzWU1PZVZFdFd1YUpo?=
 =?utf-8?B?YzNESWw1Ynd0STFmeXlEWUkvUDNvN1BTU2lDNmNEalRLUnF2MjBoTVc4L3RS?=
 =?utf-8?B?eTBMTzhGT3FodFVzcHd4RXd3QytuWk52Tno2eWR5UmttZU9UMWl1VTN4Mis3?=
 =?utf-8?B?NUNNVlRJS1R6TUVjVWIxNVhwOS9ZOXg2OWFrYmxPMEZwOE91ZjRVRFBReEMz?=
 =?utf-8?B?K3pWQjJ0bDZVZ25JM0FobnQ5R3dpd1JrL0FPSG5RVHJoWCtqbS95SjFKRHRz?=
 =?utf-8?B?VlM5dmFvdE1zeUhtdFZxOU5HZWVIeTdnTHpEcjcreG9BQ09TQmkwMUszdHJ4?=
 =?utf-8?B?eHF2a2EwZk1qaC80ckdzVEJPN1RzdStiWHhQOWpvQnNPUm56bVFaQWVDR1FU?=
 =?utf-8?B?OUpaZXZQUHdVSWMreUo4amY4b1ZBR21lYThpSmVPTnp1bDNISEs4ZVp5bHZS?=
 =?utf-8?B?MUdHdkdsTC9jRkE4TDN1ZVNud0xpWFNDRVJ1RWdWRFdQODNzaG5rb1MxY3dj?=
 =?utf-8?B?WHd2RVN5ZkYvbk9nemllM2JmRnk1RjJMZTk3RGQ3L1BrRWpmTEZTK2JqRXNM?=
 =?utf-8?B?VVJCVVJWcmdsdEhtUjR5UU11amE4OTRreUgvMFRDUjRGTWlJUGNtaEJpTytL?=
 =?utf-8?B?YnZ4aUFucjd1aUZZYXQrSGkxUlpuSTVPMnlUY1d3OHhiZGh0MldMeUJ0d3RQ?=
 =?utf-8?B?K0lybTZCbm9oaVAyZUZYZnl2WllFSUc1Mi9VZTlYSjVZVWxPcGxqK0lOSlcw?=
 =?utf-8?B?TUZjM1hTZWZjTG53ejFrS3M2Q2hSbnpsUlVXMGpoOUY4SWJFOWhEclZBWFdz?=
 =?utf-8?B?cDMralpMU3ZKa1ZjWUhYOGJnTkh5U3Uxa1hpTkdjcDBhZTNMR01paHA5OExq?=
 =?utf-8?B?Z1FFQWJCT3Z2RVJWcUhWSG5ya0RrQ01SdzFyN3IzdWlaNmQwYkhBeDRkUncz?=
 =?utf-8?B?bWg4bjVoVnU5bk1sN09QRDA0RlJDZTdkemZ3NHJlUjRUa2hRVlpSN2plaXVU?=
 =?utf-8?B?MEMyRTVyOWVjRWNZUll6MGNHclRnTk1YUUhmVUdtZU82ZDY1WW1wUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ac10ce-8a2a-4a59-d4ad-08decb7b2931
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:44:56.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdsSCDnC6PD8qEnIObTEJrjJuEdZLybxNLIXk6VxOLJP0w+ieQFD+kn20OBdZpab5Pz9FuQauzSpEL5vy7Rusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7392
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 07:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23152

On 10.06.26 23:27, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> This revision introduces Rust recipe support, various
> testsuite improvements, installer-related fixes, and
> adds support for the Debian Forky release.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 4d47ea9..38d1d62 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
> +    commit: 8893ec3ac0e7d64951da008404df0cbda9aece37
>      layers:
>        meta:
>  

Thanks, both applied, this one by pulling two extra commits in.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

