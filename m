Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E7C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 12:05:52 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.71])
 by mx.groups.io with SMTP id smtpd.web12.18508.1667477136952894337
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 05:05:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ocSmfPye;
 spf=pass (domain: siemens.com, ip: 40.107.14.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwPd22Rt194Jw6sMEpyKAhZiUn4YZKk5w6Vrjt8knznU8RoxEETKqzMwSp9v/BljFTnbv3NIQqOiJZieUQncqm7O/vBd324GRrimiLA8bMe0y35MWC/asTA62uesH/bC97m4d0Z9JpczTxSuD2EbonxkHTzYjxBfXhX0IIgR6LagY0+mKefoNCFTKSAu0rxx8iVH3IDOj3CBN4VLkslV0XUb944c60mrXnJjazsy9BJIcawBN1gI8a2H0Of+jlrY3rT8c6WLt4iDrDf6A0pUFw7oWS8T3YND8/Oid5m8+l1SzRvFbPbAndUOyQcceEAsiWp2gLXLflY/lZXnLrRqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv40Lp59uCS2jF+CJEM9tYF7d59tZeO9fvuQWuNYas4=;
 b=ALP6CTCJwKXyX0w/DD7f+QlO/UTZNmwkm2nYOolJyc7BBvV93vzWdle/ANGf8VuJAdZ1nE3YC2oFKcOo0S7oeO1KRKAARy5vDG1/hNkn1bYptiO4pehNwx919Rc8Wq93w++om1SfPNWM6iI9v7hMbmdaeLH3wpnKy9n/rBrTBBtcghULXXdOciqj49S+JJWo57zSUpkmTzLq1PjOllfzPniVfM+N/IpFhGk4IEHlWnOHLLFF/7Ma0BcDvTxR8ir7ER2rn3LwAiif2bM8Im/dng4Z1hN6oUbSjac7h5DldyC8S/X5TVQpyculewgwNbh7Q4pjaOtAxjL51pOUKeX/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv40Lp59uCS2jF+CJEM9tYF7d59tZeO9fvuQWuNYas4=;
 b=ocSmfPyeubZK8ooIsmPsQIVIho767qZkyQrMwiYRusOgi0phhJZrl3Yph0YD6iheJOJjPBzFV/zOz2PUozqeo6lMT5ljWdYeMPRRpzvoApAMVRs1hiZdj26q90Js98c/O2Ci3y2NU88NJXz6kg7wanoxKJmSL5cXX20pf+D0m7RS0m/u34hTdxlMFsf0fVz5XIeU4vOV5uj08UU72BuKuewOMAWubyZucNPHhacpoc6CTzvp2BzS0eZcN2VynAJYBHajNARgoZaE4Er07Mdwr1KTCmQdfSv3rQLG1J7iY7IlfI0asfIMmi+DOTn3X2T7c8qhFRtyTzjGRcqq8IHtow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:513::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 3 Nov
 2022 12:05:33 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7%9]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 12:05:33 +0000
Message-ID: <c9b84313-1390-7a82-e986-a2bcb96b9f5f@siemens.com>
Date: Thu, 3 Nov 2022 13:05:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH] add sha256 fields for sw-description.tmpl
Content-Language: en-US
To: peng_qiuming@163.com, cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com, quirin.gylstorff@siemens.com,
 qiuming.peng@siemens.com
