Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6082E77199
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 09:55:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.59])
 by mx.groups.io with SMTP id smtpd.web11.44566.1736416503763871146
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 01:55:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BwENjJTY;
 spf=pass (domain: siemens.com, ip: 40.107.22.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gClysERPd2zQKyS8NH4htK7sMkK4qNhuGJ/nZpxRKahKfoh9Kzp2lmWxplxZI3OhG3wB90RGIlepK/+w6tP65kkFTO1k9Prcz2eODhTCvqE/w6XAtL/og3wS7nsKeraQJJDKCFSZCiXqscmvApMNxM7DQ/LQMeb6XwJ/Wx5S3rdzixKUFlEW32cP/v2TtMNzNnXg5YjKHeog1PrFgK8Cg259KoR/dpU6VRqqZFDTIT90Abav/tLEvEhD7ZhBRyf2gTWPuyIFCJ5M6zLVuJdMV3GiUTGvNqrZYmp80HRg+7tdv5J94uBcYY2RnTJs8Zk+/YZfWEsn4Wtl2H8Uh5vVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtV/xeNRKIHubz63TzNlbruoKM95gF31dfHpahm+KsE=;
 b=fLUSTqdBYDbk7o+6xF0MKi0gyt8fa8bvJMGYB6MMFYK2/HLpCjhscej521tV0VJb71fcBg3SArTJK7j2E/XbV6Sly4fR4mLNcLRvqzzGegZeeT4faZTXT0wsFnrls21BvhW8kQkqsTi7PbhxGqRq0PHz3dsFKg2Lfm2qZ2ATHojs4e4gNDFrExRAV7ucuOJneEPTAj2Wgn5DcnHcZ3ClU1DYTKI3H/Sl1bHaQiIisVyOgzJcDdEjPJsZr35pIdKnFcaNor2DoYCYJExDmpTXBeO0RaryRKkzyX+U1m4fHv21umsREZlVDMQQiKtft4BU9+jU7wk+g3aOMAXhW68ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtV/xeNRKIHubz63TzNlbruoKM95gF31dfHpahm+KsE=;
 b=BwENjJTY3pRNQdWtIn4aPX/vvpEdClHeAf/5ZE7UoZT7w6yqLQSboGDRCWfsOEPIUUE4Oee38PaHmKeXig5MsESi3wte5m6Z5BsFYIRx5NIZKhZx4J4L58gVoI5VnTmWyz10b+icSm51ZAONYhPQkTf6ktpIxfFnNTJ6yx+X2eSoMyk4+SAwenUSFBI+uPT6lzVyapiKOsjs7lkGL7JLyIpek+HsFa2hQ0TpjLaEw0AdAKR8x9C+D/6W0fvwiIBOqzz+O6Xop7vbvjnLxmVrngOQMkUwQUDVOW3RXdtJJRHB/3VU1dl1hP2wC8c6RneV+8Si049optv6NBJOz9CalQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 09:55:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 09:55:00 +0000
Message-ID: <129b362b-f69c-404a-ac9a-a7c1c4f91bc5@siemens.com>
Date: Thu, 9 Jan 2025 10:54:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Fix ordering with
 abroofs hook
Content-Language: en-US
CC: =?UTF-8?Q?P=C3=A9ter_Czegl=C3=A9dy?= <peter.czegledy@evosoft.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 871dc2ef-0e86-4e06-f85d-08dd3093aea0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9ZRLa2XV2PUQDq7SV0j6+f9zyqY4ywYe/TfPxKuefuadlJ/ecw7th/umdbcr?=
 =?us-ascii?Q?n5HcMwRJNTAgnrzG7B9K3zRktLjSBsbfcRzJMb3nKvP4StvWXKY7uGn76lHM?=
 =?us-ascii?Q?sCe7GjQSoyixBvMo01ddiMEhqiH47xfFc+eGWbMRToWxATQXP2mpYaKaWGnx?=
 =?us-ascii?Q?hed3104zjHIBIe1P67P2SDrTKmj62kpakpWtnG1H1Akeo+mOz4SC5T41uJeu?=
 =?us-ascii?Q?ziMxT7VWRqifuhhuhELZxtaTCRHm6c3iWqz4bnOGqqse8bifKzwRUCLida9v?=
 =?us-ascii?Q?i1bOWymXpxSYRpQlY8JG7G0DFvGgKBCVXrf3RzbVZlJV7208iaANR1ZNVpXN?=
 =?us-ascii?Q?dtozUbBB0hZHvx8EHOllAyGLhcMU7+M7gSGeouYNJvTtJS/xQBhnT/3DXI2q?=
 =?us-ascii?Q?UPNHc4NlmrUdFn2PPREe0fAYA4vqg5zDM/YXN0gdUcwRYnlfJ9H3/kVBvxuR?=
 =?us-ascii?Q?XX/O5EneF8b2X8UkN/7zou9s3suGVygIdrl4FnFjM6WXh9lgQGoZ14IoIZdn?=
 =?us-ascii?Q?CAQE75xxIvuHd619/mHNrQAcD9V1K3wglVCqfZFjD5rxVBFHJ5noP50qr9H/?=
 =?us-ascii?Q?R5/mWMNvxNGoIs392wQLyR/kOCQRQCVLX54ER56cGsHbKN2AD194ZET9mHYo?=
 =?us-ascii?Q?Vca9X1sS/PViwn6H/q2J3fHn/NzcOd2kLazpZCKU2xPnbfSpcdJkZ7v6zaFi?=
 =?us-ascii?Q?w9Ls6Yed14RsdQcJHB0/BYzLnUhPXKdLM0mj96aYwNxhTT5RoMs82XAmhUZa?=
 =?us-ascii?Q?AZdlo4tGJVN25GRekpY4yYEu9Obr9uvaP45wqSuDyNfNlcdFHQZ6e+AhA5/K?=
 =?us-ascii?Q?uSUlyP4H9I5oCQjP/Pmp9jKF7wyiezT2mkkz1indpaQN2zzORLngo9OV0/UU?=
 =?us-ascii?Q?yWqnKlixOJHIesMiNR+HChx0xpuqf1T90dZ3kl64QEDftKZxnJWzcI7AF1Dc?=
 =?us-ascii?Q?hvjp39Iy95NyQev0gmrkXKHAzpnR1mSdext+6BhtP8KU4OwU/Q5RFcEePsI+?=
 =?us-ascii?Q?yoFs8IscT9GgRNe2PJip/Rlwpv56QGVcBQgBUKmAud6G9u6lY1xCiPcgtKN0?=
 =?us-ascii?Q?uMMhOl3PglCjD8+jpZWLJMisT9Hy6Nj20wA2jBE2VEmlWo124PBGuU6jtSGZ?=
 =?us-ascii?Q?fRW2yXN2lwXEOSEalHKD+amRBMJUhvxzBuwBz0LlUJ0ZnU0X8+8Xgk5i0Va5?=
 =?us-ascii?Q?jyJxgaP+V2hALqrjiaeX65LUAG9UAAKrX0b6P1H0QGyr4bpMEL5z2S6aet+v?=
 =?us-ascii?Q?PZ6sXvtff85k4amM2DxTmUy14StSiTUN7FC6ZNJQZ/8qVKfN61YzoUU51jnl?=
 =?us-ascii?Q?Kc5lXNACJGcg+SEOYAVxZcsT3D246IIjlfB70mcZ44DQe3CYLhy/YtxX4RNz?=
 =?us-ascii?Q?LLTyec8A5sMLtj4kgbrrLBHl8sCu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tUYhE1Y174CE2nWVeuD5kTBsDKrgFe+/LfqZ9QwJmihh+VkAvQAmVWRI8UHm?=
 =?us-ascii?Q?URh9l1QYLSxdelMdRaVd8hjFR002WDnV+jQpUBa28GDr/jDs/O2w3EhIS5Zx?=
 =?us-ascii?Q?omKVpGwGsi9WFFnI4AuA/Z1YpevxGzy5BEBRWZ67aLAwAvLBtuxd+YplCM+W?=
 =?us-ascii?Q?HGmmnq5KiDFUXFEWnNdevIJe7Erqy4y3r6tSob2moeeLu9W3YIrGGcah5wy3?=
 =?us-ascii?Q?atoyh9sLCLm+JBqnE/dtM9C+gCJPf8aCUVgRHEUc6j0HkStt3RET7EAipFBj?=
 =?us-ascii?Q?pdNCQlr0vBbFk5GqCw/wzqvaVNSHlCZ9tt3GLBny9BDBpoDXmJI7JiI0KdJd?=
 =?us-ascii?Q?peq7BYzkQPTj7XvdM/eLP7jAvg7XqZghZqwTfwoLr7a4EK9PdtXqimuYrBz/?=
 =?us-ascii?Q?Z5togQvZGz2uE3wYeYAu4jgAWnbKnWcoV8OW7h2s0wssBEw8wuFxAeJ0fJmu?=
 =?us-ascii?Q?ipyrcqk/s56OTT/3x94DxlfS2C2Rkb0eY6xLclpzA0ezV+69jeZ7D2IdIlU6?=
 =?us-ascii?Q?cmdoOCPHnjvmCteuE6ZUCDN+EQzT2u/DpKjHSdeP/L8Ihezk3L7DAWjRIuKo?=
 =?us-ascii?Q?3Fc/LNhn88gOVdpT8l8dTy+g66e8lPOxIv0qVuQk+euQWpXgUWPEp5DXakMf?=
 =?us-ascii?Q?ytFNlDj66qK74VnVEOoJbfIu3I+lt/xm1AS3Ok+DIcPqx/z2B9FdLXhEv3s/?=
 =?us-ascii?Q?I4i0wPyZbbbH2UI4aOanxkUipN4W8qMlAK+JwLbypfGPeRiRLd+AwXlu2iFc?=
 =?us-ascii?Q?faLJ8iHNe5QKd52oUTCx7+KNrSDAxdOFiMD5J72kJ7hfA9Gw0GhWIP+09RPQ?=
 =?us-ascii?Q?Gdzg4bItVlW61UwoMg1JHlpTYlq0klmvVqfUqn6hiXu0OoYojToUTJ4TNLz7?=
 =?us-ascii?Q?mS/nEUZulsy6B6eZRjfz/Tsd9xKRRaEgNko1+KZPjvIYXlv+YcGGAKowGFZB?=
 =?us-ascii?Q?DhP7Tk1StWhRnprOLbvIEKefWcN5Pr6sejkbvHTmoGIZZgHK9EPAgUkvSTiM?=
 =?us-ascii?Q?NJwNfi+0lHG97BAMmFOBj9oupjtGsEMSvifIdav1v/ydMRr76DOqADCFTWEz?=
 =?us-ascii?Q?sjlEZs9mvW8ryt2Bo8CuTgQMlh2dBxh8QuJKBW476eS0vzXLYIGTVNi13dPD?=
 =?us-ascii?Q?O2jTquCkh13CpT74JDi9QN6Q+1eCw7jSOEksjbTRzH12ZQsN0wrNKF0eUtb3?=
 =?us-ascii?Q?j9l79nmane5mmmYIUhFaLeiUzVmheWIhb1PRbhM9whZ86EyIvV8sVoimngXK?=
 =?us-ascii?Q?XU+JzxGwzVkfrWyXuuIsnwjwzxCs0bDwEB3DMuWBrnoFuW62T9N5Kla6mlgh?=
 =?us-ascii?Q?b8zN90IzMxsjNVukAuaoXDUSnLLaOJtyNkqP4/bKqt1rjQpL9aijmL3BB/Il?=
 =?us-ascii?Q?XgC0Po/RMdC5zfXWHs4SyinezH4tN1rNFUynlkguUEZQYGBmCcRs74rw1hW7?=
 =?us-ascii?Q?bg3i1zBb4SRgKmYrLvYt4X9x5VG2k3csS+vK441Hh/zKAoS9evAN3m2eiFrV?=
 =?us-ascii?Q?j43LicSdVzXann+S6p87P43BCuMjrggJso0u5waWY3TCXySSMzSv6B7DO+wL?=
 =?us-ascii?Q?694IN3ywveB15+I9+AVj+N2FWH+/VuoXbb7/Ab3JzvIM5zW7BNFNBq3V5DQn?=
 =?us-ascii?Q?9jZtglijP7MQlon36t02JzPfFGZm22EiAauG4jb0Y/pctTlMnmHUIS/rZWIY?=
 =?us-ascii?Q?5lSAdA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871dc2ef-0e86-4e06-f85d-08dd3093aea0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:55:00.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exS4kelmMWnInUT/s8NDoF6g96uq5x+dVPVF6QzFwJA4abU5nUOUHtIPV5BYhbNP2FCJblUjAtGwH2T62LYAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 09:55:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17512

From: Jan Kiszka <jan.kiszka@siemens.com>

When also the rootfs a/b partitions are encrpyted, abrootfs must run
after decrypting them, or it won't find its mounting target.

Closes #121
Reported-by: P=C3=A9ter Czegl=C3=A9dy <peter.czegledy@evosoft.com>
Tested-by: P=C3=A9ter Czegl=C3=A9dy <peter.czegledy@evosoft.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete            | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 834dea22..95d0a5d9 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -12,10 +12,13 @@
 prereqs()
 {
 	# Make sure that this script is run last in local-top
+	# If the abroofs or verity hooks are installed, this script
+	# should still come after them.
 	local req
 	for req in "${0%/*}"/*; do
 		script=3D"${req##*/}"
-		if [ "$script" !=3D "${0##*/}" ]; then
+		if [ "$script" !=3D "${0##*/}" ] &&
+		   [ "$script" !=3D "abrootfs" ] && [ "$script" !=3D "verity" ]; then
 			printf '%s\n' "$script"
 		fi
 	done
--=20
2.43.0

