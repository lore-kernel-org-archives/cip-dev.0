Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4AC8302F
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 05:53:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.63])
 by mx.groups.io with SMTP id smtpd.web10.3298.1751349213510303195
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 22:53:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FulthVwQ;
 spf=pass (domain: siemens.com, ip: 40.107.130.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQq7Gzyin7exSiQukYvhter9fdtWUaIpJAZC5LEuFNw9o3+51FLRNkUFxLV+SHO5SdHovrTIifzl9FIwWeShGAhe/HTCxliYn02cns/Fky4gXquHrLpJMzbg4d1YhPaHBlDbP2h9kX3UI2ILVB1NO/surm8q+v3KUZOOadP0hmnK621RomWchdxj7/xkbhUMtmh74CuPnCSwFbzjbRFGoWq57rFy6BOskhaFhMAaDWXPdx6Q+IHJAVGXlYfOdrBuavT+USNiD/Sey+Pt9sOk4tqm99ffAC8g00vw6E3VswclVJ7FB7JjIRtRzjZ9wTsNAXL6R+HQX2Vc8bS0ZckcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaKMTY8QE0p+gTueQxpkGpf5cgFYwHGMMfKtR0Uxk+A=;
 b=NyURIf14QzHt50ZXJ5fePHxxuAVFiz6/PsXmRLXWeqylJithG3k038fu9Ssw5cMQCXvtqnEnJmvuBicMYd5INzG0gZzLSPDnilMj8wFdzkQ8w9ovs7ezIANYCil9eJhHu7RIaUGlBwMqvjBdGF4yIWUPBWyliYhJUAodx3/gCEQofv1wacz6A4IVAPqyhIYHZIRNY6+nfdjTvrtnsOnIvclWucypoMKInZPNM91aMGOIRMHgf2wsv9f3ET8VXP7iJYWW/wdeEDUap/8YIX+JnoXFCvHXu86JNFSqAty9uT/wAddAKgx54W507R15pCj+7wI5OsstN1+NsK2ODr/ecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaKMTY8QE0p+gTueQxpkGpf5cgFYwHGMMfKtR0Uxk+A=;
 b=FulthVwQhdZg0vRkOTLwMj9ZY9HdrV3LfJXY3sTgAyv1n7mjQt0O20C5VJbvzyBIqcV3ri1hb3ef9cmNedmMH2+67QAD2YjyGhu5xW0q+h4/OCx95/RA9mDwGu6Mz+63lPRr+3z6gDnTjq6gTzSuh6DnYPIQd9mI1S7rymtVciVkCSAXQDDx1Ss+isHaDHvhhrGg4KmT2ltXhROaMhqtClLECPTicejyMxT7u9Cuf2N2e5nMOSWcEpSIsF4Ztle4LJ1WS630V1VGfOO5aMmGtZdP3HRxrpSjxwUDkS9fQcpK0wazqPhAGiNBYAkugfjiaf/T7jQWHg5XeTebukxMLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 05:53:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 05:53:29 +0000
Message-ID: <bef75fb8-bc9a-479f-88a1-9a8b2ef2175e@siemens.com>
Date: Tue, 1 Jul 2025 07:53:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-overlay-hook: Add support for
 handling links as lower dirs
Content-Language: en-US
CC: =?UTF-8?Q?Enes_=C3=87olpan?= <enes.colpan@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dc5502-f70e-4c6b-ef5d-08ddb8639ace
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gxjbEi0MCsvH8GapBS3AeHFsTHPm6fslPoMp8/evlacn5rsjir7N2WGQdB41?=
 =?us-ascii?Q?sbgeOp9t37dg2SsgGchWdwbs4HfLriyT9LjJpzaXswxJp0b8TSpQJ6RHitPy?=
 =?us-ascii?Q?OB7FD8acFbY6XZQX2depe89TILvMaaqEenlnLCNu32fd3Iurn8NarSjRx35o?=
 =?us-ascii?Q?lZ3eBB+M3TJ9HP3rJ+rF5ts7udgLD2Z+/1LlN4heFQM7dP3hbGDdsnLwLpzm?=
 =?us-ascii?Q?1ExnRirWyRpaG2UoURBEDh8o90Ng/yrcT8nBzhWogReW7uhj9aFjCyB2/jK5?=
 =?us-ascii?Q?BX3VfK0iAxtXXcIsIftrUfRCEBVK/j2iiPFyo6oa5tzyTCrX9m8g5kRWDIO9?=
 =?us-ascii?Q?78bdzv/ifzWxPbbjohN6Hrux8KgL12Zvhe1L30UurqtwISgBh5vxWR5VB+kD?=
 =?us-ascii?Q?PPcIxNGRpVUcwiXbrahUL853rpg2zsx1hSibyfUt95YOb8qBLgJaz319Xh7y?=
 =?us-ascii?Q?fhA65FGaPe1q2Cc/8U3KYU9vMu4n95CggnQzYf3qCYRSEc3OZBVrv5DtZ9QE?=
 =?us-ascii?Q?l2njBtNUlIJ2eshZ/7L+LIfFhyrrLxAYTS0j8aOHgZR1eiYgzt929H4oV+cl?=
 =?us-ascii?Q?ZRi90MlEJkwe83viNJpaVRcpWSqq85eBU2nhq780VB+sGaxxd9W/I7dPE61v?=
 =?us-ascii?Q?paPttcpe3FdsriQpOfRokjFOu27ZoPjuH5cr6qAGYUitWNHQ59xm5adcJePo?=
 =?us-ascii?Q?khj7MFxhclxHzrx1K198skbos6Y2XWAXTgTHpalL/qza9lVYXNod2EoQ8C6S?=
 =?us-ascii?Q?Y4T9oS7IES1AgxANd0ybPwAbCHgtCVaouU3t491tqk5n3LIwIlxLcHV13svo?=
 =?us-ascii?Q?6NZHvKW6z/E4KAJkItpxg/D7FH54chBALHVsWEQXnnSkDtdu1iwwA2X2cpDQ?=
 =?us-ascii?Q?zYzTmTr+WG5U3gf4ta/lOa1EBdfevrmWWz/3DFJvxPgauJchnFA4vd4Zt7+5?=
 =?us-ascii?Q?P4E4YK6e9yprzS249Y8v5gZLkOr1wCFWR3Lp4HhhwcM2vCf548loWpGEs6xH?=
 =?us-ascii?Q?b4w9LiXRiF/13k/XruJgwBMughx5r5tDKRNYGJUtutmsKmI6cQeabCCjd9qt?=
 =?us-ascii?Q?+ACXBlBqD7L3Ya/+UsY9ZZZ5U/V385qec4UtJcnjN8AlfsMJD0wXz8UeLgTv?=
 =?us-ascii?Q?R4illjRMKF8nmtfO8PCWYxoyePaqd/iMVvYAR1F+AVbFPpCqVJD9QjLc6Cnf?=
 =?us-ascii?Q?XLATU2xuTsqG/hYEzr8jOVDJyw4qhpeakJGiKmCei88wvyqFjz75nCOmfcF2?=
 =?us-ascii?Q?XNmWBhKp410kkpMRBV+JuW4Mbitwb86LYNnpucT5IysXgtM0f+JCEtKciFgx?=
 =?us-ascii?Q?HJqO8x85CFUJ6HfFnH3XvDl3pXAGbzFbqwzAoEZjer9IuP2rNWUZLBv8FqmZ?=
 =?us-ascii?Q?eW7uz+uW8VsNQE9Zp6uPI5DX+8SXRsUX85JYRWTO/3Uod+QuWAJ+Oy2B2lTC?=
 =?us-ascii?Q?cRjInIK1Phk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rHQcRTG6cQKW1Zz9pYk5zdp9AhBkebI6LfjlGgQQg/0FKrw60nkpJxr3DnRx?=
 =?us-ascii?Q?RB8oTZ45Uoz8eLKMYO+W1YK2dXD4IEIQfQrKHaltxEc7+U105L7rshU0HCDc?=
 =?us-ascii?Q?WDplYOmICMpyBiYsttc4EdbGQA7y39Q/uw/61DzH3Ip68ecG4GMX+Fuaj5iy?=
 =?us-ascii?Q?UJZREnK7IhS3W3FI4K6PKYFPgHZ+fwsBvpte2rmS7JImImBTagNKZ1B8gStu?=
 =?us-ascii?Q?IcBFB35qo4OX0GQdW+DOfPYktlYVM8D2eyebSMIX6rsjifpJ0BIzWWdFH1Hg?=
 =?us-ascii?Q?L4bl2Ub9VTGQ5eNd4RwApVxfysTkLa94NP/eXy/5MBjg2LYBYVQ5b707o9gf?=
 =?us-ascii?Q?Qa3+8WgQA9kbycYlHXxTYEoPRTym6ZfbSvGfaQaEORKeOE3isRqVylgHfAR1?=
 =?us-ascii?Q?wOVFzZO4pel002Czr78S40lasbAlqYZM1W2lZ56oV1/NheEAxyUzIswP1QYk?=
 =?us-ascii?Q?DF4aID+boFH2l/cpGgPSu/S/Lq3AK72Oo2uvY5mzC76M9EywtGKe/4h8m7KP?=
 =?us-ascii?Q?uXvWDBequ8MX8BZSm1XmcL1LwG6DDqvMpLhJ0uW8dhc4xh50uzez55v6XwF9?=
 =?us-ascii?Q?ba21E0FAeaIXAOkPgqWfJwMB+Ywvt9TO7t+EOAHEcXrNsA7X9FFwVOcafDQ+?=
 =?us-ascii?Q?zk+1Q+/EO/SC9hJhXAHXHERtM3KrIZhk9GL1fX4GxEqDrqGdEBEP45ZwLWbH?=
 =?us-ascii?Q?IfwkI2tHsxs+GVR4Hj1eUEdZYs/0qIQ/lla4ScdXRnJz6OZcEUr8AUi4SYnG?=
 =?us-ascii?Q?6sxOWZvLvhGrVnZs5KCBBPLfE+DjlDxPTJZtIqhgCpJHV6uqws8ZsZY5FB9k?=
 =?us-ascii?Q?hmOvO5J7HmvgM0dkJqLEKmu2Kv0hUJteWSaPlmceneAILni31K5OtxnwnHmk?=
 =?us-ascii?Q?HY7TTwxxq4n4st6Z9KjzrtGrA+OJOUErWJs82NB71lH4ceHi+evE1RVX7HXA?=
 =?us-ascii?Q?MGPNR983X5q/soCnqIbsasIrD0DXTb/sPYdHZtc6pMlkRhbSZQashcF8G0Lz?=
 =?us-ascii?Q?WPgAxaHk4vomwx9pKqHlrxzsbqQ0xGOQJzFVnHAG/x2rDyexhVyrdZ7y6l/C?=
 =?us-ascii?Q?wkwjqEyTo+lrEnijcqIsHHK5rEHuq0ds8Ftj1nhVjdBZx88iVVg2Jjlg3Dz5?=
 =?us-ascii?Q?OPfgBoT2s5mqgTmDwpH3vgfitfMjmjibzpmcQ1/UEAJGGJCl6FbJaYuirzvR?=
 =?us-ascii?Q?KK4OLXwS3uWRVJcUl8BnWYnPelzhw9BRUEc/7V2s32i+wByym0zqi+0RRN2U?=
 =?us-ascii?Q?3S8IHRn/Ei8PJEsqOmzwnbqBbwlY2HFJH9AQOCNLA5r+tRmMqZb5J6jAxaRY?=
 =?us-ascii?Q?gRvNCO8wg61IyOp7LB9HcndmdgLL+U5XNlrhAXbKtKQIF7aZ4MR499cKddva?=
 =?us-ascii?Q?TBj1VTvKGPdwGPwdzEcH3rsNXrKoaxLqCXAvzbK7cDBMlelGO4XVf8zb4Fc7?=
 =?us-ascii?Q?h1y+g6NKRlaZboFaTIlsa/nC8cv/ViaYVKmxktf54islunC2u8BeQtwMjzcI?=
 =?us-ascii?Q?tZUqsKmoUuidps3Jd87uLcgkTBlwiXqkKefIMb3INK8npC9IdRbi4NF5uNGD?=
 =?us-ascii?Q?wiIXsAI6526BZJZk+KYfnCzEyCRVMEwLc4mYyBHXv0Pnf/124KFxtk5T5r4q?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dc5502-f70e-4c6b-ef5d-08ddb8639ace
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:53:29.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIVlEMVcizhg68XbM8BbYt1ukcVia8GmscKo6SeKnCYIx3+LlOya0f3/F3dBrpWXYDRMnBRs4TCiNZMxYjelcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8455
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Jul 2025 05:53:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19268

From: Jan Kiszka <jan.kiszka@siemens.com>

If the specified directory that should be overlayed is an absolute link,
e.g. /root -> /home/root, mount it fails as we try to find it inside the
initramfs rootfs, not upcoming one. Address that be resolving the link
relative to rootmnt first.

Reported-by: Enes =C3=87olpan <enes.colpan@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/files/local-bottom.tmpl              | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tm=
pl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 71cc63c5..bc5f0ea3 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -47,7 +47,7 @@ for ovl_lower_dir in ${ovl_lower_dirs}; do
 	work_dir_name=3D$(awk -v var=3D$ovl_lower_dir \
 		'BEGIN{subvar=3Dsubstr(var,2);gsub("/","_",subvar);print subvar}')
=20
-	lower_dir=3D${rootmnt}${ovl_lower_dir}
+	lower_dir=3D${rootmnt}/$(realpath --relative-base "${rootmnt}" "${rootmnt=
}${ovl_lower_dir}")
 	upper_dir=3D${root_mount_storage}${ovl_lower_dir}
 	work_dir=3D${root_mount_storage}/.${work_dir_name}-atomic
=20
--=20
2.43.0

