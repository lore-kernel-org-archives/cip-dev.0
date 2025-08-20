Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4082CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.41])
 by mx.groups.io with SMTP id smtpd.web10.918.1755705895978179196
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ipUZs7jO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfjpAexOb0YcWOcbLsPRcGSpwwSMqEB/QVEjkNpB3/aQFFWLOFCu/Uwhwhn8hNqBVdC3d4jPXG15jlbMJLXUUTtJmC8MiSGjIhIaetFMJjDN1Uu9vg7+WBrdGIcy5MnJIMXmyVTJ1gXsDc4VlQzYtl+tgjUofgOR8czIEHSws2mz6O5sSaiAFAHMhasYuSAjC1ZO97uVxErrMTgJcCL0Gg6YwIrtfrppUQ/KKW1wk9BXdbiaZkWImTHzXOoJN5HXSRYk/lll2HYTOpnDzz1Z5vNlntWOpTK0sh1QekDbfBmENQgwSUgHin2c0m3mXJBPhUoy2Id0bCXaERq+lg8cFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiprgEGd8Mh/tkTCIPDjzQIvropawmiY3zra1vodiXo=;
 b=SPxNdUcOpi7QG8Y6Rps3/I9zyBQXQ9+AtD0JGgzKFNvXOvHjn5bEP/P+ujDMt7frrJ+Q74szuUafLHaGn52XMU1ff7aT0G50YSIbFQJmi0rfE7PH2O0NkHd40BoC/ek4Datdvs7iYI4fcEVr4gTdlkxmd5hstEM+Qpkyy90L+mjrlEa+9EGwoaaJ9JCdIy4YdKtuHx/5D2GgcUV6Xr55H2jHdCd/+d7sf6h/88R8AoenllFqjzEOxEE11kzEDylorHLnVpttP0BOc5WpK8x3ABeiW6sb2WgR6GzIureEXyn80L+rLCk8k3Q+0Xge0R/sHqv3pnBWDF7ceYX4hddHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiprgEGd8Mh/tkTCIPDjzQIvropawmiY3zra1vodiXo=;
 b=ipUZs7jOw8+JDN/MVIf8POLOTtfP0mcn0TjTdeZeno1NNBgRnAXQZOhkfzii9Y3gGcj0LIaet92Iq5U2V20KsBqcVdKonkzpaWlZzOvhFUCO+lf/1q2+SGvFWhz3RnlkKF4XGpkhKf6DgRSeyj9DY/XTqp+e9R68LxbVL32A2wA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/55] media: platform: rzg2l-cru: rzg2l-video: Set AXI burst max length
