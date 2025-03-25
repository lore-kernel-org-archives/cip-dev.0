Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B5C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 09:02:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.56])
 by mx.groups.io with SMTP id smtpd.web10.61551.1742893367109865487
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 02:02:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bEK/Pd2A;
 spf=pass (domain: siemens.com, ip: 52.101.65.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0VVNPxWPr5OO+V/AcKIMBNo6xcJMuDZDamjkIsz/9tpztQpNEp83V1OB52pxg25PDJ5KQbzk7pJ45pr1YTTl2YXcPq1mCKWdF4aaY5UWjmWkXHzCs45yoYf6IxmnJTplOCpxNurzX3pXg49rFe/5jhOQ3NecaffVuXr7tHwXA2xBq/XQ6VdSxvE7RgDOFGJHdOHvUJiw/UCPmtO+vydZRtZUDug50DtbZ69ojezXxvFRT0iyjgDbxqMdlNTCIVv1F22IzHuXRz6e2ozm6RV9OGvudXr2m2q0pPRA73V2ug72D2ZD3PiT/mNn4m0cHJzvjumUXrJE1RnxUTNQHlkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWzVz+8Ef9kTJiwviWlkcCyIi+fyW9qIuivXy3BlCO0=;
 b=Ja7pYUtyYZOmg+PlVvN8HMK00E0e/Y9Jwp99YbCBa5eXh7MS8VsnS7EAx7c03TPes/5fupdioHy1yb0D4yD6sV3z/jSwYt745EmCLjcgxBhduXdhsGDSoFP/YVygPbGZaNopd37tf6PI7yN5oLddwychl1Vt/RquMIDdb0C6sVQuibiTkeEUoycikQQofp0PhSA6GtTiH1X3wUqHObacTRapPkbkP4ER3shDdEZe713ENkct8LPv1SuaiIIwVuAiHsn7esonTNmRhmOkYd0gJ5sLBggx3X0bAWD8K9zZI9ShDv4bm1owoY3G9JuYRMhMXrHw6sXkp405+U2njDAK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWzVz+8Ef9kTJiwviWlkcCyIi+fyW9qIuivXy3BlCO0=;
 b=bEK/Pd2AItE2c3p2dXq0M463ChMHE8LkVelqtYG/048E6mtwhfFKbJmKAUZa+vwAh/CXoUOY4j42jiRPuoy31T0Yo5cLJKXlffciGZLTlSVELL+/Dj7b4XiRIXd0uwSImfb7iiJ3LY8sNNXnbhkF0Snb++SQtmiQz3BuBDc3ZHc3G2MghBIvSFf4fJmnEVWpWj36+YJ5A+FqFWecaVS7Mvn4RBb+v7iOtHM/aOFeTEtnVHUJ9ImWsonEs0qjbxnyBznSAAlWH63TSSQ+YgW3DzKvTOrVAMbYSaJrYsrb7SxmQQtBF5q0HKBgf01/q+Q2BiudUDMacCXWeQwQxY1J6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:02:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:02:42 +0000
Message-ID: <85fb08ff-11c2-4a9f-868e-88c2454c1b5e@siemens.com>
Date: Tue, 25 Mar 2025 10:02:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] help required to understand isar-cip-core for new
 platform addition
