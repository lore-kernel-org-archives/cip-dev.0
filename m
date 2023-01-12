Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C853C61DB3
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 17:11:19 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web10.61233.1673543476509358256
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Jan 2023 09:11:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TUeUYn9e;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy5Kp15Xk1B4p9gdqBfnTHId1MoojT4hVAqVWe9L8UX538aeQ1tImXW91gJTVs92cMUQkWxIs0cuKbiHTJkUbJLt6WBqvTWzbO2gl0KBvfv8BhK1WJUb0BTWT7KXzVorZxIZrSbEX89so5iugi1Wjad5ukk9lxfwrmey5xali1CDKQI/cnt+c2No/tDWbIYzVm5ALpIhdYQrRhBfb+e971F6ilJ+GV++CSnpjz/zDcxfRmX+9cIXrblqk9vlwnRBni99uWgdD1Ta2eq2LXJtc6+l1arrPNiaQHt3swnrDGAgJbZHvAwLhFSwaimGTNdugbQvs7tnOziTQ/4usDRmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqF0/ZyGVLmDM9+e2EOgtKElMoEh5R98DlEhYmi/mxY=;
 b=bdspjoNCjJAzc9d4nzOWdKcj2gBKbrAsTDP+cyjr/1UnV0ohN/rhNAvUqzY0v++Qkxu6zFPiZ/ZqQtlTA3bNPGjJXrawK0G+sCJb2TMBqLUTL+aZ9CNRs7SS9kzU1xwFpR94IsOQrl849Ihas1FZv6rbSQdNvuF2GvswIcuuQZ/pCVd07CKW8+twojpSgOpXwNUSISJeTEoMV9A/G3wQ19lsMq4cjUZsZyEb0HQlXG3rV8MTHnGosUPFPrlBYWbL1FmxaVu68HkjqAd04ZIGs4zpSKx3eNu9ORtipDnTgBjydZp/yeUdOqCV/p8KVWCLu0XYN4MDfERHDNY2GIlJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqF0/ZyGVLmDM9+e2EOgtKElMoEh5R98DlEhYmi/mxY=;
 b=TUeUYn9ek6PpwbJDXInpUxAa7XO8D9H7ojaHqA2GSM4v7rvvfiLbRwwVYbElUO0Qh45o5t7lidhB9u7GejfDz9Jk186Q88ryUAebRypLuO0hcf6DthVt5Pa18I0U1GNK/9Y9QiD9xWdKMsjbC7jRzi83NFOUd5aHQ+yfElzxD1+6T7T7MopqErJga7glY7/MRf9Xp/lthFAncDJdrqxY/YHgXxuI01a/POdxd9yvScz4BvjyUL5NKX9dCkFEy73lQFKnr7jN0l8R0wGnyOflQgunhLYvWR5uZb87pLcVsow2Ygg/zQSv/H6DbS8zaRo9gFN9M+3XezbY86PyqQePtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7656.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 17:11:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 17:11:13 +0000
