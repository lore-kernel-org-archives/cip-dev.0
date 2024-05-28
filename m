Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CDC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:27:33 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web11.25396.1716910046990543206
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 08:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tp1E6B1M;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/IL4xHuD4xz82aYKM9pZWr9zWsiRwSVcSyPTWhEZCIkuSmoKVerI8map6uLjlvvrMypMfdZeU3EurRe/ZdLK5wfZqhjs3TYyv4ghhaU/e2Uq1zH1qBKp+95RtJ7l9tnhaY9fPZ3mF6iWYSqzXr+UbSUX6qmaDK8F4rXfbBEXR0WkvNQVmbKeqMfTGA2ithrKsxc984CIwf2/5ohuoqHgG+/eRvzTOvfV5DvdlURlRUXkxJeLpo6dBC6ec+OmepmZ8+hO56Av1oRL/6AlouUw03SmBesFUgMUYh7FkRGMJiZq5TPddAvnwb5Q+j2HBvbum/0RAVBTVKO7vi2LbTIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7mKhSjGKAfB4SDm+ZHxcXOdD58F+r2d4vgBbJhjixA=;
 b=l9a6ft+6zuM3wL7KF2bZlZEkwXSYduLxw08cs6HqP5WbAwzFYyoxihtSZqE+eokwEoDQRaQXMz93AVUUggbjB+k+ZVwRJdIgquya9suXm+OF4lVqbaOfjDlaHkfI1OcybiXkmJt/dgEgUdkJcKixoFSVdEj5EX5fMKqYH+CqZyxKNEX5dxNDvqVeFBU7vBqw1g3sG2gb2RFfR0+J5YJ2mJErnmUcgIf9BdR0fX3pOMa4lIWvsKzitFVEWSAOVtaLn5O/wAmUZCI5FGvsOQLbsPKfHbXpZXdbq/qEqLg8VItcGw5U6mffhqmUHBtGtOd8GLjHNJWDUTa9mOT0c/sXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7mKhSjGKAfB4SDm+ZHxcXOdD58F+r2d4vgBbJhjixA=;
 b=tp1E6B1Mir+jhuygXhbX+qFckfKlKBpr3dP2WvuAHG384Ktb1eksQNGOtmUX52CYaujcrJGeie9w9kEShyjA3tTxjn4OCDI0C2I4M3GxgVJWDm9d7+DtfJvbhAJ8znO+q7vSMjT9zV5MEDpvYZL3j3VeKSth3L3mOAmJ2dWAKNvS/K2a6sgvilQWm5AzbFgH1DCeX7FpTE0G1PkSy9dBrF8QFZviLR25cmE8fxNYnoFf7Km+kFmuPjtYB/GQyUUAsVO1g1kJc4rPNh1yTgoidIoERp7KDl3E+pxDABwFJog03+K/gtakNCNJlKkRdjEjAnuMZsJXOzBR9HnY9IuW5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:27:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:27:23 +0000
