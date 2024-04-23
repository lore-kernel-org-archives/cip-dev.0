Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F0C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 10:00:41 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.85])
 by mx.groups.io with SMTP id smtpd.web11.14670.1713866439439361609
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 03:00:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=V6v43OMv;
 spf=pass (domain: siemens.com, ip: 40.107.6.85, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw6T2haw9McTXLP3Kv8fwLbDGUS5qjswdPpQZhvug0LDmFq2glW8sEzpMcssGpziTm0PcgWV+ysfI+OnLJcQLhIKQPDhix1DlJ4tCfCn0mFB5wge4NPKSVMw5oQi/ohoLN34QPAcJI4vSiGTyHzZ/cOmWh99H1TnOUzjNJVD5PsuTpgvQyta8gmjH4QVJQrlXphovv1ew0ykdOINhA1nzubWCWwcU+Y3LRuZl+IJvppII9g7lE3ePha1f7t4bgyI6lqr4MsQjor1F19KM6PAbLde1LiDK40epuQ83fjlYo5loLv8hXXyhYM0XsUeUprZa2wUfHbAQMxzbe4Ayuj1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/hCxzPBwwMkxpGWwNGQPT7ZAfEXzKHBDrIYtctUzao=;
 b=QzxhTzavvU9bFIAN1QuZnGpK49wRXlADvO5NOKElCfbcJ1n9Z1NPy3XYDVhjnuTALx26foHYcwljKv2aEVgctpgk/JhcYUehAn7PMIENTJoxc7arkP34D5YxCA7/yaL3pTr2IVnOktXJdCeGpoPMsNb8vlOeqaYyNV4J/wUV3wcS/49B+2K9X9vUjKiCBSu8jKe7IM9KZ5xqyor0o/wJbPqJu240zU3bUYItMSW6rxGgsJXkpkSeUYc3EEkNSIHjaqY1oOp/whG8IDawZ85KsEgP96lLn5CUeil8RgFKgYNT2HpoUDtR3Iq7VTuyKosmr3ekuK5MCJGj2ch67owXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/hCxzPBwwMkxpGWwNGQPT7ZAfEXzKHBDrIYtctUzao=;
 b=V6v43OMvcK+tosKAXm+QzQd70o2YkhaGr0IgmVEqt03bdHMZnMRrwdUobRGsPPLjkUZ3R+rEwmHoNhvU8jWUzNqzXRh//AJCkks6cNG+6NEKvon0b3mP421VehMpuwxMoUIRdZZPCkrQnlC+hFMAxaSk5EDoy2PKv4zhrHzJbN8/W7VgEw5wgVOJnMlI+X/aoSo2UTfsrD1e9+rNnTr12KFTfz0cGlynVa3yNFPyOJjptGw3w8cfw6iJnYUCnEBTxc9hKgv/jafDh+PxsSl2XeG/y54y0MTpynsyxGaMJc7HzP3g0fJqblD90e/kKwm49Bgy80C2+756nYrZiPUJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB8157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:00:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Tue, 23 Apr 2024
 10:00:36 +0000
Message-ID: <69e0e19e-4600-4df6-b1f6-e159c71440d0@siemens.com>
Date: Tue, 23 Apr 2024 12:00:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify
 encrypted partition
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "johnxw@amazon.com" <johnxw@amazon.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
 <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
 <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: c0954959-8de0-4484-a044-08dc637c38de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sXsAXJesFzBTAr/UJsUjnBnnTju77wC/93nyPAWHOEtml0Ib4uWggEH6vHkD?=
 =?us-ascii?Q?Q6xL6B+eUDooR3vAvES6V4d4yBGQRtFgD9O8bBeaLuiOQLBks5Hl1Q5m6kUm?=
 =?us-ascii?Q?XuSdsQAUvnmgGTLPd6P1vlfpAKqdBMh3zc5Sbj+UeNs267OGaWINki2dYLhA?=
 =?us-ascii?Q?PIsgQ8UoVSPpxNn4Cw0n7dBjs7gTSRu7Ix4H64EfJnNcsr7pC+JemPTw0Fhd?=
 =?us-ascii?Q?8Qb44Ku5JKQyyJRELjdaUy1uZORSEr7UW7wpG86q7vFOUVxsIH/uITaY4F1D?=
 =?us-ascii?Q?5aC8z8kaXYRXuGhFs8So90LE75Tv6EoVOVwMXlZ+x2drEheJjPLDGIG1nyAG?=
 =?us-ascii?Q?T3ivJ1y67d4sBmTgCtOiNww1u0RjPk3v5fXs30XN/jfHAyJ1VzvxvJbrGx6f?=
 =?us-ascii?Q?i7/IIcsiH0pTCRcMiaxxAKadf/hzvpd3+kgz85vdGryI+/Auxv++LoZjvmP7?=
 =?us-ascii?Q?fES94+sYDdc2wfqieHBmR85w7WGClbt4CVkbe7gwes1GndWtWH350D3MyLui?=
 =?us-ascii?Q?jR/SKy3CZqZjCys9NAjxUUkStFWipLZyqz6dTKC+X09vfiab/WxwKpX3eyUg?=
 =?us-ascii?Q?/D88ygPdpFJvTmU16oyNPOZzeqfu2Su+DF46uB4/ZL36KK+NRxczW4E3pCPd?=
 =?us-ascii?Q?AWrEk8VC0BV23kaDGsf2cdfVEuVOa9lWfMZAw0ZnnTbhWP0DASoji14EsfeH?=
 =?us-ascii?Q?uzn/o28cCtFJFC8/MMNRkBQClbp2bOjr1Cjnngv93MbcjvbGcb7GVpdDfzqF?=
 =?us-ascii?Q?r92TXbaKtqNcY8l9K1CrTbn2shw9UhzVc1raA4AFEViXalqkPYwdLUCdtpDC?=
 =?us-ascii?Q?SxZCoVRS+5u/X4JCcyJZw3y4xB1FHY35+GbNYGowIhrWNnlaT0rAbHcIr9CG?=
 =?us-ascii?Q?IDZ6eLBU12Vum24Np1uJ8WJqawNONLv1/T6l+ZNleo+0tdZCyeQXQSicxsd4?=
 =?us-ascii?Q?jMjKUrC3EVIOhgZtc9S894j5S4ufRUfNQHqe52O770vfnBTSC+hyozGixy/p?=
 =?us-ascii?Q?UH80PGAKIvZtAL7Fz9eSHp9IWsh6f1hrY3OmcpKIIwBS2LxWVFyDGU+Qjz9b?=
 =?us-ascii?Q?zuAr8L4abxE90VBtso8cb2Hzzlp7MxwRUg+lQ+/SfoWpqRGEUrz58tCHlV1L?=
 =?us-ascii?Q?UBX4Ug9oceK1tEWwXN5ZNrB3fy3KzX7RWPjxaDtTMuzbEYkgazXWhqRq6HEz?=
 =?us-ascii?Q?jAjUSYjS2w0D/qzQyfomlrf89mYAnEMfc7EeriiVJe0pO1xGzRqGzoDgLeoh?=
 =?us-ascii?Q?TqnODuuLNhrXnlfaahHxkNEmfadncIuhntVB9s7NwQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?85UHvTWyNbn8qjOGQ1GeMj/sb5C1e8oUYvrUSE0LnrFGLLbunm44J6myq6iq?=
 =?us-ascii?Q?o8UcWSBxX0OjlO+g48gQ+k+dQdCnRMMjItLBhgO05PKTkQBO4JKHNEGOBm3N?=
 =?us-ascii?Q?O9ohlP7Vl/q7moVq2UvH9wSwrep/ukO2cvIGhx/GUEpFZfTkQeQa/jf+zaWC?=
 =?us-ascii?Q?qVRw7BAjV2T7Ey62cInN1U4WhZb/qPBHC26LhmaZ7B96z3GDYWp1sYC6LVeU?=
 =?us-ascii?Q?j/tIr556Rw8u1sjyMd0/OLcCmW4n0jZofJk25in7c2XEjZ/9gKU3wdDg5efX?=
 =?us-ascii?Q?xZdU1BrO6znXX9R9PmVbes6FVF5RN6x6QKJCoPNCSpgi+ccyadsyC8rrWrOr?=
 =?us-ascii?Q?k1PPQNZ+Nxv9F5DzLpTy96zTLXaa2kFiMobLlyMXBE/+McBK3ib41K6YBgd9?=
 =?us-ascii?Q?ukRPUcUqqEI+XAnkbK2Z3W0VNkus14LtsmYuwsco9gSgtB7TVfrFtyp3W+4W?=
 =?us-ascii?Q?wpBFVn8ZfBUYaZzoWT7M8csFI7Us5QVDRvGezg5BvBMQxHiW4oPfBW9SKgqY?=
 =?us-ascii?Q?HablCqHmtg+MmU+yczHZkbRlXPpRrvbMjkbCGB1xGK2c2PD4RgVAIOjZV4Yh?=
 =?us-ascii?Q?TDPuJLxxtqcFs0dtcz0wJSYoT9fmrTOhYUAZun6b1a+xK55WE15kCLPghYRO?=
 =?us-ascii?Q?9a2JbZEnrwBBG1hi1s/DrSUypiKSbJauA6efvLiQfEr0Mb/HL2hhc5TvMDuS?=
 =?us-ascii?Q?2NG0uyQEPotyqTktpuFrdEiqjBHnQZr58SRi7f6YE1qxaBDQKAy1ghFrTV4p?=
 =?us-ascii?Q?WOcMFjGGBZSKFF9xSXGR/yv1aLBKjh/jFGQXSHiY99xrHxexga+wq06pKCST?=
 =?us-ascii?Q?kDKkF+hgbAo2Iy5usg7lJ4v4F99sb5VFaZmdOAwR/gBMdr3zRtjYJ3qdsIt7?=
 =?us-ascii?Q?bcnHOClyl4kfYc+yM0U0sKaXuDxCQ4+gNLSzekVkPoFx6S3y3nE4Lxw8Mg0z?=
 =?us-ascii?Q?gUu4Kl62aAYFVNCsLL6p2KGQlBUbD0gVSkr9wXx37SJuTIQ37u3qq6D7e4Zh?=
 =?us-ascii?Q?iZQ881SXdm0lVJFZ8M0Xl2WaecwYkdSTbgLX8R34IL6pK5d85pZV8AXv5wxw?=
 =?us-ascii?Q?MI/Eizubdqn4HBlHk1TuWezUDwdbS57U+8RVAKLfclA9bGPoLT1+PrdhWijC?=
 =?us-ascii?Q?9EYzXg9U8DtByULzPUQAFyI/OLAHeyylFvP65BewWsAgCceAlh9tgYZgqFjb?=
 =?us-ascii?Q?0xKmXs+zg8FicZlMxUvKeeIDZbqLhXkqG/F3cpA3lp7IxUi1xn5Pcxia2Z6e?=
 =?us-ascii?Q?oA2widQ57Rmed14n6AquQG85IJNnGk+LiuxnGotc28oUMO7+rtBLBOVoXihD?=
 =?us-ascii?Q?xVb9XaQT4SQojtcTp03FqhjeDLa+sUhb9Iyvulv5cfjnJKO9vMtpxYH7NDME?=
 =?us-ascii?Q?rNFhZOdN3L6evWtG/YaEIp8l7RfIG53xq9WIfoe/4/fuhdMc6oZRMoE08Wbs?=
 =?us-ascii?Q?ZNeIq+LWVAtLvzTdBCclVeXj8plHgz+Srkv/uCEMO4VQfUkurk94w8BQBKia?=
 =?us-ascii?Q?vSQd9TAukWymSxkrLecbTy7MncTYDolvXOqtKCkY01eHFTrNC4MQS479UDdT?=
 =?us-ascii?Q?SFXdRzvjp8NQcy8ByJhlxMxKK9EL9IM2oDA6O0i1HqtHFeNU3G5CVax8EClJ?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0954959-8de0-4484-a044-08dc637c38de
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:00:36.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrdrw1LYcnEWIXsHuYwuUqFpF3KY4BLONQ6fNghucgAeP+HsT/mLJ3Xf3VznxLPxHs9d9+cRvTaAYy25y4jBiLWYiNc/8Ql09ShalH8Hcss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8157
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 10:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15734



On 4/23/24 11:35 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-04-22 at 16:09 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes an issue with encrypted rootfs during system reboot.
>> With the token option it can happen that during reboot the no
>> valid Luks partition is found and the boot up fails in the initrd.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.../initramfs-crypt-hook/files/encrypt_partition.script=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
>> +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-
>> crypt-hook/files/encrypt_partition.script
>> index 51c81f3..685d882 100644
>> --- a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>> +++ b/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>> @@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if /usr/sbin/cryptsetup=
 luksDump --batch-mode "$partition" \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "token"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "luks2"; then
>=20
> How do we identify "our" partitions in the first place? If I read the
> code correctly, we still identify by label, which is quite risky.
> Otherwise we might re-encrypt partitions which are not even under our
> control.
We cannot identify our partitions- we can use label or uuid which leads=20
to same issue in the long term.

>=20
> We must either identify by UUID,
UUID can have the same issue as labels if not used correctly.
  or at least limit the search to the
> device that we bootet from (this is known via the systemd
> BOOT_LOADER_INTERFACE on recent enough ebg versions).
> The encryption should be independent of ebg.


> Felix
>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0open_tpm2_partition "$part_device"
>> "$crypt_mount_name" "$tpm_device"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0continue
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>=20

