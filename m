Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF51C5472F
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 13:31:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web10.78513.1724765480963687190
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 06:31:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y0TD3j35;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5L20FENvaF4mcvM4yFDy+UnICCwOnd8411Wpsc0N3HlYuCc1a0c0jICz29o5XTni1z7wycOzPJsbDJeNXLQnwRR9UinQX4yoUd/bzROLV5NcPrX9GqBt3qUOD7XtOoutbFaKJimKcaEewVqSUntd0kgxW09YGyBCQ6y1M+eyF2SZ1loBz7nApVF/ogSp+JrsC/0nGodtozzv5CBxSv0pg/clcGy/ZL5EmLyE9cxbIN3VKZhpl+LOOye2XnEUYOvlTeDvu6eeZRoQbhMMBqgUsSdFDURPXecB5xaMrc1jjqI3JVwGyrEmPHQzDtPF8r3hIFnDgOtUBG68IY1Ug4/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYEbDcGai1yPlZuepxgceO5M5sEG6VNBAKMGXv80BLY=;
 b=JkGVl5hApRRqe+iq6atcaIZ1ra7dq+0zK04fUPbuFs5MEhoN98Nf8YuJMiwLJyAQw/bqXlwBP3z0OMOwCKktdRUAXI1z1KYRLKNn6eWislmtMLesgZETgz2fFcLtOkJaiemOhIweLBL4BcyxQLm0tfpibnXwUnBdsa1ROxojp7ZxbK+SoPQdm8j/SVhy53ODntYZ9l8cCCKgPMjrYfNwKyeLnIHRZtc9eZ1Oea6wa04GOUcSWg6T2Ri/D09iXsKKPD7skFy5oxAfIlTK3fujwTBEw1hN/3nJxjgPv1LJeg4J5jGMYt3GmtVn08PtpvXU5tjw+PWhycTVZIMtdYOmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYEbDcGai1yPlZuepxgceO5M5sEG6VNBAKMGXv80BLY=;
 b=Y0TD3j35ZUIgoOkvb9Kcw1mEe+kBZsPo+Qjj8nZENTih0327ahnkAm0FvIJ5cb0mOoEoX1sdyTxPVD+5z+CvrA2WRWlzNw0tKAp2ds3xFJw4keDRHIp7Ah7gboGVD0cSmf+VdqNzi/2zT+NGqCa/L0N7JJFiPMW2qzWVz2rz82RQ0XHdKo3Q5Jj21I123jva0keo5H/fbNVtbkdwmntvYBnsnucZaY5MA/axX28mAI1ThfvFiiZDQf0mZmSSgvpXVQ1kU+BeL6+s+HaPfrwWsOZcllum/q2zekXoMlFv02oiDgpwSBWDJt0t1TDmi2KTh7s37ojgLtmeMJ2stDzVHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 13:31:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:31:17 +0000
