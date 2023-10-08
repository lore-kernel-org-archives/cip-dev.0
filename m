Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8159E95A82
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 10:18:28 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.59])
 by mx.groups.io with SMTP id smtpd.web11.35337.1696760305128916584
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 03:18:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yaTRKiT6;
 spf=pass (domain: siemens.com, ip: 40.107.22.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDuKU+p5fz0U3QwLa1EQAWZ1Hlw69+EPULFA7b2edpVignDGL0cuO861yoLID8W6em/lvEN6RUQI9N93N595ab6IcUTfPCrbQTVjcttB1RVfEU1iYBhbBZtU/gs4X0KIPtaluTn6aG8iWKo7GYW6azW4AhDB3JJElldbocPbF5lVT/RZuVaGCEas+6qWZxtm8VAG0pduatQlBMbFLP/ZrpVZUppnsH6js/PNhIx5isERQizXsBEdnWRpwN23ANVgfEtV2Bsy4dqnTdxjEVHgjEb9J0W34NTwUpkJgoxaRBf3ltIs4gA2nplkknonFhDLaePf4sFQxf25VuQR2cvkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SezqUWWvbZQ5XOmVa1ugNnaFTljm2b4Ov7HXNi0x54k=;
 b=OimpL/3YZd7S2C6JHf6+TIi/TllmkaJvmJSiZurEH0App2CkSJi/oaugKQiXJEUQurNM4EaOPbaWW6oXAAa77AXc4dPdlzr1tMnhEkgez784GgMIsjMY7LdC6dV2643/3gaNEmMlMBH6whqtwhMzo0PWo44lT9/tkRNO3UcwgomIY7xFxC2VhMFX9NgzAodJ3ZD7UaicV9DuETxjDd61jVPKXhhNeCwXPKCQAzDLIZMbGWH3zgbUVprlniSVaS2NxRg9JiTJ5jpSyS8tIOoOfyU8VqJ6wk7C0p/C/1/wg4JZ0Jn4IbXLeSfb/qYMuKSOUCsdpTtmWzsVuO99b8VDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SezqUWWvbZQ5XOmVa1ugNnaFTljm2b4Ov7HXNi0x54k=;
 b=yaTRKiT6QywB4ga2Z2jZAu6ADPMiDicB/NqgJkw5dVBW4Ox8Hb8EBDpTlT/SbJ8UCIHJzm8zXVR0moRl21TKduB1wqzbcMdpJE0iJrkKwilO1WAzF5iObFfrl7skaEnCHzUfLDMVZpoAK2zeYMXkgwK6NoRCHjQ1zJesLJawgpf0Wvy3msJy5+3SQC7I5f2B+PzzRFQTnURxzbmxTuoUMcBDrwTZ3ED3G9WLowl9tVMTkWY/6wkqZkSm4029Z4V57jP7SQ5+NQ8EQRcUT9Qey/9PDuHp1AJbf/1isdjZISjvcvI7a3hsdRr6hUiEDNoV4VxDLiyMOjtOvGPyuDdI1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 10:18:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Sun, 8 Oct 2023
 10:18:21 +0000
Message-ID: <7941a31b-121d-4f44-b815-2f494294ff9d@siemens.com>
Date: Sun, 8 Oct 2023 12:18:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with
 schroot imaging
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
 <20231008031529.1338834-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231008031529.1338834-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: f35e3831-76ea-4cce-53ce-08dbc7e7e5f1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MlEUiog/zfibQ9rMpgwJajKtbLPSMyGtgH3+aTxT46DWu8b3QcLfv+Ov1TPJIs1PjeW9W7Yu44mz+ZArjZOtJojxdQsSpG/r1rUR2KLZIAMRzhkVDPCPMCqQNUw9bqsuXbp1zut6vwlGDu1gROPWow9xkZd3uMwwT0ztuN7oZC+lTArNKj8lZKIHG/JEUmUw/QgA2xPjmE4tI/MiOXB07XianpN03xPOwMDk1HX8bvxMUM0vqOA9XoJzJBb/UoG5eqsoQMYQP2iei5L7C8Fhmi1J6jfllXanAptaAVwq/JnGezhWHG1s4JsfrErkgzryt+lho23/r/fJ0aRbDVFpwKjaKkIx+QEq4luhbjHifqi+/bxArPdx+lGxg3+lPhwTGNOdgJTKmm2GeAdHgpoTOm+Jn243Mq3qJOwG1dpM0VLV/55yk8zxaMue/iy9BsGub3AXi9fTGhCoET9WqcROoOKFHeGd1TwMQ060s4UMroZq2furJzVmKSkXf5yEbL0PJJ9SiNfzKvOkCmZpCIPUkuTt8yiaeBFL3MEUy+kigCh26R8VbcRgXnoI9+vKjpVYTQ2c2S8fwFrat+tEB5IVrjtUZPcbIsoTQQebDv8NbFKxLErBFnOdmWoeuvUF6T+8mfpH1l3uhtuGmGmNNfOezw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(44832011)(86362001)(5660300002)(8936002)(8676002)(31696002)(4326008)(2906002)(36756003)(41300700001)(82960400001)(53546011)(6512007)(83380400001)(2616005)(26005)(107886003)(478600001)(6486002)(6506007)(38100700002)(31686004)(66476007)(66946007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1dkOVFlMUdySjZLOEE0YnZSU3NkZmlZVWR3bXJSN1hnYmhZOVV1UjFlWlZI?=
 =?utf-8?B?cWhaNUNMZVRpd1kvOWh3ZnJkRVF2V1h5dWo3QUNjU1VjV0NwUEhUaWRENmZB?=
 =?utf-8?B?MlZSYVpZSnhoMDE5UzZ1N2NkK1QyeEw2NmhZY29ETDA4N2FlQ0xuS2o2WFUy?=
 =?utf-8?B?SUFqZzEvVzhLcDNSQTBuZGFqaUJJSEpNajlYNFFzbHRjcTdiM1ZNcFNjK0pv?=
 =?utf-8?B?Q0ZYcGFPc2VSYXFFTFZTSVFKaFB2WjFuT2tjQ3liMm1GUkVIM0JwQjUwWGZZ?=
 =?utf-8?B?N3YwdUR1NTNxQ0V1dW9CakJndXFNWWNxZElKSWJoSEFqVDZSZlJrU3gzSGVB?=
 =?utf-8?B?TW5seUlBWTd0SVdUVHJ3QVdFTEdORDlQdG9nZHRFUG9aVGplMnNJV3EyTFdq?=
 =?utf-8?B?SVpBYThqcGxYazhSSmFMbWFzOXQxNnZtdUhXQ0FianlxaVpTUExXdysxbjNj?=
 =?utf-8?B?UzBialZJTGVNNmJTRWRWUm5tUG1EK3o2ZTNmdzJnNkNGcmFDdWtVblBMWmZS?=
 =?utf-8?B?YlQ5QTV5SVhaR0JDd0pnNFVtdVM4OXVRYU5LcGRRRW1lVXIrS1NuZGpkSDJS?=
 =?utf-8?B?dFRkcFJ5c0wrNWx3WjlBRDZPMzE4YXIzZ3V2OThnVlRDUXAzYmJzaDNqZzUz?=
 =?utf-8?B?WUFJYW40VG1zeFJneDBRcDYyRmN4N1NQUFRoZWVmeCtSbVZOUWlxRGdRK1Nw?=
 =?utf-8?B?b1ZlUk82bTdPL2xJTkJxVlJCVnViVWhyNStPQWZIZnlEWGJWV2pZbVVkMnNl?=
 =?utf-8?B?VDE3Y1VJVm1VMThLSnVMSS9KZkJnZVVOTkhXQXJEb2U1VVdjV1BPQzRCWnpw?=
 =?utf-8?B?d3FxbkNKVW45WVpPYlRqUDF0dDJ0akJHNXBsT2J5Q25YWUxzV2M3aGVhKzc5?=
 =?utf-8?B?akdrR0RqaHJva25UYnBNL0xpdGIrbU9lb3RVek9qVlVVSFVUaHdOQjVGWjRi?=
 =?utf-8?B?VWVqRHZaRzI5eE1ucWhkQjNZa3Y0L2IzbXN5N3VGVm5HNlFUd1p4WGZSWU5P?=
 =?utf-8?B?bHdzcjh3QWRYRGZxWnkyd0lYSkpxRi84dHAwS25IOWx0WmE4V3NZM3Z1MXFp?=
 =?utf-8?B?S3AwK0VIZ1dpcnRxVXdSRG95V014VFloeFZQdzlHYWpBRzJhaUM3YXNkZnRS?=
 =?utf-8?B?aXlhblVWN0pDYzBTa2czR1hsdE96MFlkdnJTajhESXhrbHd4cGtuVDRpL3NV?=
 =?utf-8?B?NnJGclZDdlY5T3A5WWszbzduVkNNUXBDRzY2QXlLK1V2Y1E0eGdqVnhxWkZ2?=
 =?utf-8?B?cXdXSVNVYXAzeThDUTRFZU9IYXF3cmQ0QW5EUjMzRUxoK2xVUVcxKy9jbXVo?=
 =?utf-8?B?T2JjalcrRkl5azdtcU5NbzdtMkUrOStPaG9vc3p4ZFJNbUQzQlV5VHdabTIx?=
 =?utf-8?B?RTdFcTEwOVdNWTZuV29pWTJma283d3JJMTM0U2tmY0l3elVmVFJOS1hsMThL?=
 =?utf-8?B?TmlpVG5kbXlrdlBnSUw3azAxT29FTXl6dHI5TDVCNWV2a2NlVHBXNWJWMkZD?=
 =?utf-8?B?NjJ4NHpLMGJiYU5CMndadVZqT1RMN1JXT2xoRGwyRXZ4ZEs2SGMrQjMrMjh0?=
 =?utf-8?B?cDd1amlzUGt6Mml1TGdQemFvcGViYjZseW9HMm9BczFZK2JYNXJVSW1PZjZU?=
 =?utf-8?B?eWRpTjErMDg4Y0VXTzZJcHU2VFhOQUdrSHVuQ0V5bTV6RklHOEV1cUUzNm5N?=
 =?utf-8?B?eTM3QnJ1UVpyZHFjU2pSR0MvNHhheWVrcU5mV2hQRWtaYmo3MU1pL0ROUEJm?=
 =?utf-8?B?VlBHdFlJaTZKMXRPQU9zVFArSTRFRHdORXNCUkxZODdyVW9YY1pPS1VDL0la?=
 =?utf-8?B?Z0FHSW1GZ2NJa3JuR0YzSjEvWXN5cmlOQjRrdW1DbmR5VW1PaUMxNEk3Ulhw?=
 =?utf-8?B?bFIxQm01N21UTC9STXZha2tpVVZhb2lsKzA4MkszOUpsZUtFb1R5VGEwTUR4?=
 =?utf-8?B?VU0rdCtseDlMWEljSUt0MEZRY1BnU2xJYUNNVVZkdzl5VnZ2dFl3SExCVEZw?=
 =?utf-8?B?N2FxZTEzQWU1ZWk5TzMzM1hTaFFmOUlsNWd2cEVsSDh4ZjZHZndoQ3dEbGtR?=
 =?utf-8?B?ZWs3TCsvMnN5MUlaZHNkMHBRcmZMVjVtTGF5SVIrVzZwWi84RGpCWVRuUGxy?=
 =?utf-8?Q?j5Wp5BqBmpgsLXGBzUtbqU7SM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35e3831-76ea-4cce-53ce-08dbc7e7e5f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:18:21.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu2cHCPf5Wpzoi2f0gG/4cPEzBvqx90yS14SWAKfR7vE0SoLydxKO5zrE9+LoeJdHWiFnVqM5shjbHHyB9UZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 10:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13305

On 08.10.23 05:15, Felix Moessbauer wrote:
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/images/deploy-ovmf.inc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
> index 0ec8762..cdab118 100644
> --- a/recipes-core/images/deploy-ovmf.inc
> +++ b/recipes-core/images/deploy-ovmf.inc
> @@ -11,11 +11,15 @@
>  # This recipe deploys the OVMF binaries to run the image in QEMU
>  # Note: x86 only
>  
> -IMAGER_INSTALL += "ovmf"
> +INSTALL_deploy_ovmf_binaries += "ovmf"
>  
> +do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
>  do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
> +do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
>  do_deploy_ovmf_binaries() {
> -    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd ${DEPLOY_DIR_IMAGE}/OVMF
> +    imager_run -p -d ${PP_WORK} -- <<'EOIMAGER'
> +        cp -v /usr/share/OVMF/*.fd ${PP_DEPLOY}/OVMF/
> +EOIMAGER

Single command, no need for the EOIMAGER trick here.

>  }
> +addtask deploy_ovmf_binaries before do_image
>  
> -addtask deploy_ovmf_binaries after do_install_imager_deps before do_image

Jan

-- 
Siemens AG, Technology
Linux Expert Center


