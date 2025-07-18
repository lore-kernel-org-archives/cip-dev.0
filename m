Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8175C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:49:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.18])
 by mx.groups.io with SMTP id smtpd.web11.574.1752850190372416510
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 07:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iIgS+rMA;
 spf=pass (domain: siemens.com, ip: 52.101.70.18, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3zLHi7rogFzQuab+8RqjAcU6EuqpSAy0bZgYhpDAueuurYIqCbYiLLWMAT2rqYQsymQVyD325L2INZdEu5pls4UMT7tmhvhZQb4qeeQRO+NBygQlgACvkJxTL19n0/WaeyO39F8X6yYXkj0nCawIxBn/t/eMJzZv0VGsk5gLCIsA3e5ticEynB/bX5u2GBq8Rf3DotQMPePt9zaxzS9SnVrYgKQUUAsoWIMfYekbNwa8OaG7fzUEuju1nCBjPZ/Mzvw1r6skAp95U0cVr6TOlkfzBkNcX3C7wXmJ13XOC/MMIUaz3gU8A5XV0TV63p5ZrmPeoH0EtvC+YBjpxy2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc8D8OPsHahIZ8YdITA+I6atU6KINFlvxyJpl5CjIBo=;
 b=v0h7WUNth8N3DzyDOOAFRYmlc3EHJffSN0vE6S0rP4e5iQetR77SjDsNqkZpxwictddL8b9aKDl9CR6XfV+xIP6/Djr/XaAE3p41cMs4U76H0bxObfFXqtNEwLWdR7wfR2P5Ph3takoTkgGm8Y3BF/dJUBCO5QLQr2FCEqQtNfSo4a6vYxE7ZOaFVWdUDCcJldzUopwxQD2K9aEm9QyulC0erLZ5LyJnGv3QqwP1IuEkMbhxZ9s5QmIQrLwkhrhvtWgTHLex6pqAFFRIcGV9hGvLhPKI4qPPXks5+8WTcMSALDOHEb2JLs21dZyySCoj3sykDq1KB97zcw42kHe4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc8D8OPsHahIZ8YdITA+I6atU6KINFlvxyJpl5CjIBo=;
 b=iIgS+rMAIgA30PS4uOqR2vjCq/ZHAH0FBIh+rm8l9E1HF6wAPr3spOtXJ3eY1cEp5hyrNrzYm0j7S6ksIJgKKqN7iMk+YgUUBr4E9tfCpXpsV2hsXyuP1je6+vc89HlU12JRYuunkUoIEMQav7wJRvjkpWkDHY6yTknU5dqhLNzd3Z4+MnE1ICBIh7BnHlNVPLhHug9xJPiRW56u4Py/He3b/XabdHDX/VdjfyF1Ev2yxzQ1GxuTlH7ijDOd3wKwLYD6hURqL9hBClkYicx3e1w5w+fEZChpLzQqm/cgkTaiGKCIISyV6y2Pch879khHWZbF93eyOJkbiZRBjRsZwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 14:49:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:49:46 +0000
Message-ID: <24bbed0d-daeb-453f-9663-bb3f712ac86b@siemens.com>
Date: Fri, 18 Jul 2025 16:49:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] immutable-rootfs: disable daily
 package update checks
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>
References: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
 <20250718101525.1270424-2-felix.moessbauer@siemens.com>
 <816a6e9c-9d3b-4cfa-a2f4-6cd685cde9df@siemens.com>
 <1fdb1d29524875f932d8b894b3904eecbba13190.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1fdb1d29524875f932d8b894b3904eecbba13190.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6794d054-c6e1-4be2-0189-08ddc60a5688
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kIV7qVU8qlW8C6u1tZKEffGbcecvMglQ0j9iwbVReD8qMVyfZoMUjZdvmf12?=
 =?us-ascii?Q?4jOg9cDa33WSnCq3EaNk8OoB3Wnz/jf29PWOUYeos5Cj0NJ5BK922lUGy/s2?=
 =?us-ascii?Q?YCL7q8yB5cbd7VuiLeXoxOF1oGM+7hkPFC/mewX1CB7JSL7puWP4D7PJrUm5?=
 =?us-ascii?Q?kpfl7wATGnL3sliZoKQ4jV5NZx0AV4Po86V3TDxtM1deio/if4oMoY50g9Z3?=
 =?us-ascii?Q?MWsr1QeJVjd92oHXivqCkzn6cA+FY3KIFRV3DnxYfV+sImlKEPvycw9p7Vi2?=
 =?us-ascii?Q?Rel/SvbBhAAc1xvtJWde5lTSSXPRGVIF2fYyK+veCDYQsVAe6z990BiE2V5O?=
 =?us-ascii?Q?Q4gf/O3q8GJwIWevS1DAZe8SjhPaugVKu2DWH/kzVxQBGnIyW7jROiHB0f2M?=
 =?us-ascii?Q?zyK06eQHhkb41cLIy3qjbo+HrOL/PI46CrRjwWRlHDRbX0/aCiQibMJEB1J3?=
 =?us-ascii?Q?piP0WnXW+G7uridWly2S6ybc5E3e3jV4i5uNvso68iaTaFFpelvYwc0lpHjF?=
 =?us-ascii?Q?UxLF7EOx/sSoJKBQu2eW1LNrmbCe5Uu1H+HWAAmZkI6F8vgNXgzI48lB4V6L?=
 =?us-ascii?Q?gy4ppDK69uUfVNl2hn/j/CFqeZlOBRyNri+V3+udbCiWp6xVRCOirXtTFS27?=
 =?us-ascii?Q?FrdFK9taV59Z3xJBXsUZpX4lzLIRyIwxPsxJzRRSgdH2MFAHfp8m3dbEWxIi?=
 =?us-ascii?Q?oSYpi3XdhtZrGRvkRKe4Sx7Oq5VUbQ4MNB49LZIBceiKlMPt2fTpKEjhtbRN?=
 =?us-ascii?Q?kyONWFxzXTg4PJ4DEiUlF8cnMxI8oiJUq8PtHvm0fJbhHFWNSLM1tkpzU2fo?=
 =?us-ascii?Q?zbgFPdC23h6yQxTmEFrMSgc5h1A3BYKCg6l9uUxiHyZA8maJygCk5yDF7ZkP?=
 =?us-ascii?Q?uhmhOS/Vhmx7rHX9mL8LS9f2OC9UJG3W1eYiQS4dFNQfvlqvuRQeJmkYhK2s?=
 =?us-ascii?Q?iXHrLSGTMoLc9d91FQDFEPA7EGc/EURuKEYQmrNrxHZMxz5bPcDZAPcnXv/g?=
 =?us-ascii?Q?CNisGlnweIdU5X4a12ydn2lwoo1ZLs325219q1gzXndgJpQemdWQn1JsK+Ib?=
 =?us-ascii?Q?m/1TuNmoIM2bT1Tcvdh3zJq2rZBa9S3Rm2cEjKdOxikkaVJtAFzN3ZHVzWDl?=
 =?us-ascii?Q?ZEeIM9oUw8je8k9aPRhqt34NrquNxKf5bVackjeAbN81QRagMey3a8T4H6xa?=
 =?us-ascii?Q?l5SouVIPtPpyMtlbNFo7sV0Y08wT1pPPyhp0Feg0TyNzocjnImhs+/xjBLnu?=
 =?us-ascii?Q?kNTu0kDDwYe+Kn2ibjNvBWR+OqIhXhcDCA39OwMDgp29KB9NDaar5G9UQyX2?=
 =?us-ascii?Q?s02iB9s1zMY+/SkHLqpzhC9G0tzQBV3TqN7bAfEHiZ3KUmtHOetVql/Uu6yP?=
 =?us-ascii?Q?dbTxV9N1WSFAEr2oKcnU/1qUe8wHvY4j+8RPHvG19QWewQ87FcY7GCnCRZlQ?=
 =?us-ascii?Q?A1njDjB3ctE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HbsXBTYVRoIl4XOQAfkfJVszIAOR2ZrRgOg7iwrHPRVajCISeXeStPMjF8h0?=
 =?us-ascii?Q?RWSnPiOH0CKB2Z+bSQMUo9FEg7tynZPoTi6rhw4ASDQph7/VLvJ6X/P9JNEL?=
 =?us-ascii?Q?gc1Kggo8H7d8EwhWj8Sn/zjLxA3q6Gw2rxWEYrBQV7CB/lhok+FVoSrXmoAA?=
 =?us-ascii?Q?zncaIUUGOCEGTDt4JzAK4V2Oa5UBK8BAswzLuEgMgC7r/846lfWVrg6TcqKs?=
 =?us-ascii?Q?Gw+hMiungljY61PLgTKjCSp00U3udkE/cuVdoiQQWjDj+1tILtlBNiDkmRc+?=
 =?us-ascii?Q?Fk+CdGCs4DGwC5AmTO4OZ4BMVxba29HCsaV7sBKYiC3RvmNBy2WuPNgCIqyy?=
 =?us-ascii?Q?1/gxAPv3muOQIldne9OIxZTrWF+ERR/jtZ8UUjauNMuH1bkbq/PIvrxIWULG?=
 =?us-ascii?Q?D/k08Z1yeA0jIfrGOuzouCsqG/+q0cL3ioJX4v+b78T6oK86Mpp3+z/UnBUC?=
 =?us-ascii?Q?cfRtN2U6qZI1XnfOk9rxSVRHLjWjUmPEOm2pTnZJn1vofTQpssNdvHEDWZRt?=
 =?us-ascii?Q?DYQCDx78ouSwhJcABesEpOt1v2OBgWiioyRQ05EOLUdxt4wnR+oTKYllthOr?=
 =?us-ascii?Q?T5pOTof2l8CwnywWxCOm9w1THNY7VX5nSp1NnJ92XR9OUHojjoDpceKs+EZk?=
 =?us-ascii?Q?Pt228a7upKc8p24zTXEAryAuInPrgOVwmhX7eT/1Mr+ZzAi9o9zG2siaFH2k?=
 =?us-ascii?Q?IQqvWgFB5gKNVkTKB0rVjyIvwL0kQoJFrWMTGcQDd6IhwoFmkh8C0GLN4j9J?=
 =?us-ascii?Q?mZyOYJ/OHSWRcUg+MIdxOo3Z/gUKh9JqiDz3XNRuFlJwNYwDdKDdESuU8ThM?=
 =?us-ascii?Q?QuH4dvSBGhALWeW5ax0n5GnHVtnqQz5/nWnW7wVbHmYqqfZ3eWqmLPXpOUcn?=
 =?us-ascii?Q?SOQD8ee+ROHPowmbKRJ6YT5oxaHZXkSi/vwxunRLoEfNhylGNRd5gNtIAT63?=
 =?us-ascii?Q?/RX1XqixHU3jvtUnptQz6Ma4ycJJhga0bvRRU6fu1dkPmjKxgh6EHRA0nxKX?=
 =?us-ascii?Q?XK1IWn1ZjEjo7O0c12dOGUM+VQfh+niOOuDwifWZRLYOCI1VH5abROJWaqr8?=
 =?us-ascii?Q?ITP90MKYNeX7JJ9n8xyIJc7Bwo/BpvZYSlqgvfs80m93Kl0cIc4O9W7EdNls?=
 =?us-ascii?Q?4QCPXnVdgbI579VSCPWhYyCVIyCMDWA0PwlfAYJ+B5CZkeSVYnNqfHgmLUrl?=
 =?us-ascii?Q?NNM8oycV15NG5RQW9r3VkpSHlLCxSzyW9MWtMf0dOXeUnpCQn9Me/7Ao6ujn?=
 =?us-ascii?Q?kw7w/dVDbMgRSEIkpWDW8axkDjozvd0AkImR7btBO4XLc4IuwuMVlfEQZv5Q?=
 =?us-ascii?Q?XkuIl0wJzsm75grBUZl5WEKi1goG97dtIldWulxx31oNEqaooXfYsauoGyiC?=
 =?us-ascii?Q?RMU5Mtpv8pZB1w1+/hzUhm9gsm/oum1o8YnpYaO2E6me91M692TH6JBAFHWI?=
 =?us-ascii?Q?8H8hTiTahwht3mlUMcBZjAO3JeyK/o44UsEUjXmzSmPuF+DkjmpUgqM3tRwY?=
 =?us-ascii?Q?ec0tHqw53A1ki8Cqb2NuHXWWMtRklvs7hIZYKttATeO1dDR1nHoY/ooGczZd?=
 =?us-ascii?Q?b5sfHivB8gNyKcB/ZxNm73OmHu4vsWRUYMcPCadu2fqAtYH/yN5GspDwOcQt?=
 =?us-ascii?Q?CjqisR5/B/SSQZbufKM2ZBI8i/NAOLt09h7HCG4vdlgoXi7nS8FSow04hJV+?=
 =?us-ascii?Q?sEYMSA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6794d054-c6e1-4be2-0189-08ddc60a5688
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:49:46.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0dfiCmbkgxw4cspSGkRwglGCxJeoL9WfOmlPE7viCpvdD7qYB3k8BUpfzwdBo6w/LubJd9GK4t4YNhG83KYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 14:49:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19569

