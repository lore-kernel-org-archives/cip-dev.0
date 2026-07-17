Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F0C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:39 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13251.1784294018149120735
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dIDZcm3Y;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U85bQElSnfKK9kJEttfgW/LWw7m0f2ztNvpuN/vg7Xd4AidmYTom1TwYv/6fcqkD255kxwTrY2yJ1xN6Kn4yji4I9pOJRoV2VGj+YwzNtCG3NNtFoR1DZWcdQ/GBTrl+9NmE0RkuW4XOzM98MVKImhhWEJmtu1nrloDehABT++BY+ixdp2Qc/Kutr09ooBlzwQ8J9N33AFx8aSpUpeJDj7jEfkxrJbztz5+hy99uVH7lo3g5y8t/6j363oMhza5mZUrGvLen1TYKv2eKZ0o7L9eD3o6nyoxxg8patpesqiR78XeSKDUE+WQ2CzcODUYoRdY1SLv5V54zf1sm9Lz7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8T3F4Cpb4ELpGbXAUKwIeOtyBi837is7W9IAkVXTNo=;
 b=Hp//ilOUXV1szuwmp69BKzcXrQYgCLALY42o0AXbdqckGuJba4n0Ym+Auz8QGLw+HJNIfju7OnwdYPqF+FVS3MI/5VNbvkyTgOwIkcpbJpgXC7OmQRGoGV60JThIumWUKwNVR1J3ncOYfcL3O7gZuWIF5cXfZNNBOofN/L17B73pLXjuFLgtQZBA6SZXCThIX9H8MCa1lKsKlXiQzoNtqMwsvtY+xf9ZI8KxokFgIKwH/K8waqIeA56cYF1QUs4ZKDalcpeo0yqRop0IeWJ0EJS7tOB0OzPFqgy3fu4XI6RyBofR2GE9gKA67TuO91+rjakIhOW3lObtdpV5+Mf/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8T3F4Cpb4ELpGbXAUKwIeOtyBi837is7W9IAkVXTNo=;
 b=dIDZcm3YwwK05cq5y41CkUqCL+fFG1gcaPw6+BQ1Tv/YO10IYZOFlZirI1MYOyVRnc9Gz2YBMoCd61PEfj/svZuGGbvuiviorJqpsjEO8dhJrbDyF2stJOZC5scI6CkcOH9me4oAflnmKzabNbxOpaLZcCXahCvsvqERJYJm+Kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:36 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/23] dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Fri, 17 Jul 2026 15:12:26 +0200
