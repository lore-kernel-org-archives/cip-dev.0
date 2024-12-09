Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC99DE7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 08:20:10 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.79])
 by mx.groups.io with SMTP id smtpd.web10.96337.1733732406549667209
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Dec 2024 00:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xxHpOssE;
 spf=pass (domain: siemens.com, ip: 40.107.21.79, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmI3o2U/zNqUHr/4JYy1UsiU71hz4lSOfQLNP2c3e4nyg9cYWRTe81Bf51FK6rKkfHCPbyn63AVo+uEIK0W1rFUnIHjR+gk3yIWGaBV18ZSxUa/mY3y/ZQ5OyrPq9RNrJRyL6OYduC3la63mIpqQl7vBdRUt6PCX7vj9a92a4rLPGbnZ6QfAF9YNsZh+0dqhsuZkFtvBhF0D2EZfCEigH0X5EqOBgd7ZtYTmsAgTKv+s4xeNfPM+rr+TpxF4R7JuycEjyCAxKLKPZnJkeU7YAGIqAMQozymHwjsQJ2406LPMfJ9gfkGRuq4LamvMvzkJV8QvaxJk53dOVilyELVLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs53GjONn7jrlyLPsOJGHoGYhsAy2tjaxcE+4M1gLYs=;
 b=d6fYiA9iy8UYYEJ/cqEwhKvVVo5BftWugll1T1kBwU5JhzSjOWP3ATr6xnx2xCu5AviaESrGLKYRRF7ejd2YgQi66UcDzUl6/NJx/Gmbw3zMmNKwucs0bj/VLyoCTUuM01ABo81QawTsdUT3SFJ0N/opk0SSVVWWaYkQHaWjssHINtdxMNkQdqiYh9FX9F7wGlrsLA5THcAUyLM2iZcdBK5ioDrVWZiHckiPpJohTakZPeU/uOaNZsFuk1V/l6Qd8m0RZ0z6EpVfgTYuZoKvpjVPIYGJPvxLNw8Ent4UGt+GInlCT75bFhZmOc9HHUCKnRUtxhK94rgdIKXA2qvEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs53GjONn7jrlyLPsOJGHoGYhsAy2tjaxcE+4M1gLYs=;
 b=xxHpOssE/zuIpADh7j+CO16yityOjpoFN2R5ZUowsMwpSeqYMjxq+iWczEagz52doizYGLt7oMba1f10AAM13fGfhmwNMJkr3QUPldOHriAy5CHticwRlhCk3VMtzN3oKiGwLKAlB5A++PSIYTDuzneZXiLVu3XCtxu1ujPJVd79dOyYmh3fR7ZKuSX36B99ZSUCPqjNKAV3N8A83KFoSyG3bMC7FC0Qp1xOie5vcMzOpyDRKg/CRRSnhLJ34bmWdlGyxzQEG5JrUjCTM1ZLgDzl3t3BZs+Gs7sY5vIfY7lkVXNZB5PPXiRwFDFOzqmW2XxyJJGiyYQ3qvA36PTYRw==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Mon, 9 Dec
 2024 08:20:01 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8251.008; Mon, 9 Dec 2024
 08:20:01 +0000
From: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv:
 Switch to cip_merged_defconfig
Thread-Topic: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv:
 Switch to cip_merged_defconfig
Thread-Index: AQHbQBZx+yWAu7F1rEiu9w8WFW8yUrLcrZkAgAD4eDg=
Date: Mon, 9 Dec 2024 08:20:01 +0000
Message-ID: 
 <AM9PR10MB4085F29209653B4C16E261FE813C2@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
 <20241126151751.1747275-3-Quirin.Gylstorff@siemens.com>
 <5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com>
In-Reply-To: <5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-12-09T08:19:52.6767759Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4085:EE_|DU0PR10MB5412:EE_
x-ms-office365-filtering-correlation-id: 95a537c4-3ceb-41f8-1803-08dd182a46fa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Pv0bkkI7dOvmo1UWExHTETDMDtQLNC86DCKi3U+4I5XMqV4dg4Bvde3Mjfvw?=
 =?us-ascii?Q?VqpTry5cUhKa8NJv0iCJC1OWfL3TYUTkdb+pLHx7B6bjbYU4lOCI6A7jld27?=
 =?us-ascii?Q?+aXOtUViSswh79VcLBPIVapqvZSsplcLzDdlO2/bFhnXS1X0j6bkq7/XjM0J?=
 =?us-ascii?Q?GQVJES6U8iqgwDBrqfeSzsVE0y4wdWsXMANJ9Jho0eRcwIVIRCi6wpQzG80g?=
 =?us-ascii?Q?s13vib4EhQRod6cqJ7LUx0GE8YQhwwg8GMZ2smbBxbf16HeUmlELhIpi+r6N?=
 =?us-ascii?Q?azHbYiZBYAIYQ5R/VvbmrVRq/F86GblP4V4P5n5T+AIPdwSdywDjwgOcD0nC?=
 =?us-ascii?Q?SORY4N2DbWZhcnS4vyUeXHfvj2lTeLrxnu8AwjLTob0oas8GKlW/IKq3AxRP?=
 =?us-ascii?Q?UD46o2dvWj/kN2jYEzRVk3bbmltBg+Y7Q6czrsIp/qYP5QgWK5GslxJ8mikB?=
 =?us-ascii?Q?T7h/V2oDOSbIWFUXQzP6G9KqGCNd/EWVCoeMFxfVieFEyVKySsYvaJhRP+OT?=
 =?us-ascii?Q?CcLTNyIL+NWmAJ50VL6swEDNIirwuDIW3k8PFEc0AGTQX2znRl+lMnIVKeRX?=
 =?us-ascii?Q?r49ltfQXpM9u/HlYIfPdG7D7h0oho5CmcerGYHG152321yhKDgH6YmSBxlr5?=
 =?us-ascii?Q?8uX35aMxDa1i/HP/DVYotWD2zLl/0kHEDouaU6/SGB6bZJqBZ7SHVpAELR9w?=
 =?us-ascii?Q?Z6Z+8mIH4qFdCMHvbP0fh+lMEx2tdoeIQN60yNN4oA8aXJQWKesmnD8HtoT4?=
 =?us-ascii?Q?xovANesdGwIFqj38rB2CF9RhbLWhKeP+je9AmHrx3mIVnPcAB1mHwVHzb83T?=
 =?us-ascii?Q?P8sMexbnRJzYIUsa45kUO3aXqSB2qB4K3t4vl4br3VF8TgsGALtMB4/FVSp5?=
 =?us-ascii?Q?DN6CHfI2KEcYkeVsuSNT528hdVxNrDvw0rtkCJz/MDAyRW4PcwS5+JdI4l5B?=
 =?us-ascii?Q?7EnQdh/T5VyNJSMg8VvWzSR/FjoQPBYVkGXmBC6XgZfIspjW4TwiHxTkBTRA?=
 =?us-ascii?Q?szv82ob5AT8CquOwMbwHg1cArk9zWQeS1uWZFS0VOUvTYuJmOWSrTcxNF1Aj?=
 =?us-ascii?Q?+oVBmM7ZPpYoBvZQBxlRgGTjhlg/R/dJowU88PyCU/1CEkgSK08ESsnJmle5?=
 =?us-ascii?Q?Z6IsQcRHwlzKcLQhnNaF2DWQzi5L6KVSY5+l/PHI28B5SDQtKy37DPT2TKAx?=
 =?us-ascii?Q?CqmD+voDLCm9OKcCEpaSNJwqmb7KZtbTn2O+RLvzlaPlzRpuF86W5Vl25hLF?=
 =?us-ascii?Q?ctDNLGCGoIYIa733H5XQb6zoJ9BPeexyJRy2uJBISQ8lTrgr8+uiayj8N/eh?=
 =?us-ascii?Q?8FOmQmaZ9vPyVaO2LEWwPQ76oOrxqXVuV6ZGhPIXAEtSBS4KRCe9fbLbrmMV?=
 =?us-ascii?Q?DtxR3t9agyXNgSM+0ZG1CWcAmEvsne+fFZtgjaCe9Kmlf46rnw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vtLlkNRMpsf6wo6SsvfsJgB8LB071xta71j9mfQdXRE76EbHm/33t6zztH7+?=
 =?us-ascii?Q?Fa1MZyFtAYILspr9b8z/QjquIZE7lx0Ej8hPoGVSoyULwgt7iwhrh/lOPr2t?=
 =?us-ascii?Q?baqnOGyjxMDbSHqR7TKOuJj7s59GTw2SbyiDIKd9cU9oQ0VM1BRa5oaWMNts?=
 =?us-ascii?Q?rS5aqFJ2SeIOiADlNgqX+SauXQ68tpB/jbSDrGFQE4Ha5+6U8LBKPmIpWDFz?=
 =?us-ascii?Q?3RxPbyDRnG2yDWj7dF5YmLn5c06eyMs6HwVGIyui3W98DtKtqNaoZWA0RJ1l?=
 =?us-ascii?Q?UqOeWhu8CFpC8hO+EWC79/6+SVvhq4Yeedpx0hCd1i+ftXFapapPZTJm6bM2?=
 =?us-ascii?Q?yV97KB4ir61glCDMb+Ie4w82khgSJUJ0QQEVL35KN8v9eHjrDUwXnd3jbTU9?=
 =?us-ascii?Q?ZkfmtXa1ZXK3C+nMI+lckIQXvXjfuB6rVni1/oxolNjx0mLXx7cRu7OJy01t?=
 =?us-ascii?Q?Av0/9FpozzNrMBhIzKGFE6R2XdG2OJ4DsZaQ9ltnlc0dp/PTpbXtodSU5GP1?=
 =?us-ascii?Q?u/XM4LneYWEz1Icz0X1OeHEuChnilnykGjtVbwHu2sW9XkR1zln0RPPuFWYZ?=
 =?us-ascii?Q?XjOtTe8lM7HkU0Xh7yXvS7fYxjLQKlJCUJe7vL0c+IxIo79oAK/S+bhuTm6a?=
 =?us-ascii?Q?hubOZFyOsIe9QJhNCV5n4fjHgY00ERem4UO/3QQfN+F33rSJ+4tsO49aisPb?=
 =?us-ascii?Q?WtXZoI3bzneqUAy3Gp7pXnuRJhDbL9isfVGIXc5gerdw6CT1/bm+0xsmkqpB?=
 =?us-ascii?Q?RLi4xU/LMVZqKxCbmanuWsQatjoPHmmsYOj+2tsALVACkDNmLnfSD7eNDSCU?=
 =?us-ascii?Q?Zmjsal1PJ/TaedCkqeL+3ewzzUDd0owZcN0rtr4vO0N7hec4cwSuT7vo940e?=
 =?us-ascii?Q?bpnea6npYvR0irU6CBKPJCjNgmxnsq3NnKpk97/bgIyLDOnxE2QuXvEMcwJN?=
 =?us-ascii?Q?W1IKx44i/uv02ajGs0aRJYRc+72qOclPZ/A1uf306UyTZqbmECoG7whjQ5FA?=
 =?us-ascii?Q?AnZw4nH4zJBsAHIso7cOjasgTL2+A9PIC906yb3iTOAHydg8v/zLt59V2ZP2?=
 =?us-ascii?Q?3t8cC5MDtgMVU+ann+ed6DVMCnpJoYPwEGT2w2Qy7uwgP813GhhYix1CufHi?=
 =?us-ascii?Q?0S9icJqy3mO7PF0djxv1tWN+kId2oCTXVtFZLh42myWI2H7x7JWPMb794bl5?=
 =?us-ascii?Q?qn+Bwzb5DnWkSb2buMDAfS18ITpc24ntZIoXlcDvk+2oJXuxs95g0cZmH3HP?=
 =?us-ascii?Q?PEy0Ke6UtaYxm/hG9GAaLe2xc7t0Pa08/5uwV7p8vrUUusZ9uiIVlGi06h1K?=
 =?us-ascii?Q?OCfCey43QTXjNhyMKCF2eRGyrrs9j+posomLSMkV5KbErkJHyxaxZVBNNSOS?=
 =?us-ascii?Q?xSdzFwKC26+SUVU3Yir11mw5shrLS/YSuptDl/DN1irJypfuOHOd6dqfxT+k?=
 =?us-ascii?Q?3RBYIrENW+gr9Oa1zDHqv8BG5g5kra2uqHFJGETCcEkAIxvX7FT4OY2bQEWz?=
 =?us-ascii?Q?qdroLY4Mf3KRUSJiu4VmY+9BgynoobXbsi/R9kl6WnbxXt/KDeD784TQL+6E?=
 =?us-ascii?Q?Nonk8jrHlcfnKeMAN1fzsTLBraHlnqLxKVzV62tdSDUZskXKPudJDwP/glJr?=
 =?us-ascii?Q?+AG0w3Xz7jOTf59R75drgnbFDWQBfW2inyPn/e+mr0/jnklxOnU9V2ammwuY?=
 =?us-ascii?Q?i5m8x8Oe8/we4myN45wcg7lEKYw=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AM9PR10MB4085F29209653B4C16E261FE813C2AM9PR10MB4085EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a537c4-3ceb-41f8-1803-08dd182a46fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 08:20:01.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt8WhS29VjWUiAt2HkB9A2CqiQzky3WdzNFQo5hi0L6z0Bv4tAm3iL1RrJCXnmd/2HG3kFrcT4u1hwHMwoLUI7ixUhRJShfvsNJ3YJdI5jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 08:20:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17381

--_000_AM9PR10MB4085F29209653B4C16E261FE813C2AM9PR10MB4085EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


________________________________
Von: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Gesendet: Sunday, December 8, 2024 6:30:34 PM
An: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; c=
ip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Betreff: Re: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv: Sw=
itch to cip_merged_defconfig

On 26.11.24 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>
> This allows to pick up all common features someone brings into the
> merged config, like we already do for qemu-amd64.
>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/qemu-arm.conf     | 2 +-
>  conf/machine/qemu-arm64.conf   | 2 +-
>  conf/machine/qemu-riscv64.conf | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index d2dd81f..17c0883 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -11,7 +11,7 @@ DISTRO_ARCH =3D "armhf"
>
>  IMAGE_FSTYPES ?=3D "ext4"
>  USE_CIP_KERNEL_CONFIG =3D "1"
> -KERNEL_DEFCONFIG ?=3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm=
/qemu_arm_defconfig"
> +KERNEL_DEFCONFIG ?=3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm=
/cip_merged_defconfig"
>

At least for 6.1, cip_merged_defconfig lacks CONFIG_AUDIT, causing some
test case failures [1]. Did you rerun the generation for all archs and
versions?

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8580918327

--
Siemens AG, Technology
Linux Expert Center

--_000_AM9PR10MB4085F29209653B4C16E261FE813C2AM9PR10MB4085EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">
<div dir=3D"ltr"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr"></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Kiszka, Jan (FT RPD CE=
D) &lt;jan.kiszka@siemens.com&gt;<br>
<b>Gesendet:</b> Sunday, December 8, 2024 6:30:34 PM<br>
<b>An:</b> Gylstorff, Quirin (FT RPD CED OES-DE) &lt;quirin.gylstorff@sieme=
ns.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org=
&gt;<br>
<b>Betreff:</b> Re: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-ri=
scv: Switch to cip_merged_defconfig</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 26.11.24 16:16, Quirin Gylstorff wrote:<br>
&gt; From: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
&gt; <br>
&gt; This allows to pick up all common features someone brings into the<br>
&gt; merged config, like we already do for qemu-amd64.<br>
&gt; <br>
&gt; Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<b=
r>
&gt; ---<br>
&gt;&nbsp; conf/machine/qemu-arm.conf&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&gt;&nbsp; conf/machine/qemu-arm64.conf&nbsp;&nbsp; | 2 +-<br>
&gt;&nbsp; conf/machine/qemu-riscv64.conf | 2 +-<br>
&gt;&nbsp; 3 files changed, 3 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf<b=
r>
&gt; index d2dd81f..17c0883 100644<br>
&gt; --- a/conf/machine/qemu-arm.conf<br>
&gt; +++ b/conf/machine/qemu-arm.conf<br>
&gt; @@ -11,7 +11,7 @@ DISTRO_ARCH =3D &quot;armhf&quot;<br>
&gt;&nbsp; <br>
&gt;&nbsp; IMAGE_FSTYPES ?=3D &quot;ext4&quot;<br>
&gt;&nbsp; USE_CIP_KERNEL_CONFIG =3D &quot;1&quot;<br>
&gt; -KERNEL_DEFCONFIG ?=3D &quot;cip-kernel-config/${KERNEL_DEFCONFIG_VERS=
ION}/arm/qemu_arm_defconfig&quot;<br>
&gt; +KERNEL_DEFCONFIG ?=3D &quot;cip-kernel-config/${KERNEL_DEFCONFIG_VERS=
ION}/arm/cip_merged_defconfig&quot;<br>
&gt;&nbsp; <br>
<br>
At least for 6.1, cip_merged_defconfig lacks CONFIG_AUDIT, causing some<br>
test case failures [1]. Did you rerun the generation for all archs and<br>
versions?<br>
<br>
Jan<br>
<br>
[1] <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs=
/8580918327">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8580918327</a>=
<br>
<br>
-- <br>
Siemens AG, Technology<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM9PR10MB4085F29209653B4C16E261FE813C2AM9PR10MB4085EURP_--

