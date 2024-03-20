Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC3C54E58
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 11:42:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.83])
 by mx.groups.io with SMTP id smtpd.web11.41714.1710934961234987255
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 04:42:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zU7lVzyU;
 spf=pass (domain: siemens.com, ip: 40.107.6.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccwH0UH0d4c21S1nkem+stGhz9c0rVc5REAPfMoeDHQGkNbcj0fQ5oJyykexbFUtBupcer0AZJuQBS/VAVgCFIUAxgJlMk/y2Fb5Cl+HW22UPQk+GfyX6LJFqXyFrekE1AZ9sK67vGIFp0MoHGTImlMYYYXmxv8sG64aECDclKuZIqzjQTMyCT6qJOGKu1iilKbPWOvGvvEw8UiOUJqI5gKSQI2DuIo0ivMl9+OdGFL71BdtQHz1nz0B8AdXL9LOW3R6jKuzuemcu+Rd+RNGS/t8FTNuhh5+iMYDXud1ElpfsHrMtg9cAXdh+D9cxVhQ9EAxJIOU5i0JIQ20RKlM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DlRt9wAoFo6cYtiyzRAvvU2SDg/3RqukiP8I6Cc1Qs=;
 b=TfHRquX9D5P8o9NAkYMuJSLLp7FthUn4k2sbVQCMl5VAGESrmUHBwGu8zWJ0e7H0yysBb1uYuWV0H+hNdwdOoNDUAkNh+KawDH6qrFViSd0S0Arm6iIkmr0T8VqJse4FXyXdBfegZDNu+hy/gHd+L9TuuAvXt/dXi/VkFSnu6XxQIINisxwmeRKjZq76XQKSm6SR7bYCp+5hpaWN6r6DkhbAWv0Rl+cnbZ+JsoJq+0LdUq7B+JUlESE4djbRiEn2MSHA1hhCjkm9c5rUaxXntan1TUVp3FCmPAiz9vA5mStB4pcLRtkyj7SuRJM0RjSpqljpFwCTb3I9ZsQipy7M/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DlRt9wAoFo6cYtiyzRAvvU2SDg/3RqukiP8I6Cc1Qs=;
 b=zU7lVzyUofnaSuCN7EsI+SZL1Pt29LyQBbLa0LCGfZDUxttxRHSrW5ACLnHkhqXX8S073aBZE3V/p6QP7jwV+QiC8lzulTbBBCe+xBnUSoCgN/uWglxRt5bO9CMCgZMW5+rb2A2TQpmJM50+M/EqAjp9wmBJFl1pHwD1ktIDq+bC5l57qno2FadHjrt3pHRFjt4ySJ+H4lv5JSuGGd0asRQp1ssJ86gsUfGKJTDLclPBnP8wFJCgcF8tzv1zd8ZoWqCacPIchkPKYVam6zEB2U5tIM6liR+OVdO2cL7DSXcDvUE/8wNBvB2BMMpW+t//simvfA3/mvIYfIDwAJh+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:42:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:42:38 +0000
Message-ID: <67e9f840-0be0-462b-b033-b52c4fb4bf08@siemens.com>
Date: Wed, 20 Mar 2024 12:42:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 6/8] initramfs-crypt-hook: add
 e2fsck to avoid resize error
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-7-Quirin.Gylstorff@siemens.com>
 <4ff78067-10ad-4715-93fc-578439f49ab1@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <4ff78067-10ad-4715-93fc-578439f49ab1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 96815be6-c10b-4374-41ae-08dc48d2d7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/2fHgzx2aHjiq9MXyIks9jgtU4qMj9jT0xuQi0xs7awGASkyN/G1ZyOyvjYJGFHXlCYqPR7VjOoxZB/WYEJp2k7lNXWZu8WPKZox3BhfAG8ITjUe+Fz6VrbGTxtGSo25EeK8BckR3vuREr2hCm0jGZwLeIV7jlQzZe3pe5bBdJZUnSo6CLsOPkKWHbo/gPYJT/DiBTd8/uDs6+jNvVVRAr9P4wpqy4UE8F+lCt88w88U83C/90RJcJlr39DMKiZqfYSrYxHFKHdyuvGKhA13VU5aJ1Ygu0g51bbX/obvkoVkHYIxI43M5P24Hojwm5fJ07mhJ/cOyFObqhWpS1vf4VEk1I+rQyDPzd/mm3ToOSrC3ZHZiaOHWz7y46j6WEBSN0jrtyzMHZd1vKGEcOAUgwxD7UgdvytZuVwid3OxP8uwd1E1iMLL9xa9MaJFQmt/7VATjR1+s9xDdX70nHm8Zo/jgq6CNpHPzfNKN4BDZgnUQsGuqaENVsKQ8Bp531gtntZ/NdRnRpx1cb/IHHtD/wqhXUPJpz7oPWe/sw/fQWmba4T9PW/Se0QQYaiAlxZB7moXA+nTRGZkyzp8O6QP9SGeqTJWLNbov4E4fTDTK7uckCvGXENFWK1c2jOhaQGZ4Z3gB18KhLgx0NPPgM3tvPLbwISoRJ5B0C69r+PsPR4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m0SarxZDEzQR2xz8mdKon7eV1sg2/ZPMD0qG4TgFkUBQLhiY3nmnEY4ChxFj?=
 =?us-ascii?Q?ZDoRq4tszic3/350+59q8YT9xw9Iovdul0opYgngoqkl0MZQLrQClhtmb29G?=
 =?us-ascii?Q?ldXmD4mqObVtBhVP3E+j88U0/BwAgY15QkCtLZEUDbaoUKjM/fnGEjhP/rTc?=
 =?us-ascii?Q?TJfKQiVvQHcWSc06vbHBeXOrCtohtwJcNrZb8HipYG2mF7Yds3eVp3PhhA0U?=
 =?us-ascii?Q?JaF4AGe+p/xk+acsm+POt7SIx0my0q/+CzfkexkQHedle0QS3RGO8uOAYrpH?=
 =?us-ascii?Q?PYI3EEFhO8fGBWlF+p5O8KcvDthNYnftJ3Tgwzd2qEDY/y6pjnk3l7994rKV?=
 =?us-ascii?Q?UiQGXHyGm2qAhZ3iFUWE9Q/NwfqQGNWYxFi86jU6CE6rIdrZ5D0KpVwm9SPk?=
 =?us-ascii?Q?KM36XuVHatIg+gJaqHwsQnUZxkMToSQC3IhC5oRyVNpkXfummh+m+lVp0mUQ?=
 =?us-ascii?Q?tBOEl/qdC1UNLS7wZdjEo7qKqCKSzHOs+XU+KPDaCfbBLiG2zFVh0cqv7RJh?=
 =?us-ascii?Q?CtG2n32GBT5jWYO2boq7ZR8/UputIo7xjWNhU++eRfmjQqb8zhdQ+LpllFvk?=
 =?us-ascii?Q?+M9KsO1RJ4oNTuImDVcmKDSvJhLFLKqsrjWJfcCcDqweaDfgTfhMGr328rfc?=
 =?us-ascii?Q?vDv5OTN9ebTz/M+Q5qQ/8q28HlmbyEoHLhjqZ8/zkwmagL4YXbNXMgp0l72b?=
 =?us-ascii?Q?jBqTpcZGitaz3PJsSTBbs3jgN//DIQUbgRY8mb4WuP6g/GfBeJ5P0nVhchPI?=
 =?us-ascii?Q?4AsD9cq8EqhNxPwTrJjThl56pgV0+u1jMMqHBFax1cMxqJgTEkS2ffbF+yhP?=
 =?us-ascii?Q?orTDSuQ+UdUw0E44L9FuSy/SDi32sFxOKMrr9UTIvNq9qUYqZ4DNbOiQYPHp?=
 =?us-ascii?Q?xNfB2AFN5fPZjKGHjDjmYFoUEq0q5PF4KaXhWN4Mfaagfvvb3cBnPY2hYpd7?=
 =?us-ascii?Q?ebKRGvO9dtZE6/DVJ8FSn9bl4VXxYy4BuQpiYnFNhvByH7Kq6VOb8GCzaxgf?=
 =?us-ascii?Q?MVV+FnY8vzkDoF2ZOul9wRzEIDb2I4E4fk6HFPz/tWlvgqX8GUQD+NRjIJ4r?=
 =?us-ascii?Q?dhFDY9WxOApOitDG89//zTkqtIkVMel5PTXKIwtvK/EspJ6LEWNMArCAjKga?=
 =?us-ascii?Q?xYVd4cqkm+jsb/YsBKo1gXGDdHPLeZscRLWEqgh49P45r9r0DYgFDWATnuOb?=
 =?us-ascii?Q?xzI9ADYuMCEza3hMmtU78Jv+JVgM4vRtg+X1n3k1Hw/t7xpieKBcJlKQLIAb?=
 =?us-ascii?Q?zzPLSvRvwZKKVzAR++bZvBosm6RmNJOo3ZDDIWf2HK1anPG0H6mLRJygCWUE?=
 =?us-ascii?Q?8excN5z44yPUNSetF9uWkkskN+zkH6SFu9o58Peen75XBUcJCXHBBT04aYqr?=
 =?us-ascii?Q?KwA/g06TtZ3DzTxbypPdGLMXZgR+1Q9cneB2DpJHA0DPtM3Zpgnwn/I9KatB?=
 =?us-ascii?Q?EEkj/ydp0M4twY5i0BcNeQLcH5kAKr/kFzb197pJ2BFeYqEDRgZuO5NW7bbE?=
 =?us-ascii?Q?zjTZsCbkMA3k+tdkjeWDi2g+NLUyA/tZjWG4g2fqBvCIXX12z6onBA6jXM2z?=
 =?us-ascii?Q?csHuI5u+MOHHGP94QzlxOtLrPQiNq9SO+imVleJtJWNQB+Rkn+LR+0EpK/Qh?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96815be6-c10b-4374-41ae-08dc48d2d7f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:42:38.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZUjoljCrdF+pbt3vqSVUXdSMNyOGkHxyLpvzOwncIrMnKDEAOWl/HezLEeca8vNTEmlko2IuCOMawBqh7d7bEXcYUedItruixgaDVNKS5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 11:42:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15386



On 3/19/24 7:37 PM, Jan Kiszka wrote:
> On 19.03.24 19:18, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This avoids the following error during resizing a file system:
>>
>=20
> "Error: Success"? Or what should be here? :)

oops the error message is `Please run =E2=80=98e2fsck -f /dev/<disk>=E2=80=
=99 first`.
I had it once so I am not sure it is required.

Quirin
>=20
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/encrypt_partition.clevis.script   | 1 +
>>   .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_pa=
rtition.clevis.script
>> index 6e2713f..0bb6720 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle=
vis.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle=
vis.script
>> @@ -81,6 +81,7 @@ reencrypt_existing_partition() {
>>   	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
>>   	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
>>   	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
>> +	e2fsck -f "$1"
>>   	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>>   		panic "reencryption of filesystem $1 cannot continue!"
>>   	fi
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_p=
artition.systemd.script
>> index 2e6691a..9809c87 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sys=
temd.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sys=
temd.script
>> @@ -94,6 +94,7 @@ reencrypt_existing_partition() {
>>   	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
>>   	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
>>   	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
>> +	e2fsck -f "$1"
>>   	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>>   		panic "reencryption of filesystem $1 cannot continue!"
>>   	fi
>=20
> Jan
>=20

