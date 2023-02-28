Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96BC64EC7
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 17:34:40 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.79])
 by mx.groups.io with SMTP id smtpd.web11.30303.1677605677422992275
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 09:34:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LpiwYMWG;
 spf=pass (domain: siemens.com, ip: 40.107.249.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3r6uZ+03P/yBpI44NnCF5dc6/kfrKE6eeAGtszA5f8wakMjfa7CbgmTCcaG6V5vmKjcFSwvRc53gzaWFujXmPbKmHHoE1gW9mrDfnMAzx7Z0kJ+VX2zSAmnlvEhti3HP475lz0W9+FytpP6jSpB4n8XaYs25t0WJvGJl9c4Rfs2a3Q3Wc7iDKRXouppvzJI54UShM8jp/irueAVfy+ywOX36KU7MZFL8fP1DZRrZ9hqTD94cZqA24KTl+lvkpZdCfNa6qsouzvywHH5B0+NDTw0dbw4WM1JWJk4Rx49LaMbM/RYJU87nz3Cm6OfhdK1xVKnvrbTrlxJzFn/awU1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4X4QZIqST+EfjQKDZ8NnobqxoUi/AR/RGPmb00+ZBc=;
 b=RubMmu/T+preLkX6z8hgxYwaBMnyf0Xr8/Wdv6hur/1DSRCmLoDh4sNF1Etn25DXPYYjRYihquxCP5aq5WzOoNweu6U0GwCHQm9f6QEPoioFvlC4NEwrOSv8aGu1TDlZ7if4Xp9HiGSRoxZ3bY9/ffB4B1UxIDAj3/9B9i8dtltKWv3GDx8g58KsO+wqrfvkv3V/ldRLmJZZivHENcvMj6xf9zB/DYV2OY8nFZN+qx5KivBq4k3HAPMrRnQcr7lisBAskOz6Ifu3U5ECrW0CUjx2Z1lY61ZBICemjC0aKapJqv2zxe3TD5hWKvfaTB0qme9JSX4LvYoXH6M4t4XmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4X4QZIqST+EfjQKDZ8NnobqxoUi/AR/RGPmb00+ZBc=;
 b=LpiwYMWGJRloE5ocfZ0ACHYrFrGwbw+8p6w9GAnUStwJgDbTLZ7Xp6MuefF9gfi8add//+b17n6fOXvkmWmrr/0QKOONyFcHey73pNRLXNXaWyE2Eu6jDCmIuotUAVuEQ6XdPrxlaDFyZgFfA46RVspN+1VD9cyzs4WV8BQOd1mXEMQebiCZqhZKbqkVB3dGPe40M/9YubzEkUpMiNF4YiKDL3N6quvMVWrIDPbcDoExQgCRknT8EVQUNi00BNJaZMf9ZY74/MQDh2MkfmxEcGgyUN00a+xxf+CNWCY4uYI/2xlAjXkXUAgz1hvjvAdwPledLNWPkq2j16TyJirRMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Tue, 28 Feb
 2023 17:34:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:34:34 +0000
Message-ID: <117e754d-933b-87f5-03a3-4910c639e961@siemens.com>
Date: Tue, 28 Feb 2023 18:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH] README.swupdate.md: Update SWUpdate
 document
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
CC: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230228150246.2523007-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230228150246.2523007-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 84006886-b898-45cf-0382-08db19b20e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8fsQGbVWrDUgwLSbARh/BnEA5LGkEhbA7Qe0h+UGZN3ni/BiByQvKFBm4Pbe0bzFIreieGJru9xh2HDh2WWSLU321ZKRWFplynCFrXTncuCoIEgW9ydi4EpJTD6A0k2oiXoGmjnRG/q8QzpY1Up/Gb3u1j0Yumz+j7LegjN2JK0pmg5ln4SSElj0EMDVV6iMFXfYxC+dqv21VpBUNUJHuoJ52sAfUlFUFxbprDtFigPeOuDTms7eeZ/OBISzFExW7fykRVXooDv6GUyyCnqh+wjbI38FdMjIXnkv0JUKlh0J8dAg3gT7qZR56Ft5FpAl081wYOhhX4Pc089Ro5nP6ihW+0GAXsL/QgoeJeTVwCa0/xxhAOmeDSutC3fwJZKQzKZfe57mZQIaM1TMoI5D8Vk5iPThgHslwarLR8CeSe938s6Tcv8M2KfUA8VQWw8zIi3brReTJyn/m7OItpGC0uJyRG5Ok7a+evN8A6KGOhYwbv/QdU6S191LgT/i7zjdtmHjtEB2AdmV4itylJ16/j8EVDsgEL2wnNnRMHNfKo7U5BkVFkXCYRVMeHtY8mWo7Pq3SeijPufSVHuxeCSCqay3HTn9xpMboCcfExEXGslS4aKp8P9UMKWb3E5PnJNmrIU5Ge3k5CpS8YQ0rmSdawh/hqOlEodaTZ5BP61hNu9fOfkch45W2f1M1vWAX3Yzg0bZBwurOj7VYCa9HGF0r2N4o+196Rceoo4jgYM1xYU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(31686004)(8936002)(4326008)(478600001)(41300700001)(66556008)(66476007)(53546011)(66946007)(26005)(8676002)(36756003)(31696002)(86362001)(107886003)(6486002)(82960400001)(6506007)(2616005)(6512007)(15650500001)(83380400001)(44832011)(316002)(38100700002)(186003)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SRgQk4+WFW1ua2iP/hXWD/0+8GeRe/PiKrLC6xR3Lnv4RCh8502wyhuHDtZI?=
 =?us-ascii?Q?rTza1OuUvZHcTmjtnD0DB5HJTuYYs6TT4rYMbgSR+joSpu7NdbSUHQyxLK67?=
 =?us-ascii?Q?u82qI5yeI71utxa2sfY45R43k6M2rfI3CNPEwcfB7ggWJmkOq47gwZ2lpmRQ?=
 =?us-ascii?Q?nJtcJ+gciXAqVG1r2f3zYwnxOarntsoCeK9CPHwnoWwKr26xhsho+/0J67XB?=
 =?us-ascii?Q?fFpIv3zEYsPiauTFjw8I6RXoDywTeJi4zuVeEe8noLdtfDsd7f5iIZXmrE7d?=
 =?us-ascii?Q?dyCAWl3N7zOxK9IJaTjywI/1GaVGrbiItkDWRyI3QdiOMLoYmY3vtBjdyX3O?=
 =?us-ascii?Q?7G15ChJGRz7nJspkLvD3rLfxClxNjrD8lbMKFTDtvjK1mNqNHi+voWOk3x3E?=
 =?us-ascii?Q?dQ9cQqqnVOMMaq+nB4SR1YB9gXKBVIIrgfstqDWx/ujFF58iTnvgIo9HW09h?=
 =?us-ascii?Q?HE5b8CjudzyZhB5HtHy6UBxZMJYaAnRnv8geVMil6aud/PnESeblFws+DM0J?=
 =?us-ascii?Q?3CwOLu+B4DNElshyyFinmOzzaKjFYC4YAZRTqturWZ4dNpBJicH93qT7Ni/h?=
 =?us-ascii?Q?qyM5CgeeUb8m9suLOHF39v22yAWlLBEhQ0HGWP+sHY7N+wwmUnB0UKfFJ1JR?=
 =?us-ascii?Q?pr/yq71MTtD8G8lCNMhPEXX+i7fK142K/mUGwOHWw6HG0baOVMTTIaB0ieqj?=
 =?us-ascii?Q?Otex8by7olQXDPO8pekyaJAMdF4N86Q25RSLmwbjAdfpv0W0PiuA3QDgasZk?=
 =?us-ascii?Q?i0baN4Oxm5sImIvmDVVzElplPLxkn4j5sdRAooYmC9HPQkKaRVU9iPA3uN4u?=
 =?us-ascii?Q?f++91suJg8jmNYKOmt0vsMpReZbRAPa+BNDL1hJyb2baRAzL3coYSic7YNrh?=
 =?us-ascii?Q?iUxSDvQNn2XOGEPb6XBv4CTaQbIS2V0Fv5xgL62h9iMApHolPqF/kE+bWo5n?=
 =?us-ascii?Q?BCIns+N6lDkcfNsgtIChJrC+dV5A1pWEWjBAJMSXnDhxJtT9u3Rr6XTQdni6?=
 =?us-ascii?Q?hZhZZYtGnG9r9LSUZYUN4ONInCYNiFsTnwRTqhQRouMS4Enj14r/zr082Fxy?=
 =?us-ascii?Q?Fc0RerI61Ac/smpgbDYVZhI52cNRqWJuQOSESwvVygZDOl8LQDT6cqYomWiH?=
 =?us-ascii?Q?FHXXRSDc/ST3yq3NYtv+0g071YA6iIXsx4s3KSMGI4sRmOnerjKnRn9sKCRh?=
 =?us-ascii?Q?KDVPEPR5KkGLozdygd5JhHud18eujTT1qoKvPWwGQk9jxo1hx5SFxbFTuoaW?=
 =?us-ascii?Q?oW6xRYEgzPqQp1yGn2OXlr05hBx0eQ+CcUwypbc4iTow/GVVjh6go892F6iM?=
 =?us-ascii?Q?+3HQkedvyhFlpm1BThJDiXDyRqh0lGWxZMyr9TscXdGwzuBi6YkQp+rerCTt?=
 =?us-ascii?Q?ki/yqYKT/SBoaBCb5RdX7F/3q2/HjK6VWi3mnNvlATTpRKXddZzEYeyspp9p?=
 =?us-ascii?Q?xn+QbUz8qNbSPpSQkALeTiXi6lwcCoTCbDrtEU5/9WrWkPgiGOFtYEXALVfG?=
 =?us-ascii?Q?SNjIHerGm+7NGCPJc/gubwDpqpSv4amwR8fWtuusGL178lFzsIx59nwypZhC?=
 =?us-ascii?Q?C3PPIasUdwyRpTpgPHjIdAiw0ddRds10l3i/2aykIjZV3wDEqMLVZPpA/KAJ?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84006886-b898-45cf-0382-08db19b20e8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 17:34:34.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNRDEylzxx7L9OirGqFHO+9RbeHoiZYb179awwAhWbTmbNhWZISqLmXoVKdexL6CjdpD35epmAnRB0xpa9DbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7730
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 17:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10870

