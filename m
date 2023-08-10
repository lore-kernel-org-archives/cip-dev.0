Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE8C001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:46:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.68])
 by mx.groups.io with SMTP id smtpd.web10.15119.1691667981026767826
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:46:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oR7R2BJR;
 spf=pass (domain: siemens.com, ip: 40.107.21.68, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We/fBgPpIzBDMz9gjcvYMM1Da3TaM/xEL70o+65Gf8oycK9/7OgW58NvdDZxjEa0Oa6jIaWLJVmVj/Wer38mdqtojIIi/DdebwW2i1O70xwD+hnW9Vel4nxKx582Q05wCANo7J/i65dwR8cKhT2oSa8zOG3Mbfgn2tNFEZmFySjSrkrCzbNag26W9TyRU3RRl3E8Py7j3i6pe67CJKl8PNYaRG7ylINaeBfOo3wnbXlNQHygX0H5GdRPoVUb5Cg/sVd8DJOrL2ejpT/Tu4+UQKiTSylDKX0DIr+qEo6/GHdILBZXWlFGP/vUon6XMsqZn15sxKjwCfGINCL+3YtZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4CmsinhM0UQ6wgKU+Oku9D0/ScgZFW02E1RjQQObuw=;
 b=WMtoIwKKAOz1UjnTtZ4HfUjITfMgK9ZdF1FQLN6C70FfBZ/DpDZ3a1iltXqfrdaCNPuSJ9ZV7anz7xCmLlHMil3IwqWGPiD1xauwFspKTrWB53M9M93lprrAdiGLDpm7g0Tfrbi7WQtEZu21KE24xPxvVvc7FPX8JbhtZrubNM4I1Xnd2Dke7BQ8TnhzOzV0uBn4RUDeuG7FieTb/g5lLgvx6K4kgK9D5QQ+TKz3Y6vSFXDm88P+Ljzl27jKb13gnIa/mTH22NOTXI2vqI16P+P/ydbgm1O1sB9pPvsgBl5jZd5rtDuvSGIiG5dj9JvCsrfXMdYtPfcgPtq3LRLMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4CmsinhM0UQ6wgKU+Oku9D0/ScgZFW02E1RjQQObuw=;
 b=oR7R2BJR8CLx8CTpFpioHaUNxA0veRn6Ixm+eYh5HRtXIgPstLoFTyY/SEdi4YKCfCq3ESE7mrBggigEtbhDN8+2LZzoiMZgJ1z+PZ1xxj0HIST8c4D5cAhzT1S5G3J/PrB20yOYBvpjZCOM2z38MmRvf61RrFjBSUzkAAUGvmGHHda/hHlphWzK+V4bKR7Ry7R4PFcy2T9BGCV/796ngKBasDMTE0fDiJ7eeJ4/ihx4b0eGEEA3nHIRrSLD9R7963d9+Q4yzU4Zz1JBKEzm7+tCAoc3Xpwusno0YkyguuuR3QPjYLHJOAxAi6nJ1X0H2FeF5fv/JLVPyhL+o93CQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VE1PR10MB3838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:46:17 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:46:17 +0000
Message-ID: <ea49f7a3-0723-94cb-7af9-79a9c84ef766@siemens.com>
Date: Thu, 10 Aug 2023 13:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <14e1c827-c770-4f84-8b24-279dc54699d5@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <14e1c827-c770-4f84-8b24-279dc54699d5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VE1PR10MB3838:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efa0626-b0f9-489d-5e10-08db99976832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6yZY0HnocMcQe78CYD5KkyGsadmN7IbxqRnrFmDrE5VKcyFJm+AxXsBCdKDrtLYm04jUNTR3tNEzmCe2HS3MCNk/ToD7oPkzSzVipxP0Jg23qamvbPtY6dQBvwnRVgor7J6Ca3weZuwbsWoBbV50RRfz/NBQhcMjYgIGkEEOzTmSiD0RF1LeWvsn1BORcBz92fr+G51hC/g2K5iH1wh+mpYUZz49AR8CIgbQ7AroIlAPvtGdbZmcmVoBLCV1sedjC0Ewcq+PITZS/aOOEv/xus8epU8rl+4IZcZ684+no19r7Y4XIC5QG8FzIwPbwX9fL1cwSQhsrUZx9VOtIivnzZ8frCmtQIPc+o4gmzsATQGTisg8slnRzJL7pcOwHne6QvR85QMvYUgUueab05UPYb2w34FnchyCgeMorYkftPBeTEpDCBE9sdJlT2Nd3cwm4+yQTfcY6NSIkF90dQFJr7GFD2ta3ZoVKwRGy+D1OSCSEvhU9oqG/AGEYLLhx5z8oKbh/raUyVwBucWRMsKM7kl3YYP7a5KLdxtGAuE/YyQXw5XXDdd7hh95cvD2RpbK72S9jKabF5VD2IP+WdKsMRrvH2ZESGQDeUQLA77Z0oYzAEm74GXy8iV2NM7TCX1WDw6O02zWdYOk+L2zlRcFug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(1800799006)(186006)(36756003)(6666004)(478600001)(6506007)(53546011)(66476007)(66946007)(26005)(66556008)(6512007)(6486002)(2906002)(41300700001)(316002)(15650500001)(8676002)(5660300002)(82960400001)(38100700002)(8936002)(86362001)(83380400001)(2616005)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnpLY1dueTFzQkMzSjFJQ0VKOU1KWDJhRGloREFUaEdMWmp2Rk5YYjZZbTJV?=
 =?utf-8?B?ZVZ1OVlxM052TTJrdURmQUZueW1BalpSN1NtUmRVM0JQQVIxZFpIM3hnekFZ?=
 =?utf-8?B?SzREYW5JbXVkYWxMSHcvbW5PY0sxbEhleXNGUkVWd0VZdTVoYnFZcTkya3hT?=
 =?utf-8?B?b2tuWUVXdUtpbkRQL2pIMlZFbDBxajJMSVgrQzFuTWd4bFc2UGZpWnppOEg1?=
 =?utf-8?B?Tld0MWhoZ2xMZHNXeG5uM3pqd3ptaHVwRVgyRFROcHpOcHZVQnc2RHp2U0ha?=
 =?utf-8?B?dW9GcEhadmRwdkFWWkJjNWxPT2pyUmJNemdsRlA2amc3WGlORjdBY2lUd0ts?=
 =?utf-8?B?VnFmRE8yWDZYaDRzMXRKUEgvd0RkekhDMVBaOTExQXVXdjFYSG9IS0ZGMW9z?=
 =?utf-8?B?SFdrK2dsRU9mb2ZEbVVMWldPWC83L1kvUitYWmQwV2lQZEpQRmlBMkNpMnQy?=
 =?utf-8?B?NlVJSGZUb1MvYWtaYW5rZlVGUTcyL3gxU1BIU0J1ckswcWhsYVVKc1hDSWkv?=
 =?utf-8?B?ZGVFbWQ3Z294TUZlaDJ0S21wdExPaUcvL1h0ajJXRkNjQzl3UVY0UGZ2SE56?=
 =?utf-8?B?amNIdWFrZ0ExWXcyZmIxdlNBZDVCWDZ0cnBWV1BoT0pqRkFIT0owczJaSnNm?=
 =?utf-8?B?Z1AvYTA2dEdCYStDeXFFK3o1aHFhcktXZ0FrUmZQTGcvalNHL2x6QXJrN0VR?=
 =?utf-8?B?ZzRjazFUendrTE1KRUt6TE1sMy9PM0Rrb3pTdmlNYXBuT1dubkV3SVBHUjNM?=
 =?utf-8?B?ZjNyV09UY2xNeGZuVzAySDBlaGs0UnduKzl3U0RLYUVVYTRzVE1TMTZzSHpw?=
 =?utf-8?B?US9rSVM3RVd2WTRhZnY4dWxxK1NDcXBCb3J3MkRTV2ZRVEpDaG5UMnptaDB5?=
 =?utf-8?B?Q0E3czZRMktQcHY0R2FrU29abHZYblZuYjQyem5rU3FsWEtvUTVHY1R1N0Uv?=
 =?utf-8?B?RTFSaEg5TEdzaCsyWERZUHRDUnYvbmErdVRnR05QNkVVZm84WjhwUTVXZ3I3?=
 =?utf-8?B?K25zQ3Iya3ZIZzREVkNLYmJ4Wm9RZ2VxQldmUk9GV2hOTmpHRWJNUHBpKzVv?=
 =?utf-8?B?MEY2MFJmNTdRa0w0UlZ5czJpa2FQOFBydllwbkNZaEUwRURwTWVLa3lzYWFP?=
 =?utf-8?B?RVZMd1hFc1BSL2RXakZSTFc0RzhmeGRJeS9oRTZmblIzSVMvdHZ4UWxCWUdI?=
 =?utf-8?B?SDRha2NNc2t2YnBvbWswR1JoLzR3M3h2Wm1JeDlMVFdZMC90czVYZUFzaEFH?=
 =?utf-8?B?blVES0piNU83aVNuWGhtOUdBb001Qmd2eFIyTEpmQms1dzZaN0RxcFM2Z1VV?=
 =?utf-8?B?LzVZMzBiOUdxVERjMFpVS1FoSTlPUGh6aXNadEI2SVlYbDhEVkZYTUxSQjh4?=
 =?utf-8?B?L09OZWhYYmdEaE92d0dFa01VSzh2cGlncmNWMldoNzFwNStkNXpFRjdPRU5i?=
 =?utf-8?B?blJyeSs3TGJET29zbHQ5ZkE5R0ZteTZxbHhQS1dsb0Q1NUsyOHZSelVYTUpQ?=
 =?utf-8?B?cXo1V3RpNGNmSEpKdEhnbVJPMHVtUFJxcEU4SG1lN2NQRmVXOUdyc0pETlIz?=
 =?utf-8?B?a2tUWXBEZzBIQ2JrZXJwREliU1N6U1lkSXUwbzYzMzNYSkQvVjRidFNJVWZB?=
 =?utf-8?B?VW5GUU1tR20weEZuTWdOUXFKcmIwNEFERlJHNTVBQjRQY3pIQXZpUGROaEtB?=
 =?utf-8?B?VGpITktXR1Q0Ni9nUlMvSU84OGFRd1RpU281bFRoUzlsMnczTXpCalMyQXNT?=
 =?utf-8?B?WUpuaVVpSWJHNHVuVWhqRGJSTmNCbjFEYVoycy9QYkx4VFFNK0xXblVHK0pp?=
 =?utf-8?B?TEgvK3BZRUdlcHBkTHVlellKOW55cUxoSjNXWGVPVFdSOVpBV21XejNUWGZv?=
 =?utf-8?B?aGErMmh2cXhIZmQwWmNkOUd5WXJKbE10YlJ6YzV4NjZIQVJtTTRpSGQyMWZv?=
 =?utf-8?B?akpxMW5kZUVscmdJUUhaZ1ZYY2VQeFpyRTVOWHptbDhCblNMZlh5aEViMWZ3?=
 =?utf-8?B?V1pVbWVtQytCM0kxcWV4bkk0Q3ZOWDJnVFhtZXJ0MExrRjl0ZEZPeFNFSUlB?=
 =?utf-8?B?Sm5qWXdLbENVbm05TWJmMHYzS1ovYlg3NnRzK3lTSFlDMHBTbDV1cnp2RFkv?=
 =?utf-8?B?ZUNHV0Y4ZGc3cXB5RHVZM2phZGJVSGdDQXR3OVROOHBHWG15Q1MxV25LM0J5?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa0626-b0f9-489d-5e10-08db99976832
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:46:17.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr1StHqnnFq4wUEMDifhbUPn1R4e3y5qIJHdShpajMlzwFBlv3ZvBmgGmVfneR3ME9muNr2pMM42kiaA/t/OaC77Gug1mwKZ4gS6qcNEdD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3838
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12602



On 8/10/23 13:31, Jan Kiszka wrote:
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
> 
> This needs to go into patch 2, right?

It can go there. Only with this patch it has an impact on SWUpdate.

Should I send a v3?

Quirin

> 
> Jan
> 
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

