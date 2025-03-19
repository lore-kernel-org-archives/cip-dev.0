Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33609C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:50 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.web10.4029.1742377726533161170
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UXXJ4Ckr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDoFsXn1rfjOCWi2cr/plC9kAsXQpNRb01DNSFjKpc9RyuusK8rwcXPdZSm/hGDM2B0eGK4FxbIWEu6FxVUQ8ImIteHx7kqABKk92ZDu25PkhWKWKJePigylG3NuN1c+dBpW6R/BCK2z7Q2dqNluA56wTIX8z58rbwDNOgao7ViumL4HLWUt9jkT8V1n/upebQpmYHqN5jNNW69NDIjkI1sky1MMs5MdkH/H4wDwRWVgg6qlg/pKF+lrEWk41ARW8DNHNuni/uHKf3YKZd3zKnmkwMf0a8EmlLpULjytjII0H5HgYDxg+7TfLPYb83Z5SFIM+/1Y/d0OU/vbS/vspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UreD2GRMIY/E6oKAoZDWv4UjfE/YKBOrtl6mhcrGbw0=;
 b=qF0EI822/c3DlY6YGlSYnNOMSwY08oJnW58WNMF2DeKblTIU7DpqaTfJSHz2clvhTU2dXGm0unOj7XTuGIyUp84YLqR9UULtLqsopOXl0wW8l4GdShW5S2CNTWRIXS5pUXq0V2LwcbFLT0nlzKgpUZbDxQvZS2wGB6Xw4REWD4vSrvHXd/XbSxKl5pQqiwl8WofjemglA3I0TQxS9UrvPJlLIZmIVmYCnJ4vItJFVi0+Hv7tUvM4T6ZS/CAGHSFaDaop5fRyM+dqtKDFLA1IlAQOdzjf88TtqD7PRqNYlAQI7aWiRhIkY+BKYfau7Nt/G1Jj0ZcpDA2BEDgZ/bzgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UreD2GRMIY/E6oKAoZDWv4UjfE/YKBOrtl6mhcrGbw0=;
 b=UXXJ4CkraXRjtuc0McRXUsSxppKjovEmeCXpetb25V3ZIZ7pJGUJIQXh5JGDYOtDqMk2D5r6mZwc6d54vYqjgHf4Q0MLa5Okyp4O7EaACGn27gxgwxXGyyDbVh84KIZtNyz9O4XgReHqQN53vnXbjzbVJoxyc2HiY4XbzlUdFAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:45 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/12] serial: sh-sci: describe locking requirements for invalidating RXDMA
