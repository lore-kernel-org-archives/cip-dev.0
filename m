Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF72C982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 08:07:39 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6442.1789718854765964124
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 01:07:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ISPQSeM1;
 spf=pass (domain: siemens.com, ip: 52.101.70.17, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvhW9FOsYi9H09M8fWJpbW/7muEY1Fg1o6rGEzZwJvj6SYr9SaycRDoVIbWRzbkU0S/f7LdXG6Jh38uIfuRxPgiJ75kQIjC1OfRgWrMleyMAHB1oCioSbFyP6ixyfMMk754OuFvB3dnchTOL6g88MTDb5e1FKtdy3lFJso+H+VJqiJ73/+4/xi0sfCq7i1b6hCu0jZlcq72c2nBLNuqvd5IFT9Z9H9BIFZ9/20mK7WjFMfeqrzJTkrrtNXWwZcS+3SalxkenXhx95/wNK4nRcn/V5a22zKohbIVmr4xi/6jeNNCJ2uwVI0vzM353ySabBERcCz2bblc+An3LTPQTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYtbXc00QA+52/uYIZrFj3nukV7yypZQydjF7GQxYdc=;
 b=y4cwSajS2NAlEk31dSady8pYsqKXHJuUnude2JeldJq7qorrvrnQQSm1J0WqjIhdPtKNYJFiyt1RNrtFSdUhzUC5rqMEYgECFUPlewpyt+ojq2EyzXPR5Lixzz+XB5y/OyhE/A75c830FsTzPwRp9bUAN1TiCJ2oUcB01X1jTSMyTiniGO++UR/RgtJ+7D6/xv6hiJS0sgrDOoCDVa8fIPpErz++yPfdEFG/Gd9guAxh9IQTWhLSiPamXRq/eIG1B6KSRmKngujfe1+dmbZu0eRCf5C2DnarDdMMex8M//DrHLaEsS1ZrlrvWUBkRvec15LJfiHblbtSaMamJj+AGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYtbXc00QA+52/uYIZrFj3nukV7yypZQydjF7GQxYdc=;
 b=ISPQSeM1Vheny7vdVrifIIH+IP1qp9kVHACl+sGtG14/GtiVu5FV/ruhlGlYv+dx3KHKJcv2tqOPtbaRJwx7TrwIQoG9KlQboN25MoO0tMQm2046eofkRBmguAc7WfIUqfinEw7XqfNUfbeLX4aNyDC49GRuxOZ019vMfu+RRfMpnYdB2pbEm8fIkkOmG2rLCxxgaPmDYQmo/cWywXoxcv9SrPEBiK7PuB2Y7I0zHdFzO8WmqtpYsoEajsZw/xz5PxkTFed3fEDGOiBmzyy1D9mmcTp41F8JDC7hcYVB8RMBoegjBIWeycGcjRsKWySTjXuKJS/CHZxwEnH/UOGsRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by GVXPR10MB8341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 08:07:29 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 08:07:29 +0000
Message-ID: <dfe404a4-1799-45c8-9ca0-01b9bbc4fab2@siemens.com>
Date: Fri, 18 Sep 2026 10:07:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add
 option to clear partition before new fs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
 <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
 <658067cd-ff46-4ea7-b61d-f65aadaf76b8@siemens.com>
 <fd80eb75-c6d1-4485-8e14-6950d95d0b11@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <fd80eb75-c6d1-4485-8e14-6950d95d0b11@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0112.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::6) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|GVXPR10MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 130ad520-719c-46ee-5efa-08df155be24a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|5023799004|4143699003|11063799006|10067099003|56012099006|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	oHnH3GS4MwQajKBnqhqEhsD61cJ73JEv65wcn7f2WYjNXves0VqcdmShYBSOkic3lnCmKqIR2RmTmjpjXCmMNq3GJNND9u1ku89DPqsL31dJfZL4Q3kURtldAntWAq8cZHa72VyUIid0FO3ZrX9IqsQb1tlbFtzJ7xumWIbLBh3sa0X7fvAX1nx4xHg+KDj9IKt33LFFVWt2+i/dMOW4+UwZyVwE1ufF4cFICl5mdct28aPQAarGyEvDtk++CMom3GjbotFRHcNKRa3rW4/ywtpanVcl+UPzRg/mMchjCyJcYDoBKWB87Khf4gz3OxQK19EiKMN47uqG1ZpxUUJd5XFfzjgWTdJ08wh+ZHemE097Qq2BieC9+HcKiJ5COCK0hXD8t3xs/6BUxttoki3gm2RciMjDX1mdTRBo5B23tCO4XwOs80HR/8HP0RRHkdnpV6cLlppjcaO87X5+g97kFhua8TBz/rGOq//Z8/R8Pw3FUkxzAwpHyyNCueXnehGD17LRoH9++nQte5A9lfOHBgyTjsfAOrvL/sJzZHspoYKykYkInniaMSFVSGifc1mahsgP8CV/KGiZ34Q6xjgdYG3Ay69WcLEO90slSmh1y9hodl5tGp/rVrRC3XB50Kpu1GswhEU9eQGiQChA/rTOFr2DiQQw45ghNjfFgjA52l0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8ZwlaBbzBon1jcy8JfrmgYiM2CfvbvpI5AjZgUn1dvvt4R5Bucq8IXzvAbln?=
 =?us-ascii?Q?IJuJ12axapznkMpwBwoEj7JHQOFCp1Y1uQwAWpchsXelhOohozhG8+2oJVNi?=
 =?us-ascii?Q?pdD+JM7CzZmD+03ur9s3SMPoFNBrlmktW6rFEz+60UqPjawfS3+HHeVv0I98?=
 =?us-ascii?Q?RyQyuSuZa9ZHUcdYKy3RQ8uuTRj9xRZaGYTQZwHytaN1nWRn6h6gZxQnAzR5?=
 =?us-ascii?Q?sOrS59w4i4Npcr5FQ4dCtLqNJrUd8CyYnwujzTeAi85RYp3tYj8lC5OM+3gb?=
 =?us-ascii?Q?arFZHFGaChJxH9ki31cA7CeR0bJj2OMKOwondYFQsCcKGILwbOyqi/2s+u7A?=
 =?us-ascii?Q?ddmJcMBxTBx8jhFZ1/gyu74gsTgdRouOvEx2Kqc6QTkaXddhwNfkarjZzHSN?=
 =?us-ascii?Q?M1kzz/slZwZThzrDev5/bOviGG/DNoTlcStPakSmf+LK2SWPBBM9nuG5cmFF?=
 =?us-ascii?Q?r4Ly/7GmRLziDSzeISTKgzhzbYovTqoQJntjPjELLLQwpPRiSlfdzHb8MMkJ?=
 =?us-ascii?Q?uGKymKtOlu8UGiPXF6af4Cp5dWnp4tcexUvUPnaRCRDZB9vhno66dXNX8oMb?=
 =?us-ascii?Q?6wDHSdivcYEv9CMnx2seBp4KzQqX+RsUZxbe6I5kGJiGtZwjGuEXpNcUCKKN?=
 =?us-ascii?Q?mMk+8P3NxD6jPRaSzxOaJdoqDBSGEkeeJfrnl2R7Lzn4B7jO6WzvmQG+weHD?=
 =?us-ascii?Q?VI2VgnXitXotfZLP/Hg1JjpGod686Esv6FV/4qBJvrlikyojw2Wy+vwgU3PV?=
 =?us-ascii?Q?qrEc5hLjL343ChSYMBlYvvfvGL6+zyZxQbFBPD0HoQRpVkw0i9X3yxjmFd6W?=
 =?us-ascii?Q?5BRh9Dc7hUtma9+B2r3cQwTKmDc1MeYcCKppDjdUVhc8mkSKyFuhloFYuukS?=
 =?us-ascii?Q?ZoWcxLoPkmaTv1mBnsu3IGOVv/ehlhcH4JJnLj9Gf0LRE837w8lEJaZy35Ao?=
 =?us-ascii?Q?dNlDXkVsNaKYIVNAL6lOfXZ+dTGwiqgG7BRK/EDAshY1tpwPpNa+7Vw+Mx3E?=
 =?us-ascii?Q?ww0D9tn0PqGpueElvROEZwUGTmE0uTYEoaU9XA7bJDgsozwIateOK2LgVCzZ?=
 =?us-ascii?Q?fhdjdV3PTvsB64U7JVbLC+B//HcPjqNKGtoIccHXH/cMkXS/+pKUaoZ/vrG8?=
 =?us-ascii?Q?jgof3bKBrrnS2cMnteTEFo7w+eyZ6wECHKYr2mbMcKQSH+FSpm0UtPxO4dXq?=
 =?us-ascii?Q?tiwHvFMBQYhwbVt1YE1AYSPBYON21KU+2Xs1EvwPmF3M0xC5UQ5lGSA4Rkj7?=
 =?us-ascii?Q?4ZG+pj4Agm/tk0L5EJAiWVXBJSCFACsqsZK7dQzlhoqnFauep8eP54GoZDe4?=
 =?us-ascii?Q?IqzQq8naNtqaP8AWGUE57col1yEFj5Z412BSjIze2QDtWKwWPktaytUJ/KUL?=
 =?us-ascii?Q?rnmECpIj0iMnJz3joZDQ1rph8s2x6BuEaXuHaUdsrBJSTCOFiU1+mBnVYDwN?=
 =?us-ascii?Q?HG1b+Fxkmh0xJwDk2OmRf+QxvK2OwnS++BpOsqkD29GYCipDK1IuLcQzQYpO?=
 =?us-ascii?Q?oBTVCTix3I8uMQEkMC5zU72Sm8JdgF0i7T1W9lt+gDYz+AGjcuK8S+fvsBHB?=
 =?us-ascii?Q?duR7pJCgxBTcCNLJgiG2AREEzXek1Kk39iGWbfCR7s5IkoQIqu8/jOjYMQmi?=
 =?us-ascii?Q?7wtsfnLCPSNIPSgKR+r59dVn+aEwLUmYVBg1siC9bdrzaFN58A05b9ZDK/9N?=
 =?us-ascii?Q?T/8WeVkHm27z3T7/echlopPCTP/r+juiK2fwHPQJIRW1dFe1OCrggWvuAgmc?=
 =?us-ascii?Q?NAf+nltu2IIuOpzVOHvq3LdtTWdqDig=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130ad520-719c-46ee-5efa-08df155be24a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:07:29.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9nUCHq1m0v7+E9kt4rIgjKpEwUBDwFnv8Q/xzFObWiLLYC4LMWCeZzSQ1zP2URo3PdOM94Yw5JEyBM7uYuX30uT1bNKrfvE7eoN+j+CMcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 08:07:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24238



