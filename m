Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=OzBYyqrF;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdWU7Gu5D1IF05zqbVPx9dJeppV6YgYUkj1KYXy2GvwnZD9VjMmvP+c+K3//4fI34xYBxMAJtZvBiJumTO4pv1WcTxRhO3Im6UI9DJ4zw9+MY21QdhsKSLQ3Bmb06rkAg0r+cRdHQHNn+ubSPRW5WRqw0ZCHoCbKFP3gNoqJYWLQRohvcOHjh/a1/JSB3nABvIxsaPdbkcq+AeAdW9wQdrgyg3zd6XRtdIRZ4gj0V2xG29Z4bhROtjbT6q1SOQycmb65dMc6LBRcyHlTyRialDsRIdHjoW1z6/LSRn9YoiiSU+vxpX2CC/lyZx3tjttHkb842REuSWDfCm00DxjATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1ZmbFLbO5GyV0RDBpds8mpdCZSV0Hm5kOmqsH2WmSU=;
 b=E7S7+GvFLI253aC8uG5TQXTMVsg7v9ih+CQl6RpfY3iTriz20SE9NOhxrBCjS7IgGStPITt8u0mSUjqVxJYf6jLdLo3bHlqOO8z2mRZSovooudfB5QwlfgunS17meMRjlREmguyqgV/DFCxg8EAYz9fq70mJDYBnC5pYpJEwiykB2L08FWZScMtw39WJ8IGJz7OasyDDTCSK3ciIbDinJDfT1lcfMAfDOo7xUZLnJwq0DAr8EiLYuqbjvjPqMQS7Yabkb79gfrlpT7VnVKWEDp6ts+nN8wXGt7XuUjW0syZDxBsHXxAgf3CAdpjQCfKWUTJTs/vLS/YPQkkLppQYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ZmbFLbO5GyV0RDBpds8mpdCZSV0Hm5kOmqsH2WmSU=;
 b=OzBYyqrFWtODA83tMAkerNcOD30fysD+8S527ZKpPAVh+bOq6DD8k3JfZWzjiCCA9CC4r7sRzrL6xAt6E1AHHTZPAWwEBz/XWnIhw9gN1szwh8ZrWbBde1zOU2iJW2IVw0IA6rKjH0QDa3nFn+iYYvMx/2xEIZAA4K/W5gHWYXiCQzDfKTcBEh6AThNlGWHZb42h4RVR7oU0QIneodHyPb7UoE6rvG1RwynC4rETzXLEbV9Kd7rdd6w8i1s4rc4MIrwPLwXseTGWIS0xCSEq8+RMqQ0fhxcMnC01q503dx3A3kGzhIvSRV2K0Q/cmc7/Age+3+MajzMg8KO4lhXLPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:31:31 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:31:31 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 21/21] qemu-arm64: double the crypt setup timeout
