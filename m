Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C2C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 08:05:33 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.59])
 by mx.groups.io with SMTP id smtpd.web11.2089.1665129922179435734
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 01:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bw3mkUVA;
 spf=pass (domain: siemens.com, ip: 40.107.15.59,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpMhqaqwXjLesxnIKs1tVddNEcImqcgCWbjaOxUqzngjF3W429RNUz053JtenVxcFq2bx3PLTWAeKHaH1WDhR1sqnJmKZwaqu4g2xteKfpcc17wO78mKEY+1QK4L9M0o7JewY379xDsTRQJlLgDJB4Bz3LzBVkRti10wizVM/LLIXi4qa1WtHqdaZG6NjgfcMlqGOA2DpsB0+RPcqwQcfTKfZlmL3g2esm2mGxHiXq8Hpja9+/XPE7BaFhROn9B64HpwNuuE7P/8qTzEmvgfdPoRqokGomo00+cBCtQxHZ/z2ZTD+R2rLUO5vdv3z1EEK6HrRTYRetc06EyCN3v6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnhPI4Djdyu7deBr3+MEGvrrnWDHXlHTF1C+4NO7Wn0=;
 b=i5+RUeIw1mNojKInACBgeKaQaOH9ErmW3fnyZnbOzba5vPMSDAzgvK2niRUaYmtbabBzD/0CdJwRYYMCyKRsb+3BsrJgU4Wb+/Jv3Lt+eDyX2J9d+IcawNMOF/nNIzrTL3yr/8R36dVqtXxPtTgMLxWKm7an/1t0w4fPF6f8S7T6J/YGxG1dJ54QF6XWcBFy9/IYRNRFxxt7F67rJI26oTrn5gB3eGvDAaAX6EPzw+Uj2epLE6AFgEWleQT0leDpdn4qWXfygfzVJFAp4KrSwJ/oa1PC1aW0L4L5CpYSxSGQMehKAf5B0YPue00gIioljrJnJ7CI61KTis/RUooKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnhPI4Djdyu7deBr3+MEGvrrnWDHXlHTF1C+4NO7Wn0=;
 b=bw3mkUVAZ9U58rWGUTn94ZkG37qsIxdTgzL8dxQLTBQmtS6ZKQB+0PWc7ZjEyz3pZntUrdh+XjOEbHCUuTTke/4n1kue70ePtp1nEnrEjKlrhTP/Ya/IZv3qEt5PEyV2PcT0KwISWzw0DtO4bK5tk4KzohpbmlyMJEhoBxHvb8NGBMKKsZMLLttqsD6M945Jf6W3/i70MiiywrMVsvwQ94dA8nf9CiK2EfnR6f4EeEbHP5UjsPi5eqrE6IbuEgYV1KDgG/rYBoI/q4kFq7PjYBYLOYI1wtU6vHX3MeP4t0WMPIYh7HnF0Z51Rizh1El4WJ8sogJWJuLENaCNRbqMng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by VI1PR10MB3342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 08:05:19 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfd:6d9c:9cf5:9e2a]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfd:6d9c:9cf5:9e2a%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 08:05:19 +0000
Message-ID: <8faa341d-0e6a-a203-b12a-673d6a7e3211@siemens.com>
Date: Fri, 7 Oct 2022 10:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [isar-cip-core][PATCH 1/1] layer.conf: fix sstate cacheability
 issue
