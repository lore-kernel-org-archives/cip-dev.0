Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9AC00144
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 09:06:32 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.45])
 by mx.groups.io with SMTP id smtpd.web12.5942.1659085587366256016
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 02:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rLa+hCJ0;
 spf=pass (domain: siemens.com, ip: 40.107.6.45,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVoYZ8RMbuC5zXYb23DrYLis1Uom5R16h9tsS7kvotLouwXBiTywaEScFWL5sbGcz0EeLTG1TAukfZMoJrIBporiAQoScFaRQW+h+fv2SCG5W1xXqe3shEG0oP58Lw+OBtx5iQAgxg7ojPUv478O91eHc/e36OtCL9RICvy8aW5IXv9g+hTptmgjHrKfUKh+eleKgPWrjo48A/Gj3M02I/T+C6qX8/C+iWbv7Do6F+iIx4nahRVPoEmrD0dUDM/JUFHSy6ZQcRUrp7IA+NC4R9nXiksMFnDsZuWgKs7L7lnSN7oJyz2X09eFloAZ84ddfqXshFl6a51xUeaeK2r12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0dFB1oqPhaFejwSDSqV4SjUwIbwlqnUGQIvibnqQx0=;
 b=cwgtwLbqbshgJn9RFNUS4jNfca8SciP5Gis2LNCCve+Xo/BQoxDsczScHdO9biBOjVg3vZa+6oGZkcr7n3wUXfGkdaqS+CmifuBqEbHPymhdk8hCstIr5HNoS1RClh19K6nTLWy4MtBzL+Ldke/Rr3DJK/Hn+ODejKD6c49tla+nA2m9gtu3ye22nr/eMo7CQRZ6oXZbbSh5UYNFog0ORQg3pEOQtffb17t0um1Zvq+8YlXS0fdr6pFlyXgPj13nVQHzvFU/RiA7ZxUYi1tm6EV5Nz+3cHo1cST7u2eXezr+rJAWlXJsaKImHKH/OXxLky6e2Ol9xt/iGMZKtkRGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0dFB1oqPhaFejwSDSqV4SjUwIbwlqnUGQIvibnqQx0=;
 b=rLa+hCJ00x1Kj97XmHAHAHHgKj9Sv7vs2kWOZEwns4HEaq422yZPqGxYkQFIhqWrjawA2ngKVpSoeiKEQuR4WEy2+crfABfolJ+lLsN36p0cxl8ocChJNU5RD0+PxCBqKtjeGwbPuFrIeFSsgdDrbz7IskFsaxDY66vqjqpIDNp5RwCOoB3cPEfLU1VDDfbNnJONTl3xm5f8RUoGqD4N2JftNXDpwHDK7JwaLGQRmaRhqV9cb16ztm56aNNviDELXo3AdS7MH2xKQr/NW2ofcW+iHJDddjQfO5T5/65fuB+Eo5tlWWo21nAyHkBnaVc6ezqmw2FHHW37XMeFyLnkSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:278::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 09:06:24 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1%7]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 09:06:24 +0000
Message-ID: <8cd5a594-7385-923c-2995-8bf62de0a85a@siemens.com>
Date: Fri, 29 Jul 2022 11:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] scripts/deploy-cip-core.sh:
 Use dtb from deploy dir
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
 <20220729083931.419731-3-Quirin.Gylstorff@siemens.com>
 <d6ce2432-64b6-6527-2319-408266fb9b00@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <d6ce2432-64b6-6527-2319-408266fb9b00@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0df5246-f71a-4048-8188-08da71419ce0
