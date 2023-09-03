Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07919C71153
	for <webhook@archiver.kernel.org>; Sun,  3 Sep 2023 08:11:05 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.40])
 by mx.groups.io with SMTP id smtpd.web10.24206.1693728660812254935
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Sep 2023 01:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=orw71Hbo;
 spf=pass (domain: siemens.com, ip: 40.107.13.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgB+/HcrdNUNfzgoqHEuq8ESXWWk3ThBeuKtcHDMxtD4VGFs8tohqhHBftfy8agq8IbTDm5nEM0ctjYveEBxE3mpopUF84y8o7ogoFI86Ifzb0CyEYnRRmMJdVIb8uo40ZfTAabe9qdIp2/qK8469H3zP1VSU2woBlm43GN4z3AwwgpTA5sLCss6dbBIRmSWuxj418bd7HgzIgSw6mH8EkeYSgMrN5nms9EkXbbeT2DWOhR6QapIJbMhHN7+eFwaZ50+GS5KDubgE0rW0sPfJFzwg9wa+aIewvo6vTW9SvjmAMPu5LYFC14LFwtLR86SOEmFOuHZ7pJlPZiSTWnBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iSzqXka8anud5StLsTc44LWqFym2Bfwoa+eRkqHDpY=;
 b=bg5sfIvZty2MQvgCw49ymdgFmN0W9zZKM/1QM7HWb0Gqp9W4yZrcYl5XoEPsQmKidQXxSxVMeXEz3uVGdHyqk6EEgRmfOiBbbt3NS7aL2YLaK8P/Mp3k0vBO3PU5pLSmIOX+Q1rQGFK31Oo1vx8dS+ShcGC7q1BaEDa2T48C1dB300Cwzgx9vgPwVpdEvaVpULI0tjMWiZ7DedAIUnxcTs5LZyJA0OhsJypdkmEVx9d/HRxQmS1s2XdCGxBqVuBVFiAk+xvwGdLrxqCSt8jGS4lv/3HMSCLDwKIvQzYq/P8v7pWPEF+qCWGLRMEl8sNooPN3vONF1FILuIEyAgfcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iSzqXka8anud5StLsTc44LWqFym2Bfwoa+eRkqHDpY=;
 b=orw71Hboa3FwcSgYgxaLU9cD6tyY1lsNB+BS6aI5hkERRMdCVpC9LUoDOiSrm5SSjgMPVeEOfZijQlkwCs3iU7t+3+yc99F7KQfiW2iz6QTTfF9bXSVH4NDo0OMuPdYMPzEb02qxJyzr9/8myJbInepnNo1UjFemQjMXWjpwlv/daMosnRnRt5aTnZrlrue3a/bSA2NbunwfLNjEie6ntNtJ81ESQHmibDyllGTb/h3dHYQjq2rQpCF4/jKaHtMBVhybrbvnF1swbGBFtwr7Ie5fSg9GzgQoPHEKlTbhxse4GSVB2fev2pqbkBPb79Yx6GXoITbtJnhwMbcD4qNVdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 08:10:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 08:10:56 +0000
Message-ID: <9bcf181b-061f-4fe1-95a1-0773c52390c0@siemens.com>
Date: Sun, 3 Sep 2023 10:10:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to v6.1.46-cip4-rt2
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4245c785-cdd7-4302-e3d6-08dbac554c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4T5wY3phDcv6K+yj+7kfV3Nf/lLD1quRbpccI9k2iKinJHBawNZFny2MrNkpbHn5xvJfsOe2JFlgz6LrA2vfd/5BwE/FQRA44s42JZ3Tt+aVkMGkp8UUaPYsDys7T2nqOCmS+rd6YbhNTR4wZUPxtzqNUlTAhsWq2QZFXQKahekVQLlC4Ql3Z7L1C1of01DMsabDVGD/Gu8VwW8Sy14285jBXj2+F4zz/3232yzCCSNDoG//kF7XPq8pklVPqpZU6eYgpK1J5ZKrxcMbIkWOhhl9P6bYkORM5TCgfShKjwYdFuHo3ZS6Y8Cjn1EUQRvUph3yeFH5J0nn7kyr2b5Fa9BrCYusjJgplzR5xyG4boF+rqp8zMx1b0U+y/vq+JE/mseWROPnaJyYTStNabkPhSB0uAYuDYg0yjw7ZexFrXGk2SFU9APePh7pBaSyHZo+sDsAmOa3u6IGhoQ0C23jhpH/2fXKO8N8cqUwZf5ZAGw4ONbdCRWZlyqhssKiGN7cxHfqGI0f/eO7eW49Kb+dTuXN1AYHCV3vDTx9mAWcNAjRPapt9QQiRm47x3PRnvJ+UmidA0LuXpj44Ko845MHoy5rM9jKmzTUSileJ9nmt5F6ih9MqLLCwMVaJW8NkPt4tJg0P8x53JU5xErLGVgeSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(478600001)(82960400001)(38100700002)(83380400001)(2616005)(26005)(6512007)(66946007)(36756003)(2906002)(66476007)(66556008)(6916009)(316002)(86362001)(31696002)(31686004)(5660300002)(44832011)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUxzYmNpRCs3L1pVQ1NLNkxpbDl2aTFqVGFHd0JTZEpQOThhM1ZBNWRlaHJn?=
 =?utf-8?B?Rjl3c1J2cHhUS2R6alZ0UDV2SldKUWdBT2ZUSVJZVXh6RGV2bmZXTFlLdUJt?=
 =?utf-8?B?YjV0MjZBQXNLVWtNY2JyN1AzQ1pRam96dVFTUEFUM2RKVEMyV0d4ZzZlaWlB?=
 =?utf-8?B?MXZsM1BHRGFZazZ3SG5Bdk54K01hZG5WL0FNdEdCTzgvUWh2bXB6YUZVcHdJ?=
 =?utf-8?B?cCs1elRoMUltWnVIcmpmZjJDcHRrZ2toODJpTDNvTnlLT2p6V2QvUlFwS3Q1?=
 =?utf-8?B?Yi84RUNWU0pnOXVjaDA2ZUpDUzVTTXNoenNPWXBMWHhPZTRDMkpWUjF3aXdJ?=
 =?utf-8?B?ZnFZY3dBTktEWWJKbHFGWlVEUzRpTDJGdXNQQ0xQcWk2R3dNUG1KbEpKTkFm?=
 =?utf-8?B?bldHOGlGeStKTklSN3BQVXBRMXYwcmYyQTE2aFZoNHBaTDAvbjF2S1MzdVl1?=
 =?utf-8?B?cVFHU2RUanZSQWt3aDRIcWxKaDdEdm91SXJlK3ZhL3NkZjZkb2RZWnl5ajQy?=
 =?utf-8?B?K1NMMFFwcDBqYzY1QW1rb3dDUEp1SklUWS8xdTlxcFJpNlpJZ2tHVUROUmdF?=
 =?utf-8?B?QnMzRWNiSitDQ2w5YkQ3dmZiQ3BuWElMbDNkckVpTWlPWDJ1Ukk1YmdtakZH?=
 =?utf-8?B?d0NUUDMydGtqc0xSYWZDWU1JbXgwb2o1TUNOOHh1bTgwUTNjUGtsOGFTSXQ1?=
 =?utf-8?B?M0VvNmVpc2lLZUxpcmVSMm0rRlJTdkNrK1dsTXl6ZG4vVXplYU5qOVRVbEpS?=
 =?utf-8?B?NlQ1SVpPYnp6QjVFYUdvWHdOU29TTVBWOUZpNVlBdVV6ekFOYjVRTG9ZR1dV?=
 =?utf-8?B?cWcwZHErTnZ5c2tMb2g5M1diOHNEb0lIMDB0SkR4RUFiWWo0UG5PdGpxUXVM?=
 =?utf-8?B?bng3MEh2Y2FIVU5TQmgrZ2F3ZVgwTGRoMGllZHJoOFJKV0RzblBHTk1PSC9y?=
 =?utf-8?B?dUIrRmIrM0tQRmlwT1hyYTBlN1p1UG1odFcrTkZGejFmcVBqMDJQa296aXY1?=
 =?utf-8?B?Nm5qL1hGOWZ0U2NLaWJ3cmpIVjU4dmtjcjJsakU0OHRhUVpVTXp4cmplUklS?=
 =?utf-8?B?c2VqdlBhMThpY29qUVZHeXYyOVlrRFF2VmFLc3VnM0VZUWd3VkdQdzA3ZFJD?=
 =?utf-8?B?aW1NOWI5cFIxa3MzR2lXeVRCb21YQmpkQ0ljWjNPZlBzWUlDYjFzdG9mbzlF?=
 =?utf-8?B?bEFxbEgvN2xzMDZ4bUkzekNnNFJGVlRRS256YmlPQWJJdmlOSFhyek1raTZ4?=
 =?utf-8?B?blQ2OGZRMVFtd2RVSzRCUzJGbjFRRzMzTDhKeTJsb3U5YmxpRG1ZTGdqK2ZF?=
 =?utf-8?B?RjlqNFBEN0lvamVvL1JoczVSdEZvWk9Ka3I3Mlp6WXc2U0RpYms4VVgyek4x?=
 =?utf-8?B?TGo4bjlDMlovRndXSDF3MUlPTkxYQjEyaTlwbitZSzVNRGp4ZHpXRW80VDdE?=
 =?utf-8?B?cUF3Q3QwY25OY0ZkMTRqN3lnTGdhV1dMcjdDVzEwNHZ3NVdhY01OSmlwaTBn?=
 =?utf-8?B?KzRtWGkydkwrRVhadnc1NHBybW1YaGZxc3lJeDF1UkdKWWdmbHF5QmNMazZJ?=
 =?utf-8?B?Vi9ULzZGazRITmJJWWpNTUY3QjRzbWl5bzcyMngyS0lrazBjaTIyRjlLK1Qy?=
 =?utf-8?B?b1gzdmdHeDBXcUI3OVUvU3d3SEFpNUQ2dmtNcm9ETE5CejRZLzN4U1Q4VE4w?=
 =?utf-8?B?b085WkNUbWFXRGI4QTRMSkg3SGxCdVd5SmJwczAwTmdwTDVrQkhKZFZtTGFn?=
 =?utf-8?B?Qi9jYWdOVFlrTnhaT2VkTlhNZ0dYRXYvWVA1clBhb1NNbTlLWTBQci9neHIx?=
 =?utf-8?B?MTF2NExkVVpndzVkTkJVbzB1ZnpwTmZ3YytJOHhOQTNaZnYxMVM5WjhUTUZ6?=
 =?utf-8?B?azdUZEpMdDlRMUVEWkozSVBTYUpVd0d5eE5ndDhoVnFCd3Rkc243SlBWQ2ZQ?=
 =?utf-8?B?ZklCTXRmTVVJaUtuaWxKaW93bjVzT2ZRYlE1Tno4ejNmWW5SRmlWYk9QZ29u?=
 =?utf-8?B?L1k5cmVVMnBkT0YvNXdCU3VnVG5NWjBMdmlkMCtnZUwwbzdGZko5elA1RnR6?=
 =?utf-8?B?a3hlOUlSb3V2emtWaFlZUFk1NTJZR1JtVkNzTlUyRVZ1TVBmZnI2b3RXNi9U?=
 =?utf-8?Q?8VYzi6I54kS1zFTVTadZX4svz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4245c785-cdd7-4302-e3d6-08dbac554c9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 08:10:56.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOxkOYDMXmx3oghcgenP5u1WGgdXoXyNpJzv0yV0iYjEzWPMQIYfGITcttTfCWHvav5IHmkba8iVQD9BehbI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7890
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Sep 2023 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12937

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

changes in v2:
 - fix miscalculated checksum

 ...ip-rt_6.1.38-cip1-rt1.bb => linux-cip-rt_6.1.46-cip4-rt2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.38-cip1-rt1.bb => linux-cip-rt_6.1.46-cip4-rt2.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
index a1ba50a9..89610e17 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.38-cip1-rt1.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "5e4dd386aa8a4cce341b8efeec76320feed53770ead67c838ffb321edd47b157"
+SRC_URI[sha256sum] = "f59d2c191269709d1873a445189281adb5c2f26ccdcaa459ea495d2ef7ac7b28"
-- 
2.35.3