Date: Wed, 20 Aug 2025 18:03:21 +0200
Message-ID: <20250820160413.801341-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e8ddee-8605-4e74-fe4f-08dde0034cdb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?omXrA55C/T1zuRybFwio4ak7J8tsruxwFKpZbKNfkCodFFOOHHCrhUbXCnlZ?=
 =?us-ascii?Q?hUiaZskrnG8gxv+vx03ASvpJSxpmC+q1rVVeRCs1O/ZSrUtu1eNWjuBBTgUr?=
 =?us-ascii?Q?EeNmwDqGlJB17hqcCoSGjzfanKiMG/d6DDBIjzrXqERmS2ZE5JFukOdD6CBB?=
 =?us-ascii?Q?vXzCO2RaQmOe/WXSZqQOMedU5LBNTUZh7OMJb4DKfTTcnS4GyQrwxlq96mxq?=
 =?us-ascii?Q?lJ4YAt95nu19GGcnY+CEgqumfPOMmlvvy21XmkVC4dsDGuZ2YrHFT6FekGWd?=
 =?us-ascii?Q?SRvSVYV4suDwvzMo8TYxhUgcPsUdrc74A9gkoC+3g9J4El3khcI9GgyEpThQ?=
 =?us-ascii?Q?xz7Z4mAvOMDy+FUtrJ4o2nZYYwXF9VxhDwu3k2JHjmLUUfMI25Vm6l0jQH08?=
 =?us-ascii?Q?Ovi7Y/rEhQaoRV7PbOj8/DZdxvhwMZL/FK+LUpYFV99vM5KTzb/yMM4P93TL?=
 =?us-ascii?Q?IT4GMrf4GRa0lCNUZ/RlYQ+Bv0U+s9eSEh1LupxKLiYnd6RbiEYsC9cyQyV1?=
 =?us-ascii?Q?qvfUJxKwaXNRBT6pG4AVCFLhYkagRsalBIsdBzAjxNlhH0RHzU1wawUn/5u8?=
 =?us-ascii?Q?S0LPVaIzYJc0fihJa2IEv1StWlwuopAU0a1UlgTeZq1GwvA0qQrmzvX4JjyD?=
 =?us-ascii?Q?Hedw20/3YcPT9zmO7dVDQaQPLgENDuIRNQFcYOHep96PM8QW2lmfeCK4AzaE?=
 =?us-ascii?Q?v5J2nrNby0wkZdaiNybA2L3Xzh3qxVwV919tQ8uq3nZn5LgLtzYtGHm/buUv?=
 =?us-ascii?Q?cuCRuAQnTQmnZaJW5Qh/ADUN7geOcP97MSo5OTk2zijF+PLGd3W8bSpMPHwm?=
 =?us-ascii?Q?vSw17036/3q4klMl2yEk0R0EHSkPb8GyjgnOakOFDSH1dB7drbwuTZTK5q8S?=
 =?us-ascii?Q?ScEHPESrVFo5U+wo7e0w8u7AjNUlWYfbnrI2z5uiHdUsvPEX5gIailG086o/?=
 =?us-ascii?Q?4ulk6W3RB4A6jMhmrUVlSB8S7zEhCAoda2wv7JQiQMBIbC9lYdpVXA0tVl/r?=
 =?us-ascii?Q?a2QXthQvxWNIwv6oYKyuEWkXmty6XOj8P9i7MLOPPoBJLKmfUWWCQNLnPr+t?=
 =?us-ascii?Q?VYsybF3/7IA3HNjpBZaibYFa/JbQcuQiv7YzJRb1+0nvXAkdQgxnSm5SZlQD?=
 =?us-ascii?Q?nvUS2PxV0jV7TI75/S9YcUqgCnfMOz038P6GjwaMjlO/KudsRr15RoepE0dh?=
 =?us-ascii?Q?IzoS1Mvmc+gKK53JM8xwQ0m+th1kPc3cGM9klg4RCADEEVMiTbPltZHAXOfc?=
 =?us-ascii?Q?KbGStTzqIkvM8QvCTOrRSEVKTmu53DvYoCq3CRKfdpjPMs5UHnvmud/6xjsf?=
 =?us-ascii?Q?31oORcQIFQ29xYLNKqPl9M+VC/NIpMsKUE2hwkEruhqeX9BgP5cG2pp/Mong?=
 =?us-ascii?Q?nOa/YnbFUxI238KfUDcK0WFNBWVaOjltFuR52ead6rnUA74hS5VEkpCEDlqM?=
 =?us-ascii?Q?dTdYYaWNNOil0uKZ0ziOQWqIACRDFSBTmLCXVLWsrJMPX7u/cK2nWsbrf6cf?=
 =?us-ascii?Q?l2r1+ns5kTLlNas=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yxvGiXxvyLJxAezWrIhuhxXvWo+kmomFYHKRiT5GviPOAydrlcmjhJqBoLHG?=
 =?us-ascii?Q?+BB9GUopfuiaRuTG9uRw9bF6EUNr/RVXDzzx69oLM7VyQAG01bgHAvE5/Vra?=
 =?us-ascii?Q?jbd63GVY3VxQ4ieDsiN2ursFfP4Hpm4mPUR80PN7SzIYxCQQWFteoY+sFx4u?=
 =?us-ascii?Q?HvMXhpDrtevKYwEpjMH3pRkPG5acBOPz1aLGiJBWvT6SFecndKgcfmJmWOCD?=
 =?us-ascii?Q?sgTpgbxcreEhQk90ROSgCOnHhns+aNgYa71dxFhl0iSUKRslVe8VB76SlFGL?=
 =?us-ascii?Q?1AXQAALzbJFqWyxlqq/9YkEta0OGoPsK6xIaqR+MDZJ75FbamjkdP9lHZ9/W?=
 =?us-ascii?Q?AjMdxIePh1/rOB82r/PrNWvrt9I+64nrFerzpHF7mv3W8XKgUl28ofOcEeF/?=
 =?us-ascii?Q?gEk1vAqdsniUyE1xwsxMd4tx30KNq6AtbWPV+Al5TKksGP55Oto3m0X8mdUl?=
 =?us-ascii?Q?ihlXZgfq53TR1XJEVkDSF4kbqgOfKYSs0I0b+hM6P4bD0pfwuOSHRu0xqwo2?=
 =?us-ascii?Q?Fa34ZqhsQSuQYiZ8xn/reTXn6+Utz4SQb5r+ELbDOeivPZV+sYp2Jmf2OXth?=
 =?us-ascii?Q?kUaSnDS1Vu5jvvfJO+Q5MY1JETw1Y41mblVYaeKMz61J+VhMuk9oXjdCaoe5?=
 =?us-ascii?Q?i8eSM8yPalN7tNaae4oimBPdftobRJ84gGLMA0biEf1VlrZR7JtZF4jCsmpB?=
 =?us-ascii?Q?S6Kao4rH7/khDQnbbF4cgPsnhtdDWK3vl0ntuK7KtJl53CMQPz4CTAiT5mUR?=
 =?us-ascii?Q?ibJew/vncytRQoR5YeK2C/DhR6KL3cUef8MRflftM2BbJY7QrviuAxkVCqhG?=
 =?us-ascii?Q?eW2Tbh3lWqDIG1my7D78yfi6H5EbIxHWk34m+UE/c+ezoghBhiPCKgIhShMO?=
 =?us-ascii?Q?ayFKv0CKJYanmcRX4YWXuOJgtzpdgtszmK0/bZc3O9A29EqE+8FbOm2qD6gd?=
 =?us-ascii?Q?JBv6b/qugHsD/aIEi9B2xHDUqpcRNfYQ/8IWFD5XplihZYggim35KwQk7ycc?=
 =?us-ascii?Q?SJNFPN/wbkNxtViLclODDNExpJQg+oYJjmQA3HLORIp55AOaC/wYWq/c+3Zw?=
 =?us-ascii?Q?xprMGVduwIwBa8bIjPBagiv3xWcVWgAXx83vUw3CJ5y/+LSK7FNxDUrTlGnA?=
 =?us-ascii?Q?sDwRdurVCyxjpdG6iqfqgfZuIUGtYnvkXXglxuMqG7LL2U2T9BxaEO2Vth6u?=
 =?us-ascii?Q?ZgRNdEypz+DfcFQZL9dGeC5WfH6PB9PFZ7+BQWyFIQtB1rUdbItW7K6z/j6d?=
 =?us-ascii?Q?E1/wCuXUIfPxHa6mU62BLqqw2j0bNCMszPWx66yojLLmb0n/pWwGWZMJzlvx?=
 =?us-ascii?Q?i7snfhjHEDVwCV4RjK7R8gJ8XECYeusIWIzktni5sVbCDpjJSNo1dwa0LCRv?=
 =?us-ascii?Q?PAh3+jJj8eSzWsa9+zUFvqDUS1RaZPLIvYxdrV+1g2M0QoMgxS062wqaAvm+?=
 =?us-ascii?Q?5NPlm1/ePhtXkmTVROG9/7CVEtqGZkBFhgOj15Vr5x77segXtEEF5qQKNbME?=
 =?us-ascii?Q?/IbqNO8KJCK3on9la9X83HOYrxMN5NkZNwj8ZRDkAncBeXK0C7AR0gtqg/mE?=
 =?us-ascii?Q?mIN3DeTiomw2bn9G5H38k4MCq22xSr84sny7dI2vOs5YMOAY3en0dna+94oc?=
 =?us-ascii?Q?gG6WnlJJC/wMgrWZMgelOQw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e8ddee-8605-4e74-fe4f-08dde0034cdb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:53.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq1Aksddrb9LJvGxKzh3Aj3WphvfESCG+4ec0f9xtxPGyWSNGvUIX+FtUgiAc4oKpefPWrlOPJXL/iCmdNp/4grFG+CRjf2wQIuOuG+svIsDL8HXFbqbzrN865HsJxMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19830

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 12564e809c8cb30e3eb0dba5368cf7d356ffc883 upstream.

