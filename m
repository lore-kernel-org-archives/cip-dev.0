Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB8FF8868
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 11:27:43 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11133.1777375654397122447
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 04:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bL8vq2Pb;
 spf=pass (domain: siemens.com, ip: 52.101.65.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7II1g8CimLplYJkq6IhCxuuctjM2f/YeCmPIQr1xSrbVbMxIMWbONq/yQPg4mI3VR22izzpZ9uwdt9669SywYHggevd4Ns2KO2S0L/+Vl2+BqYUU5HxmyXiV+8DM+lxQgp70/unJN6Quw8sKIiEToB7LJSEvv39pVlZ23IljWtDFcOiYsqLzI5jhtUskohL4k5KOoqy01Id5qPii0F62kuzzlH8dyeHFB4e29QqxoiV2ERH1uUxwPyR4VUeR3egkEuwJFlJuEu/6byiLd0AyUdDlFwKwpvpIwpbDJ5TccHMMWJUUYwW1TLurKsng1+eS0yiPcYbM0Q0Wc0lKLUwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK2ToKDJE9/BskYtqfrf8C1uMAudOoC6Z5osEcAv5zI=;
 b=n7AuCUk3deq6ejvzMZL9n3v2LNfBvKyJqF79maULt4p+tBOErJeFBg89atMF4CIlmWYB2pkf/DyYXDWBxp8fi/llect0Q1YJDX0BlYiqInVQL0zOE01kx+ikp/dnLfxVxhSLEtnxYkDSRdFtNgx6IySu+j4HwAd24Dn1+wegmDf8n9GcbREKa+PdBPGArFE9kjRzSdnUCkAYY59dpLT9lA76BzG33kMoZSEBEZFh8imhrmqwZhXOeG9AVguFG7DjvavH8d1LJl5QxmoA1f/KahWuRq3U2iL2lf2liNke8WYpGUrWiTUOiLX+4i5Gb+D5171/3yxKZKE7Bckt92qOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK2ToKDJE9/BskYtqfrf8C1uMAudOoC6Z5osEcAv5zI=;
 b=bL8vq2PblIcHSVvxmrXne/cZH5TJEoj4aRVfrv10RApDxuNpLkbwWKJNLeFxIN6kpToVX9aaCsXnt/nSd1nf/600Vtp1ogcbojqY6FXwmhVKEew6Je9+3fy5JdpegZmrS5BilRGsexEacbhpeTkVQjz5zzuNXZuA1CNdfGlSrTb3L3SUTy70/tXjilxX+6BZwXRyswG0tfGbnEw/sbHp8fXLjGn/v5rfPRMQ/KspI36kzqQ7D4GL9S9no/ak+4YeEYUyyDzBxzp5Nqki3KWq0pLH6gfyJXWhd85q0tWkpS7OaDEf+3xxSY8+7kyqVykoZS7s7FBkJiwVTYZxvZxY4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:27:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:27:29 +0000
Message-ID: <6ae1a144-afe3-4c9b-83e8-87ab8cd98851@siemens.com>
Date: Tue, 28 Apr 2026 13:27:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] crypt-hook: Check if WATCHDOG_DEV
 is set and available
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260428091124.1765253-1-Quirin.Gylstorff@siemens.com>
 <9c22fa0d-faa9-46d9-9c3a-7030e24707d0@siemens.com>
 <981c2046-989a-435e-bba5-819884ff94ad@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <981c2046-989a-435e-bba5-819884ff94ad@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 0951274a-15b4-4c60-5e54-08dea51921f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	kHzIKwnT6wpieREuorHeF09MYpa85WePoyLD7Ik26r0lmKv1/h8r9JoAz9/mTiUm7Jwx6SW4JJHIda8MvqJpOMuiaYUHUImXSdH98hF0WD9VQ1LW4jglmlb1123uVG9OJ4bEb6ZHd0TpHMBbVMi3cvoT8y+bXVkv5WBNBOZzQgQRKK/vEeV5VTvyXP9PM+mSW1NMMh38++cwuxXArLxIsXIb7Zn3PHRc3pjrPEjsnCPta2GfytRZw19LPtM7CQjw6VkUk5Oz4LkCHgYG7CJHa6GHTEKNkIwzjujnE+RWGEsx8wOlZEEt+ogcxu+WGunH1pG0gqCVD+L8tiKrQD+Iut3obgA0WwcpVVBjZ0AAVklraPjfIW6J9/914RkkY/U8lLTcUFbLLiKpcSVKWV0nLisCdH69jLFhpBt1dhryZpB+PVn/ebdWIfINq11QKYHC7jvTaxNPcrxVUPtYoWnu6DXyPfR315lPoR9snDoiY3kztv9/RNadfCp1K8BS1Rmc+URSCMVQNPYsJjwtq886CsHseeRNZxil4jLDEQ/dNnTuaRUlsXP2uG50DnnAT/3hsInsk0M6b2dM4A4Ks6X5nCewvHvL4ZSvZQGfuR13G8OjqOzoPapQlE4/BdlA0a19c4RrIwJIBjFWaY+3piF5cnjcPGkHn8zas/FJD8LNr8vk6S/PeuHS8SKYki9o+juLyWo/ZppOu27bJ5vtqNIg3UEGQrxznkOixk45QM6TKVg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M5OCmEUwC0rxZcXcePSNI9vMB4yIE+xvFbfimGuUZ0yNc2GvAR8cvEjMIvO+?=
 =?us-ascii?Q?Uc3ULwGI73cVf9qbjagzhK1RcrfZQN+YlfqlXEdqkgg0Y5HkFrEkv9RXXRrG?=
 =?us-ascii?Q?nj6dpgCQIKLAzUAKz9Jj3TTZz0XUqQoQJK8REHiuTHFM3pqB5sv3RyQKY1nQ?=
 =?us-ascii?Q?Sa96ZBjZur7wFhyxZ6aw3CJ4oYgQ7IaS6z/8EbzPUWaTcBRlmEDa36fBPaJv?=
 =?us-ascii?Q?O9y1nUnw614GNVV8Js/V8ilpjJ6VJe3Nsh3W6m8a9xMyGLjpiQXb7WiGKuOq?=
 =?us-ascii?Q?zKiHQXjmrddMow3JLgHc/2slTSISGIm5GIcwinH3BFLfnFb5P9RR9DVsifBR?=
 =?us-ascii?Q?2jgEcVETgWKLxw1/s7I8qsjS2TDB5tMyJgnV3saaoTifye2CtKo84IM0LmSA?=
 =?us-ascii?Q?oHV+VjzNxdvXpls1AFL1MP5e5oNisgkovTPo8xyy3tqhBwyLnbeN9Qy3cIMX?=
 =?us-ascii?Q?AMcnYZ7THpgiExZHJ5fvq17c+C88HmYOtC++K7jh1M/1YE3c35wYXGxcWjeV?=
 =?us-ascii?Q?hJ3UR9jW7qD6hfvn8AQ5cRwTcjau4XEBbQfN2dPqfkz6p4xV4g34cFF80t52?=
 =?us-ascii?Q?zuaq0V2GoknTXEPYFYp5OFKz3aRhzpIWJha6LSo2Sy23sat29Nfzag2zlmwN?=
 =?us-ascii?Q?1FcOaY73Ed+0BmQl0X7aZTdV8bn9JJ+fpsqcUMaa5XAK8LJJ2qmvuwH3yToZ?=
 =?us-ascii?Q?ttt0aGCQ91hteqoSXrjWud53vbE0YmXQiJ2oAdIqH9eN9aiurhFYDP41ybx/?=
 =?us-ascii?Q?b8D5KINDGpEzgbKaRJvL2SmUtI2dbu0rDsB95lGLVWPt/u4cttqkzDvIPG1F?=
 =?us-ascii?Q?9v8g+4fitj7JM+/3MtFJVciWMW0oMufP2grjxbx9i4YpOPx6sRwLhcIe7Qk/?=
 =?us-ascii?Q?K74kEHQ42t4xyz/rfq1JO+BhJgwFFG4EQ20IWMQWoDvPBR68dRDiefAxjXAs?=
 =?us-ascii?Q?W6wbz++lzuInx6t+En1n+b5ttcNwzDdEJ+hDf3uaXJcLmE7hlhuTBiV+LzfA?=
 =?us-ascii?Q?UQL0G9jYv8rHJcje+cx+FQ0d0RZ4zepUp18q53YhSAaOFpNzDoVvTW5jIJY3?=
 =?us-ascii?Q?wGlvxdP8SJKYTuUM2UDJbECq+T4lJHpjLxmiBui0Kl43eTJZ0k+kTjYI126s?=
 =?us-ascii?Q?EiY8F4pmaSwM0TC/G+tJjAF1x+LS0UD8aSNGV9KXYnZzpTSUdpZZmrbqWXf0?=
 =?us-ascii?Q?FY2oTzoO2ns0r3usJ6FaD0bW1XaOJV+cE4o0qtRQAAO+dT1fDJAwtUssjPCl?=
 =?us-ascii?Q?UpVyRVoqkJsdtfaYS+Rgyhlau0iQsarEtWlS06RUi38qb8mOCmGXykc4Bydn?=
 =?us-ascii?Q?oGzaeBnbvFrbEl8G28ylfxuSUt/CkQDeEgeINT8OS0A2kMxPT0iuOSgvvJ7X?=
 =?us-ascii?Q?Xz1EDOh7B3NwnRReI372VXROX5RwJnky35WUeNZzp+EfqKp+gBpUovhESOYM?=
 =?us-ascii?Q?NZWAoG0qJsZzHFf36eDPEOTmVcMXjQ3qbNzpUfxUGA0PaX84qRcm7l9O2c80?=
 =?us-ascii?Q?ZF245En2n4I+PNXpm1RY/h7Mcz03YDCU1zeMRCLO1MU5WUUqt0MPrk242GxH?=
 =?us-ascii?Q?oY8T+Rwlv1PDaBBWNR8jrtNVZsfyCeGN2s+sDbh+/AlFsk1/RVNkKhaMNaww?=
 =?us-ascii?Q?4lwf+KQFZXskXLkZoRU4UReEIKQE733Ha7RHKr7278qI1QNx1KLMTUK+5Yhj?=
 =?us-ascii?Q?v8JoPXYX+aaH1iYP3BW3QsOK8b8KpHPNyHN5+c34xzSqH265ttF6e/XuVrS5?=
 =?us-ascii?Q?NLkVtYvhZg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951274a-15b4-4c60-5e54-08dea51921f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:27:29.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSb1QUXl8CoruuwdL33y+ezxW3Bq96Uo8Eev1dtJro2MiENdrd9yxKWD7wiuSjlLm4wQgR/KuH4Qgm/pmnuQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 11:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22817

