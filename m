Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED118CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:43 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.51])
 by mx.groups.io with SMTP id smtpd.web10.998.1755705997301539526
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ngigegBY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.51, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbY629oewYiEKZPT1myFJXiQ5NiMDvYMg70YWCqOwuVw1VNEk4i1gfFR22bmWhlENC8EnnUpriRD5vhohCLVadvPaznhwZz6+/jPJwW+gZvN93Y6s+P688Ygp3hs8sznI7IblFFaCLMsS+8sGAowm4oNRTEhazZs8CyH100a3Zkj6rgcrXIfmM6eH/46A+Z+0MZ7Z16TovkWLnu0vJNFmEHL2JDlVgS1FFKnMY/0juMMpsZO3uEEDKenUqwujZtMLPz6gcPZY2QsbPnPvsj5ARGvME0yR6hCZYt44PmBTDouFXDr162N0uohoQFdYYO0jQmA052yYa1XEDV6cpW4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOwUHNbG5NWw6O4Bb7Kq+qxvwsSDzrrkshp1aNErBCo=;
 b=dhuBan/I+DruRTD1i89cYUdYPySVc0wXgGjSgGcT6lUzVlECxXZxnmXODL7pFEbBuELPbsnIJn1cd7LZSo78QfoAAsJ1OvV1VBjYVDh9NARxwUdZLUoWOAMluAVwrr+pPhKu3d7NmGcZ16tntafTWzwPVHhXZBphoc5nak9Piu4E9jmBzDlkyYot6nRSvzyQ3Hw952ddajwNsE1i0Xu6oVLOvW7tutxg2UaanVkCtPtSRMKZeZf52TZpeuSGpPYkKBP2g7cx0CRcH4+4isUC1Krv6Sb76RwJuXf1n/JTMih4TRWOEmDgorW5boYeFy3QKdl7uhLzey3wkk3QKV1OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOwUHNbG5NWw6O4Bb7Kq+qxvwsSDzrrkshp1aNErBCo=;
 b=ngigegBYQZiiUvPKKaVydVgqankwp3sB6r//SnDG6jUsNn3zpLqoLojKLQJBPsFgsVOPLFmBPfvl05eUT8qJv7RFdS5zB+s5astDG06drXE69ln7R/EzvZIkOSrpW6uVF9m0eWDa6H5wKw6liaUQC4kaFFybTUze/jbKyWQSCjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:35 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 46/55] arm64: dts: renesas: r9a09g047e57-smarc: Add I2C0 pincontrol
