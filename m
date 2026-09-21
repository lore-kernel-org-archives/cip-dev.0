Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31DC982DA
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 05:25:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43073.1789968341555253896
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Sep 2026 22:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Bvw3Zwai;
 spf=pass (domain: siemens.com, ip: 52.101.72.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqLZha15Gi0zJ9tlv4qHRq4xgKNFZm0gZ/80mX73rWQXni6jHiX7bPsDaQ3XBwWygo6b9qIG0Wt27mvDMMLsFRFTwvsNjw10UT7oRkRggt2k8dutlEnZLEHJ7G79IbgExDjcFGUI+bWFUVh1UjphX++jHDBs771xh+4ph90WguOVeMDO2V3S3R6aVGqYxjDb7I1zEJLMyOY7aSnXPuiib8q0HCfx4H2nqwBcqXhQtoppf6uPWMh7nCp9HX1S3dqk+YucwMO0Wdk4FJAFJh2nOb1wIGU57A75x0brSDp/zeYfKgNPgc9n+LCW9F5BAayUDZIFG32wIqebumBHHl5VNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJOoe3h070ZdWKCfwfIhmh9OqgXA/LZW3EU3jECCaDA=;
 b=R01njytVMDTRVAzxUcFLpUIwM8aJ1L03VdK34BoYn/yZ5iVPnFR0vKMrRvJEj3WtVbvRDh7rvD/aSW/hp9URXswS5gZbVAW9u3FY1l3c2yKgiXShY/cpY4MDISup1jpBKHu6pg+hK8LxWHJM4gixjpviZr57ode2dSRDE3c/6jIvNeZNjR9U/EEv5f7sJD57R1tYdntLIA5ZfuJu9oMSoEkhqa5dk4gCI++6C2zlhITO1WbW+abED+4SvK9wt1g6g+daKskFfyKCcyF+k5dZcf+Iq+2SzA8vyuqD0er6vBXi2CVpHimN3vc/R+Kd/SWDbq6QYJk9VOJsqPynLTBedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJOoe3h070ZdWKCfwfIhmh9OqgXA/LZW3EU3jECCaDA=;
 b=Bvw3ZwaiPIEBmLPQCbsQ3KwlUzwqY/tWi9/A0JlMmMh1Ax6hF67btIPGRMwQ2N2o+zIr1v0N1hvIZIMxq2krEzXvC8fyNnfrFGq87pltecVUi8XQZEN4OtohElPvAsC4U4EDsM2LfmRcWn4JoeQEV4hlN2wBJ52C/7aZyHPh5NJMzGQQ9zsliV7Wv970oukTWDPEwMd8vTLHXnMgyuQNTj3+ghtGRWCfEl1s/6MNHlqiXo92xzc8LprUfEMjqoP7SbTZ/S/wDZCvlhFCl/eldg0qDKAH6P6bpiruzwCfkq3NJc3QIM6X5kGKgMCNsdABQQtbEwBDYskb8E9bIkKtJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:25:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:25:37 +0000
Message-ID: <28467eec-7feb-4bb0-8c2f-a73ca9c4b6f7@siemens.com>
Date: Mon, 21 Sep 2026 07:25:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add SECURITY.md
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
CC: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 Dinesh Kumar <kumar.dinesh.h95@mail.toshiba>
References: <7c5a1901-7536-435c-aecb-bfdf3a8a9d6f@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7c5a1901-7536-435c-aecb-bfdf3a8a9d6f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 719c590c-a769-4586-5405-08df17a0c481
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|3023799007|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	kDGphHxUMXo3PAsNzFLKXTAtTaI0N3lO13RpX8VYNDx0vJuth5qr6wtNWDW+MgixmlPA4Kerc1FgwtrqLWo/gg5yRt1OZa0J26CE5zd7c0yc04Ii0JYzodLesegBSQhrgU8Fs94UQ1zEFl2ndLsZGwUeaDjOyyYGC1UYwHyaNIFq0WlPs9bUNjdP1nt8dpJrfubGj1lYukeUuZ2SusmHjDjYflVLhtZGZ3hlfRI/esZB9sAf1OWAXQ8EFKmdRQxWqMSfKdY20cGM9heMekgjoa4NE61D/e+U+V5/Itf5k1dUQRYvoFb73jTPewPSYhq3xvmgxpCsdBWTlcEIBM+LCgxdZ+/bYJId3IOEtjehj0GX9BiqhBm3YrXje5idFG4/hn5X+XlCKVbYLrrpo+MQn5NtwmtJkA9vRP1xNwyJjDADHHsxJatTPYPBdeRR8tuBkKrDjnoy5JDM5sf518ttEID1zYP/KLTaE7WXefAT2l5fWWbPoDtpM0x15UzyItCkaoOPNrWac88cXaE7UJCD9Is+GzOu2BFkfgAr5WNz1GdM+nl1OnXc37QLh9zeXa2WwhydF8iD4r2exWToeTFX3ToJi/szBx///pDjs141mo5HH0E1H1tEFVE+xLQplecc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2ihsQlpBXSmpdW0ua8FVFmjTpON0irMzHW2NA5zK+5aeeq47YypOjGyD0ttN?=
 =?us-ascii?Q?8RVP8hVmrj48ZAzw6uGzINPkAVWSjEwh6YIF1QgYCd15ex1k7cIEA09gPGoh?=
 =?us-ascii?Q?GW5vUmFdnx5N56YP+fgdtpYU6K3bD54+RiQV76Nk2Gx4K6BmAdDHLegKgXdh?=
 =?us-ascii?Q?uvH5g9cFvdgu1LDFh4WNBa8gvowHENn5g8WBn+dP5A0Gv4voxLHOQ0mTQG0C?=
 =?us-ascii?Q?OxZoSMVxvotZVaSWQAd4F5F/DMK4yZFd5TY/jWhFWQa65FqRJQwFpbU3Pu3O?=
 =?us-ascii?Q?82V/tYfS8N5Ng5Z0hq5T1UDka2TNBC0POGndsWVomykWOtlAmmWcYOr1ThhF?=
 =?us-ascii?Q?FuKZJHTdTmpQx/hoTBxkNsj5sobd6MiOeJXmVNTQAum2h0QHXmzN6KHBjBQV?=
 =?us-ascii?Q?NngYxsOrsABTChKXhbCiBSnzsjKSBUXdqbOwT6rB6gRpZH6XhRrdh2vX+EeR?=
 =?us-ascii?Q?sABcT+8wbOoz0tBIIP9fe6h8hh+11K+XEpWXlgL4OZ3fz5vE8AD535t4UM6q?=
 =?us-ascii?Q?OeUldwi02KmbGRrGCp5J4mrHA6wXUgwyBkD13TN9SUxnyb678n3DPcVB6My1?=
 =?us-ascii?Q?o4do4fPwoUD6s2t2nSPmOaC+tETAjzCafKOZ++vydjEIm2I/PwD685/mmI29?=
 =?us-ascii?Q?ZTF/IxIOKs5/i68JBqrUYE//FLkz5zQ8K41OHtiTiRbwtZmdXOb/9P32aGho?=
 =?us-ascii?Q?tK2Y56tWYfo5G5eNx94pxcKTxYVW5Yc9oRg4CEBdTX4eXrPghjT3IUCPu2iC?=
 =?us-ascii?Q?DbwogZSMtEzFkGrmb1Ay9volBKYUTswUZFwLzHu/3KM97ONfoNsdyVnK45qE?=
 =?us-ascii?Q?yzXmL/15RSV4VwzNhBfkgwZ+T14crC+t6zrEhPT2MPCFH/chhdO2QUM09z4c?=
 =?us-ascii?Q?qxPqI3GcxnTSG6v2ZHIhtiu70J4q83PVbuP6CTs3xdCqwf32yciM2rRHF0MX?=
 =?us-ascii?Q?Ri4IvIRTSi81SUp51j1q4rONuwi6ZHbS9qflDPpGA62qPpA5ZJx52l3F+tQY?=
 =?us-ascii?Q?yh6mcdGYxnbkJoCgBujp5dJIG+QYGm35vKr5CE6a557xGFd4VpENn8C5Q3RE?=
 =?us-ascii?Q?NUrvp7tmRTcQWNDMaVBdg3kUxEM+vRNZxJ03axFipwjmvtPiVSlDO/41g11j?=
 =?us-ascii?Q?X0ipBzTurEyrnFbKWgOkqf/oE5W+lydEBufRm6NV0og2qmEBWo+abqV4zKuu?=
 =?us-ascii?Q?DoIMNDMPZRZ9uGkAjbk/XnZngdOypAToLKI+2MTvdhudX+cl1/Mt8+VnjXAd?=
 =?us-ascii?Q?oe6SOZXJHPTD34b4PTZHqhDHn4TUOia7VucyWD/22zZE/KD6IFdwGHtP9Xhk?=
 =?us-ascii?Q?SsLAvlNAPkRC31AE3GIzTt4OGu1Xo5vlcwkN+/Wnjp1vlx4uClT5tw0uo3vZ?=
 =?us-ascii?Q?3ua9ac35DU+kJBLSgB/NcQxQh4O/B3mnwFUv3e0mPw9ovWxeO7WF86zCaKgQ?=
 =?us-ascii?Q?J9ycVtrMJzyHBPxt4ZIiA4CM8P/CN6CGic39o3z5ptnsxePzNOJaAKZ7Z0bQ?=
 =?us-ascii?Q?kNkaR2raMItMRHMuubXjtl0WZeJpn1y1ROSw9E4wnQAQKpcsJ0L9DpPc+7MN?=
 =?us-ascii?Q?kWIIEyfwxUj0AuppGuzr19yZ8co/nQ28F61wAXGNHxxFD3/xvBy//f/qOCPF?=
 =?us-ascii?Q?Upznqj9daJnQH3Qd0OpXeueXazgZKWrPL3h4+5s/GCgUTqtxKKSny7tY5ESK?=
 =?us-ascii?Q?xx0sSzwfMXNX1777s3xnAMQRYmyRUpQIQgir3Q643cv4/Ywe2gvGfK6zoQdu?=
 =?us-ascii?Q?o+8DHgwHmw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719c590c-a769-4586-5405-08df17a0c481
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:25:37.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ntMIf108k6PPGePmB0v+Rx2914yKtp3Zm3YRqhvwNsRUim1PYgi4M8Zt8Hkw0Th6LI630A2Ds5LKBcjGxSQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 05:25:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24248

On 14.09.26 10:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This documents that isar-cip-core falls under the LF CRA stewardship
> framework, describes what we consider in scope for vulnerability reports
> and defines the reporting channel via the CIP security mailing list.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> We will need something for the kernel as well, and also for other CIP=20
> components. This is just a start and, if it makes sense for all, can act=
=20
> as a template.
>=20
>  SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 SECURITY.md
>=20
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 00000000..664a303f
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,37 @@
> +# Security Policy
> +
> +This project is supported under the Linux Foundation CRA stewardship fra=
mework,
> +as described at https://www.linuxfoundation.org/security. Security
> +vulnerabilities should be reported through the mechanisms described belo=
w,
> +which we will coordinate with our CRA steward. For actively exploited
> +vulnerabilities and severe incidents that may require CRA escalation, pl=
ease
> +use the project=E2=80=99s emergency security reporting mechanisms as app=
ropriate.
> +
> +## Security Context
> +
> +Open source software can be used in various contexts that may go far bey=
ond
> +what it was originally designed and also secured for. Therefore, we desc=
ribe
> +here how isar-cip-core is expected to be used in security-sensitive scen=
arios.
> +
> +This project provides building blocks and reference configurations to cr=
eate
> +secured systems that support secure updates. Demonstration images that c=
an be
> +created from it may use publicly known keys or contain debugging feature=
s not
> +intended for production use. It is the responsibility of the final integ=
rator
> +of this project to use appropriate keys and harden the system integratio=
n. This
> +includes the choice of secured Debian package versions.
> +
> +In scope for vulnerability reports against this project are flaws in new=
 or
> +customized packages provided here which contribute to the security of a =
final
> +system. Furthermore in scope are noteworthy documentation deficits regar=
ding
> +how to achieve secure usage of these packages.
> +
> +## Reporting a Vulnerability
> +
> +Please DO NOT report any potential security vulnerability via a public c=
hannel
> +(mailing list, gitlab issue etc.). Instead, contact the CIP security tea=
m via
> +security@cip-project.org via email. Please provide a detailed descriptio=
n of
> +the issue, the steps to reproduce it, the affected versions and, if alre=
ady
> +available, a proposal for a fix. You should receive a response within 5 =
working
> +days. If the issue is confirmed as a vulnerability by us, we will reques=
t a
> +CVE, publish the fix and give credits for your report if desired. This p=
roject
> +follows a 90 day disclosure timeline.

Gentle reminder to provide feedback on this. We are getting closer to
the next release, and this will have to carry a security policy.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