Message-ID: <16f367d2-01f9-6164-9a09-ce8b421b8593@siemens.com>
Date: Thu, 12 Jan 2023 18:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RISC-V and bookworm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b9658e-37d1-458c-c8c9-08daf4c001e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tllDB0VUh7oq5wEsKMgO4R0ByocfjF/Ar9t7dTPUEjSjiqvY9Mi0LeBWTlOtcdNzS3HsIZNwksTBVFemhJUpAXn6kho35VfyhK4d9YAO7xU/W5Szm/qFhImEQ2LiFpjQwgjxqorzpls42Tqp1SW3Av8/Yh/nO290GLJ4vvQGFLteBNQCN/L7XeWdtWa9J2fxJoTG+GtrAuwg081LqnQEwXUTI1kzmzlaG1KnaAdkMA9fqB+hqXOTWXL+YZLZIjNQciwt53yGIp2kFEJf4icWP7N4IfCt4ncIBK+d2IZEeWfg1KhnQOafVmkVG6Ewp83NV7yPBjDuYX13bWAfue8tYrhg1lYmlIRJ3TrGqIDwz/PWHTgVOMe6HXK6ZUGWqyTT5KWzXOttJ7UREIfZ3oGPCMjzS/Ds9GY3XPUuZ5MSMlPacgNcoogYt3kFfJSITCjxtR7wHuF/arMIzpb3cdnU3CWJS5e8ErnmvUOnkuBhd4YVKh6/kHbr2rIoemaRFzFdej83MCLF3DI5tn5XZVED/S5mVukwhHJTMBdjsPSwrZD9JQBSvSK7sIsINJpCy3ZufBEYg3twyCdGiC1tF86v3AQZSjD+meCp5O7zQY99BN6EEUnCcblnR2b6MURJkXS3T6kg3qeHuK7Nd9FyNg7CdP2u2bbB+hcCI7trD7jQzkE9Ci/ZGikq0Z0yCrQIq/vu0AYDLCkWyt6r4r1EeTXojK0xFW/iWZKKa/jjcFwloqiHjCw1WD3VkN2D6LFRJEF7c4csdu/rVI/ITNjvbRD+EA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(6512007)(31686004)(966005)(26005)(186003)(478600001)(558084003)(316002)(66946007)(66556008)(2616005)(66476007)(6506007)(6916009)(8676002)(6486002)(38100700002)(8936002)(5660300002)(41300700001)(86362001)(31696002)(44832011)(36756003)(82960400001)(3480700007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmZnUE81ajBoRG8vY2Z1U0dINUtyNVJ3ZkJXbU9CNENhV3lqOWJGS0FEZjZu?=
 =?utf-8?B?WkwyTk5HeS9LZHNOMFV0anoxMUV2NFFRVFNFT2w1bTlKSjFUcmlDWDcyakhF?=
 =?utf-8?B?WUcyREhTdytWM3VzL0lwbzZaS2NsMFFRRzd6NU83dWxzRUViVTNhL0U4RTdY?=
 =?utf-8?B?bnhocWtaMUJDOFhZYkJxWlg1UmZ0R1I2bENRMDdqRTlZNVo5OS8vdmtvdkdP?=
 =?utf-8?B?V2hISkNoeUhBd3J6dVhVdWc4dERYTHNvb3pMZHUzM25FdzVVd1hwWjVwaVAz?=
 =?utf-8?B?bHZ2TWdmUSthUm5KemtndDJHbzJoMmxmUjBkdzNhT0xUdHNVcnJhbVE3L3dq?=
 =?utf-8?B?eFFRSXVsQ2ZWWlNOZTlndnVlV2lJcmdXMnd4NlhVbHVhaWNiZ3RnSGhZUEda?=
 =?utf-8?B?RktJZ2UveHd3N2gvNlRBVXVBMXA1QkE5UjNlWEt4SW1Ma2xtbE80RWhSbEF1?=
 =?utf-8?B?UVNQU0tMWHZYaGU3V3djNjJBSWxsL2Vhbi9ieUpXcThwWTI3SFFaN1E1a2Va?=
 =?utf-8?B?MUVFT3NKSVZGRHQ4K0ozaEcrK05ZY1VHeGN6dllweUNLMmFtTElsbjF6Y3JG?=
 =?utf-8?B?elhKWm1vSWZNQ0d6czBTSEJPaHgyOWE5ekFtbmxUNlY1MWtERVptWjVJaG9P?=
 =?utf-8?B?UkFscWdaQ0JzZURMMEZqZ1VKZy92QUplMDRodTlzL3MzejFTRDZQMXBqb2hW?=
 =?utf-8?B?U3lhYkcwV3pnbVFBU2NwZWwxbGlBeTdtYXVSM1hNZlE3cGhqclQxWVBEWGhx?=
 =?utf-8?B?bjJlQ3pJUlZkbzYwS0VheE9haTgvS1RFZHdDTGZ5aXUyQzRCTEFNZUJaTWlT?=
 =?utf-8?B?eXF4d242eDR4bERvSlpFOUlWWTF4bDNSdmZMdndOdXlCaTNoWTE4c1B0OE1p?=
 =?utf-8?B?NEc0RytoeWZuRm8wRGdKTDhXbExWSTZnOFBsUTZia3QwcnBqN01nQzRaTE5s?=
 =?utf-8?B?RmprNXRYd1pmS1BLTlpnaFU3Zjc3TEZOVmhwM3gwcllNTEpoUjlxS3cwekJ2?=
 =?utf-8?B?VGZkdzJyazJBdGNnTEVsZUNha0E5dHNHRS9JS2JWZ1A4ZGl6YVRUdjI3c2hq?=
 =?utf-8?B?SGNUSW5HcTNYbUljbmJoTFZ5cktjTEdDRVlPOTEydXUyYVF1YktRTTVpNFZk?=
 =?utf-8?B?OHE5aUdJa0UwbGpCb3o3RFMySFVNWTJwUklFa3lRSzY1ZlcrbHRvNU9wU21n?=
 =?utf-8?B?S3Vpci9jQTU2NE40Zm55RGVoVkJ0cXpVL2JYOUVXblY2Q0s2MXhKakhuRVpW?=
 =?utf-8?B?ZmlzN3lLbnFpUjRGWHNGUXB2TWlvMFdDbEg4bzBmeXRnSEJ0WUZEankwbmgx?=
 =?utf-8?B?Rm1oS0tlcTd4UzFMYWxtMUxlTW1rZks3OHJ1USt1NU1FMm1NTDBLeHlBaXNG?=
 =?utf-8?B?TEkxTC9odGUvL3N0ZUVKMWk4ejJjV3h2SUNOcmdnMTh1bHFwL2kyZDNBVlFa?=
 =?utf-8?B?UjIrUXJkaDZ6YnU1RTlrWkZhVjM0RXZ2UjQyQWxYejlJLzV5U3JRQnFzbjhJ?=
 =?utf-8?B?SWF5RGhoZDZxdGxrOXFhQUhSUW1QSVRmSkJwaFM5M3NYTE96NWRENVdHSWtY?=
 =?utf-8?B?T1FobjlEYXRjbHplYm9vK3lDcy9NQUYvdk04LzR4ZVBzUGhvaUwyMXVRbzBQ?=
 =?utf-8?B?a3JJUjJmOUlXbkhsNk55M01IaSszMUxtRXllUURQTkp4T1JlUjNBWStDdnFV?=
 =?utf-8?B?V3JtdDhBTmZQa0k0SmVIS2NoVHJkdDV0QWRmbG5BdS9zUFZxc0t4djJ4Mnc0?=
 =?utf-8?B?ckVvVVdOZVNDWE9sc2FpVndJb000czcwZ2Z2QWk1YWhZcDBCM2NUMElydUpI?=
 =?utf-8?B?SmxzU3VqZ05yaXdYWHIxMW1GWkl4by8xOE43bTByWVRCWUpScGxOUkJidU0y?=
 =?utf-8?B?WG8zWERBWHdNbUkvUVF1eUVOMWorc3l0TTF3OEttK2tEZjNHeWpua2N0MWxz?=
 =?utf-8?B?QmZVMlNPd0dLS3BHeW5nbHUwbTM1T1U5YjR6RGNGZS9EbUd2UjRucDgzOSt1?=
 =?utf-8?B?SXFseEl6MmtHRTRva3hNWjBxWlJ0aVZLZzJIWUhSMFVUSUlzcmlnQ1pqSlFH?=
 =?utf-8?B?UDRIYXVVVUFnOFNqNDhZbWJQTElHK3JBQmNpdE5TK2VDREFtaTBqdVRlSVNG?=
 =?utf-8?B?eWxmWGl4YWdEb1g5cDlsb3NreC9BYWJpQ1FiU05DNXphUC92OEg4ZytoUi9a?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b9658e-37d1-458c-c8c9-08daf4c001e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 17:11:13.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: is6z9PsJ6wB8PKZsN7SwiNKjnu10mHdfP8P5MlTuod9vuLPuWKs799sn24ttBVrgwrXxly/q7LM7SX6Vj3ToJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7656
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jan 2023 17:11:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10346

Hi all,

in case you didn't hear this otherwise already:

"Debian riscv64 arch did not catch up with the release of bookworm in my
view." [1] :(

Jan

[1] https://lists.debian.org/debian-riscv/2023/01/msg00001.html

-- 
Siemens AG, Technology
Competence Center Embedded Linux

