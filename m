Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE0C3DA4B
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 12:51:38 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.86])
 by mx.groups.io with SMTP id smtpd.web11.37106.1721047896079731426
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 05:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CNxocQ0E;
 spf=pass (domain: siemens.com, ip: 40.107.103.86, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYuHJNJFztperJ0+6XUBaI1r3xkhruYasOrWLUUEfuTLgWwixLLNvgo9d2UiyEypmIsh0JquNXUzLWJgt5Tshabb5syUyqldcDGSkSrlaCbzwNcooxu9QkQywLqj/wXi9UnBB4cmtRBsQJJJy82mEbyb6M8pOqogoo0/L6OLpEp7nBU5iuwIhJsCP+whnXaef4TPf+spNJhT+nhoppdw54CtiKSHG0dQxn4ViGd2Ww25CsPJV3LVKyvACB9brqk+YKg+exdto7OoxfUTaPBdVo+skRbn4+UVJXP3aO+pfjX4ulViXFgeIYTguEks1EFz6QKLLyiYjQKMa8NnGiBuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR/JP+edNdZFNq9ByDmMf1fR50GefwDBWc6fbD8Wh7c=;
 b=htfqHUU3wmEeuki1tf6BCj/bftuANKwUircvxOpEN0K0OmbMetbrFK8BcCrZvICf0ofYTsG7jooz2k1bc/FTi14ZFd5l+Wns1VoHwpHL1saozemmCgdmh9RN9A5q9KJWYKCekJfk6B4Wxn+DZ9b8YpKWlTmf/MGJe9SJvcVojF/fo4wY2C6oYb5+qdPeZ+4+Bdyxgmuc/+Hxq/3QMq671zaHZ26Fb27nvpQALap41iGoNdglzJZ6+qPU9wKBL4EGYdm9Jm6M9jEwSIkXhLo2gQuhPq3wekVLFjjy6RLouHPV7MSZ1oDA/4nF2xUU93j1o3C3K00b74WuYxo/rjtlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR/JP+edNdZFNq9ByDmMf1fR50GefwDBWc6fbD8Wh7c=;
 b=CNxocQ0Ee2TD4IHEzA66XUrwN88nPyTTcg1UM4fvRI+4BkbZw+GJ5ZW9C9iVJRGavFQZScD2RmRQEw4PpeNbxRJGiVvIXz7alLNogagUM0tL8uzr5TM6mdJH73umP2LsisTnXNj25h602DiBrqoOpEEoLF+PQIm47sVv4TzX4ScLVDkg8yRZ6YOh/AmH6gSHmoriiIp7Suwun9nfs1Jqe9X3LugIPQZ12g1TedvA5JBwQx5EW727GLf9jpOtC81oI0qIDo+lC32ap8LrDyaQEd4oQObbVACRD2Zep+OUbfVr94bzgF4y09OlKfGxFAQFBecmOqyIDI9F0Q+RDkf1cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA2PR10MB9080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:51:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 12:51:33 +0000
Message-ID: <de1bbc07-074b-4814-a404-d7d88ba5be07@siemens.com>
Date: Mon, 15 Jul 2024 14:51:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup
 executable
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED OES-DE)" <christian.storm@siemens.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "Adler, Michael (T CED OES-DE)" <michael.adler@siemens.com>
References: <20240715093424.632716-1-stefan-koch@siemens.com>
 <c183806d-c3a3-4860-a8f3-a4e4c12c82f3@siemens.com>
 <60345d8f9471d087dc866f56688421232a5c3c12.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <60345d8f9471d087dc866f56688421232a5c3c12.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA2PR10MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fd6bb8-a808-4007-7185-08dca4ccdacc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RWz0HtN2b6Oq4qN4Zd0sUMDYpSU/pzFH2COs6kB5rR9W67i3Nlw5mK/WkdZg?=
 =?us-ascii?Q?WmiSPKGIw1IXcHwMUSStjUyCxnazlNaXC4zTmAsx/l9NkYJIn5Fil4yD+5Qf?=
 =?us-ascii?Q?NfUpEUTl0tU1L0rJfmvsXY4qVUW1krePT/NaYZZKO+wf14LqHaRAPFSnatLD?=
 =?us-ascii?Q?uCwYc8OrZGkhhgX8LWFsn6MUa+ejCPxKUTvGHVXP/QB+C2TFMdJbl+aYTIaX?=
 =?us-ascii?Q?xjKKk8LrgSZpqD21h22ZZXI+RGzo5LR/CdzSh+LhOV1nQsB2zTo4NGXDIerR?=
 =?us-ascii?Q?fyodeO/EQJeKTzshhWl2vMgbPh3qeUiSDYYP20bh9VIeVATuz1OyUAYA3ewU?=
 =?us-ascii?Q?NLRa3HR6IRdLcCI3Q2nFCgxlFF91UxG9M1D1Noxp9LHcSm8Il971Hjbmutgx?=
 =?us-ascii?Q?V+ZyjlF5gECKD097z1DCoraxn6V/pZk+g5ci7rrZxmf+Le3GwgJvHCH5tZbS?=
 =?us-ascii?Q?o8Gpru9TJhMP3rLT+dC4ka1mCH+5drQbs4RLDA+LWl7MlUxyruD0tZvzdLDG?=
 =?us-ascii?Q?OpECqJlQyqr9w4OoVrfW3blQJbbkK1mzCZ2H3WlsltC2AmhiO1P747ffpPKN?=
 =?us-ascii?Q?ci/doepao/W71TcutNal4KckVb44QZt9F6BHrtJU/L4qewDa74zKbNa0oc1D?=
 =?us-ascii?Q?fvrxHx8um8946QLLZGxRmdvQzcqGXr699HHNrZb7JRP2zop09/DEYroCYfJK?=
 =?us-ascii?Q?4kmGUkKzpcXUQTY4kshu3CIMm/fth1oepUOng67pn6/aRdLFotzYnAGw3piu?=
 =?us-ascii?Q?ExRck2L4CyuGVLbvDU7OD/skE9LlUz7RLzGs+1iolZsvA34C3cTlzRcp1fZU?=
 =?us-ascii?Q?WkingBgIBu0kVRKB+4K60Z43hhTNevaoFfic2mCOMMtEFS43drWdXXIKiW/O?=
 =?us-ascii?Q?YMsVCNnxL4ZJ0mosMvzbOrZcn8H+n2S/cha0dNp5arH3pP54d1RlI7U2ajoV?=
 =?us-ascii?Q?QMAoksN7N56g+sn4oxo+NN9UtnBZ8rPEnIBgz/fnA5k2B7jEwpxuHC7Uw2jl?=
 =?us-ascii?Q?CTN8P56DRo+Qs1yYwB9P+fLt7Oj1LqR7gD4tlpw/QFJXanCTC3+iaeneaQVF?=
 =?us-ascii?Q?F+GeQW+U4PqPWUsSAZRwQ6MJRNJJTmyL9WUOBTD8CmMHWZd/lGg85w7JzRQu?=
 =?us-ascii?Q?8fUN0NWAqyokjApEzdAVosRoLtkU0YyvtpnLN9CQebk1vH540SHF4a1fZCCR?=
 =?us-ascii?Q?om0wA4gZ25X2Y0yMmPTpnxZnXohX3mm0p3zL9Y9hRYph/vQWae3BLz7XWQpZ?=
 =?us-ascii?Q?XeeCZisWqy0SSckfl8EIPMHMPwbsy8WK7hXCtD3FIf7NZrqZ6BLmzFtLkUtH?=
 =?us-ascii?Q?CxcFHRFTATC6WsybwtaK/KP40D3pFQywfHtKdnbkyGEVBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8XW0aGKeWa+MlkshUBBJZJXMH0QFve907UAd/Ff/ubeZr8oCObwCVjS0+v9C?=
 =?us-ascii?Q?Idk46ViEZ2nodz00pQLKKxmNNDBzL8JD4ca5nDPc48Y5i6qejqebXeTEWl5q?=
 =?us-ascii?Q?3y45j0bvIH3la1tUgO5iif+GYXNN+aUAZw8BUsPA8LtU0QwDHtVOXpk9gQCE?=
 =?us-ascii?Q?3tpjh0sOwzyBEIHjs3Syd6hNGG41vHevqinXxDfQY8XlbNDQqPYbtQgfXuOJ?=
 =?us-ascii?Q?UZ904gxno1DukWJa8nbln7GRHUM+CoekDrinXagyT6oYQHhaEMFg4fZc2shu?=
 =?us-ascii?Q?DCeWziSbl0kmRb2MGA8Rl86zb1v0knAF1Ya5Qvhjrl1gRZjagdXnhch5dYbK?=
 =?us-ascii?Q?LqHnIdbjoT4fHMywtekcL2yWOD3A2txpdfTAphkpeX/SHigeVX1Oft15uzEu?=
 =?us-ascii?Q?Amx/ujikV56HtvFoskipu0fjHb13x0C8B3goQ8Djf8Lcd1oR9lAcSFNXj3+Y?=
 =?us-ascii?Q?yoCrKk8SLptmHQwsdYK0e4cNBDyZgDh5G0qANZYS+tHMelnuZfwvGUZ+QOp9?=
 =?us-ascii?Q?HwjjDWc3gi8zV3F7U8MmjwS9YlkUi8aNgk2CWHLyJjHbZyz8YdRq7wXepEF/?=
 =?us-ascii?Q?E3VjhxlJiA54LUAM+pyYhYCPN8cef5EoHrfrgNXvpPf3exdZUTDXBgkq4zmT?=
 =?us-ascii?Q?L9+1ie1xQeleBPhqgNyXLTEmaVJamWQS/XTGHYbEjQDq8I2CXNBV8CCRI4K/?=
 =?us-ascii?Q?ax7Oephw47aVqBhOVP82LWFRKSHvzpaMpcjyPVw2iAQQdzUOA34tMRwCwRLj?=
 =?us-ascii?Q?MOUOZ53ce8paQ8cQy0A/beeRiGI5d7PgeSsbFU3vDKjgbxNbGznzZg8Ph5Xn?=
 =?us-ascii?Q?SMT2DsB/GxqeWeYuJ+4tWN7CpgCBhJlgfSaVP+ZJWBnYGhyUsvN/X55vkOiv?=
 =?us-ascii?Q?34Un1lOqa5AAQ4Ixx53EdqKGtYHMKYgOBgbc3U89GA0sT6YSy+EJ/wSU89bD?=
 =?us-ascii?Q?C6lf3ANqBryXryw4wuUy3U5V322M9pUYsKTyOPAQqxAvo2QFzm5OsdS0GkTn?=
 =?us-ascii?Q?byxoYAwMwN+yRnt1JfwgsvycmyMMcTabMPJviNd5hVfIh3opwGemZX09HxX/?=
 =?us-ascii?Q?DkqGTbEgbJql2vNR65rYBqe6wtKFroCo5P5L884B/lwcI6FhBVwq4DRA9p61?=
 =?us-ascii?Q?Tqxn/aNBqYJKE4HYAoLqFp9MEjlpbHlc+EVZCjOXWrscmDeLpTwnBKNDXCXy?=
 =?us-ascii?Q?0hDgYIb1xMzEtKZPHDkuQlPTJsGcNxRRC8CJ406Aa0P8V55pq0KsQrAF5f11?=
 =?us-ascii?Q?9HhU+hSp5lguWKh3QsOLPRGjtP13aizCEp1ursWIcZoXw4Wmn8krcgN1xLy4?=
 =?us-ascii?Q?mn79FGu5aRB3sCWfK5wk1REWUm28c5iFgPN+wLry7WHtNC6VslQTFrk7PHJa?=
 =?us-ascii?Q?ElL5aVHfKddz1+dssbMflew7Y9awmaKrI450nDWWXMMKGN/lUBdYz4aekCOI?=
 =?us-ascii?Q?dlvSFKH473nKAPKKCkwl685dgKwupw0dpuarKFfLyNeIk6Fhn1bD4at4Miii?=
 =?us-ascii?Q?LfzY+eQHt8EyLpqxQRywiGG07WpHruLwFD5+u3E6NbiBgJvPuylmdpk+tU+O?=
 =?us-ascii?Q?BpX9vDe7VS+LD/bpfaQxUnWVIcBmB075mfn1uu/Maaw1X5KnKVyTdHPa2MaN?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fd6bb8-a808-4007-7185-08dca4ccdacc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:51:33.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJCCIZ7kJXcZhTkUOJMYHOtGG+tK0hThzBHYxqFJs6Jcf/PvpraWOaRG+zyLHg+Yj1N5g4DZDfE1uH7pXmQl6AR+ba3Wom/In6z0F6WyRWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9080
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 12:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16493



