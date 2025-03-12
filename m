Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC9C35FF9
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.51])
 by mx.groups.io with SMTP id smtpd.web10.34449.1741778698389627250
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uYRi3eol;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.51, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+IxYLzHplPr/JAtZ/you1MdMukGGdfXFcHfFTmiK6VWYwhpuoChNnJT9BsQrD2dYMs/Pdy30tbySAw/87jQmA0Qy4R1sVq2jixoqjKuFSCqD/+iZFiWSAn+R6zWBdJSNDQHIVClK8mXNut/SjOBgjDBt4nstDabIppDGAHoTJMg9daXMvRW00v/c9olaco0Z4JRvMjOAGwYJbuGo4o68dZ6FCGmZ1xvjlQJvuNPfpZZXYYcmnnc9PqjaQaBOFYwSDdQyKjdcJ2XCWEzIIi61eNzxMHxtTyBzD2wTMjEhDC7c8HVg0pX3klz9uFIPZTVSftJ17krtdcwcHFzia4ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XzGDGnkrFQXMOEz7uOBqgDejlApJezB4ilNGVHe6pE=;
 b=cTM86LjvWUs32btYDodrE1zJeehqoRctMe1RNuQjUP5AynS7Ht6z/lRV+BHDNu35gf/Ylb1pE0qCyWgBJ9TFYwUhpqbatbbyqjAP93GJg9UoauC/kHC7L3Vazoda//iri9hCJhtbBzC8srFs8CkmKpqR/yzjSqu2V8cq6DAb8v2P22ygY3qZ+zBbdZkmi92QLocS9GDR9qxDs8WEIG7euJn70cRkGTwV7WC0flK5N8t7AokzEWCmDcEDE1cU/TyIKRCKSF2ibezgyQ2z01BniMj/3mpY5IgArKnLn6T8fQEYSdlmhmuW7BJiW8rDKXdsWSy1NIZAN+dNvfeMu91dyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XzGDGnkrFQXMOEz7uOBqgDejlApJezB4ilNGVHe6pE=;
 b=uYRi3eolsAmpgeqDJXvIKwMWt6TVws+ysA+jy5nBHw1AbwUpWbTRqkb+PeFSps1QO6komyWXvZxiu/DTUnWlLpEpdQapw7D2AaK0rIVyY81lNzmGwCTS7jMxpW9LaQe5stoB7tmb3L7NuVMwrvc3cQBdzkcYIVAXpI7ZJMvUn7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 27/85] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open drain properties
