Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F0CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:36:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.web11.18803.1758101782071455441
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 02:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=I6sOczd6;
 spf=pass (domain: renesas.com, ip: 52.101.125.39, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMOcJx0wNeeZ61jFnI4RK/7/gR3Hfqat6oPFqCt4BlIJcRMMU9aVsQSc+A7bOCSo26NfS4INJAckaSkyTcwcIzdZw+qby5YuSloQn3naexEiTZcAYXfVRLExE5StssPk1DoxfzqJgkCOEKwmCykAHn54PqADGpPToNPbWwW9PG6fEfX5iRPo154q6GPf18CQwSKeIfG1RRly5aoGn1JSo9fTz+x8e7ViWDtHdEB4qcXBfu4eZ+2iaz6LvHIVT+CD9xdCzW6NRz/4JtIwDpDEZuh8ZKBfaNQKyHV2haeTXmmV4k1pKwPDFadkZgySBp1teL/FMiFH6RNIsNr2fGVrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfrTKlNe3Vq1JP2rEXZMu8huEss4X95YmODz0C6/yuY=;
 b=dVzDLRjw5Wuog5Flq9YNKK3yKU5JFKgM/tA5d8Ji8D/Rif8ZuNmg3Ort66UMNuhtMesw6yRuIsf1oOWjIhua58s/Gk8H4Ty4vlNO5IsF6aNy1ApwopL28tdkl5XQNpoOANiYUIpbI0lDE2FBQp9wIp7q78sLiezZl7dcpDZbBs1siAvMtuiq8+0sgmo8hrx118SBHVW4p+oncloCKfAh1gNjljdX19XD2QSF5zhNpypsATWKBHx7Wc0U/A/ftMJb/v4bLPjLgX1vNUGcX+6tFH3p78L1n1X4xJEjc5XNZyq9DnWuKs8fMf37aEo13YS5ZQLXSveZpdOVXGQ1+PhmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfrTKlNe3Vq1JP2rEXZMu8huEss4X95YmODz0C6/yuY=;
 b=I6sOczd67IYqiuuR4Foeu4RjX7P2wlUvdIg535IsMoSl3Lfab27ZTAPs7F5uiLm8zPo4McIyEu1O8VyL4g4G4oMGJRePNXcF5VpTD37zDuh6cEsLXkM61zmkyYwtvUIh2gR5IweFgWS44OkKX+McZHEp11ozl5Weth/NjvMWF/s=
Received: from TY4PR01MB15127.jpnprd01.prod.outlook.com (2603:1096:405:280::6)
 by OS7PR01MB11728.jpnprd01.prod.outlook.com (2603:1096:604:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 09:36:18 +0000
Received: from TY4PR01MB15127.jpnprd01.prod.outlook.com
 ([fe80::e19d:7660:7b8f:c0f5]) by TY4PR01MB15127.jpnprd01.prod.outlook.com
 ([fe80::e19d:7660:7b8f:c0f5%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:36:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 2/3] ci: Add job to build own
 lavacli container for tests
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 2/3] ci: Add job to build own
 lavacli container for tests
Thread-Index: AQHcJ6lc9vatKZF+hkSbdofRsRtzq7SXG8Gg
Date: Wed, 17 Sep 2025 09:36:18 +0000
Message-ID: 
 <TY4PR01MB151279869A438BB0BFE882D17B717A@TY4PR01MB15127.jpnprd01.prod.outlook.com>
References: <cover.1758096066.git.jan.kiszka@siemens.com>
 <f8694e5ba24ace2dafd4df9fa859e0395d932917.1758096066.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <f8694e5ba24ace2dafd4df9fa859e0395d932917.1758096066.git.jan.kiszka@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB15127:EE_|OS7PR01MB11728:EE_
x-ms-office365-filtering-correlation-id: 7b2d2eea-07f7-460f-8dd7-08ddf5cda794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?rtjp8N7+dlmMD0WLJVU0Su0TOnvKcxAV2qka5G2Puh/xVhlzE5/6V2Kg?=
 =?Windows-1252?Q?V83+ORRQYYcnXVpqC+kyHnlBmQQKOAp5D3QaQiSL6fu21Vd6BjFg/5eh?=
 =?Windows-1252?Q?fnLFOecEaAlI/T5GTKEa1ojGfeSmdXOlNGQiXMyIfS9ZLe+7pxnPsF7G?=
 =?Windows-1252?Q?qLYERWpw4fE9e2cTZP+e75R6YCzx4ApkGiHrUQqVwRq3jEkayEmyNchT?=
 =?Windows-1252?Q?UGraMTk+rEPJXkQ2qVVtX23vAT6FEw9VdoQFbXn8oeKNsxOywHykb5Bz?=
 =?Windows-1252?Q?CDVKae9N0Dc64zLzoadS9i+AUIYQBFi9cVbr7BKfWpsZje71OEh8470Q?=
 =?Windows-1252?Q?JRu8ekFXH3f6Bi1Jd/0g6bPb4Y7jrIzhI9bHfy96KjTCGIQjJbfv0Dfb?=
 =?Windows-1252?Q?7mxEi5iFtWpT3lwqXhRs79wAbe788/kExZ8v9z12EQm49UZt3SHd7ijp?=
 =?Windows-1252?Q?1Tbb0YyZqlPQ3YOI2lV8Yo+/pq2dnoXn9kegu8CUI6mZSUQJ1vDCfnEJ?=
 =?Windows-1252?Q?fW5plg4pK3bEMoeFdrUvdMcXaKQHADr5H8jo4qtAYxeiST1WIzVPY0I4?=
 =?Windows-1252?Q?zgrwjGnvOlI8aMcQFH0itrKTAd1nHVb8NlK2oC2Wwxdw6HfJ5HjU0pxp?=
 =?Windows-1252?Q?svztc1RssqD1aPgrFaqCQHP59Yigg6Hd7fYMlhdQPmjDID/HEHvosMQZ?=
 =?Windows-1252?Q?86/1nnp0fRw8AvkDu/a7LIyWEEruiXvAfaq8RqhGQxkIjAyDNa1+8AJn?=
 =?Windows-1252?Q?lhE9joGjBdn4+zSapPsUjkaka3PhjiWGBuEyDuu9JYsat0b9aerCs79K?=
 =?Windows-1252?Q?K3xiwmNxFI7QMGR/zh8gAeqd1V1YzVvvgkG57Rp2tCGqAVyWDBIardGY?=
 =?Windows-1252?Q?zruXi/BFOaeRa/v1PAbR8awjOEcbgY0MeAHtpOV31U+eyJ09w9vs2HGK?=
 =?Windows-1252?Q?dSKuTpYTpVCbyXORe7sCshSmvMH860lYo3Hdh13AAz2FfpfbhE1Khhw0?=
 =?Windows-1252?Q?Isg5Kx7/C4d22J/mlWPpTLhuquLmC0RmjiiVggj2UxaAfYFUjh6654s4?=
 =?Windows-1252?Q?ZmqrkQI/2L5+tIDntdxwB4+7ZrLZb7+NWJB6Iu7IPLRi4lsglDimi759?=
 =?Windows-1252?Q?NIc8+Koq7ob9k6fvJSz11PrWqjOPeqgfWqK8na4yeQirub9RBZGQkb/g?=
 =?Windows-1252?Q?3+p7Y4jmkdmbyG27MMQusYyBu3jBb0luh9eEXb/az40rABWU4ENwPF2f?=
 =?Windows-1252?Q?ouPen87mnODF+2bTDlkMRLrV4gpcrkzZrMboIW5/dIwTz+0DZZDA4TEl?=
 =?Windows-1252?Q?95JufHIvLXSJSTNP88t07EYYOnyu3Qatsemqtw1iPS2lOCQEb06UoAs9?=
 =?Windows-1252?Q?7UDvZNRHhgosNLD5SvLVnoOq9fLo1Iyx2L/2X5FGosVMQ13GgJnWKL8p?=
 =?Windows-1252?Q?P462aBYQfK/umefi8GmI2vQ/QBHQRqNDosNQtEeW9TpCEQ8RNwnw0WoP?=
 =?Windows-1252?Q?b3yetEGB/ULtFcvGsWDa8jvn5ITVoh6O8lBQMOCSPJtWgxRoRRY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15127.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?BEGZ2xKmbxoHhf2WWwvazoD3YfxVsjHUDzI8N7if5idMbSG5DVZ9kKDs?=
 =?Windows-1252?Q?fuWPMMTnssM+ZId5u2AOdOePDLufz+CSoG60jts9IE+28y3IpnSqMqVb?=
 =?Windows-1252?Q?A2MPmM+9xYXKlT5Rc0JlEX0b1tvZPREN7jOr9J+TNQw924NsearQnw+K?=
 =?Windows-1252?Q?IbEBTtfvIGctHf3nqDakFOSGZaO0dpZPMUGBn+jYk6ziXg188LeXHUWx?=
 =?Windows-1252?Q?vjUUaSh+r46Bn+2GYbZFQKMsvX2537EnukSTvEuB/tsjBaS1rTwQF05z?=
 =?Windows-1252?Q?BRf+Hv8oRLQ9ovOC3XNbwmD51/GRnmf6Nv98CtqOyaCP+OXAmdgI6mUd?=
 =?Windows-1252?Q?NptOMr59Y2z29JsACeuhog6Ipg3ic+qYCzAsISHln1RYVk0YPvdpm0XE?=
 =?Windows-1252?Q?yK1sKH/sFKmCw57f+8ImSJdrdgiWpmfgV/RQS8FFqKeNV7dCe0BVTlsE?=
 =?Windows-1252?Q?vmixOYkH+O8LE/yAypXWTiJnNBqdjTZ+T7Lf7souwEhZyBqe8LyUTY8d?=
 =?Windows-1252?Q?qQX9+8zZ1jZk+wCht1HPLxWIFvJMLRzh6TSe/YrqiZG82NDcr4F5px3M?=
 =?Windows-1252?Q?sbKxJAALywTMigUcHPqSFD6/g+NN9vIyZmo3wTzfgCJ48iA3PN9QEmL2?=
 =?Windows-1252?Q?oIdnmtX/26eSUlAylgXX/t54QVM7+nI9KX6BrWpihfLIdOYBf1S+StQ/?=
 =?Windows-1252?Q?botGbfJyhR6pnrvKHjHP3r0lkiaqlJrRsSAvi10NH8jaA5jbo87i4JTq?=
 =?Windows-1252?Q?2J4wXYrBm+hcxa7YfCrfNP0YBJwA/MtKlUc/P9BYxSRWRKhyqCxcJTN8?=
 =?Windows-1252?Q?jep9xFOZXyB+y6SIMDewk8MwEotn2r+VOunI2luyFiqWsbXdfSkNtjTD?=
 =?Windows-1252?Q?aImSagntbv+CRqOeIi/ficEjFVZmA0VXuYbqPnR4QjXriUoZTG/YTScV?=
 =?Windows-1252?Q?SU1YzxyyNmcHwm0K7fyGIOCd6tOr5lsFl4Ztdm68aUpH6cLz2AolOBm/?=
 =?Windows-1252?Q?xWJg19Tu823ycitHZVmNhGYWPKF3dDu4SyBGi3M1d+1BW+AygVomduEb?=
 =?Windows-1252?Q?4Yxj9T2OzW1HbTmg9l8Ox6jE8Os5k38VzJafHReApbRLCbsc83FUY4M0?=
 =?Windows-1252?Q?5CPPRkDgVQnA3Jz1tbOmb7+WfY79cwGZM0KM/hhSgXBqpLH4lNxCpg0/?=
 =?Windows-1252?Q?ZvGQKVargzzcrpqTrENUaQt5urn2Hj3QsImem2zgFV41sd/Hx9k++nft?=
 =?Windows-1252?Q?tC66fme3ECq7MB5d42G4Mcv+3+DjX9XoGBaZw2oto/90TjVjnDAkboyx?=
 =?Windows-1252?Q?6hNpOlste9n1EcVDlwbLQIbqvGWq1UhbpP4wbG80Wu1y+z8GtY1GLb4Y?=
 =?Windows-1252?Q?+EZFRVu42+ZGrsOb+wS/soS6DB1uO3Iuh3E3k9lTa0zPDbl+ZgMxOYEG?=
 =?Windows-1252?Q?hjYcNzfkSccwI9iQHwQLe7kqEkJo24iY/A4NCuIZChkdc2fudxy7gr5L?=
 =?Windows-1252?Q?jygpiBu3EjhOfhc/JTwqzWLjfKvyyR5+9CppEEvSCHpOq/jJ2lLK0jKS?=
 =?Windows-1252?Q?YMjt+//g2FfxDP+TmEc3Xag2IXf1gYnl069EuoWF888vYyYS2Sl1/lgm?=
 =?Windows-1252?Q?1C+B0brtjedlRoPY9Um+pFppfDt2OXDyj0xeayjMg+8JkYqre4EP9PXx?=
 =?Windows-1252?Q?n4FpZufPotIFdw7Aj1w++Bz2jk9JHCvz5vt6m06OyAWhbbdgkosnHw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB15127.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2d2eea-07f7-460f-8dd7-08ddf5cda794
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 09:36:18.4492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vm9BB8uwppqQV9fxRf4wuafsyEtqI1e96gJV1vaiN2ZRBJcn0uydRGJ6Dj1jpetzzvcef4tFHsUxE2bFgRKmBQ59I0M5Br/1a0i7+y02ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 09:36:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20072

Hello Jan,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 17 September 2025 09:01
>=20
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This shall accelerate the startup of our lava tests by using a base
> image which already contains all the required dependencies. That image
> will be re-generated every months by a scheduled pipeline and stored in
> the gitlab registry of the isar-cip-core repository by default.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml             | 13 +++++++++++++
>  scripts/Dockerfile.lavacli | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 scripts/Dockerfile.lavacli
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d951e160..de082272 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -674,3 +674,16 @@ cve-checks:
>        - cve-reports
>=20
>  include: '.reproducible-check-ci.yml'
> +
> +lavacli-container:
> +  stage: build
> +  image: quay.io/buildah/stable:v1.41.4
> +  tags:
> +    - large
> +  before_script:
> +    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWOR=
D
> $CI_REGISTRY
> +  script:
> +    - buildah build -f scripts/Dockerfile.lavacli -t
> $CI_REGISTRY_IMAGE/lavacli .

Nice. I haven't seen buildah before.

> +    - buildah push $CI_REGISTRY_IMAGE/lavacli

Normally I'd worry about the "official" container being overwritten by deve=
lopment branches pushed to the same repo.
However, I guess you're protected against that due to this job only running=
 via a schedule.


> +  rules:
> +    - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $LAVACLI_CONTAINER'

Maybe further protection could be added to only run it on the default branc=
h, but probably overkill as you will already only run if $LAVACLI_CONTAINER=
 is set.


Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Kind regards, Chris


> diff --git a/scripts/Dockerfile.lavacli b/scripts/Dockerfile.lavacli
> new file mode 100644
> index 00000000..763ed4dd
> --- /dev/null
> +++ b/scripts/Dockerfile.lavacli
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +FROM debian:stable
> +
> +ARG DEBIAN_FRONTEND=3Dnoninteractive
> +
> +RUN apt-get update && \
> +    apt-get install -y --no-install-recommends gettext-base curl
> xmlstarlet lavacli
> --
> 2.51.0


