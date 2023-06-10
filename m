Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90CC77B7A
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 09:55:59 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.61])
 by mx.groups.io with SMTP id smtpd.web11.14732.1686390950434736485
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Jun 2023 02:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JxKpJclP;
 spf=pass (domain: siemens.com, ip: 40.107.105.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFuKXyT5/aOlvnHe4DqQbQyRyYptnmQkFzimH5SUYIhzeZNa8WqizPLNpGoGt+BiKqt0vlQzziYTnViuFYmUmmqLtia9gn0DYBRB1y5BeU200LdZDYLmmCiEpQNAQWJo2imqvd8meqtd+USg9hrKFqGYvIXtZMhGD07+UKcHwSDRVycAGAOWIIuee9fGOuRyBtBLVGDoJqipYjTWWKFl5vuh7ySCDDQaNTPrzrHnWu2SFjE37WAkTMDH93TU/xbDD19O5CvECn+yICqkh8TDT8+AfLMiEkHC301YIqkkclMp3vFSaOgUNBID93yOUxAxTNFEDhFGhOcV5sWSAG5+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTpsukBUZCJEizgJJTkCrdl7vDpTkYBC/uafyUXb3YI=;
 b=N+V7Onn79Gyf5GrgzPWEN8+riK/X32zIXCYLfGHE13vAPmt4zt48o5HVKbbVK96BMy5AxFxR0Si6fKP7pV+fTlULSTXhUTboDbF5yw2cr1MBNIKoYHQpffXuAHPKzT4yFXl1GmPGMzRLcmlvxnqSzLB1n+olrD1cCJYOctHMoDRRoAN2BlPxzOghPTTjgJiSl4O58GJuH1DJNWQpaDBxHAOovvkSP1pOnkDUer+dnN1agEkZM70ukDOB7ZoT3ROlGe+Jp2OEOMONI+pfPecUU59S94mPSniOi20OUync3beWBMnvlki+JYdN/7kBr4+QGpHRPM/dkhm7oa1G+IorlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTpsukBUZCJEizgJJTkCrdl7vDpTkYBC/uafyUXb3YI=;
 b=JxKpJclPoBgKmm7+y53MX7CFAz5yN9Q7WQCWJ3TXkSNUz37RuexpzLZjHFqxCUyvNjSTMEfdDD1BtGpTjLJ/kTniFw06EVo7YuJ1xgthtXSrJmhCLG5l/HgvmS5BJ49+k32X8NnktYQdB8jyiijD3XQ/KjylEq8V3TSAaCWYdgq+0NMqwy8q47hAXGkZ35cybkCgVOlVzvAaT7zloKM5tkncT9zt8gf/42QqPywzQkOyZGSJZbPyq6n+exhJSifKoEVKuf4M6NhX1pUvEIJj4vpfIxmQrghc9j3DE01QhUnBhACGmsF4hO4o1x97tgWWR4+7+pizusTo3I6CkbNoVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 09:55:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Sat, 10 Jun 2023
 09:55:46 +0000
Message-ID: <e2c82aaf-5c90-778b-d324-630e5d846871@siemens.com>
Date: Sat, 10 Jun 2023 11:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to
 edk2-stable202305
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 "Schultschik, Sven Angelo (PD PA CI R&D 4)" <sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: aa80157c-c219-4af7-157e-08db6998dce4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cmrle9Ma5ogAiAtYcKYK/CwR0Jscgso6aRR+fMhExyyYfHI+QkxmJc0iVCydAiDd7Z1R4lH/QI/PNV79tjbNEb4bkKTCE6GDcVhholnyXWx/ClBQtMRd0tosa0RxlpXXemrD/DuDWxK99Fgzo4LhYivBvzhMbgvqiq/otud9ZKi0vEYdXyxwKe1z6aqRo4bXk3D8ie/+x2esSZauujAcypedBa4lWjQRQ9J5QNFgqm8SxQpAO4/YnSZ09qWRlNZCQXj2kgVmA3MoQTCtndDUD8OLWeLXRQ2FGXN4oK9eMKU5ElYl2R8q2OotDxTAvHbphn1ZJVgQ7lNkdR/+8YP2HG7tMLtBYe7nStIz/ARRjF+kHYJlu93dLaoK5dutuvn8DohA0dgZ580mZ21fYuvIUf0oR/U5xUZljI6PmLguuAYObejg6VsPaKih9Dg893LyWCwMyMof0rm4kwPHbRk11HR88oD4aZFaOb7X9WQUbM+dYnzwl2XS2Ku0aiDdvQ3T3gETo3zhME70sMEgw1NxC908MiSctlsviYMauoVOTHtRZ6cdXV0D/Ikld7TpW/ayfU3pe5zC/hcOtGe3vQ3bVe6EoHJ4nnp8B0HiUhxLHHNupOeP51f6turbOuRM0W33TcD8xdlshg85rPLQUBCJLTtxgiH/Ppm0H/IgecxoYF73KXlIbuYUuCqt+8m66yEF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(107886003)(6486002)(6666004)(966005)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(82960400001)(6506007)(6512007)(26005)(186003)(2906002)(54906003)(5660300002)(8676002)(44832011)(8936002)(316002)(41300700001)(31686004)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzJtZWs2Tmhmdmk5YkpwQlFZT2FiK1pwa1lweGIrdkFVTitsSFZLQnVGbDhx?=
 =?utf-8?B?TTVzK3JaZGk5elNyOG5US29STk9DQ2h2MHdieFEzblUyYmNlU2llTEo2Y3Qy?=
 =?utf-8?B?bHZVWDlpYzM5ZnNYZWdVY2VmNGJlZlJVSnRlYThjNWYvdnkrem1kUnhSQWhK?=
 =?utf-8?B?emJxMDRqd1ZTVWVlc0QyTUtud3NFb0MxQXBTR1h6TzBvWU1rUE9wZUk0d3pn?=
 =?utf-8?B?T2l3SERWOTdBWHNvNjBNRmFwOG5WWFZpOEVJemEvUUFwcExqMUhRS2FNWFlQ?=
 =?utf-8?B?RkdqdHhFTWM2NVFDS2ExSndXaytTaVh2cG1BeDRhbnlQK0FOZ290UmR6Q1N6?=
 =?utf-8?B?M2ROYnBZTnROc0xQUGptZW1PdnNxZ0ZzSjN2eTdBTWZYTGhPbXNCZCtkQVJj?=
 =?utf-8?B?YittQ3ZuOFFvL0QzYk9oRWw0MVZSdE41a3BVZmhzRnRIUmFHNTIrSC9rWnRk?=
 =?utf-8?B?cFhNVy8vdVI5TmMyUGU5SUI0STUwZnA4c1dxL25PVGpnRGtjUS9BYWFRSlVU?=
 =?utf-8?B?N0g5Yzd3aDJJdVBCNGpSVGVRZjdWZXFHYnlxSmhLalVVcGNLcHJKTjRlM3Ft?=
 =?utf-8?B?ZUxid0puSXoxRVEyVVlRcDltQll2MGRJZU1NVmovUFY1ekJuTUs5N0ZkcGcw?=
 =?utf-8?B?elQ4NzlxRkh2Z2s4d2FaT1NyM01ocis1MTlwUjVubWRnMHFGWUVFenZ4b3lJ?=
 =?utf-8?B?dWhDdVZzRmtIV043eHl6OXlDNldNbFRzcTQ2ZWhWaUhKRGZxRFhPc0VBVXZZ?=
 =?utf-8?B?d1VrN1Y3OWszRUNQUmd1blhDQkV0Y0crZUxUbGM4UVk1S2VaUWtQMFNOOExt?=
 =?utf-8?B?RlJkOUE4WFBVYlpLQWFlaWl2dGY4UVF5dmtjTUIzdDB4cEpxQ0oyZEMvbzJG?=
 =?utf-8?B?MGRGT3MrWEtsTisyNGVoOGJuVnhzV20rVzgxTGw0aWk1a1dhYjMyUUhEL3k4?=
 =?utf-8?B?Z3lWK05NL1JoVnU5UmEwVTdJKzd4QmNuQXR1Q1NMSUZFYmhFS2RtSU1PeVIw?=
 =?utf-8?B?L011NEFIMm9Nd20ydC82MkNoSVFiWWQrMzZhaDJCdGJBWGhzSGI2T3RyU0Yv?=
 =?utf-8?B?SUdseW1SYXhqdDJBdGRHZ1RNSG4yRUhiWWtpUjNhOVpkaVg3RkZJWk5KaGln?=
 =?utf-8?B?VGNtUlJWVlJITW9CdFV3dzZKT3VyYVVpd1lJTHhHT2lJUm5sTFRUakpac0or?=
 =?utf-8?B?RW9TWlNNd3Fyb3V6UDlCMkxCbThLQm4yWVpsRklpczFWaks1aUFDMklBWHNp?=
 =?utf-8?B?WFhyd2RCMHhTQzhkSCsrejAxMW9HYUx2R0x4TnpSN3lDcXhWNXBxUlVEQWRK?=
 =?utf-8?B?RmxDMStneUtMMHhjZVEvSlFUdEF5UlVJUk0vaTV2ZlNqTTJTZS9LVlpsODBo?=
 =?utf-8?B?QXRTSXdXMnJnbzlQRHFMblgxY2xLbWt3eXd5TUo3SjZ0ekwzK2l0VFNNbzEv?=
 =?utf-8?B?Y21YTVZyWC9KOEJMQTFNM2k4N0hrMzJLWk5GV1pwMjhzOGs1UjFQNDNaRjB0?=
 =?utf-8?B?ZWxMZzM1YmdweThDK0tkMzZnNVVOeTkrUUF3V1ExVkxOV2s3VjBlWk1PWlBI?=
 =?utf-8?B?ekMrdVRvRjBxSnJSSGs0SDVnRkRWUk9TbWtLZEZvaTBuYUFuN3dEMGJsUXkv?=
 =?utf-8?B?R1o4NzlvaHFYN0oyLzZOdlMydmRBcUE4NVdUSmVXQVd0ejYwVCtpQWZnZTFT?=
 =?utf-8?B?a0trdXFQbndlckxBMFhQMW1lM21lOHlDcnZ3YTlCZElFamQ2aDJmVGtFeTB1?=
 =?utf-8?B?ZnlCQnZqa010Mkp3ZEFhb01PMk54c0ZkekZjRzd0alMzeUVEMzZCRUs2NXRW?=
 =?utf-8?B?eGRhUXY3c1o0T1R1a0FaemdlR2dZRmVVSFJQRFlIMVBFQU5aOUZLbFZmOXEy?=
 =?utf-8?B?M2phV0k1YnBUcDBPVzlQNml0ZVpKVUZvVVBSOGJybFM2N0t4SXNkd2RwbkRO?=
 =?utf-8?B?MC9XMHQ3UkQ1YkhnUTFnU1l3bWJXbFVFdXZrbE1WdmRHN2xPaGxXdERRdnJS?=
 =?utf-8?B?b1RybTRvaDFKdE14TVlaamdQaE1lR3FGMFVyTnhvbDU2WU9UTHBCcGhkL0Vm?=
 =?utf-8?B?MHV6d3FlNjBnUHczcVZ4TmJmSHZIOCs2VTBleUJNV3lZQ1dKbHFtVGh6QjZ3?=
 =?utf-8?Q?S0vA5mn6UvythmMBltW1tMQrR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80157c-c219-4af7-157e-08db6998dce4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 09:55:46.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWO0ZST/vkhFa1GcOe6cpePL3dw4jD4UVlEWkJe2duTEMQaEHii27bptIHBdM8r6O0biM3ZLL5reuPB3bCn4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4084
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 09:55:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11961

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings one new dependency: MIPI SyS-T, a tracing infrastructure.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...02211.bb => edk2-standalonemm-rpmb_202305.bb} | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
 rename recipes-bsp/edk2/{edk2-standalonemm-rpmb_202211.bb => edk2-standalonemm-rpmb_202305.bb} (69%)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
