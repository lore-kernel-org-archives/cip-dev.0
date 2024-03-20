Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E8C54E58
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 11:41:32 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.83])
 by mx.groups.io with SMTP id smtpd.web10.41418.1710934885964067680
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 04:41:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Woz+6fCz;
 spf=pass (domain: siemens.com, ip: 40.107.6.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SekjnUQS2ZnLVaVdZOCkbSpRWVwV1WQ17cZkxRszFlBbEeWk+ExWeRKoBTRxnbco4rdldNSIpUUCaL0plK7twZTyMz90W1zjz4kt4J/3mo0bqYp2Nbp65I+Hjb/lA4zDMlxRM6aniKAm/DSehhSaA6YlMQ2UwnX+WRiR+FNsLDY5PH5ciavmApiHyAJMppz0qp7ar+uq37Ks7ZYHoiLvOqwmmUTcMzCw9DQgbyQr0wbdNKcEXnNgq1L/qlq2XGX69Pkxjf11SMV8YM8sce7+oGYmQPS4naTeJgd8RjMxnVI+ZycwlwM+t143UFASNI2kk+SfWnyW6L3PK1AuHE+mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmBkMtjS4kMgiFzQYzVEFYKz/8TCTMuz70aeULRKUBk=;
 b=OOwqxYMB2JpobGF5MgSrfr7NNtD+cVVpTFxCOR6NHbYK5TD3ATkuT9+RWDjWCReF3FrFhOX1fn+sjAvf8oIKsO7w/13UA8mftXAACiEvJj2AFGej3+oFRcMDsSbhmLiHFFjVnjBcBu/pQpA9M1FXF65P7sl9xa118wmDYzBz49kRQZgkfi+YQx2/04Pox5MxSfDmJuZ/9bqtV8md+nudtaJTk2XkEgGwb+WGxK6peBRTwsC7hl2zsP/Jmk6KCVpncYqEZHRaQ4Vq3pt7GzOcLatKOYkRaHJm+yg5BklYENj72ppXWarRUJa5PiNXUajg8+eGa62sYJDDOLsFaENXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmBkMtjS4kMgiFzQYzVEFYKz/8TCTMuz70aeULRKUBk=;
 b=Woz+6fCzzokdDZGBapEztdZPr2KgaA7VCgC1zhfXlch0aM8WGHtnokU8B28KILu1urGTYGv6WgeSN83ll4KgbtMGuq1Xadzf1nnIsm65UPBNo6kD8/k8mF4FWpOITPDAhzvz2MMF1V2p240HPHp0eoCEgDJ29ixX10xC16izts5fY1v8J71c0gsXDN3JBYVDYYoYYavV+l3ieOZcu8YyxYwk7AvwbA82PloWSecR0Z4nBQxRlTYp3ZqntjbOb1OUaf1WVZA91+dZao40zSOsLix5PHUYcYPRn3Q+S9Xu/c8AzNo5Fvpg5S4ABx3ImJeU90vxOJYn9atIfA64h2wPtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:41:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:41:22 +0000
Message-ID: <6853e791-5d6a-4b48-acc8-06d783a6554b@siemens.com>
Date: Wed, 20 Mar 2024 12:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 8/8] Add example to encrypt the
 rootfs
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-9-Quirin.Gylstorff@siemens.com>
 <09154543-a923-4dfc-a6c0-0920da9bf45b@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <09154543-a923-4dfc-a6c0-0920da9bf45b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: aba18af6-53a6-4e02-f19d-08dc48d2aad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kMd00yOHpEazzkv4HEahAmYZ7hu9uzBlev4OyVhlR8hRzT19BcerWw2amyy4OitIidg4tYhpDiH8G8HYNw7C4WcsQHghph5sGwNg4X02G88l5Fc3SIAWSuu6i0zuuys3vmDokfPelG/ekph17/QKg+zJSHFJ1ISU/GeLu1Yv8zs+3yRwl9jHRY4l5eb8aMbzU+RRpT0y6bsmvSsKAg2yx75ZG7l8YsP3H+2U9i2T9xLG8xX2YEdbG9MjOBnpMErdsHh+JcWfZ1OX6XGpNdDSvCWnk0ZAkaCTlKSTaJhmXddW/v/AFDctd1cOLvEiBFzdLekWkHbvqHyz3jxlY6ykut6PIlIkDD+eAZfuYLcdqk6UjP82eACvrkuCGzvA0ohP6OplN/m7YZnSoSZe4EPXVq4zGUe/HiYDOtNhjUzryzzmxHgZ21NldDLY011z9gqtJiZx4dia8oY2rpSTCazpZGsfhqlUAgkAtTk/m/LTyPpN92iA32vCBftvcQshiKl90WHuXXrwQrXakDIrB7EEFxzIhbFX7/UkffEDOF8rVaRpAvi/2YoAZrq8ssx6IquKAvgds5KBoEaaV/VO4Z5PTtx1+2dV4HhGK4sow+m4ZW6JbZEP3hU46PdWAHhJSyrDCiCuuJXTgdBbEMeTxfOSnOJ4QBEtg3Bg7etMfNHowg0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dENWUlI2ZEVwUFNodEFhZkdYcy85cmhXOTlCWUphS0lCNFBObk5YT2xXbnh3?=
 =?utf-8?B?U3pFUC9iOEVhRXh5Z0ticytOb3hNWVNwOWtmZHVLOXg2TWpFS2g1WTE2Z1VI?=
 =?utf-8?B?aFlrNjVvdEQrOGd3YnhNb3p1enVpSTBqMkp5elY0N3MweTV4WFhOVmo2S2JI?=
 =?utf-8?B?dXJmR3JBMUY1WnUxcVJ5Qk0xaEpXZUl4YVdqNXlBSitDaVRzeWtlc1dZODlJ?=
 =?utf-8?B?cUVqTFpIOXJBTDd1UVF2NDJvck14VnAxZ0FuUnlIYzdLUkFmOFNGT0R6bGxH?=
 =?utf-8?B?eUJEazB2d0ExUGtlOUVxbG1qV3g0c0RjVG1aR1NvcFJJSjcwMnJUckgySkVz?=
 =?utf-8?B?eS9WbHVwMlNFRUozeTRnQU5yVHJSYUFLOGNRV011bmhRUVQybHh2S25tQ2lB?=
 =?utf-8?B?NFlHUFl1SVZESjU2YXZUS09xRjhGTDl4Y3dxNG03UXlZUDBsL0ljbnFXUDRx?=
 =?utf-8?B?OWJGZHUyTW9lZS82ckJhalg0Rmh3WDc1elYxbnhqTUp1UFpTaE1TcUZXbGZy?=
 =?utf-8?B?bnNIcnNkRXllMHNZT0w4TFMyRHlRbld5aDRJcC9JTHFXRmxCalB4Skk5KzI4?=
 =?utf-8?B?S2hwb0VhaTBIcno4L2w2aFJQR0RFd2plOWp4M2taYVMrOCtQMk1XdEcrZmxC?=
 =?utf-8?B?QXREaE9OakNWTUxoaGxCbTN2UUZZdDIvYjcwNFBCT0xQakdlWXkrTHY2R1VY?=
 =?utf-8?B?dk94UnBXNjZFc29QWTU3b1lQRkdFcHllQUd4ZHR2dUtUMmU1N2dadVlWcmNK?=
 =?utf-8?B?dW5yTGpYYWIvL1EzV1ZNR0hIU1o3VmRwbE9rUHEvRWllM3I1UDVqeGpyaEVN?=
 =?utf-8?B?SEY0L2tPMVhROUczRkI5MVpnbk9GRUF1RE9PZEt0ZlV1NThsMVZJazFpTUN0?=
 =?utf-8?B?Nm9xL1NDY09oUDl6ZVJ6SW1TT3lsRzd2R0R1aTUzOUNaUE80NzdyYXlQY3NJ?=
 =?utf-8?B?MDZzWDluSHNLUGJoeVA0QngzNzNhVjc0S3Z5RE8yM21qRzR2a0hHWmQrcWx6?=
 =?utf-8?B?aEtDem1Ed2RHNDM3QndwczExcFlYTWdtRkhSbDlheHdjblo3K0dUTmdKYVd2?=
 =?utf-8?B?dzVQU2orZnBsanNCU2g4YzFrQ05yOUFGTjN5VWV3Z1JaWUtTd2ZmVHNUc2RM?=
 =?utf-8?B?UmlmNjB1ZnV2dGxtdmhDR0R3MGhOZkp4ZEx4VTR4WndRTThsdzRRd2g5bUR2?=
 =?utf-8?B?d2oyYkxwRzVzdGsyZ1hCVFRWbG9JRGlTNEZLa2tmdUNrUFJmSmZyMDl4VHU1?=
 =?utf-8?B?U0diTGp6VmErWHVpaEdJb2s1NGZsN0VlMmpLRWZLN3ZiVStvM041NStOUERa?=
 =?utf-8?B?VGpvZHZNeUhzMzc1cTBsSmI4OFl4UmRBb01QSHJBaWFyV2gxbnNkV0F5V1FD?=
 =?utf-8?B?dWVYVGtka3lHeTlrK0lDWktiVzN0NkVJQkMzUnRtZzZTUXVaeFZreGR3OTVp?=
 =?utf-8?B?RHBEcDJ3K2JnWjc4US8wUE5vYWI0Y1FPdnZkNE53U1QzSXVldTVOdmNUNzVK?=
 =?utf-8?B?SWpldkkrNWdGUE1Tck51NW8zeXVFSVNaZDZvRURNN0NNVWdpTHFUVHdxWHEz?=
 =?utf-8?B?ajdQR3VnQXUrcXpFR0E5YjZ6M0RDeDVydDBHbno2elg4RVBuL1h1ZmlCeGlZ?=
 =?utf-8?B?cXhSN2NPbnEwbjAwb0NGVmo5SUFreUxyY0tGanU1VW9taXZvMThTRWdvWi85?=
 =?utf-8?B?RnJlNi8zTmFZQWhKMWsxeFVVM2FzZm85VHY5cWQwNW9BY25udmdHUm1HVHVy?=
 =?utf-8?B?UjEzaklmaE00WkR1UDk4SlVvSXlLSkhGYkhkWks2UnM0eG84ZG5ZNzZhMUxU?=
 =?utf-8?B?QzRFWUZxTW1kQ2FUUFFlaDFWRzQrR253ZVRMUTUxdHBVOFM5QVRaUm5STVVS?=
 =?utf-8?B?dnl3dFZDL2J6SW5GZFRndnY3YjJiV3BRS0k3NUJhazB3ZG9WaTBIdlo0KzJ2?=
 =?utf-8?B?VmZNZ2NQcUhZcVFxT2UrakI2eDV5TDVUdkdESGRSK2tpS1hwNy83TXlzY1ph?=
 =?utf-8?B?RTJDSFBSOVM3VWx4QzhJdzFaQ3dkQlBZb2d4cEJKRUhPdFpnMTdnQVBySW43?=
 =?utf-8?B?VVV2Y00vODM5bzhhUFNheUNzbndtcllJMUlyYlQvOEp0MjhMcFhYUG54UTE1?=
 =?utf-8?B?NDlhbkZnZnFLM283bTdXVzVwdzNGc3Z1MDdoOE5ZWXM4ME1STnMzT3dreHd5?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba18af6-53a6-4e02-f19d-08dc48d2aad4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:41:22.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAydaaxa7Iz1HXGsK9zdgJXUnqZYOmwDJTR8tyEvOBWsPJzb/HtiJqg+kHXqO5Wkj7kIDX7KI6pT1cQEo2A3UcF0V0JC7kaJhytnNxTZN5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 11:41:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15385



