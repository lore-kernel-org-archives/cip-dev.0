Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F32C77B7D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 17:07:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web10.56044.1684343263684993465
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 10:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FfZx3R5N;
 spf=pass (domain: siemens.com, ip: 40.107.20.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPNUK6l5OYPDQFsI9sNyf6Nl7bjsTzX7v8Nm9QVumZ3cM5TkgWSMnKvaT3v03zkJCJNoQwJudFfckDXpuNhnyeKo5IsSaUmVSS6o4Eq1NhUNaI75+9PjUcq9acXhXNVk666Nx9Y+oTCBhxHTwZNGWDggzBKe3exU5GY2NzuA59DrsJtHzVx+j1T8jwgqVC82gIAJ4HwweESYk8aZz3uizS31DzLUoZ91kPKJm9Zj1fXqqOEmghjRp0bmh4BTsFdN1mg8vQwJTsMXvAs76xK1+HcjapZQ0FyfGWdUu9e3AJYnbGXXoTFkYwbS1OxICjDriZnSXEUX76HT9s7Aa83U3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EW2FQfieEyJS/ZreZM3YY683zGE5neW92Dx/MCspPY=;
 b=fc1gyU2eh56qik7dJbZBQPj5GCsZhMbJI2blCFcBUXQCSdRG7Kcd6ZxvrHjEEYrxfRpfIdvINCm/JbKaSyO9SOJIJKRUflyCTrIzeTRqxGVGJZfjBD96R4ZZ2MWxpgBEyxgDTLB/bIs6dq4j/kPzbxbnurXg75PRdAjCVrjxTKtGpQ48WlqZUUbrZ7ZbOiBq9Ne727HJyKVtzvXZj/aPxaqkcVaNb8pDCoOmQILj7V0LA4/JT8H/MLN9npoTLPr1WE53+CC02jrFWfeQZRNYOnPR4/goUpN6SWFBS1qsxTWYm67RtfgPAY11uQISrRfmikjtK/wgDA/o7ngYEMMYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EW2FQfieEyJS/ZreZM3YY683zGE5neW92Dx/MCspPY=;
 b=FfZx3R5NwRRFBaIShF2WGd2nz4RqPvm8EN7F/qA0V+myb5znHMwX3pXyHqgJS8YplP3qdDYF9bknr6s6+yDlCMMVU2PNImwonDorouqH6K4uXp6rNUyJ3h3dEKn3bLM/3bbUhbZr0a3pehoOYaD66HigHAS4oQnaloCNudQNv8GyQeNlqIatIcZD8EgpKXrtgf39x4stI1GuWzWA+AMPuch6VKK88nwroXJFh4RENkClM7IiPbzvUm1rdJzHkSxTfADX+5r6iEzQ62ZzDgn2KIY2c1+MpooULT7im/YmD5TqWqpQGFlCHPkGbDtinmR9dQsId4RLVBGQu5QkiEuxzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB7759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 17:07:41 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::181e:c26e:d585:c80f]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::181e:c26e:d585:c80f%3]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 17:07:41 +0000