As per the hardware manual section 35.2.3.26 'AXI Master Transfer
Setting Register for CRU Image Data', it is mentioned that to improve
the transfer performance of CRU, it is recommended to use AXILEN value
'0xf' for AXI burst max length setting for image data.

Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240905111828.159670-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 4e74721e2422..704278eb2f3c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -52,6 +52,11 @@
 #define AMnMBS				0x14c
 #define AMnMBS_MBSTS			0x7
=20
+/* AXI Master Transfer Setting Register for CRU Image Data */
+#define AMnAXIATTR			0x158
+#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
+#define AMnAXIATTR_AXILEN		(0xf)
+
 /* AXI Master FIFO Pointer Register for CRU Image Data */
 #define AMnFIFOPNTR			0x168
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
@@ -278,6 +283,7 @@ static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev=
 *cru, int slot)
 static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 {
 	unsigned int slot;
+	u32 amnaxiattr;
=20
 	/*
 	 * Set image data memory banks.
@@ -287,6 +293,11 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_=
dev *cru)
=20
 	for (slot =3D 0; slot < cru->num_buf; slot++)
 		rzg2l_cru_fill_hw_slot(cru, slot);
+
+	/* Set AXI burst max length to recommended setting */
+	amnaxiattr =3D rzg2l_cru_read(cru, AMnAXIATTR) & ~AMnAXIATTR_AXILEN_MASK;
+	amnaxiattr |=3D AMnAXIATTR_AXILEN;
+	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
 static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
--=20
2.43.0


