Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F01C25B7E
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:27:33 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.69])
 by mx.groups.io with SMTP id smtpd.web11.25400.1716910051350197188
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 08:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pLtrI6X9;
 spf=pass (domain: siemens.com, ip: 40.107.247.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qthu8QbCvrhPr3Qu5937q8ZEx7aWumPOmf0rfJI1Xb760yUrAvTfzDkoZpk5rQdhPzhTx7ex84nEd3/hI87nL9r+/CkqQV7KY8g138hJ8Mb5LiUPWEaajcuirMODLCfsUvIJxt1FnyM6mi1C//4ro3kCaIhzGwDAYT2/nN+NGUWzLpv8zUdQrpyK8nmEZBvpLbXBkSO2Iqz28SP6fXdtrpmjpC5J5UaQcmb4nDyCMjTShd8I3xSSMkI9IyeiG+Sq+MMm0+2SNGdCpX2SpOB+IiO4A8Jm7kq2cHAobEi/Jj9lDRvdsv5RN7Ae9zSA99WI/1oJ87JmIsw/VRUOaRLyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR28JBKmwPds2fviO7NG7UZRNNkcyAAHhGRn1D39iIM=;
 b=ckE+wOd9VUnAXNywd56JPHZqsTqLTtlfeTWvmXL683OiDs/XjeM8UEX4+xEHxsPPzI8H5Mm+bOIBkeOJPJf0LSugSfH1r1yQGXtEDhFrDxIuBRb85nHtwxJO3qxp3J3DTxXR8+ZY+tkY1FfSn34ZC/kVt2HrCRrHDTiZPyybRJ38sdCZWaokK6gq49ygYjywGAJeGOhBdXXrEFrciZYXaiK6FlmAp1Xrh46eHETwTwKyMyc8qcTA/yVY1t9hbd8z51D/dRJO9KrhAXPYpdAmf43CxEnBEQvFhZQQOWAXGxiPKGbU74txb4KRjNb8yLJiz4vkM4j+1qfFnkdjh6vAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR28JBKmwPds2fviO7NG7UZRNNkcyAAHhGRn1D39iIM=;
 b=pLtrI6X9KnjU6rsXZUoh9M2vnqs+zk0a/th/hPkwEXtlVwTy8qn8iN6XM0IXjQzT9RozuagRNK82fKsHFqjwZ/3Hq+a+ErWt4u0thp0tcmDFuzWEcufg8EY2L4JVpMWdNzQ/tW9MXdOABzAca313jiu+bNNDzD9QhknyHRDua8KVjc7MRSK6PL80xOB4egv/yElj1yoao3cjgfSGWEh3Ky/3VDV4C11B6v28KB62+eS6gGgmXhZi4V52Gsom7n9s7ugP4CfWSkabHubaF9xCkzYYUa8pC6sTE3rget/EAb9+dZTNSkcugaRc0KeB/AXdPmQgi/Hdx7dl9o9eE9kpIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:27:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:27:28 +0000
Message-ID: <3d582c71-7d7d-4d42-a95d-706dcd8d9ba5@siemens.com>
Date: Tue, 28 May 2024 17:27:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] Clean up security config
To: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 "Schroeder, Stefan" <stefan.ss.schroeder@siemens.com>
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
In-Reply-To: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:610:57::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: c10863df-2ce0-4a88-25ab-08dc7f2aaf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmZZTzlVTXd4RjdiOElTMWZuQm5BMDV3WUtUcmhpTlJEaVpWbTVTTEZXL3Jr?=
 =?utf-8?B?TWYxOXVtWE16L0lZaWptUmJmbkwraUU1enU0bjZtaVBYc1hyUUFHSzlRNzFu?=
 =?utf-8?B?ZW8zWDNHY2NDV1k0UUF1SVBwekhDWkdXQlE4R1VGdUI5T2pUYnpUOCtrazdG?=
 =?utf-8?B?R0xvQURVU1dJWVdPQ2tMZFNnYThKdE1zMDNZcXhzd2FPU2lFYUdaSG1JNFVa?=
 =?utf-8?B?SFhSYWtHSm9xSmFORGt0bU5DNmZLS3F5SnpsaFp2T0g5UHBLUU9NTjY0a3JW?=
 =?utf-8?B?VFlKWXhSRmlSYU1QbjJLeGdpSmdQc21rV0pDVVJ5Ynk3NEs2KzMyZmYyVlVZ?=
 =?utf-8?B?VVo3QUhrVjVrNW9ybE9scHVHRDRoSWw1RWNLbDErWjZTUGJ2U05EcEdTNTRT?=
 =?utf-8?B?L3pRd1RWekx5TFE0c1VFeEdBczZpb1lDMEdacHV5bk40WkJUVzZSUDBxV00x?=
 =?utf-8?B?ZC9WMS95VERZTllPa1I4cVMzdWhVRUlpbWpnMUNBdWFXTjU0aEVQTWVDZ3ZS?=
 =?utf-8?B?dFZBZmlYMmpNb09PVkllQ20xU2hkU2c5N0JHaU5SYVBHZGpPRHpZUHZybzJ1?=
 =?utf-8?B?MDk4OExpMFdNaEZ3TTZMR2h6aFlMNUR6ZzB3OUNXSk5vL1Vrb2xuZXd3bU02?=
 =?utf-8?B?a3ErZ05FODJXNGRlQ3VHaWIzaFlTWlU3SGdWRDNaUlJJMStMaGRhenMzMC9h?=
 =?utf-8?B?TUxsVnptUXp2cHp5RW16QkI3ZGdxQmdoQ3B4OGoyTXBvZDI3ZXJEMng3cklw?=
 =?utf-8?B?c280QUY0UEg2N0lnQlFPc1ZCU1hUU3Qwdm4rekZvSkZaQTFrKzQ5M2FRM3FL?=
 =?utf-8?B?dFRhWENHYzAvVS9veXpoSjlOREtlTUpwUklmK2pQYVRxZXV3WERnNTJOY1VW?=
 =?utf-8?B?TnkyYnY4emJ3RU9VZXB6NFNXV0ZSakRvdXl3aXdUOEtoV0p1ckF0OHBENVZv?=
 =?utf-8?B?b2NFalh3NE5YSlc4bGZ2WkxiVCtJby9CeUgxQXkybDIwK3BHdVBmRzNYeXQ0?=
 =?utf-8?B?V0wxN0gvWXpVNmIzZkdhNTU5S2Q0WTZzUSs2QjBNdjM2bm1sUEhyblY2TGd0?=
 =?utf-8?B?cnZCdmxmSU9OR3laeFNMaXZLY3VMVVZ1TkoycXFJTU1XVjkrU3U3WU9zUWN0?=
 =?utf-8?B?SE4zU0VuSllWaWNCNGtvaTJMWFVVeWk4UHZoaFNLSlVEMFhwZ1BIRjZKNWpk?=
 =?utf-8?B?d0JuVnowNWhPQkl3TXhJc2pXbHl0QXJ1QjFzcHFLZHJnbGEyUjNUcGdNM21t?=
 =?utf-8?B?bCs2RzlvdnNCSnFQV3d4bExtZFRaTGxyWVNGOURET3R5aUZoZEJURUYxK2ZF?=
 =?utf-8?B?UWhrYjZKK1FPeTZMUUFjbGhJMDRWQnRvSjVPTTdQaFFKbmo4NGY3Y3VnZzJ4?=
 =?utf-8?B?cytpSXJpTEV1ZDNpRUd3ZzBXTldRc1dVM0FxdENnMDR2d2xxTDQxT1hBRHls?=
 =?utf-8?B?Zms2VExqdUhXME1Rb1ZJaGk1MkNWcnVZdXRGSW0rZGtqZ3VxbGlSV2VseWlF?=
 =?utf-8?B?VEJVWEJLYU1MTEtaeThjNlZ1eTRIWk9PcElkL2ZUYWpJUHFSZFNvdmJEZUhB?=
 =?utf-8?B?SGJYbkJ6Q0hQVEZaUmVCNDYxSXZISTJpSlJRMDVZalhQTkZtOS9SZUxRc0lq?=
 =?utf-8?B?YUtLdkM0ZmVQMlBLRmpiME8wTWhLRkhxeVB3K1hVMmhwQVhwMUxXdE5oclRo?=
 =?utf-8?B?clI4dVY1RmEvVmpndGFzaThHMjlaaS9uZmR1S1llOXZlQlJ1eDFNbUlRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUZDK3Q3ZUxnTFozWm05ZW1DSFR4KzFqYktNMHVRWFR5OThWUWNTT3B2YmRR?=
 =?utf-8?B?ZlM0SkhJY2dMcEdkb2FtZllyMElrMUg1cGkzWGV5S01YTFJ6ZXhxUkFSZ2Vo?=
 =?utf-8?B?MXNwb1I3STlWYWo2b1Uxb1NKSVJWaUtkRjlSUVU1M3MwSGYwc3QyQUNEMUVK?=
 =?utf-8?B?NnEwT2tOSVFPVjZ1YU05OElpR1U2WjV6MW1jaEprNzhwMkphRDIzOStBTXp2?=
 =?utf-8?B?SHVvQnRXbERLSXYzcTQxL2NVMG9MVDlNbndUd1BBcVdpc2tCS2h4WGl3S3dR?=
 =?utf-8?B?SmczNi9Qb3dldE8rMjIyMFBqMkdQS0pwL1FZYy96MUx3MUJ6SmJiYk50NnJW?=
 =?utf-8?B?MGFUSTMrYStUT09vb1dNbEtoNTdFQVhST1dUQTJZSmcycnlrdGVoZ3h6OGdv?=
 =?utf-8?B?TFR1bkJ2RUVNUHdWaHJENjlRVjl3UDZ6UHhlTlBmMDNjVEswd3lDZjNMY0Zk?=
 =?utf-8?B?aDBNUzk4bDEweEoyRE00czRNNTVmUVEzWWdkNUZPT0Q1cWVGc3l1SkpWS2ly?=
 =?utf-8?B?bXhveFJxQVprOG9zZVlKL2EzUlNicFlQaVMwVWxBaGFjeVNqSEZ1eDZUcEsx?=
 =?utf-8?B?Ynk2VC8vMzRTTEQ5bm90MHB3eVc4dmN6bzhpY21WODA2R0dIZUo3L0VzeE12?=
 =?utf-8?B?Vi9pMmYwZWFyelJ0dERSeFpjOU9DSStBTm5TOXp1QlMwdE5PV0FkQm03Qmx6?=
 =?utf-8?B?YU1CY1RabE41WkZFYUhJTVFSbWhwakc5Z2VhYUtSNDlzNS9LU1l5RktYWkJP?=
 =?utf-8?B?ckkza2dQTWlFKzRNbitPdXJxZ3ExSnloWnVYY3U2U2dhTW1qai9qRjhtWEZF?=
 =?utf-8?B?Q1dCWmxBaUE3SHZUZnBZUmxhWnBPdVB5SC9nWFZCT0J1ODBHR1o3bFFUSHYz?=
 =?utf-8?B?eDlXa3pWNUd0VThFTFJzVkFVbHhlTXNiVnFuOStOeHY1d1BvSkc2aFg4a1g2?=
 =?utf-8?B?a0I0VmVEOGk4TUdtWktOZHZqY0NIUXN4ZTJRb2tYQWVnWjVYWGRMQ0Q4VlU4?=
 =?utf-8?B?OEJidjZCME9JK296MlF5UGVoSTN3TXptTzNQdmM1eWVjcllONUlmK3RYalhY?=
 =?utf-8?B?RHAzWEVIUlBLU0R2NTRsZDRXMUc0aXhodWtaNzdqNTFBRzk5OUVrWGJUK0M0?=
 =?utf-8?B?c3p5K0hnMEtXeHA4YTB3OGRvR0xudXBXM05sSWIrTGdURGpISXpGQVBnTUl2?=
 =?utf-8?B?VFlkY2NTWnZyMDBuZlhMQzYxcDA1c05hbWtFbFc2eXZnbHpJaVVoU21ldjEy?=
 =?utf-8?B?b05wc1VsaUl0blFBZC9VaUVnT3lFRHhyZE1EUExkdVFlT09QNWxwU0JDUUdj?=
 =?utf-8?B?Um5TT3VSUGd5QlBKWEROaE1jUVNtSzlKbnRwQSszOUtURThFYlpnMTZsTzRL?=
 =?utf-8?B?SUZ4RHRmRWFDOVluQmdmdlpReS9kZTI5UW5TRFBReUJMcXhSOERpaE53dFRR?=
 =?utf-8?B?Y01iRG9xd3ROMEsrempkbXc3SC9kRzB3cXA5VGk4bFFSUXc2MzIzNG9PcTN5?=
 =?utf-8?B?SEdUNXV4QTdaZVd1MzlibmEwczRsOVcvVUFxS2l6OFdLaHhEL0FJdTVnUXZE?=
 =?utf-8?B?Y1J2VmY0bWNOS1hLZ3JNNS9iaVJRUE8xQW9QUW0zelBUcmY4VWZESEdlbm9w?=
 =?utf-8?B?QithbW9BSlF6VVJNM1NYMVdjK2x0VkY5clhrakg4VlczWEZNOFFSR1ltdkJk?=
 =?utf-8?B?MCtEd0pZYU1taG9xcDYyOVlZb0ZpcmUrelo1cFJpL2lVRUNMQ21oQXpFdzZy?=
 =?utf-8?B?TGtNbklXcEFhRnU4Q0VtOGZleWkvd01nRXBsdWd5WVFqMEMrZnY2SnRDLzdQ?=
 =?utf-8?B?QjI5bnFLa0hxUW9IV1JQdDN6QmRlcjRzakpuQXczT1VMU3JtaENXeWZPSGRX?=
 =?utf-8?B?UEM1U2dDQXUxK0VFMU9UWVV2Tlo5RnBPdDB1a200RkE5bEJOeVFtUUdqRlcw?=
 =?utf-8?B?dDY5bDBLOVFSUk9tM2FYaENZd1RjNkdMZDdUVHJBMzVzclNQdGVWYk9tNnZs?=
 =?utf-8?B?anEvVCtXSkRXeHplSElNVURZWHBvam5ua3lkSGJrbTJVMDJlNUR4UW54UHgz?=
 =?utf-8?B?b2p0cXV0T2RKNjdlTGo5djdmQmhXR3piVWFFSjVlMXFxUHNmWnlETTNUbWM3?=
 =?utf-8?B?eDVUdUprMFdPbkg1YTJUdXVCSEtxVDJKQUtjeTVsMDdxbE5EUUhyb3Z6Tis2?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10863df-2ce0-4a88-25ab-08dc7f2aaf16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:27:28.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3C/pHr4W2vIIdUVsYti6PvnoPda8cI96RGmVhUb6dSBFwmulP5MAIipiA7CYZT6rNluhLBV1FjHjkQZrj3PLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 15:27:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15970

On 28.05.24 16:42, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Move security related recipes to the folder recipes-security.
> Use systemd as the fail2ban backend.
> Remove the tpm2-abrmd
> 
> Quirin Gylstorff (3):
>   Move security-customizations to recipes-security
>   Add fail2ban-config
>   Remove tpm2-abrmd
> 
>  .../images/cip-core-image-security.bb         |  4 +---
>  .../fail2ban-config/fail2ban-config.bb        | 23 +++++++++++++++++++
>  .../files/systemd-defaults.conf               | 11 +++++++++
>  .../security-customizations/files/postinst    |  0
>  .../files/ssh-pam-remote.conf                 |  0
>  .../files/ssh-remote-session-term.conf        |  0
>  .../security-customizations.bb                |  0
>  7 files changed, 35 insertions(+), 3 deletions(-)
>  create mode 100644 recipes-security/fail2ban-config/fail2ban-config.bb
>  create mode 100644 recipes-security/fail2ban-config/files/systemd-defaults.conf
>  rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
>  rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)
> 

Please have a look from the security WG perspective. Patch 2 and 3
apparently address the open issues, regressions compared to 1.3 but also
longer pending problems. Would be great to have them in upcoming 1.4
release. Further discussions and cleanups can be done later, without a
hurry.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


