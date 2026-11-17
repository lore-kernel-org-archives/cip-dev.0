Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15529.1794914926563983602
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Idb9Qwqf;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0St43lnYLfD23qKfkcy8y2DF2/AE/kE4YghljcOY1wAP/0Rov+50Mjhemhjmly2LaX9ahlO4EOfR88BGK69KBMUN4KOdepC4j2Vjs00q4APiVea/xr6tCrusNVIU1m9PfodI0y1MwQOs65sxn9O5V1IedFdNE9bflXKGvWcSrp8itV1HXH2PrctCfn81jZy04aHfjm/pcnG0watG+RDbjD9iFnOCUYtadWUPcvkiXY8imPL7gEdM+4fsLGlbQ60V7m9B5VzuEkHTD6HIW3X5XqMhOpJdFlr7sop2kYyjJW0Z3AHiKGabTCCgo21rsKFB+fe+zY2rhGM5OJOm/g3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVRtBunUfjcQ/CrbBWHTE+pjSD1IgAH1vICMUi7gA8w=;
 b=hRinPU1jS1fW1M9BnUNWBQc5e1Fef1/jNj467rhISG3rTS6enTV90gT+pN8RBuPZiHf8SvSDfPS5thuiuywNtYuqGyJPBesFl5qmXsZuaA6zHAVJn9ls3pJowkDKOTl3EMnGm6cD1OALLBct1krQlAdYU7r4K3C/jAOoVJQ5zTZvWAboutOgUnYp3TsQU6zATKL7mWNnkvKFhGG2doqt2p3KkODPe4LsviX+8WnJBDf+qmR23nXLj+MeSDMpPAcPJakOK/m5BiBo7HKpP1eqVgZuvkZfwL49U0VPQUs8E2qEDcSO9Fn7+9qTo/OAsvfZceqlM3LG0BsfZKGsrLLeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVRtBunUfjcQ/CrbBWHTE+pjSD1IgAH1vICMUi7gA8w=;
 b=Idb9QwqfaGtwl17U2O4xIMzGIprRxc2Q67cSZTO9m+mzQg/ZmyqD9EDAhWeHkxK1G4xpCwAo/DMsbz0YXbSNoqUxUF9h5PMK0aVOIXGq+mzhxFjNb8+Ljgn+N4YInADTphVYzsJozrRTqZvyvgRP42X0G0nhfaI9K/DaHHhKW/BAL1jfbPeVfoPXBO1fx7zsGgPJfwIjvofXQSA+90MxQFFHMIr9siiOdExyXg1Dqazy6L12ujPubvUzEN5rmPtpGFphhTRT+apSBpbgaVmWJrjffAx4kg6vo8UVltk978XaLG/l5W/0xfeOX+YU0KJnttj+yZxqMXJIvbFqVNbsRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:28:41 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:41 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 02/19] Fix expand-on-first-boot with separate home
