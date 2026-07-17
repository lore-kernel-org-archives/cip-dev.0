Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5981C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:49 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13145.1784294024494283217
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FzAuK1Ti;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNKYHSFm2pjLO+UsbWLvbZCwWLOo52KsetZiTnsYDhqTyCNWZcLe1n1ryvWjZHt1AFiVSe8JJKntFopBUiy7PMN8JsE1kdf+KnpfYI4z1wkjeEplM7Fiv4K15kAhCwbfaUzmHLvSz97r8kZ1d9/HOLxuNk2v+tQZQuXWWEYn8bJcg4CU11eKb7z5QBstz3edKcc81sug2m4g8+pnbm0AfKuS4XWsBalbxs0Xs2zOG8wtaMVXWGU9aA11ZbkIs2/Z7tdViVsOVmrlofWqXDdnhGLKEH9QlyBavqzkg0XdykFSXszAguPQy/t7N2IMlcpiOjTZoQ3ZL+P0VxiFlY7w8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs9VpIrdajbPHfrJ+/k41QZAl1KdL61OEKGQHN8RRIk=;
 b=UXEkrFDRigNMSrPLHasOHLOEYieChrV/Xt9GRfNjvZ5b+AWzcJxXQJYlJREDkGYyqKlu53JOKYZgQkbaxKbENi2Ch3aQl8M1tv11j894u2BMPKmsrvNSotL0jZZ0FstTGRLeUxNDfPHhPXQJpLZ+nmzWwHPqMFgorvTvYo/8QeEQdsTHJ79VomJoMdEh2enYiuntP4hYKIObqjIUTHgSYZCusjrq1YEUDPpy7ISVf7iVUxhSU5brF0CvV+iVPlg9JaYVVbWLwnENzfHseWvLQeskdmH0sl/FZlVLp3F/3VkCid7R1/pmveI7T2OLGP7XNjesCJDWw6zqZ3YrLKWcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs9VpIrdajbPHfrJ+/k41QZAl1KdL61OEKGQHN8RRIk=;
 b=FzAuK1Ti1jz9em8wcO+HLkwohNx5JLzG9Etg5H8SSwjayhEx19RgL7jKWWNj8P+vI/vPP9JPPHbp46Pk7Idn3EnSoSeDs2p7ybRK228cEL9v4g5e0v/X2K27vsYGKZYufLkHgSrD48B9RPgNKQYrDSwIWLJl5wJ6dJe7vAuVFGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:42 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/23] dt-bindings: hwmon: lm75: Add NXP P3T1755
