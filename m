Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A84CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6976.1778751640816255723
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IKGV3ks2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.50, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNbYbguH988ESYXvyrQFLlsxT0JnUbPaazqHSk8RoYfhP385hkuzH1FdA8aApnGsuwZ1Ex+0HlpDb4ShH3XHtmJbsNbb41jdg+RTglZP+CnWlHh64BFyi152qsZfy/lqrWKUll7IqXTDOJoAla/7w+eo6VYy1SopvqlOgBr6CK2vPSq5ifWocKrlncCHz54OlY5pbqPx34x7njW9x3nBlUY8PQIn2iXMg3bOR3cMxCzUqa0Qz+V+YxIjZ8VKrJyTF6l/JkEJt7JCisKe+630dGc9cVFTrGt8bdlwjAhhsW96hESUFTVSN7Nnx0MhCWFQrOfSKNBPoGYrdilp7TXe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tffLVAN6r7hWsTwx0kAn42umjXD1f1DgwZgfg4h99FE=;
 b=Gw+zaZVaYy43HUJENRBxoA01uVEt64okMbuQ9uqKEm0w1GpcbrXXiwCrAxiQpWHXLTJ5+2zzwUMiKLQz7ngdalcEeL1XPlEsNE5+79lUhJRPN8jvtkr9++A+ju+yEkNpD0DsF5eKWDJT1AluH1RMEHPDiSJLlkdFOhRpRgK0iwE3hr1GpDSNO0Puyy5YfKOkVtMzjE8JEb6aRBXaRAaRmubVCG6hGv5YHrXgCFxeLOjxoVS/Kjyno8K3u1GO5OecbdAJ9yi/bWuru0pzVMdhAN6blxdE16w3qmXsRs7VwK+8QeFk0OHblvsaxHEKd4X/qcLsCcjlLAcmgwV242TT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tffLVAN6r7hWsTwx0kAn42umjXD1f1DgwZgfg4h99FE=;
 b=IKGV3ks2MBr2Xwyw/XIMuFctyP2E6P7w+ZlcHNJe12nzk1nuNKmvNSUmOysSy3+b3zmrn0WOlhAvaHb9E3PboWD+vYtIk2150WkGAR6IzKPaz7c9ggOzgwC8O5AZEG8hDtuywSW9pPddInxrghWx40vo12yHjL2tN4HBpEPFosk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:39 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:39 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 12/17] PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
