Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF1C77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 10:16:40 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.88])
 by mx.groups.io with SMTP id smtpd.web11.7780.1685182591745493668
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 03:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g6TxjJ8b;
 spf=pass (domain: siemens.com, ip: 40.107.105.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzB0OIfs6RIxIW1oEe9idNs67C3guwB3fj40Ky/OuHrnctCF9VwmCufkVtVrQhS7jRlxTD/NL1H+PDtvYyEBjzL89Pt+NPFQbmAheTk5cTctkY9R1Z3T95bQuM7dedS3j0i2wEP060tnJ3Fo3Nx8fP7duYIlxJm1BuuR/S0rLoQ5fMKJ0eZ4ZsEYl0vcdEvDGRY3Dkuq8x1z7s1R1N8shyv94G0hrFouglDR4808jYyuZGpGamAsoGCOsOuknShvP4lhdTQuV0Eu4HfcgZc7jX0K6suhVMfuuSOF2UROPl0PT7n5CGPz0SxrXJPBd04ujYkU9tzgAmncvPVZVHQ39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXNDDdymVvNwl4wGbOK3fQxUfy7wTEKuPBTHkOPMAFo=;
 b=W2X6tisCZW+z8ucmOPKcFCrua0D/CCbfHVmnVBBbS3SVfrpUBLItby9jt4KSuR00PNK0XNxaRZtLt4pt5q0vRa4MvnaD5N0ZK5AtNXU4mhzCimgRJJI31TA2nMBYUEUJOCWbEaP+NQZSlIWpONir4cY9JP3VvuDkyBKHwzAxlGv0c9Wpku1b6AMS4gUcm85IV3EFhUbiWEO4EzZUDpuyBhuZFNKZPeAk4Si56T5vB6l2qb44a1+OnmpsBF8coaKPJ6vsBFsDRpxCuefQ1SwBFIGFvltbRIImibAQgS1xnVlaQSmMDhwLE7S1PWzg0NqD9B3r9yk8EGzOIdRxN1SB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXNDDdymVvNwl4wGbOK3fQxUfy7wTEKuPBTHkOPMAFo=;
 b=g6TxjJ8b2iJZ7h/dUrYD3LiK49nhzzPJmHcXIcaitcxcTeEXfgQjg0dcrLDTnXJdYt6PPFMVns2B9R1V6tSryzmiIO21hYR+tBX1zaW3lJmjOcCMT4CeeduVzh/zj0jqeVe3kiIRr90ApNRgHVk4lY81ng8hdOQRcfsbn0HypkXd2v1zq0pLYJH0BsYxbR8HCWUCMx+ZDXVp19Hzg8LYqhe+zv8U1/mD3/LbFe/Cz9fajJ+drUDcvtB35xOi3trCzn96+rKPRIZe2TJYE/0NPQ+m4ZpOHfcSyR8G60a9Jkaob/ARNJqO29FY7+a6DJCDg6nL/EpSSXVZLkWv3u81GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 10:16:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 10:16:28 +0000
Message-ID: <1e37239b-8a73-adf4-7e2e-b7667f51b484@siemens.com>
Date: Sat, 27 May 2023 12:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] classes/swupdate: Correct
 task_order
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230522121604.2175830-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230522121604.2175830-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda98da-2f33-421a-0354-08db5e9b6f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zXgRFoCVpwSgnEfiDsBDb1d8bs6gHdjM4/JTrqeiyWbaAJapLQJZYQo8MIJjTa+tooFoKz2gmzH3RoZpxxvForWoOMyKkD3xJJfnz5mByzH/RBxniXNY2jKTDSbKRQkFSeg0yHFz74r3mpfTULivaIK2aslJ3QiF6npvT9VVmLN/Lmyp2ocrTdN07Qfalli0pgR2H0arvPPdd4B1bZJj7N5bl5VLaT6P4g0yyYgL+pnw0II13unA2im3H+rHXijc4xoivbONEMBk6hDkoFkicDhEkNttY9wJAPf4SaZa/W2c7es+/7qLGAAwnAw+iybBihi/+m/Wg0RZQV2Snu4wPPNBAZIUHc6b5YtOPmSTM6mYTiXd0XwC7ISZJdPDrJPZjzOutCt5Ece4QPGQOGyLy0cc3Kf3QKsRen3NLJNCpeaO1eJfpAyo7NeyoRRDs5T3n6dH3+M34AQpbrg708k0jG4eJ6KFzaVm1dCohtDm0anjhYE/ga359N9XFeyGoHRAW6zKoKjKKiJ+hBy+c2mh7niD5TYyWPlvr0cWRDKDzo4kVBvPnLhZBMDHkcamb6b1zLC3S1oELH3ru0xXXS3B/TvuS0XU1UrL2QzUi0Gip/Y//HTQGNu8wxJBpJ6tvwl0eg7MLEbCIPjMKzxi5uesZg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(316002)(82960400001)(38100700002)(6486002)(41300700001)(6512007)(478600001)(6506007)(53546011)(44832011)(31686004)(31696002)(186003)(2906002)(86362001)(8936002)(8676002)(83380400001)(26005)(5660300002)(36756003)(66556008)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVFiTTRrRXY1Rit0cHNBM05TVFcvcUVnd0hBTDRwbXdVaGtvTUJKalprYXEz?=
 =?utf-8?B?S2s4MFM0SGl3Q3FFZ2hOR3VveVpGWlFUQndqQkZoME1mTzZUb1RteDR1L1p1?=
 =?utf-8?B?cUFTajlRRHBoMFNHcy9wWGFzT01lM3VoczROZkFwdGRJS1pGaWxhWFd5eTVu?=
 =?utf-8?B?by8yc1hlRmxCV0wrN05zK0t5VDZwRFQvTlRwSEhMbzAzZGVoaFIyL1cxTWtx?=
 =?utf-8?B?Rk0wUXRsQm94UVpmQlVWZFkydGxURS9xRWVOeVBSVitNb1MzZE1FTm51TEh4?=
 =?utf-8?B?K3JmeWZmaE1qZjd4OW1lNjJsbmpENnJUTTI4RVE0ckwxNWhYSkV0MmZseFVv?=
 =?utf-8?B?WUxhanFYVTBNRDdNSUQxNTlhQ0NrWXJ6REVPVGtsMDFmNktaYWpPRXJXSzhL?=
 =?utf-8?B?SXQvb1FiTVlYaVgwRUY5djcxMm9MUlZlWkhST0piMTE4ZVo3eEI3TFhIckVX?=
 =?utf-8?B?RGdqb2hXbm9rNjBiT3RNSmR1Zm0zbWt0VVVoK1d1SlkwL05wS3JmUmJsbFN6?=
 =?utf-8?B?U3Y5TjVrdFBFV05Lb1FqUE5YMHAvbXZHa0xGckx4akNoTXZRQ2Z4Z0l0Vm5L?=
 =?utf-8?B?SXFOaldGbnlNb0V4ck0vakgxeXRvaTJPWEl2RzRSSjROLzcrSWg1azF3NnpO?=
 =?utf-8?B?b3ljNyt0NGlrQXByd3hLYVFVZTllOStXVFpMM0JRdVpuUVlKbXE2ZkN5aHhV?=
 =?utf-8?B?QXlBWTg4cjFXNjU2b0JhUDRZbEp4WDhwcXlvQ0E4dkFrTy9ZL29XOXU5WFpm?=
 =?utf-8?B?WlpNZ2h0b1lVTER0QzF5ZkxUOVcxbFZNbHZyWHh3b0E3S2kwZEFtRHdrWHoz?=
 =?utf-8?B?MFdtVExXZEZzODczY1pBcEhhNEpQYVJ1ajZIaW95L0h3ZlRpYkdTTUVXUlB1?=
 =?utf-8?B?RVdITkhYRGJvTUsxMW9keG4vRFI4WWt3VDVkb0RodmNKK2NhUFZicDBoYzlu?=
 =?utf-8?B?UnFKeEF2TnZzUHd4b2pNYkNKMkdWb052QWVVVVZiMkFCQlQ0MUxzNUlHOGdG?=
 =?utf-8?B?NHZtODRNUjF0TEZPVmdNR1dTRUdSMEFaVjFnem1abG82ZVBJZFVOUWxnbWRh?=
 =?utf-8?B?MlkvYUtYUVdIOXp2NURqa0hmS1NBZmVoSGVxT29YVUt6enFtL0Y1emxBdTNq?=
 =?utf-8?B?M0ZSMHhMdmxJVnNBc1FTajJjMGxIK0hJNFZkOW5ZWXlsZE1HRjZRWGUrT0gw?=
 =?utf-8?B?MFVrVVQ5aTYxaFIySVlZcXlXK2o1TUlXUzgyc05HenRwRXNtNjRtQ0dwa3Mx?=
 =?utf-8?B?NDVuS0NRNkxmSVNNeEhLbkxEdWE0RVllNkI2bTNza3lHWWQyTFdJTFNXcUVy?=
 =?utf-8?B?TFlTdUpheThkdjhrNXBZRHM5VFk4c0U4akZaWVF5d0FaODdQRGRsWmJMU00x?=
 =?utf-8?B?YVFxalE4V1ZDVHdabVVTOGcxUXo4NXBrS1dyalh3UlVnSkRhZFNIUXorQmpo?=
 =?utf-8?B?VzBiV0RiRlVXRTRKdmVqaWxoRXdEZlhHVm5ybkQvdlpYYlh2Uno5dHhyYVZI?=
 =?utf-8?B?cW9qUEcxNnlCL2g5RmZOdjlXTUlZb3N1a2MwUnhCWFBNRXhoMXdHSnluZGtW?=
 =?utf-8?B?VW9LTlllTmVhSzVpa0pZTXJZODRyUW5iMWUwMmljUmxHd2pWZGdzVC8xYnd6?=
 =?utf-8?B?ZWQ0M21CUHlLMEhtZFkrRC9YbXhRL1l1MEM0Z1R4T2hCVElvWERIZFJOSVRZ?=
 =?utf-8?B?SXB1U3cvU2FpMXY0aFRxZ0RORXVDcEN5UlZpMHVhOXZkMlRYdjdkMHg4aDVp?=
 =?utf-8?B?MVlpMExMZUpYQVFPaXUyaTV5RXpIUjZkaUhvNjYxSEtvWFhrM0pwWG0vSGQ0?=
 =?utf-8?B?di9kc2RiYVliWG42Q0tpQmRqYVc3RmR6Q1NHS3pvYnQvZi95QWpWRzY1d2Fy?=
 =?utf-8?B?VjN1TmV2U1ByZXVUbDBTYllha2FtQmtjNjNBNlNjR01OVHdXVWsrS2tjZFBL?=
 =?utf-8?B?Ui9udXRIN3dNU0l1N2Rta0tKekgraVZ4RGNpMGFJeU9mZlV3MjlEaVNPNkZW?=
 =?utf-8?B?c3hSTGdKZE5SdE9WWi84WHdDdWsrMWZyajJrV2tiQ0dDNFIvNWpPY0t1NjRi?=
 =?utf-8?B?dWJZbjVrSGRMRUprVkh4VVVLZEN3bkhUL20rMGJrWURyQ29RWExZT3BQdlZ6?=
 =?utf-8?Q?F5lEdIV2DPWo/vhXnEPv7jIgj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda98da-2f33-421a-0354-08db5e9b6f3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 10:16:28.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQxR9Uekp6xY4PF3zWsVezu3NfRTwiD0zJgzmRARLuYAWNN/QXAoSUi6TiIoii6byPUrBGqpcQmeNmEkc09Qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 10:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11663

On 22.05.23 14:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The file sw-description is generated from a template and requires
> the TARGET_IMAGE_UUID. Therefore the image_uuid needs to be generated
> before the template is evaluated.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - move task order from image_uuid to swupdate.bbclass
>  - adapt commit message
> 
>  classes/swupdate.bbclass | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 9a4d509..af9d12a 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -46,6 +46,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_VERSION \
>      SWU_NAME"
>  
> +# TARGET_IMAGE_UUID needs to be generated before completing the template
> +addtask do_transform_template after do_generate_image_uuid
> +
>  python(){
>      # create SWU_HW_COMPAT_NODE based on list of supported hw
>      hw_compat = d.getVar('SWU_HW_COMPAT')

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


