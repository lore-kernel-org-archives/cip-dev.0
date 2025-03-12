Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D49C35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.19])
 by mx.groups.io with SMTP id smtpd.web11.34883.1741778862917121101
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ICNAsSUk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfH7C3stc26+1qPOEdg2kljD/YrXGd4yvSlf6WIkouohruRVy34UqdanWB5V14OT3Wp2ImCn+pOKDqjIlHZdVPDMw8Tppj8zuwqw1kmtnyq7PahuYU/Ng+fDTpGgO6Czdh7Gyr28I2QomyRTe60ENFocvarMIBDrScb7jumH20cOkc5AO7PWcxIOVRdpBDmAnmMsPN8h5Q5W//uaOhwAWFeUEbxLji2x/c54h0XyrcvtrE5219Dc5F/MAsGxSepCpmYMmjWeJ12Up1ycWWKQo8pRwtgRv1agqZkKhJhwrWc7mpw/mKEfy26Jq2ApqU3CQZldzr/UNiMB5HFarz1V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtYP/N08pzCcVBSU+jeUMBJtydddEQ2HKROILWogo3U=;
 b=ci2G4VIG2AcJwO+5ZaK76xkm2PlypSMNmye1lzdhp3utH4xymYxvSYBzGWDysaSx96lhtQpOo36BhpAOmtvGvBuS8wQN6+o9M4F1gNpq/pTPCNqiIZ1wTlga8J7/W27Cl9BqMAJtNdvh01zfLlA0OKTMMBHZDa3ei7wPyofbVkvTS9AaPRx4KaQdCs00+YQA4rEOM8ddnonnSq4RPM9Hsl9Low/XLYJA5yXDxsXQ8GFKcUCHtebmKeksoVckg7HuGeMKKXBxuV2hkTqunG80cSHa/OaU3FVc4+LjAJ8K/1bxKK01j+BSnhoUAatUWXTIU6+e2JmJZCtSwp+pCvW2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtYP/N08pzCcVBSU+jeUMBJtydddEQ2HKROILWogo3U=;
 b=ICNAsSUka61nutVIQn8m9iiDKVFxAL7gCIBIIGfRBQz3kcViys9qhDDvBfHcwWdbqimU77H6QTnsSXlLh/EU0AXzxlUEy6oxfKI5ZDSsZzTzHBk2UqR9qSTddCT9Sa0taiT0LzEyxUX+kSTBAR4uPnS7gZ5iARnoqoGpTMrtB7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:41 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 84/85] i2c: riic: Add support for R9A09G057 SoC
