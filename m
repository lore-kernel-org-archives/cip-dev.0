Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15532.1794914932321455839
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CHDZuRdl;
 spf=pass (domain: siemens.com, ip: 52.101.66.28, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsImstA2O/dw33MHuiomkKyl4BWK5rXj45IAMMfbLyeamOsb9RICIMKv6pkq5sVq3u/BWrRLr7dSF9O8GsW4vmq310G1u+cDNwTBhKrySnkGIvbbBpzE+tpiUMA9ODJdSU2zG5DSOFp19vGti2e6flr7t5z6eynutFhx8WXmi6+FQUfThp9QXSNAHvb7RQR8Yhn+a/FMEaA3Wlqvh10ffYzYY4+3cNH/62qhcrKUwsVkCT6mHPBLPc838bTNXGxICUAqmZW+AZscodAS0vrUVZci0nouFFrIHjGCXiM0sGrV2BBPXKKlq8jgd8ZdHXi/zTUhCSNsSUcRHCGTVHyipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0Tp9Q0XYISQkAKuvDvoQmpzkpmxm1KNsf6qsv7qsFQ=;
 b=fwS7BbaKdwTpQ7sSh1jg84zpMQHz+okPOIkwzQJYn7FWo4gSbeo5hH9WQmPenMrirEWfIK4vbF+bd721mukmfuSqGZj8ZuaswXBGMMg6RD5SLCl1bUahjlqs9/l76rpStBJPN96x807R1f16RPI4wSbl/euK/8fvk8XmyURDxAWLxdI975xD1KTw/eWcI0SUDyWWjQZP52cF0KqnPgIPhhJOjrfBPk0JDvAoG9JdSx3vl+8yUndYUI8gnW/jUWzI/sLwi/npREhxJ0UU5znrvSra2FJfgRGPkUxq/nNlbx9ALWqdceAVvz41jjdRKVrKlvNA48T+/e4wHQRnrJ+h1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0Tp9Q0XYISQkAKuvDvoQmpzkpmxm1KNsf6qsv7qsFQ=;
 b=CHDZuRdloHesVXavLI7pAD8rb3Y9zyuoAJsiJy9crH9BDRORmZ9TFtkFiTtXIiiA+yNxno4qHDv1I8GSQa1OsZmGpe9GfxQsMdM9Uv2Kj4MxV+FfoqgJUfhP694bbBdxmiKssM5yjKeqlvGiX9k8WPOLFYK7x1qXH6d/3ZIbvcMix45J1Ix0StPFLcKFP80e+CkEYsw12Y3TkhEBj06Lc7ZOmMdAQ88j3NnTw1LxCMbzibqdrYaE2xO1O9wP8vqdJvD8YuW01Dd26LAHmfnOwASnPh2B0p04Wi+Vqu1ie+SOGccAWXvF/l1kUkRz7T/iOKCXBShX7JAChb66jNyKOg==
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
Subject: [isar-cip-core][PATCH v3 01/19] Update Isar for DRACUT_FORCE_DRIVERS
Date: Tue, 17 Nov 2026 12:28:15 +0100
Message-ID: <20261117112833.316234-2-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a57d60b-d8da-40ed-2fa5-08df449dee16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026135527099003|261026140227099003|261026130827099003|261028144727099003|261026121527099003|261022115727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261022105027099003|261021121427099003|261022113327099003|261022075727099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bFFATkyv4H0pTOQecemfmJUkNJjscfvivLYySKeV1GQvPDlI3gCEjTRk8fp78YviV0Jn2GP7RUqYhSFLQwMduezDGi1dQ1xB+GJP4H7DuhKjJ14vMKzTMwJCDG/MVsLgu5vJqDuGfAiX1BhDm10dmk5S3cX7ygFIv8hP835BXC0KyoopmBcJif9qGwL5+n38kCDWe6Utx4mC44O7X/7P0bWBUdnBh1y3aOwVmjBTpZd4/cij4jpZ9J+DuLvZNPrPakpB/UL/LIRCzf+4xXYmxwxWqstIIrR1LLKTpZRyEmdrB7bVYTSS/026YC65g5L4PbuccOX5I0jZrmbQ6W6lTZS9UHDoHuR7QRpQmgapUknoDc90axwTWcrF7S5VHW5LLYfvE4xEGs2Am+GfXenmSA6jrPnb7SnSLA/wgZST8EQJAMboYZ1e3XT+cvHPFfgC+OJqpaoS5GnE/jConvZy/qhcBav9ACRzJ+9bqnFZl5w7YRssuPcCYp939AZjvSPZ0TGs/wl8jsiXb09lXUH+fYm2qbk3uSaiID6d2OJ5DKfXWsBaiAqitEqRV4P+Tiezj04orueqBJcNXqiHVwJ6lgMLAtheK+1nokTY5xUNeY2VnlnApDE9SfAClnHe3CVOs3Eh1frLoL21nRjgoXpk/JotSipYJRXZPJQlHvM48Z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026135527099003)(261026140227099003)(261026130827099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?etBMSKfVDRVtyjnzry9OCj3uzjiAROTj7GC7obZPQ60T7gmxgd7UHd7IWmAC?=
 =?us-ascii?Q?81sfTGX/79bUzUop6Q8Qw1dv3KAVqg0Wu8CFP+0kcliQfOqdpOMfQkym2kFQ?=
 =?us-ascii?Q?POuTne1bYMKjR1CUzUmmoPConPg/AAMWSkMGUARu1bzaFFstNRI46SySXGM4?=
 =?us-ascii?Q?OKi7RxrD+GyggG4GaXRf7etzp6S0NPvLpgr4eFxPXO2xMwNaHkDJvu935LFJ?=
 =?us-ascii?Q?0wy4dpds1Dtr70wZ4i76NL8aPcTdzEGFcRklQDqPhp+i/hvJDdKMAVa2f9j8?=
 =?us-ascii?Q?KnAJKwc/CqN7zMs8yjpCDTUVcs8hdvKT7uZaxN7SVU1nzOC35Znd5SOhRh7f?=
 =?us-ascii?Q?QbyC0Wvd1ZADgtDJrOAEmmimlAWTTuk8o3aaeEaHOPbLK+DCXimEVmfLnwUm?=
 =?us-ascii?Q?A2usE8WMdGwCLYlIDy+IRK0Fa+mfQzksd3+KNRnQ336XhGwCm+YcDyG5mIvt?=
 =?us-ascii?Q?AGmxzkENzikvhLWM9xeqRawdi1s9S9sr11xvAGlWQQOrS2LGMpGnDKNI7xtV?=
 =?us-ascii?Q?qLs+FTK3QX+hBSwu+5VB6WNQg8ehxyK58rC/vUQSvFYT726liIDc4mx8DhCs?=
 =?us-ascii?Q?9qxsVOvXGUoK6+ysl8jxC6HVyIrzwWcRCXUXEqIzYQgtGSDlbygFNJNZln7D?=
 =?us-ascii?Q?JIxhORhL9VaBuOSm67rdE4YKadsTK5uX7qRQoPl4wIansvifrNh601gZ3z4d?=
 =?us-ascii?Q?fswdL0LVm5QnNUrNR95cbMHtQ9q4kiNGvYISgW5cvLdVaQHgzyyGhV2l94eq?=
 =?us-ascii?Q?5ZDcz2svBeS9E4vGRtIJUZqiZwBhx65g8lP2rhYj3cU2GXRroYjHgywBPY9j?=
 =?us-ascii?Q?3ceSQ+SohM6C1So7cFd34miwix5ZTOYOLTN8IA2NZUEhF+AEQIciygmRZG13?=
 =?us-ascii?Q?jeNzKFEgKM0kXusqDvwYz209BgVPJiC2+Y4/vQOY8Ur755BbLabOjsWowDgf?=
 =?us-ascii?Q?eTgJ8if8GS3+do2ffKOy/VJyaxV8kL/nMiHVK8L7bZk8/1ShNR//twDJ4Wsi?=
 =?us-ascii?Q?rPuQt++xKHt0dKdUVIy/nZw9YGSavxFjM9PytEsRB2kBDqHo63UFXwhjQFxA?=
 =?us-ascii?Q?olWXUIrp7oUhvpWEh0wtCyvOZMBo2j3NvMIseES1h7y1FS4pQtHM1czWd8HQ?=
 =?us-ascii?Q?cf9eYNi4c4Aphsperp6qfeATHkqB6j0vvecZPsqO3Rs96bqXjbcr67koJKqN?=
 =?us-ascii?Q?cDj5Bd+wfT2v3a81CcHHNlrmblXGkWF3vcWgXsvb0ElmC6k6NJR0mViD0M7p?=
 =?us-ascii?Q?mYZOqj372/Yc1GUQRALcjSMVk+TUzuFRy88h1xwD+HxrFusQEH8wNqoQUm+2?=
 =?us-ascii?Q?XKioxciOFt3C7fFt8HTZ9AouWUuKN7t0bObMqb4KbCvAiGWEETqHtsRYhWP6?=
 =?us-ascii?Q?C1x0SWzHovd8nNsYGm2J4Vxw7lRKC0GUYQgq8ldl+umWNMF0q4ell8VQskDc?=
 =?us-ascii?Q?wuuUix55s+qn3vh27S/VXSL8sybNKkMPqlQ25znX9DgcF7iNHU9ggAWdvvzL?=
 =?us-ascii?Q?trcxW51cbM/Xa4bVwavYJcl9X8FPQKgb20+d+dFD92Hu1HE/XJQMzysZKUIF?=
 =?us-ascii?Q?3a452W68E8F7Ib+PSf/+ZAiR+XHdY6I6Phr/oOZ71Md2h1KEZ6FP+LHaAnoi?=
 =?us-ascii?Q?fkwvwIhOfl8VZuxgiPfcJlnifJxRcbKQdURUhkhme2cJo1zLSVQfs4xkUdKM?=
 =?us-ascii?Q?e3OI8QNgp6qV7eKA8q8qo7MSTDlplo9FBrDo+dGG1pRJgqatyGESerCV0cQL?=
 =?us-ascii?Q?mjadTLdoyTj1syghiBxMBzoG0J+Vqdo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a57d60b-d8da-40ed-2fa5-08df449dee16
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:40.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cHDlGv55iVeJtHJC3TQcknOs23x2OD7H70/nptuS69cC01W4BsYjwMLFLRtnPURbHN+e8LWBM3j/C/0K8Y4YfOaYcn6mbWsbuTMUcCtsdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24826
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 13251a75..d584145f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
=20
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
+    commit: 17565d933c90220041a8411c0162d96dc43114ed
     layers:
       meta:
=20
--=20
2.47.3

