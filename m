Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D74E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.70])
 by mx.groups.io with SMTP id smtpd.web10.15576.1733934799330822209
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 08:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tttGT8E7;
 spf=pass (domain: siemens.com, ip: 40.107.21.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpvIsZ5zfbIIBaSh66aRI2c7WdpszmxQGAjm5D+vAh4OLiX5VXUawtwyt0y99oVXOR1A1pzt3Wd43ri6tyggTFZ+yb/HWvFDX9zGo6S78+3KNij+IK5dKFFaDqhvZ+svUqxBuBOnwzLhxBo+ufNBOo1n+ZsjxI+XHOEySI+M5yYAwP/vYmsWQReLTPG3sWCPAeYddv2t33DtQaYLvaiiGQnL6/MF+jho38MzcU5CGTMOzhIu20xhl20j0Ppl1432yE0POGJiDomfeHFcs1VrdJd1KEng5u6EsZ84jLmPEXnXU+CiSaooGoTixo3o//I4NCG0KpLTYQoWoHus/sb4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3oc2EwtlJ6tKqhJTkvWvC4E+4PE7eeIgWqI2qcF2jE=;
 b=cIVvF0+hWdPrPeswRbloTGBlen3bkkMILvLU/pXPLwasnyMyl6cTgGv5TxHSzcgKqky8Vy7pnZxoyFXnc8AeABF4kRfR4B6lf3V6XvE5pyGwoUHn/f0ff3yCgXj7JLOTbgAB/iyHl7+YU9LvVDLm/p1s3HbAL8Uaj8Vi3aF6SGbmS2hCwJH3ORczpMzkcrkl10xEP1Ai8v9RxLsTeFCZkdsVLy708z9JIUPMRrKZxnMCRejAp2U5yCuedcrmW+U7IiQwOMn9evkHIZxG4uf1ZVaBqwvjOG5Ffl3nLTxeteJKcIlOA46DqRaV8Qk7l+g+WG+xcP5+HKNP9p6fLmVeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3oc2EwtlJ6tKqhJTkvWvC4E+4PE7eeIgWqI2qcF2jE=;
 b=tttGT8E7v6Wzg6FedYPHCU08laEqDUbwdGPfziwNnd1WCPIauky9bfumR/JFSybjc59i2O8MVcxn6zjTwdqOfCQ8ArnCMNZX1gEwWWCLHqHLrUPmhORuSe0fvrhtNUsrdLIJeCXGrDIxFHc83ovjD8S8WhnDYJ2EW50S+jeOaQ10LXDiOiMpQmksH7EBhNi+A2/mqM1TVngLfBmkjqyuzVT7uuYN3tBGDAooTyvQrrB3RnkQ0RIKlnNQrhXs0xvm5fTSLbX3uHEu1/xQQi9fw4bITzRvH5dfnPuqsAZR6d8bRV0RmtPSbe12Ygh1YZauFj0XzArDrYkWyCffhnjYww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM0PR10MB3652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:33:15 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:33:15 +0000
Message-ID: <9925b70c-e8ce-497b-afa6-f7b871a789d8@siemens.com>
Date: Wed, 11 Dec 2024 17:33:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv:
 Switch to cip_merged_defconfig
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
 <20241126151751.1747275-3-Quirin.Gylstorff@siemens.com>
 <5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com>
Content-Language: en-US
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM0PR10MB3652:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c164ca-e807-435d-fde9-08dd1a0182fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3ZJWWJmMi9OV0RHb1ovVWc4bkFBMTBwTmVnUXhkbVhPaWdNbzJjY0tPTjhu?=
 =?utf-8?B?enFDd2hzdjdPOEpCYmY1aFhTcFpFRUZXNHZuM0pLR3k5eVNKdHdEU2NpRVky?=
 =?utf-8?B?NzVLWE5sbnIxVlgzc3A1RVJYSFcxYXFHVmlEMEV4THJuVkcwT01UbHJTMVVW?=
 =?utf-8?B?dkZ0eWo1Zy90UXE1SmJkaFIyMzRqb1Q1d09UdzFzZllYNzZyb2ducEtnVTcz?=
 =?utf-8?B?RUd1Q1Rra201VWg0QjFhaW85UDVyTHgyOUgrVWlvblFMRkp4bzNEV0tVenQ0?=
 =?utf-8?B?cm5kekR3eE5RVlJ4SUpUVkp5aEhjc1l1M25CdWpoZ1ZNUThyYTAycGxZME9t?=
 =?utf-8?B?TFZMMTdNRTFFeDdVNGRQejJHc2Q3Vzl1OGR5YzVXSmU3enlqaXdEcnFzQ05K?=
 =?utf-8?B?d2NwNmltUk92WHc0MVc0aFZUcWlBOTBSMjBpd3UweG03eENQQThuNUVsZXJM?=
 =?utf-8?B?T0pQbVpxZUhmUTExV0MwUEMydUJJYW1ORmJESndZbnVpTUpWY3dIWEY4VVlO?=
 =?utf-8?B?WGpUS051M0puRCtRRzRHVElvWlUzSVZPNkhkVDNZTlRFS2NWZHJEWHdzZlpO?=
 =?utf-8?B?SHo3N3h6MWVzME51MFB3TFVKZFJzejBNN0pWUlp6VlA3eHB4REtzNXBrbFo4?=
 =?utf-8?B?Y2tqYkFZYmZXd1RzT0ZVamFmdnk3d2NQeU83elNWVitrcXZTVzBiMi84ODFX?=
 =?utf-8?B?MG85QlhxQW9DclArL3pydzlaV3RwZTg0Q09DamtYaSsyNW9qbm9rSWtEY3hq?=
 =?utf-8?B?K3J3OVcxakVZcTdBeVM0c2dYZ3hMcUZPZVBVV1N5L2hoVEZWVERoNk5yZkNP?=
 =?utf-8?B?OEVFTmtuOXNuRERDYmRJYmtZQVZUR3JzYjV3aDJzeU9Za3lrSkZkTGp2OGQy?=
 =?utf-8?B?ajZ5TkhWWUpwcHM2M2J1NVB5bjROMm42c3BwZDQ3R2o1dEtZcG50TUhGQ3Fi?=
 =?utf-8?B?TU9VR3BYRU9wbjAzVUN2ZGVFTlV5UnJUTkFLYzlvQ1RjQ3BsZDY5UG40VThW?=
 =?utf-8?B?aVkvZStsSUQ2WlQ3TVAvUXhQRERWakQ4dTBYeGxsZEZvSDhWcVIvY05UaWFJ?=
 =?utf-8?B?TnVnSjBON0VMWU9IUUlyamNYVmtsTDRYYnA5U3M3SnFJb1F1Z080czRycEdX?=
 =?utf-8?B?Qm5kakJESExlOENuVnpOUlFnSjh2alV6dlNhWUJ1T2dNempRbUV2YlhYb2tV?=
 =?utf-8?B?cVpNcWRncWtUS0xnU0tBM1RxNk9hMkNaN3ZBY1BOelJsUDRXUTM5bjRSV0pJ?=
 =?utf-8?B?NkxvTG93WGlXQjRyUzQzZmVhUGlNaDhUNG55Q0tNRE5adFRZcEx2MUwxOE9Z?=
 =?utf-8?B?ZDJDTEFsak1IMEdBSTBTYVgwdU9sQzVIcTR6TE5sTEY4WVExK2wrNDdjTnFt?=
 =?utf-8?B?RG5JR0ErdUZQZFpZWitPT25YVEZwbFJuUG4vREhSWW9tMVR6eHdJdmh4ODE2?=
 =?utf-8?B?YUdhZG5vMkNPUjdUeGt1R1Fmam5PcG1xaS9lR09meVZRaXg3aGhKbG9iVXJK?=
 =?utf-8?B?cDc3UDMzRjF0d25WNStJNk1JYlRsK0NESjFBV2RpcG1UVEVLd0doOUl4NFA4?=
 =?utf-8?B?MjVRaUFuNFlxTDZSU09WMk4zb1gyOVRXaUR1WWhNL2xjaStobEk5aCthVWpH?=
 =?utf-8?B?SVQ3Yks4d2J0ZUg5ZHhoTExMczBsd1NFTDhjTjlYRXJxMWFubXVaQTZhL0pR?=
 =?utf-8?B?V2ltcGNiQlA3UGt0OW9Bc1dFNkYwUFo4T3pwdUxveDhoalpOMkkxNi92TkdW?=
 =?utf-8?B?dFoxMno3UmV4czZMc2VwNHhoc1VGNm83K3FrWmJzYm1yT0tCV1ljNWRPR2Er?=
 =?utf-8?Q?tKTaOnZqfTilGB2PsOFUO1T5OmtGe4duH2snM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUZJaHBjOGdTelpsNGxib2ozY1RHa09ZRnR2bnZUYm44OTUyL3BzbkducDIy?=
 =?utf-8?B?UG9TRGdhQ0oxSVMzenJHbU1XQUpNTVBsbldYQWZnaUZOY2RrSUJ5VEZhdC9r?=
 =?utf-8?B?MmJwT3hpVnZrMlpYTUJzNm81NzVPb3l6aE54cGVXekFCMGtuZ3Era3RuMi9Y?=
 =?utf-8?B?QlNtdDV5QUpYVkZvRkJSQjBLcFM4TktSWUJHd0ZuNVJlREVhOTBXbTlQU3lY?=
 =?utf-8?B?ZWZIOXRJVXBYZ21oZ1puRGx3ci9xa0RQeWpJbkJrVXFYbWNnYTVXODhhMWdG?=
 =?utf-8?B?MUh4Tld4djI4QWlFT2hxZGxpa3g1RjVPVUE1empDb2pIZm85eUJUVXNLMFlV?=
 =?utf-8?B?c2FpVHhwRUlxbFlsb0VPaE9Xa2xjYzdEanBEeEVkanplMWx3Rjc3WmJoSnRX?=
 =?utf-8?B?eTZDTU1sWnhmdnNuaUc5RFFtRUgwbENoekhFUFJvQVRKczlKK3FSSmw4QU1K?=
 =?utf-8?B?UmxzRC8wazFidDg5Z0JlQ0VFQWpFL3cwUnNDeTY5SXhycGNSdUZzeGJJdlRq?=
 =?utf-8?B?Q3F5aUg3N1o0cU9DNWV0RVdPL1FvSjdlS0Jsa2pnUHQvZC9PQVFxc2FDaXNt?=
 =?utf-8?B?eFVoQUpPWVdlWnE0WmFrVDUybERjQ1RTZ0tNcXNVZVlUKzhDK1g4WXpsSjA0?=
 =?utf-8?B?MW9YRFRqT1NYVlVRTjNrTUY0emhTK2dYTzJKYzd3alBzRU1uUGxCd1NLSTRq?=
 =?utf-8?B?UGRCRXREMElKMk4wbGg1RDc5eHNxVFFuSy9OKzVjZzZLbXAxcjlrNEprdGtn?=
 =?utf-8?B?UEtWMit4eG5DVmR4anlWcEVkN0dUZ2tXRFZNR08yWUZRSW9ucytkZkFDU3dl?=
 =?utf-8?B?NzkwVllSZGwvbmxFSGVoazJUa2ZDM2JJL2pwYk9KZUJqdkpNN1lQU3gwNWx2?=
 =?utf-8?B?ODFqc1JuMDFMM2VtL1pSVmNHdHhXbjdVcUkzQUNoVnRFT2dIOHNUYk9vSjBT?=
 =?utf-8?B?YlBRVzhUMkUycTFoMXJuQVF0Nnc3blh4T3JBendYQURiaHlZQkFWTVE3N093?=
 =?utf-8?B?Mi9uSlVmcFBhTVI3UlJsYmJOOFJEc0MxR3VROXhOSW9MUWJlcVJIc2JacVZC?=
 =?utf-8?B?aDhMODRPdEF3cURVNDRPdHlVWHZod2dGQmx4L2RpRXNidzN0S0RmeHRxZ01N?=
 =?utf-8?B?N0QzNHJoUHNUOHhGZ1czZ3J6VnYzRmZJMjVLc2Y0S2JpbHU1anNlNFQ2M3JN?=
 =?utf-8?B?NU44Z2ZqbnRNcVZmVzBWaDdDcVgyRjBoT0FsYUNxMEExQk0vUnRzajZmSUly?=
 =?utf-8?B?cGJyaDJBU3FCOTlmMDEyRTVxVmZSRVN5YUFHUnluVnl3MjRzUW1oeW53NTd1?=
 =?utf-8?B?cjR0V1RJNER1Q3g3R2YrSy9OOXg4ME5rWmY4a1dVSGl0TFU2cVEwZ1haL1F6?=
 =?utf-8?B?YWdiOHQra3J5aG1uVlJiaWdoNjVXTXMxY1Y1TWxQcFNRZENMRzdTVmU5S3Nq?=
 =?utf-8?B?VXdVdWNjVUhDQnhtZXdOWXRPUC9YYU85NFNSL3RPRFJpemZjUHdTLzJNWGNn?=
 =?utf-8?B?NU4zaUE0eGl0QUNlRDR6QzhsaWhiU1ZYL1JVd3dTekloRDlXUmcvS2lTZ25S?=
 =?utf-8?B?S0pRcVlrbzZqZG1wV1BkTTlGOGx4OU8zdTV3L2hkUXVBTHdEMi94NEJ1SG9M?=
 =?utf-8?B?WnpzQnhDeDdEUEl6cjNzbi8vUFcvTXJIOExtOFJ3M3FTN0hRQUREaGZsS1pz?=
 =?utf-8?B?YWZhc2UvTERrTGdvekdMVzltOW9KaTI4aGZUZWNkSTNoQmJHbXB4YTBtdUYr?=
 =?utf-8?B?QlBUSkQ3bFQ0MkxhcG9RL2FYbHl4UXZaV2RnWW5XVGRmSXF1TVhOQXpleEVU?=
 =?utf-8?B?TDg0WGdaM29RaW4xdjUxL0haaWVITC9ubjFpUnNtc3hFTWY3azB0QjQvU3BR?=
 =?utf-8?B?YTNtTmFjNlhydXBKNWsxbTRaYWNjN1J2QUpqMVprM21ZQkJTZE14N1pyWm5h?=
 =?utf-8?B?Rm5nVHAxWEFTRHA2OHBIL2ZyNjBFRkNFa2czb0tIU2E2WUN2Vk9ETlBIVkdo?=
 =?utf-8?B?N2ZmVTEwdWNabDlaNU9GN1RTMDA0Mm4vMGMrQmJ0WjdyeWNLTWdSK3NKY2Jv?=
 =?utf-8?B?WmJaT3E1Q0gyODhkM0psalp6eHI3RnlqUUU5NnlsbkRoUlZydks1RjkvZTJN?=
 =?utf-8?B?cUgySjZxdWE3WXlDZndqeHlvdXlFdjRnNUxydUJCdnp6Vm8vbUxiZTRNSzQy?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c164ca-e807-435d-fde9-08dd1a0182fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:33:15.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY9e1GSTQcIvBcro//DnggCVTVMsAPCZixrtwtwPj+kpXx+3O2395TDw03a9tZTroXe/DUeJACMPLbqRFD6tYWrQFisQ/gp1PmHcz1pwCqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 16:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17406

Hi,

On 12/8/24 18:30, Jan Kiszka wrote:
> On 26.11.24 16:16, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to pick up all common features someone brings into the
>> merged config, like we already do for qemu-amd64.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/machine/qemu-arm.conf     | 2 +-
>>   conf/machine/qemu-arm64.conf   | 2 +-
>>   conf/machine/qemu-riscv64.conf | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
>> index d2dd81f..17c0883 100644
>> --- a/conf/machine/qemu-arm.conf
>> +++ b/conf/machine/qemu-arm.conf
>> @@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
>>   
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
>> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
>>   
> 
> At least for 6.1, cip_merged_defconfig lacks CONFIG_AUDIT, causing some
> test case failures [1]. Did you rerun the generation for all archs and
> versions?

This caused by enabling OABI_COMPAT in cip_merged_defconfig. OABI_COMPAT 
disables HAVE_ARCH_AUDITSYSCALL which is necessary for auditctl to work[1].
This option was originally introduced with commit 
e28e124c4b0bdbf9d9552a3ee77ba29b4247f86f (arm: Add config and sources 
for Beagle Bone Black(BBB)).

@Nobuhiro - do you know why the option OABI_COMPAT was enabled in the 
first place? Also, can we remove that option from bbb or only from the 
merged_config?

OABI_COMPAT is disabled by default [2].

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/Kconfig?h=v6.1.119#n82
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/Kconfig?h=v6.1.119#n1269

Kind regards,

Quirin
> 
> Jan
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8580918327
> 


