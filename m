Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E9C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:44:07 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.72])
 by mx.groups.io with SMTP id smtpd.web11.14063.1708004636725185876
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:43:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HNd/bvW+;
 spf=pass (domain: siemens.com, ip: 40.107.6.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I75BjvLTjBBFs3Prr33r/38NSdvKhp1o1CAn4RSwx0Bfp24Y5lV7DhjmILIC9/UsFpFRNcms2ycqmmkOVqGhLVW8m97ETecRyamrttVW5Gf3M6LVy6FHz/gG66Bg9947wSwG3mcFU32ZFZFLRtn4XhQ2aZ2swuVm5pSjzzT0pdEz9TrrXumWVSdBATbXwfJHlCE+D23vSJT3qIm7SgSN73Fu00sx5fw1DGuw2IRvYOCgp6zrgu7grsmgdXEqF7T+cgAdls4/Luc4O/vz4JTSFisQ578lzJDgXpvvjCHTpliUPHdB3tx7qWk5RmUvKVvd4nioiSReyH2M5urwhH0JVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny3P6NTxrNeKWyjqmH26l5qVHkXYbRiPhiEKn5/iXq4=;
 b=awtia383Uwk7yri6rXgoi3qivyuJ52+250L0rcGRmK87ztI0bLiX0PKbvXWzlm56s/o3yzmshS5+gH0tHVHPrJNgtDm2ZWI80KLFddjx0PzgEGLHSTgpz8gQAnDpIgcO6xkyAV+3arvMFXiqPwDzaYlKR3OtN6nmRw6YRTGt7ZSdygfW9T0FPFd0mHzXm60GAhPZi2kxbdUnaBOwkB15Hdpr8U+jOE9cgl4fIAFpO9rAi+1uXM7flcHJh+7s8GbLhLrsNP2FMOWxH0W63SrmPj2pOD46F3+FLurUNEb5xg8LzMemaQu28tYhy0Wqb3DGU7iOLXfv4ctvKle+w86oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny3P6NTxrNeKWyjqmH26l5qVHkXYbRiPhiEKn5/iXq4=;
 b=HNd/bvW+/H+aiWF8NK/dw5CegM1VNpeuPyTbgGKf5+ZHgH1SOj2b45YDhgkrJWFMNDSI92CK0uOpD/Tms6SLNEUhOxMaFfDhz2Fvf7j7Mqy0u04zk+Pqt5lpJ6XTm5W+119rHPE76iuWX1NdaAMVChEOpAz8tFUqrGtsfzPnmxNUyZkzoLBkeNcxenEa45yciIJaGVMqTvxptXkbtiksN4sOhtJ1KSfyywnFJigcSYDv+RAbaaSrdjnOYXPn731Qj6sJiWZa90KFvmciV3TRx46pHNvlre+6x6rP61G79GnIaS1Eu0i8va5iB6StEhdArfvGn3ewDsFFauZ6DWzaWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB5PR10MB7721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 13:43:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:43:51 +0000
Message-ID: <f5d7892f-874f-4151-b5f7-2056ded33601@siemens.com>
Date: Thu, 15 Feb 2024 14:43:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] add SWUpdate 2022.12
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
 <20240215121659.315309-3-Quirin.Gylstorff@siemens.com>
 <8ca05288-d85d-478b-9796-d2bc4092abd1@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <8ca05288-d85d-478b-9796-d2bc4092abd1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB5PR10MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 64125361-7518-4d39-216e-08dc2e2c24f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+2V+ux28n96yYHV4Ej3heFDOSJQQXzZUtVR/q4IuzrNWLc9kxXAaeYkM+PPfmcG3gB+Nxoa2V/0v53wXzkOwALgxIUh9KO5Ga+/cFvBA8fO/SuLmoBKYRw6nWgbwl0X7MRm0mIJ+635kI/mjn1jjRFL1M15bkMTf6fWK0VjMGfUh4Meth41qY7LlI45dv0LlFhz86DdBsDycO7uGB7/9ufl0y7fTKG+qPAyOYRYL7q2knK9SGdvDnQrjWbRNBDy46VN5Ck/jeNeKaa4a9YLSLyjD6ZjJcliv3cOru7Ar8svKhwF5v8LKf81N4LmFNRR3ThwvXEMhe4/t4mxcUUI/uXY3U9O2epSNDO0bIfWhdoUmP9UAal11h/J/F+S+zqKaTxK2jDXia4AT5fUADQoSlWPrEfSF4dPm0HTnknBDXIf3uKH/O0C0dH1chuv6sSUyOKf0I4oNmnKrlzG4ygiwFySKGlksteLcGcmpZ88HyNgulcOwN1LGaPdUPDccBmGzR3FljGeUHQ6ehfuH3/eNRakjQXStMG+nY7PR4v+arc/LtIG5ZFIoqVGWO4VqCooF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(6512007)(478600001)(6506007)(41300700001)(2616005)(6486002)(5660300002)(31686004)(2906002)(8936002)(66476007)(8676002)(66946007)(66556008)(316002)(19627235002)(26005)(83380400001)(38100700002)(31696002)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjFLd2tLeldFSFoxNXArdUcxRmM2RU5RZFQrMU5hQkJZR1UzdUFXTmhPSm1L?=
 =?utf-8?B?L2pESGNheWFzWWpRZktKdnAyNGpyWGJ5T1lpaEVzZC9mR3RCNm1iTHdiRkZ6?=
 =?utf-8?B?c0puZG9qMXBjVldCcFk3Zk9wcW1YWUxYNC9xa0dVaXY0ZmVBeFIySXBBVC93?=
 =?utf-8?B?NThpL1JJOHdkenVUOTB2d1d2eE5XamFGUGpzQnFFTm5wSFN4ZWExMzJLTkV1?=
 =?utf-8?B?SS85Z1BRNE9ZVS9BNDNGY0hPMWcwMHVOUjM4MlVoZ2pLNTV0YWdEMjlSenE2?=
 =?utf-8?B?ZVRLNy9FMnZzVjF1TlhPY0NXSnVBVUE3MVRGck9zK0Frbi8vS3gxYTJpam16?=
 =?utf-8?B?NlFRWnl1QnhBSjVBYngwak1JV0RGaXNRTlZsMzJXc2s0SUcyZ1pxUExUMFIx?=
 =?utf-8?B?c1VpNXRFbWx3OVU2MEVuTXBGYTVnWEdXTGNhK1JQVTdWbmowVlhXc0xJYjBI?=
 =?utf-8?B?WkRVemdZck5LVTNEbzI0elhHNXR3ckk3aFRrMzdPOHJDYTFjZUFCSC9DL1Rn?=
 =?utf-8?B?WWFGb3M0VmExSnNLV1laTkU5N1E4UnZBdVZ4aFNQdzdhY0xNZTJXVkFIdzZ4?=
 =?utf-8?B?UHg0ZTI2bWpsZkR3d2pLRGRNU25LZ1p2YUhsN21aT29sYnAyMUcwRmgvTGda?=
 =?utf-8?B?aUsxQzV0eVlNeEZCM2FTY2ZlemRxdXJlL25MSkNtWmxZb2JPWTFleWZhTEsw?=
 =?utf-8?B?V2dUWXBJWlhrSlJ1bXoycERvVmJIMTZaT1BDVFhkeEIvVVVBSTFiSXkyZUNG?=
 =?utf-8?B?c0hCRXBLblo3TkYxRGNzd0hmMTgwMGtsUDBJb251VUNlbm5TcFZIUk9XRCtv?=
 =?utf-8?B?cnErdHlDb2tjd0VhenJZQVUyNUhNM2d1QjhpVU1LYmF5bWttKzV6Vmo2UnBl?=
 =?utf-8?B?Rk9XYVZMVWw3TDVialJGYUlKRjRBZFcyZGpkQko3cnVGdFYxWjYwbWdjOVRu?=
 =?utf-8?B?T0RiVWZQTGlIQXpETExnS2xPMU9JbXBjMmNLVVZkcmozRHArZHh2R1BFVlg3?=
 =?utf-8?B?ZGR3NGkyOTZ0UGpYejdvMlZLbEU5ZmdhSlVzQU5vVVBTV0c2bmI2UGdsMHB5?=
 =?utf-8?B?SDZ4ZVV6S0VXdGRxcVJvejYwbjRvQ3pEWVNXanhQZlordDRSZjc4cHQzMGRE?=
 =?utf-8?B?dStySjE0WTdZbFBGSkFyY1dabkpmeno5QlZKYm5qMHk4aUNhVkh0Vk9JUWVG?=
 =?utf-8?B?alBMU3NVY1JMSlJ2N0x1NkJpR2duQ2pQdTB4Y0NSN25NZmkxWVRqNVgvMEgx?=
 =?utf-8?B?Sm5vUGVXNEY1UFlSR01tU2pwYUVQVVFnUHYyQmxvUDRMUFR6MkpQUnJmVmRB?=
 =?utf-8?B?NFYrUE1VTjBJbzJ2dVBvVmRET0xQanozUkhOUjc5MDkwMGtlZC9pMDNJZSt6?=
 =?utf-8?B?RTlRbkRIa1E2aUlOMkkzTkJWSEwzV3ZYY2ZuamZ2M0ROblhtWUxPS1BmZVdo?=
 =?utf-8?B?T1V0Vmhpa0phV2FzZHEyRWJqNTQvdmFOa3Erbk5vR1l2OURJamtEUndicktE?=
 =?utf-8?B?REF1LzdMQ3RGTzkwU3Z6UzBHS2hUaTJZRll5OWNOUy91aG5HNERTdURtS3do?=
 =?utf-8?B?KzAvU2RVT1Q0bHluR3VFTnVXMjcxdFA5c0w5Y2JmbEozeEhBLzRaQ0JtUmxZ?=
 =?utf-8?B?Mjg1c2FzWjJOK2orMDhBWDBhdC8rUjUxazdMa2Ywc21XaVU4VkhrY29wRkpI?=
 =?utf-8?B?ZGs1Y0pZQWx5YlIwNjg3ZnNXSGJpMEJUaGFJSm13WklXaUJ6Y2MxUTJyQUl2?=
 =?utf-8?B?MnA0cEFXR1BkR0NXWjBYbjF6dHdhaVp1MThLV1FWZDEvNHlNMHJ1ME9YS2w0?=
 =?utf-8?B?Tlp1dUErNkx4dUprRDE3cVRwbHZicmM2S3I3UkVEVVdoWXAxZ1dyRVJEWk0y?=
 =?utf-8?B?ay81NzBadHo5UmJiSnpzR2R6L09sbU5xRDJVcnVzWUhKUUx6NzBLWEQzU1J3?=
 =?utf-8?B?VS9sUVFwcXVxNlRMMlNvbE5MdkMzT0thYjZvNWZCVlZZWXp6UWNzTzJtcDB5?=
 =?utf-8?B?ZGszbVAydzVEUjFKOUY0ZmRZQStKdHdvMnZMeGQ0OG9PRkF5TVBmUE9aR0I5?=
 =?utf-8?B?WUJoc2x2SXJCVTJoRGdHcjE0YmxEMW9xUFdUTnFxUjB4aUN1ejRJWG9MZVdx?=
 =?utf-8?B?Ny9sRzNETXExelloQ25rWEMwSzgrLytCdjM3djRpN3Y5YWp5RURpakZlTEpT?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64125361-7518-4d39-216e-08dc2e2c24f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:43:51.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVdcNB4TwgFlrFjZCkwVva0l78JiosYYEEGAu2bV/mnXgP7sIb34PrcFK9xiD+/k8UNWlEhzXmRkXP7qfeZp1OcYJDr9GbcCC16GVWuhSPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7721
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14996



