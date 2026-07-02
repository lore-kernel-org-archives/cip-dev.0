Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC4AC43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:09 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65740.1782987836908991043
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:23:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LRXpyuyF;
 spf=pass (domain: siemens.com, ip: 40.107.130.24, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRAQwJSIUID/qRrvgyFUJn2i1+47T66mDyt/gsIRJHY61xtAu0r4ZkSVY0bV4HEcgviibh/f8yDejBY/M3BexYk2Wh/OWp6gBe4y3C+KNEyN1zvv+JCvPxo2AhnxlPV1bWCMjq6X0SYX8vizeoMsu0ABqsF+pvKya+fvEm5QJKTF5vVgbUvXrRpCOYsf//3mZge7zBcYKmWetQWQ9p+VXsIyBhrfYvc/KSUQ+gbg+Hf77l38acy8UUA8TNfYRPG6GdzIi1/iHy+8dt0CUQXLxGxZBUwE51OZBxIdzX8gMxayWA7nf+oWg2l8tHiey/Th+HIW5j6twZ/xwdM5ND34EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJz8uSYh024P651dHBtmckf5/LaiAxop1FhcoK+ZLz8=;
 b=bziXsQC6sRpwbFOL1sA36ILaZjXz123IlVw6dS7rG2d4jgbSKSrnBjLkXDVIZuJTTVFuTeMQOe4FGmFD9q8Oimy8niLb/HUWfeMd1FsdHyMCvfsvErd4CV2Bq3SCJfCMmC6mSxurlXWc8JdLI4sWRj5P7IfWKzKuJN0xxuvj/jR8TbGuhEV1hs77fngsk4EnHkkml13VZi6YKNM+tnc7VaqGlQIN0O+2eXI3eIBw9DcEPOR5BmlPu0xNOSVOBv4s13aaW2Z3mqX6Bd5L1QGZHEKKYYMmtU4dDBsfxeYhiXd9GfWSvMs+3Qors60OXPeI3KGf+DR8QhIulZaQQGFBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJz8uSYh024P651dHBtmckf5/LaiAxop1FhcoK+ZLz8=;
 b=LRXpyuyFBpff2/XrpqcFM0Dutjl2X6/VqLtBE9AyNIZnMVJNZ4X5MKCNFOYH0XQpg1lz3t4Vi9876hcM6K85LH/7LiunjK4zFJcwZ4dZMBV/ThZ2+0QgUjQItbq+zYUNnAybR3mGV7O5xnn53jB9QYeF7wZMOjwIcOjv9v7gyIZ/1+5dBfrMImUvleGmgNKagsXT3YKCOD9d96Hde4h1BSYvjafDjpoAWScbBPDc0BwsVyBMeBy89Oj/ceaJQxe0bpxmlQTOoYpGuC64ujnMG5O9aRUFUBotKhnP9qofPoELFSteAC+981a2sZlqEdrg+7akm+hW+ZlXRrW2aGNh6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:346::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:23:47 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:23:47 +0000
Message-ID: <de7ca5d1-c5f0-4152-81a8-eb4e1b06190c@siemens.com>
Date: Thu, 2 Jul 2026 12:23:46 +0200
User-Agent: Mozilla Thunderbird
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] 2nd Isar community meetup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: d695905f-2160-4bba-bb59-08ded824007f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	8dO2zSqOhUWXfyBpRCVgwE0zULklF2/8LqZM9dI3g4dZP5z6UhwGOlRDAN02KsMK1RyhI1GDJUBYJsUaglIcVDXOenIB4x7OcUn5uTjwBO8nZkRcAAgMB2l6IN67XCMV0YIzM61mqyMVBwCLjmAvaZ/b7f/AJflDocPZyAsoj5B8c3XI81KOROIFD5NWKTLjdkhaUc013fmaE61v+JZbQLlO6hz5OLQlTHCS700R+jGjVLhPig3v0ljz8gdweVgnVeQIXJ+YCqMF3eF4J6KzLkQH/gJ0gm7/dOtAhlHeIJD00l9ju1P6ma+Cnx6+Y/vaOl2XRKTLQ1qB4Zb1vcO2DkkuRq9msiV+M4f9ryGPaAxiz9HeWY7ukswGe4l90HKFAfo6bHXgkV6wG2muONpZAzyAN3qr8aHpS0tZhH2Tb0jpPtqRXs9PbHwb/eTJtqO4WkYYBS6S0FTgITMvrPg+FyBq5kXsB+5pZhxGA63q8aSJE9a4Dn6j+VCUghJ5205ICLoUNnGiK54brJD+ZQQQsxJ47rkLtP91UDYAAKFZgRdS1svhT45P05rWE/bUEBOw3K0Vs2dkSy5hQ/4hdizOHf7bkBtPVtQcGqPCFBOaq1o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VEEtWObP33K4jy9Il+Kc7YZ0Jo2UYoWtE637si+RieHRC6Mki3oikOjmD+cu?=
 =?us-ascii?Q?IwlkVMjU++hYI2JK9ZoRl/iyhsZbCzc2mk6+tWYAWQGKONfTjIX2nCaq5M8l?=
 =?us-ascii?Q?dBSvp0bORp8JlLFCoER4IziJgfpR7FamsUqgy1Me+gwK1HxLwa9vR0ujIoXE?=
 =?us-ascii?Q?KkXirzxNYtmtsmmeTjVliT3F+rS45XfPXDSdn5pZh+cLFmgSfCB0MT31Kaeg?=
 =?us-ascii?Q?hLRfNqwbz9YQQHtBvsuDtIH/qlnkjfJY251SiU1bvW+BrwarieNYNOMf32Lj?=
 =?us-ascii?Q?YaZCtSmPAxMI/cG3FbrSHFXTrVIWbZ4/ZeKTfRlIIoPaFZtd76OaDhJFvfmn?=
 =?us-ascii?Q?ksv9ekH72BmjFLwf3F0fSalGPwLpsrlzocYlfXxsVbobuYIYrirmlG7Mgo/I?=
 =?us-ascii?Q?GxRardfQzrJZw8GfbBxkwwrIprxMFHrzustXA5kLbj56+xj4PpCU++LuNoLd?=
 =?us-ascii?Q?OVTd90BqXpniiALoD7cmd2VIdJ+fnrX+hLdtHBOyRynTzktd8v4kt/iDoEXT?=
 =?us-ascii?Q?a3tj4Z07h4j1gdvo3uaUgbu8h8e3nvVR/R6xuihVzRiRaoHreZw8QdehSSar?=
 =?us-ascii?Q?ssU1BZ8wXa/ttgXpe0UbJvbgUuL55K0dUEhuJyzprY9jx6Kc7aJaM8MX9gKB?=
 =?us-ascii?Q?JQSuUvZ0D1vKjBuIQs2emwEcV2YXfrTApjc4mlRgT3H+aCEPVZZql1Z+6jNf?=
 =?us-ascii?Q?EGuRDVEc4xomVEH4LB6wD/h5rR7X9GzVEFbJr2qiE8vUFCEabEYm4MTcWnYs?=
 =?us-ascii?Q?ch5U4MuA3EfnI9Y8CM9AVg+vmA4RY53TGcs7tC2KAkCyAVvw17oF1B31rxA8?=
 =?us-ascii?Q?+S86TFr+wDFD815XFUDjNCZx5zFq2ttuyL0aQS97RDZ0HfLd4ZXDOYD78FHn?=
 =?us-ascii?Q?MeKX4ye74hY4ZtXGnWYqhVd+H8lKduppSAL4axxzFGzrjaq9nboD4+GnFoMY?=
 =?us-ascii?Q?hrz/nNn5ZhDM8hODtikmWVqXpPxA4bAhl5qcMAEgsRwvpwsu0JtIUxiB+O1H?=
 =?us-ascii?Q?hQWw297kFHd2spaQpHhReEaWnjUzP8+pugZQjrurKiZECHYUsVPIDATk6XjV?=
 =?us-ascii?Q?opx0ymBCtWAA9M6gAp6KfyAIvXDi+GNFBoB5w4etYJp3s6MSrzXp1zsAOyL1?=
 =?us-ascii?Q?6BbCEDIAPNFs3SD+1ZzNX8fGwcj63UfOrDj2zuf/S/M1Stkc9bjeAYjSKUBl?=
 =?us-ascii?Q?9A7Os30y3IYbziIKl83b+q17hibIMHgAcuyxU5xSntz/AqLYnWTEj/GjF3bD?=
 =?us-ascii?Q?plF08H2prb2iIx2qMeQyK8bB6fz4FYiMdCDwJJ4gRJQnmYkNsE5IFjxl/jNj?=
 =?us-ascii?Q?RQpWsXGu1BSP6xjgEnBZpvrmNw/O3OYnSwzyY0247UceYGIJy3A3KXVjAiMP?=
 =?us-ascii?Q?aOR71vGykA+xpIR2u0LMpUb1WfLXQWlSgqpzVTHrSIRZSeKs8Bo74nVZIkKh?=
 =?us-ascii?Q?cxT4L7sDrnseJDhhKhR82USHAiNUBcXPrxl5rILnCvAfZU8znGipk3ziAzM0?=
 =?us-ascii?Q?WqeIw+bXU/USmY4pnbES32roewbgPO5J3LCQTFQZz1t9V0gbJj37wMNL7pyo?=
 =?us-ascii?Q?7s1zDH7XdPdQvtBY3G3Pn1/T/QSZWyn7RzqtywgFyjtyMwNAi83TzoKtJsLt?=
 =?us-ascii?Q?J6hNKhq5MQQLWsZ1MbvCyRl8GWqVEfyqAYypTP9uMkx2dylf5qgXiXzh9ZLz?=
 =?us-ascii?Q?4P7evlZFDrd4pWBTxdJZbdwCiS+xApbhbVx08My1oQ5PJUJ6AF+k82nZ4zY5?=
 =?us-ascii?Q?d8Pu8xGcSYool/rtI1BGZe7h3OolWqXPcZImC6aMA1xBWbx0b1nC+Gm+iubz?=
