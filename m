Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5BCC54E67
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 11:49:42 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.47])
 by mx.groups.io with SMTP id smtpd.web10.41558.1710935380509751011
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 04:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XPcpPVHU;
 spf=pass (domain: siemens.com, ip: 40.107.249.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSD3HtAarN64HzEfy3p9NacQvL5Sx3SIwWBFBkDh6eOvfYfJmTwyZrWU0/IoT7TesDGXOCmmVRdlyHHHl96ObYq0cYnjvQ1acRbp9pQ/9rMLpFIFGtWF0zM3Yuqoe6waTJ8lRkh5O+DROlPV0eDvWYaHjv3Nl8eTNlziVFyd8Jm28R7/xug3Me10cTEO602TeuImFkIS6dXhOP7FpoqrMLR1SgqlIg1ABUTj3mzEQC+2auZd8Ue6VDyxHGjbFPWfhQ6hjrXtblMgAk29NrtAhfPv2ow71T2FZdAvqAXZ1MfejXDHX2nhi2X84jongXJXwFym+Po25e3sUli17viVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYUkXY4OpO7nT3tbn+mgGCCB9xKIJLrZ26FzUpI4Xtw=;
 b=bZMwZLkyLbgDisAuHb7S2vUIO3R8olOdB2e3/6pNCLLACdbJIDPXznnc8uhwD3XHFim76O1J/sn+wxb3F0N9IKtSepqs+SmHS/RFf4wyP8Mxxu+Up7O84KYextQk46svX/Xs1pLd8EDbZEz4U/rwUfbpkZVvnQy/jA0LtAxLqliytSX+DAAPn7u5bknZVLFes0sYxD6B0W+Lj9r+yxcERo8IfI/f/Hbv9oRppgDj+rj3auqrR9arX11WVSKyTMf7o4vmD2w6LHLIAf1L9T99m56r8QlbuRSWsXwMY3tsmxTqtLV5EI4X2LYuYIpiIL6J3UERfeLevOsSp8rxvHW+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYUkXY4OpO7nT3tbn+mgGCCB9xKIJLrZ26FzUpI4Xtw=;
 b=XPcpPVHUiUoZRA9ykPdgfXWJy6noCzfk/tKwkGVjGxKhEgbRYjtUOUyTwAgahrejSJEvWa20eaef2lgH1keNHvJJJKfFkjsL5C62JVn5zb0vzau+Z8DOlqD4ZvDwyjezhJ98JvxXdc/sDIDzkF3EWb1iY/IlhUhgLNpwx99Z0b6WGMl+kjpggI+Jxbkcrnqmv192BqbscJ03KzOXS/RCgt4iHBrMNR+KtJBMQLxJmuXwnMZQJ1+FROFXhc7yDfNfB1X3cuQ416Oqow2hl0xSG3orpOYpLNGp76L7vxVlXVkh1emzhXnYPp4AC6FVyx4SrqXsiHNJJpYVmBAfrAUayA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 11:49:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:49:37 +0000
Message-ID: <c9216a86-403f-4365-9668-c8c0a89445fa@siemens.com>
Date: Wed, 20 Mar 2024 12:49:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 8/8] Add example to encrypt the
 rootfs
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-9-Quirin.Gylstorff@siemens.com>
 <09154543-a923-4dfc-a6c0-0920da9bf45b@siemens.com>
 <6853e791-5d6a-4b48-acc8-06d783a6554b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6853e791-5d6a-4b48-acc8-06d783a6554b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6753bf7f-9dec-4809-f105-08dc48d3d1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H76ACDagrTu8YKVUwYt4rtEz+8WEqDZ7fX7OMRjpou7H7WqYSVRFsT3SdAz9YkyYavJISUFh1YrrO2+9lh3wtmwqSVxuOxjWnDu6XrUMpmBAAxMhMK5XCPnLmes6sVBVun+/P663vdjlwpXjEAZjxNRFbgL5hb64Jy3Xpk9z/dWSCX/69ET7cwsqXqHDrrRMILtP5g+oFWBFDNl79ZnYbCgXBxdvTOttniVcTQiE55F2dmYZ5xaSW4FJ5IDpXjdoGfsnzA8VScCzZpjztho6732j5gvVwrmFdZdzo9dE31XrciE7eFMRMBmu9ZZxP2qFBIIYVyczF9JbMmgsy+6fihhGUW4VbESXAZJsNOfbKG4LbJWezKz7xAfLdiaSTMIGrAekHGZ7f7TrfqCpgzyBNS1vyETniRthbjejdJN8742srtpsYMq6smUc04ngbFEo448lvj7+HA2jF9t6DB/aioQFJpeiGRENyq9sfK2LKXUY7//zWVuH4ttJEm+fdB+MZitJrHS9SRl4xJXEffjxkFN0+qgazYhHx1du9PKNhMPQ0SvO44R9yV/C3NaFiKvcSLZh1vXn25+yKJwfyGgHBM7OsMspIz0rpFmahfCUTIedyeFCUP1sxHmPYilWYrOShixI5p3FkfBKN3IowCRnXxHTTzDYEypv/6gvPHO6bzY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PAURpMhrXPmnhQo6os14XnyWMF05MVzKezuK8EHpslq0upOfdAy2SVU26Mpf?=
 =?us-ascii?Q?o7tZRlXbbYh61yWKysdJxE3KhCuMVxHyNBLRCE8SmqLKRmptZ2s4J7emdXvU?=
 =?us-ascii?Q?fMfnU+4W6cuhmbU6bU7agntYz8OMbrYVmnp+7+5kMWQfv1BN+a7pd9qq/zBZ?=
 =?us-ascii?Q?d5LH7ShRCRtGHDQ70WzaQjyvDFMUjvD+exSJl/1orKA8Ks3fqMRq1GI4JA7V?=
 =?us-ascii?Q?XXxQrnv8puKwGBJAszDIWKlMktQDkt1WE+MQiljwbRS1Ezk4czcsNuvpxJSR?=
 =?us-ascii?Q?ru/nU4+BCTagB6rutEMjWa62zg+ZdJG3dndRO9KiPrOvd8lSNrGVYSY4DFAY?=
 =?us-ascii?Q?KfofPZ6gPcxjK0lzq4T+BhtyMfo9EIWEqxSX/JCtN7X8lCXUxTTIHuPWj9AF?=
 =?us-ascii?Q?EFQlyMoM77ayuNP4XNZAnqtCGzCJJM6zy5emxuqKyKBrD49CkvGZfAHY4oNb?=
 =?us-ascii?Q?+taife834o8pyRhvTsvPjSy18zP9ZY3oGjkNP4jjlVYs1jZitUg0t1cb5DV0?=
 =?us-ascii?Q?i8x+mcnxFOijUJxkU0jx4NW2NcqR29jlIF2jDlSRiJa6z0xkNs29cQ+7Vn61?=
 =?us-ascii?Q?ZrfpjklIQmpnH1ilL520V2YU3dvTtdGG/axEHyhyuYgrNnxUdHbioH1IPWtt?=
 =?us-ascii?Q?MRTQ5wNax4QDt05wPAC0svDLMpgMRAQun0srfDhCpSwIpjv/VCWmDVrgptPw?=
 =?us-ascii?Q?ZMPy3zmH9xguAQVTsJTUNlIP1HeAo5031l54REH/CwN5074s17CPN9hkc6cZ?=
 =?us-ascii?Q?/RN6OouRAJYlFqCP70UtUsICr7UVlGwrSNKZc8I4Gc+HYQF6JJLx9t+YCJWC?=
 =?us-ascii?Q?t7V2zzRKKhLAIPO0NaCHM4RWpNTE0qhs3cZoCh4GT9CC5uKVPPHq86r8RvRi?=
 =?us-ascii?Q?r1h0atnqTBh94dNxBLEREmH/uuHgYY9nnwetJOQMr5LZYRm3DVsUuh34VXgk?=
 =?us-ascii?Q?XMSIGAdAdIF7NUsi6jxVv8D3Zxo9D2xRbRySVbbiTEr0uu+7gc8tmxCh+oqv?=
 =?us-ascii?Q?+/9WEVsb7DE5z4/0hdIM7aAZ0NENnBaHPyDgOzA36vNBJWKPBCPUN58AWu5F?=
 =?us-ascii?Q?zQ3qod/yncP74eQSQxvP+KAJkGdfng7zAh7iCPFxQgrgMfv2TvAZBzd7y8YG?=
 =?us-ascii?Q?nL2nggF9fjUybd+kzd4EZxLry5XAXW/SbJ/CIzl1xxoQjkVPvfwzT39i20UO?=
 =?us-ascii?Q?YY6vFun0b+bneM7yoLc9R8zzNCdi2hdKPHEVf4Tn/ldVqB3vxMgoV2LxUJIT?=
 =?us-ascii?Q?x+WUykJZI0pgYqKR9HIXIhobDSUXijsmo8/bVTwP6HIqJF8BDa5l6Xn2+Yvx?=
 =?us-ascii?Q?IfglLRsl0gtxrtZVTAiO0qiunHooTBT/Z1VD0Q+lJzzTE0YQkLLJ0aj1tsWe?=
 =?us-ascii?Q?NPJfEGbuN/2Vzd5ylrpLWwoDupEi1X0IAFQSiI1W4G/hR5Mw5CDdHmz6EnP8?=
 =?us-ascii?Q?dOg99dt8Pov7avcnWAK0CuE874tEEBNPML73beCUif3cAL0Csf7CPu9vvLpc?=
 =?us-ascii?Q?V0um/z0xNN71FRyTs5GtDk2p2Ahxj6raPr26+NFquKbzhfY6l+49B2NvbmlV?=
 =?us-ascii?Q?EY2w9N9ud543pemfoO1XfRkQgne3GSHCaymEU4R9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753bf7f-9dec-4809-f105-08dc48d3d1c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:49:37.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIkNahBeihtJHWD1cyVk5sUv0Y5FwhnhDh5nIIgxwPr7Pyn3GuSwnHUuNaGzS+lF/Y8PJdof486fdpVSD82UUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 11:49:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15387