Date: Thu, 14 May 2026 09:39:30 +0000
Message-ID: <20260514093935.2212718-13-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eb0c00-925d-4e45-8212-08deb19cdbb1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	p5H62bE8uCmxG6BtAGV+2RuB2ZW9R8dBicEdxiUlhAd1tEInQDzjkNJhxIKb8woyU3RehoTLNOLjDaawOoQDkiipwHG3skaHFcbeDHKV/zMAwQp5awxVnaJQ+nj71FqE3CxYm0sloFUpmTzYekEvhfOmTYUlqUJls4UC2dlCZQSe9IZ2x1UGJOtvCC5q/QjVzdEz/Vym/DvC3tEnC0k78oS9KfSI4wYpwsa1qbSZLQAXv74i+rBvsXCdFV+/8jJdI1/PB4TQwbk8EoFaGGAnS9q2jh0E0kaIbh47EYqN00NxNYWRiWTrjB3EAiq6fP2rfhEcSWosCKECDAxcOwLfAZga233OX/VOkPWXop6/r+W0HXFnQvWLKmiAAEHqXmow7uORLcmfnCXSmNbM3um7m8W+jwRfXUmQSp3xTUnujH7ML9Im1nCibjuLUVFKPpvMoKMSr9s8uK6NE/schrW3enNwXy6rVrFS5ldc/XgC/NWpebhfkxNpGw7QX084GNkBaOG5Y79zObjog3NVyANXo+mNBBwd0QD0Vbb7p44t9gJF1ZlME4wJIClUtr8YXzRSnmxHretyvhKAzt8RUUU+QH9+ZA5q+1lsssaNvntaw8Bdw5GncBnMsDPe+IXZy7TiaH4oLARIq5qwVqr/vwfyvoUYGYMlDWi2uzyK88GXfLRakzjdVS5XZUz7YuJckq5ViumVxdlsbHw7K02QoF9WOw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S2RwlVGEkLKUHhaqPTQsKCO8vqMg5KAacpDXzWYiospITNPBKcjGoUfaGIU0?=
 =?us-ascii?Q?qXn3C+gUuONqlR2w4Rajaj4QGfulY1bi1fhbIx1yZBtYUky8ofsv/7rd6CLx?=
 =?us-ascii?Q?k6RP7AG0f6oJHOE/s7NO3+TmX6PdnBGFUt43FuNl1xC3zsbQo0bny6zi50hy?=
 =?us-ascii?Q?OQDSThPQg3H7TeTaZ19ryzjfnzhTxvhsA75qrKfwvNPYYSpe9b/JZ5JHoORz?=
 =?us-ascii?Q?NpywK4yhkKuF3aRdyw2OrwL8x7yMcdMYchYGZNouPYOZIirSj+Cd0zpT02Qq?=
 =?us-ascii?Q?nYwsCieUNgqsSEhPZ5sBh90o97YxTX9WJBPWqv4TjtqDZOPlOK6u3gp/XpKC?=
 =?us-ascii?Q?Sg+F7hwKG3/q2cPX+eeiPGCRLe4OE6swdsklk6IewUGivtcEghkJG2dAocRy?=
 =?us-ascii?Q?J91nFUmmRWgrEE9KC4sLX8nH3+W0fTlWgRmDN9l8ImCrcDEdU7thv0EN9Rgw?=
 =?us-ascii?Q?Q28vhryuDsKx7uuQLycC/cV8I+HCu7rKqzQZyL3eogwqQIiwb1cCRmrcnrIl?=
 =?us-ascii?Q?0jRu8hPLazFcKal+3gcPe4XZyrMl1V9rawQIQJs8Hlujj9ICHFPlx+qzh83G?=
 =?us-ascii?Q?GMFBWPP76zTMQSiDWW78VA0s2XBd/zitRqS8yzxGbZiLiySdb6HsamZxSuDJ?=
 =?us-ascii?Q?OxymqBM1LSBcLPzjvMCxJSJywYG9k97IH1tIjYi+J5Xlm+rcDLZOE8ceGJh7?=
 =?us-ascii?Q?hbn//3eaaPbUqlRFbYEl/xJMpKwv0M48R2ZoD3MULZNmuhIwuJIeQu2EOk4q?=
 =?us-ascii?Q?HZPoKloY9lHPPoYILjjOa2A/6l053a5R83ymaPj6VC/aUj+Z29IkanVUaKl8?=
 =?us-ascii?Q?HhuoHIXhZ17dGoAYatOvdBkcRgPpCFZpnxahoNwL8GKzzKth2T+rlx4VtSW1?=
 =?us-ascii?Q?AHn1BsEEK7c5+IpNBkTCWDIHKapBurkYbQdrkGeKM0oWwAOf+X1jW8TrY9gC?=
 =?us-ascii?Q?yhu9bwIFcYHvVT9Al1ZXdpUZF2LbtSEbR3Pfj/e0PzEcYCJD7a/F2/tCbsAF?=
 =?us-ascii?Q?9I9K7jc75NNqYCmUl0VjZm2YT0t6Nubu9skyP7yEDF/tE/EwnhWv3uQobRWj?=
 =?us-ascii?Q?I3ex3tO1uxHfO2ht62BhNnwUuczH2/D1wnc/5SjyA74zf/Pu+HqNeNVCjqXe?=
 =?us-ascii?Q?ONOwWeuNDbLKojRsuP097cFON81reSRMKTKR6/jg1tPSiseqHbPzuaPjIulK?=
 =?us-ascii?Q?2HifWuCGpFWU2VsDZH1lFZygWFhQC20BMoPYEM2l0VMssFYsciDYCU1Q0Z0N?=
 =?us-ascii?Q?wzElq0PHy3JANQLZR7DYQkKFTW95J+SnXMEkZtTZsI19z/X2Xwe8/V3quX7R?=
 =?us-ascii?Q?zXUx1fGT89ZPEk5ZNhFm+45Sp6a1Qe7kT+7vvfosUPBtTawM6TSynOnuoBU/?=
 =?us-ascii?Q?lHSO2/ujT96J2yeBFQwQ9zB9RtdMSbM7D2eohshCOhNBijNXII7BIiVHUXv2?=
 =?us-ascii?Q?1BqQne2q1+zEmFIO1p07Sx/Nc/OQWXT2JXmph6VHlGLVuLScvl7I9OR3j6rg?=
 =?us-ascii?Q?qGUPsD+XPy8VM1fQElG0BkOUyNloZ1ZAMLnBAyYlLYw+gFG0dv98QL/SB7aJ?=
 =?us-ascii?Q?XZcbVSdlMCWxio9cCmeq3BUYG0AADY9eCwrS3kCqq0IMLKyCdsnO/uPsXAnE?=
 =?us-ascii?Q?Fzk207ADt3HNMzLsHpI7Og0b/Bl1fXP5wPhj7mSS49VUF3cZHfsDun8Ou6FR?=
 =?us-ascii?Q?icyjHh8eYEiblLgWsxhS9mnaZogy0VgWuN75jNh0Ev/++1T8kmpRJp67pbE/?=
 =?us-ascii?Q?0r53+1R+v1EGFPe0Vhvuw0FsNxSaodo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eb0c00-925d-4e45-8212-08deb19cdbb1
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:39.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO+sne8EHT0xzfnddmY1tduKE1sEfOzSwv6I6/z8ki4PttpV0lKrDYp0j7msoIQaQ6d22o4jO+6Fced/9WIKgvMxaQG2cOehgRSZmjkwkew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22946

[ Upstream commit 1e75d2e9a0e018b53f06dcc2e9345ac10f1aa174 ]

Program the class code register explicitly during PCIe configuration
initialization. RZ/G3E requires this register to be set, while RZ/G3S
has these values as hardware defaults.

This configuration is harmless for RZ/G3S where these match the hardware
defaults, and necessary for RZ/G3E to properly identify the device as a
PCI bridge.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-11-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 1de91ac54069..b3fade8443db 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1103,6 +1103,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s=
_pcie_host *host)
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
 	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
+	u32 mask =3D GENMASK(31, 8);
 	struct resource_entry *ft;
 	struct resource *bus;
 	u8 subordinate_bus;
@@ -1126,6 +1127,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
=20
+	/*
+	 * Explicitly program class code. RZ/G3E requires this configuration.
+	 * Harmless for RZ/G3S where this matches the hardware default.
+	 */
+	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
+			       field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
+
 	/* Disable access control to the CFGU */
 	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
=20
--=20
2.25.1