References: <20221103075401.16462-1-peng_qiuming@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221103075401.16462-1-peng_qiuming@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0653adb4-01d5-4e26-3b98-08dabd93b5cc
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nV339qT7MGtStmWaEuaQgfwR3xIRbWsT2JrJ/5npzjgdkgTnSUVXaiideiTWgqyPjco+iZylgft2KfDPoDb6tjM4TX60bIUX2ZyEMjCUKLPLBu+niAOcR3zwEUt/rYaNJ8PKl4lVRNM2IBs+8mpZDazEdUfqOq8I84ChJgaxFhtqeDb3gc01yqQ4PVWGj+KLNyLRyF3J3MQTj1QJ7pmJN4IcB6oswTCKN0aIr4ELg8jpkiC+aztYquSeFYYQwyuckwZRiVIKIUP5RdW3Sizi+IGizvZBsOtyDa6sfmlCaPaLqGIVyLGBH5ZH7XxzDKIQ4w34OowmuAfeNPtKWhCkUMFC5LGXMELnksfU5lJv05PObKw7LzzAv5gXbFgJI+D7Cut6V7vZOWLw7kppGIQCEpH6wXMaEFwVrbAgkf3r0gP4CmcqDXDQoKsC3H6zZXaZ0IH+rkNKvnr91vImbK2OUqzD3NWjbdrOGa0lx0Innshh12ysYJwXBmDEieE1OP1r/mi2YaFbWDTPpED5rDEsSOEqqs483adATD81TFi48sjbP4oEQI8q3DNRVIDlY5dzF7dJo8Ev9DK6xJxSsNUsjW9ApdpURsVzeKab5nHEshzdTpyf1LySLNW8M9Evp6CbnyNHE5ujf58hIOKr6vCoYJWCnW7MihtuFjn0Pov8kPobnPwsUjf8/yzs40rN9y0aw1e+gl+9Dtg+hp7M8x7gvF89HLZM+3TA6tp+Jgjg3Tt6Nr0E266qmi5YfVVPmjPvZFcap95OMhcqqdLa3n32q1zmQaOcUh6qTNdoSPndkDs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(8676002)(38100700002)(66946007)(66476007)(66556008)(41300700001)(316002)(2906002)(8936002)(82960400001)(5660300002)(6506007)(107886003)(44832011)(6512007)(186003)(26005)(2616005)(53546011)(6486002)(83380400001)(31696002)(4326008)(86362001)(31686004)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2RyUkIyUmdMdmo3VW83S0R2cEF4MEZvTFprTmgrdXBielYzL1o4MEZLYWxw?=
 =?utf-8?B?a29QY1pIMkFJWjI4emJDVXlhM2NBNldUTkk4Tmp0bFBQaC9XVE9Rcm9MNHZN?=
 =?utf-8?B?dG5GRGl0aG1YZWlxcTdSWjgycDRkQzJYZWhZa1ZaUzE4dDZYL0E3YkNrZWRM?=
 =?utf-8?B?VXVXQTlIakxRNkZ6R01lZitPdVp0UWtrRnFGNm9kRFoxZC8yY0dqUG11M3By?=
 =?utf-8?B?Z0ptRTlvU3ZvazgwaGIvRE5xandwY1pNcjFJSThybW85aWZTaDVxZjF1bjJD?=
 =?utf-8?B?UFVhSUdJYXkxaGRnYS93YTRQWDlCMTFlWkcwc2RUbmRPWllBWFZrVjN4dWpt?=
 =?utf-8?B?cDdhMDBDSjJiN04vS0lwaEQvYm1ROTY1cWM1RnY2TE9uUVpJbzZvYkRzaDVm?=
 =?utf-8?B?OEVvK2hIcWY5R1orQ2txUS9mQUZPMlRwZ2ZEZTRwK2lwUHBQaHgrNzlGTGNB?=
 =?utf-8?B?WUxkbEdGVzVZQmhPTG1jR1pCNE9NemI3Z1RrcXZLVUVNbGVwR2FRbkU5cmdh?=
 =?utf-8?B?YjdEeW1YUWdoTUVFZkxGc3hlUGI3S2Qvb2hnMEtBSWpZdFJ3TFBncmNQWWtZ?=
 =?utf-8?B?by9ydUd2eWVpTk5PMGNwbFFKMUV2Wmw4ek5udGI3Q0V6V3EvcmpMdXQ4Rzcx?=
 =?utf-8?B?b1hvUDBNWWdsY0NpTTNHM1VZS0Z3N2RTM256eUNxd3hUbVdxOGNuL2hvTFFa?=
 =?utf-8?B?T2lpT3E4SlhzRW82ckhibTlVbVE1YTZOT3NpcGRpaytRcFJNMFlwcy9RL2lw?=
 =?utf-8?B?K0NLWkJBYlFtZ1dXaDl3Z2ZwMDNja0JiWHAwMkFJWE84dkhTcHVpN2xqMXA0?=
 =?utf-8?B?NGppU2hLLytVWWxySnNBRVVIeFA5WTVha3VRdFdoM1Vzd2drU2I5MGhRU1RY?=
 =?utf-8?B?T3l4K0d5SGhET1RrVnUyN3h4UExuNkhNbjRVaDlRVHVSK0R4WExWU0kwYnZq?=
 =?utf-8?B?OEZ4MkhtYmNnSFpWcVNjMEFxY2ZRUjNqcXRqakFwVUtTT1RyM1dSdXJObUVp?=
 =?utf-8?B?U09aajlYL0w5bjRwTWd0M2ZkVnQrV0VuamlVQXB3emRFbDdyOHdickNHeUlG?=
 =?utf-8?B?N2svclhiclVGQXVBaXYxSWV6ZUVVK1BtdXVDRnZlWS9YOUFxdFRranl6b0x1?=
 =?utf-8?B?SjdjZFdmVnZlb1VMRXZ4aG0wZDBLcER3NmNGb0FlRTlKSkJlRzA4dW1aRlNV?=
 =?utf-8?B?b0pDdlBOQ29rNjlBNTUwSjJ4eGZpUUVKREQxUlF5M0VtWHFPdGRwYUlhY1Uv?=
 =?utf-8?B?emtFSDBjRWZ1cHpHa0pLNWpSdGFZOWZPZzhPRzFPdEtkUms5ejhIY2czUXZH?=
 =?utf-8?B?SzFRQkN1U1VmbERDcGpROXJYM0ZjZ3hvRUF1Z05tNkFCeEtJMVRqY3lQRnpV?=
 =?utf-8?B?ZmlqczFxQTlQc3B6T20ycXFVVklhL3pGLzBEWHIreTBvVjFycGpMbVZBN0Vp?=
 =?utf-8?B?UmhwNEhsdzNFMWgrN2RIMGRzSlI0NEVtY0dJLzRaZE9lTHZXOVpJSnlSeE45?=
 =?utf-8?B?Yi9QNVdQUTN5Z0U2dDlWWnJXSlZuTi9SZmNncnd1MzdqUXBMYnB3TytLcDdl?=
 =?utf-8?B?czZyVnNWVW42VGNKbjVxdlhvNFNvZGhhQVR6MUM5V1JhNlhDNnFaRzNKNFJh?=
 =?utf-8?B?clVlVVlYZ2xJbHBKQ2E2OVd2SGttNmVZbFdQTUwvNkg3ZVJZVkdjd2dkenZw?=
 =?utf-8?B?NndTRkNEdVd1czBqdGlja2tjQk84UkJwTnF0OGZNKzNYWUYrZFdzZStZZ2t4?=
 =?utf-8?B?cnZSK3RJQUhmRCtNZ3pEZjI3ZzFsalhUcFJ5bmFyTWJncnFQck5ReEFMVmdN?=
 =?utf-8?B?V256TVFTSC9Bc2U0bnZncS9ZZFR4K1hBcSs3ZGU0eVIzcWZQWndvUU13U1gr?=
 =?utf-8?B?aGl2OEdHaTBDSStBZjRQTzZpNlZzTTZDc0k1K2FrajJwZVYrNnhEVjVFOGhL?=
 =?utf-8?B?ajhDVFU4d2FuYlllZTliajZZZnFsaTl3N2orNDJhM01BRkhuVUhpcFdKK3lr?=
 =?utf-8?B?RGMvVzJSVitlSkVrS2pHTVhFS0Z4WTZvU0o1UTU0T3UvMFFJZHpMbXYxdUZ3?=
 =?utf-8?B?QWU5VERRSytyL1dCWDg1ZXNORU1Ic2x0TlRzaitqdHVOUHRGVjVRZ1hvK1pY?=
 =?utf-8?B?LzlaeXpnTmp6R05GbDluZHM0aTV6WXErK2VnQVBmTXdRRUJVcEVlL000VFdh?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653adb4-01d5-4e26-3b98-08dabd93b5cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 12:05:33.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAgxos6JJ2RF7goLLec21rlaYKiaTX94tqNIay33ar+Rz6An4+6x3vZ2WatVLScUhIGm81OO+Y2QxepgaZMxqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 12:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9914

On 03.11.22 08:54, peng_qiuming@163.com wrote:
> From: Peng Qiu Ming <peng_qiuming@163.com>
> 
> isar-cip-core provides signature function in swupdate.bbclass file to support sign swu image,
> but there are no such fields named "sha256" in sw-description.tmpl file to support that, this
> patch will fix this issue.
> 
> Signed-off-by: Peng Qiu Ming <peng_qiuming@163.com>

While you can perfectly send your patches via a personal address (or
have to - we know the reasons), please keep your official affiliation as
From: and Signed-off-by: in the text above, ie. use your siemens.com
address there.

> ---
>  recipes-core/images/files/sw-description.tmpl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f5cafeb..1c0db02 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -21,6 +21,7 @@ software =
>              properties: {
>                          subtype = "image";
>              };
> +            sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
>      });
>      files: ({
>              filename = "linux.efi";
> @@ -31,5 +32,6 @@ software =
>              properties: {
>                          subtype = "kernel";
>              };
> +            sha256 = "linux.efi-sha256";
>      });
>  }

Patch is fine otherwise.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


