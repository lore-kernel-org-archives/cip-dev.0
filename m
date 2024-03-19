Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC453C54E68
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:33:41 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.69])
 by mx.groups.io with SMTP id smtpd.web10.23764.1710873220333655479
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DpaEKV9d;
 spf=pass (domain: siemens.com, ip: 40.107.249.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXkOtZn4EDTgyCZ7qw5yFBplYEbmOkgmHcU6QdlXZWxEqelbIe+JMDVczh4DLZD1cmKYVUNTvwj0wFq9+JJ/hIwaLRiB2iEGJ9DCCo1cxGUQuOT3X5qGtDhlQ7lgU24MPUfwSOjofB6+0ltR2WtPpW/u9n88E/hKceeODatRQKYC7OTOt5ku+Ro0qaRvGtsZCNGny5E6RpdrPXw0N9cKEZH8lTlbjVNg6myZ0JqBMYHItj9gROWrYrYBF9Ba1hLgenrZUV1+kH9eakFAw3j0mbmFG31H+1FtSlbHGfK+llEcWoqmlalHHmXfUBOon6FdUBObO9gOtHD5ngDLbmS46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5m3ZzVFu1UiV2AVLoeYrMnTXtPEI3MzIEZV0gnSloE=;
 b=V97CroNyz7yyXfZ4s3yVpFEZnZZbAEJNy1YeASWPUBgxrfbihBDdy83aXl9qx7UcunS9CS+Ydulx7r6hhOTfZpnCytJr4IhxuR8OT6zH/j2SG6681JhfHqfWlwaWqb5H6uYEae/KZkT3gxgKAzPMyaFmM9aLoLIHNwR9KQEt8oNtE+bELaSmphhDy4CipIlVstPcC55rLlqgYiZOjf4oYhX2eUSxS+DrE85aIReSpbExjhFeMcsImIz60JMVAjTLg+7DVf3KomOhBAiFU6XfcFl7H2rloT0qxnSdHqq9HxET+RGuArg/HYspgjQacNH910On54f2T37uXS9VWLHTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5m3ZzVFu1UiV2AVLoeYrMnTXtPEI3MzIEZV0gnSloE=;
 b=DpaEKV9dmpPf5ou9vFCadHT4q+RKuxhK3e0R7YtQUQuGATWiiyrAxDtD1EnrRPPf5PixlofdhX571YxDwdFQcAmBHzLJUxFFMgOSIl1JLm4MISCosIPf49o3bvr3OxLgYEu8JpkBjmFVh/RxqHui/EAw3CkVOBob/zh25qL6NZQGaKQf3eedNeiNU9vmbd636/4tDpS+9Ggdwurw+cgISvIE/ZbfFVwcez5/CNO23xa47UUUj+GnAIG8DuQkKiRXwZhnJniww2LaEpGm4VCeYMkb1zpnKYTFerBv2kuaqZLYdrOCm7KwaJwDGXvbTJTb8RTST7SQlIy03p6SoGXc/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 18:33:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:33:37 +0000
Message-ID: <0b49dc4c-db73-4b3b-bc4e-a4c8073a3956@siemens.com>
Date: Tue, 19 Mar 2024 19:33:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/8] initramfs-crypt-hook: Allow
 switching between clevis and systemd
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240319182026.1571362-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3829:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a46bd34-c1c7-426e-6e8e-08dc48431732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ItsxwlFTMEjQVQc56QSvuNkia+8Wd1v4uUGkcW1MK5qaWE42dFZow418Fx4M2VRpDOoAi8xliVQf8bRAqBdrzYchBMI3GWrr0tD92QliGaaPemNqB73d0RwOeabkHULp8vwUZit3J/KVDELedJv276chxxZSYJ6x+aM++u0jgwS3VcK7SFew7WETAYAI+eB+26WA4dnRV1AJyZJMQ/14FcH2R9CpV7jNpv93YMSzJBPt606PxCX+DNEQ/CVSR1nb53SMRm1VHeI9JgNha4ZrTlIjr1juXZZx6sW7nEcaxB1Fj9jj3lpB+zNN5+9kzUC2qW1ZQXhYcEamCay9SuSvD8ITxrw9hZvSqshzS/+KIGa6BgI87YNJcHc8fjU+lI4yN2QGbErBrkIhQKwWQcSN1mp6D3X+LHfMU45HtiyOS48T+gWU2P0UvjeykoDdWr21fpqOv2TNLX327TLNH+q1x+Ejdb2/Wqml5C5biefXGs9dn8kSJ7Nd9bdoP8LleBaOCWI868S2FGpRU4fMZ1coHNxtlhlaW3MA0ouiRv6YBCcwWE9iWtRje6iqWHkZvPb/kpMjWtaqLOo4kGdkDCTeKn+LvgQCN4wx5dvzERKOTxLD35z60j6x132rS7UiH1QEHAEqcn0+UqfBtbmx07ihaKkcCBly2qjoaM39BNpGXKE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGJLWHpIN3JXNHVta1V2OWhMclM5UGpvVThxUWdBU0s3S01TV1AwcnBIWUN4?=
 =?utf-8?B?L0EyZ2FwaHFtRS9SZ2EwZ2JETFNiZW4rYm5BZ29uelNiR05PUTUzd1dzWFhS?=
 =?utf-8?B?Tlp3c1p1ak9TQlU5Rk5kTm1YTFlPeFBZaWVITjlBSTg3SVhJc2dXVmFldUhw?=
 =?utf-8?B?WjJTR1J1d09xSlF3QjJmckEyTUhabllvQWlCb0Mwdk82N25TUFJMWURkOVNQ?=
 =?utf-8?B?aE0zTitRN0ZIYlFzWWpXOUxmdEhraWxoeG5FSWZPSXozQndyTFkxcStFajQ0?=
 =?utf-8?B?clVrUDNtUXBQTUVKdnlsR05USHpQNHBPT1ZiT0xTYWlUZ0NpU2FBMzAvcDFN?=
 =?utf-8?B?N2RqS2s4NjNZZmlCREFpVTkwWG5Hd0NDcTlISis0dFBGT0QrWWNMMnFpc055?=
 =?utf-8?B?K3JSdjdWWXhWdlhiZjRqeXduZDZsUWpodVMzUmJZdW9ocDkxT0N3WUZuV3hB?=
 =?utf-8?B?QnVKT0xLZnBpUC96VHNrMDF1U0RJa29mZENHZHA3SzlmQkVBd00rWm5CLzEy?=
 =?utf-8?B?SEQrQUFJa0RPRXAreU1UejdkdmhHOUFZcEE2SWtaVkhhYU1jdU0xV1pWNXFa?=
 =?utf-8?B?V2ptY3hDQ3FJdU54ME9oNTN2RnV3anVKcHBPM1ZXN29xNU5wMXBRYlRMM09a?=
 =?utf-8?B?Q2tVZGdGS2dXa2dNUDFBR2Jsa3FkMHhjNTUrVFlKU05xSmlmTlVCWTFMTmVS?=
 =?utf-8?B?N2FTVTBpVHI1dFhLTUdVR0JVaGN6MGU1Und6Mkk3dkVHalNBT3RTUCtOSGVy?=
 =?utf-8?B?Y3hXOXcrSjl6bjJETjg5TDlvVXJnbmcyS1dtYnQ3aDQ5WktVYUZ2L1dGeStq?=
 =?utf-8?B?TnhteU4wTHZjVFpaWldxcUM0dmFXaHNNbHBFSys1YUE3WlAwVWxManBmNkR5?=
 =?utf-8?B?eWU5cmhTV2hndnh4ZWxnaEUybDl5QUd0VnVIV1FIMnZ3M0ErU1pPZDlGRU5G?=
 =?utf-8?B?Q281Zkd5aFpqclA3UmE0SW9iTW5ZenJUalVDakFHQ093K0pQVUZQKzNOQi9n?=
 =?utf-8?B?cVk1WkpXTEhGQjFRdXpYYlorS242SEFQbTZlaTRwcTJ6Z0ZrNWF5b0VxdnZp?=
 =?utf-8?B?eUtvbTgvcHo3bHl0MlBPbkR3c3ZNZHAyMGtWVHYzNktGbURaTUVlam5lU1Mz?=
 =?utf-8?B?TlRGRVJicXpnSzNUK3djRFE5VHNZc1I0bUtsYlpDckQ4NWcyTHhKSU9qM1Fj?=
 =?utf-8?B?bGkyUVp6Mi9xSyszRTFEWkVlb0R4TnhDSDNWRXBsSEMxbDh4MURnejE2d1Ew?=
 =?utf-8?B?RERYT244S25YbE0wVE5WUllpM1FZUzhHamMwaHRLeFR0c1J1WW5IVE9YNlBm?=
 =?utf-8?B?QVhEWld3TktQUk5lOFY0bGdQdk10Tm53UmxIZkZTc1FlSVkyaElHclJxeURH?=
 =?utf-8?B?QWd2RVY3VUplR1NkSHpjTlpubUwwcWZuRk9wbUp1ZGcvdHpYTzFLWkNpeTFq?=
 =?utf-8?B?WUxraTQ3QjFMS2dmS1FvVFlIdnZwV2Y3OE1MeFFkb0ZDUm9FbCtPYVFyQVRS?=
 =?utf-8?B?ampKWk9jUFp5WG5kUFptQ0lENDY1RXpTaUVDNE1LME8wVnJFd2Y4MGlhOFBF?=
 =?utf-8?B?QWFuSFZUTTJaU1BIUEU5cGxGYWpGMXEyS0pqdUdpVXkxU3h1cFNRYzNoZ1BP?=
 =?utf-8?B?a2FSTVM5cStqdUZSN25pZ29GeHBVU2JSc08xc0poYUppQjI0S0FyQ3NCTndy?=
 =?utf-8?B?MFpnQUpLUm9xdHo2bEIzMUVLZFhoeVZxZmorV2FkQWFhelcyblBrR3p0U1BO?=
 =?utf-8?B?akJpQUdXRFZaNnZhTFhJdFh2bGlKM1grTGZJcm1WbktlQUx1Y2QrcjVkWDJ6?=
 =?utf-8?B?dVBheTdMczZCbVhPVUJZNjdaa2ZjQ0o3Ny9jckJSTDUzbktYQzFLaER5Q0c3?=
 =?utf-8?B?MlJkQVVUV05LU3RRd3ZaTS81RzlFYW8xTVJvVnRQbVNEVDB5VVkyVXFZR1BP?=
 =?utf-8?B?VTZmSGp4V011V1hWQk1SemRONTA2eHFBSjdCWWdSMHdQY3RFOEI3bDROcys5?=
 =?utf-8?B?cnhLTGFSaDcyNFUyUUNYOTNTNGJNcWFKbHJwdWIxV0VIelZMTmhOMFhJRW5C?=
 =?utf-8?B?K3RDcWMxOVFla2hlWXMydzRUMWx3dUdHbFM1UnpjekxCYUFCeE9yYWpRYThI?=
 =?utf-8?B?QjdvN0FCVUZRd3ZXaDR1bDJlclRZVGdOSmthYkZNZDlRSFdXV3VJRzgrZGhl?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a46bd34-c1c7-426e-6e8e-08dc48431732
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:33:37.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYsICfPur0Y2jnU2OSrpgHjdxw6kDwaPzlkier72QfRcBDIHN7G924aB25UE/80Ng2ePm9Od7ok3215JOaMDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3829
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15374

On 19.03.24 19:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows device which started on Debian 11 to continue using
> clevis for encryption and decryption.
> 

Would an upgrade to systemd tooling be possible as well? Create a new
key with systemd in the TPM and add that to dm-crypt container?

This is just out of the concern if we may have to maintain that clevis
path forever.

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook_0.1.bb                    | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index b275c0f..317ea12 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2023
> +# Copyright (c) Siemens AG, 2020-2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -17,7 +17,17 @@ CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
>  
>  DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
>  DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
> -DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
> +DEBIAN_DEPENDS:append = "${@encryption_dependency(d)}"
> +
> +def encryption_dependency(d):
> +    crypt_backend = d.getVar('CRYPT_BACKEND')
> +    if crypt_backend == 'clevis':
> +        clevis_depends= d.getVar('CLEVIS_DEPEND')
> +        return f"{clevis_depends}, clevis-tpm2"
> +    elif crypt_backend == 'systemd':
> +        return ", systemd (>= 251)"
> +    else:
> +        bb.error("unkown cryptbackend defined")
>  
>  CRYPT_BACKEND:buster = "clevis"
>  CRYPT_BACKEND:bullseye = "clevis"

-- 
Siemens AG, Technology
Linux Expert Center