Date: Fri, 17 Jul 2026 15:12:28 +0200
Message-ID: <20260717131241.2233788-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e11a94-4cf7-4a8b-27b1-08dee4053903
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	dub1l2NAVyhLihpy/MbNdLomlLvfUPW/d6iQyuqWyFbpGToQ2uKP6IE2+U9fN9J616tm7ymrrQvNYWiemYc9HTZVObgiquEcPWkahJs21RG/H3Cez2fPFBNFlfhRmweGh+hWVUdcRvWznvOictl4AelPbd4IihDStn9GsDVa3xgcfQsePvyX+B+NbR/375556eX+45rLXF7MsneHDzDnguNJh5DGIbaBVlry87tG5c73UcUn9oR4/3NTxaZnMAwYgOn+WCAvFvJbAr7GvO2hFJXmmXVHrlvS+OhzFQcqFX2merUkQ6t73OLgMqwNiwW7CASjC4ltwy7XbQZSb0SUSi1EsPnx32/+cfVxGv3N+q/UAOlIA/ujyV5J9S2oV+qIj2CI2ZfphhWnv21a72IONunhU3RGy2jRhR0DAKcUq71OmNT41Fyhzy0bo4euINSdlgeS1UPBFcgxqSTiqanaICG8mWKeK2uYWVZjOQqe69gAssLSG0Vh4YlLW1pnA4OeYXwWrT0oJO0SSSVyK+vJD0CYUPsOjVO/DacnmbI8Y6g9t9Mmqzl7pPaNMnjTjI3rPHGhee6/StBLDHUywmPqCjjSGHAtrkn63RzI/gA60BhGMfbzxSl0maReQqaAmUPbjiFETPK7QmfELcJtjzRkhCPexYLUCh2Yas6+MvK/yso5Seo9zSmj35h2WtPkJSI+5UgItFzZM+0b+A//7lOlqN4F+pwToHm3QCMRbzZKsFw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PnP3ntjEFVX9pUr3Jz1WHrQu2z3W/929+ZGzUc7ya6n0S1dkNn7nFxYZtRBv?=
 =?us-ascii?Q?9BAUnZt6+qAXPeem5Hc3NosNhwkDbP/+Z98BuNqKtnmDNfercYMbQaUr586j?=
 =?us-ascii?Q?FzIfLM4FLZ+LKlxAljy1baoVWerYEBmeHzMzGOeWifl0NmDJwR8B+fHVKDVR?=
 =?us-ascii?Q?mJuPg5uiEhsqqHiJP0XYPlNVa8BYPQITUkIcB2BTAUQGo5juWbBuEjF8SINB?=
 =?us-ascii?Q?GHEjvL/lZxIIiK1ymX2LMY8sA57xRa8AVlfHzhZYDTp5pECF8pYwNXloueAZ?=
 =?us-ascii?Q?Yrme1nt1lMf3VhaYqZK3hzjw4sFolwB+BcDlPMCkuvfLVs/B/8wELBBBgRPQ?=
 =?us-ascii?Q?ZReG6P7QLjMjFrGUWoJIv4YqACHEBFmEK/T9ponf1cl0iGTbWxPXbv9EmDUu?=
 =?us-ascii?Q?vsxr2cN30cfZERdl8bE6I3kPbdBTP3ZiqygvF7UHhiXNp0sb1zcHRS5hGN1I?=
 =?us-ascii?Q?SOkJMHOYx5+9/ZU4KrgIJgh0Tip2WYK+Ee8vqXH0QFn4bSVH+o5sFPN0QAry?=
 =?us-ascii?Q?oOjt1KpEA+H+oGRESnEeNeo5PDmgvlAZWDnF/oOO/yllLRSI5HTQHetjLbCL?=
 =?us-ascii?Q?nJESht8xKqASGcRz7cUpfjA5f7DJiu2GDB1+kefQAYlg1tvyMaykZQXFqmPM?=
 =?us-ascii?Q?aiuLg/vlVvPTRaBote407f3BUDtAwgl3mu54PqylHCAHaobaYlAyRxVZX23B?=
 =?us-ascii?Q?AWBuytEm59JHkw5Meoc5WQ9X7T7/pYS2rMTn+GTrewCq3Q5anIdLL9zgCuLi?=
 =?us-ascii?Q?2qNfJ4Cc1bgi8y8CEHcQwYVOVxGLp1ql5ScvzigVfVWzvjZTpAJfy7GPg0bC?=
 =?us-ascii?Q?ng6I3cWjIM20okS2kHJvi0P5jKKlrLmrzAupJ9HDbYfWxxP5h7J8wcBoQT5z?=
 =?us-ascii?Q?uelip7r20UyiRdkPGa6c2aw3qtIq6xFc52sWTicO4gWXZrCNXOZNUjKH7w2w?=
 =?us-ascii?Q?bxwpyPFG+4s1YFLPc5W66pr9Fm2DxrP7xZ7UYhOWgz8RvmtFNj9JN3G/yLiI?=
 =?us-ascii?Q?pagBpkXR1auOUiy/UNQxYo5BlSbp+QBjaTgzS5+ZqCBOY6v3vRvDpB8ru1B4?=
 =?us-ascii?Q?6L/kwGWvVWPjJ8Z1gVRPOxvV+BE3A612KEnLU5f7BwccRuBHyI5uY9GiwKYr?=
 =?us-ascii?Q?wBTqfPPI7Ly9wuFqvw/epNHnop+cIf3BvuqEC4HDxdlV4uHiX/rvFj0ggeTi?=
 =?us-ascii?Q?Pw3gztXucazNq56iZAPOR/xC1v+TYAC96HzAXhf5auFbMjl1zBBo4PtrJhjl?=
 =?us-ascii?Q?S87DZhllG+7d6tiHil6LgMnK741tTw7OtyApsj4JJjS2g/pT7djaa1FbsQNh?=
 =?us-ascii?Q?WwN1mmwdvDJnzAvHPwlgRX1gjFrtDRnpKDL8wdreNAYGQXcKQr/W4uS1d6UK?=
 =?us-ascii?Q?4EPahaGdZF0tsPYkFcElEW4MEV1SUiCvd1IKEIeCMjjbEpbUkKnkh/2yuD8f?=
 =?us-ascii?Q?LqgrqKac+Shbcy8a7jROwxR6YUXFGCGIL4yLJ3c2hihhZqYu2h7r2IY13twp?=
 =?us-ascii?Q?3UfZVqcOOPCj+q0y/Ba4irA6j0haAULLR4kHw0N8A4LR8ElruLw88ywQyLxi?=
 =?us-ascii?Q?m0dVu4jbvwxXLyQkSBuFOar/+ieIKQA+Y5HQiOxFS1qYivBJuxYYGjN0FQtm?=
 =?us-ascii?Q?4RHBFNRC/K2iVW1gQ4cP0x3kK8eAAn8jO55acQVsuH6llqCkL9SXFbs7yRGO?=
 =?us-ascii?Q?NbbYIuT4qZ2ap/fmU/y6o/QwxBF3RLvzaYWDlcy6tFalGhF2uWdpJoiOj6Av?=
 =?us-ascii?Q?y/+ylwBiva3rIqaQqqIyKYNuASA224erGrTVcxw3jzt5BQffzvgn?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e11a94-4cf7-4a8b-27b1-08dee4053903
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:41.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TolvaxuqzlYaqNyFhd7g0elWcf/hy++DP1cY7CS8Bx1Ts61JIXLNz7wlWarDhqoIa9OsfNC04hjrPmHDsga/NfWPbbS487wECtsM5VhjkbPjW3dn6UrvTYZxZ3ovRfbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23638

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 844029c59d44c590871b93fdc9720245a71f63c4 upstream.

Add this LM75 compatible sensor which needs a separate entry because of
its default sampling time and SMBusAlert handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241218074131.4351-6-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 5aefcf8e5ca1..b82ff62e9495 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -28,6 +28,7 @@ properties:
       - maxim,max31725
       - maxim,max31726
       - maxim,mcp980x
+      - nxp,p3t1755
       - nxp,pct2075
       - st,stds75
       - st,stlm75
--=20
2.54.0


