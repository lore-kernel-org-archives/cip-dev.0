Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E4EC36016
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:08:01 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.web10.49424.1743419278930271975
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mIIztaEh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzHvQwWPwfcwb18KJau8G2+J3pXx9RplwqkBGZJYxRaZCa54Ug++qnZ7+UP/rFKdjlPo4wPej9tpLKRvapScI5iiSf/kDJdyR3SDRw0vmNdZwTUtYWbobpF7Iy0OiJGdje+yRXlZ0HbhOEKEXna+IUSEOiR4lsj1w0u6HKPV1FpGRbfA9bsyUqLAoW4VAiNuwwd81uDJcrTU3d85nHzppaaSO3MolXpu33YshHbQ0j8HBZcr9tVVtOWf3Fi2ovor1EilhjBHmtSP9hr4/PbaVDvmtRCpKfwOWEyPBSu8WPCY6nOj7HjpQe0tyjTM9sDenxC+KNzrKrRu+idQiWgZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEALd6uSJ63zhlZhlF6MntZ5FEmXlNSK5KCQaAtKg2M=;
 b=Jpt3mhEz4tOGo+vLb1W36yPyzUY2OmGoKE2x5yxMM2CYlSz6Kqf0PXkqek79g5B3z6P4Ta286AEBNGSxoSqoyzgT7+MLnQQqaK12LTvgdomTEIMDsISCOlk09m7GUyGxqyi5YMjZTNcYsJgqxziXGqEQoRdFZvZ849oO+xZRNgB2HR5jrc34ZHqInpk28QBy8Zs9Z20BHR6TjWea4JicT0V+DNAvgZrDXvJdWNj3HqZw6oDYgG/qwzAI1hh35txAOnTfGdxbvWqokukZ6NEICJxWg6PcERPbXUBEx5pgWJUyX/BB2GINItDD7BbV7pX0Bl3SbLsdiML6hrZE4GSeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEALd6uSJ63zhlZhlF6MntZ5FEmXlNSK5KCQaAtKg2M=;
 b=mIIztaEhLbKi0iDTBdptz/Tav3od6wS4B605nk1Ljd+1RqLFdoVdhOxYtWQke3WC5lUdy1cqlc9BpzOi0zbwtF3mKaPINUGfLfdXh8ph501dWr09q7TyWAbkqfpp0Yu8xHlIrmqhPMzRLxxliqbEwY1emPqmX9BZz6gFY7WRTsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/13] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
