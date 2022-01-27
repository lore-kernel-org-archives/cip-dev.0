Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DCC4332F
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:01 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.84])
 by mx.groups.io with SMTP id smtpd.web08.655.1643303579508093796
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=wdJnU6MS;
 spf=pass (domain: siemens.com, ip: 40.107.15.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaPnBMc189OmrjHOM9LP0HwnGzOn1V3Y0vNySsrJarU7fVcjijfAa91ZPLTWxP8ojRW1u6rVum3CBfbVPWfHuqM9Yvj4Z99w6kwA1+xUSaC5gRQAOA6P5ezwuxkg1EuK9ucsj50RbqnJR3kxYV4BFN1JXZZmTt9fiWMH3+nASDUpM0KF7uQvi6lRqi+35FeleImwZJi6XXZ1HSVdIve4bv3TczS1a9xisPaZvgXxIMb5OtOa9wRpt1e9Tn9E8LBi5u8kgSFacwra3ax0np8FUnngVfAx0HRh0OUcctKFKK+OXiYQX9CgUM3dys+trUXWVTm/zg24KGgd9J1ECZ51Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfsJobPRUyF+gqmZpHPjqeKeAWAoaO43xGqni93UkQU=;
 b=XMFuhvVdKIBSikhCJnTva49OjXG6D4EFdfbiujuKNTykILGBU+19nqXlqLT2t2tlxpfw5PqTAYSD3rfkv+RhsGKH8THlbm03NsXDPW+gXb2c3s5LlgBFnRYzUWG6PjIjAFfcRd52d4rS2B84ExQDJRnJOTZqDoYzFTmtXBJPCD964X9gtDlPkGdQT5wGIkJ4Anou2OKuZNHYv4kbHsV7rIAIsH+2Ys6uVgevfYcGGU2LEaIuEmQjxeKWOfrAGMx9Y6cum5L27Zjza6V6qOHyTQsYJ/eiL+ldE9/Z0ufvC9LbZejNVhC8QG/p2ZekdBInj1NDKVSAcRrknoiJG58jvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfsJobPRUyF+gqmZpHPjqeKeAWAoaO43xGqni93UkQU=;
 b=wdJnU6MSEaxbhjoNmG1ozU5u4y8dfwOwJr6iNQJLxTdJGdk4Qe7OuWRw+aaH52LwgyUTIaieJttDcBh0W/U/0p5O6xUaIjk5xC86ImL17c/+bxk5l0yfjVKkvneI6Ksj+wynh80ATPc0b5hNVXUjM1jimkJOehT5leTOvCo3wJXqfzBBw80snadFTCq+V7DDSu7E/O5tgBCnr/KE0vG5VgZCbDuFMBL3NCDObrMg4FZIDd1sdCMVhleCqA2L0maQJy+cQwaV1uJ9lzKDVByLuJcfs2aXK7EqF3c+dx3mJMzk4EMPQ3FTYhgobrZMJo/BYQMhSGX1yhP8npQhLEsBUw==
Received: from SV0P279CA0035.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::22)
 by AM9PR10MB5082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:435::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 17:12:57 +0000
