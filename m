Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077EEC433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Jun 2022 14:14:21 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web08.30547.1655475256919994416
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jun 2022 07:14:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=WSvXei+y;
 spf=pass (domain: siemens.com, ip: 40.107.7.51,
 mailfrom: florian.bezdeka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHT2kns0sY2ZiBPAGpCwAc/BOCjFW0UJ3iwuf7wXpSsMc8DBdM/YU7ZoBDpG8+PTjUvgmw9ZV7THa55jP2UtBE/Alj6Kg5ddHmtoX9i65k8kiubmyS/BmmrtwiheO5uJIxI1R8VzOoedFoxXIIpa61PtmEyrzniSoV3ODhO02ehJHmmeKKKna8nhbiK3Gx8Oq/yCheXyhEalTJ/lqcd9l6EXZRHXo1MIR+tkCtTFcoJjTt4rtAnwOeCv8BVH3M9OVuY1jL5jATqPrmUtVwIqqvA1sLLb6tF/7JmW5o9Q4v9HWmTgTIrOQdhSZGCYedl0EgoKIt52lTW3VzJDXnvBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnBJcaoWAht0MAxJGhI7lr9qv5A7mzMmTnjcw0cGC/s=;
 b=oZTMUXZethrFY/dVhXB/5VQIw59SwqrXRyf7aHqbG38bk88f9a3imERQIJPhBLxml9acx0ZFJwa/fpI0pxX05XceE9NrQfkLjwHAJzbc3OUtY/TXTL4Disvn6Fs1kPvyzJLjzIDCQZcaUXybV0+5h8XIWGyeLJrHjgc/FZ53KVNcoN2rAH9LdMbLQ7l7Ek6ckSsKQxcS1R0l+e7HUmOB1M3pwpTqLCDxgEbqRNOzcqxwU9evhkI6ckgVjdZ76RgVC7A4eK/ijdgZbof1UBBnnRQ5qYICt++7D/hWfKsjr+NTRhoIhZwqWxyzfjkKN18STG2oxD4LZmj6l07ySh/wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnBJcaoWAht0MAxJGhI7lr9qv5A7mzMmTnjcw0cGC/s=;
 b=WSvXei+yfGLa+33IdNVUtcAUmzElw5WzZAeagbww7LK6K1IHbkiESO5NG1ziNmbn0HE/xRu9HqigI7QNorTaomQe7YdGylYLFUc9dJiZB1hU+YZ3Ig5J5ijoLlHmvJQrUtTn/tx3/joYstxsVMU9LJ7npCP55I97m6WXmMjcxfWUym3rQRLEV3z2rFJqEgceNtpkaepCtuKQZOoV4POln1BDghUnkcYcJmGjPJipIKw3QX2XYpxM25T2vXD9wFxR8pZG8ybur05H2LDRyzk3lOaxiL+iMh+vgDz/qZ5+n6aG8BchCEPhxwIlWit2TU0JJTus77VN5ZoHeaR0fiL0mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DBAPR10MB4172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Fri, 17 Jun
 2022 14:14:13 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd%3]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 14:14:13 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate: Limit SRC_URI addition to the
 supported efibootguard case