On 28.04.26 13:06, Quirin Gylstorff wrote:
>=20
>=20
> On 4/28/26 11:14 AM, Jan Kiszka wrote:
>> On 28.04.26 11:11, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This avoids an error message on systems without the given `WATCHDOG_DEV=
`
>>> and allows the user to disable the watchdog by emptying the variable
>>> `INITRAMFS_WATCHDOG_DEVICE`.
>>>
>>> Reported-by: Stefan Koch <stefan.koch@siemens.com>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-crypt-hook/files/local-top-complete=C2=A0=C2=A0=C2=
=A0 | 12 +++++++-----
>>> =C2=A0 ...ypt-hook_0.10.bb =3D> initramfs-crypt-hook_0.11.bb} |=C2=A0 2=
 +-
>>> =C2=A0 2 files changed, 8 insertions(+), 6 deletions(-)
>>> =C2=A0 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-
>>> hook_0.10.bb =3D> initramfs-crypt-hook_0.11.bb} (99%)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete
>>> index 4f3eafc..fa4980c 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -2,7 +2,7 @@
>>> =C2=A0 #
>>> =C2=A0 # CIP Core, generic profile
>>> =C2=A0 #
>>> -# Copyright (c) Siemens AG, 2023-2025
>>> +# Copyright (c) Siemens AG, 2023-2026
>>> =C2=A0 #
>>> =C2=A0 # Authors:
>>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> @@ -64,10 +64,12 @@ if [ -z "${create_file_system_cmd}" ]; then
>>> =C2=A0 fi
>>> =C2=A0 =C2=A0 service_watchdog() {
>>> -=C2=A0=C2=A0=C2=A0 for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\0'
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10
>>> -=C2=A0=C2=A0=C2=A0 done > "$WATCHDOG_DEV"
>>> +=C2=A0=C2=A0=C2=A0 if [ -n "$WATCHDOG_DEV" ] && [ -f "$WATCHDOG_DEV" ]=
; then
>>
>> The first test makes sense, but can't the second paper over bugs, or at
>> least make finding them harder?
>=20
> If the second check fails, it means the kernel does not provide watchdog
> device.
> If the watchdog is enabled earlier in the boot process we are already in
> a reboot loop.
>=20
> I would use a separate check for the watchdog device and print a warning
> or use panic to indicate a miss-configured kernel.
>

Anything is better than silent skip.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

