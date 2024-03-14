Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F0C5475B
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 09:26:55 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.54])
 by mx.groups.io with SMTP id smtpd.web10.8554.1710408414025450323
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 02:26:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=c8JuCB2t;
 spf=pass (domain: siemens.com, ip: 40.107.104.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+xbwk3v9cHgz5dC/tWUwOQxP28h2qDxXwSqo6SFrat+Fc3oiFKowjLj2GgBmxBSYXGjVT1MW4jo6eWvCJb4svQBmqM5mZGM0ooBzmoDamvJN+++OXmTWJbBUMr170jY0iqDqeVGhMTyDoNIz528gR4j4Ua7mdV+qyWuwl6+j7wI9W5nMiH4FcKs5FzBdtDMXEk7xJh7GVxDBXPnd10GqOwNTJpluBMKYm+GPv5I8n3jTjFQlFciDU8zz+fFpoUUxgEzKZm3eC7WI7IvktlYtBA6QmG8vEu570rAvRUbC+hwu6USSsC+HbyF9MsCPWXfqVBXQCypPvbZ4iMR57FV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXR1IHVLVFVq5Kipzr7m8dW69lu2mtw5iBdL2AV19Xs=;
 b=UE7QqDfHv5DRwFKsQ7nket0v/+HzuerWs7Im6OB5zFciL82sFuHoXuQ3iLu+cI3HzMHZGtFv83IZVXOY82vKWuBzuaXa2tgW8oO50t+LkTWAYmnxYsqZu1PfVrmtXE1Dlu22nbBY1CcjKrM2loYqpZiL1fRr+XTQs7jfsD4mYOw1oBw/I6aJNECRvGhYmBsoqolarceuCeiJdA52lcsp6uceTtlqQ7UzmSVQsNIS+iOVYIepoPqXqupb+Vyra5dkH7OlvJZ0gT1MroxeQxvUWCTZk/zzw1F4wrmTehJ1XQsk22zNvZUn+ac7lasp6Lce/QhSUzIN5DGyFKFnzWtYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXR1IHVLVFVq5Kipzr7m8dW69lu2mtw5iBdL2AV19Xs=;
 b=c8JuCB2tFreMLx0hjI3qlwJ2JhnX8x8MBKhFln1pGOKgfgVdPZoKTj3Ay4rpEGn2fcNvnR/2XvA7AB+Z2CvvtbsiKJTN8T0J0eznLYhXtB8Eupiarc2kSk0zS6NeFTm9qWTKLYj5lt8hlSjSi4Ro9p5xd5/algE2Bdx89llTSi+PXrs+6pCgcODJhZM8Jvx7/9lAOt0r1/NN/wuEGE5TdqDN8mHmerak8ztCA56Hwkh9DTA2JJK05D0c9M3KMt/kbUxXivfhS/JO0ZeQlt/55MSOE0LgLjbzTyqdVPpw+KZZioLRLMxOt94FJheu6NJJowPslkTj7UGIJpw1kploPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 09:26:50 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 09:26:50 +0000
Message-ID: <2f7b1523-39c1-4645-bb60-4f130a20a119@siemens.com>
Date: Thu, 14 Mar 2024 10:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
 swu for delta updates
Content-Language: en-US, de-DE
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, jan.kiszka@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-6-Adithya.Balakumar@toshiba-tsip.com>
 <4fb765ea54765e58a93b6aa0d19f0054a0e680f1.camel@siemens.com>
 <TYCPR01MB96694682086B4F651CE7C8FDC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <d9b9a979-41b3-4348-8171-14727d79d7c7@siemens.com>
 <TYCPR01MB966952366AB5AB0D4D749D31C4292@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB966952366AB5AB0D4D749D31C4292@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 405d4c51-8bea-457d-144c-08dc4408e0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9ojG3G0Fv0Yjf3ACqu3f6fuW3p/tEJaii8brBv6Air8IAXt7GFTvH91QJkL20qDyFZ2XH7jdF0cV+amWhcDb4LUJw4mKkElAEHfLUwYvEbdbP5aMNAk7i31uEt44owJx/Ak+jcP784v3eXoSaOyzyMSlmMYC0am/Kk0ikhtbqRLTfQFpVUsk/I06tfLw7A4dDEgxadvva2ncRdzlZJkO1/cYZh4ZgUSl6P0/LCfQQmu3NgAJyfUmvl4lzYCqyktQLzvpuVmo/pt2Zb86FVxTyvMf5dsgKQ72Y/KrPRvlYGrIoC3gNPijO5wxU1tZYkUWxK15WmifYwxr1NZjEt7610saheAGEEwqN5i34Bm9Fk1xiOOOnSDU+J2uf8ITL9sUhUYpY0XvoMLAAWwUj1SXVHxaxk/ZQvWZS90T4EbVv0ZhAHecatPOtL219jhlUeOsPF+XJ0EAXur9I5DpPD658qnerRAiNG8/OSKRv0YKEMgB5hQ0XAjhuYrkrXKu+BDBsM1CzYvKg+xIySp29pwkcYZSm6dddd3fkfVrCZIV66BpA9DbiMVPvKwSqLM9OaXhDeZuXmRTtSslHYk1hPnM3FLKgVFUU+ABNcTYQVMGOxM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J+9upQ+XggohWFRGgHcovrTAEs27IEgO7J2oB+SiBTn5Ftx4P3VdDN7FVVbd?=
 =?us-ascii?Q?TR8J1qD6/0NW7Q+wD/h7nQlOW23+pH2Tsn/pH9HCLsHjVabxcZnARhK/YSN0?=
 =?us-ascii?Q?qGrzJg0l/Y8uhuhSGF3bCIvo/OlVCK0umtiFsCC9wNXKPvjTY1Sd8G4nBVE5?=
 =?us-ascii?Q?1xcYvVHXnx90ScajlESEb+0pba1Eh7iGisn7PqOQD4JLVB2HhRbbQfQie2SL?=
 =?us-ascii?Q?o/jgS5zM1osQotqSiU1SXYQnNkP7S6n7B3VLqdfRuziVBIro6fqK1lWjzR7I?=
 =?us-ascii?Q?WlNHtSJizhGH9a/uj3tMwtdEubNeVUwaNzO80goE/fMMV3ORVSlHuklb0Ghw?=
 =?us-ascii?Q?oYEtme/kHSH7XXT2/6hBmNByCKjpMSKVLs71UONexP1Lnaw+J0Zal2jLT4bu?=
 =?us-ascii?Q?A5/Zg7y5l0vrK2Ql+eqtmLTMSTe9rz4atgbufZa53mt8XeDbx3nIS/HYXcEk?=
 =?us-ascii?Q?LB4XgPGGb9jPiF4JSIg+nzmGqIAwFYqhUBJifkkBjQOi6RkiHfdDVXhvEJgP?=
 =?us-ascii?Q?nMzSTSzsdyT326dFk6hpPg7Oli7LH7Tnu3WTieP5zc++fYN49/oalUpaRzFb?=
 =?us-ascii?Q?+ZpPSnyG6rSNpLhh68xBeedRVtHW0PDylPLWUgU7hNmnq0vSVwm8O1QWJXK3?=
 =?us-ascii?Q?QFpCl/Qh0O/jM4avdC2n5HagSGJqHsQ8zw+ttbxzxfUR8gKFERapSLwrKa9s?=
 =?us-ascii?Q?cD6S4q7sNh2EZczomc/zWrzwD6qBSUX4jujPur2vQJRwUz0KRGUzHya5V8VZ?=
 =?us-ascii?Q?9Mwp8ks4pycQfLHOZr4DaVJvAgXOmn2YsfjAH/whhgXOTKkkgZ0CyD/GeM9/?=
 =?us-ascii?Q?EhFMB0mK8GDsuxvak1QXxBDPzJRpj6MF0WO9+jLnHS9II+Rz9EZVm6nVqnEe?=
 =?us-ascii?Q?jhsGsetZR1EcRRBzt8ev2JSM6vVZvr5hu2DASKI42Qr6zQA4PMCNwzIciIYj?=
 =?us-ascii?Q?5f0ygSlapx9u4ECiDuTAgPbXpqd0fuaLomCXggdW9UZqOfr+AIFji1M+i8Qi?=
 =?us-ascii?Q?BiO+NijEoK2ueklec7VXdNDZg+NHCuWWqlkbtkdErG5OqMxwCI8Y1buxtjjL?=
 =?us-ascii?Q?rvSMobImbh3+HGaK+SojynKgi09a59D5o8xuLfb9c98T+SXBBNlXXqkUvNFA?=
 =?us-ascii?Q?Pbx4c+97n4UlZ2rFlFm6A6LLIDnUE7xZUH3mecNKcXE03UnoRlEcEysVBKIh?=
 =?us-ascii?Q?HOosEQAeRiE3rWrz/rz23jgeHxru+Br6UkDYAWC/XAPtl0Vm6QWh+5EnL9l9?=
 =?us-ascii?Q?I7LhRYvZut0TNw8VCyJskrcDqNrLhzOTUbT13VQm7UNmJFUFICNB227CO37a?=
 =?us-ascii?Q?GDgSfkP4jLEdqG2VEGWPjIpylh/ZvCOKdQjuIR1a+nYVllrJPQeARX0FTp0I?=
 =?us-ascii?Q?D1EJg0Qbv68PTCO0gI0OGZFnfMghydUZ95bJj4eVKXXrkEjLguEkrfMrLwEk?=
 =?us-ascii?Q?gxtZ5gVmh27SrvyAt782Da+V4W3YaKiL8ZKr7Zgx9OGM+0DbRTTOa4CiEmKy?=
 =?us-ascii?Q?KGadGSCdlpC5S8UVsG5tDX+FIq8WAU+97rtwNIIVm4xHxd7PegGFAZQyHtgf?=
 =?us-ascii?Q?yzgWJtZYPaaLN9QfVGfLt8Xb6Cq+lXW8UJI4GOOOmi0760N/bPPo5gR06W7L?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405d4c51-8bea-457d-144c-08dc4408e0ef
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:26:50.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtVdOm0TKa94dks4oc/giNNqRh6C/xFJ5Q6GdzoahLhXFJrD5oK2QB2B+vh7B7f4DmRDlOtJHSxDbMxkcPqlFRCEaGRI0Hzty+inWnjYhzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 09:26:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15302



On 3/14/24 8:41 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Quirin Gylstorff via lists.cip-project.org
> Sent: Wednesday, March 13, 2024 10:46 PM
> To: cip-dev@lists.cip-project.org; felix.moessbauer@siemens.com; jan.kisz=
ka@siemens.com
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Gene=
rate swu for delta updates
>=20
>=20
>=20
> On 3/13/24 8:03 AM, Adithya Balakumar via lists.cip-project.org wrote:
>> -----Original Message-----
>> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
>> Sent: Friday, March 8, 2024 4:27 PM
>> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR)
>> <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan
>> <jan.kiszka@siemens.com>
>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG P=
orting)
>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG Porting)
>> <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=
=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=
=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
>> swu for delta updates
>>
>> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>>> This allows the creation of a swu file for delta update. The swu file
>>> for delta update is only created when delta-update.yml file is
>>> included at build time.
>>>
>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> ---
>>>   =C2=A0classes/swupdate.bbclass | 35 +++++++++++++++++++++++++++++++++=
--
>>>   =C2=A01 file changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>> index
>>> 2c69892..2964024 100644
>>> --- a/classes/swupdate.bbclass
>>> +++ b/classes/swupdate.bbclass
>>> @@ -26,10 +26,13 @@ SWU_EBG_UPDATE ?=3D ""
>>>   =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>>   =C2=A0SWU_BOOTLOADER ??=3D "ebg"
>>>   =C2=A0SWU_DESCRIPITION_FILE_BOOTLOADER ??=3D "${SWU_DESCRIPTION_FILE}=
-
>>> ${SWU_BOOTLOADER}"
>>> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??=3D
>>
>> Hi, do we really need a dedicated file / variable for that?
>>
>> [Adithya Balakumar]
>> Hi Felix,
>>
>> The sw-description file for a delta update is slightly different in
>> terms of the image artifact inlcuded in the swu file and some additional=
 delta update specific properties included in the sw-description file. Henc=
