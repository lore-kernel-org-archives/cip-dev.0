Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB887D116E2
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 14:36:07 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19634.1764254158395864380
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 06:35:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BVqiIpD6;
 spf=pass (domain: siemens.com, ip: 40.107.130.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei2ptwflNJyubTitY5n+R/TgnnTlwFDyBlo4bXgxyUoQBnNFkqFDWSCRqupeQtvoBIV5UiPUKtJSGnAXbKVnuSIp2IN9fJb5EXc6AJbuJShs6KW/lfsJf+octKMtppWdPcDB4sDzgHQ9qOeE3r2ZVVY3Vb0s4edCVev0LRGLO8GqTuMX/dRMx0O4pYU/+uTG6yHBnEn8IDT0jSflhTRZngMLgA5J4opzAaVFHYNy7hDhYhnkcX4452aQrt20TPqvJQhXg+JS7eIaPg18Jtf/3obMhqgaH7A9gv1wGRGSmgu7lzFMOovflcMEq4+uNi/vTBlladifz7oevVmT/PCUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smT+ifWE+spfucnV9EIvawVLeo5iTQbP6zxI39svxHo=;
 b=LkXEfA3fBnM9w6I9PH6Odq+Frat7HpPfvY7j/8FWmsLEB7fgnukiUqk2I2NsOwEg2S02h2dsGBiNIlpksguTKtULNqHx5SgNlp6ukoD6efF6vwPTKTpBtvGFrIenv8olGgI6Jh3Avs+ExwHP1TWsyIKLkqSgICW3XQsw9lKRvVRqQn6olZVu75+cUjmNSq7rYF3bJ60D+lCPQWKovvwUH8LEqK/bAoocR50SJ4KvInJY3ZvXUy6yrO5QUmYNoA8zeiAyk2sigTAjmmmUJXjeUORB6Tnu8pXElqjBX24lR4h64WRSvdF1Efh/qHiCp6NVWV4moqvt7g1c+Q59S/9R1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smT+ifWE+spfucnV9EIvawVLeo5iTQbP6zxI39svxHo=;
 b=BVqiIpD6oKUTDqsssNPngTAwBSJottCwjmMwPSrhavkaqTImyVvVk1YQTmULX1ZiTvjsYfYRbp6SRpw51JISPjcvuyhVAQra3tnPBJV77hL6CrxBtM34GUP3QepAdnWu7N7/RaDj4+vlNCUJBLiGfFwheLCln9681Iilg5vfrgE4jUcXTnzw6Zgr/FfqgeuTGGEXTnO5hYMJIhImdM70ZgvBpwYevY2jlik86QEz/utrbtOPtrcpecdkyYlP9E2YzK0p6hRRE36LgrksoS7PxCKHXEKfulquNcd7yH8f1Mhm9YiTObny5llUcPvdoI5PEC/BSZUcuQztocm1yWLLGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by MRWPR10MB9627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 14:35:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 14:35:54 +0000
Message-ID: <b12ef53f-532a-4fdc-b0f4-1484e13ec22c@siemens.com>
Date: Thu, 27 Nov 2025 15:35:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
 <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
 <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
 <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
 <d1f88d49-e317-4782-9ac9-fce1bf21bd7b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d1f88d49-e317-4782-9ac9-fce1bf21bd7b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|MRWPR10MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 9600c3f9-fc67-40ac-d22d-08de2dc24585
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NyLLThKcxdWN/GXw4/s1J03hBIDk9yjp88YWqH7ySIEvYcY1HAqDuAm1Zk7M?=
 =?us-ascii?Q?7zUyFjY2akL9HkNZdmLfoaX+82qx0liuaagg1vuDNl1mSYYQ3Tlz6tvUurTp?=
 =?us-ascii?Q?DfD8gZ5Ju+Kmwi3jNOxBDuWAS7hP9dQQAsNCvCkFdF1y/LP0mgsiQoW+rzuq?=
 =?us-ascii?Q?+4erZydiu8JmmaiYdZ2eU1QKRvoOdmXOGUQitao+aQ1jAv4VeYpJli41IgCw?=
 =?us-ascii?Q?OjFewD6Dg+g5pibFlWPtA5iPvPn3KvUJsmsSPvxFgCXt4KxzXOv+RSv9HUwQ?=
 =?us-ascii?Q?7XCiTw+XGRbqLlqDnlEsZTBmHMex3CT10t+pYgOcFn9zePxWv+YH4yo0+Ndp?=
 =?us-ascii?Q?zxkW5jwDLUGvZLjnezKy0tQe1wABezNSzt0yAN2SoV1BZGIb7RahybHpWfbC?=
 =?us-ascii?Q?cRpo7qAN9JNgR9o0ws9unj0eJdzN8PWS0v66UDs1VqqniceJ+8kfBgnFI4i+?=
 =?us-ascii?Q?P2CRSTAPZ3JRBzwp2X/182jpSwPyES+AWKEuMmWyV3ncSe9g5UH44w7wJasC?=
 =?us-ascii?Q?jX1zjxk7ChzJkCyW+rAZDMjO0ENRh3eFxN3Ju9LtekC7uN1tYiPek2OFt3AE?=
 =?us-ascii?Q?JD06Qne+IHx4/fhNkUwYavEudXWxwUbEZVe9kwcNXsy71+SGqlUoRu6jxPo7?=
 =?us-ascii?Q?cL7AR2nk1oMTfJT2Jxzm9n+hPhfGwbtBA69i5d6CFbY60MNiYuy6LobqYJqr?=
 =?us-ascii?Q?kKwMjaNF7bOzk2ZWNg/PWzkW8s/rNdjwxa6tp9tgGEFSoMANDkq1SyG7IaQW?=
 =?us-ascii?Q?CcHuTkurJi+6+ei/96EJtFRAxsuDtAdUUSM7bJ/k4N2HyffyRivNmPu8OUDD?=
 =?us-ascii?Q?QS8RzZdYW3UqXGCt4z9NieoD+YeSB+j4OV0aRzDHNTou+Ng4ScMCwv5lwFfa?=
 =?us-ascii?Q?rtlS/Ftu1wOvaNnIKcmOjp6G0acvrzD+PZGV9Ndwl2FJmwpHOwmPJnWKQAHa?=
 =?us-ascii?Q?CMrRMhp0XWY8PDXVdHERA/NxwhTdSKC+vVQqalrn4RCbAEZUCOKNCfES7usf?=
 =?us-ascii?Q?SleKLB5vYN1ImaKJpK5KjxFhccw7oO4i+fkPAGmImfmHCTCuvZUNC+R1RKx2?=
 =?us-ascii?Q?cZbySc8SO2gpXUbVtB/pa5431Fw1DY1tyCBwXP3wc5FgzU6ntQAxmlY36O4O?=
 =?us-ascii?Q?iEDiCdknyB2YvvFAPVR8KYoapAAnbDFJNrPis/bQEpxaWe0/ZgTUG6mofUAx?=
 =?us-ascii?Q?99EEiszIiusA705NklwS0sAtKf6rZrw5oCiuFCG0oOqC6+qu159rQo4UyRpv?=
 =?us-ascii?Q?OXwNkXsbutwtiZMdu3X36FjXQv2hWvTV3X1PGu903gnkGrgixyBSj3JZzB3z?=
 =?us-ascii?Q?Nr2TnaenVQnI5t5M15h2MvCFz1xg+F1nHr1jInYgoTuGu22Moxh7wracYTtQ?=
 =?us-ascii?Q?msUqfbVNXKOnq5BoMbVl+d7WzqLG7zL5e36K0/tBojQCgf5jkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+4o5e4CJzrKK9zGBqggg4l//Bl/k6l59XJxUySe0Dj3NYhl/BOXxL2GRH/lz?=
 =?us-ascii?Q?tBRqYloGh1d+IRMoPDl/EAbeSWbicZbZIUg9phYB6Tv1AdZHlQ1etwFyxnuQ?=
 =?us-ascii?Q?F/76F7uOL/ooMy0QPn4if1WDhRaHSP8pYfBNPcSM/iIocwQaCqoPJa42aiji?=
 =?us-ascii?Q?9os9Sd8c6n4d07u2HRFf/HOGrEjWRm/AmqNBqH9FZN8nn0rkc1V5xG68UYdv?=
 =?us-ascii?Q?mNQu2+REVVombrZjATVegreC3X9CdGLGPnJM1+AzU1PyK4XP+4yhPFbj2kjY?=
 =?us-ascii?Q?Auf2D1zp0X+3qSU0D8EDz4HczIdLncr2/hSRupDEM9CSMpuAvcDTxku9ono1?=
 =?us-ascii?Q?Tb/cVFcWbnqrzXW2r4DSsC7aYughNT2bp6vuep7ZlJwMdvSfsPXAc5u4TJXe?=
 =?us-ascii?Q?sudDxXLMZ2DxOmdDXhFTsJh1eBxU6+WNemuwB670pOoG2r0eIPtu17SqqnbN?=
 =?us-ascii?Q?X0A0lw2wcvqqFlkRigatDvacek8S/eZcf8WyAMP4KJqxWVd/M6e77eb53Y6t?=
 =?us-ascii?Q?wa386Xj0k739erxrNXJx27AkIvTVXqlbZCWELg8OelIbomruxaF8lLDR+GRB?=
 =?us-ascii?Q?tXJONtj3DiW5FeeeVesdV3ivjRaPR4WJ4Z0THbg7JZv+vrkcTNC1GY/QKr39?=
 =?us-ascii?Q?wkA3/hRE/DNSS5WKvwikPVRy55OlX4ST64oicNAnZXtkr6kIKDUc7OTAbQ6g?=
 =?us-ascii?Q?vIEJain+/fXl7KvXm6yczcRs185OkWnd/xElLGOpD7+4G+NfZnQczX48R4E4?=
 =?us-ascii?Q?MgpCbnGZmiYGQj7D7gALDs9ceDQy+JUi3TwZC1tgZQ1L4yitQBtLeP4koVey?=
 =?us-ascii?Q?fK2sYDe2QJCDJz0Np6Wq844SAHI5eJqxXMw5GvwhhOrspnr+qd4S/Pvf+t7z?=
 =?us-ascii?Q?JF0s429SoOArMblZCeXYpfvjGjqed1YRgy4+pabenLU59gYDHXmv17CV0Osf?=
 =?us-ascii?Q?PQ1yQJd4CLr94b5sagQhQVqI82yLFEWfDStEiFLe1lrTJdjmiFItzBOiqeEo?=
 =?us-ascii?Q?aVztpZ0TrYdQpsT6bBCBUQP5xhf2Bb4von4fmo5tyCnkzAgP/TBJOZkYa8x1?=
 =?us-ascii?Q?C9Ufk/v/LJE/B75XPf66GU/u0HcK+OFu2ux4SWFOH1r38DOnsSP9SPe0ZXQn?=
 =?us-ascii?Q?cDzCeHAr2vqYiUF5w+sbV3tLruoPYJx3v/rFKixK2+RkkqJll/60tgf4t565?=
 =?us-ascii?Q?QqcXTwgxjbd0JkgbhS/KG+24FesVQX6hySxaK5ajrKBLYxa631vnrF4wVfwM?=
 =?us-ascii?Q?POC46iRPQdrfKjB1rfwjQbPbj41A8IChTXo+7Mk/Gj6ks6N3WqNNFC8Wn+JU?=
 =?us-ascii?Q?F2os3M7WVzLqfgGq9P+qQAqt/aYQfSeElNLRm+RcJf8Lfs80xBt/IN4KJU4E?=
 =?us-ascii?Q?VcdvMgQViaicZIy4q6FVBlLDPm2AYjQ6DwubL8KY+XX978wAMGzm5wzpuRdy?=
 =?us-ascii?Q?IalCLuyh42WfkrPlPfBsMXuCn3xlBPHgvG/0NAbhp681ftBZ2u6JkO2+AKEO?=
 =?us-ascii?Q?Z7COC3s4qesJa9JoqkJjQ5BoO/FPc3q83zvmVecm/JBgIhIxVZf4Ldh44f7E?=
 =?us-ascii?Q?uJ7HgtFcRFz2O2C8cExVXQ+bSVA+kdhPc3hyL/DuXWxNg8vTJxTXXg8684Wz?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9600c3f9-fc67-40ac-d22d-08de2dc24585
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:35:54.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX+oHSwJkr3ghksxBNEIEV3OaLkvvxJLZOddz3jkoNV8Ux5EwUpcBrGW9agwrJDxikbLKZcVdSDXlbcik8itWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 14:36:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20759

On 27.11.25 14:37, Jan Kiszka wrote:
> On 26.11.25 11:25, Sai Sree Kartheek Adivi wrote:
>>
>>
>> On 11/24/25 16:35, Jan Kiszka wrote:
>>> On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>>>>
>>>>
>>>> On 11/24/25 15:27, Jan Kiszka wrote:
>>>>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>>>>
>>>>>>
>>>>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> Allows to use the same kernel for all arm64 targets.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>>>>> =C2=A0=C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>>>>> =C2=A0=C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>>>>>> rzg2m.conf
>>>>>>> index 0b3acf49..485683b2 100644
>>>>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>>>>> @@ -1,7 +1,7 @@
>>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>>> =C2=A0=C2=A0=C2=A0 # CIP Core, generic profile
>>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>>> -# Copyright (c) Siemens AG, 2019
>>>>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>>> =C2=A0=C2=A0=C2=A0 # Authors:
>>>>>>> =C2=A0=C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>>>>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>>>>> =C2=A0=C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>> arm64/renesas_defconfig"
>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION=
}/
>>>>>>> arm64/cip_merged_defconfig"
>>>>>>> =C2=A0=C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>> =C2=A0=C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>>>>> =C2=A0=C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILE=
S}"
>>>>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62p=
x-
>>>>>>> sk.conf
>>>>>>> index 589f071e..bf3cf9ab 100644
>>>>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHIN=
E}/tiboot3-am62px-hs-fs-
>>>>>>> evm.bin;tiboot3.bin"
>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION=
}/
>>>>>>> arm64/ti_defconfig"
>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION=
}/
>>>>>>> arm64/cip_merged_defconfig"
>>>>>>
>>>>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>>>>> initramfs with the following log
>>>>>>
>>>>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
>>>>>> create a encrypted device!
>>>>>>
>>>>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>>>>> command confirms that the device supports sha256 and ecc.
>>>>>>
>>>>>> It's working with ti_defconfig. So looks like there is some timing
>>>>>> issue / race condition when the tpm support is built as inbuilt
>>>>>> instead
>>>>>> of module.
>>>>>
>>>>> And there is no other module missing in the initramfs that might be
>>>>> built-in with your config? If you re-run the encryption hook manually
>>>>> from the initramfs later, that will work then?
>>>>
>>>> yes. Once after the boot stops at initramfs with above error, running
>>>> `/scripts/local-top/crypt` manually starts encryption without any
>>>> issues.
>>>>
>>>>>
>>>>>>
>>>>>> I'll run some more tests to properly identify the issue and post a f=
ix
>>>>>> in here or cip-kernel-config repo.
>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>>>>
>>>>>
>>>>> Thanks for reporting. Finding the root cause will be important to avo=
id
>>>>> that other users will run into similar issues later on.
>>>>
>>>> Yup, actively working on it.
>>>>
>>>
>>> Is initramfs-tee-ftpm-hook included in the build? That is supposed to
>>> wait for the ftpm to appear.
>>
>> Just found out that it's not included in the build. The recipe itself is
>> built but the local-top is not added to the SRC_URI.
>>
>> There are 2 issues.
>> 1. TEE_SUPPLICANT_IN_USERLAND is not set.
>> 2. the initramfs-tee-ftpm-hook recipe has an issue. There is a missing :
>> while adding supp-user to the OVERRIDES.
>>
>> I'll send a patch fixing [1] in sometime. I've sent a PATCH on isar-
>> users for [2] but I don't see it on the list. Will try to repost in
>> sometime if I still don't find it.
>=20
> I had a look at the config diff again but still didn't spot anything
> that could explain the different behavior. Fact is that the userland
> supplicant should no longer be used - pulling it in is likely only
> papering over the underlying synchronization issue we may still have.
>=20
> Did you also try with just the initramfs-tee-ftpm-hook of isar fixed
> while keeping TEE_SUPPLICANT_IN_USERLAND =3D "0"? If that still causes
> issues on your board, maybe you could add "set -x" to
> isar/meta/recipes-initramfs/initramfs-tee-ftpm-hook/files/local-top and
> also to recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> and share a boot log. I hope that this will tell us more about what is
> going on.
>=20

Now I recall:

https://github.com/ilbers/isar/commit/a1893507e495710297a2749efa3b2cb05e4f2=
881

There is no waiting for some tpm device anymore. I was assuming that=20
this device node appears magically in time when the in-kernel supplicant=20
is used. But I was likely misguided by the timing I saw inside qemu.

If you roll this isar commit back, then things should work with in-
kernel supplicant as well. Please confirm, then I will provide some=20
upstream patch which also updates the comments in the local-top file.

Well, this kind makes sense because we also need just polling loops when=20
waiting on partitions to appear before decrypting or mounting them -=20
same reason, I guess: The storage device has to be probed first. And the=20
RPMB is attached to the same device, so it does not matter if we are=20
waiting for an in-kernel or a userland supplicant, both also need to=20
wait for the eMMC.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

