Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4FAC35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:22 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.1])
 by mx.groups.io with SMTP id smtpd.web10.67890.1742914641706834031
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PeuJKaGQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyXU0J0mSXaJ/oiJ9prp0VCragM0nLBIEehfFe/A/bn70UU3sF6Zw09eR9gY6lN7VJX+MYl67rT7J2FVCbk2Sz0TtVKv5dV7cLT/XVqIZbngmDeeKxLDr3EGkkLPcQDGxnv5NblWXmpk8WaR7/mwTTuV6ME3KodG3bhhlkDG6k2ra78c3T3QasPUrckY+VWbJdngxsQSFUbaQfJYCLvzlKUdrXFHxZnBQhsCN9tYjqSW+HXIkl1e731k8ouq9BS5Pwuufqe/x2i19MB6sKX3a2dPnTE2jz7Zhs3TrV34OyvnEKQrKwJrstdOmxA97PUhW0BQhiya7/X+Lxw6Sw3o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzDp7IKcdMJzD+TBo6eDyfPNB9zBX6BsylzI//GBdVo=;
 b=Swr0JEmEvlJ5bqvRWcBGSaz0bgzm8lP4wwhUMrcg/409nGO1h6iIrRSH7p7eEtrRvy8dx+Z0ryz2H1obX9dnyC9eFJROV/bzn9jnaQdHqlLMOrVn8MDwBEOgrdDGsIQjxz/dVUbPclHPh7J6dG9BKUIQxn1iFA6KGsLhlppS1PMhO1X8KSKBWGhgaZycqmhroO9j9n7kGPzBtqjDgCP4ezmdGolquOgMViF55jMc2WsK8f6qxaShcY/ZFewJqN8S7P4FAc6+Kk3RgEuq5YIfS/tFy1+lajxiqA6lpYMAgywtx6XsG/Tm5rAp3V7dCAbMkYJs7NeKgvhO48ezA1Y3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzDp7IKcdMJzD+TBo6eDyfPNB9zBX6BsylzI//GBdVo=;
 b=PeuJKaGQLaSZMORROTNU9BQ7ssIy/yViH4L/ofvssoGCDcWTxUqzU7Di6iYeoE+ByBbq8rXHnfeTFWF2mpig4Ih6wTQz0kT6xBP8cOf/beRwHOeRepExiJCqpDZOd/3AMpu2Vc4Zp/mTsnOPDo+6gpaRhp9BT5hO9JsCEz/rOAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/16] arm64: defconfig: Enable R9A09G047 SoC
