Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5862EDE981
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 05:44:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web11.5483.1694670274457280666
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 22:44:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=v+yFzMeW;
 spf=pass (domain: siemens.com, ip: 40.107.22.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV256pPfO/TFPzBs8NKhbvhK9Ys9pEUoOmrX/qoJbqhrLysup/SUb4wrRAo/RNKih4gYGFXjtaztBtojQFCCbFS7FSdieM40mxiwnd+v+hBbpwDL344xkYxSg5iDxRgfMh3QVStUolwjhzqkZzHLZ5Cld2cYUqA6tPHAMOPMwv5IVJlKpXHv2Brk6YZno2jAYQMFdkoJen2bAInheN9+rWmQ4VB0/YodFx7lS8j9Zh0jnmIeVBYnbgvWYcV/ug1ZbWuoQor6hL93GNroEhcM8Ak+irAVNX3rZbjdTGJQJfVpDOCV/fI4I4CkYciMwc+Ed3L2OjBEWzGQ3axVG/Qtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mgzvIP9W5nHlWGNlRdGxuXS6n7+e8ccFrtHSPlvrrg=;
 b=kjiMe+pjm3rdmzkDlSeyCkCDHSQkejp4gq0ONHwmZ/Y+gng0BNKVnOLd91aav1H1ThZYWafE9JZ2UKHMOqBjgaZ1IArkRtYtu+LghIf8SYlc23v6Fz2y7B4C2gj/SVdOG5OV79b+dlric4xHyza1hZiVB+xDneFcoAjygjswVV9WtyxOIDLNW6WZxX2z/22oGy/rzwVImdE80PSyuuLLfurarycTlSmJjZsv8jNKYqEJHpskM2Qy09npRDcHwV4/6wwPO92dkBv9prywov8ho2dLgSyGUKBtBmv6+/08VmEwYl5e0rlKh7XGguADi6ECnmunZsyJHVkfM9XIbK5KOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mgzvIP9W5nHlWGNlRdGxuXS6n7+e8ccFrtHSPlvrrg=;
 b=v+yFzMeWW7MoGSLK3OY4YSnGJlmgqDmUasoWwpQpeiNxabQJONd3vHSKbTl0CIIPFY9Wsuh8ktN/aAgkye5GrsBoEvV3uXH0hDk5Zt1Fgy7MAPSnN0RwqEg4u+BnwPIXuvL2W/+7FS1jkKffQR67str4CuJHRC9SYQXC70jZjoFUdbj3L8lAT464yTgMS/zvKAuAUYGWib+KClwV9x0poSUlU6mNFyxAYt/JJap9hnUI5NUkH0YT5SI4o+QJ+2mB+6aSsUkyw6pnTzOeOIM9Crlpv1VlmvkWZ5D0YMcpdd0CEha0zETlfPAdUKEGcACi62hcfKHZUP0/Lm2fClZJQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 05:44:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 05:44:30 +0000
Message-ID: <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
Date: Thu, 14 Sep 2023 11:14:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp
CC: cip-dev@lists.cip-project.org, iwamatsu@nigauri.org, minmin@plathome.co.jp
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: dff8ca8c-e975-41f5-8446-08dbb4e5aaa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+l34ZgxwoZkMOqqGBATBFrYkdajKyibDE4g9dt54Mlax7UyUWvQ9E6oO5mcm3DeSYlDFiyFHCKDQJQfLqwTCDlj4iYqDA/cO6z+MvFbL4sKUPwKg6l685zegnJF9lh8s4egeCCRNgKn/iabuo3FEgDjiDvStuKAZd9VfmGGvDCrt/q/uNmCCsdRHd+SnR+ddadDW2i6vqjUKn4FSXyCkPAiymK39J9PqbVV6F1y2SJ03XymInee+bIzP5A5xap/wcjpAz6jJ2+cpQmFztgabcTWaXKqg2zHXll0ddP3QhbIYh8TqUuQAvAw+urXJgfxuAT7fo24Au59NoS7SAY2nrpaaoiI4L5n3ogLunDEToSKn8lzv+Pp6t68vwTIHvk+rsXZ1gwt5zgSRBoHDri092Jxb2pGYfmC7ANZ5p5RfDKM7VKEQCXUOv8qpDOnFn03JxYer166Ia/P3C0Lp7D60PgGdE2Qab8Y+92fJ/+qLfzOorc1VTwHitfqtzOU7aVZfbTu9V9e2/xt2xKVNgzvCVkuStkPT07lmtwXTBQaF4yjBtuOeeCZFN5OH5MRCc08zWSpavCoU0NjveDJ32POVfzD1wNPlw2IR1oghKqDZkBISj/v/Dk9e8cKzIh5abcHpavbROesypHgsD0pmsBUyqxolGBUU1o8HXrJP/a4TOg4qGKTPfwTqzybNEAkZODr8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(316002)(5660300002)(2906002)(6916009)(66476007)(66946007)(66556008)(38100700002)(478600001)(83380400001)(26005)(4326008)(8936002)(6506007)(53546011)(82960400001)(44832011)(41300700001)(6512007)(6486002)(2616005)(8676002)(86362001)(6666004)(31696002)(36756003)(31686004)(151773002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xv7810QOhctR1xSs4f/ybYKr42qhqB666lGMoNDdgatT36lUgHKociwCpc/F?=
 =?us-ascii?Q?ox85T+EgchggW+54H6iFg/JeutVvpqngvEIY2Bv+AqspuKZOPn2XcaaAGz04?=
 =?us-ascii?Q?Ph9q7JFl/3fH1AFB05l2fdJ03KRPvIkcY7CWlAOghVVDYeNDCtFH+hhgTdCt?=
 =?us-ascii?Q?ycRH4spAliUAAKcZLpzn7GcOv8wR1q5eapxJCh64X//RJAQsLHsVUaSwWfUq?=
 =?us-ascii?Q?oebak5RonhUTU5r5q1Ra9uURL6YTxtqu///KOiX16N1HKvaoD4mD0XzyESw4?=
 =?us-ascii?Q?0SdXRvwAwFjryk2wL+AgDKDkjmWLf/LAjtEqgawOpKPiYVwCSUY8nOqSz5Ym?=
 =?us-ascii?Q?oXYTE/JBbVtOAxQfMQk+u2pTTF7b4+2jAKA6BqpENZJ97aHooaAUsgiqcgaD?=
 =?us-ascii?Q?HZUVADCTyeeIh7Jy4zR5nqMIPqcVbkSMNChLzxKn+pZHg+Qdc+KGpjZ7g2L+?=
 =?us-ascii?Q?1WjHDwiJ+4WwBQjwPCCwcgYTTq0nnne2lgC1UXwo097YXvsOrRiSCW7HPe9L?=
 =?us-ascii?Q?tX1bq8g+B/rIR2pj+rS8NfmlWS75al4XP0P/lXpQQPKnzVfXKEbfe0EtqGxC?=
 =?us-ascii?Q?ARp5ttXWoFzT0roBes7W82/iAAOgnurzCWG2nV+EJ+Nk9yYX196czX7lpw/J?=
 =?us-ascii?Q?FtxsO4XR/UPozOtOe0Dmomxk0axv3vBZl079wDW1H1o6J8tw7cFG52wKLRD8?=
 =?us-ascii?Q?dQkCJMQm5wWEZKuHaPzYhKQRxq0CzU885pp5Y6HZ50qVC6zaq3auan19JzME?=
 =?us-ascii?Q?XjvV1PwNX7yjYSmJ3ECQOZ0ku7YuytItfXyqbdD/lBSIEFKeL3GgaWMUoV2/?=
 =?us-ascii?Q?3q/rPbIopRwqnQ3KvPfMZFd6qvAsFkvTdsDkArkqcsc9jsjgQVF6k60fZLgw?=
 =?us-ascii?Q?ZnrvM8wAecgMckBlUtD+t7mvwDjnT0zxpXqaj6DOt5XWVb4oUwkpOmMAmarx?=
 =?us-ascii?Q?pJ2kjnRhHJ+taxan3TRBFzUIjwQSj98fCrAplw7ZI9fCuCSWCdtuZ5YUezJb?=
 =?us-ascii?Q?Q2F6BeIfIvGIHSyW9knURoEfwOJrLydPBT+8p+Xs8KiVtpgH2uq0kRpKgW4t?=
 =?us-ascii?Q?4T2ODOJtzJOSaH447gQaYCzp2skxt9JADyVDruat2JXicMF6ZKTfGnAA5i9A?=
 =?us-ascii?Q?C5Hcmgu5+g0ITVdCvg7mfuSQifZHY2tPwLyhABlGBZBT5Ucz8r6v8rpZCDyD?=
 =?us-ascii?Q?daP89ggAGY9ULu+FZniO35jA0Ka3O/SSbzfdSDjmvkvS6vR1HeIlbXBDB3fE?=
 =?us-ascii?Q?EC5LyDN7+p6fI7iVqiFtaGw2NMAqdH6xN+d4HRLvUU7TLUMjruFjMYWxrC8T?=
 =?us-ascii?Q?7X58biU32kGxk3QHL6J2hQKGK1iVbxd9PROQiLrLak0Pirab0xN5waTrwp4/?=
 =?us-ascii?Q?ZlQuakAKR4diBKlBRgVI5n/DDS4zHQqkwGur67J9/tgcKZqL2iKpc6W72kr0?=
 =?us-ascii?Q?0msUBKJAXQf5Xkcyy4AkfRcAyyVV4ra9XPeuafqSpjYN2aaArL9TlOhmvJS6?=
 =?us-ascii?Q?x41xu3e+bBi1ZBNXfR6Y5sE9odUjYBxVhhDQ1/Ho4JcvVKss1sNom+x1Z6QU?=
 =?us-ascii?Q?8ecWDqjAk20zdIzzvGfGEC0hpgIVP6JjtfxWhH4h1O3ApmKV0NM2gJuEpWSt?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff8ca8c-e975-41f5-8446-08dbb4e5aaa4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:44:30.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioSsu+xod0qWeq57unaWLOGRuODFW3yUUPwoMBfzl87wGEOf7N4EZj/pCYaJdUimP+H4kuY7v1Z9tzC569itXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 05:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13126

On 12.09.23 18:41, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>> -----Original Message-----
>> From: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=97=8B=
=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=E2=
=97=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4)
>> Sent: Monday, August 28, 2023 5:27 PM
>> To: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>> <iwamatsu@nigauri.org>; Masato Minda <minmin@plathome.co.jp>
>> Subject: RE: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT
>> VX2
>>
>> Hi Jan,
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Monday, August 28, 2023 3:44 PM
>>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=97=8B=
=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=E2=
=97=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4)
>>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>>> <iwamatsu@nigauri.org>; Masato Minda <minmin@plathome.co.jp>
>>> Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks
>>> IoT
>>> VX2
>>>
>>>> diff --git a/wic/openblocks-iot-vx2.wks b/wic/openblocks-iot-vx2.wks
>>>> new file mode 100644 index 0000000..3050684
>>>> --- /dev/null
>>>> +++ b/wic/openblocks-iot-vx2.wks
>>>> @@ -0,0 +1,15 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2019
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +# Based wic/simatic-ipc227e.wks
>>>> +#
>>>> +
>>>> +part /boot --source bootimg-efi-isar --sourceparams "loader=3Dgrub-ef=
i"
>>>> +--label efi --part-type EF00 --align 1024
>>>> +
>>>> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default"
>>>> +--label platform --align 1024 --use-uuid
>>>> +
>>>> +bootloader --ptable gpt --timeout 2 --append "console=3DttyS0,115200"
>>>
>>> I wonder if we should (and could) consolidate the x86 configs. Or does
>>> this target come with any specialties?
>>
>> I think it can be integrated if the serial port and baud rate are the sa=
me.
>> (There may be other settings as well.)
>> And the partition scheme is a reference, so I think the same settings ar=
e fine.
>> This time ipc227e and vx2 happened to have the same settings, so they en=
ded
>> up in the same config file.
>>
>=20
> Ping=EF=BC=9F
>=20

Sounded to me like you wanted to send v2, given that you confirmed we
can consolidate things. Or did I misunderstand this?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


