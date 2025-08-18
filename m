Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B8CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:49 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.web11.79803.1755533923859648190
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B7B3Klvn;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvMGWSzZMSyoi0MgnxqOfqklZAvTvwv1PcX2bl2sReaFou+xhVRm1susqkOI3PEfX7S5x7AC+oqpsoPhxfHHr0F1QcZZjamXJggDXBIDFhbHOoZGdIe49OhSd4EUs+Vs/UWLeGJI/M/3GMwuFi+qUeo4J9pkMJa7K+UsYdUHb4c9+zTSxabtOOmyFQlniiyOnnjkTo7GpyqRwfTpYk/NLljcdQLxknpUf6XWoosnpmHG95qWTfRbtbMx6joklrMBCDhrwFrsn/VX1q5Pfna0I3CnHhJ/ee33dNzTlsZbii1fNy9XG9XduqeW5vEKfXpJFJCfoJRa68sFLVuN8WckKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4omJw2Krb2DgL8rW24PIk+YlZF56T9Gf17fVwV8sKU=;
 b=FOsmp2CWLPaDczxd3BCC+g6eus6TWzexxEtZVS/IDE/0xRkJpjvrEFrHTlQFVtfFdfgm5gt5VwYjoprxnc/HseU2mC8MI/3SVJ3/jwNbFFs5tlTWw0VGdo7+GOQdhb6MRMJVr78qsfqfFvWC0vqHQNLBxvhEGjHwVCrNXxQ0KK8duel5Hbqv8lrvGWIhY9PEMG+VLOFkSSfH7jZib324ehIU/LFMd0sBnk3Tegj7fNZh5sPbp7cnv7QbvNXKUBC0LeUeijQKJcxZpOKBOzQwero5ARHZt+vWGR8UfWnIZzjYXW+eKg14bNhSH+VkJln4/2jvkpK+/zBXxuePfMwIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4omJw2Krb2DgL8rW24PIk+YlZF56T9Gf17fVwV8sKU=;
 b=B7B3KlvnJTWdi9gII84VbjPLVBioj3zwVptrAlRYGjhz7rPTeyhCc8IRBQv+wo0WDhcmttZwkFWLsY9/B8SBux+ffyUZ32UDBC7/FtkEYxLHsd4yFwBM6Vt3JdvOAvGLkv1U/0fvigOOEm+JC9RqtrSIlptWvoVHBuT4+n9l5Lx6QDtfUZyIQfC83D5voMbzTQ22TGkZBnJuuRrUvP/P0reYYBnIpGl9Er8H2wSwI6Ys5kwRqGUk2W4q8vkC2ptSGhAE29nDc0iuW5ukJmm+RcFVb/KcBTeAc9mT6zCAvaAar2rJGnyujXZNhv/vf+ybW/VYoNPS0lhLCfOpAKf81A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:18:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:18:39 +0000
