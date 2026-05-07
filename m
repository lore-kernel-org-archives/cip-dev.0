Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A788CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:04:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14319.1778166266508354429
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 08:04:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=W6LqIPhK;
 spf=pass (domain: siemens.com, ip: 52.101.70.43, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePt52HF5L34QRNgYwbqSOKjPEcQLfnYGJHZD/RmvC104XqS3pqik6Hw7TYLmiKBXFaO89KI4k8CFJI5/zcJqHpUU3BDY8W4OMjWoJl/Cce9CSC/0Q3uJpozem7yob57lQcsnznbU6IgBKDod2s36Q7MYiHG3cfciUtiOmhIOYbFKnQH4AYosz5nwLusibrzwpPHVT/BU7wkk9S9D+BAFyVTSgd/qfeA8p9qWxoVg59Wv6H2ZKzAaGIQQPeknc/Un8YYUHjQiDNIceIgwaQtIUsJBhLgvJzWQb+3F3vm8eIRVQldmU1Udij3tapGf4gNJm5T6HdYoW52Pi7Sj5Oq3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TlQXEAUiYhOypXN3PXP6kRrYmp0xpXXN7P6uV7AeWQ=;
 b=JhM5EwTCwNJdx63mPw6IKIo/FzxLeZxuK7MgH3NlZUdYbJYlBBBWhDfSjdPJTKRi5xIyUsmXKk+BZF8NWbu1e6ifTxwTulGaHE6GAKT83oz2Xxq36U+bYBIjYlUoaHlzcBsZtAVJl/QATWZlsSDHQmo3waNwcCbuyUuamaqTEb7g6eHQQKNCpRz8Ntzfm5mNxuv/32LriPViPdxz3MAYLf2snSvfyE/kxjK8iGfh7rQmKMu6XilW2SIWYMKEBUiHpAeXZANCJtgm3K/1Eg6OheDjXSTxnz0FSID/xAGMhuvQXESE2p6LQKQsFCDZ1/ZYHMC9zH9xrgUasxE44FoAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TlQXEAUiYhOypXN3PXP6kRrYmp0xpXXN7P6uV7AeWQ=;
 b=W6LqIPhKX+g3G5FeMAYDHpcw/qp6aq1rS8RnxSjtzguSiiOFzmwlCdl6kfQUvH9ffybh/lSJcT8Y/2sR3Fgag67nkLDbt17JpROTDOytm6KZDyY8iyrNTUxkWRwzn624qKLzBNR7VQ/cQtkKkJt2XdVCQGP13PoShZmFCoaYWNoTo9A5h+xW3IgLZF+PCXglFeRg5EZTu8E7KsqclG6ZIxYdSl+6KzWMpJ1WGqD1opO7kdlsXpeIc4AhFc9+SQtDTKJzuE4CPJv4YDshO0du0atqz72rgML8ehnT+rhCbQ7Om/l+4GBHxI4hhmutWYk3gJoFCu/JbFvZW5X5CO5rsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:110::12)
 by DB4PR10MB7446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:04:23 +0000
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599]) by AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 15:04:22 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] chore: drop btrfs support from expand-on-first-boot
Date: Thu,  7 May 2026 17:04:15 +0200
Message-ID: <20260507150415.2323664-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:110::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2546:EE_|DB4PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe12302-ef88-40cf-0715-08deac49ec1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	gUskAPBL/JsbatS2mefsPSRRsZPsrzNLoJYNDKZxkClr2euECeCZUIbMXXeKD2HVkh9UMXe76pgbqfpTeY5Yd1B9fO6KlVMyxNoMg/IgNz/9q/QBJtUSEseqB2NsuY2FzE5pVScT3oega4fsQuaptd5px/7Y2jxk/grCPtspkQaLclEOJWlwI8rn7jMl7kJBF5dipj3sBX83GImW5k039B08qrZyY0fE+oZOw6R7+KlHBBw7/gvwjbaXi16kHvt3xBrlMKX2RigOHbttc6Q0zZnJsUwW1XXsN+x8mdcl30geuM0xLjXEhYvWqdrezJ5ae5qblBJNHe/px8tOn7vRk2HqPW3HoDXHW13AwEAQa0no7pX4G3vmXPcqZKAPkv5oYe+E6ddQeQE9ODxo50wKYW7nIQ2GweplHt/HX0xSxpSY5/vHfDO+yGQbZijY1h89i67DLLr2Tcc/fMoysgKZ6mwwjgqfLAub97+J1lBGXGCzqz6Ep6QYpfOOXI+OomONRDboINXn4fCnP7oXluz+ivRXHaGbSxRchsn9q4FcrxmjQ/plAhYEjS3T2RW/je4kZCF4iBT0tfXLvK+ecGrX0GOZo7GiInungieFqxoZ9VIIJLN4eiba5yW1njX9c2m9dDO77KThteG2vwQZZiDCkf3OXqDiw9tts8/9eybEhhlIH6eo2/4jUuQ6q499GUEp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U8/ce1Pe8SMwWhop0o39cBtMqxSbEbmJSOyO61YQzMQFyVgFS7TvY8klHDpP?=
 =?us-ascii?Q?q7R2P74F9BUeIcmoIhEdK2FdrKnhKlgp1YW0OCmEPCLutFW2ZPktkkaNd5an?=
 =?us-ascii?Q?mfxu/3bp32t+5fzpM3yxDqsc1EJZKjRHhDqIh9MkBKP5qdn5BmmCMTSawS5y?=
 =?us-ascii?Q?omcvW6DZJeTMBXY1/S4da/K/RSCTRdFEIWLtvGyxEk3+wEkbyNC5jZYgiqDg?=
 =?us-ascii?Q?95wsCkpZz7ZKyuRBDDRl5hVgPutYsH2illeuNyHSc5LJz24neFfU3wnpdn9A?=
 =?us-ascii?Q?H9spJnMbX3KpJ3jZ9udMQwrtVWPteO+eexubzPcMdTjFes4Mnb7m17lY3exN?=
 =?us-ascii?Q?Xau54cFvU0PQ7cHUeuehL5gBktt1CK1LhB3jIyMSnxYrZApCA8tfzWH0KKz5?=
 =?us-ascii?Q?rQQ0NBTxlbnE2WbNmT27bZnfSpPPyp+Q5EByvNpEq/V4lxuhV5dA8bsBjEg/?=
 =?us-ascii?Q?2IeCK4po5UnmDD2+mai3dUL3I70CUYGhdfO3IXdMDookPwrYWTAPYr7sYqQi?=
 =?us-ascii?Q?obTdkgQzmeDsGG8tY6OLgb6cMw6tBbMiK/a0kiaBH/pmWtRdXuc7iJ/s/Ptl?=
 =?us-ascii?Q?X0V7gijn2x/e3VoSprNAxP/zyG0c+NGFdqqs4xqxM5LhYWPAuoVeG0UVCo7T?=
 =?us-ascii?Q?CJvcxc6gaIuFn2wTY4m5Wh/4ltvN+a6RiTyW4C1Hi9qn+FVGCYCF0iPT7RwX?=
 =?us-ascii?Q?Ba/PSe7f02359WjnPxiu6h+MhSF4eCECNBbfOUJMoQyuE8SEGynJSsv7lNRK?=
 =?us-ascii?Q?PTxydtxsJeOufk1BA7ak3L4jAopfmfbQb3DKLPo4gEh0HNIrQmfWj+/W3DfK?=
 =?us-ascii?Q?aiC6hq7aveR1EVYx7uuEIRE31xl9l4wQ3ZGw06DvIQnP5hx7q0Nk0j6ZA2Yz?=
 =?us-ascii?Q?E81v+AO07TgtN6ITt06Lfs1OO8NKOdsRHt4aUt/vz+GhwaVFTnAPwv6nW0Wr?=
 =?us-ascii?Q?rdi8+elCrGXHQDkWUFx6rR5e1UpexnAk7ISISbnCba0r+jC1vXmyYkyPs2LD?=
 =?us-ascii?Q?srpTa2Je9hwwjNYs/I678sw+035hVmekoAuN70jZdQZ2P8oQqqm/i+I1ZXmu?=
 =?us-ascii?Q?nuPKwR3KIHMvV9yGjpM3I+8h+5b2J5svBYrEnRyPG8ppJuYbQo+zYlVqa1q6?=
 =?us-ascii?Q?UHX7yyxre+BbMUbHNVJJleVj5PH2daTDFkhWL0jeeaTniTf1DOJoaBaQpDVU?=
 =?us-ascii?Q?S799jRkowh9x6OumNmobdmwaTWKUMQL0ADRUOjbCAvfYQbxATTyAeDENXD1b?=
 =?us-ascii?Q?0843EsBxcLGDHs4fXqG62xdAPDcDNUP+cRIyd9G2XH4bmfsGq2w7qBQzeRjV?=
 =?us-ascii?Q?DbdeqguYpNwh93FRUq7Ebeo4cAOJ/3VH7L3YNx7GIHHBHuUXj6+L2I5QS28j?=
 =?us-ascii?Q?a+SMF4gmR3KB7fFDwIHKAe9s31UJup/Rz4Ce9vte5cDbT/N2ZiTH+1CBUOUz?=
 =?us-ascii?Q?jOrTKh3xI+G4/iKstU2McrLIvNSmlMmTXN4F7kqRobtHuqdpYBiH32OL7aF8?=
 =?us-ascii?Q?+FvVdkNygLS0udBNr9oAuIwOKY8zCwhaXjWx5IeVuVfdrxnzkySv1IunuYE9?=
 =?us-ascii?Q?/2a57Fml5OYDyv67qixuNJViDt7gvXPqtAlEPU8XKFu/RDnlo8rmrrwz15hj?=
 =?us-ascii?Q?yBAbAnR6YfsYBKMvd9pFjoS8BN1Bb7KRUdz62MkG8jyH67Prn2OFrbhDyGpC?=
 =?us-ascii?Q?QD8D3gMzj8JWNUS/LAKUTA6ajIOjBC1UPiWoBg/RCttagW0nKtsLS2fg4oqS?=
 =?us-ascii?Q?87TEe28t4gtIJAL9iygAQlukAISAXMdqW2+hrp0bp0hXBW1qccN6Nqq4qmpY?=
