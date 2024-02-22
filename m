Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1BC48BF8
	for <webhook@archiver.kernel.org>; Thu, 22 Feb 2024 16:31:18 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.88])
 by mx.groups.io with SMTP id smtpd.web11.17186.1708619474311830617
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Feb 2024 08:31:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z1DbN2Fd;
 spf=pass (domain: siemens.com, ip: 40.107.14.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npA3hv+xuTViHgJAwN+5kYspQHgtQxw3w/1W7SuANFdDBwn6gPALrqp9afwvF0FVfm1SIOOsyXTiMmbYVSQpKm/MCz1ubQUqyOVOBqflUWy45TyfrTPjeLxdAaUCLG8W//O4/rPe177+qBUT1poDJv3mTqr09RJUpq9c7jpZYQd5kESzzROWUJcgunAcQW219uwlFtBS7cKxh43dmS1xtD1yX2RRVqWIQUxTRt6UwiAsQNXiByDzYvhO2yArCQbilX/sJjda6uLVAG/g0PrKxmY4S1jurI6nqfEMpjgc58TR5rdt02xgtlg1yenqa97fiEs432t/dw+A94Jf7SlcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdBUJqlbCYHQGvIee4821fr8G/UEwuNMIx4LXLUESCU=;
 b=Xgh59sZ00qEz/ylrbRJpCbZbdIQaedyi01I4xm0ieEqLLZs97ZyVj/Ze+8aMh6DTvHgMKM/JW/NALBQpYtAtvN6YqUajwnJnsMIArGuyz0ydA3wEQ6bZ0oR31gM5w3H0XLkqCv/RN+XGgcpf6OPLmZc2PRSgq22Esy8+RMN3QkEdCVLUvWL5IvTIPVAn2FU4ijxXxAS3hr/9+O9/pIs78r05pOEwY2ohnBibRLNoD0wBYIbb6NZnkiGUT6dTweLVVInSXmxL3g1YD5uSp5FiHLTHT6J04FkedD+ryPZ95SebnGjSlx/N/Yq56SKyi433zKcD6itt4MXoe9AU9TXebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdBUJqlbCYHQGvIee4821fr8G/UEwuNMIx4LXLUESCU=;
 b=Z1DbN2FdXJxTz/t2nHIolOPW3WpSfd//J/F4tui0iXiNFJZa1ds5is+153xC01FtmpME+QD+AhGnGLgfhRJsA3kOKhHyy//lhKv5Nw8UUpiABNMkttMNHTn5Lv2NpcbaYr+Ylv05IvveDL/3qkQ79Pio4W5hGKlUE6dic3e+oPcsrLKf75IxXWl9ZKFsAtKhwis4sgGuuBCuWP1ZJztHbazM1sMkc9bPR/lsFZPAlxnKr7C8ctLPNFb5vlELuUYX1Zjn8x3qzOR7terJE+6DdsLK0oLFbciwNrnYyceM6VoZaIwUNtHl0bvFigjXBeoCGJUPnegC3IqvEQmTEN5dyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 16:31:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 16:31:11 +0000
Message-ID: <a7bf4cfc-71be-4303-8fc3-6440e3c6593a@siemens.com>
Date: Thu, 22 Feb 2024 17:31:06 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.306-cip107
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4245dfa9-d9fa-4749-4ec2-08dc33c3addf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b9Y+uo/ceiATiDDiZQJi3epRuHdEnbn7YPWL7+YKGV2HTkmCTa0CZVEM7v5+OnWyKm4xHv+EVM0ldjpPMZTGwtFJ/8UwzfvUdevfuFGPpH9EGaWtASptVEZhNOzq8/MCr2RHFKSrrZJb8CZZfEARS/d/HxDxNOTbN923KpucgOaGtzI4CQUIClED5omOOzzzO4yKyJ7qRJr2uvKAKAgi6FLXGXq0wvgUPVAyLzCb1udmEDvkzP9R34yYMSWO6Ltu2APcUgCK11NNnadNU6wpWhhKggcifLnL7ttq7XcXxDFKNJYwU7OL/a8cZH0fEQ4tSjmN8V6gPiGYM3fDvC+KnBHf23tFjlqZY2UBxIqI5CeF82ZXcTmbQfwLwCO/dvwt1WoeCfhJTK2UUWedmZT6PvVVkrAwLdneMwoC69kDIj0i9AIvZu3Q3xKQXv70dqpo/Lo84kitF+67Aiu2ggOrMwuAZE9LQL45/mvqdZdv6MBLCPLbQbGu0V/2vSKt0czgB09Q/Cv5dKO6SYJtw0NyJPOfBFGilu3p2xg6YnmLCgY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzhpNzE0S2lHR2VVYWlhTWlRWllEU2k3T1VyZk5mVkJKajRUS0Q2Wjg1SDNL?=
 =?utf-8?B?SFQzQStoQ3JyNkZVREhGZGgzV1pmeXFhQXAxVmM1U2dJeW9WTlJnaFIvUnVs?=
 =?utf-8?B?bnh1WDJ0S1E5TlRLdHJJZU5FRWp6MHRScUQ1UWRqWGxwSDE4VjFGdHllSGZw?=
 =?utf-8?B?SFBlV1JKWE5yVU5ZalNGU1kyOWdYZjNEZHpiUGtMNjhPOEQxR1hPQlRoLzNt?=
 =?utf-8?B?aXFqcHJkWW54eVZ0RTNSR1Z6RTFXcTBqVUlyazF6aDB3ZThOUmdURnYrT01y?=
 =?utf-8?B?VHhUaVpIaDhpQ1k4TDMxMVV6NFJYWGNGMzFPM3dhK291V1hrSmVpbytBZ3NG?=
 =?utf-8?B?a2lVSHVYU2JhbUpVM0NSUS9vSlZlRmU1WWZuY0NMLzc1WDRHN3Rxa0x3dEtW?=
 =?utf-8?B?Y2FCc1lnYWNzQ1FqVVFxb3k4WUI1MUp5RmFGSVFyRmUvYUxvMnNpOGk3QnVD?=
 =?utf-8?B?dEJCUkdpTlVUcERnMmdDZWs2ZlNNV3k4V1hMVURJbE9ETkNYL1pvMVFEWVFL?=
 =?utf-8?B?bWZ3dW12bDFsK3hQUkxEbGp2N2x4QlJzYlJWY3FieG5DaEMwdVFZVHRXK1g5?=
 =?utf-8?B?d2ZSd2ZTTjZaeWdTbzkwcmdadnE2cm9VQmZJWG45SG55aExJWDIwZHlTS3A4?=
 =?utf-8?B?aUoxSlB2VjcyWTZhUjVES3ZsMFlEcEZMQlluNFQrRFoyZVRZbVNDQUpaamt3?=
 =?utf-8?B?cmlDRmd0QklzT1RaY3l4bS96ckV3cUFzeVAzSzhBc0tyYTRVaHRvTHAvb0tP?=
 =?utf-8?B?ZUFBK1JIOUhHUU9oaFhUUTlubG15NVJabDNGN0xsWmsyZ0FoUE5pWkZ0NGxw?=
 =?utf-8?B?bnducTExK042R1pEejhLaS9JSDRPck1CeW9pU3BXZFdOSFNKOElvbmRTOXVW?=
 =?utf-8?B?d0lLdFlEQ2krY3JXbVNOYnBuR3Y2SVBzTTVYcHkySnFBT0hzRnQ2VFdvUmEy?=
 =?utf-8?B?N3FxMXpoeXE1ZHhyamJIQ2VqSXdYR0d2ZmFucHVwdW9xR2pjUzR5ZU5ZeTc3?=
 =?utf-8?B?ZWNPeUozUnU0K2ZlY0tTQ0NrZlBnTXRsN29OOHNaRjFJVklxamNkUE9SQmJR?=
 =?utf-8?B?emJlQWFiOXpuOXFRM3gvREdxWTVIRisxWmpBOGJqTjhmaXl4MUpMRVFGbVdv?=
 =?utf-8?B?YWxXWFJvdHJqQmNjWlk5Y2ttRXd3TGVTanNnb054Yks0V0R5bGdpRDlKRzE3?=
 =?utf-8?B?dzFvaGpRRUNnZHl6YUE0VTZjdWh5VUxrWjR0cklPODV6Vzl0ZW5qQmR4OUtq?=
 =?utf-8?B?eVZMQVM1cy9MMVhNbko5cG16OFFmajduZms0Uk9HWUZERXZVVG1BUXZPOEFx?=
 =?utf-8?B?eXZoZDNPNTlvaEZuekNodWI4R3gyNStWbGZiZnZyeEVDc2FwckE4YWc4WTdt?=
 =?utf-8?B?a01vSG1sRXUyanJQQkFHM3kvNzhzQzNVRDV5azIwRE5LbG9pbzFKbzNoa0hO?=
 =?utf-8?B?STNhdWJkMmE3R0Y5UlVBY3RjQ1hMSldDN0pxL282UXlkaERwS1h4UFlUUXdk?=
 =?utf-8?B?RHk4ZzZXZThaUFdhRWhOcDFVVU1kQ0FnalZlcUtPTnVEY1ptZ1hmNW5SWFJl?=
 =?utf-8?B?YlNPK2d4ZGNsOFd3K0RFRlVac3g3OGpIQ09YSWlJNmEvY3psVzZWOWxJTE5j?=
 =?utf-8?B?UGR6dnh2MHJhNTV2WWVPMWFGTXExbHNKRFdNSWVsLzJwYk5LRU1ISTNIbFlV?=
 =?utf-8?B?MkZsSUlGS0svMXgrTlhVTEVxUTJyMG1HbEtldmhoVkY5bUt6K3VkTlBIbWUx?=
 =?utf-8?B?dzkvb0wrSVcxeVk1bEVEUjV1YVFidDJhWDY1bWRRK0RVbnJkQ2RVVWpuTGsw?=
 =?utf-8?B?d1Ztb00zbnVPZS9kWTM3L3BSc3RSNlR5TVRXejJySnFpcGs0WDRYclAwNEtT?=
 =?utf-8?B?OG8zdCtSc1NmNzJOMTA3ZE9YeTdJWE5TS1Fad0NHN091S1dDT3RkMnAvL01q?=
 =?utf-8?B?ZEgzS01BT0ZELzR5cmNHYUNhaExjWDNDdVd0RW5PcWlJTG5qMXdwaFZlM0dE?=
 =?utf-8?B?RjNtRklEcVJSR05KVmErWStsdUlIVHhjM1dyQU80RzlzK1VxalRIdy9xTDJV?=
 =?utf-8?B?Z0lSazJLNDJ2UUlzbExFNjhZdWZkZS95WFRwVWFVMFYvT3NPTDJ2QWF0czJQ?=
 =?utf-8?B?SlNzb3dVZEpzQW8vVk0vaDM5RUxycndrR1REdS8ybVhxYzF4VnNqNUNMK05B?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4245dfa9-d9fa-4749-4ec2-08dc33c3addf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:31:11.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSE+KFF8J/LCpw4qyRapNG1cbMkcbwdTz1P/9sHEcAdSxsu2mcG3aG4rx3u2EjNgzgsyQIiWzkz4Q4W2rDHvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Feb 2024 16:31:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15064

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...inux-cip_4.19.304-cip106.bb => linux-cip_4.19.306-cip107.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.19.304-cip106.bb => linux-cip_4.19.306-cip107.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.304-cip106.bb b/recipes-kernel/linux/linux-cip_4.19.306-cip107.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.304-cip106.bb
rename to recipes-kernel/linux/linux-cip_4.19.306-cip107.bb
index 055006eb..57dd2502 100644
--- a/recipes-kernel/linux/linux-cip_4.19.304-cip106.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.306-cip107.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "3c920d95bf991d4242bbfd5f89e623aff5037863a9a7b0e8b2ea3a374105a635"
+SRC_URI[sha256sum] = "ed0dc5037bcf213bd4852710f65f99e87272f6b295d2214ef270d1651c5c4896"
-- 
2.35.3