Date: Fri, 17 Jun 2022 16:14:06 +0200
Message-ID: <20220617141406.526462-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0146.eurprd04.prod.outlook.com
 (2603:10a6:20b:48a::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93bb8424-a80f-4dea-d037-08da506ba7ac
X-MS-TrafficTypeDiagnostic: DBAPR10MB4172:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB4172D582CC43A04E96F91556F6AF9@DBAPR10MB4172.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1fCZmVUjBiI6fwW1FJ86beVMQehijToJSKpbvz8n/7ZkRlXTmz0nmRjf4QaOCYfBxyLlhfrIA6SpDza78CiIdigYyHgjrGswmy0k3hiPqFKK47NhyCX5t8YSQfQ5X5uy6beeTHiPLf6he2Uw3Xp+DdWWtodXG8fUJ2sSNGNljFK24qWhGhQG0tKvA9NSKzeObuAeByXo3bEwwKDt0UCzNMRDtA3zSJGh7nH3Z1F46DHEVkqintXGHbMaDzSJIoU20U29dEfqokxycFTtPQ7QetfeJUy5XqrkdjmTJox8A5GtHrzdc2phSQqc+CNg8Kncbh6ORk060ETYUVs71F5oQBgRqY5L3PyclYkjfdL2MWJeUSKYiF9qKnov8tRx2XjEglkCEHc1vLUV9LGyEmra6ePY93YCQOdIHyK5TUYI6UD6mwkdbCpY48b/LKjE1h5+pB6Qwn0eWa6fpauJMgekjPsd60u6K53K6SDreemtju1cvZHalESxeZdnifKI0m9vsjbd8TXX7UPb3QXljGGcTrKb2mmA9i9aKdSSoXr6bVAXixrgmdduEHSzUhC8OrCW+UeM8xxF/vIaDdcCIqY4x1UNOhoFdTYRlcdRuYbQ/hIyHvJlQ4lHstng8qM76NzkGZI1uGbrtq4i58ljhb427Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2616005)(498600001)(6506007)(82960400001)(6916009)(66476007)(36756003)(186003)(8936002)(66946007)(86362001)(2906002)(6512007)(44832011)(316002)(8676002)(4326008)(6666004)(83380400001)(66556008)(107886003)(38100700002)(6486002)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5RQKbRN0l/rZRGL7aJsVwUJRe3U6bxeoirmWUQHo/0B0fzXUuHKYr5bfujKC?=
 =?us-ascii?Q?uW9TQFpwYe5BxiS8aFqUcZYhNDeiIe37iiZfH4ivOxsOgZ5VQTCW3ZTvHPQk?=
 =?us-ascii?Q?oYgcUP2AKNtm6KgnzJwgHDViPs8farGFNfThZl5eXe49VmLPcjPyKO3n3niA?=
 =?us-ascii?Q?P9bonD4QzfMRp8rl6rsm9sAs0IXi/cmXT774lMJVo1+WYeyjXu3XW/hnUtz/?=
 =?us-ascii?Q?t5gp+kszwhgJNKq071SP3L4ogeqOaAJ60MSDIlxUgwr8cuxMndzdNv5jVddb?=
 =?us-ascii?Q?mjrizPmq461vUjpqTN0M8Zxeb0eQ4cdSueBz1G/j1lp0cRVAIn18JPhJkwpZ?=
 =?us-ascii?Q?fkUEv3OMJLPsRfI1zual1QTXRCJ8M+s/F/Lx19HSpTZ52XkfAF78CN1ZWOip?=
 =?us-ascii?Q?bs9yObpzXspWQsUtjfR6Zhef8mAoluMSmMySIZqbKEftu0FYGUPofBT6KnXv?=
 =?us-ascii?Q?tkueFjmH9a3ClDkt/L4OYzpgTS1E0cxjmLlfo02UKiDMKr8viMOAtrDpd8tK?=
 =?us-ascii?Q?jPDgPmQ74JJZlvYXAgpsS9tA9F7r76YC71/kPYdrefK0xPEjQttYCy6sVem/?=
 =?us-ascii?Q?92egqG1e177QyyA6U5w/FUrC3U4flWAuSCZhCULAOHoUdtWj6q7pYThuyTrM?=
 =?us-ascii?Q?tl+d/bZDZvoU8NhlgM7/N5feuRcdQCykhnG65NorFUzWlVkj/u54Pj/nCwRt?=
 =?us-ascii?Q?HOnJb8aueutviHOl8EcPjbn8VfeHKcrkZsMAxwWqKLbk+U5jkbHK6V3DQt9S?=
 =?us-ascii?Q?/mi0vTvQMJCLojp//+ko2HiPCIpsjs28J4JLUy8NGqqqAhXy3v9+eql1AaX0?=
 =?us-ascii?Q?luMF+kv4UoVXvGVLacpfiFa9SDK+PXxdhYN6dJP14ykBvKEJ4cMYOXI9FqBY?=
 =?us-ascii?Q?d2S7j28R4ZEy9/ITdkHJr0RTa9N2IKorkSTCONvCvHzUFXzrmhnCQnfDKtIx?=
 =?us-ascii?Q?/BIeci5zhKwgdaNA1zMVop+8ZtVgd95VCGoO+badJyeaQNf+fSIZuRfcDrrl?=
 =?us-ascii?Q?IOLYGojJX9t/xaVLiICM3A7mnev+PlUqKGsMBhcRHYyI+PCwkQBaTgBWxMJV?=
 =?us-ascii?Q?2KZMKY3YwhtxbhosP2ujW/cbg4nDZzHAW1phwTktSMWficfOVYtEGhnSHIlX?=
 =?us-ascii?Q?Pgt8dbBkkAH4CQNFVIs30RMS4W6kox2KdFcT1bjaqCQh2owzd9VcKPnUQzXa?=
 =?us-ascii?Q?wAVRX5ngCZDSGDxwji908cd2vamDcYDElCPP92YhpIVIAPCud8cKxgXw/2kn?=
 =?us-ascii?Q?OmURiV2E0KC/5AH4n0O1SETdejB0vNsJOD7PqXoiPmnYH9PICcIG5gfVZ1Wl?=
 =?us-ascii?Q?IaOd6Qdconi0liFb9ZitPpqRzz7mDO67WFeNUFAsxmTzPFCK8ExanVgy15pC?=
 =?us-ascii?Q?OnKsemPsJXeC9vPyxqJfzfMq+VE88BD+pF+eOH0trqyRyIT1aK2k5kb/uPtT?=
 =?us-ascii?Q?UgAKS3Co/08q/QpYYHHc+lSLOVwSMHPg9Hc2VNkh4tQ53HhUswGyRUAJ1k5Z?=
 =?us-ascii?Q?oNkJkBmjsDoVbN7FWtC90UTW1hUVZUY8MKXwlVF4IbhItFsPs5prBdlAnVeH?=
 =?us-ascii?Q?Zbe19RmSoKyX3AUdHrAAyrA0OeBhKOIrW1WR0rQseUXAPJDwLB3VlpSaNQ9I?=
 =?us-ascii?Q?ExRovd6JkrrgJql9DWDmkQ5s6VPiE2Rme/e1PEoit2KqsGbFWTEN4AMXtYjO?=
 =?us-ascii?Q?qFFeTUXfBFpG9lUfFcWRVd14cjnRe2WSr+QNzbORcQfor58U/gwvq7hDGIAs?=
 =?us-ascii?Q?d0j8F3C5sXThuGDu6LEQ51Jg+M4uAwFiclZvOANhH1rXQBXzyk3DRvQ3cEUs?=
