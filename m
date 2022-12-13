Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CAEC4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 12:50:07 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.70])
 by mx.groups.io with SMTP id smtpd.web11.72553.1670935802775981250
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 04:50:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pKxYLIwX;
 spf=pass (domain: siemens.com, ip: 40.107.6.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHZaACxTDNnTitunYa/vvlbqME7D2KoiEzoMRRBUWO5RQ8fnYAhulBuFxeco2SGP6ZbG5rLqHymo46VV2AFikJNPUA5EWOFk3eFhMnvy9RP0tCVvKo6UjYtlNt7TuYd/iIYu2lTaKMN/r+Gjt9hX2+4lsi6/I3tDLbKV4xuVQjhtDDQyCHpAu7A974jYCxAXt76gkB6qQw2UN3GVgpvnF6bObqGPutA1ZM+aw73sRFnrICLM9BfEI8FWl+4zD74modMDE9G/y29nR43WVtISHiobbtwRp63jb2oO+swEDaGTB6bwu2tUb5CXONdiOMKJGmOXhciI8P6Nxkinc7VNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUJHMTm3SH9gJ6XnH8oh6w9zJiC+98agUr+aaYzJntY=;
 b=kuk/WzYuga9SwYpQR/zTFqb5p4fDFTZQHZ0WJC56Ui7ovrVmYx+7Z7Yv9qsJNTD7ISDNj/eKKQjAjwgFvkN0ARq6dZF7sZ8VYpqCFmkCYrQG2HpUD2Pw8L/jHEmXoDxIq1vRUeKx+QqeF1glaZhdzSbFUQ41d3WKxjTEDlxUmbg3kl5vlvecjc5VMCqtHKjQ5YVTNAuJNC1Y25JHlRLwv8FLIJl9bw+PhJd/GLmk60YW97rnN17+UzqF9IbNu0mvxianPA0iQHnwXbKWpfOBc/Lix3VO6d6IGhQoKDxBjcYDEZ53HOR2kYjh+GHcRew3N9KeC7hoRD9cNmmEfxoYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUJHMTm3SH9gJ6XnH8oh6w9zJiC+98agUr+aaYzJntY=;
 b=pKxYLIwXOZZzdYy4ed08/azFc9og1uV50cn4dRhGrSRdUn9Ze2jm93aNf3YMp4GxKZLNYo6gOXJauKdvGmoX7yN8VJ1Qg/WLCpqCXUY6r92/GFAOUiuFTnqUpAkUsVsqquv7za/CxARFmNVbXlHEKsbovpdQ1ICvoZnvh33+bLBUWlAimoj5fWFu3ihCNIqTEvc4NyYBxUG8fuIMRAqIU3M7gcH5NtkF6ykacyxZWPeCaM9rNmK2rrrov/1NaDSmw4BKjOyYxR9aIx5ylqiDFYeWk5HLYN5N6GM8xAwha+K5CvsyTxKDIOQhlvkq+bao4ZmRXlfyvTVpqNHoFXE7CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:49:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:49:59 +0000
Message-ID: <7404ca3f-0457-3a22-38cb-73596b5b98e3@siemens.com>
Date: Tue, 13 Dec 2022 13:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/4]
 swupdate-handler-roundrobin: Increase revision for configfilecheck
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <20221209145827.1309521-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221209145827.1309521-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f03c5a8-1737-4c80-60d7-08dadd088b74
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mrBp1P+qBEVMw3wjIkDc7p1UrbDDq5Gf717oPNE+YQRWhTtU6ywklUXS5pd/3FgZDMUOjDGODwYaUAPkDpAnzMAfezfQI6mQiHeKbQxfKoC1lbYhWH5K3CW5ue8IFxaL/wGxvUeEO7sZey1/4VTox4IdiuB4lrradOTuZoC5sQSFReHy0dBapFOkYxSybY7wWjXgmh6yGQ79MsI+KPOgFCT4VZe/DazDCZZlsNwHMhgno1JTkllSuFCzW8/ngVBUByj3hGViz7V3YVA5GTUAaiOud76/MsX5zXtYwHUTcCleazkviw0lC8RdBXAYSGxCUc5mBZZ9I3+F9JjVCOl6vU/mQPTBn8jXxB66lgtf7C3peDpcotiUg6Pc8YR0S3xayBgzSIAED8oCVc0UI1XUvjAx7iw+yPz2zIr5exkREm4xJYhNfjlDLDoNT3gR6L1jqMDTK6my0RNrBswSBJgXkBybKmTKlCHvV32eiALcaNDojhUJIrgnNNH15EhFCc+x9FfybKwt5d9ntq7udIH1jSLd/H9bkfc3rUuBVGu6Hwe2+obGfp4FLPNkR+FpHfww492abZhEUXrVVV1RdUw6I/DWcU3mFt97y4dmfildjARGVL6WI3HiIMqt92PlbEKvPJHvl99uZ3y+gtbOUMSLQXy2Ql5Y7XKfnEUHqt/fn5d+Sn6Vkm9OVGqq1dR6CdCy/h/pM9F/3YXaGI4A8RbU45IQ3SWdVX2iy83PpTubOvE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(82960400001)(2906002)(31686004)(38100700002)(44832011)(53546011)(8676002)(6506007)(86362001)(6666004)(6512007)(8936002)(5660300002)(316002)(66476007)(66556008)(66946007)(6636002)(26005)(478600001)(6486002)(41300700001)(36756003)(31696002)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDErMG1rVEJSVlVLWDZqN2tDVzFkUnIzMVJsSWZ6UFI4RGVvQ21xRk44MzQ1?=
 =?utf-8?B?cmtkL0JsNm9mWjZRek4zUWZRREtrbmNRVnc2eXFRVUc4Z2RLNjBmeWpYaVJY?=
 =?utf-8?B?dVRyUmwxZUJHU05LaW9jRUlsdmhRN2VkQ0dIRkZGOVNLUHRWVXkzYmpiazFk?=
 =?utf-8?B?SSt6QkdLb2Y2ZXU5MjByUVl5TDgxYk9wM1Y5RFdJbjJraXo2djA5aFdCTndY?=
 =?utf-8?B?UHBTdnRsOGFnTlNRUEErUEhQUGpibXYwd1E0eWtCRm5pRGJHeXhtVVRhRlR3?=
 =?utf-8?B?a2hHSGY0TjBGdkFzZ0dac09STU9YOGtrYWx2UDdjQzNqS2lLVmRnc1lrbGxI?=
 =?utf-8?B?TDlZakZSK0NFeTZmU3lHL05MSTZQK0ErblVWcDNFRjVrZEsrZlVHVmxwcmc2?=
 =?utf-8?B?cXZIaDkxeUNheC8wRVhRZU9jTDJSNXRtalRyS1Vsanl0d1RMRXFSelhtVzJ0?=
 =?utf-8?B?Wm9MKzRsQnMxOWttZ1hjZmdEdmpiNXBsQWtnVDZqSndNUWlBWUxNY1lheGRZ?=
 =?utf-8?B?NHZIb04yZXA1cWd2ZVU0UzZTdjNyald6dHNtMGdEcmxRQVNUNTJ3cFlNUHFh?=
 =?utf-8?B?dE5KTXoxZitSVXhuQjdoTnE1cUw0bXBJa3ByeTR6dFZXNFZoaFlEWDRmeWNs?=
 =?utf-8?B?Tmg2YldOQWdVSUllSWRNTUEvQWRtdEZqSkh4SVArSXVsRURONThyTlBoK3Yz?=
 =?utf-8?B?Nzk3U3Zta0VRUERNK2ZmM0hvYUtyaDVRSGZhMU9ZWENaVEtoSDlxYWQ5UWti?=
 =?utf-8?B?WTRCT2tRVVhGOXJ6eEpoN1Z2MzViVXM3NXFuWFYyeGJBdEwveUE5R1dTQUtj?=
 =?utf-8?B?N3ZnZzhPbGdVN1E3c0RJL3dJRVQzQWI1d2gyeGYyZjdLRm5ZL3JDaUhXRm1s?=
 =?utf-8?B?YTBSWlRja085U3d3YnIxWTNJL2lwQ2VJSlozYUtIcVFwWXF1NlZRSkFrZEsz?=
 =?utf-8?B?eVRjSmNpWUpxemJEZWJqSi9DdEY1UURPSTJyOHJ6TzZtcjhDVlZMQThIek03?=
 =?utf-8?B?QzJTQTAzeE1Zbys4RVFTeEtMVEN1UU9YZ2xncy9ZUVhsYnR6ZzlkWlRpS2R1?=
 =?utf-8?B?OW5la0U3NU0wWTZyRytPQzRjMkswekVMQlZpRnNMVHNhT1RQYmhMbmRiRFFF?=
 =?utf-8?B?WmlDWDZCLzI0NmRqbmdDdGh1NHNieU9PNUxyajVaZ2lZTjJZZzg5eG9IUWFC?=
 =?utf-8?B?MWxzWFo5STRTVGZSQTRvWDBpTXpmNzI1M05ZSmpzSVF3VGltbm1zdnM5VDRP?=
 =?utf-8?B?ai9PR0hVbjloblNQb1U3L2VLRjJGdE8zWDcvdEZMQjZYbUF1b2R1V2x3S29D?=
 =?utf-8?B?cDZYNXlaTEJ6dkorTEhYcWJLbVA3ZXl1d3RncENJT3FSbjhJZnpyc2Z6Ujhy?=
 =?utf-8?B?aTN5dmhjOXZQbEtnYS8wOWF4U3J6cmJ0cUI3cVZkQ3FVaSs4QW9yQXh3ZW45?=
 =?utf-8?B?MEZzYzRDNG53WGpMenJRLzdxQVIzSjBmcnpOcUpHQm0zYTd0aTFxQ3hyOXg1?=
 =?utf-8?B?SlRYdThxbnkrRkFqSnA5Mm8zcEQ0MzZ4QUY1ODlVaEc3NXV2R09QMXg0YXZn?=
 =?utf-8?B?R2RYU0RwT0RzZUxkYUhHYUdFOVNkRFdFaTljUEJvN3l3eEJib2JvZEFBZ0py?=
 =?utf-8?B?angrQ2IvOE91UGZsWm0rOC9HWUJYMXEyaVp6NTZpbXY5bk5IdnhCdVdBMmRJ?=
 =?utf-8?B?cFBPVDgxenQxb3k0ejFJL2gwQkdFNENwOG5kQnU0N2c0czliV1hJbVZTaFpD?=
 =?utf-8?B?TTBKUWdHOEdYRnBTMEEzRUt0WVlvQTB6aWZzZ3YrMzAwRlZlTVhIMitIa2sz?=
 =?utf-8?B?bUxiazR2RkNKOFh0MGNMWmw0alE2NVR3MEJITVRxNXlZTllHQ0RPVG9GYVVl?=
 =?utf-8?B?SlhXMWhWWUxQVENvQk9mMjkrMDZRdVlkZU1SNU8rSTlKcE1KZkFPUnRGT3VZ?=
 =?utf-8?B?NHJpcWRsUlpRYmJvZW5IWkJSNjk5QTcyaXJKeVVwYy9hZGRMZEF1UEYrb09L?=
 =?utf-8?B?QVNZZ0haUFphTEJLZU55dDcwUmpiR1BsVnZpcm5CbVhUQWEvWHpqVVcwVzB6?=
 =?utf-8?B?QThmbkxOeWt4cWZ4dGE0QnIxYldhWTVpZU51OFVYT1czdTlZaEJRYU1GQjNL?=
 =?utf-8?B?dEorSWREQ3RBdDN6Y2FCVHN6VWtQM082dTVOWHJIZzNldDExdVY4VEpZbmZP?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f03c5a8-1737-4c80-60d7-08dadd088b74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:49:59.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrqSJDsM8i8q4v/TDjXuftho+0UkyTJQsaK1Crm3//9blR4zflS2lsnKcjCkmn0yesmvr6HLEpDtudMp/FU4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 12:50:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10213

On 09.12.22 15:58, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This new revision allows use to check if an update is already installed.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 5801113..b39278e 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -13,7 +13,7 @@ inherit dpkg-raw
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
> +SRCREV_swupdate-handler-roundrobin ?= "bb35127231ec08a67f79a7584ccfc0cada88cc4e"
>  
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  

Should we also bump the recipe version, even if there are no
corresponding upstream releases?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


