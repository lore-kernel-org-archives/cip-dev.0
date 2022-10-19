Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A4C433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:23:11 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.54])
 by mx.groups.io with SMTP id smtpd.web10.5951.1666171383482874154
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kPYdw8Bc;
 spf=pass (domain: siemens.com, ip: 40.107.6.54, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1hq/NkyLTRrlGbEUXZPsEuvLHlU+tZ/0+lv+KsgZsiJo/c/KzMChQ+RR3vBly2Ar0RLzaB6MXLwnKZ3LZPe7pd5idSDDwqExOuKjP9cHWziGexDZM28Twf3YlvMJ+ke0eVqKgK2u2/rn9mUASgywAg6wmSfHSbDL8b6HmAdDNer0nRQWBsJ5QpCOKbBSvhx/XysmzreqSuRZNveu6w1HsfTpLErJREpP0eFlWK3nBwqUArm1d+T0WGQHbHWMSca/ljzZjNuMm8ao19nXwempwRW8pMZcwJUGccCgGTTkL9ut1T/86PrKFBuZc3uGriktka7LQ+bb9OzaFgz/fFeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKctsy99kQVyvvjfNtrVgONXkTgC7lmciMU6TbJdXpg=;
 b=jnxAwGKzpxa0GD1jCxPoqMaMetTQDtRmJ7ktow81USHNDu+ppvk24jZ5/l5qqwPO8kFj+RnExUKmiJlwIawPYS+0uWGjrW7bn893348HY+C938/jXEsvyNqaXuYp6uwKOWmpMUf+Th1JE96NIjHoOJ5ONryEY9rOAo/+lZlfuYjw1aBCYU8/Ifyn0udWkH78nVQAzIX12RcqavZvq7pjZb/f+v9hAcLperP/tLZqD1IPfWsn80/m6K886XLxKMHiQ6YXKv1IYTzRWOmdMGLOoVz8y7P03H6JavM2f7rDL3jnEPaZvF1UG7UL0m0AJN5taFCyXmXIoJ0XTJQ1EnTciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKctsy99kQVyvvjfNtrVgONXkTgC7lmciMU6TbJdXpg=;
 b=kPYdw8BcxAPOZFnkmt4c17lLHPpLUNEOiN0mregiuJPhRdyhIji3ksCEpR8OISi6PuKJRVzcWrEYfJpFmG73Bfti7Srx3g3ykqWVYhVGDLGCHut/EyVLOUU/ILKt8y7ZbnmDmXMtF0zV1B7YthaTtBOrWHVNhhE0Az6x0N+HxBJc3hVUdreU3g3GFqAzKJZIkZ38h15u27rR/zU1fCr/QtWFuDkWq/LsdvdTzMT2HPe8CJLqkhpV1ruGTG3WaHQIQMAyMXtb3wYlUbsUD3FR9Hfs86ZyE5z0+l/Rev+HaqXqXzv4F6EBl9tXEzT+qowxVL+XZDSKFfSXOY/Qp9zvOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM7PR10MB3510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:23:00 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:23:00 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 5/7] add kas files for building qemu secure boot images
