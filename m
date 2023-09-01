Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CACA0FE6
	for <webhook@archiver.kernel.org>; Fri,  1 Sep 2023 10:39:57 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.77])
 by mx.groups.io with SMTP id smtpd.web11.3435.1693564788470865785
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Sep 2023 03:39:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NkO1oaN+;
 spf=pass (domain: siemens.com, ip: 40.107.249.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKErHx1KYGntMwqukvKMM8YSbxwC5nYWxebvUGOUEKbh2IkuhcY3stVBoDJ2WtA+5hu80v9yM14VCFEQRe8jbw/YBAC5nfG9YxOBRW42iIFsWXuj0sI/dJUWPHRbmBm7fURliHpmRgoV9VEbzNiTfc/CBQHXFRvwds36r/kkUbHQ8Zvl3AggOQ4gSLakxLPneE/VhvhrggYv0pfh5Kn7EOpaoRlz63NM3Je7p4eFA1r1qVXwAW60DvarhoUPZEaYmPvr+Vhqr/nJJI2fQsieMYnjqzXrUJ2DrK03YbTpygDxmXlAPBIFTVAMpJGH20bElvdPXex2uGObS+lzJ79d7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjhZj5D/TusVFB0BrUvN3dxSwafljg1YGsJyGOxTqoA=;
 b=G06hySJyoTBAhtF1KMJHqQaI4ZQ/6Q7Ql46ZDARtAr+EhWxURlqMMfGNUo+PIXiDuxY4+cdrqzeQgFCujXCRmikK1VDELWM/Nsnxp5hjkfZSCInrOyInZBaHyiSRgFZWcTKkZ0U0D7RU2VpK0WkOW26vuibodItZgNDsqFy1WGwjtMImLFqZzQEGVOWI9QfogghOs4PMj1wiw2+n9KC0ngn+vu22qK9+adsA3piC+J8PV+JOskC05FUUNjt94is3QU6pWx+SN6NK2sJiJFiO7KtpfCOh00UYvK8jJLQqKOtYoxxidAkwmJl3Oyl3MhomDYFrM0cOeVVChUUsAjKyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjhZj5D/TusVFB0BrUvN3dxSwafljg1YGsJyGOxTqoA=;
 b=NkO1oaN+3UKT7+3z1S/8ES0icyCvP4hqWtOxXlmLa5snGuqzg1AZpBbI8Tr9xm6UOchdepMyxvmlnf/BDIDoxoxfIthpXSiwegVPdEKuCbHa4zV6G4xd956hhEbpaixo1/CcP88MJjxol7gdLV9h/n/nroTTwK00SLwa3vEcAWoYyX2Ww69t6w30TlYXLEsH+9uboSCux+GNlLuiKmIcRoCZdGaX3herAwWvrcjpFRxu9xlVfckp7Wb80qA8bgJVCjXSUIrW3FWJLYTGU5NKzCjK/vilSb/nxZF+T5UxqougXCwgPIEXtuT9vEpyau1OlI0XPVfOaGAYYtcOVmoodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 10:39:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 10:39:44 +0000
Message-ID: <a97e69f2-bb88-4075-97ca-5830251032b7@siemens.com>
Date: Fri, 1 Sep 2023 12:39:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 1/2] README_version-release-policy.md: Rectify "y"
 incremental details in metadata version
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3835:EE_
X-MS-Office365-Filtering-Correlation-Id: 00be7654-9d70-43a5-2df6-08dbaad7c195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nKnfQJd3vAYCEJL5g4zySG9rsKaqGsNw+8c99W6KkvJWX2rJgTsJTbXRSV3XS8l+GaE48gnEmOVGBU5oERFycCQLApQcMOuR+3micJW2UaYkJpieU75Y5T066ELruXy9cXQbd3WnOSvEinIBla5uYOo+o/OaXijrH67E7e7uklYDXM+pk3WMg8QewvFlqNvT61oFA+FkCaBkFa3uqdgYtlWmGkJQpoMjA1K8SCKvKnxDH6amU+l272S8BhFEeD2oJcmKZtHrWK055zuUxUDhWCUHgheZZULyVjx6/bto5tJMP51PCLBZbkiOOxAtrBNjVClDiKqRDC8t5yVq2JKtC5lSvIb/wCwrNF3TlgIlFcWbFzlDnzf3jgGkUuv0MZfx73+cWKb4XfepHWLpIMHlh7hL/zUisPcB2nUB/6M/rYpkH2dQuMpgwUr8Dtf8SycYgFDwJld3ADXxNtRSCYYaKCN7czX4KOZICozDsYlmc0CiEKpBuMFE23m8rKMO/wklcBhcfjKLdNlTxuIqBfkZvKcwRpQN+samrE/gpKdNWJDiJzUWygQab3DLn9Z1n0UOm3XoYAc7sYdMvtPTqGHxCHieFJ9Vbn2JTWy6Ghi9i0Z/FdTBqLHu/HROvGlh/5LFbVAXgut0edAQGxvYyDNHiw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(478600001)(31686004)(2616005)(38100700002)(66556008)(66476007)(53546011)(83380400001)(26005)(66946007)(6512007)(82960400001)(6506007)(6486002)(2906002)(44832011)(5660300002)(8676002)(41300700001)(316002)(36756003)(86362001)(31696002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wnc2WjJrY3dGTGRlWm1paUJtS043bStwSUJHeDBuL0VXTG14UlFuTW5udHNx?=
 =?utf-8?B?K3BOdTcxZzhDVG5iazhOSVhMaGZJWkZUYklqakFicmRITjFxb2xBSWZCTC94?=
 =?utf-8?B?eXNGSVdtSUtXOWw4OWkrRXNvUGgxaURVQVdYVVBNRXZPT2k1UkthUi9icHJk?=
 =?utf-8?B?aXVjQ0hzTmZOK3d6MGlzTno0NkV0VkRyNFpqWXZBazNRWHA3VTJLaW0wQllo?=
 =?utf-8?B?dUk0blA3NjhGNXVUdmJYeVpwWDl6L3BSTzdINXlwbGRMVG1PQjJBYUNsWm5r?=
 =?utf-8?B?MnVPcFhNVHM3cEhPUlh4VTZwbkdxdUpWaURnbGJ6dUxHUFRuRHhjNUhQeERQ?=
 =?utf-8?B?NzdNLzdTc3dvTkZTT3pWb0sxaHgxbGdPS3M5V1FxN3k3bTk3U3crZmowU3Q5?=
 =?utf-8?B?ODVDbEZRWnlRVDJNRFV5RDlFRTlCdWRBcXdFUFN0M004S0t0MEQvd2k1Zi9m?=
 =?utf-8?B?bkZtUTV5eG5aWWptaTNxaXZvbG1BeGowemhmMm5qV0ZNMG5idU04dmlwUEVz?=
 =?utf-8?B?YmJQNmFudE5hazlwR1lqaThCVnVxRzMrdGNXakxwaGphYzdkcEZwQ0l6cjVQ?=
 =?utf-8?B?eElodlZXd21WNGVGL0RaV3phZ2dIam1Ub2xUelYvQ1EwM0ZraTE1RWQ1OW95?=
 =?utf-8?B?UkZSNnBBU1gzdU0xaCtzeGdjKy8zcUtwKzFVbm9GazJCNy9XelRPMEZnQUF3?=
 =?utf-8?B?bUlPK2IrOEw3ZVg1UVJSUmd5TUdVYUpoMVZ6SmtUVk4vWGZJODlGZ0p2cytr?=
 =?utf-8?B?NUZDa1NpWHVQU2hpbHFlc2ZXbFVoem9PdmZOa3h0eFFmbkwraGx0dlJaL3U5?=
 =?utf-8?B?RU1kREZYVlJKOFA1ck1vUHlmUWx1eVExOWtKdTBlOGxYRENYMzMvdE5pNlpt?=
 =?utf-8?B?VGVacTh1UDM2WHRQbkxEMkphR05MeEp5SE9CaDNKb1BNdWd2Q0ZwS08zRXc2?=
 =?utf-8?B?ZHM3NGkyd3dqUnl6SSt4bUxOWGdrQjdESGpMTmJyRFRtNXZiZkh2UmpPK3g3?=
 =?utf-8?B?RnNrOEFUY3gvaHFtVlhyb2tpNXA2d2xYY09JWWNkbjdRUWNNaDR0SVo5TENK?=
 =?utf-8?B?NDJLVDV2WnhIanprZGZCU0VicmFwQ1VsUTY1TDNCelh1SkNxMTNxKzVLdTZ3?=
 =?utf-8?B?QTBaUE9TZXJ3THkvaGw5eVFzMG8raGhRd0ZJSE1DTWE3UmgyWlpjYUFuc1N1?=
 =?utf-8?B?ZEhyZFliTU01eHAwTXBHY3hoOE9UMTYzWStWeEUwYUtCaE5Rb3ZPSklaTEVu?=
 =?utf-8?B?OXlMb0lHWVBCMERzUUdXVkE1Y2NZUk1HNjJQbW9vdW1hK3dlQ2VReTloaW5W?=
 =?utf-8?B?UmpxT2lwdU5yaURITlFmZDdqVEtlYmgyU01Vb2RYei8xSE1GUjRWNGZnU0t5?=
 =?utf-8?B?Y2NUTWJ2VVh3dDRGSUlGZG9WMGRlTktDb2RNa3JPVXBCMzhwQ29iL3IvNm52?=
 =?utf-8?B?MUdmdDAwNk0rNWNtMHBmODBJcS9idEN5Um5wMmFnYndhczVuWEtUc0VHM1dK?=
 =?utf-8?B?Z2MvZE1ZOVIzaTgvZWpGRDRQSVdSVUk2SWJuM2dXV2hYVy8vcnNtS0JWSWxD?=
 =?utf-8?B?OExvTkRJTkhmbG05MU9aajlhNUN0QkdKNE45S0d6VlJsUFdEdTVReWRVT2dE?=
 =?utf-8?B?WXJqR25RNU5PSXpmdEZyUmlFTnJXQjBHSDNraHlpMnlUTXpzTFBzekRFNThk?=
 =?utf-8?B?WGJ0b1dWb3J5STg4RWswaDQ2TDVUTWNocis5VnV6Y09CZTJIUXhJN2xnYUxs?=
 =?utf-8?B?L05Kenk5Z3AzZ0U0LzU0Q2t4TCtvT2k4WHVxamRjcTVRNzFLQkwyZDE5OElz?=
 =?utf-8?B?eEFkQkY0a3o0NER0NDBlY2ZudnBxVTFVeHk3Q0hJWjVETkVwVFZSTFBCZ0xS?=
 =?utf-8?B?dVNieVlVSkJMTmliMTU4WmpPbjNEcGIyK0hnMExCTEdxZUIxS0dicVY5ZlhF?=
 =?utf-8?B?S2R5RUJXcWt0aVdkYXF3WmhDK3ZaTFJTTHl3eGVUS1BzUkQveERXR0ovRFNz?=
 =?utf-8?B?NGJSVVI1WG5zQnJCT3NQKzU1dTVFRCtWVS9mZHZXTEFDMGUycFBydCtzN2tB?=
 =?utf-8?B?SEc5bWdsR0FBZEhxK3RSN3lleEVkVzUwdTNUb0Naay82Z0lUOXVrVUJoNWN5?=
 =?utf-8?B?K2F4VjBveG0rS3JCdmY4ZXZlVEpadkpHaHhUWTNwVkxHcVpzVEhpcHFLYUQ5?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00be7654-9d70-43a5-2df6-08dbaad7c195
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 10:39:44.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkjwEhLedIQHiZvAdG3J7dt3+iXF47r5UMmBF2XQUWnpeUaTDbBDAU+/yxH+GuMiOViZXCoY+6itzqKRIKm24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Sep 2023 10:39:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12935

On 01.09.23 10:19, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> isar-cip-core regular releases are not triggered by Debian point releases. Details
> regarding what the regular releases consist of are also added.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README_version-release-policy.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/README_version-release-policy.md b/doc/README_version-release-policy.md
> index b0b8591..918e77a 100644
> --- a/doc/README_version-release-policy.md
> +++ b/doc/README_version-release-policy.md
> @@ -16,7 +16,7 @@ The isar-cip-core metadata follows semantic versioning system i.e **x.y.z** form
>  1. **z** is incremented only when critical bugs are fixed. If **z** is zero, it will be left out.
>      * For example, if the latest release version is **2.2.5**, then the upcoming release version after fixing some critical bugs will be **2.2.6**.
>  
> -2. **y** is incremented for each Debian point release or in case of isar-cip-core regular release. When **y** is incremented, **z** is reset to 0.
> +2. **y** is incremented in case of isar-cip-core regular release. When **y** is incremented, **z** is reset to 0. Regular releases include modifications in recipes, addition of new features, bringing changes when updates are announced in CIP Kernel and Debian releases.
>      * Let us assume that the latest release version is **2.1.1**, then the upcoming regular release version will be **2.2**.
>  
>  3. **x** is incremented when significant changes are done other than **y** and **z**.

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