similarity index 69%
rename from recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
rename to recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
index 40d979d9..1a589184 100644
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
@@ -19,21 +19,24 @@ SRC_URI = " \
     https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;subdir=${S} \
     https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;subdir=${S} \
     https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
+    https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;subdir=${S} \
     https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
     file://rules \
     "
-SRC_URI[sha256sum] = "b7276c0496bf4983265bf3f9886b563af1ae6e93aade91f4634ead2b1338d1b4"
-SRC_URI[edk2-platforms.sha256sum] = "b0f5b6d832e4dcc1d47a98ae0560e0b955433e32e8ac6d12c946c66d5fa6f51a"
+SRC_URI[sha256sum] = "5f6c18cf1068089d669fbe81dab2325f8bf7b1298b192c276490b65e2edbbd94"
+SRC_URI[edk2-platforms.sha256sum] = "31257160ac51a4a5f63db92d26482d6a005286ed040dafe89d01f0ee906b111e"
 SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
-SRC_URI[openssl.sha256sum] = "6b2d2440ced8c802aaa61475919f0870ec556694c466ebea460e35ea2b14839e"
+SRC_URI[mipisyst.sha256sum] = "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
+SRC_URI[openssl.sha256sum] = "b1270f044e36452e15d1f2e18b702691a240b0445080282f2c7daaea8704ec5e"
 
 # according to edk2 submodules
 SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
+SRCREV-mipisyst = "370b5944c046bab043dd8b133727b2135af7747a"
 
 # revision closest to edk2 release
-SRCREV-edk2-platforms = "4ad557e494d8055f5ea16009d6e565cace6571d6"
+SRCREV-edk2-platforms = "b71f2bda9e4fc183068eef5d1d90a631181a2506"
 
-PV-openssl = "OpenSSL_1_1_1n"
+PV-openssl = "OpenSSL_1_1_1t"
 
 DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
 
@@ -49,6 +52,9 @@ do_prepare_build() {
     rm -rf ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
     ln -s ../../../../brotli-${SRCREV-brotli} ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
 
+    rm -rf ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
+    ln -s ../../../../public-mipi-sys-t-${SRCREV-mipisyst} ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
+
     rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
     ln -s ../../../../openssl-${PV-openssl} ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
 
-- 
2.35.3

