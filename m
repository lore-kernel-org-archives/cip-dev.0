Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A6EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 16:28:01 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web10.29244.1688660875089097218
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 09:27:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qtg+oADa;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0e/WQ6HeZ8nZJEYWV8JFl9b+95OoCuhP2I9AlsehpyRht0JVIrQ4wMQJeo2tq9T3Oc3cqJ8NFsKdWieraBQYTemOglb2vWXhHeaFqvX6fjSBzup9fZlGGKsYQMGpPYnFIek2mtGqfVfcd5d8cIEl+LmEHattDmIQlO986t2h6qcg42NWnsi0AetJ7B11fnbn4/GqRZqe7a8QxhCjrO2U+R8dac8JlMK3Q4PH6F11ivSQ9eumhgb6uT59IiTuC12gxip8SegSWR1zEEQRtHEaEDTeZcfu3qQAvn2fHCkmJa2x8sDTX+4DQLbeipbPTBx7jHg68wVCwS5piBtdABEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZLp9GHwmg4JDd5MFoDFOWU/nindj8YSYttxZYxIDYw=;
 b=Y+lu4Kn3/bq2s3yD2PM9sS3C0EiniPpi+RKnnyXHz8JspbFybYqEVwuKTElM0PpZja7zC2c/WeMpMD4iOKA9XPqzwnrvFgPktxzIXHQxhZO3DNd3YLlRJ+k0UxECkFdldS2lxydFgyXjvb9RrS7NOs29qmGtdKKINgjNFYGz27DHSryUQmzp0U3b8qqT+/nBIhYil3ENQCeoS1FpSEjIJVSi2YsLJi+7zSdztHF6iL/58Egu7uMSiY9YW/AdpNMExPinY0i8nTTQHHUHzO6M5Q13M+43vQqSuIu2sONB3ikCcDDN1Yo4kiJbCBYqcqDD8QokZEHHoBHM6kpLfhuEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZLp9GHwmg4JDd5MFoDFOWU/nindj8YSYttxZYxIDYw=;
 b=Qtg+oADa4en8MHa3LTO3CgIBk22bI4lSNoGGJMSb6dkLi3j6cXLlpaPCAtZMrKY0wU5FePOsKylUX17nkyHNL3nfacbGbn6Cs2oQeuhocDLMVwfXBtjEXJlTExKXBIVlxWaZlEdpfvc7GZT871YKeOxCGA4GUzbyJ6QHNDMgQvlnBMsNqFRLGzQE6vcN7fSD/C7sCbdOJ+4x4jbCiwN6ewOQSVSVDAaN56iFOZr3mezEYeW3cuiCEdylGmXmlzZFcC6vqCenB8oJO+ZVr9sLtSSVQcKaUmfVdbR6EjuCOV+A2zE3kRDdHKk6IfdfYBrByrwylADpm7SvZlfe2ApswQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:27:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:27:52 +0000
