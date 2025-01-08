Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81E4E77188
	for <webhook@archiver.kernel.org>; Wed,  8 Jan 2025 10:09:00 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.55])
 by mx.groups.io with SMTP id smtpd.web10.15503.1736330934114922276
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jan 2025 02:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JNe26K+i;
 spf=pass (domain: siemens.com, ip: 40.107.241.55, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEKvTPIvr4rCrazS8h35/b9mbhtH72LUvdzb05AWpVq/uFBNH84z4WjpLVuRgMQdE7F7/Tt2LlZtr5mtWmJlemZp45NMstbrH6siyXVmX+g+bpi1MPZI+i3ymoTjAOczeWbano1hnkQ1Bbejq9uBiI2V2j6dg4qtxvi04sCg9Mpexh/sKsAryP62a0xhrZc2ZfsMrt6OW07FuV7S1DppjjjwD46HDtcExKjrBuzio+bHBpGcnkAOTHJxsK0iQlkB++8cNT84qiC3OSl34B28iPb9GFzvFnfshS/RD8vJ6px0HL79I4q2cAXq+xXNWSQZVecYEwpV3dLyrvYJ3mWQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9fNshsDJBGzrundICC3m+8w2UyvssNIVZyFvbO0GAI=;
 b=iiULd7UdEU0YywaqCJLmEqV3f3xdCoGh9f4tCDHpQnkEKGq5RfA4gtaQYpRNXHAz6cRnA5qYyNcsOMGMnRd8eGPTzqgAVTKYhYEqHxbFBn/I7sM6uePucomqbYUAf+fG5gsfF6rhXb+XHsmeig+kdqFvSsBIoY6q6cJAL4buIj2Mfv7f7j97ePWNX/df73jLRy5TeLxGvcRglCiR4gVRuknzV04eQhJFlAg6wsEhJPZYNpCyeJTcbUix3l4cnJ+7lBvjrghbwk4bsM2rHFFec49VSEAux1ebZlwnGUwNHKQpKlcwk1hUvB+ezhq8mIRZ8WMVCwCamEcvF1qokpeW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9fNshsDJBGzrundICC3m+8w2UyvssNIVZyFvbO0GAI=;
 b=JNe26K+ikaTIQvv7nlaop2FG/Z3PvOUEyuPFRga2eKu4IDU1Ap4OA1Mlid5jnRrUaY6rNv+cwTvdhQWeksIcYG3cfEOZ+mhbYeKaF/L9oy/2tQJQuH2oi0cOextCfHFmNPZ772m+JgTOh4+EaxcbIN62qNT6qy171OaEPeEoq2XhAO3w6e+ha/91EuUw/cowwtvwqCmKG58/ihJhQjx+kUKAN8LTj8H4f3aiSZVR/ueux+nliMm8Kvnl6b2krCRnL44WKtpvHORgymyAHO0ixtKe3RuBWJeohZhTd9TooOtSF6QANeHMhc4PeXY7qNFYqB8qHFvk3fQ/YLaqi/iQIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB8PR10MB3257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 10:08:49 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:08:48 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH 0/1] linux-cip: add kernel config snippet for container compatibility
