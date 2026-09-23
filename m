Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3274C982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 11:32:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4859.1790163139819749837
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 04:32:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pR3k9NB1;
 spf=pass (domain: siemens.com, ip: 40.107.162.30, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8a3j60fJpztAEbkUm1NoIwEcRicMlvyh6XGsvoodLrhU86f016MXLaNuLrYkZq3nhhr9h36aHfUzzO7Tm0HcSGVfXxdnkgkUMCqM8fWgzGJ+ER/tLUiU5TaIMEWpLzSuan46n1jT1UsGX7nBnx6WZb9o5J8XoDLn5qnhH3L5RWGJBsKjT6c15grwHBjZFeDINxtEqC2gjv123fo1/qI25EIVTkjS8UDxktTJXF35RbRXUI0K4vl9kygtYSSEzx9bpxkDYp6KJ0VORrOIT/IdFQK7YdRbyABut1sGKOX2H3qB8tkof8Jmds8FnMXS72rKYCluez8gz843YQF7wVNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVBYTekBbilMHuWUFZDq+E25qFvplkOI1U2NNONbZfI=;
 b=YVeqlTxH2qVlj+LVeC9xmbcAaMGLV8khialKjL39KGS3H50FrXMZ4dKnf5m8CmIddzfPEB+kSFJlbRikk7VMqG8tThwTUi/uUyb1jJ/9E1B79mDEjdm9vW6tykUjBN0WBuSDbBD33J0azPRxIKBZyT4sCQY88H0wG9A/CJXIJxP+K28BBk1qUA6eMOssWY1pdyjyU82AwOU22ovvmPoqMjtKG9+VCPfr7RAqT9CSurwq2WvpQC7XkC8oAezwVPJRYy0WPAU1DAZfJCjTDMkdNqSd4qD26S29OO0iy46KB5uANsh0i0jm9GqkYhBX7slAHO/QAq2ASgveKXcz2GHNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVBYTekBbilMHuWUFZDq+E25qFvplkOI1U2NNONbZfI=;
 b=pR3k9NB1CnPDP6b4SZKWtV1Eq1oKcLJE2+pccyZ4yJM0ggcu7lmt7Auc+5JCrXyFIPtyT2pgQ0Tcs6D3EiHNSj0KKMYjA8g7lz7CspEccgcqw6wVOG9xpiE4VJoJBpJpIYZIk9MFVf6JYboidN3UR6OL/2AG6XqNG3hVmtqL5/jH+zULE2rCa02NhxnmHvnYGSQAs9w8cRfiskmQuwO1f4/z7KfiiK7L5J3j81cZ1NgCk2fkaR1M6AQyLDvHkjmVn6jAtYFI9ZtxbxURwg1UxLcYAuWqWSKNI4MpJaKwfgJCOJa5tYX1gxvlv4rolQStG/rsZuqMbD931vEYHc9y+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 11:32:12 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:32:12 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	kazuhiro.hayashi.f74@mail.toshiba,
	kumar.dinesh.h95@mail.toshiba,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 2/2] Fix file timestamps are not reproducible for EFI certificates
