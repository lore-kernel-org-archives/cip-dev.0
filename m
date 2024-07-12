Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B067C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:17:50 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.89])
 by mx.groups.io with SMTP id smtpd.web11.2611.1720768668364584855
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NVuRFByE;
 spf=pass (domain: siemens.com, ip: 40.107.104.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwG9M36QnzhiHHqhB+OwYm5Dwhi0gHL50TBYNUSkSlvExZ8TRKc9xnq9m/X578CegOwqtt6gmr97YKXN1S4DX9DRsv7K66eZFQioYg+ED5ROUl+OH3NNUmSNNBoXaAXF3kiwl4IE1hU67SyjLOOjNTveI4JxksdGGrgFJ464TcOV83kGb/+REm8UvNagw+aNGjoHE3smT3JUfUN6WKk3nDBLeurd+r8daedi5XxLrInBNlAZtoC4hG/kvHhwz8/dAz4EeyKMXkf4OHM89ntaRS5zP8h0tsxmE8WjSYgvoVj50cgBi++nS5gGqNVuUeBPKDDkB44PAVcpDouzNxz22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvglzskF/6C+rWcpl3vlIAni5JnasNjV2bMEIim527M=;
 b=RTTL+F9tdOBiDQith0txsU1hO7uaMsGCFl8hHtKWrLXnPXbYjkqhqXUO9yxiYHyR9MpJyeAldZO9hv/DPrFIXp7UdU4iy8NKKooGSfeA1epkkxjmY+i0TEkn7RVSOOit/1JsThKnzXS+Uu+QKQ6GGProRacuLuY1RJWotw4eK1FSc4E5CyjToprxdehF3otX51RB/BnbcLSot8tuRuYBnpMkYA2Y0JQ2QGEoFilvDmRW6CLKgoyE7Gs5QVr3gIZcrDwVJq4gaiWyM7LFQ4A2I3uJqWX+omJMSroZ1jSSKLH/EydqCt/FjPcTYmnHXwFiWFLjdeErDoVh0bUhUWstow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvglzskF/6C+rWcpl3vlIAni5JnasNjV2bMEIim527M=;
 b=NVuRFByEE/n0E3m5eIor3464JipsFAohNZIgA2tsWrbYSvr0C66U1y2Bw+vmmPiCm1hup4hbO1jKxa35xii0pfdwQJeMNMe+j5O4NZvVGMKShO/0DLGKFioS7c1YzeiDlNtTvV9MAs/aUEMdY7NiXizc1fLxEz59y3Ncv5RUrwDkEfASh5HFqLYXIaBOyHCaewXTKDl7MW/WRChdTGb6ckkSuTUkU56CRct7NIeu/29ybriUn6tT84RuUoCPhydcO914dTi6SUqwdg4X7FlsmNDJSVkKL66OL5Vc6TlyuW7NmfXNd+5bhgXHHbuDnXdhZSjWvcN6P0s8a/PBUEqDPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:17:45 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:17:45 +0000
Message-ID: <83537631-7a6b-4d9c-9c40-3b992c05adc4@siemens.com>
Date: Fri, 12 Jul 2024 09:17:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20240703114242.1896508-1-ch@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240703114242.1896508-1-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3353:EE_
X-MS-Office365-Filtering-Correlation-Id: e098b2f6-154f-45ec-f0f0-08dca242b9d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Yk5lbmQ1b20vakk1R09lQi9NTHVyUCtpWWZIbWNPeW40cUlLTTVVSlRURS8w?=
 =?utf-8?B?S2JUZldWYklEWjh2b2wrUXZlYlJZV3AzVUxqNkoza3J0S3RoajJOeUpoekNZ?=
 =?utf-8?B?bUZKWStFY3JlaEY0eVdjTUw1OEhlcHZ4emUrRWRkTFNaYm5VdVFBRmI2eEVW?=
 =?utf-8?B?djNvanFQOURlYkpXRk5oc3hkOW5ZWThSK1FVc2xLeFVKVDZXRVpCYmxOYnJY?=
 =?utf-8?B?a3ppZHQ2UkpESWltTWd3LzJBcGxSTXpndlhSSk5hZkRCeFl1RHNVNnl2Znky?=
 =?utf-8?B?MXl2NDdBSG9abFZ6UVQ2TmNNUkNhOHFFY0VGZkdtK1hoSkpoQlo4Q2ZYazIv?=
 =?utf-8?B?R051dllVeklKck5XR0haaHo2Zlh6bTk1aElXdjhCdGo2aFMzOVJlWVZkTHY3?=
 =?utf-8?B?SEZTemVJM3oyb0NKNTdOZGJqcWI3RDRpanBYRWtxb2VDOTFWK2JDME1kdG1w?=
 =?utf-8?B?RForWDZ5QWhFS3E3OFkzY0NOV0xlWW16bVpvQmdrNzhWR0FnWUFUZWVzYlZw?=
 =?utf-8?B?SHR1S0tRWDlVZDBUMmI5ajM4SU0zV09JWHJHUkhUKzAvUlp4ektuUHRad0JB?=
 =?utf-8?B?TnpmRDM5QWo2aUJPWUZuajBkMDIzakdUNmZXTDR0bEFvbHBXZ3lUbE9UK00y?=
 =?utf-8?B?bHRZWGdWV0FFWWtqaUZ3dXUxYTNneHNIZkVxUWozeWl3QVhLUVlNK2pQa0Yr?=
 =?utf-8?B?bURtOHpSTFpOMC9vKy9ueXRPMWVLcTNhb21OMFN5STU2d3V1SE1aMmwvMDBi?=
 =?utf-8?B?ckMweWpBWEg4TGJwOHRaT3o0S2FuZlN3Smd3SVdTb2lpa2VrSnpuQjNSclFD?=
 =?utf-8?B?L3Zjczl6NHhJNDJ6V1M1OUlFanlkM2c0K0NtQmRCSEpqVkt1MjBucnVZY2ho?=
 =?utf-8?B?Qk9JblpIZmhyTFFMWHZHVDZ2MFF2UFA1Qi9iU0NJYlRHVUROOWk2OGNQc3N6?=
 =?utf-8?B?VktnMjFJcUxQaXA3Q0NKS2p5aVJ5cEdsZHNLd2RGdVY3Mm9pR0o4SXkxV0Z5?=
 =?utf-8?B?TEs3ME5LUnQ1UlQ0d0lFa2JWbzZGN3h0ZmlPRWJCMlk2SXhXN3R5NHNpSmc3?=
 =?utf-8?B?U0hIenFuUGQ0WHlJY001dklCdlBSSkpaa0RLOGFpYko0RVUwOEJFVERpQ2hx?=
 =?utf-8?B?bG1MUElCdUxIUVk5aTJwN2NDdi9rRTlybEd4Z0EzcXF2Ym9QNzVWcy9Oejkr?=
 =?utf-8?B?cm4xRVJzVTdIMUZjMVZpd1d2ZlExUG5qTjdDbElRYnI4QlBWbUcvV2F1YU8r?=
 =?utf-8?B?R1cxRGpLUnF0dllCNkJtaWcwTDVZSDJDYzMzby81dXFablA5OWhSbkRLTTVp?=
 =?utf-8?B?b2U3T3ZURlFZZ0pRU1ZUMW5qUTdDdUZHVGE5Rzd3azR5SjRZNS94aDRvNHdX?=
 =?utf-8?B?SkxmUmF6MHdCSnRIY1Znai9UamJha2hGNmQzd2Vsdm1uRWZuRHF4Yi9DOUVk?=
 =?utf-8?B?MC9lV1BqY0RubkNEU1pFZ2swY1QzV3M3WGNZQUM1Y0NEUkp6VGNoc05ub2sx?=
 =?utf-8?B?NVhSaGpBQUF5OXJud2ZjUC9CSFBuT3RLamFFbmIvMEJ5VVk2TnJDS2pRUGtQ?=
 =?utf-8?B?T3p6OUNZM0FWSVJpYytjZjI0emxuRDNCNFE5ZmducDloT0pkSkFJQjF2aHZU?=
 =?utf-8?B?Qmpkd1BXWjZhc0JBU0trYmF5a2M4dmZPemtIb3VpcWM3dE1DL1BFRnBxSmYz?=
 =?utf-8?B?bXdkUTlLaHU0R1lvRG15K0tOZkR5QlNqMU9URCsxcThDV3hmWWZUZEZ3OFZQ?=
 =?utf-8?B?MVE0bzdnOFo4RWRDRkJYU0JrZUVkTGNZTC9Bb296Z3NIM0dSMk45azA3d25Y?=
 =?utf-8?B?QlZDZG5DMzJOdFNvc2ZKUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1cwdmR3aFR4T2UxbEYzc2tyY0FGOHpWa3c5Vm1iSGN2L1ZEMmVvdi9BZm54?=
 =?utf-8?B?TUFkSWZkRmtiMVFNY2sxMk1scytyU1Q0UTVLdzFibDhsRFR4YlhPS05RbXYr?=
 =?utf-8?B?cnhWQlZVQVBsdHI5K2VENGhGZEdqMnI3b1FOb0tZYTZUWk53cXQ3NFNqT1JC?=
 =?utf-8?B?alNBY0VKNmhzSElBa0I5dlZUN0dkdy9mMVVFK2JWT294VUJQYXdWckNmSHph?=
 =?utf-8?B?MjNRcWVHeitEbFpKeWszV3RWdHhxNkhHeklxdVFHUGk2TFRqMHpCYTVwUGlu?=
 =?utf-8?B?L2hhU05OZ2FRa0pjNjRUY2V1WW1xVVZRdy9EVjRIalRuZmp5N0NKNHRiYmxo?=
 =?utf-8?B?M3VDRUF0Rml4ZERRTHdKQXBBb2FiNVFPWldUeGdteG9mdk42RURRemxaUGp5?=
 =?utf-8?B?dVNkV3JaenVIZC9PT2JBbUt0NDlId2VEczR0blZOSlpDMFNOWGZFaE9NL09w?=
 =?utf-8?B?d1UydHZRcHkxSGxuSGhJdXdhQS9yM1JXRFVKQ09ENXBQN0NTTnVKUHlhS1Y5?=
 =?utf-8?B?dkQ3TUtKNUZud1Y2Q0lseVczalFHQVhLeVhUMVByM0xzU2dMN1ZtZTZlSkx4?=
 =?utf-8?B?RWhLa3BHNGs1REFwZmZyeklEb2dIamJFeFVFT1g1aVNjSUJhUTJacm1tbDVh?=
 =?utf-8?B?OTBqSzBkSlNzMnZtVlYzQ1hKZTQ5L1lpTWFzK3Jpd0YrWlcyNXBlQ09ZT1dj?=
 =?utf-8?B?WUNjRmR2TTQzZmt6aG0vWHVKOGUrRExhSzNZVVpUQkVLSGZ3OFZaMWxJc0lU?=
 =?utf-8?B?c2VxR0dzbGp6QjQ5SWNVREx2RjRMa2Ivc2pVMUU3YjBxTHBOMk4rMkdOWDRM?=
 =?utf-8?B?eEg4VjNCcUNIenRtcWprbTNFdTRHcUtCNzIyRDhOL1grdmVQTDdISjRYbG50?=
 =?utf-8?B?dkJsQ0dhR1RBcVE2WFVaYzNNdWt3RGUvblF0bGVPTmoreThXdjVtRnlwcXdP?=
 =?utf-8?B?MUdNQ0I4bVF4WkkzazRzL3pxbnJGdlhReDVOOWZtcDJxSFRqTVVwczBtRG05?=
 =?utf-8?B?eEgwczZLc09DNjM5LzFldjZwdDdIQ21mdWNrOW41bFFPbGJGOU9xZzltR2FC?=
 =?utf-8?B?Q3dYNGVselJVaEUxWS83VzBGenUzZGlhMjlaRU5NNS9TWEVwM0dSRk1yTEYz?=
 =?utf-8?B?YTkzeGwwUjJ5YXFwL29Db1hQUmNsMDBGZnNIenp0NjJRNmRXbC9qNCtERk5K?=
 =?utf-8?B?VHRSU2U0Ykd3NzdHV2VjTkYxRS8vZXY5aXlSeFNDY254RFNGSEJLR0JjZThF?=
 =?utf-8?B?M2tMZUk2WGFHYktuNTdsZFRuVWFzL0QreFo2aHYwdXEvZGV6Y3pmVTNyYThz?=
 =?utf-8?B?UGcxdCtZRUpPMVMxNkRMUnU2Q2RjNUxCUTJGT1JseVFUaVQ5R3E3TTczdUQ1?=
 =?utf-8?B?UzN6TlFJN1dyQTVqZG82UXJnREUwRHFlNGhFd0c4QmpRbjk4Wmd2dFRvY0Vr?=
 =?utf-8?B?bVN2MDVwS2k4Mm5RcitnMVBvQXVPaDhLeHlpR01VT2hWbDhxVGRacHJQM2xT?=
 =?utf-8?B?VjAwQ0Q4RzREL1FCYTVRWGdSdkxxR2c2WnllWE56WnVDd241T25oQTNmRUdD?=
 =?utf-8?B?ekplRnBZMG91Tk9jakpRNGErUllLdUtuUDVaNWgvU09KTHk3ZWltZ09XQWlz?=
 =?utf-8?B?cllzV1dCbjJTOFpMUXQra0V4dmFmTlR2U0p3L0c5cVhsd3M3OEl3SUQrQUJ2?=
 =?utf-8?B?cjEyRWZOTWxBandicVFKbHlaZGZWVGZJVDN3VXkyb2VGengzN0VyQW4rVWlG?=
 =?utf-8?B?N0hROVFwR2F6ekdCVmgxT3dzWGZ2eTBWaHJod0dyODFxTTVUdjQ2aDFLdVlI?=
 =?utf-8?B?UjhjRDV1UDcxRWpSZGRxUjBHcVRNZXg3cjFEUElxRFR4SG1tNEZNRVA1RkhM?=
 =?utf-8?B?aXNMR2pETFovL0c4cm5YektJZFpVSlVDbVpKZnBYOGRBalRNQmFaUkgwYzBv?=
 =?utf-8?B?Z2pMamxBSi91ZFRzNVFwdjFHSEF4aDJzSW50ZldxYVBBcjRCZWFlY2Z6UVZL?=
 =?utf-8?B?UmhJbVBPRWlvR3hEWklsZ3ZybVBLMWdLK3FvTDYzdFk5a1NzbHdJckZKQ3lW?=
 =?utf-8?B?MkxpcmJlRlBucllVNTZYMnpOVFdJaWx6VEdpM2JOSWNqcEhNNmY4SkZ0QkNl?=
 =?utf-8?B?UGxHbWFqZHBHSVRXRUtjeTFFaXNjclV4V0dnRm5QbmV4aHpXYUFZakUvUGIr?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e098b2f6-154f-45ec-f0f0-08dca242b9d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:17:45.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UJsQV5t20x8X1j1FsDXsMjm89E4rwHDWt+K++xDQhiKJBIZ6Et5n6qEzU3yEzlVci1CtBig+msZGN8wwBiL/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16452

On 03.07.24 13:42, Claudius Heine wrote:
> In case a sw-description contains multiple entries of the same file,
> swu_files will contains multiples of the same file and thus later
> operations fail.
> 
> This change makes the files in the swu_files variable unique, so they
> are only operated on once.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  classes/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index e91238d..5e54853 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -205,7 +205,7 @@ IMAGE_CMD:swu() {
>          swu_file_base=$(basename $swu_file)
>          # Create symlinks for files used in the update image
>          swu_files=$(awk '$1=="filename"{gsub(/[",;]/, "", $3); print $3}' \
> -            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
> +            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}" | sort | uniq)
>          export swu_files
>          for file in $swu_files; do
>              if [ -e "${WORKDIR}/$file" ]; then

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