Date: Mon, 31 Mar 2025 13:06:59 +0200
Message-ID: <20250331110659.252237-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed0f027-422c-48e5-307d-08dd70444abe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3MSYFVXcxlGBvht/naxPuGmSKumqJkR14k6S9dbk6AfCDcNMPXbli5umnkxW?=
 =?us-ascii?Q?JDmBW0qv3Pn/YIFbkgtO8i22h7Mfz3FFNhe9DmpoY+ERWQjy8CGWK8E594Gg?=
 =?us-ascii?Q?53P9jTrfqxixGT6+NT3uPbn5vCbyrnp0yioSl3SptvfzfKMGpIwBa3uSZfMo?=
 =?us-ascii?Q?U9qiEr4ax6n+lYFE2PJaOJh4750PmDna21ccn89wsh5yJ/RS8euRoawmjNS7?=
 =?us-ascii?Q?HhK2OCPNlK4bxAwcS9KRX0ZzqFgdBP9JstYXpyw+UrINBpUksJ46rUQ2785A?=
 =?us-ascii?Q?Gn7SSa1VzlKYl0vSFXj7BcMns1Q2ETRU/tP6F1Wpb3tsNTCR4LV4Ob6XbjQc?=
 =?us-ascii?Q?SheC+0TUyU8Tam2BHZ7tVh8JQQ05V9mTRiqxMs0AIEEj5PwotUGvBxlosSRr?=
 =?us-ascii?Q?VxxMPi/G7D3XxKlPP3ABHGrM/m4BSEzeIDcdK9YZ9qmDroSLIoFF8Rm74Qqk?=
 =?us-ascii?Q?fMhiRvpz45xbzM6nSKYoUHz4CnG767LJh8yEWZkDzdIE2F/PZlU2Hzb91pBG?=
 =?us-ascii?Q?ai7KKIZULsVH+oklssaA2jnAA17AevvOgUvvZBx0dXAp5LqzoIRhbrPvnr87?=
 =?us-ascii?Q?0kbiUqZRlaHhHO+OanJIAIJLP7uRFcEyj/lSJddPhploxoMV0ZezMfp5lmUO?=
 =?us-ascii?Q?FQCukFFYEzFdo8YPRWmq9OhmCXxmmwuaRrllHL2zuq+uVG70ovBf1T53zdh4?=
 =?us-ascii?Q?joPQJ9MtL0lOgj1TyI5gn+bQHtusJMjsuYzwk7WbUfi8Quku61r0NyX0mVC3?=
 =?us-ascii?Q?NoUwSfwfPIqlwTTMgOqmuOPi8w15oCLOWULbgFz74an0PHmlAZHtrrJaki1p?=
 =?us-ascii?Q?PRwym+WXtoQpiciDojLNIH+hGqs5O4ySeFU+Lsne3b+oO9AzWqwNw35Hfd79?=
 =?us-ascii?Q?DDqpFVRq156jEuYKtBy/qfWnoND8VhvgHahcjg5ruz8Rh08pwzu/4HgYx6oB?=
 =?us-ascii?Q?JwNtuy69uh9z00Ap+B3/brcPOX4EAIunW3hynmG7TV/peye0a5q0C+vE7TUg?=
 =?us-ascii?Q?NdyjfNMLK8DXmsr2aK9QGUWY9peYY3O0YzL5r1jSriHQ2TKM4Ww2ffG6oCcY?=
 =?us-ascii?Q?rZbXscKSvMiCD1twXgCl16kbqfoT7AnF9yGWnBSwBqYEhriHNHE+MU9m/Gu+?=
 =?us-ascii?Q?Hh4uRUFbuD0tOw2K8Fj3T3Qi1SRAW/9MA5yR9yw3qoQCa/4Xw0rcXlos6pJ3?=
 =?us-ascii?Q?hJlRe2BBn5V9OCXJNesEi619cLgv6p/4ye9FyfYCVI9WNEDb8ldVipQ2a3lU?=
 =?us-ascii?Q?muQEcBJ1zK2x+A9UONsU7bvXnmsXYmB8iToLMUKu9fDUvTo4Ez6Sip0DJn2n?=
 =?us-ascii?Q?WAnMHD+wyW2waTlzxedZn5e47syNA6zJoPrOR4uYfkW43+wTBCI3/DtVeUP9?=
 =?us-ascii?Q?jgAp0SqDnY7gADLjjVFnIPuVw1dlSfVbcyIem4E17iVzoSqLtLkVzUtfdWqm?=
 =?us-ascii?Q?sHJn53Ie75K7UGRqTGsjIhsDNe7zirO3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fWae3FIDxbq8eTWkKzWwu/ZkgqrGZDdPwPxIUSH/k6DGb6es8Kjfx+cP16jn?=
 =?us-ascii?Q?EOzNSIBDfNzThopYTMGZPkqNmwRJClNXgTIMfWIHpn4kA3VrS6VAUqTVoT0U?=
 =?us-ascii?Q?53A3uWIm/Jq+dEhbt9rjciYJcpJkyQ1HZeFHuFqz3ZngB3gd/p50Rqjevpqs?=
 =?us-ascii?Q?BTc8qGqXIvq6deHnNtLnPdYGlB1RlYOaCoBcIabRSFwOKUG0SV3BqDgMoxgV?=
 =?us-ascii?Q?t6BCOS6rVuH7XUdrH1+zlHskOzET1Odr1n2OwnxVX1VbZiRYe/frGCbQy7di?=
 =?us-ascii?Q?nCXKXAzm8yinOHnyVIdVUkzTSRvaZKipKilqJGdjEjhHbflrg032uRrziT2Z?=
 =?us-ascii?Q?/zuuo4II5WwS2RO/hAo6LE4z7qtNlZuNairbFgzuRcV9dJ9D3wkk/qDCYykt?=
 =?us-ascii?Q?hhbsP1Y14HPdrJm8ZRvbb8TQbMbItNSg1hyZtkrXUZVR3x8JDnVkCIndLAcs?=
 =?us-ascii?Q?6xg6iuffk12Yi12Fd30hdDwOSen5+ZbdFkhi7neSkOM02hbyDIi5LxMKztuE?=
 =?us-ascii?Q?g9ItCqz5bRN4j8c9jFNPNdcAuCw4tv15JmIPDbzSYe8TQ9gjL0a2ePoxg8PE?=
 =?us-ascii?Q?v94HVlsIQy6bBt6B7Hj6SdVKODmdM01XmU1Jb1Xtm/5+6wskl5KX5PhoY+wO?=
 =?us-ascii?Q?AgRjowVkCgE54V7CZhIVGhjvOlMLQR+JBT1FUqaBPYVsS0l3AchoMyH1vllb?=
 =?us-ascii?Q?OEPtowtCW3uWae2a+Ls+EECpBPQmWDydrfiBxe/xNXMz/OLExonRdp9NFpWo?=
 =?us-ascii?Q?QCuDmpTTT7FsSLWVl2/FWJFdfoeHJt3FkbfJ5mvEw1oki46jG8UqZt4G06aM?=
 =?us-ascii?Q?LwGO9TnQQQjT+s8QmgXpK9sWWaNmmrKxOqAF10lAxeayS46548Zev+xuAItv?=
 =?us-ascii?Q?WfZgxUiFZQB3ubpwV1fu2IgA7kV87BRjR8TssoJ1JlN1YU5kKdLWKbWDA22g?=
 =?us-ascii?Q?AzjJxR0VEkDwIDP4W8RTTrNmIzpdgm7jHbBfBVavmxlQuuY04qHRFBqRR8c8?=
 =?us-ascii?Q?C+a65BeMcEwwrO9jcnRm13cAxsOiDo12Kvnkycxe0Vhqeu6bXvKTdm+AvmUK?=
 =?us-ascii?Q?zADKtxjN2fFQaExn0+P72h9cNsK/B4rWP7UPv+soD5vnU0i5BiUpm7YE1Rh4?=
 =?us-ascii?Q?4ijfiecgOaxbBDbcdXFA1ADZN77W9FwQWHQR7wL9AWr4Vd02P9ur7AnOnlws?=
 =?us-ascii?Q?R4pxddXR9DOZGWyR+bk5dCHA4Ne7Rvstn/WeH/0RG5Sb2Sk8m8ZqGs4wulug?=
 =?us-ascii?Q?OGavlB+IY8Yb0KNFGfVbqrQq7sUYK7l57iSLCLNXWwYCVdNPV45QHpq2krV4?=
 =?us-ascii?Q?KIjQ0ZCIDG1It/xHJHCJBYG2167+qxcpVgJwelHCv7wHtj1+3FGGmrahnmG5?=
 =?us-ascii?Q?TB1B++becgXCyMBN9jTI2GSt4zkZ8o58fEEQSLui+Yr7jvH3PAjjk527aHXa?=
 =?us-ascii?Q?LQ7/4FiQj8Z+jzB0FMOyRYJNahUFf6LFdEeEoQK/A/iZXFxWFyjCZbpw6P8K?=
 =?us-ascii?Q?PFlYasM5R6qtSRHQd5MzjDJS0lhTFtYXMoEHUFOwsJTrJTmWETRUnR6FrKvb?=
 =?us-ascii?Q?Inv0XTHKePTR+cxDpwadGJUzALsn7iSpw2hS+GRz5QSo0KsNIeirVGPCPVG6?=
 =?us-ascii?Q?EZb4aQgnFFLcIvdPOAwagSE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed0f027-422c-48e5-307d-08dd70444abe
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:57.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M902xklMSNsUi7mQf2y95oIMB0wTU9kBbw6CO3UzN8pTFfz7F5NkmKpTJxyTzxlpwGfOwTIsNmGlUB9a/yG/76Qgez2hV1+QfeQOZArEDjbfsCRiSS4AqGlFC91uhuSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18445

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9e269561b363038d573a69755c9eeabc9258837f upstream.

Add device node for SCIF pincontrol.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-8-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index d4d61bd039696..c063d47e2952f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -7,6 +7,7 @@
=20
 /dts-v1/;
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
@@ -16,3 +17,15 @@ / {
 	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
 		     "renesas,r9a09g047e57", "renesas,r9a09g047";
 };
+
+&pinctrl {
+	scif_pins: scif {
+		pins =3D "SCIF_TXD", "SCIF_RXD";
+		renesas,output-impedance =3D <1>;
+	};
+};
+
+&scif0 {
+	pinctrl-0 =3D <&scif_pins>;
+	pinctrl-names =3D "default";
+};
--=20
2.43.0


