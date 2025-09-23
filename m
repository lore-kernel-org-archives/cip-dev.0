Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FEACAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 15:26:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.3])
 by mx.groups.io with SMTP id smtpd.web11.569.1758641168977052068
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 08:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kgrMxBsX;
 spf=pass (domain: siemens.com, ip: 52.101.69.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqDaak/gSmJiOm+Y8iSpHZCAgVV7idcgXQO5bcVIlCzSCq0XsqzYESDvqZ9ECqHt5I4GTnZ9O619C6VokpTXyOcW8f6AXzGHd2A0J935goRoDLM6xEakaVnnHWebQRFPlNU5wPaZOKVen4caJ/NWEc+9SOhBS+u/LUj7SmyeGZcP4ULonQMjGrLBeWt8JkrCdji7+FP+LtWMoZUjkcjN91pV/9zdFVWqP6jZJ1Hl9N+uop2a+TzhqrAiwEcW+VojXLF9TCONvkTxX5WmCuXi535zmXc99uyloYrDStdwLTqPaKdd/xWm32OCcNMsyuKx9AlTlWReWjj0QSrBAfVWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFFh0Bu0cbgfhiscr1XQYCtkAfnwewgowD1DSy0xFJY=;
 b=F97JxJNSUN2qWDM7NKkzayItOKXHZAsxqeBoF7mKyNoE/u1m4HF8lXE+Ce9IL52VxF/PpKyNx6k93+2KcbmAL868unG7TQWMeq3vyI2cR19GHfJDtiM2U8GGnHkK1J9MtRTuPEi5cKu0jKhwfacU3e/DedDb3raTR09stj4FYgJBAS0QXYOAzzwjMNiVjwMN54Tnmi4/Y0EtZPnoOJk99fx+E0E8O3rQsjdTRWhmKxP63Gb5D8/yApVmtDlMJW5Posb0FPcl/ul3Al55Z4uPpGLqfymTy+dyquXrzKOAg7ehFCPxTzCnOorH3ZNnPxUBiYgh+u7CxdH9k9eZkjBDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFFh0Bu0cbgfhiscr1XQYCtkAfnwewgowD1DSy0xFJY=;
 b=kgrMxBsXbcBg+ZFAvT9Sf6+Qsm0elReEIpyqr9QHmisb/MoXRaMiUZ8UpNuuOcEmMhbz+yrcJsWDKZ+imWHuCCDulvn8YBTDaEGa5ZHkzjB2gVo2ZIeD8jwQaG98js+t/2W/61gJQFvjVwBDjEhOVj8W0DRIC54e2zHTGzaukts6M0REKKo7VdpfQPYMV/Hr2Yr55i9Oy3tb2jR/n5mmsC99+ejmNH1SLGcW3+qQCf2ZS6A1Q6qsD83wStfeDkHPeEHdK5OLGQwMMUTs0+qk0u8tsyZnUhryLf92OYw3q0IkaHCIGrJHXblLsVRtm+GLC0oHohZlNJO0fSWVkPRRHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:26:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:26:04 +0000
Message-ID: <48d8c94e-419a-4862-b6d8-2e45ad984507@siemens.com>
Date: Tue, 23 Sep 2025 17:26:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v7 0/7] Add factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdf0958-584b-4135-c40e-08ddfab582b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Mi9YaHp3czNnRGRZM1BYTU0rRnZVL3NxZjI0TUwydCs2dHBSOFd3amlwOHUr?=
 =?utf-8?B?SUFMWHZpYkRuOXRWdTRVZHVzTGdtTk1DUDhDV1Q4K0xqT3VWd0FleFJzazlW?=
 =?utf-8?B?N0d2Yms2dUZ3eUs1T1FkNTRGZFgvaU44bHB3WmEvNlVhS0pEek1MRnlXWEdx?=
 =?utf-8?B?RGtreGxSRW56MC9NY1lleGdwaDJBVXFOdTkwNUJYcmVHZ05aYTJIaWlSQXJ0?=
 =?utf-8?B?Z2lGZ21MOWdISVRHM1dxNTdhQlN5Wkx1d0M2ZDByclNBSXVlZ3ZTZlhJZ0Nq?=
 =?utf-8?B?MEpkRFA3WllxZSswalFyZ29kTzVONDhsb3RDSjRVU3FoVUhFL3ljci9MRkk4?=
 =?utf-8?B?RGN2MVQrbnZya3QvT3hUQzd5TTIxUFQxNVMySG5oaVJsZU9VL1BUN1c4bzVG?=
 =?utf-8?B?R1NONnVqaWxwMm1TUC9Hd1lpQ29hKzM4OTBWNzQyT1lzaHRuVEJVSGxhWG9w?=
 =?utf-8?B?d0x2TkFEZEo4VnBaMDJhNlArZUswUmNjdW84djdmcUtPTEZSU3Vlc1FYSkJZ?=
 =?utf-8?B?WHpyclNDNVVPVTdBaGd4NHdGSnMvZ1BvOGVrSUdCanRYR3pLTVdIR3VYbE8y?=
 =?utf-8?B?TTZ2THJCS1BuNFBQZWt3WVFsRjJ2NUtNcTNvR3JBUWRpMG5QSU9yT1IwRzhZ?=
 =?utf-8?B?TDVBU3NjWVY1a09SMUhoMTRTVld1QU4yYWFyV21kK09DSnFJUjkxY0pKY2dp?=
 =?utf-8?B?VUNmeWVZdThZN2RVN1ZZNnRqT1NWMmpiN2dWZ3lKTWVvbWdPRk9vZTJZdjZV?=
 =?utf-8?B?VWJNVUdLU1FlckdaVkdBMi9PS0J4MWlNYnVqdEVvbGdSNGlyTEtncGwvSUIr?=
 =?utf-8?B?K3N2U0xxRWtxZ1QvRVE1UGZWMkFZVjFSc09wYmMvQ1F0R1pDSmJMT3RWQlNq?=
 =?utf-8?B?enhiTkFoYlVvN1ZjdnFML1BXUEhnMXByMDhuaWdneW1KWWplRjYwVUplSmtD?=
 =?utf-8?B?M2hkS0NXODBkeHhqTVBpeVhvS2xSUTE0VCtOYkxxQjUyeDhUWS9wMkpKS1lJ?=
 =?utf-8?B?Z1A0bWEwNGRwOEtidXFhNGU1Q3EvWGI3NmR5MTNpVndZUlBWUHhtZjQyZWxa?=
 =?utf-8?B?Y1BGUDBxQlM5NEIxR0p0ZVhiT0IzRWRVeWFuQ21aRE42TFk5b2dUVDRxWjVL?=
 =?utf-8?B?aHFUd2VCUTR6aHd1dFZDQURKQTVnUDErQkY0cWZNV2d4MmE4dmVSWVNYYjR1?=
 =?utf-8?B?c3YxTnU4NEswam42cXBwcXI4cm9XQ3B4MlJvT29Kb2p4cmc1cHZoSUxQaTZS?=
 =?utf-8?B?Q0NYN1hTRlRwZ1VsMDZSOERMRzBXbDhFVEtnYW1GNHBmbGozRVVkcU92VVRO?=
 =?utf-8?B?TmdkdEwwRzFwdDV0aVZ4bFVRd0tMSDJpWmdxMzdoak9RWTRYRWpBY1RaZWo4?=
 =?utf-8?B?S21CRUt6UGkyenkyU1NJYTV4ZnIxNkhmZ2EzRTJVUlFZWkN4Y0dRZWVZeU15?=
 =?utf-8?B?NDJqRlcvbnB1RUJsUzM5czQraGZZNzRmY3g0bWJnRktGNTdqUTFVeEw5Vm0r?=
 =?utf-8?B?SDFESnhEYjA3aXhCNVVwNzE4bkI1eEE0b3R2RVFCdGRnaml5bXlDL3NhQWVB?=
 =?utf-8?B?MG1PWHRLZ28wTHJxZkZCcE5rYUxOczA4ZkN1OWpTSlpvaS9EME96NDZnL2Ry?=
 =?utf-8?B?dXpwOU5JZTBCWk5BTU1GYktFK2NzaGh0cjQxbi9GOWsrWWR3UTZHWmVuK21G?=
 =?utf-8?B?ZUpaNmo2cTlLdDFQZnVNeUpETUR0RVlpTWZYUkx3MlJ3Y0pGL1NhbUJWejE3?=
 =?utf-8?B?bnh3blM3M0F5MlVjc2JsbDVvQ2IrWDBwdTIvcXlWMUk4elpFbHBlUmNZT0Vm?=
 =?utf-8?B?UlV4ZWhpL1cxSnhRb2hLamN4MW8xY0Fqeit6UHNHTTlkWFpZeW9Wb0F3U0NL?=
 =?utf-8?B?bGh2VGFkcjJzVE4wNlR2UlZlODNUdjZuVHhhT05NWEVwc2NLcEtwZEswS0hO?=
 =?utf-8?Q?TXPa0vDDgD4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkRJcWRwUnNyVEt4Wkh6NS9kQnlPMXNZYlR2bWlFYWpzTEs0Ylh0U3lHL1Rv?=
 =?utf-8?B?ckREYUdiVlVwT0c5MTlKc05OQjNrS3BGSERGUDJQVVFidEI2ekhEckVHQm1v?=
 =?utf-8?B?MW4wclFEV0FiaXhKdVRtTGIrMUt0akMvNXd0Q0UwTXVWYXQxS2hwaTRObXYz?=
 =?utf-8?B?Z2dhUklCZ1JEWFhjYnNMOXY1UkxRSnczVGQzNUdLZkRpa0ZrTXZYK2FKRVgv?=
 =?utf-8?B?VGFaaWh5dnh4YmdnS2dEcDloL1lsL0F2VUhNVjRVSFl3S3QrZTJhTHdtVCt2?=
 =?utf-8?B?OVdRT2hVTVE4YVVFSy9tbEc1TEN0Q1JVS2FEMHZ4MU05bmd5SzZCOWx5Tzhk?=
 =?utf-8?B?MXlqL1ovdmMxeTNFTGVXSEJJS0ZBRW8rWDg1akFCMEtGWCt0SDhCU01VVlBz?=
 =?utf-8?B?UCt6ZmJnQlNWYVFQeVNNUjVUS3BlNk5Db05wMzlWYStnd3ZRRVhVK3IrZ2V1?=
 =?utf-8?B?MjFsQWt3OUc3elA3Z0xQS1lkYWZFWG15Q1ZaUWNmaDJmV0F1Rm5mRGFVT2hu?=
 =?utf-8?B?Z0lYelRmNUc3L3N4Z0pyamhIRk9FamNObVZ4R00zVmtuMXpuME4wSzFxa2w0?=
 =?utf-8?B?cmJJTVhPUmYvUG01Wjg0eE1XaHhOSkkvOE1zTkhJTXlqU1NZSmlyeHJ0QUkz?=
 =?utf-8?B?NHBTenhaSm4zc0tLT0t0b2ZUelY3Q2xmbEk1dGV2ZWdWeTZ3RUFYdy9UNFh5?=
 =?utf-8?B?L29sVk1TZEF4TmNoSjJtU21HR2pVRm5VeE8zdWM2Z216ZVRtQ3BCaDFnK3ZC?=
 =?utf-8?B?UjlTNVlJc2o1T0hvVVgyWVBxVEdkK0pZZzFrQUpOUmtNTUVNZ1RZaS9HRE5Q?=
 =?utf-8?B?eWM2bGc0MmFvZnRXbGROTG43L1VKVittTHo0bHdCM3FCUW9vSDh3R250VXBv?=
 =?utf-8?B?TFBUVkhqcW8va3VhVFZrSmhGR3dqMmNqU0JBM1F2cFBrYU9RTGZZTFZQcndV?=
 =?utf-8?B?cFpoV0NORTlOYkt0VzVmNlJ3cUxVOG9NTHVwZGQzY1RIbzNhM1lIVWx0THZh?=
 =?utf-8?B?blNncE93L2xRbHA3SHpVZjBGUWZtUFF0UHllQTUrWFplZFF1QVU2bkZvR0dS?=
 =?utf-8?B?RzlVUm16SjM0bWJOMXNoZHJiRWZaTVQ0Z1lVVXErbm9EdlpZb2kwUVhDTEFV?=
 =?utf-8?B?eVJnQy9FRStucGtRS3FVb1NMTU9qdG80bWZrRDFWTGFoYkFlYmduTVN5YnlR?=
 =?utf-8?B?MldJNjFDSUpIdWJRWU9WSlhsRHQxeHJZaWVLbHJIbDY5Mzc1WjhEMmNaVHBu?=
 =?utf-8?B?MEtqQlJzcnBISmZrMEtjMDBPbkhQaS9jMG14bWE5bDJQNHZteVN3dmlIMU9Z?=
 =?utf-8?B?VWd2Z0lzYUpBamFqekkxbVdnbE1sTThyQmF1WjlING1jU2lxWDJiMlhKSEMy?=
 =?utf-8?B?THBSYUtEaDBmWlVHaTEyZ3FUSE1tNERvWE5vUDFUVmtKL2U1RUlzaS8wUjl6?=
 =?utf-8?B?TEhPeWhSbng3TWdkNWVYM2dKQzRXeDJ5V1hGY0VFWFQwMWpWSjdmN3FmS3cy?=
 =?utf-8?B?SWllcVI0L1hEU3p1UkEzTU9JZVFoZEc4czNnWnIwZGV5QzhwTXpXTXMyQzMy?=
 =?utf-8?B?bnBVemhQcGFVUm5mWStUMXNTdlRMcHJGZnpvTkpjZ2xNQWxXNTNURUdndjZy?=
 =?utf-8?B?QVJEdUlTNndqdW1ublRVTy8reGlaZUlia1BtODhhVEhOWmZrUlJxMXZjd3h3?=
 =?utf-8?B?OXZzUERZSFRCNysvdFVsSTVHQmdIR1plRDlYSWh5RTM1V2EyL1p1ZVpjZTc1?=
 =?utf-8?B?QWIzUWtISVRIOFUrWHZnaCttK3dmT29zaUZYZ3VuMVlVbUh6eXp4cHAzd3By?=
 =?utf-8?B?T05BdXArdVB4by90YjdUT1ZNajFtSXBaRTkxTTk5U0EvQWFXZmM1dGcveE9m?=
 =?utf-8?B?bnIzU2dPN3BBSW5YRytvRmRXQzBxaStPSFQyczY3dENldHNxWkt0aEZQR2l5?=
 =?utf-8?B?OWFoYitHM09uR0ZtMTZUZXlzejhISm9BWElrMTNRbFlHemRjcnlMbnFVbnd2?=
 =?utf-8?B?cXVzUTRmVXlDa0lUdkJzbzYrUkRUSCtJcGxnTkVpUDY0SXh1L0tEYllmYmVx?=
 =?utf-8?B?VVpKYk9qdFFMY3Z4MGdSM3VDb1ZuTUNIa1NVdWV1UFBGOGZpMEJnRnZBSVJE?=
 =?utf-8?B?K010azM1eGVTbHZtbW81T1FzUVFxVGlyQ3BaL0E5SnFwMGFSUFVFRmh0eEc0?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf0958-584b-4135-c40e-08ddfab582b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:26:04.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP9EoaOz0sA0ZAXTDSC7MtYBdQvecdU1fit9N1KqwBY/o1cCiVE3RrHiGQLqSgCa6wLm6HLIwgzNaV31GSHS9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8067
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 15:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20115

