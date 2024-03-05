Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41E6C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 06:30:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web11.16099.1709620218411919187
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 22:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PP7qMpXc;
 spf=pass (domain: siemens.com, ip: 40.107.21.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE17xhwG75kSB6c4Rnz/Ow3Hcpuvav/jYzviW6KNcIqP63ldJne8546plXZveCQJSOFghHSuVn0P93RDNwASLjlrS1zpB6Gq0LN/7rWfNk/3JGTE1HA4S3LwZoQHo0Gk1DL5I0eZAiUw+ph1a8jvEJozKCAmM8Uo3NXE7QVdeb2/YH8YaC6Bw0Vi+NMYP47DequkP9euB+VWFs0JbWLqsQSfpUIsRgLPBvKte/f9CkXS6ttxW56MRgcowhynvDCpZLK9DIe70hFXjAfNNuuLmQpJgf5Y86ByAIHHoVsLi/7t7akXetTkvAHyQenWnPLqas7VsZriZXxrI/fyWkgpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi9tZFyFArvcJFXhI+ufT7WoWBSkgGbh8mhACh6CENw=;
 b=H5XhZAQVITX6ijq2xYZMD8E7YxHt6ets0zi3Y4pvRQIdA/xIqn0OvX4CmbnnHHjOMa4s+ZoN9ex5MPd+Kw/U1B5ApFrwck8hFvDwx+sSPyx5Sksv6h9ooawQzqBtGBRYUYcxwUZVKtXfHz/UCPh6aqINGR27qqz5fKL8b/R4nLuoyHV2B5Y1cEGQ0yzodugLKg2MOYatuMOQk3GqWsPuuznqkveArF4xx3AK7G08vkBVTRQrPYACCU9deVcyBGVYikxe4ghoA2+D8Ml9CQ9rQ1cIiRxOD1ExnmM+GAXkzSF/RJCicqFomcMmQ5MY+cynRfbc7M8fyPe43tCQrUPUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi9tZFyFArvcJFXhI+ufT7WoWBSkgGbh8mhACh6CENw=;
 b=PP7qMpXcjlyUmkluWrnMsQT9+e3uVrbjk7W5LcpPUrFjaAhFdRcKY7RX3kQs6wTXj4CTRWyXd5sUgOErlWSofQg/oYC+QgBjfHxl8hHhvh/oBG38En4bU63KT3lXhsW9dz8DAq/Gqcv5SCh6tNXEkbww9jXGDPHoV5pyPHZ7YMMMBBTi9OL0G5K9iDABQIM6NZ8mkFqxz2U58AmzIUer20S925GofQtsA/nugBtLm3I3phN4ArV4mHk6Dn2gNCoX6BnjASn6D0wPFBNK3mcdqssZYIh28309iloywdBrlv4S8n+T57yS14igSIJTwZiPykyLNt0SYeFRD3rDDEsFOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:30:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:30:15 +0000
Message-ID: <bb934b8e-63ad-422b-a9c5-8d6d69e54232@siemens.com>
Date: Tue, 5 Mar 2024 07:30:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/4] Reduce difference to
 debian
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdef54d-6075-4e23-dc17-08dc3cddb7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OGl79MYhnf44L2/akTveiXMQhbsAS3zQBMdojApzrvdTbgjwlJt58JFEoUd7Th11AcDhGgQUfJpfxV3hgOuB9GiRI+bTcgyJV79LphOM5cX7njnTLAwv4eDEeghDr0zsaAaYQj60cLScnt+hrQ8F71upUu/i2e+kLLuw7PeUoVzK2UfI2ZGUdCwL6jPb/3bQ6sJRSd3dZvO5StVECEZ5tAycqLkw2/gtk0ejswr5ktdrlSuU+0o4RimAl76K4zouI3+QUeBKZqK0P7gDfqBIQyIKqmiGTCy9HX3bqR+kPK1pEFhWYyrGPjVyO4dNriAEmPAUkGCZA3jVfLG2POJOND3OX+UeGsXC1+5srJcQBbBNlwLhTKO3RMWoFtZIEoktjdBpZxuk2rW9n+YNhcM3l1zBacB8P61U1uUptTzS2s8czHFtCU+dvHaszpkOv/lKL3/JKV01mNMqZfqUpRxz3PgGWr6Qr9sL6BfEIShofpFxso7C3stx7fTcOhPuN921Q6rJFyOHeyDYyQFGR4/enzYVefTmGxiPOVN3eO4DtK+PbhreZ2HqUJyJV5WUQlA4FtQOFtljxtGy80VCL8ALN3Ji9H3ZeH6JAH5gllm9dguD6c9VFEqorleMEKX4yFXrcSC2BKrE1df4eSIGIo0WdVhPw+CmmOfSE2980wNJOyo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmQwZTd3WFJXVndFcnhxWFhHZE9JWUJ5TGJTSVFaMWlZcW1EQ0FlTm5NeGpH?=
 =?utf-8?B?TWh1MVV4QjVGZEI3TlRPdGtqN2hVY0F4TGE5UTJWdkdraXFPNnRyOVBGTlIz?=
 =?utf-8?B?UG02SDFMcnhuTFBlUnFuQXVGV1JGU0pCZGhkNkJaNXEvTkZlUTRJYnNobDNK?=
 =?utf-8?B?QmtMR0g2Rk96a29IVzdCaUgrWDdtRFNXSW12cVlxakFOSytpR1ZVY2dZOFJJ?=
 =?utf-8?B?NG9CZVdGbk1pOWdhTDIyeGFUb202cUNCZ1gxZDRMRmdzcU00SDlVZG5GZ0VD?=
 =?utf-8?B?T2VCZlMwc0QyV2ZqYS9mbHkwNjdxWDRRWitvZHJGTS85Z3NoK21xeUZ1UnVr?=
 =?utf-8?B?Y0h3QXpNeTE3THdiTTRCZnRMZitqd1BrdHM3dXRGMWk5WFB4dzRBT0x3NjFR?=
 =?utf-8?B?Zk43VHQzQ2ZJNkQzWXBDK2ZjbHk4WHUyQ2ZIejJTNitoaUZhcEMxZ3MrZmRq?=
 =?utf-8?B?dk5mZEdHaWNNUml3TTBkQ1hOMEpKbHpOMlBocm1nSnVkMWxtM0ZEZElKUUdy?=
 =?utf-8?B?c0hZYzZXOWE2VmU4Zk9HRGFQR2tjbkZtbkxKWFJQZ1JmUlZMWWh4ZUIvQU83?=
 =?utf-8?B?MnB1QW1tLzlkQnF5RkxuTlpvTTJXZzNZandPR0lRMzE4Q0NhVTV0eHplRlZV?=
 =?utf-8?B?RmFqQmQ0STF1ckN6RGdhSWQ5YzJCb2VRYnZxTi9heTd5WUZyNk9CZSs5WkJt?=
 =?utf-8?B?OTNZb05PV1V6dEQ3cFkvQnhhUEh5OEVRN1FvMUJ1ekg0SmMzWkZpa3M4dHRa?=
 =?utf-8?B?aHgyRkVmVzdJRkZiUmRHT0c4M0dZSWhKK0EwS2lWYytOVjl2aGhJRWcrYm1j?=
 =?utf-8?B?ajgvZkpid2g3cEowSWlPTE4xYytaT2orc0JITU56YVZ4em1lamJtUnFmSndR?=
 =?utf-8?B?MVZQUkp4dUc2YmhiQ1R3SU5ieU1pNlg4bmg5RmxpWVFSeDRCendyVGNRc09v?=
 =?utf-8?B?dWF2L25TbTFzVGRGSUErVUZEM2cwR3g4NDlDQTNKdVV0WmZ0Ni9mYlVaSlcw?=
 =?utf-8?B?b3hHdm10Sm10bmNOVnRsNno2U1Q0NytMblUvdkZKb2xGU0R0L2pvb3BRYlV3?=
 =?utf-8?B?aVhhb21XUjNjWkRDTjdpYkZMdnVVeGovVVJBSG1mek8wMXpBMUx3bzFRalR0?=
 =?utf-8?B?VE41K3dBTXMzNGhZaHROY1FRSjF1VC9janVJOFk0NWZWNktDQkhqTGlBcFlL?=
 =?utf-8?B?dkhGTlp2andXQ3prcDU0VWp5Sm10dHdwdlRTcVlxbjRLTTN3aUgyM1g4RTRF?=
 =?utf-8?B?WVY2Rm5STTZ5MFo2Z0ZXNUtZVmljbDE1Qjlxd3JoMnR6UUY0aEJDamRMeUFX?=
 =?utf-8?B?UEFJNXZ4ZjhnNlFrcEVMYWp4TWh0TWpyM29ROFc3bElscFF6N0xvVUZib2J2?=
 =?utf-8?B?amUvZFJEVnh2aGRXcGc2c2N5enhYdFNvZFdqOTZhNmhCUkJXc212clViV3c4?=
 =?utf-8?B?Q3o4MDR1aVJLQ0t3ejJ2TTFRb1lpK3FBMU41aUtTaS9MMUJVbldJV0lLb2pz?=
 =?utf-8?B?c3lwOVNaQnI0RlpoSFkxeno0NE1vVlNsMWhFTVZ2MkoydlFEOWxCNlNBQWRG?=
 =?utf-8?B?RVVnUTR2ZzR2OEhBeVdZU05lTmdJZVhtVXd1OVIvaHkrcnNJYnc5bnZiVzFU?=
 =?utf-8?B?Z3FCQWxEdUNUNXJtbWZyeHlLR1JYbTFPMEtHTTN4cEZLZzB4YVhrcjd5QnFR?=
 =?utf-8?B?N1JlT054dExFYldxR3hMMDdRSXNuZXJQVE13UE9SaUw2V3FQWE9BQVFiTHBK?=
 =?utf-8?B?MmEwME9KMk5DTlMvSUJkUFNqSGo0TnYwRmRSQnJ2UnpoaUxWQXF6cGc4NVlS?=
 =?utf-8?B?QmVISmdvbStrVVF3NWZaRGZQeHhsUTlDMGY0K3dma1hGaGtEU1QyQVBvTk5k?=
 =?utf-8?B?dEVISlY1NkE4UWtQdGY5TUZNNG8vMC9JWlpyaEllcndFeVNxY3hDMzROc0NB?=
 =?utf-8?B?S0hhbFRPajRjaVZHY0JVMWpvY2YzNkFwb0YyTm5TYm9XRDBWVVc4Y2pTaWVm?=
 =?utf-8?B?ck1Td0FaYXpjVGlCb25uakRQU21Eb2NFWFkvUE10TGsrRFFDVmtpTmFpZVBO?=
 =?utf-8?B?ei8xM2IwWkRLdVlDQ0J3OU53dlBhL0UwNk1wa3M1cUh5cCtNOFVaZmRpUVIx?=
 =?utf-8?B?TGkwRmdCRWNDVWgzWXVPdDlYdWJwOHdINTBYTWZic1dUWXA1K01rT1hTZnc5?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdef54d-6075-4e23-dc17-08dc3cddb7ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:30:15.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HLXVFZ7knc9SuvQpp1x4ZyFybl5uWC5NUqm9Sue6IkRWs5WjI0LZ4Sqmxt0TrNHE4IaCv3mLRwgMwKiY0AHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5563
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 06:30:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15207

