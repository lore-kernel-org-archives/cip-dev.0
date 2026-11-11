Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6345.1794392285754086241
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 02:18:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=voeu5RN9;
 spf=pass (domain: siemens.com, ip: 40.107.159.27, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Paee/ipd5V1IxA3jG76sBCau0he4VjzssKBMrBsTXHMZ5s21MfJyjazyi2aDGZhHwuAixNFLhuCMd1GFzU6T5txXQi+V2WvlsLWFlpUBh4ZuNEo3i26Oid9opY6/mSurVy0/YTfpcrpH2ufqXZxoUJFnYmvNYcf91C7djnKUYC87UtdM+TFBiyTmlt9tNC7RnwDmBuDxFRhrnZsB7qtoWNp4oCYNVN8ik7YBNvumqgE+IA7PId2aLgyTAdwOvkbSkziQOOeVcXSMrYWzh67VCgHOCErGIC6fC8Yxp4DVC5G5t0yDAl3T3hOyTpvwBODVPdhMiyy7Ek4tP9kK7v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv9S5R2LocG1sW0lng82TMMyRFfV46x5/VxoCjxLgV8=;
 b=iCq/LYlkaBaqZlunK1CqvQnJfM4Fv04SENAZXJOwh9ielkgDEDmrclZqTv2WCgHoFgp4mewLnYxuhnyRnl7J5j0KyI6fDLl0Oe3RWNmtsdW/YPrU5E11BPIwqxYlvONbZEVHUMC477eTdaPe9JRn1obTEPSSncanw9hcb1FM7PG/8U+P/sKXTnF0XfUVBqOOqHVtovLKTiipElJGhehahCEtghILBvPijn28mhV63OVyp+QjHBV2qPaucfq/4yZQOfzIOrCl+D6Oblsiq+bFOvqFlKv++Hli3cJJFvkwWEuPznhZFn5OujoCCDkQna8HcW2Pdg+4iDA/LJzg3L+aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv9S5R2LocG1sW0lng82TMMyRFfV46x5/VxoCjxLgV8=;
 b=voeu5RN9hZIP9gyjKkCKriTE8a+5NJC/+/1ql7oxxP8orBY7+w5ky+mTGo3CKclwXp4WFeVuQrQjOsMpQ4RNFtNEYhfjCJsFYSFL6uQ2fd0DuCO3KhtIQeG6VRdTmVfPR1QDim9SDRPPTfhkfAI+o25BENhct0KIuFdKEvUlt60zmERqaok78RS8FDK/fSDQBGR3MxyeYIZvIoJims2+w1+ZC2rDSw7GrbvZvRWo7ipadwoogW+Ncd7zXCgApXrigmVJYN7DaGeE4Fq3lJy8nKZdHJQOgqwZ/InpJ2ekp+WR0rnTU/DynJVx9yn5NkSGJ7o8zNlgIhdvtb2a1zLE3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAVPR10MB7236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:18:01 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:18:01 +0000
Message-ID: <ed60f3d9-5043-46de-994f-e98d8fa28ec0@siemens.com>
Date: Wed, 11 Nov 2026 11:17:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
 <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
 <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
 <2388290b-53b3-47a7-8a41-39c574732916@siemens.com>
 <e17ff609-5a79-43a2-8630-28e143dc21a8@siemens.com>
 <4a0901c0-0c40-48bb-b605-a759787b8fad@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <4a0901c0-0c40-48bb-b605-a759787b8fad@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAVPR10MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: cadb96a2-423c-41a2-72af-08df3fdd1087
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|10067099003|22082099003|55112099003|3023799007|56012099006|11063799006|4143699003|261021121427099003|261022075727099003|261102123227099003|261028144727099003|261026140227099003|261022115727099003|261026121527099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: pyeSngCsAQVx1MjjTvPTVHv6ilgZ4zbgExITKPNHEsAWoYjHbYvKF/DcXZr7yMNL+jkDT1hBEYFjETp4mNHXOC7g0yE+K6B/piUgv6LeeeO5oozZOK5r/hjNPCqtp8wNUnmsM83J2feu2IvryD3nB1hjM8JrIuuU57pjWCbIoYESkfnzd6tvAI7Vu87qkmKh1kyeyuhuMZIovCXisuDWOK0SXtSNK8nyTFMx8GnuM12sYhrNiGoRavcjSCWlatR1NBNWD710MFUKq7BIYSaTSs9si5weixRC75v9E0LLPirfAy74iqf1qNnyTyeVEHG0VzZQen2ysPTi7yWPixSFRpgALdHuQHT13pkIIOdUSYOq5si9ea7gXCJR8fTl7qmMW8/Fx4gHJ+yB4TUwKqvr+C3KQ7gLj4ydoBE3l7ZtyEK4xDQdSyFbn52VaYcQ4iRsBpfCk9NyrCpGu1JzkOoSJmgRejJlTc47+MM8TG6JUi9nbg5uUc912PQlebD3Jox203HoJX9B0FADjJIPbdMLUNgGYXSnGvuMCYlbxaDo8D4WC1iA4t6dGu7g8mnKmoRroTYnHRajCCdvGIbFi0J/Y0o2Cx21SceywvQ1pFNxv5KfUuU1/rXYq6bVLr/XorhEpMUJRaIRKQpjFZAnUMNYn8wlWuVJLVE+/NVrYLRmJ/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(55112099003)(3023799007)(56012099006)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022115727099003)(261026121527099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtBVkZVT2ZmTGhoYlNxalNKdmdCWDQxK1Y2blRVek1ndDcvVDIrN0RtclBm?=
 =?utf-8?B?VkRyVDhoREhUdGd0My95UUpoOE8rekVMc2dPYXdCc2dGNW5aTkVBMHBsYTBS?=
 =?utf-8?B?bDh4SXRVSmsrbHVVcGZlam1rRGhHQTBTSldPV2x2c0kxN0VjWWVZdUZRanY0?=
 =?utf-8?B?K0Q1U3o0bVVnQSttNzNOTUtSMUVwbnZFNmxXV1BiYmlZNXdKVXFTSTJETzdh?=
 =?utf-8?B?VDl2NnJzSmZ6emJ3MUgzQmdHT3diYlJSQWd6NDFsakMvVDI5VWt1blE1OUhq?=
 =?utf-8?B?bFRxdko0TEdyWWllanBDb3ppeHQwMUJqNzNmZlg1aGx0akZkMlRXaUdYTks4?=
 =?utf-8?B?TVdTUVBUQzVBSEhsTjlrd3F0UTVieUVYYUY3dDJBYU9HZUMwNHlNUFpWeTZz?=
 =?utf-8?B?KzdXWEdRcHI0Tjh5Zzh2UStueTBwT0EvMlM5YlZNbFVFdWVvbVYra1NMTlU4?=
 =?utf-8?B?WUFoQWJhQ0ZWUy9lZFZwbzMvazFiTFlvdHVVVkxIaWphamtPSWxNUTNJY2Fw?=
 =?utf-8?B?aDNXNjJ4Z2FBa29GVW9EWjhzWlg5ci8vNDVWblZHWWJ4dm1EOXVoUVNzZE9x?=
 =?utf-8?B?ZDdLU0FWUUYycUFob0YvT2I4OW4zL3BtTkdIdmoySzhvRDJiKzcwaW5zMnZY?=
 =?utf-8?B?U2ZwdzQ5bDJsbnNWdzZuSWtTYlZwK2RkOU5tK0h6eUNOMlNUSmZCRkRiMENz?=
 =?utf-8?B?N3dJOE9SRVRWVExaTVRoUVA5c1J6bnNOdDBSU21aQmk1cHhZV3hZdGxBK2Vu?=
 =?utf-8?B?WGRvK2dmdkkwdnNNK21HaXZSZ1NGV0Nmc0R2Q1FjV240VTZaK2JEeGs2Z05K?=
 =?utf-8?B?eWhqRys4dGM2bGJvdmh0WkE3bG1rNDBhZWlwVnQ2YXE5anRUWEtsVmZIZGpa?=
 =?utf-8?B?a3cxTnJ1T1IzdHdPa0VVTjVkMW8zYmJIS0Q0eFdmNHNjOHE3NEZiVmxFWGx1?=
 =?utf-8?B?bWN6cSs2aUZhcmZnMnExdE9rZFRJcXpWY1pVRkEzR2RVVisyZzdkWkZ0Zndi?=
 =?utf-8?B?N2tXNERoVmh0bmlUbS9tWlFHdmo2WEFRSmdBTjFpUWhid25oUE5qR2Q1YzZl?=
 =?utf-8?B?R2RNdDFpd0RWU2ljN1c5VGZQRjE1bUdtMnZxdjhrNEZNQjdKRUhqcEhYZmJp?=
 =?utf-8?B?dEJ6QmsrVzhEWkQybnhmV283Y1d0R3lYcTJUWFI5TDArR1JaMWxrb3BDd01q?=
 =?utf-8?B?MzFnTEliSjkvc0xDUk1NVytHTXhSSkl2UXlBSXArTG5zNit4Sjdla3RDVlV3?=
 =?utf-8?B?dC9HMjNaYU9vOE9ldjJ4Yk1KanpOcmpVay9ENSsrdVJ0ZzZPSVZkcFY1M1Ju?=
 =?utf-8?B?QTZ5Vk5QUHhwUjRWS1RJdVFxNEhtdnNUVlE3dlRTN2VaWllEc1k0NlJmOWRR?=
 =?utf-8?B?aW9hemJCcUx1aWNLeXJVZXBaN3c3V2xiZE1nQkRzMjYyT2RXRXRudHBGbFNs?=
 =?utf-8?B?ajBSb1oxQW50V24wZ1JwSVlNTnl6M2N4cWk5WWVuNVY1dGdYc0N6N1NPUEQw?=
 =?utf-8?B?VUNmU0pSWUNBMlFEcld1aThDNnFad2UyWDB6ZW1ERzRsTFYwN2ZCRmt2Z0x3?=
 =?utf-8?B?U0RwSDFyNktoS3p1dnZVVDZkZ2UyeHY4eEpYejVUdGE0enVIUnN4RjQ1WFU2?=
 =?utf-8?B?V3dPNUdhRGVMdHFRVFpBckxTOXUrVHJGOStPWjJ5bmJDRGpIaE5XcDBQZENJ?=
 =?utf-8?B?NkJiVytEVTB6MmNkZTRCRnB4K0NjYjVOSjRpMkZBVUFyYnRXWDA3NjAzRG5N?=
 =?utf-8?B?Q3k5UmhhczVoUlFscGdYRVh4aEZ6WlpHWXBIWGVlN1FsaVRaRDVGQTk2NGJU?=
 =?utf-8?B?TWRhTEhIL3Rsb2xVdFM2MkhGdXRpeVhtb0k1eVp5cE1uZ2VoWVN6RkwxMU53?=
 =?utf-8?B?SS9sM2FFVm1lSU1WQ3pjVDc3NTdybkI1TXNEL3A3dFVJSzFleEhBazVicU41?=
 =?utf-8?B?bVAyWlFVK2gzOE96WFVEZFpQdFpVYXI0QS9vb0hpS0h1ZGNPdllpcXhISk1o?=
 =?utf-8?B?NERxUEkxVXJPc2tWRnZaZ09EYjBMOWNTSUFQdlE1Ym5nWk9YcmlTNkxKZTc5?=
 =?utf-8?B?NlNWM2ZZTnVRWVpuS0hmd1hJMzdRTjFzajNjOVV6UFdWY0t3ejlPMFRsNFEv?=
 =?utf-8?B?VTFvVnRPdGZTWlNiTVo2ampQSGNoSEFjcVZLMmZNSWJRcy9HeHhnMDVsdWtU?=
 =?utf-8?B?UEZPL3Urb0huajVxOHROQ1pJcHF6ZG1FQzJkb0Y4MkJMaUxzQmpVWXZKNXhy?=
 =?utf-8?B?bjZEU0dzdlIzcDBuT1JRMlpvUHYvYUhpWVIrSUJFRTVzL09vR08xcHpVNHAw?=
 =?utf-8?B?a1FxMWZjci9vd3M1dFQ4VXVwb1huSGNiYmV1c2tGeTBGek12dTJ5RUl0TWtN?=
 =?utf-8?Q?n45Gtl8izcLNtkhc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadb96a2-423c-41a2-72af-08df3fdd1087
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:18:00.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04kmajqoATSfOhOnxyqgfxA3Q+IM9sF+SHiea+VCofB3AvgBateJzAusrHg8tXPnIH2ZmOqOXqr/t96nODKyAqR1gI4tXsKrLGLAenlIQcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7236
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 10:18:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24763



On 11/11/26 10:08 AM, Jan Kiszka wrote:
> On 11.11.26 09:28, Quirin Gylstorff wrote:
>>
>>
>> On 11/11/26 9:20 AM, Jan Kiszka wrote:
>>> On 11.11.26 08:44, Quirin Gylstorff wrote:
>>>>
>>>>
>>>> On 11/5/26 7:48 AM, Jan Kiszka wrote:
>>>>> On 19.10.26 12:25, Quirin Gylstorff wrote:
>>>>>> The efibootguard wks files take the rootfs image from
>>>>>> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
>>>>>> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
>>>>>> via the new ro-rootfs-verity override instead of secureboot.
>>>>>>
>>>>>
>>>>> Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This
>>>>> really
>>>>> makes no sense. Please avoid the latter, it looks redundant.
>>>>
>>>> We need two flags or variables to differ because verity consumes a
>>>> rootfs.${RO_ROOTFS_TYPE} and changes only the file suffix. in theory
>>>> there could even be a ext4 partition.
>>>>
>>>> The only way we can avoid that variable would be to remove
>>>> ${RO_ROOTFS_TYPE} from the image and use a non coded variant but this is
>>>> other than normal file systems are handled (.e.g. ext4).
>>>>
>>>> Third way would be to look into a separate verity hash partition like in
>>>> the uapi discoverable partion specification[1]. But that would be a
>>>> redesign outside of this patchset.
>>>>
>>>> Another separate patchset would be to move the partition creation and
>>>> verity creation into a wic recipe. Which I don't like because it creates
>>>> an additional wic plugin we need to maintain. The current approach was
>>>> inspired by meta-security[2]
>>>>
>>>
>>> Is still don't get from this why RO_ROOTFS_VERITY is needed. It'sfi
>>> RO_ROOTFS_TYPE == 'verity', no?
>>>
>> In the v1.13 implementation RO_ROOTFS_TYPE can be squashfs or erofs.
>> verity is solved indepented. As verity.bbclass consumes RO_ROOTFS_TYPE
>> to create the verity image.
>>
>> And the secureboot recipe then has '${IMAGE_FULLNAME}.verity' hardcoded.
>>
> 
> OK, it's stacked, makes sense now.
> 
> But we should be careful with recipe interface names here. This simple
> boolean "verity" underneath "type" looks like a lost opportunity for a
> more flexible, thus stable interface.
> 
> We should account for different container types in the future, e.g. IMA
> or dm-integrity in place of verity. How about ROOTFS_CONTAINER_TYPE?
> Would even account for writable rootfs setups (not that we are
> supporting them now, though).

Ok, I will change it to ROOTFS_CONTAINER_TYPE. In that case the question 
should we rename the used variable in the WIC files to e.g. 
ROOTFS_IMAGE_TYPE if it can contain in the future writable integrity images.

As the location of the variable now contains RO_ROOTFS_TYPE or 
ROOTFS_CONTAINER_TYPE:


Option 1: fallback syntax

--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -7,4 +7,4 @@
include ebg-sysparts.inc

-part --source rawcopy --sourceparams 
"file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G 
--uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-
8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams 
"file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE|ROOTFS_CONTAINER_TYPE}" --align 
1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 
1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 
0FC63DAF-8483-4772-8E79-
3D69D8477DE4 --part-name systemb

Option 2: new variable

--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -7,4 +7,4 @@
include ebg-sysparts.inc

-part --source rawcopy --sourceparams 
"file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G 
--uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-
8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams 
"file=${IMAGE_FULLNAME}.${ROOTFS_IMAGE_TYPE}" --align 1024 --fixed-size 
1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type
0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 
1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 
0FC63DAF-8483-4772-8E79-
3D69D8477DE4 --part-name systemb




Quirin
> 
> Jan
> 