Content-Language: en-US, de-DE
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
References: <20221001044712.441683-1-felix.moessbauer@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20221001044712.441683-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|VI1PR10MB3342:EE_
X-MS-Office365-Filtering-Correlation-Id: bc366114-8d8f-4599-1d77-08daa83aace9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RW0FJJ1QhJCa1p59nztSCum7OfUpcEfL2PF68Ynwd3YsZMESwNvx/Q7ZNWZqhj7o7ktj8V42vRAM6ErwvbKPdHUFEIjyRKqvLC9iwsLp+5G7tmBVVpkOWeL/UkNqBliENquz5HKxzyNuJk+TKiV3WCtZ2C9MLYUiXILu/so+9ucJsBMk+UAMxKjbhtbpS0hKgmLohTfIjvN498eo/fl3xG0hiOR8udVQrIO3TpToJt3IcOAjj7u9kPuJx+7UvCYMhdsfyRAJMCYgvDX7u7E046he37Z7gucmt/yH5kMGVZiP5KPXhp3i3FXs+DhKSMCS5r7gvbA7iTpMtnO9/ZByj+SlRpWgr+79yR8KgXxpWNy8Maze4q5uvnhKy7Su0CmjdQCHEx6TeLmLmFJJ8NS6hAJD8y1TFXp94f+OxfKLhm7uoN41Bd3DXybLRc4V1VwK7XA1V5E9m/y8U4M0wdGbjKMAnf85bVYEEEshTEmAO1DPjHlJhk/zQa0KyeP7IYVY1TFiMgb1lFbikruJtP2o5XsMFK4my6stH/45TtFcJ26vVDP0v4PM1ZBwLZgMZ8uPgXboRlzQ5GOdfSVE7uF74FfqDvQ54VjnAwgduqzJR0lCAg9AW10uL894YLrr0hgFnIq3Bs8EqhYw2XyCVA6rmhZtereZXNV8tvR3iNsce6Mx5t7oeDWwE7vvJARg8gxVnt+sFsaUBuubrzSURfeCFFcBold3FvnrKzAX7H81XRfz8GaGTLlt1P/FOjXztUPH8c9w1T+kb8opGre2YUJSKiosCdUNj0gqC8jNntKXQcY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(66946007)(316002)(66476007)(38100700002)(66556008)(8676002)(6636002)(36756003)(110136005)(186003)(83380400001)(6486002)(2616005)(478600001)(86362001)(6506007)(53546011)(31696002)(82960400001)(6512007)(6666004)(36916002)(4744005)(5660300002)(41300700001)(31686004)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWlCZllFZG9jNXU1VCtYdU9QY1E0VjdHSmdXTWtKRmxtSUZacXBIaERIalhR?=
 =?utf-8?B?OWdTdFJubmFadnlhVklabXhkRmpoTHdiU2pVZkNObndGOWVET1lWaHNVRjBy?=
 =?utf-8?B?L29sSk83RWsyNFNVeVUrZUtTUDd0RWlJbk5EU3FCNC9CcjRtWjBJN0pGZmUx?=
 =?utf-8?B?MWw3ZjZjY05kZHZEQWR2QUhpMFE0TGY3UENsOEpMYkVkVTVWRGtsdWJJU1M3?=
 =?utf-8?B?bEd3c0JZYUZqVFdsYUJXVXVYYW5nQ2JhSXIzK2JST1NTRmVBbm5ORjI4bjFM?=
 =?utf-8?B?L095RFlhQXRMY0VTUzl1MnAzTS9VM1ppa2h4MzREdnRVQlhoNGM2UFhoWTBz?=
 =?utf-8?B?V2plTDZxTlorWWdnaWQyK1dyWGlwS0tBZGNHWkpDMkg2YlBScnR4aGdZVTRv?=
 =?utf-8?B?dTdEZ0V4ZlczZVFEUFJ3M081K3NOMVlZcFdETTVQb2FpK09KU25jbFg4TlVO?=
 =?utf-8?B?MHJSZERRNWw0T09kc205eFppUWdJTTl3bi9lc1BMRHduUjUwbmpsOXcxNVNW?=
 =?utf-8?B?L1Z3ekVuc1o3eDdLVnVlc2hFWUFuRGpVMHdWZTNadHNGTjZ2Um1DT0NNRUtC?=
 =?utf-8?B?cXpjOWxIT0VndDlPSXA0U1NEaFVuQndKbUlvS29ESHY4RDlmZW1mWWV1bTMr?=
 =?utf-8?B?UDltUnhhSEhrQi90SFpzK2FzM0crc3JnbWhKZytsS1lVeUMrenpBM2VGZGp1?=
 =?utf-8?B?emJvaGNxSTdZaTdUQ2d1NXIvT1BPanI3V1NPeFc2YWkxRXFvMkE0cHpGVi9m?=
 =?utf-8?B?cGZFNnZkcjRxeGd1Vm1ZUnZMQkJhOU90US9BdFZZNGRIUmpEZWxoaHRzVS9B?=
 =?utf-8?B?U1I4eDZIeU1ncWV5VENvcG84SWdYZ245bGxtbE1RYk9uYy82eVMvek1XeElN?=
 =?utf-8?B?N042MlcrWDA5eVRQckVTZytUMlRTTm1QRkJYTXlkd1JYZlpXcFVIREVodU96?=
 =?utf-8?B?Rm1kVmdZbjVCTVRzNGs0d25QdGgxZHV4UDZWZUlsRUQ0ZGRzMU0zZ1UzSnNW?=
 =?utf-8?B?WnFQTzNvd2g1Z00xMWpvZ2ttMWMrU1FEQzhmZnVqZTF0RVNRaENDNngyWGQ4?=
 =?utf-8?B?dERnY2VQMzBkaTRWNXY2cCtvYXRUYUZaeUNQTUVGRHB0SzFJN0JsNCtRTEJD?=
 =?utf-8?B?SDVxbFgwYWJudUdmVDdWRkZnbHFEWGg4U0FCVEdwOGhzZmlxWlVwa0tkVUxr?=
 =?utf-8?B?R2w3VjlaU0lxUUkzZkRxM09rQUpaT2tzZWFQYUdHUWpJdFc2N25HbCs2MVg2?=
 =?utf-8?B?S0Vxb0RPQkFmVTU4OXV1Rk9qWThSZVdqNmpVbXo3NmJFZ0czZUprWkVKdGhz?=
 =?utf-8?B?Vi8ySENEZGJ0dmJ6eFdxcjlnbzdjZXZNNVNUZCtwdGFlaURlakliT0J5Ly9h?=
 =?utf-8?B?dlRBOWZvY2FTTndyY1dXUE9Ua1ViY0w2bGYwTHlBOWxIVzVJanFTRHcrTkh4?=
 =?utf-8?B?Y2dtTFp3aXpkUlVIN1hiNDA4SFJIOEhLSlI2ODdjcHd5UmIvZmVWMmxXaTdu?=
 =?utf-8?B?MGZCYk1iNG1nbkFDQitsWVdJYW1YbUtteG44ODRmZis4d01kbGZPUWpNcFdu?=
 =?utf-8?B?QS9ubkc4ejZXVXJwbnNaV0NBSUV2QWd5bEsrSXJIOU1iUCtwOTZ4T2gyNlRH?=
 =?utf-8?B?Z2R1NSsrK0wvaEQwRVI4dTV1cHRCNlJFUW0xYlcyaVZGcHR2SVFjR0ZkZGp6?=
 =?utf-8?B?ZGFjaG04amZ0UTY5blp6YzJIazNScXBqK3Q3VWVLYmRJSEpzQytVb2NWM21T?=
 =?utf-8?B?dGwxa3IrRjdMSktkT24yUXA4ZlJVQW1ucDd5Q0djdURFU3lwSGRERVZZaWRG?=
 =?utf-8?B?aVVWdnJ2NXpjNWkzMHNXWFE0WW10bXg1NEZBem9oMFRYU1pHM3Y3TDFyTFdv?=
 =?utf-8?B?NHpoaHZQS3FnUWVCWjI1bDE4TEtpcWMwZ1Q4TUd6Z0hCSDJOdUMxZm9IZ3Fq?=
 =?utf-8?B?VnNNKzlXOTFHNHpRNFRXZG9BSGY4ZFlTR0tGS1l5azljNUx3UnZKRHlEc3Z3?=
 =?utf-8?B?ZlhWZ1dlOUpMUklyWVh0Mm1YQ1pJZTR5azh2ajl5NnV1M0JjeHRBbmlWV1gy?=
 =?utf-8?B?Q01oYy9waFpJVnJqTEhDT3ZJWGt5ci9JekJZS2RsM2NpSTYxcUpVMFZCZmpO?=
 =?utf-8?B?YXpreXhrekxOYitDWU1lVVh1Z3ZDSG1iNERRSDBEWEJEbXBWa0RrRHpOakJQ?=
 =?utf-8?B?Z0dGRjlBSXFKZFM5aEt2YmlaT3dOcHl2S3ppZXM5OWFRQmNhZ2dFTnpQMUFZ?=
 =?utf-8?B?dUF3QW52ZHFSa2h5cFBVYmVDWStBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bc366114-8d8f-4599-1d77-08daa83aace9
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 08:05:19.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 9iy52ExDnUfmfGLU0rbjqnBIogI1Eokm/Slvhyh0feExfxN0E0/cZFDIJUcB61bml6ULnTWWpek3jDWjSEUfWS5AgYDRB7yc8AAi9aTRrmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 08:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9667



On 10/1/22 06:47, Felix Moessbauer wrote:
> The LAYERDIR_cip-core contains an absolute path to the layer
> at the current location on the fs.
> This breaks sstate caching in case the layer is checked out at a
> different location on the next build (which is common in CI).
> 
> By setting the vardepvalue to a fixed string, this issue is solved.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>   conf/layer.conf | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/conf/layer.conf b/conf/layer.conf
> index cc0543a..891a0ca 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -21,3 +21,5 @@ BBFILE_PRIORITY_cip-core = "6"
>   LAYERSERIES_COMPAT_cip-core = "next"
>   
>   LAYERDIR_cip-core = "${LAYERDIR}"
> +LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
> +

ACK

Quirin


