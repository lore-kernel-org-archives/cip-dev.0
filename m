Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE266C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 14:13:33 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web11.9142.1702304005144290895
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 06:13:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VBIxj1f6;
 spf=pass (domain: siemens.com, ip: 40.107.21.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh1BtNXc+eyHolI3Fn8ONx9PMEQdc2F6TEzlUSnDz1tTdU6EA5enIzN8ZVIqtNXoiK1/S0vk+Fmq1NJXsKhqX5zJj6zpwgL0/blCJzmiSaODFUn25d9aKMbZN/fG5L3Xx/DDwCl0SxG46f2QaxrNI/eLsnXDs000citGOUBpAv8h/YkIkvgovWwDUpVkhHJYWZ3ds+nnEtfZbm+PWIpCKDYErTOvf213Up16erUQgatPDAYxjNHn/dH6zcAFu8nPkNnwjDzgoa0ti18w365DPlnYRXsAmu137qy+FTh6kN12YxilrE/njfylmOBrUKW9uJjyeY9gSl5pO4QKGedtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G2mDTczjfYvHOrC0Ql5wfAMpROr43kIGAflGfY4Dow=;
 b=NoLg2WN8scTocprQdU4A7ZrtaBNC6cuwvQG8k8iZDNNsJ+Cm76jcTy6AVtIrdtpVH74LXp1Z8BlQmqM6wds7FZScXCiIMZRgk+xuA/eqhoI1fHjtIpRNLMniTYqY2PCdO/M7Qmt+BE8GuHsK/gXM4w1JBwjPcJ3rn0Xuo2UJTexxPSa/RcR6HaGNxdo1NhxKIoGOigqQH9Rboylch/hg6oRBCbKAc87ByTVBCjifyheTqOT78riaF9DWL4prN+BYPVG5ov+CNpuNjWq6ZWlt+IQrN1+1IiY2aqsFVQ+3Zoxq3q98Ob8IMv4Kkg3BEhtOEBUyMLysDv0XPuAe6qU0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G2mDTczjfYvHOrC0Ql5wfAMpROr43kIGAflGfY4Dow=;
 b=VBIxj1f6zErPdeIPC/9u0F+nHzkneSIzcRrbkSFj5W5gjeptdoJzADl5xb/xlLsIxMiEZkGvf61ekvi4YDgMIgDIFtO4SqXg/1yuA5J1M2EJxwdW5G/yvPF8uKp83lNq6GVRePp0EeRC8T4A9JbfNyPrvKTXqmrSY/5Dv096zGN8OEgAqnmd9vayuyoo2n0rGa1NTin4x1b7VLLQ9CJBMot6Tyi67UtiVila2JsuK4Bn6UZKHBl8SYXgFgsJJUqk3Dp1u5SYA9epl7p2LG+GwcVKG+MofDOBd+7569VXiMRoKKs/z45xufOYpWNaT/i/Su4gh1WyxDH1yyEAORylUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:13:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:13:21 +0000
Message-ID: <952cf6cf-65a3-4e53-ba25-01afe312452c@siemens.com>
Date: Mon, 11 Dec 2023 15:13:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <570fc651-6525-4273-ad9a-aeef4737272c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <570fc651-6525-4273-ad9a-aeef4737272c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: c1615bc6-79e6-4d3d-291f-08dbfa5354e4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	siFWL2TxrDkxG3jf6sRhKuZggkuXjJYTeApGaru03kb5EQIUzU0eTt9u/eUOnvcr4A4AtnsLS7aaENckg6uAZK4It2SkMT4QmcTjpkpccpLAujXi5M7PJCbE8HH5XK4IAnFdHVM3nC2+iipkzfSN+6d84K04emSHEZ2LANWpawF4XSjxNND90ZvSAw+UaN/TJh3L83LTnroRQd9w8rymtK+9TdvrAGH5dE5K8jO5eQREUGMaus0ze6YZEEJ59CxRLnZSWQoPzOUeyjnUG+jDlcouKPE1+t415V3gK6M71pkFTKdjxPnZL0s9hyhjrjIlzyz3vk5Oh1hHQRzxKgO2XQIALliTqaze3hYSCr9XTQlVjEx6GcxjHKJ9FfqNXwBxMoLGwnn7a54V05TL8/lbWRnm3GB+r7O9BQJJENNCiRJlyCnK8oYkrc8Ygwxr/CyS5IDj0EnJ6JTRoNDJnrp4CETxu6GELk19S97rz+l23kq/WXXYDdL22cklkfH1SAVf5xCdm66nlJqO2wjXESAA5cnlPdw0o+pLgZh6tn9brigM3Wi/R/kuBBF3is0uYwBt9wjnA7i8jQA6KPeuogG7B5Zn6eQHXUlji8dtsM+wskjxyFCLEHlGPA38JvxFt6KCRooLrYek71UZur+7ljwYcw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(36756003)(66946007)(6486002)(66476007)(66556008)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(31696002)(15650500001)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFZHR3BBc3BPWDF5M0Y4a3FrTytQb002QXJlcUdZQ2FEbUpYMmVDenEwNmlN?=
 =?utf-8?B?ODg2ZnJlSzJReEMzc2tTU3Q0c3NGbHdBY0g1bTJxajduaDFncUxNajl5VWFm?=
 =?utf-8?B?OGRkbXpuMjJ0MVJHd1VTU1pjTFp6VXJnK2pqOWMvV0VsaU8xTnNkMHdRUitm?=
 =?utf-8?B?aHpOVU14MWtUTGw5eTJBNkhxKzJYakhITEI1dmx5SkNtazN3RnZ0eFBNQ1By?=
 =?utf-8?B?TFhIRXJNSG1VYWE4anhJU2ZiMVdmd0h1WUE0MHJFWFZhWlBGUURvaXkzZEZH?=
 =?utf-8?B?RnRTT3NmYWM3WlVSQklvczJROUNuVk9qTXV5SUZ3OC9tQUVpN0hkYUFYeEdE?=
 =?utf-8?B?aEJjb2ZsWFI4eXNnTmtVOEQ0cDJRQTlCcUV2VzNlNmdkSm5vdk16Y0EwRXly?=
 =?utf-8?B?M3ROaU9kbFdzNTRqQ0pJWkJHS1lJSDVpdHBDK29iZ1Z3ZWZ2dkMrenRIbTVJ?=
 =?utf-8?B?cDFoWWZwTlBWbjltN0JZR2dza2lmVFk5ZVRUeDdRb2xVWnhPWW5DS3JTTlhE?=
 =?utf-8?B?VkFrQ3VtYlpCMk03QklYMUtrWWI5bjRKbXg0N3hac3lBMHcyQ1NxdzI2K3J0?=
 =?utf-8?B?MElneHBlZUI3c2J1Y2pZZC8zdWE0UmNqVXFqVWNpNVF5d2RINkUwQ2toUUxV?=
 =?utf-8?B?Y0hHK1hFMXRpVVZ4dzhTWHlGbHZmbENtZmYwRnVNZXIwQXY3UHBWYm9ENC9B?=
 =?utf-8?B?elY1dncvZWlqRTAzSkhBYkE0WXcrOUllRTZid3cwU3BuZklMVzAwVTd4NExW?=
 =?utf-8?B?cmZUZ2VZVHBwNWJHR2JpOElncU5mSHdSelpzRW11Z0o4SXpYWHBLVWthMFVR?=
 =?utf-8?B?cndIOExoV0hXTFhid2QwM0NOWFF6d3YrcFNwZ1pTbFN2cXFvekFrVEdKdXIx?=
 =?utf-8?B?N3hoSXR2VnJuUG04ckQreWNEMFV1d3c0U0todnVSdGVvN0lwdXlhSWpwbFJN?=
 =?utf-8?B?cjBMaXBlbUtoZ3lzODgvUmVBeTRMSDl0Q1g0d0poZWtFbTBaa0ZDZlVLQmlD?=
 =?utf-8?B?dzg4UlIvUUNGVmlSS1JSU1pZZVVXbHQ2RTAxN0NxWU1SaWVSTkxtV2x1Qkgy?=
 =?utf-8?B?VkthVlNjRmxqWTlJbnVrMjBTelM5RjAvbzJ4SytLeCtpVHZWS3g1akZEQWpM?=
 =?utf-8?B?QVVVWkF6bDUwSmtMZFE4SWs4Vjg1QS9vTWlJd001Yk94ck5KdGQ1NzRmUEhO?=
 =?utf-8?B?NnloMjhRS3kwdmFQR1dMS1ZhV0RFMHBMK1BsZWNrWUNoUWhGdUEyNWpXVGlQ?=
 =?utf-8?B?RkUyNFVsdUtpa2JYbjdRSk42Ty9PV3YzL1ZiYjVjM3VFM0wzV0hnM1Zmcll1?=
 =?utf-8?B?L2lYZWZLZ1Y0Vm4vZmhMSkhlNWx2dWFQWTNtOFRRd1NUL2tPTlNaS2ljbndJ?=
 =?utf-8?B?aEFVcFgxMFRnWTgwb0xWUzhJOHYxc0tuLzhwYVZLejNYZjRNbUJYMGZqdGYr?=
 =?utf-8?B?ejVnVisvc1RYWkhtUHNFZVBhL3NGRUJwMkVLQ2tpMUdreWxKZ2VaWE9LVno4?=
 =?utf-8?B?Qk5YaGoyYjEwSHFVUkNrdlhvdytCZS94NzFwM2hKQ3BLK2FybUYvRUo2ZHl3?=
 =?utf-8?B?UWFCZ2tZOVA5KzZFQ3Y3NGNUdDFWa1lYVURHam1xTk9ZYkl2U21SOUd5N1Vt?=
 =?utf-8?B?WEdzOFJQSmtwUWpwVEhVYzZVNERoMHJKWFd2Z1g4Vkx1MmFDQmVqRE5KZDk0?=
 =?utf-8?B?TTUyOUtEeGZjMFJ3VUY4cnA4TzJveCtKN3VkSUgrSUJNRGdmWU9ESEdLWW9Y?=
 =?utf-8?B?RWEwMXNXZ2l5SDNPWnVBbEo1UlJVeXRZTitjYUI3aTVLOWlEUVBxSTFlVnNi?=
 =?utf-8?B?K1p4MzVydTN3RW1uVy9XQ3l3Tkw5K3YvQUYzbjQzUDRDMXgySmNsZWtER0lw?=
 =?utf-8?B?YlcrU2ExbTFKazlSYXdkODVuMmJpbksxalVTd3FLRWFQclZQcHdkbW5FVVZS?=
 =?utf-8?B?MEZjTDlUQktPMjFGWXdpSTNwazBTZHdFWHFnUmk4U2dMdDQzNDhiQmgvdk1N?=
 =?utf-8?B?ZGNzcDkyMC9wOHBkckJvcGZKMzFOd0R5aHc2QUVHd2JHeE9iMHNpazlrMDR4?=
 =?utf-8?B?NGIydE1aU3cyMnFZdTdQL1BycjJScjBFQU5NZlVodWh0N3Y3UXRpOWUyb2RM?=
 =?utf-8?B?bVRKZTZlWjB4d1pQZTVzWStmL3Fmc0JiWWdGdTkva29ZSmVNbUV4VndwUFpk?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1615bc6-79e6-4d3d-291f-08dbfa5354e4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:13:21.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB3D7FbvvQh96v7MjVxTIEfMXtjo18NQHdUwQbYBqCpP74j2RG7qkPqTR8axLR/jo7Xk2b4QED4CoqqMhK/zZTx7XAz1V2OQaJtT809MwIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 14:13:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14029



On 12/11/23 14:46, Jan Kiszka wrote:
> On 11.12.23 13:19, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This series adds the, possible signed, efibootguard binaries to the deploy dir
>> and adds them to swu file and sw-description to update the bootloader.
>>
>> The new entry contains following information:
>> {
>>             filename = "{efi_boot_loader_file}";
>>             path = "EFI/BOOT/{efi_boot_loader_file}";
>>             device = "{efi_boot_device}";
>>             filesystem = "vfat";
>>             sha256 = "{efi_boot_loader_file}-sha256";
>>             properties: {
>>                  atomic-install = true;
>>             };
>>      }
>> Changes v2:
>>   - The efibootguard file is only added if the new variable `SWU_EBG_UPDATE` equals `1`
> 
> What about only updating EBG, rather than always bundling it with a
> rootfs & friends?
> 

Currently this would require a separate sw-description.

I am thinking about rewriting it with using libconf (python3-libconf in 
Debian) to generate the sw-description. This would allow that use case
and other more easily.

Quirin

> Jan
> 
>>   - Add the variable `SWU_EFI_BOOT_DEVICE` to set the device containing
>>     the efibootguard binary
>>   - Add the variable `SWU_EXTEND_SW_DESCRIPTION` to all extension of the
>>     sw-description file
>>   - use atomic-install to update the binary atomically
>>
>> Quirin Gylstorff (3):
>>    efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
>>    swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
>>    swupdate: Extend sw-description to update efibootguard
>>
>>   classes/swupdate.bbclass                      | 47 ++++++++++++++++++-
>>   recipes-core/images/swu/sw-description.tmpl   |  2 +-
>>   .../wic/plugins/source/efibootguard-efi.py    | 13 +++++
>>   3 files changed, 60 insertions(+), 2 deletions(-)
>>
> 

