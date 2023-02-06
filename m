Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787CC05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 13:01:34 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.55])
 by mx.groups.io with SMTP id smtpd.web10.52500.1675688489637503222
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 05:01:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gnnYSoqt;
 spf=pass (domain: siemens.com, ip: 40.107.104.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsXVCa/CkaH8d7hbp/pljle3sUxvY112ZEqrCYLUsAIqGKVHPaYlybVZ2YlpRTZSeE8b2dltzNRsYNzhkmCwID9KOJcsF/M01dnaUUA0AmzARcz9vcpel4PDVDJLbsXefe3Njcam77YW8DsYSmp8wr1WDKUXuMRfDx5gfPt8B/CsXAEUIlf2xxulr2Xc7TW4DKard/j1dM/5K04yro5BEbyCE/4PIOKlUeEPCBc2peSq/eynMTjHf2ZaJbjFrMSATus2SdnWgYkNbLETwRp+v5iBjy8qwf6RReXGw/x469whuP/GliPBW41Aeaobgn52fijaa8TEy8OAR94A0r6bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDf3qWN2r/OWu78lVzEbtbHOUFJIuT3Ur85K1DHkcqE=;
 b=i5HmSePf3bB9f7UBW0w2rcCzZ23kTGPoJ/u9WDkM726iuBptbYWYEzTljprVkrsIyq8gn0Y1K1FuxjfHiG544sGops3rEi3RrXOUOx4n1eEenM1Xpc42BOOIKWIaFAGa50n8PtzMgvegFMGggcc+L3JuQvGf/Ie2HiSGNh7+i8/epddCiF6hTn2A2gxDQc0KsoczBH3YU7uNFtqZiexdd6eQt+5aP/T1ZP+7Ulo1HJYaCu8rI5ox6yCmQGCNRBSeYT6GD5yIXhSHpYnZZkSKwEB8WlPoMOhHfgKM+UArYzfkG0+lv9hkOq2BfI2HAYfemcEW/LXDTaxPcJVMrqXYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDf3qWN2r/OWu78lVzEbtbHOUFJIuT3Ur85K1DHkcqE=;
 b=gnnYSoqtT1crwItzpqZ5BK1MA9iBkcnMuRkp8wlcdhpB9m0Ud4o/+5J8IxydASPC9pqNl9ODZCZD/D/XTe/eRdeaa+52o+JFAK6mcOUAXZCyeetNmAvzH59/8LDJRAOI4FlguvjtCn+ci7cEeX6VDieHcEMcaYQoPZM5YsTINp/iMWlzNDDM1SMEPgLEesZequxLOSLzNjRp5VcN+ok3IcUdTWfvZkeznK+Ti4LHpcVsumE2tRn83yRLzQfr0P5tsDVGmy2SOvJmxT47ddk+yQAkYreJi30Khsv7ee2gMC1MmQIzv1iDBLMXVkKLePp9oNu9qogwf2L1X/8+2ggRpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:554::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:01:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 13:01:26 +0000
Message-ID: <d5ebd21e-547b-1f94-8f38-986aec3ae39c@siemens.com>
Date: Mon, 6 Feb 2023 14:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core] Update ISAR revision
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230206115118.930-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230206115118.930-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: f3595367-7ca2-4446-cf3e-08db0842418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HStzMbDFMaLkHvBS6zzshGclV7R1YHkIGpHm8Un+Zz6Z/C71pNrMziTmt2OW6U8JH4M5RHUan5a7UaKcw07nVsDHrA2B+lRvyitQaV7TurP6Er79f6Hw8STLm0Ql7tTAPXXERIh9aQQ0CNVlHVtdg4ba37DrhEUvUHbcwnALc65igJum9ujoOtjUT0ZqkZijsYExk+RaQvsRqsaURkmMtyuscThNuhuTfL1hH5C3E+Yk6A4UMZQZLVJFizi70WXF+t93YXY/QbiChvKaeSjstbHvl8/V1EsKgx7aaKziAL2Mpj4sm9VrdXIhBzTCPbPi1kR/sulqHQJ8FE6O4d8ENdyfoIbogku8ywsq6ozpY0m4CZXk2GLkrPFz+J3hrPTKQTL/BdovqGvAFzPa1eFrrpWkY0nGTXY9cpVzOUXE8OIE7gKX6b8XMaGCzYFx65rpG17OZI8IjKIuXsNXwgLoIACtVIrtJFZzUYdE7MW6rCqEV3W6lTE7b9yQMHnfWmMIjorxpiRFa/tYkbq4Ml9nanH9gYGHK96I2FPn1cMQBeUX6dQ03vy48kkNtp5/C9iCx8Dx8l7ec+uhovo5S4bH6ACERnuAlTCqg8llO2MhlTq86nu/GUylzBqfOZ6l/Y8Y0Vvo8dGjsBOWJqGTfl5eBtpHiRtwHbtmK1FpnUAI/UfSoTnTcc2qcTbDGGJgzLG4DF5RzuBDp6PpmbsAOOqOKY73u3c1ak0ZRU/OO83glOEtmcTiK1cl+EKUZNAJkTStzxWouIhPm6MAWEh5jPW1sQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(31696002)(36756003)(86362001)(38100700002)(82960400001)(66946007)(66556008)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(2906002)(15650500001)(44832011)(2616005)(83380400001)(478600001)(6486002)(966005)(186003)(6512007)(53546011)(26005)(316002)(6506007)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1lzdWd4SXFvTmFJVzNybmNMVmQ3RTZQU1diRmZJZk1CZEM4eW96aHVVYlhI?=
 =?utf-8?B?cFV5L3k1dFdiRFBPck5NN1ZyV1AzUlpFN1R1TGN1cUtUWnhhQ21PUExRZkE4?=
 =?utf-8?B?cFdDQkFCQlUxd1lNcVFRM0xvakNrb21kU2JyTjh1M0doT0d3TmNQaUxlVWZl?=
 =?utf-8?B?YkN0Tloya0RVZ2dubTVKK2wxRXQwc0ZWWEVmK05aMWtOeWxkeGQ3U1lGWVNU?=
 =?utf-8?B?d0l0ZkNnN2hGaThuZkpOV3pyNjZTWFlNcHQwVzIvQWlFNUJpSVNDc21tQzZp?=
 =?utf-8?B?cE1rMHZnQitEbk1SN2NZT3VrRTZjVHdCbXhmUUdJSStYN01VMW5hSnBnM3Rl?=
 =?utf-8?B?eVA3T0VkWVZBMElTN3hQVXdPeFFvYXpMVitFN2lwekxKTjYyS3JkQTFacTIr?=
 =?utf-8?B?OEVyRWUxc2ZrS3A2SlAyckRoOUF1YWlRYVJsWldSdXpxRm1aWVZ2dEZqNVpU?=
 =?utf-8?B?L0dxUVFXT2NlKzYxN0pxbDh5LzR1VzgyK3Jta3lLeW5zay81YnJDOFRubE1m?=
 =?utf-8?B?T0x1STkvR2l1VDJVOHoxZWJEMmtXVEdkSFQ0M1M4bDgvKzRsbFRRSGNiVERz?=
 =?utf-8?B?ZlI3a01sei9BaXZRZmFzZmw0T3ZxekIvVFdCb09Ld0RmWUdndUJjbGdjQmkv?=
 =?utf-8?B?M29KVEN2cHYwSmVVS25TelZvUmxpdk9LWE95QXdrZW1ySDBDbkFyWFlHZm1V?=
 =?utf-8?B?M1dsRUFKdk42dytVSi9BTGt5Z2pJOEVzemZLd1RXK2wxWUFqZVR5bXh5ZENR?=
 =?utf-8?B?RXJtcjIvM1ZZcEVNeDBBMmVPbnRNWkRZNHdlSENVak83T0ZPZG9USVpPU0xD?=
 =?utf-8?B?VnpWa0hTQk95SzM3RkxKYTFSc2FMak5kUDVjZ1lCWmpCUGNCWlc1eVdLbXNH?=
 =?utf-8?B?Tk1BRUxDTzZsTXZnMVA2djFTaUhCdTJRaWZtUTBNZFRoWGdJb1hOOVZOdERS?=
 =?utf-8?B?ZS8zUHR0QlJYQjhQYmEvS0xUbnNDTzVpNXNwZ3RicGI0Z0VPeFpyazJoSDQ2?=
 =?utf-8?B?eDdQUElvMncxSmU3MzY2SzJkaFprVk9NUktZOWh5a2lIQm5QUXVMQUJJZCt4?=
 =?utf-8?B?VlI1WS9qNW9SRjRrQ0NVQlRIVkRObGNBbEF4THNVWXJvY2VRck1mWkpXdmdD?=
 =?utf-8?B?RjROUG83eG95L0VlSXA5VStpM253TVBqT0NyMUsvMVRtOW45TzBDZVVZQUxu?=
 =?utf-8?B?QjBrY3pKUlZ0M1ZVcUlVRmRZb3lMYjZUZEpyRE1uT0tSQ2FROS9wdERvRFhu?=
 =?utf-8?B?dnU0cFRFMlFKRHBIRVdhZ1VyL0pkV0JMOTF1K1N0M0hGUzlvVnNQVXA1U2Jt?=
 =?utf-8?B?L0lrNkdsQ21iaWFIcWxGZTNtRlRTcGZQZjVFNm9VZzZ4QXB6dHJrVnBWVHBq?=
 =?utf-8?B?cThSSGYyamxCV3UrYVZ5N1I2eWUrclBuT280KzhJNmROb2crdkQvdFFFUjRp?=
 =?utf-8?B?TWVHcW9jTEFZNjFwVm9zbjd1QkRneEZGNlFTbHByQm9acHA2ZTBLZUtSSHF3?=
 =?utf-8?B?RllwYWlPL0tkNHRUZ09oZ3RpallSc0VsbmFjOUJTaldLMXIzRWZpU3AvMzVF?=
 =?utf-8?B?U0VrbDBSZm12Vk9ES3BOUmJiS3ZGb3kzVURYSjlZQlpITzZnSzUxcSsrU3Fv?=
 =?utf-8?B?TGFPa1ByNUpiaVB3ZGVIRDZhamkxaXAyWG9MMzB2N3B3UXc3cXpnYjIwUE4v?=
 =?utf-8?B?MVBJSFlzbVdGbEo3V21PTVlyUFhQdlNsRjBrRENjNWc0enMxeVdUYk82c0RI?=
 =?utf-8?B?S2lpN0kzTGppVEp2aUJYV0h4MXFBOU1TdE9va3VvMmxqRzVLdW9RTDAwS3Bn?=
 =?utf-8?B?YTVua0xvMEtDaEpsUjgzL3d6dVMrN3hxaUprNFhxbWNmU09ZU2NlM1dDbUc2?=
 =?utf-8?B?bmYyTlJCRnViNTVxM0hwVnVNeWFzQjNQTUlrcmFPa28xTnZrNGVVbmU3RWVq?=
 =?utf-8?B?enhoa0lqMU9FZ1RGVDVPSTc3ck5BUXd1UFRsRHVmdXJ6OVJud0E4bUlJNUZU?=
 =?utf-8?B?R0E0OEtLQWpORGxzc0NKRWxXVXMvSVRKMFgrK3hHNGVQc0NpRXRadmpGRmsv?=
 =?utf-8?B?azZ5Ym1peVIvOFF0M0J3NkhQQWhBVzJQZVlrNm9RcXBIbHIzY2FrT2xNQ1Zs?=
 =?utf-8?B?SjBxVGpTRzI0ZldnZE5BcUF2VFN4U0Y2cWVEVkprYndPT0puVk5CMmlPK1hv?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3595367-7ca2-4446-cf3e-08db0842418c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:01:26.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxD8h5OoeG3DxEvHgEUML2S7Ank1kcChCjZmr4EWZFjOozr1B7HwG9X5+U7UHB07Eccpe2wZobPmigOH5Vhg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 13:01:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10606

On 06.02.23 12:51, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index b970f39..049eca8 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
> +    refspec: 73f0cc16ca50f1102084851b1bc0f2d59925c9ad
>      layers:
>        meta:
>  

I have an update to the latest revision pending, but it is currently
awaiting an upstream fix. Will bring bitbake 2 then.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


