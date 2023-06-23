Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF6C0015E
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 14:40:57 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.74])
 by mx.groups.io with SMTP id smtpd.web11.224.1687531253096284019
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 07:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rt9Xj8Sp;
 spf=pass (domain: siemens.com, ip: 40.107.14.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SavMoXbc/iMfwif1vvVDH/qON1uhoptYaA5+SnQaD3/CC2zblBmJzJSv4S0BTAhWZwKR9K4w6yOTeKrG2Qn/x3QPLbI3h0rXyh41mwinzfqAQ1wrCU3fKTZtnpbRorrGU9d3pybc82mk+8C5Jm2IzVFVeuFXDMI+frqpOgQ6FOrUTcjMXGQqnpmGOrPPjdtA7cyEiUa2+z3Nh62MYYg33QDyWIItteQIUbuBx0sPSTryZ6lwK43JC1UToxp0bLM09qK8M6HQN66SVyPuItkCieAC1HptEETnlSUduuoDRZWvPd74vSDQyiClqJTmzA7kURk8UM2ZaQdx47Bc4enevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDOd49FzJzPQpkifBRoY5o4MfSkZPyv4jIvslBWazrc=;
 b=i7U49Ii9Fo4DF/v2WV57b/lqYaspsmenXbC5SGiwLQZLnFo0C2VJqtGyd4YgwM4jkFiB8xQ1K2Xv9EX9TgHTcCDuo9Ls0XLNx+hJomh/r5/2cdXi23hy3erOu4QyannQHiFx2/MJv2cqywNItmfbdu10l7o7GCocEa1bkhb5ZG9yraOQLv+4lNr4uHuPZWQKFBKVxm9wPw5fFOmLd90t6tmoQdUAHaWFvKmtRXcMSMpto+eFQR93PVph1ksCyCqfhs1P+KBannCSmcnbxuhh+EenQ5Fw3U6gZj5o4Qr2Nxm4GKXdPc8qjItECdGdrlXqlWety/qpG7nOxNV5LE1qmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDOd49FzJzPQpkifBRoY5o4MfSkZPyv4jIvslBWazrc=;
 b=Rt9Xj8SpEAsnj1Ntsg7lFY3Pmfw4WSWZkrtkwsxT7Jb46lQml90dB5CccQGg0FG0pWAQVW9UohsT1Ry+5ISfGuqKz5ATlmWX3OVhMkfgDDJZBXlv86Upa8AgYzRMsoV5Z6EHR1mW2qFlP8dtwDPiISlDZy2xnwltgZVrKIBQDQMJlSPT/Ufwza4GbQZJ393rQ3B0dQlQ9d8XH6ztP14p4/meGxbm34dthfKgYmRw3QtLm9mCebIVo7Uxx9BjdRP+7Vz1s+MQ1L4rt7eIESRbevYqZlTVbZq21kbuRDM/w9JapVGZsBCuLhwYXwCc4jCeFegYzL9lMkgWpPKVJkf1Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:40:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 14:40:49 +0000
Message-ID: <920059e0-642a-f83a-de35-937dcd4f4e06@siemens.com>
Date: Fri, 23 Jun 2023 16:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core 0/3] Enable swupdate targets in reproducible check
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: b03ff683-fe7a-4e5f-9852-08db73f7d67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	joX+K5DTANfWVGQYOzQk/2BRI+e5BJ8ADkUsFxEhc1PohISy1PuECWK/9sjLnHQ2bMLbPsGGav7VxyvdY7CTTaZp3G4pFxqs89jKMNxvJDDo2IvFLSuscx+fRnH6aDVjuex0vO3gm0RnaB5wLUGJqzxLYQi6P/10IZ2hSNE00v4VmvSmEZt8wOzER8YzPDJIOuiizVMN1ymYOHeUFzIcQCx8Q5r1olgaCgnRgOmmb/HFxZzVZM2McwTn7f95atzfwklKduscXCH9Fsbizys1hQliXTAGUAGRKe23XD2QAqUabxdZHX47zn7fenUYA7IUuHjVjeFqvI5OXre/7dcyMIEzYVH3Fdy7zf5W9xh0ad4hg/TUtvY93s5abP9lBo/6AhrsMScB16blY6ciKdw6Kv96U11K30F8SNpZppygMBtkMbPcuTTod+I/OWn0RRLiw2yiE+pOAcd1TeXZbyl/nZxm6kAtfCXhHc0MLOcK+jsx/uYKH7TqeXh0YDWsatTYor2rL9U0uirBquX6iro3amYKZhBUEjUaGl0X5S/gFaqMnPlto+yrrquxA4+H5k7LOqL9p15hi9MniMDMq0KGShb8qQbYnKSDs5isJ3auuHCnztDf5p+bw1UBBW5ePaMn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(31686004)(478600001)(66556008)(66946007)(66476007)(36756003)(4326008)(6486002)(38100700002)(316002)(31696002)(86362001)(66574015)(26005)(6506007)(6512007)(83380400001)(186003)(2616005)(53546011)(966005)(82960400001)(2906002)(4744005)(8676002)(41300700001)(8936002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkdQcks1K25QQTlzTFRkaW50bDhrK3o2ZHpMZ3VqbktyUUNrYy9uQXRUSXZS?=
 =?utf-8?B?UFF4UmtGVUZnNURacnQ3ZEV5YTY2QW5vWnUxUU9WNDVnZVRzV1NkM2RkMCtz?=
 =?utf-8?B?ZDBaeFBOUzNOcGlEanVLcVVwSjhSaWN4L1Zoa2lLY2Fva0Mwb2hTcUhVM1Mr?=
 =?utf-8?B?MjY1UStJM3dsakp6TDJHdUFtdzNIbk9PRU1ZWGZrSDJoRy9uNVBudllXYlVw?=
 =?utf-8?B?U0I5T2hvODdzZHVqRno2eXduVXBsSVF1UFBuelRZamxiRWNpSzZOWk13T3hj?=
 =?utf-8?B?T3hjZmliN2t4MWRMN3ZObzZpczBycElHRDBBOWdQODlrREw2S1lWZW42dmky?=
 =?utf-8?B?RmVTenRBRnd4T1ArQlhpM3hENmR5TDZENE1ubFZrSE1NbmN5d2dLTCs0R3NK?=
 =?utf-8?B?dWErN2RuMWNTWlJ2RGIyekY4QmN1TlBMeElDTkJ6RXA5dEgwV2hDd25KdkQ4?=
 =?utf-8?B?ZVNmUTQvME9FNnV4bG15U2ZOc0RvT0l5K1FzdU4xd01ENjhoem5rVWdmeVRv?=
 =?utf-8?B?M05tYjZicEdXZWtxNVNIaGdSUHMwL3ExUC9icHZOaEJJSmowZ3VUNTZtejd0?=
 =?utf-8?B?UFYyVWRDTU90OWNoUE50U1htZmc5c2l1dDFFRjd5dU5XWk9odE8wWk5WUXRN?=
 =?utf-8?B?WU1GeUVlM2FSU2N2N2FnM3dzdy9neHAwOVlVWWc5emFMWmdDczlzd0ZiYVUz?=
 =?utf-8?B?MVpjREZvYlJmRjd3dk5EUVhmM3JJSVZyajFHTG1hZ2VlOVpXVW9kWnBGUXZq?=
 =?utf-8?B?UWdGMkNVdXBiUWhSZWk0ODNxTys1RGp3aStSWGp2dEpkbFUrZm1XUmJrSEtr?=
 =?utf-8?B?NGgvR1pOV25QR1JyM3RGTzVOM0dPeWxpeGtvQmR0OTRyVjZNOFhrQkpNclQ4?=
 =?utf-8?B?dURKSGlQWUxEODlRdm9OTkpCS2J1OGQ3UWNGbGFGL2ExS0VxL0dGYVpYOXFK?=
 =?utf-8?B?c2YyTGxDRHpVeVVqTjcyTkVuTzNCRTFkT3Y0ZGM5QmV3YWNKTEdoZ1hXcVM1?=
 =?utf-8?B?MmZObkFyR2FadjBnWDQ4bTIwRnJQelk0YlFBVDg4MGtBTG5ZUFc0UFNiSjcw?=
 =?utf-8?B?ZEJHMFhUcDZhQzZUNkRjblVyUlRqbzBxZERTeWxZcTE5VnV2dTQrdk14TGE5?=
 =?utf-8?B?bXRKZFhYUXFwSDYraWJKaXJYZEJMZEdzWGRnbEpmT3JUOFJuNnQ1T1J3ZFRj?=
 =?utf-8?B?cG5nZDJLbCs3N1Nza0w3eXYxSXNVVHdXd3VjL2l5TFU4a201WUdBM3dHd0pP?=
 =?utf-8?B?Y295dXViZjdhbXB5N2FWY0lOWUkycGhuS2Q0VmYvdWJwS3JiejJlekVOaUtU?=
 =?utf-8?B?aEJyWUh0N080aGFuN09OSTJNL24wczJwZzRMM3RaT1Y5N0w4em5KZ2hLSURY?=
 =?utf-8?B?dGVMUkVvTU1FMDFta0t6T1EwUTNLNE81ZmQ0dWI2RUI1Uk1XeFBaS09lZisv?=
 =?utf-8?B?VnZiOFQxQTFDN0dzZlJWMG9DMWErU091M3RIREVLSVZaNGd1TVNEQ21vZHBN?=
 =?utf-8?B?cEFSSVlHTDYvWk9QLzVrTnZDRnRVMHFPRXQ1S2lBMVFvTXdzNDR5U2YxNjR0?=
 =?utf-8?B?ZXdTQkU5cEprL0RmLzNubXNuTGxsaGIzcklOc2ZiT3NFU3lTRFBkTms5RWx0?=
 =?utf-8?B?N0RNSHAwY2JFVE9rRVE0dmFLYmJSOFhNTElWWlBMVW0wY1RUaWpTV25ZUW1B?=
 =?utf-8?B?bXdFTHVhV0FKRjdDa1J6MFFOZFEya1ZtSTdLUnROeGlMa3FrekQvekw5YTNG?=
 =?utf-8?B?dDFObTlRRHd3L1M4WkR0blRlQnZ6QWNRWDh2NE1qSTFNQzlsZU5KYXdFUi9p?=
 =?utf-8?B?NDJLd0J4MHRjdkF2MGtIS1VwNk5vekZBVVNSb0gvTWV2dm5xczI4Rm5icjhv?=
 =?utf-8?B?UnFjd0hGWXFDNmxBK25YU2ozMnEvdFU0a1VGZHF2MTFCZkYvYnFuWFg0QnVG?=
 =?utf-8?B?QUZpSXczanh4Z043dk40eU81M1RMN3pzKzh4QklXSHB2Q2dWd2JjcEh6dDVu?=
 =?utf-8?B?TFh4Z3NsbmlSekdWejVGN1RSd1NtQVArM3VxdlRFQVNRTTQ3VUJ3UmRxRnJy?=
 =?utf-8?B?Wm1RZlQ5NXUxNkF1YjkzSWtPeFJMd0pWQlY2b2VsZHgwTnhsKzQrSFVtZlZ1?=
 =?utf-8?B?UW1jRUR5MU9YdmxjWWdVU0hYVXo1Nmg3NjVNTjYyY2x4RExqeUlwTUk2eWpv?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03ff683-fe7a-4e5f-9852-08db73f7d67e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:40:49.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCHtR9+sOP9cJfqrz5AxHqgw8INUQ1x1xkRCl2utdbxBX2UsmgS/fo74ZiaWunCtXm27+Q0P5j/uZRVKIn4Ymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 14:40:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12148

On 23.06.23 16:05, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> This following patch series enables the swupdate targets in reproducible
> check and enable html output in diffoscope to view the non-reproducible
> contents in the browser.

Are we reproducible now?? Or is this to resolve the remaining issues so
that also
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/24 is fixed?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


