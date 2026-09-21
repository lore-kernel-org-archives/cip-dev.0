Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182BC982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 09:10:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44863.1789981790747172384
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 02:09:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pOpCK/k1;
 spf=pass (domain: siemens.com, ip: 52.101.70.53, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veIWqRdnf6loaEEGOrJxLtQo+BdqsdHFHk6uq8tdLY98X8m1EU5x+xytxJuj+aiVmiztju9Qq/GxYf/ShUmBvx2oTHf0FCLa2nPlFZa0G2UQ/N50bDVA4P9jPMg9pZLOhAE2OOtDZBnffZQhQOizeS4W5+6OFBdLU/0+C4dE4WV96ZpGqhlkxVPmAnbxFutX+7X+F3rKUYuAFq64exPtU1G1YdlB/x2jv9vdTpZupMnkcF6upMDfC3hxcHVbczrLg3NLqocI6DeZBveNFf51caUaT9i85+1oVKWUM4T5+Dc1EDBYetlEX0bijeEYCN27gF+dzWxYN6AAgzqGnpEv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIKyc1TOzHZMQFOKS7OJxGW6XfaZqutA2BT3c39FPpU=;
 b=dLEg4b9eL4PzrF6+Tckfb7e9j7eS16FRHl1LoGX1WeDWvNbC1FM4qaSRZvcAxzCblJb2Eg8tGyU1W8kkbio2jMhFumTD68ifiEIBTj2oN5o3KJC4AmFPGwmz+hZ7hFiw9WZLae6iFSy/PI/RPRn08WjdQ6oz+urSHVBX7+QGjylfSTSwGCnYwGlMeQEls/RbI7xaBrn/1YAlkx3BKs4bO7jM8lc+E4ZgclYpbMyhK7cVzFbz8V5VJZNBZMgYtW2ZwJjZpz/a6Xjs28WBBZ5frKcs4+JYI/1u26+9Fj/5iUpaROI5BlmnANNh5dYbowWJEGWvCtsaCbSRHmsvfEWhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIKyc1TOzHZMQFOKS7OJxGW6XfaZqutA2BT3c39FPpU=;
 b=pOpCK/k1s5USPeY/yOD7CQgIE2Ct2F7u1EkMlSX11RdquW/w89vbGNUluD34vwJ7DALjjG5q22PKGP5f4asZOSsagrlHnSk87bfQf3VEYCrI2av+7d/BGUXGQHXdDMVYySPHHH8Hbg7vOu/QU65QuQ//UUm9qAMf9TVh83LMABv1tyHd3M0u4x13fREAh33V5+WF+cIjiOUxQkW1YVLobraTvlUD33+Wpw7LrDn+rgP0O5h6S4Jq/0sgAtv5/aotnBaBwYaKs3bGr2d9RohRnhYzjeHZtWQnpOsP4NZs8hGcl2ePgtYTXXyg+CyS311zy9vu3mfkhiJyOfKAmN+U+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU4PR10MB9589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:628::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:09:45 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:09:45 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	kazuhiro.hayashi.f74@mail.toshiba,
	kumar.dinesh.h95@mail.toshiba,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2.1 1/1] Fix file timestamps are not reproducible for EFI certificates