Date: Wed, 19 Mar 2025 10:47:48 +0100
Message-ID: <20250319094754.2404386-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: 823266ad-1a6f-4563-2def-08dd66cb3d9f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LQIBsYYAVke6MiT7UDQnGs0wj5wuySdruKFn/ca0m2NG1pfuJLhryDJVtune?=
 =?us-ascii?Q?kjo31FXR0GJETYqsp/y/+vpeIieB+Z4IQ0IGnkyMDzMf9cLiQ1OWq3UKJguK?=
 =?us-ascii?Q?KVw+0KMfLfa5NIWXeU/Yul20h+zQsh12ykxjBnbbfgYF97DLHsyicRm6Q9W4?=
 =?us-ascii?Q?JXELmflieCxkhZ7XEj/PChFNpHCe0glEXCtPgt15v6/B1IEx/SVjnoaMJRiL?=
 =?us-ascii?Q?DH7/Saivet8sF+1k98SxfGIUKIHKCVVACU8DWezSzPW5Wrz6F273Hhtc1gkH?=
 =?us-ascii?Q?2Jfx2knEz4UZ/XDu1eTFaWpb8Sh/cPFeJKLM9Uxd5E0BBgEG8FS11PxRamG6?=
 =?us-ascii?Q?5nD9OCFw04bNz1NyTkwL3ttQQV7poqR2AywXhF9JOQVHv/Gmj/e8xETnoJ//?=
 =?us-ascii?Q?2mtif1cbMKB8fN3biMG7/xnl6k3h45M4Kl58Mu4IVV+Du4M0YzDsv/b/b585?=
 =?us-ascii?Q?rJyl0t2PGv2Lj+MRvSJ3ujkQM10cEKuPLd6dmNxjgawUwj5VR90OUK9ymmWh?=
 =?us-ascii?Q?ZcCJwOh4iIztJPnXoSnWgUoN4PHHd9nY5CoflQQc1Y9jQDgyvcJhb+mjbORq?=
 =?us-ascii?Q?IOOeEJktTZFVcNaIpPFikLo+VpryoM+Smj+BQl2aXGmaWzTe5jC1am3MDFhh?=
 =?us-ascii?Q?aD7GUEVGEaNN1Q5rfotEP4euoFEIiral2+bevUhis6PvP3LJOO1dKcMGkguV?=
 =?us-ascii?Q?j4krfH2hmKr8sO+6omBqyjUaDi8DVCt5MSqT+Ces7zJx6G6t4/dOb/8mAqQz?=
 =?us-ascii?Q?uSwAHtoqomyxNNXNHL6xZIzQp4qTa/eVmgWlxtJjETh6s3OnRz/SpZHFStNa?=
 =?us-ascii?Q?gk7YJlRYZH9sXGXL2Su9LTyHUKdPvxInAiN55GTDEYmnBCoedIvI++XQyjDs?=
 =?us-ascii?Q?y9fk3xnaUXCbTrvA8jjENVs8LALT/dqM6JZLBQ8DU0bsKbUuevCinR75tDUk?=
 =?us-ascii?Q?a3jPc8l4EThy7p1TB8Sn6EAhf3hRZyXwW4XAQ37k9nkQ0QxqOzI/fTygBAVq?=
 =?us-ascii?Q?SHxIjEryno4e0Frug1Q+VzeUxK6YU5i/9wIRCah4n0/8i/Twbtr3tIHivyuQ?=
 =?us-ascii?Q?qj7nH61nsh1mV+ag1vgBlqJ9mWJ6NPnJ3VrMXtjRgomCS6Zih35Nc4ib1FEO?=
 =?us-ascii?Q?nWdpahUQseuHWf4q6dh/ZIBhFpDS5U8SnIwTUHz2lSNkbcQ25qh7/xzA52un?=
 =?us-ascii?Q?pJE/E6OJVLSSmzo26QUv+RzlWo7ju2P8KlG03iDqmF+orJqo+CQBWMgH/Vmc?=
 =?us-ascii?Q?EE9OCPRDO/Ueu26su9CHOG993gOWJ0dxk/3kZ9Z7pxP5PEhOnjQWS4eVAyQ3?=
 =?us-ascii?Q?Tzmc8n9fksgHbkHXW0iUkZ7JdWaK6GabZvboOx0a3QtG7PlaI/xkGTlttcrx?=
 =?us-ascii?Q?U9iDICmucoUa/xi396X98DFWWC+ca0bGIYOuhcxdkN+QTpeaWhSsASfUs3k3?=
 =?us-ascii?Q?HElK7jeSZqKr8Ut/3McFGjT7kfL0dn9k?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0LbHzKEWw978Uo8hDf7OtUbSuAciCHrCaNIUinPYkMKlwFQAY/3jAPKJB/c0?=
 =?us-ascii?Q?bLhjklvxJiavMEAb7Nuvk54m4qkHKdVNhxng0/xeB4VOppASBdtpDemEi3NO?=
 =?us-ascii?Q?UKPWOJfYqJVtMuK/tpjzNr1Mi0yYGXewE4XiCfbgbjggoy8Z/JULKKjTWki1?=
 =?us-ascii?Q?ZVo63l8SGDg9kMqxnzhH63LokYNir8hQe6Xi0a4TPbTEqfTQQhBOOJCqdx/J?=
 =?us-ascii?Q?jeKTG777NFScTQjLTLHs9sA48tBomQOwWtIK6Ho1OeU3xyVv8jcFsZzf7jOh?=
 =?us-ascii?Q?U2oYMs2F1FL9OUP9k3KonaungMW8fTJizSGPUZKvMT37EeJY+GiZsL3BQiFy?=
 =?us-ascii?Q?Z+4dhd29luqAlW8pc41c4VK6+DtXTu503Hq1toi+sjxky/GLCUDcIz96H/FK?=
 =?us-ascii?Q?YEwVegCGiI9wPqp8D5eG7o0ARNCvy1o2w7bCL9/YngJQAvPA+MD0GkLs7umh?=
 =?us-ascii?Q?S4vDK/7pvGdDhOnIOe9aqXvUH546p0KbyvfTuzlrs9FVSnw+0zue6UkjBCrs?=
 =?us-ascii?Q?tf+3opfGW77rb9VCfVf3VRHbSSWo6WVOKu/zZ95X3Dj/xDZy8FPAHMCTdmb3?=
 =?us-ascii?Q?QSbLZ+YNLEM1WeqccbL8mprlWg7uM0VNRETjn0yObER3BnU0xT0bFPID3NJl?=
 =?us-ascii?Q?Gfb9oNWzkXXGbT0Hp8qag//EtEcIH8nsqIwxi58354itmCqHP2gGhLlRnt2i?=
 =?us-ascii?Q?6uMne1+e0xHPdtiDQYL9JVDzjj42AgMaUeTZrgiNsIe4uJx8gnq0rGT/OEx0?=
 =?us-ascii?Q?5r2vPkn456IgUPi/viqhQ8hBzyGgRSlaFThD8T7pX7ti6jNU0gS0PmejXIrN?=
 =?us-ascii?Q?NK1orwqyEGK9eGVmoT4MgrcxQS7SWhGthP3oxrK9vcebp6vQ5Fby3X9gPczo?=
 =?us-ascii?Q?wHsbN2X2UUDHvs5YBnxkJMDJtNzbemIz+AqTee+ED9PPfOmVych7h/l0/+LF?=
 =?us-ascii?Q?ABUCVfq7th4friJxVu7GrhghX+5w2NXWQlPbQq8K2IiYmxPsUVW3Mh++J160?=
 =?us-ascii?Q?+BDlz1Muh6Iyvdcg/ldB4UZ7EitpCDh6UisDAJ+6cByHrVF4Q/+yLoFmKi+o?=
 =?us-ascii?Q?+f10rj0cTfeapuCeNxS3zaAUKajsrHTWJNoTak4WDBJYHyP9vIKUT63kZFOM?=
 =?us-ascii?Q?KJlwdT10pOo7JZH0u+bJnseJytXdhS4ilMGnu4MvhYlw5SOhsPA6jMFBxt9m?=
 =?us-ascii?Q?dgrxQMgc7oA1L9+42ExpPs1mXvjF5eWvQwuxR+gzZz9yeBkX5iHVA2LeSdaI?=
 =?us-ascii?Q?M87QEJ8+m2lZNL5bWwrI4f8EZiVTvTtO7NMWokG9BndpRsavi87wJkz4f42T?=
 =?us-ascii?Q?7uTJTtJO8d/0DbX1VI0MRQT4YRSKugQTTlD6mY9hGj0SnIOOpzbedfDBEzVd?=
 =?us-ascii?Q?lgW/yKmH+hVMQPIMkIRjwQ1LNQ5Ud9QCnIzQ6zupY+kdv8jVi3M+RFoqaMk2?=
 =?us-ascii?Q?rXNxcBkCwoKju9QjzU/X/pjmK4I/zPRbFAaQwxtdcJ+eOaBMlA1XhMBPc2Wb?=
 =?us-ascii?Q?FKE28UNXsmu6vm6N7kwcPkzrm1pM9yuNk8uTIvLpihMTRy0XDW79mqjl96wJ?=
 =?us-ascii?Q?/8QEOnPVUFc/FMpOu3hzrv7cf4AYb77Lb7Uux3g0k9dPmzvigbqBalHsfD3s?=
 =?us-ascii?Q?g1zalLFyquqQioL9NAuTEkE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823266ad-1a6f-4563-2def-08dd66cb3d9f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:45.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4I7fRrx3vmv3yIbT4M4y4SFMftP8SMipZ+RIBRaTC3IHnicNS678S3KjxVw9sSk9dpXpYILAj7qP++D35WPebdoNkZjhru/JZTDPc4ge6Og3MD3HSeMorUf5LB0qxzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18253

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8efc440549087de41abadf62f4bde1d827135338 upstream.

Make sure everyone knows that calling this function needs protection.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240506114016.30498-8-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 69f8ac561513..7c93c9a1079b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1264,6 +1264,7 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 	return -1;
 }
=20
+/* Must only be called with uart_port_lock taken */
 static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 {
 	unsigned int i;
--=20
2.43.0