Am 18.09.2026 um 09:40 schrieb Quirin Gylstorff:
>=20
>=20
> On 8/28/26 9:35 AM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>
>>
>> Am 25.08.2026 um 16:57 schrieb Jan Kiszka:
>>> On 25.08.26 16:37, Quirin Gylstorff wrote:
>>>> This ensures that the data cannot be accessed after a factory reset.
>>>> To clear a device, attach `:clear` to the device string in the variabl=
e
>>>> `INITRAMFS_FACTORY_RESET_DEVICES`, for example:
>>>>
>>>> ```
>>>> INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:clea=
r"
>>>> ```
>>>
>>> Why this extra control? Why not clear automatically when there is no
>>> encryption or there is no TPM clearing?
>>
>> Second, that!
>>
>>>
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0 .../files/factory-reset-script.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 69 ++++++++++++++=20
>>>> +----
>>>> =C2=A0 .../files/reset-env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
>>>> =C2=A0 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 21 +++---
>>>> =C2=A0 3 files changed, 69 insertions(+), 23 deletions(-)
>>>> =C2=A0 rename recipes-initramfs/initramfs-factory-reset-hook/{initramf=
s-=20
>>>> factory-reset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (7=
3%)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/=20
>>>> factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-=20
>>>> reset-hook/files/factory-reset-script.tmpl
>>>> index 94b5f8b0..8f95d780 100644
>>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-=20
>>>> reset-script.tmpl
>>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-=20
>>>> reset-script.tmpl
>>>> @@ -2,7 +2,7 @@
>>>> =C2=A0 #
>>>> =C2=A0 # CIP Core, generic profile
>>>> =C2=A0 #
>>>> -# Copyright (c) Siemens AG, 2025
>>>> +# Copyright (c) Siemens AG, 2025 - 2026
>>>> =C2=A0 #
>>>> =C2=A0 # Authors:
>>>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> @@ -13,11 +13,27 @@
>>>> =C2=A0 . /scripts/cip-initramfs-functions
>>>> +# entries of INITRAMFS_FACTORY_RESET_DEVICES have the form
>>>> +# <device>[:clear] - return the device part
>>>> +target_device_of()
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 echo "${1%%:*}"
>>>> +}
>>>> +
>>>> +# return the option part of an INITRAMFS_FACTORY_RESET_DEVICES entry
>>>> +target_option_of()
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 case "$1" in
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *:*) echo "${1#*:}" ;;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *) echo "" ;;
>>>> +=C2=A0=C2=A0=C2=A0 esac
>>>> +}
>>>> +
>>>> =C2=A0 check_partitions()
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found=3D0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for partition in ${INITRAMFS_FACTORY_RE=
SET_DEVICES}; do
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if blkid | grep -q "$(base=
name $partition)"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if blkid | grep -q "$(base=
name "$(target_device_of=20
>>>> "$partition")")"; then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 found=3D$((found + 1))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>> @@ -30,23 +46,34 @@ check_partitions()
>>>> =C2=A0 target_devices=3D"${INITRAMFS_FACTORY_RESET_DEVICES}"
>>>> =C2=A0 wait_30sec_for_condition check_partitions
>>>> -
>>>
>>> Keep this.
>>>
>>>> =C2=A0 if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-=
=20
>>>> reset"; then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Factory Reset"
>>>> +=C2=A0=C2=A0=C2=A0 # service watchdog in the background during length=
y re-encryption
>>>> +=C2=A0=C2=A0=C2=A0 start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}=
"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for target in ${target_devices}; do
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Reset devic=
e: $target"
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${=
target}")
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$target" in
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_device=3D$(target_d=
evice_of "$target")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_option=3D$(target_o=
ption_of "$target")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "${target_option}" in
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ""=
|clear) ;;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Unknown option '${target_option}'=20
>>>> for target '$target_device' - ignored"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target_option=3D""
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_begin_msg "Reset devic=
e: $target_device"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${=
target_device}")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$target_device" in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *by-partlabel*)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D"$(basename "${target}" )"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D"$(basename "${target_device}" )"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D$(blkid --match-tag LABEL "$target" | awk -F=
=3D=20
>>>> '{gsub(/"/,"");print $2}' )
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 label=3D$(blkid --match-tag LABEL "$target_device" |=
=20
>>>> awk -F=3D '{gsub(/"/,"");print $2}' )
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "${label}" ]; then
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not fi=
nd any label=C2=A0 for=20
>>>> target '$target'"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not fi=
nd any label for=20
>>>> target '$target_device'"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$fs_type"=
 =3D "luks" ]; then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # after this the data on the encrypted pa=