To: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <86937cf5-aa90-4e40-a24d-ab2eae156a3c@email.android.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <86937cf5-aa90-4e40-a24d-ab2eae156a3c@email.android.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 56423199-28cf-4e94-6b95-08dd6b7bccfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VnqyW9qrcsAg2XzwAvok0oxTjVYHAOSZqpI3RYai/0C2HranFLs5bc+BRmrS?=
 =?us-ascii?Q?g+Bol9i/wIWhEgZzLvqHd0tCPYUxJ8DKBbDu0BUlhyrSO4xff+QPa8tdFVYD?=
 =?us-ascii?Q?ufWKQbMeMQc7xMS4wxpwP7JEi4z1wd0hf0kNfnfiWHtuL0wBHgTG05nng4U3?=
 =?us-ascii?Q?illmLSbQ4qBfenwdISdUqvbJt8iHV9AJfyVQVX2nK5gaepq43LvZnKs6dX5w?=
 =?us-ascii?Q?V5XzPJH0vg3v/R22hZ60U4n442+lxviuHYXEB+MlSRqtSToBFqbsudg1sHSJ?=
 =?us-ascii?Q?z+QrDmE4s+OCmaeiiytRR3UojyX1j2/HRHpUdpLZ7+KwVfhkQl3SSW/lUD0H?=
 =?us-ascii?Q?A8yr3wedlARwrOHncbR5U23NdYKIIYytvGUz3wBkFjfgxe+oCjO+EQxnZuZq?=
 =?us-ascii?Q?FPJTZsDjMhQjBp7BrnWU8DbqqxfMJaQTBrVT9YmFwfAEkosFZtqES+bzxKMW?=
 =?us-ascii?Q?4RXx2P+NXJy6sX9RN5AY5l27Icu5aWeGOCIhx0VxrWlYoOAPLrxB2cKEVOXd?=
 =?us-ascii?Q?CSwv6s6kA/BNQ+uYibiHgnwxH0FoTKcsjMYSBKYaR5a7RoUBovJqyuhRAOJc?=
 =?us-ascii?Q?9swCRYrTYGjvwJnSPAwoY+8qDk/UvgD9MFfBB5RcAWDDHElQxM9s8dRigKVB?=
 =?us-ascii?Q?CQVolAQ6KCWGRfQa2FHv+nSiyzGfBDjABfHq9K4U+6scEnE55PRC9O4OCKiy?=
 =?us-ascii?Q?TXK9vmBYd5jvAqXSbF6dEc/kCWDVBwWsIZ4h7jY+HQpEiprz2TuTamNUkngH?=
 =?us-ascii?Q?AdSFdPvx4oD3humBNx1NWGfv1uFsKvBHXwE4lDXyAcDOk7NKI2Hnoh5LZvFc?=
 =?us-ascii?Q?vQSBeyy2C/KB4lOvk8tniVTSIX+rcq4w583x7UgAmJPCyg9AZEb5DAlGJFJd?=
 =?us-ascii?Q?BHI/SUsZJ2+JH0td+SaUT2VXuk2bkDE62F7XCOiScjrLTPcP0AbC6RSN4Nnm?=
 =?us-ascii?Q?7ZkM9hyq4Vw4t8YjlW3h8s+oipUKNILZvfhFB47yUW4abK12XPXsl/QabRJY?=
 =?us-ascii?Q?psBgagZB9Jv+qIuxluL6oH+70q6PkymxU46eEvom820j7OzgHu+tdIvqdnx0?=
 =?us-ascii?Q?NLfFAX16OD0dOEvie3tijBIv8UM3628Vl/1rgPeR8f3HZ2bJfwP76ZoLLoPQ?=
 =?us-ascii?Q?GTWGpn+ewg2P2L6nkK3ABk+XXhAlLYIu3rlinglB/GBh/YxvHl1HGizbfqtl?=
 =?us-ascii?Q?C10DM+vkFlTNk4ulLf5vhZwYv8nbRacJqQOxEtjsJRQeWu4+okjzD+cu6rJ0?=
 =?us-ascii?Q?JqwyG3myJYaC7tEMJwt1vY8G1z1Tm/oUhUQBcQ06xxX53PZrsD3BAYqC32MZ?=
 =?us-ascii?Q?ExRolzklZg5bepxYLhx3c8c01X3fm1q/RygM+xxnNZBt5fE54gjKP+7aK8L1?=
 =?us-ascii?Q?EHCwWp8BloysgPM7kb5WIupLsyFiH7nPoGwBn3UX2zm1axrUxQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JuvauEINN6jPBAC5IyN51VRRVSY+d4hHc3tkYPa5RgLDegQmlUhaDTdYd3q0?=
 =?us-ascii?Q?N4+7XmCNy2jfBfvPRZuvG6blwJL08rZ6vkcBhCKmBS6tFIdxVGeqzooCfkiH?=
 =?us-ascii?Q?YX24Yd8Sk/csbiaf16bScarRtKy8XXPA3IegD56jaLJq63oa/ANxxgsphLw5?=
 =?us-ascii?Q?MgRyRgWO2TNhXN9McZNNkCxBex6tAmfb8Qz6pOalMxyKGhlyjQckwzIv3LLu?=
 =?us-ascii?Q?HGbCwMVwdomghzc0fiU9uMyMih62Dc29dlUfoOUz/XTU3I9DM1yafDgUBPtw?=
 =?us-ascii?Q?E+6c8dS1VPANBeqdjc5S5sjxCFvPvWpdA4va80g8o7XWdfMcUE6bEEnG+AW5?=
 =?us-ascii?Q?UnGx7iYkVSyAYYY3RSH7quNPqWpSCCgGeIBqKpa426xxyUoLQLowmjeoY6LI?=
 =?us-ascii?Q?ze/2Ucs8EI+HkF4UPPoRwkegpmsC+LHzQuyoqSFjS0JHb5VXLEtuPDcr3J1S?=
 =?us-ascii?Q?rkfntgZsfG8wdJcdZUnMWkwELsp/lMHi+nos33Nb+Ff4h5FCiaJswRFvFonB?=
 =?us-ascii?Q?hubu4aOD/lgMSxFr3pQi2NM1bJwAeVwCFy5jivz/jw4fsxj+7bQABQeRCRqC?=
 =?us-ascii?Q?71EZu+TVDI6Q4upFU795+FZM92OufJdKkmOXhRX0f3QfosVfu/OEcPsE7k4b?=
 =?us-ascii?Q?Qt9S0EnSvX38g3o0QAbpekVo5JJQdd8iSeYNThohnLTvCKcb6F9X1SjgpryJ?=
 =?us-ascii?Q?mqmf1coeRiE2KZS0vEW4MKZb2JjfkJCL9vkARfQb+98fsg2LVH6J1cyMoICY?=
 =?us-ascii?Q?JQ2wESAtAneOi5Qhny4SP9Ah5IVW5QgfFB5bIyItEVESkHn58AYYmPmLlJd7?=
 =?us-ascii?Q?1/QCzyYu92Q2Bhb5Jrwgz8w9jG0vWfNxdLG+lfNGeKxgQ1uPn1pIY0kL/C8U?=
 =?us-ascii?Q?GvjDGRWV3pJvUCqlZ+ZOikpxwF2WK8e2xBwAMWBSsHFMm+CL86QnCitxxFWI?=
 =?us-ascii?Q?W7PfK72H9QsD5cmzw1XxICoOh8lfBrUEA0M8bS+xLxz7UJz7R1Kt4AD+9+E4?=
 =?us-ascii?Q?fOV1sxoUy0KmhewqlL3D4buuhqBr3EDefwdyuqinPzm45jemSd1Id/JMbfCB?=
 =?us-ascii?Q?w8SfjQMsyjTShh9EumfqUQ7MVzG0HMeiAxPfDwweh1vwJIxhYWKVoQkPxxdm?=
 =?us-ascii?Q?+7MtB+jYwkvUei7ol3NkcBz3UH98OpD3cBSW61mbFAO99+NLiISxqpw8rZxI?=
 =?us-ascii?Q?QmDBLF4uD6TRTbbqDfs1+3ZfrH1hYJ750D264mOFqGADnnjvTq88CBRA7SpA?=
 =?us-ascii?Q?mrOXVkhkSWPL6GYlBqZfBt9zBVw+mV6IWFKeEUn24JWnLpfqxYoDgrEdc8wn?=
 =?us-ascii?Q?xjRIhrp9auKwDA9RmQAH9x/nYIHLL4UUibhfrlLAyVaCfqAHj3FDp7jJ0AwS?=
 =?us-ascii?Q?SVrKhhtC9YPjq1ASIHPECG2MAJ3YZRLWrky4j0hpFP5aixTDK784CN3Oq3Ej?=
 =?us-ascii?Q?0NsMQ/dpTGNfWbLtB0SnzaqrhFEwhkoemOVn4k92Hg5jUxipRke9mthmnnj0?=
 =?us-ascii?Q?VwCjpY4k/7VZU77DrzUN9PAcaLz4nn5WMr1/UgppYjRAnaQWML+OajCWEQI8?=
 =?us-ascii?Q?pzFv/CEeWbOZ3pIy8CY7c1X9SVtBpIr7Gow1hMY7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56423199-28cf-4e94-6b95-08dd6b7bccfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:02:42.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnOixBe1ClfNrfP/23mBU5IPxizTmJn0PoswSAzA4S9Te9bd/5yhrINp9iVepzrllrlPlQDOcwyU6ZG7RJS9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 09:02:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18348

