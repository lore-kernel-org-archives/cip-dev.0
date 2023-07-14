Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EEEB64DA
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 07:18:12 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.40])
 by mx.groups.io with SMTP id smtpd.web10.13446.1689319089777785438
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 00:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MyzCZfGX;
 spf=pass (domain: siemens.com, ip: 40.107.8.40, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN2k4K0snrM3RTi/isi+TUqKh4JcxbBJHzLvLiIskygxNqVFrOqcAqzy7LfLzw0LeFKl925amYxiXq21ziFDOCCHyqXciVrotVZZu+i/zbYaGySuxQ9ZJvf0aOKntoj46YtEhx+rGPXGfsbrglmEZurmrJt/tAgE8/ZdiZMxnQtsuCA1VRSaaYXF0MFKOojSc3TCKlYI9dQLIXMp5oWY34/eW225tDFVFrOQOZcZAnUpUGG6d8WrrpXAfPjrqXqVQPU/fghcGQ6e/zEvNd1tJ9FAGLcYjyDJl7wDtDqesU1H27ZI/i8TOK9jValkbOA+4Ok+KhFKzVbeBL0fBj9vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTsSlrzlLZa/UBobtYHhVfrNJObUjrllRcHlU5i7KBQ=;
 b=lj0MCoPgt5vY3XL7pig2zNJDSrJNO/W13/iqSfWebT4Savj5jMfLsd8F7gBXhA6FLcI2qhCazc8dTGZ16UwBW3OiUfKLTkNFxj6StfDVb6vVOXW/Yr3q0ALekSF7c/RmbEOzqS9XBO4qjEqKsUh6/UmRp5NUMb9mvt1bBF/aGdvDSYl8+a2yor62q3AWhptaW0b4mnVO6gsalQoRPKL5D9mcB+L23A9Ly689K7yl6fGED/kcGDEmyYcsjgspGQyfz1zXh2WncX4gdRR6N52Xwr3YkBQbTaxwRlN4Z7Q8qJ8rHcAEVeaCaSmaNgf2BIF4b8std173kjsVdLVmdmSHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTsSlrzlLZa/UBobtYHhVfrNJObUjrllRcHlU5i7KBQ=;
 b=MyzCZfGX7MTyM+x9FaK1k4ECOIS8FDbAE6j4Ruc5eoC6CCnDX47bkK2dwXpLuiT6A12+KqaWXHoo2B4UBUXSQSPkw2wd/ejzuMVmOSWbvMmKQc65JQ5X6z0WPs9HxA0cVEyVQ0ILdkrOnaFJvR79glWnZNAIhRbRww5hTH7em0jRoqGvtfcREZW6KiVCU6f2tCzE7W3FAKwebgYkBaCFadQyws9u2Y0lFEofmDOp+YvZ46qeWXXBuA9XoMEM8w6KvlwBkNoV3NJajKeMdYmnEV54/298zMMMNmk4x42T5o1pr/Mr8s5/L7/AkMSWE9QHvLIvdfl6MsEXsKEMTNn9Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB7161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 07:18:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 07:18:06 +0000
Message-ID: <09100b3c-5308-71c6-70e4-383809bcc46a@siemens.com>
Date: Fri, 14 Jul 2023 09:18:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] swupdate: Enable signed updates
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-4-Quirin.Gylstorff@siemens.com>
 <dd74be31-e7b5-6794-4b5b-8298bc97fa5a@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <dd74be31-e7b5-6794-4b5b-8298bc97fa5a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: e559cf73-a081-4fcb-217e-08db843a7800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3mjdVLz84d33kwJJwPuZnI6v1bt4+zKp+nHVEWt2eETBb9W/gM4AI6n8eIo9YlC5xmIjdUKx/NmYAvLP7ivZ3WME/83bCafutjzQNuMPax1nFs/yR03I9okObIKHLg6w2/BT1C+fo5BcIhyLEsXfwZ7pLmqiuweLb/lGsetd3ZwUEZL51VJwojfs7gL+ccFdEAtbb9civBSbcxzgCZsJGJo+a5L3sNH73gosbEORr+N21lBDEhOk9bUBKxS/masFpM8jbDEJ3OSYRQg1o47S0CCtXaQARwEFj19eRi7glNh9u3QPCRbneq6UrY8Tyc3ioWcrAEDStEfUXAGgT9Vj9LqvJgHcZuZTIPWiGKs60o2kU15lXVWCDNJ31Oit+VwEfGAtUICe55djHO2wuOn55NBKibsj0fAC+Jks2TwuRhwwq6sJ6bwvmlwtqn5pDi57Egw/nridtZaIJHKn4kl3sSfVZLVIm7/w77Qu6aRg4GGFtah/tji+mQeB7gpsTsJS1Fe8FfNd2+P3iAU+2yAgHaklWiHLsPNIkZGJdaCmBBbjGIEcwYPi5bclhItwa/rdXzPuwF/nyua5zZozO0NdJGtgljxhWjcxcw5VkJYPajnko0ePy/TAzT4VbT6sXKkiMsX9ybC6ANqdhciSmKHiLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(6506007)(186003)(5660300002)(2906002)(66946007)(6512007)(53546011)(316002)(41300700001)(66556008)(8936002)(8676002)(82960400001)(26005)(66476007)(38100700002)(31696002)(36756003)(83380400001)(86362001)(2616005)(15650500001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2UyTlRCbnZ2YTRFK0szaThtTWl4ZFlEVnhZTTZFaDJlc3dRM3NjTG4rcXJj?=
 =?utf-8?B?QS9SUnZmMFJTTEVaaVhSWEF0NFptWUUzV3ZiOVNsUnArNVp1VzYwVkt4M3VM?=
 =?utf-8?B?TzBub21IbjVCQU4wRGZrUGYzU1lWOVlOSHFlZVNIbmRFOVBOdk9jQXJEencz?=
 =?utf-8?B?SjBqcmV1bDZ1UEtOeFAyMURxMTVIbElVdC9JaXppTmlpcFVJdmZXVG9GWElX?=
 =?utf-8?B?ZFp2aUNLR1BhaUFYNWZMMGt1Vm5hVVhwY0MyVmR1a011MUhsajZseEowUk80?=
 =?utf-8?B?eUlCT1JtMGZjUWcvaERSUlNQQTIwZC9BUFVCVEgrYTNZbm1sWjQvbloyMDV6?=
 =?utf-8?B?dnZyOGxvYklXb21tU2V4V1pBZjhIcFREb1grWHpzQUF3eVVDTW5yZTBta3JH?=
 =?utf-8?B?OGVqM1dKTHJ6cWN5bjc4NDZ4ZmUrVEI0VllDcDkyWDhWMHR6YVZyeTlTbW1D?=
 =?utf-8?B?eEFNOFo2a05FNmJnc2lsQlRYTVBFSk9PdTR3Z09HditzeENTcitMa3ZmK0Q0?=
 =?utf-8?B?TklWSWEzWURPMUtDQzBPSnZrdFFCQmNGQ2pLNS9zMmVRM3JFQ0JJQnFwaXNz?=
 =?utf-8?B?d2d2eVNNdVRPMGFiaGhqRHVOR04yemNrK2w1bEZ0dGRoWlRkRE1nMzRQa0U4?=
 =?utf-8?B?MGdYaWVySURMdEpkOTFaOVUvOVhLSFB6cVZBc1VMVUpkSXVjVUlzWDcySUZs?=
 =?utf-8?B?S3NPZjF0R05OOEJvLzFGSkNFMDZNTUdDaHI2VS9RNU1KNUNwMlcxSXNHcDhP?=
 =?utf-8?B?dXV0SXQ4SkpXaHJMaFB3THlNVmZRQ2IwVWFDTDJ2SXlCM0V2WXFTVGRiVTN1?=
 =?utf-8?B?L0ZvdUJKZVY5R01BZTJZbFhUWG5NM1VkcFZhZGxpdFFraTc4Ymxsa250ekwx?=
 =?utf-8?B?b3dvWE90bGJhY2syRjRkZnVHVmtqZ2E0SEdET3JGRTZNNXZhOHR1SjVYVTls?=
 =?utf-8?B?MktQVjhmc20wNHN6Tk5vaGZ3S1c4citKWkZtT0FiVVJwN09QRVoyZnlkRmRD?=
 =?utf-8?B?MDFycnhxcnBoa0lLaHl0dEY1K2VQVEFMazcvVzRkbDlTeWllWm9hbU1WWnla?=
 =?utf-8?B?NG9ETWdkaDB6akhabjBwc3NkT2pOS0NsREI3QVhIblZnRzQ1NWlldG5wVXVo?=
 =?utf-8?B?SWlOQ0NSc0JjTFlITjhnUkYrZUx3RFdVVmpiZEJCa3I4cVd5ZndQbDYxU3Vt?=
 =?utf-8?B?cFA2OVdYR0hwcVFPY05KRU9OTS9xNlYzYWFLT1lJL0FxWkdicklkQlVuQ1pl?=
 =?utf-8?B?Qi90U2tpZDJsNDA3TXdPaml2V1dyTkxVNlh2aTBKWG9oWVo0elN4dUh0Y253?=
 =?utf-8?B?OGlQRk9hblcxZkZybWFuellFaHozMkl4QVc4aXd5a0loQk8zc1h0VEcrdnlL?=
 =?utf-8?B?T09hbDZqVUF2T2h5dGVSck9vSlBRSmZCS3YyUE91TUhJZVV4UXBrcU9JTXl2?=
 =?utf-8?B?QXlNTHdscGRLdGtUTVJHSUZzdWhSR3I5K1JveU4zY05VQWx2TE5sbS9FYlZl?=
 =?utf-8?B?aWQxcG1zd1JpQmFUekpMK3FvVGJ1a3VwYnZObUk0Tmx4MlNYdEZ5SERtVzBz?=
 =?utf-8?B?MFBubFI4azIxMGVWMGQyUEZlN0JZc3B4eUh5cjlmNGMrbTQxd1FSU1RJS2lE?=
 =?utf-8?B?TGN6Q2FNd3k3QnQrN3BBVVdxMjkxd1JUNkhSZzljMEFtUXFSbUY5RXlZWDZi?=
 =?utf-8?B?d3NkVDdnc3JWbVBYbnhkWWNlSW1lOVA2djV0Nmk4bHZHQ1REVXpCai9JUmpK?=
 =?utf-8?B?OTVPNUNGbC8xbFhWK0w1QVRVSWRTdmJwbmprMFBvOU1WL0VxeDV0RTZPOFpo?=
 =?utf-8?B?LzFrNUxVS0NuTm9ZRWZtNDhFRk9DdElZODF4THBkdEdMVFJLNDcySzNoY2pF?=
 =?utf-8?B?YnFacmNPU3RHelFaWEkxWkxiNFpKNW04cVlickdDZk12YVE1bWFLeTZQNjlZ?=
 =?utf-8?B?ekdhVjVZaGJwbFJjZnhVNnE5YnJNV0FxcXFtam9raGEvQkpoR2diYURlNTBN?=
 =?utf-8?B?VEdFRXJwNzVGejAvbTdmVHNXcjlBZUYvV2VmUDBVaXg2UEplZjJWdTgyMk1J?=
 =?utf-8?B?SXVoVWJzeFYzWGRIM3lUa1EvYmF1YW1iMkZxTzhMeUk4S201bnAxTzZNQWl6?=
 =?utf-8?B?Mjhwa0VKMVUyU0RRNkVvSlRDVXdLaVNZdmtOVFRjcWp2cHVIcXFwbmpFVEZR?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e559cf73-a081-4fcb-217e-08db843a7800
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:18:06.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Qh4nGqOwn0b/A89Mq3YPYQxzDOUBo0x+2jV9EVzk3I14evIAjF4U28rpPB15FwXVzJJLwt4XEDTKGEB640vDP67RYnT8U/5tU1+/lHCY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7161
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 07:18:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12343



On 7/13/23 19:06, Jan Kiszka wrote:
> On 13.07.23 18:40, Quirin Gylstorff wrote:
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
>>   conf/distro/cip-core-common.inc                | 1 +
>>   kas/opt/swupdate.yml                           | 2 ++
>>   recipes-core/customizations/files/swupdate.cfg | 1 +
>>   recipes-core/images/swupdate.inc               | 4 ++++
>>   recipes-core/swupdate/swupdate_2023.05.bb      | 3 +--
>>   5 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
>> index 5d3ce10..a3d959f 100644
>> --- a/conf/distro/cip-core-common.inc
>> +++ b/conf/distro/cip-core-common.inc
>> @@ -14,3 +14,4 @@ KERNEL_NAME ?= "cip"
>>   WKS_FILE ?= "${MACHINE}.wks"
>>   
>>   CIP_IMAGE_OPTIONS ?= ""
>> +
> 
> Stray whitespace change.

Will fix.
> 
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
>> index 6a01abb..6b7da60 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -12,6 +12,10 @@
>>   inherit image_uuid
>>   inherit read-only-rootfs
>>   
>> +SWU_SIGNED = "1"
> 
> Shouldn't this be a weak assignment?

As signing is a compiled into SWUpdate and cannot deactivated I have 
decided against a weak assignment.

If we want to switch it on off again. We to add an overwrite for the 
signed SWUpdate binaries.

Quirin


> 
>> +SWU_SIGNATURE_TYPE = "cms"
>> +IMAGE_INSTALL += " swupdate-certificates"
> 
> ...and this installation depend on SWU_SIGNED?
> 
>> +
>>   IMAGE_INSTALL += " swupdate"
>>   
>>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
>> index 26c0e67..d744173 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -31,8 +31,7 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>>               file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>>               file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>>   
>> -# deactivate signing and hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +# deactivate hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>   
>>   # suricatta wfx requires suricatta lua and the dependency
> 
> Jan
> 