Date: Wed, 12 Mar 2025 12:23:01 +0100
Message-ID: <20250312112302.1605750-85-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: 541691fd-8535-4bf9-75a2-08dd6158e6a4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X1Out+gBOwp3k+v6UdFcduN2wcouKdT5QQgz6bfW8tHwO812Pfnvykq2fShz?=
 =?us-ascii?Q?Fx1MxmfBXgzQehmMEnHTxMFkxlVGnvxFzaqNLe4epxkHtNjT6MsNO1y5Mwc/?=
 =?us-ascii?Q?Y6sVshkSMwrZGqXFit3A2R4E7wLlZWPGa+17R+SciIeqNnnD4NDUqpasCYow?=
 =?us-ascii?Q?Nj2eNeuebcHKP48Q4vrDoJgbsTYqANuEw2aPUhs2C34bhrQwEBdGf61UYIs3?=
 =?us-ascii?Q?keP2fXyi+MIICj/SumI1/XRo+MKrvu5IV6yQwEbEfZwVEsRb8la8eo5rheF6?=
 =?us-ascii?Q?7vuddGb1Tr6y2Qv1SM1viTdG7d058HpABEyMvsDK82/wVMY48HcRA0ujhYQC?=
 =?us-ascii?Q?TLisqYv5xHb71MHe95FWfz3gOfixkOkkjdUJfK5pC6eblebMTneocjUiWIJT?=
 =?us-ascii?Q?Nu5iYvengyd3aSfeCUif9AQeG7IzgINeunfvoVOTVztA3HosyN7m+2MvjKYu?=
 =?us-ascii?Q?5EUDTngj9IrZkJxFND3lz/kMcp97LZU9ZnxExZ8erh1mc+sUlxXKvbedct0w?=
 =?us-ascii?Q?e9Fn1qB5+SndZv5uKYjxJ4Jd+WCsCetT6bIXnoyb9pRW+mHB+wJA/9sD0jxV?=
 =?us-ascii?Q?MWlNfHU7qIgzEKADaxCcKJyfHsObVAiatFjup0w+W9/0J7T4Ko7fdwbzsKgA?=
 =?us-ascii?Q?oWt32dczUSdl7zO9rD+AX2LZznGG4s3bOJ6tSTK+tC6xqvGekkqr8bhv3+/k?=
 =?us-ascii?Q?ES3DtJ1DIFSpW7nwG53CEdYL3fIdwy7yKpApY6l3iF4f61dSm8gbkQ3CfdXM?=
 =?us-ascii?Q?OtfjEQVqG+vsdYQNansYDzEytHP97uW4nYIDDyz7FfyFEIFLbdPLxSzSde3G?=
 =?us-ascii?Q?5pOgWeRUp2KjjJon6OuBW56DZssekW8/ZEbqCpMa3NT7MK6MiR9WQD88xCCN?=
 =?us-ascii?Q?cjGyyBYl89QJc/e1AxHhaD/JfYNG3431gH2SKc8s572jfg5UwwtRaGJ+GHHT?=
 =?us-ascii?Q?UqWh77EAZC92+256IwDSSyuRs9UPcjzg9DkyBGjmcxwQ9RuhU4J02bGVBM8w?=
 =?us-ascii?Q?ATTvV0jQwET+p6rojrFv38lcfzss+e3Cpz43QLZkt8nqdcYKNEwA3ARvs0kF?=
 =?us-ascii?Q?2fDqBTL5yT9RM+0vwd56J/ZkRNDTeBFzLTID/LmadV2S8D6caGRhh5wQEKws?=
 =?us-ascii?Q?IY4oQElI04TQLP5sRPtw7xl9/HEeaTZMaewFIeuEsZxvJvgtY5/81pVMDMJy?=
 =?us-ascii?Q?Cy5/YuEm5b//nEMV5Es0oUgJz3zVUGuXRJUxSU8amzVJFSlYbh5VDWd8dfOL?=
 =?us-ascii?Q?YDMRM5OjKJbZizMPPSbGAnpVX5ZAXwWuk20/exEOTbRwt6ypGLcJfEi8g02u?=
 =?us-ascii?Q?+yQrJYFqSp/uJNUovyGYlaOD9L4mV+w98AIRS4g1MRKHH43OkkZwB3duFNFJ?=
 =?us-ascii?Q?OjZKpbSCTJjO1um+PLHbxHAWmSHRWCsE9mxyhkELMa5oyFxhj25YLXg4GR9z?=
 =?us-ascii?Q?cWCQKaFYXHqBzavQTZQ0IQ1MBeCvHbzK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JiTvKqBJDqESEJGj0CUbCRR0LQVGH9kgu2qEuLV9nZ3mbgk6FLWqzCfg9U3v?=
 =?us-ascii?Q?i5r31fX2DMRvQdIC3MowCxfsS6aj07p5kuzhBaGHORJPWvNPAD4SqSW4etKP?=
 =?us-ascii?Q?jV69uLnpteAQW07eIVc+mpseSu3ZdElYjQXr/CVPuXm17QeFA+ahvFOOZdLP?=
 =?us-ascii?Q?5rNyFhUAaAZb0D0T5LxBBiICLo+aNCUJKllHe5egRlcgE++ShiFcSiCiXGYQ?=
 =?us-ascii?Q?GIwyQZcFzZL5oCLU+Hq5WglB3q1iK7920lbnye9ue2hy6v5Qp1hTqDzKJwcA?=
 =?us-ascii?Q?7+6J61qPraCP/ArVUzKX1ptiZM5fcyGs2bOyGRns4fhWD0tp6SRHnujhfDwL?=
 =?us-ascii?Q?rBKlXyag5a5SfGJnvzV6+OESsQ9cQkG0Uc9Fmy4vTnyqECJ7zWWzY6yvDVXm?=
 =?us-ascii?Q?2vW50jN5GJKnML5Tu0jNRthNY95cHUcMZp6SIkUxJrYi6shUYFnNQbYFED4n?=
 =?us-ascii?Q?BP/+frwGfYypGdW3FIv65iRZUQbpLsdY86vS4UqTmJpHWuJzuKCW+7ZHiYXs?=
 =?us-ascii?Q?9ChdR1/8p6e1gmtER3xGQLkfaXZzKPva4X6IY2g/M7TuQDrhF+4D19bR4uoN?=
 =?us-ascii?Q?D9OnPc/AlZcuuxdMKXAc0feYGiYI4/JMU/ebchG28eW/d7hbSagcGfqyn4Lf?=
 =?us-ascii?Q?LoB0o6a5zkkRpZqFZjppNecrpUnXeKo6VB5FQVuolDsweN7UpoqPJCG9ZR50?=
 =?us-ascii?Q?uc96aYA01IvO6VnzG3UoZmSQRMwMggRpiOhSSh/w4AZ6Al+DrMQSFNZjh+dU?=
 =?us-ascii?Q?lPeRcremYc5Giv7dzK2o4DU3oXxgyQE4i2nRwi6H2a/HRAKU4H2eSSxoc5cR?=
 =?us-ascii?Q?kvzj9I3WASK1eSJOwQCibEgzvjWoMLjLx1TNoQfdyiJrWHbxmnUOVk2d+MEZ?=
 =?us-ascii?Q?asflXS6cH6Ok/Tr5yqaLh2MYFQwXITcak/75fTYlWPCgeQs2uFAvNt8ZLbv+?=
 =?us-ascii?Q?wRTb1Hn7uKtKuNqc4ICPYrAYSUbWy7Mh0z8AFNq2l1aAtUeki8ToV1pRGG0a?=
 =?us-ascii?Q?69MNcBmXnlfVemjy6vpBSkiv9oN2SQcvnP+yoyeLBswfVOIq2e7Gb6ebLMk1?=
 =?us-ascii?Q?gnSRpihq7rZuc68H1BD/Mq1uWT2dMctwVhT/sSOWbgssu+Q4fsaO6Jn1+snr?=
 =?us-ascii?Q?UULA5cPWA8bTDGSRmrt7+7b8MCQhbsLkkSIMWGQCAVCNVDTdR1G/baWlRD7R?=
 =?us-ascii?Q?NYKYlFDVttPzwtBm4hkj+AsdUDRomlNJZWd7mHCl3qSoOq+kZEQGir+ymIi+?=
 =?us-ascii?Q?m6PDQ8dhyI8vRlLJzoPtOLEfWxJaf/TSO61aP7IbKniYY7VD3xAiZBeyhpcq?=
 =?us-ascii?Q?dVvji8NZXqebRFn+VVMHJl6fF/QHEBZidKI1VMK9m8riYOQIVmUpC57Ziqhu?=
 =?us-ascii?Q?qioc/1RE0qofmIrfPZ3tMslojT1X5Hm+ohwNI2GbDluHrygNPORzNCaQYzvY?=
 =?us-ascii?Q?qBxTZ8cKYmHmVnjBHMGF1eacZE5QOwmlYfhdWXHjJVeL7CiQvMMQBTa6YwE3?=
 =?us-ascii?Q?iFflEjG0ItO+T/lR+JoQoD2LhM8GRp/r0zFzfuenSGYjt9dfuhDMBLPG9bXq?=
 =?us-ascii?Q?9iZYb0HMkU8JQ6377r/DtcydZvrzHdD11Dte/YZLIid/Yz8ge0gXFWi+fHAB?=
 =?us-ascii?Q?cgpt/vEsnKfPYROArMIY8ZA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541691fd-8535-4bf9-75a2-08dd6158e6a4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:41.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRNjmzZZVmZRkbZwtJQ/E89sTuy09seBU4lLVGKkboBjKFMy7m5vO7PeIT8/2Gd0lQ6n8SXDIbmrYQkK0N0tRycEoegofkNcCkRrpNp6IzZt/bCAxCs9H7Z5JytgKBDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18176

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a45f95d7480544fdaa9d566cb4956d0ca5d0dc33 upstream.

