Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D4BC7EE22
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 06:16:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.81])
 by mx.groups.io with SMTP id smtpd.web10.25351.1683612975770956307
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 23:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iL5/OQAH;
 spf=pass (domain: siemens.com, ip: 40.107.22.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2Yjqp5Iqpk6r3WuoztOjOOt2pQC/TPEVO16E34BR77YF8FBVF6vaVcHj5pR8NwWQEYLIj2XJIrxWO3UkjO60DnkqPgwSixBvna95vGh2RzkPLa6SaOFM0uuJxb7KzU1AYpGCG2KZO8Vii4TXGuuxuvIMNpu3w0Rp5C12JCAoCst3uyLz/py2fPpKKeTXDlkQLpJS+ZycyautuCx3rCCp+1t/QITcXbZoMRqXik8Zr1hzVZ3sjiKNPSdChdSNgiXPjv7/atfIr/0OyUWVF7+v+xFEzlSrW7owdLvsjqIeGeaBUiytf/4ayTcX0tc7O6adYH94mRR6ufqDa0HyZvEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xka5Ut8oavoZbvOk8dss8FKxTloZ/p5N8VFd/M0WJWE=;
 b=O6nqhvQGImM6DJqk5VFDoTzjbpQx4TGnKlJMZgIG/9LGm8Rnfy0gf3Xg+vaj/Q49GO0AL4J1UVouI9BVtjzlexo7JkjtSE2bbJfCLt3xSKU40XdH9JMj85B3oRWEAFFKz3/bjplAVsDv7gShr8qQHd0WKEb4ITjYx8gNGwDILqFkWHK/tGrj+afbZr0l7E8C2kFChUfLVXD4wgi/BA13WdGWaiO3XwN9b71uD2iVLJiAFKLEiF+7tLR3NZSQCjVVALIW+Yqmbp8tIngGTy9E51xk8Xwj9lElT9oGjecsOwsZkvyk6SyigTs/RvQr5HGPY7FazCquN4dt6CR298etgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xka5Ut8oavoZbvOk8dss8FKxTloZ/p5N8VFd/M0WJWE=;
 b=iL5/OQAHz0AtHoFPNln1yO+93RkCT1rSjiXWUAIXsNKtTXYr4D4bdIYKEYKJxljaaeOvRBFXbTsan/wZG/7fzmrpSLCcz/fTH3d7BTNe+oF6fk1Kz3HLBUdSPXxMF1XTVLTrV7j0d7ZSDioq8GwxIKu7+qHFrXPmK6190JTitDBOMWV1qReWf52wEGGhyPY4/PhKoB66BluQTSQcKcCC6Fw8mM8mbXsFsC3YB6cW/fypfWBGiDVm+G7pOauGmCiAcWj4EudjsCeiijy8E4H6G0EJ3Apeyazt2tYW3MQ/qCr89N5Qzunym+R/1Wpno/3RT3qmAaxM0aJYvTR8Ve+5Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 06:16:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:16:12 +0000
Message-ID: <fdc98640-47c8-7f2b-93d5-530dae2326d8@siemens.com>
Date: Tue, 9 May 2023 08:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core] README_cip-core-version-release-policy.md : To
 define the versioning and release policy
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230508132444.32525-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508132444.32525-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: f30e0748-594c-443a-602f-08db5054e311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dab2jzY2FKrWNVFMOhf1ki+pUNDCefSFaQV/zQMX6M578q2ZSYUcfYmO5unAH+zFpIiz5WXHjo3FtV14uWc7ZPuxo6gfohlII1rLXWEE0C+SX4HdN32yY3jJCyOJaXjDxEZyLgMQrjAJt6aRPCfuVv4CEEm26kNUP1WJrMwKPoGLbdcsDJMTLy0vwRP2+Mn0+M7lJ47Sv3OlznPIOU2XC1J1lJzx/dY4cuPkZ2mu0kcvE+2Q9QjQ4bICq46T0Silk6HeG6V29RQKmMhijdVuh4eQxJlQE0NV5zbcfqcqXzGiFBek4wYthvRzAzILlPOy3ueTp0s/dSJ6wEYsgtsjg3draDKHw6OQMEfaQxdYj/jeBlCOKvY38Hu3fKWWAnhtXAchiPfzp74Xeb0HzFoisSRS+uafISXndFZIx8YG9nNtFYtbUAp1EQ6FKmyrhYnb04cVU4lesRmzkpQKAdK8XGrACa6jPKafdtSjl6VKmOSJjYKXDhbvHgPq9xYlF4hZoZAeAojTbjG1wOe+nsAGEOOPWUAgSCSPaajrHmIXKKKpX8x2AHVZfl9AylE6Wp7w+5nhwkTxyqVbwIMALmsnXNQIyXxDegJxGad06EqvUATVF0oSvQsyC7FSyiOr3YRYfR+aR7R51exD1HzikmLr+w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(5660300002)(4326008)(26005)(6666004)(316002)(44832011)(41300700001)(38100700002)(31696002)(82960400001)(66476007)(66556008)(86362001)(53546011)(66946007)(6506007)(6512007)(2906002)(8936002)(8676002)(31686004)(186003)(6486002)(36756003)(478600001)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0DJ1oyWFI6dfIDlGJZieqvviNmIQviWWZ8hXnw8X4DiqhkOXs/SzhOfToKZJ?=
 =?us-ascii?Q?BDiy74WbQQVJJqR37jPZ9Yl79kZdis7vOcoltqBfBaPx3p3CVdCtoqlg6sfi?=
 =?us-ascii?Q?5C+Ust4lgxhSy0ievIDYNA1lJB2Uw2XAuZ3YKQshrjf9PRvZsiZDNDulOLKo?=
 =?us-ascii?Q?O3/BWzG4idXRU4OCzcQJVj5zONYTSUQ9ql6TkyFf7I+6dZUSuxZl9KSfWQOT?=
 =?us-ascii?Q?F3fXehktSx8TSgMghBYQ0K/EW3xyADpYmfiDXRp0Vu8OwmkAytjZjXJt76C3?=
 =?us-ascii?Q?X/xJZytO3nmbL0galmEGdsUBrlBsvTd1ZPmI2MaqQ1x0sf1DEPSluiuFGqJO?=
 =?us-ascii?Q?IVwKQRX+MR6YSbB0aIVHvK8sAG7YS8cCyQWgtwzrtV5Fhj4RiVrLRsBh7are?=
 =?us-ascii?Q?ipylCk0lx7kIMIlyyt/+13EyImFgjVS0nN3LMgVXtDfW/nF/0YsAVq02b6y4?=
 =?us-ascii?Q?vljTpp1es6N34El6PIcRfsBXcY9Hri+FUeNkw32EsbBKKdVu2fJK3pXGyApv?=
 =?us-ascii?Q?/b6nwjFG4wyk8tLpDONe3f8U8BzJmVKTR0Q2SbQ9p95ArESPAxs+DOt90IHK?=
 =?us-ascii?Q?GkMtq/iYhrIQNTom4EGMgEGrGxSFvRreFSlSyL36IehLcFe/IV20OqQdZ8xD?=
 =?us-ascii?Q?O3Vjn9bxUMI6nyIrgntPINNwBE2mL7sVRLyT+KYwbNhfHFWNtEIUcVdw3HFx?=
 =?us-ascii?Q?HTGJwRo6qUQ0biYl+Z8Usgd2iwfRsmttk0Ct2cqPO04NdZOktYjLHX8VUit7?=
 =?us-ascii?Q?v2JWlVR7kDDO4d4WMyrCy4ZANjErDDFx1Z22Qv16aD6vRzjJzcrxDVC1Kfc/?=
 =?us-ascii?Q?N8LHciU3L/1tdUhT75Qvw3iYPkzPLJV5keaKZwQhezGey63vo2zRBT7B1TV8?=
 =?us-ascii?Q?H1jE2vClg2hH1r8EqVlyei4in+27hANYLoDua8iVp/f5bGQETQvKkfWQy15A?=
 =?us-ascii?Q?EfESqcEa6Ho8yx2cFK2IsuWG0t95UVp1R6yNSD0QPG/Am/onYLP4ofZgJFCW?=
 =?us-ascii?Q?bo9HJERSm10us8UjUj6eeL3CMrf4m3BOkP8j1E1OUbnkbOp7vjB2//FwVl3+?=
 =?us-ascii?Q?cbNLvqySpSoQFSwmQCBszf9pBFokcq0T7P57ph5BNw3C9+E11T+uumzv6G7i?=
 =?us-ascii?Q?JTDtmtZfjvfqcL28Nl05D/6EpWUl4cA/qeoDw5HIWvEMxOk/fBus8PCQYzuq?=
 =?us-ascii?Q?Zy8xXYpyi2a0AjKGM7IxVYWFy6dX8P+UfagqaCz0CE/oteLbQom5zGn6GjA9?=
 =?us-ascii?Q?adaabJ5/x7AWA8v9qkbApJfh1+dVhMhln3ogf24MqhRwIU0ZCS7tjNvkFcAc?=
 =?us-ascii?Q?ytZRI4K7SZbVrOn9+y0dSsENP3ehbBE+fDQQdRzmclbwtoYWFxe6MrlVbGa+?=
 =?us-ascii?Q?MKLphNQRjieZ2NaQjjbKdzTMlvvFyyaGO9dKefnIroKkfcBlal8vVECJIZTC?=
 =?us-ascii?Q?MYLDOM+u+bpTctmAPbVkPTlgtRTPP9WrrXdKpuWu04ImDGbCNP5R34D0b7RV?=
 =?us-ascii?Q?UESfme6uwfGwLoKnBollpYZEuzmr8a7cpmn4UTLPCcACYqRSQQQxWP+U/YsN?=
 =?us-ascii?Q?Qn4Bfb4hJu+WdU2sCXvIxPsbNE3IGdQ0y2iZBf1qQn+3ah41X0GJpzLPC8Me?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30e0748-594c-443a-602f-08db5054e311
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 06:16:12.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuDQVSFvTVSGsDZBTXJYjqhGdGFugfcsm9l4vnngXOiCEyJbVInYNGuT2AMg2aG9pojVKTijxAZ7DmIr8XwNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 06:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11418

