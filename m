Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC67C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 17:22:13 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.58])
 by mx.groups.io with SMTP id smtpd.web10.46768.1707931331864978140
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 09:22:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dHkPS4v2;
 spf=pass (domain: siemens.com, ip: 40.107.105.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCu4TIR/9CODjRFaALKb1JzW4WB5Q76sJswukL3oMBDkDL55Pbp8j5+n4EPDXhWqFvZ1g01/h11A6lfr2214a20gAuZGhFpI9c56imxyiGCmSTkmoHSNhh4leWiKWRqZwJ5e4+OSeGe1TLjW7b8wVf32k9nQ4Bc7gqU3OBsMVRsL+HNQfcEAu5rt8AXvdzCGiXwY+lMxtkNdKwhxjvi7ko3Vm28/+vcvqYOE4ABDwFPKHpDlMDBbONMPxLCS+DxzYAwpR5umMQU06M9YLKKKVOpyVgmfF6HULBGz4Uh25tDq8B88sc6pv3a9LdOuH5TDNuhtV7nBVNQ97pE8lUsyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAD4dhazL0QRU/beuLgpK/qKieqgQaKAwwJV4EGGyhE=;
 b=UA/3h/oDNxWDPkEMYU2v/1e2i3zmEcVCIWvbHU8hUSicCeaYMKMakiJQT2+QFsuZklrsEbXiIf9i9JguENO56q1GdBF8TzhZ5yQrbJgHRBJ4OLwFVRexf3kKvPfrJYz/l29gANcfD94natZyCP086Pn1j/rjOwPevEnv5Jp+kMGufspuaohI3tbeFEzg5eTF1uwNplEGLb1byGlyrAJMF8jy2H9dGZKl75VzurKoNx2+yxYyoPisSjILZWTT6Mu9i5rQ1BPZnWy5aZZuQWLByuuR+CwaBgFCZotcZQEgrFV4jQrc2YmhUZP2gTh3FWo2MfsvKUNxxN/ltZaAZHe1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAD4dhazL0QRU/beuLgpK/qKieqgQaKAwwJV4EGGyhE=;
 b=dHkPS4v2x0f9pfcS7r39392O5G4VIcxSBK68s1YoN9KstANmCyKo2zlISTVCKSKVsKc3UQJ+7v7qLlX8K1acaoK6fcV4nRAqkd6+GAZ1AdBndEv/p7anqGXuoi0FmABCr9BlYxcpoxQfesDVdo7SRyqNOmOT4JhOeyZdujZcLRllUo29oWPWi8sKtXEbj9JTMoUf2hcWuDJiaQ2dzQ0GisdR+xy2hPsnc9gMpcZRHVADfbWCcwCGjycxd8lclX+0/2fHuLL9l1nkpUDnMGtI7DaRItMpFzTHaF+qatlffCRUz7qLFynKAQ7q7YoX/26wK8Z+y7yqmI4OOBEMl6IL6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 17:22:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 17:22:08 +0000
Message-ID: <2ae87a46-f5ae-470d-b8ec-4837107a63f6@siemens.com>
Date: Wed, 14 Feb 2024 18:22:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 1/2] deploy-cip-core.sh: Upload only .swu file
 for v2 QEMU security targets
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214154820.3544080-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214154820.3544080-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: e092cc0f-5d8e-4944-1abb-08dc2d817922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lk63YYQF4g81DW8d3L/OjIIBhWlghl2QDERXnHTux4m9fQWKnlEFE/AnCDxYOjIOUTUvObN4VhK0qoWEWGyfMS575Swo8Z41ivzyiBiPOWsGzZRDWVsYOnbykID1GpxMS4lUdW6cZsPj1UXiG6a0WZf82KGJc07N6H1zD+Dr0hjfX/NfbkCTfeOYbJQWRbVfmFKHdHEcvn/bQ3n+5eU4lzrZQzphk8PbCJByjW0h2pIad5xamHNk9VIRRzcObO5DMOrCZKHukndcJy17s/qN1nhxUxOFIyRb+AWru7yJV6tiJAqWa6jCHSTeNPhxub8gc/yKweco3BtmB19QNZvSAwWumB7C2INnymfxLS6inuBc/p3BBm/ahvcoTsUdP9CXW3BjknhLBJDop6/t/M0+7d7rbc8m6LU/BcIAEzFg090HpanKq9qW9m5bWmomwWRtIcuI9+nlXC3ixk02oxN+oFu946Zo/iTSEF01WJkoWPiZmqbyf8AkzXs2DF6lCBk1mZbaDvK3uj245fBiGIiAnsRy92tUjmxfg2xtFycaVFH8ekz9aWGwKSzz+hR2BD1Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(316002)(66476007)(66946007)(41300700001)(66556008)(8936002)(15650500001)(2906002)(5660300002)(4326008)(31696002)(8676002)(44832011)(36756003)(86362001)(2616005)(6512007)(6486002)(6506007)(53546011)(83380400001)(82960400001)(26005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGVqNW1EUGRWcU54NC9kUlBZaU51c1FGYkwzOWhHRTlta3d3b0lvQzBSWXVW?=
 =?utf-8?B?MXk5aW03dEsxQ0xVTEFYQ096RFl3bWtWNEU0M08vSFZSbG5VRzVwKzNvSlNX?=
 =?utf-8?B?N3RhcUl5SkE2MTVuRmliQjNJMTNPTXIyeEticXJDOTRmQTh6cVBlcTFRUHNL?=
 =?utf-8?B?V1FIUUVLNGJxbk5yYVBwNUtyVmlsZm9CRnVxNzFyWmxsODJPWjdaRHhWcThG?=
 =?utf-8?B?amVRZmFka0trWXh2YXVDVnE0ck9vMmx3dE11cStUYmpaU2wwM2JaejVCQWNj?=
 =?utf-8?B?QSs0bDBGMmtiVFFtOFFBWS9uWWRwVVdyaW9BNm1KOW53REV2UG9tclhKU0N6?=
 =?utf-8?B?TzBnVlRHdGZaOVVwb2ZCRG9RNHY0Y1ZSQTZ2NFNwdUhEUE9rd1JqQnc2azFQ?=
 =?utf-8?B?dmlkNmRMUVhsRk5vbmdPOVE3VE9LWFFsK1Y3eDVvNFZxN01GdGZONE9ndi9a?=
 =?utf-8?B?M0tRcnphOHRCL2puaDFnVUpSRHhyQnFOYVZSc1JvdktlR0xybnVzS1hGU1pG?=
 =?utf-8?B?NEdQMHBqMVhxV2tDL29ET3FiTFVaSlV6bGpkVk81elZzSi9jbThQdXhFZzJY?=
 =?utf-8?B?ayt3RDZpUXNUMmMzV0pMdHg5ZGw2eVp5cnVCNlNUODVuWTRiWkxqb1AyRk5X?=
 =?utf-8?B?eGwzakVoYi9RMndGekl1cVlLTzBuOXVJdUdUd0JyTjE3cng0RzdIcm1hR0RE?=
 =?utf-8?B?b0xvd3cvelJtbzE2QzMxVWtWV29EajRJSVJnSVh5WG1reEtsVWFBNG04TTlU?=
 =?utf-8?B?S0FHdTkxei9HUmZaQS9yenc3MjlRT3o5MXZhb3BLRjltSzBnM2xmWE90VkVO?=
 =?utf-8?B?SFB4aldNMW0zempPVlFXVUJGSVdDTUIyVE9KMTFDMzN4aHZWY0kyOTV0UGZu?=
 =?utf-8?B?WFRRRmJiYSttUkI0WTU5eUcrU25LQ3lkZEs3ZVJxbk5sMzVCdHBRWE9LZ1lP?=
 =?utf-8?B?SGtQeHN3WnhjUTF1SlVlOEM0LzFyc1phaUNwRVFnTm1ZSUJTVzRuejBwRFJt?=
 =?utf-8?B?RHhOdjJPa1Y0ZkFOWFZHbSswMVhKRlQ4ZVRDTzV1SHM1KzFSRVg1L3krbjUx?=
 =?utf-8?B?VnBOc0I1T0Z4L2lVdlkxMGl2ek9sRlpJQUh6Rm1DNjNLYi9RaE9UUVBLY1lo?=
 =?utf-8?B?TlljR1dlczRFaWJTTkNuNzE3TXNvV1Z5MmQwZVNoTk5CV2ZQangvRlhmOWs0?=
 =?utf-8?B?Nys0U2pvY1pvQngvR0F5aDI3TDB2akpxTlRuQnpmMmpkaW0vSWNrQ3o1dWpP?=
 =?utf-8?B?SVR6bGY5V21mbXZhMlM0UGROeGgvTkF3SzhlWlpmY2dUYTRZR0ova0lVcDlG?=
 =?utf-8?B?elZMMmNDRnF3d3hMZHJ3Ynkwelg0a2tEdjlMVDdvcXg2MlBDeEZHWXhkc2hL?=
 =?utf-8?B?NU9aSWRWNndGZllpemdHTGNzTzFkMEZBWDNuei9COHZJTnI4S2JOSm1BYkVv?=
 =?utf-8?B?bDNKRWo3L2lUOW5Yb216OEk3ZlZLajhnZlhIZXVYVGdHM3lYcU5SMVRXdjc2?=
 =?utf-8?B?SzE0TnZJSXA4NC9HNUwvK0J2Rjl5RTAveGZDczFqNUNhTXM5SzJmQTVvcVBh?=
 =?utf-8?B?WHVHUC8wcEN1QjFtOTBRNnRGQlZaZEdGMjJkb0J0bm03VGQ1UFhkWHBYbEJX?=
 =?utf-8?B?eERHM3JKR09sRG1LYk1Fa1UwNVNUcVEwTHRMbkUrK2lrRGIrMEJ2SnhIU3Bn?=
 =?utf-8?B?N3FwTzRRdC9GMkJZTEJQUE5YOGJpL2tQSTZJckU1cGIxU2ZNSHdCOVorTFJD?=
 =?utf-8?B?R3hKTGFhMkpYMjFyK2RYZ3hQdVdUMUY5SlErOHIzVDFOa0hrQXN2ZURCVFl0?=
 =?utf-8?B?cndSTW9kWi9SYkxUQjJaTlJtSVZuNWZBaEpsZTRmcnVjYTNqWGhzbExodFZG?=
 =?utf-8?B?QkJMOEtoOXFUY2h3eDZLdFdDOWpITXNoYWdtTHVzWDVCZXFvdElKWkFPVlBy?=
 =?utf-8?B?czlZWlhYQWJsNjVVcE5hTDhCcFN4blltM1pRa0VoUk04RFhjOVNMK2JQV0Nj?=
 =?utf-8?B?Z29ETnhuNWxkdTkxVzE4OHBxMHJTck9GWVpZL29OOExDbXRSYlZsaWIzNUJF?=
 =?utf-8?B?VmpQK3NxSm4zRHlva3M5b3hLait6WklxQldHNndlMlJ4cW9Wa1liNXpFcTJp?=
 =?utf-8?B?eE02dDgrbGp1SVZwOHVDRkhndFZDUTFRR3hDRlNqRUpBVXZpUDhSRDl3aTdI?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e092cc0f-5d8e-4944-1abb-08dc2d817922
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:22:08.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+sbDW/nlTnVQrb9N1iGQQQmzRpFwSdHUw7HMCqv23KafSH8bPNp3AQ2/CGXWKy9VfEdde9jP/g/SUn3Z2uPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 17:22:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14982

On 14.02.24 16:48, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> Currently software update testing is enabled for QEMU security targets,
> so if "USE_SWU" switch is enabled then only the .swu file is uploaded
> ignoring the v2 .wic image. Since the project directory in CI will be
> cleaned after every job, so the compressed wic file is moved to s3 bucket
> instead of copying to avoid "file exists" error in case of two consecutive
> builds in a single job.
> 
> U-boot binaries are also uploaded for usage
> when required in LAVA job definitionss.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  scripts/deploy-cip-core.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 7f6cbe9..aece4d1 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -15,6 +15,7 @@ TARGET=$2
>  EXTENSION=$3
>  DTB=$4
>  REF=$5
> +USE_SWU=$6

Naming: DEPLOY={swu|wic} would be a nicer interface IMHO.

>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -33,7 +34,17 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  	xz -9 -k -T0 "${BASE_PATH}.wic"
>  
>  	echo "Uploading artifacts..."
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
> +	# Condition check to avoid deploying v2 security image and prefer only it's .swu artifact

The deployment script should not worry about who is using it. Its
interface are the command line options. So, let's drop this comment.

> +	if [ "$USE_SWU" = "enable" ]; then
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
> +	else
> +		# Move the first wic.xz file to aws s3 bucket to avoid error while compressing v2 image
> +		aws s3 mv --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
> +	fi
> +
> +	if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
> +		aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
> +	fi
>  else
>  	if [ -f "${BASE_PATH}.tar.gz" ]; then
>  		echo "Uploading artifacts..."

Jan

-- 
Siemens AG, Technology
Linux Expert Center


