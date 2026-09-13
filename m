Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30DBC88E63
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:59 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2208.1789317471845042288
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=TNk7MWSq;
 spf=pass (domain: renesas.com, ip: 52.101.228.70, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKa1+S30bFjYpYRsdOx8bAxvu/MKPYt7SasQoeLUZg0pEPEz6opWT5RoDJj5gEM3bM0bY6VTZ+S3qadfAJ0DwroDI0qzbXLTrLn6Y69Fd6gcfgCe+jaz5HaGoxxG7hzzfupN6DuCgyQgLTBbRNaZwxOogQ8DwU/A+VPGzQaGwornKvjEH+xMKzY4ZxcjV2jCASm8J4mbX8SdCtZt2+7xuV9fiGMwpcpQaBlpeIvtptUd5riBrnnRAkzbUYKwc3gs/w6EBfHnYB/rXjcinJq3yfF3HsOI1/f+1dywvTZYOdBhRjmKD67sHruk4Ek0NCohE9syio4MVQb9lrHQFYqF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owxwEMd+7aNIU7t2sHrgiwhKEqXxfMF0nARVVAHpcpo=;
 b=J/Ei8fAWnpEXfqCxm18Vba54IcAS/VY2Q5ht/OztwFl3XLTsPrlqpMVF76w8zd3F5VAlifxugHQEoiS6uuqSDU21uPoBA/+qqDjgLcwFzPSJn6g3aRxvCpGgFWhusYIVo3VymbOe92cUmNifBfj8tfquDlCyf0IhiMjHrzdv1YTx2yhK5980KYZJaKH1BcEpHoHAax6PMhUGCMSrQreAnrvw/R3S5YidbvevU/vHAanDlZyTxjFMrmg3zNhtWvk2LrpX7Opf/fhYysfSec9qYbpU7Jnk7MKK0CAHTtfUQO6KG3oTgC+dJjtUhbM/sa9L1guUDhMFoWlxhLlRlSjIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxwEMd+7aNIU7t2sHrgiwhKEqXxfMF0nARVVAHpcpo=;
 b=TNk7MWSqavFDdWHZurRV8NJHne7xXjcQq30gqKpbaz+SDUzgZvp/uwfulIKdqfrUuAaALs8Um/RLBbHv6M21mKIPaaxoJhDTbVTYtHyl0denL63dqYZvx1cROVmb7Z3AU0wW4nq1IWB0ZxVcZFcS0sRpQLxZYwgJT7qiMllc3/c=
Received: from TY4P301CA0085.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37a::15)
 by TY4PR01MB13937.jpnprd01.prod.outlook.com (2603:1096:405:1fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:37:45 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37a:cafe::60) by TY4P301CA0085.outlook.office365.com
 (2603:1096:405:37a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:37:45 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 94889300024B;
	Mon, 14 Sep 2026 01:37:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H and RZ/V2N
Date: Sun, 13 Sep 2026 16:37:25 +0000
Message-ID: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY4PR01MB13937:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f2f3640d-9b59-4bb3-7a05-08df11b55720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	0J9wOU0RFVlT9l9/aIrJ2bd/H46fYr6BG/b02W9q0NnPL1VXX8WV4J3YOyw0nSPNv8NeNL5bkfJusifGi0foAHsSbbrfTQgrmyRb31I7dPLTR50f8SlWF6l3VEKUxAf/ryQNkiuS499TpiqU2YuNsnHJgIE22XhO1uwonq84q7PqAkbSZB+00oA80iLZ4LA1ik2okUkIwAOy6GGBkjMimeop5ebT2+jsxoQhtVTpkWUpPTDt6T+uijc+dwHHfyK8a/nkN4GAAMIf9tRY5FKLQYQeql0wTFjBISI9zjmE8mjlvwaPcp0nB/BHL/oHShbqvAzc27oprZwZwW9ow1mA6rohtJVh5kRHmVWrZzIhEX494kdJEbdc4qEaRz7J3HLlt/o1Is+ItOXc1/FdnQn9hgqoFAFAESthHAQLNv3zbfLKVi6ZmTGW+00AdL7pjDa3V6E4W1kVZPAvUm/5g9VuQNt9fUWpN/HYM7viaVi0IkZtU7s871kC4pAPkRMtfcseyNuub6J6zmatpxHYe1HqMe0BdXg8SHQ6sW0gikr2mQVgJYRs+RJFC/8piKywsLveoWbsxYHMcs0fCTmwP1bV/CRPbVodyJPytlPZaEpULqB2fq6vcWfTPdUBpbgYLAgEhprq+db9prx1k440VhgA28j1eolnlyLQedX80mZP36Id63NYCfkSykkjia0ksCPBYzzDfuujWZXdq0DCo1+wZA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hUI2Z8xCHbeARCUgvkn2Kmd0bWlxfSFhx5jjYYQa4m1mKCighcWasElJWBvQQHqtxSv+RiqXzjInejpMjuMA1pV4IOYzzodLFD467TxzT4DrOi/mU3mN3ZM96qtZkktGyEewZmUtGMTc4XmSpvQ4MIG/oaseDcyFblw20C4QzUDIljVFcSoQd9FRY4Yk405OrpFcNYervPfuDGb0JjGk+YYzZKRPjhyZCwUIETIRVaISflSHIbK68ZRG2kxrmZ4O9GXc1hDN+fqTKdobyozsnHXwNY/QotAePAynsR7as0CcUr4JglD3Te8OjUViKkKCEosQZ8lHGhagVU3nYUeLf4bUjtUU6uuEfPaqjnScBxJtSVfYj1yDg2iD5ycxeWItrEUBY8Aq+lilbZAtM5DBAxMcQlEbVCAaz2cX5wktjaNbY0lscdu3SnhQziunR30U
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:37:45.7903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f3640d-9b59-4bb3-7a05-08df11b55720
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13937
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24158

Hi,

This series enables DMA for the RSPI controllers on the Renesas RZ/V2H and
RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (2):
  arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
  arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels

 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

--=20
2.34.1


