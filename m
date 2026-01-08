Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154CCF6AA8
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3037.1767864662688350346
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=junb+tGv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZNtWM7W2fVeUVvG4XpAtS9+ds2fFl3A0eOpYCGPqUPv0ZEt3mE0JQzPSwuxkynpZsshGsnliXxyZiy1LnFTauRI/eTOa6D2w1ipa1aSDTvMDLgiv0jZOF1MpvpS/PbQNZgrT3VM5UJrS5r7R8i7wWJN6cz+FWSzHNkJwzerfLWAtpBWFzzSzhV6A/0JVW/ZlECe+OG+3vJWtXhO7ZRKGpYb6Q920WVz91KldLczTExyZfwXSzbZjN4UpyZHKXRrpDVaHV5VAwXV4pIyWPIdduo/rk44/RRHANLhqIUDLZlTHdnxRBbs7Jj+W/4CuK0Hyp4wofHJuJ7FywAuRBm3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD+jR9mdeU8x/pOVbvqPVmUQOCuKqlWObK/kqZ8fiPc=;
 b=RPbsjISpD1IFL5Htckv5wuB3FX34pNno677tL6OFK04cLzVdZ84l0nw3uuyJW86aP8O29/uyyNH79/skAnR37V/AVXJKLkEmmnEUvnnMzgJ1bsx64/HMZWtSA0a5Az0ZbSYJ5EXk9LLxNf3hRkhpijriYISUD1HG7F/DH4KaVzLxk9lsyh+K4oQ3vhy9TEQEJemMEwZooG830T/Tb6Wnth+RnFNQo4tTQO6isKHdB9lTNGqEKu+SOauvmrZyDwE9Ly2Yg/z9e8a065OFB7gT8D9FW/6n+cuaE25cSrpi1XOJYU+ioeH3u3MXuD/tE7712z6N64M9gOyHLdWBUp5zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD+jR9mdeU8x/pOVbvqPVmUQOCuKqlWObK/kqZ8fiPc=;
 b=junb+tGvPE/MP2/RcToYmV9RAUsfx8g45bT8uteLfKKw3yB7qLds4xCg7HakaYMlZasBVFcltKs2vEC9d4n/ibStpPqDGdnm6AbCppTMhz4DxQJvTrr/Dg9GvNf7Cgj4mYSptstD5g7YoCR3ylPHO+mntVw6+OQked31z4GdkDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:02 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/19] i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API