Extend the RIIC driver to support the RZ/V2H(P) ("R9A09G057") SoC. It
accomplishes this by appending the compatible string list and passing
the RZ/V2H-specific OF data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-riic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 3dc806f72b78..9df80c4c2b5b 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -526,8 +526,25 @@ static const struct riic_of_data riic_rz_a_info =3D {
 	},
 };
=20
+static const struct riic_of_data riic_rz_v2h_info =3D {
+	.regs =3D {
+		[RIIC_ICCR1] =3D 0x00,
+		[RIIC_ICCR2] =3D 0x01,
+		[RIIC_ICMR1] =3D 0x02,
+		[RIIC_ICMR3] =3D 0x04,
+		[RIIC_ICSER] =3D 0x06,
+		[RIIC_ICIER] =3D 0x07,
+		[RIIC_ICSR2] =3D 0x09,
+		[RIIC_ICBRL] =3D 0x10,
+		[RIIC_ICBRH] =3D 0x11,
+		[RIIC_ICDRT] =3D 0x12,
+		[RIIC_ICDRR] =3D 0x13,
+	},
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] =3D {
 	{ .compatible =3D "renesas,riic-rz", .data =3D &riic_rz_a_info },
+	{ .compatible =3D "renesas,riic-r9a09g057", .data =3D &riic_rz_v2h_info }=
,
 	{ /* Sentinel */ },
 };
=20
--=20
2.43.0