rtition
>>>> @@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete |=20
>>>> grep -q "factory-reset"; th
>>
>> tpm2_clear is omitted from the diff output here. But wasn't it more=20
>> robust to put it at the very end (outside the target_devices loop)
>=20
> That I would=C2=A0 solve outside of the patchset.

Fine for me. More to come in [1]

>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # use a variable from the reset-env to se=
t it
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_type=3D"$INITRAMFS_FACTORY_RESET_LUKS_=
FORMAT_TYPE"
>>
>> Can we derive this from the actual device. Setup up a temp device-=20
>> mapper to resolve the actual fs_type of the device. That way multiple=20
>> different file systems for encrypted partitions are supported as well.
>=20
> No we cannot as we need to open the device.

That's what I described. 1. Setup the device 2. get the fstype info.
I admit, that requires some refactoring, but solves the limitations we=20
have with `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`.

Probably, like above, nothing we need to fix in this patchset, but we=20
should continue working on that. Also in alginment with findings from [1]

1: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/164

>=20
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target=3D$(find /dev/mapper -iname "*$label")
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${target}")
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 echo "luks device detected use $target"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 target_device=3D$(find /dev/mapper -iname "*$label")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_type=3D$(get_fstype "${target_device}")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 echo "luks device detected use $target_device"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "${target_option}" =
=3D "clear" ]; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
g_begin_msg "Clear device $target_device"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
vice_size=3D$(blockdev --getsz "${target_device}")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ! dd if=3D/dev/zero of=3D"${target_device}" bs=3D512 \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count=3D"${device_size}" conv=
=3Dfsync; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Could not clear partition=20
>>>> $target_device"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
g_end_msg "Finished clearing device $target_device"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ${fs_type}=
 in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ext*)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mke2fs -L "${label}" -F -t ext4=20