Date: Thu, 26 Nov 2026 11:30:07 +0100
Message-ID: <20261126103007.2922985-22-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9886e57e-8ee4-4d20-340d-08df4ba86f9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|3023799007|11063799006|261022075727099003|56012099006|261102123227099003|261021121427099003|261026121527099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2I4w5XJ6JDc6w+48bhLJQiErnVAy9LRhX0WoR+K0Lrmw3Bd9p+jn1ARwEso7SBJ4UhaKpZxFGScp/4bY2RcerrVZfBJ9voI3TBpYBpV25qzJkc3PYjiqIonZLdScIiFD7exbESCh1UB4+cLBSTP+Fzsq5C25caDhjI+8JaiZRZ38DVJ3dX4T11N3Js7A/wU/ovhsQq9UXLh6fAiARZDtECkEBn6l+oz47zJe3+XOslOaTUyqQjJKPrZAKjq/TSq55QH16Ng8I0fflTQTrdlXffntSG4YszWnSFLyf7jbG9PyRd3/SIA3pvUij8lIG8qMlA7ke0HGOV5JRJWEXLqZQlf4t4PJ3pVs2t5g5fwj4DdbaCnpHEpq21xzNU/iV6KgrbhyAfcnkQGRzfYUCuEjtuKnZeEzBp9zf9XZRZMsFVGdVxcarPcT5dsBfBYaiI4RzC2Ecxst0nfzwkeARH9PKHLjRrTQSg5v53+WJmYlSOp9jpxEl1ak6SpaDhqN42aDKqlJd0WFVr7K2ShRKsXH7FvR/GPIESZ9KbhVogVCUiSXywyTEmqcftC2R0HeeGvtgj/rimZeIrmTi0FaUUeb9YV5NdaYsKPNiJbf+O4jNb0lxECGw/QOntAElRFEHbhPRR0Ob1/KIZNxGK3PWlfKxx4Do6qoi1dp1qxfn060B9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(11063799006)(261022075727099003)(56012099006)(261102123227099003)(261021121427099003)(261026121527099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h4qczqErMpbma4dNwasoJ8g/ptXLj4fE85cB9SP0GRMBjSOpUUnEzG7nTW6P?=
 =?us-ascii?Q?R9VbogK6x2qKw9axZ5eJvrzXQhtnsirZNWh20qto0IUF8yd6BTswcskGUYab?=
 =?us-ascii?Q?j+L2JmMqq63zbU6/dYXBsrPCRM4T1GeGTEo3GTCV3VL2CNYiv+2laYRFTxhj?=
 =?us-ascii?Q?NDz3uS1NpCWpkVHwOnBolc4xUR9Z3tm8IfvOEIRzNlhH48ejZoBTDtDNTEMZ?=
 =?us-ascii?Q?NWB9wamEid0pi2ijhCG/X4gX01Z4zzaYSy9+GMW6OsOJyO7djB8iEDPNRJmD?=
 =?us-ascii?Q?608LNMWypQGLwDeKI52iWFD2hlIzuQB5Lzp9sehzh2Daey7Sl/FGWI9G/uN1?=
 =?us-ascii?Q?mVNAZhEO0Wa8P4gcBMfl42DvI0GR1LRE7/GMIVth2IzFbxfjc3Jf300/bqpr?=
 =?us-ascii?Q?sKgFQEi/+l+0FtMJlQeOns0yZsqbwBfU8r8NAkJBH2gFxIME30vXi7upV/7V?=
 =?us-ascii?Q?mae/oUkmFTHeIF76jEaWF7CRgzIvzd+zYmXjCfuWwFtXcGTY7rb0HGoh+XTW?=
 =?us-ascii?Q?dHQ8A/W/hrQ0aN6g2e5FXQ2FqYppusuMKkga6wwuuXdsSbC1EzIV6vAQ9OqL?=
 =?us-ascii?Q?giIrEGX4z21PP0QoG6AgQF8OH0OypSwacPxcIwN8HPfEf/LIhYFXzkf3kD8P?=
 =?us-ascii?Q?DoToa1FTItJh49rQsRKHWkdb2aPeOmAGXfw3Uhuor43Gt1JgpfAzFjPGlkIg?=
 =?us-ascii?Q?1DIcS7FDYdbhOBJxvUjfLEcBW88E8dcCojiO0nXmbvh3rLXZ5DUzi5z3QSLp?=
 =?us-ascii?Q?Xkdvjh37liv56041Aeux0l68r1+BlsO66RGyUVIE6KJ++1D5ZvP1biOe3yQr?=
 =?us-ascii?Q?UalH7DiSwWPFGBcJR6h3MTpkljuCR7ovbr1VUwRnThjKZ7YbcOVISLpXyWQH?=
 =?us-ascii?Q?R1ItkzDrFcDmbJii3WtCEz+irWUt7qFp6Q2DPuGsnhOEWX2JmMiJqjHxmJXq?=
 =?us-ascii?Q?PbkuUgdN+SIk4trbocfGF3Pm2TJ9/F0eFWepXAx0GpjdXL+eLZQG826ZhJIg?=
 =?us-ascii?Q?CGKcTg7KUzAsOJBGsN89d0jnlWhrc+ZZnD33x62YeVOYcDprEHOCyZOcUe9D?=
 =?us-ascii?Q?S5q2iRu59OXaMJtUiqaAbJaWyQGYjzyGRhbDkon1SYmssXZF5hquj6sR1gdD?=
 =?us-ascii?Q?BUIx5LlXndkXsAuomdynmzFRW29v64leM8yqb6lbfOyF96JacNJHCLWU7gHt?=
 =?us-ascii?Q?NhjlrWTbEK8bMe88Y21yXxrkhJtfHUgY/s4MefITIWrnib8EK19ydL5zV3Be?=
 =?us-ascii?Q?uJxhMVHIh+xAzv4L9y0jG5n8Gmh9OfWgBamjUyNad5z3A55O/GzRL/B6V4mz?=
 =?us-ascii?Q?2+zWK1G9TeptYu+6pHJZz4+MIrIKcO8PuohJeRuEXOIolcSQAbCRwrs9Sktn?=
 =?us-ascii?Q?44lkLdSfM0uaGw8QlVLnO8UxjKlzYGVYFZbFZZ/KVVaOmViA+NA3SqI55avr?=
 =?us-ascii?Q?G2vi7k1/XJSNAu9Zs6qKPCw9VJwb1Lbb0qA68FVSsksWiK2ca6jI3wT3LWEn?=
 =?us-ascii?Q?ab8mcERE7asp6jrEp5mMqwPqfQOo9h9w7B66QiaTYFVp9cETHwPPKJC4NLNB?=
 =?us-ascii?Q?df3kku77B6X1XvKDzI/5RzjV1CnMuo/90AEsnpcBEvZyvOYvvDf+oZYCDzJF?=
 =?us-ascii?Q?tkzjuS9QdotqCXfFSC6d6n/w7CcexqwZtSQ1eWxJdiz9GYofks/tdkVV3gmv?=
 =?us-ascii?Q?1r+VyJS8qQr5CPpf4+j9BX708MebNZZOwTkhtyGmuLA2XxVyJyMKB4LWXbUZ?=
 =?us-ascii?Q?KBynYFLPHvGDhOvnbIZqJ9YxPqNXb8E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9886e57e-8ee4-4d20-340d-08df4ba86f9b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:31.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D86Jw0/7viSLuJmGmuE4nwTZJTerQ4hn3HaDpvInzWRd060jH34KAQ0eguGW9ysKe1zj24J5mQ1zQ3vw58UrFxtb5n9yqWWy17b43dBriUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25103
Content-Type: text/plain; charset="utf-8"

Encrypting the rootfs with kas/opt/encrypt-all.yml takes longer than the
default 600 seconds on the emulated arm64 CPU. Full disk encryption with
fTPM and dracut boots with 1200 seconds. DRACUT_VERITY_DEVICE_TIMEOUT
follows with its 60 s margin.

Use a weak default: local.conf is parsed before the machine
configuration and must still be able to override it.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/qemu-arm64.conf | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 314d1430..008efb86 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -16,3 +16,9 @@ USE_CIP_KERNEL_CONFIG =3D "1"
 # watchdog is not yet supported in our QEMU executor for this platform, di=
sable it
 WDOG_TIMEOUT =3D "0"
 INITRAMFS_WATCHDOG_DEVICE =3D ""
+
+# Encrypting the rootfs with encrypt-all is slow on the emulated arm64 CPU=
:
+# double the default of 600 seconds. DRACUT_VERITY_DEVICE_TIMEOUT follows
+# with its margin. Weak default: local.conf is parsed before the machine
+# configuration and must be able to override it.
+CRYPT_SETUP_TIMEOUT ?=3D "1200"
--=20
2.47.3

