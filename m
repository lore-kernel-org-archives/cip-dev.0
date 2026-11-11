Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5731.1794388764833846105
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tHSJbqGb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFNeBbZ8VgoCA5adoCwXbY2VJTZPCbmUjkYu4oUliLtq+WyCNRTwnpcmWnqK3lPOrlcb6LbBosXN6zRHkE0byY+fmRiyyEdjYWxXrTyWzY/bUxFqch0VNkdY3Ckbfc756zBoZ8osZjUWLD0VsXjxY7nW8vrkWGEfpsdGIPW+ModsHtPElSRTTjUuezuM53sgJiGeUPmgpRCAIElK4VQS/h2vfA9rwCbmn4d8sAOKSyRmGgMT/82sTc9u9pfkvJn8qZZ/TXyYEg86i7PdiPu/iCwmBTF5YBYdHQx8tx92Y3ffOvjKYWd0xEYAxaB39CVz5ikuhysS3L/ETAMKevpxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lweC9TfhvkZGrT/+EPya/ASoS7JS49pYn7IFLJEJt08=;
 b=wK2bjEZXem/heV309tYg844OliE+j+HA6ZgYuNy7qus1RsjUptP8TA7ELwspKH9Is+w/PyG4QNydoUt8KWDa2tPSgxxV30nq4LgGHokM7Zyj8FSDX5RaCW4pRcBa5oaSv6+cwHDvSCumdoNTk7C4d4xxsLpUib6/ClHlQ47QbCs/UFGTs03GKyvzBQpwW2b1WCizCcUrGwRYk3rfI99BItygbzC0hh88BL5FOIaaPJeBag3Qhdk81HK+7LARbhBFJH4pR7K0Ji+qkZiJ/uu8QLL9XJUsuL8C93VWwLuRgDRJaor9rrXbVCZyL8YfyjLc/Hz8h9Fp2meVsabi0uPnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lweC9TfhvkZGrT/+EPya/ASoS7JS49pYn7IFLJEJt08=;
 b=tHSJbqGbG7LTGQNTRpeRLC0Oe5ZN2HpXabOUUffv5BvfRizHat/ZCb5limd0iB/EWGRNCBMaErtm0GwgjsOnydMh7ecJx70r8q12UumzC9v+fVjNIzG6DxMxyy3gjSq934Rx8WQp+Cy3F+RR1KQ7yN3r3/DTGAeUYMPThvXkkpk=
Received: from TY4P286CA0042.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::12)
 by OS3PR01MB10201.jpnprd01.prod.outlook.com (2603:1096:604:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:16 +0000
Received: from TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::56) by TY4P286CA0042.outlook.office365.com
 (2603:1096:405:2b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4E.mail.protection.outlook.com (10.167.253.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:16 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7600A3001DE8;
	Wed, 11 Nov 2026 18:19:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/21] rtc: rzn1: Fix alarm range check truncation on 32-bit systems
Date: Wed, 11 Nov 2026 09:18:47 +0000
Message-ID: <20261111091901.41995-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4E:EE_|OS3PR01MB10201:EE_
X-MS-Office365-Filtering-Correlation-Id: 56faead6-c6aa-47cf-d5fc-08df3fd4dc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|261021123027099003|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S7eJNagbVB9ehbjTCBvF85amvpVUuaIx4hm8/zwa4s32GGQCsNR+ikmVs2xv/OiOBlsq2rFoxdO1K0hGSMPDFosdKoFI28FLQzFnC0YO21KtDC1LtVdTJoL2cGr2BY4GM7SxiXdsDFJrXzhp5DGpCVYhvfpzFOdW0wkUowOHcVhkFylkZ/NDiyH+kd/NyPhVNixPNVtxq1aiz2Vemjy8MCb4ejuOjupwfaRamuW6lG9rM88M3rNpBA/OG/7hoLTIOtNzM36o4OV5ohs2Uq/umViin8G8kXVMtCZWNWeyLeSZAvwQPjE/Jv4a5A84bEjMTRPqLsttC3uF3vGKMSQOY/eLYc2gbMhm0upK7eu34/MDmbVYWpdXkWr71RIZE8xtFkeKeILz19BxP65B6EBmv87paHqUz3F/o+bJySNGfsSqhnl2ITLaMA+uOc0LAdokAAx/csPZnHf92AjNycO+ZyDqjdB61N/dK6ML34YCDSyGH3cssqbzPtuMFaesrmlUSb7T8n6qASBiFAexE8Vki1XR0jXtjqjIFcHVgotPy+kRUlIxKtIHdGJDO3x4YGA8M69Itf9OAW9FjapqxWMPETKPIif8NA7kdZ9s5rkRrsCzG1RV0TKkQrepYcBLPJqYk3T9rooE3Gv5Gaeu+sDkzWkvm0IKQsmGzZmOJnCa+78=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xve6i9Lql4A8fYrr+HCvGANUNzyiiOaRgMnO2ec02vbcP3Mw6dLw028CN+QPEnpU8iHzmKMXo9H9CHWPDqhx55eQL6lgC07K0pZmJugo8ou//5KC85i+mvInLDrp+9t1U2DwKTyWXeG0Kewq0rgdbUjc2QhWe/54lzMPgKHw7wykYZ94GxT0s8u7xquAnAlWjvM2LtDQSHseTQ19D7jWgeC2OGnsFbkPmfwNxqc79OF8AYqE54ZV4E6TweYJvbNLtwmFDcxL5yOVa8Mv7a71oI36re8/m1b15mshhGqS4WpGuvZSfjLpdUhiAIA3yt77rTYZL7FXzOXpxaC5fCVxslkCOF45e2Psf7CDfY1vIcfVQ+EiJPiZrOjlsUjmNT73XsbIQUUSh1Y7rnp8A9t9d/DrHaIJqGX3TCHZdhy5PtDQZOB3nDSQHe8cRgFbIcOG
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:16.7368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56faead6-c6aa-47cf-d5fc-08df3fd4dc14
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24751
Content-Type: text/plain; charset="utf-8"

commit c3e735e9f62022354fc63dbf193cb5614188a33b upstream.

alarm and farest were declared as unsigned long, but
rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
unsigned long is 32 bits, the assignment silently truncates the upper
32 bits of the timestamp.

Fix by declaring alarm and farest as time64_t and replacing
time_after() with a direct signed comparison, which is correct for
time64_t values that will never realistically overflow.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-6-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 9b624f49f61f0..0407b48af8665 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -268,7 +268,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 {
 	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
 	struct rtc_time *tm =3D &alrm->time, tm_now;
-	unsigned long alarm, farest;
+	time64_t alarm, farest;
 	int ret;
=20
 	ret =3D rzn1_rtc_read_time(dev, &tm_now);
@@ -278,7 +278,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	/* We cannot set alarms more than one week ahead */
 	farest =3D rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
 	alarm =3D rtc_tm_to_time64(tm);
-	if (time_after(alarm, farest))
+	if (alarm > farest)
 		return -ERANGE;
=20
 	/* Disable alarm interrupts before reprogramming the alarm. */
--=20
2.43.0