Date: Thu,  8 Jan 2026 10:30:10 +0100
Message-ID: <20260108093023.489513-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c43b229-33dc-464d-fff5-08de4e98a387
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mr6cUP7KTHP14Y5q8pnhUWVQ27gH0x6mTDG5yGwVVJ+Yyipgt285+iG1B9tI?=
 =?us-ascii?Q?ofBn1sLLvrhrVNZvT2vcKosaehn4RJCA8LI9zR0tIwg0A7oZOmYis6KxZyke?=
 =?us-ascii?Q?ILTtKdbrYqqzIKsUWfYTGo9ErbG6bFJb0RFN85zI7A55/9t8/1Q11O+VmmEW?=
 =?us-ascii?Q?DkLbdSkDifPs+F8YYqQ2UHbmURXMkvEWfZ+o59MfXyyn1W6WR4/lSVc4j7ml?=
 =?us-ascii?Q?K3y1IuLYWAa0Ej1AF6P4Qllm2YjV3ZqtLGmwqCtFrFCMw0N1+0mNNlzFsjeu?=
 =?us-ascii?Q?8vn/wzBUDHc5E3XX/atVCeSP4vGS6AgT4mkDsGYGgxbGQ2EiwSxtbFWHKgwv?=
 =?us-ascii?Q?fffML0KWbuq2F4xms8Rr+8dxO8kapQlFciQbpi7Z4Dsoq/QXxokLqzRbsqP4?=
 =?us-ascii?Q?vTia0Mvg+fvXxg+BmHrqhzkwJkkHmC8smgi179HlHOnY6uKSqvANBPpa+WiL?=
 =?us-ascii?Q?jKCz8BatuDYRHR6oGk7GxFRz4+zCDLJo9qqV+DpVhw2f2tCCibchR5nhKcFt?=
 =?us-ascii?Q?pQfYqrP/D/eazaRpHL8I+GCVofXcyuUP/ulcLYSaIuUDjOdX5NfICzOrfdWh?=
 =?us-ascii?Q?WkwwBA+4le4TgLOxDf/D+Wdh1tGUwKhR3jMJJ7eyX+xDC57QrBfmJ0rSDBdM?=
 =?us-ascii?Q?g9KaVVIj7ImHM9PsQs0DhK2TMrfBpnG1+mkQXKyOQ2TaG/zCdAS5JRyqMn0Z?=
 =?us-ascii?Q?vNqTTiDheIIWO1g09RDMN2VPLX844YfHh6Wd7wgboYZ2KEvJ+c6Ztjy4JPSf?=
 =?us-ascii?Q?9eogrh7FI6eW6FClnxufkCI1O/Qf/hfbBUGDM/7R+XOxvgIFP4nj1CiAglcY?=
 =?us-ascii?Q?lqFdHC+QhhqQLr83F2l526aeMN+cnaxzuLNhfOfzmd8j07sDJ+3VKsIG/RmI?=
 =?us-ascii?Q?OYUHi+vVac6Gsr2Y9OoeCsUnWjfAMx8Vj93KZbd5riQ4kaiBVsJWXf9jF7aG?=
 =?us-ascii?Q?rhjZWbldAM4gY9TcjrObkO7wPpuH/nvIpoC+zu68AgJPQMVW58u8LcD0copP?=
 =?us-ascii?Q?JI11MG2CiLzzD7IDqwRINV/7EtWGXLMA78hLxhaKyCWtt0b47m1rSEAWqVeV?=
 =?us-ascii?Q?enxmWpX2uT3121+FyEIxKA++BxJew3po2ZZ1bJiuGFeVM+6X2cyXCvEGzXtg?=
 =?us-ascii?Q?Ao1AAuoarVEUWlUctndBKyuAfMEjoKtfphU7as7D1r7LFctGN2S505NrUBmc?=
 =?us-ascii?Q?mnUKGBD9gCBsBbcJaavX3X1vAvV9ocRITvr9cLLcX9J4iyqHeUchgSqfrKpD?=
 =?us-ascii?Q?49g7DtdQx1zaEgt2O7VZtGDU8bkKxMIPUSDpTZMPgxA07hj04sGoutq7fGgG?=
 =?us-ascii?Q?6tmc6vlMP6c92gDNu0T0suLjSBkQ31M/qvLayO8lnEu1V9jMmBSk7BlEfTn+?=
 =?us-ascii?Q?tnukgwQS/4JmlwOpZVcb5ief/9/406l/bbU9mXXyqF71tkKAQ0smxH9ucmaJ?=
 =?us-ascii?Q?zCEGBzjVO9EuWKAA2oJDc1lFIVDVrqUHlTw46GZUynxlpH7REHl2fBAL/985?=
 =?us-ascii?Q?A9JhKT2njgSGJ9IDTccfi1jC7HvyDWsmEB+w?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S2zEKGF2tCgv2t9oNFtghhTYLEVQwEnGkyT4weT5CRJC1GuGaA1rX1TT4nA2?=
 =?us-ascii?Q?/Ovn2hClF8IATczzkz0w6DUIK/pwqleCcNl5y7N/AuYvwkK35D1dgH0HixU0?=
 =?us-ascii?Q?Z+t8RQdRqiXNzNBeeNBOVtMMdWNe/ftyLc3R37iBG3NOUvyxFrV9Mvbb+aLZ?=
 =?us-ascii?Q?uN1U1sSwJilgetY/wHZ9FDHh8WjIqOLecgur2yL4Ap7QbwHyNh9PGb8DVUMv?=
 =?us-ascii?Q?LO4V2ZqxKpHeIlbIVg7YPgNMryaYBtgDGZGgTGKmI4Bdvg7sHpHS5grxVhLT?=
 =?us-ascii?Q?m5NlZdFOFyTK9VNhTzZvh4XU47Z9D2enOoDxEqWY0hKLbSbK/qMGfcQ7AEXy?=
 =?us-ascii?Q?Ns+QUsiPuTc42nJCQHhNpgVSxJ3Vp0sam1vJsL1fxvWsVO3CtO4ONlja6pe+?=
 =?us-ascii?Q?47yLTE5MihnwaiDfEJlqU/ZBb4V4Ha6tZvU24lWRm4Ak42KbdMDfcP8F0XKH?=
 =?us-ascii?Q?g4wERfESu1taorjniw+GFuhJm82F5LBLXueTXFIKe5R2ct91pGjLN3jjgMw5?=
 =?us-ascii?Q?VVL/lPGzRiXIPxMl8B9BP7C+xCci2kN1yAmx+1i+DL3atbS6gsggDwq2h3M5?=
 =?us-ascii?Q?pFoVAfvgGuPi9DGXGxj4Gs3b+7VoMy4YVZRJ2PsWWdhsS8Xs+CabU7peTMs6?=
 =?us-ascii?Q?iNIuSMe6AQFhcsZcdGcMLonQLnxIHDeTxJtEa7BTRKZQvn7b6yZVMh3gdUyT?=
 =?us-ascii?Q?pdBykroosCnb6VMYkP0bOlta2RurYykihR6bEgIhRmiKrRbcELPU9aWqbn+7?=
 =?us-ascii?Q?flRbEWCXEZxpcct6dht21hyU8WNz5xbtMqJCxpsa+D+x0sW72jCZnTre0Qqf?=
 =?us-ascii?Q?GYhNLj4SFw74z4xZBUjvwiqpEyCa4SVAlVA4CgD6gDKdJgiG0CU7rEo59Z7j?=
 =?us-ascii?Q?9nBvcJGDJMEVC22D+Ovh6fPKbFOh2bpfSDPT17KqL0qkOmvUUSKiK255AqaL?=
 =?us-ascii?Q?b7n+zzcLwnY8O1x+46eO54cLC5YxWsdpXKU/l02fSkwb8nu3dSEHYOy/qZsh?=
 =?us-ascii?Q?S53pK3lXS/cmmDb6dqotVmXQ5owXbb+s6tT1g7Xrwjuj7bmnflpjgNbvxJ+M?=
 =?us-ascii?Q?o3HGNGoIZ9QtZLxFEzh8MYbYEZ6lXmVSlKKE/vkeKoRhnlE0t8u0dpojO1il?=
 =?us-ascii?Q?Z3YqxhW1W3YfVkyM1fktYhoIP7+GHVDaFURO6An+Nt3g44I2CsFKpM9518Cn?=
 =?us-ascii?Q?CGzym//tYpraFFyWD8lBxniDN8P4lj0lylZVmLsgGOX9jS6T7bg+fh1W/Ety?=
 =?us-ascii?Q?yvBZPfO0Sfx1crHB1JmR9KZBiLWFeSCsgF4Q+6FE4PgIfh9SqgvM/P4MFAn1?=
 =?us-ascii?Q?/arn+PeioLAi6DlhlIRhEIWOfnuCRapapVNG/CwE4Gtuew7ux/3IfEXS6iqj?=
 =?us-ascii?Q?LQHrNzdZhHjECIYwA9JvavEzwag6MAiISHWOvTTY6ZqUP7kzX/im3Ji5Nm9C?=
 =?us-ascii?Q?E2mj6TFksoKF4Rbay92/voazUPTyBEudkHKc9JPGZSKHLsEDrTNtBTaaE7p3?=
 =?us-ascii?Q?HzcD4VaHIlcuV+7hSY+3kiNHAsgFMgHnTln5GAPC5EW+QoRhVEcHnxFsJ5sm?=
 =?us-ascii?Q?4jspV9chNX/cQvlt2lTFwJE8NIgUF/8eR3TcMl4x3p6ry1pSSlGJiwpOmsKS?=
 =?us-ascii?Q?vgcVc4hapEI3BD9mvhsgxkQDUWgXPptgyt8OAS6Nz7EeLW2GoyL+KmIGIm/8?=
 =?us-ascii?Q?hmyJVazanwMgHVtBq3ui7hMlqmc3RaQFXJszwotnv6UvuWlcrl50Su6PMi35?=
 =?us-ascii?Q?sOy0NsLWY8M7A10D3xdaE0jTw1zn8Cy/OfODyS9zTBk/LfaG40+c?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c43b229-33dc-464d-fff5-08de4e98a387
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:02.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIbzEZ/hPLGbxjy51WQZEd5FwMyNulSRRxc9QwZVXJYvgyr3VQAQbVrV3FtXfa745QVyIlc0TVWQX1YOIKDr50WAr+eNobUNX1kLIGVbvROsF1ukQ9OkT4/pbx4Spsny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21465