Date: Wed, 23 Sep 2026 13:30:02 +0200
Message-ID: <20260923113003.259191-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923113003.259191-1-felix.moessbauer@siemens.com>
References: <20260923113003.259191-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AM7PR10MB3320:EE_
X-MS-Office365-Filtering-Correlation-Id: b3faddb8-7341-4bd2-1c03-08df19664fd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|55112099003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	AVRPHGu9JfDn5ZMeYw8yT22uR1B5Nq8HRDMYwwnKKMmINZt9Bp+ThGp1DJh6wXSZ2sNtLWmzX8GkaPYhlsvgftuK8W2dx4c245MO/vriJZzSA2SwUQlf+pPs1EPQYP6bkhvRRZCkEJYQX/N8g7+lrQqjVW+bamrLs3aWR4XvXaFLo2qsaPnBoKeuccSeApz2a3Zim8hpzwDLI2nQw0NkPf4XfuILUdQ7mf+incbCJV6YP4KpSiIYN11ro73ED2b8FTHVQWSOmBrZUiKd6Uu13HiJXu7yNe+nLUhFd2S+68GjmVU5X5xnzNzDKDezVVxyffKIz4e72GT8RdP6FDG17WhXpKjjVdQtn1wkmtBhDGBYTbDIqFHiz/v4JCZn5x6ifgrEN/xQXv16RlRQ74o2FhQkt0VwWmlMlk6GA7zrbQox6brzNONpCn0Ss7ahChUNTMU6AcSJzY5sIcNOyT2OGAJQweOHQeGL2GYyXKEwSE+BMQ1/w6Aj/SXN0fEZFaXC+eozIBOo3IOvkglNz487UI4gD34I+UH3s/vGZfZGY9TmchaKHTo+5eiWThqFZJzqIVpYRYDoa9iZysfOU7TsTuQvEJLYQTkP8mASnnfxexQ7jWXdA2+tZkPiP5ApOpcT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ks4/mCNmPS6SiK1iuYlw8SWIc/ScV6N2EIs0di+moTsi94uETQO468ZybDsi?=
 =?us-ascii?Q?WAobc6Is1Q/yvCbIqJiBXmQRaOtsp+zW1LGHz8X0UZJXFYGBbtQdQUXY2rA3?=
 =?us-ascii?Q?RpzuQXrw9gjpThsRk+nAWWjQ/sznG6TzD9FK5B+OTfYDXMN/TLhXhYue8U/Q?=
 =?us-ascii?Q?E0GMXkBG8q8RsI23JKfCnoyJWVpiBS81+DsPODO62NCePvYK+NHytHgFzPtF?=
 =?us-ascii?Q?ZGj7eIk4Mjgp7aa0xWhjFV3tzM6S4pJsRUjXK2K4dTgdQ1nFcc5RnPcAPcd4?=
 =?us-ascii?Q?UcwVunpNFc1d5jEeG1E92M4dKZUos71Ijv1bqBAA+evPTzdPjELMMdjM7REI?=
 =?us-ascii?Q?8r2NGKzGbDP3SY4U6kB8RY2aegiIMgXewEhkuYz3DqawAIRwiIbz4sMSnTtS?=
 =?us-ascii?Q?e4cEA13niJRZxFr6j5/gVqnWqdflz0+jbe6HwEln5WlhJBJPWXcIvaF5hY0d?=
 =?us-ascii?Q?VJv7EA+bOnOI28ZE28fbTxjRZxac668IiGvSYQd+gYMVX88febw3PH3Vsts3?=
 =?us-ascii?Q?7FxKN8wTd0b7MfpHg6vqlfepD6DsHHFra9fgWgS+z0NSo/0dK0EVYAREfYyG?=
 =?us-ascii?Q?NW9Wc31hgHBCIuU75RcOEIlsLVw4xsxbcYL781RBP5gNixj6WORhbf5nfeMD?=
 =?us-ascii?Q?TdfsWnQDtoE0iu/DATsxmFeXiUQZKufZRzcJb0xNnYcpHW7I09FehPXUrPi6?=
 =?us-ascii?Q?V6PqkgkvPzhfOV+9UhqcRiMdY68GOA0ZILbYJTg2Lx33RBVFTtVKz52pwZDR?=
 =?us-ascii?Q?ltidEIiNCqO3b8oEdQ2laVyhH9pUaNbiAdhbFg8O7is5TAQNRAc46g8Nh/jn?=
 =?us-ascii?Q?DAHsr4SFbfqAkl+YTPjEzryUMs7+X0vLpjDwDD8dKBjdmnHQ4qDmqJ98S5Ji?=
 =?us-ascii?Q?QU3FkvSFpwI3Rn/B4sFMvmhzLk/pOYMZPlGvu+mlLrWmbcfapdiUvWvItd3W?=
 =?us-ascii?Q?xYfQNmwb4NFNQiYmpvFnHEHX/L0eMCziprJIhj35rrMb5AGh2szfPFvaOJ8w?=
 =?us-ascii?Q?6CEsWbJIEW5zR5SEMrBN+UXomhpme3elYZmt3DNgfXe0MoZ0BLoudOrms9G/?=
 =?us-ascii?Q?/YelT3YU2I2p0AZ91PzW/JjWpBdwwDewqUyecMXe+i/SK+RsetZO6DlNILql?=
 =?us-ascii?Q?jr+xXP2QBixJHxRlUiqKzocEmjwpvywKcLxu3zZ0zugg54hPezZ5eSby9Tr1?=
 =?us-ascii?Q?Hhh9JaOPuoXktIqqiH13jnY9Gx7jdYC57U21jRExPk0UARi9GhRl8k2eKLjt?=
 =?us-ascii?Q?c7WYdL97d/qC3RCWlGtbQVeTn3gBKSBgmSOS0dPAdgQafyCEI8Ae3dzxUoNj?=
 =?us-ascii?Q?nHW/tr/m7DgnpDEGtY9RO4SsFaDKZWMSTnW9Tgu1U5GeT8NiRJCweWlHhaku?=
 =?us-ascii?Q?1YTVSnixmpgqfYTR4JY/Hse0eKLCvhlC+b6/HqbIr4u/TRu/a2Zgv67oB2yE?=
 =?us-ascii?Q?vmJFSg5lcukoxFivtEyanpbWkKK3q5ocshh0VMN4q5Ot0csZVc64cHYkYeVc?=
 =?us-ascii?Q?Xv5gVdGjNtzVlcpmEsEeFN0VxeEqxUq8hjNBKXXN+RSUe03K5DU11mGN/Hd7?=
 =?us-ascii?Q?AY/pkB9U8Beu7jVjDZc364gAUoxYwktPolbetEr02zBdHhFxR6MZDrcZ76Uv?=
 =?us-ascii?Q?MjWHr3ajXLeeFrHdmN8WluuMhlIkiWZLuFLebJqLJNAvMrHa1KpzVF0iEKcR?=
 =?us-ascii?Q?veUMpY2uO2yydGf/RshvMrz2NoIfYFqmOQ5Wrd5YqNWJMwZ0Sg3NEdR35xCm?=
 =?us-ascii?Q?Vz76bYazCme/d2uhEG1WdXO+Bov5lNQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3faddb8-7341-4bd2-1c03-08df19664fd8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:32:12.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oH5/IJ2iYv9ueMdxlPkY3dALDgtPtnju7X7NaRhFW4RhqVBg4ooKaa7RD7jSyPmFh2eqJ1t/oclyV9JhH07zQH2V0snvusVRf1JuQkEbmCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3320
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 11:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24275

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/1=
62

[Felix: let dch timestamp depend on SDE, pin timezone to UTC when
signing, pass timestamp in correct format to sign-efi-sig-list]

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2.2:

- replace :next commit a7b96bb
- fix double issue of computation and issuing of note

 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs=
_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.=
1.bb
index 263f794..75927ec 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -22,6 +22,8 @@ DEBIAN_BUILD_DEPENDS .=3D ", secure-boot-secrets, efitool=
s"
=20
 DPKG_ARCH =3D "all"
=20
+inherit secure-boot-timestamp
+
 do_prepare_build() {
     deb_debianize
=20
@@ -35,7 +37,7 @@ EOF
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