Date: Wed, 19 Oct 2022 11:21:15 +0200
Message-ID: <20221019092117.5291-5-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:203:2::26) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|AM7PR10MB3510:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d8a9b2-7054-4c22-9654-08dab1b38482
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9fr1Bqvev0CjvDaVK6KFIe6n0/HU9gIZPK4BGpxTW+lBWi4y0XnMWCAJG/3kanpgvL6rNp2NtV0NIkq6xwTwcUtRL4XgA5z1i8SfGFNHJTybloLYO2cCBNH47WXPtX4esb4Q58dVTvCgNz//q60bOLmtLKGpaH/7eaGga0HP4La5nDUYl7M4uz5BVtwPeN0BjhSYhyWvs5Wocp26WyuBYVXGyvwVOO3W3MCSTefRBwm84WwWInnpH/nWkeej57oLwJ37PjcFFaeOz0zvjSn+OMTb+srOfFJ8qqX/nqJ1MkH97d2od3sryhFqBoVyglWDWvwcx1/GZdzkXI63FpSYXg//Xa0jR0ocoEE+G1t/yvpPvrXcXwd4krmMjLCvn98Hc1DAmvLyCaWgU2XzA3ZeZUqE2SSX1UPwcD5yzMlvyoDctBlOtWrhD0sFyFLu7+ZIz/TaxX/uRmaGpwG2PAkPhZjJsbhH1aMzQxBWlviDMyUihjTkNur9KY5pDslyStSftfETjnKW7Is+EYDP9IDsf9RFA+rNyA4mrzM4R2YfJQHIRSgegu6DJMaO9chkZuRXomHdMbezq4+JG2m1gn1vKAzOPMZt6kjMLXIEick17ACfX25/tiOazJJWu5PXaWFrz/6xhzy42sVp5u2wc8gxS0GJa3tBXJTAxMb6GZWjUTwgr0EC8jbzDIeav5IKXHpbJvEjqAR+2LJSbNWnFk6Ucg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(26005)(4744005)(6512007)(9686003)(6506007)(41300700001)(86362001)(36756003)(6916009)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(5660300002)(107886003)(6666004)(316002)(82960400001)(6486002)(38100700002)(2616005)(2906002)(1076003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eL9Ic5GZonmiWpjOdxXdWSPCPMBTEZit5xFJ41Hn6xclac2BTeakTUI3q2LG?=
 =?us-ascii?Q?Cm8novdsKhPaNmI3TX7X38BY+IuJVfm2xc1Mgdx40C0YC+usWTItXNthlDZl?=
 =?us-ascii?Q?72KXrTd9YHhXmmLlcV0C1tUhC0ajY26EJQfPoSwr6ZYDxVYfFxOEfrvAArcv?=
 =?us-ascii?Q?sv5rdl3rFzZnHjXdLlOOfiLZNv+Eq5GK7yostQvdth9vvZ/21pfF+SaOE6og?=
 =?us-ascii?Q?iY/RoR+uNfKJ5E82ZHzKfKG9ypOfXsgTigsDSy8gG4qVqK1LKUr8tqpzpZrJ?=
 =?us-ascii?Q?IZR7MAyIymYjpwdjuxMKnUnTKzMMjS+Owr1AaiC0mJPdCC2c/dn9xdRWYADu?=
 =?us-ascii?Q?J1CpBTu2fWl++OIkgv02XmClW3LXM4QA21bnsVg5mK8k90wpYiXWuRwbtwzC?=
 =?us-ascii?Q?zB1zCn+0M+Ngigk7+NmZgr+zAyzmk9Mr/lifHotvrBa+ZmpSJ0KIEnSHorxP?=
 =?us-ascii?Q?9WwziA1O7IK+oVgG28+Tn4UrZBcEMD5HFRJRzAzfxSjeF7ornptIq+cumzzr?=
 =?us-ascii?Q?h8DSgL8ydKWU1NUhrga4Z7T8SZfshPPuv8pSm40tWCEOQ5Ncg7WyQuDrztiQ?=
 =?us-ascii?Q?25W39cpDEhaI/YJNTVRaJNQ6kj4C98fuSNI884ZAT4VPjbdSTlX8PxnkQx90?=
 =?us-ascii?Q?EZk6QtxiKRMOFe65NrFd9QC9rTSevB+9LXg/uHMjdgr4nwDDOvDVFG1/ibf+?=
 =?us-ascii?Q?Uk19VwbfV+iFzQeVqbMA+dTI2oOLfEHCNQACJfFkAq/De8cuDxkozqwc6LES?=
 =?us-ascii?Q?kCppZcEZbQTjNRD7sXZ6hDGu55lM9KdMdasXe0b2lGeidilu8s5sa+i8BDnR?=
 =?us-ascii?Q?Sn0Zua1g50nRLnMHhCieWGuXg7B6Ii2y7Y+BpiJV6Tp+sXafr+OYvakPJYOX?=
 =?us-ascii?Q?M4JHZ0fjbZoEQnrEko16V5kmojOztjQHBVNtLq0JAK/yUtwTwzDJ9adQlHxK?=
 =?us-ascii?Q?SEfttM08VqVutggMEAu/Epem0dQWv5hUumS/cyUPMXABdVTazNc1u/4d3VK4?=
 =?us-ascii?Q?8Vk6wnVjYphEocL7EE0WGLnvcz/n+ovWF2bvlcUtmiiiXkiViCuscMHIk67R?=
 =?us-ascii?Q?rAgU7sG6xdo5qSVWVaz+SwwzmWzk4HWDqpAMG1CAzEnGX6a2G2HGKQpM8liC?=
 =?us-ascii?Q?XTPsnEIFqPAFUpF/uZXjEu5tjP7DoUNrKhktrXZCeK4w5douXGHL371n310F?=
 =?us-ascii?Q?vfw9x/vGp3b9FhRoRHBPW9Qy0fC7Jt6MwqEImCmGPyGyuBu1IXoXyDSJO3ad?=
 =?us-ascii?Q?KMYBujIm9bpKh5wyNikROArVyJT6RtoMHZDwGEh6hIPALK9LzjcZx2zbO3L7?=
 =?us-ascii?Q?Xo783Ho0DppsoONnkwZSTOaZdLgzoJ2OImK4TNnAwHlveWfG4Ymru2MjpHMM?=
 =?us-ascii?Q?ocWfzqGLNu46W8JiIE3zUymOkBXkWe4jiUlsWmontH1EvW7q5ONyvV13DaKO?=
 =?us-ascii?Q?DSJnoDViWs/LWwXi0j5rjT+h0B2Ujwo0fgwGXBE/gwoLClNBfKSZX6LkBQY1?=
 =?us-ascii?Q?6MCjU5A4HDEwnCIO9cwA1KRLeuxnFVEZbW2fAnIqw9gDQ3RGCIdiTbpx2OEB?=
 =?us-ascii?Q?IjMywDW9yHFtxprjxrh9IKODgUNGx2DgEDfnzP8qcyhTOlvx708cYptPd4ZW?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d8a9b2-7054-4c22-9654-08dab1b38482
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:23:00.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j24xDmXsGsun6ZcS0nl2iQqLFCf57ekAGv4Ha001413H1pxVb/zowrYinSr5gozUPjt4TDUz0XC4yG7vtvPSvH9g6mJSqXXvjpILoxttaes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9779

From: Sven Schultschik <sven.schultschik@siemens.com>

The u-boot-efi-ebg-op-tee-qemu kas file combines the different recipes to c=
reate an image which can be booted with qemu and provides secure boot with =
EBG, TFA, u-boot, UEFI, EDK2, OPTEE and RPMB

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml

diff --git a/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml b/kas/opt/u-boot-efi-eb=
g-op-tee-qemu.yml
new file mode 100644
index 000000000..0558c8e79
--- /dev/null
+++ b/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
@@ -0,0 +1,11 @@
+header:
+  version: 10
+  includes:
+    - kas/board/qemu-arm64.yml
+    - kas/opt/5.10.yml
+    - kas/opt/bullseye.yml
+    - kas/opt/ebg-secure-boot-snakeoil.yml
+
+local_conf_header: =20
+  trusted-firmware-a-qemu-arm64: |
+    IMAGE_INSTALL_append =3D " trusted-firmware-a-qemu-arm64"
\ No newline at end of file
--=20
2.30.2


