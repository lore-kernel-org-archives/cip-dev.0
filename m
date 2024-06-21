Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8DC27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 11:06:09 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.51])
 by mx.groups.io with SMTP id smtpd.web10.70409.1718967968727499573
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 04:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oqbXVN3S;
 spf=pass (domain: siemens.com, ip: 40.107.6.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhdde4rTXk/0HEUXozIQhoQ62tWE+8KOMFtmwPqBPi+OcaJgP1U344603+WSiP/pXUcCr8odvuQzPe6claKbPec9EGK0yg/Z1FQM7NMM4CbbtiNHAZn8fgU792kEDlr0lZvzmHIj2+0R0d/KKw79TdLWuJBpY7AfXLXo7Q4k7whHELzacoxmlXDq3uotiFbcjmsMYnP/gZeiHGwheFC5n47tRmv/NNFpDayOQGlp3eyH5iWhzopYR+c9OdXWYJAVKE8jQuwi1d90p5P6yyumoj65xcEx7ixPIteGSGlcY2GB3MAyZ2c6rXyfAHrsCQ0apF91n+Od8ncdLO9qppi46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPgop5iXdT1I0XKW9yniqbx5sr1KEo1aBIa9qKUyGQc=;
 b=go9vXPUCYr4j94tSDXf/0QgdK7Qp0V3bDfFBztV0gElM0+cmdVxP09pbq7F2G29yU2wuZ/IqvVzZ5iupPQ1mj3bBkKp2hzL2X2PYEMSAl9C+Pa4JYYThdEUYUfpJb+47tOLwHsZks9TKkdtrSu4w0Ys3Wa1VbvG9X50X+Ey9YKHtUa+TmBvMmsiTbgSi2tcN+Izlv9Xiu4Y5RDU6pMU8rX+e+ODVJY7VVXXdF1AbQB/Cgjh100eg7TFHMNTPgy/J1NrP/XHUY/h5s/Dut3WoJGpLT+m2nPj/vuSeniljWKAVVMslZ4sbJqVccR7f9UY1wQuL6/DwxnIggvi89NMOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPgop5iXdT1I0XKW9yniqbx5sr1KEo1aBIa9qKUyGQc=;
 b=oqbXVN3SaQ7ILYe8TuHz6D3s9pCVwjbxOKcUVzU9GR6TgKU9030PGOhU97mSwi4Aaa8JT0ij5aZb8ASuZTpB7V7R319NnoVrxzEydym5EVbiecL0Fcc3HNVNxewO7FCPCtWD4tjBwTlG3cXbYR6/L+ujwMdzmpDsPAul04zoEWkUSSmtQuo7msfFz6nFOlLlE/CfamvC4hzdiLZ9YBuMU2LNPKHOHexCIlAUrEdYXQirRSByNeQHO6Xw04KZOvbRklkOyXfCLU4kvpCpJQYtvltp4oLAEsXC03WVcJLGpOkmhCzMQkJmqdG8aI4EzfQS7hT6/jSHd8dGxRwbcZP04Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.35; Fri, 21 Jun
 2024 11:06:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:06:06 +0000
Message-ID: <7f3069a8-d098-4eea-a1bc-5ad9964d2509@siemens.com>
Date: Fri, 21 Jun 2024 13:06:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] doc: Add section howto
 generate the a efi auth file from snakeoil certs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
 <20240621105215.2233044-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240621105215.2233044-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8fbb8b-ef48-4d21-ba4e-08dc91e22594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XYW09a9IBb4i6Lsti1s9zkNqo0zeU/TAh9lBWd3DynD331uGawSeOdXpBlTM?=
 =?us-ascii?Q?z6L2c2Cv6yC7iJmHpo/eCNbFt6TB+JxZ0cCT0jLipM+SoVklB3QU36DZyK2y?=
 =?us-ascii?Q?XAByi1QL+sJNPID82T4H+whLLiUQ94XFt2qDqakhp2cOD8fOOyDZnwj7wpT/?=
 =?us-ascii?Q?fz3lWJnRcSSX1+2C1qkcIIRFblh09S+Judjd4syF5JvREhcZaPBhOzBItxhh?=
 =?us-ascii?Q?9QvsPSuvTW+y+dwXxEdOJf6aRY/yYgbZBVrB5Udu9hzTnKi0XCiJ96MyDZB2?=
 =?us-ascii?Q?DHNF/pzWGHcr0DOGC+OgjTHY77CeFoSWSXAXrt1g/NhYJqhs/zdr3yn4McQF?=
 =?us-ascii?Q?Lhr85M0LpWcgWwEXmTjincc+4I3fajPGodhiRLq0UFymqEaUhc4h1S1cOS4r?=
 =?us-ascii?Q?B2t6YmbjJ/QQTB9p9ofRx4dwUASRlg3pEp2RGg3mEoCh/Qq678U6QOFL9jt9?=
 =?us-ascii?Q?2bEtlGobF1VhXcca6g6+PLlknWQqyoVyEb4QfJpV3oUikJSX/5M6zG8tkR6c?=
 =?us-ascii?Q?F95UvXWRd+TNJTHZb9F+G4WNiJrRw5dFtiYDf5f21ihjjOQKRjKN6pkW0qSK?=
 =?us-ascii?Q?gTof/mdErcewr8LK2CYCN9IY/gBK4JNxuecHEewPAhCdfYQvb/ZtEk/gFu+U?=
 =?us-ascii?Q?rjMAV82hzGNkL5dVRi6EYzLFztBlgQijx4Elr8NhXy5O2hFhRcdMrxWTywLk?=
 =?us-ascii?Q?Qf5PHDFZUgKIYw2cpxprAOHDKbUo/bPgR/8mzOcx6eg+PRbk+5KPH4AAlZjj?=
 =?us-ascii?Q?cko42ScTcLWCO13Dp8DXdoJeTtuVGJn6u8E5/ql1UR1sPIl+/OU0YDfBTBNO?=
 =?us-ascii?Q?02MVmdROmSU7ECxHgpCYXkocZ9LGlI3lfP8UE3awG9nfxjHop3HgFtIWe/Io?=
 =?us-ascii?Q?h+rqXFxQigFOx3DgdXrKknpXoGBf5RAonpavyKO50/hQPK9qqs7sgGO7ArMj?=
 =?us-ascii?Q?DdYIUqbs5bIKFD0PRc8odSylQAxpwhPQN6HCzjfIkkMnAsV0JWdgXZGRrRuc?=
 =?us-ascii?Q?HUBIAI+SUOMigveocgWlR919smu41KgqVzqGLpw5KeNmE5Zzu/zM4YqxqXLr?=
 =?us-ascii?Q?0uCdSb4o3tiB+pipLoWakpejOjkeC9xrvjJQbWwt61isOWapZUAFLAy6q+ur?=
 =?us-ascii?Q?B4cXPbO582FaJtk/KqErZAt1kq/X9Xyv1SjiLcIqiWcxyF49ImW/S0zcAK7M?=
 =?us-ascii?Q?W9u2FLmAM0pIQ1NMEOYzO5PGsVJRZFxhF7y/9SBC4JDDzx3HtNI95mWvsDPc?=
 =?us-ascii?Q?TUsNB42LtzJ/5WQ6GW+Qac0KeE2RPWVSfAFMNId9NpRnAkV8Dih11qX9khfd?=
 =?us-ascii?Q?WezPnxRgZDjZ64RoxNFxcB7n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?im9muvdTFM8xXyAYBu7No+RT1Xo28GETRtTvuY2/GPF7elumuwK2ktMmWwAG?=
 =?us-ascii?Q?iclTiPrfR9imHKkzm5ltrhq2ZvXZJU0Yf38iQClYPqDI2Jxay9zoTQMM/GPp?=
 =?us-ascii?Q?8jhf5G/6H1bcWEu8ymfXEwUfwovwvsQVZhSI5tTBF/K9h2ISClTPCoo+QG5F?=
 =?us-ascii?Q?Rbz7zCnumEn0xBih4aRWGSKU342bJj8czJCrm2N6NId/wlk75q9T1ywu5U9w?=
 =?us-ascii?Q?TmgHrw1LvmS+mDo2W50frelxHidD+sAHoXKlcP2T8u8o8m9vTShvFCyKdI0Q?=
 =?us-ascii?Q?72dlIQp0xYWOLK/KheJJYT3cZ8DRLoPmhU4GC9hV0D+ZrVMmMSUcKpPHNITx?=
 =?us-ascii?Q?aCkeiFTeiZXMvQpuQ+am6yrnA7zu6aBYko2iIwnf8k4S+LXHk1nd1b+q9QTS?=
 =?us-ascii?Q?yk97bthp54z91IzI5yoLjipqwXeabaV1clLXVJ6nToXNoLBlLM8pclXupT0R?=
 =?us-ascii?Q?bPE22nO1Ir6csJKshVss6H6IfL6MVA/WWdabibL9fVg9+5uikyodpU+xCcBp?=
 =?us-ascii?Q?xMwSzV8tsIyl1R8jz8wBBa0+QrBXWK28S01tEnkzGOTett6gleH3DbH+UXZt?=
 =?us-ascii?Q?WU+M7fdGZsx/QZwAZyjHqzHijmFRgVtAFTMOVI2KshKY0sLEXcid0JtKg3Ia?=
 =?us-ascii?Q?cZllDghs3SbUmA9+u3r8R3OU2/evjcyt8kT7JRIaIq3w7j6eew3GBbHrXmSO?=
 =?us-ascii?Q?VVNNIzG+8Son5HkeZTxL15W2I/M7fZyA8Di/z1cs4vyf3nGyfpVNRgL9fs1Q?=
 =?us-ascii?Q?8grH+Rt/yzFJhIGwYSJxkdjD0Qx5HVfvuetbEJPEhA5d6YBEglIfXB+h5AUC?=
 =?us-ascii?Q?6Ke9KIKfdCjeG2xTgUZHwhOZsGKNpu8GREglaqjyLImaltPjSmTb78byoikD?=
 =?us-ascii?Q?ePAwoFbuXlEm7kvboi68FXe3wJs2QSNEDQUS37s6N15BrVFYEf0dNr4cEnoQ?=
 =?us-ascii?Q?34gWl/nP4Y21b29/b34E1xgJ43aX6TqG9YjtvjhR2FI9LcTi1FJfRzmvnsKp?=
 =?us-ascii?Q?oMgFyqkd5rBbbwEbufArQwfefSX2yNhFkyK8UVomkWhadyswqnVNSbGjj3sY?=
 =?us-ascii?Q?ULiplfn7tDyneCg/UGeHIDln6lXdgeqVd1/q6Y8dNSb3r43EkruUoic/NQnw?=
 =?us-ascii?Q?Iu2odBqVpiGMXs0u9LH/rz5la++Bz4KS40Itkbxuwnv2qL/qsr6b9Y3jePp4?=
 =?us-ascii?Q?0P4270wPuN6MyKAfr/iXAh1KlL3onfIeb2AtiBLOEHAVPRGiN/vNZx/MMmcy?=
 =?us-ascii?Q?Z5HyN6U4G5JybCqRiajlPWB8IvdJolblGrLCo75jKfnjNfekIs/3fXD+auLN?=
 =?us-ascii?Q?An4dFnsI33+knGqmfhR7Wk+ShiE8OBg2tQI+nwfFBpBhDcYgqV5KMT0dSK8N?=
 =?us-ascii?Q?pJz5Tek3+4JrmNXG4nDgE3boQj7UnJR1gdFxJGyETGcsa49PAqq6Ypk5T9Nm?=
 =?us-ascii?Q?tlxnC0/TA60qB4UOWwK6Sqzg3nt9Lxr8PEOlsUQBtUnzyz2C7tKo5iB+rik5?=
 =?us-ascii?Q?GPLfn9Sk8QAMrA8ZDRIWi2PeK8OFJThq6s+w9OIV1UVkQA17YxO30d3hYFwn?=
 =?us-ascii?Q?9ZQEi+5uLlupTBF1Jp+fvQPI4NI6AX96fAD5DF2dKIHGU2i9nUP6cfCPsG8o?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8fbb8b-ef48-4d21-ba4e-08dc91e22594
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:06:05.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmtm+S90jQ1H6gkdIn2sU4L0E0sU9Wm/d7qCBslyogIOPfe8UUGd5s/4QMpcz8lC9OZtC5oiSiQOyfxxeXG4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 11:06:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16314