Date: Mon, 21 Sep 2026 11:09:31 +0200
Message-ID: <20260921090931.156453-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|DU4PR10MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d162a1a-9d32-4dc7-a870-08df17c013a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|10070799003|1800799024|3023799007|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	c2zD43amxkPt5+9t44FVJxJS2DUKF8WH3X5UvZKgnSTBl3KEqBxlvIyIotweDEv3UUEwqhrttm3JhPAML6xtwdX2E5kkzKJGG3Dl2aS7uGHwY9X/KlEhTCiqGzbymbpUvR9HV+/oy+H+zTlpzPPgxPyIyQS/SghnvgyAonFRxotIjAujFQhfeyAua+DpJlMNgWUP6vfFgqD7Rdz5LHvk8m66CqGOeXrp3BUDdfVaGjCr+4FA1I57NUViQoV/YYa7F/SJobfdiuOV0ZUNOrGLuzHJ3LFcn+D5EAvD/v8pr0nihxBdHqcpuAE4Rw6RGCmMpx+j1w1BM60VV0aJ6cRbUlg0Akl0ZTqAr41dnBYolGWhM+IiOVqvcfpZKfTf86/xlilBk08QdKeKYtTwtE0BjN3LT9mNIxdOj7+ycJLUfsSudP4E7gg54NbkT2R5xDxaznZTHqqcQqnsb4oaEiGqE/FvYD2rna3SlTJ0NpSKWNDu6vEAdvLwAWY4B6hk09zt/XukM21okffmShfVo8RozjRBArfxxj1McqfLl4ZRnjMbAkaAk5Cd2W90Gt2QMU+XDsHwe3bE3tR4g3iLjZFNqCfDKANTGtco8jEsx34iq939re/Zeg92gy82wi2QrXCi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(10070799003)(1800799024)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Tx/hHXo3N7u+GY+kkvCnPFBbEagdCQ3hXaVFOCs/f1CrRkHN3L4IRcu8mtlq?=
 =?us-ascii?Q?FP3knTZyQagc0ZQsjfg9d1QMANcHfTgQIlLXkCasc/RA/ioz9OUpfGmnCeji?=
 =?us-ascii?Q?leCUJSdpt+Xq2gWcIyZN+Az7nbqaBMBpvrVT3PDl5Qc21qK2TJmfucmulDOr?=
 =?us-ascii?Q?JJsvSpTUjwU+wW2bWmCiqVmixF0PDbmHUi/n6+vEYi2eqBd0XH2xGKkAPF2n?=
 =?us-ascii?Q?4YVhBhXICwPBChClDcR4h/ZI5YVSqle82wVFnbyxb/mZTJ3yXrbZ0Pgtg9Sj?=
 =?us-ascii?Q?jGBNpZEr3gdiMQ+HWfh4tKm6hY29WhMn4G2FRXWjcWLdrAVeZIqirRXQto2+?=
 =?us-ascii?Q?kxsjR1ldpWo/dUasJNT8PS1tdOQ9WQVUrPpy4f/8r/cQvozk2eSEO62rfkPL?=
 =?us-ascii?Q?CTRqixB8CFEmN1jWZ7nRZud/hqb38MvUn5W7w1kNKkpOb09m9COCr/YOqL+I?=
 =?us-ascii?Q?qGVfMhbOKNuZBCkeYMHBb0x26t3vL/WsHqKHyQFCI7AizwihdejB6EkYerdL?=
 =?us-ascii?Q?IwuV7a9G0H4SMQeNJA5BFe28QVJ1/RuB20CTf/uDbE6ofWDEjgIUqyQIkakV?=
 =?us-ascii?Q?LEewngf+yTDjvUnHRMlwHYGXdB+sxQ0guToaIiq7QWUwJYgTPwW915IHFtUo?=
 =?us-ascii?Q?NW9B6x8uMIPXbL2v7ydZYYFjti8yb3TDb2WvdmFWJeWz45VTSJGVAcLbv87R?=
 =?us-ascii?Q?3Boy1Hv8oTaEgywjCys4YldHaNNQeRKkPtbKXeXGDA46HYKYiG1FqRYagxoF?=
 =?us-ascii?Q?H6XPdulEYwIFzdBZAM2HS90BxuOMgosJxWKUFkHvUeNAE9HlgKfjqEE4QK6u?=
 =?us-ascii?Q?GekYIEM4sg3KOzmuU4p9ZW/GgPiZG/7THuEXbpx4RgEDwctIDXK6g2J1pvzr?=
 =?us-ascii?Q?tq2kdA4bKS7cqXUlK72AiikWrS4H4R+zhsZ9URoXjGjRu7JzqMokVk6Dzghf?=
 =?us-ascii?Q?dTQcPLJgRnkeelA66qQ8Az9NMKN/8GK6UdjmjYXn/GNoijiINPZvDy5XEjPo?=
 =?us-ascii?Q?/APT16AOwceW8XcmJCp8KqkW+M4u7ARTNiSB041pcThdmJkC/utWyLovxRLi?=
 =?us-ascii?Q?lJIiwUWphZ032tWKJ9b/biNlyOcnr79TncTKkyGIYi6dcSUcEFDYVvJaS+NC?=
 =?us-ascii?Q?UKW1Vwi0rfIbW3Vo6niZuVIstkxEmbiLRRCPGy2Bw8b7XxQDJGXL9R8dxSQC?=
 =?us-ascii?Q?7ZpmHm4I9G+UlSVBZOn9xYnCQnQRA8tuQyGKt8P7N17cfihMaHItOAw6YO43?=
 =?us-ascii?Q?xy+PLxqJUgEmTSQ5mSXPlvI0FkALVCXJS48n2Uyzc2GuwQyKX952uguoLZjl?=
 =?us-ascii?Q?TjgbIXDvj28idu8uSgJMZojJFl9IDUPdupT/DBI431sePcKrAI3fdIKyA74p?=
 =?us-ascii?Q?JXV2RjkbTMw83A7xt5fSxT3YefypAgUPqK2Snn9H98Sh8OeCXdYrK8yLvfXP?=
 =?us-ascii?Q?RM77dOh1K2PMOA1VUxXtSQowCvdsips3YZx7WPSpNVWWd5mMW2qbtJEZc/mb?=
 =?us-ascii?Q?MX1wpTpy2sxPTwk4XeBXUzTJJBak7FuA0Rh4xzuzJjd/Q/VPZ6NdOprxkoe7?=
 =?us-ascii?Q?2+MKG5pmVAbf8ilEt4+4qlTZ1nD8BYmNqChTOFsEx53jv6f8nPUMGIi7Yuj5?=
 =?us-ascii?Q?+lqQftZX1pzQ006b2JWeNYoacl5sNn7r6LvAk38jOhqzLCCYC0iPppCpft+i?=
 =?us-ascii?Q?G6XLZFLpFMrukVg72zPSYSC6TQARluh6Lt9ukPmrHiGBw2mqEOrnSqgRTDvP?=
 =?us-ascii?Q?XnNFIkroF7kYMBjBXDD0LVtzcRrjhR5p90qWsjgyrYCaDNlo8CZYyRuUUxB8?=