On 2/15/24 14:41, Jan Kiszka wrote:
> On 15.02.24 13:14, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> SWUpdate changes the Suricatta lua api in 2023.05 to support
>> released legacy applications add version with the old api.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/swupdate-2022.12.yaml                 | 22 +++++
>>   ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
>>   ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
>>   .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
>>   4 files changed, 184 insertions(+)
>>   create mode 100644 kas/opt/swupdate-2022.12.yaml
>>   create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>>   create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>
>> diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
>> new file mode 100644
>> index 0000000..5dfe97a
>> --- /dev/null
>> +++ b/kas/opt/swupdate-2022.12.yaml
>> @@ -0,0 +1,22 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
>> +# from the first wic partition
>> +
>> +header:
>> +  version: 14
>> +  includes:
>> +   - kas/opt/swupdate.yml
>> +
>> +local_conf_header:
>> +  swupdate-2022.12: |
>> +    PREFERRED_VERSION_swupdate = "2022.12%"
>> +    IMAGE_PREINSTALL += "cowsay"
> 
> What has the cow to say here???
> 
>> diff --git a/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>> new file mode 100644
>> index 0000000..dafbf6d
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>> @@ -0,0 +1,27 @@
>> +From 451a80e1a98d7f6abd287215e7cac3929eebe025 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Thu, 15 Feb 2024 11:06:52 +0100
>> +Subject: [PATCH 1/2] Add option to enable surricatta-lua
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/rules | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/debian/rules b/debian/rules
>> +index 57da4ca7..a78d9ca8 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -56,6 +56,9 @@ endif
>> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> + endif
>> ++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> ++	echo CONFIG_SURICATTA_LUA=y              >> configs/debian_defconfig
>> ++endif
>> + ifneq (,$(LUA_VERSION))
>> + 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>> + 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>> +--
>> +2.43.0
>> +
>> diff --git a/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> new file mode 100644
>> index 0000000..4ff7419
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> @@ -0,0 +1,94 @@
>> +From 356ed7987a489f0259c0878117a4cac8e22ba8d5 Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Fri, 16 Jun 2023 19:43:38 +0200
>> +Subject: [PATCH 2/2] d/patches: Add patch to add the build version to swupdate
>> +
>> +The build version is only set if build in a git repository
>> +this patch allows to use the version information stored in
>> +the Makefile.
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
>> + debian/patches/series                         |  1 +
>> + debian/rules                                  |  2 +
>> + 3 files changed, 49 insertions(+)
>> + create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
>> +
>> +diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
>> +new file mode 100644
>> +index 00000000..480b67f5
>> +--- /dev/null
>> ++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
>> +@@ -0,0 +1,46 @@
>> ++From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
>> ++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ++Date: Sat, 17 Jun 2023 17:56:18 +0200
>> ++Subject: [PATCH] Makefile.flags: Set version if git returns no information
>> ++
>> ++This set the swupdate version if build in a non git environment.
>> ++E.g. pristine-tar build or from a release tarball.
>> ++
>> ++Also allows to set the EXTRAVERSION from the command line.
>> ++
>> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ++---
>> ++ Makefile       | 2 +-
>> ++ Makefile.flags | 3 +++
>> ++ 2 files changed, 4 insertions(+), 1 deletion(-)
>> ++
>> ++diff --git a/Makefile b/Makefile
>> ++index 9f6a33a6..56189688 100644
>> ++--- a/Makefile
>> +++++ b/Makefile
>> ++@@ -5,7 +5,7 @@
>> ++ VERSION = 2022
>> ++ PATCHLEVEL = 12
>> ++ SUBLEVEL = 0
>> ++-EXTRAVERSION =
>> +++EXTRAVERSION ?=
>> ++ NAME =
>> ++
>> ++ IPCLIB_VERSION = 0.1
>> ++diff --git a/Makefile.flags b/Makefile.flags
>> ++index 2bec8468..f69ab5e8 100644
>> ++--- a/Makefile.flags
>> +++++ b/Makefile.flags
>> ++@@ -7,6 +7,9 @@
>> ++ # ==========================================================================
>> ++ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
>> ++ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
>> +++ifeq (,$(SWU_VER))
>> +++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
>> +++endif
>> ++ export SWU_VER
>> ++ SKIP_STRIP ?= n
>> ++
>> ++--
>> ++2.39.2
>> ++
>> +diff --git a/debian/patches/series b/debian/patches/series
>> +index 5638bbf5..12324569 100644
>> +--- a/debian/patches/series
>> ++++ b/debian/patches/series
>> +@@ -1,3 +1,4 @@
>> + Link-config-to-swupdate-www-path.diff
>> + Replace-Font-Awesome-5-with-Fork-Awesome.diff
>> + use-gcc-compiler.diff
>> ++Makefile.flags-Set-version-if-git-returns-no-informa.diff
>> +diff --git a/debian/rules b/debian/rules
>> +index a78d9ca8..1bc70f84 100755
>> +--- a/debian/rules
>> ++++ b/debian/rules
>> +@@ -17,6 +17,8 @@ export DH_WITH=--with lua
>> + export HAVE_LUA=y
>> + endif
>> +
>> ++DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
>> ++export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
>> + BU_SWU=
>> + ifeq (linux,$(DEB_HOST_ARCH_OS))
>> + 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
>> +--
>> +2.43.0
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>> new file mode 100644
>> index 0000000..fcccc2c
>> --- /dev/null
>> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>> @@ -0,0 +1,41 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg
>> +
>> +require swupdate.inc
>> +
>> +DEPENDS += "libebgenv-dev"
>> +
>> +DEB_BUILD_PROFILES += "nodoc"
>> +DEB_BUILD_OPTIONS += "nodoc"
>> +
>> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2022.12:"
>> +
>> +SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
>> +
>> +SRCREV = "aa9edf070567fa5b3e942c270633a8feef49dad8"
> 
> Is this the debianization for Debian's 2022.12 version or for newer?

This is the latest version oft the debianization of Debian 2022.12.

Quirin
> 
>> +SRC_URI += "file://0001-Add-option-to-enable-surricatta-lua.patch"
>> +SRC_URI += "file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
>> +
>> +ISAR_CROSS_COMPILE:bullseye = "0"
>> +
>> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>> +
>> +# use backport build profile for bullseye
>> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
>> +
>> +CHANGELOG_V ?= "${PV}-${SRCREV}"
>> +
>> +do_prepare_build() {
>> +    deb_add_changelog
>> +    cd ${WORKDIR}
>> +    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
>> +}
> 
> Jan
> 

