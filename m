Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BBEC27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 13:59:44 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.57])
 by mx.groups.io with SMTP id smtpd.web11.21623.1718805574982351678
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 06:59:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VrAAZfwy;
 spf=pass (domain: siemens.com, ip: 40.107.241.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhBADUNKkt18i5EFLJt6U8IlACSzcXhfL6+2AGWJ/XfhJsdTQl//K17+hompo1GKGxWPllyCI9Ch6C0+sRdAyd7QelDCooqjHOTQZ3xKAv0/amOnNcE0ES6EGB4mF37OeiDpGz5gAGAeRavxu514KU7F5jcensWfGD4vhiKZq1L9mA46NCHqLSRUXT0sgcz4USZwZMQtllCVy26M+OZpa/uBLDtTVQuXl4mwBc8ceHhQBPPjJQktH/IaUhkBAwX3HssOu2rRz/WNIyFUU1XudSbcWaw+c3Uio5Xsg/if3cVqVaoXvXKf4Xob/oamYhJ2cL8BxnM3MPLR6Y21j2deqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11zw4ISsDhUhHiMvOvaOWtU7iFhqq6SLjqu+w275Duo=;
 b=AfARWK+NivU0WmElr/j+5Knzt9Tj5o8O4tftxlVQ+CxIrSlG5boBBrxXwQ36y7yipBXJWDMX959xDGhGWJmYqisE5V0PeDdfgHTxqKtjIYrJy5fQkX927c9ot95G+EOdPnGn7VZyFiXk0e687pYGc7WISMN+jWXhXu3VT3uIoHaZfDhhUZ9EP11zo5CUf+KXJz+5QM1g3GGACtD8jnX6SIIqN8WGgFo5VhoVBJ264VkQ19GhxSjSQjxIIe4J57Ngjxctlk1upbGOFrJmUsuNVkOI/B1JGVH8iNwQUsgqm2YaMdVrjJHrGV8xx7Heq266KfDwRAWmfY81R0uxB21x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11zw4ISsDhUhHiMvOvaOWtU7iFhqq6SLjqu+w275Duo=;
 b=VrAAZfwyvHKNTKt+Ax82XameSLIUlpFEyJ0wkgY5doShgMDZ+4gHneBppk7F+0+KtWs5WDf9m/Mp4ufJJjITGVRoLMNy38k0QrZBeVD/UCg/pzYKithfJftDyZumzcXVlwq7xeiKbLFd35/pBLMW+Dx97Y8FFoaoG5jvuos5+WTne0hZdI3N4gbw+T6YivvNNjtiTJ48yPzmEW5AcMH43XGGxtGePqhMAblO4BStSq3xi+mJ6VpcDU4Wc0RcOfIyhOJza8ZnUp/vP3MDIa7rkiMx+5HURzByOwkLg6dsUJp9Veh4h/FQGS/8yuWyPWAqmwSElK/N3efLE7ADisgfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 13:59:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 13:59:31 +0000
Message-ID: <5e3a4961-6b59-4fbc-900a-981144572682@siemens.com>
Date: Wed, 19 Jun 2024 15:59:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: MCOM device testing status
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
 "Schilling, Benjamin (MO MM VT)" <schilling.benjamin@siemens.com>,
 "Kaufmann, Bjoern (SMO RI R&D F SEC)" <bjoern.kaufmann@siemens.com>
References: <TY3PR01MB11075D40AA8B013BAF6DED310C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075D40AA8B013BAF6DED310C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:610:58::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbda9fe-b605-462d-e419-08dc90680adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gmbl0+SfMRzQuJZllJrfXm9flgBqmh+5EKlsPiAQpIOBhGxAXk83SNqI1J6L?=
 =?us-ascii?Q?QQqQ8mgshmuGx167CrYBZEw0lZrJVYDKNt/Wbbr0oE/t93Jtub/P0sAWZPm+?=
 =?us-ascii?Q?J0MOctW35wiuX4zO7BNg2poaRgdKQ+xqBG1lITYvYZHHe11tMSVFWwZ4B2cQ?=
 =?us-ascii?Q?+hPViyedhAB5XiJ+Qox8VOwfbV+OhWMgBY2ubRgC8tvEEEWEYiokLZr6Wmrb?=
 =?us-ascii?Q?42xZBWxFoazL1OE36v0VFmii7T2Ouz3wFiiNLTJHwQe+YnsomC+sxxjmn0Ts?=
 =?us-ascii?Q?at6P4ZJNQ9q+ofdRPyufYbGENrrh7dzSVi+4e9q4A9+CiWFWeu+ansmH8yi+?=
 =?us-ascii?Q?dm/u0n1SxHI9kmlLINtPAer6MY2bWKf4BVLExObgzTPT6Wnnr+Xw+6vAIJJ5?=
 =?us-ascii?Q?G8aoT6CZCkslaoCbv1NRUZ9HlaAfKmKwQe9bUnjcbb6AerO4qoPdq+dJDSMQ?=
 =?us-ascii?Q?6KnxUYWPmYuNz9QAerbx6x/8QplkmqGRAHUSjtOcMv6NhR1DwJ50KRr6OJ1/?=
 =?us-ascii?Q?3u+pTGBOC5rgiAx4m67BTZ4d3ydjeFN256Cz1IIvg6JnNh3IGb9VoMiYailI?=
 =?us-ascii?Q?dafekqNbTeIbyJGLwSpXK52xHDALlle/EWpYZt6MuY9+uOW4vjeB/PjDxyZS?=
 =?us-ascii?Q?/q+4F/pGI+ipLcW5pyp097QvDs1tEfBscJ684ss1aqtMIk/BF9hs+L3sf0GX?=
 =?us-ascii?Q?cXPk3dTR4LYo2Yzz32N84heNRH8yTBJNI9usJj+jtGA3Yabg95/k1YS/X/IO?=
 =?us-ascii?Q?KuGiLKKZMPLxdQCJh/WmoC0nqf3gVf8spHrtgIbrjJJlMGkmgzqsEQRv+2bJ?=
 =?us-ascii?Q?f41Rz9OFBrH9gEc72JVA8uVJxS1d6AZwwJJEPwvsG51oLCJ75nEzwWI7Jv3c?=
 =?us-ascii?Q?Vz08grY0IWyFuY3QXaykeSfqxoZ/2uonM4JmYiRjG5wTEqk1jnxUto7WppHm?=
 =?us-ascii?Q?RXC5OB8Hgu6nj5Jua306cAD43l5K6OMP8R+vBwnyifJGdbYy8o6wZi6tBmid?=
 =?us-ascii?Q?9cNwe/uj8wx5CMjA8DhFd9Ra6DIAPqtTtapY8tuDG7k4V8lL9Z7yeOkraO7p?=
 =?us-ascii?Q?ov4bFSVQJmxo0LW/0QCYs7IyQe/dtvpLDNqARReyG01iRGw0u2Dd/T2OF/LY?=
 =?us-ascii?Q?9Har0GneC8QIUl7X/AiYMWRRiV3YaDl0rhL4b4TIkflvbSVVVuCf/vjP+JM7?=
 =?us-ascii?Q?2np9T0S5EBIvWdbVWedG96PNI5ZU4tkijvkGqhbAzNGjXP1NjAzJ6aUZL/Fb?=
 =?us-ascii?Q?fDsOqC8BbO1g2DK3X53vHRcIBYbQ105/gqPtiHlEmRbrGoiascbIKHZIqxOt?=
 =?us-ascii?Q?+BYJyOXfGOHrX0zIhMcRxVFZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uyVxD0QHv9P1gWzt+JzjvB6ozCek2eHPYOiFchkAksrRuSdbRUAMQuUGSxlx?=
 =?us-ascii?Q?s0caUbL/wDBnVbNouP/dwDRNjX6VLL8djuHmM1rY6kzrqAGPbiRh18dqnfCL?=
 =?us-ascii?Q?IdeY1ev3L3F5YV6/+cqNZcTtlzzjJ9/SlpDXP9suo87ntPQGKg6DIMA6gMNN?=
 =?us-ascii?Q?IrQL1kLZFtATzDROev14tnJ1HBDa0XlgP8dKdxUsqySu9M0TocBQ+NgVY3ni?=
 =?us-ascii?Q?7uhJwG7X5ZdhjCy22K29E28i50ric45VHG4SggkpODGcpAdu/MkHvAPQZIVm?=
 =?us-ascii?Q?gU0dS7kFTUOMOSfGL+QeRt/VeX/q2SElKTDNvzQdY7nmqZZO207xKH9zsR9g?=
 =?us-ascii?Q?VskuL4NIBXH3eflPokq5fuBQWSoW8BkEslvL2FcyqcMU2UdlsGY0lmCGswVl?=
 =?us-ascii?Q?xNlLaJsNbkSe9wKe/YwKt32TgUQRQxTnTtgBYaDiEHFqEqeFmLNlpv8gFgbM?=
 =?us-ascii?Q?YdBp4h/XQU1mzxHyq4ZtJghliH71+cRGAVRYMolK62AcELcykFTFhabsrprp?=
 =?us-ascii?Q?UCpzMxta+thoHtOsdc+wiOynPX7iKujEUTFU22OQgZHadfUXc9/prVSFMrgf?=
 =?us-ascii?Q?eaCORd9kMbpZI4HoLDADFJWfV82KofTpkRGaa2vsBM/rR7YnMnPrGKeLi5qK?=
 =?us-ascii?Q?sq0Oe+rHOOsHpF6AIUN5wKMzgY59MlnCksK4DfI9hPa405oZj0b8VJeBRuz/?=
 =?us-ascii?Q?pAso7tlBnmThPeaSbdOJgmGYqoWDWaZsfptEW1tdbn+A8n/6G2xTM/tJFH7w?=
 =?us-ascii?Q?QhOgdH3Ato+37OGXp+W8owexnzTQIVocC9ejWQL+cbb+Hv8J3EiMhBfFRflv?=
 =?us-ascii?Q?TaZBavdn9jL35ia6v6/FrW500iR7bfnYdGxcnKRzcT3WVSs/axM6gO8+IMBv?=
 =?us-ascii?Q?i3JwWiZBcMbGlchgzpx694MEReR7hYIisjtvgKsYjOJHoFCSlgQqdhActJew?=
 =?us-ascii?Q?sFHTvWQpIYRoemoPpwMttjQtf1q4qd5MJ+7cuzArSX0f3pmBrwxwn18ZMSKQ?=
 =?us-ascii?Q?cmRk+1QqN4Me8Z1not9fD+jZSsZ+5LQjPwT6qYVesaip9L6ju91pJtnX5qsS?=
 =?us-ascii?Q?s7Owen2bUkfktuDUTnrkHMkx0qkb0nXE3jXRzjzbtqzcY3LMuDV0/JcrYpTf?=
 =?us-ascii?Q?gE6niSsgZsnofWo5A7dEaAP4gImpIcZSu6pseI/NxQ3WD+ZDGS69+qoTKLun?=
 =?us-ascii?Q?0oxs5GKoP4iYI5nLBCEvo51iclXqcEjJpKjAEuuBgA9w94XvG0fV7A+UTizk?=
 =?us-ascii?Q?K/kgmCeaPdgGv8nRuWIcAAl2kGyjHS0uJWdlUsfhBfj5BWKPLL0miKe7nwlk?=
 =?us-ascii?Q?SX+WsQQ6tUa/qWsweaEGOe4sRLm6obO9d26X/aBZsIcAga3w51TFUGJfHNMl?=
 =?us-ascii?Q?Oc+5sUgjNUMQo5qUpu7do/xZoblabAqefJ1Vz9XjBoexzAsQxoQTfWlRTnXt?=
 =?us-ascii?Q?itYJAZyV4aZN7f0wRY+WrvExYlgf4jkpuaJ8BI6FuHpTcFcQWx3Dt5NnJWbQ?=
 =?us-ascii?Q?C4VBeqY8HE8mIIn8el/r6f0nRCpsefQXPVaeb8V9VrIPohXfEQNk3n6Ozaec?=
 =?us-ascii?Q?YQpVQ02QAUMtuI5hODCwKmHcYjJ0sL9H6HBqpYBOJ77cXaGn+TpPJwYB4d1A?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbda9fe-b605-462d-e419-08dc90680adc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 13:59:31.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIkYGW3QeTq18dYDSRRnqGXoXaX4qVolqO2bgk+9RkAM7+QeouFQz4tbze9UckAm6OutMkkMO81F7sy61sH1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 13:59:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16296

On 19.06.24 12:06, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi All,
>=20
> This is to inform you all that the generic x86 image created from
> current master branch is successfully booted on MCOM device.
>=20
> Please find summary of testing so far,
> *Base generic x86 image:*
>   * Boot successful=20
>=20
> *SWUpdate *
>   * Confirmed, it works fine by applying swupdate.=20
>=20
> *Secure boot*
>   * Build error in current master branch
>       o ERROR:
>         /build/../repo/recipes-core/images/cip-core-image-security.bb:
>         WKS_FILE 'x86-uefi-efibootguard-secureboot.wks.in' not found
>           + I found =E2=80=9Cx86-uefi-efibootguard-secureboot.wks.in=E2=
=80=9D file is
>             not present in the repository so, locally copied
>             =E2=80=9Cqemu-amd64-efibootguard-secureboot.wks.in=E2=80=9D f=
ile contents to
>             =E2=80=9Cx86-uefi-efibootguard-secureboot.wks.in=E2=80=9D and=
 created image
>             for testing purpose. My understanding is that there is no
>             difference in qemu-amd64 and x86-uefi wks files apart from
>             watchdog settings. Please correct me if my understanding is
>             incorrect.=20

Patch sent, test ongoing.

>   * After injecting the secure boot keys, the boot failed with following
>     error =E2=80=9C*Invalid Signature Detected. Check Secure Boot Policy =
in
>     Setup=E2=80=9D. *Investigating this issue is in progress*. *=C2=A0
>=20

Tests ongoing, will be followed by improvements of our deployment
instructions (how to get a PK.auth file from snakeoil.pem).

We also have an issue on the M-COM that EBG starts WDAT (the default
watchdog of that hardware - that's good) but our merged defconfig only
builds the WDAT driver as module, and that is not available during
initial disk encryption -> reboot loop.

Sorry for the late fixes for all these simple problems but our group
just now got a device physically running.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


