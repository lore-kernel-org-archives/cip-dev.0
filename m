Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2FC54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 06:24:02 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.61])
 by mx.groups.io with SMTP id smtpd.web11.16030.1709619825240008410
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 22:23:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zSC6Kfat;
 spf=pass (domain: siemens.com, ip: 40.107.249.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh1iJi+fMPZWf2Q7BssFKQFdh1W+NCPfVgyCpdYJ0XX9VNzPiUvmWqm+c9eE0/hoDn2c78rxpuP9zwMzEjejuEE49ZjkI0LSe0/opTF/0prAW39LkiAMf2jL1iMranwiKa1ZZCOqBnXmQwGRiw5N9/TFOB4NBEFr8MDNsIurDZn6w7ItHkn+gRVvu0sokIvLtXFoUd/yskp0AtdOT8i9vdlXW1yaHzGToxhDOHoYNTeuGuCXgLqaRmUuEAPvtsmcGTo249LXgTQSrvPFgvQAwSuLYnzZiFLm0Pnz8XNQmZc+IfA90yHlwSUGaUBS9vmGfI+RiJZkR0Azdf3c4zBZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4XoIXPDb2gc8Ir6JZJniXW43eQXE1uGUMJSwhmuFEk=;
 b=Gip8ed3abAAjFFuAzmUY7KPimm9U3nfpDekpiKpEU3LLzZJBXHaIYkZDR4N3yj7TKjm2mb61FKdZy0U2THQ8P6HibAhysQ3Wa7scdqzj+WU4xmRl8yYxINRPluiXkk46smjoRH/0DAurLp3wfpYCEdSFGm6xRLrdegTfZxpQnLtWu9N/Jsy6Gfj6V+3OMD/N7lYTzT5MispaA1fX4MbZ0cBDQeBaj+S6c1NsDHN7XS211YNlg6bLBdlL/tcqTYtyQqS/u2ZINIejMH/DPIVV+fZGobhpd7vqDtErKhAtqhSEviMDv4b4G84DwNOAqEeo0g6be9/1mSl1OrSkkTv/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4XoIXPDb2gc8Ir6JZJniXW43eQXE1uGUMJSwhmuFEk=;
 b=zSC6Kfat8kh8tEmaa746O+tVB3ZEq42ICmIwizkqkpcMGLS/vkjtzsCFkEJ0fL8QFzwj78EQqN5T3xbXHT+/vfvz97Kx2dVVgpSNCWnp3UBjqwXcMdjBteUsCoL1XRNJSXCsZ66HCt15YAFBDaxG3x0aeTLg8KtKpYbt13Ijp3Qzp7rIc9K0iFcXbDQjkv3Xdjs+IeiTPSYwZCYMuZh0m9YiAq07ECotJr3N4m0ooI8u07L/x0//ETffE5nmKMftD9YBOmHPh/ZiPJ8y1zRYyDkGL/5dmdKbsNNK6xt2RfhbiII3MI/5W9IxOE2zqluYt8hv1aMy6CYW8RnKtQHbSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB8021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:23:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:23:42 +0000
Message-ID: <1f7f05c8-131b-4a6c-826d-30f353d5c92e@siemens.com>
Date: Tue, 5 Mar 2024 07:23:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Make swupdate signing more
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: fef5aa00-5505-481e-cb9a-08dc3cdccd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	83vtPl8tzePfKRt7uoVS76m+w+5lyHsCymGrD316tOmHWs5N+hNtORRivv/U4zICPGfqqzwf2pPiKX+tG6bsuOkg9/VTfW1zCRnbKBiXvoQAqQeRJgR19lD+cxtswb+elt3ELWxKex1znKFq6yU8jE527aruvER8RZcqAwvk7VIYGl/y4GWidN3HLdr+ZIosccIASBwspb8H2KSbOZDcODQV+e7nKHYXSrT9rKmvMVsUUEiTOGc8t++A6Jdu56ELF7YVYSVybrXFePFCy1nzGIChajhokeOWeBxm/ljO8F/bMmJc+vWGkTj3xzoypbvH0Zt9G0cfkNMUsq7gCFE2SBu1oEopk+pFI7rYE4Gf7BZ+vKerzaI0DJ0Qd39kuxLL6IQ0m4NRly/WNWFHSISjmSYXRZHZRWeL5GmlpwNY/bGHOu8+yH+qcKDBICTKkdoeRzGkpZyvFJLaQOBB74skOadEUPvusY+UTHP/nYacXJMLryfZlEZoF+aXpOUuKxpnQX6RP71OdsjLg2jb4M9P27AnQ5+Nzbik6knJotxdX7kGV4uXbrDPC/bX5eupl5hV/HggWcSn5t2CxVUzJj7v1DToFvjVyo2PyZQYjJ1gma9NfKdRyDmaTYaJoBxjgb6rqGR03x1IBwZvuDYK1Nnd/SSz2T1CVnyhvrteaNP+hK0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEJQYjV6cHJUZHJLT2lScjhDbTZiODBZM09TbkhwMGRWR3l1dXpjd1J1aGZQ?=
 =?utf-8?B?bDZlRmpsSTRGWEFBUENTT0YzRlJGZUFwS2hSakhraUxuRDdzM3FMNFZFQ2lP?=
 =?utf-8?B?alE2Ym8zM0d3aDZqQTFHYzRFdnpCTGVLZVlEeTRRSWgrdm1mY0UwdTNhNHlq?=
 =?utf-8?B?RHh0dlNSVm9HTHUvbHpBRUxMUmtkT3N6NXJtazZzWEtLMXlUTzZpZWgrT1VI?=
 =?utf-8?B?NlA1QkU2Qy9TS1I5Tm1XRkp4ZHcxTGtrdDNTMnpkUzhIL050bTdGMHhDODhH?=
 =?utf-8?B?cHNVek0vcGpOcnFnVXR0WW9Tbm5Ec3NnZVFaOWpsaGRFMUpUVENBa2xUM05G?=
 =?utf-8?B?YTl5MUJVNWNkZFBwVEM2bHRrY0drZWN6YlJKZjJFU2liYnlicFdLRG55ajlO?=
 =?utf-8?B?Tit5eTB1elI5MTlRUGFaYUxZVGR0ZlhOKzZMUzBtUFl4K0pkTjgzNzN1aUZB?=
 =?utf-8?B?ZUxKK1hLY29RVy82N2QyMHhuUDdpS2tCYzRxaTNGWWNkbklTOU1VZ2xUQWtN?=
 =?utf-8?B?SnZTem9ia1Rrc2x2OTlBUVlNSS9tUE9RWTZZN28xVGhTV25adjRKWFVXdStR?=
 =?utf-8?B?a0Nheis4T0NaL21SUFdHN05WbkdweUlQcnhCaUluUmJtN0w1bTdzQmZaalov?=
 =?utf-8?B?czNJS3JMdi9vODVMSTJoTll1U1RWeFpIWWRDN1ZWeVdCQURKTDdnUCtvT04z?=
 =?utf-8?B?Y2VWNnZnMjEzQUROZVBUYjJxblIrbGZzWDY4aFk5WDNpbElDUWZ5UnJFU2VR?=
 =?utf-8?B?RC93U0lybzlkQzQveTBIbkIxNjM1U3J3eDRBV0pyMjdJdXZTL3Y3QVR6ZGZn?=
 =?utf-8?B?M1I4TElXMGREcVRuMC9HTW5XTnEwdUNNV0VUbGhaazVTSUFIeFlxMGFBSnUr?=
 =?utf-8?B?blRueENmWExNaHpkQjFTRGlOaU5UbU1JUUJsRERtcUR2OWhsNnVOeGNBTUho?=
 =?utf-8?B?NjRYdmx6MGRtdlY4cXBJSy9HSlRnckgzOG00ZEYxb2M2TUs5NWdDTzFyTkM2?=
 =?utf-8?B?QlMvcU1DbUhiMFlqb2JuMnhmUi9nM0pOQXZkZ0xRbXc4Q0JiVlFvZFQ4Slpz?=
 =?utf-8?B?SEFLQnVIcDdoYUJiYTRuWFlZdE9YZFpIeStFUFh5UmRvVDZhNFJRSzJJcjhF?=
 =?utf-8?B?WWppNFVMbXVabzFPZC92UFZ1YXBWbFAxSnpDeTBYamc3UUg0cDlqZC9zOW1G?=
 =?utf-8?B?VmtLOEVwdHBidnQzVE15bllkditxN3NhSEhjWHIwVE1kRXI3RE1DQmtRUjlm?=
 =?utf-8?B?ZklaMTFnNU8zR1puZXllaW9VWXRWQXAwVmZIVjU0RDBLelE5ejArbVpIeWdK?=
 =?utf-8?B?NUt6akd1QXEwQ2pQU0NHOFNCOERsYmhieGRHaUJYSDNPUkx2aUpWbCtXYVFi?=
 =?utf-8?B?bU5CdW82RW5yZVlvcmcyMXV5b0ZweXdwOHBRR2Vmd1RuOHpqU2lueFg1Zm1O?=
 =?utf-8?B?bzRIMkR0cjk4Um5yUlFxTW5GOWZjNWVWYkZzRjNMY3NOUmFWUVRkdjY1WFlY?=
 =?utf-8?B?SW44ME1YQkNGSFMyQnRNZDdtRy9NUEdHZlBSajVEM3RjeVQ3ekV6ZmU0Y1JG?=
 =?utf-8?B?bGNDcGhqbysxUlhiWnJSLzg1c3JXRGp1OGg0ZnZwcmplVGFZNTIvM1dwMVZH?=
 =?utf-8?B?eUpiekJTWTdxTUxBVXlRSDJYVytBVGgxMDVqM09IM3FxbU1VbHdGWFZUOEVa?=
 =?utf-8?B?bHlRUTRaLzJkcHNSUm9uL2plSytVSytTZWs5a2xCeUc0bXpQRHhzdTBhUnZP?=
 =?utf-8?B?N0tUN3FpTk5ZNTdJQ2Q5TzJYNEtzdE5LZXFnN3FCa094VVdmNk5rcGZpSkph?=
 =?utf-8?B?OTJOdXJZQ2tXZUF2anBzQlBOTEJ5VERXdlpSUFJnT0s0NmYrR3lyYlpyVC85?=
 =?utf-8?B?U1FXRUtVMjBWbGVIV1ZBUWtCL3ZKMjRnTURPUkZacFNsYXYxSVFNNFlKdEUv?=
 =?utf-8?B?dExQMjVPUi9PbFV4NVdPVXJuZG1RaU1lSmZlQURKaDdMUHhNRE5wOGlrUURR?=
 =?utf-8?B?bUJ0UWxvQWxVbWY1dXd4Q2J4V1daalRlWWVwVk1XY1Z1YnZGQUg5dTRud3k1?=
 =?utf-8?B?a0FRZS92dU1jdlV3bVlQeG5PeXdYT3orYW9Pa29FcTZwdDBoaTgzcm9PQThj?=
 =?utf-8?B?SGY5NnNTdnBpZ3FtQXgwb1RjcldTOW53NkgwakkzVlVlZG8zdUM0WSt5UUw3?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef5aa00-5505-481e-cb9a-08dc3cdccd8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:23:42.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzdq3+e5CAjEOocuC75D+GMB3wtz7W6ljEir8JTnPTeCD5/XH87J/tbDJuhFVBfb65MLSgRiYJuC2jj5QdkYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB8021
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 06:24:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15205

On 04.03.24 11:08, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset adds checks to validate the certificate and key before
> used in the signing process.
> 
> Add also adds the missing Documentation about swu signing in cip-core
> and fixes two issues:
>  - an error in the build logs of do_image_swu
>  - Creating all existing image recipes by touching SRC_URI in a anonym
>    python function.
> 
> Quirin Gylstorff (4):
>   swupdate: check output of sign-swu
>   sign-swu-cms: check if key and cert are valid
>   doc: Add section about SWUpdate signing to README.swupdate.md
>   fix do not add files to each image recipe
> 
>  classes/efibootguard.bbclass                  |  1 -
>  classes/swupdate.bbclass                      | 83 +++++++++++++------
>  doc/README.swupdate.md                        | 21 +++++
>  .../swupdate-certificates/files/sign-swu-cms  | 29 ++++++-
>  4 files changed, 105 insertions(+), 29 deletions(-)
> 

"Make swupdate signing more"... more what? :)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