Message-ID: <20260717131241.2233788-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: af0bf314-1352-4869-4f17-08dee4053551
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	+Po7QF5xTXT8FFIJMt+YKW367LbgKueM0nuhwxJT5B8U6QW6UvwY/s9Ag6hxkV/9CAG4Kv0RvlXylFRW8Kx6PtFfow83Z7QxYa42+E0M0Xrdoi1Q5RmsyNp5vKVppF7eR1snu7gnRPmTgkHNzLUDHyFyD7npLoLgt1b6Zsu6w5BORUKG+QuOTnt9w0k4aJdZ/uArTB0I/cIgvrJb1AtZBHlc3p5QH1XPXJcFV3LE6D/O46yr1dtS4gRA2yi0zX6Vcf7pHj79jIA5E/iHP1YhWXiOevfr602oTCzuEqA3Y56NvhAW3JeEGXSUudF3wZnHTwj9Zx9ns/kx1wTm4LuUnRnYyhE/ZGMi265HaRdvwLoICQcpcbYB0qrQdOBJewOy2OeUVDcyF1LJPjdFYWF0rhIw7aDWl2zm1CS1uJ1nPby//gKjzTtv8BZ8uHibfaq76l2vStprYPlcX0MO+OxilaUOljOyQeHcyIiL03dk7ecAvyjRhbHTTGf5Pv4WTIaLsvWQKN1CCfaeLxmKRRI9HjFPO/A92imRswqOgGB96WTPLPI0CHLS6wOtxaHREYDkk6PxLz6rJLWxoHGFRrPofxPpWYZOUVHud7K9BaPvjGVkkHsOwmo2pnb1WFCb4Cxk79vSUgdXK4uNGuQWu93xeDOPdNVekXb81+kA+WeVQBvx73PDH7x9oSLVb+630KzSEKt9MUND1v3cLSCnpiWLLaDRDO+nNLelHTswzdfT3eU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Du5k3pALqHHf4loP5CnPiU2oKNTg3ZNvEh9lTQWMGgtTqfe7T0OMIccS8cTW?=
 =?us-ascii?Q?+rNxVj7dF/RaXIkLf36wnaXS2NLyUo+XhX79ButsKQM4A985iTwcMLb1lGe8?=
 =?us-ascii?Q?PcseVXve/TYvuN3rmkLmcKDJtk0Py4qSbWOkHNb95DxO+DVbfybMX8LZRshx?=
 =?us-ascii?Q?6lPgkmdWLT/4LIfQFmC1GzOwBlsfA1fWXgTc/KAXexx71Wt3IyXlnYfDkvIg?=
 =?us-ascii?Q?pO8Ilq62d5WQcdkUY+/ZC3Amee0RPQMjmuSClzjhgMjlR72BT7bppfjR7n+R?=
 =?us-ascii?Q?+THZezp1iO44KWDLWDk2pae5SkkL6A1ihIEG7P8xzWcTIuIi09g4PtbWnQCM?=
 =?us-ascii?Q?8VRSVOzPlhFkBI28cuZsKLg9qqb2lTImgBfrWLYAHM3r2nlLLD2qyhGaNqNU?=
 =?us-ascii?Q?yE6ysSq7tpYVcOyfQHBNTlJQmjSEHO5q2s+q5D38ATNTEsuzrOxtuTUezUpa?=
 =?us-ascii?Q?Ptqv8clNzsWAPWmiMgKVK+WkBy65UBuDWt2nrzC8TpTdDM2Jn4b309uMgNHG?=
 =?us-ascii?Q?cTt/EA+/zsenhlOMYkoDGVopyOy7k+q6hniHwn9ojN7ncR6gYUMi3wnrDDxz?=
 =?us-ascii?Q?YaIbBDc1z8ocUZtic7iL/vFhSmMExhd7jFfUZK6jmjUtDHWclMCP/XUjNX4C?=
 =?us-ascii?Q?6+1mJ/xXdkUReDHezF+Pq/k9X9AXL8WC1gaZ4g8y426xzjJdZWef5fBkbTYV?=
 =?us-ascii?Q?u/LRB/fEuOTytCbQiIjO6d67j9iHRJK4Mjh5H8KQ3Vt7nxb+sptSxUUorFdu?=
 =?us-ascii?Q?h2RoKES71pkjZ3ztmBF6ifCdQ6WZoBQ7RczuCD/a2uUccAHxdzMQ1B59ynZg?=
 =?us-ascii?Q?PsBvSfSdXbk8rTCv3VGPe/58g/CoH+OtveOc3mdcYff3dQHn078W+iddrW6T?=
 =?us-ascii?Q?8zFuL5zbudki7NR2rCH8k6zTGye27NSlmen6P1P58BDYdFa1GdyyZsIq1jPu?=
 =?us-ascii?Q?kS7sV8Dt6OD1VP/cpZa2X73XS7ni73bn/K57CSFSN79uPF3FvAvu9gNdQlRs?=
 =?us-ascii?Q?c/17THz3JqjHYXpjZ/jbh1T9r1ohWXT6wLTa4iSmHwgUkyVERZLtdVPOwBY+?=
 =?us-ascii?Q?295VyHmiXqmORUlTDjUcRWLJfx5Ltt2co778vSIGmnoOUrXUtHZTqyn5Felr?=
 =?us-ascii?Q?sLejQgBuGRVxcc2Lx+4FobGdRVo4/SQPsytcMhVA0w9S06HNSyeU8Kh1Ytzh?=
 =?us-ascii?Q?VbeB8PEDAUE2J0Qq5uW8N2wnABK+KKXOaHzEURW+tCLXFel7X1yDYHa7J/8r?=
 =?us-ascii?Q?GDhlJSsFi/psWeHhsWQ6hzb0gcROMRM32jCvfezeDP/z84eHzyy5WCPyEr1S?=
 =?us-ascii?Q?9YmshMhNJC1ed5yaMZkk1vj4PcefFwF56ODurhvGIFuDMm7W0/8RA82+oIF9?=
 =?us-ascii?Q?VkRSETBje9peRiB7XJg48W9BOF0UkeI1ZVQUqrCoZWpK+7DTEcQbN6hCtjs+?=
 =?us-ascii?Q?O78HAQ71Wk41Szs+BU+FUKI1X2w7prKnX75YNLUM8VWlr8y+lL6wh+6G3WGa?=
 =?us-ascii?Q?R4UPa9GnIyGJqIp58+PiSBn2VaaqlNGinImBSYvpHTWs0JU+FjYV7IJMm5zX?=
 =?us-ascii?Q?lKAXAXES9o6+iSVmcRgDB1TeLJJDLQI+QjzsPhunXPnSoToE0f7bUH0QqlC1?=
 =?us-ascii?Q?R7ck6ev/5BBJJ/kAp25sYLjS14Z/62SKPRB8gSDbhTqFiAx791EYNJFK2J/f?=
 =?us-ascii?Q?WB6NjOUvhgzDEpy29SuMZskV6WTf26JAVYivwuKa+NkyA8DdlNXlthxzdNx4?=
 =?us-ascii?Q?TpMBDbRFvmCDPDx9DEXAAw2lijHovl0nYYQWNs3am7AacKLztPa4?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0bf314-1352-4869-4f17-08dee4053551
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:35.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtgjBIL3Yv3kV2QvKTlRZU0ADtL6+mDEzAxvT/X6yU53tZUi8S/aEOchdSEjmnZu6PanTKnwhja4E2t/GHJo3ikutlIy47qtDx52nqvPEHZhJ0y+cWIVARdFCWvhwn41
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23636

From: Abdel Alkuor <alkuor@gmail.com>

commit de9c6033fb4de6013c5a4f6cc23b3b40c618cad2 upstream.

as6200 is a temperature sensor with a range between -40=C2=B0C to
125=C2=B0C degrees and an accuracy of =C2=B10.4=C2=B0C degree between 0
and 65=C2=B0C and =C2=B11=C2=B0C for the other ranges.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.17=
03127334.git.alkuor@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/hwmon/lm75.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 8226e3b5d028..a7af231c52d3 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - adi,adt75
+      - ams,as6200
       - atmel,at30ts74
       - dallas,ds1775
       - dallas,ds75
@@ -48,10 +49,28 @@ properties:
   vs-supply:
     description: phandle to the regulator that provides the +VS supply
=20
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
=20
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ams,as6200
+                - ti,tmp100
+                - ti,tmp101
+                - ti,tmp112
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
=20
 examples:
@@ -66,3 +85,17 @@ examples:
         vs-supply =3D <&vs>;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      temperature-sensor@48 {
+        compatible =3D "ams,as6200";
+        reg =3D <0x48>;
+        vs-supply =3D <&vs>;
+        interrupt-parent =3D <&gpio1>;
+        interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
+      };
+    };
--=20
2.54.0


