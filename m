Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D95FC83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.3])
 by mx.groups.io with SMTP id smtpd.web11.20557.1751452578569991069
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rQBsDTES;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk/NGfs2UEP0iP2jNlijA/00XSr0aC2H/Xt0REfHvlLDLsdQdgLHhhAMvkiuHE2mlH4FQ4OUlyo77mgiVaOS3td6UBbNxfieXeia+3s/MhdxtyOKILsgoAXYnKreKrG3R45D5Jl0AFkNQcYciHVCPy++68Wfo9c5SfZardLGcsuMWDXIYnYKJHJI+NMA25OIivTUd2OG+y/Ma46BWFSOGhf6TJX4N/SRO+EgunnXhLyq+zWtIjC4AxtE5ddtwe13rRTIXst0dxIPHA3AfSIFujmPLy5e+DEeCSjwHOx33JjYN8dpQ/mLmoePXI2aeiAcsNX1WkhCNIxnvvN5ylTTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZMtSyZTAVB1tuukwjtZKzAUtV8338S0fNTu3YIlnZQ=;
 b=Uky10v1rOmikYGux/yMtes47rPJmlV6VKCtPDNvoH7gkQj7cVmw9WrrsvitiLekjcwoZPeSR8EWN1wn1GrI48F/eMcMhddqw0QJH6/HuUvcQDeyszgHkOuQj78iu0lJlXxaRMbLKoBoah7lcJ2vxGtk40qQXSvRvz3t6fO2dVpgxKV4I9aY1VsyNOBhsGDaFSXuCRKAW+ho1cXkdBa4QcFwRkTmN/oO/urkCb2IPe5BYREnvq5WRKXQfs1HSFfJKB3wq0OW/9Lruc7tXGzB97RT0wmCNin7q+4HL0ReuVxAcqzSD+uasx4G6g791X/9M14yRMViWJoK0O+gxuaIJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZMtSyZTAVB1tuukwjtZKzAUtV8338S0fNTu3YIlnZQ=;
 b=rQBsDTESBm2/j3QEngl7y2ELNetyYyQhqPfxQBMofIPmNuwrfS5/0ZU8jMsWXSf78ZBZNwfLELVSSF+QnxTnPAS7bcSzJ6qS6+twvi6+rHOZKPXPamsr4gTR2eE/gSPo4FZGcNQniDtAy1y/XanuNTwmCJllSc5WNy86hucJPTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/12] dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