X-MS-Exchange-AntiSpam-MessageData-1: 
	vjhB7rEimA7Kr2TfbeB6QHLFYEDb2GaGGJpa7gBumBfVe/7/E35jm34f
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 93bb8424-a80f-4dea-d037-08da506ba7ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 14:14:13.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 7MRLr1BmMTR9Oaiuqm6q9p9TDSB4nCzLeWxN4+Aw2sr+Mq2FwrQ2T/Hhpm2rutVFyIXhZlQTvfb5P430MvDeAAG+21uPG5lMu85yiqawipo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jun 2022 14:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8576

The following build warning was observed when SWUPDATE_BOOTLOADER was
set to something different from "efibootguard" in downstream layers:

WARNING:
/work/cip-core/recipes-core/swupdate-handler-roundrobin/swupdate-handler-ro=
undrobin_0.1.bb:
Unable to get checksum for swupdate-handler-roundrobin SRC_URI entry
swupdate.handler.u-boot.ini: file could not be found

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                         | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roun=
drobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-r=
oundrobin_0.1.bb
index 5801113..7202c14 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
@@ -17,8 +17,7 @@ SRCREV_swupdate-handler-roundrobin ?=3D "bf73f04b1eec0b87=
14d3a1b56bfcd1431c58ba10"
=20
 SWUPDATE_LUASCRIPT =3D "swupdate-handler-roundrobin/swupdate_handlers_roun=
drobin.lua"
=20
-SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?=3D "swupdate.handler.${SWUPDATE_BOOT=
LOADER}.ini"
-SRC_URI +=3D "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFI=
G')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
+SRC_URI +=3D "${@ 'file://swupdate.handler.efibootguard.ini' if d.getVar('=
SWUPDATE_BOOTLOADER') =3D=3D 'efibootguard' else ''}"
=20
 # lua version 5.2 is currently hard coded in swupdate @ debian salsa
 do_install[cleandirs] =3D "${D}/etc \
--=20
2.35.3