On 7/15/24 2:00 PM, Koch, Stefan (DI PA DCP R&D 3) wrote:
> On Mon, 2024-07-15 at 13:01 +0200, Gylstorff Quirin wrote:
>> Hi,
>>
>> On 7/15/24 11:34 AM, Stefan Koch wrote:
>>> - Avoids using a busybox losetup executable that
>>>  =C2=A0=C2=A0 doesn't support the "--sizelimit" parameter
>>> - The "--sizelimit" parameter is needed for introducing
>>>  =C2=A0=C2=A0 speed-up of disk reencryption with the following commit
>>>
>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>> ---
>>>  =C2=A0 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl=C2=A0=
=C2=A0=C2=A0 | 1
>>> +
>>>  =C2=A0 .../files/encrypt_partition.systemd.hook=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 4
>>> ++++
>>>  =C2=A0 .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5
>>> ++++-
>>>  =C2=A0 3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl b/recipes-
>>> initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> index bb93361..72033d1 100644
>>> --- a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl
>>> +++ b/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl
>>> @@ -5,3 +5,4 @@ WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
>>>  =C2=A0 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
>>>  =C2=A0 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
>>>  =C2=A0 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
>>> +LOSETUP_PATH=3D"${CRYPT_LOSETUP_PATH}"
>> Why do we need a variable at this point?
>>
>> If there is no reason please drop that variable and use always the
>> full
>> losetup.
> When remove it here, we need to hardcode the path
> /usr/local/sbin/losetup three times within encrypt_partition.script and
> once within encrypt_partition.systemd.hook

