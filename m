Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1BC04A6A
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 15:59:07 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.42])
 by mx.groups.io with SMTP id smtpd.web10.21181.1691683142358824305
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 08:59:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MSa5Ozpt;
 spf=pass (domain: siemens.com, ip: 40.107.7.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLvecpvkS2zN7F4KFQgzkvPPrk6ZEePsDa6XMCyo/meyz6kGQONnadeKcApgPc9+iUHkzfPCcuywP6MT94E3rXJc4VMKkstbu/4WQGzsWpuSyUN3W7rgF9Is3F5GsQVIcpQXQUSBd4YaoxJWCmTwBZWaEWkTr/Ctpwmxibrxjaqugiqwy9Ii7/iyqQEMm8Ila7nSDzjlc4K/mP+nZrLzOLL6DPcg5TFgmIJdnjSlB0nXEsBfPMKIoKpXE6mowHrcMo+IzL2nfEaKKPmyU4sLhXPOat6VoPrjiBmI1T6slC+bPCMxGXRznrng0UISMVxuYmAlm2tpWDr/EnpMqvsxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+5M+F+br/2hOfHeyEbgRZCYW2+MpWjyI7FLytp2V0A=;
 b=ZVHpbm8SgRBBSWd2ZbqOOwd3eIGQTLGgb1kqSnR+yJ7Q7jz0c8fWyakNUqcEYM2eimSJrGGg34WOsCTDqr0hxVKKKHcQk/5RSW/Jg8PXCiMvTAX+1Ivcs9wL6xm+LaqINevYk5NF/vwJSJ+65caPllNoq6gOsriDJaLOzDm8CfrJI+vhRhetNs2JpT1vJz2Ej7CP22xqmyufKpNnHfyyNhsUZCZUH5/wZsS20Kow0lSAKrkgf5imCCPH6DBnfxThfCzctAXxjt54gIDxZuFJ9XUGg5Jt9E2Rgu7ExWNZasgrHfHlKdSwhh4bm5VOyMvr246UNflSL69Fn1l3NvOOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+5M+F+br/2hOfHeyEbgRZCYW2+MpWjyI7FLytp2V0A=;
 b=MSa5OzptRo+LsJz1RnA27Cbt+4NgdCoBM79W2QnPkMpJbFAtnJYCznz8NDWQif+PzgG8wIA7IqFZQnTcUnIxal5mYiVUDisTEo5zdNE/PCHyIXEclB+rVBwTXLFGjUiV3UIDGEolZkm8uP8NJ/pD2IFInyRQ2qnFeabUTUizgjgDRZsQOOtp9IcZ5AwiD08esgT4Ti7JrfZxHQbNuhdsZnsPR4DZlGFtOCNhqgzHzUZQuAAQ/sBBwmXPS22sp8wuRTsm0Ci6DW3pKAyvHCNexFeRt8ChsjUrOVwcL8UQvtUL8xysOrgYcBsZ1hB4nnfn8iCjSUB5FPgVI47+VttEsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB5887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:58:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:58:58 +0000
Message-ID: <45e6785d-6d78-8d40-bce1-2606661730e2@siemens.com>
Date: Thu, 10 Aug 2023 17:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb1e92c-8e1e-4e8f-762c-08db99bab4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GXQ55PNbvZPONFNgZf2w77t51Ql60axfOgnZkT9x6bIOpS5rt6sOanDtsLFJU+zuHFvM7ZA15hFvwRzqblle+417rEAyghDIo0G5mbpu10L3RddEKO+fhL6KjZgFmQcGJBISkbmHMwYePl0ZynKbzYqmXsr5hlV9ndMy5lrI1lpe/Sk41z2sB9A2d33byVAnxH/rnSs6WPdSTnCS9tbDbvRVOQIlifc2Atn+4oKlNsmp/ecIc3tsH3a5a4PMrlTZJi9yBwIng56/4qWquZk+8bGSElpa+ArKHW52h/66qjXjA2EJhlwWBXhYjjZmFzUiXbopc4zkcgT7kH63d3baIEgUsZA4F2DS+VA5PpLwhhRyhBQHYYF/hdU0JpPLdFNzrGMWCpjkIpWlz7hyZ2VGMIspn0siqNjAsr8LE543KogXBijS3ENnjBYVmtgiQu/xj8skbJtRFJoe8d97r0ZaLsfIg+ApBUU9gMe0G+lVYJKM4QJOhgO6a/0j3v1D19KabLharl3370Ag1ykFhcKRxC0acepxqrQXwwPV/HI2CSp4e6R0UXYqMTt0IOMx36e5LEh6uibSiAaqjSc03Xkdf6/j+CKY02Efaz41aXC0ecFwXv73y5FVVNvJPoxtiYcGEyrKEzT0ljvcshInnn6ShQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(26005)(66476007)(6506007)(66556008)(53546011)(6512007)(6486002)(2906002)(41300700001)(316002)(15650500001)(82960400001)(5660300002)(8936002)(8676002)(38100700002)(86362001)(31696002)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGdsZzFlbXllaVB6NDRta2U0Ry9BZmdPaE9LTWxBdTRjMitjWGgwWFRJSHcw?=
 =?utf-8?B?eUxMQm90dXBhZktDNWJYUXZnUnF4c2dCTjVOQ2kyUnh4WTlZUTQzU1Naem1Y?=
 =?utf-8?B?YXg2OUVKREZUbUtTekZQaUNOMFVFamlDUWpOdXlCdnhUdkcwM1V2WnZWMlRS?=
 =?utf-8?B?RjJ3dUhRdlNnTXBER2JnME9tQ3VMN2s5U25oTDRBZUwxUlUwd0RzN1IzL2oz?=
 =?utf-8?B?VDFkbkFueUs5VTRqa2E4dUZqc1dxWVpDTVJDTFFLa1BvUW5BZklWa3hXNjEx?=
 =?utf-8?B?bk56K2g4TE9JT2Zpam5rQUlaN21EeS9Fc1pucGlrcVA3SEdVUW1TWVpUYVNy?=
 =?utf-8?B?QlhIa2t4Q0hkM3VQcFdDbEJyTzZ2aG9PbyszRE13Q21EOUxKVXNFVWVKdG9M?=
 =?utf-8?B?em1QdkF6Z3A0bE4yRnJzWDdodC9YTE0waEFvYmNVN0Z1ZFh3Uld2NGU2bFVQ?=
 =?utf-8?B?bUtieTU0cTczSzUyWks1cTBCcTVLTEVtOXNxOW1wRmpCMnhtb2gzVFE1Ymxo?=
 =?utf-8?B?SXdFbVFWbGMybkNSNVZrTXBJdm5LUjYza0NMa0VKUmFEa3BWdjNRazMrZlRH?=
 =?utf-8?B?MTRDUS9TMEVrOHhJMHhMTEc5SjVlbG1Dejc5NnQzVWp3WHhLSkNaR0M3SmY5?=
 =?utf-8?B?bFhzdVlCZFl6MWNQY1FYdXViVHlHZUd6eTZUdmNIT3hPVkxwam44QjBOdlFP?=
 =?utf-8?B?OW1HRmNJbDdVdEF4Rk51K3EwTTdvdXZHM3hnbTNYYVpodkEySHVXMTBRL21k?=
 =?utf-8?B?M1ZIRTRwQjJTcXdBeHFoREZBTFN5ZzQ0UkROUFlIRXJmWUJvUmIxLzAyRSt3?=
 =?utf-8?B?SEJ4WmsxejRwZm44a2w3bmNDdTRxbm5VZFk1RENFSC8yMGtlNGVBUWdMc0Zw?=
 =?utf-8?B?QkQvRGRFS3VVUk9qdVFRemg3YW1tZ09EbmZFemJ4b2Nndjg5V1lXaWR3NXNk?=
 =?utf-8?B?MlNXQkgwOXYwV29Ya2JFR2tGZmErcjcwNWlwSGdOR3Q0WXBWWFBuelozd0N2?=
 =?utf-8?B?SFNCQ01GZVUrcENuMHhNU2thRmRFNnlRSWxTYWo2d1kyM2ZVN0ZpL1lCVng1?=
 =?utf-8?B?T29Tbm9VZHltM2Z1Y1EvTFFWSlp3aWladEdmcUFleEtHbFo3eDFWS0p3UVBJ?=
 =?utf-8?B?TXpSaVRkUlJCRzE4NVRWejFHNWlkd2EyMWF4V2llTmdRVGkvVGsyMGRFKy94?=
 =?utf-8?B?cUdIa3FHSUVJL2lMbC9ycHlIZ3lKNHpMOEZYWE5CM3dXelE4enJHdCtjdFZY?=
 =?utf-8?B?a1Zza0loNHRXU21INyt5QUZXL3hESjlud21CenpWNERzbjdiOEhwMnZiQTFZ?=
 =?utf-8?B?SEdBRkZTY2lGOUlxZE8vcElUTDVSZndmMkdTNEJGWmF0WXRGRnlnK3ovQUkv?=
 =?utf-8?B?WnpxTHNtWUVXc1dqQ1NvMUx2WTVVNXczbFVkOU1QVTNJTGlQYlpLMDlHdWI4?=
 =?utf-8?B?UEROWWE1K1hTTGFTMldsREpNZlBFbUhJZ1NJTWZCRUpHNlZkZEFMelVqcEVJ?=
 =?utf-8?B?R2FGVW5MODFiN1R1c2FaUGJKM3N1eDBnRDdHb0hTZTZIcHhsOE82MW96MkpO?=
 =?utf-8?B?enlBTU5lYWY4NHFyWm5zMldtMGFZVE95ZGtYUXBrSVhlRXhhV20rZWcyM1Qw?=
 =?utf-8?B?SWkxbWUxbHJHQ0pQRnJ1RGhlWCttMUNoMDNhWkVUUnIvNXFXUlNsWml2eXRD?=
 =?utf-8?B?ckhVeUJ0TWJ2R3pSbkdPTm4rSjhudE9zazdXdkxFbUpTVmNuNFF0SndhczB4?=
 =?utf-8?B?UDd3Zlk0QWpWS2JjbC9QMHQ1aUl1Tkl1MWprZHpXTXZ3Rzd5aStCS0l0VU5n?=
 =?utf-8?B?dVdOZ25pczJkS0pUTkhmaWFUbWwyS1gvaUthOGRUcDNKemZJMWVzT2dvMzdX?=
 =?utf-8?B?Z0JhVytzeE1TQ2xNV0NyMmxYaWpiNExIUFdBM2dvdmFXU0d6TnllVEN5Z05n?=
 =?utf-8?B?a0VvZHQ5dlNhRzRQc2IzMFAvYXo4c3VLeHE0V2Vob09JSk1QK0VOZ25hT0Nj?=
 =?utf-8?B?bHJXbm43YkN6d09ka2N1YWZGVHFQQWhFL24rNlllL3VSRkpwbkNndWNwWDRC?=
 =?utf-8?B?NUlVbGh2R0RHcHBVbWprcGw1UERCUHhpZnd4WnFNUFNSVmI0bkZ6Nkp1eU41?=
 =?utf-8?B?cmI1aFpDeWJHbUorUWNzYldma1JmRDg5ZWZFNnhJUmJOVVM2TERvblc2cVEr?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb1e92c-8e1e-4e8f-762c-08db99bab4ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:58:58.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTWJ4HmspACKsEt+hE+9gATl16N9XoBN0CQ1IP1vOpYlyAhWuIqDaOUyfWVFOPxiMKKgyuH/MlJhvOu9d/wFZ3/n5gwxKoIYM4DUhC0pV18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 15:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12606



On 8/10/23 16:47, Jan Kiszka wrote:
> On 17.07.23 12:54, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> With this change SWUpdate requires signed binaries to update
>> the system. An update without the correct signature will lead to the
>> following error message:
>> ```
>> Error: SWUpdate is built for signed images, provide a public key file.
>> ```
>>
> 
> I ran a build with SWU_SIGNED unset, and the result rather gives
> 
> [TRACE] : SWUPDATE running :  [network_initializer] : Software update started
> [WARN ] : SWUPDATE running :  [scan_mtd_devices] : MTD is not present on the target
> [WARN ] : SWUPDATE running :  [mtd_init] : MTD is not present in the system
> [WARN ] : SWUPDATE running :  [mtd_init] : cannot open libmtd
> [TRACE] : SWUPDATE running :  [extract_file_to_tmp] : Found file
> [TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   filename sw-description
> [TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   size 1219
> [TRACE] : SWUPDATE running :  [extract_file_to_tmp] : description file name not the first of the list: linux.efi instead of sw-description.sig
> ...
> [ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not installing ...
> 
I will look into it a send v3 if necessary.

Quirin

> 
>> If unsigned binaries are wanted readd the Build option
>> ```
>> DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> ```
>> to a swupdate_%.bbappend recipe
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/swupdate.yml                                   | 2 ++
>>   recipes-core/customizations/files/swupdate.cfg         | 1 +
>>   recipes-core/images/swupdate.inc                       | 2 +-
>>   recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 ++++++---
>>   recipes-core/swupdate/swupdate_2023.05.bb              | 8 ++++++--
>>   5 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index b0293ce..0e30e89 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -28,3 +28,5 @@ local_conf_header:
>>       INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
>>       ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>>       ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
>> +    PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
>> +    PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
>> diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
>> index 9ee47c7..3e2b45c 100644
>> --- a/recipes-core/customizations/files/swupdate.cfg
>> +++ b/recipes-core/customizations/files/swupdate.cfg
>> @@ -1,4 +1,5 @@
>>   globals :
>>   {
>>       bootloader = "ebg";
>> +    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
>>   };
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 5d9cd58..4983f7c 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020
>> +# Copyright (c) Siemens AG, 2023
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 2384f41..8f7a97d 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2021
>> +# Copyright (c) Siemens AG, 2021-2023
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -29,8 +29,11 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>   
>>   # end patching for dm-verity based images
>>   
>> -# deactivate signing and hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +# The option: "pkg.swupdate.nosigning" disables the required signing
>> +# of update binaries
>> +# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +
>> +# deactivate hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>   
>>   # add cross build and deactivate testing for arm based builds
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
>> index 26c0e67..762fac2 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -31,8 +31,12 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>>               file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>>               file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>>   
>> -# deactivate signing and hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +
>> +# The option: "pkg.swupdate.nosigning" disables the required signing
>> +# of update binaries
>> +# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +
>> +# deactivate hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>   
>>   # suricatta wfx requires suricatta lua and the dependency
> 

