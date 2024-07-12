Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B12C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:40:01 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.73])
 by mx.groups.io with SMTP id smtpd.web10.4031.1720777196171551711
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gpw5ZnmU;
 spf=pass (domain: siemens.com, ip: 40.107.103.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFlFcdkfA4TD/jY5EsGWRcRi+MHkfG0P5oXKhRgW4uWad+ypVK6p3iMatLjuqZhjKShx4c/rUtlINKWsBYzE9McSyl0wHMFl8EWbBiDmzaRW7OTVpRHflNc0x8HqmZl2SVUUTR80d6bVYJyUSFrXyKptBA0pfPTp32al8pbdL3B+QcnqgFm+qCHbJvP1E3UoAuBIStZtAcXDyIW2fpIOLTEXq+NqRB55TW2hw77c10VnL1LshRo+NpMb8Ae/xrRZZzdUeN3mSIZc+L8dEEFxRcmZ7muiU3IFyTaFl0v6/LBS68oKnDc38YoOd3vLGXtE6ix7Oy0g+2F1sU35YMEPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBZfXQJczl5hX+TAWk0SN0+dNr6Nre41qj6v+ldtB80=;
 b=mNK7RMtQ8FlaQYIrLCJBbbAPrRPWgVxvR0DPGtENeNL0rgx5T+LS8iQN7Z3O/bsxH08mhIDM9y1QcGwqvVaggnNRQZRWZZZNoffYH9eeAFm8Yn+ubfBtcLqm1VoVXY7M9a7Yz+Nmyklq30cmSatYpJUaOvK2JsW45YLIKM75sxLU4IZ/IWQdSzzNNP1sLDIXv2yqQ3+KUnTFbg8kO6f74YH5A6lr4QuGAtUPyyzVFC8ZAAwYXbdiiBFmTGrpgr5vK7xnZjtU9uVVHyTGAOCsdHGOL8Gfe4PISxQesCUvy5YGwqaUAvLmF+jnW5riCJXGaqfezpBYZ37EGG9LLdnNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBZfXQJczl5hX+TAWk0SN0+dNr6Nre41qj6v+ldtB80=;
 b=gpw5ZnmUKxrrio+zZ0GX1DcyHyHP0mOoVr2Xkv76jq3ZG2S1kcu6hactU9qiArDcO0XTsNEjeRJwZtTBheQmhxD+FcuytbwFg8mjKNtbZIGsGuaqsCB6t6cTjQMyAqEvE2ANkn73zqFlcxzH6mgzR0jp86/EniKYXZ6Q4V2gDeZaYZuH2SUtkBiwEXZXOp4PK/8P6hQBxxeJkUtLo6PFQgZquz15wcchLfBNJAWI4/4riPjL53AoVUvyldhYQXFmZoA1/+ddi8EdbaulTUJtZpcQRjAyD8Q8kDrKMkbC1bo6MD6CJOW9mo2XxRHQBrDiDB7g4HCAnrv0mRI/zlR01Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB6864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 09:39:52 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:39:52 +0000
Message-ID: <25ad90e9-37a8-4b01-9c53-81251dcdaba1@siemens.com>
Date: Fri, 12 Jul 2024 11:39:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 0/2] Update docs
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fb71c3-e16f-4eb0-d84e-08dca25694a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c0xrd2dNOFJCOXIvQVJab1BXbHZRNStNTzl6R2pjbDhQdVVNeldoekRpUjhX?=
 =?utf-8?B?WnJCWWRMREpDWFowdmE5MlFlRHNOKy9CK1JFd2tlVlBjOUtkSnNZQWpwaW01?=
 =?utf-8?B?dHNCZUdoRGcrWWRCdjRHNU5LbzhMNkE0QzBUV082REs3TFJhS3pOWU1xSW9h?=
 =?utf-8?B?ZE9KWlZJdFpRNURtMEVMcTRReUtlSzlKa0NIc3FlUTNOS0QwR3JDMUZNRHFa?=
 =?utf-8?B?SzM2bWhUcVFtZGU2ZUJ4aktOWmtvQ0NGc0wwZWpJdmRkSHdTbWJxSUtKV05H?=
 =?utf-8?B?ZXI2eVZDVnhNOTF6ME1VdHFjbGlacjBQQWpxVkUyNVh0citGc3JwSzhNRjhM?=
 =?utf-8?B?dWZRZy9MNGx5Z0duY0NxNWhDZ05Bd1NhYW1maXJYL05FSU5wM0FEdGlsemZt?=
 =?utf-8?B?RFJUM2ltRTNNN1Q2K2JKVEUycUE0b2laYlRxblFiL2g4Zi8xSnhYMyt6V3dz?=
 =?utf-8?B?QTYvTXgzWVRlanV3cTZCSEFOc3krWjZ4aUNnb2JzNWM5TGU3NERJLzhCeWt5?=
 =?utf-8?B?MlZ0c2MxMEg5aHc3Yjh6cEViZi92dlAxWWdVck9lbnFSNDhwVlpLRWpocEJC?=
 =?utf-8?B?aHM1clBOVFRNU3hodlZqSklTVWliTHh1eEtkQnY4S0I0K3VxVkV4YVgzSkQ1?=
 =?utf-8?B?NmdQakcycHY4VStKVUZmMTFycWJiTGM5aVRsNlJxMHl3aUVDbDJERnN4R2NI?=
 =?utf-8?B?UGNJazYrek96VjhkOXN1T2hhMUJVVWttYVo4MFByRG1vMDdodmY0NFNxY2JD?=
 =?utf-8?B?Tjdmb0RiVnFQMXZEWmxxYUlBSmtYbGRCZ2dsWHB4N1dPYmFDanVjNEUrT1ZM?=
 =?utf-8?B?dGpYdlVyQTVBN2xlRzdVU1hNM2tSTlR2bGdMdy9UOU9YRU11TW9vdWxlZXls?=
 =?utf-8?B?R2RQOHNvbXNwSVJGSkExOGNNT05MVEIwV3FHekdUbWxkMnQzMUx1SDQ2cjFt?=
 =?utf-8?B?VVVMMjdpbDdkaFh2cEswcWluenUybkRpL05NTElFOEpobHV1QnQxczgzR0Nr?=
 =?utf-8?B?K3U3a3RHVWN5VmlVOStlNmlBeFNGajhCZVVBYzFZaTBCVGk2SUhzVTdMNENS?=
 =?utf-8?B?V1VXU0gwTkhIMDRHOWd5RzMvVUxMc0lGd1BrSzhpaVZDem1Bbjd6djNIaGdF?=
 =?utf-8?B?c3hiN1hidkYzd3QrK1VsZGdXQXBRSjNudlpreXZUdTVZT3FtbVNjdWZwV08x?=
 =?utf-8?B?MElqV3o0WjdubkFzN0FqZ2FNbVJiTmphNXR4WUoyUmY0ditXZnZ3YkR3ODFk?=
 =?utf-8?B?NGhvbzBTRVhiZkRRMWFCcm5iMlU4cG9WVG5URWFoa203ejhlcm1GaGc1S0F0?=
 =?utf-8?B?YUJISm03VzF5dlRVSm1wWVdCT0NsMWw2WWtBYWg0TlJFWFVWVEV6WkhqZmsz?=
 =?utf-8?B?TjZMRWxreXlJcDFrT0UvWUxodDc4eURTc3VlMEZybG5zVENKR1JVVXB2K0Er?=
 =?utf-8?B?TlA1Sng1V3N6aDFqcUkxMXRpQzVOd2k5Y3d0SjdqNDNXdzU0d3lDdFZHZ3Zh?=
 =?utf-8?B?dmpic2NONFh2K0VVL2w0WnRyc1ZZbFBndHpENi8wN0VxdENRWUtkbG1uTjIr?=
 =?utf-8?B?dkNleUdCTS9xdDZHaW5UOGlySHNzNEVkVnJ1NVBQaEUxTnlIT3JzelkvRGFH?=
 =?utf-8?B?bmRDZ1RsUmtkTk9mM3ptNDBzSlYvejlTVXpKdUVrMXBoUUppeDVPTzk4ZkR2?=
 =?utf-8?B?NnBXTFZqYlpnN2N4ZDRmd2Y3OUptZlBQVmtUQ055TTNZU1A4MFBPR0djbEpm?=
 =?utf-8?B?S3h5SUk4dUlUV1lGbDNHR2p2WktIWS8zYjZ0MlROdUxnY1VoYVNvMERYWnVv?=
 =?utf-8?B?RHUydlNyb0VGMlUvVG85UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTJkMVdTWEtBek16VEpieWEvdG5wQ0gyR092TndHcjJWT2kwYXRLWXJsdTNj?=
 =?utf-8?B?MHc4cUNBYkJCeUhDamlnMjZuUXBMakRCZ2E2d3ppZnU1MllVS0VWd09UZXpM?=
 =?utf-8?B?MHRuZ3N0V3hyNXI5YjlVM2wxRFlpTHZ3UWF3b3NQZUUwNHVxR055ZG9JSDVa?=
 =?utf-8?B?RTlhRlYzdXlqU0doMXNxNFJpWStjMWlwU0xSRlM5US9vaEVObUQ5NkEwSkRI?=
 =?utf-8?B?Qm40NXUxUE94RVBGUEFqaU1hMmVUMTFFaDZ2VHFJSzU1d1J6K05OZ0dhc0Zr?=
 =?utf-8?B?TWxzSzJOdGNxZ3BWQVVQUUw0eHRheFN0N01GeThOVU8ya2UzWHJyS2hSZkJy?=
 =?utf-8?B?UTN4MU1CRkdRUkFvTE9zejJ6bjBycWtpS0h2S1JELzRWS3NGbUk4eWV0aFor?=
 =?utf-8?B?V3JNdXcwWllZekFaOUs2TFpqbDlrZTlUZXBOL2Y5Ri9DWjFFRUU1Ymx5d0Rh?=
 =?utf-8?B?OTRnM3A5YzhjYUpVUm00bVVDZWUrSm1sKzcxeEc5WEt3NlRHcUJzOTRuQlcw?=
 =?utf-8?B?OVhyWFFoc1VPYS9lSWNKdW1QQTVVdDRnQnFONEtHMyt3bzRkZ28zNzVwcEw5?=
 =?utf-8?B?Y2tZRGs0MEZuYjBwSGYzK2U5ZVVYbWNCTnI2c3FrWlZ1NVAwV0Fma1BYSHdi?=
 =?utf-8?B?bUsxczF2TXl4R3BPZlc5eURDcWk4dWVGZDJkR3Raa3VCV1krTSt4YTBLTlNq?=
 =?utf-8?B?bkFBVVJML0lhcW5OaG9nSVc0Q1EvY1dxZVhzRi9iaUhjby9qbXU5SU1ZS2pY?=
 =?utf-8?B?RDVISlNVT2dFbzlOczd1cTc0dXFhR3JJOUpZRytFVlBVNHBkSmZ5YlN2b2pT?=
 =?utf-8?B?aFh0QWFVaC9TN3FGUEVGSFcxd0ZTR2lOczd6SlY5VHdCK29nMEcwQnFLTDV6?=
 =?utf-8?B?TlpqZWxrYVFZZWFKb29qQjAxQ3J6VmJCYm5Lbmo5RWpiRlRMVktoZWpxUUtE?=
 =?utf-8?B?ZmhucDFGMUpOVTRuWnNkK3ppL3pOOUFDSVVrYmxQUU5vV3FybEJIUmJUbk5Q?=
 =?utf-8?B?ei9ueGtPdVhxSS9oZzZ6aE9WV0tMRkR6YVd3cXN6a1ZPMm9oODhlNzBkRFFx?=
 =?utf-8?B?NGx1UUFORCs4YzdBczUwbm8xSHo5SlBKN0ZNZnFlOXJwN3BDaDNDVXNMdFNu?=
 =?utf-8?B?Rmd4YjB3Mit4WWNoOWREZ0VGNldRMHg3L2V5WGRHVm9MYXBvY3JJdzZGcTQv?=
 =?utf-8?B?UGZtM2RsVzRkV05JZGZNcEtHbEVIeUorUjdiWm9YWG5JTVdxRVpCUDdFWnlU?=
 =?utf-8?B?V0NGL3FyOFhtaFJqMW9nS25pcEFoZTVOVllXQ0tNRU95bFpxaEtpMmZpRUZZ?=
 =?utf-8?B?YXJ0N3ZJcXZLcWxPelFJemFVWEIzdGNRYTg1SWtycStVWUhUSHF3SG41djZl?=
 =?utf-8?B?YjNiN1dkSXk5aitnOVV3L3hJeEpUQ2E5emhLRzdxYjgxVDA4S1RPRER0R1A3?=
 =?utf-8?B?S0lNTHc4U2ZyNTFheDFCU3lJb2FrSkM4dURBUE8wVTk4c0FvRWtSOE5BNXlk?=
 =?utf-8?B?OVV3eFBiU3V1d0lIeDZMTkU0cXhxQ21KV3VIQUhCUy9aWWxqZmdpMC9JRnBu?=
 =?utf-8?B?Z0F5MlhCSGhWampLU0xleDN1aUFDN1J0UElkSXNoNkVlcWZyRW5uMnBHdCtU?=
 =?utf-8?B?QmErbHQ0dEFVVk85UXdRRE93aDFWZW0rTU1QYnR1Q0xDZjFaNWZvKzdiL0tw?=
 =?utf-8?B?NWg4OE8vOWhEM013K2xSQ2RGRHRwV24xRDUyQytpNTNMcmczWjBKam9VcUQ0?=
 =?utf-8?B?SGVsWFI5ekdhSWN3eU01UGdVZnRBbEtTK3g2UUhUcG9mTlVrZ0VCUDB6S3Rr?=
 =?utf-8?B?MVAyOFNSK2RReVZhSzl4QWtCc3pncFBPa05LdXp5d29qTFRpcGNvTkxUM0dH?=
 =?utf-8?B?cnZCMHByR2FMbEQ4eFZ0TUU2VDI2VzZ6QTJVeHpNREdrWmtpSmJ0UkpNM0tK?=
 =?utf-8?B?cUxUcm1YelJYWlFQZTJ4T1l2Rm1WTitOeTJza3cvODhpei9GbEJhTjAxZ21k?=
 =?utf-8?B?bU1VRVArZEk0c2h5YnJ3OEZzdWovWlRYRi8zTUFiWHBhNnRCUVlpdDd5YWNW?=
 =?utf-8?B?MnY3azA2OFVaWGFoNE1BcDk0REVUSWNvNDZQcGRGLzVra3NEMml5Sm5jcmZm?=
 =?utf-8?B?cnJGcUJXYW8xR3g1WWo4VkowNjFtRHlzUG9ibHVhamdsdGFCNzdlQVBnV010?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fb71c3-e16f-4eb0-d84e-08dca25694a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:39:52.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH5rYSld3uJNOmoQQ6vVRhesZkpXeVMbzl6EpnOZ1llSKZ8HAC17zNovdJksYZ2718jiJ/JfPae33AEvZxHMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6864
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16470

On 12.07.24 10:45, Shivanand Kunijadar wrote:
> doc/README.secureboot.md: The information about DB and KEK keys in case
> of Debian snakeoil key method is missing here, I just added a line so
> that user will get know PK.esl can be used as DB and KEK for secure
> boot.
> 
> README.m-com-x86.md: Add information about how to generate Debian
> snakeoil based UEFI keys and also how to generate user generated keys
> for secure boot.
> 
> Shivanand Kunijadar (2):
>   doc/README.secureboot.md: Add information of DB and KEK in case of
>     snakeoil keys
>   doc: Add information about Debian snakeoil and user generated keys
>     method for secure boot
> 
>  doc/README.secureboot.md       |  2 ++
>  doc/boards/README.m-com-x86.md | 23 +++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