Then make it a internal variable of the scripts no need to set it with=20
the template mechanism, which is intend to be modified by downstream.

And it does not need to be added in the hook.

>>
>> Quirin
>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.hook b/recipes-
>>> initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
>>> index be8c117..2ace533 100755
>>> --- a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.hook
>>> +++ b/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.hook
>>> @@ -19,6 +19,9 @@ esac
>>>   =20
>>>  =C2=A0 . /usr/share/initramfs-tools/hook-functions
>>>   =20
>>> +# get configuration variables
>>> +. /usr/share/encrypt_partition/encrypt_partition.env
>>> +
>>>  =C2=A0 hook_error() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "(ERROR): $1" >&2
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
>>> @@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error
>>> "/usr/bin/sleep not found"
>>>  =C2=A0 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not
>>> found"
>>>  =C2=A0 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2f=
s
>>> not found"
>>>  =C2=A0 copy_exec /usr/sbin/cryptsetup || hook_error
>>> "/usr/sbin/cryptsetup not found"
>>> +copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error
>>> "/usr/sbin/losetup not found" >=C2=A0=C2=A0 copy_exec /usr/bin/systemd-
>>> cryptenroll || hook_error
This is unnecessary please remove LOSETUP from here. Also it needs to be=20
added to the clevis hook.

