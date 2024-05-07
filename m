Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A514C25B75
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 09:24:15 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.74])
 by mx.groups.io with SMTP id smtpd.web10.7362.1715073849495924435
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 02:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u4QRAYjv;
 spf=pass (domain: siemens.com, ip: 40.107.247.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk16ikSggUo7NAVGFYuV70YnIuiFSS5Bf2MFepXslns1evoLwZwoYCjgvrRcf3WitkMIFHrpF7GGDHhR43O43ARAeAfNhAvhxeGfPlPM+HzMBIWIHaHAG6ju2ipoQ/d07yjW0Bs/WlFpuWmJ27EUYWqwCWgjKC+vlVnFbHZZJVaNVppXnCU0d+dUoKLvcYzGM0u4oxVNc7NODPil8guN04p8Y4uTO5wpH8LX4PtzzyhaTWTUWF9V/7OnXEZcXV7WigXFtdPXoTwpCmiyoZIagirRq1T9igHNpYQF178IfFzwNAGhTzbshXJf1haeXTzjv4CldAuUPeg6IMgRQFFEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wvY1BUs/P5NqggEU6UfShhtyAfxwDhS09dtpZNGhL0=;
 b=XKcd6hotsTPNbaps2AAjLcKefdgYDagjwglVcyp0GpBl4Ya+27WLJTRWGBes30QVvR3KAbcbH+EO7iGV5c94m5ueooFhaO0qQMs+4Na3TTXhZFlcLYwKKLyHFvbGxwDCqO9PexGO1d/HsiRWBJNsJufhVpaHJOg1I2etcikTHZjvcviIdc1sxl57kF1eFwwZMFeYER91RnD9D51K0MyblRqiVH53VqUkJA4aoEBo1zQZOOLhvFLXIbqJo2HyTfOVXybSkIiZpZx6gOkjzvoS8F8ZUJCB/JQEpslo3yVM0wjTxmubBxp+7D2sve2WzLj8wDfEm+V8Cfj+8zwvpVn2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wvY1BUs/P5NqggEU6UfShhtyAfxwDhS09dtpZNGhL0=;
 b=u4QRAYjvTiYr8uzqzUoxwYjdvCVBFGYdUZ2T2LkikiNe8+y5AEnkzg4o3xsAb064go98axRbl5VnH1LVdpunhccvx+D4o+n9DrO8AbN34DSkXEcXfz/ffy5cG9DdDvOwyT7CBFoEBKodyANv6zpTct9VlTqoh+BbmUtB8AsOnvnGyF1FXlBWVgTxJ0E2sM263pDmZFNMC5yFBePMSUulC0B2tcCBrjFPsplRe4JUOPeEG/9UCdMVXV4D4Ry9B/vaCQTHTdRQFPBSWq1XF1bDqybC0WbB711/CaZKIb5Fjz77EdXh/h/gDuPmzo/wTRSlLCiEt/DfqJ06NH7Q0Zt8pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 09:24:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:24:06 +0000
Message-ID: <c50a9a6c-d3e1-45fa-830f-b5b49b8938b7@siemens.com>
Date: Tue, 7 May 2024 11:24:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v6 0/4] Integrate Delta Update with
 rdiff_image and delta handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 582d4578-6e6f-4b03-7aa8-08dc6e77713c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M3RNZ1pUVzZhcjhqK0NoeXgvZFlJeEdzSUxLMHJvUTEyU2ZNY3U2M1kyTmpH?=
 =?utf-8?B?SUNtcXliSHBZcVZJcEJ4dk5YMlBrUVAwaWhYMnBVeGVRNGpLeTlWbU85eGdJ?=
 =?utf-8?B?M2pVa1FrOGhLQUxPWnpYblptTWdLMHV6aVUyc3RnN2syNDZkK0hXVmowalFh?=
 =?utf-8?B?NmxobG8xcldLRkVWWENhS09ySTZZcERpam1HTDdxTFM3ajk2TDFuYU1aNHJa?=
 =?utf-8?B?cDhnZDBwVW5MVCsrazVDem5veG11T2xBSFhKeWtkbWhwZHR3N2lPV1BINHhr?=
 =?utf-8?B?emx6UkN2OWZtZHhuZXN2WHZJM1E2UFF1cHVXUWpFOE16MlhvMVk4MGlLQ0pD?=
 =?utf-8?B?cllMU1phUFN1MjZqU3l5Q1U1aVdUNXFNNC8vVFM4b0dySmlrV2gxRWxCb09w?=
 =?utf-8?B?RERhTFZUeTExbk9OanJmVElNUXgzY29jeHBDVm9BNmhMWnREcHBFS1ZaWWt0?=
 =?utf-8?B?L0U4d09jak9xcnYwUzU5S0VmZ0NreHJVSEZKa3VPTXNOM2tVais5Y1FwK2RE?=
 =?utf-8?B?bk5PZDBSeVdZdkpZazlQOEtJZzZtM0ZodFJGRzV2b2pGMVErSStpWHNvdSt6?=
 =?utf-8?B?VGxsbXgva2NIeTZsWldoNXl2NjdKaTc1dEFhZ1N6OWpkdGR4MzB1WnBCaFMx?=
 =?utf-8?B?MENROG5wWjNkVWhVandjY1lwa21VaXUyY0JkR2ExNEtaN3c0cUwrYi9IeWFI?=
 =?utf-8?B?RkYyZCtyMEZUS0NmaXAxajhJS3pKWmN0QlQ5SlBvZnhvQzRnSFRqcDI0b1pP?=
 =?utf-8?B?OE8ycWNWdm9maWhCRmUwZmhITFdIQzBkUU1mN1hLUVA0enBuYm43MnNGZ0Fx?=
 =?utf-8?B?RFJLWjMvL2dwTC9pbXdGVFhCU214V3RoV0YzNEhOLzZmMnA4ZzIybkw0WGRk?=
 =?utf-8?B?bkUrc1V6K2Yra1dUOXU5WTRud3BJYUhlQW5uRlJQeGZ0cEZaWWZld01OL0pV?=
 =?utf-8?B?UGpuTXpadzlPTWVyRHNFaHhPNC9vcm1FaEpaUHNnY1BJSnBtUjBHKzE0Uk1a?=
 =?utf-8?B?T2pwRGRVWW5WaTVURjVIMHdFeTBHU2xsd0VnMzQxd1BJR2hmTWtjMTlHbGNp?=
 =?utf-8?B?Q1hnZHZjNTh4SWh1YnM4aHh6aG5YcW5NaFA2eHFCVkJVM0pYN3RPZTRsUHZw?=
 =?utf-8?B?MmpIb0VjdTUyZlZWcG5NUEtCczBsbXFXQnJtT2ZTbTU5OTFmVGJwTTBFWThQ?=
 =?utf-8?B?clczRitsanQrdHNwWjgycXpZRlNlVGh0WlV6azIzN3VKMzJlcjRYRTFmUjk5?=
 =?utf-8?B?THF5ZUZvOVVlSUlObG9jYUNpYS8zQWhJRkI2aEhtTmUvNWthSjVwQ2dlMldh?=
 =?utf-8?B?YnFuenFUOFR3Y0cvUm10c25NZXJzRUtIK1NoZjZxcnMwTGxpVGU1dE1aanRW?=
 =?utf-8?B?d1h2eWF2MFZsaTQ4TXVld055SE5Kc3NTeDFPRmEzWFM1RFpCK3dBbmpJWjZF?=
 =?utf-8?B?NUdHamNmMENxcHhEWWNReThvZlIydGErWmVuNmp0VWVDVHJid3pBblpiS0dY?=
 =?utf-8?B?aVlaeW0rdUFGamRVbVpGRlpxa2UzeG5TdGpQVlpLYldYckhoelo4c0kzZXMz?=
 =?utf-8?B?YWxpbHAwRENNaWFGM2plaStrc3hSazBjbWMwY2lvY1FCaEo5WUVzTnVsUFdB?=
 =?utf-8?B?OUV1VEVUbVcydlVqWGxCK3Q3NmI5OU1IUkczYjMwSkI4NVEzbE1WbVJXejRZ?=
 =?utf-8?B?ZVVIT09FdTVSQkVBVk5OQ0VSYU8zUjVDV0tLbjZ2UWpsQzhzbWprUkZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHppb0huZ2FyUlJDb3pneStRZnRPVm8rQTh6YTdwWVdldjRzTVljUWlab2ZE?=
 =?utf-8?B?UzlXSXQzbWUyZDR5T2xFMDN6S2hpaTd4RnJHa2xkVnBabzRQZjNWUHNKeGxX?=
 =?utf-8?B?UlBXOGQzUG9BRmhSNWQxY1gyeXRCdVgwZm9hMnYxMWp4bGVQcHhoUHRoWlIr?=
 =?utf-8?B?QmxkcjYreW4xN0RhaGsvNHp3b1RyNzlhMlljZENlUjRWczA0ZVhsMmpZeW5p?=
 =?utf-8?B?WU1DT1lzQWRudTR2QXU2cllaeCtZM3VGMTI5NnAwaDNlT0tkSUswU3JxVjZl?=
 =?utf-8?B?aGJmYUlDQko3RnR2bmV2RG81Q3JGTC9UMlRIZEJXaWo2Uk03cW9vcDdIOWNO?=
 =?utf-8?B?UnUzWUV5WHJxNGdQYU1kWUFNV1phSEZpL2RMbFV0bTNNK2hHK2JwdENqcG5z?=
 =?utf-8?B?RTVjcE9UU2svT0JOQ1hScDJ5S1dEci8vOTg2alpoazFMdDNhSERlT0V0bFdJ?=
 =?utf-8?B?V29VdTdRQkFsKzIyeTROdVFFTGp2Qzhqc0RsOWZWVUE2aWltOGFLcEwvYUdF?=
 =?utf-8?B?MTZoTnNDNlBwSGJ6QkJiUkhRNHJaYXhFZ0lpV3dhU3F2MFBSL1BGNG0zd0Ev?=
 =?utf-8?B?RjV3cFdHaWtUK2tOVnU5Q0VvbWcxN3dvTmVKdEJSb3FVTUJzcjhXTHF6UUUw?=
 =?utf-8?B?Y3ltbkgyNnBERnVpN3JsdHZUd1N6cExEcTNrbm4zdTdqMm4rRitaS1hwMjdX?=
 =?utf-8?B?dmlvazA1c083bEFER0psalZGZVMwQ2pKRkV3S1dmSFdOODZ3TStsMjBlR0NP?=
 =?utf-8?B?MDhHRnM4SU9ORUtHWlA1eHpZQVovQXF0QXBzMVN6OStjbWpRUVl6b2hhNDdQ?=
 =?utf-8?B?WVp1L1pRbG9EUEtPZkJpN3g1QmxUb3ZxaGEyVDUzT1JYZGVyaW4rNklia2VD?=
 =?utf-8?B?YmtSNi8yc3RpWndyRnkyaGxwaytGV1F5V3pqVEFiM2xNdWZ5NHA1WHlzNk42?=
 =?utf-8?B?Q2dlZEZqRUxxek95L3U2dFJHeG1UOEhpaFNRdWZxV0ZGcjNYRWxJcHN1SXFs?=
 =?utf-8?B?YW83d3YzSWVFYTBNQktObDN4STQycUZSMmV3bnJTcEgxbWFFdXcreU1KQmww?=
 =?utf-8?B?MUsvTkY2SXVJanBXanRZT1hlQ2FKVlcyUmFNbmc1VXMvemM3ZjhuMGRrOVpx?=
 =?utf-8?B?MFF4NlVZV1ZtNkRHeVZnWU5IZTVjcnFJRytDdnc5dDNNck5FTWZ6a0xkb0ND?=
 =?utf-8?B?UFNGQ085OUZrU0tRa0FOdFNobEtoRUYvSWpVNDdhN1ArcklMVS83UlBDS3R1?=
 =?utf-8?B?L3ZtbkdLdjI0UDk2eXFBUEtXVHdlOXdVM1RzcTR2MjVKbVJqd2JDNCtoSmlH?=
 =?utf-8?B?TzZnRXNYaS9JSTJEWTNKWGNrcGMrVjdqMVlFcVBDMnRrOU5UVlBlRHI3NmQv?=
 =?utf-8?B?eHBRTTg0blFZVXAycWNCNWxSb2ZtOUErNUJOTU9wN1ZEbHcyM0RQdlIxYlkx?=
 =?utf-8?B?MUZHZTdPSHRKYVN3aldmWXJZbGVpTTNHZ2k5dlc4Y2s1S05DSVZxU2k2Qzlo?=
 =?utf-8?B?VHBaYWxxV2tHSzFnd242RFVvVmN5L3UxSVloZmUxWmZZOFdWUWNLQmxybmor?=
 =?utf-8?B?OG9Oa1BCOWRpWXRKUDlKbUZGbURoRFRTQy9Ob1lqcWNpUk5hTGE3LzEvQjJa?=
 =?utf-8?B?Q2M3d1VFNFh1NHRDZGh4eUhYWHUxZHluN2xNU1hvclAvS0VwYitJL0NqS1N5?=
 =?utf-8?B?RUpROXpXTUovajVUWHVkR3NqL1d0WTQ3N2h5SHVJOExDYnl2VFVOWGk0SXla?=
 =?utf-8?B?ZTVaQTdzZjhjYnJGdnk1VjQ0OWZnR2JmTjZlWVVXczRIOFdsT2RmaXdjYTdw?=
 =?utf-8?B?VEdTK1FnNjJZQUtxdW9vNWQvUkxmMVUxS3FMblZRWktHQkVsdUhwZlg4aTA2?=
 =?utf-8?B?VndZcE5SSmxlWUdiM0xzVHFMWjN2OW04NmVROXZaaEpWWTl2UDNUQ3I4UHd1?=
 =?utf-8?B?RkE0NExRdEpCS2hpMEVIc2JUYW40a0JlZzhNMlhiMTZhOGpXbGhXSW4yOFhR?=
 =?utf-8?B?bVhGZ1dSOTlJUGpDRWNzQi9jN2dNTkYwdDh1eHpNajlZdkhpNUovU2pYejlV?=
 =?utf-8?B?T0FGamZ4WmNhZFNDeXFoSVJHcE5rOENTbG5GZmhRbjQ5T3kyY1ZKVkl4MDly?=
 =?utf-8?B?cnlqcTV2eFdKMHRMOFBQZVlLdlM3THA3dHdFOTZQNHZ1MXNocDJZbFMxSkpF?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582d4578-6e6f-4b03-7aa8-08dc6e77713c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:24:06.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKXv9PXNouJiYigcbmzZL931t5gzJiFTTDiCPFOALa0IkZ4kgEzz8Mfu5ba5YZG/KUazIs36qsm3OhDjrg7AIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 09:24:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15855