X-MS-TrafficTypeDiagnostic: PRAPR10MB5201:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uAPoUIhVQePNFBmIvnVcVdpBISTRCQvv6XbLbNtmnMgo7baBP2zA29mWJPsex8jehfRoL3B8axunp5PEd9rElS0a1rV2imqS98Gfz3QVl485wA0ZgWa3XIi1daDuGnh5J8kSb/wtVjSA+vAnb4GYJn3B8Fe1j6lLZ+6KzL2LLX9/W5mYPcBcYqLn0R7Y08odUMrmAVq8dev4AZpJbY7O+oUh+v1AWMArLEZwZoTXSkIEx5qiuC8xvPgV8uzgef+j0A14J8Y6VR9EyUJMHmD5kzceg+hU9FZot87I08dWx8lfZgRmCxTJKTbcOGFEXC/C7TpqA9CR0RC7f2T4vrtGaNQbXkk5qUvHHLF2S6Blyfx1qrOagb4Y+MyA4xNhKaR2TPrd17EdM1axodNLiIEareq/XP/2aVZkIeKB0iJnVkIBGcc4RVrhPZ0Pxyv/AB7c+YenR0RZbr3HuxfQWbMqTFueK/ZzSOyN74ls9W69UamVF/liA4qbSGrEFOgzB56B2RuS3yeBPjrh0FsVVfE9glf8XN9HNLARVgrxWHm7j76cyqizrh9CjwSQOBaWcDy5lonPN5h0TJyzxuOwD3ajfbdK9Cchk9gXQlCNuq+lBUFWboyeetqhV2xLmoWZXbCj9H8hopPkpN3JeYCZb+Q6zKX9ePYvqwP/ugSLMh1J0juecTQZKBDM+wrQ2yZYxC6JPtAknYIQqh7iX/U0I5/179W/BC1perLe/nq677DXULxhRPIikyvqFAVx98hgJIkkyvRg3qQWZViXODT04VSsVU2LcniLJ56ABh0BAJ6/QDpTLzlUv/cHM8GECji/6qltOwYjNyZt3VAWqxOik40NkA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(186003)(2616005)(83380400001)(6512007)(53546011)(6506007)(36756003)(36916002)(31686004)(41300700001)(2906002)(6666004)(82960400001)(31696002)(86362001)(8936002)(66476007)(316002)(6486002)(478600001)(8676002)(66556008)(5660300002)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmhnWVVQZFRvZzkwa3hGYnZQVUZpNk1oTWsxYzltMHdSaFhhSHd2V3JxNkZN?=
 =?utf-8?B?WW5yQzJrQWxlK3ZLS3hFQ1FUbkcrTTF1cVlMY1NNZ01aUkxEU1pXUm1UUTN2?=
 =?utf-8?B?QTk3V3hBb0Y1aXkyemdzZ3lFeloycS9lWGJXSHI5VkFQaHBYbkgraHFMK01R?=
 =?utf-8?B?MkRMeWZOenFqdUtQOVk2QkEwUjlod2pMQUREeEMyM21FUHlyU2VTYVh6aTVr?=
 =?utf-8?B?Y1NBODdXUFRPWDF6c2I3dlpQZWl4UE5ub2dqREJjb09TL29WTHE0VjMwTnV4?=
 =?utf-8?B?N0FZTnJCeTRSVzV6MmFqczU5eElKZ25SN2xPQ1pZMHI4bTZYNjFRSW1rRUNP?=
 =?utf-8?B?WGpTbFhZbGs3dVBUb1M1Kzd0Vkg1QUlTRjA1Lzl3T1FuaHcvdFZvcWxQZCtt?=
 =?utf-8?B?THFHU0tNakhCdFhvaTNyS0dRR0ozcTRCMGFzUUVJRWk2VnpsZVJ4T1d2OVVa?=
 =?utf-8?B?SzhiYmRJc25XYjU5d0ZERU5rUllCcGltUitjZDVuUFdJZ0ZMRDFtQ0I0Qlhp?=
 =?utf-8?B?VzMzTm9KNEN6K0FEdnlZQzhqeUsrM1lOMjVmWHlXQklSOG5OZVgwQk1WOEtw?=
 =?utf-8?B?em5TdjBzYXYwNW5idE1hUTJjcDE1d0FLOXZKeVJLRlZUUnNsUFBQQlpwcE9E?=
 =?utf-8?B?Q1NROGE5enF1WEwzMFJudHM0NnFYV2M2OGtaREpaVURicWRjaExOZHZ1S3VG?=
 =?utf-8?B?WEY4OElmVjh1dWZXQlUzRXRPWDdXMFVRRnpYeUc3akNJSWd2N1F3MlRtOGIz?=
 =?utf-8?B?cE8rWStscjdZSjFITTdjODJxUWtIVExqcEduOVh0N1pyQnorWnMrajJCdkNB?=
 =?utf-8?B?dml4dFd1Y0pNSTFISkFrZnhsVnU3dUVySlhjdllLQU1EQXZYTkRBeCtWOVpx?=
 =?utf-8?B?TGVId3ZQREpsb2NSRG5PbHFRenB1Z1hVTmVWNS9QSmE0MmVEN3hNUDFpTk9p?=
 =?utf-8?B?Vnova0kvNXRrREdLenozRW1wc21VRU1oaS9uZkZWNVpDOFpIdzZRbmRYdnM5?=
 =?utf-8?B?eGdob3hzcEU2eVRqMmNyOElmMys0cTl6QmQ4VlR4TG5TWGNvZnRXdk1vMG1m?=
 =?utf-8?B?SGxHWVVNdnJSb2FkblR0dGhreWQ3aDB5ZEkyckhMc2xqSGR0MENuUzZIZVdB?=
 =?utf-8?B?WXdpWkhRSGc0RE5vbWVuSkZqbnkrS2tHeXdpL1FQazhwZVRRcDRMZlhlUXlr?=
 =?utf-8?B?bVFWa0U2N1B2bmpiYnBBSjUwL0pQUk9jVjdndTJaNGpNZmc5SWFUbllvcWgw?=
 =?utf-8?B?OGozRkdiWDRzb3A3ejVVRkVZT3E3VmVmTU5NOVozZThINlBnZEhXbkpQY3JS?=
 =?utf-8?B?WDJRMTJhNGNkaFkrc2Zud3pabnhCVzdWc3dDek1HNjdNUkg0YTVVZWNyT01s?=
 =?utf-8?B?TmFLZi9QZkFNeDVkc1lTcU1iMkttekcwbVQ5WUFKckNYbVI5akMvR0pRSGlD?=
 =?utf-8?B?L2pmV1R0NXdXSmh0bklHd0dMWVJDdDR4T1kvZFlHRzVid05LVnJzYVRCYTE4?=
 =?utf-8?B?UWNmR2lYMUpzWGhlVVdxT1FTTTUvT0F2M1I5bXN4aFczdHRGWTRZUEFuTUVN?=
 =?utf-8?B?aXdCbHJBb2FSTTNEc3V6WUNLWVRUVGE2dmFpNjRVSnp0dXJYU1RUclNiWkp2?=
 =?utf-8?B?eGpjbTlHWXg5c0ZFcjZkeFlsUC9JU1FxYnFMREMzbitkOGZVRXpUQ0RUTHFy?=
 =?utf-8?B?R3dlcFBuZUpIL1FncDlhZVJ0RFRUaVlkVU5LTlhIK3p1dHBnSVBuaHo1dFFV?=
 =?utf-8?B?SWQzblRDSHc1ZGpvVjg3UXlTVzBPTTRiRlM0V3pub295aWQwV3dwaytYQ1hl?=
 =?utf-8?B?YlNqeVVpK2E0WkFxQWErSC8yNk84TWpUVVNvZVk2a2JQMHlEK29MMFNXWmhS?=
 =?utf-8?B?VXVIU0ZSdURNYVlkZTBYOUErNUVoNlR4NnVRU1dlNE1kZkx0Q2tacCtCbDFJ?=
 =?utf-8?B?UDdMKzVkcExDeFVJN1pYdWRDU01HcDNEd0xPL2hPR1Zrelh1VUd1UVFlZWxm?=
 =?utf-8?B?NStGd0JPenM3UEpaeWNZUlh2U0xuNUFjMW1FeHdUbXVhbml5eTB0bFRUZlR3?=
 =?utf-8?B?R1lpWDc0M3RMbmYrV1YyOUdlMjhvcDBGWFBBdmxCMkVjeGxRa1JMaE51WGtT?=
 =?utf-8?B?WDJWcWIzaGVydzdjbFNyVnhVbnh1MVNyOUwyUEwwM0tBbUlCTlplWFBZVng5?=
 =?utf-8?B?NWZ5MDRhbXMzSEpSNDM2Z0E5Rld6dERka0pYcGFHVVZtNlNWK0wwMUVwdHl5?=
 =?utf-8?B?OG8ybTRjS2xkU3luK25oazR4OXlnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c0df5246-f71a-4048-8188-08da71419ce0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 09:06:24.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 WhVhXjLA5L2dU/WUBFmRWyGkOblfkq3MD9ToWdOOT8W8lXyX+yCORYopr4aGt9Nlo10WaNM/gWTMt7WHa/ciO+DYzciCCimaoYx9LRXeUZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 09:06:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8979