Message-ID: <3d0967bb-328f-4d15-a9e6-d57f84e595f3@siemens.com>
Date: Tue, 27 Aug 2024 15:31:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] recipes-core/images/cip-core-image.bb:
 install cryptsetup package
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240827124407.810136-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240827124407.810136-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: b5661c84-15e8-4705-235d-08dcc69c8793
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azl6aW96UWdPb1o1MlM3dzFOZkZOY3R2YWNqMC9oalRsUTN1Z3BOZ05tbi9F?=
 =?utf-8?B?VnVRQW9zSTR6MEtmSUlqUkhybWU4OEtmR1F6OThLTlRBejhzUkVja0llTE1v?=
 =?utf-8?B?bENMR1czMkZsSDF1UmpLQ2VUM0o3VjA4Qll4QTRZbGdUTlpUNlBZVDJRUWRn?=
 =?utf-8?B?d1hKQmRFL2NpalVON2VZQit0dXBNdUVTSEd5U0F5bDFGaDNCMDI3enphUHJo?=
 =?utf-8?B?cWhIOThZVlhleStwYWtYS1A5R1NkbzkvcGRPaWU1VWk3T3YvV0pCdDU1b1hk?=
 =?utf-8?B?M3hvNyt5K0M2S2FaOGYrbkpxZ0Ficmw1d3ZKTXFVVkhIYkFkU3ZGVkxLdnUz?=
 =?utf-8?B?WjdzRjR4Uk42bm9lOEZSOXNxRnZmTlVCOElramo2Um1naDNMMHdCM3NjZ2hK?=
 =?utf-8?B?UWVhZ3NqL0pxVUtlVXo3ZC9UanZZdm01U3djWDlaNE9UT1NWOE1QNkV5NFlr?=
 =?utf-8?B?THhyWm1VL28zVUQ0SWJkUHZRaVkxWWJIOE5MWjAyVXBjaGM2SFJadUlYQm9S?=
 =?utf-8?B?MmlrT3RWd2JrdDNHTnBhV0MyVURuM3MrbHBYdm5TZEVqcXRLdXFBRHk5RXBr?=
 =?utf-8?B?ZUxkUS9qQlltK01pK1VkaXZvdTR6RllJTFYvMlFoNmFycmlZaExpcFNTaGw1?=
 =?utf-8?B?SnFOdlRsbzYwTmV6RFo5MDJudlVtbno2YWlaRE4rS3pkODVVeEplWnJManhp?=
 =?utf-8?B?VU9FenRrUnZpdTFKMTExcmRaUEFMYlk3eE9DSEFNVHhTWWlaZlBUVFVBK0Ru?=
 =?utf-8?B?R3E1WGlLSEMrcWZGWGdPdjZOZmVvUFJ0Qm83K1JmZ29yTXpsN3Bnd1VlYnU2?=
 =?utf-8?B?WjI5N2tjWkRWV3BtUFJsSW5WSU1ubjVabXZKMEtwY2doQVlHbEtQTDVhZVlK?=
 =?utf-8?B?aHEwY1RZeWF5SkFpYzhici9UeDUxL2EwNzdTVnhyajZtUGo2dURvcE1tN3dL?=
 =?utf-8?B?T1Juc0JBS2dndTZERzFRSTYzL2tNQ0liVE5wb3ptSUl0VXNrSkg2L2w3MUpF?=
 =?utf-8?B?NHlDdk10M3ZHbHJNajYxb2tuUENpVDB4cVQxbkRmV1VMZlpHMmpXQ0lqNm1L?=
 =?utf-8?B?Rm1pMlk4TnRkUVJsd0JOOG42ZzUwVzZSZ3VPdU5KaHFSd3hzRGx5UlpFcjJn?=
 =?utf-8?B?KzN5d1J5UnhnbStjeThSUFVMd05uY0VBdzk4b1JjelowUWpSRzFIdFVzNjJn?=
 =?utf-8?B?Tmx3VHJKTzRJK09yUnpQMW9jVWY1VVVacVA1ayttSzlBZzIzcWxFVllIalFK?=
 =?utf-8?B?ZmxpdjVvK3RGZlMxWFAycXlZeGFBK0s5S1h0OVljUXhKcm5oSWx3aDBwNWVw?=
 =?utf-8?B?WS9FRWlXUTdkN3d2WXR0eFkzVVJ1dDhadmF5eG84ZTU3VzhHZ3lWTGpCajNp?=
 =?utf-8?B?alJZMU5PMTF5bHBYYm5YWnYxc3JrejAxcnp1Z2ZvRXh2R014TGw2SU1IT2kz?=
 =?utf-8?B?MzBra2JWeEJET2RMM1FseHRHUUdkOGtsQlpheWJJWnlnQklrRmp2aWdUbXNs?=
 =?utf-8?B?Q2VPeHdjMWRsanA5c1hqOW42UHhyOHh4eEVzZzc2NnZqQ3J6dG5LUzV4VDU2?=
 =?utf-8?B?QXdaNCtYb3BtVjVTUGl3cmV1WGtKVkxBeDNWazVTNDJVMll5aUZLcEE5b1pX?=
 =?utf-8?B?Wnhhb1lDTVE5c0N5REI4Mmo4b25GYlFrNitZZ0NCeFJMM2dWZTZBMjgrTzVI?=
 =?utf-8?B?M1c4R0liRlhaZGdYK2NTNTJyU0p6cGVLTWlyQm1VdXArY2hxS3hWeU1TdWxF?=
 =?utf-8?Q?+yYFkzsk7v7ZP169Oo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Um90S0ZLcFhuR3o0UDV4ZVpHVjI0RFJEL0o5SVR1dk1PTmsvbHF0SjNjSUVM?=
 =?utf-8?B?c1RHcE5HREVFU25uRy9NdVlKcmtiWGtzMnZGeFNIZFV3enJmZTFoVzBnQmVp?=
 =?utf-8?B?bURhbGVSK3dDamtXbmc3aXdFdjNSR3o3OWQ0MnVrRXEwOGR6N2t6VzdFRStK?=
 =?utf-8?B?WkFJdGNOL05EQ1VST2E5RzFvcU54cnlHQ2NNdlJiNWs0QlFKeUx3dzlVVnV5?=
 =?utf-8?B?N1l0OFBaUXF4aDY0dnhQaGVmY05uV2c0L3k2MGNNcHpRK25Lbk54Tk83WkZz?=
 =?utf-8?B?bnVpU1I3V0xEMFFGNXRkVEZqSXV6MGJFTCtJcWhJbkpLdW9WVEh2NU1Gajlv?=
 =?utf-8?B?YVNTVXZxbmhGdW5YOUdtKy9jM0RxQnZhK0RXemNFei9wdWs1SDZ2aEZZYTM4?=
 =?utf-8?B?eWYzL1BDUzlDdCtRUmFJSVFSbUZhWkhmL3REUnRjZC84NkkvaERMK0F3c0Vp?=
 =?utf-8?B?VEZLaE9mYnlIdHRacjViZVNNTnB5dDRCL1NhT3VtU011ODFvMkl5ZTAyZG9o?=
 =?utf-8?B?K0loS3U2QllpclVQT2ZWb2Y4MHAza1BqZ3IzR2pUZHBkSDlLSHhPS1FSaXJB?=
 =?utf-8?B?dDZaM2FNZmM5cHg4amxMNi9TR2ZoQzRwcnhKWFBVU2s5Ym9JWEZUV1dIa3pL?=
 =?utf-8?B?eWg5R0hteG1pUFBVWjBGREdOS0V4UGxxOWdHdDJLQW5oN3VOdTBkTThKbVNB?=
 =?utf-8?B?Q0h4Ung0aDlZZm5hZ3lNT3ZSYW5mOTVFT2orbzhLWm9LQkZUSHVCQzJHeUo1?=
 =?utf-8?B?YzZ5T21uMitFVjg3eTVFWDUyTTg5MHF6YVlGUFRPOWlUcHNJdFU5RFZnTlhK?=
 =?utf-8?B?L0hoOGhzZEdKa1RaYkVCN2hwOElCVXhOZzJjZCtscmtDNVA1ckJDTkd6OWFY?=
 =?utf-8?B?Rm9PTFYxbkt5ODV6S3dCNWt1TmlaU0MycXlrYnR1b3VpQnN5UEN5WDZvUWlK?=
 =?utf-8?B?dENzQUczQjhpRTErMlQ3T3Z5aUllUDM5N3FGSWFjZFhjWGxiSllvNlN1N1VT?=
 =?utf-8?B?cHJyTnczZWRQUE5XaEdOL05ZZnlITnhnRXhFd1BkOVFqZGozS3dWMW9oem94?=
 =?utf-8?B?bnQ0cUJJS0pUSlk2VzIyQVFxaWs0bWtyQWtmdlM5YnNwMUpqVzhCTldmWUhl?=
 =?utf-8?B?ckZnenMwdE45NkVFSXJPRVB4ZkZDSUd5aXpHS09xWndRRDRqZkNGRENqUVUy?=
 =?utf-8?B?NWd0a3U5TFBuRnJ1eXhHbUlsbHl4Uys4Sk5USTdZWllvV3dVNjdxNm85bXVW?=
 =?utf-8?B?cWg5N2N2ZVV5eVUzNXBsZmw4eFFsSDEzSHJvbVNONnZrZWxoc1I0NlVVNGlS?=
 =?utf-8?B?anlnelFnOGdaRjJiSnhwUVFMbTVHc2JTSUgvbFdWeWFyeHZzRmJLdHJZSy9W?=
 =?utf-8?B?bzhQTW04c3dxRVNrRDRuSVdYS0k1MG5ReWszYWowUTgrNGhveVozRUdSRzlz?=
 =?utf-8?B?NHJva2V6d2JJcTRpNGtUOFNTd0Q2eDdqL2grcEZmYTRJbkpkcHgyMlhPUWUy?=
 =?utf-8?B?aGxaa2ozY2xyRFZKVDIwQzR3Rm5BZkV1bFI1YmhFZU01TjZIVGYxcFJ2YStG?=
 =?utf-8?B?UzA2aVIwNEpHVk56SDJYK0ljN3ZxR1FSSnkzM3o1bm1CWkRXZ1E1Q0ttaWlx?=
 =?utf-8?B?NGxrSDJ4TTJlN0lMM0J1R250N0JRVVc3TC9XS2dSNXNIdzE4c3YzVjdxaWla?=
 =?utf-8?B?MTAyeUVCMUtCaFJTalRyYmxhRjUrQjFwZG9udCtyTlFoMmxFQTBEOUVWZ1RN?=
 =?utf-8?B?czVGNC9RZWsyYkdXUWxSQU9vSUxsek4xQlQrbjJUaldIWkFrRm93ZGsyd0Iz?=
 =?utf-8?B?ckVnb3pNV01PK3pKZk1rVGhGZ0NmY2luRXlmbU42L2lROGMzQUdNSWZPRlNF?=
 =?utf-8?B?L2ZGZnByc1RvcnVOdi9uekk4MTZWUW1ZcThFRVJ3QVg5VjFNWmQ5N1JuYmls?=
 =?utf-8?B?SnZYVjVzT1FvZFRKMVY4WjlCbzMwWjFKbkpGVW1jSlJMQlpOby8zS0dha1dY?=
 =?utf-8?B?MTNWditwTVErMDhsNFJTWG80VnRMaGMrSHZ4ZjhkSnA0d2hYdFNaMUxOdk1h?=
 =?utf-8?B?WmhNNzV2M2NmTHNuY29wbmx1bXREVlF0bzI0YkR6dnpKZ2xobjZ3NlBKZ3J0?=
 =?utf-8?B?dFNzdkhrdzArNitDemRhS1A1UG01SEZ1RzRSc2FsQmt4OTIxam51VHFTenJY?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5661c84-15e8-4705-235d-08dcc69c8793
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:31:17.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLweqCAcJEVDWHE/Ysavfp4+3SE0lbywT0Tx3DgI5ej4nSHRPn4hZMGwbq95qoDvvMbhpo5KU4ob0Mk7V331mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5983
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 13:31:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16816

On 27.08.24 14:44, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> When we validate expand-on-first-boot with encrypted partition, the last
> encrypted partition is not expanded due to cryptsetup package not availabe,
> hence added the package in the rootfs.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  recipes-core/images/cip-core-image.bb | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 4a9cea9..28f5f3c 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -15,5 +15,7 @@ DESCRIPTION = "CIP Core image"
>  
>  IMAGE_INSTALL += "customizations"
>  
> +IMAGE_PREINSTALL:append:encrypt-partitions = " cryptsetup"
> +
>  CIP_IMAGE_OPTIONS ?= ""
>  require ${CIP_IMAGE_OPTIONS}

Please see this thread:
https://lore.kernel.org/cip-dev/20240823161906.1168642-1-alexander.heinisch@siemens.com/

Jan

-- 
Siemens AG, Technology
Linux Expert Center


