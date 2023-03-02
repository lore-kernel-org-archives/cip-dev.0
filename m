Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A29FC678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:18:01 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.51])
 by mx.groups.io with SMTP id smtpd.web10.5158.1677788276158033452
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:17:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Grgqqpic;
 spf=pass (domain: siemens.com, ip: 40.107.104.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POuqePhrZWpHNvTUyCalW0QwJUU17//uLk3+fTKg1SYcYIfBtAkP1hh9ZAHPc7BkaafxA82adxQ0IvL4tGjMTDyJ4hl3XdTD9tBYn4filfnVdwh3vsA2uEocY9jRXSCIqZ2EbF91ECIbV7YNHAIIPiKMSjgMpQZPrNMbGSVVxI4Q5YKgCvGzJe2u+Ok9qz2ykiTK+iYQR+1+vFv6+hMN+m39PTnk5eGtTKOD2/r8k1W4IB22HCheGOhVa21BtoAwNNyMukIhQf8JYMY5ftWYSDYDk836OkfTrPbMe+3wQ4qd3Z8f2WYDjIef1VLto9KyFGNC6p74mmhnPrc5hzKufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZzwZ0Zi8x6Lv360k0AJHvAyM3t11CCHvAdrHfGhFZA=;
 b=mIFknnRnniSPBspx3zQHEwE9dvwv/MStZEDRzck9fV4a6TMEbuV19v4O66TX04LRRN+4BkZtUetz0E2U60GrSkjAPGqoy/i0l/sa+OoElC7vGgeHJaf5GdtiZ8YJL/UuzcqY2sq9t9kQR3RkWiRcQ8jS3k/cIY6pTHfpl3EShVjF+RtVtfW3gJS2EkJNAAt3WZ6/kIUhq5ZJEkboG9+nrPHWDrvfCOBMj1VYEZRtf06iypR52ilColrxHDGpMgE5jjgo53g6iJWT9BRJwXQJBlOb2isC0jDx/Iu/RpGyBH5mYiYZidwnlcqTWcMtBEgvdV6dQ8f1631syxM5iyLcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZzwZ0Zi8x6Lv360k0AJHvAyM3t11CCHvAdrHfGhFZA=;
 b=GrgqqpicjYNhYcGgVGh7cZrRiqYbY46eDCfoY68spTQ0SG9XAK++tRxsM9F6XzoJcwI3dCTmOiADkp7pzBZgdJAmCw5IWAcUzrdLLPAOlb9K9II99vTtrhtBQ1v8Hc7yaKqYJ0ThW0I8vbD1VOLCGUk+yw4M9XQlRnXnyiRE8LQeY0Oequ3BBuffmiHQIVPahgJ3Spi69iLBdBziRvEYm0ZqdLwJMVW4dU6/09GrpQ9d2gkynwawEKMlrBn2xTUVUKccUPLCtd1S8wuDXXHE4AcV7vFZdbUrPSC9DJQyuULIAC73eLg395xVzZU0wb9dZexm6SvktlRE9YiGWxskZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 20:17:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Thu, 2 Mar 2023
 20:17:53 +0000
Message-ID: <912c4a8b-4bab-241c-722b-dae967b7f100@siemens.com>
Date: Thu, 2 Mar 2023 21:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] ci: Fix typo in job name
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ad4394-f52a-45eb-2f8e-08db1b5b33df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5InbUbGFBn9/vQfaiI8h0s1rp0gxoA5hdyb6fgoGZCVVBS1YUMae6Xda+uGTTRJ70H+ZGC+Vz+/+0LpnRSbl5dRnEYcjU34eGZ/q4gimIvSWrNys8btVPSlB7Rnh37GreWeQIX6Aa8eMtJwOV17Zg4MTswsXycI0AX+06KX3YChpWK+7QzJhjrvkSk1RoU60REKadib0LJqwCxcBsmEJ50MOnvideG8q6bD5w7ks2vDGTFhVkxBCe98C6Z4+udOAupTVjLqTjo8S/V+/l81HWwoIeJQAu9ZiygMIzg3P1qWnQWB7SHfaVR/Zg0YyTLTw182fKhUpo7trnVu4qXhfmxxmxyTl9xUHvYrIrh9JUdlIax/jnZnpsd+YCtkRraD6UNKcVEJxgTe87MW5ZzjHk26PUvdC3QcwMDIvHZJ5kB+x5CKHxhCmmQN0OiH0wjiE0tppe/ypbnmy/4XN1Snf5e5CHulfSoQzcxFThYpTPwtEnQ67QnhUqrWV++tL+ofEAjm7z4jElSobwUhkkJr27fhCq5HbenzUG+rBlJZoA/2W5cvbYUtWXJsFnUra+Bqjac9lst9e8lEyuZ4xCN5fpWNCaeKpgN8/oPFHsv10DrY7JwucDt+ijHW+dLBx6BU0Qj3fem0qPvSHjrhp0u9RLOoB7kFngZGFab9CQ/QADQoPVN2gB5NyKg61oK0yE+WW46whBqJvOu1KZTxb+sJCM/aPuLwSYXzfubG2wy28KCg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(36756003)(478600001)(83380400001)(4744005)(6512007)(41300700001)(6486002)(6506007)(26005)(38100700002)(186003)(2616005)(44832011)(86362001)(66946007)(5660300002)(8936002)(2906002)(66556008)(6916009)(8676002)(66476007)(31696002)(82960400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXI1MGdoem1IdG1qMkFMNlhLSVhNd1JzYUV0VExLTVl0cnJUOG9zc1RhUnhh?=
 =?utf-8?B?QUs1bE0wZlFKS0hDTENpUmcrWGNNTVkyNXBjSmgwY3BVelRURFpZTGVXTFJM?=
 =?utf-8?B?TW5IZXM5K3laK1hjZHVFM2czK1Z3WVlrbmpkYStXVGx3Z2JTbS8zTCtETWFS?=
 =?utf-8?B?MUIwWWxjZUcwZzlLTTYrWjRhOHJrZFZWSnBWeWZ4N3VzZDdIMUxnNUI3cjhQ?=
 =?utf-8?B?ckdEclhBL09jUXpsOUcrcDJpQXpSTWJBd0piampNWnVPOVE2bjZVRlVSU1hz?=
 =?utf-8?B?UUhyOUhLK1ZuQWJhdWJ2QU1VR3psOVVESUF5aDBVUjR2MjFBWnlTK2pKSExt?=
 =?utf-8?B?d3FrMkE1WUYyN0NMVksrNGtzWnd0TXlobUxGbnBnUnFzUElSbFJEL0RYYmtt?=
 =?utf-8?B?RExzenorcENGbm45M2JFOEhsMTJFTEdvR3o3RGpXNU1aellxWjVvSzVGZEpn?=
 =?utf-8?B?dCt4U0hPYTVMWDI3aVcyUU1wc1grbDJvUXNIL29HeGdmY2ZlOWhHait2YTlv?=
 =?utf-8?B?MnNqZHE3MFVReWM1QmYvUTRHRVVGSW9oY1QzNzhHVDAwL1Z5SGFpVS9NeGtS?=
 =?utf-8?B?TWJWUkJSelJjMDFRSVRRWDV6SjJZWEFvbCsyc29QMDNWQkU1Q0lDVXYybWUv?=
 =?utf-8?B?UTJrWVJGTklsbEg2TVljNEFGOFVjaVhWZGNXbERBT1I5Ym1YV2VucWlTbExM?=
 =?utf-8?B?SEZCSVpTRk40MkF1dkdxSGxpWGJnVlJHUXBnRm9HcEJSbDIxa0lSZ2pNMnM0?=
 =?utf-8?B?RXJzYmZvNWdFZ2pvN1c3bUlpWGd4cnNiYitVRk5UU29ENmxkRXpBRWhncFFw?=
 =?utf-8?B?TVA3bENWb3BnTXNDYWVrbEtac1BoeVhac2J3enF6aW9ad0NPMGI4ZVNQblpJ?=
 =?utf-8?B?c29OejZKSW1XMlFEc002MDJYclE0QXVFUjlyd0ZaSW4rWGJIb2d3bm5WQStj?=
 =?utf-8?B?eVNzOCtaaGtqekwwVjh2N3NuVG55UVJHS3FPVzY1U01aN1p4VUJsanc2eUND?=
 =?utf-8?B?eTBiWUVyTWw4VTFGd2xGa1FqdEhhV3lpZ0QzdSs5Z3V5MEc4RzNQYytxL2pp?=
 =?utf-8?B?N3VWcERhUUl3cXRJVXRDem1DTjhNVWhpV1BGSGFCekVKbDhENDk1ZWJVVVNM?=
 =?utf-8?B?R2w3bXJDM3kyUWZEbkZLR2luWUxkdG1nNGF3TlhaeXZyT1VReEJlWitTU1Av?=
 =?utf-8?B?TVFkN0NVdDE0TWxBc0R3TVRlNEVRQkZGd0FRYjZjdDZ2U0NoOTN5dko1U3A2?=
 =?utf-8?B?aWFrdWszNFlnaUVlc3pnYmlHUkRqcGExOFlJeUtpZ00rN0ZGamc2Ykl0dXVR?=
 =?utf-8?B?dmw0VGtaYitidXR5RURidVh0MkYwdCtPdy9xekdCN2VLMUpmdFRUQVNraVlv?=
 =?utf-8?B?Zmw2MGw5YU5EcUxBSHZ2bUgvU3VIQU5PQ1UwRjhaeHJFaWNtMHZCOXdpMXJt?=
 =?utf-8?B?WjVGN1J6R0lQc0krbnQ0VG5aZmdVUWo5Q0U1RHhjS3I0bys3czlraWpsWHJJ?=
 =?utf-8?B?ZWx5MDdlUjU2dnZSTlFRSWprdHE2R29NOWtnMXBrdVF5TVhtZWFsQm1kVmVV?=
 =?utf-8?B?UEp3bDVuQ0pIckZzT0pDKzE3ZWowWTl2UFROa084T3JWb3lpYXhvbG9VczdR?=
 =?utf-8?B?bHlEMXhjUXgyc1ltWjJyTmpxd0p2UytYS2l6VzNGVjkydTAvcW1vZHVOczUw?=
 =?utf-8?B?cTNZeUdML0lDQU1CWm1PL2FQSTA3NGE1UDVyMzJFZlBWWmoxSFAyYVFzTHNy?=
 =?utf-8?B?R3l0NDZtM0V6Ky96dHZyUnZreTcvd0xQbHpGLzZnY0d4L29WOXFjZC9rVnVC?=
 =?utf-8?B?aFo1SUtncWNFQzhqUzNCOVkxSFRQUEw2cFkxaHVsaXMwSlo3UXBoaWoycGVu?=
 =?utf-8?B?eXpoZ3R2Z25ha296VklHRkNyV2E4Zk1rNm44blNjZ0tzOC9hNDh6UDFCRWxJ?=
 =?utf-8?B?MnhqWTgrd2M2MUFIMmYwaWdoSnh0Z01wTk9Vdld0aHh3cWZuNmNBRUNmOHlR?=
 =?utf-8?B?SW9CNlJNellTY0l2TjZTanZRL2VwK2JWVE9jdU41T0JDYXBZSmU1c3VITUZ4?=
 =?utf-8?B?Z2wrbEZPdU5NbVZVWHRjOGUrbEtaeWRtVEdvaWJsRWMxQ2RsRjdRZ3phdEUy?=
 =?utf-8?B?b1NjOXZBdy92K1RlR3pSc1RwaEhtWEFQNHNMWmo4QlFBVGxORDdhMmtyQ1Bj?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ad4394-f52a-45eb-2f8e-08db1b5b33df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:17:53.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnHHnpDh+WcnlGFGbmmHO/3RqhPA52UbKGudI7eDbgK6GkSEX4btiLfEYgMAnhNPtdmBe9y6qairVXGfEzkCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10884

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7aa61ecb..f51b64b3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -301,7 +301,7 @@ build:qemu-amd64-secure-boot-buster:
     deploy: disable
 
 # riscv64 (sid-ports)
-build:qemu-risv64:
+build:qemu-riscv64:
   extends:
     - .build_base
   variables:
-- 
2.35.3