X-MS-Exchange-AntiSpam-MessageData-1: h98l626lhXoEhlwU2koPc/kT8qMiNTPjpo4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d162a1a-9d32-4dc7-a870-08df17c013a9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:09:45.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeCvJRVS9wPcpSF+GZeIrJ04mXPj7XGRAbaXvXIP1fzu8VSppVFhxE3AvpBZafj5QCASnd3jQeA4lDZkfHTAbIBRr4pAmnpgJKMUheQd33Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 09:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24256

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/1=
62

[Felix: let dch timestamp depend on SDE, pin timezone to UTC when
signing, pass timestamp in correct format to sign-efi-sig-list, print
bbnote regarding chosen timestamp value]

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs=
_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.=
1.bb
index 263f794..b14d6cc 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -20,9 +20,16 @@ DEBIAN_PROVIDES =3D "secure-boot-efi-certs"
 DEPENDS =3D "secure-boot-secrets"
 DEBIAN_BUILD_DEPENDS .=3D ", secure-boot-secrets, efitools"
=20
+# We need up-to-date timestamps for the cryptographic operations
+# but we must reflect the chosen timestamp in the Debian changelog
+DEBIAN_CHANGELOG_TIMESTAMP ?=3D "${SOURCE_DATE_EPOCH}"
+# sign-efi-sig-list expects "YYYY-MM-DD hh:mm:ss" and interprets it in loc=
al time
+SECURE_BOOT_TIMESTAMP =3D "${@time.strftime('%Y-%m-%d %H:%M:%S', time.gmti=
me(int(d.getVar('DEBIAN_CHANGELOG_TIMESTAMP'))))}"
+
 DPKG_ARCH =3D "all"
=20
 do_prepare_build() {
+    bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing EFI cer=
tificates"
     deb_debianize
=20
     cat <<EOF > ${S}/debian/${BPN}.install
@@ -35,7 +42,7 @@ EOF
=20
 override_dh_auto_build:
 	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.es=
l
-	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
+	TZ=3DUTC sign-efi-sig-list -t '${SECURE_BOOT_TIMESTAMP}' -k /usr/share/se=
cure-boot-secrets/secure-boot.key \
 	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
 	cp PK.auth KEK.auth
 	cp PK.auth db.auth
--=20
2.55.0


