Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6F3EB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 07:09:35 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web11.5980.1687417767682163685
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 00:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vCr6Yk5U;
 spf=pass (domain: siemens.com, ip: 40.107.21.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzyfbx/7YkwC+bu5WHmdVROaPfWJwl4s7a5KXTEzoc8eR6okbndGm+8f1zrHW1pGe/wY9CbbMyCeNyT/4l7ytMAA+5GffA8AWFBmT6ZGN6UeSp/wpME/biLjPyb1ET4Sye4fVZ0SOoM1BRjTtJ2TW2VEa1c80JMKaEw5KTWjyG/o5vr5GtUsYF4nMXCcyRwKF4uYTko3lSHZsy+rnEL2m1frkkCwXhnxCt+svYMh9o5RavtLTnNKlEwuk9ltfShz4n6VWKks4fGB35qE10Rk2+vtuMANDqxeF5EoGEkxGuALxwUaTMBoyLWsAUE9DPbwDqS9dGxsLHYYH5FkRvDVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1AMkEGPPNOSvXtuwSMypv9s4UncZZDCwAkHzTsYb+k=;
 b=Dhd8l5Xy6RuK82h2pSeiFHbTuDczDnY6+efmpF75dVYYnHyCm8KbPNUv7hP2TbOddIpXOHQfwlqbA5YPxKwre8a8o43DG0ColaV8l/a4+MWTJTpMouxgWFcMbSfw04aJwtSxo1RW0IUrCv7wITZX08J309aGy8XXmDNTRCelpt2baFEdx9hADziRFxu324Wze84+evscWMb2xB/dxBqO7UC3vbN7D2Jut5RQ+KVDPajKJSNe51/HG7QWXnivLuSwRQqkQWg9QFUb8Z1PdbtlYxkHQ2xbPfMKcRL2TLHblwF0alK3ZPe950+PlVhsveFy1Kmwqkg7VtkmgmVybaIAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1AMkEGPPNOSvXtuwSMypv9s4UncZZDCwAkHzTsYb+k=;
 b=vCr6Yk5UxF/m5qXWgfI+4e3Pi4s/h9zToJcf6cKIvZnQ8NrXSPLBLm7SnpU9B2b0jfSuj3WdTuHn9AUQMrHts9f1mSI69YO5UjlK7i53Yqyue7XJX1bZ/XqBoIV8LsCX457XrF0025XKzSWXcWweBEfXBB0OaZl6VEauIvPeRfjhZIpCrG6JRomp/gqAJVBgKa1XHaWkZJ5DTSwW5RAcNJC+MkZENX7i4gMM7jXxW6puSGxJESmPEcBMcaeP0HJ7uNuugEtqgw9Vg0uSgSGJL4f1BWe9yPSJqfWzrdado7sfwJK1E25hKI3nhr1aSKXOu1lVe2/iPs9pkPRog2qCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:09:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 07:09:24 +0000
Message-ID: <d14d1cbb-ec04-d4ac-41c6-af6609158952@siemens.com>
Date: Thu, 22 Jun 2023 09:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3545:EE_
X-MS-Office365-Filtering-Correlation-Id: cb78607b-ad07-401b-18c2-08db72ef9bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZuBEs6mfM0xniwaB5PRq5sinkzgid/NBmosCvV6WJc4XLCubC9VC8Itt6L8t0H6+J6ZYBWK0AhkOlpYP8OLeROKFC3UxElqwR8pFvlDeCq/h3OX8Ero7XJM02dXA/Bdl1c/XPQ1jst1pIPq05xImCpwd0YJltSvjmRf2ab+uSKb9pbB6u3UeV7zTJI2BJPoWDET1k9mZqMKoM6ZsXxfoN/azKtkx2YyAtfLTks9roUXsAReK3u/hB0xjkAhVSU2QW7v5aUMt4jX5a+lXw1TU9o+ETEbxT+OD0G0rC6XdfyfOaWf3sTOpWDIyjvvb+/P1qJHgiCdYmzIQl+KZXLenxp7We2+0bnxXGqIuaFGBgE7frwJ1E9HhuFYo3FVV4dd0bxBZR9g++dZkRfO0ULp9dLQskSeN3Js22qA1U0GC7qF4QjfiHQFgz/OtO/h8TPD3wJO+2zBttXDFMba1p3ChnQ9dEI3t0j7vnY2qHbIL5NOz2UbkWo+VmLf3uWaDB/IELMAs3Y0kh9Ss/MAnBCm7t3jOA7aLmHXarJVieheXy5i8q9KvUyQgC+0/sNFLd+uj6fWFuTIOHB75fqvGf3E1IuBEEe1JDTHtH2uwoCu9oDdWWD+/qAyPDEcYnPqG/E7jakhsCL8TY+BNXCulEgJh6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(31686004)(6486002)(478600001)(6666004)(83380400001)(2616005)(31696002)(36756003)(2906002)(966005)(4744005)(66946007)(186003)(6512007)(26005)(6506007)(38100700002)(41300700001)(86362001)(82960400001)(8676002)(66476007)(6916009)(316002)(66556008)(8936002)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjZGRkw4SS8xcTcrcW5kc2t1U3ppRk1pT0FSOTdHemd2a1dtcXhmUUZFQmgz?=
 =?utf-8?B?QWNBdkRMMVBITCtENjFMYk1FUVQzRUVqNjFUT0QwSTIwVVN1aCs1RHpmOUpa?=
 =?utf-8?B?YXB4MUVVckV4QS8rMC85eTRObmlQZWt6cDhrQzVrSVpiZkZuTlhhandCUlZq?=
 =?utf-8?B?ZlZveEp3dlZRSXFnZERFRklUbnVnNE4rais5Z2pWbnFISWlRSTZkKzJVLzUz?=
 =?utf-8?B?Nmk1NVpPSGhBK1oreUU2TTI5QjlQKzVGK1U0Smh0RVczR0pZNTI0T092bG5O?=
 =?utf-8?B?RGVTQW1vUXV1Mk1nZ2xJdVpMU3h6SjROUHJrTDd1MXZ1QjlUT3paRFdTL2cv?=
 =?utf-8?B?YjVPWU1RRmtnN3J5eEExSzNrdVplcUIyUDl2b0JUeDJSNkxLOVZyMms0MDNI?=
 =?utf-8?B?YnJOK1lBdlNRQzhsajBkZ2MxczdPVGJ1N3NkalZXMlVYNUo1eHRuVkUxU291?=
 =?utf-8?B?TnBJRHNMTDYycGtGbyt6TldOVHpZbzJ5MU0zOWJDSk4xOXNvU0JrOEFmV0Va?=
 =?utf-8?B?T3dyRnVNbEx5TWphbnY2QytmNkpaQi9KQ2FVRXNWQnYwdlFIV05ndjVnQW5K?=
 =?utf-8?B?MXM4MGJGd1EzaXMya2ltTjlsSlpRU3lOZ21ILzdNdmRpVnQybkFYY1kyMjd3?=
 =?utf-8?B?KzRqMjN2Q2QveG9pVWxiZjJYS3hSYlp1VzNvbzIrTXpvVzdZVGg2aGtBZElN?=
 =?utf-8?B?RFpvbnFPYWlha3l1b09yL1kzSkNlMWd4UVJOdUdhTlFtSk9PMHpNSTlwUkU4?=
 =?utf-8?B?V3RGVE9vREhJak5HclQzMGVtME1DdUgxc2U1ZlFxT1RYQW9PN3dMeU9tWm1a?=
 =?utf-8?B?eVNSNHdVc3BHSGw5WVAvRHJtWWdxZXg0NVlnMEdDMitLQzNNbVRhdjkzU25F?=
 =?utf-8?B?cTFCSWNPbUNyNlIveUlKbjF6SUpidGFVeSt5RWhkbVdPQWd2WjBhM3N0RENN?=
 =?utf-8?B?cThpa1U4d014WDF0SGkzdHBnbHNSazQ0UUwzSEl1WnpuVFJ3cmpiQXdOa20y?=
 =?utf-8?B?eUszd2JiWlFBRVRCWmJ0STJlRStEenAzTDROekVRamx1dExIbWlwWjNVbFo2?=
 =?utf-8?B?RGFvVUpaUnh2UjBsZCtVbXcwUGlXcGRaa0w3Y3RCRnpLK0xlZklrL1RxUEx2?=
 =?utf-8?B?TTZpKzFBb09JWnN3TG9uYnZxdFpkV3RFblJLTzBGNXlZSzZCQmxBdU9rODc5?=
 =?utf-8?B?VkVaUzZUUFBrcEVJU1BDN1RxMlJNc2hrS0cwQXlxSFVwTUY0aTdBQ3ZpTm5T?=
 =?utf-8?B?emJTSzduU1M2b1QzNjViYmpvNk92ZzVPQ3lCQVZsMFJEOE1wR2x5dnhUTzFX?=
 =?utf-8?B?bFYrRHNWaEU0UG1EYlpsMkhCMVp3WTRzQXhkMitrekxiRHlJOWx1dFRubkhG?=
 =?utf-8?B?TlU4ZmFEUkZkblhoTExCOWpQMlMvWFBJdnVOMXZZa2FWbSszQXJScTI2cFky?=
 =?utf-8?B?MDh3d3UyNFl1RUNUV2ZvaElxdkFEcHBLdlpXRUFUYXVVcXlEcTgwK05Ec2ZI?=
 =?utf-8?B?R1BJR1VvajRha1lJbXhYbWJmUVNDUnNIaVUyV0RzaURKWU9yUktjK2NGR3Ro?=
 =?utf-8?B?cUtIb1RuSGh6c3hMcVRJa2UrampQTVVCc28vRTNqNEs1aVBHTjRjNmhUS21Q?=
 =?utf-8?B?SEdSczU2N2NhWnFnMkRGcFJjaHNkbzdmWTJyQkZrRGgyUlJyVWo1VFBRMys3?=
 =?utf-8?B?MTdCOVIxT3BXS2QvTlMwYmhkbDZ3MkNOSXREWjE1akN4blBTR0ZXODRuZWk0?=
 =?utf-8?B?Z3dHWm42ZlYrUmFjYjc0aFNmVnlxNXhIVXVBb1RaVUthbVNaNTJqM05oRjlh?=
 =?utf-8?B?QUl5L1ZYN01uVDczV1JNUitSQzhDcmp0WXY2KzBoc2p6RWZjMStDYWFtUHlE?=
 =?utf-8?B?THQxaWdnZ2VVeUgxelNheHdSczlXR3U2RTl3dGtYR2VGdHJERlMwNzg5QjJN?=
 =?utf-8?B?YjJCV2YvK2xQVkp3eUpSdlliN2NCdTdNVUN5alhuWUZVbEVsLzNoeU83Zjg2?=
 =?utf-8?B?ejdvYld4bXZIdFZxU0NvaDN2aGVpUzJTVFJ4SkV3dFJ0ZFExOHUwekFBM3BS?=
 =?utf-8?B?K2ZjNFlBcUJrS3V4Mm1LU0VrU1I3dDlFR25rYzNsbjk0VVZMcEl2RU82MEZy?=
 =?utf-8?B?dWtZeFpzdHF2eDBVOC9wM1ZDZm5EcXhZbXdqdDYyRUZOTGN6azV4aS9KQ3N0?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb78607b-ad07-401b-18c2-08db72ef9bfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:09:24.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY7INBQJ5zQwEpEliOJu1gU8oNAXCJp8GF7ooMirdp0u2tQ+NQL/Rdlm4JRCn5rfZABA/bfW5rvcFebgs2H2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3545
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 07:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12114

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=6&day=22&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/06/cip.2023-06-15-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

