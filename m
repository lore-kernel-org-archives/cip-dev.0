Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89ECA5FD4
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 16:17:02 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15216.1790871419916211214
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 09:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Egi9YwiY;
 spf=pass (domain: siemens.com, ip: 52.101.66.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFAOH9b33XXXaR+9YCw9oYTKjj9jb15/cndwPtabUu2wEoNbLxoQjsKTg5sWM3bMbKixJ27UwBlGnmMSi/+CufwDmsF/NKuEdPQT1B0SyQPtIHhb/EEHBvk3Nikia5gG/1mPusKQp70eTUYFhFDm+RQqlO+606vW+el1OtEcwJDTEhyi6ic3CbM7UnHUxYYB53qLNLZs78O5ftQCY7ZSDFmFPSeKLooVXrpMltgukememFeMAq1papspba/9B065CP/8Ass25w9OOn5JtBr+m1mYTIY/lQATDcSPnutavJDbuOwmPBPRNs0A6Xhu2gn5BIk6N3zwPXNPxuYhH1J1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n77iNZQqlgS5FjmIXEHwTlGszuduVjTzGP2Fs6Oy2+U=;
 b=Xi7hWrGl7iC2Cq8/eR0ItkSywQUryrCYWV3WWWvhDitf966LjWdVEkpoZX+ccm0KezvZz6cjFllPH60rB6uajBPPYCWKTRDtB1Wi/XvwNqE5vIQfZuPuugGwv7i4B8OTZCJba3qLlMnWWJi52sVhVBorsAYJgETTOjpvRoFZvR4qYywCRJKxOo3VQtGDFzoTAmsu0QLiyNME7N76d0lPQD8gL1HfqLY/MirMCXd/dtzogdBU6ohd0Z1JkYhkXbsHnF/vRL6MUaniI8i60RdgYqRmPidvKCFYXFuN+8LC0axAAq5wLx2ARjR/WF2D7Q+hqyKk5MUl4RmE3ivTZL5Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n77iNZQqlgS5FjmIXEHwTlGszuduVjTzGP2Fs6Oy2+U=;
 b=Egi9YwiYcuZm21lvjvWSHVFsRFwfoSvIrenA3rzKOxuc5+njFqFWiUuQKL26Lc8jvqKxseLg/CNimSve2HOTRqYhgnP85dT6pl6q1HGg1XTukwICeTqiquSuEghsBw7UIfMadnY+/YKzl0apBhb/ceA54blITpXJlQJuM770NQF/tRrqUugdasMB5AhzBUGkqsYG8/lJluLTcQmv7jtMpmbR8Y3jOx4TEdY26O/8JSCg45o8SZTbtJ42QqywCEvF0di4Ji/NTAKWsecgjlm1rhf+wBdQ5hMoB9U2RNa4ZJZIeJCZ3b/tugy9mjRhiqEiz5bAQeqljkPpA/mtkgsSBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:592::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 16:16:56 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 16:16:56 +0000
Message-ID: <8ca4f721-90d9-4615-9b0a-0b2a9585f901@siemens.com>
Date: Thu, 1 Oct 2026 18:16:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 7/7] initramfs-crypt-hook: Prevent
 encryption without secure boot
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <eee0dd79f2b78a061ee9a097d68a9e27cc805731.1787722904.git.jan.kiszka@siemens.com>
 <029504a1-bc85-4008-92b2-3eab2d845ed7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <029504a1-bc85-4008-92b2-3eab2d845ed7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a39d99-19bb-45eb-fee0-08df1fd76989
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|55112099003|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	/CWI5BOF120bAbtXWPCDGifo2scgasP+1UupQumfZv2Eg6YOK3cRz81GTAb2h5l0hA951s0JPEVvQYQqssskn65zmnfh2nBTEK3M0+T8eziue6NVv7VnuDDrt0N+R2rWQIO0CiEYC5bo3MWEw/GWFcQnitf8JCR5yt8XUUlXtOvdvX0x8bjaBh8jbOyQBFLsoiBiVqajYKXyz0qF0aYBd9TbwRUzh9+tlIVOF9netLcFVPIfYS3Pil4ccgLEFSRq7NvQoQ/eubpBvcwyaZ/jMejKzjNQ31L0MjRTtxp/4yVTok4cIQ8wJpH4Q5y/72FVGYESouMv/ycrQ+xrNEKS3EgyyCuKlPg9jI0uYI0ACSiiO9Q6DlgrVms1ZqLP3x/TrAWMx/zE9aMPZ5yHmLz23DJSjESYn3T0nwkSmqS/faMxPddmkgxsOi15qfI6kDuhBnmA7pbeSgMcB5dA3AiKbOnLJjY39bVHw7PiS4d5oPaOZsXJrPVf5C2ZoNESv+KD5p8KFLUB4h3NfMMlkxlqxelMtRLReq8gu0dRJPx495Tha2l+HRrC7bVH4xZCFw9xup+uPYTAHIY4BtSm3ymgJABYtsII0ao6CIQSa4sYdHHZko7P8279DoBJqw+gyTiwNaKC8PBqBflKXfuxtwQRRTYo/lthAvVc2KZIKrn5HiU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iPNTwQ6CAU6jkfsL7JsEolxidLOZUkjdi7MwTUqqDTD++Q4T7tjHIJtZhKbg?=
 =?us-ascii?Q?t/iwf7p9+bnYyMDjN9gyw41S1k+eYDkuwr85arLDfRcctKJ52WNkpzU7uByS?=
 =?us-ascii?Q?wNTAuKHeCFgm8yt18nPBEF1etfanClKWfc6fi1/5iNyJlFch0xvTv3jDiPv1?=
 =?us-ascii?Q?pmz236Xk2TFK/OG1nj6UoqBBO7qTrQlYRznfCt/BKEjEwhY5NHpVR2MnSIX+?=
 =?us-ascii?Q?q25EDR395TDFYlBkSx4u0/rqNBpLa97Y0XnRCAL05wcYdwNtUOcWgeLHOzQN?=
 =?us-ascii?Q?a5SKsb1DtcKGuW1j0nBK9YBZ+WVIl20u+IwNPB5emEeS2A0nPHoafh+p6qBQ?=
 =?us-ascii?Q?rT92FRvrbBHyxr2VBTzHYfFGN6GiHNEp6ZDc9QcC2uVWjGLVub25MY6ZGuLc?=
 =?us-ascii?Q?Xay0/pJyoeRAF1ASbLQWCGZ5xAIzNFfZSU+i63mOH75ml+SKRLLiZ/ub4c+a?=
 =?us-ascii?Q?gtFQJNqUMLE9qwFI/Cl91uURUgT+HKN+VArlXRjrqAgt9ErXJa2kLvI8Ok/9?=
 =?us-ascii?Q?wJ6XBn7Zz9mSx3704XclFtw8QXw/df8DvVFmiHPBZK95olZjhQg+uy3rIPvZ?=
 =?us-ascii?Q?dhHe5pjsdVfwm4RXv5gzyp2YJPlNZjVKdxE8wP4M8IC2TJl0ebfVIuFCgrcC?=
 =?us-ascii?Q?sCClaZvDZTVlY1vSa9LnDDertHayXXpeTVWxKOYdxM9q+gZZlt+VnbnlikoZ?=
 =?us-ascii?Q?a6I4jogVC14CA/uFFOdTG8KeL2lzLBWSYkLyLo8EMosfXNfLyuaFOA3WGtGW?=
 =?us-ascii?Q?W6GrHTxKzLKGdnekWwAhLLPC22GA8rgLHXQd1jlrElSSPP/9nTRwfs5mWKjn?=
 =?us-ascii?Q?+Hzjqcy5Z6GJaf+KugnK1eXSykktL8kH4Kd1WdwrIQj5XfBQALYFsY+OAcit?=
 =?us-ascii?Q?q0ece49bhO9PUnBEXxIlAy2KMYvbGI5Jhch2RQkXxdlaxuvgfxjh4VZosfXq?=
 =?us-ascii?Q?J0wL+1BQD9f+2DDRqyS+wK5nJKPu4HjGcnsDY00KHVhBeGb0EBpOBJgsAJuq?=
 =?us-ascii?Q?iGe8xSv5zERxlElXK7yvmeMCJCHZy1E8jiU0zmXalvjUlPoER1Jjl/9B9qy4?=
 =?us-ascii?Q?I1fhaazOQmG0+NBRksFEpH5Renr+tQLTnP6DLqEavSHm+4YOZYJeZK5XlL7N?=
 =?us-ascii?Q?R3HrNbUDPMla3Att6XfFXSrHlDgEpVfrnYg5/xayNVMIT/jgMuRo4BAX+iV0?=
 =?us-ascii?Q?FZNghyKACFT/w8UYkpA0XCRfVfLXpXFx8hu04AXcutCa3TFGDcRdHOucf8a1?=
 =?us-ascii?Q?haOoxEw43lv8sSf+7ipObuiZnncDcPQziNoj5go2t0V7d4noqX/oL+EzSka7?=
 =?us-ascii?Q?FKc71uoHaV9l7KktXzWBac0OUO9O0WUNsQ7P3GWGA+CJFJSpyqCYRElWG9C+?=
 =?us-ascii?Q?5mdYbfOCfwiJgKpYy3C1634XTgfYb4Qpf4Q5CdGlfrg2WHUabwYsme0qfx3A?=
 =?us-ascii?Q?yH/BeOin8UEc/rXUaZyb/RypVRk900JwIeNJzKMF31aU6h0BrnFsvFuJvDO2?=
 =?us-ascii?Q?pGQ3UVxnLaJyX5fJu6Rpoc3MpDZzr8atUxOyVFU6Y+SMYhpS94UwKQNl6VLX?=
 =?us-ascii?Q?hGgcM7OolYrLoRsuodaGmXPFjf7BBVLVcnJA9DEZfhXabGtx/Jt/Calg4+gc?=
 =?us-ascii?Q?ETmgtGuMKODqNks3EJ00wcy4By5+U7qnOXkA9KXwwNrmkFTY3/NktjMseG6M?=
 =?us-ascii?Q?+gl4WPB1LPWtLIAkjDA55B7WBaWOWohsJFJSxspeAA3cepp4Mhk7Yk9ZthFa?=
 =?us-ascii?Q?speDvLC47A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a39d99-19bb-45eb-fee0-08df1fd76989
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:16:55.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPtqM+63XCRoH7lJhohH6vE13qZ5KTvh2lJ1XIILP4A6u8R2g7vglJ4I2dN0UM9UxFlPLgeVIn1SGNu/rGNO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7502
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 16:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24398

On 01.10.26 11:41, Quirin Gylstorff wrote:
>=20
>=20
> On 8/26/26 7:41 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We so far allowed to run first-boot encryption in any secure boot state.
>> This remained unnoticed because the QEMU x86 machine is started with
>> keys provisioned, and the QEMU arm64 machine does not support measured
>> boot yet. The latter is fixed, and we also deploy keys during first boot
>> now if they aren't pre-deployed. Time to raise the bar and reject
>> generally insecure states.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 .../initramfs-crypt-hook/files/local-top-complete=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>> complete
>> index 7bc08e55..3312e632 100755
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -297,6 +297,10 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if ! secure_boot_enabled; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Secure boot disabled!=
 Must be enabled to ensure
>> correct key sealing."
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
> Why is this check execute for each encrypted partiton.
> We could test this in front of the loop?
>=20

We only want to enforce this rule when there is actually encryption
requested, and that requires to iterate over the entries.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