From: Billy Tsai <billy_tsai@aspeedtech.com>

commit 6866c91f8c2327546d850d5a85025fb81e2089bf upstream.

The change is necessary to enable the use of the
`i2c_get_dma_safe_msg_buf()` API, which requires a non-const
`struct i2c_msg *` to operate. The `i2c_get_dma_safe_msg_buf()` function
ensures safe handling of I2C messages when using DMA, making it essential
for scenarios where DMA transfers are involved. By removing the `const`
qualifier, this patch allows drivers to prepare and manage DMA-safe
buffers directly.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Link: https://lore.kernel.org/r/20250204091702.4014466-1-billy_tsai@aspeedt=
ech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/dw-i3c-master.c     | 2 +-
 drivers/i3c/master/i3c-master-cdns.c   | 2 +-
 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 drivers/i3c/master/svc-i3c-master.c    | 2 +-
 include/linux/i3c/master.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c=
-master.c
index dbcd3984f257..577368467b8b 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1066,7 +1066,7 @@ static void dw_i3c_master_detach_i3c_dev(struct i3c_d=
ev_desc *dev)
 }
=20
 static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				   const struct i2c_msg *i2c_xfers,
+				   struct i2c_msg *i2c_xfers,
 				   int i2c_nxfers)
 {
 	struct dw_i3c_i2c_dev_data *data =3D i2c_dev_get_master_data(dev);
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-=
master-cdns.c
index fe4d59833ad5..ce2933c912d0 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -813,7 +813,7 @@ static int cdns_i3c_master_priv_xfers(struct i3c_dev_de=
sc *dev,
 }
=20
 static int cdns_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				     const struct i2c_msg *xfers, int nxfers)