The syntax is `copy_exec <binary_name> || hook_error`.

Quirin
>> "/usr/bin/systemd-cryptenroll not found"
>>>  =C2=A0 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error
>>> "/usr/lib/systemd/systemd-cryptsetup not found"
>>>  =C2=A0 copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy
>>> /usr/bin/tpm2_pcrread"
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-
>>> crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-
>>> hook/initramfs-crypt-hook_0.2.bb
>>> index 72de5b6..1679133 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>> hook_0.2.bb
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>> hook_0.2.bb
>>> @@ -9,7 +9,7 @@
>>>  =C2=A0 # SPDX-License-Identifier: MIT
>>>   =20
>>>  =C2=A0 inherit dpkg-raw
>>> -DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup, \
>>> +DEBIAN_DEPENDS =3D "initramfs-tools, mount, cryptsetup, \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 awk, openssl, libtss2-esys-3.0.2-0 | li=
btss2-esys0, \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libtss2-rc0 | libtss2-esys0, libtss2-mu=
0 | libtss2-esys0, \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e2fsprogs, tpm2-tools, coreutils, uuid-=
runtime"
>>> @@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>>> var:/var:reencrypt"
>>>  =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to
>>> create the filesystem
>>>  =C2=A0 # in a newly formatted LUKS Partition
>>>  =C2=A0 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>> +# Path to full (non-busybox) losetup binary
>>> +CRYPT_LOSETUP_PATH ??=3D "/usr/local/sbin/losetup"
>>>  =C2=A0 # Timeout for creating / re-encrypting partitions on first boot
>>>  =C2=A0 CRYPT_SETUP_TIMEOUT ??=3D "600"
>>>  =C2=A0 # Watchdog to service during the initial setup of the crypto
>>> partitions
>>> @@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
>>>   =20
>>>  =C2=A0 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CM=
D \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_=
DEVICE CRYPT_HASH_TYPE
>>> \
>>> +=C2=A0=C2=A0=C2=A0 CRYPT_LOSETUP_PATH \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OP=
TIONAL"
>>>  =C2=A0 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
>>>   =20
>=20

