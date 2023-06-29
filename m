Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D657EB64D9
	for <webhook@archiver.kernel.org>; Thu, 29 Jun 2023 05:15:33 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.43])
 by mx.groups.io with SMTP id smtpd.web11.2183.1688015727307920523
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jun 2023 22:15:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JYz9rEOW;
 spf=pass (domain: siemens.com, ip: 40.107.104.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJxzZyadVAeBXFgVRX7QGFG2dBbu4RlrB3IcXTFa8mkWMrn8RqekFb0/mnSiCndQRqhIT5uPTG6V8scvMDohtd7AIc74XI9MjyTp+endOf1kLI4cd+YCKoV9NhNULTlDu1YoFfFU10DXMGVAiBdNNS7QZAdjlEC3wLyjvZpcLBrMejG4b881HaZNVx/RzE4iOkPEt3hyPJouhOKvYAMgtO0J4nxxsfmBeYMUBcwW/KtGA6y+/eNdXHO7gofI1v9s4WHSi+AYfaa6vO1OUZmG11JNvh8c78VG1cTkBaddPN3lLG6KY1M5471d9jThPcD+p6hXnk62ZlLn5/wEb4jjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZAE5QR+xfUtSGAcQukYd2WnrVJkRe3map/HpBMIPJg=;
 b=JTp4TzqDPUnWynA1ybVH7zJkIX4VVz5gaRGDklm/ZDzB9NB11gAmnVIj0EKAndkT5XjcT+qgZ+Ax95nVMmWQzh0JdMpTJeN5TgQykW6uxitT26X37/5SRBgj5NZ2uV5TJ11YiBjX7cVBlp1lZU79nrXwC1VJ4zlIbMZvKiUG0g1ihnHKdAlO/FWp6tAcB0LlgtO8GXygTwGDDTG2vZS/qQyFLJG1tE3NU2w8NUldvV6tp4Bkcrj43WO/PSe11/W6O3uBGARlzXTB1pYP6QwM9ZdweBKnJSvmaURkg126sTlCfwyLrLMNHRgX7lqVUnWM5j+78stAp20HSRyZMqIfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZAE5QR+xfUtSGAcQukYd2WnrVJkRe3map/HpBMIPJg=;
 b=JYz9rEOWH5uT3cT5qw3KN+HRkc8sb3T+8p62w3+TA/zQSX7WHprt2eI3Ju2vWyLB5ROWL/9+wGSAYWzT2G7/HnYMrytV5qIpuBncVx2J8RYmEWhv1BS4DrkWdKHfXeRQNdPwfnAsWA7c7Q/DOBXgSnJk+lZHC6aW0X4mbz8HhpO/zKDIKrBPnLhmqtr0rBI/jyIqgnp572l/mEOdS+15RB8r8+HAgRPNFHa5/qwcXjgGS8HoIcO6B5TU3SxY6WU9rky33S2IqgM13dovyR3Go2/r3WfeyDe9nvjfF4PqXXbLssjm5VkhmGcLBxX8oS+b0xOtpWo7IKIEl5qGsNIHOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 05:15:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 05:15:24 +0000
Message-ID: <c1695b8a-7aa0-38af-26c1-5582c06914dc@siemens.com>
Date: Thu, 29 Jun 2023 07:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [Reminder] no CIP IRC today
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3242:EE_
X-MS-Office365-Filtering-Correlation-Id: 680c339d-fe49-4bf6-e7df-08db785fd825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xc8RltxD2O+lZtLFTI9MMNHzEepOrn6UNRqRzveBQbiBWR+MQELIqC4fROp2ZUTEhr69hJC1HQhfwbXxbGbWAPuk4LpU0SuX29droNErubByUVVKcfhOAAGBKDuXMIk3d0kUubPF84yIL43lyu3jeikpuYFty8omV9sbqUWsmRKTzgtYWy4z4wZClQXcYuk4SSNLkhdpZELCMITHJhdYebGiv/ek7QjeKz56hRItRs89HChwK88ijgCNuFQEkad3n9k42KMhNPVNIJxJGMvooN1C/lJSTqclMeVPydt+uhJaZIhtdOVuu9UEyNK5qyV7VhXDAbVlEEurPMoxnkqpjuiODe1z6qnbJmi9n4JhRVYjV+ZaYrEuDrQMIT2PqT+LzJU/+fNa/J8Rib2r7ahgU9PQ1cE2Zau623lXgZRIrIPZG0YuP0HJbEXPmER4arApIUXf4KYKSmF/hoT46N+OcAJlLry0VigPjQnoJDXbvWUv8YaQzO/MEukLpJMJA6lOPhQ5E8Uop32/WmQPP9FTTfc5zFwvVfTFGyJp/+IWdUqt0PwdayVkG5F/auxRsvDr8eU751oYblTHjRwwJC16yq7b2v13Il+9BENboOc1dfTq78s7nOpx6KJslLEE6MXxzLXC0UeWnXM/jqYNe34tgg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(31686004)(6512007)(36756003)(558084003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(31696002)(6916009)(66476007)(8936002)(8676002)(316002)(66946007)(66556008)(82960400001)(478600001)(6486002)(6506007)(2906002)(26005)(186003)(83380400001)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bEVZN2V6WHJYVUlDLzU5MkJScmxaUG9ZcXA1bnpic2Z0Wnd6QUtPckJodk1T?=
 =?utf-8?B?ODl0T2lMZktGenYzYmR2ZkJCUXI1djMvaGIzTmJNSDNLdUx0bXp0NFAvdVlC?=
 =?utf-8?B?QTNjQ3B2YXpCc2pRcWgwdCsvTFdsTUF2Z29qSVBQMXhVS0xaYkZZZGZuQXpH?=
 =?utf-8?B?dWtUT2dXUkhITWx3VTR0RmpxV2g5R1FCbkVHNDcrZitxYjZ2b1RyUHV3NVFl?=
 =?utf-8?B?QXdCWjEzTFlxYmorRFEzMU9XTDJaVUlCMFFMc3dqQTJlOVhYb0VrMFdwOGNK?=
 =?utf-8?B?ZzAwSVAvdUpMNVA0M2dmNFJXaFBSLytZSDJ1ankyVTNjT1docCtOWk1hTzJo?=
 =?utf-8?B?NTRkMzZLY203MGJ1UjRSQ0R4RlJuM3h0SGYvVG8vRXNwZVhCT0lzNW8vZnQz?=
 =?utf-8?B?d3BDZ3pIWjdQaENTMk1DbTZCY0FkYmRZanY1amxwUmFGeHd5ZUpHc3h2eU9L?=
 =?utf-8?B?RlV4T2pEQ2czUjNMNjZKdnNsdTdGenYvSnlVOWc0eTB0cEdlWXNhZVpoMDRm?=
 =?utf-8?B?bjcvdTdsaHRmZ242M0tZaTkwRHBtRW9kWXZTRWdIdDZLZ200MFlrRVJ3Qndv?=
 =?utf-8?B?YWw2bVRIK0RNT3EzYndUa2JnbnpkUS9pL0tRL0duaEpwc052Yis0OTdNZ1dV?=
 =?utf-8?B?YjE5R0dROEpGMTBxU3NhSDZpTHFYUzNrbFJObHhWK2x4dHVnNElIOXptdU5I?=
 =?utf-8?B?Z3FRRVA3M1I1aUVYTzRnMWQ0NXpVM1FVcExvSjhScTV0U2xnZm9hZjNWYldv?=
 =?utf-8?B?UWR6eWltbmk2YUQ5N3ZGWTA3Q0hIcDgxbnhHT2MwR3ZseHFPTmdjU2NWQ2Y4?=
 =?utf-8?B?MHFjYlg5dUJYa1FHOGVLZitvazhwUWJkdmlFZXpUWFhxRmg5L0tPQnpmM0FL?=
 =?utf-8?B?UnM1TU9OWXlEMVAvVjdjcE5oTzljTFB0eUQxK0xNY1EzNzg3Y1MwcjR1OHB5?=
 =?utf-8?B?emNwVmwwZnNEUXE4UmhQNDJ6NTZiWTF6TDVzMDgwajBMY1BQejgybXVxMTJn?=
 =?utf-8?B?WXQxZXA5M3FSOG9MRkJlQzcwTDRiU2drOTNueXZRd3FOZzRlamNuTjhlci95?=
 =?utf-8?B?M0FBc1B1TXFtMHZBaXY1WnZVZXJYZmtDM3ZtSHJMYldSMVdBOVhTYnpvc051?=
 =?utf-8?B?WS9SeEVmclVkbnBTdFpGM2lrNkRUZHUyWGZwOWFoakRZODh0NWZNTFR1MXov?=
 =?utf-8?B?d3NIZWhZUnFOV09JV3lyTjJua2hzT2MzbXRwK2R3YUQ5WHVQQmdXQnF3Qjc3?=
 =?utf-8?B?QjduTFduVENqaTZMWHgvZmdhZnc3aDlDUGwzZ0dqOTg1S3hSM3VYb0FSeThP?=
 =?utf-8?B?azJwVmt0YVZNUEU1cWQ0b2x5YTI5czNMSE54VWhwekM0RHErMExJY29RNGFz?=
 =?utf-8?B?YUgxYXYzSGRRYURRZ1l2MExrejlOZlMvSC9PaGh4TXUzUDlWcnkrZkZqSTJK?=
 =?utf-8?B?NFVrekxuRjlDbzFqRUVqRWNmL0M2MWp2NU85VnNyZFF4OHZsOXpycnVrQ0hW?=
 =?utf-8?B?NTBwSGh3dHk3Tjl2T1J3TEpZemxLcHdaTnFxK01qSTVETDB3Y1F1WFdxTFpE?=
 =?utf-8?B?MU9uOFIyQnBRZGl5b0RyREp6S3gyZ2ExT0lmTXpXODU5YlNqVnFTbm9uSmp6?=
 =?utf-8?B?VCs3NmY0SVBnTytaSVd0VkNBVzNoNnlCSnRHMEIxNTFWRkRZNFRBM05EUEpo?=
 =?utf-8?B?eUVlcWR1S2tyWkNIR2pzTnhBLzJoVC8xTUs1NWVrRlBKQnVWUUZnMG1zcEVS?=
 =?utf-8?B?VzN2Y1JRN2kvQUtBU0VIUW5UMXd1NXcvNDlqTkc5K3hJekRLMTB6RGY0d0JY?=
 =?utf-8?B?a1dEbnhJWU9uME5mTmdZSWoxQnlGZnRrVE1WRU1icXNWRTNvYkpTVXBhNFBW?=
 =?utf-8?B?U3d4Y1ZtdFVXVVduQUFQRmZiaWJHZS9zR0dQZUd6NHRnTGZCK25lVGZtb0gy?=
 =?utf-8?B?V0VzTDNlN3I1QkdIbkpYY1VCOWcxblE4ZVpBSDdoelJwTlYrSnMzbVdPcThC?=
 =?utf-8?B?eG4wMWZFbTVBWjdlVjJDNG53KzdZN3ljR2E2ejlQNUtkZ3cwbWN5Zk1TRVoy?=
 =?utf-8?B?ckFkeW9IdlVUZUdXa2ZlY08yN3VsZDRRc0NvejBCaFhOZktWT053Q09iWnNU?=
 =?utf-8?Q?Pb63wYhcmblhoVCBPwxObY7jG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680c339d-fe49-4bf6-e7df-08db785fd825
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:15:24.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeyMrrY1mVUXufqeLa8DC/RTJMXvY45Vo95SuCqitxlePGXKUoyBaEp6hvztCUkqB0cJajltVPvkzwPMw3H3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3242
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jun 2023 05:15:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12161

Hi all,

just a short reminder that we DON'T have an IRC meet-up today but that
those of us attending EOSS here in Prague rather plan to meet for lunch
around 13:00 at the CIP booth.

Jan