Date: Tue, 25 Mar 2025 15:56:10 +0100
Message-ID: <20250325145611.3595454-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: eceb6a27-cd8b-464f-7fa1-08dd6bad574f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KiuDyEXYkTeRshSJlc/k5vg2kOnfVO6hO8ur48XkKBNuil4RALt7Iii1EFI5?=
 =?us-ascii?Q?4N1UT93lDVDVXmJWkOj1yAxpgh0f1hbgKkw1jmpVyoM4LwyXWY6quLAOcJ9i?=
 =?us-ascii?Q?JTphBXB2oAOSo7WqPz61OGzGGtwwqcB3RCjNVAgbGugLvKNCpP9eF3cuIPu2?=
 =?us-ascii?Q?iIGB3Jj4QAZRV+DvIRBo865vsPBVXqQvMVV9YcUg5UIUEohNkpJH9zCHKcBa?=
 =?us-ascii?Q?bmLtAwxU0sHELOazDOZ0gUpZJF7oksMZDQ/yOa31PcOStJ2TlaUSa3HTXddm?=
 =?us-ascii?Q?ycCB6T9KatBqh0GbjTCC925/3hs0QOV8K9NoyRiZHn7IV3JuMNF7+bAeg4PL?=
 =?us-ascii?Q?9Ppm5RUVR3A0EChKxA+WHjF6zRuTWql/fky5eZMGNatbn1k89NW5QETgkmHe?=
 =?us-ascii?Q?tvLkKXFFW+zBJdi3QcY4am4TMv2IPsZRT6ZvTGoZVzmHcMXdjPv51nooSSGa?=
 =?us-ascii?Q?M7UK8YQvk3rGpaftrGNaaDD1G8qkkIGXdsoNBTwBWh3JX7buEvzjz7VdAZUX?=
 =?us-ascii?Q?9SvBcu0RZtpumblvmOpbHkvEs/tIYn52xr5l4xJC5WiKPbXWfEMYzgsbh4sf?=
 =?us-ascii?Q?PrUIh2TLwwTnn2KiUiS3ywVEYHTbl1mZoEuA2R9gLdASxzrQB0glIQKKt9BE?=
 =?us-ascii?Q?Sg3nohSWZdmwS//FJLwcur5OEbOH+9XtnIWNDytla3dYtjbpRvgfLwM+tSRu?=
 =?us-ascii?Q?3ohYlNVfD9clbfmzUMDOeYaDk1tV0tzpNKV/mgjk+o8QorWu+jBifjaJD/rm?=
 =?us-ascii?Q?aIRGGuncpGGIVaPzRcSA/2K3k2iTYLdPFyFJsVbX4fmA6/LuWc8MPSkZtdyN?=
 =?us-ascii?Q?MtnNF2QK71YOofnzFH/zG0h9SsdIf8uJ+XjSN7/xPz/dvYaKwxkcasewnZ/R?=
 =?us-ascii?Q?4AUcMtJZuPFUmb91dIRZgL9GQadXz3CPd8h6sLZ6qYg+UPkPRWDy0lY1Ly59?=
 =?us-ascii?Q?oeqXJ8P57MLo0nuD+6pPq8y91bMzBTTQD1w7Yqf4q7xfMzQaRX4bp7wTymwH?=
 =?us-ascii?Q?DoR8CSeQwQ6XOgrrtcz/xe4gKNsFPZqP17iztrG16TYYjvffgF4ZjTAd4aHJ?=
 =?us-ascii?Q?O1BnmIpWwuwbXmXGwlYxon0+HwbASYGFMG+FpXCR7mxYuWh5NH5EmYHDdXJy?=
 =?us-ascii?Q?PfOehzUTwJR66McDU+XH7DuZpeaREGnGNfKZy+xCzMWVyywkPkpqjgd8Iday?=
 =?us-ascii?Q?6KE1a+MXP0EdP7av4LAtqiyJCprppafdKjcR7axfqOp1e4c6M6YvWIl1BVgO?=
 =?us-ascii?Q?tCLUyDZpXLapkj4Ipzz74pY+EV/MMJ9cNQD41MEeP8pAojFlB6b1uXyqAIIN?=
 =?us-ascii?Q?kclH0CB4Cv4KsLQPpa9YsHhIz4gSx/O8B9gOPsZFQVfzKwUBGPhEiYH5jxGY?=
 =?us-ascii?Q?Ei0WLCvbpbo1dJYwwQlkR2xeFsQoakYr02NpHWELgVWHOx86SDFRAfotnAd8?=
 =?us-ascii?Q?qPFqt1WLf0Sp8rBkRJ4ENDEvx9EIv2Rk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MknBWramS3pYlhu4a0gfVPmmYMjTrH4qZA8nxS7pR11l+xsRjbRlh95rjUJM?=
 =?us-ascii?Q?0ixAb8DT9z7GzA0XDC7c/nLbguwzAkPLuLHjjbdYGEPXyAvkacnIcPAkGLHK?=
 =?us-ascii?Q?Gh7woHk/dhpM/VtpM/d7/ASgkWk8D6FZG4iIJ5FSrILNs04KvTqGrKc2lab1?=
 =?us-ascii?Q?ebbm2GYOU1PuSQ8hUdGURWGnUxjRNZA6ZhwF/C+esoLIQM7lN56MdL4b8H3B?=
 =?us-ascii?Q?wNCcEjbqslhuqLvsrcIoGuVqUK9XOr5nNVHz/w7GtWSi9qS6bieN33nvmVbD?=
 =?us-ascii?Q?R47Pq8S1VsTXBzMadtWxjjxR0PwaU8r40ytZ2AQJZyBqU4SZ/zwLJCQXNOUU?=
 =?us-ascii?Q?bVnhNgIOSrTcrZbBKSUIGYwyjjssce1SEfb5hisbXelWO7Xi+XtwxrOwE+8X?=
 =?us-ascii?Q?4yXEcT/GKCDhX//9yRibiETi/fMU+aZmSrjtaDM2Se3fZ/NWkdjgN7iviFkj?=
 =?us-ascii?Q?uoO5h0e32ZrWFXIZwTicARBA9B7BDb5xhVlQjoZb4U+mv2zVG999rvp/r5HC?=
 =?us-ascii?Q?4Hrrb9UtB43AikQediIOE806R3GSe6k4tCvo3EkaN2QLh1DLgtmSdEjZdoZU?=
 =?us-ascii?Q?n5fsMHDICENjCiwuJbqQy7OKKa1IZ/aNZsL9j0DVRAHiBAYrDHh69fWl7REh?=
 =?us-ascii?Q?j24QucjJGcJkg9QdY6MfUPEhhD21MX2Fqs2LIldlWvwTDTTqvHmETU9gzYGO?=
 =?us-ascii?Q?kbUvScACHkczdl0MbghRWaVFbb8uctnFmt9UbmRhZn1AoyYwu6CiiRB/2JNp?=
 =?us-ascii?Q?TcG007JZSjqXV4Q8Nqe9PJaAgsXw96jrwXSklGuX5UXP0dZSK4nnDtBevZrS?=
 =?us-ascii?Q?b76Y43VCv240EMAVxAJzK8ikbYzGYsrFWTzXRb4gVMsRLksYqQDL5LutrfMm?=
 =?us-ascii?Q?RqM/SXVaiJnh6udSJV0lMDX5NtMdUEcpoi0JhEVnDPmrCie9DYx6KH0aR8xg?=
 =?us-ascii?Q?DuLIZogxKrOpg5hD58yuUtguB4JR2rWr23kca3/01W7yGvFtGTNN5xiRQuCT?=
 =?us-ascii?Q?XWMrwcTS49ivKGbmAP5T0KbaTvEYSQ6Yi6DrvC6mmZaTXgA9KjDbTEhyn572?=
 =?us-ascii?Q?DIQLigioqMp+F2k97Pl4G19HF7N30TscKHjLcaR8n8azEiXcbBhhZ5kQolsu?=
 =?us-ascii?Q?2dzSw6aqU0LIjsJ2Xs9Lwu2CKkDdwPOGVj7tQ7m85BizNdhSPexDcHEyfl/0?=
 =?us-ascii?Q?OveZijsgBMUikOzxU/74T+J/0s/Cb+6KIntnpVih8ohLDI9XCdTcnZuSuKMN?=
 =?us-ascii?Q?/uNZ+HHwvSECxw1GtVJdV6pZ+6Wxm5Zlk2H8wPNPASx4uhFp3/kDy3WBztPE?=
 =?us-ascii?Q?jhfSoheG79BjXjZa9TIjLBXN+VUBsR32XSJVsMhuylyd0iVK4F8djnOyNXMT?=
 =?us-ascii?Q?efETy1tlGZInSWv+UZRcns09abVnIU4yFBTbfhGfLl07mwOVATx7PCZqqhK3?=
 =?us-ascii?Q?bfpOHdHRJYiU23wKRKaGqHiW86HCiib0mtfYzmEn7wfxP9MQpdEyKbRJJq4N?=
 =?us-ascii?Q?JQjqmemDN95+V+8yuacvixW4BU9k1NfRK0epe1k6c9w8uVp8bcTFNVNf06SC?=
 =?us-ascii?Q?y0lzlp3WJhxzXN4q01F2XwlJ6omZXLIHm6yvA9TXWtAFlw2yeOhxNDFJHqPn?=
 =?us-ascii?Q?h9Fu/iLIK0PS29zqeDV4ryM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eceb6a27-cd8b-464f-7fa1-08dd6bad574f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:19.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YESmF20x2VTMp/xFF6Ljb/epqXU6rfmKz7Zb96HwqmHlfe1TaRt8wrz4KSULtZ9uX11hZvK/eqUcLuD1DxuKBHHagFn2pupO+C5qdyvZ/3qlXp6fTVMuWul+MR3v4ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18366

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a40f02b2923b6d58e76cfef760b8ed61a00f1d53 upstream.

Enable support for the Renesas RZ/G3E (R9A09G047) SoC in the ARM64
defconfig.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-14-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 85310c13107a3..4eddb85c1211b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARCH_R9A07G044=3Dy
 CONFIG_ARCH_R9A07G054=3Dy
 CONFIG_ARCH_R9A08G045=3Dy
 CONFIG_ARCH_R9A09G011=3Dy
+CONFIG_ARCH_R9A09G047=3Dy
 CONFIG_ARCH_R9A09G057=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_ARCH_TEGRA_132_SOC=3Dy
--=20
2.43.0