X-MS-Exchange-AntiSpam-MessageData-1: ypiPyHtuyUHXl8ed3u/G8rJwHL7AoEKFYBM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d695905f-2160-4bba-bb59-08ded824007f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:23:47.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsoLNRgsp1DJLctuPa5B+tOBDREQ3VpqOYqkrgr49bK0+LmatWHQ7YQ8XgnSHHm7/vhRhUsUnMMTxI4XyeoIYDuqqE7UHYkwij9bVI8/BPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5194
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23380

Hi all,

we, the Isar enthusiasts at ilbers GmbH and Siemens AG, are happy to
invite the CIP community to the second Isar Community Meetup in Prague,
taking place right before the Embedded Linux Conference Europe 2026.

Date:         Monday, October 5, 2026
Location:     SIEMENS Conference Centre Prague
               SIEMENSOVA 2716/2, 15500 PRAHA 13-STOD=C5=AELKY [1]
Registration: https://eveeno.com/isar2026

As many of you are using and contributing to Isar through isar-cip-core,
we would be delighted to welcome members of the CIP community to join
the discussions.

Following the great exchange at our first meetup, we are excited to
bring the Isar community together again for another full day of
collaboration, technical talks, and networking.

We are planning sessions covering recent developments in the Isar
project, user experiences, integration stories, enhancement proposals,
and interactive discussions about future directions and challenges.

We welcome contributions from the community and invite participants to
share their experiences with Isar through presentations and talks.
Topics may include real-world use cases, migration and adoption
experiences, tooling and workflow improvements, ideas for future
enhancements, or ongoing development efforts related to the project.
Both short lightning talks and longer technical presentations are
welcome.

If you would like to give a talk, please include a title and a short
abstract with your registration.

We hope to see you in Prague!

[1] https://www.openstreetmap.org/node/13806143589

