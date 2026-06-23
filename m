Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E353CD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 07:56:29 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15871.1782201378547217854
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 00:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DOe6fp9Y;
 spf=pass (domain: siemens.com, ip: 52.101.66.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj7vTUl6D1eOCb9MmW8ihwO5KztwYlJIs3TjcDLmraha1i/8cr4PmK8WQpuPgEdJdGpEpORotBIZkyH02OvMTcewHy4fowhoCb+ynEMhp2TLTzqjRtHjkgj+63PGpuq/QTnWfdIlui1ww/b/UT8olnZEfJdjSg5jECtLEDWP95HRPr+BDVkIn92MRq0OmimVOATjj3+b8ekI1gZZwo42wmTtFQispLlWJx1N+g0N4xkAdldR11KrmKSdmX+/fTXFYGu52oDXHjsBd+dOXj2puALncZds5muiSG3I3y8M9frMFwQVMqRQ31yJWbYDp/btBrG56XV/2388ajetEy/fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lT5p3b4xibhhKSCrduHUuNWnluqJ+ka+5LA249KMs4=;
 b=GoGXUvuEjDtGwousdlN2gf+4H1rLMiNzPA48a4XYxVOmoeCh+MGnH2TG/xQ0qkHmJVoFWhwcml4cdxzQfPubhEXhPCa4TrQiLUxjhTJAT/gYaTcXd7ZtDTZo4hTyHoNqKxw6urqMyHvgnU8d80NS0WUwtViigbsdUq/CgaLmwxzDcpuZM1JbJMc9Wk131ASpmgCanEmi/xXJNCSNsqWE0se9suw8mmvdMHzTgYN+H5UoPE0btHTtI7M/0kbay21iEQhJx/ZX8Geq5QgmEE7HmKs2/JcuZhghoZtGBj+k04h//+qh6UQbnqzRDcdvY7KzdSiMyuNdjvyXH6Ub5Pwl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lT5p3b4xibhhKSCrduHUuNWnluqJ+ka+5LA249KMs4=;
 b=DOe6fp9YQfPYypHoWWRBRmMg5rx6+QMZollq6jG9NPZpc7Lk9ecU8J+j9d/rXrda9kdvy4nR12r3xK1aP0FsplV2P4Kx6ESFQr8a6HCXjRyZnMQhutfXK+nuZgC6GK3IuW/H4yEUgKIKqKA6++553WdHwTncIYzeCLxUQdEX8UFwXkTDLdKHFLWzGD4drUx8FaAEZlAnqP/zGMkcFp+yGocJ3OesigxZ7eA8DhklJjqx60nocHqmxbX8IXJCxFkyMxfQts7qNZ2fMAQVWB02MYVthJOK2qSVwguCXcMsZM+Dd34XEswq1+g25HxAynyoPAQ671Vd+DiilMgN3W/gNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:56:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:56:13 +0000
Message-ID: <8c9ae7ce-8bfc-45ab-92a7-26f0931b9f0d@siemens.com>
Date: Tue, 23 Jun 2026 09:56:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 2/4] Add the default kernel verions in
 cip-core-common.inc with extra weak
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260623073642.964019-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260623073642.964019-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd23c27-68b5-4b1c-1de7-08ded0fce549
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|4143699003|6133799003|11063799006|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	mKA9DdCR92To+DJqP8RGeJVbA68Ag7x9jrKW3sCyHZd3EWiQ/B91Gh8YOkq8bEZ4JMCRJB/RyZC1xVuTNfeZ1ehCZUpP1lHJ0ReRcy2wQ0MOS/sJIQNDOxz5XzockTTQS7EteW+cRWRe2RMGSmNdI0v70rs91UTiL6GXrpXJRZIMFj4kxMWgYGrSeN93TQcyrOaiz+R3LD3YpkWDoklGNz/YKA7D8OGse92aAWg/x5fcsOhgi3yq910P7bTZS4gRE/sFmAdxO+A3FbKikAc+NV/3N8IlaE3L9lQieirxJUpxmCA2lh4jfrGC8H0jgE07dD8Kymh8gFsG/BRJJjHhOti9kw45hyb7DjDhEkHcgShil3O4dwbwfkyYG+AcHj0MAb4Af9yQeU4H63VQtzx/3uPs1flfNt/9gwy8DW1H8Xz1EfXb9dBWorRU/9oHnSFXPr9ovmuFK+a+juPa6OmNvRKiKGWD4TbQNX4EUFHu2Srv+gCpNmMRrgKOeP5+D3luDcWFclgBdtNYpXp80F3O29rWdLmpRVxlb0pfZgRpuq8tba0duL37RlaKUcazS7PPY8dXaEUEunGvCVGp34Kqr1hY8ru0CSFlTssKEnEHT/tk1LCW3+JVU0DprFEwsfbR7Ga5EXnmznoeye1KsZLb5gvt3onw1fLo5qA8HPLInnA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(4143699003)(6133799003)(11063799006)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEwrNWp3UHRvWVdENWp1ZHlLZG5ybFE4UUpFbXBmWUtkTDdLbXQ0aTZQRito?=
 =?utf-8?B?VFFpZkxSbVJIRmhweGFpeEQrYjgybDFZdFlYeFRxcy9iZjdaSGlGU0d3cUdw?=
 =?utf-8?B?cGxUR09NYnBvUS8zMU9hRFAvTTdjTTBTQ2hnSVBDd0FwMXRtZFg1bmZEcVZP?=
 =?utf-8?B?Z3kwRTcwbGJLYmZiWmxoNlhJRHZLWW9SZlNDQ0FUU09WaVdNeElLN2lsRlBB?=
 =?utf-8?B?ZGZIc05aa2RHL3lGZ0pLVDBsNHlidG96YnZRRndsVTlBMWsvaW5iWmszYm51?=
 =?utf-8?B?ck8xbWFYTFZjVzZwMkQ1aThidnNJdUZJclJYQWVpTFVXcCt3dlVrWk1rNmZV?=
 =?utf-8?B?YTBGdVlDaENpb3NHL09NK0pqQW5VOS9OTUE0Y0twMFpWdCtwT1AxRFVnV25B?=
 =?utf-8?B?UDExaVI0cVg3aHdkd0xtWEhocnA3ZFhvNm96cDZJYUJvRUtRYVZlU3VYZjZr?=
 =?utf-8?B?eTF6NUdYY2o4STZQdmN6SlpHNzBuZ2daakxvQS9BeW40Y3RZUGFDY01kRCtZ?=
 =?utf-8?B?eFdGRHl2b1QyVi96MnArN0drZ1JrMFVqY1N0VWQrcGRySVU1NjQ0SWpySnU1?=
 =?utf-8?B?eGtaMk9TNERuWXl2S043VXg5cmRyMUtqQkZzdzFEZjQ4OVZ5NXpnNEpnTnp2?=
 =?utf-8?B?TlB0L2M3N3lXWGViL1R2YmptQ2p3UGdKNUZFSnBYSitjcUVZS1YvcmdWS2JZ?=
 =?utf-8?B?dUJ1bXlXTldVUTJTTU5iTk1lMlVOUEExT0xIUjZxWk9lZWtzSnNVelVLOE94?=
 =?utf-8?B?M1JBbXNMV2FFY1hFbkRSRWNpaENQZXFXTXZ5NjdwVFl2NVNjeVpFdE93R2l1?=
 =?utf-8?B?Y0NLOXRrajZGeDRwcVJOcGFtN2lYcVVyRW9CQVgrRHhBZGNFbzU3a3FpR2Vv?=
 =?utf-8?B?TGVDbVBlWnoxYXhCYWw0elM2Z1NEWjBzNUVVbVJCQTlRRkFxL2xPWDFXVU90?=
 =?utf-8?B?L21JdHV2L1pxWjN1bzMwdVhieHR6V2twNjVQNGZ3cUZMRWZwenhabkhkMFhP?=
 =?utf-8?B?Y3dxRWJGdzUwWkMyZnE1M3ZPV2Q2aGhNQ2g5YlFVcG1EcmNwZU9saS9vZHNP?=
 =?utf-8?B?SVVZdHlBaHlDQ0RBVUZHRnVKMlN3M2Y2S25iRSt5M2tLQ0lvYXpTS1FKUlVE?=
 =?utf-8?B?M29sQU1tWXZyL1kzK2p1YXc2OW9zUGd3Z2JCUVc3amdDc3IxazBxSGVVSWZm?=
 =?utf-8?B?ZXBHaUdVeFFJQkVEZ3ZZT1JFV3c1Rk5JTS92YjdQcjZvUENvNGJNOHZtY3Ro?=
 =?utf-8?B?TDM2Q0hzQmc3eExoSUJhMnE3N3pNQUZFTlBSY0RDbnF4a1BOYWhuVllXbjZR?=
 =?utf-8?B?T0dTdDR4ZHhtRTFmZGdBL053ZFBHc1pqVE9vVktzWURVY3NKZnAxN1FPdXhW?=
 =?utf-8?B?ZmxCZ3F2dEJWWGEyS2REaUNZS2ZVTFExd1FTVlJpV3p0UWtJSzNuNGpmcGFS?=
 =?utf-8?B?dTBmdUZrZlZQMHl5MUczbWFYcGxvc2ltZXZueEdBcFJZUHI1QVVqaitwOFBy?=
 =?utf-8?B?emdFUVF5a3FZWEhLdzFVYWx4dytMUkcvL3N2cERja3VEWUpOSEVzdDNoL0tm?=
 =?utf-8?B?bjBhblZXdFRZUDA0eUVOOUJFYkMvcHF0WEhSSzg5OVQ2eHpZMkp3NEpCTGY3?=
 =?utf-8?B?b0M4N1VwNEZkTGxjQ1JJV0RleUVpaFlzVEtXcnl4UHNvMkROdjRBQWZZa1E3?=
 =?utf-8?B?ZFRpRWR0aUl2MGZwS1hPRmVSS2phL0hyMUFSWVI2U3N1b1BIK1RYTit4aUNn?=
 =?utf-8?B?cUh0a3BxVG5iOHR0OWNsd24zczNST2lIWjNmaVZQVExsd1hPM1I2SUpNQ3hW?=
 =?utf-8?B?RUdWZ0w1MVlsTVZOSmpCSndVRW44d3VBOHJ0Y3NlTmZzNG5tZVZMME00djJ6?=
 =?utf-8?B?ZExuS0hDcCtVWm1iZEZaNGM4b1dOQUtyMHhHb3lDdWlTcVloZ3Z5M29VL1Fa?=
 =?utf-8?B?R1lFQTFpOFoxL3JrSEpVWFZIR2dPV2hGTkNGa0xjNG1oT0tEZlFDZWxjdCt6?=
 =?utf-8?B?Ny9BTE5tczhTOGhRRTVlQ3hLUmhqb1RrbGRQWjhyR0tvcWF0bXZaaFFBSFNH?=
 =?utf-8?B?TmZRejZ6bmxDcG9JeU9yMy9CQUZnblJXNjRSQ0k4ZVRqUkpFREdsZ1lGdFND?=
 =?utf-8?B?bGt4TnAzNDl5Ny9sOWtMeVVEZGxFdWo5RHk4cEgzSzR1WVByd1c3bUhzNjkx?=
 =?utf-8?B?QWVUT2tONzdUM3k0VFNvOE51d0hBcDhLQzI3bXFZdHE0RjI2SU5XNi9ucndp?=
 =?utf-8?B?V2dVVmpTMkwrNjZTdW52MkxyRVVYdUtCemdGaEkzcFdtc1JCblFKYTdSa1Vy?=
 =?utf-8?B?eTB2WkFHK3Y5VURCMkxPOUpMVjdYWWZ3V3UvR2orV3BYcldJZy9rUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd23c27-68b5-4b1c-1de7-08ded0fce549
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:56:13.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtJlRS2oQFEBh15XNgJe17cyILf1B5pjtlMZEPDxiDpN4F92UnwNttpZZR9icuUz6NA4YbR6pKKhIOdUf/HAfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3174
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 07:56:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23263

On 23.06.26 09:36, Shivanand Kunijadar wrote:
> The distro specific conf files (e.g conf/distro/debian-trixie.conf)
> override this option to set the kernel versions specific to the distros.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  conf/distro/cip-core-common.inc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 0b45636..8a1db61 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -18,6 +18,9 @@ CIP_IMAGE_OPTIONS ?= ""
>  IMAGER_BUILD_DEPS:append:bullseye = " dosfstools-native"
>  IMAGER_BUILD_DEPS:append:bookworm = " dosfstools-native"
>  
> +PREFERRED_VERSION_linux-cip ??= "6.12.%"
> +PREFERRED_VERSION_linux-cip-rt ??= "6.12.%"
> +
>  PREFERRED_VERSION_linux-cip-native ?= "${PREFERRED_VERSION_linux-cip}"
>  PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
>  

Now you could drop the identical statements from cip-core-trixie.conf.
You also need to move this patch first as the sid support needs it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

