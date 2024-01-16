Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9971C47077
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 16:24:35 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.58])
 by mx.groups.io with SMTP id smtpd.web11.20224.1705422266778549954
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jan 2024 08:24:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jRXvMWba;
 spf=pass (domain: siemens.com, ip: 40.107.6.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrPkcNh3quqlnIlib5jt4M9aFowwov/IOJseeCbGP4wuzCVP1dvArrRlYm8g1wNmr2PX0nJmRmBmn+NldcjZNZm0mYs1pgCQhKPGoGUICxvUn7eWb+f9QVKktR/5ee9PyTRJ/9Ui40s7ukOkXCYBNWY0I5g/6XvrIQESO2uARrHXovgCX1NNVb3mQNfHm6OZmnvQJOPt2rws8B2I+fNGHKSLMRtjjYJlI+eRHsvGscKhec14vRLw0cyw/AJDzZqCVwFvG/a74yozv+eNu0tn1643qM4vJ/soaeNSbOKrKuA0lzWOztF5DM2ZgUX+orme+M9EgdguA5Qrf8jqFX3U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ej5pIRqjB5J5gYRjAvfHEOadd4tr2FPXjhtgaXvGf4=;
 b=RVwPuxcYFnErdw2unhcFSObevBtnXgfFcVE/i9JwctixfcNyUVJ0Odl81JSbsrH9nI8F/9dYaiwJiDG48tXKwnSKlbDrYnkooL9IMR6cxaO3c0zcyHLYbZzPqwyqf17FO6wtrWqS0y6CP4wQ8wtIxJ35mz9/HIKPsqav4V2s2GvQ8UvereB9hw+22QeQEHRWijFuUb0HKt+WdPkfNBUsV/2wu8yXrFGfX29RJ9FSeCVWkcYMukuGoo8rA1gq6MZ3Bo0Nu/D1FHZaEBekIK/7TYeCKMlM8TEiB8WpltmL6/QYnAmwFsCPn3ydU/JexRnrecbyVJ1MUc13v/ioJWI02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ej5pIRqjB5J5gYRjAvfHEOadd4tr2FPXjhtgaXvGf4=;
 b=jRXvMWba9vrMPUZJ6y+qb0zWyDRghRrY7DJZDroc/inbWgNHFAR/NHftz7Be4XSvg/9Fb36dUMkMeG89agm4uKQ13Cb6MLanBrBXoEwp044G+UExQXy+ntTad/i9L9vfHw9w61zYzdL3jy2vvjIfhsd5WbhO9tLRcToiNeoehYx4bl1gXUb5ze8HhN19E3IT4mQhmXIQbAG55MgRha8pUu0e1Lns8YGGrwKJIi9sIbKSSb7urGQyW8y2vGXqqlGk6LEztsCBs3zuGtSlgplBF52ddAM8dCAldlNk8JZyPa6zYjwDdWlvlvqk/F/z8Dsw8W/19q3yctuhqFLSI5qOMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7293.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 16:24:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 16:24:23 +0000
Message-ID: <0e2458f1-e3d5-45cc-a37e-5c6b87c858f3@siemens.com>
Date: Tue, 16 Jan 2024 17:24:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to latest
 debianization
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <2bb4e18b-20bd-4dd0-9301-fb08aea7a730@siemens.com>
 <c3dc60a8-ff32-4e16-a1af-9087b4e84193@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <c3dc60a8-ff32-4e16-a1af-9087b4e84193@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: c320e3e3-be46-4db4-a05b-08dc16af9983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5VXhDr1OiNvbkF0TZ/sVXKd9OFJxQXbGefOjpy0IrLC1w1lJhvcLupuYlXx2rRpbHhXDqpNDd5RcNgs3dq484GyJBVZvUiLMQFAPrRLqM7n7oIFjo4/gwIkF4X/+Fw6dSkeyzHmv9bK45xhO7+cu+s0HF4FfjaWLyFuHS8lvq55xayewg/R179blrqs/KjP5tf7N8lRmFC/aJbXok/X9fdMR+1s+XKrePbmf3sKmcSly1QMusMuhUxaW5HWSw885JdmEw8KEjG4bKSbbR7NjT9AflJpMX9nvWCmu6Nhpwkoitqxqmi64yPDCBK5UJebqJ8XNekyMLAqK0Ih2q5xB7WSCNQOh7sxPE/Tw/lBczruykR2xnxerUBKKw12twySplx+5rUs7uUpbKg57SUty1ACCM1d1qIc80JXaXvSC2GKDHzIyboNvq/y1EuEuc1SH2NzkPFx/wagAEZz7wv7w7rbqHWZLUveuq43cYrKvyL5L6YeKUHoJOJAAz5l2QBGGeoFjrvzqVMvrcpD5LZibZAn2eFvP77GkOGqWUl0hWay08rqyrkV7Ua95yjqB2KbRVggeQYbHUAwkh6qYwg7qz4QpwgU0zJ/AprjEpkm2tTL6agNm2/1CJpXMbJumU8HqG2ak2uA3tz0TCWKU/AlMiw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(53546011)(31696002)(86362001)(36756003)(82960400001)(6666004)(44832011)(8936002)(8676002)(5660300002)(66946007)(26005)(2616005)(38100700002)(66476007)(66556008)(110136005)(2906002)(41300700001)(316002)(6506007)(6486002)(6512007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GtTHvbL4+ePVjRYW+nflrD2do9PrY0HkhltccOYpKdGg8JcwUKT+O7QR5GVm?=
 =?us-ascii?Q?XGo4hzFQaQBZ65enIVZX4/3paBfVIGN9XivYw2hkz6jHL5tzPr6ik+OJQ9YH?=
 =?us-ascii?Q?6rbsOmKKCBLgEZTnRwNX8GDlPxJ9b0BbDg0/Cb0HOfYA28bOlFxbEaaFcg5b?=
 =?us-ascii?Q?FyL3qGWh8xEMPjT1W0AZbFWOqChk1YuWFpw3xD5lmwn6RqhwZg3GofWfg4nU?=
 =?us-ascii?Q?zH1maUXYUZSTjH/oBXkJfHke+9Xt+ukQL5XJuFWCXH1IeRHBiqnzLxzTQU56?=
 =?us-ascii?Q?I2wMLIwkGq21RdDrt1fUTO6QrDBmjRYYJBX9ZH4aD9z9X1VQHogYHoz40Mtf?=
 =?us-ascii?Q?c9IE2HSXOCTdwgAqKWhwO9iIDxQNNTrPp8pHT6lvXXbGv925Sl+uqLwBvDSC?=
 =?us-ascii?Q?cFUJbt6u0Gsy9MChqNfrFSbss026TKiOgZcXZgtA3JD1enQTCsPJSIHAztBC?=
 =?us-ascii?Q?/Kea00djTwKvAjT7ot57Y4Fqy6H3CikVbnFG1JHZYJZdpV6mMJDYQk+mYdtm?=
 =?us-ascii?Q?XD8faAyZmYLpx521EQfH/S4MynqS3Rfo6OyihBbR9AE615jdhZLKKL1kRHc5?=
 =?us-ascii?Q?9kVERCOf6FzZ1XVhD1u3j0Qoe/q7KKP9mj5xeujWvJ9fMFLe89a2eBHe/LFD?=
 =?us-ascii?Q?KnIxufnwKXgfalR4/hbVyf8GF7bp8gT3Cx5a2q77f0lHrhOXiA5PVosG3bBb?=
 =?us-ascii?Q?Ya7wWDqmG8R8TBYAi+OW7oKZYT2TAxwuZoj1kNa5M8UE/56kmyT5Zigrd8W8?=
 =?us-ascii?Q?YhOWT5xHpmXIdtMo28vkLtB5PHAuM7yWHCECCvzRVX5dfBe9Kkqyek8a0W/d?=
 =?us-ascii?Q?d4Xqz9DK45CSyi3QritwM8bJjPiVV903MYyLD3s8SP1Rs3ZMTjxQt3ywniY+?=
 =?us-ascii?Q?bSa/RL3I/eLNL6D8X0mvgcoWV4XGKPtFrEueJbcd/L2L2eXDzPalkEeonted?=
 =?us-ascii?Q?WysjIBTXT4mL2V21eUckXljeYEr4Zs8DX6yeGJ1rWeFg/6/as3plp2BewSbZ?=
 =?us-ascii?Q?m9JLu+i18Vp7bNkWRwq2iAIUVOpyN9juBGAIybu73+yAgfHa6BaDi+pNmwM8?=
 =?us-ascii?Q?GC0at8DQeSm8n2rBGOnu4Ziv6A2ErVEcnOTf1G0zXDM2LOVMrZoW5tH0w0lH?=
 =?us-ascii?Q?nXNmsfwm1/RE9cL6X/86uQ4C0zCqCbA1LUt6edyuaaV8QhTRDj4t2TwqeUnx?=
 =?us-ascii?Q?RIbJqiQ7Izg0Ls4WlnB8ywDw1wNhKo7wY+kXjLDKh3kydPYzkje9ne+JTTgW?=
 =?us-ascii?Q?gqfseuNriODXwOenjD6+K+te28PNjmyle/fcP0au5xpgyg0Jdbb2JymKTi7P?=
 =?us-ascii?Q?dnKOyw9bbGBvKyRwUR8jzmEsjcTXhBU54yDnnFhqk3VhGpWoN44SL01fvOMO?=
 =?us-ascii?Q?b1gAn2mB/Q1sKV6vsyvuqtZ04MWy/uL8CtE4oJxyAb8Izg6a7bNPOmMKT37h?=
 =?us-ascii?Q?sVhsAuLkrGguYxAFGchXOAP8jEVwT7KbPbJryRZmpQmnGLYjffSiqsO7Wcyp?=
 =?us-ascii?Q?WFsZ8ZUA6R3KoMj3QXEKKAcXQl+EdBD9hAZ+lP/T6pqP2ITri+z7pROMSNJB?=
 =?us-ascii?Q?RLUO+sKXjO7phgKRGswnrODWIEXz0ji8LwM3sgD4hiZoorLHfbSmNBfXp1EG?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c320e3e3-be46-4db4-a05b-08dc16af9983
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:24:23.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQb/WmpXj9xTWoCOe5YgHuwoZiJFZRgQCiXpkMy+uAjgRghoIQFBmv2yW3cieVwZ1bFdAVZgYOmVCkBGxWLQkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7293
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 16:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14397

On 16.01.24 16:17, Gylstorff Quirin wrote:
>=20
>=20
> On 1/16/24 14:32, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This fixes cross-building and allows to use python3-shtab in bookworm
>> and newer from Debian directly.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 ...bootguard_0.16-1+cip.bb =3D> efibootguard_0.16-3+cip.bb} | 8 +=
++++---
>> =C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)
>> =C2=A0 rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb =3D>
>> efibootguard_0.16-3+cip.bb} (89%)
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>> b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> similarity index 89%
>> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>> rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> index a7ffb00b..83be2a4d 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> @@ -1,7 +1,7 @@
>> =C2=A0 #
>> =C2=A0 # CIP Core, generic profile
>> =C2=A0 #
>> -# Copyright (c) Siemens AG, 2020-2023
>> +# Copyright (c) Siemens AG, 2020-2024
>> =C2=A0 #
>> =C2=A0 # Authors:
>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -24,7 +24,7 @@ SRC_URI =3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.=
patch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>> =C2=A0 SRC_URI[tarball.sha256sum] =3D
>> "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
>> -SRCREV_debian =3D "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
>> +SRCREV_debian =3D "22b173a3293c976c9dff2ae92085d7ed995f6768"
>> =C2=A0 =C2=A0 PROVIDES =3D "libebgenv-dev libebgenv0 efibootguard"
>> =C2=A0 @@ -34,7 +34,9 @@ PATCHTOOL =3D "git"
>> =C2=A0 =C2=A0 inherit dpkg
>> =C2=A0 -DEPENDS =3D "python3-shtab"
>> +DEPENDS:buster =3D "python3-shtab"
>> +DEPENDS:bullseye =3D "python3-shtab"
> I think :native will fail for buster.
>=20

Yes, and that even for bullseye. I'm not yet understanding why that
breaks - limitation of those apt/dpkg versions?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


