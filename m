Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D282DC001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:01:25 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.79])
 by mx.groups.io with SMTP id smtpd.web10.14460.1691665278962814512
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aBB9oE5i;
 spf=pass (domain: siemens.com, ip: 40.107.247.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeLh17MTQOCWaYnf7BeKcKZRT2dJhrACfhNVFEzyj8fAJGjsHCCnrTjOwG1potqQZEfYinjin7lvTJTExJTZ2CeJLyHzfBTg8Mok7hA8z0uR0gyh+JyRKnbHYV6KUD6EtfQFK2KIRj7/Usyq5cSoTLgcDOD2hdre6F+KfSQjB2Y+Zj1LwPWq3k2kBT5qk4cnb4RfiAXFCu70LwRvHgVL8gBQFQ+349MxQpRnwSPaCPVbvD/pdI58JfkPY2pedDp08FSE0aIdmIxZvXtxMvXoOKO99nqB4qeAipJ4aUGuyQhpBdbED+l1Iiei0ToXaQG3ro7mxVdbufzPmpRf82XZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf5/oTAHlbaLDcprPxltmBur6zypF/fSjVp5fAqgF/I=;
 b=cCukg8vhve6/qFKYN3dXxdP5JnKmereoxFkoCHWSAmREkkFdWyTkIw+MI/yTZ2C7e88LkOlqz6ncIrL022f3cCa9tEMih06jgK/OAkXpW+z/U3b7y3LeBtR6MHq6wejLLtJJyT7baCbSFrPrjt5MhA0RR+TKdButNOMSYXzsxMxVJmFXoQW0Va3gooZO6zcq0LJf2quyXW4F6784156PXHuLjqm5T4pENS+BSUOU+lpQCdBKuFC3BpFqg9BT26T9cpLroYR+Acl+KBguAx2CIXUvh/aYj2L2YUovYGeKPGO2AOna1yPxw3jfCxXpchGlY9lgNX0W+oinbktlY/FP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf5/oTAHlbaLDcprPxltmBur6zypF/fSjVp5fAqgF/I=;
 b=aBB9oE5i7xp79Ju5HYHW6uUW+uZA7rhVJjDmd8db2zmECyzkzNhdG50vBUGQhtAxAgbQ4HuSU1XkA7dx4iBKyJm/OxVdje7RMtzPsccAwkrdiwD/3sYEp/dJSyK5vxnD87D1/SFxwplBDndQKAnHnUxlgIWnEQ9zLezzKilFKuUrEdZJqLj/Y3R3tEmEZRj4dnXJf9VDnCdTxMKYinh8xLH+WWYhUmJ26u2ubCccIvTlff6w7+rYNKPOKEuhHmRTEhMZMV4c/5dbqkRs3c2O4isxxszDJGcA4IZkQO2oLidMWNLcOrFeY+STalrrUpu9/9AbpwJv7scflherhWTDMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:01:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:01:15 +0000
Message-ID: <674bbcf8-8246-4faf-b80b-f5f672315492@siemens.com>
Date: Thu, 10 Aug 2023 13:01:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate-handler: Add default
 config to fix u-boot build
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: caa1e47d-ad74-4f44-2c93-08db99911e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TaLG7siUzftQd8YTS6lETiHM+zMNs34BOrNSddaYUNQbj47PEkqiwNLtBXf6eXDagvoKpQ3G9aSOHA022HSKw0TFyXuCp42bIvdWvxywA0EW+iDnPZc0osCPkThNda6Hm3wTggCZu+QnFZdAs/F2dXBIJgY2xP3wo9WOrJdfvEcze9QWa0zOdrcZ7acoCz21EZ0xxtGQXyWKFBS4BgeRLZIVT+gxqIjx2GjbxCSpjSlVYUXiLPaaKal3aq9c0u6MrNj9A50ruIu2rjI8PXqApf7mvhL5txCEH5AV/8KxB1A8+tu2K+yN/Bh1rZPwkegIsaQVULXG56fstp6aNnsA9+dxTysuMYqmrwsvWl/zkiHBSC7DIH5a1Rhk5unMO4okaHvNWtanzzKddQ5o9bxL0BB1yPIWaN0M0YARKBQx889q1dvwm5slkRemclPYlqbKd61QAlzoD+Wqr+krv1WCDwljt2pFI/95wR3YI9V7+8VmFUzQadZovKsnT7F7xi3jXez+lvY6Kre+x30zgx4VD98ntbf3myO8TmRHgO23rZqzZfw9zczeFxt9nlraKAiyyTl1m1ggBdzfSQ+Tk8nrQ4MWIratIc2HwYkeH9l1OdDWiPmaQxW9SUglI63WDQoOp7xiM726q3meIT/fVCyPmQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(1800799006)(186006)(31696002)(6506007)(53546011)(26005)(478600001)(86362001)(82960400001)(83380400001)(6486002)(36756003)(6512007)(2616005)(66946007)(66556008)(66476007)(44832011)(316002)(2906002)(8676002)(8936002)(41300700001)(31686004)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWF1QmNycytBR2NRdXlyOG5zSnJDSHV3b09JK29OejZKZ2hiWDgzdS9YLzgx?=
 =?utf-8?B?c0UvUkJXemh4R3ZDbU9TVG1ER1pTLy85MWo1bEgvT1Vpcnk4MEJWU25pdnVw?=
 =?utf-8?B?YTNmTGc0amtnTWprV0tZRUlLSVZDSGsxUXcwZXZaSHRtY2h4S0ZoajNCYkM5?=
 =?utf-8?B?WThMUm9TMlZoeDV0RUhoMWlpZzJnbGpQUmM3OU50NGdLbW5OamZndGRWZ2cv?=
 =?utf-8?B?cFY3U3o5SDJ4RmxBRHNGQWVkc1ZJRzhjenJKT0s4ajYzbDZYK2lXVFVqMmht?=
 =?utf-8?B?dGlLYjROdDVac1ltcEt0S0dhWFo0UmJCYXRWSTN6dWlXNDVkcWQwRTJONEpu?=
 =?utf-8?B?VVlHOVBwZVJEN0d1b3NSazYrMm9XQitDcGoxZEh0dzJ1TTdkaGQxcHhtQjZN?=
 =?utf-8?B?elhpV2YreVZ4WkgweEFLcjB6d29xWGFhY3BWVU1NQjRvMjY3NWJMT05TS3F2?=
 =?utf-8?B?MzFoZmovak9pcGVlN3doOWNiVUJSNXVNZHZYb2owdVc2cEFFYis0Ull1WTFU?=
 =?utf-8?B?QXlrWHZ4WDkvT2pvZytqTEY3RGQ4OFdvUU41cFB6bGxJeHJJT3pScmlxU25H?=
 =?utf-8?B?R2RpMUJoYllaSitneHJVWUhFQlI1WHhMRkZuODZNWWwzZ3hpWGtUNFJSS0RZ?=
 =?utf-8?B?QmYwU25saEcwN0g2ZHQ0UHplWUhweCtpWFpmVkh3OWdXT0NUQjBYTDZxb280?=
 =?utf-8?B?Z1dkRmRJSkF3RG5oQ0ZQZ2JIOUpESVRqOE91QWJuMUhvVVlaaHdDMnlzaU14?=
 =?utf-8?B?RDBZVXNsSTlaK1BqL2lyOHhjSDVmdXNWVnRYenA4T2YrRGxkQVhnNUFQVmVW?=
 =?utf-8?B?bDZmSVdtUGZtTVROWTh1RU85K2JuTlRrUDdxTTAxVWdvdmhZM3dBTzZmNmE3?=
 =?utf-8?B?Q3VUYUpxd3JjdWxoVGk5QVlROG5qeUt0K3FFQzcvRHBKQXMwZGhvcjVYNUhI?=
 =?utf-8?B?UDFDNm4wYjZLN0I4M1hFbEZJWDYrbjZkUHdlLzNGZXRXMTZQK3FaSm84Yjly?=
 =?utf-8?B?ZXdlak1JcHFZMjNDMTYyS2kvWUVHazZGVlVuV2dJRHBFcitWVm8vTnlVTVNG?=
 =?utf-8?B?Y0FLcXBXSytoakpLdjV2R0ExTFVhTi9BWG9kQjFhZ1h2VTJieGZMVGVienh6?=
 =?utf-8?B?b2Y2MTlhTzdldW4wR1dVMDZ4NEljOC91SEhnUjNOVWJqVTAzRzl3TUFpREhx?=
 =?utf-8?B?RkpITlpxckFUaFVyN2VYL094Wmx2cWt2aEw0RkxpQkRDZ21WSXdXL1hNWWhp?=
 =?utf-8?B?d0pBcUNzRTVLaW1rc3k0b21RUUJpTnUvSWZ4MjlCT2YyajRMS3BTOG5MMCs1?=
 =?utf-8?B?ZHZoWTIxNjB4SkdEYnBWZkhtcFl6QzArNW9WcHFJUVVpb0JHNHhDcmh6T0p5?=
 =?utf-8?B?Z0JvWDZwMnJMV3FmVU9iZldOdCs5WUZPY3ExakpxWkJqL0l1NDVtNUpWV1Az?=
 =?utf-8?B?RTkzWThyby9KMTJFbmloVUdhV3V2cUZGbkhXQUJ3SFJvQzYxZTlZeFZCVXA2?=
 =?utf-8?B?VG0rQ0lGdVZNUUY5d3ErTE8yWFZpdFFYOEIyZVlKWDJRN0haUXI4L2R5cWU5?=
 =?utf-8?B?cHZDSGczYkxIZGJYWXA2R2YwR3d5ek9RYTBGSVJxc2pJZTRTem9Sbzhod2hZ?=
 =?utf-8?B?RHRQUmduVitlOTVDMkNjczRvNHJIdnJMdEY2OG11bHg0eEtGcmJDdDlRQUlT?=
 =?utf-8?B?SVFjcHdETDluOHRvcTA4UzFlWG1hTlFIZmJMRVpzeGhhUitFWkZndVNKeE9T?=
 =?utf-8?B?eENPVEV0alBBaldKUFpXYUxOck9hb1BzVTg5T1hldEkrY25ER3RQdFdOb2Mx?=
 =?utf-8?B?T1plNEhOZFNNcXRlR0VIODdFQWdCQUNWL2NrZzlhbHNESE1ZTXFDZUp4VVVl?=
 =?utf-8?B?Q1JjVWt1R0NqMTB2UUpZK21nd0dvRFhiN2lyd1hPVXRhT1NnZXV3WFFEeUhO?=
 =?utf-8?B?TTlJaWJaR0NTNUJ1cW5XRUNhUTdIbjJoa1FRWUdhbE03Q1dMRDFMbWlaZUZv?=
 =?utf-8?B?MW5nNkRUQnpXOGFFQjViaDRIL0dMTWxMWFdmVkZQZHRza0VoaDBBVVY4MmpM?=
 =?utf-8?B?SW5HUm8xUHBsTlpGUXR2TDJSMEduMXZGV0NuKzlheTEvQnFhZXFUL1VOejRB?=
 =?utf-8?B?czlMYlZ5M0w1Njd3NjlRNVdvS25SUStjTEhISDJwbUdUOGhzSmhseFJpVERE?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa1e47d-ad74-4f44-2c93-08db99911e03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:01:15.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqU6YvXAw5kClYu+rFIi8GcnO9hAn6+ok85zVgZ55EZAHZrG5PX2ix0hw215iK1L3HLfzvFiklDWpq4tKsrNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:01:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12596

On 03.08.23 12:24, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds the missing configuration file to allow to build with u-boot
> as the boot selector.
> 
> It uses the getroot mechanism from SWUpdate to select the update
> partition.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> CC: felix.moessbauer@siemens.com
> TO: jan.kiszka@siemens.com
> 
>  .../files/swupdate.handler.u-boot.ini                  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
> new file mode 100644
> index 0000000..0e6df08
> --- /dev/null
> +++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
> @@ -0,0 +1,10 @@
> +[image]
> +chainhandler=raw
> +
> +[image.selector]
> +method=getroot_rrmap
> +[kernel]
> +chainhandler=rawfile
> +
> +[kernel.selector]
> +method=getroot_rrmap

This is not being stressed by isar-cip-core, is it? Do we plan to add a
target that uses legacy u-boot script-based a/b switching?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


