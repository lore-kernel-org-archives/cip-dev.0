Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2686D2CE17
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 09:35:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11876.1765359308733907181
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 01:35:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KaOvEjrI;
 spf=pass (domain: siemens.com, ip: 52.101.69.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfqfOPLxrtGNNYXwRF99XsnToP10WtlKeR5pfg8bUl5YC3ow+JAz9qZJZEcZQJn5B6zNa4Yq1/ciOvp+SVJsx1RFwWy+3yS40MQOo5ZU1XyAsM60l3+ycvocVwJ5YNzaHeiYhoxksUFHey9siiRwuQUZ4t0QsNeCBbw1RrLDxpgN1r7VC/yYunqry04SlGkYdv7q/y7lMHbcA179yGXbs8A2lGMRaJemZ+8MrrzFfwY7jqG79I88ILnbSAmF2y+pvdE7yHDkvfDcH3li+GSSBZ8EKvYhJsba3uqd5ieqT/KRpVTz8xM+2wQAdMEFdkpgGiOwBsSSPxaqzu1BNGKdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrCwA+YAOsEKqkW0au0ZtaD5R/9GgCvxi0veC17TLgY=;
 b=Y1KWYidQDY+79Gp2CA3UsKqa6zkqrHLim1RDndLfHhgeUaPqa97w80rcCj+fljLA+8cCO7+xsyW+zEyggqFM78MbneDpFOoLnivjFe/c/b/aavgoYcicSFaMInJrj8tHMmion+oJ0JrMFwZ0EL5v2zg4M/CGb+Ibi1YyviW8WQlern/LksO4UxWmEDAoipoqVuFskewYpjA0iTOWHQhifcI4CiD+TlKQ9iN2g2K4hjGhRhEOxkr/BbX0se4wfadUcg8dj4iKQCSoCl4yrqCestMVU4ywr7u9NgMkOuDEaagJklaZ4f6YpjrUPil5wx3Y1/ypZUQTOaBTt+ZoH0QJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrCwA+YAOsEKqkW0au0ZtaD5R/9GgCvxi0veC17TLgY=;
 b=KaOvEjrI6T6Ck/FJQYiyyTfFyt+OwCGjPUsnhCfJ2hNo7HkMqnxYathUYHt/v/k0PYvNFpwq8xK0o+XonFJgXfpTc/WUIx0P3SkMp9G2D0YllFqM3Lsc2uhWNfVgML4dfpq1Pn67scKLIJI7727h5llq6bE02uzlkriQ+ysAe9yr9/9h1nWyPCsjQARFfPKxJvDggMAJQR45zP0UI+HqeeRrKoFEjqUxSbOi+8cMVpWW3Ejtu9pDdl7RNY0WRc7Q3maQW2lpZBWg2lLrZTw5s5bIxlSvuMTVOSQvFpNLKHLPFScEDuQ9OMxGenPrGAZ2fHJEto71zWrG50sg4CUyPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB5PR10MB7722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 09:35:04 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 09:35:04 +0000
Message-ID: <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
Date: Wed, 10 Dec 2025 10:35:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB5PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a5ccb8-346c-4028-e4ed-08de37cf65d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|4022899009|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S2pWSDllbjNSdFNFSjFJMmtNUHRFSUI5VG93aExXdUhiazJldzUxUC9PamRH?=
 =?utf-8?B?bjVpL3k0Q1liaEtSZXgrYWxmNEp2N1dSTGRkRyszcHNMY3Z2ZUNUdjBiTm80?=
 =?utf-8?B?MW9qNXdIYk1iOXh0SW1XSzdta2pjM2pjc3l0bFZWQjVTMmdsQnNxNUtMZHVC?=
 =?utf-8?B?UFo1U1FBc3dVT3JQVytWanV0RW8yMUd4bWZxNzJEdHV3bjU5RldPdFE0djc3?=
 =?utf-8?B?WEFYVS82ZjlRU0NQa0dwcm8weEN1SGgwaE9tcFRlNitUQnJxUUR1d0MvMVlv?=
 =?utf-8?B?cVN5MjVhejdXRk1GamlIbjZZenUvYVZUdzlaZkJzNEJjQ3lWcEVCNEZ0NWpW?=
 =?utf-8?B?S3NRUENEK0lXM2dBSTlhdS9zYVB3d0g1NDBWaTI5ZXgvRXFsWkhDb21kQjFD?=
 =?utf-8?B?eVJPTXpyZlY2ekNBaXVHNTlUYlVMSUdUVHdqUnY5TFdyQXBZVjROcm9wL1A5?=
 =?utf-8?B?YUozNmtYLy9GT3c2Z0NrbGIvQnUvVitZL2lzR2FEaWtDTjdqcWZ3bUxqeUh6?=
 =?utf-8?B?NWhuUHdqWkdsSEd5ZW0weUVDc2RPL2dLTVBmTVV0TFRWTW1PWW1DNitXYi9a?=
 =?utf-8?B?NnkzcVZBMjlVcjltL084cmFlam9CL2VzTVFESnFxVFlVVVc3ampRMCtlKy9W?=
 =?utf-8?B?OEpPNk1pMlZsTnpGRVRleFBVOTNPTkR5QXY4QkVRQlR4N09nK1hRdUtCaUtF?=
 =?utf-8?B?Y3ZjS1dvWWg2K0djQmVUSDNVc0ZqdEFZVklIeXdvd0U0SVdTbWJPNlMvNWV6?=
 =?utf-8?B?YWxMcnNwTit3ZThTMThveElRbEtyZ05KdlMzR3J3ZVc3TlpKZjlyNUxpNUdH?=
 =?utf-8?B?ZFdEU1VCZVhycU1hNE5FKzlwTGpEUXB6U1hBekxPMFA1aXduR2pSS2hlL0E1?=
 =?utf-8?B?RWs2OUsyZlVIajRMTjdGRDd4U05LWUtoNGdVcGw0bGlmSXdoeW5DOXEvNFZG?=
 =?utf-8?B?Wlc4ZkxZbHZnc20xS1QzWm1CZTNGTExUZGxDNFpSYTRyeElESW9uUzJRbE9q?=
 =?utf-8?B?Vi9VbGdqTVgxWVo5MG1oQ1dVUjBLR09HZFZFVGRTWWZtUEFYOXVuaHhpbHZy?=
 =?utf-8?B?VlNmSWlrYTc0Vnoxd3ZWdThpTEdtbEhDbUM3UzBQMXBJQkhDckNUNTFFOEVE?=
 =?utf-8?B?SHJLaG1OdjVYUjc1UkMxYjU1bURqN1ZOUHJEK0N6b3NLZHRSd0ZJOVEyTERV?=
 =?utf-8?B?V0IrclkwenMxNjByREprMlorUG52T2tMRmlxTU81VitMVXNISlhxeGlNL1Rt?=
 =?utf-8?B?TFZhWE1aaWZnZ29NakNXSG5laXBiaS96eDE3YnNZV3JGVzlBY2tORXU5NjRW?=
 =?utf-8?B?T20xYXozZjFXdDhuVUZLWGxYcFpoaUFyUlZoemhDZ3BwWVJPYjdzbktWN0h6?=
 =?utf-8?B?aSs4RWcxU3BMSHB4cWsvcEp1aUgvb1hHZnZIbUdyaWFaVmFhMy90dW9sLytn?=
 =?utf-8?B?cEQrY3JlTENtSWJxRVRxMkZUVkRVS1JTVVdMTm9hV2tUTm02OGVKbTU4Zk9S?=
 =?utf-8?B?c2lFUmpBbUNCaGRUTE1YeFZTdWJRYkZna2hETEh4aGJIdHgrN1NQY3Frb2JU?=
 =?utf-8?B?WUlqdjBhRHJKTmxId1Z4VU56U3BBd3lSaStTZDArMngrN2Zoc3FmbXRrci9l?=
 =?utf-8?B?YlduQ2xSeTQ0VHduVHBZSVpnZFZPZUdnVjRHbVFTR3MyU1NVQzNOb3JJNHBH?=
 =?utf-8?B?YjdraWI0bERBaFhvVFJzTHVuVWpKTVRDR1RQN3hOdGlTcERXNVNHOGpvbTBo?=
 =?utf-8?B?OU4yN1JpWlFsZmpNNU1HNkpZQk9MSm1KZWVxQXRLeFdjTWFwaXdwTW5QRVNo?=
 =?utf-8?B?R3IvN05qMWxnZjc2eFdwNDFNNTI2Q0lncEY0ZGFZdGhNK1VQSTV1U0FIUkg2?=
 =?utf-8?B?ZGhUV0QwNUtBeWl6WnUzZ1NUUk5CY3NIckpkSmx6bVp4S1g5OXgzdTFGb1Rz?=
 =?utf-8?Q?/ntUnAbgl9aB87u4RCN30y0kSaj/V/F/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlFhZG1hR01KcVMzbjE2VVlJQ3BHQVA4Q2lZMmxSdmZWNVVwWlFpVExUYkZ5?=
 =?utf-8?B?MzlEaWVaZ2JacU1yT25NOHVzNEhRSDY1K2dPT3ZuVGlSRXZIOE93cVRJbGhH?=
 =?utf-8?B?cWFMZk5GdEZBWXdlb2RmT1J0alpwT1E2TUo4M3R3K2hKdEtBVUFFRXRNMXRi?=
 =?utf-8?B?U0huRjM2RWFsekh3citkL3JBcTBGckhTSXkvQzdlVzBoZHhrLzAyYjJJLzlC?=
 =?utf-8?B?WC96bmdKbXluN1lMZzdjenNhcUtlckdJNWFldkdxMXBvK2Jxd0UreGZia2lt?=
 =?utf-8?B?eVd2aVErci9PZXRrT0dwbnYza3BTc2hFd2FoUnYzZy9vT3FYZFprMUJldVBv?=
 =?utf-8?B?cURmbS82VXZ0YjJPeVdVaHNLVmtvN1ZEQUpzZGp4L1lFYXVoTzVyVHJrTzZr?=
 =?utf-8?B?d0hkd3FuOVBmVGdIR1NHMnlSa1hlalBiVHRjampTdEoxaUhNZDBkc3FGRXYz?=
 =?utf-8?B?L2VNRXlHek1lQyt4SjZYaTFxVUJEQnZYOVhoNkpxU1N2WjhLajFmd3dwV0tN?=
 =?utf-8?B?dnRscFQ1MUwxQkgwV3FpbFUvSWxMUTF6YUtaNzc1SUE1dHczU1VWRkxob2ha?=
 =?utf-8?B?VzltcDBGMG45QjFhMjRVQ0ZISG5WcWxZM1ZoS3JJQlV0SVIvQllMMFNiOG9p?=
 =?utf-8?B?UXZxQkZvT2ZVamxFNXZ1SlFKczBNRGw1ekhjMElWbDlUSzRrNDZOK21tV2s5?=
 =?utf-8?B?cHBDWlUyTlJhVTFEM1V6bC83ZTNkRTVKM2hoWFo1K25heGY1K2o0bnBVRHk4?=
 =?utf-8?B?MUk0aWxRbzBzRnNYRExPNUoxVm1McGNJN2tpUUl0azZXR3NiTmEyb2JxYmV6?=
 =?utf-8?B?OWVNWjFhbkQwaE1lRHdvQnhiaTF5MjQzdVRRTERKYm9pMXkrbGNHM3liT2Mx?=
 =?utf-8?B?cEpLWE4xbFZiSCtKZUt3RHJkZXVVLzNjOHhVNm9STUdMQ1RUTXdHLzV0VjVh?=
 =?utf-8?B?elJIUDk1dmFLL21HcDZEemo1N3ZKanRDMmc2Q2FSclJBaXdjN2RReHpYMVJY?=
 =?utf-8?B?NG85ZXhqVS9oWVRlQW9aR0lRWW1hakVyVjFoWmplWUFCTkJRWE1zQ01SOVJ0?=
 =?utf-8?B?TzBhRHZ1OU9IMzJ2YXE1UStmTWczbzZiVGFDSmhTNlppeVlDNFI2Y2IxY0Fi?=
 =?utf-8?B?d0tnWlJ1Zi9CVkR3dEVIY3h1dlVBbHV3M0NFQWxLdFZKZ3JHbVo0RTdSaGRo?=
 =?utf-8?B?VmdLTkN2Z2VIUWJkeXltSGVvWHUwNTA4M1J2SDRrdGVzS2s1V3dFUHZPa05h?=
 =?utf-8?B?KzNXUmRhYkJJV2FaV3ZteDFPZDFhR25kSFc5RGxwU2JPUzc0cUdLU2JnQWw4?=
 =?utf-8?B?emxPUHZtTVFrMjlINDBWT0h1MlExOEdTQW9IMkJYYTRxbnRxL0RXVjVoS2VM?=
 =?utf-8?B?ejZJelROZXpaODBXNDhUZW01U0dXMko5QkswdXJlWGVzNXZzNmlNL2dFM25C?=
 =?utf-8?B?UTd6Wis2Y2pvZDJqeHRCUUpRZENCa2xwNXpvWmpCUkVoT3p0Sm84aXVvMTVL?=
 =?utf-8?B?TmdqZnYwdWN0MUZpallaK21TTUU1V1hlNEtyRjYycFVXclBwNm56UFB3NFJ3?=
 =?utf-8?B?Yzc2MForSEsyc1NpL2krb3BSTnRvZk5lbXE0VTdOZ0hMQ3ByQzZzSWloU1pW?=
 =?utf-8?B?dGFISXFlck5BN21FNGl6MzZ2QUhkOGhTUENoaEc4dUlsZDE3cUVWaEtHanRn?=
 =?utf-8?B?dnd5MmlXTnVKbkk5MDYwcDVoY1NWQ0l3VkdTLzZ1azhRZ0hTektXekUxR1Ja?=
 =?utf-8?B?ajJlaGllZklFbmZRME16MFlMOGQ2eFEvbWpEbjJKSDFpZnlOWWZ4NjhRdzZ3?=
 =?utf-8?B?cWJnQ2RBYmRWREl4Q0xKQ0lLV2pIT2YvYi9INXNocVlwVk03eDJqaFBOT2cr?=
 =?utf-8?B?VkFwck9lUDRQSHBkK0UrNjBmbjRiNTE1dWNHenMyd25nUUFkY0xadTBIWmxj?=
 =?utf-8?B?bmFNbitiOTFUc0xpK2Foa3Vxc0FsRWdpZkFRQkg2aUtDRGRPN3NxOWZzMEtS?=
 =?utf-8?B?bWtYUTI4TjBRV1Q0aGVCZ1o0dEpMdEZyYTNBMklEdGV6aGl5NXJ1eTBZREFT?=
 =?utf-8?B?bStQQUlyTGJ2YThJbUFmdHhwMFdObXNpV0lGL3k2VlZadTdqSHZ1azI5MXB2?=
 =?utf-8?B?MnA0bzk5dkFtRjljSkhSRUZDOWV1ZWg2RHU2aXBtRUhFZmI5RE1JNkhlNEM4?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a5ccb8-346c-4028-e4ed-08de37cf65d5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 09:35:04.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmpWNCIU8B29f/nSow7rkhCCKwyJyYIi2zadUh6WKCtaPUOXZAd5ey27z78JigWuJbhBZRoo+z3z5nFQ/yz0CxFQH3D4oDzv/5YtuLpTUQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7722
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 09:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20958

Hi,

On 2/7/25 16:04, sai.sathujoda via lists.cip-project.org wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>   tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
>   .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
>   2 files changed, 70 insertions(+)
>   create mode 100644 tests/templates/M-COM-x86.yml
>   create mode 100644 tests/templates/swupdate-test-action-M-COM.yml
> 
> diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
> new file mode 100644
> index 0000000..4716225
> --- /dev/null
> +++ b/tests/templates/M-COM-x86.yml
> @@ -0,0 +1,52 @@
> +# Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +# SPDX-License-Identifier:      AGPL-3.0
I had some request about the license of this file as it is the only one 
in CIP with an AGPL.

Was this license intentionally?

Quirin

> +# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
> +# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +job_name: mtda-mcom-#test_function#
> +device_type: mcom-mtda
> +timeouts:
> +  job:
> +    minutes: 180
> +  action:
> +    minutes: 95
> +  connection:
> +    minutes: 25
> +priority: medium
> +visibility: public
> +context:
> +  lava_test_results_dir: /home/lava/%s
> +notify:
> +  criteria:
> +    status: finished
> +  recipients:
> +  - to:
> +     method: email
> +     email: cip-testing-results@lists.cip-project.org
> +
> +# ACTION_BLOCK
> +actions:
> +- deploy:
> +    timeout:
> +      minutes: 60
> +    to: flasher
> +    images:
> +      image:
> +        url: #project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#distribution#-x86-uefi.wic.xz
> +
> +# BOOT BLOCK
> +- boot:
> +    method: minimal
> +    timeout:
> +      minutes: 30
> +    reset: true
> +    failure_retry: 1
> +    prompts: ["root@demo:~#"]
> +    auto_login:
> +      login_prompt: "demo login:"
> +      username: "root"
> +      password_prompt: "Password:"
> +      password: "CIPsecurity@123"
> +    transfer_overlay:
> +      transfer_method: http
> +      download_command: "curl -H 'Connection: close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
> +      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C /home/lava/ -xf
> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
> new file mode 100644
> index 0000000..02b0b03
> --- /dev/null
> +++ b/tests/templates/swupdate-test-action-M-COM.yml
> @@ -0,0 +1,18 @@
> +# TEST BLOCK 1
> +# Fail the job if software update application failed
> +- test:
> +    timeout:
> +      minutes: 15
> +    definitions:
> +    - repository:
> +        metadata:
> +          format: Lava-Test Test Definition 1.0
> +          name: sample-test
> +          description: "Test software update"
> +        run:
> +          steps:
> +            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-bookworm-x86-uefi.swu --output test.swu
> +            - if swupdate -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
> +      from: inline
> +      name: sample-test-1
> +      path: inline/sample-test.yaml
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17772): https://lists.cip-project.org/g/cip-dev/message/17772
> Mute This Topic: https://lists.cip-project.org/mt/111053334/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