e I chose to create a seperate sw-description file for delta update.
>>
>> Would like to understand if there is a better approach.
>=20
> A seperate sw-description file is not ideal, we should take the same abro=
ach as with scripts and other optional or malible fields by writing the con=
tent to variable and use the template mechanism of ISAR. The sw-description=
 can look like this:
>=20
> ```
>        images: ({
> -            filename =3D "${SWU_ROOTFS_PARTITION_NAME}";
> +            filename =3D "${SWU_IMAGE_ARTIFACT}";
>                device =3D
> "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS=
_PART_UUID_B}";
>                type =3D "roundrobin";
>                ${SWU_COMPRESSION_NODE}
> -            properties: {
> -                        subtype =3D "image";
> -                        configfilecheck =3D
> "/etc/os-release@not_match@IMAGE_UUID=3D${TARGET_IMAGE_UUID}";
> -            };
> +            ${SWU_IMAGE_PROPERTIES}
>                sha256 =3D "${SWU_ROOTFS_PARTITION_NAME}-sha256";
>        });
> ```
>=20
> an alternative would be generate the whole swu with the Variable[flag] sy=
ntax, e.g.
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/feat/generat=
e-sw-description/classes/sw-description-generator.bbclass?ref_type=3Dheads
>=20
> Quirin
>=20
> [Adithya Balakumar]
> Hi Quirin,
>=20
> Thanks for the quick response. I understand the approach you are suggesti=
ng. But in a case where I have to create a swu file for both regular and a =
delta update, I would need two different sw-description files right. Each w=
ith different filename in the images section and some additional properties=
 for delta update in the properties section.