On 08.05.23 15:24, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> This is the updated patch after making changes based on Jan's comments.

This is a change log of the patch and, as such, it should go after the
"---" separator. Instead, you need to restore the original commit
message here.

Please also version your patches, e.g.:

[isar-cip-core][PATCH v2] Document versioning and release policy

Jan

> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README_cip-core-version-release-policy.md | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 doc/README_cip-core-version-release-policy.md
>=20
> diff --git a/doc/README_cip-core-version-release-policy.md b/doc/README_c=
ip-core-version-release-policy.md
> new file mode 100644
> index 0000000..f42e549
> --- /dev/null
> +++ b/doc/README_cip-core-version-release-policy.md
> @@ -0,0 +1,31 @@
> +# CIP metadata versioning and Release policy
> +
> +## Table of contents
> +1. [Objective](#objective)
> +2. [Versioning system](#versioningsystem)
> +3. [Release policy](#releasepolicy)
> +
> +## Objective <a name=3D"objective"></a>
> +
> +The primary objective is to document the release process, it=E2=80=99s f=
requency and version changing for isar-cip-core metadata. This metadata can=
 be used by CIP users to create various flavors of images like **security-h=
ardened image, testing image, partition-encrypted image** etc. in architect=
ures like **x86_64, arm64, armhf, riscv64**.
> +
> +## Versioning system <a name=3D"versioningsystem"></a>
> +
> +The isar-cip-core metadata follows semantic versioning system i.e **x.y.=
z** format which is explained below:
> +
> +1. **z** is incremented only when critical bugs are fixed.
> +    * For example, if the latest release version is **2.2.5**, then the =
upcoming release version after fixing some critical bugs will be **2.2.6**.
> +
> +2. **y** is incremented for each Debian point release or in case of isar=
-cip-core regular release. When **y** is incremented, **z** is reset to 0.
> +    * Let us assume that the latest release version is **2.1.1**, then t=
he upcoming regular release version will be **2.2.0**.
> +
> +3. **x** is incremented when significant changes are done other than **y=
** and **z**.
> +    * In cases where recipes are broken fundamentally, or support for an=
 older Debian version is dropped then the value of x is incremented by 1.
> +    * Let us assume that the latest release version is **1.0.1**. If cha=
nges similar to the one mentioned above are done, then the next release wil=
l be **2.0**. When **x** is incremented, **y** & **z** are reset to 0.
> +
> +## Release policy
> +
> +An approximate time gap of 3 months is taken between consecutive regular=
 releases. During every release, CIP-Core plans to give out recipes (isar-c=
ip-core metadata) using which the user can build the flavor of their choice=
.
> +
> +All the releases can be found [here](https://gitlab.com/cip-project/cip-=
core/isar-cip-core/-/tags).
> +

--=20
Siemens AG, Technology
Competence Center Embedded Linux


