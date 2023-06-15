Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEBFEB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 17:05:12 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.83])
 by mx.groups.io with SMTP id smtpd.web10.24378.1686848708773762980
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 10:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d5eDfAgd;
 spf=pass (domain: siemens.com, ip: 40.107.104.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5rUrHqCu05WldUB0EboCRJBmiTytMWcyNK0TX51uW79JmjWKmZb3xRzQnWS41psNcCbfDbZyK1qAROMUTp+4nX1cQqAp60etFP7y/G223z2XtBgcYU3wtxFu1ohLJsw2j2rQjj1mqSUzLffDg2hx0QLKBrYttRcxRVu6zZ3/yjU3DlfkQJr9hyCaYb5CiTixI8/aGU6N50JlY2CMqgqDAnIcnlUrqNAqBGqCe0gsUJIDZjq33nqhi+cbLi3muEs/sveN+s+5JgqkuoeEZjSpp8L7OqHvj4AzDUZRSNcqvT9wbWzHfKfUnO7y8728/qqizg9cR/wWC+2rhnOjw0L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McfOVRTO13e6hnMyvl+4JTnCNF8gl6mDquyF11nf4MQ=;
 b=OfNqXhggIxyLWr/R68VjU+6xWaEtb3l0mPaIBz9whl4pRiGAOoMQlxgovaqERDzoQabI1ROg9JoTsvv8OHXit/RLY7YE4w9ab3BXhbGn7kdU5OIrS7XL/7OJxvyLBhuHAMwqVPZ26fcegW2IBkwmCAJ43KbXXiWVLYmt3TZ7Nq5qmIFvhgrcO1KgSpRlpq/YiMnDu4BJGganJ0KeWhb4WyiI30/0uAqJAv7e7dku939nGlDWBYwrCyBoL40KOR+HnDUdVLo3zk1gMkwkD9hwACX0A/nXfErE1XSP/dg6XyB4Y+fwv9xldwTyJ6IIBKdSYBa6DouYUmPo+Xz22fiyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McfOVRTO13e6hnMyvl+4JTnCNF8gl6mDquyF11nf4MQ=;
 b=d5eDfAgdLqcEZgZBt0D34GOKlSGXsapz7g8z5YDdPJ72dGQwWgYGfhw4JyLmc0owqD4Yv5A5UKufDmCyujPgj2s9bWofbG8ssFooVokYWcurnht4zsWUt4c/ydw+KaIZ6/lVtHYtZUUeUXw9U062/RZEaYBPoS6qVbfVhBgyQNf7ZHjrNW46fnz7btjaYWF5S3J5LkRr4k69QqYu3fdDCLeCnZyrmkFMDUNBltlqtsj9Qw+p3uedtmaj/MXr0v+eKS5iLqv6lAUPhSZ4Dct+A3dFKk6SQSvAwfWUTd6fpK2vdhsPZqavmNmGmMy+e0MMFg0+V8HaF/pGYlsyaPxoyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 17:05:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 17:05:04 +0000
Message-ID: <b572071c-d05c-167b-6a3e-363272e7c88e@siemens.com>
Date: Thu, 15 Jun 2023 19:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] customizations: Select EFI Boot Guard as
 bootloader in swupdate.cfg
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb236b9-c33a-4890-8139-08db6dc2a9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JXsMCROrZ4mDPTqxY+t97AVboI14dHuWoOpOd49T4DBoML9zTuzv9jskUm8O5iR9TsbCDHR1fnHuzXDlEg8CxEQ/VZde3U0aK8unmmhQ8UGHNcvhi6n/reoH+kcIgo9TGI76nI0l59P23bBQ8e+j2J7QelggDJY0W3UHbGGKqUamKMidjlIlEI4x8qhQw6hm1bWacr+3S+i8ykT/EFoP3eLlosE2/f+XpQt4UkxFfTJq3kgbhyazCdvNeVwCcfWIRZJ8G33ziK8x+prrP4wlFZkbnv1QqTGpqnXyQQA+RFUVrdLnEdm3qJnX3l7woswAoHPa1/0Tvs65737eA3rLnq7fGEyQ9azqTn/5q199Z9YkImKUCjRRxE9BmNBzB5/DfYgqf39MYPeKYigZfzmwqByrpKeFkZikpjITyiRVjPvC57wnhbAWv4NUWd5tULv8g5/Gc+EBAhA7DZQ8yFKl9dVNvNsdp1ogh6DEHtT+oMnYWgKny5xgXhXwiYBxlOeJOAxtX5/lwk/Jyu6acnnGWWobvAJNx6OwtqxHKYdaaYw2gEcGscNYqSiw9hXU/iM0Q2X5BmR0yZKnpPhqHEmNvj9B6Jd+TJ8cLzKbCIzu7JgqOaij//HFf7cmTeK0+Pe646rQc3xT18vxzEEPguahwA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(478600001)(82960400001)(6666004)(6486002)(38100700002)(107886003)(83380400001)(26005)(2616005)(186003)(36756003)(6512007)(6506007)(316002)(41300700001)(66946007)(6916009)(66556008)(66476007)(4326008)(44832011)(31696002)(86362001)(2906002)(31686004)(5660300002)(8676002)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVc1QkpTSlFmTjIrcTkxdklLZE9PMmVDbmlXWmNvVmdFdE9ZZGYrQzRmREVJ?=
 =?utf-8?B?KzhSRHQ2N004MVhLM3NqZWlDbis4REhiRmVBMk93MitqU0N2aGlrRDRqVk1k?=
 =?utf-8?B?eDk2Mll0dXdzbFVHS3lGbzc3M3lXdjRCY2UzR0g1T2NoZUVSbm84SkZZU281?=
 =?utf-8?B?c0d1bFRuOC9iNUZGMFF6dVNnVFBSTSt4UmRlYThvMFJSR3ByWDFmVUlHYW5E?=
 =?utf-8?B?bXlCMWFnQzFscnd6M3crc2JBR2xoSjFIcSt0SzZEdXFGblVUMldMU0M4d2VR?=
 =?utf-8?B?OTlVTDZ6YWZuZlFGMitxckJSazV1cUM4ZGNmQ1FXNXBqQWdUdE5ZeGJHblNS?=
 =?utf-8?B?S3VON3dhZWhhVndiSWo3dUVYc2pscUVRNkNkVURxb3ZzMjFPc01jcCtrT0N0?=
 =?utf-8?B?anZQNFpraFF6NEF6MERQT3RXdGczbTNic1BPOW80VmlZZWdLL2lZV21MWGlV?=
 =?utf-8?B?OWx1L0R1WmFud3B1cVJHNGFyVmUvbHp1M3Qvb2J2NUpSVWYwY1ptdm9ZaDVR?=
 =?utf-8?B?Q3ozdFBMVjFpNjl3eXNUQzZUWXZaUWNMNVJ6OTd6SWhSa2dCWGFzNmw5RWUz?=
 =?utf-8?B?dDdTRGlxTk5MZ2dPcUoza1J5WVdZM0xOYTdld2U3LzRZN0JKTkVEWVJvRlBa?=
 =?utf-8?B?UUZkbDVRSkhoakltanRqNXpmbjBicnQ3dGN1WnRjZGhGRktzd0Ewa2VGY2RK?=
 =?utf-8?B?SmhabkFjb0VkdFNJLzluSzZyRzlCUnk3SXlETXNSMmw4Y1RkVnZRK0JybU1q?=
 =?utf-8?B?MG5obkgrK2Y4SDA4OTh4UTI3cTViUm9qWXR2cEkva2lDbUxQeUR0MlYwQXNB?=
 =?utf-8?B?ZE5IdjFsa0l4cFJ0T2RzTVRUVDZNL0hzbzhId2N1RDNOdlZlL0l2SHhFMWJO?=
 =?utf-8?B?c2JyV3dmM1lSYVBPNmlZelVoYkJ0SHlqTkV4NmR4a013U1g4MUoxR25oNksz?=
 =?utf-8?B?Tkc3dzJNNzdwSlQvS0NSbDZFS0Z6aXlCek5zbE90NjIvYTN4Y05CVjZqaG5m?=
 =?utf-8?B?VEVtOW95b1JBZlovNDZwdllDVVJpdFF2NWw3RXA0ajNUVGQ0aGJBcDdGUnlR?=
 =?utf-8?B?TWh6QmJNMFdpb3VxY3NKUVdLVmxMa1NXZWxMMzAvV2VockVYeVJpc1J0S2pJ?=
 =?utf-8?B?MWdiTzAyQ0xEenNSa3J4aG44R3VKd3ZXL0JSZG1aL0V3SkkxZlZ6a0NPTTJJ?=
 =?utf-8?B?Qm84aW12QXppUjByeWxxSS96UHZaODhFcTZrVEQ4S1lZTVNlQ3NsTTJsZWlM?=
 =?utf-8?B?eHFOQURpYzdSRm9pY25LQldTVzAxTWZ2andRbXVacUNVb29KNkxaZHIvcUFu?=
 =?utf-8?B?dTkybnN3dUMzV0FkYjhNS0JLWk0zd2l2N0ZwZlVrbmZSNFo1aEdoVGI0VE9L?=
 =?utf-8?B?QUhPSFVsK1BUMUpSMWxqQzZPeWVINGdRMDVBOERtUzcxWTVSbmpNNzlWRVps?=
 =?utf-8?B?YXFzV2FtL3hWbWxvelNOQy9TaDhPSzVrVlIxb3BHSENyM0dLa2tSbWd2bFMz?=
 =?utf-8?B?dkl0cmxJWk9iVUVpckl0TzA3WkIrNDNrUjBmZG9MWVFKQi84N29UVHEzRFhj?=
 =?utf-8?B?cGdyN3B6L2ZQQVhHUFl3dG1UcjYrU2ZDdzdwQy9NNU9qZWpNYTdrT3U1RHZX?=
 =?utf-8?B?TTMzRi9nSlVxWmRLcEJtVzh6VmlhVjcrZWRLNVNEdzZrNmhoR240b0Y2dHFy?=
 =?utf-8?B?ZVBDbzh6Q1pueVhTS2VLVUE5cXAyeXpUcjZBWU85RGsvNlhnUXBROS9VLyt5?=
 =?utf-8?B?V1NZYkhGUFYrWDZ3NlRvS0UvTEE1bHIyL3FERER0ajBoRmltYjNucE83NlBz?=
 =?utf-8?B?RkUyazhmOXhvMGgvbDVPY2tTN3dsSDBlcmpZOGJHaUJYYldwZi9pSFZMK3NE?=
 =?utf-8?B?VnNtWnUwd0IralhwMlhXb3ZldHN0TCt1bUNjVVBCRGtHcGFrSm4vNnY5WGt3?=
 =?utf-8?B?UFpENkE0QVVaczJkYUxUV295K2RNa0VtVDl1b0FIS3ZScE9ZMWN0bzhiTVpF?=
 =?utf-8?B?N2ZsR3VYN1hwdUFYL1J0dEtRWWVsRnJZTXRFdnA3TExVZWpJWEczbERmTktv?=
 =?utf-8?B?VFRhU2JqN2RSWmptazVJbU1BZlp2YjRQSE1YK1ZCM1NEK2RaWUtYRHBOeUxz?=
 =?utf-8?B?Z1VrcjB5Wm5SZ3NTV3laSkZFczhKUHc2Zmh5bFY1RkZoc1dkZEx3N0YzM1Q5?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb236b9-c33a-4890-8139-08db6dc2a9a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:05:04.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFML5EJ+EUCv8871x3Mug6CXw+Kpob26DKuZtLosnKaoY5Aeei19qKGyAuqIVJ2m02xca9TezNYuanPjDDzr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 17:05:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12065

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now a runtime choice for SWUpdate 2022.12 or later.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/common.inc         | 6 ++++++
 recipes-core/customizations/files/swupdate.cfg | 4 ++++
 2 files changed, 10 insertions(+)
 create mode 100644 recipes-core/customizations/files/swupdate.cfg

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 93f2fbe6..680a4d64 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,6 +19,8 @@ SRC_URI = " \
     file://99-silent-printk.conf \
     file://99-watchdog.conf"
 
+SRC_URI:append:swupdate = " file://swupdate.cfg"
+
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
 
@@ -40,3 +42,7 @@ do_install() {
 	install -v -d ${D}/etc/systemd/system.conf.d
 	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
 }
+
+do_install:append:swupdate() {
+	install -v -m 644 ${WORKDIR}/swupdate.cfg ${D}/etc/
+}
diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
new file mode 100644
index 00000000..9ee47c73
--- /dev/null
+++ b/recipes-core/customizations/files/swupdate.cfg
@@ -0,0 +1,4 @@
+globals :
+{
+    bootloader = "ebg";
+};
-- 
2.35.3

