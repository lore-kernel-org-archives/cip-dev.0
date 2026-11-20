Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Vk2Orv1Y;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvsx9SD/7lG/5LtxEq8FiK0FmdXyPDYBSi3INDNbH3W+gGWcM5S2mlF5OYm+/a3YO80mDs46RfgCkqbaupaMb44DRK6jXQ/qX4xx7FV58k1LttNtkTa/LT5HJD0tKX43+qwXpFMm/vlQ0rAWlcg6dRXBXnZ99SVInYQKO2HDIxeliuPH8O5gQo9I8RqTGq2c2dO2k8m/wdaISBB7LXJjkOcP4A+j2giY2A/Mnl8r7J7NGyrNs9D0rGLN/culPG9gfcjLV4HctqtvNMW5vATBxyUwL19avtCl9uevuzsKnIxHicm+YkspHU6ZYcyl233WalpWwpcGwgniTgAwIgwz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGjx5a6xUwr9l/L71ubOq/bIEAETPLY+E7aWzONafqo=;
 b=a5rK8dAnr0yXigmLK/UXCgWyP5SfyIg3QoHYuQTun4XztBrSMA9Kt/U4pzT1sWY4WZRaA1PlIRnNbum5wsBFBTK5eDr289KCH22mzuY7f41L6H4BHh8VuiCnUFF0Zld55G4klUnL1935igJRH1dzu1rz7rJhqNBW5NJe4tlFzGa30T69cggxXL3jhc5N3CXDfRqMt2Q05ayGg4ZGwRdgYCQg3F5xkwiQtpMbfF39jCkDCCPh7NAmn6vyBOOOj12m+qv3FbpfDXKJ1PAoZ/FTZRbqTzUCKmWlKuvOwZ/3feJ8GfTvgHRGg7g9uLlad7JhVheH7ml5A4Qi9GWNc3S49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGjx5a6xUwr9l/L71ubOq/bIEAETPLY+E7aWzONafqo=;
 b=Vk2Orv1YQB/J98r1s297Ef1lUFYLWsO57pGlaCO91egxNun+NVV/548BLgXOXcrotthkXRl3bfR4zFIK9cs0x/fBzIngOpG2K4oKMrQ5D7OrM6qUEOMxLJBflAsyaJ/o+vQy/9uo8BXmndrdgidv5LT2Y8fDi69Po7vK45XGl24q6BclYc7p7Oep/sT687EUKld0W8EJkXWeV24iJgD5zFQAc+I7is7HepG1y6FAQSwRd3y0/qAtcZ2p8jiDFeAetAgmFVYvoIeB4ngU0UfbjwxAizZ8AZ63wWeocrcCgfxt+KY1f6UYY5HBhZAsU7+GUC0N9IqHhuqJUfolNkegCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:02 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:02 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 1/8] scripts: use apt-get in run-cve-checks.sh
