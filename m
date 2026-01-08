Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB824CF6AAD
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3042.1767864680503765412
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=flDFJCm7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.51, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcgdiRphbplLg8pqJ5vmYLlpCNWU/ug8BsxGdQk6gujw3/36DWNHBI/dCsidvvOJAryOHC7CB9QDZK0hopZKhxKG/5g/HS3rB8ehtOenDhI3RWB5h5xAjr+AOROlD/GjHs2tTDBOiPV6i2pbpmHjC8R+1XbEyDOVC0s9Vlgy6Tzlk+3gW9H3P4FCbt7OG9fpEeQwdPOY3ohXVKqtU39d9W3NP/YEsDl8KWZFyuvQ7OxsMR1tCEC1hiiZxlwZrXcFe+Q+FEt4rU6/1n5XgNoy1v6lZZuNSJwi4a77YGNuhk6EZafqb0VNUMWf44FnQSG7DOzG1oGN4MdiRcfhng8qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSB3Uq655/wU6N8xji0rmgGdOB/InVVoMPgLTWAi1VY=;
 b=u2hjIXDFrHNH5hNaezi1jNTSlnN8XnvJLRFJmholSXz7VJ/15J/38icFdhMqZDwjQO7XlvGnWm9KBcIdiON2WI/I8Br7gBJYDHiM1aKfBtkE4oaSsYYe/FQ+lm+S4/Eb6+sYdI1D0OJW39rS7TACDKf/cQD8ZR4hdDfuQIi2BrxJn71MMl2cBwUc8S/MlD4DsFJZ8FStd/kRckbViMX+y6v8Bdx/SBLqxWdz+Y+focFLIxdoWsYpWod4lpXZ3xOWYp6+VnC40N6wP9bbhy68X6ObDMYQDBVhgLbxG/aK4rgMoG5ezAXUfrPLugdXpT513oXgTNIY+2W6Gjz6QEMTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSB3Uq655/wU6N8xji0rmgGdOB/InVVoMPgLTWAi1VY=;
 b=flDFJCm7Nsy6fdyXEdz9oz40LBvI56Fi7seZw2GkyzmSpdrys1vkc1SuHCBpaKFnLJBI9fpatiFzDdIBcq0GveAoZyhgVHiwrRuo6YdkSP8VCu/q/cgrxUx4PKBqhBZ6h0AKWhJ69hyylBUUyxWBzyIovZ4vsTTNx8TuqksGiDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:16 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/19] i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
