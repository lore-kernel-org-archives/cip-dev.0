Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13380.1794902701588859709
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 00:05:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HQqug1cs;
 spf=pass (domain: siemens.com, ip: 52.101.66.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr6yM/t4vdVNPLYGLxBAMNIiWwLIw1oLXCdrquIrNGNQKmq9m8RxZQqM5l/d6GGuXuZXJEwf/+qzsJYn68YfpwF3fZMuJ43TYkDS88pFL/2Uh87DM+QoBmUqcpeaR/li6AQAgPAbY5+VH/obscZnNdKGQxInwTzkHAN0jajAPMyqpEUbWgAusOueIUugkCQyYys3WW54nrrqUw3RV8Vlx77u1LxC3SwDy263QfbYirbfdxDZOks+zLpct+HIynzZKhYx/E8Ftr0+WauVtPS1HxCqU9JPV6eYPOCiPgfjCsMX9d7kQTRPBFua5J0xcw6JiW/EoI5wFkzsMoJXbsRTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNOFHbS9PIP7DoLaNs9I46qc4DW6w455K7A3UBnwKLQ=;
 b=Piib4Rv1Bygjzpc5YKyVr0RA/akwHUMxtYBOm3YnWYwRKXLlZxXX/OYW0yxkHqnK+ZWKMcjfGd5Iqts1D3HDeToFqVohWXGA5MPjQKNlhr4uGH9l0L2oLEh7euA+n25XgNonyGS2XsG+c0V2OcDr5OZinojao3riVLrh8fe8r7yWkJv795eqv6DzlAUw6v5Sofvu1KB3ef4hplXMALu5JVkwfUhkKLl1/Wd6WVwqC7DyoqnPseS3NpinSxCYYAP6af6f2IWowmBSl8ouNMLdQmgRime1vr6vKbJc5JgmE0JBjmusKOTN84baTk+xx+fFRbWfjDoTMkg6VKlLMFltkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNOFHbS9PIP7DoLaNs9I46qc4DW6w455K7A3UBnwKLQ=;
 b=HQqug1cs7fVrYKlyIVvKbRfSulNoYVsJtrqCU9B+YQupVxoL7MULsQjj5+Nbj9KH4PU+EdMvQXwgAjVxZQpZ7HZkookLZ1nE4RNj6Ybd8Zv207/Duqjo8RCDLeX2FzmXztfTWuWdrStazM5SGsW2LtE6gGQmaJSE/Ci9io3fLw3F0a9Eq1kK1xie12Y+k3hxwLt5E4CTHQUGmxH3m/YFuw/z/09Da9c/Tbje4w5eqv+UHS0iM6DfDilhimLaF0SFvCZYiw6Q8Hv6jtbRgbnCWFjAZH5A8idEf3prBgSXhPrEXHuccwPFHUteQb0EGU/ra4vR0tUI6qhFuDFX8nQz6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3179.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:11e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 08:04:56 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 08:04:56 +0000
Message-ID: <fd7c1d48-bb3a-448f-abc3-108b5c573783@siemens.com>
Date: Tue, 17 Nov 2026 09:04:54 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [6.12.y-cip][PATCH v4] Add SECURITY.md for the CIP kernel
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
CC: Dinesh Kumar <kumar.dinesh.h95@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3179:EE_
X-MS-Office365-Filtering-Correlation-Id: 217fb4dc-e21a-4a10-ecd2-08df448177ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261022105027099003|11063799006|56012099006|261021121427099003|10067099003|261102123227099003|261026140227099003|261009223027099003|261026121527099003|261022075727099003|261022113327099003|261028144727099003|55112099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: doDXssNq4IysqVLhrlo/Us8bKDTgCPaHcpgLAiM2OCzDNKlWl8mVuzNjnRMEeE/uNpqEToaO4KDv/QAhA9olaayqMGAJ5wE+j1Cnz0j9880UooKzfztWU3lEa25yXiNBDNSHW0CaJKMd1URIXm8/e1qtzais16pkHxYFPk2HIo6zY296a6DE4zvr61SMpjBTOKrjNguaXkyXuGNa5amNy7o4NeChb8OjjaAtaOsYPcCsmGhyJ8yvBLH8ouYQyeJDZcukTDjmNN/EIolifqJZQp0F8SdfxGWyRTJGj891p3xN5YyBGPUAMTpcb+MW1vbCEJ4N8vydog+2sSnNPToi0YRep+PqJPHZm60MJDYkXKDgKd2oQHSKh9mE8dXMdqWie7fV6HSMsea3LOLMVXt/0L/TP60VlkWejkcne30VdLtz+6D5nyCZZMpaRiRC45/d9JemJhAL512a7AU3V/+/uJVIYg8kMXnoum88Eejscscw3V9Yc0Q362KHdiCqsQqaj5hLoWV/ld9qrFJGxVo1IourLjrvoPlWNeqTXshPblvV4mhZ19HNZm0j3HuzfpWH57nnndwDNdufZJghBxLZ8TJpV1MYSsqkODjV7j7AC/0p+2wR84CCjsTk0l3p5Gn6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261022105027099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261009223027099003)(261026121527099003)(261022075727099003)(261022113327099003)(261028144727099003)(55112099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MI+Ak2I5ww561j8j4udF/GqKOXJZhiBnBbDurLc1ZkMATR4aCu27FWpfnPiA?=
 =?us-ascii?Q?HOZt7A5OB4CV9lnmnjB3F8xEXu40LnH//4c32M0NHU9F/LoF/deCzW00Ip+q?=
 =?us-ascii?Q?VO7DXW77qLHrP/qfNtI9oP2gvaVyKhUFxjDoHg48pz+bA/yCCS2JOphhot6/?=
 =?us-ascii?Q?TcbVdHZi4uXuF0adQQPlLz2kEtfu5hjQlpbKwbyJSAJzWnwHvGXblsEAghdT?=
 =?us-ascii?Q?QAodiux9Kj93pf9ohhtimf4qjQpqZQQJASQ5vP8KbyAxVNyRHLArKIfYAggl?=
 =?us-ascii?Q?FzQ+o8eyAaZeXlnIRI2xLHXIhGrXwp/yuMAfxrxYoSjHZepQtj42O3BaF5up?=
 =?us-ascii?Q?MHxK7fH6x2k/poU47vwgCrDioOXPu6meZCo8Xmq3whvuZilv2K6VqjVvyctM?=
 =?us-ascii?Q?KHbD7H+LMZslRP2FOp/A+SckQTIBqPV8VtGemDm0q8kAx7XcCWKuey6xW8z1?=
 =?us-ascii?Q?UoFyEHcOeYmK8xIOIrySbX2/nhurvIPt3jQf6b+G07hBj8fCDsMz5iGB++Xf?=
 =?us-ascii?Q?OkyVB99ZRM1jRbdLnT4+4ErWqHYcurEqrKu2jZidtzW+BXv0JFKeyvhaxxLS?=
 =?us-ascii?Q?H1L5mYVUD+BHSKhfLkS1e77RgNMWNXguKDXlmvsA8ZAImGAVoFpdgg7PODqT?=
 =?us-ascii?Q?3f1ANbyr4/pGnKg72FNETL+WNTSrnGMETnzNZzx8Bj9oDFjhpPYme1nKLRVY?=
 =?us-ascii?Q?Z7ZiJtYv3ZJcMZ9AZpRcqMlbv26XMARUDO7blma8cdKwBtN9VznKnoiXNJWR?=
 =?us-ascii?Q?D/p1PUamISMEsx+mQPJYyGjGh3H7eaZ3vQPbUW7FJ1OWz/H1TZ25TNL/Vv6q?=
 =?us-ascii?Q?0Mo79ODqmdXHbMdSmXHrB+qEuQ7hOZBIyrUgTcI0acDbcB90H52GjAQ/eDZW?=
 =?us-ascii?Q?0ROtKD0N5NudFxpEtl0nCE3fch77+WfNVBPyr5bB18aeS8fo2LGTf96JOJyp?=
 =?us-ascii?Q?loHCmNR5VFXBTUZ/6q7CwIC67tdw+S1YK48wtMFtJPWisCxa4EXJgvROOJ2i?=
 =?us-ascii?Q?/hJj5rpQPzfZGeEwU8v2YEljYQKQFH+hVgpkLPx5jVb17hcC3UBy7l/oggXJ?=
 =?us-ascii?Q?MVToVuLvaAbY78ZYHRYsV5cTFdKxy/+169tDE0Ttq1SwtsPKC2IPa1h2OYLP?=
 =?us-ascii?Q?zqwpNJF7vVsjN1V53OnxDoQtWzrPio4qdyis/cFTBv/CE3k2M6xj64qhCpvK?=
 =?us-ascii?Q?/qESdpPm9ulgo4P5g7YACJ8Tk5i4NWArFvYvaE+pcN8QkrXw2UddGQLJpd54?=
 =?us-ascii?Q?6AJfe+/BynjqLQccLMSXXm3qjsWNhdRD42QOFSLaVyF4wfozRoFVA3dZJmGr?=
 =?us-ascii?Q?ak0ulc0tq/u+hEFu/Jfo6xZJc93svXOLIfYqiQhYzs2y5lcyvc6KCQ2y+U1n?=
 =?us-ascii?Q?flTbiHtcJA9Rctfvb7zg8bZEs9MdE4PSRCfPjittRFZDaH2Cv+T10QaAHuO7?=
 =?us-ascii?Q?KDFDirx/ilcqFIWK0YJrbP7jHSsrj6VeaWxj8YIbbmuVvEbbMBkcD0jMjUa3?=
 =?us-ascii?Q?4WCnv1w6J3f+INrN7HuIjq2LhKvuwXGiTrdj7sT6LpX0Zai7ByQeXZUcvyJi?=
 =?us-ascii?Q?TGQGuYiW6JjgZGtC9RKT6419VpjwZb5kiytj64ukC0OIi0aVQLfVnywrKOyb?=
 =?us-ascii?Q?pcwpyytlGjqv9jwJj5UHXZeuMIUekkPElyQ7DjhGcJBuNdT+HpAG9S+YH2Du?=
 =?us-ascii?Q?5cy1KBYUcNLXDZpfdUBzEy/4+coEGniGr9ygbJJUHQ8fZ0wWR0I7WM/xWpDy?=
 =?us-ascii?Q?tgR57C0IhA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217fb4dc-e21a-4a10-ecd2-08df448177ed
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 08:04:56.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2eqh1VGA14doXPaRhsXdr9YGSNkCmgAypnVNcgU8UxnPWz27VaEqMZl5MKjr7s6CqAXSVd/u3rJ2uZAkWPQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 08:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24820

From: Jan Kiszka <jan.kiszka@siemens.com>

This describes at which time which areas of the CIP kernel are handled
by the CIP security team and how to report vulnerabilities to it. It
furthermore states that this project falls under the LF stewardship
framework.

As the original kernel documentation already contains a reporting guide,
leave a note there which one applies to CIP kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v4:
 - fix typos in commit message [thanks, Dinesh!]

 Documentation/process/security-bugs.rst |  6 ++++
 SECURITY.md                             | 37 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/Documentation/process/security-bugs.rst b/Documentation/proces=
s/security-bugs.rst
index 56c560a00b37a..7b38c83d932d6 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -3,6 +3,12 @@
 Security bugs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. note::
+
+   If you identified a vulnerability that only affects a CIP kernel, pleas=
e
+   instead follow the reporting process described in SECURITY.md that can =
be
+   found in the top-level directory.
+
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000000000..c67799cd54223
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,37 @@
+# Security Policy
+
+This project is supported under the Linux Foundation CRA stewardship frame=
work,
+as described at https://www.linuxfoundation.org/security. Security
+vulnerabilities should be reported through the mechanisms described below,
+which we will coordinate with our CRA steward. For actively exploited
+vulnerabilities and severe incidents that may require CRA escalation, plea=
se
+use the project=E2=80=99s emergency security reporting mechanisms as descr=
ibed below.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyon=
d
+what it was originally designed and also secured for. Therefore, we descri=
be
+here what the CIP kernel maintenance is particularly covering and what is =
out
+of scope.
+
+Unlike the upstream kernel, the CIP kernel is maintained with the focus on
+architectures and configurations defined by the CIP project members, see
+https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabiliti=
es
+found in code paths not covered this way are considered out of scope.
+Furthermore, vulnerabilities that are affecting the upstream Linux kernel =
as
+well are in the responsibility of the kernel security team, see
+https://www.kernel.org/doc/html/latest/process/security-bugs.html. In scop=
e for
+the CIP kernel are issues caused by patches not found in the corresponding
+stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
+missing backports after the corresponding stable kernel went end-of-life.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public cha=
nnel
+(mailing list, gitlab issue etc.). Instead, contact the CIP security team =
via
+security@cip-project.org via email. Please provide a detailed description =
of
+the issue, the steps to reproduce it, the affected versions and, if alread=
y
+available, a proposal for a fix. You should receive a response within 5 wo=
rking
+days. If the issue is confirmed as a vulnerability by us, we will request =
a
+CVE, publish the fix and give credits for your report if desired. This pro=
ject
+follows a 90 day disclosure timeline.
--=20
2.47.3
