Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C15C38A2D
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:28:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.80])
 by mx.groups.io with SMTP id smtpd.web11.18519.1666614521439018156
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:28:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iZaozp4L;
 spf=pass (domain: siemens.com, ip: 40.107.22.80, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcyZI6EZ31R90LvGqUyzOtW4Kjxz6nG9OcmsGLHCd/H0NbuFIBh6m/kUjrS6s6cEsuFbBMlKeJkUY/FMzes3h+VnFmDd5H3F6WsNjLIekGK3Q/+BAGWfNoFvWADvcUxQvWtthyja3X8ZejCvnXcTJINalDL3uxze3VTZDX5iPeR0hHmNFah16qT2bcVt/9GQeZoJGNl43ier8k0P5RZr3A0d6BnRMulYJqdxc5wGyRlUhY91eyNmkCQl3I4F9OMWK8Y8eqSbNd0caEDBi6Rg5uM5xufD3V4oPdX8zUXH1uKyo4Z9xAlnJ8cDXTeMFUElc30ozBlg+e74BKKFEnNECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKctsy99kQVyvvjfNtrVgONXkTgC7lmciMU6TbJdXpg=;
 b=GV5w5g6S/FuoOCWUyHBYEIrkHYVYW7EZ8g4BwkjKFGvB45ohj2H0svp4CN9D59WUDI2jtYTIYzV+utfYvgI2/tl3zsZagJ53yR3cjeheHqs/uoChnwzXBa+iqXRj/ag+Fe9CQfV/fDzj4f0HNIQg09bduXBWNJ+8rrKYxxOjbAyAuHq/CqrTXEVbdnQiJFUkyyIRHScJk7Rh1L8cLCFEyMg8k0JZ4I6dYjW1rx2NqQFIv1jv9ayNvgB0xWSMs6j4rpX1jafzJ1ZLYLJ8fi5zCzi4CcMsHK39o2t0U1z7Y6isAKYvrGpMierSOXtMPCWyQx0TqYmULl1DpABZEko0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKctsy99kQVyvvjfNtrVgONXkTgC7lmciMU6TbJdXpg=;
 b=iZaozp4Ld3NhMOzcFj06uSxyztjog/OoEcHO+BNt/OctNKS6xBkMTo16VnixpVV+Za0POBYr5aNa48j2/g6IGsjEVTH5N06Q0Ij9UDak+JoOwAGpneV7S3IPYoLt9OWcCi8uAn4bsKiLXiZ8uBMQDrZWvzikmNsRiLBA5/cJFNSjwARAF3JNSCFG3aJDgZQBCVnyYXMjCWcwX9FHMyoR/YNVeCeubbz/qqNyRfgTV8MAbuQVhPJ8n1eI44Ua+JIYiI2c0a9BToMLeSpwtWK3Bce6c/HUW7Tvtecvxh/q056VOrh93PjCWqUsUc3XfFGEPCgYKrT0lxQgh/dFX+1qQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PAXPR10MB5783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 12:28:39 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:28:39 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 6/8] add kas files for building qemu secure boot images
