Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D758AC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 13:22:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web10.28580.1704201748238907042
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 05:22:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qs6i1MIv;
 spf=pass (domain: siemens.com, ip: 40.107.20.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeR44svYguJW26vqVadRGP3JbAY2uHuZELNkkFcPJczO13Eqt+h0q8nbNwaT+iavx6wuVZ+fwnqEjFsM8UzGzrIs+3bdktm+YrZjtCYS7veTpQf7f0vbnAbsRqoTvIAfmWbdaUHsZovHy+98HmUoFX+NZKurs8AMX1N2MkqGyoEW1FrpZHPhrHve/qBObGmsr4OaFi/aZSGyd9UKZyMNh+VcmlMgW4CawQCLInhRrCpwO+3IRTb8lwpQRBnqavDWUBLrLGvRN/9wKzM85vplqlKW4tcBrLdKVY9lhoZjH1AjxO8Bc3OcEEE678Zz65CCEUjqeLJysywWlXzfaenwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqXHGobx8TD4DnVG7Vv8cRPnNyfMCfpDBdQtZKu3cgQ=;
 b=PB0+PK/tFRxrQrd4zKfl+EG/opfrthFxIWIUXgmRYVO3SKjZp0TA1BhdWyV9eCQdDhstaJOUBcsgwdT8kxkHk7v8IeLAqh1QYOUoBNY0Nzk8EAGdfYKkNcEQJ9k7voIa9XG6Sed2zOMNo7tCvJv27TONljTNOnmbDJ7gG1vAHF3vuDhH6Oq1ywXzisx4N+XmAPx7OMJbU1XTjp4dzqMFYsU/TRcipJflz9eWZQFZZL2NLOOcow1S8uWRoGVsopqiK7pyBoVA9jtRdC1p1nkoF8VTw8X0Cnd3XNfNyvkylDnzluosBfVnYnRTcz1CC+9CeRJgJUyd+SY0gD91ujvHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqXHGobx8TD4DnVG7Vv8cRPnNyfMCfpDBdQtZKu3cgQ=;
 b=Qs6i1MIvutiQRJ4IYI3DdMZrjY0qff1jDtiYet1F+PD0E8UsHKPdTiqRhZgj2jXrnpsMzhJl0b7ZwjHDW/lq/4ZUEw2v9skeSMSba4dHuuaem+x0LvqIl9TEYxjb45n16f/fVyVi8sstbp+++nFWaGtXYQeKrfLghkWPj5dh3H9o3Ww23qbCoVqwsFyr+cjbaZnQG3aPzaBXttIkIGHH/IPENbQfOUkeRHBZ74DWhRmPRSsPB57Ry/P7jWHFQOpTNz1cHTQbarUrX+4LTQo1rbhzJINJ7cvVoAETZOPF/RhONtHR2MKBARtz6Ayb3OsRCvyxtX//mcWcoQGOEXJ2tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB6526.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:22:25 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:22:25 +0000
Message-ID: <b0924edb-d29d-4e4e-a7bc-e24985d93bc6@siemens.com>
Date: Tue, 2 Jan 2024 14:22:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v3 3/5] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
 <20231229123111.400555-4-Quirin.Gylstorff@siemens.com>
 <9a87e572-5353-47ba-a031-22c91d08d67d@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <9a87e572-5353-47ba-a031-22c91d08d67d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0008.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2193d6-623d-44e2-7a19-08dc0b95dbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0i60rIvS3mXtWUekVMKNSCKoXghsuoBwhU+Dfv4U0ex/icy76L+mNwdvz0a+Bk4q8eJc6JsIKyKJhZXSYzcRFrlUxIdpDccMfCcylRvzz8pR2Nhu7tZXwmuDTv7Y0PGMFMJHmaQLWCfjktbZFA+qSDZ7vOiMi3Je0O+8E+sHC2hnhP3jn8jQaMLffCBpnbKAomfusHn08byaisu1My8HLQa4C3o3AYhNUV31ASDz6UlIpNZoxLebKj04GHT3XFyLIiP2ZOAS9kuNMddF/upTsLnq94BL5NGeJbTQqTKztHjTh7G008OSPPqBagBSKnd9plnigaaNIAdZxwp7iyra1MNIMFd+7CeTlQMu27UdmPOZqezcuSt6EXit8LaB7C1Mxan3kKh5Cv8TEXHHWsm4FBqF+URTRDbcD7ZjlZmMBaQ5cbkgorMJxEEEY6oiZTBwY+sMu7snvyi7oIbIzk02odGcEKuf5nP6pgmkYMFhM3D2QOrisuBGlLkIMJKKuSHsj98NsYErD/9kfeCrYJqrvVWVZhDHtHZ9XHE4/WRTN+PiuMFMM3SgJ5UyMW/1YR5Gzldmu0F7bY6QVvHONiidya3BNDdhAmoyHfPsO9WhoFFFnPEkla/+3bZr3b78qdvUpW3b+BaPWxlP37LPBQM1XWWWao6tk0FeIsWqjLi6wso=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2616005)(26005)(82960400001)(83380400001)(38100700002)(66946007)(66556008)(36756003)(66476007)(316002)(478600001)(6486002)(966005)(31696002)(86362001)(5660300002)(15650500001)(2906002)(31686004)(8936002)(8676002)(6512007)(6666004)(6506007)(53546011)(41300700001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlRDV2N0VVFyQVlnZHIwb2NpZm13bjh1eEtUamZ5cmhFTUZqRXVhMGw1MWFw?=
 =?utf-8?B?YmFsRTFGLzhqOGZoaTg5SVNmUVd5L3NuTzg4NkcxVUEvMVZJY1VGMCtWQkJi?=
 =?utf-8?B?MkJIQlJseGRHd1A4YXoxSmJrekFxZHRETFNQdjVncDNrMjVOdU9aeUtJRTl6?=
 =?utf-8?B?UkxXZ2ZjUHlQYndrSzlXdWQvKzBDRmxud0VEOC82dDBHY0pEN3lrcWVSUExP?=
 =?utf-8?B?Y0tpRTFsYVZIcHJRWllrVzFCY1RJSjVtYzNhbzZmeGh5ajN4TmRQK3Y3czBI?=
 =?utf-8?B?T29kN0hSVWZwdG11aC9CdThXeStLL25aK1RiNHR6SXBMUmhBb3BpTStFQUNu?=
 =?utf-8?B?YzhxWFEvZUZCUTEzaEkzb2Y0dEdoSE9MVnFKTWRvQjV6bi9YdDNBQkV0UHRh?=
 =?utf-8?B?eUQyZXVjdC9IbnhqYit0ZUlybGwrNEpjYzBpTHJOY21ld0pvWlFlRG9IbEtN?=
 =?utf-8?B?MjJNTlhlS0xRRVQ0SXVpK0pKNlFiUksyUStER21iSkdHNjV5d0wyUUJhWnNM?=
 =?utf-8?B?dk9FSThqY1ZGWkdUNWxWMDFnZHNWL01QL3ZhZno2Tnh2ZjhLc1NhYmdUMlhV?=
 =?utf-8?B?bmV6dXZpeEFmZFlRNDQwNnZXNDA1RnMzYmI1MHdUanFGZEU1d0RBMlRmMHQ1?=
 =?utf-8?B?ZVRFOFlDa1lIU085dVVZbHZ5bEFyN2NRNzZKdTcrOHJjbXY0aFpUV1RYR3pw?=
 =?utf-8?B?UFVIN256QzBYWWp3NVljYzlzYm9ZT0lBWUZlSmJPVklHTldQYncwbkg5bE9T?=
 =?utf-8?B?MHhURmU5TkNQd0J3YkdVdEdQWDRkbENTOCtTS05OcGU3TElBM0NkNzFjMzJm?=
 =?utf-8?B?cFI4QU1YdEpBRkpXT25qenZRcFYvWGY3MEx3L29RQlN4cU0ycVdua2RXTUgy?=
 =?utf-8?B?bllyMi9RRFBUVkFrbmw3YXBtQ1Vta28vQnZlNVY0RU1pb2FIMU9JQWdmaEJL?=
 =?utf-8?B?ZFg0Q3dCVjNDMmxoSTBYYmtnbGR3K0lPdjhJeklRZVdqYnl5R3F4US95bXFL?=
 =?utf-8?B?SlFUNFNPbTBQWUJaQzBDcVFZQ0FkTndNb1BpQXdJUHdvZnRicEVEVjR2cU9x?=
 =?utf-8?B?WWpsa1k0aWMrVktQSXBmSmRheWkvREhPRFFva2RhOWwxNjJMSTFlKzkyL1pG?=
 =?utf-8?B?MDIrdVRmYmxTQTFXejNSVG1lbXZPVDF0Zm84M0lWY3VReVFrcngyYUR4dDdm?=
 =?utf-8?B?NTROU21yVDV0MHpyMU81MFdHSVc0aWJXVFN2VklWSHMvZm0vREhOUDlpdEVH?=
 =?utf-8?B?RjE4VjR0TFZvN1B3cUJNMjdBZHJZdkg3QUtHazlVZmVoSmRyeFJ0eVlhSVRJ?=
 =?utf-8?B?M1FKUExGci9pZ3daNkpQNDhPVms1eUpZbzNqUkFxeTk0OG9xU2tOSHdDSEhi?=
 =?utf-8?B?QW5Mc0swVEsrUktxKzJ4Z0c1Y0tYcDJRVnoxb1c1amozRzJKcExaa3lmZG03?=
 =?utf-8?B?b3ZWVUtTRVJxOEVXWllqU0xQWTZuRGd5dFI5TDZwbzdFc2J3WVlxS29scjdx?=
 =?utf-8?B?b2pxbkVQSWhQK25Cc1hENCtHemVrM3NiM3hVR1I4VHNCS3RMVm92MHpCYWdR?=
 =?utf-8?B?dEpicUlleHBBYUpKZUVQZ1Jac1ZSTTRPRXU4bEpkTTNWcitDclZFaHUweGsv?=
 =?utf-8?B?aVBRVDFKTnh4K3Q2dEZKdVgwamVTelJUNm9QQXNWdDFIaTY1eWtZdTNVa3Jr?=
 =?utf-8?B?UVNVWlNNTnNocWUvMitsVXVEVCtEZm1RTklUZzZiRFo0d2lWbGZUTXZCSUM3?=
 =?utf-8?B?SWZDZW1maWtSdHhhdWh4OW5EQXE3NENiWS9FbU15VEdJc3Vpa1hqNVZrdFEw?=
 =?utf-8?B?Y1dlM2syWmJEZ1dEaVdnNElTaTFzZjRoU1RhN0tUK0QwRHFyU3RSUlZ6Nmdi?=
 =?utf-8?B?bHlLdE9ZU3h6R2NMdUZtVlFsTEtmajhBd0pQZHRINGpZazRLWTJDY3BjdUFr?=
 =?utf-8?B?cHRlb3FXMitkZnJkcHVwOTRYR3FLYTVNZ0ZHa2UrdlQvdjQvNWk2cmdnY3l6?=
 =?utf-8?B?UE9EVkhYVnBXend4OExHQ0hlNGg3YTV4MXczc25XR0thQWt1blIrMlF6NEE1?=
 =?utf-8?B?TWtNcTZDa1RhQ25Eem8xSlFSQVE4RmxuQkJsM1l3RnEvQm5qSjFRVitBaW84?=
 =?utf-8?B?dUtDcjc1czFyWjRFRC9wb2R3QjdxZWRQOS9taVI0LzBCREQxTWlsV1RQQkxT?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2193d6-623d-44e2-7a19-08dc0b95dbd1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:22:24.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8MjzXKJPJGjVe09aAwv03QmkKRWZWw9vewrt//Xy9beVS0Op06bR4Pkr++zNMT1LKxxaoMubH7w0JzH8+JHHyiC+XWrye9KSoIXZhB19UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6526
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 13:22:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14228



On 1/2/24 13:38, Jan Kiszka wrote:
> On 29.12.23 13:30, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>> element is added to the sw-description to replace the ebg.
>>
>> Use python as newlines are part of the sw-description syntax an
>> therefore cannot be hold in a bitbake variable, see note in[1].
>>
>> The efibootguard binary has the property 'atomic-install' which
>> copies the file to a tempory location before replacing the original with
>> new file[2].
>>
>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>> support atomic writes or renames so a powercut can still corrupt the
>> system[3].
>>
>> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
>> [2]: https://sbabic.github.io/swupdate/sw-description.html#files
>> [3]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/swupdate.bbclass                    | 39 ++++++++++++++++++++-
>>   recipes-core/images/swu/sw-description.tmpl |  2 +-
>>   2 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index dfe8ef1..f9dab33 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -22,6 +22,9 @@ SWU_NAME ?= "cip software update"
>>   # space separated list of supported hw. Leave empty to leave out
>>   SWU_HW_COMPAT ?= ""
>>   
>> +SWU_EBG_UPDATE ?= ""
>> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
>> +
>>   SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>>   SWU_DESCRIPTION_FILE ?= "sw-description"
>>   SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>> @@ -47,7 +50,21 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>       SWU_HW_COMPAT_NODE \
>>       SWU_COMPRESSION_NODE \
>>       SWU_VERSION \
>> -    SWU_NAME"
>> +    SWU_NAME \
>> +    SWU_FILE_NODES \
>> +    "
>> +
>> +# Add the bootloader file
>> +def efi_bootloader_name(d):
>> +    distro_arch = d.getVar('DISTRO_ARCH')
>> +    distro_to_efi_arch = {
>> +            "amd64": "x64",
>> +            "arm64": "aa64",
>> +            "armhf": "arm",
>> +            "i386": "ia32",
>> +            "riscv64": "riscv64"
>> +    }
> 
> That's now the third time we have this mapping in our code. Maybe worth
> the think about having it only once?

We have it in the wic plugins and now in swupdate I can move it to a 
seperate class in to a variable BOOTLOADER_BINARY and use that variable 
in the wic files.

This would also allow other binary not from efibootguard to be used.



> 
>> +    return "boot{}.efi".format(distro_to_efi_arch[distro_arch])
>>   
>>   # TARGET_IMAGE_UUID needs to be generated before completing the template
>>   addtask do_transform_template after do_generate_image_uuid
>> @@ -83,6 +100,26 @@ python add_swu_compression(){
>>           d.setVar('SWU_COMPRESSION_NODE', '')
>>   }
>>   
>> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
>> +python add_ebg_update(){
>> +   efi_boot_loader_file = efi_bootloader_name(d)
>> +   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
>> +   swu_ebg_update_node = f""",
>> +   {{
>> +          filename = "{efi_boot_loader_file}";
>> +          path = "EFI/BOOT/{efi_boot_loader_file}";
>> +          device = "{efi_boot_device}";
>> +          filesystem = "vfat";
>> +          sha256 = "{efi_boot_loader_file}-sha256";
>> +          properties: {{
>> +               atomic-install = "true";
>> +          }};
>> +   }}
>> +   """
>> +   d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
>> +   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>> +}
> 
> I still wonder if the EBG update shouldn't simply be a separate SWU,
> thus there would be also no need to perform any append operations on
> existing ones.
> 
I think both variants should be possible one only to update the 
bootloader and another for a whole system update.


>> +
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
Quirin

