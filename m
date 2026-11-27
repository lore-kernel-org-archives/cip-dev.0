Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12103.1795765151165944994
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 23:39:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RXpXcovd;
 spf=pass (domain: siemens.com, ip: 40.107.162.32, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZOSHJwLWNvrUKZemqTeay4ntdx5d1K7GkBQxnVSHqXw/ceAEEe7zoZbFrbqPJXT1GPncFl/BOUF+j2vXjcDLni9+NFB5grLZkB8OZLrnHaUBo57lT5stuIznhJMrAzf0PXJ61Fswvg7gjH+QHETspUn80NX6OYjU/6RSD9MoJ6KdgbR2PCPCiGmg5OLa2u8i/VxIqNfH5CzLbeskLYZp7bBLcFgqkOgMMKmmfLY/SDzxrfSMlXb82nUEkHmsrFZmrhNXEt5MUif3Y6nGzSIZHDRBzEkXlLqw0mYxp/+NWokqvuwe/8DXqFai/8HNCjusBy9bza4E/eTYDYy/QJ2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBjf3CA/e4IYavyWuyLIgQRqQ7QaFs5aK+TLBn9+6eE=;
 b=YVQ2PRsiXMnHTEego4Sgmj/vhLS3M7ftRW/VYWccSct95ssQgNBp14+kDh78FnujrGcH7uEJVrkGleQlNej4gx2qFe71OGukZWlaFl7fPSGaFpBLdvkuoFHrCYf1RD1Q9ddoIh36v0k/RSmn7qGlVVvCIjLG9w5yqFoCCx05GzvNXhCEOlSL1KHOr6nZOi4T8zN2NKYL8sRfnCAOU+0yJKocvDGEomOGwogyxIVm9oViMbsDxBnQsPEhP6/iD/kpDm6ObUqrBJ7JjF2g8pcnj2ESLz9B+F8a2Rw+GXIVYCoQ7mGASGrgC7iH56RLc0pgL6nrUtBOmHIFZVgSts+xNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBjf3CA/e4IYavyWuyLIgQRqQ7QaFs5aK+TLBn9+6eE=;
 b=RXpXcovdv1P1s+Nr2xLyWbQU9qG9uOopzaNvLVx0Ux+UNlLaf9/JztsGzs+UKv5EF3IpNW3StcGHbQR3xSNfvMCNtPMBulUch3SQs4pNdXOR04DeoJsmSB8fGfp3qeqNAPVqYBNOctJaU91nAfYypaJBVhVLZY2nUSWHCD2HXvscgR7N9ngplMzEwB/plUUS5AUX5TBO8Yjzf9gTBcEaCXn0FwtNzmfozkPSgHa4xzAsy5Yi3aLn+G74mm+4mluwEum/P5Gm+7P5q8g4PRGpJ2OetpFyrqNqlNJ+9Z1pGCYvo3YLM4Hnt06OLFaBPAZkfRvpN3v4byqebQHV7bXZUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MA9PR10MB355341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:250:10a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 07:39:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 07:39:05 +0000
Message-ID: <b5e136a1-657f-43bd-9b5a-41133f320e3c@siemens.com>
Date: Fri, 27 Nov 2026 08:39:03 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: Chris Paterson <chris.paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Lava errror
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MA9PR10MB355341:EE_
X-MS-Office365-Filtering-Correlation-Id: eda5cd27-dded-48d9-8d33-08df4c598391
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|261009223027099003|18002099003|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|55112099003;
X-Microsoft-Antispam-Message-Info: sklO2kgTlzDtHyaguf/4SN04zp7avKCHCPCKhgZE56TnlOl7xR8us7zETXUUrd9mAiyCWxDoeC98wjAJHRi3u2VXoF0I4I2MBAHsi3Wq6p7SzmCMUO+tBnscryWRU87j6fOHlysva6HsAmuym7kFO/Szy2b07iwbzvLR8BlprpHihxBAzwr8n3QF8Nrg9xj56SXN9Y/424U0p2RBy5bJaKiuPOBk0QaODVI5lHghHZdgBmVLaC7rRZof5EfAQF99OwdsoN7iuQDV+7Dyw6p7CiASc2ez0Ag/g203N5A7lAtaAQHUizegBTOF7dB6K3A6JniKYuajTgb/1uOteIMkTTOD0W8k81kcv+YdKe07Aun8UE4yBHiPRrhLPynxqSWXz3VZD7QRqpY77Cvgb+K+KKg/PnLukJYH7NQa4WG5Uns+gZJbgXspV46qCUu6gRAJkYxHdKaSS3mcMh8I1qreEmqPcZawwcWGF/3D3K1rKplPPYLSzgFlzMA6AfUMFOI/Wk9n8osmulQ03GQ4bq68ao/ybN9PXTcOZ0lbpZ4+43gmdp/EmOrtrc7v3XzF9/K/Cc+VrSKcyeruObRI6d7wR8g7z0ASnmkEXe3dTbl5wXxG0LQVLLHfRzq+yqASRdxl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(261009223027099003)(18002099003)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtrHA12LYxnsUN4YtF05Qn8gXdJt3DebUYYdskb8KdREc/Y7RIzaSCLJas/d?=
 =?us-ascii?Q?ZO3hyJ5VeebVB1fyRykxBOI7Fhv3tzyNZmBUkrVn6VTwUPM0aKl4tpmh/kvc?=
 =?us-ascii?Q?NGBRSEekqJN2nADt9/N/0llyKB/ElJV7iAuUTGgRy9aJ96Kc565MIo6kU7Vs?=
 =?us-ascii?Q?29N4xzQXUCDQBkGgHssLNDCLIYY07L4et0qr3mpXsP6XtUUITMAnx+Ty4p2V?=
 =?us-ascii?Q?3mD2ICwAs1W5EVFAhKez1g7WsgbAZn7J/np+bPFTTkAykHnBzaFDxUTdZNOt?=
 =?us-ascii?Q?D4ulLJT+NK/GIxnKZCTJwjFcEzueCwx1IGkNtIanZ0T8VxUnbYOWfnjp6iz7?=
 =?us-ascii?Q?whrp7NK+iCuJ+Jb7qzgyUde7I8itvMeRa8PXGf0+Gpzr4vCE/qKm09qYCCoG?=
 =?us-ascii?Q?OFLTauD8IbzpprUvV8T4MXwKeqgGrzQuax+/ZB0OjD6hc3EexS89CiE0sUGv?=
 =?us-ascii?Q?SO7PBogZOMlH1dJoG4L8MUdGQVxCUtgdrxcBKgHLpOgz24RDW/lOnAVIgEsJ?=
 =?us-ascii?Q?WAkhSJteGYmJVvxWlNuvTxCsBKB0wNGw+rAYlTgd81Cy7HYBg5eYV6bKbzFU?=
 =?us-ascii?Q?SZO4IMkklw3ZtFnN6Q0z5Toiv0G79nENMQghZhzCOUxTz8cnZX0gF87QDp52?=
 =?us-ascii?Q?OLbPGdV7PuDGKV3dMPXvhOa1kJ59tsc2yJXy1rBlgjwQP2IfZQJVny/AYErY?=
 =?us-ascii?Q?j57k6IwTh2PtImznrI+4TfnCEDSgFL5Ex1uNskID7vH2iI0szqBjFWGgOtvO?=
 =?us-ascii?Q?2I+SNQ2z/v7pTzsoaGpw7jzCoSfyzY2auleOx9Z6ACVRGvFeigXvUFrUrmBP?=
 =?us-ascii?Q?T4GBknIEq2+e8yXDDctxOD6cybcUBD0Tf2OSWQ3q7D4eFbOzcoqVLm6ldCQv?=
 =?us-ascii?Q?mlM79SyJiNdY/X9zdbSMRyO2Lmi1PLYzdPONu/+K8M4u220KcJtSx6fv3Uw1?=
 =?us-ascii?Q?oHo3WJ5zHVYwLPYiorRndk86HS4r+ZwLkawKd9A3GjifgQBDB07sagHc42mM?=
 =?us-ascii?Q?kW1GQRVS5IaDBoIGpbX4GPDv66LtZxg+hrvNzyd5Xb4zEHAXuVdmbYBrB+/W?=
 =?us-ascii?Q?LtnkTJCkGScxvyZZRgzj6zxh33yhVEi/Bh0tBNx1ydaZ8XTenXZAcNofJoLS?=
 =?us-ascii?Q?9aDSkpeBpqDcSOeBdjKDQbm4LDMx2erBrKBjJqofcaorOhhDm44d6kNUa+CQ?=
 =?us-ascii?Q?uVyD3keCxafqxocEWiPgfUpzMhKsJLvkxshj/9CQOm/jUyGjAglFTYsNOVCO?=
 =?us-ascii?Q?uq3VtOsWapl8FPZX/jb0U50sc/5CjoiOf8VmBkQEAexi419sub+FcgouWtl+?=
 =?us-ascii?Q?sR+1rKk7o2bF2rThCLzwzEnGYMXF+Z22A6Ad1IbRrtf310nVV4/ys4hpPLFp?=
 =?us-ascii?Q?7+ZiL87iM8cbsRBvZcXPWHIND39u9Ee+/4dyQU5x4yPvXSC5zf/ZNP0YKxO4?=
 =?us-ascii?Q?3LSo4jiaJj8ywLOpbjK/nCA0QRlgxHVAAjUKWR9t0ivbd3NyE+e64Wa9Idgc?=
 =?us-ascii?Q?pJNgBNafLDFMG5LT9CKADEPSrmN1g6tiyICJtSzUpF8iyWiFwP0KzQG4RZFB?=
 =?us-ascii?Q?3h0jhy7kG537CvruKeIWB8A3W3zX4Mh8Faylnn+QV1rBVjyrrYrxN4QIM3PB?=
 =?us-ascii?Q?a0qdAfXj0AZ0dB4/4QG0DEBTyPqVTHMXE7wsjQ/UafzMmfcLMkL2AoXftOjs?=
 =?us-ascii?Q?BeTbcWYrlqEK+fHnPkEIhk9mNEUTCyJJOl21QumQXK9i2puCrpm63nIB6FHZ?=
 =?us-ascii?Q?BeSt2fA2Xs9a7q3+vmp4gYzUp82toVk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda5cd27-dded-48d9-8d33-08df4c598391
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:39:05.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KanR7kZDuy5h3vO3HeJ1TydXJcUFgpSrRPViHb9A7rY+dYMg+TpJg9Jx6GrAofH+teMx2Vcdx1L9EWy6gsZtCHpOAxOK8eQYsKudNR4u0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR10MB355341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 07:39:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25227

Hi Chris,

we have sometimes one=C2=A0 of theses errors:

 > + [=C2=A0 =C2=A0 =C2=A0 =C2=A0`-swtpm(461435) ]
 >> + echo TPM socket acquired by another job, please wait...
 >> TPM socket acquired by another job, please wait...
 >> + sleep 30s
 >> + pstree -p
 >> + grep swtpm

https://lava.ciplatform.org/scheduler/job/1555515

https://lava.ciplatform.org/scheduler/job/1479261

A solution would be to encode the job id into /tmp/qemu-swtpm.sock but=20
it don't know if this would work.

Best regards

Quirin