Message-ID: <428716d7-3027-4c77-98ea-8e6ee0bf124c@siemens.com>
Date: Tue, 28 May 2024 17:27:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/3] Move security-customizations
 to recipes-security
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
 <20240528144903.922587-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240528144903.922587-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:610:57::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3a5a3a-db7a-419c-67b6-08dc7f2aac32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aXhVRFR3RFpXbmR4K0NNYUptQmxuT2J2c3dGeGtKZTBuTVRYMDl5OTQzVGox?=
 =?utf-8?B?by9VcWtEQzBRYmc5UzFldjNjRzNlanN3OWsxUFhiVytzWEtGZ1pTWlh6VlFW?=
 =?utf-8?B?VFp6b2RKaXNOYnYwdzgwUU0zWFV3R2puZHU5ak5ZZzFQVzJ0aGh6MFNGODZj?=
 =?utf-8?B?NWp5WEhXL1VTL3ViTG5DaUgxbEVIcUxDTnRpQlFZOS9rN1UzdVdJS0NScVc5?=
 =?utf-8?B?cUdOdVhoUnNNbTJPb1BrL29kN1MvTFM5YzErRlRGNnE5elhoS1Y5c25kVTF2?=
 =?utf-8?B?T1lxWjlMQlliZnZyaGU2UFVLT2RjcDRXMkZkM1dqV2l2TmFlb2l5SC9FaFE3?=
 =?utf-8?B?Z09JNHY2MWZpYk1VMllDSjZiR21IRjFOWjN6RHpabUtBRFlUaGt1NHZ5SlhL?=
 =?utf-8?B?eFRxb3o5bVNySzVlc0VEc2RsY0lHdTY1eDBpSmpiU0xjUmtZSElUMW1OV3p1?=
 =?utf-8?B?dURsVEp4enk5T2VTeWZacHBkVTJhNGJ4a0w3cVFBd3ZGL3lIandQRXAzb3dC?=
 =?utf-8?B?QWs1b0ZGZGNML0UySmExTmNmTkVVSDEzYmtqU1RIU2JJeGMzRmJTYlkweVdL?=
 =?utf-8?B?TjZHdGgwNG9raWdtTmFmcVlDVDlvV3dRN0o1ZWRCU3J4NDBoc251RzZTRHBD?=
 =?utf-8?B?czJ2eFNIdTBYYVRuZHM3SURuWmFDTTVzRXZndmttUXMzbStab1MwL0x2NU5v?=
 =?utf-8?B?NEdCRjFuMnlLWkVzNmtvUVFkbFJmTDJFNXFqOU9CSFhsUEh0ZWpRUTBtdjJ4?=
 =?utf-8?B?YzV5dy9qQ0s1NmxGRWV3RFJVemo3RFRaQ0xYbUkvem4xeHN4NWR4cmd6R2tH?=
 =?utf-8?B?QUs1NHlOeWdISWErb0g3OWtJL2srMlYzalhhcnY2QnN5WG90U0ZwLzFuanR0?=
 =?utf-8?B?enpJY1Z3d29SeXU3NmVrOFlNUnhKSW85RStQNkJvM1JqWXhWOEI4UXZkZXhB?=
 =?utf-8?B?L09oZmtzQ0JWWTZQRkU1Q0gzSS92eElId2dYVVFtZnh0OUNaTHNqUml1MEZE?=
 =?utf-8?B?TzBVT1UxV0kwSk5xUTJsR3JPd1RpNmNNcVdJbUhQeGVsbmxIMHI3YnR2SG9j?=
 =?utf-8?B?T0tnRkorNGFvdFhtTHlJbUNSeXcyRGJtM0I5cDZYTXR2UllleTc1TEg0b3RW?=
 =?utf-8?B?c1Aya1FOY1JSK3V4OU5rRzhOODZ0Z2ErR3ZVMjNyVGpKajRzZ1ltMkkyeUxW?=
 =?utf-8?B?anU3NGNrWWg1UXVaeURxNEZqU2lHUEVwRjNmVXY2UTFGRWgyR1dvYVlSZWVB?=
 =?utf-8?B?NWVHdlU3bWphZlRsS1Y4TXJTZFlSais4bGhWcDBMdmVNT0VPWTZ3MjdydXdD?=
 =?utf-8?B?M1F4RWJXbUp0ZkRQRjRMS0hUZmQzaGZYd3N1NjdRNUdlbjI3bUxlK29uRnhJ?=
 =?utf-8?B?MDNtaGJSaXpvNzdPd0hoWVF3cDFucER0NmVoTU1GbWxZTVJkSk50S1NTd0JX?=
 =?utf-8?B?TzdkK1BOSTN0OEovQ0VtdVFWbktZenNFa2hkSUp3dU5GZStlaVc1WjlKQzQ2?=
 =?utf-8?B?QUhaY1pPRjFzSWExZlR0ZFcwN0w0YUM2dlJnYWZhQ3JidWFIMzZMN0NSeEQ3?=
 =?utf-8?B?MUYvaFl4S2RjWDlVRU1PTGFpSnZQcUFHcDBYekcvL0VLc2VKRjA0VTYwdXV3?=
 =?utf-8?B?V3FuWU5Vdk9LMVhVblQ5Q0FzSE5laHl3MG1lT3MxTGg4cG41SUJxS0J4SCtU?=
 =?utf-8?B?dzd4TitBWFFBTWMyVWhjaHZkQmNYOFZPaWpBbFlEdERvb3pWTWxUV3N3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm5rMlRBYTBkRi8yb2xEODIwU3dZdit0Rk51RmgzK29zUjd5bmxvUitJNzl0?=
 =?utf-8?B?eVFyWWhKVkg5anBNdTVpNjMxckg5VWlyWUI5UElJcDJXYmJWMk9SSjA2cith?=
 =?utf-8?B?anh3YnNNWW9hcFhxNnFhdmU3dUlVV2lTYUQ2NG1pWHV0WEtmZDI4VVZVUmNl?=
 =?utf-8?B?UDk4L2ZreEI5ckVsdDZDM2U3ak43U1JWc29vcW51QkZzZUs0dml2ZUk2MlZ6?=
 =?utf-8?B?c1B1UlI1aEczeDBxWHlsVlZGQ2hYT3lHVmhNUW51UWExNklLcnBUdWpRZFFY?=
 =?utf-8?B?NVdUQjNTQ1JXVDkxWDVqWHZFWXk2bEZjVnZYK056TmcyZnovQWFONWc4OGNI?=
 =?utf-8?B?RG1qWStkVnVCKzdMa244M29QVklGNUN1UFJJbUh5K3FudUpzN1NsaDRZeUht?=
 =?utf-8?B?czFwN1NDNFQ5YTc2S1Y4dVZ3b2RFcVhld0RndlVXaUxNazlTd3ZjSG04SzZH?=
 =?utf-8?B?VUtaNEdiNVgrTm16dTJhenZHY2JWa2ZzM21YTjFoL00wajFod2M4THNiYmlp?=
 =?utf-8?B?TGdKMnNuamRuaFN1QlU3VHNsUEdrUVBlYWl6ZllLaHlwMDZCSktqUXFjb2xJ?=
 =?utf-8?B?d1NpNWJ4NEdZRFdhVlZKdzUvL095ZENpeGh6bmVUMzhmamxuZElyd3ZBanYw?=
 =?utf-8?B?NXJnUTVRQUNWNkQyTXllVytwWldWM1pDS2NHK1dwNVdob0hqdVEvYmF1WGY4?=
 =?utf-8?B?SGw1NFpNbHMwNncySTByZGgzQjBCem5qbmE2WFlkWlBvSUJubkg4T21kRlh2?=
 =?utf-8?B?Y25oK3dQUEh2NDd3OVFRRENjRFhhZjFYd3VqaDJyb0xLUWNXekFqWG1IM21m?=
 =?utf-8?B?dnJkdURCUG9GbEZ2UGptczdadHJ3VVhhMWJJVjNLQ25qRGY1Z2svSVRBNEFq?=
 =?utf-8?B?V3hITTR5VDFhNm40WG1jTmJ2Tk5MNS8ycXlHNUVUbFJzWTVtNE5OdVRvM0FK?=
 =?utf-8?B?QldaVUdiTVNFZmR3UC9walB6elM4SW04ekFobFhUWTBCc0pXOVlZYXdNRkNE?=
 =?utf-8?B?RXROWkdsM3I4QVZpV3NyNEpDcWhtWnhlZElMQk02UlVvNVFYa3hyM29QbjBQ?=
 =?utf-8?B?ZlpJZDFoS1BpQUwxT1ArOVlMQzRUM1BXaVRzWEF0TlNpSHZmeVVLUWFJVVpi?=
 =?utf-8?B?aVovRjBUSGs3SCsrU3hvOUlTS1Y3ZnRnVi9yc1FrTVluWm1vUXlSMzh0enZo?=
 =?utf-8?B?QVNsSDc2aytuV3NJbUxkUHQybFo0QnE1SS81QW5HMUZja0lucXJsTjZBaUxs?=
 =?utf-8?B?YU1HZ043V1BMYmdmdzcwT0xPdCtPN3AvTlJUR0F2VFMxd1AwNjhEWTcxeVVU?=
 =?utf-8?B?aXZOcWY1UnZtc2JGRHhabFAzajVVcWFXWFlVTFh5c2dpdVUzbmIrT0hlMzdZ?=
 =?utf-8?B?U255RU5UcVhLZ0hjZDFKNVpaTjgxNWpaSGhhMi9YbkUwNzR0TTkvNUJ0SkEz?=
 =?utf-8?B?UHplT0VzUWNYRHNoR1BYM20vRWNaNFVoZ0tJYXJHRjFRUUVVc3ZHdFU0OHh6?=
 =?utf-8?B?MlB4MFc4TVFuSWc4TFMva2FOQmQxdGx0NHU3RzNtVHlvUjRId1ViV04vQUJG?=
 =?utf-8?B?S0Rvb2duQWlMS2NQeE1WMDh4SGh2TFpnVnhXZmZLSDhTd1Vjd1grUXlUMzFC?=
 =?utf-8?B?R2pWbXFVMzBSMmp4TzBldWl1dm1KWG1OM3BFZzVHc0NQcVJMZHliRmxLVUVF?=
 =?utf-8?B?RDF6OVFPRkY5blFWclJwY3FKM0o3YjhWbGE1WUxUaWlOQjluTTYyTWNoRDZN?=
 =?utf-8?B?RnJZTVpTaDhvVTYxaGx5ZytnQzg2b0tVS1I4amRCK1lqNG1xT2FwWlBsTjNk?=
 =?utf-8?B?VWFxdGZpM3hDSHFQNTArVURuQ2hVUk9YdHVXN291cGphN0YxTXV3S3djN05L?=
 =?utf-8?B?RUtLWjJqK0E2SldTeng2MnBNQ3VzYzdORDJHbG8rekRXWGZLNnNVNmZoZkNk?=
 =?utf-8?B?UzFPQnhZV3dKU0YvdngwS3BWTDI2ZThieU5ZeGxKU0F3dXNiaGhRejdWTzB2?=
 =?utf-8?B?S3ZGTVRhZEFCa002MG5rTEUwWG8zTWtRQkwxL1E2dWJkZFRJcmlYc2c5dmRv?=
 =?utf-8?B?cUQ2eU1UYVdwVUp1SytHcERCWWoxWGZDSW5RSFVQOGxUc3FSY25IU09BMWJm?=
 =?utf-8?B?RHRDVXlpOXEwOWdTRmpzU1JxN1dFZDFiaTFiVm5DOHlDSVlzeEZqM0dWNjhT?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3a5a3a-db7a-419c-67b6-08dc7f2aac32
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:27:23.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VI0K3gMSxqAfsQolKiouu6sn+ouI2jzCPVDsn9eKHtpyx6esvlcqiyq1BjhUzJY6fricM+7V8QGyWXhdHO5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 15:27:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15969

