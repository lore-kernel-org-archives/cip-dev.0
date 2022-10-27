Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22961C38A2D
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 04:57:17 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web09.3121.1666846632741496289
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 21:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lYb8sS1A;
 spf=pass (domain: siemens.com, ip: 40.107.8.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgW69PHEqzwijBgTtqhWWJMdzaudHCN1dpmx8YlbT3dPI+CIAiZXd1sM4/00aqWD4OlSWjdTYNzxwKxUwtAH09AfE5LSsAg597wWPRCpd00hTyNqPDIr4uNGV/18tBuCD+q4X2cox+vot4ITgbnZUUpWGRYTL8PnDsmLfQ4pQG0XdxelU+saqvRu/sKqyKI9b86ntbDcArSPxNZ87QHdTBb7yx9sl6dmKdMhFfhOx0gsBNbxAvINxhPwa22xvgPkvFAfdIVh78hN6NZ+iO/oK55zUf4jzqN7tNW/i63JLqlcIXQlqR3cPSd1zBsa+WXyd/+wbdBuyt9US/Ux2Fh81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzUeEfxFY1vidlmVXPeL7yOk1nZvfLqXha4J53tOk5Q=;
 b=SSUPG51abSKzDTOnOWkRv3CeLEUD+OBN/oeO08Xl6fTGAaOCstzxasB6d88/eg0txvihSZv1i/QU81ppNkaUiRawdWSFOkYghjgG61Gk5VOhNJYGO6t1p/OpE6kOEZOWqgc7jrZLjrAhyBdVcnVCKXxETZLmjLfyD/I70dy0Axjk/K1M9BqOxiSvpCJO4wtn9f8dfPfVIDk//U6LSj94nHs6b5IfkEcljqdz1l8WHVgKm5z0OGmErZ/znSipocaCMGbpvaC5xERyS4R77+OCGym0HaJIWWLz4iCx7QdefPVQUKH8fBuAw40r5XymyjCj7xm07XEWP5YC7wiROo8cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzUeEfxFY1vidlmVXPeL7yOk1nZvfLqXha4J53tOk5Q=;
 b=lYb8sS1AcbH3YNiY36OsF2FlDYRJwpB/vPy8iCe922oU+ktJGnqhw1jvSsQR+lqAGqS8I4Zfz5PI3IxNqIV0I6BEgB0t7sSRU7zEgVToug2kMHoihmmTsrLS22BiQPktc1a4Q4vgNChIcDiQG9pEXEwn3Z0fNpHV38ll7jlYkXNIYo8MnW3m8agNMT9Sgfbqv1KE3ZTy7AN+fHMOY7unGeKX9pi6h4md0Ddg9Ymuflub7NwIeDjZ7D3I5l2EZ79fO4JS2fjSItMF5ludbrd5Ii4PH68vghKy4HtzD2qOHCIkhbh9B8lzBAScOnb0yRS/zGDmThbWfIL3zK9Hm4l3rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29; Thu, 27 Oct
 2022 04:57:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 04:57:09 +0000
Message-ID: <fc00a363-65ba-0918-273b-405c05f6228c@siemens.com>
Date: Thu, 27 Oct 2022 06:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3682:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eddf2f0-37ea-488b-32e5-08dab7d7b453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	72gbbxj/u+anynXx/Y55pQz3AokoXTAq74c9PSxlxhbIVB9i/BCX/AeEOYQ6n+0UXYefyw/59Yb4gOJdGBdiMC3uFy3L5LDC+CU2wYJPPHvEps3k8KvtUa545hq48TyKiUJI7yRJBzm5YFrtJhnayDJ6U+ppWc8n8m4MjHL6o9fINGZys4IseEXY8hKxJtb1Jyp1sQTpnY1z/zXPaYZJe1jthCyA+jzsSaLM9MpMFRfysP9A4G+VUvAH+DEVecHhQzyAlxCHeI0w/YbUhHZQx3++vkpFrXhNCfFeI8GRCwl76gqr7WSO9N4MmD9/ehV5+KSp7GhPYJWuNLfRnvXxCi1bVtTe09OZgIxZAjU+bDyQb7s1HCSa0W9k2v9CZVVSegQkpI+F2l+9+gHFVdQxprU9bTux5t3V3wlvbXOnyvglYkWQbsiBSspfouubMklraiQtM0kGUVtY01NcajqIRibfFlU+l8DWm1F/nA1HxkwLFGgO1DaG1IgwwydTa9DDShIaT7n4yK8mGO8BiLpehcATmyUgeGKjuW0wqrDUBPYDSI5CQdFgZn9pVXCdfhEGGXZaXJrV74JOFW2NtkZVATvM3QOiJmmHtLlkedeCTk6HVmChSx2+rshxzN5WQ+tTVBZ2vQ14Enrxi4TTpfMhAp2td0P/3owQ37cRbi0kgxv9K4MzFTQjXesaYGO0Xg1+PCcVUQ1lSm8AFPsdQfUF7ziE3dRccdGetjqcR0FpLEEjQc66Se7PSJ+VSw7fQL4HskXqFKB1zck1QqulxhAlu5QDe/Cty3ZzJ5ueTtvUWv9xY1EISu/OdyU6CzM4YsLzV9nTXYzmSoWHaz6PT/7jLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(2616005)(6486002)(4001150100001)(2906002)(31686004)(186003)(966005)(8936002)(83380400001)(478600001)(4744005)(44832011)(5660300002)(6512007)(38100700002)(26005)(41300700001)(82960400001)(36756003)(66946007)(31696002)(86362001)(6916009)(66556008)(66476007)(6506007)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkRWSEkyWURYd3RzakEzYjZPSXEydTlIZllzM0gzN3hVMUcwT3pXY0NSS3hC?=
 =?utf-8?B?MVZnOTVES0RtMnliYlVhVzBqc3RicTQwNklIZTJVejB5VGRBN2pRSVJoTHd0?=
 =?utf-8?B?K1dDeXNXWjFmbWtXdWtUdkxvMitLZnRjbUFEZWNYVE8zQTVueVcxNUViN0dH?=
 =?utf-8?B?Y1o2ajdnbGVGZ2pPdTRjcWRUNWpFU0d2WndwdkRMQzVKNTNWQmY0K0hvSXBB?=
 =?utf-8?B?c3RkUkNwNEVYTFhJeWxJV2tTbXZxWFJ5WlhCY0ViWlg5ekdWcjM3cXlkcDFB?=
 =?utf-8?B?VW84RFJsQW5qVE9MZXpFZi9PVm94bFZHT011SU5QcWRlNlliZ2xTdXVPMUVR?=
 =?utf-8?B?NVplLy9EK05ibU15WTVUOFpaNXZOeWpvbHQzRlozSlVmL1pmNkJWOFVlTHcy?=
 =?utf-8?B?eXBLUlBjRmwrOXZkL1IzcW43N2JrMFphcGVLRVE5ZHhPdTV3VHpkblRkZTh0?=
 =?utf-8?B?ZnFHMnpLRXZJdURiSlVweVlscnVOYm9qUGlKWC8rRDROTXdyUFM1Rmh3VHds?=
 =?utf-8?B?SEJnMWtLd0xEY3ZMcXZUanlic2ZYaTcyR0VzNFF2TVZWcC9vOGJhSzM4NlJW?=
 =?utf-8?B?REtnLzVsb2xPKzA1aUV0QmNDcVZJcE05QkNmeXk5Mm9xZ3FVcndNbXVVR0VQ?=
 =?utf-8?B?cnR6V05JTmVrSWVLdXVHN0xyWmk2L1ZaSHlyd2U4eXU1T1Yya2ZGTVVFVDlE?=
 =?utf-8?B?a0o5RHFsZG9JU2djM2V0aFlNZTJNRGh0Z2JPa3drdmxtWFdleGVTdjhTbDMv?=
 =?utf-8?B?aGo5U2hKbzRsVk5aaTk3ZmYyRkVvU2kvUnVXZ09iMFhMVEZiMkUybnBnNXBN?=
 =?utf-8?B?cncwRW5PbGZlOXhmT0lRSzFVeW5rc0NGZ05iSkZWK29seHhzN2s4aXZUVWI3?=
 =?utf-8?B?QVpWbXlVTmRiSU92RGFvTjl5NFF5aFRpaHRvSE5jcmExSXE5QkFYMW9hQmQr?=
 =?utf-8?B?VS9DcFhybEN1R1g1Z2d4OUErUWFyWEZ4SGxCMGk5dXBVRHpwL2IxcmdFRSsx?=
 =?utf-8?B?L0pzTGFGYmVPdUFFVWhRSkQ4TjZtWkxaQ2dJd2NtaCtQZCtQMm1kTU5kVlJ3?=
 =?utf-8?B?UGdzV29KVFpvcE1PV1pzRU9XV012RUwzaE1RYzhwSEw2eXRsVCtpVlFQUHJj?=
 =?utf-8?B?cGpsZ2JMUEFXcUtDbVRucEFDYVJzMWhTMlRiZjY1QjJNNGVrUWlXZ0Z1ckJv?=
 =?utf-8?B?ZzY4RTQ3N1M4dnFSa1BJdmpKZEUxRWZkSTFWYVZrZGJoWkdHS1hmazYrY3Fl?=
 =?utf-8?B?QjNaOGZmZnJSNnhFZ1RJakFjdS9TRmhYRXZibHgxenYxeVIvdzZSSWd6V0Uw?=
 =?utf-8?B?Y09JYnNyZzBsdDVBU0htMVRpckJOTWlDYWZ5SWFQc3dLUUlnRzRMWlJKNTNT?=
 =?utf-8?B?ejNjdGJGdE1WQW8rQytucTB1eVFTSXVqODYyOUlTd1l3TS9jSncrQTdHZ0Vp?=
 =?utf-8?B?dG4vcld0eXAvbzJRdHArOW8vMi9GTyt1aWtMVkVIbjdGRnNNbGhYdHdTMm1E?=
 =?utf-8?B?YUJvVkpNWlhoRnlqenVMZlRGMnlmaHNyNjZiSEg3Rm1TdW1TeTdDTHBvWW85?=
 =?utf-8?B?ZlFuNnhsTjVDSkNvbTRxcDZ4d2kxWW1MUy8rc0g0RzFPM3V5bUJhWGZ2NFhh?=
 =?utf-8?B?MnNCYTEyN09mSEZPY2hlbGJwakpmZzkwQjBXNGVLalVWWFFtbTJYdHdMZkdM?=
 =?utf-8?B?K1N2M1c3ZmdHenNwd2pnOC9iMkUwSkNNOVpHMUdZbGszZWVmc0YwN3RBQlhE?=
 =?utf-8?B?UTQ4czlsUWlJeWJHMkREa0ppVk4zNW9iOXMvU05MYlFodHczaFN5RDVHU2NX?=
 =?utf-8?B?WVd5d2RGSUFiV1FSWkNVOTdNa0h0WW9QcFBzMTR0bnVpYkVwRW5mVXFoc3hx?=
 =?utf-8?B?TnRhSHREQ0VDWHB2aFBzWkx2SDVrQUpGNkRsdVZubUszOGQ5ZXp2YlRjYjZi?=
 =?utf-8?B?VndXQXpQaFM0R2RrcDNXNXlVcnpKMTZ4bytOUThWcGN3ZTlLOElUbXFSTzB6?=
 =?utf-8?B?Q0ppM0dsejZDOVBxQlQzNnl6WFRZSmpmVXVPVGJ4WGdBL3lKWEpQdWtKM1Rt?=
 =?utf-8?B?YVM1RWZ5UXVLT0hleEVJV0djaG1MTzlsZkxNUjNvYUQxZS9lQzN2eFVDWXVY?=
 =?utf-8?B?S1JKZXZvdnowODNiQ0JKYytWVVVaYzEyb2NzUE9DMjBha3VYNlFsT3ZFR3BE?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eddf2f0-37ea-488b-32e5-08dab7d7b453
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 04:57:09.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSnwgIdbf+ZNacPOQgE9Hc95gQCUfpva0ClyPXAIU6c++Xl4U3ssa33jln5cACYhQ3SIxPk2MUsdrZGF8RfJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 04:57:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9876

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=10&day=27&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/10/cip.2022-10-20-12.03.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

