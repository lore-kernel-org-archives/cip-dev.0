Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3172C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 10:57:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.12])
 by mx.groups.io with SMTP id smtpd.web10.18430.1739530676252404244
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 02:57:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HhcUdHmy;
 spf=pass (domain: siemens.com, ip: 52.101.66.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNiN0iFxF+RajDJLQxB9enfAhvOs+wmP8mF/edesCypQ/tma9wsMHf0V6pRR/U5RQbtZ97U7n4yTL6307guwhDxzWYnUCELj3rZYI8tKlRT2OgIgvUsdYdLMncYyhfHOC6WLV/pLYX04x1UMyerQqfPC1P9r/hBICP2MdCLB8l53eH8tYnfLHtVeSfWw7y7Neh/6HfKRLh7LzY1WRA/SSNPnp4xixZqCrFoWF0fDxIWtGtjTTP99A4oTLGB0UiYApGD6b4I6nXB1VUmZuCBHvqkNbAE7lWE6srMRwE9Xxcb1H4qS5jnPwZbJY0c+c5jikrtSnuglIPcJFn3rLQavIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaWCAsgHvb0oqH34kSH/WhE2mA7zFk7bsuIXAaKgLXo=;
 b=BETldrNnBHe95oT9FGJCO9XyDcYfF5bg9MLemjLFGosAGUAHKXtICuli67cHcaMDShULVEIJ/4Zd4NlLKiomveUltE8HmYnZFwu9cRrkL/IOEBOZii9OdrDPqnlTm7TraXirm6PGi/xZtaGBtuqSJQkPmiEEFubWwvIc0OOnsACksRVGo5rdjV3LpotnI0avzO/DFxSgMHHHvQ8WXH2OyCX/AOnVWwvEjOGMtEt5I5Rvpn80C5McuhNvT7d42FNmdZve52KPB2jLNrWYb9/gTlZ4QW7Adu2wqSjqVMdb7kEgahlUkb4G7WzJyVx1esEMksmNQW59+jrsyAr3k0u5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaWCAsgHvb0oqH34kSH/WhE2mA7zFk7bsuIXAaKgLXo=;
 b=HhcUdHmy386fhy4dqDWhzX8TcO2LwUy5qtrcu2uAh/ifkQU+MlMwq6trkrpBmGl2xStVl+TUe23y+YDqs4z9RcFHA5z76dsHchR4IAkUeL/twaa5sgwbdArVlLUcbgI1Y0zEzKkfIyOHsgt8XIv+iB8XoqEb+JfgL/tNA+iNDBZHVSJ295THaJ9QtU6UpSzD8jkxsyu6/7ZQq0e+JudsJbq9SuVqpm+gXvs2EmBItEHhIgAj26Zu91dg9bfm8RKvz3uvAo0pnHFJMi394Pfnd/tEhpjNLCGh5iJ5/fMpPv5zGYyl19c6oLP+5kpIF5rItdAXKORgxcWdQiW9Xv6r3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Fri, 14 Feb
 2025 10:57:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 10:57:52 +0000
Message-ID: <001f5146-d574-4d66-a85d-723b3d061379@siemens.com>
Date: Fri, 14 Feb 2025 11:57:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip117
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>
CC: "pavel@denx.de" <pavel@denx.de>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1733593115.596079.1739239912119@webmail.strato.de>
 <CANgtXuPttHLDcdO7U-WaNS3tTeRUkDB6LBiTt1T0mvsCMjKwOA@mail.gmail.com>
 <2463f342-16cc-4606-acb9-c1339f886253@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2463f342-16cc-4606-acb9-c1339f886253@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e52e480-5c79-4659-7903-08dd4ce66ddb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hH80aoJZ7E963DB1O3bBllyrQ/ydQu4QyXSxIX5hlB7YCYItyccb5DclyNfq?=
 =?us-ascii?Q?QZ35DIZvk/coJAIrV1uhWaEo30EXgJ7IFmDn6WTaP8S2hnoQvyGWbVC6/2s7?=
 =?us-ascii?Q?4OHdxzs9DTFLoVh+i8NPDIYrWzjvTh6gdNbA0XD8uUfVtamalSvVE4Tzynrs?=
 =?us-ascii?Q?5YYQjQM4n5HwNKddDzVQZpyK4iiTTL1LOr33A84HcqWhwQuOs9XOXSiReaN8?=
 =?us-ascii?Q?1mHe69MrNWDd0npZQWAVkgZy48DWhWvX1ytatimtOqKFwG9exeHSMUo1Waly?=
 =?us-ascii?Q?1ZZ4I6/BK8qkQMb3f31Rob0jCWah25tlcO4IZTMNlZND2TQbA9G/SPecXcFo?=
 =?us-ascii?Q?FW4uTIDNfr2ONxGrSgdQ9F/YjgHWBT5dBE/O9E0afgOxBKLqntc5AE6pBnU9?=
 =?us-ascii?Q?4q+Ebyi3OXr3w7AToogrku4KbftxGANI7lFrmnjHSfpmi6EDKhwPC4dczJos?=
 =?us-ascii?Q?8Tc9XmawCqwv+MCCialrDCsDZxZTOokECCP1gHmB+OKMfFE+rwc+JPNYZaD7?=
 =?us-ascii?Q?XNW9lJY+fnCua4o3EOt06kS9zHu6fKIic4ZGTl78ht+MhzEh6j/Q5rxET388?=
 =?us-ascii?Q?GcVwrAP62ZxSpIF4wmhCpo+UVVjlLIfYjZua8tBAbkCThGkBG0EIeRiZWZep?=
 =?us-ascii?Q?gby6rL/yqOBUvgmNpm6/Z8ckd9cnGXzdAKy1EvmydYlWcKxaESwoNhKIUMhH?=
 =?us-ascii?Q?JmSZsp2p5TCaNbgmfKhoysRjMKH6iVkZEBSIbfFq7pEAwz8dyBPVtkgKKkJX?=
 =?us-ascii?Q?0vujVDJJT5BhQ2iOqhdd0q2pyBAgnPQS3mC8TMQrW7njXFdYdAhVOtSafKPi?=
 =?us-ascii?Q?eQfjpPGbDc6YxuWNmLJR29OqZLKaR02pF15AkngE9mitfBErE4XtJQuWA8eq?=
 =?us-ascii?Q?4WP75JQAfyVXSjxZhQbIT4584P9ZX/W5paFBsZDUPOMoitpxmm3EwbFXuJ5S?=
 =?us-ascii?Q?qDYvijz8cl17uqI0VItzrPkPqSxD1hbX3vCSS/zpfjGYpTUn9d0KfxzMssMj?=
 =?us-ascii?Q?+yhbmPiv/tnLJtuI4kWTgud936EDMGL1cusvxnjfBmFLUk2Xis47ktIhUb8x?=
 =?us-ascii?Q?MV0gb+cx1uqKzjvj5WcKOXUNrcaWOdysB7h0v6mjmuhHKctf3dRK02mCTN3b?=
 =?us-ascii?Q?77eqJdkSfFYrw5jt68D1W0IMtDbkMr2I9J/wlgvihNsKR5+D4N5NXWNz9b+G?=
 =?us-ascii?Q?AE4EM8Q8w1eBeg621LzXDHzOhEcQIm+6nXSBg0Pn+MyDsUpIOUr+j9+mAPeb?=
 =?us-ascii?Q?nVC2LKEtfPAE919G1PvlsI7lrcOyQe0ztu0sgEd7ADuTZj5ug4TqxDi7AqNX?=
 =?us-ascii?Q?x5suOdWkVwCR+kXCUDxX75StVZlnrM8nGFsGUp8UXgwz4b8uPSzYvZTcNAgX?=
 =?us-ascii?Q?HVLn1S3iq/xo7pq2rc1ZOOB3/A9e?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+VI4jq+KLdBhPiKqblDF3ZW/Tn8Q8y5aDV/anblu9Kxzs0X6vXMsLY4v81Vh?=
 =?us-ascii?Q?p3MNEDopPT5QBRmTaqvo8T2JE/4UKM17hRiHrsK1QJp2wzfZnJo6a24BfLwZ?=
 =?us-ascii?Q?9Co3Gc6tRpuC2LLdcwbxGLKCuhwzT+i6uk7lxO68dr73sh1i09SPz47X2zWG?=
 =?us-ascii?Q?cQUjnhyruMwCLCQnFyG+BCVZzMx6iVCN4VylTLWZA5oJHDo8Cvk7FfqNKAkR?=
 =?us-ascii?Q?Kmdms8ealmxUXOSEYtTaTXh9ZEx5165Bkw+ETQhatZrDFM0IZJmijY1dM/wo?=
 =?us-ascii?Q?5pVPgMSKjiixbW7bBYbiUDzPJTb+hoPIxeJ/oRBOl0a6trHJ4Y6g6OmZwRGy?=
 =?us-ascii?Q?gPwAoVOvpU3h30BHy7e8c2OUQvgzigL3iy42rXZLzxsCFyBDyzGP5oPtTTzU?=
 =?us-ascii?Q?gqsc0nT52izy0LLaBtHJeOoJdO2GUYeOkqdo+auVCbG1u5xss9Q5g0VI8Q58?=
 =?us-ascii?Q?7oCz5FlaPMrQyOuFwasUU+nsJx4rVUNiWdSnExYgxQSv14lY0NKKTqXuN5Op?=
 =?us-ascii?Q?byWBAzmz+/yBLd5tQpGPzSuQjE1yMGjD4GlkpePABMBPp0YVMNux/P2g2lFw?=
 =?us-ascii?Q?nW5rNK8bxbq9ZMm/FRJzLbiZMFqP59zubY+Z65Q47EeH7uUH9cv8YdvUOCEp?=
 =?us-ascii?Q?gR1xVXPgQ8eCANil0Ct4a2NX3V7HMXR2BJmNW9u1lSWZrMRL39kyJ970OlH8?=
 =?us-ascii?Q?uNpCquA1KBNZ52g1uvetB9RkiIBwK0Yqd9FDEIjHtBTvj3AK+hTlg5uNG6mM?=
 =?us-ascii?Q?X8XtM0mQE3SBYrAnF3ZFw77RF2qqOB5Dv3GvKeipCNl31DAk7VUm4ZhpxhbW?=
 =?us-ascii?Q?mL+lCvLGnD7KDNGVMt2P2+l2k+LzgyYkHggVC8pUvkGIiK3eJXZAz/xe5b1J?=
 =?us-ascii?Q?utIZWs0AsH7v3/7UpdG/fjcXB+O5kS/zL1TSTH2NGaJ4ufGUPa7khk9I+kSN?=
 =?us-ascii?Q?/INeahjUgWJEnCsDYXhQyhKggYVtznpPIQKlTmeqPZg5krz0AQMwnjiTRgQf?=
 =?us-ascii?Q?eXmxL7AyxCaTxPxsS5/0u56xx8mh4L44N7CufodAGLo2EL8+NaCxy/pa261o?=
 =?us-ascii?Q?9+2/I5zieQAsXoSbogylmA3Qqhp/Z/kcD1Uvcq+XyauwDbOTpEsuLbhiuufB?=
 =?us-ascii?Q?c+or7kcFmKkwTa6MKGn1NlwhfiFo2l9YWyBM8f4rnF0GpnOLBidHKG8MnTaz?=
 =?us-ascii?Q?MNOs3BsQClYsBSVtG/02leHCejdZEPMYxBDwutjwgTYCDK+KjfKBAirtF9EU?=
 =?us-ascii?Q?rT4UdhzvDns/IvtrbE1XKJ/GzdLFQttI/6kXFjO1slNbr2O0v/dY4M/Kahq9?=
 =?us-ascii?Q?WgmReBGfcoCgJaT7dR9+VpXhDxZ1Xvb21OIfqm/+gxuTX5jQ/WPSaiF40qtS?=
 =?us-ascii?Q?imzbxCPQVlZgwz+Ihtu0K7dvmFEr7k6NZDmzmcm4qPOfOUu8/FYxuYf2J4Kh?=
 =?us-ascii?Q?Gx7bhmxwNJzeDJZi5R6hAtC6jxRqOcJI5kbgGHP08jtBa64ClhoZJKR4QYn+?=
 =?us-ascii?Q?ApbIUOfyTHGy67KcI02/13xKZcNCcJ5sdfFvYvjXIKplE60DUqdEM9wkqDiZ?=
 =?us-ascii?Q?DiQdlbHkzsWcF7H+uKI5/j0YOklGRfSI/V6UvqjSdbXcAXBxXLj/fZntIEdW?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e52e480-5c79-4659-7903-08dd4ce66ddb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:57:52.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA/u7qyHmGnDKDvGjVXPiv2UBCVoW8O+slm/xNHh0Iq8Y5ejHhxTF8WD31R4Pt7VFlD2lAHJoekbMGydaG4jkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5274
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 10:57:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17839

On 14.02.25 11:40, Jan Kiszka wrote:
> On 14.02.25 11:18, Arisu Tachibana wrote:
>> On Tue, Feb 11, 2025 at 11:12=E2=80=AFAM Ulrich Hecht via
>> lists.cip-project.org <uli=3Dfpond.eu@lists.cip-project.org> wrote:
>>>
>>> Hi,
>>>
>>> the CIP kernel team has released Linux kernel v4.19.325-cip117. The lin=
ux-4.19.y-cip tree's base version has been updated to v4.19-st1. The trees =
are up-to-date with kernel 5.4.289. This is the first 4.19 release maintain=
ed exclusively by CIP
>>
>> I noticed that v4.19.325-cip117 and v4.19-st1 tags are both a lightweigh=
t tag,
>> instead of the usual annotated tag with the PGP signature.
>> Same is for linux-4.4.y-cip branch.
>>
>=20
> Thanks for pointing out! Ulrich, please fix and please use a scripted
> release process in the future if this isn't the case yet to avoid mistake=
s.
>=20

Uli, seems no release tag of yours for 4.4 and now 4.19 was signed so
far. Our tarballs are, though, because kernel.org enforces this. But we
should do the same for release tags.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