Date: Wed,  8 Jan 2025 11:07:54 +0100
Message-ID: <20250108100755.55673-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB8PR10MB3257:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bc8f16-b9e7-45ad-a35f-08dd2fcc71f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jt5mWNc5n9FN+WmJZiGt1vqWxX5YqWMcZKaorCIGYbrIfPRPEUaNMjSuB3ob?=
 =?us-ascii?Q?O+CRAY9VR8OrqCHaOYTMaP9vznVe3LfpjAzJC9SIkgj4+sao47hluDBIuYOD?=
 =?us-ascii?Q?bOXXXEtTmgWKUCsYMdeu1uW76I1QfsPtFHs1CDFHgO19FvxWRUwjkBpZ55ig?=
 =?us-ascii?Q?38zD1G4mKg0/ujMEmjd61l/vWN9S+ZU6ceyhKMqePImaUYkAHlG6S5iVjBY6?=
 =?us-ascii?Q?P5Ws3X8QcPqcnHn8DJMyAOsizwVxTnzzW7/mq2y2X6/WpCcyqydlikb5QCat?=
 =?us-ascii?Q?OHXiLi0Q03W6RW8uFa+clPMGhe77Lujj77M+dIExtxpPuII0DQvbORf/XUNa?=
 =?us-ascii?Q?dTntyS9jOhVPPRJtbwYPHON2WxXDIGtoqFzmx/7rwWytSPVHR8QNFy7PptT6?=
 =?us-ascii?Q?cQMaVec8N0BtinDhDKxl4SQ0uNUxf56iuTFHqDMYfUrNkfzal5ihvwDxr/w/?=
 =?us-ascii?Q?n5KkiZ3vijqGEcov2WRqrBsDsD5NkI3FDGEP6NM/g/oyoPNtOUB++7I/36eN?=
 =?us-ascii?Q?q4MWze6VyGDNiymvVieCkBsGIXWEZSTp7ej4H04WZ1zXQOZS6cJAxQoTFPwf?=
 =?us-ascii?Q?ZJsaEn3PVa/ZnUm4tf+GZ32Pd9OBcySHYE9pWN24D8gG89M/jFsCKnxKFTuA?=
 =?us-ascii?Q?f//56KPkdybBDZ5ld41T6oWCZ33UP0Yg7DaVuK0T+OADfs8tF+Yvb7KTCDpI?=
 =?us-ascii?Q?iIR2ty5LiMxGHPv5i7Si+uZo52bnj2AnNFQGjYMR0+uGbNDFz2ughVkzoXh7?=
 =?us-ascii?Q?LDJHXABUuawn/pNyD9DJVKqOIi9l3qixeg4TYh6BfJgtqa/l45hhTs0LWEh/?=
 =?us-ascii?Q?1Dfzs64pLOI00OeBrsnayXmIfZLIBeWwfFc6bAQ6NRIgvJmg+iqn0JwleVMn?=
 =?us-ascii?Q?GRgrZLePLSbK690K5GqSt023hb22rkoGuPNP8v9RsFfWnabuiM9bbz3ZV+2A?=
 =?us-ascii?Q?XwrAnIkfPaSkWc81oQsUM4NeMKnUyPNc+Lt2zdcuMPfTm+K9idLw4mGPPEDY?=
 =?us-ascii?Q?OddfllQnQI32zJg7DvPInaSoPekWo5r7ktIp2NXnQPRYt6+YDJsE3UNp+mA8?=
 =?us-ascii?Q?XLIFdDfIUaxT7Ynb3jk7U9cSGUHDEggMj2sPZAeUYsdMishjR31bspaD2thJ?=
 =?us-ascii?Q?LAa0qEVXm9ZxVKeKCJ0XEZZXc3JZR4SSdmon30LXHvqjmQaOYGNXuB2m8mHx?=
 =?us-ascii?Q?URLFMHJMD59DbhD4rjOH9KFY4Gsa8UYCpkZoVRNJuNoebN2jjh663JYDYgYm?=
 =?us-ascii?Q?LQHflQwy1wg7+LliTAjyXjAj3TULgigqRpmlnuhBVup+pQsTO6UMv20h2anP?=
 =?us-ascii?Q?3Cq+maCZaoExZy2bPGbZtj+DmXXul7fUa0BSOB63Rvu8a0SP1ePMDCVO4M6R?=
 =?us-ascii?Q?HDn1JuLXvPIl5q+HNpoQSOSaoG6q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bbYtWz9fHywJg8TJ05+5KKShis/PrRRR3Vt8WO1Gkj0oWWKyDiAvQHtus0OF?=
 =?us-ascii?Q?t3deR4YsXjVOJwze/QmzY8PjVW5zEU+dqlzHPdSwSDyoJXEyqqkQDVWLgY4N?=
 =?us-ascii?Q?Isy0mX63BZdOkLcbQT6BkJsaZA6Uzfq2E/61mVEIrcnW2REOIKltgDl+rGN7?=
 =?us-ascii?Q?P8Iu9iOhwMs7Trxfxp8VfXKT97h4Rcy8LWR+17LC+0oYA0T4xNCuqDav8WbE?=
 =?us-ascii?Q?04E/BYWDFdtrOz9a24cIZ1RI/bsOG60inDSlNkWwjjJloze2gzCxTmtP7Uxz?=
 =?us-ascii?Q?+aObFb3h6loBtHCQzCF6Nx/zvuDYEx3TeQzb5ddt+rdNz3CeiA4Dt1kl1RZs?=
 =?us-ascii?Q?wMtd2x5KOrC8YA8oWa3UTtQMCQb5UZOfPbJ8O/7XyzqL9bd0t3i65Yq//30E?=
 =?us-ascii?Q?fU7/ySHigGS0dddd0tYqH70dJnBMb78nbUEX4tuIsOVun67jJKDLWWalK400?=
 =?us-ascii?Q?zW/gt1FNo/22m+ea7WR/gxIzzd261lq525Sq8qj5Eh4JngcXctDVLRSQDj4k?=
 =?us-ascii?Q?EMCd4KzRmLR+8SFXZKl4VrGzWBZoIjZO0+61pp6WFBEkEn4KMnnaDSk1meIl?=
 =?us-ascii?Q?8J616ehwuGHlKHOOUldrLOABz2zjCvJ0DQzZxqPprPUp417LU6W9Q2TT4KPM?=
 =?us-ascii?Q?ZfIVD/9oysWjSLjGpvDYiJhW4gpxbGbTZAW8PRPnIT++txrNjBhFrnWBV9kE?=
 =?us-ascii?Q?vWMJOE/CyvdtyMtHpPfKT+z3usSzv9W3pB0fdFyQcmS5MYINyZNZySK/fglC?=
 =?us-ascii?Q?sh/9CQcmcFkLeMlbNYcsw+bUg7Ta2GhowCfnxl5/1DTsa9wKdbPnidBenJ2E?=
 =?us-ascii?Q?+sEB+DeFL8D8n7ubE6u84Ev+l3lEGBsgKVUQmIfIj2gLRmpTrCt/IQU1YTD+?=
 =?us-ascii?Q?bT74ycJ67tca5BM7iW4kspaTaxFmE25oIMgsO06CE7nrCIxgNMlu57f6rb8e?=
 =?us-ascii?Q?SwvV7K1l1v8wKltoR+5yF3Noomp/jo0KBupRa4iy0YNiS+LSQjOdYAHg+Pz2?=
 =?us-ascii?Q?1fSWvGqGrsTNlfoyyRUziUg1osTP9lf9j7O1sgUA+QXHPQBi/JjHzLhH1TpJ?=
 =?us-ascii?Q?obVuRkt/K21bsCfMhxp1hmmwAZGBNkFJq8rkbDuCb8RTPcE2rWpoR72lqtY3?=
 =?us-ascii?Q?g1JpYjNTyC1c9SVgBBA1KOAwS1KqPqjMTLVA6NVa0JRj9umE4GpVR43FBcRM?=
 =?us-ascii?Q?WbcMbcQ1133YEDUPG/HuK0rVQB/2ipD+mw/U0osX5R3jqfRPO3XbkD9KvyFA?=
 =?us-ascii?Q?F/ICtc5Ey2/q9KWIdWRzW4suAbUNMBZmDbNzbiID8bNDuYoqWli1AX7u5JsW?=
 =?us-ascii?Q?9oE9KhB6uOwH18W1vhsKI8b/qX9Adco3zv9bvG2Vt5jVqLXDtboYtsHJGpLE?=
 =?us-ascii?Q?6p5Q6pW8DOlTM5uWTZ50EJuysPIPuBay8RVSUvkvxbJMzI4bNJf6cVGB+D/p?=
 =?us-ascii?Q?0TvbSW5w7MxfvIA+3+ZNR3BXS8H5hZcUQBFk+pSdX0SGxrx1aCR9QoK12pKp?=
 =?us-ascii?Q?SUSpo5aYQl1R++x3UIVrRYSKxHEUnHvPy54IsHg7jODrB1pol3h4a5UW8u+v?=
 =?us-ascii?Q?zxNFN8lITKDbu8LMXy6vpb53LTle4HQFVWCO4/JmJoWWU6JGp6FR6PBi4qRa?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bc8f16-b9e7-45ad-a35f-08dd2fcc71f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:08:48.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxYWQW/Dmg6AoHaCdNJXFin9p90+A91letxuBnhDgDfiV9H3oxRbUEu6excERZsNj4UsTDOM2BcmXt0JxvpTslpftaIN1xi4DQ006wMmg4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jan 2025 10:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17505

While the cip-core x86-64 kernel configuration includes the necessary optio=
ns
for container engines like Docker, the arm64 configuration does not.
I have identified the required kernel configuration options to ensure
compatibility with Docker and Podman.
Instead of integrating these options directly into the arm64 configuration,=
 I
am providing them as a drop-in snippet to support custom kernel
configurations.

Note: I am open to feedback on whether this should remain a drop-in snippet=
 or
be merged into the default configuration.


Michael Adler (1):
  linux-cip: add kernel config snippet for container compatibility

 conf/machine/qemu-amd64.conf              |   1 +
 conf/machine/qemu-arm64.conf              |   1 +
 recipes-kernel/linux/files/container.cfg  | 114 ++++++++++++++++++++++
 recipes-kernel/linux/linux-cip-common.inc |   5 +
 4 files changed, 121 insertions(+)
 create mode 100644 recipes-kernel/linux/files/container.cfg

--=20
2.47.1


