Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69CC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 09:30:53 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.76])
 by mx.groups.io with SMTP id smtpd.web11.15771.1678699850319292033
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 02:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X3blqdnx;
 spf=pass (domain: siemens.com, ip: 40.107.6.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHKKYPix0IkuK9IvK6w6nm+Xpm4MCmglvnhQG+uaDImoJWP396nU/migOf2EKspGdl/CN2Sz4M72gT9I6bqCe+HjWIGf0qvZQOiIUTT+DvwJs1HXBTH1Wq8jK/aKa4r4RIZE+iyPAwi3sXfU6U/0+1lBMBeH/Jx50qVRIV8BO0mEImLaGFCXFCbGhefTSuYjdC38AQgd/M/u81iVIZVSr2WNt1O0X1uFB7DRFr568MANL0y1p2hJwDOSPPQ26u5/Gtt7u4Dq0hkfWx8rSkJwSsTJOm7OXZlumm/NPL9mZmqeYHVf1y7S70WRk4yK0u6HqLNepIooDjIlHdw5nUigoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfZuTAxIpBuCZReK+quHQt47/1zaGWL8+Z45bc3iR/g=;
 b=CFTtrLfmiMo4CGET/OapdCLmfH1wXHTZjugEISeiywpDs1IlQSbSkffAQZDxabxeY4UcnVc8wL+jYDWL0GWUm6sGGaMctJUM23LXJg6XuDrkg3lrQfNjdtDwzXU15L8lI/0FnqDQN3tsAP3g9VYrU86siGa6tlch8MoZ6hIOVXJaEtZaDzc9xk+lFNWUPbv2tl795/dpxsZCs0/u1yB8U77/neUYAz7iJNI/ZwtP+bmpOqnA5V7o2Uv9pTjId+gSw+vVlpbOwVpgzcYkhYeOIPaHN1DIHpSvWf0P7cTmD30flxgGWAew8OUvoejOy7c6mJzN1oFJlXwvq23GtnH0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfZuTAxIpBuCZReK+quHQt47/1zaGWL8+Z45bc3iR/g=;
 b=X3blqdnxROx0jmFlxvRzw9eKNcEubExHZwGK5rGVojzbGXRt/l71sZ8fsxjfAVUtR4PMecRxtDAGH12NOgipEowAn9vZPhuaHrI7/VWwTb0I+2LYCMwOA0SgIWp1DRiyM7hFtND41dPqk3qUVM8N4w9sSkEoI086ezft59+kRHdI7PookgbHsMkyXwlTqQmLOERZAecoizZE3rDDc3/QIbNOfaD/h6/ViqWE8xklVWt8o+t5l3T1Km+1itqNYK/pCk85VojaFziNyCDC6094Ft4U4+oD9f35zBuHq7sc22iWkKF5NWQoccDwcq/KvN8FJtZEnDElnn9anzR/MS7J5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:30:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:30:47 +0000
Message-ID: <2833b182-7081-95a2-a67b-81c45c214f75@siemens.com>
Date: Mon, 13 Mar 2023 10:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu: Add missing case termination
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c9616ae5-4f81-4352-b2d7-08db23a5a0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o631aMcnqKCU8c9kUwR+nhXU1n/aIBMUB145s3CgL7wPB0X0AUrVHOU4WxVSV88flwXgtJSgsVNt59jXPNdOhYHT6M0bvWsKZW6KX1DWZgp6Ur+EpkizDF29YscOwq66TktbiOkRvKfSYqTmJfdKJg+Qa9EPhtcNWzTJRQ8SURAp5M0d4KwUHEBjQUlBWs2ysOQjdSuGnRYl5V8EvZWV1IhCZg1jd1A8by/4Vb4fQU6D6HxV/YR6nHFpedNfSm61Yho1k151xdYz5LHaf46Th7lAWRT1LK5aPUChWXIMzg18koqiWF4jsFQsNN3VWn4OTPvEUy4jb3U1StcTbbjrkfLH/mYjXamik+z9wyp6OBSIiHncbLXWRqETXvDne/RstTFF9/63iwWJmMvOLyAU8UTytvnwVLZie5BvpH/ql7gWmjojdjpbU3Kt3XWsZHifxVRSo5kKhyHtxB8B08Z9Jy8PtA2WXXRlXCvsJWrYRY172K3J5ZSAXfprrDmD0A8avVBDHsCVzdv9ly0dKY8Q9OSS+vgOFFBCWjLpsROjPaIsZNICBCUArm7VKmhHNgrzBcNaGEL+OKJQLkI506a/gC2YKrfRWlUsaojDhomesEHttVE3BwAFQOtJR5x4Whgtar5i6jhWZ/WYtJwqR+yc0gTOhgIIAEFxV/PsWTIUOHHW/xTz8zKjATuQR+/w7WVSzQhKCdPMIxsPEoll6pJpwddCWqiylJniQ0JQagkMHkM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(31686004)(478600001)(41300700001)(8936002)(66556008)(8676002)(6916009)(66476007)(66946007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(6512007)(6486002)(6506007)(186003)(26005)(5660300002)(2906002)(4744005)(44832011)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjNVOU9zcGh6NW45T0RGektRbDg0ekFTRTlMZk1pdGNNdU05dGN3Vkc2UnZ3?=
 =?utf-8?B?d0grUVNNaE9mNk40OVU2WHpiSWk2aEd6MFl4b3BvVHhTYXdZSC9UMXBXSnUz?=
 =?utf-8?B?dWdwbjlvOEE1N0ZrTUp6OTJFZWduaG90MXhWQXhpcTdmcjN6czI0VGlaZ0tr?=
 =?utf-8?B?ZnVOUmpnY1d0S0dGVVZyQ2xOV21mTms3MHdEY1cxM25QQlE3ZnJEQk51RXpj?=
 =?utf-8?B?Q0JOeDlRODQ0aWJpUDRnSVlCTGtHYmhmeHRMM1krZXRKOG9PSEgvUVJvQzdR?=
 =?utf-8?B?SU9zSGhmeWpsT29ZQUVKR1NQVnJqVW9XMHgweXd1a1FJWGRKMStaZ3ZrNWNW?=
 =?utf-8?B?bXJWZW9OSkNSYVUxTGJibUl2bHlaZWtpYXdpblk0M2tybWE1S0h5Sk5DVzBK?=
 =?utf-8?B?Wk51bmRQT2Exdm0xMThzdHY1WnRtazFQNEhBTUw4czBrZHBzZmpycFZrcGtt?=
 =?utf-8?B?a09lRC9MV21Ld1lpdklnd3NBTVhwVTZBUWNiNzM3Ny9vMHBNc1RSNVgyL2du?=
 =?utf-8?B?TWIzQzVINXVWWi83ejd0Z3RrM2oxVEZGMkl1Nmc5NG0rR2VGbUlBeFlJNDNN?=
 =?utf-8?B?Z0pPWHVOVkE5UDhsQ2F0L1dGNm9ZdG5McDV3QmVhTEwvblNjYTFQMDloYUh0?=
 =?utf-8?B?S0w4d25CZk1LLzZUODE2aVpYbXRNbXBlUGhuOXZuYlhTUloyV3lDTjR4UFpM?=
 =?utf-8?B?RTU5Q3FiTzlybnJCc29aNVdzZFEvdVlhMHVSRHMzQ2REZCs4VnlxUGRDTTYx?=
 =?utf-8?B?WEt5WlczOTJPalBUSUV2U2paNWRVVFkvMXhRYnhLVHBQbWhiZjVUSTFYbmli?=
 =?utf-8?B?S3IyajY3ZWZiQUJVb3NNUWlDYmp4VW1zc1VUbk0vVnhNS2xXdjRTU3BiQVEr?=
 =?utf-8?B?eXRSUFpSTExlMEErN3psYm1lOHJqN0JFWTR2YlRZT1Rmc3BKVzhtV3pCbFF3?=
 =?utf-8?B?ZFoxMGN6amNiL1krQTdtMDVmTjMzbkFvbzZodXlEdVVHS05jRDZwcExzbUpQ?=
 =?utf-8?B?RUhaTHU5Nmsvb2EyNkFkeGt0a1dPNE1SaFJuT1d0ZWFpc1Q2dHB3bzJnWklF?=
 =?utf-8?B?T21oNUVIb1J5UlZyYXo5QTdPSW1QeEdBcnplMFhXelE4WWpZNkpGa2ltRlZo?=
 =?utf-8?B?YVNGWnZ4VFV5dVZ3QUJWUGpmQm9KUjVqaTZWRE1HWnlHK3JnMXBaQW0xWWlo?=
 =?utf-8?B?ZnVVT0Z3VG5FWXpSSEVFanVqa1hFdlpscUtOWGFYRVFteGFXTmZyS0EvaDZs?=
 =?utf-8?B?eVBWa3haYW5XSHhkcWlMNnZTWGoyTDNLUlJWMG8vT0lPYTNPNExjc3JrWjl6?=
 =?utf-8?B?dmxRNTBYNW9zVXlIanhWMHlEZlg5eDV6OG9FVDRnbUJMZFNjNnYxNXZmWUFm?=
 =?utf-8?B?VG1iRXBPcHJhdG1KeDVDTGJDWUdRbEtzb3A2T2I1Q0p6eG9ONG9HZ3VBY0o0?=
 =?utf-8?B?Ly90K3FaYXlMYU9CYkZ5RGgzcitRanFtUEM2YWlRbXQzdzJJUnlsMEZ0em1T?=
 =?utf-8?B?eHFNRHRLb04vR3U4T2JEeDNnU0hkYitMVWxTMmpiN1JPeGY0eTJDbkExdmtC?=
 =?utf-8?B?eUJ4VlFqeUZnakc5SERXT3k1aFNGMFpWWGV2dmpNM3lxc2FOam1YSVRYUzJF?=
 =?utf-8?B?dlJqeis5RUtCUEwyakhVRHlqWWgyK1B0SG5CMjNhM3B3bUJ5alZvWmNtNUxX?=
 =?utf-8?B?bDkrUWlVcjNBdWNyNnJkeGRjb1dDMGZzTG9BaFhCRkllOU90S0F1RkVHcEwx?=
 =?utf-8?B?RTYyZWM4dEF1emxtcWtoZjN0cW13OTlabW1VUFR4OUxnZFR6NFNnSURNYnhB?=
 =?utf-8?B?OVVFdmdSZy9UTkZ6S1FoWHlVRjNhaFJBaWVGVEI5L0FKcXdGNHQ5SEsvcmda?=
 =?utf-8?B?V1pFa1ZNOHJrM3M4d0tOQjlqTC9MRDBGZG9NUXdkdFZITGp0U0Mva1U1TzRm?=
 =?utf-8?B?cXplZUxka0pHWnBhekpsUW1GYjkxUVk4SjF2YU5HbTMxNWdMTDZ1dC8zcVdj?=
 =?utf-8?B?d1lsRHQ5KzNPSlZ1RXd2N2s2K3UxRG9jd3BtcldQZUZmd2JLNGZ4clZwZU9X?=
 =?utf-8?B?VS95NGtjQjc5WHN6YnllaC9DY0IrT0tNNElXYkRQeklIRFlBRUpTSXhVT202?=
 =?utf-8?B?elB3OG1kM0xOZ1E2MG5TWVhxaGdkV08yb1gxUktCd1hsYnZ3SHllWCttZm5N?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9616ae5-4f81-4352-b2d7-08db23a5a0a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:30:47.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snm1wFUW8ljssbGLnnBgQMSnFk9dTvYATm69aZb1VTb3iXpHk0j39WSiRQYee4nMAuFOZhJqgc49G8NFvQKEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7384
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 09:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10996

From: Jan Kiszka <jan.kiszka@siemens.com>

Just a style change so far because there are no other cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 44fb4196..9dce0183 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -140,6 +140,7 @@ if [ -z "${DISPLAY}" ]; then
 	case "${arch}" in
 		x86|x86_64|amd64)
 			KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
+			;;
 	esac
 fi
 
-- 
2.35.3