Date: Thu,  8 Jan 2026 10:30:15 +0100
Message-ID: <20260108093023.489513-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78358ddf-1d46-4e96-bfda-08de4e98ac2b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?29jf2gqErkC5t5IEF7Bb9oftLk/evRVbfbtFDiQbiryvU4bmulxBC939EVlq?=
 =?us-ascii?Q?uVpDcuWOEVxYXRdQW0+3tDUQ8GVfBiL/6aQC1ppS+VM0PqcV+EGQUUIaiIaR?=
 =?us-ascii?Q?s2zpClPAvDgpRwXGvQutvk1UjLMwU/sZvvGLj05FmPLD9dBvEavfLV5Bb1/b?=
 =?us-ascii?Q?rWnU7By58MUKTrGTlONwPeheEOcKjVEAjB4oVCUfOtFoYgXCYA9M8PF7jg8M?=
 =?us-ascii?Q?OZazGTfMqqOp7gDg/Z6kdYoqDcaVnCRzVvy/AqhH8fKF4RQWeQV9TsTSlQs6?=
 =?us-ascii?Q?aHQy1qkZMewiKZr9dOMa0SN47wxfPRu+Cl8SNmWaZJ9hiHsP+rW3KRfVcqCI?=
 =?us-ascii?Q?AcSOccmDPZJ3QNwcib+BYM8A0lM6BU2CI9tuQylXszSFPNK8Ixr2C1K3i4my?=
 =?us-ascii?Q?9pHgvLGtrDb4dRq6Dbm+h0f7zPBy0fkEAtG8+KCv27OogSOqnPv+wurHveZo?=
 =?us-ascii?Q?dzkMq7p/5I2IqJGttjnBI11WNObdquBCV1/gTCeVS1RdG0D7zgj8ETiTxiS3?=
 =?us-ascii?Q?VB5066jxqCYxIKcHqU9YI9wi0/AbJ/uACqFI1SArntTRsxSsxCU7xYN9B9ZU?=
 =?us-ascii?Q?cL255ZQvsMH4Q2+OEahUPq8nJPYfvWS0+q4XuW0FATudC5hsN/qwtYULnB9J?=
 =?us-ascii?Q?cvgBjJWyxnbPdqTXcf8cBfnQ2snQmtkKb44mtk54f2PAPn0w1e3jB4nkV5D8?=
 =?us-ascii?Q?0h/6p4/l7wAntaH1ZBG54mlZEK1wOLrpL+IAD99uckj4qilfcYa9M4RR01u1?=
 =?us-ascii?Q?zdsx3ZPenFpasekEENnGx50kNpzp8+asQU3RZvIsyJ8+gvOiVJylgC0S56Oh?=
 =?us-ascii?Q?8WXo/DdYR6CFlPRVL+7E8zTZ+YJULChAx/uNHUrvTdqwFyBErhvUhF4DMa2p?=
 =?us-ascii?Q?URupy+Hl7pfDEXb1/W2y/IdnrxDd1L0w3niFeutxRQ15C67yynPPSfuOSL6q?=
 =?us-ascii?Q?7zOxpF2DH5ApfN/LKL5FHN/vsnRLJzEDt+kGDZcAmRtooe7Nhc46OMa+3N1b?=
 =?us-ascii?Q?sFiJduSzSfX/Cbfcaj4oU8MuP3A/zgUl//iddwkQ5IeUXSt5KMb/hfvvKo8L?=
 =?us-ascii?Q?lph1qt1jXilFgsqSCvfXYV0Xl1ZChGrSpulYjxqwQFh3LJmAAKcLLucQGhnP?=
 =?us-ascii?Q?2VDgSQy+RKMv+6DA3UxeZ+PQIKBnhEI+RfURZz9Y0SmBrlKFRdQUkS5NcdK7?=
 =?us-ascii?Q?4dpAja0aXVtGHpPRur5GEkdcjF9x3jZrxWI2KOjhB6N2dac3JlLyWSGgFFcC?=
 =?us-ascii?Q?zKwNupKo5HQuEy9j6SOS7+HI+4BRXT0lPmuJsoF7O+b0OpjrR+AQpgBGufHr?=
 =?us-ascii?Q?DtdPOq+gFc2JI1vb+LHzrKGgS2+m4XD37oU4DzYW2p2Ax3F6r8SJlAmmOAyT?=
 =?us-ascii?Q?STGSda/iZ43CwdagPsJDC0JNWfClvI7V22LiujBGvUNjFoNkA9HanyYUgLn6?=
 =?us-ascii?Q?vjX4qoeHEewzu1kdfC+cN5c/BbGzaD1gMCQ0/0JbO7FVf9F8YamCwnjzjI92?=
 =?us-ascii?Q?xeK0di9huqYkn0zWBK0czVE9ARZ+inByCZBb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r6Ha9AyYEe0+EOI7S0UoLMu6p6U7wdZo7SMHl0Ef1KHHOoGiX++iC4IfmFF1?=
 =?us-ascii?Q?rBlcjB4LBPqTeeMc7ACPH2JFesSkE4y3Wj/+jZpwbhr6Be45LlSB2TzIecUk?=
 =?us-ascii?Q?C6zbEh9IOy2Ip76KXZ+3BJlYVZQoT7JdCBytYDXzVprUyhFGlyZ0cSwL0fkE?=
 =?us-ascii?Q?AG7mT4TqatyDVKaiuBk1V0NCmQBbo18oGMOeVIhc2KIowvU9YyjMSHf8jwWf?=
 =?us-ascii?Q?dhKW5qhMrh8tmC3MuQpxWsIN12At+D4q4+bbfRQYkuVEkXMMU4vGo36vl6H+?=
 =?us-ascii?Q?cbZmKjaa+Q1aPO6s2N787djLTQSaEvZ982p2BRzDobHo47v6KrHlzsjavZJl?=
 =?us-ascii?Q?iIpn9DZZraw6QMJEceZ0ALTSOmqYRDzzmWrFVnI9nIa16UK3Yk4fAWYJxX6p?=
 =?us-ascii?Q?P1U+UuVETULlg7Iqfrz4SmmMbqt4TuxkwSSHZ7Ot8xUKc6ltnhwugMnUDCAX?=
 =?us-ascii?Q?hGdOiQ2Q85xRenc+vvKbh3GMhEJZ/loGhb8QJWwZRU3JyrFrxurx96TWfJVN?=
 =?us-ascii?Q?TCZyzdGAX3eb2Bw7E0WAxYx8mdUBf59xM0jH7gjFAcoYL2LxySBZIZpDWkZZ?=
 =?us-ascii?Q?JWm5N+OGmF+8lKK9Rhg1GannjrMj2xe71lPdZu2i1+BHdD1o+1efcxxUUhbZ?=
 =?us-ascii?Q?q4IPdGS98qR0NsMDG6BLc0oJK+uZvGk9zsP/aVnnJ5eSTOBtSFyl+NETeVQJ?=
 =?us-ascii?Q?ZYwzADKt6HDCseBAUzfyE601n81AQhfyRXi4Jyq/9o+qD0gCZXW9SraQr45F?=
 =?us-ascii?Q?7+4ePaK/ZRizq5tSNmxGz0uQcBl8qHqTu2jqAoxnNYnnVVs3zWU6OZjAAaNM?=
 =?us-ascii?Q?IKWZjYIkOwkPP4cGf6p3DD5uwNisAgzGBvqYczIVG8oodbrN1dkQwOdkm+dK?=
 =?us-ascii?Q?ivs1Mml2yHUrUj4rOcPmoOmozLGXlgwHk4f6RtAO//8beWCpX++23S3W7JiD?=
 =?us-ascii?Q?/zRG5PDHhql+YZMyd2NSgJZMciqr11eUGdB1qh9uflkIyOJRuK5FgLQvwCp0?=
 =?us-ascii?Q?jrL5ECrVTTkI6JGWaxqxPJulRnIsFw1uB6U9cFVtr+QrS2PTydwdjsP9MW+e?=
 =?us-ascii?Q?pLsBkcltnT3fs7NDn2JxzX2Os5mUe7Bbh3LHJamuyHi6My+syRlXtfYvpRLN?=
 =?us-ascii?Q?6ezH26i2AQpd4zRrucjUY4zTcQZtTyJ3MfTkCUVRU86w63Fz2s9R6/7QF8qY?=
 =?us-ascii?Q?zIbJ8JBkqz8X1QA/8dr5DbQAyXetmUlqH3rlIP1PuwhdFn1+iGncIiydjB7J?=
 =?us-ascii?Q?1Qy7vAOOF7VVfdKmtnBeR6Wi0Ph5db1dnrtldSmmGZZxUDeV5rurejtqg1iW?=
 =?us-ascii?Q?1/eUxM6ioOlB9yFKVJYHnhxoAXUIuE/XpGgvdrwBR9674PW/AC3XBPr0kcez?=
 =?us-ascii?Q?qSZ5TzecY32wTxDDwj3ekaWPU9pLXUbxgApxwmnQjjMBwCqKqLUhW3kcyVSH?=
 =?us-ascii?Q?k3oGmcNixbADHlbN9gsSnotYEHgqNwI1iT3HBTJIoYLmVkJeEKpViq57ZdJ2?=
 =?us-ascii?Q?lXMoyklURrW/q0etrkniYk5emVI+SvNwPZ7g+sZGoc6rJF2BtUvABvRhx2MQ?=
 =?us-ascii?Q?6x70sIAeKvQK/HXHVYZuxTUk/plrMfJGPTe3H7mZ00N6YnHBtywGvuaz6sYI?=
 =?us-ascii?Q?75+wyI4mvkMxJOyzQVm15Fdn44MvejftdGWBPrMqXvBBK24fatO+EP6++8kb?=
 =?us-ascii?Q?Vv6xSFvuC+U12UtQSNyddUJPBW8MhuqLmenra/r7e/5pEvaTYQ07dUhYIrHI?=
 =?us-ascii?Q?bdSOgZKu4mxsE3OsllV1VuoprhWMWZ3NvvEArzXAxTmbRaKwJ5Ft?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78358ddf-1d46-4e96-bfda-08de4e98ac2b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:16.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCoKG6aLoE6yLIC+SsHQRUdnqmCfJEJ0TE/Hefk0VNGq4+6TbvYLVdbyLbZ3er2IxoFLIwBNPIVDdZP1qERAMbHBahw4FvNLdoRPgxTXln08BnYY7JKxh6jmyT97/C4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21470

