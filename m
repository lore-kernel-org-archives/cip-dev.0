Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD366C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 16:29:22 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.89])
 by mx.groups.io with SMTP id smtpd.web11.15617.1704990557966604969
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 08:29:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hEApBcbP;
 spf=pass (domain: siemens.com, ip: 40.107.14.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAFG7bJlbszmbwzXpSOzlHg5/9hRYhESPvtYNQiKBKjWGygQ9Bgyim697L7w7BhSa7+cD3iT58ERBMzua4opioXrJUgoVKSp/uExcrv0XZP6NjRvqg77Hm232IxReQgPufxvi8bppbKdOaINh5Jz2RHcyfz1YvwT+KjSPcj5ZSYxhhNgFvZfH7qpp/eIlRshDQhd/6xXjw6FblULb5HRE3NGryYH3Si63SktZO10Bf8BVrvk7ysHjzc2Rq1VGMZSaNfQSyqiwzLLHu9L9eUKX+7tJMd7krmSaBwMYypoWMdNzjD9YxxMsfbtJMRr/d4zRC2+VOt7IYyMxV7SFmKWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlsQFFs9ZMxy7bS0RHvMQQXU+eM84mRtCPncKpi6m0s=;
 b=TKcSjeJfFAGGGM5mFTJdtcvsAWCcpaDAexy9XVKAVifTxD3WQtwrhfQpq99/weBmB9LbJ/uGuyuT9pqAFFqMtGtbZUebAEZ5EgU/xm0AiY4DGiTglcgQNMqci9gLzRNuyPue6QNVUCLztxIh6LwR19E1ERyJzshv+4NvP6l+R/r7m+qVvBmXHHq74kX1c8aRMzDyI1ucfTfeBhFYtbiJrnrlq/qro49iiv2A/BoWiGw/rfXfrFn9d2GwdIc4Gk8Pq6iPLFQt0KIJOTYotIqkDP1iUZ/M5cT2q+OpMhjoTf2dLeVVSQqGE944wZO2tqLKVe6wnAyxfNQuP9Jqk8NzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlsQFFs9ZMxy7bS0RHvMQQXU+eM84mRtCPncKpi6m0s=;
 b=hEApBcbPTtEFt4coSFRlLr6hIL9Hg3ZrnvXAXfCa1sSYKXGZuDztrlMycAFVLisyiljAqVYg59hdVH1/yPHDUR3EVWUcF2YMc3iUNkDeNYpLEPh5L0P841GwTze7ysBWGW8arICokuxCvavSAyBn3jl+Ym91Lp2nnF97hbP+sEwOfsz9Jen0Ap2ANPMg7cx8KNdBhtI0QDFHMW2R/gCNZOIFifhK/HaNHcbvm7/g2GEUJ2oymWsP1f2goyDBvaf4cc0NdO4uvdMPTqGnG90K370QQYCTPCBBsesQmjKw8+8UKW37yUwPf/vietgB6ELdp0BJHsIPQLHVBaxZB9SDog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:29:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 16:29:12 +0000
Message-ID: <32db6678-7a05-4b0d-a251-61799bf2bc40@siemens.com>
Date: Thu, 11 Jan 2024 17:28:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Content-Language: en-US
To: "Cetin, Gokhan (ADV D EU TR C&E)" <gokhan.cetin@siemens.com>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <PRAPR10MB542260589618B60AAA1B6B1E80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <2d27dee9-fd70-44a6-a8ad-bd31c0f2f735@siemens.com>
 <PRAPR10MB54221B45AFE5B9B87A21314B80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PRAPR10MB54221B45AFE5B9B87A21314B80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e84c67-766e-41fe-1319-08dc12c271d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xfWqq7WKkZKXU7TKg1/fq/3Y/H6kmvapwxsnxar/+YFUgjPw7ZbR63nwYsQ3i5kqb2yP1Z6Qprs2dcnsAp9G/spaREy3Bkd9IoYQU0Y/DQqxseLsUG/Thc1g/UbixE2VLf18Ta5dBVSaMQ3R1Kdj/JQJdg7r/6ew1gU9DXHTba6HklGx7V7C/AfA5KBIErPCvp62HlN3G/e9SsEfnhfP0jcWpsVhm5332P9p5WKGVcQiYgpRua/Q2MrAd94i2623l7569OYSjOJvBQ0Kc/a52O2jNjRGAsL90PRG2ypkssJKf/zqABNV5SFFGFSDILwewItOF38m9gxKcshmpAmetFurcGROspOG8tf955esm877jBRoIGZ/lBsHihTu27mbIzdczMX3YVrJKNpSeRGcDSBqMQO20NQbOj7eMn9ZaHf2qoAFTOWLU/ckR6NHGqYgW5FGv2qWbxR3kQpn5//8XVyojVreVKwVtNSzaSxXd+6Ip0h1ZTNthGuV6KdtKL1iRQi4BtkMlbiEqPEi1pJmzBejlqhsiAR/rfAg+3tL3fj3NHqVddao4GJIrlQfHGPXnmT+O5/rqJOFi9NU/9mZGcxV23YBsVloPzI1KccNJKIyGQmgKr2bXSaZBZtxZF1q2BsSWq/YNLQvjreQRGHaxw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(82960400001)(86362001)(31696002)(41300700001)(36756003)(38100700002)(44832011)(478600001)(8676002)(66476007)(66556008)(316002)(110136005)(8936002)(66946007)(26005)(6666004)(2906002)(2616005)(6506007)(53546011)(6512007)(5660300002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVp1dFhnY0ZrVXlRYWc4aFRZWjJWV1d5aW5nZHZzOGFlTFA3eDZGUDl1ZGV6?=
 =?utf-8?B?Q05mNTZqRzNJQWxvMDdhVm5ZWjI3VmsySjdlUVp5OG40Z3lQdUY1bko3ZmR3?=
 =?utf-8?B?c0ZQaXlOWlpPYmRNZGNRSzJLQlp3Q01EU3U4bEFvWmk0YW9YNkxkYVhBbFhm?=
 =?utf-8?B?QlRNMXErNXAzQlZYNmpMN3RReXgzclNuNm9PZXUxZjAwMWhWTjhlODdtOFZi?=
 =?utf-8?B?cXNUdXdEOEU2MUozdlg2cWp4Wld3ZFI2a3dhcXVFMTZENENDSjVhSnV5NU9a?=
 =?utf-8?B?VFJoTm5lZmFkUWE4WHR1aG9CODNkaDhIdzlnQXJ0WFpCQ1hQQnhVSEFBZlBR?=
 =?utf-8?B?UnR1cCtxbHZaaUpESStFREJ3TkozRkc3aEh4MitVSGRpbzJIbnN4Qkc1TjM0?=
 =?utf-8?B?WVNMSHl6a3BHWTBkbjBJVGtiTjhoRmhmWU9xakY3a2x4ZG1SdXlSb2Z2Z3dP?=
 =?utf-8?B?bzhVOENTWlphekg3cSs3RUwzYnVmR0xXcnhucTN5WXBGcEpJbk5XdTNnakNY?=
 =?utf-8?B?cDdISnJpQ0RWSEdpYVFpRDZaWEpYNmwza3I4YWRJRGxtckY3c0RuLzFoemhK?=
 =?utf-8?B?bW5ER1hxak5PVmY3L3lDOForMnVQQ0pyc3FSdU9JaHZTaTg4blQ3UlNNUFF4?=
 =?utf-8?B?SUpvcDk5dUErSzVpVWRPMGxQUUZJUXVpdTJ0MktXOVFnN04xZjlEOSs2VnFZ?=
 =?utf-8?B?RkFMdkd2M1hYSXRMRi9Bd1E5dVVMOFcrTlRwWkNFRHZnYksyajMzOEJlVWRF?=
 =?utf-8?B?RW4wZTJvSXhvU0o1dHI2MUI3QU9ZVWxjZ2JKM3YrU0hhZXlIRUh1NkZ1NCtZ?=
 =?utf-8?B?bWVySk5xUnlUZ3pteEllTlA1QjltRUtDcW02cmtpTjJxYzdjcVV3Nll1TFdj?=
 =?utf-8?B?eGlaS1BnVXpSWXB5a0UwR2QzNGhKWlRDR3ZrTGZIalJtZ3o5N1B5bUdCYXds?=
 =?utf-8?B?c0kvSGdFSTZaRnNiQWh3WG9PVExRQ1BTR2hFR2VYeWNpUE44UHNyd3o5V2FJ?=
 =?utf-8?B?SjB5emk5MzFpMFQ4L3d3UEhCV254d0UydEhxSUtCdFZIeTVwdWsrY0lZcHpY?=
 =?utf-8?B?OEloTzhEV3ZVQWdzbFR1am1FWGxUZXptRE9wMVg1M2hWMFBVUUdmV3J6Ritm?=
 =?utf-8?B?c3BZc3RwQ04vSVg3cUVIWDR0SWRPM3ZvZjZOcVkxYlBrNUg0UlVzSzdVVXBu?=
 =?utf-8?B?R3BzeFQxNkxSMzBoK21OQ3pOREZyZ3Z2VGp3ZTMyTVBXaDdkekpDRWVOU2lh?=
 =?utf-8?B?bS9DUUI5eUxTRXU0eFBucEx1K0JWbys5UlZMMi9WNEV3VVJhRzhleUZGeTJq?=
 =?utf-8?B?NHFUNkRBS2YyQ0ZSd3NHMlphY0RBV1IyVkRodlB1MzlnS1IzcTBCT2NOeWZR?=
 =?utf-8?B?MUNpNVVYUkVCUGw4UWFtQk51QTMzVDVxOGFIMUZlc0I3d2RLWjBvMVhuRXZ1?=
 =?utf-8?B?VUZyOW5qL2FJL1lkb00yUnhDbnpyUU1Udm8rY0FTMSt0cjNlaFg3eHBJNTVS?=
 =?utf-8?B?Ujk2Z2xLRDJBT3NJdmFWb25NbHo3SlVsemIwMXdsSng5UEMrSkRUYjJZZ3Zp?=
 =?utf-8?B?V292MDB6ZkI0Q3l1T1RON3F3TFFuemRTTFVBVVRuQlV4ZW1Wa0I2aURlMVlh?=
 =?utf-8?B?VnY2Z0QzOFhSalZQSGpHTEcvVXhEdUNjRHlhMWd5TW1BUkx4Q0FWMGh0dnph?=
 =?utf-8?B?Y0JsZ3Fsb3MwTG4zMzJMdXpxUFZvSW5LWHVFZVA5UWFHWVVuNVFkbzJmZnBS?=
 =?utf-8?B?eVNHWVE2VmlScDEvQmxkSERacVhhaVkwS1Z4WFpSOVp2d3F6L2dDWURhL3Jp?=
 =?utf-8?B?Z2xRbkowV0tjaUZncFB5OStJbFc5b2dHMmJZSTZTQXJyY280MFd3WCtpMFJX?=
 =?utf-8?B?Ym5vOG5jZFNRbDl0OTNCYlVpOU1LODEwU3E2UENzWkN6L3BUdUdQelJJbDBJ?=
 =?utf-8?B?MjE1Nk00TlBzcmk1Wm1qTHBLK3hFekJGR3hSeEpqcTdodDh3ZmVqNUl3a0Ux?=
 =?utf-8?B?dFZnSUUyeU9qTWFCMWVBK1BTMTRXNkdOdEdoaDJyNmpaU3pXOHhubERuaUZI?=
 =?utf-8?B?aGttMVRsbnZkZTJmS3VJK0FKUGJ4YjdraDByaXFJM2x4WHhXR1lNc09UMklK?=
 =?utf-8?B?WWZpaEtEb28xYkFoYmxLM1N2MXMvbzd3TUZxUDRMY1NLNjVkZ2JINExVMTNw?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e84c67-766e-41fe-1319-08dc12c271d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:29:12.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jc3/mN+UOvIkA+emc9mYa40a6OEtFCVz/gXpFeix+lmgznzb7QnvZOMb9hxYFt+upw+LD1GbmBVGVKjts9SLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 16:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14332

On 10.01.24 20:58, Cetin, Gokhan (ADV D EU TR C&E) wrote:
>> On 1/10/24 16:13, Cetin, Gokhan (ADV D EU TR C&E) wrote:
>>>
>>> This adds necessary crypt modules and loop device in case they are not
>>> loaded at early boot as default.
>>>
>>> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
>>> ---
>>>   .../files/encrypt_partition.clevis.hook                    | 5 +++--
>>>   .../files/encrypt_partition.clevis.script                  | 7 +++++++
>>>   .../files/encrypt_partition.systemd.hook                   | 7 +++++--
>>>   .../files/encrypt_partition.systemd.script                 | 7 +++++++
>>>   4 files changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>>> s.hook
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>>> s.hook
>>> index 37b373c..bcfe885 100755
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>>> s.hook
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.c
>>> +++ levis.hook
>>> @@ -34,8 +34,9 @@ manual_add_modules tpm_crb
>>>   manual_add_modules dm_mod
>>>   manual_add_modules dm_crypt
>>>
>>> -# add crypto modules for debian upstream kernel -manual_add_modules
>>> aesni-intel
>>
>> On which Hardware did you test? If i remember correctly asni-intel was
>> necessary for the ipc227e.
>>
>> Reqards
>> Quirin
> 
> Hi Quirin,
> 
> The initial findings were like this, but we realized that instead of aesni-intel, these 3 crypto modules were sufficient and more generic.
> We tested it on several different (non-Siemens-IPC yet) x86 based devices. Also qemu and virsh also confirm this behavior.
> 

Mind to enhance the commit message with a sentence that explains why
dropping that module is fine?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