On 28.05.24 16:42, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This increase the readability and organizes the the cip-core layer.
> 

Double "the".

But I'm not 100% sure about this move as typical isar layers so far had
customization recipes under recipes-core. Not that this is written
somewhere as well, but...

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../security-customizations/files/postinst                        | 0
>  .../security-customizations/files/ssh-pam-remote.conf             | 0
>  .../security-customizations/files/ssh-remote-session-term.conf    | 0
>  .../security-customizations/security-customizations.bb            | 0
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
>  rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
>  rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-security/security-customizations/files/postinst
> similarity index 100%
> rename from recipes-core/security-customizations/files/postinst
> rename to recipes-security/security-customizations/files/postinst
> diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-security/security-customizations/files/ssh-pam-remote.conf
> similarity index 100%
> rename from recipes-core/security-customizations/files/ssh-pam-remote.conf
> rename to recipes-security/security-customizations/files/ssh-pam-remote.conf
> diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-security/security-customizations/files/ssh-remote-session-term.conf
> similarity index 100%
> rename from recipes-core/security-customizations/files/ssh-remote-session-term.conf
> rename to recipes-security/security-customizations/files/ssh-remote-session-term.conf
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-security/security-customizations/security-customizations.bb
> similarity index 100%
> rename from recipes-core/security-customizations/security-customizations.bb
> rename to recipes-security/security-customizations/security-customizations.bb

-- 
Siemens AG, Technology
Linux Expert Center