Date: Wed,  2 Jul 2025 12:35:23 +0200
Message-ID: <20250702103525.117166-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 775ad0a8-0937-4a4d-a156-08ddb954463d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RAr+X23omGDUSgHuTxd6AVTsbA93HPqlUIonv6dlvQ9VRO4a6szrzWcAw9/N?=
 =?us-ascii?Q?7Ha4F4r2ZPWjMXVCaVeba4s+Yqwzbt0U783V5pEY3w779YSMs4pHGy4KeOBd?=
 =?us-ascii?Q?zBePPoSCKzoasBMhK+1rY6SfQUdmKj5b99IkHNWkZZ8fPmzPK75i255wDZnB?=
 =?us-ascii?Q?fqAEGcs3gSHS090mZ9QoC3nXPrGSNb6JcB98YC0iQQ4czmL5lk+JAF97Ewm+?=
 =?us-ascii?Q?W7W3HOF5WyoRduf/iaxGcQQVctTeeE5+hn2d2Sn+2GmFzLse4zNyY1bR6loI?=
 =?us-ascii?Q?0qe6J9r3aocMqEUyOeNzIIjCd3tX0umMdleyxmYcXwhG3NGurrGzRiGEo2hT?=
 =?us-ascii?Q?h3u5kZn1ccmaojB9Ol7pS8ahYzuXbX0e2VRMaHO/buakz0quTsepH8fvf6hv?=
 =?us-ascii?Q?A3RlxjOVetxSxktvCXNZZnVscpvzFMtTFTjHjzhWpB4EHnZ1DkrKgscjaoQJ?=
 =?us-ascii?Q?sMdM3JpJyB6K7MQ4fFB45H2J+HKAiT1Cmke6tm3dv+JfWPH9jDFJLhyDJl9C?=
 =?us-ascii?Q?otCxXgWaGyE/HU3Jz3lKtqSuxBjaXcXVwnCcq5Iv//Iz/dQ4x+pzumEKkwbt?=
 =?us-ascii?Q?KVD0YqzebzYRdj6mm8Q7Z5YiA0fNIHshMxmmuPOTFf6mj3iDEjU9gfYcd78e?=
 =?us-ascii?Q?eLqndeo2dXDcyd2qZoOQ4bE7URp+BzVvGxKJulAmmdtYb77gql1lCqmUfMIL?=
 =?us-ascii?Q?+K+SG+Gt+/uonRD5SxeEvyd/wiRz9mitciXCI45udkzMddKe6KF474LjpL+X?=
 =?us-ascii?Q?jknAToV5UgurkSBVjMJNksIY99zH4cxpbD8YrJsJsUMxhDEpPZpOYGD3rAq3?=
 =?us-ascii?Q?/4+VqkVl4Xn+ygek4wyRQDvA028wGEJOdm2wFQd3HcpytBBSiUJXyJK71KAQ?=
 =?us-ascii?Q?+D8T9ZU6ofaGk7UQqCZTG52+bSFJshznN6jFll2KyNv+L4wptAUBDXiF19ee?=
 =?us-ascii?Q?z9G7Cpm0xWXQVoO0myhbcweyq89FXKtCVUP/xOPe4M1vBAMjYD/o5wUwEi76?=
 =?us-ascii?Q?eTJ2CXEjaZVBxsmbzhL11D4hvPrt4gH7j8/1H5F8n52cuX2xR4Opxn6pN0tq?=
 =?us-ascii?Q?tNIFF1z0XI2zu+d4rPOTD3tXIVjgIs/gm1KwWs+TfshP82gVGJRYQf12qmFp?=
 =?us-ascii?Q?72BOJckNlPthllvduJc8FF0mADVHlkdvl+gypZTMBvxRsZZhwRPr/RnJre1D?=
 =?us-ascii?Q?BCG2Lrd766CeWzllVob1RMUilxW165deRckmQJBftDxL5yCmHhqbFGydBaB5?=
 =?us-ascii?Q?guGpV8J8DScrXHUb96SNE+AaoeX6jAC8sHLe7/Z/nnuSNDRqcDV4a8/8PJ/L?=
 =?us-ascii?Q?6wGw26in5oZ5MMwtLEoogv/anEFDjWd3ASfYiNxxe14XyC9HlkmvLsibguQk?=
 =?us-ascii?Q?t8ewrXW7FIPYkYWyT0e5ZojrNZ2zDohzCKj5URmFcz6xjDXQOMUcKV7E4gBT?=
 =?us-ascii?Q?fHWbRofFw++UDBAeXA3+gPByeSqyU1gj68NzG/x83/wWyjWA29O6ti28n3Tp?=
 =?us-ascii?Q?ciobAkHjZTRgaTI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ze4mGrVUrDhRcw3oRsU5tZwB/82Mn1QO/JBSbbUCPNp36YT+CoSX58tXcbDW?=
 =?us-ascii?Q?qMQGmC1H/2cBZtkXJauovBWpGvxfPlo6DsoP4MbppeNZrY0GH9rw9dUebQSR?=
 =?us-ascii?Q?dhWFClZXu2Rbr9dN938Z9eh3YqSxZQaxYsUlNOT0QrDwpXVcArs1UVhyaf6t?=
 =?us-ascii?Q?WtupGuu+U6AQ1hpWHo3nZj7JXvTdO33/fnrXIDSy6NbJr3OshXyed8FsKqLz?=
 =?us-ascii?Q?u3EjAkDcT2LOK3ycsJ+Yxn8cS6MtMF0N4Bg1nMnf1g3I0vQOKPxlk6ePGBkc?=
 =?us-ascii?Q?Na4MXhVaE2nEer0tKWDh/1wSTzdn3J/KWBZROFeMNKYoVfoe2ADSNEXrX6Ih?=
 =?us-ascii?Q?Wu/q/5lzH68d9LyoNrZHpF34HNVuG2FTi+xdt4sj1l6eJL24xnV/99eZGlTT?=
 =?us-ascii?Q?TtcUDsGi/X8CtK3yjHRtIOifOfjDGZzlfA+fesMrL6ixHy5gao4QF5o/8H7x?=
 =?us-ascii?Q?SElM40sAm4DB72y57l+eA+XEyTxGKcdakQloaT2OD3vU8nPxKfmFD2/BTvX4?=
 =?us-ascii?Q?Hj5/3EWsRA6D5Bxq+RJkCodupNdIOnAXWYbfbZY1xLjv48nD7x/eihCHTPIa?=
 =?us-ascii?Q?5OKiNOPJXZZDa9W8FDXSyxjY808t/13cqShTfNmlZf1O2k3LliM7iDrQrKiH?=
 =?us-ascii?Q?ePP+YAXXf1lb1rtwboWclDG5gVxrpdyAtHTf9IxcjnoaLsIFR6YJlk2W589l?=
 =?us-ascii?Q?qeicnB5Jz21D0hmRUrJEdsWVdkx7Pgspg/9bPQSEbwYvuNIcaKQRDQ0whPCw?=
 =?us-ascii?Q?F11/HSpY2+5K5HFhTWizFenHYLTg+40NoKNIHfAw8NpqPQt476S4sO/q3fdp?=
 =?us-ascii?Q?VwgvnsfnXa4rbJug4tfUBG5YISCfm/r0vnWs5cqE8OUSU1Vuc8QsR6rA+hnJ?=
 =?us-ascii?Q?X/th7JPDH5P3EePVzh2cX40tYSsYUxkj55q8WGNSuvQjHttMkRk6Z5zTL7fa?=
 =?us-ascii?Q?ga95iJukL70kSGSnYF9Miuh/LB0DZbwndvkB/5Ili7agVTYt1xZPCd3W/Z/l?=
 =?us-ascii?Q?PxFXLXN1lBk4YnYtEQLgYtZYYKOF91TWJGJ/RDhc45aoz76Y5EQe9NS0gBq7?=
 =?us-ascii?Q?o9S/37XAXm79KpOqWJbz11oVXoRSoxYqpxRloSH772n1CdwlTINDYM22HE8A?=
 =?us-ascii?Q?rAKrp2QOThre+GLvKVZ2cudjNvJWLAcPJ8vgiuGwLxatTqaojoOAm+gAawn9?=
 =?us-ascii?Q?fEB1U4zQLgXni/+bCBPXrpfEAa29AyVAYqSlgrF4GQo5wW6fJKlg/4qmm2FE?=
 =?us-ascii?Q?6KMaHn+XNOnUDDcrCXbj1GMudTZxdYWyeP200d8CmABBlEwTkw5Q8y+HUHEF?=
 =?us-ascii?Q?d6zCVXrJsjMzdS89lIdnQwWtUBNqVfG0FkG5IKzYURe9gZ/X0JCD6CdGIbi+?=
 =?us-ascii?Q?G3l7Kt989HJnwzUUi71xiPWIDLF/kLGwsmUS5iFu5arKKiw6PxUT9IpX3576?=
 =?us-ascii?Q?++0wFAfdoqXp6FLyj6soyTHk2GK8m0ro9dA1WCUAXAI4ica8Nc4htJtz3BNO?=
 =?us-ascii?Q?n4NbISeTNz3IFCgGFlQUh8cnQlXdga0DAywyKltRX/2lMzK8awkfRaksTR9I?=
 =?us-ascii?Q?kDoP/Eb7k6d4kcEpK+Bs5QDG35EulKHwCDjGxfk9N0YU0ZXA1eq0CgH2VfIy?=
 =?us-ascii?Q?6X7++va+7uRc7KpPhVwRIYw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775ad0a8-0937-4a4d-a156-08ddb954463d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:16.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvSYEHDFTnqOaNLgUw/NPMl31OEULfNuRRMtpCYbSAOj3cJ+/pZzsNie4g0ruSREJkis53yXuQvRjpSmSL43AfUc0NNUqoI6tVk5UFBcoXvFL1yQnyDhyZjbmucykRt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19295

commit b9457813016841df82eaa39f1f00ddebf385f352 upstream.

Add a compatible string for the Renesas RZ/G3E SoC variants that
include a Mali-G52 GPU. These variants share the same restrictions on
interrupts, clocks, and power domains as the RZ/G2L SoC, so extend
the existing schema validation accordingly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250528073040.904033-1-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/=
Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 2198f97da516..9d42466c59b8 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -22,6 +22,7 @@ properties:
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g047-mali
               - renesas,r9a09g057-mali
               - rockchip,px30-mali
               - rockchip,rk3568-mali
@@ -119,6 +120,7 @@ allOf:
             enum:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a09g047-mali
               - renesas,r9a09g057-mali
     then:
       properties:
--=20
2.43.0


