Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225FC25B74
	for <webhook@archiver.kernel.org>; Sat, 18 May 2024 04:59:58 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.61])
 by mx.groups.io with SMTP id smtpd.web10.13315.1716008390714349335
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 21:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wO4osNJa;
 spf=pass (domain: siemens.com, ip: 40.107.104.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA35USHTU1LhjbhYrfgCHKyzrAz+R4hUFm6r0wpvcFzNaotFLbtr5aNKi4ECx+QBVvogkb6aYUOVSTZZw8I7h6s+5ygYrokUQaSDo4q308wIaQSG7nixIiGpsTVZWTwhjHJbYR0pGAhEeT8kGjf3GFO3YfK3wenxzZQzI9pFqMbFgeG+cjgH+z3SfbaTLXXv/NoTBjiy6B6xHLwuzNqRMCsGC30M9Deyb4IDcLHjCfJ1XBqJsCR0vGobUmMv2/MsfKHsxdj3Y3DO0Vv6FHRIx9dVKMoTIGaE/ZC/oJ6NAj+T1ZFMp6HU/Om6TGHivkX3lVuHoM/34CsfxE4Zaq1isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzg5Z4lttCDS6E1CZ+16fNUtPu6nmdR+HVtqs8VRcP4=;
 b=D4tJMPFigm07E0mdbTAoNgGMH1VX3gkXWNkPgscvCviV5xKPOe77F2V9jz1JJU1eryrLSi+GDPqdOBOcnb4wUu7IbyRK8z5ccefnZPz9VMpNfUAcIJ7wQ/ak5ImyYmWY4ki0JAjetaEHBJRQCEOLKAGlNx7L+3qDXXKJVbU3+cM/ox4IBAHZYtw7WbFGaMhBqmTAM/mvN20GUWXGzwyRNIsXRZqwAeA+LnQHarBEqQr5IdU0dDNLGknPIz9mQuwp8DRJH6mHxC6DIRRDlwfqwmN6Lg7OOSyGARycNBCAatXEByoUGvIzm0zNfcygvZdt9q0Qos4EKDPkt3rja6HCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzg5Z4lttCDS6E1CZ+16fNUtPu6nmdR+HVtqs8VRcP4=;
 b=wO4osNJawr/fKFfJEo3YXan8bQyuUul17sevwO27GqLlt5WBd1oZPtJX6Jkt0SFj2unpcgEQRnhx8aWw7uL1R5QLSG5s9XxSTWxjT07jllKpzCoiBsbnmZCHWHUXFxXt/4mJ8PA/BOP9iYdMd9aj1UhBYGVXNfsniQsTDueZRRPtCFTAy/3Ik33EA2Yo0UGDw+ZQkurRIiWrIUAlPhXkqEhOsFJgGga5ZJ9GeTbfsMYHpDfnhMlFlubSVRn0C8BnfkXEE199VGBWxhsPeJNlkDoLQJkdVMGtnG5nmoZ4OpuGeL0T8WK9A8sa4A1piLg7jr7EaeWULbt9DnVBUFHwng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 04:59:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Sat, 18 May 2024
 04:59:46 +0000
Message-ID: <1565561c-70e8-4277-9d3d-0e1b4a40af71@siemens.com>
Date: Sat, 18 May 2024 06:59:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] .gitlab-ci.yml: Build for delta update
 when build_swu_v2 is enabled
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240517091834.1398975-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240517091834.1398975-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b784e7c-db6e-40cd-8c73-08dc76f756f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SGV5S0RZb3RIVGhQaEVFRlNoVm1Od2xNWGpleXhqQnJKcDZhdjdTOXliZWRW?=
 =?utf-8?B?ZjVGZ1o0NjNPWEFJUUYxcEVmNUU3cTR2SWhzQVFqR2lLNlVrUHNLdXhwTXli?=
 =?utf-8?B?cjJNRGg0ZVFudGdCdXE0c3V6eXcxdWhvemt6eGQyck4za1Vuc3RJdTdyaHV0?=
 =?utf-8?B?UHRmNVkxQ3lpYmNHcVJ2ZUdxOXFUNytDbWZGdGVpOHBzTDJ4VFRUTWJpYkNJ?=
 =?utf-8?B?YlBjQXNBdkNtZWRjM3BaVkQwZVJBZWJVbWZuYXNjRVNMY3pPQnNOSUJCUGNI?=
 =?utf-8?B?RWk0WXg2anQ5TDFEK3hZYmpzMDdkSWxrYW9ZY3dHOVNrNnBNZHg2YnVGeCts?=
 =?utf-8?B?T3U0UEhUTTdFRFQ5SmtuWGV6U2V5N3M3SHJOeFRDOWxUMVBVSmN3dWtxaitP?=
 =?utf-8?B?bWZjTS9VQWFqcHl5ZUJpckViT3pFWWw0blYybW1FS21vSVhlZFNJNWNpamF2?=
 =?utf-8?B?WHRBbFRYRUpySGQzZ1VJeGYraXZtUDdYb1JVWGRRbjBRaE1McVVLM1YvUjJK?=
 =?utf-8?B?d3BpSWEycVZWWE5ieUF1d2MydEc0U0c3UGpySjh3cGpyZTBnbW9BU0ZFR2ly?=
 =?utf-8?B?K3h0cTAvRWk4SFFXMVVRNFBlMUJBTzVVZGpNTkJDdzJheXdONTF4ZlR5YXFF?=
 =?utf-8?B?cCsyZ3A2cmdQUkt1dVlUSTNtOVNGVmdRZkZGL3paNTN6K0hoaTVTR3RSK2tn?=
 =?utf-8?B?T1lRK2ZVQXU2K2puUVNOTVYwajFvK0VzOWdsbTlnWFlzMERHU0VXV1hDVmd3?=
 =?utf-8?B?Qm5TQ2FGVkQxMDA5YVB2V0xOck55ZFRIcTFMdVRnNzdtanVBRHhZQ2JJRE12?=
 =?utf-8?B?aTZ6NEVsMVNqeHRadjNhSmw3ZUprd1plLy9FbXY5R09NRG1xNHdzc2tJbno0?=
 =?utf-8?B?RWZRUWdqeFJ3R0ZvZ0tlaWtVM2Q4bENONmczaVZGcEh6WVA5NlhaNGhrQW1M?=
 =?utf-8?B?bUlQbmhMb3JUMEVDSDM0cjJYNHhzM0h5Uk1RVTk4aUpZZDh5R1EwWWdqTHRy?=
 =?utf-8?B?N0NpZTd4aGhVWUZONFZmWXhvZE5jeVhia1pBY2FvWGpZdC9sZzJJQW5UVmEv?=
 =?utf-8?B?RUNqN081V1hMRDdHVDFBaXJIaFVTVGxhK1k0Y05FeWljQ1lYSTgrdEJ4eE9Q?=
 =?utf-8?B?Um5tQm03Mk80clNCZnNIUUNYR3VTY0tscEIrSXkrTmx5RjVncGF3L1hRME1D?=
 =?utf-8?B?SmNSaGYya2VwTU1wTEJWVDVHOXZkeDNmeUVrSEVXTHlud0dMYUlmYlpJTkcy?=
 =?utf-8?B?ZzBzODRBWjRCdk5mTjZaUzNTMmk1NzZEN2U1YWE2R0VBdXBxeUVNTUt5K3BI?=
 =?utf-8?B?MVhidGZXUnJBTHFKcFZBRmlaMDFrSmdxQkhmZllkYlh1N1pTV2NOb2F0ZjZi?=
 =?utf-8?B?bCs4eXloa2xoTEdVcmlqM2RQMnNuNmh0cm1qdXFtaEltZys4THdaNkxKQ05x?=
 =?utf-8?B?R1VGM280d2wvd1dBV1VCYTZ0VGlVU1pWVS9LanZGbC9FdW9NbGFPYkFBMW85?=
 =?utf-8?B?R3N2YVg2Y1NpOXg5dHNTa0Zub256akdJOGdUdHZOaGxwWFUydXc2WXY1Y3d1?=
 =?utf-8?B?N3U5VXBEL0Y2L3d5U3hDMkMyN2Y0dDFyV3NnUVZQS1pXeklyRmRaOHZxY21a?=
 =?utf-8?B?dmk2clVLclByZjQrTjRReUJESDRCTVpaZkhhdjVrcnNTeXBUeUF3T3FSUlFT?=
 =?utf-8?B?Mzl5WFFqN20wYmJRNUFab1FoSnBxNUlnR0ZtTG9sUmI2NmFTOWRTK3hRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEs4MHJEcTVjMFk2RHY4ZWdPVlI2MnNYbEV3UHlSaVJ5bkc0UEZSekJGTFkr?=
 =?utf-8?B?TVFHTFE5RjRuaGpIdHpsQXg0YWFIaGhyTC9VTHZvTTV3TC90cDBPdjlCeTJu?=
 =?utf-8?B?MGF6N2dlelByYVRUdlFqOXEvazZhdFhGS0FNc013aExsaHdYUzZGY1VCc3pt?=
 =?utf-8?B?dXdFcEF1RVZKMUEvSWsvVEs5VTU3TnhWYzR5dUJBYnIzUDNCa0xhR3FmZDM3?=
 =?utf-8?B?Uk9qQlJ5OGxEa1FxYmwzdFNTd2RHa0VUUERJQldzM3c1ZEdQS2cvQlhDQ0x0?=
 =?utf-8?B?WU5haTRsdzl5bVorQ241bXZZbDJTVExhUkxwTlRnYTlGenNYRzNFKzlNVXpJ?=
 =?utf-8?B?UHVFQ01GN0I4SkR2YmdBOUdETXRTUHlIbGVjM2dlOXNlTHpvcjZvcFY1eDIw?=
 =?utf-8?B?SlFDaitBRTNFZ3VpWXQ4T05lZE82YmsyUklkMHpIbmdOYjE1RUZJU2VHTU9H?=
 =?utf-8?B?UEFRd3Bta3RYMC91U2wrVm4ycEJYWUpXSFAzQ1JqTDROaUM4YkF2RlZxRDA3?=
 =?utf-8?B?RlFSY2NGTlk5TXEreksraE5mWGMrMGxaMHZoTlg4QWUzcEJlY1RjZXJxOVJu?=
 =?utf-8?B?MExWRjZUWFdNT0FWTldTeWdwYzZMbWJPR3lrVHFmMHZNVWNXemk0ditZQllp?=
 =?utf-8?B?bUVpSUdDYjJQMW85T0ZRVUFhcmRMaXBLOTBPNU9NbkhvZzVGMlVPRG50ZVRs?=
 =?utf-8?B?dUdnU2tNVXo0YnY3Smg4YmMwcXBlZTh4d1ZyYm52dGdEM2txbW9PLzA1MDBC?=
 =?utf-8?B?eVBqRHVMOXBzTTNTNmhqaG95c2VIelo5M0xKaGJZakRzYVFaWHkzTTlUREE0?=
 =?utf-8?B?MDcxQmw1emliMlNqdHY4c2p5MXMyUGdDUzlkZzlnQWNPNkgwUFltUG16Zndq?=
 =?utf-8?B?MGxxQTVHVGx1Rm1KZXZCOU5uWlpaRnFkRHpjQUVWMTUyRHVjNnZPU1dEU1VB?=
 =?utf-8?B?SnpPZ0FHb0RIZ2xJSkpoS2x4bDlIemVpM09Rd1c5UWJhUzdJS2V0VlZGQnpH?=
 =?utf-8?B?UDY2MTU3Rm1OT3gwbUNZVStRRDZod3M3YWtMZmk0ZmJyeWV0OXBDZDZuZ0V2?=
 =?utf-8?B?RE5zT0l0c3NjUHV5bTdicTZvZlczbW9MdTUvM1JyUlpUaWwvd3ZleERySUhy?=
 =?utf-8?B?dzFFK0E0b0pBOUxuTjlTTDdWeW9EdjJnWm9La3d5OGMwMTM0RnVaSERNcWJh?=
 =?utf-8?B?azM4cFhsWHd1eGtESkFZbzV3bFA4STVyaE1DVWcxS3FuQVZZN1IxRmQ1NW1z?=
 =?utf-8?B?OFFibXdkUngyd3lrVVVnem9IaERtd2dZdWVETVUyR3dQTUtyTjg1WUpTUElo?=
 =?utf-8?B?M2lVaGRTZjVoUm50dDZzdDlCSDFtSlRsbitObXRRM3BlMXRUUzYrVGV0N1lJ?=
 =?utf-8?B?eVBSUzZmM25rbGt1bTdkY0xidEozMFBGb3BFTGZQcHpJM3BTY2RaRGMwNlps?=
 =?utf-8?B?NFJ0aUZsL3hPSVFybiszcmNkUWxJZEVVNk4yYVNDMXcwZ0JxeDd2eTg5Rmpm?=
 =?utf-8?B?ZzFtVzJlSE10UTF1T2RHUkpOVVFYNS9qWmtJWlVWb2xqVmVFRFQ4Vk4zTmtB?=
 =?utf-8?B?UGJDaWFVdmFEcDFucStKbHY4OHlTWDVSYURycC9WVzZmVEhtTFNET1hBQ1NL?=
 =?utf-8?B?Zm1NSHNtZHN6bFZyMUdjVFl4R3VlZTNMSFBjLzlUeUlxYXo0SlgrSTM2TVFm?=
 =?utf-8?B?dmJtbmQyS2hzaVBkam82TDFnZEJEQjAwc0NudlZJZ3hETS9NbGRUeE80LzIv?=
 =?utf-8?B?SWxzSUw2RUdhK2c2VnczK29Xd0lIeDRXWWs3Z2ZOakdNTExwYWkvQVpXVC9G?=
 =?utf-8?B?Z2tFcUEwOWV1cXFiM0t3SmxuZ2ZxYkxFUmE2Q1Y4dm4xOG43Z2ZzMGk5ZFZS?=
 =?utf-8?B?SFI5RWtmTitDNzVWckNraHd6TklrVlJLN0JudE1QV0N1d3FWbHpVa25wTjJh?=
 =?utf-8?B?Wkhqc1ZmOHVaN05UL0tvYTVWWEpadWJEVHJBaUJQMlU4Sm50NzNhMnU4dDh3?=
 =?utf-8?B?bG03anZCaWNwMmZCUGpoQ0kvMEVqNS9kMjhhSVF4TE0zUmhOYkRKS2xoQUNr?=
 =?utf-8?B?akFGcGdhR1RvUDZpYTdXcHB6VSswUmRyQnBXYkdnM1I4eTJqM2RYL09sMjFi?=
 =?utf-8?B?a0laZi94SHlFQXNuWkMzSHRmRWtUTGhTdys3bURYQUUwYnFjMklKOUx3YzlT?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b784e7c-db6e-40cd-8c73-08dc76f756f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 04:59:46.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg/VQ5dUoj9xYfxhWJFpoYVA7jPvg8HUJbHErUWOZOS4aopHWdUEtb1QfGdOrkCXyGi9JB4dklUUbBzbECLYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 18 May 2024 04:59:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15917

On 17.05.24 11:18, Adithya Balakumar wrote:
> Build for delta update when build_swu_v2 is enabled in the CI
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index aab55be..2f88dea 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -70,8 +70,14 @@ default:
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
> +          mkdir build/previous-image;
> +          if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> +              cp build/tmp/deploy/images/${target}/*.verity build/previous-image;
> +          else
> +              cp build/tmp/deploy/images/${target}/*.squashfs build/previous-image;
> +          fi;
>            echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
> -          kas build ${base_yaml};
> +          kas build ${base_yaml}:kas/opt/delta-update.yml;
>            scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
>        fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