X-MS-Exchange-AntiSpam-MessageData-1: 9o67CuwKT8LqOxuCTWLgdkxrhUdrxtLcFhQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe12302-ef88-40cf-0715-08deac49ec1d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:04:22.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RsaJFgNTPz8CxKnGhdhH6IDFsevRAFj1esvJIdyKmksodEBj6ZNtohgyAKKO8JZurHxNxS+R8oLxuJxpY8AyPUpZYARzLpAlf7EDAHYzEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 15:04:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22910

We currently add a dependency to btrfs-progs via the
expand-on-first-boot package, despite we don't have a single target in
cip that uses btrfs. As we can't make that assumption for downstream
users, we only drop that dependency for the internal targets (via the
kas include).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Note: This has been found while working on the CIS hardening.

 kas/opt/expand-on-first-boot.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boo=
t.yml
index f5be699..adfbbb6 100644
--- a/kas/opt/expand-on-first-boot.yml
+++ b/kas/opt/expand-on-first-boot.yml
@@ -15,6 +15,7 @@ header:
 local_conf_header:
   package-expand-on-first-boot: |
     IMAGE_INSTALL:append =3D " expand-on-first-boot"
+    EXPAND_FSTYPES:remove =3D "btrfs"
   expand-before-encrypt: |
     IMAGE_INSTALL:remove:encrypt-partitions =3D "expand-on-first-boot"
     CRYPT_PARTITIONS:append:encrypt-partitions =3D ":expand"
--=20
2.53.0