Message-ID: <08f9b5e5-e68d-7105-6e15-c742abb0c563@siemens.com>
Date: Wed, 17 May 2023 19:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: gitlab oddities again
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: fa750403-8a08-4a01-dad8-08db56f938cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5r7VMgDTDx6sY3upob2GwcHZznAwwHDmYWp1zQW8U0f5NQEVYD58+KGuCDJQxqbVeLs+wq4LJRnvzzdfngFc8wBv4Q20gVdhantT8FeVoP+KxwGwKB9T/YROPx3uf4SAqcMwlwEbUfRUqLQ8gf22tVqS1TaEGTM8nT9adYRpZrFb8nfes/7SbIAyLpLDB4qt2Mp41Xx4gFZfQ5T4mnlXws/DO3mCWxm8uZTlPFmlXN0gW4m8YILf5I//MW/M1SaJePXYgtQYuuuxz5OFHw5clFZbpPD7u5AxURe+FPFfvTUQ9tJRQyK4DBwaKmww0KU6ZB7qRpSj8aQlAZkr65OulYV+k95hEv3nV7xmBbrRTqcLbZBjrP7WIXFJWm5qn0wvBnDcbXHPglrFivMlERzdnVvX0YgEAUoY03KvIyhADRxJ8JZ31hJacAVvuB6puzYSUmPDtKyHCXNjnOmWvLsXhFggTfM2iz1eLlX4amFuVFT7wjs0hICisRR1RwIhi5FsL3j8emj7rHeoUnTigeAQszpEEdy448jnClsfuas+lFn6Jlt6GqoRmYh8qB5y4ofTiiGNEjyhcitkj/oLmP9zhaPEg4nx6fcYVnY/jemkiYD9N88LC9YCKVFfDvwyHLjRJEsjyBEphNrQSOx/ebvTzBGLcYlky7q9cm0FbuCrPm0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(31686004)(4326008)(66476007)(6916009)(478600001)(66946007)(66556008)(316002)(6486002)(31696002)(86362001)(36756003)(6666004)(83380400001)(2616005)(6506007)(6512007)(3480700007)(26005)(186003)(7116003)(44832011)(5660300002)(8936002)(41300700001)(8676002)(2906002)(4744005)(38100700002)(82960400001)(133083001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1lucFRSVUlHblowNy9hT3lpRlNFOVNXaEZJS1NrVEt0TGcwOTYyK09tc3I2?=
 =?utf-8?B?L3hubEpaUkg3NXBseDlPR1NaZGloSW05NGN0R2hQemo2T1NFWEx5MG9HUEdv?=
 =?utf-8?B?MEw1MGlwNWxhcmh6dThGRWZSbEtWWjQ5a085ZXNPVGxMblZsOXpOa09QUlM5?=
 =?utf-8?B?SHRJR3d3amZTQ3YwNFFLaThrNERaYlZPcWlUMjB3MHY2Q2ZVTzlXb1dHRE1Y?=
 =?utf-8?B?ME1rS1Q4S3MvMnB6cUk2V3VQZ29aZWJIOHN4eXNuQmFwTm5ZKzdacEg3Y0pu?=
 =?utf-8?B?TEs3NENhcFZ3czJJNHNNeEE4WG5RcXg3aTQ0TmJuVFZlcE11K3BpYWtOWmZL?=
 =?utf-8?B?aU55STVBUTIyM2JQbFE3V3pQOVlmTEIwUDNpZFRCbWJXNlJVeGxSUmhBQlBO?=
 =?utf-8?B?N3pwY2huVUtQVzY2bDRMNG05Mk5Hb09BVXJlNkprUUhYN3NlYlZRVVc3K0VX?=
 =?utf-8?B?dm12Q0lVeU14NDRkSGJVVEw0QTI1TmtaQTVoNzR2RGFVMXlOUUVrTHg4ckp3?=
 =?utf-8?B?U080cG9vZ1pDbGZzcU1XZGxLZE9tN3B2Ynl4SWVKMkNaNzlFblNJZ1R5QlZI?=
 =?utf-8?B?RFhkTC93UG1oUzlaVDBzclUrd2wzNlNpS2pQeU1HemExTVpXdWNnbDR4VHIr?=
 =?utf-8?B?S28xVVRNUm96bktDWDkyZmdpQlhLTjh1Vmlnd3gzWExXUE1qMUlFYTlzV09q?=
 =?utf-8?B?eGdabkNxUzB5MkhxQzI5YXpjbC8xd25sa2dKcXBJdnA3SmFEMDFkclMwbzky?=
 =?utf-8?B?aWpUTlVlWnpnVTFtU3lUNUtublVQRkJCeG0vRy82blIrL2s4NEZ0M05kT0tl?=
 =?utf-8?B?eW9YcURUTUxPR3N1anRKL2c1TXgrUG5JUzVnRGhMbFpJY2RDTTN5QWVJaitN?=
 =?utf-8?B?TWVGRU9nTXRvT1Q3ZFZSN0h1M2RtTjcyU1pmUkZHRE1OMGQybUdFRmtsOGov?=
 =?utf-8?B?aVhqQWpPUXN0SmZHODlsYmFzbUNYY3NIK0R0b1FiVnBySExIWHRoSWJzVTMw?=
 =?utf-8?B?cnN6aTZoOEhHeWUwaldXanRWZ3BIamlQeHZEVS80c2JFMzlFWDZhRU5iNnRl?=
 =?utf-8?B?bDFaMXpRNGJOb3ZhcU0vSGRSVWRLcU5JT2JLMi80Z0dyZjFvbjFxbGNnYlJy?=
 =?utf-8?B?MFBSd2hVVmRhaExkYUxON1FaS2QzZjRtdlFLVDU4azlMTUdXaVl2cGpGd0Ir?=
 =?utf-8?B?T3hEai9iZFp4SGZOUk9RTFBjeVNRMUhKM3poVStYU3JoYmUyOUtMcXM0bnlu?=
 =?utf-8?B?VW01WHFhVWNPdHJDNkpSbjBjU3o2L0ZwODgxc29naHFVL3NUdEhFSHlGNHVi?=
 =?utf-8?B?a2QwZ3lpYngvbitZRC9pT051bUhMRzYvRFptMHRITU0wUXJxcXhEVTRQVWdq?=
 =?utf-8?B?QlAydzI3YURnRnBmQlBBY3JqZGFoYW1hbDRzOVNEbnFrQTRLdm11WTlWQXFF?=
 =?utf-8?B?RndRNDI3UC9nckV5YSs3SnBkL0QyYnZPNEtOVGtmbGdSUzBFekF2M0kvSlRQ?=
 =?utf-8?B?aGtndTYrU3JXWlVNZ3Z1SDJJTlNsRENWV3NLczJac0FHbURjNHpOQlZDbHgw?=
 =?utf-8?B?SVpVNHluWHBDMFRRWDhNZHdienkwSnEvUTB1cjdCMktYMlNRQkxJRWJDWlJ1?=
 =?utf-8?B?MERydnk5SFVwVjJ0Zk9TbmFtaFRyeE5zOXdnSmZITjZvRkpIYUZsZFJFVWVV?=
 =?utf-8?B?dHVoMzNRQ29VS0ZqT1hXYjMxeDFxcHoyYnJqN1Q0N3N1eTJod3VOL2twTWxC?=
 =?utf-8?B?QVYvZEd3Z1NiZStaS1BtcC9qVWZxSldFYmk2aytwS2E2cU40dGtVTGFZWTZs?=
 =?utf-8?B?MWNWWmFNSUlmMmttZ3ZVS1Z5YzVhMHF4WVBWdEVPK0NlWDZham1YQUJQQ0xD?=
 =?utf-8?B?a3VMbGppTGZldGwxeG1WTmFkVWRrVFJUWC9Rd3RjQ1FndmJoSjJlVFhuU1RK?=
 =?utf-8?B?RzNZTGZWSy9RQ2FMbWZyNUU0NmlwSkF6VGRBUFRFczlvOFFlc25pSk5IQXZm?=
 =?utf-8?B?WEk4VDUyVnJveUJpSnpjUUtiTGMycEZ5SzlTSHEwQ3d5UURkV3duaFFyTlVW?=
 =?utf-8?B?RDFCZmJnNkkrK0d6bEZvNnZ3ZUR6K3RRWmIvN2liWTNBZnc5dE9wL0VzZ3hn?=
 =?utf-8?B?Q1pENTZNMStkTEdrL2N3dHhLem5VTUpzZE5mRWFuU2hsR29BemhkcGd3MDAy?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa750403-8a08-4a01-dad8-08db56f938cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:07:40.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSQrebOYkouguDke1rcUMJQjC3T/I75kDvIPr1RalX3Rmr2e8GoNAEHBY8wM6tklG+38cO/Q9nrvcI7eTMMEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 17:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11508

Hi Chris,

remote:    Your push has been rejected, because this repository has exceeded
remote:     its size limit of 0 Bytes by 140 MB. Please contact your GitLab
remote:                   administrator for more information.

Are you our admin? :D But you talked to gitlab last time, right?

Is anyone else seeing that on pushes? The issue is currently harmless as 
pushing still works. But there might be more behind it.

Jan

