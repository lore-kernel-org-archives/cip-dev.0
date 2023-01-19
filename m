Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDACC38142
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 07:08:19 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.78])
 by mx.groups.io with SMTP id smtpd.web10.39865.1674112094648917748
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jan 2023 23:08:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fxWoeL41;
 spf=pass (domain: siemens.com, ip: 40.107.13.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc5lK4q5ATRNInDq/g0zNqKvou/SyoITLDXhUFO0x1SwxO3HSFyGiHdoMVFQCW4MzxeDI6TIpqCeXGCVqHsQwkr2hOFbVtwVoe4OU9kLfn+5s3JRz60nFS221LIIRArXB5pY/H6nKhksnR/ZN5OjxIU8Dr0r95jf4NFhKlVGZAxMMcyRSziiJ/hk87/yTEQcQ+iqgznjKTjlviYQN3fNyYGBKfP7y7UbLW5UWt7i8DPMMDRZ+dFmbMFxxovIqwu9O/eDModio47IcDSb+JrTqe9h922FZhgggJIuyozwUIJjHu1tfcsb5kV7jLbRmMomhafQ2caur2A6YH+PCdeYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+AYgqjPPOKqOjtmK037/CCUFMbIJdSEBk0r3GuqmDM=;
 b=cuTFcSCmkRMh3Ct6WLaE5y6cf54eLLV/nVuOjeq+9iyQvK7piPGp1dY93XnTcA1DaiXw0svwodRfTE9GjizdRqtRSH0jMH3ZWND+UdDti/WgxAs9guQ5PkkztknugeccUgXD/oyQhte1VKSKFKYEynqpvQcvAOV3Clh4DIYDPskI9EWt646ndlYe1c3jQToazGNKBQVi//T/tVRJs5CKfrfYVtq7im9gGhJ/AbxJdwrJ7356v2B3qzNgxeRLJq1cOj5fsPr/vLLXzuvYaW5+UXoFrfQmXo51astVcqvWuxvTQxmiE7UlTP0bNphGTdLB0VZKxVpsD2x6igVWORUKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+AYgqjPPOKqOjtmK037/CCUFMbIJdSEBk0r3GuqmDM=;
 b=fxWoeL41VCrp+S2Ep8a1LlqGL/ggoS5Ar/63jr5bKCcz7j946mKttP4va29xXSoEB62GzfR2sjdZPed3fWC3+ilUKQ5P+14pjG0LH84+4sRTv43OppX0pvq6/EowM7z2y8sdmmz+hzFdNKqmAt9YrQ0u3yYMTseLVuMkhs6BCYHwT1yZDK+2g1szmH0sZFy7kSW7o++Ym8gAKX77SOhg6UaakgGKaCRVCNhVoXl8yXGopNOP/Ptfbvo6tpcWJ+6QnBYQzEBtxpWcb07KF2VViLjNZJ4mPWgNoftPN+k8nns18dX/7ts7Q0Dz62EdEYY6hDiTguSHPBRaM7yE87d+HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6437.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 07:08:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 07:08:09 +0000
Message-ID: <418c6c86-02fe-7d4b-70a5-162dd0383dfc@siemens.com>
Date: Thu, 19 Jan 2023 08:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: a8596fad-421a-4da1-3ed1-08daf9ebebbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2IzkkTvIDU0wER+fbggr0JiRAvvnIO6g6of0wWvVGAiTB4M93HW4EcnTO7LA9TZoDijdbk19zpP12VZZbONlsU2TxZRE2NvMribCZSfyYMo3/YCDUkWzBx5wIwf7YyNGANJask+ZIrgcqVuT52XJb+ilG4vsVh901Y+TKtbsF7crmIYXADzH30bTbz6dWjXzGia/NhZeinWuWtoeoTr6Zk0Fg/vzXcaxCn9Ov+bLAJAVVlQ3Q6azwvlR+/iYjHlxvelojG5NB7WmrzC5G71RW728eCbAPQcF2ZNy+2/PngsGsl8croHcTCt19asDOgqF7z0v7ajeeJ8UeO0hbsJCWlHXZPp8DiNp7ksJh9KJFfZVnX/lUW0kEjq7T+hW7pZOT8eEhQ7houq8N1TmwBOcj4dejN2KgK0KwEnRpex7STFQrYSoSneJVT8EvzcEohn6k6Zx5OS0X4mDYw9d19OMZLJe5qLxoxnADa85i/KcKF+vrpoIQDHqMar1NxJHbr4BjBQ4hZklwVzKu02W7jniIdy4YRmYc84FGb0pRg0uQfwFUyvPROKDlw/k4nukOJcIVusR4XCmv9a4KrRA032m+GCVDDZ7acQv81WfWd7WeZjveCfkLXTM4+/Pl66Vci6OcZpJLdU+6daigUh5Db2sM1HnJ+QT1h5AfRowkO6iCDN1HrAZXt4AyluvWfol0O5S+HWu/eTT7nFgOIEB0P+tqBZDcgSOHzK7E1os9W3szVNAC4ULxuO9oBIPQESZITbunEDXQl6JPn0s1BedigG7+Fn1bz3+fyktLAAh9mD9Rny2iP1TJPQtYCKKxi6b91LM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(31686004)(86362001)(44832011)(4744005)(2906002)(66556008)(66946007)(5660300002)(8936002)(66476007)(82960400001)(31696002)(38100700002)(316002)(6486002)(6506007)(478600001)(966005)(36756003)(26005)(8676002)(41300700001)(6916009)(2616005)(186003)(83380400001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2FhL1NJcG84c3FjUHpVd1VGck9PV3F4QnczVGFxSFBlV1E3aDZsR2o3UC9z?=
 =?utf-8?B?aHNib00xbnVBV2FUMUxXUUE2RDZNcEdZY2ZGQXdVbm5QbEFqeWI0TGhQdzB6?=
 =?utf-8?B?TFdtL3hmY1NqdEZRUklmbFJ4azk1UkI5Z25oOXczaWkwTURHTkNaREtuK3Vp?=
 =?utf-8?B?dC9NdElXY2s0VE1rMXpRaVRKOGFJWml4MXRsaFZiWDBINjF3WGZhVDZDSTB1?=
 =?utf-8?B?RXFYZm9rc1lOYkpUbzFseXFJUC9HbkNkSFZjYVB3VSt0eVJtMzhZZG42aW00?=
 =?utf-8?B?WUdHejVyRmkzaFFGOFVlK2ZlMi9PQTQ5bSsxVTVGZG9wamlyMUpOalhlb0F2?=
 =?utf-8?B?bU5WVW14YW9ja3JMTGY0amZSMFNNOWoycmN5WldwdEFCQUJKQ3UzU1RkSTRj?=
 =?utf-8?B?Vk9kVVE5VHhzSnRsVnc1QWR2L0M2azl1aHl3dVhReHpyMEQxbWZYYmxzaS9r?=
 =?utf-8?B?SEI3M0c5bFZoRE82dUVEeThXWlJZZTEwaFdBY2RSTTcxL2JQT25TM2x0eTMx?=
 =?utf-8?B?VzY5MGl1Tyt2RnYwMFl0NkUvRzBPb1pGWWtFWmRYYVpSQzYvalRQd25Ba091?=
 =?utf-8?B?VmZXeXQzSEhrMWQyS0Eyd1NHK0l0MXB2N3VqSTM0aGR6SCtJc3RNY3JkTXNj?=
 =?utf-8?B?UDJiQ0s4dVBTM2hiblpSLy9lczc0WVgrQVdNdDZ6c1VHaStMa3RYcnBHR0JZ?=
 =?utf-8?B?aWpkWnN5Q0ljdGJQREhENUE2eGRDSjFnRVF2dFIyNVRjL1o5a3hyV3ZVUDRF?=
 =?utf-8?B?bWZLVENUOU5Sb1M4a1NjTmIyM1cyMEJidGdKb1I0V2krVnZ1SVlrU3lDSzIz?=
 =?utf-8?B?QkdnalNMRW5BaW96RG5id2RRM2V0VnlVY1FWS2MvQzRDK1J3anUzMnQ0YWQ0?=
 =?utf-8?B?S2c1YmNsRitQN3VkeFNYK20xOWtudkR5MGR1V2owbXc5YkUrdlh4RXc2cVFr?=
 =?utf-8?B?dUlxdkpNVVFOTTA0YStONHNyZFpiL20zcU5INXcvdHlpWUNwVGZ1NDVXQ21D?=
 =?utf-8?B?S3hPYU92d3NsbmdJQzhGZHIwaTJFQXhhY0ZteVBrd3JmWUxRQ2Nkc1ZRb2t5?=
 =?utf-8?B?RHhuaGg3ZlkrRmoyUk45VXpsWnZVL1dvSzNTenU0N2VERTJYWFRZS1ZPWEx3?=
 =?utf-8?B?UmZONWNGbS9kQnVpQ0IvejA5clRnU2k5alhIUnBUMnR5a3pWZlM5V09OUmVG?=
 =?utf-8?B?N29RM1ljWHp1NEZWWllVVWkxcmsrSDVmeGR1alVPTnl1ZUwvVU9YclBybHQw?=
 =?utf-8?B?NEs3Y3RyWTBlS2ZGaHh2aUdZRTNST0tJcUZRZ0F1RDVBM2k1aWhtV0N6cWth?=
 =?utf-8?B?ZnNOT3JLdzNWUmljNzJsU1hETUNjTjZNYVArUlJoRWgwT2MxY1dYR1RpMXVL?=
 =?utf-8?B?SE1YTndoZS8rQWhnU3E5dVNhWnJBbURaSnJncmMwZ3BpVEhyMDVicmwydks5?=
 =?utf-8?B?cmhUUzhXYkNudTAzdFBtOGxKUG16eXFwb3h4b1Y3VGpNaGVGZnQwOHlhdXBG?=
 =?utf-8?B?RmhkZG5MdGRVeWxlMFRiM3dHMHp0N2RuZG1LWXI5WkJTYkExbGx1MmZMZ3lM?=
 =?utf-8?B?dXNsQWx2NDR1dHFJVVRNdjBZOFpoYlpJQ0hGOHNFd2xTTzFqMnphRVVPU3pX?=
 =?utf-8?B?a3hsNDZJVmlZNmRWZ3BlWU1reDZPY1RIQ0VZdkVKN1Y2WS9CVW1vYVArRkRG?=
 =?utf-8?B?K0dtOHlWaWNyTHdrc2t4V04vbk1FL0J4SDRaM0E5WVdxQ0Z1NGtDaVhFV2hx?=
 =?utf-8?B?dDV6UHk1alZLeUZHQmlHTzFYSHk3Nlk5MWpLQ3FCVlVVMm1QM0lxNG45ZGRz?=
 =?utf-8?B?cmdHLzhkSWg5VkZweEJXUVhOaHl6N2xOYml6Q3cyMjEzRWRUVldHZmJaakFL?=
 =?utf-8?B?ZHFNODI1K25OUjV2MDkwV0lvek5Td3hraHUzTWZBTmJyOEgyc3BFRFVzWngv?=
 =?utf-8?B?Z2luQ0FBSVQvSXpDeFlDNFhqUEhicVFQVmhiZ1B0SDdxREk4TzU2TUpYT2w2?=
 =?utf-8?B?UHl0UzNwWmlFVVZVajlHM1YzRUI5UnVTUXlKVjJDMDBIcmY4cE56Zm1qd01F?=
 =?utf-8?B?UEt0S2k5Mjk3Qk84VGRSWjhucTFVVkhEZW5VV0N5LzBDbXRmNG1qcHVEL0hs?=
 =?utf-8?B?bUZTeUI2QUFBV3BlbERGeStiZlBKeHpwUS9peHF0Y0gwT3VQUHdCM29maDcx?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8596fad-421a-4da1-3ed1-08daf9ebebbf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 07:08:09.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfxSDOPqS6i+05mPu2VpeCGufk9UqzeMBAihk+0mxUEjFbf7Ax6rP+N1WwLGVyaXRdhpAEeGVuk5TRT8xsQAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 07:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10430

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=1&day=19&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/01/cip.2023-01-12-13.03.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan


