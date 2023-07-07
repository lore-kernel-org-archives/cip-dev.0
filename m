Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B7EB64D9
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:40:40 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web10.13924.1688740832656309990
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VER0DWx4;
 spf=pass (domain: siemens.com, ip: 40.107.8.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQg0CViTphfiAFZkbyn2pvigHMfRHzZKdzmyt8XwNKEU53sxLnlz+1qyhyFgyn4FPcLBvqJ2ks5Yse5xx8j0Yg7pCVVmsMSV22baxMKGoThkAX/SgTkHQYcmu1W5kKfeaoiTA+lBdWHcdCIRbxlzVKE/scKSSvdGP+2/PYdfe592V7apaw7q0kpQm1f12IPWkoSmz0f/ZscBI42Z+8uePFEvgRt/SMZPVWzeS3n59OrkwiTFkwtp6gDCAcjkeqjMpUGKDDZAv8ZuKgTBSc2r/Wj8QMVfQPy3ipJVlHKxNKeKeN//GtXlQQ41aM+qdJFjuR+OsRp6toByROgoi92nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHjLd21idwxumfHHMVzStKUSmfOtdl3BoX81XNIg2NU=;
 b=YxiwPrFYplnhIcd8iw1xISaSqeVDefzYAf5oGFJKIp8ojmejTK+OkF9u7WJKT5N2/zI1agxk2W84RkUkWaGj/5NoOgJ58P0g5Np3B5amOKzKwn9RRyANkAy1pOsLcXiEJq9NCZToT4qd7lkcaZxttcS5zh41eXQpobVtP2rUUI0ljSCTxXObeJax7CuajFDPdwQwz8tDe/Hlb+pJKbjJAkyRCe+meJcoIfcEQ0p8q/Z4+a4MMVpg9sNsF+VwX+Plc1O9mAc8b16RRDGZfx5/EHiZsPy3LmwzP0tJHZfqIwxF5dJs8aYp3EEgsstIlOcE+7e61IeUigJQwnrg53yKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHjLd21idwxumfHHMVzStKUSmfOtdl3BoX81XNIg2NU=;
 b=VER0DWx4y6OeJf3hm3ygONkpnd4D/qmKJVv+jEmkxvYKuQyOO6Rx60FOr+ItqWl8xWATOYo2zv8YankMC6q/2dFGif7RUwgBSDIWmH9MYn/qrKyiU70UEMMd5uRZOiOlvnhCuCFDkdMP892XpXL4AO3Ai1MCYDGnJ6M5nbQeYlnl5+O0ic91+ofqJ8zhOE9R4y56OgtHKxSwri6oSvY1gLxTnocxclLwDp4kb7fE6u6Waj8pHolumvQJyYT2YKQRX4SEjJ/ImPQ4n1jAMZWeal9nHcfWlvvD2T52ochgJThteYR2tD9LG/1Btx/sUjpvDk+wTVY7hgtqYi2OYcrpZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:40:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 14:40:29 +0000
Message-ID: <71b35181-1ebd-2d68-4c8d-81fca6acba8c@siemens.com>
Date: Fri, 7 Jul 2023 16:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core v3 0/8] Enable swupdate in reproducible check
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <176E5CF032D87010.7887@lists.cip-project.org>
 <20230707141550.27805-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230707141550.27805-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d63fe66-4bd8-4395-9f7c-08db7ef81c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b0TesFY/59OhNPyiYPxy7pBpBT4wzUJPKKG6lOe/Ou3yutiteigexA/STG6c/7pVgPiBQKW3NzyBx8QK5LuU6GpHdoGqFuZ/QhozIBZnGsijn9+gJkmARS8D9MQeRJ6pxrSx1jMU150egUCmme15/0uzhcQfh0dTcABy3HwqSF49efZHgBy8HNY/79cUTQzplu63i9jfOyMNvtYBMybKluD3hYjY+n7Bw/85ANlFbCymy8N7xEtIwdUrWFXlGXR1YXs3NrOoLq6MROdvpWw6Z8E+D3+heWUq3ol02fcB/LNz+01JDhH6A0tkAXR73OiSJmrN8J3wZHTFFcqcN8aZvWTYWbp4qEfrBJNiOTfdxcofUniG8UN+ZBTuu1XDA4aS738OyhQ7uVYsa1zk0htHwtUuovFVFi5aEuWmoZyfI7DEC9KBkV4t0MD0my/az3Z4LR0jV+y/x5ubJ3Bb2yvkOf9KqX7knVOhYS91Hcz0G0WUrQkBPD0z09FO0BEazgCRYFC9tTc8Sr/rS+gJlqsN109kTVQgq7+kbkiLGLQsz+HCDqsIG4H9zg4k54MTyT6z+i8kHUcewPR9DcwP3ms9kSxNiKO5GsfDhDXpRhNNY7ojdKNpsPMyrRuWr+/bojsbjUzKIgSieYNRJ0Mti6OOlA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(38100700002)(82960400001)(36756003)(86362001)(31696002)(6512007)(478600001)(6486002)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(5660300002)(44832011)(31686004)(66946007)(4326008)(66476007)(316002)(66556008)(2906002)(41300700001)(83380400001)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDhkMUp6dzUzT0JjelhCYlQzVExySHVwcGV5Z294cWtIZkowdXJPSWRNQk0y?=
 =?utf-8?B?S2p2Q3VNRGtmRGZ5dzMrd0JvcUZHNHErTHFZa0ZDb25lcHNMQWxIUFJhWFBr?=
 =?utf-8?B?WHNSRXNta2tsL3NaS1BmR1JpaHNHNWg2ZEhlOGxndC9lZW13WS83Q0lkU0p3?=
 =?utf-8?B?UHhRU09zc1BwaDRJWFE0T2tDd1dwLys1RFhReXovSGhrbjdyWVZpOE1HNUY2?=
 =?utf-8?B?WTRjNWhvUVlHQ3NnYzk2RUFkNTQzTTJCTXAvNWhVeGpMQUgxbzdLdGpQMVV4?=
 =?utf-8?B?Y3F0blZySld0YWc3QWN5MHB3MHdBOUJNMlpYcm9lcXJNeTJpOUpVQW01K3Vs?=
 =?utf-8?B?L1Y2cFRkZ08rTUZvYktaeUJmWUZuSnE3SFdzYlFxSm9ienQ5RWVzd0FwcU51?=
 =?utf-8?B?L0JCazh1Q0d4VnBnckQvbnNwRS80ZVRLSTFVV2Fxbk5YWndVSlZoVDFiMklS?=
 =?utf-8?B?SmpaazBTVjFsMTk3NGc5RllSdm9ieUxqeUhxOHVqSnZqTXJhVW9xTXBKejND?=
 =?utf-8?B?MWxZaDRPVm02RFphNnQrZGtaMHltdm9DZTRYU0FXWndLeUw1TENsampZdFlE?=
 =?utf-8?B?MFBObXJaYXFBWFZlL2xMUUFOemdxQnhJdVVBOEdVYjBqRW8zQlJ4V2NuYWt6?=
 =?utf-8?B?T2FRR0NUMjVEcmRpdURFZ0Z6dGs2dmFERGhNNlFoNkkxS21FODI5eHBWNk0y?=
 =?utf-8?B?aWRrS0hDVDlPSEVVNnZjNzIwTm05VXBQdGxvNVBQYWJOODhCQ3pwZjlkVU1N?=
 =?utf-8?B?SDBlTGhBMytRVzBNUzdUWkgxYUoyTk1OeFJVcWFhVWJIeVFLQUwzc2dnQ1NM?=
 =?utf-8?B?Nk83U2JpRjVUMXBMd2VManJ1NzIxT3dWYTRPcWJ3OXNmR3h0WjVEWm9kcXJk?=
 =?utf-8?B?aVBwdXJodE0xV1BXeEdVcDRaSm1TaUtTYnBoK1RvVEY5d1RFREZ3RmN5VGJL?=
 =?utf-8?B?aHc1VyswOEZPMzErbDBVMHA2TVVrTWxvOGQwMy9FTG1UbEVNWmVONEplYkZZ?=
 =?utf-8?B?TFhBWTF1bG8vcVRmK1VmMUlwZmswcDBPaEc4TU5TYWlDcTNDTUVjRkk0MFVW?=
 =?utf-8?B?YjV1eC9DOGlXajRxMG0rVGNRN0FnTWc4UEYybjNhWlk0NzhQZWNOenN5ckJa?=
 =?utf-8?B?c3gwTko2NkFZTkJTSGRNMTRLZ0F0VEdDUDRNY2JSYXZMNWd6b1JKbWczcnov?=
 =?utf-8?B?THJwaWtmd0hNdnVyQWRyU0hURUNLeXkxdTdUT09sZkVjNVU3SmM4UzlmS1NQ?=
 =?utf-8?B?YmFtU2w1YUdDWDc2ZngyWG5SbjQxSC9wR0lHMysxVUZtaFlIK0NHWmJsY0lD?=
 =?utf-8?B?bG9KbHhCakV4RlZRcnMxUVh4TThVWXZoOW0xQThzb0dNOSsvWk04WGpkcVFs?=
 =?utf-8?B?QXM1TDhaSGRGTmFkd3hST0N1UEhVK0lIR3VRbDRTL2hyRmZBeXFxcXhOeTdL?=
 =?utf-8?B?N2FNbVgwWkxXL3pUTmEvMUd3WDRid01rMWovcnRnWDZzaTJnVlZZcHl4SXl0?=
 =?utf-8?B?SlJocks1RDJ0bmx3cDZ4T29IeVFwUkNvb3Y3SThFR3c0aGZjOUZWRG91dWQ0?=
 =?utf-8?B?SnRHenBmZjdTQ2ZSUjJSdHZBLytKa2VyNlRZbnhILy9JYkxnWGQxd1ZXa21W?=
 =?utf-8?B?anJwTkswL3dSbHZzc1J5YzZBNVIzaytVODBmOFQ4RGNQMjBBYW1OOWpFQUE3?=
 =?utf-8?B?OVRvSkhycFNyeStnY2FXaGk1NFVTdm5pR0JOTEcrRzQrUEVxdFFqMUJRR05o?=
 =?utf-8?B?NEM5emFSQ21iWWR3L0owSURwKytyL1Q5cm1Fa2VwU0t1MzFzSkp4WVlPYmla?=
 =?utf-8?B?cjFrVy80NGQxazJnbTRLVGttc05tNEtKdGx0VVdZSFhlV1lLR1ZLSlZVZ1ll?=
 =?utf-8?B?aEpld2JJRmFncFAyMDVueGdzaGtmVE1iM1NGVkZkTmlHclRDZzJ2OGhpdlJ5?=
 =?utf-8?B?d1pKZ2M3d3VPNXZLK3pYR2RCWVZKS3dJVGxtUGZySVRsOGczSGN1am5GdXdE?=
 =?utf-8?B?NjhxY3grMGU1bEFNUExXZ0ZhcU92eVBZdUVQVGd6ZG9pdW1QRnV0NmU3M1VJ?=
 =?utf-8?B?ZFhqbWRkMGVLUkxEZHJJYzRkclFZS0RjSUN1UUlQWmFJWWNHbFdpckp0eTcr?=
 =?utf-8?B?azdVLzlQUzFOUTJscnRvdlhVYkNqOVJNMVM1SWhpOVRRNExrUHhKL0lCY0I2?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d63fe66-4bd8-4395-9f7c-08db7ef81c0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:40:29.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLxaeZYur/9DUjItknUW+BU/tEvK6J8ElKtjJZ1XwseuQu3gVjALM5JN+fF8qxViKPe1rQun7Mx1bMaELy6AIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:40:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12273

On 07.07.23 16:15, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> 
> Hi,
> 
> The following patch series enables swupdate in reproducible check CI,
> and also it include fixes for the reproducible build failures #68 and
> #69.
> 
> with this patch series the reproducible builds are getting passed in amd64
> and arm64 architectures considering following artifacts.
>  - vmlinux
>  - initrd
>  - rootfs tarball
>  - squashfs image
>  - swu file
> 
> armhf is not reproducible yet due to this issue #70 - WIP
> 
> filesystem images and disk partition tables are yet to add to the
> reproducible check - WIP.
> 
> v3 changes:
>  - fix indentation issue in squashfs.bbclass (dd241fbd)
>  - Use bookworm for reproducible checks
>  - Update isar refernce to bring reproducible fixes
> 
> v2 changes:
>  - Include swupdate feature in base image itself instead of separate
>    targets
>  - Added commit to fix file timestamps are not reproducible in squashfs
>    image and swu file.
> 
> venkata pyla (8):
>   .reproducible-check-ci.yml: Include swupdate artifacts in reproducible
>     check
>   .reproducible-check-ci.yml: Drop 'base' in job names
>   .reproducible-check-ci.yml: Include only files required for RB check
>   repro-tests.sh: Enable html output in diffoscope
>   squashfs.bbclass: Fix file timestamps are not reproducible in squashfs
>     image
>   swupdate.bbclass: Fix file timestamps are not reproducible in swu file
>   .reproducible-check-ci.yml: Enable reproudicble check on bookworm
>   kas-cip.yml: Update isar reference
> 
>  .reproducible-check-ci.yml | 37 +++++++++++++++++++++++++------------
>  classes/squashfs.bbclass   |  6 ++++++
>  classes/swupdate.bbclass   | 10 +++++++++-
>  kas-cip.yml                |  2 +-
>  scripts/repro-tests.sh     |  2 ++
>  5 files changed, 43 insertions(+), 14 deletions(-)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