On 3/19/24 7:42 PM, Jan Kiszka wrote:
> On 19.03.24 19:18, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> This is a rough example to show that rootfs encryption is possible.
>>
>>   kas/opt/encrypt_rootfs.yml   | 24 ++++++++++++++++++++++++
>>   wic/x86_64-encryption.wks.in | 18 ++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>   create mode 100644 kas/opt/encrypt_rootfs.yml
>>   create mode 100644 wic/x86_64-encryption.wks.in
>>
>> diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
>> new file mode 100644
>> index 0000000..4001c75
>> --- /dev/null
>> +++ b/kas/opt/encrypt_rootfs.yml
>> @@ -0,0 +1,24 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 14
>> +
>> +local_conf_header:
>> +  encrypted_root: |
>> +    WKS_FILE = "x86_64-encryption.wks.in"
>> +    CRYPT_PARTITIONS = "platform:/:reencrypt home:/home:reencrypt var:/var:reencrypt"
>> +    IMAGE_FSTYPES = "wic"
>> +    IMAGER_INSTALL:wic += "systemd-boot"
>> +    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
>> +    INITRAMFS_RECIPE ?= "cip-core-initramfs"
>> +    INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>> +    do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>> diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.in
>> new file mode 100644
>> index 0000000..c143500
>> --- /dev/null
>> +++ b/wic/x86_64-encryption.wks.in
>> @@ -0,0 +1,18 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,initrd=${INITRD_IMAGE}" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
>> +
>> +# Not nice use the source param label to supress the root commandline
> 
> "suppress"
> 
> Can you elaborate what will happen without this label? Another, wrong
> "root=..." would be appended?
Yes the default behaviour from bootimg-efi-isar is to add `root=<uuid>` 
to the kernel commandline

> 
>> +part / --source rootfs --fstype ext4 --sourceparams "label=BOOT" --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
>> +# home and var are extra partitions
>> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>> +
>> +# This works as we know how that the luks device will be named encrypted_<label of the root device>
> 
> A bit ugly, indeed. Is there no way to let the script set the
> appropriate root?
We can work with templates for the rootfs label or set the ROOT variable 
in the initramfs like verity and or abrootfs. The second case would 
require the initramfs to detect a encrypted root.

Quirin
> 
>> +bootloader --ptable gpt --timeout 2 --append "root=/dev/mapper/encrypted_platform console=ttyS0,115200"
> Jan
> 