On 07.05.24 11:14, Adithya Balakumar wrote:
> These series of patches enable the support for delta update for the root file system with swupdate's
> rdiff_image and delta handler(zchunk).
> 
> A couple notes about the implementation:
> - In this patchset, Delta update is only supported for the root file system.
> - The newly added delta-update.bbclass handles the creation of the delta update artifacts.
> - The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE"
> in the delta-update.yml file along with some variables required for each handler.
> - The creation of delta artifact for the rdiff_image handler requires a reference image (against which
> the delta is computed). Currently the reference artifact file (.squashfs/.verity) is passed to the
> build system by placing the artifact in the path "${TOPDIR}/previous-image" and setting the name of the
> artifact in the variable DELTA_RDIFF_REF_IMAGE in the delta-update.yml file.
> - zchunk based delta update is only supported for sid onwards.
> 
> Changes in v6:
> - Minor refactoring and improve error messages in delta-update.bbclass  
> 
> Changes in v5:
> - Introduce delta-update.yml file for delta update related configs.
> - Set rdiff as the default for delta update type.
> - Add delta update option in Kconfig menu.
> 
> Changes in v4:
> - Create only 1 .swu file, either delta or complete swu.
> - By default complete update swu is created.
> 
> Changes in v3:
> - Rebase to current next branch (61e998e1e0541e2713c05fcbf21df39fbc882a0a)
> - Set "${TOPDIR}/previous-image" as the path for the previous image artifact for rdiff update.
> - README updates to verify delta update.
> 
> Changes in v2:
> - Removed zchunk support for bookworm (due to use of backports). Currently zchunk based update only supported in Sid.
> - Removed delta-update.yml file. Related variables have default values and can be set in manually swupdate.yml file.
> - Using .squashfs file (.verity file in the case of Secure boot) for rdiff delta creation instead of .wic file.
> - rdiff is set as default for delta update type, the build system looks for the v1 artifact in a default path (image-v1/<artifact_name>).
> - Created a separate template file for sw-description of delta update.
> - Renamed delta_update.bbclass to delta-update.bbclass.
> 
> Adithya Balakumar (4):
>   Add Delta update support with rdiff_image and delta handler
>   swupdate.bbclass: Generate swu for delta updates
>   doc/README.swupdate.md: Update steps to test Delta software Update
>   Kconfig: Add delta update option
> 
>  Kconfig                                     | 16 ++++
>  classes/delta-update.bbclass                | 99 +++++++++++++++++++++
>  classes/swupdate.bbclass                    | 32 ++++++-
>  conf/layer.conf                             |  2 +-
>  doc/README.swupdate.md                      | 59 ++++++++++++
>  kas/opt/delta-update.yml                    | 20 +++++
>  recipes-core/images/swu/sw-description.tmpl |  5 +-
>  7 files changed, 227 insertions(+), 6 deletions(-)
>  create mode 100644 classes/delta-update.bbclass
>  create mode 100644 kas/opt/delta-update.yml
> 

Thanks a lot, applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