Date: Mon, 24 Oct 2022 14:27:23 +0200
Message-ID: <20221024122725.383791-7-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0226.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::25) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|PAXPR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c48a9520-e1b0-4597-58dd-08dab5bb4776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DSLvZagd7r30SiBYb0RBqQLvAV2nx9wTmniHirKbIim4+mMG6CJvwokX/OtIonf2MJD0mwbg3ApNBwKdIOb+XDEgsmq1+AeTXJ0avgEL9SQK5SgG3+PPFXpoIffe4qJPxdCdsaGbXF0f8z+vI9+xgDaS72hQVCiCUdOi6WW5edvLvxy42ZlGniwHH4yvW1Pv8IXfQX7XaRfgAjmOnhADISjcMVbYb81dSWxeM/ZwvOROgxQxKJAAYLowKb8oq/nKB39I/HftO9wVt0Zv3BxI9VZdLnnsSC5CO2M6XUwmZ/0bo/LIhaZfYm7C+6AK7n5NsXtOKWm5X2yOOcL+hkfcHTNlwyRJtUTEIWp02CpBZ3hhndPB5UXyqTcJM9YUGqJ2IrCjbOhEzYtraKuYWBhUcgLB17++2y2G9PJ1a/TxlUERG7xJcpn1qGcxnhiYLeLkfyD3nQVfMTd8xilIHGbg3QxAt4NVUZGJgygWB8hS8yMybl8PSL564v0eoXN71EWHCQXaqgCHEy2ixxdYguiARIsYjxsUL485xq3mMnT5Kf+HHUdsOB4koI+PxFQr3o3eYNsuXiK92MUgy4wrvSrw7Bsi/c0AKzTlCOk3ku71Yg1rcKMLdgM3Pkx5LVlbst0Eg8WL6DnNb+sb6DYVzysyksr5ZNpn5RlNF38quElqyzHKSDrG9pUzPd6qDdg1sLOyBUzg1pEZ/kH6dreBvhMWVg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6486002)(5660300002)(186003)(2616005)(316002)(2906002)(1076003)(86362001)(38100700002)(6916009)(6512007)(4326008)(8936002)(66476007)(107886003)(8676002)(478600001)(9686003)(26005)(66946007)(6666004)(6506007)(36756003)(4744005)(66556008)(82960400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hM9XyUZukM4raWJDZ33toegAAdsbi2fPbANJR0DoQOhaO/oUY4EPDM38zzPS?=
 =?us-ascii?Q?A/NV+sBaQNbZepTSjq/qumKTE2hryrMSSrvR0vSs1i2ATlqPdxucMP62mWg9?=
 =?us-ascii?Q?ZonRYg1RyLvb2aBLMVf9SMFh3PlfYLx8MtZWCR3HKsXVDapg/j0YiFZHleZ/?=
 =?us-ascii?Q?fiw+SYeIGqDaBE0Ya+8hlAtgSP2ftxsOJjrKr2ylbmv3rlWB+n/Td9DxOgMX?=
 =?us-ascii?Q?N42EyY/3fuRWeFK2BLsEtbzhsJNQJ6x097m8YTvqCQRrxQNMK73tG2ZFtbOO?=
 =?us-ascii?Q?HH9VHbvBGrb2Xtw3KZskemwtTxiWYyLZLkBoalaE8taMXUtR2qdztETA7ANj?=
 =?us-ascii?Q?WEPOcAQQ3EE1WADMp8Ld2z5X97q311c1mU4lp6hWJzct3OTi7T0r4EgcfRDW?=
 =?us-ascii?Q?xN2AcaPS1MtrrQcLFJSZ71noWjJnVAUF9qqinq09YS37J793P8NWgyqrOG90?=
 =?us-ascii?Q?z2S3NU93SQNWQ8uE/N1nFxkBV8pJwZs2bO8jKfxkrfa6LDMQlILgnaQAlz4X?=
 =?us-ascii?Q?59m8002f+9p/wrEKNNNw4n8AUAAoiZz3NKpRBeq3A/1MjxcKCRR5MKgpOWmg?=
 =?us-ascii?Q?9lLzUqNtLFZVC/6rk2ewUDUlxuXh9EFNkOUeakSB0CeUcX/RaHz45ub0Nv/8?=
 =?us-ascii?Q?CnrO0kBkATmmcapSrFFzIJU8yS2Y9OvUZq9ft6FIrGnLgbeuNVbbu20WtAkI?=
 =?us-ascii?Q?4f/DUQrpjpuobhAaURDlwPpDfWkmzFa9Ui8jbN6cvYgI3gdSt8lHcFNh9uiK?=
 =?us-ascii?Q?RB0QwUnIUeweM+LGU9uUNBsxTaKUBCSF4wRB8JFnr7A5vyxZh4We1XOjVmhy?=
 =?us-ascii?Q?xMhFqT/ymulXwUNR8D3hTa+e6aqXUrv9UycIgGI7BdQL8aWV8IQAYmMbby0o?=
 =?us-ascii?Q?94CwmAK0DzkwRXr+OSQsRaKQVgVTdBzap86AkgwaKeZhcM7bakTPq7UFIjxA?=
 =?us-ascii?Q?EgkeEeQ8MLQ0lfQFVEb5Vn+wUK6h4cm/zpVwU0lf7AgJsOfhhj1GcH/lG3NK?=
 =?us-ascii?Q?gQxmhsOv93F4Q3WjMBeAIM9RTAGjOhrn5Z/ldC5AywcsWKd9U1d410m+FEgm?=
 =?us-ascii?Q?P0Yx60Tk/J997awdnf4O/qipaCL8K1QfbIpL8/m9Mg1hiCrO17TA1bwIqq4x?=
 =?us-ascii?Q?7JzUaqhfhk98BTGOFkpEo8UDpCPJlx8WdNw4UPbn7LNZALZhlQpRkLlBfPnh?=
 =?us-ascii?Q?CA3USS9eO2ig7HAWK9WUkg/CgDuMc9oNiRFQHhE/2NSmxG6Zo4WjcXEc8Rb2?=
 =?us-ascii?Q?dSpDoS401fv/O54AdxWMvxhIDnGfEywZ1Q9F0GPqro6GDE2sQ4RdCsbQDkXk?=
 =?us-ascii?Q?dt3L9bUayiP1IU/llKUYYFUshl2YBQO5HTj0bXsVhho+l5NzjZbknC+DiR7R?=
 =?us-ascii?Q?JpT30hkrkDT5bfSYy8rVFi8FGXxtWw1KSPmdWt5XAPwjr0BoQSkI1rLTB2Zy?=
 =?us-ascii?Q?Q+c7DhAFweD6Tp6krktaUzJ+wEfCtI20VIk+ahy2p9SAul/anMbiVj9kfYfQ?=
 =?us-ascii?Q?gFXc638weA7nfbuipBRu92Wk8KgDteOvNqZKHd/o/n3HbzOHp87qZOHmlnw8?=
 =?us-ascii?Q?CpIN6wwmssajIgeCHnRN/Ha1XLFllipLqQO90oHBLQ5dHoZyJIcPIfuK6mqc?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48a9520-e1b0-4597-58dd-08dab5bb4776
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:28:38.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ped7jUzMNKxRAqsnVGh3/xWaGOkTiK/Scui8fZc+Lcc/nx2iXYQmWPm7K2odpEoiX5yVdCZmHe7msSntdtDTuT1Yo41iIEwFFqWGfTOsAQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:28:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9810

From: Sven Schultschik <sven.schultschik@siemens.com>

The u-boot-efi-ebg-op-tee-qemu kas file combines the different recipes to c=
reate an image which can be booted with qemu and provides secure boot with =
EBG, TFA, u-boot, UEFI, EDK2, OPTEE and RPMB

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml

diff --git a/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml b/kas/opt/u-boot-efi-eb=
g-op-tee-qemu.yml
new file mode 100644
index 000000000..0558c8e79
--- /dev/null
+++ b/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
@@ -0,0 +1,11 @@
+header:
+  version: 10
+  includes:
+    - kas/board/qemu-arm64.yml
+    - kas/opt/5.10.yml
+    - kas/opt/bullseye.yml
+    - kas/opt/ebg-secure-boot-snakeoil.yml
+
+local_conf_header: =20
+  trusted-firmware-a-qemu-arm64: |
+    IMAGE_INSTALL_append =3D " trusted-firmware-a-qemu-arm64"
\ No newline at end of file
--=20
2.30.2