Message-ID: <723d7301-a528-0aac-f30a-1ecd73db294f@siemens.com>
Date: Thu, 6 Jul 2023 18:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] cip-core-image: Restore CIP_IMAGE_OPTIONS
 default
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ec9243-a033-43ac-d181-08db7e3df1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cmouRzIgN2jmMX2xuruzrcma9IlhEmQ2M6O11AJzkdfzifpQdOvXk+PYoxbQT/ARt1rDW5esed7zpclLFplrieeYmnfwnHelQvizJnNyUwa+ze082QWdfWuGpC/X2OVtIA1fR+60TP9/4ujmaYgc2C4Jk+KS7HmPu14ZsYGQgVG0uedK8xlqxYxsCGi3dgnrCqSx48ejOA/Tt0TlXYy3dARmvN0cM/K+Kd5RXJzUjRFPbm5bid8scj+PCoFgmzju/6Owz9O8fbZVMTPxp2RZDgpvPbYv84lItXajPOzEV+T9QmHSngTUJ8U1f+AlK/jT7CvQvTCoPEmKPBteb5kGFw9JLF5ngoHxrsEItrFrSfqVy6GvAMOSg+ZDErB7UXpbP2tWrvOLupm08tINtXewxWolt58loN0+ozIGHXWuQk8E1NtSEQ8wJxn7atTl++rCQko+LNmqFp2Ldt8P+zGCsCwlsIUSR6p4uH/NeIsxKB+//4KCDN3q0dCrOtI7dFBINiK99tKWGXogYSoxOIdUo9jsfUo4YSL7bQQxlrFPa/VTdnvGtC6wFBnivJOwseee8/xTyZZqs39lfHSMznmrs4qp+GxXZokMwvQ78RZEB8SUk6mabEm8LgUyZ064KSyeSRS3vliofHbjhdYboWz6Gg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(5660300002)(4744005)(8676002)(8936002)(41300700001)(316002)(2906002)(31686004)(82960400001)(38100700002)(2616005)(66476007)(66946007)(6916009)(6506007)(66556008)(86362001)(186003)(6666004)(26005)(478600001)(31696002)(6486002)(36756003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUo0dnlQY0ZndWdSNURSTm1SYTBtSGhhSVV6Nmh3R1M2UVVVM2ZiY1VHMDdF?=
 =?utf-8?B?VE5xUllBU0R0Y29aL3NNN2lkN2lTZ3FCSitkT0FWRE9IMjRkQVJPSS9CNHV1?=
 =?utf-8?B?eHJlNzdkR1p3UFRlT2UvYWFMbXdJN0M0Y25wUy8ya3pSZzlqODNTTnNEdnc0?=
 =?utf-8?B?RzlEMEp0cTJLTEpDNDVRVmwzdlpGVnlWSGhtTnV4aE5GYmZwWFppTGFhVjN2?=
 =?utf-8?B?VXhWa0I1TnhZUGdWQ0Z6UlM1NitEajRqZ1laRUdlTUZmUitqYTRhUlAvYWRs?=
 =?utf-8?B?SlFCTFBFUXFFcGwvVUY5TDFFUzdVdUQ3WFZmbStBdDdJSnU5N0hsbDZ3ejlS?=
 =?utf-8?B?L0ovRC9CUDVJVFdPWjRmN0NJWUNvSzRCc2tVMkMyRmMzeUhRY0szMGlkTytE?=
 =?utf-8?B?TVlkSWpCSlo0YmdOeEJMTGdvcUdsQ3Uxdno3bFltQ0lxTzNKU2tYRXNSQmdi?=
 =?utf-8?B?WTBEUWtLQjVIM0p4ZEVUSzJXQTNYaU5mQzVOK1hIOGZHUmt6WDg4TUtwZzJj?=
 =?utf-8?B?UVBzeG9VWjcwUk9RZ2pwdy9kVnowN0Z0WDhFOHZyejRoNHgxWVFBblpVemdk?=
 =?utf-8?B?VlgvN3R4UkZtN2ErelJCcmNZeGxwbnNNbXlYTnAyZVBuekFGNC9LVzBpak5q?=
 =?utf-8?B?SWR2bE50aVUvdThkS29qUjlGRnQ4TGllZEpSVXBKc0xBdTRHN0tvVHBaL2Jn?=
 =?utf-8?B?ajlqVEQ5aVpZZzBHQzZadEp1RllQdkhydDluclR0UnphNVplS3U2c1NmV0FP?=
 =?utf-8?B?a2hhbFE4YjFhdE9HQjEzTzNaSUEzUHlqYjh2LzlrMDgyNUd4UmZzNjlEcCtT?=
 =?utf-8?B?MVBFYm12bDFyU2h1OUQza0xyTFpyd2piM3dhRm8yYSsrb0dNOXBQdjY2b1h4?=
 =?utf-8?B?OWg3czFKdmJvN3VKV3IxMnpEYVlDMVdhNEFuTTBwOW5DOS9COElVMElVcnNN?=
 =?utf-8?B?ZzRWSUVRRFBtY1RoSHljdC95dDVLOTFSeHcydUxaWFVZazdTbUxwelBJUDVZ?=
 =?utf-8?B?cjYyUWxGcWpUWmR4dUNNUTMvTW8xNE5tL3Fyd21jbUNYeFR3d3lYLy9DUWNJ?=
 =?utf-8?B?Y3JxNFdjU1UwV2FDZXBCeTExd3owV1hyM2c5c3pQanhTQnNVUTB1RmZ4Y1lK?=
 =?utf-8?B?T3VNOU9maVVQTWYvUW5qcTBIc3g0VlZJdnZNNVI4bnlPdlFSWGdKMkZ4Ti90?=
 =?utf-8?B?ZmcyZmVHU0xZbHk5bVVwWGQ4Uld2NDVLaDd6NlM1VWZmNEJTS05FejEycER3?=
 =?utf-8?B?Slp0ZTIzTTJKSDdhTjN5bnpFcTI1TmVpakt2bERIbGFBSkowVEdVL3huY01V?=
 =?utf-8?B?Q0lyMFFsZXdMdTR6Z0YwblduVmxSS0N6cmpoeTRwWUdtZkR6UmgyWjFBVHp0?=
 =?utf-8?B?V2JNSlBKYlZ2NmRuZFB0cXlLM2FSQWF4UGZPY1JDejZ0SzhJQitlQ0l3bzhX?=
 =?utf-8?B?N2cyVDZCcmNKTmE3aWVpaTl6cEg5cy9RQ1B1S3VvRHJOQWVWaEdkcDNJOXZz?=
 =?utf-8?B?bkFOYW9pOENGOFRac1drOGcwLzc1aHBSTTlVbjJudXI3TVRUUmRWZlcxWWwx?=
 =?utf-8?B?WGZuNGo0eFZiQ2VqVUdXVU1UYmRpMHNxRTZoTnFCalI5MzUwd003NDBuVVhh?=
 =?utf-8?B?T2xuQkI2dUJFeWdoVGlSTkd0WEU5MEJCZkU3dEk1NDlHUzMzb1NjVzR3cTVh?=
 =?utf-8?B?cVNidC9NZE9mOU4zRkNSZEcrUDVQK3NiQld0b0tSNG1LL0FOQXpzRWorRVQ3?=
 =?utf-8?B?VHdxZVBMSS95U1ZtcmhzeWZWdFgrTjBSYVhCS3NIc21FQ1Avd081UTI3bTJ1?=
 =?utf-8?B?OUpNVFJOZ1VFMGNUUnFRQWZkREF4eEs2RzZEWWIvWnpNc2pBVWlMVm81VHc3?=
 =?utf-8?B?Z090K2dPdmdjaCtrQlQvMjRNalREN01NbmYwRDFWbW95SDluUWN1UWpUN3Ix?=
 =?utf-8?B?R3c1WnVraXA0eVZkZ2o0dGd0MG96YXFZWWJVSzFncTFzdVFjTlJRZ2srbG9T?=
 =?utf-8?B?cU1ySGZURlZOMHBaSEZxd2k3RDRPMUUyUW5SK3JaUEhBRWFqRk96N1JzTmow?=
 =?utf-8?B?Q1V2VDBydGEvanJ2ZzVPM3lMdXJsc2Vuek1jQjZZK25DNExPVnFLVmVTNmlQ?=
 =?utf-8?B?OTNIbWJLMThyeFREa3pYVnROUnlOZnU0QjdkYzBuRWNkZVp6OWk2WWVodnFt?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec9243-a033-43ac-d181-08db7e3df1d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:27:52.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/yBfeSPSDLcsm8PM6SUWb15+J9k+4cRedVz5Sps6n9cSBXwLHz4lofSYX2SuCDxQt2Q9I3RWgzxm2j1rwLa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8036
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 16:28:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12262

From: Jan Kiszka <jan.kiszka@siemens.com>

If a downstream layer is not including conf/distro/cip-core-common.inc,
parsing of this recipe will fail, even if it is otherwise unused.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/cip-core-image.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index f7370c49..0ec72208 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -16,4 +16,5 @@ DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
+CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
-- 
2.35.3

