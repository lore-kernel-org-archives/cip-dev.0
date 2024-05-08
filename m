Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA41C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 16:03:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.85])
 by mx.groups.io with SMTP id smtpd.web11.749.1715184223971804846
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 09:03:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OSnBT4S7;
 spf=pass (domain: siemens.com, ip: 40.107.20.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhE/ZX8Iw2cfBVS382nQmEy18HCPdfyoU0/LipizxZe/bZWiopj4uis2Fno4LvF/JKUmD4CmyEbv/FA4eB3O62BjJxRSuzMp+xSGPAxky6yPY8oHJoZ7W/WlqnK+qc0rdzWSJFfgpzF2HxUpKpyZODkzlJBUuZDsu9YnHdIibCdfmj7dx8leZQd67O3kUliMgdldxR0yL8dLeV0aTyVFGgKDtX7SwxQYQ3k7mlvnFke8LKOJC1fzJ9FWltQpU3xNzsS0QqtOS4VRmmrsM5neNZ1Aa15fZ/myKni/kIxMLRP9vjzwuPhWUYMnwSUG4ZuhW4DdqiAVRwfj85MBJdsnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY2JE7m4Hn5mtS/HTW/tDyj0jApi1/hr/DXYrB+xJnE=;
 b=fEQF0qJpEMbir8IL83Oo3TLlkRZ/8fwdYmsGDNNn2OXZjLkGyQwfQgjpCI9JyrIFJz/CI6xCvbKI5bI1+LVegkgnw/ctO7r2a8LLlLosAWqu5agDp+ryW8+C4r/gEM+fKbD29gtcRi07acULWCImHLADiFngoAu6idrvimX1Qv5Pcdm2h/XPEYnExB9qCWIzvB43QJcr86bmCQSjnBFiLmYOhLMXG+qG5L9aD2WOCvIoK24mAhrdQ7dg2kIjAOoCEMiSDkDR/3qWIIZUNI85TTcefFH1QJJ2sXiOkWuFFNDOFLwgyC9fq9u3HJ1WqcEgcIKs3Te1D9fbV54htURLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY2JE7m4Hn5mtS/HTW/tDyj0jApi1/hr/DXYrB+xJnE=;
 b=OSnBT4S70ghJqZczlUr5cqUQF5yXI3my445SSVMQBbPaRLdHitdwTBTz86XR++BuVuaDn9JnC2Adosqv/tBS5Iu7qXXvqsaOW2vKsK7a1Rrk1Bebxql43HxB1Wv43E09Sd3GycpXY3Nuw6yX4xGsqyJH2knuoeBZG3mG4AVg63VMtlmcTird/OKYbSs9cYy7cs+Zi04/AWYVzoMtpg/yh5xllTTS6s27VmkfX5iWsL1NQSxUneUEHFit0CS3enhOMjmwXq0mM5mIgS5w+Qy/egpagLTDwtN34S+wkcAUDZZOq6vYLbBrupx5g5qfT9BmhizujddnubBnE43DU5i4cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 16:03:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:03:40 +0000
Message-ID: <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
Date: Wed, 8 May 2024 18:03:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Generic x86 kernel configration
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "Schilling, Benjamin (MO MM R&D SYS SEC)" <schilling.benjamin@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 36306fa3-0ea6-4a52-d172-08dc6f786db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QitoamZlSkNNbThRdWk5dFdkbHRrVy81Yzc3ajhkdHdvbFZNRlI5WmxscXJ1?=
 =?utf-8?B?akoxSWZZdm5pSElqenY2MkFHOUVzNnE0M3ZjVTdrTm1vWlhHVWtrZjZRQ0c1?=
 =?utf-8?B?eVN6U0xQMEdCZXJRTFlXL3B6VmhFWGdJalZabytRbEJHdEYwZmpDUDNVV1Ay?=
 =?utf-8?B?SWxPNDFkbi9OK0FLUlNMcXdJNi9FSWxVMVNDeVpjeTUvZTlVNDFSS2R0UG5I?=
 =?utf-8?B?R2xOYU5kbjRhSzdHRlAvVXUxVU4xd3dnSkdXU2FpRE0wSkw5dG1NbnB3OUFq?=
 =?utf-8?B?U0JLOEEyVk5ac2dnZGRCb29pNWVyS3RTWnNZbHQ0Wi9Sa0tBUjE4TStWbGRy?=
 =?utf-8?B?b3pkZnFaZmhldi9LRkZTRHhIbHE5bGxJMWdNZEJFdjBGbW5qaXRSNFRHL2U0?=
 =?utf-8?B?Z0dtemI5Vm5xUzJBeEdrdUl1a3RxN1p6U2VFNXVkU1hUWDFGUW9zeWxEazcr?=
 =?utf-8?B?TS9wbWNTQVd0V2l0aEdRakptSTlpMXo1TnRVVEhBV3NxZ3VhbUlERm5wK1Vy?=
 =?utf-8?B?R1oxVGx4K2JhM2FUdHpONk1PU0czVEtlS3N2TzRzQXUxYXd3d0NDcStucTRJ?=
 =?utf-8?B?RS9adTJUR1FjMHBreVZGeEdDYmtkRFM1Vkk2WXpmU0c1MElGREp4VXZoNFQ1?=
 =?utf-8?B?M3k1Y3hxL3FDZFdPL0xFMEVkdU1LcndpQ2NnVllURk9DTVlwdXdkcVIzbUc2?=
 =?utf-8?B?L3p2dmlEUU9YSXBMeC9HWlhTTDNOcUxSWUlkdHozQkM1M3dIK2NhaklWbW5y?=
 =?utf-8?B?U0tJM2c5MHVpMHN1dElSd1ExM2JiZ2xTTUw3NHhJejFJS2lSOFI3eWZFTzRY?=
 =?utf-8?B?S2tNSnhmdGNUQ3ViQVpueTNna2RMRnA3WkF0N2g4UzRyMFQ4YmxOYXZoMTM3?=
 =?utf-8?B?MGVYbWtiNDRWNmhUOUJYQkpnVWtVTTVNTSs0dVNVbFNYZ21BZ29qbmhlM0hz?=
 =?utf-8?B?aVZOODhKK2thbUtQWlNTQmYwL255aHR0UW1CeW8vMDNobkZuNFkvM0ZxVFZM?=
 =?utf-8?B?VE9lckp1WStLU09PblMwS3ducmR5aUNCMnF3cHhMK0I2S2JSazkxME53bE4z?=
 =?utf-8?B?NTJCcU9yR0k0WmlidFdVS1VxdFVJQ0oxeks1dHdNZHZnQ3BTckJVSUpGc2ly?=
 =?utf-8?B?dTEvVUxISWpPNk5IZFFleVAwWnJiWk1RMDlHQS9JR25YTW96RmxwdkUxREYv?=
 =?utf-8?B?dnRRUGtkSzJ3Ui9OVnVid0hWa2JDbUNlWFBZVFloRjBxY2pzakJwWXNReEdF?=
 =?utf-8?B?cmF1NCtPUlFVUlRFMnJXNGFjMzdjZDlYcXNxT2FTU3pteXpZWjNNK3FMeGgz?=
 =?utf-8?B?aUpyRU5qdFBIL3JQTGpRdTF1Nlc4cXdLVXZRZlg4SGUvaFoxQjZaZENEWExw?=
 =?utf-8?B?MURydlRSbDFrWWR4d2kwNUpoVitVaDJZbmkrOFZZVG4xcVRMeUNZSnVkd2lu?=
 =?utf-8?B?Yk1pemJ0K1ZIZ2VWWHlFYjZrY0EzelpTbWJZNkt2Z2RHZGxhL2FVY3hMajNB?=
 =?utf-8?B?Sld3NGFKa1d4Y0UvTTcyMytkekcvS3Q3d3J1QSs5endPcHc0N1BXeEFqUCto?=
 =?utf-8?B?cVhhblNrQ3d0STR4S0ljaXBMSk1tZ2JZbXNYZVhHK2h6U0FmYlJiUmJqVHVS?=
 =?utf-8?B?bmVPN3pvZW1OdHZseEI3d3hJMHZQMEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkNPamMyQ0phRStNODJpOFZoM2R5TGZNTUJ1ODc4MGszS0JQd3VCM3hpOG1k?=
 =?utf-8?B?clNnT2d5TzM3MGcrdzhaamRmV3JTVVRCN2dVbjhoM0ZhckNuUDJ0dFg1MnFX?=
 =?utf-8?B?TUhocEpHNG9JeEJXTjd5eGIvRmQrczRNdEM3UVJqdTlxMjVqM2FGSWFHbzBy?=
 =?utf-8?B?cmRMVmVQTEhPVnNPenlKQmF3NytYZHVNOVYyK0xPNFZKSU9UbTgxbUpCZHNt?=
 =?utf-8?B?dGkrVEF6SWdYNEFZcDFPNTUvK1NTUFpXQTlrY1ZERE5JMis5UXBnTThjbTF6?=
 =?utf-8?B?TDdBVWtHUmdQRVhmTzVLa1ZKUWsvNFJmTDZwOXQ3MnA1bHpqd202NnZac3ZF?=
 =?utf-8?B?V1VseUpLRm1aNm1maGlKaWd4VFNmMjR3d3BkWDE0S1NnZTdXS2pyZmg3cDlF?=
 =?utf-8?B?VjQwdi93MkdSQlVwV3lPazZOVDFkNXIrRXdUUTkxb0g2R1k0cG0wa0pGbUlN?=
 =?utf-8?B?eHREQnVreXRmb1B6NVp4NE9INnBNZTM5VHpMNDBZZDVnRGxZZGF1S0hDUi9F?=
 =?utf-8?B?RzU4TjN1TkJib0dHNlc3N1A0ZGNVM1FGdFRySDNCRGhqcE56Z0F3N0l4REVl?=
 =?utf-8?B?VVBTMnRMMTlZdkNvMkVBbko5TTNvUkZDOGdOMHF4aXlrZm5rcy9wNWhHT1Bn?=
 =?utf-8?B?eHU1T1FHYktoZm9OTWtJRCt0M1luc21BN21NYVBITW5Pclp5NXcrYjFpOGZw?=
 =?utf-8?B?RHJlYWNVNWJKb1BQSHlrQm96UjdlK3lwZnNPU1d4Z0ovVkErRUVIc3A1Wkk0?=
 =?utf-8?B?dDhTUlBkaVNzbjgzRDFxaVZzaGViUkt0OUNaTTlvOXRqaVFnSXJ5SVIxeTdP?=
 =?utf-8?B?OXZVM1ozd2pQbkVFTmx1L0s5Qm05SGY0eXE4MnVvemZPamp4Vm1HekJibFBt?=
 =?utf-8?B?MlBISUlJUlBaZXE2UWoraWZKSzV1WGJQenR4ZmRVWk5RcTVOWmx5bHZXODBo?=
 =?utf-8?B?cW9FRlZJVHA3UUE3OWlvNnZCUWQyblk2TnZIbVNPYzZOVFNsM0hpTUdUZWlv?=
 =?utf-8?B?ZmJQV1J2eUlYUDNpdWwwbzJBbkFiUGhxRWhtYjNZV1lxTkhxMnF4bktwbTdJ?=
 =?utf-8?B?NkJMTmkxOENRTXVyWEdKbnVVeC9mQkxodjNrT0NXenhBY3NBWmZFNDNXMWNu?=
 =?utf-8?B?MC9icHZzSHd2T21Xak9qeFM1OXNNV01ZUlBvNzNCbWtOOVJoSzFQOGpHR0Yw?=
 =?utf-8?B?aDZsdXdZWDZRYURYZ2xsQ1R1WWtGNnZ0dldWUThhdjJzVjBZMHBRNysvVkhJ?=
 =?utf-8?B?Tjh6Q0dsdkpVNk5sMkREZS9VUkhoMnQ4ajAvdFdaQzlVRkRtMHFlSzZjOTVF?=
 =?utf-8?B?ZkVRMTlvTVZtUFNFUUd4dEZ4a1MrRW9BZTl0dTBjZlczZE54bVJFMWR2OCt1?=
 =?utf-8?B?WDlhNjQzVkx1dGVCakZLVHNUc3lzcXZWVmN5UDNIdVV4SnBDQjZkTElseWhn?=
 =?utf-8?B?djBYeVh4NEVPb1pGaDd3SUNiVStvaUh2S3ZrWFZjbVJtQ1pPTzdjUFhkZFo4?=
 =?utf-8?B?dHFrWjJPWlVCZFVBMGlMUWdPa2JRcU45SFRVc2tzd2hqQ0g2cElJZW1iL0U5?=
 =?utf-8?B?NkR1c0JMb3RHcW9TalVYSm0zd1ptTE1mbE5mL3FjNTZ5UzBLQzFEam9pRjU2?=
 =?utf-8?B?blJJSnlxRmJsalMzaDJZUmRDRlhtUitNRFUrZHBoZnIxQ1IzTG9zanFxLzNy?=
 =?utf-8?B?N3NmbXFIRFF1aEFWempaSUVIWnpuWDB1VHJpNmJKWnVxSU1kL2dzbEFMT3lX?=
 =?utf-8?B?Q1dHMW9XUGZKaGJMMWlac3FQdVdkVGV0OGpSUHZ4R1Y2K1IvR3R4emxRMnRW?=
 =?utf-8?B?b0xXMlNLRDYzTkJTSmJ4TmZSakNRUVBtTkFSckJzTXpCVzhvUk5FbXluQndW?=
 =?utf-8?B?RUdNOTVmaU9ORHRKcTdsK2tiQk9UNU9zT2luejhUSUU3c2xPd3F4NUhzWTR3?=
 =?utf-8?B?WSthUVRxM1RDZ0IxSWtwR1lFenNaVnFIZEpZTHB5aEo1UHZ1M3Y4SEJvZXpM?=
 =?utf-8?B?TEJUMm4zOXAxTHNKMzVlbHpyamd6enBBdmk3YVZaM2FKaU9ZTVVXeWcyeSt6?=
 =?utf-8?B?N1E2Q3R2UzJMNXJhSW1sL1pGT3J0MHJzcnBOaEhIWnFNTlZ4ekdsWmxuWGFP?=
 =?utf-8?B?M2ZhK1JHYXNXV0tEdEFHVXhvclhpYzdZVlJNdzZTN3NzbzRvbk14SXE2Zjhx?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36306fa3-0ea6-4a52-d172-08dc6f786db7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:03:40.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dUXZIM1B/2wfgi7Y4CxmoZwsp4vxY33/HEI8m1X7LSRAIqNG1ZsmmqOH1oY89KOdYWlCj11hgMJgkTMyxwDLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4100
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 16:03:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15863

On 08.05.24 18:00, Chris Paterson wrote:
> Hello Quirin,
> 
> Thank you for your work on this.
> 
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
>> Sent: Friday, May 3, 2024 4:58 PM
>>
>> Dear all,
>>
>> I have used a forked version of [1], which you can find here[2] to
>> merge the following x86 kernel configs together:
>>
>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>
>>
>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64.
>> The next step would be to check it in the cip lab on the real hardware.
>>
>> The script takes the Kconfig entries of the specific kernel version into
>> account. It also adds all dependencies to the config. You can find to
>> log of the merge at [3] and the diffs to each configuration at [4].
>>
>> An first integration into cip-core can be found at [5].
>>
>> Any comments from your side?
> 
> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitLab CI setup using your merged config:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476801
> 
> It built and booted okay on the ipc227e.
> However, it didn't boot on the qemu setup in our LAVA lab:
> https://lava.ciplatform.org/scheduler/job/1129968
> "This kernel requires the following features not present on the CPU: movbe"
> 
> I don't know if that's an issue with our qemu setup or with the kernel config.

The CPU type the kernel supports/expects is a choice. I suspect that
merging multiple configs shifted us from "works with generic x86"
towards "only works on Intel-whatsoever". Combine that with a
restrictive CPU type selected for qemu/kvm, and you get that kind of error.

We should likely tune the common config for generic x86.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