On 18.07.25 13:36, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Fri, 2025-07-18 at 13:17 +0200, Jan Kiszka wrote:
>> On 18.07.25 12:15, Felix Moessbauer wrote:
>>> When running on an immutable rootfs, we don't allow package
>>> updates.
>>> Nonetheless, apt tries to update the daily package list and upgrade
>>> some
>>> packages. This is triggered by systemd timers, which are both
>>> manually
>>> registered in /etc, as well as deployed via systemd vendor presets.
>>> While it anyways makes no sense to run the update, it also might
>>> fail
>>> for various reasons, rendering the system "degraded" after some
>>> time.
>>>
>>> We disable the timers and also disable the dpkg database backup, as
>>> the
>>> database itself is also immutable.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>> PS: It is very unlikely, that we catch this kind of errors in our
>>> tests,
>>> as they only show up after running the system for some time. We
>>> further
>>> don't reliably know severe the impact on production systems is, as
>>> still
>>> many don't rely on the overall systemd state (e.g. to bless an
>>> update).
>>>
>>> Firmware updates: This patch will also cleanup the timers on
>>> deployments
>>> with an /etc overlay because:
>>>
>>> - the timers previously got installed by debian - hence are part of
>>> the
>>> =C2=A0 immutable rootfs (the lowerdir of /etc)
>>> - the systemd presets did not install the timers because they were
>>> =C2=A0 already installed - hence the files are not created in the
>>> upperdir.
>>>
>>> Best regards,
>>> Felix
>>>
>>> =C2=A0.../files/95-disable-package-updates.preset=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>>> =C2=A0recipes-core/immutable-rootfs/files/postinst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12
>>> ++++++++++++
>>> =C2=A0.../immutable-rootfs/immutable-rootfs_0.2.bb=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11
>>> ++++++++++-
>>> =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
>>> =C2=A0create mode 100644 recipes-core/immutable-rootfs/files/95-disable=
-
>>> package-updates.preset
>>> =C2=A0create mode 100644 recipes-core/immutable-rootfs/files/postinst
>>>
>>> diff --git a/recipes-core/immutable-rootfs/files/95-disable-
>>> package-updates.preset b/recipes-core/immutable-rootfs/files/95-
>>> disable-package-updates.preset
>>> new file mode 100644
>>> index 0000000..7e6e9ef
>>> --- /dev/null
>>> +++ b/recipes-core/immutable-rootfs/files/95-disable-package-
>>> updates.preset
>>> @@ -0,0 +1,3 @@
>>> +disable apt-daily.timer
>>> +disable apt-daily-upgrade.timer
>>> +disable dpkg-db-backup.timer
>>> diff --git a/recipes-core/immutable-rootfs/files/postinst
>>> b/recipes-core/immutable-rootfs/files/postinst
>>> new file mode 100644
>>> index 0000000..a6e1962
>>> --- /dev/null
>>> +++ b/recipes-core/immutable-rootfs/files/postinst
>>> @@ -0,0 +1,12 @@
>>> +#!/bin/sh
>>> +
>>> +set -e
>>> +
>>> +# These services are installed by "apt" to ensure the system
>>> receives
>>> +# updates. As we don't allow updates on an immutable system, we
>>> need
>>> +# to disable them.
>>> +deb-systemd-helper disable apt-daily.timer
>>> +deb-systemd-helper disable apt-daily-upgrade.timer
>>> +deb-systemd-helper disable dpkg-db-backup.timer
>>
>> What if someone downstream (and I hope eventually also in isar
>> upstream)
>> has dropped dpkg and apt from the system? Then this will fail
>> although
>> it should rather just be happily doing nothing.
>=20
> dpkg is an essential package - so dropping it is undefined behavior
> from Debian perspective. The postinst script is run by dpkg itself at
> install time, hence the last line can remain.
>=20
> I would even argue that the immutable-rootfs is a package that only is
> installed from within isar - and by that with apt (in fact it only
> works together with ISAR rootfs postprocess steps). If apt should be
> dropped, it has to be done later on. That does not break anything as
> disabling a service is just removing the symlink in /etc.
>=20
> For the sake of error checking, I propose to not drop the checks.
>=20

Right, no harm to expect from that because and dpkg/apt rip-out would be
after the installation, including maintainer script runs.

>>
>>> +
>>> +#DEBHELPER#
>>> diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
>>> b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
>>> index c847f44..85f6184 100644
>>> --- a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
>>> +++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
>>
>> Let's bump the recipe revision at this chance.
>=20
> If no v2 is needed, please do so while merging.
>=20

Done while merging the series.

Thanks,
Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

