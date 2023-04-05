Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A75C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:39:07 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.42])
 by mx.groups.io with SMTP id smtpd.web11.126028.1680687543199714826
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 02:39:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GgFzfDkb;
 spf=pass (domain: siemens.com, ip: 40.107.13.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy2HrePsEUO5oKSWnxcvGyRs35Ao8AOjpmti+x4B3GOfBLBpzEXGRSsHUMgs7khYd5f+P+tTcHb/fdoNbqKy1LpQ2eRW/0fx2nArrImmvwsbo17a6CTSP8Q6CVs99S2NnAgR2T56MlX/4EIN2EnvdyhBsrXtJDikq05yBteB1yZD49/jgazHu15jTXFAo4w7fo7b65m6BePw53liq+eDZyYHQ2MSTgzhwZKpKvHkjTi/2C6167cP0ExvbqFfGC1Ljx7fGsMHCmwHaPNjS8WfV3Ukuck6qXBePaExd/6WVlVNuFeJey6PyTEU1U5cDsQdZ0JnEzhVUYVz0/FFNN4ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5qRoQWlJl7FOP9Qc1dF4Thjn7PqxoDBiPrNOdCPblM=;
 b=nJY1rai++aMcIC+isd5R72JFKdrbzLkwIs8DbDTUWyux+1B99DMBYyAIrf8B1RziZ59hDLpUOdW9omt5vKTrZweo9ZSlTiUygFseR9TVFj55qoXnCeg69ooYcFrcf/hoiIlVp2+01+yS13Ev6cz8TSbUf/DIJeb/ZWgEAV8WGWKXeUZaitu4q8fBF0l/t0aVTxcEyqsqcJLwDe1WxtONqGpqi+T/2Zs7Nj4Kw79bcef8kpMyRESXITGODMZaduTm5FYr+ywbEGRSyqwYkeabl1UssIbXDOu2VYSEop124ya5bwnCkS7nIrGOdhKBhELrbKy0eYH/x1fmzsSSzXSbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5qRoQWlJl7FOP9Qc1dF4Thjn7PqxoDBiPrNOdCPblM=;
 b=GgFzfDkbOprRIIPfFvapMeIG40XKYx5tahRMHaJnnN0QJBUjXYaOlEp9f2Lp+Qpr5MaGJwlkoTCa7FsxW6zlKnHahDjxvhv1narXNvs4xLdR/SlBjtTIkZQrYCEClz/Wt9JYj+BZ5u1LFVbnyPUR77Ixhn3Orll6Yvld5298rgEZyZvt7Clr5nyq0cUVk35aMUoNhiaS4QGUfCSbrFgBskKKvp2Ulkx/Xz6dCXYnhlGRcfxcygVs/MgSEHvTcpyCiOVMTg2UT0Nm1C0wei6+PrIJRNxUZagH3OXiB2LRQcNqCVNv8HuLbWgf3PFKCg0lNEKcR/FE9Xd441XGIKzebQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Wed, 5 Apr
 2023 09:38:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 09:38:59 +0000
Message-ID: <ce6d8f5c-d703-3898-9839-7dd8c77d3e74@siemens.com>
Date: Wed, 5 Apr 2023 11:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH] scripts/deploy-cip-core.sh: fix style
 issues
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
References: <20230405071927.600015-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230405071927.600015-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: a053c95d-d4a8-4aa3-5fdb-08db35b99560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5rZCHDiq2Pb9rTeLXXEFJaCAqBaHyZ6g+MC2V7lfrDcdE78d2xMfl4y7u02/4BcLkwKDn5gJjHSohuzWVixP/3IPI6tbq7bg6fdFVrs+dmZDGWPLCRm8lQhRR9tFIWVoCjzLfEoTGmN1sfoLqP+kW12TEtXfYO4+kbQfBpOpbdrSoL/pxat3OTwAOYgvE2kF7YDtt+3XCrVK65wovDfsmzd3HJGm48Zqpnc/aICUG1mIUgckrCJxw/daitn5lLQXXBpFYwvC6kUhApid8vDc8MQ6WUCESUN+s3D59xkbvFkOok61P/aViuiy3YsenOvtKtxRQV1Q1IvSW+3XQybwnzdv+BbFh1EEGaUcr+2yT4zWJ2eOTJPutA3HFIYoSeHjn/FkpFtOCF8BUg5as67R2UWL5YaDUHRWjHyVWHUDMXFYam559t6Hl+DW8Qfn79uR7XT5bDfa2xKX6j3v0ex3G1aefGdVC2igST97nG/fAjWdK6ZbGQKC8/3/NFRuSOJgg+8cs9jBiVJEb1NqGum55YCprz+haVfujSFmqcoM/1soOo88vL+w/WX1DgfQYuCwS7Oqpe1Tssc5my6g89Ezh6h+xBK8GreOax2oY5ja0fL7zJHRJkrSAt3fqudb28lt2ZCvYUoN6x2Bu/3eojCD/Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(83380400001)(186003)(36756003)(2616005)(6512007)(53546011)(26005)(6506007)(6486002)(5660300002)(38100700002)(8936002)(316002)(82960400001)(31686004)(44832011)(66946007)(8676002)(66556008)(66476007)(41300700001)(31696002)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnB2ekNqTWNldDZoYjZ4WXJZZWlxdXFPYUpmREFyYm1xcXoxSTBsMU1HNFZp?=
 =?utf-8?B?bkp0N1pEOURiZXNKMjNjS3RoTTBDaGNMenNPaVFsckJWYjJHY1ZRbWJPcTB1?=
 =?utf-8?B?VDZXZ2d1d3FYL0RqVFdFQ1Y3RCt2THptTkd2VnVZT2JKYmxRSzFIQ0VQKzRm?=
 =?utf-8?B?WDVMRW5pUW42alhycVhkVXoyTDlhVWJYVnFyRWtidFd6TGp4T3N1dERNS3pw?=
 =?utf-8?B?Z29PWWdZTmpUSzlvaC9OeWlod1Q3blgydzlpTWNMZk5DSFg2cGJNTVlnYzV2?=
 =?utf-8?B?YkRpZmhjME1oNVhpbXRaMGF4bnpwcWcxNGdQbEVxT29VV0hJdEliejRlR05K?=
 =?utf-8?B?MllYMnFOanJrQXhxVEN1M3FSNjM5RUJZZWZ0SkY3b1cxOWN5OUVUQk9YTmFt?=
 =?utf-8?B?cDBhVEhtT1RRRGNrc28yeGNtcVhSaDlJdzRTVWhFRWRSeU9XSkRFNTdlMHp1?=
 =?utf-8?B?NDBIaGxHNlJBcy8rWU02OXk3U2Y1Vi93NDN5ODJiK0o2RFcwUi9KR1ZDVjFn?=
 =?utf-8?B?SFlsam5EWG0yZ0tGUThGYVc1bmhMWVBkOFBmaUVubTVtRXIyVkk5RjRkZ1Vl?=
 =?utf-8?B?NThnVXdFSnhLZmdZMThscDFXS0RPaXVHNE1BYlNLYjJIWVpKMEl6TEhqWTNm?=
 =?utf-8?B?YzhSYTZGUVFVV2FuaWRjdzVLQmFheExsVkpzSTBnWk5rc3ZpSElTNmNyaDlT?=
 =?utf-8?B?YWs5RFR6d0ZzcExRTjdoUWNmTVF1ZWtJT3dyL3lpdXhqYWxzK0FZbVU4RHBD?=
 =?utf-8?B?TlNrR0lRYmtYSHhOb3hwSXNsV3VwcmVaSklWbFNoS3JUNHBYTmtLM1grcFQw?=
 =?utf-8?B?aSsvUDMwbW1FUWpTWkU5dDQ1c0szcktMK0s1cENuUGVvbzZCZEc3U2V3bWZ0?=
 =?utf-8?B?NWVaVXFkSW0wamdndVlsZmZkNE45MWxNT3NNdWRoa3F0SmFmN3lnNXZ1N1p1?=
 =?utf-8?B?aXF4ZHJTU0J2UFRoSVJLWS96QnRraUJHdW5qNks4VVcyRzF4NGFhcWlYUU1F?=
 =?utf-8?B?WmFURElYaDdkNmRkWE9mWWxZMDE4Z2NtR2hET1lqeXpJOUZlYkEraFJsVlBR?=
 =?utf-8?B?OGFXOEFzZFUyRnhOOXk5RVdsak5kOU1ha0pDZHhRVHpTY2syTDJrYUY3dXdZ?=
 =?utf-8?B?aXJ5bjVoNkY1cGxXcjBSdFR4R1ZvWko4dHNxOFVMM0ExdWZCbFJZRGNNa3FW?=
 =?utf-8?B?RUlWUVpMMmI2YzFsbVdsNXFldC8zVkt2N1FCL1dKTG9JL0M4TnJ2NzA2Q3B5?=
 =?utf-8?B?YXQ2NmR2b1lBM051VW9jY3A4TDVrS0hTRHZmMGxMbFdORzZUc0RHNDJ5MS85?=
 =?utf-8?B?VGNRcWxaMEl0cFJRdGhsWEFjWmdHVHFhT1hYRUYyaVgxN2sva3RrN29YOFVM?=
 =?utf-8?B?NjVpVWh0QS91MXVQb09wOXFXRTJpNExMTDFaYlhyek9JUUlEQ1YvME8yZnM4?=
 =?utf-8?B?WWpQSXdsN3VyNDR0TWdKbGRhS0M1T3g2U3lDVFloRGZaWVdnbFNZZ0dieEJk?=
 =?utf-8?B?clc4VU1aVk9YRm0zWndidVVtZHo5RS9qcDFYSWdhbTZnRU1iYmVRcHNucFor?=
 =?utf-8?B?SmxJcXpEUG1uYUJlbVVGdytnSk16Q0R6bzVTczlUZlgwTHBGcENzMWhOMTVF?=
 =?utf-8?B?eStxdnI0dkVqcEtidHowTklZT0Z5TG1neUptZ2hPaFdrU2cyZVI2MEJNTHU2?=
 =?utf-8?B?ZWYvWG8zZFZZMmljR29IQkNOK3hnMHU1Q0VPRDRkSG1xdzhTOEpZUGxSZGVL?=
 =?utf-8?B?LzBpM0VrcU5uWDBYM3F5VkFhVXlDS3NsYlJMempQbjg4VWRidFpucTNBZWlS?=
 =?utf-8?B?N1ZMeGNKYy9kNlg0WGZHc2RTRHQ1VWEyYkFoeU12a2JpSmdPOVpsK2VVNGNM?=
 =?utf-8?B?SWZKNlQ2dEo0bmtiWkpvbFREeW8ydEVublUrRlNSQWZKVnBPWFpJRTZITDFD?=
 =?utf-8?B?S3lDMm9FRm9KbUluSmtqbGRqa0Q3R2pVUDNKZmliSmhocW1tQ3VrRnMzeW9h?=
 =?utf-8?B?VDdJZTBieVZkNnNidXR6UEhXR2s5ZzNvQS9PM0ppRXk3MVNZNklDc2R6RFph?=
 =?utf-8?B?a3RXRmdrQldmLy9JMENpZWFhK3hKdzJoTkUxTGx3dVN5ZXRna0dBYXFvWUFR?=
 =?utf-8?B?UGM4MSt3MndxVHpzbWNGWVpJdE83Y0dNN21BY2pRbTZtYW5CbnlFTXV5Yys2?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a053c95d-d4a8-4aa3-5fdb-08db35b99560
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:38:59.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D7EH+k6LSYH8uuAL2dTvrKftK0pG/eibr8q4eBJQEGdh1CTFhsdEwC3FaW/w+wSfOBBFSD4HhCIY6tQtaSZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 09:39:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11178

On 05.04.23 09:19, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Align same coding style with other scripts.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  scripts/deploy-cip-core.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index ab98468..b185a84 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -17,8 +17,8 @@ DTB=$4
>  REF=$5
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
> -if [ "${EXTENSION}" != "none" ] ; then
> -	if [ "${EXTENSION}" = "security" ] ; then
> +if [ "${EXTENSION}" != "none" ]; then
> +	if [ "${EXTENSION}" = "security" ]; then
>  		BASE_FILENAME=cip-core-image-$EXTENSION-cip-core-$RELEASE-$TARGET
>  	else
>  		BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
> @@ -28,7 +28,7 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> -if [ -f $BASE_PATH.wic ] ; then
> +if [ -f $BASE_PATH.wic ]; then
>  	echo "Compressing $BASE_FILENAME.wic..."
>  	xz -9 -k -T0 $BASE_PATH.wic
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