On 04.03.24 11:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset introduces a new configuration package for SWUpdate:
>   - It adds /etc/hwrevision to allow removal of the
>     swupdate.pkg.nohwcompat build options
>   - It moves the swupdate.cfg from customizations to allow the reusage
>     in downstream layers
> 
> Changes v4:
>  - rebase onto next(35f5ab2)
>  - Add information for HW_COMPAT in production
> 
> Changes v3:
>  - add entry to README.swupdate.md
>  - correct hwrevision.tmpl
>  - rework commit message
> 
> Changes v2:
>  - drop Add patch to copy the server_wfx.lua to /usr/share as Debian
>    upstream is also enabling CONFIG_EMBEDDED_SURICATTA_LUA[1]
>  - Use RDEPENDS in customization
> 
> Quirin Gylstorff (4):
>   swupdate-config: move swupdate.cfg from customizations to own recipe
>   swupdate: set SWU_HW_COMPAT
>   swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
>   doc/README.swupdate.md: Add documentation for hardware compatibility
> 
>  classes/swupdate.bbclass                      |  2 +-
>  doc/README.swupdate.md                        | 14 ++++++++++
>  recipes-core/customizations/common.inc        |  8 ++----
>  recipes-core/images/swupdate.inc              |  2 +-
>  .../swupdate-config/files/hwrevision.tmpl     |  1 +
>  .../files/swupdate.cfg                        |  0
>  .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.inc            |  3 ---
>  8 files changed, 46 insertions(+), 11 deletions(-)
>  create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
>  rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
>  create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
> 

Thanks, merged, fixing indention of patch 1.

Jan
-- 
Siemens AG, Technology
Linux Expert Center


