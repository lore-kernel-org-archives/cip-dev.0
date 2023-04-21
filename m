Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C2C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 20:24:44 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web11.23311.1682108677995130639
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 13:24:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tG/bGb+h;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQUdDLpTSJPvwsmPfS+vObUndZBfAQ//RPuHdLYu1M4Dg9HjD9qA66TFPhlSuPGtmcuhYNwZKnT0kvqD9xW7APBPg1QSvWlt/fA7OaA7zE9xpgUEeuUZ4aQ9feDvmNIKbnTYB96win50Hzy3OUme6R1379dnCg28fmkuxoO28QIfWjVkJ9yolHczvAf/pQU+HMSW5W7jyRb/q3aPOJbBwO1XHsfvRXhT03PbekgrWMnAezLOrla4DjdBDbaKrsnumlZAgirK9s8xeHynmCCIxHdzpVKM1BfPQJfqRvMoeOi0IU4WKwAFWsR4qCT14eRtRjLbtVx0utWKHbhoqYPc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wnmQoQY6FXbW2iV5iu/sPH2CKHzpFiScwP6rvBxeD0=;
 b=T7cvfgCgTLJ8ySnhCJ016LDRQhs5ENY0KgDZwIibzshCGHLW8x9QdxGLwCc9dO3/ELDcsb/vv2d1DLyHIJjHnsB+vWFHP2F9cT4i943i6zqLAN+6dRhHnsI3k14UxGVLKeFlZ4/S5kxPd1y8eLl2J7R4XlR0QmTpKHyBa9NkigyzOgaFst0f5SGzSWrR0wIcRKGoqDai1LnQkQHspb42t+B2ztwv4XZl/3A2q10A0HPSvXBWwCLUkopUesl1cFNKiEOXACCKZ7lc8UjJd012FWYjdR6131uOy7O8SrE3sfFbk205FSr+w2SL/Yy0NKOxBMi4y/5/3Dy5PDzR0JqN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wnmQoQY6FXbW2iV5iu/sPH2CKHzpFiScwP6rvBxeD0=;
 b=tG/bGb+hMmwFwzZMePBstZZ31ZdwkIsr/Lta+tSo0iYSX/d96smDb+vYuYwsC/5PllHxKFvV++8nqu6cRn7jYFNXDnJMu2Ht9C7ggkedzWzyOjkrlzj8qQmExZLDMfyPGHc/qsSSYMFxtUhtF9M5kbK09LtCMTrfNDaeyEgvLJ0sH2+Oq8xd/VQlW6ilv3zFHN+Wma5fMCDR7hIRtXFuFe56hXpel3eTTsK1jthdBW4BGbkYTbhiCY5iZ83bnn+7sL/zM/D6y96LmdAU8KdFexleZaSzWmBvKn1EGVmVwXjjze2IVAOTnZXFHfqkHa1ZZWrcvA/qQydp3H4Ka1SDjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.15; Fri, 21 Apr
 2023 20:24:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d356:e734:7193:bce6]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d356:e734:7193:bce6%5]) with mapi id 15.20.6340.010; Fri, 21 Apr 2023
 20:24:06 +0000