On 23.03.25 04:36, Adivi, Sai Sree Kartheek wrote:
> Hi All,
>=20
> I'm trying to add support for TI AM62x SK in isar-cip-core.
>=20

You may want to study isar upstream for this, namely the BeaglePlay
support there:

https://github.com/ilbers/isar/blob/master/meta-isar/conf/machine/beaglepla=
y.conf
https://github.com/ilbers/isar/blob/master/meta-isar/scripts/lib/wic/canned=
-wks/beagleplay.wks.in
...

> As a starting point to see how the images are partitioned and
> structured, I've build a 6.1 Bookworm image for BeagleBone Black. I see
> that there is only one ext4 partition which holds the rootfs and there
> is no fat32 partition for the bootloader.=C2=A0

As discussed in the WG meeting, here is the partitioning:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/wic/bbb=
.wks

> I've tried to boot it on BBB and it seems to be starting the U-boot from
> emmc and picking up Filesystem from SD card.
>=20

Boot ordering issue, most likely. Wipe the eMMC or enforce booting from
SD card via the boot button.

Jan

> - Is this the expectation for all platforms?
> - Doesn't the isar-cip-core image package u-boot? Or am I missing some
> config option while building?
> - Also if the u-boot is not supposed to be packaged, why do we have a u-
> boot recipe in isar-cip-core?
>=20
> I would appreciate any insights or guidance from the community. If there
> are relevant references, past discussions, or documentation regarding
> this, please let me know.
>=20
> PS: I've also tried building an image with same configuration for
> hihope-rzg2m and seen similar observations (wic image doesn't have a
> bootloader).
>=20
> Thanks & Regards,
> Sai Sree Kartheek Adivi
>=20
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