On 7/29/22 10:58, Jan Kiszka wrote:
> On 29.07.22 10:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the build errors after sbuild migration as the build
>> artifacts are no longer available after the build.
>>
>> This adds the DTB file for the beagle bone black to the deploy
>> dir to fix the CI pipeline after using sbuild.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml             | 6 +++---
>>   conf/machine/bbb.conf      | 1 +
>>   scripts/deploy-cip-core.sh | 2 +-
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 3d39d1f..41af3e9 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -68,7 +68,7 @@ build:hihope-rzg2m-base:
>>       - .build_base
>>     variables:
>>       target: hihope-rzg2m
>> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>   
>>   build:qemu-amd64-base:
>>     extends:
>> @@ -166,7 +166,7 @@ build:hihope-rzg2m-test:
>>     variables:
>>       target: hihope-rzg2m
>>       extension: test
>> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>   
>>   build:qemu-amd64-test:
>>     extends:
>> @@ -271,7 +271,7 @@ build:hihope-rzg2m-buster:
>>       - .build_base
>>     variables:
>>       target: hihope-rzg2m
>> -    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>       release: buster
>>   
>>   build:qemu-amd64-secure-boot-buster:
>> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
>> index b592f4d..ea87ed8 100644
>> --- a/conf/machine/bbb.conf
>> +++ b/conf/machine/bbb.conf
>> @@ -7,6 +7,7 @@
>>   #
>>   
>>   DISTRO_ARCH = "armhf"
>> +DTB_FILES = "am335x-boneblack.dtb"
>>   
>>   IMAGE_FSTYPES ?= "wic"
>>   IMAGER_INSTALL += "u-boot-omap"
>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
>> index 203ab1d..01aa494 100755
>> --- a/scripts/deploy-cip-core.sh
>> +++ b/scripts/deploy-cip-core.sh
>> @@ -50,5 +50,5 @@ aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE ${S3_TARGET}
>>   aws s3 cp --no-progress --acl public-read $BASE_PATH-initrd.img ${S3_TARGET}
>>   
>>   if [ "$DTB" != "none" ]; then
>> -	aws s3 cp --no-progress --acl public-read build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB ${S3_TARGET}
>> +	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/$DTB ${S3_TARGET}
>>   fi
> 
> Can't we do that before patch 1?

There is nothing sbuild specific in it - it only had an impact when 
switching to sbuild. I can reorder the patchset.

Quirin
> 
> Jan
> 




