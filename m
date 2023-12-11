Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74FFC4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 14:07:33 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.41])
 by mx.groups.io with SMTP id smtpd.web11.8999.1702303652177941119
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 06:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W/wgxyM1;
 spf=pass (domain: siemens.com, ip: 40.107.105.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqkxpShLH5kquc51P+ZaAF0xHFS+W04l/OPtMYYusd/2th2STy7jmuSzNrZXFnUAgzcuw5kX2zgSyGnbpGYRTtywJwPTdpwb6T3Dt5hupMBzp3W7nBM8gBsQvg2lDU/iUGiAVcf4j11n1WlfJS+6BLdbSTvURR7fw8xMaSVOgnXl9QdLixBYzDyH7A6j9jAcXiKKIRiuVZEIurOL455hLaDksZaMjXz2VYnkBa3rf8rpp8CSMpWl9Nrvlqs3L3+sNiODqCEe7/eT+JzS2Q+cHiG6dxPBWi0+zJlDP3C0AcMd1ieehb1alsCflTdo0vYDixAmPjP+vYp0dqwY5B9DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4xQPPTQrwFBLd3FSAsL8YjMDajIFwln1/g8sp6YJxc=;
 b=WVpog3G+EvnhwM70OrIHGeRxG2s3r2oFs0nGjBBFZCjFt14z7iFAbmhtXH/L4f3i7fnIFo/2dwq75eq8+Ie/aUi/YHZGnUW7IKRdPL3o66B18J3fz5gpmMYveQnsLQHGzLtwn/2u6xF5WHYD9fCLk+/vX0WuHDfBe9Sd45tS+WZkWUPWQ26M8DbgLN+w4rStDmggmjYx0y+L7zZBJQLjMi6iOmxrH+q2BEi5bS77hLtfh6nxoKhviqO26Ri7H0pezkzf8HKLJVAJt8jXqjVcodoc2UFaYfyR0yFD4IdDmRo/YmwXqJqdeGPrSQ11++QATsh4ab7roZ/oF5DS34+cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4xQPPTQrwFBLd3FSAsL8YjMDajIFwln1/g8sp6YJxc=;
 b=W/wgxyM13+RQK9qgS4+EdM/fIDlVUdAvR1cEakkM30WP5chF2plFt4pswLD1d/UUDq8o+KiwMF+jEkukUHFvaRnPm7zTUAFfXBrERNUsjPZKfVkc3fcvoJWMD7Dfqpv6w10uE2ZK+LeA0SWrEDnSLDnZxequhtFG3hmxSiN/5w0Acmra8VAkkZTDIiFTXZRIkmFaeTYfP/6c3k80FcIzD+dqwKkC2toUfBoqSRNI2a8EoDf1EOXn01Irm6ZyYLpOYqnxLgfje0JdkNqLzXNUftIWbE03OasS6kdMcwOo53RujorKR6McTIgB4Cj0T7a1SPRpXiYrWMWcG5eT9UrkzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 11 Dec
 2023 14:07:28 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:28 +0000
Message-ID: <3f622b00-006d-476e-a928-79b0a31dc750@siemens.com>
Date: Mon, 11 Dec 2023 15:07:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
 <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:610::40)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: e630e16e-71c3-4dad-f58f-08dbfa528237
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eF4Zr8N3B8NDWutAeRBYxB/dyaWwARR4loEAx4FQQJc7tLA2b8fBWB53PjkzXITo7cn2bR93rUBOPvPLNfGagGZnccJiYMpEI/eRKwOgfl+Encx6tRLxUWXtrOPOmbxIDhHlpCUxUxCYYynpfSTOrFWU7WQg78SyMMu0OECc3sj/TFqgPHQlOEd6RRllUcEeU7EyNUxLMOJ6bZAt52BQ5YKzTW7/N7R6RhV2nGfILHYHHPAVn7M897D1Fs640rGgzSX/YoD/2O1EMeAF7S86uLu8ethtZPI4D4Y9Yy5m9SNeF83UuHjV4ym7rqmJvK0pfOSi3tVrJE/qSdSvBwxgprOfXgZ8MW3LRySbWCSy4BrLlq0EXYh2Wix0a/m9kVgEIFZ4iEZvlnRV0/4ITgJYfA5zOZsPGtOi/UNZ/iEi1y+BAkRuKmyr4O0uvxVohbqhgYPWiOp5LNYXZCM0Wm/IBm2eRRSPqd1cIsSXJXrhcDXNedOgDrL3njIncXxb5KzDZJdtklSsmtq+TT6U0peACYE8VfCms2VBBXpYPdJgdYuRsRFnXuPGJDv+wQFbab/TjyQjMSOeDt9S2aYvyE4of3Dlc7m7ihYTrwQqkz2R4if9xHNuh7+AcS8ITMgvmFIYwlybto5Ph8ONMgBwz7gLnda+u3hH6M13b9d4WIIIaqz3p/OqhOxK40JHWZaZh12PvCzJ9poxhtM97p7IWEgk2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(478600001)(83380400001)(6506007)(2616005)(6512007)(53546011)(26005)(966005)(6666004)(8936002)(66476007)(66556008)(316002)(86362001)(41300700001)(8676002)(66946007)(31696002)(15650500001)(36756003)(2906002)(38100700002)(31686004)(5660300002)(82960400001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGZ4N2dJRjZVT2tHZmp1R2kraVp5TS9scEhCQ3NVcTFMb2cxTEFoVEZEdGJV?=
 =?utf-8?B?dFQrSXVDc3cwcWlRUVVjKzgyaURjVkRleUNGT2dyYW13OTQzYzlnUTJNZlNt?=
 =?utf-8?B?RmFNYnBlRGEwVjh0cEkvM0lOL3Z6MjNKR1A2eERtRWE1ai9xWXIvV3JOM1N6?=
 =?utf-8?B?Unk1UGZmNERWQWFoYTRSazl6cXIrV05TR2NQaDI4ZUlCZXEzcWtlUTBHby9D?=
 =?utf-8?B?RmFYQUE3MlBKMW5UZERZcC9jak9CTUVPVUx3Qy9JTVVpZVJJQnh3QzdvVlN5?=
 =?utf-8?B?OWdOWjN3UUtVcE9SRGRqM2NwbFN3bXJ1WlNXaXNxY3RzazBtSGJtNDY5YmU4?=
 =?utf-8?B?YUpmRTZxYXQ0eHViMDNoayswT2NrN0YrWG1lVzFKZzNLR004bkpOa09JR2J3?=
 =?utf-8?B?UnF5Wjh0RmFyeU15L1VYWldMQzhiOE42a002MXpTOVZGdmp6REJaeTFkdk1Z?=
 =?utf-8?B?NEJHaFdtQnBFbU9XVUxVMXE5RDJEQjJXM0xlVm96bmM2WjJMMEN0cG9ONjZK?=
 =?utf-8?B?NDZJOVlCRUMzYkRveUo5cW1ueklRdGt4ZnAvTU5HaUNsdlZrSnZhSVhFVW8v?=
 =?utf-8?B?anQ3WWM2TThVL3dHLzBTNWVaSHpTN2E5MitoRUhpVHBXVkNpZGZOUzBmWmND?=
 =?utf-8?B?QVdrcmc4OWRvcE5HaGhDeFQxQmtFa29JTmxhYVI2Z01xSUFHd2x2L3daZjk5?=
 =?utf-8?B?b3ZzQlQvTGtZSm9GTERPc3pRbWI1VUk0clZKWlU4ZVViQlZ1MTNsTGRoQVVy?=
 =?utf-8?B?TUtOOEt2M3d1ZzNiSU5idm1WNVFZSXd3Q29HOXhLSUtjVFpmNjQrRjJ6OUZW?=
 =?utf-8?B?Y0k1T1IyaU82RTRpK1B2Q084RmRBUTVYa1R2bFRrREdaYU1Ba0MweUczVmpO?=
 =?utf-8?B?TVQzZDg5M3owaUlTNXRoOWVNUHc1MHkyeVk2eDZ2SFIrZC9Ybm44NThCNHEw?=
 =?utf-8?B?dTdNSkZpQ0dib1NjWnB4bXM3NGxhQkdtUkF0VUdvb282UGxvazJoTWQ3N28z?=
 =?utf-8?B?N1VOVGlkSkYydU9wWkR0ZzVQSDlvMFUrVCtvNlMvNWN2dnhKWmRDQU8yNDBC?=
 =?utf-8?B?bHVLVzNZMU1UeVY5SmFEd3N6QmpsRVFLT0N1UHRDQmliN0loWlFmSS9obWpq?=
 =?utf-8?B?WU43NnhtM3N6eG9qcW1WRmZIUTVpdExlYjhOQ0UrakhjSHFGaW44MTU0ekxa?=
 =?utf-8?B?UGhoRGZSNEVtRmNESENlQ3pWd0Nad0Q4Z3MvUzJYYW1VanoydVBLcXhPT24w?=
 =?utf-8?B?K2hYK3hCdTlMTVhxdFprS05YeVlVbzBsUUg3VUFnUktBZERJUktaSzUyT2dB?=
 =?utf-8?B?MnZiK1ZBM0tKSGJrc0VoZElSVkhmVGhUdU5DU0l1NXE5NG83ZUROWVJxSzVV?=
 =?utf-8?B?RktHb1ArNktyek85UVFhRTQ0WWxFM0RwN1VVYWxteE05Y1V3NTZIWHZGb0Jt?=
 =?utf-8?B?SzZPdlozYVBvMVc1WTJmd3hENGNwTWE0aEZEczhiY3dTK0k4dENhdTR2aEpU?=
 =?utf-8?B?b2ZHbi9vNURFWlEwbzJyVS9naGRSRWhvelRxK3kyb0JLa0VaNXJ4dG9hai92?=
 =?utf-8?B?bEh4SnNPOHV5aEZkcU5HZkt1STcyYmJwSFA3d2t0T0pXQ0sySG52Mng5TTEv?=
 =?utf-8?B?OXVGQWppb0svcCtUVi8wMmUycHpuZ1RIbE9nOEVySHJaenlHL1gyUkdxb1N1?=
 =?utf-8?B?cUFObFgwV1BUNXNxaXdMNnE1Zkw1NE8xTlZlSVdsdEdKdkIzL3FOeVhtdFVa?=
 =?utf-8?B?RHN6d2NGNTlyMG9RbHZSbWg2b092OUpXMlk1K0lEdXJ3akhEZlRJMkQ1RHBF?=
 =?utf-8?B?dnk4dFMvSk5PeE9BbndLeUx0bVEwU29wMXNybDhJZVNETUZZWHlFNGN2Ti9J?=
 =?utf-8?B?bW1MV0RHL2pZT0pYRXZHdWJiS0cyaDE2dzBGVXRzbTZ5eE1rZzZFT2Nadk9m?=
 =?utf-8?B?NDJZVlZXajdtRXJwSXAxVnlwUjk1bitpRGp2aHV1Mm1OMUQxWTJuSkVSTWJT?=
 =?utf-8?B?UllLcEZKb0tHTTE0MDNmVlY5WUxuVHJiUm5pYVRpNUhuWFBTQkRpZGd0OHV6?=
 =?utf-8?B?K2Z4YXo1ZlhCNVdwVFQ3MjQzVDVWZXA0dHdqYWFGS1BOYWpYdU9UK29jc0dR?=
 =?utf-8?B?YlJuNXE1NS9JL0ZVMzFxNUNZSmxRUXh2NUtWbjMvNjhGTFdDdU9hN1p0RGpp?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e630e16e-71c3-4dad-f58f-08dbfa528237
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:28.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwOJxRNchwO6Rad+2klVppN8Xr17F2JxEFwLR4CnaGpEwUoB8OAbo5gWBuhgW8xjXYdP3RwEztxJYZgJZ2F4zV8kpTuH2BojADd6T/2B0eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5323
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 14:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14027



On 12/11/23 14:45, Jan Kiszka wrote:
> On 11.12.23 13:19, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>> element is added to the sw-description to replace the ebg.
>>
>> Use python as newlines are part of the sw-description syntax an
>> therefore cannot be hold in a bitbake variable, see note in[1].
>>
>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>> support atomic writes or renames so a powercut can still corrupt the
>> system[1].
> 
> "system[2]".
> 
> But you are not implementing option B described there, just the even
> more risky option C. Doing flushes before the renaming and after it
> should reduce - though not eliminate - the corruption window.

swupdate installs files the property `atomic-install` with option B

copy file to tmp path:
https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L185

fsync
https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L222

rename
https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L233

If this is unclear a will add some additional comment to the patch.

Quirin

> 
>>
>> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
>> [2]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/swupdate.bbclass                    | 35 +++++++++++++++++++--
>>   recipes-core/images/swu/sw-description.tmpl |  2 +-
>>   2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 0e95e3c..99a4c6f 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -21,7 +21,8 @@ SWU_VERSION ?= "0.2"
>>   SWU_NAME ?= "cip software update"
>>   # space separated list of supported hw. Leave empty to leave out
>>   SWU_HW_COMPAT ?= ""
>> -
>> +SWU_EBG_UPDATE ?= ""
>> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
>>   
>>   SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>>   SWU_DESCRIPTION_FILE ?= "sw-description"
>> @@ -48,7 +49,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>       SWU_HW_COMPAT_NODE \
>>       SWU_COMPRESSION_NODE \
>>       SWU_VERSION \
>> -    SWU_NAME"
>> +    SWU_NAME \
>> +    SWU_FILE_NODES \
>> +    "
>>   
>>   # TARGET_IMAGE_UUID needs to be generated before completing the template
>>   addtask do_transform_template after do_generate_image_uuid
>> @@ -84,6 +87,34 @@ python add_swu_compression(){
>>           d.setVar('SWU_COMPRESSION_NODE', '')
>>   }
>>   
>> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
>> +python add_ebg_update(){
>> +    distro_arch = d.getVar('DISTRO_ARCH')
>> +    distro_to_efi_arch = {
>> +            "amd64": "x64",
>> +            "arm64": "aa64",
>> +            "armhf": "arm",
>> +            "i386": "ia32",
>> +            "riscv64": "riscv64"
>> +    }
>> +    efi_boot_loader_file = "boot{}.efi".format(distro_to_efi_arch[distro_arch])
>> +    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
>> +    swu_ebg_update_node = f""",
>> +    {{
>> +           filename = "{efi_boot_loader_file}";
>> +           path = "EFI/BOOT/{efi_boot_loader_file}";
>> +           device = "{efi_boot_device}";
>> +           filesystem = "vfat";
>> +           sha256 = "{efi_boot_loader_file}-sha256";
>> +           properties: {{
>> +                atomic-install = true;
>> +           }};
>> +    }}
>> +    """
>> +    d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
>> +    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>> +}
>> +
> 
> Unneeded newline here.
> 
>>   
>>   # convert between swupdate compressor name and imagetype extension
>>   def get_swu_compression_type(d):
>> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
>> index 6b53a3c..c52372c 100644
>> --- a/recipes-core/images/swu/sw-description.tmpl
>> +++ b/recipes-core/images/swu/sw-description.tmpl
>> @@ -34,5 +34,5 @@ software =
>>                           subtype = "kernel";
>>               };
>>               sha256 = "linux.efi-sha256";
>> -    });
>> +    }${SWU_FILE_NODES});
>>   }
> 
> Jan
> 