On 28.02.23 16:02, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
>=20
> Update SWUpdate document based on the current implementation.
>=20
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.swupdate.md | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 97de777..00359c7 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -38,12 +38,14 @@ Check which partition is booted, e.g. with lsblk:
>  ```
>  root@demo:~# lsblk
>  NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    2G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> +sda      8:0    0    6G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 16.1M  0 part
>  =E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
>  =E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part /
> +=E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part
> +=E2=94=9C=E2=94=80sda6   8:6    0  1.3G  0 part /home
> +=E2=94=94=E2=94=80sda7   8:7    0  2.6G  0 part /var
>  ```
> =20
>  Also check that you are running the RT kernel:
> @@ -66,12 +68,14 @@ Check which partition is booted, e.g. with lsblk and =
the rootfs should have chan
>  ```
>  root@demo:~# lsblk
>  NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    2G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> +sda      8:0    0    6G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 16.1M  0 part
>  =E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
>  =E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part
> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part /
> +=E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part
> +=E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part /
> +=E2=94=9C=E2=94=80sda6   8:6    0  1.3G  0 part /home
> +=E2=94=94=E2=94=80sda7   8:7    0  2.6G  0 part /var
>  ```
> =20
>  Check the active kernel:
> @@ -91,7 +95,7 @@ root@demo:~# bg_printenv
>  in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           0 (OK)
> =20
> @@ -104,7 +108,7 @@ user variables:
>  in_progress:      no
>  revision:         3
>  kernel:           C:BOOT1:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           2 (TESTING)
> =20
> @@ -155,7 +159,7 @@ root@demo:~# bg_printenv
>  in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           0 (OK)
> =20
> @@ -168,7 +172,7 @@ user variables:
>  in_progress:      no
>  revision:         3
>  kernel:           C:BOOT1:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           1 (INSTALLED)
> =20
> @@ -196,7 +200,7 @@ root@demo:~# bg_printenv
>  in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           0 (OK)
> =20
> @@ -209,7 +213,7 @@ user variables:
>  in_progress:      no
>  revision:         0
>  kernel:           C:BOOT1:linux.efi
> -kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk
> +kernelargs:
>  watchdog timeout: 60 seconds
>  ustate:           3 (FAILED)
> =20

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