Message-ID: <db0f91d7-14ed-8e4a-a6ef-1d6302e32b9b@siemens.com>
Date: Fri, 21 Apr 2023 22:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: Add bookworm as
 distro
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230421141643.3905811-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230421141643.3905811-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: b0377e90-97b6-4819-05d9-08db42a65adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WMce0NuAHqzqZ5TIjrkd9sXIcOCLOr8dc395X8USpk9Qo/Z9Q0o6Q4LFhYWQtJFzH4EaiTHU/yWdNOR1xriyzwuVMbcFrlVg32fVgcrGrIOA0B2OjTrEHrK3+nqEvaDLo7thZjmZ03UKunvPTroVZ2e9pfoukDAZ3yI2s5mpu1GoND/2eI58jCpivJUMoc9GXuA73NarW1PaGa3eBPmLR95zM9k29RzZgj3Zr6dIazZkLTCjYmuoSGkebcnTpm51UATj64b2I5AxMS88vKjfW+vkxvJzjY0PrAVTq6IH73UCZBJ9jFXf1CFtL54D/v94xv2Gj689Mp9ZuzvxP8lfe2MqhLLz9Lnk1ym7wvq9MwyL77V/zc2TKMfplixd3PtsBryOHww9Is6wkThjim5OCksaNdh9/Otm8lEuPDyVCwgKgm/nTBULaT3MkbvgQeHsJG3/MzMHaoW0md/zaftmzNj7WEy9HW0NCOGsnLneAQL/nWRKiufvO89HZCwxn1PuyAUqIN1dfJPBSupROdR4sgXRAe0DRysNdbqtFeOrU9zrixj7pwqSUbYMDT5FO9IkXDHhemXPB0Kyw0Phqn1Yfm+XGeEGDuF/eWwq/DsL+qDZ617rnOhgjI4R9Djx907TbZgf9vCEkC2QYeb9W/veiw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(2906002)(4744005)(41300700001)(5660300002)(38100700002)(8936002)(44832011)(8676002)(36756003)(82960400001)(31696002)(86362001)(478600001)(6666004)(26005)(6506007)(6512007)(53546011)(6486002)(2616005)(31686004)(186003)(66556008)(66476007)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVZqREpzSnhwNGhRNDFPM3FGdUhneTljMGRiT1JsdzdiKzM3N1V3QVgvMkxN?=
 =?utf-8?B?TVMwRnZJRFoyVFl2MTdJSjlsRVZlU0I3TmlxVTZTL0JsbFl6Y0VIOVlWeTVW?=
 =?utf-8?B?cXJKdGxEb2hIejhlVnkxS2hZbk1yNDAzRHJaZGl3bDZiQ1p3UXV5TlRGYlU2?=
 =?utf-8?B?VExVbFJ0dElQMHdVNU44VXVqbjk1RTZYdjFhNnZkdk9MNWhwdTB1ZWd0Q0M1?=
 =?utf-8?B?ZXpDUUgvZXRSc0pKaFlpNVUzWVdFWkM0ZmhwRkl3cGU5azZpc3FQUnhEQjk0?=
 =?utf-8?B?clRiUXFtRFg0UHE5NHJHVWRjbStzQk1wdDBQSkZLd3dIQ2hhOWNVZm9HY04w?=
 =?utf-8?B?aVlTRG4reWVtYk5QM3VsK1RrQnNpNk5VWUhUQytGZ2t0U2ZBSXJ4WlFqcVFU?=
 =?utf-8?B?RDc2c0pERFJiVjV5dFIxbjFKYkRBSm5UVFhkRnZ2d2VMbXFWeDdiVXhLb3hn?=
 =?utf-8?B?YnNWY3NySS9FZnZRZTcrcGFqbnFTVVVpaFBENkhEazVkWGRiNlp2WTNOdDk0?=
 =?utf-8?B?UVVCZzRPbk5MdmV3Um84KzJuM1B5blU4eE9WTFplM1ZsRFpXMEpJMHZYWHZC?=
 =?utf-8?B?a2c2MG1BdGgra1Y1blVEbUhKNTVDQUM0RTc1a0Q4Z0QxOHBGQ0hHdWZQTisz?=
 =?utf-8?B?R2tqcjhPSEZvMG0zdkVHNWJLREJ3VlJsdncraFB5MGFPaTA1UnZ3RTAzYzQz?=
 =?utf-8?B?Tm0zeklLekhqVWZwcVQrUzd0MDZDd2w1ZlBLaktPblltT2JjeS9kZFptWDlY?=
 =?utf-8?B?OXMvTUpMZW16Q24zdit2aWxyaWJKdWpLbDhpSTJwSUFadGh1d3FaRmpLbzFw?=
 =?utf-8?B?a3hjRUpINTZPSXF0VmJ0cXI2TmRRdk05V3BwdWdXeUdvU0lTVEE2QmkzanNs?=
 =?utf-8?B?QVNaYmh2UDRBWTJuSjdYZSt3OTRtZGdJaUhpb3BrQVozMGhpQTJiTFQ3ZVBh?=
 =?utf-8?B?R2xRQ2gwYy9YK2QrV2c1R3RMT0Nwb3hOak9waWgxNDJTWmpJN3VPOE1YZ1V5?=
 =?utf-8?B?L25rYzR6akc5bi9QNmdLeUszRjNHM3ZWTjJxaTNYZlN5NXVPSFRnL2xEa3Fx?=
 =?utf-8?B?czFTQytTU0NFNFY1MUpKcEMvVllDWjRCRk9qclEvNkF4dFFlU21NV21OVHE2?=
 =?utf-8?B?czVBRTJrUkRaK2J5RloyYW4yQTBEbTc4YWsyWThBcU5CazR1bmErajkrVTl3?=
 =?utf-8?B?cHZndE0rR0N3dUUxdEo3WjNFNFZQQnRYRlJyNmVzWHZSeW5rRTlURzk2cDQ3?=
 =?utf-8?B?bllucEcvTWFQUUpjYVFNL1hXNzRIQW50b2tVTEFoYmdwK1lWOGpmWWpKU0Nq?=
 =?utf-8?B?cGFtQ2JGOTdJRWlHYkJ3Vzd4NHJPdTRySTFybXVldWpjeTFvSlZDa0NXdTl3?=
 =?utf-8?B?UXlVdEZtclk5WFBOT1U1bWRXeityRnZuQkxwUTdoSU1IblVPWmFiV2k3TVIw?=
 =?utf-8?B?SGxKOW5pNzFyOVFNNGhOQXIxZUt5a01odnJHdit0MTR0eGlHZ3dqTk85bWNH?=
 =?utf-8?B?U0g0R1g3d3daTGE3QzlCRUxZYU5Xbm5WQ09qQ3gzMjBHTFN3T3VpZ3A0Qndp?=
 =?utf-8?B?U2orQzlzWFZlSmMwakpQalNPZ2hWMGJMWllyS2d6c250aUs1QWcrY3g3Ymsz?=
 =?utf-8?B?amR6RTBsMDAyeDVPM25mZ2tIUDF3U0ZDUVZ3cVMvTU9WMDcwb1Fib1dRZWpZ?=
 =?utf-8?B?ZWlGajZ2U1pCYzFieWQ2T0pTcm9SMkcrNTNoeXZkbDIvZ1h5cTNiaW1CWUIy?=
 =?utf-8?B?NjZZbFg0SFd3b3FsbzFuYzQyS3BxRTBHSzN3U3NyTGtNaXgrbGhJVnAvbVAr?=
 =?utf-8?B?STlCMTl5MTNDbjh3MFdBZ1ZGVWxSbDYzamFBWFhyeUhuL0dWSjlPdGRoTTdL?=
 =?utf-8?B?SXdBaDNGbWN5akQxRDNPbVQ1VFIrUWd3UFI2MFVDNVgwWnVMaFByVGV2N052?=
 =?utf-8?B?QUV6MFM1eTdsWHpUdmhOT2VvTkV0d2w4Ymp3ZW5HeDJuRmJNaGlHMlhldDY0?=
 =?utf-8?B?Tkc3UkUrTm9xK3lOaTVYZGhYTlA0UWdoV1RSeFRsMGlWSE1KKzZPVEVWT2F0?=
 =?utf-8?B?b0g4RVMwOFh5dFZqWHVPNmlGSkhhMXFySXd5SFNWRDB0MVg2T3NWTndCWDdT?=
 =?utf-8?Q?Go+3gGtp1ScVK5MUx6Df5DL10?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0377e90-97b6-4819-05d9-08db42a65adc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 20:24:06.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtlGSGkeWL2HPXGNrPd2euuhQ5Rnj0S6p3FtjEzf/izsltu5HLCi+Z/wnUvYqTmeepPN853mn82M++gNrQDN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5223
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 20:24:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11329

On 21.04.23 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to start qemu with bookworm images without additional
> arguments.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 8810474..5d48e0d 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -41,6 +41,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
>  		DISTRO_RELEASE="sid-ports"
>  	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
>  		DISTRO_RELEASE="buster"
> +	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
> +		DISTRO_RELEASE="bookworm"
>  	else
>  		DISTRO_RELEASE="bullseye"
>  	fi

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