From: Jorge Marques <jorge.marques@analog.com>

commit 733b439375b494e8a6950ab47d18a4b615b73cb3 upstream.

The I3C abstraction expects u8 buffers, but some controllers operate with
a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
reading or writing outside the buffer bounds, use 32-bit accesses where
possible and apply memcpy for any remaining bytes

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250624-i3c-writesl-readsl-v3-1-63ccf0870f=
01@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/internals.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index ce04aa4f269e..0d857cc68cc5 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -23,4 +23,41 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+
+/**
+ * i3c_writel_fifo - Write data buffer to 32bit FIFO
+ * @addr: FIFO Address to write to
+ * @buf: Pointer to the data bytes to write
+ * @nbytes: Number of bytes to write
+ */
+static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
+				   int nbytes)
+{
+	writesl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp =3D 0;
+
+		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
+		writel(tmp, addr);
+	}
+}
+
+/**
+ * i3c_readl_fifo - Read data buffer from 32bit FIFO
+ * @addr: FIFO Address to read from
+ * @buf: Pointer to the buffer to store read bytes
+ * @nbytes: Number of bytes to read
+ */
+static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
+				  int nbytes)
+{
+	readsl(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp;
+
+		tmp =3D readl(addr);
+		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
+	}
+}
+
 #endif /* I3C_INTERNAL_H */
--=20
2.43.0