Received: from HE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::64) by SV0P279CA0035.outlook.office365.com
 (2603:10a6:f10:12::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT022.mail.protection.outlook.com (10.152.0.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:12:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:12:55 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:12:55 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 3/6] Add script deploy-kernelci.py for
 upload the cip-core-image-kernelci
Date: Thu, 27 Jan 2022 18:12:40 +0100
Message-ID: 
 <b9f11b364d7a658ccfd11313afdce13d19f6da7d.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: effc0a1f-5e03-49c2-3826-08d9e1b84319
X-MS-TrafficTypeDiagnostic: AM9PR10MB5082:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB5082BBAC6588EACCE08ED61995219@AM9PR10MB5082.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ApZtGF6A6RIXcOfadEYQWef9v39beiJ/MUd2n8mQLpouzEeCbPiGgzNpVOGR4NIuFys6jisRzP/s/okan2Kz6QpQM7p25zja0YCE+YJzogMjC8QyhutIH682/4OFgwD1JUtCBzTLqvfdseH3AfIqmgEIymaG2dViKsa+xNaaftb5lGNqtsl4/3hSId3rqeS/x35lC8bJM0tKivuZFdDUHP0LPk58QS1sdYaNV+sk27dAoJI/MQHXbhZ7swVbCAUKPUhc0R47iQ/WITEOEDFi/CBmxbh4cC3C80WJfa8MYQX6cR7FqtyPkg0K4MTLQghsIUxMgkwS9IBu4i9wukBMcf66GWgbX7Lf9c9pkGCR6S1enwb+Jpr0bqi41/9U6ynuR2wlQopDgRfABD55bsPrOFo2KDcjYXG+S7+kyv7r3YV9Ghq65xuR7U7utCZ2PORsrhv9lmYRDYV4GmeXP3sFkV65mB2R9ODoKv8bxvwSmZ9z0uacb3nLlEqXm66+MtLYidp62YXWjNBsjPh6P+BX+SjGZbjWls0FHQwbsS640VQk4G/UCm1yGIjTCf7ZWcILEogueICLBtr/WxA8+xiMVxjUr19Xe0GG1/uLHBgTVE+2pHRkBGLMtnr3OC9OrBKyJGDUp/4jp63A7bj7y+CTjqyaTdiXH3q2/F9IX1JN/Bh24hgg0MA786C+qBG7KBQf4GJ2cdBA+Pjh4YYqaY4CyQqx7vh3WpDMV0hZvW6JP+WhyxsHij1uaZ8zL5w9L7TSod1gwUrEze4bN7IRwFx0f9aKqsUQ4NSTSWPn+jCOw9k=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(186003)(2906002)(508600001)(966005)(336012)(2616005)(956004)(44832011)(8936002)(8676002)(4326008)(16526019)(47076005)(83380400001)(36756003)(86362001)(26005)(40460700003)(316002)(6916009)(82960400001)(70206006)(82310400004)(70586007)(36860700001)(5660300002)(356005)(81166007)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:12:56.4656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 effc0a1f-5e03-49c2-3826-08d9e1b84319
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7509

From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

The cip-core-image-kernelci need to be uploaded to the KernelCI
production storage for been used by KernelCI.
This script use the KernelCI API for uploading the
cip-core-image-kernelci to the production storage.
The images are uploaded in the following link:
https://storage.kernelci.org/images/rootfs/cip/

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-kernelci.py | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 scripts/deploy-kernelci.py

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
new file mode 100755
index 0000000..5a8adca
--- /dev/null
+++ b/scripts/deploy-kernelci.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+import subprocess
+import requests
+import os
+import sys
+import time
+from urllib.parse import urljoin
+
+cdate=3Dtime.strftime("%Y%m%d")
+api=3D"https://api.kernelci.org/upload"
+token=3Dos.getenv("KERNELCI_TOKEN")
+
+release=3Dsys.argv[1]
+target=3Dsys.argv[2]
+extension=3Dsys.argv[3]
+
+rootfs_filename=3D"cip-core-image-kernelci-cip-core-"+release+"-"+target+"=
.tar.gz"
+initrd_filename=3D"cip-core-image-kernelci-cip-core-"+release+"-"+target+"=
-initrd.img"
+initrd_gz_filename=3D"cip-core-image-kernelci-cip-core-"+release+"-"+targe=
t+"-initrd.img.gz"
+
+input_dir=3D"build/tmp/deploy/images/"+target
+upload_path=3D"/images/rootfs/cip/"+cdate+"/"+target+"/"
+upload_path_latest=3D"/images/rootfs/cip/latest/"+target+"/"
+rootfs=3Dinput_dir+"/"+rootfs_filename
+initrd=3Dinput_dir+"/"+initrd_filename
+
+def upload_file(api, token, path, input_file, input_filename):
+    headers =3D {
+        'Authorization': token,
+    }
+    data =3D {
+        'path': path,
+    }
+    files =3D {
+        'file': (input_filename, open(input_file, 'rb').read()),
+    }
+    url =3D urljoin(api, 'upload')
+    resp =3D requests.post(url, headers=3Dheaders, data=3Ddata, files=3Dfi=
les)
+    resp.raise_for_status()
+
+if os.path.exists(rootfs) and os.path.exists(initrd):
+    print("uploading rootfs to KernelCI")
+    upload_file(api, token, upload_path, rootfs, rootfs_filename)
+    print("uploading initrd to KernelCI")
+    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
+    print("uploaded to: https://storage.kernelci.org"+upload_path)
+
+    # Upload latest
+    print("uploading rootfs to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
+    print("uploading initrd to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename=
)
+    print("uploaded to: https://storage.kernelci.org"+upload_path_latest)
--=20
2.31.1