Message-ID: <bdc68a14-5c48-4b15-bdaa-d8f9bf3403ff@siemens.com>
Date: Mon, 18 Aug 2025 18:18:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/5] Add support for delta kernel binary
 update
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da8a997-75b7-434a-7f99-08ddde72e485
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c2YzR0R2MnQwdHZ1TUVIR3orUVl2SnBpZ3A1MzR4dllBSG42K2JuMU1ubGtL?=
 =?utf-8?B?MHZoRGR3YkN6aVo0TUh3SnRUVDhFaitONGIyRy9RcWNSSllpRUwxc2JoWUpl?=
 =?utf-8?B?OWxhdUd3MGlpZ2U2WlQwTk5KWnFIRXFFUkFqQ2hpV3gwVFJ0NUlXWVJLbHRp?=
 =?utf-8?B?TEthbFI2a3kxYXpSNnkrSjN1YU1PcnRwK1lBUjdXUTE2NnJQMVZrMUxsbVkv?=
 =?utf-8?B?ZFpjSTdmWG9JU2ErZzFENDFYV0wzM3psVGRjQnRzZXpsRFVlc25YWkRxWFRS?=
 =?utf-8?B?bWtUdmhSK1c0cmlQblYvcFNHcUhRdkFSa2VRWm5CQzhjSjZEV3U4T3ptR004?=
 =?utf-8?B?UVFGelZtTHErZ3pROWlRSjNHcVhaY1lrSGEwaWU0NGtSOC9LUzhPUE1HSE9i?=
 =?utf-8?B?TmNWQWlaK3BWQlhTd1VCUlRBc0hUY284c1UwOFpIWG91RFRGSE1uNlU3VlVK?=
 =?utf-8?B?N0VYR2xKajhHYjVnMVpIRjlvT29iTUpEVlpiaElGeExLS05WK3dOS01CWEVY?=
 =?utf-8?B?eGZsZzJwQnZ1VXBKTVZnK3pWTkhUNTU4L0dRNm9GVE1lU002M1FHVEtvNWhM?=
 =?utf-8?B?S204cnZvcnBiT0tteTY2NGhSekJ3OEh4RVFjMUE1ODUvKzVwRXZ1cC9rZU9k?=
 =?utf-8?B?c3g1QzRzSFJjUWJaQkRQWWpqZjFycEZoaW9kM3poYUdtamxTR2VkVXI0ditu?=
 =?utf-8?B?WEl0dEhvNTU3ejVsczlyZXcrSHFhcWxQNU1EOUhwZFp3NVlIUEtTOFBPTE5M?=
 =?utf-8?B?RVppN1pnV1FGNHhNcHJPaWJVRGJKTml3aFF1KzVwUjMrWWNEcTR2clpHWGRP?=
 =?utf-8?B?WkZ2anlYS251aGdINnh4dXNHaTNKbDhWcEJTSVYxTHVXeDluMnBxcDUxSVVv?=
 =?utf-8?B?dXpqNTgxS2RCTmVtcGFjdDBUUW83NWVqWTVwWUdaY0h0N05mWllJa1VWYlFQ?=
 =?utf-8?B?ZTdRdUNWVndTdllNVlBEUjh5OG9MUUJUY3FMU0s5KzNhcGk4b1pRUjBDUnIv?=
 =?utf-8?B?ZzJ1ZzJaQjFsT0VmUjAvNmYwMW5GeG5PK3JEbGNnZFBmNUowMXhIQ3dIUUlT?=
 =?utf-8?B?bTViUDN5NDFYVjBjZmNBZFdiWVBpWVZWdHpESkdjaEdkemhlU2U0Zm5xblR4?=
 =?utf-8?B?SER6S3Z5NFV2MFRzVGhvcFlNaGFOOFZYbUxOSEhiajA1UGZqMFNQRENOR0k4?=
 =?utf-8?B?WUt2QXVpTGtGbzV5aGlCRVZwRWdHRmlFdTl4bFE3N09OdGFxRGtkRTRkSkts?=
 =?utf-8?B?S3Iwa2pFc1hoMGV0eDc4VDQ1ZWszdmpONjRPcGpqSkxkY0l1dWJqS3lCT0JJ?=
 =?utf-8?B?ZFFYZTE4TktRRXEyQVVPQVhCNGdsSzhVM1VDeFFmaitYVEZUbkdNaFBYL0NR?=
 =?utf-8?B?K0xDb0VtRUZFaTkwTUtCdmVXQnYxZzZqMVFzREpLMmgwNU03cGh3UmFQRzNr?=
 =?utf-8?B?dGRTWnY2MFcxRUNMZ1VMNUFiK1Y5aEZ2L0k2c2ZJUDNLUm02Ym8wMFBWYm92?=
 =?utf-8?B?a0g1YkdDZTk2UlZPd0IzbFRDT0xObjZCeGh0ZXV4bjM5S2hmLzJiV3pQUTJH?=
 =?utf-8?B?MHRjbDRMV1A4YUJ4VDdvdnlnd3cybGNRYTJwNDhXVWgzaGVuTEtPdUhTOGZi?=
 =?utf-8?B?bFlrN0pjNlF6OWhIaFl4WThWWnhWUTlKek1udmJ5a0FYME5jOFdIWjMvcjJQ?=
 =?utf-8?B?NGdldWEzWndHcGlXM2tDOUt3WWEzdURab3Ryc3B6ZXE0bTdCRmUzc2ZlaVdm?=
 =?utf-8?B?THJsNFY5ZiszTWFrMHhhRFBOWEp1cWVTM0xjOFJBUkRkMnRLWkNsRVhqUUMy?=
 =?utf-8?B?cy85UUxHY3E1K2M3b3FXMDlDZjlHMzd0UURSYUtNZU9oNWw3Q1ZzbGR3Mzdk?=
 =?utf-8?B?SEhzK0R3bloraXFLVjg2K2ExOHVrL1pQaU5wOFJPc0dBYXhjSFRYc1NqdVAv?=
 =?utf-8?Q?j21fs4zcxFs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkJqR2RVWkFqdXVzNDNCdXlVQzVabDFYV3NOZSsxU05zMHBlZEgzSkFpNmlU?=
 =?utf-8?B?eE10NE1xNG1ZR3ZvZDJzcW53YWxORStkbTBOVktRdnJ1ZnZLMm12aGNnV1RH?=
 =?utf-8?B?cS96Q3ArNk5jbVE3MEd0VnlwZnlzM3M0WUE5VjNhZzFPc255Z2VYV0gxUTBz?=
 =?utf-8?B?ZHIrY0xMVERaSmNKVVZMamdmTUVHbXRERXBhUTljSVRxS0xPMzgvY25TSkVN?=
 =?utf-8?B?QUZ5aXJJZmcxTWgrd2pldVp0RUszcVFNY0NIRG94KzlMTG53NU16WHoyODhV?=
 =?utf-8?B?Q0dqMHh4K1hUSEc5S0crbGl0Z2lwZzQ4RWpYWEZvV1RUTm5wcVlPWE0wb29C?=
 =?utf-8?B?UXNObjZKdEl3MVZYUEJXdWhOd3ozYmZxSk9ZMkNac2RPN2lOcW1yUTV0NVhF?=
 =?utf-8?B?U3pRRmI4WUc5L2YvS08zZC9sQ1YyUHZuVjY1L3hnb0FwSWZ2UDJQSmZ0NU9u?=
 =?utf-8?B?b2NBdlNoQ05QMlFBclRreW15bDZlN3o2dFhCV3ZCNDNkSytpNVpSVi9KOXN1?=
 =?utf-8?B?NFp5Q3BhTkNpZUp3OW1xM0pwNld5NmxhZ1lzZUhyM3hqb1VKZDJmTWpkUWRq?=
 =?utf-8?B?ZDVwZUlncHRWbjRqQ0M2SzI5OTlXM09rd2NxWDN2N2ovakhaRHFkeFB4UDJn?=
 =?utf-8?B?MDlMVTdUUGlJTVBhazkzbWxWa0dxRG1ybURZcnY0U0lRT2x3SDcydGJDeENL?=
 =?utf-8?B?SmhjK0dLaDFKM2RnVVZTK244NzhRU081aklRQTRQRVduSlJsekFJUFpGeUZ5?=
 =?utf-8?B?Tmt4S296aTA4bmhLN0RDSk9YSytCa0xBMlRVeGhGZkF6cGVzK1hXV1I2ZlA3?=
 =?utf-8?B?SjltQWEvSUFmODVFaHJyRVNoeWVlZkVoazhiUWR3N1JtZllnbHM2aW5NMFNT?=
 =?utf-8?B?L2dhZlh4ZnNmL2dsSnM4RUhrM3FDd0VDc2NjaFgrWG1KaTQ5b3JiK1JwMk9m?=
 =?utf-8?B?MUhFYXFiMDEyWktDc2RIK29sWTh6Tzl4M3pYbUdsM3hqdGRWRTdPQ3orZHUw?=
 =?utf-8?B?YVJLSDJlQm1SL3J6OGRKQWxmYU5BcG1QazJqQU5iV0lDSG00YTNENnF1dkdX?=
 =?utf-8?B?NWZyOCtrVzRtTFJJM25WQlN5MVZ1a0JXVDM0NXFMR01wZlRHL3A4Q2NVbW1D?=
 =?utf-8?B?aTNuZnpBOGVtajBIM3ZDVUowQkUySmF2bnc4eVEwV0ZZRGZkV2sxRWU1NGlU?=
 =?utf-8?B?QmttNC8zVlNJeklYTUE4VG93SkpmdWs0S0U4eS9DMytoSjNwQ2EyNWVGeXNC?=
 =?utf-8?B?cWducjVWLzJ5YTdwYnk4ZDRjNGJXNTZpbExuK0pQNm1mU0dDN0YvbXJ6bk5y?=
 =?utf-8?B?UnR3R0FxMkFLL1krR1JVemJCaVJqRGladW5pRjM0T3pqdEsrWHFYOU5nRURE?=
 =?utf-8?B?N1dONUFyNHNnNWVQaEwxVDFSb1VNc2s3Y2I5NUdJUS9OWDhabnp4SVVoZWRF?=
 =?utf-8?B?cUZDcC9ETjA5NVY0SGxXSjhQMnloTG50SjlRd0tSTS9JbnhFbUc4QTBRNE5B?=
 =?utf-8?B?cjRVU2VVenI0djlNVDNKMEJGTE9wQWgxUDIwNU1zRFpiTlVTQ3hTL2ludEZw?=
 =?utf-8?B?RU5nWG50K0ZJN2VVeTI5R3JoVFlUSDliVkRIblArK2RTK3Qxc21WdXVCMXpL?=
 =?utf-8?B?elV5eVQ0RlZFNTRkVjluNEJLUEVRTGxObTVFQkNuRVJMSHF3cDJvVHl4VHli?=
 =?utf-8?B?Mm0vN2kwcGhTaUtVZ0tDWmlXcy83bXJPc3VHdE1YNFlZc3AwQkNqd0c5d2lu?=
 =?utf-8?B?R0llUnlNZTF1amFIYW5Oa2F4VmM0OGEvL0VPSWlkNi9QcG5pdjZOOW4rT1JY?=
 =?utf-8?B?bkxlUDhUclludklOV1dEY0EyK1JhdHNqbGdic1BLVW5HRmtZbDdLWFNJVzZj?=
 =?utf-8?B?cDN4YnMwQWozaHNEOEhObHkya3VBelhwMGM0cFVGWktEYy9nTVd4cFRsZWhv?=
 =?utf-8?B?Mi9NcC85Y2JMQ0QyN1BYNVQxWG5RbXhZNm9lK2ZFT0wxa2dBdDBNVXM3SDl2?=
 =?utf-8?B?aW5YT3BURGxuOUtaRmhrU0ZLenp0QVozMlEzdVo3dEpMT2pDZ2xZNmU2WS8r?=
 =?utf-8?B?N2s0OVFCdjJjV1dEQThMWGN6VnpBVFpidGFnekE2V0FxeUVNZ3U4ejl1RVZ6?=
 =?utf-8?B?VGZjcFp1dWxiUVh6RXk5REVVSDRnVTdrSEZmMjBDUFJIOU9VdkVtSFFUamRT?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da8a997-75b7-434a-7f99-08ddde72e485
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:18:39.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3Twufg2RORT9bGoG1Uo/AneOnLGzJs+4887qK3cUo8TfFVEcdDe+iMSuLVTK88f0o4ky5QpMLLwz7Fchr7U1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:18:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19756

On 14.08.25 12:21, Shivanand Kunijadar wrote:
> This patch series enables the delta kernel binary updates along with rootfs. 
> When rdiff is selected by default it generates deltas for both kernel and rootfs.
> 
> In this v2 series, I just re-ordered the patches, no other changes.
> 
> Shivanand Kunijadar (5):
>   swupdate-handler-roundrobin: Update revision for rdiff_file handler
>     support
>   delta-update.yml: Add previous image kernel file for rdiff delta
>     update
>   Add delta update support for kernel binary update using rdiff_file
>     handler
>   .gitlab-ci.yml: Add linux.efi to previous image folder
>   README.swupdate.md: Modify readme for kernel binary delta update
>     support.
> 
>  .gitlab-ci.yml                                |  1 +
>  classes/delta-update.bbclass                  | 33 ++++++++++++++-----
>  classes/swupdate.bbclass                      | 24 ++++++++++----
>  doc/README.swupdate.md                        |  9 +++--
>  kas/opt/delta-update.yml                      |  1 +
>  recipes-core/images/swu/sw-description.tmpl   |  7 ++--
>  .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
>  7 files changed, 55 insertions(+), 22 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