Date: Fri, 20 Nov 2026 09:25:47 +0100
Message-ID: <20261120082554.375548-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a02bc92-b234-44d3-0cf1-08df46dfe98d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|261102123227099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tWoGp/VnrcnWBRKK7hoYqiBvirZMptSmzgVjdMTA6GQBcu2hs4RXhsU6Efn27jkGNbdvXjCmBkaab202lgLqDKZeWcbi4VRhxhSWd9QI7kD3bjwSZFqsbzqgPH2EuPzly4mOOoq5qf9KIWonAAGZ/AY2w9auARp+b7rOlaoJK3Q5ZC4T/J0KIPt2eu2AI33XEfX03fd3IMEYMn4xJ+MG8BqlpciR7RUkCvjjLIzoAA+gbJiY/fmXPCUCkvIjtWt0zNqhWWD9RwDHOTTQRbJdzvS0sQRRd2E5jLKG1y358tLmc7pk1Sx9opFJW1qfC5Fkfbf0MQ4m5YsFObXl6kdHTCSoV8mgSCyrn9s6Mz9RgC2IpGgcj05FLDgKweJL+d7yQfexqKQM89uwf00w0Z8rVxILp2iWVEP1o+9hYVttQGwE+bIql13PYg+ZOthg24USFIUEQ3UTPre30BRR/kdZbzHjskKs446z8pMnXCTr1AeZ4bO3D5GfgmZbZoBONj3N5M08VYnN4fbFxHhGaL0Pfc6CX/VY1OCCHRDZoq7gfyOWwj3ES9LI0gS+symjaQ6rrCliSpj2m6xalHcBNhnJa15XJOX2D6YxTgHNTcm87hCmcZYAz02ciowHh47JCMwnfEpi7pDIChwCnT7aHQflFus481fQSygQHp15mZKXLgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PwtHSGDm4Sc1dLELnIOxLX15kYjiGM/wIxpiJ90bnvwFq+t/aBkDaIFFQMM?=
 =?us-ascii?Q?DClmJNs/9lkxvfHOXyTYLmedC6GaaUaIlT6LSYfWPmGKfGH9DPluAgYjFnYb?=
 =?us-ascii?Q?kN/cddiTA6vbOYLAwkc5SuOGiGbbokgcnskubzmS/itzWpi0CYPu7hSbx8zJ?=
 =?us-ascii?Q?ZmsKOv7AA9kUJ/kD9Lte0puwUGJ/+vsBlp+dV0H23/UdmmfcP2GsjfjexAYF?=
 =?us-ascii?Q?bmvB5VMgWkJ6qCaupyI5MVlcvQjmrNpXOJ+L3CKoIkE5gKZdRhLDYeEjrN3o?=
 =?us-ascii?Q?Mtk/ANbJqNIlL/c0AARwg2dKmfBUL0y7zCUQhPKVNwwgyqGWbM60VlGunTWH?=
 =?us-ascii?Q?EaA4Hv/u7Ez6YlqoBHkQbzYGANvLuLPanzgwCT+m4VXyt+RQjooyGriNS7Qq?=
 =?us-ascii?Q?cVOhPZGp+fyjqRiSwJrVJ8Odmap2/D2b0UxtUk3yw/+GOiv+XIHx1v/5zQuI?=
 =?us-ascii?Q?sNf99UnCAmRzYxX6BC4A4ALXyB2i3wMAGmqlsn8MK60lZv+FvG6PLgNXmdf+?=
 =?us-ascii?Q?9xq4dP3/qSmUaCjVhPDpLS4Zv/1l7HQ0/Rjci6KrRQksCns0EZnSxt8v9OPj?=
 =?us-ascii?Q?0eWBYOoNg0pALMfPdgheQEXfBYctYgJkw4sJUmrxMoUbCL6TY4wR+W/cn2lj?=
 =?us-ascii?Q?eiLxwy+LCk/ZOgdQpSgccxImwGqhw3dNYO/f9j79A9TLCl/IB9wR/xZCEAfS?=
 =?us-ascii?Q?v/RSgVPHJMJ2Ug7n/myhkxpXMrDBHx4Hr4N7Ro4vzikgrMh6r4L9X2KsQVDJ?=
 =?us-ascii?Q?6tAi86AW4AEecix2+2RH3lAETcjFJ3lpJ4MccTafLB3O/gbYi9+Q5J6OdPGX?=
 =?us-ascii?Q?DrzU8EHjDskvQlvYrnGgWYu4RMq51UxHaJj+rOlYZWRESI1zVsxgsCAyF9Kq?=
 =?us-ascii?Q?L6oRmkT4xwcHgBzIA+t6K/2cOE7gWHXKbcT64iRrgMf6PYFdsMChpdDIRiA0?=
 =?us-ascii?Q?EHup4yaQCsWKA8cODwboju4dQBJxavt1FQM9KFDPYZIo5hFAMDx8h4n/cjEk?=
 =?us-ascii?Q?/L7lHSC18hZq+QBPgXw5D5mILEeX+j30SRvc9SJPqEaCoSs4cJwk1qAmm/yC?=
 =?us-ascii?Q?+kwEt5R9NtPiML3cqyrOptz3O03hpfAMeX1rmtGfFSbYvXcyMhf3Evo5oWDP?=
 =?us-ascii?Q?qdMrWE6CefbGipm9AjwxWkWzRucn9xhJLHgk/a+AnfsGM8ww3rHqbWqMsrsN?=
 =?us-ascii?Q?VjaSLOApXlYYno7xJ/jZAizq0J1BRKd/REIez0h+rPu01dMLf82vy8Nro1B+?=
 =?us-ascii?Q?kMVv0Yi5GsCz5ahtnEvoM1BljR+bY3coD+ORAFzmwdVENT9JMA9NJQBGU5WA?=
 =?us-ascii?Q?+stOavyPHXSy4L2AfQ9nmSebtKzS4CnzldLkRSqPocLA1L6JeS2zK7V1529Q?=
 =?us-ascii?Q?b9jYA3/6inkGRLP882Olg5/b9Hc+drqi5kFmtJQXAzxmSJ+x7bWX1egG4pEa?=
 =?us-ascii?Q?lZXGsPYq3CTv31LgGs02XwKSuOXkatDc4WLdWy59HVs3L9NHhvmJk8rz953H?=
 =?us-ascii?Q?9aZvDWuKjUi+Jrrux1OGPcHEL9Lc/fdGRXDOqfRgPcVyVscDsAmtlHv+flM+?=
 =?us-ascii?Q?2+9POk5X7AHauPSEWXb45Xou8m9qV9LfRDBW4buUEjMISoxKHxW2rsH5zFPz?=
 =?us-ascii?Q?c9sr+NHLN17icY4X6NJYDgYjp0iRqQs4/Bb5+QzpqUT0vondeYrPlFfJI3T5?=
 =?us-ascii?Q?JyHyGOd1wv6hi0wuX0j6ThXBscJDG1BfOwDIBTkjYAqZhXhdo4EWsSzct3H9?=
 =?us-ascii?Q?dhtGQTa+DvvHKzexFGk76lX8mkXQ4Qs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02bc92-b234-44d3-0cf1-08df46dfe98d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:02.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnFpJ6dHQj3ERp7mWyLmMXSOVzPtC6sMllbacSQp3hZ16Rf+T8zGqqD/4rTJ3Pk4T0kHo6Dxdn+OzsTGIlrKrLNcK8vmzLUPZI95yfa9q+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25028
Content-Type: text/plain; charset="utf-8"

apt has no stable CLI interface for scripts. Use apt-get and install
both packages in one call.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-cve-checks.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
index 12fd74ee..12efcace 100755
--- a/scripts/run-cve-checks.sh
+++ b/scripts/run-cve-checks.sh
@@ -20,9 +20,8 @@ set -e
 # Install AWS CLI
 if ! which aws >/dev/null 2>&1; then
 	echo "Installing awscli..."
-	apt update
-	apt install -y python3-wheel
-	apt install -y awscli
+	apt-get update
+	DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y python3-wheel awscli
 fi
=20
 # Retrieve the latest dpkg status files from AWS
--=20
2.47.3

