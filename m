Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A2C77B61
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 20:44:10 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.45])
 by mx.groups.io with SMTP id smtpd.web10.3241.1681418640474519303
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Apr 2023 13:44:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sWs5qPy+;
 spf=pass (domain: siemens.com, ip: 40.107.105.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiUTaCMozwb6f9U7bXQF8Y7xvzctt4FZNUI1ZScettJxP/dPpA+F4oth9+raWCPHI19HmTFtF4GOD//SFof9EneAgJxvX5nWa9lzizQwnWHbiMP1GiIykr4x0ZszqwkSNxaKANASrYmRyT0SFbQMlXhEOwmFbeJ14bJqf6RwHFGvCAnKZOC9/kou4ACD4Leha44oiP2STiFsJcMCBgSNRp22aZpYvTaU3c7SrZ67rxNRcHBmBS1QLqdqRY36oGlbW5FyzZlBma3bzhZU0Lqpc1tRVS9Hmv4CHgyOofihnpFcrycujpQMkXqQ7TEztN5BXfrTlvFKj0GIGW9cJCjcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MC2Kihi/QsWQKQmPnza5qmOCbCSzYjQa5vvpcNUVpE=;
 b=GBiM4dIqAaNM6f2qDcIA1qXIYtRunNfIyJoHPy6nVwY7kYS0UXD3bBSN8KzmEfelMJAeUApEJHlTFyz2bRDQNsFcUE52QMGCqLloal3Bj5zJIGHvHRK03eOfWECdyTDVSPRclnd38FSCYskqlCKQdu4aJjyiTG+i0MF6WXBzgddY+FmQtq9P0b8SrJRJf0hHs8TQOPMFwx1RZKZNecE0LxuE1o6enlvLxYxzVDOrvkM2OLmsiNJWCBqE08n7LGOfex8eF6NHCy3nt1/LhlWZwlLISe2/JgjcJON1p1gTyjx4sMxDtzdgCWZvPYn0jIomvfpvMCW4MnzHaJh4Pd2sEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MC2Kihi/QsWQKQmPnza5qmOCbCSzYjQa5vvpcNUVpE=;
 b=sWs5qPy+sQB/48v30wJkWfpDbofMrBvtKH+97wBlYeH4+84hLCSqyE7wF2tnNsS4R+UqxIB58ou+IA8S9MJfhSZmTSdRg5QswUD5DJDUA1HYqoN8Y+FWngqUWIEBc78NesKnT0IT/9cYLGb3YSsUNoaVmuYqwXngKgzcIby7L4mHFFD3Ia2S5shZ5x8rJ320fT0cCUDXZdrwJBNkQyNdnRBXF94K8PVDDDM/JbUm34AgUsl0VtcLEjfkTEsN4FT7zWzfh5jzMkXbWY2XVjr6cpC/xjhg6J1sq0cqCTSUFdW+JYLbBNIskjRKOXjHpfEzQkydTg+8ArXSrELvvt122A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6; Thu, 13 Apr
 2023 20:43:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 20:43:57 +0000
Message-ID: <3609ada3-9e29-77c7-d07a-8d789a7ed033@siemens.com>
Date: Thu, 13 Apr 2023 22:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] scripts: Add make_release helper
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba6d23b-fd93-4153-939c-08db3c5fcde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TFZkG0G8Jmg7PZQQApRDG6J/CTUZKCTQ8iQG19w0tO09zqvY7ZmYBVzx3UGGLlAy5XzkOanrGNs2vMYsTgD304DlVIsO6V3FCxgvhDNHzGZQrZX0BS2iziBW9WAZEzN838hnBBWIyZdL3N0yiItzvMo78xpeWL+Z5ZKJBofY9kgDnkLE9QPnyldpU5E7iWNN7GVjlFLsjO8eelMcpsnCR0g8ByM0cVIwc6JHeo9expFnCi2eqym0JMFukfcg7TPUykytImkjbFobryPwCGn6fopREZmWjWFdt+q0aP4kd54cS7bm2ExfgrmmTKL3uluJczuEv+dbhv/hrTBNC8lW1iICIwitrtxhZn9uub9xAvpqkHOuRyXB/mvKu2z6U9d8XGw53PvQdi6NlfVvlp+lRecP7+pDY1gWM5YvUrasZFM0mBUSl7gUYEmER4SusLWY90Bk5XqLVn9GsAvET64xMFHg3Cu25hF96SXsGqr4JN/Dh+ssgXyB+1VfRH8mrInkxEq6qo05xUeEoNhNOtKo/8o83jHsq3suwIXfJrvuYH7EHIEz9ZM0aC/emE8c1PWJvNIA3RjPtRCUoH2ofXHiVRA/+VviYj9i0XUlTEjBfSWCmvhuhk4u5mSuAsb3YgMR/qd8RUYF2yy69WlIK+L5uw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(6916009)(66476007)(66556008)(66946007)(36756003)(2906002)(44832011)(31696002)(86362001)(82960400001)(41300700001)(5660300002)(8676002)(8936002)(38100700002)(316002)(478600001)(6512007)(6506007)(31686004)(26005)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnVmMjB1Z3p3bzJBbVBNSWswc3A4eCtCdml6ZkhDajNSRnRqclhaMDBCTmM5?=
 =?utf-8?B?WXFWK0NZSnM1VFEvbG1HNTRXakVaZTZCdHR4SjZlbDA2VmZFNDlwL2FyRERF?=
 =?utf-8?B?SEY5VEhDWFNIUW9nV2w4K2JuTUV0M2p6ZkpOL2ZYNUlxQkJ1K05saUNaeWdr?=
 =?utf-8?B?b2dUSGpUazB1R0ZjWHdSZ0lnMHBuSVRGTVFmTUZ6eXJNYTk0UGxSZDdrNHhB?=
 =?utf-8?B?aGdZd2dENysrOGo0S20waENqQ1RPRWJRYUliQklJOTlhcy84d1E0QmhQaFl6?=
 =?utf-8?B?V3VRdkNpbjhTNE5FNU1pMnlQcW04b3FiZ0VUcjJyTkRnM2ZlZnQwV0lwek50?=
 =?utf-8?B?em5zZnpxMW9qdThmUDMwbnVKekxYRjQ0OHVtc2hHS1dTS2IzMFN1dU1XQTU1?=
 =?utf-8?B?ai9hbm5Ib1dZUVVRaEpEUldhWjRQYzkzdWlud1B6cFEyZnlHOU5yeVZaTWU0?=
 =?utf-8?B?cVM5OXltRVp2N0d6RGJOT1ZOMVhkWUZrelY3TkMxdnJ6VEczemtydjB3bXln?=
 =?utf-8?B?UHJhc0NQaElVV3NUeEc0UWd6T2Q5c1hTMnBrTWNaQmhVWjN2eENIdyt4QmZK?=
 =?utf-8?B?eXRFUTRnSzVVaHpKdlFuNnpQZVVCUUdzYmNpdnB2bkNOdENlR1RHVHJ0aEZH?=
 =?utf-8?B?c1ZiTnptU3RWdGREMEhJT1BhRXhoRGlNUklvcTlNRFJaMmxiT2J2QnhJMTVy?=
 =?utf-8?B?K3k1SmxNSzZtZXNqMXRaeHFQMHJaVElJVkN2UCszRWpCaXRxUEZzOUJOaXZp?=
 =?utf-8?B?Wmk3YlBJQVQ1REZMY0hVZUwwK2NpUHowQlpvOFU5enVxYzYza3d5aU5KSjNo?=
 =?utf-8?B?bEFMM2dYM2NCRkI5SjNBMWxndS9TcjYxelpyMW9TR25zQ2E2YmRja3pERE5y?=
 =?utf-8?B?Y1I3L09wSEY5VFJqc1czMTdJajlkSW82bE1PSjBGRkpjWFhIZGM1b25QRm9E?=
 =?utf-8?B?R3l4b3hVNmlScFJFdkJrUGVVSVVYeTJIUWFBUmxIbDJJd3hMWDJwVExEbytY?=
 =?utf-8?B?TkJtN1lCWWYyYmlHU0JjalhkRGdXZHhqQUtWYWZCQVdUZ0Fpb1hQalZ5U25W?=
 =?utf-8?B?L0t3cVZuL0QrMm9EcEJyZVdpS1dGS0llMVp2bnZac2FtQkZLOUFGUjFwcDJP?=
 =?utf-8?B?QWFybGEwbXd1dmJtM1FJWG1ETzIzbDlhOFRSKzNhbE54dFZBQ1E4YmpZbkpa?=
 =?utf-8?B?MGlOVVl1Qjl0RC9TTjJjUjFtaEs5cGpPSDcwamhkNzhBeGcrRHJCNUJxT3Bi?=
 =?utf-8?B?U253MlBoeUtLVUpSbjlNQXBKMFg0U2FVSEJoZ1pwWDBpSTdoZ011a2VWaHgv?=
 =?utf-8?B?NmIwZFEzd0xCTGRMdWIrcTh2MnR4d21YQmJKdDFjUFhBZWNHR2VjUzM0ZDkz?=
 =?utf-8?B?U2V6WUYvSVpFR0M2ZStkWFhsdXY1OUJRdStwaTdnbDV0MkpMSjJnSGI1akVr?=
 =?utf-8?B?Q1JPWW9Qc2FlUUNhVHhkc3RIdnJ6cFlqQ3NMWXVaVXF5VGxxVFBpZXF6OUNy?=
 =?utf-8?B?cEtaanFNbW9VM3ZOdkJiQTJXbWlhY20yR1B5T1VsbXJXcWNjVlVVTVhCY1VH?=
 =?utf-8?B?L2k4ZUJpVkZKUlVDQW5pbTFscUVPOTMwK1FRQnhVcXprNnREVU9FK3d4K0c3?=
 =?utf-8?B?TDhtOWd0YkY3VVJ4TGt5VDVDWnBxRExBVkNwTDFLQjVhcXhGRUwyWmtDWFJD?=
 =?utf-8?B?aEl0STA3aFR0a0pKRkp4UTZvajR4TDYrdmZ5SWU3T052RVMzVmIySDRTWm5s?=
 =?utf-8?B?RG5QMGd1dUpxUVpwdzlEeE43Mmo2ZkpRL1k1aGI0MmwwU0lLR1psYTBxVEha?=
 =?utf-8?B?Vkx4c3ZnTXh6YmVQTlVWVklMeE5qQy9zMkJNSjlyZzBocHVWd0tHalJoemUv?=
 =?utf-8?B?cGl0S0RFbDNwUUduUnF1ZjBteVlxUFVnNWV3UHpBMWNkTHRFcGpQQzh5MTVq?=
 =?utf-8?B?bjE0WktyVVJORUhVc1FqV2xwNFlxeDBkdm52aVZGbk43WVU4anM4OFI3SXpK?=
 =?utf-8?B?TkZLQlBramE2KzlpclN3ajJmTzM5RWovSDNkcXhvdE51eWU2VStEL0ZMb1ZC?=
 =?utf-8?B?WTZXQ0ZBK0FQYkFZT0c5b0pYVGJxK0VSb1FBK1VaMFJFWGNuTkx1VUtQSWhh?=
 =?utf-8?Q?j8tAvRma9eeqedJosCxkvA34T?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba6d23b-fd93-4153-939c-08db3c5fcde7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:43:57.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS3rwI+1NI4oyi1NRFdeWNRD1WwonypEnp0aKWkYq2JdpOBuNhz66ZD9pqFWM42f3/w37y8l0+i7xYRFqlf5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 20:44:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11199

From: Jan Kiszka <jan.kiszka@siemens.com>

Helps to remember how to tag future releases in the same way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/make_release | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 scripts/make_release

diff --git a/scripts/make_release b/scripts/make_release
new file mode 100755
index 00000000..24ad9195
--- /dev/null
+++ b/scripts/make_release
@@ -0,0 +1,37 @@
+#!/bin/bash
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+usage() {
+	echo "usage: $0 name"
+	exit 1
+}
+
+name=$1
+
+if [ -z "$name" ]; then
+	usage
+fi
+
+if [ -n "$(git status -s -uno)" ]; then
+	echo "Working directory is dirty!"
+	exit 1
+fi
+
+echo -e "Tag commit\n\n    $(git log -1 --oneline)"
+echo -e "\nof branch\n\n    $(git branch | sed -n 's/^\* //p')"
+echo -ne "\nas $name? (y/N) "
+read answer
+if [ "$answer" != "y" ]; then
+	exit 1
+fi
+
+git tag -as $name -m "Release $name"
-- 
2.35.3


-- 
Siemens AG, Technology
Competence Center Embedded Linux