On 20.03.24 12:41, Gylstorff Quirin wrote:
>=20
>=20
> On 3/19/24 7:42 PM, Jan Kiszka wrote:
>> On 19.03.24 19:18, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> This is a rough example to show that rootfs encryption is possible.
>>>
>>> =C2=A0 kas/opt/encrypt_rootfs.yml=C2=A0=C2=A0 | 24 ++++++++++++++++++++=
++++
>>> =C2=A0 wic/x86_64-encryption.wks.in | 18 ++++++++++++++++++
>>> =C2=A0 2 files changed, 42 insertions(+)
>>> =C2=A0 create mode 100644 kas/opt/encrypt_rootfs.yml
>>> =C2=A0 create mode 100644 wic/x86_64-encryption.wks.in
>>>
>>> diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
>>> new file mode 100644
>>> index 0000000..4001c75
>>> --- /dev/null
>>> +++ b/kas/opt/encrypt_rootfs.yml
>>> @@ -0,0 +1,24 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +header:
>>> +=C2=A0 version: 14
>>> +
>>> +local_conf_header:
>>> +=C2=A0 encrypted_root: |
>>> +=C2=A0=C2=A0=C2=A0 WKS_FILE =3D "x86_64-encryption.wks.in"
>>> +=C2=A0=C2=A0=C2=A0 CRYPT_PARTITIONS =3D "platform:/:reencrypt home:/ho=
me:reencrypt
>>> var:/var:reencrypt"
>>> +=C2=A0=C2=A0=C2=A0 IMAGE_FSTYPES =3D "wic"
>>> +=C2=A0=C2=A0=C2=A0 IMAGER_INSTALL:wic +=3D "systemd-boot"
>>> +=C2=A0=C2=A0=C2=A0 CIP_IMAGE_OPTIONS:append:qemu-amd64 =3D "
>>> recipes-core/images/deploy-ovmf.inc"
>>> +=C2=A0=C2=A0=C2=A0 INITRAMFS_RECIPE ?=3D "cip-core-initramfs"
>>> +=C2=A0=C2=A0=C2=A0 INITRD_IMAGE =3D
>>> "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>>> +=C2=A0=C2=A0=C2=A0 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_=
build"
>>> diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.i=
n
>>> new file mode 100644
>>> index 0000000..c143500
>>> --- /dev/null
>>> +++ b/wic/x86_64-encryption.wks.in
>>> @@ -0,0 +1,18 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +part /boot --source bootimg-efi-isar --sourceparams
>>> "loader=3Dsystemd-boot,initrd=3D${INITRD_IMAGE}" --label efi --part-typ=
e
>>> EF00 --align 1024 --fsuuid 0x4321dcba --uuid
>>> cf142945-6fa1-4945-b0f2-b8d6226298c0
>>> +
>>> +# Not nice use the source param label to supress the root commandline
>>
>> "suppress"
>>
>> Can you elaborate what will happen without this label? Another, wrong
>> "root=3D..." would be appended?
> Yes the default behaviour from bootimg-efi-isar is to add `root=3D<uuid>`
> to the kernel commandline
>=20

Is that a problem of the -isar part in bootimg-efi-isar or also in
upstream? Wouldn't it make sense to add some flexibility here?

Or can't we ignore that specific "root=3D" from the command line in the
initramfs?

>>
>>> +part / --source rootfs --fstype ext4 --sourceparams "label=3DBOOT"
>>> --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid
>>> 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid
>>> f225331b-2d9c-45a2-bcfe-4a6e86287dfb
>>> +# home and var are extra partitions
>>> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4
>>> --label home --align 1024=C2=A0 --size 1G --extra-space=3D100M --fsuuid
>>> 1f55d66a-40d8-11ee-be56-0242ac120002
>>> +part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G
>>> --fsuuid 96be3374-4258-11ee-be56-0242ac120002
>>> +
>>> +# This works as we know how that the luks device will be named
>>> encrypted_<label of the root device>
>>
>> A bit ugly, indeed. Is there no way to let the script set the
>> appropriate root?
> We can work with templates for the rootfs label or set the ROOT variable
> in the initramfs like verity and or abrootfs. The second case would
> require the initramfs to detect a encrypted root.

Yeah, but the effort should be in generic code ideally, not in
individual config files like this one here.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