On 21.06.24 12:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to test a physical target with the snakeoil keys.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.secureboot.md | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 509de97..c5371ea 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -47,8 +47,7 @@ Supply the script name and path to wic by adding
> =20
>  #### secure-boot-snakeoil
> =20
> -This package uses the snakeoil key and certificate from the ovmf package=
(0.0~20200229-2)
> -backported from Debian bullseye for signing the image.
> +This package uses the snakeoil key and certificate from the ovmf package=
from Debian bullseye or later for signing the image.

Missing whitespace.

> =20
>  #### secure-boot-key
> =20
> @@ -284,7 +283,7 @@ sda              8:0    0     6G  0 disk
>  =E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
>  =E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
>  =E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> -=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 party

Party?!? :)

Please re-read your patches once more before sending.

>  =E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
>  =E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
>  =E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> @@ -295,6 +294,18 @@ sda              8:0    0     6G  0 disk
> =20
>  Secureboot for a generic UEFI x86 target works similar to the QEMU targe=
t,
>  except the enrollment of the secure boot keys.
> +### Generate keys from Debian snakeoil keys
> +
> +For testing the snakeoil keys from OVMF package can be used to convert t=
he certitificate

And please enable spellchecking in your editor.

> +into a efi authority file use the following commands:
> +```bash
> +cert-to-efi-sig-list recipes-devtools/secure-boot-secrets/files/bookworm=
/PkKek-1-snakeoil.pem PK.esl
> +sign-efi-sig-list -k recipes-devtools/secure-boot-secrets/files/bookworm=
/PkKek-1-snakeoil.key -c recipes-devtools/secure-boot-secrets/files/bookwor=
m/PkKek-1-snakeoil.pem PK PK.esl PK.auth
> +```
> +
> +#### Prerequisites
> + The package `efitools` needs to be installed.
> +
> =20
>  ### Secure boot key enrollment
> =20
> @@ -316,6 +327,9 @@ Use the recipes [secure-boot-key](###secure-boot-key)=
 to provided the keys
>  to the signing script contained in
>  [ebg-secure-boot-signer](###ebg-secure-boot-signer).
> =20
> +
> +
> +

Why these newlines?

>  ### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/e=
bg-secure-boot-signer_0.2.bb)
> =20
>  During building a efibootguard based wic image the scripts contained in

Jan

--=20
Siemens AG, Technology
Linux Expert Center