Date: Wed, 20 Aug 2025 18:04:02 +0200
Message-ID: <20250820160413.801341-47-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e6ad9e-75db-43da-3cb5-08dde003895c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p4m4ZOas8wlbEvCdlg2iIrAZA33lDS8ZM0BoOcwPgd6HM9etUf1Vc7Q6mB5P?=
 =?us-ascii?Q?svZEXNBKS4EJFcK0ywvBK6aCayDv7II32Lw0yrMDoe2oKynFwKhCL33UCOqF?=
 =?us-ascii?Q?7TlJ+Ut8kpSH7YHc/WdUlePSZ81rlqw9k2TqRlyHrO9q3SMIpHWGpzqiOWcq?=
 =?us-ascii?Q?/9GCnPa05uBKs84uVGmMlQO9NHlMUVGSl/oVvqAgIv0rM1nuIhVASSK/z4qS?=
 =?us-ascii?Q?HiMvKnwXcZkctag6qsF+HAbkeBXy3nmD6lQi00fpeMwtnMDV8JMCYTqgSjuK?=
 =?us-ascii?Q?uPDh8a1ZISOzNhxSzfi3AaxIko5xhnSsfO9oOdIUrgqG+1BllD2LfZ3wZ5vp?=
 =?us-ascii?Q?7j2rTeCu3dnoEsJcHJ3IhREx/IwmKdRWEMmwktAHIKFK3EDQ+ae4EuHcjcsP?=
 =?us-ascii?Q?6bYrZHc2ZSFJvPK2MNMEwTJpg4Fmy1djAs7KQ+IJZn566e77Qp0tkeTlBTKg?=
 =?us-ascii?Q?jGk82gFMM1Rdhq8QEjnCmsAmA5v6b/OpKt41tvTTvYkb9MD7OcQZT0CgBZUr?=
 =?us-ascii?Q?9pzWCf3TLJequN5+eTxaM5ZRfMnK4tY1fOYgvuC2IXeryZ//6BvXJTxWCuKI?=
 =?us-ascii?Q?RizGznAZL7cilDI0e+dlvBXmnU0l0TSmJiS8nn/nURMqIXhInmCCxlLCd8+d?=
 =?us-ascii?Q?Qly8hLCIaj90cIGw8FSWx45A1eHIXi9mKYagCz3Jze+FzcMUih0FbC80M53Q?=
 =?us-ascii?Q?B+OxTLb/0Z+ckTCfNUGfjnzdqrafHatz5AVEMlltZSdZL4hMw/LA6VJ2DU8n?=
 =?us-ascii?Q?OrV6BsIqQIgxEZFwvwqppVSZ6Tz7lEiGiFuFH4aKaNtO3721SelaDxUFedPJ?=
 =?us-ascii?Q?NQ2zKUjpUaywXClq+y3NwHQsAcsGDaVdHvlsqKeUI3FB4jaO/pT8lMQiPM+F?=
 =?us-ascii?Q?RN9KTl3uBfNBhT5ityBJvXpnmUbS9eIvjBhJzaLCUC0n31/8pHHrOyg9KFYa?=
 =?us-ascii?Q?i1nE+UDF0xHI3FV4u2vZYW3vYAmZfzRFnH8C4MRBVuVOYI71MKhwMc98W9HF?=
 =?us-ascii?Q?vN1mLO4SvwJI00mAADFn90NcxypZyciyNmNXnD9kinbfao9/WVdzOqoiwbch?=
 =?us-ascii?Q?8e/bXvOpiKfiTUfp4jCw8nwKogt5MOwE40oLFnU0mlOxowWNmZuf+OeSMZJM?=
 =?us-ascii?Q?Z5WUfmuL/N8DdUH9q2/vyxiufMCHHgABj33E8wbit1hopjYxlhI+HAS5YyHQ?=
 =?us-ascii?Q?635qrvesLmQhOwURwzGSzHAj4vun/kbwQHCKUXUpkPq9imj6Vi3ttqlgVCrl?=
 =?us-ascii?Q?wF1gDALx+t4EZhM0BVH6yX3qgecrcbg33IbvNcyqZE7qfLPzkz/SLaFJPy/9?=
 =?us-ascii?Q?aESyXjcoWKHeLFkZ5IjVpxtaWZMv44ew8t/njG4FcLQ5R7mNdbgF7pvVQP8S?=
 =?us-ascii?Q?jLFadXYFw0zADdWmpIcaTvbrpJMM3+imeTF3zrEdXINmRkWy3FU/SeE6Tr6w?=
 =?us-ascii?Q?FYU5qWoH81UfWtwVs1vfpCbhsPIDq3aL4rY3gYI3cQ0e5lmGHeRoj1qFzoKF?=
 =?us-ascii?Q?VrhTKMvgy10xfdw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1n7betOwRunB7c/xmGxUTsKtajGVTZetD4tw2NnfjtAidpjNM9QId0hGHd6v?=
 =?us-ascii?Q?aBg9iw5jsPH83fko3oC6IqMlja4Os+Q3U60AsMse3cRNV3ObeloAmV6GV5xE?=
 =?us-ascii?Q?dlglaveX8b/dWyqFnnKfAqK9D8ZbQrd2KbceBZ47xdopbWc1wrs51k6z3Sim?=
 =?us-ascii?Q?RvRka8pQhFA5mRkjVWcEjTHRJKc0zasINtC9tpBm1HFEXpEAfFYhCU0Ecf02?=
 =?us-ascii?Q?P+2nadZ30ve/5zfBox5aYJuLLhj+Ry/E9yqQBfEEe4t8sLI4lnHhpqoFq/4s?=
 =?us-ascii?Q?swaYxfk6RQ/kSXX5fJo5x4lQJf8r1SfT34tJZIF62/miLdwIsfdgBbQivyx9?=
 =?us-ascii?Q?7enjW2mysoJ/9lgL4kfQU+tDNZN/1vLlFDRqsczNyA7s9mY/4svwynRf2OG6?=
 =?us-ascii?Q?kcYgdEPLUeyOXzmCtBeTuvUyZqQ5AEPmFPseOH3eUj1D5YBkusqfREmTGVGG?=
 =?us-ascii?Q?icbFE83fYcD4PTgUQpQeOUn9girCUAJ6ZuKJHSVyoRHstf9M6MeborgZNbJF?=
 =?us-ascii?Q?HOOlfrlCMctvq/PKCtTJL4HmImctIOvxJrNnBKG80g+Gc55AmQgdqQj3DJdH?=
 =?us-ascii?Q?1smb62Ut6QE0ee4737mXbh5S1Q4VVz5va9UaRhNwox7LDDEXpP+b4fw0M4Y9?=
 =?us-ascii?Q?79qVYRrZ/5unzTfVVep3fCgXWHjDzpO2dXarX/qQEYU7iwEVUwtUBGU2V++S?=
 =?us-ascii?Q?PWJ/hfEW1NfJTYatkjl8B0KaG7+C3UHEJmqjIafZ6ftaIiyz6GNYWUAjIKsR?=
 =?us-ascii?Q?15v7AlKyg4IfW4Hi9bvWDm8sDpbhBXTCyXh+9Hl3fzyYcabfAgX06JC1/TCA?=
 =?us-ascii?Q?SO7szGCJVf/LILWEK16MaE3hoY0HTNjqHG7rvC08uDftDCa4SE1kqQimQQdu?=
 =?us-ascii?Q?upnpepWF0F6LNROtVcPMGbEDe0t6cU13w9SzA7z+C5G3WYGKSOVeAezhRMj4?=
 =?us-ascii?Q?+XDMAUqaNyY6aXpPFQu0EGV3sUqVr7NbpTKM2N4GYeT44QnsnjptFzGfwIu9?=
 =?us-ascii?Q?jzNNIeX4JKqEuVzOVJlJov08wZccHvYBEDt0Q4cTnrEbsoanwCL2FeShtpbi?=
 =?us-ascii?Q?HrOD5lhuwOdximZsY8GAieA/zPgrWu9Nv2UDJtfMKSootBbw7i2xgtq0Sh5K?=
 =?us-ascii?Q?/IQwZpOsyl/NwpcidfRY2AsXuPpoCHqIghFNEmFn7yCkrBFPOEfM3ebPvXC9?=
 =?us-ascii?Q?KCB0ULxlA/KqZ6esW++Op6pkcPttEyqVK5GAKsmiLUnr3B76xrc2Sj6m+MTe?=
 =?us-ascii?Q?sTIg/Wo7Ha6ab7wMegZr9QOcJWP3mGWk+EUoGkiPl1rgi1Quks31JLjNSed2?=
 =?us-ascii?Q?azmNL7hIkQsBKXghOiWj+sCkA1tNabeihlxfw9VS9OXbVZRKqRLk8sjou1Jt?=
 =?us-ascii?Q?FzDQUiEjqJwCdutSCPz/pGkHqg8vEVCADOxW17sLd8XuPjA6TY4VP4uU7cIo?=
 =?us-ascii?Q?3yZVVNQ9+6zHc8vVpXwJ/DtLL0H0xQduoM7udZICHWlLDR6uAGuiE5VUc51K?=
 =?us-ascii?Q?JjLc2OPMBMR2inyAVbTup809maWgvCO4cw9UPpZ9eXOZA8oV97wKWm9kLnw8?=
 =?us-ascii?Q?SZ1eNfqSIPDx2HZoVHGHb/6NJQ/rAEmRXhAHDx0VpM3JeUgtWtqfZQEPin27?=
 =?us-ascii?Q?NeowYzEgBS6bKeTch1DS6aY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6ad9e-75db-43da-3cb5-08dde003895c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:35.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0fByy3S+IqzXW2ZujB0zFDN9wwzLgr4BkN2MToLqR7K9J0sKnLdflor4sFObd9HA9xO2Qb5BGkLLHmPPjn/h99qeNRezhy4eOYjwjv7dwgIxJ+IAjzd1hdt4lp0RQsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19871

commit bf3409a6612cb94b03c708350d56a4755e65970d upstream.

Add device node for I2C0 pincontrol.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514162422.910114-3-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index 1f5e61a73c35..2454a9743df2 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -74,6 +74,11 @@ &can_transceiver1 {
 };
 #endif
=20
+&i2c0 {
+	pinctrl-0 =3D <&i2c0_pins>;
+	pinctrl-names =3D "default";
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
@@ -87,6 +92,11 @@ can4_pins: can4 {
 		};
 	};
=20
+	i2c0_pins: i2c0 {
+		pinmux =3D <RZG3E_PORT_PINMUX(D, 4, 4)>, /* SCL0 */
+			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
+	};
+
 	scif_pins: scif {
 		pins =3D "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance =3D <1>;
--=20
2.43.0