On 23.09.25 13:52, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds an new hooks for factory-reset to the
> initramfs. This hook will
> 
> - format the disk.
> - In case of a encrypted disk factory reset the TPM is cleared(all keys
>   are deleted)
> 
> In case of an encrypted file system the marker hook needs to be stored
> in a readable location, e.g. one of the boot partitions or the efi
> partition.
> 
> Changes v7:
>  - reorder patches
>  - kconfig add conditions to enable factory reset with disk encryption
>  - fix indentation
> 
> Changes v6:
>  - clean up white spaces
>  - fix shell check warnings
>  - Use efivars in case swupdate is enabled.
>  - add an error message to the factory-reset-helper-file. This error
>    message will be printed if the factory reset is used together with
>    disk encryption.
>  - correct wording in README
>  - add kconfig option to use factory-reset. This avoids
>    build errors due to the availability of EFI variables
> 
> Changes v5:
>  - Add option to disable the TPM reset by setting
>    INITRAMFS_FACTORY_RESET_CLEAR_TPM to 0
>  - correct options for efivar in trixie
> 
> Changes v4:
>  - don't add factory reset for ext4 builds. The factory reset feature
>    needs a full disk image or a efi bootloader to store the reset
>    variable
>  - remove bashism from scripts
>  - add README
>  - change uuid to avoid clash with systemd
> 
> Changes v3:
>  - move marker setter and getter into helper. This removes the
>    duplication of variables
>  - Use efi variable to indicate a factory-reset
>    As default we use the same variable as systemd[1].
>  - The file based marker is still used for qemu targets which don't
>    support writing efi-variables.
> 
> Changes v2:
>  - make marker check a separate script
>  - change data-reset to factory-reset hook
> 
> 
> Quirin Gylstorff (7):
>   Add factory-reset-helper to set the Marker correctly
>   Factory-reset-helper file is incompatible with encrypt-partitions
>   Add factory-reset initramfs hook
>   Set PREFERRED_PROVIDER_factory-reset-helper for all machines
>   Add settings for factory-reset with a separate home partition
>   Add README for factory-reset
>   Kconfig: add option for factory-reset
> 
>  Kconfig                                       | 16 +++++
>  README.md                                     |  3 +-
>  conf/machine/bbb.conf                         |  1 +
>  conf/machine/hihope-rzg2m.conf                |  2 +
>  conf/machine/iwg20m.conf                      |  2 +
>  conf/machine/qemu-amd64.conf                  |  3 +
>  conf/machine/qemu-arm.conf                    |  2 +
>  conf/machine/qemu-arm64.conf                  |  2 +
>  conf/machine/qemu-riscv64.conf                |  2 +
>  conf/machine/x86-uefi.conf                    |  2 +
>  doc/README.factory-reset.md                   | 29 +++++++++
>  kas/opt/factory-reset.yml                     | 17 +++++
>  kas/opt/separate-home-partition.yml           |  2 +
>  recipes-core/images/cip-core-image.bb         |  2 +
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
>  .../initramfs-factory-reset-hook/files/hook   |  5 ++
>  .../files/local-bottom                        | 48 ++++++++++++++
>  .../files/local-top                           | 52 +++++++++++++++
>  .../files/reset-env.tmpl                      |  3 +
>  .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++
>  .../factory-reset-helper-efi_0.1.bb           | 23 +++++++
>  .../factory-reset-helper-file_0.1.bb          | 24 +++++++
>  .../factory-reset-helper.inc                  | 35 ++++++++++
>  .../files/get-factory-reset-efivar.sh.tmpl    | 40 ++++++++++++
>  .../files/get-factory-reset-file.sh.tmpl      | 65 +++++++++++++++++++
>  .../files/set-factory-reset-efivar.sh.tmpl    | 59 +++++++++++++++++
>  .../files/set-factory-reset-file.sh.tmpl      | 56 ++++++++++++++++
>  27 files changed, 536 insertions(+), 2 deletions(-)
>  create mode 100644 doc/README.factory-reset.md
>  create mode 100644 kas/opt/factory-reset.yml
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>  create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
>  create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
> 

Looks good now. I think we are only missing a test, at least a test
build. Can be done on top, merging this as is now

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