Date: Tue, 17 Nov 2026 12:28:16 +0100
Message-ID: <20261117112833.316234-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: c86de7df-d38f-41e6-3eb9-08df449dee96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: CapkWNF6uoPlfpMdqWOAC7VStrNjOdtz3Mo6KHCfjnmpl89ufLENLvZF787nIEszqxySLnofS6Mz+5eGv+UbMBhgEYp55dNld2hcb1+HPgw5W3ROpU8zHHgDJ5LkuKpF6vZ0YTLSTbMW5QVHh/hQqZ7ghPCv2BYrqY8EzOXKGOTDGOmVcDQV3RnC4Iov+VLcQtj3IqkFttsRSexOt2emAZXZUPQPY999I6/UPKbdXhi0rXpy8mtnkMsZzovqkQSJScPAKh5Rv/xxs792VEkfPuTzjY+YHuSmEnLCPCW2AVgtYwlq8LcMmxCmrb5Dm6iqPuWLzbk8nCqVWObjobp3+A17YpF8kMobH5HQawPJghri36LT2m5x/RvBEv9+CCoHx10eUA2kYZe4oCHyh8m2nbVuAm4p+3ZL3sTcZJRkkwzEL7wiUuDIUHbi/ec31n67wmvXyhYo+2WWNOSvfucsoQms9ms9yxNAfqodwKsxV3zM14+AOpvtbnzXhu3dy6Z1PeXVt1OVEsIP/5eTXLZU9QPkzMDf+Zxb4DLyiiZ2QHmlkdVqTeaG634gvamPPoRjkDgiulMOC1m35aGrVc2HrCjHbJ+WBlUQYbKwM7Q1F1+iWqQbszLotur6aOhfKGYepG5F2zPmsiUStGydyQRhEfYoMf84XbyoZ7V/bypBeqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/f0m98sluICpjq6p8TSM3SmI4ug46AzRi9Gp4toLY/snXkJrwvDl4h9kzQq?=
 =?us-ascii?Q?k9kFVyjsBtOWZNTgFQ14paLrvPTi7KG2oeAh3Bccs75i7E+fjO6CBiA/NO4L?=
 =?us-ascii?Q?Z9Ju5cRX6LHfAKSL2udFbvcK8kCL65zvW2WEOGI/8tZY82eM6b2u2miPOLYT?=
 =?us-ascii?Q?U0J09OMOkrEbpssE1D7trtt9iF54rhtLUom/QLFcXLGe0d7FNRhOOl07/Th8?=
 =?us-ascii?Q?KQw2vWtLfY/vv86XA9AU4y5+12WTivcOkfyEJsRED/8OcED1eKUvlQMu70bW?=
 =?us-ascii?Q?W4ofUmBbhiJmRvj3456seJJrmLACddcZXYitnJCAoDYguuDwB0wucIg/rz5a?=
 =?us-ascii?Q?QcBs52AMU7RTpJJ+3V5h/w9I2tos6mfAfqlLCabvRSAlT0pWrN/D/ANn9Jlg?=
 =?us-ascii?Q?ADS2qAItUS8137U8ly7c8xeKQdXeW8kMcZDH+IUoEPdmFuCC+RHuOg8YRs8C?=
 =?us-ascii?Q?fFC1W3BE5MM5kSGH6QlaJE9gnUVy6EUi0sn7lcgQM9NQ0pB76UkmmfACXxcw?=
 =?us-ascii?Q?YMOenAaM0Dg0oD+iDSe4epBgJVolN+erISHdIsSTl23SaLYZuc67mtGbEMWb?=
 =?us-ascii?Q?PZaza9Khf9Qw1wptxrxK6zY/iwwD6QXh8gTFojWHu/ioLjdT6L4NQaqRaNdo?=
 =?us-ascii?Q?hDmvAmVbMq/krOlJ/tT+QMVzGsmO9L1RwvXruE4w108iEQJGA1HBI353M53V?=
 =?us-ascii?Q?pwNiXbsIJccoMC52dTkgeXe7vRqxWy/HNfv2sP2VVZrrghK1wCIFhq6YO6RV?=
 =?us-ascii?Q?WzhY5ELsurOzc8Q92opYHniICrw89S0s8BAJHrXHGWgNBgzjkSmikTuY41Yb?=
 =?us-ascii?Q?fzq0eSdEzM3/H0ZhSxRjcZHDDcnZj2uUYue7NJ4Dk3pFCFPtaAxL17sTNN41?=
 =?us-ascii?Q?dgqNvSybJLk8SNKBKGx2rTIe1aAY5yEZhE44sU7JR1xJu9D2CtSBkdpAvYtl?=
 =?us-ascii?Q?CqeN1at14XmGLwNy9KkTEo45JZJbfPAAaJF6eTHWWfoUaMSHjLUvyaMcfZpx?=
 =?us-ascii?Q?B8CqZXiexEhVGl6BchP6uLLL1/sKIXtnD10otbACn+U7Hk9blAfbNTb6pryg?=
 =?us-ascii?Q?Kn/6GU9SkTFFglLl8+C8E4Kjapc5l4A4XtZuzagf3hXnO+LEwCXnYoBCCZrY?=
 =?us-ascii?Q?O0pkCQD6Ns+mthEk9nIrmsSblXnoW8WSZLUK4wxCiDL7LTxUYLBTa/0whJOE?=
 =?us-ascii?Q?UkM5WFRQCKAwrxxEx0xb8dXOfhxxpU17ueG3xagmkv9n3ht/cawSrC0EApH0?=
 =?us-ascii?Q?lFfi/l88FcZcqm5f9ubPNeIdvAa97p9Qg/fUhe1zEK8/3E0GvqqY+rAU77aG?=
 =?us-ascii?Q?wZvgna2YIXQDMRE1/eIc/LcPYcvaI1CAErJVOxj+IfF0fZdkCPuT1YHSwwXF?=
 =?us-ascii?Q?sz0JrSVGT08mxL/U0m4sOt6WFrb6/hnBeUjIXSx210I/jHm1Vc5HGPAkQNfM?=
 =?us-ascii?Q?wM7BNkIzPUlHx5vtejvCzWqYya/Sfz7XN5ieqa6PF2ZA6MP1iYcLDMJlgsgy?=
 =?us-ascii?Q?64j37Rh/vZSxzlUiQ4NArdFdiaDwxGjp5amVTOyt6K510NyI/cdCGQSqiWhy?=
 =?us-ascii?Q?KrP5dQMgxHTSuo+CUrGeXQM7XUnVKmLmW/jn9/g0ynbRQ4QbBe8KBlU5oJop?=
 =?us-ascii?Q?H3O6EuUvebgmiYN8Xc5HCFO8Hpcy4ckOya05qJ9rDKW6ma3n46TLd67IkVtL?=
 =?us-ascii?Q?5V+gX5/fFILQs88ognmrIObZF1djYIi2DljTqd9DbZgo4SDO3K8bZg+zsL6y?=
 =?us-ascii?Q?rkWOagtavMxXgQQxRETVVZ+A9/TrINU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86de7df-d38f-41e6-3eb9-08df449dee96
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:41.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkYbGGeIiTVjk140sH+9TjWtLRAqwxfhDIoxNnr0RodVZMyJdiGwfjEObVr5yZwMbAZMoKxOMbE28mObv0o6GiNbFGn/G1gRdQnCY1p34KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24822
Content-Type: text/plain; charset="utf-8"

With separate home enabled, the home partition is appended to
CRYPT_PARTITIONS, so the ":expand" option is added to home. home is
not the last partition in the wic layout, so it cannot be expanded.

Prepend the home partition instead, so var stays last and receives
":expand".

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/separate-home-partition.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-pa=
rtition.yml
index 16fe2cb7..ed415c4d 100644
--- a/kas/opt/separate-home-partition.yml
+++ b/kas/opt/separate-home-partition.yml
@@ -18,6 +18,6 @@ local_conf_header:
   separate-home-partition: |
     OVERRIDES .=3D ":separate-home-part"
   add-home-partition-to-crypt: |
-    CRYPT_PARTITIONS:append:separate-home-part =3D " home:/home:reencrypt"
+    CRYPT_PARTITIONS:prepend:separate-home-part =3D " home:/home:reencrypt=
 "
   add-home-partition-to-factory-reset: |
     INITRAMFS_FACTORY_RESET_DEVICES:append:separate-home-part =3D " /dev/d=
isk/by-partlabel/home"
--=20
2.47.3