What would be the use case to have both a regular and a delta update?

If you have multiple swus the server has the additional responsibility=20
to select the correct swu.

In the first version of the delta update I would use the either delta=20
update or full update.

Quirin

>=20
> As per my understanding of the template mechanism of ISAR, the do_transfo=
rm_template task generates an output file for every .tmpl file provided in =
the IMAGE_TEMPLATE_FILES variable.
>=20
> Please correct me if my understanding is wrong.
>=20
> Regards,
> Adithya
>=20
>=20
>>
>>> "${SWU_DESCRIPTION_FILE}-delta"
>>> +SWU_DELTA_UPDATE_ARTIFACT =3D
>>> "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
>>> +SWU_DELTA_UPDATE_ARTIFACT_TYPE =3D
>>> "delta_update${@get_swu_compression_type(d)}"
>>>   =20
>>>   =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>>   =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>>> -SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>>> +SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}
>>> ${SWU_DELTA_UPDATE_ARTIFACT}"
>>
>> Does this mean the delta artifact is always added here?
>> [Adithya Balakumar]  Apologies, I should have appended ${SWU_DELTA_UPDAT=
E_ARTIFACT} conditionally if delta update is enabled.
>>
>>>   =C2=A0SWU_SIGNED ??=3D ""
>>>   =C2=A0SWU_SIGNATURE_EXT ?=3D "sig"
>>>   =C2=A0SWU_SIGNATURE_TYPE ?=3D "cms"
>>> @@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?=3D "cms"
>>>   =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
>>> "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>   =20
>>>   =C2=A0IMAGE_TYPEDEP:swu =3D
>>> "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>> +IMAGE_TYPEDEP:swu +=3D "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if
>>> d.getVar('DELTA_UPDATE_TYPE') else ''}"
>>>   =C2=A0IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-certificates-key' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>   =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl swupdate-certificates=
-key'
>>> if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>   =C2=A0IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> @@ -46,6 +50,7 @@ IMAGE_SRC_URI:swu =3D
>>> "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>>   =C2=A0IMAGE_SRC_URI:swu +=3D
>>> "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>>   =C2=A0IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
>>>   =C2=A0IMAGE_TEMPLATE_FILES:swu +=3D
>>> "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>> +IMAGE_TEMPLATE_FILES:delta_update +=3D
>>> "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>>   =C2=A0IMAGE_TEMPLATE_VARS:swu =3D " \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 SWU_ROOTFS_PARTITION_NAME \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 TARGET_IMAGE_UUID \
>>> @@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ARTIFACT \
>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES \
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 "
>>>   =20
>>>   =C2=A0# TARGET_IMAGE_UUID needs to be generated before completing the
>>> template @@ -136,6 +143,22 @@ python add_scripts(){
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_=
node)
>>>   =C2=A0}
>>>   =20
>>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_swu_delta_update_properties"
>>> +python add_swu_delta_update_properties() {
>>> +=C2=A0=C2=A0=C2=A0 delta_type =3D d.getVar('DELTA_UPDATE_TYPE')
>>> +=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =3D ""
>>> +=C2=A0=C2=A0=C2=A0 if delta_type =3D=3D "rdiff":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties=
 =3D=C2=A0 'chainhandler =3D
>>> "rdiff_image";'
>>> +=C2=A0=C2=A0=C2=A0 elif delta_type =3D=3D "zchunk":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zck_url =3D d.getVar('DELTA=
_ZCK_URL')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties=
 =3D f"""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain=
handler =3D "delta";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =
=3D "{zck_url}";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zcklo=
glevel =3D "error";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0 d.setVar('SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES',
>>> swu_delta_update_properties)
>>> +}
>>> +
>>>   =C2=A0# convert between swupdate compressor name and imagetype extens=
ion
>>>   =C2=A0def get_swu_compression_type(d):
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYPE') =
@@ -154,13 +177,21 @@
>>> FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-
>>> core}/recipes-core/images/swu"
>>>   =20
>>>   =C2=A0do_image_swu[depends] +=3D "${PN}:do_transform_template"
>>>   =C2=A0do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
>>> -do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>> ${SWU_BOOTLOADER}"
>>> +do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>> ${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
>>>   =C2=A0IMAGE_CMD:swu() {
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}=
'*.swu
>>> +=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_UPDATE_TYPE}" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${WORKDIR}/swu-delta
>>
>> Why is this required if we already clear the ${WORKDIR}/swu-delta in cle=
andirs?
>>
>> Felix
>>
>> [Adithya Balakumar] Apologies. I should add swu-delta to do_image_swu[cl=
eandirs] only if a delta update is enabled.
>> But even with the above change, in a case where we build with delta upda=
te enabled and without cleaning the build directory if we build again witho=
ut enabling delta update, the swu-delta directory is retained in the WORKDI=
R.
>>
>> Thanks and Regards,
>> Adithya
>>
>>>
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
>>> '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_=
BOOTLOADER}' ];
>>> then
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU=
_DESCRIPITION_FILE_BOOTLOADER}'
>>> '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_U=
PDATE}' ];
>>> then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRI=
PITION_FILE_DELTA_UPDATE}'
>>> '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>>   =20
>>>   =C2=A0=C2=A0=C2=A0=C2=A0 for swu_file in "${WORKDIR}"/swu*; do
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(ba=
sename $swu_file)
>>
>> --
>>> Siemens AG, Technology
>>> Linux Expert Center
>>
>>
>>
>>
>>
>>