Date: Wed, 12 Mar 2025 12:22:04 +0100
Message-ID: <20250312112302.1605750-28-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4be7a0-49f2-4415-7c15-08dd615883df
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/W4lye/cZtIaaUJ/Dt3uDerq5+pyLchcvD+GFy45rYSFlWXhv+1Bwl9iVVVr?=
 =?us-ascii?Q?jrLZlvvsy/Mk3l90hUtxl/Jz2EsA7BIg2GYMo3Y6B/lfxAgBNre2cQ0ixwpu?=
 =?us-ascii?Q?9Iz3jHKsIxk/P/gTVGhn0qYfeRYSm0MJyrRNqPNZWLzV25V3cVtENEkfE/hZ?=
 =?us-ascii?Q?oSwiQ2viQmXRtFgfgcAqJC6NZkh3Fh7jcvA9x9mjYYiIBi/7XfNyXr0Prl6E?=
 =?us-ascii?Q?+qVdLYJug6AECuCfofgibYRY9dkYgbuzE3fHzdMKJJLklHVG7/bC1nKfxt4H?=
 =?us-ascii?Q?yW5/EAxMRur/8aSi/mB5qDm1RAdBiTdkFx+PKkbi9DZ+zi0I3BXDIFQSwP1d?=
 =?us-ascii?Q?UbHqL7RQiIUQPAxIsEgd+bo0QJj67a5KbgyOdVuZYrmfhr0DmQy9x4cmNRw4?=
 =?us-ascii?Q?dD2VMX9tOBwNO1wDewID9IkpTkI0Us6iPjA1Mz+zthFo627G2tf2eaXc0zkd?=
 =?us-ascii?Q?RyPoEbMhYdF1L26KnA1/uL/XEM9U+8pAQfqC6YEyyw7DEvczmHXqMXVVxz/u?=
 =?us-ascii?Q?DQMks9kT9Az48DY0Wdd6OtEOvoI2c+MP0SPF+0Et8AsY6+nzQeijc0skx8oN?=
 =?us-ascii?Q?OsTXxwX5wm5kYHdDwd0FN/PbJUhJv9mT5WfY6UTNlavr/QPmaS7rWcXyDHBG?=
 =?us-ascii?Q?1xGa7Q6qDh5tENZz3Lx9L69BiVDGGlyflMEN5YCANoQS1FBtlUXS6j0qh9fx?=
 =?us-ascii?Q?Jt7BolzleQ0zPtTgFOnANQLv9WYgyTuJxqBhrjAgreQQYCCyR+h+GrVJnKFz?=
 =?us-ascii?Q?/ZNBkXI5lxxwAqbfC7nFyApbIse9MkLWolihu1qhf2XKEcr1wZyURxjjrY9r?=
 =?us-ascii?Q?el1+HoV/RjZCYWJ1DWzjeqeIEQ7B5BC6Mzr+5bnnqGytjx83bPFBJb14alAt?=
 =?us-ascii?Q?xRRg/DQKeJ+Yuw/pPFuYNZYe4ikxoNQ/1xn8ddQz6UY1/goak1EtBAMoAOaZ?=
 =?us-ascii?Q?GabwH1x8ZkQf1cBJm1JnANJSwSxUeyNYq6A4F5Ta8q9yOhuGxdzJkZEwgLtf?=
 =?us-ascii?Q?I03eziZ85Nqva05UodGr3d4MRVBUwf61/HVqisTDF3FfFFyZnp0kWTkJ9XtN?=
 =?us-ascii?Q?uYal+jP0+rgjVzkWZ1YTVvreTq+4WNLp28akP1V8n6LMCEkk9lg+BZ3PHVOm?=
 =?us-ascii?Q?ZgXfEUTwa4nNKxB8ct6E9kI9/Pn8ypIWSKZ/R7FQyOYRvCzklwOj9LFhUlI+?=
 =?us-ascii?Q?4Xv1gEEhYDBc/liuyAsccrsJaE1pXt+wsUj2Z+480u7xpcAkIRQW4S+kG9pA?=
 =?us-ascii?Q?OJzRk2ePRtsJtp1lWjQuoJWxoHlDrJ0gcTJwNKn4dzjJAXmpJ71VNfD/dd4d?=
 =?us-ascii?Q?bdobdrIT+MCjO7Frt31VAiqV2Yx8+DXv/oc60DUYWMZiIhBnMAgELvS+toTa?=
 =?us-ascii?Q?J8yU7gboFSnwcdkHrg8N7KiVFQR02i7uoNYgZWRwHcD/kv3S5EiAlctySSS0?=
 =?us-ascii?Q?yvZdnQiOXxwaCPUXRfpcjI9KbLX49U1s?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mbIl9j2GMRwDufOz7jrrpyb95I1K5XBw2Q8/DQc26JCzNo8Ei/jt9W4eFh1d?=
 =?us-ascii?Q?ywTS6+sRTVQyFeSXEP4cz2p7fTrP/le+5QRD9d3219CGvHOZ5HCd7by6ZsL+?=
 =?us-ascii?Q?67xNEqr9p0r96tfAT/1QQ2aiDYKwovhOkJYsaXH53ApDjHRgtO3sJx2NMxAG?=
 =?us-ascii?Q?aKJBkMpJIoihBByYse3tT/czOobjVHLb3z+lJrFiYtuVh4O3nt8r2o6lE+5b?=
 =?us-ascii?Q?bIA5Sozfid20WSF/7gBHuA4oNsXr+RQ/g82gAGkEwAO76uZEzjivu7kqHOp6?=
 =?us-ascii?Q?r/EugnKNRffzYL+ZGeqPf3IAHEbbnKGK1QCML5oXph+D9v3jvMGQeff2FjfD?=
 =?us-ascii?Q?AqWscSttYXy6XWX8HTKEIv9kQoCjADOrW4DLjBDwVOB59Tc95gj62LP4OthF?=
 =?us-ascii?Q?B9Nfo17JGf8exzuHfrHJGYeK4kGld7BKgaWJIczxE5Zg9O6SNw/esfT4Stzc?=
 =?us-ascii?Q?kTE6KUBtIJi0LH5IHWQ7Kx0pZlYGx9dnGv7xYbsTfoPo2OaJb57WirarGsZv?=
 =?us-ascii?Q?q1ji2mLm9UdmQTu8y+99HmZGKyBnmHxCxOlocddAIe63lnK2+hr2iLrXZ44t?=
 =?us-ascii?Q?2q+aLFKNoZT2tN4ZYOnCHP1KgcgfbFh7o83fPp0JpVMMnnaqF55YbwaGTC15?=
 =?us-ascii?Q?Gxrv/h5Uv9/OknoFbeRCyO41uNZPXv8QxEx+ou43GaUohBECKNPie79qmHPu?=
 =?us-ascii?Q?adyIsR1rNcCqItLavFja422gLM0ntjiv+yldpUTrozUlnqVvSpr7mJYgFPpR?=
 =?us-ascii?Q?8VC9RpKvg7pyfOyza8AgBp/rhrYlC3Wulk0TWRsgIN8kwqhdVtfp8Ze3N9E0?=
 =?us-ascii?Q?ED9c72mkm+N6IPPOLfP7x0412yaQLfpOAgxsehi+0/emvTC49yxLDeUpOgPe?=
 =?us-ascii?Q?lV/7KuNJFzX2jq8rKTrX0xPqqZwpZTVbR/aA6o2IPfXaexeO5f14z2U3QQvd?=
 =?us-ascii?Q?LVfjFbve//kOQjx5MpSOAk6AFIUbBYWNByUUTzX0JrCWV9OlXYUJkjmC43Nr?=
 =?us-ascii?Q?PuawS/qCqPq9cMtGX8rDlQIOnKc4sNDO9RLa8EDaVDss/2VVX0p7MKky9py/?=
 =?us-ascii?Q?P8YxbET9UhP7p5TnizZMEJmVl6w4b8kNyBLci2REVmy+O/6sCjpUHrvyBdft?=
 =?us-ascii?Q?IGQ0yAgn00ixP7qowhvjpZDoOa430dhFOEDVOKxHQMrCv8Fx+lgXz02OwgC5?=
 =?us-ascii?Q?s+CJMH9czOeHSSK+yGKnEkTSGU9lNBNd6rSQtJmACa2sBds0RMNYXb7BYLgG?=
 =?us-ascii?Q?hM3vDevUuhApaUagNL3CU5zZ4aMx4txvRYkmhkKtHaqKDEXZzpu806NM/f5L?=
 =?us-ascii?Q?PghQwG1M3QGgCQ6bpEmUvwHFiNbQ1pSOv4qUXOxeAD5wI9TsoKepR6afvsau?=
 =?us-ascii?Q?IMx2osyM7rXWVm7jzftAwa3f/n/oImpK4S8lllqTWcMIH4AgO487DGN5Z0Sv?=
 =?us-ascii?Q?4hFjFjW+LGNS/QJl/vBFEArh+ka9qwgnWPPbbbvNbA9qo8TJ4aAQKUgHTCfC?=
 =?us-ascii?Q?nyIju+qZtCPoNKnfz3fhIb9im3x9cG8kGg+HkSlix6uPNw+P13cHJjBX7tKh?=
 =?us-ascii?Q?jRZTlaR+6RhzW9EdaH5wioxEi7DTMwmH69Kl+0OgMldugDHXcObL4JHJDiap?=
 =?us-ascii?Q?hQQol6NuzDdsE0nz2zVWlSE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4be7a0-49f2-4415-7c15-08dd615883df
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:55.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0b++PbJxG0/XHHpUssKB1BMVPeUTHnaeJFe2AcUxE3/2RNCwvlfXsj5HZrSiU/BDpeEwTXa+llOu3uyvwpHCRA3BWpJ+uOkS2rURVn6EMH2ZSsb7z6M40FXfqt4vVeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18119

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f07e2b681edd8d8ed25048b958fdcfb55abaf487 upstream.

On the RZ/V2H(P) SoC one can configure the 'input-schmitt-{enable,disable}'=
,
'drive-open-drain' and 'drive-push-pull' of multiplexed pins. Update the
binding documentation to include these properties.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/20241004123658.764557-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 7d7e66eaabf1..1a16fc06c96a 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -119,6 +119,10 @@ additionalProperties:
         bias-disable: true
         bias-pull-down: true
         bias-pull-up: true
+        input-schmitt-enable: true
+        input-schmitt-disable: true
+        drive-open-drain: true
+        drive-push-pull: true
         renesas,output-impedance:
           description:
             Output impedance for pins on the RZ/V2H(P) SoC. The value prov=
ided by this
--=20
2.43.0


