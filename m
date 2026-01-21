Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB836C44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 15:32:32 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14306.1769009545033072122
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 07:32:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=C87FJGVX;
 spf=pass (domain: siemens.com, ip: 52.101.72.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVy2J3dCRXcytYIvOWKXsaciMWJLJMPtV5gTPin6N44doitIPR1XwQcK4weVGLowYm82TP6HAYRc76Gfs+wzlLfU6bm/ZL1msyN040pKsIQt3HVqStjj4x7oDt1sB2y5VibOyRjJqd0g+mhOzJvVG0/3hdPqJ0GdnmxYTMlISFhCXpYrNSiSlwhziWBqmjdIiIq6Ovwp3XzbdxDM6cGNC2IndrNcb4c/c4ld7xtpI9wlvDHta4xcMgNtpLpsqEILXODf+tnAP4WM39ltzMTOFAL82H0ZMsUUovhVa6JxcYyF3sxKTvxa9bnPEHAfNmAMaHb3ask/nCLVt87MjfoT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyBw6j82QmrCrOQmi0hke5X59qMaOaHsDeog1ogopI0=;
 b=S3mMFLesicf6sgPy0Y6iTbk2QypZxr1jPDvxASYtOpQ0brIBF9LvnS9GmN9vOHg29f4TS0lp3HjYNS4kT4MTbI8MMVa9D3DXoUBo1IkSuoJjEk9WD9YvD240I0bXPnQdUYfptvbVqumZb36gWA9oUJID8YBweaUnUYnkWeRG2M36yCH4LmNK1XQYUGAmLz0BEcAJJx3rW/6rfodyGhC+dHDNgUe/FDjYoX+lkWXRY+eYoRH5fPdSJghs9Hr3Mr2CZ+P0d5NcR1DLBKwSRqurw0PJJnnrLlOItE15+fb2J2jEJb9yGXuvw3yAlIwg2ikKVHk9jHofhbH1cibC7FTTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyBw6j82QmrCrOQmi0hke5X59qMaOaHsDeog1ogopI0=;
 b=C87FJGVXVc4eWrwSdf9Evrh0ttaJSu+mHv0J+cD6pbE6dY4wnwYcn01+6JjjJYjLV/r0j/Z6l/mri6oVdoboVQgGpSt4k8cgTqbG4f29cxC6sg6v8KTkApedzT+ZaKTKV/fkzhTQhLXzpOOjwoXUY4BDPaM54blYA3k8EMP7xblWz+/rvn28xJTDqsywdSxYUf4uBdJQVj2DQj/CR0ivA4+rvoOTIbLuuM8fu/LWHNaw9Bqhd0Bj2zdRbb7NoWMF6gOqX8/t2LXVyLaXKmCvKfjzbm91GfSt7JVnuW3Jurj4Aj2krGhbuYPgmB0njo9Yu0vXPe9xA2eyL7j4d+rF/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by AS8PR10MB7352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 15:32:21 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:32:21 +0000
Message-ID: <c9a3d41d-0491-4c4a-b1e6-ef92b726a7eb@siemens.com>
Date: Wed, 21 Jan 2026 16:32:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 jan.kiszka@siemens.com
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
 <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
 <188B3C54C2BB568A.3242018@lists.cip-project.org>
 <TYCPR01MB9669482AEDEEBBE66196C416C496A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <TYCPR01MB9669482AEDEEBBE66196C416C496A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|AS8PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2169a6-3e41-439c-7d08-08de5902447f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WKAVVPZX7DmniUstlY7BNMm3A/yfEafHlzW6dEA1DKa37hhhaeDAog8OJfRJ?=
 =?us-ascii?Q?bjFjEt/NJblbgtSRN25SSqSelRSgQYjytB8mio83cmjCUL9k/bMgMAva8HY6?=
 =?us-ascii?Q?nPO0ZVkBdO/XsZfC5Uy5e3nwU3+grtlX7EsGdpMVtOfjWFc6oqsyBhzqFZ2o?=
 =?us-ascii?Q?JYWWwDI+HducSVP62Vdu1YNxxMv095S2bYQ0d+n+ZjV9UlRMLKeoPx4QgL65?=
 =?us-ascii?Q?de0RIjngxJrERoBgA15Xge1QwEI5s5d8hcb+h9ieA8Y60jzVouvlF5muaiOG?=
 =?us-ascii?Q?vIoSV/UyAJlW2I9BtCPBmdEKE3+rfQ5uRcyYABhxoq/rFnGwnoQBikhfA1mg?=
 =?us-ascii?Q?o/M5W6fICUdSjQTYFf/w23Ictf6oaU7azc4MsBgBt8l2hw596M8Mf3ecMisE?=
 =?us-ascii?Q?UufoYRPnCUkOxyYbSEmqMuyyHdhdeNAzs+8SB2oSiPJqqbr58AWoYuJRJ7ci?=
 =?us-ascii?Q?eJ7Yy02tTOE2gV6DosJLnD2C+BTaFiiroG5J7kwpTvvxh3GEtOzQpkyo3m3d?=
 =?us-ascii?Q?95HliA2HEnnYRPE9zes0HryeOHo4Du5rg1NUwh8kpsXPY4Xr9I2CQTs4k0xM?=
 =?us-ascii?Q?e0PTePBU7a1Qa+Y+iJatmmPcRyhQA1qgwhesjNbyabVaX1/ZHkRXnn/rByUP?=
 =?us-ascii?Q?Q6RXFBsKMNneEtR9bRstqrOnFZ9bmc8CfAFuq+gQbpbfomtZ5Z3RmC6GVnuQ?=
 =?us-ascii?Q?JFR6CSlthmuy88qpaYysHojjCvztTU4WCSPHDrQ1rc92Ir3dYJzomKYVUSuS?=
 =?us-ascii?Q?ZYvJB4gSm6lS63K1T7bhnrXP9RK1mE7w8/WNEMgrh61AqMlBzBSXxb1tmf4L?=
 =?us-ascii?Q?7tIfVzmHtF7FNodtAGHSrByrfz2yuIxhBK2PaTfnewJKd/hujkRf+jQmQ32J?=
 =?us-ascii?Q?hTIOUu3U67rzyRX887oaLra9rA23SiAndTW4I8GjhKN1UVlg0/e+H+VSBW/C?=
 =?us-ascii?Q?3Jtvpd/ff9fcJXjFxru3veZNa9UGZ2Ck5AAuufa+ENxq6WvYcthOU4vIRaHo?=
 =?us-ascii?Q?5d8ovPDrRCGKet6nVUE6KxoJBQ5TuPirMnQcKp+a1w4fWcL/HfQJzhvchwjO?=
 =?us-ascii?Q?zYqFhzC4QDdC23fwtjGBhOWjvpBeKrQ59VMdhdLU7Tdszw0aCcOXTuVTrVBL?=
 =?us-ascii?Q?J3QB+0KTb64M/W2YQ3C2dnaGkC2ZgN8Oou08yd0uxpHBPLJ1F7SGT9FfH2zJ?=
 =?us-ascii?Q?LO3PiYXF4mxorqoOw2CT1T581rpoBnwpZqhnT8GwFXrq1xeu/+x5B8F0WRvj?=
 =?us-ascii?Q?JxbzoF9FdEIjHOQcCkUO/VZkZ40OGMw/lhs75l4F3dRXNDX6DSgenweCYZ0D?=
 =?us-ascii?Q?/J9AY9g+n5JojY9vuEcVio4bEm5O6VTXVozOHtwf9FRoSYVsqT1WSaGI3dFu?=
 =?us-ascii?Q?jSjwegbfjauIq+pvsMPMbv52y5T0wswKX0SLcnnXhOYZU5Uo49zP8Vl0Lf6P?=
 =?us-ascii?Q?l5Q44ChNSnwfTeqxeWXZDq65MXFz+uUhUFvFihXgFnfR0RqPbtcERH9jWY9H?=
 =?us-ascii?Q?NTCilbJFkdsCugM3ah7dlH4/N4sc27YoiATp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SG45deY90kZl3Ww/sapkXpG939qfADoxjgLWNYdhADvywBbb84sygvBj+2bQ?=
 =?us-ascii?Q?nKb/sDpjJVcyTsDOQbmycHiYPORJUGCaBSv7Xug4fwsCVBdCVIzsE8TLNZUT?=
 =?us-ascii?Q?0kgBN+hW0i3Uw6v0z0/dWfAwYuFaNqZYoGiTizeASZpLPJfTCJEqSjtvRJSq?=
 =?us-ascii?Q?StGLdgqhZEWi/6mM4/na8f9m05BdNvxgMbm/a63OgvXglJ/GnpCefhtCuydg?=
 =?us-ascii?Q?j9+QqBu6iejFJBnroXAmvdrxEJF3a/Kyz1denUsy7IFr58EFJl/fIaFxVW3f?=
 =?us-ascii?Q?NmzXrYlp6D6S7h/hwx5cdaeFOOeQVXjTpT0rTEbOhL7/mBd9fM/EoOQkYPoV?=
 =?us-ascii?Q?TPO63xCbtw1guL6Ik62FjbX0O7KYE9rx0mOIu3HTM3+w0fHYepkdQfQpdPUR?=
 =?us-ascii?Q?+03OflZ3yS37j1M6VDgxzO5UOIFU8ttu3dzT4DlLwXO1AHZtalsH3lPWfkrh?=
 =?us-ascii?Q?2gYfRyE9YsFnFqN2DBRhfa4UdyUV80H3LLvHDilvzTk5Io7fthyhLwYbWM9F?=
 =?us-ascii?Q?nsc4znwimm/Bpk8wwazFZ7H5QySu9d4fPcublHs+1QvS60wmSeMauowpPnWm?=
 =?us-ascii?Q?2gDgQHw7W/qs+bq8oRIl8UtgNfoe+gzK+G7zLxmakM3ki9Er1+kH2x4sI1PK?=
 =?us-ascii?Q?cIRUm96/pCu+wyab6B8QIydq5KjX2/ts2gYYEMm/nB3Lxn+6aj+QMDkbtcCm?=
 =?us-ascii?Q?eF6oTVOnatgzFgFJBYcBh3zCT9hasFiselZRIBUBMDujatrI4rrv22CQaM0k?=
 =?us-ascii?Q?/Z496W8WFf14Huex3vFYMWqpkYcko4X/t1aq0JnSWg8ZrqwOKQn6stuXeNI0?=
 =?us-ascii?Q?SSovf4xfamyeJA2AH5pgCJNoyBEIJKdt7K8nR5iqG4ObCqWqWE7w/dpNvQHr?=
 =?us-ascii?Q?Ng/82RWv0FTDoO1J6KgBuV6SuEB7rZ9P3mN5NCdEkWcUKKYPJ04zBfFdYjQm?=
 =?us-ascii?Q?ls0Bwlf31U4l4b5c5M+37xpPT+dwq3yZIcXARyeCz6qgw612rJCh3V+ITyXo?=
 =?us-ascii?Q?n+RCWIBpkOIwUhdIfHkhQwcm0lPPWn4sDoiMnR2IUFUNohhPYX2IwSHQSpJB?=
 =?us-ascii?Q?cMRhWkKT/tw8hqsVWkkheBw1T4oguDeOzSXfH6PPCH50+209Wh2lK+Y+imF+?=
 =?us-ascii?Q?4mauQFvwsqVyCwRr1ngc9wxFUukjVPelZWfD+odCG9EsLUydAexWPEdnh8vm?=
 =?us-ascii?Q?a9xp8YRasYIYW0afJCZ45T/quRy/foQUeFIai9POQtMvurWO3svO9ZjS+2bQ?=
 =?us-ascii?Q?3xcGU+lvxnWyd5VnKtidxLr5tgbTFPDR6ndPUPUOEEe98Z8AM0BPQX4hXMkQ?=
 =?us-ascii?Q?8LcZyzP0c5PokTbiZx5EshlUAhr4T0vB7Tya7Qkh/Zo70BCnRcBj8afAMWqe?=
 =?us-ascii?Q?MRcnIGrUOdaDq5NigbEjjYPT3EUnsplLqF3XqW/JYAZS3HWi85FBrzkl0RrV?=
 =?us-ascii?Q?b298bit9TFd16cXuUWj9De8OMHYByewFa4hpI/xInIi/JFXecUITJeTs52/g?=
 =?us-ascii?Q?+V+DRGkY4OchWcZpKDj0ssA6CyjeOcF9lqvh9+dz5WCkvgDhLrz4hMTOBWi+?=
 =?us-ascii?Q?eMWFfKJTLMAfM9mFQvU0qICqQci5daTIzACnqt4vyY+e21EFQKp20pYzZlQQ?=
 =?us-ascii?Q?hzFBXFSJk+KGnhIcZjXANwX2TTFU2vaB/R3m2ML3i2RXsT3DYL5tkchFJSf8?=
 =?us-ascii?Q?SBG76ILX+Jif4ZNRjrZWmFXz8OQpC0r/IuQuEp+25OkSD+31M8SOF4OWKRc2?=
 =?us-ascii?Q?TY57dqKystR94GI2bO0WG6jnp9XqLxA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2169a6-3e41-439c-7d08-08de5902447f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:32:21.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qdl/gFFA99qJtLrzUjMWx2nsvxohJyeJpBhska5t5ltGkcBv1Kx0s9HcbjMt/D41wcfsYn6GxxFZuIP74Lni74DAeQb2UI8Sv0viZHEjnwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7352
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 15:32:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21689



On 1/21/26 9:14 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Any thoughts on this? Do we stick with the current approach or switch=20
> over to a file in kas/opt ?
>=20
Alternative drop the unnecessary `overrides`. And use WFX_URL direct to=20
install swupdate-config-wfx.

Quirin
> Regards,
> Adithya Balakumar
> ------------------------------------------------------------------------
> *From:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org=
> on=20
> behalf of Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> *Sent:*=C2=A0Friday, January 16, 2026 7:56 PM
> *To:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;=
=20
> quirin.gylstorff@siemens.com <quirin.gylstorff@siemens.com>
> *Subject:*=C2=A0Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc:=
=20
> Enable wfx based updates if WFX_URL is set
>=20
> Hi Quirin,
>=20
>  >Why the getVar pattern? In all other cases we set overrides with a file
>  >in kas/opt/.
>=20
> I took this approach after a suggestion from Jan in v3=C2=A0 [1]
>=20
> [1] https://lists.cip-project.org/g/cip-dev/message/20264 <https://=20
> lists.cip-project.org/g/cip-dev/message/20264>
> ------------------------------------------------------------------------
> *From:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org=
> on=20
> behalf of Quirin Gylstorff via lists.cip-project.org=20
> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
> *Sent:*=C2=A0Friday, January 16, 2026 7:19 PM
> *To:*=C2=A0cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> *Subject:*=C2=A0Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc:=
=20
> Enable wfx based updates if WFX_URL is set
>=20
>=20
>=20
> On 1/16/26 12:49 PM, Adithya Balakumar wrote:
>  > From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>  >
>  > WFX_URL can be set via the Kconfig menu. Enable wfx backend based upda=
tes
>  > if WFX_URL is set at build time.
>  >
>  > Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>  > ---
>  >=C2=A0=C2=A0 recipes-core/images/swupdate.inc | 4 ++++
>  >=C2=A0=C2=A0 1 file changed, 4 insertions(+)
>  >
>  > diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/=20
> swupdate.inc
>  > index 7cd816a..7041058 100644
>  > --- a/recipes-core/images/swupdate.inc
>  > +++ b/recipes-core/images/swupdate.inc
>  > @@ -57,5 +57,9 @@ python() {
>  >=C2=A0=C2=A0 IMAGE_INSTALL:append =3D "${@' swupdate' if=20
> bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
>  >=C2=A0=C2=A0 IMAGE_PREINSTALL:append =3D "${@'' if=20
> bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>  >
>  > +# check for wfx url to enable support for wfx backend based updates
>  > +OVERRIDES .=3D "${@':wfx' if d.getVar("WFX_URL") else ''}"
>=20
> Why the getVar pattern? In all other cases we set overrides with a file
> in kas/opt/.
>=20
> Quirin
>=20
>  > +IMAGE_INSTALL:append:wfx =3D " swupdate-config-wfx"
>  > +
>  >=C2=A0=C2=A0 IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>  >=C2=A0=C2=A0 IMAGE_INSTALL +=3D " swupdate-config"
>  >
>  >
>  >
>  >
>  >
>=20


