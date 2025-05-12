Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27586C3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 06:50:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web11.44270.1747032644163023599
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 23:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=U970zPCO;
 spf=pass (domain: siemens.com, ip: 40.107.20.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULVIqlN9hqFDgK8iBIi+t0CkQQfOdkT/wJhQXcbce0cOAppaF/dDy/bSIzacpKVECnF7JrQhOKQiKE4KHQUURg5P/CPf35uOci4giBu8qVDol6S7jCtHSM31fGDXuLprvzkwIVg0HM+MkRd2YlzPLJtoAhgwBgizgQpH+NTV4oFnJMjxi7ABHNmKb4+StZ8nfKZmueRZxOBLzpVqoFrslFg1gvpWwaKuGcsklXdzzmdYvShThIDorL/DnpuB5+r2LQSpFKPt+3oJ+GFxyVOsDWAvp4fGgVyzVXOUzL3tQkho9X2pLHi12QT7svQb30FrsuQ7IyZ38RihFnu7YGzOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdFF+HQhcAE/DviTYypkYo/lbt55mhu4qkQRYSCoinw=;
 b=YDS25SEpyiTSfYyD8BJRdM8kuYxxoutjrzC4wxwFdOeGxiEFBQdRfpmi33Fe7laGvAqUxIdB5jqDzQg5whETR0K2C15M5QyNR4q62bZSVC2PHKTlv/TG8fjpLtmVicuIK/nU1S7i7pjCa/0Wu5qBVX7tTdC4uYRp2uC1cPgoemcad4Nhplm0HlQ3dySgK17MSaQO18DF4Am9kMwwn1rLCpKZ5y5H7Src+8H3CEt10VxQbpCG9YvZ5w2ehlp3EHpEFmT46PvAKwBQ+d5l/a98jmWTXna9c5gvDVJN0M4/249yxp3tLBfFN0o9Et4+leLah5zrmOh+YvDcU7D05+yM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdFF+HQhcAE/DviTYypkYo/lbt55mhu4qkQRYSCoinw=;
 b=U970zPCOYD8u/KbFM7Xj2o+cS7jzdlM2a+Qo8Fc2BFb1TzFqcgotzQB856fujmzZemWNImCHQaOBnqAxKBQ5cPvsLgV40uRSYNlhfVsgqsEXpQSWw7zi7SGJqpElRZTGxjvEhWANtH8i2sGNBhUQ07PZ8gEm4oU+xRkrlC/DaFtAwEKIjRcTZZg5nBfN7+bHKRUokyBzq/BKs83rwoWVmAGQuJBP8sH1rlUlaeCUPZJ7ugSb8uP+mza3F2mDaJO3Ipe9hvrKTrm6ZkIFgEjoff2Qob6VEN5XZU2kygMr8lvhCz6gWZj5W7fJRH6tm+xJH+yCvZP0csdLaisn1FTH0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:50:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:50:40 +0000
Message-ID: <3a67fc32-2eba-4d2f-b4ed-c7e929d52d76@siemens.com>
Date: Mon, 12 May 2025 08:50:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Support for TI AM62P SK in isar-cip-core: U-Boot and Kernel
 Version Plans
To: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>,
 "Khasim, Syed Mohammed" <khasim@ti.com>
References: <3574c4cc-2ab7-4e97-945c-24c959891eb6@email.android.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3574c4cc-2ab7-4e97-945c-24c959891eb6@email.android.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3850:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc40369-fbe3-46a4-7ce9-08dd91214f0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UXFQYkV5Q3kwb05NbElpK2Z4RHdPT3p6ZDlOamV3RUVzbjk2Rk9ueFJCODRG?=
 =?utf-8?B?VWVCcnpiU2NFU0dNajlwQXdFb2paYmZjUGFzbGZyMHFHOXBpc20wdCswcThu?=
 =?utf-8?B?SGhGMm1kV0FURFlldkpKclhLMzV6S0Z5YmVwc1YwOVVxTkVyMEh3VGh5NWZn?=
 =?utf-8?B?Z3NXdjVISjdVMGNzUHdYMHM3U2VIMFFlOG1pc2MrdHdDWUJLVmh5aVVaOXdP?=
 =?utf-8?B?cElxMndZeExtb3UzOTVXb2NIZjNIUld4bUFGT2pwRFhOdS93citoYnhFQ3Vi?=
 =?utf-8?B?NlNBUVo2VmxwVEtjWUFqb0E0dzY0K3c4SXFPaHd5UDRBRXhBOHN5OHN2WFg5?=
 =?utf-8?B?Rlk0Mk1aOXNmelA4OGxkTHFLQVpYRkMyWXgyakJVZWlvN2RaNit4SmFtei9i?=
 =?utf-8?B?aUFiUmF6UUtlb3hMaHIxQzdXaG9LUTZVRTlSNXppSEJldk9UaUJ1MkxNd213?=
 =?utf-8?B?cmFobHh1QmVuN0thUWJSRTZzNWNkVnMzMkIydXlRM1UvK3VZTFNJVmlRSk5t?=
 =?utf-8?B?UE9zdXo5UXMwTU9RTTJ3LzhEZGYwU3NaZlBraCthZlJqdjJrcllDU2dKemR0?=
 =?utf-8?B?eWFPOHNFSGJmSkU3WWdaTi8wUTd0VUQwdkE1R09kZXNzVkJVYUVnbDJlU01k?=
 =?utf-8?B?UE1GeWI3bkZUZFc1NWt2STQySkJqNDcvVThJZFhrSzVYYm5naVFrZnFadXA5?=
 =?utf-8?B?QnJFcWVXWTZVTkJGRStKWnRMekk0NldpSzUrMlMxczFpMWw0YzE4Q2xSV2ZM?=
 =?utf-8?B?Rzh2VHl1RUFqOEROQ25MY0xoZnFLOTA0dVZCcUtMeFRsTEh2Y3hJMFJQYXpt?=
 =?utf-8?B?Q0JPcytoS1gwQnQ2SjZDNFpOTmc0TlN1UDJOTXQ3azFJZXJCSXNaMTN3R2Np?=
 =?utf-8?B?bWdWdjhTcEFVL21JVXhsdnREc2k2T081QjlTRENvN3p3aHRGSHhMOXVHWlFC?=
 =?utf-8?B?L25qRWJLdU9YdG83NTFYZlEvN1ZVeG41NWtxRTRUdHlqRi9HalZkTURlc2ti?=
 =?utf-8?B?V2hNblVIeXhHNWlnd0U0Z0xBbTZTT00vdks3V09nRlVhdkFyVHVDd08wTmhK?=
 =?utf-8?B?akFjcVhlVzUyNThXaDdidWRSS2EyWUtzMVB4NnRzVmJHTU95RENjRjRpMisv?=
 =?utf-8?B?Z1BNL2NuWXNmOVd5eGM1Z1JjY3NXenZwcnExS3BmcS9VVHV3ejB1ZUNPN2FR?=
 =?utf-8?B?UVdmNmRJczI0bWRGTUtwKzhBaWwvK2tFYWhsYmkzaDY4N3gzOWxkeGNQZkRh?=
 =?utf-8?B?OFVZc3kzQnM0U0xiVGFaY3ZEWjIwaVFOL2NjRzJJTzNUcEFWNUVld0l2SWor?=
 =?utf-8?B?SDlrb3VWdWc0UlRBaStMZjZFeFVxeFNPVk54b2pHMjJGWS81ajF2QTVvS25H?=
 =?utf-8?B?dWxRZTA0MElKUE1Ubm15N0VzbnJoc28zbmJEWUZEdXZoeGg0OHk2VXlycHRy?=
 =?utf-8?B?REhEQkNxV0ZNdmJDUTB4T2xxOHV5bUtiN3RJK3haTTk4M2V3cWNkd043VUQw?=
 =?utf-8?B?TmlRc2JDRUFUY3VYMzFvQThENmF0eTN5elEzOVRhOEx2cXRRT1BJUGZsWlow?=
 =?utf-8?B?VXZ2cDVCeXJpWld4cUMzT1Zxd2wzblpRS0NscVIzUHhhTDBNN0grUkQxaFRB?=
 =?utf-8?B?djVDVW5WYnorK2Rid0FSVVJnbkR6ekdoWUZZajBxZjFBcys0SmRETW9saHF1?=
 =?utf-8?B?WDkzZ1VvTUVuWlNoRTZxckV5Y3EzTjgrZHIwTXd6cTAycURnWG1WZ20ya2JW?=
 =?utf-8?B?cEl1cTNQaUF1bE8xcnlIbUdQVWhHakxFM1JSVnFsVWdyK1d2ZXREcGIwczg5?=
 =?utf-8?B?Tnh4a21teFNKcWJrZkFCczNwL01ETDJaKzBUMkVra1B0YkloSTJDcGk2L3dn?=
 =?utf-8?B?Rm0vTVIxbjdQejRoZ2hCVkJmRGZTTEVGdVRkOU1VQ1VYTXhGa012M295alFh?=
 =?utf-8?Q?K4GuzAJKsDo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L24rVnJaZ0dZTDB6eTVBZjJtcFRLUm5RT1NmM2FLcTBaVXVELytmUVhrUDJL?=
 =?utf-8?B?U0JreHJOS0dUbFcwU0lac1dCUzZDVWdPbys3QjJOY091Q2Y0ZGdFMzBJYkZZ?=
 =?utf-8?B?U1lDeFBXS1lRV3RQOG1nTzZ4UWZnVllLUVVOM0xCOU16TjY3VzY0OUcvMzVr?=
 =?utf-8?B?dDlKcjhwc051MFE2YUxYdlRVSGx0alRFMGJicFVYQ2hZeE9EZ3I5dDg2TXpa?=
 =?utf-8?B?MEVlSUtsZDRsU0hkOVNxUUpiYVZyK01CcnFuZTlySysvakZKbTdZOFBqZDV6?=
 =?utf-8?B?TGZjaEdqcGVNanBzaFB6MnJLOWFqMGd1c09LK1gveUxHL1J6cE85ZE9oQ1NV?=
 =?utf-8?B?c1pHaExhUjgzR2wyRUx3a1E1NFFhR1lobFVnTWNaWXhqWFc5NjVYZWd2aTFz?=
 =?utf-8?B?SHk4bXZ3cDcxQkRlWkU5TFVScTkybDdsZ1Myems3U0FTaTBjdWVBeW9heVQx?=
 =?utf-8?B?QnJyQTI4UlEyWHdZem1BQWo5VVhTYSsrdjcrVnFWWFRkbHYza3lPNkUxeFM3?=
 =?utf-8?B?VE4yVkNDeFZsa0YyWWFudWVXcnNabjFqWkRzUDgzUU1WOFpHclp2N0JyNFls?=
 =?utf-8?B?ZHh6NjZ6d1daYzhPaFJPWmxobm12NWJqTTY5a1p3ZHZwVmxhS004QXJMUHNr?=
 =?utf-8?B?Q0pTRGxReCtqQkJQcDh6M2Q5bGZ0bzBwTXFnUXdvRWdFVHBPVmk2UGdCYWMx?=
 =?utf-8?B?aUxzbjZTSnpHNGdvWGpSWUtMbjBJbGI1L1hjZmZGYnowdHM5eHlDTGczcTJF?=
 =?utf-8?B?a0FRTTNsTU1RWmxrYmJmTmk0NUZZSmtsMUgvTEtwWkJnNERxbTFNaGJaK01x?=
 =?utf-8?B?VzVMTVh2VldhYXBsckc4aktlendXZU1sU0dkR1NOYXdFbEQ2dE90akpuS3Ey?=
 =?utf-8?B?MmJBYkI5dUcxUHZVTkVTSmRvQ2tqRy9MTGp4QmZ5VHF3S2R2UHUzS2t6dWlD?=
 =?utf-8?B?aFdSZXRuMyt4WFYzeHU2eXpjc0VFMkNCRjBRWDdjbE9CUjNCcG1xL2Ntb0g2?=
 =?utf-8?B?Wm5jbzgxbldCWkY0NW1ubFJKblM3M1c4R2pDN0l6cFNHejN4VGJaL2c2M0Q2?=
 =?utf-8?B?ZFZNd21mTThmY2R5RmpML3VrNEszY0d6WmlZbmtxYmFKbHBkcUNLc1lpWHA3?=
 =?utf-8?B?eDltQlZvNU54Y2c5V0JjUXF5VzhwWk9FaUdGRi91UUN3ZXh4TlBFNXlsSUgr?=
 =?utf-8?B?VzQ3aGxKaXJsUlp4Wm5iSE5BcWVTR0t6dmFaUUNvcjVEM3JzQTBmOXM2Y3Zp?=
 =?utf-8?B?bEhqRWwvbjI5cUZZQjdoTVh3Mk93cjBDV09hcnRkRU1ndEIvdGQ2UDk0ZjRG?=
 =?utf-8?B?WUhaazh3UHhEa2kxU1oxeDJKRWZpd1lGeVdvcUQ3ejFHc0Mwd3RFY0VxbjBq?=
 =?utf-8?B?eFBhRGcyN3A4b29oZFY4VFF6UE04dFRua3RkVXZUdEdNUHUwcDIwQ0MwcGc0?=
 =?utf-8?B?TjliQ2wvMVVDaEU3alp2bzVnb21iZHVBNE1XNDYwSGtQdGNWRlYxUkREWEdr?=
 =?utf-8?B?ODRwdy9saWdGUjZSNEhFemtqRHdvZTNGYzA1NTFJVCtRdmF2ZkhtcmlFVTJ6?=
 =?utf-8?B?WmNWQ2NQQmF2WmpOSWh0SHNQZW9iSHRCcVpQOWIvKysrZnd4T3QrYnRYcldE?=
 =?utf-8?B?NXJ1YTFORzUzazYwckhOaElOcUpRT1IxaGNBMVpwbFpqamVnMEI2aXc0VkVC?=
 =?utf-8?B?MWp2QVFkb1E0NnB5Y0hmQ3BhOWpiZW8xOXNtUFB1eVlURkRSRnp0Ukt2czg2?=
 =?utf-8?B?YmlYRmFISDFSeWJocUs4R3NQKzQrc3BDRmNIc0JtV3FpWVdyRmRJQmp0TWda?=
 =?utf-8?B?ejU3YVdSVU9vTCtBU2V0VXRIdEgwSFNQQVc2R0ViZk5sanBKeWZNcHdUVm9y?=
 =?utf-8?B?aUZHNWtWeEtQTEI2TFZGMXAwcDV0NmVFeHdqQlRsZFUraU1oc3p1dSs1enFa?=
 =?utf-8?B?VEduZllnTWdaSjRZQmd1VFMvZWM5ajYyT09UNUZMbGRJclJTUUIvUnVmYkZS?=
 =?utf-8?B?c3ROTjI4cXVzYlZVTnhyanlGZUpKamhHUTNYRWV4d200S0hTUzNKYk40dHk4?=
 =?utf-8?B?VkttK3plV2Iwc2dTcy8zUjRPaW5aSmFqc1lxUEYyZUJZTWl0LzAyOEUrZE8y?=
 =?utf-8?Q?7+6sgZrwlEatinC6POLX3ERjk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc40369-fbe3-46a4-7ce9-08dd91214f0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:50:40.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55ovgS/0HsB3Ki+w0Dzo/VOj2DIvAJAimMeG3CKZCKFur+PX3CgMIuGVn0GXvISQ6LaHON7pTEChmpU/9jBmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 06:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18892

On 11.05.25 19:37, Adivi, Sai Sree Kartheek wrote:
> Dear CIP Developers,
> 
> I am planning to add support for the TI AM62P SK platform to the isar-
> cip-core project. However, I have a couple of questions regarding
> version alignments for both U-Boot and the Linux Kernel:
> 
> 1. U-Boot:
> Currently, isar-cip-core uses U-Boot 2024.01 across all supported
> platforms. The TI AM62P SK platform is supported only from U-Boot
> version 2025.01 onwards.
> 
> What is the current plan or timeline for updating isar-cip-core to U-
> Boot 2025.01?
> 

This is demand-driven, specifically as the U-Boot recipes are only
helpers for the demo/test images, not part of CIP's regular support.

> Alternatively, would it be acceptable to introduce U-Boot 2025.01 only
> for TI AM62P SK while retaining 2024.01 for other platforms?

Only if really needed. Default is updating them all. U-Boot has no
stable lines, so this is generally recommended anyway.

> 
> 2. Linux Kernel:
> I noticed that a branch for 6.12.y-cip has been created. Since TI AM62P
> SK support is not available in the current 6.1.y-cip kernel, we would
> prefer to use the 6.12 baseline rather than backporting support to
> 6.1.y-cip.
> 
> Is there a plan/timeline for integrating the 6.12.y-cip kernel into
> isar-cip-core?
> 

Once it has been tagged, but that should happen rather soon. We
currently do not have any cip kernel recipe to track latest branch
heads. Adding such an option would not be a big deal (see e.g.
xenomai-images), but no one asked for it so far. Would you see benefits
in having such a recipe also in the future?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