>>>> "${target_device}"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mkfs.btrfs -L "${label}" --force "${target}"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /sbin/mkfs.btrfs -L "${label}" --force=20
>>>> "${target_device}"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_warning_msg "Unrecognized filesystem =
type=20
>>>> ${fs_type} - could not format"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Reset device:=
 $target"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Reset device:=
 $target_device"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_end_msg "Factory Reset"
>>>> =C2=A0 fi
>>>> +stop_watchdog
>>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/=20
>>>> reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/=20
>>>> files/reset-env.tmpl
>>>> index 07e2376a..663b0af0 100644
>>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-=20
>>>> env.tmpl
>>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-=20
>>>> env.tmpl
>>>> @@ -2,5 +2,7 @@
>>>> =C2=A0 #
>>>> =C2=A0 # SPDX-License-Identifier: MIT
>>>> =C2=A0 #
>>>> +WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
>>>> +SETUP_TIMEOUT=3D"${INITRAMFS_SETUP_TIMEOUT}"
>>>> =C2=A0 INITRAMFS_FACTORY_RESET_DEVICES=3D"${INITRAMFS_FACTORY_RESET_DE=
VICES}"
>>>> INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D"${INITRAMFS_FACTORY_RESET_=
LUKS_FORMAT_TYPE}"
>>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/=20
>>>> initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-=20
>>>> factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
>>>> similarity index 73%
>>>> rename from recipes-initramfs/initramfs-factory-reset-hook/=20
>>>> initramfs- factory-reset-hook_0.3.bb
>>>> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>>> factory-reset-hook_0.4.bb
>>>> index 670725b7..c192c38c 100644
>>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>>> factory-reset-hook_0.3.bb
>>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-=20
>>>> factory-reset-hook_0.4.bb
>>>> @@ -1,7 +1,7 @@
>>>> =C2=A0 #
>>>> =C2=A0 # CIP Core, generic profile
>>>> =C2=A0 #
>>>> -# Copyright (c) Siemens AG, 2025
>>>> +# Copyright (c) Siemens AG, 2025 - 2026
>>>> =C2=A0 #
>>>> =C2=A0 # Authors:
>>>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> @@ -15,13 +15,15 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>>>> project.org>"
>>>> =C2=A0 DESCRIPTION =3D "Delete the content of the given Devices"
>>>> =C2=A0 # list of partitions by label
>>>> -INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
>>>> +INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var:cle=
ar"
>>>> =C2=A0 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
>>>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
>>>> -INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
>>>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
>>>> +INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
>>>> +INITRAMFS_SETUP_TIMEOUT ?=3D "600"
>>
>> Timeout of disc encryption vs. full disk wipe differ.
>>
>> Why not allow an individual factory reset override of the watchdog=20
>> timeout?
>=20
> Why? The watchdog needs to be driven the whole initrd period. so one=20
> timeout is enough.