+				     struct i2c_msg *xfers, int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
 	struct cdns_i3c_master *master =3D to_cdns_i3c_master(m);
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mi=
pi-i3c-hci/core.c
index a82c47c9986d..5bc22d9635eb 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -369,7 +369,7 @@ static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
 }
=20
 static int i3c_hci_i2c_xfers(struct i2c_dev_desc *dev,
-			     const struct i2c_msg *i2c_xfers, int nxfers)
+			     struct i2c_msg *i2c_xfers, int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
 	struct i3c_hci *hci =3D to_i3c_hci(m);
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i=
3c-master.c
index 985f30ef0c93..7b4a62efd066 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1572,7 +1572,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_d=
esc *dev,
 }
=20
 static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
-				    const struct i2c_msg *xfers,
+				    struct i2c_msg *xfers,
 				    int nxfers)
 {
 	struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 12d532b012c5..c67922ece617 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -475,7 +475,7 @@ struct i3c_master_controller_ops {
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,
-			 const struct i2c_msg *xfers, int nxfers);
+			 struct i2c_msg *xfers, int nxfers);
 	int (*request_ibi)(struct i3c_dev_desc *dev,
 			   const struct i3c_ibi_setup *req);
 	void (*free_ibi)(struct i3c_dev_desc *dev);
--=20
2.43.0


