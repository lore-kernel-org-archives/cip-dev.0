Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB8EC10F05
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 14:10:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.87])
 by mx.groups.io with SMTP id smtpd.web11.9067.1702303817364968799
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 06:10:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UEjA/icU;
 spf=pass (domain: siemens.com, ip: 40.107.21.87, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5ToZFeVlYdmmT0OM84+XcI8xYx7tVLM/4owhfXFjIdPZYKZ4eeAOl5uyOIfhG4xwbFYSq3qPFnPXAqN0Pa/pX2+mCe5/YKO6kfwaggJEQsY0Kc2+YXjKt79+XmjmxgWUV1p1Hm/WrU/BYI7RyR17vevOx3K1nS2cHrY10df+QD+/Qbh1rCDaqEeBM03wRCVOmuq9svBOefBUfNYCx79vGkFtOCHBwmnKlW5/EWvT4kf1My2BpT6ugy78WOxnTyAOLMFEaj6zW2B0Isqscx6MEF2po/hiptpH59XmMt6wzYk+5t8SO9A4PKAsxiHYXaRyKAwxIht/+ZsAVAa3cw3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P+GWrDJBpXZCkifP32g0vTUXBiDa2kjXMalOsNEdac=;
 b=mBmNsqP5vP3Aa6QFu8thDtrDYwQKXJ0xUupsOq0IY3D7lUtAQYvSpje6EPw/wDkkGBzHMFgM8u26IxwvT9V2fjemWIYEVQTvPrblG7phbMsbKdo71Yy6SRLBDthCIRq2by24fsKS9DQ3qvttW7Us9dEzBhpDy/sd1/NeHpcPh3EZwwxwIP75Ox9mgAEkiGvVpP6G8QngdN7bQDTbc9M7enbTGR4xHxNWSgLDwlvAkJoZGyhhI243dqOjjcplPxt65OYPPgjxL1ISioLYE2pGu1utrZ9irU4yDEu6SEaqXW4u53DRYb5pTkbLumJd7RHO9EID/vL+V+QQNocVaTdjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P+GWrDJBpXZCkifP32g0vTUXBiDa2kjXMalOsNEdac=;
 b=UEjA/icUtUlNIGNj2MdgxnALNcJKvu2xLiajH14A4427UFo19NaMTfQW4zfnSAe3Uyvil5J9dwR6OFy2GCqaCU3xqU3HsuxEHaQJRHXdYGXp2NnZgTX2ohvx/bn+AzbZ7eePTDJLkPfPX7G6C817fgQUdmq9fYPVWMlC6EkvbpajOlOsHMaDHZjGRABtFGQ4zm34ZISOtFLTI+cy8x+27ez/qvEasE/6d35EF4iA5wftuKpPoxih99MTtuQhVcHNgj5udI73OS15ddzlhof097mxTfdPK4caUOlGL2G55waeH1U1IOxccQb/XmknuiWdMbL1560glPnS0+ES8iC3Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:10:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:10:13 +0000
Message-ID: <0d705fa9-9c0a-447a-9eb3-5f08ee0e8a0f@siemens.com>
Date: Mon, 11 Dec 2023 15:10:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
 <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
 <b53a426e-b5f9-4ba7-b76c-e4020ca1a1b5@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <b53a426e-b5f9-4ba7-b76c-e4020ca1a1b5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: df4fece6-eeb3-4d22-9618-08dbfa52e4af
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kyhF3RUpzEwCKNw+4tAPV2yxTGUL/vFpXrU+5QDtpQ4iTBFogWO83H6D+ResgRpabawVwD4ERCgaOYF3upohAyI7hxe/5KIeZDI5o2cNfK1/f25speHW944fqxIzfVIHjhGhtgaO+1uP4xaptNmGOBSWiPERwqeaU4iof3kj0SSaMCJVpDdA2YFu9w/0jtzKy0S4gFkj1b2phZ4mRziAFk/4yeXGD1iw4c5BjwSjpv7cvYa97oYJHtEdG4hg9hCvOWtGz8DK3StoiJL5Wp5ZRhHaTzg/ds+64FILh2x/6dBvWnp9mCdJ+gG1WIlCq89jGlSO3Rju4Px60Q5VS/oW0BXRGhJwS+Tk6U5X95yz+jAR/g7uL/Vggo+l+eGbf15nyC3XHOin8fGOUOY8Sn0xA4hJNk9TyBOwqzd1pIk5F5RrDrfkps5WBT0CKEZD3/zeKZ9EpA/UudRuK6GxmO9uOLiD/v8kLs7xIx/I4s0Qr3WMI/QQ2oEFFlayhlSwZUVc+AeRXSSyc9H/1MebrOI+YlS6pFGhGxiJ6W56UCMiFVzvnTf2f8dfO3LbVp39TMue+rJvovOtO5917+YwbPZzHsv5K4WhjrgjtgjfZXRZo9S7yExcJuBFgsC5hFb3qCqT8scLIRAEYQzTqD3RF4yxSv/gbf82W2myTeydKLc3h2E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(36756003)(66946007)(6486002)(66476007)(66556008)(966005)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(31696002)(15650500001)(316002)(38100700002)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elhkU2l1cU5qMTJQbGZKMDI1aWM3QUNWdkFSbzAzU0hTR00wNnhBR0FvQnBZ?=
 =?utf-8?B?c0R3SWZRb0F2aXJDL0g4dHBCNHc5RnBGMlN1VjE5dXQrMkc3QWxRQXBCaGxm?=
 =?utf-8?B?NFIyeVlZeFVDTnNYSlMzRnBUdzI4U29wdFp4Q1hYc0UzQ0pSSk5kWFU4RldU?=
 =?utf-8?B?R3JlUjBPSGQzZjk4R3IrcmtqdWQxNy9Xb0k5T2RReDRGdTQzUDBtdXJablBJ?=
 =?utf-8?B?QWE1MUNxL3E3QTQ0WXFsd2N6NGZ1VVpRTG5yaTdZNXI0VUpYZFVCeU1YckVH?=
 =?utf-8?B?WkZ6dFZKQ3ovVzAwOUl0TUtWZXhSOEhHVEFjVzdWUktQTTRSOC9BTkg2WWFn?=
 =?utf-8?B?RjY3d3UyYlc1cXhzeXNQWUFBTGp3WlhvQ0ZseXdtZE94TGRYSXZQSlJlRENp?=
 =?utf-8?B?cXhtRnYwL3BlbkZhZy83WEtIL3plNzd3V1pLU3UremRETGw3RW5NblpUUHBY?=
 =?utf-8?B?c0E0ZnJ2bGFtNmovYjBhUVcvQzJoV0pLSGk2d2RxYS9KUG1obE5tcGJVYVB3?=
 =?utf-8?B?Vk5XK0pvRGNUdThMcjdmVDZQZExjUTIxM092ZWFybTNUME5ZdjVCUklhZWFT?=
 =?utf-8?B?TXhDanU5VDA5SWxHSWZmTHdVcTVHa1lhQk5xeWFxeDhvZDJETmhyZTJKbkFz?=
 =?utf-8?B?Z1dkd3AraURnYnk3RGlTWStSbFVOVitYaUR4Q1U3M0xRVEQ5d3N2UDQzL0Vz?=
 =?utf-8?B?SGo0ZHAyZUtiYUNrWkoyZGo0bnB2eG0zcTVTbTcyelVtT1F5dGJqdVBLWjY3?=
 =?utf-8?B?WUFVN3J5R0NGM3lRUUUyRTJqVFMwWG9teVpyZ3RTVHYyWVhmZnp4akZFSC9q?=
 =?utf-8?B?K0RIM2Q2MHY2ZEdsb0RtMTNYQzFFTmZXSTAyM1FBeG5CcXBSMEZReldabll0?=
 =?utf-8?B?SFVTRERBUm04MkxIcXArQ0ZRRE8va2V2N2NQcDQxOHVtMHFhTWJ4VjYyUytH?=
 =?utf-8?B?T0MvZ0I3bmpDWjNiditkK1VzZEJHc2pJb0Era1A2ZHE1MkhKaTdxVEQ4dzZn?=
 =?utf-8?B?aEFYRDk0S0ZlNk9BWXExVWlYclQza29OMUVUNncrdXRmWjdqQTc1bGhncGtz?=
 =?utf-8?B?dWlmVEFLRXltUFJtMzM2RkF0OWhXUG0vQ3BmTkdRVVZjTjlUa2JRSnY0VHJK?=
 =?utf-8?B?cVBoQnAwc1BOR0xVYXhERjRjbHJsTXBKVzNKRlVVbmR1YkhkaDBBdWFuT2RG?=
 =?utf-8?B?VEV2WnZOeWxLL2k4TnZMdjY3SUJwS1VjRk5LN2h4dmVCRTFQbzF1Nk93ZFpV?=
 =?utf-8?B?bjJvYmZTeFBycFNRVjU2YU43dVYrOEx3SnVsc2J0VEw1aXFrZE91UEc4RWpL?=
 =?utf-8?B?bGEvak5KWldNV2ZCWmIrWWd0b2VPUTdnQkdEVi90SXEreENIVjdBQm5aemdM?=
 =?utf-8?B?dFhiV3Vsek1FR1hWRU92K1NOL0s3aklIOTRla1hyUlBMdTREcVFYa2VXWHNN?=
 =?utf-8?B?eXR5TGVZK2dPZXdZb3dxY3NZZDFQYTBSZnNkN1d6Z1cyK2lsdXNmdnd2K1Vo?=
 =?utf-8?B?blZ2UFp6b0daUU5XdXluT2w4cURmb2VjdlZiYzhKT29uV1N5dVAzU2dyaEZw?=
 =?utf-8?B?RnZEcGNKK212cExrdkhTNHNZbUpRN2I4NDlTVklOeHVGUE43Nm5KSkFxb2Vm?=
 =?utf-8?B?V0JHSjBUTVhyM2JPSlkwVytUTVFJcTRNZEJzVU5kRldQY2J5U1VOQWQydzR6?=
 =?utf-8?B?V29Ya0llRDdKb1Byc2VCOUlWVVQzdGtaVmVBM1BBS1RBSFpFelBrYm04ZVU2?=
 =?utf-8?B?WGFpVXl6aUhqR3ZsU2VSVG5KMncwQzJDdjJiYTlzTHhUakUvM3ZtbEtKWE81?=
 =?utf-8?B?MHBFZ202RWhjdmxBZlA0VGY1SS9DMHh5bnZENVRxc3RoZUZYeXJkcEVwUFUy?=
 =?utf-8?B?U0RBRjYzSGtUNXNpODB2QTEyQysvaFhPMFZJbWtQT20zR04xcnJjb2VHejdY?=
 =?utf-8?B?QUpjQUZSR1IzYzhLcFZTL3YzU09STXZIYkZlMHNMTGFNaVJWOUV5UnRsdkQz?=
 =?utf-8?B?MmpkYVlxN0kzOGVEVmtyMkxSOXpBVU00Q1ZibXUzNUFpSDIvdGhibGZEZWVM?=
 =?utf-8?B?M1U3MmNVbEdHOVZxQjRWQWVuVlVGcGUrcE41K3FIckVtNUNVd1lkTStHYW9y?=
 =?utf-8?B?eXRib2wydE5CL1VPY0h0Z3o5M2wvMEpXdEx2My9XNFBDQ1ZUYVpzbzF6Tnp0?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4fece6-eeb3-4d22-9618-08dbfa52e4af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:10:13.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yaa4cLMccb914nIfmWVhI3UZgDusp4JDQyTcbpGvndzIinosSrppGSTDEk52vq1DNusJItXJcNH1zpLQKq7gmgJww7QJnRNTIIuX7z0nUbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7312
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 14:10:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14028



On 12/11/23 14:46, Jan Kiszka wrote:
> On 11.12.23 14:45, Jan Kiszka wrote:
>> On 11.12.23 13:19, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>>> element is added to the sw-description to replace the ebg.
>>>
>>> Use python as newlines are part of the sw-description syntax an
>>> therefore cannot be hold in a bitbake variable, see note in[1].
>>>
>>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>>> support atomic writes or renames so a powercut can still corrupt the
>>> system[1].
>>
>> "system[2]".
>>
>> But you are not implementing option B described there, just the even
>> more risky option C. Doing flushes before the renaming and after it
>> should reduce - though not eliminate - the corruption window.
>>
>>>
>>> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
>>> [2]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   classes/swupdate.bbclass                    | 35 +++++++++++++++++++--
>>>   recipes-core/images/swu/sw-description.tmpl |  2 +-
>>>   2 files changed, 34 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>> index 0e95e3c..99a4c6f 100644
>>> --- a/classes/swupdate.bbclass
>>> +++ b/classes/swupdate.bbclass
>>> @@ -21,7 +21,8 @@ SWU_VERSION ?= "0.2"
>>>   SWU_NAME ?= "cip software update"
>>>   # space separated list of supported hw. Leave empty to leave out
>>>   SWU_HW_COMPAT ?= ""
>>> -
>>> +SWU_EBG_UPDATE ?= ""
>>> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
> 
> Oh, and where does this UUID come from? Is it a wic default?

It was added with 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/b1bc585877549dabca78873f6bada730cd56cf71

Quirin
> 
> Jan
> 
>>>   
>>>   SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>>>   SWU_DESCRIPTION_FILE ?= "sw-description"
>>> @@ -48,7 +49,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>>       SWU_HW_COMPAT_NODE \
>>>       SWU_COMPRESSION_NODE \
>>>       SWU_VERSION \
>>> -    SWU_NAME"
>>> +    SWU_NAME \
>>> +    SWU_FILE_NODES \
>>> +    "
>>>   
>>>   # TARGET_IMAGE_UUID needs to be generated before completing the template
>>>   addtask do_transform_template after do_generate_image_uuid
>>> @@ -84,6 +87,34 @@ python add_swu_compression(){
>>>           d.setVar('SWU_COMPRESSION_NODE', '')
>>>   }
>>>   
>>> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
>>> +python add_ebg_update(){
>>> +    distro_arch = d.getVar('DISTRO_ARCH')
>>> +    distro_to_efi_arch = {
>>> +            "amd64": "x64",
>>> +            "arm64": "aa64",
>>> +            "armhf": "arm",
>>> +            "i386": "ia32",
>>> +            "riscv64": "riscv64"
>>> +    }
>>> +    efi_boot_loader_file = "boot{}.efi".format(distro_to_efi_arch[distro_arch])
>>> +    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
>>> +    swu_ebg_update_node = f""",
>>> +    {{
>>> +           filename = "{efi_boot_loader_file}";
>>> +           path = "EFI/BOOT/{efi_boot_loader_file}";
>>> +           device = "{efi_boot_device}";
>>> +           filesystem = "vfat";
>>> +           sha256 = "{efi_boot_loader_file}-sha256";
>>> +           properties: {{
>>> +                atomic-install = true;
>>> +           }};
>>> +    }}
>>> +    """
>>> +    d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
>>> +    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>>> +}
>>> +
>>
>> Unneeded newline here.
>>
>>>   
>>>   # convert between swupdate compressor name and imagetype extension
>>>   def get_swu_compression_type(d):
>>> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
>>> index 6b53a3c..c52372c 100644
>>> --- a/recipes-core/images/swu/sw-description.tmpl
>>> +++ b/recipes-core/images/swu/sw-description.tmpl
>>> @@ -34,5 +34,5 @@ software =
>>>                           subtype = "kernel";
>>>               };
>>>               sha256 = "linux.efi-sha256";
>>> -    });
>>> +    }${SWU_FILE_NODES});
>>>   }
>>
>> Jan
>>
> 