Currently we have two instances in the initrd handling the watchdog.
crypt enrollment and factory reset.
A single INITRAMFS_SETUP_TIMEOUT always needs to consider the=20
combination of both paths, no matter if they apply or not.
e.g. full disk encryption (typically done on first boot for all the=20
partitions incl. rootfs) may require a longer watchdog handling than=20
factory-reset (at least when used w/o the tpm clearing)

BR Alexander

>=20
>=20
>>
>> e.g.:
>> ```
>> INITRAMFS_SETUP_TIMEOUT ??=3D "600"
>> INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${INITRAMFS_SETUP_TIMEOUT}"
>> ```
>>
>> Same applies to first patch wrt. `INITRAMFS_CRYPT_SETUP_TIMEOUT`
>>
>=20
> Quirin
>=20
>>>> =C2=A0 # to support factory reset on btrfs, add 'btrfs'
>>>> =C2=A0 INITRAMFS_FACTORY_RESET_FSTYPES =3D=20
>>>> "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>>>> +INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' if=20
>>>> int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
>>>> =C2=A0 SRC_URI +=3D " \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://factory-reset-script.tmpl \
>>>> @@ -33,17 +35,20 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if=
=20
>>>> bb.utils.to_boolean(d.getVar('IN
>>>> =C2=A0 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
>>>> =C2=A0 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET=
_LUKS_FORMAT_TYPE \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET_CLEAR_TPM \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_WATCHDOG_DEVICE \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_SETUP_TIMEOUT "
>>>> =C2=A0 RDEPENDS =3D "factory-reset-helper \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 initramfs-cip-functions"
>>>> =C2=A0 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factory-reset-helper, finduti=
ls, initramfs-cip-=20
>>>> functions"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factory-reset-helper, finduti=
ls, initramfs-cip-=20
>>>> functions, \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psmisc"
>>>> =C2=A0 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
>>>> -HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
>>>> +HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename dd \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mke2fs awk blkid rm get=
-factory-reset.sh \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chattr grep find"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chattr grep find blockdev seq fuser=
"
>>>
>>> fuser: see patch 1.
>>>
>>>> =C2=A0 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
>>>> =C2=A0 OVERRIDES .=3D "${@':btrfs-support' if 'btrfs' in=20
>>>> d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"
>>>
>>> Jan
>>>
>>
>> BR Alexander
>=20


